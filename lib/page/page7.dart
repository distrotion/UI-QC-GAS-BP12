import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/07-01-GASMCS002.dart';
import '../bloc/Cubit/Rebuild.dart';
import '../model/model.dart';
import 'P7GASMCS002/GASMCS002main.dart';
import 'P7GASMCS002/GASMCS002var.dart';

class Page7 extends StatelessWidget {
  const Page7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page7BlocTableBody();
  }
}

class Page7BlocTableBody extends StatelessWidget {
  const Page7BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => GASMCS002_Bloc(),
        child: BlocBuilder<GASMCS002_Bloc, GASMCS002SCHEMA>(
          builder: (context, data) {
            return Page7Body(
              data: data,
            );
          },
        ));
  }
}

class Page7Body extends StatelessWidget {
  Page7Body({Key? key, this.data}) : super(key: key);

  GASMCS002SCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MICROSCOPE_GASMCS002main(
        data: data,
      ),
    );
  }
}
