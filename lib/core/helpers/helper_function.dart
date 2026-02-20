import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
 import 'package:go_router/go_router.dart';
import 'package:huungry/features/auth/data/models/user_model.dart';

import '../../shared/custom_dialog_design.dart';
import '../cached/app_controller.dart';
import '../constants/const_string.dart';
import '../routes/routes.dart';




Future<void> loginCache({
  required UserModel data,
  required String token,
}) async {
   await AppController.setSecuredString(tokenText, token);
  await AppController.instance.setLoggedIn(true);
  await AppController.instance.setUser(data);
}
/*Future<void> loginCache({
  required UserModel data,
  required String token,
}) async {
  GetSettingCubit.get(navigatorKey.currentContext!).cahngeIsLogedIn(true);
  await AppController.setSecuredString(tokenText, token);
  await AppController.instance.setLoggedIn(true);
  await AppController.instance.setUser(data);
}

String getLanguageStringFromCode({required String languageCode}) {
  Map<String, dynamic> language = {
    arabicCode: "اللغة العربية",
    englishCode: 'English',
  };
  return language[languageCode] ?? 'لا يوجد';
}

String getLanguageCodeFromCode({required String languageCode}) {
  Map<String, dynamic> language = {arabicCode: "ع", englishCode: 'En'};
  return language[languageCode] ?? '؟';
}*/

/*Future<String> getDeviceId() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor ?? '';
    }
    return '';
  } catch (e) {
    log("Error getting device ID: $e");
    return '';
  }
}*/

Future<DateTime?> selectDate(
  BuildContext context, {
  DateTime? initDate,
  DateTime? firstTime,
  DateTime? lastTime,
}) async {
  return await showDatePicker(
    context: context,
    initialDate: initDate ?? DateTime.now(),
    firstDate: firstTime ?? DateTime.now(),
    lastDate: lastTime ?? DateTime.now().add(const Duration(days: 999)),
  );
}

/*String dateToString(DateTime date) =>
    L.DateFormat('yyyy-MM-dd', 'en_US').format(date);*/

String formatTime(int seconds) {
  final int minutes = (seconds % 3600) ~/ 60;
  final int remainingSeconds = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}

/// Function to separate date and time from a given date-time string
Map<String, String> separateDateAndTime(String dateTimeString) {
  try {
    // Parse the date-time string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);


    // Format the date and time separately
    String date =
        "${dateTime.year}-${dateTime.month >= 10 ? dateTime.month : '0${dateTime.month}'}-${dateTime.day >= 10 ? dateTime.day : '0${dateTime.day}'}";
    String time =
        "${dateTime.hour >= 10 ? dateTime.hour : '0${dateTime.hour}'}:${dateTime.minute >= 10 ? dateTime.minute : '0${dateTime.minute}'}:${dateTime.second >= 10 ? dateTime.second : '0${dateTime.second}'}";

    // Return a map containing the separated date and time
    return {'date': date, 'time': time};
  } catch (e) {
    // Handle any parsing errors
    return {'date': 'Invalid date', 'time': 'Invalid time'};
  }
}

/*customErrorToast(
  BuildContext context, {
  required String errorText,
  bool isSuccess = false,
}) => showToastWidget(
  Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Directionality(
      textDirection: context.isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 19.h),
        decoration: BoxDecoration(
          color: isSuccess ? AppColors.successColor : AppColors.dangerColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Icon(Icons.info, color: AppColors.scaffoldColor),
            const HorizontalSizedBox(10),
            Expanded(
              child: Text(
                errorText,
                style: mainBody.copyWith(color: context.scaffoldColor),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  context: context,
  position: StyledToastPosition.top,
);*/

Future<void> logoutFunction(BuildContext context) async {
  await AppController.instance.logout(context);
  context.goNamed(Routes.LOGIN);
}

void logoutAppDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => CustomDialogDesign(
          label: 'S.of(context).youNeedLogout',
          yesFunction: () => exit(0),
        ),
  );
}

/*deleteAccountDialog(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: context.scaffoldColor,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 2 / 3,
    ),
    builder:
        (context) => SizedBox(
          width: double.infinity,
          child: Padding(
            padding: AppPadding.horizontalAndVertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('S.of(context).youNeedDeleteAccount', style: mainBody),
                CustomDivider(),
                AppBtn(
                  // isLoading: state is AuthDeleteAccountLoading,
                  title: S.of(context).yesDeleteAccount,
                  // function: () => AuthCubit.get(context).deleteAccount(),
                  function: () {},
                  btnColor: AppColors.dangerColor,
                ),

                VerticalSizedBox(vMedium20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    S.of(context).cancel,
                    style: mainBodySecondaryColor,
                  ),
                ),
                VerticalSizedBox(vMedium20),
              ],
            ),
          ),
        ),
  );
}*/

/*logoutDialog(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: context.scaffoldColor,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 2 / 3,
    ),
    builder:
        (context) => SizedBox(
          width: double.infinity,
          child: Padding(
            padding: AppPadding.horizontalAndVertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(S.of(context).youNeedLogout, style: mainBody),
                CustomDivider(),
                BlocProvider(
                  create:
                      (context) =>
                          AuthCubit(getIt(), getIt(), getIt(), getIt()),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is LogoutSuccess) {
                        logoutFunction(context);
                      }
                    },
                    builder:
                        (context, state) => AppBtn(
                          isLoading: state is LogoutLoading,
                          title: S.of(context).yesLogout,
                          function: () => AuthCubit.get(context).logout(),
                          btnColor: AppColors.dangerColor,
                          textColor: AppColors.scaffoldColor,
                        ),
                  ),
                ),

                VerticalSizedBox(vMedium20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    S.of(context).cancel,
                    style: mainBodySecondaryColor,
                  ),
                ),
                VerticalSizedBox(vMedium20),
              ],
            ),
          ),
        ),
  );
}*/

// void changeLanguageBottomSheet(BuildContext context) => showModalBottomSheet(
//   context: context,
//   builder:
//       (context) => BlocProvider(
//         create: (context) => AccountVarCubit(),
//         child: const ChangeLanguageBottomSheet(),
//       ),
// );

/*Future<void> launchAction({
  required LaunchType type,
  required String value,
}) async {
  String url;
  switch (type) {
    case LaunchType.call:
      url = 'tel:$value';
      break;
    case LaunchType.email:
      url = 'mailto:$value';
      break;
    case LaunchType.url:
      url = value;
      break;
  }

  // Try to launch the app link; if it fails, fall back to the web link.
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url. Please make sure the app is installed or accessible via the web.';
  }
}*/
