
import React, { Component } from 'react';
import { Platform, StyleSheet, Text, View } from 'react-native';
import { SwitchNavigator } from 'react-navigation';

//Importing screens
import Login from './Screens/Login/Login';
import SignUp from './Screens/SignUp/SignUp';
import Main from './Screens/Main/Main';

// export default class App extends Component {
//   render() {
//     SwitchNavigator(
//       {
//             SignUp,
//             Login,
//             Main,
//           },
        
//           {
//             initialRouteName: 'Main'
//           }
//     )
//   }
// }

const App = SwitchNavigator(
  {
    SignUp,
    Login,
    Main,
  },

  {
    initialRouteName: 'Main'
  }
)

export default App

// type Props = {};

// export default class App extends Component<Props> {
//   render() {
//     return (
//       <Login/>
//     );
//   }
// }

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});