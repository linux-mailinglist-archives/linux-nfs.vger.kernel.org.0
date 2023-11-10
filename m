Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345747E828D
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 20:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346348AbjKJTb7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 14:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbjKJTbn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 14:31:43 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2098.outbound.protection.outlook.com [40.107.93.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C03A47B5
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 11:08:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKQUsGLq2BYN6nWQcKDGbJKb/gzq+D2F4wNDDKTa2UPf5eglurRe3yE+79/avIqtNHHfgSJHpGrKhEvJ/RcCCalAPquGpGQEYihDM691W9WJbMWYU8OGT+dgF5HA8xwP031+4OLMOKaMZ4wyv6m2hLOs0lPQXB3k+kCX1pVUUTYB/9gcFDFSCSG78pUnHc6ANmKnMOB46FJ4OQyDZgfoG+W+7QYki++JiNahWsG1XdA3YTUMPAirzyfHrjBYXsIp2zp1RvIifB4myVqzEAecDs8/EHPwNsXOTPu3b4IbtrV2HboRSTKgddnxs8sTBaydkunidPBulCde81J0ShXicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjoZShS8C1fV2+jfxzBjhCfSbwejEjtD+Sczu4UxTpU=;
 b=INz1tH+ZiENWsXYXf34FuwDA0N0w5ncuRlmR3anW0Q4ywqxaiDXtEHcfAVPjprtZVOjWngAuCKXF7wKqjOZtCAyaySL+poKrrtOYglacEzw2VHL+JgDjTZocQn7JFB8B/iFcRiGQPYgjOqsvOViw2PioszXv/r/5apgDIc8Qt/8KdjhwbFv3toso5Zpf2zoU5mxmGFlTyYeP1ILmoE7bitjVMcts1Lhb+Oa+bJH4lzBPr5AyaUSrE5Z6rKYdFWjTSghvMXTIansZ65L4sB5hJljm35eLPgAvFdDnk9S6R5rAU4YVgeOCpMvQKKC48zWO4GagqBsWOY/obufTbwXjow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjoZShS8C1fV2+jfxzBjhCfSbwejEjtD+Sczu4UxTpU=;
 b=RHOMWyPyqqCg5ffC4fQkzq3KGWqVFgdrp76vbNV+IXVM8jvW5Zr1W7R/fZK5vBWB7Giaa9E6dI8JLIivuXQDeIpeBjUCytjVq3sLq2rFudRsL13KkEHCXX2sY12Imx1eLhMAiCMaJCOxTYAy7ux2vJg4BTbBzLM+vUpyYRLXskI=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 MW3PR13MB4009.namprd13.prod.outlook.com (2603:10b6:303:5b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.19; Fri, 10 Nov 2023 19:08:48 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%5]) with mapi id 15.20.6977.020; Fri, 10 Nov 2023
 19:08:48 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chengen.du@canonical.com" <chengen.du@canonical.com>,
        "steved@redhat.com" <steved@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3] nfs(5): adding new mount option 'fasc'
Thread-Topic: [PATCH v3] nfs(5): adding new mount option 'fasc'
Thread-Index: AQHZ2XQWFTKcvVStg0eQgSb/ZQS8PbB0OjwAgAAlhAA=
Date:   Fri, 10 Nov 2023 19:08:47 +0000
Message-ID: <4bbbb46c1d2311143f590e57c04c7692e95c04ce.camel@hammerspace.com>
References: <20230828055324.21408-1-chengen.du@canonical.com>
         <6b4e6cd5-5711-4033-b813-2f8048c35921@redhat.com>
In-Reply-To: <6b4e6cd5-5711-4033-b813-2f8048c35921@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|MW3PR13MB4009:EE_
x-ms-office365-filtering-correlation-id: 832348bb-c1f9-4aa7-e855-08dbe22077cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7kRDKrtXk8iDNN3O87mfCZRGucCtCg4w+Wh0dBFeFQ8sFoYbPsYOMB8x8X3JwabWFQ4WfESvpVrTv+vBol706LYOQhLCeQFrqQ9XTuIWoCChUVQeMUyQ59o4gqcHSlYJ+8YtuZNxQqz1+dwgDlPEa0F9IDqCDVgrtN/Erv8Lk+vMT+9HNb3/Ic6/B62r+IIwWjCJSBlypgbzvvCb0FTGPeS8iA4Ro2H6PNVZbO7L4J69xv+4NrhOSjfOXJNlLYzU4rODWjvuzlyyYmh8mmW0aPnmeOj+O1I22SzBWQgoxZu61okxYT+WvAqMxbJKOn2+aU+yzb/E47Z9dRszKEybCwUP6bFUsk1x1it9F/y686jwRBJDOXu2hA7qkdylhwo1n97fqQhKToQz6QAsvs5oAvroRkKAB1BnoNhNldiHaTzzDrEEXpam/pxovS/ALWPtoMo1erjsc2fFAujjGbgizQlS6fC8wAMk6sOffFkF6x6mPNTpv0cnDJH7B1nFt1ph438w3fLJBeRigZnLunOXMr2iJXv7ANIR3w+6irgjj5gl04nSMomTFCLet3NJLE8n8wBjdOYSOBaMPUyKiTUGaFUGHUgH/rnFtKcNWu001sxYkVStUvW8dxeOcaTC3hQ9JmvvgaSgVHr3K286PvKThyicedqW68sNIqo0P/uOYwU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39840400004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(8936002)(5660300002)(38070700009)(66446008)(66946007)(66476007)(76116006)(66556008)(64756008)(4326008)(8676002)(316002)(110136005)(91956017)(41300700001)(2616005)(83380400001)(38100700002)(4001150100001)(86362001)(122000001)(6506007)(71200400001)(36756003)(2906002)(6512007)(53546011)(4744005)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djMrVW4wVi9IUFpmdHRNeENiQW8rRnZsK0h1RVZjQXFVRnRWWGtLYlg5NHBa?=
 =?utf-8?B?N25SSndBT0FMc1E5SG5yU0crVGx2N0xHT2dHb3VkdFptSkFjY0NyL0tuOHJx?=
 =?utf-8?B?YlF3aFJSdlFwUnRMdkw1Yzk2b1lReTlmcjdkZkl6Q0ZkdmFmSzJ4RHRoYzU1?=
 =?utf-8?B?aTArN1c3TjUybWthdWhoRTRYbEk1cnRBUmd4YjQ3YmdCSHFsTjlFRUhTZURX?=
 =?utf-8?B?dkk3eGw2Smkxb3BXUW1MVEZMRWdHUmZzOFVsQkJBa3hiZVlPRDlvcWFENk15?=
 =?utf-8?B?REw3T3kwcW1CajI1VkJDZ3ora2hHMzVCMWxUaFQ0RlQzNlE0dTdYeTUvWC9R?=
 =?utf-8?B?ZlhadEY1OWhXOWJtcEgzTklURVNmTS9weTU3aDFYUzZDeTBtUENVMFdoU1RI?=
 =?utf-8?B?em1xRG0vZWVweStDZ2M3TDdrc3VMR3drSHEvT1BaQU50M2lvUzZqUllUdWJa?=
 =?utf-8?B?VjNCK0Y5SjJVQm9BaUlUY2lDWHVaa0JpZnM1bDBaRU1YRzJBMmNGMFh0VDF0?=
 =?utf-8?B?RGUyQ21qTUc3cDBleEsxWUJFSDRLbDJ1K3BNRXl4a25ReGlra21GNVhWVUZs?=
 =?utf-8?B?TExNSHZydlRtc2RUY29wK1AybWJyNHdsU1ZoeUwrZVFSRUhCQ042dDliSnp5?=
 =?utf-8?B?OFB5ditqQXNmQkZtbGNwR1o1dHlSQkRialFBVWMwRzZTUEZDTXZ5SElwcFc3?=
 =?utf-8?B?QlI5RUVYQUFMWDlFUlJWRDVuU1ZONUNtS3lVd2NQYjVBd2VDc0FrR1R4UVlv?=
 =?utf-8?B?OWJNbGN5dkxsOHgvUmVXemlUVndCWkNkRDh2Vk5iU0wvbWJEQWg5dEl1eHFj?=
 =?utf-8?B?NVJZOVpXNnEybDlTWFAwUWUxK3pxSFdSY2huemVHUVVrR1dqTXlZZGpIZWll?=
 =?utf-8?B?QjAwNVcvNnNNUjZkNlNTc2NteFYvZlpMd1pMY0hhK01UNlNmQ1BWVTVxTE1H?=
 =?utf-8?B?NlBFU1ovM3VGM2JPYlpMQXpPNnFwUm01SEJLWUNyYWxpS1VDazAwbFRncUEr?=
 =?utf-8?B?TmlLZWxwL2k5bERpeXY2MjFEQlJBbDdZY3pqVlArUzFMOUVocFBIenVYREkw?=
 =?utf-8?B?WnZwaWFlRFdnTTlwa053ajBhc3pjZHZvcllwbTg1Q285ckpEcmtJSklHQ1dw?=
 =?utf-8?B?OTRqRFZoK3BTNFR6SDRNL0ZYRG1wbnJpbWtOWHpOWDBZYnduL3V0anB6Mmoy?=
 =?utf-8?B?TG1xUE5sK2htMFd2SHZKRC82SkJBU1QzbzJIa2cwUi9uL3NsbGh5dzRiMFZa?=
 =?utf-8?B?TkcyUkdlYzkvYk9qK1ozbEFqUjdJK1owSWRQVis1d2pFYldodGFMM2xyck1m?=
 =?utf-8?B?ZStXVk1jWEFLMjJaakFEdkZZMnB0SWJVUFh2d3FWMkdXcy9lZnJqSGdkaHZ3?=
 =?utf-8?B?NzhuUVJrakRCZ2ZJaGVYQ2o0dzZuRHR1ZDVUSzRLUndBS1VYd3p6UnFyMnlN?=
 =?utf-8?B?KzBtUHVyV1FoZFdTbTM2L1hDT1NyVmRQdHN0ekl5SXlWWGFIeGNPVkVVMndq?=
 =?utf-8?B?UzVEWHI1NGhib1V4cm9wclNFY0xEbGdDc0FQWlFUNXRjSDVjbnU2RTR0UmlO?=
 =?utf-8?B?dkRJQnBiV0VwQnVLOE5zZDZJYU5TUzRHMWNTaFJzNDJDdzVwdjRqZ0hTZ1ps?=
 =?utf-8?B?TGNxK1ZtcEZOdnlpRmZBMjJUWm5ZT3l6K1VmZzRYeUhMNkFObXdzVWFjU0NO?=
 =?utf-8?B?MWFxbG1lSGg5cU5NRGl4LzdHbTBrV2hJNlc4UlU4am9PSlBYVjhvd1hCQnRl?=
 =?utf-8?B?TDQ1ZUJrODNObjFOaGorZFMwOHJUL2liSTE3UHdPZVZ5RUFGckU5dEJyd0Zy?=
 =?utf-8?B?V095blQ4UjVNckpYaDl6TERiRWhqQ3dycmk4dVlOcVVqQ3g2WkVQMW1FekZU?=
 =?utf-8?B?bWRVQklaQUNOWkxQbHYxSXpIbHdIVVZhaHVxLzR1bVJPa1Rvc3lPSHJrOHc4?=
 =?utf-8?B?WGhPd1B6TUl4K1lTU1NPajIyMW5xRmZ5UmZIbHFNb3JodVNISFZHL0xLa2xG?=
 =?utf-8?B?andMTEtUeVFJeUNzRXM3MDNxR2xSVXBPMllWcDY1WnFrTjNVMnJpTDRxRzZG?=
 =?utf-8?B?QkZjaERZVnF5QzdpV01pNklBTVNoZkVJTUQvUWtvbVp2am5vWW5MN0p2NDlt?=
 =?utf-8?B?SkR6bENOai8zOFQvdzY0NkNSNThDd2drZ1d2c0ZaVUEyci8zbUx6clVXdzRC?=
 =?utf-8?B?KzA3eUg0VlUrWWZzb205R2xVMmxoL25CMVJybjdWOFhhcjlHdmdzMTJPb29y?=
 =?utf-8?B?a2hHRjhQZnE5N3Q4VjIvRXRRcjlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F317C2CE899D2346929D503B4EE281E4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832348bb-c1f9-4aa7-e855-08dbe22077cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:08:47.9683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Iez57F9zU/p4tfiLDmo8V6L8NPfSNyY8GcYxgzy3WGT2qnIEwPUNBHQyUYomVn/OkKXcGW6hWw/akmaZPiy3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIzLTExLTEwIGF0IDExOjU0IC0wNTAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiBIZWxsbywNCj4gDQo+IE15IGFwb2xvZ2llcyBvbiB0aGlzIGRlbGF5Li4uDQo+IA0KPiBPbiA4
LzI4LzIzIDE6NTMgQU0sIENoZW5nZW4gRHUgd3JvdGU6DQo+ID4gQWRkIGFuIG9wdGlvbiB0aGF0
IHRyaWdnZXJzIHRoZSBjbGVhcmluZyBvZiB0aGUgZmlsZQ0KPiA+IGFjY2VzcyBjYWNoZSBhcyBz
b29uIGFzIHRoZSBjYWNoZSB0aW1lc3RhbXAgYmVjb21lcw0KPiA+IG9sZGVyIHRoYW4gdGhlIHVz
ZXIncyBsb2dpbiB0aW1lLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENoZW5nZW4gRHUgPGNo
ZW5nZW4uZHVAY2Fub25pY2FsLmNvbT4NCj4gT24gYSA2LjctcmMwIGtlcm5lbCBJJ20gZ2V0dGlu
ZyAibmZzOiBVbmtub3duIHBhcmFtZXRlciAnZmFzYyciDQo+IGVycm9yLi4uIHdhcyB0aGlzIG5l
dmVyIGltcGxlbWVudGVkPw0KPiANCg0KTm8uIFRoZXJlIGFyZSBubyBwbGFucyB0byBhZGQgYW55
IG1vdW50IHBhcmFtZXRlcnMgZm9yIHRoaXMNCmZ1bmN0aW9uYWxpdHkuDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
