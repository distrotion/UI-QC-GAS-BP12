import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Layout/head.dart';
import '../../bloc/Cubit/31-ReportPDFCommoncubit.dart';

import '../../bloc/Cubit/32-Reportset.dart';
import '../../data/CommonTestData.dart';
import '../../data/global.dart';
import '../../widget/GRAPH/LineGraph01.dart';
import '../../widget/GRAPH/LineGraphCONTROL.dart';
import '../../widget/ReportComponent/CommonReport.dart';
import '../../widget/ReportComponent/PicSlot.dart';
import '../../widget/ReportComponent/SignSide.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/ComInputText.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/common/Error_NO_Popup.dart';
import '../../widget/common/Loading.dart';
import '../../widget/common/Safty.dart';
import '../../widget/common/imgset.dart';
import '../../widget/common/popup.dart';
import '../../widget/function/helper.dart';
import '../P303QMMASTERQC/P303QMMASTERQCVAR.dart';
import '../page303.dart';
import 'ReportPDFcovvar.dart';

late BuildContext ReportPDFcovcontext;

class ReportPDFcov extends StatefulWidget {
  ReportPDFcov({
    Key? key,
    this.dataCommon,
  }) : super(key: key);
  CommonReportOutput? dataCommon;
  @override
  State<ReportPDFcov> createState() => _ReportPDFcovState();
}

class _ReportPDFcovState extends State<ReportPDFcov> {
  @override
  void initState() {
    ReportPDFcovvar.TPKLOTEDIT = '';
    print("ma rel");
    if (ReportPDFcovvar.PO != '') {
      ReportPDFcovvar.canf = false;
      context
          .read<ReportPDFCommon_Cubit>()
          .ReportPDFCommonCubit(ReportPDFcovvar.PO, "");
    }
    super.initState();
  }

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ReportPDFcovcontext = context;

    CommonReportOutput _dataCOMMON = widget.dataCommon ??
        CommonReportOutput(
          databasic: BasicCommonDATA(),
        );
    int HardnessNO = 1;
    int CoreNO = 1;
    int GraphNO = 1;
    int CompoundNO = 1;
    int RoughnessNO = 1;
    if (_dataCOMMON.datain.isNotEmpty) {
      //
      ReportPDFcovvar.STATUS = 'REPORT READY';
      ReportPDFcovvar.CUSTOMER = _dataCOMMON.databasic.CUSTOMER;
      ReportPDFcovvar.PROCESS = _dataCOMMON.databasic.PROCESS;
      ReportPDFcovvar.PARTNAME = _dataCOMMON.databasic.PARTNAME;
      ReportPDFcovvar.PARTNO = _dataCOMMON.databasic.PARTNO;
      ReportPDFcovvar.PARTNO_s = _dataCOMMON.databasic.PARTNO_s;
      ReportPDFcovvar.CUSLOT = _dataCOMMON.databasic.CUSLOT;
      ReportPDFcovvar.TPKLOT = _dataCOMMON.databasic.TPKLOT;
      ReportPDFcovvar.MATERIAL = _dataCOMMON.databasic.MATERIAL;
      if (_dataCOMMON.databasic.UNITSAP.toUpperCase() != 'KG') {
        ReportPDFcovvar.QTY =
            '${double.parse(ConverstStr(_dataCOMMON.databasic.QTY)).toStringAsFixed(0)} ${_dataCOMMON.databasic.UNITSAP}';
      } else {
        ReportPDFcovvar.QTY =
            '${double.parse(ConverstStr(_dataCOMMON.databasic.QTY)).toStringAsFixed(1)} ${_dataCOMMON.databasic.UNITSAP}';
      }

      ReportPDFcovvar.PIC01 = _dataCOMMON.databasic.PIC01;
      ReportPDFcovvar.PIC02 = _dataCOMMON.databasic.PIC02;

      ReportPDFcovvar.PICstd = _dataCOMMON.databasic.PICstd;

      ReportPDFcovvar.PASS = _dataCOMMON.databasic.PASS;
      // ReportPDFcovvar.remark = '';
      ReportPDFcovvar.remark = _dataCOMMON.databasic.remark;
      if (_dataCOMMON.databasic.PARTNAMEref != '') {
        ReportPDFcovvar.remark =
            'Reference data from\n${_dataCOMMON.databasic.PARTNAMEref}\n${_dataCOMMON.databasic.PARTref}';
      }

      ReportPDFcovvar.INC01 = _dataCOMMON.databasic.INC01;
      ReportPDFcovvar.INC02 = _dataCOMMON.databasic.INC02;
//remark

      // print(_dataCOMMON.datain[0]);
      // print(_dataCOMMON.datain.length);
      ReportPDFcovvar.rawlistHardness = [];
      ReportPDFcovvar.rawlistCompound = [];
      ReportPDFcovvar.rawlistRoughness = [];
      ReportPDFcovvar.rawlistCORE = [];

      ReportPDFcovvar.graphupper = [];
      ReportPDFcovvar.graphdata = [];
      ReportPDFcovvar.graphdata2 = [];
      ReportPDFcovvar.graphdata3 = [];
      ReportPDFcovvar.graphdata4 = [];
      ReportPDFcovvar.graphunder = [];

      for (var i = 0; i < _dataCOMMON.datain.length; i++) {
        String Loadin = '';
        if (_dataCOMMON.datain[i].LOAD != '' &&
            _dataCOMMON.datain[i].LOAD != '-') {
          Loadin = "( Load ${_dataCOMMON.datain[i].LOAD} )";
        }
        ReportPDFcovvar.datalist[i].ITEMname =
            " ${_dataCOMMON.datain[i].ITEMname} ${Loadin}";
        ReportPDFcovvar.datalist[i].SCMARK = _dataCOMMON.datain[i].SCMARK;
        ReportPDFcovvar.datalist[i].METHODname =
            _dataCOMMON.datain[i].METHODname;
        ReportPDFcovvar.datalist[i].FREQ = _dataCOMMON.datain[i].FREQ;
        ReportPDFcovvar.datalist[i].SPECIFICATIONname =
            _dataCOMMON.datain[i].SPECIFICATION;
        ReportPDFcovvar.datalist[i].RESULT = _dataCOMMON.datain[i].RESULT;
        ReportPDFcovvar.datalist[i].REMARK = _dataCOMMON.datain[i].Remark;

        String unitss = _dataCOMMON.datain[i].unitP;
        String unitss2 = _dataCOMMON.datain[i].unitPC;
        //print(ReportPDFcovvar.datalist[i].RESULT.length);
        //Surface Hardness

        // if (unitss == 'HRA') {
        //   unitss2 = 'HMV';
        // } else if (unitss == 'HRC') {
        //   unitss2 = 'HV';
        // } else if (unitss == 'Hv.') {
        //   unitss2 = 'HRA';
        // }
        // else
        // if (unitss == 'HRA') {
        //   unitss2 = '15N';
        // }

        if (_dataCOMMON.datain[i].TYPE == 'Number') {
          if (_dataCOMMON.datain[i].ITEMname.toUpperCase().contains('HARDNESS')
              //     &&
              // _dataCOMMON.datain[i].ITEMname.toUpperCase().contains('CORE') ==
              //     false
              ) {
            for (var li = 0;
                li < _dataCOMMON.datain[i].datapackset.length;
                li++) {
              // print(_dataCOMMON.datain[i].datapackset[li].dimensionX);

              if (_dataCOMMON.datain[i].datapackset[li].dimensionX == 0) {}
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 1) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '1',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA01c,
                  UNIT1: unitss,
                  UNIT2: unitss2,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '2',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA02c,
                  UNIT1: unitss,
                  UNIT2: unitss2,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '3',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA03c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '4',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA04c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '5',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA05c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '6',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA06c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '7',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA07c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '8',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA08c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '9',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA09c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '10',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA10c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '11',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA11c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '12',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA12c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '13',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA13c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '14',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA14c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '15',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA15c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '16',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA16c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '17',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA17c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '18',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA18c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '19',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA19c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                ReportPDFcovvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '20',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA20,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA20c,
                ));
              }
              HardnessNO++;
              // print('>>${HardnessNO}');
            }
          }

          // else if (_dataCOMMON.datain[i].ITEMname
          //     .toUpperCase()
          //     .contains('CORE')) {
          //   for (var li = 0;
          //       li < _dataCOMMON.datain[i].datapackset.length;
          //       li++) {
          //     // print(_dataCOMMON.datain[i].datapackset[li].dimensionX);
          //     print(_dataCOMMON.datain[i].datapackset[li]);
          //     print(_dataCOMMON.datain[i].datapackset[li].DATA01);
          //     print(_dataCOMMON.datain[i].datapackset[li].DATA02);
          //     print(_dataCOMMON.datain[i].datapackset[li].DATA03);

          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX == 0) {}
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 1) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '1',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
          //         UNIT1: unitss,
          //         UNIT2: unitss2,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '2',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
          //         UNIT1: unitss,
          //         UNIT2: unitss2,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '3',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '4',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '5',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '6',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '7',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '8',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '9',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '10',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '11',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '12',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '13',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '14',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '15',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '16',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '17',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '18',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '19',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
          //       ));
          //     }
          //     if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
          //       ReportPDFcovvar.rawlistCORE.add(rawlist(
          //         DATANO: CoreNO.toString(),
          //         DATAPCS: '20',
          //         DATA: _dataCOMMON.datain[i].datapackset[li].DATA20,
          //       ));
          //     }
          //     CoreNO++;
          //     // print('>>${CoreNO}');
          //   }
          // }
          //  CoreNO++;
        }

        if (_dataCOMMON.datain[i].TYPE == 'Graph') {
          ReportPDFcovvar.rawlistGraph = [];

          ReportPDFcovvar.GTC = _dataCOMMON.datain[i].GTC;
          ReportPDFcovvar.lower = _dataCOMMON.datain[i].lower;
          ReportPDFcovvar.upper = _dataCOMMON.datain[i].upper;
          if (_dataCOMMON.datain[i].ITEMname.contains('Hardness') ||
                  _dataCOMMON.datain[i].ITEMname.contains('hardness') ||
                  _dataCOMMON.datain[i].ITEMname.contains('Total') ||
                  _dataCOMMON.datain[i].ITEMname.contains('(Graph)')

              //
              ) {
            for (var li = 0;
                li < _dataCOMMON.datain[i].datapackset.length;
                li++) {
              // print(_dataCOMMON.datain[i].datapackset[li].dimensionX);

              if (_dataCOMMON.datain[i].datapackset[li].dimensionX == 0) {}
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 1) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA01p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA01p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA01))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA02p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA02p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA02))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA03p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA03p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA03))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA04p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA04p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA04))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA05p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA05p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA05))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA06p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA06p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA06))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA07p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA07p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA07))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA08p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA08p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA08))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA09p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA09p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA09))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA10p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA10p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA10))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA11p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA11p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA11))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA12p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA12p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA12))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA13p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA13p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA13))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA14p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA14p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA14))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA15p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA15p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA15))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA16p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA16p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA16))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA17p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA17p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA17))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA18p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA18p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA18))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA19p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA19p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA19))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                ReportPDFcovvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA20p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA20,
                ));

                ReportPDFcovvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA20p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA20))),
                );
              }
              GraphNO++;
              // print('>>${HardnessNO}');
            }
          }

          // ReportPDFcovvar.rawlistGraphCore = rawlist(
          //   DATAPCS: "Core",
          //   DATA: ReportPDFcovvar
          //       .rawlistGraph[ReportPDFcovvar.rawlistGraph.length - 1].DATA,
          // );
          // print(">>>${ReportPDFcovvar.rawlistGraph.length}");
          // ReportPDFcovvar.rawlistGraph.removeLast();
          if (ReportPDFcovvar.rawlistGraph.length > 2) {
            ReportPDFcovvar.rawlistGraphCore = rawlist(
              DATAPCS: "Core",
              DATA: ReportPDFcovvar
                  .rawlistGraph[ReportPDFcovvar.rawlistGraph.length - 1].DATA,
            );
            // print(">>>${ReportPDFcovvar.rawlistGraph.length}");

            ReportPDFcovvar.rawlistGraph
                .removeAt(ReportPDFcovvar.rawlistGraph.length - 1);
          }

          ReportPDFcovvar.graphupper = [
            FlSpot(ReportPDFcovvar.graphdata[0].x, 1000),
            FlSpot(
                ReportPDFcovvar
                    .graphdata[ReportPDFcovvar.graphdata.length - 2].x,
                1000)
          ];

          ReportPDFcovvar.graphdata2 = [
            FlSpot(ReportPDFcovvar.graphdata[0].x,
                double.parse(ConverstStr(_dataCOMMON.datain[i].Cross))),
            FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)),
                double.parse(ConverstStr(_dataCOMMON.datain[i].Cross)))
          ];

          ReportPDFcovvar.graphdata3 = [
            FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)),
                double.parse(ConverstStr(_dataCOMMON.datain[i].Cross))),
            FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)), 0)
          ];

          ReportPDFcovvar.graphdata4 = [
            FlSpot(ReportPDFcovvar.graphdata[0].x, 1000),
            FlSpot(ReportPDFcovvar.graphdata[0].x, 0)
          ];

          ReportPDFcovvar.graphunder = [
            FlSpot(ReportPDFcovvar.graphdata[0].x, 0),
            FlSpot(
                ReportPDFcovvar
                    .graphdata[ReportPDFcovvar.graphdata.length - 2].x,
                0)
          ];
        }

        if (ReportPDFcovvar.graphupper.length > 1) {
          ReportPDFcovvar.graphupper;
        }

        if (ReportPDFcovvar.graphdata2.length > 1) {
          ReportPDFcovvar.graphdata2;
        }
        if (ReportPDFcovvar.graphdata3.length > 1) {
          ReportPDFcovvar.graphdata3;
        }
        if (ReportPDFcovvar.graphdata4.length > 1) {
          ReportPDFcovvar.graphdata4;
        }
        if (ReportPDFcovvar.graphunder.length > 1) {
          ReportPDFcovvar.graphunder;
        }

        //Compound Layer

        // Roughness
      }
      if (ReportPDFcovvar.graphdata.length > 1) {
        ReportPDFcovvar.graphdata.removeLast();
        //     .removeAt(ReportPDFcovvar.graphdata.length - 1);
      }

      // print(ReportPDFcovvar.datalist);
    } else {
      ReportPDFcovvar.STATUS = 'WATTING or NO-DATA';

      ReportPDFcovvar.CUSTOMER = '';
      ReportPDFcovvar.PROCESS = '';
      ReportPDFcovvar.PARTNAME = '';
      ReportPDFcovvar.PARTNO = '';
      ReportPDFcovvar.PARTNO_s = '';
      ReportPDFcovvar.CUSLOT = '';
      ReportPDFcovvar.TPKLOT = '';
      ReportPDFcovvar.MATERIAL = '';
      ReportPDFcovvar.QTY = '';

      ReportPDFcovvar.PICstd = '';
      ReportPDFcovvar.PIC01 = '';
      ReportPDFcovvar.PIC02 = '';

      ReportPDFcovvar.rawlistHardness = [];
      ReportPDFcovvar.rawlistCompound = [];
      ReportPDFcovvar.rawlistRoughness = [];
      ReportPDFcovvar.rawlistCORE = [];
      ReportPDFcovvar.INC01 = '';
      ReportPDFcovvar.INC02 = '';

      ReportPDFcovvar.datalist = [
        ReportPDFcovlist(),
        ReportPDFcovlist(),
        ReportPDFcovlist(),
        ReportPDFcovlist(),
        ReportPDFcovlist(),
        ReportPDFcovlist(),
        ReportPDFcovlist(),
        ReportPDFcovlist(),
        ReportPDFcovlist(),
        ReportPDFcovlist(),
        ReportPDFcovlist(),
        ReportPDFcovlist(),
        ReportPDFcovlist(),
      ];

      ReportPDFcovvar.rawlistGraphCore = rawlist();

      ReportPDFcovvar.rawlistGraph = [];
      ReportPDFcovvar.graphupper = [];
      ReportPDFcovvar.graphdata = [];
      ReportPDFcovvar.graphdata2 = [];
      ReportPDFcovvar.graphdata3 = [];
      ReportPDFcovvar.graphdata4 = [];
      ReportPDFcovvar.graphunder = [];
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: ComInputText(
                  height: 40,
                  width: 200,
                  isContr: ReportPDFcovvar.iscontrol,
                  fnContr: (input) {
                    setState(() {
                      ReportPDFcovvar.iscontrol = input;
                    });
                  },
                  isEnabled: ReportPDFcovvar.canf,
                  sValue: ReportPDFcovvar.PO,
                  returnfunc: (String s) {
                    ReportPDFcovvar.PO = s;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    if (ReportPDFcovvar.PO != '') {
                      context
                          .read<ReportPDFCommon_Cubit>()
                          .ReportPDFCommonCubit(ReportPDFcovvar.PO, "cov");
                    }
                  },
                  child: Container(
                    color: Colors.black,
                    height: 40,
                    width: 40,
                    child: const Center(
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    context.read<ReportPDFCommon_Cubit>().Flush();
                    ReportPDFcovvar.canf = true;
                    ReportPDFcovvar.iscontrol = true;
                    ReportPDFcovvar.PO = '';
                    setState(() {});
                  },
                  child: Container(
                    color: Colors.red,
                    height: 40,
                    width: 100,
                    child: const Center(
                      child: Text("CLEAR"),
                    ),
                  ),
                ),
              ),
              InkWell(
                onDoubleTap: () {
                  //  ReportPDFcovvar.HIDEDATAPIC
                  if (ReportPDFcovvar.HIDEDATAPIC) {
                    ReportPDFcovvar.HIDEDATAPIC = false;
                  } else {
                    ReportPDFcovvar.HIDEDATAPIC = true;
                  }
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    color: ReportPDFcovvar.STATUS == 'REPORT READY'
                        ? Colors.green
                        : Colors.yellow,
                    height: 40,
                    width: 200,
                    child: Center(
                      child: Text(ReportPDFcovvar.STATUS),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: SizedBox(
                  height: 40,
                  width: 150,
                  child: AdvanceDropDown(
                    imgpath: 'assets/icons/icon-down_4@3x.png',
                    listdropdown: const [
                      MapEntry("-", "-"),
                      MapEntry("General", "1"),
                      MapEntry("JTEKT", "2"),
                      MapEntry("NTN122-4-7", "3"),
                      MapEntry("TBKK", "4"),
                      MapEntry("GKN", "5"),
                      MapEntry("SIAMADVANCE", "6"),
                      MapEntry("NTN500T850T", "7"),
                    ],
                    onChangeinside: (d, v) {
                      // print(d);
                      ReportPDFcovvar.TYPE = d;
                      if (d == '1') {
                        setState(() {
                          ReportPDFcovvar.SCMASKTYPE = imgGeneral;
                          ReportPDFcovvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '2') {
                        setState(() {
                          ReportPDFcovvar.SCMASKTYPE = imgJTEKT;
                          ReportPDFcovvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '3') {
                        setState(() {
                          ReportPDFcovvar.SCMASKTYPE = imgNTN;
                          ReportPDFcovvar.SCMASKTYPEonTop = imgNTNonH;
                        });
                      } else if (d == '4') {
                        setState(() {
                          ReportPDFcovvar.SCMASKTYPE = imgTBKK;
                          ReportPDFcovvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '5') {
                        setState(() {
                          ReportPDFcovvar.SCMASKTYPE = imgGKN;
                          ReportPDFcovvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '6') {
                        setState(() {
                          ReportPDFcovvar.SCMASKTYPE = SIAMADVANCE;
                          ReportPDFcovvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '7') {
                        setState(() {
                          ReportPDFcovvar.SCMASKTYPE = NTN500T850T;
                          ReportPDFcovvar.SCMASKTYPEonTop = NTN500T850T;
                        });
                      } else {
                        setState(() {
                          ReportPDFcovvar.SCMASKTYPE = imgGeneral;
                          ReportPDFcovvar.SCMASKTYPEonTop = '';
                        });
                      }
                    },
                    value: ReportPDFcovvar.TYPE,
                    height: 40,
                    width: 100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: ComInputText(
                  height: 40,
                  width: 200,
                  isContr: ReportPDFcovvar.iscontrol,
                  fnContr: (input) {
                    setState(() {
                      ReportPDFcovvar.iscontrol = input;
                    });
                  },
                  sPlaceholder: "Inspected By",
                  sValue: ReportPDFcovvar.SignInsBy,
                  returnfunc: (String s) {
                    setState(() {
                      ReportPDFcovvar.SignInsBy = s;
                    });
                  },
                ),
              ),
              const Spacer(),
              // if (ReportPDFcovvar.PASS == "PASSED") ...[
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    PDFloader(context);
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      // capture(
                      captureToback(
                        // capture(
                        _globalKey,
                        ReportPDFcovvar.PO,
                      ).then((value) {
                        print(value);

                        Navigator.pop(context);
                      });
                    });
                  },
                  child: Container(
                    color: Colors.yellow,
                    height: 50,
                    width: 100,
                    child: const Center(
                      child: Text("Print"),
                    ),
                  ),
                ),
              ),
              // ] else ...[
              //   if (USERDATA.UserLV > 5 &&
              //       _dataCOMMON.databasic.USER_STATUS == 'QCFN') ...[
              //     Padding(
              //       padding: const EdgeInsets.all(3.0),
              //       child: InkWell(
              //         onTap: () {
              //           PDFloader(context);
              //           Future.delayed(const Duration(milliseconds: 1000), () {
              //             // capture(
              //             captureToback(
              //               // capture(
              //               _globalKey,
              //               ReportPDFcovvar.PO,
              //             ).then((value) {
              //               print(value);

              //               Navigator.pop(context);
              //             });
              //           });
              //         },
              //         child: Container(
              //           color: Colors.yellow,
              //           height: 50,
              //           width: 100,
              //           child: const Center(
              //             child: Text("Print"),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ]
              // ],
            ],
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: InkWell(
                onTap: () {
                  P303QMMASTERQCVAR.SETDAY = 'OK';
                  P303QMMASTERQCVAR.SEARCH = ReportPDFcovvar.PO;
                  var now = DateTime.now().subtract(Duration(days: 25));
                  P303QMMASTERQCVAR.day = DateFormat('dd').format(now);
                  P303QMMASTERQCVAR.month = DateFormat('MM').format(now);
                  P303QMMASTERQCVAR.year = DateFormat('yyyy').format(now);
                  STDreport2(context);
                },
                child: Container(
                  color: Colors.yellow,
                  height: 50,
                  width: 100,
                  child: const Center(
                    child: Text("UD and QCFN"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: InkWell(
                onTap: () {
                  //ReportPDFcovvar.PO
                  QCFN(context);
                },
                child: Container(
                  color: Colors.yellow,
                  height: 50,
                  width: 100,
                  child: const Center(
                    child: Text("QCFN"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: InkWell(
                onTap: () {
                  //ReportPDFcovvar.PO
                  String server = 'http://172.23.10.40:1885/';
                  String sap = "sap_GASHES_GB";

                  Dio().post(
                    server + sap,
                    data: {},
                  ).then((v) {
                    //
                    var databuff = v.data;
                    for (var i = 0; i < databuff.length; i++) {
                      //

                      if (databuff[i]['PO'] == ReportPDFcovvar.PO) {
                        print(
                            databuff[i]['PO'] + ':' + databuff[i]['FG_CHARG']);
                        // print(databuff[i]);
                        ReportPDFcovvar.TPKLOTEDIT = databuff[i]['FG_CHARG'];
                        setState(() {});
                      }
                    }
                  });
                },
                child: Container(
                  color: Colors.orange,
                  height: 50,
                  width: 100,
                  child: const Center(
                    child: Text("Re Lot"),
                  ),
                ),
              ),
            ),
          ]),

//QCFN
          //STDreport2
          // Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 60),
          //       child: ComInputText(
          //         sLabel: "Remark",
          //         height: 40,
          //         width: 500,
          //         nLimitedChar: 500,
          //         isContr: ReportPDFcovvar.iscontrol,
          //         fnContr: (input) {
          //           setState(() {
          //             ReportPDFcovvar.iscontrol = input;
          //           });
          //         },
          //         // isEnabled: ReportPDFcovvar.canf,
          //         sValue: ReportPDFcovvar.remark,
          //         returnfunc: (String s) {
          //           setState(() {
          //             ReportPDFcovvar.remark = s;
          //           });
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                RepaintBoundary(
                  key: _globalKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // const SizedBox(
                          //   width: 50,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              height: 2000,
                              width: 1364,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 3),
                                // color: Colors.red,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(0)),
                              ),
                              child: Column(
                                children: [
                                  headerreport(
                                    CUSTOMER: ReportPDFcovvar.CUSTOMER,
                                    PROCESS: ReportPDFcovvar.PROCESS,
                                    PARTNAME: ReportPDFcovvar.PARTNAME,
                                    PARTNO: ReportPDFcovvar.PARTNO.contains("|")
                                        ? ReportPDFcovvar.PARTNO.split("|")[1]
                                        : ReportPDFcovvar.PARTNO == ''
                                            ? ReportPDFcovvar.PARTNO_s
                                            : ReportPDFcovvar.PARTNO,
                                    CUSLOT: ReportPDFcovvar.CUSLOT,
                                    TPKLOT: ReportPDFcovvar.TPKLOT,
                                    MATERIAL: ReportPDFcovvar.MATERIAL,
                                    QTY: ReportPDFcovvar.QTY,
                                  ),
                                  HEAD1SLOT(
                                    widget01: const Center(
                                      child: Text(
                                        "INCOMING INSPECTION",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  HEAD7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: const Center(
                                      child: Text(
                                        "ITEM",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget02: const Center(
                                      child: Text(
                                        "SC",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget03: const Center(
                                      child: Text(
                                        "Check Method",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget04: const Center(
                                      child: Text(
                                        "Frequency",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget05: const Center(
                                      child: Text(
                                        "Specification",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget06: const Center(
                                      child: Text(
                                        "Result",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget07: const Center(
                                      child: Text(
                                        "Remark",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: const [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFcovvar.INC01 != ''
                                            ? "Appearance for Rust"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: const Center(
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFcovvar.INC01 != ''
                                            ? "Visual"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFcovvar.INC01 != ''
                                            ? "10 pcs/rcv.Lot"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFcovvar.INC01 != ''
                                            ? "No Rust"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFcovvar.INC01 != ''
                                            ? "No Rust"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget07: const Center(
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFcovvar.INC02 != ''
                                            ? "Appearance for scratch"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: Text(
                                        ReportPDFcovvar.INC02 != '' ? "" : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFcovvar.INC02 != ''
                                            ? "Visual"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFcovvar.INC02 != ''
                                            ? "10 pcs/rcv.Lot"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFcovvar.INC02 != ''
                                            ? "No Scratch"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFcovvar.INC02 != ''
                                            ? "No Scratch"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget07: const Center(
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  HEAD1SLOT(
                                    widget01: const Center(
                                      child: Text(
                                        "FINAL INSPECTION",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  HEAD7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: const Center(
                                      child: Text(
                                        "ITEM",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget02: const Center(
                                      child: Text(
                                        "SC",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget03: const Center(
                                      child: Text(
                                        "Check Method",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget04: const Center(
                                      child: Text(
                                        "Frequency",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget05: const Center(
                                      child: Text(
                                        "Specification",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget06: const Center(
                                      child: Text(
                                        "Result",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget07: const Center(
                                      child: Text(
                                        "Remark",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[0].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFcovvar
                                                  .datalist[0].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFcovvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[0].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[0].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFcovvar
                                            .datalist[0].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar
                                                      .datalist[0]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[0].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[0]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[0].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[0]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[1].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFcovvar
                                                  .datalist[1].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFcovvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[1].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[1].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFcovvar
                                            .datalist[1].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar
                                                      .datalist[1]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[1].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[1]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[1].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[1]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[2].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFcovvar
                                                  .datalist[2].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFcovvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[2].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[2].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFcovvar
                                            .datalist[2].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar
                                                      .datalist[2]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[2].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[2]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[2].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[2]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[3].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFcovvar
                                                  .datalist[3].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFcovvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[3].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[3].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFcovvar
                                            .datalist[3].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar
                                                      .datalist[3]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[3].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[3]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[3].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[3]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[4].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFcovvar
                                                  .datalist[4].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFcovvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[4].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[4].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFcovvar
                                            .datalist[4].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar
                                                      .datalist[4]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[4].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[4]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[4].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[4]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[5].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFcovvar
                                                  .datalist[5].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFcovvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[5].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[5].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFcovvar
                                            .datalist[5].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar
                                                      .datalist[5]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[5].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[5]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[5].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[5]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[6].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFcovvar
                                                  .datalist[6].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFcovvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[6].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[6].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFcovvar
                                            .datalist[6].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar
                                                      .datalist[6]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[6].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[6]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFcovvar.datalist[7].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFcovvar.datalist[7]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          children: [
                                            HEAD16SLOT(
                                              ListFlex: S16slot,
                                              widget01: const Center(
                                                child: Text(
                                                  "SAMPLE NO.",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget02: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[0]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget03: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[1]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget04: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[2]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget05: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[3]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget06: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[4]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget07: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[5]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget08: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[6]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget09: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[7]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget10: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[8]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget11: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[9]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget12: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[10]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget13: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[11]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget14: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[12]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget15: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[13]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget16: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[14]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            BODY16SLOT(
                                              ListFlex: S16slot,
                                              widget01: const Center(
                                                child: Text(
                                                  "POINT NO.",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget02: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[0]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget03: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[1]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget04: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[2]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget05: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[3]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget06: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[4]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget07: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[5]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget08: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[6]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget09: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[7]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget10: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[8]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget11: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[9]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget12: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[10]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget13: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[11]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget14: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[12]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget15: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[13]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget16: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[14]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            BODY16SLOT(
                                              ListFlex: S16slot,
                                              widget01: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >
                                                          0
                                                      ? "Surface Hardness (${ReportPDFcovvar.rawlistHardness[0].UNIT1})"
                                                      : "",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget02: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[0]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget03: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[1]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget04: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[2]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget05: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[3]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget06: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[4]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget07: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[5]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget08: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[6]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget09: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[7]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget10: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[8]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget11: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[9]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget12: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[10]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget13: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[11]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget14: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[12]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget15: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[13]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget16: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[14]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            BODY16SLOT(
                                              ListFlex: S16slot,
                                              widget01: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >
                                                          0
                                                      ? "Surface Hardness (${ReportPDFcovvar.rawlistHardness[0].UNIT2})"
                                                      : "",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget02: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[0]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget03: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[1]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget04: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[2]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget05: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[3]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget06: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[4]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget07: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[5]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget08: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[6]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget09: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[7]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget10: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[8]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget11: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[9]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget12: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[10]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget13: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[11]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget14: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[12]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget15: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[13]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget16: Center(
                                                child: Text(
                                                  ReportPDFcovvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDFcovvar
                                                          .rawlistHardness[14]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Expanded(
                                      //   flex: 2,
                                      //   child: Column(
                                      //     children: [
                                      //       HEAD2SLOT(
                                      //         ListFlex: [2, 1, 1, 1, 1, 1],
                                      //         widget01: const Center(
                                      //           child: Text(
                                      //             "SAMPLE NO.",
                                      //             style: TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         widget02: Center(
                                      //           child: Text(
                                      //             ReportPDFcovvar
                                      //                         .rawlistCORE.length >=
                                      //                     1
                                      //                 ? ReportPDFcovvar
                                      //                     .rawlistCORE[0].DATANO
                                      //                 : '',
                                      //             style: const TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       BODY2SLOT(
                                      //         ListFlex: [2, 1, 1, 1, 1, 1],
                                      //         widget01: const Center(
                                      //           child: Text(
                                      //             "POINT NO.",
                                      //             style: TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         widget02: Center(
                                      //           child: Text(
                                      //             ReportPDFcovvar
                                      //                         .rawlistCORE.length >=
                                      //                     1
                                      //                 ? ReportPDFcovvar
                                      //                     .rawlistCORE[0].DATAPCS
                                      //                 : '',
                                      //             style: const TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         // widget03: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFcovvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             2
                                      //         //         ? ReportPDFcovvar
                                      //         //             .rawlistCORE[1].DATAPCS
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //         // widget04: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFcovvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             3
                                      //         //         ? ReportPDFcovvar
                                      //         //             .rawlistCORE[2].DATAPCS
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //         // widget05: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFcovvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             4
                                      //         //         ? ReportPDFcovvar
                                      //         //             .rawlistCORE[3].DATAPCS
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //         // widget06: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFcovvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             5
                                      //         //         ? ReportPDFcovvar
                                      //         //             .rawlistCORE[4].DATAPCS
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //       ),
                                      //       BODY2SLOT(
                                      //         ListFlex: [2, 1, 1, 1, 1, 1],
                                      //         widget01: const Center(
                                      //           child: Text(
                                      //             "CORE",
                                      //             style: TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         widget02: Center(
                                      //           child: Text(
                                      //             ReportPDFcovvar
                                      //                         .rawlistCORE.length >=
                                      //                     1
                                      //                 ? ReportPDFcovvar
                                      //                     .rawlistCORE[0].DATA
                                      //                 : '',
                                      //             style: const TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         // widget03: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFcovvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             2
                                      //         //         ? ReportPDFcovvar
                                      //         //             .rawlistCORE[1].DATA
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //         // widget04: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFcovvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             3
                                      //         //         ? ReportPDFcovvar
                                      //         //             .rawlistCORE[2].DATA
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //         // widget05: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFcovvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             4
                                      //         //         ? ReportPDFcovvar
                                      //         //             .rawlistCORE[3].DATA
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //         // widget06: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFcovvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             5
                                      //         //         ? ReportPDFcovvar
                                      //         //             .rawlistCORE[4].DATA
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  // PICSLO2SIDEGRAPH(
                                  //   // PIC01: _dataCOMMON.databasic.PIC01,
                                  //   // PIC02: _dataCOMMON.databasic.PIC02 == wpic
                                  //   //     ? _dataCOMMON.databasic.PIC03
                                  //   //     : _dataCOMMON.databasic.PIC02,
                                  //   // PIC01: "",
                                  //   // PIC02: "",
                                  //   PIC01: ReportPDFcovvar.HIDEDATAPIC
                                  //       ? ""
                                  //       : _dataCOMMON.databasic.PIC01,
                                  //   PIC02: ReportPDFcovvar.HIDEDATAPIC
                                  //       ? ""
                                  //       : _dataCOMMON.databasic.PIC02,
                                  //   widget01: Column(
                                  //     children: [
                                  //       Padding(
                                  //         padding: const EdgeInsets.only(
                                  //             left: 10, bottom: 10),
                                  //         child: Container(
                                  //           height: 320,
                                  //           decoration: BoxDecoration(
                                  //             border: Border.all(
                                  //                 color: Colors.black,
                                  //                 width: 3),
                                  //           ),
                                  //           child: ReportPDFcovvar
                                  //                   .graphdata.isNotEmpty
                                  //               ? ControlChart01(
                                  //                   upper: ReportPDFcovvar
                                  //                       .graphupper,
                                  //                   data: ReportPDFcovvar
                                  //                       .graphdata,
                                  //                   data2: ReportPDFcovvar
                                  //                       .graphdata2,
                                  //                   data3: ReportPDFcovvar
                                  //                       .graphdata3,
                                  //                   data4: ReportPDFcovvar
                                  //                       .graphdata4,
                                  //                   under: ReportPDFcovvar
                                  //                       .graphunder,
                                  //                 )
                                  //               : SizedBox(
                                  //                   height: 320,
                                  //                   width: 2000,
                                  //                 ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  //   widget02: Column(
                                  //     children: [
                                  //       HEAD16SLOT(
                                  //         ListFlex: S16slot,
                                  //         widget01: const Center(
                                  //           child: Text(
                                  //             "Depth (mm.)",
                                  //             style: TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget02: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     1
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[0].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget03: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     2
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[1].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget04: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     3
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[2].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget05: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     4
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[3].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget06: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     5
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[4].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget07: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     6
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[5].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget08: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     7
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[6].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget09: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     8
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[7].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget10: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     9
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[8].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget11: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     10
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[9].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget12: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     11
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[10].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget13: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     12
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[11].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget14: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     13
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[12].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget15: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     14
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[13].DATAPCS
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget16: const Center(
                                  //           child: Text(
                                  //             "CORE",
                                  //             // ReportPDFcovvar
                                  //             //     .rawlistGraphCore.DATAPCS,
                                  //             style: TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       BODY16SLOT(
                                  //         ListFlex: S16slot,
                                  //         widget01: const Center(
                                  //           child: Text(
                                  //             "Hardness",
                                  //             style: TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget02: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     1
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[0].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget03: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     2
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[1].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget04: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     3
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[2].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget05: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     4
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[3].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget06: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     5
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[4].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget07: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     6
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[5].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget08: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     7
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[6].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget09: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     8
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[7].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget10: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     9
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[8].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget11: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     10
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[9].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget12: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     11
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[10].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget13: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     12
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[11].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget14: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     13
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[12].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget15: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar.rawlistGraph
                                  //                         .length >=
                                  //                     14
                                  //                 ? ReportPDFcovvar
                                  //                     .rawlistGraph[13].DATA
                                  //                 : '',
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         widget16: Center(
                                  //           child: Text(
                                  //             ReportPDFcovvar
                                  //                 .rawlistGraphCore.DATA,
                                  //             style: const TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  PICSLO2SIDEGRAPH(
                                    // PIC01: _dataCOMMON.databasic.PIC01,
                                    // PIC02: _dataCOMMON.databasic.PIC02 == wpic
                                    //     ? _dataCOMMON.databasic.PIC03
                                    //     : _dataCOMMON.databasic.PIC02,
                                    PIC01: ReportPDFcovvar.HIDEDATAPIC
                                        ? ""
                                        : _dataCOMMON.databasic.PIC01,
                                    PIC02: ReportPDFcovvar.HIDEDATAPIC
                                        ? ""
                                        : _dataCOMMON.databasic.PIC02,
                                    widget01: Column(
                                      children: [
                                        if (ReportPDFcovvar.GTC == '' ||
                                            ReportPDFcovvar.GTC == '-') ...[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, bottom: 10),
                                            child: Container(
                                              height: 320,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 3),
                                              ),
                                              child: ReportPDFcovvar
                                                      .graphdata.isNotEmpty
                                                  ? ControlChart01(
                                                      upper: ReportPDFcovvar
                                                          .graphupper,
                                                      data: ReportPDFcovvar
                                                          .graphdata,
                                                      data2: ReportPDFcovvar
                                                          .graphdata2,
                                                      data3: ReportPDFcovvar
                                                          .graphdata3,
                                                      data4: ReportPDFcovvar
                                                          .graphdata4,
                                                      under: ReportPDFcovvar
                                                          .graphunder,
                                                    )
                                                  : SizedBox(
                                                      height: 320,
                                                      width: 2000,
                                                    ),
                                            ),
                                          ),
                                        ] else ...[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, bottom: 10),
                                            child: Container(
                                              height: 320,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 3),
                                              ),
                                              child: ReportPDFcovvar
                                                      .graphdata.isNotEmpty
                                                  ? LineGraphCONTROL(
                                                      upper: ReportPDFcovvar
                                                          .graphupper,
                                                      data: ReportPDFcovvar
                                                          .graphdata,
                                                      data2: ReportPDFcovvar
                                                          .graphdata2,
                                                      data3: ReportPDFcovvar
                                                          .graphdata3,
                                                      data4: ReportPDFcovvar
                                                          .graphdata4,
                                                      under: ReportPDFcovvar
                                                          .graphunder,
                                                      //----------------------
                                                      // data_2: ReportPDFcovvar
                                                      //     .graphdataS,
                                                      // data_2: [
                                                      //   FlSpot(0.1, 800),
                                                      //   // FlSpot(0.2, 750),
                                                      //   FlSpot(0.3, 780),
                                                      //   // FlSpot(0.4, 660),
                                                      //   FlSpot(0.5, 760),
                                                      //   // FlSpot(0.6, 700),
                                                      //   // FlSpot(0.7, 550),
                                                      //   // FlSpot(0.8, 650),
                                                      //   FlSpot(0.9, 670),
                                                      //   // FlSpot(1, 500)
                                                      // ],
                                                      data_2:
                                                          ReportPDFcovvar.lower,
                                                      // data2_2:
                                                      //     ReportPDFcovvar
                                                      //         .graphdata2S,
                                                      // data3_2:
                                                      //     ReportPDFcovvar
                                                      //         .graphdata3S,
                                                      //----------------------
                                                      // data_3: ReportPDFcovvar
                                                      //     .graphdataSS,
                                                      data_3:
                                                          ReportPDFcovvar.upper,
                                                      // data2_3:
                                                      //     ReportPDFcovvar
                                                      //         .graphdata2SS,
                                                      // data3_3:
                                                      //     ReportPDFcovvar
                                                      //         .graphdata3SS,
                                                      //----------------------
                                                      // data_4: ReportPDFcovvar
                                                      //     .graphdataSSS,
                                                      // data2_4:
                                                      //     ReportPDFcovvar
                                                      //         .graphdata2SSS,
                                                      // data3_4:
                                                      //     ReportPDFcovvar
                                                      //         .graphdata3SSS,
                                                      //----------------------
                                                    )
                                                  : SizedBox(
                                                      height: 320,
                                                      width: 2000,
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    widget02: Column(
                                      children: [
                                        HEAD16SLOT(
                                          ListFlex: S16slot,
                                          widget01: const Center(
                                            child: Text(
                                              "Depth (mm.)",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget02: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      1
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[0].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget03: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      2
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[1].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget04: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      3
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[2].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget05: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      4
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[3].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget06: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      5
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[4].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget07: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      6
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[5].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget08: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      7
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[6].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget09: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      8
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[7].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget10: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      9
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[8].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget11: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      10
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[9].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget12: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      11
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[10].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget13: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      12
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[11].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget14: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      13
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[12].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget15: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      14
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[13].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget16: const Center(
                                            child: Text(
                                              "CORE",
                                              // ReportPDFcovvar
                                              //     .rawlistGraphCore.DATAPCS,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        BODY16SLOT(
                                          ListFlex: S16slot,
                                          widget01: const Center(
                                            child: Text(
                                              "Hardness",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget02: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      1
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[0].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget03: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      2
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[1].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget04: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      3
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[2].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget05: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      4
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[3].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget06: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      5
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[4].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget07: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      6
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[5].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget08: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      7
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[6].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget09: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      8
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[7].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget10: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      9
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[8].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget11: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      10
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[9].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget12: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      11
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[10].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget13: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      12
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[11].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget14: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      13
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[12].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget15: Center(
                                            child: Text(
                                              ReportPDFcovvar.rawlistGraph
                                                          .length >=
                                                      14
                                                  ? ReportPDFcovvar
                                                      .rawlistGraph[13].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget16: Center(
                                            child: Text(
                                              ReportPDFcovvar
                                                  .rawlistGraphCore.DATA,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  TAILSLOT(
                                    PASS: ReportPDFcovvar.PASS,
                                    PICS: _dataCOMMON.databasic.PICstd,
                                    Remark: ReportPDFcovvar.remark,
                                    signs: true,
                                    NAME01:
                                        _dataCOMMON.databasic.Inspected_sign,
                                    NAME02: _dataCOMMON.databasic.Check_sign,
                                    NAME03: _dataCOMMON.databasic.Approve_sign,
                                    NAME01date: _dataCOMMON
                                                .databasic.dateInspected !=
                                            ''
                                        ? DateFormat('dd/MM/yyyy').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(ConverstStr(
                                                        _dataCOMMON.databasic
                                                            .dateInspected)) *
                                                    1))
                                        : "",
                                    NAME02date: _dataCOMMON
                                                .databasic.dateCheck !=
                                            ''
                                        ? DateFormat('dd/MM/yyyy').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(ConverstStr(
                                                        _dataCOMMON.databasic
                                                            .dateCheck) *
                                                    1)))
                                        : "",
                                    NAME03date: _dataCOMMON
                                                .databasic.dateApprove !=
                                            ''
                                        ? DateFormat('dd/MM/yyyy').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(ConverstStr(
                                                        _dataCOMMON.databasic
                                                            .dateApprove) *
                                                    1)))
                                        : "",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    if ((USERDATA.UserLV) > 1) ...[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            if (_dataCOMMON.databasic.Inspected == '') {
                              Dio().post(
                                options: Options(
                                  // contentType: "application/json",

                                  headers: {
                                    "server": "BP12-GAS",
                                  },
                                ),
                                GLOserverMASTER + "Inspected-sign",
                                data: {
                                  "ID": USERDATA.ID,
                                  "PO": ReportPDFcovvar.PO,
                                },
                              ).then((v) {
                                var databuff = v.data;
                                context
                                    .read<ReportPDFCommon_Cubit>()
                                    .ReportPDFCommonCubit(
                                        ReportPDFcovvar.PO, "");
                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            color: _dataCOMMON.databasic.Inspected == ''
                                ? Colors.blue
                                : Colors.red,
                            child: Center(
                              child: Text("Inspected"),
                            ),
                          ),
                        ),
                      ),
                    ],
                    if ((USERDATA.UserLV) > 20) ...[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            if (_dataCOMMON.databasic.Check == '' &&
                                _dataCOMMON.databasic.Inspected != '') {
                              Dio().post(
                                options: Options(
                                  // contentType: "application/json",

                                  headers: {
                                    "server": "BP12-GAS",
                                  },
                                ),
                                GLOserverMASTER + "Check-sign",
                                data: {
                                  "ID": USERDATA.ID,
                                  "PO": ReportPDFcovvar.PO,
                                },
                              ).then((v) {
                                var databuff = v.data;
                                context
                                    .read<ReportPDFCommon_Cubit>()
                                    .ReportPDFCommonCubit(
                                        ReportPDFcovvar.PO, "");
                              });
                            } else {
                              if (_dataCOMMON.databasic.Inspected == '') {
                                WORNINGpop(
                                    context,
                                    ["", "Please Inspected first", ""],
                                    60,
                                    200);
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            color: _dataCOMMON.databasic.Check == ''
                                ? Colors.blue
                                : Colors.red,
                            child: Center(
                              child: Text("Check"),
                            ),
                          ),
                        ),
                      ),
                    ],
                    if ((USERDATA.UserLV) > 30) ...[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            if (_dataCOMMON.databasic.Approve == '' &&
                                _dataCOMMON.databasic.Check != '' &&
                                _dataCOMMON.databasic.Inspected != '') {
                              Dio().post(
                                options: Options(
                                  // contentType: "application/json",

                                  headers: {
                                    "server": "BP12-GAS",
                                  },
                                ),
                                GLOserverMASTER + "Approve-sign",
                                data: {
                                  "ID": USERDATA.ID,
                                  "PO": ReportPDFcovvar.PO,
                                },
                              ).then((v) {
                                var databuff = v.data;
                                context
                                    .read<ReportPDFCommon_Cubit>()
                                    .ReportPDFCommonCubit(
                                        ReportPDFcovvar.PO, "");
                              });
                            } else {
                              if (_dataCOMMON.databasic.Inspected == '') {
                                WORNINGpop(
                                    context,
                                    ["", "Please Inspected first", ""],
                                    60,
                                    200);
                              } else if (_dataCOMMON.databasic.Check == '') {
                                WORNINGpop(context,
                                    ["", "Please Check first", ""], 60, 200);
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            color: _dataCOMMON.databasic.Approve == ''
                                ? Colors.blue
                                : Colors.red,
                            child: Center(
                              child: Text("Approve"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 50,
          ),
        ],
      ),
    );
  }
}

List<int> S16slot = const [
  3,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1
];

void STDreport2(
  BuildContext contextin,
) {
  showDialog(
    context: contextin,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          height: 1000,
          width: 1500,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Page303(),
            ),
          ),
        ),
      );
    },
  );
}

void QCFN(BuildContext contextin) {
  showDialog(
    context: contextin,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        child: QCFNWD(),
      );
    },
  );
}

class QCFNWD extends StatefulWidget {
  const QCFNWD({super.key});

  @override
  State<QCFNWD> createState() => QCFNWDState();
}

class QCFNWDState extends State<QCFNWD> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 600,
      child: Center(
        child: SizedBox(
          child: InkWell(
            onTap: () {
              print("00" + ReportPDFcovvar.PO);
              Dio().post(
                "${server2}10GETDATAFROMJOBBINGAQC/QCFN",
                // "${'http://127.0.0.1:14094/'}10GETDATAFROMJOBBINGAQC/QCFN",
                data: {
                  "BAPI_NAME": "ZFMPPQCFN_IN",
                  "ORDERID": ReportPDFcovvar.PO,
                  "PERNR_ID": USERDATA.ID
                },
              ).then((v) {
                Navigator.pop(context);

                //
                print(v.data);
                if (v.data['ExportParameter'] != null) {
                  if (v.data['ExportParameter']['INACT_NEW'].toString() ==
                      'E') {
                    showErrorPopup(context, v.data.toString());
                  } else {
                    showGoodPopup(context, v.data.toString());
                  }
                } else {
                  showErrorPopup(context, v.data.toString());
                }
              });
            },
            child: Container(
              width: 400,
              height: 100,
              color: Colors.blue,
              child: Center(
                child: Text("QCFN"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
