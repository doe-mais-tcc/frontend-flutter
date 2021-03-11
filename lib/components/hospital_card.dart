import 'package:doe_mais/models/hospital.dart';
import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  final Hospital hospital;
  HospitalCard(this.hospital);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 150,
              color: Colors.grey,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 25),
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hospital.name,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 8),
                    Text(
                      hospital.location,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 8),
                    Text(
                      hospital.phone,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
