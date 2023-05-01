import {
  ASSIGN_USER_TO_NETWORK_SUCCESS,
  LOAD_ALL_USER_ROLES_SUCCESS,
  LOAD_CURRENT_NETWORK_SUCCESS,
  LOAD_CURRENT_USER_NETWORKS_SUCCESS,
  LOAD_CURRENT_USER_ROLE_SUCCESS
} from './actions';

const initialState = {
  userRoles: null,
  currentRole: {},
  userNetworks: null,
  activeNetwork: {}
};

export default function accessControlReducer(state = initialState, action) {
  switch (action.type) {
    case LOAD_ALL_USER_ROLES_SUCCESS:
      return { ...state, userRoles: action.payload };
    case LOAD_CURRENT_USER_ROLE_SUCCESS:
      return { ...state, currentRole: action.payload };
    case LOAD_CURRENT_USER_NETWORKS_SUCCESS:
      return { ...state, userNetworks: action.payload };
    case LOAD_CURRENT_NETWORK_SUCCESS:
      return { ...state, activeNetwork: action.payload };
    default:
      return state;
  }
}
