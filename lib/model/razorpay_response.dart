class RazorpayResponse {
  RazorpayResponse({
    this.status,
    this.message,
    this.data,
  });

  RazorpayResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null
        ? RazorpayResponseData.fromJson(json["data"])
        : null;
  }
  String? status;
  String? message;
  RazorpayResponseData? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map["status"] = status;
    map["message"] = message;
    if (data != null) {
      map["data"] = data?.toJson();
    }
    return map;
  }
}

class RazorpayResponseData {
  RazorpayResponseData({
    this.order,
    this.options,
  });

  RazorpayResponseData.fromJson(Map<String, dynamic> json) {
    order = json["order"] != null ? Order.fromJson(json["order"]) : null;
    options =
        json["options"] != null ? Options.fromJson(json["options"]) : null;
  }
  Order? order;
  Options? options;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (order != null) {
      map["order"] = order?.toJson();
    }
    if (options != null) {
      map["options"] = options?.toJson();
    }
    return map;
  }
}

class Options {
  Options({
    this.key,
    this.appName,
    this.description,
    this.fullName,
    this.email,
    this.contact,
    this.timeout,
    this.userTheme,
    this.userLang,
  });

  Options.fromJson(Map<String, dynamic> json) {
    key = json["key"];
    appName = json["app_name"];
    description = json["description"];
    fullName = json["full_name"];
    email = json["email"];
    contact = json["contact"];
    timeout = json["timeout"];
    userTheme = json["user_theme"];
    userLang = json["user_lang"];
  }
  String? key;
  String? appName;
  String? description;
  String? fullName;
  String? email;
  String? contact;
  int? timeout;
  String? userTheme;
  String? userLang;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map["key"] = key;
    map["app_name"] = appName;
    map["description"] = description;
    map["full_name"] = fullName;
    map["email"] = email;
    map["contact"] = contact;
    map["timeout"] = timeout;
    map["user_theme"] = userTheme;
    map["user_lang"] = userLang;
    return map;
  }
}

class Order {
  Order({
    this.id,
    this.entity,
    this.amount,
    this.amountPaid,
    this.amountDue,
    this.currency,
    this.receipt,
    this.offerId,
    this.status,
    this.attempts,
    this.notes,
    this.createdAt,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    entity = json["entity"];
    amount = json["amount"];
    amountPaid = json["amount_paid"];
    amountDue = json["amount_due"];
    currency = json["currency"];
    receipt = json["receipt"];
    offerId = json["offer_id"];
    status = json["status"];
    attempts = json["attempts"];
    notes = json["notes"] != null ? Notes.fromJson(json["notes"]) : null;
    createdAt = json["created_at"];
  }
  String? id;
  String? entity;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  String? receipt;
  String? offerId;
  String? status;
  int? attempts;
  Notes? notes;
  int? createdAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map["id"] = id;
    map["entity"] = entity;
    map["amount"] = amount;
    map["amount_paid"] = amountPaid;
    map["amount_due"] = amountDue;
    map["currency"] = currency;
    map["receipt"] = receipt;
    map["offer_id"] = offerId;
    map["status"] = status;
    map["attempts"] = attempts;
    if (notes != null) {
      map["notes"] = notes?.toJson();
    }
    map["created_at"] = createdAt;
    return map;
  }
}

class Notes {
  Notes({
    this.id,
  });

  Notes.fromJson(Map<String, dynamic> json) {
    id = json["id"];
  }
  int? id;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map["id"] = id;
    return map;
  }
}
