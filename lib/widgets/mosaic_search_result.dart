import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mosaic_rs_application/main.dart';
import 'package:mosaic_rs_application/widgets/mosaic_search_result_large.dart';
import 'package:mosaic_rs_application/widgets/standard_elements/calendar_time_line.dart';
import 'package:mosaic_rs_application/widgets/standard_elements/frederic_card.dart';

import 'standard_elements/frederic_chip.dart';

import 'dart:js' as js;

class MosaicSearchResult extends StatelessWidget {
  MosaicSearchResult(
      {super.key,
      required this.url,
      required this.title,
      required this.text,
      this.rawData,
      this.textHeader = 'Excerpt',
      this.chips = const <String>[]});

  final Map<String, dynamic>? rawData;

  final String url;
  final List<String> chips;
  final String title;
  final String text;
  final String textHeader;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, right: 24),
      child: SizedBox(
        height: 200,
        child: Row(
          children: [
            CalendarTimeLine(
              isActive: true,
              activeColor: theme.mainColor,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return Center(
                          child: MosaicSearchResultLarge(data: rawData ?? {}));
                    },
                  ),
                  child: FredericCard(
                    height: 200,
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Linkify(
                                options: LinkifyOptions(),
                                style: TextStyle(fontFamily: 'Montserrat'),
                                text: url,
                                onOpen: (e) =>
                                    js.context.callMethod('open', [url]),
                              ),
                            ),
                            for (final chip in chips)
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: FredericChip(chip),
                              ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Flexible(
                          child: Text(
                            title,
                            style: GoogleFonts.montserrat(
                                color: theme.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          textHeader,
                          style: GoogleFonts.montserrat(
                              color: theme.greyTextColor, fontSize: 12),
                        ),
                        SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            text.replaceAll('\s+', '').replaceAll('\n', ' '),
                            style: GoogleFonts.montserrat(
                                color: theme.textColor,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
