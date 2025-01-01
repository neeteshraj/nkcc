import { Home } from "@/screens";
import { Paths } from "../paths";
import type { FC } from "react";
import { createNativeStackNavigator } from "@react-navigation/native-stack";

const AuthStack = createNativeStackNavigator();

//@refresh reset
const AuthenticatedNavigator:FC = () => {
    return (
        <AuthStack.Navigator initialRouteName={Paths.Home}
        screenOptions={{
            animation: 'ios_from_right',
            animationDuration: 0.01,
            gestureEnabled: true,
            headerShown: false,
        }}>
            <AuthStack.Screen component={Home} name={Paths.Home} />
        </AuthStack.Navigator>
    )
}

export default AuthenticatedNavigator