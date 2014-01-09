

function verify_delete()
{
    if (document.getElementById('verify_delete').style.display == 'inline')
        document.getElementById('verify_delete').style.display = 'none';
    else
        document.getElementById('verify_delete').style.display = 'inline';
}

function displayComments(myDiv) {
    var comments_div = document.getElementById(myDiv);

    var abs = document.getElementById("smallbutton_"+myDiv);
    if (comments_div.style.display == 'inline') {
        comments_div.style.display = 'none';
        abs.value = "Show Comments";
        
    } else {
        comments_div.style.display = 'inline';
        abs.value = "Hide Comments";
    }
}