import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Cubit/31-ReportPDFCommoncubit.dart';

import 'P40ReportPDF4GP/ReportPDF4GPMain.dart';

class Page40 extends StatelessWidget {
  const Page40({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page40BlocTableBody();
  }
}

class Page40BlocTableBody extends StatelessWidget {
  const Page40BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportPDFCommon_Cubit(),
      child: BlocBuilder<ReportPDFCommon_Cubit, CommonReportOutput>(
        builder: (context, dataCommon) {
          return Page40Body(
            dataCommon: dataCommon,
          );
        },
      ),
    );
  }
}

class Page40Body extends StatelessWidget {
  Page40Body({Key? key, this.dataCommon}) : super(key: key);

  CommonReportOutput? dataCommon;

  @override
  Widget build(BuildContext context) {
    return ReportPDF4GP(
      dataCommon: dataCommon,
    );
  }
}
