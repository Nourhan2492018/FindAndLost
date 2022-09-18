abstract class ChatState{}
class ChatInitialState extends ChatState{}
////send massages
class SendMassageSuccessState extends ChatState {}
class SendMassageErrorState extends ChatState {}
////get All Massages massages
class GetAllMassagesSuccessState extends ChatState {}
class GetAllMassagesErrorState extends ChatState {}