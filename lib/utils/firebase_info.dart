import 'package:firedart/firedart.dart';

const apiKey = 'AIzaSyBKAWgzK2pGcsqxvJBRdJrmbC8RbipqsU8';
const projectId = 'appsdashboard-91087';
const email = 'seuxbaptiste@gmail.com';
const password = 'testtest';

Future<bool> firebaseAuthenticate() async {
  FirebaseAuth.initialize(apiKey, VolatileStore());
  Firestore.initialize(projectId); // Firestore reuses the auth client

  var auth = FirebaseAuth.instance;
  // Monitor sign-in state
  auth.signInState.listen((state) => print("Signed ${state ? "in" : "out"}"));

  // Sign in with user credentials
  try {
    await auth.signIn(email, password);

    // Get user object
    var user = await auth.getUser();

    return true;
  } catch (e) {
    return false;
  }
}
