import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { BottomTab } from '@/components/templates';
import { Home, Products, Profile, Services } from '@/screens';
import { Paths } from '../paths';

const Tab = createBottomTabNavigator();

// @refresh reset
const BottomTabs: React.FC = () => {
    return (
        <Tab.Navigator
            detachInactiveScreens={false}
            initialRouteName={Paths.Home}
            screenOptions={{
                headerShown: false,
            }}
            tabBar={props => <BottomTab {...props} />}
        >
            <Tab.Screen component={Home} name={Paths.Home} options={{
                tabBarLabel: "Home"
            }} />
            <Tab.Screen component={Services} name={Paths.Services} options={{
                tabBarLabel: "Services"
            }} />
            <Tab.Screen component={Products} name={Paths.Products} options={{
                tabBarLabel: "Products"
            }} />
            <Tab.Screen component={Profile} name={Paths.Profile} options={{
                tabBarLabel: "Profile"
            }} />
        </Tab.Navigator>
    );
};

export default React.memo(BottomTabs);
