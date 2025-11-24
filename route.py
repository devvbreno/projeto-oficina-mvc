from app.controllers.application import Application
from bottle import Bottle, route, run, request, static_file
from bottle import redirect, template, response


app = Bottle()
ctl = Application()


#-----------------------------------------------------------------------------
# Rotas:

@app.route('/static/<filepath:path>')
def serve_static(filepath):
    return static_file(filepath, root='./app/static')

@app.route('/helper')
def helper(info= None):
    return ctl.render('helper')


#-----------------------------------------------------------------------------
# Suas rotas aqui:

@app.route('/oficina', methods=['GET'])
def action_oficina():
    return ctl.render('oficina')

@app.route('/create_order', method='POST')
def action_create_order():
    return ctl.create_order()

@app.route('/delete_order', method='POST')
def action_delete_order():
    id_to_delete = request.forms.get('id')
    return ctl.delete_order(id_to_delete)

#-----------------------------------------------------------------------------


if __name__ == '__main__':

    run(app, host='0.0.0.0', port=8080, debug=True)
