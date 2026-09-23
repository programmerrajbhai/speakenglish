import '../../models/speaking_rule_model.dart';
import 'speaking_rule_factory.dart';

class SpeakingRules46To50 {
  SpeakingRules46To50._();

  static final List<SpeakingRule> rules = <SpeakingRule>[
    _rule46, _rule47, _rule48, _rule49, _rule50,
  ];

  static final SpeakingRule _rule46 = SpeakingRuleFactory.create(
    id: 46,
    title: 'Past Continuous',
    explanation:
    'অতীতের নির্দিষ্ট সময়ে চলমান কাজ বলতে was বা were-এর পরে verb+ing ব্যবহার হয়।',
    formula: 'Subject + was/were + verb-ing',
    example: 'I was working. They were playing.',
    optionBuilder: _pastContinuousOptions,
    hintBuilder: (_) => 'I, He, She, It-এর সঙ্গে was; You, We, They-এর সঙ্গে were এবং verb+ing ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I was working at ten.', 'আমি দশটায় কাজ করছিলাম।'),
      SpeakingSeed('They were playing football.', 'তারা football খেলছিল।'),
      SpeakingSeed('She was cooking dinner.', 'সে রাতের খাবার রান্না করছিল।'),
      SpeakingSeed('We were studying together.', 'আমরা একসঙ্গে পড়ছিলাম।'),
      SpeakingSeed('He was talking on the phone.', 'সে phone-এ কথা বলছিল।'),
      SpeakingSeed('You were sleeping then.', 'তুমি তখন ঘুমাচ্ছিলে।'),
      SpeakingSeed('It was raining last night.', 'গত রাতে বৃষ্টি হচ্ছিল।'),
      SpeakingSeed('The children were making noise.', 'শিশুরা শব্দ করছিল।'),
      SpeakingSeed('I was waiting for the bus.', 'আমি bus-এর জন্য অপেক্ষা করছিলাম।'),
      SpeakingSeed('My mother was watching television.', 'আমার মা television দেখছিলেন।'),
      SpeakingSeed('We were having lunch.', 'আমরা দুপুরের খাবার খাচ্ছিলাম।'),
      SpeakingSeed('She was writing an email.', 'সে একটি email লিখছিল।'),
      SpeakingSeed('They were traveling to Dhaka.', 'তারা ঢাকা যাচ্ছিল।'),
      SpeakingSeed('The baby was crying.', 'শিশুটি কাঁদছিল।'),
      SpeakingSeed('I was practicing English.', 'আমি English practice করছিলাম।'),
      SpeakingSeed('I was working at eight.', 'তুমি আটটায় কী করছিলে?', question: 'What were you doing at eight?'),
      SpeakingSeed('They were playing in the field.', 'তারা কোথায় খেলছিল?', question: 'Where were they playing?'),
      SpeakingSeed('She was reading a book.', 'ভুল বাক্যটি ঠিক করো: She were reading a book.'),
      SpeakingSeed('I was waiting when the bus arrived.', 'Bus আসার আগের কাজ বলো।'),
      SpeakingSeed('I was working while my brother was studying.', 'গত রাতের চলমান কাজগুলো বলো।', question: 'What was everyone doing last night?'),
    ],
  );

  static final SpeakingRule _rule47 = SpeakingRuleFactory.create(
    id: 47,
    title: 'When & While',
    explanation:
    'একটি ছোট কাজ অন্য চলমান কাজের মাঝে ঘটলে when এবং একই সময়ে দুটি চলমান কাজ বোঝাতে while ব্যবহার হয়।',
    formula: 'Past continuous + when + past simple • while + past continuous',
    example: 'I was sleeping when you called.',
    optionBuilder: _whenWhileOptions,
    hintBuilder: (_) => 'ছোট ঘটনা হলে when; একই সময়ে চলমান দুটি কাজ হলে while ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I was sleeping when you called.', 'তুমি call করার সময় আমি ঘুমাচ্ছিলাম।'),
      SpeakingSeed('She was cooking while I was working.', 'আমি কাজ করার সময় সে রান্না করছিল।'),
      SpeakingSeed('We were walking when it started to rain.', 'আমরা হাঁটার সময় বৃষ্টি শুরু হয়েছিল।'),
      SpeakingSeed('He was reading while she was watching television.', 'সে পড়ছিল আর একই সময়ে সে television দেখছিল।'),
      SpeakingSeed('They were playing when the teacher arrived.', 'Teacher আসার সময় তারা খেলছিল।'),
      SpeakingSeed('I listened to music while I was driving.', 'Drive করার সময় আমি music শুনেছিলাম।'),
      SpeakingSeed('The phone rang when I was eating.', 'আমি খাওয়ার সময় phone বেজেছিল।'),
      SpeakingSeed('She smiled when she saw me.', 'আমাকে দেখে সে হেসেছিল।'),
      SpeakingSeed('We talked while we were waiting.', 'অপেক্ষার সময় আমরা কথা বলেছিলাম।'),
      SpeakingSeed('He fell while he was running.', 'দৌড়ানোর সময় সে পড়ে গিয়েছিল।'),
      SpeakingSeed('I was studying when the power went out.', 'আমি পড়ার সময় বিদ্যুৎ চলে গিয়েছিল।'),
      SpeakingSeed('My mother cooked while I cleaned the room.', 'আমি room পরিষ্কার করার সময় মা রান্না করেছিলেন।'),
      SpeakingSeed('The bus arrived when we reached the stop.', 'আমরা stop-এ পৌঁছালে bus এসেছিল।'),
      SpeakingSeed('She called me while I was working.', 'আমি কাজ করার সময় সে আমাকে call করেছিল।'),
      SpeakingSeed('It started raining while they were playing.', 'তারা খেলার সময় বৃষ্টি শুরু হয়েছিল।'),
      SpeakingSeed('I was sleeping when he called.', 'সে call করার সময় তুমি কী করছিলে?', question: 'What were you doing when he called?'),
      SpeakingSeed('I practiced English while I was waiting.', 'অপেক্ষার সময় তুমি কী করেছিলে?', question: 'What did you do while you were waiting?'),
      SpeakingSeed('I was working when she arrived.', 'ভুল বাক্যটি ঠিক করো: I worked while she was arriving.'),
      SpeakingSeed('The lights went out while I was using the computer.', 'কাজ বন্ধ হওয়ার কারণ বলো।'),
      SpeakingSeed('I was practicing when my friend called, so we spoke in English.', 'ঘটনার ধারাবাহিকতা বলো।', question: 'What happened while you were practicing?'),
    ],
  );

  static final SpeakingRule _rule48 = SpeakingRuleFactory.create(
    id: 48,
    title: 'Present Perfect Continuous',
    explanation:
    'অতীতে শুরু হয়ে এখনো চলছে এমন কাজ বোঝাতে have/has been-এর পরে verb+ing ব্যবহার হয়।',
    formula: 'Subject + have/has been + verb-ing',
    example: 'I have been studying for two hours.',
    optionBuilder: _perfectContinuousOptions,
    hintBuilder: (_) => 'have/has been-এর পরে verb+ing এবং সময়ের জন্য since/for ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I have been studying for two hours.', 'আমি দুই ঘণ্টা ধরে পড়ছি।'),
      SpeakingSeed('She has been working since morning.', 'সে সকাল থেকে কাজ করছে।'),
      SpeakingSeed('We have been waiting for the bus.', 'আমরা bus-এর জন্য অপেক্ষা করছি।'),
      SpeakingSeed('He has been learning English for a year.', 'সে এক বছর ধরে English শিখছে।'),
      SpeakingSeed('They have been living here since 2020.', 'তারা ২০২০ সাল থেকে এখানে থাকছে।'),
      SpeakingSeed('You have been practicing every day.', 'তুমি প্রতিদিন practice করে আসছ।'),
      SpeakingSeed('It has been raining since noon.', 'দুপুর থেকে বৃষ্টি হচ্ছে।'),
      SpeakingSeed('I have been working on this project.', 'আমি এই project-এ কাজ করছি।'),
      SpeakingSeed('My brother has been looking for a job.', 'আমার ভাই job খুঁজছে।'),
      SpeakingSeed('We have been talking for an hour.', 'আমরা এক ঘণ্টা ধরে কথা বলছি।'),
      SpeakingSeed('She has been feeling sick.', 'সে অসুস্থ বোধ করছে।'),
      SpeakingSeed('The children have been playing outside.', 'শিশুরা বাইরে খেলছে।'),
      SpeakingSeed('I have been using this app for a month.', 'আমি এক মাস ধরে এই app ব্যবহার করছি।'),
      SpeakingSeed('He has been driving since dawn.', 'সে ভোর থেকে drive করছে।'),
      SpeakingSeed('They have been building the house.', 'তারা বাড়িটি তৈরি করছে।'),
      SpeakingSeed('I have been learning English for one year.', 'কতদিন ধরে English শিখছ?', question: 'How long have you been learning English?'),
      SpeakingSeed('She has been working since morning.', 'সে কখন থেকে কাজ করছে?', question: 'Since when has she been working?'),
      SpeakingSeed('He has been studying for two hours.', 'ভুল বাক্যটি ঠিক করো: He have been study for two hours.'),
      SpeakingSeed('I have been waiting for thirty minutes.', 'Service desk-এ অপেক্ষার সময় বলো।'),
      SpeakingSeed('I have been practicing daily, so my speaking has been improving.', 'নিজের চলমান progress বলো।', question: 'How has your English been improving?'),
    ],
  );

  static final SpeakingRule _rule49 = SpeakingRuleFactory.create(
    id: 49,
    title: 'Basic Passive Voice',
    explanation:
    'কাজটি কে করেছে তার চেয়ে কাজ বা object গুরুত্বপূর্ণ হলে be verb-এর পরে past participle দিয়ে Passive Voice তৈরি হয়।',
    formula: 'Subject + am/is/are/was/were + past participle',
    example: 'English is spoken worldwide.',
    optionBuilder: _passiveOptions,
    hintBuilder: (_) => 'Subject-এর পরে সঠিক be verb এবং verb-এর past participle ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('English is spoken worldwide.', 'বিশ্বজুড়ে English বলা হয়।'),
      SpeakingSeed('The room is cleaned every day.', 'Room-টি প্রতিদিন পরিষ্কার করা হয়।'),
      SpeakingSeed('The food is prepared here.', 'খাবার এখানে তৈরি করা হয়।'),
      SpeakingSeed('These phones are made in China.', 'এই phone-গুলো China-তে তৈরি।'),
      SpeakingSeed('The door is locked at night.', 'রাতে দরজা lock করা হয়।'),
      SpeakingSeed('The message was sent yesterday.', 'Message-টি গতকাল পাঠানো হয়েছিল।'),
      SpeakingSeed('The tickets were booked online.', 'Ticket-গুলো online book করা হয়েছিল।'),
      SpeakingSeed('Rice is grown in Bangladesh.', 'Bangladesh-এ ধান চাষ করা হয়।'),
      SpeakingSeed('The class is taught in English.', 'Class-টি English-এ পড়ানো হয়।'),
      SpeakingSeed('The road was closed.', 'রাস্তাটি বন্ধ করা হয়েছিল।'),
      SpeakingSeed('The bill is paid at the counter.', 'Bill counter-এ দেওয়া হয়।'),
      SpeakingSeed('The project was completed on time.', 'Project-টি সময়মতো শেষ করা হয়েছিল।'),
      SpeakingSeed('The rooms are checked every morning.', 'Room-গুলো প্রতিদিন সকালে check করা হয়।'),
      SpeakingSeed('The app is used by many learners.', 'App-টি অনেক learner ব্যবহার করে।'),
      SpeakingSeed('The problem was solved quickly.', 'Problem-টি দ্রুত সমাধান করা হয়েছিল।'),
      SpeakingSeed('English is spoken in many countries.', 'কোথায় English বলা হয়?', question: 'Where is English spoken?'),
      SpeakingSeed('The room is cleaned every day.', 'Room-টি কতবার পরিষ্কার করা হয়?', question: 'How often is the room cleaned?'),
      SpeakingSeed('The email was sent yesterday.', 'ভুল বাক্যটি ঠিক করো: The email was send yesterday.'),
      SpeakingSeed('The payment was completed successfully.', 'Customer-কে payment status জানাও।'),
      SpeakingSeed('The lessons are explained simply, and the practices are checked automatically.', 'App-এ কীভাবে শেখানো হয় বলো।', question: 'How does the app teach learners?'),
    ],
  );

  static final SpeakingRule _rule50 = SpeakingRuleFactory.create(
    id: 50,
    title: 'Basic Reported Speech',
    explanation:
    'কারও বলা কথা নিজের ভাষায় জানাতে said that বা told me that ব্যবহার হয়। Report করার সময় pronoun ও tense প্রয়োজন অনুযায়ী বদলায়।',
    formula: 'Subject + said/told me + that + reported sentence',
    example: 'She said that she was busy.',
    optionBuilder: _reportedOptions,
    hintBuilder: (_) => 'said-এর পরে ব্যক্তি সরাসরি বসে না; told-এর পরে object ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('She said that she was busy.', 'সে বলেছিল যে সে ব্যস্ত ছিল।'),
      SpeakingSeed('He told me that he was tired.', 'সে আমাকে বলেছিল যে সে ক্লান্ত ছিল।'),
      SpeakingSeed('They said that they were ready.', 'তারা বলেছিল যে তারা প্রস্তুত ছিল।'),
      SpeakingSeed('My teacher said that English was important.', 'আমার teacher বলেছিলেন যে English গুরুত্বপূর্ণ।'),
      SpeakingSeed('She told me that she needed help.', 'সে আমাকে বলেছিল যে তার সাহায্য প্রয়োজন।'),
      SpeakingSeed('He said that he would call later.', 'সে বলেছিল যে পরে call করবে।'),
      SpeakingSeed('They told us that the shop was closed.', 'তারা আমাদের বলেছিল যে দোকান বন্ধ ছিল।'),
      SpeakingSeed('I said that I was sorry.', 'আমি বলেছিলাম যে আমি দুঃখিত।'),
      SpeakingSeed('She said that she could speak English.', 'সে বলেছিল যে সে English বলতে পারে।'),
      SpeakingSeed('He told me that the bus was late.', 'সে আমাকে বলেছিল যে bus দেরি করেছিল।'),
      SpeakingSeed('The doctor said that I should rest.', 'Doctor বলেছিলেন যে আমার বিশ্রাম নেওয়া উচিত।'),
      SpeakingSeed('My friend said that he had finished.', 'আমার বন্ধু বলেছিল যে সে শেষ করেছে।'),
      SpeakingSeed('She told me that she lived in Dhaka.', 'সে আমাকে বলেছিল যে সে ঢাকায় থাকে।'),
      SpeakingSeed('They said that they would help us.', 'তারা বলেছিল যে আমাদের সাহায্য করবে।'),
      SpeakingSeed('He said that he did not know.', 'সে বলেছিল যে সে জানে না।'),
      SpeakingSeed('She said that she was learning English.', 'সে কী বলেছিল?', question: 'What did she say?'),
      SpeakingSeed('He told me that he would come.', 'সে তোমাকে কী বলেছিল?', question: 'What did he tell you?'),
      SpeakingSeed('She told me that she was busy.', 'ভুল বাক্যটি ঠিক করো: She told that she was busy.'),
      SpeakingSeed('The manager said that the room was ready.', 'Guest-কে manager-এর message জানাও।'),
      SpeakingSeed('My teacher said that practice was important, so I practiced every day.', 'Teacher-এর advice এবং নিজের action বলো।', question: 'What did your teacher say?'),
    ],
  );

  static List<String> _pastContinuousOptions(int id, String correct) {
    final wrongOne = correct.contains(' was ')
        ? correct.replaceFirst(' was ', ' were ')
        : correct.replaceFirst(' were ', ' was ');
    final wrongTwo = correct.replaceFirst(RegExp(r'\b(was|were)\b'), 'did');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _whenWhileOptions(int id, String correct) {
    final wrongOne = correct.contains(' when ')
        ? correct.replaceFirst(' when ', ' while ')
        : correct.replaceFirst(' while ', ' when ');
    final wrongTwo = correct.replaceFirst(RegExp(r'\b(when|while)\b'), 'because');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _perfectContinuousOptions(int id, String correct) {
    final wrongOne = correct.contains(' has been ')
        ? correct.replaceFirst(' has been ', ' have been ')
        : correct.replaceFirst(' have been ', ' has been ');
    final wrongTwo = correct.replaceFirst(RegExp(r'\b(has|have) been\b'), 'is');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _passiveOptions(int id, String correct) {
    final wrongOne = correct
        .replaceFirst(' is ', ' does ')
        .replaceFirst(' are ', ' do ')
        .replaceFirst(' was ', ' did ')
        .replaceFirst(' were ', ' did ');
    final wrongTwo = 'Does $correct';
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _reportedOptions(int id, String correct) {
    final wrongOne = correct.contains(' told me ')
        ? correct.replaceFirst(' told me ', ' said me ')
        : correct.replaceFirst(' said that ', ' told that ');
    final wrongTwo = correct.replaceFirst(' that ', ' to ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _options(int id, String correct, String wrongOne, String wrongTwo) {
    return SpeakingRuleFactory.arrangeOptions(
      practiceId: id,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }
}
