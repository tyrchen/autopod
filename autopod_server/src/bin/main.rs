use anyhow::Result;
use tonic::transport::Server;

use autopod_server::{TtsServiceServer, TtsServer};

#[tokio::main]
async fn main() {
    let port = 12345;
    println!("Starting autopod server at: {}", port);
    start_grpc_server(port).await.unwrap();
}

async fn start_grpc_server(port: u16) -> Result<()> {
    let addr = format!("0.0.0.0:{}", port).parse().unwrap();
    let server = TtsServer {};
    let svc = TtsServiceServer::new(server);

    Server::builder()
        .add_service(svc)
        .serve(addr)
        .await?;
    Ok(())
}
