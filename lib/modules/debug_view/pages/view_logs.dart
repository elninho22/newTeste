import 'package:applocation/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/debug_view_controller.dart';
import '../models/debug_log_item.dart';
import 'item_logs.dart';

class ViewLogs extends StatelessWidget {
  const ViewLogs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(DebugViewController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs da aplicação'),
      ),
      body: Obx(() { 
              return ListView.separated(
              itemBuilder: (context, index) {
                final DebugLogItem item = _controller.listLog[index];
                return InkWell(
                  onTap: () => Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => ItemLogs(item: item),
                    ),
                  ),
                  child: Container(
                    color: item.type.toString() == "REQUISIÇÃO" ? Colors.amber.withOpacity(0.1) : (item.type.toString() == "RESPONSE" ? Colors.green.withOpacity(0.1) : (item.type.toString() == "ERROR RESPONSE" ? Colors.red.withOpacity(0.1) : Colors.black.withOpacity(0.1))),
                    child: ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          wi('Tipo: ', item.type.toString()),
                          wi('statusCode: ', item.statusCode.toString()),
                          wi('Method: ', item.method.toString()),
                          wi('Path: ', item.path.toString()),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          const Icon(Icons.arrow_right_alt_outlined, size: 30),
                          Text(
                            '',
                            style: GoogleFonts.openSans(fontSize: 14.0, color: ConstColors.blue, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: _controller.listLog.length,
              reverse: true,
            );
          }
        )
    );
  }

  wi(String label, String description) => RichText(
        text: TextSpan(
          text: label,
          style: GoogleFonts.openSans(fontSize: 14.0, color: ConstColors.blue, fontWeight: FontWeight.w700),
          children: [
            TextSpan(
              text: description,
              style: GoogleFonts.openSans(fontSize: 14.0, color: ConstColors.blue, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
}
