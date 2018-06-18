
import React from 'react';
import { Platform, StyleSheet, Text, View } from 'react-native';
import { SwitchNavigator } from 'react-navigation';

//Importing screens
import Login from './Screens/Login/Login';
import SignUp from './Screens/SignUp/SignUp';
import Home from './Screens/Main/Home';

const App = SwitchNavigator(
  {
    SignUp,
    Login,
    Home,
    
  },

  {
    initialRouteName: 'Login'
  }
)

export default App