# osc_ubct

A new Flutter plugin project.

## For AI readers
- `thirdparty`として、[.gitmodules](./.gitmodules)に以下を設定しています。仕様を理解してください。
  - [./windows/thirdparty/opencv](https://github.com/opencv/opencv.git)
  - [./windows/thirdparty/oscpack](https://github.com/RossBencina/oscpack.git)
  - [./windows/thirdparty/glm](https://github.com/g-truc/glm.git)
  - [./windows/thirdparty/open_model_zoo](https://github.com/openvinotoolkit/open_model_zoo.git)
- [WorkspaceLayout.md](./WorkspaceLayout.md)を読んで、階層と役割を理解してください。

# 
```mermaid
graph LR
  %% ====== 外部コンポーネント ======
  subgraph FL["Flutter"]
    FUI["UI: OSC_Controller"]
  end

  subgraph CPP["C++"]
    subgraph OSC["OSC"]
      SND["Sender"]
    end
    subgraph CV["OpenCV"]
      CAM["Camera"]
      TRK["Tracking"]
    end
  end

  %% ====== Resonite.exe 側（階層: components → Item → avater） ======
  subgraph RES["Resonite.exe"]
    %% components
    subgraph COMP["components"]
      subgraph NET["Network > OSC"]
        RCV["OSC_Receiver"]
        VAL["OSC_Value<T>"]
      end
    end

    %% Item
    subgraph ITEM["Item"]
      subgraph UIX["UIX"]
        CTRL["avater_expr_controller"]
      end
    end

    %% avater
    subgraph AVA["avater"]
      SK["Shape Key"]
    end
  end

  %% ====== データフロー ======
  FUI -- 設定(送信先/アドレス/周期) --> SND
  CAM --> TRK
  TRK -- 追跡結果(表情/関節角など) --> SND
  SND -- OSC送信 --> RCV
  RCV --> VAL
  VAL -- 値を購読/参照 --> CTRL
  CTRL -- 係数/マッピング適用 --> SK

```

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

