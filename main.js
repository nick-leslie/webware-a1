function hideTab(tabName) {
  const tabs = document.getElementsByClassName("tabs")
  const buttons = document.getElementsByClassName("tab-button")
  for (i = 0; i < tabs.length; i++) {
    if (tabs[i].id != tabName) {
      tabs[i].classList.add("tab-hidden")
    } else {
      tabs[i].classList.remove("tab-hidden");
    }
  }
  for (i = 0; i < buttons.length; i++) {
    if(buttons[i].id == tabName) {
      buttons[i].classList.add("tab-button-active")
    } else {
      buttons[i].classList.remove("tab-button-active")
    }
  }
}
