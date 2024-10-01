const String jobSalary = 'salary';
const String jobOwner = 'jobOwner';
const String jobDescription = 'descreption';
const String jobAddress = 'address';
const String jobType = 'jobtype';
const String jobcompanyId = 'companyId';
const String jobcategory = 'category';
const String jobcloseCategory = 'closeCategory';
const String jobNumberOfOrder = 'numberOfOrder';

const String orderworkerName = 'workerName';
const String ordercounty = 'country';
const String orderworkerEmail = 'email';
const String orderMessage = 'massage';
const String orderjobId = 'jobId';
const String orderCv = 'CvUrl';
const String orderWorkerId = 'workerId';

const String isCompany = 'isCompany';
const String companyNameKey = 'name';
const String companyemailKey = 'email';
const String companyUrlKey = 'url';
const String companyIdKey = 'id';
const String jobOwneremail = 'email';
const String jobOwnerUserName = 'userName';
const String jobOwnerImage = 'ImageUrl';
const String worker = 'worker';
const String workerEmail = 'email';
const String workerUserName = 'userName';
const String workerImage = 'imageUrl';
const String workerIdKey = 'id';
const String workerEmailKey = 'email';
const String workerNameKey = 'name';
const String workerUrlKey = 'url';
const String noImage = 'noImage';
const String jobs = 'jobs';

const String messagesCollection = 'messages';
const String workerMessage = 'workerId';
const String companyMessage = 'companyId';
const String messageTime = 'time';
const String messagecomponent = 'message';
const String messageSender = 'sender';

const String friends = 'firends';
const String friendId = 'friendId';

const List<String> jobTypes = <String>[
  'Full Time',
  'Part Time',
  'Contract',
  'Freelance',
  'Remote'
];

class FireBaseStringConst {
  static const String jobCollectionName = 'Jobs';
  static const String applicationsCollectionName = 'Applications';
  static const String userCollectionName = 'Users';
  static const String friendsCollectionName = 'Friends';
  static const String messagesCollectionName = 'Messages';
  static const String jobOrderCollectinName = 'JobOrder';
  static const String usersImagesPath = 'UsersImages';
  static const String usersDefaultImagePath =
      'https://firebasestorage.googleapis.com/v0/b/dream-job-5a696.appspot.com/o/UsersImages%2Fdefault%20.jpg?alt=media&token=fdd0e268-4c73-47fe-844a-6967caba11b8';

  static const String usersCVsPath = 'CVs';
}

class SharedPreferenceKeys {
  static const String userNameKey = 'userName';
  static const String userImageKey = 'userImage';
  static const String userPassword = 'userPassword';
  static const String userEmail = 'userEmail';
  static const String userId = 'userId';
  static const String userverify = 'userVerify';
  static const String addOrGetUserKey = 'addOrGetUserKey';
  static const String checkLoginKey = 'isLogin';
  static const String firstStart = 'firstStart';
}

class JobStringConst {
  static const String jobId = 'id';
  static const String jobTitle = 'jobTitle';
  static const String jobSalary = 'jobSalary';
  static const String jobDescription = 'jobDescription';
  static const String jobAddress = 'jobAddress';
  static const String jobType = 'jobType';
  static const String jobCatecory = 'jobCatecory';
  static const String jobSubCategory = 'jobSubCategory';
  static const String jobCompanyId = 'jobCompanyId';
  static const String jobCompanyName = 'jobCompanyName';
  static const String jobCompanyImage = 'jobCompanyImage';
  static const String jobNumberOfOrder = 'numberOfOrder';
  static const String jobQualifications = 'jobQualifications';
  static const String jobReadedOrder = 'readedOrder';
  static const String jobShareTime = 'ShareTime';
}

class ApplicationStringConst {
  static const String applicationId = 'Id';
  static const String applicationOwnerId = 'OwnerId';
  static const String applicationJobId = 'JobId';
  static const String applicationOwnerFirstName = 'FirstName';
  static const String applicationOwnerLastName = 'LastName';
  static const String applicationeOwnerEmail = 'Email';
  static const String applicationOwnerAddress = 'Address';
  static const String applicationMessage = 'Message';
  static const String applicationCvFilePath = 'FilePath';
  static const String applicationOwnerImage = 'ownerImage';
}

class MessagesStringConst {
  static const String messageId = 'messageId';
  static const String senderAndReceiver = 'senderAndReceiver';
  static const String messageContent = 'messageContent';
  static const String messageSendTime = 'SendTime';
  static const String messageIsRead = 'isRead';
}

class FriendStringConst {
  static const String friendId = 'friendId';
  static const String friendImageUrl = 'imagePath';
  static const String friendName = 'Name';
}

class UserStringConst {
  static const String userName = 'userName';
  static const String userImage = 'userImage';
  static const String userPassword = 'userPassword';
  static const String userEmail = 'userEmail';
  static const String userId = 'userId';
}

class JobOrderStringCosnt {
  static const String id = 'id';
  static const String companyName = 'companyName';
  static const String jobTitle = 'jobTitle';
  static const String isDelivered = 'isDelivered';
  static const String salary = 'salary';
  static const String address = 'address';
  static const String companyImage = 'companyImage';
  static const String userId = 'UserId';
  static const String applicationId = 'applicationId';
  static const String jobId = 'jobId';
}

class ErrorStringConst {
  static const String youActuallySendApplicationError =
      'you actually send an Application';
}
