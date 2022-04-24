import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
    duration: const Duration(milliseconds: 1500),
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
    // width: 280,
    // behavior: SnackBarBehavior.floating,
    backgroundColor: const Color(0xff2E305F).withOpacity(0.8),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15))),
  ));
}
