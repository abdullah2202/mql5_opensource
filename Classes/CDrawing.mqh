class CDrawing{
   private:
      color    defaultColor;
   public:
               CDrawing();
      void     drawHLine(string name, double price, color lineColor);
      void     drawHLine(string name, double price);
      void     drawHLine(double price);
      void     drawArrowUp(datetime time, double price);
      void     drawArrowDown(datetime time, double price);
      void     drawLevels(double& levels[], string preText);
      void     setDefaultColor(color colorToSet);
      void     deleteAllObjects();
      void     deleteAllObjects(string preText);
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

void CDrawing::drawArrowUp(datetime time, double price){
   ObjectCreate(0, "strat-arrowup", OBJ_ARROW_UP, 0, time, price);
   ObjectSetInteger(0, "strat-arrowup", OBJPROP_COLOR,clrGreen);
   ObjectSetInteger(0, "strat-arrowup", OBJPROP_WIDTH,3);
}

void CDrawing::drawArrowDown(datetime time, double price){
   ObjectCreate(0, "strat-arrowdown", OBJ_ARROW_DOWN, 0, time, price);
   ObjectSetInteger(0, "strat-arrowdown", OBJPROP_COLOR,clrRed);
   ObjectSetInteger(0, "strat-arrowdown", OBJPROP_WIDTH,3);
}

void CDrawing::deleteAllObjects(){
   ObjectsDeleteAll(0);
}

void CDrawing::deleteAllObjects(string preText){
   ObjectsDeleteAll(0, preText);
}

void CDrawing::drawLevels(double& levels[], string preText){
   for(int i=0; i<ArraySize(levels); i++){
      drawHLine(preText+(string) i, levels[i], defaultColor);
   }
}

void CDrawing::setDefaultColor(color colorToSet){
   defaultColor = colorToSet;
}