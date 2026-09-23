import '../../models/speaking_rule_model.dart';
import 'speaking_rule_factory.dart';

class SpeakingRules11To15 {
  SpeakingRules11To15._();

  static final List<SpeakingRule> rules = <SpeakingRule>[
    _rule11,
    _rule12,
    _rule13,
    _rule14,
    _rule15,
  ];

  static final SpeakingRule _rule11 = SpeakingRuleFactory.create(
    id: 11,
    title: 'Singular & Plural',
    explanation:
    'একটি ব্যক্তি বা জিনিস বোঝাতে singular এবং একের বেশি বোঝাতে plural ব্যবহার হয়। সাধারণত plural করতে noun-এর শেষে s বা es যোগ হয়।',
    formula: 'one + singular noun • two/many + plural noun',
    example: 'This is a book. These are two books.',
    optionBuilder: _singularPluralOptions,
    hintBuilder: (sentence) =>
    'একটি হলে singular noun, আর একের বেশি হলে plural noun ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('This is a book.', 'এটি একটি বই।'),
      SpeakingSeed('These are two books.', 'এগুলো দুটি বই।'),
      SpeakingSeed('I have one brother.', 'আমার একজন ভাই আছে।'),
      SpeakingSeed('I have two sisters.', 'আমার দুইজন বোন আছে।'),
      SpeakingSeed('There is a chair in the room.', 'ঘরে একটি চেয়ার আছে।'),
      SpeakingSeed('There are four chairs in the room.', 'ঘরে চারটি চেয়ার আছে।'),
      SpeakingSeed('The child is playing.', 'শিশুটি খেলছে।'),
      SpeakingSeed('The children are playing.', 'শিশুরা খেলছে।'),
      SpeakingSeed('I bought a mango.', 'আমি একটি আম কিনেছি।'),
      SpeakingSeed('I bought five mangoes.', 'আমি পাঁচটি আম কিনেছি।'),
      SpeakingSeed('A bus is coming.', 'একটি বাস আসছে।'),
      SpeakingSeed('Three buses are waiting.', 'তিনটি বাস অপেক্ষা করছে।'),
      SpeakingSeed('This woman is a doctor.', 'এই নারী একজন ডাক্তার।'),
      SpeakingSeed('Those women are teachers.', 'ওই নারীরা শিক্ষক।'),
      SpeakingSeed('My foot is wet.', 'আমার পা ভেজা।'),
      SpeakingSeed(
        'I have two phones.',
        'তোমার কয়টি ফোন আছে?',
        question: 'How many phones do you have?',
      ),
      SpeakingSeed(
        'There are three people in the room.',
        'ঘরে কতজন মানুষ আছে?',
        question: 'How many people are in the room?',
      ),
      SpeakingSeed('These are two boxes.', 'ভুল বাক্যটি ঠিক করো: These are two box.'),
      SpeakingSeed('I need two tickets, please.', 'কাউন্টারে দুটি টিকিট চাও।'),
      SpeakingSeed(
        'I have one brother and two sisters.',
        'তোমার ভাইবোন সম্পর্কে বলো।',
        question: 'How many brothers and sisters do you have?',
      ),
    ],
  );

  static final SpeakingRule _rule12 = SpeakingRuleFactory.create(
    id: 12,
    title: 'My, Your, His & Her',
    explanation:
    'কোনো জিনিস কার তা বোঝাতে my, your, his এবং her ব্যবহার হয়। এগুলোর পরে সাধারণত একটি noun বসে।',
    formula: 'my/your/his/her + noun',
    example: 'This is my phone. That is her bag.',
    optionBuilder: _possessiveOptions,
    hintBuilder: (sentence) =>
    'মালিক অনুযায়ী my, your, his অথবা her বেছে নাও।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('This is my phone.', 'এটি আমার ফোন।'),
      SpeakingSeed('That is your bag.', 'ওটি তোমার ব্যাগ।'),
      SpeakingSeed('His name is Rahim.', 'তার নাম রহিম।'),
      SpeakingSeed('Her name is Rima.', 'তার নাম রিমা।'),
      SpeakingSeed('My house is small.', 'আমার বাড়ি ছোট।'),
      SpeakingSeed('Your English is good.', 'তোমার ইংরেজি ভালো।'),
      SpeakingSeed('His father is a teacher.', 'তার বাবা একজন শিক্ষক।'),
      SpeakingSeed('Her mother is a doctor.', 'তার মা একজন ডাক্তার।'),
      SpeakingSeed('My brother lives in Dhaka.', 'আমার ভাই ঢাকায় থাকে।'),
      SpeakingSeed('Your book is on the table.', 'তোমার বইটি টেবিলের ওপর আছে।'),
      SpeakingSeed('His car is new.', 'তার গাড়িটি নতুন।'),
      SpeakingSeed('Her dress is beautiful.', 'তার পোশাকটি সুন্দর।'),
      SpeakingSeed('My friends help me.', 'আমার বন্ধুরা আমাকে সাহায্য করে।'),
      SpeakingSeed('Your idea is interesting.', 'তোমার ধারণাটি আকর্ষণীয়।'),
      SpeakingSeed('Her phone is ringing.', 'তার ফোন বাজছে।'),
      SpeakingSeed(
        'My name is Raj.',
        'তোমার নাম কী?',
        question: 'What is your name?',
      ),
      SpeakingSeed(
        'His job is teaching.',
        'তার কাজ কী?',
        question: 'What is his job?',
      ),
      SpeakingSeed('Her bag is red.', 'ভুল বাক্যটি ঠিক করো: She bag is red.'),
      SpeakingSeed('This is my passport.', 'চেক-ইন ডেস্কে নিজের পাসপোর্ট দেখাও।'),
      SpeakingSeed(
        'My phone is black, and her phone is white.',
        'তোমাদের ফোন সম্পর্কে বলো।',
        question: 'What colors are your phones?',
      ),
    ],
  );

  static final SpeakingRule _rule13 = SpeakingRuleFactory.create(
    id: 13,
    title: 'Can & Cannot',
    explanation:
    'কোনো কাজ করার সক্ষমতা বোঝাতে can এবং অক্ষমতা বোঝাতে cannot ব্যবহার হয়। can-এর পরে verb-এর base form বসে।',
    formula: 'Subject + can/cannot + base verb',
    example: 'I can swim. I cannot drive.',
    optionBuilder: _canOptions,
    hintBuilder: (sentence) =>
    'can বা cannot-এর পরে verb-এর মূল রূপ ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I can speak English.', 'আমি ইংরেজি বলতে পারি।'),
      SpeakingSeed('I cannot drive a car.', 'আমি গাড়ি চালাতে পারি না।'),
      SpeakingSeed('She can sing well.', 'সে ভালো গান গাইতে পারে।'),
      SpeakingSeed('He cannot swim.', 'সে সাঁতার কাটতে পারে না।'),
      SpeakingSeed('We can help you.', 'আমরা তোমাকে সাহায্য করতে পারি।'),
      SpeakingSeed('They cannot come today.', 'তারা আজ আসতে পারবে না।'),
      SpeakingSeed('You can sit here.', 'তুমি এখানে বসতে পারো।'),
      SpeakingSeed('I can use a computer.', 'আমি কম্পিউটার ব্যবহার করতে পারি।'),
      SpeakingSeed('My mother can cook well.', 'আমার মা ভালো রান্না করতে পারেন।'),
      SpeakingSeed('My brother cannot ride a bicycle.', 'আমার ভাই সাইকেল চালাতে পারে না।'),
      SpeakingSeed('Birds can fly.', 'পাখিরা উড়তে পারে।'),
      SpeakingSeed('A baby cannot speak clearly.', 'একটি শিশু স্পষ্টভাবে কথা বলতে পারে না।'),
      SpeakingSeed('I can understand this lesson.', 'আমি এই পাঠটি বুঝতে পারি।'),
      SpeakingSeed('She can answer the question.', 'সে প্রশ্নটির উত্তর দিতে পারে।'),
      SpeakingSeed('We cannot wait any longer.', 'আমরা আর অপেক্ষা করতে পারি না।'),
      SpeakingSeed(
        'I can speak Bangla and English.',
        'তুমি কোন ভাষা বলতে পারো?',
        question: 'What languages can you speak?',
      ),
      SpeakingSeed(
        'Yes, I can help you.',
        'তুমি কি আমাকে সাহায্য করতে পারবে?',
        question: 'Can you help me?',
      ),
      SpeakingSeed('He can play football.', 'ভুল বাক্যটি ঠিক করো: He can plays football.'),
      SpeakingSeed('I cannot find my ticket.', 'স্টেশনে বলো যে টিকিটটি খুঁজে পাচ্ছ না।'),
      SpeakingSeed(
        'I can read English, but I cannot speak fluently yet.',
        'নিজের ইংরেজি দক্ষতা সম্পর্কে বলো।',
        question: 'What can you do in English?',
      ),
    ],
  );

  static final SpeakingRule _rule14 = SpeakingRuleFactory.create(
    id: 14,
    title: 'Basic Prepositions',
    explanation:
    'কোনো ব্যক্তি বা জিনিসের অবস্থান বোঝাতে in, on, under, beside, behind, in front of এবং between ব্যবহার হয়।',
    formula: 'Subject + be verb + preposition + place/object',
    example: 'The book is on the table.',
    optionBuilder: _prepositionOptions,
    hintBuilder: (sentence) =>
    'জিনিসটির সঠিক অবস্থান বুঝে preposition নির্বাচন করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('The book is on the table.', 'বইটি টেবিলের ওপর আছে।'),
      SpeakingSeed('The cat is under the chair.', 'বিড়ালটি চেয়ারের নিচে আছে।'),
      SpeakingSeed('The keys are in my bag.', 'চাবিগুলো আমার ব্যাগের মধ্যে আছে।'),
      SpeakingSeed('The school is beside the bank.', 'স্কুলটি ব্যাংকের পাশে।'),
      SpeakingSeed('The car is behind the house.', 'গাড়িটি বাড়ির পেছনে আছে।'),
      SpeakingSeed('He is standing in front of the door.', 'সে দরজার সামনে দাঁড়িয়ে আছে।'),
      SpeakingSeed('The ball is between the boxes.', 'বলটি বাক্স দুটির মাঝখানে।'),
      SpeakingSeed('My phone is on the bed.', 'আমার ফোনটি বিছানার ওপর আছে।'),
      SpeakingSeed('She is in the kitchen.', 'সে রান্নাঘরে আছে।'),
      SpeakingSeed('The shoes are under the bed.', 'জুতাগুলো বিছানার নিচে আছে।'),
      SpeakingSeed('The pharmacy is beside the hospital.', 'ফার্মেসিটি হাসপাতালের পাশে।'),
      SpeakingSeed('The garden is behind our house.', 'বাগানটি আমাদের বাড়ির পেছনে।'),
      SpeakingSeed('A man is standing in front of me.', 'একজন মানুষ আমার সামনে দাঁড়িয়ে আছেন।'),
      SpeakingSeed('The chair is between the table and the wall.', 'চেয়ারটি টেবিল ও দেয়ালের মাঝখানে।'),
      SpeakingSeed('There is a picture on the wall.', 'দেয়ালে একটি ছবি আছে।'),
      SpeakingSeed(
        'My phone is in my pocket.',
        'তোমার ফোন কোথায়?',
        question: 'Where is your phone?',
      ),
      SpeakingSeed(
        'The bank is beside the market.',
        'ব্যাংকটি কোথায়?',
        question: 'Where is the bank?',
      ),
      SpeakingSeed('The cat is under the table.', 'ভুল বাক্যটি ঠিক করো: The cat is under of the table.'),
      SpeakingSeed('The bus stop is in front of the hospital.', 'কাউকে বাসস্টপের অবস্থান বলো।'),
      SpeakingSeed(
        'The keys are on the table beside the phone.',
        'চাবিগুলোর অবস্থান বিস্তারিত বলো।',
        question: 'Where are the keys?',
      ),
    ],
  );

  static final SpeakingRule _rule15 = SpeakingRuleFactory.create(
    id: 15,
    title: 'Question Words',
    explanation:
    'তথ্য জানতে What, Where, Who, When, Why এবং How দিয়ে প্রশ্ন শুরু করা হয়। প্রশ্নের ধরন অনুযায়ী সঠিক question word ব্যবহার করো।',
    formula: 'Question word + helping verb + subject + verb?',
    example: 'What do you do? Where do you live?',
    optionBuilder: _questionWordOptions,
    hintBuilder: (sentence) =>
    'কী জানতে চাওয়া হচ্ছে—ব্যক্তি, স্থান, সময়, কারণ নাকি পদ্ধতি—তা আগে বোঝো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('What is your name?', 'তোমার নাম কী?'),
      SpeakingSeed('Where do you live?', 'তুমি কোথায় থাকো?'),
      SpeakingSeed('Who is your teacher?', 'তোমার শিক্ষক কে?'),
      SpeakingSeed('When do you study English?', 'তুমি কখন ইংরেজি পড়ো?'),
      SpeakingSeed('Why are you learning English?', 'তুমি কেন ইংরেজি শিখছ?'),
      SpeakingSeed('How are you today?', 'আজ তুমি কেমন আছ?'),
      SpeakingSeed('What do you do?', 'তুমি কী কাজ করো?'),
      SpeakingSeed('Where is the nearest hospital?', 'সবচেয়ে কাছের হাসপাতাল কোথায়?'),
      SpeakingSeed('Who is calling me?', 'কে আমাকে ফোন করছে?'),
      SpeakingSeed('When does the class start?', 'ক্লাস কখন শুরু হয়?'),
      SpeakingSeed('Why is the shop closed?', 'দোকানটি কেন বন্ধ?'),
      SpeakingSeed('How do you go to work?', 'তুমি কীভাবে কাজে যাও?'),
      SpeakingSeed('What time is it?', 'এখন কয়টা বাজে?'),
      SpeakingSeed('Where can I buy a ticket?', 'আমি কোথায় টিকিট কিনতে পারি?'),
      SpeakingSeed('How much does this cost?', 'এটির দাম কত?'),
      SpeakingSeed(
        'I live in Bangladesh.',
        'Where do you live? প্রশ্নের উত্তর দাও।',
        question: 'Where do you live?',
      ),
      SpeakingSeed(
        'I study English in the evening.',
        'When do you study English? প্রশ্নের উত্তর দাও।',
        question: 'When do you study English?',
      ),
      SpeakingSeed('Where do you work?', 'ভুল প্রশ্নটি ঠিক করো: Where you work?'),
      SpeakingSeed('How can I get to the station?', 'অপরিচিত জায়গায় স্টেশনের পথ জিজ্ঞাসা করো।'),
      SpeakingSeed(
        'My name is Raj, and I live in Bangladesh.',
        'নাম ও ঠিকানা সম্পর্কে কথোপকথনের উত্তর দাও।',
        question: 'What is your name, and where do you live?',
      ),
    ],
  );

  static List<String> _singularPluralOptions(int practiceId, String correct) {
    var wrongOne = correct;
    var wrongTwo = correct;

    const replacements = <String, String>{
      'two books': 'two book',
      'two sisters': 'two sister',
      'four chairs': 'four chair',
      'The children are': 'The child are',
      'five mangoes': 'five mango',
      'Three buses are': 'Three bus is',
      'Those women are': 'That woman are',
      'two phones': 'two phone',
      'three people': 'three person',
      'two boxes': 'two box',
      'two tickets': 'two ticket',
      'one brother and two sisters': 'one brothers and two sister',
    };

    for (final entry in replacements.entries) {
      if (correct.contains(entry.key)) {
        wrongOne = correct.replaceFirst(entry.key, entry.value);
        break;
      }
    }

    if (wrongOne == correct) {
      wrongOne = correct.startsWith('This ')
          ? correct.replaceFirst('This ', 'These ')
          : 'One ${correct.toLowerCase()}';
    }

    wrongTwo = correct.startsWith('There is')
        ? correct.replaceFirst('There is', 'There are')
        : correct.startsWith('There are')
        ? correct.replaceFirst('There are', 'There is')
        : correct.startsWith('These are')
        ? correct.replaceFirst('These are', 'This is')
        : 'Many ${correct.toLowerCase()}';

    return SpeakingRuleFactory.arrangeOptions(
      practiceId: practiceId,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }

  static List<String> _possessiveOptions(int practiceId, String correct) {
    var wrongOne = correct;
    var wrongTwo = correct;

    if (correct.contains('My ') || correct.startsWith('My ')) {
      wrongOne = correct.replaceFirst('My ', 'His ');
      wrongTwo = correct.replaceFirst('My ', 'Your ');
    } else if (correct.contains('Your ') || correct.startsWith('Your ')) {
      wrongOne = correct.replaceFirst('Your ', 'Her ');
      wrongTwo = correct.replaceFirst('Your ', 'My ');
    } else if (correct.contains('His ') || correct.startsWith('His ')) {
      wrongOne = correct.replaceFirst('His ', 'Her ');
      wrongTwo = correct.replaceFirst('His ', 'My ');
    } else if (correct.contains('Her ') || correct.startsWith('Her ')) {
      wrongOne = correct.replaceFirst('Her ', 'His ');
      wrongTwo = correct.replaceFirst('Her ', 'Your ');
    } else if (correct.contains(' her ')) {
      wrongOne = correct.replaceFirst(' her ', ' his ');
      wrongTwo = correct.replaceFirst(' her ', ' your ');
    } else {
      wrongOne = 'His $correct';
      wrongTwo = 'Her $correct';
    }

    return SpeakingRuleFactory.arrangeOptions(
      practiceId: practiceId,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }

  static List<String> _canOptions(int practiceId, String correct) {
    final wrongOne = correct.contains(' cannot ')
        ? correct.replaceFirst(' cannot ', ' can not to ')
        : correct.replaceFirst(' can ', ' can to ');
    final wrongTwo = correct.contains(' cannot ')
        ? correct.replaceFirst(' cannot ', ' does not can ')
        : correct.replaceFirst(' can ', ' cans ');

    return SpeakingRuleFactory.arrangeOptions(
      practiceId: practiceId,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }

  static List<String> _prepositionOptions(int practiceId, String correct) {
    var wrongOne = correct;
    var wrongTwo = correct;

    const alternatives = <String, List<String>>{
      ' in front of ': <String>[' behind ', ' under '],
      ' between ': <String>[' beside ', ' on '],
      ' beside ': <String>[' between ', ' in '],
      ' behind ': <String>[' on ', ' in front of '],
      ' under ': <String>[' on ', ' beside '],
      ' on ': <String>[' in ', ' under '],
      ' in ': <String>[' on ', ' behind '],
    };

    for (final entry in alternatives.entries) {
      if (correct.contains(entry.key)) {
        wrongOne = correct.replaceFirst(entry.key, entry.value[0]);
        wrongTwo = correct.replaceFirst(entry.key, entry.value[1]);
        break;
      }
    }

    if (wrongOne == correct) {
      wrongOne = 'On $correct';
      wrongTwo = 'Under $correct';
    }

    return SpeakingRuleFactory.arrangeOptions(
      practiceId: practiceId,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }

  static List<String> _questionWordOptions(int practiceId, String correct) {
    final words = <String>['What', 'Where', 'Who', 'When', 'Why', 'How'];
    final current = words.firstWhere(
      correct.startsWith,
      orElse: () => 'What',
    );
    final alternatives = words.where((word) => word != current).toList();
    final wrongOne = correct.replaceFirst(current, alternatives[practiceId % alternatives.length]);
    final wrongTwo = correct.replaceFirst(
      current,
      alternatives[(practiceId + 2) % alternatives.length],
    );

    return SpeakingRuleFactory.arrangeOptions(
      practiceId: practiceId,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }
}