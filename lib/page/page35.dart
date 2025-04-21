import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Cubit/31-ReportPDFCommoncubit.dart';
import 'P32ReportPDFwm/ReportPDFwmMain.dart';
import 'P33ReportPDF2GP/ReportPDF2GPMain.dart';
import 'P34ReportPDF3PIC/ReportPDF3PICMain.dart';
import 'P35ReportPDFwm3/ReportPDFwm3Main.dart';

class Page35 extends StatelessWidget {
  const Page35({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page35BlocTableBody();
  }
}

class Page35BlocTableBody extends StatelessWidget {
  const Page35BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportPDFCommon_Cubit(),
      child: BlocBuilder<ReportPDFCommon_Cubit, CommonReportOutput>(
        builder: (context, dataCommon) {
          return Page35Body(
            dataCommon: dataCommon,
          );
        },
      ),
    );
  }
}

class Page35Body extends StatelessWidget {
  Page35Body({Key? key, this.dataCommon}) : super(key: key);

  CommonReportOutput? dataCommon;

  @override
  Widget build(BuildContext context) {
    return ReportPDFwm3(
      dataCommon: dataCommon,
    );
  }
}
