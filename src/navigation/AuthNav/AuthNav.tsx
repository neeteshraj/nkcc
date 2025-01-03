import { Home, ProductDetails } from "@/screens";
import { Paths } from "../paths";
import type { FC } from "react";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import BottomTab from "../BottomTab/BottomTab";

const AuthStack = createNativeStackNavigator();

//@refresh reset
const AuthenticatedNavigator: FC = () => {
    return (
        <AuthStack.Navigator initialRouteName={Paths.BottomTab}
            screenOptions={{
                animation: 'ios_from_right',
                animationDuration: 0.01,
                gestureEnabled: true,
                headerShown: false,
            }}>
            <AuthStack.Screen component={BottomTab} name={Paths.BottomTab} />
            <AuthStack.Screen component={Home} name={Paths.Home} />
            <AuthStack.Screen component={ProductDetails} name={Paths.ProductDetails} />
        </AuthStack.Navigator>
    )
}

export default AuthenticatedNavigator