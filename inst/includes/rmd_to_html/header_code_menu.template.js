let btnMenuCode_Handler = function () {
  let ulDropdown = document.querySelector('ul.dropdown-menu');
  if (ulDropdown.getAttribute('hidden') == null) ulDropdown.setAttribute('hidden', '');
  else ulDropdown.removeAttribute('hidden');
};
let window_Handler = function (elm) {
  if (!elm.target.classList.contains('dropdown-toggle') && !elm.target.parentElement.classList.contains('dropdown-toggle'))
    document.querySelector('ul.dropdown-menu').setAttribute('hidden', '');
};
function initializeCodeMenu() {
  /**
   ** Handlers for show/ hide Code menu
   */
  document.querySelector('button.dropdown-toggle').addEventListener('click', btnMenuCode_Handler);
  window.addEventListener('click', function (elm) {
    window_Handler(elm);
  });
}
document.addEventListener('readystatechange', function () {
  if (document.readyState === 'complete') {
    /**
     ** Code menu
     ** - Code Folding
     ** - Source Embed
     */
    initializeCodeMenu();
    /*Rb3m:code_folding
    initializeCodeFolding('${code_folding}' === 'show');
    /Rb3m:code_folding*/
    /*Rb3m:code_download
    //initializeCodeDownload();
    /Rb3m:code_download*/
  }
});
