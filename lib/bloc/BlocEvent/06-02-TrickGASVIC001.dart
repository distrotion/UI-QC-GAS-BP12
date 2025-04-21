import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P1FIRSTUI/FIRSTuiVAR.dart';
import '../../page/P6GASVIC001/GASVIC001var.dart';

//-------------------------------------------------
String server = GLOserver;

abstract class TRICKER_Event {}

//--------------------------------

class TRICKER_GETINtoGASVIC001 extends TRICKER_Event {}

//-------------------------------- non returnfunction

class TRICKER_GASVIC001geteachITEM extends TRICKER_Event {}

class TRICKER_GASVIC001geteachGRAPH extends TRICKER_Event {}

class TRICKER_GASVIC001confirmdata extends TRICKER_Event {}

class TRICKER_GASVIC001CLEAR extends TRICKER_Event {}

class TRICKER_GASVIC001RESETVALUE extends TRICKER_Event {}

class TRICKER_GASVIC001SETZERO extends TRICKER_Event {}

//-------------------------------- FINISH

class TRICKER_GASVIC001FINISH extends TRICKER_Event {}

//-------------------------------- no request

class TRICKER_FLUSH extends TRICKER_Event {}

class TRICKER_GASVIC001_Bloc extends Bloc<TRICKER_Event, String> {
  TRICKER_GASVIC001_Bloc() : super('') {
    //--------------------------------
    on<TRICKER_GETINtoGASVIC001>((event, emit) {
      return _TRICKER_GETINtoGASVIC001('', emit);
    });

    //-------------------------------- non returnfunction

    on<TRICKER_GASVIC001geteachITEM>((event, emit) {
      return _TRICKER_GASVIC001geteachITEM('', emit);
    });

    on<TRICKER_GASVIC001geteachGRAPH>((event, emit) {
      return _TRICKER_GASVIC001geteachGRAPH('', emit);
    });

    on<TRICKER_GASVIC001confirmdata>((event, emit) {
      return _TRICKER_GASVIC001confirmdata('', emit);
    });

    on<TRICKER_GASVIC001CLEAR>((event, emit) {
      return _TRICKER_GASVIC001CLEAR('', emit);
    });

    on<TRICKER_GASVIC001RESETVALUE>((event, emit) {
      return _TRICKER_GASVIC001RESETVALUE('', emit);
    });

    on<TRICKER_GASVIC001SETZERO>((event, emit) {
      return _TRICKER_GASVIC001SETZERO('', emit);
    });

    //-------------------------------- FINISH

    on<TRICKER_GASVIC001FINISH>((event, emit) {
      return _TRICKER_GASVIC001FINISH('', emit);
    });

    //-------------------------------- no request

    on<TRICKER_FLUSH>((event, emit) {
      return _TRICKER_FLUSH('', emit);
    });
  }

  Future<void> _TRICKER_GETINtoGASVIC001(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoGASVIC001',
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

  Future<void> _TRICKER_GASVIC001geteachITEM(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASVIC001-geteachITEM',
      data: {
        "ITEMs": GASVIC001var.ItemPickSELECT,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_GASVIC001geteachGRAPH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASVIC001-geteachGRAPH',
      data: {
        "GAPname": GASVIC001var.GAPname,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_GASVIC001confirmdata(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASVIC001-confirmdata',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASVIC001CLEAR(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASVIC001-CLEAR',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASVIC001RESETVALUE(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASVIC001-RESETVALUE',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASVIC001SETZERO(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASVIC001-SETZERO',
      data: {},
    );
    emit('');
  }

  //-------------------------------- FINISH
  //TRICKER_GASVIC001FINISH

  Future<void> _TRICKER_GASVIC001FINISH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASVIC001-FINISH',
      data: {},
    );
    emit('');
  }

  //-------------------------------- no request

  Future<void> _TRICKER_FLUSH(String toAdd, Emitter<String> emit) async {
    emit('');
  }
}
