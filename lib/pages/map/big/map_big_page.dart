import 'package:daystodieutils/pages/map/big/map_big_controller.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class MapBigPage extends GetView<MapBigController> {
  const MapBigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapBigController>(
      id: MapBigController.idRootView,
      builder: (_) {
        return Scaffold(
          appBar: _appBar(_),
          backgroundColor: Colors.white30,
          body: SafeArea(
            child: Listener(
              child: PhotoView(
                imageProvider: FastCachedImageProvider(_.imageUrl),
                scaleStateChangedCallback: (state) {
                  _.changeFullScreen(state.index != 0);
                },
                controller: _.controller,
              ),
              onPointerSignal: (event) {
                if (event is PointerScrollEvent &&
                    event.kind == PointerDeviceKind.mouse) {
                  if (event.scrollDelta.dy < 0) {
                    // 向上滚动
                    _.zoomIn();
                  } else if (event.scrollDelta.dy > 0) {
                    // 向下滚动
                    _.zoomOut();
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }

  _appBar(MapBigController _) {
    return _.isFullScreen == true ? null : ViewUtils.getAppBar("大图");
  }
}
