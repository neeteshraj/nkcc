import type { RequestSpace, UserResponseSpace } from '@/hooks';

import { ENDPOINTS } from '@/config';
import { api } from '@/services';
import { userActions } from '@/store/slices';

export const userApi = api.injectEndpoints({
  endpoints: (builder) => ({
    login: builder.mutation<
      UserResponseSpace.UserResponse,
      RequestSpace.RequestBody
    >({
      query: (data: RequestSpace.RequestBody) => {
        return {
          body: data,
          method: 'POST',
          url: ENDPOINTS.LOGIN,
        };
      },
      // eslint-disable-next-line perfectionist/sort-objects
      async onQueryStarted(_, { dispatch, queryFulfilled }) {
        try {
          const { data: userData } = await queryFulfilled;

          const { tokenInfo, user } = userData.response;

          dispatch(userActions.setTokenInfo(tokenInfo));
          dispatch(userActions.setUser(user));
        } catch (error) {
          console.error('Login error:', error);
        }
      },
    }),
  }),
  overrideExisting: false,
});

export const { useLoginMutation } = userApi;
