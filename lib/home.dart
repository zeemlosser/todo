import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  List<Todo> todos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
        actions: [
          IconButton(onPressed: (){
            todos.clear();
            if(mounted){
              setState(() {});
            }
          }, icon: const Icon(Icons.playlist_remove))
        ],
        centerTitle: true,
      ),
      body:
      ListView.separated(
          itemCount: todos.length,
          itemBuilder: (context, index){
            return ListTile(
              onLongPress: (){
                todos[index].isDone = false;
                if(mounted){
                  setState(() {});
                }
              },
              onTap: (){
                todos[index].isDone = true;
                if(mounted){
                  setState(() {});
                }
              },
              leading: todos[index].isDone ?  const Icon(Icons.done_outline) :  const Icon(Icons.pending_outlined),
              title: Text(todos[index].title),
            subtitle: Text(todos[index].description),
              trailing: IconButton(
                icon: const Icon(Icons.delete_forever_outlined),
                onPressed: (){
                  todos.removeAt(index);
                  if(mounted){
                    setState(() {});
                  }
                },
              ),
            );
      },
        separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 0,);
      },),


      floatingActionButton: FloatingActionButton(
        onPressed: (){
         ShowAddNewToDoList();
        },
        child: const Icon(Icons.add),
      ),
    );


  }

  // ignore: non_constant_identifier_names
  void ShowAddNewToDoList(){
    showModalBottomSheet(context: context, builder: (context){
      return Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: const Text("Add New todo",

                  )),
            TextField(
              controller: _titleTEController,
              decoration: const InputDecoration(
                label: Text('Title'),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 2),

                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 5),
                )


              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: TextField(
                controller: _descriptionTEController,
                decoration: const InputDecoration(
                    label: Text('Description'),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 2),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 5),
                    )

                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              if(_titleTEController.text.trim().isNotEmpty && _descriptionTEController.text.trim().isNotEmpty) {
                todos.add(Todo(
                    _titleTEController.text, _descriptionTEController.text,
                    false));
                if (mounted) {
                  setState(() {});
                }
                _titleTEController.clear();
                _descriptionTEController.clear();
                Navigator.pop(context);
              }
            },
                child: const Text('Add'))
          ],
        ),
      );
    });
  }


}

class Todo{
  String title, description;
  bool isDone;
  Todo(this.title, this.description, this.isDone);
}
