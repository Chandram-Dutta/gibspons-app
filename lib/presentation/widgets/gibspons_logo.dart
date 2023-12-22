import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GibSponsLogoLight extends StatelessWidget {
  const GibSponsLogoLight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/gibspons-logo.png",
          height: 64,
        ),
        const Gap(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "gibspons",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const Text("sponsorships made easier")
          ],
        )
      ],
    );
  }
}

class GibSponsLogoDark extends StatelessWidget {
  const GibSponsLogoDark({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/gibspons-logo-dark.png",
          height: 64,
        ),
        const Gap(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "gibspons",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.surface,
                  ),
            ),
            Text(
              "By GDSC VIT.",
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
              ),
            )
          ],
        )
      ],
    );
  }
}
