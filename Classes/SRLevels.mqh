class SRLevels{
private:
   int               numberOfCandles;
   int               numberOfLevels;
   ENUM_TIMEFRAMES   timeframe; 
   double            sensitivityPips;
   bool              isClearSupport(double support);
   bool              isClearResistance(double resistance);
   void              arrayPush(double &array[], double price);
public:
                     SRLevels();
   void              setSupport(double price);
   void              setResistance(double price);
   double            resistances[];
   double            supports[]; 
   void              clearLevels();
   void              calculateLevels();
   double            getSupport(int id);
   double            getResistance(int id);
   int               getSupportsSize();
   int               getResistancesSize();
   void              setNumberOfCandles(int number);
   int               getNumberOfCandles();
   void              setNumberOfLevels(int levels);
   int               getNumberOfLevels();
   void              setTimeframe(ENUM_TIMEFRAMES timeframeToSet);
   ENUM_TIMEFRAMES   getTimeframe();
   void              setSensitivityPips(double sensitivity);
   double            getSensitivityPips();
};

// Constructor
SRLevels::SRLevels(){  
   // TODO: Have these vars set through params when creating this class via init method
   setNumberOfCandles(300);
   setNumberOfLevels(3);
   setTimeframe(PERIOD_M30);

   // Each level needs to be atleast 10 pips away from other levels
   setSensitivityPips(10);
}

/**
 * @brief - Calculate the SR levels
 * 
 */
void SRLevels::calculateLevels(){
   clearLevels();

   // Iterate through candles
   for(int i=1; i<getNumberOfCandles(); i++){
      
      double open_1 = iOpen(_Symbol,getTimeframe(),i);
      double close_1 = iClose(_Symbol,getTimeframe(),i);
      double open_2 = iOpen(_Symbol,getTimeframe(),i+1);
      double close_2 = iClose(_Symbol,getTimeframe(),i+1);
      // Calculate Support Levels
      if(
         close_1 > open_1 &&     // Bullish Candle
         close_2 < open_2 &&     // Bearish Candle
         open_1 < SymbolInfoDouble(_Symbol, SYMBOL_ASK) &&     // Support is below current price
         getSupportsSize() < getNumberOfLevels()
      ){
            if(isClearSupport(open_1)){
               setSupport(open_1);
            }
      }
      // Calculate Resistance Levels
      if(
         close_1 < open_1  &&    // Bearish Candle
         close_2 > open_2 &&     // Bullish Candle
         open_1 > SymbolInfoDouble(_Symbol, SYMBOL_ASK) &&     // Resistance is above current price
         getResistancesSize() < getNumberOfLevels()
      ){
         if(isClearResistance(open_1)){
            setResistance(open_1);
         }

      }
      // Print("Supports: " + (string) getSupportsSize());
      // Print("Resistances: " + (string) getResistancesSize());  
   }
}

/**
 * @brief - Copy levels over to arrays with previous levels
 *        - Delete objects drawn on chart for levels, (Delete all objects, simpler)
 * 
 */
void SRLevels::clearLevels(){
   // Copy supports over to previous array and delete objects
   // for(int i=0; i<getSupportsSize(); i++){
      // Copy current supports over to previousSupportsArray
      // TODO: 
   // }
   // for(int i=0; i<getResistancesSize(); i++){

   // }

   ArrayResize(supports, 0);
   ArrayResize(resistances, 0);

}

bool SRLevels::isClearSupport(double support){
   if(getSupportsSize()>0){
      for(int i=0; i<getSupportsSize(); i++){
         if(
            support > (getSupport(i) - getSensitivityPips())
         ){
            // If price is similar, increase strength of level?
            // if(price < getSupport(i))
            return false;
         }
      }
   }
   return true;
}

bool SRLevels::isClearResistance(double resistance){
   if(getResistancesSize()>0){
      for(int i=0; i<getResistancesSize(); i++){
         if(
            resistance < (getResistance(i) - getSensitivityPips())
         ){
            return false;
         }
      }
   }
   return true;
}



// -- Setter, Getter, and Helper Methods below



void SRLevels::setSupport(double support){
   arrayPush(supports, support);
}

void SRLevels::setResistance(double resistance){
   arrayPush(resistances, resistance);
}

double SRLevels::getSupport(int id){
   // ArrayPrint(supports);
   return supports[id];
}

double SRLevels::getResistance(int id){
   return resistances[id];
}

int SRLevels::getResistancesSize(){
   return ArraySize(resistances);
}

int SRLevels::getSupportsSize(){
   return ArraySize(supports);
}

void SRLevels::setNumberOfCandles(int number){
   numberOfCandles = number;
}

int SRLevels::getNumberOfCandles(){
   return numberOfCandles;
}

void SRLevels::setNumberOfLevels(int levels){
   numberOfLevels = levels;
}

int SRLevels::getNumberOfLevels(){
   return numberOfLevels;
}

void SRLevels::setTimeframe(ENUM_TIMEFRAMES timeframeToSet){
   timeframe = timeframeToSet;
}

ENUM_TIMEFRAMES SRLevels::getTimeframe(){
   return timeframe;
}

void SRLevels::setSensitivityPips(double sensitivity){
   sensitivityPips = (10 * SymbolInfoDouble(_Symbol, SYMBOL_POINT)) * sensitivity;
}

double SRLevels::getSensitivityPips(){
   return sensitivityPips;
}

void SRLevels::arrayPush(double &array[], double price){
   ArrayResize(array, ArraySize(array) + 1);
   array[ArraySize(array) - 1] = price;
}




