import React from 'react';
import { Button, Text, View, StyleSheet } from 'react-native';

export default class SettingsScreen extends React.Component {
    render() {
      return (
        <View style={styles.container}>
          <Text>Settings!</Text>
        </View>
      );
    }
  }
 
const styles = StyleSheet.create({
    container: {
      backgroundColor: '#2c3e50',
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center'
    }
  })