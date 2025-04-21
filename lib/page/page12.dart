import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/12-01-GASOHR001.dart';
import '../model/model.dart';
import 'P12GASOHR001/GASOHR001main.dart';
import 'P12GASOHR001/GASOHR001var.dart';

class Page12 extends StatelessWidget {
  const Page12({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page12BlocTableBody();
  }
}

class Page12BlocTableBody extends StatelessWidget {
  const Page12BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => GASOHR001_Bloc(),
        child: BlocBuilder<GASOHR001_Bloc, GASOHR001SCHEMA>(
          builder: (context, data) {
            return Page12Body(
              data: data,
            );
          },
        ));
  }
}

class Page12Body extends StatelessWidget {
  Page12Body({Key? key, this.data}) : super(key: key);
  GASOHR001SCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return MICROVICKER_GASOHR001main(
      data: data,
    );
  }
}
