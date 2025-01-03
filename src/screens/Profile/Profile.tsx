import { SafeScreen } from '@/components/templates';
import { useTheme } from '@/theme';
import type { FC } from 'react';
import React from 'react'
import { View } from 'react-native'


/**
* @author Nitesh Raj Khanal
* @function @Profile
**/

const Profile: FC = () => {
    const { backgrounds, components, gutters, layout } = useTheme()
    return (
        <SafeScreen style={[backgrounds.background, gutters.paddingHorizontal_16]}
        ></SafeScreen>
    )
}

export default React.memo(Profile)