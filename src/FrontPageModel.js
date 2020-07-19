import React from 'React';
import ReactDOM from 'react-dom';
import * as dgraph from 'dgraph-js';
import * as grpc from 'grpc';

export default class FrontPageModel {
  constructor() {
    const clientStub = new dgraph.DgraphClientStub("http://localhost:8080");
    this.dgraph = new dgraph.DgraphClient(clientStub);
    this.latest = [];
    this.recent = [];
  }

  async fetchLatestVote() {
    const datetime = new Date();
    const dt = datetime.toISOString();
    const query = '{
      ongoing(func: type(VotingSession) @filter(le(voteFinished,' + dt + ') AND ge(voteStarted,' + dt + '))) {
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
      recent(func: type(VotingSession) gt(voteFinished,' + dt + '), orderdesc:voteFinished, first:10) {
        ~votingSessions {
          title
          officiatingbodies {
            uid
            name
          }
        }
        voteStarted
        voteEnded
        approveVotes : count(approve)
        disapproveVotes : count(disapprove)
        abstainVotes : count(abstain)
        clarificationVotes : count(requestClarification)
      }
    }';
    const res = await this.dgraph.newTxn().query(query)
    return res.data || []
  }

  async fetchAndInform() {
    let data = await this.fetchLatest();
    this.latest = data.latest || [];
    this.recent = data.recent || [];
    this.Inform();
  }
}
