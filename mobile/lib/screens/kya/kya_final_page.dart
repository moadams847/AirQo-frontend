import 'package:app/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:app/themes/theme.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class KyaFinalPage extends StatefulWidget {
  const KyaFinalPage(this.kya, {super.key});
  final Kya kya;

  @override
  State<KyaFinalPage> createState() => _KyaFinalPageState();
}

class _KyaFinalPageState extends State<KyaFinalPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: CustomColors.appBodyColor,
        ),
        body: AppSafeArea(
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icon/learn_complete.svg',
                height: 133,
                width: 221,
              ),
              const SizedBox(
                height: 33.61,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Congrats!',
                  style: CustomTextStyle.headline11(context),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Text(
                  widget.kya.completionMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: CustomColors.appColorBlack.withOpacity(0.5),
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
    context.read<KyaBloc>().add(PartiallyCompleteKya(widget.kya));
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(
      const Duration(seconds: 4),
      () async {
        await popNavigation(context);
      },
    );
  }

  Future<bool> _onWillPop() {
    return Future.value(false);
  }
}
