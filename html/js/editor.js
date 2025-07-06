// editor.js – NUI-based config editor with type-aware, recursive editing

// State
let allData = {};
let currentFile = null;

// Select a file and render its data
function selectFile(file, liElement) {
    document.querySelectorAll(".file-list li").forEach((li) => li.classList.remove("active"));
    liElement.classList.add("active");
    currentFile = file;
    renderData();
}

// Render JSON data for the current file
function renderData() {
    if (!currentFile) return;
    const data = allData[currentFile];
    if (!data) {
        console.error(`No data found for ${currentFile}`);
        return;
    }
    buildEditor(data);
}

// Build main editor UI from data object
function buildEditor(data) {
    const container = document.getElementById("data-container");
    container.innerHTML = "";
    Object.entries(data).forEach(([key, value]) => {
        const card = document.createElement("div");
        card.className = "data-card";
        card.dataset.key = key;
        card.innerHTML = `<h3>${key}</h3>`;

        // value preview
        // const preview = document.createElement("div");
        // preview.className = "data-preview";
        // if (typeof value === "boolean") {
        //     preview.textContent = value;
        // } else if (Array.isArray(value)) {
        //     preview.textContent = `[${value.map((v) => (typeof v === "object" ? JSON.stringify(v) : v)).join(", ")}]`;
        // } else if (typeof value === "object" && value !== null) {
        //     preview.textContent = JSON.stringify(value);
        // } else {
        //     preview.textContent = value;
        // }
        // card.appendChild(preview);

        const editBtn = document.createElement("button");
        editBtn.className = "btn-edit";
        editBtn.innerHTML = `<span class='material-symbols-rounded'>edit</span> Edit`;
        editBtn.addEventListener("click", () => openEditModal(key, value));
        card.appendChild(editBtn);

        container.appendChild(card);
    });
}

// Recursive field builder
function buildFormFields(container, data, prefix = "") {
    const entries = Object.entries(data);

    // Sort fields: booleans first, then other flat fields, then nested objects
    const sorted = [
        ...entries.filter(([_, val]) => typeof val === "boolean"),
        ...entries.filter(([_, val]) => val !== null && typeof val !== "object" && typeof val !== "boolean"),
        ...entries.filter(([_, val]) => val !== null && typeof val === "object")
    ];

    sorted.forEach(([field, val]) => {
        if (typeof val === "boolean") {
            const group = document.createElement("div");
            group.className = "form-group form-toggle-group";

            const label = document.createElement("label");
            label.htmlFor = "field-" + prefix + field;
            label.textContent = field;
            group.appendChild(label);

            const toggleLabel = document.createElement("label");
            toggleLabel.className = "toggle-wrapper";

            const input = document.createElement("input");
            input.type = "checkbox";
            input.checked = val;
            input.name = prefix + field;
            input.id = "field-" + prefix + field;

            const span = document.createElement("span");
            span.className = "toggle-switch";

            toggleLabel.appendChild(input);
            toggleLabel.appendChild(span);
            group.appendChild(toggleLabel);

            container.appendChild(group);
        } else if (val !== null && typeof val === "object") {
            const group = document.createElement("div");
            group.className = "form-group";

            if (Array.isArray(val)) {
                val.forEach((item, idx) => {
                    if (item !== null && typeof item === "object") {
                        const fieldset = document.createElement("fieldset");
                        fieldset.className = "nested-fieldset";

                        const legend = document.createElement("legend");
                        legend.textContent = `${field}[${idx}]`;
                        fieldset.appendChild(legend);

                        buildFormFields(fieldset, item, `${prefix}${field}[${idx}].`);

                        // Delete button
                        const deleteBtn = document.createElement("button");
                        deleteBtn.textContent = "Delete";
                        deleteBtn.className = "delete-button";
                        deleteBtn.onclick = () => {
                            val.splice(idx, 1);
                            container.innerHTML = "";
                            buildFormFields(container, data, prefix);
                        };
                        fieldset.appendChild(deleteBtn);

                        group.appendChild(fieldset);
                    } else {
                        const itemGroup = document.createElement("div");
                        itemGroup.className = "form-group";

                        const itemLabel = document.createElement("label");
                        itemLabel.htmlFor = `field-${prefix}${field}[${idx}]`;
                        itemLabel.textContent = `${field}[${idx}]`;
                        itemGroup.appendChild(itemLabel);

                        if (typeof item === "boolean") {
                            itemGroup.classList.add("form-toggle-group");

                            const toggleLabel = document.createElement("label");
                            toggleLabel.className = "toggle-wrapper";

                            const input = document.createElement("input");
                            input.type = "checkbox";
                            input.checked = item;
                            input.name = `${prefix}${field}[${idx}]`;
                            input.id = `field-${prefix}${field}[${idx}]`;

                            const span = document.createElement("span");
                            span.className = "toggle-switch";

                            toggleLabel.appendChild(input);
                            toggleLabel.appendChild(span);
                            itemGroup.appendChild(toggleLabel);
                        } else {
                            const input = document.createElement("input");
                            input.type = "text";
                            input.value = item;
                            input.name = `${prefix}${field}[${idx}]`;
                            input.id = `field-${prefix}${field}[${idx}]`;
                            input.className = "form-control";
                            itemGroup.appendChild(input);
                        }

                        group.appendChild(itemGroup);
                    }
                });

                // Add button
                const addBtn = document.createElement("button");
                addBtn.textContent = "Add " + field;
                addBtn.className = "add-button";
                addBtn.onclick = () => {
                    val.push({});
                    container.innerHTML = "";
                    buildFormFields(container, data, prefix);
                };
                group.appendChild(addBtn);
            } else {
                const fieldset = document.createElement("fieldset");
                fieldset.className = "nested-fieldset";

                const legend = document.createElement("legend");
                legend.textContent = field;
                fieldset.appendChild(legend);

                buildFormFields(fieldset, val, prefix + field + ".");
                group.appendChild(fieldset);
            }

            container.appendChild(group);
        } else {
            const group = document.createElement("div");
            group.className = "form-group";

            const label = document.createElement("label");
            label.htmlFor = "field-" + prefix + field;
            label.textContent = field;
            group.appendChild(label);

            const input = document.createElement("input");
            input.type = "text";
            input.value = val;
            input.name = prefix + field;
            input.id = "field-" + prefix + field;
            input.className = "form-control";
            group.appendChild(input);

            container.appendChild(group);
        }
    });
}


// Open modal to edit a key
function openEditModal(key, value) {
    const modal = document.getElementById("edit-modal");
    modal.querySelector("h2").textContent = `${key}`;
    const formContainer = document.getElementById("editor-form");
    formContainer.innerHTML = "";

    const form = document.createElement("form");
    form.id = "editor-form-inner";

    // Determine if value is object or primitive
    const isObj = value !== null && typeof value === "object";
    const editableData = isObj ? value : {[key]: value};
    const prefix = isObj ? "" : key + ".";

    buildFormFields(form, editableData, prefix);
    formContainer.appendChild(form);

    // Save handler
    document.getElementById("save-item-btn").onclick = async (e) => {
        e.preventDefault();
        const formElem = document.getElementById("editor-form-inner");
        const updated = {...allData[currentFile]};
        const resultValue = {};

        Array.from(formElem.elements).forEach((el) => {
            if (!el.name) return;
            const name = el.name;
            let val;
            if (el.type === "checkbox") val = el.checked;
            else if (el.tagName === "TEXTAREA") {
                try {
                    val = JSON.parse(el.value);
                } catch {
                    val = el.value;
                }
            } else val = el.value;

            // assign into nested structure
            const path = name.split(/\.|\[|\]/).filter((p) => p);
            let target = resultValue;
            path.forEach((part, idx) => {
                const last = idx === path.length - 1;
                if (last) target[part] = val;
                else {
                    target[part] = target[part] || {};
                    target = target[part];
                }
            });
        });

        updated[key] = Array.isArray(value) || (value !== null && typeof value === "object") ? resultValue : resultValue[key];
        await saveConfig(updated);
    };

    setupModalClose();
    modal.classList.remove("hidden");
}

// Open modal to add a new key/value
function openNewItemModal() {
    const modal = document.getElementById("edit-modal");
    modal.querySelector("h2").textContent = "Add New Item";
    const formContainer = document.getElementById("editor-form");
    formContainer.innerHTML = "";

    const form = document.createElement("form");
    form.id = "editor-form-inner";

    // Key input
    const keyGroup = document.createElement("div");
    keyGroup.className = "form-group";
    const keyLabel = document.createElement("label");
    keyLabel.htmlFor = "new-key";
    keyLabel.textContent = "Key";
    const keyInput = document.createElement("input");
    keyInput.type = "text";
    keyInput.id = "new-key";
    keyInput.name = "key";
    keyInput.className = "form-control";
    keyGroup.append(keyLabel, keyInput);
    form.appendChild(keyGroup);

    // Value input
    const valGroup = document.createElement("div");
    valGroup.className = "form-group";
    const valLabel = document.createElement("label");
    valLabel.htmlFor = "new-value";
    valLabel.textContent = "Value";
    const valInput = document.createElement("input");
    valInput.type = "text";
    valInput.id = "new-value";
    valInput.name = "value";
    valInput.className = "form-control";
    valGroup.append(valLabel, valInput);
    form.appendChild(valGroup);

    formContainer.appendChild(form);

    // Add handler
    document.getElementById("save-item-btn").onclick = async (e) => {
        e.preventDefault();
        const key = document.getElementById("new-key").value.trim();
        const raw = document.getElementById("new-value").value;
        if (!key) {
            console.error("Key cannot be empty.");
            return;
        }
        let val;
        if (raw.toLowerCase() === "true" || raw.toLowerCase() === "false") val = raw.toLowerCase() === "true";
        else if ((raw.startsWith("{") && raw.endsWith("}")) || (raw.startsWith("[") && raw.endsWith("]"))) {
            try {
                val = JSON.parse(raw);
            } catch {
                val = raw;
            }
        } else val = raw;
        const updated = {...allData[currentFile]};
        updated[key] = val;
        await saveConfig(updated);
    };

    setupModalClose();
    modal.classList.remove("hidden");
}

// Save full config via NUI
async function saveConfig(configData) {
    try {
        const res = await fetch(`https://${GetParentResourceName()}/saveConfig`, {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({file: currentFile, data: configData}),
        });
        const result = await res.json();
        if (result === "ok") {
            allData[currentFile] = configData;
            console.log("Saved successfully!");
            closeModal();
            renderData();
        } else throw new Error(result);
    } catch (err) {
        console.error("Save failed.", err);
    }
}

// Modal close handlers
function setupModalClose() {
    document.getElementById("close-modal-btn").onclick = closeModal;
    document.getElementById("cancel-edit-btn").onclick = (e) => {
        e.preventDefault();
        closeModal();
    };
}

function closeModal() {
    document.getElementById("edit-modal").classList.add("hidden");
}

// Search/filter cards
function setupSearch() {
    document.getElementById("search-input").addEventListener("input", (e) => {
        const term = e.target.value.toLowerCase();
        document.querySelectorAll(".data-card").forEach((card) => {
            card.style.display = card.dataset.key.toLowerCase().includes(term) ? "" : "none";
        });
    });
}

// Keyboard shortcuts
function setupKeyboard() {
    window.addEventListener("keydown", (e) => {
        if (e.key === "Escape") closeModal();
    });
}

// Initialize UI
window.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".file-list li").forEach((li) => {
        const file = li.dataset.file;
        li.addEventListener("click", () => selectFile(file, li));
    });
    setupSearch();
    setupKeyboard();
});

// Listen for NUI messages and auto-select first file
window.addEventListener("message", (event) => {
    if (event.data.action === "populateData") {
        allData = event.data.data;
        if (!currentFile) {
            const firstLi = document.querySelector(".file-list li");
            if (firstLi) firstLi.click();
        }
    }
});
