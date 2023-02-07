import 'package:app/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:app/screens/home_page.dart';
import 'package:app/services/services.dart';
import 'package:app/themes/theme.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notifications_setup_screen.dart';
import 'on_boarding_widgets.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ProfileSetupScreenState createState() => ProfileSetupScreenState();
}

class ProfileSetupScreenState extends State<ProfileSetupScreen> {
  DateTime? _exitTime;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OnBoardingTopBar(),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: AppSafeArea(
          horizontalPadding: 24,
          verticalPadding: 10,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Great!\nPlease enter your name?',
                textAlign: TextAlign.center,
                style: CustomTextStyle.headline7(context),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                height: 48,
                child: Row(
                  children: <Widget>[
                    const TitleDropDown(),
                    const SizedBox(
                      width: 8,
                    ),
                    Form(
                      key: _formKey,
                      child: Expanded(
                        child: ProfileSetupNameInputField(
                          controller: _controller,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              BlocBuilder<ProfileBloc, ProfileState>(
                buildWhen: (previous, current) {
                  Profile? currentProfile = current.profile;
                  Profile? previousProfile = previous.profile;
                  if (currentProfile == null || previousProfile == null) {
                    return true;
                  }

                  return previousProfile.fullName() !=
                      currentProfile.fullName();
                },
                builder: (context, state) {
                  Profile? profile = state.profile;

                  if (profile == null) {
                    context.read<ProfileBloc>().add(const FetchProfile());

                    return const LoadingIcon();
                  }

                  return NextButton(
                    buttonColor: profile.fullName().isEmpty
                        ? CustomColors.appColorDisabled
                        : CustomColors.appColorBlue,
                    callBack: () async {
                      await _saveName();
                    },
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const NotificationsSetupScreen();
                    }),
                    (r) => false,
                  );
                },
                child: Text(
                  'No, thanks',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: CustomColors.appColorBlue,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    updateOnBoardingPage();
  }

  Future<bool> onWillPop() {
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

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) {
        return const HomePage();
      }),
      (r) => false,
    );

    return Future.value(false);
  }

  Future<void> _saveName() async {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(const UpdateProfile());
      FocusManager.instance.primaryFocus?.unfocus();
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return const NotificationsSetupScreen();
        }),
        (r) => true,
      );
    }
  }

  void updateOnBoardingPage() async {
    await SharedPreferencesHelper.updateOnBoardingPage(OnBoardingPage.profile);
  }
}
