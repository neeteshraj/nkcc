import { AssetByVariant, ButtonVariant } from '@/components/atoms';
import { useTheme } from '@/theme';
import React, { forwardRef } from 'react';
import { TextInput, View } from 'react-native';
import type { TextInputProps } from 'react-native';

/**
 * @author Nitesh Raj Khanal
 * @function @SearchBar
 **/

const SearchBar = forwardRef<TextInput, TextInputProps>(({ ...props }, ref) => {
    const { borders, components,gutters, layout } = useTheme()
    return (
        <View style={[layout.row, layout.itemsCenter, layout.justifyBetween, borders.white70, borders.w_1, borders.rounded_8, gutters.padding_14]}>
            <AssetByVariant
                extension='png'
                path='search'
                style={[layout.height18, layout.width18]}
            />
            <TextInput
                {...props}
                ref={ref}
                style={[layout.flex_1, gutters.marginHorizontal_12, components.interDescriptionUnAligned]}
            />
            <ButtonVariant>
                <AssetByVariant
                    extension='png'
                    path='filter'
                    style={[layout.height18, layout.width18]}
                />
            </ButtonVariant>
        </View>
    );
})

export default React.memo(SearchBar);
