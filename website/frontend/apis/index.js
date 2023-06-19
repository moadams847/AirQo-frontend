import axios from 'axios';
import {
  AIRQLOUD_SUMMARY,
  NEWSLETTER_SUBSCRIPTION,
  INQUIRY_URL,
  EXPLORE_DATA_URL,
  CAREERS_URL,
  DEPARTMENTS_URL,
  TEAMS_URL,
  HIGHLIGHTS_URL,
  TAGS_URL,
  PARTNERS_URL,
  BOARD_MEMBERS_URL,
  PUBLICATIONS_URL,
  EVENTS_URL,
  CITIES_URL
} from '../config/urls';

axios.defaults.headers.common.Authorization = `JWT ${process.env.REACT_APP_AUTHORIZATION_TOKEN}`;

export const getAirQloudSummaryApi = async () =>
  await axios.get(AIRQLOUD_SUMMARY).then((response) => response.data);

export const newsletterSubscriptionApi = async (data) =>
  await axios.post(NEWSLETTER_SUBSCRIPTION, data).then((response) => response.data);

export const contactUsApi = async (data) =>
  await axios.post(INQUIRY_URL, data).then((response) => response.data);

export const sendInquiryApi = async (data) =>
  await axios.post(INQUIRY_URL, data).then((response) => response.data);

export const requestDataAccessApi = async (data) =>
  await axios.post(EXPLORE_DATA_URL, data).then((response) => response.data);

// Careers endpoints
export const getAllCareersApi = async () =>
  await axios.get(CAREERS_URL).then((response) => response.data);

export const getAllDepartmentsApi = async () =>
  await axios.get(DEPARTMENTS_URL).then((response) => response.data);

// Teams endpoints
export const getAllTeamMembersApi = async () =>
  await axios.get(TEAMS_URL).then((response) => response.data);

// Highlights endpoints
export const getAllHighlightsApi = async () =>
  await axios.get(HIGHLIGHTS_URL).then((response) => response.data);
export const getAllTagsApi = async () =>
  await axios.get(TAGS_URL).then((response) => response.data);

// Partners endpoints
export const getAllPartnersApi = async () =>
  await axios.get(PARTNERS_URL).then((response) => response.data);

// Board Members endpoints
export const getBoardMembersApi = async () =>
  await axios.get(BOARD_MEMBERS_URL).then((response) => response.data);

// Publications endpoints
export const getAllPublicationsApi = async () =>
  await axios.get(PUBLICATIONS_URL).then((response) => response.data);

// Events endpoint
export const getAllEventsApi = async () =>
  await axios.get(EVENTS_URL).then((response) => response.data);

// African Cities endpoint
export const getAllCitiesApi = async () =>
  await axios.get(CITIES_URL).then((response) => response.data);

