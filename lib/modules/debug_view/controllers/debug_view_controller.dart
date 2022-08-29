
import 'package:get/get.dart';
import '../models/debug_log_item.dart';

class DebugViewController extends GetxController {
  final RxList<DebugLogItem> listLog = RxList<DebugLogItem>();
  addLog(DebugLogItem item) => listLog.add(item);
}
