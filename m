Return-Path: <linux-nfs+bounces-11655-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABD5AB25B2
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 01:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3104A0B05
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 23:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE9420E6E3;
	Sat, 10 May 2025 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e2HkvhJN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2465620C489;
	Sat, 10 May 2025 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746918750; cv=fail; b=Zh949lp/Q6/0x8KIGI0xswr5p9klbEQ9ki7Acr7zCq40KEcfnV3U9QSWd8zULXrUGmt4t9IL8M+w8LbX/GpJR6BMLwgA81l3aQRDFzspBtwqx6BoZC0YTtAVATr9f8gSg2khmr7gVWCbSi9z2UVgZtVek2c5w/XL94ygoMMnP2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746918750; c=relaxed/simple;
	bh=PCoZNvPoqPhjn28ADCAJQuDHAEu1rKmYtg0mM++KyDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g3bggUvoocvZ1rdzSR5VB8gKcljq+cEtw1oUrYouhHfEAwKFaEWwj9BzvJfKoQdPEuWQyisLXjo6DBamwoD7QCaA+ikg5KHPLsUdPU3hUuOACeu5mrIjUg0/lwrybkyepn5uSUkOfQ8VrbDdrWlfagvxEj4DEa2P8pV7MzOZmbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e2HkvhJN; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4KNOBWK6fosdU7lJApxhUgxfndLT7vBBHucn1HAU8eCQgaJ5nqrlAXJNb8lb6cuYFJ/KLsBIWkLKraT0tueu5d7tkorhkO11w8bDJ9sxG7KkmrrXWd7to2pdSsUUk58PnoxymljTBnHe3klz6qPCIzID2+8R4g/EbB2w4tw+ANyf8NYmppgAiCx4kwpI153APoXOaIy4HdsI7mfVr+CadXFnesSV9rGqed716tdGewwZM0EZtZsT393vlgVim10cVkicR6iDTWcpienhv/Q3gEvRxxu5wx2v7ZBoD9GmfbVc4OGoBlpDok/y1+KiLTjtmX5+JyAMqDL5L5MgK9Mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyYcc3IL6IzTM3lRpEbRz2MnGsCLox3lqCPCVUdMTqI=;
 b=NaCLBH73Kj2dxzFxYGa56EUhDUoRM73Z2J2AyBjhDUsu39dblbsb6VwLeO0mRN8dfZMUEcfRvE3hNg5P7IxqpJmnO5k/QpBAB6wLL31FhnOda/bM6tVXqjzxvXs+VWiRlojT7RAScSt1WfuASuysxH12czKtVJkfuqrAgsaWbenQSyppL81YBwun0KDt5fsY/FdE7g8xiuSTKPTE3l6u+Hm5TxxXNJ9pvSdRv4LGUB8VfaVbvkE0V4koME+xacqO8msIUcVW4XOfZhLI8StI56sogMnNZys8TmUxCLJeUfqeSDy4SYNTV+6H5tWgWsaaq8wYLUKQECYZlX0frWosqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyYcc3IL6IzTM3lRpEbRz2MnGsCLox3lqCPCVUdMTqI=;
 b=e2HkvhJNTH7mgVkM74WTFmfBCL7VrzB5B8JkONc/wL10W4lAjdaldZ5auDo+YD1ksvAiwWY66moJSbMn/uUlXbRhl67dXf3cXZgzYQ0Qhllv1SDvL9q9oaImasDa6VtRJ/UisB/sYkh7nmgXBlUUw4FG5F5OvghJRNLGGZfYkAdN0K1CPcJswin3R9IqqfiSffiV1fMe4VR2zjyESVazet1xiKsvTSLavHaQOfjAZyosC+iAxsR2Z5srT0SYxeIzGpmRY5QwFVVooV5Xd/1pwnVA5IKslrnY+F1wDEaKVC8jtmucNaaQcPaSLQYhsBktFDAAX5gIL0GzoTdtlZxN9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Sat, 10 May
 2025 23:12:24 +0000
Received: from SJ0PR12MB5663.namprd12.prod.outlook.com
 ([fe80::b41f:9a21:f1fa:185a]) by SJ0PR12MB5663.namprd12.prod.outlook.com
 ([fe80::b41f:9a21:f1fa:185a%5]) with mapi id 15.20.8699.012; Sat, 10 May 2025
 23:12:23 +0000
Message-ID: <e9e3c6ba-3a45-4fe6-967a-ffa100705663@nvidia.com>
Date: Sun, 11 May 2025 02:12:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] svcrdma: Reduce the number of rdma_rw contexts
 per-QP
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Chuck Lever <cel@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Leon Romanovsky <leon@kernel.org>
References: <20250428193702.5186-2-cel@kernel.org>
 <aBoJ64qDSp7U3twh@infradead.org> <20250506131722.GG2260621@ziepe.ca>
 <aBoRSeERzax5lTvH@infradead.org> <20250506135536.GH2260621@ziepe.ca>
 <be740f28-8d68-400c-85bc-81cc4e48ccc6@kernel.org>
 <20250506141705.GI2260621@ziepe.ca>
 <d7115cd7-c34c-4212-b244-e5247ac68fcc@kernel.org>
 <20250506142202.GJ2260621@ziepe.ca>
 <1a1bcbd5-4b78-47ae-bede-36265586c7ff@nvidia.com>
 <20250508124328.GA6500@ziepe.ca>
Content-Language: en-US
From: Edward Srouji <edwards@nvidia.com>
In-Reply-To: <20250508124328.GA6500@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0397.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::13) To SJ0PR12MB5663.namprd12.prod.outlook.com
 (2603:10b6:a03:42a::18)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5663:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ecb7ae6-de1f-4f08-6d9e-08dd90181f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mi9Od0ZGYitJd3pYb012eHBNNkNVMDM4dWJOSW5rbTZXSEUrdWJsNmwxRWtF?=
 =?utf-8?B?aTlpZGFMY2hRRnNLZTVtamszVmd5MTc5MnFtWjNpMzJPNEtSakxocStSYjZl?=
 =?utf-8?B?VXpNVmFxL3dicHhCNkplcVpNMHEvdm5sdk5xWXJYS3NTQ2FJd2M4RkZOaUpC?=
 =?utf-8?B?Vno2UFZPVjU1WWdsOHBzQ1FmYm9UdU9EWVducGdFVjJYUFVFNEhrWlR5azdk?=
 =?utf-8?B?ZW9hRnNma0N2dXRFeFhjVndSUnZMTWlHbVloeWtqZkpQQXZuOXp1NE8ybHRq?=
 =?utf-8?B?ZFgxanJNT0h5R0Z5QWljbW9UTUZPRXFKMFhTRVZiMkdtQ2NScjEvWGcrUUl1?=
 =?utf-8?B?QmdvN3lpZ3djWFBlVmcvMmVjcjVsN2dSNXhXM3lWb3psZDRsb09Ed0RldnNU?=
 =?utf-8?B?b0VnUDFnTmJ0d0k0NFZZL1cyb0VLdm9OY0dsZDkyWVhpVVJqbkZTMDMwQ3Zs?=
 =?utf-8?B?NTZjYUhCVlVwK1lDb3pQSWVzY0o2alI2cVJTOFVPb0pUaHJJUHZ2WlprdHlh?=
 =?utf-8?B?ZnF1cUM1VUFvWXFublQxL29xblNYUkphRjRSODhEOW9DVXNNcGJoQ3ZuNnpG?=
 =?utf-8?B?eFJUb0Jnb1pDdkFQblUyN3VCY0RuTWVjdDBmLzA1VU1mT1BibndBeldVRkpK?=
 =?utf-8?B?ZTUxcmZ6VWpXYWc4L0JyNTM4UnhPS2haWFdrWW5vekxoOTEweXFGVXVzb0Ir?=
 =?utf-8?B?SDdJOVR3QVdYMkprTTVEQm1mMGFrMmdyZWZWL1huY3dxOHVFOTNlWTBqdVUv?=
 =?utf-8?B?VW1DME1DdUtraS85QTk2cnR5anVJTnRwOEQ2S1I4aUNjVVRScmg0RXFWT2E1?=
 =?utf-8?B?eGpxWkZ4eFdqTldyN3l1bk5oTE4wS1puVzF4cG9WVkRKZUhHMVlOblRLUVhz?=
 =?utf-8?B?a2RnQTY5eGdsQTRLTXNWYlc1VlBISFFZZHZaRnJVMlp0eW9SWmpkVm1rYzFJ?=
 =?utf-8?B?bFByY2RpZitUekR5aXNSM1gzY1JEQkFVOGo4QzhtSWoxV0VsTjJXT1VINW1j?=
 =?utf-8?B?aEgxdjIyemFBTjhabGowZ05PV1QzWm95QWlZeXk0ZWlHUkVlUTIwQ2Z6dVBy?=
 =?utf-8?B?QU94R1dLeUZ2T3JhNUN5YlBmY01kNmZZZjRWSzd5ZFlQODRiZmhLaWt4MkI1?=
 =?utf-8?B?WmljaithRVRHc2o5d3lmU01yZ0s4aW92Qk81YTNYa09waWVUdnpNcTlyRzN6?=
 =?utf-8?B?TDNtQjZNOVo3QndiYWNyblZpemVvWmdQK0hJcFNIbHlYdTUwUFFxczZWL1Fu?=
 =?utf-8?B?VzNzOTAzc0h4L3FiTFhUa2JGcDVRUWoyY3M3WFlkeXpvQUdnbDVja2I1VUhB?=
 =?utf-8?B?bzBEMzhTb3daTUVPTVBYOFA4ZitnNEU3NU8vRkhzN1o2Mk9ab2xCRjlCZUFp?=
 =?utf-8?B?L1g1UHZQWkZ0aFFZSVJXSFdGNlpWbldpN1hvWTBXbzRidHU1ZDEzclg3ODZt?=
 =?utf-8?B?Zm9KY3VwK3kvaHpmTTRMSkRGd0JtcTg1bXJiTkY0RjNuQ3FBNE5UdkRJYUdy?=
 =?utf-8?B?SElxVEkxZG1BSlQ5dUpOckVIUTlNN3NXUFdId2V4c1g3bUxBNVR4dmpsbWNy?=
 =?utf-8?B?RjhLTmFJaElDS0J0OG1uMURyTmZoKzUrdm85WEtGWEpaUTdURXBoMFhSSGxz?=
 =?utf-8?B?Q1RBWCtwSEMvN1ZNbjNFK05JM1YxMHFWdWlLK3VRRlowWGhkaGFWamtSWDh5?=
 =?utf-8?B?bzlqYXRKalFteitIWlF5WlNZTTNXYVZFcXpXUE5RdGp1dmJUby9RcEgrWU5S?=
 =?utf-8?B?b2FUM2dadzlGUGhtT0ROc09Yby9EVElUbUdSNWlGYzNrVm9BWUU2Nm1qZ0h3?=
 =?utf-8?B?U1ZJd2t0aWhsdDZWVENNMmRIY2hrY3pHd1lHeFVSTFEvckxuOUdoQ2pzVlVI?=
 =?utf-8?B?MGtNR0FqdmVMcW55Q0p0c3VGTWxFM1FjZ0M4UW0rSFhsTFZJRU5oTmlWeHNw?=
 =?utf-8?Q?gsgIj9vVAlU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUV5NndKVjhQdnpTcFgrSGZRQW9ldmhONjlQSlFDTzhQenhJSFROTnBpMk9D?=
 =?utf-8?B?TVVRY1d2NG9wY0JRTTRUcmxpNDlxR1gyazc5SzFDOTFiT3ROMHR5cEVHb3BM?=
 =?utf-8?B?Y1R3cC9NM1BMd0h0SURURHJqY0UydEsrdWc1YkxGa0xpekpYcFFqTUcwUVpo?=
 =?utf-8?B?T3lFcnE3MXpkeEREZ0NMVnp4RDRqNWNnTDJqWWlnTnN1MFNML0pCNnNvQmJC?=
 =?utf-8?B?b3U1b0wyQWR6RmNpdFg2TzI4M1pqS2xKbkNjbjBHRmRGWW9qdEJlT0V3ODFC?=
 =?utf-8?B?YUFndmV4Y0FQWm9pckd6TVlwcnNhVDNOTndkNWozME55OU1sTHYxSGVuZzZm?=
 =?utf-8?B?TWNqNU9RSmxMUFRWZ2ZFczlSVDVBaEYyS3o0WDVzUXFBQkdQQXFwajk4N3U4?=
 =?utf-8?B?YzczZzJ6Vm1taGlsc1dlcXI5N1JhY01JNGF4VExITlhVeFQ3OGZDSG1kTVRu?=
 =?utf-8?B?MnF6NTJYK0piQWsyOFdaaHlUYU9xdC9QTW9GSW5JQkh6eHNWbXpoTVJNdXR0?=
 =?utf-8?B?OERNc1ZGbnZCUm9CeFlmakI4Ym5sc0FqeXllNmQxcWRBb0RqUlcyRUdDRUFk?=
 =?utf-8?B?ZVp2SVhoUWozS25CUURidEZiTHJrKzJRUEVrOTgyWnFaUXlybG5XRnVtdzBB?=
 =?utf-8?B?UVBQQkpMR0NRbVduT2QvM1JsRWpMMVpRbVpSSlc3WG9iaTFqNzI1RTFlQUox?=
 =?utf-8?B?UE8xcVpaaHBscFB2R1VqU2tWd3AwZUxpWGg0ZEg1OE8yNkpNYzJtMUJ1Vjhr?=
 =?utf-8?B?VTI4UEV1eVhSaHllQUcwM0J2N1lMM2lLeEZTUFNmRG9uUnpOMEV6QnhnQXp3?=
 =?utf-8?B?bHN5TG5tamEyYm9xalBsQVY0cmthaGVjSzdUdnFqdGtla3BjQUhEdlVwaVZ1?=
 =?utf-8?B?WEtxY1NpZ0MrRjR3bSsxZnFuUjBqWU00MXBpczBLRm9EMzFRc2dQTG9PaW1J?=
 =?utf-8?B?MEc0T2M3aTg3cHkyR3JKTGI1OXd1c0NrYWFPQ2JSbzRPS202aWlpSktjYjQy?=
 =?utf-8?B?bTNRa0xoUTJHbDF5eWFQRWdVUG1KcGxPM0g5ZTZKUk93UVJONUpFeGRWdDIw?=
 =?utf-8?B?WXNSUjFDenpiWlViVjd0VmF2K0lVRlYzVktyKy9Hc0xlRVlYUWllYlgvejBw?=
 =?utf-8?B?YTBBbHVtVk9jemswSStKR09JdGR2bHB5M3NISjlXZ0JtSXlMeEVVNWx5dWNa?=
 =?utf-8?B?dzYzOVEzMmVUTVJhQzZMdW1FVTl6NzFrc2R4M0FsaE10QkhIRVdyZHRjM1Nw?=
 =?utf-8?B?Vm5ZWm80dkQ0Y0lUdk9yOGsvNm40MmFZZmJmQm5PVE9EZEVFc2FKSzdtNWhx?=
 =?utf-8?B?KzRhakhjZGhtSFp1VUxIOGpoV1lLYjJRcnpNbExWNGN2ZWZFd3ZIVndSZ2x6?=
 =?utf-8?B?RHlZOXZsLzgyTFQ2TDA2eC8wNDZYTG03VHdRWUdqYWhleDBuV2lZNEdtNCt0?=
 =?utf-8?B?aEZZRktqK3NTRW15R2FZdTdSZGdIRHZ3NDlXK09QRm8ySkIvUmtGV09UaXFX?=
 =?utf-8?B?TEVhRC9oQ0hHSTVENjRlWTBaV0x3K3RWY1dUQ0pmbkh0Zm91dFVqa2dTalA1?=
 =?utf-8?B?VkpNRjI1MEdHbWk4czZLTXBXUnNKUXRoRUc3Y1FmT2NEa3NVdWFPNXpSdWtk?=
 =?utf-8?B?TEZBUWxnelFGMUd0TTBmZmJLY3VuaWs2UUtaR3Y5MXNVT2pWY0VyNnBIYTN1?=
 =?utf-8?B?eFdPUEZ3RVRwOFU1NlRJanYxMEttYUFlQ3VyaTBic0xraS9FMnhybjZpb0hS?=
 =?utf-8?B?NEErOUdKYkRBWTlNdXpweDI2TFRVNDVTTHZoMmwyUExrSE1rZU9HQVlWWmZs?=
 =?utf-8?B?K1BuWTBmRW1KSW9SWlI2QXQyTnF3YytoT0pkY0VnN0dvSlFNR29qYk5jUDJs?=
 =?utf-8?B?clFVK1NqSUdiSDA1R1QwVFJ4U1NuYUlHZitjMFVzWHlFSFcxVkJSeTlnYzZx?=
 =?utf-8?B?UVM0S2JqR0xKMGpYNzIvTDB0azQxVm0wQlNPYkROZ2N2YWhpZm5LVk9LS1k1?=
 =?utf-8?B?aDF1ekRJc0RiUlNUZGtwaVdvdWpaYkJ2Qnc2Q1EycmwxdC9PMXcwSVlYQk9n?=
 =?utf-8?B?cUtURTVjVyt6bGNzOU1uK2VXWE5PQ0ZaQWJVdXZHVUFyRjFoU2dLU1I1Q2hZ?=
 =?utf-8?Q?49tu0S9N6l6wZGRsuwnFedXE9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecb7ae6-de1f-4f08-6d9e-08dd90181f3f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2025 23:12:23.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17B345PPEyubt1OJTzQJ7+YOBnOpOhD4ud4v/jVrjUII8qdBReysTT3rbjXQbQod0jhC5nZ2JNO4U+sG2iaF5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600


On 5/8/2025 3:43 PM, Jason Gunthorpe wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, May 08, 2025 at 11:41:18AM +0300, Edward Srouji wrote:
>> On 5/6/2025 5:22 PM, Jason Gunthorpe wrote:
>>> On Tue, May 06, 2025 at 10:19:06AM -0400, Chuck Lever wrote:
>>>>>> In this patch I'm trying to include the reg/inv multiplier in the
>>>>>> calculation, but that doesn't seem to be enough to make "accept"
>>>>>> reliable, IMO due to this extra calculation in calc_sq_size().
>>>>> Did ib_create_qp get called with more than max_qp_wr ?
>>>> The request was for, like, 9300 SQEs. max_qp_wr is 32K on my systems.
>>> Sounds like it is broken then..
>>>
>>>      props->max_qp_wr           = 1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
>>>
>>> So it is ignoring the wqe_size adustment.. It should adjust by the worst
>>> case result of calc_send_wqe() for the device..
>> How do you suggest adjusting to the worst case?
>> How inline messages could be addressed and taken into account?
> I think assume 0 size inline for computing max sizes
>
>> Even if we ignore the inline size, worst case potentially could be less than
>> 1/8th of the max HCA CAP, not sure we want to deliver this as a limitation
>> to users.
> The math is simply wrong - log_max_qp_sz is not the number of work
> queue entries in the queue, it is the number of MLX5_SEND_WQE_BB's
> units which is some internal value.

I agree, no doubt that the returned max_qp_wr is wrong and misleading...

>
> For a verbs API the result should be the max number of work queue
> entries that can be requested for any of XRC/RC/UC/UD QP types using a
> 0 inline size, 1 SGL and no other special features.
>
> Even for a simple RC QP sq_overhead() will return 132 which already
> makes props->max_qp_wr uselessly wrong. 132 goes into here:
>
>                  return ALIGN(max_t(int, inl_size, size), MLX5_SEND_WQE_BB);
>
> Comes out as 192 - so props->max_qp_wr is off by 3x even for a simple
> no-feature RC QP.
>
> Chuck is getting:
>
> calc_sq_size:618:(pid 1514): send queue size (9326 * 256 / 64 -> 65536) exceeds limits(32768)
>
> So I suppose that extra 64 bytes is coming from cap.max_send_sge >= 3?
>
> Without a new API we can't make it fully discoverable, but the way it
> is now is clearly wrong.

This is what I was considering, a new API.
The above suggested calculation will return a reasonable value but 
obviously won't satisfy all use-cases (probably someone else will face 
similar issue later on).
The question is whether it is worth a new dedicated API for an accurate 
"per user-case" calculation.

>
> Jason

