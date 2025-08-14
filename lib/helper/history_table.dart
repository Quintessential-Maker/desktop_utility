import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FixedHeaderTable extends StatelessWidget {
  final List<Map<String, String>> data;
  final bool showBoth;

  const FixedHeaderTable({
    Key? key,
    required this.data,
    required this.showBoth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ✅ Agar showBoth true hai to table width sirf left section ka lena hai
    final double tableWidth = MediaQuery.of(context).size.width * (showBoth ? 0.55 : 1);

    double colWidth(int percent) => tableWidth * (percent / 100);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // 🔹 Fixed Header
              Container(
                width: tableWidth,
                color: theme.colorScheme.primary.withOpacity(0.1),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  children: [
                    buildHeaderCell('reqTS'.tr, colWidth(18)),
                    buildHeaderCell('url'.tr, colWidth(18)),
                    buildHeaderCell('authToken'.tr, colWidth(18)),
                    buildHeaderCell('repliedTS'.tr, colWidth(18)),
                    buildHeaderCell('statusCode'.tr, colWidth(20)),
                  ],
                ),
              ),

              // 🔹 Scrollable Rows
              SizedBox(
                height: 500,
                width: tableWidth,
                child: SingleChildScrollView(
                  child: Column(
                    children: data.map((item) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Row(
                          children: [
                            buildCell(item['reqTS'] ?? '', colWidth(18)),
                            buildCell(item['url'] ?? '', colWidth(18)),
                            buildCell(item['authToken'] ?? '', colWidth(18)),
                            buildCell(item['repliedTS'] ?? '', colWidth(18)),
                            buildCell(item['statusCode'] ?? '', colWidth(20)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildHeaderCell(String text, double width) {
    return Container(
      width: width,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: hexToColor(CustomColors.primaryColor)),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildCell(String text, double width) {
    return Container(
      width: width,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(color: hexToColor(CustomColors.secondaryColor)),
      ),
    );
  }
}

