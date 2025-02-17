import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/kcolors.dart';

class AnswerFAQWidget extends ConsumerWidget {
  const AnswerFAQWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final answeringTo = ref.watch(faqsProvider.select((value) => value.answeringTo));
    // if (answeringTo == null) return const SizedBox();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Drawer(
          backgroundColor: KColors.bgColor,
          width: constraints.maxWidth / 2,
          child: const SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const AppText(
                //   "Answering to:",
                //   fontSize: 14,
                //   color: KColors.white,
                //   fontWeight: FontWeight.w400,
                // ),
                // AppText(
                //   answeringTo.question ?? '',
                //   color: KColors.white,
                // ),
                // const SizedBox(height: 20),
                // AppTextField(
                //   key: ValueKey(answeringTo.id),
                //   initialValue: answeringTo.answer,
                //   onChanged: (value) => ref.read(faqsProvider.notifier).onAnswerChanged(value),
                //   hintText: "Type answer...",
                //   radius: 4,
                //   borderColor: Colors.black12,
                //   minLines: 20,
                //   maxLines: 20,
                // ),
                // const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     AppButton(
                //       onTap: () => ref.read(faqsProvider.notifier).answer(context, ref),
                //       width: 200,
                //       backgroundColor: KColors.secondary,
                //       text: "Submit",
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}
