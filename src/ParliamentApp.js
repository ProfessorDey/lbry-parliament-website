import React from 'react';
import logo from './logo.svg';
import { Switch, Route } from 'react-router-dom';
import FrontPage from './FrontPage';
import {VoteHome, VoteSearch} from './Vote';
import {GroupHome, GroupSearch} from './Group';
import {PeopleHome, PeopleSearch} from './People';

function ParliamentApp() {
  return (
    <Switch>
      <Route path='/' component={FrontPage} />
      {/*<Route path='/votes' component={VoteHome} />
      <Route path='/votes/:uid' component={VoteSearch} />
      <Route path='/groups' component={GroupHome} />
      <Route path='/groups/:uid' component={GroupSearch} />
      <Route path='/people' component={PeopleHome} />
      <Route path='/people/:uid' component={PeopleSearch} />*/}
    </Switch>
  );
}

export default ParliamentApp;
