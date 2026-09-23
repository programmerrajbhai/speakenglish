import '../../models/speaking_rule_model.dart';
import 'speaking_rule_factory.dart';

class SpeakingRules06To10 {
  SpeakingRules06To10._();

  static final List<SpeakingRule> rules = [
    _rule06,
    _rule07,
    _rule08,
    _rule09,
    _rule10,
  ];

  static final SpeakingRule _rule06 =
  SpeakingRuleFactory.create(
    id: 6,
    title: 'There is & There are',
    explanation:
    'একটি জিনিসের অস্তিত্ব বোঝাতে There is এবং একাধিক জিনিসের জন্য There are ব্যবহার হয়।',
    formula: 'There is + singular / There are + plural',
    example:
    'There is a book. There are three books.',
    optionBuilder: _thereOptions,
    hintBuilder: (sentence) {
      return sentence.startsWith('There is')
          ? 'একটি জিনিস হলে There is ব্যবহার করো।'
          : 'একাধিক জিনিস হলে There are ব্যবহার করো।';
    },
    seeds: const [
      SpeakingSeed(
        'There is a book on the table.',
        'টেবিলের ওপর একটি বই আছে।',
      ),
      SpeakingSeed(
        'There are two books on the table.',
        'টেবিলের ওপর দুটি বই আছে।',
      ),
      SpeakingSeed(
        'There is a cat in the room.',
        'ঘরের মধ্যে একটি বিড়াল আছে।',
      ),
      SpeakingSeed(
        'There are many students here.',
        'এখানে অনেক শিক্ষার্থী আছে।',
      ),
      SpeakingSeed(
        'There is a pen in my bag.',
        'আমার ব্যাগে একটি কলম আছে।',
      ),
      SpeakingSeed(
        'There are five chairs in the room.',
        'ঘরে পাঁচটি চেয়ার আছে।',
      ),
      SpeakingSeed(
        'There is some water in the glass.',
        'গ্লাসে কিছু পানি আছে।',
      ),
      SpeakingSeed(
        'There are many trees near my house.',
        'আমার বাড়ির কাছে অনেক গাছ আছে।',
      ),
      SpeakingSeed(
        'There is a problem with my phone.',
        'আমার ফোনে একটি সমস্যা আছে।',
      ),
      SpeakingSeed(
        'There are three people outside.',
        'বাইরে তিনজন মানুষ আছে।',
      ),
      SpeakingSeed(
        'There is a hospital near here.',
        'এখানকার কাছে একটি হাসপাতাল আছে।',
      ),
      SpeakingSeed(
        'There are many shops in this market.',
        'এই বাজারে অনেক দোকান আছে।',
      ),
      SpeakingSeed(
        'There is a message for you.',
        'তোমার জন্য একটি বার্তা আছে।',
      ),
      SpeakingSeed(
        'There is a car beside the house.',
        'বাড়ির পাশে একটি গাড়ি আছে।',
      ),
      SpeakingSeed(
        'There are flowers in the garden.',
        'বাগানে ফুল আছে।',
      ),
      SpeakingSeed(
        'There is a bank near my house.',
        'তোমার বাড়ির কাছে কী আছে? ইংরেজিতে উত্তর দাও।',
        question: 'What is near your house?',
      ),
      SpeakingSeed(
        'There are four people in my family.',
        'তোমার পরিবারে কতজন মানুষ আছে?',
        question: 'How many people are there in your family?',
      ),
      SpeakingSeed(
        'There are two chairs here.',
        'ভুল বাক্যটি ঠিক করো: There is two chairs here.',
      ),
      SpeakingSeed(
        'There is a bus stop near the school.',
        'কাউকে স্কুলের পাশের বাসস্টপ সম্পর্কে বলো।',
      ),
      SpeakingSeed(
        'There is a table, and there are four chairs.',
        'ঘরে কী কী আছে তা বলো।',
        question: 'What is there in the room?',
      ),
    ],
  );

  static final SpeakingRule _rule07 =
  SpeakingRuleFactory.create(
    id: 7,
    title: 'Have & Has',
    explanation:
    'I, You, We, They-এর সঙ্গে have এবং He, She, It-এর সঙ্গে has ব্যবহার হয়।',
    formula: 'I/You/We/They + have • He/She/It + has',
    example: 'I have a phone. She has a laptop.',
    optionBuilder: _haveOptions,
    hintBuilder: (sentence) {
      final lower = sentence.toLowerCase();

      if (lower.startsWith('he ') ||
          lower.startsWith('she ') ||
          lower.startsWith('it ')) {
        return 'He, She বা It-এর সঙ্গে has ব্যবহার করো।';
      }

      return 'I, You, We অথবা They-এর সঙ্গে have ব্যবহার করো।';
    },
    seeds: const [
      SpeakingSeed(
        'I have a mobile phone.',
        'আমার একটি মোবাইল ফোন আছে।',
      ),
      SpeakingSeed(
        'She has a new laptop.',
        'তার একটি নতুন ল্যাপটপ আছে।',
      ),
      SpeakingSeed(
        'We have a small house.',
        'আমাদের একটি ছোট বাড়ি আছে।',
      ),
      SpeakingSeed(
        'He has a bicycle.',
        'তার একটি সাইকেল আছে।',
      ),
      SpeakingSeed(
        'They have many friends.',
        'তাদের অনেক বন্ধু আছে।',
      ),
      SpeakingSeed(
        'You have a beautiful smile.',
        'তোমার সুন্দর হাসি আছে।',
      ),
      SpeakingSeed(
        'I have two brothers.',
        'আমার দুই ভাই আছে।',
      ),
      SpeakingSeed(
        'She has long hair.',
        'তার লম্বা চুল আছে।',
      ),
      SpeakingSeed(
        'He has a good job.',
        'তার একটি ভালো চাকরি আছে।',
      ),
      SpeakingSeed(
        'We have enough time.',
        'আমাদের যথেষ্ট সময় আছে।',
      ),
      SpeakingSeed(
        'They have a new car.',
        'তাদের একটি নতুন গাড়ি আছে।',
      ),
      SpeakingSeed(
        'My phone has a good camera.',
        'আমার ফোনে ভালো ক্যামেরা আছে।',
      ),
      SpeakingSeed(
        'The house has three rooms.',
        'বাড়িটিতে তিনটি ঘর আছে।',
      ),
      SpeakingSeed(
        'I have an English class today.',
        'আজ আমার ইংরেজি ক্লাস আছে।',
      ),
      SpeakingSeed(
        'She has a meeting this morning.',
        'আজ সকালে তার একটি মিটিং আছে।',
      ),
      SpeakingSeed(
        'I have two sisters.',
        'তোমার কয়জন বোন আছে?',
        question: 'How many sisters do you have?',
      ),
      SpeakingSeed(
        'Yes, she has a laptop.',
        'তার কি একটি ল্যাপটপ আছে?',
        question: 'Does she have a laptop?',
      ),
      SpeakingSeed(
        'He has a new phone.',
        'ভুল বাক্যটি ঠিক করো: He have a new phone.',
      ),
      SpeakingSeed(
        'I have my ticket and passport.',
        'ভ্রমণের সময় প্রয়োজনীয় জিনিস আছে বলে জানাও।',
      ),
      SpeakingSeed(
        'I have a laptop, but my brother has a desktop.',
        'তোমাদের কম্পিউটার সম্পর্কে উত্তর দাও।',
        question: 'What computers do you and your brother have?',
      ),
    ],
  );

  static final SpeakingRule _rule08 =
  SpeakingRuleFactory.create(
    id: 8,
    title: 'Subject + Verb',
    explanation:
    'একটি basic action sentence Subject দিয়ে শুরু হয় এবং এরপর সঠিক Verb বসে।',
    formula: 'Subject + Verb + remaining information',
    example: 'I work every day. She reads books.',
    optionBuilder: _verbOptions,
    hintBuilder: (sentence) {
      return 'প্রথমে কে কাজ করছে বলো, তারপর action verb ব্যবহার করো।';
    },
    seeds: const [
      SpeakingSeed(
        'I work every day.',
        'আমি প্রতিদিন কাজ করি।',
      ),
      SpeakingSeed(
        'She reads books.',
        'সে বই পড়ে।',
      ),
      SpeakingSeed(
        'We play football.',
        'আমরা ফুটবল খেলি।',
      ),
      SpeakingSeed(
        'He drinks tea.',
        'সে চা পান করে।',
      ),
      SpeakingSeed(
        'They live in Dhaka.',
        'তারা ঢাকায় থাকে।',
      ),
      SpeakingSeed(
        'You speak English.',
        'তুমি ইংরেজি বলো।',
      ),
      SpeakingSeed(
        'I study at night.',
        'আমি রাতে পড়াশোনা করি।',
      ),
      SpeakingSeed(
        'My mother cooks food.',
        'আমার মা খাবার রান্না করেন।',
      ),
      SpeakingSeed(
        'My father drives a car.',
        'আমার বাবা গাড়ি চালান।',
      ),
      SpeakingSeed(
        'The baby sleeps peacefully.',
        'শিশুটি শান্তভাবে ঘুমায়।',
      ),
      SpeakingSeed(
        'Birds fly in the sky.',
        'পাখিরা আকাশে উড়ে।',
      ),
      SpeakingSeed(
        'The sun rises in the east.',
        'সূর্য পূর্ব দিকে ওঠে।',
      ),
      SpeakingSeed(
        'Water boils at high temperature.',
        'উচ্চ তাপমাত্রায় পানি ফুটে।',
      ),
      SpeakingSeed(
        'I practice English every morning.',
        'আমি প্রতিদিন সকালে ইংরেজি অনুশীলন করি।',
      ),
      SpeakingSeed(
        'She teaches English at school.',
        'সে স্কুলে ইংরেজি পড়ায়।',
      ),
      SpeakingSeed(
        'I work from home.',
        'তুমি কোথায় কাজ করো?',
        question: 'Where do you work?',
      ),
      SpeakingSeed(
        'He plays cricket.',
        'সে কোন খেলা খেলে?',
        question: 'What game does he play?',
      ),
      SpeakingSeed(
        'She reads every day.',
        'ভুল বাক্যটি ঠিক করো: She read every day.',
      ),
      SpeakingSeed(
        'I study English in the evening.',
        'সন্ধ্যার routine সম্পর্কে বলো।',
      ),
      SpeakingSeed(
        'I work in the morning and study at night.',
        'নিজের দৈনিক কাজ সম্পর্কে উত্তর দাও।',
        question: 'What do you do every day?',
      ),
    ],
  );

  static final SpeakingRule _rule09 =
  SpeakingRuleFactory.create(
    id: 9,
    title: 'Objects in Sentences',
    explanation:
    'Verb-এর পরে কাজটি কাকে বা কোন জিনিসকে প্রভাবিত করছে সেটি Object।',
    formula: 'Subject + Verb + Object',
    example: 'I read books. She drinks water.',
    optionBuilder: _objectOptions,
    hintBuilder: (sentence) {
      return 'Subject-এর পরে action এবং action-এর পরে object বসাও।';
    },
    seeds: const [
      SpeakingSeed(
        'I read books.',
        'আমি বই পড়ি।',
      ),
      SpeakingSeed(
        'She drinks water.',
        'সে পানি পান করে।',
      ),
      SpeakingSeed(
        'He plays football.',
        'সে ফুটবল খেলে।',
      ),
      SpeakingSeed(
        'We learn English.',
        'আমরা ইংরেজি শিখি।',
      ),
      SpeakingSeed(
        'They watch television.',
        'তারা টেলিভিশন দেখে।',
      ),
      SpeakingSeed(
        'You need help.',
        'তোমার সাহায্য প্রয়োজন।',
      ),
      SpeakingSeed(
        'I use a computer.',
        'আমি কম্পিউটার ব্যবহার করি।',
      ),
      SpeakingSeed(
        'She writes a letter.',
        'সে একটি চিঠি লেখে।',
      ),
      SpeakingSeed(
        'He buys vegetables.',
        'সে সবজি কেনে।',
      ),
      SpeakingSeed(
        'We clean our room.',
        'আমরা আমাদের ঘর পরিষ্কার করি।',
      ),
      SpeakingSeed(
        'The teacher explains the lesson.',
        'শিক্ষক পাঠটি ব্যাখ্যা করেন।',
      ),
      SpeakingSeed(
        'My mother prepares breakfast.',
        'আমার মা সকালের খাবার তৈরি করেন।',
      ),
      SpeakingSeed(
        'The child opens the door.',
        'শিশুটি দরজা খোলে।',
      ),
      SpeakingSeed(
        'I check my email every morning.',
        'আমি প্রতিদিন সকালে ইমেইল দেখি।',
      ),
      SpeakingSeed(
        'She answers the question.',
        'সে প্রশ্নের উত্তর দেয়।',
      ),
      SpeakingSeed(
        'I read English books.',
        'তুমি কী ধরনের বই পড়ো?',
        question: 'What kind of books do you read?',
      ),
      SpeakingSeed(
        'She drinks coffee.',
        'সে কী পান করে?',
        question: 'What does she drink?',
      ),
      SpeakingSeed(
        'I use a computer.',
        'ভুল order ঠিক করো: I a computer use.',
      ),
      SpeakingSeed(
        'I need a bus ticket.',
        'টিকিট কাউন্টারে নিজের প্রয়োজন বলো।',
      ),
      SpeakingSeed(
        'I read books and watch English videos.',
        'ইংরেজি শেখার জন্য তুমি কী করো?',
        question: 'What do you do to learn English?',
      ),
    ],
  );

  static final SpeakingRule _rule10 =
  SpeakingRuleFactory.create(
    id: 10,
    title: 'A, An & The',
    explanation:
    'Consonant sound-এর আগে a, vowel sound-এর আগে an এবং নির্দিষ্ট জিনিসের আগে the বসে।',
    formula: 'a + consonant • an + vowel • the + specific',
    example: 'I have a book. She eats an apple.',
    optionBuilder: _articleOptions,
    hintBuilder: (sentence) {
      return 'একটি সাধারণ জিনিসে a/an এবং নির্দিষ্ট জিনিসে the ব্যবহার করো।';
    },
    seeds: const [
      SpeakingSeed(
        'I have a book.',
        'আমার একটি বই আছে।',
      ),
      SpeakingSeed(
        'She eats an apple.',
        'সে একটি আপেল খায়।',
      ),
      SpeakingSeed(
        'He is a teacher.',
        'সে একজন শিক্ষক।',
      ),
      SpeakingSeed(
        'I need an umbrella.',
        'আমার একটি ছাতা প্রয়োজন।',
      ),
      SpeakingSeed(
        'This is a car.',
        'এটি একটি গাড়ি।',
      ),
      SpeakingSeed(
        'That is an orange.',
        'ওটি একটি কমলা।',
      ),
      SpeakingSeed(
        'She has a cat.',
        'তার একটি বিড়াল আছে।',
      ),
      SpeakingSeed(
        'He is an honest man.',
        'সে একজন সৎ মানুষ।',
      ),
      SpeakingSeed(
        'The sun is very bright.',
        'সূর্য খুব উজ্জ্বল।',
      ),
      SpeakingSeed(
        'Please close the door.',
        'দয়া করে দরজাটি বন্ধ করো।',
      ),
      SpeakingSeed(
        'I saw a bird in the garden.',
        'আমি বাগানে একটি পাখি দেখেছি।',
      ),
      SpeakingSeed(
        'She bought an expensive bag.',
        'সে একটি দামি ব্যাগ কিনেছে।',
      ),
      SpeakingSeed(
        'The book is on the table.',
        'বইটি টেবিলের ওপর আছে।',
      ),
      SpeakingSeed(
        'I want a glass of water.',
        'আমি এক গ্লাস পানি চাই।',
      ),
      SpeakingSeed(
        'He is an English teacher.',
        'সে একজন ইংরেজি শিক্ষক।',
      ),
      SpeakingSeed(
        'I need an umbrella.',
        'বৃষ্টির সময় তোমার কী প্রয়োজন?',
        question: 'What do you need when it rains?',
      ),
      SpeakingSeed(
        'The phone is on the table.',
        'ফোনটি কোথায় আছে?',
        question: 'Where is the phone?',
      ),
      SpeakingSeed(
        'She eats an apple.',
        'ভুল বাক্যটি ঠিক করো: She eats a apple.',
      ),
      SpeakingSeed(
        'I would like a cup of tea.',
        'রেস্টুরেন্টে এক কাপ চা চাও।',
      ),
      SpeakingSeed(
        'I need a room and an extra pillow.',
        'হোটেলের কর্মীকে নিজের প্রয়োজন বলো।',
        question: 'What do you need for your stay?',
      ),
    ],
  );

  static List<String> _thereOptions(
      int practiceId,
      String correct,
      ) {
    final wrongOne = correct.startsWith('There is')
        ? correct.replaceFirst('There is', 'There are')
        : correct.replaceFirst('There are', 'There is');

    final wrongTwo = correct.startsWith('There is')
        ? correct.replaceFirst('There is', 'There am')
        : correct.replaceFirst('There are', 'There is are');

    return SpeakingRuleFactory.arrangeOptions(
      practiceId: practiceId,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }

  static List<String> _haveOptions(
      int practiceId,
      String correct,
      ) {
    final usesHas = correct.contains(' has ');

    final wrongOne = usesHas
        ? correct.replaceFirst(' has ', ' have ')
        : correct.replaceFirst(' have ', ' has ');

    final wrongTwo = usesHas
        ? correct.replaceFirst(' has ', ' having ')
        : correct.replaceFirst(' have ', ' having ');

    return SpeakingRuleFactory.arrangeOptions(
      practiceId: practiceId,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }

  static List<String> _verbOptions(
      int practiceId,
      String correct,
      ) {
    final wrongOne = 'Does $correct';
    final wrongTwo = 'Is $correct';

    return SpeakingRuleFactory.arrangeOptions(
      practiceId: practiceId,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }

  static List<String> _objectOptions(
      int practiceId,
      String correct,
      ) {
    final words = correct
        .replaceAll(RegExp(r'[.!?]'), '')
        .split(' ');

    final wrongOne = words.reversed.join(' ');
    final wrongTwo = 'Does $correct';

    return SpeakingRuleFactory.arrangeOptions(
      practiceId: practiceId,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }

  static List<String> _articleOptions(
      int practiceId,
      String correct,
      ) {
    String wrongOne = correct;
    String wrongTwo = correct;

    if (correct.contains(' an ')) {
      wrongOne = correct.replaceFirst(' an ', ' a ');
      wrongTwo = correct.replaceFirst(' an ', ' the ');
    } else if (correct.contains(' a ')) {
      wrongOne = correct.replaceFirst(' a ', ' an ');
      wrongTwo = correct.replaceFirst(' a ', ' the ');
    } else if (correct.startsWith('The ')) {
      wrongOne = correct.replaceFirst('The ', 'A ');
      wrongTwo = correct.replaceFirst('The ', 'An ');
    } else if (correct.contains(' the ')) {
      wrongOne = correct.replaceFirst(' the ', ' a ');
      wrongTwo = correct.replaceFirst(' the ', ' an ');
    } else {
      wrongOne = 'A $correct';
      wrongTwo = 'An $correct';
    }

    return SpeakingRuleFactory.arrangeOptions(
      practiceId: practiceId,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }
}