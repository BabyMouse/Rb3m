/**
 ** Add Code-Menu to HMTL at run-time.
 ** Add some features to Code-Box to HMTL at run-time.
 ** Source: https://github.com/rstudio/rmarkdown/blob/master/inst/rmd/h/navigation-1.1/codefolding.js
 */
/**
 * Ref: https://pandoc.org/MANUAL.html#syntax-highlighting
 * Ref: https://github.com/KDE/syntax-highlighting/tree/master/data/syntax
 */
let languages = new Map([
  ['abc', '"abc'],
  ['actionscript', 'ActionScript'],
  ['ada', 'ada'],
  ['agda', 'agda'],
  ['alertindent', 'alertindent'],
  ['apache', 'Apache'],
  ['asn1', 'asn1'],
  ['asp', 'asp'],
  ['ats', 'ats'],
  ['awk', 'awk'],
  ['bash', 'Bash'],
  ['bibtex', 'BibTeX'],
  ['boo', 'boo'],
  ['c', 'C'],
  ['changelog', 'changelog'],
  ['clojure', 'clojure'],
  ['cmake', 'CMake'],
  ['coffee', 'Coffee'],
  ['coldfusion', 'coldfusion'],
  ['commonlisp', 'CommonLisp'],
  ['cpp', 'C++'],
  ['cs', 'C#'],
  ['css', 'CSS'],
  ['curry', 'curry'],
  ['d', 'd'],
  ['default', 'default'],
  ['diff', 'diff'],
  ['djangotemplate', 'djangotemplate'],
  ['dockerfile', 'dockerfile'],
  ['dot', 'dot'],
  ['doxygen', 'doxygen'],
  ['doxygenlua', 'doxygenlua'],
  ['dtd', 'DTD'],
  ['eiffel', 'eiffel'],
  ['elixir', 'Elixir'],
  ['elm', 'elm'],
  ['email', 'Email'],
  ['erlang', 'erlang'],
  ['fasm', 'fasm'],
  ['fortran', 'Fortran'],
  ['fsharp', 'F#'],
  ['gcc', 'gcc'],
  ['glsl', 'glsl'],
  ['gnuassembler', 'gnuassembler'],
  ['go', 'Go'],
  ['hamlet', 'hamlet'],
  ['haskell', 'haskell'],
  ['haxe', 'haxe'],
  ['html', 'HTML/XHTML'],
  ['idris', 'idris'],
  ['ini', 'ini'],
  ['isocpp', 'isocpp'],
  ['j', 'j'],
  ['java', 'Java'],
  ['javadoc', 'javadoc'],
  ['javascript', 'JavaScript'],
  ['javascriptreact', 'JavaScriptReact'],
  ['json', 'json'],
  ['jsp', 'jsp'],
  ['julia', 'julia'],
  ['kotlin', 'kotlin'],
  ['latex', 'LaTeX'],
  ['lex', 'lex'],
  ['lilypond', 'lilypond'],
  ['literatecurry', 'literatecurry'],
  ['literatehaskell', 'literatehaskell'],
  ['llvm', 'llvm'],
  ['lua', 'Lua'],
  ['m4', 'm4'],
  ['makefile', 'makefile'],
  ['mandoc', 'mandoc'],
  ['markdown', 'Markdown'],
  ['mathematica', 'mathematica'],
  ['matlab', 'MATLAB/Octave'],
  ['maxima', 'maxima'],
  ['mediawiki', 'mediawiki'],
  ['metafont', 'metafont'],
  ['mips', 'mips'],
  ['modelines', 'modelines'],
  ['modula2', 'modula2'],
  ['modula3', 'modula3'],
  ['monobasic', 'monobasic'],
  ['mustache', 'mustache'],
  ['nasm', 'nasm'],
  ['noweb', 'noweb'],
  ['objectivec', 'Objective-C'],
  ['objectivecpp', 'Objective-C++'],
  ['ocaml', 'ocaml'],
  ['octave', 'octave'],
  ['opencl', 'opencl'],
  ['pascal', 'Pascal/Delphi'],
  ['perl', 'Perl'],
  ['php', 'PHP'],
  ['pike', 'pike'],
  ['postscript', 'PostScript'],
  ['povray', 'povray'],
  ['powershell', 'PowerShell'],
  ['prolog', 'prolog'],
  ['protobuf', 'protobuf'],
  ['pure', 'pure'],
  ['purebasic', 'purebasic'],
  ['python', 'Python'],
  ['qml', 'qml'],
  ['r', 'R'],
  ['relaxng', 'relaxng'],
  ['relaxngcompact', 'relaxngcompact'],
  ['rest', 'rest'],
  ['rhtml', 'rhtml'],
  ['roff', 'roff'],
  ['ruby', 'Ruby'],
  ['rust', 'rust'],
  ['scala', 'scala'],
  ['scheme', 'scheme'],
  ['sci', 'sci'],
  ['sed', 'sed'],
  ['sgml', 'sgml'],
  ['sml', 'sml'],
  ['sql', 'SQL'],
  ['sqlmysql', 'MySQL'],
  ['sqlpostgresql', 'PostgreSQL SQL'],
  ['stata', 'Stata'],
  ['tcl', 'tcl'],
  ['tcsh', 'tcsh'],
  ['texinfo', 'texinfo'],
  ['typescript', 'TypeScript'],
  ['verilog', 'verilog'],
  ['vhdl', 'vhdl'],
  ['xml', 'XML'],
  ['xorg', 'xorg'],
  ['xslt', 'XSLT'],
  ['xul', 'xul'],
  ['yacc', 'yacc'],
  ['yaml', 'YAML'],
  ['yml', 'YAML'],
  ['zsh', 'Z shell']
]);
let btnCode_Handler = function (elm, srcCodeID) {
  let btnCode_Text = elm.currentTarget.querySelector('span');
  if (btnCode_Text.innerText == 'Hide') {
    document.getElementById(srcCodeID).setAttribute('hidden', '');
    btnCode_Text.innerText = 'Code';
  } else {
    document.getElementById(srcCodeID).removeAttribute('hidden');
    btnCode_Text.innerText = 'Hide';
  }
};
let btnShowAllCode_Handler = function () {
  for (let elm of document.querySelectorAll('div.code-collapse')) elm.removeAttribute('hidden');
  for (let elm of document.querySelectorAll('button.code-box-btn span')) elm.innerText = 'Hide';
};
let btnHideAllCode_Handler = function () {
  for (let elm of document.querySelectorAll('div.code-collapse')) elm.setAttribute('hidden', '');
  for (let elm of document.querySelectorAll('button.code-box-btn span')) elm.innerText = 'Code';
};

function initializeCodeFolding(show) {
  /**
   ** Handlers for show-all and hide all Source code
   */
  document.getElementById('show-all-code').addEventListener('click', btnShowAllCode_Handler);
  document.getElementById('hide-all-code').addEventListener('click', btnHideAllCode_Handler);
  /**
   ** Handlers for Show/ Hide code button
   */
  let sourceCodeIndex = 1;

  /* select all R code blocks */
  for (let codeBlock of document.querySelectorAll('div.sourceCode')) {
    let sourceCodeID = 'sourceCodeIndex-' + sourceCodeIndex;
    let classList = codeBlock.querySelector('pre').className.split(' ');
    let language;
    for (let i = 0; i < classList.length; i++) {
      language = languages.get(classList[i]);
      if (language != undefined) break;
    }

    /* create a codefoding bar div */
    let divCodeBar = document.createElement('div');
    divCodeBar.classList.add('code-box-bar');
    divCodeBar.insertAdjacentHTML(
      'afterbegin',
      `<div class="code-box-label"><span class="sourceCode-index">#${sourceCodeIndex}</span><span>&horbar;</span><span class="sourceCode-lang">${language}</span></div>`
    );
    let btnCode = document.createElement('button');
    btnCode.setAttribute('type', 'button');
    btnCode.classList.add('btn-default', 'btn-xs', 'code-box-btn', 'pull-right');
    btnCode.setAttribute('data-target', sourceCodeID);
    btnCode.insertAdjacentHTML('afterbegin', '<span>' + (show ? 'Hide' : 'Code') + '</span>');
    btnCode.addEventListener(
      'click',
      function (elm) {
        btnCode_Handler(elm, sourceCodeID);
      },
      false
    );
    let divButtonGroup = document.createElement('div');
    divButtonGroup.classList.add('btn-group');
    divButtonGroup.append(btnCode);
    divCodeBar.append(divButtonGroup);
    codeBlock.append(divCodeBar);
    /* create a collapsable div to wrap the code in */
    let divCollapse = document.createElement('div');
    divCollapse.setAttribute('id', sourceCodeID);
    divCollapse.classList.add('collapse', 'code-collapse');
    if (!show) divCollapse.setAttribute('hidden', '');
    divCollapse.append(codeBlock.querySelector('pre'));
    codeBlock.append(divCollapse);
    sourceCodeIndex++;
  }
}
