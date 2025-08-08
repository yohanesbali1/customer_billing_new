import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonReportDetail extends StatelessWidget {
  const SkeletonReportDetail({super.key});
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        Skeletonizer.zone(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
              padding:
                  EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Bone.text(words: 2),
                  const SizedBox(height: 14),
                  Row(children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Bone.text(words: 2),
                        SizedBox(height: 10),
                        Bone.text(words: 2),
                      ],
                    )),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Bone.text(words: 2),
                        SizedBox(height: 10),
                        Bone.text(words: 2),
                      ],
                    )),
                  ]),
                  const SizedBox(height: 14),
                  Row(children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Bone.text(words: 2),
                        SizedBox(height: 10),
                        Bone.text(words: 2),
                      ],
                    )),
                  ]),
                  SizedBox(height: 14),
                  Bone.text(words: 2),
                  SizedBox(height: 10),
                  Bone.multiText(lines: 3),
                  SizedBox(height: 14),
                  Bone.text(words: 2),
                  SizedBox(height: 10),
                  Bone.multiText(lines: 3),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Bone.text(words: 3),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(8, (index) {
                        return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(children: [
                              Bone.circle(size: 20),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Bone.text(words: 2),
                              ),
                            ]));
                      }),
                    ),
                  ],
                ))
          ],
        )),
      ],
    ));
  }
}
