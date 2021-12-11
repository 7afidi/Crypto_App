import 'package:crypto_app/blocs/crypto/crypto_bloc.dart';
import 'package:crypto_app/repositories/crypto_repository.dart';
import 'package:crypto_app/screens/home_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  EquatableConfig.stringify = kDebugMode;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(390, 844),
        builder: () => RepositoryProvider(
              create: (context) => CryptoRepository(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(primaryColor: Colors.black),
                home: BlocProvider(
                  create: (context) => CryptoBloc(
                    cryptoRepository: context.read<CryptoRepository>(),
                  )..add(AppStarted()),
                  child: HomeScreen(),
                ),
              ),
            ));
  }
}
