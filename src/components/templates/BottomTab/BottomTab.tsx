import type { FC } from 'react';
import React, { useCallback } from 'react';
import { View } from 'react-native';
import type { BottomTabBarProps } from '@react-navigation/bottom-tabs';
import { useTheme } from '@/theme';
import { useTranslation } from 'react-i18next';
import { AssetByVariant, ButtonVariant, TextByVariant } from '@/components/atoms';
import { Paths } from '@/navigation/paths';

/**
 * @function BottomTab
 * @param state, descriptors, navigation
 * @returns JSX.Element
 * @description BottomTab component for bottom tab navigation bar
 * @author Nitesh Raj Khanal
 */

const BottomTab: FC<BottomTabBarProps> = ({
    descriptors,
    navigation,
    state,
}) => {
    const { backgrounds, borders, components, gutters, layout } = useTheme();

    const { t } = useTranslation(["bottomTab"])

    const icons = {
        Home: "home",
        Products: "products",
        Profile: "profile",
        Services: "services"
    };

    const iconsFilled = {
        Home: "home_active",
        Products: "products_active",
        Profile: "profile_active",
        Services: "services_active"
    };

    return (
        <View
            style={[
                layout.row, layout.justifyBetween,
                gutters.paddingVertical_12,
                backgrounds.background,
                borders.wTop_1,
                borders.gray400
            ]}
        >

            {state.routes.map((route, index) => {
                const { options } = descriptors[route.key];

                const isFocused = state.index === index;

                const onPress = useCallback(() => {
                    const event = navigation.emit({
                        canPreventDefault: true,
                        target: route.key,
                        type: 'tabPress',
                    });

                    if (!isFocused && !event.defaultPrevented) {
                        navigation.navigate(route.name);
                    }
                }, [isFocused, route.key, route.name]);

                const onLongPress = useCallback(() => {
                    navigation.emit({
                        target: route.key,
                        type: 'tabLongPress',
                    });
                }, [route.key]);

                return (
                    <ButtonVariant
                        accessibilityLabel={options.tabBarAccessibilityLabel}
                        accessibilityRole="button"
                        accessibilityState={isFocused ? { selected: true } : {}}
                        key={route.key}
                        onLongPress={onLongPress}
                        onPress={onPress}
                        style={[layout.flex_1, layout.justifyCenter, layout.itemsCenter]}
                    >
                        <View style={[layout.itemsCenter, layout.justifyCenter]}>
                            <AssetByVariant
                                extension="png"
                                path={route.name === Paths.Home ? isFocused ? iconsFilled.Home : icons.Home : route.name === Paths.Services ? isFocused ? iconsFilled.Services : icons.Services : route.name === Paths.Products ? isFocused ? iconsFilled.Products : icons.Products : isFocused ? iconsFilled.Profile : icons.Profile}
                                style={[
                                    layout.height24,
                                    layout.width24,
                                    gutters.marginVertical_4,
                                ]}
                            />
                            <TextByVariant style={[gutters.marginVertical_4, isFocused ? components.interDescription12Primary : components.interDescription12white70]}>{route.name === Paths.Home ? t("bottomTab:home") : route.name === Paths.Services ? t("bottomTab:services") : route.name === Paths.Products ? t("bottomTab:products") : route.name === Paths.Profile ? t("bottomTab:profile") : null}</TextByVariant>
                        </View>
                    </ButtonVariant>
                );
            })}
        </View>
    );
};

export default React.memo(BottomTab);
