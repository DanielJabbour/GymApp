import { SwitchNavigator } from 'react-navigation';
import React from 'react';
//Importing screens
import Login from '../Screens/Login/Login';
import SignUp from '../Screens/SignUp/SignUp';
import Home from '../Screens/Main/Home';

const App = SwitchNavigator(
  {
    SignUp,
    Login,
    Home,
    
  },

  {
    initialRouteName: 'Home'
  }
)