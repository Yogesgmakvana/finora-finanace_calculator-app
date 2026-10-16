import 'package:get/get.dart';
import '../modules/finance_hub/bindings/finance_hub_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../views/finora_views.dart';
import '../views/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(name: Routes.SPLASH, page: () => const SplashView()),
    GetPage(name: Routes.HOME, page: () => const HomeView(), binding: HomeBinding()),
    GetPage(name: Routes.FINANCE_HUB, page: () => const FinanceHubView(), binding: FinanceHubBinding()),
    GetPage(name: Routes.EMI_CALCULATOR, page: () => const CalculatorView(type: CalculatorType.emi)),
    GetPage(name: Routes.LOAN_AMOUNT_CALCULATOR, page: () => const CalculatorView(type: CalculatorType.loanAmount)),
    GetPage(name: Routes.SIP_CALCULATOR, page: () => const CalculatorView(type: CalculatorType.sip)),
    GetPage(name: Routes.GST_CALCULATOR, page: () => const CalculatorView(type: CalculatorType.gst)),
    GetPage(name: Routes.INTEREST_CALCULATOR, page: () => const CalculatorView(type: CalculatorType.interest)),
    GetPage(name: Routes.COMPARE_LOANS, page: () => const CalculatorView(type: CalculatorType.compare)),
    GetPage(name: Routes.CASH_CALCULATOR, page: () => const CalculatorView(type: CalculatorType.cash)),
  ];
}
