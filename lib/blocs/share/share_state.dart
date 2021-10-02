part of 'share_bloc.dart';

enum LoadShareStatus { initial, loading, success, failure }

class ShareState extends Equatable {
  final List<TableMemberModel>? members;
  final LoadShareStatus load;
  final String? shareId;

  const ShareState({
    this.members,
    this.load = LoadShareStatus.initial,
    this.shareId,
  });

  @override
  List<Object?> get props => [members, shareId, load];

  ShareState copyWith({
    List<TableMemberModel>? members,
    LoadShareStatus? load,
    String? shareId,
  }) => ShareState(
    members: members ?? this.members,
    load: load ?? this.load,
    shareId: shareId ?? this.shareId,
  );
}
