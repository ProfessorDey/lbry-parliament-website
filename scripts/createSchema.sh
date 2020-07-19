#!/bin/bash
curl -X POST localhost:8080/alter -d '{"drop_all": true}' && \
curl localhost:8080/alter -d '
name: string @index(term) @lang .
dob: dateTime .
description: string @lang .
location: geo @index(geo) .
iconURL: string .

members: [uid] @count @reverse .
created: dateTime .

emails: [string] @index(term) .
discordUID: int @index(int) .
weblinks: [string] @index(term) .

title: string @index(term) @lang .
claimID: string @index(exact) .
owners: [uid] @count @reverse .

voteType: string @index(term) .
officiatingBodies: [uid] @count @reverse .
relevantParties: [uid] @count @reverse .
subjectTags: [string] @index(term) .
votingSessions: [uid] @count @reverse .

voteStarted: dateTime @index(hour) .
voteFinished: dateTime @index(hour) .

approve: [uid] @count @reverse .
disapprove: [uid] @count @reverse .
abstain: [uid] @count @reverse .
requestClarification: [uid] @count @reverse .

voteCast: dateTime @index(hour) .
voteBy: uid @reverse .

requestedUSD: int @index(int) .
walletAddress: string @index(exact) .
paymentMovingAverage: int @index(int) .
paymentDate: dateTime @index(day) .
paymentAmountLBC: int @index(int) .

type Person {
	name
	dob
	description
	location
	iconURL
}

type Group {
	name
	description
	iconURL
	members
	created
}

type Contactable {
	emails
	weblinks
	discordUID
}

type LBRYContent {
	title
	claimID
	description
	owners
}

type Vote {
	title
	voteType
	description
	officiatingBodies
	relevantParties
	subjectTags
	votingSessions
}

type VotingSession {
	voteStarted
	voteFinished
	requestClarification
}

type YesNoVote {
	approve
	disapprove
	abstain
}

type VotingParty {
	voteCast
	voteBy
	description
}

type Proposal {
	requestedUSD
	walletAddress
	paymentMovingAverage
	paymentDate
	paymentAmountLBC
}
' 
