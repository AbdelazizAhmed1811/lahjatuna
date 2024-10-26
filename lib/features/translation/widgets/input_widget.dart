import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../themes/colors.dart';

class InputWidget extends StatefulWidget {
  final String sourceLanguage;

  const InputWidget({super.key, required this.sourceLanguage});

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 5.h, horizontal: 10.w), // Responsive padding
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    widget.sourceLanguage,
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
              ),
              IconButton(
                icon: Icon(Icons.close,
                    color: Colors.black, size: 24.sp), // Responsive icon size
                onPressed: () {
                  _textEditingController.clear();
                },
              ),
            ],
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: 153.h, // Responsive height
              child: TextField(
                maxLines: null,
                controller: _textEditingController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20.sp, // Responsive font size
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: ColorsManager.dartBlue,
                  radius: 24.r, // Responsive radius
                  child: Icon(
                    Icons.mic,
                    size: 30.sp, // Responsive icon size
                    color: ColorsManager.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.orange,
                    fixedSize: Size(120.w, 35.h), // Responsive button size
                  ),
                  child: Text(
                    "Translate",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 15.sp, // Responsive font size
                      color: ColorsManager.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
