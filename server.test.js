const test = require('node:test');
const assert = require('node:assert/strict');
const server = require('./server');

test('home page responds with the demo application', async () => {
  await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
  const address = server.address();
  try {
    const response = await fetch(`http://127.0.0.1:${address.port}/`);
    assert.equal(response.status, 200);
    assert.match(await response.text(), /Abode DevOps Lifecycle Demo/);
  } finally {
    await new Promise(resolve => server.close(resolve));
  }
});

test('health endpoint returns JSON status ok', async () => {
  await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
  const address = server.address();
  try {
    const response = await fetch(`http://127.0.0.1:${address.port}/health`);
    assert.equal(response.status, 200);
    assert.deepEqual(await response.json(), { status: 'ok', application: 'abode-devops-demo' });
  } finally {
    await new Promise(resolve => server.close(resolve));
  }
});

test('unknown routes return a JSON 404 response', async () => {
  await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
  const address = server.address();
  try {
    const response = await fetch(`http://127.0.0.1:${address.port}/does-not-exist`);
    assert.equal(response.status, 404);
    assert.deepEqual(await response.json(), { error: 'Not found' });
  } finally {
    await new Promise(resolve => server.close(resolve));
  }
});
