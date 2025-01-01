import { AssetByVariant } from '@/components/atoms';
import { useTheme } from '@/theme';
import React, { useEffect } from 'react';
import Animated, {
    Easing,
    useAnimatedStyle,
    useSharedValue,
    withRepeat,
    withTiming,
} from 'react-native-reanimated';
/**
 * @author Nitesh Raj Khanal
 * @function @Brand
 **/

const Brand = ({
    height =150,
    isLoading = false,
    width = 150,
}) => {
    const { layout } = useTheme();
    const scale = useSharedValue(1);

    useEffect(() => {
        scale.value = isLoading ? withRepeat(
            withTiming(1.1, {
                duration: 500,
                easing: Easing.inOut(Easing.ease),
            }),
            -1,
            true,
        ) : withTiming(1, {
            duration: 500,
            easing: Easing.inOut(Easing.ease),
        });
    }, [isLoading, scale]);

    const animatedStyle = useAnimatedStyle(() => {
        return {
            transform: [{ scale: scale.value }],
        };
    });


    return (
        <Animated.View
            style={[{ height, width }, animatedStyle, { alignItems: 'center' }]}
            testID="brand-img-wrapper"
        >
            <AssetByVariant
                extension={"png"}
                path={'logo'}
                resizeMode={'contain'}
                style={[layout.width150, layout.height150]}
            />
        </Animated.View>
    );
};

export default Brand;
