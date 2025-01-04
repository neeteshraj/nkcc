import React from "react"
import Root from './src/Root'
import { enableFreeze } from "react-native-screens"

/**
* @author Nitesh Raj Khanal
* @function @App
**/

enableFreeze(true)
const App = () => {
    return (
        <Root />
    )
}

export default React.memo(App)