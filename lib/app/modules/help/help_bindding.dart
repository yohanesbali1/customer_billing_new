import 'package:customer_billing/app/modules/help/help_chat_controller.dart';
import 'package:customer_billing/app/modules/help/help_add_controller.dart';

import 'help_detail_controller.dart';
import 'package:get/get.dart';
import 'help_controller.dart';

class HelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpController>(
      () => HelpController(),
    );
    Get.lazyPut<HelpDetailController>(
      () => HelpDetailController(),
    );

    Get.lazyPut<HelpFormController>(
      () => HelpFormController(),
    );
    Get.lazyPut<HelpChatController>(
      () => HelpChatController(),
    );
  }
}
