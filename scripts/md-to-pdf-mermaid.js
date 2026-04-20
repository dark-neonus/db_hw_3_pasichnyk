(async () => {
  const selectors = [
    'pre > code.language-mermaid',
    'pre > code.mermaid',
    'pre > code.lang-mermaid',
    'code.language-mermaid',
    'code.mermaid',
    'code.lang-mermaid',
  ];

  const codeNodes = Array.from(
    new Set(selectors.flatMap((s) => Array.from(document.querySelectorAll(s))))
  );

  if (codeNodes.length === 0 || typeof window.mermaid === 'undefined') {
    return;
  }

  const mermaidBlocks = codeNodes.map((codeNode, index) => {
    const pre = codeNode.parentElement?.tagName?.toLowerCase() === 'pre'
      ? codeNode.parentElement
      : codeNode;

    const container = document.createElement('div');
    container.className = 'mermaid';
    container.id = `mermaid-diagram-${index + 1}`;
    container.textContent = codeNode.textContent || '';
    pre.replaceWith(container);
    return container;
  });

  window.mermaid.initialize({
    startOnLoad: false,
    securityLevel: 'loose',
    theme: 'default',
  });

  if (typeof window.mermaid.run === 'function') {
    await window.mermaid.run({ nodes: mermaidBlocks });
  } else if (typeof window.mermaid.init === 'function') {
    window.mermaid.init(undefined, mermaidBlocks);
  }
})();
