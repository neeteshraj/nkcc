import { CreateAccount, Onboarding, PrivacyPolicy, QRScan, TermsOfUse } from "@/screens";
import { Paths } from "../paths";
import type { FC } from "react";
import { createNativeStackNavigator } from "@react-navigation/native-stack";

const UnAuthStack = createNativeStackNavigator();

//@refresh reset
const UnAuthenticatedNavigator: FC = () => {
    return (
        <UnAuthStack.Navigator initialRouteName={Paths.Onboarding}
            screenOptions={{
                animation: 'ios_from_right',
                animationDuration: 0.01,
                gestureEnabled: true,
                headerShown: false,
            }}>
            <UnAuthStack.Screen component={CreateAccount} name={Paths.CreateAccount} />
            <UnAuthStack.Screen component={Onboarding} name={Paths.Onboarding} />
            <UnAuthStack.Screen component={QRScan} name={Paths.QRScan} />
            <UnAuthStack.Screen component={PrivacyPolicy} name={Paths.PrivacyPolicy} />
            <UnAuthStack.Screen component={TermsOfUse} name={Paths.TermsOfUse} />
        </UnAuthStack.Navigator>
    )
}

export default UnAuthenticatedNavigator