import { AssetByVariant, ButtonVariant } from '@/components/atoms'
import { useTheme } from '@/theme';
import type { FC } from 'react';
import React, { useState } from 'react'

/**
* @author Nitesh Raj Khanal
* @function @CheckBox
**/

type CheckboxProps = {
    initialChecked?: boolean;
    onToggle: (isChecked: boolean) => void;  
  };
  

 const CheckBox :FC<CheckboxProps> = ({ initialChecked = false, onToggle }) => { 

    const {layout} = useTheme();

    const [isChecked, setIsChecked] = useState<boolean>(initialChecked);

    const handlePress = () => {
      const newCheckedState = !isChecked;
      setIsChecked(newCheckedState);
      onToggle(newCheckedState);  
    };

 return(
  <ButtonVariant onPress={handlePress} style={[layout.height24, layout.width24]}>
    <AssetByVariant
        extension='png'
        path={isChecked ? 'check' : 'uncheck'}
        style={[layout.fullHeight, layout.fullWidth]}
    />
  </ButtonVariant>
  )
}

export default React.memo(CheckBox);
