import 'package:iris/common/errors.dart';
import 'package:iris/model/index.dart';
import 'package:iris/utils/http_util.dart';

Future<List<Section>> getSectionList() async {
  var r = await HttpUtil.dio.get("/section");
  if (r.statusCode != 200) {
    throw CommonError("获取section信息失败");
  }
  var data = r.data as Map<String, dynamic>;
  var obj = data["data"] as List<dynamic>;
  return obj
      .map((item) => Section.fromJson(item as Map<String, dynamic>))
      .toList();
}
