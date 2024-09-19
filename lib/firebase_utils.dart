import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/my_user.dart';

import 'model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection(String uId) {
    // kol ma 23oz 2geb el collection 2nady 3la function gettaskcolle
    return getUsersCollection().doc(uId).collection(Task.collectionName).withConverter<
            Task>(
        // bt5ly el fire base 3rfa no3 el 7aga ely btst5dmha ,keda bn5zn el task
        fromFirestore: ((snapshot, options) =>
            Task.fromFireStore(snapshot.data()!)),
        //data mwgoda gowa firebase fana 34an 2wslha lazm 2wsl lel document ya3ny Task gowah doc gowah data
        toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task, String uId) {
    var taskCollection = getTasksCollection(
        uId); // lw 27tagt 2geb collection ,collection gowah document
    var taskDocRef = taskCollection.doc(); //keda b3ml create le doc leeh id
    task.id = taskDocRef.id; //el auto id elly et3ml fe firebase
    return taskDocRef.set(task);

    /// keda 3mlna collec w 3mlna doc w GBNA id BTA3 DOC 7tetO FE ID BTA3 taskaya w 5znto fe fire bSE
  }

  static Future<void> deleteTaskFromFireStore(Task task, String uId) {
    return getTasksCollection(uId).doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: ((snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()!)),
            toFirestore: (user, options) =>
                user.toFireStore()); //34an firebase tb2a 3rfa no3 el 7aga   ;
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var snapshot = await getUsersCollection().doc(uId).get();
    return snapshot.data();
  }
}
