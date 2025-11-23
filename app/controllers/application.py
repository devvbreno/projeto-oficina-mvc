from bottle import template, request, redirect
from app.models.service_order import ServiceOrder
from app.controllers.db import 
class Application():

    def __init__(self):
        self.pages = {
            'helper': self.helper,
            'oficina': self.home_ofina
        }
        self.__model = DataRecord()

    def render(self,page):
       content = self.pages.get(page, self.helper)
       return content()


    def helper(self):
        return template('app/views/html/helper')

    def home_ofina(self):
        return template('app/views/html/home_oficina', error_message = None)
    
    def create_order(self):

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
        
        except ValueError as e:
            return template('app/views/html/home_oficina', error_message=str(e))