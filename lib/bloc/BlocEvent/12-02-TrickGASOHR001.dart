import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';

import '../../page/P12GASOHR001/GASOHR001var.dart';
import '../../page/P1FIRSTUI/FIRSTuiVAR.dart';

//-------------------------------------------------
String server = GLOserver;

abstract class TRICKER_Event {}

//--------------------------------

class TRICKER_GETINtoGASOHR001 extends TRICKER_Event {}

//-------------------------------- non returnfunction

class TRICKER_GASOHR001geteachITEM extends TRICKER_Event {}

class TRICKER_GASOHR001geteachGRAPH extends TRICKER_Event {}

class TRICKER_GASOHR001confirmdata extends TRICKER_Event {}

class TRICKER_GASOHR001CLEAR extends TRICKER_Event {}

class TRICKER_GASOHR001RESETVALUE extends TRICKER_Event {}

class TRICKER_GASOHR001SETZERO extends TRICKER_Event {}

//-------------------------------- FINISH

class TRICKER_GASOHR001FINISH extends TRICKER_Event {}

//-------------------------------- no request

class TRICKER_FLUSH extends TRICKER_Event {}

class TRICKER_GASOHR001_Bloc extends Bloc<TRICKER_Event, String> {
  TRICKER_GASOHR001_Bloc() : super('') {
    //--------------------------------
    on<TRICKER_GETINtoGASOHR001>((event, emit) {
      return _TRICKER_GETINtoGASOHR001('', emit);
    });

    //-------------------------------- non returnfunction

    on<TRICKER_GASOHR001geteachITEM>((event, emit) {
      return _TRICKER_GASOHR001geteachITEM('', emit);
    });

    on<TRICKER_GASOHR001geteachGRAPH>((event, emit) {
      return _TRICKER_GASOHR001geteachGRAPH('', emit);
    });

    on<TRICKER_GASOHR001confirmdata>((event, emit) {
      return _TRICKER_GASOHR001confirmdata('', emit);
    });

    on<TRICKER_GASOHR001CLEAR>((event, emit) {
      return _TRICKER_GASOHR001CLEAR('', emit);
    });

    on<TRICKER_GASOHR001RESETVALUE>((event, emit) {
      return _TRICKER_GASOHR001RESETVALUE('', emit);
    });

    on<TRICKER_GASOHR001SETZERO>((event, emit) {
      return _TRICKER_GASOHR001SETZERO('', emit);
    });

    //-------------------------------- FINISH

    on<TRICKER_GASOHR001FINISH>((event, emit) {
      return _TRICKER_GASOHR001FINISH('', emit);
    });

    //-------------------------------- no request

    on<TRICKER_FLUSH>((event, emit) {
      return _TRICKER_FLUSH('', emit);
    });
  }

  Future<void> _TRICKER_GETINtoGASOHR001(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoGASOHR001',
      data: {
        "PO": FIRSTUI.POACTIVE,
        "CP": FIRSTUI.CPACTIVE,
        "USER": USERDATA.NAME,
        "USERID": USERDATA.ID,
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

  Future<void> _TRICKER_GASOHR001geteachITEM(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASOHR001-geteachITEM',
      data: {
        "ITEMs": GASOHR001var.ItemPickSELECT,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_GASOHR001geteachGRAPH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASOHR001-geteachGRAPH',
      data: {
        "GAPname": GASOHR001var.GAPname,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_GASOHR001confirmdata(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASOHR001-confirmdata',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASOHR001CLEAR(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASOHR001-CLEAR',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASOHR001RESETVALUE(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASOHR001-RESETVALUE',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASOHR001SETZERO(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASOHR001-SETZERO',
      data: {},
    );
    emit('');
  }

  //-------------------------------- FINISH
  //TRICKER_GASOHR001FINISH

  Future<void> _TRICKER_GASOHR001FINISH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASOHR001-FINISH',
      data: {},
    );
    emit('');
  }

  //-------------------------------- no request

  Future<void> _TRICKER_FLUSH(String toAdd, Emitter<String> emit) async {
    emit('');
  }
}
