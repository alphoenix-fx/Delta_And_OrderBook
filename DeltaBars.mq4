
#property strict



//--- indicator settings
#property  indicator_separate_window
#property  indicator_buffers 2
#property  indicator_color1  Red
#property  indicator_width1  1
#property  indicator_maximum 3
#property  indicator_minimum -3
#property indicator_level1     -.80
#property indicator_level2     .80
#property indicator_level3     0.0
//--- indicator parameters



#include <OrderBook.mqh>

OrderBook OB_Ask;
OrderBook OB_Bid;
int Track= 0;
//--- indicator buffers
double    ExtSignalBuffer[];
double    ExtSignalBufferBear[];
//--- right input parameters flag
bool      ExtParameters=false;
double    delta_prev = 0; 
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit(void)
  {
   IndicatorDigits(Digits+1);
//--- drawing settings
   
   SetIndexStyle(0,DRAW_HISTOGRAM,EMPTY,EMPTY,clrGreen);
   SetIndexStyle(1,DRAW_HISTOGRAM,EMPTY,EMPTY,clrRed);
//--- indicator buffers mapping
   
   SetIndexBuffer(0,ExtSignalBuffer);
   SetIndexBuffer(1,ExtSignalBufferBear);
//--- name for DataWindow and indicator subwindow label
   IndicatorShortName("Delta");
   
   SetIndexLabel(0,"Bull");
   SetIndexLabel(0,"Bear");
//--- check for input parameters
   if(false)
     {
      Print("Wrong input parameters");
      ExtParameters=false;
      return(INIT_FAILED);
     }
   else
      ExtParameters=true;
//--- initialization done
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Moving Averages Convergence/Divergence                           |
//+------------------------------------------------------------------+
int OnCalculate (const int rates_total,
                 const int prev_calculated,
                 const datetime& time[],
                 const double& open[],
                 const double& high[],
                 const double& low[],
                 const double& close[],
                 const long& tick_volume[],
                 const long& volume[],
                 const int& spread[])
  {
  
  
  
  
  
  
   int limit;
//---
   if(rates_total<=0 )
      return(0);
//--- last counted bar will be recounted
   limit=rates_total-prev_calculated;
   //Print(prev_calculated);
   if(prev_calculated>0)
      limit = limit  +1;
  
  
   double current_Ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   double current_Bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
   
   ulong current_Volume = Volume[0];//iTickVolume(_Symbol,PERIOD_M1,0);
   //Print( current_Volume);
   
   OB_Ask.Insert(current_Ask,current_Volume);
   OB_Bid.Insert(current_Bid,current_Volume);
   
   
   
   double UniqueAsk[];
   double UniqueNumsAsk[];
   
   double UniqueBid[];
   double UniqueNumsBid[];   
   
   double UniqueAskSize     = OB_Ask.SetArraysWithValues(UniqueNumsAsk,UniqueAsk);
 
   
   double UniqueBidSize     = OB_Bid.SetArraysWithValues(UniqueNumsBid,UniqueBid);
   
   
   double delatAsk = 0;
   double deltaBid = 0;
   double delta = 0;
   
   if( prev_calculated > Track){
      Track = prev_calculated;
      
      
       for( int i = 0 ; i< UniqueAskSize; i++){
  
   
   delatAsk +=  UniqueNumsAsk[i]*UniqueAsk[i];
  
   
   
   
   
   
   
      
   } 
   
   
   
   for( int i = 0 ; i< UniqueBidSize; i++){
   
   
   
   deltaBid +=  UniqueNumsBid[i]*UniqueBid[i];
   
    
   
   
   
   
      
   }
      //event 
      delta = delatAsk - deltaBid;
      
      if( Track==0){
      ExtSignalBuffer[0] = 0; //(current_Ask- delta)/current_Ask;  
      }
      else{
         
         
         
         if((current_Ask- delta)/current_Ask - delta_prev > 0){
         
            
         ExtSignalBuffer[0] = (current_Ask- delta)/current_Ask - delta_prev  ;   
         
         
         }
         
         if((current_Ask- delta)/current_Ask - delta_prev < 0){
         
         
         ExtSignalBufferBear[0] = (current_Ask- delta)/current_Ask - delta_prev  ;
         
         
         }
         
         
         delta_prev = (current_Ask- delta)/current_Ask;
         
         
         
         
           
      }
      OB_Ask.ClearBook();
      OB_Bid.ClearBook();   
   }
  
  
   //Print(prev_calculated);   
   //Print(limit);   
//--- macd counted in the 1-st buffer
   //for(i=0 ; i<limit-WalkDepth; i++)
      

//--- done
   return(rates_total);
  }
//+------------------------------------------------------------------+

