import React, {Component} from 'react';
import {StyleSheet, View, Image, Text, KeyboardAvoidingView, StatusBar, Button, TextInput} from 'react-native';
import firebase from 'react-native-firebase';

export default class Login extends Component {

  state = { email: '', password: '', errorMessage: null }

  handleLogin = () => {
    const { email, password } = this.state
    firebase
      .auth()
      .signInWithEmailAndPassword(email, password)
      .then(() => this.props.navigation.navigate('Main'))
      .catch(error => this.setState({errorMessage: error.message}))
  }

  render() {
    return (
      //Keyboard avoiding view for adjusting view when users bring up phone keyboard
      //View render structure corresponding to stylesheet
      <KeyboardAvoidingView behavior="padding" style={styles.container}>
        <View style={styles.container}>
          <StatusBar 
            barStyle="light-content"
              />

          <View style={styles.logoContainer}>
            {/*<Image
              style = {styles.logo}
              source = {require("image URL")}
            />*/}
            <Text style={styles.title}>A fitness analytics application</Text>
          </View>

          <View style={styles.formContainer}>
            <TextInput
                placeholder="Email"
                placeholderTextColor="rgba(255,255,255,0.25)"
                returnKeyType="next"
                onSubmitEditing={()=> this.passwordInput.focus()}
                keyboardType="email-address"
                autoCapitalize="none"
                autoCorrect={false}
                style={styles.input}
                onChangeText={email => this.setState({ email })}
                value={this.state.email}
              />

            <TextInput 
                placeholder="Password"
                placeholderTextColor="rgba(255,255,255,0.25)"
                returnKeyType="go"
                secureTextEntry
                style={styles.input}
                onChangeText={password => this.setState({ password })}
                value={this.state.password}
            />

            <Button
                title="Sign In"
                style={styles.buttonText}
                onPress={()=> this.handleLogin()}
            />

            <Button 
                title="Sign Up" 
                style={styles.buttonText}
                onPress={() => this.props.navigation.navigate('SignUp')}
            />
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
    },

  input: {
      color: 'white',
      height: 40,
      marginBottom: 20,
      paddingHorizontal: 5,
      borderBottomWidth: 2,
      borderBottomColor: '#FFF'
  },

  buttonContainer: {
      paddingVertical: 15
  },

  buttonText: {
      textAlign: 'center',
      color: '#FFF',
      fontWeight: '700'
  },
  formContainer: {
    padding: 40,
    paddingBottom: 200
 }
});
