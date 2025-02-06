document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".toggle_coupon_code").forEach(button => {
        button.addEventListener("click", function () {
            let codeSpan = this.previousElementSibling;
            let actualCode = codeSpan.getAttribute("data-code");
            
            if (codeSpan.textContent.includes("****")) {
                codeSpan.textContent = actualCode;
                this.textContent = "Hide Code";
            } else {
                codeSpan.textContent = "***************";
                this.textContent = "Show Code";
            }
        });
    });
});

