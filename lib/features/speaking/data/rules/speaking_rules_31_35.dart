import '../../models/speaking_rule_model.dart';
import 'speaking_rule_factory.dart';

class SpeakingRules31To35 {
  SpeakingRules31To35._();

  static final List<SpeakingRule> rules = <SpeakingRule>[
    _rule31, _rule32, _rule33, _rule34, _rule35,
  ];

  static final SpeakingRule _rule31 = SpeakingRuleFactory.create(
    id: 31,
    title: 'Countable & Uncountable Nouns',
    explanation:
    'যেসব noun সংখ্যা দিয়ে গোনা যায় সেগুলো countable; water, rice, information-এর মতো যেগুলো সরাসরি গোনা যায় না সেগুলো uncountable।',
    formula: 'a/an/numbers + countable • some + uncountable',
    example: 'I have two apples. I need some water.',
    optionBuilder: _countableOptions,
    hintBuilder: (_) => 'Noun-টি সরাসরি গোনা যায় কি না আগে চিন্তা করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I have two apples.', 'আমার দুটি আপেল আছে।'),
      SpeakingSeed('I need some water.', 'আমার কিছু পানি প্রয়োজন।'),
      SpeakingSeed('There are three chairs.', 'সেখানে তিনটি চেয়ার আছে।'),
      SpeakingSeed('We need some rice.', 'আমাদের কিছু চাল প্রয়োজন।'),
      SpeakingSeed('She bought four books.', 'সে চারটি বই কিনেছে।'),
      SpeakingSeed('Please give me some information.', 'দয়া করে আমাকে কিছু তথ্য দিন।'),
      SpeakingSeed('I ate an egg.', 'আমি একটি ডিম খেয়েছি।'),
      SpeakingSeed('There is some milk in the glass.', 'গ্লাসে কিছু দুধ আছে।'),
      SpeakingSeed('He has two bags.', 'তার দুটি ব্যাগ আছে।'),
      SpeakingSeed('We need some sugar.', 'আমাদের কিছু চিনি প্রয়োজন।'),
      SpeakingSeed('Five students are waiting.', 'পাঁচজন শিক্ষার্থী অপেক্ষা করছে।'),
      SpeakingSeed('She gave me some advice.', 'সে আমাকে কিছু পরামর্শ দিয়েছে।'),
      SpeakingSeed('I bought three bananas.', 'আমি তিনটি কলা কিনেছি।'),
      SpeakingSeed('There is some traffic today.', 'আজ কিছু traffic আছে।'),
      SpeakingSeed('He has a new idea.', 'তার একটি নতুন idea আছে।'),
      SpeakingSeed('I need two bottles of water.', 'তোমার কত bottle পানি প্রয়োজন?', question: 'How many bottles of water do you need?'),
      SpeakingSeed('I bought three oranges.', 'তুমি কয়টি কমলা কিনেছ?', question: 'How many oranges did you buy?'),
      SpeakingSeed('I need some information.', 'ভুল বাক্যটি ঠিক করো: I need an information.'),
      SpeakingSeed('I would like a cup of tea.', 'দোকানে এক cup চা চাও।'),
      SpeakingSeed('I need two eggs and some bread.', 'সকালের খাবারের জন্য প্রয়োজনীয় জিনিস বলো।', question: 'What do you need for breakfast?'),
    ],
  );

  static final SpeakingRule _rule32 = SpeakingRuleFactory.create(
    id: 32,
    title: 'Some & Any',
    explanation:
    'Positive বাক্যে সাধারণত some এবং question বা negative বাক্যে any ব্যবহার হয়। ভদ্র offer/request-এও some ব্যবহার হতে পারে।',
    formula: 'Positive: some • Question/Negative: any',
    example: 'I have some money. Do you have any money?',
    optionBuilder: _someAnyOptions,
    hintBuilder: (_) => 'Positive হলে some; question বা negative হলে সাধারণত any ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I have some money.', 'আমার কিছু টাকা আছে।'),
      SpeakingSeed('Do you have any money?', 'তোমার কি কোনো টাকা আছে?'),
      SpeakingSeed('She bought some vegetables.', 'সে কিছু সবজি কিনেছে।'),
      SpeakingSeed('We do not have any milk.', 'আমাদের কোনো দুধ নেই।'),
      SpeakingSeed('There are some books on the table.', 'টেবিলে কিছু বই আছে।'),
      SpeakingSeed('Are there any shops nearby?', 'কাছাকাছি কোনো দোকান আছে কি?'),
      SpeakingSeed('I need some help.', 'আমার কিছু সাহায্য প্রয়োজন।'),
      SpeakingSeed('He does not have any friends here.', 'এখানে তার কোনো বন্ধু নেই।'),
      SpeakingSeed('Please give me some water.', 'দয়া করে আমাকে কিছু পানি দিন।'),
      SpeakingSeed('Did you buy any fruit?', 'তুমি কি কোনো ফল কিনেছ?'),
      SpeakingSeed('We have some free time.', 'আমাদের কিছু অবসর সময় আছে।'),
      SpeakingSeed('I cannot find any information.', 'আমি কোনো তথ্য খুঁজে পাচ্ছি না।'),
      SpeakingSeed('She has some questions.', 'তার কিছু প্রশ্ন আছে।'),
      SpeakingSeed('There is not any sugar.', 'কোনো চিনি নেই।'),
      SpeakingSeed('Would you like some tea?', 'তুমি কি কিছু চা চাইবে?'),
      SpeakingSeed('Yes, I need some help.', 'তোমার কি কোনো সাহায্য প্রয়োজন?', question: 'Do you need any help?'),
      SpeakingSeed('No, I do not have any questions.', 'তোমার কি কোনো প্রশ্ন আছে?', question: 'Do you have any questions?'),
      SpeakingSeed('I do not have any money.', 'ভুল বাক্যটি ঠিক করো: I do not have some money.'),
      SpeakingSeed('Could I have some water, please?', 'Restaurant-এ পানি চাও।'),
      SpeakingSeed('I have some rice, but I do not have any vegetables.', 'তোমার কাছে কী আছে এবং কী নেই বলো।', question: 'What food do you have at home?'),
    ],
  );

  static final SpeakingRule _rule33 = SpeakingRuleFactory.create(
    id: 33,
    title: 'Much & Many',
    explanation:
    'Countable plural noun-এর সঙ্গে many এবং uncountable noun-এর সঙ্গে much ব্যবহার হয়। এগুলো question ও negative বাক্যে বেশি ব্যবহৃত হয়।',
    formula: 'many + plural countable • much + uncountable',
    example: 'How many books? How much water?',
    optionBuilder: _muchManyOptions,
    hintBuilder: (_) => 'গোনা যায় এমন plural noun-এ many; গোনা যায় না এমন noun-এ much ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I have many books.', 'আমার অনেক বই আছে।'),
      SpeakingSeed('We do not have much time.', 'আমাদের বেশি সময় নেই।'),
      SpeakingSeed('There are many people here.', 'এখানে অনেক মানুষ আছে।'),
      SpeakingSeed('She does not drink much water.', 'সে বেশি পানি পান করে না।'),
      SpeakingSeed('How many students are there?', 'সেখানে কতজন student আছে?'),
      SpeakingSeed('How much money do you need?', 'তোমার কত টাকা প্রয়োজন?'),
      SpeakingSeed('He has many friends.', 'তার অনেক বন্ধু আছে।'),
      SpeakingSeed('I do not eat much rice.', 'আমি বেশি ভাত খাই না।'),
      SpeakingSeed('We visited many places.', 'আমরা অনেক জায়গা ভ্রমণ করেছি।'),
      SpeakingSeed('There is not much traffic today.', 'আজ বেশি traffic নেই।'),
      SpeakingSeed('She asked many questions.', 'সে অনেক প্রশ্ন করেছে।'),
      SpeakingSeed('I do not have much experience.', 'আমার বেশি অভিজ্ঞতা নেই।'),
      SpeakingSeed('Many shops are closed.', 'অনেক দোকান বন্ধ।'),
      SpeakingSeed('He does not spend much money.', 'সে বেশি টাকা খরচ করে না।'),
      SpeakingSeed('We have many opportunities.', 'আমাদের অনেক সুযোগ আছে।'),
      SpeakingSeed('I have many English books.', 'তোমার কতগুলো English book আছে?', question: 'How many English books do you have?'),
      SpeakingSeed('I do not have much free time.', 'তোমার কি অনেক free time আছে?', question: 'Do you have much free time?'),
      SpeakingSeed('There are many people here.', 'ভুল বাক্যটি ঠিক করো: There are much people here.'),
      SpeakingSeed('How much luggage do you have?', 'Airport-এ luggage-এর পরিমাণ জিজ্ঞাসা করো।'),
      SpeakingSeed('I have many tasks, but I do not have much time.', 'আজকের কাজ ও সময় সম্পর্কে বলো।', question: 'How busy are you today?'),
    ],
  );

  static final SpeakingRule _rule34 = SpeakingRuleFactory.create(
    id: 34,
    title: 'A Few & A Little',
    explanation:
    'অল্প কিন্তু কিছু আছে বোঝাতে countable plural-এর সঙ্গে a few এবং uncountable noun-এর সঙ্গে a little ব্যবহার হয়।',
    formula: 'a few + plural countable • a little + uncountable',
    example: 'I have a few friends. I need a little water.',
    optionBuilder: _fewLittleOptions,
    hintBuilder: (_) => 'গোনা যায় এমন plural noun-এ a few; uncountable noun-এ a little ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I have a few friends.', 'আমার কয়েকজন বন্ধু আছে।'),
      SpeakingSeed('I need a little water.', 'আমার অল্প পানি প্রয়োজন।'),
      SpeakingSeed('She bought a few apples.', 'সে কয়েকটি আপেল কিনেছে।'),
      SpeakingSeed('We have a little time.', 'আমাদের অল্প সময় আছে।'),
      SpeakingSeed('There are a few chairs.', 'সেখানে কয়েকটি চেয়ার আছে।'),
      SpeakingSeed('Add a little sugar.', 'অল্প চিনি যোগ করো।'),
      SpeakingSeed('He knows a few English words.', 'সে কয়েকটি English word জানে।'),
      SpeakingSeed('I need a little help.', 'আমার অল্প সাহায্য প্রয়োজন।'),
      SpeakingSeed('We visited a few places.', 'আমরা কয়েকটি জায়গা ভ্রমণ করেছি।'),
      SpeakingSeed('She speaks a little English.', 'সে অল্প English বলতে পারে।'),
      SpeakingSeed('I asked a few questions.', 'আমি কয়েকটি প্রশ্ন করেছি।'),
      SpeakingSeed('There is a little milk left.', 'অল্প দুধ বাকি আছে।'),
      SpeakingSeed('He has a few minutes.', 'তার কয়েক মিনিট সময় আছে।'),
      SpeakingSeed('Please wait a little longer.', 'দয়া করে আরেকটু অপেক্ষা করো।'),
      SpeakingSeed('I made a few mistakes.', 'আমি কয়েকটি ভুল করেছি।'),
      SpeakingSeed('I have a few books.', 'তোমার কি কয়েকটি বই আছে?', question: 'Do you have a few books?'),
      SpeakingSeed('Yes, I speak a little English.', 'তুমি কি অল্প English বলতে পারো?', question: 'Can you speak a little English?'),
      SpeakingSeed('I need a little water.', 'ভুল বাক্যটি ঠিক করো: I need a few water.'),
      SpeakingSeed('Please give me a little rice.', 'খাবার পরিবেশনের সময় অল্প ভাত চাও।'),
      SpeakingSeed('I know a few words, so I can speak a little English.', 'নিজের বর্তমান English skill বলো।', question: 'How much English can you speak?'),
    ],
  );

  static final SpeakingRule _rule35 = SpeakingRuleFactory.create(
    id: 35,
    title: 'How Much & How Many',
    explanation:
    'Countable plural-এর পরিমাণ জানতে How many এবং uncountable noun-এর পরিমাণ বা দাম জানতে How much ব্যবহার হয়।',
    formula: 'How many + plural noun • How much + uncountable noun',
    example: 'How many books? How much water?',
    optionBuilder: _howMuchManyOptions,
    hintBuilder: (_) => 'Noun গোনা গেলে How many; না গেলে How much ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('How many books do you have?', 'তোমার কয়টি বই আছে?'),
      SpeakingSeed('How much water do you drink?', 'তুমি কতটা পানি পান করো?'),
      SpeakingSeed('How many people are there?', 'সেখানে কতজন মানুষ আছে?'),
      SpeakingSeed('How much money do you need?', 'তোমার কত টাকা প্রয়োজন?'),
      SpeakingSeed('How many languages can you speak?', 'তুমি কয়টি ভাষা বলতে পারো?'),
      SpeakingSeed('How much rice should I cook?', 'আমার কতটা ভাত রান্না করা উচিত?'),
      SpeakingSeed('How many chairs do we need?', 'আমাদের কয়টি চেয়ার প্রয়োজন?'),
      SpeakingSeed('How much time do we have?', 'আমাদের কত সময় আছে?'),
      SpeakingSeed('How many brothers do you have?', 'তোমার কয়জন ভাই আছে?'),
      SpeakingSeed('How much does this phone cost?', 'এই phone-এর দাম কত?'),
      SpeakingSeed('How many days will you stay?', 'তুমি কতদিন থাকবে?'),
      SpeakingSeed('How much milk is left?', 'কতটা দুধ বাকি আছে?'),
      SpeakingSeed('How many tickets did you buy?', 'তুমি কয়টি ticket কিনেছ?'),
      SpeakingSeed('How much work is left?', 'কতটা কাজ বাকি আছে?'),
      SpeakingSeed('How many questions are there?', 'কয়টি প্রশ্ন আছে?'),
      SpeakingSeed('I have three books.', 'How many books do you have? প্রশ্নের উত্তর দাও।', question: 'How many books do you have?'),
      SpeakingSeed('I need a little water.', 'How much water do you need? প্রশ্নের উত্তর দাও।', question: 'How much water do you need?'),
      SpeakingSeed('How many students are there?', 'ভুল প্রশ্নটি ঠিক করো: How much students are there?'),
      SpeakingSeed('How much does this ticket cost?', 'Counter-এ ticket-এর দাম জিজ্ঞাসা করো।'),
      SpeakingSeed('I need two tickets and a little information.', 'Ticket ও information-এর পরিমাণ নিয়ে উত্তর দাও।', question: 'How many tickets and how much information do you need?'),
    ],
  );

  static List<String> _countableOptions(int id, String correct) {
    final wrongOne = correct
        .replaceFirst('some water', 'a water')
        .replaceFirst('some rice', 'a rice')
        .replaceFirst('some information', 'an information')
        .replaceFirst('some milk', 'a milk')
        .replaceFirst('some sugar', 'a sugar')
        .replaceFirst('some advice', 'an advice');
    final wrongTwo = correct.replaceFirst(RegExp(r'\b(two|three|four|five)\b'), 'much');
    return _options(id, correct, wrongOne == correct ? 'A $correct' : wrongOne, wrongTwo == correct ? 'Much $correct' : wrongTwo);
  }

  static List<String> _someAnyOptions(int id, String correct) {
    final wrongOne = correct.contains(' some ')
        ? correct.replaceFirst(' some ', ' any ')
        : correct.replaceFirst(' any ', ' some ');
    final wrongTwo = correct.replaceFirst(RegExp(r'\b(some|any)\b'), 'many');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _muchManyOptions(int id, String correct) {
    final wrongOne = correct.contains(' many ')
        ? correct.replaceFirst(' many ', ' much ')
        : correct.replaceFirst(' much ', ' many ');
    final wrongTwo = correct.replaceFirst(RegExp(r'\b(much|many)\b'), 'a');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _fewLittleOptions(int id, String correct) {
    final wrongOne = correct.contains(' a few ')
        ? correct.replaceFirst(' a few ', ' a little ')
        : correct.replaceFirst(' a little ', ' a few ');
    final wrongTwo = correct.replaceFirst(RegExp(r'\ba (few|little)\b'), 'many');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _howMuchManyOptions(int id, String correct) {
    final wrongOne = correct.startsWith('How many')
        ? correct.replaceFirst('How many', 'How much')
        : correct.replaceFirst('How much', 'How many');
    final wrongTwo = correct.replaceFirst(RegExp(r'^How (many|much)'), 'What many');
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
