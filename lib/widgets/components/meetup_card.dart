import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/models/MeetupModel.dart';
import 'package:packs/utils/globals.dart' as globals;
import 'package:packs/widgets/components/icon_button.dart';
import 'package:packs/widgets/components/icon_text.dart';
import 'package:packs/widgets/components/participants_preview.dart';

class MeetupCard extends StatefulWidget {
  final MeetupModel model;

  MeetupCard({required this.model});

  @override
  _MeetupCardState createState() => _MeetupCardState();
}

class _MeetupCardState extends State<MeetupCard> {
  @override
  Widget build(BuildContext context) {
    final isMyMeetup = widget.model.owner.uid == globals.currentUserData.uid;
    final requestAccepted = widget.model.participants
        .map((e) => e.uid!)
        .toList()
        .contains(globals.currentUserData.uid);

    return GestureDetector(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: PXColor.white,
          border: Border.all(color: PXColor.athensGrey),
          borderRadius: BorderRadius.circular(PXBorderRadius.radiusM),
        ),
        child: Padding(
          padding: EdgeInsets.all(PXSpacing.spacingM),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // MARK: - About the Host
                Container(
                  width: 80,
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Image.network(
                            widget.model.owner.logoURL!,
                            height: 64,
                            width: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: PXSpacing.spacingS),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            widget.model.owner.firstName!,
                            style: PXTextStyle.styleLBold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          'Female, 28',
                          style: TextStyle(
                            fontSize: PXFontSize.sizeS,
                            color: PXColor.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: PXSpacing.spacingS),
                // MARK: - Details
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.model.title,
                                  style: PXTextStyle.styleLBold,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: PXSpacing.spacingXS),
                              // TODO: If its my meetup and there open requests show accept + reject button instead
                              // if (widget.viewModel.actionButtonModels != null)
                              SizedBox(width: PXSpacing.spacingXS),
                              Container(
                                child: PXIconButton(
                                  icon: CupertinoIcons.heart,
                                  onTap: () {
                                    print('MeetupCard button pressed');
                                  },
                                ),
                              ),
                            ],
                          ),
                          // TODO: If I am on the list of openRequest
                          Text(
                            'Requested on: ${widget.model.startDate}',
                            style: PXTextStyle.captionLight,
                          ),
                        ],
                      ),
                      SizedBox(height: PXSpacing.spacingS),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: PXSpacing.spacingXS),
                                IconText(
                                  icon: CupertinoIcons.calendar,
                                  text: widget.model.startDate,
                                  fontWeight: FontWeight.w800,
                                ),

                                // Location
                                SizedBox(height: PXSpacing.spacingXS),
                                IconText(
                                  icon: CupertinoIcons.location,
                                  text:
                                      '${widget.model.address?.city!}, ${widget.model.address?.country!}',
                                ),

                                // Show request status if I am NOT the owner
                                if (isMyMeetup != true)
                                  Column(
                                    children: [
                                      SizedBox(height: PXSpacing.spacingXS),
                                      IconText(
                                        icon: requestAccepted
                                            ? CupertinoIcons
                                                .check_mark_circled_solid
                                            : CupertinoIcons
                                                .hourglass_bottomhalf_fill,
                                        text: requestAccepted
                                            ? 'Request accepted'
                                            : 'Request pending',
                                        iconColor: requestAccepted
                                            ? PXColor.neonGreen
                                            : PXColor.red,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(width: PXSpacing.spacingS),
                          ParticipantsPreview(
                            imageURLs: widget.model.participants
                                .map((e) => e.logoURL!) // TODO: Handle nullable
                                .toList(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
