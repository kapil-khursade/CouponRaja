document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".toggle_coupon_active_status").forEach(function (checkbox) {
      checkbox.addEventListener("change", function () {
        let couponId = this.dataset.couponId;
        let isChecked = this.checked;
  
        fetch(`/coupons/${couponId}/toggle_status`, {
          method: "PATCH",
          headers: {
            "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
            "Content-Type": "application/json"
          },
          body: JSON.stringify({ active_status: isChecked })
        })
        .then(response => response.json())
        .then(data => {
          if (data.success) {
            console.log(`Coupon ${couponId} status updated:`, data.active_status);
            this.classList.toggle("bg-success", data.active_status);
            this.classList.toggle("bg-secondary", !data.active_status);
          } else {
            alert("Failed to update status.");
            this.checked = !isChecked; // Revert toggle if update fails
          }
        })
        .catch(error => {
          console.error("AJAX Error:", error);
          alert("An error occurred.");
          this.checked = !isChecked;
        });
      });
    });
  });
  