class ApiResponse {
  final String message;
  final int statusCode;
  final dynamic rawStatus; // can be String or bool
  final String? token;     // ✅ Add this

  ApiResponse({
    required this.rawStatus,
    required this.statusCode,
    required this.message,
    this.token,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      rawStatus: json['Status'],
      statusCode: json['StatusCode'] ?? 0,
      message: json['Message'] ?? '',
      token: json['Token'], // ✅ assign token (may be null)
    );
  }

  bool get isSuccess {
    if (rawStatus is String) {
      return rawStatus.toString().toUpperCase() == 'SUCCESS';
    } else if (rawStatus is bool) {
      return rawStatus == true;
    }
    return false;
  }
}
