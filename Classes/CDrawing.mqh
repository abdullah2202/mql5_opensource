class CDrawing{
   private:
   public:
               CDrawing();
      void     drawHLine(string name, double price, color lineColor);
      void     drawHLine(string name, double price);
      void     drawHLine(double price);
};

CDrawing::CDrawing(){}

void CDrawing::drawHLine(string name, double price, color lineColor){
   ObjectCreate(0, name, OBJ_HLINE, 0, 0, price);
   ObjectSetInteger(0,name,OBJPROP_COLOR,lineColor);       
   ObjectSetInteger(0,name,OBJPROP_WIDTH,3);               
   ObjectSetString(0,name,OBJPROP_TEXT,(string) price);   
}

void CDrawing::drawHLine(double price){
   ObjectCreate(0, "test", OBJ_HLINE, 0, 0, price);
   ObjectSetInteger(0,"test",OBJPROP_COLOR,clrOrange);       
   ObjectSetInteger(0,"test",OBJPROP_WIDTH,3);
}

void CDrawing::drawHLine(string name, double price){
   ObjectCreate(0, name, OBJ_HLINE, 0, 0, price);
   ObjectSetInteger(0,name,OBJPROP_COLOR,clrOrange);       
   ObjectSetInteger(0,name,OBJPROP_WIDTH,3);   
}