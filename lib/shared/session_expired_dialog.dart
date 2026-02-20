import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/helpers/helper_function.dart';
import '../core/routes/routes.dart';


class SessionExpiredDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onLogout;

  const SessionExpiredDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) => logoutFunction(context),
      child: AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.of(context).pop();
              onLogout();
              context.pushNamed(Routes.LOGIN);
            },
            child: Text(
              'S.of(context).logout',
            ),
          ),
        ],
      ),
    );
  }
}
