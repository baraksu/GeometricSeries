# סדרה הנדסית - פרויקט גמר באסמבלי
### מתכנת: איתן שאול נוימן
### מורה: ברק צוברי
### כיתה: י'2
### בית ספר: ישיבת בני עקיבא גבעת שמואל
### שנת הגשה: 2023 | ה'תשפ"ג

## תוכן עניינים:
1. [מה התוכנית עושה](#מה-התוכנית-עושה)
2. [הפעולות שהמשתמש יכול לבצע](#הפעולות-שהמשתמש-יכול-לבצע)
3. [דוגמאות ריצה](#דוגמאות-ריצה)
4. [שלבי הפיתוח](#שלבי-הפיתוח)
5. [דברים שהייתי מוסיף בעתיד](#דברים-שהייתי-מוסיף-בעתיד)
6. [סיכום אישי](#סיכום-אישי)


## מה התוכנית עושה

מטרת הפרויקט היא להדפיס אייברים של סדרה הנדסית בהתאם לקלטי המשתמש ובנוסף להדפיס טבלה שמכילה מתחת לכל איבר בסדרה טור אנכי של חיצי משולשים שאורכו כערך האיבר המתאים שמעליו.
> הערה: במתמטיקה, סדרה הנדסית או סדרה גאומטרית היא סדרה של מספרים, כך שהיחס בין כל שני איברים סמוכים הוא קבוע. 
> במילים אחרות, ניתן לחשב כל איבר בסדרה על ידי הכפלת האיבר הקודם לו במספר קבוע (מנת הסדרה).
> נוסחה לאיבר כללי בסדרה הנדסית:
>
>  ![image](https://github.com/baraksu/GeometricSeries/assets/126795369/89bb8413-6fad-4403-99e1-c3a708c811f1)
> 




## הפעולות שהמשתמש יכול לבצע

המשתמש מתבקש להזין 3 קלטים:
1. איבר ראשון בסדרה (a1)
2. מנת הסדרה (q)
3. כמות האיברים (n)
4. 
## דוגמאות ריצה
### דוגמה 1:
נתבונן בדוגמת ריצה עבור הקלטים הבאים:

```
a1 = 1, q = 2, n = 4
```

![image](https://github.com/baraksu/GeometricSeries/assets/126795369/7774ce69-9592-4804-8441-90acbefac4f3)

בשלב הבא מודפסים כל איברי הסדרה ההנדסית בהתאם לנתוני המשתמש:

![image](https://github.com/baraksu/GeometricSeries/assets/126795369/a2227edb-cca9-4be1-88ed-7cc0f39de251)

ולבסוף תודפס הטבלה המתאימה:

![image](https://github.com/baraksu/GeometricSeries/assets/126795369/ce0ac666-b12f-426d-84f6-543e6e4a1036)

כך שמתקבל לסיכום הפלט הבא:

![image](https://github.com/baraksu/GeometricSeries/assets/126795369/b18fa3af-1953-49c1-ac8e-4b314b904e60)

### דוגמה 2:
דוגמת ריצה נוספת תתקבל עבור הקלטים הבאים:
```
a1 = 2, q = 3, n = 3
```

![image](https://github.com/baraksu/GeometricSeries/assets/126795369/8ff2585f-85f7-4c1f-9170-c58abe9015b0)

## שלבי הפיתוח


1. בשלב הראשון חשבתי לעומק על כל הפרויקט, על איך לגשת אליו ולתכנן את סדר העבודה
2. בשלב השני קלטתי מהמשתמש את כל הנתונים שאני צריך בשביל לבצע את התוכנית (a1, q, n)
3. בשלב השלישי יצרתי את הפונקציות להפדסת רווח, אנטר וסימן המשולש בשביל לקצר את הקוד ולא להעמיס עליו
4. בשלב הרביעי הדפסתי למסך את האיבר הראשון, ואז יצרתי לולאה שמכפילה כל פעם את האיבר במנת הסדרה ואז מדפיסה את האיבר החדש, ככה הלולאה רצה n פעמים, ככמות האיברים, עד שכל הסדרה מודפסת למסך
5. בשלב החמישי הוספתי אפשרויות למקרי קצה, למשל כאשר מכניסים ל-n 0 או 1 שזה עלול להקריס את התוכנית העיקרית, וכו'
6. בשלב השישי חשבתי רבות על איך להדפיס את הטבלה. בניתי אלגוריתם שמדפיס את הטבלה באמצעות מימוש לולאה תלת מימדית, תוך שימוש בפקודות cmp, jmp, אשר קוראת לפונקציות שהגדרתי לפני כן
שלבי האלגוריתם:
* תחילה הדפסתי a1 שורות של n חיצים.
* אתחלתי 2 משתנים: x ו-y
```
x = a1, y = a1 * q = a2
```
* לאחר מכן בניתי את הלולאה התלת המימדית כאשר הלולאה החיצונית רצה n-1 פעמים באמצעות משתנה j שרץ בין הערכים n-1 ל-1 (כולל)
  הלולאה האמצעית רצה y-x פעמים
  הלולאה הפנימית מחולקת ל-2 חלקים: הדפסת רווחים n-j פעמים ולאחר מכן הדפסת החיצים j פעמים לכל שורה
* לפני כל איטרציה חדשה של הלולאה החיצונית, הכפלתי את x ו-y ב-q כך שיתעדכנו לאיברים הבאים 
7. בשלב השביעי תירגמתי את האלגוריתם שכתבתי לאסמבלי

## דברים שהייתי מוסיף בעתיד

הייתי רוצה שהתוכנית תוכל לתמוך גם אם איברי הסדרה גדולים מאוד. נתקלתי בקושי לממש זאת מאחר וגרסת האסמבלי שאנו משתמשים בה לא תומכת בהדפסת כמות גדולה כל כך של קווים ורצה לאט מאוד.
בנוסף הייתי תומך בהכנסת איבר ראשון או מנה שלילית כך שכמות החיצים בכל טור ייצגו את הערך המוחלט של כל איבר במידה והוא שלילי.

## סיכום אישי

היה לי מאתגר לממש את התוכנית בשפת אסמבלי על אף שהיה לי תכנון מה לעשות מאחר ושפה זו דורשת דיוקים רבים וקשה לדבג אותה באופן יעיל ולאתר מקורות של תקלות בקוד.
אך החלק הכי מאתגר במימוש התוכנית הייתה בניית האלגוריתם שידפיס את הטבלה המתאימה לסדרה.
למרות הקשיים נהניתי מאוד מהחשיבה והלימוד שליוו אותי במהלך בניית הפרויקט ובפרט התמלאתי סיפוק כאשר התוכנית עבדה בסוף כמו שהתבקשתי לבצע גם עם מקרי הקצה השונים.
נוסף על כן, שמחתי על ההזדמנות שניתנה לי להכיר את הגיטהאב וללמוד להשתמש ולעבוד איתו באופן עצמאי. 











