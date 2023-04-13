import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          'Message',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.w900, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: SizedBox(
              height: 100,
              width: 1200,
              child: Material(
                shape:
                    const OutlineInputBorder(borderSide: BorderSide(width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 20),
                              child: Image.asset(
                                "assets/images/b.png",
                                fit: BoxFit.fill,
                                height: 50,
                                width: 50,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20, bottom: 5),
                              child: Text(
                                'ID_01987',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        const Text(
                          "Your product was very amazing.I will never buy this product again\nThank you",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Row(
                        children: const [
                          Text(
                            "3.5 ",
                          ),
                          Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 234, 212, 12),
                          ),
                          Text(" Rating")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
