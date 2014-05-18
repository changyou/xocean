'use strict';

var index = require('./controllers'),
    users = require('./controllers/users'),
    report = require('./controllers/report'),
    article = require('./controllers/article'),
    manage = require('./controllers/manage'),
    session = require('./controllers/session');

var middleware = require('./middleware');

/**
 * Application routes
 */
module.exports = function(app) {

  // Server API Routes
  app.post('/api/users', users.create);
  app.put('/api/users', users.changePassword);
  app.get('/api/users', users.getAll);
  app.get('/api/users/me', users.me);
  app.get('/api/users/:id', users.show);
  
  app.post('/api/users/activate', users.activate);
  app.post('/api/users/:id', users.sendRegistEmail);
  app.get('/api/user/findByCode', users.findByCode);
  app.post('/api/user/changeInfo', users.changeInfo);


  app.post('/api/session', session.login);
  app.del('/api/session', session.logout);

  app.post('/api/report', report.create);
  app.put('/api/report/:id', report.update);
  app.get('/api/report', report.list);
  app.get('/api/report/:id', report.get);
  app.del('/api/report/:id', report.del);
  app.post('/api/report/:id', report.sendEmail);
  app.get('/api/article', article.list);
  app.get('/api/report/:id/preview', report.preview);

  // manage Routes
  app.get("/api/manage/users", users.getAll);
  app.post('/api/manage/users', users.addUser);
  app.post("/api/manage/users/:id", users.sendRegistEmail);
  app.put('/api/manage/users/addallnew', users.addAllNew);

  // All undefined api routes should return a 404
  app.get('/api/*', function(req, res) {
    res.send(404);
  });

  // All other routes to use Angular routing in app/scripts/app.js
  app.get('/partials/*', index.partials);
  app.get('/manage/*', manage.manage);
  app.get('/*', middleware.setUserCookie, index.index);
};