import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/not_found.dart';
import 'package:vigo_customer_billing/app/modules/help/chat/controllers/help_chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigo_customer_billing/app/modules/help/chat/widgets/input_chat_widget.dart';
import 'package:vigo_customer_billing/app/modules/help/chat/widgets/list_data.dart';

class ChatHelpPage extends GetView<HelpChatController> {
  @override
  Widget build(BuildContext context) {
    controller.getData();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Chat',
          style: GoogleFonts.montserrat(
            color: textPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
                vertical: 10,
              ),
              child: Obx(() {
                final data = controller.data;
                if (controller.isLoading.value) {
                  return Container();
                }
                return RefreshIndicator(
                  color: mainColor,
                  onRefresh: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      controller.getData();
                    });
                    return Future.value(true);
                  },
                  child: data.isEmpty
                      ? SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 300,
                            child: NotFoundPage(),
                          ),
                        )
                      : ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: controller.scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount:
                                data.length +
                                (controller.isLoadMore.value ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index < data.length) {
                                return ListDataChatWidget(data: data[index]);
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 28,
                                        width: 28,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          valueColor: AlwaysStoppedAnimation(
                                            mainColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                );
              }),
            ),
          ),
          ChatInputWidget(),
        ],
      ),
    );
  }
}
