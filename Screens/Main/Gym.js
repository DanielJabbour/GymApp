import React from 'react';
import { Button, Alert, Text, View, StyleSheet, StatusBar, TouchableOpacity} from 'react-native';

export default class GymScreen extends React.Component {

	_onPressButton() {
		//Actions
	  }


    render() {
      return (

		<View style={styles.container}>
			
			<TouchableOpacity onPress={this._onPressButton} underlayColor="white">
				<View style={styles.button}>
					<Text style={styles.buttonText}>Chest</Text>
				</View>
			</TouchableOpacity>

			<TouchableOpacity onPress={this._onPressButton} underlayColor="white">
				<View style={styles.button}>
					<Text style={styles.buttonText}>Back</Text>
				</View>
			</TouchableOpacity>

			<TouchableOpacity onPress={this._onPressButton} underlayColor="white">
				<View style={styles.button}>
					<Text style={styles.buttonText}>Legs</Text>
				</View>
			</TouchableOpacity>

			<TouchableOpacity onPress={this._onPressButton} underlayColor="white">
				<View style={styles.button}>
					<Text style={styles.buttonText}>Biceps</Text>
				</View>
			</TouchableOpacity>

			<TouchableOpacity onPress={this._onPressButton} underlayColor="white">
				<View style={styles.button}>
					<Text style={styles.buttonText}>Triceps</Text>
				</View>
			</TouchableOpacity>

			<TouchableOpacity onPress={this._onPressButton} underlayColor="white">
				<View style={styles.button}>
					<Text style={styles.buttonText}>Shoulders</Text>
				</View>
			</TouchableOpacity>

		</View>

		);
	  }
}

const styles = StyleSheet.create({
    container: {
		backgroundColor: '#2c3e50',
		paddingTop: 60,
		alignItems: 'center'

	  },
	  button: {
		marginBottom: 30,
		width: 260,
		alignItems: 'center',
		backgroundColor: '#2196F3'
	  },
	  buttonText: {
		padding: 20,
		color: 'white'
	  }

  })