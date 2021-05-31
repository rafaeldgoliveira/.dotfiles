// ==UserScript==
// @name WhatsApp Fullpage
// @match *://*web.whatsapp.com/*
// @grant none
// ==/UserScript==

function addGlobalStyle(css) {
	var head, style;
	head = document.getElementsByTagName("head")[0];
	if (!head) {
		return;
	}
	style = document.createElement("style");
	style.type = "text/css";
	style.innerHTML = css;
	head.appendChild(style);
}

addGlobalStyle(
	".app-wrapper-web > div { width: 100%!important; height: 100%!important; top: 0!important; }"
);
