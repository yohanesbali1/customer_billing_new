import 'package:vigo_customer_billing/app/core/middleware/auth_middleware.dart';
import 'package:vigo_customer_billing/app/modules/invoice/datail/views/invoice_detail.dart';
import 'package:vigo_customer_billing/app/modules/invoice/datail/bindings/invoice_detail_binding.dart';
import 'package:get/get.dart';

class InvoiceRoutes {
  InvoiceRoutes._();

  static final routes = [
    GetPage(
      name: '/invoice/detail/:id',
      page: () => const InvoiceDetailPage(),
      binding: InvoiceDetailBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
