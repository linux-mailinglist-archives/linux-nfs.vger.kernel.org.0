Return-Path: <linux-nfs+bounces-1827-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32F584D2D7
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 21:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35171F2357C
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E427C8286B;
	Wed,  7 Feb 2024 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="fm10+LDZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61DA126F37
	for <linux-nfs@vger.kernel.org>; Wed,  7 Feb 2024 20:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337381; cv=fail; b=t9Ww5LQoToF2ehKvwZTTWVzrSV1bwzTwxncGarEuX/MmE21uwW73rLbjQxtTIKaY4fY31VBiyLGuP2DohUmio3R9M7moKhwVE6+wW+mKjH4FcU3Y3JVrihubDDQ9mBzUM2X9xPunuu3RJquAH3jL0eiAalQfEncMBfa0ojTG+3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337381; c=relaxed/simple;
	bh=KXsN7cNx9wqenfmgzmMYOSCC+alxeFzG4Zf6GGYaPuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+X1rrSxIAFh7NvekFSbEQE/PBbhD16qebd5V7aJ2jKOBCDEcHMq2nxf020FlBH1gZVI8A144veWcc90NG43xqz0eu3DVZaPwzOzj9e6X/TEp3vhF92HPntrRY55Le/8dqveF+thFTIRe46iVPtchgKbbsMjWEeur+L6UDCUwRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=fm10+LDZ; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKgaGED1ej7Rax573YQD6vEFQF/B4+s76pOVFohr7ZZesxYH5BkLRw7JaYeu+WDpMVM5Y6zDaUkE/2Shvr4VOJFQ+ZflZ4WpPhbxVzCOGCQj5Or1bmK2xB9t6Se7FUtpZ68itg3YJkh38okygRzIcCtfVLLteTzR0F/qEQLfQcIQv2CBmvhr6iGFbIk/guCdNoBXlXEp6Kb9Y5EPou4MeewoYXJkKzr+0yEehhogucNMu+Wee2nlEUO3JKwsb/HHakrh+or4x2AojaCPNenBv2a3Ct3Uar2tAs8uPfw/JS5kfqkX2UjFAHeCmQK21Wd7fQQ5THV8PidwmAd6yDGJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXsN7cNx9wqenfmgzmMYOSCC+alxeFzG4Zf6GGYaPuc=;
 b=BS1AnBRyid4Ejyl8Hb6L4AyirF34Op3r1wEXvpsfvHwqvAqIyA80SIP+dkA2K5XIkX7xib/NnuLrCfZQhQi11VurahA/5A5n/GbXJeLugGpBxQU2q1p7b2j5FJB4mZq4lL9plJKjt9ZFfTzaXkGHeG+8VdJIMwTyBY+/7yMK7qF/HE7DUcSMDcQ+0WscbNLWoxxuw1KOEHg3bTMPMiFuabZGlowXyg7z8GjVrjh7glNJ4SH4VAgGegzn4F5eI0oWGEZGBctDQEVZV8NUVvXbJRm4k3ZJeFkJujUVmL5uWLVD3gMx5cpg+dpGaTca/f7y9SW1UH2tfhokwygZDJO9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXsN7cNx9wqenfmgzmMYOSCC+alxeFzG4Zf6GGYaPuc=;
 b=fm10+LDZgqy+Zbjjmql3dpJbvOaoolXhsqQEcOTt5vY/rYe/XA3v59876GUK4vefKh/Jg1twaSwb3o+pSrdxqFNujJdIYRgsa92ftSfE+U0fgoAv54IpNn16lZ98nHlHBsY7EIHY0k+ZGzOhVcUM4+mfH+0LYoIeNHMIGbL8qHo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH7PR13MB6318.namprd13.prod.outlook.com (2603:10b6:510:2f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 20:22:54 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a%5]) with mapi id 15.20.7249.037; Wed, 7 Feb 2024
 20:22:53 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/1] NFSv4.1/pnfs: error gracefully on partial pnfs layout
Thread-Topic: [PATCH 1/1] NFSv4.1/pnfs: error gracefully on partial pnfs
 layout
Thread-Index: AQHaWfOPdWZCWS05wUeJC6M2pFsKwLD/PyUAgAAK7ICAAAIoAIAABrkA
Date: Wed, 7 Feb 2024 20:22:53 +0000
Message-ID: <3154d1ddb6eadaa367b55512b22eb939fc4ca177.camel@hammerspace.com>
References: <20240207182912.30981-1-olga.kornievskaia@gmail.com>
	 <be83ac24a9d17fc78590d4b182afd3f4e6c1e8a7.camel@hammerspace.com>
	 <CAN-5tyFTx4bUvuF627E_2x9Kw2h9tccqU-7KfCtJHyFazTTLYg@mail.gmail.com>
	 <CAN-5tyF2bqMy9y1rbeYbU5uakzg0AeiF7rEzH8M7S=kWyogY_w@mail.gmail.com>
In-Reply-To:
 <CAN-5tyF2bqMy9y1rbeYbU5uakzg0AeiF7rEzH8M7S=kWyogY_w@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH7PR13MB6318:EE_
x-ms-office365-filtering-correlation-id: 1b409235-f5d0-44fb-c285-08dc281a905b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 itQAmYBjSZMjNffWdv/AjznX+2jA0ZCxQbQJvD2211BwIFV9NZUeRzgZLh11KBWbX9jkivO6Uk6f2V89njVT/j2tXPhl+ItRqS4zU9tuRLy8XWGlGmLvq/FSRtPDLXOzkcm8/40g9vBmy5Uhhzz41r/HBR/9gtijLIwts5nsUl/q6AXn0NrAvgDCCmTXIM41bSaRwR9a6Sm/XyN7XklTZ5T66kP1dqfdfOsrC8qiU0ryhymUU23dVfwpeT5CLoMN/7xa0WtGlzMnIIWH1TXYCaoBWbtiE+9pJtzM/oSHnzZWQqQDSuhBfdJgnaF2l6f+Ff2XKWYRqbwt97zgh2iRpr17eFjcRHck4qEEHsaEj7Ac88CFqwPM6bd+eh573fC3L+WBokiRnINFOai862xn6JO8nYnZQF72X72e4RDjWvtZDyBjEdCjNdERWWScT+FRckHv8h/qYxgfTtVGE2NJb25Xaz42lh6aDm7epDX88V3eouR664In3AMOg1DUMQ5VS8HwTx1olUoDK9V/8aAf2lTKJl3GbfTNmMWa7Dide73qA2K4mrOCc36zMa3pjiItPd6J97Mp8f9tnY34YDeIp8NryTZ/A2i8BBVXySwff0Tbov6EFYQInPgDtUVcOQtB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39840400004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(6506007)(53546011)(122000001)(86362001)(41300700001)(2616005)(6512007)(8936002)(8676002)(4326008)(36756003)(71200400001)(2906002)(478600001)(6486002)(5660300002)(66476007)(6916009)(66556008)(66446008)(64756008)(316002)(66946007)(38070700009)(76116006)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3VSZ2I0cy9FRHhYQU9abjZOc25yMGsyTjFFMVZxMFNoQjdSemFKdEZEVy9B?=
 =?utf-8?B?V09TUE5XeWppUTc3bkF6UDhFbWJZbEN6UWJsTi9LNVB3NVM4dkhWdnpYbGht?=
 =?utf-8?B?VEVFam9DOXZGS2lnVWNlUWpwQ0g1WDBqdFFCN1p3L2pOcllSRXRYN1ZHY0NW?=
 =?utf-8?B?TGlHTmJ5cFQzRjh0dXpPdFdhbzlJVVNWSmNrQVJpRzlKQ1VWQmd6anBraTQ3?=
 =?utf-8?B?MmpWUzkxMjRuWFliWGNabmdxUGluUE5VT1d3VVlkRkJGcWduRzBRNDRhZ3Ex?=
 =?utf-8?B?V0FDOFE0bDNBTzMzR1h4eHFpOHA0alNuYThYYVo1MUwwd002MzdQMVBwbHQr?=
 =?utf-8?B?WWFCRFNRRVAyeXZiWVp5S0h4Z0JvSWMzN05RK3B3b3d5Um1Ea0wxZlpkRUxX?=
 =?utf-8?B?SkRmMk1RTGc4UGlDM3phN0FNajAwOFZLOGFHVTFlT3FWR0VMazJHTUxDalVN?=
 =?utf-8?B?eUlRNG8rTWNQYW1XNEdsMlllU2Q5YnNYaklIbmcxUXNyUnFRSUt6dUZPNjJX?=
 =?utf-8?B?NWw3T2VaOHhGS1dTdHVIL0FMNVM1Tng5UVEyL2F6Q3VFQllzS0Fnbmh1VGly?=
 =?utf-8?B?SUFKVjk0TldsbnJHYW8yTTEyYWNQbEM5VHgwUTJaOVAwSURreStJL1JYdGJT?=
 =?utf-8?B?b0VtODdxdWJvYkpleVZNSEVzbUtxQ09IUWlPckVaS0V2UzVQa213S1lMeEJ4?=
 =?utf-8?B?N1FOa3JibDcwb2VMSXRRRFpYMUkydzRQSDZ5NUpvT1MwNTd3T2ZPcWV6aUNG?=
 =?utf-8?B?cmdYSElDVE9mNTNZNWI0UnZ1N2dxMCs0bEZqbUkvOGI1MHd1clkvKzQvRFFv?=
 =?utf-8?B?ZzhUckUvWHcrNWNPU2QrN1RjcTMwUmxiMkJUYlBkUjV4dURKZTZVSUdrUWZi?=
 =?utf-8?B?cG95T0gwNG9CL2piZERRU1U2OHphK0ppd3hqcDd3Ynl3WXcyWHV5STZ2REFj?=
 =?utf-8?B?WTZqMFc1eGNETjA4M1NGK0tFVzBDeTVKcERWa1BPWHd2OCtma3BqUjdKTlYw?=
 =?utf-8?B?eEo4ZVdscHRrY1hUWE9DNEtmaEpIVVo1cFNtb0FBOVFaVFFzNHVJdkdySXdk?=
 =?utf-8?B?Y3VhRGZTYU5zZ3hxSUFDQ3dkdmdZNE84NWFuRTFkeHJZMXM2empmN0E4SGoy?=
 =?utf-8?B?OVowMXI0Y0xvcDRJSmpCbFRkRGEwUlJWUHlXVWVCOHl3clNqQUd6MFF5dlY4?=
 =?utf-8?B?UlU3WThiN2FTTWRsQklyVFRtaDY1K0FORVc5RUF0cit2VFNaRkl1SHdEVW9z?=
 =?utf-8?B?eWNMSnZNUUpBRm9ONUUzNWQwMms4NVJUeHluaS9FR1RCYlpBWldiLzZLZmZQ?=
 =?utf-8?B?ZUg5OVZUTWUwb2dTK1Qwc1E4dnBxeVNvd1pPWEZNVVdxUXRUMHVGQ0lTemo0?=
 =?utf-8?B?RHZlNTAwSVhXWENYWFl0b0hVelhxQmtGU0xOVExJdDN5QjRtb09yMDhKWFJr?=
 =?utf-8?B?bGlyQ210T2ZmU3Z2UVZjUXRUdFhNRzc0UTlGL1MzZ1BMSmFPV3l0VUd4b3ZK?=
 =?utf-8?B?QmRFYmtJcC9LakthaTByQUV4U3Z5WGw2OWRmWm9IQ09CL3o5QTdYVmlvL2t3?=
 =?utf-8?B?KzhKY09zU1ZHWU53bTRNL2tBTWJwdi95S3JYeXNVenJUKy9JQWpZc3JVaElQ?=
 =?utf-8?B?SHZmc2lPWXBHVlRiVExWTzQwV0ZEbmdpZWZOSUR5VHF4N3BLa09aUmZOTnZ4?=
 =?utf-8?B?Vkt0Y2hOR2ZzcGZuNUhCRzFocTRYajNNSDkwWHcxLzVJRUNVcHdkdUtCdGw4?=
 =?utf-8?B?WUQ1Wjd1MlNWa3RYT1Naa0tvSU5CZkhkeHc1MCthOTdIVVkyaFRZSHJISHAr?=
 =?utf-8?B?d3lIYWpWVVVUejAzSnFPSHJMekJDSWE4VUFSRGRIdjlMSjlvaVJ2ZDdnVWJu?=
 =?utf-8?B?OVV0RTRjUTNTeTRsMVRPb05FdDViZ01mRFRMbU1jR2tkWnhaQXVXbGpqTkxK?=
 =?utf-8?B?MXNEZ3U4NllhUWE5RDNXWm9pTUVLYUxncDF0bEI2NEFWem93dHFFY20xNVps?=
 =?utf-8?B?NnFYMVhEb0pHd3hyQjh5c3VQRm9md1BLNUV1eHhOSXFQdS9XSFNVak1mK3JJ?=
 =?utf-8?B?Y0djOVMvWmJWZllSTkdRbTcrNWUxZWhiS0NQditrY1dXb1B3MloyKzBEanZN?=
 =?utf-8?B?NlpvU3BCUU5paERqby9zeWpKUGZyckpPWmRqUE5odC8wcUk2dk51eTRITUFk?=
 =?utf-8?B?MzZTOHQ0VjlxRHB1ZnRBWDNJc0lyNUE4MHRkQ3o0TFNRRUh1aWJIZ1JxN2pY?=
 =?utf-8?B?R1Vvelk2S0xuS3BxR3lRWjRiQXRRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76B859697E8785468B139489970A7C65@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b409235-f5d0-44fb-c285-08dc281a905b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 20:22:53.5707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7343rEKmXYjiDrPhGrSwifGiSjwJT5tNYtHYaA6cjDS9wPql4mXeL8wE3kOEEG/STfLK21Xx3fAjTP57UoFBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6318

T24gV2VkLCAyMDI0LTAyLTA3IGF0IDE0OjU4IC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gV2VkLCBGZWIgNywgMjAyNCBhdCAyOjUx4oCvUE0gT2xnYSBLb3JuaWV2c2thaWEN
Cj4gPG9sZ2Eua29ybmlldnNrYWlhQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gV2Vk
LCBGZWIgNywgMjAyNCBhdCAyOjEy4oCvUE0gVHJvbmQgTXlrbGVidXN0DQo+ID4gPHRyb25kbXlA
aGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gT24gV2VkLCAyMDI0LTAyLTA3
IGF0IDEzOjI5IC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+ID4gRnJvbTog
T2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBD
dXJyZW50bHksIGlmIHRoZSBzZXJ2ZXIgcmV0dXJucyBhIHBhcnRpYWwgbGF5b3V0LCB0aGUgY2xp
ZW50DQo+ID4gPiA+IGdldHMNCj4gPiA+ID4gc3R1Y2sgYXNraW5nIGZvciBhIGxheW91dCBpbmRl
ZmluaXRlbHkuIFVudGlsIHdlIGFkZCBzdXBwb3J0DQo+ID4gPiA+IGZvcg0KPiA+ID4gPiBwYXJ0
aWFsIGxheW91dHMsIHRyZWF0IHBhcnRpYWwgbGF5b3V0IGFzIGxheW91dCB1bmF2YWlsYWJsZQ0K
PiA+ID4gPiBlcnJvci4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29y
bmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBmcy9u
ZnMvbmZzNHByb2MuYyB8IDYgKysrKysrDQo+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJv
Yy5jIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gPiA+ID4gaW5kZXggZGFlNGMxYjZjYzFjLi4xMDhi
YzdmM2U4YzIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2ZzL25mcy9uZnM0cHJvYy5jDQo+ID4gPiA+
ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+ID4gPiA+IEBAIC05NzkwLDYgKzk3OTAsMTIgQEAg
bmZzNF9wcm9jX2xheW91dGdldChzdHJ1Y3QNCj4gPiA+ID4gbmZzNF9sYXlvdXRnZXQNCj4gPiA+
ID4gKmxncCwNCj4gPiA+ID4gwqDCoMKgwqDCoCBpZiAoc3RhdHVzICE9IDApDQo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KPiA+ID4gPiANCj4gPiA+ID4gK8Kg
wqDCoMKgIC8qIFNpbmNlIGNsaWVudCBkb2VzIG5vdCBzdXBwb3J0IHBhcnRpYWwgcG5mcyBsYXlv
dXQsDQo+ID4gPiA+IHRoZW4NCj4gPiA+ID4gdHJlYXQNCj4gPiA+ID4gK8KgwqDCoMKgwqAgKiBn
ZXR0aW5nIGEgcGFydGlhbCBsYXlvdXQgYXMgTEFZT1VUVU5BVkFJTEFCTEUgZXJyb3INCj4gPiA+
ID4gK8KgwqDCoMKgwqAgKi8NCj4gPiA+ID4gK8KgwqDCoMKgIGlmIChsZ3AtPmFyZ3MucmFuZ2Uu
bGVuZ3RoICE9IGxncC0+cmVzLnJhbmdlLmxlbmd0aCkNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB0YXNrLT50a19zdGF0dXMgPSAtTkZTNEVSUl9MQVlPVVRVTkFWQUlMQUJMRTsN
Cj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHRoaXMgY2FzZSBpcyBiZXR0ZXIgaGFuZGxl
ZCBieSBhbGxvd2luZyB0aGUgY2FsbGVyIHRvIHNldA0KPiA+ID4gbGdwLQ0KPiA+ID4gPiBhcmdz
Lm1pbmxlbmd0aCB0byBhbiBhcHByb3ByaWF0ZSBtaW5pbXVtIHZhbHVlLg0KPiA+IA0KPiA+IEkg
ZG8gbm90IHVuZGVyc3RhbmQgd2hhdCB0aGlzIHN1Z2dlc3Rpb24gbWVhbnMuIFdoYXQgSSBjYW4g
dGhpbmsgb2YNCj4gPiBpcw0KPiA+IHRoYXQgdGhlIGNhbGxlciB3b3VsZCBzZXQgYW4gYXBwcm9w
cmlhdGUgbWluaW11bSB2YWx1ZSBhbmQgdGhlIGNvZGUNCj4gPiBoZXJlIHdvdWxkIGNoZWNrIHRo
YXQgdGhlIHJlc3VsdCBpcyBhdCBsZWFzdCBhcyBsYXJnZT8NCj4gDQo+IEEgZm9sbG93IHVwIHF1
ZXN0aW9uIG9uIGEgIm1pbmltdW0gdmFsdWUiLiBJdCBzZWVtcyB0aGF0IHNpbmNlIHRoZQ0KPiBj
bGllbnQgd291bGQgdGhlbiBuZWVkIHRvIHNldCBpdCB0byB0aGUgc2FtZSB2YWx1ZSBhcyB0aGUg
Imxlbmd0aCINCj4gKGllDQo+IHdob2xlIGZpbGUgbGF5b3V0IHZhbHVlKSwgeWVzPyBTbyBpdCBz
aGlmdHMgdGhlIHJlc3BvbnNpYmlsaXR5IHRvIHRoZQ0KPiBzZXJ2ZXIsIGRpc2FsbG93aW5nIGl0
IGZyb20gcmV0dXJuaW5nIGEgcGFydGlhbCBsYXlvdXQuDQo+IA0KPiA+IElmIHNvLCBjYW4geW91
IGV4cGxhaW4gd2h5IHRoYXQncyBtb3JlIGRlc2lyYWJsZT8gU2VlbXMgdG8gbWUgaXQnZA0KPiA+
IGJlDQo+ID4gbW9yZSBsaW5lcyBmb3Igc29tZXRoaW5nIHRoYXQgd291bGQgYmUgcmVtb3ZlZCBs
YXRlcj8NCj4gDQoNCldoYXQgSSdtIHNheWluZyBpcyB0aGF0IHRoZSBwcm90b2NvbCBleHBlY3Rz
IHRoZSBjbGllbnQgdG8gc2VuZCB0aGUNCm1pbmltYWwgYWNjZXB0YWJsZSBsYXlvdXQgbGVuZ3Ro
IGFzIGEgc2VwYXJhdGUgYXJndW1lbnQgZnJvbSB0aGUNCmRlc2lyZWQgbGVuZ3RoLiBSaWdodCBu
b3csIHdlIHNldCB0aGUgbWluaW1hbCBsZW5ndGggaW4NCnBuZnNfYWxsb2NfaW5pdF9sYXlvdXRn
ZXRfYXJncygpIHRvIGJlIHRoZSBzbWFsbGVyIG9mIFBBR0VfU0laRSBvciB0aGUNCmxlbmd0aCBv
ZiB0aGUgSS9PIHNlZ21lbnQuDQpUaGUgZXhwZWN0YXRpb24gaXMgdGhhdCBhbGwgdGhlIHBuZnMg
ZHJpdmVycyBzaG91bGQgYmUgYWJsZSB0byBoYW5kbGUNCnRoYXQuDQoNCklmIHlvdSdyZSB0ZWxs
aW5nIG1lIHRoYXQgdGhlcmUgYXJlIGRyaXZlcnMgdGhhdCBkbyBub3QgaGFuZGxlIGJlaW5nDQpn
aXZlbiBhIGxheW91dCB3aXRoIHRoZSBtaW5pbWFsIGxlbmd0aCB0aGF0IGlzIHNldCBpbg0KcG5m
c19hbGxvY19pbml0X2xheW91dGdldF9hcmdzKCksIHRoZW4gd2Ugc2hvdWxkIGdpdmUgdGhlbSBj
b250cm9sIG92ZXINCnRoYXQgdmFsdWUuDQoNCj4gPiA+IA0KPiA+ID4gPiArDQo+ID4gPiA+IMKg
wqDCoMKgwqAgaWYgKHRhc2stPnRrX3N0YXR1cyA8IDApIHsNCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZXhjZXB0aW9uLT5yZXRyeSA9IDE7DQo+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IG5mczRfbGF5b3V0Z2V0X2hhbmRsZV9leGNlcHRpb24o
dGFzaywNCj4gPiA+ID4gbGdwLA0KPiA+ID4gPiBleGNlcHRpb24pOw0KPiA+ID4gDQo+ID4gPiAN
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

