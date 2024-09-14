import 'package:flutter/material.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/features/job/domain/entities/job.dart';

class ApplicationOfUserOrder extends StatelessWidget {
  const ApplicationOfUserOrder({
    super.key,
    required this.job,
  });
  final Job job;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/companydefaultImage.jpg',
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${job.companyName} ',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            job.title,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            job.address,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Icon(Icons.more_vert)
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.mainColor,
                        foregroundColor: Colors.white),
                    child: const Row(
                      children: [
                        Text(
                          'Delivered',
                        ),
                        Icon(Icons.book_rounded)
                      ],
                    ),
                  ),
                  Text('\$ ${job.salary} Monthly'),
                ],
              ),
            )
          ],
        ));
  }
}
