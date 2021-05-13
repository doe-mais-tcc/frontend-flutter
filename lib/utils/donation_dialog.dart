import 'package:doe_mais/models/doacao.dart';
import 'package:doe_mais/screens/form_pages/donation_step1.dart';
import 'package:flutter/material.dart';

Future<Doacao> donationDialog(BuildContext context, [Doacao doacao]) async {
  return await showDialog(
    context: context,
    useSafeArea: true,
    useRootNavigator: false,
    barrierColor: Colors.black.withAlpha(180),
    builder: (context) => SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Dialog(
            insetPadding: const EdgeInsets.all(20),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: DonationStep1(
                    editDoacao: doacao,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
