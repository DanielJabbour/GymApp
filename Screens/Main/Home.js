import React from 'react';
import { createBottomTabNavigator, createStackNavigator,} from 'react-navigation';
import { Button, Text, View, StyleSheet, StatusBar } from 'react-native';
import Ionicons from 'react-native-vector-icons/Ionicons';

import SettingsScreen from './Settings';
import DataScreen from './Data';
import GymScreen from './Gym';

class HomeScreen extends React.Component {
    render() {
      return (
        <View style={styles.container}>
			<StatusBar 
                barStyle="light-content"
            />
        	<Text>Home!</Text>
        </View>
      );
    }
  }
  
  export default createBottomTabNavigator(
    {
    Home: HomeScreen,
    Gym: GymScreen,
    Data: DataScreen,
    Settings: SettingsScreen,
    },
    {
      navigationOptions: ({ navigation }) => ({
        tabBarIcon: ({ focused, tintColor }) => {
          const { routeName } = navigation.state;
          let iconName;

          if (routeName === 'Home') {
            iconName = `ios-home${focused ? '' : '-outline'}`;
          }
          else if (routeName === 'Gym') {
            iconName = `ios-pulse${focused ? '' : '-outline'}`;
          }
          else if (routeName === 'Data') {
            iconName = `ios-options${focused ? '' : '-outline'}`;
          }
          else if (routeName === 'Settings') {
            iconName = `ios-settings${focused ? '' : '-outline'}`;
          }

          return <Ionicons name={iconName} size={25} color={tintColor} />;
        },
      }),
      tabBarOptions: {
        activeTintColor: '#2980b9',
        inactiveTintColor: 'gray',
      },
    }
  );

  const styles = StyleSheet.create({
    container: {
      backgroundColor: '#2c3e50',
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center'
    }
  })