import type { FC } from 'react';
import React from 'react'
import { StyleSheet, Text, View } from 'react-native'


/**
* @author Nitesh Raj Khanal
* @function @PrivacyPolicy
**/


const PrivacyPolicy: FC = () => {

    const { container } = styles
    return (
        <View style={container}>
            <Text>PrivacyPolicy</Text>
        </View>
    )
}


const styles = StyleSheet.create({
    container: {
        alignItems: 'center',
        flex: 1,
        justifyContent: 'center',
    }
})

export default React.memo(PrivacyPolicy)