import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P1FIRSTUI/FIRSTuiVAR.dart';
import '../../page/P7GASMCS002/GASMCS002main.dart';
import '../../page/P7GASMCS002/GASMCS002var.dart';
import '07-01-GASMCS002.dart';

//-------------------------------------------------
String server = GLOserver;
String serverR = 'http://172.101.33.151:1880/';

abstract class TRICKER_Event {}

//--------------------------------

class TRICKER_GETINtoGASMCS002 extends TRICKER_Event {}

//-------------------------------- non returnfunction

class TRICKER_GASMCS002geteachITEM extends TRICKER_Event {}

class TRICKER_GASMCS002geteachGRAPH extends TRICKER_Event {}

class TRICKER_GASMCS002confirmdata extends TRICKER_Event {}

class TRICKER_GASMCS002CLEAR extends TRICKER_Event {}

class TRICKER_GASMCS002RESETVALUE extends TRICKER_Event {}

class TRICKER_GASMCS002SETZERO extends TRICKER_Event {}

//

class TRICKER_GASMCS002getPR extends TRICKER_Event {}

class TRICKER_GASMCS002getCP extends TRICKER_Event {}

//-------------------------------- FINISH

class TRICKER_GASMCS002FINISH extends TRICKER_Event {}

//-------------------------------- no request

class TRICKER_FLUSH extends TRICKER_Event {}

class TRICKER_GASMCS002_Bloc extends Bloc<TRICKER_Event, String> {
  TRICKER_GASMCS002_Bloc() : super('') {
    //--------------------------------
    on<TRICKER_GETINtoGASMCS002>((event, emit) {
      return _TRICKER_GETINtoGASMCS002('', emit);
    });

    //-------------------------------- non returnfunction

    on<TRICKER_GASMCS002geteachITEM>((event, emit) {
      return _TRICKER_GASMCS002geteachITEM('', emit);
    });

    on<TRICKER_GASMCS002confirmdata>((event, emit) {
      return _TRICKER_GASMCS002confirmdata('', emit);
    });

    on<TRICKER_GASMCS002CLEAR>((event, emit) {
      return _TRICKER_GASMCS002CLEAR('', emit);
    });

    on<TRICKER_GASMCS002RESETVALUE>((event, emit) {
      return _TRICKER_GASMCS002RESETVALUE('', emit);
    });

    on<TRICKER_GASMCS002SETZERO>((event, emit) {
      return _TRICKER_GASMCS002SETZERO('', emit);
    });
    //
    on<TRICKER_GASMCS002getPR>((event, emit) {
      return _TRICKER_GASMCS002getPR('', emit);
    });

    on<TRICKER_GASMCS002getCP>((event, emit) {
      return _TRICKER_GASMCS002getCP('', emit);
    });

    //-------------------------------- FINISH

    on<TRICKER_GASMCS002FINISH>((event, emit) {
      return _TRICKER_GASMCS002FINISH('', emit);
    });

    //-------------------------------- no request

    on<TRICKER_FLUSH>((event, emit) {
      return _TRICKER_FLUSH('', emit);
    });
  }

  Future<void> _TRICKER_GETINtoGASMCS002(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoGASMCS002',
      data: {
        "PO": FIRSTUI.POACTIVE,
        "CP": FIRSTUI.CPACTIVE,
      },
    );
    String output = '';
    if (response.statusCode == 200) {
      var databuff = response.data;
      if (databuff.toString() == 'OK') {
        output = 'OK';
      } else {
        output = 'NOK';
      }
    } else {
      //
    }
    MICROSCOPEGASMCS002_CONTEXT.read<GASMCS002_Bloc>().add(GASMCS002_READ());
    emit(output);
  }

  Future<void> _TRICKER_GASMCS002geteachITEM(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASMCS002-geteachITEM',
      data: {
        "ITEMs": GASMCS002var.ItemPickSELECT,
      },
    );
    MICROSCOPEGASMCS002_CONTEXT.read<GASMCS002_Bloc>().add(GASMCS002_READ());
    emit('');
  }

  Future<void> _TRICKER_GASMCS002confirmdata(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASMCS002-confirmdata',
      data: {},
    );
    MICROSCOPEGASMCS002_CONTEXT.read<GASMCS002_Bloc>().add(GASMCS002_READ());
    emit('');
  }

  Future<void> _TRICKER_GASMCS002CLEAR(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASMCS002-CLEAR',
      data: {},
    );
    MICROSCOPEGASMCS002_CONTEXT.read<GASMCS002_Bloc>().add(GASMCS002_READ());
    emit('');
  }

  Future<void> _TRICKER_GASMCS002RESETVALUE(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASMCS002-RESETVALUE',
      data: {},
    );
    MICROSCOPEGASMCS002_CONTEXT.read<GASMCS002_Bloc>().add(GASMCS002_READ());
    emit('');
  }

  Future<void> _TRICKER_GASMCS002SETZERO(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASMCS002-SETZERO',
      data: {},
    );
    emit('');
  }

  //
  Future<void> _TRICKER_GASMCS002getPR(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      serverR + 'getPR',
      data: {
        "MC": GASMCS002var.selectINS,
      },
    );
    String output = '';
    if (response.statusCode == 200) {
      var databuff = response.data;
      GASMCS002var.base64pic01data =
          databuff['DATA1'] != null ? databuff['DATA1'].toString() : "";
      GASMCS002var.base64pic02data =
          databuff['DATA2'] != null ? databuff['DATA2'].toString() : "";
      GASMCS002var.base64pic03data =
          databuff['DATA3'] != null ? databuff['DATA3'].toString() : "";
      GASMCS002var.base64pic04data =
          databuff['DATA4'] != null ? databuff['DATA4'].toString() : "";
    } else {
      //
    }
    MICROSCOPEGASMCS002_CONTEXT.read<GASMCS002_Bloc>().add(GASMCS002_READ());
    emit(output);
  }

  Future<void> _TRICKER_GASMCS002getCP(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      serverR + 'getCP',
      data: {
        "MC": GASMCS002var.selectINS,
      },
    );
    if (response.statusCode == 200) {
      var databuff = response.data;
      GASMCS002var.base64pic01data =
          databuff['DATA1'] != null ? databuff['DATA1'].toString() : "";
      GASMCS002var.base64pic02data =
          databuff['DATA2'] != null ? databuff['DATA2'].toString() : "";
      GASMCS002var.base64pic03data =
          databuff['DATA3'] != null ? databuff['DATA3'].toString() : "";
      GASMCS002var.base64pic04data =
          databuff['DATA4'] != null ? databuff['DATA4'].toString() : "";
    } else {
      //
    }
    MICROSCOPEGASMCS002_CONTEXT.read<GASMCS002_Bloc>().add(GASMCS002_READ());
    emit('');
  }

  //-------------------------------- FINISH
  //TRICKER_GASMCS002FINISH

  Future<void> _TRICKER_GASMCS002FINISH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASMCS002-FINISH-IMG',
      data: {
        "IMG01": GASMCS002var.base64pic01,
        "IMG02": GASMCS002var.base64pic02,
        "IMG03": GASMCS002var.base64pic03,
        "IMG04": GASMCS002var.base64pic04,
        "IMG01data": GASMCS002var.base64pic01data,
        "IMG02data": GASMCS002var.base64pic02data,
        "IMG03data": GASMCS002var.base64pic03data,
        "IMG04data": GASMCS002var.base64pic04data,
      },
    );
    if (response.statusCode == 200) {
      MICROSCOPEGASMCS002_CONTEXT.read<GASMCS002_Bloc>().add(GASMCS002_READ());
    }

    emit('OK');
  }

  //-------------------------------- no request

  Future<void> _TRICKER_FLUSH(String toAdd, Emitter<String> emit) async {
    MICROSCOPEGASMCS002_CONTEXT.read<GASMCS002_Bloc>().add(GASMCS002_READ());
    emit('');
  }
}
