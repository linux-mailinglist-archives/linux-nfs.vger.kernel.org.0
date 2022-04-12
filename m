Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7234FE0DB
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Apr 2022 14:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354434AbiDLMu5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355282AbiDLMsJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 08:48:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2137.outbound.protection.outlook.com [40.107.236.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CB532C
        for <linux-nfs@vger.kernel.org>; Tue, 12 Apr 2022 05:16:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnYTC1yZ9fCRoEGoCv9Kz7TV/fT0U8jVUWzFrUkCU7Ou8q26dtFNE8IsS3WVuoEDqeZ5sd//uzncYZ8JMelrhwToSlb6lrqOXzGdXeZCjRgI/CdkWeLHk41yUzCar2jUUaa6ZXRojzVdzZcRQqXuw3X8/O6cQKHK7g7DRDwUaSsNICxzNlJrAI6w/Fa5xbgfoZ2dO/KL0ePe9iXdIyVKMBOEDFpaGHgao+yKyZathef2urho0oqz+o1mUivXY3XWTUVwbl+RW/qtEwzV6bIYlm6qC4lQ4EHLlR0J9B6Itjy3EqDH9swwc9HpZ7SMF540yd7FBZ6zFQLEIFrFHC3JPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFtj6/sELI8CpJKpr15yrq6nYrUMXJAxGr0Vi3Ba5BQ=;
 b=mR+aMEfM8XZTRu+xTdJ5V5w9hTB+cJsvmsPQaKSYMLWvoopPyqKqUcQzs4BSvEj1T8YO0C2cJmb444vHe6Paooth8Cer++4Rlvsh/CY2XOfQK+BcdEhHx34Q/7GNpi/hr7mojDRiclwXNWMjOES5zTDGDXbv3000zT/f9dEnUumwH/0JiqUH9+POnzoVSix/5E6YEUPBsrpcXNkf+xkbqrQV7Kw7mYoWKOb+c2rJbatrDLAvflyBd8YRGxiPOd0ifcnJ7y5uPgSKkHozCrrsIHqfFW91qwb87TVI8EoPM32xem0pDEJknI1chLvQQBD/tfJ2SlekW07vgkKfzq4m1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFtj6/sELI8CpJKpr15yrq6nYrUMXJAxGr0Vi3Ba5BQ=;
 b=d5DXM332Qyh/pvrbZdRscTXXXz+sg0MRpEwm5rJHYcAWZgrHEu+bJ8MUAK72HNmDBVdcVnElG6nDhDhZ2+6/y76JKhKNf/mTOxmUtkLAsYx+mhj5AWWbvV26U8dsnzs28RaCphLtrIU1W65p489nNJW3XxFeCseAAEpqaK2hVnM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN6PR13MB1313.namprd13.prod.outlook.com (2603:10b6:404:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 12 Apr
 2022 12:16:23 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 12:16:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chenxiaosong2@huawei.com" <chenxiaosong2@huawei.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "smayhew@redhat.com" <smayhew@redhat.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH v2 3/5] NFS: Don't report ENOSPC write errors twice
Thread-Topic: [PATCH v2 3/5] NFS: Don't report ENOSPC write errors twice
Thread-Index: AQHYTezLj+OkZz+E9kqzcWZ6/Qb7sazr0CEAgABiQwA=
Date:   Tue, 12 Apr 2022 12:16:23 +0000
Message-ID: <5fde4fd533805990cfbd0f23964db786cfda2cd7.camel@hammerspace.com>
References: <20220411213346.762302-1-trondmy@kernel.org>
         <20220411213346.762302-2-trondmy@kernel.org>
         <20220411213346.762302-3-trondmy@kernel.org>
         <20220411213346.762302-4-trondmy@kernel.org>
         <a2babe9f-e85e-3c72-9132-35aa6ae3888b@huawei.com>
In-Reply-To: <a2babe9f-e85e-3c72-9132-35aa6ae3888b@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8373eff-378e-40cd-b875-08da1c7e42bd
x-ms-traffictypediagnostic: BN6PR13MB1313:EE_
x-microsoft-antispam-prvs: <BN6PR13MB1313D5920B66376A67A91F7BB8ED9@BN6PR13MB1313.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kyx/defWGtVbvt0NooxU+EPqtqIfYdAXX6z3LgTkpaZJ1viHwWbbJ6eZNBF4HO41td4eNGgO0tg6CTwpIJ05aH6PQEiIgnJREcJn4behqJwljahP0T4cK5FtCdtWbBDrmGtVdO2m40TkD1e5HTG3T3C8KNt2uVVyt8ctJUMfjoHs0z5wnBn+Fa7+8/rcc+Lbbl1XMfusegpj6oyOU19euFtZAXkjqHCLMmzrWQKIQhbceUH5uucl2lc2iHQ77UdHjCZdbGcJTLzdWrakGBBPLyviF2/5a5LQIquaRl6KWqjOBx89yfz9rb1ApLpCiPQQrGdguK5zTLSfDaiX288cC+QIAnuHBofGbe8D54b4mEukFIhXzFXI7mXLTdX1O1fut9ea1E3R3lhmFbS8fxbuEdfLBpfVN+JFXQ5bjpQFj0o8zwxTGevdyjKaZ2wPpeIRxbjyI2Dqd6ZMWXuekOt24ApsqXci82XIcbj6nbgRY0x5+0q8Ro0cK3+Va8rBsF57/9ltjUe1exoCI2Ei313I2v/Tlx1iVK+tTQutsE7BYsRdjX91rBe1pAcANgR4nZutBdNF18/irJQsfo78T/lT/E6qMVtFt0dqq6Bdum3ZPKWRd3rtUCQ9mlLylkNH0H/NOqEPnLZ+DJv7bYtZsT8kwRx6Snygc93FSerF2avhKGjiW1ybhzd/4+r9fthVvuFeLpqds0ngCjR4M1JhBnyLN+VhzBOFrNxDzD5TI5DdeicruPkaLFjY1JgP7/YHTLT/gD/tN4wAFZvR2qdrqAfeZsvUfQELlfv4GokpjGdpkC0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(4326008)(6512007)(66476007)(76116006)(316002)(26005)(186003)(66946007)(66556008)(66446008)(71200400001)(64756008)(86362001)(6486002)(966005)(110136005)(54906003)(122000001)(83380400001)(8676002)(38070700005)(508600001)(2616005)(38100700002)(36756003)(8936002)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWg0eTBwUEVuZEV0NTFMd2NJV04ybGxtdEhhTXFjT2UrVXBERERUWXJoWE0x?=
 =?utf-8?B?NFRuT3k1emFjZGJBMWphaGMxZGZVV0l0aVM2a3p3WVFLT01EKzJYcWZVQnNF?=
 =?utf-8?B?aHpGYWFCbFY2WUljS2hkT1hMYjhHdXJEM2pPZEM0L0RGbHF0SURjaittbjJL?=
 =?utf-8?B?Rjl0UFhCVTRqN2lhdDBoRDJyaGYzZ0lselZzMGdPZUQ4aXBKQ1ZDN3J2YkFN?=
 =?utf-8?B?Y2VmU09ya0N1MVZFd2dpUWNFU1Q4WllGYXBJYkYvb3dUTTZMU0dqd3dBUzV2?=
 =?utf-8?B?eVhrWEJwUFZxcmpvQzcyOTJmdnJBa3dvSDFwRzc1dE9yeDVPT1lTZHNzK3ZT?=
 =?utf-8?B?dlExVmdlS3BvWWx5RGRQMVNReHdoTEY5d2xqMkVwYUlJSitpRlZ4aWhvMUV4?=
 =?utf-8?B?cDBxWlpQU2lCVzhkSk9BcVQyV0FJL1pTS1BobFZqVkJYNGNDSi8xVEJPVFpY?=
 =?utf-8?B?S0t1T1J6cU9jVEdQMFJ1ZndZcFZHWlg0U0lQVG1TNkkwMXp0N292M0ErRENC?=
 =?utf-8?B?ZW9YcEZmb05NdmQ1b3JyY0pCaFNXclE1SGVXQjZWZ1h4Y25XVWVIb0pUQkZk?=
 =?utf-8?B?djVPaWFPOHlDMDdpaVZpTTRlU3R1Ynh5RjlxQno5cWhNWWxGRnh5VnRibklo?=
 =?utf-8?B?Y2RTSGJ3TzcydW8rY1NRRFB5ekoyc1ZmYnJSMEtjZzlZaUlCdnY4Z1hzSlZw?=
 =?utf-8?B?Y1RsK05GUkNMTlVTZ2tiejg1MFhnWnlTcjNCazFpb24vSE81RmZzZ2xyYVd0?=
 =?utf-8?B?a3NJbXZHd0NsRXNVTHI0eHpKb29qZFpsSTVlQ09uOGhTQmhPK05YRDExdTRZ?=
 =?utf-8?B?cmdsZUJDUTdXVElobjdDdSt3eXJRNi9HdHg2QnMrMVhmcmVzS2ptSm4yWGNV?=
 =?utf-8?B?YnIyT2JjS3JWNE1uWkFBYzU5VkJabUN5SDdsbnFaVmpwdDBhNjFXRCtqcUdi?=
 =?utf-8?B?cmV0bzJ3WFBITW1yT3YrZVdHTTY1Sk5QK0c5aFZiQWtpMDFmaGNQS0tCQXVW?=
 =?utf-8?B?UEtrakh2aEJ5MkpSeTRia2pTVC9tSmtuQ3IzZHh5T2VjTjJ6cmEzVndIVnkv?=
 =?utf-8?B?bkJ3ZzFCTXFEUUJ0bzU3ZFE5V1VKbk05WkFSYS9rbFNQNlJYVlRraWFreldR?=
 =?utf-8?B?V2pIVHFGU0VXL1F2MGJ1TUZKQlZUc1hiREx0NFJ2WlkrTFhDRU5UeDhlODZi?=
 =?utf-8?B?RnlxZ3RuS2xtK1dnNHRNUCtuZS9Va2hMT29hQWc1VFlaSW1GTUZWeGZMOVRz?=
 =?utf-8?B?dWRSMXYyY3lRbFhUcmlRSVdkV2ZCemQ0eGtZN3JvblovS28rRUdWNmticmFU?=
 =?utf-8?B?dy9qWXVBcWhMdjFhZ3ZOTWN5MTF5SXVqMlJ4L2NPQjE1dXJ4VkpyV3BtZWsz?=
 =?utf-8?B?dUZLOUNZaDBJOWVLd1RteElhMjlWamROejUwWi94VXFDM2pKV1ROSVM4aHNr?=
 =?utf-8?B?THkyYTZoZGJxWDhtbE93Wll1c1B4VWwwOHVmdldiVFIxMFQ4b2VpV3JJam9D?=
 =?utf-8?B?MlcrbXVLUU90dFRpUUFvcTVSNUMrNk9PMGV3UktxWStTZnlremhCdk5ac3JF?=
 =?utf-8?B?T3hFWDdtR0dUUGN1VkpxdE9pVEhnZTFGT3Jhd1A3YXA4TzVFMTUvVFpqck4x?=
 =?utf-8?B?RHZWb09qejZ0bDNQc2p5SmNCbDVhSXpVSDdXTTNHR05tYWRYM29kT0pnaVEw?=
 =?utf-8?B?dWNlNDhmNTYyRWV6bW0ybWxVMDZsSDBNWHN3bE55NUtEdkdRVVZzMEljQThr?=
 =?utf-8?B?bzBTeFYyQy9FQXhyQWRKL3B1dUVaS2ZYUFNlNUFwZHZDOHNVOVY1djUwV3l2?=
 =?utf-8?B?THQwSHlvbkIwMFFaK1d4NUUreHl2THM2ZjE0anBsOVdUUnN4WkIzRDdVUTFo?=
 =?utf-8?B?dEt6QmEvQjk1Uy91T3lxZ1JVSHh0d1g5OVZSdTQ2Tk1LZ29RYU9WdWI1eHdG?=
 =?utf-8?B?WlQ3a09waFhEV0E0aWIwZmd5K29WSy9mbDhvekxac1VmY0N1UHhTUTI4K0dh?=
 =?utf-8?B?Q1BCOVJucnNEL3U3RzJhdWFxaDArK2dJZUl2bXJnakErdXVLak1BTk4wOHpN?=
 =?utf-8?B?ZStPRUdCNWx5ajdobDBraUZUQnljRUVoclltZndadnNJNXhwS3ZUMEN5UVRH?=
 =?utf-8?B?NmZlOXh4VHI4cG5ad3d5cklNMno3cUhKamFxcUZQMW0vbUduYlFFNFJabEJY?=
 =?utf-8?B?NlFWbHBsTlVwWURzYnFuRHJURzhpSTJkSCszbEpZYmNLMVEzcWNvbXB3T3ZU?=
 =?utf-8?B?aEhtWkJiVDMzY3E4MU9FY3NlemUvbStsM0tMRGFBWDlkdlVkai9BQ2w1VlhN?=
 =?utf-8?B?dkNaWlVLaHdmMC8xSk1VaCtMamt3alc0UWNQZ2lESkF3OVhIRlNoS055WGJM?=
 =?utf-8?Q?/JrOpHdAbXSZEE1M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C93240B18A90B4C8C4499BA45366202@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8373eff-378e-40cd-b875-08da1c7e42bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 12:16:23.6127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w5RqwMN2Uj7zndXreCOscAYCOE/S6w+TJQwShs5pZxF6tqWqgCzUaXl4GNUl6RSfCdwDy52dWngUGbDo/c6Fhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTEyIGF0IDE0OjI0ICswODAwLCBjaGVueGlhb3NvbmcgKEEpIHdyb3Rl
Og0KPiDlnKggMjAyMi80LzEyIDU6MzMsIHRyb25kbXlAa2VybmVsLm9yZ8Kg5YaZ6YGTOg0KPiA+
IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4N
Cj4gPiANCj4gPiBBbnkgZXJyb3JzIHJlcG9ydGVkIGJ5IHRoZSB3cml0ZSgpIHN5c3RlbSBjYWxs
IG5lZWQgdG8gYmUgY2xlYXJlZA0KPiA+IGZyb20NCj4gPiB0aGUgZmlsZSBkZXNjcmlwdG9yJ3Mg
ZXJyb3IgdHJhY2tpbmcuIFRoZSBjdXJyZW50IGNhbGwgdG8NCj4gPiBuZnNfd2JfYWxsKCkNCj4g
PiBjYXVzZXMgdGhlIGVycm9yIHRvIGJlIHJlcG9ydGVkLCBidXQgc2luY2UgaXQgZG9lc24ndCBj
YWxsDQo+ID4gZmlsZV9jaGVja19hbmRfYWR2YW5jZV93Yl9lcnIoKSwgd2UgY2FuIGVuZCB1cCBy
ZXBvcnRpbmcgdGhlIHNhbWUNCj4gPiBlcnJvcg0KPiA+IGEgc2Vjb25kIHRpbWUgd2hlbiB0aGUg
YXBwbGljYXRpb24gY2FsbHMgZnN5bmMoKS4NCj4gPiANCj4gPiBOb3RlIHRoYXQgc2luY2UgTGlu
dXggNC4xMywgdGhlIHJ1bGUgaXMgdGhhdCBFSU8gbWF5IGJlIHJlcG9ydGVkDQo+ID4gZm9yDQo+
ID4gd3JpdGUoKSwgYnV0IGl0IG11c3QgYmUgcmVwb3J0ZWQgYnkgYSBzdWJzZXF1ZW50IGZzeW5j
KCksIHNvIGxldCdzDQo+ID4ganVzdA0KPiA+IGRyb3AgcmVwb3J0aW5nIGl0IGluIHdyaXRlLg0K
PiA+IA0KPiA+IFRoZSBjaGVjayBmb3IgbmZzX2N0eF9rZXlfdG9fZXhwaXJlKCkgaXMganVzdCBh
IGR1cGxpY2F0ZSB0byB0aGUNCj4gPiBvbmUNCj4gPiBhbHJlYWR5IGluIG5mc193cml0ZV9lbmQo
KSwgc28gbGV0J3MgZHJvcCB0aGF0IHRvby4NCj4gPiANCj4gPiBSZXBvcnRlZC1ieTogQ2hlblhp
YW9Tb25nIDxjaGVueGlhb3NvbmcyQGh1YXdlaS5jb20+DQo+ID4gRml4ZXM6IGNlMzY4NTM2ZGQ2
MSAoIm5mczogbmZzX2ZpbGVfd3JpdGUoKSBzaG91bGQgY2hlY2sgZm9yDQo+ID4gd3JpdGViYWNr
IGVycm9ycyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IC0tLQ0KPiA+IMKgIGZzL25mcy9maWxlLmMgfCAz
MyArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiDCoCAxIGZpbGUgY2hhbmdl
ZCwgMTMgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gIyAxLiB3YiBl
cnJvciBtZWNoYW5pc20gb2Ygb3RoZXIgZmlsZXN5c3RlbQ0KPiANCj4gT3RoZXIgZmlsZXN5c3Rl
bSBvbmx5IGNsZWFyIHRoZSB3YiBlcnJvciB3aGVuIGNhbGxpbmcgZnN5bmMoKSwgYXN5bmMgDQo+
IHdyaXRlIHdpbGwgbm90IGNsZWFyIHRoZSB3YiBlcnJvci4NCj4gDQo+IA0KPiAjIDIuIHN0aWxs
IHJlcG9ydCB1bmV4cGVjdGVkIGVycm9yIC4uLiBhZ2Fpbg0KPiANCj4gQWZ0ZXIgbWVyZ2luZyB0
aGlzIHBhdGNoc2V0KDUgcGF0Y2hlcyksIHNlY29uZCBgZGRgIG9mIHRoZSBmb2xsb3dpbmcgDQo+
IHJlcHJvZHVjZXIgd2lsbCBzdGlsbCByZXBvcnQgdW5leHBlY3RlZCBlcnJvcjogTm8gc3BhY2Ug
bGVmdCBvbg0KPiBkZXZpY2UuDQo+IA0KPiBSZXByb2R1Y2VyOg0KPiDCoMKgwqDCoMKgwqDCoMKg
IG5mcyBzZXJ2ZXLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqAgbmZzIGNsaWVu
dA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tLS0tLQ0KPiDCoCAjIE5vIHNwYWNlIGxlZnQgb24gc2Vy
dmVywqDCoMKgIHwNCj4gwqAgZmFsbG9jYXRlIC1sIDEwMEcgL3N2ci9ub3NwYyB8DQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IG1vdW50IC10IG5mcyAkbmZzX3NlcnZlcl9pcDovIC9tbnQNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgIyBF
eHBlY3RlZCBlcnJvcjogTm8gc3BhY2UgbGVmdCBvbg0KPiBkZXZpY2UNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgZGQgaWY9
L2Rldi96ZXJvIG9mPS9tbnQvZmlsZSBjb3VudD0xDQo+IGlicz0xMEsNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgIyBSZWxlYXNlIHNwYWNlIG9uIG1vdW50cG9pbnQNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgcm0gL21udC9ub3NwYw0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAjIFVuZXhwZWN0ZWQgZXJyb3I6IE5vIHNwYWNlIGxlZnQgb24NCj4g
ZGV2aWNlDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IGRkIGlmPS9kZXYvemVybyBvZj0vbW50L2ZpbGUgY291bnQ9MQ0KPiBp
YnM9MTBLDQo+IA0KPiANCj4gIyAzLiBteSBwYXRjaHNldA0KPiANCj4gaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW5mcy9saXN0Lz9zZXJpZXM9NjI4MDY2DQo+IA0K
PiBNeSBwYXRjaHNldCBjYW4gZml4IGJ1ZyBvZiBhYm92ZSByZXByb2R1Y2VyLg0KPiANCj4gZmls
ZW1hcF9zYW1wbGVfd2JfZXJyKCkgYWx3YXlzIHJldHVybiAwIGlmIG9sZCB3cml0ZWJhY2sgZXJy
b3INCj4gaGF2ZSBub3QgYmVlbiBjb25zdW1lZC4gZmlsZW1hcF9jaGVja193Yl9lcnIoKSB3aWxs
IHJldHVybiB0aGUgb2xkDQo+IGVycm9yDQo+IGV2ZW4gaWYgdGhlcmUgaXMgbm8gbmV3IHdyaXRl
YmFjayBlcnJvciBiZXR3ZWVuDQo+IGZpbGVtYXBfc2FtcGxlX3diX2VycigpIGFuZA0KPiBmaWxl
bWFwX2NoZWNrX3diX2VycigpLg0KPiANCj4gYGBgYw0KPiDCoMKgIHNpbmNlID0gZmlsZW1hcF9z
YW1wbGVfd2JfZXJyKCkgPSAwDQo+IMKgwqDCoMKgIGVycnNlcV9zYW1wbGUNCj4gwqDCoMKgwqDC
oMKgIGlmICghKG9sZCAmIEVSUlNFUV9TRUVOKSkgLy8gbm9ib2R5IHNlZSB0aGUgZXJyb3INCj4g
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gwqDCoCBuZnNfd2JfYWxsIC8vIG5vIG5ldyBl
cnJvcg0KPiDCoMKgIGVycm9yID0gZmlsZW1hcF9jaGVja193Yl9lcnIoLi4uLCBzaW5jZSkgIT0g
MCAvLyB1bmV4cGVjdGVkIGVycm9yDQo+IGBgYA0KPiANCj4gU28gd2Ugc3RpbGwgbmVlZCByZWNv
cmQgd3JpdGViYWNrIGVycm9yIGluIGFkZHJlc3Nfc3BhY2UgZmxhZ3MuIFRoZSANCj4gd3JpdGVi
YWNrDQo+IGVycm9yIGluIGFkZHJlc3Nfc3BhY2UgZmxhZ3MgaXMgbm90IHVzZWQgdG8gYmUgcmVw
b3J0ZWQgdG8gdXNlcnNwYWNlLA0KPiBpdCANCj4gaXMganVzdA0KPiB1c2VkIHRvIGRldGVjdCBp
ZiB0aGVyZSBpcyBuZXcgZXJyb3Igd2hpbGUgd3JpdGViYWNrLg0KDQpJIHVuZGVyc3RhbmQgYWxs
IHRoYXQuIFRoZSBwb2ludCB5b3UgYXBwZWFyIHRvIGJlIG1pc3NpbmcgaXMgdGhhdCB0aGlzDQpp
cyBpbiBmYWN0IGluIGFncmVlbWVudCB3aXRoIHRoZSBkb2N1bWVudGVkIGJlaGF2aW91ciBpbiB0
aGUgd3JpdGUoMikNCmFuZCBmc3luYygyKSBtYW5wYWdlcy4gVGhlc2UgZXJyb3JzIGFyZSBzdXBw
b3NlZCB0byBiZSByZXBvcnRlZCBvbmNlLA0KZXZlbiBpZiB0aGV5IHdlcmUgY2F1c2VkIGJ5IGEg
d3JpdGUgdG8gYSBkaWZmZXJlbnQgZmlsZSBkZXNjcmlwdG9yLg0KDQpJbiBmYWN0LCBldmVuIHdp
dGggeW91ciBjaGFuZ2UsIGlmIHlvdSBtYWtlIHRoZSBzZWNvbmQgJ2RkJyBjYWxsIGZzeW5jDQoo
YnkgYWRkaW5nIGEgY29udj1mc3luYyksIEkgd291bGQgZXhwZWN0IGl0IHRvIHJlcG9ydCB0aGUg
ZXhhY3Qgc2FtZQ0KRU5PU1BDIGVycm9yLCBhbmQgdGhhdCB3b3VsZCBiZSBjb3JyZWN0IGJlaGF2
aW91ciENCg0KU28gbXkgcGF0Y2hlcyBhcmUgbW9yZSBjb25jZXJuZWQgd2l0aCB0aGUgZmFjdCB0
aGF0IHdlIGFwcGVhciB0byBiZQ0KcmVwb3J0aW5nIHRoZSBzYW1lIGVycm9yIG1vcmUgdGhhbiBv
bmNlLCByYXRoZXIgdGhhbiB0aGUgZmFjdCB0aGF0DQp3ZSdyZSByZXBvcnRpbmcgdGhlbSBpbiB0
aGUgc2Vjb25kIGF0dGVtcHQgYXQgSS9PLiBBcyBmYXIgYXMgSSdtDQpjb25jZXJuZWQsIHRoYXQg
aXMgdGhlIG1haW4gY2hhbmdlIHRoYXQgaXMgbmVlZGVkIHRvIG1lZXQgdGhlIGJlaGF2aW91cg0K
dGhhdCBpcyBkb2N1bWVudGVkIGluIHRoZSBtYW5wYWdlcy4NCg0KDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
