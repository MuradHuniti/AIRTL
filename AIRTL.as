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



	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getTimer;



	public class AIRTL {
		private static var map: Mapper, cashedtext: SharedObject, sharedId: String = 'tempText';
		public static var deactiveConvertor: Boolean = false;
		public static var detectArabicScript: Boolean = false;
		public static function clearMyTemp(cashID: String = null) {
			if (cashID == null) {
				cashID = sharedId;
			}
			cashedtext = SharedObject.getLocal(cashID);
			cashedtext.clear();
			cashedtext = null;
		}

		public static function setID(newID: String) {
			sharedId = newID;
			firstSetUp(true);
		}

		public static function arabicNumber(myText: String): String {
			return map.NumberChange(myText);
		}

		public static function insert(str: String, useCash: Boolean = false, arabicNumber: Boolean = false) {

			if (deactiveConvertor && (!detectArabicScript || detectArabicScript && !Strings.isPersian(str))) {
				return str;
			}

			firstSetUp();
			if (str == '' || str == null) {
				return '';
			}

			var noData = useCash;
			if (useCash) {
				var ID = textID(null, str);
				var cashed: String = loadStringFromData(ID);
				if (cashed == null || cashed == 'undefined' || cashed == '') {
					noData = false;
				} else {
					return cashed;
				}
			}
			if (!noData) {
				var string: String = map.toRtl(String(str));
				if (arabicNumber) {
					string = map.NumberChange(string);
				}
				if (useCash) {
					saveStringOnID(ID, string);
				}
				return string;
			}
		}

		public static function convertText(target: TextField, tx: String, autoSize: Boolean = false): void {
			firstSetUp();
			if (autoSize) {
				target.height = 50;
			}
			target.multiline = true;
			target.wordWrap = true;
			if (deactiveConvertor && (!detectArabicScript || !Strings.isPersian(tx))) {
				target.text = tx;
			} else {
				map.convertText(target, tx);
			}
			if (autoSize) {
				target.height = target.textHeight + 10;
				target.mouseWheelEnabled = false;
			}
		}

		public static function htmlText(target: TextField, tx: String, useCash: Boolean = true, autoSize: Boolean = false, justify: Boolean = true, splitIfToLong: Boolean = false): void {
			firstSetUp();
			target.multiline = true;

			var detectedArabicScript: Boolean = true;
			var wasArabic: Boolean = true;

			if (detectArabicScript) {
				detectedArabicScript = Strings.isPersian(tx);
				wasArabic = detectedArabicScript;
			}

			if (useCash && !deactiveConvertor && detectedArabicScript) {
				var ID = textID(target, tx);
				var cashed: String = loadStringFromData(ID);
				if (cashed == null || cashed == 'undefined' || cashed == '') {
					tx = correctHTMLS(tx);
					map.HTMLconvertText(target, tx, justify);
					saveStringOnID(ID, target.htmlText);
				} else {
					target.htmlText = cashed;
				}
			} else {
				tx = correctHTMLS(tx);
				if ((deactiveConvertor || !detectedArabicScript) && !(detectArabicScript && detectedArabicScript)) {
					target.text = 'Murad';
					var tf: TextFormat;
					target.htmlText = target.htmlText.split(target.text).join(tx);
					tf = target.getTextFormat();
					if (justify && target.defaultTextFormat.align != TextFormatAlign.CENTER) {
						tf.align = TextFormatAlign.JUSTIFY;
						target.setTextFormat(tf);
					} else if (tf.align == TextFormatAlign.RIGHT) {
						tf.align = TextFormatAlign.LEFT;
						target.setTextFormat(tf);
					}

				} else {
					map.HTMLconvertText(target, tx, justify);
				}
			}
			if (splitIfToLong) {
				if (target.maxScrollV > 1) {
					var axxeptedText: String = '';
					var maxAxxeptedTextLine: uint = target.numLines - (target.maxScrollV - 1);
					var lineText: String;
					for (var i = 0; i < maxAxxeptedTextLine; i++) {
						lineText = target.getLineText(i);
						if (i == maxAxxeptedTextLine - 1) {
							var spaceIndex: uint;
							if (wasArabic) {
								spaceIndex = lineText.indexOf(' ', 2);
							} else {
								spaceIndex = lineText.lastIndexOf(' ', lineText.length - 3);
							}
							if (spaceIndex != -1) {
								if (wasArabic) {
									lineText = '...' + lineText.substring(spaceIndex + 1);
								} else {
									lineText = lineText.substring(spaceIndex + 1) + '...';
								}
							}
						}
						axxeptedText += lineText;
					}
					target.text = axxeptedText;
				}
			} else if (autoSize) {
				target.height = target.textHeight + 10;
			}
		}

		private static function correctHTMLS(htmlString: String): String {
			if (htmlString == null) {
				htmlString = '';
			}
			return htmlString.split('[[').join('<').split(']]').join('>')
		}

		private static function firstSetUp(forceToSetUp: Boolean = false) {
			if (map == null || forceToSetUp == true) {
				map = new Mapper();
				cashedtext = SharedObject.getLocal(sharedId);
				if (cashedtext.data['tempText2'] == undefined) {
					cashedtext.data['tempText2'] = new Object();
				}
			}
		}

		public static function resetTemp() {
			firstSetUp();
			cashedtext.data['tempText2'] = new Object();
		}



		private static function textID(yourTextField: TextField, tex: String): String {
			if (yourTextField == null) {
				yourTextField = new TextField();
			}
			var tf: TextFormat = yourTextField.defaultTextFormat;
			var size: Number = Number(tf.size);
			var font: String = tf.font;
			var bold: String = String(tf.bold);
			var ID: String = yourTextField.width + ',' + tex.length + ',' + tex.substring(0, 5) + ',' + tex.substring(tex.length - 5, tex.length) + ',' + zipTheText(tex.substr(tex.length / 2)) + ',' + zipTheText(tex.substr(0, tex.length / 2)) + ',' + size + ',' + font + bold;
			return ID;
		}


		private static function zipTheText(tex: String): uint {
			var tim: Number = getTimer();
			var myNum: uint = 0;
			for (var i = 0; i < tex.length; i++) {
				myNum += tex.charCodeAt(i);
			}
			return myNum;
		}

		private static function loadStringFromData(ID: String) {
			return cashedtext.data['tempText2'][ID];
		}


		private static function saveStringOnID(ID: String, Text: String) {
			cashedtext.data['tempText2'][ID] = Text;
			try {
				cashedtext.flush();
			} catch (e) {};
		}

		public static function KaafYe(str: String): String {
			return str.split('ی').join('ي').split('ک').join('ك').split('ى').join('ي');
		}

		public static function numberCorrection(str: String): String {
			firstSetUp();
			return map.numCorrection(str);
		}

		public static function clearArabicStyles(str: String): String {
			return str.split('ي').join('ی').split('ة').join('ه').split('‏').join(' ');
		}


		public static function isArabic(str: String): Boolean {
			for (var i = 0; i < str.length; i++) {
				if (str.charCodeAt(i) > 1000) {
					return true;
				}
			}
			return false;
		}
	}
}