import 'package:balagi_bhjans/constants/text.dart';
import 'package:balagi_bhjans/widgets/popups.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DropDown extends StatelessWidget {
  DropDown({
    super.key,
  });
  //! Sub menu items
  List<String> menuItems = [
    'Share',
    'MoreApps',
    'Rate Us',
    'About Us',
    'Privacy Policy',
    'Terms & Conditions',
    'Disclaimer'
  ];

  void _handleMenuSelection(String value, BuildContext context) async {
    // !change this with google account details
    const String packageName = "com.example.yourapp";
    const String developerId = "6766189598171769553";
    switch (value) {
      case 'Share':
        final String shareLink =
            "https://play.google.com/store/apps/details?id=$packageName";
        await Share.share("Checkout the amazing app: $shareLink");
        break;
      case 'MoreApps':
        final String moreAppsLink =
            "https://play.google.com/store/apps/developer?id=$developerId";
        if (await canLaunchUrl(Uri.parse(moreAppsLink))) {
          await launchUrl(Uri.parse(moreAppsLink),
              mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Could not open  Play Store")),
          );
        }
        break;
      case 'Rate Us':
        final String rateUsLink =
            "https://play.google.com/store/apps/details?id=$packageName";
        if (await canLaunchUrl(Uri.parse(rateUsLink))) {
          await launchUrl(Uri.parse(rateUsLink),
              mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could Not Open PlayStore')));
        }
        break;
      case 'About Us':
        customPopup(context, 'About Us', PTexts.aboutUs);
        break;
      case 'Privacy Policy':
        customPopup(context, 'Privacy Policy', PTexts.privacyPolicy);

        break;
      case 'Terms & Conditions':
        customPopup(context, 'Terms & Conditions', PTexts.termAndConditions);

        break;
      case 'Disclaimer':
        customPopup(context, 'Disclamier', PTexts.disclamer);

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: (value) => _handleMenuSelection(value, context),
      itemBuilder: (BuildContext context) => menuItems
          .map(
            (item) => PopupMenuItem(
              value: item,
              child: SizedBox(
                width: 172.sp,
                child: Text(
                  item,
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
