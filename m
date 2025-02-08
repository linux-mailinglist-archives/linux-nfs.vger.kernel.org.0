Return-Path: <linux-nfs+bounces-9967-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4A4A2D80C
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 19:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BFB162362
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 18:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC316187848;
	Sat,  8 Feb 2025 18:40:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2123.outbound.protection.outlook.com [40.107.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94BF24111A;
	Sat,  8 Feb 2025 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739040042; cv=fail; b=u/hGIq7X+qbA8sv4vDNb5SqShdrd9KFXbEUPpbuNc/HjkAKJ5lJHNgm+MUDPBErE6QIU3qYHsWOjGfXP8GbGqbV6pk/D/Xfwmqc4oHAiHBKxOWPM+d4lLpIlIiHLWVCfJypRxQXPMaUoFO8CcKMrN7zoIYnpFDvQPncJdm9qP+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739040042; c=relaxed/simple;
	bh=tZVPeax55rHhPSwRe1vQEK4yriPopEsnpxfKR0BDRBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uDV3RvwLDntAG/pjVcOcylxAGbMp/gKhi3mDcVDZb/ib/akH0E1cRLGv6tAofcmcgDrGAZi0G7k0/I3xuiFIEXC0Iz9oJVJ/NNWzb+Mn6nIqTWfj3FiJhm1hrV5HhCNjWEirU/yPlk8ehJH3mlieDzn57HM2yN4MkA08/HvayTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.223.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jra0vIsPuaoNCLrNri8uugiUysuPKYXpp7fTDGlwlX0z8QNrtdRbwSsHY0k3rLi5DLBn5evat5W8HawLXVSeVzYW9/B2s9NBtsY3mWppRugkMXBK0gmBz0wZJulywWKYHiISpy+eUXszMd57kgXOeklkO7UWnxeGIYWZd2jFUEkTGlrk7HMZCPladv+DsVETEzMjPnNVvY6Q2wqyIdy6RJ29lslIufvDCwvh7b6MyG2tEU92u5KvZe4xcTQQV8Y65a+/pc2s213tZYWmxYBhqkPdVQ+mBP/9UeepYnw70lnPHqGj+AY72y6Jj22P/lDKz4O79q1U8W5y/F10hJ77Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fddCiW6B2DALc//EKY8MYmbvLPZ3LnaiNEoHB0V/fA=;
 b=uOOm9Axer1K2KeYUClnH6KkxpD/gWIiK2Vm0UgyBbyxpuGa62XJJrcfIIeLS+9rLyiWww9ufpBolozpG8g4BeJ1Hng6TpsDuOInADQ26Bto5HsYImSgBPaRFKrdfHERdhdaKXxdr70fvsnu98v+Hr67vwDdAqNpZy3CD/xvcIdTJ7jfz6W09iqzOu8M3XTItuSR7XE+AqoWdoCojuv0xrh8Vih3HsSS4U1KA8Da4WDz2lCk7ilLbIk/g7Eqy3EsFPulJOm9G/wPbr3pxh5LPgpcPGO5L6NdL2rOPogr2SayH4DunvKxFH6G3rOWNtrhXDbFh1+L09pmjXSzG0stIGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 CH0PR01MB7186.prod.exchangelabs.com (2603:10b6:610:f8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.8; Sat, 8 Feb 2025 18:40:35 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%6]) with mapi id 15.20.8445.005; Sat, 8 Feb 2025
 18:40:35 +0000
Message-ID: <40970e33-4689-4623-a423-b346e739ba80@talpey.com>
Date: Sat, 8 Feb 2025 13:40:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] nfsd: handle CB_SEQUENCE NFS4ERR_SEQ_MISORDERED
 error better
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
 <20250207-nfsd-6-14-v5-6-f3b54fb60dc0@kernel.org>
 <28174296-129d-4459-aa23-a94bbf00d257@oracle.com>
 <3e4d14075482489cd010e4ea621c0bd368700e27.camel@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <3e4d14075482489cd010e4ea621c0bd368700e27.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:208:23c::12) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|CH0PR01MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e9743e-62dc-452a-3801-08dd48701337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2hJZENwN1Vpb1h5dllqZlR2RE80RkNQa3V6R01Lb045SmJaakJmNVgrWUJw?=
 =?utf-8?B?aVNHUXZ1YTZVV1IwWWZQYW1RbHVmTWlRaklWaFFOVWhMVUZ3NCtLUnVUR1JQ?=
 =?utf-8?B?d3p5RVBNSk40dk8rOFFIcEY0T2tiN0Y0R0JEcGwybjJYb2lWSy9uWTl3TEpX?=
 =?utf-8?B?elRka1hWYWFOSmhiUHZSWDFpTXdlNURCSmR5b2U0RzZTQWdKakE4MmgrM29y?=
 =?utf-8?B?eGsxUyt4ZXgvUlZnR3VRNTB1dGNXUDN6TGVoY3NUcElZbHhFcUxjcHhGeS9V?=
 =?utf-8?B?Q2RucjhCZ29ic3NqMExwVG43a0gvMXMwb2hXT1ZseC93K2pmNXlrS2E1QXRN?=
 =?utf-8?B?Y3ZFUGxCbGNUYUtUM3NRRFRhcVFlWGVWRno2cXE4R2hObVQrbkpFUGZWTzdt?=
 =?utf-8?B?b2t6OFNoeWJMemFHbTRzZkdUbHU1WXROaXJkdTNSWXdVMEQ5dGhYU0llcG0y?=
 =?utf-8?B?L2tkSG1FN0pEVVViQU1HdDVmcW5NaUNJcUJXR0luOFlkWGt1amcxS2dYZlBG?=
 =?utf-8?B?YVFicTVyUE9KMGVSckIwQkR2OEhjWktMU05FZDRQYnVaUlJXaWVLcGRNcjhP?=
 =?utf-8?B?cjVRVmVsQ0VUaDFoZlFsVkFPclZzekMyL2lCOHpwNm53dnZ2dVZQQk85b3B1?=
 =?utf-8?B?U3pEZnZVZWtPZjMvcG52bm9nRTRaaUt3c2k3UFMyMmRyMld6QXVNamMwQTB4?=
 =?utf-8?B?cU92Y1FDRUg0RHBFWmxZOElBUUF3V2Y2RVlWT0xWOVYzWGhIWmZUaWxya3lv?=
 =?utf-8?B?K1JXM1JtMkpnR3pRWEVzQWROTmIybFZrbXBmSDY0V29YR2tTUVRGM0JpMGlV?=
 =?utf-8?B?VWJyUmpxTkRRcE9aazh2eTZ0M3h4bnorUnR4VnV6ZEhMSjJxQ0NucFd6ck10?=
 =?utf-8?B?Qld5RUxGVnJHdUNCN1JmZlEyTmF4MjFGUkIvQlA0YlhtQ0xNS2NnbXpnemRq?=
 =?utf-8?B?WG41T2pBNDRLVmJwWjFmbHlvQi85RlJ5NXhkS015bzd1ek9DZnkyN1UvUU00?=
 =?utf-8?B?SC93QTluVlRvMUNTUWQ2NTRIbi9jdTlxcTVhRUg1aVJselRIY256Z0gxVU5r?=
 =?utf-8?B?bjdRdTNoRFdwcmNmcmd2YXNSWE5TamFHQ1FMY0lvUFRsQ0NJVWFZSlAzeHkx?=
 =?utf-8?B?QlBvNEd3SlI1aHRJZ2M2Y3d0QnZaclc2TWZMblFiY01PM2FyeCtQcjd1a1Rh?=
 =?utf-8?B?MExvWVcrM21BL0dtWDdBRWNub2k2bk1iczFFWWtpSDdNbDM5OFZHRkYwUHpH?=
 =?utf-8?B?eDVEK2FFZ1VkdVFzK2dwNlpYTjUxWVJGQ2kzOSs4REw4bUJkN1JSWVdzeXJZ?=
 =?utf-8?B?akFJSUdLWGhoWFUwcGFMem12NWFSL0lTUTFrQ05SbzFRS1psajl3Qy9nNWF3?=
 =?utf-8?B?UzJvcmRXV0tVWTFCYTVXbHlOcFB3Y3F3amRMSCtQSWdndVZaUzF1REFaT1Zo?=
 =?utf-8?B?RVNGVWw3MTk3SUthMks1ckVWRVpCeGN3QW55TFdtUFIrNG5zZ1lickEzaXc5?=
 =?utf-8?B?OXZhZUNEWVpKTENYU0FGT1QxdXp0YVVrS1o4M0lZbG84QkhDYThESnRLOGM5?=
 =?utf-8?B?Um5NWGdyQmw5WjNnbkZlTHY2KzRFN25wdndseGVLTm1rUDlIcFZoTjVWRU82?=
 =?utf-8?B?aGVIM3UxSDlPRUlwamRvN0hPcFYxRmJwemx1eDU1UVBYa2FIL3I3TUtmK0t6?=
 =?utf-8?B?TVdHSlN4VUEwZTNrYW5JSjRLL29SdXdtdHd5WWNpZEpiWVdGNytNR051Vnd5?=
 =?utf-8?B?cFY5QVRaeTlDYlhPRHEzNEJJaVZMUEJFa2VCREo2YTMvN3BWcXhkTm1ZVUps?=
 =?utf-8?B?QzVmRGxobWhXRDFpMXJ4Nms3V1paMnJxVjhHbXIvcEhKdW1YK1JGN1Y0a3Az?=
 =?utf-8?Q?P9ERueRXNof04?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVcwaG8zTnlCV1hURFZaUnh4T0wrSERvWjhzcVBpNE5RSlg5dDNpRWliT09N?=
 =?utf-8?B?WG9qL2hFNVlIam1MT1ZQYjRUVEpjelMrN3VURFlDekhucU9aTFd1eDMzK3RO?=
 =?utf-8?B?U09CY0c0RStLRDhia1lseXhYOVIvNVZuYWt5ZEovZjh1RHFrZ0NsSmFxQUtN?=
 =?utf-8?B?ODNEcUdYTVFzQjFyc2RzZ09UNVFCT0pCMGxOT2ZMYVEyZG1Wa0ZZWVQ1V0Zn?=
 =?utf-8?B?alNLbzBTUE9BTTliSlErS05NNTB1UmxVTWluUkxaenFCUG1XdUg5UUMxQUlC?=
 =?utf-8?B?YXJ1cmVQd2IyY0M5Rlh5QUZnSS8xbVYvVW4rcFZ4RGNvMXF2V0JCVm4yMExq?=
 =?utf-8?B?K3psNmxYdHpBQVp6YnZadWlXZ2F6S2krYlFJcW8xT1RZd085c0pLSGs0V1h4?=
 =?utf-8?B?M3N2R2VsUEN6SjJBSjlDYVovdEVlQmhsdkJlL1pTL01jQ0s0c3U0dEdGdS9H?=
 =?utf-8?B?NjE5L3hjS09zYTRqK1JIeTZGcjF0cWFZODVQY2tEN3FycGwxWkgxbXVPY1Jy?=
 =?utf-8?B?TzFLWGh5NWd4OGQvT21XK1gxY2Y5MEdqMnRYRWk1cGcvVnh6R0grdmJyUzBr?=
 =?utf-8?B?bkNqNmVMS3hmRXducmJvdkFQd2w4eVRwVGlIU05xelNNUWdzWUx0dzdidVBv?=
 =?utf-8?B?Y3NxYmszMW9JMTdRTThLTGpiV0lwbXVDVFZOWnBXYWxua0pOWlJ2SDREKzNh?=
 =?utf-8?B?eHRHSjdMSnhvMStyM1Zpb1Bla2pGSG1rd3JqNkRLWFRnYkZTV3dDV3BIa1ND?=
 =?utf-8?B?bms0TmNaM2FkT24xeWUxd3JhbE1OZU9NYm1uL0h4Q0FrMFFxaXNXT29ORDlY?=
 =?utf-8?B?ZU8wVG5BTittWW9yQjV6YTlkT2txc2FpVHZuOHFWT3dxaXZMblB6Um1RTXhh?=
 =?utf-8?B?NUFVN2cwNmVHYmgzN3ozZUI4MFpHOHhwcGVja25WTzVkSGFLazk3em5mQWcr?=
 =?utf-8?B?aXA2bmUweXVxVkRsNHJIMVhLNHllSlhNcUJxa09LVXZLRFY2REIwdG5mK0Na?=
 =?utf-8?B?UG42MHFTOEMzdTB2dEkzZzRJeTNPMEdTUFgxc05jaGZGWCs3ckQyQUxBTE9m?=
 =?utf-8?B?cHEyOTlCZE9VUmppQ2NJY3FJS3dBMW9EMTFvTzI0UGduU3pXUUJXb0hTcWkr?=
 =?utf-8?B?clhyWW9DQk5iM1lxdEZTV1hRVktqTENjZFZYUGVpOThiaUVTS0xldGtQSjVO?=
 =?utf-8?B?R3NZQ0NSU0NHbWdheC9zNnJSZzArNTFKMlJJellMVU5JTHIxeGFoTFFpbEwz?=
 =?utf-8?B?VkliWTl4ZmQwWE9BcFB2WlJXbEpza0IwZnJPa3RDbWtMcmxqQUlMQ05hcE0y?=
 =?utf-8?B?c2Y2emhFSFFCR2tGVHBsYm5wZlVpMVdUZ1F4eHAxZVNTUkNVMFFaQlVxM1lk?=
 =?utf-8?B?b0c5WjF3TUlBaGNQbGxjVUU4aE04NnkxbDVVcC9kc2dpYXIzWEcxWUVRdER5?=
 =?utf-8?B?aHBXOE9PNVQzNlY1RDZUK3RNUmk3WnpQT1pJYU4xSHdJaUdvdS8yd0VYM3Na?=
 =?utf-8?B?SlVGenZvZjJCOGRDUmFFem81VjlBSzB0WFBLQkNuOVVWdWNUeFlFZGhESVpW?=
 =?utf-8?B?QVNqLzlmYVUrMnoySTFNaC9GV0IwVFlxU0lqOTZvWXpQakZ0MGF6OUxxaEk2?=
 =?utf-8?B?dWRHcThxZS9xQmFFMXg0bFl5N0lzemM2UVA5VHlqZGxZZGc4TWprSUhWTkpL?=
 =?utf-8?B?SldZb1J6b0M0TGlYTWRQdDJsbmNrejVvTFhMYTd2WmlUTnUrbzhXZVRlK25v?=
 =?utf-8?B?VW9jc09UVGwxWG44N3dJSFlIeXE5S0Z0dWdWTTU1NWJCcDkzVCtYWHNwajk0?=
 =?utf-8?B?U1B2S0VDV3Z4cndhOFpKWk1sNk0xSjBFZnRkZXBRTEdOZGE3TmtkQm10TS9I?=
 =?utf-8?B?dDE3R2svQlVYTXJMM1ZJSEFZNzJFK0JPdHZ0NUp3Vzh5WGd1MytyZkdiMGdK?=
 =?utf-8?B?dC9ONndIZ0krYzNoRnZMVEZ5MzJUeEtqbW9zRVpGM21lZUphZnhvdlB4bHgv?=
 =?utf-8?B?VmpzK2QzTkN4bzR0cE5sKzhDT2FqM3NlbUIrUE5ON1VLS0RHMDd6R2hsS0No?=
 =?utf-8?B?S0FsdDV0YkgzKzA2bERGN00wTHc2c0MvVW5zYmZDSjlONFZEcm1UUE1teHp1?=
 =?utf-8?Q?coYs=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e9743e-62dc-452a-3801-08dd48701337
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 18:40:35.5345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9UGLdvD50C00DdscDdb6VgCGBmAA66yTz5EsLcFZO4dnDv4wjcrCzVR3vuyJwdQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7186

On 2/8/2025 10:02 AM, Jeff Layton wrote:
> On Sat, 2025-02-08 at 12:01 -0500, Chuck Lever wrote:
>> On 2/7/25 4:53 PM, Jeff Layton wrote:
>>> For NFS4ERR_SEQ_MISORDERED, do one attempt with a seqid of 1, and then
>>> fall back to treating it like a BADSLOT if that fails.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>   fs/nfsd/nfs4callback.c | 16 ++++++++++------
>>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>> index 10067a34db3afff8d4e4383854ab9abd9767c2d6..d6e3e8bb2efabadda9f922318880e12e1cb2c23f 100644
>>> --- a/fs/nfsd/nfs4callback.c
>>> +++ b/fs/nfsd/nfs4callback.c
>>> @@ -1393,6 +1393,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>   			goto requeue;
>>>   		rpc_delay(task, 2 * HZ);
>>>   		return false;
>>> +	case -NFS4ERR_SEQ_MISORDERED:
>>> +		/*
>>> +		 * Reattempt once with seq_nr 1. If that fails, treat this
>>> +		 * like BADSLOT.
>>> +		 */
>>
>> Nit: this comment says exactly what the code says. If it were me, I'd
>> remove it. Is there a "why" statement that could be made here? Like,
>> why retry with a seq_nr of 1 instead of just failing immediately?
>>
> 
> There isn't one that I know of. It looks like Kinglong Mee added it in
> 7ba6cad6c88f, but there is no real mention of that in the changelog.
> 
> TBH, I'm not enamored with this remedy either. What if the seq_nr was 2
> when we got this error, and we then retry with a seq_nr of 1? Does the
> server then treat that as a retransmission? 

So I assume you mean the requester sent seq_nr 1, saw a reply and sent a
subsequent seq_nr 2, to which it gets SEQ_MISORDERED.

If so, yes definitely backing up the seq_nr to 1 will result in the
peer considering it to be a retransmission, which will be bad.

> We might be best off
> dropping this and just always treating it like BADSLOT.

But, why would this happen? Usually I'd think the peer sent seq_nr X
before it received a reply to seq_nr X-1, which would be a peer bug.

OTOH, SEQ_MISORDERED is a valid response to an in-progress retry. So,
how does the requester know the difference?

If treating it as BADSLOT completely resets the sequence, then sure,
but either a) the request is still in-progress, or b) if a bug is
causing the situation, well it's not going to converge on a functional
session.

Not sure I have a solid suggestion right now. Whatever the fix, it
should capture any subtlety in a comment.

Tom.


> 
> Thoughts?
> 
>>
>>> +		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
>>> +			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>>> +			goto retry_nowait;
>>> +		}
>>> +		fallthrough;
>>>   	case -NFS4ERR_BADSLOT:
>>>   		/*
>>>   		 * BADSLOT means that the client and server are out of sync
>>> @@ -1403,12 +1413,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>   		nfsd4_mark_cb_fault(cb->cb_clp);
>>>   		cb->cb_held_slot = -1;
>>>   		goto retry_nowait;
>>> -	case -NFS4ERR_SEQ_MISORDERED:
>>> -		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
>>> -			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>>> -			goto retry_nowait;
>>> -		}
>>> -		break;
>>>   	default:
>>>   		nfsd4_mark_cb_fault(cb->cb_clp);
>>>   	}
>>>
>>
>>
> 


