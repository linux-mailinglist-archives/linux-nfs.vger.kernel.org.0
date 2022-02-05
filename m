Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1A44AAADB
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Feb 2022 19:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380873AbiBESYT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Feb 2022 13:24:19 -0500
Received: from mail-dm6nam10on2113.outbound.protection.outlook.com ([40.107.93.113]:35553
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380881AbiBESYP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 5 Feb 2022 13:24:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2lCe/00v3XSmbW5PjWNhAWewEN5pxwP7GYO+ftGIP/QvmuCnKeMT+NV23F7ueajHrsRIWDMkWmLCp+CWato14Th1X4GuOnbXOYwyoFmRjTglgKwZzuQopovHd87YX3psHAxi4snT7kfOQVkdHANmybHp58jAzymQNf45xF65HvUtuhPExU9Mp9AJjY9E9DzPGTOuMn2ikFfEaVtpBxKGLXJQYIcSEwyewz0CjkEoZfrIflAb/9lNHLGLHI5W4ilRhkeuhlTP6aJhQhHUpVMtoEoAhZMFbKne3wk8Zatr5fFZLMWxBq28iKS3iI1PoDy1nIWYukvggAysUHUAILwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7/8ezNvWX9wJlLPsr3COwm3zofXmTknY/anmZpsBLI=;
 b=atkDzweS7jPqYvkGd0tjPr2dCmUIfoqlqv69KhPrefUSeFGf4T82PGL/MaoRVWBCLbxKutqMRiZjph6owfdeN8o7pPJ7z1q9BsdJg07Yv31KLfBdo6aoRkwa7e9DAHSccjhpRGwe6Gar4lLFmLr/4QOeoGoVqW7XDqPai1jvCPs0ke+du3KfGQplpJCcLqk+piYf4nAnEWxocEf+SktchqIsAYuynBtZk3r0V8ZIKz6vBhZskLj/ny5mQJengXRL4jkZ6sgEww9wtMVDSjydpSNijD9gt6cq9VR48T10vlZnEC8iDKfHk4//SKMMdbjwOu4g4aR9b/wiAK44gkXiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7/8ezNvWX9wJlLPsr3COwm3zofXmTknY/anmZpsBLI=;
 b=aNVHZkLxDDQugzmRX3mDUdgqQrH3gu1Y9mNHyevHS9omwZl+Jfmoo5OEa9R1IkF4pdpZwY7GJ2iUuNijkPkmWu1hQXOB5g8rm9wSDQbvwbDxfUfiatwENZoBDzgoZfhW0sS7muP1GHGnShm/0L/XN+3GDqompZeG3B7zGNH6o0w=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 BY3PR13MB4932.namprd13.prod.outlook.com (2603:10b6:a03:36c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Sat, 5 Feb
 2022 18:24:13 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::9a9:2e76:d536:adcf]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::9a9:2e76:d536:adcf%3]) with mapi id 15.20.4951.017; Sat, 5 Feb 2022
 18:24:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Thread-Topic: v4 clientid uniquifiers in containers/namespaces
Thread-Index: AQHYGqGY+wEK6KvlxECYW5WP2WwW2KyFReGA
Date:   Sat, 5 Feb 2022 18:24:13 +0000
Message-ID: <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
In-Reply-To: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3213832-1eb9-44e4-44aa-08d9e8d4b5e9
x-ms-traffictypediagnostic: BY3PR13MB4932:EE_
x-microsoft-antispam-prvs: <BY3PR13MB49327147B367840C2FB834ECB82A9@BY3PR13MB4932.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ijUTZz6irb+aS1tB4unW36tz8DIJLZxajqlci4Rk8pS0KyITAkeGc26wcwG0/PPvad/t7WL7MOa9ro40SfMnJSYd/goX03a+5uhR9PB8J3rgjs1Z4DqQ8XhpeVJVhDVejuccPpHhHGcmI9N+wHu13EQVq2sKSSgMtGd4ZH1ae1oZrIO1KHHq4qoCSieksnGz6/AoLfbZSuNqFyFZup0EcYGdgNFA/htRej8Aq1MjiBo1L0QWfU4n2btZXzvgNrLJ17tZzch63Q0j5hn4hv9hMHModz2k/h3Lkm8rRdCtWm1Qc5tBShG3wLZ38zlEXYVEUA/T73z7kGTrHbByxuYXo5fAy36y8DgcDBdQdI4eBVFsrQcy9QCbxCXM8maBvnlFazMe+wlUyXgm2hI67/2hqbUyckeE5LrKC7gyZbfsOuQqAs0vtIhWUzQUECZ9TvgqCOy5TcHO2CTfWFu363PQDiCAxuU28NfCi2Myha4UOgEiXqI52MfvmYxDa1tzUgJ05sPg+EK6/UOLyIUCcTD94bLMr2vuY9H4v7Zsdcfr6FeFdjggWNuRUI52ZTKcGtRQJ6fzUvhZ0Y+Q9Bd3skDYCAx6FJywIs+W9OuJ4MttIApzval1b95mdf/h/vt1VHU6sWG688STPRq4DFMoFKXOU1FMFmrvWsCh+ceoGbRIVG5vXQ1/qF9Om8XzEmEXWoQdWyR1ocWcygqdqoREUNbJSzM1erSeOi6ezSzVAu23O+dp3WGbfkibwQCwmHO485DB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(2906002)(5660300002)(2616005)(508600001)(86362001)(83380400001)(38070700005)(110136005)(91956017)(6506007)(76116006)(38100700002)(122000001)(186003)(316002)(8936002)(6512007)(66946007)(66556008)(66446008)(66476007)(8676002)(26005)(64756008)(36756003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGRJbDJaWFRtWmF0cTVQd1IwelF2VEFZQlNSTkNWRzMzdjAzb2NMaDBWdDR6?=
 =?utf-8?B?U1JFZUhvY2w3YnhUOTNKbXJzbWxrcUhUNmdKQklRRHpFN2lId2tyOHBzRlI3?=
 =?utf-8?B?ZGdEM0pvdGwxQjkvaitUaUZId3FGeVB1b1RlNlJ6bk4wbmJKRXlmTmZnRmd3?=
 =?utf-8?B?NWFPUlRqTVNKdTNkZjNMaThXQ00wbUJkSXprd1VmeWtiK2ZiYUFIOTczZW9p?=
 =?utf-8?B?VHVFeGx4SldFRHFqbmp4Ym1rWldnNVlwWkJJS2dybnVZL3ArYU9Ea0x5azFE?=
 =?utf-8?B?Z3VLd1hBUytSSE1ZbnJROHU0dVNON1EzaUFQUkNCSmpwM2RKL2lxT0l6SFpS?=
 =?utf-8?B?RVM4WFYvOGcyQzRLNFZJdDBIYmNNOVlZbXBpQnkvUWlEcDJVM3dyazlaa3lX?=
 =?utf-8?B?V3FQUVYxWEJWMTFqT0s4UlEvQkFXWlBhRFhTOWJLTEs4elZHSlBsdjBmR1hm?=
 =?utf-8?B?bW9kTlE3OGVVTnh3aGcrUHk2VGVRN01OZ29ucWxHRXRUd0pTaFE2SkdNdWxJ?=
 =?utf-8?B?eEZOZzExQ3ZPd2RxMUhEZlNsWjBoUE9EUmdEYVdqdjVrV2VudFQ3TnBlYTNy?=
 =?utf-8?B?blJOUGd4a0VuYXJ1TFJvaUZjNDZib2xwdWd2a2g2M2lVUFloWk4rVlVjVXNv?=
 =?utf-8?B?Rml5VWIrQ0hBUWFyTVNCeU1qUHUzMnBPV053NnJETzg2eUVFcVJzZTdqYjFi?=
 =?utf-8?B?QXdUc0tVcFJod3gxVHo3ZDBHb3NIcE1iUm5kbmovRTZrL1FOSkZzeXJERk5L?=
 =?utf-8?B?Umtkb1pYc01pQ3VLcVJ6MEphR2hCK2c2ZzdyY3pMMDcvWTR6SEU3K1lSR3RZ?=
 =?utf-8?B?eWFhNitCam1hWEZCQjB4dkVpdnYvQ2E4Z3FJMGF3Vnd1a21LdVFCRmZGeVZD?=
 =?utf-8?B?ZXNKaEt5UXlwSjM0ZGp3Sjc3U09CSmprejFmd1Jmcno0QnRQTlVCbWFHRk1k?=
 =?utf-8?B?bUo3SkhFMlpZVVptTnI3UFFGQjhPYVB1Qmx4WVU4YXRyYkFaSysySkRXTDRY?=
 =?utf-8?B?Z2RYZmVSRHNUZUx6VDZIYjRHei9NaEVKbnFaVzZncHRRejdFVG1kL0FpSFRB?=
 =?utf-8?B?ZjBCVnprUGErd2Fwd0hVZ0I1M0RwWEtmRHJFUUNmdVhpZnMzRGw3OVkxay9V?=
 =?utf-8?B?Qi9zL01Tekl6MTUramh5K3NVQ21qU3g3YnU4eHVPNzU4Yk9zMnloaFBkYlRT?=
 =?utf-8?B?UXVhaXRMaWFYQkxORmtTQ3IyaXhTLy9zemlDdUVkOHZhWUdsRUY2TXplSFY1?=
 =?utf-8?B?NThqRVFOMEsyaVdKQjlrSG5iNU4vWjRPRFFsdmVOWWtVd2o3dys2cEpmT3VN?=
 =?utf-8?B?K09XVlB5K1lkcldXaHVZU29ZRjNnUTNYaGdnczNMYml3RytwT1MrNWVtcjNX?=
 =?utf-8?B?dld5b1YrMVF2b21lTDA3dm9RNFUyL1grSkV3UEVJVXEyaHJBK3IyZ295R21Y?=
 =?utf-8?B?RWJhQmR1MEhHck41UUpBM29rK2llUFpIL3pSdVNJUG1ZaThiMTVpeUJvU2xR?=
 =?utf-8?B?ZEhuYzdDSE1nMDNWVXdsQUZOanRJVmtZMXI3Qjh4dzNzVXMxeEZ5cWlWTzhR?=
 =?utf-8?B?anVDYi93TCt1bkZod3ZRci9CckV0azAxc1YyTVZHdmtrQXNXMzMwMW5TdmtS?=
 =?utf-8?B?ZTY5Wk1waGJkMU1BbTJtekszZ3hUblhGVlMvQmtoTXhwcC9KR3JvUEdLVFNr?=
 =?utf-8?B?L05PL25oV1VTSFlsSWlSY2t0alRIYnRxZ3FUK1ZyS2p2RHMzSVZjcFRQaFZI?=
 =?utf-8?B?dDRiS1ZqUG1Ma2d0bVJGTWtoSHdyUGZwUGIyeU1pUytVTWJ3M0I3NkV2YzNH?=
 =?utf-8?B?MjZqakVMWXBUSmxoSS9udEJ4U3Z6Z2ZJZmJxdHpiNTFOd212U0s0ZGZaMmZB?=
 =?utf-8?B?VXVkSDZUOVB3b0ZTUkxDamFDOVN6bFRNQlRPckZBV0RkYlQ0aGs3L01yTllh?=
 =?utf-8?B?OFAxUlY4R1hMU0VjOTQrejVYWWU5emtZVHRYWURGVVZGRXhOTXRpUEVTOW02?=
 =?utf-8?B?emo2NzJJYnpDUU1HTVJQREM3UjVzSHNUMmRDUytjSUxYbllBVFdTZ2Q4ZDVG?=
 =?utf-8?B?cDlKcmZKcFFTYW4rMWJMb2pIWEY5TUJxMVFHRnAxN3ZnaENVUTBXT1hsWEdm?=
 =?utf-8?B?OVVsMktUdlRLL2dOTEJhL1g4dzFkV0Y4RjN4elk1TzEyL0lFNEEwaTF0TWhB?=
 =?utf-8?Q?NJk8b4nmu2Z2badDuJDdYwg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5063A72780B4BD499BBCEBD65B71CC10@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3213832-1eb9-44e4-44aa-08d9e8d4b5e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2022 18:24:13.1060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3Wbef0MJk6EQIoSrX4QncfvcQ84Mc4rgcQduhk8OawUvaZDu+ujfFp2xOuA2u/wexw5iLp/9xEwKxwSuLQrEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4932
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIyLTAyLTA1IGF0IDEwOjAzIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBIaSBhbGwsDQo+IA0KPiBJcyBhbnlvbmUgdXNpbmcgYSB1ZGV2KC1saWtlKSBpbXBs
ZW1lbnRhdGlvbiB3aXRoDQo+IE5FVExJTktfTElTVEVOX0FMTF9OU0lEPw0KPiBJdCBsb29rcyBs
aWtlIHRoYXQgaXMgYXQgbGVhc3QgbmVjZXNzYXJ5IHRvIGFsbG93IHRoZSBpbml0IG5hbWVzcGFj
ZWQNCj4gdWRldg0KPiB0byByZWNlaXZlIG5vdGlmaWNhdGlvbnMgb24gL3N5cy9mcy9uZnMvbmV0
L25mc19jbGllbnQvaWRlbnRpZmllciwNCj4gd2hpY2gNCj4gd291bGQgYmUgYSBwcmUtcmVxIHRv
IGF1dG9tYXRpY2FsbHkgdW5pcXVpZnkgaW4gY29udGFpbmVycy4NCj4gDQo+IEknbWQgaW50ZXJl
c3RlZCBzaW5jZSBpdCB3aWxsIGluZm9ybSB3aGV0aGVyIEkgbmVlZCB0byBzZW5kIHBhdGNoZXMN
Cj4gdG8NCj4gc3lzdGVtZCdzIHVkZXYsIGFuZCBwb3RlbnRpYWxseSBvcGVuIHRoZSBjYW4gb2Yg
d29ybXMgb3ZlciB0aGVyZS7CoA0KPiBZZXQgaXRzDQo+IG5vdCB5ZXQgY2xlYXIgdG8gbWUgaG93
IGFuIGluaXQgbmFtZXNwYWNlZCB1ZGV2IHByb2Nlc3MgY2FuIHdyaXRlIHRvDQo+IGEgbmV0bnMN
Cj4gc3lzZnMgcGF0aC4NCj4gDQo+IEFub3RoZXIgb3B0aW9uIG1pZ2h0IGJlIHRvIGNyZWF0ZSB5
ZXQgYW5vdGhlciBkYWVtb24vdG9vbCB0aGF0IHdvdWxkDQo+IGxpc3Rlbg0KPiBzcGVjaWZpY2Fs
bHkgZm9yIHRoZXNlIG5vdGlmaWNhdGlvbnMuwqAgVWdoLg0KPiANCj4gQmVuDQo+IA0KDQpJIGRv
bid0IHVuZGVyc3RhbmQuIFdoeSBkbyB5b3UgbmVlZCBhIG5ldyBkYWVtb24vdG9vbD8NCg0KSSBo
YXZlIHRoZSBmb2xsb3dpbmcgZW50cnkgaW4gL2V0Yy91ZGV2L3J1bGVzLmQ6DQoNClt0cm9uZG15
QGxlaXJhIH5dJCBjYXQgL2V0Yy91ZGV2L3J1bGVzLmQvNTAtbmZzNC5ydWxlcyANCkFDVElPTj09
ImFkZCIgS0VSTkVMPT0ibmZzX2NsaWVudCIgQVRUUntpZGVudGlmaWVyfT09IihudWxsKSIgUFJP
R1JBTT0iL3Vzci9zYmluL25mczRfdXVpZCIgQVRUUntpZGVudGlmaWVyfT0iJWMiDQoNCg0KLi4u
YW5kIGEgdmVyeSBzaW1wbGUgc2NyaXB0IC91c3Ivc2Jpbi9uZnM0X3V1aWQgdGhhdCByZWFkcyBh
cyBmb2xsb3dzOg0KDQojIS9iaW4vYmFzaA0KIw0KaWYgWyAhIC1mIC9ldGMvbmZzNF91dWlkIF0N
CnRoZW4NCiAgICAgICAgdXVpZD0iJCh1dWlkZ2VuIC1yKSINCiAgICAgICAgZWNobyAtbiAke3V1
aWR9ID4gL2V0Yy9uZnM0X3V1aWQNCmVsc2UNCiAgICAgICAgdXVpZD0iJChjYXQgL2V0Yy9uZnM0
X3V1aWQpIg0KZmkNCmVjaG8gJHt1dWlkfQ0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
