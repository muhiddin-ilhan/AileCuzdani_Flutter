import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/app_logo.dart';
import 'package:aile_cuzdani/core/components/authenticate_text_card.dart';
import 'package:aile_cuzdani/core/components/authentication_background_shape.dart';
import 'package:aile_cuzdani/core/components/authentication_tabs.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/extensions/validation_extension.dart';
import 'package:aile_cuzdani/core/utils/navigate_utils.dart';
import 'package:aile_cuzdani/core/utils/sizer_utils.dart';
import 'package:aile_cuzdani/view/auth/forgot_password/forgot_password_view.dart';
import 'package:aile_cuzdani/view/auth/reset_password/reset_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/components/custom_textbox.dart';
import '../../../core/components/custom_tooltip.dart';
import '../../../core/constants/app_constants.dart';
import '../login/login_view.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key, required this.resetKey});

  final String resetKey;
  final ResetPasswordViewModel viewModel = ResetPasswordViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseView<ResetPasswordViewModel>(
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
            prefixIcon: const Icon(Icons.password),
            fontSize: 14,
            textInputAction: TextInputAction.next,
            labelText: 'Şifre',
            suffixIcon: viewModel.passwordController.text.isNotEmpty && viewModel.passwordError != null
                ? customTooltip(
                    message: "Şifreniz en az 8 karakter olmalıdır",
                    child: const IconButton(
                      icon: Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN),
                      onPressed: null,
                    ),
                  )
                : null,
            autoCorrect: false,
            enabled: !viewModel.loading,
            obsecureText: viewModel.showPassword,
            maxLength: 20,
            controller: viewModel.passwordController,
            onChanged: (text) {
              viewModel.setPasswordError(!text.passwordValidation());
              viewModel.setPasswordConfirmError(text != viewModel.passwordConfirmController.text);
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
              viewModel.resetPassword(context, resetToken: resetKey);
            },
            labelText: 'Şifre (Tekrar)',
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                passwordShowIcon(),
                if (viewModel.passwordConfirmController.text.isNotEmpty && viewModel.passwordConfirmError != null)
                  customTooltip(
                    message: "Şifreleriniz birbirleri ile aynı olmalıdır",
                    child: const IconButton(
                      icon: Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN),
                      onPressed: null,
                    ),
                  ),
                const SizedBox(width: 6),
              ],
            ),
            obsecureText: viewModel.showPassword,
            autoCorrect: false,
            enabled: !viewModel.loading,
            maxLength: 20,
            controller: viewModel.passwordConfirmController,
            onChanged: (text) {
              viewModel.setPasswordConfirmError(text != viewModel.passwordController.text);
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
              enabled: viewModel.passwordError == null && viewModel.passwordConfirmError == null,
              onTap: () {
                viewModel.resetPassword(context, resetToken: resetKey);
              },
              text: "Sıfırla",
            ),
          ),
        ],
      );
    });
  }
}
