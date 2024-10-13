const savedAccounts = localStorage.getItem('UserAccounts');
const GETSERCH = localStorage.getItem("GETSERCH");
const GETREVERSEACC = localStorage.getItem("GETREVERSEACC");
const UserAccounts = JSON.parse(savedAccounts) || {};
const ReverseAccounts = JSON.parse(GETREVERSEACC) || {};
const ForSerCh = JSON.parse(GETSERCH) || {};
const getSEssion = sessionStorage.getItem('system');
const ReverseSession = JSON.parse(getSEssion);
const UserDisplayInformation = {
    AnimationSystem: { PointerAnimaiton: (ReverseSession.AS.PA ? true:false) },
    PageStyle: { BlueViolet: (ReverseSession.PStyle.BV ? true : false), GreenBLue: (ReverseSession.PStyle.GB ? true : false) },
    Contents: {
        IsHaveContacts: false,
        IsContactSelected: false,
    },
    PageSystem: {
        CHANGE: { ISEDITING: false, THEVALUE: '' },
        DEleteWithPermisioin: (ReverseSession.PSystem.DEL_PER ? true : false),
        IsSelcting: false,
        Components: { Microphon: true },
        SYT: { AutoBack: (ReverseSession.PSystem.SYT.AB ? true : false) }
    }
}
const ACCTEXTES = localStorage.getItem("ACCTEXTES")
const Account_textes = JSON.parse(ACCTEXTES) || {};
console.log(Account_textes)
const Xstore = {
    'A': [ '1' ], 'B': [ '10' ], 'C': [ '11' ], 'D': [ '100' ], 'E': [ '101' ], 'F': [ '110' ], 'G': [ '111' ], 'H': [ '1000' ], 'I': [ '1001' ], 'J': [ '1010' ], 'K': [ '1011' ], 'L': [ '1100' ], 'M': [ '1101' ], 'N': [ '1110' ], 'O': [ '1111' ], 'P': [ '10000' ], 'Q': [ '10001' ], 'R': [ '10010' ], 'S': [ '10011' ], 'T': [ '10100' ], 'U': [ '10101' ], 'V': [ '10110' ], 'W': [ '10111' ], 'X': [ '11000' ], 'Y': [ '11001' ], 'Z': [ '11010' ], ',': [ '11011' ], '.': [ '11100' ], '/': [ '11101' ], '"': [ '11110' ], ';': [ '11111' ], ':': [ '100000' ], '[': [ '100001' ], ']': [ '100010' ], '<': [ '100011' ], '>': [ '100100' ], '?': [ '100101' ], '"': [ '100110' ], '|': [ '100111' ], '{': [ '101000' ], '}': [ '101001' ], '(': [ '101010' ], ')': [ '101011' ], '+': [ '101100' ], '=': [ '101101' ], '-': [ '101110' ], '_': [ '101111' ], '*': [ '110000' ], '&': [ '110001' ], '^': [ '110010' ], '%': [ '110011' ], '$': [ '110100' ], '#': [ '110101' ], '@': [ '110110' ], '!': [ '110111' ], "'": [ '111000' ], ' ': [ '0' ], '1': [ '111001' ], '2': [ '111010' ], '3': [ '111011' ], '4': [ '111100' ], '5': [ '111101' ], '6': [ '111110' ], '7': [ '111111' ], '8': [ '1000000' ], '9': [ '1000001' ], '0': [ '1000010' ], '~': [ '1000011' ], '`': [ '1000100' ], 'a': [ '1000101' ], 'b': [ '1000110' ], 'c': [ '1000111' ], 'd': [ '1001000' ], 'e': [ '1001001' ], 'f': [ '1001010' ], 'g': [ '1001011' ], 'h': [ '1001100' ], 'i': [ '1001101' ], 'j': [ '1001110' ], 'k': [ '1001111' ], 'l': [ '1010000' ], 'm': [ '1010001' ], 'n': [ '1010010' ], 'o': [ '1010011' ], 'p': [ '1010100' ], 'q': [ '1010101' ], 'r': [ '1010110' ],'s':['1011100'],'t':['1011101'],'u':['1011110'], 'v': [ '1010111' ], 'w': [ '1011000' ], 'x': [ '1011001' ], 'y': [ '1011010' ], 'z': [ '1011011' ]
};
const XreverseStore = Object.fromEntries(
    Object.entries(Xstore).map(([key, value]) => [value, key])
);

function changeToBinary(text) {
    return text.split('').map(char => Xstore[char] || '').join(' ');
}
function changeFromBinary(binaryText) {
    return binaryText.trim().split(' ').map(bin => XreverseStore[bin] || '').join('');
}