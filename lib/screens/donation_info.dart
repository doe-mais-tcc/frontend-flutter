import 'dart:convert';
import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/components/info_card.dart';
import 'package:doe_mais/models/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonationInfo extends StatelessWidget {
  Future<List<Info>> getInfo() async {
    String jsonString =
        await rootBundle.loadString('assets/files/donation_info.json');
    return (jsonDecode(jsonString) as List)
        .map((e) => Info.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: Container(
        child: FutureBuilder<List<Info>>(
          future: getInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => InfoCard(snapshot.data[index]),
              );

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
