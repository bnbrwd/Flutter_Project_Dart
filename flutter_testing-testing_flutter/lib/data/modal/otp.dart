

class OtpResponse {
    OtpResponse({
       required this.data,
       required this.status,
       required this.message,
    });

    Data data;
    int status;
    String message;

    factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
    };
}

class Data {
    Data({
       required this.accessToken,
    });

    String accessToken;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["accessToken"],
    );

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
    };
}
