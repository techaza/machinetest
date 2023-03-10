import 'package:flutter/material.dart';
import 'package:todo_ap/core/constants.dart';
import 'package:todo_ap/services/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Services.todos(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    padding: const EdgeInsets.all(kPadding),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: textEditingController,
                                    decoration: const InputDecoration(
                                      hintText: "Enter value",
                                      counterText: "",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    if (textEditingController.text.isEmpty) {
                                      return;
                                    }
                                    final status = await Services.create(
                                        textEditingController.text);
                                    if (status) {
                                      setState(() {
                                        textEditingController.clear();
                                      });
                                    }
                                  },
                                  splashRadius: 20,
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Card(
                          child: ListTile(
                            title: Text(snapshot.data![index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              splashRadius: 20,
                              onPressed: () async {
                                final status = await Services.delete(
                                    snapshot.data![index]);
                                if (status) {
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        );
                      }
                    },
                  )
                : Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.red,
                  );
          },
        ),
      ),
    );
  }
}
