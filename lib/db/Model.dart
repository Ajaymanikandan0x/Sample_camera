class Model {
final  String? img;
final int? id;
Model({required this.img,this.id});

factory Model.fromMap(Map <String, dynamic> model)=>Model(img: model['img'],
id: model['id']);

Map <String, dynamic> toMap()=>
    {
      'id':id,
      'img':img
    };
}