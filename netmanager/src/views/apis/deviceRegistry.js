import axios from "axios";
import {
  ALL_DEVICES_URI,
  ADD_COMPONENT_URI,
  GET_COMPONENTS_URI,
  DEPLOY_DEVICE_URI,
  EDIT_DEVICE_URI,
  DELETE_DEVICE_URI,
  UPDATE_ACTIVITY_LOG,
  DELETE_ACTIVITY_LOG,
  UPDATE_COMPONENT,
  DELETE_COMPONENT,
  DELETE_DEVICE_PHOTO,
  EVENTS,
  RECALL_DEVICE_URI,
} from "config/urls/deviceRegistry";
import { DEVICE_MAINTENANCE_LOG_URI } from "config/urls/deviceMonitoring";
import { DEVICE_RECENT_FEEDS } from "config/urls/dataManagement";

export const getAllDevicesApi = async () => {
  return await axios.get(ALL_DEVICES_URI).then((response) => response.data);
};

export const createDeviceComponentApi = async (
  deviceName,
  componentType,
  data
) => {
  const ctype = componentType;
  return await axios
    .post(ADD_COMPONENT_URI + deviceName, data, { params: { ctype } })
    .then((response) => response.data);
};

export const getDeviceComponentsApi = async (deviceName) => {
  return await axios
    .get(GET_COMPONENTS_URI + deviceName)
    .then((response) => response.data);
};

export const getFilteredDevicesApi = async (params) => {
  return await axios
    .get(ALL_DEVICES_URI, { params })
    .then((response) => response.data);
};

export const getDeviceMaintenanceLogsApi = async (deviceName) => {
  return await axios
    .get(DEVICE_MAINTENANCE_LOG_URI + deviceName)
    .then((response) => response.data);
};

export const addMaintenanceLogApi = async (logData) => {
  return await axios
    .post(DEPLOY_DEVICE_URI + "maintain", logData)
    .then((response) => response.data);
};

export const recallDeviceApi = async (deviceName) => {
  return await axios
    .post(RECALL_DEVICE_URI, {}, { params: { deviceName } })
    .then((response) => response.data);
};

export const deployDeviceApi = async (deployData) => {
  return axios
    .post(DEPLOY_DEVICE_URI + "deploy", deployData)
    .then((response) => response.data);
};

export const getDeviceRecentFeedByChannelIdApi = async (channelId) => {
  return await axios
    .get(DEVICE_RECENT_FEEDS, { params: { channel: channelId } })
    .then((response) => response.data);
};

export const updateDeviceDetails = async (deviceName, updateData) => {
  return await axios
    .put(EDIT_DEVICE_URI + deviceName, updateData)
    .then((response) => response.data);
};

export const deleteDeviceApi = async (deviceName) => {
  return axios
    .delete(DELETE_DEVICE_URI, { params: { device: deviceName } })
    .then((response) => response.data);
};

export const updateMaintenanceLogApi = async (deviceId, logData) => {
  return axios
    .put(UPDATE_ACTIVITY_LOG, logData, { params: { id: deviceId } })
    .then((response) => response.data);
};

export const deleteMaintenanceLogApi = (deviceId) => {
  return axios
    .delete(DELETE_ACTIVITY_LOG, { params: { id: deviceId } })
    .then((response) => response.data);
};

export const updateComponentApi = async (deviceName, componentName, data) => {
  return await axios
    .put(UPDATE_COMPONENT, data, {
      params: { device: deviceName, comp: componentName },
    })
    .then((response) => response.data);
};

export const deleteComponentApi = async (deviceName, componentName) => {
  return await axios
    .delete(DELETE_COMPONENT, {
      params: { device: deviceName, comp: componentName },
    })
    .then((response) => response.data);
};

export const deleteDevicePhotos = async (deviceName, pictures) => {
  return await axios
    .delete(DELETE_DEVICE_PHOTO, {
      params: { device: deviceName },
      data: { photos: pictures },
    })
    .then((response) => response.data);
};

export const getEventsApi = async (params) => {
  return await axios.get(EVENTS, { params }).then((response) => response.data);
};
