import 'package:sqflite/sqflite.dart';

import 'Model.dart';

Future<Database>opendb()async{
   final db=await openDatabase('imgSave',version: 1,onCreate: (db,version)async{
      await db.execute('CREATE TABLE imgSave(id INTEGER PRIMARY KEY AUTOINCREMENT, img TEXT)');
   }) ;

   return db;
}

Future<void>addImg(Model model)async{
final db =await  opendb();
db.insert('imgSave',model.toMap() );
}


Future<void>delete(int id)async{
   final db =await opendb();
   db.delete('imgSave',where:'id=?', whereArgs: [id]);

   }


Future<List<Model>>getimg()async {
   final db = await opendb();
   final List<Map <String,dynamic>>databaselist=await db.query('imgSave',columns: ['id','img']);
List<Model> temp =[];
for (var element in databaselist) {
   temp.add(Model.fromMap(element));
}
return temp;
}