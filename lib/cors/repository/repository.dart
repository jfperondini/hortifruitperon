abstract class Repository<T> {
  List<T> convertListJsonToListModel(List<Map<String, dynamic>> list) {
    return list.map((e) => convertJsonToModel(e)).toList();
  }

  T convertJsonToModel(Map<String, dynamic> map);

  Map<String, dynamic> convertModelToJson(T model);

  findUserById({required String id});

  Future<List<T>> getListCollection(
      {String? filterField, dynamic filterValue, required String orderBy, required bool arg});

  Future<List<T>> getListSubCollection({required String idUser});

  putSubCollection({required String idUser, required Map<String, dynamic> values});

  putCollection({required Map<String, dynamic> values});

  Future<void> updateOrCreateCollection({required String idUser, required Map<String, dynamic> valuesToUpdate});

  Future<void> updateCollectionById({required String idModel, required Map<String, dynamic> valuesToUpdate});

  Future<void> updateSubCollection(
      {required String idUser, required String idModel, required Map<String, dynamic> valuesToUpdate});

  Future<void> deleteSubCollection({required String idUser, required String idModel});

  Future<void> deleteCollection({required String idModel});
}
