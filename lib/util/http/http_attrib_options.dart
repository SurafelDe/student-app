
class HttpAttribOptions {
  String baseUrl;
  String path;
  Object? body;
  BodySerializationMethod? serializationMethod;
  HttpMethods method;
  HttpRequestPriority? priority;
  Map<String, String>? headerAttribute;
  HttpAttribOptions(
      {required this.baseUrl,
      required this.path,
      required this.method,
      this.headerAttribute,
      this.serializationMethod,
      this.body,
      this.priority});
}

enum HttpMethods { GET, POST, DELETE, PUT }

enum HttpRequestPriority { BACKGROUND, SPECULATIVE, USER_INITIATED }

enum BodySerializationMethod {
  //
  // Summary:
  //     Strings are set as-is
  Default,
  //
  // Summary:
  //     Json encodes everything, including strings
  Json,
  //
  // Summary:
  //     Form-UrlEncode's the values
  UrlEncoded,
  //
  // Summary:
  Serialized
}
