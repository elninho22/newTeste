import 'package:applocation/constants/const_colors.dart';
import 'package:applocation/core/responsive/responsive_builder.dart';
import 'package:applocation/core/scaffold/app_bar_default.dart';
import 'package:applocation/core/scaffold/app_scaffold.dart';
import 'package:applocation/modules/home/presenter/controller/appview_controller.dart';
import 'package:applocation/modules/home/presenter/pages/appview_itens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class AppViewPhone extends StatefulWidget {
  const AppViewPhone({Key? key}) : super(key: key);

  @override
  _AppViewPhoneState createState() => _AppViewPhoneState();
}

class _AppViewPhoneState extends State<AppViewPhone> with WidgetsBindingObserver {
  final _controller = Get.find<AppViewController>();
  final _scrollController = ScrollController();
  String? lat, long, country, adminArea;

  late Location location;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      location = Location();
      location.onLocationChanged.listen((LocationData currentLocation) {
        _controller.getLocaltionOperation();
        _controller.distanceBetweenSet(currentLocation.latitude!, currentLocation.longitude!, _controller.latLocation.value, _controller.lonLocation.value);
        _controller.bearingBetweenSet(currentLocation.latitude!, currentLocation.longitude!, _controller.latLocation.value, _controller.lonLocation.value);
      });
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
      backgroundColor: ConstColors.white,
      onWillPop: () async => await Future.value(true),
      appBar: AppBarDefault.bar(
        showIconBackTop: false,
        elevation: 0.5,
        toolbarHeight: 55,
        title: Text(
          'homeAppView'.tr.toUpperCase(),
          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: ConstColors.background),
              accountName: Text(
                "André Juliano",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "andrejulianom@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
              ),
              title: const Text('Itens'),
              onTap: () {
                Get.to(() => const AppViewItens());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
              ),
              title: const Text('Configuraçoes'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(child: body()),
    );
  }

  TextStyle getStyle({double size = 14}) => TextStyle(fontSize: size, fontWeight: FontWeight.w600);

  body() {
    return ResponsiveBuilder(builder: (context, view) {
      return Container(
        height: view.localWidgetSize?.height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      onTap: () => Get.to(() => const AppViewItens()),
                      title: const Text('Lista de personagens'),
                      subtitle: const Text('Leitura da API'),
                    ),
                  ),
                )
              ],
            ),
            const Divider(height: 15),
            Obx(() {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Minhas informações:',
                        style: getStyle(size: 20),
                      ),
                      Text(
                        'Latitude: ${_controller.lat.value}',
                        style: getStyle(),
                      ),
                      Text(
                        'Longitude: ${_controller.lon.value}',
                        style: getStyle(),
                      ),
                      Text(
                        'Pais: ${_controller.country.value}',
                        style: getStyle(),
                      ),
                      Text(
                        'Cidade: ${_controller.adminArea.value}',
                        style: getStyle(),
                      ),
                      Text(
                        'Rua: ${_controller.street.value}',
                        style: getStyle(),
                      ),
                      Text(
                        'Número: ${_controller.numberStreet.value}',
                        style: getStyle(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            }),
            const Divider(height: 15),
            Obx(() {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Meu destino:',
                        style: getStyle(size: 20),
                      ),
                      Text(
                        'Latitude: ${_controller.latLocation.value}',
                        style: getStyle(),
                      ),
                      Text(
                        'Longitude: ${_controller.lonLocation.value}',
                        style: getStyle(),
                      ),
                      Text(
                        'Cep: ${_controller.setCep.value}',
                        style: getStyle(),
                      ),
                      Text(
                        'Cidade: ${_controller.setCountry.value}',
                        style: getStyle(),
                      ),
                      Text(
                        'Rua: ${_controller.setStreet.value}',
                        style: getStyle(),
                      ),
                      Text(
                        'Número: ${_controller.setNumberStreet.value}',
                        style: getStyle(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            }),
            Obx(() {
              return Card(
                color: _controller.distanceKm.value < 1000 ? Colors.greenAccent : Colors.amber.shade300,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informações adicionais:',
                        style: getStyle(size: 24),
                      ),
                      _controller.distanceKm.value < 1000
                          ? Text(
                              'Distancia Total (m): ${_controller.distanceKm.value.toStringAsFixed(0)}',
                              style: getStyle(),
                            )
                          : Text(
                              'Distancia Total (km): ${_controller.distanceKm.value.toStringAsFixed(0)}',
                              style: getStyle(),
                            ),
                      Visibility(
                        visible: _controller.distanceKm.value < 1000,
                        child: ListTile(
                          onTap: () => Get.to(() => const AppViewItens()),
                          title: Expanded(
                            child: Row(
                              children: [
                                const Text('Coleta'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(height: 20, width: 20, child: circleYes),
                                )
                              ],
                            ),
                          ),
                          subtitle: const Text('Clique aqui para coletar'),
                          trailing: Column(
                            children: const [
                              Icon(
                                Icons.arrow_right_alt_outlined,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        replacement: ListTile(
                          onTap: () => Get.to(() => const AppViewItens()),
                          title: Expanded(
                            child: Row(
                              children: [
                                const Text('Coleta'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(height: 20, width: 20, child: circleNot),
                                )
                              ],
                            ),
                          ),
                          subtitle: const Text('Não disponivel, dirija-se ao destino'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      );
    });
  }

  Widget circleNot = Container(
    width: 2.0,
    height: 2.0,
    decoration: const BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
    ),
  );
  Widget circleYes = Container(
    width: 2.0,
    height: 2.0,
    decoration: const BoxDecoration(
      color: Colors.green,
      shape: BoxShape.circle,
    ),
  );
}
