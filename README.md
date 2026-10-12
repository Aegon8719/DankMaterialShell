# DankMaterialShell for Conscia

Conscia 的桌面 Shell，基于 DankMaterialShell、Quickshell 和 Go，提供状态栏、搜索、通知、剪贴板、日历、媒体、系统控制、锁屏与后台服务。

配套合成器为 [niri Conscia 分支](https://github.com/Aegon8719/niri)，安装、默认配置和成对版本锁由 [ConsciaDesktop](https://github.com/Aegon8719/ConsciaDesktop) 管理。本仓库保留 DMS 的通用设置和插件接口；以下默认外观由 ConsciaDesktop 配置提供。

## 状态栏

默认使用 island 模式，中央从左到右为 **搜索、通知、剪贴板、时钟、媒体**。左侧显示工作区，右侧显示托盘、CPU／内存、电池和控制中心。

中央和两侧共用组件加载器、尺寸、边距和背景规则，在同一状态栏区域内居中。搜索、通知和剪贴板为圆形，其余组件使用胶囊形。默认 `innerPadding: 10`，文字和图标缩放均为 `1.1`。空工作区和有窗口时使用相同的布局参考间隙。

时钟显示 `yyyy/MM/dd HH:mm:ss`，与 CPU 百分比使用相同 NumericText、字号和字重，启用等宽数字；宽度按固定模板计算，不随秒数变化。点击时钟仅打开日历，日历布局固定。

CPU 与内存百分比共用一个无 CPU 图标的组件，点击任意位置打开同一个进程面板。媒体有独立入口和播放器弹窗；没有播放器或停止播放时隐藏波形，暂停时保留。封面占位使用低透明度主题前景色。

## 交互

| 输入 | 位置／操作 | 行为 |
| --- | --- | --- |
| Mouse Click／TouchPad | 组件左键点击 | 打开／切换对应弹窗 |
| Mouse Click／TouchPad | 中央空白区域左键 | 不打开组件弹窗 |
| Mouse Click | 状态栏空白区域滚轮上下 | 切换上下工作区 |
| TouchPad | 状态栏空白区域二指滚动 | 不触发滚轮切换工作区 |
| Touch | 点击组件 | 对应左键点击 |
| Touch | 组件向屏幕内侧扫动 | 打开对应弹窗；工作区组件打开概览 |
| 任意点击输入 | 弹窗外部空白 | 关闭弹窗 |
| KeyBoard Shortcuts | 双击 Super | 打开搜索，由合成器绑定处理 |

顶部栏向内是向下，底部栏向内是向上，左右侧栏分别向右、向左。中央组件不通过悬浮展开。

工作区、窗口分屏和桌面手势由合成器处理，完整默认交互见 [niri 项目说明](https://github.com/Aegon8719/niri#交互约定)。

## 共用弹窗

`DPopout` 统一负责定位、动画、焦点及外部空白点击关闭。Niri island 模式下，弹窗近侧边缘按工作区预留区域和窗口边缘间隙对齐。

日历直接使用 `CalendarOverviewCard`，媒体直接使用 `MediaPlayerTab`，均关闭外层背景绘制并省去外层留白。`drawBackground` 控制共用外框绘制，内容自身的背景与控件不受影响。默认配置关闭 `blurBorderEnabled`，不绘制主色外框；应用焦点高亮由合成器独立管理。

## 代码结构与构建

| 路径 | 用途 |
| --- | --- |
| `quickshell/Modules/DBar/` | 状态栏布局和内置部件 |
| `quickshell/Modules/DIsland/` | island 承载与状态切换 |
| `quickshell/Modules/SurfaceWidgets/` | 共用部件加载、点击与弹窗路由 |
| `quickshell/Modules/DDash/` | 日历、媒体和仪表盘内容 |
| `quickshell/Widgets/DPopout.qml` | 弹窗公共接口 |
| `quickshell/Widgets/DPopoutHost.qml` | 弹窗表面、动画及绘制 |
| `quickshell/Services/` | 系统集成及合成器通信 |
| `core/` | Go 后端、CLI 及嵌入式 Shell |
| `dank-qml-common/` | 共用 QML 子模块 |

```sh
git submodule update --init --recursive
make build
```

产物为 `core/bin/dms`。构建会同步 QML 资源到嵌入目录；不要手动编辑生成资源。运行环境需要 Quickshell／Qt、配套系统服务和当前版本要求的 Go 工具链，安装依赖由 ConsciaDesktop 提供。

[QML 结构说明](quickshell/README.md)、[后端说明](core/README.md)、[插件接口](quickshell/PLUGINS/README.md)。

## Credits

- [quickshell](https://quickshell.org/) - Shell framework
- [niri](https://github.com/YaLTeR/niri) - Scrolling window manager
- [Ly-sec](http://github.com/ly-sec) - Wallpaper effects from [Noctalia](https://github.com/noctalia-dev/noctalia-shell)
- [soramanew](https://github.com/soramanew) - [Caelestia](https://github.com/caelestia-dots/shell) inspiration
- [end-4](https://github.com/end-4) - [dots-hyprland](https://github.com/end-4/dots-hyprland) inspiration
- [Reverier-Xu](https://github.com/Reverier-Xu) - [Ori-fcitx5](https://github.com/Reverier-Xu/Ori-fcitx5) inspiration for Fcitx5 theme


## License

MIT License，见 [LICENSE](LICENSE)。
