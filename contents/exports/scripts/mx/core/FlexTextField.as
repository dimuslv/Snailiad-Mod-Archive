 
package mx.core
{
   import flash.text.TextField;
   import mx.utils.NameUtil;
   
   use namespace mx_internal;
   
   public class FlexTextField extends TextField
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      public function FlexTextField()
      {
         super();
         try
         {
            name = NameUtil.createUniqueName(this);
         }
         catch(e:Error)
         {
         }
      }
      
      override public function toString() : String
      {
         return NameUtil.displayObjectToString(this);
      }
   }
}
