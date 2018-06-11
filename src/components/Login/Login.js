import React, {Component} from 'react';
import {StyleSheet, View, Image, Text, KeyboardAvoidingView} from 'react-native';
import LoginForm from './LoginForm'; //Importing login form view

export default class Login extends Component {
  render() {
    return (
      //Keyboard avoiding view for adjusting view when users bring up phone keyboard
      //View render structure corresponding to stylesheet
      <KeyboardAvoidingView behavior="padding" style={styles.container}>
        <View style={styles.container}>
          <View style={styles.logoContainer}>
            {/*<Image
              style = {styles.logo}
              source = {require("image URL")}
            />*/}
            <Text style={styles.title}>A fitness analytics application</Text>
          </View>

          <View style={styles.formContainer}>
            <LoginForm/>
          </View>
        </View>
      </KeyboardAvoidingView>
    );
  }
}

//Stylesheet definition
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#2c3e50'
  },
  logoContainer: {
    alignItems: 'center',
    flexGrow: 1,
    justifyContent: 'center'
  },
  logo: {
    width: 100,
    height: 100
  },
  title: {
    color: '#FFF',
    marginTop: 10,
    width: 160,
    textAlign: 'center',
  }
});
