import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/models/AddressModel.dart';
import 'package:packs/models/CompanyModel.dart';
import 'package:packs/models/DealModel.dart';
import 'package:packs/modules/deals/screens/deal_detail_screen.dart';
import 'package:packs/utils/globals.dart' as globals;
import 'package:packs/utils/services/database_manager.dart';
import 'package:packs/widgets/components/company_intro.dart';

class DealCard extends StatefulWidget {
  final DealModel model;
  // temporary flag only for show design later on it will removed
  final bool? showMeetups;

  DealCard({required this.model, this.showMeetups = false});

  @override
  _DealCardState createState() => _DealCardState();
}

class _DealCardState extends State<DealCard> {
  final _databaseManager = DatabaseManager();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, PXSpacing.spacingM),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: PXColor.white,
          border: Border.all(color: PXColor.lightGrey),
          borderRadius: BorderRadius.circular(PXBorderRadius.radiusM),
        ),
        child: widget.showMeetups! ? meetupCardWidget() : dealCardWidget(),
      ),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => DealDetailScreen(model: widget.model),
          ),
        );
      },
    );
  }

  Widget dealCardWidget() {
    return Column(
      children: [
        // Image
        Stack(
          children: [
            if (widget.model.titleImage != null)
              Image.network(
                widget.model.titleImage!,
                height: 160.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            Positioned.fill(
              right: 5,
              top: 5,
              child: Align(
                alignment: Alignment.topRight,
                child: heartButton(),
              ),
            )
          ],
        ),
        // Info/Text Box
        Padding(
          padding: EdgeInsets.all(PXSpacing.spacingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: PXSpacing.spacingS),
              Container(
                width: double.infinity,
                child: Text(
                  // TODO: Handle nullable
                  widget.model.name!,
                  style: PXTextStyle.styleLBold,
                ),
              ),
              SizedBox(height: PXSpacing.spacingS),
              Text(
                // TODO: Handle nullable
                '${widget.model.price!.currency} \$${widget.model.price!.value}',
                style: PXTextStyle.styleLBold,
              ),
              SizedBox(height: PXSpacing.spacingXS),
              // TODO: Handle nullable
              if (widget.model.price?.priceBeforeDiscount != null)
                Text(
                  widget.model.price!.priceBeforeDiscount.toString(),
                  style: TextStyle(
                    fontSize: PXFontSize.sizeXS,
                    color: PXColor.textLight,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              SizedBox(height: PXSpacing.spacingM),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // TODO: Should we add the company rating to each deal or
                  // do we just want to add a reference and load from there?
                  //
                  // TODO: Replace with `widget.model.companyBlaBla...`
                  CompanyIntro(
                    model: CompanyModel(
                      logoURL:
                      'https://d1wnwqwep8qkqc.cloudfront.net/uploads/stage/stage_image/41544/optimized_large_thumb_stage.jpg',
                      name: 'Jeep Xplorers',
                      address: AddressModel(
                          city: widget.model.address!.city, country: widget.model.address!.country),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: PXFontSize.headline,
                          color: PXColor.yellow,
                        ),
                        SizedBox(width: PXSpacing.spacingXS),
                        Text('4.5', style: PXTextStyle.styleMBold),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget meetupCardWidget() {
    return Container(
      padding: const EdgeInsets.all(PXSpacing.spacingM),
      child: Column(
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.model.titleImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(PXBorderRadius.radiusXXL)),
                  child: Image.network(
                    widget.model.titleImage!,
                    height: 65.0,
                    width: 65,
                    fit: BoxFit.cover,
                  ),
                ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  // TODO: Handle nullable
                  widget.model.name!,
                  style: PXTextStyle.styleLBold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: PXColor.lightGrey),
                  borderRadius: const BorderRadius.all(Radius.circular(PXBorderRadius.radiusXXL)),
                ),
                child: heartButton(),
              )
            ],
          ),
          SizedBox(height: PXSpacing.spacingM,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Zoey",style: PXTextStyle.styleMBold,),
                    Text("Female, 21",style: PXTextStyle.styleSRegular.copyWith(color: PXColor.textLight),),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(PXImages.calenderCheck,height: 15,width: 15,),
                      SizedBox(width: PXSpacing.spacingXS,),
                      Text('11.06.2022',style: PXTextStyle.styleSBold,)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Image.asset(PXImages.blackMarker,height: 15,width: 15,),
                      ),
                      SizedBox(width: PXSpacing.spacingXS,),
                      Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(widget.model.address!.city!+", "+widget.model.address!.country!,style: PXTextStyle.styleSRegular.copyWith(color: PXColor.textLight),))
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 100,
                child: Stack(
                  children: List.generate(4, (index) =>
                    index == 0 ? roundedImage() : index == 3 ? Positioned(
                        left: index * 15,
                        child: Container(
                          height: 32,
                          width: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: PXColor.white,width: 1.5),
                              borderRadius: BorderRadius.all(Radius.circular(PXBorderRadius.radiusXXL)),
                              color: PXColor.lightGrey
                          ),
                          child:Text("4+",style: PXTextStyle.styleSBold),
                        )
                    ) : Positioned(
                        left: index * 15,
                        child: roundedImage()
                    )
                  )
                ),
              )
            ],
          )

        ],
      ),
    );
  }


  Widget roundedImage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: PXColor.white,width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(PXBorderRadius.radiusXXL)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(PXBorderRadius.radiusXXL)),
        child: Image.network(widget.model.titleImage!,height: 30,width: 30,fit: BoxFit.cover),
      ),
    );
  }


  Widget heartButton() {
    return SizedBox(
      height: 30,
      width: 30,
      child: CupertinoButton(
        color: Colors.white,
        padding: EdgeInsets.zero,
        borderRadius: const BorderRadius.all(Radius.circular(PXBorderRadius.radiusXXL)),
        child: Icon(
          globals.currentUserData.savedDeals != null &&
              globals.currentUserData.savedDeals!
                  .contains(widget.model.uid)
              ? CupertinoIcons.heart_fill
              : CupertinoIcons.heart,
          color: PXColor.darkText,
          size: 20,
        ),
        onPressed: () {
          // TODO: Handle nullable
          if (globals.currentUserData.savedDeals == null) {
            globals.currentUserData.savedDeals = [];
          }

          if (!globals.currentUserData.savedDeals!
              .contains(widget.model.uid)) {
            globals.currentUserData.savedDeals!
                .add(widget.model.uid!);
          } else {
            globals.currentUserData.savedDeals!
                .remove(widget.model.uid!);
          }

          setState(() => {
            _databaseManager.setUserData(),
          });
        },
      ),
    );
  }


}







// TODO: Extract to separate component
class CompanyRating extends StatelessWidget {
  final DealModel model;

  CompanyRating({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.network(
                "https://d1wnwqwep8qkqc.cloudfront.net/uploads/stage/stage_image/41544/optimized_large_thumb_stage.jpg",
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lorem Company',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "⭐⭐⭐⭐⭐️️️ 4.5",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
