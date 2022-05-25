class SRLevels{
private:
   double            resistances[];
   double            supports[]; 
   int               numberOfCandles;
   int               numberOfLevels;
   ENUM_TIMEFRAMES   timeframe; 
   double            sensitivityPips;
   bool              isClearSupport();
   bool              isClearResistance();
   void              arrayPush(double &array[], double price);
   void              setSupport(double price);
   void              setResistance(double price);
public:
                     SRLevels();
   void              clearLevels();
   void              CalculateLevels();
   double            getSupport(int id);
   double            getResistance(int id);
   int               getSupportsSize();
   int               getResistancesSize();
};

// Constructor
SRLevels::SRLevels(){
   // TODO: Have these vars set through params when creating this class.
   numberOfCandles = 300;
   timeframe = PERIOD_M30;

   // Each level needs to be atleast 10 pips away from other levels
   sensitivityPips = (10 * SymbolInfoDouble(_Symbol, SYMBOLE_POINT)) * 10;
}

/**
 * @brief - Copy levels over to arrays with previous levels
 *        - Delete objects drawn on chart for levels, (Delete all objects, simpler)
 * 
 */
void SRLevels::clearLevels(){
   // Copy supports over to previous array and delete objects
   for(int i=0; i<getSupportsSize(); i++){
      // Copy current supports over to previousSupportsArray
      // TODO: 
   }
   for(int i=0; i<getResistancesSize(); i++){

   }


}

void SRLevels::CalculateLevels(){
   clearLevels();

   // Iterate through candles
   for(int i=1; i<numberOfCandles; i++){
      
      double open_1 = iOpen(_Symbol,timeframe,i);
      double close_1 = iClose(_Symbol,timeframe,i);
      double open_2 = iOpen(_Symbol,timeframe,i+1);
      double close_2 = iClose(_Symbol,timeframe,i+1);

      // Calculate Support Levels
      if(
         close_1 > open_1 &&     // Bullish Candle
         close_2 < open_2 &&     // Bearish Candle
         open_1 < SymbolInfoDouble(_Symbol, SYMBOL_ASK) &&     // Support is below current price
         getSupportsSize<numberOfLevels
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
         getResistancesSize<numberOfLevels
      ){

         if(isClearResistance(open_1)){
            setResistance(open_1);
         }

      }



   }
}

bool SRLevels::isClearSupport(double support){
   if(getSupportsSize()>0){
      for(int i=0; i<getSupportsSize(); i++){
         if(
            support > (getSupport(i) - sensitivityPips)
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
            resistance < (getResistance(i) - sensitivityPips)
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
   return supports[id];
}

double SRLevels::getResistance(int id){
   return resistances[id];
}

int SRLevels::getResistancesSize(){
   return ArraySize(supports);
}

int SRLevels::getSupportsSize(){
   return ArraySize(resistances);
}

void SRLevels::arrayPush(double &array[], double price){
   ArrayResize(array, ArraySize(array) + 1);
   array[ArraySize[array] - 1] = price;
}




