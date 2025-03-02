import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/kcolors.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/loading_indidactor.dart';
import '../../../../widgets/no_content_message_widget.dart';
import '../../models/user_details.dart';
import '../providers/provider.dart';
import 'widgets/view_user_details_drawer.dart';

class RequestsPage extends ConsumerWidget {
  const RequestsPage({super.key});

  static const route = "/requests";

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
      key: ref.read(requestsProvider.notifier).scaffoldKey,
      endDrawer: const ViewUserDetailsDrawer(),
      body: Consumer(builder: (_, ref, __) {
        final entrepreneurs = ref.watch(requestsProvider.select((value) => value.entrepreneurs));

        if (entrepreneurs == null) {
          return const Center(child: LoadingIndicator());
        } else if (entrepreneurs.isEmpty) {
          return const NoContentMessageWidget(
            message: "No new requests",
            icon: Icons.request_page,
          );
        } else {
          return Table(
            border: TableBorder.all(color: KColors.white10),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: const BoxDecoration(color: KColors.white10),
                children: [
                  // Columns
                  ...["Name", "Phone", "Email", "Status", "View"].map(
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
                          entrepreneur.email.toString(),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                            decoration: BoxDecoration(
                              color: getStatusColor(entrepreneur),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: AppText(
                              getStatus(entrepreneur),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => ref.read(requestsProvider.notifier).setVerifyingToUser(entrepreneur),
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
          );
        }
      }),
    );
  }
}
