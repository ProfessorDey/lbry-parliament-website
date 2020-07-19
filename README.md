# LBRY Foundation Parliamentary Voting System Website

The public facing website for viewing ongoing and historical votes within the LBRY Foundation. In order to provide a robust means of handling votes from multiple groups within the LBRY Foundation, the Parliamentary Voting System was devised as an external and publicly accessible system for transparent and open decision making.

The Website portion of this system is intended to provide user friendly and detailed information on every vote that has taken place since the site was first written, as well as providing profiles for every group and individual that takes part in the parliamentary system. This will allow for complete transparency in moderation,  It has been built with a graph database back end, in this case DGraph, instead of the typical SQL database for maximum flexibility and efficiency.

# Feature Set
While still a work in progress, I can go into what the various functions of the website are intended to be, if you're looking for more technical information, see the Technical Background section below.

## Ongoing Voting Session List (Front page)

First and foremost, the front page is intended to provide a detailed starting point for a user, with a list of currently ongoing Voting Sessions, including the officiating bodies allowed to vote, the voting options and the current voting tally, represented as individual blocks for each voting member. It will also provide hover-over information for each vote, allowing users to not only see who voted what way, but when as well as their reasoning. Clarification Requests will also be visible, allowing for users to quickly see the questions and answers in ongoing Voting Sessions.

Clicking on any of these votes or the Officiating Groups' names will take the user to the voting member's/group's profile page respectively, while clicking on the title of the Voting Session will take the user to that Vote's information page.

## Historical Vote Listings

In addition to ongoing votes, the previously completed votes will also be readily available and summarized on the front page, with the dates of the listed sessions and the summarized outcome, clicking on any of these summaries will link the user to the appropriate Vote Information page where they can peruse the relevant information in more detail.

## Detailed Vote Information Pages

The Vote information pages contain the full details of the vote, including the full description that defines the exact terms of the vote, a complete list of all present and possible votes, a list of valid voters who have yet to vote, all related files and materials provided as linked assets as well as a complete list of Clarification requests and whether a response has been given for each. The subject tags are also provided to allow for subject specific searches once more votes take place.

## Individual and Group Profile Pages

With the goal of transparency in mind, every individual and group who is directly involved in the Parliamentary Voting System is assigned a unique profile, allowing for users to look up exactly what decisions are involving whom and helping them understand who are the ones making the decisions. With the ability to see a complete voting history and their individual Clarification Requests, users can understand what groups and individuals care about most and find the contact details needed to reach out to them and get their voices heard. Wallet addresses are also provided to allow for tipping those the user feels deserve it for their hard work. As these addresses are publicly known, these can also be tracked by avid users concerned about donations being exploited as well as ensuring that funds promised by a proposal vote are in fact received.

# Technical Background

As described in the introduction, the Parliamentary Voting System in built on a Graph Database backend called DGraph, which allows for heavily optimized, node based queries, instead of SQL's rigid table system, this flexibility is essential for describing the complex relationships between entities stored by the Voting System and even allows for extensible vote types beyond Yes, No, Abstain. At present the only limitation is in querying such flexible systems from the website side and thus this initial implementation only had the YesNoVote type, but this will be rectified with time and effort.

The website itself is a standard React application running in the browser with GRPC queries to the database occurring after the routing stage, while this is still in initial testing it is expected that this should reduce the number of queries to the server overall, instead of having to query the entire database for every user. The intention is to add hourly caching for most information to further limit the requests, but with the present limited datasets this is not yet required.

## Schema and Test Data

The schema for the database is presently defined in `scripts/createSchema.sh` and this script allows for simple replication of the Parliamentary Voting System database on any blank DGraph Zero instance. Note that this script drops all existing data on the database, so take care when using it to ensure you don't wipe valuable data.

Regarding test data, the main instance utilizes real world non-anonymized data from Veteran and Creator Council votes held during development, as such the data is not presently provided, an anonymized test data script will be written in the future once the system is ready for decentralized/federated use.

## Queries and Public API

While there is no public Query API presently available for the system, once deployed a rate-limited query system for external analytics will be implemented to allow other app developers to utilize the same data.

Internally the Voting System uses straightforward GRPC queries using DGraph's inbuilt GraphQL+- query language derived from the Facebook developed GraphQL, which is syntactically near-identical, though DGraph documentation can be referenced for further information on the distinctions.

## Build from Source

At present no build instructions are provided beyond the general steps to replicate the system.
>1. Install Go Version 1.13.2+
>2. Install Dgraph from Source to avoid licence restrictions
>3. Clone this repository into a directory accessible to your web server of choice.
>4. Start a DGraph Zero instance as follows:
>`dgraph zero --my=localhost:5080 --enable_sentry=false`
>5. Run DGraph Alpha instance as follows:
>`dgraph alpha --zero=localhost:5080 --enable_sentry=false --lru_mb=4096`
>6. Load database schema using provided script:
>`bash -x scripts/createSchema.sh`.
>7. Load test data manually using curl:
>`curl -H "Content-Type: application/rdf" -X POST localhost:8080/mutate?commitNow=true -d $'{ set: { _RDF_Triples_Go_Here_ } }'`
>8. Test system with the provided test query script:
>`bash -x scripts/testquery.sh`
>9. Build and launch the React Website with the usual NPM commands:
>`npm install && npm build && npm start`

Beyond that, good luck and have fun!

# Contact Details
Developer : ProfessorDey (Joshua Hayes)
LBRY Foundation Veteran Council Member
LBRY-C Core Team Member (Not affiliated with LBRY Inc)

Email : joshua (dot) hayesandassociates (dot) eu
Discord Username : @ProfessorDey #1578
LBRY Foundation Discord Server : https:// chat (dot) lbry (dot) com
LBRY-C Discord Server : https:// invite (dot) lbry (dot) community
