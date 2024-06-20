import 'dart:convert';
import 'dart:io';
// ignore: unused_import
import 'dart:typed_data';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:semper_web/dio_models/auth_details.dart';
import 'package:semper_web/dio_models/ballot.dart';
import 'package:semper_web/dio_models/bool_response.dart';
import 'package:semper_web/dio_models/candidate.dart';
import 'package:semper_web/dio_models/cast_vote_request.dart';
import 'package:semper_web/dio_models/election_mutation_request.dart';
import 'package:semper_web/dio_models/credentials.dart';
import 'package:semper_web/dio_models/election.dart';
import 'package:semper_web/dio_models/election_verification_method_list_response.dart';
import 'package:semper_web/dio_models/email.dart';
import 'package:semper_web/dio_models/get_amount_paid_request.dart';
import 'package:semper_web/dio_models/get_ballot_request.dart';
import 'package:semper_web/dio_models/get_payments_request.dart';
import 'package:semper_web/dio_models/get_quantity_paid_for_request.dart';
import 'package:semper_web/dio_models/institution.dart';
import 'package:semper_web/dio_models/int_response.dart';
import 'package:semper_web/dio_models/double_response.dart';
// ignore: unused_import
import 'package:semper_web/dio_models/json_response.dart';
import 'package:semper_web/dio_models/message_response.dart';
import 'package:semper_web/dio_models/office.dart';
import 'package:semper_web/dio_models/office_scores_list_response.dart';
import 'package:semper_web/dio_models/office_scores_response.dart';
import 'package:semper_web/dio_models/reset_password_request.dart';
import 'package:semper_web/dio_models/payment_list_response.dart';
import 'package:semper_web/dio_models/send_voter_otp_request.dart';
import 'package:semper_web/dio_models/string_response.dart';
import 'package:semper_web/dio_models/upate_user_password.dart';
import 'package:semper_web/dio_models/user.dart';
import 'package:semper_web/dio_models/verification_method_list_response.dart';
import 'package:semper_web/dio_models/verify_email_request.dart';
import 'package:semper_web/dio_models/voter.dart';
import 'package:semper_web/dio_models/voter_login_request.dart';
import 'package:semper_web/endpoints/endpoints.dart';
import 'package:semper_web/dio_models/get_payment_link_request.dart';
import 'package:semper_web/dio_models/get_amount_payable_request.dart';

part 'client.g.dart';

class ClientImplementation extends _Client {
  ClientImplementation(Dio dio, {String? baseUrl})
      : super(dio, baseUrl: baseUrl);
}

@RestApi(baseUrl: EndPoints.base)
abstract class Client {
  factory Client(Dio dio, {String baseUrl}) = _Client;

  @POST(EndPoints.login)
  Future<AuthDetailsResponse> login(@Body() Credentials cred);

  @GET(EndPoints.logout)
  Future<MessageResponse> logout();

  @GET(EndPoints.refresh)
  Future<AuthDetailsResponse> refresh();

  @POST(EndPoints.register)
  Future<UserResponse> register(@Body() User user);

  @GET(EndPoints.users)
  Future<UserListResponse> getUsers();

  @GET(EndPoints.user)
  Future<UserResponse> getUser(@Path() int id);

  @POST(EndPoints.users)
  Future<UserResponse> createUser(@Body() User user);

  @PUT(EndPoints.user)
  Future<UserResponse> updateUser(
    @Path() int id,
    @Body() User user,
  );

  @PUT(EndPoints.updateUserPassword)
  Future<MessageResponse> updateUserPassword(
    @Path() int id,
    @Body() UpdateUserPassword updateUserPassword,
  );

  @MultiPart()
  @PUT(EndPoints.updateUserPhoto)
  Future<UserResponse> updateUserPhoto(
    @Path() int id,
    @Part(name: "file") String file,
  );

  @DELETE(EndPoints.user)
  Future<MessageResponse> deleteUser(@Path() int id);

  @GET(EndPoints.institutions)
  Future<InstitutionListResponse> getInstitutions();

  @GET(EndPoints.institution)
  Future<InstitutionResponse> getInstitution(@Path() int id);

  @MultiPart()
  @POST(EndPoints.institutions)
  Future<InstitutionResponse> createInstitution(
    @Part(name: "file") String file,
    @Part(name: "institution") Institution institution,
  );

  @MultiPart()
  @PUT(EndPoints.institution)
  Future<InstitutionResponse> updateInstitutionWithLogo(
    @Path() int id,
    @Part(name: "file") String file,
    @Part(name: "institution") Institution institution,
  );

  @MultiPart()
  @PUT(EndPoints.institution)
  Future<InstitutionResponse> updateInstitution(
    @Path() int id,
    @Part(name: "institution") Institution institution,
  );

  @DELETE(EndPoints.institution)
  Future<MessageResponse> deleteInstitution(@Path() int id);

  @GET(EndPoints.elections)
  Future<ElectionListResponse> getElections({
    @Query("institutionId") required int institutionId,
  });

  @GET(EndPoints.election)
  Future<ElectionResponse> getElection(@Path() int id);

  @POST(EndPoints.elections)
  Future<ElectionResponse> createElection(
    @Body() ElectionMutationRequest election,
  );

  @PUT(EndPoints.election)
  Future<ElectionResponse> updateElection(
    @Path() int id,
    @Body() ElectionMutationRequest election,
  );

  @DELETE(EndPoints.election)
  Future<MessageResponse> deleteElection(@Path() int id);

  @GET(EndPoints.electionCode)
  Future<StringResponse> getElectionCode(@Path() int id);

  @GET(EndPoints.voters)
  Future<VoterListResponse> getVoters({
    @Query("electionId") required int electionId,
  });

  @GET(EndPoints.voter)
  Future<VoterResponse> getVoter(@Path() int id);

  @POST(EndPoints.voters)
  Future<VoterResponse> createVoter(@Body() Voter voter);

  @PUT(EndPoints.voter)
  Future<VoterResponse> updateVoter(@Path() int id, @Body() Voter voter);

  @DELETE(EndPoints.voter)
  Future<MessageResponse> deleteVoter(@Path() int id);

  @GET(EndPoints.offices)
  Future<OfficeListResponse> getOffices({
    @Query("electionId") required int electionId,
  });

  @GET(EndPoints.office)
  Future<OfficeResponse> getOffice(@Path() int id);

  @POST(EndPoints.offices)
  Future<OfficeResponse> createOffice(@Body() Office office);

  @PUT(EndPoints.office)
  Future<OfficeResponse> updateOffice(@Path() int id, @Body() Office office);

  @DELETE(EndPoints.office)
  Future<MessageResponse> deleteOffice(@Path() int id);

  @GET(EndPoints.candidates)
  Future<CandidateListResponse> getCandidates(
      {@Query("electionId") required int electionId});

  @GET(EndPoints.candidate)
  Future<CandidateResponse> getCandidate(@Path() int id);

  @MultiPart()
  @POST(EndPoints.candidates)
  Future<CandidateResponse> createCandidate(
    @Part(name: "file") String file,
    @Part(name: "candidate") Candidate candidate,
  );

  @MultiPart()
  @PUT(EndPoints.candidate)
  Future<CandidateResponse> updateCandidateWithPhoto(
    @Path() int id,
    @Part(name: "file") String file,
    @Part(name: "candidate") Candidate candidate,
  );

  @MultiPart()
  @PUT(EndPoints.candidate)
  Future<CandidateResponse> updateCandidate(
    @Path() int id,
    @Part(name: "candidate") Candidate candidate,
  );

  @DELETE(EndPoints.candidate)
  Future<MessageResponse> deleteCandidate(@Path() int id);

  @GET(EndPoints.votersCount)
  Future<IntResponse> getVotersCount({
    @Query("electionId") required int electionId,
  });

  @GET(EndPoints.donwload)
  Future<MessageResponse> uploadByUrl({@Query("url") required String url});

  @POST(EndPoints.upload)
  @MultiPart()
  Future<MessageResponse> upload({
    // @Part() required String title,
    // @Part() required int part,
    @Part() required File file,
  });

  @POST(EndPoints.pushVerificationEmail)
  Future<MessageResponse> pushVerificationEmail(@Body() Email email);

  @POST(EndPoints.isEmailVerified)
  Future<BoolResponse> isEmailVerified(@Body() Email email);

  @POST(EndPoints.verifyEmail)
  Future<BoolResponse> verifyEmail(@Body() VerifyEmailRequest req);

  @POST(EndPoints.pushResetPasswordEmail)
  Future<MessageResponse> requestResetPasswordToken(@Body() Email email);

  @POST(EndPoints.resetPassword)
  Future<MessageResponse> resetPassword(@Body() ResetPasswordRequest req);

  @POST(EndPoints.pushVoterOtp)
  Future<MessageResponse> pushVoterOtp(@Body() PushVoterOtpRequest req);

  @POST(EndPoints.voterLogin)
  Future<AuthDetailsResponse> voterLogin(@Body() VoterLoginRequest req);

  @POST(EndPoints.hasBallot)
  Future<BoolResponse> hasBallot(@Body() GetBallotRequest req);

  @POST(EndPoints.getBallot)
  Future<BallotResponse> getBallot(@Body() GetBallotRequest req);

  @POST(EndPoints.vote)
  Future<MessageResponse> vote(@Body() CastVoteRequest req);

  @GET(EndPoints.getElectionPdf)
  Future<StringResponse> getElectionPdf(@Path("id") int electionId);

  @GET(EndPoints.getElectionXL)
  Future<StringResponse> getElectionXl(@Path("id") int electioId);

  @GET(EndPoints.getOfficeScores)
  Future<OfficeScoresResponse> getOfficeScores(@Path("id") int officeId);

  @GET(EndPoints.getNumberOfAbsentVoters)
  Future<IntResponse> getNumberOfAbsentVoters(@Path("id") int electionId);

  @GET(EndPoints.getNumberOfOfficeVotes)
  Future<IntResponse> getNumberOfOfficeVotes(@Path("id") int officeId);

  @GET(EndPoints.getNumberOfOutstandingOfficeVotes)
  Future<IntResponse> getNumberOfOutstandingOfficeVotes(
    @Path("id") int electionId,
  );

  @GET(EndPoints.getNumberOfVotersWhoCompletedVoting)
  Future<IntResponse> getNumberOfVotersWhoCompletedVoting(
    @Path("id") int electionId,
  );

  @GET(EndPoints.getNumberOfVotersWhoDidntCompleteVoting)
  Future<IntResponse> getNumberOfVotersWhoDidntCompleteVoting(
    @Path("id") int electionId,
  );

  @GET(EndPoints.getNumberOfVotersWhoVoted)
  Future<IntResponse> getNumberOfVotersWhoVoted(@Path("id") int electionId);

  @GET(EndPoints.electionWinners)
  Future<OfficeScoresListResponse> getWinners(@Path("id") int electionId);

  @GET(EndPoints.scores)
  Future<OfficeScoresListResponse> getScores(@Path("id") int electionId);

  @GET(EndPoints.getVerificationMethods)
  Future<VerificationMethodListResponse> getVerificationMethods();

  @GET(EndPoints.getElectionVerificationMethods)
  Future<IntListResponse> getElectionVerificationMethods(
    @Path("id") int electionId,
  );

  @GET(EndPoints.getElectionVerificationMethodsByCode)
  Future<IntListResponse> getElectionVerificationMethodsByCode(
    @Query("electionCode") String electionCode,
  );

  @GET(EndPoints.startPauseElection)
  Future<ElectionResponse> startPauseElection(@Path() int id);

  @GET(EndPoints.endElection)
  Future<ElectionResponse> endElection(@Path() int id);

  @POST(EndPoints.paymentlink)
  Future<StringResponse> getPaymentLink(@Body() GetPaymentLinkRequest req);

  @POST(EndPoints.amountPayable)
  Future<DoubleResponse> getAmountPayable(@Body() GetAmountPayableRequest req);

  @POST(EndPoints.amountPaid)
  Future<DoubleResponse> getAmountPaid(@Body() GetAmountPaidRequest req);

  @POST(EndPoints.quantityPaidFor)
  Future<IntResponse> getQuantityPaidFor(@Body() GetQuantityPaidForRequest req);

  @POST(EndPoints.payments)
  Future<PaymentListResponse> getPayments(@Body() GetPaymentsRequest req);
}
