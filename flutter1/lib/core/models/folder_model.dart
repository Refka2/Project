
class FolderModel {
  FolderModel( {
    this.userId,
    this.folderId,
    this.folderName,
    this.itemsNb,

  });
  final String? userId;
  final String? folderId;
  final String? folderName;
  final int? itemsNb;

  static FolderModel fromFirestore(Map<String, dynamic>? data) =>
      FolderModel(
        userId: data?['userId'],
        folderId: data?['folderId'],
        folderName: data?['folderName'],
        itemsNb: data?['itemsNb']
      );

  Map<String, dynamic> toFirestore() {
    return {
      'userId' : userId,
      'folderId': folderId,
      'folderName': folderName,
      'itemsNb': itemsNb,
    };
  }
}
