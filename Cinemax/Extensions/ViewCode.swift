//
//  ViewCode.swift
//  Cinemax
//
//  Created by Humberto Rodrigues on 11/01/23.
//

import Foundation

protocol ViewCode {
    func setView()
    func setContrains()
    func extraChanges()
}

extension ViewCode { //MARK: A HIERARQUIA DA CHAMADA DAS VIEWS É IMPORTANTE
    func setupViewCode(){
        setView() //MARK: 1º SetView pois ela add as subviews necessárias
        extraChanges() //MARK: 2º extrachanges pois chama as funções necessárias do app
        setContrains()//MARK: 3º setConstrains, que ativa NSConstraint e as pina
        
    }
}
