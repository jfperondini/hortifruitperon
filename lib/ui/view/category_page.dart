import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/cors/shared/widgets/text_form_field_widget.dart';
import 'package:hortifruitperon/ui/controller/category_controller.dart';
import 'package:hortifruitperon/ui/controller/user_controller.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final category = Modular.get<CategoryController>();
  final user = Modular.get<UserController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await category.getListCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Styles.backgroud,
      appBar: AppBar(
        title: Text('Categoria', style: TextStyle(color: Styles.black)),
        leading: IconButton(
          onPressed: () {
            Modular.to.pop();
          },
          icon: Icon(Icons.chevron_left_outlined, color: Styles.black),
        ),
      ),
      body: Padding(
        padding: Paddings.edgeInsets,
        child: Column(
          children: [
            TextFormFieldWidget(
              controller: category.add,
              inputFormatters: null,
              readOnly: true,
              hintText: 'Cadastrar um nova categoria',
              prefixIcon: Icon(Icons.home, color: Styles.green),
              onTap: () async {
                await Modular.to.pushNamed(Routes.categoryRegister);
              },
            ),
            const SizedBox(height: 10),
            ListenableBuilder(
              listenable: category,
              builder: (context, child) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: size.height - 200,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: category.listCategory.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const BehindMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) async {
                                  await category.deleteCategory(index);
                                },
                                backgroundColor: Styles.redAccent,
                                foregroundColor: Styles.white,
                                icon: Icons.delete,
                                label: 'Deletar',
                              ),
                            ],
                          ),
                          child: Card(
                              elevation: 10,
                              shadowColor: Styles.backgroud,
                              child: ListTile(
                                title: Text(category.listCategory[index].typeName),
                              )),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
