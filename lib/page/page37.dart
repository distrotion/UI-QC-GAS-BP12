import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Cubit/31-ReportPDFCommoncubit.dart';
import 'P31ReportPDFcommon/ReportPDFCommonMain.dart';
import 'P36ReportPDFcov/ReportPDFcovMain.dart';
import 'P37ReportPDFASI/ReportPDFASIMain.dart';

class Page37 extends StatelessWidget {
  const Page37({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page37BlocTableBody();
  }
}

class Page37BlocTableBody extends StatelessWidget {
  const Page37BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportPDFCommon_Cubit(),
      child: BlocBuilder<ReportPDFCommon_Cubit, CommonReportOutput>(
        builder: (context, dataCommon) {
          return Page37Body(
            dataCommon: dataCommon,
          );
        },
      ),
    );
  }
}

class Page37Body extends StatelessWidget {
  Page37Body({Key? key, this.dataCommon}) : super(key: key);

  CommonReportOutput? dataCommon;

  @override
  Widget build(BuildContext context) {
    return ReportPDFASI(
      dataCommon: dataCommon,
    );
  }
}
