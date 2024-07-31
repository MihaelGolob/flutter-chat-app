import 'package:flutter/material.dart';

class CompanyButton extends StatelessWidget {
  final Image image;
  final VoidCallback? onPressed;
  const CompanyButton({super.key, required this.image, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: image,
      ),
    );
  }
}
