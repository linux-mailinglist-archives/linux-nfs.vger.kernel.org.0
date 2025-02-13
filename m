Return-Path: <linux-nfs+bounces-10075-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C70A333D5
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 01:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325E6188A073
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 00:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B3F28382;
	Thu, 13 Feb 2025 00:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fn/PtXvn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hK8GBoxG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168627456
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405353; cv=fail; b=IX9GnMQ4iJG6w2xaikLQ8Uwiq3T+++DOodprNOy28oHp9oDuAFxgPkUAn2A81iU6fso7lng0WKf7HdlYMhmc6Mbd08tekzf1oTnkx62stEV0W5g2g+MQD4ATkw69Copa2eEN39WtUXDejw8a0j9qBZwyrmNdmUnJbLsDe3lI7Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405353; c=relaxed/simple;
	bh=K4HSo2CAIMiF0AELhjA6aQQbK/fEy4bUBJpLig08OgM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TnN2ndDWLQ7jKU5718T45ZiwAJ8eXAlCjZ610iqNbqRrEOvlsBFkDV1OXkfODDIztplzTiD7gc0/WRUtacMf998w+ewJCsvG+5IpEjEWWf6PYlfImQA2GuEM95/ZmCtbo26jd51iki6imkvLiDl4/m1mLDB/Xw1b/CuPI5VA4K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fn/PtXvn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hK8GBoxG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CLpkYN002084;
	Thu, 13 Feb 2025 00:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mrgsECWgfF3bqJJ4lI69X0pxCmCser57WHt7q/mDnJA=; b=
	Fn/PtXvng+vMzN9kdrafG87X5YoeaeoDa5HkTa4KdGk/pWA1W2PFIhwtsoO+x8ct
	L7owcN1OxwCpSpoTiAiksoPnrjXRmwsNmOfuvxKtvFOowKeetvnP50TQkSk8zHcC
	lpK4FVUqAZgKY4AOzZS1IECIg72hSB+wp0mbr+U7m1vUYL+DjIVhvVVNVoLvYeEV
	vWkH1srV2fvsYqi2pB0dGJgjZiOtd/xs9l5boNuFw8DPzNCUTdvZDWfarfdFvSHJ
	lVMalfEGCrcp8H1J3GvFNFcNGN5uNy0eFSHCXJOCtgyBzvFSVlzfKvXpTmw3rPoL
	L9+kVuxspEwCF1ZAVhnnpw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s40kcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 00:09:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51CNxqmD030546;
	Thu, 13 Feb 2025 00:09:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p631etyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 00:09:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJawdafKGW9km0QTXgsm8haSX63ijbjBC1M6wOTXgfXwEckFOjt2TrBbvv8MmbZl1IS7p6uRg8X/QFcE5pdaya/AvhuAmJl+4vRXoSSRTaO1OzIn+NpQoLn0QkpnwEBXyIFuwB9OU7COK9/4ddhWkbclttqH2e7/51VfFHCHCPjwthbPDndvQu8C6jO0JV9850lMe1YzNMGlTPy8Ttb/pmAimRIi9NKDcFTn2sTq7B/5KczgwpD9ge3GgKPn+69GZROxnacyzMxT1AtJtMrO+lyWhZ32jLxUkau1bzhJckCxvf3xJO+wBariIGjot45cnOkOlKnB0947pUTSgiI5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrgsECWgfF3bqJJ4lI69X0pxCmCser57WHt7q/mDnJA=;
 b=il9+BP44wwLEW762sqzYBJuYIBUCoUVfi7fjw3dXAUhBwE1gaKtznUO7h9NVLzGZdp/KrHhW3tj7cziEHKHw2cBfEaaoJ0UZu1UFlpjbK6kIKQEYGyR/01SmzxjULiIXKru4C4XwacnX+0sdEB2TujgsZ22yAMVv7UL0ILrtx9+5OPn/ucC8QHTyMue3MfabwxVEeHeXdS4FhaSDYIqHtuYDc2Qftop/pdyHbWP63NpN8mfUvXwCS0XGyD/N17pEJSd2NPHI/ofDny23BAFjJA7X2YBi3B5gfxHmBYeEzCWVwICyEHo44VjOA+/0yX2p72YAJDz6XqIM3mecsbxgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrgsECWgfF3bqJJ4lI69X0pxCmCser57WHt7q/mDnJA=;
 b=hK8GBoxGgbEa9ouxw/u+LkxzwJbJFA9BNpvhBSSyU3BkZaEmDWct01lt/mdJFQSM1rKAJNdM5jNt6hWF9+OGWwTNbIpd8ocENaHokNecJSl4EqeRGqj24I0KbYtRNt57xKedsBfQm90zmghQteUw8GdpD5j/s5cEtqg16xFxSlA=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 00:08:59 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 00:08:58 +0000
Message-ID: <024c33ad-9ae7-42c7-99c7-62c338f03bd8@oracle.com>
Date: Wed, 12 Feb 2025 19:08:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] nfsd: filecache: introduce NFSD_FILE_RECENT
To: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Dave Chinner <david@fromorbit.com>
References: <> <861990916fdd98170abb7b15188dc360566a8937.camel@kernel.org>
 <173939997256.22054.14991770209667672699@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173939997256.22054.14991770209667672699@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:610:cc::29) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SJ0PR10MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e516367-3d9a-422d-72b6-08dd4bc29bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alNJTUNkaDl0Mi9Cak9VdVYrYW1GVDZxOEVjRHRLYzIxUll2Mm8yeGZVNWU2?=
 =?utf-8?B?QmtBVS9XZkV6YUhack9XZnI1UGhXc25YcVBDWXRuV2pZMzZsMldDK05BaDNQ?=
 =?utf-8?B?YlNyU3YxZS9iVzRPeWp6U0F2MWtwUEphUlMrVDB4WXN4N2l2S0tVdVJLYmEr?=
 =?utf-8?B?eEFVbEJpNkhoTTRKdnlmRnhQNE5tRkNTcXBGMFdxVnRyNmFDcjFid3lFK0Nk?=
 =?utf-8?B?QjRza05hRE5TQUxpckJwczk3bzlBMkVDajQyZVg4SzBnaTU4SUtnWFpBMkVY?=
 =?utf-8?B?M2dxbXFoL2g2RGhvblAvWTNsb090bm1hRWN6d3B6RHpWakx0YUY2eUYvQXpz?=
 =?utf-8?B?MlkxMzRZSUVOMld3T2dvQVZsWFlSM21ZNGx2NnJxNUV6WCtndlBQekU3c1VE?=
 =?utf-8?B?aXBwVEd5U1RidDFIam1mbVhKT1pySHNONVFDWUR0TXArL3ZXVUFyemdMYTR6?=
 =?utf-8?B?SWRicE1uMnZEWDY5Yi9WUGJjSlJNRTVhekJkNW8reUtySk5Odzl5RDM2Z3Jo?=
 =?utf-8?B?VTJqOFhHSXE1cEs4RmNKcGVNVEVRUmdLOERlSFZVT2kyMWFCNVVhaExxaENm?=
 =?utf-8?B?TThVNFI1N0dMYWxYZnEzV2diYWtrTjl5RFZ3RHRJOFVyb3IvcXZpOFhYcUU1?=
 =?utf-8?B?aUpQUllNcEh3MUtaWFJheklwTzBNcG9UZ1ZuYlpJa2JpbUNNWHlFRE41Z1Fo?=
 =?utf-8?B?cG45ZE85dlprUXNUSjVEUWhuV1ZISVkyeWRKUkpsK1VZWCtBVzdkRS8wUkFo?=
 =?utf-8?B?NS8vajMvWENaZitMdUkybSt3MURGeS9DYmw1NisrMlF0NTRyZGZyaEsyTml2?=
 =?utf-8?B?UUtqemxZZDVBQktvbU9Bby9Ma1pQNFgwTGptaVhSQzd3YlB3Q2NKT0I3Um5S?=
 =?utf-8?B?TFJCcWthK3RURVhKdVlOYy8yVG54RDNaeXFVV0huMCtzOUE2ZkdhQTljOUZB?=
 =?utf-8?B?VWFETkNqV25peTVSTTRKcVBxN3VudnpNUlZxYmlVcnRtTkFPVnVLclV3bGtk?=
 =?utf-8?B?cjJUZHRTQXJpVjFXeDMrVm9GYm8rWjA0MFRhbUxNS08zQTVpREJCRUxIbk85?=
 =?utf-8?B?V2JCdVJrOXhiWU43ZGcydnEzZGtxUWlrR2JFQ3lvQURKTlhNVjVwZWI0bDlP?=
 =?utf-8?B?Y2JqWHNKQXhuS0crLzZBbGhVRStEVnJmMU0xTHFKQjJRVjZPQ1UwVWtqdXR0?=
 =?utf-8?B?aUdUT3JKUGtLM0JTM01iRnhxM3U2QmkzSmtSbldjeitJUWNMM2tEY1Rua0Rq?=
 =?utf-8?B?STRrNVFaQ1VXWWdSQmJOM3N5Tnh6MUZYNHRLVHFjcXlBV3Q0UlJiaTl6TVV1?=
 =?utf-8?B?ZWlwc29sWFMxa01RMDdyZlFtVVI1emZ6MGk5OSsyN1hrVWRRZkU1d0V5c25s?=
 =?utf-8?B?VEV6TXZpQys0UUdUM0JnQUZxMDVuR2hMWlpPVE4rdVFYZ0tiaE81cDFRNUNk?=
 =?utf-8?B?VGdxZEEraks5ZDdIdThWRkFMYXV0SUlVK3pZL2pUM2NFSGxTRTcvZnM4b09E?=
 =?utf-8?B?Tm5xeVZQeHNUc0V6TDllN0RRTG93ek1QZDZ0MHRWUHFwYmlDcDhTT0Vzd0Nw?=
 =?utf-8?B?MXJxekt1VTQxQ3dCWGNSUFEwSWJCeWpsYTk1N1l6dmNiRW4rUmZ2SEYvaGF5?=
 =?utf-8?B?M0V3M05MUWVIZUNCNnlIZWoweVZPam41RDZBNGlob2NqSTBQWENLMDN3UUQy?=
 =?utf-8?B?Z21zVE9hU3ZHc3gzbHlKYStpdjZIT0pWYml6aFBJNURCcnZKSWgrNG9GTmM3?=
 =?utf-8?B?dzJKWXBrNHlYcnMyeHZId3AvVFJGSTJYdDN0eGxGbmZwL3hhdkorSEpaVFZS?=
 =?utf-8?B?TFFwazFSQkNOZm9sWDZRRTZ6NVU3RzJXRTFlczE5WFdJTGxtWUdkVFZkR3Yy?=
 =?utf-8?Q?juUYjdq++3XF3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXhkMWtQSDlyaTV4akxuTHJBdXRwWkxLaVhwZTNacDVQWkIxTXBXbHJ3TnI0?=
 =?utf-8?B?eWg2VGJNT2VLeS9XdFJ6d1FJQ2NpZm5NZWZ3RTh0aEhiZEl5bTJLRjF0ZDFO?=
 =?utf-8?B?bThXbVd0STF2OVR2TlYwMkh1TllYdXdCMnM3T3VEMFJ5UVFQczB0aEhFSzlX?=
 =?utf-8?B?K1FDMjYrUCtuY3k2VC9DVFhCTXcveGNvRUUzNWRIQ0ZuSWFtZzVBd00rSENX?=
 =?utf-8?B?b2RWWmtnUnVTd0FyaktOd1JCYlNkVHNaSW45UGtIaEIzdkNnb3dVUjk3cU91?=
 =?utf-8?B?K0t1bFB1d21EL1F6a1NDaThRRG1QdXlGLyt4dUFwY1hmRFZEalBkOUFxUEVV?=
 =?utf-8?B?c012NGN4VkNNdkVBd0NIK25xa1UrR2hLNG1YU2NmazdNenQ2cUhxaWZ0S1hm?=
 =?utf-8?B?YkFuMUxOYUg5cDRMZGhIb3pwMG9CZ0RLbkhwTUFzUW9aRDNKUDZyTnRJbDJJ?=
 =?utf-8?B?WGN6YWppaTRndmFXUE84UFZRSXRVQitUNkZYNkJvc0s0dGhmOEhXTTVyR0FS?=
 =?utf-8?B?dkFZRkV0cEd0MXYrTFgvb0dobVljZG9YbHpVMHFES1JZbEVoWW9FK1ZpM3hn?=
 =?utf-8?B?Y1Uxb2dpc0t1c1F1Qm5xa1hMQWpFQlkzVnZPOUVUUGVoQWVHY2NiRnhpM2lz?=
 =?utf-8?B?VXJDRUIyWkpaQjVCU2l5czNVdkdLcFhSSm0ySFF3Zy9jQnNzaW5naDIwZVBa?=
 =?utf-8?B?cVhybGMvS3NIUDJWQ1FmR1pyNDRhU0xMcERsYmtyOFI0MWhXU2JmdnVESHhZ?=
 =?utf-8?B?OHUzNUwxS1oweUJhU3hsd2NpNUpoWVpFMUp5QVYrZldSVHliZjZObFkwRXA3?=
 =?utf-8?B?c2lXZmNqcUp4QmJRZGpMZ3F2YnQ2MDdqTzdVbW1ocHFMSlBvREdvZm5yUm4x?=
 =?utf-8?B?akxrcWVYWU82N2RUbUF1dWNBb0dhTWY1bzNRc0tlV1RxQ3RDTVUzSlcwejN2?=
 =?utf-8?B?T2RDZlhxUkZwRW53ZExncWYzb0JJS0REeWpZQzVId3lweTAxbStNQkhFbGpx?=
 =?utf-8?B?UGFIRkFSSm9KeDQ1ZkV3NzZuaElxbXhrUzBBM1pST3IvZDlrb1A0U1FuVEZp?=
 =?utf-8?B?WUtnQmFvRHU4OFRTaUZVZkRyT0JhTy9tYXlkM0NvTGhWUzBRTGJaQkkweHdV?=
 =?utf-8?B?ZjBvQ2F4OWJJemltM2g5WGZOS0tlQTFpREpHQXVNT2ZoM3JrOXZSZXJ1YjVC?=
 =?utf-8?B?SmMycGpVTWd6eXpsR0lDT09iVEQrK3N2L1k0R1ZsNXdPby9TQ1I3SmEzclM2?=
 =?utf-8?B?SVhyMjhTbCtWQ3NwZlpFRWRPSlp1SjRKNFJHbVJHb3RlSm9jOFBKMVZuaS9S?=
 =?utf-8?B?aDA5WFdobExFSlRaSXdXbnBvQ2NYcUVDR3JUZzYvWjgrb2FtaEVQTWhYSjZM?=
 =?utf-8?B?dXFiamU1cytmWlk1VmphYUhOK0MxQUdjWFhyQW4wVXltUXphQTRFdjFIeHZL?=
 =?utf-8?B?Sjc5aFVCSjA1U0hDeEw2WlYwYVc0R050N0dNU1ZlVjBYc0FQMHc5VGZlbFFr?=
 =?utf-8?B?Ymsvemw3V0g3djQ4bExaMnFWNlEybWozK2VDT1FJVHBYZTVnSmlqK2k5azhE?=
 =?utf-8?B?ZXZvZ2ZBRXEwRDlNYmlTL2htS2VpZHRzNm0vek42alpFTW5hcHNqOVdnd3Jz?=
 =?utf-8?B?aVFiUGlxTS9mUzlvVU1QQ2VOV3ZuOWZXWDJpQWdwQzFUMEFTaDlPQ0tqUnFL?=
 =?utf-8?B?L0tvTXVWY3JmK0VHWGhRMVFmdVZaTEJab1pjZ1Zua282d2kwSkZCaVJMSzFS?=
 =?utf-8?B?VzNEczVKbXl5K2Flb3N2MEUrVC9WV091djZEd2FiS1M2aDR1cmx1QXhSVmJJ?=
 =?utf-8?B?TU04ZVUwQTE2RzRHd2VLRkFPSFQvSWk3Um9GRldSamFYOUJOZlJEbzl3ZHhB?=
 =?utf-8?B?ajFkak95YzExVDZueTFZaXpXOFJFRUdpelFjb0ordWxyU0lKaFhldTR4SUdl?=
 =?utf-8?B?dzBnSTduRFdIc2N3ZXJCdmRubkpTOVlnVHlWK2VkK0k2TTFhV3ZUVC9vdS9Q?=
 =?utf-8?B?cEJvM0hsUGJUMFRQNy9nTHRCZmtscXhzZGVVUnUzMm96M0lFZzJFS3E1djBw?=
 =?utf-8?B?TG1vSnZkRzR2bHA0SlJpdnlBcjM0S2tzSHBlWStmU3ZNbFJ2YkVtbTZXcHZC?=
 =?utf-8?Q?VTwYY9IkZ56a1ZbK0yy4r4JvT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jqhB/wL8zBHxFMMDSdtIqJxwoPhzYrTNmhX0rW0wTf+vDsDBhDhEG4mSBv4Yjw/guFoR6MLDz9oFf7ANuefVPw5ngxg60oOy3iG3jusVUgBvTpMZt0W1jyPLqq9BQdHxbyf7pt7QH+yPLoqA3BSw2L4ePNuAfBMC9KC5EF8qmimGU42wrZhNhJCa55WwdJnCAUEEhvEr6bqjYKtQNlmtVSLNeeo94ay26EatCHZYIlrufIFUKN0yZK5p/mGU2U5OH9ihTQpRYVUrLwM7ZRQCNoafhgmwumoMbZU3cSsJW6QX8pab9TMJjw4DoNbg9UFmA6j5XJkSFXAhwPu612s/R6DLHen/kEKl+KBAQJ+ya0Un1HPx7FINfR4+gYPuPoEL54KB1iDXAwVmNr+gD5PWiOjvHP+lfu3N7BjgaLbb+0RpSw8q8j3Glg2mQ8wle0Sf3dJ6RymqKDJpkhJ7wFdGKnOKYKznH1tt8CicCDI6N0KLsO3qsMANHOfp3ZGCvPw4oGSHWu0JO9KFqfywUWAwX6qieBC1HE4ePoakiBoaZCu2jSfIZ6H5bWEfVxKranrb7VGc4w8nDWddo5payW4PPmoKXzirh9tsNs7tdypMcww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e516367-3d9a-422d-72b6-08dd4bc29bdd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 00:08:58.2609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C52BQT/Tq2pCPVt/4eaDP+6VsyUopVmuwE+7UODUj05/PK3Dd2BnzKi+1rs4X2meWtrA/znTzqAc+nJWCc7AIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120170
X-Proofpoint-GUID: s2amUagL-XRMpxyvsiSp_l1-QMoQaANT
X-Proofpoint-ORIG-GUID: s2amUagL-XRMpxyvsiSp_l1-QMoQaANT

On 2/12/25 5:39 PM, NeilBrown wrote:
> On Tue, 11 Feb 2025, Jeff Layton wrote:
>> One thing that Chuck has brought up a few times is that maybe we should
>> consider making v4 not use the filecache at all. If that simplifies
>> things then that might be a good thing to consider as well.
> 
> As v4 stores the file with the open state it shouldn't need the cache.
> Maybe the filecache makes life a bit easier for localio?
> 
> I don't know that it would make the garbage-collection/shrinking any
> simpler but it does superficially seem like an unnecessary indirection. 
> Do you know of any specific benefit it brings v4?

One benefit is that the fs/nfsd/vfs.c APIs can all deal with nfsd_file's
no matter which NFS version is in use.

-- 
Chuck Lever

