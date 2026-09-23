import '../../models/speaking_rule_model.dart';
import 'speaking_rule_factory.dart';

class SpeakingRules16To20 {
  SpeakingRules16To20._();

  static final List<SpeakingRule> rules = <SpeakingRule>[
    _rule16,
    _rule17,
    _rule18,
    _rule19,
    _rule20,
  ];

  static final SpeakingRule _rule16 = SpeakingRuleFactory.create(
    id: 16,
    title: 'Simple Present Tense',
    explanation:
    'নিয়মিত কাজ, অভ্যাস ও সাধারণ সত্য বলতে Simple Present ব্যবহার হয়। He, She ও It-এর সঙ্গে verb-এ সাধারণত s বা es যোগ হয়।',
    formula: 'Subject + base verb / verb+s/es + object',
    example: 'I work every day. She works every day.',
    optionBuilder: _simplePresentOptions,
    hintBuilder: (sentence) =>
    'He, She বা It হলে verb-এ s/es দাও; অন্য subject হলে base verb রাখো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I wake up early.', 'আমি সকালে তাড়াতাড়ি ঘুম থেকে উঠি।'),
      SpeakingSeed('She wakes up early.', 'সে সকালে তাড়াতাড়ি ঘুম থেকে ওঠে।'),
      SpeakingSeed('We study English every day.', 'আমরা প্রতিদিন ইংরেজি পড়ি।'),
      SpeakingSeed('He studies English every day.', 'সে প্রতিদিন ইংরেজি পড়ে।'),
      SpeakingSeed('They play football on Friday.', 'তারা শুক্রবার ফুটবল খেলে।'),
      SpeakingSeed('My brother plays cricket.', 'আমার ভাই ক্রিকেট খেলে।'),
      SpeakingSeed('I drink tea in the morning.', 'আমি সকালে চা পান করি।'),
      SpeakingSeed('My mother cooks breakfast.', 'আমার মা সকালের খাবার রান্না করেন।'),
      SpeakingSeed('You speak very clearly.', 'তুমি খুব স্পষ্টভাবে কথা বলো।'),
      SpeakingSeed('The shop opens at nine.', 'দোকানটি নয়টায় খোলে।'),
      SpeakingSeed('Birds fly in the sky.', 'পাখিরা আকাশে উড়ে।'),
      SpeakingSeed('The sun rises in the east.', 'সূর্য পূর্ব দিকে ওঠে।'),
      SpeakingSeed('I practice speaking at night.', 'আমি রাতে speaking practice করি।'),
      SpeakingSeed('She watches English videos.', 'সে ইংরেজি ভিডিও দেখে।'),
      SpeakingSeed('He goes to work by bus.', 'সে বাসে করে কাজে যায়।'),
      SpeakingSeed(
        'I work from home.',
        'তুমি কোথায় কাজ করো?',
        question: 'Where do you work?',
      ),
      SpeakingSeed(
        'She reads books every evening.',
        'সে কখন বই পড়ে?',
        question: 'When does she read books?',
      ),
      SpeakingSeed('He plays football.', 'ভুল বাক্যটি ঠিক করো: He play football.'),
      SpeakingSeed('I take the bus to work every day.', 'নিজের নিয়মিত যাতায়াত সম্পর্কে বলো।'),
      SpeakingSeed(
        'I study English and practice speaking every day.',
        'প্রতিদিন ইংরেজি শেখার জন্য কী করো?',
        question: 'What do you do to learn English every day?',
      ),
    ],
  );

  static final SpeakingRule _rule17 = SpeakingRuleFactory.create(
    id: 17,
    title: 'Do & Does Questions',
    explanation:
    'Simple Present-এ I, You, We, They-এর প্রশ্নে Do এবং He, She, It-এর প্রশ্নে Does ব্যবহার হয়। Does-এর পরে verb-এর base form বসে।',
    formula: 'Do/Does + subject + base verb + ...?',
    example: 'Do you work? Does she study?',
    optionBuilder: _doDoesOptions,
    hintBuilder: (sentence) =>
    'He, She বা It-এর জন্য Does; অন্য subject-এর জন্য Do ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('Do you speak English?', 'তুমি কি ইংরেজি বলো?'),
      SpeakingSeed('Does she live here?', 'সে কি এখানে থাকে?'),
      SpeakingSeed('Do they play football?', 'তারা কি ফুটবল খেলে?'),
      SpeakingSeed('Does he work from home?', 'সে কি বাসা থেকে কাজ করে?'),
      SpeakingSeed('Do we have enough time?', 'আমাদের কি যথেষ্ট সময় আছে?'),
      SpeakingSeed('Does your brother drive?', 'তোমার ভাই কি গাড়ি চালায়?'),
      SpeakingSeed('Do you drink coffee?', 'তুমি কি কফি পান করো?'),
      SpeakingSeed('Does your mother cook every day?', 'তোমার মা কি প্রতিদিন রান্না করেন?'),
      SpeakingSeed('Do the children go to school?', 'শিশুরা কি স্কুলে যায়?'),
      SpeakingSeed('Does this bus go to the station?', 'এই বাস কি স্টেশনে যায়?'),
      SpeakingSeed('Do you understand me?', 'তুমি কি আমাকে বুঝতে পারছ?'),
      SpeakingSeed('Does the shop open at nine?', 'দোকানটি কি নয়টায় খোলে?'),
      SpeakingSeed('Do they need help?', 'তাদের কি সাহায্য প্রয়োজন?'),
      SpeakingSeed('Does she watch English videos?', 'সে কি ইংরেজি ভিডিও দেখে?'),
      SpeakingSeed('Do you practice every day?', 'তুমি কি প্রতিদিন অনুশীলন করো?'),
      SpeakingSeed(
        'Yes, I work from home.',
        'Do you work from home? প্রশ্নের উত্তর দাও।',
        question: 'Do you work from home?',
      ),
      SpeakingSeed(
        'No, he does not drive.',
        'Does he drive? প্রশ্নের উত্তর দাও।',
        question: 'Does he drive?',
      ),
      SpeakingSeed('Does she speak English?', 'ভুল প্রশ্নটি ঠিক করো: Does she speaks English?'),
      SpeakingSeed('Does this train go to Dhaka?', 'স্টেশনে ট্রেনের গন্তব্য জিজ্ঞাসা করো।'),
      SpeakingSeed(
        'Yes, I study English every day.',
        'ইংরেজি অনুশীলন নিয়ে কথোপকথনের উত্তর দাও।',
        question: 'Do you study English every day?',
      ),
    ],
  );

  static final SpeakingRule _rule18 = SpeakingRuleFactory.create(
    id: 18,
    title: 'Negative Sentences',
    explanation:
    'Simple Present-এর negative বাক্যে I, You, We, They-এর সঙ্গে do not এবং He, She, It-এর সঙ্গে does not ব্যবহার হয়।',
    formula: 'Subject + do not/does not + base verb',
    example: 'I do not smoke. She does not drive.',
    optionBuilder: _negativeOptions,
    hintBuilder: (sentence) =>
    'does not-এর পরেও verb-এর base form ব্যবহার করো; verb-এ s/es দিও না।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I do not smoke.', 'আমি ধূমপান করি না।'),
      SpeakingSeed('She does not drive.', 'সে গাড়ি চালায় না।'),
      SpeakingSeed('We do not live in Dhaka.', 'আমরা ঢাকায় থাকি না।'),
      SpeakingSeed('He does not drink coffee.', 'সে কফি পান করে না।'),
      SpeakingSeed('They do not play cricket.', 'তারা ক্রিকেট খেলে না।'),
      SpeakingSeed('My brother does not work here.', 'আমার ভাই এখানে কাজ করে না।'),
      SpeakingSeed('I do not understand this word.', 'আমি এই শব্দটি বুঝি না।'),
      SpeakingSeed('She does not watch television.', 'সে টেলিভিশন দেখে না।'),
      SpeakingSeed('You do not need a ticket.', 'তোমার টিকিট প্রয়োজন নেই।'),
      SpeakingSeed('The shop does not open on Friday.', 'দোকানটি শুক্রবার খোলে না।'),
      SpeakingSeed('We do not have enough time.', 'আমাদের যথেষ্ট সময় নেই।'),
      SpeakingSeed('He does not speak loudly.', 'সে জোরে কথা বলে না।'),
      SpeakingSeed('I do not use this phone.', 'আমি এই ফোনটি ব্যবহার করি না।'),
      SpeakingSeed('My mother does not eat meat.', 'আমার মা মাংস খান না।'),
      SpeakingSeed('They do not know the answer.', 'তারা উত্তরটি জানে না।'),
      SpeakingSeed(
        'No, I do not drink coffee.',
        'তুমি কি কফি পান করো?',
        question: 'Do you drink coffee?',
      ),
      SpeakingSeed(
        'No, she does not live here.',
        'সে কি এখানে থাকে?',
        question: 'Does she live here?',
      ),
      SpeakingSeed('He does not play football.', 'ভুল বাক্যটি ঠিক করো: He does not plays football.'),
      SpeakingSeed('I do not eat spicy food.', 'রেস্টুরেন্টে নিজের খাবারের পছন্দ বলো।'),
      SpeakingSeed(
        'I do not speak fluently, but I do not stop practicing.',
        'ইংরেজি শেখার বর্তমান অবস্থা বলো।',
        question: 'What can you not do fluently yet?',
      ),
    ],
  );

  static final SpeakingRule _rule19 = SpeakingRuleFactory.create(
    id: 19,
    title: 'Present Continuous',
    explanation:
    'এই মুহূর্তে চলমান কাজ বলতে Present Continuous ব্যবহার হয়। Subject অনুযায়ী am, is বা are-এর পরে verb+ing বসে।',
    formula: 'Subject + am/is/are + verb-ing',
    example: 'I am reading. She is cooking.',
    optionBuilder: _continuousOptions,
    hintBuilder: (sentence) =>
    'চলমান কাজে am/is/are-এর পরে verb-এর সঙ্গে ing যোগ করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I am reading a book.', 'আমি একটি বই পড়ছি।'),
      SpeakingSeed('She is cooking dinner.', 'সে রাতের খাবার রান্না করছে।'),
      SpeakingSeed('They are playing football.', 'তারা ফুটবল খেলছে।'),
      SpeakingSeed('He is talking on the phone.', 'সে ফোনে কথা বলছে।'),
      SpeakingSeed('We are learning English.', 'আমরা ইংরেজি শিখছি।'),
      SpeakingSeed('You are speaking clearly.', 'তুমি স্পষ্টভাবে কথা বলছ।'),
      SpeakingSeed('The baby is sleeping.', 'শিশুটি ঘুমাচ্ছে।'),
      SpeakingSeed('My friends are waiting outside.', 'আমার বন্ধুরা বাইরে অপেক্ষা করছে।'),
      SpeakingSeed('I am writing an email.', 'আমি একটি ইমেইল লিখছি।'),
      SpeakingSeed('It is raining now.', 'এখন বৃষ্টি হচ্ছে।'),
      SpeakingSeed('The bus is coming.', 'বাসটি আসছে।'),
      SpeakingSeed('The children are studying.', 'শিশুরা পড়াশোনা করছে।'),
      SpeakingSeed('My mother is watching television.', 'আমার মা টেলিভিশন দেখছেন।'),
      SpeakingSeed('We are having lunch.', 'আমরা দুপুরের খাবার খাচ্ছি।'),
      SpeakingSeed('She is wearing a blue dress.', 'সে নীল পোশাক পরেছে।'),
      SpeakingSeed(
        'I am practicing English.',
        'তুমি এখন কী করছ?',
        question: 'What are you doing now?',
      ),
      SpeakingSeed(
        'They are playing in the field.',
        'তারা কোথায় খেলছে?',
        question: 'Where are they playing?',
      ),
      SpeakingSeed('He is going to school.', 'ভুল বাক্যটি ঠিক করো: He are going to school.'),
      SpeakingSeed('I am waiting for the bus.', 'বাসস্টপে তুমি কী করছ তা বলো।'),
      SpeakingSeed(
        'I am sitting at my desk and working on my project.',
        'এই মুহূর্তে নিজের কাজ সম্পর্কে বলো।',
        question: 'What are you doing right now?',
      ),
    ],
  );

  static final SpeakingRule _rule20 = SpeakingRuleFactory.create(
    id: 20,
    title: 'Talk About Daily Routine',
    explanation:
    'প্রতিদিনের কাজ ধারাবাহিকভাবে বলতে Simple Present এবং first, then, after that, finally-এর মতো sequence words ব্যবহার করো।',
    formula: 'First + action • Then/After that + action • Finally + action',
    example: 'First, I wake up. Then, I brush my teeth.',
    optionBuilder: _routineOptions,
    hintBuilder: (sentence) =>
    'কাজের সঠিক ক্রম বোঝাতে first, then, after that বা finally ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I wake up at six every morning.', 'আমি প্রতিদিন সকাল ছয়টায় উঠি।'),
      SpeakingSeed('First, I brush my teeth.', 'প্রথমে আমি দাঁত ব্রাশ করি।'),
      SpeakingSeed('Then, I wash my face.', 'তারপর আমি মুখ ধুই।'),
      SpeakingSeed('After that, I eat breakfast.', 'এরপর আমি সকালের খাবার খাই।'),
      SpeakingSeed('I start work at nine.', 'আমি নয়টায় কাজ শুরু করি।'),
      SpeakingSeed('I take a short break at noon.', 'আমি দুপুরে অল্প বিরতি নিই।'),
      SpeakingSeed('I eat lunch with my family.', 'আমি পরিবারের সঙ্গে দুপুরের খাবার খাই।'),
      SpeakingSeed('I work again in the afternoon.', 'আমি বিকেলে আবার কাজ করি।'),
      SpeakingSeed('I practice English in the evening.', 'আমি সন্ধ্যায় ইংরেজি অনুশীলন করি।'),
      SpeakingSeed('I watch English videos at night.', 'আমি রাতে ইংরেজি ভিডিও দেখি।'),
      SpeakingSeed('I have dinner at nine.', 'আমি নয়টায় রাতের খাবার খাই।'),
      SpeakingSeed('Finally, I go to bed at eleven.', 'সবশেষে আমি এগারোটায় ঘুমাতে যাই।'),
      SpeakingSeed('On Friday, I visit my friends.', 'শুক্রবার আমি বন্ধুদের সঙ্গে দেখা করি।'),
      SpeakingSeed('I clean my room every morning.', 'আমি প্রতিদিন সকালে ঘর পরিষ্কার করি।'),
      SpeakingSeed('I check my email after breakfast.', 'সকালের খাবারের পর আমি ইমেইল দেখি।'),
      SpeakingSeed(
        'I wake up at six.',
        'তুমি কখন ঘুম থেকে ওঠো?',
        question: 'When do you wake up?',
      ),
      SpeakingSeed(
        'I practice English in the evening.',
        'তুমি সন্ধ্যায় কী করো?',
        question: 'What do you do in the evening?',
      ),
      SpeakingSeed('Then, I eat breakfast.', 'ভুল বাক্যটি ঠিক করো: Then, I eats breakfast.'),
      SpeakingSeed('First, I check my schedule, and then I start work.', 'কাজ শুরু করার আগের routine বলো।'),
      SpeakingSeed(
        'First, I wake up early. Then, I work, practice English, and finally go to bed.',
        'নিজের পুরো দিনের routine সংক্ষেপে বলো।',
        question: 'Can you describe your daily routine?',
      ),
    ],
  );

  static List<String> _simplePresentOptions(int id, String correct) {
    final subject = correct.split(' ').first;
    final singular = <String>{'He', 'She', 'It'}.contains(subject) ||
        correct.startsWith('My brother') ||
        correct.startsWith('My mother') ||
        correct.startsWith('The shop') ||
        correct.startsWith('The sun');
    final words = correct.split(' ');
    final verbIndex = subject == 'My' || subject == 'The' ? 2 : 1;
    var wrongOne = correct;
    if (words.length > verbIndex) {
      final verb = words[verbIndex];
      words[verbIndex] = singular
          ? (verb.endsWith('s') ? verb.substring(0, verb.length - 1) : verb)
          : '${verb}s';
      wrongOne = words.join(' ');
    }
    final wrongTwo = 'Does $correct';
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _doDoesOptions(int id, String correct) {
    final wrongOne = correct.startsWith('Does ')
        ? correct.replaceFirst('Does ', 'Do ')
        : correct.startsWith('Do ')
        ? correct.replaceFirst('Do ', 'Does ')
        : 'Does $correct';
    final wrongTwo = correct
        .replaceFirst(RegExp(r'^(Do|Does) '), '')
        .replaceFirst('?', ' do?');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _negativeOptions(int id, String correct) {
    final wrongOne = correct.contains(' does not ')
        ? correct.replaceFirst(' does not ', ' do not ')
        : correct.replaceFirst(' do not ', ' does not ');
    final wrongTwo = correct
        .replaceFirst(' does not ', ' not ')
        .replaceFirst(' do not ', ' not ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _continuousOptions(int id, String correct) {
    var wrongOne = correct;
    if (correct.contains(' am ')) {
      wrongOne = correct.replaceFirst(' am ', ' is ');
    } else if (correct.contains(' is ')) {
      wrongOne = correct.replaceFirst(' is ', ' are ');
    } else if (correct.contains(' are ')) {
      wrongOne = correct.replaceFirst(' are ', ' is ');
    }
    final wrongTwo = correct
        .replaceFirst(' am ', ' ')
        .replaceFirst(' is ', ' ')
        .replaceFirst(' are ', ' ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _routineOptions(int id, String correct) {
    var wrongOne = correct;
    var wrongTwo = correct;
    if (correct.startsWith('First,')) {
      wrongOne = correct.replaceFirst('First,', 'Finally,');
      wrongTwo = correct.replaceFirst('First,', 'Yesterday,');
    } else if (correct.startsWith('Then,')) {
      wrongOne = correct.replaceFirst('Then,', 'Before first,');
      wrongTwo = correct.replaceFirst('Then,', 'Never,');
    } else if (correct.startsWith('After that,')) {
      wrongOne = correct.replaceFirst('After that,', 'Before that,');
      wrongTwo = correct.replaceFirst('After that,', 'Last year,');
    } else if (correct.startsWith('Finally,')) {
      wrongOne = correct.replaceFirst('Finally,', 'First,');
      wrongTwo = correct.replaceFirst('Finally,', 'Before,');
    } else {
      wrongOne = 'Yesterday, $correct';
      wrongTwo = 'Does $correct';
    }
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _options(
      int practiceId,
      String correct,
      String wrongOne,
      String wrongTwo,
      ) {
    return SpeakingRuleFactory.arrangeOptions(
      practiceId: practiceId,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }
}
