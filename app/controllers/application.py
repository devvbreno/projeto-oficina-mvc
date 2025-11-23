from bottle import template, request


class Application():

    def __init__(self):
        self.pages = {
            'helper': self.helper,
            'oficina': self.home_ofina
            'servicos': self.service_order
        }


    def render(self,page):
       content = self.pages.get(page, self.helper)
       return content()


    def helper(self):
        return template('app/views/html/helper')

    def home_ofina(self):
        return template('app/views/html/home_oficina')
    
    def order(self):

        self.value = {
            name = self.request.forms.get('nome'),
            models = self.request.forms.get('app/views/html/veiculo'),
            date = self.request.forms.get('data'),
            phone = self.request.forms.get('telefone'),
            service = self.request.forms.get('servico'),
            time = self.request.forms.get('hora'),
            notes = self.request.forms.get('observacoes'),
        }
        return self.value