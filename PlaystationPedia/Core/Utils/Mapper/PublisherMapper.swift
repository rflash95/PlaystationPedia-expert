//
//  PublisherMapper.swift
//  PlaystationPedia
//
//  Created by rzamau on 18/12/22.
//

final class PublisherMapper {
    
    static func mapPublisherResponsesToEntities(
        input publisherResponses: [PublisherResult]
    ) -> [PublisherEntity] {
        return publisherResponses.map { result in
            let newPublisher = PublisherEntity()
            newPublisher.id = result.id
            newPublisher.name = result.name
            newPublisher.gamesCount = result.gamesCount
            newPublisher.imageUrl = result.imageBackground
            newPublisher.desc = ""
            return newPublisher
        }
    }
    
    static func mapPublisherEntitiesToDomains(
        input publisherEntities: [PublisherEntity]
    ) -> [PublisherModel] {
        return publisherEntities.map { result in
            return PublisherModel(id: result.id,
                                  name: result.name,
                                  gamesCount: result.gamesCount,
                                  imageUrl: result.imageUrl,
                                  description: result.desc)
        }
    }
    
    static func mapPublisherResponsesToDomains(
        input publisherResponses: [PublisherResult]
    ) -> [PublisherModel] {
        return publisherResponses.map { result in
            return PublisherModel(
                id: result.id,
                name: result.name,
                gamesCount: result.gamesCount,
                imageUrl: result.imageBackground,
                description: ""
            )
        }
    }
    
    static func mapPublisherDetailResponseToEntity(
      input  publisherResponse: PublisherDetailResponse
    ) -> PublisherEntity {
        let newPublisher = PublisherEntity()
        newPublisher.id = publisherResponse.id
        newPublisher.name = publisherResponse.name
        newPublisher.gamesCount = publisherResponse.gamesCount
        newPublisher.imageUrl = publisherResponse.imageBackground
        newPublisher.desc = publisherResponse.description.trimHTMLTags() ?? ""
        return newPublisher
      }
    
    static func mapPublisherDetailToEntity(
      input  publisherResponse: PublisherDetailResponse
    ) -> PublisherEntity {
        let newPublisher = PublisherEntity()
        newPublisher.id = publisherResponse.id
        newPublisher.name = publisherResponse.name
        newPublisher.gamesCount = publisherResponse.gamesCount
        newPublisher.imageUrl = publisherResponse.imageBackground
        newPublisher.desc = publisherResponse.description
        return newPublisher
      }
    
    static func mapPublisherDetailToDomains(
        input publisherEntity: PublisherEntity
    ) -> PublisherModel {
        return PublisherModel(id: publisherEntity.id,
                              name: publisherEntity.name,
                              gamesCount: publisherEntity.gamesCount,
                              imageUrl: publisherEntity.imageUrl,
                              description: publisherEntity.desc)
    }
    static func mapPublisherDetailResponseToDomain(
        input detailResponse: PublisherDetailResponse
    ) -> PublisherModel {
        return PublisherModel(
            id: detailResponse.id,
            name: detailResponse.name,
            gamesCount: detailResponse.gamesCount,
            imageUrl: detailResponse.imageBackground,
            description: detailResponse.description.trimHTMLTags()!
        )
    }
    static func mapPublisherDetailEntityToDomain(
        input publisherEntity: PublisherEntity
    ) -> PublisherModel {
     return PublisherModel(id: publisherEntity.id,
                              name: publisherEntity.name,
                              gamesCount: publisherEntity.gamesCount,
                              imageUrl: publisherEntity.imageUrl,
                              description: publisherEntity.desc)
    }
}
