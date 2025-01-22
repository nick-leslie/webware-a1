function hideTab(tabName) {
  const tabs = document.getElementsByClassName("tabs")
  for (i = 0; i < tabs.length;i++) {
    if(tabs[i].id != tabName) {
      tabs[i].classList.add("tab-hidden")
    } else {
        tabs[i].classList.remove("tab-hidden");
    }
  }
}
