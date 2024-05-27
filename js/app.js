// const connectButton = document.getElementById("connectButton");

// connectButton.addEventListener("click", () => {
//    if (typeof window.ethereum !== "undefined") {
//        console.log("MetaMask installed")
//    } else {
//        window.open("https://metamask.io/download/", "_blank");
//    }
// })


document.addEventListener('DOMContentLoaded', function() {
    const connectButton = document.getElementById("connectButton");
    const walletID = document.getElementById("walletID");

    if (typeof window.ethereum !== "undefined") {
        ethereum
          .request({ method: "eth_requestAccounts" })
          .then((accounts) => {
            const account = accounts[0]
    
            walletID.innerHTML = `Wallet connected: ${account}`;
          })
    } else {
        window.open("https://metamask.io/download/", "_blank");
    }

    console.log(window.ethereum);
});

