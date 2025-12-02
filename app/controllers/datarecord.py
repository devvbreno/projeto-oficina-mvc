import os
from app.models.service_order import ServiceOrder
import json
import uuid
from app.models.user_account import UserAccount
import datetime

def log_debug(mensagem):
    try:
        current_dir = os.path.dirname(os.path.abspath(__file__))    
        project_root = os.path.dirname(os.path.dirname(current_dir))
        log_file = os.path.join(project_root, "debug_log.txt")
        with open(log_file, "a", encoding='utf-8') as f:
            timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            f.write(f"[{timestamp}] {mensagem}\n")
    except Exception as e:
        print(f"ERRO AO GRAVAR LOG: {e}")

class DataRecord():
    def __init__(self):
        log_debug("Iniciando datarecord...")

        current_directory = os.path.dirname(os.path.abspath(__file__))    
        self.__db_folder = os.path.join(current_directory, "db")
        self.__archive_db = os.path.join(self.__db_folder, "orders.json")     
        self.__users_db = os.path.join(self.__db_folder, "users.json")
        
        self.__users = []
        self.__orders = []
   
        self.__authenticated_users = {}

        self.read()

    def read(self):
        if not os.path.exists(self.__archive_db):
            self.__orders = []
        else:
            try:
                with open(self.__archive_db, "r") as archive_json:
                    datas_json = json.load(archive_json)
                    self.__orders = []
                    for data in datas_json:
                        order = ServiceOrder(**data)
                        self.__orders.append(order)
            except json.JSONDecodeError:
                self.__orders = []
        if not os.path.exists(self.__users_db):
            self.__users = []
            self.__users.append(UserAccount("admin", "admin"))
            self.save_users()
        else :
            try:
                with open(self.__users_db, "r") as f:
                    data = json.load(f)
                    self.__users = [UserAccount(**d) for d in data]
            except json.JSONDecodeError:
                self.__users = []
    
    def create_order(self, order: ServiceOrder):
        if not order.id:
            order._id = len(self.__orders) + 1
        self.__orders.append(order)
        self.save_to_json()
    
    def save_to_json(self):
        list_dicionary = []
        for ordem in self.__orders:
            order_dict = {
            "id": ordem.id,
            "client_name": ordem.client_name,
            "vehicle_model": ordem.vehicle_model,
            "date": ordem.date,
            "contact_phone": ordem.contact_phone,
            "service_description": ordem.service_description,
            "time": ordem.time,
            "notes": ordem.notes   
            }
            list_dicionary.append(order_dict)
        
        with open(self.__archive_db, "w") as archive_json:
            json.dump(list_dicionary, archive_json, indent=4)

    def get_all_orders(self):
        return self.__orders
    
    def delete_order(self, id_to_delete):
        order_founded = None
        for ordem in self.__orders:
            if ordem.id == id_to_delete:
                order_founded = ordem
                break
        
        if order_founded:
            self.__orders.remove(order_founded)
            self.save_to_json()
            return True 
        return False
    
    def save_users(self):
        if not os.path.exists(self.__db_folder):
            os.makedirs(self.__db_folder)

        datalist = [{"username": u.username, "password": u.password} for u in self.__users]

        with open(self.__users_db, "w") as f:
            json.dump(datalist, f, indent=4)

    def check_user(self, username, password):
        for user in self.__users:
            if user.username == username and user.password == password:
                session_id = str(uuid.uuid4())
                self.__authenticated_users[session_id] = user.username
                return session_id
        return None

    def get_username(self, session_id):
        if session_id in self.__authenticated_users:
            return self.__authenticated_users[session_id]
        return None

    def logout(self, session_id):
        """Remove a sessão da memória"""
        if session_id in self.__authenticated_users:
            del self.__authenticated_users[session_id]