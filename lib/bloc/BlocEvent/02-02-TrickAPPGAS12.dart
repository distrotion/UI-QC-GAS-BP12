import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P1FIRSTUI/FIRSTuiVAR.dart';
import '../../page/P2APPGAS12/APPGAS12var.dart';

//-------------------------------------------------
String server = GLOserver;

abstract class TRICKER_Event {}

//--------------------------------

class TRICKER_GETINtoAPPGAS12 extends TRICKER_Event {}

//-------------------------------- non returnfunction

class TRICKER_APPGAS12geteachITEM extends TRICKER_Event {}

class TRICKER_APPGAS12confirmdata extends TRICKER_Event {}

class TRICKER_APPGAS12CLEAR extends TRICKER_Event {}

class TRICKER_APPGAS12RESETVALUE extends TRICKER_Event {}

class TRICKER_APPGAS12SETZERO extends TRICKER_Event {}

//-------------------------------- FINISH

class TRICKER_APPGAS12FINISH extends TRICKER_Event {}

//-------------------------------- no request

class TRICKER_FLUSH extends TRICKER_Event {}

class TRICKER_APPGAS12_Bloc extends Bloc<TRICKER_Event, String> {
  TRICKER_APPGAS12_Bloc() : super('') {
    //--------------------------------
    on<TRICKER_GETINtoAPPGAS12>((event, emit) {
      return _TRICKER_GETINtoAPPGAS12('', emit);
    });

    //-------------------------------- non returnfunction

    on<TRICKER_APPGAS12geteachITEM>((event, emit) {
      return _TRICKER_APPGAS12geteachITEM('', emit);
    });

    on<TRICKER_APPGAS12confirmdata>((event, emit) {
      return _TRICKER_APPGAS12confirmdata('', emit);
    });

    on<TRICKER_APPGAS12CLEAR>((event, emit) {
      return _TRICKER_APPGAS12CLEAR('', emit);
    });

    on<TRICKER_APPGAS12RESETVALUE>((event, emit) {
      return _TRICKER_APPGAS12RESETVALUE('', emit);
    });

    on<TRICKER_APPGAS12SETZERO>((event, emit) {
      return _TRICKER_APPGAS12SETZERO('', emit);
    });

    //-------------------------------- FINISH

    on<TRICKER_APPGAS12FINISH>((event, emit) {
      return _TRICKER_APPGAS12FINISH('', emit);
    });

    //-------------------------------- no request

    on<TRICKER_FLUSH>((event, emit) {
      return _TRICKER_FLUSH('', emit);
    });
  }

  Future<void> _TRICKER_GETINtoAPPGAS12(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoAPPGAS12',
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
    emit(output);
  }

  Future<void> _TRICKER_APPGAS12geteachITEM(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'APPGAS12-geteachITEM',
      data: {
        "ITEMs": APPGAS12var.ItemPickSELECT,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_APPGAS12confirmdata(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'APPGAS12-confirmdata',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_APPGAS12CLEAR(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'APPGAS12-CLEAR',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_APPGAS12RESETVALUE(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'APPGAS12-RESETVALUE',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_APPGAS12SETZERO(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'APPGAS12-SETZERO',
      data: {},
    );
    emit('');
  }

  //-------------------------------- FINISH
  //TRICKER_APPGAS12FINISH

  Future<void> _TRICKER_APPGAS12FINISH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'APPGAS12-FINISH-APR',
      data: {
        "APRitem": APPGAS12var.ItemPickSELECT,
        "APRre": APPGAS12var.APPEARANCE,
      },
    );
    emit('OK');
  }

  //-------------------------------- no request

  Future<void> _TRICKER_FLUSH(String toAdd, Emitter<String> emit) async {
    emit('');
  }
}
