import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';

class SessionService extends GetxService {
  Rxn<AccountBillModel> currentUser = Rxn<AccountBillModel>();

  void setUser(AccountBillModel user) => currentUser.value = user;
  void clear() => currentUser.value = null;
}
