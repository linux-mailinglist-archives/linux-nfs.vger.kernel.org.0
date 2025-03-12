Return-Path: <linux-nfs+bounces-10577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AC7A5E7BE
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 23:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027AA1899D74
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 22:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9751F12EF;
	Wed, 12 Mar 2025 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="GrvFkF/y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2096.outbound.protection.outlook.com [40.107.220.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E516F1F0E45
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820274; cv=fail; b=HF94NauMKZQmSbzQLlG1UfD5D/JwNFtkvbDIelSjB0SX7idfm99ZLXNwgNURuQXKAD0gG7Iw9UbQZB4sNVCjrJ+JhekGTbcVTGMJjVlRC85tRuXaEfzYBslbQegdvPLqB6zfSRhWqyNowBaCdDt3zptcHErdIbJdMTA7Cejuy/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820274; c=relaxed/simple;
	bh=84Wcxnljz2dyhPK4Kv0tPFp6GzQrKzwN2kOK3G5rnr0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r5ReiCjhcE6XygTCS63SqU68qY2ZpP11MMHOKjIcclsEthfGLTYclxNtgbwlxHH9z9gufksJu0FibON55grd7ky/8PJe0zek0WEYmIqvfOfIWA9262SoR7tUWqe0HhMg0viVMFPjAxfyN8/VA3/6T6SET739Qqw+kNwxGC80ACU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=GrvFkF/y; arc=fail smtp.client-ip=40.107.220.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juc1X/XGh/n0UnYArMWIzVC17WQzFhUFdKzTDVrQtkj9OJo2rK9h4xRl8TRcmuUxAjBIHljRHZClhpskDY4vmKxaRoMUk7K1bTKR/oPxJxiRM7tsI+GoN+rBinyvwyO/a0yBaA/PkeZ0ugg0N81DxmL44k4xALWRLhe576HkHGqgmg1mYi/Q19E38KDjZCN5XjKtYSpIr3kOvLbEUaQAOmCknMBSrmq8aClD5EkhADpkRtA9mJeZEmXLcivUsSwgiO7x95oM5bYc8LHbcvlwO9+YPMMIlO7MXAPGystthxfyd569izuDO12VOzTQdN/NJbeBI0oIRbzFkONp+psI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84Wcxnljz2dyhPK4Kv0tPFp6GzQrKzwN2kOK3G5rnr0=;
 b=w7KdfisNGq0x5mKLUnkq4Rz3V2+ODoZyA62iXylJiUgjxBXLdqTLlZNHD4hawlqeSWTEPo7wsSxcVjovQ1Waz/kxGuhZM5ew8HeTkrmLqSv6hTxTwHxeG1gQ2IvKqJV+qAwwVnB75sgqXQq/gH+HlT4O7ldhTG/7ZF0CetRL8rQD/Zk8bw8UZxsvoHV6ZJQObh/PeJtRLc3xI6+NDPe0xd+i/Y27Lo3l/ZUvI765YI5tMHpNGn7ayUozHZNuBCogqa0WnfrBxuXqcaqswvQ7Ho62Ccz64wD5XkbP5EEWopdcyRJKvsQW0nKlZhpsBYek6/Ttek6NVdhM01EZjYhA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84Wcxnljz2dyhPK4Kv0tPFp6GzQrKzwN2kOK3G5rnr0=;
 b=GrvFkF/yZj0coZauDkMXcNjCuGsvtSjUJrWXP8GeXxIMXTDTcCNQDcwscsZi3iJCFWHCXzdrkPj2DnAHyIGEw3n+aK8udHEbzswQumNmHKHlj7QfO0oRH6VRe9l3NT1tAEMdthzxOxD5/t8ZJpDhk/6BtbE03QowwWARknAuiNA=
Received: from BL3PR13MB5073.namprd13.prod.outlook.com (2603:10b6:208:33c::7)
 by LV8PR13MB6776.namprd13.prod.outlook.com (2603:10b6:408:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 22:57:50 +0000
Received: from BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::b148:fe5d:ff6a:6310]) by BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::b148:fe5d:ff6a:6310%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:57:50 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"tychokirchner@mail.de" <tychokirchner@mail.de>
Subject: Re: Parallel shared to exclusive flock conversion blocks forever on
 single NFS client
Thread-Topic: Parallel shared to exclusive flock conversion blocks forever on
 single NFS client
Thread-Index: AQHbk5qJIi5B8bawlkCYp+LDOy1/oLNwHSWA
Date: Wed, 12 Mar 2025 22:57:50 +0000
Message-ID: <05ce8da1909fd21c2511abf1d21536a872077324.camel@hammerspace.com>
References: <d27d885e-568c-42b8-a204-2f4a3e949d64@mail.de>
In-Reply-To: <d27d885e-568c-42b8-a204-2f4a3e949d64@mail.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR13MB5073:EE_|LV8PR13MB6776:EE_
x-ms-office365-filtering-correlation-id: c4f633d3-eafd-4aa9-5225-08dd61b95098
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3Vmb1U0ZGNpZExyOTl0b1FRc3V2MGVMMzNVMTE5aFNyNzNJSXc5Z1BNa0ZZ?=
 =?utf-8?B?UnFqUmZoNXRkU1VIS1Z3SVo1K2dZWVRqUWFnRENWNFd3azRTU3ZPYWtDWVd5?=
 =?utf-8?B?MCtWcU5yVkZoMEwrRTVpV0g4YWFKYmR5TjBZWUtUZFBEWDE2WTdRbitRWStB?=
 =?utf-8?B?djRNdnBIL2pPK3g1OVBtYTN3UkhXRTltSS9kWmdCUlV2WDZXckJXQU95cW5C?=
 =?utf-8?B?QWs1UHZKdVpnVFdXZFF3MFUxZVlGeDJWb211UU9Bend0QWRSa1FqUVNLdkwv?=
 =?utf-8?B?K2Jpc3RzbVhYZDRnMXYzWXdxalBnbjFZQ2FnWGx0MnFHaGNTcFVYSGdOK3dB?=
 =?utf-8?B?K0lyQTBrYzVscjYxQStpczUvbWZLZ0UzWlRMTkp2eUNBZENvWmVOSXlkZlFM?=
 =?utf-8?B?S3EyT2EyOUlYZU54ci9UcS9haXNVSmZpbWU2RUtLZVlYRjBQMTNMSS9RSmRV?=
 =?utf-8?B?WWdNYjRPaC92a1VhSzBUSWsrUExrMUR2aHdEd1ByQ1U2UDJraStjekRIZmRa?=
 =?utf-8?B?V2pBOWFpcEhHT0JLdUE0KzZPSUxYVGFCTWxEODg1eG5MYnNhMTMzajBZY1Qx?=
 =?utf-8?B?bEl3UGlod3dJZzErNi9jMmMydHQ0Si8xWTNaWVZOajBnOG8rRFZ3VGJaZEJn?=
 =?utf-8?B?VVJ3VEpYMUZhMzh6WUVVbUUraVFjbWlsRjZOeExoNWYvczM5Z2hNTU1WNjJt?=
 =?utf-8?B?eEZjQnFsQ1docXViRzFpaWNJZ0grMnU0UkkwSjNSaXN5V3Q2bzBNRFdZaVly?=
 =?utf-8?B?WFJaMHlKU3R1SHorSmdwMmtUV1hCN2NySXBEZ0pJOHlQWjc0ZW14UGRyRnhr?=
 =?utf-8?B?N3Z0Qk9UR3I3L0xUeWprZWU1SFJxbisxNW1vWlBBVnh3eXhSVE1iQWlJTi9q?=
 =?utf-8?B?bHNFRGVmSUt5aWZxNHpYcFR0YW1Gam9DWmM2b094c2QrZmI1Q2ZYRTRBeVp5?=
 =?utf-8?B?YkY4alNWSG1NeHVFN0h4WmZhMkdzZGp1ZFo1K1VvNUt5a1dHbEgrQWd1RUF2?=
 =?utf-8?B?RUUzd0ZIMjJHTEZRcGVsaTU5cEVHYUdIbUtxOHdZaWdCWUZ0dDFNT1Y1am5L?=
 =?utf-8?B?RE92ZXpaL3hjdlh0Mld2dHJnUDVySWdhY2ZSWFlRTWVQQThycmJ2QnJYWFpC?=
 =?utf-8?B?a2pTWGRTSEJMWEJCcFkrZlYwZ0Q0K3VVcm02S2ZTUW9EZ2R1ei9jMnVLbXNa?=
 =?utf-8?B?bkJ0RHY1cHN3UnhpaEtTUWgvR1BOZUFlakYrNVhXbllDQmZGMXF0VnpNWk9h?=
 =?utf-8?B?djVKeW4ydExpVlQ5KzVLczN2Mk40TWlsaVhxc0JzZEJOS3dpWDcwcEZqcmls?=
 =?utf-8?B?T0FzOHd1aVl5THZTNEM5N2R3d0VDSzVQVnZWaGdmUjB3cmxxaUoyUjNHZUg2?=
 =?utf-8?B?Y2FjUWxCdEF5azkxNkxOVm04VFF3Rldwa3c3Nm9xTjBTZm11T0JrZTdyR3dy?=
 =?utf-8?B?NXdEeUxWTTMreGJQSjJndDlYdmpnZjNGZFJramxuUHJLelhBenV4L1pZQ3V1?=
 =?utf-8?B?cXo1WG5uTWE3T2JGWmhEWjRYOE8ybElBUDgyWWJxaUZPT0pmaEpBamF6NUZK?=
 =?utf-8?B?Qk42eEJTSHduVnNGOC85dGpZZExxaEtFZHdZS282M2pQV01KNHlJTys1U3RB?=
 =?utf-8?B?NHZnTzhIaUdCRERpS0VUdkRLNTFJUFlxU3dqcjhsL3FmblFZcFNuSVRobDBB?=
 =?utf-8?B?RFJvdFg3ZFJhVVJmeEpwTlQ2aWk5Q1ZFemN4dWdrdUZocGJrS2dNL3NXV3k2?=
 =?utf-8?B?Y2syeS84bllzMHM2WlJ4UmRQWWgvS0RyMTJuT1VDelpMcnY2b2VMZWt0NUxV?=
 =?utf-8?B?YUtqejVyZHNLT0syWXRzSDRFaGx0UCtHRWV4dlh5dzY0aWRkK1BoZmNEZTdq?=
 =?utf-8?B?NERrYXlJYUQ3ZkJDUWdaOWUzVWp2aEpxQndLTkRlbk9FTS9oOU1LWlN1MTZi?=
 =?utf-8?Q?rpHDfK+3srMUYOb5Lx2JjQW3TFMWWK96?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR13MB5073.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STY2YzFkQnVwVTB6TlBFb2RCRUxSaDVZeXlibWppc1dOTXJLekQ3SGFvNWc5?=
 =?utf-8?B?UVFKM0Y0amMwcWVicGxEMXE5djZhOHpnVjdDVzA1dWJ5RkQ3Wk55N3JDcGVs?=
 =?utf-8?B?OHdORU12VTczNitYbGl4T1dleCtFTEJDSEhkQ0hSdXNrb0w0SDhJVGh0T3VY?=
 =?utf-8?B?MGgyeHBxbm5OcC9rUURUQ1lXRC9tRmNFaFQ0bGpSdksrR3BNdjlUU3ZRU2Fy?=
 =?utf-8?B?TFg2akxzS081UGNDOG9INktCRGQxS0xhZWpYTSt5K1hubi9vUU1hNGMvT1pr?=
 =?utf-8?B?MHFJTVp2TlgyMzFPcExCcjFZQ0FTZ1pXUHZhY0plUmJtNnB6L0J2RmozSkVJ?=
 =?utf-8?B?QXllYitCVm1EOExIYWl4SzFOMXV4SC9yRWNkYVNod0N2U1hmWElrcEdmYXAw?=
 =?utf-8?B?SHJ3bGFXRmZxN20yMk8rakVUOWU4VGNOYkM2cVJUa3Ivb2Z1SUt1QlZzMDU4?=
 =?utf-8?B?M1JqdlNDMy9ONU9TeUg0Q1QyTEFUSmpRVGUwZWpHUFNNN3NBOHdsR0ZnOG9E?=
 =?utf-8?B?MmhGMzd4czQ3bVUxRlB3WUhGZzArN2dLMFFTditVVExiSlVEQXhvekNybVRi?=
 =?utf-8?B?clB1eDZXc21sSFZCa2dGVUlscEVDalJONU1uVUhrc1ZJa2FoRHBaNnB5OWFM?=
 =?utf-8?B?RGpQcU5SZVNQZUlCaW5mVFFHUjlaVmkvM1Uzb2pRRHQyK0VVQWJ3TXNJZENq?=
 =?utf-8?B?SnpIbG1UVEJGOEMrZHVyRFlVckhnNG5GMDhRanNMWkx4c0U1UzNRVGZCQXZ1?=
 =?utf-8?B?SEM3YW01Sk9XK2ErUHAxZ2VKS0tiWTYwL1U4aE4zd29NQ0lITUdmN1RlUk9S?=
 =?utf-8?B?YkQ2UEZZVXBoMklRNnhEY1d2cXpXNlFBMkR5azV0VjNieGRVNHIySkpiOXVO?=
 =?utf-8?B?NHNLdHVzNjF2Y3pHSnpoamw4OC9kWXN0cUJlMUJyK2ZsU3ZqN2VROUoxOWZu?=
 =?utf-8?B?ZkptcGpUZ2tNSUVJZ1FaY24zOXpmUlJZamZ5b0htSHk0YmU4OHFKWVVySTI4?=
 =?utf-8?B?ZXNPUDBReEl5ckplMGhWSUZsZEZRWU1wY2RuNmR1dWF5Y1YwYlI5S2Y1MUhl?=
 =?utf-8?B?ZDViMTB4SjJva1NPSEVCQTIzL3AwdkJVRHVWeHd1WWZUMDZzbTVXcDh3azk1?=
 =?utf-8?B?enRIZndwTFBFRjVFYXlmbnBteUhnSVlrVVV4MDgrNlI0b2p3dUxvT0ptVzdv?=
 =?utf-8?B?Ym9wc0VhanFIRlA3ekVQNlVnWmpnN0lWN0hhWUw1UVo0RmFwSVJDNXFkR1VG?=
 =?utf-8?B?Z2ZueGplLzUvTk9sOGdCZ3dDdEdONUtKcG8ydFFLQ1lCSzhOKzJuQWtvVVZC?=
 =?utf-8?B?TVVoejR2MmJCckxHRkRxVWxYbys4Z3Bld1d1WkFVWUdGZldmeHRVTUN3Q1RV?=
 =?utf-8?B?MTY4RXFObTJuTlNRYndISmhWWWZJMnlXK0pIVFpkRy8waE1aUlZWTTNUdmxL?=
 =?utf-8?B?VU1PaUpsM2xlSm92MEwrQlhIaEx6dk0vTy91d3FkUXdCT0xNU2tkSkxjcHVt?=
 =?utf-8?B?QnlZZ05Iei9kbFRVckM2VTdhSzZSNjl4dFF5V2J2WDhEM2ZHWVY5SlFFTjYr?=
 =?utf-8?B?K0kvRm93UmJ4Z2t6U1dpRnFXVHZ6L251enhZTHZXV3JIT0I2dURORVFwWXND?=
 =?utf-8?B?a1ZxbUl4ckI2aTJWelpYODdPZHRCdTlOU3k0MVBZTVI5aTJBMWxkMkxZRFc2?=
 =?utf-8?B?amovK1UyYkkzTHlwcm9JeGx0akdLM2laaWIycG5HSm52bjNUYlRGSFlzOG9p?=
 =?utf-8?B?Y1grOG9qVUNxaUw0UFV2SldNR3U5aSs2OHVWR1luRWVjeUg4eWNTdFNObHJ3?=
 =?utf-8?B?SHpkSXYrWFJBUzRReHRuSDZ2ZEJhV3VJOGF4RFdLczJKVktWUE83ZFhjVU5K?=
 =?utf-8?B?SjJnbGNqa0RxNHJRZkQxdzRBUUVmWVJPUDY2bWpXZ0Y2TlA5eURlSXJmZE8w?=
 =?utf-8?B?RWFIR3dkMUJZaDB4K1NHNGEycUYydUZ4Qy9MaFNFcm9UV04wK2lZdEd6V2Nj?=
 =?utf-8?B?S0lobFZhalE0bldTaFRMSlk4TUZsYXQyN0dGNW9qT3cyZUFkd0ZlUjRVclR4?=
 =?utf-8?B?SDJuYVE4YkRZVlRkTDQ1MkV4NDBKbUg4ZHU0UFBLSnU4YTdKUVJ4VFB2V0pY?=
 =?utf-8?B?N0xZdFFtMlNaQWQ5UnlvUTJma0p2enJNUVIrUjJ6T2daQkdUdTdrM1MyLzV5?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F1BA30466EBF7459431736F9110FE45@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f633d3-eafd-4aa9-5225-08dd61b95098
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 22:57:50.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prLK4Gzg1uldLGvl2X66lDER35cgYZIJwNZ9YEXSSgDFurCISPdGPJ0eAN68hAgBcz9hYcVAG2ZyqaeWRrv1+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6776

T24gV2VkLCAyMDI1LTAzLTEyIGF0IDIyOjU3ICswMTAwLCBUeWNobyBLaXJjaG5lciB3cm90ZToN
Cj4gRGVhciBORlMga2VybmVsIGRldmVsb3BlcnMsDQo+IEluIGBtYW4gMiBmbG9ja2AgaXQgaXMg
ZG9jdW1lbnRlZCwgdGhhdCBhbiBleGlzdGluZyBsb2NrIGNhbiBiZSANCj4gY29udmVydGVkIHRv
IGEgbmV3IGxvY2sgbW9kZS4gTXVsdGlwbGUgcHJvY2Vzc2VzIG9uIHRoZSAqc2FtZSogY2xpZW50
DQo+IGNvbnZlcnRpbmcgdGhlaXIgTE9DS19TSCB0byBMT0NLX0VYIHF1aWNrbHkgcmVzdWx0cyBp
biBhIGRlYWRsb2NrIG9mDQo+IHRoZSANCj4gY2xpZW50IHByb2Nlc3Nlcy4gVGhpcyBjYW4gYWxy
ZWFkeSBiZSByZXByb2R1Y2VkIG9uIGEgc2luZ2xlIHBoeXNpY2FsDQo+IG1hY2hpbmUsIHdpdGgg
Zm9yIGluc3RhbmNlIHRoZSBORlMgc2VydmVyIHJ1bm5pbmcgaW4gYSBWTSBhbmQgdGhlDQo+IGhv
c3QgDQo+IG1hY2hpbmUgY29ubmVjdGluZyB0byBpdCBhcyBhIGNsaWVudC4NCj4gDQo+IFN0ZXBz
IHRvIHJlcHJvZHVjZToNCj4gLSBTZXR1cCBhIHZpcnR1YWwgbWFjaGluZSB3aXRoIFZpcnR1YWxi
b3ggYW5kIGluc3RhbGwgTkZTLXNlcnZlcg0KPiAtIENyZWF0ZSBhbiAvZXRjL2V4cG9ydDogL2hv
bWUvVk1VU0VSL25mc8KgIDEwLjAuMi4yKHJ3LGFzeW5jKQ0KPiAtIENyZWF0ZSBhIE5BVCBmaXJl
d2FsbCBydWxlIGZvcndhcmRpbmcgTkZTIHBvcnQgMjA0OSB0byB0aGUgVk0NCj4gLSBNb3VudCB0
aGUgZXhwb3J0IG9uIHRoZSBob3N0LCBjaGRpciBpdCBhbmQgY3JlYXRlIGFuIGVtcHR5IGZpbGU6
DQo+IMKgwqAgJCBzdWRvIG1vdW50IC10IG5mcyAxMjcuMC4wLjE6L2hvbWUvVk1VU0VSL25mc8Kg
IC9zb21lZGlyDQo+IMKgwqAgJCBjZCAvc29tZWRpcg0KPiDCoMKgICQgdG91Y2ggZm9vDQo+IC0g
RXhlY3V0ZSBiZWxvdyBhdHRhY2hlZCB+L2xvY2t0ZXN0LnB5IGluIHBhcmFsbGVsIG9uIHRoZSBj
bGllbnQ6DQo+IMKgwqAgJCBmb3IgaSBpbiB7MS4uMTB9OyBkbyB+L2xvY2t0ZXN0LnB5IGZvbyAm
IGRvbmU7IHdhaXQNCj4gLSBXYWl0IGhhbGYgYSBtaW51dGUuIFRoZSBjb21tYW5kIGRvZXMgbm90
IHRlcm1pbmF0ZS4gRXZlci4NCj4gLSBBYm9ydCBleGVjdXRpb24gd2l0aCBDdHJsK0MgYW5kIGtp
bGwgbGVmdG92ZXJzOiBwa2lsbCAtZg0KPiBsb2NrdGVzdC5weQ0KPiANCj4gTm90ZXM6DQo+IC0g
QWNjb3JkaW5nIHRvIG15IHRlc3RzLCBmcm9tIHRocmVlIGNvbmN1cnJlbnQgY2xpZW50LXByb2Nl
c3Nlcw0KPiBvbndhcmRzLCANCj4gdGhlIGJsb2NrIHF1aWNrbHkgb2NjdXJzLg0KPiAtIFBsYWNp
bmcgYSBgZmNudGwuZmxvY2soYSwgZmNudGwuTE9DS19VTilgIGJlZm9yZSBmY250bC5MT0NLX0VY
IGlzIA0KPiBlbm91Z2gsIHNvIHRoZSBkZWFkbG9jayBuZXZlciBvY2N1cnMuDQo+IC0gT1InaW5n
IGB8IGZjbnRsLkxPQ0tfTkJgIHF1aWNrbHkgcmVzdWx0cyBpbiBlbmRsZXNzDQo+IMK7QmxvY2tp
bmdJT0Vycm9ywqsgDQo+IGV4Y2VwdGlvbnMgd2l0aCBubyBjbGllbnQgcHJvY2VzcyBtYWtpbmcg
YW55IHByb2dyZXNzLiBTZWUgdGhlIGFsc28gDQo+IGF0dGFjaGVkIH4vbG9ja3Rlc3RfTkIucHku
DQo+IC0gTXVsdGlwbGUgZGlzdHJpYnV0aW9ucywgS2VybmVsdmVyc2lvbnMgYW5kIGNvbWJpbmF0
aW9ucyB0ZXN0ZWQsDQo+IGUuZy4gDQo+IE5GUy1jbGllbnQgS1ZFUiA2LjYuNjcgb24gRGViaWFu
MTIgYW5kIEtWRVIgNi4xMi4xNy1hbWQ2NCBvbiANCj4gRGViaWFuVGVzdGluZywgb3IgS1ZFUiA2
LjQuMC0xNTA2MDAuMjMuMzgtZGVmYXVsdCBvbiBvcGVuU1VTRSBMZWFwDQo+IDE1LjYuIA0KPiBU
aGUgZXJyb3Igd2FzIGFsd2F5cyBhbmQgcXVpY2tseSByZXByb2R1Y2libGUuDQo+IA0KDQpUaGUg
c2FtZSBtYW5wYWdlIGFsc28gc3RhdGVzOg0KDQogICAgICAgQ29udmVydGluZyBhIGxvY2sgKHNo
YXJlZCB0byBleGNsdXNpdmUsIG9yIHZpY2UgdmVyc2EpIGlzIG5vdCBndWFyYW50ZWVkDQogICAg
ICAgdG8gYmUgYXRvbWljOiB0aGUgZXhpc3RpbmcgbG9jayBpcyBmaXJzdCByZW1vdmVkLCBhbmQg
dGhlbiBhIG5ldyBsb2NrIGlzDQogICAgICAgZXN0YWJsaXNoZWQuICBCZXR3ZWVuIHRoZXNlIHR3
byBzdGVwcywgYSBwZW5kaW5nIGxvY2sgcmVxdWVzdCBieSBhbm90aGVyDQogICAgICAgcHJvY2Vz
cyBtYXkgYmUgZ3JhbnRlZCwgd2l0aCAgdGhlICByZXN1bHQgIHRoYXQgIHRoZSAgY29udmVyc2lv
biAgZWl0aGVyDQogICAgICAgYmxvY2tzLCAgb3IgIGZhaWxzICBpZiBMT0NLX05CIHdhcyBzcGVj
aWZpZWQuICAoVGhpcyBpcyB0aGUgb3JpZ2luYWwgQlNEDQogICAgICAgYmVoYXZpb3IsIGFuZCBv
Y2N1cnMgb24gbWFueSBvdGhlciBpbXBsZW1lbnRhdGlvbnMuKQ0KDQpzbyB0aGVyZSBpcyBubyBo
YXJtIGluIGFkZGluZyB0aGUgTE9DS19VTiBiZWNhdXNlIHlvdSBjYW5ub3QgZXhwZWN0DQphdG9t
aWNpdHkuDQoNCkNoZWVycw0KICBUcm9uZA0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20NCg0KDQo=

