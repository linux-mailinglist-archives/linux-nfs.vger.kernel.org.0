Return-Path: <linux-nfs+bounces-135-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54F17FC321
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 19:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D47B20E4E
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 18:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4B3D0A5;
	Tue, 28 Nov 2023 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="LOyXz0hU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2139.outbound.protection.outlook.com [40.107.92.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBD3170B
	for <linux-nfs@vger.kernel.org>; Tue, 28 Nov 2023 10:28:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2QYfuufkmKYOV74ZaM4+3qOMR0nV30bNH1ILlHg4UNcLQ6ExF4hg8zQhE7HG+e+2WCeQfvF3JDoMRIU0TLvg7+AbdIm3tYR3SBRwyuZ7SkNgpG7/EV6dPxS7WbDq0wRxBwE/TP11p2iycMUOnBAVkZr2/KTfKzpHffaclVYy16Lq9FCQAcIGaR3/MUhRYanWsAr4a/aa1LjuZWJoSdBbdBAQFIFjao8exZ+F8FlObsOB9YBK1RGhBT+5Vt4VHRqduZZusC7io9t4iz7EC38am6Wp4RMeCNXskAihE5BAd7cWBrNc/kKOmvMX8atpNAE99TT9Sp11ebHptWVQyFF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KU5MtP2fjPZlMfG4/7R0y4e3+75Gmw/yUi9UlQ8WKE=;
 b=K4GD9qdRlyWWVLplujZc+g94+Sa7/9ktqo88KODJ5UFxmDiZszu9uKt7Mz0msqEngFspJMKEkvZuHz2Onhk3auou9uKVfsa/VpOD5vjAajAKj9Fn64k7B7psTM3HoaftBGO3X0irD8uoqtBpEBm29XEGXZ61L6RaIW3mqkGm3i37k9GZeETTpHy6jv2wqy8UIsTvi4VlsrVZCk+8GvzxiaVEts9xfBFqlqGPbtExLQdT8iq6hVGpAvgjOAbgqdem6LygdDX9osqSKg9dQSzC73xDcpReihUXH6e+WAcdFxrQeI6oBkHwSYLayr8hz4W8Wcnxqg1NaIZ0y7R+KWxtfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KU5MtP2fjPZlMfG4/7R0y4e3+75Gmw/yUi9UlQ8WKE=;
 b=LOyXz0hUsN1bUM1TJYTF/LR1WPqEku4z2an24+h/XId4ctC3nMEtMKWv42+FaDUbDTTql1izYZ7my8jhf9lXmAYpAYrVkC77dgIs7N2kAr4Sn1U9ao6zuGf6KHq5x9/6UsCLh3bCIe7Bh58mAsJtHp0EqC6KOqFVxQFYEoNRh6c=
Received: from BL3PR13MB5073.namprd13.prod.outlook.com (2603:10b6:208:33c::7)
 by BY5PR13MB4471.namprd13.prod.outlook.com (2603:10b6:a03:1db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 18:28:14 +0000
Received: from BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::d405:57ad:ac67:fb8c]) by BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::d405:57ad:ac67:fb8c%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 18:28:14 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "rick.macklem@gmail.com" <rick.macklem@gmail.com>, "hch@infradead.org"
	<hch@infradead.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "tao.lyu@epfl.ch"
	<tao.lyu@epfl.ch>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Question about O_APPEND | O_DIRECT
Thread-Topic: Question about O_APPEND | O_DIRECT
Thread-Index:
 AQHaHjflhODFfyeMXUSkxSGiPt/2HLCLuRkAgAKTcNCAABbagIAAA+kAgACW44CAAL2BgIAAWSkA
Date: Tue, 28 Nov 2023 18:28:13 +0000
Message-ID: <6d6ba42df68d4639742ed42a00bd08ea608892a6.camel@hammerspace.com>
References: <c609e5f9df75438dbfe3810859935d58@epfl.ch>
	 <2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
	 <7d2d17e4d3904d29b75fadcfd916b2a3@epfl.ch> <ZWTFn0/FtJ5WuQGc@infradead.org>
	 <7E2914D2-B9AB-4280-9A44-875DA8B58328@oracle.com>
	 <CAM5tNy4qVXXS3sHqx7Y3Ndt2YNnd1hrj32iJdo9KMi+ByMfEuQ@mail.gmail.com>
	 <ZWXmcYy8NElP0FC2@infradead.org>
In-Reply-To: <ZWXmcYy8NElP0FC2@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR13MB5073:EE_|BY5PR13MB4471:EE_
x-ms-office365-filtering-correlation-id: a8bf854d-4ac2-4353-3737-08dbf03fc87a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 M/nIVICwc9IAWHKqSaDs055aa76E6Ham1LLUOw67R8ffSvhPJNEFcHDe4462dnglvZkpBm7qp4hFXk5JMevpbFayi36pg9Cr6H1LwNXmHCAIN5YRQf8lcm6FHO7NvHj2xZoiaLjo/RHAdRxHOnIbzQjjmwLh2jLERGiXX9Xc4jvoW++vTKPjJbQ7GQ/IUnvMGGkNzpukF6t3gK+eohKDsalEVI7VT7PpulI3VbNlGXQDIj/YUS4zFQvsZ5EkfFlyKcfmrkbsDUlAGU4g7St7lctrxhmpSRvbyHggMj3zd+Sn4vjU9D1nzXuidFkmhwnRtTFqKv9K0JLHece8BE49uKLsRFtQI/x/aTerBM4xvU8Yiat86ojbBT2wO1BdnU25ZxuGiVmLEGCri+b9Uj6bqyxiX9Uiz2TIAuRMQB/7m989HBuX0FzFyto4xsFa/2NP2c/uCKDvltTz5BmrzzMVZI7YY2ymFIEEIXPrkmHmAi+QzRcZFXYwuxQgG32/m7EGuwY5rcCdx9qVmInMEFc8GyDPQaP+H5SKvV6PUDUASAQ/NPihH4pAMCTlLSYM6ejhEs/y3nMT6tnSZ4c4ypOKWqhfW3q/Q5AfwN476ZfPsRW147nP+WDkcAxZzwfSxlKLEagklKC7U/quriYdiMxkFrmYStgogrrRu6kPvjnE4WU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR13MB5073.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39830400003)(136003)(396003)(366004)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(41300700001)(38070700009)(36756003)(2906002)(122000001)(4001150100001)(83380400001)(5660300002)(54906003)(86362001)(64756008)(2616005)(6506007)(71200400001)(8936002)(6512007)(8676002)(4326008)(6486002)(478600001)(66899024)(110136005)(66556008)(76116006)(66476007)(66946007)(66446008)(91956017)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGZ2ZFc5cHZYUHBDODFtSDJadlJQcUUyS3lqYkMza1JLRThjZ2EweEtIQU56?=
 =?utf-8?B?MFQrNHBXWFVoT2hsQ3FHeWlIMkVHS1VHYmo5UWw2WWNXdk14Zk8vOGFtN1pV?=
 =?utf-8?B?ZkwzMTd3eWdjV0tPQ2lJdWk1dVBZNU9HZVlLelRGTEJlQjJzM2QrNHVZWm5q?=
 =?utf-8?B?SWlmTk5QUlNvZkhuTnJ6dlgrTkVoTlZCNFgyYmg3aVAwTlZ4RW1zYm13YWx2?=
 =?utf-8?B?NkVtVWZOY3Vtdi9yYWtOZkJ5SkdDalhzNjlwVERoR2s1ZzJXSllHc01Lcmpt?=
 =?utf-8?B?TW1KcXJCeldGZFpaMDhJR2RRRTJSZ2wzcHZqOTVHSTdOTjNFSHQzQ0J0YkRS?=
 =?utf-8?B?YVVPYklyM1R0b09KbU1oUGIwLys4UVI3RW9EWHpydFoyRTNTVDhKakdkUzVw?=
 =?utf-8?B?WmVIM1llQ2VmaWV3RVpJaUVRUGI3MEhBQzJqTncwaXJ0MGUrY2RYd1FZYzc3?=
 =?utf-8?B?U1FhMnZPZHQ1UkF6V1oycXcvSWV0VFd5MGNFVkZJL1R6VFJ6blgrY1dIZHlZ?=
 =?utf-8?B?blBCRGZuUU81RHNWUjRyVVA1QTVmMEJpYkpFREpLc1M0V0dpYWQ4V1hwYU5J?=
 =?utf-8?B?ck5lMUZubnY1bDFOR3pqT0V0UllhUDNVS1hwVlZScUtjR1hpNGVveDdvMTNO?=
 =?utf-8?B?aVErb3pTOXZiK29VTWd1anRMS3BhYmw2NXFnbHYwSDVTdlpnSnB6dExxWUhH?=
 =?utf-8?B?SWRQNERMc3F5WkszM3piVGZzYTdEVnQreS9ZTzZsanE0WXgxeEttS25IcEFB?=
 =?utf-8?B?NDNURXFPVGZWVVBpSGFmMFNQSG9jWU5DYmpoRHA2VWQ5bUM0ZW5MTDRZQlp0?=
 =?utf-8?B?VXV5UWlkSjBJVU5meWR0VFdMVzAvTGxacUg3UHVxWHNWWW43dHNRdkZwRExM?=
 =?utf-8?B?VG9CMXhrMlloeGJWN0JNdzMrc0xVb0JsM3c0cW1PdFVsSDBEb0R5RldpdFpp?=
 =?utf-8?B?Sm54SGE3KzZWaWRnUHFqbDVKUzBtYTVUdHZTWjZQcUFLZExONTNPWVpiWG1h?=
 =?utf-8?B?NlZscy9pOGlsdFR5ckozSTk2S05JejkxcWh6ZDlWTWlDeGlCNnlCRWtYeUFK?=
 =?utf-8?B?c3VxS2Z0QmhFRjJGN2l6TVFpdi9id29CeDdZN210RzVMdlFHNnpKMU1sRzg1?=
 =?utf-8?B?SmRRcndLaUxCSGkzSmQzRUJrTFFqaFJuMXdtbDQxZWJZUUxlM2gxTEhSckxq?=
 =?utf-8?B?SS9GRC9HWitVaUZxUm5wQlJzOVhNempnQjdRS1RMNTJkMlo5MU14WlhKeEIw?=
 =?utf-8?B?aXpsWERhdDlOV2VubUhJNGg5L0ZvVGlPbFgrNXdaMEZxSzh0V251Q1RKYzJ1?=
 =?utf-8?B?bWs3M0ZyT0dvb1g4bEs4YTdrWVpXK3gyRlJxSk40TEhMM0l2WmFTSVNpbSth?=
 =?utf-8?B?VDVBalBvVGY5WEpqQlZndlNDZ2NFNmxhZ1hYYmJtcXNMYkYxeFkzbHBGRVpq?=
 =?utf-8?B?Y3hNZGF1S0Uvd3pkZWwzNWpYOW5lb1pLSU96S3BsVzBJMTdSaGlVQlBpTVNt?=
 =?utf-8?B?ZGFYdHAxNXZwRXdyTW5QS2lpKzdId1dURzhJZVlTRWM4ZzRITE1BZXZtSy80?=
 =?utf-8?B?OG1yTXFheDJ3d1FYYzVFcEh4RytLSU9kcnNJb2pjZ2ZqRjc2UWxCdW5jckxI?=
 =?utf-8?B?bHlPYWpqN3lIVVJxaUkzdHNWbW9QOXUrbEswNk5QLytPNSt3amh6VDdOSTZt?=
 =?utf-8?B?MG9mYnNIN012ZDlCcmt4eWFDZ3lWNjdubHhrTEl6bkxNZldkUkMxdjh0N0lK?=
 =?utf-8?B?N2RYUmdDRWR1b0pLaWNYN2RCa3dWcXVpMHBVSGhQTjNSVy90M1ZHbzhFQkgr?=
 =?utf-8?B?SmxhMEFjblRSV2liZzNtR0lvZVRqS0pmTVcyZjFjMXJ2VWM1ajFhM2NwT3lZ?=
 =?utf-8?B?aW5XSjFkbVFoMW1CUkJUQ0FMdm9HZzByMWlrZG5jQ3dmZlhNTm0wYkg2T3pN?=
 =?utf-8?B?OWJhTXNtOEk0VWJ5eDg3dm9TSHIrRDhXM3lqc2ZONldKTUdrVytSZkZYZmpy?=
 =?utf-8?B?QXVwbUdHOG5lSzJCMXV3VUZ0dTBYZVEzcmw5ZDVIRlJFTzFNSWZsd0VrZVBQ?=
 =?utf-8?B?OE9SZ0FPVk9VamUyTHJYSFpMUXZoTGdIeW9LSnBDeU9NTklSMTRCWWx1dDlN?=
 =?utf-8?B?dUlIa2ZzZjlTZkZhN3Uwc1p0QW01Z0R6czRaUHFrUGgwc0RTT2VTdEdLR0d6?=
 =?utf-8?B?SnVaQm9JTTBFa2VoRzY0cnFkM1J1SHR0b0VnWm9OdlY3UzlpWkFwQ0hNRzB0?=
 =?utf-8?B?VDg5bTVUbXJBTi9FOVIwM2V5UVh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ADEC305AFEF234CBF6C89CDB898F6D4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR13MB5073.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bf854d-4ac2-4353-3737-08dbf03fc87a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 18:28:13.9494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PaVOKMjIKXbd9VcZrHCuzQp2ufo+r4poRu8b/ueZzSreqzhznIY8hPNAFsApHtbysMuh0aV/UKwqTnkIwEmtAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4471

T24gVHVlLCAyMDIzLTExLTI4IGF0IDA1OjA5IC0wODAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gTW9uLCBOb3YgMjcsIDIwMjMgYXQgMDU6NTA6NDlQTSAtMDgwMCwgUmljayBNYWNr
bGVtIHdyb3RlOg0KPiA+ID4gPiBXZWxsLCBpdCBkb2VzIHN1cHBvcnQgT19SRFdSfE9fQVBQRU5E
LCBqdXN0IG5vdCB3aXRoIE9fRElSRUNUPw0KPiA+ID4gPiANCj4gPiA+ID4gQnR3LCBJIHRoaW5r
IGFuIEFQUEVORCBvcGVyYXRpb24gaW4gTkZTIHdvdWxkIGJlIGEgdmVyeSBnb29kDQo+ID4gPiA+
IGlkZWEsIGFuZA0KPiA+ID4gPiBJJ2QgbG92ZSB0byB3b3JrIHdpdGggaW50ZXJlc3RlZCBwYXJ0
aWVzIGluIHRoZSBJRVRGIG9uIGl0Lg0KPiA+IEl0IGlzIG5vdCBlYXN5IHRvIGRlYWwgd2l0aCB3
LnIudC4gUlBDIHJldHJpZXMuDQo+IA0KPiBJbmRlZWQuDQo+IA0KPiA+IEkgc3VwcG9zZSBhIE5G
U3Y0LjIgZXh0ZW5zaW9uIHRoYXQgZWl0aGVyIHJlcXVpcmVzIChvciBzdHJvbmdseQ0KPiA+IHJl
Y29tbWVuZHMpIHBlcnNpc3RlbnQgc2Vzc2lvbnMgbWlnaHQgd29yaz8NCj4gPiAoUGVyc2lzdGVu
dCBzZXNzaW9ucyBzaG91bGQgcHJldHR5IHdlbGwgZ3VhcmFudGVlIGFuIFJQQyBpcyBub3QNCj4g
PiByZWRvbmUgb24gdGhlIHNlcnZlci4pDQo+IA0KPiBJIGd1ZXNzIHNvLsKgIFRoYXQgb2YgY291
cnNlIGFjdHVhbGx5IG1lYW5zIHdlIHJlbHkgb24gYSB2aWFibGUNCj4gaW1wbGVtZW50YXRpb24g
b2YgcGVyc2lzdGVudCBzZXNzaW9ucy7CoCBUaGUgTGludXggc2VydmVyIGRvZXNuJ3QNCj4gc3Vw
cG9ydCB0aGVtLCBhbmQgSSdtIG5vdCBzdXJlIHdoaWNoIHNlcnZlcnMgYWN0dWFsbHkgZG8uDQoN
Ck5vYm9keSBpcyBnb2luZyB0byBpbXBsZW1lbnQgdGhlIG92ZXJoZWFkIG9mIHBlcnNpc3RlbnQg
c2Vzc2lvbnMganVzdA0KaW4gb3JkZXIgdG8gYWRkIHN1cHBvcnQgZm9yIEFQUEVORC4NClRoZSBv
bmx5IHRoaW5nIHRoYXQgd2lsbCBiZSBhY2hpZXZlZCBieSB0eWluZyB0aGUgZnVuY3Rpb25hbGl0
eSB0bw0KcGVyc2lzdGVudCBzZXNzaW9ucyBpcyB0byBlbnN1cmUgdGhhdCBwZW9wbGUgd2lsbCBj
b21wbGV0ZWx5IGlnbm9yZSB0aGUNCnNwZWMuDQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxp
bnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20NCg0KDQo=

