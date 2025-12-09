import eventlet
eventlet.monkey_patch()

from app.controllers.application import Application
from bottle import Bottle, static_file, request, debug
import socketio

sio = socketio.Server(async_mode='eventlet')
app = Bottle()
app_with_socket = socketio.WSGIApp(sio, app)
ctl = Application(sio)

# Rotas Normais (HTTP)
@app.route('/static/<filepath:path>')
def serve_static(filepath):
    return static_file(filepath, root='./app/static')

@app.route('/helper')
def helper():
    return ctl.render('helper')

@app.route('/oficina', method='GET')
def action_oficina():
    return ctl.render('oficina')

@app.route('/create_order', method='POST')
def action_create_order():
    return ctl.create_order()

@app.route('/delete_order', method='POST')
def action_delete_order():
    id_to_delete = request.forms.get('id')
    return ctl.delete_order(id_to_delete)

# Rotas de Login 
@app.route('/login', method='GET')
def action_login_view():
    return ctl.render('login')

@app.route('/login', method='POST')
def action_login_post():
    return ctl.authenticate_user()

@app.route('/logout', method='POST')
def action_logout():
    return ctl.logout_user()

# Eventos de Websocket 
@sio.event
def connect(sid, environ):
    print(f'[SocketIO] Novo navegador conectado: {sid}')

@sio.event
def disconnect(sid):
    print(f'[SocketIO] Navegador desconectado: {sid}')


if __name__ == '__main__':
    print("Iniciando servidor com suporte a Websocket na porta 8080...")
    
    debug(True)

    eventlet.wsgi.server(eventlet.listen(('0.0.0.0', 8080)), app_with_socket)