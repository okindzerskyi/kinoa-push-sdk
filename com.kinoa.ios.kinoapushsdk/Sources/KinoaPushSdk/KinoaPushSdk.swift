import UserNotifications
@available(iOS 13.0, *)
/// Kinoa Push SDK class.
public class KinoaPushSdk {
    /**
    Initialize Kinoa Push SDK.
     
    - Parameter gameSecrets: Kinoa game secrets.
    - Parameter webRoutes: Kinoa web routes.
    */
    public static func initialize(gameSecrets: GameSecrets, webRoutes: WebRoutes) {
        SDK.instance.initialize(gameSecrets: gameSecrets, webRoutes: webRoutes)
    }
    
    /**
    Sets Kinoa player.
     
    - Parameter playerId: Kinoa Player ID.
    */
    public static func setPlayer(playerId: String) async {
         await SDK.instance.setPlayer(playerId: playerId)
    }
    
    /**
    Registers device token on Kinoa.
     
    - Parameter token: Device token.
    - Returns: Processed Kinoa Response.
    */
    public static func registerToken(token: String) async -> KinoaResponse? {
        await SDK.instance.registerToken(token: token)
    }
    
    /**
    Deletes device token on Kinoa.
     
    - Parameter token: Device token.
    - Returns: Processed Kinoa Response.
    */
    public static func deleteToken(token: String) async -> KinoaResponse? {
        await SDK.instance.deleteToken(token: token)
    }
    
    /**
    Gets cached device token.
     
    - Returns: Cached device token.
    */
    public static func getCachedToken() -> String {
        return SDK.instance.getCachedToken()
    }
    
    /**
    Block pushes on Kinoa.
     
    - Returns: Processed Kinoa Response.
    */
    public static func blockPushes() async -> KinoaResponse? {
        await SDK.instance.blockPushes()
    }
    
    /**
    Unblock pushes on Kinoa.
     
    - Returns: Processed Kinoa Response.
    */
    public static func unblockPushes() async -> KinoaResponse? {
        await SDK.instance.unblockPushes()
    }
    
    /**
    Returns push status on Kinoa.
     
    - Returns: Processed Kinoa Response with Kinoa pushes status.
    */
    public static func getPushesStatus() async -> KinoaResponseT<KinoaPushesStatus>? {
        await SDK.instance.getPushesStatus()
    }
    
    /**
    Gets push personalization information.
     
    - Returns: Processed Kinoa Response with KinoaPushPersonalizationInfo.
    */
    public static func getPushPersonalizationInfo() async -> KinoaResponseT<KinoaPushPersonalizationInfo>? {
        await SDK.instance.getPushPersonalizationInfo()
    }
    
    /**
    Sets push personalization information.
     
    - Returns: Processed Kinoa Response.
    */
    public static func setPushPersonalizationInfo(pushPersonalizationInfo: KinoaPushPersonalizationInfo) async -> KinoaResponse? {
        await SDK.instance.setPushPersonalizationInfo(pushPersonalizationInfo: pushPersonalizationInfo)
    }
    
    /**
    Deletes push personalization information.
     
    - Returns: Processed Kinoa Response.
    */
    public static func deletePushPersonalizationInfo() async -> KinoaResponse? {
        await SDK.instance.deletePushPersonalizationInfo()
    }
    
    public static func processClickedNotification(notification: UNNotification?)  -> KinoaPushNotificationClickedData? {
        SDK.instance.processClickedNotification(notification: notification)
    }
}
