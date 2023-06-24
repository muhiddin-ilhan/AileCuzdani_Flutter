import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/custom_snack_bar.dart';
import 'package:aile_cuzdani/core/components/popups/app_update_popup.dart';
import 'package:aile_cuzdani/view/auth/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../core/components/app_logo.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/sizer_utils.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashViewModel viewModel = SplashViewModel();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.checkVersion(context).then((result) {
        if (result == 1) {
          viewModel.isAuthenticate(context);
        } else if (result == -1) {
          showAppUpdatePopup(context);
        } else {
          customSnackBar(context, message: "İnternet Bağlantınızı Kontrol Ediniz, İnternetiniz Var İse Daha Sonra Tekrar Deneyiniz");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      onPageBuilder: (context) => Scaffold(
        body: Container(
          width: Sizer.getWidth(context),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                CustomColors.GREEN,
                CustomColors.DARK_GREEN,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 1),
              stops: [0.25, 1],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appLogo(
                height: Sizer.getHeight(context) * 0.5,
                width: Sizer.getWidth(context) * 0.4,
                textSize: 38,
              ),
              const CircularProgressIndicator(
                color: CustomColors.VERY_DARK_GREEN,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
