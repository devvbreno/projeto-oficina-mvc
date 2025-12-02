from bottle import template, request, redirect, response
from app.models.service_order import ServiceOrder
from app.controllers.datarecord import DataRecord
class Application():

    def __init__(self):
        self.pages = {
            'helper': self.helper,
            'oficina': self.home_oficina,
            'login' : self.login 
        }
        self.__model = DataRecord()

    def render(self,page):
        content = self.pages.get(page, self.helper)
        return content()


    def helper(self):
        return template('app/views/html/helper')

    def home_oficina(self):
        session_id = request.get_cookie('session_id')
        current_user = self.__model.get_username(session_id)
        if not current_user:
            return redirect('/login')
        list_orders=self.__model.get_all_orders()
        return template('app/views/html/home_oficina', error_message = None, orders = list_orders)
    
    def create_order(self):
        session_id = request.get_cookie('session_id')
        if not self.__model.get_username(session_id):
            return redirect('/login')
        
        ids = None
        name =request.forms.get('nome')
        models = request.forms.get('veiculo')
        date = request.forms.get('data')
        phone = request.forms.get('telefone')
        service = request.forms.get('servico')
        times = request.forms.get('hora')
        notess = request.forms.get('observacoes')

        try:
            new_order = ServiceOrder(
                id= ids,
                client_name= name,
                vehicle_model= models,
                date= date,
                contact_phone= phone,
                service_description= service,
                time= times,
                notes= notess
            )   
            self.__model.create_order(new_order)
            return redirect('/oficina')
        
        except Exception as e:
            list_orders = self.__model.get_all_orders()
            return template('app/views/html/home_oficina', error_message=str(e), orders = list_orders)
        
    def delete_order(self, id_to_delete):
        session_id = request.get_cookie('session_id')
        if not self.__model.get_username(session_id):
            return redirect('/login')
        
        try:
            self.__model.delete_order(int(id_to_delete))
        except (ValueError, TypeError):
            pass
            
    def login(self):
        session_id = request.get_cookie('session_id')
        if self.__model.get_username(session_id):
            return redirect('/oficina')
        return template('app/views/html/login', error_message = None)
    
    def authenticate_user(self):
        username = request.forms.get('username')
        password = request.forms.get('password')

        session_id = self.__model.check_user(username, password)
        if session_id:
            response.set_cookie('session_id', session_id, httponly=True, max_age=3600)
            return redirect('/oficina')
        else:
            return template('app/views/html/login', error_message="Usuário ou senha inválidos.")

    def logout_user(self):
        session_id = request.get_cookie('session_id')
        if session_id:
            self.__model.logout(session_id)
            response.delete_cookie('session_id')
        return redirect('/login')