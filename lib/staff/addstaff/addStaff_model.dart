class Addstaff {
  String? staffId;
  String? activationDate;
  String? company;
  String? consentToTermsAndConditions;
  String? corporateEmail;
  String? createdBy;
  String? createdOn;
  String? dob;
  String? doj;
  String? door;
  String? enrollFR;
  String? enrollQR;
  String? expirationDate;
  String? firstName;
  String? imageName;
  String? lastName;
  String? modifiedBy;
  String? modifiedOn;
  String? nricNumber;
  String? remarks;
  String? staffEmail;
  String? staffJobPosition;
  String? staffNumber;
  String? staffPhone;
  String? systemName;
  String? companyId;
  String? isUploadP1;
  String? isUploadFr;
  String? isCompanyUpdated;
  String? uploadReason;
  String? uploadStatus;
  String? cardNumber;
  String? frImageName;
  String? isUploadSuntecApi;
  String? imageData;
  String? unitNumber;
  String? towerId;

  Addstaff(
      {this.staffId,
        this.activationDate,
        this.company,
        this.consentToTermsAndConditions,
        this.corporateEmail,
        this.createdBy,
        this.createdOn,
        this.dob,
        this.doj,
        this.door,
        this.enrollFR,
        this.enrollQR,
        this.expirationDate,
        this.firstName,
        this.imageName,
        this.lastName,
        this.modifiedBy,
        this.modifiedOn,
        this.nricNumber,
        this.remarks,
        this.staffEmail,
        this.staffJobPosition,
        this.staffNumber,
        this.staffPhone,
        this.systemName,
        this.companyId,
        this.isUploadP1,
        this.isUploadFr,
        this.isCompanyUpdated,
        this.uploadReason,
        this.uploadStatus,
        this.cardNumber,
        this.frImageName,
        this.isUploadSuntecApi,
        this.imageData,
        this.unitNumber,
        this.towerId});

  Addstaff.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    activationDate = json['activation_date'];
    company = json['company'];
    consentToTermsAndConditions = json['consent_to_terms_and_conditions'];
    corporateEmail = json['corporate_email'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    dob = json['dob'];
    doj = json['doj'];
    door = json['door'];
    enrollFR = json['enroll_FR'];
    enrollQR = json['enroll_QR'];
    expirationDate = json['expiration_date'];
    firstName = json['first_name'];
    imageName = json['image_name'];
    lastName = json['last_name'];
    modifiedBy = json['modified_by'];
    modifiedOn = json['modified_on'];
    nricNumber = json['nric_number'];
    remarks = json['remarks'];
    staffEmail = json['staff_email'];
    staffJobPosition = json['staff_job_position'];
    staffNumber = json['staff_number'];
    staffPhone = json['staff_phone'];
    systemName = json['system_name'];
    companyId = json['company_id'];
    isUploadP1 = json['is_upload_p1'];
    isUploadFr = json['is_upload_fr'];
    isCompanyUpdated = json['is_company_updated'];
    uploadReason = json['upload_reason'];
    uploadStatus = json['upload_status'];
    cardNumber = json['card_number'];
    frImageName = json['fr_image_name'];
    isUploadSuntecApi = json['is_upload_suntec_api'];
    imageData = json['image_data'];
    unitNumber = json['unit_number'];
    towerId = json['tower_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['activation_date'] = this.activationDate;
    data['company'] = this.company;
    data['consent_to_terms_and_conditions'] = this.consentToTermsAndConditions;
    data['corporate_email'] = this.corporateEmail;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['dob'] = this.dob;
    data['doj'] = this.doj;
    data['door'] = this.door;
    data['enroll_FR'] = this.enrollFR;
    data['enroll_QR'] = this.enrollQR;
    data['expiration_date'] = this.expirationDate;
    data['first_name'] = this.firstName;
    data['image_name'] = this.imageName;
    data['last_name'] = this.lastName;
    data['modified_by'] = this.modifiedBy;
    data['modified_on'] = this.modifiedOn;
    data['nric_number'] = this.nricNumber;
    data['remarks'] = this.remarks;
    data['staff_email'] = this.staffEmail;
    data['staff_job_position'] = this.staffJobPosition;
    data['staff_number'] = this.staffNumber;
    data['staff_phone'] = this.staffPhone;
    data['system_name'] = this.systemName;
    data['company_id'] = this.companyId;
    data['is_upload_p1'] = this.isUploadP1;
    data['is_upload_fr'] = this.isUploadFr;
    data['is_company_updated'] = this.isCompanyUpdated;
    data['upload_reason'] = this.uploadReason;
    data['upload_status'] = this.uploadStatus;
    data['card_number'] = this.cardNumber;
    data['fr_image_name'] = this.frImageName;
    data['is_upload_suntec_api'] = this.isUploadSuntecApi;
    data['image_data'] = this.imageData;
    data['unit_number'] = this.unitNumber;
    data['tower_id'] = this.towerId;
    return data;
  }
}