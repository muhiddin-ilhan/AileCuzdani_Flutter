import 'dart:io';

import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/authenticate_text_card.dart';
import 'package:aile_cuzdani/view/auth/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/components/custom_textbox.dart';
import '../../../core/components/custom_tooltip.dart';
import '../../../core/components/popups/message_popup.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/components/app_logo.dart';
import '../../../core/components/authentication_background_shape.dart';
import '../../../core/components/authentication_tabs.dart';
import '../../../core/components/custom_material_button.dart';
import '../../../core/extensions/validation_extension.dart';
import '../../../core/utils/navigate_utils.dart';
import '../../../core/utils/sizer_utils.dart';
import '../forgot_password/forgot_password_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginViewModel viewModel = LoginViewModel();

  onBackPress(BuildContext context) {
    if (!viewModel.loading) {
      showMessagePopup(
        context,
        title: "Uygulamayı Kapat",
        message: "Uygulama Kapatılsın mı?",
        onAccessTitle: "Evet",
        onAcceptTap: () {
          exit(0);
        },
        onRejectTitle: "İptal",
        onRejectTap: () {},
      );
    }
  }

  void initState(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.setLoading(true);
      viewModel.getSharedUserInfos().then((_) {
        viewModel.setEmailError(!viewModel.emailController.text.emailValidation());
        viewModel.setPasswordError(!viewModel.passwordController.text.passwordValidation());
        viewModel.setLoading(false);
      });
    });
  }

  void dispose(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      initState: initState,
      dispose: dispose,
      onPageBuilder: (_) => WillPopScope(
        onWillPop: () async {
          onBackPress(context);
          return false;
        },
        child: Scaffold(
          backgroundColor: CustomColors.DARK_WHITE,
          body: SingleChildScrollView(
            child: SizedBox(
              height: Sizer.getHeight(context),
              child: Stack(
                children: [
                  authenticationBackgroundShape(context),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      appLogo(
                        height: Sizer.getHeight(context) * 0.5,
                        width: Sizer.getWidth(context) * 0.4,
                        textSize: 38,
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Stack(
                            children: [
                              card(context),
                              Observer(builder: (_) {
                                return authenticationTabs(context: context, index: 0, isLoading: viewModel.loading);
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget card(BuildContext context) {
    return Observer(builder: (_) {
      return authenticateTextCard(
        context,
        child: [
          const Divider(height: 20, color: Colors.transparent),
          customTextbox(
            context,
            borderRadius: 12,
            prefixIcon: const Icon(Icons.mail),
            inputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            fontSize: 14,
            labelText: 'Email',
            autoCorrect: false,
            controller: viewModel.emailController,
            enabled: !viewModel.loading,
            suffixIcon: viewModel.emailController.text.isNotEmpty && viewModel.emailError != null
                ? customTooltip(
                    message: "Geçerli bir email adresi girmeniz gerekmektedir", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
                : null,
            maxLength: 50,
            onChanged: (text) {
              viewModel.setEmailError(!text.emailValidation());
            },
            height: Sizer.getHeight(context) * 0.055,
          ),
          Divider(height: Sizer.getHeight(context) * 0.015, color: Colors.transparent),
          customTextbox(
            context,
            borderRadius: 12,
            prefixIcon: const Icon(Icons.vpn_key),
            fontSize: 14,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (value) {
              viewModel.login(context);
            },
            labelText: 'Şifre',
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                passwordShowIcon(),
                viewModel.passwordController.text.isNotEmpty && viewModel.passwordError != null
                    ? customTooltip(
                        message: "Şifreniz en az 8, en fazla 16 karakter olmalı ve en az 1 büyük harf, 1 küçük harf ve 1 adet rakam içermelidir",
                        child: const IconButton(
                          icon: Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN),
                          onPressed: null,
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(width: 6),
              ],
            ),
            obsecureText: viewModel.showPassword,
            autoCorrect: false,
            enabled: !viewModel.loading,
            maxLength: 20,
            controller: viewModel.passwordController,
            onChanged: (text) {
              viewModel.setPasswordError(!text.passwordValidation());
            },
            height: Sizer.getHeight(context) * 0.055,
          ),
          Divider(height: Sizer.getHeight(context) * 0.025, color: Colors.transparent),
          buttons(context),
        ],
      );
    });
  }

  Widget passwordShowIcon() {
    return Observer(builder: (_) {
      return IconButton(
        onPressed: () {
          viewModel.toggleShowPassword();
        },
        icon: Icon(viewModel.showPassword ? Icons.visibility_off : Icons.visibility),
      );
    });
  }

  Widget buttons(BuildContext context) {
    return Observer(builder: (_) {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: customMaterialButton(
              context: context,
              isLoading: viewModel.loading,
              enableLoadingAnim: false,
              onTap: () {
                NavigateUtils.pushAndRemoveUntil(context, page: ForgotPasswordView());
              },
              child: const Icon(Icons.key, color: CustomColors.WHITE),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: customMaterialButton(
              text: "Giriş Yap",
              context: context,
              isLoading: viewModel.loading,
              enabled: viewModel.emailError == null && viewModel.passwordError == null,
              onTap: () {
                viewModel.login(context);
              },
            ),
          ),
        ],
      );
    });
  }
}
