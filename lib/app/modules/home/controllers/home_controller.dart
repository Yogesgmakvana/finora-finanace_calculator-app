import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  void navigateTo(String route) {
    Get.toNamed(route);
  }
}
