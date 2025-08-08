import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonListReport extends StatelessWidget {
  const SkeletonListReport({super.key});
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, bottom: 10, top: 10),
        child: ListView.separated(
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 10,
                ),
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) => Container(
                padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: const Skeletonizer.zone(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Bone.circle(
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Bone.text(
                            width: 120,
                          ),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Bone.text(words: 2),
                                  SizedBox(height: 12),
                                  Bone.text(words: 2),
                                ]),
                          ),
                          SizedBox(width: 20),
                          Column(children: [
                            Bone.text(width: 60),
                          ]),
                        ]),
                  ],
                )))));
  }
}
