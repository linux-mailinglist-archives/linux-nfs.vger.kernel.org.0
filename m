Return-Path: <linux-nfs+bounces-18469-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDu0Ij5md2nCfQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18469-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 14:03:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07003888F6
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 14:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3147B3015A5D
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996CE329E5E;
	Mon, 26 Jan 2026 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WBSzRrSL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R28GVNEZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C07192B90
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432634; cv=fail; b=rF/3kS1vQ+gSLXpdHVNnnaqbKODEBe9qw1AlUa8eU+ToIY/gAJ2gAVExGtsMEcKvNZNJ/6TJqmp+71HMYsKQRni9zdGOvqdrPLIxLXQ8TWH2nAmkZNwpfBIHQh8KDjrYD7wnPcFZhGwonqysyOcGG7Pv0BkWULCTtVauFOpKQKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432634; c=relaxed/simple;
	bh=tlGCeF+U+f4m1S8DrqMXQzO+kOYXtIKKmgN6lJa9pHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sK8nkfIKTwlkH/dXbWj7Xv5qOAmlY6Okj21hWY0pZQTMxb6KSMvSs/vfzzqaliQKMI/OA2mqYwa2JMWbix310eFWvh2iqclJBhYj1MwdHQCvCg6KAONXw5W2ZMmaqz04zgZDy44O9RwWB1rSHZouno99mcrbJGggMJb1FaodPLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WBSzRrSL; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R28GVNEZ reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q4x7he522655;
	Mon, 26 Jan 2026 13:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5iRO7hYgb3RZI76IYtbf2blkI8taaFiU8foyX1gk4bM=; b=
	WBSzRrSLXRxR1gNV8CRsDOaRJJ+xoD2qP67SRB7R2n8pALv/qbpJmQ07HdhQiO2J
	LtiwVHztFa89ND+gcNtT1eeWNHhTOHJfQhw3vQ9LWRNQHLQsOFFIVIgdZb0wn150
	FCPChWjYIp4LZisO3KD0KD5FM5u18iKX+tzomEvGMkFj4ScimI1PDMUseTdNY/59
	wqqlhsSRAouIrliWTltSgTW9B/VEA2fNouaeZkmPaYQwVO0x6FU/V7EmFn04/i81
	crCgEJ1nGVxd8XbtlBj9eZ4FiQY8bGkto41btWTZgwdFLVTxXYckB5QOXjh2CKcI
	js8Hho5rjEhunA/Os6nr0g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvn09hts4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 13:03:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QCaqHi032705;
	Mon, 26 Jan 2026 13:03:49 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh7wpwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 13:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jt9EKdXs/KUdqDHLrbvAOPEdCGmCwwW/yUbID+tokLlOLLmulnZjI3GYmAif0pZm5xBsfhDstjr5oTN3TtwaVbyCv4ipDPPiUPUduTtAlY7ZCQf/QxcBcWg7zK0sbwmGA9Vs4/bmFkP2XTAXMjY7KZN4T0iez9N+1dxSpmff8Ju13TRqD+vHvEzv1v/K07LhcotMZ+K3qT73WseZXBeE5600GaWfmrWTCKh+KXW3M4sv6ZTIGVec6melbC0FHlj8k3reBLv+IBbjT8Q+yNmlQ/qYkU560B12wQMlinTxX7r/Yo7PLYaW4vOT3Peyd9WkSuPWas5p2bBR4SaO9NKFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kw/XX+QmUeyVrazVFXd7hvRrOnqyxCkZOe4/juvjYmQ=;
 b=wjVXtXLdqIrSCjNgwhJj1J+JkYGaftc1Zxrd94+FTUep9iyWn1zNFO9XZ0jqwTqzvdwqfWzy/XVTzL8hUgNCBlVxOWDv0fRMw60BXwedcqBfYbxYjIDH0IHDcBp4g6/MupzbWCaqWu1fIOEbvUlMd5tysJ/gCEliWDQvkenbIX8AxrSZshDUCcqkbeLcn6EEebGArwYP5KhAzOVQan+sMa/X/xcLdX+zTMmb5pn1LPvdpFaWR0RFDeGZXp0Sf68Dla7d4mCZWSwzJQBmEDkyw0CZIpv7u9Kasa2NFFiCi/q+NLP7qZyOmRv14EZCvm2zoFrw+LRm/AZmnug44A2VCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw/XX+QmUeyVrazVFXd7hvRrOnqyxCkZOe4/juvjYmQ=;
 b=R28GVNEZNPv922Hkmc2qBhGIm6ISW4SDcpKcfYmRYgKNenNjzjymPlIvOWUi5H/LSabRRAgkZKa+62ZDUJGoXsgXLfr1O6ddDcOu/D3gTDA80wXpmhQdTaL5E6DJTCMg4AJ+c89HmCgeHBBtYS0Rc5539YZ82iODxOZIpO/Lpfg=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Mon, 26 Jan
 2026 13:03:43 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 26 Jan 2026
 13:03:46 +0000
Date: Mon, 26 Jan 2026 13:03:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/5] NFS: Protect against 'eof page pollution'
Message-ID: <8b0b3a40-008a-435f-aa01-75668c22be62@lucifer.local>
References: <cover.1757100278.git.trond.myklebust@hammerspace.com>
 <a753650aeb789a1a3f2a748bf37415b92615382b.1757100278.git.trond.myklebust@hammerspace.com>
 <4a0a8181-b0b5-4f2f-84e1-3c935273b7df@lucifer.local>
 <7c86e2c3ec73650696579a3e03be937a8b4205a1.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c86e2c3ec73650696579a3e03be937a8b4205a1.camel@kernel.org>
X-ClientProxiedBy: LO4P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA2PR10MB4665:EE_
X-MS-Office365-Filtering-Correlation-Id: 14faa112-9b79-487b-536c-08de5cdb56f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?IwnRuUmJ241l04VYRPAhkezLMFNT4kORP3CQzarWJM88gefidHcLCO7Ulp?=
 =?iso-8859-1?Q?fVbN+bEtW6lwoxspb3kiLZ/rpQQux9OAImYWIOvaqHK2WSkbDxuUABpriU?=
 =?iso-8859-1?Q?EmXN+OsLslh0lwEYu1Fmxnqb8EU3VHbGpxxK0J3Y2CGMvzl9oa0hv2cSiF?=
 =?iso-8859-1?Q?4DS4IHc4KMsNwSUgA6LWtsfqFHtv2bmnkemn1JoGckeeS/aRyJ1YpJexhd?=
 =?iso-8859-1?Q?+6no2Tr06H6ZoVcQMZBQmi/1dRsxuhF6BEuypOvQa25DY3IHAMzzKeA3tn?=
 =?iso-8859-1?Q?VlMpqXfjBgNTDov88AYArq9cL2LOOXNajHkH9xlOX+Uj9W2cpmp1VJ5Slv?=
 =?iso-8859-1?Q?GmgliQvBl4KU4htqtDuw7Zyut3jcDVTuP8t00FaTtpPoPri6liMZM6h4bT?=
 =?iso-8859-1?Q?PhqxGDSCie9xeQhV4J/6Q2y+wX8RZOUhEMQzDRKukWQZLeiNGjncZgxUAo?=
 =?iso-8859-1?Q?2KaVmj+v9wyxbJd7WnDS9MPTrXKIFG/Flq48eDmXGSpcQ26i2OVUyNQ64w?=
 =?iso-8859-1?Q?rfv9BiXxkZyyKkr7D/TtGy9F+8BnLRhfJ9VUuATrHxtDsNEb7GNoZtYT0R?=
 =?iso-8859-1?Q?SXztZQ+ohewfEaU+ttaEJloitm891HjJmqxdEIYqasfmfdtGh9wVXOlDIN?=
 =?iso-8859-1?Q?RtcfXZdGS9o0eusuC2yIumPF2tstJ8/Ay3j2mIFcxiuW5LBhnWP3VyvcfK?=
 =?iso-8859-1?Q?0gbSw5yyZ7c6m8Qm/pKU5+mvgaj6BNmDI4X0WyqfEWtqVpRvq7lkkKZ4Xq?=
 =?iso-8859-1?Q?OUmHsFcaaRI4dV9bbmg7OTsDjxLHv51drha3U7/Vknn6xwONlf0lnHtEpu?=
 =?iso-8859-1?Q?uBR58x+Xz35wgOAfi3K/TldDtk8pZEXI0sysvl80ysHoEoh7h0ANXY3oc9?=
 =?iso-8859-1?Q?tCciiwALidtDbAfaTN0rtXYDotEz03OIqRSoLqbjCw/+3ywYwwugDPY2QV?=
 =?iso-8859-1?Q?DaEtwNuGBIO4urdiN8mrnrJJjl+rFVG3QbnHEbw6t/El8PtWrLwSu2H+AC?=
 =?iso-8859-1?Q?Xpvvw3JpH8CNE5nC3KCc7slVv/6Ex4kfNdSYKkz2q0eZWr9kkhWSrr6HqP?=
 =?iso-8859-1?Q?moZQmaGMegGvPSCXn9HMG3yRlmVNZPwVGzS46a7HkxL7+5ogoRjMsN7+Mc?=
 =?iso-8859-1?Q?Ce0oIN/bQAm2PDGhUk6+91Do0wspOHj4I1IK9ZKVhEc8riSKBDBqZ/YWKq?=
 =?iso-8859-1?Q?9jTfjYwEZ/fDq8CCca8hz1CTdODBsttuQTJIJqPe77RGegj0t08lF+DgV2?=
 =?iso-8859-1?Q?Eel0Ts1Ylb1EDv8jCXEGSJEJ5P1BmQfmx1vWh4SJShocdgeXbbs+O/uF33?=
 =?iso-8859-1?Q?w8zHIygTfs+dLw+yUlNfRXYSvbIVS4CXrihCwqq/CCah6havFKqwyhljhx?=
 =?iso-8859-1?Q?3qnrjTbBC6LSpJ2eGFTbEqh3sN0xNNOJrm2tN+v+CyI6p4YX3gA6tHr1I3?=
 =?iso-8859-1?Q?xCX7HcZPsGSBNPBetukg1+5I4rk/BchKFvhJtugKYKsuG7nFr7hlBibYww?=
 =?iso-8859-1?Q?dFjsBTC3HKCDObpMwoGhvzrclKt6wbqj3Y8EyfzRz0DpwMod+8XFtIjFfM?=
 =?iso-8859-1?Q?I57H0KuGggmDfb8C51pREBHUl7i+9m3igKIvRSTRgnHwBSlueinkUl5cW5?=
 =?iso-8859-1?Q?AgADvz1dRAR8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?V4QhwVUP6hm0qEH5rhNj2qvPOtc+Wbyp7AnraCpeT1KOdxKAVHOeoZXYRk?=
 =?iso-8859-1?Q?TmUdWtGhRCN7XF/gbK5lNpUHvfYOYCc+2JspPB4JbnUczm3Z1ZxsF+Dnp5?=
 =?iso-8859-1?Q?TzSklgpC+2t3P0EFKDVJv87Mv6h5nUJBTrexqxuiUB+B1Ev/zyNv/UX1zD?=
 =?iso-8859-1?Q?wyKWB/lIyNkLuRTUPvH+C8JUkRkHsTJTf/+TszKFAT6lW+nhZtOxBtvkPK?=
 =?iso-8859-1?Q?JMhOWc7AUCwiIcpXD9ZwMgucNoqRS0Tjk4qhj0rZRLTnndryqFWWF0Ayx8?=
 =?iso-8859-1?Q?uEsFp7U7hIkqcR808aZz/8ZqEEMIEA3epkEqUdag+J1svEkM+1TCSnJGSc?=
 =?iso-8859-1?Q?TPhlS5LDGuXQvgu3dNoTASXpBlbMcC+0gjmAqPzEw7oKpEIZ9hHJcTv7Sj?=
 =?iso-8859-1?Q?aRFpljR37aSoP3vO0G1LkAHjGikAN72KmGoXfOVAqo+oyElAA56a21aOsL?=
 =?iso-8859-1?Q?fnjwM50sisdsnUG/78EpE5mRP/jW4ex6aMi6tCBunthQwPxFIHujgYyKoZ?=
 =?iso-8859-1?Q?2cQ+Db09WZXSzhCEHvjDI+kwgmwsaV4653lYmLo1glGs7K0iJ5huOH3Y66?=
 =?iso-8859-1?Q?eqgbJL+qx9RWe+Q83LR0iiBR0GC1jiEOpVd9lVq1H0xQkHqC/GoofU1YEg?=
 =?iso-8859-1?Q?tcA7yc8VQrsuPG6wD0ATtO6K+btSS0LFn++syD/Ue1zJGRYR8QUE0aXdBc?=
 =?iso-8859-1?Q?ZW6KRBZ/KR/dg+BRK2tXw1u+f2UL6eEb3LahdleXT5j/Nfdo4I4RRFxjRi?=
 =?iso-8859-1?Q?5Pd/tsOTN0/jpa6bWqa6jw5MqaSSjekb28pBKYWtoca+PtGQerInC//7qt?=
 =?iso-8859-1?Q?HfYsBvnOV9uC5ceCWMAODssTp2VQ7zmk3gLZdINa8ntK2J4Lwfq1mqvYmH?=
 =?iso-8859-1?Q?dK3EQl/bB4vdJWg33AQRQawnyovSNqUd7DovfDcQA1IFEED6tkDZMt/Fhh?=
 =?iso-8859-1?Q?ePo1iYSbQzvLuiRfIeAM1Rhb/4ur7CsZTh4y2VJ/bpU/Nj7HyKXwOEk4yj?=
 =?iso-8859-1?Q?mmmeElbhPbxFJjnAKsd6MEozcMxyo2KKS3DD8j69DD4Nm4CexqMszwhqI0?=
 =?iso-8859-1?Q?x57qbFFADh/iqFPJynFvkOdPazDm7TGTZSc019rsksZV/TIKrYYSstIas0?=
 =?iso-8859-1?Q?bC+iLyklgQRFGau+LeOg3cX0tXAPsXOhtgSG6ZY4sxwyyQvWzZUjnDaXvD?=
 =?iso-8859-1?Q?8W79hauvuOnxoH5yb2Ei2FVD4a0HaFedb7VsrxDBwQbUrZH/viTEJNqQgw?=
 =?iso-8859-1?Q?2hrvZKu6YdwZLa5zCsjfmyC0Q0qGIQqUtg3uAxkSPBMvLVH2t31zfZ/XT8?=
 =?iso-8859-1?Q?5FvkM3pR0EIOQ8/7g7S0nC9uoaf+xlx9p+oWI5Uqxxl2EPeCyy2kqKi0AJ?=
 =?iso-8859-1?Q?jiLq+eKvm5j3XlMBlb6hlKkSyDzAJUhPbXmo5GxmL173sRCSsAo0Q3e1ur?=
 =?iso-8859-1?Q?NavB1oXxtkqzgczu53CjhvNNo15WKmSJnEMV5QFh9S/WHMkGCQ8uFkKdW1?=
 =?iso-8859-1?Q?jsU9mKbrNkPeW9de5UWV37Y15Bk438AWYigmzmUNmxrLTpGxzKFrRrx+e9?=
 =?iso-8859-1?Q?zzjbZKNwCAH0eyaHke4sRg+9awKJVeaRoiMFF1fzu3eOnatFVd09Nrk3Zb?=
 =?iso-8859-1?Q?EFLu2hCSmcvpjOp1W11eSRASDEYOzUxGTXXMz2RdzZDfZ2xZqbTlCMGk46?=
 =?iso-8859-1?Q?2wHIx7ufo1S24KhgSAEsJ8rXbXZ7+C/xxgY1rItTINGFVAD6K69GA/4Si0?=
 =?iso-8859-1?Q?RSHBBPQkezH+wKQKE4GofwFWGI51VFVSqFPXZzeHR3Zgo0OgDdq5slvpAp?=
 =?iso-8859-1?Q?CLv018j14K+idtXQLj4+GsOq1LZ4D0M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cTofOdquelaLWI8BvxEqF21RfEgDHZ4VUZ/ZRKp6QYZsmZ5ANci4o7Ot6hWS4rOU1Pou/XJvC/zAtDTuWJ0NZzRZY+lm7ZqQ5IONvB8FT785olGcG9050szlh6QDrNSA3hVJ9UEYwvlQe8IGgaeDUmHyDXsz3mwQokBg4IUyoLaJv/LvtZT9A1guKp585X3qXE7SIZtgK/zJlQwgO6doXWRqxEq7zhgYs4cdtJZmNRP8OLYUh9O8QrvTtV0AAF34heMrfzXxoD2+Ayn0jqEJo09y6hpWi+lOUrGZWq0AzEovL34zi87mMWBp6VN2bNMDqgvIixf/hYeXp/S+feue94PlGxVoVQamjMeZghYRVcNFRUOC/ofkISDOdI4U6jOSa6ZXopRTYqlHlYhCsm0NGX6GxX8TTo3Q704mo/8DvYgJUL+QzWTgTtK9/kzDlN0EKq4q2y37Lf0cpDgUJjEUSRsMozySK/wffEs7CF0NWVB9szcBiCFMFjTbjSd8k4cpN4OeW2CjX2lHms7sl/RQlft2TubiMYxQJb4bFh9BoP3E3NLh7+maXCtQ5P2T5de9CoOyj6WSQKLDzgVrba/EoM2dUFTVua5BK8YlV1r9ktg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14faa112-9b79-487b-536c-08de5cdb56f3
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 13:03:46.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVrilsAlQJnclNWalnYOvzx1VHCH6HjeiDkWY1fOvt2UT0NlQumtwi9QbqtJGgPW8LveVl9BBJtQvxeCnySE4teHwufdabOdPgdZWIzIguc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601260111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDExMSBTYWx0ZWRfXz/KDsNIOi6vf
 LnMKVWypAxz1u5eFcRO9Zs2HflOTc7hv6TgSxxhWZA1GlcnmceG1sRIJoWo7zKkMo67V2449eVI
 peSyVLWSfB29rxJyPsDrvSXXG6S9OBGa3mEgbLk+Wk8WSdlrffMkNl2Twgo2dfo5ascaCHAYuHu
 rlAenfTDhtgEbgLQdUvUVjquG626YZ2Sfm4dyIFXNuBkYAsVv4RCXusuQaMvq84rNzzr37HwBSg
 IKZDK5kyk4Hcezk3XI+mtF9Wk3UuxZPPq7vYxW8f5S9liLC+qzs9Zbv+eibLsZsTGpwwo563sKA
 yQMsvDh85cenFWUrrEBIlyfIWFrJ21GBNbI7JdOnr1A5TNLBlYMVTNJabyabHVHIQrFh5NfYJdq
 Mrga9XDW6Sv5pvRKhmAp3XxtdGiElhVxCq8tWswYhnIlsMReXY6QNFGec5rIM3txPIdv4Xyk+/k
 tPfmb+nJ/HndIpOAcCA==
X-Proofpoint-ORIG-GUID: vYC3dkyblavqta1lN63uaUw3Z_xqIIYR
X-Authority-Analysis: v=2.4 cv=Rp7I7SmK c=1 sm=1 tr=0 ts=69776636 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RqAwqL4BN2GdRpRTKnkA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: vYC3dkyblavqta1lN63uaUw3Z_xqIIYR
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18469-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	R_DKIM_REJECT(0.00)[oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_MIXED(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:-];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 07003888F6
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 05:20:19PM -0500, Trond Myklebust wrote:
> > > diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> > > index 86e36c630f09..af2fdbfcbbf6 100644
> > > --- a/fs/nfs/file.c
> > > +++ b/fs/nfs/file.c
> > > @@ -28,6 +28,7 @@
> > >  #include <linux/mm.h>
> > >  #include <linux/pagemap.h>
> > >  #include <linux/gfp.h>
> > > +#include <linux/rmap.h>
> > >  #include <linux/swap.h>
> > >  #include <linux/compaction.h>
> > >
> > > @@ -280,6 +281,37 @@ nfs_file_fsync(struct file *file, loff_t
> > > start, loff_t end, int datasync)
> > >  }
> > >  EXPORT_SYMBOL_GPL(nfs_file_fsync);
> > >
> > > +void nfs_truncate_last_folio(struct address_space *mapping, loff_t
> > > from,
> > > +      loff_t to)
> >
> > So this seems to be a slightly adjusted version of
> > pagecache_isize_extend(),
> > what was it about that that didn't work for you?
> >
> > It seems the main differences are - block size alignment (surely you
> > still need
> > that though?) switching folio_test_dirty() for folio_test_uptodate()
> > (I'm not
> > sure about this change though?) and adding the trace line.
>
>    1. NFS is not a block protocol. Reads and writes are byte aligned.
>    2. The test for bsize >= PAGE_SIZE is nonsense for a byte aligned
>       filesystem.
>    3. NFS does care about using folio_mkclean() to fix races between an
>       application that is writing to the folio, and any zeroing of the
>       data that may result from the file truncation.
>    4. The existing folio dirty state isn't of interest here, since NFS
>       won't extend existing writes to cover the part of the folio that
>       lies after the old eof.
>    5. The folio uptodate state is of interest, since any future
>       pagecache read needs to see zeroed bytes starting at the old eof
>       and extending either to the offset at the end of the folio, or to
>       the new eof (whichever of the two is smaller).

Thanks very much for the explanation, much appreciated :)

Motivation is that generally it seems to me folio_mkclean() itself is an
implementation detail we shouldn't be exporting, but I'm considering how we
might abstract this while retaining functionality in existing file systems
(nfs and ext4 are the only current users).

So given what you've said, either we'd need an abstraction that provided an
alternative to pagecache_isize_extend() which could account for your use
case (perhaps breaking it into parts), or simply to have an abstraction
around the folio_mkclean() / folio_mark_dirty() dance.

The latter I was trying to avoid as it doesn't do all that much to
un-export the implementation detail but of course ensuring in-tree
filesystems work as they do now is a requirement for any such change.

Obviously I will cc- you on anything that touches NFS in this regard!

Cheers, Lorenzo

