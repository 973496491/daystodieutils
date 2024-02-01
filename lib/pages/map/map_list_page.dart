import 'package:daystodieutils/module/entity/map_list_resp.dart';
import 'package:daystodieutils/pages/map/map_list_controller.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapListPage extends GetView<MapListController> {
  const MapListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar(
        "地图列表",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GetBuilder<MapListController>(builder: (_) {
              return const Text(
                "搜索",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ).onClick(() => _.showSearchDialog(context));
            }),
          ),
        ],
      ),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 30),
                child: GetBuilder<MapListController>(
                  id: MapListController.idListView,
                  builder: (_) {
                    return SizedBox(
                      width: 1000,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.80,
                        ),
                        itemCount: _.itemList.length,
                        itemBuilder: (context, index) {
                          return _itemWidget(_.itemList[index]);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        width: 100,
        height: 100,
        child: GetBuilder<MapListController>(
          builder: (_) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 0.5,
                  color: Colors.blueAccent,
                ),
              ),
              child: IconButton(
                color: Colors.blue,
                icon: const Icon(Icons.add),
                onPressed: () => _.addMapItem(),
              ),
            );
          },
        ),
      ),
    );
  }

  _itemWidget(MapListResp? item) {
    double size = (1000 - 15 * 3) / 4;
    var imageUrl = item?.imageUrl ?? "";
    if (imageUrl.isNotEmpty) {
      imageUrl = "$imageUrl?imageView2/1/w/100/q/15";
    }
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: const RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: FastCachedImage(
                url: item?.imageUrl ?? "",
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              item?.name ?? "--",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ).marginOnly(top: 10),
          ],
        ),
      ),
    ).onClick(() => controller.toDetailPage("${item?.imageUrl}"));
  }
}
