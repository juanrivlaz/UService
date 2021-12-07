class ContactModel {
  String name;
  String lastName;
  String telephone;
  String officeTelephone;
  String cellphone;
  String email;
  String sex;

  ContactModel() {
    this.name = '';
    this.lastName = '';
    this.telephone = '';
    this.officeTelephone = '';
    this.cellphone = '';
    this.email = '';
    this.sex = '';
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    ContactModel contact = new ContactModel();

    contact.name = json['name'] ?? '';
    contact.lastName = json['last_name'] ?? '';
    contact.telephone = json['telephone'] ?? '';
    contact.officeTelephone = json['office_telephone'] ?? '';
    contact.cellphone = json['cellphone'] ?? '';
    contact.email = json['email'] ?? '';
    contact.sex = json['sex'] ?? '';

    return contact;
  }
}