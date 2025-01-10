Return-Path: <linux-nfs+bounces-9102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3DCA094A6
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 16:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA02D164E7A
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC19211488;
	Fri, 10 Jan 2025 15:05:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2090.outbound.protection.outlook.com [40.107.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D420DD79
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736521557; cv=fail; b=RWgKfKcf18+XuUQlcBz0ngvpILENtCkjIdF8KFH84QDHUDbC0nQfGXomR8ebDhMkEGR4pNGY3+JA8kFDURUNJmgiBOfYZ89fXWu0FN57a6ngVwDSJug2GCX+P5/cyJ0DElNgfU8Pw0H+7CAlKVLVmmHSHOSizDa6nbmmLqSclPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736521557; c=relaxed/simple;
	bh=M/0k0kcYKNUOgxu5CKQODxG0sGWNyzw+/StU7aw2mhc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FTYkbwHDfhBITdIf6bVEvqj+0wFOU/9vQNA+aKhyIseUsKIj3qSNcOFcCVaL1SiEMlgBMbfGZV+F4YqGQBjV06EQJcP+OxINq5Xi15RdnphIC22ERJJ47EFPEI1j37x0DNP47gXSZ7dEhd+t913FWCqHYmTgsuWZC0ytmMMqJDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.92.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARN0yLiyGsjtWgdE3TXnJKzep31oQ1ldRd407MXy/cbnKvKJmE0/PvGAKCMuJdupmGD/dewlWDwUp5n4JlQLESp4PfXJhEsco0OX4p0/5+Y5SvnZSeazqE2by47eG/UnZAM/1rGgzkStRorti/9JS+Z3d7ogtKgu8X/+a16rIv9mhTMwsfvpmFJvj0QnzgW3D2WPS0u7nN3C7u5Sp2Xr6qsRqcg9/bHqBNPHQ49upeUi62sytGsjk1L9HC6SxpswhzthSMdeszeBvCanOub53MMbZfrX540X6AcgwoQ1k5Za93Hg/4bPURmkGT7S3AZyAw9l14BV7UhRukBYoZ61rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GFbIZA4yPXule3redSN5Wv7fU9BpcN6mPhuf/KgJW4=;
 b=QMfSvWSvKsTQFEcBqxstwAKmRA59+iVPJUEV8711ukURkvXh2xNKWuqF5yKmzuzE4F+vAnvH0lGbBCpjk42ELazPOZPHxtNFYb/LgfXnTCE+johuJmPpugYou+709Qu26jwmqYb1iqggIzZS7d2zsg0UKSFAxSzgzHxuAoNaIotmKCsatZFDPIVz0OK9yL5Lss5mEFPJ91W0HhO29+4NcCCx3AIyy2tsmo9PBQWoWYz7rFksxZqUZeXpmOgBz4yxRbcDtIesbok5y/mmlb7q055kPCNiYb3+ZC2oOiRi+ayGbb7ZJnLSlw2wveMQWkMBaSGzprxziSMCKGaIPR1pvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 CH3PR01MB8630.prod.exchangelabs.com (2603:10b6:610:17e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.12; Fri, 10 Jan 2025 15:05:50 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%5]) with mapi id 15.20.8335.003; Fri, 10 Jan 2025
 15:05:50 +0000
Message-ID: <6c6bdf9b-858b-4a10-9317-f55aeda1ab80@talpey.com>
Date: Fri, 10 Jan 2025 10:05:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nfsdctl: add necessary bits to configure lockd
To: Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>,
 linux-nfs@vger.kernel.org
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
 <20250110-lockd-nl-v2-3-e3abe78cc7fb@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <20250110-lockd-nl-v2-3-e3abe78cc7fb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:208:32d::28) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|CH3PR01MB8630:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7cfb93-44ea-419c-d9a6-08dd31884545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WU9IL1lMazdyZlplQjQ5czUwdEFkM3VvcW1JTkFsYTJ1dk5YWjlaNTJxUXJI?=
 =?utf-8?B?dUMvYmljWW9EVk9jRnc0UTc0bDdWZXh6dldjcjdObU9oNVVNRUxzTlpmYUg2?=
 =?utf-8?B?c3NORHZqYS9iWnk2SElTSHByOWZhQmtPQjc5UG9hM29haHJXOCtDNXNCR0NW?=
 =?utf-8?B?TDFpcEVXdlRmWjd5MGFacC9wS2w2dVEyYStGTkVlMUVHbW1RNEdUUmhtUERa?=
 =?utf-8?B?Rnp5NDRMR29veGhFaDBHWlAzUEpLLzh1bCtYajdxRC85UXBvZU9rdkhvMzdt?=
 =?utf-8?B?a3k0SnowYjZQa1dCbG0zYlo5QTA2T2JndHFUb051WmwvTXoreHEzeW4yenpO?=
 =?utf-8?B?cFlGa09rSUlPSlVlM3lvL1FzMnlVbmNoc2ZhWUJCR21hVlN3bVJtV2Evc09p?=
 =?utf-8?B?SElxOUcreVZQYTdQbHY1R0REaC9MR3hJb1lMT1ZXcnB4V2x6K2JvSzRaRnEr?=
 =?utf-8?B?Y1FxRlZxNGxQUEMrZVVPcFZTUWF2Kzk3VUFlcitLb05rbFRDeVYyOFRPc1Bz?=
 =?utf-8?B?RVdNd1VUejFWdG4yQy9saVRMZE5qVzZtaWpLZFQ5RnB4WGoxYU90REZnTU1y?=
 =?utf-8?B?NEJzVzNRM1NaM0VlUFVKUFNCQW1pNGtGNzhUSUJzK1UybkdRbFUrSFR4R05B?=
 =?utf-8?B?aldxYk9sZjh0T3Zad2N1UlFQbnZxODdDUlBKeTlYZHNzZnFDYXliQnJLMm5q?=
 =?utf-8?B?UjdnczJqZmFyNWhJVjQ1TWEzSUNvNWZQdVZsMGVhc3pLL2FpdVNvZFJWQ2pF?=
 =?utf-8?B?aGZRR2hZWS96Y3ZpUVA4aDZici90SXFQbTU0Q3VMbmpCNlBiWGFlL1RDYU84?=
 =?utf-8?B?TzNVdzFKNS8xaGcxd2RCTjQ5Szl4ZnBFclZsZ2NDWFFmMlgxL28wNmxSbmdV?=
 =?utf-8?B?Y1R3dFIvVTJTczI4dFp5UzNzeVltQ2hjajIvV096TDZFNFgrRzk0NDBQcTBh?=
 =?utf-8?B?QUtUeXRDSkVYRmRDeHkrTG9VNjdYVFhXcnVJbnoxM0FjWmJUZXRZL0FVdEFt?=
 =?utf-8?B?dVB1bkZzaU1kckFIclF3Y3R3emhRcGsxVm9TeW1Jb1hDUGFkaUlDRWVza252?=
 =?utf-8?B?YVJVS1dmSUxZYXhOWjkxM1JiTUkyc0twcUdON2pTRUlVVzlNNU8rc1JGM3FJ?=
 =?utf-8?B?N0I1Y0JBU1lYcGg4R0hyNkdZc0UvSjlQUkdzRzdGY01iYTMxTVZnc01rb2V1?=
 =?utf-8?B?WFQyaFY3YXNiMHpVSWRoaThLSEhNYnlwRVArSlIxRkhTU3JVMitleUFGNnNl?=
 =?utf-8?B?aXRZd1ZzNmQrakUrM1daZkU2L0ppKzhDL0t6U3BQVlBoL3dGemxQL25rQVU1?=
 =?utf-8?B?c1hyekdLcENFRUcya1c2ckV5bmZmL1hUK3pPSFZ4UTBVekRlZTk0Q2ZEQVpV?=
 =?utf-8?B?Y2VhZUliSVBWcmRnS2FXODBiM1dHckhiZGl1a1RFeG5IY0JWZHV2WmsxUGJ5?=
 =?utf-8?B?WFg5dlM2QVlKRkFIaW41Rjd2SVQyQ0tVMmFZUlVMY0tvV2hUejhKaDVyUTdp?=
 =?utf-8?B?RmRabHc0TU9oODZ1RFFwZmd5cExjdnJUQ1Rrd0p5dXBhRW1lbTFuNmlHazJJ?=
 =?utf-8?B?Qk9Gc0lYcjNRU1E4OWQyUEhoS2Rna242bjNtTjRoNTgyZHZMQmJBOE96MmVl?=
 =?utf-8?B?b20xbUJBUXU1bXpZYkxDVmFyREFYVUxlaUVXeHk2a1BaNTlvWC8vWWtzRWUx?=
 =?utf-8?B?WXFTMmhabDZCeUlzMDRPUlRWWjlnL25HWkpwRnRmN2tmd1VRaWxBZ3pqNVJC?=
 =?utf-8?B?QWhyQWFVWHUvaTc0OXRpYldHdEhQMlNQeUg4eTJ6aWhFRHE2Y3pQOGZIV3FK?=
 =?utf-8?B?S25GTTVzaE9wN2ptVWRjZjdBbEUrRlZDQkd3b0VNbXp3eVpnc3JUbzliWmtK?=
 =?utf-8?Q?+ITtLg6TDW+fT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aklTcDlheitQZFRCVzlGUjA5N2o5T2l1ZFJwWnRHd1g4RnMyUmlZbzFGOTRC?=
 =?utf-8?B?WkdmcG5uTnZXcFBzZjlFVzBwQWh1emdxYUUxVkJiUzB4TjgrSjJwNUgvV2VL?=
 =?utf-8?B?MjNRSEFDNGNmaGxUeEJIazJYYTU3ZTlIYUtNVTVsTGFENkNjRnVhVlNlbWE5?=
 =?utf-8?B?dXZvalN3bTFBbWVsZ2xnQTBRMmhtU1habFZjVm83OWNyMDNIQkI5ejNrdDhC?=
 =?utf-8?B?ZksyQm80Q2RXL0VTVTcwSlVxMnBQVDl5SVkwUlo5Vld3ZWVqbThyU3dmbXA4?=
 =?utf-8?B?Qy84Tnh6MkVLYzgrV2t5UGp5K0lDVUluc0Mvdmd6RXdrS3lyd0ZCNTN2NnVU?=
 =?utf-8?B?SktTYnYyN0xQOVpYVnlOb3BwYW1lQUpXOXgvOVpqME9wZ3dPektsamszWEFi?=
 =?utf-8?B?Z2VxVzhLTXNGTGVTcEl0ZCtlNnJoUnplRWh3ZmdsYUNmNDFMS2JCWURuK2pL?=
 =?utf-8?B?VS9qMEsvelplTFpFODNaSG14cnFPMzZPS0MwcHFqY2dra2kvK3BuWUJRaWJY?=
 =?utf-8?B?cDhUMzMzSFpqdHo1eUdJVlV5bUpJaFE5RE8rOU1RTzkyYTZ1azAyQjluUHow?=
 =?utf-8?B?SkRVZFQvbkpjUk8wN25PMk5udm9mSUNxN0ZGMmcwa0ZoaElUNHN6TXBYdVl0?=
 =?utf-8?B?TGQ3NksyWFRxS0FZamVHaEVzUFg0QkpieHowQ05TKzJ4Tmg0RS94VVRwOENP?=
 =?utf-8?B?M1VmYXRZWWVKYS9kcEpnWmtPK1c5LzdMVkw1RzhUbWJMVXN0aWVITWxNTlpW?=
 =?utf-8?B?VE5neU9PRTExOVZaWkpwRHRLeU5FdjRKTFR1MWtVeDJGeVdwZ0N6STYwZUtl?=
 =?utf-8?B?bGpYNlBZcWh3Qk9vS3R4T1VEbFE2RHNPSzh6dlh0ZHFXV0JMSnJHNnpqeUVC?=
 =?utf-8?B?bGtiN1Q1WkY5N1VBN0JIaXpwd1pEV1llTWo2SGRZWVMvZUhKNzEvZUhSUmsv?=
 =?utf-8?B?L284K0hFYnFWbEo2ZVNxZS9OTFhxWGhXTXd2aUdWcnFscWlkOStWU0g2cW1X?=
 =?utf-8?B?SEdxYVk0c2hwbk42dDg4TWhyZGxYMmZSU0kvWVIyRVBIczNtcDVlZzQyVVcy?=
 =?utf-8?B?WC9EcE9sMEFtaW1WZFY3WmtIL2NvdGRhMkk5WElKcGlHWTQvUG5heTlXWXhZ?=
 =?utf-8?B?NVorRFNUMlZoTnhDMFhselAyaUNST0R5NXl5NkRnOURZWHdrcXNLMFJZd3Zp?=
 =?utf-8?B?aWJuMm92U0RBVTlKSDdQRURkMnZzYzdxbFlwRmlLL2ovdE55T3hpWWo5SURB?=
 =?utf-8?B?YVhNWUNIc0lYN2lkVjM4NncwYVNEb1Y1UlRvM2syQWJlWmNKNG9vU09Vajg0?=
 =?utf-8?B?WEdOODhMOUJkL0IzNk9LbVhtSWIvcTVreVF0UnQ0Ky90bEtTc1g5blAzaTdv?=
 =?utf-8?B?VEtiZHRxZ2dqNUtQZXAwcGR3eFJDK0F2NVM3anB6Tmk2dG0rcmVRcTV0cTlH?=
 =?utf-8?B?bzMrVWNyZjk5WHJMNFc2WldvTGtFY3N4Unp1UnZzTEgwQWNVbFR0Nm40dllp?=
 =?utf-8?B?YXdHMGdtVTl0NTQ1aDd1ZU1jQXNJQXUvSVEwV3EyZUc0akF1N2xsVml4THRn?=
 =?utf-8?B?TmxEeWZLcTFZdERLZStGRGhyOFBITDNraENGdDlJRWJEdklIVWNId1RwYm42?=
 =?utf-8?B?UEczMHhaMmJCTWF2WHhXaWZxWDJCcS9MS2czNlFpeVorb3IwMmYreWFhUU90?=
 =?utf-8?B?UkxIWm9PRXc0NnFaN2RBb1BnUzBIa0RrbUJXMmtRNVJmaGZ3RHNqZFZmbFho?=
 =?utf-8?B?SjBWRUN1SmF0eGszRW4rNElWN0tWQzFBTWVrbDZLYVM2RjhpUkpQeEtBN0FK?=
 =?utf-8?B?dWVyNm1xbm56aFF5VTBUay9oQ2VpclhVVk9vcVlhZExzVXcxSjJ5ajRWNzJ1?=
 =?utf-8?B?bm0yb0NrSll3NWtGeTFmTURuVS9wNUNUUUVsN1lKcUpvb3h3Z2hPT0h6eHpB?=
 =?utf-8?B?WnFqSDlRL0FzbjUwWlhBTHB2SWhRclRsUDZiQXJmSnp2cjJjY2JTMUp3UEo4?=
 =?utf-8?B?emliMVI5UTVIbHJIL2hiVDdlcFdDOEVmeVByT3dQZ005YmFRQzV2bzhCa3E2?=
 =?utf-8?B?Yi9TdWo2TWlCeVBBS24rdGk4bDRLMTREMkVKL1ZZQjdUeUNReklUS3VseVJH?=
 =?utf-8?Q?2sKU=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7cfb93-44ea-419c-d9a6-08dd31884545
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 15:05:50.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3L1pWsmgkMLiD16RagWJnyuoFf5eARu2NhvOEMZr/XzW+kykiIU/4aBT/KVY+NW2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8630

On 1/10/2025 8:46 AM, Jeff Layton wrote:
> The legacy rpc.nfsd program would configure the nlm_grace_period to
> match the NFSv4 grace period when starting the server. This adds similar
> functionality to the autostart subcommand using the new lockd netlink
> configuration interfaces. In addition, if lockd's udp or tcp listener
> ports are specified, also configure them before starting the server.
> 
> A "nlm" subcommand is also added that will display the current lockd
> config settings in the current net ns. In the future, we could add the
> ability to set these values using the "nlm" subcommand, but for now I
> didn't see a real use-case for that, so I left it out.

It seems unnatural that the nlm_grace_period is tied to the netns.

It seems to me it's more dependent on the network and its likely
failure modes, the backend storage/filesystem, and perhaps the
scale of clients performing possibly-conflicting locks. Oh, and
also perhaps the minor version, since 4.1+ have the RECLAIM_COMPLETE
termination event.

Food for thought, perhaps.

Tom.


> 
> Link: https://issues.redhat.com/browse/RHEL-71698
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   configure.ac                  |   4 +
>   utils/nfsdctl/lockd_netlink.h |  29 ++++++
>   utils/nfsdctl/nfsdctl.8       |   6 ++
>   utils/nfsdctl/nfsdctl.adoc    |   5 +
>   utils/nfsdctl/nfsdctl.c       | 218 +++++++++++++++++++++++++++++++++++++++---
>   5 files changed, 249 insertions(+), 13 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 561e894dc46f48997df4ba6dc3e7691876589fdb..1d865fbc1c7f79e3ac6152bc59995e99fe10a38e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -268,6 +268,10 @@ AC_ARG_ENABLE(nfsdctl,
>   				                   [[int foo = NFSD_CMD_POOL_MODE_GET;]])],
>   				   [AC_DEFINE([USE_SYSTEM_NFSD_NETLINK_H], 1,
>   					      ["Use system's linux/nfsd_netlink.h"])])
> +		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/lockd_netlink.h>]],
> +				                   [[int foo = LOCKD_CMD_SERVER_GET;]])],
> +				   [AC_DEFINE([USE_SYSTEM_LOCKD_NETLINK_H], 1,
> +					      ["Use system's linux/lockd_netlink.h"])])
>   	fi
>   
>   AC_ARG_ENABLE(nfsv4server,
> diff --git a/utils/nfsdctl/lockd_netlink.h b/utils/nfsdctl/lockd_netlink.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..21c65aec3bc6d1839961937081e6d16540332179
> --- /dev/null
> +++ b/utils/nfsdctl/lockd_netlink.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/lockd.yaml */
> +/* YNL-GEN uapi header */
> +
> +#ifndef _UAPI_LINUX_LOCKD_NETLINK_H
> +#define _UAPI_LINUX_LOCKD_NETLINK_H
> +
> +#define LOCKD_FAMILY_NAME	"lockd"
> +#define LOCKD_FAMILY_VERSION	1
> +
> +enum {
> +	LOCKD_A_SERVER_GRACETIME = 1,
> +	LOCKD_A_SERVER_TCP_PORT,
> +	LOCKD_A_SERVER_UDP_PORT,
> +
> +	__LOCKD_A_SERVER_MAX,
> +	LOCKD_A_SERVER_MAX = (__LOCKD_A_SERVER_MAX - 1)
> +};
> +
> +enum {
> +	LOCKD_CMD_SERVER_SET = 1,
> +	LOCKD_CMD_SERVER_GET,
> +
> +	__LOCKD_CMD_MAX,
> +	LOCKD_CMD_MAX = (__LOCKD_CMD_MAX - 1)
> +};
> +
> +#endif /* _UAPI_LINUX_LOCKD_NETLINK_H */
> diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
> index 39ae1855ae50e94da113981d5e8cf8ac14440c3a..d69922448eb17fb155f05dc4ddc9aefffbf966e4 100644
> --- a/utils/nfsdctl/nfsdctl.8
> +++ b/utils/nfsdctl/nfsdctl.8
> @@ -127,6 +127,12 @@ colon separated form, and must be enclosed in square brackets.
>   .if n .RE
>   .RE
>   .sp
> +\fBnlm\fP
> +.RS 4
> +Get information about NLM (lockd) settings in the current net namespace. This
> +subcommand takes no arguments.
> +.RE
> +.sp
>   \fBstatus\fP
>   .RS 4
>   Get information about RPCs currently executing in the server. This subcommand
> diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
> index 2114693042594297b7c5d8600ca16813a0f2356c..0207eff6118d2dcc5a794d2013c039d9beb11ddc 100644
> --- a/utils/nfsdctl/nfsdctl.adoc
> +++ b/utils/nfsdctl/nfsdctl.adoc
> @@ -67,6 +67,11 @@ Each subcommand can also accept its own set of options and arguments. The
>     addresses must be in dotted-quad form. IPv6 addresses should be in standard
>     colon separated form, and must be enclosed in square brackets.
>   
> +*nlm*::
> +
> +  Get information about NLM (lockd) settings in the current net namespace. This
> +  subcommand takes no arguments.
> +
>   *status*::
>   
>     Get information about RPCs currently executing in the server. This subcommand
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index 5c319a74273fd2bbe84003c1261043c4b2f1ff29..003daba5f30a403eb4168f6103e5a496d96968a4 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -35,6 +35,12 @@
>   #include "nfsd_netlink.h"
>   #endif
>   
> +#ifdef USE_SYSTEM_LOCKD_NETLINK_H
> +#include <linux/lockd_netlink.h>
> +#else
> +#include "lockd_netlink.h"
> +#endif
> +
>   #include "nfsdctl.h"
>   #include "conffile.h"
>   #include "xlog.h"
> @@ -348,6 +354,28 @@ static void parse_pool_mode_get(struct genlmsghdr *gnlh)
>   	}
>   }
>   
> +static void parse_lockd_get(struct genlmsghdr *gnlh)
> +{
> +	struct nlattr *attr;
> +	int rem;
> +
> +	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
> +			  genlmsg_attrlen(gnlh, 0), rem) {
> +		switch (nla_type(attr)) {
> +		case LOCKD_A_SERVER_GRACETIME:
> +			printf("gracetime: %u\n", nla_get_u32(attr));
> +			break;
> +		case LOCKD_A_SERVER_TCP_PORT:
> +			printf("tcp_port: %hu\n", nla_get_u16(attr));
> +			break;
> +		case LOCKD_A_SERVER_UDP_PORT:
> +			printf("udp_port: %hu\n", nla_get_u16(attr));
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
>   static int recv_handler(struct nl_msg *msg, void *arg)
>   {
>   	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
> @@ -368,6 +396,9 @@ static int recv_handler(struct nl_msg *msg, void *arg)
>   	case NFSD_CMD_POOL_MODE_GET:
>   		parse_pool_mode_get(gnlh);
>   		break;
> +	case LOCKD_CMD_SERVER_GET:
> +		parse_lockd_get(gnlh);
> +		break;
>   	default:
>   		break;
>   	}
> @@ -398,12 +429,12 @@ static struct nl_sock *netlink_sock_alloc(void)
>   	return sock;
>   }
>   
> -static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock)
> +static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family)
>   {
>   	struct nl_msg *msg;
>   	int id;
>   
> -	id = genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
> +	id = genl_ctrl_resolve(sock, family);
>   	if (id < 0) {
>   		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
>   		return NULL;
> @@ -447,7 +478,7 @@ static int status_func(struct nl_sock *sock, int argc, char ** argv)
>   		}
>   	}
>   
> -	msg = netlink_msg_alloc(sock);
> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>   	if (!msg)
>   		return 1;
>   
> @@ -495,7 +526,7 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
>   	struct nl_cb *cb;
>   	int ret;
>   
> -	msg = netlink_msg_alloc(sock);
> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>   	if (!msg)
>   		return 1;
>   
> @@ -607,7 +638,7 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
>   	struct nl_cb *cb;
>   	int ret;
>   
> -	msg = netlink_msg_alloc(sock);
> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>   	if (!msg)
>   		return 1;
>   
> @@ -672,7 +703,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
>   	struct nl_cb *cb;
>   	int i, ret;
>   
> -	msg = netlink_msg_alloc(sock);
> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>   	if (!msg)
>   		return 1;
>   
> @@ -825,7 +856,7 @@ static int fetch_current_listeners(struct nl_sock *sock)
>   	struct nl_cb *cb;
>   	int ret;
>   
> -	msg = netlink_msg_alloc(sock);
> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>   	if (!msg)
>   		return 1;
>   
> @@ -1054,7 +1085,7 @@ static int set_listeners(struct nl_sock *sock)
>   	struct nl_cb *cb;
>   	int i, ret;
>   
> -	msg = netlink_msg_alloc(sock);
> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>   	if (!msg)
>   		return 1;
>   
> @@ -1170,7 +1201,7 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
>   	struct nl_cb *cb;
>   	int ret;
>   
> -	msg = netlink_msg_alloc(sock);
> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>   	if (!msg)
>   		return 1;
>   
> @@ -1249,6 +1280,131 @@ static int pool_mode_func(struct nl_sock *sock, int argc, char **argv)
>   	return pool_mode_doit(sock, cmd, pool_mode);
>   }
>   
> +static int lockd_config_doit(struct nl_sock *sock, int cmd, int grace, int tcpport, int udpport)
> +{
> +	struct genlmsghdr *ghdr;
> +	struct nlmsghdr *nlh;
> +	struct nl_msg *msg;
> +	struct nl_cb *cb;
> +	int ret;
> +
> +	if (cmd == LOCKD_CMD_SERVER_SET) {
> +		/* Do nothing if there is nothing to set */
> +		if (!grace && !tcpport && !udpport)
> +			return 0;
> +	}
> +
> +	msg = netlink_msg_alloc(sock, LOCKD_FAMILY_NAME);
> +	if (!msg)
> +		return 1;
> +
> +	nlh = nlmsg_hdr(msg);
> +	if (cmd == LOCKD_CMD_SERVER_SET) {
> +		if (grace)
> +			nla_put_u32(msg, LOCKD_A_SERVER_GRACETIME, grace);
> +		if (tcpport)
> +			nla_put_u16(msg, LOCKD_A_SERVER_TCP_PORT, tcpport);
> +		if (udpport)
> +			nla_put_u16(msg, LOCKD_A_SERVER_UDP_PORT, udpport);
> +	}
> +
> +	ghdr = nlmsg_data(nlh);
> +	ghdr->cmd = cmd;
> +
> +	cb = nl_cb_alloc(NL_CB_CUSTOM);
> +	if (!cb) {
> +		xlog(L_ERROR, "failed to allocate netlink callbacks\n");
> +		ret = 1;
> +		goto out;
> +	}
> +
> +	ret = nl_send_auto(sock, msg);
> +	if (ret < 0) {
> +		xlog(L_ERROR, "send failed (%d)!\n", ret);
> +		goto out_cb;
> +	}
> +
> +	ret = 1;
> +	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
> +	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
> +	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
> +	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, recv_handler, NULL);
> +
> +	while (ret > 0)
> +		nl_recvmsgs(sock, cb);
> +	if (ret < 0) {
> +		xlog(L_ERROR, "Error: %s\n", strerror(-ret));
> +		ret = 1;
> +	}
> +out_cb:
> +	nl_cb_put(cb);
> +out:
> +	nlmsg_free(msg);
> +	return ret;
> +}
> +
> +static int get_service(const char *svc)
> +{
> +	struct addrinfo *res, hints = { .ai_flags = AI_PASSIVE };
> +	int ret, port;
> +
> +	if (!svc)
> +		return 0;
> +
> +	ret = getaddrinfo(NULL, svc, &hints, &res);
> +	if (ret) {
> +		xlog(L_ERROR, "getaddrinfo of \"%s\" failed: %s\n",
> +			svc, gai_strerror(ret));
> +		return -1;
> +	}
> +
> +	switch (res->ai_family) {
> +	case AF_INET:
> +		{
> +			struct sockaddr_in *sin = (struct sockaddr_in *)res->ai_addr;
> +
> +			port = ntohs(sin->sin_port);
> +		}
> +		break;
> +	case AF_INET6:
> +		{
> +			struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)res->ai_addr;
> +
> +			port = ntohs(sin6->sin6_port);
> +		}
> +		break;
> +	default:
> +		xlog(L_ERROR, "Bad address family: %d\n", res->ai_family);
> +		port = -1;
> +	}
> +	freeaddrinfo(res);
> +	return port;
> +}
> +
> +static int lockd_configure(struct nl_sock *sock, int grace)
> +{
> +	char *tcp_svc, *udp_svc;
> +	int tcpport = 0, udpport = 0;
> +	int ret;
> +
> +	tcp_svc = conf_get_str("lockd", "port");
> +	if (tcp_svc) {
> +		tcpport = get_service(tcp_svc);
> +		if (tcpport < 0)
> +			return 1;
> +	}
> +
> +	udp_svc = conf_get_str("lockd", "udp-port");
> +	if (udp_svc) {
> +		udpport = get_service(udp_svc);
> +		if (udpport < 0)
> +			return 1;
> +	}
> +
> +	return lockd_config_doit(sock, LOCKD_CMD_SERVER_SET, grace, tcpport, udpport);
> +}
> +
> +
>   #define MAX_LISTENER_LEN (64 * 2 + 16)
>   
>   static void
> @@ -1355,6 +1511,13 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>   
>   	read_nfsd_conf();
>   
> +	grace = conf_get_num("nfsd", "grace-time", 0);
> +	ret = lockd_configure(sock, grace);
> +	if (ret) {
> +		xlog(L_ERROR, "lockd configuration failure");
> +		return ret;
> +	}
> +
>   	pool_mode = conf_get_str("nfsd", "pool-mode");
>   	if (pool_mode) {
>   		ret = pool_mode_doit(sock, NFSD_CMD_POOL_MODE_SET, pool_mode);
> @@ -1370,15 +1533,12 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>   	if (ret)
>   		return ret;
>   
> +	xlog(D_GENERAL, "configuring listeners");
>   	configure_listeners();
>   	ret = set_listeners(sock);
>   	if (ret)
>   		return ret;
>   
> -	grace = conf_get_num("nfsd", "grace-time", 0);
> -	lease = conf_get_num("nfsd", "lease-time", 0);
> -	scope = conf_get_str("nfsd", "scope");
> -
>   	thread_str = conf_get_list("nfsd", "threads");
>   	pools = thread_str ? thread_str->cnt : 1;
>   
> @@ -1402,6 +1562,9 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>   		threads[0] = DEFAULT_AUTOSTART_THREADS;
>   	}
>   
> +	lease = conf_get_num("nfsd", "lease-time", 0);
> +	scope = conf_get_str("nfsd", "scope");
> +
>   	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
>   			   threads, scope);
>   out:
> @@ -1409,6 +1572,30 @@ out:
>   	return ret;
>   }
>   
> +static void nlm_usage(void)
> +{
> +	printf("Usage: %s nlm\n", taskname);
> +	printf("    Get the current settings for the NLM (lockd) server.\n");
> +}
> +
> +static int nlm_func(struct nl_sock *sock, int argc, char ** argv)
> +{
> +	int *threads, grace, lease, idx, ret, opt, pools;
> +	struct conf_list *thread_str;
> +	struct conf_list_node *n;
> +	char *scope, *pool_mode;
> +
> +	optind = 1;
> +	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
> +		switch (opt) {
> +		case 'h':
> +			nlm_usage();
> +			return 0;
> +		}
> +	}
> +	return lockd_config_doit(sock, LOCKD_CMD_SERVER_GET, 0, 0, 0);
> +}
> +
>   enum nfsdctl_commands {
>   	NFSDCTL_STATUS,
>   	NFSDCTL_THREADS,
> @@ -1416,6 +1603,7 @@ enum nfsdctl_commands {
>   	NFSDCTL_LISTENER,
>   	NFSDCTL_AUTOSTART,
>   	NFSDCTL_POOL_MODE,
> +	NFSDCTL_NLM,
>   };
>   
>   static int parse_command(char *str)
> @@ -1432,6 +1620,8 @@ static int parse_command(char *str)
>   		return NFSDCTL_AUTOSTART;
>   	if (!strcmp(str, "pool-mode"))
>   		return NFSDCTL_POOL_MODE;
> +	if (!strcmp(str, "nlm"))
> +		return NFSDCTL_NLM;
>   	return -1;
>   }
>   
> @@ -1444,6 +1634,7 @@ static nfsdctl_func func[] = {
>   	[NFSDCTL_LISTENER] = listener_func,
>   	[NFSDCTL_AUTOSTART] = autostart_func,
>   	[NFSDCTL_POOL_MODE] = pool_mode_func,
> +	[NFSDCTL_NLM] = nlm_func,
>   };
>   
>   static void usage(void)
> @@ -1460,6 +1651,7 @@ static void usage(void)
>   	printf("    listener             get/set listener info\n");
>   	printf("    version              get/set supported NFS versions\n");
>   	printf("    threads              get/set nfsd thread settings\n");
> +	printf("    nlm                  get current nlm settings\n");
>   	printf("    status               get current RPC processing info\n");
>   	printf("    autostart            start server with settings from /etc/nfs.conf\n");
>   }
> 


