import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Cubit/31-ReportPDFCommoncubit.dart';
import 'P32ReportPDFwm/ReportPDFwmMain.dart';
import 'P33ReportPDF2GP/ReportPDF2GPMain.dart';
import 'P34ReportPDF3PIC/ReportPDF3PICMain.dart';

class Page34 extends StatelessWidget {
  const Page34({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page34BlocTableBody();
  }
}

class Page34BlocTableBody extends StatelessWidget {
  const Page34BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportPDFCommon_Cubit(),
      child: BlocBuilder<ReportPDFCommon_Cubit, CommonReportOutput>(
        builder: (context, dataCommon) {
          return Page34Body(
            dataCommon: dataCommon,
          );
        },
      ),
    );
  }
}

class Page34Body extends StatelessWidget {
  Page34Body({Key? key, this.dataCommon}) : super(key: key);

  CommonReportOutput? dataCommon;

  @override
  Widget build(BuildContext context) {
    return ReportPDF3PIC(
      dataCommon: dataCommon,
    );
  }
}
