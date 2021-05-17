class RestResponse<T> {
  final int code;
  final String message;
  final T t;

  RestResponse(this.code, this.message, this.t);
}

