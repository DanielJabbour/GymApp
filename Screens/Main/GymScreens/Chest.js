import React from 'react';
import { Text, View, StyleSheet } from 'react-native';

export default class ChestScreen extends React.Component {
	render() {
	  return (
		<View style={styles.container}>
		  <Text>Chest Screen</Text>
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