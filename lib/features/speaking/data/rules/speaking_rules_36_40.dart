import '../../models/speaking_rule_model.dart';
import 'speaking_rule_factory.dart';

class SpeakingRules36To40 {
  SpeakingRules36To40._();

  static final List<SpeakingRule> rules = <SpeakingRule>[
    _rule36, _rule37, _rule38, _rule39, _rule40,
  ];

  static final SpeakingRule _rule36 = SpeakingRuleFactory.create(
    id: 36,
    title: 'Present Perfect',
    explanation:
    'অতীতে ঘটে যাওয়া কিন্তু বর্তমানের সঙ্গে সম্পর্ক আছে এমন কাজ বলতে Present Perfect ব্যবহার হয়। I, You, We, They-এর সঙ্গে have এবং He, She, It-এর সঙ্গে has বসে।',
    formula: 'Subject + have/has + past participle',
    example: 'I have finished. She has arrived.',
    optionBuilder: _presentPerfectOptions,
    hintBuilder: (_) => 'Subject অনুযায়ী have/has-এর পরে verb-এর past participle ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I have finished my work.', 'আমি আমার কাজ শেষ করেছি।'),
      SpeakingSeed('She has arrived at the office.', 'সে office-এ পৌঁছেছে।'),
      SpeakingSeed('We have learned a new rule.', 'আমরা একটি নতুন rule শিখেছি।'),
      SpeakingSeed('He has bought a new phone.', 'সে একটি নতুন phone কিনেছে।'),
      SpeakingSeed('They have visited Dhaka.', 'তারা ঢাকা ভ্রমণ করেছে।'),
      SpeakingSeed('You have improved a lot.', 'তুমি অনেক উন্নতি করেছ।'),
      SpeakingSeed('I have lost my keys.', 'আমি আমার চাবি হারিয়েছি।'),
      SpeakingSeed('My mother has cooked dinner.', 'আমার মা রাতের খাবার রান্না করেছেন।'),
      SpeakingSeed('The bus has left.', 'বাসটি চলে গেছে।'),
      SpeakingSeed('We have completed the project.', 'আমরা project-টি শেষ করেছি।'),
      SpeakingSeed('She has written an email.', 'সে একটি email লিখেছে।'),
      SpeakingSeed('I have seen this movie.', 'আমি এই movie দেখেছি।'),
      SpeakingSeed('He has forgotten the password.', 'সে password ভুলে গেছে।'),
      SpeakingSeed('They have changed the plan.', 'তারা plan পরিবর্তন করেছে।'),
      SpeakingSeed('The class has started.', 'Class শুরু হয়েছে।'),
      SpeakingSeed('I have practiced English today.', 'তুমি আজ কী practice করেছ?', question: 'What have you practiced today?'),
      SpeakingSeed('Yes, she has finished her work.', 'সে কি কাজ শেষ করেছে?', question: 'Has she finished her work?'),
      SpeakingSeed('He has gone home.', 'ভুল বাক্যটি ঠিক করো: He have went home.'),
      SpeakingSeed('I have lost my ticket.', 'Station-এ নিজের সমস্যা বলো।'),
      SpeakingSeed('I have learned many rules and improved my speaking.', 'এখন পর্যন্ত কী শিখেছ বলো।', question: 'What have you learned so far?'),
    ],
  );

  static final SpeakingRule _rule37 = SpeakingRuleFactory.create(
    id: 37,
    title: 'Since & For',
    explanation:
    'কাজ কখন শুরু হয়েছে তার নির্দিষ্ট সময়ের আগে since এবং কত সময় ধরে চলছে তার duration-এর আগে for ব্যবহার হয়।',
    formula: 'since + starting point • for + duration',
    example: 'I have lived here since 2020. I have lived here for five years.',
    optionBuilder: _sinceForOptions,
    hintBuilder: (_) => 'Starting point হলে since, duration হলে for ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I have lived here since 2020.', 'আমি ২০২০ সাল থেকে এখানে থাকি।'),
      SpeakingSeed('I have lived here for five years.', 'আমি পাঁচ বছর ধরে এখানে থাকি।'),
      SpeakingSeed('She has worked here since Monday.', 'সে Monday থেকে এখানে কাজ করছে।'),
      SpeakingSeed('We have waited for two hours.', 'আমরা দুই ঘণ্টা ধরে অপেক্ষা করছি।'),
      SpeakingSeed('He has studied English since January.', 'সে January থেকে English পড়ছে।'),
      SpeakingSeed('They have known each other for ten years.', 'তারা দশ বছর ধরে একে অন্যকে চেনে।'),
      SpeakingSeed('I have been busy since morning.', 'আমি সকাল থেকে ব্যস্ত।'),
      SpeakingSeed('She has been sick for three days.', 'সে তিন দিন ধরে অসুস্থ।'),
      SpeakingSeed('We have used this app since last week.', 'আমরা গত সপ্তাহ থেকে এই app ব্যবহার করছি।'),
      SpeakingSeed('He has stayed there for a month.', 'সে সেখানে এক মাস ধরে আছে।'),
      SpeakingSeed('It has rained since noon.', 'দুপুর থেকে বৃষ্টি হচ্ছে।'),
      SpeakingSeed('I have practiced for thirty minutes.', 'আমি ত্রিশ মিনিট ধরে practice করেছি।'),
      SpeakingSeed('The shop has been closed since Friday.', 'দোকানটি Friday থেকে বন্ধ।'),
      SpeakingSeed('My family has lived here for many years.', 'আমার পরিবার বহু বছর ধরে এখানে থাকে।'),
      SpeakingSeed('She has taught here since 2022.', 'সে ২০২২ সাল থেকে এখানে পড়ায়।'),
      SpeakingSeed('I have studied English for one year.', 'তুমি কতদিন ধরে English পড়ছ?', question: 'How long have you studied English?'),
      SpeakingSeed('He has worked here since June.', 'সে কখন থেকে এখানে কাজ করছে?', question: 'Since when has he worked here?'),
      SpeakingSeed('I have waited for two hours.', 'ভুল বাক্যটি ঠিক করো: I have waited since two hours.'),
      SpeakingSeed('I have been waiting for twenty minutes.', 'অপেক্ষার সময় সম্পর্কে staff-কে বলো।'),
      SpeakingSeed('I have learned English for a year and practiced daily since January.', 'English শেখার সময় সম্পর্কে বলো।', question: 'How long have you been learning English?'),
    ],
  );

  static final SpeakingRule _rule38 = SpeakingRuleFactory.create(
    id: 38,
    title: 'Ever & Never',
    explanation:
    'জীবনে কখনো কোনো অভিজ্ঞতা হয়েছে কি না জিজ্ঞাসা করতে ever এবং কখনো হয়নি বলতে never ব্যবহার হয়।',
    formula: 'Have/Has + subject + ever...? • Subject + have/has never...',
    example: 'Have you ever traveled abroad? I have never traveled abroad.',
    optionBuilder: _everNeverOptions,
    hintBuilder: (_) => 'Question-এ ever এবং negative experience-এ never ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('Have you ever visited Dhaka?', 'তুমি কি কখনো ঢাকা ভ্রমণ করেছ?'),
      SpeakingSeed('I have never traveled abroad.', 'আমি কখনো বিদেশ ভ্রমণ করিনি।'),
      SpeakingSeed('Has she ever tried this food?', 'সে কি কখনো এই খাবার চেষ্টা করেছে?'),
      SpeakingSeed('He has never driven a car.', 'সে কখনো গাড়ি চালায়নি।'),
      SpeakingSeed('Have they ever met you?', 'তারা কি কখনো তোমার সঙ্গে দেখা করেছে?'),
      SpeakingSeed('We have never seen this place.', 'আমরা কখনো এই জায়গা দেখিনি।'),
      SpeakingSeed('Have you ever spoken to a foreigner?', 'তুমি কি কখনো বিদেশির সঙ্গে কথা বলেছ?'),
      SpeakingSeed('I have never eaten sushi.', 'আমি কখনো sushi খাইনি।'),
      SpeakingSeed('Has he ever worked online?', 'সে কি কখনো online কাজ করেছে?'),
      SpeakingSeed('She has never missed a class.', 'সে কখনো class miss করেনি।'),
      SpeakingSeed('Have you ever used this app?', 'তুমি কি কখনো এই app ব্যবহার করেছ?'),
      SpeakingSeed('I have never forgotten your name.', 'আমি কখনো তোমার নাম ভুলিনি।'),
      SpeakingSeed('Has it ever happened before?', 'এটি কি আগে কখনো ঘটেছে?'),
      SpeakingSeed('They have never been late.', 'তারা কখনো দেরি করেনি।'),
      SpeakingSeed('Have we ever discussed this topic?', 'আমরা কি কখনো এই topic আলোচনা করেছি?'),
      SpeakingSeed('Yes, I have visited Dhaka.', 'তুমি কি কখনো ঢাকা গিয়েছ?', question: 'Have you ever visited Dhaka?'),
      SpeakingSeed('No, I have never traveled abroad.', 'তুমি কি কখনো বিদেশ গিয়েছ?', question: 'Have you ever traveled abroad?'),
      SpeakingSeed('I have never seen it.', 'ভুল বাক্যটি ঠিক করো: I have ever not seen it.'),
      SpeakingSeed('Have you ever stayed at this hotel?', 'Hotel guest-এর আগের অভিজ্ঞতা জিজ্ঞাসা করো।'),
      SpeakingSeed('I have never spoken abroad, but I have spoken to foreign clients.', 'নিজের speaking experience বলো।', question: 'Have you ever spoken English with foreigners?'),
    ],
  );

  static final SpeakingRule _rule39 = SpeakingRuleFactory.create(
    id: 39,
    title: 'Already & Yet',
    explanation:
    'প্রত্যাশার আগেই কাজ শেষ হয়েছে বোঝাতে already এবং প্রশ্ন বা negative বাক্যে এখনো পর্যন্ত বোঝাতে yet ব্যবহার হয়।',
    formula: 'have/has already + V3 • have/has not + V3 + yet',
    example: 'I have already eaten. I have not eaten yet.',
    optionBuilder: _alreadyYetOptions,
    hintBuilder: (_) => 'Positive completed action-এ already; question/negative-এর শেষে yet ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I have already finished my work.', 'আমি ইতোমধ্যে কাজ শেষ করেছি।'),
      SpeakingSeed('I have not eaten yet.', 'আমি এখনো খাইনি।'),
      SpeakingSeed('She has already arrived.', 'সে ইতোমধ্যে পৌঁছেছে।'),
      SpeakingSeed('Has he called you yet?', 'সে কি এখনো তোমাকে phone করেছে?'),
      SpeakingSeed('We have already booked the tickets.', 'আমরা ইতোমধ্যে ticket book করেছি।'),
      SpeakingSeed('They have not started yet.', 'তারা এখনো শুরু করেনি।'),
      SpeakingSeed('I have already seen this movie.', 'আমি ইতোমধ্যে এই movie দেখেছি।'),
      SpeakingSeed('Have you completed the lesson yet?', 'তুমি কি lesson-টি এখনো শেষ করেছ?'),
      SpeakingSeed('My brother has already left.', 'আমার ভাই ইতোমধ্যে চলে গেছে।'),
      SpeakingSeed('The bus has not arrived yet.', 'Bus এখনো আসেনি।'),
      SpeakingSeed('She has already sent the email.', 'সে ইতোমধ্যে email পাঠিয়েছে।'),
      SpeakingSeed('I have not decided yet.', 'আমি এখনো সিদ্ধান্ত নিইনি।'),
      SpeakingSeed('We have already discussed this.', 'আমরা ইতোমধ্যে এটি আলোচনা করেছি।'),
      SpeakingSeed('Has the class started yet?', 'Class কি এখনো শুরু হয়েছে?'),
      SpeakingSeed('He has already paid the bill.', 'সে ইতোমধ্যে bill দিয়েছে।'),
      SpeakingSeed('Yes, I have already finished it.', 'তুমি কি কাজটি শেষ করেছ?', question: 'Have you finished the work yet?'),
      SpeakingSeed('No, the bus has not arrived yet.', 'Bus কি এসেছে?', question: 'Has the bus arrived yet?'),
      SpeakingSeed('I have not finished yet.', 'ভুল বাক্যটি ঠিক করো: I have not yet finished yet.'),
      SpeakingSeed('I have already made a reservation.', 'Hotel reception-এ booking সম্পর্কে বলো।'),
      SpeakingSeed('I have already learned the rules, but I have not mastered speaking yet.', 'নিজের learning progress বলো।', question: 'What have you completed, and what is left?'),
    ],
  );

  static final SpeakingRule _rule40 = SpeakingRuleFactory.create(
    id: 40,
    title: 'Used To',
    explanation:
    'অতীতে নিয়মিত ছিল কিন্তু এখন আর নেই এমন অভ্যাস বা অবস্থা বোঝাতে used to ব্যবহার হয়।',
    formula: 'Subject + used to + base verb',
    example: 'I used to play football.',
    optionBuilder: _usedToOptions,
    hintBuilder: (_) => 'used to-এর পরে verb-এর base form ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I used to play football.', 'আমি আগে football খেলতাম।'),
      SpeakingSeed('She used to live in Dhaka.', 'সে আগে ঢাকায় থাকত।'),
      SpeakingSeed('We used to study together.', 'আমরা আগে একসঙ্গে পড়তাম।'),
      SpeakingSeed('He used to work here.', 'সে আগে এখানে কাজ করত।'),
      SpeakingSeed('They used to visit us often.', 'তারা আগে প্রায়ই আমাদের দেখতে আসত।'),
      SpeakingSeed('I used to wake up late.', 'আমি আগে দেরিতে ঘুম থেকে উঠতাম।'),
      SpeakingSeed('My father used to drive a bus.', 'আমার বাবা আগে bus চালাতেন।'),
      SpeakingSeed('She used to be shy.', 'সে আগে লাজুক ছিল।'),
      SpeakingSeed('We used to watch television every night.', 'আমরা আগে প্রতি রাতে television দেখতাম।'),
      SpeakingSeed('He used to smoke.', 'সে আগে ধূমপান করত।'),
      SpeakingSeed('I did not use to speak English.', 'আমি আগে English বলতাম না।'),
      SpeakingSeed('Did you use to live here?', 'তুমি কি আগে এখানে থাকতে?'),
      SpeakingSeed('There used to be a shop here.', 'এখানে আগে একটি দোকান ছিল।'),
      SpeakingSeed('She used to walk to school.', 'সে আগে হেঁটে school-এ যেত।'),
      SpeakingSeed('I used to fear making mistakes.', 'আমি আগে ভুল করতে ভয় পেতাম।'),
      SpeakingSeed('I used to play cricket.', 'তুমি আগে কী খেলতে?', question: 'What did you use to play?'),
      SpeakingSeed('Yes, I used to live there.', 'তুমি কি আগে সেখানে থাকতে?', question: 'Did you use to live there?'),
      SpeakingSeed('He used to work here.', 'ভুল বাক্যটি ঠিক করো: He used to worked here.'),
      SpeakingSeed('I used to drink tea, but now I drink coffee.', 'আগের ও বর্তমান পছন্দ বলো।'),
      SpeakingSeed('I used to avoid English, but now I practice it every day.', 'নিজের পুরোনো ও বর্তমান learning habit বলো।', question: 'How have your English habits changed?'),
    ],
  );

  static List<String> _presentPerfectOptions(int id, String correct) {
    final wrongOne = correct.contains(' has ')
        ? correct.replaceFirst(' has ', ' have ')
        : correct.replaceFirst(' have ', ' has ');
    final wrongTwo = correct.replaceFirst(RegExp(r'\b(has|have)\b'), 'did');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _sinceForOptions(int id, String correct) {
    final wrongOne = correct.contains(' since ')
        ? correct.replaceFirst(' since ', ' for ')
        : correct.replaceFirst(' for ', ' since ');
    final wrongTwo = correct.replaceFirst(RegExp(r'\b(since|for)\b'), 'from');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _everNeverOptions(int id, String correct) {
    final wrongOne = correct.contains(' ever ')
        ? correct.replaceFirst(' ever ', ' never ')
        : correct.replaceFirst(' never ', ' ever ');
    final wrongTwo = correct.replaceFirst(RegExp(r'\b(ever|never)\b'), 'always');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _alreadyYetOptions(int id, String correct) {
    final wrongOne = correct.contains(' already ')
        ? correct.replaceFirst(' already ', ' yet ')
        : correct.replaceFirst(' yet', ' already');
    final wrongTwo = correct.replaceFirst(RegExp(r'\b(already|yet)\b'), 'ever');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _usedToOptions(int id, String correct) {
    final wrongOne = correct.replaceFirst(' used to ', ' use to ');
    final wrongTwo = correct.replaceFirst(' used to ', ' was use to ');
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
