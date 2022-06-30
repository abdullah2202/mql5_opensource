#include <Custom/CCandles.mqh>

class SRLevels{
private:
   int               numberOfCandles;
   int               numberOfLevels;
   ENUM_TIMEFRAMES   timeframe; 
   double            sensitivityPips;
   bool              isClearSupport(double support);
   bool              isClearResistance(double resistance);
   // void              arrayPush(double &array[], double price);
   void              arrayPush(double &array[][3], double price, int hits, int index);

   // Different methods of calculating SR Levels
   void              candleFlipCalculation();
   void              fractalCalculation();

   CCandles          candle;
public:
                     SRLevels();
   void              setSupport(double price, int hits, int index);
   void              setResistance(double price, int hits, int index);
   void              addHit(double &array[][3], int id);
   double            resistances[][3];
   double            supports[][3]; 
   void              clearLevels();

   // Calculate the Support and Resistance levels
   void              calculateLevels();

   // Get and Set functions
   double            getSupport(int id, int field);
   double            getResistance(int id, int field);
   int               getArraySize(double &array[][3]);
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
}

/**
 * @brief - Calculate the SR levels
 * 
 */
void SRLevels::calculateLevels(){
   clearLevels();

   // Candle flip calculation
   // candleFlipCalculation();

   // Fractal calculation
   fractalCalculation();

   
}

void SRLevels::candleFlipCalculation(){
   // Iterate through candles
   for(int i=1; i<getNumberOfCandles(); i++){

      double open_1 = candle.getOpen(i);

      // Calculate Support Levels
      if(
         candle.isBullish(i) &&
         candle.isBearish(i+1) &&
         open_1 < candle.getAsk() &&
         getSupportsSize() < getNumberOfLevels()
      ){
            if(isClearSupport(open_1)){
               setSupport(open_1, 1, i);
            }
      }
      // Calculate Resistance Levels
      if(
         candle.isBearish(i) &&
         candle.isBullish(i+1) &&
         open_1 > candle.getAsk() &&
         getResistancesSize() < getNumberOfLevels()
      ){
         if(isClearResistance(open_1)){
            setResistance(open_1, 1, i);
         }

      }

   }
}

void SRLevels::fractalCalculation(){
   // Start at 5 candles back
   for(int i=4; i<getNumberOfCandles(); i++){

      double open = candle.getOpen(i);

      // Support
      if(
         candle.isLowerLow(i,i-2) &&
         candle.isLowerLow(i,i-1) &&
         candle.isLowerLow(i,i+1) &&
         candle.isLowerLow(i,i+2) &&
         getSupportsSize() < getNumberOfLevels()
      ){
         if(isClearSupport(open))
            setSupport(open, 1, i);
      }

      // Resistance
      if(
         candle.isHigherHigh(i,i-2) &&
         candle.isHigherHigh(i,i-1) &&
         candle.isHigherHigh(i,i+1) &&
         candle.isHigherHigh(i,i+2) &&
         getResistancesSize() < getNumberOfLevels()
      ){
         if(isClearResistance(open))
            setResistance(open, 1, i);
      }

   }
}

/**
 * @brief - Copy levels over to arrays with previous levels
 *        - Delete objects drawn on chart for levels, (Delete all objects, simpler)
 * 
 */
void SRLevels::clearLevels(){
   ArrayResize(supports, 0);
   ArrayResize(resistances, 0);
}

bool SRLevels::isClearSupport(double support){
   if(getSupportsSize()>0){
      for(int i=0; i<getSupportsSize(); i++){
         if(support > (getSupport(i) - getSensitivityPips())){
            if(support < getSupport(i)){
               addHit(supports, i);
            }
            return false;
         }
      }
   }
   return true;
}

bool SRLevels::isClearResistance(double resistance){
   if(getResistancesSize()>0){
      for(int i=0; i<getResistancesSize(); i++){
         if(resistance < (getResistance(i) + getSensitivityPips())){
            if(resistance > getResistance(i)){
               addHit(resistances, i);
            }
            return false;
         }
      }
   }
   return true;
}



// -- Setter, Getter, and Helper Methods below

void SRLevels::setSupport(double price, int hits, int index){
   arrayPush(supports, price, hits, index);
}

void SRLevels::setResistance(double price, int hits, int index){
   arrayPush(resistances, price, hits, index);
}

void SRLevels::addHit(double &array[][3], int id){
   array[id][1] += 1; 
}

double SRLevels::getSupport(int id, int field = 0){
   return supports[id][field];
}

double SRLevels::getResistance(int id, int field = 0){
   return resistances[id][field];
}

int SRLevels::getArraySize(double &array[][3]){
   return ArraySize(array)/3;
}

int SRLevels::getResistancesSize(){
   return getArraySize(resistances);
}

int SRLevels::getSupportsSize(){
   return getArraySize(supports);
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
   sensitivityPips = sensitivity;
}

double SRLevels::getSensitivityPips(){
   return sensitivityPips;
}

void SRLevels::arrayPush(double &array[][3], double price, int hits, int index){
   int oldSize = ArraySize(array)/3, newSize = oldSize+1;
   ArrayResize(array, newSize);
   array[oldSize][0] = price;
   array[oldSize][1] = hits;
   array[oldSize][2] = index;
}


