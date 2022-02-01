import 'dart:io' ;
import 'package:flutter/foundation.dart' show kIsWeb;


enum PlatformType {
  Web,
  IOS,
  Android,
  Windows,
  Linux,
  MacOS,
  Fuchsia,
  unknown
}
class PlatformDetector{
  get platformType{
    if (kIsWeb){
      return PlatformType.Web;
    }
    if (Platform.isAndroid){
      return PlatformType.Android;
    }
    if (Platform.isFuchsia){
      return PlatformType.Fuchsia;
    }
    if (Platform.isIOS){
      return PlatformType.IOS;
    }
    if (Platform.isLinux){
      return PlatformType.Linux;
    }
    if (Platform.isMacOS){
      return PlatformType.MacOS;
    }
    if (Platform.isWindows){
      return PlatformType.Windows;
    }
  }
}
