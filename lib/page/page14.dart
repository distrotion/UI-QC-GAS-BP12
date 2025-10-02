import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/BlocEvent/14-01-TotalNitriding.dart';
import '../model/model.dart';
import 'P14TotalNitriding/TotalNitridingmain.dart';
import 'P14TotalNitriding/TotalNitridingvar.dart';

class Page14 extends StatelessWidget {
  const Page14({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page14BlocTableBody();
  }
}

class Page14BlocTableBody extends StatelessWidget {
  const Page14BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TotalNitriding_Bloc(),
        child: BlocBuilder<TotalNitriding_Bloc, TotalNitridingSCHEMA>(
          builder: (context, data) {
            return Page14Body(
              data: data,
            );
          },
        ));
  }
}

class Page14Body extends StatelessWidget {
  Page14Body({Key? key, this.data}) : super(key: key);
  TotalNitridingSCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return MICROVICKER_TotalNitridingmain(
      data: data,
    );
  }
}
