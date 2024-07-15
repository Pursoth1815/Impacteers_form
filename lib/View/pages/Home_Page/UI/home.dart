import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impacteers/View/pages/Home_Page/bloc/home_bloc.dart';
import 'package:impacteers/res/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();
  String page_id = '1';

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent(page_id: page_id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        builder: (context, state) {
          return Container();
        },
        listener: (context, state) {
          if (state is GoToUserDetailsState) {
            /*  Navigator.of(context).push(
              MyCustomAnimatedRoute(
                route: HomePage(),
              ),
            ); */
          }
        },
      ),
    );
  }
}
