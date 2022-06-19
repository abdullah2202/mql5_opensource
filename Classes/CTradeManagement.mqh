#include <Trade/Trade.mqh>

class CTradeManagement{
   private:
      CTrade      trade;
   public:
                  CTradeManagement();
      void        makeTrade(  
                              string setupType, 
                     ENUM_ORDER_TYPE orderType,
                              double lot, 
                              double entry, 
                              double tp, 
                              double sl
                        );
      void        makeSellTrade(
                              double lot, 
                              double entry, 
                              double tp, 
                              double sl
                        );
      void        makeBuyTrade( 
                              double lot, 
                              double entry, 
                              double tp, 
                              double sl
                         );
};

CTradeManagement::CTradeManagement(){}

void CTradeManagement::makeTrade(
      string setupType,
      ENUM_ORDER_TYPE orderType,
      double lot,
      double entry,
      double tp,
      double sl
){
      trade.PositionOpen(
            _Symbol,
            orderType,
            lot,
            entry,
            sl,
            0,
            setupType + " trade. Magic Number: " + (string) trade.RequestMagic()
      );

      if(trade.ResultRetcode() == 10008 ||
         trade.ResultRetcode() == 10009){
            // Successfully placed trade
      }else{
            // Error placing trade.
            Print((string) GetLastError());
            ResetLastError();
            return;
      }
}

void CTradeManagement::makeBuyTrade(
      double lot,
      double entry,
      double tp,
      double sl
){
      double tradeEntry = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      makeTrade("Buy",ORDER_TYPE_BUY,lot,tradeEntry,tp,sl);
}

void CTradeManagement::makeSellTrade(
      double lot,
      double entry,
      double tp,
      double sl
){
      double tradeEntry = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      makeTrade("Sell",ORDER_TYPE_SELL,lot,tradeEntry,tp,sl);
}


