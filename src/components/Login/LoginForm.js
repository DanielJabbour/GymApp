 import React, { Component } from 'react';
 import { StyleSheet, View, TextInput } from 'react-native';

 export default class LoginForm extends Component {
     render() {
         return (
             <View style={styles.container}>
                <TextInput
                    placeholder="Email"
                    style={styles.input}
                />

                <TextInput 
                    placeholder="Password"
                    style={styles.input}
                />
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
    }
 });