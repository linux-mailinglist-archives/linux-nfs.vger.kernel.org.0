Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA694F87FB
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 21:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiDGTZO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 15:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiDGTZN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 15:25:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2111.outbound.protection.outlook.com [40.107.244.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC262706CF
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 12:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLhuoV6eWWMew2kQIxLKUj97zLEhBcy/Lmq11aeDJFT99SdP84UWzeo3yvHwrpsgM2ujU43uH9v+lacZUpdEPFTkIYw6sDZxQ+Iq9ueOkJy2H8WrmiDsXacQbt7rijSyjxYVFUg5rCIQyISh4DjXzB+C2W1n4UvepYwLuaOwOHBAEU14mYxzIJ06J6EWRGHZ5FA0yicEHdJp4w2P2/x7ETcB3cd0lZaVeBTGRimJ71eksBhxIAUvPGKql4sRS2DiZ7KcqbiE9Zdhwu8+QrCC5Rsc2svZvnyS5q1QoLT6OtB2nAL4IS65uy5Ek5A3ENiL7jjNRZj4W+i2gh5A3jz8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X0UTYUjKgDvbLD3xbN5Ph+ypMn3NS/dgo4y8I7ptDY=;
 b=CwlfaBFU6Q0nxsKJ09S/DJyyBYiyVuVTI6unsmcVpTuyErFL92lgHRXDWUzQS6qVh5xUWcmNTl27tmOsKtGzTtS4UEfkGILkoCBkjkmx7o6Bwpvi4OPCw6BncHCy0mKRcb0DdnrB2NvAr6w3BYjCfhdh7M7E0FylssD1oAixNPmG+pC5PPIen+btsKVIX5VznN1gUtEqHQPEhWtiVCZfqRMIA7BLBNzw4TMRp++UWwKFcWBMgnUIJDstnHdPjs2T709YJUG5qve7k+cAxhDdiQp5b8ALhDTT5I9dV4I0eHSaUT13VGjpYBF1EAWlg9YzK2EzT9u0DWe4qUubVTp+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X0UTYUjKgDvbLD3xbN5Ph+ypMn3NS/dgo4y8I7ptDY=;
 b=e2qg5STmwWO4kri2JfDLuPDDOh1L9cj2Bhf/Uf4zlrkYJClyLZTAO8XFDUejGP1/oVRBY2mF59Y5X1I+qAeZibSLo+ejiv2rp8DfwocHTSFFkkxyTrbGRJs6RHy2SKO/Ou3Yj/vJWVIV54ZyaOC09ToWfqadFWyQiUkOIy0jYsI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN6PR13MB4285.namprd13.prod.outlook.com (2603:10b6:805:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8; Thu, 7 Apr
 2022 19:23:06 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5164.008; Thu, 7 Apr 2022
 19:23:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Chuck.Lever@oracle.com" <Chuck.Lever@oracle.com>
Subject: Re: [PATCH v2 7/8] SUNRPC: svc_tcp_sendmsg() should handle errors
 from xdr_alloc_bvec()
Thread-Topic: [PATCH v2 7/8] SUNRPC: svc_tcp_sendmsg() should handle errors
 from xdr_alloc_bvec()
Thread-Index: AQHYSrClKqdX1ZKSxUqVYgVmqYAQaqzk1G6A
Date:   Thu, 7 Apr 2022 19:23:06 +0000
Message-ID: <38e0bc33775687622bacf16385efe6267aa98a2b.camel@hammerspace.com>
References: <20220407184601.1064640-1-trondmy@kernel.org>
         <20220407184601.1064640-2-trondmy@kernel.org>
         <20220407184601.1064640-3-trondmy@kernel.org>
         <20220407184601.1064640-4-trondmy@kernel.org>
         <20220407184601.1064640-5-trondmy@kernel.org>
         <20220407184601.1064640-6-trondmy@kernel.org>
         <20220407184601.1064640-7-trondmy@kernel.org>
In-Reply-To: <20220407184601.1064640-7-trondmy@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6816cfee-2e62-44fb-e8c1-08da18cc0b28
x-ms-traffictypediagnostic: SN6PR13MB4285:EE_
x-microsoft-antispam-prvs: <SN6PR13MB42854D7BBCD27670C42E64B1B8E69@SN6PR13MB4285.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqDULxHQ94WKjy9y/I/UzNubS1pnEQo+kdpC3LptU41aIEygQtMx9nsvG48CT1MMnRfAxAbTcqzCyF0QqZuDHCJVHNVl6djOKArGGj8B1rW9GEQpMwhdSFDm9zEYbDHqxViONI7ASoRX/5LbZEf4eeLbOkn80LQtPf8WtaHVKTKFFQcUV+YDFSbk+ZYOj8SSIdvhE2Kckfoj9JeR18ui/OTsYVXbaK8oWaRJsOpW39OsOqbC8fQKCWklxPI7GSl8W4OkVUd0xfCymokrWZ/HvTqEp/9lkxjLwUm0qPyn7E9PNstv20/RE+W8ke/ov60Y3/fkbbVAFAbIodzJ6IlWjgC2uxDB3oA4/bmv3oOkNBq4W+sFQpxTPitl5QVivtfTnRX/rPF46KjrUkGbnS7X0Mfc2o/sdpjqxCT/Evz7xo6T32fNOwp655+Rz/nBz92u8u8wejY4qXiC/gheWCWJ1YgWsyw/al/j1r5kB8QsJafDT7TEsiS9sqx4XeUruvrrf1hTL3Kor+zszKjoxdA9oH7gl5+zHhS/sWjnXHAaYR7pY/SJbfsFHEv2JYyP+kkhzeqR47ooZ8bpcGaqqP0VV/ibPEAw4+d4id7EcZild3aU0SPYCB+sod0Zcbp2Uvl+D6mdHFbIFcuxfhdx85oRT7juZHaziCpKsQEwpsEXA7i8Yz+8WzD0omiUUtY5A3tbnhydfJeLgcB1qIOHTehJ2db3etJKO2JmvCyHZVuki2akSbR6Mj6Eb1hesvgREC67
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(86362001)(122000001)(66446008)(316002)(66556008)(36756003)(66946007)(76116006)(66476007)(64756008)(508600001)(6486002)(8676002)(110136005)(186003)(83380400001)(2616005)(71200400001)(26005)(6506007)(38100700002)(5660300002)(2906002)(8936002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzlFeUlkN25BWjJubms5eU9qNGROalRKa0xSTCtVWVp0RTc2ODNEMTg1VTVK?=
 =?utf-8?B?clFjcStJam9EVTZmVzFDZFBKdUZYLzJSa2I5alkzYWQ2SG9wUmhFVUVUY240?=
 =?utf-8?B?YVd2SlljV0dRNWhtK0crZUNhOW9qWlF4cGFuR1ZDOEI3T0poRkZEOGx0R2J0?=
 =?utf-8?B?S3IyOGVvM3pYOTl6bE1lellBVXdESEl0MUQ3bCt6YnpWQjlVN2RwRVp0aCtn?=
 =?utf-8?B?b3ZEdHl6bnVsUGcxay9kbjJwZG5MdW9yZVJCMEw2ZitqS0ovUVIwUWtYUGI5?=
 =?utf-8?B?ZnZvMnBNK00xd2MxYThkOXpVWjlRcUttV1lIS0lSMS9nOFFCOU03aHU0MFRp?=
 =?utf-8?B?WmFQc1YwRmdqVnhkTWR1RXk0ZllvWE5WYnlWRk5aakRGUFFvY3RiU0QxYXgw?=
 =?utf-8?B?SW50dFFyaDFVVjM3OFMxZWFSSHRPMXlNUzBUTGdSVndIS1VhOTFmK3lvZy9v?=
 =?utf-8?B?bmlNRzg1MlJYb2xOVnpHbkd6ZHJlelBnZmRLWFhoSWJYb1RJOHhHWUxoMFVM?=
 =?utf-8?B?ZkpvRDZTZW94b2tlZEE5b011UmZYdmt4dURuNTExU1owTWRaSWpIQTRXNmVB?=
 =?utf-8?B?SDBSbzU1MWFIZ2tYQi91YjI0RmZFUUluS3lrSEtIZkpvSGppdjZ1U1lZUGxp?=
 =?utf-8?B?OERGSXBZUGl3VWtURjJ6WklEQVhWTTRsRFFpSG1iUTZqZk51N2R0ejBGKzdU?=
 =?utf-8?B?TjBpcDhtY3ZwanVDNExtTWcwK3pRcXJidmp1Z3hZZEg3a08rd3NqeUd5WE91?=
 =?utf-8?B?elplZTJrMFgzeTdobVZKQ3FuK1QvUFBqazcwdFJFd3p2OC9lQUtYYmpQT2dY?=
 =?utf-8?B?N1pDM1ZiN0o5RU0zYmpjZ1B2ZVQwMDFhMlkycUxBUHVkbVJIQTNvQ1JNWWpl?=
 =?utf-8?B?MHUyODByeWxYM3ZkMjFCRVFQZDE1b2lOZnNZcS9RWVJwU0d3Y00wVXVNd1ky?=
 =?utf-8?B?UEpTWm9nUUMvbnNYbjdKanJ5Mk1SVDFtcnBoRGIvM1BVcGxyMklDa0poczEr?=
 =?utf-8?B?WFZMSGgrMW85QzRRYmdyZ0NoeHlLbU5MUFcvdEpSR0JvamoxYThKZFYzdFVw?=
 =?utf-8?B?K09QRnVJcUJpaFBnZjRybUw5ODZtb1F4V3dKOGdZNGJVb0FxVUlLNVJNaFZi?=
 =?utf-8?B?b0IzOHBsYnhMeDY3aVdxczlLdHAxMzJNUlFQMXUvY3doUGpSN2t2VXFUalAr?=
 =?utf-8?B?eGhka0FEbmFGcUNFR2VabUpnVUdvK24rV0lWOUoydFRSZnRKUllpdmNNeTli?=
 =?utf-8?B?RTRKUk81VWZ2M3o2bzlXZDBJSjNNSW1CZy9zYXRLZFJITmo4S2tjeGxtQ1pp?=
 =?utf-8?B?eVpRd0dSRk9tcVVsRDQxZTU3NE5BdFg4Mm04cDR5dWY4d1g1ZjRLcEJuOXZw?=
 =?utf-8?B?MCtkdml6b3R5TkFjckJtNVhlVENTNXhac3BXOUQxSklSREZIUUU2b3hubk5m?=
 =?utf-8?B?WUFpTFp5bkROSjlHdlBGY005cDl1WStLUWdha2U2Rld4YklySko2dXJNV250?=
 =?utf-8?B?azQ4eGVUZzVqUERFaUtkSFZIWDBVK1VGOXJISTVGY2w5MTRtNUdPejhveXMw?=
 =?utf-8?B?aEJkd3ZTRnJXMGQzUTNhcXExZnI4NHJ5YU0yWVZiM3ZEZnA4WjQwU09BZDN5?=
 =?utf-8?B?OFFoZE9jQUNoZGxkckduQTFFV0dzVUpMYUpDd1lkS0pPY0ZiMmZNYXlHZ1pv?=
 =?utf-8?B?c09YL1V6dHl4UUlyeHptb05KUmVobDAzbUVQWmRyOVFTT3JqVnZoMW80M3A0?=
 =?utf-8?B?K2JUY0lzV3ZzQ2pmZnpHWU1rZzdDNDdweUJ1SG55aTRSbVI4YzRuRzJEb3k1?=
 =?utf-8?B?N3RRV3V0ajNGbDhVWTZuRzJua210UVkwNnRSdWdFYnVhbzBHNThpZ2YvZ2lv?=
 =?utf-8?B?Rmx5Z0I0MWMvbXZaVlZ0b1VFM2dSMlhuY2hNN2tEcHhaaWFwdmRnTURvRTVU?=
 =?utf-8?B?NFNHYXdkOHVaTUZYQlFXcU01OWNlVXRhejVwMHlEWE95V3U1ZUpXZDFPYzJB?=
 =?utf-8?B?eTZ1ekNWTzRuYVBPajVNTCtzT2pJc29vNlp1RHNkUXJ5TkR3c3ZtSUpVMSt0?=
 =?utf-8?B?UEN0QVpJbVZ1cG9BVlJLZUlSNjcyYlFqUGVaUkM2OHRHZmR2T3MzdTFQKzR6?=
 =?utf-8?B?cG4wbkM5WlFuL2tRbXhySFp4Y0tzM0ROWTdhTktRRGY1UGhNWTlCTnJwTHVH?=
 =?utf-8?B?TjhHN0ZJVkhxaE9CckpFWlhDRDhzdVRZUi9HSzkwTFJjd3BTUm5tOEl0L3pz?=
 =?utf-8?B?aTVtbE1PTlNOQjZjMW5Ga25ScWlxWWRHd0JucUQ1S1d2QytyK2E0Z3hBdHdO?=
 =?utf-8?B?bWZoT2J3b21LUlBtRFNMOE1GOXdJVndONHNLYXdiSFJnR1diVzF2VzRlN3dK?=
 =?utf-8?Q?FWiP/PE7bSFOKT40=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D5861D47897294AB531DEFFF5BCAE34@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6816cfee-2e62-44fb-e8c1-08da18cc0b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 19:23:06.5347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XyJiaj5U9yKTfNMPnPcmGwpM5+I4VtLlri7ExsKLnsZS1qopmKMXSXUmeNsK8RymTjSN5TgepmgX1SGZijPNtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB4285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTA3IGF0IDE0OjQ2IC0wNDAwLCB0cm9uZG15QGtlcm5lbC5vcmcgd3Jv
dGU6DQo+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbT4NCj4gDQo+IFRoZSBhbGxvY2F0aW9uIGlzIGRvbmUgd2l0aCBHRlBfS0VSTkVMLCBidXQg
aXQgY291bGQgc3RpbGwgZmFpbCBpbiBhDQo+IGxvdw0KPiBtZW1vcnkgc2l0dWF0aW9uLg0KPiAN
Cj4gRml4ZXM6IDRhODVhNmEzMzIwYiAoIlNVTlJQQzogSGFuZGxlIFRDUCBzb2NrZXQgc2VuZHMg
d2l0aA0KPiBrZXJuZWxfc2VuZHBhZ2UoKSBhZ2FpbiIpDQo+IFNpZ25lZC1vZmYtYnk6IFRyb25k
IE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gLS0tDQo+IMKg
bmV0L3N1bnJwYy9zdmNzb2NrLmMgfCA0ICsrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy9z
dmNzb2NrLmMgYi9uZXQvc3VucnBjL3N2Y3NvY2suYw0KPiBpbmRleCA0NzhmODU3Y2RhZWQuLjZl
YTNkODdlMTE0NyAxMDA2NDQNCj4gLS0tIGEvbmV0L3N1bnJwYy9zdmNzb2NrLmMNCj4gKysrIGIv
bmV0L3N1bnJwYy9zdmNzb2NrLmMNCj4gQEAgLTEwOTYsNyArMTA5Niw5IEBAIHN0YXRpYyBpbnQg
c3ZjX3RjcF9zZW5kbXNnKHN0cnVjdCBzb2NrZXQgKnNvY2ssDQo+IHN0cnVjdCB4ZHJfYnVmICp4
ZHIsDQo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0Ow0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKg
KnNlbnRwID0gMDsNCj4gLcKgwqDCoMKgwqDCoMKgeGRyX2FsbG9jX2J2ZWMoeGRyLCBHRlBfS0VS
TkVMKTsNCj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0geGRyX2FsbG9jX2J2ZWMoeGRyLCBHRlBfS0VS
TkVMKTsNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCA8IDApDQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Ow0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgcmV0ID0g
a2VybmVsX3NlbmRtc2coc29jaywgJm1zZywgJnJtLCAxLCBybS5pb3ZfbGVuKTsNCj4gwqDCoMKg
wqDCoMKgwqDCoGlmIChyZXQgPCAwKQ0KDQoNCkNodWNrLA0KDQpEbyB5b3UgbWluZCBpZiBJIHNl
bmQgdGhpcyBhbmQgdGhlIDgvOCBhcyBwYXJ0IG9mIHRoZSBjbGllbnQgcHVsbA0KcmVxdWVzdD8g
SSBzYXcgdGhpcyB3aGlsZSBJIHdhcyBkaWdnaW5nIHRocm91Z2ggdGhlIGNvZGUgYW5kIHNlcGFy
YXRpbmcNCm91dCB0aGUgY2xpZW50IGFuZCBzZXJ2ZXIgdXNlcyBvZiB4ZHJfYWxsb2NfYnZlYygp
Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
