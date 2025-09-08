#!/bin/sh
WEB_JS=/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
if [ -s "$WEB_JS" ] && ! grep -q NoMoreNagging "$WEB_JS"; then
    echo "Patching Web UI nag..."
    sed -i -e "/data\.status/ s/!//" -e "/data\.status/ s/active/NoMoreNagging/" "$WEB_JS"
fi

MOBILE_TPL=/usr/share/pve-yew-mobile-gui/index.html.tpl
MARKER="<!-- MANAGED BLOCK FOR MOBILE NAG -->"
if [ -f "$MOBILE_TPL" ] && ! grep -q "$MARKER" "$MOBILE_TPL"; then
    echo "Patching Mobile UI nag..."
    printf "%s\n" \
      "$MARKER" \
      "<script>" \
      "  function watchAndRemoveDialog() {" \
      "    const observer = new MutationObserver(() => {" \
      "      const dialog = document.querySelector('dialog[aria-label=\"No valid subscription\"]');" \
      "      if (dialog) { dialog.remove(); console.log('Removed dialog: No valid subscription'); observer.disconnect(); }" \
      "    });" \
      "    observer.observe(document.body, { childList: true, subtree: true });" \
      "  }" \
      "  setTimeout(watchAndRemoveDialog, 100);" \
      "</script>" \
      "" >> "$MOBILE_TPL"
fi
