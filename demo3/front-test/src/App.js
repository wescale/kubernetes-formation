import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import AppStore from './AppStore'

class App extends Component {
  constructor() {
    super();
    this.state = {
      facture: null,
      client: null,
      ips: null,
    }
    this.getFacture = this.getFacture.bind(this);
    this.getClient = this.getClient.bind(this);
    this.getIps = this.getIps.bind(this);
  }

  componentWillMount() {
    AppStore.on("facture_receive", this.getFacture);
    AppStore.on("client_receive", this.getClient);
    AppStore.on("ips_receive", this.getIps);

    AppStore.getHandlerClient();
    AppStore.getHandlerFacture();
    AppStore.getHandlerIPs();
  }

  componentWillUnmount() {
    AppStore.removeListener("facture_receive", this.getFacture);
    AppStore.removeListener("client_receive", this.getClient);
    AppStore.removeListener("ips_receive", this.getIps);
  }

  getFacture() {
    this.setState({
      facture: AppStore.getFacture(),
    })
  }

  getClient() {
    this.setState({
      client: AppStore.getClient(),
    })
  }

  getIps() {
    this.setState({
      ips: AppStore.getIps(),
    })
  }


  render() {

    let Facture = null
    if(this.state.facture){
      Facture = <p className="App-intro">
        Le contrat '{this.state.facture.contrat}' est de {this.state.facture.days} jours dont le coût est {this.state.facture.cost} Monopoly
      </p>
    } else {
      Facture = <p className="App-intro">Pas de données</p>
    }

    let Client = null
    if(this.state.facture){
      Client = <p className="App-intro">
        Le client est '{this.state.client.name}' dans le service {this.state.client.service}
      </p>
    } else {
      Client = <p className="App-intro">Pas de données</p>
    }

    let IP = null
    if(this.state.ips){
      let ListIps = this.state.ips.map((ip) => {
            return <p>{ip}, </p>
      });

      IP = <p className="App-intro">
        {ListIps}
      </p>
    } else {
      IP = <p className="App-intro">Pas de données</p>
    }

    return (
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h2>Welcome to Gemalto</h2>
        </div>
        {Facture}
        {Client}
        {IP}
      </div>
    );
  }
}

export default App;
