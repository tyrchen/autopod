use anyhow::{anyhow, Result};
use rusoto_core::Region;
use rusoto_polly::{Polly, PollyClient, SynthesizeSpeechInput};

// TODO: extend this MVP
pub async fn synthesize(text: &str) -> Result<Vec<u8>> {
    let client = PollyClient::new(Region::UsWest2);
    let input = SynthesizeSpeechInput {
        text: text.to_owned(),
        voice_id: "Joanna".to_owned(),
        engine: Some("neural".to_owned()),
        output_format: "mp3".to_owned(),
        ..Default::default()
    };
    let output = client.synthesize_speech(input).await?;
    if let Some(stream) = output.audio_stream {
        // TODO: not good
        return Ok((&stream[..]).to_owned());
    }
    Err(anyhow!("No audio stream returned"))
}
