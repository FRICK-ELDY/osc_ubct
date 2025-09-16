//! path: example/rust/src/api/camera.rs
use image::{codecs::jpeg::JpegEncoder, ImageBuffer, Rgb};
use std::time::Instant;
use flutter_rust_bridge::frb;          // ← 追加

#[frb(opaque)]                          // ← 追加
#[derive(Debug)]
pub struct Camera {
    w: i32,
    h: i32,
    fps: i32,
    t0: Instant,
}

#[derive(Debug)]
pub struct Frame {
    pub jpeg: Vec<u8>,
    pub width: i32,
    pub height: i32,
}

pub fn camera_open(_index: i32, w: i32, h: i32, fps: i32) -> Camera {
    Camera { w, h, fps, t0: Instant::now() }
}

pub fn camera_grab_jpeg(cam: &Camera, quality: u8) -> Frame {
    let w = cam.w as u32;
    let h = cam.h as u32;
    let t = cam.t0.elapsed().as_millis() as u32 / 30;
    let mut img = ImageBuffer::<Rgb<u8>, Vec<u8>>::new(w, h);
    for y in 0..h { for x in 0..w {
        let v = (((x/16 + y/16 + t) % 32) * 8) as u8;
        img.put_pixel(x, y, Rgb([v, 255 - v, v.saturating_add(32)]));
    }}
    let mut buf = Vec::new();
    let mut enc = JpegEncoder::new_with_quality(&mut buf, quality.clamp(1, 100));
    enc.encode(&img, w, h, image::ExtendedColorType::Rgb8).expect("jpeg encode");
    Frame { jpeg: buf, width: cam.w, height: cam.h }
}
