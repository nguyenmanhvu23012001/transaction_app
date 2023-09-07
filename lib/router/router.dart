import 'package:auto_route/auto_route.dart';
import 'package:zen8app/app/pages/main/wallet/wallet_detail.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/app/pages/auth/login/login_page.dart';
import 'package:zen8app/app/pages/main/home/home_page.dart';
import 'package:zen8app/models/sources/wallet.dart';

import '../app/pages/auth/login/sign_up_page.dart';
import '../app/pages/auth/login/wellcome_page.dart';
import '../app/pages/main/history/history_page.dart';
import '../app/pages/main/transaction/transaction_detail.dart';
import '../app/pages/main/transaction/transaction_page.dart';
import '../app/pages/main/wallet/wallet_page.dart';
import '../models/sources/transaction.dart';
export 'package:auto_route/auto_route.dart';

part 'router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (Session.isLoggedIn) {
      resolver.next(true);
    } else {
      router.push(LoginRoute());
    }
  }
}

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: WellComeRoute.page),
    AutoRoute(page: HomeRoute.page, path: "/", guards: [AuthGuard()]),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: TransactionRoute.page),
    AutoRoute(page: HistoryRoute.page),
    AutoRoute(page: WalletRoute.page),
    AutoRoute(page: TransactionDetailRoute.page),
    AutoRoute(page: WalletDetailRoute.page),

  ];
}
