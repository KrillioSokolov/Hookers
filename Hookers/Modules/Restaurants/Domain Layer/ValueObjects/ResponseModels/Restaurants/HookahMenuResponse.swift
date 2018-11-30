//
//  HookahMenuResponse.swift
//  Hookers
//
//  Created by Kirill Sokolov on 22.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct HookahMenuResponse: Decodable {
    
    struct Data: Decodable {
        let restaurantId: String
        let categories : [MixCategory]
    }
    
    let reqId: String
    let action: String
    let data: HookahMenuResponse.Data
    
    static func makeTestData() -> [MixCategory] {
        let lemon = HookahMix(mixId: "", name: "Лемонный пирог", imageURL: "lemon_pie", price: Double(280), categoryId: "sour", restaurantId: "", strength: "Средняя", likes: 73, tabacco: [HookahMix.Tabacco(brand: "Fumari", sort: "")], description: "Лимонный вкус, с нотками пряностей и корицы", hookahBowl: "", filling: "")
        
        let mishki = HookahMix(mixId: "", name: "Мишки гамми", imageURL: "mishki", price: Double(280), categoryId: "sweet", restaurantId: "", strength: "Средняя", likes: 73, tabacco: [HookahMix.Tabacco(brand: "Fumari", sort: "")], description: "Вкус любимых мармеладных мишек детства", hookahBowl: "", filling: "")

        let vata = HookahMix(mixId: "", name: "Сладкая вата", imageURL: "vata", price: Double(280), categoryId: "sweet", restaurantId: "", strength: "Средняя", likes: 73, tabacco: [HookahMix.Tabacco(brand: "Fumari", sort: "")], description: "Очень легкая и сладкая вата", hookahBowl: "", filling: "")

//        let pinacolada = HookahMix.init(name: "Пина колада", imageURL: "pina-colada", price: 210, categoryId: "sweet",  strength: "Легкий", likes: 31, tabacco: "Afzal, Alfakher", description: "Мягкий вкус кокоса отлично сочетается с ананасовым соком")
//
//        let moxito = HookahMix.init(name: "Moxито", imageURL: "moxito", price: 200, categoryId: "mint",  strength: "Средний", likes: 57, tabacco: "Afzal", description: "Освежающий мохито освежит твой день")
        
//        let myataShoko = HookahMix.init(name: "Мятный шоколад", imageURL: "myata_shoko", price: 270, categoryId: "mint",  strength: "Средний", likes: 81, tabacco: "Fumari", description: "Американская классика - черный шоколад с мятной начинкой")
//
//        let spicedTea = HookahMix.init(name: "Пряный чай", imageURL: "spiced_tea", price: 250, categoryId: "exotic",  strength: "Средний", likes: 44, tabacco: "Serbetli, Afzal", description: "Чай с бергамотом и индийские пряности, отличный выбор для тех, кому надоели фруктовые вкусы")
//
//        let cola = HookahMix.init(name: "Двойной кайф", imageURL: "cola_lemon", price: 280, categoryId: "exotic",  strength: "Крепкий", likes: 74, tabacco: "Tangers", description: "Для кого-то стакан наполовину пуст, а для кого-то наполовину полон Coca-Cola с долькой лемона.")
//
//        let mafin = HookahMix.init(name: "Черничный мафин", imageURL: "mafin", price: 220, categoryId: "exotic",  strength: "Средний", likes: 32, tabacco: "Adalia", description: "Вкус пряной выпечки с кислинкой черники, отлично гармонирует к теплому чаю")
//
//        let jogurt = HookahMix.init(name: "Бананово-клубничный йогурт", imageURL: "jogurt", price: 195, categoryId: "fruits",  strength: "Легкий", likes: 56, tabacco: "Serbetly", description: "Мягкий и плотный вкус клубничного йогура и банана")
//
//        let yagoda =  HookahMix.init(name: "Ягодный удар", imageURL: "yagoda", price: 175, categoryId: "sour",  strength: "Легкий", likes: 46, tabacco: "Afzal", description: "Смесь ягод, закружит Вашу голову, и напомнит о прекрасных весенних днях")
//
//        let arbuz =  HookahMix.init(name: "Арбуз и дыня", imageURL: "arbuz", price: 165, categoryId: "fruits",  strength: "Легкий", likes: 56, tabacco: "Serbetly", description: "Ненавящевый вкус, отлично заходит любителям бахчевых")
//
//        let slivki =  HookahMix.init(name: "Клубничный десерт", imageURL: "slivki", price: 210, categoryId: "fruits",  strength: "Легкий", likes: 24, tabacco: "Serbetly", description: "Нежный как попка младенца клубничный десерт со сливками")
//

        let sweet = [vata, mishki]

        let sour = [lemon]

//        let fruits = [arbuz, slivki, jogurt]
//
//        let exotic = [mafin, spicedTea, cola]
//
//        let mint = [myataShoko, moxito]
//
        let sourCat = MixCategory(categoryId: "sour", name: "Кислые", imageURL: "kisliy", mixes: sour)

        let sweetCat = MixCategory(categoryId: "sweet", name: "Сладкие", imageURL: "sladkiy", mixes: sweet)

//        let fruitsCat = MixCategory(categoryId: "fruits", name: "Фруктовые", imageURL: "fruktoviy", mixes: fruits)
//
//        let exoticCat = MixCategory(categoryId: "exotic", name: "Другие", imageURL: "exotic", mixes: exotic)
//
//        let mintCat = MixCategory(categoryId: "mint", name: "Мятные", imageURL: "myata", mixes: mint)

        return [sourCat, sweetCat] //, fruitsCat, mintCat, exoticCat]
        
    }
    
}
