use crate::{TtsService, RequestSynthesize, ResponseSynthesize, synthesize};
use tonic::{Request, Response, Status};

pub struct TtsServer {}

#[tonic::async_trait]
impl TtsService for TtsServer {
    async fn synthesize(&self, request: Request<RequestSynthesize>) -> Result<Response<ResponseSynthesize>, Status> {
        let msg = request.into_inner();
        let mut reply = ResponseSynthesize::default();
        match synthesize(msg.text.as_str()).await {
            Ok(data) => {
                reply.data = data;
                Ok(Response::new(reply))
            },
            Err(error) => {
                Err(Status::internal(error.to_string()))
            }
        }

    }
}
