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


	/* ((( WARNING : DO NOT REFORMAT THE CODE TEXT : Line 77 and 78 error )))*/
	

	import flash.geom.Point;

	public class Strings {
		private static var arabicChars: String = 'ًٌٍَُِّْٰٜٕٖۣٞٝٓٔٗ٘ٙٚٛؕؔؓؐؑؒۖۘۗۙۚۛۜۢ‌ـ?',
			arabicSames: Array = ['ؤو', '11', '22', '33', '44', '55', '66', '77', '88', '99', '00',
				'0٠۰', '1١۱', '9٩۹', '8٨۸', '7٧۷', '6٦۶', '5٥۵', '4٤۴', '3٣۳', '2٢۲', 'ييیىئ', 'اإأآ?', 'کك'
			],
			arabicWord: String = 'والي';


		public static function isArabic(str: String) {
			var reg: RegExp = new RegExp('[' + arabicChars + ']', 'g');
			var founced: uint = 0;
			var L: uint = Math.min(50, str.length);

			var searchResult: Object = reg.exec(str);
			while (searchResult != null && reg.lastIndex < L) {
				founced++;
				searchResult = reg.exec(str);
			}
			if (founced > L / 4) {
				return true;
			} else {
				return false;
			}
		}

		public static function isPersian(str: String, stringLength: Number = NaN): Boolean {
			var max: uint;
			if (isNaN(stringLength)) {
				max = Math.min(str.length, 200);
			} else {
				max = Math.min(str.length, stringLength);
			}
			for (var i = 0; i < max; i++) {
				if (str.charCodeAt(i) > 1000) {
					return true;
				}
			}
			return false;
		}


		public static function search(str: String, searchedWord: String, fineAll: Boolean = true, arabic: Boolean = false, arabic2: Boolean = false): Vector.<Point> {
			var founded: Vector.<Point> = new Vector.<Point> ();
			if (str == '' || str == ' ') {
				return founded;
			}
			if (arabic) {
				var regularEx: String = '';
				var L: int = searchedWord.length;
				var arabChars: String = arabicChars;
				if (arabic2) {
					arabChars += arabicWord;
				}
				for (var i = 0; i < L; i++) {
					var char: String = searchedWord.charAt(i);
					for (var j = 0; j < arabicSames.length; j++) {
						if (arabicSames[j].indexOf(char) != -1) {
							char = '[' + arabicSames[j] + ']';
							break;
						}
					}
					regularEx += char;
					if (i < L - 1) {
						regularEx += '[' + arabChars + ']*';
					}
				}
				var reg: RegExp = new RegExp(regularEx, 'g');
				var searchResult: Object = reg.exec(str);
				while (searchResult != null) {
					founded.push(new Point(searchResult.index, reg.lastIndex));
					searchResult = reg.exec(str);
					if (!fineAll) {
						break;
					}
				}
			} else {
				var f: int = -1;
				while ((f = str.indexOf(searchedWord, f + 1)) != -1) {
					founded.push(new Point(f, f + searchedWord.length));
					if (!fineAll) {
						break;
					}
				}
			}

			return founded;
		}



		public static function generateLinks(str: String, linkColors: int = -1): String {
			var colorTagStart: String = '';
			var colorTagEnd: String = '';
			if (linkColors != -1) {
				colorTagStart = '<font color="#' + linkColors.toString(16) + '">';
				colorTagEnd = '</font>';
			}
			var str: String = str;
			if (true) {
				var regNumberDetection: RegExp = /([\n\r\s\t,^])([\d-]{8,})/gi;
				trace("Find the phone : " + str);
				str = str.replace(regNumberDetection, '$1' + colorTagStart + '<a href="tel:$2">$2</a>' + colorTagEnd);
			}
			var regURLDetect: RegExp = /(www|http:\/\/)[^ \n\r]*/gi;
			str = str.replace(regURLDetect, colorTagStart + '<a href="http://$&">$&</a>' + colorTagEnd);
			var regDetectEmail: RegExp = /[a-z\.\-1234567890_]*\@[a-z\.\-_]*/gi;
			str = str.replace(regDetectEmail, colorTagStart + '<a href="mailto:$&">$&</a>' + colorTagEnd);
			var doubleHTTP: RegExp = /http:\/\/[ ]*http:\/\//gi;
			str = str.replace(doubleHTTP, 'http://');

			return str;
		}


		public static function clearDoubleQuartmarksOnJSON(str: String): String {
			var regexp: RegExp = /(":"((?!"\},\{)(?!",")(?!"\}\])(?!"\})(.))*[^\\])"((?!\},\{)(?!,")(?!\}\])(?!\}))/gi
			var lastStr: String;
			do {
				lastStr = str;
				str = str.replace(regexp, '$1\\"')
			} while (str != lastStr)
			return str;
		}



		public static function utfToUnicode(utfString: String): String {
			var reg: RegExp = /u[0-9a-f][0-9a-f][0-9a-f][0-9a-f]/gi;

			var searchResult: Object = reg.exec(utfString);
			var correctedString: String = '';
			var index: uint = 0;
			var lastIndex: uint = Infinity;
			var currentIndex: uint;
			while (searchResult != null) {
				lastIndex = reg.lastIndex;
				currentIndex = searchResult.index;

				correctedString += utfString.substring(index, currentIndex) + correctUTF(utfString.substring(currentIndex, lastIndex));
				index = lastIndex;
				searchResult = reg.exec(utfString);
			}
			correctedString += utfString.substring(index);

			return correctedString;
		}

		private static function correctUTF(utfWord: String): String {
			var num: String = utfWord.substring(1);
			return String.fromCharCode(parseInt(num, 16));
		}



		public static function short(str: String, len: uint = 10, removeEntersWith: String = ''): String {
			if (str == null) {
				return '';
			}
			if (removeEntersWith != '') {
				str = str.split('\r').join('\n').split('\n\n').join('\n').split('\n').join(removeEntersWith);
			}
			var dotString: String = '...';
			var spaceIndex: int = str.indexOf(' ', len - dotString.length);
			if (spaceIndex == -1) {
				if (str.length > len) {
					return str.substring(0, len - dotString.length) + dotString;
				} else {
					return str;
				}
			} else {
				if (spaceIndex >= str.length) {
					dotString = '';
				}
				return str.substr(0, spaceIndex) + dotString;
			}
		}



		public static function htmlCorrect(htm: String, linkColor: int = -1, replacePwithEnter: Boolean = false, fontSizeIs: Number = 20): String {
			return Mapper.htmlCorrect(htm, linkColor, replacePwithEnter, fontSizeIs)
		}


		public static function timeInString(seconds: Number): String {
			seconds = Math.ceil(seconds);
			var min: Number = Math.floor(seconds / 60);
			seconds = seconds % 60;
			var hour: Number = Math.floor(min / 60);
			min = min % 60;
			if (hour > 0) {
				return numToString(hour) + ':' + numToString(min) + ':' + numToString(seconds);
			} else {
				return numToString(min) + ':' + numToString(seconds);
			}
		}


		public static function numToString(num: * , numberLenght: uint = 2) {
			num = String(num);
			while (num.length < numberLenght) {
				num = '0' + num;
			}
			return num;
		}


		public static function removeHTML(ReferText: String): String {
			if (ReferText == null) {
				return '';
			}
			var htmlDeleter: RegExp = /<\/?[^>]*>/gi;
			return ReferText.replace(htmlDeleter, '');
		}


		public static function compairFarsiString(str1: String, str2: String): int {
			if (str1 == null) {
				str1 = '';
			}
			if (str2 == null) {
				str2 = '';
			}

			if (str1 == '' && str2 == '') {
				return 0;
			}

			if (str1 == '') {
				return -1;
			}
			if (str2 == '') {
				return 1;
			}

			var alephba: String = "ابپتثجچهخدذرزژسشصضطظعغفقكگلمنوهیي";
			var farsiStr1: String = AIRTL.KaafYe(str1);
			var farsiStr2: String = AIRTL.KaafYe(str2);

			var index1: int = alephba.indexOf(farsiStr1.charAt(0));
			var index2: int = alephba.indexOf(farsiStr2.charAt(0));

			if (index1 == -1 || index2 == -1) {
				if (str1 < str2) {
					return -1;
				} else if (str1 > str2) {
					return 1;
				} else {
					return 0;
				}
			}

			if (index1 < index2) {
				return -1;
			} else if (index1 > index2) {
				return 1;
			} else {
				return 0;
			}
		}
	}
}