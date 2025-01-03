import { AssetByVariant, TextByVariant } from '@/components/atoms';
import { useTheme } from '@/theme';
import type { FC } from 'react';
import React from 'react';
import { FlatList, View } from 'react-native';

/**
* @author Nitesh Raj Khanal
* @function @Categories
**/

const Categories: FC = () => {

    const { borders, components, gutters, layout } = useTheme()

    const categories = [
        {
            extension: 'jpg',
            id: '1',
            name: 'UV Filter',
            path: 'uv_purifier'
        },
        {
            extension: 'jpg',
            id: '2',
            name: 'UF Filter',
            path: 'uf_purifier'
        },
        {
            extension: 'jpg',
            id: '3',
            name: 'RO Filter',
            path: 'ro_purifier'
        }
    ];

    const renderCategory = ({ item }: { item: typeof categories[0] }) => (
        <View key={item.id} style={[, layout.itemsCenter, borders.w_1, borders.white70, borders.rounded_8, gutters.paddingVertical_14, gutters.paddingHorizontal_32]}>
            <AssetByVariant
                extension={item.extension}
                path={item.path}
                resizeMode='contain'
                style={[layout.height45, layout.width45, borders.rounded_500]}
            />
            <TextByVariant style={[components.interDescription12, gutters.marginTop_16]}>{item.name}</TextByVariant>
        </View>
    );

    return (
        <FlatList
            contentContainerStyle={[layout.row, layout.justifyBetween, layout.fullWidth]}
            data={categories}
            horizontal
            keyExtractor={(item) => item.id}
            renderItem={renderCategory}
            scrollEnabled={false}
            showsHorizontalScrollIndicator={false}
            style={[layout.flexGrow0]}
        />
    );
};

export default React.memo(Categories);
