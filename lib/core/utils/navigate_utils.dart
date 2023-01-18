// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/api.dart';
import 'package:aile_cuzdani/core/providers/authentication_provider.dart';
import 'package:aile_cuzdani/core/providers/bottom_navbar_provider.dart';
import 'package:aile_cuzdani/core/providers/bucket_provider.dart';
import 'package:aile_cuzdani/core/providers/user_provider.dart';
import 'package:aile_cuzdani/core/utils/shared_preferences.dart';
import 'package:aile_cuzdani/view/auth/login/login_view.dart';
import 'package:aile_cuzdani/view/family_selection/family_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/user/user_services.dart';
import 'navigate_animation_state.dart';

class NavigateUtils {
  static Future<T?> push<T extends Object?>(
    BuildContext context, {
    String? pageUrl,
    required Widget page,
    NavigateAnimationState animationState = NavigateAnimationState.slideRightToLeft,
  }) async {
    return Navigator.push<T>(
        context,
        PageRouteBuilder(
          settings: RouteSettings(name: pageUrl),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: animationState.duration,
          reverseTransitionDuration: animationState.duration,
          transitionsBuilder: animationState.animation,
        ));
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context, {
    String? pageUrl,
    required Widget page,
    bool Function(Route<dynamic>)? predicate,
    NavigateAnimationState animationState = NavigateAnimationState.slideRightToLeft,
  }) async {
    try {
      return Navigator.pushAndRemoveUntil<T>(
        context,
        PageRouteBuilder(
          settings: RouteSettings(name: pageUrl),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: animationState.duration,
          reverseTransitionDuration: animationState.duration,
          transitionsBuilder: animationState.animation,
        ),
        predicate ?? (route) => false,
      );
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static void popUntil(BuildContext context, bool Function(Route<dynamic>) predicate) {
    return Navigator.popUntil(context, predicate);
  }

  static Future logout(BuildContext context) async {
    try {
      await UserServices.saveTokenToDatabase(isDeleted: true);
      await SharedManager.instance.remove("token");
    } catch (e) {
      debugPrint(e.toString());
    }
    Provider.of<AuthenticationProvider>(context, listen: false).reset();
    Provider.of<BucketProvider>(context, listen: false).reset();
    Provider.of<BottomNavBarProvider>(context, listen: false).reset();
    Provider.of<UserProvider>(context, listen: false).reset();
    Provider.of<BottomNavBarProvider>(context, listen: false).reset();
    Api.instance!.deleteToken();
    pushAndRemoveUntil(context, page: LoginView());
  }

  static void goFamilySelectionPage(BuildContext context) async {
    try {
      await UserServices.saveTokenToDatabase(isDeleted: true);
      await SharedManager.instance.remove("token");
    } catch (e) {
      debugPrint(e.toString());
    }
    Provider.of<AuthenticationProvider>(context, listen: false).removeFamily();
    Provider.of<BucketProvider>(context, listen: false).reset();
    Provider.of<BottomNavBarProvider>(context, listen: false).reset();
    Provider.of<UserProvider>(context, listen: false).reset();
    Provider.of<BottomNavBarProvider>(context, listen: false).reset();
    pushAndRemoveUntil(context, page: const FamilySelectionView());
  }
}
