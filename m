Return-Path: <linux-nfs+bounces-9987-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7FEA2DF34
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 17:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CF63A4DB4
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DFC1DE3BF;
	Sun,  9 Feb 2025 16:58:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023110.outbound.protection.outlook.com [52.101.44.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4321348;
	Sun,  9 Feb 2025 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739120296; cv=fail; b=asWgSNCLT7QA2L5OquxfuhaHY25NATuGOc5zZNj/AQd7XyQ78QI6n/JbB4qHFXPXVI6r7ZpDrAr9umta4zNSIly7EC0R8CCd1c9g7wB20Ea/69tYqWYSSAPDM99zDHbMgJq7T1N7HhPBCINc8/pRN7Ryy4iw5xFtlfVnVTbTjPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739120296; c=relaxed/simple;
	bh=WKqNSUNSNhXAk9k0AE46gfiCtP+bYI22dh/mRThON2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b7/EoVrp4LnyW9E2OO/QtQP/mJgn8++9+vk9QpbEEN59IFjS/tSxPjOXeBbI9hdYsQUkW9recYpdCh9M7M+NGI8LsWLxBCLkZk9aLRfp3u98dUcg0n7QKd8yygzls2Bm1fcLOESkYaxV6JcARIlUvrpmrPITtNZpx5sNpDuf6gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.44.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0ueKNoajdePAx1FbUm4k3BXwaNKe2ps/3dapdnOSSIRKeWwqJ6KQ/rxTUkTT3u7SnFa2UChsDpZZzy5mr/YL9itxjn4X9JQDX0L1uTYz1ITkrNHQ+N3FdZNUp5LhjVdVmrLvWXUjpt7zsE915Yf6vFBEz4IIoPZJN2XVQKyNOxbDf58UQLyOpqDUmiutGmowRPe6yyNn5RWrdQRlbDBhP+hxFlX0XiA7qB/E90iJE2R7T9PB8Q3pek7hDJiGTarnwPqMexWopcRLFYvO5SFUPg7nsUJ/D+m38jqIZNl86OZ6Lr6s6q1V8Im3JaJgCEon0Rrg4g9v6o/2lp0YdNzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipolEmF8TXrK8GGilnmfoSSb+b0mNnLb2n1S6TP9OWI=;
 b=PCMWqamFoj83/s5ag3Rp2kwFFSixIt1wYj7VNZbH0c9LdTV3DjRVAxeqZXhybZpqo40IoaOWw1sH4Gp5WRUKxRmakVastV/rtwIdRtgAifPp0GPaxHIDb1WhbPfqJe3lbZ9JAwikKKnBZ/fU8q76MJZ6/toZtI54udrcM/GtbTPMJzVbXRQoRE/R7f6VjamCb8l5a7fttWwyeP5SQNpUP1dLhdNQCoPoOkd/hE5X0Hz4qVZ6ABvN2Cs7/WiAckcL6tFIQCge1QEslSCqrOKkN5gYW74yOEF2wytSGzfhK14VUj8oUPt23NlS55vvVyAHAqaVheCgZv0TzxNYD33i/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 SA1PR01MB7326.prod.exchangelabs.com (2603:10b6:806:1f5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.9; Sun, 9 Feb 2025 16:58:10 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%6]) with mapi id 15.20.8445.008; Sun, 9 Feb 2025
 16:58:10 +0000
Message-ID: <bef3a870-32b6-48be-8698-e56e1512dd40@talpey.com>
Date: Sun, 9 Feb 2025 11:58:08 -0500
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
 <40970e33-4689-4623-a423-b346e739ba80@talpey.com>
 <66532654ca25280ffa30168a977601ba4a37aaab.camel@kernel.org>
 <29e739f1-2d85-40c2-a549-5ab9d71686b0@talpey.com>
 <35cae0eb73781bb36c49aed2c2bc49a808698635.camel@kernel.org>
 <2f9fe86f-b49c-460c-bf2e-fed97970952d@oracle.com>
 <ad26cab0-8f63-4ff7-a786-1d0ec51da490@talpey.com>
 <d6fdb3ba346ef606f630441de1a34cb00030cb4d.camel@kernel.org>
 <7da740d0-1e4f-4e1b-986f-9516c8286d19@talpey.com>
 <6606c3bb229513af8a8e1b4cc398aa6e72257666.camel@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <6606c3bb229513af8a8e1b4cc398aa6e72257666.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|SA1PR01MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c60d41-2ac4-4fc1-225f-08dd492aeee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlJsbHJ0Nmo3RUliNXVKV1lhQml6TEJPSGV0NmFON2xpbGdoRmFLOTJzd09v?=
 =?utf-8?B?VnUvY0xibHhnaGN6ZG52ZWs3YTkyN28wMzVod0d1SFRQZXRQR3BENkNtMnd3?=
 =?utf-8?B?THBZb1NiQkdnZVVGTTZHdEhyYy90ZmM1M1FLYVNIcE5KeDlsYkhHMVJ0c2s1?=
 =?utf-8?B?aG9vWmRWR1NYOEtHNW5iYkJBS0x0ZVI0akFpZzdCVFYzWVZFQTUvUXNCSUhk?=
 =?utf-8?B?aWhsNWMxMmE2YVc2R0xjeTBiVWZIQ2xmR1dML1ZHNENTNEQvTHJEcEQ3RFlJ?=
 =?utf-8?B?ZE9HUmhEcTI4bHBvNUZXdnBxYS9LYTFjVUxuSnQ0bXN3Tys4dUFXcGZReFNR?=
 =?utf-8?B?aTBFK2Y5VWZWZkhvY2lDVmpncnBRRERFNzRHS0V3OGo3U0U2eGdpcGNmei9Z?=
 =?utf-8?B?QWx3SnhObkNDWFZwblk3OHpXZVZDOUZlTmhhckN5OVl2YVRzZEhwb2wwSTVt?=
 =?utf-8?B?ZjI2M1lxU1dTUHdLdUpzSWtmelBVcHpFeHd6U24zd0JkMEhyMXV3ai8wNVJG?=
 =?utf-8?B?aStMaE5YbC9pcGw4R2NER2pEY0RFd2F1ZlkwVW40VVc4SCtJdFIrbCtGVEJs?=
 =?utf-8?B?ZkU1OWRoWXZ6OVZudzkxRWpMMWdZQkZiT21naGI1VGFMakxCdHdxL2U4MGtI?=
 =?utf-8?B?WDFOcUM4QTc1R0NFZFRocHNNOXN6dENLLzZYZEtVWG9IakZxeWhpYzQvRHZu?=
 =?utf-8?B?bW9qWHlEaTcrZ0R5SVVpNCtEMFBhWUgyUDZtaUdCNVUzWVlNczVhVXBFVktX?=
 =?utf-8?B?TkxpeE5ib2ExU21FcEZjNXEzc2cwdjFUZDJaOGZUOVd2SVpiNVh4SVpWdmtN?=
 =?utf-8?B?RXJsUUk0ZmFhOHR0MngwMFFGNHBQekdrL0hvekQ1cmNTMEhtWDBIL3hPTk51?=
 =?utf-8?B?L0Q0YkV3eTFLRmRyZzMzc296anljQ2p2TGRoSEI5VUI0RWhBUjRoRzMzc2lM?=
 =?utf-8?B?eDFkOEVnbG1FUG1CbkdISU9qQlVQcUJMZlJmeDJOWERGZm91K1pkQlkxWUUx?=
 =?utf-8?B?Y3ltYjFMY0xGOUxFUzlHT0lPdlJrRmZoOFkwWko4Qk44U1VwNnEza3FUU3U2?=
 =?utf-8?B?VTArUUJOdksvbEJQVmphdXVuU0FoYjhNMWIxa2lXL1dMdXZKVjdOVWNzUHVT?=
 =?utf-8?B?VStLYTVSQndYOHJwL3dkeDlJY3I0QVlLT1M2aGRqOERDakM2bktKeDRjRXQz?=
 =?utf-8?B?ZCs3NzZTbjdkeHlYc044YVhQbzNJdFZEdDVGcVk0WGhMVDFVTkxjVGNQVlBD?=
 =?utf-8?B?aG1qNWV2QUZNM2hUOXFpNmx4Q3gvZEwvK3RqSkF0NXk0RTVReTZudExtby80?=
 =?utf-8?B?QU9UTG90V1V3a1FMTWd4dW0xemc3N3lCSGhWN3JOUlZsTUlhY21SSGFublZ2?=
 =?utf-8?B?TFd4T2lTVTVXS1RmNjN4UUp3OUp2dDNMa0tlbUtBdW9tdGtMWWtXd2kwY0JO?=
 =?utf-8?B?OGNiZFdEL3VUQk1xRGxxQUliNVBYK2hKOCtQZ0hKR1MwMitsdG5yamFuU1Qr?=
 =?utf-8?B?MEJVb2ZZZERyZjd3eVRJaXhxKzhUSEdHcHJWRHBsQ3p5QWpjejZuaGFjc3hC?=
 =?utf-8?B?WmlzNkwrWVFia0loc0tZc1VUVWJMK0RRRVFWQjUreGJ4WHFHemV0WVNoUEtO?=
 =?utf-8?B?R04waWhaWjVvUDRIS0k1dWlndWNONG1id2FhdzlJVCswRXBzeVh4Y1pLemVH?=
 =?utf-8?B?U0FEZ1kxdWpFSFNTcmpKd1FtT1NYdUcyWDNCTVVuRWg2SDJ4VDYrWXNqWEJI?=
 =?utf-8?B?UWUwN2pVWHRWdGtEeGZxWFpqMkh0SjdZNHNJUHhCdUlsWm5hRHliNi9xNTd0?=
 =?utf-8?B?RnA0UzZpN1RXejRsV01sT1JJd3E0ZTdPN2ZCeDdGTElObXFwclU0bEdsOHV3?=
 =?utf-8?Q?29TZWPPEZb6sy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGd2anpQdE9EVGovUkx3UTBUQUN3bEJEQU92ZWpyUmVTTzM1MkVJM0hJTE5V?=
 =?utf-8?B?YXcyby8rQUVybVo1SWV2MktKZDIrcmMzNUpQN0crMW84NXA4emtjamZ3SG1U?=
 =?utf-8?B?UmpQK1NyMW1GVldEMVRXS1RjV2J6cnFpd2RpYStHbFVLb0tGbW1zNFhuOHhY?=
 =?utf-8?B?SXd3YmZEdmFnSGtOWjhXMFBuaks0aUpIWmRNanZvQm1vYlJzRXhuK3VUK203?=
 =?utf-8?B?dWRoMHcrZm9LRWt1VHRKWEpEb1ZKUmR2cFNCM1AwZ3czb2FzbHBFU3RHZ2JS?=
 =?utf-8?B?R3IrUFgwNzAwTG1HamRaZGQ1bFZTVVJRMUlPeDJSbi9XaWdWR0c4VHIwNlJF?=
 =?utf-8?B?YlZTYnl2MlZmK0hyaGVFWVdWQTQyZm1LQ2ttaHBOYzJlVXhIYzBQVDBJNE45?=
 =?utf-8?B?ZFdCblovdUFENlJaVTZ2UjV4TEtKNWxleW5LaThPdzR4YUQ2YlRtNmU3MlNQ?=
 =?utf-8?B?OXhQakVEeS9qQ2RwbVRtRTgvY2Nybi9acUJaVmJFZDJrdjd0R0hsdzFnQnlk?=
 =?utf-8?B?THFpbUNkeWd0NVRIK0FLVWNubkUweFRoVnBPT2xuQStTZm5za1hBK3BHZHBu?=
 =?utf-8?B?anUrZ01GcWszTGFRUVZveVArNkV1Zkcza0s5UFl6VzIyOHJJdzRmVG1rTEZZ?=
 =?utf-8?B?N1BlT005eXRlc3VOTGl3WmM2VDRnYWVQYVMzNDBmWmozRHBZYnhkVFRBL3Mw?=
 =?utf-8?B?MXIwVzgvS1N2TDFqd3p0aEt4cGJaSFFIMkhEK3I5UWYySEF0eTgyTCticlM1?=
 =?utf-8?B?RnBOR09CZEZtWFJmdERrb21MYUROV1NFbHAwckhaSDdmbkNQRUtUb2hsZC92?=
 =?utf-8?B?R0NyN1pHNmhYejFmWHlxUjlyTkkwajRvdDRCZStKYnltdXNyL0EvcWhkdzYv?=
 =?utf-8?B?cElFQ1dlYmdSSURHVWdzNWdWT2lTelFUMDltQUhITTRkaEUrWnFpVDNEQ1Nk?=
 =?utf-8?B?NTU0V1VSdUZkOEl1UStPRjVpYXQwS0laandFU3lXODA0akRkQ0gwNGVtVFQ0?=
 =?utf-8?B?ZnZBVHVSUnhNTVdKNUNraUNNQnVEWEVhWFl4ZlU4a1JqSW5pdk5DSm9DemhJ?=
 =?utf-8?B?SWRtMXVqQllEcTVKRWU3YTBGdm1iNlNJZHUreTNWeXVLbnNQOEJ4Qko3RVhP?=
 =?utf-8?B?bFZvM2VMcUVjbnk4YndMOTJqbDF4Wk9ldVNraEplbmNjNEpyazFEdFRvaVJh?=
 =?utf-8?B?L013TlRab1ZsVGE3MkpOeGcvZHhLWDZZK2M0WUpxY0YxY3FORmNhdlRhY0lr?=
 =?utf-8?B?a2J5MUNLRDEwbG11ZW1tL0pQZytlWEVvUXd6N2JTSmtORjNuQmJkUUQvWnd0?=
 =?utf-8?B?WmZtRzl2UDNpRndCS05adU9FOFNKd01uNURyNmh2MnBBSUFIQnduRmttY2pr?=
 =?utf-8?B?WVM3bGswMGRZRmFuRmJmTVRQQjVneFdFa2VGK09WTERBUVdYZnQ5WVYwSnFQ?=
 =?utf-8?B?RytoOTJlaGtPNk5BNG5UNHVxUUFRMnBkRVpmVUxDSmF6NUpEWndXNFpPd0ZZ?=
 =?utf-8?B?azdCcllUaCs5TDByaXpTNXBQQmJrRTI4OE4wVm1INENWTlU4NytDVjVJN0Vl?=
 =?utf-8?B?Z1ZocHBRaWg2M0xETTcwQXpHdmVJdmgzdFBEZjhXTUU3MG9EbjcyTCtKcnEz?=
 =?utf-8?B?WTlTNVJ1RkhzTGI3M0x6RVNJL3FOamZFZisyQWRiZXpvTzhlYkRBRWpid0Zj?=
 =?utf-8?B?STJ5TTluVEFUNWJNeWZzUmk5RGVSTEN4NmlGK1M3ZVlSZDJKT1ZEa09PYVRV?=
 =?utf-8?B?enUwdEI2TitjcEJvT3VvTWZ6YUdFOWEwVjN2SXlMeWZMNXJtWHhHcTJ2NzJT?=
 =?utf-8?B?aGFrK3VIWUZLeXhkS2tzRUwzRXhHc1Exbm4xelFGMW1zK3l2ekk0V2hBdDY2?=
 =?utf-8?B?QVBQMSthQlZvaTloa2Z0dVZva1BNMndkL00xL1YvbTlRZWV0djQ4dFM3NEov?=
 =?utf-8?B?SFNIdnBEQTFmTDBacVNaOVRSWUtLZld6aFY1MmRkRmppUVQxQVhKUFFYc1Nj?=
 =?utf-8?B?b0N5SDhUb3NJNXZNWHdYTElxQVRBaURtTzEvb3kzYXpDU2xpbTBzdW8zUXVq?=
 =?utf-8?B?UHUxTkxLdkFJQ04yZ0lqSXp0QlIyaHZsNkdlUU5odXg3S1FXT3pMeld4R3Bl?=
 =?utf-8?Q?lWAo4fnIgrBaS2EOLz7Eh3UXe?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c60d41-2ac4-4fc1-225f-08dd492aeee5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 16:58:10.3401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENk6EZmEqDFRD8HEwPHP4RkiUAZEZuPrrS4zBRRgqVVIdqOiVFwN4Dm1KR6VRdc4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7326

On 2/9/2025 11:51 AM, Jeff Layton wrote:
> On Sun, 2025-02-09 at 11:26 -0500, Tom Talpey wrote:
>> On 2/8/2025 9:14 PM, Jeff Layton wrote:
>>> On Sat, 2025-02-08 at 20:24 -0500, Tom Talpey wrote:
>>>> On 2/8/2025 4:07 PM, Chuck Lever wrote:
>>>>> On 2/8/25 3:45 PM, Jeff Layton wrote:
>>>>>> On Sat, 2025-02-08 at 14:18 -0500, Tom Talpey wrote:
>>>>>>> On 2/8/2025 11:08 AM, Jeff Layton wrote:
>>>>>>>> On Sat, 2025-02-08 at 13:40 -0500, Tom Talpey wrote:
>>>>>>>>> On 2/8/2025 10:02 AM, Jeff Layton wrote:
>>>>>>>>>> On Sat, 2025-02-08 at 12:01 -0500, Chuck Lever wrote:
>>>>>>>>>>> On 2/7/25 4:53 PM, Jeff Layton wrote:
>>>>>>>>>>>> For NFS4ERR_SEQ_MISORDERED, do one attempt with a seqid of 1, and then
>>>>>>>>>>>> fall back to treating it like a BADSLOT if that fails.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>>>>>>> ---
>>>>>>>>>>>>       fs/nfsd/nfs4callback.c | 16 ++++++++++------
>>>>>>>>>>>>       1 file changed, 10 insertions(+), 6 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>>>>>>>>> index 10067a34db3afff8d4e4383854ab9abd9767c2d6..d6e3e8bb2efabadda9f922318880e12e1cb2c23f 100644
>>>>>>>>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>>>>>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>>>>>>>>> @@ -1393,6 +1393,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>>>>>>>>>>       			goto requeue;
>>>>>>>>>>>>       		rpc_delay(task, 2 * HZ);
>>>>>>>>>>>>       		return false;
>>>>>>>>>>>> +	case -NFS4ERR_SEQ_MISORDERED:
>>>>>>>>>>>> +		/*
>>>>>>>>>>>> +		 * Reattempt once with seq_nr 1. If that fails, treat this
>>>>>>>>>>>> +		 * like BADSLOT.
>>>>>>>>>>>> +		 */
>>>>>>>>>>>
>>>>>>>>>>> Nit: this comment says exactly what the code says. If it were me, I'd
>>>>>>>>>>> remove it. Is there a "why" statement that could be made here? Like,
>>>>>>>>>>> why retry with a seq_nr of 1 instead of just failing immediately?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> There isn't one that I know of. It looks like Kinglong Mee added it in
>>>>>>>>>> 7ba6cad6c88f, but there is no real mention of that in the changelog.
>>>>>>>>>>
>>>>>>>>>> TBH, I'm not enamored with this remedy either. What if the seq_nr was 2
>>>>>>>>>> when we got this error, and we then retry with a seq_nr of 1? Does the
>>>>>>>>>> server then treat that as a retransmission?
>>>>>>>>>
>>>>>>>>> So I assume you mean the requester sent seq_nr 1, saw a reply and sent a
>>>>>>>>> subsequent seq_nr 2, to which it gets SEQ_MISORDERED.
>>>>>>>>>
>>>>>>>>> If so, yes definitely backing up the seq_nr to 1 will result in the
>>>>>>>>> peer considering it to be a retransmission, which will be bad.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yes, that's what I meant.
>>>>>>>>
>>>>>>>>>> We might be best off
>>>>>>>>>> dropping this and just always treating it like BADSLOT.
>>>>>>>>>
>>>>>>>>> But, why would this happen? Usually I'd think the peer sent seq_nr X
>>>>>>>>> before it received a reply to seq_nr X-1, which would be a peer bug.
>>>>>>>>>
>>>>>>>>> OTOH, SEQ_MISORDERED is a valid response to an in-progress retry. So,
>>>>>>>>> how does the requester know the difference?
>>>>>>>>>
>>>>>>>>> If treating it as BADSLOT completely resets the sequence, then sure,
>>>>>>>>> but either a) the request is still in-progress, or b) if a bug is
>>>>>>>>> causing the situation, well it's not going to converge on a functional
>>>>>>>>> session.
>>>>>>>>>
>>>>>>>>
>>>>>>>> With this patchset, on BADSLOT, we'll set SEQ4_STATUS_BACKCHANNEL_FAULT
>>>>>>>> in the next forechannel SEQUENCE on the session. That should cause the
>>>>>>>> client to (eventually) send a DESTROY_SESSION and create a new one.
>>>>>>>>
>>>>>>>> Unfortunately, in the meantime, because of the way the callback channel
>>>>>>>> update works, the server can end up trying to send the callback again
>>>>>>>> on the same session (and maybe more than once). I'm not sure that
>>>>>>>> that's a real problem per-se, but it's less than ideal.
>>>>>>>>
>>>>>>>>> Not sure I have a solid suggestion right now. Whatever the fix, it
>>>>>>>>> should capture any subtlety in a comment.
>>>>>>>>>
>>>>>>>>
>>>>>>>> At this point, I'm leaning toward just treating it like BADSLOT.
>>>>>>>> Basically, mark the backchannel faulty, and leak the slot so that
>>>>>>>> nothing else uses it. That allows us to send backchannel requests on
>>>>>>>> the other slots until the session gets recreated.
>>>>>>>
>>>>>>> Hmm, leaking the slot is a workable approach, as long as it doesn't
>>>>>>> cascade more than a time or two. Some sort of trigger should be armed
>>>>>>> to prevent runaway retries.
>>>>>>>
>>>>>>> It's maybe worth considering what state the peer might be in when this
>>>>>>> happens. It too may effectively leak a slot, and if is retaining some
>>>>>>> bogus state either as a result of or because of the previous exchange(s)
>>>>>>> then this may lead to future hangs/failures. Not pretty, and maybe not
>>>>>>> worth trying to guess.
>>>>>>>
>>>>>>> Tom.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> The idea here is that eventually the client should figure out that
>>>>>> something is wrong and reestablish the session. Currently we don't
>>>>>> limit the number of retries on a callback.
>>>>>>
>>>>>> Maybe they should time out after a while? If we've retried a callback
>>>>>> for more than two lease periods, give up and log something?
>>>>>>
>>>>>> Either way, I'd consider that to be follow-on work to this set.
>>>>>
>>>>> As a general comment, I think making a heroic effort to recover in any
>>>>> of these cases is probably not worth the additional complexity. Where it
>>>>> is required or where we believe it is worth the trouble, that's where we
>>>>> want a detailed comment.
>>>>>
>>>>> What we want to do is ensure forward progress. I'm guessing that error
>>>>> conditions are going to be rare, so leaking the slot until a certain
>>>>> portion of them are gone, and then indicating a session fault to force
>>>>> the client to start over from scratch, is probably the most
>>>>> straightforward approach.
>>>>>
>>>>> So, is there a good reason to retry? There doesn't appear to be any
>>>>> reasoning mentioned in the commit log or in nearby comments.
>>>>
>>>> Agreed on the general comment.
>>>>
>>>> As for the "any reason to retry" - maybe. If it's a transient error we
>>>> don't want to give up early. Unfortunately that appears to be an
>>>> ambiguous situation, because SEQ_MISORDERED is allowed in place of
>>>> ERR_DELAY. I don't have any great suggestion however.
>>>>
>>>
>>> IMO, we should retry callbacks (basically) indefinitely, unless the
>>> NFSv4 client is being torn down (i.e. lease expires or an unmount
>>> happened, etc).
>>>
>>>> Jeff, to your point that the "client should figure out something is
>>>> wrong", I'm not sure how you think that will happen. If the server is
>>>> making a delegation recall and the client receive code chooses to reject
>>>> it at the sequence check, how would that eventually cause the client to
>>>> reestablish the session (on the forechannel)?
>>>>
>>>>
>>>
>>> In the BADSLOT case, it calls nfsd4_mark_cb_fault(cb->cb_clp), which
>>> sets a flag in the client that makes it set
>>> SEQ4_STATUS_BACKCHANNEL_FAULT in the next SEQUENCE call.
>>
>> Aha, that's good. RFC8881 only mentions it twice, but it's normative:
>>
>> SEQ4_STATUS_BACKCHANNEL_FAULT
>>       The server has encountered an unrecoverable fault with the
>>       backchannel (e.g., it has lost track of the sequence ID for a slot
>>       in the backchannel). The client MUST stop sending more requests on
>>       the session's fore channel, wait for all outstanding requests to
>>       complete on the fore and back channel, and then destroy the session.
>>
>> I guess my question is, what if the client ignores it anyway? What
>> server code actually forces the recovery?
>>
>> Tom.
>>
> 
> I don't think there is anything that does this right now. Does the RFC
> mention what the server should do if that happens? I suppose the server
> could just unilaterally destroy the session at some point, and force
> the client to reestablish it.

Nope. :( Like many other requirements, it's unenforced normatively.

Perhaps we could consider this as an erratum, but it's more of an
omission. Because of that, it may need IETF discussion ("at some point"
needs a MUST). I'll volunteer to open an issue, if you agree to discuss!

Tom.

