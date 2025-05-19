import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Cubit/31-ReportPDFCommoncubit.dart';
import 'P31ReportPDFcommon/ReportPDFCommonMain.dart';
import 'P36ReportPDFcov/ReportPDFcovMain.dart';

class Page36 extends StatelessWidget {
  const Page36({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page36BlocTableBody();
  }
}

class Page36BlocTableBody extends StatelessWidget {
  const Page36BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportPDFCommon_Cubit(),
      child: BlocBuilder<ReportPDFCommon_Cubit, CommonReportOutput>(
        builder: (context, dataCommon) {
          return Page36Body(
            dataCommon: dataCommon,
          );
        },
      ),
    );
  }
}

class Page36Body extends StatelessWidget {
  Page36Body({Key? key, this.dataCommon}) : super(key: key);

  CommonReportOutput? dataCommon;

  @override
  Widget build(BuildContext context) {
    return ReportPDFcov(
      dataCommon: dataCommon,
    );
  }
}
