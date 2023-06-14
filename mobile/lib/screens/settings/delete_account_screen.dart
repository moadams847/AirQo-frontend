import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:app/themes/theme.dart';
import 'package:app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';
import '../on_boarding/on_boarding_widgets.dart';
import 'account_deletion_widgets.dart';

Future<void> openDeleteAccountScreen(
  BuildContext context, {
  EmailAuthModel? emailAuthModel,
  PhoneAuthModel? phoneAuthModel,
}) async {
  await Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          _DeleteAccountWidget(
        emailAuthModel: emailAuthModel,
        phoneAuthModel: phoneAuthModel,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
}

class _DeleteAccountWidget extends StatefulWidget {
  const _DeleteAccountWidget({
    this.emailAuthModel,
    this.phoneAuthModel,
  });
  final EmailAuthModel? emailAuthModel;
  final PhoneAuthModel? phoneAuthModel;

  @override
  State<_DeleteAccountWidget> createState() => _DeleteAccountWidgetState();
}

class _DeleteAccountWidgetState extends State<_DeleteAccountWidget> {
  final _formKey = GlobalKey<FormState>();
  String _inputCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OnBoardingTopBar(backgroundColor: Colors.white),
      body: AppSafeArea(
        horizontalPadding: 24,
        backgroundColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AccountDeletionTitle(),
            const AccountDeletionSubTitle(),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter the code';
                    }

                    if (value.length < 6) {
                      return 'Please enter all the digits';
                    }

                    if (widget.emailAuthModel != null) {
                      if (widget.emailAuthModel?.token.toString() != value) {
                        return 'Invalid code';
                      }
                    }

                    return null;
                  },
                  onChanged: (value) {
                    setState(() => _inputCode = value);
                  },
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  cursorWidth: 1,
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 16 * 0.41,
                        height: 40 / 32,
                      ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 0,
                    ),
                    filled: true,
                    counter: Offstage(),
                    errorStyle: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            NextButton(
              text: "Confirm",
              showIcon: false,
              buttonColor: _inputCode.length >= 6
                  ? CustomColors.appColorRed
                  : CustomColors.appColorRed.withOpacity(0.5),
              callBack: () async {
                FormState? formState = _formKey.currentState;
                if (formState == null) {
                  return;
                }
                if (formState.validate()) {
                  await _deleteAccount();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            NextButton(
              text: "Cancel",
              showIcon: false,
              buttonColor: CustomColors.appColorBlue,
              callBack: () async {
                await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }),
                      (r) => false,
                );
              },
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteAccount() async {
    loadingScreen(context);
    AuthCredential? authCredential;
    if (widget.emailAuthModel != null) {
      authCredential = EmailAuthProvider.credentialWithLink(
        emailLink: widget.emailAuthModel!.reAuthenticationLink,
        email: widget.emailAuthModel!.emailAddress,
      );
    } else if (widget.phoneAuthModel != null) {
      authCredential = PhoneAuthProvider.credential(
        verificationId: widget.phoneAuthModel?.verificationId ?? "",
        smsCode: _inputCode,
      );
    }

    if (authCredential == null) {
      showSnackBar(context, "Failed to delete account. Try again later");
      return;
    }

    await CustomAuth.reAuthenticate(authCredential).then((success) async {
      if (!success) {
        showSnackBar(context, "Failed to re authenticate. Try again later");
        return;
      }
      await CustomAuth.deleteAccount().then((success) async {
        if (!success) {
          showSnackBar(context, "Failed to delete account. Try again later");
        } else {
          await AppService.postSignOutActions(context).then((_) async {
            await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) {
                return const HomePage();
              }),
              (r) => false,
            );
          });
        }
      });
    }, onError: (error) {
      Navigator.pop(context);
      showSnackBar(context, error.toString());
    });
  }
}
