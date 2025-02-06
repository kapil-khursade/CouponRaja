// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'flowbite'
import "toggle_coupon_code";
import "toggle_coupon_active_status";

document.addEventListener("turbo:load", () => {
    import("flowbite").then((module) => {
        module.initFlowbite();
    });
});
