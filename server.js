// Minimal static server for the Scenario -> La Redoute pitch microsite.
// Serves index.html, the deck, media (images + video), and the PDF.
const express = require('express');
const path = require('path');

const app = express();
const ROOT = __dirname;

// Long cache for media (immutable assets), short for HTML.
app.use(express.static(ROOT, {
  extensions: ['html'],
  setHeaders(res, filePath) {
    if (/\.(mp4|jpg|jpeg|png|mp3|pdf)$/i.test(filePath)) {
      res.setHeader('Cache-Control', 'public, max-age=86400');
    } else {
      res.setHeader('Cache-Control', 'no-cache');
    }
  },
}));

// Health check for Railway.
app.get('/healthz', (_req, res) => res.status(200).send('ok'));

// Fallback to the microsite.
app.get('*', (_req, res) => res.sendFile(path.join(ROOT, 'index.html')));

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Scenario x La Redoute pitch live on :${port}`));
