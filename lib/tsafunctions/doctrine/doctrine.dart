import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class BeliefStatement extends StatelessWidget {
  final String htmlContent = '''
<div style=" line-height:1.5; ">
<h3 style="text-align:center;">Doctrines of Salvation Army</h3>
  <ol>
    <li>We Believe that the Scriptures of the Old and New Testaments were given by the inspiration of God and that they only constitute the Divine rule of Christian faith and practice.</li>
    <li>We Believe that there is only one God, who is infinitely perfect, the Creator, Preserver, and Governor of all things, and who is the only proper object of religious worship.</li>
    <li>We Believe that there are three persons in the Godhead - the Father, the Son, and the Holy Ghost, undivided in essence and co-equal in power and glory.</li>
    <li>We Believe that in the person of Jesus Christ the Divine and human natures are united so that He is truly and properly God and truly and properly man.</li>
    <li>We Believe that our first parents were created in a state of innocency, but by their disobedience, they lost their purity and happiness, and that in consequence of their fall, all men have become sinners, totally depraved, and as such are justly exposed to the wrath of God.</li>
    <li>We Believe that the Lord Jesus Christ has by His suffering and death made an atonement for the whole world so that whosoever will may be saved.</li>
    <li>We Believe that repentance toward God, faith in our Lord Jesus Christ, and regeneration by the Holy Spirit are necessary for salvation.</li>
    <li>We Believe that we are justified by grace through faith in our Lord Jesus Christ and that he that believeth that the witness in himself.</li>
    <li>We Believe that continuance in a state of salvation depends upon continued obedient faith in Christ.</li>
    <li>We Believe that it is the privilege of all believers to be wholly sanctified and that their whole spirit soul and body may be preserved blameless unto the coming of our Lord Jesus Christ.</li>
    <li>We Believe in the immortality of the soul, the resurrection of the body, the general judgment at the end of the world, the eternal happiness of the righteous, and the endless punishment of the wicked.</li>
  </ol>
</div>
  ''';

  @override
  Widget build(BuildContext context) {
    final CupertinoThemeData themeData = CupertinoTheme.of(context);
    final Color backgroundColor = themeData.barBackgroundColor;
    final Color textColor = themeData.textTheme.navTitleTextStyle.color!;

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Belief Statement',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'InterTight',
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
          child: Icon(
            CupertinoIcons.back,
            color: CupertinoColors.activeBlue,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: HtmlWidget(
              htmlContent,
              textStyle: TextStyle(
                color: textColor,
                fontSize: 18,
                fontFamily: 'PTSerif-Regular'// Adjusted font size for better readability
              ),
            ),
          ),
        ),
      ),
    );
  }
}
