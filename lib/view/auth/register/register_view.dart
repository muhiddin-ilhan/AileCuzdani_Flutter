import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/app_logo.dart';
import 'package:aile_cuzdani/core/components/authenticate_text_card.dart';
import 'package:aile_cuzdani/core/components/authentication_background_shape.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/extensions/validation_extension.dart';
import 'package:aile_cuzdani/core/utils/navigate_utils.dart';
import 'package:aile_cuzdani/core/utils/sizer_utils.dart';
import 'package:aile_cuzdani/view/auth/login/login_view.dart';
import 'package:aile_cuzdani/view/auth/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/components/authentication_tabs.dart';
import '../../../core/components/custom_textbox.dart';
import '../../../core/components/custom_tooltip.dart';
import '../../../core/constants/app_constants.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final RegisterViewModel viewModel = RegisterViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      onPageBuilder: (_) => WillPopScope(
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
                        height: Sizer.getHeight(context) * 0.42,
                        width: Sizer.getWidth(context) * 0.2,
                        textSize: 28,
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Stack(
                            children: [
                              registerCard(context),
                              Observer(builder: (_) {
                                return authenticationTabs(context: context, index: 1, isLoading: viewModel.loading);
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

  Widget registerCard(BuildContext context) {
    return Observer(builder: (_) {
      return authenticateTextCard(
        context,
        child: [
          const Divider(height: 20, color: Colors.transparent),
          customTextbox(
            context,
            borderRadius: 12,
            prefixIcon: const Icon(Icons.person),
            inputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            fontSize: 14,
            labelText: 'İsim',
            autoCorrect: false,
            enabled: !viewModel.loading,
            maxLength: 50,
            controller: viewModel.nameController,
            suffixIcon: viewModel.nameController.text.isNotEmpty && viewModel.nameError != null
                ? customTooltip(
                    message: "Doğru bir isim yanlızca harf ve boşluk içerebilir ve en fazla 20 karakter olabilir, lütfen geçerli bir isim giriniz",
                    child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN),
                  )
                : null,
            onChanged: (text) {
              viewModel.setNameError(!text.alphabeticValidation());
            },
            height: Sizer.getHeight(context) * 0.052,
          ),
          Divider(height: Sizer.getHeight(context) * 0.015, color: Colors.transparent),
          customTextbox(
            context,
            borderRadius: 12,
            prefixIcon: const Icon(Icons.person),
            inputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            fontSize: 14,
            labelText: 'Soyisim',
            autoCorrect: false,
            enabled: !viewModel.loading,
            maxLength: 50,
            controller: viewModel.surnameController,
            suffixIcon: viewModel.surnameController.text.isNotEmpty && viewModel.surnameError != null
                ? customTooltip(
                    message: "Doğru bir soyisim yanlızca harf ve boşluk içerebilir ve en fazla 20 karakter olabilir, lütfen geçerli bir isim giriniz",
                    child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN),
                  )
                : null,
            onChanged: (text) {
              viewModel.setSurnameError(!text.alphabeticValidation());
            },
            height: Sizer.getHeight(context) * 0.052,
          ),
          Divider(height: Sizer.getHeight(context) * 0.015, color: Colors.transparent),
          customTextbox(
            context,
            borderRadius: 12,
            prefixIcon: const Icon(Icons.mail),
            inputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            fontSize: 14,
            labelText: 'Email',
            autoCorrect: false,
            enabled: !viewModel.loading,
            maxLength: 75,
            controller: viewModel.emailController,
            suffixIcon: viewModel.emailController.text.isNotEmpty && viewModel.emailError != null
                ? customTooltip(
                    message: "Geçerli bir email adresi girmeniz gerekmektedir",
                    child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN),
                  )
                : null,
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
              viewModel.register(context);
            },
            labelText: 'Şifre',
            enabled: !viewModel.loading,
            maxLength: 18,
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                passwordShowIcon(),
                if (viewModel.passwordController.text.isNotEmpty && viewModel.passwordError != null)
                  customTooltip(
                    message: "Şifreniz en az 8, en fazla 16 karakter olmalı ve en az 1 büyük harf, 1 küçük harf ve 1 adet rakam içermelidir",
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
            controller: viewModel.passwordController,
            onChanged: (text) {
              viewModel.setPasswordError(!text.passwordValidation());
            },
            height: Sizer.getHeight(context) * 0.055,
          ),
          Divider(height: Sizer.getHeight(context) * 0.025, color: Colors.transparent),
          getLoginButton(context),
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

  Widget getLoginButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Observer(builder: (_) {
            return customMaterialButton(
              context: context,
              isLoading: viewModel.loading,
              enabled: viewModel.emailError == null && viewModel.passwordError == null && viewModel.nameError == null && viewModel.surnameError == null,
              text: "Kayıt Ol",
              onTap: () {
                viewModel.register(context);
              },
            );
          }),
        ),
      ],
    );
  }
}
