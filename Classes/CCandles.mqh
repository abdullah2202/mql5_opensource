class CCandles{
   private:
      ENUM_TIMEFRAMES   mTimeframe;
      string            mSymbol;
   public:
                        CCandles();
      void              setTimeframe(ENUM_TIMEFRAMES timeframe);
      ENUM_TIMEFRAMES   getTimeframe();
      void              setSymbol(string symbol);
      string            getSymbol();

      double            getOpen(int shift);
      double            getHigh(int shift);
      double            getLow(int shift);
      double            getClose(int shift);

      double            getBid();
      double            getAsk();

      bool              isBearish(int shift);
      bool              isBullish(int shift);
      string            getType(int shift);

      double            getTopWickRatio(int shift);
      double            getBottomWickRatio(int shift);
      double            getWickRatio(double wick, double body);

      bool              isLowerLow(int shift, int checkShift);
      bool              isHigherLow(int shift, int checkShift);
      bool              isLowerHigh(int shift, int checkShift);
      bool              isHigherHigh(int shift, int checkShift);

      bool              isBodyBiggerThanWick(int shift);
};

// Constructor
CCandles::CCandles(){
   mTimeframe = PERIOD_M30;
   mSymbol = _Symbol;
}

void CCandles::setTimeframe(ENUM_TIMEFRAMES timeframe){
   mTimeframe = timeframe;
}

ENUM_TIMEFRAMES CCandles::getTimeframe(){
   return mTimeframe;
}

void CCandles::setSymbol(string symbol){
   mSymbol = symbol;
}

string CCandles::getSymbol(){
   return mSymbol;
}

double CCandles::getOpen(int shift = 0){
   return iOpen(mSymbol, mTimeframe, shift);
}

double CCandles::getHigh(int shift = 0){
   return iHigh(mSymbol, mTimeframe, shift);
}

double CCandles::getLow(int shift = 0){
   return iLow(mSymbol, mTimeframe, shift);
}

double CCandles::getClose(int shift = 0){
   return iClose(mSymbol, mTimeframe, shift);
}

double CCandles::getBid(){
   return SymbolInfoDouble(mSymbol, SYMBOL_BID);
}

double CCandles::getAsk(){
   return SymbolInfoDouble(mSymbol, SYMBOL_ASK);
}

bool CCandles::isBearish(int shift = 0){
   return getOpen(shift) > getClose(shift);
}

bool CCandles::isBullish(int shift = 0){
   return getClose(shift) > getOpen(shift);
}

string CCandles::getType(int shift = 0){
   if(isBearish(shift)){
      return "bearish";
   }
   return "bullish";
}

// Gets ratio of top Wick to Candle body
double CCandles::getTopWickRatio(int shift = 0){
   double wick;
   double body;
   if(isBearish(shift)){
      wick = getHigh(shift) - getOpen(shift);
      body = getOpen(shift) - getClose(shift);
   } else {
      wick = getHigh(shift) - getClose(shift);
      body = getClose(shift) - getOpene(shift);
   }
   return getWickRatio(wick, body);
}

// Gets ratio of bottom Wick to Candle body
double CCandles::getBottomWickRatio(int shift = 0){
   double wick;
   double body;
   if(isBearish(shift)){
      wick = getClose(shift) - getLow(shift);
      body = getOpen(shift) - getClose(shift);
   } else {
      wick = getOpen(shift) - getLow(shift);
      body = getClose(shift) - getOpene(shift);
   }
   return getWickRatio(wick, body);
}

double CCandles::getWickRatio(double wick, double body){
   return wick / body;
}

bool CCandles::isLowerLow(int shift, int checkShift){
   return getLow(shift) < getLow(checkShift);
}

bool CCandles::isHigherLow(int shift, int checkShift){
   return getLow(shift) > getLow(checkShift);
}

bool CCandles::isLowerHigh(int shift, int checkShift){
   return getHigh(shift) < getHigh(checkShift);
}

bool CCandles::isHigherHigh(int shift, int checkShift){
   return getHigh(shift) > getHigh(checkShift);
}

bool CCandles::isBodyBiggerThanWick(int shift){
   double totalSize = getHigh(shift) - getLow(shift);
   double bodySize = MathAbs(getOpen(shift) - getClose(shift));
   return bodySize > (totalSize - bodySize);
}


