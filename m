Return-Path: <linux-nfs+bounces-2008-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC7C8591A7
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 19:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521F3B20EC2
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 18:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6525C7E0F2;
	Sat, 17 Feb 2024 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="XL5VaMhT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2110.outbound.protection.outlook.com [40.107.92.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D27E117
	for <linux-nfs@vger.kernel.org>; Sat, 17 Feb 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708193796; cv=fail; b=DEHW0OYhQAxx1fmili7wyJS7RYMaIYISwy/KaSQorFq829vguPqRevzg9a7p/iL31zkUHYRp5pFttW1rRNzVpYv2ccUEKGUi+G4JOhASOnfT0p5WT4ds3JC04V14l1PWU4A7ZynHCGhzlwaD04uG+Qpd54ROAFvFKAY94Y2B7+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708193796; c=relaxed/simple;
	bh=0yFv3jBUaQx2DcTSwHY8/xmBqTfN6zqPKc1372oXajU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BrdhPihJ0jjRqCrqDj+Bj6IaSVNSFNdht6hrxFYyxqajKM8lNQ/Y2LXlXXZSbk3D/R5DZFpip5iYAclwvQXIHwVRRToj+wcj0KAfrUDdpuJhLsCG6yYH5VQ1OtXzT5vRx+mVrFDhUfRoMOeUnaIpedgC+8f2rwQqNAAzvDQ+7Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=XL5VaMhT; arc=fail smtp.client-ip=40.107.92.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=au1vqzLIYPaOGgTV1hNnRztvsm/lLP+w5T5JA6FQ3tTElC1o2TT6c5CygWQ/riqEhtqT35bRiVBCWfCH7Ivyjk8doDuJjzf/Hz+uVg2JD6VHachK79DdVfSg+ORDsVeDXlHGlCMGfMnOsO/ufymsH6of+/5ZX37Sy2ZO5mP1doaBnVjlxWeo1xffElV8c+yxsL8dy2eMI9IXvpwEK0298MVhuhvvDTuhmNy0HQXJWkjvgSGGKfVBQw2OapmFfwsd6VNjtosbaIXGFGqqYbctXIpCcblI64YrO7fCzv6FVI3e7YxgW2NoMFswfqrRfpFz1rA/LuFCOHtuZlmiMHqhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yFv3jBUaQx2DcTSwHY8/xmBqTfN6zqPKc1372oXajU=;
 b=J86S7pAQDA2x71cGHebxqS2I4Qze5+5KvC4vwgjzqyKaRAqCp1mi/nr1Kh66g2PmIVSxPY9xZ+YukHyMdyBqp3BRc5ifGlUHBiE2nDwMfnvH0Ge92+Cgu/NLuiHfSahMhb+t/epOhiKHRwYPo0RPz7UIVweeXcKFUW3TqdeYp8hlwD6ww39xm3kree90envjRjLm4Y+BOQzwPEVvwfj1fqSpEd8O/HGXcHJoyQ4HtgRX7Chaudn4l5LZL0HMQ6pjlhPLI9R0ZgTTZEA4bhDBaun8pqQYbIwAD+JtHn4qXUJWjrnJoCoP2alvynwwhQn1BBGKEQDfwBbxFck5dS+6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yFv3jBUaQx2DcTSwHY8/xmBqTfN6zqPKc1372oXajU=;
 b=XL5VaMhThQrFcY+x/bOu7VGG+0vJwTdH7xUu5/7OkCgXp+iCjcRhMM5ES4FxuOz1dpnkJaKY/1w06I7c7jvntxqY5DRDUdCYNe4h/zaSqb+D+W74VjTP3cmhA3aowvMFc2u23eltejsw72IsUYy6iK+7DJ2N6Wk1eY5YJswsCcA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB5043.namprd13.prod.outlook.com (2603:10b6:a03:369::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 18:16:28 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 18:16:28 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Thread-Topic: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Thread-Index:
 AQHaYHfUW0xTMio2ik6dSCtFnyTgcbEM+KOAgABPaQCAAABugIAAAamAgAAI1oCAAXMrAIAAE8MA
Date: Sat, 17 Feb 2024 18:16:27 +0000
Message-ID: <7b51a5725d82ac9ec8f62bd664004d29a121ba43.camel@hammerspace.com>
References: <20240216012451.22725-1-trondmy@kernel.org>
	 <20240216012451.22725-2-trondmy@kernel.org>
	 <Zc9kQ1Autf6xdcii@tissot.1015granger.net>
	 <ac1166ca466c343f18df45094c0130947bd21f5c.camel@hammerspace.com>
	 <CFBE3BDF-E347-4273-8C7F-A57E0D353457@oracle.com>
	 <756FABF8-FA78-4D16-A4B8-B47C4745868E@oracle.com>
	 <5c35277cd061e16a914b94e070ea6d95a75c1342.camel@hammerspace.com>
	 <ZdDnZmQ5_rAUm6fl@manet.1015granger.net>
In-Reply-To: <ZdDnZmQ5_rAUm6fl@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY3PR13MB5043:EE_
x-ms-office365-filtering-correlation-id: cdc50659-ed95-44e0-907d-08dc2fe48f19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dmfg8BboFloRi4Ttg019D+66cvdYoAyVKpfx9OJZPDQ+r1Y+DkBb1FPVMWzt5WqL9t2jN5Kzep7G45f9ny/Twj94tfgTCGC4lLQur8I5Ufn58kXmOqEzgGcWbvf5TOjgVj0OJhcYvKIqU75R1U7WaVIDV3Zq4N+1Xl87Xbej0u8J0IJm1u0+FmQ5ANWYWyyVZGju/ltWrI/dLJ7mDTKMgG4EWDWqzuVT5b9XIIh5CzpEQAxdCVMVO6ZA8OfTgJKRAgeBzJzo5ckCl3CAZiotaKIcNwUpKVKvZ9mlrAWQPXfGlg/4ijc7osZjteA0VTGO2Sv1jU0zCKSRTxiS6bz/wXWSEl05nAwkm4Hai4h5qtIdmw5IudskWFoS25qKswOSkN0H1bKWS7yjmE6hUBi/cLmSkvVcXx6+FtO5aXjlcsRCyM/EeqjK+JtoUmSabhJmylnO9+G9Gz8GUvKtkcpVA+zzm4LjsTxaFKkKzH6pDFkFRmGm0y5ADc2axeUMycraqWPw+bHje8lBkGsrLrxTYmjFroca/1afVijpSv559q9FkRqlOby0yKtrGSg4kFuYWRK0pZ+HFK4Da3C01/wqPzGu+rJChSqF/xzE5GTpJs520Uubnpqd970r8G8v3h6b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39840400004)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66446008)(2906002)(41300700001)(8936002)(8676002)(5660300002)(4326008)(122000001)(36756003)(38100700002)(64756008)(6916009)(316002)(76116006)(6512007)(38070700009)(66556008)(6506007)(86362001)(53546011)(71200400001)(478600001)(6486002)(2616005)(66476007)(26005)(83380400001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzRpNWVIaGlVQ3g2Rm5QUGRmUjNzMHBESHpNb3pJbUZNZHcyd1k1Tkt1THIy?=
 =?utf-8?B?RUZ3ZE96Z2Z2WmpjZSt4akMxNFp6cmZOYVJSQ01WMFdLK2JpWW5qdXZzam03?=
 =?utf-8?B?QzArWXJiQ0I5UStXanZObkNYTEE5a2J1ZHFMaWZ2NkpLaDBIMTRjZTd4T0E1?=
 =?utf-8?B?bHhOcmNGaGVvWFRXWjlrRmVqbmhEWWhHUzZBTzdscDV2czZGY1EyckNzdVQ5?=
 =?utf-8?B?S0s3TklmYzJQUWV6dkJwV3N3aG1ZakpCM0h3Y1dYU1craHRZNjdaSW5ndlhP?=
 =?utf-8?B?Y09WM3FMdWpjSW1xa0NvVVZyMzh0QU9XbGRhSm8rRHQrWVlHbGtqL21XbnNu?=
 =?utf-8?B?SmRIQ2RZRElQazFkaTBCdXM4WUZUQUozc3YxZllCSTI0MXBqcGJmVTBqRndH?=
 =?utf-8?B?c0ZzSVptK1NzaWtWd3JMQ0JVQUNFR1RDQURJOEQrbUlXNElQVWRIU1lkU0Nv?=
 =?utf-8?B?Nk1PTDd4c3RGUjRQVVZpelBtRlp6R3RneUlMR2pLUmduRUkzSmY3YVhCUTIz?=
 =?utf-8?B?V2V6bEdDbG83U1pzNnk3NFZvSzM3Q3plMVIvZFhzaFVCMkgxQW5Kd2Y1cllE?=
 =?utf-8?B?LzR0c3dDYm45dUFTN2ZURVpyKzdUaU1TSXAvcDdEbXphUGdtUXRGdFArYlUx?=
 =?utf-8?B?MCtlekRJUnM2eXpabTRvR05SNThMNXJyb1h1d3F3dmVUNzIrQUlBdUgrKytM?=
 =?utf-8?B?RnFEcE1qTkxzdW9NOUpXU1pRSVBka2RjQ0ZaWjJTeEl1QldFL1gwU3dOUmYv?=
 =?utf-8?B?Y0JMaEdpTzZHVkpRZkJzVC93Z0pPVnJWT1BxVTVjVW54bnhqTk1qV040OWli?=
 =?utf-8?B?eHFHSldXcU9nK201S25aVmVCWDZML1FUVXpqbHBlVWxVc2FpWWVFemlmNVhX?=
 =?utf-8?B?UytJWDFSeFd5ekdhLy9SSSsyV2JNV0M0aUYvTDQwLzFDSWtJZk1RMnpTVnRt?=
 =?utf-8?B?UnBkbW5mQzI3RHhDTWt2Tkl6RTBWZTN2aDhuUTNNQkVyUUZUanVNUzMyclQ4?=
 =?utf-8?B?OGlzNlNFU2lMZDFLMmp0RUs1SEw4d1kzdE1BN1BrZDg5TlFERnNRWUVLZjFo?=
 =?utf-8?B?V2JoY2M4ZlY0ek1yUVdOZmpoTGpWcVpuMW4wNitETnRHMXFRV3RWcWVkbit3?=
 =?utf-8?B?NHdkUGsrZjJpM3VjR2FYNHFqdUpGN3J0WGNIK2wxS2dBSnI4b2huaHVLa3dt?=
 =?utf-8?B?cDFzKzJoZmNGZ0dBRU9BbnFBMCtCUHdYOTVmd012UWtlTHZ0b1dMZGNGYm85?=
 =?utf-8?B?czJzWlNXYkxJMXJRamtNbURYb0J1WDVXZWM0aStDOWZSTVZtUmNSdEU1MnRI?=
 =?utf-8?B?amtQditrWW04VDllb3V1SjJzRUFLT1dkUElZc2hBN1ZubW1xVzFyczRyeGpk?=
 =?utf-8?B?aTA5eGhBUDBQNjdjenJTUTRQa3l6TkxQU3ljZUQ3NGFadGNPeHF5cVhwNkVM?=
 =?utf-8?B?T1Q4dUxyUHFybHdpc1B4a1pzWGQzZ1RQM2d3SEdPTnp4N2VNSG90aTlvZEZl?=
 =?utf-8?B?cGduN21ERHZVeGRSRUtKcHl3WWZxNGp4RkdzNnh3TkxCTjczU2h5NnRkUnhG?=
 =?utf-8?B?OG94NEE5R2Jndjc3eUF3NXdqK0YwZEp1cEo3WUVUZU1oRjE3V1pCSFIyK0dK?=
 =?utf-8?B?N3VIK0Z4enFZQW5ZM2hRazArMlJWdVFYUG5QNFR6T0VNN090Y0xHZUxuRVlw?=
 =?utf-8?B?YUtTU2tXNVh5a2trRzhmMGF5aHMyQ1BGNm91R0dtWW43MitOdUZZclhiMTVj?=
 =?utf-8?B?VFRtV1BRZFlsOGF2Z05tM05pa1AyRVZpV3VVUVRjaW40dzR2YzFwMHlOWmU3?=
 =?utf-8?B?L0FUN3l3S1pSWlV2b0hwMGdHNndWeTBuZWE5TmExS2JFbi94anA5QXljRDR3?=
 =?utf-8?B?YTh3YkdGNUUzRUh4SXVWT0thUnlUR0o2KzkzSG8xVWRIQU1UbDlpS0JzM29r?=
 =?utf-8?B?cU5rSGluN2RaRWMxREhVTDQ3QzdRWDJuQ1RlWk5tT1hVVFNFOHNsS3U3QjJZ?=
 =?utf-8?B?bTN6bjJkbXZpQWtibTV5dlQ2S1B0RzVhRDRkUzZtbnZhelpFMXlWRi9vYzQy?=
 =?utf-8?B?SGJ2T20wcDJnTHBGN2dQMDVEZndZYjRScnVQZXEyTjgyTnN2a0lBSG9qNWZz?=
 =?utf-8?B?eGtmdjdmZTlBLzZjL3RCUk83WEcxN29vdnl2NE5SaEFFVlJLQ2g2WXFXYlJG?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7655388926616349B79644BF09C8C13F@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc50659-ed95-44e0-907d-08dc2fe48f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2024 18:16:27.9317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+7yQPGJ6YyA+y+bLeOdglUKzhWc/P7BnRk8lZxnDv05FuD0r73R4tvkYLOjjE/wt4n2lmo/LKbOQqjB5lYChw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB5043

T24gU2F0LCAyMDI0LTAyLTE3IGF0IDEyOjA1IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gRnJpLCBGZWIgMTYsIDIwMjQgYXQgMDY6NTc6MTZQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0
IHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyNC0wMi0xNiBhdCAxODoyNSArMDAwMCwgQ2h1Y2sgTGV2
ZXIgSUlJIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+ID4gT24gRmViIDE2LCAyMDI0LCBh
dCAxOjE54oCvUE0sIENodWNrIExldmVyIElJSQ0KPiA+ID4gPiA8Y2h1Y2subGV2ZXJAb3JhY2xl
LmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gT24g
RmViIDE2LCAyMDI0LCBhdCAxOjE44oCvUE0sIFRyb25kIE15a2xlYnVzdA0KPiA+ID4gPiA+IDx0
cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24g
RnJpLCAyMDI0LTAyLTE2IGF0IDA4OjMzIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+
ID4gPiA+IE9uIFRodSwgRmViIDE1LCAyMDI0IGF0IDA4OjI0OjUwUE0gLTA1MDAsDQo+ID4gPiA+
ID4gPiB0cm9uZG15QGtlcm5lbC5vcmfCoHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBGcm9tOiBUcm9u
ZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiBDb21taXQgYmI0ZDUzZDY2ZTRiIGJyb2tlIHRoZSBORlN2MyBw
cmUvcG9zdCBvcA0KPiA+ID4gPiA+ID4gPiBhdHRyaWJ1dGVzDQo+ID4gPiA+ID4gPiA+IGJlaGF2
aW91cg0KPiA+ID4gPiA+ID4gPiB3aGVuIGRvaW5nIGEgU0VUQVRUUiBycGMgY2FsbCBieSBzdHJp
cHBpbmcgb3V0IHRoZSBjYWxscw0KPiA+ID4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+ID4gPiBmaF9m
aWxsX3ByZV9hdHRycygpIGFuZCBmaF9maWxsX3Bvc3RfYXR0cnMoKS4NCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gQ2FuIHlvdSBnaXZlIG1vcmUgZGV0YWlsIGFib3V0IHdoYXQgYnJva2U/DQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2l0aG91dCB0aGUgY2FsbHMgdG8gZmhfZmlsbF9wcmVfYXR0
cnMoKSBhbmQNCj4gPiA+ID4gPiBmaF9maWxsX3Bvc3RfYXR0cnMoKSwgd2UNCj4gPiA+ID4gPiBk
b24ndCBzdG9yZSBhbnkgcHJlL3Bvc3Qgb3AgYXR0cmlidXRlcyBhbmQgd2UgY2FuJ3QgcmV0dXJu
DQo+ID4gPiA+ID4gYW55DQo+ID4gPiA+ID4gc3VjaA0KPiA+ID4gPiA+IGF0dHJpYnV0ZXMgdG8g
dGhlIE5GU3YzIGNsaWVudC4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgZ2V0IHRoYXQuIFdoeSBkb2Vz
IHRoYXQgbWF0dGVyPw0KPiA+ID4gDQo+ID4gPiBPciwgdG8gYmUgYSBsaXR0bGUgbGVzcyB0ZXJz
ZS4uLiBjbGllbnRzIHJlbHkgb24gdGhlIHByZS9wb3N0DQo+ID4gPiBvcCBhdHRyaWJ1dGVzIGFy
b3VuZCBhIFNFVEFUVFIsIEkgZ3Vlc3MsIGJ1dCBJIGRvbid0IHNlZSB3aHkuDQo+ID4gPiBJJ20g
bWlzc2luZyBzb21lIGNvbnRleHQuDQo+ID4gDQo+ID4gwqDCoCAxLiBTRVRBVFRSIGlzIG5vdCBh
dG9taWMsIGFuZCBpcyBub3QgaW1wbGVtZW50ZWQgYXMgYmVpbmcgYXRvbWljDQo+ID4gaW4NCj4g
PiDCoMKgwqDCoMKgIExpbnV4LiBJdCBpcyBwZXJmZWN0bHkgcG9zc2libGUgZm9yLCBzYXksIHRo
ZSBmaWxlIHRvIGdldA0KPiA+IMKgwqDCoMKgwqAgdHJ1bmNhdGVkLCBidXQgZm9yIHRoZSBvdGhl
ciBhdHRyaWJ1dGUgY2hhbmdlcyB0byBnZXQgZHJvcHBlZA0KPiA+IG9uDQo+ID4gwqDCoMKgwqDC
oCB0aGUgZmxvb3IuIE5GU3Y0IGNvbW11bmljYXRlcyB0aGF0IGluZm9ybWF0aW9uIHZpYSB0aGUN
Cj4gPiBiaXRtYXAuDQo+ID4gwqDCoMKgwqDCoCBORlN2MyBkb2VzIGl0IHVzaW5nIHRoZSBwcmUv
cG9zdCBhdHRyaWJ1dGVzLg0KPiA+IMKgwqAgMi4gV2hlbiBkb2luZyBhIGd1YXJkZWQgU0VUQVRU
UiwgaWYgdGhlIHNlcnZlciByZXR1cm5zDQo+ID4gwqDCoMKgwqDCoCBORlMzRVJSX05PVF9TWU5D
LCB0aGUgY2xpZW50IG1heSB3YW50IHRvIHVwZGF0ZSBpdHMgY2FjaGVkDQo+ID4gY3RpbWUNCj4g
PiDCoMKgwqDCoMKgIGFuZCByZXNlbmQuDQo+IA0KPiBBbGwgZ3JhbnRlZCwgYnV0IEknbSBzdGls
bCBub3QgY2xlYXIuIExldCBtZSBhc2sgdGhpcyBhIGRpZmZlcmVudA0KPiB3YXkuDQo+IA0KPiBB
cyBmYXIgYXMgSSBjYW4gdGVsbCwgaXQncyBhbHdheXMgYmVlbiBvcHRpb25hbCBmb3IgYW4gTkZT
djMgc2VydmVyDQo+IHRvIGluY2x1ZGUgcHJlLSBhbmQgcG9zdC1vcCBhdHRyaWJ1dGVzIGluIHdj
Y19kYXRhLiBCb3RoIHRoZQ0KPiBwcmVfb3BfYXR0ciBhbmQgcG9zdF9vcF9hdHRyIFhEUiB0eXBl
cyBzdGFydCB3aXRoIGFuDQo+ICJhdHRyaWJ1dGVfZm9sbG93cyIgZGlzY3JpbWluYXRvci4gVGhl
cmVmb3JlIGNsaWVudHMgY2Fubm90IHJlbHkgb24NCj4gcmVjZWl2aW5nIHRob3NlIGF0dHJpYnV0
ZXMuDQo+IA0KPiBUaGUgcGF0Y2ggZGVzY3JpcHRpb24gc2F5cyB0aGF0ICJDb21taXQgYmI0ZDUz
ZDY2ZTRiIGJyb2tlIHRoZSBORlN2Mw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBeXl5eXg0KPiBwcmUvcG9zdCBvcCBhdHRyaWJ1dGVzIC4uLiIuIEFu
ZCBJIHRoaW5rIHlvdSBhbHNvIHVzZWQgdGhlIHdvcmQNCj4gIm5hc3R5IiBpbiBhbiBlYXJsaWVy
IGVtYWlsLiBTbyB3aGF0IGlzIGJyb2tlbiBpZiB0aGUgc2VydmVyIC9uZXZlci8NCj4gcmV0dXJu
cyB0aG9zZSBhdHRyaWJ1dGVzPyBXaGF0IGFyZSB0aGUgYXBwbGljYXRpb24tdmlzaWJsZSBlZmZl
Y3RzDQo+IG9mIHRoZSBzZXJ2ZXIgYmVoYXZpb3IgY2hhbmdlIGluIGJiNGQ1M2Q2NmU0YiA/DQo+
IA0KPiBJIGRvbid0IGhhdmUgYSBwcm9ibGVtIHJldmVydGluZyB0aGF0IHBhcnQgb2YgYmI0ZDUz
ZDY2ZTRiLCBidXQNCj4gImJyb2tlIiBpcyBkb2luZyBzb21lIGhlYXZ5IGxpZnRpbmcgaGVyZS4g
SSB3YW50IHRvIHVuZGVyc3RhbmQgd2h5DQo+IHdlIG5lZWQgdG8gcmV2ZXJ0LiBCZWNhdXNlIGl0
IHNlZW1zIHRvIG1lIHRoZSBzZXJ2ZXIncyBjdXJyZW50IE5GU3YzDQo+IFNFVEFUVFIgaW1wbGVt
ZW50YXRpb24gaXMgc3BlYy1jb21wbGlhbnQuIEFzIGZhciBhcyBJIGNhbiB0ZWxsLA0KPiBiYjRk
NTNkNjZlNGIgbWlnaHQgcmVzdWx0IGluIGEgbGl0dGxlIG1vcmUgbmV0d29yayB0cmFmZmljIGlu
IHNvbWUNCj4gY2FzZXMsIGJ1dCBpdCB3b24ndCBpbXBhY3QgaW50ZXJvcGVyYWJpbGl0eSBvciBv
dXRjb21lLg0KPiANCg0KQXMgSSBzYWlkIGFib3ZlLCB5b3UgYnJva2UgdGhlIE5GU3YzIGNsaWVu
dCdzIGFiaWxpdHkgdG8gZGV0ZXJtaW5lDQp3aGV0aGVyIG9yIG5vdCB0aGUgU0VUQVRUUiB3YXMg
YSBmYWlsdXJlLCBzdWNjZXNzIG9yIGEgcGFydGlhbCBzdWNjZXNzLg0KVGhhdCdzIG5vdCBoZWF2
eSBsaWZ0aW5nLCBpdCBpcyBhIGZhY3QuDQoNClRoZSBmdW5jdGlvbiBuZnNkX3NldGF0dHIoKSB1
c2VzIHR3byBkaWZmZXJlbnQgY2FsbHMgdG8gbm90aWZ5X2NoYW5nZSgpDQppbiBvcmRlciB0byBw
ZXJmb3JtIGl0cyBmdW5jdGlvbi4gRWl0aGVyIG9uZSBvZiB0aGVtIGNhbiByZXR1cm4gYW4NCmVy
cm9yLiBFaXRoZXIgb25lIG9mIHRoZW0gY2FuIGZhaWwsIGFuZCB0aGUgd2F5IHRoYXQgdGhlIGNs
aWVudCBmaW5kcw0Kb3V0IHdoZXRoZXIgb3Igbm90IHRoZSBvcGVyYXRpb24gd2FzIGEgcGFydGlh
bCBzdWNjZXNzIGlzIGJ5IGV4YW1pbmluZw0KdGhlIHByZS9wb3N0IG9wIGF0dHJpYnV0ZXMgKE5G
U3YzKSBvciB0aGUgcmV0dXJuZWQgYml0bWFwIChORlN2NCkuDQoNClRoZSBwYXRjaCBkb2VzIG5v
dCB0cnkgdG8gZml4IE5GU3Y0LCBzaW5jZSBBRkFJQ1MsIHRoYXQgY29kZSBoYXMgYWx3YXlzDQpi
ZWVuIGJyb2tlbi4NCg0KSG93ZXZlciwgdGhlIE5GU3YzIGNvZGUgd2FzIG5vdCBicm9rZW4gcHJp
b3IgdG8gYmI0ZDUzZDY2ZTRiLiBJdCB3YXMNCmNvcnJlY3RseSByZXR1cm5pbmcgcHJlL3Bvc3Qg
b3AgYXR0cmlidXRlcyB0aGF0IHJlZmxlY3RlZCB0aGUNCnN1Y2Nlc3MvZmFpbHVyZSBvZiB0aGUg
c2V0YXR0ciBvcGVyYXRpb24uIFRoYXQgaXMgdGhlcmVmb3JlIGENCnJlZ3Jlc3Npb24uDQpGdXJ0
aGVybW9yZSwgaXQgaXMgYSB0b3RhbGx5IHVubmVjZXNzYXJ5IHJlZ3Jlc3Npb24uIFRoZSB3aG9s
ZSBwb2ludCBvZg0KU0VUQVRUUiBpcyB0byBjaGFuZ2UgdGhlIHZhbHVlIG9mIHRoZSBhdHRyaWJ1
dGVzIG9mIHRoZSBleGFjdCBzYW1lIGZpbGUNCmZvciB3aGljaCB0aGUgcHJlL3Bvc3Qgb3AgYXR0
cmlidXRlcyBhcmUgYmVpbmcgcmV0cmlldmVkLiBUaGVyZSBpcyBubw0KZXh0cmEgZGlzayBhY2Nl
c3MgcmVxdWlyZWQgdG8gcmV0cmlldmUgdGhvc2UgYXR0cmlidXRlcywgbm9yIHNob3VsZA0KdGhl
cmUgYmUgYW55IG90aGVyIG92ZXJoZWFkIG90aGVyIHRoYW4gY29weWluZyB0aGVtIGludG8gdGhl
IGJ1ZmZlci4NCg0KPiBEbyB5b3UgbWVhbiB0aGF0IHlvdSB3YW50IHRvIHJlc3RvcmUgdGhlIHBy
ZXZpb3VzLCBtb3JlIG9wdGltaXplZCwNCj4gc2VydmVyIGJlaGF2aW9yIHRvIHJldHVybiBwcmUt
IGFuZCBwb3N0LW9wIGF0dHJpYnV0ZXMgd2hlbiB0aGV5IGFyZQ0KPiBhdmFpbGFibGU/IEFuZCBp
ZiBzbywgd2hhdCBpcyB0aGUgYXBwbGljYXRpb24tdmlzaWJsZSBiZW5lZml0Pw0KDQpBcHBsaWNh
dGlvbiBjb3JyZWN0bmVzczogdGhlIGFiaWxpdHkgdG8gc2VlIHRoYXQgeW91ciBmaWxlIGdvdA0K
dHJ1bmNhdGVkIGRlc3BpdGUgdGhlIFJQQyBjYWxsIHJldHVybmluZyBhbiBlcnJvci4NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

