import StreamerStyle from "./Streamer.module.css"

export default function Streamer() {
    function GiveItems(item: any) {
        fetch("https://streamer/giveitem", {
            method: "POST",
            body: JSON.stringify({item: item})
        })
        window.postMessage({show: false})
    }
    return (
        <div className={StreamerStyle.Container}>
            <div className={StreamerStyle.Option} onClick={() => GiveItems("lancer")}>
                <div className={StreamerStyle.Text}>
                    <h1>carro</h1>
                    <p>Lancer</p>
                </div>
                <img src="./src/assets/images/carro.png"></img>
            </div> 
            <div className={StreamerStyle.Option} onClick={() => GiveItems("moto")}>
                <div className={StreamerStyle.Text}>
                    <h1>moto</h1>
                    <p>Cbr</p>
                </div>
                <img src="./src/assets/images/moto.png"></img>
            </div> 
            <div className={StreamerStyle.Option} onClick={() => GiveItems("streamer")}>
                <div className={StreamerStyle.Text}>
                    <h1>kit</h1>
                    <p>streamer</p>
                </div>
                <img src="./src/assets/images/ak.png"></img>
            </div> 
            <div className={StreamerStyle.Option} onClick={() => GiveItems("amigos")}>
                <div className={StreamerStyle.Text}>
                    <h1>kit</h1>
                    <p>amigos</p>
                </div>
                <img src="./src/assets/images/five.png"></img>
            </div> 
        </div>
    )
}