#!/bin/bash
curl -H "Content-Type: application/graphql+-" -X POST localhost:8080/query -d $'
{
  latest(func: type(VotingSession)) {
        voteStarted
        voteFinished
        clarificationVotes : count(requestClarification)
        requestClarification {
          voteBy {
            uid
            name
          }
          description
          voteCast
        }
        ~votingSessions {
          title@en
          officiatingbodies {
            uid
            name
          }
        }
        approveVotes : count(approve)
        approve {
          voteBy {
            uid
            name
          }
        }
        disapproveVotes : count(disapprove)
        disapprove {
          voteBy {
            uid
            name
          }
        }
        abstainVotes : count(abstain)
        abstain {
          voteBy {
            uid
            name
          }
        }
  }
}
'
