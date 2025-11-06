import 'package:vigo_customer_billing/app/core/middleware/auth_middleware.dart';
import 'package:vigo_customer_billing/app/modules/history/datail/invoice.dart';
import 'package:vigo_customer_billing/app/modules/history/datail/invoice_binding.dart';
import 'package:get/get.dart';

class InvoiceRoutes {
  InvoiceRoutes._();

  static final routes = [
    GetPage(
      name: '/invoice/detail/:id',
      page: () => const InvoicePage(),
      binding: InvoiceBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
