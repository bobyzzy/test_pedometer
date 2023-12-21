import 'package:flutter/material.dart';

class CustomStepsInfo extends StatelessWidget {
  const CustomStepsInfo({
    super.key,
    required this.width,
    required this.height,
    required this.snapshot,
    required this.labelIcon,
    required this.labelText,
    required this.textColor,
    required this.infoSteps,
    required this.infoWidget,
  });

  final double width;
  final double height;
  final AsyncSnapshot snapshot;
  final String labelIcon;
  final String labelText;
  final String infoSteps;
  final Color textColor;
  final Widget infoWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.18,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    labelIcon,
                    fit: BoxFit.cover,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    labelText,
                    style:  TextStyle(color: textColor),
                  ),
                ],
              ),
              snapshot.hasData
                  ? RichText(
                      text: TextSpan(
                        text: '${snapshot.data}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: infoSteps,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Text("Нет данных"),
            ],
          ),
          infoWidget
        ],
      ),
    );
  }
}
