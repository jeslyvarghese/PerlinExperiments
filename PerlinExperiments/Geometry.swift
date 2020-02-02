//
//  Geometry.swift
//  PerlinExperiments
//
//  Created by Jesly Varghese on 01/02/20.
//  Copyright © 2020 Jesly Varghese. All rights reserved.
//

import Foundation
import SceneKit
import SceneKit.ModelIO

func perlinPlane(width: Int = 10, length: Int = 10, textureScale: Float = 8, cellSize: Float = 0.5) -> SCNGeometry {
    var vertices: [SCNVector3] = []
    var texCoords: [vector_float2] = []
    var faces: [Int] = []
    let pointAcross = width + 1
    let halfWidth = Double(width) / 2
    let halfLength = Double(length) / 2
    
    for z in 0...length {
        for x in 0...width {
            let fX = Double(x) - halfWidth
            let fZ = Double(z) - halfLength
            let noise = perlin(forPoint: Point(x: fX, y: fZ, z: 1))
            vertices.append(SCNVector3Make(Float(fX) * cellSize, Float(fZ) * cellSize, Float(noise) * cellSize * 1.5))
            texCoords.append(vector_float2(x: Float(x)/Float(width) * textureScale, y: Float(z)/Float(length)*textureScale))
            if z > 0 && x > 0 {
                let a = Int(vertices.count) - 1
                let b = a - 1
                let c = b - pointAcross
                let d = a - pointAcross
                faces += [a, c, b, a, d, c]
            }
        }
    }
    let vertexSource = SCNGeometrySource(vertices: vertices)
    let indexData = Data(bytes: faces, count: MemoryLayout<Int>.size * faces.count)
    let element = SCNGeometryElement(data: indexData, primitiveType: .triangles, primitiveCount: faces.count/3, bytesPerIndex: MemoryLayout<Int>.size)
    let geometry = SCNGeometry(sources: [vertexSource], elements: [element])
    let mesh = MDLMesh(scnGeometry: geometry)
    mesh.addNormals(withAttributeNamed: "MDLVertexAttributeNormal", creaseThreshold: 0)
    let geometryWithNormal = SCNGeometry(mdlMesh: mesh)
    return geometryWithNormal
    
    
    
    
    
    
    
}
