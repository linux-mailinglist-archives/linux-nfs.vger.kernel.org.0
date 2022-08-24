Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C704559FA24
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Aug 2022 14:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiHXMmI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Aug 2022 08:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiHXMmH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Aug 2022 08:42:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2106.outbound.protection.outlook.com [40.107.237.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454A2696C6
        for <linux-nfs@vger.kernel.org>; Wed, 24 Aug 2022 05:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNEeXauKFdlTQkS358vbr07PHSUeurQMPzzsbLgXDuFPuFxg5wXTCGeCWmKC3AdOshyUaCh7vORmTlt2tHsl0fKVXYOcFaSYLEXXBkHWnIsz2CD+74MkysM11iqLeSlTdQGhd7bki1ci/ILNTFOXqRJbnF3Dh4N5+lOvRWYx51X7msSG4Aebt9YJktbkM6BwGQnTUc7RUPrAdpYNb5UUVRlrv8ySVJrQIe/kZhlKbkLw9fmsh3OJx9bk9QBRGClhEeGTfzBRN/IzDSOqAArCxZ/enMADyHsMxCINBhBRqgtZOhTyiSUtOUAFr+uUj0hbqiAIwdkufvc55Fg3fkFX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpYJ7udYKRs5Ib7/U7XcnSTeRawVG4FZDxLki1nJ+MA=;
 b=FnTi+bBOQo017GbPv3j8UK/XMDaXI1SyNMhm1VhxLvvzXcr9jKmZeXIiNUNizGapeOlylp+l0d1ubjLmcPJxIroRH1B/ZY+52piGt+pTQIMHhei0m/oc3wZFaH95GgG0vA+FA2GGvlZdXA79kvoahGJF6THUSFQyfuASKJ44NQS5viLq9o3a0Jrl9Uq3Kxi7MqrLM4cI2NarqUKF/qr4g05AlULQZL9tTvLSOPfEScmfPUkVKy/ibgbMC6G3aUYuMlXXClFAhZGhV0ZPC42w+4ynMphzUBkqzhB+gAsrVz8K23DmahfLTJvC8BINCD06MhwLVuxoLGLowXUjsL5QUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpYJ7udYKRs5Ib7/U7XcnSTeRawVG4FZDxLki1nJ+MA=;
 b=LuIun4atxTURZj4mdv0wvzGZYQ9Fvbsr0B7K7KNSOkzRjs7OOE+i5/iEh9Rki2BbNdPmGwkKjzDw9DVbTxg+77yuagQU2L9QaQ+hWz4mmpz/eLg4NkiYXEnl6EYX7x5OVrzFxTCbTEFPB85g//zeYv6pw4H9nCon67HjzJmAbx8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB5633.namprd13.prod.outlook.com (2603:10b6:806:230::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 12:42:02 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 12:42:01 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire.byrne@gmail.com" <daire.byrne@gmail.com>,
        "benmaynard@google.com" <benmaynard@google.com>
Subject: Re: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode
 and Kconfig
Thread-Topic: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode
 and Kconfig
Thread-Index: AQHYt5zQc0jiP02yL0Kjw6guU1m2RK29/pOA
Date:   Wed, 24 Aug 2022 12:42:01 +0000
Message-ID: <429ecc819fcffe63d60dbb2b72f9022d2a21ddd8.camel@hammerspace.com>
References: <20220824093501.384755-1-dwysocha@redhat.com>
         <20220824093501.384755-3-dwysocha@redhat.com>
In-Reply-To: <20220824093501.384755-3-dwysocha@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 882874e8-3e43-4fe7-673b-08da85ce0acd
x-ms-traffictypediagnostic: SA1PR13MB5633:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vmynj3J/YT4AlnnIZDauZXPE0q2ksi2BAuyU7hbkD17MOmigD6HAuneB37EcLRrlmgPhdsjAmHAxyL2Jt7QCKDCqerB2nbVyoNqbuzek321ad4RrcyywUIC4+Pv5QVMVMahWY9akG+KL1O2T0CBArfVxDjQC34jkLA5s2N0dx4pKPxW9JORmyrS+b6pcUqBonCKFxFTB0YuJC2+ROrpDQEo787d40DcQfFyHqpM1n8FdLo+MIhVoxhffRhMwm3whklrBzvpTv/hCnGG5m3nWICJLd8WsoopEiFb8jlImW4rx6dZCYTcZ7L9EK5YrbE8BjPQBxVRGEQrD7kmpUdPYxPD8pUaNn8Hf7j5/aO85NwoU9NTRQPnD221mTJGhvKOq6PbL9c9WpGdLp23aJA/N0EemivPjq35+S/8NxlACjv8mvf7n5NoUReK36mp0y7bLRPjJnU6JNIp9GiuroTIXWn/AXR7vlzcYorrhdtLs8u5n93YslesQt8B+nxiVHQvNW/l9RKKgH43Aq1kwp5rc9Xav+lLAWuVz55vG7Jjlf/ybn/n7e2o3xQS67+qA7ycFwPqcZfoDH5BA+efxo+5DqqYV/LUQxCi/KQxr3KV+ZXQ9EuCTAR4Wmd9Ui6Nfxj8e8784zfWp2hkZz16NLhiX5eh+9PMKc14eJlUg9CGOlIF09PhQfN5jk6Lq5VT3QS8TKz8dKCzmPVUbCypzuSimV6dxAlXmOapH0ouDR48CrDlvfSh5BW0mF47O8tQr0K+m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(376002)(136003)(39840400004)(66446008)(66476007)(4326008)(71200400001)(66946007)(8936002)(66556008)(41300700001)(64756008)(8676002)(36756003)(76116006)(316002)(478600001)(5660300002)(6486002)(110136005)(6506007)(2906002)(26005)(186003)(2616005)(38100700002)(54906003)(86362001)(6512007)(38070700005)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzJIbEhtYVpxV3VBM3ZOcVFIemlObUEybDZ6MllHVTdnUEprNjRRajlZV2l2?=
 =?utf-8?B?ZVFwZ0ZIellqVzExaC8rbDRQSWdTZThweXNMK3ZxODFacXNOdDBiU2p1V042?=
 =?utf-8?B?b0JzaW5GNDNhQm1pWnRBczAxNG1YT1hIRC9lUWZCNDN0bFNUYVNkVkphZzNV?=
 =?utf-8?B?YmU3Mkw4T0RpbEx4ZTB5a3ZmKzh3Ulk5Nk9DKzNmeFBPenhHZ2tzcFVhOGo5?=
 =?utf-8?B?dlU3Tytzdit6L1Y0Mk83VmVqMFoyMmNMNnZUSjgvVmtvaWpLYVRrank0TDIw?=
 =?utf-8?B?ckJwaDVPQVg2NHZJU1dMdWNJSDd0VmxHU2xkM21zSlpBS0NqRmRMaVphU0Z1?=
 =?utf-8?B?bHd3SEhWcU5GQ0pLOTJGY2NTUk1uMVo1OFZxYk1qT3psNzB2VE9SdjNtYm9X?=
 =?utf-8?B?eDE0VWNEMHZWcFUweHk5ZWlDSkRPZUF1b1U1Tk50dFBEbHN5Y0NqK3FRVHYz?=
 =?utf-8?B?ZndhdENsYURPOXE5VXJOeE5HVGtWbnlFVlY0dTBiRlIrT0VwelFjaHpvRmJJ?=
 =?utf-8?B?Rnl1QXQ1U1VvNGRGOHJSNjBLSVZwWTc0c0Zpc2d6NGRTcUd0MTJnbzdSZ0px?=
 =?utf-8?B?TERvU1k2TTdJK09xVjRZZVluMW8wNnVEd1lrcWZFMFRWRU42Tm1nSWF5c1Ri?=
 =?utf-8?B?MjF0RldNRHpCNXdYUytpcitnSWZSTy9MQUNSeE5DeDRzWmNoLzByLzhmejVa?=
 =?utf-8?B?eDRvU1JJTS9KS1A4WUg4YzFlQ0tmVEZ6VDFGS1cyMVNpTkdTVnZJS3J3Q1dm?=
 =?utf-8?B?dXllRWlBSlc1TlY1VVBBYms0VFdxVXBpZ0F1WjcwYmxXMDQvRjEvSlM3ZE8y?=
 =?utf-8?B?T0pxczhSbmhCbGQwZi95bURuZUZMTXpyeVlRZm50UjVFbHF6S3ZwZ3NqNi9u?=
 =?utf-8?B?cVZKbHF6aWQ5TkVpeFIxRWZ4WVBYZ2V2em01MkNsaEtmd1VMeW1tV3pQWjIw?=
 =?utf-8?B?eTRucWJEV2VneE5HTHN5VTR3SGVPY3lBSkdkRktPTjhqMFBhQzBWY280TTMy?=
 =?utf-8?B?eGhGVTcxTW9MbEhVbE5DbUxVQThXcjBENEpqMkxuMEFmbm41QjFSa2tRcEFy?=
 =?utf-8?B?RkVGbVAxeEpLdG8xN0lvbnRwTFNLZmVaT2xGT0Z2d01KMDhKOGlEaVpXYUZG?=
 =?utf-8?B?bUhkVkJPdjhnL0RwNU1heVlrZ09jMVJSQUZpWkx4RFV4bUhUQTErTzZybllr?=
 =?utf-8?B?ZUpoS05kRzdOT0hNUE01T1NpV0MrK0lkRXk2cHhnNWo2NEs2Vzk4WDU2TWNV?=
 =?utf-8?B?Q0t0WGk5MDl2c2FTb2tpU1hYZnRuUkpLRVJOc1JhSTlVc3pzaHhodzNmbnZB?=
 =?utf-8?B?QVF3U1ZVT2EzQkJtUTNuZ3JwSEZldlFaVHhqQld2YkFHWGdLcU9sSjRObzVO?=
 =?utf-8?B?WHNxTHVPNnJwTUNvaWdMdm5NODNCTUNKSUlrZjJIM1BZNVVPUlpka2pDOHc5?=
 =?utf-8?B?SlFDYVVzVFR6eEJxcnlraTAvZjc1dlVJOVdIL2dOQWdVUE5zdy9BVHhXMml4?=
 =?utf-8?B?ZU95RW9veXZDUmNtdWFXaFFsaXNlQjhSTEZhZVVYWDhOS1V1L0N4dmQrUWYr?=
 =?utf-8?B?cXRVTUZFQUdKSS9VZndIUmNMSzR3Ykx4ZjQxcW5meU5HTEVwVWlCZi84SmF5?=
 =?utf-8?B?TWdyb3N2MWd3NlhmK2tyQWZublNvbTl2aVpJRE5lQUdVWmtTT1lUZTViNVhI?=
 =?utf-8?B?dExCVEl5RmR3OVVRR2x3elpLMnBwOThHRXlSZTFicnFra3M1TE5sVWI4WXQ2?=
 =?utf-8?B?bUpOa2hmM0FmM0hPOUt3cWNMQjdVcUd3WUk0NHdWVmhWZnZOMFduZXY2VldR?=
 =?utf-8?B?TjdYZU5YN2REWi9vWEVrVm1seG9VRFVqWFFldm5LLzcrYVkvTSswVDZET0lI?=
 =?utf-8?B?VDlYQmg3U1VtVDRSblU2RVl6bXdaVnFUMUhCTFlHQjNpVEc5SklZYjBTK2JY?=
 =?utf-8?B?QVZkZktJN1Z2R3R0T0J3M2tjVlZJdDN6UzJVR2hKc2lBeVpPSmtFOFVPK2Zp?=
 =?utf-8?B?dG1Ba3l5d1A5b0JiM1NhTVFpbENjL0FVRkFuRHMzNHpKWFVZUGlKV3FWZTRT?=
 =?utf-8?B?RzhhdFJwZnlNc0sxNzlKNS9XMGEvVXRTcnRTMjVxeS9XczRyVDJWRnJlbzNR?=
 =?utf-8?B?aENSaG5pd2NlbTVJaGlzNzNLUGZsbFVMTlhCcGovQytWaTVhVlpsYzdsdm0z?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <262D79942952D345B475EEE022415AF6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882874e8-3e43-4fe7-673b-08da85ce0acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 12:42:01.6712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5up/rkQbqdxkdCkXEGAe4YR2s7FkeFXPc1OgDgqnpZh9S7GdFMjuDNPbwvx/mRe94xTAkts5kvUCW4/oOSMSSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5633
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTI0IGF0IDA1OjM1IC0wNDAwLCBEYXZlIFd5c29jaGFuc2tpIHdyb3Rl
Og0KPiBBcyBmaXJzdCBzdGVwcyBmb3Igc3VwcG9ydCBvZiB0aGUgbmV0ZnMgbGlicmFyeSwgYWRk
IE5FVEZTX1NVUFBPUlQNCj4gdG8gS2NvbmZpZyBhbmQgYWRkIHRoZSByZXF1aXJlZCBuZXRmc19p
bm9kZSBpbnRvIHN0cnVjdCBuZnNfaW5vZGUuDQo+IFRoZSBzdHJ1Y3QgbmV0ZnNfaW5vZGUgaXMg
bm93IHdoZXJlIHRoZSB2ZnNfaW5vZGUgaXMgc3RvcmVkIGFzIHdlbGwNCj4gYXMgdGhlIGZzY2Fj
aGVfY29va2llLsKgIEluIGFkZGl0aW9uLCB1c2UgdGhlIG5ldGZzX2lub2RlKCkgYW5kDQo+IG5l
dGZzX2lfY29va2llKCkgaGVscGVycywgYW5kIHJlbW92ZSBvdXIgb3duIGhlbHBlciwgbmZzX2lf
ZnNjYWNoZSgpLg0KPiANCj4gTGF0ZXIgcGF0Y2hlcyB3aWxsIGVuYWJsZSBuZXRmcyBieSBkZWZp
bmluZyBORlMgc3BlY2lmaWMgdmVyc2lvbg0KPiBvZiBzdHJ1Y3QgbmV0ZnNfcmVxdWVzdF9vcHMg
YW5kIGNhbGxpbmcgbmV0ZnNfaW5vZGVfaW5pdCgpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2
ZSBXeXNvY2hhbnNraSA8ZHd5c29jaGFAcmVkaGF0LmNvbT4NCj4gLS0tDQo+IMKgZnMvbmZzL0tj
b25maWfCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gwqBmcy9uZnMvZGVsZWdhdGlvbi5jwqDC
oMKgIHzCoCAyICstDQo+IMKgZnMvbmZzL2Rpci5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIg
Ky0NCj4gwqBmcy9uZnMvZnNjYWNoZS5jwqDCoMKgwqDCoMKgIHwgMjAgKysrKysrKysrLS0tLS0t
LS0tLS0NCj4gwqBmcy9uZnMvZnNjYWNoZS5owqDCoMKgwqDCoMKgIHwgMTUgKysrKysrLS0tLS0t
LS0tDQo+IMKgZnMvbmZzL2lub2RlLmPCoMKgwqDCoMKgwqDCoMKgIHzCoCA2ICsrKy0tLQ0KPiDC
oGZzL25mcy9pbnRlcm5hbC5owqDCoMKgwqDCoCB8wqAgMiArLQ0KPiDCoGZzL25mcy9wbmZzLmPC
oMKgwqDCoMKgwqDCoMKgwqAgfCAxMiArKysrKystLS0tLS0NCj4gwqBmcy9uZnMvd3JpdGUuY8Kg
wqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4gwqBpbmNsdWRlL2xpbnV4L25mc19mcy5oIHwgMTkg
KysrKystLS0tLS0tLS0tLS0tLQ0KPiDCoDEwIGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMo
KyksIDQ3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9LY29uZmlnIGIv
ZnMvbmZzL0tjb25maWcNCj4gaW5kZXggMTRhNzIyMjRiNjU3Li43OWIyNDFiZWQ3NjIgMTAwNjQ0
DQo+IC0tLSBhL2ZzL25mcy9LY29uZmlnDQo+ICsrKyBiL2ZzL25mcy9LY29uZmlnDQo+IEBAIC01
LDYgKzUsNyBAQCBjb25maWcgTkZTX0ZTDQo+IMKgwqDCoMKgwqDCoMKgwqBzZWxlY3QgTE9DS0QN
Cj4gwqDCoMKgwqDCoMKgwqDCoHNlbGVjdCBTVU5SUEMNCj4gwqDCoMKgwqDCoMKgwqDCoHNlbGVj
dCBORlNfQUNMX1NVUFBPUlQgaWYgTkZTX1YzX0FDTA0KPiArwqDCoMKgwqDCoMKgwqBzZWxlY3Qg
TkVURlNfU1VQUE9SVA0KPiANCg0KTkFDSy4gSSdtIG5vdCBhdCBhbGwgT0sgd2l0aCBtYWtpbmcg
bmV0ZnMgbWFuZGF0b3J5Lg0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQoNCg0K
