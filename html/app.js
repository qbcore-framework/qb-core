const { useQuasar } = Quasar;
const { onMounted, onUnmounted } = Vue;
const app = Vue.createApp({
  setup() {
    const $q = useQuasar();
    const showNotif = (e) => {
      const text = e.data.text;
      const length = e.data.length;
      const type = e.data.type;
      const caption = e.data.caption;

      switch (type) {
        case 'success':
          classes = 'success';
          icon = 'done';
          break;
        case 'primary':
          classes = 'primary';
          icon = 'info';
          break;
        case 'error':
          classes = 'error';
          icon = 'dangerous';
          break;
        case 'police':
          classes = 'police';
          icon = 'local_police';
          break;
        case 'ambulance':
          classes = 'ambulance';
          icon = 'fas fa-ambulance';
          break;
      }

      if (text.length > 100) {
        multiline = true;
      } else {
        multiline = false;
      }

      $q.notify({
        message: text,
        caption: caption,
        multiLine: multiline,
        color: color,
        group: false,
        progress: true,
        position: 'right',
        timeout: length,
        icon: icon,
        classes: classes,
      });
    };
    onMounted(() => {
      window.addEventListener('message', showNotif);
    });
    onUnmounted(() => {
      window.removeEventListener('message', showNotif);
    });
    return {};
  },
});
app.use(Quasar, { config: {} });
app.mount('#q-app');
