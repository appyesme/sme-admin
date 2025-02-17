import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/kcolors.dart';
import '../../../../../widgets/app_text.dart';

class SettingCard extends ConsumerWidget {
  const SettingCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final faq = ref.watch(faqsProvider.select((value) => value.faqs!.elementAt(index)));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: InkWell(
            // onTap: () => ref.read(faqsProvider.notifier).setQuestionToAnswer(faq),
            borderRadius: BorderRadius.circular(6),
            child: Ink(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: KColors.filled,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: KColors.white10, width: 1.5),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: AppText(
                      "faq.question ?? ''",
                      color: KColors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      // ref.watch(faqsProvider.notifier).setChallengeIdToView(faq.challengeId!);
                    },
                    customBorder: const CircleBorder(),
                    child: const Tooltip(
                      message: "See challenge",
                      child: Material(
                        color: KColors.white10,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.emoji_events,
                            color: KColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Tooltip(
                  //   message: faq.answer != null ? "Answered" : "Not Answered",
                  //   child: Icon(
                  //     faq.answer != null ? Icons.check_box : Icons.check_box_outline_blank,
                  //     color: faq.answer != null ? Colors.green : KColors.grey,
                  //     size: 34,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
