window.addEventListener("beforeunload", function () {
    Object.keys(UserAccounts).forEach(ent => {
        // Check if the user has an image
        if (UserAccounts[ent].Img !== undefined) {
            const GTI = UserAccounts[ent].rem;
            const IMG2 = document.getElementById(`IMG_${GTI}9io_gmi`);
        }
        else {
            UserAccounts[ ent ].Img = 'undefined';
        }
    });
    localStorage.setItem('UserAccounts', JSON.stringify(UserAccounts));
    localStorage.setItem('GETSERCH', JSON.stringify(ForSerCh));
    localStorage.setItem('GETConversation', JSON.stringify(Conversations));
    localStorage.setItem('GETCOverCount', JSON.stringify(ConverCount));
    localStorage.setItem('GETREVERSEACC', JSON.stringify(ReverseAccounts));
    localStorage.setItem('GETCONverAudio', JSON.stringify(ConvAudio));
    localStorage.setItem('ACCTEXTES', JSON.stringify(Account_textes));

});
