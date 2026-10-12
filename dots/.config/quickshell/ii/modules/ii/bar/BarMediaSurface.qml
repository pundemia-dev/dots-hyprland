pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Window
import Qt5Compat.GraphicalEffects

// Rounded clipping with a stable allocation throughout the morph. The regular
// ClippingRectangle resizes both its content and mask textures on every frame.
Item {
    id: root
    required property size textureSize
    property alias radius: background.radius
    property alias color: background.color
    default property alias contentData: content.data
    readonly property size backingTextureSize: Qt.size(
        Math.ceil(textureSize.width * Screen.devicePixelRatio),
        Math.ceil(textureSize.height * Screen.devicePixelRatio))

    Rectangle {
        id: background
        anchors.fill: parent
        antialiasing: true
    }

    Rectangle {
        id: mask
        anchors.fill: parent
        radius: root.radius
        color: "white"
        antialiasing: true
        visible: false
        layer.enabled: true
        layer.textureSize: root.backingTextureSize
        layer.smooth: true
    }

    Item {
        id: content
        anchors.fill: parent
        layer.enabled: true
        layer.textureSize: root.backingTextureSize
        layer.smooth: true
        layer.effect: OpacityMask {
            maskSource: mask
        }
    }
}
