import React from 'react';
import { createBottomTabNavigator, createStackNavigator,} from 'react-navigation';
import { Button, Text, View, StyleSheet } from 'react-native';
import Ionicons from 'react-native-vector-icons/Ionicons';

import SettingsScreen from './Settings';


class HomeScreen extends React.Component {
    render() {
      return (
        <View style={styles.container}>
          <Text>Home!</Text>
        </View>
      );
    }
  }
  
  export default createBottomTabNavigator({
    Home: HomeScreen,
    Settings: SettingsScreen,
  });

  const styles = StyleSheet.create({
    container: {
      backgroundColor: '#2c3e50',
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center'
    }
  })