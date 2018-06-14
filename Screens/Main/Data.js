import React from 'react';
import { Text, View, StyleSheet, StatusBar } from 'react-native';

export default class DataScreen extends React.Component {
    render() {
      return (
        <View style={styles.container}>
            <StatusBar 
                barStyle="light-content"
            />

            <Text>Data!</Text>
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