import type { FC } from 'react';
import React from 'react'
import { StyleSheet, Text, View } from 'react-native'


/**
* @author Nitesh Raj Khanal
* @function @CreateAccount
**/


const CreateAccount: FC = () => {

    const { container } = styles
    return (
        <View style={container}>
            <Text>CreateAccount</Text>
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

export default React.memo(CreateAccount)