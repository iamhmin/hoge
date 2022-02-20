"use strict";

// Join

// ---------------- Check-box ----------------

function selectAll(selectAll) {
  const checkboxes = document.getElementsByName("agreecheck");

  checkboxes.forEach((checkbox) => (checkbox.checked = selectAll.checked));
}

function checkSelectAll() {
  const checkboxes = document.querySelectorAll('input[name="agreecheck"]');
  const checked = document.querySelectorAll('input[name="agreecheck"]:checked');
  const selectAll = document.querySelector('input[name="selectall"]');

  if (checkboxes.length === checked.length) {
    selectAll.checked = true;
  } else {
    selectAll.checked = false;
  }
}

// Admin

// ---------------- Tab ----------------
{
  const tabList = document.querySelectorAll(".sub-nav__item");

  Array.prototype.forEach.call(tabList, function (list) {
    list.children[0].addEventListener("click", function (e) {
      e.preventDefault();

      const tabContents = document.querySelectorAll(".tab__content");
      const tabNum = this.parentElement.getAttribute("data-tabNum");

      Array.prototype.forEach.call(tabContents, function (cont, i) {
        cont.style.display = "none";
        tabList[i].className = "sub-nav__item";
      });

      tabContents[tabNum].style.display = "block";

      if (list.className.indexOf("active") == -1) {
        list.className = "sub-nav__item active";
      }
    });
  });
}


