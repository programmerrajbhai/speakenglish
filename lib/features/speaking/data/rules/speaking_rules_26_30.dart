import '../../models/speaking_rule_model.dart';
import 'speaking_rule_factory.dart';

class SpeakingRules26To30 {
  SpeakingRules26To30._();

  static final List<SpeakingRule> rules = <SpeakingRule>[
    _rule26,
    _rule27,
    _rule28,
    _rule29,
    _rule30,
  ];

  static final SpeakingRule _rule26 = SpeakingRuleFactory.create(
    id: 26,
    title: 'Have To & Has To',
    explanation:
    'কোনো কাজ করা প্রয়োজন বা বাধ্যতামূলক বোঝাতে I, You, We, They-এর সঙ্গে have to এবং He, She, It-এর সঙ্গে has to ব্যবহার হয়।',
    formula: 'Subject + have to/has to + base verb',
    example: 'I have to work. She has to study.',
    optionBuilder: _haveToOptions,
    hintBuilder: (_) =>
    'He, She, It-এর সঙ্গে has to; অন্য subject-এর সঙ্গে have to ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I have to work today.', 'আমাকে আজ কাজ করতে হবে।'),
      SpeakingSeed('She has to study tonight.', 'তাকে আজ রাতে পড়তে হবে।'),
      SpeakingSeed('We have to leave now.', 'আমাদের এখন যেতে হবে।'),
      SpeakingSeed('He has to call the client.', 'তাকে client-কে ফোন করতে হবে।'),
      SpeakingSeed('They have to wait outside.', 'তাদের বাইরে অপেক্ষা করতে হবে।'),
      SpeakingSeed('You have to practice every day.', 'তোমাকে প্রতিদিন অনুশীলন করতে হবে।'),
      SpeakingSeed('My brother has to wake up early.', 'আমার ভাইকে তাড়াতাড়ি উঠতে হবে।'),
      SpeakingSeed('I have to buy a ticket.', 'আমাকে একটি টিকিট কিনতে হবে।'),
      SpeakingSeed('The bus has to stop here.', 'বাসটিকে এখানে থামতে হবে।'),
      SpeakingSeed('We have to finish this project.', 'আমাদের project-টি শেষ করতে হবে।'),
      SpeakingSeed('She has to wear a uniform.', 'তাকে uniform পরতে হবে।'),
      SpeakingSeed('I have to improve my English.', 'আমাকে আমার ইংরেজি উন্নত করতে হবে।'),
      SpeakingSeed('He has to take some medicine.', 'তাকে কিছু ওষুধ খেতে হবে।'),
      SpeakingSeed('They have to follow the rules.', 'তাদের নিয়মগুলো মানতে হবে।'),
      SpeakingSeed('You have to speak slowly.', 'তোমাকে ধীরে কথা বলতে হবে।'),
      SpeakingSeed('I have to go to work.', 'তোমাকে এখন কোথায় যেতে হবে?', question: 'Where do you have to go now?'),
      SpeakingSeed('She has to finish her homework.', 'তাকে কী শেষ করতে হবে?', question: 'What does she have to finish?'),
      SpeakingSeed('He has to work today.', 'ভুল বাক্যটি ঠিক করো: He have to work today.'),
      SpeakingSeed('I have to show my passport.', 'Airport-এ নিজের প্রয়োজনীয় কাজ বলো।'),
      SpeakingSeed('I have to work, but my brother has to study.', 'আজ তোমাদের কী করতে হবে?', question: 'What do you have to do today?'),
    ],
  );

  static final SpeakingRule _rule27 = SpeakingRuleFactory.create(
    id: 27,
    title: 'Should & Should Not',
    explanation:
    'পরামর্শ দিতে should এবং কোনো কাজ না করার পরামর্শ দিতে should not বা shouldn’t ব্যবহার হয়।',
    formula: 'Subject + should/should not + base verb',
    example: 'You should practice. You should not worry.',
    optionBuilder: _shouldOptions,
    hintBuilder: (_) => 'should-এর পরে সবসময় verb-এর base form ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('You should practice every day.', 'তোমার প্রতিদিন অনুশীলন করা উচিত।'),
      SpeakingSeed('You should not worry.', 'তোমার চিন্তা করা উচিত নয়।'),
      SpeakingSeed('I should sleep early.', 'আমার তাড়াতাড়ি ঘুমানো উচিত।'),
      SpeakingSeed('She should drink more water.', 'তার আরও পানি পান করা উচিত।'),
      SpeakingSeed('He should see a doctor.', 'তার একজন ডাক্তার দেখানো উচিত।'),
      SpeakingSeed('We should help each other.', 'আমাদের একে অন্যকে সাহায্য করা উচিত।'),
      SpeakingSeed('They should arrive on time.', 'তাদের সময়মতো পৌঁছানো উচিত।'),
      SpeakingSeed('You should speak slowly.', 'তোমার ধীরে কথা বলা উচিত।'),
      SpeakingSeed('I should learn new words.', 'আমার নতুন শব্দ শেখা উচিত।'),
      SpeakingSeed('She should not skip breakfast.', 'তার সকালের খাবার বাদ দেওয়া উচিত নয়।'),
      SpeakingSeed('He should not drive so fast.', 'তার এত দ্রুত গাড়ি চালানো উচিত নয়।'),
      SpeakingSeed('We should keep the room clean.', 'আমাদের ঘর পরিষ্কার রাখা উচিত।'),
      SpeakingSeed('You should listen carefully.', 'তোমার মনোযোগ দিয়ে শোনা উচিত।'),
      SpeakingSeed('They should not make noise.', 'তাদের শব্দ করা উচিত নয়।'),
      SpeakingSeed('I should review this lesson.', 'আমার এই lesson আবার দেখা উচিত।'),
      SpeakingSeed('You should take some rest.', 'ক্লান্ত হলে কী করা উচিত?', question: 'What should I do when I am tired?'),
      SpeakingSeed('She should practice speaking.', 'তার English উন্নত করতে কী করা উচিত?', question: 'What should she do to improve her English?'),
      SpeakingSeed('He should study more.', 'ভুল বাক্যটি ঠিক করো: He should studies more.'),
      SpeakingSeed('You should take this medicine after food.', 'অসুস্থ বন্ধুকে পরামর্শ দাও।'),
      SpeakingSeed('You should practice daily, and you should not fear mistakes.', 'নতুন learner-কে পরামর্শ দাও।', question: 'What advice would you give a beginner?'),
    ],
  );

  static final SpeakingRule _rule28 = SpeakingRuleFactory.create(
    id: 28,
    title: 'Must & Must Not',
    explanation:
    'জোরালো প্রয়োজন বা নিয়ম বোঝাতে must এবং কঠোর নিষেধ বোঝাতে must not বা mustn’t ব্যবহার হয়।',
    formula: 'Subject + must/must not + base verb',
    example: 'You must wear a seat belt.',
    optionBuilder: _mustOptions,
    hintBuilder: (_) => 'must বা must not-এর পরে verb-এর base form ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('You must wear a seat belt.', 'তোমাকে seat belt পরতেই হবে।'),
      SpeakingSeed('You must not smoke here.', 'তুমি এখানে ধূমপান করতে পারবে না।'),
      SpeakingSeed('I must finish this work.', 'আমাকে এই কাজটি শেষ করতেই হবে।'),
      SpeakingSeed('She must arrive on time.', 'তাকে সময়মতো পৌঁছাতেই হবে।'),
      SpeakingSeed('He must follow the rules.', 'তাকে নিয়মগুলো মানতেই হবে।'),
      SpeakingSeed('We must keep our city clean.', 'আমাদের শহর পরিষ্কার রাখতেই হবে।'),
      SpeakingSeed('They must show their tickets.', 'তাদের টিকিট দেখাতেই হবে।'),
      SpeakingSeed('You must speak the truth.', 'তোমাকে সত্য কথা বলতেই হবে।'),
      SpeakingSeed('Students must attend the class.', 'শিক্ষার্থীদের class-এ উপস্থিত থাকতেই হবে।'),
      SpeakingSeed('Drivers must stop at the red light.', 'লাল বাতিতে চালকদের থামতেই হবে।'),
      SpeakingSeed('You must not touch this button.', 'তুমি এই button স্পর্শ করতে পারবে না।'),
      SpeakingSeed('We must not waste water.', 'আমাদের পানি অপচয় করা যাবে না।'),
      SpeakingSeed('He must not be late again.', 'তার আবার দেরি করা যাবে না।'),
      SpeakingSeed('I must remember the password.', 'আমাকে password মনে রাখতেই হবে।'),
      SpeakingSeed('She must take her medicine.', 'তাকে ওষুধ খেতেই হবে।'),
      SpeakingSeed('You must carry your passport.', 'ভ্রমণের সময় কী সঙ্গে রাখতেই হবে?', question: 'What must you carry while traveling?'),
      SpeakingSeed('We must follow the safety rules.', 'আমাদের কী মানতেই হবে?', question: 'What must we follow?'),
      SpeakingSeed('She must go now.', 'ভুল বাক্যটি ঠিক করো: She must goes now.'),
      SpeakingSeed('You must not park here.', 'একজন driver-কে নিষেধ করো।'),
      SpeakingSeed('You must practice, but you must not fear mistakes.', 'English শেখার দুটি গুরুত্বপূর্ণ rule বলো।', question: 'What must a learner do and avoid?'),
    ],
  );

  static final SpeakingRule _rule29 = SpeakingRuleFactory.create(
    id: 29,
    title: 'Comparative Adjectives',
    explanation:
    'দুই ব্যক্তি বা জিনিসের তুলনা করতে adjective-এর comparative form এবং than ব্যবহার হয়। ছোট adjective-এ সাধারণত er যোগ হয়।',
    formula: 'Subject + be verb + comparative adjective + than + object',
    example: 'This book is cheaper than that book.',
    optionBuilder: _comparativeOptions,
    hintBuilder: (_) => 'দুইটির তুলনায় comparative form-এর পরে than ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('This book is cheaper than that book.', 'এই বইটি ওই বইয়ের চেয়ে সস্তা।'),
      SpeakingSeed('My brother is taller than me.', 'আমার ভাই আমার চেয়ে লম্বা।'),
      SpeakingSeed('A car is faster than a bicycle.', 'গাড়ি সাইকেলের চেয়ে দ্রুত।'),
      SpeakingSeed('Today is hotter than yesterday.', 'আজ গতকালের চেয়ে বেশি গরম।'),
      SpeakingSeed('English is easier than I thought.', 'English আমার ধারণার চেয়ে সহজ।'),
      SpeakingSeed('This phone is better than my old phone.', 'এই ফোনটি আমার পুরোনো ফোনের চেয়ে ভালো।'),
      SpeakingSeed('The blue bag is bigger than the red bag.', 'নীল ব্যাগটি লাল ব্যাগের চেয়ে বড়।'),
      SpeakingSeed('My house is closer than yours.', 'আমার বাড়ি তোমার বাড়ির চেয়ে কাছে।'),
      SpeakingSeed('She speaks more clearly than before.', 'সে আগের চেয়ে আরও স্পষ্টভাবে কথা বলে।'),
      SpeakingSeed('This road is wider than that road.', 'এই রাস্তাটি ওই রাস্তার চেয়ে চওড়া।'),
      SpeakingSeed('Tea is cheaper than coffee.', 'চা কফির চেয়ে সস্তা।'),
      SpeakingSeed('The train is safer than the bus.', 'ট্রেন বাসের চেয়ে নিরাপদ।'),
      SpeakingSeed('My new job is better than my old job.', 'আমার নতুন job পুরোনো job-এর চেয়ে ভালো।'),
      SpeakingSeed('This lesson is more difficult than the last one.', 'এই lesson আগেরটির চেয়ে কঠিন।'),
      SpeakingSeed('He is younger than his brother.', 'সে তার ভাইয়ের চেয়ে ছোট।'),
      SpeakingSeed('My phone is faster than my old phone.', 'তোমার নতুন ফোন কেমন?', question: 'How is your new phone compared with your old phone?'),
      SpeakingSeed('A bus is cheaper than a taxi.', 'কোনটি বেশি সস্তা?', question: 'Which is cheaper, a bus or a taxi?'),
      SpeakingSeed('She is taller than me.', 'ভুল বাক্যটি ঠিক করো: She is more tall than me.'),
      SpeakingSeed('This room is quieter than the other room.', 'Hotel-এ দুটি room তুলনা করো।'),
      SpeakingSeed('My English is better and clearer than before.', 'নিজের আগের ও বর্তমান English তুলনা করো।', question: 'How is your English now compared with before?'),
    ],
  );

  static final SpeakingRule _rule30 = SpeakingRuleFactory.create(
    id: 30,
    title: 'Superlative Adjectives',
    explanation:
    'তিন বা তার বেশি ব্যক্তি বা জিনিসের মধ্যে সর্বোচ্চ গুণ বোঝাতে superlative form ব্যবহার হয় এবং এর আগে সাধারণত the বসে।',
    formula: 'Subject + be verb + the + superlative adjective',
    example: 'This is the tallest building.',
    optionBuilder: _superlativeOptions,
    hintBuilder: (_) => 'সবার মধ্যে একটি সেরা হলে the + superlative form ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('This is the tallest building.', 'এটি সবচেয়ে উঁচু building।'),
      SpeakingSeed('She is the best student in the class.', 'সে class-এর সেরা student।'),
      SpeakingSeed('Today is the hottest day of the week.', 'আজ সপ্তাহের সবচেয়ে গরম দিন।'),
      SpeakingSeed('This is the cheapest phone in the shop.', 'এটি দোকানের সবচেয়ে সস্তা phone।'),
      SpeakingSeed('He is the oldest person in my family.', 'সে আমার পরিবারের সবচেয়ে বয়স্ক ব্যক্তি।'),
      SpeakingSeed('That was the most interesting movie.', 'ওটি সবচেয়ে আকর্ষণীয় movie ছিল।'),
      SpeakingSeed('This is the easiest lesson.', 'এটি সবচেয়ে সহজ lesson।'),
      SpeakingSeed('Mount Everest is the highest mountain.', 'Mount Everest সবচেয়ে উঁচু mountain।'),
      SpeakingSeed('Friday is the busiest day for me.', 'শুক্রবার আমার সবচেয়ে ব্যস্ত দিন।'),
      SpeakingSeed('She is the youngest member of the team.', 'সে team-এর সবচেয়ে ছোট member।'),
      SpeakingSeed('This is the fastest train.', 'এটি সবচেয়ে দ্রুত train।'),
      SpeakingSeed('It is the safest place here.', 'এটি এখানকার সবচেয়ে নিরাপদ জায়গা।'),
      SpeakingSeed('He is the most careful driver.', 'সে সবচেয়ে সতর্ক driver।'),
      SpeakingSeed('This is the biggest room in the hotel.', 'এটি hotel-এর সবচেয়ে বড় room।'),
      SpeakingSeed('English is the most useful language for my work.', 'আমার কাজের জন্য English সবচেয়ে useful language।'),
      SpeakingSeed('This is the best phone for me.', 'তোমার জন্য কোন phone সবচেয়ে ভালো?', question: 'Which is the best phone for you?'),
      SpeakingSeed('Saturday is my busiest day.', 'তোমার সবচেয়ে ব্যস্ত দিন কোনটি?', question: 'What is your busiest day?'),
      SpeakingSeed('He is the tallest boy in the class.', 'ভুল বাক্যটি ঠিক করো: He is tallest boy in the class.'),
      SpeakingSeed('This is the cheapest room in the hotel.', 'Hotel-এ সবচেয়ে সস্তা room সম্পর্কে জিজ্ঞাসা করো।'),
      SpeakingSeed('Speaking confidently is the most important goal for me.', 'English শেখার সবচেয়ে গুরুত্বপূর্ণ goal বলো।', question: 'What is your most important English goal?'),
    ],
  );

  static List<String> _haveToOptions(int id, String correct) {
    final wrongOne = correct.contains(' has to ')
        ? correct.replaceFirst(' has to ', ' have to ')
        : correct.replaceFirst(' have to ', ' has to ');
    final wrongTwo = correct
        .replaceFirst(' has to ', ' has ')
        .replaceFirst(' have to ', ' have ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _shouldOptions(int id, String correct) {
    final wrongOne = correct.contains(' should not ')
        ? correct.replaceFirst(' should not ', ' should to not ')
        : correct.replaceFirst(' should ', ' should to ');
    final wrongTwo = correct.replaceFirst(' should ', ' does should ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _mustOptions(int id, String correct) {
    final wrongOne = correct.contains(' must not ')
        ? correct.replaceFirst(' must not ', ' must to not ')
        : correct.replaceFirst(' must ', ' must to ');
    final wrongTwo = correct.replaceFirst(' must ', ' has must ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _comparativeOptions(int id, String correct) {
    final wrongOne = correct.replaceFirst(' than ', ' then ');
    final wrongTwo = correct.replaceFirst(' than ', ' from ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _superlativeOptions(int id, String correct) {
    final wrongOne = correct.replaceFirst(' the ', ' a ');
    final wrongTwo = correct.replaceFirst(' the ', ' more ');
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
