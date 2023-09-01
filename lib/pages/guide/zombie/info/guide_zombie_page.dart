import 'package:cached_network_image/cached_network_image.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'guide_zombie_controller.dart';

class GuideZombiePage extends GetView<GuideZombieController> {
  const GuideZombiePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar("古神图鉴"),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: GetBuilder<GuideZombieController>(
            id: GuideZombieController.idContent,
            builder: (_) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CachedNetworkImage(
                              width: 250,
                              height: 300,
                              imageUrl: "http://via.placeholder.com/250x300",
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 50),
                              child: SizedBox(
                                height: 300,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _itemWidget("名称:", _.zombieName),
                                    _itemWidget("类型:", _.zombieType),
                                    _itemWidget("初始血量:", _.zombieHp),
                                    _itemWidget("掉落物:", _.bootyList),
                                    _itemWidget("尸体材料:", _.corpseDrop),
                                    _itemWidget("注意事项:", _.precautions),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "攻略",
                            style: TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              _.raiders,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 110,
                              height: 35,
                              child: ElevatedButton(
                                child: const Text(
                                  "编辑",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 35,
                              margin: const EdgeInsets.only(left: 20),
                              child: ElevatedButton(
                                child: const Text(
                                  "删除",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  _itemWidget(String desc, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          desc,
          style: const TextStyle(
            color: Colors.blueAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
