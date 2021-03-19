//
//  ExApi.h
//  ExCheckCar
//
//  Created by exsun on 2021/1/11.
//

#ifndef ExApi_h
#define ExApi_h

/****************************统计报表****************************/
/** 获取开始结束时间 */
 #define URL_POST_GetTypeTime   @"/api/AppReports/GetTypeTime"
/** 获取当前用户定位的经纬度 */
#define URL_POST_UserLocation  @"/api/UserData/UserLocation"
/** 统计报表-企业上线率接口*/
#define URL_POST_GetEnterpriseTheWholePoint   @"/api/AppReports/GetEnterpriseTheWholePoint"
/** 区域统计报表-区域出土量*/
#define URL_POST_GetRegionUnearthed @"/api/AppReports/GetRegionUnearthed"
/** 区域统计报表-区域消纳量*/
#define URL_POST_GetRegionConsumptive @"/api/AppReports/GetRegionConsumptive"
/** 区域统计报表-区域可疑工地*/
#define URL_POST_GetRegionSusUnearthed @"/api/AppReports/GetRegionSusUnearthed"
/** 区域统计报表-区域可疑消纳点*/
#define URL_POST_GetRegionSusConsumptive @"/api/AppReports/GetRegionSusConsumptive"
/**区域统计报表-区域未密闭率-区域超速率*/
#define URL_POST_GetRegionAlarm  @"/api/AppReports/GetRegionAlarm"
/** 企业统计报表-出土量最多最少企业*/
#define URL_POST_GetEnterpriseSiteCube  @"/api/AppReports/GetEnterpriseSiteCube"
/** 企业统计报表-未密闭率超速最高最低企业*/
#define URL_POST_GetEnterpriseAlarm  @"/api/AppReports/GetEnterpriseAlarm"
/** 企业统计报表-企业基本信息*/
#define URL_POST_GetEnterpriseBacis  @"/api/AppReports/GetEnterpriseBacis"
/** 工地统计报表-出土量最多最少工地*/
#define URL_POST_GetSiteRank @"/api/AppReports/GetSiteRank"
/** 工地统计报表-提前出土工地*/
#define URL_POST_GetInAdvanceSite @"/api/AppReports/GetInAdvanceSite"
/** 工地统计报表-工地出土情况*/
#define URL_POST_GetSiteStatic @"/api/AppReports/GetSiteStatic"
/** 工地统计报表-黑工地数*/
#define URL_POST_GetBlackSiteStatic @"/api/AppReports/GetBlackSiteStatic"
/** 消纳点统计报表-消纳量最多和最少消纳点*/
#define URL_POST_GetUnLoadRank @"/api/AppReports/GetUnLoadRank"
/** 车辆统计报表-上线时长最高最低车辆*/
#define URL_POST_GetVehicleOnLine @"/api/AppReports/GetVehicleOnLine"
/** 车辆统计报表-未密闭、超速、超载最高最低*/
#define URL_POST_GetVehicleAlarm @"/api/AppReports/GetVehicleAlarm"
/** 车辆统计报表-获取安装车辆统计*/
#define URL_POST_GetInstallVehicle @"/api/AppReports/GetInstallVehicle"
/** 车辆统计报表-获取企业车辆安装图片*/
#define URL_POST_GetInstallVehicleImgs @"/api/AppReports/GetInstallVehicleImgs"
/** 专题统计报表-重点监控区域*/
#define URL_POST_GetVehicleFenceTrips   @"/api/AppReports/GetVehicleFenceTrips"

/** 条件查询-获取围栏信息*/
#define URL_POST_GetFenceList  @"/api/AppReports/GetFenceList"
#endif /* ExApi_h */
