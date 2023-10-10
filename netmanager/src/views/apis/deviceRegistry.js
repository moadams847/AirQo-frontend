import axios from 'axios';
import {
  ACTIVITY_URI,
  ALL_DEVICES_URI,
  ADD_MAINTENANCE_LOGS_URI,
  DEPLOY_DEVICE_URI,
  EDIT_DEVICE_URI,
  DELETE_DEVICE_URI,
  DELETE_DEVICE_PHOTO,
  EVENTS,
  RECALL_DEVICE_URI,
  SITES,
  AIRQLOUDS,
  DECRYPT,
  QRCODE,
  REFRESH_AIRQLOUD,
  SOFT_EDIT_DEVICE_URI,
  DASHBOARD_AIRQLOUDS,
  ALL_DEVICE_HOSTS,
  CREATE_DEVICE_HOST,
  UPDATE_DEVICE_HOST,
  SEND_DEVICE_HOST_MONEY,
  GET_TRANSACTION_HISTORY
} from 'config/urls/deviceRegistry';
import { DEVICE_MAINTENANCE_LOG_URI } from 'config/urls/deviceMonitoring';
import { DEVICE_RECENT_FEEDS } from 'config/urls/dataManagement';
import {
  COHORTS,
  GRIDS,
  GRIDS_COHORTS_COMBINED,
  GET_AIRQLOUDS_SUMMARY,
  GET_DEVICE_IMAGES,
  SOFT_EDIT_DEVICE_IMAGE
} from '../../config/urls/deviceRegistry';
import { BASE_AUTH_TOKEN } from '../../utils/envVariables';
import { isEmpty } from 'validate.js';

const jwtToken = localStorage.getItem('jwtToken');
axios.defaults.headers.common.Authorization = jwtToken;

export const getAllDevicesApi = async (networkID) => {
  return await axios
    .get(ALL_DEVICES_URI, { params: { network: networkID } })
    .then((response) => response.data);
};

export const softCreateDeviceApi = async (data, ctype) => {
  return await axios
    .post(SOFT_EDIT_DEVICE_URI, data, { params: { ctype } })
    .then((response) => response.data);
};

export const getFilteredDevicesApi = async (params) => {
  return await axios
    .get(ALL_DEVICES_URI, { params: { ...params } })
    .then((response) => response.data);
};

export const getDeviceMaintenanceLogsApi = async (deviceName) => {
  return await axios.get(DEVICE_MAINTENANCE_LOG_URI + deviceName).then((response) => response.data);
};

export const getActivitiesApi = async (params) => {
  return await axios.get(ACTIVITY_URI, { params: { ...params } }).then((response) => response.data);
};

export const getActivitiesSummaryApi = async (params) => {
  return await axios.get(ACTIVITY_URI, { params: { ...params } }).then((response) => response.data);
};

export const addMaintenanceLogApi = async (deviceName, logData) => {
  return await axios
    .post(ADD_MAINTENANCE_LOGS_URI, logData, { params: { deviceName } })
    .then((response) => response.data);
};

export const recallDeviceApi = async (deviceName, requestData) => {
  return await axios
    .post(RECALL_DEVICE_URI, requestData, { params: { deviceName } })
    .then((response) => response.data);
};

export const deployDeviceApi = async (deviceName, deployData) => {
  return axios
    .post(DEPLOY_DEVICE_URI, deployData, { params: { deviceName } })
    .then((response) => response.data);
};

export const getDeviceRecentFeedByChannelIdApi = async (channelId) => {
  return await axios
    .get(DEVICE_RECENT_FEEDS, { params: { channel: channelId } })
    .then((response) => response.data);
};

export const updateDeviceDetails = async (id, updateData) => {
  return await axios
    .put(EDIT_DEVICE_URI, updateData, { params: { id } })
    .then((response) => response.data);
};

export const softUpdateDeviceDetails = async (deviceId, updateData) => {
  return await axios
    .put(SOFT_EDIT_DEVICE_URI, updateData, { params: { id: deviceId } })
    .then((response) => response.data);
};

export const deleteDeviceApi = async (deviceName) => {
  return axios
    .delete(DELETE_DEVICE_URI, { params: { device: deviceName } })
    .then((response) => response.data);
};

export const updateMaintenanceLogApi = async (deviceId, logData) => {
  return axios
    .put(ACTIVITY_URI, logData, { params: { id: deviceId } })
    .then((response) => response.data);
};

export const deleteMaintenanceLogApi = (deviceId) => {
  return axios.delete(ACTIVITY_URI, { params: { id: deviceId } }).then((response) => response.data);
};

export const deleteDevicePhotos = async (deviceId, urls) => {
  return await axios
    .delete(DELETE_DEVICE_PHOTO, {
      params: { id: deviceId },
      data: { photos: urls }
    })
    .then((response) => response.data);
};

export const getEventsApi = async (params) => {
  return await axios
    .get(EVENTS, { params: { ...params, token: BASE_AUTH_TOKEN } })
    .then((response) => response.data);
};

export const getSitesApi = async (params) => {
  return await axios.get(SITES, { params: { ...params } }).then((response) => response.data);
};

export const getSitesSummaryApi = async (params) => {
  return await axios
    .get(`${SITES}/summary`, { params: { ...params } })
    .then((response) => response.data);
};

export const getSiteDetailsApi = async (site_id) => {
  return await axios.get(SITES, { params: { id: site_id } }).then((response) => response.data);
};

export const updateSiteApi = async (site_id, siteData) => {
  return await axios
    .put(SITES, siteData, { params: { id: site_id } })
    .then((response) => response.data);
};

export const createSiteApi = async (siteData) => {
  return await axios.post(SITES, siteData).then((response) => response.data);
};

export const createSiteMetaDataApi = async (siteData) => {
  return await axios.post(`${SITES}/metadata`, siteData).then((response) => response.data);
};

export const deleteSiteApi = async (siteId) => {
  return await axios.delete(SITES, { params: { id: siteId } }).then((response) => response.data);
};

export const getAirQloudsApi = async (params) => {
  return await axios.get(AIRQLOUDS, { params: { ...params } }).then((response) => response.data);
};

export const getDashboardAirQloudsApi = async (params) => {
  return await axios
    .get(DASHBOARD_AIRQLOUDS, { params: { ...params } })
    .then((response) => response.data);
};

export const getAirqloudsSummaryApi = async (params) => {
  return await axios
    .get(GET_AIRQLOUDS_SUMMARY, { params: { ...params } })
    .then((response) => response.data);
};

export const decryptKeyApi = async (encrypted_key) => {
  return await axios.post(DECRYPT, { encrypted_key }).then((response) => response.data);
};

export const QRCodeApi = async (params) => {
  return await axios.get(QRCODE, { params: { ...params } }).then((response) => response.data);
};

export const refreshAirQloudApi = async (params) => {
  return await axios
    .put(REFRESH_AIRQLOUD, {}, { params: { ...params } })
    .then((response) => response.data);
};

export const createCohortApi = async (cohortData) => {
  return await axios.post(COHORTS, cohortData).then((response) => response.data);
};

export const getGridsAndCohortsSummaryApi = async (networkID) => {
  return await axios
    .get(`${GRIDS_COHORTS_COMBINED}/${networkID}/summary`)
    .then((response) => response.data);
};

export const getGridDetailsApi = async (gridID) => {
  return await axios.get(`${GRIDS}/${gridID}`).then((response) => response.data);
};

export const getGridsApi = async (params) => {
  return await axios.get(GRIDS, { params: { ...params } }).then((response) => response.data);
};

export const getCohortDetailsApi = async (cohortID) => {
  return await axios.get(`${COHORTS}/${cohortID}`).then((response) => response.data);
};

export const getCohortsApi = async (params) => {
  return await axios.get(COHORTS, { params: { ...params } }).then((response) => response.data);
};

export const deleteCohortApi = async (cohortID) => {
  return await axios.delete(`${COHORTS}/${cohortID}`).then((response) => response.data);
};

export const unassignDeviceFromCohortApi = async (cohortID, deviceID) => {
  return await axios
    .delete(`${COHORTS}/${cohortID}/unassign-device/${deviceID}`)
    .then((response) => response.data);
};

export const deleteGridApi = async (gridID) => {
  return await axios.delete(`${GRIDS}/${gridID}`).then((response) => response.data);
};

export const updateCohortApi = async (cohortID, cohortData) => {
  return await axios.put(`${COHORTS}/${cohortID}`, cohortData).then((response) => response.data);
};

export const updateGridApi = async (gridID, gridData) => {
  return await axios.put(`${GRIDS}/${gridID}`, gridData).then((response) => response.data);
};

export const assignDevicesToCohort = async (cohortID, deviceIDs) => {
  return await axios
    .post(`${COHORTS}/${cohortID}/assign-devices`, { device_ids: deviceIDs })
    .then((response) => response.data);
};

export const createGridApi = async (gridData) => {
  return await axios.post(GRIDS, gridData).then((response) => response.data);
};

export const refreshGridApi = async (gridID) => {
  return await axios.put(`${GRIDS}/refresh/${gridID}`).then((response) => response.data);
};

export const softCreateDevicePhoto = async (data) => {
  return await axios.post(SOFT_EDIT_DEVICE_IMAGE, data).then((response) => response.data);
};

export const getDevicePhotos = async (params) => {
  return await axios
    .get(GET_DEVICE_IMAGES, { params: { device_id: params } })
    .then((response) => response.data);
};

export const getAllDeviceHosts = async () => {
  return await axios.get(ALL_DEVICE_HOSTS).then((response) => response.data);
};

export const createDeviceHost = async (params) => {
  return await axios
    .post(CREATE_DEVICE_HOST, params)
    .then((response) => response.data)
    .catch((error) => error.response.data);
};

export const updateDeviceHost = async (id, params) => {
  return await axios
    .put(`${UPDATE_DEVICE_HOST}/${id}`, params)
    .then((response) => response.data)
    .catch((error) => error.response.data);
};

export const sendMoneyToHost = async (id, amount) => {
  return await axios
    .post(`${SEND_DEVICE_HOST_MONEY}/${id}/payments`, { amount })
    .then((response) => response.data)
    .catch((error) => error.response.data);
};

export const getTransactionDetails = async (id) => {
  return await axios
    .get(`${GET_TRANSACTION_HISTORY}/${id}`)
    .then((response) => response.data)
    .catch((error) => error.response.data);
};
