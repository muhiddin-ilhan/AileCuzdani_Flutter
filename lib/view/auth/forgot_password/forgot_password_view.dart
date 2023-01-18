import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/app_logo.dart';
import 'package:aile_cuzdani/core/components/authenticate_text_card.dart';
import 'package:aile_cuzdani/core/components/authentication_background_shape.dart';
import 'package:aile_cuzdani/core/components/authentication_tabs.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/extensions/validation_extension.dart';
import 'package:aile_cuzdani/core/utils/navigate_utils.dart';
import 'package:aile_cuzdani/core/utils/sizer_utils.dart';
import 'package:aile_cuzdani/view/auth/forgot_password/forgot_password_view_model.dart';
import 'package:aile_cuzdani/view/auth/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/components/custom_textbox.dart';
import '../../../core/components/custom_tooltip.dart';
import '../../../core/constants/app_constants.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final ForgotPasswordViewModel viewModel = ForgotPasswordViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewModel>(
      onPageBuilder: (context) => WillPopScope(
        onWillPop: () async {
          if (!viewModel.loading) {
            await NavigateUtils.pushAndRemoveUntil(context, page: LoginView());
          }
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
                      Observer(builder: (_) {
                        return appLogo(
                          height: viewModel.isValidationCodeShow ? Sizer.getHeight(context) * 0.5 : Sizer.getHeight(context) * 0.55,
                          width: Sizer.getWidth(context) * 0.4,
                          textSize: 38,
                        );
                      }),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Stack(
                            children: [
                              card(context),
                              Observer(builder: (_) {
                                return authenticationTabs(context: context, isLoading: viewModel.loading);
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
            textInputAction: TextInputAction.done,
            fontSize: 14,
            labelText: 'Email',
            autoCorrect: false,
            controller: viewModel.emailController,
            enabled: !viewModel.loading && !viewModel.isValidationCodeShow,
            onFieldSubmitted: (value) {
              viewModel.sendEmailCode(context);
            },
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
          if (viewModel.isValidationCodeShow) Divider(height: Sizer.getHeight(context) * 0.015, color: Colors.transparent),
          if (viewModel.isValidationCodeShow)
            customTextbox(
              context,
              borderRadius: 12,
              prefixIcon: const Icon(Icons.key),
              inputType: TextInputType.text,
              textInputAction: TextInputAction.done,
              fontSize: 14,
              labelText: 'Doğrulama Kodu',
              autoCorrect: false,
              controller: viewModel.confirmCodeController,
              enabled: !viewModel.loading,
              suffixIcon: viewModel.confirmCodeController.text.isNotEmpty && viewModel.confirmError != null
                  ? customTooltip(
                      message: "Gireceğiniz kod 6 haneli olmalı, boşluk ve özel karakter içermemelidir",
                      child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
                  : null,
              maxLength: 6,
              onChanged: (text) {
                viewModel.setConfirmError(!text.confirmationCodeValidation());
              },
              onFieldSubmitted: (value) {
                viewModel.sendConfirmationCode(context);
              },
              height: Sizer.getHeight(context) * 0.055,
            ),
          Divider(height: Sizer.getHeight(context) * 0.025, color: Colors.transparent),
          buttons(context),
        ],
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
                NavigateUtils.pushAndRemoveUntil(context, page: LoginView());
              },
              child: const Icon(
                Icons.arrow_back,
                color: CustomColors.WHITE,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: customMaterialButton(
              context: context,
              isLoading: viewModel.loading,
              enabled: viewModel.isValidationCodeShow ? viewModel.confirmError == null : viewModel.emailError == null,
              onTap: () {
                if (viewModel.isValidationCodeShow) {
                  viewModel.sendConfirmationCode(context);
                } else {
                  viewModel.sendEmailCode(context);
                }
              },
              text: viewModel.isValidationCodeShow ? "Tamamla" : "Gönder",
            ),
          ),
        ],
      );
    });
  }
}
