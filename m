Return-Path: <linux-nfs+bounces-10271-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3B7A3F989
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 16:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7588D165048
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AB21D86E8;
	Fri, 21 Feb 2025 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FtJDv86+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hFSf2XjT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746421DB366
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153077; cv=fail; b=IWUKM9B8A0/LUbHfBSeCOS7o3KzbuFjGMobngQkGpad0xFhfM/XQBU79KpS5Xu07JeGeA1HEbVDcKuE5xht5c2LG/7UJ1JaI6p9tBEiKWdLaen6N0j967izry+qpB4AOInB1lh9fGfHeLGDjLJI46ttVlWAPcoFTArBhh8XbegM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153077; c=relaxed/simple;
	bh=6+ecrtewPLKaakdWXWsSUb9Afc47tjcXkLngMvdT+hE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eirFa+V+v7NpyDfHONMEcTeT9LnF1dZogVMcABRNQiXaYbIzidG0mPBvIBAkSQGFrlifvPIHCoGbB8k59x/8kK9VuRPxyb5n4qtrPL9SLAJk9rnzJ8vKoCcl35CABz2oX0hR0RypL4p9hPYGtlj0v4HtPWOsIyabqLxt5jSKphU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FtJDv86+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hFSf2XjT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fbOs029775;
	Fri, 21 Feb 2025 15:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7jYU0PQ9nvFYDJ560kjmmLGxwN+WP2XZ/AQiiiBg5yY=; b=
	FtJDv86+sq/0bTwhBsu+SsnoXeJ/jA5wUhzoh0Lc4WEMHsR6exuOqo0lP2G1hCHP
	LA468SeV7H0AaneAUllaT6MGBamorNFedOB6wsKkzbSylZDmDaU+74m/iCUsJCTP
	k1O7NtuJfnxIDDzwGgTiy1Lwk7A3617msqfslbtNxnuj6FgfVgWSBCHFvRVbXjne
	x1g75pyrifoyiU/7Vdzdoa07r34hfNGh9QKzxuSBqhjHH5qfXXk9zBGFu9AOvEih
	12HbI7DSaHnPBYXudWDiRUkZ9iGD/BBr3hmuIiAokrRvDD4Z6tdU4/qiyi6+PzVb
	E5xVyHh4zhL9HgYauzQTvg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n6g9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 15:51:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LFkmFm009776;
	Fri, 21 Feb 2025 15:51:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w09ft535-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 15:51:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2nAQjw943bZ4KxgYpQ16sGOlA+x9tR0oJFQ1jpdtxkDtkoSzU5m5fcSWnUFPOMOCamJnDKl5V0s5iz0IogYHo9r4UOQZwexh2XAtUjr3Fbdx7Q3qOhviOU9wfVsDRZ3+xnQSA42EGZtL08N0ghgjB4SUaN8406oPO59SRAD9H16wAT21jF9RtpmK0DCi3UUx2qTbZIAlptSZZhOPJ8nPjyjDtKlNDbHNQT/cA1pELv/kLylGGT/B+cUmY09x3KZck29dlUSxNOv6+ubmxmWUx0BHayHF/UjuYAyWMU1t2Xkvrxp/SghmtE2b3gknr9HdwXdFXdIAymQvKgvXjA+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jYU0PQ9nvFYDJ560kjmmLGxwN+WP2XZ/AQiiiBg5yY=;
 b=ogKbw68eD+QuET+h2iyaQGRviALaTLjaOfdKJM+HqhvEpprqoYsKl4Dqr27AXW6ZsAXrlZuxbTuaGMtqh0TqAyCXZao6LKRHZKb+qyDtur7HzRrdXqsaWg0G2yi5X/zDNG6+WKR29+nFKD1sPp/Dmvh51/63O/+Z5pYztGhCYLa7hyxjdWdrvxWQo/EwaWd9N/tD5AX9BILfKOLH/gMyZApHQzY/9bVLjKbbDmV3aix2zcrrJY2XR32MnVW7FEtxC9Z1IpnYR5XEcE9rgicBlqI0sAQqb2oUSVtYP+gtlH6pcA/lVVNcPjY+dFViLxyfcc4bmsB3rDcvQsopijybgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jYU0PQ9nvFYDJ560kjmmLGxwN+WP2XZ/AQiiiBg5yY=;
 b=hFSf2XjTF/3BkBUmxdJYZK9Br4e1IyxK3Z8nYudbrB17DtfP9L6ugj09zZlCCnN2BuJeKaP2vbIe6rD2/WAgwmosxhgO+Q3OUKtiyWcgQQMbes5OwxHYIdQOCxDZO7rPoIywCl+iMqLnNsrmhM5Fs5MzFQtBVHYyn98HZVrr0GA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB7006.namprd10.prod.outlook.com (2603:10b6:510:285::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:51:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 15:51:00 +0000
Message-ID: <428799bc-c4d6-4c81-a6bb-bf8a16aa6bb9@oracle.com>
Date: Fri, 21 Feb 2025 10:50:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd: add the ability to enable use of RWF_DONTCACHE for all nfsd
 IO
To: Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, axboe@kernel.dk
References: <20250220171205.12092-1-snitzer@kernel.org>
 <ce92e5f6-d7cb-47ef-ad96-d334212a51f1@oracle.com>
 <Z7iVdHcnGveg-gbg@kernel.org>
 <64d7e00d-e025-481a-9145-7038e9ee7fdf@oracle.com>
 <bb0c5102c1004b896a8d3350dcbea9ba7a8accd3.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <bb0c5102c1004b896a8d3350dcbea9ba7a8accd3.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0009.namprd18.prod.outlook.com
 (2603:10b6:610:4f::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: fc416eca-2d5b-4193-8dfd-08dd528f89f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHVJTWsvV2JwQlI1WWNHODR3U1ZlblZjRS80S0NYSUU1TklCbWV6N2UvVE5o?=
 =?utf-8?B?dGlCb3lNTkRjbXM4UVNwZmFJRnR4eFRlWXVhYVRsaGNVSkxlNkNHeVJWNzNi?=
 =?utf-8?B?bHFwd3k4WEk2bFVxSnIydEpkaXgvc3lJbWZ0TE5zZi81cUJvSHdtckRaYVdj?=
 =?utf-8?B?ZVhGaWczSzExaHR3aFN0QkY2bDFRc01QSy91T0VzSVhPNEY0Q21veko3bUpG?=
 =?utf-8?B?ZG1PcEUzNytnMGduM2RobnhMZlBaNnd1cSttYy9ZMXdpMUloalN1QjRpVjRB?=
 =?utf-8?B?WitJdGFXWXhzZDIwRlh1aEF5ZnJtWi82THhrS0NZTTg4NVNYME1EcE9zSnkz?=
 =?utf-8?B?MXVnTU5ycG10cHhTL1dqT3VUZkZpV1d1UUszMzRQc1lHL0xSRllMRVRIYUdy?=
 =?utf-8?B?VnJCSU95MHBUQ0RYMU5OZXRLbEZGWGwwYWhkSUtIOVI4UFBBUU5yVXJFdi9v?=
 =?utf-8?B?Qnh0TWxaUk1KVU0rWkJmbEdnV0V1aUR0b1dDc0dhRDlJcXVjdDNUYjh6bnJa?=
 =?utf-8?B?bzllc1c4YUZiNnFvRGRNUXFrQU91bHEvM2k3WGJJdjh0eHZhMlMwSHZXK25R?=
 =?utf-8?B?ZFhiT0lsS0xtaHpxbVlrcWJYWlRjcHY1OHR5M0VnK1FZcmtvMHVBNmtPOGJR?=
 =?utf-8?B?T3Nla3VMTGhMUVRhdHVHbVNueG5SOGkweCt0cG13aXFpRnRpbzRscUZRS1FM?=
 =?utf-8?B?U0lXWGt6UHlVemE0djFJWVIyMkxFVEEzMmFrTk4vL0lzQU9pYWhEQjBQTHVq?=
 =?utf-8?B?K21VMjhqcmdoTWtjbnhIWWd5NlZjT0ZWTXcvNmhyV3F6WGZBNHlIUThBWXBk?=
 =?utf-8?B?bEc5YTgzUjJkakxGTnViOXA4YzN5VlNCSER0dkVMMXVSNmIrbGtLdGpqQitq?=
 =?utf-8?B?bzdvNVE3enN6Q1pjWnBydFcwTGxYaXB5RWM3eldscWp4Y1NyYmdKK3NZSE0w?=
 =?utf-8?B?L1JtUDhnTVFWT0draDF4UWdKWmpqY0dETlhiTFFXSCtJWFFqbTNzSE1oZ3E3?=
 =?utf-8?B?YTlKNVJ3OVg2Q1Z3Slh5UllkdDliSHRrOHI4OXZUZXZrWFp4SFVDSHh3MWZ5?=
 =?utf-8?B?QW1pVWowdjRBYlVYdXhhNmtPNFNBZ2FYbFI0QmVreHE2QlRHejlKbC9JSEgv?=
 =?utf-8?B?aENOOXprOU9WNEl3N2pwNlBFOHpIUHVZQzZCeDAyMTFGOVFhV080WTdhL2kw?=
 =?utf-8?B?OXFwVHltSVNDb0Zjc1ZLRGxGVHZ0aDhUWUNWNFZERjFTaEtpTTBzRWpGdWhu?=
 =?utf-8?B?Y0FCMEhWdVd5NHg4SGFxblhnUzR3cURzcXkzRnZ1WlVpWGFwWno5bTVweFZm?=
 =?utf-8?B?VDZxNlBjTzBPR1hWa29xL0psZkw2Y0RkNEVzTURwVDlJNTRBeW9GUCtpV0JN?=
 =?utf-8?B?blhBWjJ1WFQrQk1XYlZNOFZENUI2bGJ2VXloMTljSFJCYWFXUGwvRmFpQW1p?=
 =?utf-8?B?MGxVSzhkaUtDOGN3T1RRZWRQajBZYmJ4bUh5YWtuZ01wbGd1ZndvSXZhMExx?=
 =?utf-8?B?SmM1MFlEaXdjeWxrRGZnajl6S2x5UElNamQ3RmpxbTMxTlk0eElnaWN3NTRX?=
 =?utf-8?B?ck9ZVXAyNlk3Q2RrQ2lQeVQwbVZjNzFTOXc1bVpWZStoOFdtVWFKZVpxVHFi?=
 =?utf-8?B?cHdFS0svbi9BZkpVLzViWnh3NDN4QVArWTcxbTIxM0I1SnJhc3hVZmtTUndM?=
 =?utf-8?B?aUFPNEtoVmxoSFBua2JTM2o2SE9XQjRZZmR4c3l2bk9ZQjkrWWhUNkpELzN1?=
 =?utf-8?B?ZTJyODgvYytqVjZCZVdPNnBsbDVDQnNqKytNUExKa1RNaEtTY3ZOOW5rVWFh?=
 =?utf-8?B?VExJMS9yYWN3TUZ2ektLKzRiKzRnblcwQUZKd3N0VU4rOUIvNlBmeDZzejMz?=
 =?utf-8?Q?HMY5lFgBNjual?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzJlTjhHclc0QklSb09UcFZOUE5odEdTT0gwSUplM1IyZ1gxUEJpb3JtZWxJ?=
 =?utf-8?B?eGN4M2JKZ01BclIzcUVONTBMZWFFRmlzMkgycUhwZjdiV1pSN3BXbzFBcTJE?=
 =?utf-8?B?ZVVLSXhiTUhzcGxHMUFDVXpxaGMwVjJZaGtvSEFqOWdBamhMdlRoSWM3R1pJ?=
 =?utf-8?B?dXpFT3Rnc2s4VnpoTGZiMmtYRTFxNFRxUzdHWG15c0d2bm1oQytiMlVGaVB6?=
 =?utf-8?B?NHNZWGI5SU9XQ0tqTnBPTjdGcGFldHc2N1EwVW5td0ZrT1J0NTYvQS9ZbVlp?=
 =?utf-8?B?aXpNNEY3eEVSK0FvTWozVDNHdVNkZlN1RStOYnBnR0x6clRKS2k4L0JvTDk3?=
 =?utf-8?B?SVZYdFhhcDZNQWc0Z012T1hxbFlQVVdUT0dRUE9TbTl2bjdiZVExS1Q1by9S?=
 =?utf-8?B?am14dXd4cjVody8zSVVkeFc5cVNqS2dMbnAyaWhkZnhGZmJpdGd1OWN2UlM3?=
 =?utf-8?B?Y09nVnpjRHRMaEhWdEIwd3poeTVueHdFeVhnM3JVbDYrbXRpZ00zdlhxQWtr?=
 =?utf-8?B?OUhXeTdRZ2FTQkVURVhIa2JCc2I3Yml6NUduTzlkT0xBdjV1YWFocWd0UDhX?=
 =?utf-8?B?Vldkay9sZmo4bWh3TFJ3c09WbFQ3L05aMTZYTXc1SFNLWlE1ZEVqR1AvQkxD?=
 =?utf-8?B?NzVaZjUzRVNlbUJ6cXZydU9ZWW1XOVMrWG5jUHIrOGlYMXNQclQ2c3I0enc5?=
 =?utf-8?B?THBQR0FiaU9FejF3TkxES2JtTDZ5b3VWcGJHMzFzTERnRUg5M1ZyaTR4L09o?=
 =?utf-8?B?cm1yN05TczFMaTRPY2ZlZkRGK0tXMHVYU2Vtdk5Bb1YwWTBkSWFHSTRXZnBV?=
 =?utf-8?B?R3V6ejRPMDVJamU4dXE1eHlzZGs5dE42ZWZTUjhxckNHRWV4blo0YXVuU1lw?=
 =?utf-8?B?cW41Q0FGYlNYbFlobkZSRlJqenZEeVA5NEpBWXN0eXlTb3hmcGtFVmtPUENH?=
 =?utf-8?B?TERqaWdSVVZ6UGtDNVl3T20yK0V0YjhFTTlBVHNiRElGb1YrTnpSU043azlk?=
 =?utf-8?B?Q3oySmYvbWJ1WXp5cHZzRmNPeURxQmZnMUZiR01ndDdWL2p1WXdVa0VVUGN0?=
 =?utf-8?B?b0hNMjRuRHppeHN2K2s0R0tyZHV2R1JSbmU1Qld5REIzamdaMVdWNm15bzNs?=
 =?utf-8?B?RTUyT1IyNi9uYUdiNGtVZEpDK3NDelBmdlVpRFdub1FnWDZoWjdzS2tSL25k?=
 =?utf-8?B?aDhCVjlyOW1qNUZwVUo4emgzdFM2V2wvNFU4eGhrUkdnem54bGhXM3FnNGkz?=
 =?utf-8?B?VXdVQVVrR2J4MXhqOGJvNjE3U1ZrNThBYSs1d2ZMcUI0UkF4c2x4SnZ0MEd2?=
 =?utf-8?B?ZHM1YUxKOXFkUEcvUmtUNjhJeTlTT2xKTkZRUnJBYjJkejBIck5PUjd1WHYz?=
 =?utf-8?B?TllZMnFpdk53TXhNSHRIWVU0ZXkvb3g2cFZmdjIwSWZaQU05WER1NkdRbUJq?=
 =?utf-8?B?YXJXOWNQSDlnSng3a2JoUjZ6d1VHbW9HTmRFV1VlSjd1WUkrYTVRSFlIa3Vi?=
 =?utf-8?B?dzVlb0F4WitWbC82dlNIbmxkT2tvQzFVOXBpa1lxQjI5QkVhaWZOK2Rkc1Vj?=
 =?utf-8?B?eEZxRUQ3MUFaK1FQQ0RSTkJXUDE2cU9pLzZWK3V5c3FhdS9RNDVkWktCTkFy?=
 =?utf-8?B?MXlKUElxMVJxME5Ta3JweTZ3TXhRblBWQnRja2FKSTI0STlzNWhBNXFxTE56?=
 =?utf-8?B?bFM3MGJZNUJSK0F5Z3NGNlJCd0VnSEw4V0h1NXlraVJKQjc5S0FvY2grNWs2?=
 =?utf-8?B?NVlrSHZLMS9JVEdkSE1ZZlJJL2xtdVYzK2cwbDY2UWZKOGJyS2xpakh2VjV2?=
 =?utf-8?B?TDBNcXA5QS9IM0xSeDlwc2xmN28ySkR6N1dyeTRYQ2xDalFYM1hCSlBmNWZr?=
 =?utf-8?B?ZU01VVowQmVrOURSOGZZWnhZTTEwZ1cvcVUzTWhWbVc4RU8xZWQ1dURLYktO?=
 =?utf-8?B?QXV2SUhZU2lLdzYyd25ObEd6Yk1WUTZVa3NUWithdFNFOXF5UjR5WDlCYS95?=
 =?utf-8?B?WWl6SHplRHJ1SDRwZTB0eTR5WldNTDJjRnRPcXBhc2JHUXp3a1JFV0V4OTRX?=
 =?utf-8?B?L0xZajRHcUlUTFo0V3ZmVTY1d3dRcUNkSUEvdUdjMDc1RVlUWW55dkJTU3Bo?=
 =?utf-8?B?Y0F0Z2NHZElTV2RUM0ZyQSs1YXF3NEliVy9GRHViNWd2bjdCNkw0ZmFSTXR1?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vDhLLZkSWyZzYicXHL5bXFZoCEklP0ru01q8aF6pRID9siJXcpyXADKM3tefnzCFeKOiHL0KW3lyaQHRvGfQa7bTG6mONg6dupDbD9fPW9jbM04xWUZ1lNiVxXyQ93p74KQe3+ygBS/AKojK/nCf5J7TU/mid+vwc71dK50XngebR2eGsy9QEFp45ElAL7Y2GeMc6KKmgzFteQL5V1rsJyhnS7OP0F8jj/wuX1qjE1eX9klH6d8f+yGwdzRpy+xny8eKdBjHF6rGOUYxSGfLO7IOno+NzD1wLHEMOrH8yyGI6vbmGk7SHSzZzUQEgz7bAn8Dq+zOCYLlvvf23Twi3AGymkNAicB3oJ/7lQ8YMb5/wNRmOuCK3DLHKnMag0Na+34k2DzeFOSqjEUOcEpD0WQMkUt78eYgYu4poy9AdGgGqYoUtZHkXLtqRBxipy3ExbrBQQOA3l8yu0VXRgmYvs8bqJSm4iKxTMMClke9Mcv+COmE/lwy11kME1O0t6lvewi7R2rGcIHYnDy165Lkufw1UWYbIRXX8rLfDaKmo20Hs0ETy+5B9QHvZA76z69cyK0FALMU0B74A2KNMgEInmzQaweEsQeBQGn5M0fUTJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc416eca-2d5b-4193-8dfd-08dd528f89f5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:51:00.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAr2NlrU0ISKJ8bJ9J9TDSbsvLMxJSls+/iS3lq2WY0kzpFnBBZOE7t6KUAbPumsusO4fx9/3C/dylWnqY93hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=288 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502210113
X-Proofpoint-ORIG-GUID: QlKvsm8sb_bKuOybXoIDPuQq_Q33E_Ac
X-Proofpoint-GUID: QlKvsm8sb_bKuOybXoIDPuQq_Q33E_Ac

On 2/21/25 10:46 AM, Jeff Layton wrote:
> On Fri, 2025-02-21 at 10:39 -0500, Chuck Lever wrote:
>> On 2/21/25 10:02 AM, Mike Snitzer wrote:
>>> On Thu, Feb 20, 2025 at 01:17:42PM -0500, Chuck Lever wrote:
>>>> * It might be argued that putting these experimental tunables under /sys
>>>>   eliminates the support longevity question, since there aren't strict
>>>>   rules about removing files under /sys.
>>>
>>> Right, I do think a sysfs knob (that defaults to disabled, requires
>>> user opt-in) is a pretty useful and benign means to expose
>>> experimental functionality.
>>
>> Seems like we want to figure out a blessed way to add this kind of
>> experimental "hidden" tunable in a way that can be easily removed
>> once we have the answers we need.
>>
>> I'd really like to keep the documented administrative interface as
>> straightforward as possible, but I agree that having a way to
>> experiment is valuable.
> 
> We do have this fancy new netlink interface that is extensible.
> 
> You could extend the "threads" call to add a server-wide boolean for
> this and then extend nfsdctl to set that value in some cases.

If we don't have other options that are more familiar outside of
the NFSD world (someone mentioned debugfs), then adding a netlink
operation that is explicitly documented as "access to experimental
temporary features that no-one can rely on existing" seems like a good
alternative. We can make our own rules there.


-- 
Chuck Lever

