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
  void _showDropdownMenu(BuildContext context, Offset position, id) async {
    final selected = await showMenu(
      context: context,
      color: Colors.white,
      shadowColor: Colors.grey.shade300,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx + 1,
        position.dy + 1,
      ),
      items: [
        PopupMenuItem(
          value: 'delete',
          height: 10,
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete, color: textPrimaryColor, size: 14),
              SizedBox(width: 5),
              Text(
                'Delete',
                style: GoogleFonts.montserrat(
                  color: textPrimaryColor,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (selected == 'delete') {
      bool confirm = await Helper().AlertGetX(type: 'question');
      if (confirm) {
        deleteData(id);
      }
    }
  }

  submitData(BuildContext context) async {
    if (controller.formkey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      await controller.submit_data();
    }
  }

  deleteData(id) async {
    if (controller.formkey.currentState!.validate()) {
      await controller.delete_data(id);
    }
  }

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
                      : ListView.builder(
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
