// Will register dev utilities on window
export const registerWindowMethods = () => {
  window.SendNotification = (data) => {
    window.dispatchEvent(
      new MessageEvent("message", {
        data: {
          action: "notify",
          ...data,
        },
      })
    );
  };
};

// Used for browser env handling
export const BrowserMockConfigData = {
  NotificationStyling: {
    group: true,
    position: "top-right",
    progress: true,
  },
  VariantDefinitions: {
    success: {
      classes: "success",
      icon: "done",
    },
    primary: {
      classes: "primary",
      icon: "info",
    },
    error: {
      classes: "error",
      icon: "dangerous",
    },
    police: {
      classes: "police",
      icon: "local_police",
    },
    ambulance: {
      classes: "ambulance",
      icon: "fas fa-ambulance",
    },
  },
};
