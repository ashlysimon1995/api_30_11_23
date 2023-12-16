import 'package:api_30_11_23/controller/controller_class.dart';
import 'package:flutter/material.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  Controllerclass ctrl = Controllerclass();
  var namectrl = TextEditingController();
  var designationctrl = TextEditingController();
  bool isLoading = true;

  void initState() {
    fetchData();
    super.initState();
  }

  Future fetchData() async {
    await ctrl.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My screen"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ctrl.modelobj?.employees?.length,
              itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                        ctrl.modelobj?.employees?[index].employeeName ?? ""),
                    subtitle: Text(
                        ctrl.modelobj?.employees?[index].designation ?? ""),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextField(
                                              controller: namectrl,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Employee name',
                                                  labelText: 'Employee name'),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextField(
                                              controller: designationctrl,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "Designation",
                                                  hintText: 'Designation'),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      namectrl.clear();
                                                      designationctrl.clear();
                                                    },
                                                    child: Text("Cancel")),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      isLoading = true;
                                                      setState(() {});
                                                      await ctrl.updateData(
                                                          name: namectrl.text,
                                                          designation:
                                                              designationctrl
                                                                  .text,
                                                          id: ctrl
                                                                  .modelobj
                                                                  ?.employees?[
                                                                      index]
                                                                  .id
                                                                  .toString() ??
                                                              "");
                                                      isLoading = false;
                                                      setState(() {});
                                                    },
                                                    child: Text("update"))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                            onPressed: () async {
                              isLoading = true;
                              setState(() {});
                              await ctrl.deleteData(
                                  ctrl.modelobj?.employees?[index].id);
                              isLoading = false;
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  )),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: namectrl,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Employee name',
                                labelText: 'Employee name'),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: designationctrl,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Designation",
                                hintText: 'Designation'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    namectrl.clear();
                                    designationctrl.clear();
                                  },
                                  child: Text("Cancel")),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    isLoading = true;
                                    setState(() {});
                                    await ctrl.addData(
                                      namectrl.text,
                                      designationctrl.text,
                                    );
                                    isLoading = false;
                                    setState(() {});
                                    namectrl.clear();
                                    designationctrl.clear();
                                  },
                                  child: Text("save"))
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
