xquery version "3.1";

<html>
    <head>
        <title>Dr. Seuss XQuery</title>
    </head>
    <body>
        <h1>Book Info</h1>
        
        {
            let $char := $book//char
            let $charDv := $book//char =>distinct-values()
            let $charCount := $book//char =>count()
            let $charDvCount := $book//char =>distinct-values() =>count()
            
            let $sound := $book//sound
            let $soundDv := $book//sound =>distinct-values()
            let $soundCount := $book//sound =>count()
            let $soundDvCount := $book//sound =>distinct-values() =>count()
            
            let $figOfSp := $book//figOfSp
            let $figOfSpDv := $book//figOfSp =>distinct-values()
            let $figOfSpCount := $book//figOfSp =>count()
            let $figOfSpDvCount := $book//figOfSp =>distinct-values() =>count()
            
            let $rym := $book//rym
            let $rymDv := $book//rym =>distinct-values()
            let $rymCount := $book//rym =>count()
            let $rymDvCount := $book//rym =>distinct-values() =>count()
            
            let $sch := $book//sch
            let $schDv := $book//sch =>distinct-values()
            let $schCount := $book//sch =>count()
            let $schDvCount := $book//sch =>distinct-values() =>count()
            
            let $mUp := $book//mUp
            let $mUpDv := $book//mUp =>distinct-values()
            let $mUpCount := $book//mUp =>count()
            let $mUpDvCount := $book//mUp =>distinct-values() =>count()
            
            return
            
            <div>
                <ul>
                <li>{$char}</li>
                <li>{$charDv}</li>
                <li>{$charCount}</li>
                <li>{$charDvCount}</li>
            </ul>
            <ul>
                <li>{$sounds}</li>
                <li>{$soundsDv}</li>
                <li>{$soundsCount}</li>
                <li>{$soundsDvCount}</li>
            </ul>
            <ul>
                <li>{$figOfSp}</li>
                <li>{$figOfSpDv}</li>
                <li>{$figOfSpCount}</li>
                <li>{$figOfSpDvCount}</li>
            </ul>
            <ul>
                <li>{$rym}</li>
                <li>{$rymDv}</li>
                <li>{$rymCount}</li>
                <li>{$rymDvCount}</li>
            </ul>
            <ul>
                <li>{$sch}</li>
                <li>{$schDv}</li>
                <li>{$schCount}</li>
                <li>{$schDvCount}</li>
            </ul>
            <ul>
                <li>{$mUp}</li>
                <li>{$mUpDv}</li>
                <li>{$mUpCount}</li>
                <li>{$mUpDvCount}</li>
            </ul>
            </div>
        }
    </body>
</html>