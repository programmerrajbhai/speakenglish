
import '../../models/speaking_rule_model.dart';
import 'speaking_rule_factory.dart';

class SpeakingRules41To45 {
  SpeakingRules41To45._();

  static final List<SpeakingRule> rules = <SpeakingRule>[
    _rule41, _rule42, _rule43, _rule44, _rule45,
  ];

  static final SpeakingRule _rule41 = SpeakingRuleFactory.create(
    id: 41,
    title: 'And, But & Or',
    explanation:
    'একই ধরনের তথ্য যোগ করতে and, বিপরীত তথ্য যুক্ত করতে but এবং বিকল্প বোঝাতে or ব্যবহার হয়।',
    formula: 'idea + and/but/or + idea',
    example: 'I read and write. I try, but I make mistakes.',
    optionBuilder: _andButOrOptions,
    hintBuilder: (_) => 'যোগ হলে and, বিপরীত হলে but, আর বিকল্প হলে or ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I read and write English.', 'আমি English পড়ি এবং লিখি।'),
      SpeakingSeed('I try, but I make mistakes.', 'আমি চেষ্টা করি, কিন্তু ভুল করি।'),
      SpeakingSeed('Would you like tea or coffee?', 'তুমি চা নাকি coffee চাইবে?'),
      SpeakingSeed('She sings and dances.', 'সে গান গায় এবং নাচে।'),
      SpeakingSeed('He is tired, but he is working.', 'সে ক্লান্ত, কিন্তু কাজ করছে।'),
      SpeakingSeed('You can call or message me.', 'তুমি আমাকে call অথবা message করতে পারো।'),
      SpeakingSeed('We studied and practiced together.', 'আমরা একসঙ্গে পড়েছি এবং practice করেছি।'),
      SpeakingSeed('The room is small but comfortable.', 'Room-টি ছোট কিন্তু আরামদায়ক।'),
      SpeakingSeed('Do you want rice or bread?', 'তুমি ভাত নাকি bread চাও?'),
      SpeakingSeed('I opened the app and started learning.', 'আমি app খুলে শেখা শুরু করেছি।'),
      SpeakingSeed('She is young but very experienced.', 'সে তরুণ কিন্তু অনেক অভিজ্ঞ।'),
      SpeakingSeed('We can go today or tomorrow.', 'আমরা আজ অথবা আগামীকাল যেতে পারি।'),
      SpeakingSeed('He bought a phone and a laptop.', 'সে একটি phone এবং laptop কিনেছে।'),
      SpeakingSeed('I understand English, but I speak slowly.', 'আমি English বুঝি, কিন্তু ধীরে বলি।'),
      SpeakingSeed('You may sit here or outside.', 'তুমি এখানে অথবা বাইরে বসতে পারো।'),
      SpeakingSeed('I work and study every day.', 'তুমি প্রতিদিন কী কী করো?', question: 'What do you do every day?'),
      SpeakingSeed('I like tea, but I do not like coffee.', 'তোমার পছন্দ ও অপছন্দ কী?', question: 'What do you like and dislike?'),
      SpeakingSeed('She reads and writes.', 'ভুল বাক্যটি ঠিক করো: She reads but writes.'),
      SpeakingSeed('Would you like cash or card payment?', 'Customer-কে payment option জিজ্ঞাসা করো।'),
      SpeakingSeed('I can read and write, but I need more speaking practice.', 'নিজের English skill ব্যাখ্যা করো।', question: 'What can you do in English?'),
    ],
  );

  static final SpeakingRule _rule42 = SpeakingRuleFactory.create(
    id: 42,
    title: 'Because & So',
    explanation:
    'কোনো কাজের কারণ বলতে because এবং কারণের ফলাফল বলতে so ব্যবহার হয়।',
    formula: 'result + because + reason • reason + so + result',
    example: 'I stayed home because it was raining. It was raining, so I stayed home.',
    optionBuilder: _becauseSoOptions,
    hintBuilder: (_) => 'কারণের আগে because এবং ফলাফলের আগে so ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I stayed home because it was raining.', 'বৃষ্টি হচ্ছিল বলে আমি বাসায় ছিলাম।'),
      SpeakingSeed('It was raining, so I stayed home.', 'বৃষ্টি হচ্ছিল, তাই আমি বাসায় ছিলাম।'),
      SpeakingSeed('She studies hard because she wants a good job.', 'ভালো job চায় বলে সে মন দিয়ে পড়ে।'),
      SpeakingSeed('He was tired, so he went to bed.', 'সে ক্লান্ত ছিল, তাই ঘুমাতে গেল।'),
      SpeakingSeed('I practice daily because I want to speak fluently.', 'Fluently বলতে চাই বলে আমি প্রতিদিন practice করি।'),
      SpeakingSeed('The bus was late, so I missed the class.', 'Bus দেরি করেছিল, তাই class miss করেছি।'),
      SpeakingSeed('We left early because the road was busy.', 'রাস্তা ব্যস্ত ছিল বলে আমরা আগে বের হয়েছি।'),
      SpeakingSeed('She was sick, so she saw a doctor.', 'সে অসুস্থ ছিল, তাই doctor দেখিয়েছে।'),
      SpeakingSeed('I called him because I needed help.', 'সাহায্য প্রয়োজন ছিল বলে আমি তাকে call করেছি।'),
      SpeakingSeed('The shop was closed, so we returned home.', 'দোকান বন্ধ ছিল, তাই আমরা বাসায় ফিরেছি।'),
      SpeakingSeed('He speaks slowly because I am a beginner.', 'আমি beginner বলে সে ধীরে কথা বলে।'),
      SpeakingSeed('I forgot the key, so I could not enter.', 'চাবি ভুলে গিয়েছিলাম, তাই ঢুকতে পারিনি।'),
      SpeakingSeed('They are happy because they passed the test.', 'Test pass করেছে বলে তারা খুশি।'),
      SpeakingSeed('I was busy, so I did not answer.', 'আমি ব্যস্ত ছিলাম, তাই উত্তর দিইনি।'),
      SpeakingSeed('We use this app because it is helpful.', 'Helpful বলে আমরা এই app ব্যবহার করি।'),
      SpeakingSeed('I learn English because I need it for work.', 'তুমি কেন English শেখো?', question: 'Why do you learn English?'),
      SpeakingSeed('I was tired, so I took some rest.', 'ক্লান্ত ছিলে, তাই কী করেছিলে?', question: 'What did you do because you were tired?'),
      SpeakingSeed('I stayed home because it was raining.', 'ভুল বাক্যটি ঠিক করো: I stayed home so it was raining.'),
      SpeakingSeed('I am late because the bus broke down.', 'Office-এ দেরির কারণ বলো।'),
      SpeakingSeed('I want better opportunities, so I practice English every day.', 'English practice-এর কারণ ও ফল বলো।', question: 'Why do you practice English daily?'),
    ],
  );

  static final SpeakingRule _rule43 = SpeakingRuleFactory.create(
    id: 43,
    title: 'First Conditional',
    explanation:
    'ভবিষ্যতে বাস্তবসম্ভব কোনো শর্ত ও তার ফল বলতে If + Simple Present এবং will + base verb ব্যবহার হয়।',
    formula: 'If + present simple, subject + will + base verb',
    example: 'If I practice, I will improve.',
    optionBuilder: _conditionalOptions,
    hintBuilder: (_) => 'If অংশে present tense এবং result অংশে will + base verb ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('If I practice, I will improve.', 'আমি practice করলে উন্নতি করব।'),
      SpeakingSeed('If it rains, we will stay home.', 'বৃষ্টি হলে আমরা বাসায় থাকব।'),
      SpeakingSeed('If she calls, I will answer.', 'সে call করলে আমি উত্তর দেব।'),
      SpeakingSeed('If you study, you will pass.', 'তুমি পড়লে pass করবে।'),
      SpeakingSeed('If he comes, we will start.', 'সে এলে আমরা শুরু করব।'),
      SpeakingSeed('If they invite me, I will go.', 'তারা invite করলে আমি যাব।'),
      SpeakingSeed('If I have time, I will help you.', 'সময় থাকলে আমি তোমাকে সাহায্য করব।'),
      SpeakingSeed('If we leave now, we will catch the bus.', 'এখন বের হলে আমরা bus ধরতে পারব।'),
      SpeakingSeed('If you speak slowly, I will understand.', 'তুমি ধীরে বললে আমি বুঝব।'),
      SpeakingSeed('If the shop is open, I will buy it.', 'দোকান খোলা থাকলে আমি এটি কিনব।'),
      SpeakingSeed('If I earn enough, I will travel.', 'যথেষ্ট আয় করলে আমি travel করব।'),
      SpeakingSeed('If she practices daily, she will speak confidently.', 'প্রতিদিন practice করলে সে confidently বলবে।'),
      SpeakingSeed('If you need help, call me.', 'সাহায্য প্রয়োজন হলে আমাকে call করো।'),
      SpeakingSeed('If the bus is late, I will take a taxi.', 'Bus দেরি করলে taxi নেব।'),
      SpeakingSeed('If we finish early, we will watch a movie.', 'আগে শেষ করলে movie দেখব।'),
      SpeakingSeed('If I have free time, I will practice English.', 'Free time পেলে কী করবে?', question: 'What will you do if you have free time?'),
      SpeakingSeed('I will stay home if it rains.', 'বৃষ্টি হলে কী করবে?', question: 'What will you do if it rains?'),
      SpeakingSeed('If she comes, I will call you.', 'ভুল বাক্যটি ঠিক করো: If she will come, I will call you.'),
      SpeakingSeed('If the room is available, I will book it.', 'Hotel booking-এর শর্ত বলো।'),
      SpeakingSeed('If I practice every day, I will speak English fluently.', 'নিজের learning condition ও result বলো।', question: 'How will you become fluent?'),
    ],
  );

  static final SpeakingRule _rule44 = SpeakingRuleFactory.create(
    id: 44,
    title: 'Would Like',
    explanation:
    'ভদ্রভাবে নিজের ইচ্ছা, খাবার বা সেবা চাইতে would like ব্যবহার হয়। এর পরে noun অথবা to + verb বসে।',
    formula: 'Subject + would like + noun/to + verb',
    example: 'I would like some tea. I would like to book a room.',
    optionBuilder: _wouldLikeOptions,
    hintBuilder: (_) => 'Noun সরাসরি এবং action হলে would like to + base verb ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I would like some tea.', 'আমি কিছু চা চাই।'),
      SpeakingSeed('I would like to book a room.', 'আমি একটি room book করতে চাই।'),
      SpeakingSeed('She would like a glass of water.', 'সে এক glass পানি চায়।'),
      SpeakingSeed('We would like to order food.', 'আমরা খাবার order করতে চাই।'),
      SpeakingSeed('He would like a window seat.', 'সে window seat চায়।'),
      SpeakingSeed('They would like to join us.', 'তারা আমাদের সঙ্গে যোগ দিতে চায়।'),
      SpeakingSeed('I would like more information.', 'আমি আরও information চাই।'),
      SpeakingSeed('Would you like some coffee?', 'তুমি কি কিছু coffee চাইবে?'),
      SpeakingSeed('She would like to speak to the manager.', 'সে manager-এর সঙ্গে কথা বলতে চায়।'),
      SpeakingSeed('I would like the bill, please.', 'আমি bill চাই, দয়া করে।'),
      SpeakingSeed('We would like two tickets.', 'আমরা দুটি ticket চাই।'),
      SpeakingSeed('He would like to change the date.', 'সে date পরিবর্তন করতে চায়।'),
      SpeakingSeed('I would like a quiet room.', 'আমি একটি শান্ত room চাই।'),
      SpeakingSeed('Would you like to sit here?', 'তুমি কি এখানে বসতে চাইবে?'),
      SpeakingSeed('I would like to improve my speaking.', 'আমি speaking উন্নত করতে চাই।'),
      SpeakingSeed('I would like some rice.', 'তুমি কী খেতে চাও?', question: 'What would you like to eat?'),
      SpeakingSeed('Yes, I would like to join.', 'তুমি কি যোগ দিতে চাও?', question: 'Would you like to join?'),
      SpeakingSeed('I would like to order.', 'ভুল বাক্যটি ঠিক করো: I would like order.'),
      SpeakingSeed('I would like to check in, please.', 'Hotel reception-এ check-in করতে চাও।'),
      SpeakingSeed('I would like to learn English and speak with confidence.', 'নিজের English goal ভদ্রভাবে বলো।', question: 'What would you like to achieve?'),
    ],
  );

  static final SpeakingRule _rule45 = SpeakingRuleFactory.create(
    id: 45,
    title: 'Polite Requests',
    explanation:
    'ভদ্রভাবে সাহায্য বা অনুমতি চাইতে Can you, Could you, Would you এবং Could I ব্যবহার করা যায়।',
    formula: 'Could/Would/Can + subject + base verb + please?',
    example: 'Could you help me, please?',
    optionBuilder: _requestOptions,
    hintBuilder: (_) => 'Modal-এর পরে subject এবং verb-এর base form ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('Could you help me, please?', 'দয়া করে আমাকে সাহায্য করবেন?'),
      SpeakingSeed('Would you open the door, please?', 'দয়া করে দরজাটি খুলবেন?'),
      SpeakingSeed('Can you speak slowly, please?', 'দয়া করে ধীরে কথা বলবেন?'),
      SpeakingSeed('Could I use your phone?', 'আমি কি আপনার phone ব্যবহার করতে পারি?'),
      SpeakingSeed('Would you wait a moment, please?', 'দয়া করে একটু অপেক্ষা করবেন?'),
      SpeakingSeed('Could you repeat that, please?', 'দয়া করে কথাটি আবার বলবেন?'),
      SpeakingSeed('Can I sit here?', 'আমি কি এখানে বসতে পারি?'),
      SpeakingSeed('Would you send me the details?', 'আপনি কি আমাকে details পাঠাবেন?'),
      SpeakingSeed('Could you show me the way?', 'আপনি কি আমাকে পথ দেখাবেন?'),
      SpeakingSeed('Can you call me later?', 'আপনি কি আমাকে পরে call করতে পারেন?'),
      SpeakingSeed('Could I have some water, please?', 'আমি কি কিছু পানি পেতে পারি?'),
      SpeakingSeed('Would you check this file, please?', 'দয়া করে এই file-টি check করবেন?'),
      SpeakingSeed('Could you tell me the price?', 'আপনি কি আমাকে দামটি বলবেন?'),
      SpeakingSeed('Can I pay by card?', 'আমি কি card দিয়ে payment করতে পারি?'),
      SpeakingSeed('Would you mind closing the window?', 'আপনি কি window-টি বন্ধ করবেন?'),
      SpeakingSeed('Could you repeat the question, please?', 'প্রশ্ন বুঝতে না পারলে কী বলবে?', question: 'What would you say if you did not understand?'),
      SpeakingSeed('Yes, I can help you.', 'কেউ সাহায্য চাইলে কী উত্তর দেবে?', question: 'Could you help me?'),
      SpeakingSeed('Could you help me?', 'ভুল প্রশ্নটি ঠিক করো: Could you to help me?'),
      SpeakingSeed('Could you bring the bill, please?', 'Restaurant-এ bill চাও।'),
      SpeakingSeed('Could you speak slowly and repeat the last sentence, please?', 'কথা বুঝতে না পারলে ভদ্র request করো।', question: 'How would you ask someone to speak more clearly?'),
    ],
  );

  static List<String> _andButOrOptions(int id, String correct) {
    final connector = correct.contains(' and ') ? 'and' : correct.contains(' but ') ? 'but' : 'or';
    final wrongOne = correct.replaceFirst(' $connector ', connector == 'and' ? ' but ' : ' and ');
    final wrongTwo = correct.replaceFirst(' $connector ', connector == 'or' ? ' but ' : ' or ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _becauseSoOptions(int id, String correct) {
    final wrongOne = correct.contains(' because ')
        ? correct.replaceFirst(' because ', ' so ')
        : correct.replaceFirst(', so ', ' because ');
    final wrongTwo = correct.replaceFirst(RegExp(r'\b(because|so)\b'), 'but');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _conditionalOptions(int id, String correct) {
    final wrongOne = correct.replaceFirst('If ', 'When maybe ');
    final wrongTwo = correct.replaceFirst(RegExp(r'\bwill\b'), 'would to');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _wouldLikeOptions(int id, String correct) {
    final wrongOne = correct.replaceFirst(' would like ', ' would likes ');
    final wrongTwo = correct.replaceFirst(' would like ', ' will like to ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _requestOptions(int id, String correct) {
    final wrongOne = correct
        .replaceFirst('Could ', 'Could to ')
        .replaceFirst('Would ', 'Would to ')
        .replaceFirst('Can ', 'Can to ');
    final wrongTwo = 'Do $correct';
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
