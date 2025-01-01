import type { RootScreenProps } from '@/navigation/types';

import React, { useEffect } from 'react';
import { View } from 'react-native';

import { useTheme } from '@/theme';
import { Paths } from '@/navigation/paths';

import { SafeScreen } from '@/components/templates';
import { Brand } from '@/components/molecules';

const Startup = ({ navigation }: RootScreenProps<Paths.Startup>) => {
    const { layout } = useTheme();

    useEffect(() => {
        const timeout = setTimeout(() => {
            navigation.reset({
                index: 0,
                routes: [{ name: Paths.UnAuthenticated }],
            });
        }, 1000);

        return () => clearTimeout(timeout);
    }, [navigation]);

    return (
        <SafeScreen>
            <View
                style={[
                    layout.flex_1,
                    layout.col,
                    layout.itemsCenter,
                    layout.justifyCenter,
                ]}
            >
                <Brand isLoading />
            </View>
        </SafeScreen>
    );
}

export default React.memo(Startup);
