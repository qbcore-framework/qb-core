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
      color: "green",
      icon: "done",
    },
    primary: {
      color: "blue",
      icon: "info",
    },
    error: {
      color: "red",
      icon: "dangerous",
    },
    police: {
      color: "blue",
      icon: "local_police",
    },
    ambulance: {
      color: "red",
      icon: "fas fa-ambulance",
    },
  },
};
