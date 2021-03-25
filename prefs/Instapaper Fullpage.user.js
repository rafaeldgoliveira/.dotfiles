// ==UserScript==
// @name Instapaper Fullpage
// @match *://*.instapaper.com/*
// @grant none
// ==/UserScript==

function addGlobalStyle(css) {
    var head, style;
    head = document.getElementsByTagName('head')[0];
    if (!head) { return; }
    style = document.createElement('style');
    style.type = 'text/css';
    style.innerHTML = css;
    head.appendChild(style);
}

addGlobalStyle('.widemode #footer, .widemode #story, .widemode #titlebar, .widemode .read_content_container {max-width: 1400px!important;}');
addGlobalStyle('.story p {text-align: justify;}');
addGlobalStyle('.container-fluid {max-width: 100%!important;}');

