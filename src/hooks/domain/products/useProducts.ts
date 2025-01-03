import type { ProductResponseSpace } from './schema';

import { ENDPOINTS } from '@/config';
import { api } from '@/services';
import { myOwnProductActions, productActions } from '@/store/slices';

export const useProductsApi = api.injectEndpoints({
  endpoints: (builder) => ({
    getMyProducts: builder.query<ProductResponseSpace.ProductResponse, void>({
      query: () => ({
        method: 'GET',
        url: ENDPOINTS.MY_OWNED_PRODUCTS,
      }),
      // eslint-disable-next-line perfectionist/sort-objects
      onQueryStarted: async (_, { dispatch, queryFulfilled }) => {
        try {
          const { data } = await queryFulfilled;
          dispatch(
            myOwnProductActions.setMyProducts({
              products: data.response,
              responseHeader: data.responseHeader,
            }),
          );
        } catch (error) {
          console.error('Error fetching my products:', error);
        }
      },
    }),
    getProductList: builder.query<
      ProductResponseSpace.ProductResponse,
      { limit: number; page: number }
    >({
      query: ({ limit, page }) => ({
        method: 'GET',
        url: `${ENDPOINTS.PRODUCTS}?page=${page}&limit=${limit}`,
      }),
      // eslint-disable-next-line perfectionist/sort-objects
      onQueryStarted: async (args, { dispatch, queryFulfilled }) => {
        try {
          const { data } = await queryFulfilled;
          if (args.page === 1) {
            dispatch(
              productActions.setProducts({
                products: data.response,
                responseHeader: data.responseHeader,
              }),
            );
          } else {
            dispatch(
              productActions.appendProducts({
                newProducts: data.response,
              }),
            );
          }
        } catch (error) {
          console.error('Error fetching product list:', error);
        }
      },
    }),
  }),
});

export const { useGetMyProductsQuery, useGetProductListQuery } = useProductsApi;
