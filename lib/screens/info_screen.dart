import 'package:flutter/material.dart';
import 'package:finwise/screens/chatbot/chat_screen.dart';

class InvestmentInfoPage extends StatelessWidget {
  const InvestmentInfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Investment Information'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Investment Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Investing in stocks and shares might sound like a term reserved for those who wear fancy suits and sit in big offices, but it\'s actually something that can benefit everyone, including folks living in rural areas of India. Imagine it like this: when you buy a stock, you are basically buying a tiny piece of a company, like owning a little part of a shop in your village. And just like that shop can grow and make more money, the company whose stock you own can grow too, hopefully making your piece more valuable over time.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Let\'s think about some of the words you might hear when people talk about investing. First up, "stocks." Think of stocks as little certificates that say you own a piece of a company. It\'s like having a share in the village well, you get a portion of the water, and if the well becomes more popular and more people need water, your share becomes more valuable.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Then there\'s "dividends." This is like when the village decides to share some of the well\'s water with everyone who owns a piece of it. So, if the company you own stock in makes a lot of money, they might decide to share some of that money with you and other shareholders. It\'s like a little bonus for being part of the company\'s success.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vehicula odio vitae nisl fringilla, id ullamcorper leo porttitor. Duis feugiat, dui ac dictum ultrices, metus neque placerat arcu, vitae ultrices velit ligula ac sapien.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Now, what about the "stock market"? It\'s not as complicated as it sounds. Imagine it like a big market in your town where people buy and sell things. In this case, they\'re buying and selling stocks. Sometimes, lots of people want to buy stocks because they believe companies are doing well,that\'s called a "bull market." Other times, people are more cautious and might sell their stocks that\'s a "bear market.',                
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Now, before you jump into investing, there are a few things to keep in mind. First, it\'s essential to learn about different types of investments and how they work. Just like you wouldn\'t buy a cow without knowing how to take care of it, you shouldn\'t invest without understanding what you\'re getting into.Start small, just like when you plant seeds in your fields. You don\'t want to risk all your savings on one stock. Instead, spread your money across different investments, like planting different crops. This way, if one doesn\'t grow well, you still have others to rely on.And always keep an eye on your investments, just like you watch over your crops as they grow. Markets can change, and it\'s essential to be ready to adjust your investments if needed.',
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatScreen()),
                  );
                },
                child: const Text('Go to Chat Bot'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}