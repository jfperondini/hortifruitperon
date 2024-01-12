import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/cors/shared/widgets/circle_button_widget.dart';
import 'package:hortifruitperon/cors/shared/widgets/text_form_field_widget.dart';
import 'package:hortifruitperon/ui/controller/category_controller.dart';
import 'package:hortifruitperon/ui/controller/home_controller.dart';
import 'package:hortifruitperon/ui/controller/product_controller.dart';
import 'package:hortifruitperon/ui/view/menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final home = Modular.get<HomeController>();
  final category = Modular.get<CategoryController>();
  final product = Modular.get<ProductController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await home.getUser();
      await category.getListCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> stateKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: stateKey,
      backgroundColor: Styles.backgroud,
      drawer: const MenuPage(),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 18, right: 18),
        child: Column(
          children: [
            ListenableBuilder(
              listenable: home,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          stateKey.currentState?.openDrawer();
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Styles.white,
                              child: (home.userSelect?.photo != null && home.userSelect?.photo != '')
                                  ? ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.elliptical(100, 100),
                                      ),
                                      child: Image.memory(
                                        base64Decode(home.userSelect?.photo ?? ''),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(
                                      Icons.person,
                                      color: Styles.grey,
                                      size: 30,
                                    ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  home.getDateTime(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0.2,
                                    color: Styles.grey,
                                  ),
                                ),
                                Text(
                                  home.userSelect?.name ?? 'seu nome',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: (home.userSelect?.name != null) ? 22 : 14,
                                    letterSpacing: 0.27,
                                    color: Styles.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            TextFormFieldWidget(
              controller: home.search,
              inputFormatters: null,
              hintText: 'Procurar um produto',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Icon(
                  Icons.search_outlined,
                  color: Styles.green,
                ),
              ),
              onFieldSubmitted: (String value) async {
                if (value.isNotEmpty) {
                  await product.filterListProduct(
                    categoryModel: null,
                    searcProduct: value,
                  );

                  home.search.clear();
                }
              },
            ),
            const SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categoria',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        letterSpacing: 0.27,
                        color: Styles.black,
                      ),
                    ),
                  ],
                ),
                ListenableBuilder(
                  listenable: category,
                  builder: (context, child) {
                    return SingleChildScrollView(
                      child: SizedBox(
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: category.listCategory.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CircleButtonWidget(
                              onTap: () async {
                                await product.filterListProduct(
                                  categoryModel: category.listCategory[index],
                                  searcProduct: null,
                                );
                              },
                              title: category.listCategory[index].typeName,
                              photo: category.listCategory[index].photo,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                ListenableBuilder(
                  listenable: product,
                  builder: (context, child) {
                    return SingleChildScrollView(
                      child: SizedBox(
                        height: 420,
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 180,
                          ),
                          itemCount: product.listFilterProduto.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () async {
                                await product.setProduct(index);
                                await Modular.to.pushNamed(Routes.productDetail);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Styles.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.memory(
                                          base64Decode(product.listFilterProduto[index].photo),
                                          height: 107,
                                          width: 107,
                                          fit: BoxFit.cover,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            product.toggleIsFavorite(index);
                                          },
                                          icon: Icon(
                                            (product.listFilterProduto[index].isFavorite)
                                                ? Icons.favorite
                                                : Icons.favorite_outline,
                                            color: Styles.redAccent,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      product.listFilterProduto[index].name,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6.0),
                                    Row(
                                      children: [
                                        Text(
                                          'R\$ ${product.listFilterProduto[index].price.toString()}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Styles.redAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Styles.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: (home.userSelect?.isAdmin != true)
              ? [
                  IconButton(
                    icon: Icon(Icons.menu, color: Styles.green),
                    onPressed: () {
                      Modular.to.pushNamed(Routes.menu);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite_border_outlined, color: Styles.green),
                    onPressed: () {
                      Modular.to.pushNamed(Routes.favorite);
                    },
                  ),
                  if (home.orderSelect?.listOrderItemModel.isNotEmpty ?? false)
                    IconButton(
                      icon: Icon(Icons.shopping_cart_checkout, color: Styles.green),
                      onPressed: () {
                        Modular.to.pushNamed(Routes.order);
                      },
                    ),
                ]
              : [],
        ),
      ),
    );
  }
}
