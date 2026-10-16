import 'package:get/get.dart';
import '../controllers/finance_hub_controller.dart';

class FinanceHubBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinanceHubController>(() => FinanceHubController());
  }
}
