import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:laundry_app/core/apis/order_repository.dart';
import 'package:laundry_app/core/widgets/locale_service.dart';
import 'package:laundry_app/features/order_screen/presentation/order_cubit/schedule_order/order_cubit.dart';
import 'package:laundry_app/features/splash_screen/presentation/views/splash_screen.dart';
import 'package:laundry_app/features/view_order_screen/presentation/managers/orders_cubit/order_cubits.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "your_publishable_key_here"; // استبدل بالمفتاح العام من Stripe
  await EasyLocalization.ensureInitialized();
    final savedLocale = await LocaleService.getSavedLocale();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: Locale('ar'),
      startLocale: savedLocale,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OrderCubit()),
        BlocProvider(create: (context) => OrderCubits(OrderRepository(Dio()))),
      ],

      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
