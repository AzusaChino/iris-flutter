import 'package:dio/dio.dart';
import 'package:iris/common/errors.dart';
import 'package:iris/model/index.dart';
import 'package:iris/utils/http_util.dart';

Future<List<Record>> getRecordList(
    {String sid, Map<String, dynamic> params, refresh = false}) async {
  Options _options;
  if (refresh) {
    _options.extra.addAll({"refresh": true, "list": true});
  }
  var r = await HttpUtil.dio
      .get("/$sid/record", queryParameters: params, options: _options);

  if (r.statusCode != 200) {
    throw CommonError("获取Record信息失败");
  }
  var data = r.data as Map<String, dynamic>;
  var obj = data["data"] as List<dynamic>;
  return obj
      .map((item) => Record.fromJson(item as Map<String, dynamic>))
      .toList();
}

Future<List<Record>> searchRecordList() async {
  return null;
}

Future<String> insertRecord({Record record}) async {
  var r = await HttpUtil.dio.post("/${record.sid}/record", data: record);

  if (r.statusCode != 200) {
    throw CommonError("新增Record失败");
  }
  var data = r.data as Map<String, dynamic>;

  return data["data"];
}
