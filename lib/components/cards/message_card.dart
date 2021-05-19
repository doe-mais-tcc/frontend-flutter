import 'package:doe_mais/components/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final Map<String, dynamic> json;
  MessageCard(this.json);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              json['asset'] != null
                  ? Image.asset(json['asset'], width: 70)
                  : SizedBox(),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 300),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: RichText(
                          softWrap: true,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          text: TextSpan(children: [
                            TextSpan(
                              text: '${json['title']}\n',
                              style: theme.textTheme.headline1,
                            ),
                            TextSpan(
                              text: '${json['message']}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ]),
                        ),
                      ),
                      json['button'] != null
                          ? Flexible(
                              child: Container(
                                padding: const EdgeInsets.only(top: 10),
                                height: 50,
                                width: 300,
                                child: CustomElevatedButton(
                                  label: json['button'],
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed('${json['route']}'),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
