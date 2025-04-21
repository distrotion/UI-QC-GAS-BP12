import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Cubit/31-ReportPDFCommoncubit.dart';
import 'P32ReportPDFwm/ReportPDFwmMain.dart';
import 'P33ReportPDF2GP/ReportPDF2GPMain.dart';

class Page33 extends StatelessWidget {
  const Page33({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page33BlocTableBody();
  }
}

class Page33BlocTableBody extends StatelessWidget {
  const Page33BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportPDFCommon_Cubit(),
      child: BlocBuilder<ReportPDFCommon_Cubit, CommonReportOutput>(
        builder: (context, dataCommon) {
          return Page33Body(
            dataCommon: dataCommon,
          );
        },
      ),
    );
  }
}

class Page33Body extends StatelessWidget {
  Page33Body({Key? key, this.dataCommon}) : super(key: key);

  CommonReportOutput? dataCommon;

  @override
  Widget build(BuildContext context) {
    return ReportPDF2GP(
      dataCommon: dataCommon,
    );
  }
}
