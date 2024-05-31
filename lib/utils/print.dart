import 'dart:developer';

void dPrint(dynamic msg, {String? tag}) {
  log(msg.toString(), name: tag ?? "dPrint");
}
