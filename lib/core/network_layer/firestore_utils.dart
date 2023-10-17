import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_application/core/utils/extract_date.dart';
import 'package:to_do_application/model/task_model.dart';

class FirestoreUtils {
  static CollectionReference<TaskModel> getCollection() {
    return FirebaseFirestore.instance
        .collection("Task Collection")
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFirestore(snapshot.data()!),
          toFirestore: (value, _) => value.toFirestore(),
        );
  }

  static Future<void> addDataToFireStore(TaskModel model) async {
    var collectionRef = getCollection();
    var docRef = collectionRef.doc();
    model.id = docRef.id;
    return docRef.set(model);
  }

  static Future<List<TaskModel>> getDataFromFireStore() async {
    var snapshot = await getCollection().get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeDataFromFireStore(
      DateTime dateTime) {
    var date = ExtractDate.extractDate(dateTime);
    var snapshot = getCollection()
        .where("dateTime", isEqualTo: date.millisecondsSinceEpoch)
        .snapshots();
    return snapshot;
  }

  static Future<void> deleteDataFromFirestore(TaskModel model) async {
    var collectionRef = getCollection();
    return collectionRef.doc(model.id).delete();
  }
}
