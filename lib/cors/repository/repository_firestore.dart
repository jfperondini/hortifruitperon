import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hortifruitperon/cors/repository/repository.dart';

abstract class RepositoryFireStore<T> extends Repository<T> {
  String get nameCollection;

  @override
  findUserById({required String id}) async {
    final store = FirebaseFirestore.instance.collection(nameCollection).doc(id);
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await store.get();
      if (snapshot.exists) {
        Map<String, dynamic>? userData = snapshot.data();
        if (userData != null) {
          userData['id'] = snapshot.id;
          return convertJsonToModel(userData);
        }
      }
    } on FirebaseAuthException catch (e) {
      e.message;
    }
  }

  @override
  Future<List<T>> getListCollection({
    String? filterField,
    dynamic filterValue,
    required String orderBy,
    required bool arg,
  }) async {
    QuerySnapshot<Map<String, dynamic>> store;
    if (filterField != null && filterValue != null) {
      if (arg != false) {
        store = await FirebaseFirestore.instance
            .collection(nameCollection)
            .orderBy(orderBy)
            .where(filterField)
            .startAt([filterValue]).endAt(['$filterValue\uf8ff']).get();
      } else {
        store = await FirebaseFirestore.instance
            .collection(nameCollection)
            .where(filterField, isEqualTo: filterValue)
            .get();
      }
    } else {
      store = await FirebaseFirestore.instance.collection(nameCollection).orderBy(orderBy).get();
    }
    //List<Map<String, dynamic>> list = store.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    List<Map<String, dynamic>> list = [];
    for (QueryDocumentSnapshot documentSnapshot in store.docs) {
      Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        data['id'] = documentSnapshot.id;
        list.add(data);
      }
    }
    return convertListJsonToListModel(list);
  }

  @override
  Future<List<T>> getListSubCollection({required String idUser}) async {
    final store =
        await FirebaseFirestore.instance.collection(nameCollection).doc(idUser).collection('sub-$nameCollection').get();
    List<Map<String, dynamic>> list = [];
    for (QueryDocumentSnapshot documentSnapshot in store.docs) {
      Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        data['id'] = documentSnapshot.id;
        list.add(data);
      }
    }
    return convertListJsonToListModel(list);
  }

  @override
  Future<void> updateOrCreateCollection({
    required String idUser,
    required Map<String, dynamic> valuesToUpdate,
  }) async {
    final store = FirebaseFirestore.instance.collection(nameCollection);
    try {
      await store.doc(idUser).set(valuesToUpdate);
    } on FirebaseAuthException catch (e) {
      e.message;
    }
  }

  @override
  Future<void> updateCollectionById({required String idModel, required Map<String, dynamic> valuesToUpdate}) async {
    final store = FirebaseFirestore.instance.collection(nameCollection).doc(idModel);
    try {
      await store.update(valuesToUpdate);
    } on FirebaseAuthException catch (e) {
      e.message;
    }
  }

  @override
  Future<void> updateSubCollection({
    required String idUser,
    required String idModel,
    required Map<String, dynamic> valuesToUpdate,
  }) async {
    final store = FirebaseFirestore.instance.collection(nameCollection).doc(idUser).collection('sub-$nameCollection');
    try {
      await store.doc(idModel).update(valuesToUpdate);
    } on FirebaseAuthException catch (e) {
      e.message;
    }
  }

  @override
  putCollection({required Map<String, dynamic> values}) async {
    final store = FirebaseFirestore.instance.collection(nameCollection);
    try {
      await store.add(values);
    } on FirebaseAuthException catch (e) {
      e.message;
    }
  }

  @override
  putSubCollection({required String idUser, required Map<String, dynamic> values}) async {
    final store = FirebaseFirestore.instance.collection('$nameCollection/$idUser/sub-$nameCollection');
    try {
      await store.add(values);
    } on FirebaseAuthException catch (e) {
      e.message;
    }
  }

  @override
  Future<void> deleteCollection({required String idModel}) async {
    final store = FirebaseFirestore.instance.collection(nameCollection).doc(idModel);
    try {
      await store.delete();
    } on FirebaseAuthException catch (e) {
      e.message;
    }
  }

  @override
  Future<void> deleteSubCollection({required String idUser, required String idModel}) async {
    final store = FirebaseFirestore.instance.collection(nameCollection).doc(idUser).collection('sub-$nameCollection');
    try {
      await store.doc(idModel).delete();
    } on FirebaseAuthException catch (e) {
      e.message;
    }
  }
}
