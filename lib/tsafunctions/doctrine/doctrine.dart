import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class BeliefStatement extends StatefulWidget {
  @override
  _BeliefStatementState createState() => _BeliefStatementState();
}

class _BeliefStatementState extends State<BeliefStatement> {
  int _selectedSegment = 0;

  final String englishContent = '''
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

  final String tamilContent = '''
<div style=" line-height:1.5; ">
<h3 style="text-align:center;">விசுவாச பிரமாணம்</h3>
  <ol>
   <li>பழைய ஏற்பாடும் புதிய ஏற்பாடும் அடங்கிய வேதகமானது தேவனுடைய ஏவுதலினால் அருளப்பட்டதென்றும், கிறிஸ்தவ விசுவாசமும் கிரியையுமாகிய தெய்வீகச் சட்டம் அதில் அடங்கியிருக்கிறதென்றும் விசுவாசிக்கிறோம்.</li>
   <li>எல்லாவற்றிற்கும் சிருஷ்டிகரும் பாதுகாவலரும், ஆளுகிறவரும், சர்வபூரணருமான ஒரே தேவன் உண்டென்றும், அவர் மார்க்கீக வணக்கத்திற்குரியவரென்றும் விசுவாசிக்கிறோம்.</li>
   <li>தத்துவத்தில் பிரியாதவர்களும் வல்லமையிலும் மகிமையிலும் சமமானவர்களுமான பிதா, குமாரன், பரிசுத்தாவியானவராகிய மூவர் தேவத்துவத்தில் உண்டென்றும் விசுவாசிக்கிறோம்.</li>
   <li>கர்த்தராகிய கிறிஸ்துவில் தெய்வீகத் தன்மையும் மனிதத் தன்மையும் பொருந்தியிருக்கின்றன வென்றும், அதனால் அவர் மெய்யாகவே தேவனாகவும் மெய்யாகவே மனிதனாகவும் இருக்கிறாரென்றும் விசுவாசிக்கிறோம்.</li>
   <li>நமது ஆதிப்பெற்றோர் நிர்மலமான நிலையில் சிருஷ்டிக்கப்பட்டார்களென்றும், அனால் அவர்களுடைய கீழ்ப்படியாமையால் தங்களுடைய தூய்மையையும், பாக்கியத்தையும் இழந்தார்கள் என்றும் அதன் பலனாய் எல்ல மனிதரும் பாவிகளாயும், முற்றிலும் சீரழிந்தவர்களாயும் ஆனார்களென்றும், ஆகையால் தேவனுடைய நியாயமான கோபாக்கினைக்குள்ளானார்களென்றும் விசுவாசிக்கிறோம்.</li>
   <li>கர்த்தராகிய இயேசுகிறிஸ்து விருப்பமுள்ளவர்களேவர் யார்களோ அவர்கள் அனைவரும் இரட்சிக்கப்படும் பொருட்டு, தம்முடைய பாடு மரணத்தால் உலகம் முழுவதற்கும் வேண்டிய பிராயச்சித்தப் பலியானாரென்றும் விசுவாசிக்கிறோம்.</li>
   <li>தேவனுக்கு முன் மனஸ்தாபமும் கர்த்தராகிய இயேசு கிறிஸ்துவில் விசுவாசமும், பரிசுத்தாவியானவராலுண்டாகும் மறுபிறப்பும் இரட்சிப்புக்கு அவசியமென விசுவாசிக்கிறோம்.</li>
   <li>கர்த்தராகிய கிறிஸ்து இயேசுவிலுள்ள விசுவாசத்தின் மூலம் அவரது கிருபையினால் நீதிமான்களாக்கப்படுகிறோம் என்றும், அவரில் விசுவாசிக்கவன் தன்னிலே அந்த சாட்சியை உடையவனாய் இருக்கிறானென்றும் விசுவாசிக்கிறோம்.</li>
   <li>இரட்சிப்பில் நிலைத்திருப்பது கிறிஸ்துவில் உள்ள தொடர்பான விசுவாசத்திலும், கீழ்ப்படிதலிலும் சார்ந்திருக்கிறதென்றும் விசுவாசிக்கிறோம்.</li>
   <li>முற்றிலும் சுத்திகரிக்கப்பட்டிருத்தல், விசுவாசிகள் யாருடைய சிலாக்கியமாயிருக்கிற தென்றும், அவர்களுடைய ஆவி, ஆத்துமா, சரீரம் முழுவதும் கர்த்தராகிய இயேசுவின் வருகை மட்டும் குற்றமாட்டாதாய்க் காக்கப்படக் கூடுமென்றும் விசுவாசிக்கிறோம்.</li>
   <li>ஆத்துமாவின் அழியாமையிலும், சரீரத்தின் உயிர்தெழுதலிலும், உலக முடிவிலுண்டாகும் பொதுவான நியாயத் தீர்ப்பிலும், நீதிமான்களுடைய நித்திய ஆனந்தத்திலும், துன்மார்களுடைய நித்திய ஆக்கினையிலும் நாம் விசுவாசிக்கிறோம்.</li>
  </ol>
</div>
  ''';

  final String tanglishContent = '''
<div style=" line-height:1.5; ">
<h3 style="text-align:center;">Viswasa  Pramaanam</h3>
  <ol>
  <li>Palaya yerpadum pudhiya yerpadum adangiya vedhagamam aanadhu dhevanudiya yevudhalinal arulapattadhendrum, krishtava visuwasamum kiriyaiyumagiya dheiviga sattam adhil adangiyirukkiradhendrum visuwasikkirom.</li>
  <li>Ella vatrirkum srishtigarum, padhugavalarum, aalugiravarum, sarvapooranamanavarumana orey dhevan undendrum, avarae maarkiga vanakkathirkuriyavarendrum visuwasikkirom.</li>
  <li>Thathuvathil piriyadhavargalum, vallamaiyilum magimaiyilum samamanavargalumana pidha, kumaran, parisuthaaviyanavaragiya moovar dhevathuvathil undendrum visuwasikkirom.</li>
  <li>Kartharagiya kristhuvil dheiviga thanmaiyum manidha thanmaiyum porundhirukkindrana vendrum, adhanal avar meiyyagave dhevanagavum, meiyyagave manidhanagavum irukkirarendrum visuwasikkirom.</li>
  <li>Namadhu aadhipetror nirmalamana nilaiyil srishtikkapattargalendrum, aanal avargaludaiya keelpadiyamaiyal thangaludaiya thuyimaiyum baakiyathaiyum ilandhargal endrum adhan balanai ella manidharum paavigalaiyum, mutrilum seeralindhavargalaiyum aanargalendrum, aagaiyal dhevanudaiya nyayamana kobakkinaikkulanargalendrum visuwasikkirom.</li>
  <li>Kartharagiya yesu kristhu viruppamullavargal yevargalo avargal anaivarum ratchikkapadum poruttu, thammudaiya paadu maranathal ulagam muluva                   tharkum vendiya prayasitha baliyanarendrum visuwasikkirom.</li>
  <li>Dhevanukku munn manasthabamum kartharagiya yesu kristhuvil visuwasamum, parisutha aaviyanavaralundagum marupirappum ratchippukku avasiyamena visuwasikkirom.</li>
  <li>Kartharagiya kristhu yesuvilulla visuwasathin moolam avarudaiya kirubaiyinal needhimangal aakapadugirom endrum, avaril visuwasikkiravan thannilae andha saatchiyai udaiyavanai irukkiranendrum visuwasikkirom.</li>
  <li>Ratchippil nilaithiruppadhu kristhuvvil ulla thodarbana visuwasathilum, keelpadidhalilum saarndhirukkiradhendrum visuwasikkirom.</li>
  <li>Mutrilum suthigarikkappattiruthal, visuwasigal yaavarudaiya slakkiyamayirukkiradhendrum avargaludaiya aavi, aathuma, sareeram muluvadhum kartharagiya yesu kristhuvin varugai mattum kutramatradhai kaakappada koodumendrum visuwasikkirom.</li>
  <li>Aathumavin aliyamaiyilum, sareerathin uyirtheludhalilum, ulaga mudivilundagum podhuvana nyaya theerpilum, needhimangaludaiya nitthiya aanandhathilum, dhunmarkarudaiya nitthiya aakinaiyilum naam visuwasikkirom.</li>
  </ol>
</div>
  ''';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return CupertinoPageScaffold(
      backgroundColor: isDarkMode ? CupertinoColors.black : CupertinoColors.systemGrey5,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Belief Statement',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? CupertinoColors.lightBackgroundGray : CupertinoColors.black,
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.back,
            color: CupertinoColors.white,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoSlidingSegmentedControl<int>(
              backgroundColor: isDarkMode ? CupertinoColors.darkBackgroundGray : CupertinoColors.systemGrey2,
              groupValue: _selectedSegment,
              onValueChanged: (int? value) {
                if (value != null) {
                  setState(() {
                    _selectedSegment = value;
                  });
                }
              },
              children: const <int, Widget>{
                0: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('English'),
                ),
                1: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('தமிழ்'),
                ),
                2: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Tanglish'),
                ),
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: HtmlWidget(
                    _selectedSegment == 0
                        ? englishContent
                        : _selectedSegment == 1
                        ? tamilContent
                        : tanglishContent,
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'PTSerif-Regular', // Use PTSerif for all languages
                      color: isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
