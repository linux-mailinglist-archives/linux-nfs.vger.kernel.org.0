Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CB554C7F3
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 13:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiFOLzQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 07:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbiFOLzQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 07:55:16 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2100.outbound.protection.outlook.com [40.107.100.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC349E00;
        Wed, 15 Jun 2022 04:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrXP1USNKvBZs4j9tovP2G862yv93w+/hqhek2DpZq8U/C5w6gQ/mtCGDE2D2c6qb0XW9tCHj6YcHHgEAY2Hi6F8WxzMl7m9bEqKOFW4sZint4VuPjRlTc71g6LQLrb/VFfzvMbYgMYWc2V6no1e/jJbD4I12A5segLraJNnz68eQudqg77vpSsIERtksFzbo1YVnk3xp4y1M5sdwPd2Swthwnda6tT3QM0vQKfaVShNxdWYy0aeiSrhxdUzc6gQLVd9FEIJE2MBg4qrehtDLcho1XYt2RTCmal0J4wka3gO7dz2V3of2nzM//Lv6P497F0ZxpiCF0uyoSFfbT/uFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys0RxhfaEzWX3vL80XeyNkHPVQ2d9YFO/Qs8n2WsAeE=;
 b=SZfwEakjUocDZhYXtsrs5kIFucXBpnWlTA4zuJdAV0zNOgJ0/CLV7+KfPXDPMWidmbkdyZL3K4cRGfODELKGxbkdpiUtlmvWaB1J3FbJ6mXM1c5ZJGRBmFuzHjj6lTBAAPA03lH2b+7uc93noejrDTjweVfLx8Nk+evKKV2/mqZMdP6rGj6qplOatcVYqETkpnBm11AXGAKotCucg7VRFghnVd85/U59+ahHgAd3Br1x7wBSXopSvdb1veL6T1Rdji2YBYjbz3swssgY3Vlsd5b0/UdqCR7n231vhNM6xSthXkB280EOxsgWQrMuw9AGbmEKjT/2RuI0MR/l9PmU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys0RxhfaEzWX3vL80XeyNkHPVQ2d9YFO/Qs8n2WsAeE=;
 b=cHLsFGWZNmXnJTLqbQ1mfPrfM/RVIknu/2HqA7GmeHjgDeoRC6bDoRfb65v2l3i7cZttPhsed23yhhW2HoWJx0pKv1IX0BlAXTCjMSHAskcU6a7zHLDcuHzKaJNhXxUtC1GxP/g0TyKFvQWj4A5M4XGtEFdolXm28mnDdGU+xgU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4603.namprd13.prod.outlook.com (2603:10b6:610:c3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6; Wed, 15 Jun
 2022 11:55:08 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7%7]) with mapi id 15.20.5353.013; Wed, 15 Jun 2022
 11:55:08 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "chenxiaosong2@huawei.com" <chenxiaosong2@huawei.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH -next,v2] NFS: report and clear ENOSPC/EFBIG/EDQUOT
 writeback error on close() file
Thread-Topic: [PATCH -next,v2] NFS: report and clear ENOSPC/EFBIG/EDQUOT
 writeback error on close() file
Thread-Index: AQHYgAGRBdlVDWmn/0KFB/DfAtVV6a1PT16AgABgvYCAAK1lgA==
Date:   Wed, 15 Jun 2022 11:55:08 +0000
Message-ID: <6d2fb44131b4ec713e81676f26ca7ba086af4ee4.camel@hammerspace.com>
References: <20220614152817.271507-1-chenxiaosong2@huawei.com>
         <806ae30d4d53886e7d394cc9abb0b2045a314f01.camel@hammerspace.com>
         <d82be232-8df4-86ff-ade5-4b9864e9cf40@huawei.com>
In-Reply-To: <d82be232-8df4-86ff-ade5-4b9864e9cf40@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cd5f5bd-7bf9-4e79-deef-08da4ec5e509
x-ms-traffictypediagnostic: CH0PR13MB4603:EE_
x-microsoft-antispam-prvs: <CH0PR13MB460399755C7E759E6C3F3C35B8AD9@CH0PR13MB4603.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9KxbXxWqR06FjxDQiAukw7XzicaDuFxSpcSmtIKpvziRO4lG2Rzd08fl8EAFJOthqUiBwYL1wD+RaZDRQKxWEpeG2FZ27KSliv+9DHfpttUpYA2IbMXToma9Z6sNdQK9QiHimNGNrERvGLLAaUCkc1jB4YWVik1Y1G5GMn0uoM0ShFIaN/zwnifT+zhxsN5JGY399B7s13HYbm0oPzZEp0N/HWgAS67YcrlRnu4P/1nMo3fu6tIO/pkqlmTWKcnjTN0UObsCmePvGMCLq3UG0hLRAi5kNHS3/J2OH/dSetsNSuo+/6+eP6Whph08gZZSUFdY8kvHsOIOi07cKfRpw2tMhFlhb/GlWIKagX+UqUSpsUk1gLd4NE8CoMRkm2/hcpyo+XjKUROhrh1qA0gxvOY3FAO6CFwp5oerHFpd1t/eoj3A/BRgBGEyXhxgmPw4tlHPhm8tdF3Z70x6Gu2gQ6SiRPuT+ZS9ImCXqFWSzdgV+qSnwdDPjJpuFnNOERfPZW+Z1YV6Jf3nK8/z7FJfYZ6Y/ALNm+JwmnS2zGYH4t+heQznOg7jNZl3c1GcQbwXmJJ4O3Ru8MetCj4afa+Y+3LUD/Mj98+a4dJkpAjYVyDxZ0JwKVvaPumC2JY8CtLC5H/LHfevqp9QN69uTnN6ZSWGHgn81WHHB8+jsdnnXlo0TMudPYmcEvQ0e3A26AV5+4qzyGQQV+rVgGOr5NgtKb2VIeCjp6v41uW1TSaatpZT2toqkBzRu/B9x2tjIbw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(346002)(39840400004)(110136005)(54906003)(8936002)(4326008)(64756008)(66446008)(66476007)(8676002)(66946007)(66556008)(76116006)(86362001)(2616005)(316002)(41300700001)(38100700002)(26005)(6512007)(6506007)(71200400001)(508600001)(122000001)(38070700005)(6486002)(2906002)(36756003)(83380400001)(5660300002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnlKbUh5Vm1LRWFwemk0WGgxM3FLcEFZY3FJaTNzTmEwbmtYL2tLWDI2M3Vn?=
 =?utf-8?B?UjNjNWVUODROT2RqdmFldkNFOTBmb3Z4a2lYKytENlBCc213eEFUR29MSkI2?=
 =?utf-8?B?ZjgwREE4dTlTMFNtSFlXYzNadWZETTdhdjg3ZjRvL3NDVng0VktDQVdrRGZH?=
 =?utf-8?B?VmhsT2l2UjZxK1EyVGEvVFV2NldRTVBmUWVQY1NlM1N2bnVQOVFQWlNCQ04v?=
 =?utf-8?B?ZjN4S0l5ZlpGMEdTRU1ibVBCVDJwYVRmK2s1YjRyYVVxbHhCcnZrZWRkR1lx?=
 =?utf-8?B?aVZ0OHoxN0FLbUx1TjJpR0RKZEs2VTF4RVhtQm5iY1lRMzErWVJEN1BMYUpP?=
 =?utf-8?B?Nm14SGhsOXh6WElJL1N4NkR6L1U1M0o4aVVjcFVmOVRWQjh1WW5VbGFlRDdq?=
 =?utf-8?B?aldvdkVXZjFtenlJUThvTXFvR0NUSldEbkpGL3Q3aloxcFF2MldlVlF1MldC?=
 =?utf-8?B?K0ZLN0NDekxZWUR1U2xTQ04xV2xjVm94U29wNEJwbklHUk1ad25RcDZYdVI2?=
 =?utf-8?B?NkJoU09lL2FnS2VJV3FxdGlCSEhla3Z4V0Qyc25Bd2drQ3poQjJpYlNVbEdB?=
 =?utf-8?B?RDFVWk9qWFZqSXRhZ2JFTHM1dVk2bWowemNlTFRLZkNMVnM0OWtpUEcrQUYy?=
 =?utf-8?B?QjZCOVExZUsxMDhuNFN0cTVtSjgvY0FRaStKL1NHeTdHWWdQVXlIOVJLQnlh?=
 =?utf-8?B?VGludk15bmZGWjRtUzVBbFUxSHpJRzhyMHN2UC9hNjFwQ0JXZ3VaTGhTVE85?=
 =?utf-8?B?eXYwZUtQU245b01VRmsybjVLU0FKTzhDaTdBVnBVTytKcHp3VHlXdGVzWUd5?=
 =?utf-8?B?TzNlblp1dENhaFBXUkpBYWRrU09KbHVWTkpiRDA3SVpYL2psUnBXOFBOUksy?=
 =?utf-8?B?akZ2ZGVtRzFkU1pMS1I0d3AxbnFDRlp1T2IzMmxpUGRkd3dPVkxPbXJLekx3?=
 =?utf-8?B?c0RUN1FnWWlPbkZsUEYzbFV5UTU2RStMRG5kUEtkZGdKaUhtcG5NOGNsZ0Yv?=
 =?utf-8?B?bzE1WTV5cGZmVjB5UVVyYzFqVnAzQk1YTkx0NmdLYjllVVRydWo4NkIyZFNy?=
 =?utf-8?B?a1NIdHBJSlRGNm04VEpNUWUyQXdsdFlBUlNsemlJSVQvcGZpdkRCMkhHekIy?=
 =?utf-8?B?TFgySUQwUzQrdlFQZmcySlNOK1h5UGkxeWFGbDJRM3E4RURBODNmWEw5TnRv?=
 =?utf-8?B?cUw3YklibjF0dG1hSUxFU1plQXp1NVVrcE05UHdOcThQZEpJNG5EN0JwbmFW?=
 =?utf-8?B?ckZ2QkpCTVJmeGYxUDdNRW9MRFkvUU83SmU1ZENlVlZ0Mld0ODNjc3M3TE5S?=
 =?utf-8?B?ekVGNXdIWHB2TzFaTys1ZFdFcUZNck9reWhoVUNOUGNXT0xyQytZZ1dNTzBj?=
 =?utf-8?B?MS9mQzBXT1NZTjJzcXUrcjNxOC93aUNhU3FlZ2s2bzFUeVZkZWs5N090aExz?=
 =?utf-8?B?TEVFd1dJeTVhRGgySll5YU1sTURNZ0JuUGd4Mm1lNlNlVGNucFJraXhNN0tv?=
 =?utf-8?B?M1lGcFNiQkwxdTh3ZjVWT1E0S29kMzFJRFBjSU1uZGZTa0hZenBBQ2FyaDFQ?=
 =?utf-8?B?S0hCVHl3cU9sQXV2Smp6Rjd4dkNuUGRSQkZObVJDRWtJSERnM2NnUks0ZnBy?=
 =?utf-8?B?bGJjekovOVhrRndGQ21ZMk5GdlJxUG9pYU45d3ZXa1ljMFpBSnAwY2w3bnpp?=
 =?utf-8?B?OVFqTjkvWVdDVnhWcTRCN0lQL3ZBL1VEQ005RHFaVmh3OEVjOFovNHlrTGV2?=
 =?utf-8?B?NTVrdXZYb0hxaGc5Vlp4Q1NVWjRrQXBRZ3BjREp6aFQ3RG92Q2Q3aDhKTEtN?=
 =?utf-8?B?MHZLRTNYN2dONFdkaUQxeXJFekI3OEU3U3BRWnQ2ZlFKSll1MG9BUlR3M0Nq?=
 =?utf-8?B?aTBPdVdjYitlelRvQ1IxbnMyT09ROU1wTEtqSDdHVmhCRVhRbzN3L3ZPRm5U?=
 =?utf-8?B?ZDFoSWxVWmhySXJmSGZYdUNpWS9aVTJIbFVwS0ZIYlFGWjRyNVZBRE9GQ2du?=
 =?utf-8?B?RGluTWQ4QVFwTWZKa2FmNHJIVm92MkJVMEtTMU9KOFllS1NVK0RZdTlhWWtB?=
 =?utf-8?B?emlJSVNVK3lVSlVQUXhwY1NsbWdieWN5ZHVHeEQ3UCsrbEdtRGJWOXJNOGJs?=
 =?utf-8?B?R2NSQ1Y0VmZTV2V4U3FFRlI5UVk5aVFoN3l4cStzUDVjeVNxdjJzdGR2TjM4?=
 =?utf-8?B?anR6dmE1d29GK2NGMTM2T1JkYU94RlMwaTlmV0JFM1hKSHFGWmhRaFQ2UlZm?=
 =?utf-8?B?WU5PWGxaMWlsK2R4ajBUd0hEbVFiNy9rRnh2d2YzbXdOOGdoNDNWUXFjQksv?=
 =?utf-8?B?QmtmajN0bG13aXcxM2dxSndWLzkyV2Q2N09mWDRpbmROeG52eENyZEFvQTg0?=
 =?utf-8?Q?qIKoWDfvrICj5dn8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7C233B1FD466E4B90DA476B7638E447@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd5f5bd-7bf9-4e79-deef-08da4ec5e509
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 11:55:08.4233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2pJsygBKW05SR3G3WC0p0tlB3WdLq1LRYEnLrYiAyTb1bqfjF6IX6JDUpFW0qbUCho4QQPn4PNaE23tlqUv+tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4603
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTA2LTE1IGF0IDA5OjM0ICswODAwLCBjaGVueGlhb3NvbmcgKEEpIHdyb3Rl
Og0KPiDlnKggMjAyMi82LzE1IDM6NDgsIFRyb25kIE15a2xlYnVzdCDlhpnpgZM6DQo+ID4gTkFD
Sy4gSG93IG1hbnkgdGltZXMgZG8gSSBoYXZlIHRvIHJlcGVhdCB0aGF0IHdlIGRvIE5PVCBjbGVh
ciB0aGUNCj4gPiBlcnJvcg0KPiA+IGxvZyBpbiBmbHVzaCgpPw0KPiA+IA0KPiANCj4gY2xvc2Uo
MikgbWFucGFnZSBkZXNjcmliZWQ6DQo+IA0KPiA+IEVOT1NQQywgRURRVU9UOiBPbiBORlMsIHRo
ZXNlIGVycm9ycyBhcmUgbm90IG5vcm1hbGx5IHJlcG9ydGVkDQo+ID4gYWdhaW5zdCB0aGUgZmly
c3Qgd3JpdGUgd2hpY2ggZXhjZWVkcyB0aGUgYXZhaWxhYmxlIHN0b3JhZ2Ugc3BhY2UsDQo+ID4g
YnV0IGluc3RlYWQgYWdhaW5zdCBhIHN1YnNlcXVlbnQgd3JpdGUoMiksIGZzeW5jKDIpLCBvciBj
bG9zZSgyKS4NCj4gDQo+ID4gQcKgIGNhcmVmdWwgcHJvZ3JhbW1lciB3aWxsIGNoZWNrIHRoZSBy
ZXR1cm4gdmFsdWUgb2YgY2xvc2UoKSwgc2luY2UNCj4gPiBpdCBpcyBxdWl0ZSBwb3NzaWJsZSB0
aGF0IGVycm9ycyBvbiBhIHByZXZpb3VzIHdyaXRlKDIpIG9wZXJhdGlvbg0KPiA+IGFyZQ0KPiA+
IHJlcG9ydGVkIG9ubHkgb24gdGhlIGZpbmFsIGNsb3NlKCkgdGhhdCByZWxlYXNlcyB0aGUgb3Bl
biBmaWxlDQo+ID4gZGVzY3JpcHRpb24uwqAgRmFpbGluZyB0byBjaGVjayB0aGUgcmV0dXJuIHZh
bHVlIHdoZW4gY2xvc2luZyBhIGZpbGUNCj4gPiBtYXkgbGVhZCB0byBzaWxlbnQgbG9zcyBvZiBk
YXRhLsKgIFRoaXMgY2FuIGVzcGVjaWFsbHkgYmUgb2JzZXJ2ZWQgDQo+ID4gd2l0aCBORlMgYW5k
IHdpdGggZGlzayBxdW90YS4NCj4gDQo+IHdyaXRlKDIpIG1hbnBhZ2UgZGVzY3JpYmVkOg0KPiAN
Cj4gPiBTaW5jZSBMaW51eCA0LjEzLCBlcnJvcnMgZnJvbSB3cml0ZS1iYWNrIGNvbWUgd2l0aCBh
IHByb21pc2UgdGhhdA0KPiA+IHRoZXkNCj4gPiBtYXkgYmUgcmVwb3J0ZWQgYnkgc3Vic2VxdWVu
dC7CoCB3cml0ZSgyKSByZXF1ZXN0cywgYW5kIHdpbGwgYmUNCj4gPiByZXBvcnRlZCBieSBhIHN1
YnNlcXVlbnQgZnN5bmMoMikgKHdoZXRoZXIgb3Igbm90IHRoZXkgd2VyZSBhbHNvDQo+ID4gcmVw
b3J0ZWQgYnkgd3JpdGUoMikpLg0KPiANCj4gQm90aCBjbG9zZSgyKSBhbmQgd3JpdGUoMikgbWFu
cGFnZSBkZXNjcmliZWQ6IHJlcG9ydCB3cml0ZWJhY2sgZXJyb3IgDQo+IChub3QgY2xlYXIgZXJy
b3IpLCBlc3BlY2lhbGx5IHRoZSB3cml0ZSgyKSBtYW5wYWdlIGRlc2NyaWJlZDogd2lsbCBiZQ0K
PiByZXBvcnRlZCBieSBhIHN1YnNlcXVlbnQgZnN5bmMoMikgd2hldGhlciBvciBub3QgdGhleSB3
ZXJlIGFsc28NCj4gcmVwb3J0ZWQgDQo+IGJ5IHdyaXRlKDIpLg0KPiANCj4gSWYgRU5PU1BDL0VG
QklHL0VEUVVPVCB3cml0ZWJhY2sgZXJyb3IgY2FuIGJlIGNsZWFyZWQgb24gd3JpdGUoKSwNCj4g
bWF5YmUgDQo+IGl0IGlzIGJldHRlciB0byBiZSBjbGVhcmVkIG9uIGNsb3NlKCkgaW5zdGVhZCBv
ZiBzYXZpbmcgdGhlIGVycm9yIGZvcg0KPiBuZXh0IG9wZW4oKS4NCg0KV2UndmUgYWxyZWFkeSBo
YWQgdGhpcyBkaXNjdXNzaW9uLiBJJ20gbm90IG1ha2luZyBhbnkgZXhjZXB0aW9ucyBmb3INCk5G
UyB0byBydWxlcyB0aGF0IGFwcGx5IHRvIGFsbCBmaWxlc3lzdGVtcy4NCg0KSWYgeW91IHdhbnQg
dGhlIHJ1bGVzIHRvIGNoYW5nZSwgdGhlbiB5b3UgbmVlZCB0byB0YWxrIHRvIHRoZSBlbnRpcmUN
CmZpbGVzeXN0ZW0gY29tbXVuaXR5IGFuZCBnZXQgdGhlbSB0byBhY2NlcHQgdGhhdCB0aGUgVkZT
IGxldmVsDQppbXBsZW1lbnRhdGlvbiBvZiBlcnJvciBoYW5kbGluZyBpcyBpbmNvcnJlY3QuDQoN
ClRoYXQncyBteSBmaW5hbCB3b3JkIG9uIHRoaXMgc3ViamVjdC4NCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
