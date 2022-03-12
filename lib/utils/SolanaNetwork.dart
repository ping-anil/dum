
class NetworkUrl {
  late String rpc;
  late String ws;
  NetworkUrl(this.rpc, this.ws);
}

class SolanaNetwork{
  static final Devnet =  NetworkUrl('https://api.devnet.solana.com', 'ws://api.devnet.solana.com');
  static final Mainnet = NetworkUrl('https://solana-api.projectserum.com', 'ws://solana-api.projectserum.com');
  static final TestNet = NetworkUrl('https://api.testnet.solana.com', 'ws://api.testnet.solana.com');
  static final Current = Mainnet;
}


