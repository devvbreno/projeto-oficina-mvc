
class ServiceOrder():
    def __init__(self, id, client_name, vehicle_model, date, contact_phone, service_description, time, notes):
        self._id = id

        self.client_name = client_name
        self.vehicle_model = vehicle_model
        self.date = date
        self.contact_phone = contact_phone
        self.service_description = service_description
        self.time = time
        self._notes = notes
    
    @property
    def id(self):
        return self._id
    @property
    def client_name(self):
        return self._client_name
    
    @client_name.setter
    def client_name(self, value: str):
        if not value or not value.strip():
            raise ValueError ("Client name cannot be empty or invalid.")
        self._client_name = value.strip().title()
        return self._client_name
    
    @property
    def vehicle_model(self):
        return self._vehicle_model
    
    @vehicle_model.setter
    def vehicle_model(self, value: str):
        if not value or not value.strip():
            raise ValueError ("Vehicle model cannot be empty or invalid.")
        self._vehicle_model = value.strip().upper()
        return self._vehicle_model
    
    @property
    def date(self):
        return self._date
    
    @date.setter
    def date(self, value: str):
        if not value or not value.strip():
            raise ValueError ("Date cannot be empty or invalid.")
        self._date = value.strip()
        return self._date
    
    @property
    def contact_phone(self):
        return self._contact_phone
    
    @contact_phone.setter
    def contact_phone(self, value: str):
        if not value or not value.strip():
            raise ValueError ("Contact phone be empty or invalid.")
        self._contact_phone = value
        return self._contact_phone
    
    @property
    def service_description(self):
        return self._service_description
    
    @service_description.setter
    def service_description(self, value: str):
        if not value or not value.strip():
            raise ValueError ("Service description cannot be empty or invalid.")
        self._service_description = value.strip()
        return self._service_description
    
    @property
    def time(self):
        return self._time
    
    @time.setter
    def time(self, value: str):
        if not value or not value.strip():
            raise ValueError ("Time cannot be empty or invalid.")
        self._time = value.strip()
        return self._time
    
    @property
    def notes(self):
        return self._notes
    