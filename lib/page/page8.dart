import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/BlocEvent/08-01-GASRHT001.dart';
import 'P8GASRHT001/GASRHT001main.dart';
import 'P8GASRHT001/GASRHT001var.dart';

class Page8 extends StatelessWidget {
  const Page8({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page8BlocTableBody();
  }
}

class Page8BlocTableBody extends StatelessWidget {
  const Page8BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => GASRHT001_Bloc(),
        child: BlocBuilder<GASRHT001_Bloc, GASRHT001SCHEMA>(
          builder: (context, data) {
            return Page8Body(
              data: data,
            );
          },
        ));
  }
}

class Page8Body extends StatelessWidget {
  Page8Body({Key? key, this.data}) : super(key: key);
  GASRHT001SCHEMA? data;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MICROVICKER_GASRHT001main(
        data: data,
      ),
    );
  }
}
