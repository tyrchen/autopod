use std::fs;
fn main() {
    tonic_build::configure()
        .out_dir("src/pb")
        .format(true)
        .compile(&["../protos/tts.proto"], &["../protos"])
        .unwrap_or_else(|e| panic!("Failed to compile proto files. Error: {:?}", e));
    fs::remove_file("src/pb/google.protobuf.rs")
        .unwrap_or_else(|e| print!("Failed to move proto files. Error: {:?}", e));
}
