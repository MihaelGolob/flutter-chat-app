import 'package:flutter/material.dart';

SnackBar chatSnackBar(Key? key, String message) {
  return SnackBar(
    backgroundColor: const Color.fromARGB(255, 33, 124, 124),
    content: Text(
      message,
      key: key,
      textAlign: TextAlign.center,
    ),
  );
}
