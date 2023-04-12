import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/core/utils/extensions.dart';
import 'package:todo_app/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeCtrl.editCtrl.clear();
                      homeCtrl.changeTask(null);
                    },
                    icon: const Icon(Icons.close),
                    color: Colors.grey[700],
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.deepPurple[700]),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                'New task',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCtrl.editCtrl,
                decoration: InputDecoration(
                    hintText: 'Enter your task item title',
                    hintStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple[700]!))),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 5.0.wp),
              child: Text(
                'Add to',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0.sp,
                    color: Colors.grey[500]),
              ),
            ),
            ...homeCtrl.tasks.map((element) => Obx(
                  () => InkWell(
                    onTap: () => homeCtrl.changeTask(element),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.0.wp, vertical: 3.0.wp),
                      child: Row(
                        children: [
                          Icon(
                            IconData(element.icon, fontFamily: 'MaterialIcons'),
                            color: HexColor.fromHex(element.color),
                          ),
                          SizedBox(
                            width: 3.0.wp,
                          ),
                          Text(
                            element.title,
                            style: TextStyle(
                                color: HexColor.fromHex(element.color),
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 3.0.wp,
                          ),
                          if (homeCtrl.task.value == element)
                            Icon(
                              Icons.check,
                              color: HexColor.fromHex(element.color),
                            )
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
