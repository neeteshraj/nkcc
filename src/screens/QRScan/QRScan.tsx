import { AssetByVariant, ButtonVariant, TextByVariant } from '@/components/atoms';
import { SafeScreen } from '@/components/templates';
import type { Paths } from '@/navigation/paths';
import type { RootStackParamList } from '@/navigation/types';
import { useTheme } from '@/theme';
import { useNavigation } from '@react-navigation/native';
import type { StackNavigationProp } from '@react-navigation/stack';
import LottieView from 'lottie-react-native';
import type { FC } from 'react';
import React from 'react';
import { useTranslation } from 'react-i18next';
import { Alert, StyleSheet, View } from 'react-native';
import { Camera, useCameraDevice, useCameraPermission } from 'react-native-vision-camera';

/**
* @author Nitesh Raj Khanal
* @function @QRScan
**/

const QRScan: FC = () => {
    const { borders, components, gutters, layout } = useTheme();
    const { t } = useTranslation(['QRCode']);

    const navigation = useNavigation<StackNavigationProp<RootStackParamList, Paths.QRScan>>();

    const device = useCameraDevice('back');
    const { hasPermission, requestPermission } = useCameraPermission();

    if (!hasPermission) {
        requestPermission();
    }

    if (device == null) {
        Alert.alert(t('QRCode:error'), t('QRCode:camera_not_found'));
    }

    const backAction = () => {
        navigation.goBack();
    }

    return (
        <SafeScreen style={[layout.flex_1]}>
            <View style={[layout.row, layout.z10, layout.itemsCenter]}>
                <ButtonVariant
                    onPress={backAction}
                    style={[layout.height40, layout.width40, components.overlayPart, borders.rounded_500, layout.itemsCenter, layout.justifyCenter, gutters.marginHorizontal_16]}
                >
                    <AssetByVariant
                        extension='png'
                        path="arrow_left"
                        resizeMode='contain'
                        style={[layout.height24, layout.width24]}
                    />
                </ButtonVariant>
                <TextByVariant style={[components.interDescription18]}>{t("QRCode:scanQRCode")}</TextByVariant>
            </View>
            {device && (
                <Camera
                    device={device}
                    isActive={true}
                    style={StyleSheet.absoluteFillObject}
                />
            )}

            <View
                style={[
                    components.overlayPart,
                    layout.absolute,
                    layout.top0,
                    layout.height20Percentage,
                    layout.overflowHidden,
                    layout.z1,
                    layout.fullWidth
                ]}
            />
            <View
                style={[
                    components.overlayPart,
                    layout.absolute,
                    layout.bottom0,
                    layout.height20Percentage,
                    layout.overflowHidden,
                    layout.z1,
                    layout.fullWidth
                ]}
            />

            <View
                style={[
                    components.overlayPart,
                    layout.absolute,
                    layout.left0,
                    layout.width5percentage,
                    layout.overflowHidden,
                    layout.z1,
                    layout.height60Percent,
                    layout.top20Percentage
                ]}
            />

            <View
                style={[
                    components.overlayPart,
                    layout.absolute,
                    layout.right0,
                    layout.width5percentage,
                    layout.overflowHidden,
                    layout.z1,
                    layout.height60Percent,
                    layout.top20Percentage
                ]}
            />


            <View
                style={[
                    layout.absolute,
                    layout.top20Percentage,
                    layout.bottom20Percentage,
                    layout.flex_1,
                    layout.justifyBetween,
                    layout.alignSelfCenter,
                    layout.itemsStretch,
                    layout.height60Percent,
                    layout.width90Percentage,
                    layout.overflowHidden,
                ]}
            >
                <View style={[layout.row, layout.justifyBetween, layout.fullWidth]}>
                    <AssetByVariant
                        extension="png"
                        path="top_left"
                        style={[layout.width40, layout.height40, layout.bottom0, layout.left0]}
                    />
                    <AssetByVariant
                        extension="png"
                        path="top_right"
                        style={[layout.width40, layout.height40, layout.bottom0, layout.right0]}
                    />
                </View>
                <View style={[layout.row, layout.justifyBetween, layout.fullWidth]}>
                    <AssetByVariant
                        extension="png"
                        path="bottom_left"
                        style={[layout.width40, layout.height40, layout.bottom0, layout.left0]}
                    />
                    <AssetByVariant
                        extension="png"
                        path="bottom_right"
                        style={[layout.width40, layout.height40, layout.bottom0, layout.right0]}
                    />
                </View>
            </View>
            <View style={[layout.fullWidth, layout.fullHeight, layout.z1]}>
                <LottieView
                    autoPlay
                    loop
                    // eslint-disable-next-line @typescript-eslint/no-require-imports
                    source={require('@/theme/assets/lottie/scan_qr.lottie')}
                    speed={1.5}
                    style={[{height:"100%"}, layout.fullWidth, layout.z10, layout.flex_1]}
                    
                />
            </View>
        </SafeScreen>
    );
};

export default React.memo(QRScan);
