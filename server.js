const http = require('node:http');

const PORT = Number(process.env.PORT || 3000);

const server = http.createServer((req, res) => {
  if (req.url === '/health') {
    res.writeHead(200, { 'content-type': 'application/json' });
    return res.end(JSON.stringify({ status: 'ok', application: 'abode-devops-demo' }));
  }

  if (req.url === '/') {
    res.writeHead(200, { 'content-type': 'text/html; charset=utf-8' });
    return res.end('<!doctype html><html><head><title>Abode DevOps Demo</title></head><body><main><h1>Abode DevOps Lifecycle Demo</h1><p>Sample application for CI, Docker and deployment-pipeline practice.</p><p>Health: <a href="/health">/health</a></p></main></body></html>');
  }

  res.writeHead(404, { 'content-type': 'application/json' });
  res.end(JSON.stringify({ error: 'Not found' }));
});

if (require.main === module) {
  server.listen(PORT, '0.0.0.0', () => console.log(`Abode demo listening on port ${PORT}`));
}

module.exports = server;
