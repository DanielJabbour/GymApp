import React from 'react';
import { Button, Text, View, StyleSheet, StatusBar, TouchableOpacity, ScrollView} from 'react-native';

export default class GymScreen extends React.Component {

	_onPressButton() {
		//Actions
	  }


    render() {
      return (

		<ScrollView >

			<StatusBar 
                barStyle="light-content"
            />

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
		</ScrollView>

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
		marginBottom: 60,
		width: 260,
		alignItems: 'center',
		backgroundColor: '#2196F3'
	  },
	  buttonText: {
		padding: 40,
		color: 'white'
	  }

  })