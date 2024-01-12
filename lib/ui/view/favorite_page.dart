import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/ui/controller/product_controller.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final product = Modular.get<ProductController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await product.filterFavoriteList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Styles.backgroud,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Modular.to.pop();
          },
          icon: Icon(
            Icons.chevron_left_outlined,
            color: Styles.black,
          ),
        ),
        title: Text(
          'Favoritos',
          style: TextStyle(color: Styles.black),
        ),
      ),
      body: ListenableBuilder(
        listenable: product,
        builder: (context, child) {
          return Padding(
            padding: Paddings.edgeInsets,
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height * 0.5,
                child: product.listFavoriteProduto.isEmpty
                    ? Center(
                        child: Text(
                          'Sua lista está vazia.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            letterSpacing: 0.27,
                            color: Styles.black,
                          ),
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (_, __) => const Padding(padding: EdgeInsets.all(10)),
                        shrinkWrap: true,
                        itemCount: product.listFavoriteProduto.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Styles.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Styles.white,
                                      foregroundImage: MemoryImage(
                                        base64Decode(product.listFavoriteProduto[index].photo),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.listFavoriteProduto[index].name,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'R\$ ${product.listFavoriteProduto[index].price}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Styles.redAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        product.toggleIsFavorite(index);
                                        product.removeListFavorite(index);
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
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
