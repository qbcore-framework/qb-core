import { fetchNui, isEnvBrowser } from "./utils.js";
import { BrowserMockConfigData } from "./testing.js";

export const DEV_MODE = false;

/**
 * @typedef NotiVariantData
 * @property {string} icon
 * @property {string} color
 **/

/**
 * Will hold config statically outside of Vue state
 * @property {Record<string, NotiVariantData>} VariantDefinitions
 * @property {Record<string, any>} NotificationStyling
 **/
export let NOTIFY_CONFIG = null;

/**
 * Pure function taking a notification type and returning an object
 * with style details
 * @param {string} variant
 * @returns NotiVariantData
 **/
export const determineStyleFromVariant = (variant) => {
  const variantData = NOTIFY_CONFIG.VariantDefinitions[variant];
  if (!variantData)
    throw new Error(`Style of type: ${variant}, does not exist in the config`);
  return variantData;
};

// Fetch and set NOTIFY_CONFIG from client script callback
export const fetchNotifyConfig = async () => {
  NOTIFY_CONFIG = await fetchNui("getNotifyConfig", {}, BrowserMockConfigData);
  if (isEnvBrowser() || DEV_MODE) {
    console.log("Fetched Config:");
    console.dir(NOTIFY_CONFIG);
  }
};

// We specifically wait for all other files to load
// just in case of a race condition between client handlers
// and NUI fetch call
window.addEventListener("load", async () => {
  await fetchNotifyConfig();
});
