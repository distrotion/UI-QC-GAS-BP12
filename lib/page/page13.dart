import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/13-01-Refgraph.dart';
import '../model/model.dart';
import 'P13Refgraph/Refgraphmain.dart';
import 'P13Refgraph/Refgraphvar.dart';

class Page13 extends StatelessWidget {
  const Page13({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page13BlocTableBody();
  }
}

class Page13BlocTableBody extends StatelessWidget {
  const Page13BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => Refgraph_Bloc(),
        child: BlocBuilder<Refgraph_Bloc, RefgraphSCHEMA>(
          builder: (context, data) {
            return Page13Body(
              data: data,
            );
          },
        ));
  }
}

class Page13Body extends StatelessWidget {
  Page13Body({Key? key, this.data}) : super(key: key);
  RefgraphSCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return MICROVICKER_Refgraphmain(
      data: data,
    );
  }
}
