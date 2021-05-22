import 'package:intl/intl.dart';
import 'package:iris/common/common.dart';

// 格式化时间戳
String formatTimestamp(int timestamp) {
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
  var format = DateFormat(DATE_FORMAT);
  return format.format(date);
}
