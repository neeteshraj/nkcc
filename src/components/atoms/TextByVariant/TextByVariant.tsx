import type { FC } from 'react';
import React from 'react';
import type { TextProps } from 'react-native';
import { Text } from 'react-native';

interface IProps extends TextProps {
    children: React.ReactNode;
}

/**
 * @author Nitesh Raj Khanal
 * @function @TextByVariant
 **/

const TextByVariant: FC<IProps> = ({ children, ...props }) => {
    return (
        <Text adjustsFontSizeToFit={true} {...props}>
            {children}
        </Text>
    );
};

export default TextByVariant;
