/// 通用返回值格式
///
class RestResponse<T> {
  final int code;
  final T data;
  final String message;

  RestResponse(int code, String message, T data)
      : this.code = code,
        this.data = data,
        this.message = message;
}

// 日期格式
const DATE_FORMAT = "yyyy-MM-dd";
