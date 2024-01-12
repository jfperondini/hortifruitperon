import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hortifruitperon/cors/repository/repository.dart';
import 'package:hortifruitperon/domain/model/category_model.dart';
import 'package:hortifruitperon/domain/usecase/get_image_gallery_usecase.dart';
import 'package:image_picker/image_picker.dart';

class CategoryController extends ChangeNotifier {
  final Repository<CategoryModel> repositoryCategory;

  CategoryController(this.repositoryCategory);

  List<CategoryModel> listCategory = [];
  CategoryModel? categorySelect;

  final typeName = TextEditingController();
  final add = TextEditingController();

  bool get hasImage => bytes?.isNotEmpty ?? false;
  Uint8List? bytes;
  String get photo => hasImage ? base64Encode(bytes ?? Uint8List(0)) : '';

  getListCategory() async {
    listCategory = await repositoryCategory.getListCollection(orderBy: 'typeName', arg: false);
    notifyListeners();
  }

  Future<void> getImageGallery() async {
    final ImagePicker picker = ImagePicker();
    GetImageGalleryUsecase useCase = GetImageGalleryUsecase(picker: picker);
    bytes = await useCase.call();
    notifyListeners();
  }

  putCategory() {
    repositoryCategory.putCollection(values: {
      'typeName': typeName.text,
      'photo': bytes?.isEmpty ?? false ? categorySelect?.photo : photo,
    });
    notifyListeners();
  }

  deleteCategory(int index) async {
    repositoryCategory.deleteCollection(idModel: listCategory[index].id ?? '');
    notifyListeners();
  }

  clearCategory() {
    typeName.text = '';
    bytes = null;
    notifyListeners();
  }
}
