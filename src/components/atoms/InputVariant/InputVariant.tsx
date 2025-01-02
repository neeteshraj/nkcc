import React, { forwardRef } from 'react'
import { TextInput } from 'react-native'
import type { TextInputProps } from 'react-native-paper';


/**
* @author Nitesh Raj Khanal
* @function @InputVariant
**/


const InputVariant = forwardRef<TextInput, TextInputProps>(({ ...props }, ref) => {
    return (
        <TextInput {...props} ref={ref} />
    )
})


export default React.memo(InputVariant);