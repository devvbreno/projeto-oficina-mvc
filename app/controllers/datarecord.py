import os
from app.models.service_order import ServiceOrder
import json

class DataRecord():
    def __init__(self):
        self.__archive_db = "app/controllers/db/orders.json"
        self.__orders = []
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