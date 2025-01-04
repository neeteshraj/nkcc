import Feather from 'react-native-vector-icons/Feather';
import React, { forwardRef, useState } from 'react';
import { TextInput, View } from 'react-native';
import type { TextInputProps } from 'react-native-paper';
import { useTheme } from '@/theme';
import { ButtonVariant } from '@/components/atoms';

/**
 * @function InputWithIconVariant
 */

interface InputWithIconProps extends TextInputProps {
    direction: 'left' | 'right';
}

const InputWithIconVariant = forwardRef<TextInput, InputWithIconProps>(
    ({ direction = 'left', secureTextEntry: secureTextProp, ...props }, ref) => {
        const { backgrounds, borders, colors, components, gutters, layout } = useTheme();

        const [secureTextEntry, setSecureTextEntry] = useState<boolean>(!!secureTextProp);

        const toggleSecureEntry = () => {
            setSecureTextEntry(!secureTextEntry);
        };

        return (
            <View style={[
                layout.row,
                layout.fullWidth,
                backgrounds.background,
                borders.wBottom_1,
                borders.white50,
                gutters.paddingVertical_16,
                components.interDescription18UnAligned,
            ]}>
                <TextInput secureTextEntry={secureTextEntry} {...props} ref={ref} />
                {direction === 'right' && (
                    <ButtonVariant onPress={toggleSecureEntry}>
                        <Feather color={colors.white} name={secureTextEntry ? 'eye' : 'eye-off'} size={24} />
                    </ButtonVariant>
                )}
            </View>
        );
    }
);

export default React.memo(InputWithIconVariant);
