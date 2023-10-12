import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wire_viewer/models/Item.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails({
    required this.isInTabletLayout,
    this.item,
  });

  final bool isInTabletLayout;
  final Item? item;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = Padding(
      padding: const EdgeInsets.all(20.0),
      child: item != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: (item!.image.toString() != ''
                      ? Image.network(
                          item!.image.toString(),
                          width: 150,
                        )
                      : Image.asset(
                          "assets/images/No_image_available.png",
                          width: 150,
                        )),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  item?.title ?? 'Please select any character',
                  style: textTheme.headlineLarge,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  item?.description ?? 'Please select any character',
                  style: textTheme.bodyLarge,
                ),
              ],
            )
          : Text(
              'Please select any character',
              style: textTheme.headlineLarge,
            ),
    );

    if (isInTabletLayout) {
      return Center(child: content);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item!.title),
      ),
      body: Center(child: content),
    );
  }
}
