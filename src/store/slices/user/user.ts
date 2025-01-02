import type { PayloadAction } from '@reduxjs/toolkit';
import type { UserResponseSpace } from '@/hooks';

import { createSlice } from '@reduxjs/toolkit';

interface UserState {
  tokenInfo: null | UserResponseSpace.UserResponse['response']['tokenInfo'];
  user: null | UserResponseSpace.UserResponse['response']['user'];
}

const initialState: UserState = {
  tokenInfo: null,
  user: null,
};

const userSlice = createSlice({
  initialState,
  name: 'user',
  reducers: {
    clearUser(state) {
      state.user = null;
      state.tokenInfo = null;
    },
    setTokenInfo(
      state,
      action: PayloadAction<
        UserResponseSpace.UserResponse['response']['tokenInfo']
      >,
    ) {
      state.tokenInfo = action.payload;
    },
    setUser(
      state,
      action: PayloadAction<UserResponseSpace.UserResponse['response']['user']>,
    ) {
      state.user = action.payload;
    },
  },
});

export const userActions = userSlice.actions;
export default userSlice.reducer;
export const UserReducer = userSlice.reducer;
