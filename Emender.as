package {


	/////////////////////////////////////////////////////////////////////////////////////////////
	//\                                                                                        // 
	//  \                                    AIRTL v 1.3 BETA                                  //
	//    \                   Arabic and RTL text engine for Android and IOS                   //
	//      \                 Contact : muradhuniti@gmail.com; drjo6@live.com                  //  
	//        \--------------------------------------------------------------------------------// 
	//          \                                                                              //
	//            \                     Author : Murad Zeyad AlHunaiti                         //
	//    *         >          © 2019 Hermes Developments. All rights reserved.                // 
	//            /                       Actionscript 3.0 library                             //
	//          /                                                                              //
	//        /--------------------------------------------------------------------------------// 
	//      /                                Special Thanks to                                 //
	//    /                    Jordan Academy of Arabic, Dr.Mohammad AlSo'udi                  //
	//  /                          Suha AlSo'ub, for the Arabic Map Class                      //
	///                                                                                        //
	/////////////////////////////////////////////////////////////////////////////////////////////



	/*******************************************************************************************\
	       # KINDLY REFER TO THE PROVIDED INSTRUCTIONS DOCUMENT FOR MORE USAGE INFORMATION
			 # YOU CAN'T USE THIS LIBRARY IN ANY SOFTWARE WITHOUT MY WRITTEN PERMISSION
	 \*****************************************************************************************/



	import flash.text.*;
	import flash.utils.getTimer;


	internal class Emender {

		public static function Adjust(str: String): String {
			return str.split('ﺎﻟ').join('ﻻ').split(String.fromCharCode(160)).join('').split('ﺄﻠ').join('ﻸ').split('ﺈﻠ').join('ﻺ').split('ﺂﻠ').join('ﻶ').split('ﺎﻠ').join('ﻼ').split('ﺄﻟ').join('ﻷ').split('ﺂﻟ').join('ﻵ').split('ﺈﻟ').join('ﻹ');
		}
	}

}