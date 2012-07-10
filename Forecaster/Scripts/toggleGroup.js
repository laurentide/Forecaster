function toggleGroup(img) {
    //  get a reference to the row and table
    var tr = img.parentNode.parentNode;
    var table = $get('segments');
    var src = img.src;

    //  do some simple math to determine how many
    //  rows we need to hide/show
    var startIndex = tr.rowIndex + 1;
    //var stopIndex = startIndex + parseInt(numberOfRows);

    //  if the img src ends with plus, then we are expanding the
    //  rows.  go ahead and remove the hidden class from the rows
    //  and update the image src
    if (src.endsWith('plus.png')) {
        for (var i = startIndex;i<100; i++) {
            if (Sys.UI.DomElement.containsCssClass(table.rows[i], 'hidden')) {
                Sys.UI.DomElement.removeCssClass(table.rows[i], 'hidden');
            }
            else {
                break;
            }
        }

        src = src.replace('plus.png', 'minus.png');
    }
    else {
        for (var i = startIndex; i < 100; i++) {
            Sys.UI.DomElement.addCssClass(table.rows[i], 'hidden');
        }

        src = src.replace('minus.png', 'plus.png');
    }

    //  update the src with the new value
    img.src = src;
}
    