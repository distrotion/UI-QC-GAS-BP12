import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Cubit/31-ReportPDFCommoncubit.dart';
import 'P30SELECTReport/P30SELECTReportMain.dart';
import 'P31ReportPDFcommon/ReportPDFCommonMain.dart';

class Page30 extends StatelessWidget {
  const Page30({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page30BlocTableBody();
  }
}

class Page30BlocTableBody extends StatelessWidget {
  const Page30BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportPDFCommon_Cubit(),
      child: BlocBuilder<ReportPDFCommon_Cubit, CommonReportOutput>(
        builder: (context, dataCommon) {
          return Page30Body(
            dataCommon: dataCommon,
          );
        },
      ),
    );
  }
}

class Page30Body extends StatelessWidget {
  Page30Body({Key? key, this.dataCommon}) : super(key: key);

  CommonReportOutput? dataCommon;

  @override
  Widget build(BuildContext context) {
    return SELECTReport(
      dataCommon: dataCommon,
    );
  }
}
