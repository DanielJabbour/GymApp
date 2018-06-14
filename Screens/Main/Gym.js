import React from 'react';
import { Text, View, StyleSheet, StatusBar, TouchableOpacity, ScrollView} from 'react-native';
import { createStackNavigator } from 'react-navigation';

import ChestScreen from './GymScreens/Chest';
import AbsScreen from './GymScreens/Abs';
import BackScreen from './GymScreens/Back';
import BicepScreen from './GymScreens/Biceps';
import LegsScreen from './GymScreens/Legs';
import ShouldersScreen from './GymScreens/Shoulders';
import TricepsScreen from './GymScreens/Triceps';

class GymScreen extends React.Component {

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

				<TouchableOpacity onPress={() => this.props.navigation.navigate('Chest')} underlayColor="white">
					<View style={styles.button}>
						<Text style={styles.buttonText}>Chest</Text>
					</View>
				</TouchableOpacity>

				<TouchableOpacity onPress={() => this.props.navigation.navigate('Back')} underlayColor="white">
					<View style={styles.button}>
						<Text style={styles.buttonText}>Back</Text>
					</View>
				</TouchableOpacity>

				<TouchableOpacity onPress={() => this.props.navigation.navigate('Abs')} underlayColor="white">
					<View style={styles.button}>
						<Text style={styles.buttonText}>Abs</Text>
					</View>
				</TouchableOpacity>

				<TouchableOpacity onPress={() => this.props.navigation.navigate('Legs')} underlayColor="white">
					<View style={styles.button}>
						<Text style={styles.buttonText}>Legs</Text>
					</View>
				</TouchableOpacity>

				<TouchableOpacity onPress={() => this.props.navigation.navigate('Biceps')} underlayColor="white">
					<View style={styles.button}>
						<Text style={styles.buttonText}>Biceps</Text>
					</View>
				</TouchableOpacity>

				<TouchableOpacity onPress={() => this.props.navigation.navigate('Triceps')} underlayColor="white">
					<View style={styles.button}>
						<Text style={styles.buttonText}>Triceps</Text>
					</View>
				</TouchableOpacity>

				<TouchableOpacity onPress={() => this.props.navigation.navigate('Shoulders')} underlayColor="white">
					<View style={styles.button}>
						<Text style={styles.buttonText}>Shoulders</Text>
					</View>
				</TouchableOpacity>

			</View>
		</ScrollView>

		);
	  }
}

const RootStack = createStackNavigator(
	{
		Gym: GymScreen,
		Chest: ChestScreen,
		Ticeps: TricepsScreen,
		Shoulders: ShouldersScreen,
		Biceps: BicepScreen,
		Back: BackScreen,
		Abs: AbsScreen,

	},
	{
		initialRouteName: 'Gym',
	}
);

export default class Gym extends React.Component {
	render() {
		return <RootStack />;
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