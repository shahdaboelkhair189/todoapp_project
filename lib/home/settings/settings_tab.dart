import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_project/appcolors.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:todoapp_project/home/settings/theme_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp_project/provider/app_config_provider.dart';
import 'language_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  //lw 7wlna le statfull y2dr ya acess el context mn 2y mkan
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var provider =
        Provider.of<AppConfigProvider>(context); //create obj mn provider
    return Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: height * 0.02),
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Appcolors.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(color: Appcolors.primaryColor, width: 2)),
                child: InkWell(
                  //bt3ml click
                  onTap: () {
                    //function 7ttnfz lma nd8t 3la zorar
                    showLanguageBottomSheet(); //7n3ml create lel method
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.appLanguage == 'en'
                            ? AppLocalizations.of(context)!.english
                            : AppLocalizations.of(context)!.arabic,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                )),
            SizedBox(height: height * 0.03),
            Text(
              AppLocalizations.of(context)!.mode,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: height * 0.02),
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Appcolors.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(color: Appcolors.primaryColor, width: 2)),
                child: InkWell(
                  onTap: () {
                    showThemeBottomSheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.isDarkMode()
                            ? AppLocalizations.of(context)!.dark
                            : AppLocalizations.of(context)!.light,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ))
          ],
        ));
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeBottomSheet());
  }
}
