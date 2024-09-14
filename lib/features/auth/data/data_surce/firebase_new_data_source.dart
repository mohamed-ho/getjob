import 'package:firebase_auth/firebase_auth.dart';

class FirebaseNewDataSource {
  final user = FirebaseAuth.instance.currentUser;

  List getUserProfile() {
    if (user != null) {
      // Name, email address, and profile photo URL
      final name = user!.displayName;
      final email = user!.email;
      final photoUrl = user!.photoURL;

      // Check if user's email is verified
      final emailVerified = user!.emailVerified;

      // The user's ID, unique to the Firebase project. Do NOT use this value to
      // authenticate with your backend server, if you have one. Use
      // User.getIdToken() instead.
      final uid = user!.uid;
      return [name, email, photoUrl, emailVerified, uid];
    }
    return ['you', 'have', 'no', 'data'];
  }
}
