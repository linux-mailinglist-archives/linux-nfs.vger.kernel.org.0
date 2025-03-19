Return-Path: <linux-nfs+bounces-10684-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE4EA68435
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 05:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28765189400F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 04:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB7121171D;
	Wed, 19 Mar 2025 04:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="KkYQV/T1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2136.outbound.protection.outlook.com [40.107.237.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B620D519
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 04:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742358547; cv=fail; b=SgOn/P95yeID6YVOP+q1y2zcYyC00BopTKmC80FMeiOuYQFo2vQEDK9KzsyIjQhwYd4fNat+8RphjBJ83bF9MmDH6zl3SBBMBUqi+xVi8jk+qYyICysYg4jFzchbD1fkuO+rAKbrPRYbj5SGhajwRQ8OuyqXJ5uzwbx9IV6UAhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742358547; c=relaxed/simple;
	bh=8unb+bT/ZDjhpSY1Hn4dKep41pw/5P7CK5OO6Ud1LHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rbGlTuPxzwtmZVpnopgQ+6A3JioL4Hw3dGKjl8k+/F64dMj6Nc53ohkoK4Lpr1QXkM8n/1Y7SP6+i6QkIlTeUM6TT50NS3o4FY8Gc+d4Magsb5nLCaCDdyD2DXu6oO1JGINPETOwd0JQgIhWVZgCRNMl6G43GVaAZesTnbsQgb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=KkYQV/T1; arc=fail smtp.client-ip=40.107.237.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2wR7cZMAMuwd3F00lTfEwb0MvsrsJGqOpWD4xVkHs0sw2TJRBJESXD173LcMpRP77d2aZXUyG4Q77+NKKG/kMHRsL+InrmTin8u845fU5BmSyqYDdhd/6sJIFv5/jxtDwi3pf4IcdU4RvEozGS3JHaNJBDPvfz4ifx0jC+tBa0nnMw0I+Z7S4pFymMwu906JyFsvkYrGXko6MJ0raM+jdY7idqC0JqO2kuKziGdO/mTWcx/EUfftOAq1XiChj//n0pwmc6Hc/v8eDlX8ufq3MrGE5UgBpMPN4KQpuw15zN/YSRCQHqk+3DGQVxq8SPt/LwOGk3+J7aAGB96FZf/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8unb+bT/ZDjhpSY1Hn4dKep41pw/5P7CK5OO6Ud1LHw=;
 b=UG5fXobuCma49/CS50qghB3J30y0ng32hgRrIwBuPuWTmZ3tbW1K7BFltLTaO/Qagh5pU1y3l3r2RTQ04lGaZjDShjRfP7ICpBWM2dDgp+nVGv2VkIJ5RAbGv/6MOKNIY2NFY6ETj2ZSEhSZDLAdZATMWiNvGXTkjl26H9W0fxePY+iT93/4M6sCtgsWVFNLRkoHJgFPCKbpgDjv0LsG37Ww7+QJtVLeREKYAaziQLSHFFteshTHDWWDRZ0ukPcLdjM6DPk0FFJCRJcHTIoB+uzsw1SCmz8OMCEcA6G5O40hDo36xmR3EXy/mE42fRYZcT24SIMN0yCQ+kTSlyxzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8unb+bT/ZDjhpSY1Hn4dKep41pw/5P7CK5OO6Ud1LHw=;
 b=KkYQV/T1KN+lugCXe/rECexwuUZ78cj0ul/96fvMr9xRbcFiygfE8gkUnttA7iWVIbjhfA+7COZBc7kS4WYO4mPdtBHeax5Cxn86MOcBzb2n96PEidbRfY1lNKyDhADe17nT5jQltaVfYv+RrhDxWe+IJn/PyV1UunffocsLYHc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3959.namprd13.prod.outlook.com (2603:10b6:208:24f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 04:29:00 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 04:29:00 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "rick.macklem@gmail.com" <rick.macklem@gmail.com>
CC: "lionelcons1972@gmail.com" <lionelcons1972@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>,
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
Thread-Topic: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
Thread-Index:
 AQHbmBa5xy/j3c2GaUCylZ3htsCWqbN4/18AgAAOAgCAAFTsgIAAA8+AgAAWQoCAABGcAIAAA2sAgAACFgCAABRWgIAAB++AgAAu7wA=
Date: Wed, 19 Mar 2025 04:28:59 +0000
Message-ID: <a4adced9418a2ef6d3241938dcd754da31312066.camel@hammerspace.com>
References:
 <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
	 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com>
	 <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
	 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com>
	 <e674d6ec96cc8598b079efd3b93612537f840a87.camel@hammerspace.com>
	 <CAPJSo4WrOnWfLzmfoCcj1MuYQQBHo434vTK=9qx+rh_FCVck=w@mail.gmail.com>
	 <e21645871fd6249d93f9bb33b154c3663eaf0a70.camel@hammerspace.com>
	 <CAM5tNy5ZA5MKuCsFQHXE_uBkmMv3eBH7dgonaTrk9Rk-p2jA0g@mail.gmail.com>
	 <09c573463b19a1d1f4b1e50484faa657d3c3aa28.camel@hammerspace.com>
	 <75d4e5849c488bddeaa12f2a9780394dfe8d743e.camel@hammerspace.com>
	 <CAM5tNy5W_WwtYT8LpPrX_B5wHyu3yi5DMrf9Hcu3iM4911Jvgw@mail.gmail.com>
In-Reply-To:
 <CAM5tNy5W_WwtYT8LpPrX_B5wHyu3yi5DMrf9Hcu3iM4911Jvgw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB3959:EE_
x-ms-office365-filtering-correlation-id: 3a0e25c0-1eab-4b62-1472-08dd669e9227
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y0hnQmordlRrNHBiWXNpdWlBYlIzRG9VUnIxeVlGc0FyRFh4eHRsR3ZMaU5T?=
 =?utf-8?B?WWorUGtLKzUwcENwREsvVzNva05MYTNYUVZGOUFYa2JXNEV1aUhjVW8wanFV?=
 =?utf-8?B?MVBDM3lWdEo5S0ZsdnIvU2xYUGRJQjZFQ2w2UUEwRmxLR0F3bURmSkQzd2pl?=
 =?utf-8?B?ZWVJZjJlVDdWeDVpaksvTHovb2tQOEJSc0FJbHgvaG9DNzhzTzFmb1NnRzRy?=
 =?utf-8?B?UFdFb0F3TGhnYlh5cXZQcEIrYi9GaVFYNklKdmVMbFExamFMOEN4ZFlhdWk3?=
 =?utf-8?B?OXkyMzN1NGkxd2VadHIyL25mN1RLOVJ5UHZCMjV5K3VBcEt4ZVVRSjBTQVhq?=
 =?utf-8?B?WEVXYXJwUVg4RTFqMzcwWWVrbkpFd2RtdytsYndWMXREMU9maU5NRzdsbjFF?=
 =?utf-8?B?Uzc5Rzl2bWF6SjJqdW8wNlI0aHIwcytrTkJ3WURtMUN3WmhxbjZWbXV0bGJW?=
 =?utf-8?B?ZlNhQ1BQTlh4N1JJS3hYWjdNMjVBT3d5WFp0c0VLR1ZrL0Fhd3NzTGxZb1h2?=
 =?utf-8?B?QmUrV3NxZ2o4QXVFS2hwNkZCTnJkTzUwOE1tYUh0VkZ5LzhHajIxVXByd1hQ?=
 =?utf-8?B?OFdHSmpjT0lJTkR2UjBnMXRwUGZSUEpBMktUV3RVNXpNUHFhNTIvVjl4L0dr?=
 =?utf-8?B?eWJXY0F4VjZMWXM3SG1KVjNQbEZLVy80dW1ZUUZBNENKbEtrWFdmUHlIcmF4?=
 =?utf-8?B?UHNlT1M2dUloeEZVLzZoSmRiR3dYS1FMMzlLbVMwVE8wL2lzQzJKZ0xuR3M0?=
 =?utf-8?B?Y2NWNGE5dEI2enIwd0lwVzVwZ3pGbENTR1JCVW5PSGJHeGhZWFcxN0JTM0lF?=
 =?utf-8?B?cUFzckNMdDhTWGhYZnNpT2RxbEhxMEVIcEYrZTRwRTVnN2tub2hTZ1dXbzdB?=
 =?utf-8?B?MC85ZlRhZ2p0NkxTOVRnNEE0MjZrWGUzVEhkL3MxQ2FEUU8wNWFpektjUW9O?=
 =?utf-8?B?QXFIUmpRYi90Vk4rU1NZWi9qOExsN3lQSEpaR3RWak1wOFZSSEU1emJCNmt6?=
 =?utf-8?B?enNWcHA4TDR5TjYwbDRUZkxwT1BpTHcyZjBHUUZNV2dOYS9XcDdUWmRXZ2VQ?=
 =?utf-8?B?c0hLVEhwOUdpN25GNkRMY1YyNVZGVkxiOGR1ckdUdEpJNTFLNE9GTVJ5WVNW?=
 =?utf-8?B?am96cHJQSUVqdjlPdkRLQnBYbjB2VnFKL0kwOUQwampMdEFrUjFFU09nQnNI?=
 =?utf-8?B?MWorQkUvSjE1dXF6RzMwMFBSV3k3aSs3cW45ZnVBSlg4VnU4TXJkaWVubWRZ?=
 =?utf-8?B?Nkl3TC9EdGVaQ3ZtRy9yK0hoWmgxV0V1VGx6U3JkczRXdDlscmk0Nk9KelBR?=
 =?utf-8?B?d0RKN0hyMjZtNDlYYXdaMkxPWU5PblZJaW05THVrT3ovSHhPM3c2NzZYWmxo?=
 =?utf-8?B?ZTROZjI3R0hYT09USnFaR2RFZW1xMTA5WENDU3FRaHpmUklKa0JlNEVoOFdu?=
 =?utf-8?B?WWhHN0lERkU2TklyUFR5VFhuZnVPYmNPdXlEallacy9uUThDMG1JOEJ2eWll?=
 =?utf-8?B?ZVArVU1qcmlHZTNNT2hhanl6d1YzTjBaWWt5Q3krUGZKdmFXTnJFbkdlM25w?=
 =?utf-8?B?dk4wZVZYUUxBTXl2OTN6TnZ4aGJwTWdGMnRWbkZjV3dpa0Y5Ny9pM1htbDVo?=
 =?utf-8?B?KzJFOW5tNUJrdGZrelM3dmNpK0ZpNjkrcmUvYVR3ZjhWeGJ4VEtmR01MUGxm?=
 =?utf-8?B?ZS9CSEF6UkFsQi9CeTNBWi9MVnhrOEd6VTJXWkRycUNzNHpTZkZvUkZ6dWx1?=
 =?utf-8?B?NllPNDFkc1ozVGdzV3pVTDB1RTlSNHdEVDlHYVpJK2kyaTlBV1RqM1VHUmZq?=
 =?utf-8?B?aE9zVjZBSWtUTklXaWxLbHFuY1p1VXdsOGVlalBZbmFDb2ZPSWtyWXY1bzhB?=
 =?utf-8?B?TXNSSUJqV1prci9jOXZ3ZG5uUytyd0xCRkRVLzlIMC9GM2N2Zml4eXAxUE5Y?=
 =?utf-8?Q?t9LsW6w8pusWaDXE5X8yFxNdSQ7iAQvE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWpkRXdMWDJOK2FrRlQ5OFdFK1FvdnprS1hRb3hTeDZZMUJOeUlRdzNUVTZq?=
 =?utf-8?B?Q3ZaQ1RUVWluRVFhNEMxRFc0cnNMeHBxcGNIOXJBcElEWjIwQnpkblIvcnJD?=
 =?utf-8?B?MitITEZJZkptOEFkV09EaGxCTlUrRloyejE2OXhKL3FVb2dmRDluKzZtNW9W?=
 =?utf-8?B?SklxOTFYY0JKT1dYQXFvVnBnVHovVnpEa3JEeXF1c1V6cG91Vi9jQmZacFJF?=
 =?utf-8?B?MC90ZURPdXVSUnRkUjBOYXl3TXV6V2RGWHAwTFR0ZkVkWXgrTXdUVXc2VWZu?=
 =?utf-8?B?ZlZ0Skh4NFhJQytnQmovemNRcWN4QVY5Szd0WXVNbnVjeFMySnJ6S0ZaREhJ?=
 =?utf-8?B?M0lSekorSFZuREwwbjVCUHYwMlFYQ29acDBCSWZFdU9Td0ZUOVlXTmFYT0FD?=
 =?utf-8?B?VlYzUzViQkdRSTZNU1AzN3RhUHNqbU5hZndtRE9XQVlDeE4vRXNzZHZ6aDJi?=
 =?utf-8?B?T3VhQUIvcnVhR1YwOHp4MlN6TjcrUW90L1Exd1BiYU1aTTBNWUdzUzVqT0Yv?=
 =?utf-8?B?b1NWWXNyN3lkM3k5QW13MUVqV0M4ZkJZZWpISXRXV1BMV1FYbW4wVGZ2WTBF?=
 =?utf-8?B?WHhnbmxlV0xqSnV3cll6bmhJY3B4UGgzd3dISkN4WjRDVkM1MC9OU1FPN1Zv?=
 =?utf-8?B?SjV0Wjk2a2U3THg1dlV3VUYyZDBEOU9FQ2UwSDY5TkhZdWhpQ2o1ZVV4T0Qy?=
 =?utf-8?B?c0hnaXlBeTVpVSswUnFqR1htdnJxdzFMU0RHWkJRMXNlMWp3dy9seG1ISy9y?=
 =?utf-8?B?UFFRTE9rK1BTc1BJclhuOXlpbjZnQ215OUo4R1JJTFM4dFdvdFp1S0VMOTdY?=
 =?utf-8?B?OXV4YWxuT1FhNmdVS3dOd0kxN2c0ZVV4NXluTlQ2OXQwWHJ2Z3huQnluTncx?=
 =?utf-8?B?LzYrUjlQYW5YQ2FxZklJT29ZSGEzOGUwbEJiRmNnMEhlNGh2RUVLM3dPV3VL?=
 =?utf-8?B?SlZwazVaSnB0cHUwMkFKL0t4dHlxN2RNdkM2by9MZk9tM3RGL2RlVUNzNnVX?=
 =?utf-8?B?STFXSHFuYVhCNW9pelJSMm10bHRLZFdJalgveElJelFiMkZReDIwaFpXQ2ZZ?=
 =?utf-8?B?TXU1UlMvelNTQUhqUEMrTmtLMUtUU2FwNk5GUTVGTytjMXZHeldkdXZYYVpJ?=
 =?utf-8?B?TEt6TDJBUFh1ZjZTclZvSlg1U1N0QnNqK3ZGcDdOWjgyOEN3RTgwak9aaXA5?=
 =?utf-8?B?dzFLNUF1MWhhU2l6bnUvUGhCcGtvdEJyLzFGUVdPeHFqcnNTamRGeVl4VFd3?=
 =?utf-8?B?MVdtK0FrblhqWkZvZHVvQnhsNXdaU2VqYksxSUI2UkQ0Z0l2c3JEQzJQOEdS?=
 =?utf-8?B?SGRhLytibXhqelByR2tzZ3V4VFUxTm55S3RtOFhQZEhJZE03R0tDZ0l3SFBi?=
 =?utf-8?B?MTM0RjNKOUlCbkUwQjh3ZEJUS1c4WTg2UUNHKzR3dGZWWVdNV0V1RXFOL0Jv?=
 =?utf-8?B?VHNRaXFKUGNYM25sbnpKT0h2OEZXTjk0VVBVMXJ2cXVlMFEzRkF5MkFQYlU2?=
 =?utf-8?B?Z0RWRE9XdXFjNEh4YnZGYnFpUVBrOEF4UXZlRUtXdXNZb3BYWXZUSTJkbXpW?=
 =?utf-8?B?ZjYrTjR6OUw4QmZqWVZPekJNNWh3WHpFeVBnUEFKV0UyRkhjeldIZnNJQVd3?=
 =?utf-8?B?VFUwb244TWM1OTZXUFpna1YyaTFxeDB4d3V1cVF4TTIzUTR2UEo4Qno3TXAz?=
 =?utf-8?B?em1iL1BvajUyREU4MmtOcDUrMmNPKzhhckdnWVpodUhQeHhwNmY0TEJBZ09J?=
 =?utf-8?B?em8vOHR1UzMzY0hrYkR6Y2tXY1dUdUtsWnd1RTZxVlFtYjFNSzBhWDdJc1M0?=
 =?utf-8?B?VkJwQ0RhSGZLTW9KQ0F2QjBBMllwMEtXWUx5aWIza0ZqbENIekg1bVJSdkIy?=
 =?utf-8?B?a0NBU3VnMVJGZTFRa21sUjBYQm10enhHK1BUVC85TEU2TU5wWEpEeFNDQ0dk?=
 =?utf-8?B?Ukl5d0lRSkM5Q3FaNDkvSVlwbWVPUDhWK3FHVDFGNEJQakNOaE12eW1kSVZm?=
 =?utf-8?B?cU1pSXRtam9zNjBEWW9zdTByejl1b0VCemZHeElvbUxKSE1ndGdzUW5PYlBR?=
 =?utf-8?B?ajIvNXgrU0RTMFJlc2E5ZjB6QzJXOFpIV25TZ1hlR3JvMkNLSklYQVZKbFpr?=
 =?utf-8?B?Y1kwNnJQZ0hnM0VSNDAvaUFRR0h6dVFIdzlFems3ZmQ1OUhHTndmVUp3OWI2?=
 =?utf-8?B?QkZDcWEwSngwbFJ1SnBqV0Y5eDNlWlhRby8wOXBPZGc3SFRVd3NZOWlpbnd5?=
 =?utf-8?B?V0NIeWdzU3VpRHVzcWszdzZRcUpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37C0E21F48D59F4185DFC25B5C6232BF@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0e25c0-1eab-4b62-1472-08dd669e9227
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 04:28:59.9017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bnuguz/m8R7lj/+gjVLEO4tjkUHcKgDgJngD44Aj2BwbUVGDwlLzVCayNpYKGAtiVdiEx2qvrs1DbRfSggDIYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3959

T24gVHVlLCAyMDI1LTAzLTE4IGF0IDE4OjQwIC0wNzAwLCBSaWNrIE1hY2tsZW0gd3JvdGU6DQo+
IE9uIFR1ZSwgTWFyIDE4LCAyMDI1IGF0IDY6MTLigK9QTSBUcm9uZCBNeWtsZWJ1c3QNCj4gPHRy
b25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUdWUsIDIwMjUtMDMt
MTggYXQgMjM6NTkgKzAwMDAsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+IE9uIFR1ZSwg
MjAyNS0wMy0xOCBhdCAxNjo1MiAtMDcwMCwgUmljayBNYWNrbGVtIHdyb3RlOg0KPiA+ID4gPiBP
biBUdWUsIE1hciAxOCwgMjAyNSBhdCA0OjQw4oCvUE0gVHJvbmQgTXlrbGVidXN0DQo+ID4gPiA+
IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiA+IFll
cywgSSBhbHNvIHJlYWxpc2UgdGhhdCBub25lIG9mIHRoZSBhYm92ZSBvcGVyYXRpb25zDQo+ID4g
PiA+ID4gYWN0dWFsbHkNCj4gPiA+ID4gPiByZXN1bHRlZA0KPiA+ID4gPiA+IGluIGJsb2NrcyBi
ZWluZyBwaHlzaWNhbGx5IGZpbGxlZCB3aXRoIGRhdGEsIGJ1dCBhbGwgbW9kZXJuDQo+ID4gPiA+
ID4gZmxhc2gNCj4gPiA+ID4gPiBiYXNlZA0KPiA+ID4gPiA+IGRyaXZlcyB0ZW5kIHRvIGhhdmUg
YSBsb2cgc3RydWN0dXJlZCBGVEwuIFNvIHdoaWxlDQo+ID4gPiA+ID4gb3ZlcndyaXRpbmcNCj4g
PiA+ID4gPiBkYXRhDQo+ID4gPiA+ID4gaW4NCj4gPiA+ID4gPiB0aGUgSEREIGVyYSBtZWFudCB0
aGF0IHlvdSB3b3VsZCB1c3VhbGx5ICh1bmxlc3MgeW91IGhhZCBhDQo+ID4gPiA+ID4gbG9nDQo+
ID4gPiA+ID4gYmFzZWQNCj4gPiA+ID4gPiBmaWxlc3lzdGVtKSBvdmVyd3JpdGUgdGhlIHNhbWUg
cGh5c2ljYWwgc3BhY2Ugd2l0aCBkYXRhLA0KPiA+ID4gPiA+IHRvZGF5J3MNCj4gPiA+ID4gPiBk
cml2ZXMNCj4gPiA+ID4gPiBhcmUgZnJlZSB0byBzaGlmdCB0aGUgcmV3cml0dGVuIGJsb2NrIHRv
IGFueSBuZXcgcGh5c2ljYWwNCj4gPiA+ID4gPiBsb2NhdGlvbg0KPiA+ID4gPiA+IGluDQo+ID4g
PiA+ID4gb3JkZXIgdG8gZW5zdXJlIGV2ZW4gd2VhciBsZXZlbGxpbmcgb2YgdGhlIFNTRC4NCj4g
PiA+ID4gWWVhLiBUaGUgV3JfemVybyBvcGVyYXRpb24gd3JpdGVzIDBzIHRvIHRoZSBsb2dpY2Fs
IGJsb2NrLiBEb2VzDQo+ID4gPiA+IHRoYXQNCj4gPiA+ID4gZ3VhcmFudGVlIHRoZXJlIGlzIG5v
ICJvbGQgYmxvY2sgZm9yIHRoZSBsb2dpY2FsIGJsb2NrIiB0aGF0DQo+ID4gPiA+IHN0aWxsDQo+
ID4gPiA+IGhvbGRzDQo+ID4gPiA+IHRoZSBkYXRhPyAoSXQgZG9lcyBzYXkgV3JfemVybyBjYW4g
YmUgdXNlZCBmb3Igc2VjdXJlIGVyYXN1cmUsDQo+ID4gPiA+IGJ1dD8/KQ0KPiA+ID4gPiANCj4g
PiA+ID4gR29vZCBxdWVzdGlvbiBmb3Igd2hpY2ggSSBkb24ndCBoYXZlIGFueSBpZGVhIHdoYXQg
dGhlIGFuc3dlcg0KPiA+ID4gPiBpcywNCj4gPiA+ID4gcmljaw0KPiA+ID4gDQo+ID4gPiBJbiBi
b3RoIHRoZSBhYm92ZSBhcmd1bWVudHMsIHlvdSBhcmUgdGFsa2luZyBhYm91dCBzcGVjaWZpYw0K
PiA+ID4gZmlsZXN5c3RlbQ0KPiA+ID4gaW1wbGVtZW50YXRpb24gZGV0YWlscyB0aGF0IHlvdSds
bCBhbHNvIGhhdmUgdG8gYWRkcmVzcyB3aXRoIHlvdXINCj4gPiA+IG5ldw0KPiA+ID4gb3BlcmF0
aW9uLg0KPiA+IA0KPiA+IEFjdHVhbGx5LCBsZXQgbWUgY29ycmVjdCB0aGF0Li4uIEknbSBub3Qg
YXdhcmUgb2YgYW55IHJlcXVpcmVtZW50DQo+ID4gb24NCj4gPiBhbnkgb2YgdGhlIE5GU3Y0LjIg
b3BlcmF0aW9ucyBvciB0aGUgTkZTdjQuMiBleHRlbnNpb25zLCB0aGF0DQo+ID4gZXhwZWN0DQo+
ID4gdGhlIHBlcm1hbmVudCBhbmQgaXJyZXZvY2FibGUgZGVsZXRpb24gb2YgZGF0YS4NCj4gPiBJ
IGRlZmluaXRlbHkgd29uJ3Qgc2F5IHRoZXJlIGlzbid0IGEgdXNlIGNhc2UgZm9yIGl0LCBidXQg
SSBhbQ0KPiA+IHNheWluZw0KPiA+IHRoYXQgaXQgaXNuJ3QgY292ZXJlZCBieSBhbnkgTkZTIHBy
b3RvY29sIHRvZGF5Lg0KPiBBZ3JlZWQuDQo+IA0KPiBJIHRob3VnaHQgaXQgd2FzIGFuIGltcGxl
bWVudGF0aW9uIG9mIEZBTExPQ19GTF9aRVJPX1JBTkdFDQo+IHdhcyB3aGF0IHdhcyBiZWluZyBs
b29rZWQgYXQgKG9yIGlzIHRoZXJlIG5vdyBhIHNlcGFyYXRlDQo+IEZBTExPQ19GTF9XUklURV9a
RVJPUz8pLiBJIGFncmVlIHRoYXQgdGhlIE5GU1Y0LjINCj4gREVBTExPQ0FURSBmb2xsb3dlZCBi
eSBBTExPQ0FURSBzZWVtcyB0byBzYXRpc2Z5IHRoZQ0KPiByZXF1aXJlbWVudC4NCj4gVGhlcmUg
aXMgdGhlIHF1ZXN0aW9uICJXaGF0IGhhcHBlbnMgaWYgREVBTExPQ0FURQ0KPiBzdWNjZWVkcyBh
bmQgdGhlbiBBTExPQ0FURSBmYWlscz8iLg0KDQpOb3QgYW4gaXNzdWUgdGhhdCBpcyBjb3ZlcmVk
IGJ5IFdSSVRFX1NBTUUgZWl0aGVyLiBUaGUgbGF0dGVyIGlzIG5vdA0KZ3VhcmFudGVlZCB0byBi
ZSBhdG9taWMsIHNvIGl0IGlzIHBlcmZlY3RseSBwb3NzaWJsZSBmb3IgeW91IHRvIGZpbmQNCmhh
bGYgeW91ciBkYXRhIGdvbmUsIGFuZCB0aGUgcmVzdCBpbnRhY3QuDQpPZGR3aXNlLCB5b3UncmUg
YWN0dWFsbHkgYmV0dGVyIG9mZiB3aXRoIERFQUxMT0NBVEUrQUxMT0NBVEUgYmVjYXVzZQ0KeW91
IGRvIGFjdHVhbGx5IGdldCBhIHNlY29uZCBjaGFuY2UgdG8gc3VjY2Vzc2Z1bGx5IHdyaXRlIHRo
ZSBkYXRhIGV2ZW4NCmlmIHRoZSBBTExPQ0FURSBmYWlsZWQuDQpTbyBub25lIG9mIHRoZSBhYm92
ZSBvYmplY3Rpb25zIGFyZSBmdWxseSBjb3ZlcmVkIGJ5IGFueSBvZiB0aGUNCmV4aXN0aW5nIE5G
U3Y0LjIgb3BlcmF0aW9ucy4NCg0KDQpZb3VyIG1pc3Npb24sIHNob3VsZCB5b3UgYWNjZXB0LCBp
cyB0byBkZXNjcmliZSBpbiBmdWxsIHRvIHRoZSBJRVRGDQp3b3JraW5nIGdyb3VwLCB0aGUgdXNl
IGNhc2VzIGZvciBhbGwgb2YgdGhlIGFib3ZlIHJlcXVpcmVtZW50cy4NClRoaXMgZW1haWwgd2ls
bCBzZWxmLWRlc3RydWN0Li4uDQoNCj4gPiANCj4gPiBJT1c6IGlmIGRhdGEgd2lwaW5nIGlzIHdo
YXQgeW91J3JlIGFjdHVhbGx5IGxvb2tpbmcgZm9yIGhlcmUsIHRoZW4NCj4gPiBJDQo+ID4gdGhp
bmsgdGhhdCBuZWVkcyB0byBiZSBhIG5ldyBvcGVyYXRpb24sIGFuZCB3ZSdsbCBuZWVkIGEgbG90
IG9mDQo+ID4gZGlzY3Vzc2lvbiBhYm91dCBob3cgdGhlIE5GUyBwcm90b2NvbCBzaG91bGQgZGVh
bCB3aXRoIGFsbCB0aGUNCj4gPiB2YXJpb3VzDQo+ID4gd2F5cyBpbiB3aGljaCBub3QganVzdCB0
aGUgc3RvcmFnZSwgYnV0IGFsc28gdGhlIGZpbGVzeXN0ZW0gZ28NCj4gPiBhYm91dA0KPiA+IHRy
eWluZyB0byBwcmVzZXJ2ZSBkYXRhLiBXZSBjYW4gcHJvYmFibHkgbGVhdmUgdGhlIGV4aXN0ZW5j
ZSBvZg0KPiA+IGV4dGVybmFsIGJhY2t1cHMgYXMgYW4gZXhlcmNpc2UgZm9yIHRoZSB1c2VyLi4u
IPCfpJTvuI8NCj4gPiANCj4gPiAtLQ0KPiA+IFRyb25kIE15a2xlYnVzdA0KPiA+IExpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCj4gPiB0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQo+ID4gDQo+ID4gDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==

