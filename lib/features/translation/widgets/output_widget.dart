import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../themes/colors.dart';

class OutputWidget extends StatelessWidget {
  final String targetLanguage;

  const OutputWidget({super.key, required this.targetLanguage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w), // Responsive padding
      height: 250.h, // Responsive height
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20.r), // Responsive radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2.w,
            blurRadius: 5.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      targetLanguage,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        fontSize: 18.sp, // Responsive font size
                        color: ColorsManager.dartBlue,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up_outlined,
                          color: ColorsManager.dartBlue),
                      onPressed: () {},
                      iconSize: 24.sp, // Responsive icon size
                    ),
                  ],
                )
              ],
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: 140.h, // Responsive height
                child: const Text("data"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.copy_rounded,
                      color: ColorsManager.dartBlue),
                  onPressed: () {},
                  iconSize: 24.sp, // Responsive icon size
                ),
                IconButton(
                  icon: const Icon(Icons.share, color: ColorsManager.green),
                  onPressed: () {},
                  iconSize: 24.sp,
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border,
                      color: ColorsManager.pink),
                  onPressed: () {},
                  iconSize: 24.sp,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
