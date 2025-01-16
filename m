Return-Path: <linux-nfs+bounces-9323-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA76A143A3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 21:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5A33A1E5E
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 20:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36C7236ED0;
	Thu, 16 Jan 2025 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Rp62MwuY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2098.outbound.protection.outlook.com [40.107.93.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8823B236A81;
	Thu, 16 Jan 2025 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737060762; cv=fail; b=XaOLkXg5GNSaJkeLsmXA4ysrMkixpTdJK62mWvt3TtE95p8jqH9LcSRc8TGJJx8Mg9mEYi8NO1mUEjnqAlC3QMivxLQIOGWqJAwpcvB80R/p2AdDzJ1cg2XDpxFEis/YYYWlGN7HwgbJxBh2W5VvWiBLsonq83W/lF4zhIN2ZHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737060762; c=relaxed/simple;
	bh=VIYnPJcHWdcylLQg+G4JXQ3Vy8tnT1vDwRFl6ZRsSqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GGxIHY9+DazrdWADnqFiPptCYc+731N9m468aboIkNWA/y8IVQoh2WQwpk/udVoB1OjcxupZ+fy/ttZsEMTD2s15AopysEiD9Jm+Fc37S49Q3KSl74jOjL3RENWWbIgpqY6bhB3J1eo6GrxOx/rOyiBpCT7InlRZDeXeK++PHuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Rp62MwuY; arc=fail smtp.client-ip=40.107.93.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdFNviLavDXekqlr6lYgz+T2u7/+c5nrWFCXVeP5eX/H6sT2Lc45UGbFl+ELwVczy06B+Z2LI3b9X7QGnjlHs6KTGdGOn38zryeNOzzhYkphCvldroFhPWPAACl8jDwMzRcv1KSirs0fFeDnuDtKNVpRG4z4+ZNsDS/JpDTlfQBR7DhZ4/sdf67NFKjeIj5dLltoWxkBzM9z1bY40lojPgGERWHCcvoAtD4KkjMCiRI+L3gEktFw2jQZdVeTeObx/Mv5tHAGjMhOaAz+LZW/Va3oCHJP4aKZOA81XgQTIJL0YtZV9Qa78SboxYekHIDf0BHYjQMoWRUf45mYd0wHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIYnPJcHWdcylLQg+G4JXQ3Vy8tnT1vDwRFl6ZRsSqQ=;
 b=nDuTbJIsEWM1Af3h+Mwm1MWzE0ckUEPO+ydVx/11ITrnHNJtUdkbvcAF00kFIYzRn1JJjA0c9lSmcSri4Q6H5e+On0IZw5DCvuBho3ngn2NWnozdLbf0O6Jf+h99Rb9IJ6EC/MF6OjPcDM4ol7G/KtwSvjf5B/J0dCDQuweQYmixdwAu2dLaM0JkfmnIny5f4XKnoX4dODd8eOPFwDS29WxGt/r234o3krVEpt22h7mXJwtCyS6ro0GZqYtz0wQnBKxel8DV9GDmeA5j1VjRpCOLi5Yy5U8umYQOWNzf5JguzxLRzC1eXno5DunPnGk6UVeoFizRqrdlz83zDtGbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIYnPJcHWdcylLQg+G4JXQ3Vy8tnT1vDwRFl6ZRsSqQ=;
 b=Rp62MwuYeKIQ9fHNIFbUA6QrQVLgt43JRmFpZA4Av4oVprtwC6aWGPpOAL90Qf0Efj7+c6tov2V0sl/znejJpwJhaXz9kO8fXB2LR61V6lZOUGPOg4K4X8Yo5ziBsAVBMob/AzhJGlqsMzOptgxh9+Lyp0lbnn3OBFrEbgiVVzU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB5085.namprd13.prod.outlook.com (2603:10b6:408:148::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 20:52:37 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 20:52:36 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "horms@kernel.org" <horms@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "yangerkun@huawei.com"
	<yangerkun@huawei.com>, "okorniev@redhat.com" <okorniev@redhat.com>,
	"anna@kernel.org" <anna@kernel.org>, "lilingfeng3@huawei.com"
	<lilingfeng3@huawei.com>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "neilb@suse.de" <neilb@suse.de>,
	"tom@talpey.com" <tom@talpey.com>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "lilingfeng@huaweicloud.com" <lilingfeng@huaweicloud.com>,
	"houtao1@huawei.com" <houtao1@huawei.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "yukuai1@huaweicloud.com"
	<yukuai1@huaweicloud.com>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH] SUNRPC: Set tk_rpc_status when RPC_TASK_SIGNALLED is
 detected
Thread-Topic: [PATCH] SUNRPC: Set tk_rpc_status when RPC_TASK_SIGNALLED is
 detected
Thread-Index: AQHbZpCbUIUTseuRhkGlry2Cvg0UVLMZSn4AgACZhIA=
Date: Thu, 16 Jan 2025 20:52:36 +0000
Message-ID: <642413c4bdbe296db722f0091ffa5190c992eb8e.camel@hammerspace.com>
References: <20250114144101.2511043-1-lilingfeng3@huawei.com>
	 <fed3cd85-0a15-ae30-b167-84881d6a5efd@huawei.com>
In-Reply-To: <fed3cd85-0a15-ae30-b167-84881d6a5efd@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB5085:EE_
x-ms-office365-filtering-correlation-id: 3c8686d9-ed69-4538-d864-08dd366fb544
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|10070799003|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjB3ZUxDOUZNZEI1YjNKN0F3aVBkbHdISnpIT3Y5QVI2K2R4TVQxMFBwUWFW?=
 =?utf-8?B?ZFhnT1lWOEc5Z3laWWVvYnNHbUU3bHM0ZFBaekg5aGpTWjBBZW1KNExGUkZP?=
 =?utf-8?B?NzZ0cVVPQXZtZ2hLS3hkcE9mbkdXSmhZZjFLNndRaVBjVktPZFYxNXpaSVZq?=
 =?utf-8?B?RERIWlpBZklSRmVna08zMFJCNGphcjhwaGo3dE0wNTNDeXBvVC9rYllDZTBs?=
 =?utf-8?B?L2VhUXBPdTJxNzdnWlBkY2lYWkd1S3E1aExwbkMyUnVUNDRxOFJJOU9TZS85?=
 =?utf-8?B?c0Q3bTc1OWhpbzVKTUZvUForVStaZGd0Q3RRbHNMeW1nVlVnK2NvY1JYSkJF?=
 =?utf-8?B?dDVHZkxGZlc2b09BbFpQOERGTUZLNzQ1b0xmdkhZenNKeHFYa2xMN1hXa2tv?=
 =?utf-8?B?VW1ESTJ1QlVaL2JGVXEyVVB0WnZsaFZkZmtNUGpCWDBNT0R6Y3dYY3FVRWcw?=
 =?utf-8?B?VWdpTHAxSTIzOUlaWU1LazhqSTZYa3FvL2NzeDFDVWtqMno3N0QvelhjQU1X?=
 =?utf-8?B?eUU3b21SbUxtM1JJTGRucG5IbnoyOFgzRTZvT3J3UmpGcnJXQ3hha1oyWWwx?=
 =?utf-8?B?RHI3Q05JdEhjU2J3NVhBbERKLzMvNlJ4WlVVdUZEUld3QXl5RWNFWVBYOEZu?=
 =?utf-8?B?djFCNWZDV1o4VGJZakp0K1k3N1pFRFdDZnVzQ1dqZ3IrV25VN3MyNTJwaFds?=
 =?utf-8?B?OUN0MW9jRW42MEpNSDJydThpRmFyUzJXZC81dGljNm9yTG85OUVER1Q1YkxW?=
 =?utf-8?B?WnJSYjF6Z3RkQzFvVzNFMzUybzBNUDVONzVVek9TVXA0WFJycGNKNEt3UklC?=
 =?utf-8?B?djl1T2krakU1RXRieHQrNmg1QktpajdrNVJEK2hjS29XK3NKYTNjOHN1L3BF?=
 =?utf-8?B?RTJrOUcrYlhTbUI1b0RMbTFWZjI3YW52NFhwaXl6ZW10YitvZ05aNkdJRy9I?=
 =?utf-8?B?dldmVjV2ajBwa0F5QTdMUWZFWXFwWk1keVVUeHNEYlVVdEREVEliUDUwZ3pu?=
 =?utf-8?B?YkpDZlFCWmsvZlVKWG53YWc4b0VHTkpkVmxyc1NYdExEVWhmYTFGUTVJWVJQ?=
 =?utf-8?B?QnhGRDMwQ0p5LzdUNHVPRXhnR3hBcHM5T1FqbWRibmdnRUtzQ0lhYll3Vm5R?=
 =?utf-8?B?U0xVSVpxcEhSUXU3L1EzM1BJVXZ4TlJENHMrUzd4dlVMdldERU1pNnFvL0c2?=
 =?utf-8?B?alJVMFl2Nk5yY2JDblZ4dmExQ1hoYUxMNmxnRXh1czVsY0ZaeEJxeXRyY2Rz?=
 =?utf-8?B?aUphRzBaM21oNmdtaXhPL3pLb0FZR2VnSHUzVGdOZW5aRmJHb1ZUcWVvOWx5?=
 =?utf-8?B?NlJjWmd4M2xqWnQ3dG1haDg1b0NGQjAwcWIwRXRiRld6alMzNmpZZDVRUzNH?=
 =?utf-8?B?bVZVQVVxYkVyK1RYN2xhcXFuc1NMS3RDOXVETGlGRTNGaDVEdTU3OEVGSmxO?=
 =?utf-8?B?WEtwdGY0SmNDQ0lxNHVrTjNTY3lNWXlVMGIvWXFxVzU0aDI2OWdYNTh0T0xG?=
 =?utf-8?B?ZmJjdXdUcWllYThNK3hRWmFrWEQwSTc3T0hkaDJTRDMxR0YxOVpPazJWRU1j?=
 =?utf-8?B?NDRxMWRROGx0aElxRWpoeXExMFA5NFF2aXZ5VVhSL0VnSnBIRllOcmpNWHNK?=
 =?utf-8?B?ZjJHWnB6NXhEaEt2QjBIUFBlTnlmVmFMcXRRVklZSnp2M2NSNnNuSnZSOWlO?=
 =?utf-8?B?cWs2VWVWSVZMT0FHd0xmTDFJZzB4WXhSQ0VSUkJRbGdJQ203ZVFZQmEycTFq?=
 =?utf-8?B?OGxSY09FZ01WWmo2N0h3ODBiRk9mTTlNM1RjSjRoVGs2aGV1MHpuR2p4eldI?=
 =?utf-8?B?MlVnYjhnS216SUI3blhWTHNFckJkcEdjUDJqRmpyN1F2NjZkV1NKaVAzQjdB?=
 =?utf-8?B?OHRXWlZmY1kraUtwNTFncktCM1RsbnRBbWdnUXZJVWE5VXA0Z0FiUXBKb294?=
 =?utf-8?Q?pqXmqVoZIe+mLAJ1xPS4Z6aQjAdm6nAt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(10070799003)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUs4dnoxZ3dJSWMyaHo5ZEE2a2JRc3ZXVUhmLzBwb3JrM3V4MHNSZzVSU092?=
 =?utf-8?B?ZWRvK0ttQTBSZFAyUDgxa3YvbEFkUkN3bWJLWEw2M2xIL2gzcG9xdVRSTmFI?=
 =?utf-8?B?SGg3ZW1vUUVOcTQxN24zY0E5ME5oSndNdXV6bnBzNDdxbDVmTWE3dk9GcEF6?=
 =?utf-8?B?N3BrNWgvWW5OVWlOVWpKTVNvUk9lclNHUk5jOUNKQm5tR2RpNUtwMU5hdGMz?=
 =?utf-8?B?Y0RaRHluak1tYlFtQm9KVC9qODlQRkI3MDVBcEN6c2RWbkdDUlhwMGdISVh5?=
 =?utf-8?B?NlVZRUtLSUV1SUZ3OVBlZkFBTTNWL2xKOHQvajNWeVJVbUJRVy8rOHdGT2Z6?=
 =?utf-8?B?ZmRNUVg2QVJqRUJVaTZVTEJ0ZVJrc0FZNXFiWm1DOVRQZlAwTkFSMVUwTFNz?=
 =?utf-8?B?bzluZ0tHTmNQRmZhSXNGT0I5M0NvMVM0YnBUSFZCMzRSOXUraEh5U3FjTFlJ?=
 =?utf-8?B?L0VCSnNyZDNTTHVReWQ5RXVqd1VZb1NpaWJkZ3VNSHpPRi9wMGVtMU54dWNn?=
 =?utf-8?B?V0xnWGhBb3M4QmpoZFN3QWlUQXhZcDBtQkc5ZitRcU81bitISkVtWGdaSWN4?=
 =?utf-8?B?SG9NQWp3bU4va3I5TGliZzRTcmtjR3ZjT29Zb1J6QndyVFlmNjA4MzhtdWNz?=
 =?utf-8?B?QmV3T3d0aEpZaUF1K0ZVaHlramIyWTIyaEtJYVB3NGs4NU1PK2Z4V0VXaWRq?=
 =?utf-8?B?cHVNS1NoQ09kRDhLU3dWZ0t3V3k0dVZqS2t4YUIzWkdDQmRSaHpTUktCUFdW?=
 =?utf-8?B?UW5WRVNwcG9CMElMSitsOVRTWDFXYlo4VnVHVTNVeUd4SHJ6NFdkYUl2UTNZ?=
 =?utf-8?B?czVuVEY2eFFlcTNwS0g1NHJPZ1VXdkQzVEtZWm43MFNyb0FJNlo0MmQ4TkdV?=
 =?utf-8?B?amg4UDQwRFlPU0VJbllDYnNGVmtkL2RYbm0wUml1RTNTbWZ0RUFvNTdvWWdJ?=
 =?utf-8?B?OGtOdkVlZ3h2OW8vQlMvNEp0QW4zUWhGMldOOVBSem95OXVIakJYVWU3aGNI?=
 =?utf-8?B?VUVRSGlpRHJlZExtNnNJT1pJek1wNWJkb2p0RjlKK2F5VDBiaWV3Y0xzWDJo?=
 =?utf-8?B?Vk1UTEg4ZDhaUHc3RzVvaThYRFNEUkZtbTh3dGtQaDRLUVlqREJrYkdCU0U5?=
 =?utf-8?B?VGJHVmJxblM4NzIzS1ZSVmR0dTczVGNxbE1uTEo3UDdUVXpZMFRyZVFoQU8r?=
 =?utf-8?B?bVZtQUJHZVUxOXdwck1jZXdIUU9aaTNMbWNPV3Q4aC9vQTVCbkg1UHZwcmt5?=
 =?utf-8?B?YU9rZS9YWmx5OU43VTV0T1VqUzhsWWllaGp2OUk3K28rVWwxSTlEUk9abEN1?=
 =?utf-8?B?WjgrYW11UW94UHlCV0Q5N3d6RjNVL254dUhuOTlKVHRSRkVGeXJ5dU1MOUtB?=
 =?utf-8?B?RWJtZzd6aS9XbnFaR0VIbGltbW9SWVFkVmJYSmdidkFSeENPNDZSaHQ0TDQ3?=
 =?utf-8?B?VUh5Q3N1eGJjOHdMQWJkWml6ckx4RmFPaElrK04xTEtUZCtoSnJRSU1EcDg5?=
 =?utf-8?B?N1pqTWFKdW9sUjh1RTdKSE1UU3pQaDAwS0xsclFONHFPc2Jtb0M3VTFyUDJO?=
 =?utf-8?B?UWxLa3p1dTNXWG5HUXhMZ05vZEZRQjdyOWpkbUVwU1cwSWZmSUx2UU9FdGVy?=
 =?utf-8?B?TDN4TFhmSnhjVExPaDZnTzROY0djWXFqaGNPclhVbWprWG84RFZzQ0RSSGpK?=
 =?utf-8?B?MWFzSkVBL2NveUU4STJxaTY4blhiMU5ZRDErRTJuMHk1Qk1oS245UG5CdFJj?=
 =?utf-8?B?cG1OYkdERjNFSlBWNE9vR2tLdFBVdEo0ek42eUlqVm1tNkxmakpDTlRucUJn?=
 =?utf-8?B?VnlwdU5rL2hVZ1FmT3l1cFUxNDlDalhtanQ1eG4rdWdGSW42TE55UWp2RkNw?=
 =?utf-8?B?Rkd4TXBSbU1GMUhFczBJL0lmQ2dvRGhweEY5OXlyYkZtSjhmZnRUcG11Yi9S?=
 =?utf-8?B?ZlovQnE1TTUyK1BCUmQwQk4vUnFremdFK0V4TGFkK01MZDJNWmdVUzgvNDNy?=
 =?utf-8?B?NTNqcUdyRXFOMDdSRDhNVHFBT0xvQWJUWlplQjI1NS9peDVOR2JtMFhydW81?=
 =?utf-8?B?eUZibjlrTHVOK2xiU1M5ZDlzYjQwcy9XaVphVTVnVzFOMW5CWkFLb2JzcGE3?=
 =?utf-8?B?VnNhUThxN3lDUzhkcHVrVVpjMkVEb1F1T3c5TC84QlVHVEVUSEZLV1JyajhW?=
 =?utf-8?B?TFVDUjJlc0VpYXNPamhCYnpLMko4TmE3aTNMYit3aUw1aEhid3Y0ODBRY2xC?=
 =?utf-8?B?dTJWdW9iQlhnWTlNQTFWcnd1MVR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE5124887F01EF45A973A7C1D734AEFD@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8686d9-ed69-4538-d864-08dd366fb544
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 20:52:36.6349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODyyrJnbWvgbdIA7CegQPvYxyZLZhkN4Bw7qC38IlCLf/1/mM/2o5C6Jd4fRFXdGTMjfIUY47X/fxojd50AOuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5085

T24gVGh1LCAyMDI1LTAxLTE2IGF0IDE5OjQzICswODAwLCB5YW5nZXJrdW4gd3JvdGU6DQo+IEhp
LA0KPiANCj4gVGhhbmtzIGZvciB0aGUgcGF0Y2guDQo+IA0KPiBCZWZvcmUgMzk0OTQxOTRmOTNi
KCJTVU5SUEM6IEZpeCByYWNlcyB3aXRoIHJwY19raWxsYWxsX3Rhc2tzKCkiLA0KPiBldmVyeQ0K
PiB0aW1lIHdlIHNldCBSUENfVEFTS19TSUdOQUxMRUQsIHdoZW4gd2UgZ28gdGhyb3VnaCBfX3Jw
Y19leGVjdXRlLA0KPiB0aGlzDQo+IHJwY190YXNrIHdpbGwgaW1tZWRpYXRlIGJyZWFrIGFuZCBl
eGlzdC4NCj4gDQo+IEhvd2V2ZXIgYWZ0ZXIgdGhhdCwgX19ycGNfZXhlY3V0ZSB3b24ndCBqdWRn
ZSBSUENfVEFTS19TSUdOTkFMRUQsIHNvDQo+IGZvcg0KPiB0aGUgY2FzZSBsaWtlIHlvdSBwb2lu
dCBvdXQgYmVsb3csIGV2ZW4gYWZ0ZXIgeW91ciBjb21taXQNCj4gcnBjX2NoZWNrX3RpbWVvdXQg
d2lsbCBoZWxwIGJyZWFrIGFuZCBleGlzdCBldmVudHVhbGx5LCBidXQgdGhpcw0KPiBycGNfdGFz
ayBoYXMgYWxyZWFkeSBkbyBzb21lIHdvcmsuIEkgcHJlZmVyIHJlaW50cm9kdWNlIGp1ZGdpbmcN
Cj4gUlBDX1RBU0tfU0lHTk5BTEVEIGluIF9fcnBjX2V4ZWN1dGUgdG8gaGVscCBleGlzdCBpbW1l
ZGlhdGx5Lg0KPiANCg0KQmV0dGVyIHlldC4uLiBMZXQncyBnZXQgcmlkIG9mIHRoZSBSUENfVEFT
S19TSUdOQUxMRUQgZmxhZyBhbHRvZ2V0aGVyDQphbmQganVzdCByZXBsYWNlDQoNCiNkZWZpbmUg
UlBDX1RBU0tfU0lHTkFMTEVEKHRhc2spIChSRUFEX09OQ0UodGFzay0+dGtfcnBjX3N0YXR1cykg
PT0gLUVSRVNUQVJUU1lTKQ0KDQpUaGVyZSBpcyBubyBnb29kIHJlYXNvbiB0byB0cnkgdG8gbWFp
bnRhaW4gdHdvIGNvbXBsZXRlbHkgc2VwYXJhdGUNCnNvdXJjZXMgb2YgdHJ1dGggdG8gZGVzY3Jp
YmUgdGhlIHNhbWUgdGFzayBzdGF0ZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20NCg0KDQo=

