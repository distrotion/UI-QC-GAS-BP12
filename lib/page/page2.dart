import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/BlocEvent/02-01-APPGAS12.dart';

import 'P2APPGAS12/APPGAS12main.dart';
import 'P2APPGAS12/APPGAS12var.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page2BlocTableBody();
  }
}

class Page2BlocTableBody extends StatelessWidget {
  const Page2BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => APPGAS12_Bloc(),
        child: BlocBuilder<APPGAS12_Bloc, APPGAS12SCHEMA>(
          builder: (context, data) {
            return Page2Body(
              data: data,
            );
          },
        ));
  }
}

class Page2Body extends StatelessWidget {
  Page2Body({Key? key, this.data}) : super(key: key);
  APPGAS12SCHEMA? data;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: APPEARANCE_APPGAS12main(
        data: data,
      ),
    );
  }
}
