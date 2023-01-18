// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class AppRatingHelper {
  static final AppRatingHelper shared = AppRatingHelper._instance();

  // final InAppReview inAppReview = InAppReview.instance;
  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_12',
    minDays: 0,
    minLaunches: 2,
    remindDays: 0,
    remindLaunches: 5,
    googlePlayIdentifier: 'com.ilhan.aile_cuzdani.aile_cuzdani',
    appStoreIdentifier: '###########',
  );

  factory AppRatingHelper() {
    return shared;
  }

  AppRatingHelper._instance();

  void showRateDialog(context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await rateMyApp.init();
      if (rateMyApp.shouldOpenDialog /*&& await inAppReview.isAvailable()*/) {
        rateMyApp.showRateDialog(
          context,
          title: 'Rate this app', // The dialog title.
          message: 'You like this app ? Then take a little bit of your time to leave a rating.', // The dialog message.
          actionsBuilder: (context) {
            // Triggered when the user updates the star rating.
            return [
              // Return a list of actions (that will be shown at the bottom of the dialog).
              ElevatedButton(
                child: const Text('Maybe Later'),
                onPressed: () async {
                  await rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed);
                  Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.later);
                },
              ),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () async {
                  await rateMyApp.launchNativeReviewDialog();
                  await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                  Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
                  //  inAppReview.requestReview();
                  //await rateMyApp.launchStore();
                },
              ),
            ];
          },
          ignoreNativeDialog: true,
          dialogStyle: const DialogStyle(
            // Custom dialog styles.
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20),
          ),
          onDismissed: () async {
            await rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed);
          },
        );
      }
    });
  }
}
