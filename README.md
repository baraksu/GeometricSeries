# סדרה הנדסית - פרויקט גמר באסמבלי
### מתכנת: איתן שאול נוימן
### מורה: ברק צוברי
### כיתה: י'2
### בית ספר: ישיבת בני עקיבא גבעת שמואל
### שנת הגשה: 2023 | ה'תשפ"ג

## תוכן עניינים:
1. [מה התוכנית עושה](#מה-התוכנית-עושה)
2. [הפעולות שהמשתמש יכול לבצע](#הפעולות-שהמשתמש-יכול-לבצע)

## מה התוכנית עושה

מטרת הפרויקט היא להדפיס אייברים של סדרה הנדסית בהתאם לקלטי המשתמש ובנוסף להדפיס טבלה שמכילה מתחת לכל איבר בסדרה טור אנכי של חיצי משולשים שאורכו כערך האיבר המתאים שמעליו.
> הערה: במתמטיקה, סדרה הנדסית או סדרה גאומטרית היא סדרה של מספרים, כך שהיחס בין כל שני איברים סמוכים הוא קבוע. 
> במילים אחרות, ניתן לחשב כל איבר בסדרה על ידי הכפלת האיבר הקודם לו במספר קבוע (מנת הסדרה).
> נוסחה לאיבר כללי בסדרה הנדסית:
> ![image](https://github.com/baraksu/GeometricSeries/assets/126795369/89bb8413-6fad-4403-99e1-c3a708c811f1)




## הפעולות שהמשתמש יכול לבצע

המשתמש מתבקש להזין 3 קלטים:
1. איבר ראשון בסדרה (a1)
2. מנת הסדרה (q)
3. כמות האיברים (n)
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


```
        lea dx, msg1          ; print message 'Please insert the first term (a1): '
        mov ah, 09h
        int 21h
        
        mov ah, 01h           ; get a1 as input
        int 21h
        mov a1, al            
        
        lea dx, msg2          ; print message 'Please insert the quotient (q): '
        mov ah, 09h
        int 21h
        
        mov ah, 01h           ; get q as input
        int 21h               
        mov q, al            
        
        lea dx, msg3          ; print message 'Please insert the amount of terms (n): '
        mov ah, 09h
        int 21h
        
        mov ah, 01h           ; get n as input
        int 21h
        mov n, al
```









