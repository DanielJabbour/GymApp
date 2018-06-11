 import React, { Component } from 'react';
 import { StyleSheet, View, TextInput, Text, TouchableOpacity, StatusBar } from 'react-native';

 export default class LoginForm extends Component {
     render() {
         return (
             <View style={styles.container}>
             
             <StatusBar 
                barStyle="light-content"
            />

                <TextInput
                    placeholder="Email"
                    placeholderTextColor="rgba(255,255,255,0.25)"
                    returnKeyType="next"
                    onSubmitEditing={()=> this.passwordInput.focus()}
                    keyboardType="email-address"
                    autoCapitalize="none"
                    autoCorrect={false}
                    style={styles.input}
                />

                <TextInput 
                    placeholder="Password"
                    placeholderTextColor="rgba(255,255,255,0.25)"
                    returnKeyType="go"
                    secureTextEntry
                    style={styles.input}
                    ref={(input) => this.passwordInput = input}
                />

                <TouchableOpacity style={styles.buttonContainer}>
                    <Text style={styles.buttonText}>Sign In</Text>
                </TouchableOpacity>

                <TouchableOpacity style={styles.buttonContainer}>
                    <Text style={styles.buttonText}>Sign Up</Text>
                </TouchableOpacity>
            </View>
         );
     }
 }

 const styles = StyleSheet.create({
     container: {
        padding: 40,
        paddingBottom: 200
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
    }
 });