import 'package:ansergame/screen/question/controller/question_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  QuestionController controller = Get.put(QuestionController());

  @override
  void initState() {
    super.initState();

    controller.countDown();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Question",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/img/free-photo-of-green-metal-plate-wall.jpeg'),
              fit: BoxFit.cover, // Adjust this to fit your needs
            ),
          ),
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Center(
            child: SingleChildScrollView(
              child: Obx(
                    () => controller.quizList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Obx(() => Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            "${controller.count}",
                            style: const TextStyle(fontSize: 20,color: Colors.white),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator(
                              value: controller.count / 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )),
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Question :- ${controller.index.value + 1}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                            () => Text(
                          "${controller.quizList[controller.index.value].question}",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Obx(
                            () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            options(
                                '${controller.quizList[controller.index.value].option![0]}'),
                            options(
                                '${controller.quizList[controller.index.value].option![1]}'),
                            options(
                                '${controller.quizList[controller.index.value].option![2]}'),
                            options(
                                '${controller.quizList[controller.index.value].option![3]}'),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),


      ),
    );
  }

  InkWell options(String text) {
    return InkWell(
      onTap: () {
        controller.result(text);

        if (controller.index.value != controller.quizList.length - 1) {
          controller.count.value = 20;
          controller.index.value = controller.index.value + 1;
        } else {
          controller.timer!.cancel();
          Get.offAllNamed('result');
        }
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}
