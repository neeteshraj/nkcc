import type {
  RequestSpace,
  UserCreateSpace,
  UserDetailsResponseSpace,
  UserResponseSpace,
} from './schema';

import { ENDPOINTS } from '@/config';
import { api } from '@/services';
import { userActions } from '@/store/slices';

export const userApi = api.injectEndpoints({
  endpoints: (builder) => ({
    getUserDetails: builder.query<
      UserDetailsResponseSpace.UserDetailsResponse,
      void
    >({
      query: () => {
        return {
          method: 'GET',
          url: ENDPOINTS.DETAILS,
        };
      },
      // eslint-disable-next-line perfectionist/sort-objects
      async onQueryStarted(_, { dispatch, queryFulfilled }) {
        try {
          const { data: userData } = await queryFulfilled;

          const { user } = userData.response;

          dispatch(userActions.setUser(user));
        } catch (error) {
          console.error('Login error:', error);
        }
      },
    }),
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
    register: builder.mutation<
      UserResponseSpace.UserResponse,
      UserCreateSpace.UserCreate
    >({
      query: (data: UserCreateSpace.UserCreate) => {
        return {
          body: data,
          method: 'POST',
          url: ENDPOINTS.REGISTER,
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

export const { useGetUserDetailsQuery, useLoginMutation, useRegisterMutation } =
  userApi;
