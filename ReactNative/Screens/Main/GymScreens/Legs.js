import React from 'react';
import { Text, View, StyleSheet } from 'react-native';

export default class LegsScreen extends React.Component {
	render() {
	  return (
		<View style={styles.container}>
		  <Text>Legs Screen</Text>
		</View>
	  );
	}
  }


const styles = StyleSheet.create({
    container: {
		backgroundColor: '#FFF',
		alignItems: 'center',
		flex: 1,
    }

  });