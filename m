Return-Path: <linux-nfs+bounces-1819-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96984CD91
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 16:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF5A292EF4
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25567E77B;
	Wed,  7 Feb 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="HwUy4TiM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2098.outbound.protection.outlook.com [40.107.243.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21B1D548
	for <linux-nfs@vger.kernel.org>; Wed,  7 Feb 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318164; cv=fail; b=GUs9fY+qohicqBa8FlrAHEM01YJ/B7mkLsBC/m3fcxKAXjxkDWIkYyIqohFPWQ926/ngqfT9PizjdqzU73EC2mDc8G1v7/Yh2OtFLl+qntr8YiN6al33kRlXV97hICKtOtAQ6FuY1+gtIIseOGuZ9NXOHISjRiqGyFFxFwJjSHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318164; c=relaxed/simple;
	bh=DGhq78KQFS/ivPQjIl2y5zyuQkKUFByRmhG8LMnTqVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gdJ66ThHbnvCX4dYvKiLXaqezaRAB8lQhsn5VKQVSFHK60+i4cqbnWUnFljF3vt3XoFU2aKRIEUeg/cUd/M+6vrc4q/uyylwM543BKWHK/SdwXt/vQhJQAGTGLrps6dZoF82WfHIxeF0thuYl7Kq2VjaqkQ9ps4o6psyyvw7S5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=HwUy4TiM; arc=fail smtp.client-ip=40.107.243.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyCogC9o4l9BO7Fziq0Q9/24sqbp8EPnX/Y99xKEcVh3vr/Ds7IgmYEi6U0xRhI+LsAPJAl4Gk+F7gwIdybdJtgCjMY+8qpaO+36reYnRlw6Rw1BAslmQW/bdsf5aape53bwH0p/uUQhtOBOyNPOweoaYu1IjRhrcSafbDoQmUg/TAAkYkHfVBmgT0gVEWXKZTqZYWOJxT9kdzSZ+/03UtMJw62ianCg7g+RMjGxlhtGC8cKJ65RzyOeAIIPOTLeh0A4u8qA9mpzX0/a5IkiaswEiHuszk+U7sEF4cMTILAJCoqZoIWPFJOuqHxQJHhhNXgjK0gKsRx1K8Dpkucfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGhq78KQFS/ivPQjIl2y5zyuQkKUFByRmhG8LMnTqVc=;
 b=Xz1+ZSJOnA8EScElacOfkI4Qe1CZwrrYyTUbe9q+7/ZhBmJXd8zXzOXRsDLxXiDO/Ag9iNhcEbVa2i4feMT+AaX+OaD3VNbTQDUBfvUQD1gwWPZALiV1twAL4BM0wxrnUb3tnxVX+SJnZ6v4KfAzsMQ3RrayHYfO20D9pXLlnbopH+9+CFz8VTVGVqd/om1vUfaeq+5qmYuzwmFJV3sRtYjG2vq/nbQLrYvTlyxEHdCT4IJTRdQe3LQAPsLekWFwJtGlBmiESezE/Qat//kPGw6TgrxCk9tvzLxWXNWVSf9lje3GG72K0mP17NAZj0cBoZFHyNfTrvGG7CE5/8z0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGhq78KQFS/ivPQjIl2y5zyuQkKUFByRmhG8LMnTqVc=;
 b=HwUy4TiMTEUxu+2XLOacBmRqQ3uei7Ojv7brGU3FLlhz7dzHlAJYjr6efGG9XkrEC3BoefSZweuvcYx4CmCYQlKvMkdp1InmF74+IDGbJBWiKmyA6/V8CJ1SidsSLwocx0kQc92P/LKVxmNBHVHSmpLuthSCQ30Ivj4usfQgJPg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3776.namprd13.prod.outlook.com (2603:10b6:208:1e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 15:02:40 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a%5]) with mapi id 15.20.7249.037; Wed, 7 Feb 2024
 15:02:40 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
CC: "rick.macklem@gmail.com" <rick.macklem@gmail.com>
Subject: Re: when should the client request a directory delegation?
Thread-Topic: when should the client request a directory delegation?
Thread-Index: AQHaWcppe3dWAatSzkyuu9kjNEc7UrD+7lAAgAAJqACAAAHUAA==
Date: Wed, 7 Feb 2024 15:02:39 +0000
Message-ID: <c6a10b1b0c7bcb3af364c1c07840f4e67279982a.camel@hammerspace.com>
References: <57b9f5e0c3ec7bc09044b016a3822d0700760c55.camel@kernel.org>
	 <71e5d519411330ee608415fa629322fc84de8139.camel@hammerspace.com>
	 <67cd74bcebdbbfcd0cd46702e3c5c971f743dfba.camel@kernel.org>
In-Reply-To: <67cd74bcebdbbfcd0cd46702e3c5c971f743dfba.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB3776:EE_
x-ms-office365-filtering-correlation-id: 929e1b9d-1b00-4f7e-7226-08dc27edd430
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 enVF+nxTcLdpoIm37KxajAWuKogGqrpeF1niQSkDG61doU6xULhl151DpuJwysupqUktiPFShXnqkfBgaOxU0F8DAjc3RYaP02QKjrDMx9ZG93gDgg2AFRqyqupiI3aIbwuhQDHS47DD0XF3a+l1KpRl2qzXmGiG/aDsoxv3aAksw2Zkl9Q8AIeP9Y1qc1gPZ9MxB4cSlefAV+18lyyEhX+v8w7laOowXLvQwSH8GMiKSciOtHSvNy5RN/fdQXvOM23LSM0qUI5D+Nhqpn24kvOmtcVZ71eqGp6MGgTHv1956xbZlGGQinmcK588vsP4vhhjWi9P6pcssCHs3MEJ+Ct3rOg47wT6w6CGOU/lQfg7FAhICBHfjpUnQ6iY7d2byI6KxFtG389H+/ZxKvOK/1cJzJFmlXrzb6WtYYtE/p4cYZG86kFqd+MClo80HrSrHATaKW9lYclzDM1tCtVxE62bNSLNOoP7RskfQD51G+Y91WRlOw/5dZP4emfcLEcMcgEOoZXMgzW8kYOQzaNu6x8a+a7D8YLxRP128yJOARxwo8H0YI3907NDckQAIyP8nsUYfBPq87iMqm1s0UyaFP1PrUstYUoP7MgGqsdqsAS1ltM4qevXcKBVF+BFfC/t
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39840400004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(76116006)(41300700001)(86362001)(8936002)(8676002)(4326008)(6512007)(6506007)(36756003)(478600001)(6486002)(71200400001)(2616005)(5660300002)(38070700009)(110136005)(66946007)(66476007)(64756008)(66556008)(66446008)(316002)(2906002)(83380400001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3BDeTJjV1dlYmVlN3dSSW90Ky8yNi9pNE5CcmVQWmNPZ2RFalA5bFFRN3BX?=
 =?utf-8?B?L0RQQ0x0QlhveVhUQkV3S0ttZEVMTmRvNUlETXh0UytXQW9leXFKYnFZZndR?=
 =?utf-8?B?Nk9TNUd4QklJSEVYNFdoTVRpWlZXcWVaRzRyRlFYRHpaZWlWKzhNTE53OWQ3?=
 =?utf-8?B?R3BxaFdSaytJdWpUWXMrNkFIL1BIZzI5OTlyYXl2MEV5aUhZRExFSExsRm9N?=
 =?utf-8?B?dStQOGpGb0dqY095Njd5cHhGRHl4OHFRbGltenhFakxuR3ZkUm9idjJaOUlR?=
 =?utf-8?B?WGtSUjFXdlo4SnpBb1BzUHJNVVZFY3h5ZGdkck92Z29DdFd3SnIzTnByTTlD?=
 =?utf-8?B?RlF3ZG1RM0pjSXNzMXpWME5saittYmdobUlSK1YzSkxRejdxdzBTZ0N2U0hN?=
 =?utf-8?B?M2s2MWlVZnR4ZmZhUytTMGMwWkdRc0huWFFQWlBqN2VjUzNhSXorU2dFYWZE?=
 =?utf-8?B?WGM2b1F2UG9IaUFDRWVQR1pJdmhRbUV4WEw2M1BKcS9PdUdwenkzQ3VFcGRB?=
 =?utf-8?B?WVdOVW4zc2N6RVJ6Q2FXODU4Q2lBei8xamFsZmFJS3JoajZXUFQxYWpHdXBY?=
 =?utf-8?B?YXpNanlOZGxsc1lzbXlPalJzSjFoYkVrWWpHenUyL3FNWUFEMHN4T0pIQW5x?=
 =?utf-8?B?Y0VxRmpMV1d5UCtGODkzMnloUm85QitUNGhRdWVFM2tvd3hxZkdUaFZpUUVj?=
 =?utf-8?B?V1R1Q2g2VFpkZ3g1SjdQMHpUZWEyd3QzcUVadHZnS1BRdnJSWklCVldxdkdV?=
 =?utf-8?B?dUxFeHlzMnU1WHFmSGFIYkg5UzdvclRKU2w1YkJ5YTZxZFVJcEcwcE4vS1hI?=
 =?utf-8?B?a1RLcTBPVWlYUmNYTlAvRzZPaXRRWGtpc2hiekEyNmtjTzAwYU5yS0RZYTI5?=
 =?utf-8?B?dWZ1Rk80RWtHT0VhUVVRYmxaeEdnbVYzbldpUkN0Vldhc3VvdXZ5dFd5M1Nm?=
 =?utf-8?B?Z0IraXBtdlNqcENxcFVyQ2tvQXpsdEszdEJ3alpISlFncjUrcXVKY050eThx?=
 =?utf-8?B?QzJoVkcvMHlCY2RWeGhLcDdhUjRwTzlFTnFOQ0RKZi92blVhcjhZZmNIR1I0?=
 =?utf-8?B?K3ZVNVRRbHl6anpUMCtkaUdQOVg5ZDgzTzlva2hTdFhYaG1BMEh5a0ZXQkRp?=
 =?utf-8?B?Y3lzSzQ0STNYZFN2eGwxUWNkeElvVWwxNkpWaXk4QVArSC95c3FpK3YxeUJM?=
 =?utf-8?B?Y1VjNHFaVENoY09RSzllb3BIeWVQM1JoMHdTUnNWWjgzRFhJNllrT3dDNEFR?=
 =?utf-8?B?bE9qMk51YzlsTHc0TW5KQTlwQ2U3RjdHRWh2d3FYaHBDVWU0SHhIa1dpdnYv?=
 =?utf-8?B?cUNicnRFSHBSOXZPQytvY3ZCYnRMU0gveFlNNUhqVlFVRnZFbCt4N1E0U0xr?=
 =?utf-8?B?MFk2MzRpOFVpY0J5eFZhdXVzSkpONXZpYlo1SExUNUQvRFZCZko0MnpFQ3RT?=
 =?utf-8?B?RGF3ZTA0ZDJZSUE5c3FSM3gxalF0NzF2VHprSjZqdDl5Zk44WTlyWFZQbjVP?=
 =?utf-8?B?ekw2U1NLS0RHOVJsTnFGaHFIRGIxNEhha1hVSHkvSVBkS1NnMlc0aEcwWEtO?=
 =?utf-8?B?Q1E4VW00NzVlbysxenlZbGhHTCsrT0RQNzkwMDNVQjlHTkt6Q0tVdlBGM254?=
 =?utf-8?B?VUpVckdFTGpGV0hlV1B4R2dmNjJtL2dQMGZMN2czcDZvRURhNi9BdWxEWXBh?=
 =?utf-8?B?RkY2eVpFemNUb0lLMVdnZ01uWVZ4NDBVSURrNHB1MVBrVGZGSkpabDRHc1hp?=
 =?utf-8?B?N2xQcm1jaUtrVHJVbmc2UmliaVdZVUM4aGM3WUtGQWRYM3hZVi81Wlo4SEY2?=
 =?utf-8?B?Rm9sb3NDa2c2alg3YmpadmxpcXFkeGZyU2cvVjNiUk56VnYwQnFOOEcrRWc4?=
 =?utf-8?B?QTdPRFVpMGpEYno0aCtEWFNORHUvOVFQb2dKOWZVbEROeU9kTGhtZTZLaVlh?=
 =?utf-8?B?eXpJRzNyYytJeDlKbWtGQXdDZzM2bEExYUpTZ1czKy9WNitUQmgybG41R1R5?=
 =?utf-8?B?ZHVGVTBIeXRjYjhTRkRZTjQ1Y1pTUkZMeDE3blRycno4eUlKTDBWdk1uWVI1?=
 =?utf-8?B?OWpOQzV5NC9tTFpHaWJxc2lZLzVyN3g4U1EzamdNc3BldDRPVDl5c2JRQWpl?=
 =?utf-8?B?UFg1Vm9BaC9rVHJxTThyUjBoeUdrWndTc2JyRDYwUkd4OGZZTXBtZEhncGFR?=
 =?utf-8?B?SE5oVklSKzJnamlsRWkvZ1RWd21yUFRYRE1zckJNOGpNMmlpRlhMODVZZUZi?=
 =?utf-8?B?VzlnMklyNnR2UzFYaXlqcVRqZ1R3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78B515063FE88C47B0D983632C67B793@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929e1b9d-1b00-4f7e-7226-08dc27edd430
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 15:02:39.9976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icV05ajspWv85q7rkbIJbmyfSXTwiihYARuxiC3eSo2CVNTC6GX81BdamI1S67ymL8OkbafNLcZX2qdTYVwfhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3776

T24gV2VkLCAyMDI0LTAyLTA3IGF0IDA5OjU2IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gV2VkLCAyMDI0LTAyLTA3IGF0IDE0OjIxICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gV2VkLCAyMDI0LTAyLTA3IGF0IDA4OjM0IC0wNTAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IEkndmUgc3RhcnRlZCB3b3JrIG9uIGEgcGF0Y2hzZXQgdG8gYWRkIHN1cHBvcnQg
Zm9yIGRpcmVjdG9yeQ0KPiA+ID4gZGVsZWdhdGlvbnMNCj4gPiA+IHRvIHRoZSBMaW51eCBrZXJu
ZWwgY2xpZW50IGFuZCBzZXJ2ZXIuIEl0J3Mgc3RpbGwgdG9vIHJvdWdoIHRvDQo+ID4gPiBwb3N0
DQo+ID4gPiBhdA0KPiA+ID4gdGhpcyBwb2ludCwgYW5kIGZvciBub3csIEknbSBqdXN0IGNvYmJs
aW5nIGluIGEgaW9jdGwgdG8gZHJpdmUNCj4gPiA+IGl0Lg0KPiA+ID4gDQo+ID4gPiBBcyBJIHN0
YXJ0ZWQgd29ya2luZyBvbiBzb21lIG9mIHRoZSBjbGllbnQgYml0cywgaG93ZXZlciwgSQ0KPiA+
ID4gcmVhbGl6ZWQNCj4gPiA+IHRoYXQgSSBkb24ndCByZWFsbHkgaGF2ZSBhIGNsZWFyIHBpY3R1
cmUgYXMgdG8gd2hlbiB0aGUgY2xpZW50DQo+ID4gPiBzaG91bGQNCj4gPiA+IHJlcXVlc3QgYSBk
ZWxlZ2F0aW9uIG9uIGEgZGlyZWN0b3J5LiBJdCBzZWVtcyBsaWtlIHRoZXJlIGFyZSBhDQo+ID4g
PiBsb3Qgb2YNCj4gPiA+IHRoaW5ncyB3ZSBjb3VsZCBkbzoNCj4gPiA+IA0KPiA+ID4gT25lIGlk
ZWE6IHJlcXVlc3Qgb25lIG9uIGFuIGluaXRpYWwgZGlyZWN0b3J5IHJlYWRkaXIuIFNvIG1heWJl
DQo+ID4gPiB3aGVuDQo+ID4gPiB0aGUNCj4gPiA+IG9mZnNldCBpcyAwIGFuZCB3ZSBkb24ndCBo
YXZlIGEgZGlyIGRlbGVnYXRpb24gYWxyZWFkeSwgZG86DQo+ID4gPiANCj4gPiA+IAlQVVRGSDpH
RVRfRElSX0RFTEVHQVRJT046UkVBRERJUg0KPiA+ID4gDQo+ID4gPiBPciwgbWF5YmUganVzdCBk
byBpdCBvbiBhbnkgcmVhZGRpciB3aGVuIHdlIGhhdmVuJ3QgcmVxdWVzdGVkIG9uZQ0KPiA+ID4g
aW4NCj4gPiA+IGENCj4gPiA+IGxpdHRsZSB3aGlsZT8NCj4gPiA+IA0KPiA+ID4gV2UgY291bGQg
YWxzbyBkbyBvbmUgb24gZXZlcnkgbG9va3VwLCB3aGVuIHdlIGV4cGVjdCB0aGF0IHRoZQ0KPiA+
ID4gcmVzdWx0DQo+ID4gPiB3aWxsIGJlIGEgZGlyZWN0b3J5LiBJJ20gbm90IHN1cmUgaWYgTE9P
S1VQX0RJUkVDVE9SWSB3b3VsZCBiZSBhDQo+ID4gPiBzdWZmaWNpZW50IGluZGljYXRvciBvciBp
ZiB3ZSdkIG5lZWQgdGhlIHZmcyB0byBpbmRpY2F0ZSB0aGF0DQo+ID4gPiB3aXRoIGENCj4gPiA+
IG5ldw0KPiA+ID4gZmxhZy4NCj4gPiA+IA0KPiA+ID4gV291bGQgd2UgYWxzbyB3YW50IHRvIHJl
cXVlc3Qgb25lIGFmdGVyIGEgbWtkaXI/DQo+ID4gPiANCj4gPiA+IAlQVVRGSDpDUkVBVEU6R0VU
X0RJUl9ERUxFR0FUSU9OOkdFVEZIOkdFVF9ESVJfREVMRUdBVElPTg0KPiA+ID4gOi4uLg0KPiA+
ID4gDQo+ID4gPiBBc3N1bWluZyB3ZSBjYW4gZ2V0IHRoaXMgYWxsIHdvcmtpbmcsIHdoYXQgc2hv
dWxkIGRyaXZlIHRoZQ0KPiA+ID4gY2xpZW50IHRvDQo+ID4gPiBpc3N1ZXMgR0VUX0RJUl9ERUxF
R0FUSU9OIG9wcz8NCj4gPiANCj4gPiBBcyBmYXIgYXMgSSdtIGNvbmNlcm5lZCwgdGhlIG1haW4g
Y2FzZSB0byBiZSBtYWRlIGZvciBkaXJlY3RvcnkNCj4gPiBkZWxlZ2F0aW9ucyBpbiB0aGUgY2xp
ZW50IGlzIGZvciByZWR1Y2luZyB0aGUgbnVtYmVyIG9mDQo+ID4gcmV2YWxpZGF0aW9ucw0KPiA+
IG9uIHNhaWQgZGlyZWN0b3J5LCBwYXJ0aWN1bGFybHkgZHVyaW5nIHBhdGggbG9va3Vwcy4NCj4g
PiBpLmUuIHRoZSBnb2FsIGlzIHRvIGVsaW1pbmF0ZSB0aGUgbmVlZCB0byBjb25zdGFudGx5IHBv
bGwgdGhlDQo+ID4gZGlyZWN0b3J5DQo+ID4gY2hhbmdlIGF0dHJpYnV0ZSwgYW5kIHRvIGVsaW1p
bmF0ZSB0aGUgbmVlZCB0byBjb25zdGFudGx5DQo+ID4gcmV2YWxpZGF0ZQ0KPiA+IHRoZSBkZW50
cmllcyAoYW5kIG5lZ2F0aXZlIGRlbnRyaWVzISkgY29udGFpbmVkIGluIHRoZSBkaXJlY3RvcnkN
Cj4gPiBhZnRlcg0KPiA+IGEgY2hhbmdlLg0KPiA+IA0KPiA+IFBlcmhhcHMgdGhhdCBtZWFucyB3
ZSBzaG91bGQgZm9jdXMgb24gYWRkaW5nIGEgcmVxdWVzdCBmb3IgYQ0KPiA+IGRpcmVjdG9yeQ0K
PiA+IGRlbGVnYXRpb24gdG8gdGhlIGZ1bmN0aW9uIG5mc19sb29rdXBfcmV2YWxpZGF0ZSgpIHNp
bmNlIHRoYXQgd291bGQNCj4gPiBzZWVtIHRvIGluZGljYXRlIHRoYXQgd2UncmUgZ29pbmcgdGhy
b3VnaCB0aGUgc2FtZSBkaXJlY3RvcnkNCj4gPiBtdWx0aXBsZQ0KPiA+IHRpbWVzPyBUaGUgb3Ro
ZXIgY2FsbCBzaXRlIHRvIGNvbnNpZGVyIHdvdWxkIGJlDQo+ID4gbmZzX2NoZWNrX3ZlcmlmaWVy
KCkuDQo+ID4gDQo+IA0KPiBTb3VuZHMgZ29vZC4gSSdtIG5vdCBuZWFybHkgYXQgdGhlIHBvaW50
IHdoZXJlIEknbSBtb2RpZnlpbmcgY2xpZW50DQo+IGJlaGF2aW9yIHlldCwgYnV0IEknbGwgcGxh
biB0byB0cnkgd2lyaW5nIGl0IHVwIGluIHRoZSByZXZhbGlkYXRlDQo+IGNvZGVwYXRocyBmaXJz
dC4NCg0KVW5kZXJzdG9vZCwgYnV0IHlvdSBhcHBlYXJlZCB0byBiZSBhc2tpbmcgd2hpY2ggQ09N
UE9VTkRzIHRvIG1vZGlmeS4gSQ0KdGhpbmsgYSBkaXNjdXNzaW9uIGFyb3VuZCB0aGUgZ29hbHMg
b2YgaW50cm9kdWNpbmcgZGlyZWN0b3J5DQpkZWxlZ2F0aW9ucyBuZWVkcyB0byBpbmZvcm0gdGhh
dCBjaG9pY2UuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

