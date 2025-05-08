Return-Path: <linux-nfs+bounces-11598-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC53AAF5EA
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 10:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE8C17358C
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895EE262FC5;
	Thu,  8 May 2025 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="auucWdPb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584D21D011;
	Thu,  8 May 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746693695; cv=fail; b=mTEiWV5dSNJc5ruvtgErWUYqN+nag4/ZPpwzYSu0D8Dar/5ylGjrr38LnrAaqGRtHd39IS9TC88s91Bly2Jyai2AsCcb2sf1BIOyglGZpUl6RKGbAPJvu4Ge+UDBYfIlBhnEmlli2GAmvL/C318a8u6M8Z27upab2IkgtpzRci0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746693695; c=relaxed/simple;
	bh=0x7R0SWyVzVLIuJ9QPNq5V2OW4r2k2RUqq9izpGLRWs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HgAUARnqjgJyp/hAkBjP3+WcSQ8nvLfmFQfRSWRc7ySY7c/+h+fvA2eWyOggYDxEovKw+/F0V88TP7UXBVfT93SpKJ/HqpIDwQbCC2xoVjyYqNeb0NxXcW03PZVyqjDaT16EAERFq9nxZrlzBnDtT4pwqxgRGt+ERAHuLPstiFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=auucWdPb; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKMNIYgZELpwWesFuTAW5l2EovgzuQ2IF4YEV76nJsW8UYSBg8jZQF8y4Ovoxnc4Mb1vlxBjS8RGPgoPv6faMKnyFbhocKUBLFOHB19n+ouQhqjyhVYJ69U23PFtU3ffzHXWqOdQlBMF3PUoBVf8HKogLW1GOu9IrFtIyvF8tUPzctswWE7uEgz4ofP7dCRqshuQ4w9ZZWTIh+YnUwgTbHjWMfXV+ozj3tcUiDHfDiRUlX1Ho5r7L7rG0VcjAacWytnMLcA3G9mp3xM28pC+hvI4DX+VaM4j2ho7cmlenhFrMgkXqcuv4OdfksUekx3vljOMqgnf4XTxeTHMLu13LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5x+7tqiyNYKHDIQzWY/0lTE5DKybU8gk934uBv9ArA=;
 b=JOR8je+2w/uJT7FADuJMhS2lTU5+fIMsSHHnAAMAwO9OBWSq7L1tvPuLrC5WsnzjrZT97i2kT9jzsgbQKZD7gttWf57tYGobgUPgfEa2yt1okQWRggvhSc0ndMmcE8pmQJocVRybJrbivmtk3dznCTn8hfAAI6iboUJx6S+MdGwysq8GGzGBB3b/RtEd2gdrwr8mfIZsD+od2m51slLT8yAhaw6IYpKYlo56gLsR6heYYiFGuckdShWmKJbNOg2AixGqdGY0u+QcyK1mE3GUSUfU2SfxgqmSNlY5Bb+hZk71j/O2O2bILcEmFscvGogY667BpUMhr3fMub8Gjmez1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5x+7tqiyNYKHDIQzWY/0lTE5DKybU8gk934uBv9ArA=;
 b=auucWdPbI6qfIKp2zGRbdi/AqtrgZxetfp3Bkk3LcWP08EF84T3nOIQGk/47OWfzD2VGVyFJiGxPtK3Alt2ebNJDCGHpMcf0EZU6q2l8IHUjDIqU0Dnxleaast55TZFPhUfGW+Z0qS8ocRfi8/tRo5CE3v1c2TXRGAzDC7MDAxMOffh76arKuiEwthrC9JmuC9xC6iaNQI7hLjHVqQ5CCVXlZj94Z/2CTkD8FYL9id334kZ2LCB+SXnOtSj0NTnRwoyWqyXixxozFPQBOH10VtnnrbdibhBa/v2Fm+y2xRZFQFQThvOR8mfh6fKjmhJlUtRs6DNMZS10TOIZxBPK0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Thu, 8 May
 2025 08:41:27 +0000
Received: from SJ0PR12MB5663.namprd12.prod.outlook.com
 ([fe80::b41f:9a21:f1fa:185a]) by SJ0PR12MB5663.namprd12.prod.outlook.com
 ([fe80::b41f:9a21:f1fa:185a%5]) with mapi id 15.20.8699.012; Thu, 8 May 2025
 08:41:26 +0000
Message-ID: <1a1bcbd5-4b78-47ae-bede-36265586c7ff@nvidia.com>
Date: Thu, 8 May 2025 11:41:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] svcrdma: Reduce the number of rdma_rw contexts
 per-QP
To: Jason Gunthorpe <jgg@ziepe.ca>, Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Leon Romanovsky <leon@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-2-cel@kernel.org> <aBoJ64qDSp7U3twh@infradead.org>
 <20250506131722.GG2260621@ziepe.ca> <aBoRSeERzax5lTvH@infradead.org>
 <20250506135536.GH2260621@ziepe.ca>
 <be740f28-8d68-400c-85bc-81cc4e48ccc6@kernel.org>
 <20250506141705.GI2260621@ziepe.ca>
 <d7115cd7-c34c-4212-b244-e5247ac68fcc@kernel.org>
 <20250506142202.GJ2260621@ziepe.ca>
Content-Language: en-US
From: Edward Srouji <edwards@nvidia.com>
In-Reply-To: <20250506142202.GJ2260621@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To SJ0PR12MB5663.namprd12.prod.outlook.com
 (2603:10b6:a03:42a::18)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5663:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5294a0-e9d5-40e5-2cf2-08dd8e0c1ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmpIN0t2Mld5THhDVndMN2loSW5nUkJiNjc0bStCZExkWERpVFM3NEVKSWc2?=
 =?utf-8?B?ZWxuekJpYkN6aXZvdlgzbERlZjdzWVBTSWpDalVKcnA5SkFIVDdjZWpockdU?=
 =?utf-8?B?YXdURnJOdENEVHZIaXFNNE1ZSVhiSkM4c2JocUw5WTVQMUFhbnJ4Y0FYbHJJ?=
 =?utf-8?B?b2ZYOEV4UGpsbEZZQ294YkVLUDV1SjZaZm9TZjhOclJLOXZGZXkwdW51amQw?=
 =?utf-8?B?V3E0a0xOMlV4TG9qWUxHWlRERDQ2UU5GTEhwbTM4ZDdTcnlueHY1ZkFQZURO?=
 =?utf-8?B?K0s4ZWhXQ05yN2tPTHFpQ2huUmUyQ1V4a2F1dlVnM3BlRWgwSU80TW1uU2pS?=
 =?utf-8?B?RGFxbGJZMkg3MXpDdTk0V2VnOEZORVhrWEpzWHduU1c4WW1RdENVYkp0cUpq?=
 =?utf-8?B?azB5LzErVGgvUDZKcFFPWklOQldKMmlUSDdUVy9MbWNWemtFTDBzVUxXTUF0?=
 =?utf-8?B?Q2tsY0FTbDJBZFkxNDg5clVzdnRNZWoxa3hDWGY2bUY1TjB0RnMxNytCbUd1?=
 =?utf-8?B?cmVFUExCVzZJeEQxdjB4dVhPRVhHM0kzcEtiQVorWC9BZGs1WGdON0pjaHZI?=
 =?utf-8?B?cGgxQjJxZXBjdVE3ck53OWtOa0pnNG9QWW9lYXl6bTdDdis4S21CNmxUb2pt?=
 =?utf-8?B?QlVUZmdaaHZHaW9CVEpOb2prOS9ISXJUY1FMQVkzalVsQzQ0aWF5VnkyT3Nx?=
 =?utf-8?B?Ykgzc085QXlWaVU5bGJ0RnFzb3Z4Rko5aVJ0RU80RkNkUDlxU3NOQjllQURq?=
 =?utf-8?B?dWlJK3o2ZDRGZEVySTBKVzd2MTNHRXhqR29Md3EyVmxtRUV3aGlpVngzMjFZ?=
 =?utf-8?B?M0ZTODJjNlFkTkxwdFJBWUZhMHJ3QXZrWkN1MXRCbnpZaVM5ODNXUUZ3Y0J3?=
 =?utf-8?B?dTVjdStjUjY4Q05STlRKRHBVNDZkcGpWVmpyWjI0MFNqajUvSUJkcWcrQk9P?=
 =?utf-8?B?MzErc1d5Z2VzOVZwTG4wcTdMMjdEcEVOOElQWER2V1h5S1RjRXdXcXN2VVNo?=
 =?utf-8?B?TTRTQTYrUzZVeTFxQVJNTTlJYTJleWdQWVdjU2lkb3NwMjErWjd4OVVQSUk4?=
 =?utf-8?B?NVJCajdqOXp5Z1p1bkUzQTF4VjRwNUtlb1NtOTEyMFFmZXRWanlQSDVJOHoy?=
 =?utf-8?B?b2xaQXRNTEpydzFYMlB1K2kvMEZHNk1sckRsdjdxMXd4aDY1dTZleGpSOEV1?=
 =?utf-8?B?ZFZDMitzejI1eUVyOVJGVG1VOGVhTmFHeVhkNDRzSkFkRHVOQjEvYTlZNFdt?=
 =?utf-8?B?ZTkxN1VjUVZ4VUcwS3Z1R25zd1FLQlhuNGFlRUp6U3pQcHVxcGNQMnpWcEFj?=
 =?utf-8?B?Z3FRaFpOdEVVTmtWV0JUUERTaWVNL0VpTlZTQmErcEVsVFVsM1dtdHBQOHRF?=
 =?utf-8?B?S3hRYmVhOHFqZklOcVZFeVRBUGNtWTJpbmhPMHpWVUF6VjgzS1M1VEpCd0t4?=
 =?utf-8?B?OU85L01rQVhnMWkrWFVBbi8yZ1F1WUxubEpxMlRHcWgyVzV3ZVB4UCtpYkxx?=
 =?utf-8?B?a2RtekZRZnV5T25aMVBIUG1FTWxkajRkNHAwQjk5Wjc0YVFidHVNcEhSZUtj?=
 =?utf-8?B?QVBRYU81Y1F5NEFxYnBwdk9iS2RzOFVhK1pWTlp0UzBqQmVwaEtJSkd3aHlh?=
 =?utf-8?B?QStqQ3lubDhwcEhvVEVUb0xGa2h5bWRjcWRUWmEvZTdUeFI4TVFUUjdNZ25S?=
 =?utf-8?B?a0plMjU0TnBKSXFmU2pQYmFjN2U5OEUyK0FFZTg3MGNOK2I5d1JSSVpNTlRj?=
 =?utf-8?B?SG1KbWQxU2dEdWhkK0g3ZDFtU2VWNTlwcmp3Sm1IWlpiSDlYL0k0azdTQkhx?=
 =?utf-8?B?MFNEdXRITVdSK3hZQmI1ZVBWcHFZRHdITUxxOVBWSFB6a0R6MnRLUkNyMlJ2?=
 =?utf-8?B?M0ZDRDNQZXRrK2wxNGlLcGxxRG96MmFLbXNTTldHMDlaZ3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXFSRUYvTXgxUXFORnJuUWk2QjZtbDBwdWtLRlJZbVpNYzc4SlBvQ2lEaWJy?=
 =?utf-8?B?SjZGTTRBdzRaZmtrRUZBVSsybUdraWo5czAvZ21DTE5tdFJ2ZjF0S0MwR2Nl?=
 =?utf-8?B?UlBWR2djUWEzRzQ4OGNqcURTK0htR3ZPNHhPVDFSRitJRS81Qk5oUU1iNERp?=
 =?utf-8?B?cGQ5ZlZuSlh4Qjg4YnBsU0VHaDducUtmQW9JVkQ3dUhDTXpEeXJXM1NjbWFC?=
 =?utf-8?B?cnBCUytMV0Q5UzlIaW44ajB2a0pIMCtqNyt3VU1Gb0Q5UklTUnlLOFBsMzVD?=
 =?utf-8?B?VEUwNi9uL091TnhJc3B0c1RTWnlsOUxDN2JOdlU0RWQrdlZSYzU5SmxVYUcv?=
 =?utf-8?B?eFR4RGFzelBoeG5sUW5JQmx4ME1ack9iQy9MZi9jSUw5VmoycHlnYlBDa0t2?=
 =?utf-8?B?ajhLcGdJTC9mWnc2cVNJNlgyU0VjWTB1M1UwbmE4c2xESG5wSVVLc1ZqM0ZQ?=
 =?utf-8?B?WFpuRmR6YWV4TEkxWGh6ZVhKY1RrMGFhUFVGblQ4M1R3QkdUS1kxcFNUWDdD?=
 =?utf-8?B?NkhkbUpLUTJSbGhtOFdzajVLNDJEczNvall2UWgxb3IxdFo1a0UxeFI2M1FP?=
 =?utf-8?B?YjBIN0VQMStJdWt0MFBwcjNzcW1WUld1cHAxa1BrRXZXQ0ZTaldxRk11UmM0?=
 =?utf-8?B?OFBmK2l3T1RweWRaMENKcUJrdEpFK3NSTnRXc2xldlJFbDZIcGpHM0JTOWF6?=
 =?utf-8?B?NGdHUWZ5YlVPZDh6OExQd3BNQzVqcHM0ZnBmNDBNNytZT09oTVd5YTd6WThv?=
 =?utf-8?B?RGpOU0FUZFRaTGRJQURsOFNseEtBbFJMeGN2Q1pLUGM5NnlpNWlRa3NSaUM1?=
 =?utf-8?B?RmFib2hMcGEvQzFYVk9tb0tUN1dYN0pKa0lzOGxFVW5YNjgwdnVLZ1pJUUVX?=
 =?utf-8?B?dFpMc3Z1bGdjbWczOGtRRjUwY1N5K0VsTldpNlZTRVNFZG1hUnJ1NWdLYk1R?=
 =?utf-8?B?a1lqNUpYQkFZWnB6ZkoxUFgxb1hZb0tKV3p6Y2UrTzBGMFAyVi9FUjVaKzNj?=
 =?utf-8?B?bWw3dHFWWmx6TVFPWS9ub3o3cEV1bDc2M2hqTUN4TlpNdUZ1enJNWjF2cGdV?=
 =?utf-8?B?eU0xaTNYelRzV05ja3pPMDQvSFRFczdFWTR6R3M2SXFnK0x2Z29GNnE0SnRy?=
 =?utf-8?B?bTREL0ZobkVicFdCTmhEU2MrbFJ0TTBNbkFzQytHNi9FQUptRFN5bDMwZFpP?=
 =?utf-8?B?SHBJdEZObGVBWE9tR3ZwdUlIZnluY0hGL2RPSFhkTmo4aEJOeHNRNjBlM1dw?=
 =?utf-8?B?MEZHWWdtSndFYXRBdlNaUVp6VXpxVVNiMlFJRGNKOGdlM1BPTktvSG1CeWZM?=
 =?utf-8?B?Y2tvVkI1V2ZtRmoyWThzS2JzZGoxOGY5RXQ3R1BoYS8wZHMrQmRlaTVCdzU4?=
 =?utf-8?B?eExaMUxOUGlIcllYRDJNS0dYelBTYTh0aEFFdWxKYk5vS2w4YjdIMW9kNXhI?=
 =?utf-8?B?dHByS1hPdlc1NjBIMkIzdGFLOHA3MlA4RVViN0FLS0hHT29qMXZwclpHREky?=
 =?utf-8?B?V29JNU9Zejd3Q2xGMzRWL3NaTHJQWEM0cVVGUnBLTnlWeU1qeUswUmNKTGJl?=
 =?utf-8?B?djlKcWVFdGlqN3ZpNXBwK3R6Q3BGQ0lTNXFteVdTV2Z2R3NHNnBSY1JWMldh?=
 =?utf-8?B?YXN4ODhoTjY5Uzl5QS96RlhMOUlJdXIzMGRDeHhncDFQblZXdG5hZVJyOXpL?=
 =?utf-8?B?UEt0d2hkNklJT3BYeVZQR1puN21HZ3Rmb0Vna1QwUGExS2JsR1ZIdFcwdWRT?=
 =?utf-8?B?b3AySmNWK256R2UyRk1Ja2pzSDRPSkFzc1hocFNpZDFJcUg3MlVLd1dNK2E1?=
 =?utf-8?B?d09mOWM4MWxBV2pBR0JjdE9mTDU1SmY3ZzJKZnpaTnFIVDRXS3VSQnVia24v?=
 =?utf-8?B?ZWJYbHNZU0hrQ3UrS3g1T3c4SFpqZkVhMktqRTdiK3FkTGdreGlsY1BUY0pn?=
 =?utf-8?B?R2Z3ZDF6cFMxOFQ1WEZaRWFWS29VeW9HK1NwZ0RqQWt5blI1d2p0OU44RGtu?=
 =?utf-8?B?TWtiY1p6WjdycWlkWHBxMHdFZ0RkL2RwWFc3aHdoVTVJN0J3RThSMDNWWGdI?=
 =?utf-8?B?UWdtZ3VxRVNPZkRuMjQxWStqaE80ZlZVamtSVnhrRFBRV1IxQ0FXTWZtMU5K?=
 =?utf-8?Q?dRZv6RCXat28HVm5XxSm0eLOs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5294a0-e9d5-40e5-2cf2-08dd8e0c1ead
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 08:41:26.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxXg3dcuXRt9pgj9+h7+yhm+POqN/ZDaHrddCq0KjgsVCwlD31VukpTRT0xLHnIx7UkIxt6sOTDppl8Ce5mKOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453


On 5/6/2025 5:22 PM, Jason Gunthorpe wrote:
> On Tue, May 06, 2025 at 10:19:06AM -0400, Chuck Lever wrote:
>>>> In this patch I'm trying to include the reg/inv multiplier in the
>>>> calculation, but that doesn't seem to be enough to make "accept"
>>>> reliable, IMO due to this extra calculation in calc_sq_size().
>>> Did ib_create_qp get called with more than max_qp_wr ?
>> The request was for, like, 9300 SQEs. max_qp_wr is 32K on my systems.
> Sounds like it is broken then..
>
> 	props->max_qp_wr	   = 1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
>
> So it is ignoring the wqe_size adustment.. It should adjust by the worst
> case result of calc_send_wqe() for the device..
How do you suggest adjusting to the worst case?
How inline messages could be addressed and taken into account?
Even if we ignore the inline size, worst case potentially could be less 
than 1/8th of the max HCA CAP, not sure we want to deliver this as a 
limitation to users.
> Jason
>

