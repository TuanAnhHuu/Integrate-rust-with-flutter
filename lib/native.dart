import 'dart:ffi';
import 'dart:io' as io;

import 'package:hello_world/bridge_generated.dart';

const _base = 'native';

// Dynamic Libraries on Windows and Linux
final _dylib = io.Platform.isWindows ? '$_base.dll' : 'lib$_base.so';

// Dynamic Libraries on IOS and macOS
final _dylibIOS = '$_base.dylib';

DynamicLibrary loadLibrary() {
  if (io.Platform.isIOS || io.Platform.isMacOS) {
    return DynamicLibrary.executable();
  } else if (io.Platform.isWindows || io.Platform.isLinux) {
    return DynamicLibrary.open(_dylib);
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}

final api = NativeImpl(loadLibrary());

