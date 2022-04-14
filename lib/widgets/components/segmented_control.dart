import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

class SegmentedControl extends StatefulWidget {
  final List<String> items;
  final int segmentedControlValue;
  final Function(int) callback;
  List<String>? images;
  Color? activeTextColor;

   SegmentedControl({
    required this.items,
    required this.segmentedControlValue,
    required this.callback,
     this.images,this.activeTextColor = PXColor.black
  });

  @override
  State<SegmentedControl> createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.items.length, (index) => SegmentedControlThumb(
          title: widget.items[index],
          isActive: widget.segmentedControlValue == index,
          callback: () => widget.callback(index),
          index: index,
          image: widget.images != null ?  widget.images![index] : "",
          activeTextColor: widget.activeTextColor!,
        )),
      ),
    );
  }
}

class SegmentedControlThumb extends StatefulWidget {
   SegmentedControlThumb({
    required this.title,
    required this.isActive,
    required this.callback,
    required this.index,
     this.image,required this.activeTextColor,
  });

  final String title;
  final bool isActive;
  final Function() callback;
   final int index;
   String? image;
  final Color activeTextColor;

  @override
  State<SegmentedControlThumb> createState() => _SegmentedControlThumbState();
}

class _SegmentedControlThumbState extends State<SegmentedControlThumb> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: PXSpacing.spacingM),
      child: GestureDetector(
        onTap: () => widget.callback(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Fix animation using AnimatedCrossFade
            Row(
              children: [
               if (widget.image != null && widget.image != '') Container(
                  height: 15,
                  margin: const EdgeInsets.only(right: 5),
                  child: Image.asset(widget.image!,color: widget.isActive ? PXColor.pink : PXColor.darkText,),
                ) else Container(),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: widget.isActive
                      ? PXTextStyle.styleLBold
                      : PXTextStyle.styleLRegular,
                  child: Text(
                    widget.title,
                    style:  TextStyle(color: widget.isActive ? widget.activeTextColor : PXColor.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: PXSpacing.spacingXXS),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              // margin: EdgeInsets.only(left: widget.index * 12),
              width: widget.isActive ? 40 : 0,
              decoration: BoxDecoration(
                color: PXColor.pink,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
