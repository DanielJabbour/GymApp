import React from 'react';
import { Text, View, StyleSheet } from 'react-native';

export default class BackScreen extends React.Component {
	render() {
	  return (
		<View style={styles.container}>
		  <Text>Back Screen</Text>
		</View>
	  );
	}
  }


const styles = StyleSheet.create({
    container: {
		backgroundColor: '#2c3e50',
    }

  });