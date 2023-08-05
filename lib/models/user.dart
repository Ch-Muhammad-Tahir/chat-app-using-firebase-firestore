class ChatUser {
  String name = "";
  String uId = "";
  String phoneNumber = "";
  ChatUser();
  ChatUser.fromJosn(Map<String, dynamic> json) {
    if (json["userName"] is String || json["userName"] is int) {
      name = json["userName"].toString();
    }
    if (json["uId"] is String || json["uId"] is int) {
      uId = json["uId"].toString();
    }
    if (json["phoneNumber"] is String || json["phoneNumber"] is int) {
      phoneNumber = json["phoneNumber"].toString();
    }
  }
}
