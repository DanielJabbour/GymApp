
import React from 'react';
import { StyleSheet, Text, TextInput, View, Button, StatusBar } from 'react-native';
import firebase from 'react-native-firebase';

export default class SignUp extends React.Component {
  state = { email: '', password: '', errorMessage: null }

    handleSignUp = () => {
        firebase
            .auth()
            .createUserWithEmailAndPassword(this.state.email, this.state.password)
            .then(()=> this.props.navigation.navigate('Home'))
            .catch(error => this.setState({errorMessage: error.message}))
    }

    render() {
        return (
        <View style={styles.container}>
            <StatusBar 
                barStyle="light-content"
            />

            {this.state.errorMessage &&
            <Text style={{ color: 'red' }}>
                {this.state.errorMessage}
            </Text>}
            
            <View style={styles.formContainer}>

                <TextInput
                placeholder="Name"
                placeholderTextColor="rgba(255,255,255,0.25)"
                style={styles.textInput}
                />

                <TextInput
                placeholder="Email"
                placeholderTextColor="rgba(255,255,255,0.25)"
                autoCapitalize="none"
                style={styles.textInput}
                onChangeText={email => this.setState({ email })}
                value={this.state.email}
                />

                <TextInput
                secureTextEntry
                placeholder="Password"
                placeholderTextColor="rgba(255,255,255,0.25)"
                autoCapitalize="none"
                style={styles.textInput}
                onChangeText={password => this.setState({ password })}
                value={this.state.password}
                />

            </View>

            <Button 
                title="Sign Up" 
                onPress={this.handleSignUp}
            />

            <Button
                title="Already have an account? Login"
                onPress={() => this.props.navigation.navigate('Login')}
            />

        </View>
        )
    }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#2c3e50'
  },

  textInput: {
    color: 'white',
    height: 40,
    marginBottom: 20,
    paddingHorizontal: 5,
    borderBottomWidth: 2,
    borderBottomColor: '#FFF'
  },

  formContainer: {
    paddingTop: 200,
    padding: 40,
    justifyContent: 'center'
 }
})