# DMS Quickshell Interface

QML 桌面界面由共享状态栏部件、内容组件、弹窗和系统服务组成。默认布局与交互见[项目说明](../README.md)。

| 路径 | 职责 |
| --- | --- |
| `Modules/DBar/` | 状态栏、工作区与性能部件 |
| `Modules/DIsland/` | island 布局；中央 HomeCompact 复用 SurfaceStrip |
| `Modules/SurfaceWidgets/` | SurfaceContext、SurfaceWidgetHost、SurfaceWidgetFactory 和 BarPill |
| `Modules/DDash/` | 日历、媒体和仪表盘内容 |
| `Modules/ControlCenter/` | 网络、音频、蓝牙、显示等控制 |
| `Modules/Notifications/` | 通知中心与通知提示 |
| `Widgets/` | DPopout、输入、文本与通用视觉组件 |
| `Services/` | 后端、MPRIS、Niri 等服务 |
| `Common/` | 主题、设置、布局及弹窗管理 |
| `PLUGINS/` | 插件接口与示例 |

状态栏组件通过 SurfaceWidgetFactory 打开弹窗，使用 SurfaceContext 计算锚点。DPopout 默认处理背景点击关闭；需要特殊关闭状态的组件可提供自己的处理。具有独立内容背景的弹窗使用 `drawBackground: false`，避免叠加外层容器。

时钟使用 NumericText 和固定模板尺寸，CPU／内存共用一个 MonitorPill。日历复用 CalendarOverviewCard，媒体复用 MediaPlayerTab；这些内容不复制弹窗定位或关闭代码。

触屏输入由 BarTouchArea 转换为组件主操作，工作区向内扫动打开概览。空白区域鼠标滚轮由 BarScrollArea 处理，明确排除带滚动阶段的触控板事件。

在仓库根目录运行 `make build` 将 QML 随 Go CLI 嵌入，产物为 `core/bin/dms`。直接运行源目录可使用 `quickshell -p quickshell/`。
