import 'package:applocation/constants/const_colors.dart';
import 'package:applocation/core/enum/application_loading.dart';
import 'package:applocation/core/responsive/responsive_builder.dart';
import 'package:applocation/core/scaffold/app_bar_default.dart';
import 'package:applocation/core/scaffold/app_scaffold.dart';
import 'package:applocation/core/widgets/not_hash_data.dart';
import 'package:applocation/core/widgets/problem_network.dart';
import 'package:applocation/modules/home/infra/models/appview_impl.dart';
import 'package:applocation/modules/home/presenter/controller/appview_controller.dart';
import 'package:applocation/modules/home/presenter/widgets/card_itens.dart';
import 'package:applocation/modules/home/presenter/widgets/shimmer_appview.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppViewItens extends StatefulWidget {
  const AppViewItens({Key? key}) : super(key: key);

  @override
  _AppViewItensState createState() => _AppViewItensState();
}

class _AppViewItensState extends State<AppViewItens> with WidgetsBindingObserver {
  final _controller = Get.find<AppViewController>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getFirst(isFirst: true);
      _scrollController.addListener(() {
        _controller.onScroll(_scrollController.position.pixels, _scrollController.position.maxScrollExtent);
      });
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: ConstColors.background,
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: Colors.white,
          appBar: AppBarDefault.bar(
            
            showIconBackTop: true,
            elevation: 0.5,
            toolbarHeight: 55,
            title: Text(
              'RickandMorty'.tr.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          body: body(),
        ),
      ),
    );
  }

  body() {
    return ResponsiveBuilder(
      builder: (context, view) {
        return RefreshIndicator(
            onRefresh: () async => await _controller.swipeRefresh(),
            child: Obx(() {
              if (_controller.isLoading.value == ApplicationLoading.notConnecting) return ShimmerAppView();
              return AnimatedBuilder(
                animation: _controller,
                builder: (_, Widget? widget) {
                  if (_controller.isLoading.value == ApplicationLoading.notConnecting) {
                    return SizedBox(
                      height: view.localWidgetSize?.height,
                      child: ProblemNetwork(onPressed: () async => await _controller.swipeRefresh()),
                    );
                  }

                  if ((_controller.isLoading.value == ApplicationLoading.notLoading) || (_controller.isLoading.value == ApplicationLoading.nextPageLoading)) {
                    if (_controller.listResult.isEmpty) {
                      return SizedBox(
                        height: view.localWidgetSize?.height,
                        child: NotHashData(onPressed: () async => await _controller.swipeRefresh()),
                      );
                    }
                    return Obx(() {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
                        child: CustomScrollView(
                          controller: _scrollController,
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final AppViewImpl model = _controller.listResult[index];
                                  return CardItens(
                                    controller: _controller,
                                    itemIndex: index,
                                    model: model,
                                  );
                                },
                                childCount: _controller.listResult.length,
                              ),
                            )
                          ],
                        ),
                      );
                    });
                  } else {
                    if (_controller.isLoading.value == ApplicationLoading.shimmerLoading) {
                      return const ShimmerAppView();
                    } else {
                      return const CupertinoActivityIndicator();
                    }
                  }
                },
              );
            }));
      },
    );
  }
}
