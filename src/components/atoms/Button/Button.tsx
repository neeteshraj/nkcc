import React, { forwardRef } from 'react';
import type { TouchableOpacityProps, View } from 'react-native';
import { TouchableOpacity } from 'react-native';

interface IProps extends TouchableOpacityProps {
    children: React.ReactNode;
}

/**
 * @author Nitesh Raj Khanal
 * @function @ButtonVariant
 **/

const ButtonVariant = forwardRef<View, IProps>(({ children, ...props }, ref) => {
    return (
        <TouchableOpacity ref={ref} {...props} activeOpacity={0.6}>
            {children}
        </TouchableOpacity>
    );
});

export default React.memo(ButtonVariant);
