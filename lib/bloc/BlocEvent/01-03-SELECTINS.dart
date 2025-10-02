import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P1FIRSTUI/FIRSTuiVAR.dart';

//-------------------------------------------------
String server = GLOserver;

abstract class TRICKERMASTER_Event {}

class TRICKERMASTER_GETINtoAPPGAS12 extends TRICKERMASTER_Event {}

class TRICKERMASTER_GETINtoGASHMV001 extends TRICKERMASTER_Event {}

class TRICKERMASTER_GETINtoGASHMV002 extends TRICKERMASTER_Event {}

class TRICKERMASTER_GETINtoGASHMV003 extends TRICKERMASTER_Event {}

class TRICKERMASTER_GETINtoGASRHT001 extends TRICKERMASTER_Event {}

class TRICKERMASTER_GETINtoGASOHR001 extends TRICKERMASTER_Event {}

class TRICKERMASTER_GETINtoRefgraph extends TRICKERMASTER_Event {}

class TRICKERMASTER_GETINtoTotalNitriding extends TRICKERMASTER_Event {}

//

//

class TRICKERMASTER_GETINtoGASMCS002 extends TRICKERMASTER_Event {}

class TRICKERMASTER_GETINtoGASVIC001 extends TRICKERMASTER_Event {}

class TRICKERMASTER_FLUSH extends TRICKERMASTER_Event {}

class TRICKERMASTER_Bloc extends Bloc<TRICKERMASTER_Event, String> {
  TRICKERMASTER_Bloc() : super('') {
    on<TRICKERMASTER_GETINtoAPPGAS12>((event, emit) {
      return _TRICKERMASTER_GETINtoAPPGAS12('', emit);
    });

    on<TRICKERMASTER_GETINtoGASHMV001>((event, emit) {
      return _TRICKERMASTER_GETINtoGASHMV001('', emit);
    });

    on<TRICKERMASTER_GETINtoGASHMV002>((event, emit) {
      return _TRICKERMASTER_GETINtoGASHMV002('', emit);
    });

    on<TRICKERMASTER_GETINtoGASHMV003>((event, emit) {
      return _TRICKERMASTER_GETINtoGASHMV003('', emit);
    });

    on<TRICKERMASTER_GETINtoGASVIC001>((event, emit) {
      return _TRICKERMASTER_GETINtoGASVIC001('', emit);
    });

    on<TRICKERMASTER_GETINtoGASMCS002>((event, emit) {
      return _TRICKERMASTER_GETINtoGASMCS002('', emit);
    });

    on<TRICKERMASTER_GETINtoGASRHT001>((event, emit) {
      return _TRICKERMASTER_GETINtoGASRHT001('', emit);
    });

    on<TRICKERMASTER_GETINtoGASOHR001>((event, emit) {
      return _TRICKERMASTER_GETINtoGASOHR001('', emit);
    });

    on<TRICKERMASTER_GETINtoRefgraph>((event, emit) {
      return _TRICKERMASTER_GETINtoRefgraph('', emit);
    });
    //
    on<TRICKERMASTER_GETINtoTotalNitriding>((event, emit) {
      return _TRICKERMASTER_GETINtoTotalNitriding('', emit);
    });

    on<TRICKERMASTER_FLUSH>((event, emit) {
      return _TRICKERMASTER_FLUSH('', emit);
    });
  }

  Future<void> _TRICKERMASTER_GETINtoAPPGAS12(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoAPPGAS12',
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

  Future<void> _TRICKERMASTER_GETINtoGASHMV001(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoGASHMV001',
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

  Future<void> _TRICKERMASTER_GETINtoGASHMV002(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoGASHMV002',
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

  Future<void> _TRICKERMASTER_GETINtoGASHMV003(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoGASHMV003',
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

  Future<void> _TRICKERMASTER_GETINtoGASMCS002(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoGASMCS002',
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

  Future<void> _TRICKERMASTER_GETINtoGASVIC001(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoGASVIC001',
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

  Future<void> _TRICKERMASTER_GETINtoGASRHT001(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoGASRHT001',
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

  //
  Future<void> _TRICKERMASTER_GETINtoGASOHR001(
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
  //TRICKERMASTER_GETINtoTotalNitriding

  Future<void> _TRICKERMASTER_GETINtoRefgraph(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoRefgraph',
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

  Future<void> _TRICKERMASTER_GETINtoTotalNitriding(
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

  Future<void> _TRICKERMASTER_GETINtoAPPGASGW(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoAPPGASGW',
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

  Future<void> _TRICKERMASTER_FLUSH(String toAdd, Emitter<String> emit) async {
    emit('');
  }
}
