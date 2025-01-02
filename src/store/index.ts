import {combineReducers, configureStore} from '@reduxjs/toolkit';
import {setupListeners} from '@reduxjs/toolkit/query';
import type { Storage} from 'redux-persist';
import {FLUSH, PAUSE, PERSIST, persistReducer, persistStore, PURGE, REGISTER, REHYDRATE} from 'redux-persist';
import {MMKV} from 'react-native-mmkv';
import {api} from "@/services";
import { UserReducer } from './slices';

const reducers = combineReducers({
  user: UserReducer,
  // eslint-disable-next-line perfectionist/sort-objects
  [api.reducerPath]: api.reducer,
});

export const storage = new MMKV();
export const reduxStorage: Storage = {
  getItem: key => {
    const value = storage.getString(key);
    return Promise.resolve(value);
  },
  removeItem: key => {
    storage.delete(key);
    return Promise.resolve();
  },
  setItem: (key, value) => {
    storage.set(key, value);
    return Promise.resolve(true);
  },
};

const persistConfig = {
  key: 'root',
  storage: reduxStorage,
  whitelist: ['user'],
};

const persistedReducer = persistReducer(persistConfig, reducers);

const store = configureStore({
  middleware: getDefaultMiddleware => {
    return getDefaultMiddleware({
      immutableCheck: false,
      serializableCheck: {
        ignoredActions: [FLUSH, REHYDRATE, PAUSE, PERSIST, PURGE, REGISTER],
      },
    }).concat(api.middleware);
  },
  reducer: persistedReducer,
});

const persistor = persistStore(store);

setupListeners(store.dispatch);

export { persistor, store };


export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
export type AppState = ReturnType<typeof reducers>;