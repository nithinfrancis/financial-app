import 'package:financial_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

Widget transactionTile({required bool isSuccess}) {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              "assets/images/user_icon.png",
              height: 50,
              width: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Jhon Doe",
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "United Kingdom",
                  style: TextStyle(color: AppColors.greyColor, fontSize: 13),
                )
              ],
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "80,000 AED",
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "11 Aug 2021",
                  style: TextStyle(color: AppColors.greyColor, fontSize: 13),
                )
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            (isSuccess)
                ? Icon(
                    Icons.check_circle,
                    color: AppColors.greenColor,
                    size: 20,
                  )
                : Icon(
                    Icons.timelapse,
                    size: 20,
                    color: AppColors.lightOrangeColor,
                  ),
          ],
        )
      ],
    ),
  );
}
