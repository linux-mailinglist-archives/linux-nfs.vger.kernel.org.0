Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D59078E09C
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 22:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbjH3U1d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 16:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbjH3U1R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 16:27:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20702.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::702])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568393AA0
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 13:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7uSAVfMmmS+COHz9SE8HN+oxH3eMY82CbYEa8Vspx4jgk6ZCwNsj2+w7CAMpgOOxq/BOQoyUi2MavUQ5svIKWyw/8dKWsd+Bqu28EFR4Tw1UmC0RsEKe0ZmAD4m7xwHkIUX2vCEqGrY5aiQ2dZs5t55VbaMAtXGbJHAKmAeSUnrinFRX7C/sD9rmOFGNAS6yO/rm2Nr/XtDCS+YSKyGQKOAi2J/gA+cnhcmvcHUWuTRVum0LqKwk0/pvsKB92G0Rr6ctlfPR8ufjt8ecIY2zima31rMIlxgh/ApOe67OfvhNWswgzFmD7crFT73a1F50TGV4iuwXbSbjwTXRUIDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oPUZ/PtMkTySxVCGfYDILEYiXYFmNspcOOoAARvkUY=;
 b=f7feqPzhzP+1VlWsp/6uYaQX50cBqlKNTjjVPejoFC0tFVywiurB5RM2PSf8tocPuVS9RIdRk/eknJENnyRhCEM/AAK1SAWSW9cIrMA4HVXhxRijTkOnhQYMHFLwyxB80uChXiDwB12dNGlEokm7IyBHYs47TM2MBN9UKj7kzIOp4oRvgatJ/AkrcOyfOj7jKeSwszU0fkhheP0ePG/uqjEabwIgyEyZwHeumoLtP9hoaJljqTYyM1LTRSgJ04ixxrZPTuiH3oZbl7mXysrC+7/waUMaUDB9Rp6PcmK7/SffEn406l5Kp3F5BC1n6a5X2G2tVs4PeZlgL+K5g/XPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oPUZ/PtMkTySxVCGfYDILEYiXYFmNspcOOoAARvkUY=;
 b=P6ip1oD5QdL9UyMwVcd7uUxlFQfP6kpucqyFdTfBfYfu3ggNrsrYiKDVn8Rm1HNh20BaNUZWE/kLn9t4gTnUMRqTw+CV1ZVJBCAXOGfjJHCLa4LWJKF3Dj3vpsjMudfQV9/AwoSfuKj4VufYxMXxz6pcKqRNMdJReEmkKVbF/es=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB4899.namprd13.prod.outlook.com (2603:10b6:a03:36d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 20:20:52 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6f5a:139d:2430:b061]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6f5a:139d:2430:b061%4]) with mapi id 15.20.6745.015; Wed, 30 Aug 2023
 20:20:52 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSv4: Always ask for type with READDIR
Thread-Topic: [PATCH v2] NFSv4: Always ask for type with READDIR
Thread-Index: AQHZ23oY6M2DRW5ZSE2QG3ttIByxfbADRPsAgAADAAA=
Date:   Wed, 30 Aug 2023 20:20:52 +0000
Message-ID: <4eb846815a1cdd1a98e064305b57a890b46e2708.camel@hammerspace.com>
References: <82d1908e4f835a2f16a509a11b62b9d93ccb6cdf.1693424491.git.bcodding@redhat.com>
         <f793a08ed0db7bbe292c8aa6ec7241178c111cab.camel@kernel.org>
In-Reply-To: <f793a08ed0db7bbe292c8aa6ec7241178c111cab.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY3PR13MB4899:EE_
x-ms-office365-filtering-correlation-id: a745649d-3885-44f8-579f-08dba9969b69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JAeHLXWzL9nFKfeaa5CD7ZCEJl5coH2ddI6HkYyjsiDwpGhSmLoSlY4ksRObEUWiNe+oKys7J/81zxgbOIa7mXQ6hwJgZ0hC2CU92Oa9MI1DtZpl/j1Y2JLEQMujf26zemdoigNU1G6FuwYXFkTmYcN3qdQo7IINYidrwklJH9sYPXQOyb5dWQOZUnEPrz1XLwRGltZoAR7NoNMYLizeeAEfdp7Goh8EeE/pAml/rzdFLFi/WMfLWdQVhY2ksM0nyGbCK0UVRyDtmNE/stgJheCcavFruoUZcaIUdX/+1fKsLQkhyExScY9Q6g0fIrQKyZhO09lyDD54WwUxuKiyb3WdUg4jhrhTdFQJUo4u3uCac4SdFQvVsZgwoEWgem52CUzfQOzpK35uR5gWk586LjAyhFsSfEwAT5tkLWEm7OXRoBfgS2J91qRvB0Iq3WciKl+62evLhhV8IXc1YZa+iUUFCs58TKF/L3rd+j6/JhW/Bg2yO8Vi4QgaSGWE2CiIl2mEcD+H6mTr7bkzarx2+Hh5RsnfGKFe8MdxxtGScJhCkPMjDdvBAbSaXlhea1lYY322cxyUF6GeT++jm9iOH9Jxu5xQLDkBfUInXZnshp7rMzX60RpdB6/gXADoqmwD5qkyLG6+vGMeBxe+rm9j6yGT7X3UfBa/2EeT/0wLPHw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(366004)(396003)(346002)(1800799009)(186009)(451199024)(41300700001)(8936002)(83380400001)(66556008)(8676002)(4326008)(66476007)(71200400001)(478600001)(64756008)(76116006)(110136005)(66946007)(316002)(2616005)(66446008)(6506007)(6486002)(6512007)(2906002)(38100700002)(122000001)(38070700005)(5660300002)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW13ZWVWOWxtYXdNeTAyKzVpbkhoWDVucUxTL1pkMUY0UzBnV0RlUkxmQmZi?=
 =?utf-8?B?S1FuZDZJeTRoaFV6ZkxuRlZVUXFFTmY3enNERVNGR2FUa3pRdFRwdVFaWXpN?=
 =?utf-8?B?ODFBR0RtU3kyUmxiNENZTzZOeVROVU5iR0VqbTZIcGZwdUZsamI1TjV5em8x?=
 =?utf-8?B?M3pFVThUOGdLS2syaytEUWRrYjNUeEprMGxiU2ZyeVVNRSt2NmFGVHZ6Z3VS?=
 =?utf-8?B?MWt4U3RCRFBwT3RHT0dIcTA2MEtmY0dKR1VGN2lid3R4RERkYm5rbDJVeGty?=
 =?utf-8?B?YUlwYmo5SkRyVXN5b0xUb0dSMmVlaERFWitwdmdNQ2VrUWNKYmVRWUpuYlc3?=
 =?utf-8?B?UVdabktnL0FaUG5MVWtETmg5MDRUMWpvMDZyd2hlVDEvQzFzYXVLZUhYLzhv?=
 =?utf-8?B?RjBMNEx6ZEhaY1kvZXozbTN2ZVFRVGV1SGNoNnUwc2EzdU9HTzR0OUpoZy9G?=
 =?utf-8?B?MzlEdGJMSzFCZTg2c09LRDNTamNVc2NhOVNjTnkrTHh3WXovY3NoZk1SOW5F?=
 =?utf-8?B?cTg4M0RuQzd0RDRqZHNRMlVhRWtCK0FQdWo5NkxoT1dWbUNkVlBUdXBsU0dY?=
 =?utf-8?B?MnUrTzBMb3g4Q2lwc2gyWk8wbkR4NkhDV1Z5K2NBN0ZHWlU4emJxSVRoRk56?=
 =?utf-8?B?aWRkOXlhTXBYdVV4OVBmbFZ0UCs3TVZOaVhEaDYrNjlUcktOTXpScEdkSzNV?=
 =?utf-8?B?KzlqOU5OQ1ZheUdFOUl4SU9yTElnQzdWWlJhUUJhbTlWV3k3M2gzckZFZ1p1?=
 =?utf-8?B?WW94SUdkSVl1bVNkT29TcGhBMFM4ZkdFRkZxT01kUTFiemdRQ3ZJSlExd01W?=
 =?utf-8?B?VmxhTmRseEs3WnRqUTUrT2EwaWtVNVZrWVQ2RjhRdGlhTlJaNXdiYVY1ZE0w?=
 =?utf-8?B?MGc1ZnRFK2JsK3F3Um81NURYdHB5WEVOVkIxNHFhdHN1THlnQ0djOU5sa0N2?=
 =?utf-8?B?Q1A4eHRHSlpsaWZ0bGJxVjdJTVcycEpLdDFrSUNWWmNyaEZpcElmUVZtOWQ5?=
 =?utf-8?B?ZWV3NU8rQlg3Nm5SQmRqd3JkcUJoQzBkQWI1UHlYckhlc05aSU83alFBR2VB?=
 =?utf-8?B?TnFrUXk3OWoyNkRUcmE5ZDM3ZVM4ZGo5WDZhcFBkdTYvdWhtOXQyaEdENWk1?=
 =?utf-8?B?U2xSLzJuTmtUVHBudlh5TEtwSGlDeXFFTmszTmRQUFVZWTRlUjdSY2pCM2J5?=
 =?utf-8?B?Y0ZtQVV1T1Y3anlxcTJWT2ExQTlWV056U2ZPUUUzNlpDTndOajVsNC9wdHgw?=
 =?utf-8?B?a3orZTM2VStnTWpMeU1ZcCtYc2VMb0FXTEZlaXlJOGNFVlpjMVJ2SjVuQSt4?=
 =?utf-8?B?WkJEbS8rbktDOWRwcDFleGhTWXJlQmN1MVY0V1VqOHlEazZNeEc0eG50TFll?=
 =?utf-8?B?dU5QRXE1WDFKd0M2THhYckkxdHhoYzlwbFFkTDVZSVNHRG1ReVdpYmZibUtR?=
 =?utf-8?B?dVp3dUJ0eHJKcGMvWkR6bTNFRzR4bjFaL05oakJERCszcm90bjF4SDYzZ08y?=
 =?utf-8?B?VFBYa1RtVVcxYStCaGhQMEQyTUk2Sk1pUzlsc2VWNjVWZHNOVTlwWnNFaHBB?=
 =?utf-8?B?VTI1Z1JiSktQMitBZzZCU09uMjNkeFlDcEpnclh6S3ZaU0Z0cnRIZVFONDQ2?=
 =?utf-8?B?N2xJbjFaZTJPVGV6R0RUaVg1Ymk1MXhWemRKSWtjS0JVMXdESlpUQzRqcnFq?=
 =?utf-8?B?bXpCai9qQ3R2K1RFdDZzMXd2TzZpOElkc0FzRWxxMXEvOG01Wml0Q3dqWlBy?=
 =?utf-8?B?YWo2eFc4eVhvM1EvUmhGS09KcjhrdXdiMVdVWjI1L2pscGJGdElRQzdtaFRQ?=
 =?utf-8?B?SGtEOXA3WExBVTdmc1MwdjdyVXZoS0lvUDdyb3dxc0hRajlpMUgzVFZWTFYw?=
 =?utf-8?B?THp1akhwNTBhY2JZeFBxcW9OSkxoSVJyRTdTVUovNEV0RVdsS2xPZkJxOUJ4?=
 =?utf-8?B?TXRIa3QrRUowRUZzaHIrb0lJeVhNN1VzUGtMWEoybzJZSlRvcjVNN0kxRzU2?=
 =?utf-8?B?ZGlxanpJWllGTlNjazJaaHMybnRzWllWUWpxVU80dlpkOGkxK2QwN2ZOZkxW?=
 =?utf-8?B?YS9yYmNzY2FvSE9GcTFLcXdGWXdRbm9SZ2l6NEJidmU2REZReXI0T1lVTUVO?=
 =?utf-8?B?Q2xselg4K3FFM2twRVlkNHkxNy9ENTFLcHhSNjYwRG4xTkhISm1XTGxkVS93?=
 =?utf-8?B?ejV0dHhVMWhaakh0VG1lc01oTjUxTGhzRWZMU1pxSW1xRGZTNkFOOVVOYUM3?=
 =?utf-8?B?QTBQc2R2bGxDa3AxMUgwYjkrWkJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE930196EBD7E74484AAF2A607C1D671@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a745649d-3885-44f8-579f-08dba9969b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 20:20:52.0543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RK+ZAotv0IGoTT78Ea+8Ckli/et0dvpScAqSR2zYtiVJeoSqAWWUBuL6Dx+Wc+7dcFN/tRHq+ebwlyYFyz7t8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4899
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDE2OjEwIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gV2VkLCAyMDIzLTA4LTMwIGF0IDE1OjQyIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiA+IEFnYWluIHdlIGhhdmUgY2xhaW1lZCByZWdyZXNzaW9ucyBmb3Igd2Fsa2luZyBh
IGRpcmVjdG9yeSB0cmVlLA0KPiA+IHRoaXMgdGltZQ0KPiA+IHdpdGggdGhlICJmaW5kIiB1dGls
aXR5IHdoaWNoIGFsd2F5cyB0cmllcyB0byBvcHRpbWl6ZSBhd2F5IGFza2luZw0KPiA+IGZvciBh
bnkNCj4gPiBhdHRyaWJ1dGVzIHVudGlsIGl0IGhhcyBhIGNvbXBsZXRlIGxpc3Qgb2YgZW50cmll
cy7CoCBUaGlzIGJlaGF2aW9yDQo+ID4gbWFrZXMNCj4gPiB0aGUgcmVhZGRpciBwbHVzIGhldXJp
c3RpYyBkbyB0aGUgd3JvbmcgdGhpbmcsIHdoaWNoIGNhdXNlcyBhIHN0b3JtDQo+ID4gb2YNCj4g
PiBHRVRBVFRScyB0byBkZXRlcm1pbmUgZWFjaCBlbnRyeSdzIHR5cGUgaW4gb3JkZXIgdG8gY29u
dGludWUgdGhlDQo+ID4gd2Fsay4NCj4gPiANCj4gPiBGb3IgdjQgYWRkIHRoZSB0eXBlIGF0dHJp
YnV0ZSB0byBlYWNoIFJFQURESVIgcmVxdWVzdCB0byBpbmNsdWRlIGl0DQo+ID4gbm8NCj4gPiBt
YXR0ZXIgdGhlIGhldXJpc3RpYy7CoCBUaGlzIGFsbG93cyBhIHNpbXBsZSBgZmluZGAgY29tbWFu
ZCB0bw0KPiA+IHByb2NlZWQNCj4gPiBxdWlja2x5IHRocm91Z2ggYSBkaXJlY3RvcnkgdHJlZS4N
Cj4gPiANCj4gDQo+IFRoZSBpbXBvcnRhbnQgYml0IGhlcmUgaXMgdGhhdCB3aXRoIHY0LCB3ZSBj
YW4gZmlsbCBvdXQgZF90eXBlIGV2ZW4NCj4gd2hlbg0KPiAicGx1cyIgaXMgZmFsc2UsIGF0IGxp
dHRsZSBjb3N0LiBUaGUgZG93bnNpZGUgaXMgdGhhdCBub24tcGx1cw0KPiBSRUFERElSDQo+IHJl
cGxpZXMgd2lsbCBub3cgYmUgYSBiaXQgbGFyZ2VyIG9uIHRoZSB3aXJlLiBJIHRoaW5rIGl0J3Mg
YQ0KPiB3b3J0aHdoaWxlDQo+IHRyYWRlb2ZmIHRob3VnaC4NCg0KVGhlIHJlYXNvbiB3aHkgd2Ug
bmV2ZXIgZGlkIGl0IGJlZm9yZSBpcyB0aGF0IGZvciBtYW55IHNlcnZlcnMsIGl0DQpmb3JjZXMg
dGhlbSB0byBnbyB0byB0aGUgaW5vZGUgaW4gb3JkZXIgdG8gcmV0cmlldmUgdGhlIGluZm9ybWF0
aW9uLg0KDQpJT1c6IFlvdSBtaWdodCBhcyB3ZWxsIGp1c3QgZG8gcmVhZGRpcnBsdXMuDQoNCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
