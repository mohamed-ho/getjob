import 'package:flutter/material.dart';

class JobWidget extends StatelessWidget {
  const JobWidget(
      {super.key,
      required this.title,
      required this.salary,
      required this.numberOfOrders,
      required this.onTap,
      required this.editFunction,
      required this.deleteFunction});
  final String title;
  final double salary;
  final int numberOfOrders;
  final Function() editFunction;
  final Function() deleteFunction;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: editFunction,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.yellow,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: InkWell(
                        onTap: deleteFunction,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$salary'),
                Text('$numberOfOrders Orders'),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
