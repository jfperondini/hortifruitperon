import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/repository/repository.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/cors/uid/uid_generate.dart';
import 'package:hortifruitperon/cors/uid/uid_igenerate.dart';
import 'package:hortifruitperon/data/repository/card_repository.dart';
import 'package:hortifruitperon/data/repository/category_repository.dart';
import 'package:hortifruitperon/data/repository/order_repository.dart';
import 'package:hortifruitperon/data/repository/product_repository.dart';
import 'package:hortifruitperon/data/repository/user_repository.dart';
import 'package:hortifruitperon/data/services/auth_service.dart';
import 'package:hortifruitperon/domain/model/card_model.dart';
import 'package:hortifruitperon/domain/model/category_model.dart';
import 'package:hortifruitperon/domain/model/order_model.dart';
import 'package:hortifruitperon/domain/model/product_model.dart';
import 'package:hortifruitperon/domain/model/user_model.dart';
import 'package:hortifruitperon/ui/controller/auth_controller.dart';
import 'package:hortifruitperon/ui/controller/card_controller.dart';
import 'package:hortifruitperon/ui/controller/home_controller.dart';
import 'package:hortifruitperon/ui/controller/login_controller.dart';
import 'package:hortifruitperon/ui/controller/order_controller.dart';
import 'package:hortifruitperon/ui/controller/category_controller.dart';
import 'package:hortifruitperon/ui/controller/payment_controller.dart';
import 'package:hortifruitperon/ui/controller/product_controller.dart';
import 'package:hortifruitperon/ui/controller/user_controller.dart';
import 'package:hortifruitperon/ui/view/auth_check.dart';
import 'package:hortifruitperon/ui/view/card_page.dart';
import 'package:hortifruitperon/ui/view/card_register_page.dart';
import 'package:hortifruitperon/ui/view/category_page.dart';
import 'package:hortifruitperon/ui/view/favorite_page.dart';
import 'package:hortifruitperon/ui/view/home_page.dart';
import 'package:hortifruitperon/ui/view/intro_page.dart';
import 'package:hortifruitperon/ui/view/login_page.dart';
import 'package:hortifruitperon/ui/view/order_page.dart';
import 'package:hortifruitperon/ui/view/category_register_page.dart';
import 'package:hortifruitperon/ui/view/menu_page.dart';
import 'package:hortifruitperon/ui/view/payment_page.dart';
import 'package:hortifruitperon/ui/view/product_detail_page.dart';
import 'package:hortifruitperon/ui/view/product_register_page.dart';
import 'package:hortifruitperon/ui/view/shopping_detail_page.dart';
import 'package:hortifruitperon/ui/view/shopping_page.dart';
import 'package:hortifruitperon/ui/view/splash_page.dart';
import 'package:hortifruitperon/ui/view/user_page.dart';

class HortiFruitModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(AuthService.new);

    i.addLazySingleton<UidIGenerate>(UidGenerate.new);

    i.addSingleton<Repository<UserModel>>(UserRepository.new);
    i.addSingleton<Repository<CardModel>>(CardRepository.new);
    i.addSingleton<Repository<CategoryModel>>(CategoryRepository.new);
    i.addSingleton<Repository<ProductModel>>(ProductRepository.new);
    i.addSingleton<Repository<OrderModel>>(OrderRepository.new);

    i.addSingleton(AuthController.new);
    i.addSingleton(LoginController.new);
    i.addSingleton(HomeController.new);
    i.addSingleton(UserController.new);
    i.addSingleton(CardController.new);
    i.addSingleton(CategoryController.new);
    i.addSingleton(ProductController.new);
    i.addSingleton(OrderController.new);
    i.addSingleton(PaymentController.new);
  }

  @override
  void routes(r) {
    r.child(Routes.initialRoute, child: (_) => const SplashPage());
    r.child(Routes.authCheck, child: (_) => const AuthCheck());
    r.child(Routes.intro, child: (_) => const IntroPage());
    r.child(Routes.menu, child: (_) => const MenuPage());
    r.child(Routes.login, child: (_) => const LoginPage());
    r.child(Routes.home, child: (_) => const HomePage());
    r.child(Routes.user, child: (_) => const UserPage());
    r.child(Routes.card, child: (_) => const CardPage());
    r.child(Routes.cardRegister, child: (_) => const CardRegisterPage());
    r.child(Routes.category, child: (_) => const CategoryPage());
    r.child(Routes.categoryRegister, child: (_) => const CategoryRegisterPage());
    r.child(Routes.productRegister, child: (_) => const ProductRegisterPage());
    r.child(Routes.productDetail, child: (_) => const ProductDetailPage());
    r.child(Routes.favorite, child: (_) => const FavoritePage());
    r.child(Routes.order, child: (_) => const OrderPage());
    r.child(Routes.payment, child: (_) => const PaymentPage());
    r.child(Routes.shopping, child: (_) => const ShoppingPage());
    r.child(Routes.shoppingDetail, child: (_) => ShoppingDetailPage(orderSelect: r.args.data));
  }
}
