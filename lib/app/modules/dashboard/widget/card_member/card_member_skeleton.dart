import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'card_member_clipper.dart';

class SkeletonCardMember extends StatelessWidget {
  const SkeletonCardMember({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CardMemberClipPath(),
      child: Skeletonizer.zone(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          decoration: const BoxDecoration(gradient: kRedGradient),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Bone.text(words: 2), Bone.text(words: 2)],
                ),
                const SizedBox(height: 14),
                Bone.text(words: 3),
                const SizedBox(height: 5),
                Bone.text(words: 2),
                const SizedBox(height: 10),
                Bone.text(words: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
