import 'package:dartz/dartz.dart';
import 'package:base_flutter/core/services/remote/failure.dart';
import 'package:base_flutter/domain/models/models.dart';
import 'package:base_flutter/domain/repository/repository.dart';
import 'package:base_flutter/domain/requests.dart';
import 'base_usecase.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput,Authentication>{
  final Repository _repository ;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) async{
    // I'm sending here tha profilr picture as it is in mock api server
    return await _repository.register(RegisterRequest(input.email, input.password, input.phoneNumber, input.mobileCountyCode, "", input.userName));
  }
}

class RegisterUseCaseInput{
  String email;
  String password;
  String phoneNumber;
  String mobileCountyCode;
  String profilePicture;
  String userName;

  RegisterUseCaseInput(this.email, this.password,this.mobileCountyCode,this.phoneNumber,this.profilePicture,this.userName);
}