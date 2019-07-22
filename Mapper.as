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




	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class Mapper {
		public static var UseNewFastInLine: Boolean = false;
		public static var splitters: Array = [',', '.', ' ', '-', ')', ':'];
		public static var adad = '٠١٢٣٤٥٦٧٨٩۰۱۲۳۴۵۶۷۸۹٠١٢٣٤٥٦٧٨٩٠١٢٣٤٥٦٧٨٩۰۱۲۳۴۵۶۷۸۹۰۱۲۳۴۵۶۷۸۹����٪٪';
		public static var estesna = '-[]»«)("/\\:';
		public static var forceToEnglish: String = '';
		private var MESlistChr: Object = {};
		private var helperObject: Object = {},
			typeHirostic: Object = {};

		public static var smartTextAlign: Boolean = false,
			floatingChars: String = "-/\\+=. ",
			notSureChars: String = "0123456789",
			lastRtlStatus: Boolean = true;

		public function Mapper(numCorrection: Boolean = true) {
			MESlistChr['پ'] = "ﭖ ﭗﺘﭙﺘﭘ";
			MESlistChr['ض'] = "ﺽ ﺾﺘﻀﺘﺿ";
			MESlistChr['ص'] = "ﺹ ﺺﺘﺼﺘﺻ";
			MESlistChr['ث'] = "ﺙ ﺚﺘﺜﺘﺛ";
			MESlistChr['ق'] = "ﻕ ﻖﺘﻘﺘﻗ";
			MESlistChr['ف'] = "ﻑ ﻒﺘﻔﺘﻓ";
			MESlistChr['غ'] = "ﻍ ﻎﺘﻐﺘﻏ";
			MESlistChr['ع'] = "ﻉ ﻊﺘﻌﺘﻋ";
			MESlistChr['ه'] = "ه ﻪﺘﻬﺘﻫ";
			MESlistChr['خ'] = "ﺥ ﺦﺘﺨﺘﺧ";;
			MESlistChr['ح'] = "ﺡ ﺢﺘﺤﺘﺣ";
			MESlistChr['ج'] = "ﺝ ﺞﺘﺠﺘﺟ";
			MESlistChr['چ'] = "ﭺ ﭻﺘﭽﺘﭼ";
			MESlistChr['ژ'] = "ﮊ ﮋﺗﮋﺗﮊ";
			MESlistChr['ش'] = "ﺵ ﺶﺘﺸﺘﺷ";
			MESlistChr['س'] = "ﺱ ﺲﺘﺴﺘﺳ";
			MESlistChr['ی'] = "ﯼ ﯽﺘﻴﺘﯾ";
			MESlistChr['ى'] = "ﯼ ﯽﺘﻴﺘﯾ";
			MESlistChr['ي'] = "ﯼ ﯽﺘﻴﺘﯾ";
			MESlistChr['ێ'] = "ێ ﯽﺘﻴﺘﯾ";
			MESlistChr['ب'] = "ﺏ ﺐﺘﺒﺘﺑ";
			MESlistChr['ل'] = "ﻝ ﻞﺘﻠﺘﻟ";
			MESlistChr['ڵ'] = "ڵ ﻞﺘﻠﺘﻟ";
			MESlistChr['ا'] = "ﺍ ﺎﺗﺎﺗﺍ";
			MESlistChr['ت'] = "ﺕ ﺖﺘﺘﺘﺗ";
			MESlistChr['ن'] = "ﻥ ﻦﺘﻨﺘﻧ";
			MESlistChr['م'] = "ﻡ ﻢﺘﻤﺘﻣ";
			MESlistChr['ظ'] = "ﻅ ﻆﺘﻈﺘﻇ";
			MESlistChr['ط'] = "ﻁ ﻂﺘﻄﺘﻃ";
			MESlistChr['ز'] = "ﺯ ﺰﺗﺰﺗﺯ";
			MESlistChr['ر'] = "ﺭ ﺮﺗﺮﺗﺭ";
			MESlistChr['ڕ'] = "ڕ ﺮﺗﺮﺗﺭ";
			MESlistChr['ذ'] = "ﺫ ﺬﺗﺬﺗﺫ";
			MESlistChr['د'] = "ﺩ ﺪﺗﺪﺗﺩ";
			MESlistChr['ئ'] = "ء ﺊﺘﺌﺘﺋ";
			MESlistChr['و'] = "ﻭ ﻮﺗﻮﺗﻭ";
			MESlistChr['ۆ'] = "ۆ ﻮﺗﻮﺗۆ";
			MESlistChr['ک'] = "ﮎ ﮏﺘﮑﺘﮐ";
			MESlistChr['ك'] = "ﮎ ﮏﺘﮑﺘﮐ";
			MESlistChr['گ'] = "ﮒ ﮓﺘﮕﺘﮔ";
			MESlistChr['آ'] = "ﺁ ﺂﺗﺂﺗﺁ";
			MESlistChr['أ'] = "ﺃ ﺄﺗﺄﺗﺃ";
			MESlistChr['إ'] = "ﺇ ﺈﺗﺈﺗﺇ";
			MESlistChr['ؤ'] = "ﺅ ﺆﺗﺆﺗﺅ";
			MESlistChr['ۀ'] = "ﮤ ﮥ ﮥ ﻫ";
			MESlistChr['؟'] = "؟";
			MESlistChr['ـ'] = "ــــــ";
			MESlistChr['«'] = "»";
			MESlistChr['»'] = "«";
			MESlistChr['['] = "]";
			MESlistChr[']'] = "[";
			MESlistChr['('] = ")";
			MESlistChr[')'] = "(";
			MESlistChr['٪'] = "%";
			MESlistChr['ً'] = "ًً";
			MESlistChr['ٌ'] = "";
			MESlistChr['ٍ'] = "ٍٍ";
			MESlistChr['َ'] = "ََ";
			MESlistChr['ْ'] = "ْْ";
			MESlistChr['ُ'] = "ُُ";
			MESlistChr['ِ'] = "ِِ";
			MESlistChr['ّ'] = "ّّ";
			MESlistChr['ة'] = "ﺓ ﺔﺘﻬﺘﻫ";
			MESlistChr[','] = ",";
			if (numCorrection) {
				MESlistChr['۰'] = "0";
				MESlistChr['۱'] = "1";
				MESlistChr['۲'] = "2";
				MESlistChr['۳'] = "3";
				MESlistChr['۴'] = "4";
				MESlistChr['۵'] = "5";
				MESlistChr['۶'] = "6";
				MESlistChr['۷'] = "7";
				MESlistChr['۸'] = "8";
				MESlistChr['۹'] = "9";
				MESlistChr['٤'] = "4";
				MESlistChr['٥'] = "5";
				MESlistChr['٦'] = "6";
				MESlistChr['٧'] = "7";
				MESlistChr['٨'] = "8";
				MESlistChr['٩'] = "9";
				MESlistChr['٣'] = "3";
				MESlistChr['٢'] = "2";
				MESlistChr['١'] = "1";
				MESlistChr['٠'] = "0";
			}
			MESlistChr[','] = "،";
		}



		public function convertText(yourTextField: TextField, tex: String, detectLanguage: Boolean = true) {
			var myTextcash = entersCorrection(tex).split(String.fromCharCode(10));
			tex = '';
			var i;
			for (i = 0; i < myTextcash.length; i++) {
				tex += toRtl(myTextcash[i]) + '\n';
			}
			tex = tex.substring(0, tex.length - 1);
			var myText: String = (tex);
			var parag: Array = myText.split('\n');
			var linesTest: Array = new Array();
			for (var j = 0; j < parag.length; j++) {
				yourTextField.text = parag[j];
				if (yourTextField.numLines == 1) {
					linesTest.push(parag[j]);
					continue;
				}
				var lastNumLines: uint;
				var spaces;
				var cnt = 0;
				while ((lastNumLines = yourTextField.numLines) > 1 && cnt < 1000) {
					cnt++;
					spaces = '';
					do {
						spaces += '-';
						yourTextField.text = spaces + parag[j];
					} while (lastNumLines == yourTextField.numLines);
					spaces = spaces.substring(1);
					yourTextField.text = spaces + parag[j];
					var cashedText: String = yourTextField.getLineText(lastNumLines - 1);
					var lineIndex = yourTextField.getLineOffset(lastNumLines - 1);

					var indexOfSplitters = Infinity;
					for (i = 0; i < splitters.length; i++) {
						var J = cashedText.indexOf(splitters[i]);
						if (J != -1) {
							indexOfSplitters = Math.min(indexOfSplitters, J);
						}
					}
					if (indexOfSplitters == Infinity) {
						indexOfSplitters = 0;
					}
					cashedText = cashedText.substring(indexOfSplitters);
					linesTest.push(cashedText);
					parag[j] = parag[j].substring(0, lineIndex + indexOfSplitters - spaces.length);
					yourTextField.text = parag[j];
				}
				linesTest.push(parag[j]);
			}
			yourTextField.text = '';
			for (i = 0; i < linesTest.length; i++) {
				yourTextField.appendText(linesTest[i] + '\n');
			}
			yourTextField.text = yourTextField.text.substring(0, yourTextField.text.length - 1);
		}


		public function HTMLconvertText(yourTextField: TextField, tex: String, justify: Boolean = true) {
			var myTextcash = entersCorrection(tex).split(String.fromCharCode(10));
			var parag: Array = [];
			var i;
			var corrected: String;

			var lastWorldWrapMode: Boolean = yourTextField.wordWrap;
			yourTextField.wordWrap = false;

			yourTextField.text = ' ';
			var spaceWidth: Number = yourTextField.getCharBoundaries(0).width;


			var cashedText: String;
			var xmlSpace: String;

			xmlSpace = '<flashrichtext version="1"><textformat>( )</textformat></flashrichtext>';
			var l: uint;
			var lastIndex: uint;
			var lastSpace: int;
			var lineW: Number;
			var textWidth: Number;
			var charRect: Rectangle;
			var lineString: String;

			textWidth = yourTextField.width - 7;

			for (i = 0; i < myTextcash.length; i++) {
				corrected = HTMLUnicode(myTextcash[i]);
				parag.push(corrected);
			}
			var linesTest: Array = new Array();
			for (var j = 0; j < parag.length; j++) {
				yourTextField.htmlText = parag[j];
				cashedText = yourTextField.text;
				lastIndex = l = yourTextField.text.length;
				lineW = 0;
				lastSpace = -1;
				var step: uint = 1;
				var realLineSize: Number;

				var lastW: Number;
				var lastCharInLineLeftX: Number = NaN;
				var lastCharLeft: Number;
				var charLeft: Number;
				var spaceLeft: Number;

				const stepPrecent: Number = 0.78;

				for (i = l - 1; i >= 0; i -= step) {
					step = 1;
					charRect = yourTextField.getCharBoundaries(i);
					if (charRect == null) {
						continue;
					} else if (isNaN(lastCharInLineLeftX)) {
						lastCharInLineLeftX = charRect.right + 1;
					}
					lastCharLeft = charLeft;
					charLeft = charRect.left;
					lastW = lineW;
					lineW = lastCharInLineLeftX - charLeft;

					if (lineW > textWidth) {
						if (lastSpace != -1) {
							lineString = yourTextField.getXMLText(lastSpace + 1, lastIndex);
							step = Math.ceil((lastIndex - lastSpace) * stepPrecent);
							lastIndex = lastSpace;
							i = lastSpace;
							realLineSize = lastCharInLineLeftX - spaceLeft;
							lastCharInLineLeftX = spaceLeft;
						} else {
							lineString = yourTextField.getXMLText(i + 1, lastIndex);
							step = Math.ceil((lastIndex - i + 1) * stepPrecent);
							lastIndex = i;
							i++;
							realLineSize = lastCharInLineLeftX - lastCharLeft;
							lastCharInLineLeftX = lastCharLeft;
						}
						if (justify) {
							lineString = insertSpaceInXML(lineString, Math.floor((textWidth - realLineSize) / spaceWidth));
						}
						linesTest.push(lineString);
						lastSpace = -1;
						lineW = 0;
					} else if (cashedText.charAt(i) == ' ') {
						lastSpace = i;
						spaceLeft = charLeft;
					}
				}

				linesTest.push(yourTextField.getXMLText(0, lastIndex));


				if (linesTest.length == 1) {
					continue;
				}
			}
			var enterXML: String = '<flashrichtext version="1"><textformat>(\n)</textformat></flashrichtext>';
			yourTextField.text = '';
			l = linesTest.length;
			for (i = 0; i < linesTest.length; i++) {
				yourTextField.insertXMLText(yourTextField.length, yourTextField.length, linesTest[i]);
				if (i != l - 1) {
					yourTextField.insertXMLText(yourTextField.length, yourTextField.length, enterXML);
				}
			}
		}



		private function insertSpaceInXML(xmlText: String, numSpaces: int = 0, removeExtraSpaces: Boolean = true): String {
			numSpaces = Math.max(0, numSpaces);
			var purString: String = xmlText.substring(xmlText.indexOf('>(') + 2, xmlText.lastIndexOf(')<'));
			if (false) {
				var removedSpaces: uint = purString.length;
				purString = purString.replace(/^[\s]+/gi, '');
				purString = purString.replace(/[\s]+$/gi, '');
				removedSpaces -= purString.length;
				numSpaces += removedSpaces;
			}

			var splitedWorld: Array = purString.split(' ');
			if (splitedWorld.length > 1) {
				for (var i = 0; i < numSpaces; i++) {
					var selectedWorld: uint = randGen(i, splitedWorld.length - 1);
					splitedWorld[selectedWorld] = splitedWorld[selectedWorld] + ' ';
				}
				purString = splitedWorld.join(' ');
			}
			xmlText = xmlText.substring(0, xmlText.indexOf('>(') + 2) + purString + xmlText.substring(xmlText.lastIndexOf(')<'));
			return xmlText;
		}

		private function randGen(seed: uint, length: uint): uint {
			return Math.floor(length * 0.9 * seed) % length;
		}



		public function toRtl(ch, style = 0) {
			if (ch == '') {
				return '';
			}
			lastRtlStatus = true;
			ch = farsiCorrection(ch);
			var matn = "";
			var v0: int, v1: int, v2: int;
			var numString = '';
			var parantez;
			var chC1, chC2;
			var stringLenght: uint = ch.length;

			if (ch == '') {
				return ch;
			}



			for (var i = 0; i < ch.length; i++) {
				if (MESisEnglish(ch.charAt(i), ch, i, stringLenght)) {
					parantez = ch.charAt(i)
					if (parantez == ')' || parantez == '(') {
						chC1 = ch.charAt(i - 1);
						chC2 = ch.charAt(i + 1);
						if (chC1 == ' ' || chC1 == '') {
							chC1 = 0
						} else if (MESisEnglish(chC1)) {
							chC1 = 1
						} else {
							chC1 = -1
						}
						if (chC2 == ' ' || chC2 == '') {
							chC2 = 0
						} else if (MESisEnglish(chC2)) {
							chC2 = 1
						} else {
							chC2 = -1
						}
						if (chC1 != 1 && chC2 != 1) {
							parantez = (parantez == ')') ? '(' : ')';
						}
					}
					numString += parantez;
					continue;
				} else {
					matn = MESbekesh(numString) + matn;
					numString = ''
				}

				v1 = MESfindeType(ch.charAt(i));
				var j = 1;
				do {
					v0 = MESfindeType(ch.charAt(i - j));
					j++
				} while (v0 == 4);
				j = 1;
				do {
					v2 = MESfindeType(ch.charAt(i + j));
					j++
				} while (v2 == 4);

				if (i == 0) {
					if (style == 1 || style == 3) {
						v0 = 3;
					}
				}
				if (i == ch.length - 1) {
					if (style == 2 || style == 3) {
						v2 = 3;
					}
				}
				if (v1 == 4) {
					v1 = (v0 & 1) + (v2 & 2);
				} else {
					v1 = (((v2 & 1) << 1) & (v1 & 2)) + ((v1 & 1) & ((v0 & 2) >> 1));
				}
				matn = MESbekesh(ch.charAt(i), v1) + matn;
			}
			matn = MESbekesh(numString) + matn;
			matn = Emender.Adjust(matn);
			return matn;
		}



		public function numCorrection(str: String): String {
			var I = String('۰').charCodeAt(0);
			for (var i = I; i < I + 10; i++) {
				str = str.split(String.fromCharCode(i)).join(String(i - I));
			}
			I = String('٠').charCodeAt(0);
			for (i = I; i < I + 10; i++) {
				str = str.split(String.fromCharCode(i)).join(String(i - I));
			}
			return str;
		}


		public function NumberChange(str: String, zero: String = '۰') {
			var I = String('۰').charCodeAt(0);
			for (var i = 0; i < 10; i++) {
				str = str.split(String(i)).join(String.fromCharCode(i + I));
			}
			return str;
		}

		public function entersCorrection(str: String): String {
			return String(str).split(String.fromCharCode(13)).join(String.fromCharCode(10)).split(String.fromCharCode(10) + String.fromCharCode(10)).join(String.fromCharCode(10));
		}



		private function getChars(parag: String, char: String = ' '): Array {
			var founded: Array = new Array();
			var f: int = 0;
			var cnt: int = -1;
			while ((f = parag.indexOf(char, f + 1)) != -1 && cnt < 100) {
				cnt++;
				founded.push(f);
			}
			return founded;

		}

		public function farsiCorrection(str: String) {
			return str.split('آ').join('آ').split('ی').join('ي').split('‌').join(' ').split('‏').join(' ').split('¬').join(' ');
		}






		private function MESisEnglish(megh: String, copleteString: String = null, charIndex: uint = 0, stringLength: uint = 0, lookingForard: Boolean = false) {
			var test: * ;
			if (smartTextAlign && copleteString != null) {
				if (floatingChars.indexOf(megh) != -1) {
					for (var i = charIndex + 1; i < stringLength; i++) {
						test = MESisEnglish(copleteString.charAt(i), copleteString, i, stringLength, true);
						if (!lookingForard) {
							lastRtlStatus = test;
						}
						return test;
					}
					return lastRtlStatus;
				} else if (lookingForard && notSureChars.indexOf(megh) != -1) {
					return lastRtlStatus;
				}
			}
			test = helperObject[megh];
			if (test != undefined) {
				if (!lookingForard && notSureChars.indexOf(megh) == -1) {
					lastRtlStatus = test;
				}
				return test;
			}
			if ((forceToEnglish.indexOf(megh) != -1 || (MESlistChr[megh] == undefined && megh.charCodeAt(0) < 1417 && estesna.indexOf(megh) == -1) || (adad.indexOf(megh) != -1))) {
				helperObject[megh] = true;
				if (!lookingForard && notSureChars.indexOf(megh) == -1) {
					lastRtlStatus = true;
				}
				return true
			} else {
				helperObject[megh] = false;
				if (!lookingForard && notSureChars.indexOf(megh) == -1) {
					lastRtlStatus = false;
				}
				return false;
			}
		}

		private function MESfindeType(ch): int {

			var cash = typeHirostic[ch];
			if (cash != undefined) {
				return cash;
			}

			var typ: int = 00;
			var founded: String = MESlistChr[ch] as String;
			if (founded != null) {
				if (founded.length == 6 && founded.charAt(2) == founded.charAt(1)) {
					typ = 3;
				} else if (founded.length == 1) {
					typ = 0;
				} else if (founded.length == 2) {
					typ = 4;
				} else if (founded.charAt(4) == founded.charAt(2)) {
					typ = 1;
				} else if (founded.charAt(4) == founded.charAt(6)) {
					typ = 2;
				} else if (founded.charAt(0) == founded.charAt(4)) {
					typ = 0;
				} else {
					typ = 3;
				}
			}
			typeHirostic[ch] = typ;
			return typ
		}


		private function MESbekesh(character, no: int = -1) {
			var STR: String = MESlistChr[character] as String;

			if (no == -1) {
				if (STR != null && STR.length == 1) {
					return STR;
				} else {
					return character;
				}
			}
			var at = -1;
			switch (no) {
				case (1):
					{
						at = 2
						break;
					}
				case (2):
					{
						at = 6
						break;
					}
				case (0):
					{
						at = 0
						break;
					}
				case (3):
					{
						at = 4
						break;
					}
			}
			if (STR != null) {
				at = Math.min(String(STR).length - 1, at);
				var cash = STR.charAt(at);
				if (cash == undefined) {
					cash = STR.charAt(STR.length - 1);
				}
				return (cash)
			} else {
				return character;
			}
		}


		public function getPorp(htm: String, color: Boolean = false, size: Boolean = false, align: Boolean = false, lending: Boolean = false) {
			var cash: String = ''
			if (color) {
				cash = "COLOR=\"";
			} else if (size) {
				cash = "SIZE=\"";
			} else if (align) {
				cash = "ALIGN=\"";
			} else if (lending) {
				cash = "LEADING=\"";
			} else {
				return
			}
			htm = htm.toUpperCase()
			var I = htm.indexOf(cash) + cash.length;
			var htm2 = htm.substring(I)
			var num = (htm2.substring(0, htm2.indexOf('\"')))
			return num
		}



		public function setPorp(htm, variable, color = false, size = false, align = false, lending = false) {
			var cash: String = ''
			var htm2 = ''
			if (color) {
				cash = "COLOR=\"";
			} else if (size) {
				cash = "SIZE=\"";
			} else if (align) {
				cash = "ALIGN=\"";
			} else if (lending) {
				cash = "LEADING=\"";
			} else {
				return
			}
			while (htm.indexOf(cash) != -1) {
				htm2 = htm2 + htm.substring(0, htm.indexOf(cash) + cash.length)
				htm = htm.substring(htm.indexOf(cash) + cash.length)
				htm = htm.substring(htm.indexOf('\"'))
			}

			htm2 = htm2 + htm

			htm = htm2.split(cash + '\"').join(cash + variable + '\"')

			return htm
		}


		public static function htmlCorrect(htm: String, linkColor: int = -1, replacePwithEnter: Boolean = false, fontSizeIs: Number = 20): String {
			var StrongFontSize: Number = fontSizeIs + 5;

			var fontSize_xxSmall: Number = Math.max(1, fontSizeIs - 10);
			var fontSize_xSmall: Number = Math.max(1, fontSizeIs - 5);
			var fontSize_Small: Number = Math.max(1, fontSizeIs - 2)
			var fontSize_Larg: Number = fontSizeIs + 2;
			var fontSize_xLarg: Number = fontSizeIs + 5;
			var fontSize_xxLarg: Number = fontSizeIs + 10;

			var colorOpen: String = '';
			var colorClose: String = '';
			if (linkColor != -1) {
				colorOpen = '<FONT COLOR="#' + linkColor.toString(16) + '">';
				colorClose = '</FONT>';
			}
			var divDeleter: RegExp = /<\/?div[^>]*>/gi;
			var brReplacer: RegExp = /<\/?br[^>]*>/gi;
			var str: String = htm.replace(divDeleter, '');
			str = str.replace(brReplacer, '\n');
			str = str.split('<a').join(colorOpen + '<A')
			var linkCloser: RegExp = /<\/a[^>]*>/gi;
			str = str.replace(linkCloser, '</A>' + colorClose);
			var pTag: RegExp = /<\/?p[^>]*>/gi;
			var pColseTag: RegExp = /<\/p[^>]*>/gi;
			if (replacePwithEnter) {
				str = str.replace(pColseTag, '\n');
			} else {
				str = str.replace(pTag, '');
			}
			var strongReplacer: RegExp = /<strong>/gi;
			str = str.replace(strongReplacer, '<FONT SIZE="' + StrongFontSize + '">');
			var strongReplacerColser: RegExp = /<\/strong>/gi;
			str = str.replace(strongReplacerColser, '</FONT>');
			var spanColorReplacer: RegExp = /<span style="color:#/gi;
			str = str.replace(spanColorReplacer, '<FONT COLOR="#');
			var spanColorReplacer2: RegExp = /;">/gi;
			str = str.replace(spanColorReplacer2, '">');
			var spanColorReplacerCloser: RegExp = /<\/span>/gi;
			str = str.replace(spanColorReplacerCloser, '</FONT>');

			var reg_fontSize: RegExp;
			reg_fontSize = /<span style="font-size:xx-small">/gi;
			str = str.replace(reg_fontSize, '<FONT SIZE="' + fontSize_xxSmall + '">');
			reg_fontSize = /<span style="font-size:x-small">/gi;
			str = str.replace(reg_fontSize, '<FONT SIZE="' + fontSize_xSmall + '">');
			reg_fontSize = /<span style="font-size:small">/gi;
			str = str.replace(reg_fontSize, '<FONT SIZE="' + fontSize_Small + '">');
			reg_fontSize = /<span style="font-size:large">/gi;
			str = str.replace(reg_fontSize, '<FONT SIZE="' + fontSize_Larg + '">');
			reg_fontSize = /<span style="font-size:x-large">/gi;
			str = str.replace(reg_fontSize, '<FONT SIZE="' + fontSize_xLarg + '">');
			reg_fontSize = /<span style="font-size:xx-large">/gi;
			str = str.replace(reg_fontSize, '<FONT SIZE="' + fontSize_xxLarg + '">');

			var reg_left_span_corrector: RegExp = /<span[^>]*>/gi;
			str = str.replace(reg_left_span_corrector, '<FONT>');
			return str;
		}


		public function HTMLUnicode(tex: String) {

			tex = htmlCorrect(tex);
			var tex2: String = '';
			var i: int;
			var AnyTag: RegExp = /<[^>]*>/gi;
			tex = tex;
			var cash: String = tex;
			var tags: Array = [];
			var strings: Array = [];
			var tagsList: Array = tex.match(AnyTag);

			for (i = 0; i < tagsList.length; i++) {
				var tag: String = tagsList[i] as String;
				var tagIndex: int = cash.search(AnyTag);
				var word: String = toRtl(cash.substr(0, tagIndex));
				cash = cash.substring(tagIndex + tag.length);
				strings.push(word);
				if (tag.indexOf('</') != 0) {
					tags.push(tag);
				} else {
					var close: String;
					var open: String;
					if (tags.length == 0) {
						return tex;
					}
					var str: String = '';
					while (strings.length > tags.length) {
						str = str + strings.pop();
					}
					close = tag;
					open = tags.pop();
					strings[strings.length - 1] = open + str + close + strings[strings.length - 1];
				}
			}
			strings.push(toRtl(cash));
			for (i = 0; i < strings.length; i++) {
				tex2 = strings[i] + tex2;
			}

			return tex2
		}

		private function TagName(fullTag: String): String {
			fullTag = fullTag.split('</').join('');
			var firstSpace: int = fullTag.indexOf(' ');
			var firstClose: int = fullTag.indexOf('>');
			if (firstSpace != -1) {
				fullTag = fullTag.substr(0, firstSpace);
			} else {
				fullTag = fullTag.substr(0, firstClose);
			}
			return fullTag;
		}

		public function justHTML(field_txt, tex: String, autoSize_F: Boolean = true) {
			field_txt.text = 's'
			var cashAlign = getPorp(field_txt.htmlText, false, false, true)
			if (autoSize_F) {
				field_txt.autoSize = TextFieldAutoSize.CENTER;
			}
			field_txt.htmlText = tex;
		}

		private function getLastSplit(tex) {
			var mem = 0;
			var cash = 0;
			var batel = false
			for (var i = 0; i < splitters.length; i++) {
				for (var j = 0; j < tex.length - 2; j++) {
					cash = tex.charAt(j)
					if (cash == '<') {
						batel = true
					} else if (cash == '>') {
						batel = false
					}
					if (batel) {
						continue
					}
					if (cash == splitters[i]) {
						mem = Math.max(mem, j)
					}
				}
			}
			return mem
		}


		private function justifyUnicode(field_txt, matn) {
			field_txt.text = '.';
			var lastH = field_txt.textHeight;
			var lastMatn = matn;
			var lastMatn2 = matn;
			var lastI = new Array(matn, 0)
			var contor = 1
			while (field_txt.textHeight <= lastH) {
				contor++
				lastMatn2 = lastMatn
				lastMatn = lastI[0]
				lastI = putJUnicode(lastMatn, lastI[1])
				if (lastI[0] == false) {
					break
				}
				field_txt.htmlText = HTMLUnicode(lastI[0])
				if (contor > 40) {
					break
				}
			}
			return lastMatn2
		}


		private function putJUnicode(matn, I) {
			var batel = false
			var newMatn = matn
			var cash;
			var myI
			var shans: Array = new Array()
			for (var i = 0; i < matn.length; i++) {
				myI = (i + I) % matn.length
				cash = matn.charAt(myI)
				if (cash == '<') {
					batel = true
				} else if (cash == '>') {
					batel = false
				}
				if (batel) {
					continue
				}
				if ((MESfindeType(matn.charAt(myI)) & 2 == 2) && (MESfindeType(matn.charAt(myI + 1)) & 1 == 1) && (matn.charAt(myI + 1) != 'ـ')) {
					shans.push(myI + 1)
				}
			}
			if (shans.length == 0) {
				return new Array(false, false)
			} else {
				var rand = Math.floor(Math.random() * shans.length)
				newMatn = matn.substring(0, shans[rand]) + 'ـ' + matn.substring(shans[rand])
				return new Array(newMatn, 0)
			}
		}




		private function htmlSplit(tex, I) {
			var matn1 = '';
			var matn2 = '';

			matn1 = tex.substring(0, I);
			matn2 = tex.substring(I);

			if (matn2.indexOf('>') == -1) {} else {
				if (matn2.indexOf('<') == -1) {
					matn2 = matn1.substring(matn1.lastIndexOf('<')) + matn2;
					matn1 = matn1.substring(0, matn1.lastIndexOf('<'));
				} else {
					if (matn2.indexOf('<') < matn2.indexOf('>')) {
						if (matn2.indexOf('<') == matn2.indexOf('</FONT')) {
							matn2 = matn1.substring(matn1.lastIndexOf('<'), matn1.lastIndexOf('>') + 1) + matn2;
							matn1 = matn1 + '</FONT>'
						}
					} else {
						if (matn1.lastIndexOf('<') == matn1.lastIndexOf('</') || matn2.indexOf('>') == matn2.indexOf('T>') + 1) {
							matn2 = matn2.substring(matn2.indexOf('>') + 1)
							matn1 = matn1.substring(0, matn1.lastIndexOf('<'));
							matn1 = matn1 + '</FONT>'
						} else {
							matn2 = matn1.substring(matn1.lastIndexOf('<')) + matn2;
							matn1 = matn1.substring(0, matn1.lastIndexOf('<'));
						}
					}
				}
			}
			return new Array(matn1, matn2)
		}
	}
}