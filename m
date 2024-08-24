Return-Path: <linux-nfs+bounces-5686-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEDF95DEA7
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 17:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2C8B2177F
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEAE9475;
	Sat, 24 Aug 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Aar0gs6L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZbKD3hS1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458DA1E49F;
	Sat, 24 Aug 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724511860; cv=fail; b=g4s32JMiw5wM85GaJmFO7BjwkY7ls/Gm+hHc2pM4LEMo0Y4uFzeVpSj4vKSKHsLeUSeiisA5D+HlOQiYRcjY3Yp1sga8YtrYEzlZvBJvgGaFzJ6SLrNvG6VEvh108aPJf0oTH8HUaQpRUkEEuHKpgW8FadhYu7gG7hWzaVLjXhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724511860; c=relaxed/simple;
	bh=GKBEeuBHSPDiHWVXf4RtRNIxBwJ8I4binw8630HkPJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qk9UOh+nYRzVbJcR9xLqw+D8u+otqxNk+6HDRE7dRmGojRS+7jFxJYRUvFW2gAf1Kk+rPOWJl0xJJLrQ26DGzB76gFGOxxlRek2GyHnwEZRU//C3oYmAdDisP1vjOz1/rWwulFg/s0vOuvG12BJXy4uk64ylHpBCCX55ZVqbrgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Aar0gs6L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZbKD3hS1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47OBjrvj030088;
	Sat, 24 Aug 2024 15:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=TQ7KITK+fADfgnq
	d2bMkeaKIhXPg4EwIMBAcs+QfMmI=; b=Aar0gs6L8MNHM5cSYODS06Ak5ybnopf
	1GLMKk2OphtGZGm9hfh7NZSAcXOuafkxzjXYqJffaBLXtTntNtVI28c9HQD71sOd
	muQ1xCZ2VJ3QgdUwBZd+UjY0+RPeRhE9AmgPpGnLT3IJUvVG+IGx2AcYjn5ERgcc
	S1vEHCT7xuEkBmhlWfwh1s7wXYaEGgK/dghNJ+m+HBxNRiQtk47BTBRZ9ZHd5ikg
	V7GVo5YkIANcNagbIinV0gnElPXisdOWvBxHdTMsKgXFzwUHLN/CbNJY1RC2eYT0
	ez7tC0ONHURbHnW1A9Or0oJ4JQHz0EwAUwy6WkSG2Hw9EMmuaQQx6EQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177u6gdap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 15:03:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47OE9FqC001791;
	Sat, 24 Aug 2024 15:03:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 417h1grsxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 15:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpeDHHmtDrz37aSpwHYepO3l+vR+2lbsHc+Kifn2ndZO6EPW2MYyYkkONOuPBt6243MdavheKWnFpRhpvt7urW03EbSPoxqMS1hEa4lL7I+pOcDHey/IwhOKEYach0tUYoOmOY0xs9stlD883lpOcyL31W+WmIPMqCankifvPKUhAzZD/RO2EvzPGsH5cW7fluPD0RifC0iS8AdkK8LMGKxk3Gzs4a77Z5IpZc5QjiZQQ2vUzIuPYAedNbH2xvLowlcY7IO/rWDk1fpmj4U9yheXrtSTyWV59N4JrW5KklXAXKe9MwNsC7Jx3UjodW2WhtQUwOIdmxJF5D9BhVTijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ7KITK+fADfgnqd2bMkeaKIhXPg4EwIMBAcs+QfMmI=;
 b=h/YwoR3D6O3Yy1HwlZdGFJoL4Ymnz7ZaDa9Dq+NwW+UrnAhKqmKs9vgQWzMAyuiDW/zvG+FafBku9OFi/K8qOCj3uwGG76bsywTqMnBNjffcvV+lpimuvqc0ZeZEatVnJ6bxkxFgEWJP4B770O7JjgXVWHc2QaqjZWHYm7VW2HVrtHkd0GWfmW04xH1zOAoucJJHCgVDSL1lCfYkEjuGdirdIbqle1PBEsvqjwxWyHR0yphpevlObQujI95f5I6qAmE/I1kkwNgGLmwuTCjA/imaSBzm+oRndnm7PqAqlkkOe98sXg+y9R/cazIPJiJJGqFrz0asuZNdnYmbWpPEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ7KITK+fADfgnqd2bMkeaKIhXPg4EwIMBAcs+QfMmI=;
 b=ZbKD3hS14yHwdvI1HI399Mob0iJLp7tvLnagRC1ndxa0RGA+pkYzis42wLn58VRX8e5+s0Rub1RVg4OQ6DybxpSXU0US37WGYpaOKKh9FuSz+t8voY4+tfbDGzjF+tzLaybrWqa8pmkn2SkU2hNYRFtVkLtGfPfeXB6bUxZYmcc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6289.namprd10.prod.outlook.com (2603:10b6:510:1bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Sat, 24 Aug
 2024 15:03:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Sat, 24 Aug 2024
 15:03:55 +0000
Date: Sat, 24 Aug 2024 11:03:51 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] nfsd: hold reference to delegation when updating it
 for cb_getattr
Message-ID: <Zsn2V3cmrNfc7HXA@tissot.1015granger.net>
References: <20240823-nfsd-fixes-v1-0-fc99aa16f6a0@kernel.org>
 <20240823-nfsd-fixes-v1-1-fc99aa16f6a0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-nfsd-fixes-v1-1-fc99aa16f6a0@kernel.org>
X-ClientProxiedBy: CH2PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:610:53::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 425183f1-4923-47f9-f00d-08dcc44df8f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/v9ni2UIxrsVNPSEUfFIGnYf+7VuFYKGMWPSi7jmBb/Dy+vwcr8ueolo6wud?=
 =?us-ascii?Q?38WZAAIPzLSre/I2IRUJ1wINNm9ALqIwownnb7khWhKWE5cKIfa5RocqzV/g?=
 =?us-ascii?Q?qIRakHh6DRJ7XrTREcY4MuZszCBs0NrStDE/We3HOj8oRnq0LLYOaK6X4CL2?=
 =?us-ascii?Q?y/7Djf1+1YkGVvkGrYuDmlCN+VcVZD7lrIs2mHwY4LAuqVbqUL9oU3Uu9YBS?=
 =?us-ascii?Q?ZjM8BjAFgxv1qdoFANNRao6sb+1ls5R6mHLix8PrR2BTrMSowQiEusZmzHLq?=
 =?us-ascii?Q?jT+jVHylOjUfT+FvWDzhLZkD7AflmPj36yjMCfSwFtFhjx9cBcrfi4WUqUIl?=
 =?us-ascii?Q?Q8bs1ECxQfVC9MgKFlcMxkdaq/CHkV6d/EQnu3gWOQKA6x3gocl91Los+Yvc?=
 =?us-ascii?Q?MlLCvVqbDMaL0fcxdH4gvmZi8hpSvEqbJ0v2jpiBrPnkThnsYnEFdv1dCp53?=
 =?us-ascii?Q?2nRGVafzGHodXmp03fKP9Qz4h7aZ+4DFReaYRSecw+AAlpjJ/EZPbipK+3is?=
 =?us-ascii?Q?3rasuPYRWvgLuUNmymz6L0p9hySMWjKNHIoR7vgK3uO44x5j/jfHRULQkTeO?=
 =?us-ascii?Q?z4/hak7IJfKQe21i9b9TnVB9YkMUFIFBEPlQ8UDK2AMWHqNLK9auX1tAvm0d?=
 =?us-ascii?Q?+WM9yRJ3z7uBrHVgV5o2p13THb4kJ9n4KJ8UoxvHXWxhYAvqOTh5a9GH2ksN?=
 =?us-ascii?Q?yjI5uOyje+6rSUSbtGMxoXPoqJfOFyyAKH3z6GvZDNzw/HrvvAXTQwSzGr3n?=
 =?us-ascii?Q?l4O3MUEzWHAcrg8h49Sj2tM3+ZHYWtkgdWbgQpZ1eCyw1zCuhBRmdUcBh8Hy?=
 =?us-ascii?Q?owVY7Bgi4U9KC9/DZHi04yzyl6vncEheBeSw/S75/6mxnPMUaz86QbFsTL2B?=
 =?us-ascii?Q?Aio6KaHFKT35hF4UCFpAyjn74/YKAteTO66wdo1zflFi+ysads/tWypaE96W?=
 =?us-ascii?Q?ZwZg00NHucekWxZiy5N26HgNDZZOdyeozeeNtyglgTch34IaaGgS4DoaCQSt?=
 =?us-ascii?Q?wjVvuOG+CRbXyFCVC9fo4Si5bzIncTzkO9+UyGLo39FNL3ZKx/X5ykj/qwUl?=
 =?us-ascii?Q?hKxZDQCf9HaRojHUCQpJGOsXiyMrVGf2336uRTVzQQHFgvo2WJ9/Hz1k5wJK?=
 =?us-ascii?Q?NUl81sBiTimoI/MorxyaVFP9ZcmciXYLhJRLQuAzFjzXBVnx5hdRYX04eNDA?=
 =?us-ascii?Q?q3j0EGfGd1n5Am8J0GWuXJCQcwSN8dHQoZaNBfm/o0gMNUgJ237sst1nk1wg?=
 =?us-ascii?Q?R1Ev4mZtTcZLx71HCpTrO10Z/EJVhQrbrF+svDqrYkrCndNlOBOON/GX/c4f?=
 =?us-ascii?Q?H52SIBnKyc4YO52CC5yxMmzhtcSI9jEUod2bf/FzNzzy2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OQc+Tz5wIjFIE+GIZDecWTYlxSLbqVGstrUt4lzx+80JwC9TngFEDjnaPin2?=
 =?us-ascii?Q?9Bhz7/CUvE+uS+TWsNlTQ1A6GuwRg+iY4rj6oDJG5KLDVnySxI9OImSQmLjS?=
 =?us-ascii?Q?zVKjBVZez2qEQQLMbonWdR7srlbbP2oCBtSWMQtYPDiLWVjYYT7Udd4XyI9w?=
 =?us-ascii?Q?ZW0jq2rQvlvSQIZZGGHqVlwEUhkGTeT/yLecr3Bd+L5RcP6C9JUmdSU3W4MI?=
 =?us-ascii?Q?dQnEuyDl5VCpCWkUjRuEt/cdPi+NnsSaLbzsJcQLVulR5cSQpJTFArsk0t6w?=
 =?us-ascii?Q?05NaE01n7KW+yi6FdwTIuPq8EecI+3WemGKTxsd+Ace859Jinzydajy2CN3g?=
 =?us-ascii?Q?Ga75OAMyKmW+1wWtP1O0TM8ntX+WDYpx+7MBY40m5g5D0T4zfemjLPVpaTij?=
 =?us-ascii?Q?qxZGsxbtgH2fDjiqhq1as7Q7cygtuqk/L/8XTN0Tfmw0PagbnZX+lnH2YYOe?=
 =?us-ascii?Q?NhSY4PKb62/8BataRirFFZ/jn4E7X0QZpY6BVgoJZhioCw5jxU5YaVZ3JGYY?=
 =?us-ascii?Q?isfNebAtKEljs0HB9O1GtumY/i2aFPi7l0dn3JaNJDeBcjF0U2ONs8AdFVfS?=
 =?us-ascii?Q?Iz8GaNfgifsp024bGIb/fnNibc2wcRyEdDL/FZuW3jX6mPqbyP+ha0Zq73xw?=
 =?us-ascii?Q?gRFcvR/BCcXWve5xHrnAw25foy9Z7duOn3uUrwLAdkVeDv5PLu4iRxcwlajg?=
 =?us-ascii?Q?R0X8v91EvV8ZhKPSmTWG3oOz5uyiNY1pOVQUlcr4WGSK5A+e7Z2FNWosdnxb?=
 =?us-ascii?Q?HhCfEZeuaVZMQYHRsthI4ICx01AyfVm10gK2p851rco4rjukdbvfq/utRRVV?=
 =?us-ascii?Q?SzhLY/y9mqG7C1z9joqCNgfVa4e3up255h85nEC45bdz5gIKhhZKmhIeac02?=
 =?us-ascii?Q?S++vCb79v4fwShZ+bZ5BRWsPGZqWvkoQWWYfgZklGyYYHPzRWmEOvCShQ6bj?=
 =?us-ascii?Q?6I05vLWkkuhTCXLo2Zy9se56JAOOzcC49pspLcaHs9Zb8vm7qn2lFSXYPYYc?=
 =?us-ascii?Q?EN5oN0EQkd2RsNJcE1kyPR9EacyixvlEGZ6gRXzj2w0qUf6Cj62RjmA+ywDT?=
 =?us-ascii?Q?6J8pz2ESQ27UbC/2d4cFOqDoeJIwm6p3X0COR/gtz5afT5Bou+GyBMvH00OX?=
 =?us-ascii?Q?GkpHB/G8XzmCZ+9v1j8LvPp56Vf5nYYtbQ+JX9ehs3WGzoIE0EN7rQS8Vq4p?=
 =?us-ascii?Q?W4PURI+Yb0Q+IEvhNZxi7EPvvGefqoqxAbjJv2uU2uLkS+3w4494EsatqZgP?=
 =?us-ascii?Q?G2V1sbjGPgSlLTbn5fIDIDUvyDIMeirkMvyX1qq4TMSPQrgWYXt5G1E28c1c?=
 =?us-ascii?Q?OiU7sd/HGtdDr1ib9j6UZvnjvBEQ3QLbgZbQCC0cjldDw8ctzebWOswoFP4+?=
 =?us-ascii?Q?C0fk4gicQleuozP+LHwijaJvi/qBCFi0ZegVlebrnObn4SU5HwM/RXvsDEO1?=
 =?us-ascii?Q?Cq/kQ27M7V1auf1HHgnyrchLVwrZ3DClMEwgePwEvAZTHp+m0vTpN+jvRBkJ?=
 =?us-ascii?Q?1rBsrrTYlKdhFqRFB2ocaJagc53BO0Our4M54zYYVbJ3wblgJdz+bgOSIKup?=
 =?us-ascii?Q?entVwvUHcOw7FBTEqllrB0qm7qKxmlXcnxFeTdq7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P0cDMrs4dxtrhhsyTf13YTxCDXpL8I9o40BmjHllig9HAQxvxadnrqGoeY1gjHLfpOEMTCojiD4MLzE4/WLFDKnKYSHDIm5hLpzhzLoWGMWd7XXFmzJ10Z8zdmKaBQ3HPfDx18TYY7F7l1/0U+lslzAHkzgQvIHyRe5IVNglkWg+kgpSq2wVxpfYJnk8/ZvMEbE6LlrZurFm7BgmRa3lJwXhwKqDLw8NTcSvDZx9Q3AlNu8Ybi/mAEFNVq7y07VfcDPm4nrouRbYQ3kWY8vYmX/823Jl4wInwCMU13BNUtiZHUlE2Ecmp2SdgCNljAwejU253hB/2SBJi0Y/wEGjioHXY3r+0TgxTMMxIL01Z/UnpVLgE4cyu2BAKkMSe9l/UTOaYySSmoDpOIppa8Ra4Tyn6XpRiDuRJN8RBVDzPbEC401t23WUjEFbldOahxQuvBooZmwX0yIWixNMFobQCMzE3zy7JKTG6BWD7oE9z+WveBqLT/yKIP58Stw2gkuhjDAqgRKczJRtyyehEAf+G3eh6548SZVtwsY3JKpVW3XtQltrZGkGxHqU6lwGt19s1K0nf231zR3744jT91MUQISuH5qmqan/s7BGOSfQVHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425183f1-4923-47f9-f00d-08dcc44df8f0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 15:03:54.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/EyEUy47S+j8UOMEYn4ArfZv8wRQyRZz3SnHPGQRkuV2pRI55rET4DXMAUW2SUylLm3tem3yuVT5cWIuT+kSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6289
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408240093
X-Proofpoint-ORIG-GUID: Z5Csx5JFWd6MkwWkH40_WgXUJ-t0R-sc
X-Proofpoint-GUID: Z5Csx5JFWd6MkwWkH40_WgXUJ-t0R-sc

On Fri, Aug 23, 2024 at 06:27:38PM -0400, Jeff Layton wrote:
> Once we've dropped the flc_lock, there is nothing that ensures that the
> delegation that was found will still be around later. Take a reference
> to it while holding the lock and then drop it when we've finished with
> the delegation.
> 
> Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index dafff707e23a..19d39872be32 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8837,7 +8837,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>  	struct file_lock_context *ctx;
>  	struct file_lease *fl;
> -	struct nfs4_delegation *dp;
>  	struct iattr attrs;
>  	struct nfs4_cb_fattr *ncf;
>  
> @@ -8862,7 +8861,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>  			goto break_lease;
>  		}
>  		if (type == F_WRLCK) {
> -			dp = fl->c.flc_owner;
> +			struct nfs4_delegation *dp = fl->c.flc_owner;

Setting @dp here seems redundant; just below, after the break_lease
label it is set again to the same value. May I change this line to:

			struct nfs4_delegation *dp;

> +
>  			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
>  				spin_unlock(&ctx->flc_lock);
>  				return 0;
> @@ -8870,6 +8870,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>  break_lease:
>  			nfsd_stats_wdeleg_getattr_inc(nn);
>  			dp = fl->c.flc_owner;
> +			refcount_inc(&dp->dl_stid.sc_count);
>  			ncf = &dp->dl_cb_fattr;
>  			nfs4_cb_getattr(&dp->dl_cb_fattr);
>  			spin_unlock(&ctx->flc_lock);
> @@ -8879,8 +8880,10 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>  				/* Recall delegation only if client didn't respond */
>  				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>  				if (status != nfserr_jukebox ||
> -						!nfsd_wait_for_delegreturn(rqstp, inode))
> +						!nfsd_wait_for_delegreturn(rqstp, inode)) {
> +					nfs4_put_stid(&dp->dl_stid);
>  					return status;
> +				}
>  			}
>  			if (!ncf->ncf_file_modified &&
>  					(ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
> @@ -8900,6 +8903,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>  				*size = ncf->ncf_cur_fsize;
>  				*modified = true;
>  			}
> +			nfs4_put_stid(&dp->dl_stid);
>  			return 0;
>  		}
>  		break;
> 
> -- 
> 2.46.0
> 

-- 
Chuck Lever

