Return-Path: <linux-nfs+bounces-10914-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83784A71E3F
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 19:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E483188B6F8
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 18:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B9D2475E3;
	Wed, 26 Mar 2025 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="JZz1yb4Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2125.outbound.protection.outlook.com [40.107.100.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952F24110D
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013468; cv=fail; b=vGf3Hk/3Sbdb69EfO4TB3/s01NtDvdMfq4MuZbBnfhzbKVM51WLtnzLK6OlIE9uPbRelPrUXjx2RWRLUedk5JbxOBjFCAYXK2b3Zm66/VyWpV+a1SpV5JdOWnXC5tX7h6TPvjxXRyhDQ1FCpMLNyPu4s4xFMgUmnhi34my3L6Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013468; c=relaxed/simple;
	bh=keyehY02jdmV3nb3iKbfUhaA1gRLCQ5jTHxJwclz1pQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=laWcqqDyhFACwzLvHhGjSVKybKvA69NXBe/sJdCMOZQLrMj1F3j0pjsMdR6yB7UZbcH+P7bm1QS0MpygWaXJUsXwE7Ar20kz9Iiz5ChHJhNew1FLxwllfHkCSthQGN3RoC0XGz9EaDFWmcdwO7D6/dd9EevZenEG65E5FGT4exY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=JZz1yb4Z; arc=fail smtp.client-ip=40.107.100.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0IGeLo29rQYyrSO0vqE21CeOSALO4F1+eCUtgzIWPtks9eHU2suT8QdK89SNGBzdR71Of01ypmJPgKPTFlXEWvy3bqsXg6FBDPP7UbIBTc8oPo4Fn6q/EpwkLWHliEMLNNioDWD2O5LAODavRGHsxGIB0EawPDbojrd/83UfgQO9zGaP6SPie/m9+yW4Jv+bBwTZST5NMrvsvNLRpLsFRBSdlx/hbB5iE5yCoFbyL+CyjzHFn7KPLpQa0C7039S6LbsF3qO3L4VhXFVR0NgDgXt4T5cA+lySsAxWjAYqo3FQNwXHUyu3QguGJHJTLxF/5zr07P9HZKQzsLkAno5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keyehY02jdmV3nb3iKbfUhaA1gRLCQ5jTHxJwclz1pQ=;
 b=x8HGoEAHq3OYBMLamt0+kbz0ZsuTq/Vxi8BWsErtNvJg26t8K2HnYSkJno5buV4aBgUfZoGvSfHiTos0gfDz/KyPbMJs18WUCLI0yOxY5YNnVkPe5D6eEw5zXOtxi1i7QJnTQZwfJfZzCSb//JkH3S0AXnC6+XQ66XBrkX6Vlz9Mkp54ihkAJ4Ofkg9oo1Dqb2vlBcqLqivPmjodU0cJ62coL+BVS9g5K3e1CA2MkrG3Fwg6Gwzu1DbfaPSoRGdH9uVBi/dszOcDo+b+57fyELdRSGYJD6hSHp/JFX5be2CUwOCQ4td8TYyMyPhKxy4J6y9hHAkQgwyFCiP5dtLfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keyehY02jdmV3nb3iKbfUhaA1gRLCQ5jTHxJwclz1pQ=;
 b=JZz1yb4Z1RWqJMfwLkv4DLowMVyc1G5zH/zTvF/DqIL6n+/LsmJjKKgmYQXyyChycixz6GArzEC3UldKcnqG3QS5lmCqIuhK643nVzuhyEa2kNBbobPO1/9eIOE7dldj2xnpJrfpLo/JhkWsITpv3sNEEaDh6w/NF3F9qqp/56E=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB4518.namprd13.prod.outlook.com (2603:10b6:a03:1d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 18:24:23 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 18:24:23 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>, "bcodding@redhat.com"
	<bcodding@redhat.com>
Subject: Re: [PATCH v3 4/6] NFSv4: Further cleanups to shutdown loops
Thread-Topic: [PATCH v3 4/6] NFSv4: Further cleanups to shutdown loops
Thread-Index: AQHbndY8Px3ZNipFIkm5cc4bvhAd1rOFM8uAgACFeoCAAAK5AIAAAOwA
Date: Wed, 26 Mar 2025 18:24:23 +0000
Message-ID: <a3f8e3189d4e6dd023a408a67fdf5eadd2458df6.camel@hammerspace.com>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
				 <668e25098cb97187d084d5fa2916ddd4d2a68e00.1742941932.git.trond.myklebust@hammerspace.com>
			 <c882f951c08fc67514357ddd3a47f188fa249e34.camel@kernel.org>
		 <225a2cda58e21100c7802151ea501e140e7b3a4d.camel@hammerspace.com>
	 <d6d48ed8e767a2aaa198fe7b21163285f6b8d26c.camel@kernel.org>
In-Reply-To: <d6d48ed8e767a2aaa198fe7b21163285f6b8d26c.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY5PR13MB4518:EE_
x-ms-office365-filtering-correlation-id: b0c11c7c-0aca-4c6c-7d19-08dd6c936ed8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?THFaVFZMRUdscXRLMlVhOEk3STBMeEpHSExRbUFYOGN4Z2hYVlUwSDZMOTZl?=
 =?utf-8?B?NU5tem9ocnNLTHJFUnl1RWpYLzluc08wY1FIcWZCajhBdjYrdHUySXhvbUpB?=
 =?utf-8?B?QW1YaytvQWhxTytTRmF1Vkc1YzdsZnNHRkp2TlJjMGtDV3EyT3JiY1dQOGJJ?=
 =?utf-8?B?OFIrNHlrT0YxeFFWWHkvUCtDL1NTNGFWVUoyVmgxdTBLbitJNW4xdjIvejhS?=
 =?utf-8?B?ZFpZaGhZS0ZtSTdGRDRTTWU4WGZGK3pjM2x3SCtRQ0h2V0tXUmFwVThrRHZi?=
 =?utf-8?B?WFdLaTg0d1doY3FOZW9Vb3k3RURlTDNBc09WTHFNOTdybVplNnJpVURtV0pB?=
 =?utf-8?B?VFJSdGZUQnNNeHMxOTN1d3pCU053VGhHUm1kZFpUUGhFNjJtUmpIYTVvRmgx?=
 =?utf-8?B?UnRyamR1MUMwSDR2TWRZS3hrMGdRejYrZVBMaTEyZDBKczhPblJ6MVpieXBV?=
 =?utf-8?B?bVVVNTQ4MERSc2Z5Y1p0RU9qTkI2emRYQzBQY2JsdSt5dzVVTkFLRDhQQVBi?=
 =?utf-8?B?d3hrRGdZVnYrSnlTZllvay9EUDgzSVVyV1QzaThBUDFiSVAxUzNUUzhqSENy?=
 =?utf-8?B?VTBNSy8wUklBL29EbXFPZDUyakhlTTgreUpwOFczVnlGU2JzZlJDanE2UFhp?=
 =?utf-8?B?S0IxTXdQNkc2K3I4N1hLVkN3bHQwa21BRnRkVmFCRnhiSzVzTVlleW9WcXow?=
 =?utf-8?B?UlpxdlpRTDJyS3RwWkxERVFTbDc2QTNmRFBkb3R0Z3pEWTMwR1ZFZldNeG9L?=
 =?utf-8?B?NHY0WkNwN2QyUEtUUjczcXRHcGx2K2dEUnYxZU5lbG9xZVZ5SktDcTkvUGNX?=
 =?utf-8?B?eUVjdTRpL21meWxQTEVIbzZBckx6Z1htRlN2MGdYWkZ6aVM4eVlyNEZYdmZz?=
 =?utf-8?B?Q3R1RWRNQjBwaWZKUjZsY1EzR29TYzVyZml5aW90bVpzbWwvaEt2elVqb01s?=
 =?utf-8?B?cDJHSnYvNHZHOWpnVTVBTlFRRWpmeHlKdS90YVl2RUhOMTVQbDZiT3Y2NkVW?=
 =?utf-8?B?b1V4MnRGWVlOZzJmYUdJbGJuQy9QS01RTFFya2tZSm10d2tXZzNUVkhqZ3ND?=
 =?utf-8?B?U3BtN1NnbVYvR3JlcUoxUUMvQWcxSm1ERllnSU9tMGd2TU9Oa3dRc0tiQmVV?=
 =?utf-8?B?NEpCTytDLzByUkt2WXh5czJGYW9iTlNtMU03b3ZHSUFZMTZBNmVMTENmS3Vq?=
 =?utf-8?B?VWhDS1lXdDAwWG8vc3ZBQjdtOFovcmhEZDVNRnI2cWxRMm45OXFGcElqL1dB?=
 =?utf-8?B?RExqelRLMmNCeU5TUHdnNjhEcVZKMTFQNlFQRi9qZHZQRzJ4UEFxRk8yaFBs?=
 =?utf-8?B?YWlmZTNsbmdhR0xzV3Z6SFRabnVtSkJvRk5vMFkrZVd4ZkxpR3ZBYkhobG9K?=
 =?utf-8?B?VlFoUnczVFNuK2hveVJwclpMRU15NFV2ZXFJZDhLS2U0R1V4K05Ja0lLc2JJ?=
 =?utf-8?B?Q2VpZEpTOVIyTzBvK1dqR0IzZG5HZ3RESGE0L2ZqSFB4N0pXbUNDVkhFNDNJ?=
 =?utf-8?B?dmdzdlA1dXhSSG9INFlFelUwdmQ0MHJtVnQvT24vRVA2UWVXV0ZaajRBZzRw?=
 =?utf-8?B?QkFna3FpdW5OZkVHM09LKzNCWHU5QjFXaUx5M3BuSjd4WW1kTldnZkdETjRk?=
 =?utf-8?B?MkFuMWx2R1BzVXF6S1d2ZG5VVkxxazMrNEN2RVMwRmp4bTZlRGNuY1JtZUlC?=
 =?utf-8?B?cTM3U3ZoSDdPT0dkU0hZaVZxY3BKalVUVjYrSG1SbkVDVEh2SzY5dFpHNU8z?=
 =?utf-8?B?V1N3TDdMU0huNStLOGZZMFp3VU9UdlZUZkJkM2ZHMUVSajBQSFNuYk5SeVFH?=
 =?utf-8?B?TXI1YWN5ckZuMU5QTmtweGw1L3FJZ1Y0ZTZMT0NhdHFFRUxaUzNrb0Z1Q2hp?=
 =?utf-8?B?VlVLVzcrMmJKaHcycnJBaThzY1Q1SmoyV1RiVm9LQ2c1cTNlQ3c4djlaUDFu?=
 =?utf-8?B?QjlaK0xWYmtYWGl3RU9JWHJrWFdsQzk0ejlyQm03NExDMDZDbUNOUlBEU2Ix?=
 =?utf-8?B?Q21sT0NCekxRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnVDKzRKckVmSmczSU1FQnJZQTZMMDZqY3crMFJPem5IMFJDWWxpeFphcSth?=
 =?utf-8?B?QVJvdHRGUGRYR2FLekhaNW9VOUdEb2hWYUdZUHR6SS96YVdhYkcwNWRqWGpp?=
 =?utf-8?B?elpsK3Jyb2lJYjB6QTNub0VHOWU1aWZrYnJSbGtuM1JNNzFLcDFjUUhFaXp0?=
 =?utf-8?B?OTVNQzVXUVdVOHBaak1KcUJ0cHhhWS9sKzV6V1MrUCtGdThETDlKaFp6Q3ZX?=
 =?utf-8?B?OWpHRDQ2dHpldHh5UDZBZkwzUDlxYmhzVVhhS0JBbEs3cmJyTk1NeC9UeWIz?=
 =?utf-8?B?cy9FazJqa2Uxc3U1aDVFaUs5d2wzY0RocjJYWCtvazU2QXkrRVA5QWpoMUdX?=
 =?utf-8?B?T3JUR29pMXlXQlBrMW1sd2dYaHNyMy9TQnF1dFJobm1BSzdDNEpvUjJaeUVV?=
 =?utf-8?B?bUh0SC9ZZWlibG9zOHJteHVNbUVzb1FHS3hKeENibWpab3RLeGR5VFdCRmpY?=
 =?utf-8?B?ZDVXVzJVUy9sUW13SkhmcTFaSEdXQmtCdEtBZFVQd1kvNmVtRWE3R0kybjdq?=
 =?utf-8?B?UGNXK2FSSUd1ZjR1d3VieUxlVVc2Um9ya3JTOG1hMWRVanFXcnZiTnJ1djNy?=
 =?utf-8?B?ZEVPdGo3Z01YeE9RS1FucVZjT05ZdEZCb3hLSlZieGZuUU9uaG01N2txN2tw?=
 =?utf-8?B?dit6ODNka3FuQnpNN0o0Vkh5SWN5dUVzK0lKckpQYlFIMzVEODBqampVUHoz?=
 =?utf-8?B?c2VHTHVYWktRNkJXR2NxWkxlVENtNkpsQVJ6cm5qTWRvOHB4cE1vVW5nVHJS?=
 =?utf-8?B?S2x6WDNJcWhYQTZrdHp6TlNZcHAxemt4QjRkejNZN2Y4UHVuSjZBVnpuQzRO?=
 =?utf-8?B?d3krQkRyRkphNjJmMm5jY3I3NHQvVGhKdnJFRzJtQ0g0YUJia3FhRHFLN1lH?=
 =?utf-8?B?QXFMN0trSFBWUDVKVXZQR3lhZkluUG5DbE5BWHFIYkFRdG5iVmJ0TWtJYWVO?=
 =?utf-8?B?QVBJdnV3Y0UyeVJnc0Jnd2FkdlVKeVBsK210ZVQ3UVpucHVVdlBYVFViakMz?=
 =?utf-8?B?ZWF6U1UwQUU4NGx0Q2lQVFdnKytqT0QwbTY5L2paa1cvcCtnTjVzdFk4eFJH?=
 =?utf-8?B?L2ZKZHUwa0JlTVdIaXV6dUk2Mmx3aW9wZDZtN2xWZ2NULzl6MjNYWUVFTTNk?=
 =?utf-8?B?dDhVTjNSbGNZYXR1SWh2Y3BLTXRFdnIzNWZNbmlub21qMnN0cWhQZkdkYmxI?=
 =?utf-8?B?b3hFV3FJcCtsQjFiUWhaZ0F0dGozZkxDaWtWbmhCaDdRMTFzdHlVa0Z5bXZx?=
 =?utf-8?B?VU92RWhQSENKcE1wSVFVdFRnRTBubkoybnhKekY5VldTTmZKYlprNk5DVDBB?=
 =?utf-8?B?anQ1Zm1tTHdBYnNER0x4dzdLWEthOHUxclJaNFFrb1JySnRLcUVhVjhWQ2tq?=
 =?utf-8?B?YnJHdUtBMU1WUWNTbnVnOGZhVU5OekVDWDNMZDRtWEduMzlQa0RJZVYxQUZO?=
 =?utf-8?B?NzJXQ0NycUJxaEZ5Z3hraUZncjlnQjVCbzR6ejFZQlBSRnFNM0s2M0N2RDNN?=
 =?utf-8?B?R2ZINkFTQ252ODJVOE15MndSTDVFWVpvcjlwL3JaZjJzVENUQmxieUE5MXpN?=
 =?utf-8?B?NlhsWENGRnlSSEwyMUxIMmZDWW9DSGJIcHI5RTlFWGNSclAzeWY1b2NTZUJL?=
 =?utf-8?B?WTRpNXNQS3Z3cDN2M000Rzl3NTIvSVA2S3p5bmdDcC8vMmZFSUp0RVU5VVR2?=
 =?utf-8?B?bVMrcnhYYUxxdHQ5c3dpR1k3U2FrTk8rUmd3QmRMMXdYUUp3VDczYU16VEJ1?=
 =?utf-8?B?a0hpd0lPN1gzSW5kS3F2UmZJdkRzWXBDRlgrU2Q5emdhVCswV3dLRFNXUCtM?=
 =?utf-8?B?NkhtSG5LeTFENUUrRjVRdGJDOENrbW9ENG5LZ2JCOEJrYWhaSHRnNXR6VTg3?=
 =?utf-8?B?Ym0zcSt5WjcyYURwTDBXSkxReUUyR3NaalltZ0pJVEVvS0pmbUlRUXdZSExY?=
 =?utf-8?B?MmVhYjBMMWhVWUlWTVo4cXVQYmtncWlqSU5Rd3JNZFk2UkoybHdnaFYyQlpQ?=
 =?utf-8?B?YlplWHBxalVlT2dycm1UWlBzY3lOekZuTFhBUittVEkycVNCeDd3a05XZkZZ?=
 =?utf-8?B?VWJvMnZzbG41MGd2THRGakh1d2UxSGZvaXBiN2xsRVJjU1hZckFnYzBjb21n?=
 =?utf-8?B?N2tyUWhoS0psdXdpSW1OVTJtcUgrQ2p1WHpNT1pVcURCWDg3SmJ5NTNMY1JV?=
 =?utf-8?B?MWUvYTlzWks1TWFOSTkrcUcxTXQxWGV3endpWlVyQXR4N1orRHVTOTlmYUJn?=
 =?utf-8?B?d3ErQ01pbHBLV2xBR3llWldGNHl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36A850EB668FED42B5C01464A7190B48@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c11c7c-0aca-4c6c-7d19-08dd6c936ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 18:24:23.1538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGWH4KPLnsRPmDSK78EAbLywNzauGyV929hnBMVPZ5/Gv+IAx8G4nVe4CCR5SP9kkZW/TOgFmBAhzMVHtKX9uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4518

T24gV2VkLCAyMDI1LTAzLTI2IGF0IDE0OjIxIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gV2VkLCAyMDI1LTAzLTI2IGF0IDE4OjExICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gV2VkLCAyMDI1LTAzLTI2IGF0IDA2OjEzIC0wNDAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IE9uIFR1ZSwgMjAyNS0wMy0yNSBhdCAxODozNSAtMDQwMCwgdHJvbmRteUBrZXJu
ZWwub3JnwqB3cm90ZToNCj4gPiA+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gUmVwbGFjZSB0aGUgdGVz
dHMgZm9yIHRoZSBSUEMgY2xpZW50IGJlaW5nIHNodXQgZG93biB3aXRoIHRlc3RzDQo+ID4gPiA+
IGZvcg0KPiA+ID4gPiB3aGV0aGVyIHRoZSBuZnNfY2xpZW50IGlzIGluIGFuIGVycm9yIHN0YXRl
Lg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0DQo+ID4g
PiA+IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gwqBmcy9uZnMvbmZzNHByb2MuY8KgIHwgMiArLQ0KPiA+ID4gPiDCoGZzL25mcy9uZnM0c3Rh
dGUuYyB8IDIgKy0NCj4gPiA+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZz
NHByb2MuYyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+ID4gPiA+IGluZGV4IDg4OTUxMTY1MGNlYi4u
NTBiZTU0ZTBmNTc4IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9mcy9uZnMvbmZzNHByb2MuYw0KPiA+
ID4gPiArKysgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiA+ID4gPiBAQCAtOTU4MCw3ICs5NTgwLDcg
QEAgc3RhdGljIHZvaWQNCj4gPiA+ID4gbmZzNDFfc2VxdWVuY2VfY2FsbF9kb25lKHN0cnVjdA0K
PiA+ID4gPiBycGNfdGFzayAqdGFzaywgdm9pZCAqZGF0YSkNCj4gPiA+ID4gwqAJCXJldHVybjsN
Cj4gPiA+ID4gwqANCj4gPiA+ID4gwqAJdHJhY2VfbmZzNF9zZXF1ZW5jZShjbHAsIHRhc2stPnRr
X3N0YXR1cyk7DQo+ID4gPiA+IC0JaWYgKHRhc2stPnRrX3N0YXR1cyA8IDAgJiYgIXRhc2stPnRr
X2NsaWVudC0NCj4gPiA+ID4gPmNsX3NodXRkb3duKQ0KPiA+ID4gPiB7DQo+ID4gPiA+ICsJaWYg
KHRhc2stPnRrX3N0YXR1cyA8IDAgJiYgY2xwLT5jbF9jb25zX3N0YXRlID49IDApIHsNCj4gPiA+
ID4gwqAJCWRwcmludGsoIiVzIEVSUk9SICVkXG4iLCBfX2Z1bmNfXywgdGFzay0NCj4gPiA+ID4g
PiB0a19zdGF0dXMpOw0KPiA+ID4gPiDCoAkJaWYgKHJlZmNvdW50X3JlYWQoJmNscC0+Y2xfY291
bnQpID09IDEpDQo+ID4gPiA+IMKgCQkJcmV0dXJuOw0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMv
bmZzL25mczRzdGF0ZS5jIGIvZnMvbmZzL25mczRzdGF0ZS5jDQo+ID4gPiA+IGluZGV4IDU0MmNk
ZjcxMjI5Zi4uZjFmN2VhYTk3OTczIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9mcy9uZnMvbmZzNHN0
YXRlLmMNCj4gPiA+ID4gKysrIGIvZnMvbmZzL25mczRzdGF0ZS5jDQo+ID4gPiA+IEBAIC0xMTk4
LDcgKzExOTgsNyBAQCB2b2lkIG5mczRfc2NoZWR1bGVfc3RhdGVfbWFuYWdlcihzdHJ1Y3QNCj4g
PiA+ID4gbmZzX2NsaWVudCAqY2xwKQ0KPiA+ID4gPiDCoAlzdHJ1Y3QgcnBjX2NsbnQgKmNsbnQg
PSBjbHAtPmNsX3JwY2NsaWVudDsNCj4gPiA+ID4gwqAJYm9vbCBzd2Fwb24gPSBmYWxzZTsNCj4g
PiA+ID4gwqANCj4gPiA+ID4gLQlpZiAoY2xudC0+Y2xfc2h1dGRvd24pDQo+ID4gPiA+ICsJaWYg
KGNscC0+Y2xfY29uc19zdGF0ZSA8IDApDQo+ID4gPiA+IMKgCQlyZXR1cm47DQo+ID4gPiA+IMKg
DQo+ID4gPiA+IMKgCXNldF9iaXQoTkZTNENMTlRfUlVOX01BTkFHRVIsICZjbHAtPmNsX3N0YXRl
KTsNCj4gPiA+IA0KPiA+ID4gT25lIG1vcmUgdGhpbmc6DQo+ID4gPiANCj4gPiA+IERvIHdlIG5l
ZWQgY2xfc2h1dGRvd24gYXQgYWxsPyBJZiB3ZSBjYW4gcmVwbGFjZSB0aGVzZSBjaGVja3MNCj4g
PiA+IGhlcmUNCj4gPiA+IHdpdGgNCj4gPiA+IGEgY2hlY2sgZm9yIGNsX2NvbnNfc3RhdGUgPCAw
LCB3aHkgbm90IGRvIHRoZSBzYW1lIGluDQo+ID4gPiBjYWxsX3N0YXJ0KCk/DQo+ID4gDQo+ID4g
VGhlIHN0cnVjdCBuZnNfY2xpZW50IGlzIGEgTkZTIGxldmVsIG9iamVjdC4gSXQgY2FuJ3QgYmUg
bW92ZWQgdG8NCj4gPiB0aGUNCj4gPiBSUEMgbGF5ZXIuDQo+ID4gDQo+IA0KPiBCdXQuLi5jbF9z
aHV0ZG93biBpcyBhbiBycGNfY2xudCBmaWVsZC4NCg0KUmlnaHQsIGJ1dCBjbF9jb25zX3N0YXRl
IGlzIGEgZmllbGQgaW4gc3RydWN0IG5mc19jbGllbnQsIGhlbmNlIHRoYXQNCmNoZWNrIGNhbm5v
dCBiZSBtb3ZlZCBpbnRvIGNhbGxfc3RhcnQoKQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==

