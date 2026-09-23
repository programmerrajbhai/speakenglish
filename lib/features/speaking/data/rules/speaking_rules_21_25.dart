import '../../models/speaking_rule_model.dart';
import 'speaking_rule_factory.dart';

class SpeakingRules21To25 {
  SpeakingRules21To25._();

  static final List<SpeakingRule> rules = <SpeakingRule>[
    _rule21,
    _rule22,
    _rule23,
    _rule24,
    _rule25,
  ];

  static final SpeakingRule _rule21 = SpeakingRuleFactory.create(
    id: 21,
    title: 'Was & Were',
    explanation:
    'অতীতের অবস্থা বোঝাতে I, He, She, It-এর সঙ্গে was এবং You, We, They-এর সঙ্গে were ব্যবহার হয়।',
    formula: 'I/He/She/It + was • You/We/They + were',
    example: 'I was busy. They were happy.',
    optionBuilder: _wasWereOptions,
    hintBuilder: (_) =>
    'I, He, She, It-এর সঙ্গে was; You, We, They-এর সঙ্গে were ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I was busy yesterday.', 'আমি গতকাল ব্যস্ত ছিলাম।'),
      SpeakingSeed('They were happy.', 'তারা খুশি ছিল।'),
      SpeakingSeed('She was at home.', 'সে বাসায় ছিল।'),
      SpeakingSeed('We were tired after work.', 'কাজের পর আমরা ক্লান্ত ছিলাম।'),
      SpeakingSeed('He was my teacher.', 'সে আমার শিক্ষক ছিল।'),
      SpeakingSeed('You were very helpful.', 'তুমি অনেক সাহায্যকারী ছিলে।'),
      SpeakingSeed('It was cold last night.', 'গত রাতে ঠান্ডা ছিল।'),
      SpeakingSeed('The children were in the park.', 'শিশুরা পার্কে ছিল।'),
      SpeakingSeed('My phone was on the table.', 'আমার ফোন টেবিলের ওপর ছিল।'),
      SpeakingSeed('The shops were closed.', 'দোকানগুলো বন্ধ ছিল।'),
      SpeakingSeed('I was sick last week.', 'আমি গত সপ্তাহে অসুস্থ ছিলাম।'),
      SpeakingSeed('She was late for class.', 'সে ক্লাসে দেরি করেছিল।'),
      SpeakingSeed('We were ready to leave.', 'আমরা যাওয়ার জন্য প্রস্তুত ছিলাম।'),
      SpeakingSeed('The movie was interesting.', 'সিনেমাটি আকর্ষণীয় ছিল।'),
      SpeakingSeed('My friends were with me.', 'আমার বন্ধুরা আমার সঙ্গে ছিল।'),
      SpeakingSeed(
        'I was at work yesterday.',
        'তুমি গতকাল কোথায় ছিলে?',
        question: 'Where were you yesterday?',
      ),
      SpeakingSeed(
        'Yes, they were happy.',
        'তারা কি খুশি ছিল?',
        question: 'Were they happy?',
      ),
      SpeakingSeed('She was at home.', 'ভুল বাক্যটি ঠিক করো: She were at home.'),
      SpeakingSeed('I was busy, so I could not answer.', 'ফোন ধরতে না পারার কারণ বলো।'),
      SpeakingSeed(
        'I was tired, but my friends were energetic.',
        'গতকালের অবস্থা সম্পর্কে বলো।',
        question: 'How was everyone yesterday?',
      ),
    ],
  );

  static final SpeakingRule _rule22 = SpeakingRuleFactory.create(
    id: 22,
    title: 'Simple Past Tense',
    explanation:
    'অতীতে শেষ হয়ে যাওয়া কাজ বলতে Simple Past ব্যবহার হয়। Regular verb-এ ed যোগ হয়, আর irregular verb-এর আলাদা past form থাকে।',
    formula: 'Subject + past form of verb + object',
    example: 'I worked yesterday. She went home.',
    optionBuilder: _pastOptions,
    hintBuilder: (_) => 'অতীতের কাজের জন্য verb-এর past form ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I worked yesterday.', 'আমি গতকাল কাজ করেছি।'),
      SpeakingSeed('She went home early.', 'সে তাড়াতাড়ি বাসায় গিয়েছিল।'),
      SpeakingSeed('We watched a movie.', 'আমরা একটি সিনেমা দেখেছি।'),
      SpeakingSeed('He ate breakfast at eight.', 'সে আটটায় সকালের খাবার খেয়েছে।'),
      SpeakingSeed('They played football.', 'তারা ফুটবল খেলেছিল।'),
      SpeakingSeed('I bought a new phone.', 'আমি একটি নতুন ফোন কিনেছি।'),
      SpeakingSeed('My mother cooked dinner.', 'আমার মা রাতের খাবার রান্না করেছিলেন।'),
      SpeakingSeed('She wrote an email.', 'সে একটি ইমেইল লিখেছিল।'),
      SpeakingSeed('We visited our village.', 'আমরা আমাদের গ্রামে গিয়েছিলাম।'),
      SpeakingSeed('He called me last night.', 'সে গত রাতে আমাকে ফোন করেছিল।'),
      SpeakingSeed('I learned a new word.', 'আমি একটি নতুন শব্দ শিখেছি।'),
      SpeakingSeed('The bus arrived late.', 'বাসটি দেরিতে এসেছিল।'),
      SpeakingSeed('They helped the old man.', 'তারা বৃদ্ধ মানুষটিকে সাহায্য করেছিল।'),
      SpeakingSeed('I saw my friend at the market.', 'আমি বাজারে আমার বন্ধুকে দেখেছি।'),
      SpeakingSeed('She finished her work.', 'সে তার কাজ শেষ করেছিল।'),
      SpeakingSeed(
        'I studied English yesterday.',
        'তুমি গতকাল কী পড়েছিলে?',
        question: 'What did you study yesterday?',
      ),
      SpeakingSeed(
        'We went to the park.',
        'তোমরা কোথায় গিয়েছিলে?',
        question: 'Where did you go?',
      ),
      SpeakingSeed('He went to school.', 'ভুল বাক্যটি ঠিক করো: He goed to school.'),
      SpeakingSeed('I missed the bus this morning.', 'দেরি হওয়ার কারণ বলো।'),
      SpeakingSeed(
        'I worked in the morning and practiced English at night.',
        'গতকাল কী করেছিলে?',
        question: 'What did you do yesterday?',
      ),
    ],
  );

  static final SpeakingRule _rule23 = SpeakingRuleFactory.create(
    id: 23,
    title: 'Did Questions',
    explanation:
    'অতীতের কাজ সম্পর্কে প্রশ্ন করতে Did ব্যবহার হয়। Did-এর পরে subject এবং verb-এর base form বসে।',
    formula: 'Did + subject + base verb + ...?',
    example: 'Did you work yesterday?',
    optionBuilder: _didOptions,
    hintBuilder: (_) => 'Did-এর পরে verb-এর base form ব্যবহার করো, past form নয়।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('Did you work yesterday?', 'তুমি কি গতকাল কাজ করেছিলে?'),
      SpeakingSeed('Did she call you?', 'সে কি তোমাকে ফোন করেছিল?'),
      SpeakingSeed('Did they play football?', 'তারা কি ফুটবল খেলেছিল?'),
      SpeakingSeed('Did he eat breakfast?', 'সে কি সকালের খাবার খেয়েছিল?'),
      SpeakingSeed('Did you watch the movie?', 'তুমি কি সিনেমাটি দেখেছিলে?'),
      SpeakingSeed('Did we miss the bus?', 'আমরা কি বাসটি মিস করেছি?'),
      SpeakingSeed('Did your mother cook dinner?', 'তোমার মা কি রাতের খাবার রান্না করেছিলেন?'),
      SpeakingSeed('Did the class start on time?', 'ক্লাস কি সময়মতো শুরু হয়েছিল?'),
      SpeakingSeed('Did you understand the lesson?', 'তুমি কি পাঠটি বুঝেছিলে?'),
      SpeakingSeed('Did she buy a new bag?', 'সে কি নতুন ব্যাগ কিনেছিল?'),
      SpeakingSeed('Did he go to Dhaka?', 'সে কি ঢাকায় গিয়েছিল?'),
      SpeakingSeed('Did they help you?', 'তারা কি তোমাকে সাহায্য করেছিল?'),
      SpeakingSeed('Did you sleep well?', 'তুমি কি ভালোভাবে ঘুমিয়েছিলে?'),
      SpeakingSeed('Did the train arrive late?', 'ট্রেন কি দেরিতে এসেছিল?'),
      SpeakingSeed('Did she finish her work?', 'সে কি তার কাজ শেষ করেছিল?'),
      SpeakingSeed(
        'Yes, I worked yesterday.',
        'Did you work yesterday? প্রশ্নের উত্তর দাও।',
        question: 'Did you work yesterday?',
      ),
      SpeakingSeed(
        'No, she did not call me.',
        'Did she call you? প্রশ্নের উত্তর দাও।',
        question: 'Did she call you?',
      ),
      SpeakingSeed('Did he go to school?', 'ভুল প্রশ্নটি ঠিক করো: Did he went to school?'),
      SpeakingSeed('Did this bus stop at the station?', 'বাসের আগের গন্তব্য সম্পর্কে জিজ্ঞাসা করো।'),
      SpeakingSeed(
        'Yes, I practiced English last night.',
        'গত রাতের practice নিয়ে উত্তর দাও।',
        question: 'Did you practice English last night?',
      ),
    ],
  );

  static final SpeakingRule _rule24 = SpeakingRuleFactory.create(
    id: 24,
    title: 'Future with Will',
    explanation:
    'ভবিষ্যতের সিদ্ধান্ত, প্রতিশ্রুতি বা অনুমান বলতে will ব্যবহার হয়। will-এর পরে verb-এর base form বসে।',
    formula: 'Subject + will + base verb',
    example: 'I will call you tomorrow.',
    optionBuilder: _willOptions,
    hintBuilder: (_) => 'will-এর পরে verb-এর base form ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I will call you tomorrow.', 'আমি আগামীকাল তোমাকে ফোন করব।'),
      SpeakingSeed('She will help us.', 'সে আমাদের সাহায্য করবে।'),
      SpeakingSeed('We will learn English together.', 'আমরা একসঙ্গে ইংরেজি শিখব।'),
      SpeakingSeed('He will come later.', 'সে পরে আসবে।'),
      SpeakingSeed('They will visit Dhaka next week.', 'তারা আগামী সপ্তাহে ঢাকা যাবে।'),
      SpeakingSeed('I will finish the work today.', 'আমি আজ কাজটি শেষ করব।'),
      SpeakingSeed('You will enjoy this movie.', 'তুমি এই সিনেমাটি উপভোগ করবে।'),
      SpeakingSeed('It will rain tonight.', 'আজ রাতে বৃষ্টি হবে।'),
      SpeakingSeed('My brother will buy a laptop.', 'আমার ভাই একটি ল্যাপটপ কিনবে।'),
      SpeakingSeed('The class will start at ten.', 'ক্লাস দশটায় শুরু হবে।'),
      SpeakingSeed('I will not forget you.', 'আমি তোমাকে ভুলব না।'),
      SpeakingSeed('She will not be late.', 'সে দেরি করবে না।'),
      SpeakingSeed('We will meet again.', 'আমরা আবার দেখা করব।'),
      SpeakingSeed('I will practice every day.', 'আমি প্রতিদিন অনুশীলন করব।'),
      SpeakingSeed('He will send the message.', 'সে বার্তাটি পাঠাবে।'),
      SpeakingSeed(
        'I will work tomorrow.',
        'তুমি আগামীকাল কী করবে?',
        question: 'What will you do tomorrow?',
      ),
      SpeakingSeed(
        'Yes, I will help you.',
        'তুমি কি আমাকে সাহায্য করবে?',
        question: 'Will you help me?',
      ),
      SpeakingSeed('She will come tomorrow.', 'ভুল বাক্যটি ঠিক করো: She will comes tomorrow.'),
      SpeakingSeed('I will send the payment today.', 'ক্লায়েন্টকে payment সম্পর্কে প্রতিশ্রুতি দাও।'),
      SpeakingSeed(
        'I will study English and speak confidently.',
        'ভবিষ্যতের English goal বলো।',
        question: 'What will you achieve in English?',
      ),
    ],
  );

  static final SpeakingRule _rule25 = SpeakingRuleFactory.create(
    id: 25,
    title: 'Going To Future',
    explanation:
    'আগে থেকে করা ভবিষ্যৎ পরিকল্পনা বলতে am, is বা are going to ব্যবহার হয়। এরপর verb-এর base form বসে।',
    formula: 'Subject + am/is/are going to + base verb',
    example: 'I am going to study tonight.',
    optionBuilder: _goingToOptions,
    hintBuilder: (_) =>
    'Subject অনুযায়ী am/is/are বসিয়ে going to-এর পরে base verb ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I am going to study tonight.', 'আমি আজ রাতে পড়তে যাচ্ছি।'),
      SpeakingSeed('She is going to cook dinner.', 'সে রাতের খাবার রান্না করতে যাচ্ছে।'),
      SpeakingSeed('They are going to play football.', 'তারা ফুটবল খেলতে যাচ্ছে।'),
      SpeakingSeed('He is going to buy a phone.', 'সে একটি ফোন কিনতে যাচ্ছে।'),
      SpeakingSeed('We are going to visit our village.', 'আমরা আমাদের গ্রামে যেতে যাচ্ছি।'),
      SpeakingSeed('I am going to start a new project.', 'আমি একটি নতুন project শুরু করতে যাচ্ছি।'),
      SpeakingSeed('You are going to learn quickly.', 'তুমি দ্রুত শিখতে যাচ্ছ।'),
      SpeakingSeed('It is going to rain.', 'বৃষ্টি হতে যাচ্ছে।'),
      SpeakingSeed('My brother is going to travel.', 'আমার ভাই ভ্রমণ করতে যাচ্ছে।'),
      SpeakingSeed('The class is going to begin.', 'ক্লাস শুরু হতে যাচ্ছে।'),
      SpeakingSeed('I am going to practice speaking.', 'আমি speaking practice করতে যাচ্ছি।'),
      SpeakingSeed('She is going to meet her friend.', 'সে তার বন্ধুর সঙ্গে দেখা করতে যাচ্ছে।'),
      SpeakingSeed('We are going to watch a movie.', 'আমরা একটি সিনেমা দেখতে যাচ্ছি।'),
      SpeakingSeed('They are going to open a shop.', 'তারা একটি দোকান খুলতে যাচ্ছে।'),
      SpeakingSeed('He is going to call the client.', 'সে client-কে ফোন করতে যাচ্ছে।'),
      SpeakingSeed(
        'I am going to work tonight.',
        'তুমি আজ রাতে কী করতে যাচ্ছ?',
        question: 'What are you going to do tonight?',
      ),
      SpeakingSeed(
        'Yes, we are going to travel.',
        'তোমরা কি ভ্রমণ করতে যাচ্ছ?',
        question: 'Are you going to travel?',
      ),
      SpeakingSeed('She is going to study.', 'ভুল বাক্যটি ঠিক করো: She are going to study.'),
      SpeakingSeed('I am going to book a room.', 'হোটেল ভ্রমণের পরিকল্পনা বলো।'),
      SpeakingSeed(
        'I am going to improve my English and apply for better jobs.',
        'নিজের ভবিষ্যৎ পরিকল্পনা বলো।',
        question: 'What are you going to do in the future?',
      ),
    ],
  );

  static List<String> _wasWereOptions(int id, String correct) {
    final wrongOne = correct.contains(' was ')
        ? correct.replaceFirst(' was ', ' were ')
        : correct.replaceFirst(' were ', ' was ');
    final wrongTwo = correct
        .replaceFirst(' was ', ' is ')
        .replaceFirst(' were ', ' are ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _pastOptions(int id, String correct) {
    const pastToBase = <String, String>{
      'worked': 'work', 'went': 'go', 'watched': 'watch', 'ate': 'eat',
      'played': 'play', 'bought': 'buy', 'cooked': 'cook', 'wrote': 'write',
      'visited': 'visit', 'called': 'call', 'learned': 'learn',
      'arrived': 'arrive', 'helped': 'help', 'saw': 'see', 'finished': 'finish',
    };
    var wrongOne = correct;
    for (final entry in pastToBase.entries) {
      if (correct.contains(' ${entry.key} ')) {
        wrongOne = correct.replaceFirst(' ${entry.key} ', ' ${entry.value} ');
        break;
      }
    }
    return _options(id, correct, wrongOne, 'Did $correct');
  }

  static List<String> _didOptions(int id, String correct) {
    final wrongOne = correct.startsWith('Did ')
        ? correct.replaceFirst('Did ', 'Do ')
        : 'Did $correct';
    final wrongTwo = correct.startsWith('Did ')
        ? correct.replaceFirst('Did ', 'Was ')
        : 'Was $correct';
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _willOptions(int id, String correct) {
    final wrongOne = correct.contains(' will ')
        ? correct.replaceFirst(' will ', ' will to ')
        : 'Will $correct';
    final wrongTwo = correct.contains(' will ')
        ? correct.replaceFirst(' will ', ' is will ')
        : 'Does $correct';
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _goingToOptions(int id, String correct) {
    var wrongOne = correct;
    if (correct.contains(' am going to ')) {
      wrongOne = correct.replaceFirst(' am going to ', ' is going to ');
    } else if (correct.contains(' is going to ')) {
      wrongOne = correct.replaceFirst(' is going to ', ' are going to ');
    } else if (correct.contains(' are going to ')) {
      wrongOne = correct.replaceFirst(' are going to ', ' is going to ');
    }
    final wrongTwo = correct
        .replaceFirst(' am going to ', ' going to ')
        .replaceFirst(' is going to ', ' going to ')
        .replaceFirst(' are going to ', ' going to ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _options(
      int id,
      String correct,
      String wrongOne,
      String wrongTwo,
      ) {
    return SpeakingRuleFactory.arrangeOptions(
      practiceId: id,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }
}
