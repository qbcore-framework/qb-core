let NOTIFY_CONFIG = null;

const defaultConfig = {
    NotificationStyling: {
        group: false,
        position: "right",
        progress: true,
    },
    VariantDefinitions: {
        success: { classes: "success", icon: "check_circle" },
        primary: { classes: "primary", icon: "notifications" },
        warning: { classes: "warning", icon: "warning" },
        error: { classes: "error", icon: "error" },
        police: { classes: "police", icon: "local_police" },
        ambulance: { classes: "ambulance", icon: "fas fa-ambulance" },
    },
};

const fetchNui = async (evName, data) => {
    const resourceName = window.GetParentResourceName();
    const resp = await fetch(`https://${resourceName}/${evName}`, {
        body: JSON.stringify(data),
        headers: { "Content-Type": "application/json; charset=UTF8" },
        method: "POST",
    });
    return resp.json();
};

const determineStyleFromVariant = (variant) => {
    return NOTIFY_CONFIG.VariantDefinitions[variant] ?? NOTIFY_CONFIG.VariantDefinitions["primary"];
};

const fetchNotifyConfig = async () => {
    try {
        NOTIFY_CONFIG = await fetchNui("getNotifyConfig", {});
        if (!NOTIFY_CONFIG) NOTIFY_CONFIG = defaultConfig;
    } catch (error) {
        console.error("Failed to fetch notification config, using default", error);
        NOTIFY_CONFIG = defaultConfig;
    }
};

const POSITION_MAP = {
    "top-left": { top: "16px", left: "16px" },
    "top-right": { top: "16px", right: "16px" },
    top: { top: "16px", left: "50%", transform: "translateX(-50%)" },
    "bottom-left": { bottom: "16px", left: "16px" },
    "bottom-right": { bottom: "16px", right: "16px" },
    bottom: { bottom: "16px", left: "50%", transform: "translateX(-50%)" },
    left: { top: "50%", left: "16px", transform: "translateY(-50%)" },
    right: { top: "50%", right: "16px", transform: "translateY(-50%)" },
    center: { top: "50%", left: "50%", transform: "translate(-50%, -50%)" },
};

let container = null;

const getContainer = () => {
    if (container) return container;
    const pos = NOTIFY_CONFIG.NotificationStyling.position ?? "right";
    const isBottom = pos.startsWith("bottom");
    container = document.createElement("div");
    container.id = "notify-container";
    Object.assign(container.style, {
        position: "fixed",
        display: "flex",
        flexDirection: isBottom ? "column-reverse" : "column",
        gap: "8px",
        zIndex: "9999",
        maxWidth: "400px",
        pointerEvents: "none",
        ...(POSITION_MAP[pos] ?? POSITION_MAP["right"]),
    });
    document.body.appendChild(container);
    return container;
};

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

const showNotif = async ({ data }) => {
    if (data?.action !== "notify") return;

    if (!NOTIFY_CONFIG) {
        await fetchNotifyConfig();
    }

    const { text: message, type, length: duration = 5000, caption } = data;
    const style = determineStyleFromVariant(type ?? "primary");
    const showProgress = NOTIFY_CONFIG.NotificationStyling.progress && duration > 0;

    const isFa = style.icon.startsWith("fa");
    const iconHtml = isFa ? `<i class="notify-icon ${style.icon}"></i>` : `<span class="notify-icon material-icons">${style.icon}</span>`;

    const item = document.createElement("div");
    item.className = `notify-item ${style.classes}`;
    item.innerHTML = `
        ${iconHtml}
        <div class="notify-content">
            <div class="notify-message${!caption ? " notify-multiline" : ""}">${message}</div>
            ${caption ? `<div class="notify-caption">${caption}</div>` : ""}
        </div>
        ${showProgress ? `<div class="notify-progress" style="animation-duration:${duration}ms"></div>` : ""}
    `;

    const c = getContainer();
    c.appendChild(item);

    await sleep(10);
    item.classList.add("notify-show");

    if (duration > 0) {
        setTimeout(() => {
            item.classList.remove("notify-show");
            item.classList.add("notify-hide");
            setTimeout(() => item.remove(), 350);
        }, duration);
    }
};

window.addEventListener("message", showNotif);
window.addEventListener("load", fetchNotifyConfig);
