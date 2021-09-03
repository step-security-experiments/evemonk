// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import * as Sentry from "@sentry/browser";

Sentry.init({
  dsn: "https://185a236f4b994411a9f33c3c714cb34e@sentry.io/1424888",
});

import "@hotwired/turbo-rails"
import "@hotwired/stimulus-importmap-autoloader"
import { install } from "@github/hotkey"
import "jquery"
import "popper.js"
import "bootstrap"

document.addEventListener("turbo:load", () => {
  // $('[data-toggle="tooltip"]').tooltip();

  // Install all the hotkeys on the page
  for (const el of document.querySelectorAll("[data-hotkey]")) {
    install(el);
  }
});
