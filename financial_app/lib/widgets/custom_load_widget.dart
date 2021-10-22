import 'package:financial_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

customLoadWidget({required String heading, required int percentage, required Color color}) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppColors.greyColor.withOpacity(0.5),
          ),
          child: Row(
            children: [
              Expanded(
                flex: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: color,
                  ),
                ),
              ),
              Spacer(
                flex: 100 - percentage,
              )
            ],
          ),
        ),
      ],
    ),
  );
}
