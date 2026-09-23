import '../../models/speaking_rule_model.dart';
import 'speaking_rule_factory.dart';

class SpeakingRules51To55 {
  SpeakingRules51To55._();

  static final List<SpeakingRule> rules = <SpeakingRule>[
    _rule51, _rule52, _rule53, _rule54, _rule55,
  ];

  static final SpeakingRule _rule51 = SpeakingRuleFactory.create(
    id: 51,
    title: 'Question Tags',
    explanation:
    'বক্তব্য নিশ্চিত করতে বাক্যের শেষে ছোট প্রশ্ন যোগ করা হয়। Positive statement-এর পরে negative tag এবং negative statement-এর পরে positive tag বসে।',
    formula: 'Positive statement + negative tag? • Negative statement + positive tag?',
    example: 'You are ready, aren’t you?',
    optionBuilder: _tagOptions,
    hintBuilder: (_) => 'Main sentence positive হলে tag negative, আর main sentence negative হলে tag positive করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('You are ready, aren’t you?', 'তুমি প্রস্তুত, তাই না?'),
      SpeakingSeed('She is a teacher, isn’t she?', 'সে একজন teacher, তাই না?'),
      SpeakingSeed('They live here, don’t they?', 'তারা এখানে থাকে, তাই না?'),
      SpeakingSeed('He works hard, doesn’t he?', 'সে কঠোর পরিশ্রম করে, তাই না?'),
      SpeakingSeed('We can start now, can’t we?', 'আমরা এখন শুরু করতে পারি, তাই না?'),
      SpeakingSeed('You called me, didn’t you?', 'তুমি আমাকে call করেছিলে, তাই না?'),
      SpeakingSeed('It is raining, isn’t it?', 'বৃষ্টি হচ্ছে, তাই না?'),
      SpeakingSeed('She has finished, hasn’t she?', 'সে শেষ করেছে, তাই না?'),
      SpeakingSeed('They will come, won’t they?', 'তারা আসবে, তাই না?'),
      SpeakingSeed('He was tired, wasn’t he?', 'সে ক্লান্ত ছিল, তাই না?'),
      SpeakingSeed('You do not smoke, do you?', 'তুমি ধূমপান করো না, তাই তো?'),
      SpeakingSeed('She cannot drive, can she?', 'সে গাড়ি চালাতে পারে না, তাই তো?'),
      SpeakingSeed('We are not late, are we?', 'আমরা দেরি করিনি, তাই তো?'),
      SpeakingSeed('He did not call, did he?', 'সে call করেনি, তাই তো?'),
      SpeakingSeed('The room is clean, isn’t it?', 'Room-টি পরিষ্কার, তাই না?'),
      SpeakingSeed('You speak English, don’t you?', 'তুমি English বলো, তাই না?', question: 'You speak English, don’t you?'),
      SpeakingSeed('Yes, she does.', 'সে প্রতিদিন practice করে, তাই না?', question: 'She practices every day, doesn’t she?'),
      SpeakingSeed('He is busy, isn’t he?', 'ভুল বাক্যটি ঠিক করো: He is busy, doesn’t he?'),
      SpeakingSeed('This is your bag, isn’t it?', 'Bag-এর মালিক নিশ্চিত করো।'),
      SpeakingSeed('You have practiced a lot, haven’t you?', 'Learner-এর practice নিশ্চিত করো।', question: 'How would you confirm the learner has practiced?'),
    ],
  );

  static final SpeakingRule _rule52 = SpeakingRuleFactory.create(
    id: 52,
    title: 'Either & Neither',
    explanation:
    'দুটি বিকল্পের যেকোনো একটি বোঝাতে either এবং দুটির কোনোটিই নয় বোঝাতে neither ব্যবহার হয়।',
    formula: 'either A or B • neither A nor B',
    example: 'You can choose either tea or coffee.',
    optionBuilder: _eitherNeitherOptions,
    hintBuilder: (_) => 'Either-এর সঙ্গে or এবং neither-এর সঙ্গে nor ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('You can choose either tea or coffee.', 'তুমি tea অথবা coffee যেকোনো একটি নিতে পারো।'),
      SpeakingSeed('Neither answer is correct.', 'কোনো উত্তরই সঠিক নয়।'),
      SpeakingSeed('Either day is fine for me.', 'যেকোনো দিন আমার জন্য ঠিক আছে।'),
      SpeakingSeed('Neither bus goes to Dhaka.', 'কোনো bus-ই Dhaka যায় না।'),
      SpeakingSeed('We can meet either today or tomorrow.', 'আমরা আজ অথবা আগামীকাল দেখা করতে পারি।'),
      SpeakingSeed('Neither Rahim nor Karim is here.', 'Rahim ও Karim কেউই এখানে নেই।'),
      SpeakingSeed('You may sit on either side.', 'তুমি যেকোনো পাশে বসতে পারো।'),
      SpeakingSeed('Neither option is cheap.', 'কোনো option-ই সস্তা নয়।'),
      SpeakingSeed('I can pay either by cash or by card.', 'আমি cash অথবা card দিয়ে payment করতে পারি।'),
      SpeakingSeed('Neither of us knew the answer.', 'আমাদের কেউই উত্তর জানতাম না।'),
      SpeakingSeed('Either route will take an hour.', 'যেকোনো route-এ এক ঘণ্টা লাগবে।'),
      SpeakingSeed('She speaks neither English nor Hindi.', 'সে English বা Hindi কোনোটিই বলে না।'),
      SpeakingSeed('You can call either me or my brother.', 'তুমি আমাকে অথবা আমার ভাইকে call করতে পারো।'),
      SpeakingSeed('Neither room has a balcony.', 'কোনো room-এই balcony নেই।'),
      SpeakingSeed('Either plan can work.', 'যেকোনো plan কাজ করতে পারে।'),
      SpeakingSeed('I can come either today or tomorrow.', 'তুমি কোন দিন আসতে পারো?', question: 'Can you come today or tomorrow?'),
      SpeakingSeed('Neither one is suitable.', 'কোন option উপযুক্ত?', question: 'Which option is suitable?'),
      SpeakingSeed('Neither tea nor coffee is available.', 'ভুল বাক্যটি ঠিক করো: Neither tea or coffee is available.'),
      SpeakingSeed('You can choose either a single room or a double room.', 'Guest-কে দুটি room option দাও।'),
      SpeakingSeed('I speak neither fluently nor quickly yet, but either skill can improve with practice.', 'নিজের দুটি speaking skill নিয়ে বলো।', question: 'Which speaking skill do you want to improve?'),
    ],
  );

  static final SpeakingRule _rule53 = SpeakingRuleFactory.create(
    id: 53,
    title: 'Too & Enough',
    explanation:
    'প্রয়োজনের চেয়ে বেশি বোঝাতে too এবং প্রয়োজন অনুযায়ী যথেষ্ট বোঝাতে enough ব্যবহার হয়। adjective-এর আগে too এবং adjective-এর পরে enough বসে।',
    formula: 'too + adjective • adjective + enough • enough + noun',
    example: 'It is too expensive. It is cheap enough.',
    optionBuilder: _tooEnoughOptions,
    hintBuilder: (_) => 'Too adjective-এর আগে; enough adjective-এর পরে বা noun-এর আগে বসে।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('This phone is too expensive.', 'এই phone-টি অতিরিক্ত দামি।'),
      SpeakingSeed('The room is big enough.', 'Room-টি যথেষ্ট বড়।'),
      SpeakingSeed('It is too hot outside.', 'বাইরে অতিরিক্ত গরম।'),
      SpeakingSeed('We have enough time.', 'আমাদের যথেষ্ট সময় আছে।'),
      SpeakingSeed('The bag is too heavy.', 'Bag-টি অতিরিক্ত ভারী।'),
      SpeakingSeed('She is old enough to drive.', 'সে drive করার জন্য যথেষ্ট বড়।'),
      SpeakingSeed('The music is too loud.', 'Music অতিরিক্ত জোরে।'),
      SpeakingSeed('I do not have enough money.', 'আমার যথেষ্ট টাকা নেই।'),
      SpeakingSeed('He speaks too fast.', 'সে অতিরিক্ত দ্রুত কথা বলে।'),
      SpeakingSeed('This water is warm enough.', 'এই পানি যথেষ্ট উষ্ণ।'),
      SpeakingSeed('The box is too small.', 'Box-টি অতিরিক্ত ছোট।'),
      SpeakingSeed('There are enough chairs.', 'যথেষ্ট chair আছে।'),
      SpeakingSeed('I am too tired to work.', 'আমি কাজ করার জন্য অতিরিক্ত ক্লান্ত।'),
      SpeakingSeed('Your English is good enough.', 'তোমার English যথেষ্ট ভালো।'),
      SpeakingSeed('The bus is too crowded.', 'Bus-টি অতিরিক্ত ভিড়।'),
      SpeakingSeed('I have enough time to practice.', 'তোমার কি practice-এর জন্য যথেষ্ট সময় আছে?', question: 'Do you have enough time to practice?'),
      SpeakingSeed('It is too expensive for me.', 'কেন এটি কিনবে না?', question: 'Why will you not buy it?'),
      SpeakingSeed('The room is large enough.', 'ভুল বাক্যটি ঠিক করো: The room is enough large.'),
      SpeakingSeed('This room is too noisy; I need a quiet enough room.', 'Hotel staff-কে room-এর সমস্যা বলো।'),
      SpeakingSeed('I am not fluent enough yet, so I practice instead of speaking too quickly.', 'নিজের fluency সম্পর্কে বলো।', question: 'Are you fluent enough yet?'),
    ],
  );

  static final SpeakingRule _rule54 = SpeakingRuleFactory.create(
    id: 54,
    title: 'Gerunds & Infinitives',
    explanation:
    'কিছু verb-এর পরে verb+ing এবং কিছু verb-এর পরে to + base verb বসে। যেমন enjoy learning, want to learn।',
    formula: 'verb + gerund (-ing) • verb + to-infinitive',
    example: 'I enjoy reading. I want to learn.',
    optionBuilder: _gerundOptions,
    hintBuilder: (_) => 'Main verb অনুযায়ী পরের verb-এ ing অথবা to + base form ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I enjoy reading English books.', 'আমি English book পড়া উপভোগ করি।'),
      SpeakingSeed('I want to learn English.', 'আমি English শিখতে চাই।'),
      SpeakingSeed('She likes cooking.', 'সে রান্না করতে পছন্দ করে।'),
      SpeakingSeed('He decided to study harder.', 'সে আরও মন দিয়ে পড়ার সিদ্ধান্ত নিয়েছে।'),
      SpeakingSeed('We love traveling.', 'আমরা travel করতে ভালোবাসি।'),
      SpeakingSeed('They plan to visit Dhaka.', 'তারা Dhaka ভ্রমণের plan করেছে।'),
      SpeakingSeed('I finished writing the email.', 'আমি email লেখা শেষ করেছি।'),
      SpeakingSeed('She hopes to get a good job.', 'সে ভালো job পাওয়ার আশা করে।'),
      SpeakingSeed('He avoids making mistakes.', 'সে ভুল করা এড়িয়ে চলে।'),
      SpeakingSeed('We need to leave now.', 'আমাদের এখন যেতে হবে।'),
      SpeakingSeed('I keep practicing every day.', 'আমি প্রতিদিন practice চালিয়ে যাই।'),
      SpeakingSeed('She wants to speak fluently.', 'সে fluently বলতে চায়।'),
      SpeakingSeed('He stopped smoking.', 'সে ধূমপান বন্ধ করেছে।'),
      SpeakingSeed('They agreed to help us.', 'তারা আমাদের সাহায্য করতে রাজি হয়েছে।'),
      SpeakingSeed('I prefer working at home.', 'আমি বাসায় কাজ করতে বেশি পছন্দ করি।'),
      SpeakingSeed('I enjoy learning new words.', 'তুমি কী করতে উপভোগ করো?', question: 'What do you enjoy doing?'),
      SpeakingSeed('I want to improve my speaking.', 'তুমি কী উন্নত করতে চাও?', question: 'What do you want to improve?'),
      SpeakingSeed('She enjoys reading.', 'ভুল বাক্যটি ঠিক করো: She enjoys to read.'),
      SpeakingSeed('I would like to book a room.', 'Hotel-এ নিজের ইচ্ছা বলো।'),
      SpeakingSeed('I enjoy practicing, and I want to speak English confidently.', 'পছন্দ ও goal একসঙ্গে বলো।', question: 'What do you enjoy and want to achieve?'),
    ],
  );

  static final SpeakingRule _rule55 = SpeakingRuleFactory.create(
    id: 55,
    title: 'Who, Which & That',
    explanation:
    'ব্যক্তি সম্পর্কে অতিরিক্ত তথ্য দিতে who এবং জিনিসের জন্য which বা that ব্যবহার করে relative clause তৈরি হয়।',
    formula: 'person + who + clause • thing + which/that + clause',
    example: 'The man who called me is my teacher.',
    optionBuilder: _relativeOptions,
    hintBuilder: (_) => 'ব্যক্তির জন্য who; জিনিসের জন্য which বা that ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('The man who called me is my teacher.', 'যে মানুষটি আমাকে call করেছিলেন তিনি আমার teacher।'),
      SpeakingSeed('This is the phone that I bought.', 'এটি সেই phone যা আমি কিনেছি।'),
      SpeakingSeed('The app which I use is helpful.', 'আমি যে app ব্যবহার করি সেটি helpful।'),
      SpeakingSeed('The woman who lives next door is a doctor.', 'পাশের বাসায় থাকা নারী একজন doctor।'),
      SpeakingSeed('The book that you gave me is interesting.', 'তুমি যে book দিয়েছিলে সেটি interesting।'),
      SpeakingSeed('The bus which goes to Dhaka is late.', 'Dhaka যাওয়ার bus-টি দেরি করছে।'),
      SpeakingSeed('The student who answered is my friend.', 'যে student উত্তর দিয়েছে সে আমার বন্ধু।'),
      SpeakingSeed('The food that she cooked was delicious.', 'সে যে খাবার রান্না করেছিল তা সুস্বাদু ছিল।'),
      SpeakingSeed('The laptop which I use is old.', 'আমি যে laptop ব্যবহার করি সেটি পুরোনো।'),
      SpeakingSeed('The person who helped me was kind.', 'যে ব্যক্তি আমাকে সাহায্য করেছিল সে দয়ালু ছিল।'),
      SpeakingSeed('This is the room that we booked.', 'এটি সেই room যা আমরা book করেছি।'),
      SpeakingSeed('The movie which we watched was funny.', 'আমরা যে movie দেখেছিলাম সেটি মজার ছিল।'),
      SpeakingSeed('The teacher who teaches us speaks clearly.', 'যে teacher আমাদের পড়ান তিনি স্পষ্ট বলেন।'),
      SpeakingSeed('The message that he sent was important.', 'সে যে message পাঠিয়েছিল তা গুরুত্বপূর্ণ ছিল।'),
      SpeakingSeed('The language which I am learning is English.', 'আমি যে ভাষা শিখছি তা English।'),
      SpeakingSeed('The person who inspires me is my father.', 'কে তোমাকে inspire করে?', question: 'Who is the person who inspires you?'),
      SpeakingSeed('The app that I use is SpeakEnglish.', 'তুমি কোন learning app ব্যবহার করো?', question: 'Which app do you use for learning?'),
      SpeakingSeed('The woman who called is my manager.', 'ভুল বাক্যটি ঠিক করো: The woman which called is my manager.'),
      SpeakingSeed('The room that I booked has a problem.', 'Hotel staff-কে নির্দিষ্ট room-এর সমস্যা বলো।'),
      SpeakingSeed('The lessons that I practice and the teacher who guides me help me improve.', 'তোমাকে উন্নতি করতে কারা বা কী সাহায্য করে?', question: 'What helps you improve your English?'),
    ],
  );

  static List<String> _tagOptions(int id, String correct) {
    final wrongOne = correct.replaceFirst(RegExp(r", [^,]+\?$"), ', is it?');
    final wrongTwo = correct.replaceFirst(RegExp(r", [^,]+\?$"), ', yes?');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _eitherNeitherOptions(int id, String correct) {
    final wrongOne = correct.replaceFirst(' either ', ' neither ').replaceFirst(' or ', ' nor ');
    final wrongTwo = correct.replaceFirst(' neither ', ' either ').replaceFirst(' nor ', ' or ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _tooEnoughOptions(int id, String correct) {
    final wrongOne = correct.replaceFirst(' too ', ' enough ');
    final wrongTwo = correct.replaceFirst(' enough ', ' too ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _gerundOptions(int id, String correct) {
    final wrongOne = correct.replaceFirst(RegExp(r'\b(enjoy|like|love) '), 'want ');
    final wrongTwo = correct.replaceFirst(' to ', ' for ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _relativeOptions(int id, String correct) {
    final wrongOne = correct.contains(' who ')
        ? correct.replaceFirst(' who ', ' which ')
        : correct.replaceFirst(RegExp(r'\b(which|that)\b'), 'who');
    final wrongTwo = correct.replaceFirst(RegExp(r'\b(who|which|that)\b'), 'where');
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
