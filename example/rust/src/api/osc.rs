//! path: example/rust/src/api/osc.rs
use anyhow::Result;
use rosc::{OscMessage, OscPacket, OscType};
use std::net::{Ipv4Addr, UdpSocket};
use flutter_rust_bridge::frb;          // ← 追加

#[frb(opaque)]                          // ← 追加
#[derive(Debug)]
pub struct OscSender {
    sock: UdpSocket,
    target_ip: String,
    target_port: u16,
}

pub fn osc_open(ip: String, port: u16) -> Result<OscSender> {
    let sock = UdpSocket::bind((Ipv4Addr::UNSPECIFIED, 0))?;
    Ok(OscSender { sock, target_ip: ip, target_port: port })
}

pub fn osc_send_json(osc: &OscSender, path: String, json: Vec<u8>) -> Result<()> {
    let pkt = OscPacket::Message(OscMessage { addr: path, args: vec![OscType::Blob(json)] });
    let buf = rosc::encoder::encode(&pkt)?;
    let to = format!("{}:{}", osc.target_ip, osc.target_port);
    osc.sock.send_to(&buf, to)?;
    Ok(())
}
