Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EB04837F1
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 21:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiACUMD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 15:12:03 -0500
Received: from mail-mw2nam08on2110.outbound.protection.outlook.com ([40.107.101.110]:11666
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230182AbiACUMC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jan 2022 15:12:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7P3wa67KGSPonN591ztX80axvxwlRu3RPfwZoSluhsmVTlcOtZ16VotACvdZk35pTl8V/3rNOio+peo1k7VxWTXwNySksnHyOXbk0vOp7OwBkt++m2yK1q9JQFR0b31ol3zUyUDQqrs6AQB1dMKPjMfnS8T8ayAoWYZNNNyGUROEF/HOVca2Nu61P2U7+Wa51jpXgQDW3QmN1kg0pHCzFUdIJFEi/ff5ev1wPbwGH/F1S6+ihZjykVfvG98rAbOoLB3aDqMta/4rJo9suSNiuUEAgnEdi+PDKpsSMBeufIds2WXGJURlBaMfkZGhVUSxz6iludjxC3ZOoey5Zbr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTwOmZkSSUfZTs1VLUss0WNRHUyXiRFjfvHIT3EOswQ=;
 b=mqomCCFfVaaUE3+dr93n7/eOalX/O1tMRWg3kWKiXdOjXZbFnoJHOxFvxOY20M7XuPKwWHmICtxk7ZDgg3CKBdlxLpUo4k2Mv2gbsAf/AXFlRRChsVc+kUvn0Vl6QssDayTVVuoX9I2yVMNckO+DbtOaeFILtKfiyfl1Wabvqd1XWm7yNLVwjDKsjvX9EzayD6/E7wMnoBlxWkrGbK8vXcDyc2ItLafdLT+BYHdgzOQ4BchSe+y1zzrc57j4/VPQNyi7LxdZ2JxRQlhUL1D/UYmLMwCPJS9oRqVR5Ix0VMkAob0zFKvYEPY9nKfiZwf9m+XkmeTFYSFAcexrGbdLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTwOmZkSSUfZTs1VLUss0WNRHUyXiRFjfvHIT3EOswQ=;
 b=OO/5GSlpIP+vDZYBXNk6izpccPbV496fckuKoFWFf9f737IdF6+HsKhwwI5z3xzAwHkABkXWF2YkMmakWXvOWvrcpIiA5aKJ1R75d/46nGPqJR/WBi7tkf5slXN12EOmcPO7hMGwDkpGZ1EQkFk+qr8QxZx9Nhmq2cWsNwnLfKU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4392.namprd13.prod.outlook.com (2603:10b6:610:9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.4; Mon, 3 Jan
 2022 20:11:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.006; Mon, 3 Jan 2022
 20:11:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/5] Support case insensitive filesystems in NFSv4
Thread-Topic: [PATCH 0/5] Support case insensitive filesystems in NFSv4
Thread-Index: AQHX84bH/VRHsN5KMEWL2EjK4fwOv6xR1GCAgAAA4YA=
Date:   Mon, 3 Jan 2022 20:11:57 +0000
Message-ID: <cb2b119e0c95c8d9d783d8b28c7f2bc7973f7598.camel@hammerspace.com>
References: <20211217203658.439352-1-trondmy@kernel.org>
         <20220103200847.GH21514@fieldses.org>
In-Reply-To: <20220103200847.GH21514@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55624f32-1ee8-49e5-2e5d-08d9cef54b9a
x-ms-traffictypediagnostic: CH2PR13MB4392:EE_
x-microsoft-antispam-prvs: <CH2PR13MB439298BEAA258B78C739D088B8499@CH2PR13MB4392.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 86wInu8pL3OiPoTgnjAxr0FZbHF1tq5GxqY/U8b5ppYttlhZQMbPeWYY9FcT5SXA0Pbg66sGKIwl5QIM1im3NZLJ81/ie0APnb/IOQUm1maycXSxkTVLJJXfxdm5S1mw6t7e85XsU36O6YATKnOJ/+Y3WfrSwOCARIzAXaoHL5PKjoDLezwzrwLrnDHRyM+HuNFZBLCBJaOfOOdOTr128o9O1UtIWJG/Ov1wes1m+6M9RCdcX1Ag69mbFBXPhZ5D4AGNLw6LPDi75mUX9RdsDWr6esjKLtB6qtTUzJgVN7YY8nKkH7WbBGyUbDNg8pHWBfPP9F6gVYL1NUeW10ekTwbyTp8gIGIuN5pStdMAvdxKlXPTlsyqpvIypNMTDIOo10+p6lH+ikN1VKKwdrL3RNp1BwcQtCyK7gqGvF8B9sM0nBusxxHGtrdc0Y1ED0wO3U2nFpNfp/kS9+Gul8yGbcsKdUocVv7BsmM0P4L2xMCLXO3/A+IGgLgbDCfeOTKuaaJkCxG7DjPBrwOhaCCpXw20Gb/EuFTaMfksflHD5EuMtiFeXBix36pBBm3CvjtunTeLm7KSPHp2EDIBKDXNyU5zkbrQrocf0dofs+9PhTrOaLaxjJhRIDJcE7Gd+OYnQa1azMbt8V5iET6kpO12kATKcG/h5NXtvlRs2VrrU5UvBRPcT4TBgMkEQC9R8/uho9tFZcT1KxT5P3iTChr09w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(366004)(136003)(376002)(39830400003)(346002)(38100700002)(36756003)(66446008)(66946007)(66556008)(6512007)(4326008)(8676002)(76116006)(508600001)(54906003)(66574015)(110136005)(83380400001)(66476007)(8936002)(64756008)(6506007)(316002)(38070700005)(6486002)(2906002)(26005)(2616005)(122000001)(71200400001)(186003)(5660300002)(86362001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnBzVVBuMWFESHlYQXZiaC9tSlZlQ1VxUkFwdzkzeHErOG5pQlAya1BPSlNq?=
 =?utf-8?B?UllqVlRKdlJIUjFEMTQySENTa05tcklsSEdic2R6SW1WRzRJRnBGUGlLVGk2?=
 =?utf-8?B?b2FRTWtRNndUTEx6eHM1K2sveTJMcUhpNlkwNURMNGlZSStsVGh2ZnlCcnMx?=
 =?utf-8?B?WG1FNXlsQVY0SUxSWE1Xa3NCUk0rMy9BREdPUEZRdjRCbkdwUWlldHVVVE00?=
 =?utf-8?B?MmpKTTI4ZmQyQWFGRFpYZTVMdkt2SmxKTUdkTm9sbi92cVFDVlZXUnoxaXRs?=
 =?utf-8?B?WFUyaFRqck9CRXZpM3E4R2dtZzZUVlF6SGlCTFJadnE2ak1vTXViN0RDNjFs?=
 =?utf-8?B?T0RFYzNvNU5aWE11dThmQXVuUitOUnF0ekM5TTRFSExEQTlzMG91R1lEUWRM?=
 =?utf-8?B?UmxWV0RJR3VCdlpzMkZFekJhaXNyTlkya0RiWGgramF3VHk2d3lRbklZdXNa?=
 =?utf-8?B?K3lNZmkwYjI2UFhIZjJ3Zlowa0JLUUpJcG16STMzdTc1cVN4QXdxOU9LWXVa?=
 =?utf-8?B?QWdwcDVKM2FyRWFBdDZySWxWOWJialRzMld0WTBCRDA2bjkrQWY2bEJpYjN4?=
 =?utf-8?B?bGZUTEk1YkpncFgwRnNESnhkQm9xdzl6R2Y4d1d3dGVxWWhDN3NnUGFxdUlk?=
 =?utf-8?B?VlRBbE9ZV3NmTERGdnFTaCt4eEJYS21Ec1p1MVhjZGdoaGxGaitXZXRrVE44?=
 =?utf-8?B?SktqdkFSVkVxa01FZ0VybHFkN2MrWkVLaVF2bmVmUHNoVW1aajZTWHJjb3BL?=
 =?utf-8?B?UUR3ZzlVTGhJZUxtRExLRHNUS3hkUHBKMitFclFMOWtsangrbXNYeDBVT3hQ?=
 =?utf-8?B?NVBRQXFPYXE5elcycmhYelZXU0ZkdTUxc0hlaUNzWjJuZEI5WWdPZ0EzaW51?=
 =?utf-8?B?R212Wk9QUlY1b3dFMWkyVitTUXg3dlJJcGlqNVlpZWVCcVJjdG94cUgyTXpG?=
 =?utf-8?B?dGlXTGxNR1d2NEt2aFd3RTNwY29QOWtOSFYzSXJzZFd5eUxLbng5akZDNTh5?=
 =?utf-8?B?ZlZuZEFiK1EzRGRBUnZoWjVMdHExbDB3TlU5aXpCZ3pEQUNvQ2hIT25EeWZI?=
 =?utf-8?B?UVY1WkF5K0VvUHI1OHVHNkFVNE5DWm1DcGxGN2FqR0VIcnE1Y0duZ2IyOG9O?=
 =?utf-8?B?WWJnRmh1Zks4SUgzaXd1ei9NV0w2Q1Q4Q0VLRndmc0tNOFBjWTZGTjdFMlRt?=
 =?utf-8?B?RnNkbG0vTlFnbmNKdks0YmF3eSt6VWhZQnJ4TlROSXpoWWpZSzZXSkhoKy9v?=
 =?utf-8?B?U2xZSEhqc2xjNlRNSk9qTzJ5bkxDbU42MytFWGxTZEV0a0pLY095Z2I3amE4?=
 =?utf-8?B?emZvM0NCZUlxQVZrbXRDa2hjcnRVMGdLc1V0anROOGZieVl4SkpzM3NlTHpt?=
 =?utf-8?B?dlJBMkZnZWZnZW41M1ZsZDBFNkFmUjRuVzlrVkx4YW5SN0pEMGlZQTN3a0x1?=
 =?utf-8?B?UjdreWtrNXlYeFppWDFLUzVmYy9MRnJmYzJuSWxYTUhoSS9wWmwyNThEVzg1?=
 =?utf-8?B?cHpGRXpkdHBNTHVDOHhIUVpKeDc1Qy93VUNHbktEZVUwZm9OQk5MRDlaeWJa?=
 =?utf-8?B?aFhEQmgvcHpBaGNCUk5kc0ZJZ1ZERnVkUU1PTkdJOTBCb3kwYVEwOTFtZXl4?=
 =?utf-8?B?ZWNQRjl1OVFadE9YR3lFR1pJNVlEVXZVcDdnSys0YlQ5enViNTE2a3dlT1ZW?=
 =?utf-8?B?QTVDdFZxUzBVa3ZzUHFjUTFTd2IrNWExTjJoL1B6OEJ1NDVVdVc1SVdGQlpk?=
 =?utf-8?B?VmJPZlExeUxNRzJBUStFTHRjTytMTVpBODRHL3NNVnE0dlB4UmM2VUhXdElB?=
 =?utf-8?B?TkltQXN5MHhvczdTMzU5UnZUZWNTbW56REpwU3c0dFZYK012SjR0dEozLzNZ?=
 =?utf-8?B?SGF3YzdzaDE4clJGOVVnQkpGTDQrQ1dnSUNwczVrOWpTbk1WdlRpcHJiaGtY?=
 =?utf-8?B?UVJOd0tPNVJCRFo5ejZtd3lUWXFqYkZkQjR0OXJpRFdhSkFKa0t1S1gwVHRG?=
 =?utf-8?B?cm81cXg3MzFsbkZMUUNwQnpEZDd6Y1FDeXRmcHdtVmlRcitrNm9RMEsvVktu?=
 =?utf-8?B?eTV3N3VCVGs4SXl0d1J1RkZhTmNPYllDMHJnVldKUm9qNzNaV21ZVXZMbG5o?=
 =?utf-8?B?SmpBYnUzUVpnTlVJRDNNM25lK1loY0tpQlg1dXBVS2NyQXdkWnFEVFpqSDd3?=
 =?utf-8?Q?+l7RlXhcA8Ll2Ru2AGiiBs0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FF5B03055CBCE4EA851EA8B6A4C2225@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55624f32-1ee8-49e5-2e5d-08d9cef54b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 20:11:57.8956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2P1AQnTfmhsYX4waj8Not7wFSNEj2kjzY9WlENFLFrfc3xg+Zf5EANk10abfDSon2x4bjKHN7t/b3Gj/Nw7aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4392
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTAzIGF0IDE1OjA4IC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIEZyaSwgRGVjIDE3LCAyMDIxIGF0IDAzOjM2OjUzUE0gLTA1MDAsIHRyb25kbXlAa2Vy
bmVsLm9yZ8Kgd3JvdGU6DQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IA0KPiA+IEFkZCBzdXBwb3J0IGZvciBkZXRlY3Rpbmcg
YW4gZXhwb3J0IG9mIGEgY2FzZSBpbnNlbnNpdGl2ZQ0KPiA+IGZpbGVzeXN0ZW0gaW4NCj4gPiBO
RlN2NC4gSWYgdGhhdCBpcyB0aGUgY2FzZSwgdGhlbiB3ZSBuZWVkIHRvIGFkanVzdCB0aGUgZGVu
dHJ5DQo+ID4gY2FjaGluZw0KPiA+IGFuZCBpbnZhbGlkYXRpb24gcnVsZXMgdG8gZW5zdXJlIHRo
YXQgd2UgZG9uJ3QgaW5hZHZlcnRlbnRseSBlbmQgdXANCj4gPiBjYWNoaW5nIG90aGVyIGNhc2Ug
Zm9sZGVkIGFsaWFzZXMgYWZ0ZXIgYW4gb3BlcmF0aW9uIHRoYXQgcmVzdWx0cw0KPiA+IGluIGEN
Cj4gPiBkaXJlY3RvcnkgZW50cnkgbmFtZSBjaGFuZ2UuDQo+IA0KPiBXaGF0IHNlcnZlciBhbmQg
Y29uZmlndXJhdGlvbiBhcmUgeW91IHRlc3RpbmcgdGhpcyBhZ2FpbnN0Pw0KPiANCj4gDQoNCk91
cnMuIFdoeT8NCg0KPiAtLWIuDQo+IA0KPiA+IA0KPiA+IFRyb25kIE15a2xlYnVzdCAoNSk6DQo+
ID4gwqAgTkZTdjQ6IEFkZCBzb21lIHN1cHBvcnQgZm9yIGNhc2UgaW5zZW5zaXRpdmUgZmlsZXN5
c3RlbXMNCj4gPiDCoCBORlN2NDogSnVzdCBkb24ndCBjYWNoZSBuZWdhdGl2ZSBkZW50cmllcyBv
biBjYXNlIGluc2Vuc2l0aXZlDQo+ID4gc2VydmVycw0KPiA+IMKgIE5GUzogSW52YWxpZGF0ZSBu
ZWdhdGl2ZSBkZW50cmllcyBvbiBhbGwgY2FzZSBpbnNlbnNpdGl2ZQ0KPiA+IGRpcmVjdG9yeQ0K
PiA+IMKgwqDCoCBjaGFuZ2VzDQo+ID4gwqAgTkZTOiBBZGQgYSBoZWxwZXIgdG8gcmVtb3ZlIGNh
c2UtaW5zZW5zaXRpdmUgYWxpYXNlcw0KPiA+IMKgIE5GUzogRml4IHRoZSB2ZXJpZmllciBmb3Ig
Y2FzZSBzZW5zaXRpdmUgZmlsZXN5c3RlbSBpbg0KPiA+IMKgwqDCoCBuZnNfYXRvbWljX29wZW4o
KQ0KPiA+IA0KPiA+IMKgZnMvbmZzL2Rpci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0
MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+IC0tLS0NCj4gPiDCoGZz
L25mcy9pbnRlcm5hbC5owqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+ID4gwqBmcy9uZnMvbmZz
NHByb2MuY8KgwqDCoMKgwqDCoMKgwqAgfCAxMyArKysrKysrKysrKy0tDQo+ID4gwqBmcy9uZnMv
bmZzNHhkci5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgNDANCj4gPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+IMKgaW5jbHVkZS9saW51eC9uZnNfZnNfc2IuaCB8wqAg
MiArKw0KPiA+IMKgaW5jbHVkZS9saW51eC9uZnNfeGRyLmjCoMKgIHzCoCAyICsrDQo+ID4gwqA2
IGZpbGVzIGNoYW5nZWQsIDkxIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4gDQo+
ID4gLS0gDQo+ID4gMi4zMy4xDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQoNCg0K
