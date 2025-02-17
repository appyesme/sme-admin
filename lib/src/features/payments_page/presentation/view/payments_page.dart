import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/kcolors.dart';
import '../../../../utils/string_extension.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/loading_indidactor.dart';
import '../../../../widgets/no_content_message_widget.dart';
import '../../../profile_page/models/user_details.dart';
import '../providers/provider.dart';
import 'widgets/view_payment_clearing_drawer.dart';

class PaymentsPage extends ConsumerWidget {
  const PaymentsPage({super.key});

  static const route = "/payments";

  String getStatus(UserDetails entrepreneur) {
    if (entrepreneur.verifiedAt != null && !entrepreneur.verified) {
      return "Rejected";
    } else if (entrepreneur.verifiedAt != null && entrepreneur.verified) {
      return "Approved";
    } else {
      return "Pending";
    }
  }

  Color getStatusColor(UserDetails entrepreneur) {
    if (entrepreneur.verifiedAt != null && !entrepreneur.verified) {
      return Colors.red;
    } else if (entrepreneur.verifiedAt != null && entrepreneur.verified) {
      return Colors.green;
    } else {
      return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: ref.read(paymentsProvider.notifier).scaffoldKey,
      endDrawer: const ViewPaymentClearingDrawer(),
      body: Consumer(builder: (_, ref, __) {
        final entrepreneurs = ref.watch(paymentsProvider.select((value) => value.entrepreneurs));

        if (entrepreneurs == null) {
          return const Center(child: LoadingIndicator());
        } else if (entrepreneurs.isEmpty) {
          return const NoContentMessageWidget(
            message: "No new requests",
            icon: Icons.request_page,
          );
        } else {
          return SingleChildScrollView(
            child: Table(
              border: TableBorder.all(color: KColors.white10),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: const BoxDecoration(color: KColors.white10),
                  children: [
                    // Columns
                    ...["Name", "Phone", "Last payment", "View"].map(
                      (column) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: AppText(column),
                        );
                      },
                    ),
                  ],
                ),

                /// Data
                ...entrepreneurs.map(
                  (entrepreneur) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: AppText(
                            entrepreneur.name.toString(),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: AppText(
                            entrepreneur.phoneNumber.toString(),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: AppText(
                            entrepreneur.lastClearedAt?.toDateFormat("MMM dd, yyyy") ?? "-",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        InkWell(
                          onTap: () => ref.read(paymentsProvider.notifier).setClearEntrepreneurPayment(entrepreneur),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              CupertinoIcons.eye,
                              color: KColors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
