import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> customPopup(BuildContext context, String title, String body) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8.sp),
      backgroundColor: Colors.white,
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 600.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 50.sp,
              decoration: BoxDecoration(color: Colors.amber),
              child: Center(
                child: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.sp),
                    Text(
                      body,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "OK",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ),
      ],
    ),
  );
}
