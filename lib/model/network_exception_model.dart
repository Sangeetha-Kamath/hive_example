class NetworkExceptionModel {
  final int? statusCode;
  final String? errorMessage;
  factory NetworkExceptionModel.initial(){
    return NetworkExceptionModel(statusCode: 500, errorMessage: "internal server error");
  }
   NetworkExceptionModel({required this.statusCode,required this.errorMessage});
  @override
  String toString(){
    return "Network error with statuscode $statusCode and error message $errorMessage";
  }

}