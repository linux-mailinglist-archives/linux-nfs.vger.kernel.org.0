Return-Path: <linux-nfs+bounces-9991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBFDA2E008
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 19:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC631884660
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 18:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680F61E0B67;
	Sun,  9 Feb 2025 18:53:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022105.outbound.protection.outlook.com [40.93.200.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CC1DDA0E;
	Sun,  9 Feb 2025 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739127188; cv=fail; b=MiYgTzAYjvLGzkZzxvuvB8SCzWHJ/E5K4y1I29+AcjioOtHebmAqH6GNby7c6NRMLy1xrgBoWjtzlSvBBViPTeTJDBD6+nnKKUblisez3SlDojBinx2y3+ubY11bWtDSCa9zC+SsesMgGLkuDANT3s9mot+mELhA7t34259vQvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739127188; c=relaxed/simple;
	bh=a2YMKSI/4VyvIFRW+t3eP44VpqQ5pf0iyzLx4OYz9yM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=poafKyCV3ASc48lcc1SWE5jrUXHwBdk9DL7zOjpiYPt7SRlfF9hUFqbIKmZMByJ+izIsX51ktCiG4WiBB+nbiaN6qzPObuTZuGI+E+RQqmK+ChzFarkU+/SRnk/Ex9BPQjBG4YVaEloJsw/CbB9mUzjBysvJ20jktBatkmpGWao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.93.200.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frttRbQB+X+hb/QIC4KIdgF2vYPPSs4ABNJ2WRkAQbZTlW6aImHYKHmRJh6Qn6zdV3E0NyxOJ7H/mz7+Vj8BOclTrhZZaAYVtHOU4oCkQl8wj360uScTi7SgGKcFQieCJjOLKE1FC5beXl5Ubb97TK/Lilq/BDnSv5pw1oK20EYyclU4ENSY7IvYNHqCxNkBbBinOBd+aRcUVtQ9RLK7ndLNbAz4iQjDNjlrK3w4zjmp3r5oFkK5D9jZpPhWi5Q9LpELHfBxsdIIRGXFE2jvBoC8XrQhldqjAq+hynHbsrLjI9/sQIy/KMPIvi7FTNS97j72ZZPv/vm5h8pecJSHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8mkt17Hv0QvMgBbioUzkSHqPN67HLc2CMhU3bDlG3Y=;
 b=vtLcdZs0cFJ6kvFWC3PnOxC9DvukumHJWsM509osJFU3LISXBr4KJKYypJnYPWULKWExGZI7YR/iVtTyZQ8isx08p8PbDKETiL4X9IimoN/mIgZ9yySt9xnbNjxTaPMc0pmUduv6sXZz0iFM1BSObDkLK6XtLskZDUeDxId/ybQD669I1rM3yn370QfZ6Ea2cedAbmMNDmhjS8visZf3qvsoiK4P62wOkzwgqkLT+oNtx99xXo0DofCzIQTEgeD1+sQKe1qU/fFRnO+PIpI2KIXu1GLxyweNZ5yxMa40Pfzp2p2kCODwnh/TBiylFlQkhrrD/x3OXorvFYQD26arug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 IA1PR01MB9148.prod.exchangelabs.com (2603:10b6:208:594::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Sun, 9 Feb 2025 18:53:01 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%6]) with mapi id 15.20.8445.008; Sun, 9 Feb 2025
 18:53:01 +0000
Message-ID: <a976311c-e980-4b29-83ad-b625c7526f4b@talpey.com>
Date: Sun, 9 Feb 2025 13:52:59 -0500
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
 <bef3a870-32b6-48be-8698-e56e1512dd40@talpey.com>
 <76d23f2ad2d45f04cc60711cdf60dc59e7d0ae77.camel@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <76d23f2ad2d45f04cc60711cdf60dc59e7d0ae77.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::22) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|IA1PR01MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdba3fc-64dd-4b5b-078f-08dd493afa34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWpFeGhMNnhKZExQV2V6MzZBelpPVURPaWFyL04zV1hweWUweGx0Q0w5YXd1?=
 =?utf-8?B?N2J5cStMRXdaOWpqTEdJS1N2eVJxRWxaRDdlODFtbmxFSndNZzJEejVBUGxC?=
 =?utf-8?B?cldNU1dqRU5oQUVjdnVPdDNDelZFZ3pVOU83SU1DNUxZTFh4dGR2QW1tUWtY?=
 =?utf-8?B?WEs3Nm5nY1pUd2tuUVdzNFpGODNROW5yRzdBNXlXZnZxRXU5V084akNwNTdW?=
 =?utf-8?B?U3NSZUk2SHU4WWVFRWlXLytpSEI2SklLeC8rTWxlc3IzRXpramlXaERocW1U?=
 =?utf-8?B?WWZodFJWTkZMZG9UazZNMlB3RDUvQXVId1lzQkRFSUxyOUI1Vm9pL3Nwb3VY?=
 =?utf-8?B?U2NFZFc1WXhWSFJsbFEwd1BuNkhVY0pUT2tUSGpTNXZnTExCSGE3OER4WlVG?=
 =?utf-8?B?eWcxemVnTGwxVnpIQWNQRlVXeldmbWZWZUhiTWtwRE5RQ0M0Z21jQVNBNDZs?=
 =?utf-8?B?dGN3cEtpaDA0cG5qUkoza2lyYlJaUzA1L2dtYjk5MjFDU0E4MFU4cWhSUGZY?=
 =?utf-8?B?STBITXB4bTgxdjFwR3N4T1pwWkRyQkVJMEIvNHZ6Wk0vMVFFVWJVTXpEWDZ0?=
 =?utf-8?B?WDhzM3VyamN2d0hDWmQ1alU3WG82WVFkSlRZWG5XRjdET2ZPOUNsQmE3dVpZ?=
 =?utf-8?B?cHZUUFVEdmJKUXp5MlZrbHd6cVREMithRVRFUHROSDZyVEMxTFlUWWJzOTVt?=
 =?utf-8?B?cGpmblV5bjM2Zi9EbDF4ZVJyV0lEUHlvNXhhak8xR1FFSkVtQU9lbCtsbVlH?=
 =?utf-8?B?YkdFRFNwVVM3VlhsZERiQmRxRTNmZ3RJN2VwakpKcFNvL1dlY2hVajBUYmRa?=
 =?utf-8?B?WjEyYVlybkVOZy9WeE9WNkR1Z1lRKzJ2K2NuM0dUSnd3SSt3ajEyTTV3RzRL?=
 =?utf-8?B?WXlMNHFjd2J0TW1BL3ZDOE9xNmhwTzBNeDF0Zjg1V0oxeFFnUmRRNDhIM0F3?=
 =?utf-8?B?WjdiQVFlTUlxMkQ1ajJxWWp3eGQ1bGcvY2tRNUFwTm9DWnFqVFd6L09DQnZV?=
 =?utf-8?B?UUU0WmJteEttQkJ5dXZzYUhhWG1KSzZvU2RzTE5Zemt5MFk5a1p4ZFpiQXRD?=
 =?utf-8?B?eThIQ3JvNTE4Smx4emI5Q0ZQNllrTVlzTW9jNHJ3N0h5V3RjWHF4L3ExaU9S?=
 =?utf-8?B?RDViNFBONTMyOE1MTncxQW9uNGtxejZtYU5vSENGT1krdXE1WFA4a2tDM2Rx?=
 =?utf-8?B?MWgvbjc5cnl2aUxGcEZOeWZYQlk0Q0luay84YjVRR1VNVUw3U3Z5N0lLRWNz?=
 =?utf-8?B?dEN2dEVsa0s4ZkZDbnluYWN4TzNGQ1dOOXIxckk0aG5BZHdPRk9yYzR6cm1F?=
 =?utf-8?B?M1BZTVZKRTdOL1ZSbk5RQi9LQmt2N0hiTWJMS1BYK0UyVDF3Q3Nrczg1c09M?=
 =?utf-8?B?L3psZzByT3NGbUhWN1hNZGJKVG1UR21xdC9SL0tLdkZDa0t5Tnk5R0VKRUtX?=
 =?utf-8?B?Tjl1MFRiVmcveStmd2NvUlFZbGlZSmpJcUZxOU1KenpZanBORndkL2dLcG41?=
 =?utf-8?B?N0ZlcnVkUUw5UzAwK0ZpSjBNRi9mUHc2elYvQlkzL1BkZlFvbysvSHBGVVA3?=
 =?utf-8?B?b1JKanlBcGN0dUxWRStEbDJJdnBaYXJvN0kzOS9oMDBKUk5RZ0JYMnZxNFJV?=
 =?utf-8?B?OFpFSlN4QU9qTDBvUXp3c0VwUTZTSUxwTm9ISmY0cUxrVzVSbFRLSEozSm92?=
 =?utf-8?B?WnNIU0FHZkxTTDBCb2U1MWYyS3RVR2xqekNUbFg1cm10c3dQcXhvTmJjU252?=
 =?utf-8?B?Y0hGWlhZR2h1UFpiZFh6bVNHRlMvbzlNQzRlRXVtUmoyS2hTVTFBcElzSnp3?=
 =?utf-8?B?ekR4Nzd1UFFDMnVwYkxYSXJ0d2RieHNvOFRaNzVkRktYbERzNDJDbnp0eDBo?=
 =?utf-8?Q?8gIU5pP3ynct4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0tRUGlFRXlJeVZQWnQ0TFRacmxYVFF3N1ljdGtKRWFxMlZGa1RnaUNxb0hs?=
 =?utf-8?B?QVFjN2ZZeWVGT2FZNk90M2hqb1pUWEFna1lmZlRsdlBTZjVVdXBPakVrcHlE?=
 =?utf-8?B?SUdLUWdoNE5wbnY0WDZXZ0czd3RHbVRRMjU0WkVLbjgxZFRwVVBjTkhVckNL?=
 =?utf-8?B?TDQ1UFNQQlBNNlZnYjRLQmNtM2wxaEt3QmVQWkdCRjd1M1dSTE9QdHdOT3R3?=
 =?utf-8?B?SmczMzVRenpWTDl4b1UzZHYzTWNkNHAxeWJYNWJ0dUVnSjBObm91TUY2b1dF?=
 =?utf-8?B?UklNZWxMQUFycS9mdU40a25aR2J4MFZPVDcyWm0ydlhUem1FOXg1eWlwQ1V4?=
 =?utf-8?B?aFN5eGRiTzR2QmZ4Vk9BZk0zYzhjeU5CYnJIVjNTVnpwMDRhTzA0K2lNcjRX?=
 =?utf-8?B?Yjc5UkEwU2Qvb1JwemlEcW5OazNKN0lHbGdUKythS0hJNG5LbWdpcVpia1A2?=
 =?utf-8?B?OFhCS1l2T0txUmN1dkRscnh1OEtZdDNoY2JQcTlOQ0tnTndDTjVPbHl0T2w4?=
 =?utf-8?B?c0xkWmpuVXdlcVozcXpiYVRMRGxUb0tqeFh1WVRBTCtzU045OUlrZUNHVktz?=
 =?utf-8?B?WTlOTTY2L1NvUzUyM2hEMFVHTi9XaytWMFVsT3g3QkRKcTJ2MkM5enFSbGZs?=
 =?utf-8?B?V2pNMUVoT0RpdW5KZ21oMzdXTHlsa0xOeUhuNVBlWUthODRYcmdKNWltVFI3?=
 =?utf-8?B?MGIxZFk4SVpYRnlQVFAyMC85SmZRVXM1SXR0ZlAxTHhFVjNrZGZEMmREV1Fp?=
 =?utf-8?B?MEVXMVVqYjJmTE0wd0RHY24zcnExOEJMQUNRTXRIbnNFb1lJdVA3d3NqbzY4?=
 =?utf-8?B?ZlZLN1ZRalZCdU9pKzRJSkhIb2NIUlZ5dUVUM1d3RkREZjJlMlhJcEwvTkVz?=
 =?utf-8?B?Wis5ZWpnR2c0dm1EbjVXdGlHdjBzc3M4ZmdUQTY2cWpIVytSUVN6OXRiTEVs?=
 =?utf-8?B?bkpWVjVDME11WHdiaWgzcXkxVFNLR2dNOG45enFRMllGVGEyNzZBa0hDeTFx?=
 =?utf-8?B?bjhmZ1R2cytNaTdTaFQvaTR0ZVRhZEdOUm1pZlRaeC8wcXF3dWxaU2c5TUV3?=
 =?utf-8?B?dlc1RVoyWG1ET2RmYUdySVN1WUZaZENyTG1YMDNtbUx5aXMrWmNQV2F3Z3cy?=
 =?utf-8?B?aWZReldIK1BaSWZqRjFzU3M5OHJNNitoNE00SFExczM0V3kvY1RmVXk3UXA5?=
 =?utf-8?B?ek9uM00rakUvVUxmZzdqaE5JeENsWHE2Z0dIKzduTmNVc242NnJ5akRsT0tW?=
 =?utf-8?B?N0ZGeWsxV0k4WHpITm5VcUFWYmxRdjkyU2VaWGMwN1dtajFaSm94RVdidWJJ?=
 =?utf-8?B?eVExZ2ZvU1Nib0RleGFEVzNPa0tkcGxaVG9BU0ZWR1d3cmRsQXMyOEVjVTZ5?=
 =?utf-8?B?SkVUYXhma0QwWGlwVEhyUVFYYUsvKzgreHVZdHBPa1gxbkxqaHQ1QVVHeit5?=
 =?utf-8?B?MEVYQm9vZFhCZGFRcGVwaHlqRCtvRXBXejZLZGt5WlpZbkd5MXhjL1I4Ykkv?=
 =?utf-8?B?NjJ0eElBK3RuRmdXdWFNNTRBbGY1TUd2aVMyRGdEa3A3bmIwb2dtd0ZPN2oz?=
 =?utf-8?B?NGVpL2RYaWI5SERnbGxDOTQ0RDJYQ2NhQklGcmNmRk13dW01QldlSGxSOHZn?=
 =?utf-8?B?dEhVRVdqQjNsNlVVd3dxMW91SXhJZTdWb1JvWlRxOHpwM3RSOHlmcitSVHl5?=
 =?utf-8?B?VjVHR05ZN0Y2THE2WUEzeHFobzdqMU8vNkxZend0S3pUY0lKZDUvYlFnT3hP?=
 =?utf-8?B?ZTBHWW5DK29PcXFWTjFHNHNwQmdGbzJQTUFqbW9mc2VxNkx2TDlZZEdCb1J6?=
 =?utf-8?B?RkhxKzgrTDM0Yk9ONHpjazYwWW9xZ0I2OVF1OWNtK0NWR1d1RGxWSkp5eFFp?=
 =?utf-8?B?RkU3VGQ1QzNWbmdQWnBPbWVBeFBoTzBLRHFDd3VaRnZMcjdkenVFejNmNHlQ?=
 =?utf-8?B?OUNxc0JFaWFBdWl2WkRabjJvYXBZU3VmMFMzWDhiY3djeEFWUzhwb2ZzVm13?=
 =?utf-8?B?UmlOQlNQQmQ4L29jallMa3Fmb01oM1lwOFNRK0xwTnhpZ1dLTm9STzB4eU1r?=
 =?utf-8?B?N1RpMUxPRUlNV1hEYy83Zlk5cDBscnRkUlBwclZMRjE5cWJBeWZsUldBWTln?=
 =?utf-8?Q?lprs=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdba3fc-64dd-4b5b-078f-08dd493afa34
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 18:53:01.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: An9EdxVOGhBYnqIFWa0x/QFMqqMsGWJKAaO1Vj5k40uuHDxUXjCZ/tO/DIu3Yqpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR01MB9148

On 2/9/2025 12:05 PM, Jeff Layton wrote:
> On Sun, 2025-02-09 at 11:58 -0500, Tom Talpey wrote:
>> On 2/9/2025 11:51 AM, Jeff Layton wrote:
>>> On Sun, 2025-02-09 at 11:26 -0500, Tom Talpey wrote:
>>>> On 2/8/2025 9:14 PM, Jeff Layton wrote:
>>>>> On Sat, 2025-02-08 at 20:24 -0500, Tom Talpey wrote:
>>>>>> On 2/8/2025 4:07 PM, Chuck Lever wrote:
>>>>>>> On 2/8/25 3:45 PM, Jeff Layton wrote:
>>>>>>>> On Sat, 2025-02-08 at 14:18 -0500, Tom Talpey wrote:
>>>>>>>>> On 2/8/2025 11:08 AM, Jeff Layton wrote:
>>>>>>>>>> On Sat, 2025-02-08 at 13:40 -0500, Tom Talpey wrote:
>>>>>>>>>>> On 2/8/2025 10:02 AM, Jeff Layton wrote:
>>>>>>>>>>>> On Sat, 2025-02-08 at 12:01 -0500, Chuck Lever wrote:
>>>>>>>>>>>>> On 2/7/25 4:53 PM, Jeff Layton wrote:
>>>>>>>>>>>>>> For NFS4ERR_SEQ_MISORDERED, do one attempt with a seqid of 1, and then
>>>>>>>>>>>>>> fall back to treating it like a BADSLOT if that fails.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>        fs/nfsd/nfs4callback.c | 16 ++++++++++------
>>>>>>>>>>>>>>        1 file changed, 10 insertions(+), 6 deletions(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>>>>>>>>>>> index 10067a34db3afff8d4e4383854ab9abd9767c2d6..d6e3e8bb2efabadda9f922318880e12e1cb2c23f 100644
>>>>>>>>>>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>>>>>>>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>>>>>>>>>>> @@ -1393,6 +1393,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>>>>>>>>>>>>        			goto requeue;
>>>>>>>>>>>>>>        		rpc_delay(task, 2 * HZ);
>>>>>>>>>>>>>>        		return false;
>>>>>>>>>>>>>> +	case -NFS4ERR_SEQ_MISORDERED:
>>>>>>>>>>>>>> +		/*
>>>>>>>>>>>>>> +		 * Reattempt once with seq_nr 1. If that fails, treat this
>>>>>>>>>>>>>> +		 * like BADSLOT.
>>>>>>>>>>>>>> +		 */
>>>>>>>>>>>>>
>>>>>>>>>>>>> Nit: this comment says exactly what the code says. If it were me, I'd
>>>>>>>>>>>>> remove it. Is there a "why" statement that could be made here? Like,
>>>>>>>>>>>>> why retry with a seq_nr of 1 instead of just failing immediately?
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> There isn't one that I know of. It looks like Kinglong Mee added it in
>>>>>>>>>>>> 7ba6cad6c88f, but there is no real mention of that in the changelog.
>>>>>>>>>>>>
>>>>>>>>>>>> TBH, I'm not enamored with this remedy either. What if the seq_nr was 2
>>>>>>>>>>>> when we got this error, and we then retry with a seq_nr of 1? Does the
>>>>>>>>>>>> server then treat that as a retransmission?
>>>>>>>>>>>
>>>>>>>>>>> So I assume you mean the requester sent seq_nr 1, saw a reply and sent a
>>>>>>>>>>> subsequent seq_nr 2, to which it gets SEQ_MISORDERED.
>>>>>>>>>>>
>>>>>>>>>>> If so, yes definitely backing up the seq_nr to 1 will result in the
>>>>>>>>>>> peer considering it to be a retransmission, which will be bad.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Yes, that's what I meant.
>>>>>>>>>>
>>>>>>>>>>>> We might be best off
>>>>>>>>>>>> dropping this and just always treating it like BADSLOT.
>>>>>>>>>>>
>>>>>>>>>>> But, why would this happen? Usually I'd think the peer sent seq_nr X
>>>>>>>>>>> before it received a reply to seq_nr X-1, which would be a peer bug.
>>>>>>>>>>>
>>>>>>>>>>> OTOH, SEQ_MISORDERED is a valid response to an in-progress retry. So,
>>>>>>>>>>> how does the requester know the difference?
>>>>>>>>>>>
>>>>>>>>>>> If treating it as BADSLOT completely resets the sequence, then sure,
>>>>>>>>>>> but either a) the request is still in-progress, or b) if a bug is
>>>>>>>>>>> causing the situation, well it's not going to converge on a functional
>>>>>>>>>>> session.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> With this patchset, on BADSLOT, we'll set SEQ4_STATUS_BACKCHANNEL_FAULT
>>>>>>>>>> in the next forechannel SEQUENCE on the session. That should cause the
>>>>>>>>>> client to (eventually) send a DESTROY_SESSION and create a new one.
>>>>>>>>>>
>>>>>>>>>> Unfortunately, in the meantime, because of the way the callback channel
>>>>>>>>>> update works, the server can end up trying to send the callback again
>>>>>>>>>> on the same session (and maybe more than once). I'm not sure that
>>>>>>>>>> that's a real problem per-se, but it's less than ideal.
>>>>>>>>>>
>>>>>>>>>>> Not sure I have a solid suggestion right now. Whatever the fix, it
>>>>>>>>>>> should capture any subtlety in a comment.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> At this point, I'm leaning toward just treating it like BADSLOT.
>>>>>>>>>> Basically, mark the backchannel faulty, and leak the slot so that
>>>>>>>>>> nothing else uses it. That allows us to send backchannel requests on
>>>>>>>>>> the other slots until the session gets recreated.
>>>>>>>>>
>>>>>>>>> Hmm, leaking the slot is a workable approach, as long as it doesn't
>>>>>>>>> cascade more than a time or two. Some sort of trigger should be armed
>>>>>>>>> to prevent runaway retries.
>>>>>>>>>
>>>>>>>>> It's maybe worth considering what state the peer might be in when this
>>>>>>>>> happens. It too may effectively leak a slot, and if is retaining some
>>>>>>>>> bogus state either as a result of or because of the previous exchange(s)
>>>>>>>>> then this may lead to future hangs/failures. Not pretty, and maybe not
>>>>>>>>> worth trying to guess.
>>>>>>>>>
>>>>>>>>> Tom.
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> The idea here is that eventually the client should figure out that
>>>>>>>> something is wrong and reestablish the session. Currently we don't
>>>>>>>> limit the number of retries on a callback.
>>>>>>>>
>>>>>>>> Maybe they should time out after a while? If we've retried a callback
>>>>>>>> for more than two lease periods, give up and log something?
>>>>>>>>
>>>>>>>> Either way, I'd consider that to be follow-on work to this set.
>>>>>>>
>>>>>>> As a general comment, I think making a heroic effort to recover in any
>>>>>>> of these cases is probably not worth the additional complexity. Where it
>>>>>>> is required or where we believe it is worth the trouble, that's where we
>>>>>>> want a detailed comment.
>>>>>>>
>>>>>>> What we want to do is ensure forward progress. I'm guessing that error
>>>>>>> conditions are going to be rare, so leaking the slot until a certain
>>>>>>> portion of them are gone, and then indicating a session fault to force
>>>>>>> the client to start over from scratch, is probably the most
>>>>>>> straightforward approach.
>>>>>>>
>>>>>>> So, is there a good reason to retry? There doesn't appear to be any
>>>>>>> reasoning mentioned in the commit log or in nearby comments.
>>>>>>
>>>>>> Agreed on the general comment.
>>>>>>
>>>>>> As for the "any reason to retry" - maybe. If it's a transient error we
>>>>>> don't want to give up early. Unfortunately that appears to be an
>>>>>> ambiguous situation, because SEQ_MISORDERED is allowed in place of
>>>>>> ERR_DELAY. I don't have any great suggestion however.
>>>>>>
>>>>>
>>>>> IMO, we should retry callbacks (basically) indefinitely, unless the
>>>>> NFSv4 client is being torn down (i.e. lease expires or an unmount
>>>>> happened, etc).
>>>>>
>>>>>> Jeff, to your point that the "client should figure out something is
>>>>>> wrong", I'm not sure how you think that will happen. If the server is
>>>>>> making a delegation recall and the client receive code chooses to reject
>>>>>> it at the sequence check, how would that eventually cause the client to
>>>>>> reestablish the session (on the forechannel)?
>>>>>>
>>>>>>
>>>>>
>>>>> In the BADSLOT case, it calls nfsd4_mark_cb_fault(cb->cb_clp), which
>>>>> sets a flag in the client that makes it set
>>>>> SEQ4_STATUS_BACKCHANNEL_FAULT in the next SEQUENCE call.
>>>>
>>>> Aha, that's good. RFC8881 only mentions it twice, but it's normative:
>>>>
>>>> SEQ4_STATUS_BACKCHANNEL_FAULT
>>>>        The server has encountered an unrecoverable fault with the
>>>>        backchannel (e.g., it has lost track of the sequence ID for a slot
>>>>        in the backchannel). The client MUST stop sending more requests on
>>>>        the session's fore channel, wait for all outstanding requests to
>>>>        complete on the fore and back channel, and then destroy the session.
>>>>
>>>> I guess my question is, what if the client ignores it anyway? What
>>>> server code actually forces the recovery?
>>>>
>>>> Tom.
>>>>
>>>
>>> I don't think there is anything that does this right now. Does the RFC
>>> mention what the server should do if that happens? I suppose the server
>>> could just unilaterally destroy the session at some point, and force
>>> the client to reestablish it.
>>
>> Nope. :( Like many other requirements, it's unenforced normatively.
>>
>> Perhaps we could consider this as an erratum, but it's more of an
>> omission. Because of that, it may need IETF discussion ("at some point"
>> needs a MUST). I'll volunteer to open an issue, if you agree to discuss!
> 
> Sure. I don't have a whole lot to add, but my proposal would be:
> 
> If the server sends a SEQUENCE reply with SEQ4_STATUS_BACKCHANNEL_FAULT
> set, then the client has another lease period in which to reestablish
> the session. After that, the server may unilaterally drop the session
> and start returning NFS4ERR_BADSESSION to attempts to use it.
Oh, I don't think it needs to wait one lease period, but that's an
interesting approach. The language needs to be normative and a bit
more clear.

I'll take it to the IETF this week.

Tom.

