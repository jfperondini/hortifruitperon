import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:hortifruitperon/cors/repository/repository.dart';
import 'package:hortifruitperon/domain/model/category_model.dart';
import 'package:hortifruitperon/domain/model/product_model.dart';
import 'package:hortifruitperon/domain/usecase/filter_product_use_case.dart';
import 'package:hortifruitperon/domain/usecase/get_image_gallery_usecase.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends ChangeNotifier {
  final Repository<ProductModel> repositoryProduct;

  ProductController(this.repositoryProduct);

  List<ProductModel> listFilterProduto = [];
  List<ProductModel> listFavoriteProduto = [];

  CategoryModel? categorySelect;
  ProductModel? productSelect;

  final name = TextEditingController();
  final price = TextEditingController();

  bool get hasImage => bytes?.isNotEmpty ?? false;
  Uint8List? bytes;
  String get photo => hasImage ? base64Encode(bytes ?? Uint8List(0)) : '';

  int quantity = 1;

  filterListProduct({required CategoryModel? categoryModel, required String? searcProduct}) async {
    FilterProductUsecase usecase = FilterProductUsecase(repository: repositoryProduct);
    if (searcProduct?.isNotEmpty ?? false) {
      listFilterProduto = await usecase.call(
        filterField: 'name',
        filterValue: searcProduct ?? '',
        arg: true,
      );
    } else {
      listFilterProduto = await usecase.call(
        filterField: 'category.id',
        filterValue: categoryModel?.id ?? '',
        arg: false,
      );
    }
    notifyListeners();
  }

  toggleIsFavorite(int index) {
    listFilterProduto[index].isFavorite = !listFilterProduto[index].isFavorite;
    notifyListeners();
  }

  filterFavoriteList() async {
    listFavoriteProduto = listFilterProduto.where((produto) => produto.isFavorite).toList();
    notifyListeners();
  }

  removeListFavorite(int index) {
    if (index >= 0 && index < listFavoriteProduto.length) {
      listFavoriteProduto.removeAt(index);
    }
  }

  setProduct(int index) {
    productSelect = listFilterProduto[index];
    productSelect?.categoryModel = categorySelect ?? CategoryModel.empty();
    notifyListeners();
  }

  increaseQuantity() {
    quantity++;
    notifyListeners();
  }

  decreaseQuantity() {
    if (quantity > 1) quantity--;
    notifyListeners();
  }

  clearQuantity() {
    quantity = 1;
    notifyListeners();
  }

  valueDropDownCategory(CategoryModel? value) async {
    categorySelect = value;
    notifyListeners();
  }

  putProduct() {
    repositoryProduct.putCollection(values: {
      'name': name.text,
      'price': double.parse(price.text),
      'photo': photo,
      'category': {
        'id': categorySelect?.id ?? '',
        'typeName': categorySelect?.typeName ?? '',
      },
    });
    notifyListeners();
  }

  Future<void> getImageGallery() async {
    final ImagePicker picker = ImagePicker();
    GetImageGalleryUsecase useCase = GetImageGalleryUsecase(picker: picker);
    bytes = await useCase.call();
    notifyListeners();
  }

  clearProduct() {
    name.text = '';
    price.text = '';
    bytes = null;
    notifyListeners();
  }
}
