const prodConfig = {
  /** authentication */
  VERIFY_TOKEN_URI: "http://34.78.78.202:30000/api/v1/users/reset/you",
  UPDATE_PWD_URI:
    "http://34.78.78.202:30000/api/v1/users/updatePasswordViaEmail",
  UPDATE_PWD_IN_URI: "http://34.78.78.202:30000/api/v1/users/updatePassword",
  FORGOT_PWD_URI: "http://34.78.78.202:30000/api/v1/users/forgotPassword",
  LOGIN_USER_URI: "http://34.78.78.202:30000/api/v1/users/loginUser",
  REGISTER_USER_URI: "http://34.78.78.202:30000/api/v1/users/registerUser",
  REGISTER_CANDIDATE_URI:
    "http://34.78.78.202:30000/api/v1/users/register/new/candidate",
  REJECT_USER_URI: "http://34.78.78.202:30000/api/v1/users/deny",
  ACCEPT_USER_URI: "http://34.78.78.202:30000/api/v1/users/accept",
  GET_USERS_URI: "http://34.78.78.202:30000/api/v1/users/",
  GET_CANDIDATES_URI: "http://34.78.78.202:30000/api/v1/users/candidates/fetch",
  DEFAULTS_URI: "http://34.78.78.202:30000/api/v1/users/defaults",
  /**netmanager */
  ALL_LOCATIONS_URI:
    "http://34.78.78.202:30005/api/v1/location_registry/locations",
  CREATE_ID_URI: "http://34.78.78.202:30005/api/v1/location_registry/create_id",
  REGISTER_LOCATION_URI:
    "http://34.78.78.202:30005/api/v1/location_registry/register",
  VIEW_LOCATION_URI:
    "http://34.78.78.202:30005/api/v1/location_registry/location?loc_ref=",
  EDIT_LOCATION_DETAILS_URI:
    "http://34.78.78.202:30005/api/v1/location_registry/edit?loc_ref=",
  UPDATE_LOCATION_URI:
    "http://34.78.78.202:30005/api/v1/location_registry/update",
  RUN_LOCATE_MODEL: "http://34.78.78.202:30004/api/v1/map/parishes",
  SAVE_LOCATE_MAP: "http://34.78.78.202:30004/api/v1/map/savelocatemap",
  GET_LOCATE_MAP: "http://34.78.78.202:30004/api/v1/map/getlocatemap/",
  UPDATE_LOCATE_MAP: "http://34.78.78.202:30004/api/v1/map/updatelocatemap/",
  DELETE_LOCATE_MAP: "http://34.78.78.202:30004/api/v1/map/deletelocatemap/",
  GET_DEVICE_STATUS_SUMMARY:
    "http://34.78.78.202:30006/api/v1/monitor/device/status",
  GET_MAINTENANCE_LOGS:
    "http://34.78.78.202:30006/api/v1/monitor/device/maintenance_logs",
  GET_DEVICE_MAINTENANCE_LOG:
    "http://34.78.78.202:30006/api/v1/monitor/device/maintenance_logs/",
  GET_DEVICE_POWER_TYPE:
    "http://34.78.78.202:30006/api/v1/monitor/device/power_type",
  GET_DEVICE_STATUS_FOR_PIECHART_DISPLAY:
    "http://34.78.78.202:30006/api/v1/monitor/device/status/latest",
  GET_LATEST_OFFLINE_DEVICES:
    "http://34.78.78.202:30006/api/v1/monitor/devices/offline",
  GET_NETWORK_UPTIME: "http://34.78.78.202:30006/api/v1/monitor/network/uptime",
  GET_DEVICE_UPTIME: "http://34.78.78.202:30006/api/v1/monitor/device/uptime",
  GET_DEVICE_BATTERY_VOLTAGE:
    "http://34.78.78.202:30006/api/v1/monitor/device/batteryvoltage",
  GET_DEVICE_SENSOR_CORRELATION:
    "http://34.78.78.202:30006/api/v1/monitor/device/sensors/correlation",
  DEVICE_MAINTENANCE_LOG_URI:
    "http://34.78.78.202:30006/api/v1/monitor/device/maintenance_logs/",
  ADD_MAINTENANCE_URI:
    "http://34.78.78.202:30001/api/v1/data/channels/maintenance/add",
  DEVICE_RECENT_FEEDS:
    "http://34.78.78.202:30001/api/v1/data/feeds/transform/recent",
  REGISTER_DEVICE_URI: "http://34.78.78.202:30002/api/v1/devices/ts",
  ALL_DEVICES_URI: "http://34.78.78.202:30002/api/v1/devices",
  EDIT_DEVICE_URI: "http://34.78.78.202:30002/api/v1/devices/ts/update?device=",
  DEVICES_IN_LOCATION_URI:
    "http://34.78.78.202:30002/api/v1/devices/by/location?loc=",
  DEPLOY_DEVICE_URI:
    "http://34.78.78.202:30002/api/v1/devices/ts/activity?type=",
  DELETE_DEVICE_URI: "http://34.78.78.202:30002/api/v1/devices/ts/delete",
  GET_NETWORK_BEST_PERFORMING_DEVICES:
    "http://34.78.78.202:30006/api/v1/monitor/network/devices/bestperforming",
  GET_NETWORK_WORST_PERFORMING_DEVICES:
    "http://34.78.78.202:30006/api/v1/monitor/network/devices/worstperforming",
  ALL_DEVICES_STATUS: "http://34.78.78.202:30006/api/v1/monitor/devices/status",
  ALL_DEVICES_UPTIME: "http://34.78.78.202:30006/api/v1/monitor/devices/uptime",
  ADD_COMPONENT_URI:
    "http://34.78.78.202:30002/api/v1/devices/add/components?device=",
  GET_ONLINE_OFFLINE_MAINTENANCE_STATUS:
    "http://34.78.78.202:30006/api/v1/monitor/devices/online_offline",
  GET_COMPONENTS_URI:
    "http://34.78.78.202:30002/api/v1/devices/list/components?device=",
  DELETE_COMPONENT_URI:
    "http://34.78.78.202:30002/api/v1/devices/delete/components?comp=",
  UPDATE_COMPONENT_URI:
    "http://34.78.78.202:30002/api/v1/devices/update/components?device=",
  /**analytics */
  GENERATE_CUSTOMISABLE_CHARTS_URI:
    "http://34.78.78.202:30003/api/v1/analytics/dashboard/customisedchart",
  GET_CUSTOMISABLE_CHART_INITIAL_DATA_URI:
    "http://34.78.78.202:30003/api/v1/analytics/dashboard/customisedchart/random",
  GET_MONITORING_SITES_LOCATIONS_URI:
    "http://34.78.78.202:30003/api/v1/analytics/dashboard/monitoringsites/locations?organisation_name=KCCA",
  GET_PM25_CATEGORY_COUNT_URI:
    "http://34.78.78.202:30003/api/v1/analytics/dashboard/locations/pm25categorycount?organisation_name=KCCA",
  GET_HISTORICAL_DAILY_MEAN_AVERAGES_FOR_LAST_28_DAYS_URI:
    "http://34.78.78.202:30003/api/v1/analytics/dashboard/historical/daily/devices",
  GENERATE_DEVICE_GRAPH_URI:
    "http://34.78.78.202:30003/api/v1/analytics/device/graph",
  DOWNLOAD_DATA:
    "http://34.78.78.202:30003/api/v1/analytics/data/download?type=",
  DOWNLOAD_CUSTOMISED_DATA_URI:
    "http://34.78.78.202:30003/api/v1/analytics/data/download",
  GET_DEFAULT_REPORT_TEMPLATE_URI:
    "http://34.78.78.202:30003/api/v1/analytics/report/get_default_report_template",
  SAVE_MONTHLY_REPORT_URI:
    "http://34.78.78.202:30003/api/v1/analytics/report/save_monthly_report",
  GET_MONTHLY_REPORT_URI:
    "http://34.78.78.202:30003/api/v1/analytics/report/get_monthly_report/",
  DELETE_MONTHLY_REPORT_URI:
    "http://34.78.78.202:30003/api/v1/analytics/report/delete_monthly_report/",
  UPDATE_MONTHLY_REPORT_URI:
    "http://34.78.78.202:30003/api/v1/analytics/report/update_monthly_report/",
  EXCEEDANCES_URI:
    "http://34.78.78.202:30003/api/v1/analytics/dashboard/exceedances",
  GET_MONITORING_SITES_URI:
    "http://34.78.78.202:30003/api/v1/analytics/dashboard/monitoringsites?organisation_name=KCCA",
  GET_DATA_MAP:
    "http://34.78.78.202:30003/api/v1/analytics/dashboard/monitoringsites?organisation_name=KCCA&pm25_category=",
  GET_HEATMAP_DATA: "http://34.78.78.202:30009/api/v1/predict/heatmap",
  UPDATE_ACTIVITY_LOG:
    "http://34.78.78.202:30002/api/v1/devices/ts/activity/update",
  DELETE_ACTIVITY_LOG:
    "http://34.78.78.202:30002/api/v1/devices/ts/activity/delete",
  UPDATE_COMPONENT:
    "http://34.78.78.202:30002/api/v1/devices/update/components",
  DELETE_COMPONENT:
    "http://34.78.78.202:30002/api/v1/devices/delete/components",
  DELETE_DEVICE_PHOTO: "http://34.78.78.202:30002/api/v1/devices/photos",
  EVENTS: "http://34.78.78.202:30002/api/v1/devices/events",
};

const devConfig = {
  /**authentication */
  VERIFY_TOKEN_URI: "http://localhost:3000/api/v1/users/reset/you",
  UPDATE_PWD_URI: "http://localhost:3000/api/v1/users/updatePasswordViaEmail",
  UPDATE_PWD_IN_URI: "http://localhost:3000/api/v1/users/updatePassword",
  FORGOT_PWD_URI: "http://localhost:3000/api/v1/users/forgotPassword",
  LOGIN_USER_URI: "http://localhost:3000/api/v1/users/loginUser",
  REGISTER_USER_URI: "http://localhost:3000/api/v1/users/registerUser",
  REGISTER_CANDIDATE_URI:
    "http://localhost:3000/api/v1/users/register/new/candidate",
  REJECT_USER_URI: "http://localhost:3000/api/v1/users/deny",
  ACCEPT_USER_URI: "http://localhost:3000/api/v1/users/accept",
  GET_USERS_URI: "http://localhost:3000/api/v1/users/",
  GET_CANDIDATES_URI: "http://localhost:3000/api/v1/users/candidates/fetch",
  DEFAULTS_URI: "http://localhost:3000/api/v1/users/defaults",
  /** analytics */
  GENERATE_CUSTOMISABLE_CHARTS_URI:
    "http://127.0.0.1:5000/api/v1/analytics/dashboard/customisedchart",
  GET_CUSTOMISABLE_CHART_INITIAL_DATA_URI:
    "http://127.0.0.1:5000/api/v1/analytics/dashboard/customisedchart/random",
  GET_MONITORING_SITES_LOCATIONS_URI:
    "http://127.0.0.1:5000/api/v1/analytics/dashboard/monitoringsites/locations?organisation_name=KCCA",
  GET_PM25_CATEGORY_COUNT_URI:
    "http://127.0.0.1:5000/api/v1/analytics/dashboard/locations/pm25categorycount?organisation_name=KCCA",
  GET_HISTORICAL_DAILY_MEAN_AVERAGES_FOR_LAST_28_DAYS_URI:
    "http://127.0.0.1:5000/api/v1/analytics/dashboard/historical/daily/devices",
  GENERATE_DEVICE_GRAPH_URI:
    "http://127.0.0.1:5000/api/v1/analytics/device/graph",
  DOWNLOAD_DATA: "http://127.0.0.1:5000/api/v1/analytics/data/download?type=",
  GET_DEFAULT_REPORT_TEMPLATE_URI:
    "http://127.0.0.1:5000/api/v1/analytics/report/get_default_report_template",
  SAVE_MONTHLY_REPORT_URI:
    "http://127.0.0.1:5000/api/v1/analytics/report/save_monthly_report",
  GET_MONTHLY_REPORT_URI:
    "http://127.0.0.1:5000/api/v1/analytics/report/get_monthly_report/",
  DELETE_MONTHLY_REPORT_URI:
    "http://127.0.0.1:5000/api/v1/analytics/report/delete_monthly_report/",
  UPDATE_MONTHLY_REPORT_URI:
    "http://127.0.0.1:5000/api/v1/analytics/report/update_monthly_report/",
  EXCEEDANCES_URI:
    "http://127.0.0.1:5000/api/v1/analytics/dashboard/exceedances",
  GET_MONITORING_SITES_URI:
    "http://127.0.0.1:5000/api/v1/analytics/dashboard/monitoringsites?organisation_name=KCCA",
  GET_DATA_MAP:
    "http://127.0.0.1:5000/api/v1/analytics/dashboard/monitoringsites?organisation_name=KCCA&pm25_category=",
  GET_HEATMAP_DATA: "http://localhost:5000/api/v1/predict/heatmap",
  RUN_LOCATE_MODEL: "http://localhost:4000/api/v1/map/parishes",
  SAVE_LOCATE_MAP: "http://localhost:4000/api/v1/map/savelocatemap",
  GET_LOCATE_MAP: "http://localhost:4000/api/v1/map/getlocatemap/",
  UPDATE_LOCATE_MAP: "http://localhost:4000/api/v1/map/updatelocatemap/",
  DELETE_LOCATE_MAP: "http://localhost:4000/api/v1/map/deletelocatemap/",
  GET_DEVICE_STATUS_SUMMARY:
    "http://localhost:4001/api/v1/monitor/device/status",
  GET_MAINTENANCE_LOGS:
    "http://localhost:4001/api/v1/monitor/device/maintenance_logs",
  GET_DEVICE_MAINTENANCE_LOG:
    "http://localhost:4001/api/v1/monitor/device/maintenance_logs/",
  GET_DEVICE_POWER_TYPE:
    "http://localhost:4001/api/v1/monitor/device/power_type",
  GET_DEVICE_STATUS_FOR_PIECHART_DISPLAY:
    "http://localhost:4001/api/v1/monitor/device/status/latest",
  GET_LATEST_OFFLINE_DEVICES:
    "http://localhost:4001/api/v1/monitor/devices/offline",
  GET_NETWORK_UPTIME: "http://localhost:4001/api/v1/monitor/network/uptime",
  GET_DEVICE_UPTIME: "http://localhost:4001/api/v1/monitor/device/uptime",
  ALL_DEVICES_STATUS: "http://localhost:4001/api/v1/monitor/devices/status",
  ALL_DEVICES_UPTIME: "http://localhost:4001/api/v1/monitor/devices/uptime",
  GET_DEVICE_BATTERY_VOLTAGE:
    "http://127.0.0.1:4001/api/v1/monitor/device/batteryvoltage",
  GET_DEVICE_SENSOR_CORRELATION:
    "http://127.0.0.1:4001/api/v1/monitor/device/sensors/correlation",
  GET_NETWORK_BEST_PERFORMING_DEVICES:
    "http://localhost:4001/api/v1/monitor/network/devices/bestperforming",
  GET_NETWORK_WORST_PERFORMING_DEVICES:
    "http://localhost:4001/api/v1/monitor/network/devices/worstperforming",
  /** netmanager */
  ALL_LOCATIONS_URI: "http://127.0.0.1:4000/api/v1/location_registry/locations",
  CREATE_ID_URI: "http://127.0.0.1:4000/api/v1/location_registry/create_id",
  REGISTER_LOCATION_URI:
    "http://127.0.0.1:4000/api/v1/location_registry/register",
  VIEW_LOCATION_URI:
    "http://127.0.0.1:4000/api/v1/location_registry/location?loc_ref=",
  EDIT_LOCATION_DETAILS_URI:
    "http://127.0.0.1:4000/api/v1/location_registry/edit?loc_ref=",
  UPDATE_LOCATION_URI: "http://127.0.0.1:4000/api/v1/location_registry/update",
  ADD_MAINTENANCE_URI:
    "http://localhost:3000/api/v1/data/channels/maintenance/add",
  DEVICE_RECENT_FEEDS:
    "http://localhost:3000/api/v1/data/feeds/transform/recent",
  REGISTER_DEVICE_URI: "http://localhost:3000/api/v1/devices/ts",
  ALL_DEVICES_URI: "http://localhost:3000/api/v1/devices",
  EDIT_DEVICE_URI: "http://localhost:3000/api/v1/devices/ts/update?device=",
  ALL_SENSORS_URI: "http://127.0.0.1:3000/api/v1/devices/get/sensors",
  DEVICES_IN_LOCATION_URI:
    "http://localhost:3000/api/v1/devices/by/location?loc=",
  DEPLOY_DEVICE_URI: "http://localhost:3000/api/v1/devices/ts/activity?type=",
  DEVICE_MAINTENANCE_LOG_URI:
    "http://localhost:4001/api/v1/monitor/device/maintenance_logs/",
  DELETE_DEVICE_URI: "http://127.0.0.1:3000/api/api/v1/devices/ts/delete",
  GET_ONLINE_OFFLINE_MAINTENANCE_STATUS:
    "http://127.0.0.1:4001/api/v1/monitor/devices/online_offline",
  ADD_COMPONENT_URI:
    "http://localhost:3000/api/v1/devices/add/components?device=",
  GET_COMPONENTS_URI:
    "http://localhost:3000/api/v1/devices/list/components?device=",
  DELETE_COMPONENT_URI:
    "http://localhost:3000/api/v1/devices/delete/components?comp=",
  UPDATE_COMPONENT_URI:
    "http://localhost:3000/api/v1/devices/update/components?device=",
  UPDATE_ACTIVITY_LOG:
    "http://localhost:3000/api/v1/devices/ts/activity/update",
  DELETE_ACTIVITY_LOG:
    "http://localhost:3000/api/v1/devices/ts/activity/delete",
  UPDATE_COMPONENT: "http://localhost:3000/api/v1/devices/update/components",
  DELETE_COMPONENT: "http://localhost:3000/api/v1/devices/delete/components",
  DELETE_DEVICE_PHOTO: "http://localhost:3000/api/v1/devices/photos",
  EVENTS: "http://localhost:3000/api/v1/devices/events",
};

const stageConfig = {
  /** authentication */
  VERIFY_TOKEN_URI: "http://34.78.78.202:31000/api/v1/users/reset/you",
  UPDATE_PWD_URI:
    "http://34.78.78.202:31000/api/v1/users/updatePasswordViaEmail",
  UPDATE_PWD_IN_URI: "http://34.78.78.202:31000/api/v1/users/updatePassword",
  FORGOT_PWD_URI: "http://34.78.78.202:31000/api/v1/users/forgotPassword",
  LOGIN_USER_URI: "http://34.78.78.202:31000/api/v1/users/loginUser",
  REGISTER_USER_URI: "http://34.78.78.202:31000/api/v1/users/registerUser",
  REGISTER_CANDIDATE_URI:
    "http://34.78.78.202:31000/api/v1/users/register/new/candidate",
  REJECT_USER_URI: "http://34.78.78.202:31000/api/v1/users/deny",
  ACCEPT_USER_URI: "http://34.78.78.202:31000/api/v1/users/accept",
  GET_USERS_URI: "http://34.78.78.202:31000/api/v1/users/",
  GET_CANDIDATES_URI: "http://34.78.78.202:31000/api/v1/users/candidates/fetch",
  DEFAULTS_URI: "http://34.78.78.202:31000/api/v1/users/defaults",
  /**netmanager */
  ALL_LOCATIONS_URI:
    "http://34.78.78.202:31005/api/v1/location_registry/locations",
  CREATE_ID_URI: "http://34.78.78.202:31005/api/v1/location_registry/create_id",
  REGISTER_LOCATION_URI:
    "http://34.78.78.202:31005/api/v1/location_registry/register",
  VIEW_LOCATION_URI:
    "http://34.78.78.202:31005/api/v1/location_registry/location?loc_ref=",
  EDIT_LOCATION_DETAILS_URI:
    "http://34.78.78.202:31005/api/v1/location_registry/edit?loc_ref=",
  UPDATE_LOCATION_URI:
    "http://34.78.78.202:31005/api/v1/location_registry/update",
  RUN_LOCATE_MODEL: "http://34.78.78.202:31004/api/v1/map/parishes",
  SAVE_LOCATE_MAP: "http://34.78.78.202:31004/api/v1/map/savelocatemap",
  GET_LOCATE_MAP: "http://34.78.78.202:31004/api/v1/map/getlocatemap/",
  UPDATE_LOCATE_MAP: "http://34.78.78.202:31004/api/v1/map/updatelocatemap/",
  DELETE_LOCATE_MAP: "http://34.78.78.202:31004/api/v1/map/deletelocatemap/",
  GET_DEVICE_STATUS_SUMMARY:
    "http://34.78.78.202:31006/api/v1/monitor/device/status",
  GET_MAINTENANCE_LOGS:
    "http://34.78.78.202:31006/api/v1/monitor/device/maintenance_logs",
  GET_DEVICE_MAINTENANCE_LOG:
    "http://34.78.78.202:31006/api/v1/monitor/device/maintenance_logs/",
  ALL_DEVICES_UPTIME: "http://34.78.78.202:31006/api/v1/monitor/devices/uptime",
  GET_DEVICE_POWER_TYPE:
    "http://34.78.78.202:31006/api/v1/monitor/device/power_type",
  ALL_DEVICES_STATUS: "http://34.78.78.202:31006/api/v1/monitor/devices/status",
  GET_DEVICE_STATUS_FOR_PIECHART_DISPLAY:
    "http://34.78.78.202:31006/api/v1/monitor/device/status/latest",
  GET_LATEST_OFFLINE_DEVICES:
    "http://34.78.78.202:31006/api/v1/monitor/devices/offline",
  GET_NETWORK_UPTIME: "http://34.78.78.202:31006/api/v1/monitor/network/uptime",
  GET_DEVICE_UPTIME: "http://34.78.78.202:31006/api/v1/monitor/device/uptime",
  GET_DEVICE_BATTERY_VOLTAGE:
    "http://34.78.78.202:31006/api/v1/monitor/device/batteryvoltage",
  GET_DEVICE_SENSOR_CORRELATION:
    "http://34.78.78.202:31006/api/v1/monitor/device/sensors/correlation",
  DEVICE_MAINTENANCE_LOG_URI:
    "http://34.78.78.202:31006/api/v1/monitor/device/maintenance_logs/",
  ADD_MAINTENANCE_URI:
    "http://34.78.78.202:31001/api/v1/data/channels/maintenance/add",
  DEVICE_RECENT_FEEDS:
    "http://34.78.78.202:31001/api/v1/data/feeds/transform/recent",
  REGISTER_DEVICE_URI: "http://34.78.78.202:31002/api/v1/devices/ts",
  ALL_DEVICES_URI: "http://34.78.78.202:31002/api/v1/devices",
  EDIT_DEVICE_URI: "http://34.78.78.202:31002/api/v1/devices/ts/update?device=",
  DEVICES_IN_LOCATION_URI:
    "http://34.78.78.202:31002/api/v1/devices/by/location?loc=",
  DEPLOY_DEVICE_URI:
    "http://34.78.78.202:31002/api/v1/devices/ts/activity?type=",
  DELETE_DEVICE_URI: "http://34.78.78.202:31002/api/v1/devices/ts/delete",
  GET_NETWORK_BEST_PERFORMING_DEVICES:
    "http://34.78.78.202:31006/api/v1/monitor/network/devices/bestperforming",
  GET_NETWORK_WORST_PERFORMING_DEVICES:
    "http://34.78.78.202:31006/api/v1/monitor/network/devices/worstperforming",
  ADD_COMPONENT_URI:
    "http://34.78.78.202:31002/api/v1/devices/add/components?device=",
  GET_ONLINE_OFFLINE_MAINTENANCE_STATUS:
    "http://34.78.78.202:31006/api/v1/monitor/devices/online_offline",
  GET_COMPONENTS_URI:
    "http://34.78.78.202:31002/api/v1/devices/list/components?device=",
  DELETE_COMPONENT_URI:
    "http://34.78.78.202:31002/api/v1/devices/delete/components?comp=",
  UPDATE_COMPONENT_URI:
    "http://34.78.78.202:31002/api/v1/devices/update/components?device=",
  /** analytics */
  GENERATE_CUSTOMISABLE_CHARTS_URI:
    "http://34.78.78.202:31003/api/v1/analytics/dashboard/customisedchart",
  GET_CUSTOMISABLE_CHART_INITIAL_DATA_URI:
    "http://34.78.78.202:31003/api/v1/analytics/dashboard/customisedchart/random",
  GET_MONITORING_SITES_LOCATIONS_URI:
    "http://34.78.78.202:31003/api/v1/analytics/dashboard/monitoringsites/locations?organisation_name=KCCA",
  GET_PM25_CATEGORY_COUNT_URI:
    "http://34.78.78.202:31003/api/v1/analytics/dashboard/locations/pm25categorycount?organisation_name=KCCA",
  GET_HISTORICAL_DAILY_MEAN_AVERAGES_FOR_LAST_28_DAYS_URI:
    "http://34.78.78.202:31003/api/v1/analytics/dashboard/historical/daily/devices",
  GENERATE_DEVICE_GRAPH_URI:
    "http://34.78.78.202:31003/api/v1/analytics/device/graph",
  DOWNLOAD_DATA:
    "http://34.78.78.202:31003/api/v1/analytics/data/download?type=",
  GET_DEFAULT_REPORT_TEMPLATE_URI:
    "http://34.78.78.202:31003/api/v1/analytics/report/get_default_report_template",
  SAVE_MONTHLY_REPORT_URI:
    "http://34.78.78.202:31003/api/v1/analytics/report/save_monthly_report",
  GET_MONTHLY_REPORT_URI:
    "http://34.78.78.202:31003/api/v1/analytics/report/get_monthly_report/",
  DELETE_MONTHLY_REPORT_URI:
    "http://34.78.78.202:31003/api/v1/analytics/report/delete_monthly_report/",
  UPDATE_MONTHLY_REPORT_URI:
    "http://34.78.78.202:31003/api/v1/analytics/report/update_monthly_report/",
  EXCEEDANCES_URI:
    "http://34.78.78.202:31003/api/v1/analytics/dashboard/exceedances",
  GET_MONITORING_SITES_URI:
    "http://34.78.78.202:31003/api/v1/analytics/dashboard/monitoringsites?organisation_name=KCCA",
  GET_DATA_MAP:
    "http://34.78.78.202:31003/api/v1/analytics/dashboard/monitoringsites?organisation_name=KCCA&pm25_category=",
  GET_HEATMAP_DATA: "http://34.78.78.202:31009/api/v1/predict/heatmap",
  UPDATE_ACTIVITY_LOG:
    "http://34.78.78.202:31002/api/v1/devices/ts/activity/update",
  DELETE_ACTIVITY_LOG:
    "http://34.78.78.202:31002/api/v1/devices/ts/activity/delete",
  UPDATE_COMPONENT:
    "http://34.78.78.202:31002/api/v1/devices/update/components",
  DELETE_COMPONENT:
    "http://34.78.78.202:31002/api/v1/devices/delete/components",
  DELETE_DEVICE_PHOTO: "http://34.78.78.202:31002/api/v1/devices/photos",
  EVENTS: "http://34.78.78.202:31002/api/v1/devices/events",
};

const defaultConfig = {
  PORT: process.env.PORT || 5000,
  NODE_PATH: process.env.NODE_PATH || "src",
};

function runConfig(env) {
  console.log(`running in ${env} mode`);
  switch (env) {
    case "development":
      return devConfig;
    case "staging":
      return stageConfig;
    case "production":
      return prodConfig;
    default:
      return prodConfig;
  }
}

export default { ...defaultConfig, ...runConfig(process.env.REACT_APP_ENV) };
