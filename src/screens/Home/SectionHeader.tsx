import type { FC } from 'react';
import React from 'react';
import { View } from 'react-native';
import { useTheme } from '@/theme';
import { SearchBar } from '@/components/molecules';
import { Categories } from '@/components/organisms';
import { useTranslation } from 'react-i18next';

/**
 * @author Nitesh Raj Khanal
 * @function @ListHeader
 */
const ListHeader: FC = React.memo(() => {
    const { t } = useTranslation(['home']);
    const { colors, gutters } = useTheme();

    return (
        <>
            <View style={[gutters.marginVertical_16]}>
                <SearchBar
                    autoCapitalize="none"
                    cursorColor={colors.white}
                    placeholder={t('home:searchProduct')}
                    placeholderTextColor={colors.white50}
                    returnKeyLabel="done"
                    returnKeyType="done"
                    selectionColor={colors.white}
                />
            </View>
            <View style={[gutters.marginVertical_16]}>
                <Categories />
            </View>
        </>
    );
});

export default ListHeader;
