import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

enum IconTextCardType {
  standard,
  selectable,
  expandable,
  button,
}

class IconTextCard extends StatefulWidget {
  final IconTextCardType type;
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final String? text;
  final Color? highlightColor;
  final Color backgroundColor;
  final bool active;

  IconTextCard({
    required this.type,
    this.icon,
    this.title,
    this.subtitle,
    this.text,
    this.highlightColor,
    this.backgroundColor = PXColor.white,
    this.active = false,
  });

  @override
  _IconTextCardState createState() => _IconTextCardState();
}

class _IconTextCardState extends State<IconTextCard>
    with TickerProviderStateMixin {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    final bool isBackgroundDark =
        widget.backgroundColor.computeLuminance() < 0.5;
    final Color highlightColor = widget.highlightColor != null
        ? widget.highlightColor!
        : widget.backgroundColor.computeLuminance() < 0.5
            ? PXColor.white
            : PXColor.black;
    final Color textColor = isBackgroundDark ? PXColor.white : PXColor.black;

    IconData? actionIcon;
    switch (widget.type) {
      case IconTextCardType.standard:
        actionIcon = null;
        break;
      case IconTextCardType.selectable:
        actionIcon =
            active ? CupertinoIcons.circle : CupertinoIcons.check_mark_circled;
        break;
      case IconTextCardType.expandable:
        actionIcon = active ? CupertinoIcons.xmark : CupertinoIcons.plus;
        break;
      case IconTextCardType.button:
        actionIcon = CupertinoIcons.chevron_right;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: PXSpacing.spacingM),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: widget.backgroundColor.computeLuminance() > 0.9
            ? Border.all(color: PXColor.lightGrey)
            : null,
        borderRadius:
            const BorderRadius.all(Radius.circular(PXBorderRadius.radiusS)),
      ),
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PXSpacing.spacingM,
            vertical: PXSpacing.spacingL,
          ),
          child: Row(
            crossAxisAlignment: widget.subtitle != null || widget.text != null
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: PXSpacing.spacingM),
                  child: Icon(
                    widget.icon,
                    color: highlightColor,
                    size: 28,
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // MARK: Title
                        if (widget.title != null)
                          Expanded(
                            child: Text(
                              widget.title!,
                              style: TextStyle(
                                fontSize: PXFontSize.body,
                                fontWeight: FontWeight.bold,
                                color: highlightColor,
                              ),
                            ),
                          ),
                        // MARK: Action Icon
                        if (actionIcon != null)
                          Icon(
                            actionIcon,
                            color: highlightColor,
                            size: 20,
                          ),
                      ],
                    ),
                    // MARK: Subtitle
                    if (widget.subtitle != null)
                      Container(
                        width: double.infinity,
                        child: Text(
                          widget.subtitle!,
                          style: TextStyle(
                            fontSize: PXFontSize.body,
                            height: PXLineHeight.heightM,
                            color: textColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                    // MARK: Body
                    if (widget.text != null)
                      AnimatedSize(
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 200),
                        vsync: this,
                        child: Container(
                          margin: (active ||
                                  widget.type != IconTextCardType.expandable)
                              ? const EdgeInsets.only(top: PXSpacing.spacingS)
                              : EdgeInsets.zero,
                          constraints: (active ||
                                  widget.type != IconTextCardType.expandable)
                              ? const BoxConstraints()
                              : const BoxConstraints(maxHeight: 0),
                          child: Text(
                            widget.text!,
                            style: TextStyle(
                              fontSize: PXFontSize.body,
                              height: PXLineHeight.heightM,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          setState(() => {
                active = !active,
              });
        },
      ),
    );
  }
}
