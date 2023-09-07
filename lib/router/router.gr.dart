// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    HistoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HistoryPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    TransactionDetailRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TransactionDetailPage(transaction: args.transaction),
      );
    },
    TransactionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TransactionPage(),
      );
    },
    WellComeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WellComePage(),
      );
    },
    WalletDetailRoute.name: (routeData) {
      final args = routeData.argsAs<WalletDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WalletDetailPage(wallet: args.wallet),
      );
    },
    WalletRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WalletPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpPage(),
      );
    },
  };
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HistoryPage]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TransactionDetailPage]
class TransactionDetailRoute extends PageRouteInfo<TransactionDetailRouteArgs> {
  TransactionDetailRoute({
    required TransactionData transaction,
    List<PageRouteInfo>? children,
  }) : super(
          TransactionDetailRoute.name,
          args: TransactionDetailRouteArgs(transaction: transaction),
          initialChildren: children,
        );

  static const String name = 'TransactionDetailRoute';

  static const PageInfo<TransactionDetailRouteArgs> page =
      PageInfo<TransactionDetailRouteArgs>(name);
}

class TransactionDetailRouteArgs {
  const TransactionDetailRouteArgs({required this.transaction});

  final TransactionData transaction;

  @override
  String toString() {
    return 'TransactionDetailRouteArgs{transaction: $transaction}';
  }
}

/// generated route for
/// [TransactionPage]
class TransactionRoute extends PageRouteInfo<void> {
  const TransactionRoute({List<PageRouteInfo>? children})
      : super(
          TransactionRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WellComePage]
class WellComeRoute extends PageRouteInfo<void> {
  const WellComeRoute({List<PageRouteInfo>? children})
      : super(
          WellComeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WellComeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WalletDetailPage]
class WalletDetailRoute extends PageRouteInfo<WalletDetailRouteArgs> {
  WalletDetailRoute({
    required WalletModel wallet,
    List<PageRouteInfo>? children,
  }) : super(
          WalletDetailRoute.name,
          args: WalletDetailRouteArgs(wallet: wallet),
          initialChildren: children,
        );

  static const String name = 'WalletDetailRoute';

  static const PageInfo<WalletDetailRouteArgs> page =
      PageInfo<WalletDetailRouteArgs>(name);
}

class WalletDetailRouteArgs {
  const WalletDetailRouteArgs({required this.wallet});

  final WalletModel wallet;

  @override
  String toString() {
    return 'WalletDetailRouteArgs{wallet: $wallet}';
  }
}

/// generated route for
/// [WalletPage]
class WalletRoute extends PageRouteInfo<void> {
  const WalletRoute({List<PageRouteInfo>? children})
      : super(
          WalletRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
