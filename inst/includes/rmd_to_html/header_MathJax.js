<script type="text/x-mathjax-config">
    MathJax.Ajax.config.path["mhchem"] = "https://cdnjs.cloudflare.com/ajax/libs/mathjax-mhchem/3.3.2"; MathJax.Hub.Config({ TeX: { extensions: ["[mhchem]/mhchem.js"] } });
</script>

<!--
<script async id="MathJax-script" src="MathJax-master/es5/tex-mml-chtml.js">
    /**
     ** Source online: "https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"
     */
</script>

<script async id="MathJax-script" src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js">
    /**
     ** Source online: "https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"
     */
</script>

<script>
    MathJax = {
        loader: {
            load: ['[tex]/mhchem']
        },
        tex: {
            packages: {
                '[+]': ['mhchem']
            },
            inlineMath: [
                ['$', '$'],
                ['\(', '\)'],
                ['\\(', '\\)']
            ]
        },
        startup: {
            ready: function() {
                MathJax.startup.defaultReady();
            }
        }
    };

    MathJax = {
        tex: {
            inlineMath: [
                ['$', '$'],
                ['\(', '\)']
            ]
        }
    };

    window.MathJax = {
        startup: {
            ready: () => {
                console.log('MathJax is loaded, but not yet initialized');
                MathJax.startup.defaultReady();
                console.log('MathJax is initialized, and the initial typeset is queued');
            }
        },
        tex: {
            inlineMath: [
                ['$', '$'],
                ['\\(', '\\)']
            ]
        }
    };
</script>
-->