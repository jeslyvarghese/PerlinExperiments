//
//  Perlin.swift
//  PerlinExperiments
//
//  Created by Jesly Varghese on 18/01/20.
//  Copyright © 2020 Jesly Varghese. All rights reserved.
//

import Foundation

struct Point {
    let x: Double
    let y: Double
    let z: Double
}
    
func perlin(forPoint point: Point) -> Double {
    let permutations = [151,160,137,91,90,15,
        131,13,201,95,96,53,194,233,7,225,140,
        36,103,30,69,142,8,99,37,240,21,10,23,
        190, 6,148,247,120,234,75,0,26,197,62,
        94,252,219,203,117,35,11,32,57,177,33,
        88,237,149,56,87,174,20,125,136,171,168,
        68,175,74,165,71,134,139,48,27,166,77,
        146,158,231,83,111,229,122,60,211,133,
        230,220,105,92,41,55,46,245,40,244,
        102,143,54, 65,25,63,161, 1,216,80,73,
        209,76,132,187,208, 89,18,169,200,196,
        135,130,116,188,159,86,164,100,109,198,
        173,186, 3,64,52,217,226,250,124,123,
        5,202,38,147,118,126,255,82,85,212,207,
        206,59,227,47,16,58,17,182,189,28,42,
        223,183,170,213,119,248,152, 2,44,154,
        163, 70,221,153,101,155,167, 43,172,9,
        129,22,39,253, 19,98,108,110,79,113,224,
        232,178,185, 112,104,218,246,97,228,
        251,34,242,193,238,210,144,12,191,179,
        162,241, 81,51,145,235,249,14,239,107,
        49,192,214, 31,181,199,106,157,184,
        84,204,176,115,121,50,45,127, 4,150,254,
        138,236,205,93,222,114,67,29,24,72,243,
        141,128,195,78,66,215,61,156,180]
    let p = (0...511).map { permutations[$0 % 256] }
    let xi = Int(point.x) & 255
    let yi = Int(point.y) & 255
    let zi = Int(point.z) & 255
    let of = Point(x: point.x.truncatingRemainder(dividingBy: 1), y: point.y.truncatingRemainder(dividingBy: 1), z: point.z.truncatingRemainder(dividingBy: 1))
    let u = Point(x: fade(t: fade(t: of.x)), y: fade(t: of.y), z: fade(t: of.z))
    let aaa = p[p[p[xi]+yi]+zi]
    let aba = p[p[p[xi]+inc(of: yi)]+zi]
    let aab = p[p[p[xi]+yi]+inc(of: zi)]
    let abb = p[p[p[xi]+inc(of:yi)]+inc(of:zi)]
    let baa = p[p[p[inc(of:xi)]+yi]+zi]
    let bba = p[p[p[inc(of:xi)]+inc(of:yi)]+zi]
    let bab = p[p[p[inc(of:xi)]+yi]+inc(of:zi)]
    let bbb = p[p[p[inc(of:xi)]+inc(of:yi)]+inc(of:zi)]
    var x1 = lerp(of: Point(x: grad(hash: aaa, point: of),
                            y: grad(hash: baa, point:Point(x: of.x-1, y: of.y, z: of.z)),
                            z: u.x))
    var x2 = lerp(of: Point(x: grad(hash: aba, point:Point(x: of.x, y: of.y-1, z: of.z)),
                            y: grad(hash: bba, point:Point(x: of.x, y: of.y-1, z: of.z)),
                            z: u.x))
    let y1 = lerp(of: Point(x: x1, y: x2, z: u.y))
    x1 = lerp(of: Point(
        x: grad(hash: aab, point: Point(x: of.x, y: of.y, z: of.z - 1)),
        y: grad(hash: bab, point: Point(x: of.x - 1, y: of.y, z: of.z - 1)),
        z: u.x))
    x2 = lerp(of: Point(
        x: grad(hash: abb, point: Point(x: of.x, y: of.y - 1, z: of.z - 1)),
        y: grad(hash: bbb, point: Point(x: of.x - 1, y: of.y-1, z: of.z - 1)),
        z: u.x
    ))
    let y2 = lerp(of: Point(x: x1, y: x2, z: u.y))
    return (lerp(of: Point(x: y1, y: y2, z: u.z)) + 1) / 2
}

func inc(of num:Int) -> Int {
    return num + 1
}

func fade(t: Double) -> Double {
    return 6*pow(t, 5) - 15*pow(t, 4) + 10*pow(t, 3)
}

func lerp(of point: Point) -> Double {
    return point.x + point.z * (point.y - point.x)
}

func grad(hash: Int, point: Point) -> Double {
    let h = hash & 15
    let u = h < 8 ? point.x : point.y
    var v: Double
    if h < 4 {
        v = point.y
    } else if h == 12 || h == 14 {
        v = point.x
    } else {
        v = point.z
    }
    return (h & 1 == 0 ? u : -u) + (h & 2 == 0 ? v : -v)
}

