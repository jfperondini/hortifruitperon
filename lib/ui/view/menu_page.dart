import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/cors/shared/widgets/menu_title_widget.dart';
import 'package:hortifruitperon/ui/controller/user_controller.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Modular.get<UserController>();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Styles.backgroud,
      appBar: AppBar(
        title: Text('Menu', style: TextStyle(color: Styles.black)),
        leading: IconButton(
          onPressed: () {
            Modular.to.pop();
          },
          icon: Icon(Icons.chevron_left_outlined, color: Styles.black),
        ),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await user.setLogout();
              Modular.to.pushNamedAndRemoveUntil(Routes.login, (p0) => false);
            },
            icon: Icon(
              Icons.logout,
              color: Styles.black,
            ),
            label: Text('Sair', style: TextStyle(color: Styles.black)),
          )
        ],
      ),
      body: Padding(
        padding: Paddings.edgeInsets,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: size.width,
              height: size.height * 0.15,
              decoration: BoxDecoration(
                color: Styles.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Styles.backgroud,
                        child: (user.userSelect?.photo != null && user.userSelect?.photo != '')
                            ? ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.elliptical(100, 100),
                                ),
                                child: Image.memory(
                                  base64Decode(user.userSelect?.photo ?? ''),
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
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user.userSelect?.name ?? 'seu nome',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              letterSpacing: 0.27,
                              color: Styles.black,
                            ),
                          ),
                          Text(
                            user.userSelect?.email ?? 'e-mail',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 0.27,
                              color: Styles.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: size.width,
              height: size.height * 0.65,
              decoration: BoxDecoration(
                color: Styles.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  MenuTitleWidget(
                    icon: Icons.person,
                    title: 'Perfil',
                    route: Routes.user,
                  ),
                  if (user.userSelect?.isAdmin != true)
                    MenuTitleWidget(
                      icon: Icons.credit_card,
                      title: 'Cartões',
                      route: Routes.card,
                    ),
                  if (user.userSelect?.isAdmin != true)
                    MenuTitleWidget(
                      icon: Icons.shopping_basket,
                      title: 'Compras',
                      route: Routes.shopping,
                    ),
                  if (user.userSelect?.isAdmin != false)
                    MenuTitleWidget(
                      icon: Icons.category,
                      title: 'Categoria',
                      route: Routes.category,
                    ),
                  if (user.userSelect?.isAdmin != false)
                    MenuTitleWidget(
                      icon: Icons.add_circle_outline,
                      title: 'Produto',
                      route: Routes.productRegister,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
