import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:packs/utils/services/algolia_application.dart';
import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';
// Widgets:
import 'package:packs/widgets/screens/explore_screen.dart';

class FilterModal extends StatefulWidget {
  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  var _isSpecialOffer = false;
  var _isEcoCertified = false;
  var _showNearest = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: PXSpacing.spacingXL, horizontal: PXSpacing.spacingM),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 24,
              ),
              Expanded(
                child: IgnorePointer(
                  ignoring: true,
                  child: Center(
                    child: SizedBox(
                      height: 5,
                      width: 60,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: PXColor.mysticGreen,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Icon(CupertinoIcons.xmark, color: PXColor.darkText),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(
            height: PXSpacing.spacingXL,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: PXColor.white,
                    border: Border.all(color: PXColor.athensGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(PXSpacing.spacingM),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Only special offers'),
                        CupertinoSwitch(
                          activeColor: PXColor.primary,
                          trackColor: PXColor.mysticGreen,
                          value: _isSpecialOffer,
                          onChanged: (bool value) {
                            setState(() {
                              _isSpecialOffer = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: PXSpacing.spacingM,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: PXColor.white,
                    border: Border.all(color: PXColor.athensGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(PXSpacing.spacingM),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Only eco ceertified offers'),
                        CupertinoSwitch(
                          activeColor: PXColor.primary,
                          trackColor: PXColor.mysticGreen,
                          value: _isEcoCertified,
                          onChanged: (bool value) {
                            setState(() {
                              _isEcoCertified = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: PXSpacing.spacingM,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: PXColor.white,
                    border: Border.all(color: PXColor.athensGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(PXSpacing.spacingM),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Show nearest offers first'),
                        CupertinoSwitch(
                          activeColor: PXColor.primary,
                          trackColor: PXColor.mysticGreen,
                          value: _showNearest,
                          onChanged: (bool value) {
                            setState(() {
                              _showNearest = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CupertinoButton.filled(
            child: Text('Sow results'),
            onPressed: () {
              AlgoliaQuery _algoliaQuery = AlgoliaApplication.algolia.instance
                  .index(AlgoliaApplication.dealsIndex);

              if (_isSpecialOffer) {
                _algoliaQuery =
                    _algoliaQuery.facetFilter('specialOffer:$_isSpecialOffer');
                _algoliaQuery =
                    _algoliaQuery.setAroundLatLng('9.9747709, 53.558725');
              }

              if (_isEcoCertified) {
                _algoliaQuery =
                    _algoliaQuery.facetFilter('ecoCertified:$_isEcoCertified');
              }

              if (_showNearest) {
                _algoliaQuery =
                    _algoliaQuery.setAroundLatLng('9.9747709, 53.558725');
              }

              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) =>
                        ExploreScreen(algoliaQuery: _algoliaQuery)),
              );
            },
          ),
        ],
      ),
    );
  }
}
