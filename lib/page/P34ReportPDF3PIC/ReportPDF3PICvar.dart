import 'package:fl_chart/fl_chart.dart';

import '../../widget/common/imgset.dart';

class ReportPDF3PICvar {
  static bool iscontrol = false;
  static bool canf = true;
  static String PO = '';

  static String STATUS = '';

  static String CUSTOMER = '';
  static String PROCESS = '';
  static String PARTNAME = '';
  static String PARTNO = '';
  static String CUSLOT = '';
  static String TPKLOT = '';
  static String MATERIAL = '';
  static String QTY = '';

  static String TPKLOTEDIT = '';

  static String PICstd = '';
  static String PIC01 = '';
  static String PIC02 = '';
  static String TYPE = '-';
  static String SCMASKTYPE = SCMASK03;
  static String SCMASKTYPEonTop = '';
  static List<rawlist> rawlistHardness = [];
  static List<rawlist> rawlistCompound = [];
  static List<rawlist> rawlistRoughness = [];
  static List<rawlist> rawlistCORE = [];

  //rawlistCORE

  static List<rawlist> rawlistGraph = [];
  static rawlist rawlistGraphCore = rawlist();

  static String remark = '';

  static String PASS = '';

  static String commp = 'Compound layer';

  static String INC01 = '';
  static String INC02 = '';

  static String SignInsBy = '';

  static List<ReportPDF3PIClist> datalist = [
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
  ];
  static List<FlSpot> graphupper = [];
  static List<FlSpot> graphdata = [];
  static List<FlSpot> graphdata2 = [];
  static List<FlSpot> graphdata3 = [];
  static List<FlSpot> graphdata4 = [];
  static List<FlSpot> graphunder = [];
}

class ReportPDF3PIClist {
  ReportPDF3PIClist({
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
    this.DATA01 = '',
    this.DATA02 = '',
    this.DATA03 = '',
    this.DATAAVG = '',
    this.REMARK = '',
  });
  String ITEM;
  String ITEMname = '';
  String METHOD = '';
  String METHODname = '';
  String SCMARK = '';
  String FREQ = '';
  String SPECIFICATION = '';
  String SPECIFICATIONname = '';
  String SPECIFICATIONve = '';
  String RESULT = '';
  String CONTROLlimmit = '';
  String DATA01 = '';
  String DATA02 = '';
  String DATA03 = '';
  String DATAAVG = '';
  String REMARK = '';
}

class rawlist {
  rawlist({
    this.DATANO = '',
    this.DATAPCS = '',
    this.DATA = '',
  });
  String DATANO;
  String DATAPCS = '';
  String DATA = '';
}

ReportPDFACTclear() {
  ReportPDF3PICvar.PO = '';

  ReportPDF3PICvar.CUSTOMER = '';
  ReportPDF3PICvar.PROCESS = '';
  ReportPDF3PICvar.PARTNAME = '';
  ReportPDF3PICvar.PARTNO = '';
  ReportPDF3PICvar.CUSLOT = '';
  ReportPDF3PICvar.TPKLOT = '';
  ReportPDF3PICvar.MATERIAL = '';
  ReportPDF3PICvar.QTY = '';

  ReportPDF3PICvar.PICstd = '';
  ReportPDF3PICvar.PIC01 = '';
  ReportPDF3PICvar.PIC02 = '';

  ReportPDF3PICvar.SignInsBy = '';
  ReportPDF3PICvar.datalist = [
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
    ReportPDF3PIClist(),
  ];
}
