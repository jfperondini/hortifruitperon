import 'package:hortifruitperon/cors/repository/repository.dart';
import 'package:hortifruitperon/domain/model/product_model.dart';

class FilterProductUsecase {
  final Repository<ProductModel> repository;

  FilterProductUsecase({required this.repository});

  Future<List<ProductModel>> call({
    required String filterField,
    required String filterValue,
    required bool arg,
  }) async {
    return repository.getListCollection(
      filterField: filterField,
      filterValue: filterValue,
      orderBy: 'name',
      arg: arg,
    );
  }
}
