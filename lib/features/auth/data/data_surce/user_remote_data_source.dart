import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/auth/data/models/user_model.dart';
import 'package:getjob/features/job/data/Data_source/job_remote_date_source.dart';
import 'package:getjob/features/job/data/models/job_model.dart';
import 'package:getjob/features/jobOrder/data/datasources/job_order_application_remote_data_source.dart';
import 'package:getjob/features/jobOrder/data/models/job_order_model.dart';

import 'package:path/path.dart' as path;

abstract class UserRemoteDataSource {
  Future<void> signUp(UserModel user);
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
  Future<void> updateUser(UserModel user);
  Future<void> changePassword(String email);
  Future<void> removeAccount();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  UserRemoteDataSourceImpl(
      {required this.firebaseAuth,
      required this.firebaseFirestore,
      required this.firebaseStorage});
  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      final response = await firebaseFirestore
          .collection(FireBaseStringConst.userCollectionName)
          .doc(result.user!.uid)
          .get();
      return UserModel.fromUserCredential(response, result);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      await ls<UserLocalDataSource>().logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signUp(UserModel user) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: user.email, password: user.password);
      user.image = await FirebaseStorage.instance
          .ref(FireBaseStringConst.usersImagesPath)
          .child('default .jpg')
          .getDownloadURL();
      user.id = userCredential.user!.uid;
      await firebaseFirestore
          .collection(FireBaseStringConst.userCollectionName)
          .doc(userCredential.user!.uid)
          .set(user.toJson());
      await userCredential.user!.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUser(UserModel user) async {
    try {
      if (user.file != null) {
        // arrange the image
        var firebaseStorage = FirebaseStorage.instance.ref();
        final fileExtension = path.extension(user.file!.path);
        // add the image name
        String image =
            '${FirebaseAuth.instance.currentUser!.uid}$fileExtension';
        if (user.image != FireBaseStringConst.usersDefaultImagePath) {
          await FirebaseStorage.instance.refFromURL(user.image).delete();
        }

        // upload the image
        await firebaseStorage
            .child('${FireBaseStringConst.usersImagesPath}/$image')
            .putFile(user.file!);
        //add the new image path to the user
        user.image = await firebaseStorage
            .child('${FireBaseStringConst.usersImagesPath}/$image')
            .getDownloadURL();
        await firebaseAuth.signInWithEmailAndPassword(
            email: ls<UserLocalDataSource>().getUser().email,
            password: ls<UserLocalDataSource>().getUser().password);
        // update the user name or password
        await firebaseAuth.currentUser!.updateDisplayName(user.name);
        await firebaseAuth.currentUser!.updatePassword(user.password);
        await firebaseAuth.currentUser!
            .updateProfile(displayName: user.name, photoURL: user.image);
        // update the user data in firebase firestore
        await firebaseFirestore
            .collection(FireBaseStringConst.userCollectionName)
            .doc(firebaseAuth.currentUser!.uid)
            .update(user.toJson());
        // update the data in local device
        await ls<UserLocalDataSource>().setUser(user);
      } else {
        await firebaseAuth.currentUser!.updateDisplayName(user.name);
        await firebaseAuth.currentUser!.updatePassword(user.password);
        await firebaseAuth.currentUser!
            .updateProfile(displayName: user.name, photoURL: user.image);
        await firebaseFirestore
            .collection(FireBaseStringConst.userCollectionName)
            .doc(firebaseAuth.currentUser!.uid)
            .update(user.toJson());
        UserLocalDataSourceImpl().setUser(user);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changePassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeAccount() async {
    try {
      //delete use in firesotre
      await firebaseFirestore
          .collection(FireBaseStringConst.userCollectionName)
          .doc(ls<UserLocalDataSource>().getUser().id)
          .delete();
      // delete jobs of this user
      final docs = await firebaseFirestore
          .collection(FireBaseStringConst.jobCollectionName)
          .where(JobStringConst.jobCompanyId,
              isEqualTo: ls<UserLocalDataSource>().getUser().id)
          .get();
      List<JobModel> jobs = [];
      if (docs.docs.isNotEmpty) {
        jobs = List<JobModel>.from(docs.docs.map((e) {
          return JobModel.fromJson(e);
        }));
      }
      for (var job in jobs) {
        await ls<JobRemoteDateSource>().deleteJob(job.id);
      }
      // delete jobOrders of this user
      List<JobOrderModel> orders =
          await ls<JobOrderApplicationRemoteDataSource>()
              .getJobOrders(ls<UserLocalDataSource>().getUser().id);
      for (var order in orders) {
        ls<JobOrderApplicationRemoteDataSource>().deleteJobOrder(order);
      }
      for (var job in jobs) {
        final result = await firebaseFirestore
            .collection(FireBaseStringConst.jobOrderCollectinName)
            .where(JobOrderStringCosnt.jobId, isEqualTo: job.id)
            .get();
        List<JobOrderModel> jobOrders =
            List<JobOrderModel>.from(result.docs.map((e) {
          return JobOrderModel.queryDocumentSnapshot(e);
        }));
        for (var order in jobOrders) {
          await ls<JobOrderApplicationRemoteDataSource>().deleteJobOrder(order);
        }
      }
      // delete user image from fireStore
      if (ls<UserLocalDataSource>().getUser().image !=
          FireBaseStringConst.usersDefaultImagePath) {
        await firebaseStorage
            .ref()
            .child(Uri.parse(ls<UserLocalDataSource>().getUser().image)
                .pathSegments
                .last)
            .delete();
      }
      // delete account
      await firebaseAuth.signInWithEmailAndPassword(
          email: ls<UserLocalDataSource>().getUser().email,
          password: ls<UserLocalDataSource>().getUser().password);
      await firebaseAuth.currentUser!.delete();
      await ls<UserLocalDataSource>().logout();
    } catch (e) {
      rethrow;
    }
  }
}
