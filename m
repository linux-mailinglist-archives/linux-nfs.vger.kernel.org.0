Return-Path: <linux-nfs+bounces-6590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A4A97E1C2
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Sep 2024 14:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F791F2136C
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Sep 2024 12:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A686653;
	Sun, 22 Sep 2024 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mde1EzFs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D827E1;
	Sun, 22 Sep 2024 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727009894; cv=fail; b=HOVQq52O1cnscUQ3PtbPcRFNyZ91rTiqMsGFBYIbO0yJhJfSMB90OwmTDsuCYBfNsIRkQKCNsuzDpZgi0siSnFTB6OETowHB9nWFHj0AC6/feuZuCMT+UwNOp/XO44umwDocGDd4EhpUsK0Smadgr4OrrkSGBeVmjkssxBQ9tlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727009894; c=relaxed/simple;
	bh=GQkOwwKTI2C3o4kVkptbwMdyvarzndTJCg8Ed0K3lMA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ulf4/zv1YCFwz/UunbiCNSxINV49FY3cVOpf46KOYqko1zp6UVauR5W8fBXKpgEQ0pfHEIU+JvVtrhkmE2mcpHfJmiGsZ8TXA6Z26Vreq0mOwT1fBYGx2y9OFEiDHJjMkzRIF8w1v8Gi1ooYSFsCH6fwxLxRTrCucb/orRQdEbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mde1EzFs; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFe998j5wS0AmUSz9ljjQu3NGtpWhviICzUBquEoYVUnJFveSCF34QD8/gQUs05GylmAvz/+3uDHq9YORUYx815yz3N1WdbThyuEO2P5ZNx30UQ2m1kEOTOB4ezGvjMMMp6OMUvGzIMj8bq9u+vDuSjhw8OIYJWTOWpMLqWP1uEWe4AgdSgj8nqq2Ezz8x1jxoQ00G6MzQAVy1mXm4aRXOzuI1fyxrbUZSC7mvXnmgPoBk2thUsLr7iu7kQqJV3OZi7czzrL2Kwny6Xz4ocjPc7SdpCLpQWo3r1mguL38I0xCqKJHtUDLN7MeUVD3PVbB/+VPwgHLyNFgAK1FZJXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pis1JI49YuXUwzRvRMALTq75ND9939VJAOPABc66WHo=;
 b=YyTJYwMPCgnlWkTTHT3fGSDD3/Fj38pEzlA9KtO5PrDEjmm5GQ0RDPo12xQCxRR/FVmF4goLyGMj6vixRH3XSohATKBP3kqLeWNCJoPkHAVzshi40WbqcVlr550GB8GCbldfQQN0oV7PnXPCu3oJcTJrm19bd9lOHhedyjZJh5RmPkU9X/qrVKf6OsK///PVzta1PyRtLsOgO3JYyPZMUAh33SHfqg4EGQS44HZszGU80bhg+OutA9m2CBULPAu7QbSk+XscGLyECgx6F1nngwhMtVMmtWO0y8dVT4pHkfZh4BBIJEPwYtLe+Eycfy/IpVwWtJBYVi5ja9nj1/mMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pis1JI49YuXUwzRvRMALTq75ND9939VJAOPABc66WHo=;
 b=mde1EzFsWt0QwHwFUiw/3SJEDcl9c13Lh7Cf4JsF9xIBqZLik0aA9oIA75juGXWKupCXztjO4vxXfAPE812VNONHsL475qP9H/Ba4ti+7bRIQnVbI1WEIcw5OV5XicPF6LNohB9bpNIummY3XfAOjNBlX+FDYJ5mwoBqrc8KwSz45e+cnEXw4jJF6MnNg9Uc3tUu5CRi+4KY5A0K23GO9OhkICyBLNq3GjN0zM6crpIg91kc8pru5yeCJdnDl/ExafKYIbr2MjwEf0WTIqti73yTNgyMsY/mlVz3SSArmEottwGUyIhmQjzZ6OnjM1tKh2o0YRfB60HNzIYkBF0Q0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) by
 PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Sun, 22 Sep
 2024 12:58:08 +0000
Received: from DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b]) by DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b%4]) with mapi id 15.20.7982.022; Sun, 22 Sep 2024
 12:58:07 +0000
Message-ID: <9d670899-18f8-4367-b8a8-6ad84a1224df@nvidia.com>
Date: Sun, 22 Sep 2024 13:56:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: simplify and guarantee owner uniqueness.
To: NeilBrown <neilb@suse.de>, Steven Price <steven.price@arm.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <> <1d66e015-1ca7-4786-893c-9224ad0c7371@arm.com>
 <172680136351.17050.10296437171546281772@noble.neil.brown.name>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <172680136351.17050.10296437171546281772@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0173.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::16) To DM8PR12MB5447.namprd12.prod.outlook.com
 (2603:10b6:8:36::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5447:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 242cdc5d-b49a-4a01-9a49-08dcdb063414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3R3V2RDR2drRWJhV2ZzWkMybFNURURYeXVVZi8yOGd1OHYzRkhOM21yWXZ4?=
 =?utf-8?B?ZWF0ejBnRUVNZWtMQlBwcDRwUXlFU3ZKUmZhT0dHUVBUb0NhVEdmSktFbCs3?=
 =?utf-8?B?b2Y3djFJK2dqaW0xaXZtYVR1YlYrcDJCeTNIaGt6VXFram9LQW05Vzl2d216?=
 =?utf-8?B?QVlwVURMUi9KN2IzRUdRcXZXOWZuWkhscWdmeWdZeDNFeUlPYmZyem9Hc3No?=
 =?utf-8?B?V0lKaytIL1A0Z2owNEJLZUYzcWRtSjVxaGJlbC83TWJQQk5aRmNMWER5Z1NR?=
 =?utf-8?B?TUdoSi9KK2t6Tlk2M3had0UyK0dmcUE0czRVMFFhR3dVaFlPU2I5Wm9WbnZ1?=
 =?utf-8?B?MVhSK2FtVUlDL1Jxbm45SDI2Ymk1RGlTWVhxTm9VNnFCSWZmVWlMbTNJOFB0?=
 =?utf-8?B?UkN3UHVuTExoekZBODRleVVNeGFVWFRQN1ZiNjQzZ2oyd09OU0wzNG1vOW5l?=
 =?utf-8?B?VyswTzJNUmVTdWFuMnVQZWNFZzFnNjQ5QnpoSjdkQU42bFA1NEx0NzZSc2o5?=
 =?utf-8?B?cGUzcmVwT25XeDRmT0ttMkMzZmdsTXQxQk51V0ROMnNEMHBRM2ZpNk02WkR6?=
 =?utf-8?B?VC9TYVlqRFVyMFUxUFRCOE9pTStzOGVoUG1iVlF6TzdLN0syVm41TzBDTmZr?=
 =?utf-8?B?TlJYbkl4dWZMdHYvNFVUNU4vSDFRaDA3dGY2V3hVMlhXallXNkZ5ME9zQWpV?=
 =?utf-8?B?K0piRm9rZEY0L3ZuT2pQaVBZWU9wVzUwK1FnR01YdFRlTUNlK04wMUlzWFd3?=
 =?utf-8?B?aW5tTUVRQytnL0xzOTN6RnZoZTFjWDBsOG9PWmhvZkltVXJ1eGNEbUZCQnEv?=
 =?utf-8?B?OGlhZ2c0ZEg0c2ZBTmxVcUJ6QnVTTzZMVzNJMDhOWGxlZ0xrVDB5Y2ptVjFZ?=
 =?utf-8?B?TFdGK1BmK1BPdjArbEdISjBQSWNVMHZiZk1rTmN4UFhRNWU1OUt1cTZtd213?=
 =?utf-8?B?c09jMWxML1VDKzI5SUUvdWVIck5BM2pvTEh5dFp0MHVpWlhBcS9rYU9vODVS?=
 =?utf-8?B?a2Fmbm5mL081TWhlcS82a3dCNVM0MUV1RXJ4Z2xpeExGR2p4SXExOUQ3b2Ey?=
 =?utf-8?B?MXlYcXVWSnVaWjZScXM3RC91ck1JWFN2ajFKazMwcHF4ZUtxOTY5N3NXcXVI?=
 =?utf-8?B?OVNsUXNXWUZTdTdDU01CMjNxSW1jc01RQnhCV0FCR0ZwS21scXRubG9IeG1O?=
 =?utf-8?B?TWhLMERValdTU2hKRVdwcFZ0MDZ5dlR1Z0VOMWs0anpVR1FQM2I3Rk90Z1B2?=
 =?utf-8?B?aG5pdlRSLzFTbTY5Zkt1T2prbEdicEorbTVwSmFtb0czQU1XeVNsQ3ArOEN5?=
 =?utf-8?B?WmlKSWV2eTJUTndVVm9EOEtNL1F5Z1NyNFB4ckxOeWNRbUNmRXIwOS83MUNU?=
 =?utf-8?B?bXZvNllZZW5TV0k0OStKSGdPUEdtNklMWXBiUlh0WDAwYmxnNmtYMW9QdS9r?=
 =?utf-8?B?bEVHSGFZRTIwWkt5TnFIZ0FlQm5ObXNwSDY1ZklnaGhDSUU4TDJiZ2ZrdlNy?=
 =?utf-8?B?VHhoRlhyUWN3eHM1OCsyZkdXSW9BTHlTQ0VrczhVN0JNUEt2RHd1ZzI3aWcr?=
 =?utf-8?B?cHdFQUZneVc2b2pNeUZKNEFWTDFJK3MzdHlldzBnOUVkYjdJZmQyK1dUMlc2?=
 =?utf-8?B?cmNuVkhkZ2ZOelJ6NjduYmRuRU9EQ1A0RnhMS0psSjV4QW5mMDkxVS9SWXZJ?=
 =?utf-8?B?aDBpeGxLWGtqNStMRDYxcmdFRnZUM2U1WGdnWHo5U2JOSkJQelNEdE9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzRIeC9Ha1VCMEZ6dmxkcWR4Rk1PZzExVW9XWGVleW5nekpWOUUzckNWWUNB?=
 =?utf-8?B?UlZwb1FDL0x1Ums2MzFoMWpHSmxJWjBuKzYyQy9sdVQ5d0dsTnp3RHc5ZHJs?=
 =?utf-8?B?UkpsQUVlajd0SUlvV20wNlVEZTdjTEtzeTczK2tOYjZXWmNkWUJIV0Z5M1hR?=
 =?utf-8?B?ZTYvUXFnbW0yTFhHVGNwVWRQNEhQeElvYUF4ekRzT203MWVxVzRObDJ4WGZ2?=
 =?utf-8?B?NGtXV1dNUDNWRGlMN2RGc1pURndvblZsOTU3WUpVd3I1NjE0ZlA4WlZ2SlI2?=
 =?utf-8?B?MHZRVzRYQnMydHRRKy84V1ByUTgwT1VpcVp3WHRJWGh3TVBEeGZDSTJwNU4x?=
 =?utf-8?B?bFBROGVwYVVxa0l4VFpmSU81b2F0NlA1VitPMm9RMUF0OFlaSTFnL0hRYkhL?=
 =?utf-8?B?VWg4aUhhMk9UbzM2elg2SzI2bGZnTXQ5UU5uc1oxaUIrVHgxQkEzU3B0dmVQ?=
 =?utf-8?B?OVhEZDV3b3pLUzlhWlUyYTdtVjV5bVptR1ZKeXp6NG5YWm1UREpYZ2tUSlRG?=
 =?utf-8?B?ZUNsRlNPSHRHMW45SkRQcXVCdEVxWXphVVdJc1BFM2Q5MjJvYStMQmtKZVho?=
 =?utf-8?B?WHNQRkxEMnpNMmhOOGQ3aHNHaFVnbzBDRndHRFQ3aVFzRExZYTd6YjNNZERW?=
 =?utf-8?B?TkdrbzhGakNJWGpZSmRpcEpmSTJac1h4Z3I4LzRTSnNRQTVhSzkxaVFWSVdZ?=
 =?utf-8?B?c1RlTFBQNFd0bjRiQjkyem5xamNPQTRKNE1RcXoreUYxR1hoNVFsTDVld2JG?=
 =?utf-8?B?emVRVXhBeXR5ZitTRXp1NnRabDIrRGhFb1hlQjFOdTYzUmc4dFFOV2tWTzdt?=
 =?utf-8?B?NFRQMjJ2Sk43T1FlQzdEaUhYMFBER29kNTVJNVNCOHdIa2dSbWtmMFdibCt4?=
 =?utf-8?B?YXBGbU9hTEhTa3A3TmF1TVdpQjk1djJ5MjVVdGsvbnRyVW1mMzJZRTRGbkpF?=
 =?utf-8?B?c01QL1NOQTBkL1NsVGZ2RWtOdkFjb0o0Q3JieXF1WnB4NUlEQ2Y5MWxnNnhU?=
 =?utf-8?B?Y3NJcHZhZGlVY0pFcE9teFZQbmJ2VmNGTlhRcWpwTXRTRkpiVitZRTRQUHRQ?=
 =?utf-8?B?OGEzVTJJdThQOElEWjNZVUY4STQwYXAyeVo1YytSM2xnQVFUQ2p4ZHBpMjFS?=
 =?utf-8?B?VVRIZ1dociszN0NWRjM5MlR5Ny9tekZrMDRpZWwxSzR4YTFPckgrUGRoRHJJ?=
 =?utf-8?B?Z1dBYkhaMHdTK3BBUzhranlPenFSZlN5aVNXcGdNanNOQklkSHBwaXltSUxn?=
 =?utf-8?B?NE54Z3VFSW8vZzJiNlB2blZWRHZJT0V6bnlsTW1ITHdCVXN5WjFxZjF4SWor?=
 =?utf-8?B?NmlpeVFCZUN6aFJ6MjlESHZOM0FvWEtkQjVCVXBVRWJqV0FMNEdCaVlqSVVV?=
 =?utf-8?B?eGtGZnpPZUlkYW9kcjdsWm9zMHh5dnJXNHNLdDVTVk1hVDNaeFhLbEQ3WFBO?=
 =?utf-8?B?Ri9PVkVWbjdXMkExSTQzMUs1eE1qT3YyQWgzRDBIUDllMEttRWJ6Z2hxN0VR?=
 =?utf-8?B?bGkrMnVMdE9yeUI4U3hmaDR3OElDR085Wmxmc0JDbTBBUFpERjJrTGF5VUd1?=
 =?utf-8?B?TXF6eGJLazRxK3gzT0JVckd4bFZaYmdTV0dpeEd0dndRTHdodTBVYzdBTWJm?=
 =?utf-8?B?RTZTNEVyRElQWHBzN1RaViszNEZmQnNQR1NNRGd1bWcwT2hVdjZzSDA5dWNq?=
 =?utf-8?B?bCtsQ01kamd5bVJuYWpyaUlzbHZlYnV0c0pUYTlxd3FBWnlVT3kzUFZnYkRW?=
 =?utf-8?B?VVg2UERvZ25TWjJuSVBma2hQY1p2eVEvblM0bSswWk9kQS9GOFR5TWlWQ0Ev?=
 =?utf-8?B?eEl4WkFmcFVTM0JtdkpQTVNFbjZOVUtQT3IwL3IySXY0VlRZVjlrQTQ0WTBy?=
 =?utf-8?B?d1kyVEkrS0ducVlOVnRSTGNOM25ERndFQ0tvSktZL3ZqWmU3cjI3VzVvN2dh?=
 =?utf-8?B?MzhFSXBIZlEraFU3QXlyQzdFdDc4MTN5MjFjMCtxN3NJdW5IRzFiU3JQMXRM?=
 =?utf-8?B?YWJaeXZFSG9GdFozcktIdGRNOFZhckFsQnc2SlVGMVd6ZHlTQ0NHVVp6YnNP?=
 =?utf-8?B?TndiVWZtdU96am96NGxJRnNZczE4WmpKMkQ0aU05UW5VWncwU0JhR21xWklN?=
 =?utf-8?B?Y2xhazhZU0hUbXFYREpWZGo0UmFxejBUQVFBN2sxVDdtdklPSjYvVXhMVjg1?=
 =?utf-8?Q?wwq6DhpKqZBjEOEVGrQjOkkUIeiJKQ04G2zlj037CV0e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242cdc5d-b49a-4a01-9a49-08dcdb063414
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 12:58:07.2046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDpaIADPP+pJRuFUIZEmuIR7iEVXKFPzDVfNMoNIKUXrwKvtDmpccRqxCAZFXRyi4uRkGLG/mIJPGKv5+p9thw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796

Hi Neil,

On 20/09/2024 04:02, NeilBrown wrote:
> On Thu, 19 Sep 2024, Steven Price wrote:
>> On 19/09/2024 02:29, NeilBrown wrote:
>>> On Wed, 18 Sep 2024, Steven Price wrote:
>>>> Hi Neil,
>>>>
>>>> (Dropping the list/others due to the attachment)
>>>
>>> (re-adding others now - thanks for the attachment).
>>>
>>>>
>>>> Attached, this is booting a kernel compiled from 00fd839ca761 ("nfs:
>>>> simplify and guarantee owner uniqueness.") which uses an NFS root with a
>>>> Debian bullseye userspace.
>>>
>>> This shows that the owner_id was always different - or almost always.
>>> Once it repeated we got an error because the seqid kept increasing.
>>> This is because the xdr encoding is broken.
>>>
>>> Please apply this incremental patch and confirm that it works now.
>>
>> Thanks, I've tested the below and I don't see NFS errors any more.
>>
>> Tested-by: Steven Price <steven.price@arm.com>
> 
> Thanks Steve.
> 
> Anna: could you please squash this fix in to the commit?
> Jon: could you please confirm that this fixes your problem too.
> 
> Thanks,
> NeilBrown
> 
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 1aaf908acc5d..88bcbcba1381 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -1429,7 +1429,7 @@ static inline void encode_openhdr(struct xdr_stream *xdr, const struct nfs_opena
>   	*p++ = cpu_to_be32(28);
>   	p = xdr_encode_opaque_fixed(p, "open id:", 8);
>   	*p++ = cpu_to_be32(arg->server->s_dev);
> -	xdr_encode_hyper(p, arg->id.uniquifier);
> +	p = xdr_encode_hyper(p, arg->id.uniquifier);
>   	xdr_encode_hyper(p, arg->id.create_time);
>   }


Works for me!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic

