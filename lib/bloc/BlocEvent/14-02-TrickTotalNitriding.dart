import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';

import '../../page/P14TotalNitriding/TotalNitridingvar.dart';
import '../../page/P1FIRSTUI/FIRSTuiVAR.dart';

//-------------------------------------------------
String server = GLOserver;

abstract class TRICKER_Event {}

//--------------------------------

class TRICKER_GETINtoTotalNitriding extends TRICKER_Event {}

//-------------------------------- non returnfunction

class TRICKER_TotalNitridinggeteachITEM extends TRICKER_Event {}

class TRICKER_TotalNitridinggeteachGRAPH extends TRICKER_Event {}

class TRICKER_TotalNitridingconfirmdata extends TRICKER_Event {}

class TRICKER_TotalNitridingCLEAR extends TRICKER_Event {}

class TRICKER_TotalNitridingRESETVALUE extends TRICKER_Event {}

class TRICKER_TotalNitridingSETZERO extends TRICKER_Event {}

//-------------------------------- FINISH

class TRICKER_TotalNitridingFINISH extends TRICKER_Event {}

//-------------------------------- no request

class TRICKER_FLUSH extends TRICKER_Event {}

class TRICKER_TotalNitriding_Bloc extends Bloc<TRICKER_Event, String> {
  TRICKER_TotalNitriding_Bloc() : super('') {
    //--------------------------------
    on<TRICKER_GETINtoTotalNitriding>((event, emit) {
      return _TRICKER_GETINtoTotalNitriding('', emit);
    });

    //-------------------------------- non returnfunction

    on<TRICKER_TotalNitridinggeteachITEM>((event, emit) {
      return _TRICKER_TotalNitridinggeteachITEM('', emit);
    });

    on<TRICKER_TotalNitridinggeteachGRAPH>((event, emit) {
      return _TRICKER_TotalNitridinggeteachGRAPH('', emit);
    });

    on<TRICKER_TotalNitridingconfirmdata>((event, emit) {
      return _TRICKER_TotalNitridingconfirmdata('', emit);
    });

    on<TRICKER_TotalNitridingCLEAR>((event, emit) {
      return _TRICKER_TotalNitridingCLEAR('', emit);
    });

    on<TRICKER_TotalNitridingRESETVALUE>((event, emit) {
      return _TRICKER_TotalNitridingRESETVALUE('', emit);
    });

    on<TRICKER_TotalNitridingSETZERO>((event, emit) {
      return _TRICKER_TotalNitridingSETZERO('', emit);
    });

    //-------------------------------- FINISH

    on<TRICKER_TotalNitridingFINISH>((event, emit) {
      return _TRICKER_TotalNitridingFINISH('', emit);
    });

    //-------------------------------- no request

    on<TRICKER_FLUSH>((event, emit) {
      return _TRICKER_FLUSH('', emit);
    });
  }

  Future<void> _TRICKER_GETINtoTotalNitriding(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoTotalNitriding',
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

  Future<void> _TRICKER_TotalNitridinggeteachITEM(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'TotalNitriding-geteachITEM',
      data: {
        "ITEMs": TotalNitridingvar.ItemPickSELECT,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_TotalNitridinggeteachGRAPH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'TotalNitriding-geteachGRAPH',
      data: {
        "GAPname": TotalNitridingvar.GAPname,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_TotalNitridingconfirmdata(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'TotalNitriding-confirmdata',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_TotalNitridingCLEAR(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'TotalNitriding-CLEAR',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_TotalNitridingRESETVALUE(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'TotalNitriding-RESETVALUE',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_TotalNitridingSETZERO(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'TotalNitriding-SETZERO',
      data: {},
    );
    emit('');
  }

  //-------------------------------- FINISH
  //TRICKER_TotalNitridingFINISH

  Future<void> _TRICKER_TotalNitridingFINISH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'TotalNitriding-FINISH',
      data: {},
    );
    emit('');
  }

  //-------------------------------- no request

  Future<void> _TRICKER_FLUSH(String toAdd, Emitter<String> emit) async {
    emit('');
  }
}
