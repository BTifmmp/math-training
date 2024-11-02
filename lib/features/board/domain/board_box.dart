enum BoardBoxType { empty, filledStatic, fillable }

typedef BoardMatrix = List<List<BoardBoxInfo>>;

class BoardBoxInfo {
  final BoardBoxType type;
  final String? data;
  final int? id;
  BoardBoxInfo({required this.id, required this.type, this.data});

  BoardBoxInfo.empty()
      : type = BoardBoxType.empty,
        data = null,
        id = null;

  BoardBoxInfo.filledStatic(this.data)
      : type = BoardBoxType.filledStatic,
        id = null;

  BoardBoxInfo.fillable(this.id)
      : type = BoardBoxType.fillable,
        data = null;
}
