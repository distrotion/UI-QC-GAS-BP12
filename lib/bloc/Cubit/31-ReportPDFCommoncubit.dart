import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/ACTtestdata.dart';
import '../../data/CommonTestData.dart';
import '../../data/global.dart';
import '../../page/P31ReportPDFcommon/ReportPDFCommonvar.dart';
import '../../widget/common/Safty.dart';
import '../../widget/common/imgset.dart';

String server = 'http://172.23.10.40:16700/';
// String server = 'http://127.0.0.1:16700/';

class ReportPDFCommon_Cubit extends Cubit<CommonReportOutput> {
  ReportPDFCommon_Cubit()
    : super(CommonReportOutput(databasic: BasicCommonDATA()));

  Future<void> ReportPDFCommonCubit(String PO, String covs) async {
    CommonReportOutput output = CommonReportOutput(
      databasic: BasicCommonDATA(),
    );
    BasicCommonDATA BasicCommonDATAs = BasicCommonDATA();
    List<String> passlist = [];

    final response = await Dio().post(
      server + "BP12G_TEST_Report_PDF",
      data: {"PO": PO},
    );

    if (response.statusCode == 200) {
      var databuff = response.data;
      // var databuff = test01;
      // print("----------------->");
      // print(databuff['PATTERN'][0]['reportset']);
      // print("----------------->>");
      //commontest04
      // var databuff = ACTtestdata01;

      String setps1 = "PO3";
      String setps2 = "PO5";
      if (covs == "covs") {
        setps1 = "PO5";
        setps2 = "PO3";
      }

      if (databuff['DATA'] != null && (databuff['DATA']?.length ?? 0) != 0) {
        var FINALANSdata = databuff['DATA']?[0]['FINAL_ANS'] ?? {};
        var FINALdata = databuff['DATA']?[0]['FINAL'] ?? {};
        var PATTERNlist = databuff['PATTERN']?[0] ?? {};

        var FINALCHECKlist = databuff['DATA']?[0]['CHECKlist'] ?? [];
        var TYPElist = databuff['TYPE'] ?? [];
        var ITEMSlist = databuff['ITEMS'] ?? [];
        var METHODlist = databuff['METHOD'] ?? [];
        var RESULTFORMATlist = databuff['RESULTFORMAT'] ?? [];
        var GRAPHTYPElist = databuff['GRAPHTYPE'] ?? [];
        var INSTRUMENTSlist = databuff['INSTRUMENTS'] ?? [];
        var CALCULATElist = databuff['INSTRUMENTS'] ?? [];
        var SPECIFICATIONlist = databuff['SPECIFICATION'] ?? [];
        var UNITlist = databuff['UNIT'] ?? [];
        var DESIMALlist = databuff['DESIMAL'] ?? [];

        var GTClist = databuff['GTC'] ?? [];

        int NO_NUMBER = 0;

        var BasicDATAr = databuff['DATA']?[0];
        List<FINALCHECKlistCommonClass> ITEMlist = [];

        List<String> MACHINElist = [];
        FINALdata.forEach((key, value) {
          MACHINElist.add(key);
        });

        // print(PATTERNlist);

        String inc01 = "";
        String inc02 = "";

        if (databuff["PATTERN"][0]['INCOMMING'] != null) {
          for (var i = 0; i < databuff["PATTERN"][0]['INCOMMING'].length; i++) {
            if (i == 0) {
              inc01 = databuff["PATTERN"][0]['INCOMMING'][0]["ITEMs"];
            }
            if (i == 1) {
              inc02 = databuff["PATTERN"][0]['INCOMMING'][1]["ITEMs"];
            }
          }
        }

        BasicCommonDATAs = BasicCommonDATA(
          reportset: databuff['PATTERN'][0]['reportset'] != null
              ? databuff['PATTERN'][0]['reportset'].toString()
              : '',
          PO: BasicDATAr['PO'] != null ? BasicDATAr['PO'].toString() : '',
          CP: BasicDATAr['CP'] != null ? BasicDATAr['CP'].toString() : '',
          CUSTOMER: BasicDATAr['CUSTNAME'] != null
              ? BasicDATAr['CUSTNAME'].toString()
              : '',

          PROCESS: BasicDATAr['PROCESS'] != null
              ? BasicDATAr['PROCESS'].toString()
              : '',
          PARTNAME: BasicDATAr['PARTNAME'] != null
              ? BasicDATAr['PARTNAME'].toString()
              : '',
          PARTNO: BasicDATAr['PART_s'] != null
              ? BasicDATAr['PART_s'].toString()
              : '',
          PARTNO_s: BasicDATAr['PART'] != null
              ? BasicDATAr['PART'].toString()
              : '',
          CUSLOT: BasicDATAr['CUSLOT'] != null
              ? BasicDATAr['CUSLOT'].toString()
              : '',
          TPKLOT: BasicDATAr['FG_CHARG'] != null
              ? BasicDATAr['FG_CHARG'].toString()
              : '',
          MATERIAL: BasicDATAr['MATERIAL'] != null
              ? BasicDATAr['MATERIAL'].toString()
              : '',
          QTY: BasicDATAr['QTY'] != null ? BasicDATAr['QTY'].toString() : '',
          UNITSAP: BasicDATAr['UNITSAP'] != null
              ? BasicDATAr['UNITSAP'].toString()
              : 'PCS',
          INC01: inc01,
          INC02: inc02,

          Inspected: BasicDATAr['IDInspected'] != null
              ? BasicDATAr['IDInspected'].toString()
              : '',
          Check: BasicDATAr['IDCheck'] != null
              ? BasicDATAr['IDCheck'].toString()
              : '',
          Approve: BasicDATAr['IDApprove'] != null
              ? BasicDATAr['IDApprove'].toString()
              : '',

          dateInspected: BasicDATAr['dateInspected'] != null
              ? BasicDATAr['dateInspected'].toString()
              : '',
          dateCheck: BasicDATAr['dateCheck'] != null
              ? BasicDATAr['dateCheck'].toString()
              : '',
          dateApprove: BasicDATAr['dateApprove'] != null
              ? BasicDATAr['dateApprove'].toString()
              : '',

          GP3POINT: PATTERNlist['GP3POINT'] != null
              ? PATTERNlist['GP3POINT'].toString()
              : '',

          remark: databuff['PATTERN'][0]['remark'] != null
              ? databuff['PATTERN'][0]['remark'].toString()
              : '',

          // PICstd: BasicDATAr['PIC'] != null
          //     ? BasicDATAr['PIC'].toString().split(',')[1]
          //     : '',
        );

        if (BasicCommonDATAs.CUSTOMER == '') {
          BasicCommonDATAs.CUSTOMER = BasicDATAr['CUSTNAME_s'] != null
              ? BasicDATAr['CUSTNAME_s'].toString()
              : '';
        }

        // print(BasicCommonDATAs.Check);
        // print(BasicCommonDATAs.Approve);

        if (BasicCommonDATAs.Inspected != '') {
          final responseS1 = await Dio().post(
            'http://172.23.10.40:16714/' + "re_login",
            data: {
              "ID": BasicCommonDATAs.Inspected,
              // "PASS": logindata.userPASS,
            },
          );
          if (responseS1.statusCode == 200) {
            //SIGNATURE
            // print(responseS1.data);
            var input = responseS1.data;
            BasicCommonDATAs.Inspected_sign = input['SIGNATURE'] != null
                ? input['SIGNATURE'].toString()
                : '';
          }
        }

        if (BasicCommonDATAs.Check != '') {
          final responseS2 = await Dio().post(
            'http://172.23.10.40:16714/' + "re_login",
            data: {
              "ID": BasicCommonDATAs.Check,
              // "PASS": logindata.userPASS,
            },
          );
          if (responseS2.statusCode == 200) {
            //SIGNATURE
            // print(response.data);
            var input = responseS2.data;
            BasicCommonDATAs.Check_sign = input['SIGNATURE'] != null
                ? input['SIGNATURE'].toString()
                : '';
          }
        }

        if (BasicCommonDATAs.Approve != '') {
          final responseS3 = await Dio().post(
            'http://172.23.10.40:16714/' + "re_login",
            data: {
              "ID": BasicCommonDATAs.Approve,
              // "PASS": logindata.userPASS,
            },
          );
          if (responseS3.statusCode == 200) {
            //SIGNATURE
            // print(response.data);
            var input = responseS3.data;
            BasicCommonDATAs.Approve_sign = input['SIGNATURE'] != null
                ? input['SIGNATURE'].toString()
                : '';
          }
        }

        // if (BasicDATAr['ReferFrom'].toString() != PO) {
        //   if (BasicDATAr['ReferFrom'] != null) {
        //     final response02 = await Dio().post(
        //       server + "INS_Report_PDF",
        //       data: {
        //         "PO": BasicDATAr['ReferFrom'].toString(),
        //       },
        //     );

        //     if (response02.statusCode == 200) {
        //       var databuffref = response02.data;
        //       // print(databuffref);
        //       BasicCommonDATAs.PARTNAMEref =
        //           databuffref['DATA']?[0]['PARTNAME'].toString() ?? '';
        //       BasicCommonDATAs.PARTref =
        //           databuffref['DATA']?[0]['PART'].toString() ?? '';
        //       // print(databuffref['DATA']?[0]['PART']);
        //       // print(databuffref['DATA']?[0]['PARTNAME']);
        //     }
        //   }
        // }

        if (PATTERNlist['Pimg'] != null) {
          if (PATTERNlist['Pimg']['P1'] != null) {
            List<String> datalist = PATTERNlist['Pimg']['P1'].toString().split(
              ',',
            );
            if (datalist.length > 1) {
              BasicCommonDATAs.PICstd = datalist[1];
            } else {
              BasicCommonDATAs.PICstd = '';
            }
          }
        }

        // print(PATTERNlist['FINAL'].length);

        for (var fi = 0; fi < PATTERNlist['FINAL'].length; fi++) {
          //
          // print(PATTERNlist['FINAL'][fi]['ITEMs']);
          // print(PATTERNlist['FINAL'][fi]['RESULTFORMAT']);
          //SWreport
          String SWreport = PATTERNlist['FINAL'][fi]['SWreport'].toString();
          if (SWreport != 'NO') {
            if (PATTERNlist['FINAL'][fi]['RESULTFORMAT'] == 'Text') {
              for (var mi = 0; mi < MACHINElist.length; mi++) {
                if (FINALdata[MACHINElist[mi]] != null) {
                  if (FINALdata[MACHINElist[mi]][PATTERNlist['FINAL'][fi]['ITEMs']] !=
                      null) {
                    // print(PATTERNlist['FINAL'][fi]);
                    // print(FINALdata[MACHINElist[mi]]
                    //     [PATTERNlist['FINAL'][fi]['ITEMs']]);

                    String POINTs = (int.parse(
                      ConverstStrOne(
                        PATTERNlist['FINAL'][fi]['PCS'].toString(),
                      ),
                    )).toString();

                    String itemss = PATTERNlist['FINAL'][fi]['ITEMs']
                        .toString();
                    String SCmasks = PATTERNlist['FINAL'][fi]['SCMARK']
                        .toString();
                    String ITEMname = '';
                    String METHODss = '';
                    String METHODname = '';
                    String FREQ =
                        '${POINTs} ${PATTERNlist['FINAL'][fi]['FREQUENCY'].toString().replaceAll('?', 'pcs/Lot').replaceAll('[]', 'pcs/Lot')}';
                    String SPECIFICATION = '';
                    String LOAD = PATTERNlist['FINAL'][fi]['LOAD'].toString();

                    String SRAWDATA = PATTERNlist['FINAL'][fi]['SRAWDATA']
                        .toString();

                    for (var Fci = 0; Fci < METHODlist.length; Fci++) {
                      if (METHODlist[Fci]['masterID'].toString() == METHODss) {
                        METHODname = METHODlist[Fci]['METHOD'].toString();
                        break;
                      }
                    }

                    for (var Fci = 0; Fci < FINALCHECKlist.length; Fci++) {
                      if (FINALCHECKlist[Fci]['key'].toString() == itemss) {
                        ITEMname = FINALCHECKlist[Fci]['value'].toString();
                        METHODss = FINALCHECKlist[Fci]['METHOD'].toString();
                      }
                    }

                    for (var Fci = 0; Fci < METHODlist.length; Fci++) {
                      if (METHODlist[Fci]['masterID'].toString() == METHODss) {
                        METHODname = METHODlist[Fci]['METHOD'].toString();
                        break;
                      }
                    }
                    // print(PATTERNlist['FINAL'][fi]['SPECIFICATIONve']);

                    // print(SPECIFICATIONlist);
                    for (var SPi = 0; SPi < SPECIFICATIONlist.length; SPi++) {
                      if (SPECIFICATIONlist[SPi]['masterID'].toString() ==
                          PATTERNlist['FINAL'][fi]['SPECIFICATIONve']
                              .toString()) {
                        //
                        // print(SPECIFICATIONlist[SPi]['SPECIFICATION'].toString());
                        SPECIFICATION = SPECIFICATIONlist[SPi]['SPECIFICATION']
                            .toString();
                      }
                    }

                    ITEMlist.add(
                      FINALCHECKlistCommonClass(
                        TYPE: "Text",
                        ITEM: itemss,
                        ITEMname: ITEMname,
                        METHOD: METHODss,
                        METHODname: METHODname,
                        SCMARK: SCmasks,
                        FREQ: FREQ,
                        SPECIFICATION: SPECIFICATION,
                        RESULT: SPECIFICATION,
                        LOAD: LOAD,
                        SRAWDATA: "",
                      ),
                    );
                  }
                }
              }
            }

            if (PATTERNlist['FINAL'][fi]['RESULTFORMAT'] == 'Number') {
              NO_NUMBER++;

              for (var mi = 0; mi < MACHINElist.length; mi++) {
                if (FINALdata[MACHINElist[mi]] != null) {
                  if (FINALdata[MACHINElist[mi]][PATTERNlist['FINAL'][fi]['ITEMs']] !=
                      null) {
                    // print(PATTERNlist['FINAL'][fi]['RESULTFORMAT']);
                    // print(FINALdata[MACHINElist[mi]]
                    //     [PATTERNlist['FINAL'][fi]['ITEMs']]);

                    String POINTs = (int.parse(
                      ConverstStrOne(
                        PATTERNlist['FINAL'][fi]['PCS'].toString(),
                      ),
                    )).toString();
                    String UNITssp = PATTERNlist['FINAL'][fi]['UNIT']
                        .toString();
                    String SPECIFICATIONbuff =
                        PATTERNlist['FINAL'][fi]['SPECIFICATIONve'].toString();
                    String itemss = PATTERNlist['FINAL'][fi]['ITEMs']
                        .toString();
                    String SCmasks = PATTERNlist['FINAL'][fi]['SCMARK']
                        .toString();
                    String ITEMname = '';
                    String METHODss = '';
                    String METHODname = '';
                    String FREQ =
                        '${POINTs} ${PATTERNlist['FINAL'][fi]['FREQUENCY'].toString().replaceAll('?', 'pcs/Lot').replaceAll('[]', 'pcs/Lot')}';
                    String SPECIFICATION = '';
                    String LOAD = PATTERNlist['FINAL'][fi]['LOAD'].toString();

                    String SRAWDATA = PATTERNlist['FINAL'][fi]['SRAWDATA']
                        .toString();

                    double maxdata = 0;
                    double mindata = 0;

                    String remark = PATTERNlist['FINAL'][fi]['REMARK']
                        .toString();

                    // String remark = '';

                    String SUMDATA = PATTERNlist['FINAL'][fi]['SUMDATA']
                        .toString();

                    String LASTPcs = PATTERNlist['FINAL'][fi]['LASTPcs']
                        .toString();

                    // print('>>${remark}');

                    String convss = PATTERNlist['FINAL'][fi]['CONVERSE']
                        .toString();

                    if (convss != '' && convss != '-') {
                      for (var ih = 0; ih < UNITlist.length; ih++) {
                        // print(UNITlist[ih]['masterID'].toString());
                        if (convss == UNITlist[ih]['masterID'].toString()) {
                          // print(UNITlist[ih]);
                          String Unitss = "${UNITlist[ih]['UNIT']}";
                          if (Unitss.contains("-") == false) {
                            remark = "From ${UNITlist[ih]['UNIT']}";
                          }

                          break;
                        }
                      }
                    }
                    String unitP = '';
                    String unitPC = '';
                    try {
                      String SPECIFICATIONbuff2 = SPECIFICATIONbuff.replaceAll(
                        '{',
                        '{"',
                      );
                      String SPECIFICATIONbuff3 = SPECIFICATIONbuff2.replaceAll(
                        '}',
                        '"}',
                      );
                      String SPECIFICATIONbuff4 = SPECIFICATIONbuff3.replaceAll(
                        ':',
                        '":"',
                      );
                      String SPECIFICATIONbuff5 = SPECIFICATIONbuff4.replaceAll(
                        ',',
                        '","',
                      );
                      // print(SPECIFICATIONbuff5);
                      var SPECIFICATIONdata = json.decode(
                        SPECIFICATIONbuff5.replaceAll(' ', ''),
                      );
                      if (SPECIFICATIONdata['condition'] != null) {
                        // print(SPECIFICATIONdata['condition']);
                        String condition = SPECIFICATIONdata['condition']
                            .toString();

                        // print(condition.contains("LOL(<)"));
                        // print(condition.contains("HIM(>)"));
                        // Actual
                        // print(SPECIFICATIONdata);

                        String dataUNIT = PATTERNlist['FINAL'][fi]['UNIT']
                            .toString();

                        String dataUNITC = PATTERNlist['FINAL'][fi]['CONVERSE']
                            .toString();

                        for (var ih = 0; ih < UNITlist.length; ih++) {
                          // print(UNITlist[ih]['masterID'].toString());
                          if (dataUNIT == UNITlist[ih]['masterID'].toString()) {
                            // print(UNITlist[ih]);
                            unitP = UNITlist[ih]['UNIT'].toString();
                            break;
                          }
                        }

                        for (var ih = 0; ih < UNITlist.length; ih++) {
                          // print(UNITlist[ih]['masterID'].toString());
                          if (dataUNITC ==
                              UNITlist[ih]['masterID'].toString()) {
                            // print(UNITlist[ih]);
                            unitPC = UNITlist[ih]['UNIT'].toString();
                            break;
                          }
                        }

                        if (condition.contains("BTW")) {
                          print(SPECIFICATIONdata['BTW_LOW']);
                          print(SPECIFICATIONdata['BTW_HI']);
                          SPECIFICATION =
                              '${SPECIFICATIONdata['BTW_LOW'].toString()}-${SPECIFICATIONdata['BTW_HI'].toString()} ${unitP.replaceAll('?', 'µ')}';

                          maxdata = double.parse(
                            ConverstStr(SPECIFICATIONdata['BTW_HI'].toString()),
                          );
                          mindata = double.parse(
                            ConverstStr(
                              SPECIFICATIONdata['BTW_LOW'].toString(),
                            ),
                          );
                        } else if (condition.contains("LOL(<)")) {
                          // print(SPECIFICATIONdata['LOL_H']);
                          SPECIFICATION =
                              '≤ ${SPECIFICATIONdata['LOL_H'].toString()} ${unitP.replaceAll('?', 'µ')}';
                          maxdata = double.parse(
                            ConverstStr(SPECIFICATIONdata['LOL_H'].toString()),
                          );
                        } else if (condition.contains("HIM(>)")) {
                          // print(SPECIFICATIONdata['HIM_L']);
                          SPECIFICATION =
                              '≥ ${SPECIFICATIONdata['HIM_L'].toString()} ${unitP.replaceAll('?', 'µ')}';
                          mindata = double.parse(
                            ConverstStr(SPECIFICATIONdata['HIM_L'].toString()),
                          );
                        } else if (condition.contains("Actual")) {
                          // print(SPECIFICATIONdata['TARGET']);
                          SPECIFICATION = 'Actual';
                        }
                      }
                    } catch (er) {
                      print(er);
                    }

                    for (var Fci = 0; Fci < FINALCHECKlist.length; Fci++) {
                      if (FINALCHECKlist[Fci]['key'].toString() == itemss) {
                        ITEMname = FINALCHECKlist[Fci]['value'].toString();
                        METHODss = FINALCHECKlist[Fci]['METHOD'].toString();
                      }
                    }

                    for (var Fci = 0; Fci < METHODlist.length; Fci++) {
                      if (METHODlist[Fci]['masterID'].toString() == METHODss) {
                        METHODname = METHODlist[Fci]['METHOD'].toString();
                        break;
                      }
                    }
                    int desinal = 1;
                    int desinalc = 1;

                    // for (var Fci = 0; Fci < ITEMSlist.length; Fci++) {
                    //   if (ITEMSlist[Fci]['masterID'].toString() == itemss) {
                    //     // print(ITEMSlist[Fci]);
                    //     if (ITEMSlist[Fci]['ITEMs']
                    //         .toString()
                    //         .toUpperCase()
                    //         .contains("HARDNESS")) {
                    //       desinal = 1;
                    //     }

                    //     if (ITEMSlist[Fci]['ITEMs'].toString().contains("trid")) {
                    //       desinal = 1;
                    //     }
                    //   }
                    // }
                    // for (var B = 0; B < ITEMSlist.length; B++) {
                    //   for (var d = 0; d < DESIMALlist.length; d++) {
                    //     if (DESIMALlist[d]['ITEMs'].toString() ==
                    //         ITEMSlist[B]['masterID'].toString()) {
                    //       desinal =
                    //           int.parse(ConverstStr(DESIMALlist[d]['DESIMAL01']));
                    //     } else {
                    //       desinal = 1;
                    //     }
                    //   }
                    // }
                    // for (var d = 0; d < DESIMALlist.length; d++) {
                    //   if (DESIMALlist[d]['ITEMs'].toString() == itemss) {
                    //     desinal =
                    //         int.parse(ConverstStr(DESIMALlist[d]['DESIMAL01']));
                    //     break;
                    //   } else {
                    //     desinal = 1;
                    //   }
                    // }
                    for (var d = 0; d < UNITlist.length; d++) {
                      if (UNITlist[d]['masterID'].toString() == UNITssp) {
                        desinal = int.parse(
                          ConverstStr(UNITlist[d]['DESIMAL'].toString()),
                        );

                        break;
                      } else {
                        desinal = 1;
                      }
                    }

                    for (var d = 0; d < UNITlist.length; d++) {
                      if (UNITlist[d]['masterID'].toString() == convss) {
                        desinalc = int.parse(
                          ConverstStr(UNITlist[d]['DESIMAL'].toString()),
                        );

                        break;
                      } else {
                        desinalc = desinal;
                      }
                    }
                    print("------------desinalc");
                    print(desinalc);

                    List<datainlist> listdataset = [];
                    for (var i = 0; i < 20; i++) {
                      if (FINALdata[MACHINElist[mi]][PATTERNlist['FINAL'][fi]['ITEMs']]['PSC${i + 1}'] !=
                          null) {
                        //
                        // print(FINALdata[MACHINElist[mi]]
                        //         [PATTERNlist['FINAL'][fi]['ITEMs']]['PSC${i + 1}']
                        //     .length);
                        var datainside =
                            FINALdata[MACHINElist[mi]][PATTERNlist['FINAL'][fi]['ITEMs']]['PSC${i + 1}'];
                        datainlist datainpcsi = datainlist();
                        int pcsi = 0;
                        // print(PATTERNlist['FINAL'][fi]);
                        // print(ITEMSlist);
                        print(PATTERNlist['FINAL'][fi]['CONVERSEDATA']);
                        String conves =
                            PATTERNlist['FINAL'][fi]['CONVERSEDATA'] != null
                            ? PATTERNlist['FINAL'][fi]['CONVERSEDATA']
                                  .toString()
                                  .toLowerCase()
                            : '';

                        String ConvesData = setps1;
                        String ConvesData2 = "PO5";
                        if (conves == 'yes') {
                          ConvesData = setps2;
                          ConvesData2 = setps1;
                        }

                        if (ConvesData == "PO5") {
                          ConvesData2 = "PO3";
                        } else {
                          ConvesData2 = "PO5";
                        }

                        for (pcsi = 0; pcsi < datainside.length - 1; pcsi++) {
                          // print("--------------------------------pcsi");
                          // print(pcsi);
                          // print("--------------------------------pcsi");
                          // print(datainside[pcsi][setps1]);
                          //   double.parse(ConverstStr(datainside[pcsi]['PIC1data'].toString())).toStringAsFixed(2);

                          if (pcsi == 0) {
                            datainpcsi.DATA01 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA01c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 1) {
                            datainpcsi.DATA02 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA02c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 2) {
                            datainpcsi.DATA03 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA03c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 3) {
                            datainpcsi.DATA04 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA04c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 4) {
                            datainpcsi.DATA05 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA05c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 5) {
                            datainpcsi.DATA06 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA06c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 6) {
                            datainpcsi.DATA07 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA07c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 7) {
                            datainpcsi.DATA08 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA08c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 8) {
                            datainpcsi.DATA09 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA09c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);
                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 9) {
                            datainpcsi.DATA10 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA10c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 10) {
                            datainpcsi.DATA11 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA11c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 11) {
                            datainpcsi.DATA12 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA12c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 12) {
                            datainpcsi.DATA13 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA13c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 13) {
                            datainpcsi.DATA14 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA14c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 14) {
                            datainpcsi.DATA15 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA15c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 15) {
                            datainpcsi.DATA16 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA16c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 16) {
                            datainpcsi.DATA17 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA17c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 17) {
                            datainpcsi.DATA18 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA18c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 18) {
                            datainpcsi.DATA19 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA19c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 19) {
                            datainpcsi.DATA20 = double.parse(
                              ConverstStr(
                                datainside[pcsi][ConvesData].toString(),
                              ),
                            ).toStringAsFixed(desinal);

                            datainpcsi.DATA20c = double.parse(
                              ConverstStr(
                                checknull(datainside[pcsi][ConvesData2]),
                              ),
                            ).toStringAsFixed(desinalc);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(
                                    datainside[pcsi][ConvesData].toString(),
                                  ),
                                ),
                              ).toString(),
                            );
                          }
                        }

                        datainpcsi.DATAAVG = datainside[pcsi][ConvesData]
                            .toString();
                        datainpcsi.dimensionX = pcsi;

                        datainpcsi.TYPE = 'Number';

                        listdataset.add(datainpcsi);
                      } else {
                        break;
                      }
                    }

                    double avgall = 0;
                    for (var ig = 0; ig < listdataset.length; ig++) {
                      // print(ConverstStr(listdataset[ig].DATAAVG));
                      avgall =
                          avgall +
                          double.parse(ConverstStr(listdataset[ig].DATAAVG));
                    }
                    // print(avgall);
                    ITEMlist.add(
                      FINALCHECKlistCommonClass(
                        TYPE: "Number",
                        ITEM: itemss,
                        ITEMname: ITEMname,
                        METHOD: METHODss,
                        METHODname: METHODname,
                        SCMARK: SCmasks,
                        SPECIFICATION: SPECIFICATION,
                        NO: NO_NUMBER,
                        FREQ: FREQ,
                        datapackset: listdataset,
                        RESULT:
                            // (avgall / listdataset.length).toStringAsFixed(desinal),
                            (SUMDATA == 'NO'
                            ? "See at table"
                            : (avgall / listdataset.length).toStringAsFixed(
                                desinal,
                              )),
                        LOAD: LOAD,
                        Remark: remark,
                        SRAWDATA: SRAWDATA,
                        unitP: unitP,
                        unitPC: unitPC,
                        // RESULTDSW: RESULTDSW,
                      ),
                    );
                  }
                }
              }
            }
            if (PATTERNlist['FINAL'][fi]['RESULTFORMAT'] == 'Graph') {
              for (var mi = 0; mi < MACHINElist.length; mi++) {
                if (FINALdata[MACHINElist[mi]] != null) {
                  if (FINALdata[MACHINElist[mi]][PATTERNlist['FINAL'][fi]['ITEMs']] !=
                      null) {
                    // print(PATTERNlist['FINAL'][fi]['RESULTFORMAT']);
                    // print(FINALdata[MACHINElist[mi]]
                    //     [PATTERNlist['FINAL'][fi]['ITEMs']]);

                    String POINTs = (int.parse(
                      ConverstStrOne(
                        PATTERNlist['FINAL'][fi]['PCS'].toString(),
                      ),
                    )).toString();

                    String SPECIFICATIONbuff =
                        PATTERNlist['FINAL'][fi]['SPECIFICATIONve'].toString();
                    String itemss = PATTERNlist['FINAL'][fi]['ITEMs']
                        .toString();
                    String SCmasks = PATTERNlist['FINAL'][fi]['SCMARK']
                        .toString();
                    String ITEMname = '';
                    String METHODss = '';
                    String METHODname = '';
                    String FREQ =
                        '${POINTs} ${PATTERNlist['FINAL'][fi]['FREQUENCY'].toString().replaceAll('?', 'pcs/Lot').replaceAll('[]', 'pcs/Lot')}';
                    String SPECIFICATION = '';
                    String LOAD = PATTERNlist['FINAL'][fi]['LOAD'].toString();

                    String GTC = PATTERNlist['FINAL'][fi]['GTC'] != null
                        ? PATTERNlist['FINAL'][fi]['GTC'].toString()
                        : '';

                    String SRAWDATA = PATTERNlist['FINAL'][fi]['SRAWDATA']
                        .toString();

                    String SUMDATA = PATTERNlist['FINAL'][fi]['SUMDATA']
                        .toString();

                    double maxdata = 0;
                    double mindata = 0;

                    String remark = '';

                    try {
                      String SPECIFICATIONbuff2 = SPECIFICATIONbuff.replaceAll(
                        '{',
                        '{"',
                      );
                      String SPECIFICATIONbuff3 = SPECIFICATIONbuff2.replaceAll(
                        '}',
                        '"}',
                      );
                      String SPECIFICATIONbuff4 = SPECIFICATIONbuff3.replaceAll(
                        ':',
                        '":"',
                      );
                      String SPECIFICATIONbuff5 = SPECIFICATIONbuff4.replaceAll(
                        ',',
                        '","',
                      );
                      // print(SPECIFICATIONbuff5);
                      var SPECIFICATIONdata = json.decode(
                        SPECIFICATIONbuff5.replaceAll(' ', ''),
                      );
                      if (SPECIFICATIONdata['condition'] != null) {
                        // print(SPECIFICATIONdata['condition']);
                        String condition = SPECIFICATIONdata['condition']
                            .toString();

                        // print(condition);
                        // print(condition.contains("LOL(<)"));
                        // print(condition.contains("HIM(>)"));
                        // Actual
                        // print(SPECIFICATIONdata);

                        double maxdata = 0;
                        double mindata = 0;

                        String remark = '';

                        String dataUNIT = PATTERNlist['FINAL'][fi]['UNIT']
                            .toString();

                        String unitP = '';

                        for (var ih = 0; ih < UNITlist.length; ih++) {
                          // print(UNITlist[ih]['masterID'].toString());
                          if (dataUNIT == UNITlist[ih]['masterID'].toString()) {
                            // print(UNITlist[ih]);
                            unitP = UNITlist[ih]['UNIT'].toString();
                            break;
                          }
                        }

                        if (condition.contains("BTW")) {
                          // print(SPECIFICATIONdata['BTW_LOW']);
                          // print(SPECIFICATIONdata['BTW_HI']);
                          SPECIFICATION =
                              '${SPECIFICATIONdata['BTW_LOW'].toString()}-${SPECIFICATIONdata['BTW_HI'].toString()} ${unitP.replaceAll('?', 'µ')}';

                          maxdata = double.parse(
                            ConverstStr(SPECIFICATIONdata['BTW_HI'].toString()),
                          );
                          mindata = double.parse(
                            ConverstStr(
                              SPECIFICATIONdata['BTW_LOW'].toString(),
                            ),
                          );
                        } else if (condition.contains("LOL(<)")) {
                          // print(SPECIFICATIONdata['LOL_H']);
                          SPECIFICATION =
                              '≤ ${SPECIFICATIONdata['LOL_H'].toString()} ${unitP.replaceAll('?', 'µ')}';
                          maxdata = double.parse(
                            ConverstStr(SPECIFICATIONdata['LOL_H'].toString()),
                          );
                        } else if (condition.contains("HIM(>)")) {
                          // print(SPECIFICATIONdata['HIM_L']);
                          SPECIFICATION =
                              '≥ ${SPECIFICATIONdata['HIM_L'].toString()} ${unitP.replaceAll('?', 'µ')}';
                          mindata = double.parse(
                            ConverstStr(SPECIFICATIONdata['HIM_L'].toString()),
                          );
                        } else if (condition.contains("Actual")) {
                          // print(SPECIFICATIONdata['TARGET']);
                          SPECIFICATION = 'Actual';
                        }
                      }
                    } catch (er) {
                      print(er);
                    }

                    for (var Fci = 0; Fci < FINALCHECKlist.length; Fci++) {
                      if (FINALCHECKlist[Fci]['key'].toString() == itemss) {
                        ITEMname = FINALCHECKlist[Fci]['value'].toString();
                        METHODss = FINALCHECKlist[Fci]['METHOD'].toString();
                      }
                    }

                    for (var Fci = 0; Fci < METHODlist.length; Fci++) {
                      if (METHODlist[Fci]['masterID'].toString() == METHODss) {
                        METHODname = METHODlist[Fci]['METHOD'].toString();
                        break;
                      }
                    }
                    // print("------------->");
                    int desinal = 0;
                    int desinalG = 1;
                    // for (var Fci = 0; Fci < ITEMSlist.length; Fci++) {
                    //   if (ITEMSlist[Fci]['masterID'].toString() == itemss) {
                    //     // print(ITEMSlist[Fci]);
                    //     if (ITEMSlist[Fci]['ITEMs']
                    //         .toString()
                    //         .contains("Hardness")) {
                    //       desinal = 1;
                    //     }
                    //     if (ITEMSlist[Fci]['ITEMs'].toString().contains("trid")) {
                    //       desinal = 1;
                    //     }
                    //   }
                    // }

                    // for (var B = 0; B < ITEMSlist.length; B++) {
                    //   for (var d = 0; d < DESIMALlist.length; d++) {
                    //     if (DESIMALlist[d]['ITEMs'].toString() ==
                    //         ITEMSlist[B]['masterID'].toString()) {
                    //       desinal = int.parse(
                    //           ConverstStr(DESIMALlist[d]['DESIMAL01']));
                    //     } else {
                    //       desinal = 1;
                    //     }
                    //   }
                    // }

                    for (var d = 0; d < DESIMALlist.length; d++) {
                      if (DESIMALlist[d]['ITEMs'].toString() == itemss) {
                        desinal = int.parse(
                          ConverstStr(DESIMALlist[d]['DESIMAL01'].toString()),
                        );

                        desinalG = int.parse(
                          ConverstStr(DESIMALlist[d]['DESIMAL02'].toString()),
                        );
                        break;
                      } else {
                        desinal = 1;
                        desinalG = 1;
                      }
                    }

                    if (BasicCommonDATAs.GP3POINT == 'YES') {
                      desinalG = 3;
                    }

                    // print(itemss);

                    List<datainlist> listdataset = [];
                    for (var i = 0; i < 20; i++) {
                      if (FINALdata[MACHINElist[mi]][PATTERNlist['FINAL'][fi]['ITEMs']]['PSC${i + 1}'] !=
                          null) {
                        //
                        // print(FINALdata[MACHINElist[mi]]
                        //         [PATTERNlist['FINAL'][fi]['ITEMs']]['PSC${i + 1}']
                        //     .length);
                        var datainside =
                            FINALdata[MACHINElist[mi]][PATTERNlist['FINAL'][fi]['ITEMs']]['PSC${i + 1}'];
                        datainlist datainpcsi = datainlist();
                        int pcsi = 0;
                        // print(PATTERNlist['FINAL'][fi]);
                        // print(ITEMSlist);

                        // for (pcsi = 0; pcsi < datainside.length - 1; pcsi++) {
                        //   // print(pcsi);
                        //   // print(datainside[pcsi][setps1]);
                        //   //   double.parse(ConverstStr(datainside[pcsi]['PIC1data'].toString())).toStringAsFixed(2);
                        //   // print(datainside[pcsi]);
                        //   if (pcsi == 0) {
                        //     datainpcsi.DATA01 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA01p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 1) {
                        //     datainpcsi.DATA02 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA02p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 2) {
                        //     datainpcsi.DATA03 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA03p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 3) {
                        //     datainpcsi.DATA04 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA04p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 4) {
                        //     datainpcsi.DATA05 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA05p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 5) {
                        //     datainpcsi.DATA06 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA06p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 6) {
                        //     datainpcsi.DATA07 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA07p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 7) {
                        //     datainpcsi.DATA08 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA08p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 8) {
                        //     datainpcsi.DATA09 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA09p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 9) {
                        //     datainpcsi.DATA10 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA10p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 10) {
                        //     datainpcsi.DATA11 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA11p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 11) {
                        //     datainpcsi.DATA12 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA12p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 12) {
                        //     datainpcsi.DATA13 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA13p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 13) {
                        //     datainpcsi.DATA14 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);
                        //     datainpcsi.DATA14p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 14) {
                        //     datainpcsi.DATA15 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA15p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 15) {
                        //     datainpcsi.DATA16 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA16p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 16) {
                        //     datainpcsi.DATA17 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA17p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 17) {
                        //     datainpcsi.DATA18 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA18p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 18) {
                        //     datainpcsi.DATA19 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA19p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   } else if (pcsi == 19) {
                        //     datainpcsi.DATA20 = double.parse(ConverstStr(
                        //             datainside[pcsi][setps1].toString()))
                        //         .toStringAsFixed(desinal);

                        //     datainpcsi.DATA20p = double.parse(ConverstStr(
                        //             datainside[pcsi]['PO8'].toString()))
                        //         .toString();

                        //     passlist.add(checkdata(
                        //             maxdata,
                        //             mindata,
                        //             double.parse(ConverstStr(
                        //                 datainside[pcsi][setps1].toString())))
                        //         .toString());
                        //   }
                        // }

                        print(datainside.length);

                        for (pcsi = 0; pcsi < datainside.length - 1; pcsi++) {
                          // print(pcsi);
                          // print("---====>>");
                          // print(datainside[pcsi]["PO3"]);
                          // // 3410288012
                          // print(datainside[pcsi]['PO8']);

                          // print(datainside[pcsi]["PO3"]);
                          //   double.parse(ConverstStr(datainside[pcsi]['PIC1data'])).toStringAsFixed(2);
                          // print(datainside[pcsi]); ConverstStr(datainside[pcsi]["PO3"]
                          if (pcsi == 0) {
                            datainpcsi.DATA01 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA01p = double.parse(
                                ConverstStr((datainside[pcsi]['PO8'])),
                              ).toStringAsFixed(desinalG);
                            }

                            //desinalG

                            datainpcsi.DATA01c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 1) {
                            datainpcsi.DATA02 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA02p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA02c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 2) {
                            datainpcsi.DATA03 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA03p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA03c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 3) {
                            datainpcsi.DATA04 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA04p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA04c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 4) {
                            datainpcsi.DATA05 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA05p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA05c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 5) {
                            datainpcsi.DATA06 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA06p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA06c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 6) {
                            datainpcsi.DATA07 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA07p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA07c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 7) {
                            datainpcsi.DATA08 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA08p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA08c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 8) {
                            datainpcsi.DATA09 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);
                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA09p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA09c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 9) {
                            datainpcsi.DATA10 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);
                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA10p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA10c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 10) {
                            datainpcsi.DATA11 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);
                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA11p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA11c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 11) {
                            datainpcsi.DATA12 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);
                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA12p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA12c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 12) {
                            datainpcsi.DATA13 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);
                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA13p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA13c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 13) {
                            datainpcsi.DATA14 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);
                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA14p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toString();
                            }
                            datainpcsi.DATA14c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 14) {
                            datainpcsi.DATA15 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA15p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA15c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 15) {
                            datainpcsi.DATA16 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA16p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA16c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 16) {
                            datainpcsi.DATA17 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA17p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA17c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 17) {
                            datainpcsi.DATA18 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA18p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA18c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 18) {
                            datainpcsi.DATA19 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA19p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA19c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi]["PO3"]),
                                ),
                              ).toString(),
                            );
                          } else if (pcsi == 19) {
                            datainpcsi.DATA20 = double.parse(
                              ConverstStr(datainside[pcsi]["PO3"]),
                            ).toStringAsFixed(desinal);

                            if (datainside[pcsi]['PO8'] != null) {
                              datainpcsi.DATA20p = double.parse(
                                ConverstStr(datainside[pcsi]['PO8']),
                              ).toStringAsFixed(desinalG);
                            }
                            datainpcsi.DATA20c = double.parse(
                              ConverstStr(checknull(datainside[pcsi][setps2])),
                            ).toStringAsFixed(2);

                            passlist.add(
                              checkdata(
                                maxdata,
                                mindata,
                                double.parse(
                                  ConverstStr(datainside[pcsi][setps1]),
                                ),
                              ).toString(),
                            );
                          }
                        }

                        datainpcsi.DATAAVG = datainside[pcsi][setps1]
                            .toString();
                        datainpcsi.dimensionX = pcsi;

                        datainpcsi.TYPE = 'Graph';

                        listdataset.add(datainpcsi);
                      } else {
                        break;
                      }
                    }

                    double avgall = 0;
                    for (var ig = 0; ig < listdataset.length; ig++) {
                      // print(ConverstStr(listdataset[ig].DATAAVG));
                      avgall =
                          avgall +
                          double.parse(ConverstStr(listdataset[ig].DATAAVG));
                    }
                    // print(avgall);
                    // print(FINALANSdata);
                    // print(itemss);

                    //---------

                    // print(FINALANSdata[itemss + "_point"]['y']);
                    String reslp = '';
                    String reslpCross = '';

                    print(GTC);

                    // if (GTC != '' && GTC != '-') {
                    if (FINALANSdata[itemss] != null) {
                      reslp = FINALANSdata[itemss].toString();
                    }
                    if (FINALANSdata[itemss + "_point"] != null) {
                      reslpCross = FINALANSdata[itemss + "_point"]['y']
                          .toString();
                    }
                    // }
                    List<FlSpot> upper = [];
                    List<FlSpot> lower = [];

                    if (GTC != '' && GTC != '-') {
                      for (var vdd = 0; vdd < GTClist.length; vdd++) {
                        if (GTClist[vdd]['NO'].toString() == GTC) {
                          print(GTClist[vdd]);
                          //GT03POINT
                          if (GTClist[vdd]['GT01POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT01POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT01H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT01POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT01L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT02POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT02POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT02H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT02POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT02L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT03POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT03POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT03H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT03POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT03L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT04POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT04POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT04H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT04POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT04L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT05POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT05POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT05H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT05POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT05L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT06POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT06POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT06H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT06POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT06L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT07POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT07POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT07H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT07POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT07L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT08POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT08POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT08H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT08POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT08L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT09POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT09POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT09H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT09POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT09L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT10POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT10POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT10H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT10POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT10L'].toString()),
                                ),
                              ),
                            );
                          }

                          if (GTClist[vdd]['GT11POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT11POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT11H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT11POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT11L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT12POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT12POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT12H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT12POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT12L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT13POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT13POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT13H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT13POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT13L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT14POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT14POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT14H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT14POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT14L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT15POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT15POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT15H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT15POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT15L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT16POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT16POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT16H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT16POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT16L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT17POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT17POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT17H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT17POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT17L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT18POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT18POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT18H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT18POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT18L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT19POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT19POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT19H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT19POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT19L'].toString()),
                                ),
                              ),
                            );
                          }
                          if (GTClist[vdd]['GT20POINT'].toString() != '') {
                            upper.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT20POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT20H'].toString()),
                                ),
                              ),
                            );
                            lower.add(
                              FlSpot(
                                double.parse(
                                  ConverstStr(
                                    GTClist[vdd]['GT20POINT'].toString(),
                                  ),
                                ),
                                double.parse(
                                  ConverstStr(GTClist[vdd]['GT20L'].toString()),
                                ),
                              ),
                            );
                          }
                        }
                      }
                    }

                    //---------

                    // print("<<<<<<<<<<<<<<<");
                    // print((double.parse(ConverstStr(reslp))).toStringAsFixed(2));
                    // print("<<<<<<<<<<<<<<<");

                    ITEMlist.add(
                      FINALCHECKlistCommonClass(
                        TYPE: "Graph",
                        ITEM: itemss,
                        ITEMname: ITEMname,
                        METHOD: METHODss,
                        METHODname: METHODname,
                        SCMARK: SCmasks,
                        SPECIFICATION: SPECIFICATION,
                        NO: NO_NUMBER,
                        FREQ: FREQ,
                        datapackset: listdataset,
                        RESULT: (SUMDATA == 'NO'
                            ? "See graph"
                            : (double.parse(
                                ConverstStr(reslp),
                              )).toStringAsFixed(2)),
                        LOAD: LOAD,
                        Cross: reslpCross,
                        SRAWDATA: "",
                        GTC: GTC,
                        upper: upper,
                        lower: lower,
                      ),
                    );
                  }
                }
              }
            }

            if (PATTERNlist['FINAL'][fi]['RESULTFORMAT'] == 'Picture') {
              for (var mi = 0; mi < MACHINElist.length; mi++) {
                // print("----${PATTERNlist['FINAL'][fi]['ITEMs']}");
                if (FINALdata[MACHINElist[mi]] != null) {
                  if (FINALdata[MACHINElist[mi]][PATTERNlist['FINAL'][fi]['ITEMs']] !=
                      null) {
                    // print(PATTERNlist['FINAL'][fi]['RESULTFORMAT']);
                    // print(FINALdata[MACHINElist[mi]]

                    String POINTs = (int.parse(
                      ConverstStrOne(
                        PATTERNlist['FINAL'][fi]['PCS'].toString(),
                      ),
                    )).toString();

                    String SPECIFICATIONbuff =
                        PATTERNlist['FINAL'][fi]['SPECIFICATIONve'].toString();
                    String itemss = PATTERNlist['FINAL'][fi]['ITEMs']
                        .toString();
                    String SCmasks = PATTERNlist['FINAL'][fi]['SCMARK']
                        .toString();
                    String UNITssp = PATTERNlist['FINAL'][fi]['UNIT']
                        .toString();
                    String ITEMname = '';
                    String METHODss = '';
                    String METHODname = '';
                    String FREQ =
                        '${POINTs} ${PATTERNlist['FINAL'][fi]['FREQUENCY'].toString().replaceAll('?', 'pcs/Lot').replaceAll('[]', 'pcs/Lot')}';
                    // print(FREQ);
                    String SPECIFICATION = '';
                    String LOAD = PATTERNlist['FINAL'][fi]['LOAD'].toString();

                    String SRAWDATA = PATTERNlist['FINAL'][fi]['SRAWDATA']
                        .toString();

                    for (var Fci = 0; Fci < METHODlist.length; Fci++) {
                      if (METHODlist[Fci]['masterID'].toString() == METHODss) {
                        METHODname = METHODlist[Fci]['METHOD'].toString();
                        break;
                      }
                    }

                    for (var Fci = 0; Fci < FINALCHECKlist.length; Fci++) {
                      if (FINALCHECKlist[Fci]['key'].toString() == itemss) {
                        ITEMname = FINALCHECKlist[Fci]['value'].toString();
                        METHODss = FINALCHECKlist[Fci]['METHOD'].toString();
                      }
                    }

                    for (var Fci = 0; Fci < METHODlist.length; Fci++) {
                      if (METHODlist[Fci]['masterID'].toString() == METHODss) {
                        METHODname = METHODlist[Fci]['METHOD'].toString();
                        break;
                      }
                    }

                    int desinal = 1;
                    // print(itemss);
                    // for (var Fci = 0; Fci < ITEMSlist.length; Fci++) {
                    //   if (ITEMSlist[Fci]['masterID'].toString() == itemss) {
                    //     if (ITEMSlist[Fci]['ITEMs']
                    //         .toString()
                    //         .contains("pound")) {
                    //       desinal = 1;
                    //     }
                    //     if (ITEMSlist[Fci]['ITEMs'].toString().contains("trid")) {
                    //       desinal = 1;
                    //     } else {
                    //       desinal = 1;
                    //     }
                    //   }
                    // }
                    // for (var B = 0; B < ITEMSlist.length; B++) {
                    //   for (var d = 0; d < DESIMALlist.length; d++) {
                    //     if (DESIMALlist[d]['ITEMs'].toString() ==
                    //         ITEMSlist[B]['masterID'].toString()) {
                    //       desinal =
                    //           int.parse(ConverstStr(DESIMALlist[d]['DESIMAL01']));
                    //     }
                    //   }
                    // }
                    // for (var d = 0; d < DESIMALlist.length; d++) {
                    //   if (DESIMALlist[d]['ITEMs'].toString() == itemss) {
                    //     desinal =
                    //         int.parse(ConverstStr(DESIMALlist[d]['DESIMAL01']));
                    //     break;
                    //   } else {
                    //     desinal = 1;
                    //   }
                    // }
                    // for (var d = 0; d < UNITlist.length; d++) {
                    //   if (UNITlist[d]['masterID'].toString() == UNITssp) {
                    //     desinal =
                    //         int.parse(ConverstStr(DESIMALlist[d]['DESIMAL']));
                    //     break;
                    //   } else {
                    //     desinal = 1;
                    //   }
                    // }

                    List<datainlist> listdataset = [];
                    for (var i = 0; i < 20; i++) {
                      if (FINALdata[MACHINElist[mi]][PATTERNlist['FINAL'][fi]['ITEMs']]['PSC${i + 1}'] !=
                          null) {
                        //
                        // print(FINALdata[MACHINElist[mi]]
                        //         [PATTERNlist['FINAL'][fi]['ITEMs']]['PSC${i + 1}']
                        //     .length);

                        var datainside =
                            FINALdata[MACHINElist[mi]][PATTERNlist['FINAL'][fi]['ITEMs']]['PSC${i + 1}'];

                        datainlist datainpcsi = datainlist();
                        int pcsi = 0;

                        // print(datainside.length);

                        double maxdata = 0;
                        double mindata = 0;

                        String remark = '';

                        try {
                          String SPECIFICATIONbuff2 =
                              SPECIFICATIONbuff.replaceAll('{', '{"');
                          String SPECIFICATIONbuff3 =
                              SPECIFICATIONbuff2.replaceAll('}', '"}');
                          String SPECIFICATIONbuff4 =
                              SPECIFICATIONbuff3.replaceAll(':', '":"');
                          String SPECIFICATIONbuff5 =
                              SPECIFICATIONbuff4.replaceAll(',', '","');
                          // print(SPECIFICATIONbuff5);
                          var SPECIFICATIONdata = json.decode(
                            SPECIFICATIONbuff5.replaceAll(' ', ''),
                          );
                          if (SPECIFICATIONdata['condition'] != null) {
                            // print(SPECIFICATIONdata['condition']);
                            String condition = SPECIFICATIONdata['condition']
                                .toString();

                            // print(condition);
                            // print(condition.contains("LOL(<)"));
                            // print(condition.contains("HIM(>)"));
                            // Actual
                            // print(SPECIFICATIONdata);

                            // print(PATTERNlist['FINAL'][fi]);
                            String dataUNIT = PATTERNlist['FINAL'][fi]['UNIT']
                                .toString();

                            String unitP = '';

                            for (var ih = 0; ih < UNITlist.length; ih++) {
                              // print(UNITlist[ih]['masterID'].toString());
                              if (dataUNIT ==
                                  UNITlist[ih]['masterID'].toString()) {
                                // print(UNITlist[ih]);
                                unitP = UNITlist[ih]['UNIT'].toString();
                                break;
                              }
                            }

                            if (condition.contains("BTW")) {
                              // print(SPECIFICATIONdata['BTW_LOW']);
                              // print(SPECIFICATIONdata['BTW_HI']);
                              SPECIFICATION =
                                  '${SPECIFICATIONdata['BTW_LOW'].toString()}-${SPECIFICATIONdata['BTW_HI'].toString()} ${unitP.replaceAll('?', 'µ')}';
                              maxdata = double.parse(
                                ConverstStr(
                                  SPECIFICATIONdata['BTW_HI'].toString(),
                                ),
                              );
                              mindata = double.parse(
                                ConverstStr(
                                  SPECIFICATIONdata['BTW_LOW'].toString(),
                                ),
                              );
                            } else if (condition.contains("LOL(<)")) {
                              // print(SPECIFICATIONdata['LOL_H']);
                              SPECIFICATION =
                                  '≤ ${SPECIFICATIONdata['LOL_H'].toString()} ${unitP.replaceAll('?', 'µ')}';
                              maxdata = double.parse(
                                ConverstStr(
                                  SPECIFICATIONdata['LOL_H'].toString(),
                                ),
                              );
                            } else if (condition.contains("HIM(>)")) {
                              // print(SPECIFICATIONdata['HIM_L']);
                              SPECIFICATION =
                                  '≥ ${SPECIFICATIONdata['HIM_L'].toString()} ${unitP.replaceAll('?', 'µ')}';
                              mindata = double.parse(
                                ConverstStr(
                                  SPECIFICATIONdata['HIM_L'].toString(),
                                ),
                              );
                            } else if (condition.contains("Actual")) {
                              // print(SPECIFICATIONdata['TARGET']);
                              SPECIFICATION = 'Actual';
                            }
                          }
                        } catch (er) {
                          print(er);
                        }

                        // print(maxdata);
                        // print(datainside.length);
                        String PIC1dataBUFF = '';
                        String PIC2dataBUFF = '';
                        String PIC3dataBUFF = '';
                        String PIC4dataBUFF = '';
                        if (datainside[pcsi] != null) {
                          //
                          PIC1dataBUFF = datainside[pcsi]['PIC1data'] != null
                              ? datainside[pcsi]['PIC1data'].toString()
                              : "";
                          PIC2dataBUFF = datainside[pcsi]['PIC2data'] != null
                              ? datainside[pcsi]['PIC2data'].toString()
                              : "";
                          PIC3dataBUFF = datainside[pcsi]['PIC3data'] != null
                              ? datainside[pcsi]['PIC3data'].toString()
                              : "";
                          PIC4dataBUFF = datainside[pcsi]['PIC4data'] != null
                              ? datainside[pcsi]['PIC4data'].toString()
                              : "";
                        }

                        for (pcsi = 0; pcsi < datainside.length; pcsi++) {
                          // print(datainside[pcsi]);
                          datainpcsi.DATA01 = double.parse(
                            ConverstStr(PIC1dataBUFF),
                          ).toStringAsFixed(desinal);
                          datainpcsi.DATA02 = double.parse(
                            ConverstStr(PIC2dataBUFF),
                          ).toStringAsFixed(desinal);
                          datainpcsi.DATA03 = double.parse(
                            ConverstStr(PIC3dataBUFF),
                          ).toStringAsFixed(desinal);
                          datainpcsi.DATA04 = double.parse(
                            ConverstStr(PIC4dataBUFF),
                          ).toStringAsFixed(desinal);

                          if (PIC1dataBUFF == '0') {
                            //

                            datainpcsi.DATAAVG = '';
                            datainpcsi.dimensionX = 0;
                          } else if (PIC2dataBUFF == '0') {
                            //
                            double data0001 = double.parse(
                              ConverstStr(PIC1dataBUFF),
                            );

                            datainpcsi.DATAAVG = ((data0001) / 1)
                                .toStringAsFixed(desinal);

                            datainpcsi.dimensionX = 1;

                            passlist.add(
                              checkdata(maxdata, mindata, data0001).toString(),
                            );
                          } else if (PIC3dataBUFF == '0') {
                            //
                            double data0001 = double.parse(
                              ConverstStr(PIC1dataBUFF),
                            );
                            double data0002 = double.parse(
                              ConverstStr(PIC2dataBUFF),
                            );

                            datainpcsi.DATAAVG = ((data0001 + data0002) / 2)
                                .toStringAsFixed(desinal);
                            datainpcsi.dimensionX = 2;

                            passlist.add(
                              checkdata(maxdata, mindata, data0001).toString(),
                            );

                            passlist.add(
                              checkdata(maxdata, mindata, data0002).toString(),
                            );
                          } else if (PIC4dataBUFF == '0') {
                            //
                            double data0001 = double.parse(
                              ConverstStr(PIC1dataBUFF),
                            );
                            double data0002 = double.parse(
                              ConverstStr(PIC2dataBUFF),
                            );
                            double data0003 = double.parse(
                              ConverstStr(PIC3dataBUFF),
                            );

                            datainpcsi.DATAAVG =
                                ((data0001 + data0002 + data0003) / 3)
                                    .toStringAsFixed(desinal);
                            datainpcsi.dimensionX = 3;
                            passlist.add(
                              checkdata(maxdata, mindata, data0001).toString(),
                            );
                            passlist.add(
                              checkdata(maxdata, mindata, data0002).toString(),
                            );
                            passlist.add(
                              checkdata(maxdata, mindata, data0003).toString(),
                            );
                          } else {
                            double data0001 = double.parse(
                              ConverstStr(PIC1dataBUFF),
                            );
                            double data0002 = double.parse(
                              ConverstStr(PIC2dataBUFF),
                            );
                            double data0003 = double.parse(
                              ConverstStr(PIC3dataBUFF),
                            );
                            double data0004 = double.parse(
                              ConverstStr(PIC4dataBUFF),
                            );

                            datainpcsi.DATAAVG =
                                ((data0001 + data0002 + data0003 + data0003) /
                                        4)
                                    .toStringAsFixed(desinal);
                            datainpcsi.dimensionX = 4;
                            passlist.add(
                              checkdata(maxdata, mindata, data0001).toString(),
                            );
                            passlist.add(
                              checkdata(maxdata, mindata, data0002).toString(),
                            );
                            passlist.add(
                              checkdata(maxdata, mindata, data0003).toString(),
                            );
                            passlist.add(
                              checkdata(maxdata, mindata, data0004).toString(),
                            );
                          }
                          if (datainside[pcsi] != null) {
                            if (BasicCommonDATAs.PIC01 != '') {
                              BasicCommonDATAs.PIC03 = datainside[pcsi]['PIC1']
                                  .toString();
                              if (BasicCommonDATAs.PIC02 != NOPIC) {
                                BasicCommonDATAs.ITEMPIC02 = ITEMname;
                              }
                            }

                            if (pcsi == 0) {
                              if (BasicCommonDATAs.PIC01 == '') {
                                BasicCommonDATAs.PIC01 =
                                    datainside[pcsi]['PIC1'].toString();
                                if (BasicCommonDATAs.PIC01 != NOPIC) {
                                  BasicCommonDATAs.ITEMPIC01 = ITEMname;
                                }
                              }
                              if (BasicCommonDATAs.PIC02 == '') {
                                BasicCommonDATAs.PIC02 =
                                    datainside[pcsi]['PIC2'].toString();
                                if (BasicCommonDATAs.PIC02 != NOPIC) {
                                  BasicCommonDATAs.ITEMPIC02 = ITEMname;
                                }
                              }
                              if (BasicCommonDATAs.PIC03 == '') {
                                BasicCommonDATAs.PIC03 =
                                    datainside[pcsi]['PIC3'].toString();
                                if (BasicCommonDATAs.PIC03 != NOPIC) {
                                  BasicCommonDATAs.ITEMPIC03 = ITEMname;
                                }
                              }
                            }

                            if (pcsi == 1) {
                              if (BasicCommonDATAs.PIC02 == '') {
                                BasicCommonDATAs.PIC02 =
                                    datainside[pcsi]['PIC2'].toString();
                                if (BasicCommonDATAs.PIC02 != NOPIC) {
                                  BasicCommonDATAs.ITEMPIC02 = ITEMname;
                                }
                              }
                            }
                          }
                        }

                        // for (pcsi = 0; pcsi < datainside.length; pcsi++) {
                        //   // print(datainside[pcsi]);
                        //   datainpcsi.DATA01 = double.parse(ConverstStr(
                        //           datainside[pcsi]['PIC1data'].toString()))
                        //       .toStringAsFixed(desinal);
                        //   datainpcsi.DATA02 = double.parse(ConverstStr(
                        //           datainside[pcsi]['PIC2data'].toString()))
                        //       .toStringAsFixed(desinal);
                        //   datainpcsi.DATA03 = double.parse(ConverstStr(
                        //           datainside[pcsi]['PIC3data'].toString()))
                        //       .toStringAsFixed(desinal);
                        //   datainpcsi.DATA04 = double.parse(ConverstStr(
                        //           datainside[pcsi]['PIC4data'].toString()))
                        //       .toStringAsFixed(desinal);

                        //   if (datainside[pcsi]['PIC1data'].toString() == '0') {
                        //     //

                        //     datainpcsi.DATAAVG = '';
                        //     datainpcsi.dimensionX = 0;
                        //   } else if (datainside[pcsi]['PIC2data'].toString() ==
                        //       '0') {
                        //     //
                        //     double data0001 = double.parse(ConverstStr(
                        //         datainside[pcsi]['PIC1data'].toString()));

                        //     datainpcsi.DATAAVG =
                        //         ((data0001) / 1).toStringAsFixed(desinal);

                        //     datainpcsi.dimensionX = 1;

                        //     passlist.add(
                        //         checkdata(maxdata, mindata, data0001).toString());
                        //   } else if (datainside[pcsi]['PIC3data'].toString() ==
                        //       '0') {
                        //     //
                        //     double data0001 = double.parse(ConverstStr(
                        //         datainside[pcsi]['PIC1data'].toString()));
                        //     double data0002 = double.parse(ConverstStr(
                        //         datainside[pcsi]['PIC2data'].toString()));

                        //     datainpcsi.DATAAVG = ((data0001 + data0002) / 2)
                        //         .toStringAsFixed(desinal);
                        //     datainpcsi.dimensionX = 2;

                        //     passlist.add(
                        //         checkdata(maxdata, mindata, data0001).toString());

                        //     passlist.add(
                        //         checkdata(maxdata, mindata, data0002).toString());
                        //   } else if (datainside[pcsi]['PIC4data'].toString() ==
                        //       '0') {
                        //     //
                        //     double data0001 = double.parse(ConverstStr(
                        //         datainside[pcsi]['PIC1data'].toString()));
                        //     double data0002 = double.parse(ConverstStr(
                        //         datainside[pcsi]['PIC2data'].toString()));
                        //     double data0003 = double.parse(ConverstStr(
                        //         datainside[pcsi]['PIC3data'].toString()));

                        //     datainpcsi.DATAAVG =
                        //         ((data0001 + data0002 + data0003) / 3)
                        //             .toStringAsFixed(desinal);
                        //     datainpcsi.dimensionX = 3;
                        //     passlist.add(
                        //         checkdata(maxdata, mindata, data0001).toString());
                        //     passlist.add(
                        //         checkdata(maxdata, mindata, data0002).toString());
                        //     passlist.add(
                        //         checkdata(maxdata, mindata, data0003).toString());
                        //   } else {
                        //     double data0001 = double.parse(ConverstStr(
                        //         datainside[pcsi]['PIC1data'].toString()));
                        //     double data0002 = double.parse(ConverstStr(
                        //         datainside[pcsi]['PIC2data'].toString()));
                        //     double data0003 = double.parse(ConverstStr(
                        //         datainside[pcsi]['PIC3data'].toString()));
                        //     double data0004 = double.parse(ConverstStr(
                        //         datainside[pcsi]['PIC4data'].toString()));

                        //     datainpcsi.DATAAVG =
                        //         ((data0001 + data0002 + data0003 + data0003) / 4)
                        //             .toStringAsFixed(desinal);
                        //     datainpcsi.dimensionX = 4;
                        //     passlist.add(
                        //         checkdata(maxdata, mindata, data0001).toString());
                        //     passlist.add(
                        //         checkdata(maxdata, mindata, data0002).toString());
                        //     passlist.add(
                        //         checkdata(maxdata, mindata, data0003).toString());
                        //     passlist.add(
                        //         checkdata(maxdata, mindata, data0004).toString());
                        //   }
                        //   // print('>>${datainpcsi.DATA01}');
                        //   // print('>>${datainpcsi.DATA02}');
                        //   // print('>>${datainpcsi.DATA03}');

                        //   // print('>>${datainpcsi.DATAAVG}');
                        //   if (BasicCommonDATAs.PIC01 != '') {
                        //     BasicCommonDATAs.PIC03 =
                        //         datainside[pcsi]['PIC1'].toString();
                        //   }

                        //   if (pcsi == 0) {
                        //     if (BasicCommonDATAs.PIC01 == '') {
                        //       BasicCommonDATAs.PIC01 =
                        //           datainside[pcsi]['PIC1'].toString();
                        //     }
                        //     if (BasicCommonDATAs.PIC02 == '') {
                        //       BasicCommonDATAs.PIC02 =
                        //           datainside[pcsi]['PIC2'].toString();
                        //     }
                        //   }

                        //   if (pcsi == 1) {
                        //     if (BasicCommonDATAs.PIC02 == '') {
                        //       BasicCommonDATAs.PIC02 =
                        //           datainside[pcsi]['PIC2'].toString();
                        //     }
                        //   }
                        // }
                        // print("BasicCommonDATAs.PIC01");
                        //3310275879
                        //3310275807
                        // datainpcsi.dimensionX = pcsi;
                        listdataset.add(datainpcsi);
                      } else {
                        break;
                      }
                    }

                    // print(PATTERNlist['FINAL'][fi]['POINT']);

                    // print(SPECIFICATION);

                    double avgall = 0;
                    for (var ig = 0; ig < listdataset.length; ig++) {
                      // print(ConverstStr(listdataset[ig].DATAAVG));
                      avgall =
                          avgall +
                          double.parse(ConverstStr(listdataset[ig].DATAAVG));
                    }

                    ITEMlist.add(
                      FINALCHECKlistCommonClass(
                        TYPE: "Picture",
                        ITEM: itemss,
                        ITEMname: ITEMname,
                        METHOD: METHODss,
                        METHODname: METHODname,
                        SCMARK: SCmasks,
                        SPECIFICATION: "TP STD",
                        NO: NO_NUMBER,
                        FREQ: FREQ,
                        datapackset: listdataset,
                        RESULT: "Good",
                        LOAD: LOAD,
                        SRAWDATA: "",
                        // Remark: remark,
                      ),
                    );
                  }
                }
              }
            }
            int ocrcou = 0;
            // print(PATTERNlist['FINAL'][fi]['RESULTFORMAT']);
            if (PATTERNlist['FINAL'][fi]['RESULTFORMAT'] == 'OCR') {
              for (var mi = 0; mi < MACHINElist.length; mi++) {
                // print("----${PATTERNlist['FINAL'][fi]['ITEMs']}");
                if (FINALdata[MACHINElist[mi]] != null) {
                  if (FINALdata[MACHINElist[mi]][PATTERNlist['FINAL'][fi]['ITEMs']] !=
                      null) {
                    // print(PATTERNlist['FINAL'][fi]['SPECIFICATION']);
                    // print(FINALdata[MACHINElist[mi]]

                    String POINTs = (int.parse(
                      ConverstStrOne(
                        PATTERNlist['FINAL'][fi]['PCS'].toString(),
                      ),
                    )).toString();

                    String SPECIFICATIONbuff =
                        PATTERNlist['FINAL'][fi]['SPECIFICATIONve'].toString();
                    var SPECIFICATIONbuffs =
                        PATTERNlist['FINAL'][fi]['SPECIFICATION'];
                    String itemss = PATTERNlist['FINAL'][fi]['ITEMs']
                        .toString();
                    String UNITssp = PATTERNlist['FINAL'][fi]['UNIT']
                        .toString();
                    String SCmasks = PATTERNlist['FINAL'][fi]['SCMARK']
                        .toString();
                    String ITEMname = '';
                    String METHODss = '';
                    String METHODname = '';
                    String FREQ =
                        '${POINTs} ${PATTERNlist['FINAL'][fi]['FREQUENCY'].toString().replaceAll('?', 'pcs/Lot').replaceAll('[]', 'pcs/Lot')}';
                    // print(FREQ);
                    String SPECIFICATION = '';
                    String LOAD = PATTERNlist['FINAL'][fi]['LOAD'].toString();

                    String SRAWDATA = PATTERNlist['FINAL'][fi]['SRAWDATA']
                        .toString();

                    String remark = PATTERNlist['FINAL'][fi]['REMARK']
                        .toString();

                    String SUMDATA = PATTERNlist['FINAL'][fi]['SUMDATA']
                        .toString();
                    // print('>>${remark}');

                    String convss = PATTERNlist['FINAL'][fi]['CONVERSE']
                        .toString();

                    if (convss != '') {
                      for (var ih = 0; ih < UNITlist.length; ih++) {
                        // print(UNITlist[ih]['masterID'].toString());
                        if (convss == UNITlist[ih]['masterID'].toString()) {
                          // print(UNITlist[ih]);
                          remark = "${UNITlist[ih]['UNIT']}";
                          break;
                        }
                      }
                    }

                    for (var Fci = 0; Fci < METHODlist.length; Fci++) {
                      if (METHODlist[Fci]['masterID'].toString() == METHODss) {
                        METHODname = METHODlist[Fci]['METHOD'].toString();
                        break;
                      }
                    }

                    for (var Fci = 0; Fci < FINALCHECKlist.length; Fci++) {
                      if (FINALCHECKlist[Fci]['key'].toString() == itemss) {
                        ITEMname = FINALCHECKlist[Fci]['value'].toString();
                        METHODss = FINALCHECKlist[Fci]['METHOD'].toString();
                      }
                    }

                    for (var Fci = 0; Fci < METHODlist.length; Fci++) {
                      if (METHODlist[Fci]['masterID'].toString() == METHODss) {
                        METHODname = METHODlist[Fci]['METHOD'].toString();
                        break;
                      }
                    }

                    int desinal = 1;
                    // print(itemss);
                    // for (var Fci = 0; Fci < ITEMSlist.length; Fci++) {
                    //   if (ITEMSlist[Fci]['masterID'].toString() == itemss) {
                    //     if (ITEMSlist[Fci]['ITEMs']
                    //         .toString()
                    //         .contains("pound")) {
                    //       desinal = 1;
                    //     }
                    //     if (ITEMSlist[Fci]['ITEMs'].toString().contains("trid")) {
                    //       desinal = 1;
                    //     } else {
                    //       desinal = 1;
                    //     }
                    //   }
                    // }
                    // for (var B = 0; B < ITEMSlist.length; B++) {
                    //   for (var d = 0; d < DESIMALlist.length; d++) {
                    //     if (DESIMALlist[d]['ITEMs'].toString() ==
                    //         ITEMSlist[B]['masterID'].toString()) {
                    //       desinal =
                    //           int.parse(ConverstStr(DESIMALlist[d]['DESIMAL01']));
                    //     }
                    //   }
                    // }

                    //UNITlist

                    // for (var d = 0; d < DESIMALlist.length; d++) {
                    //   if (DESIMALlist[d]['ITEMs'].toString() == itemss) {
                    //     desinal =
                    //         int.parse(ConverstStr(DESIMALlist[d]['DESIMAL01']));
                    //     break;
                    //   } else {
                    //     desinal = 1;
                    //   }
                    // }

                    for (var d = 0; d < UNITlist.length; d++) {
                      if (UNITlist[d]['masterID'].toString() == UNITssp) {
                        desinal = int.parse(
                          ConverstStr(UNITlist[d]['DESIMAL'].toString()),
                        );

                        break;
                      } else {
                        desinal = 1;
                      }
                    }

                    List<datainlist> listdataset = [];
                    for (var i = 0; i < 20; i++) {
                      if (FINALdata[MACHINElist[mi]][PATTERNlist['FINAL'][fi]['ITEMs']]['PSC${i + 1}'] !=
                          null) {
                        //
                        // print(FINALdata[MACHINElist[mi]]
                        //         [PATTERNlist['FINAL'][fi]['ITEMs']]['PSC${i + 1}']
                        //     .length);

                        var datainside =
                            FINALdata[MACHINElist[mi]][PATTERNlist['FINAL'][fi]['ITEMs']]['PSC${i + 1}'];

                        datainlist datainpcsi = datainlist();
                        int pcsi = 0;

                        // print(datainside.length);

                        double maxdata = 0;
                        double mindata = 0;

                        String remark = '';

                        try {
                          String SPECIFICATIONbuff2 =
                              SPECIFICATIONbuff.replaceAll('{', '{"');
                          String SPECIFICATIONbuff3 =
                              SPECIFICATIONbuff2.replaceAll('}', '"}');
                          String SPECIFICATIONbuff4 =
                              SPECIFICATIONbuff3.replaceAll(':', '":"');
                          String SPECIFICATIONbuff5 =
                              SPECIFICATIONbuff4.replaceAll(',', '","');
                          // print(SPECIFICATIONbuff5);

                          var SPECIFICATIONdata = json.decode(
                            SPECIFICATIONbuff5.replaceAll(' ', ''),
                          );
                          //

                          if (SPECIFICATIONdata['condition'] != null) {
                            // print(SPECIFICATIONdata['condition']);
                            String condition = SPECIFICATIONdata['condition']
                                .toString();

                            // print(condition);
                            // print(condition.contains("LOL(<)"));
                            // print(condition.contains("HIM(>)"));
                            // Actual
                            // print(SPECIFICATIONdata);

                            // print(PATTERNlist['FINAL'][fi]);
                            String dataUNIT = PATTERNlist['FINAL'][fi]['UNIT']
                                .toString();

                            String unitP = '';
                            String unitPC = '';

                            for (var ih = 0; ih < UNITlist.length; ih++) {
                              // print(UNITlist[ih]['masterID'].toString());
                              if (dataUNIT ==
                                  UNITlist[ih]['masterID'].toString()) {
                                // print(UNITlist[ih]);
                                unitP = UNITlist[ih]['UNIT'].toString();
                                break;
                              }
                            }

                            if (condition.contains("BTW")) {
                              // print(SPECIFICATIONdata['BTW_LOW']);
                              // print(SPECIFICATIONdata['BTW_HI']);
                              SPECIFICATION =
                                  '${SPECIFICATIONdata['BTW_LOW'].toString()}-${SPECIFICATIONdata['BTW_HI'].toString()} ${unitP.replaceAll('?', 'µ')}';
                              maxdata = double.parse(
                                ConverstStr(
                                  SPECIFICATIONdata['BTW_HI'].toString(),
                                ),
                              );
                              mindata = double.parse(
                                ConverstStr(
                                  SPECIFICATIONdata['BTW_LOW'].toString(),
                                ),
                              );
                            } else if (condition.contains("LOL(<)")) {
                              // print(SPECIFICATIONdata['LOL_H']);
                              SPECIFICATION =
                                  '≤ ${SPECIFICATIONdata['LOL_H'].toString()} ${unitP.replaceAll('?', 'µ')}';
                              maxdata = double.parse(
                                ConverstStr(
                                  SPECIFICATIONdata['LOL_H'].toString(),
                                ),
                              );
                            } else if (condition.contains("HIM(>)")) {
                              // print(SPECIFICATIONdata['HIM_L']);
                              SPECIFICATION =
                                  '≥ ${SPECIFICATIONdata['HIM_L'].toString()} ${unitP.replaceAll('?', 'µ')}';
                              mindata = double.parse(
                                ConverstStr(
                                  SPECIFICATIONdata['HIM_L'].toString(),
                                ),
                              );
                            } else if (condition.contains("Actual")) {
                              // print(SPECIFICATIONdata['TARGET']);
                              SPECIFICATION = 'Actual';
                            } else if (condition.contains("SPECIFICATION")) {
                              // print(SPECIFICATIONdata['TARGET']);
                              //SPECIFICATION

                              // String SPECIFICATIONbuffs2 =
                              //     SPECIFICATIONbuff.replaceAll('{', '{"');
                              // String SPECIFICATIONbuffs3 =
                              //     SPECIFICATIONbuffs2.replaceAll('}', '"}');
                              // String SPECIFICATIONbuffs4 =
                              //     SPECIFICATIONbuffs3.replaceAll(':', '":"');
                              // String SPECIFICATIONbuffs5 =
                              //     SPECIFICATIONbuffs4.replaceAll(',', '","');
                              // // print(SPECIFICATIONbuff5);
                              // var SPECIFICATIONdata = json
                              //     .decode(SPECIFICATIONbuff5.replaceAll(' ', ''));

                              // var data = json.decode(
                              //     SPECIFICATIONbuffs5.replaceAll(' ', ''));

                              if (SPECIFICATIONbuffs.length > 0) {
                                if (SPECIFICATIONbuffs[0]['name'] != null) {
                                  SPECIFICATION = SPECIFICATIONbuffs[0]['name']
                                      .toString();
                                }
                              }
                            }
                          }
                        } catch (er) {
                          print(er);
                          if (SPECIFICATIONbuffs.length > 0) {
                            if (SPECIFICATIONbuffs[0]['name'] != null) {
                              SPECIFICATION = SPECIFICATIONbuffs[0]['name']
                                  .toString();
                            }
                          }
                        }

                        if (SPECIFICATION == '') {
                          SPECIFICATION = 'TP STD.';
                        }

                        // print(maxdata);
                        // print(datainside.length);
                        String PIC1dataBUFF = '';
                        String PIC2dataBUFF = '';
                        String PIC3dataBUFF = '';
                        String PIC4dataBUFF = '';
                        if (datainside[pcsi] != null) {
                          //
                          PIC1dataBUFF = datainside[pcsi]['PIC1data'] != null
                              ? datainside[pcsi]['PIC1data'].toString()
                              : "";
                          PIC2dataBUFF = datainside[pcsi]['PIC2data'] != null
                              ? datainside[pcsi]['PIC2data'].toString()
                              : "";
                          PIC3dataBUFF = datainside[pcsi]['PIC3data'] != null
                              ? datainside[pcsi]['PIC3data'].toString()
                              : "";
                          PIC4dataBUFF = datainside[pcsi]['PIC4data'] != null
                              ? datainside[pcsi]['PIC4data'].toString()
                              : "";
                        }

                        for (pcsi = 0; pcsi < datainside.length; pcsi++) {
                          // print(datainside[pcsi]);
                          datainpcsi.DATA01 = double.parse(
                            ConverstStr(PIC1dataBUFF),
                          ).toStringAsFixed(desinal);
                          datainpcsi.DATA02 = double.parse(
                            ConverstStr(PIC2dataBUFF),
                          ).toStringAsFixed(desinal);
                          datainpcsi.DATA03 = double.parse(
                            ConverstStr(PIC3dataBUFF),
                          ).toStringAsFixed(desinal);
                          datainpcsi.DATA04 = double.parse(
                            ConverstStr(PIC4dataBUFF),
                          ).toStringAsFixed(desinal);

                          if (PIC1dataBUFF == '0') {
                            //

                            datainpcsi.DATAAVG = '';
                            datainpcsi.dimensionX = 0;
                          } else if (PIC2dataBUFF == '0') {
                            //
                            double data0001 = double.parse(
                              ConverstStr(PIC1dataBUFF),
                            );

                            datainpcsi.DATAAVG = ((data0001) / 1)
                                .toStringAsFixed(desinal);

                            datainpcsi.dimensionX = 1;

                            passlist.add(
                              checkdata(maxdata, mindata, data0001).toString(),
                            );
                          } else if (PIC3dataBUFF == '0') {
                            //
                            double data0001 = double.parse(
                              ConverstStr(PIC1dataBUFF),
                            );
                            double data0002 = double.parse(
                              ConverstStr(PIC2dataBUFF),
                            );

                            datainpcsi.DATAAVG = ((data0001 + data0002) / 2)
                                .toStringAsFixed(desinal);
                            datainpcsi.dimensionX = 2;

                            passlist.add(
                              checkdata(maxdata, mindata, data0001).toString(),
                            );

                            passlist.add(
                              checkdata(maxdata, mindata, data0002).toString(),
                            );
                          } else if (PIC4dataBUFF == '0') {
                            //
                            double data0001 = double.parse(
                              ConverstStr(PIC1dataBUFF),
                            );
                            double data0002 = double.parse(
                              ConverstStr(PIC2dataBUFF),
                            );
                            double data0003 = double.parse(
                              ConverstStr(PIC3dataBUFF),
                            );

                            datainpcsi.DATAAVG =
                                ((data0001 + data0002 + data0003) / 3)
                                    .toStringAsFixed(desinal);
                            datainpcsi.dimensionX = 3;
                            passlist.add(
                              checkdata(maxdata, mindata, data0001).toString(),
                            );
                            passlist.add(
                              checkdata(maxdata, mindata, data0002).toString(),
                            );
                            passlist.add(
                              checkdata(maxdata, mindata, data0003).toString(),
                            );
                          } else {
                            double data0001 = double.parse(
                              ConverstStr(PIC1dataBUFF),
                            );
                            double data0002 = double.parse(
                              ConverstStr(PIC2dataBUFF),
                            );
                            double data0003 = double.parse(
                              ConverstStr(PIC3dataBUFF),
                            );
                            double data0004 = double.parse(
                              ConverstStr(PIC4dataBUFF),
                            );

                            datainpcsi.DATAAVG =
                                ((data0001 + data0002 + data0003 + data0003) /
                                        4)
                                    .toStringAsFixed(desinal);
                            datainpcsi.dimensionX = 4;
                            passlist.add(
                              checkdata(maxdata, mindata, data0001).toString(),
                            );
                            passlist.add(
                              checkdata(maxdata, mindata, data0002).toString(),
                            );
                            passlist.add(
                              checkdata(maxdata, mindata, data0003).toString(),
                            );
                            passlist.add(
                              checkdata(maxdata, mindata, data0004).toString(),
                            );
                          }

                          if (datainside[pcsi] != null) {
                            if (BasicCommonDATAs.PIC01 != '') {
                              BasicCommonDATAs.PIC03 = datainside[pcsi]['PIC1']
                                  .toString();
                              print("-------->1");
                            }

                            if (pcsi == 0) {
                              if (BasicCommonDATAs.PIC01 == '') {
                                BasicCommonDATAs.PIC01 =
                                    datainside[pcsi]['PIC1'].toString();
                                print("-------->3");
                              }
                              if (BasicCommonDATAs.PIC02 == '') {
                                BasicCommonDATAs.PIC02 =
                                    datainside[pcsi]['PIC2'].toString();
                                print("-------->4");
                              }
                              if (BasicCommonDATAs.PIC03 == '') {
                                BasicCommonDATAs.PIC03 =
                                    datainside[pcsi]['PIC3'].toString();
                                print("-------->4");
                              }
                            }

                            if (pcsi == 1) {
                              if (BasicCommonDATAs.PIC02 == '') {
                                print("-------->5");
                                BasicCommonDATAs.PIC02 =
                                    datainside[pcsi]['PIC2'].toString();
                              }
                            }

                            if (BasicCommonDATAs.PIC01 !=
                                datainside[pcsi]['PIC1'].toString()) {
                              BasicCommonDATAs.PIC02 = datainside[pcsi]['PIC1']
                                  .toString();
                              print("-------->2");
                            }
                          }
                        }

                        // print("BasicCommonDATAs.PIC01");
                        //3310275879
                        //3310275807
                        // datainpcsi.dimensionX = pcsi;
                        listdataset.add(datainpcsi);
                      } else {
                        break;
                      }
                    }

                    // print(PATTERNlist['FINAL'][fi]['POINT']);

                    // print(SPECIFICATION);

                    double avgall = 0;
                    String avgout = '';
                    for (var ig = 0; ig < listdataset.length; ig++) {
                      // print(ConverstStr(listdataset[ig].DATAAVG));
                      avgall =
                          avgall +
                          double.parse(ConverstStr(listdataset[ig].DATAAVG));
                    }

                    if (avgall == 0) {
                      avgout = "PASS";
                    } else {
                      avgout = avgall.toStringAsFixed(desinal);
                    }
                    if (SUMDATA == 'NO') {
                      avgout = "PASS";
                    }

                    ITEMlist.add(
                      FINALCHECKlistCommonClass(
                        TYPE: "OCR",
                        ITEM: itemss,
                        ITEMname: ITEMname,
                        METHOD: METHODss,
                        METHODname: METHODname,
                        SCMARK: SCmasks,
                        SPECIFICATION: SPECIFICATION,
                        NO: NO_NUMBER,
                        FREQ: FREQ,
                        datapackset: listdataset,
                        RESULT: avgout,
                        LOAD: LOAD,
                        Remark: remark,
                      ),
                    );
                  }
                }
              }
            }
          }
        }
        // print('>>${ITEMlist.length}');

        if (passlist.contains("false")) {
          BasicCommonDATAs.PASS = 'NO PASSED';
        } else {
          BasicCommonDATAs.PASS = 'PASSED';
        }

        output.databasic = BasicCommonDATAs;
        output.datain = ITEMlist;
      }
      //-----------
      var now1 = DateTime.now().subtract(Duration(days: 30));
      var now2 = DateTime.now().add(Duration(days: 5));
      String day = DateFormat('dd').format(now1);
      String month = DateFormat('MM').format(now1);
      String year = DateFormat('yyyy').format(now1);

      String days = DateFormat('dd').format(now2);
      String months = DateFormat('MM').format(now2);
      String years = DateFormat('yyyy').format(now2);
      // final response9 = await Dio().post(
      //   "${server2}10GETDATAFROMJOBBINGAQC/GETDATA",
      //   data: {
      //     "HEADER": {
      //       "PLANT": "2100",
      //       "ORD_ST_DATE_FR": "${day}.${month}.${year}",
      //       "ORD_ST_DATE_TO": "${days}.${months}.${years}",
      //       "ORDER_TYPE": "",
      //       "PROD_SUP": ""
      //     },
      //     "PROC_ORD": [
      //       {"PROCESS_ORDER": PO, "MATERIAL": ""}
      //     ]
      //   },
      // );
      // if (response9.statusCode == 200) {
      //   var databuffref = response9.data;
      //   // print(databuffref);
      //   if (databuffref['HEADER_INFO'] != null) {
      //     if (databuffref['HEADER_INFO'].length > 0) {
      //       // print(databuffref['HEADER_INFO'][0]['USER_STATUS']);
      //       output.databasic.USER_STATUS =
      //           databuffref['HEADER_INFO'][0]['USER_STATUS'].toString();
      //     }
      //   }
      // }
    }
    print(passlist);
    // print(BasicCommonDATAs.PASS);

    emit(output);
  }

  Future<void> Flush() async {
    CommonReportOutput output = CommonReportOutput(
      databasic: BasicCommonDATA(),
    );
    emit(output);
  }
}

class FINALCHECKlistCommonClass {
  FINALCHECKlistCommonClass({
    this.NO = 0,
    this.TYPE = '',
    this.ITEM = '',
    this.ITEMname = '',
    this.METHOD = '',
    this.METHODname = '',
    this.SCMARK = '',
    this.FREQ = '',
    this.SPECIFICATION = '',
    this.SPECIFICATIONname = '',
    this.SPECIFICATIONve = '',
    this.RESULT = '',
    this.CONTROLlimmit = '',
    this.datapackset = const [],
    this.LOAD = '',
    this.Cross = '',
    this.Remark = '',
    this.SRAWDATA = '',
    this.RESULTDSW = '',
    this.unitP = '',
    this.unitPC = '',
    this.GTC = '',
    this.upper = const [],
    this.lower = const [],
    //
  });
  int NO;
  String TYPE;
  String ITEM;
  String ITEMname;
  String METHOD;
  String METHODname;
  String SCMARK;
  String FREQ;
  String SPECIFICATION;
  String SPECIFICATIONname;
  String SPECIFICATIONve;
  String RESULT;
  String CONTROLlimmit;
  List<datainlist> datapackset;
  String LOAD;
  String Cross;
  String Remark;
  String SRAWDATA;
  String RESULTDSW;
  String unitP;
  String unitPC;
  String GTC;
  List<FlSpot> upper;
  List<FlSpot> lower;
  //
}

// class datainlist {
//   datainlist({
//     this.dimensionX = 0,
//     this.dimensionY = 0,
//     this.DATA01 = '',
//     this.DATA02 = '',
//     this.DATA03 = '',
//     this.DATA04 = '',
//     this.DATA05 = '',
//     this.DATA06 = '',
//     this.DATA07 = '',
//     this.DATA08 = '',
//     this.DATA09 = '',
//     this.DATA10 = '',
//     this.DATA11 = '',
//     this.DATA12 = '',
//     this.DATA13 = '',
//     this.DATA14 = '',
//     this.DATA15 = '',
//     this.DATA16 = '',
//     this.DATA17 = '',
//     this.DATA18 = '',
//     this.DATA19 = '',
//     this.DATA20 = '',
//     this.DATAAVG = '',
//   });

//   int dimensionX;
//   int dimensionY;

//   String DATA01;
//   String DATA02;
//   String DATA03;
//   String DATA04;
//   String DATA05;
//   String DATA06;
//   String DATA07;
//   String DATA08;
//   String DATA09;
//   String DATA10;
//   String DATA11;
//   String DATA12;
//   String DATA13;
//   String DATA14;
//   String DATA15;
//   String DATA16;
//   String DATA17;
//   String DATA18;
//   String DATA19;
//   String DATA20;
//   String DATAAVG;
// }

class datainlist {
  datainlist({
    this.TYPE = '',
    this.dimensionX = 0,
    this.dimensionY = 0,
    this.DATA01 = '',
    this.DATA02 = '',
    this.DATA03 = '',
    this.DATA04 = '',
    this.DATA05 = '',
    this.DATA06 = '',
    this.DATA07 = '',
    this.DATA08 = '',
    this.DATA09 = '',
    this.DATA10 = '',
    this.DATA11 = '',
    this.DATA12 = '',
    this.DATA13 = '',
    this.DATA14 = '',
    this.DATA15 = '',
    this.DATA16 = '',
    this.DATA17 = '',
    this.DATA18 = '',
    this.DATA19 = '',
    this.DATA20 = '',
    this.DATA01p = '',
    this.DATA02p = '',
    this.DATA03p = '',
    this.DATA04p = '',
    this.DATA05p = '',
    this.DATA06p = '',
    this.DATA07p = '',
    this.DATA08p = '',
    this.DATA09p = '',
    this.DATA10p = '',
    this.DATA11p = '',
    this.DATA12p = '',
    this.DATA13p = '',
    this.DATA14p = '',
    this.DATA15p = '',
    this.DATA16p = '',
    this.DATA17p = '',
    this.DATA18p = '',
    this.DATA19p = '',
    this.DATA20p = '',
    this.DATAAVG = '',
    this.DATA01c = '',
    this.DATA02c = '',
    this.DATA03c = '',
    this.DATA04c = '',
    this.DATA05c = '',
    this.DATA06c = '',
    this.DATA07c = '',
    this.DATA08c = '',
    this.DATA09c = '',
    this.DATA10c = '',
    this.DATA11c = '',
    this.DATA12c = '',
    this.DATA13c = '',
    this.DATA14c = '',
    this.DATA15c = '',
    this.DATA16c = '',
    this.DATA17c = '',
    this.DATA18c = '',
    this.DATA19c = '',
    this.DATA20c = '',
  });
  String TYPE;
  int dimensionX;
  int dimensionY;

  String DATA01;
  String DATA02;
  String DATA03;
  String DATA04;
  String DATA05;
  String DATA06;
  String DATA07;
  String DATA08;
  String DATA09;
  String DATA10;
  String DATA11;
  String DATA12;
  String DATA13;
  String DATA14;
  String DATA15;
  String DATA16;
  String DATA17;
  String DATA18;
  String DATA19;
  String DATA20;
  String DATA01p;
  String DATA02p;
  String DATA03p;
  String DATA04p;
  String DATA05p;
  String DATA06p;
  String DATA07p;
  String DATA08p;
  String DATA09p;
  String DATA10p;
  String DATA11p;
  String DATA12p;
  String DATA13p;
  String DATA14p;
  String DATA15p;
  String DATA16p;
  String DATA17p;
  String DATA18p;
  String DATA19p;
  String DATA20p;
  String DATAAVG;

  String DATA01c;
  String DATA02c;
  String DATA03c;
  String DATA04c;
  String DATA05c;
  String DATA06c;
  String DATA07c;
  String DATA08c;
  String DATA09c;
  String DATA10c;
  String DATA11c;
  String DATA12c;
  String DATA13c;
  String DATA14c;
  String DATA15c;
  String DATA16c;
  String DATA17c;
  String DATA18c;
  String DATA19c;
  String DATA20c;
}

class BasicCommonDATA {
  BasicCommonDATA({
    this.PO = '',
    this.CP = '',
    this.CUSTOMER = '',
    this.PROCESS = '',
    this.PARTNAME = '',
    this.PARTNO = '',
    this.PARTNO_s = '',
    this.CUSLOT = '',
    this.TPKLOT = '',
    this.MATERIAL = '',
    this.QTY = '',
    this.UNITSAP = '',
    this.PICstd = '',
    this.PIC01 = '',
    this.PIC02 = '',
    this.PIC03 = '',
    this.PARTNAMEref = '',
    this.PARTref = '',
    this.PASS = '',
    this.INC01 = '',
    this.INC02 = '',
    this.USER_STATUS = '',
    this.reportset = '',
    this.ITEMPIC01 = '',
    this.ITEMPIC02 = '',
    this.ITEMPIC03 = '',
    this.Inspected = '',
    this.Check = '',
    this.Approve = '',
    this.Inspected_sign = '',
    this.Check_sign = '',
    this.Approve_sign = '',
    this.GP3POINT = '',
    this.dateInspected = '',
    this.dateCheck = '',
    this.dateApprove = '',
    this.remark = '',
  });

  String PO;
  String CP;
  String CUSTOMER;
  String PROCESS;
  String PARTNAME;
  String PARTNO;
  String PARTNO_s;
  String CUSLOT;
  String TPKLOT;
  String MATERIAL;
  String QTY;
  String PICstd;
  String UNITSAP;
  String PIC01;
  String PIC02;
  String PIC03;

  String PARTNAMEref;
  String PARTref;

  String PASS;

  String INC01;
  String INC02;

  String USER_STATUS;
  String reportset;

  String ITEMPIC01;
  String ITEMPIC02;
  String ITEMPIC03;

  String Inspected;
  String Check;
  String Approve;

  String Inspected_sign;
  String Check_sign;
  String Approve_sign;
  String GP3POINT;

  String dateInspected;
  String dateCheck;
  String dateApprove;

  String remark;
}

class CommonReportOutput {
  CommonReportOutput({this.datain = const [], required this.databasic});

  List<FINALCHECKlistCommonClass> datain;
  BasicCommonDATA databasic;
}

bool checkdata(double maxdata, double mindata, double input) {
  if (maxdata != 0 && mindata != 0) {
    if (input < mindata || input > maxdata) {
      return false;
    } else {
      return true;
    }
  } else if (maxdata != 0 && mindata == 0) {
    if (input > maxdata) {
      return false;
    } else {
      return true;
    }
  } else if (maxdata == 0 && mindata != 0) {
    if (input < mindata) {
      return false;
    } else {
      return true;
    }
  } else {
    return true;
  }
}

String checknull(dynamic input) {
  if (input == null) {
    return "";
  } else {
    return input.toString();
  }
}
