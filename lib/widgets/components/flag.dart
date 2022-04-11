import 'package:flutter/cupertino.dart';
import 'package:packs/models/country_model.dart';

class Flag extends StatelessWidget {
  final Country? country;
  final bool rounded;
  final double width;
  final double height;

  const Flag(
      {Key? key,
      this.country,
      this.rounded = false,
      this.width = 32,
      this.height: 32})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return country != null
        ? rounded
            ? Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      country!.flagUri,
                    ),
                  ),
                ),
              )
            : Container(
                child: Image.asset(
                  country!.flagUri,
                  width: width,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox.shrink();
                  },
                ),
              )
        : SizedBox.shrink();
  }
}
