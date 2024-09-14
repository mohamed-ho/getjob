import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/core/errors/exceptions.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart' as path;

abstract class UserRemoteDataSource {
  Future<void> signUp(UserModel user);
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
  Future<void> updateUser(UserModel user);
  Future<UserModel> loginWithGoogle();
  Future<UserModel> loginWithFacebook();
  Future<void> changePassword(String email);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  UserRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.firebaseFirestore});
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
        var firebaseStorage =
            FirebaseStorage.instance.ref(FireBaseStringConst.usersImagesPath);
        final fileExtension = path.extension(user.file!.path);
        // add the image name
        String image =
            '${FirebaseAuth.instance.currentUser!.uid}.$fileExtension';
        if (user.image != FireBaseStringConst.usersDefaultImagePath) {
          await FirebaseStorage.instance.refFromURL(user.image).delete();
        }

        // upload the image
        await firebaseStorage.child(image).putFile(user.file!);
        //add the new image path to the user
        user.image = await firebaseStorage.child(image).getDownloadURL();

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
        UserLocalDataSourceImpl().setUser(user);
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
  Future<UserModel> loginWithFacebook() {
    // TODO: implement loginWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    // print('start .............................');
    // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // print('thired...........................');
    // if (googleUser == null) {
    //   throw const ServerExceptions('you do not chooce any google email');
    // }
    // print('firest .......................');
    // // Obtain the auth details from the request
    // final GoogleSignInAuthentication googleAuth =
    //     await googleUser.authentication;
    // print('second .......................');
    // // Create a new credential
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );
    // print('you are here ');
    // // Once signed in, return the UserCredential
    // final user = await FirebaseAuth.instance.signInWithCredential(credential);
    // print('her here here');
    // print(user.user!.displayName);
    // print(user.user!.email);
    // print(user.user!.photoURL);
    // print(user.user!.uid);
    // print(user.user!.emailVerified);
    // TODO: implement loginWithFacebook
    throw UnimplementedError();
  }
}
