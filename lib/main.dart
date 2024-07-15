import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impacteers/View/pages/Home_Page/UI/home.dart';
import 'package:impacteers/View/pages/Home_Page/bloc/home_bloc.dart';
import 'package:impacteers/res/constant.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Screenwidth initialize
    AppConstants.init(context);

    return BlocProvider(
      create: (context) => HomeBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        builder: (context, child) {
          return MediaQuery(
            child: child!,
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(1.0)),
          );
        },
      ),
    );
  }
}
