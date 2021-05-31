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

// 是否已完结
const STATUS_MAP = {true: "1", false: "0"};

// 是否已看完
const WATCH_MAP = {true: "1", false: "0"};

const RECORD_STAUS_MAP = {"0": "连载中", "1": "已完结"};

const WATCH_STATUS_MAP = {"0": "在看", "1": "已看完"};

const USER_STATUS_MAP = {"0": true, "1": false};

const VIP_STATUS_MAP = {"0": true, "1": false};
