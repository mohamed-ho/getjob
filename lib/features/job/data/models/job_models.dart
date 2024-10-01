class JobModels {
  String? companyId;
  String? descreption;
  String? address;
  int? numberOfOrder;
  String? closeCategory;
  double? salary;
  String? title;
  String? category;
  String? jobtype;
  String? jobId;

  JobModels(
      {this.companyId,
      this.descreption,
      this.address,
      this.numberOfOrder,
      this.closeCategory,
      this.salary,
      this.title,
      this.category,
      this.jobtype,
      this.jobId});

  JobModels.fromJson(Map<String, dynamic> json, String id) {
    companyId = json['companyId'];
    descreption = json['descreption'];
    address = json['address'];
    numberOfOrder = json['numberOfOrder'];
    closeCategory = json['closeCategory'];
    salary = json['salary'];
    title = json['title'];
    category = json['category'];
    jobtype = json['jobtype'];
    jobId = id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyId'] = companyId;
    data['descreption'] = descreption;
    data['address'] = address;
    data['numberOfOrder'] = numberOfOrder;
    data['closeCategory'] = closeCategory;
    data['salary'] = salary;
    data['title'] = title;
    data['category'] = category;
    data['jobtype'] = jobtype;
    return data;
  }
}
