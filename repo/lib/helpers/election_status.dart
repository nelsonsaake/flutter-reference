import 'package:semper_web/archetypes/election_status.dart';
import 'package:semper_web/dio_models/election.dart';

ElectionStatus? electionStatus(Election election) {

  if(!election.isEnded && !election.isStarted)  return ElectionStatus.pending;

  if (election.isEnded) return ElectionStatus.completed;

  if (election.isStarted) return ElectionStatus.pending;

  // if it is not pending it has started
  // if it is not ended it is still in progress
  return ElectionStatus.inProgress;
}
