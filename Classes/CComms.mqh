class CComms{
   private:
   public:
            CComms();
      void  sendMessage(string message);

};

CComms::CComms(){

}

void CComms::sendMessage(string message){
   if(SendNotification(message)){
      Print("Notification Sent: ", message);
   }else{
      Print("Notification failed to send: ", message);
      Print("Notification Error: ", GetLastError());
   }
}



