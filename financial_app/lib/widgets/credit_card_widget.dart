import 'package:flutter/material.dart';

Widget creditCard({
  required Color gradient1,
  required Color gradient2,
  required String cardName,
  required String expireDate,
  required String cardNumber,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [
          gradient1,
          gradient2,
        ])),
    width: 350,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/master_card.png",
              height: 50,
              width: 50,
            ),
            Image.asset(
              "assets/images/visa.png",
              height: 50,
              width: 60,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          cardNumber,
          style: const TextStyle(color: Colors.white, fontSize: 20, wordSpacing: 30, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "CARD",
                  style: TextStyle(color: Colors.white60, fontSize: 10),
                ),
                Text(
                  cardName,
                  style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "EXPIRES",
                  style: TextStyle(color: Colors.white60, fontSize: 10),
                ),
                Text(
                  expireDate,
                  style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
                )
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
