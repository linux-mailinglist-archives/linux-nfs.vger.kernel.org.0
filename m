Return-Path: <linux-nfs+bounces-104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEDD7FA788
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 18:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3FAB21092
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE30EEAC;
	Mon, 27 Nov 2023 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="YD/Kj2zs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2090.outbound.protection.outlook.com [40.107.237.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30171701
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 09:08:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpxIV7E7alk1C5+DAc2wJlXOVv9TXq0ui2+LbQJKc3GL5bl0oiFLJLrK6Z0Cct3NLn3UXDLIhfIx1vhlugbdEkksDE1rOTT2Nt66oNvTkk44LsnZI5TSTNbLBzfCMD/Krw0iZM8H8ofeHd7vK1JlUQkwkQc3dAhB27wb8aVFLXMXROehNvQ4juO2nEeZSdQcTqwo5yTGFnhCSN9XkGX0rdnMoHWH0zoJHssNnyXKyXLaJsUng7px/7AeGGkpo791I5s76X9ual3T9gW/zak2YFJ0912G7G7W09bHvZq/+BxQywvbtxr/b4ciI4nSbISsOUxOOw6bXED6yRutgeFjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VRiZaZi7haF3UW6PwksQtHfmRGnbtOSfrT0GC4tjIY=;
 b=MfcR9IhEDqi0imLMhI8M3g47banmz0zU8sfqmXKTvJ+D3veOMaZ/+PPSJWCo/qug8oF+XWd370F09ZbJCBFpFQhFuJuVDuPckDMYD3ovPU4Dl1Q5SZbzcO2ZyEEeSmwficP9+7J3N1dSHK+W35ZNbE3o1kfbDMCv5rSVhR9Ht/EttzQ9xLH9IQTMQO8j5LM0IGyu98tCZKwOc5Jkk21kux92v7kF4TJ/ufu9PxOaKtF8XzL2A3dPxeQtNjJUISZ/gtZBWk97Haayyqw8DeJXlRAjMxlknc6XlkRtVW1nYsjDm8gh9epTyQv/7923RX88zH48iT/4im4ATLUVBduK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VRiZaZi7haF3UW6PwksQtHfmRGnbtOSfrT0GC4tjIY=;
 b=YD/Kj2zsXYjVOn2X1xs+HtXMWCzHJiVxQF963qVmWDztWOx8HvQ7Nt+mlVVzeHoosxNn0gP1ZFZYOZtA5Sv0eTAmri5EFUtJOsFkKIMwLWu0Ox6wGJQTpC4D9/P+bD6fthWqWQFksDCi3KHfjSryzfJYzvDgmWwKIykYVAcP4PY=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 BL3PR13MB5210.namprd13.prod.outlook.com (2603:10b6:208:341::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 17:08:22 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:08:22 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "hch@infradead.org" <hch@infradead.org>, "tao.lyu@epfl.ch"
	<tao.lyu@epfl.ch>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question about O_APPEND | O_DIRECT
Thread-Topic: Question about O_APPEND | O_DIRECT
Thread-Index: AQHaHjflhODFfyeMXUSkxSGiPt/2HLCLuRkAgAKTcNCAABbagIAACNKA
Date: Mon, 27 Nov 2023 17:08:22 +0000
Message-ID: <20107e878f185628a8d498ebb046e55618abfd4f.camel@hammerspace.com>
References: <c609e5f9df75438dbfe3810859935d58@epfl.ch>
	 <2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
	 <7d2d17e4d3904d29b75fadcfd916b2a3@epfl.ch> <ZWTFn0/FtJ5WuQGc@infradead.org>
In-Reply-To: <ZWTFn0/FtJ5WuQGc@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|BL3PR13MB5210:EE_
x-ms-office365-filtering-correlation-id: 9c1628e6-a275-46b8-7f0c-08dbef6b75ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wTPHfpZCMRqwbAHQzjdBXgvpjy1485LVkftlOjker4PwEokLjTOAwdrwE9vlSzOLVQNDSoY8XH06qqkrFSS2eZUQZa+uji/lSexWfVUIRngTIaZUFfMN7oCmjY4z29Ab+UCVTJqM/96GqtlspUlip6i+BHteteTkhEV4Xw3J/RbSVqWB3OoFfZwCFLqbULoaNnhChZa97iGOoIZzRG2WPcluk3o1GJ1tb/sL1m69qNJnIr0Iyj/1fgOT9N9zRZ1FRQaz+/gw+dD/P0kehtmCkRuAlX54w0HVL6e775/2Vw0Cc8vtp+Oqp+7VdIzOVs5uCSUApA0RUDoWYVXsdcSH4XRBSIKuAORCeasIFgJIFwAx14LzPRlyJ1SfUHFZe4ICytHH8tmcM/ypffTVKQLtzxTlYCrNJ3aTdAiqEr5TXPK/kfCPeFaajaZb98Lq+xIkYgQMK9XgEV6F5gNGQmgFKsffEhlNC/g/zt4zLZNWNlOFLSmL83SQ293F5p04YNcilk/FkqHz+JMyoY2fIdnF0oSroaVOgyOGIZ2phJUqaiD+EniG11Y6LFZ+nAx+JeTdl7qBbxNAWFKmWg2hDTmX6S7VJc0OSrM6KHfjlrvotraixLLGg0VQ/vkoKF29oeMwFiNoBnniAYaNe+OPCyEm8fhlTN9CPJu1p7iyyewod/A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(396003)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(38100700002)(122000001)(38070700009)(36756003)(478600001)(6486002)(66556008)(66476007)(66446008)(316002)(64756008)(76116006)(66946007)(110136005)(91956017)(6506007)(71200400001)(2616005)(6512007)(5660300002)(2906002)(4001150100001)(4326008)(41300700001)(8936002)(8676002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHJrRStuSkxaVFNFN3Fnc2xHTEg2em1xdkg5WU1XNTRkajBBZE9XS3F5S0NH?=
 =?utf-8?B?N3BNMjBNZnpDV0F1WTJtT0ZwSVJ6OFg1YjBFQjY5ODhqU3RZSURtU0dnaHB5?=
 =?utf-8?B?WmkvVFZabFhGbnZtMU5oWG4rdGxDeExnM2ZPbERrK2xpbkVaSi9zRm5XMkhT?=
 =?utf-8?B?ckxHQnhlUm0wMnhLcGs4QjJHa0pFTldTTFhmakFla2cwbmxLdi9ZdnhHbC9w?=
 =?utf-8?B?bWpRQnBRZ2FzcUwybUVXTnhjNjFkWlRtM0hBV0I5dGJqdXIwWEVNekE2UUFm?=
 =?utf-8?B?U3NVTi9sNU5RWnE2L0pyY242RkJkMy9xV1ZLQzFIK0RJRitrWlA5MmR0Z3d1?=
 =?utf-8?B?NmQ5VzRBTk1GaEhwakQ3aHl0bGZndWc2aHBlb1F4NFVyOVVDVEtDcW9uV2Q1?=
 =?utf-8?B?ZmwwUVl3amdHYUM4Q0FYdGRmVWhQbG5OWE04b1QyS2I3RitOdzJNOUI1M3dB?=
 =?utf-8?B?UzAxLzRZaGdvT2QvUTNwV3l0RTZndG4yVUh6NFdsUmxRSEkyS0tlZWVxdEhy?=
 =?utf-8?B?cTlBSHZtMVFnOFpocS9UVm1UT0xRdkw1Rmx4OFBwM0NoOUtHSjl5R2hVZCtH?=
 =?utf-8?B?bVVNYnpIV3JjWlUrTWxrajdPL1dGSmMxbDRITUlKYXN6QU5COGx0UFppaWhJ?=
 =?utf-8?B?bjc5TXpyYWxieGJIMFMyK2dGamhBWElHZE5zcURlZlNjR2RyYWdIZHhKK3VZ?=
 =?utf-8?B?dVVIOEJYWGhEbFlTSlh4a2FFSjBrNmlCQlBueDJLQzhicFN0WS9HK05ETzRw?=
 =?utf-8?B?VHZTMGNOWHlsbkorSkJPTGVMQ1V0SktwejNtKy94OHFQaXk3YUVTVXZuWHg5?=
 =?utf-8?B?V0p2U2l1MVI1ZFhRZ2NkelZEZllheXdDaC9Cc2dkc0NUdExZYmlFdWw4cldq?=
 =?utf-8?B?cEROTnhWTkp5WjBsZGhKLzZJUWJaUzlJWG5XNXh1Zk5LamtZR2tHVklBU0dM?=
 =?utf-8?B?ZTB6Y3dOaGVsYjRhTG5EUHNRdk1lNENjVDVXaURHcDZ1TFM5R3dPM2c2dGE4?=
 =?utf-8?B?T1FldUYrRVY1N1c5TWF6YjVQZnJDQXRESUsrREdFT2lxWENITERHVGJwU3dC?=
 =?utf-8?B?Zm9Zb3kxbzIxdkdDdUt3WmJzN0k5OWNJQzByU2VUd2J4SDdud0tlV01RZm5r?=
 =?utf-8?B?ZkY4STYrR2lWM3BHSFRIR2xtcVFjZXc2a09LYUs2WHU3azhuWnJjb3lnSTgz?=
 =?utf-8?B?ZExiM2RjcVlFRnFFREtROXQ2WDNTeXdMZzQxQlp6V3g3bHUyUkkycXU1NnEx?=
 =?utf-8?B?Smo4MmtWRDRVdWxvd3g3MGtJOXJGRm1xRGhQQkFldXVLWlNUTFk0MHU0M2dv?=
 =?utf-8?B?cGsyUUIzcXc0RzdhR2xodUxqd1dHZkVJNmNjYXZ5K1FNdHhzeTBNeUIxR0pV?=
 =?utf-8?B?NXAxWkVCcFQ3NTNmRHFsekt3SkRIYU91QVUzNlZ2Q0JNN1ZKcVdPdWJ0RUVL?=
 =?utf-8?B?c2ZVQ1NpYm9mM2dIMXE3YjViZkxJNER0OUY4eVhvTG4vaGlqQTlDNTVOejJu?=
 =?utf-8?B?SXc1UHRhaFBxeEp5THRDY3hMQUR5NzBveFJjSHRYaDlOdjkva2g2MmRmbzBu?=
 =?utf-8?B?a3FwYzNlMnZWYmJqRVFtK0JLdlZZemJmaDBRTzBMd0dNbUNPRU9IWmpvcU14?=
 =?utf-8?B?RU90RDhDaUJSL28vOVE2a1AybGExci9OeXN4d2JzQVVWNnRrUTVRZWJ6ejF3?=
 =?utf-8?B?MmwvSEU4bmdzTmZWTWJhWnN1dzV5Yis0TFcyekhFTURnSmJPMFdpUEhsSWNW?=
 =?utf-8?B?TG5kMHkzOWIvenF0ZzNUdGJvTHIrdU9JYXhOakNsaFFOMFQ0V2JjVjVqWmpX?=
 =?utf-8?B?SFYvT25vaU14cDNxWmpkRUNQZ0pJSTJKcnFIaVkzUG9CNEdEV21RMmkvTDN1?=
 =?utf-8?B?ZTZBTjU4S1pRZitiK3Z6MmpyY3lhM2hJdEtGNHRTZk51REZzaThMQ3Y1Rkpp?=
 =?utf-8?B?T3VNVG5aeWpWRjZUVkxoMllKNVhPL2czN1lGelhQS1QyWlIveDBnaDVaS0Jy?=
 =?utf-8?B?ZnUvMzRoVG5raHpvc0dMeEZoUTZncDZkcThHMVdnL3NCSHUvdmRIK1htbmVJ?=
 =?utf-8?B?VUJNOWgvR1lLS2ZsOERnYTN3c1B4VTU0L1lIckY1UkxTN3QxV0pXU251RlEv?=
 =?utf-8?B?VnV5bzhWOC82NjR5YjVsOERMOXZNMEZ4WGJjN3g0eFgvVjg2MkVhM09JdE9N?=
 =?utf-8?B?Q01pRFhpaGJyN2hlTFJrZ25DcGxobUJRR2dTK24vcXY3UGtUSUFYYnVIWXF1?=
 =?utf-8?B?M3puZzZhYUlrS1dvdXFia1crM3l3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA8DA921BE8D734BB2A4B0CA8B84CA17@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1628e6-a275-46b8-7f0c-08dbef6b75ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 17:08:22.2004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SCBtItWW4FgfHlHVH99VIFq+DlWgud4FL/yQzRBSEIVME5ozGCOxjJ8m17wV/Z4oBuFHGQ/Yj4KAkxwx+C9q0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5210

T24gTW9uLCAyMDIzLTExLTI3IGF0IDA4OjM2IC0wODAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gTW9uLCBOb3YgMjcsIDIwMjMgYXQgMDM6Mjg6MTZQTSArMDAwMCwgVGFvIEx5dSB3
cm90ZToNCj4gPiANCj4gPiBPX0FQUEVORCB8IE9fRElSRUNUIGNhbiBiZSB1c2VkIHRvIGJ5cGFz
cyB0aGUgY2xpZW50IGNhY2hlIGZvcg0KPiA+IG11bHRpcGxlIHRocmVhZHMgd3JpdGluZyBkYXRh
IHdpdGhvdXQgY2FyaW5nIG9mIHRoZSBvcmRlcnMgKGUuZy4sDQo+ID4gbG9ncykuDQo+ID4gDQo+
ID4gWWVzLCB0byBzdXBwb3J0IE9fQVBQRU5EIHwgT19ESVJFQ1QsIE5GUyBtdXN0IGZpcnN0IHN1
cHBvcnQgQVBQRU5ELg0KPiA+IEJ1dCB0aGUga2V5IHBvaW50IGlzIHRoYXQgbG9va3MgbGlrZSBO
RlMgaGFzIHN1cHBvcnRlZCBPX0FQUEVORA0KPiA+IGFscmVhZHkuDQo+ID4gSSBjYW4gc3VjY2Vz
c2Z1bGx5IG9wZW4gYSBmaWxlIHdpdGggIk9fUkRXUnxPX0FQUEVORCIuDQo+ID4gDQo+ID4gTXkg
Y29uZnVzaW9uIGlzIHdoeSBORlMgc3VwcG9ydHMgT19SRFdSIGFuZCBPX0FQUEVORCBpbmRpdmlk
dWFsbHkNCj4gPiBidXQgZG9lcyBub3Qgc3VwcG9ydCB0aGlzIGNvbWJpbmF0aW9uLg0KPiANCj4g
V2VsbCwgaXQgZG9lcyBzdXBwb3J0IE9fUkRXUnxPX0FQUEVORCwganVzdCBub3Qgd2l0aCBPX0RJ
UkVDVD8NCj4gDQo+IEJ0dywgSSB0aGluayBhbiBBUFBFTkQgb3BlcmF0aW9uIGluIE5GUyB3b3Vs
ZCBiZSBhIHZlcnkgZ29vZCBpZGVhLA0KPiBhbmQNCj4gSSdkIGxvdmUgdG8gd29yayB3aXRoIGlu
dGVyZXN0ZWQgcGFydGllcyBpbiB0aGUgSUVURiBvbiBpdC7CoCBOb3QgdGhhdA0KPiB3ZSAoRGFt
aWVuIHRvIGJlIHNwZWNpZmljKSBwbGFuIHRvIGFkZCBzdXBwb3J0IHRvIExpbnV4IHRvIGFsc28N
Cj4gcmVwb3J0DQo+IHRoZSBhY3R1YWwgb2Zmc2V0IGFuIE9fQVBQRU5EIHdyaXRlIHdyb3RlIHRv
IHRocm91Z2ggaW9fdXJpbmcgYXMgd2UNCj4gaGF2ZSB2YXJpb3MgdXNlIGNhc2VzIGZvciBvdXQg
b2YgcGxhY2Ugd3JpdGUgZGF0YSBzdG9yZXMgZm9yIHRoYXQuDQo+IEl0IHdvdWxkIGJlIGdyZWF0
IHRvIGFsc28gc3VwcG9ydCB0aGF0IHByb2dyYW1taW5nIG1vZGVsIG92ZXIgTkZTLg0KPiANCg0K
Tm90ZSB0aGF0IEFQUEVORCB3b3VsZCBvbmx5IHJlYWxseSB3b3JrIHdpdGggT19ESVJFQ1QsIHNp
bmNlIGl0IGlzDQphbmF0aGVtYSB0byBjYWNoZWQgSS9PIHRvIG5vdCBiZSBhYmxlIHRvIGNvbnRy
b2wgdGhlIHBsYWNlbWVudCBvZiB0aGUNCmRhdGEuIEhvd2V2ZXIgaXQgaXMgdXNlZnVsIGZvciB0
aGUgY2FzZSB3aGVyZSB5b3Ugd2FudCB0byB3cml0ZSBsb2dzLg0KDQpJbiBhZGRpdGlvbiwgdGhl
IG1vZGVsIHdpbGwgYWx3YXlzIGJyZWFrIGRvd24gaWYgc29tZW9uZSBkZWNpZGVzIHRoZXkNCndh
bnQgdG8gd3JpdGUgYSBsb2cgZW50cnkgb2Ygc2l6ZSA+IHdzaXplLiBPbmNlIHlvdSBoYXZlIHRv
IHNwbGl0IHVwDQp0aGUgZGF0YSwgeW91IChvYnZpb3VzbHkpIGxvc2UgdGhlIGF0b21pY2l0eSB5
b3UgbmVlZCBpbiBvcmRlciB0byB3cml0ZQ0KYSBjb250aWd1b3VzIHJlY29yZC4NCg0KLS0gDQpU
cm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

