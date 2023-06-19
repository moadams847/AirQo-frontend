import 'package:animations/animations.dart';
import 'package:app/blocs/blocs.dart';
import 'package:app/constants/config.dart';
import 'package:app/models/models.dart';
import 'package:app/screens/profile/profile_view.dart';
import 'package:app/screens/settings/update_screen.dart';
import 'package:app/services/services.dart';
import 'package:app/themes/theme.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/custom_widgets.dart';
import 'package:app/widgets/dialogs.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dashboard/dashboard_view.dart';
import 'for_you_page.dart';
import 'map/map_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? _exitTime;
  int _selectedIndex = 0;
  late bool refresh;
  late GlobalKey _homeShowcaseKey;
  late GlobalKey _mapShowcaseKey;
  late GlobalKey _profileShowcaseKey;
  late BuildContext _showcaseContext;
  final AppService _appService = AppService();
  late List<Widget> _widgetOptions;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.appBodyColor,
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: PageTransitionSwitcher(
          transitionBuilder: (
            Widget child,
            Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: IndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: CustomColors.appBodyColor,
          primaryColor: CustomColors.appColorBlack,
          textTheme: Theme.of(context).textTheme.copyWith(
                bodySmall: TextStyle(
                  color: CustomColors.appColorBlack,
                ),
              ),
        ),
        child: ShowCaseWidget(
          onFinish: () async {
            final prefs = await SharedPreferences.getInstance();
            if (prefs.getBool(Config.restartTourShowcase) == true) {
              Future.delayed(
                Duration.zero,
                () => _appService.navigateShowcaseToScreen(
                  context,
                  const ForYouPage(),
                ),
              );
            }
          },
          builder: Builder(
            builder: (context) {
              _showcaseContext = context;

              return BottomNavigationBar(
                selectedIconTheme: Theme.of(context)
                    .iconTheme
                    .copyWith(color: CustomColors.appColorBlue, opacity: 0.3),
                unselectedIconTheme: Theme.of(context)
                    .iconTheme
                    .copyWith(color: CustomColors.appColorBlack, opacity: 0.3),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: CustomShowcaseWidget(
                      customize: ShowcaseOptions.up,
                      showcaseKey: _homeShowcaseKey,
                      description: 'Explore air quality here',
                      child: BottomNavIcon(
                        selectedIndex: _selectedIndex,
                        icon: Icons.home_rounded,
                        label: 'Home',
                        index: 0,
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: CustomShowcaseWidget(
                      customize: ShowcaseOptions.up,
                      showcaseKey: _mapShowcaseKey,
                      descriptionWidth: screenSize.width * 0.3,
                      descriptionHeight: screenSize.height * 0.09,
                      description: 'See readings from our monitors here',
                      child: BottomNavIcon(
                        icon: Icons.location_on_rounded,
                        selectedIndex: _selectedIndex,
                        label: 'AirQo Map',
                        index: 1,
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        CustomShowcaseWidget(
                          customize: ShowcaseOptions.up,
                          showcaseKey: _profileShowcaseKey,
                          descriptionHeight: screenSize.height * 0.13,
                          descriptionWidth: screenSize.width * 0.23,
                          description:
                              'Change your preferences and settings here',
                          child: BottomNavIcon(
                            icon: Icons.person_rounded,
                            selectedIndex: _selectedIndex,
                            label: 'Profile',
                            index: 2,
                          ),
                        ),
                        BlocBuilder<NotificationBloc, List<AppNotification>>(
                          builder: (context, state) {
                            return Positioned(
                              right: 0.0,
                              child: Container(
                                height: 4,
                                width: 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: state.filterUnRead().isEmpty
                                      ? Colors.transparent
                                      : CustomColors.aqiRed,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    label: '',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: CustomColors.appColorBlue,
                unselectedItemColor:
                    CustomColors.appColorBlack.withOpacity(0.3),
                elevation: 0.0,
                backgroundColor: CustomColors.appBodyColor,
                onTap: _onItemTapped,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 10,
                unselectedFontSize: 10,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _initialize() async {
    context.read<DashboardBloc>().add(const RefreshDashboard());
    context.read<MapBloc>().add(const InitializeMapState());
    context.read<KyaBloc>().add(const SyncKya());
    context.read<LocationHistoryBloc>().add(const SyncLocationHistory());
    context.read<FavouritePlaceBloc>().add(const SyncFavouritePlaces());
    context.read<NotificationBloc>().add(const SyncNotifications());
    await checkNetworkConnection(
      context,
      notifyUser: true,
    );
    await _initializeDynamicLinks();
    await SharedPreferencesHelper.updateOnBoardingPage(OnBoardingPage.home);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (context.read<DashboardBloc>().state.checkForUpdates) {
        await AppService().latestVersion().then((version) async {
          if (version != null && mounted) {
            await canLaunchUrl(version.url).then((bool result) async {
              await openUpdateScreen(context, version);
            });
          }
        });
      }
    });
  }

  Future<void> _initializeDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen((linkData) async {
      BuildContext? navigatorBuildContext = navigatorKey.currentContext;
      if (navigatorBuildContext != null) {
        await ShareService.navigateToSharedFeature(
          linkData: linkData,
          context: navigatorBuildContext,
        );
      }
    }).onError((error) async {
      await logException(error, null);
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();
    _homeShowcaseKey = GlobalKey();
    _mapShowcaseKey = GlobalKey();
    _profileShowcaseKey = GlobalKey();
    _widgetOptions = <Widget>[
      ShowCaseWidget(
        onFinish: _startShowcase,
        enableAutoScroll: true,
        builder: Builder(builder: (context) => const DashboardView()),
      ),
      const MapView(),
      const ProfileView(),
    ];
  }

  Future<bool> _onWillPop() {
    final currentPage = _selectedIndex;

    if (currentPage != 0) {
      setState(() => _selectedIndex = 0);

      return Future.value(false);
    }

    final now = DateTime.now();

    if (_exitTime == null ||
        now.difference(_exitTime!) > const Duration(seconds: 2)) {
      _exitTime = now;

      showSnackBar(
        context,
        'Tap again to exit !',
      );

      return Future.value(false);
    }

    return Future.value(true);
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        context.read<DashboardBloc>().add(
              const RefreshDashboard(scrollToTop: true),
            );
        break;
      case 1:
        context.read<MapBloc>().add(const InitializeMapState());
        break;
      case 2:
        context.read<ProfileBloc>().add(const SyncProfile());
        break;
    }
  }

  void _startShowcase() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(_showcaseContext).startShowCase(
        [
          _homeShowcaseKey,
          _mapShowcaseKey,
          _profileShowcaseKey,
        ],
      );
    });
  }
}
