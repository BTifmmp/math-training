import 'package:flutter/material.dart';

Future<dynamic> showInfoModal(BuildContext context) {
  final dividerColor =
      Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.15);
  return showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    context: context,
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView(
          children: [
            const InfoModalCategory(text: 'PRIVACY'),
            InfoModalButton(
              text: 'Privacy Policy',
              onTap: () {},
            ),
            Divider(color: dividerColor),
            const InfoModalCategory(text: 'FEEDBACK'),
            InfoModalButton(
              text: 'Rate This App',
              onTap: () {},
            ),
            const InfoModalRow(text1: 'E-mail', text2: 'mymail@comapny.com'),
            Divider(color: dividerColor),
            const InfoModalCategory(text: 'ABOUT'),
            const InfoModalRow(text1: 'App Version', text2: '1.0.0'),
            const InfoModalRow(text1: 'Build', text2: '1'),
            const SizedBox(height: 50),
          ],
        ),
      );
    },
  );
}

class InfoModalRow extends StatelessWidget {
  final String text1;
  final String text2;
  const InfoModalRow({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
          ),
          Flexible(
            child: Text(
              text2,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoModalButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;
  const InfoModalButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.02),
      splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.06),
      splashFactory: InkRipple.splashFactory,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}

class InfoModalCategory extends StatelessWidget {
  final String text;
  const InfoModalCategory({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color:
              Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.8),
        ),
      ),
    );
  }
}
