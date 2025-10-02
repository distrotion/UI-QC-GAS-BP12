import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Cubit/31-ReportPDFCommoncubit.dart';
import 'P41ReportPDFcommonALL/ReportPDFCommonMainALL.dart';

class Page41 extends StatelessWidget {
  const Page41({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page41BlocTableBody();
  }
}

class Page41BlocTableBody extends StatelessWidget {
  const Page41BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportPDFCommon_Cubit(),
      child: BlocBuilder<ReportPDFCommon_Cubit, CommonReportOutput>(
        builder: (context, dataCommon) {
          return Page41Body(
            dataCommon: dataCommon,
          );
        },
      ),
    );
  }
}

class Page41Body extends StatelessWidget {
  Page41Body({Key? key, this.dataCommon}) : super(key: key);

  CommonReportOutput? dataCommon;

  @override
  Widget build(BuildContext context) {
    return ReportPDFCommonNEW(
      dataCommon: dataCommon,
    );
  }
}
