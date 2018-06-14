import React from 'react';
import { Text, View, StyleSheet } from 'react-native';

export default class AbsScreen extends React.Component {
	render() {
	  return (
		<View style={styles.container}>
		  <Text>Abs Screen</Text>
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