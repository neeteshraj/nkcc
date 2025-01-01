import { AssetByVariant, ButtonVariant, TextByVariant } from '@/components/atoms';
import { Paths } from '@/navigation/paths';
import type { RootStackParamList } from '@/navigation/types';
import { useTheme } from '@/theme';
import { useNavigation } from '@react-navigation/native';
import type { StackNavigationProp } from '@react-navigation/stack';
import type { FC } from 'react';
import React from 'react'
import { useTranslation } from 'react-i18next';
import { View } from 'react-native'


/**
* @author Nitesh Raj Khanal
* @function @Onboarding
**/

const Onboarding: FC = () => {

    const { components, gutters, layout } = useTheme()

    const { t } = useTranslation(["onboarding"])

    const navigation = useNavigation<StackNavigationProp<RootStackParamList, Paths.Onboarding>>();

    const navigateAction = () => {
        navigation.navigate(Paths.QRScan); 
    };

    return (
        <View style={[layout.flex_1]}>
            <AssetByVariant
                extension='mp4'
                path="splash_screen"
                paused={false}
                repeat={true}
                style={[components.absoluteFill]}
            />
            <View style={[components.overlay, layout.flex_1, layout.justifyEnd, layout.itemsCenter, gutters.paddingHorizontal_38]} >
                <AssetByVariant
                    extension='png'
                    path="logo_onboarding"
                    style={[layout.width150, layout.height150]}
                />
                <TextByVariant
                    style={[components.bebasNeueTitle, gutters.marginTop_12]}
                >
                    {t("onboarding:onboarding_title_1")}
                </TextByVariant>
                <TextByVariant style={[components.interDescription, gutters.marginVertical_24]}>
                    {t("onboarding:onboarding_description_1")}
                </TextByVariant>

                <ButtonVariant onPress={navigateAction} style={[components.primaryButton, gutters.marginVertical_12]}>
                    <TextByVariant style={[components.interDescriptionBlack]}>
                        {t("onboarding:scan_to_add_product")}
                    </TextByVariant>
                </ButtonVariant>

                <ButtonVariant style={[components.textButton, gutters.marginBottom_12]}>
                    <TextByVariant style={[components.interDescription]}>
                        {t("onboarding:enter_code_to_add_product")}
                    </TextByVariant>
                </ButtonVariant>
            </View>

        </View>
    )
}

export default React.memo(Onboarding)