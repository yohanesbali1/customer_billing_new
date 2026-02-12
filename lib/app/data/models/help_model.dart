part of "models.dart";

class HelpModel {
  final int id;
  final String noTicket;
  final String title;
  final String description;
  final String unit;
  final String complaint;
  final String requestDate;
  final List<HelpStatus> status;
  final HelpStatus currentStatus;
  final String currentStatusType;
  final String currentStatusLabel;
  final String priority;
  final String priorityLabel;
  final String noTelp;
  final String? attachmentUrl;
  final DateTime createdAt;
  final String updatedAt;
  final User user;
  final CreatedBy createdBy;
  final DisorderCategory disorderCategory;
  final Officer? officer;

  HelpModel({
    required this.id,
    required this.noTicket,
    required this.title,
    required this.description,
    required this.unit,
    required this.complaint,
    required this.requestDate,
    required this.status,
    required this.currentStatus,
    required this.currentStatusType,
    required this.currentStatusLabel,
    required this.priority,
    required this.priorityLabel,
    required this.noTelp,
    this.attachmentUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.createdBy,
    required this.disorderCategory,
    this.officer,
  });

  factory HelpModel.fromJson(Map<String, dynamic> json) {
    return HelpModel(
      id: json['id'],
      noTicket: json['no_ticket'],
      title: json['title'],
      description: json['description'],
      unit: json['unit'],
      complaint: json['complaint'],
      requestDate: json['request_date'],
      status: (json['status'] as List)
          .map((e) => HelpStatus.fromJson(e))
          .toList(),
      currentStatus: HelpStatus.fromJson(json['current_status']),
      currentStatusType: json['current_status_type'],
      currentStatusLabel: json['current_status_label'],
      priority: json['priority'],
      priorityLabel: json['priority_label'],
      noTelp: json['no_telp'],
      attachmentUrl: json['attachment_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
      createdBy: CreatedBy.fromJson(json['created_by']),
      disorderCategory: DisorderCategory.fromJson(json['disorder_category']),
      officer: Officer.fromJson(json['officer']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'no_ticket': noTicket,
      'title': title,
      'description': description,
      'unit': unit,
      'complaint': complaint,
      'request_date': requestDate,
      'status': status.map((e) => e.toJson()).toList(),
      'current_status': currentStatus.toJson(),
      'current_status_type': currentStatusType,
      'current_status_label': currentStatusLabel,
      'priority': priority,
      'priority_label': priorityLabel,
      'no_telp': noTelp,
      'attachment_url': attachmentUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user.toJson(),
      'created_by': createdBy.toJson(),
      'disorder_category': disorderCategory.toJson(),
      'officer': officer?.toJson(),
    };
  }
}

class HelpStatus {
  final String label;
  final String createdAt;
  final UserApprove userApprove;
  final String status;

  HelpStatus({
    required this.label,
    required this.createdAt,
    required this.userApprove,
    required this.status,
  });

  factory HelpStatus.fromJson(Map<String, dynamic> json) {
    return HelpStatus(
      label: json['label'],
      createdAt: json['created_at'],
      userApprove: UserApprove.fromJson(json['user_approve']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'created_at': createdAt,
      'user_approve': userApprove.toJson(),
      'status': status,
    };
  }
}

class UserApprove {
  final int id;
  final String? name;
  final String email;

  UserApprove({required this.id, this.name, required this.email});

  factory UserApprove.fromJson(Map<String, dynamic> json) {
    return UserApprove(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}

class User {
  final int id;
  final String name;
  final String code;
  final String email;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.code,
    required this.email,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'email': email,
      'phone': phone,
    };
  }
}

class CreatedBy {
  final int id;
  final String? name;
  final String email;

  CreatedBy({required this.id, this.name, required this.email});

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(id: json['id'], name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}

class DisorderCategory {
  final int id;
  final String code;
  final String name;
  final String type;

  DisorderCategory({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
  });

  factory DisorderCategory.fromJson(Map<String, dynamic> json) {
    return DisorderCategory(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'code': code, 'name': name, 'type': type};
  }
}

class Officer {
  final int id;
  final String name;
  final String department;
  final String position;

  Officer({
    required this.id,
    required this.name,
    required this.department,
    required this.position,
  });

  factory Officer.fromJson(Map<String, dynamic> json) {
    return Officer(
      id: json['id'],
      name: json['name'],
      department: json['department'],
      position: json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'position': position,
    };
  }
}
