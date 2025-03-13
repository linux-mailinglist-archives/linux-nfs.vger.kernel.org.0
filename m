Return-Path: <linux-nfs+bounces-10596-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EAAA5FBDB
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 17:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD0B1888728
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 16:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490CA136E3F;
	Thu, 13 Mar 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="MYmSlsKK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2131.outbound.protection.outlook.com [40.107.220.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD67FBAC
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883707; cv=fail; b=t9iNJtR8PnDpBJnnw6wI3T+EyxH/PGinoq0XfPpWYODaLHw1Yn3jyC1b8MsBlTvlae80pWjHPMmCb5j8t3VYsLZoJA3CURJRvkJ/t8A2Z1Sqvu4UyS+p1RxFrJrLCZmyQM/6IcLUZz7Hd1P6jhpbsigot48pZUeIjoeFdTHWPfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883707; c=relaxed/simple;
	bh=dCvqAVdNOkwyc4/WrBBK/xnvPEYcNaQy0a6MXRs2i2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LKlNuoRlQCbgrgtQ/aeInl7Uau2FyklXY/DJzxqTthdXKOUVNggnQ5Pm8OGAGSam0JdC26sPfnq5qop37gPpb5AhhgQ85Kf6O30a6Ayoziw1xUJKZeYqUhe4v0rOJlKtvQgFPGDBQfPC70oEpJa6MIpy5HxcjWf+WYqD3jaHHJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=MYmSlsKK; arc=fail smtp.client-ip=40.107.220.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymkREtltWJ3B7levf0kKCmtLJ6aa83cn/qpaM4BSK2IEeaPS3EdyIG8EjuslOOAFPQ1i4pTFskZYNZz4Ec06RvymBRxuENyEJlgqmpAO+UQ24Rclv8bRYj53ISQqdS+2QIIduCmV8MgMsFII0yx+3fOkVKJUKMYrbIi9XcTRzTnBHe51KRohj6ofj6NAK/3oXOMRsfFFg5o9HS6YuOPC1iwpQkHuWmMCo8a1EHMWobXESFpm4Z6azSIsKbzoZGaJNeDTEGyo+346NNCCJfbJiLQi6araLU5+7jH4HpkwE6H/Aiz5pvD0hB2S14o0xKXLiplFeriMJRpyHr7mHPoQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCvqAVdNOkwyc4/WrBBK/xnvPEYcNaQy0a6MXRs2i2o=;
 b=B6PNdv7K1GdayOUzUup8zUAoALxU/n40XKO3JZrN6ZasAGpSgdr0WxD3TjoU6AkWKCc4EtNlYUY14DY27l+DxIP18sdsKb0ep4EOJmJBM+OqpPN+AuaLEKTL4n757Kx5keqShqMgNKGxYOhnQ3j2br2cV7fiF403U+KISX9S5vhTl7O3a3F50KDAKBLGYlApNjkN74hrAHliv5AdRwzgCPSgUrEROb6/1AO/+9XXVaa8COHNxEIj2ts8ReyTIdpkFJdIJwaqJfkKjGxIsmKNK5PRwWoXrDX1dYczOVQ0oyp6OHHPUvlzpJlwuEeCQrlE8E62tPwmUI0mn7dMpaCTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCvqAVdNOkwyc4/WrBBK/xnvPEYcNaQy0a6MXRs2i2o=;
 b=MYmSlsKKtD3AH9KeEhe/PHMTano3t6siy6g8w7kagHuzXaAagsdjde9J3s+/kcwcNLsES0mgP6skyld0JJzeLbySpL5k6lVFij2vWeGPtm1aQrS5nJKz9R96XxBYbgyUJBRzNtEL0RHBvGToXl7MdcAJARw15HXs9a/qd8X3cDw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH8PR13MB6269.namprd13.prod.outlook.com (2603:10b6:510:250::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 16:34:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.028; Thu, 13 Mar 2025
 16:34:58 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "bcodding@redhat.com"
	<bcodding@redhat.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] NFS: Extend rdirplus mount option with
 "force|none"
Thread-Topic: [PATCH v3 1/1] NFS: Extend rdirplus mount option with
 "force|none"
Thread-Index: AQHblCZD6RmDdtZLL0+4GeuOWid6KLNxQ2gA
Date: Thu, 13 Mar 2025 16:34:58 +0000
Message-ID: <5b2abbe2d387f7d68d41d4786655fa51a9a9ddbb.camel@hammerspace.com>
References: <cover.1741876784.git.bcodding@redhat.com>
	 <8c33cd92be52255b0dd0a7489c9e5cc35434ec95.1741876784.git.bcodding@redhat.com>
In-Reply-To:
 <8c33cd92be52255b0dd0a7489c9e5cc35434ec95.1741876784.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH8PR13MB6269:EE_
x-ms-office365-filtering-correlation-id: 45e3fcf5-6f14-4da2-38ef-08dd624cfe5a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UHB6SXBPQjhPaGRsQTBPYSt1VTlFcmw0ajBWbjdEZTdoUThDMFhtTHRWc2hO?=
 =?utf-8?B?OFZ4dXhCYTgyQnI3Z1ZXWUJnKytTYlltR3RpRFVjaGN3allYOXBJVlpPSUhV?=
 =?utf-8?B?bE83Q21ENk1uMmlMQ2FxWjhWTjZoOWNIWE04dGR4UWhXWk91WXZiRis4d2th?=
 =?utf-8?B?YkNWZ2Z4REZkVHR0b0U3Q1hyT3RiT3lSQjk3NWtFci9vSWhlYU1HU1htWSt2?=
 =?utf-8?B?TVo1bHBWVTZQZm1XcVVjUkNGSnRuWTNZZlErdmswLyszekRhUTRuMTNCSXJr?=
 =?utf-8?B?b00wcG9PczFHM2xGQXdlWmx1ZTVjVDdGUjlSUHZmNEQrL2pyemNvWG9oNEpw?=
 =?utf-8?B?Mkc5NWllQk1uUURrSllJeGxBQTJLRk5EcGw2MGJOTnQvN3NlbE05SENDZitC?=
 =?utf-8?B?OHJnVjJ6YnQzN2V2UHNyaE1SVkVVa1hHTThiSEpOWFpkRzl0RmRKMytBNkNq?=
 =?utf-8?B?TmZoekh2MklFdlpySlZ2VDRreGZNYm9MSDArb2lHSWFFK0dYSUFMTjRDaVg0?=
 =?utf-8?B?NW55T1pxWnBKaUFVYjAwLzFTNHpNZ0thT1VnN2UxS0JnQ2tFcGFYWDFIbGN6?=
 =?utf-8?B?OCtmSTFWM2RrYWVCdTZmbWVvRUlMOHB2SC9rNDJNRWdOQkw3RTl3V2RiMUdL?=
 =?utf-8?B?eDR3My9KMWRpb3pSclc1K1pRZ1p3dFM2SmZYeno3OXMxNmVDWHZJWnh1Nld4?=
 =?utf-8?B?N3JmMUFmeTFKMTdOYVdDWXNSQWZ1S04xVC9RVTRobjRldTdReWlHUVdWbEZL?=
 =?utf-8?B?djZWaktiWW9hTDNWZmZOT2M4TCtoZFQ5TUk0dEgwakNOWTY4dlV2TjNMczlD?=
 =?utf-8?B?bDVMbFp3YVUzMndLTGFzc0wvc2FVdFZmaWxrc1VMdEltL1l1aFZPWk9tb0hU?=
 =?utf-8?B?cnlhRzVXamQzOWp0WnhPTktGbjRCc2tUNGVIN29PVnpkUzR1Rm8rdTExVmEw?=
 =?utf-8?B?amhSLzBrWGRpeVp5VkNqSHNQRGU0RU5ERm42ajJETDYyMGh2Y2hZZFo3bzcy?=
 =?utf-8?B?dHJTTm5XbUhJSm5KeWNhNUM3c0lqUTBvZk52MlBtNXdwOC9oZ2lBcjRHam1i?=
 =?utf-8?B?T1JQOGw3KzhpZUkrWSs4U3dDWW03akJ1dDRLQWpQR2d1d1VMenNNeEdPOGxT?=
 =?utf-8?B?alBhUjFHZTArMVpPZkpUbEdmZU9UMGVFR2poWmFab2tESVY1Z1VmbStSZ3gx?=
 =?utf-8?B?WlE3VnVoNlRaMkpIaUJ0ZDRQNWxTZE45Sy9kVUJhL1Y5UHg4Q3lQbEZORW92?=
 =?utf-8?B?dlRqN3p3OExiWmowc0dFNEg2WDNvdk5zM2dmUUMzeEJYSFZoSmwweUdrVmIy?=
 =?utf-8?B?ZHFlQ2YwUUJaUXluRXdkdHVGbkxpN0xqUlFTTXBiNWhpVHEwWUV1dmoxV1U1?=
 =?utf-8?B?MnVRaW42ZGV4aW0yRlU5N1RFZnB1YlZDSmo3bzFsSmY2S21RSjc3OS8vS2ZP?=
 =?utf-8?B?cit0MnBZaGlEdURSVWdaOGVkNWVUL3lGb0ZZMlZXWXpyek9MaFR4eFphWHRG?=
 =?utf-8?B?d0FTN1lUWG9vOVRIOUkzOFF5TzBpVzhrV25NS0JlWUprYTZ5N1BhZ2JHZlVR?=
 =?utf-8?B?ODdXWWd6TktHeDZjR0YyLzlIQml5SU4zK0JOR0VGRTV1UWZUTzg1elBJTGQw?=
 =?utf-8?B?VlNQQWtuejJNWTNiZ1EzMHQzWVZTS09uMFdaRldSZjdVbi9HSWowL2dkVWc1?=
 =?utf-8?B?WUpoUWZ5OFRzeDlLZW02RUFDelJtdk9HTW0rM0JKUHRIcDF0dWdPOWMvKzl5?=
 =?utf-8?B?WDBQb0RSbW1SWDhvc2tyekZvN0Q1dkhsZk9KY0RWWUgwOEtjVVM5UkVXQWlX?=
 =?utf-8?B?WlBxMFlhOWEwcC9FSDZqQnlZU3YreDF5bmNBNm5yN2kwc2lsTWFvL2h3Snk0?=
 =?utf-8?B?QmxmektuYnlQc1IzMjNTQWhxbVdwOHp5NWd4eDIxbnR5amVzOWJRckxwSHAr?=
 =?utf-8?Q?1/d1rwY3U3s4yNT+dF9lZM55bF/uNTYV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nm5QeEJHTHg4MmxtUTZEVkFGZkVVTDd5WXAydHFmeFp1TnRBUTMwZ2tlMXYz?=
 =?utf-8?B?bytBWjF3cktlbVhtNEhvN25WYXlpOWV6RW1kYUJFSmpiOWNzczBXYXhhc3VR?=
 =?utf-8?B?eVhjSjVuZzJIb0crUk9PVW9neFhHU0hBWDlzTkhESTZGMDIrdHZHK1lzR210?=
 =?utf-8?B?emtXaEp5L1JValFNb1Z2anRSeStmdFN4RVJ2UnZPOGFaZG1RSkhHRUNEOERo?=
 =?utf-8?B?RXZLM0xMTy9WQ0hoLzUzZkt2MTgzMTBlK0dQR2YvbmdvYkxlOUVUblhNV0Np?=
 =?utf-8?B?R013MGtINVBQek9BOGhyVit3YVdyRHVLSy8yNjlheG1IdW5HVjlLMEZlWHJE?=
 =?utf-8?B?Ky9Ha3I1UzlsWitoeDNtdDNrNlA1MCtUc3BSOUw1NU5XT2dHazVXQ2phSHpu?=
 =?utf-8?B?bTV6eHVyWWFHREdWQjlxTksxWFdrdUYzWndzMzBZR2pHaXMwOWV3Y2lhL09z?=
 =?utf-8?B?RzBmQkZaWDdaR0xDSVFFVEhLVThvNnVEQ29WcERHdHM5OHhjRWFzQVJWNWE0?=
 =?utf-8?B?TjlNU3ZzVnRzdzM2eExEV24yMGVmUFJrMElndVVjRmtGTTdzalYwRFRCeWpk?=
 =?utf-8?B?dDJkMFlUMGRhY2g1UXVsVWE2QUNFNnlqWVB3MWFZUFFndjdaem5ERzdzZy9R?=
 =?utf-8?B?TjRSRDkzZHpEQ2tEaHFWaVNSTHhQL09aNTYzVE1IZmFFYlBPelFxTlZrYUtM?=
 =?utf-8?B?RlpsUTN0RnN0dkIzRk9PMEg1R2tTdzdEYjdrZVdYbVM4ZkNEbW9XSCtWZTZT?=
 =?utf-8?B?cGZERWk0SnhZUmtVdkJSZE9jVXRsSVg0cGMzUVdRUHVmSTdBUDNuSU5oRmRk?=
 =?utf-8?B?L1oxb2owTkx1QThwdktSaVo1d3JtZzhPQjY4bGxjWHUwcUhPRnI3Wm42Y25R?=
 =?utf-8?B?cmcrR3ZnRUlDZk00OW5heHd5bWxQTGdPbEZCZHIxQUZ2MzJMTncyazQzUWtx?=
 =?utf-8?B?QitMNWRONCsrNFhoSXZoMWdZR0lZUG9yYnZQaEFma2xJNmFWSlBOR09HQjZ3?=
 =?utf-8?B?cm9ZYk5xOXJYR1hMZDNRL25CaFpmOU11c3JmOGMxL2ljTnU5WXBQcFExMWNH?=
 =?utf-8?B?T3BDSXNoMnU5b3pSTWF3RC9wUzlmTjAyVW85REl2ZWp6SG9xK0JzMHF3MDBX?=
 =?utf-8?B?WVZPekNqcTJWd1V3OURjQWpQbEQzNHFFYThhRE95V3F5cjNoU3pFb2lxbGlC?=
 =?utf-8?B?V1JZR2k2L25TQnhuQllSQU9LbFI5THVqSjBlWWZLcWxweHJZeXI0ak8rWXlh?=
 =?utf-8?B?NGFYREZzcCtNVkdhOFRuSjRXTFZ1bC9lblFoN2FnSHk1WGlHVEl5SXBuMUFL?=
 =?utf-8?B?MUMvemFQc0IrYU9WR1F2S0xPam9ZWnU2MDZSV2puNStOT1liQ3BsUlhFMWhH?=
 =?utf-8?B?MjZmRUpOcXVzcDVJWUJoNWdxckpHV05DbkNLK05Wemx2U25DRHo3Zm9JNlFM?=
 =?utf-8?B?aGEyTzNMQzBvSEw3WDdJYWUwcFhmMmFub0EwMjZHdkQvVnptdTFrTjdaRWV2?=
 =?utf-8?B?UHhVRlF6MlA0bjY2UHFGUHpDWGdxb2R1akc4NFNlRGVjeXZlV2dqd3NwU0xu?=
 =?utf-8?B?b2lyK2dHODNXdHJOa1J5WmF3MlFqYUg2REsyUC9kNFRUc256SFdnaWdQblow?=
 =?utf-8?B?NnJnOXZrUkdQWWJ3Z0JkQjJUT1hLblhNSnA4RnI4WTV0R2FMV0o5bDUzUUdX?=
 =?utf-8?B?aWxGTEpDT2crUW0zS1dNazFVVDVxTll0ZkV6VHZidmJpMmkxck1KaVJ2NkZM?=
 =?utf-8?B?NENPT0NCeXJuS04vU3FHVXJMRXhPWXUrSFJkNUZoUkNiRHhlWjFVZFFlcERF?=
 =?utf-8?B?NkVlVi9PNmlnaE1wYTZZMUlOamtrTjlqVTRPbDhTbzZmanFOTkMzWUdrRjhl?=
 =?utf-8?B?WVFVcnVkTE5nWVRabWZaN1lYQkVhNEJTZ0RJT2NRLzY2d09kOWpVYWZTZ1dF?=
 =?utf-8?B?dGxBazhNeHFhTk5tR24xTWJOVmt0dk1RWDdibDJ6SWJQVlp5bjN4dXBBSmpj?=
 =?utf-8?B?SW9Qcm5WdVhCb25MQ1pFd05yRTdxa2hVUVZ3ZHgwc0lCQmUxajNQc3RQaFo2?=
 =?utf-8?B?YVVYdHhEZHpMZVVFUzhqVG9iRENFRmdxVFpPeEhmT2MvUFEzdW9jcG9Wa0Yr?=
 =?utf-8?B?MWNIaWNOOEtwdGJaNW1LV1JSUXI1TGVySzlPVTZTRXFxMW1oTks1cjhzV3I3?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C3F3D0C4CB3694A88607FB78869CF2C@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e3fcf5-6f14-4da2-38ef-08dd624cfe5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 16:34:58.0394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YsYvHdidFDWVZc452+4G3vYTN/DKjVDdEckhL0qkwXVxWG36FDR0O4YpCvGZAOudbQCX4ESiMhYrOT5PKbqxEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR13MB6269

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDEwOjQzIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBUaGVyZSBhcmUgY2VydGFpbiB1c2VycyB0aGF0IHdpc2ggdG8gZm9yY2UgdGhlIE5G
UyBjbGllbnQgdG8gY2hvb3NlDQo+IFJFQURESVJQTFVTIG92ZXIgUkVBRERJUiBmb3IgYSBwYXJ0
aWN1bGFyIG1vdW50LsKgIFVwZGF0ZSB0aGUNCj4gInJkaXJwbHVzIiBtb3VudA0KPiBvcHRpb24g
dG8gb3B0aW9uYWxseSBhY2NlcHQgdmFsdWVzLsKgIEZvciAicmRpcnBsdXM9Zm9yY2UiLCB0aGUg
TkZTDQo+IGNsaWVudA0KPiB3aWxsIGFsd2F5cyBhdHRlbXB0IHRvIHVzZSBSRUFERERJUlBMVVMu
wqAgVGhlIHNldHRpbmcgb2YNCj4gInJkaXJwbHVzPW5vbmUiIGlzDQo+IGFsaWFzZWQgdG8gdGhl
IGV4aXN0aW5nICJub3JkaXJwbHVzIi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIENv
ZGRpbmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiDCoGZzL25mcy9kaXIuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICsrDQo+IMKgZnMvbmZzL2ZzX2NvbnRleHQu
Y8KgwqDCoMKgwqDCoCB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+IMKg
ZnMvbmZzL3N1cGVyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gwqBpbmNsdWRl
L2xpbnV4L25mc19mc19zYi5oIHzCoCAxICsNCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDMyIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2Rpci5j
IGIvZnMvbmZzL2Rpci5jDQo+IGluZGV4IDJiMDQwMzhiMGU0MC4uYzlkZTBlNDc0Y2Y1IDEwMDY0
NA0KPiAtLS0gYS9mcy9uZnMvZGlyLmMNCj4gKysrIGIvZnMvbmZzL2Rpci5jDQo+IEBAIC02NjYs
NiArNjY2LDggQEAgc3RhdGljIGJvb2wgbmZzX3VzZV9yZWFkZGlycGx1cyhzdHJ1Y3QgaW5vZGUN
Cj4gKmRpciwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgsDQo+IMKgew0KPiDCoAlpZiAoIW5mc19z
ZXJ2ZXJfY2FwYWJsZShkaXIsIE5GU19DQVBfUkVBRERJUlBMVVMpKQ0KPiDCoAkJcmV0dXJuIGZh
bHNlOw0KPiArCWlmIChORlNfU0VSVkVSKGRpciktPmZsYWdzICYmIE5GU19NT1VOVF9GT1JDRV9S
RElSUExVUykNCg0KQml0d2lzZSBhbmQ/DQoNCj4gKwkJcmV0dXJuIHRydWU7DQo+IMKgCWlmIChj
dHgtPnBvcyA9PSAwIHx8DQo+IMKgCcKgwqDCoCBjYWNoZV9oaXRzICsgY2FjaGVfbWlzc2VzID4N
Cj4gTkZTX1JFQURESVJfQ0FDSEVfVVNBR0VfVEhSRVNIT0xEKQ0KPiDCoAkJcmV0dXJuIHRydWU7
DQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvZnNfY29udGV4dC5jIGIvZnMvbmZzL2ZzX2NvbnRleHQu
Yw0KPiBpbmRleCBiMDY5Mzg1ZWVhMTcuLjFjYWJiYTEyMzFkNiAxMDA2NDQNCj4gLS0tIGEvZnMv
bmZzL2ZzX2NvbnRleHQuYw0KPiArKysgYi9mcy9uZnMvZnNfY29udGV4dC5jDQo+IEBAIC03Miw2
ICs3Miw4IEBAIGVudW0gbmZzX3BhcmFtIHsNCj4gwqAJT3B0X3Bvc2l4LA0KPiDCoAlPcHRfcHJv
dG8sDQo+IMKgCU9wdF9yZGlycGx1cywNCj4gKwlPcHRfcmRpcnBsdXNfbm9uZSwNCj4gKwlPcHRf
cmRpcnBsdXNfZm9yY2UsDQo+IMKgCU9wdF9yZG1hLA0KPiDCoAlPcHRfcmVzdnBvcnQsDQo+IMKg
CU9wdF9yZXRyYW5zLA0KPiBAQCAtMTc0LDcgKzE3Niw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZnNfcGFyYW1ldGVyX3NwZWMNCj4gbmZzX2ZzX3BhcmFtZXRlcnNbXSA9IHsNCj4gwqAJZnNwYXJh
bV91MzLCoMKgICgicG9ydCIsCQlPcHRfcG9ydCksDQo+IMKgCWZzcGFyYW1fZmxhZ19ubygicG9z
aXgiLAlPcHRfcG9zaXgpLA0KPiDCoAlmc3BhcmFtX3N0cmluZygicHJvdG8iLAkJT3B0X3Byb3Rv
KSwNCj4gLQlmc3BhcmFtX2ZsYWdfbm8oInJkaXJwbHVzIiwJT3B0X3JkaXJwbHVzKSwNCj4gKwlm
c3BhcmFtX2ZsYWdfbm8oInJkaXJwbHVzIiwgT3B0X3JkaXJwbHVzKSwgLy8NCj4gcmRpcnBsdXN8
bm9yZGlycGx1cw0KPiArCWZzcGFyYW1fc3RyaW5nKCJyZGlycGx1cyIswqAgT3B0X3JkaXJwbHVz
KSwgLy8gcmRpcnBsdXM9Li4uDQo+IMKgCWZzcGFyYW1fZmxhZ8KgICgicmRtYSIsCQlPcHRfcmRt
YSksDQo+IMKgCWZzcGFyYW1fZmxhZ19ubygicmVzdnBvcnQiLAlPcHRfcmVzdnBvcnQpLA0KPiDC
oAlmc3BhcmFtX3UzMsKgwqAgKCJyZXRyYW5zIiwJT3B0X3JldHJhbnMpLA0KPiBAQCAtMjg4LDYg
KzI5MSwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNvbnN0YW50X3RhYmxlDQo+IG5mc194cHJ0
c2VjX3BvbGljaWVzW10gPSB7DQo+IMKgCXt9DQo+IMKgfTsNCj4gwqANCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgY29uc3RhbnRfdGFibGUgbmZzX3JkaXJwbHVzX3Rva2Vuc1tdID0gew0KPiArCXsg
Im5vbmUiLAlPcHRfcmRpcnBsdXNfbm9uZSB9LA0KPiArCXsgImZvcmNlIiwJT3B0X3JkaXJwbHVz
X2ZvcmNlIH0sDQo+ICsJe30NCj4gK307DQo+ICsNCj4gwqAvKg0KPiDCoCAqIFNhbml0eS1jaGVj
ayBhIHNlcnZlciBhZGRyZXNzIHByb3ZpZGVkIGJ5IHRoZSBtb3VudCBjb21tYW5kLg0KPiDCoCAq
DQo+IEBAIC02MzYsMTAgKzY0NSwyNSBAQCBzdGF0aWMgaW50IG5mc19mc19jb250ZXh0X3BhcnNl
X3BhcmFtKHN0cnVjdA0KPiBmc19jb250ZXh0ICpmYywNCj4gwqAJCQljdHgtPmZsYWdzICY9IH5O
RlNfTU9VTlRfTk9BQ0w7DQo+IMKgCQlicmVhazsNCj4gwqAJY2FzZSBPcHRfcmRpcnBsdXM6DQo+
IC0JCWlmIChyZXN1bHQubmVnYXRlZCkNCj4gKwkJaWYgKHJlc3VsdC5uZWdhdGVkKSB7DQo+ICsJ
CQljdHgtPmZsYWdzICY9IH5ORlNfTU9VTlRfRk9SQ0VfUkRJUlBMVVM7DQo+IMKgCQkJY3R4LT5m
bGFncyB8PSBORlNfTU9VTlRfTk9SRElSUExVUzsNCj4gLQkJZWxzZQ0KPiAtCQkJY3R4LT5mbGFn
cyAmPSB+TkZTX01PVU5UX05PUkRJUlBMVVM7DQo+ICsJCX0gZWxzZSBpZiAoIXBhcmFtLT5zdHJp
bmcpIHsNCj4gKwkJCWN0eC0+ZmxhZ3MgJj0gfihORlNfTU9VTlRfTk9SRElSUExVUyB8DQo+IE5G
U19NT1VOVF9GT1JDRV9SRElSUExVUyk7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQlzd2l0Y2ggKGxv
b2t1cF9jb25zdGFudChuZnNfcmRpcnBsdXNfdG9rZW5zLA0KPiBwYXJhbS0+c3RyaW5nLCAtMSkp
IHsNCj4gKwkJCWNhc2UgT3B0X3JkaXJwbHVzX25vbmU6DQo+ICsJCQkJY3R4LT5mbGFncyAmPQ0K
PiB+TkZTX01PVU5UX0ZPUkNFX1JESVJQTFVTOw0KPiArCQkJCWN0eC0+ZmxhZ3MgfD0gTkZTX01P
VU5UX05PUkRJUlBMVVM7DQo+ICsJCQkJYnJlYWs7DQo+ICsJCQljYXNlIE9wdF9yZGlycGx1c19m
b3JjZToNCj4gKwkJCQljdHgtPmZsYWdzICY9IH5ORlNfTU9VTlRfTk9SRElSUExVUzsNCj4gKwkJ
CQljdHgtPmZsYWdzIHw9DQo+IE5GU19NT1VOVF9GT1JDRV9SRElSUExVUzsNCj4gKwkJCQlicmVh
azsNCj4gKwkJCWRlZmF1bHQ6DQo+ICsJCQkJZ290byBvdXRfaW52YWxpZF92YWx1ZTsNCj4gKwkJ
CX0NCj4gKwkJfQ0KPiDCoAkJYnJlYWs7DQo+IMKgCWNhc2UgT3B0X3NoYXJlY2FjaGU6DQo+IMKg
CQlpZiAocmVzdWx0Lm5lZ2F0ZWQpDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvc3VwZXIuYyBiL2Zz
L25mcy9zdXBlci5jDQo+IGluZGV4IGFlYjcxNWI0YTY5MC4uOWE3NDdiMjI0YTlkIDEwMDY0NA0K
PiAtLS0gYS9mcy9uZnMvc3VwZXIuYw0KPiArKysgYi9mcy9uZnMvc3VwZXIuYw0KPiBAQCAtNDU2
LDYgKzQ1Niw3IEBAIHN0YXRpYyB2b2lkIG5mc19zaG93X21vdW50X29wdGlvbnMoc3RydWN0DQo+
IHNlcV9maWxlICptLCBzdHJ1Y3QgbmZzX3NlcnZlciAqbmZzcywNCj4gwqAJCXsgTkZTX01PVU5U
X05PUkRJUlBMVVMsICIsbm9yZGlycGx1cyIsICIiIH0sDQo+IMKgCQl7IE5GU19NT1VOVF9VTlNI
QVJFRCwgIixub3NoYXJlY2FjaGUiLCAiIiB9LA0KPiDCoAkJeyBORlNfTU9VTlRfTk9SRVNWUE9S
VCwgIixub3Jlc3Zwb3J0IiwgIiIgfSwNCj4gKwkJeyBORlNfTU9VTlRfRk9SQ0VfUkRJUlBMVVMs
ICIscmRpcnBsdXM9Zm9yY2UiLCAiIiB9LA0KDQpQdXQgdGhlIGFib3ZlIHRvZ2V0aGVyIHdpdGgg
dGhlIG90aGVyIHJkaXJwbHVzIG9wdGlvbnM/DQoNCj4gwqAJCXsgMCwgTlVMTCwgTlVMTCB9DQo+
IMKgCX07DQo+IMKgCWNvbnN0IHN0cnVjdCBwcm9jX25mc19pbmZvICpuZnNfaW5mb3A7DQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L25mc19mc19zYi5oIGIvaW5jbHVkZS9saW51eC9uZnNf
ZnNfc2IuaA0KPiBpbmRleCBmMDBiZmNlZTcxMjAuLjM3NzRiMjIzNWExZSAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9saW51eC9uZnNfZnNfc2IuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L25mc19m
c19zYi5oDQo+IEBAIC0xNjcsNiArMTY3LDcgQEAgc3RydWN0IG5mc19zZXJ2ZXIgew0KPiDCoCNk
ZWZpbmUgTkZTX01PVU5UX1RSVU5LX0RJU0NPVkVSWQkweDA0MDAwMDAwDQo+IMKgI2RlZmluZSBO
RlNfTU9VTlRfU0hVVERPV04JCQkweDA4MDAwMDAwDQo+IMKgI2RlZmluZSBORlNfTU9VTlRfTk9f
QUxJR05XUklURQkJMHgxMDAwMDAwMA0KPiArI2RlZmluZSBORlNfTU9VTlRfRk9SQ0VfUkRJUlBM
VVMJMHgyMDAwMDAwMA0KPiDCoA0KPiDCoAl1bnNpZ25lZCBpbnQJCWZhdHRyX3ZhbGlkOwkvKiBW
YWxpZCBhdHRyaWJ1dGVzDQo+ICovDQo+IMKgCXVuc2lnbmVkIGludAkJY2FwczsJCS8qIHNlcnZl
cg0KPiBjYXBhYmlsaXRpZXMgKi8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg0KDQo=

