import React from 'react';
import { Text, View, StyleSheet, StatusBar } from 'react-native';

export default class SettingsScreen extends React.Component {
    render() {
      return (
        <View style={styles.container}>
            <StatusBar 
                barStyle="light-content"
            />

            <Text>Settings!</Text>
        </View>
      );
    }
  }
 
const styles = StyleSheet.create({
    container: {
      backgroundColor: '#FFF',
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center'
    }
  })