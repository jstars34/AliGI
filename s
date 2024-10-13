document.addEventListener('DOMContentLoaded', () => {
    const ntf99 = sessionStorage.getItem("UDS");
    const ntf99IMG = sessionStorage.getItem("thisImg");
    if (!ntf99) {
        document.location.href = 'doc.html';
        return;
    }
    if (UserDisplayInformation.PageStyle.GreenBLue) { 
        document.getElementById("PageNature").href = './style/n.css';
    }
    
    const INFODISPLAY = {
        Name: ntf99,
        Img:ntf99IMG
    }
    const FNAME = []

    const CuruntClick = [];
    let IsAnswering = false;
    function generateUniqueId() {
        // Generate a random UUID
        return Math.random().toString(36).substr(2, 9);
    }
    function DLE_Buttons() {
        const GET_DELETE_Button = document.querySelectorAll('#FM_DELETE');
        const GET_EDIT_Button = document.querySelectorAll('#FM_EDIT');
        const dis = document.getElementById("UserAreaMessageControl");
        GET_EDIT_Button.forEach(EDT => {
            EDT.addEventListener("click", function (e) {
                const NST = EDT.getAttribute("JSK");
                if (UserDisplayInformation.PageSystem.CHANGE.ISEDITING == true) {
                    const a = document.getElementById("DisplayTheEdit");
                    document.getElementById('ButtonSXRemove').click();
                    a.remove();
                };
                const DDS = EDT.getAttribute("CONT").trim();
                const Ntext = document.getElementById(NST);
                const NTextDIS = Ntext.textContent.endsWith("Edited") ? Ntext.textContent.slice(0,-6):Ntext.textContent ;
                UserDisplayInformation.PageSystem.CHANGE.ISEDITING = true;
                UserDisplayInformation.PageSystem.CHANGE.THEVALUE = `${NST}-M${DDS}`;
                const s90Input = document.getElementById("messageInput")
                document.getElementById(`0${NST}`).style = `animation: stu 1000ms linear infinite;`;
                s90Input.value = NTextDIS;
                const divEDTDIs = document.createElement("div");
                divEDTDIs.classList.add("Conts00");
                divEDTDIs.id = "DisplayTheEdit";
                const Nturn = document.createElement("edit-user");
                Nturn.classList.add("ForWho");
                Nturn.textContent = 'You';
                const TextEditP = document.createElement("text");
                TextEditP.classList.add("nms");
                const ButtonSX = document.createElement("button");
                ButtonSX.id = 'ButtonSXRemove';
                ButtonSX.classList.add("BTNS")
                ButtonSX.textContent = '✕';
                ButtonSX.title = 'close Editing'
                TextEditP.textContent = NTextDIS;
                dis.prepend(divEDTDIs)
                addHtml(divEDTDIs,Nturn)
                addHtml(divEDTDIs,TextEditP)
                addHtml(divEDTDIs, ButtonSX)
                ButtonSX.addEventListener("click", function () {
                    UserDisplayInformation.PageSystem.CHANGE.ISEDITING = false;
                    try {
                        document.getElementById(`0${NST}`).style = ``;
                    } catch (error) {
                        console.warn("Deleted message Can't Be changed")
                    }
                    RHtml(dis,divEDTDIs)
                    messageInput.value = '';
                    return;
                
                })
            })
        });
        GET_DELETE_Button.forEach(DEL => {
            DEL.addEventListener("click", function (e) {
                const NST = DEL.getAttribute("JSK");
                const Ntext = document.getElementById(NST);
                const MN = document.getElementById(`0${NST}`);
                const BN = DEL.getAttribute("CONT").trim();
                try {
                    if (UserDisplayInformation.PageSystem.DEleteWithPermisioin == true) {
                        const p = confirm("Do you want to delte this Message");
                        if (p) {
                            if (p == true) {
                                if (Conversations[ CuruntClick ][ `M${BN}` ].ISAUDIO == true) {
                                    let inds = ConvAudio[ CuruntClick ].N_AUD.indexOf(NST);
                                    ConvAudio[ CuruntClick ].N_AUD.splice(inds, 1);
                                }
                                delete Conversations[ CuruntClick ][ `M${BN}` ];
                                MN.remove();
                            }
                        }
                    }
                    else {
                        if (Conversations[ CuruntClick ][ `M${BN}` ].ISAUDIO == true) {
                            let inds = ConvAudio[ CuruntClick ].N_AUD.indexOf(NST);
                            ConvAudio[ CuruntClick ].N_AUD.splice(inds, 1);
                        }
                        delete Conversations[ CuruntClick ][ `M${BN}` ];
                        MN.remove();
                    }
                    
                    
                } catch (error) {
                    
                }
                const messageId = e.target.dataset.messageId; // Get message ID
            })
        });
    }
    function checkAndAddSpaces(text, maxLength) {
        let result = '';
        let currentPosition = 0;
    
        while (currentPosition < text.length) {
            // Get the next chunk, ensuring we don't break a word
            let nextChunk = text.substring(currentPosition, currentPosition + maxLength);
    
            // Check for spaces before maxLength
            let spaceIndex = nextChunk.lastIndexOf(' ');
    
            if (spaceIndex === -1 && nextChunk.length === maxLength) {
                // No space in the chunk and it reaches maxLength, so check for the next space in the text
                let fullTextRemaining = text.substring(currentPosition);
                let nextSpaceAfterChunk = fullTextRemaining.indexOf(' ');
    
                if (nextSpaceAfterChunk === -1 || nextSpaceAfterChunk > maxLength) {
                    // If no space exists or the next space is beyond maxLength, force a break after maxLength
                    result += nextChunk + ' ';
                    currentPosition += maxLength;
                } else {
                    // If a space is nearby, move up to that space
                    result += fullTextRemaining.substring(0, nextSpaceAfterChunk + 1);
                    currentPosition += nextSpaceAfterChunk + 1;
                }
            } else if (spaceIndex !== -1) {
                // There's a space within the chunk, respect that and move on
                result += nextChunk.substring(0, spaceIndex + 1);
                currentPosition += spaceIndex + 1;
            } else {
                // This is the last part of the text (less than maxLength characters)
                result += nextChunk;
                currentPosition += nextChunk.length;
            }
        }
    
        return result.trim(); // Remove any trailing spaces
    }
    function T_animation(nots, divs, bool, nme, inht) {
        IsAnswering = true;
        const nots1 = checkAndAddSpaces(nots, 20)
        if (UserDisplayInformation.AnimationSystem.PointerAnimaiton == false) {
            divs.textContent = nots1;
            messageDisplay.scrollTop = messageDisplay.scrollHeight;
            try {
                ConverCount[ nme ].ML++;
                Conversations[ nme ][ `M${ConverCount[ nme ].ML}` ] = { EDITED: false, ISAUDIO: false, VALUE: divs.textContent, FOR: "RobotMessage", ids1: '' }
                IsAnswering = false;
            } catch (error) {
                IsAnswering = false;
            }
            return;
        }
        else {
            if (nots1.length > 500) {
                const n990 = Math.floor((nots1.length > 90 ? (nots1.length > 150 ? 1 : nots1.length / 3) : (nots1.length * 90 < 100 ? 100 : 20)));
                const N_words = nots1.split(' ');
                let DisplayTexts = '';
                const CURS2 = document.createElement('span');
                CURS2.classList.add("cursor");
                
                let i = 0;
                const TST = setInterval(() => {
                    if (i < N_words.length) {
                        if (DisplayTexts.length > 0) {
                            DisplayTexts += ' ';
                        }
                        DisplayTexts += N_words[ i ];
                        divs.textContent = DisplayTexts;
                        i++;
                        addHtml(divs, CURS2);
                        messageDisplay.scrollTop = messageDisplay.scrollHeight;
                    }
                    else {
                        RHtml(divs, CURS2);
                        IsAnswering = false;
                        ConverCount[ nme ].ML++;
                        Conversations[ nme ][ `M${ConverCount[ nme ].ML}` ] = { EDITED: false, ISAUDIO: false, VALUE: divs.textContent, FOR: "RobotMessage", ids1: '' }
                        clearInterval(TST)
                    }
                }, n990);
                return;
            }
            let index = 0;
            let disk = '';
            let wonderfull = 1000;
            const cursor = document.createElement("span-1");
            switch (true) {
                case bool == false:
                    cursor.classList.add("cursor_t")
                    break;
                default:
                    cursor.classList.add('cursor')

                    break;
            }
            const audiomp3 = document.getElementById("wavsesnav");
            IsAnswering = true;
            const n90 = Math.floor((nots1.length > 90 ? (nots1.length > 150 ? 1 : nots1.length / 3) : (nots1.length * 90 < 100 ? 100 : 20)));
            const interval = setInterval(function () {
                (wonderfull > 0 ? wonderfull -= 70 : wonderfull)
                if (index < nots1.length) {
                    if (wonderfull >= 0) {
                        if (nots1[ index ] !== ' ') {
                            try {
                                audiomp3.play();
                            } catch (error) {
                                console.log('error')
                            }
                        }
                    }
                    divs.innerHTML += nots1[ index ];
                    disk += nots1[ index ];
                    divs.textContent = disk;
                    addHtml(divs, cursor);
                    index++;
                    messageDisplay.scrollTop = messageDisplay.scrollHeight;
                    if (bool == true) {
                    }
                }
                else {
                    RHtml(divs, cursor)
                    try {
                        // Conversations[  ].push(inht.innerHTML);
                        ConverCount[ nme ].ML++;
                        Conversations[ nme ][ `M${ConverCount[ nme ].ML}` ] = { EDITED: false, ISAUDIO: true, VALUE: divs.textContent, FOR: "RobotMessage", ids1: '' }
                    } catch (error) {
                    }
                    clearInterval(interval);
                    IsAnswering = false;
                    audiomp3.play();
                }
                // audiomp3.stop();
            }, n90)
        }
    }
        
    function generatoColor() {
        return '#' + Math.floor(Math.random() * 16777215).toString(16);
    }
    const container = document.getElementById('ContainerForChatApp');
    container.textContent = '';
    let x = 0;
    const Convers_StepShow = false;
    // Function to add an HTML element
    function addHtml(parent, element) {
        parent.appendChild(element);
        return element;
    }
    function RHtml(parent, element) {
        try {
            parent.removeChild(element);
            return element;
        } catch (error) {
            console.info('removed')
        }
    }
    // Section 1 - User section
    const section1 = document.createElement('div');
    section1.id = 'Sections_1';
    section1.classList.add("divVisible")
    const an89 = document.createElement("audio");
    an89.id = 'wavsesnav'
    const an9s = document.createElement("audio");
    an9s.id = 'suv';
    an89.spellcheck = true;
    an9s.src = '/chatGpt/gs.ogg'
    addHtml(container, an9s)
    an89.src = '/chatGpt/pleasant_keyboard_click_sound_50ms.wav'
    addHtml(container, section1);
    const ThreeDot = document.createElement("control-center");//add 
    const But = document.createElement("button");
    But.textContent = '∭';
    But.classList.add("sorgum")
    ThreeDot.classList.add("hidden");
    const insideDivThree = document.createElement("display-only");
    insideDivThree.classList.add("maxwell");
    insideDivThree.hidden = true;
    const mainDviThree = document.createElement("main-contraner");
    mainDviThree.classList.add("maminDivh")
    addHtml(section1, ThreeDot);
    addHtml(ThreeDot, But);
    addHtml(ThreeDot, insideDivThree);
    addHtml(insideDivThree, mainDviThree);
    let ntu = 0;
    But.addEventListener("click", function () {
        ntu++;
        console.log(ntu)
        if (ntu == 1) {
            ThreeDot.classList.remove("hidden");
            ThreeDot.classList.add("three_dot");
            insideDivThree.hidden = false;
            console.log('display it')
        }
        else if(ntu > 1){
            ntu = 0;
            console.log('undisplay it')
            insideDivThree.hidden = true;
            ThreeDot.classList.remove("three_dot");
            ThreeDot.classList.add("hidden");

        }
    })
    const ConDiv = document.createElement("NTu-u");
    ConDiv.classList.add("condiv");
    addHtml(mainDviThree, ConDiv);
    const P1Display = document.createElement("User_info");
    P1Display.classList.add('p1display')
    const P1main = document.createElement("div-user");
    P1main.classList.add('p1min')
    const p1img = document.createElement("span");
    p1img.classList.add('c')
    let so0 = JSON.parse(ntf99);
    p1img.innerHTML = ntf99IMG ? `<img src=${ntf99IMG}>` :so0.slice(0,1);
    const p1text = document.createElement("text");
    p1text.classList.add('nt99')
    p1text.innerText = so0;
    addHtml(ConDiv, P1Display)
    addHtml(P1Display, P1main)
    addHtml(P1main, p1img)
    addHtml(P1main, p1text);
    const SETDIV = document.createElement("other-part");
    SETDIV.classList.add("otehrpart");
    const SlectOne = document.createElement("span-2");
    SlectOne.classList.add("WFSD");
    SlectOne.textContent = 'Select Accounts';
    //

    addHtml(mainDviThree,SETDIV)
    addHtml(SETDIV, SlectOne)
    const DEleteAccount = document.createElement("span-2");
    DEleteAccount.classList.add('WFSD'); 
    DEleteAccount.textContent = 'Delete This Account';
    DEleteAccount.style = 'color:rgba(185, 38, 0); font-weight:bloder'
    addHtml(SETDIV, DEleteAccount)
    DEleteAccount.addEventListener("click", function () {
        if (confirm("Are you sure you want to delte this account")) {
            sessionStorage.clear();
            document.location.reload();
        }
        else {
            document.location.reload();
        }
    })
    SlectOne.addEventListener("click", function () {
        But.click();
        searchButton.click();
    })
    //
    addHtml(container, an89)
    const userDiv = document.createElement('div');
    userDiv.classList.add('User');
    addHtml(section1, userDiv);
    const DelteChange = document.createElement("div");
    DelteChange.style.display = 'none';
    const FindDiv = document.createElement("div");
    FindDiv.classList.add("User")
    const searchInput = document.createElement('input');
    searchInput.id = 'SearchForAccounts';
    searchInput.placeholder = 'Search...';
    searchInput.type = 'search';
    DelteChange.classList.add("Select_control")
    addHtml(userDiv, FindDiv);
    const CancelSelected = document.createElement("button");
    CancelSelected.classList.add("c01")
    CancelSelected.style = `
border-radius:5px;
margin-right:20px;
    padding: 10px 12px; background - color: rgb(31, 206, 31);`
    const DeleteSelected = document.createElement("button");
    DeleteSelected.textContent = 'Delete'
    CancelSelected.textContent = 'Cancel'
    DeleteSelected.style = `background-color: rgba(224, 57, 57, 0.79);
padding: 10px 12px;
margin:auto;
border-radius:5px;
margin-left: 20px;`
    DeleteSelected.classList.add("d01")

    addHtml(userDiv, DelteChange);
    addHtml(DelteChange, CancelSelected);
    addHtml(DelteChange, DeleteSelected);
    addHtml(FindDiv, searchInput);

    const searchButton = document.createElement('button');
    searchButton.textContent = 'Selct';
    searchButton.classList.add("n99")
    const adubutton = document.createElement('button');
    adubutton.textContent = '+';
    adubutton.classList.add("TCButtonCont09");
    adubutton.classList.add("ioni9");
    adubutton.style = 'background: blue; color: white; font-weight:bolder; font-size: larger;border-radius:100%; height:50px;width:50px;'
    addHtml(FindDiv, searchButton);
    addHtml(FindDiv, adubutton);
    searchButton.addEventListener("click", function () {
        if (FNAME == '') return console.log('empty');
        UserDisplayInformation.PageSystem.IsSelcting = true;
        FindDiv.style.display = 'none';
        DelteChange.style.display = '';
        const checkboxes = document.querySelectorAll('.checkbox');
        checkboxes.forEach(checkbox => {
            checkbox.style.display = 'block';
            checkbox.classList.add("IFHE");
            // checkbox.addEventListener("fullscreenerror")
            checkbox.addEventListener("change", function () {
                switch (true) {
                    case checkbox.checked:
                        document.getElementById(`##${checkbox.value}`).style.backgroundColor = 'rgba(190, 25, 0, 0.772)'
                        break;
                
                    default:
                        document.getElementById(`##${checkbox.value}`).style.backgroundColor = ''
                        break;
                }
                const selectedCount = document.querySelectorAll(".checkbox:checked").length;
                if (selectedCount === 0) {
                    DeleteSelected.textContent = `Delete`;
                }
                if (selectedCount === 1) {
                    DeleteSelected.textContent = `Delete "1"`;
                }
                else {
                    DeleteSelected.textContent = `Delete "${selectedCount}"`;

                }
            
            })
            // Show all checkboxes
        });
    })
    CancelSelected.addEventListener("click", function () {
        UserDisplayInformation.PageSystem.IsSelcting = false;
        DelteChange.style.display = 'none';
        FindDiv.style.display = '';
        DeleteSelected.textContent = `Delete`;
        const checkboxes = document.querySelectorAll('.checkbox');
        checkboxes.forEach(checkbox => {
            checkbox.style.display = 'none';// Hide all checkboxes
            checkbox.checked = false;
            document.getElementById(`##${checkbox.value}`).style.backgroundColor = ''
            // Uncheck any checked boxes
        });
    })
    DeleteSelected.addEventListener("click", function () {
        UserDisplayInformation.PageSystem.IsSelcting = false;
        const checkboxes = document.querySelectorAll('.checkbox');
        checkboxes.forEach(checkbox => {
            DeleteSelected.textContent = `Delete`;
            if (checkbox.checked) {
                checkbox.parentElement.remove();
                const n22 = checkbox.value;
                const n33nest = checkbox.getAttribute("getme");
                const ins = FNAME.indexOf(n22);
                console.log(ins)
                if (ins > -1) {
                    FNAME.splice(ins, 1);
                    const Org = ReverseAccounts[ n33nest ].nest;
                    console.warn(Org);
                    delete UserAccounts[ Org ];
                    delete Conversations[ Org ];
                    delete Account_textes[ `@${Org}` ];
                    delete ConvAudio[Org]
                    delete ConverCount[Org]
                    delete ForSerCh[ Org ];
                    // messageDisplay.innerHTML = '';
                    if (accountS.innerHTML.trim() == '') { addHtml(accountS, main01) }
                }
            }
        });
        CancelSelected.click()
    })
    const accountS = document.createElement("div")
    accountS.classList.add("ACCAll");
    accountS.id = 'accountS'
    const main01 = document.createElement("div");
    main01.classList.add("Failed");
    const main02 = document.createElement("div");
    main02.classList.add("Dis_IMo");
    main02.textContent = '🪹';
    const main03 = document.createElement("text");
    main03.classList.add("Dis_text")
    main03.textContent = `There is no Accounts Yet!`
    const SerAccount = document.createElement("div");
    SerAccount.classList.add("t");
    SerAccount.hidden = true;

    // const accountDiv = document.createElement('div');
    // accountDiv.classList.add('oneAccount');
    addHtml(section1, accountS)
    addHtml(accountS, main01)
    addHtml(main01, main02)
    addHtml(main01, main03)
    addHtml(section1, SerAccount)
    // addHtml(accountS, accountDiv);

    // const accountSpan = document.createElement('span');
    // accountSpan.textContent = 'A';
    // addHtml(accountDiv, accountSpan);

    // const accountText = document.createElement('div');
    // accountText.classList.add('text');
    // accountText.textContent = 'Account Name';
    // addHtml(accountDiv, accountText);

    // Section 2 - Chat section
    const section2 = document.createElement('div');
    section2.id = 'Section_Commitment';
    section2.classList.add("div_visible")
    const section2_1 = document.createElement("div");
    section2_1.classList.add("firsts2")


    const section2_2 = document.createElement("div");
    section2_2.classList.add("firsts1")


    const messageDisplay = document.createElement('div');
    messageDisplay.addEventListener("scroll", function () {
        // IsAnswering = false;
    })
    //1,2,3,4:5,span,text
    const s2upper = document.createElement('div');//to of all upper
    s2upper.classList.add("TopCorner");
    const s2uppers = document.createElement('div');//second of all upper
    s2uppers.classList.add("TCcontener");
    s2uppers.id = 'TCcon';
    const s2upperb = document.createElement('div');//first back button upper
    s2upperb.classList = ("TCButtonCont TCButtonCont09");
            
    const s2upperback = document.createElement('div');//first back button place upper
    s2upperback.classList.add("TCButton");
    s2upperback.textContent = '↩';
    const s2uppert = document.createElement('div');// upper text img place
    s2uppert.classList.add("TcImgTextCont");

    const s2upperimg = document.createElement('span');//upper img place
    s2upperimg.classList.add("TCImgCont")
    s2upperimg.id = 'curucntclickImg';

    const s2uppertext = document.createElement('text');//upper tex place
    s2uppertext.classList.add("TCTexCont");
    s2uppertext.id = 'curucntclickID';

    addHtml(container, section2);
    addHtml(section2, section2_1);
    addHtml(section2, section2_2);
    addHtml(section2_1, s2upper)
    addHtml(s2upper, s2uppers);
    addHtml(s2uppers, s2upperb);
    addHtml(s2upperb, s2upperback);
    addHtml(s2uppers, s2uppert);
    addHtml(s2uppert, s2upperimg);
    addHtml(s2uppert, s2uppertext);
     

    const t = document.createElement("div");
    const m1 = document.createElement("div");
    m1.style = `   position: absolute;
   top: 0;
   bottom: 0;
   left: 0;
   right: 0;`
    m1.classList.add("Failed");
    const m2 = document.createElement("div");
    m2.classList.add("Dis_IMo");
    m2.textContent = '🗨️';
    const m3 = document.createElement("text");
    m3.classList.add("Dis_text")
    m3.textContent = `There is no chat Selected!`
    // t.textContent = "Select Account To Communicate With Him";
    addHtml(section2, t)
    addHtml(t, m1)
    addHtml(m1, m2)
    addHtml(m1, m3)
    // Section 3 - Settings section
    const section3 = document.createElement('div');
    section3.id = 'Section_Setting';
    section3.classList.add("div_visible")

    addHtml(container, section3);
    adubutton.addEventListener("click", function () {
        s1tos3()
    })
    function s1tos2() {
        //divVisible
        //div_visible
        section1.classList = '';
        section2.classList = '';
        section3.classList = '';
        section3.classList.add("div_visible")
        section1.classList.add("div_visible")
        section2.classList.add("divVisible")

    }
    function s1tos3() {
        section1.classList = '';
        section3.classList = '';
        section2.classList = '';
        section1.classList.add("div_visible")
        section2.classList.add("div_visible")
        section3.classList.add("divVisible")
    }
    function s3tos1() {
        section1.classList = '';
        section3.classList = '';
        section2.classList = '';
        section1.classList.add("divVisible");
        section3.classList.add("div_visible");
        section2.classList.add("div_visible");
    }
    function s2tos1() {
        UserDisplayInformation.PageSystem.CHANGE.ISEDITING = false
        section1.classList = '';
        section2.classList = '';
        section3.classList = '';
        section1.classList.add("divVisible");
        section2.classList.add("div_visible");
        section3.classList.add("div_visible");
        section2_2.innerHTML = '';
        s2upperimg.innerHTML = '';
        s2uppertext.textContent = '';
        addHtml(section2, t)
        // addHtml()
        CuruntClick.pop();
    }
    const settingsButtonDiv = document.createElement('div');
    settingsButtonDiv.classList.add('Section_s_button');
    addHtml(section3, settingsButtonDiv);
    const backbutton = document.createElement("button");
    backbutton.classList.add("TCButtonCont09");
    backbutton.textContent = '↩'
    backbutton.addEventListener("click", function () {
        s3tos1();
    })
    const addUserButton = document.createElement('button');
    addUserButton.classList.add('AddUser');
    addUserButton.textContent = 'Add User';
    
    const settingButton = document.createElement('button');
    settingButton.addEventListener("click",
        function () {
            settingButton.click();
        })
    settingButton.classList.add('Setting');
    settingButton.textContent = 'Settings';
    addHtml(settingsButtonDiv, backbutton)
    addHtml(settingsButtonDiv, addUserButton);

    addHtml(settingsButtonDiv, settingButton);
    const SecondSecting = document.createElement("div");
    SecondSecting.id = "SEcondSection3";
    addHtml(section3, SecondSecting)
    addUserButton.addEventListener("click", function () {
        if (!ntf99) document.location.href = 'doc.html';
        const variable1 = document.getElementById("SEcondSection3");
        variable1.innerHTML = '';
        const changeDiv = document.createElement('div');
        changeDiv.id = 'Change';
        addHtml(SecondSecting, changeDiv);
    
        const changeInput = document.createElement('input');
        // changeInput.id = 'i'
        changeInput.type = 'text';
        changeInput.placeholder = 'Wright Name that you want';
        addHtml(changeDiv, changeInput);
    
        const changeFileInput = document.createElement('input');
        changeFileInput.type = 'file';
        changeFileInput.id = 'SelctIimage'
        addHtml(changeDiv, changeFileInput);
        const Show = document.createElement("div");
        Show.classList.add("ShowAllDone");
        Show.setAttribute("id", "enw");
        // 🔥sumaw🌀, [6/22/2024 11:12 PM]
        const changeButton = document.createElement('button');
        changeButton.textContent = 'Submit';
        addHtml(changeDiv, changeButton);
        addHtml(changeDiv, Show)
                
        changeButton.addEventListener("click", function () {
            const getClor = generatoColor();
            const AllC = document.createElement("div");
            let a = changeInput.value.trim();
            const all = document.createElement("div");
            if (!a) return;
            if (a.length > 10) return;
            if (a in UserAccounts) return;
            // if (Show.innerHTML.trim() !== '') {
            //     Show.innerHTML = '';
            // }
            if (Show.innerHTML !== '') {
                x++;
                let a = document.createElement("p");
                a.textContent = "First Finish What You Start Submit or Clacele Sr.";
                a.style.color = 'red'
                if (x == 1) {
                    addHtml(changeDiv, a)
                    setTimeout(() => {
                        RHtml(changeDiv, a);
                        x = 0;
                    }, 1000);
                }
                return;
            }
            AllC.classList.add("ContainerForChck");
            const cont = document.createElement("div");
            cont.classList.add("ChckDiv")
            const cont_Span = document.createElement("span");
            const Cont_Text = document.createElement("div");
            Cont_Text.classList.add("TextChck");
            const contButtonDiv = document.createElement("div");
            contButtonDiv.classList.add("SencondChckButonDiv");
            const Cont_SubmitB = document.createElement("button");
            Cont_SubmitB.textContent = "Submit";
            const Cont_ClacelB = document.createElement("button")
            Cont_ClacelB.textContent = "Clance";
            const SelctImage1 = document.getElementById('SelctIimage').files[ 0 ];
            Cont_Text.textContent = a;
            if (SelctImage1) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const dataUrl = e.target.result;
                    cont_Span.innerHTML = `<img src="${dataUrl}" alt="Selected Image" style="max-width: 100%; max-height: 100%;">`;
                }
                reader.readAsDataURL(SelctImage1);
            }
            else {
                cont_Span.textContent = a.slice(0, 1);
            }
            addHtml(Show, AllC);
            addHtml(AllC, cont);
            addHtml(cont, cont_Span);
            addHtml(cont, Cont_Text);
            addHtml(AllC, contButtonDiv);
            addHtml(contButtonDiv, Cont_ClacelB);
            addHtml(contButtonDiv, Cont_SubmitB);
            Cont_ClacelB.addEventListener("click", function () {
                RHtml(Show, AllC);
            })
            Cont_SubmitB.addEventListener("click", function () {
                const SelctImage = document.getElementById('SelctIimage').files[ 0 ];
                const uniqId = generateUniqueId();
                all.classList.add("oneAccount");
                all.id = `##${a}`;
                all.setAttribute('ids', a)
                all.setAttribute('nest', uniqId)
                const creat1 = document.createElement("span");
                const all_CheckBox = document.createElement("input");
                all_CheckBox.type = 'checkbox';
                all_CheckBox.style.margin = '5px';
                all_CheckBox.style.display = 'none';
                all_CheckBox.setAttribute("getme", uniqId);
                all_CheckBox.classList.add('checkbox');
                all_CheckBox.value = a;
                if (SelctImage) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const dataUrl = e.target.result;
                        creat1.innerHTML = `<img id="IMG_${uniqId}9io_gmi" src="${dataUrl}" alt="Selected Image" style="max-width: 100%; max-height: 100%;">`;
                    }
                    reader.readAsDataURL(SelctImage);
                }
                else {
                    creat1.textContent = a.slice(0, 1);
                    creat1.style.backgroundColor = getClor;
                    all.setAttribute('sown', getClor)
                }
                if (a in UserAccounts) return;
                const cerat = document.createElement("div");
                cerat.classList.add("text")
                if (UserDisplayInformation.Contents.IsHaveContacts == false) {
                    UserDisplayInformation.Contents.IsHaveContacts = true;
                    RHtml(accountS, main01)
                }
                all.setAttribute("for", uniqId)
                all_CheckBox.id = uniqId;

                T_animation(a, cerat, false)
                addHtml(accountS, all);
                addHtml(all, all_CheckBox);
                addHtml(all, creat1);
                addHtml(all, cerat);
                try {
                    RHtml(accountS, main01)
                } catch (error) {
                    console.log(error)
                }
                CancelSelected.click();
                        
                try {
                    // Select the image file input
                    // Add a listener for file selection

                    UserAccounts[ a ] = { Name: a, A_T: `@${a}`, Img: SelctImage, rem: uniqId, wanted: (SelctImage == undefined ? "" : `IMG_${uniqId}9io_gmi`) };
                    ReverseAccounts[ uniqId ] = { nest: a };
                    Account_textes[ `@${a}` ] = [];
                    Conversations[ a ] = {};
                    ConverCount[ a ] = { ML: 0 };
                    FNAME.push(a);
                    ForSerCh[ a ] = { A_ID: `##${a}`, A_IDS: a, A_Nest: uniqId, A_Class: 'oneAccount', A_GETColor: getClor, A_IMG: SelctImage == undefined ? getClor : `IMG_${uniqId}9io_gmi` };
                    ConvAudio[ a ] = { AUD_L: 0, N_AUD: [ an9s.id, ] };
                    changeInput.value = '';
                    changeFileInput.value = '';
                } catch (error) {
                    console.error(error)
                    document.location.reload();
                }
                if (UserDisplayInformation.PageSystem.SYT.AutoBack == true) {
                    s3tos1();
                }
                RHtml(Show, AllC);
            })
                    
            all.addEventListener("click", function () {
                const newAll = document.getElementById(`${all.id}`);
                const newSecondALL = all.getAttribute('ids');
                const getnest = all.getAttribute('nest');
                if (UserDisplayInformation.PageSystem.IsSelcting == true) return;
                if (CuruntClick == newSecondALL) return;
                if (!(newSecondALL in Conversations)) {
                    alert("There is no account in that name, it can be removed or changed");
                    if (confirm("do you want to delte this account that doesn't exist")) {
                        try {
                            const Org = ReverseAccounts[ getnest ].nest;
                            delete UserAccounts[ Org ]
                            delete Conversations[ Org ]
                        } catch (error) {
                            alert("some thing bad happen: We must restart the page");
                            setTimeout(() => {
                                document.location.reload();
                            }, 1000);
                        }
                        RHtml(accountS, all);
                    }
                }
                else {
                    CuruntClick.pop();
                    CuruntClick.push(newSecondALL)
                    DisplayTheMessage(newSecondALL, getnest)
                };
            })
           
        })
        s2upperback.addEventListener("click", function () {
            console.log('back')
            s2tos1();
        })
        settingButton.addEventListener("click", function () {
            const Sec = document.getElementById("SEcondSection3")
            Sec.innerHTML = '';
            SecondSecting.innerHTML = '';
            const ContainerD = document.createElement("div");
            const BodyStyle = document.createElement("style");
            ContainerD.classList.add("container");
            ContainerD.id = 'Tran';
        
            addHtml(Sec, ContainerD);
            const form = document.createElement("div");
            form.classList.add("form");
            form.action = '/';
            form.id = 'Div_Form'
            addHtml(ContainerD, form);

            const label1 = document.createElement("label");
            label1.setAttribute("for", "BackGroundColorGreen");
            label1.textContent = 'GreenVlave';
            const InputR1 = document.createElement("input");
            InputR1.setAttribute("name", "Colors");
            InputR1.checked = (UserDisplayInformation.PageStyle.GreenBLue ? true : false)
            if (InputR1) {
                if (InputR1.checked) {
                    UserDisplayInformation.PageStyle.GreenBLue == true;
                    PageNature.href = './style/n.css';
                }
                else {
                    UserDisplayInformation.PageStyle.GreenBLue == false;
                }
            }
            InputR1.id = 'BackGroundColorGreen';
            const LIkeAnimLabel = document.createElement("label");
            LIkeAnimLabel.textContent = 'TextAnimation'
            LIkeAnimLabel.setAttribute("for", 'DoAnimate')
            const LIkeAnim = document.createElement("input");
            LIkeAnim.type = 'checkbox';
            LIkeAnim.checked = (UserDisplayInformation.AnimationSystem.PointerAnimaiton == true ? true : false);
            LIkeAnim.id = 'DoAnimate'
            const DELButtonC = document.createElement('label')
            DELButtonC.setAttribute("for", 'DELbutton-s')
            DELButtonC.textContent = 'Permision'
            DELButtonC.title = 'Delete with permission when you delete message it will ask you'
            const DELbuttoncInput = document.createElement("input")
            DELbuttoncInput.type = 'checkbox'
            DELbuttoncInput.checked = (UserDisplayInformation.PageSystem.DEleteWithPermisioin == true ? true : false);
            DELbuttoncInput.id = 'DELbutton-s'
            const AutoBacklabel = document.createElement("label");
            AutoBacklabel.title = 'Auto back From this page to the home'
            AutoBacklabel.textContent = 'AutoBack';
            AutoBacklabel.setAttribute("for", 'AutoBacklnPut')
            const autobackInput = document.createElement("input");
            autobackInput.type = 'checkbox';
            autobackInput.id = 'AutoBacklnPut';
            autobackInput.checked = (UserDisplayInformation.PageSystem.SYT.AutoBack == true ? true : false);
            InputR1.type = 'radio';
            addHtml(form, LIkeAnimLabel)
            addHtml(form, LIkeAnim)
            addHtml(form, AutoBacklabel)
            addHtml(form, autobackInput)
            addHtml(form, DELButtonC)
            addHtml(form, DELbuttoncInput)
            addHtml(form, label1)
            addHtml(form, InputR1)

            const label2 = document.createElement("label");
            label2.setAttribute("for", "BackGroundColorBlue");
            label2.textContent = 'blueviloate';
            const InputR2 = document.createElement("input");
            InputR2.setAttribute("name", "Colors");
            InputR2.id = 'BackGroundColorBlue';
            InputR2.type = 'radio';
            InputR2.checked = (UserDisplayInformation.PageStyle.BlueViolet == true ? true : false)
            addHtml(form, label2)
            addHtml(form, InputR2)
            const BCont = document.createElement("div");
            BCont.classList.add("su89")
            const Button = document.createElement("button");
            Button.type = 'Submit';
            Button.textContent = "Change";
            addHtml(form, BCont)
            addHtml(BCont, Button)
            Button.addEventListener("click", function () {
                const PageNature = document.getElementById("PageNature")
                if (InputR1.checked) {
                    PageNature.href = './style/n.css';
                    UserDisplayInformation.PageStyle.GreenBLue = true;
                    UserDisplayInformation.PageStyle.BlueViolet = false;
                }
                if (InputR2.checked) {
                    PageNature.href = ''
                    UserDisplayInformation.PageStyle.GreenBLue = false;
                    UserDisplayInformation.PageStyle.BlueViolet = true;
                }
                if (LIkeAnim) {
                    if (LIkeAnim.checked) {
                        UserDisplayInformation.AnimationSystem.PointerAnimaiton = true;

                    }
                    else {
                        UserDisplayInformation.AnimationSystem.PointerAnimaiton = false;
                    }
                }
                if (DELbuttoncInput) {
                    if (DELbuttoncInput.checked) {
                        UserDisplayInformation.PageSystem.DEleteWithPermisioin = true;
                    }
                    else {
                        UserDisplayInformation.PageSystem.DEleteWithPermisioin = false;
                    }
                }
                if (autobackInput) {
                    if (autobackInput.checked) {
                        UserDisplayInformation.PageSystem.SYT.AutoBack = true;

                    }
                    else {
                        UserDisplayInformation.PageSystem.SYT.AutoBack = false;
                    }
                }
                Button.style = 'background:green; ';
                Button.textContent = 'changed'
                setTimeout(() => {
                    Button.textContent = 'Change';
                    Button.style = '';
                }, 1000);
            });
            // SecondSecting.textContent = 'Update Are Coming Soon';

        })
                
    })
    
    //searhc bar
    searchInput.addEventListener("input", function () {
        const query = searchInput.value.toLowerCase();
        const filteredStores = FNAME.filter(store => store.toLowerCase().startsWith(query));
        if (searchInput.value.trim() == 0) {
            accountS.classList.remove("t")
            accountS.classList.add("ACCAll")
            SerAccount.classList.remove("ACCAll")
            SerAccount.classList.add("t")
            SerAccount.hidden = true;
            accountS.hidden = false;
        }
        else {
            updateDisplay(filteredStores);
        }
        function updateDisplay(results) {
            SerAccount.innerHTML = ''; // Clear previous results
            if (results.length > 0) {
                SerAccount.hidden = false;
                accountS.hidden = true;
                accountS.classList.remove("ACCAll")
                SerAccount.classList.remove("t")
                SerAccount.classList.add("ACCAll")
                accountS.classList.add("t")
                results.forEach(item => {
                    const div = document.createElement('div');
                    div.classList.add("oneAccount");
                    div.id = ForSerCh[ item ].A_ID;
                    div.setAttribute("ids", ForSerCh[ item ].A_IDS)
                    div.setAttribute("nest", ForSerCh[ item ].A_Nest)
                    div.setAttribute("sown", (ForSerCh[ item ].A_IMG.length > 7 ? '' : ForSerCh[ item ].A_IMG))
                    const span = document.createElement('span');
                    try {
                        const vva = UserAccounts[ item ].wanted;
                        const v1v = document.getElementById(vva);
                        const v2v = v1v.src;
                        span.innerHTML = `<img id="${vva}" src="${v2v}" alt="Selected Image" style="max-width: 100%; max-height: 100%;">`;
                    } catch (error) {
                        span.textContent = item.slice(0, 1);
                        span.style.backgroundColor = ForSerCh[ item ].A_GETColor
                    }
                    const texts = document.createElement('div');
                    texts.textContent = item;
                    SerAccount.appendChild(div);
                    addHtml(SerAccount, div)
                    addHtml(div, span)
                    addHtml(div, texts)
                    div.addEventListener("click", function () {
                        const g_9nest = div.getAttribute("nest");
                        const n9_all = div.getAttribute("ids");
                        CuruntClick.pop();
                        CuruntClick.push(n9_all);
                        DisplayTheMessage(n9_all, g_9nest);
                        DLE_Buttons();
                    })
                });
                return;
            } else {
                // if (!searchInput.value.trim()) {
                //     accountS.classList.remove("t")
                //     accountS.classList.add("ACCAll")
                //     SerAccount.classList.remove("ACCAll")
                //     SerAccount.classList.add("t")
                //     SerAccount.hidden = true;
                //     accountS.hidden = false;
                // }
                // else {
                const main1 = document.createElement("div");
                main1.classList.add("Failed")
                const main2 = document.createElement("div");
                main2.classList.add("Dis_IMo")
                main2.textContent = '😔';
                const main3 = document.createElement("text");
                main3.classList.add("Dis_text")
                main3.textContent = `Sorry we didn't get your Search`
                addHtml(SerAccount, main1)
                addHtml(main1, main2)
                addHtml(main1, main3)
                // }
                return;
            }
        }
    })

    function DisplayTheMessage(TheID, gnet) {
        DLE_Buttons();
        if (!(TheID in Conversations)) {
            alert("There is no account in that name, it can be removed or changed");
            if (confirm("do you want to delte this account that doesn't exist")) {
                try {
                    const Org = ReverseAccounts[ gnet ].nest;
                    delete UserAccounts[ Org ]
                    delete Conversations[ Org ]
                } catch (error) {
                    alert("some thing bad happen: We must restart the page");
                    setTimeout(() => {
                        document.location.reload();
                    }, 1000);
                }
                RHtml(accountS, all);
            }
        }
        section2_2.innerHTML = '';
        const AudioElement = [];
        AudioElement.pop();
        s1tos2();
        RHtml(section2, t);
        document.location.hash = `ACC/${CuruntClick}`
        // section2.remove(t)
        messageDisplay.innerHTML = '';
        messageDisplay.id = 'MessDisplay';
        messageDisplay.classList.add('MessDisplay');
        s2uppertext.textContent = CuruntClick;
        //    try {
        if (eval(UserAccounts[ CuruntClick ].Img) == undefined) {
            s2upperimg.textContent = CuruntClick[ 0 ].slice(0, 1);
        }
      
        if (eval(UserAccounts[ CuruntClick ].Img) !== undefined) {
            try {
                const nast = document.getElementById(`IMG_${gnet}9io_gmi`);
                console.log(gnet)
                s2upperimg.innerHTML = `<img src="${nast.src}">`;
            } catch (error) {
                s2upperimg.innerHTML = '<img src="There is no img here">'
            }
            // UserAccounts[ CuruntClick ].Img = nast.src;
        }
        if (CuruntClick in Conversations) {
            for (const [ iid, message ] of Object.entries(Conversations[ CuruntClick ])) {
                if (message.FOR == 'UserMessage') {
                    if (message.ISAUDIO == true) {
                        // Conversations[ CuruntClick ][ `M${ConverCount[ CuruntClick ].ML}` ] = {ISAUDIO:true,IDS:audioPlayer.id, VALUE: audioPlayer.src,FOR:"UserMessage",Couns:ConverCount[CuruntClick].ML}
                        const Aud = document.createElement("div");
                        Aud.classList.add('main012');
                        Aud.id = `0${message.IDS}`;
                        const auS = document.createElement("audio");
                        auS.id = message.IDS;
                        auS.src = message.VALUE;
                        auS.controls = true;
                        addHtml(messageDisplay, Aud);
                        addHtml(Aud, auS)
                        const CNDLIV = document.createElement("div");
                        CNDLIV.classList.add("ControlCeterFM");
                        const COOT_DEL = document.createElement("button");
                        COOT_DEL.id = "FM_DELETE";
                        COOT_DEL.classList.add("FM_DEL");
                        COOT_DEL.setAttribute("JSK", message.IDS);
                        COOT_DEL.textContent = '✕';
                        COOT_DEL.setAttribute("CONT", `${message.Couns}`);
                        addHtml(Aud, CNDLIV);
                        addHtml(CNDLIV, COOT_DEL);
                    }
                    else {
                        const DSV = document.createElement("div");
                        DSV.classList.add("main012");
                        DSV.id = `0${message.IDS}`;
                        const nd = document.createElement("div");
                        nd.setAttribute('iid', iid);
                        nd.id = message.IDS;
                        nd.classList.add(message.FOR)
                        nd.innerHTML = message.EDITED ? `${message.VALUE} <span class="MNEDITED">Edited<span>` : message.VALUE;
                        const CNDLIV = document.createElement("div");
                        CNDLIV.classList.add("ControlCeterFM")
                        const COOT_DEL = document.createElement("button");
                        const COOT_Edit = document.createElement("button");
                        COOT_DEL.id = "FM_DELETE";
                        COOT_Edit.id = "FM_EDIT";
                        COOT_DEL.classList.add("FM_DEL");
                        COOT_DEL.setAttribute("JSK", message.IDS);
                        COOT_Edit.setAttribute("JSK", message.IDS);
                        COOT_Edit.classList.add("FM_Edit");
                        COOT_DEL.textContent = '✕'
                        COOT_Edit.textContent = '⇲'
                        COOT_DEL.setAttribute("CONT", `${message.Couns}`);
                        COOT_Edit.setAttribute("CONT", `${message.Couns}`);
                        addHtml(messageDisplay, DSV)
                        addHtml(DSV, nd)
                        addHtml(DSV, CNDLIV)
                        addHtml(CNDLIV, COOT_DEL)
                        addHtml(CNDLIV, COOT_Edit)
                    }
                }
                else {
                    const nd = document.createElement("div");
                    nd.id = iid;
                    nd.classList.add(message.FOR);
                    const ndt = document.createElement("text");
                    ndt.textContent = message.EDITED ? `${message.VALUE} (edited)` : message.VALUE;;
                    addHtml(messageDisplay, nd)
                    addHtml(nd, ndt)
                }


            }
            messageDisplay.scrollTop = messageDisplay.scrollHeight;
            DLE_Buttons();
            s2upperback.addEventListener("click", function () {
                console.log('back')
                s2tos1();
            })
        }
        
        // IsAnswering = false;
        addHtml(section2_2, messageDisplay);

        const UserAreaMessageControl  = document.createElement('div');
        const userAreaMessage = document.createElement("n-tarea")
        userAreaMessage.id = 'UserAreaMessage'
        UserAreaMessageControl.id = 'UserAreaMessageControl';
        addHtml(section2_2, UserAreaMessageControl);
        addHtml(UserAreaMessageControl, userAreaMessage);

        const messageInput = document.createElement('textarea');
        messageInput.id = 'messageInput';
        messageInput.classList.add('InputText');
        messageInput.placeholder = 'Type Your Message...';
        DLE_Buttons();
        addHtml(userAreaMessage, messageInput);
        ConvAudio[ CuruntClick ].N_AUD.forEach(element => {
            if (ConvAudio[ CuruntClick ].N_AUD == 0) return;
            AudioElement.push(document.getElementById(element));
            AudioElement.forEach((audio, index) => {
                audio.addEventListener('play', function () {
                    playNextAudio01(index);
                })
            });
        });
        let currentAudio = null;
        function playNextAudio01(currentAudioIndex) {
            // Function to play audios sequentially
            if (currentAudioIndex < AudioElement.length) {
                let newAudio = AudioElement[ currentAudioIndex ];

                // If an audio is already playing, pause it
                if (currentAudio && currentAudio !== newAudio) {
                    currentAudio.pause();
                    currentAudio.currentTime = 0; // Reset its time to the beginning
                }

                // Set the new audio as the current one and play it
                currentAudio = newAudio;
                currentAudio.play();

                // When this audio ends, play the next one
                currentAudio.onended = function () {
                    playNextAudio01(currentAudioIndex + 1);// Move to the next audio
                };
            };

        }
        const sendButton = document.createElement('button');
        sendButton.innerHTML = '&blacktriangleleft;';
        sendButton.id = 'answring';
        sendButton.addEventListener('click', function () {
            // if (IsAnswering == true) sendButton.disabled = true;
            // else {
            sendMessage();
            // }
        });
        addHtml(userAreaMessage, sendButton);
        const RecordingButton = document.createElement("button");
        const textsINRB = document.createElement("n1t");
        addHtml(userAreaMessage, RecordingButton);
        addHtml(RecordingButton, textsINRB);
        textsINRB.textContent = '🎙️';
        let zxv = 0;
        var mediaRecorder;
        let audioChunks = [];
        RecordingButton.addEventListener("click", async () => {
            if (UserDisplayInformation.PageSystem.CHANGE.ISEDITING == true)  return 
            zxv++;
            let vs;
            let vst = false
            mediaRecorder;
            if (zxv == 1) {
                vst = true
                textsINRB.textContent = '❌';
                RecordingButton.style = 'background:hsl(0, 100%, 70%);border-radius:100px';
                sendButton.disabled = true;
                userAreaMessage.style = 'background: linear-gradient(50deg,  rgb(255, 102, 102),rgb(98, 98, 228));'
                textsINRB.classList.add("nu89")
                messageInput.readOnly = true;
                vs = setInterval(() => {
                    if (vst == false) {
                        clearInterval(vs);
                    }
                    messageInput.value = 'RECORDING'
                    setTimeout(() => {
                        messageInput.value = `RECORDING.`;
                        
                    }, 200);
                    setTimeout(() => {
                        messageInput.value = `RECORDING..`;
                    }, 500);
                    setTimeout(() => {
                        messageInput.value = `RECORDING...`;
                    }, 700);
                }, 1000);
                messageInput.style = 'color:black;';

                const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
                mediaRecorder = new MediaRecorder(stream);
                mediaRecorder.start();


                audioChunks = [];
                //
                mediaRecorder.ondataavailable = (event) => {
                    audioChunks.push(event.data);
                };
                mediaRecorder.onstop = () => {

                    // Create a Blob from the audio data
                    const audioBlob = new Blob(audioChunks, { type: 'audio/wav' });
                    const audioURL = URL.createObjectURL(audioBlob);
                    clearInterval(vs)
                    // Display the audio player with the recorded audio
                    const audioPlayer = document.createElement('audio');
                    audioPlayer.controls = true;
                    ConvAudio[ CuruntClick ].AUD_L++;
                    audioPlayer.id = `${CuruntClick}-AUD${ConvAudio[ CuruntClick ].AUD_L}`;
                    ConvAudio[ CuruntClick ].N_AUD.push(`${CuruntClick}-AUD${ConvAudio[ CuruntClick ].AUD_L}`);
                    audioPlayer.setAttribute("controls", 's')
                   
                    audioPlayer.playbackRate = true;
                    audioPlayer.src = audioURL;
                    // Show playback area
                    const storySound = document.createElement("div");
                    storySound.classList.add('storySound')
                    const storySound1 = document.createElement("div");
                    storySound.classList.add('storySound')
                    addHtml(messageDisplay, storySound1);
                    addHtml(storySound1, storySound);
                    addHtml(storySound, audioPlayer);
                    ConverCount[ CuruntClick ].ML++;
                    Conversations[ CuruntClick ][ `M${ConverCount[ CuruntClick ].ML}` ] = { ISAUDIO: true, IDS: `${CuruntClick}-AUD${ConvAudio[ CuruntClick ].AUD_L}`, VALUE: audioPlayer.src, FOR: "UserMessage", Couns: ConverCount[ CuruntClick ].ML }
                    
                    AudioElement.push(audioPlayer);
                    let nano0101 = 0;
                    // Add event listener to the new audio for sequential playback
                    audioPlayer.addEventListener('play', function () {
                        nano0101++;
                        if (nano0101 == 1) {
                            playNextAudio01(AudioElement.length - 1);
                        }// Play from the new audio
                    });
                    // Set up the download link // Show download link
                };
            }
            if (zxv > 1) {
                vst = false;
                zxv = 0;
                setTimeout(() => {
                    messageInput.value = '';
                    messageInput.value = '';
                }, 500);
                textsINRB.textContent = '🎙️';
                RecordingButton.style = '';
                userAreaMessage.style = '';
                textsINRB.classList.remove("nu89");
                messageInput.readOnly = false;
                sendButton.disabled = false;
                messageInput.style = '';
                mediaRecorder.stop();
 
            }
        })
    }
    //end of serch script
    // Function to send message
    function sendMessage() {

        const message1 = messageInput.value.trim();
        const formatted = checkAndAddSpaces(message1, 20);
        const message = formatted;
        if (UserDisplayInformation.PageSystem.CHANGE.ISEDITING == true) {
            try {
                if (message == '') return;
                const NV = UserDisplayInformation.PageSystem.CHANGE.THEVALUE;
                const CDF = NV.split("-");
                UserDisplayInformation.PageSystem.CHANGE.ISEDITING = false;
               try {
                Conversations[ CuruntClick ][ CDF[ 1 ] ].VALUE = message;
                Conversations[ CuruntClick ][ CDF[ 1 ] ].EDITED = true;
                const NV2 = document.getElementById(CDF[ 0 ]);
                document.getElementById(`0${CDF[ 0 ].trim()}`).style = ``;
                NV2.textContent = message;
               } catch (error) {
                console.log("removed message  can't be changed ")
               }
                messageInput.value = '';
                document.getElementById("DisplayTheEdit").remove();
                return;
            } catch (error) {
                console.error(error)
                UserDisplayInformation.PageSystem.CHANGE.ISEDITING = false;
            }
            return;
        }
        //clear
        if (message === '') return;
        if (!(CuruntClick in Conversations)) {
            alert(`There Is no file sellection ${message}`)
        }
        // let x = 's'
        else {
            if (message.length > 2000) {
                alert("maximum is 400 letter sr");
                return;
            }
            // IsAnswering = true;
            let c = CuruntClick;
            let bas = `##${generateUniqueId()}`;
            // Add user message
            let bas2 = `@${c}`
            // const message_color = document.getElementById(CuruntClick);
            // const mess_collor = message_color.getAttribute('sown');
            const aDiv = document.createElement("div");
            const BDiv = document.createElement("div");
            BDiv.classList.add("main012")
            BDiv.id = `0${bas}`
            const userMessageDiv = document.createElement('div');
            userMessageDiv.id = bas;
            userMessageDiv.setAttribute('m_get_with_N', bas);
            Account_textes[ bas2 ].push(bas)
            userMessageDiv.classList.add('UserMessage');
            userMessageDiv.textContent = message;
            const CNDLIV = document.createElement("div");
            CNDLIV.classList.add("ControlCeterFM")
            const COOT_DEL = document.createElement("button");

            const COOT_Edit = document.createElement("button");
            COOT_DEL.id = "FM_DELETE";
            COOT_Edit.id = "FM_EDIT";
            COOT_DEL.classList.add("FM_DEL");
            COOT_DEL.setAttribute("JSK", bas);
            COOT_Edit.setAttribute("JSK", bas);
            COOT_Edit.classList.add("FM_Edit");
            COOT_DEL.textContent = '✕'
            COOT_Edit.textContent = '⇲'
            // userMessageDiv.style.backgroundColor = mess_collor;
            if (IsAnswering == true) {
                return;
            }
            else {
                ConverCount[ c ].ML++;
                COOT_DEL.setAttribute("CONT", `${ConverCount[ c ].ML}`);
                COOT_Edit.setAttribute("CONT", `${ConverCount[ c ].ML}`);
                addHtml(messageDisplay, aDiv)
                addHtml(aDiv, BDiv)
                addHtml(BDiv, userMessageDiv);
                addHtml(BDiv, CNDLIV);
                addHtml(CNDLIV, COOT_DEL);
                addHtml(CNDLIV, COOT_Edit);
                Conversations[ c ][ `M${ConverCount[ c ].ML}` ] = { EDITED: false, ISAUDIO: false, VALUE: formatted, FOR: "UserMessage", IDS: bas, Couns: ConverCount[ c ].ML }
                messageInput.value = '';
                DLE_Buttons();
            }
            // 🔥sumaw🌀, [6/22/2024 11:12 PM]
            // Simulate AI response
            setTimeout(() => {
                const bDiv = document.createElement("div")
                const aiMessageDiv = document.createElement('div');
                const n1t = document.createElement('text');
                n1t.classList.add("outputDiv")
                const aiSymbole = document.createElement("span");
                aiSymbole.classList = 'aitex';
                aiSymbole.textContent = 'AI:';
                let rep;
                aiMessageDiv.classList.add('RobotMessage');
                switch (true) {
                    case message.toLowerCase() == "what is your name":
                        rep = `My name is "${CuruntClick}".`;
                        break;
                    case message.trim().toLowerCase() == CuruntClick:
                        rep = `"${CuruntClick}" whta is thise name.`;
                        break;
                    case message == 'lorem':
                        rep = `<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere tenetur, tempora aut sed debitis, commodi tempore voluptates quod, aliquid ad est placeat. Nulla sed aspernatur rem rerum eveniet odit inventore.</p>`;
                        break;
                    case message.startsWith("%01%") && message.endsWith("%AA%") || message.endsWith('%101%'):

                        let nc9 = (message.endsWith('%101%') ? message.replace('%101%', ' ').trim() : message.replace('%AA%', ' ').trim());
                        let n998 = nc9.replace('%01%', ' ').trim();
                        let chtob;
                        if (message.endsWith("%AA%")) {
                            chtob = chtob = changeFromBinary(n998);
                            rep = `AI: To Le :- ${chtob}`;
                        }
                        else {
                            chtob = changeToBinary(n998);
                            rep = `AI: To code :- ${chtob}`;

                        }
                        break;
                    case message.startsWith('%%A') || message.startsWith('%%a'):
                        let null90 = (message.startsWith("%%A") ? message.replace('%%A', '') : message.replace('%%a', ''));
                        if (message.startsWith('%%A')) {
                            rep = `AI:  Capitap-${null90.toLocaleUpperCase()}`
                        }
                        else {
                            rep = `AI:  small-${null90.toLocaleLowerCase()}`
                        }
                        break;
                    
                    case Number(message) !== NaN:
                        try {
                            const ans = eval(message);
                            rep = `AI: ${ans}`;
                        } catch (error) {
                            rep = `AI: You Math Quastion "${message}."`
                        }
                        break;
                
                    default:
                        rep = `AI: You Math Quastion "${message}."`
                        break;
                }
                
                let notes = rep;
                aiMessageDiv.textContent = ``;
              
                const addsdiv = document.createElement("div");
                // IsAnswering = true;
                addHtml(messageDisplay, bDiv);
                addHtml(bDiv, aiMessageDiv);
                addHtml(aiMessageDiv, n1t);
                const nsis = document.getElementById("answring")
                T_animation(notes, n1t, true, CuruntClick, bDiv)
                
                  
                // Add one letter every 100ms
            }, 500);
        }
    }
    document.location.hash = '';
    if (Object.keys(UserAccounts).length !== 0) {
        ACCDisplay();
    }
    function ACCDisplay() {
        accountS.innerHTML = '';
        FNAME.pop();
        Object.keys(UserAccounts).forEach(eles1 => {
            FNAME.push(eles1)
            const M_Div = document.createElement("div");
            M_Div.id = `##${eles1}`
            M_Div.classList.add("oneAccount")
            M_Div.setAttribute("ids", eles1);
            M_Div.setAttribute("nest",ForSerCh[eles1].A_Nest)
            M_Div.setAttribute("sown", ForSerCh[ eles1 ].A_GETColor)
            const I_Div = document.createElement("input");
            I_Div.classList.add("checkbox");
            I_Div.type = 'checkbox';
            I_Div.value = eles1; 
            I_Div.style.margin = '5px';
            I_Div.style.display = 'none';
            I_Div.id = ForSerCh[ eles1 ].A_Nest;
            I_Div.setAttribute("getme",ForSerCh[eles1].A_Nest)
            const S_Div = document.createElement("span");
            if (S_Div) {
                S_Div.textContent = eles1.slice(0, 1);
                S_Div.style.backgroundColor = ForSerCh[ eles1 ].A_GETColor;
            }
            const T_Div = document.createElement("div");
            T_Div.textContent = eles1;
            T_Div.classList.add('text')
            addHtml(accountS,M_Div)
            addHtml(M_Div, I_Div);
            addHtml(M_Div, S_Div);
            addHtml(M_Div, T_Div);
            M_Div.addEventListener('click', function () {
                if (UserDisplayInformation.PageSystem.IsSelcting == true) return;
                CuruntClick.pop();
                const tids = M_Div.getAttribute('ids')
                const tnest = M_Div.getAttribute('nest')
    CuruntClick.push(tids);
                DisplayTheMessage(tids, tnest);
            })
        })
    }
});