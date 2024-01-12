import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hortifruitperon/cors/repository/repository.dart';
import 'package:hortifruitperon/data/services/auth_service.dart';
import 'package:hortifruitperon/domain/model/user_model.dart';
import 'package:hortifruitperon/ui/controller/home_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hortifruitperon/domain/usecase/get_image_gallery_usecase.dart';

class UserController extends ChangeNotifier {
  final AuthService authService;
  final HomeController homeController;
  final Repository<UserModel> repository;

  UserController(this.homeController, this.authService, this.repository);

  UserModel? get userSelect => homeController.userSelect;
  final name = TextEditingController();
  final phone = TextEditingController();
  final birthData = TextEditingController();

  bool get hasImage => bytes?.isNotEmpty ?? false;
  Uint8List? bytes;
  String get photo => hasImage ? base64Encode(bytes ?? Uint8List(0)) : '';

  Future<void> setLogout() async {
    await authService.logout();
    notifyListeners();
  }

  setUser({required String? id}) async {
    User? user = await authService.getAuthUser();
    repository.updateOrCreateCollection(idUser: user?.uid ?? '', valuesToUpdate: {
      //'id': user?.uid,
      'isAdmin': userSelect?.isAdmin ?? false,
      'name': name.text.isEmpty ? userSelect?.name : name.text,
      'email': user?.email,
      'phone': phone.text.isEmpty ? userSelect?.phone : phone.text,
      'photo': (bytes?.isEmpty ?? true) ? userSelect?.photo : photo,
      'birth': birthData.text.isEmpty ? userSelect?.birth : birthData.text,
    });
    notifyListeners();
  }

  Future<void> getImageGallery() async {
    final ImagePicker picker = ImagePicker();
    GetImageGalleryUsecase useCase = GetImageGalleryUsecase(picker: picker);
    bytes = await useCase.call();
    notifyListeners();
  }
}
