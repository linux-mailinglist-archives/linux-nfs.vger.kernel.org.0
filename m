Return-Path: <linux-nfs+bounces-8116-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73859D27FD
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 15:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449F8281DCD
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59991CC17F;
	Tue, 19 Nov 2024 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jjKy9au2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wrDulHKz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D11991D2;
	Tue, 19 Nov 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026171; cv=fail; b=iDS1+fGMfFw0rpUJWe6G23JAodvx4Qxy5jl0TWpTkV8i2NfHb2Z6IQvcGY+OtQcv1L/rKKWDIyWPCfFzDw8mnVzAa54cMwqD/fS0vvYBqB/8cio6bUhdfgBseFPSBDl574gjG37wbabqYP3a+0K/hxQFspVYpdWKPN6Po0HDx3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026171; c=relaxed/simple;
	bh=00hJNsDPyVepC9g3KSzeENjLdldXmKVRSNIEOjPT2es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HF8+XiqgtpeihNf1Vngx3VQRjA2a3FqNqTkcjui/30ggkluvEOthWq2XWaZgTIQCvKi912kqaoUvxD4wBvFjAaUBWILL+wRzCKI5h2AmrecaIVoRHwSmUxLahwsAXX46ZBhs9bpHr3WmMLckLq+B8/KnPxAfXG8iwWOHIZlQ/vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jjKy9au2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wrDulHKz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJDhM1A031128;
	Tue, 19 Nov 2024 14:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Moy4mn0b1LzEqBlKgA
	mEd1JM0BLNExR8l+KyGgxd7SE=; b=jjKy9au2y2k0N/+hBPzA8T8L6mcLroshK8
	ACRzjpHbeiDdM6cnJTN859cmkhlLLgM9dnFw9/irYQENNEwqxyQ91Ft9okXpDc+4
	pvF+1dSi4e/g/rq30I3pXNc0DvtSCx18+uP8YsK3YwrduE9eGtbjEJ7mGCHEfAPz
	o2ixSLYbiUV1d+4eP3Fe5P5aF+aw3fq73tMoZv4TO2ltVmupZSnqXkPk1jh13NNf
	k3h7kZWK7x0o+IG/LRJ3ZJW+ifFg0bDmQGpL5KkUFcY0VlswGsAPQ5Q+obNHH916
	g6cw9CNg80dw7vMzT50MmPW5SQdbpe5bLdlBM3auvzbIJ8kp/5TQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc51yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 14:22:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJDsbQl037039;
	Tue, 19 Nov 2024 14:22:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8ma5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 14:22:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIc5Xj7QU4iFK4m1WVsdAHo8+vHUDyK0obnJtw4cohEP2R4dv0OpZrsW26hJt7CbjBF9IPdfbrryb43fTujE6vhKHXqokRzEew2bnJ042jlrFByh1ulhUHdx3fFN6KXg+dOWNHkIK+8KC+/1wFKJn0ntDme7NaaKwBWz8F6IynnKFYztdxbC+DRuB102LFpWRP70EXU/zJGsKntqKkjD99VRALDhnzrSF33y6ZIPGNkqHToHy7/5UNhjmuQqNRa3MQWV0Aw0ercLKiD/ly5b2b1Gm2rJUXP+sPGCx6dAHlKtU0cDmxN2w4+h1NfstpJbVsoQfn3orG3tciDb6aVXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Moy4mn0b1LzEqBlKgAmEd1JM0BLNExR8l+KyGgxd7SE=;
 b=vHY78HlbrtnK8DKlTUo9FSXRWaAGzFiFKdvr8tKcaW0FqzLhQUQcG9vP0NHHgqL3ni3z4I5yZMYxDifEAFohjxBingbnKhhp3JfKc2o9fUQ/+56ZSaFsjiVrlPLBJeh/JpvrVTl7xRQ90/S8IUDYrPmqipermZ0UKTE57UgK0nQ51IBdorIYxswCS89nC51EGw7c30Haif1yFSQa4P/1hf+Q0Je6OOR9tIXJkuSD/V3m7Zk7rLdJ8Pps7hYS4IDUyI95Pze1557FFzEV89c3lAZRradt5ZyjtwByd5JTqhz0CiT9sDyipKh9uMQ14jrbK5QrqBOxI9WK83t+SzCTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Moy4mn0b1LzEqBlKgAmEd1JM0BLNExR8l+KyGgxd7SE=;
 b=wrDulHKznQpy6SZ6NV2a4+D+/kpGOGZgXC2Nvi68gC2yiyb6hxTIOuupVlp3VumgJiLw73FOnz5kNI6RWGdeXXy/cZM7rw6fTaa8sk7styjYlrQR9C5xSo55/1dleci01U42pj2S4KBZDFUwT7iZ+ukchoofNK93ODf2tb2Dhf8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6045.namprd10.prod.outlook.com (2603:10b6:930:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 14:22:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 14:22:38 +0000
Date: Tue, 19 Nov 2024 09:22:35 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, Jeongjun Park <aha310510@gmail.com>,
        akpm@linux-foundation.org, stable@vger.kernel.org,
        regressions@lists.linux.dev, linux-nfs@vger.kernel.org,
        yuzhao@google.com
Subject: Re: tmpfs hang after v6.12-rc6
Message-ID: <ZzyfKyIqcj9pmi73@tissot.1015granger.net>
References: <ZzdxKF39VEmXSSyN@tissot.1015granger.net>
 <Zzd12OGPDnZTMZ6t@tissot.1015granger.net>
 <CAO9qdTGLn6QWJg71Ad2xcobiTHE5ovoUxSqvrDDrE_i1+uqUQw@mail.gmail.com>
 <Zzd5YaI99+hieQV+@tissot.1015granger.net>
 <CAO9qdTEaYa639ebHX8Qd0_FqOZUZLc_JvYNyxepUthGyDqw_Bw@mail.gmail.com>
 <ZzeQ1m3xIjrbUMDv@tissot.1015granger.net>
 <b40e7156-7500-5268-4c3d-c61a6382d1f0@google.com>
 <Zzi1FzrwmNIMIvnH@tissot.1015granger.net>
 <cdb68fac913bdc16e692f2f2cb833b5dca2d996a.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdb68fac913bdc16e692f2f2cb833b5dca2d996a.camel@kernel.org>
X-ClientProxiedBy: CH5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: ca751b04-30e7-42ad-ef2f-08dd08a59ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bYmimKeSEiWypLgl36GWU2ahyQooN5uKDFrWi43eS9AJBsVm+kuFlyRiZlhV?=
 =?us-ascii?Q?nJB2OGeWy7OyIq+75Mnprc2rLxf9c16yyii00YwJwg/CU7W2sgSwJz6ZGwDz?=
 =?us-ascii?Q?4grv/UvrBOs4goVyVNW+YbiDNBVs5xdXIGmZWPFfoT1JZ1dlaMLby3wqDwQN?=
 =?us-ascii?Q?u4oTbBwn6bksk9SBBDG9J9O6MRXaNnvkU0U+Qe3hKvdneQH+Gg5Nl5y+67G0?=
 =?us-ascii?Q?Lnor/231FGB1dKr7nImXbI9oQ/fzRnruWH8xYDzxia6hDYgfgYGpv1fXK0XX?=
 =?us-ascii?Q?XpB/djXj7hWKNsRPW0oUG+acS/XQg48S/Vc6aVywTVDL8XyUjQ2A7heZNnZC?=
 =?us-ascii?Q?luKc/xKVTcV7/L5aWcmcGzDFRyzpUaa1fHHdd/v0agBSST6oD2N0dHzXzPL4?=
 =?us-ascii?Q?92B1cbaP0mBBKCyiTUSJDmXZdZI7BGoFLHE1thWbkm2oyuniFhfUIoBmWmpT?=
 =?us-ascii?Q?c8fPkfRaW40QV0BvxiR87mV6aVr7MGfRGV4wPRyyIXxzuSwaMYk7s3lM1FAa?=
 =?us-ascii?Q?wzWfu29mtqAZfRHMdyLuwLIPD3U95f5eC9h4aOR9dwAl3QI61eLmkU8H9Am0?=
 =?us-ascii?Q?cBc9XVtkbIIUdELY68EhXI2t8dKTj3SVYB1h3zCrN0Kz6+bhRwtzyq4diiX8?=
 =?us-ascii?Q?hbmefOS/nzwrPUmTOnfqVD5GIPT8VSlWOdlPw+nCMqPI7+8Jc6AjqZOVmbbd?=
 =?us-ascii?Q?d+93vf2bm+nMr+d9tjoKSngavc7mz9AK+4hRPn+LvoS+YHWa2/QuxNGn+fwy?=
 =?us-ascii?Q?azMIk5cY1m3B5YrFJNvxyuHtieBqikLSUlKIUqYOd69Q3KUKDTy4Mb5FTwAU?=
 =?us-ascii?Q?z9xSlLwifWOwb/YIvoJkzWVraFRa6L7dEspIiUo7Ben6bPAFPypE31MXikox?=
 =?us-ascii?Q?1YDWKSt1uJHB7aOqew1Iq1FxKfMtwom/R2PDAqZcczwi4flZncrrhKpLJLRO?=
 =?us-ascii?Q?7tFgjdPHxyKesHVOyAjTcLaUQ6KJutZM5dTjDY57FJwl+jHQ+l9PTzS6A4P4?=
 =?us-ascii?Q?lux4207S2d1pf9ltX/zWzSTxT1GF5wTC3EIQpqVAIHp/fTKUAo8lhO70s4qu?=
 =?us-ascii?Q?2vsxrvvzYUhiMBtI43bQZehfqKWWkaN9eVvdJTY7rP/gdeFMci66MHYDF+Mf?=
 =?us-ascii?Q?W5/+q1k+KP9cJZPOXE0aA4ZqvZSPWctbrikKZ4clqeL+O8sqUmenK7EtnMcm?=
 =?us-ascii?Q?6+8bSAH1KsZIgkfMQpcjyz1aNpOUlpvmfEL42au9QPUNZSYUwjV7aC345sJj?=
 =?us-ascii?Q?t0ddlmb0QOdWmZL+zNVKwsi3otSly6hgHViUlOy5jvwHIRDXxIdSvQd91EQQ?=
 =?us-ascii?Q?miYkyKlhvwftYHVwFRdHY5Za?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?12QSzSaTAd++PALAwls1gzIMY90th/AN2Lr19Pp/ss+yBS+4LIYJw4Pl3sdV?=
 =?us-ascii?Q?l8C+EtrrcR7NbwD47jMivm5Hmos3VQyXbxQhfSbXDL3aJEiTuOjCxVUXbdpo?=
 =?us-ascii?Q?Ng+CTIH+r/OtfVpEK4eH2fqnzjAM6YUr9Iu/RY2Z84l2AMvQLBmeL9bqx42k?=
 =?us-ascii?Q?6+N6KMdnBd6baL9fJIEWm9PYhlANerwThQ8OaChKyfq+Reg715tRtvy7F8th?=
 =?us-ascii?Q?AhwKgAilj7YGbPdjO1eNeuz0u1lD9U0qygSdXVpvLZgWKB1mDOuRseRYxevU?=
 =?us-ascii?Q?s/qGUarsKUpqQSN/Z87B23/XslkeuxexUlpJZmPq/i32srSRTc5wDzJaXNMW?=
 =?us-ascii?Q?fnL7wgV0NnWBNM39KtHXNbYwxKHcF1o+xfa8GLu8khlj1QHVZiiEqqevRMvK?=
 =?us-ascii?Q?0gYnj8hQ9m9J5kyj3l7ZAHzY7wBruCCtyJgYbyzaEx1FWlgk254KS8qaX0jp?=
 =?us-ascii?Q?fdb402zJcFVOsVKA/AI838+zPHz2i9lhyx1CBBSsa2lD3cE5JKVKTyxZ/9Qx?=
 =?us-ascii?Q?rfHe3KEI3168D+abkgg9zKAGF1eB3/NQppA7rNtMCaWTo3vDFJiW+UIicYmp?=
 =?us-ascii?Q?+R5KocqctNm9+r741mVt6YLaoSEdl5DutDquAwJiRyJkHPnGOWW/YPNo83Os?=
 =?us-ascii?Q?BdzrN+QW5Ma8g562x3qR5GIGoZGNpiAn/xuAdo/PPrY1e5vsLRPlgVGY3QwJ?=
 =?us-ascii?Q?GTmlpkCxdJEAYSB9e5VMQlatCsX48S3UdpNAaGRGH8bLAu+58GEiCdEm43L0?=
 =?us-ascii?Q?q9a2bPZ1ukeDoBXvqYCsmcpJv0gwbZoT1vb58eklT1NOt8SKB7pXgup0rb0l?=
 =?us-ascii?Q?h5VGYePGEYgUKWTju/ZdlUmfdJ7mOggbFr8Rh0XcjLsfKmcl4azIoRK2DOZh?=
 =?us-ascii?Q?eTlaBgLbcLQ9WZ6/6WLec9Qftx172BGk6bDX9YVMNdVphyGxk4y18eGqWQY6?=
 =?us-ascii?Q?l9DgO79Xs9YXWKSYVns9PZV79QkTXYdDzWxE0H5mUx+4y/LxG4Kc9Mx9RrDC?=
 =?us-ascii?Q?JixCHzretzeHhkvqr4BxBuSu1cYiAgMoQR+FMKLeT2eqE7qoSSObLFBRT9OK?=
 =?us-ascii?Q?1Byj/GN/ZA9neKXbBSqNZQA1pNqTHDMUxSsx7/cncMNbRe7pXhqYnHtEFuqA?=
 =?us-ascii?Q?4qh3Iyux35NkqmzCevT6ACTYGKMGQh37tkOBbTjZTC6uj/aER5n76Xr+eqfh?=
 =?us-ascii?Q?y02O6MbRjZpo4aeru/rARcxWQzSQZtX8cO5J4w2wMcu840T0bM5vYYY3X2KO?=
 =?us-ascii?Q?UtO6EoMESUv/dSfNH2hMAxUOXNcIBFZwCXYCkWmyjuLg1Z7F+AcSR+qd13Y9?=
 =?us-ascii?Q?T4uc2X63voe6qzVIudO3zI2+g1VPegv/ei+pibttCiQzhrJuzpF/yBPtG+mm?=
 =?us-ascii?Q?x9cRJI0GjH+08aqcruT/GlYg2NdliTO8R3qkVWnlbuvZr5tBLhMtTeoiE4kK?=
 =?us-ascii?Q?k/YJjW7qOqQMiiEG2/tQPdK31xNLbV2UhwxsG8jmGhjOfyiuNXNT5YGEVmWr?=
 =?us-ascii?Q?Il4PvYpW1yOhSl/7rxbUq/bSmE1CDMrOFzuO6+rdf0nOdH4dHrKcDdYIZdBz?=
 =?us-ascii?Q?hzCdKwrQGCwEdyERomy7wFMj2BRSHmY/UYczcb4th8A6tmHilkNcnQqRpLtL?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TOSFqrvKjVH8rM2Cd9a5ewsgz/TgcX1anHUcHq+CnCoVQU2eRKbzg+wSejNdV3x+9+1tj1LB1PSluY993YrGp+YcWgw7GqL/D8QA4j2WRVOAxJC820QpzQm9kUtw4CqbjAXljtDExAXFAcz8IuuPsK93zGKWzJaRp3kDYiX+YR8klpXGblTuKeQie7P9kcGlozW4OVEC6CFxIB2X0K9KfeKTLUhBYal0rUoOP1J5fvcGiw/5QaSB7GVx2MMbLbdXbmz40jmIbXa+9/CTrOe107eIiDL+glKz7c6FGRYTd8Lj1ygn/CT9tJa1cMn2tJDP10vX4kPRCrA1ihlkXnOUwzl3+W35VNJ2MrH1Q0vgg9/gzYAFso9wN5lmX99VSFs9UIAUBjWvfWO/ZvB+Hvz2R9j9XQuTnxVJtYWTvAoW4K71XboyhvhmwCXkdHU1a5s5Q4LlLjV/LV3a6/ZzM0T4EaEdkHqCNCIDzfWVC8bGa663DRRZCF9uLNRsseKHJuYuHhWrcj4mUDPyo4eK8B0T8+dPfIMXeRDc0zL3gqL2AWngzk9Tvi3ECagPx9Jf4Oz/wP0KOYtou3gsIwLWBh5aEnKIhZ0yFNjPBzJLE6NUQUk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca751b04-30e7-42ad-ef2f-08dd08a59ed8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 14:22:38.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYcf9yijKnun1bzlx0ROWTI60R+sagvNVS4JwUbDK4Ieooy29RxpnlpfrFQs8rhbt7KWdW5mwze7tzQ2BgejGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_06,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190105
X-Proofpoint-GUID: ib0WWEy06XJqoJphhJAF6Bi8tNIBvgrA
X-Proofpoint-ORIG-GUID: ib0WWEy06XJqoJphhJAF6Bi8tNIBvgrA

On Tue, Nov 19, 2024 at 08:59:19AM -0500, Jeff Layton wrote:
> On Sat, 2024-11-16 at 10:07 -0500, Chuck Lever wrote:
> > On Fri, Nov 15, 2024 at 05:31:38PM -0800, Hugh Dickins wrote:
> > > On Fri, 15 Nov 2024, Chuck Lever wrote:
> > > > 
> > > > As I said before, I've failed to find any file system getattr method
> > > > that explicitly takes the inode's semaphore around a
> > > > generic_fillattr() call. My understanding is that these methods
> > > > assume that their caller handles appropriate serialization.
> > > > Therefore, taking the inode semaphore at all in shmem_getattr()
> > > > seems to me to be the wrong approach entirely.
> > > > 
> > > > The point of reverting immediately is that any fix can't possibly
> > > > get the review and testing it deserves three days before v6.12
> > > > becomes final. Also, it's not clear what the rush to fix the
> > > > KCSAN splat is; according to the Fixes: tag, this issue has been
> > > > present for years without causing overt problems. It doesn't feel
> > > > like this change belongs in an -rc in the first place.
> > > > 
> > > > Please revert d949d1d14fa2, then let's discuss a proper fix in a
> > > > separate thread. Thanks!
> > > 
> > > Thanks so much for reporting this issue, Chuck: just in time.
> > > 
> > > I agree abso-lutely with you: I was just preparing a revert,
> > > when I saw that akpm is already on it: great, thanks Andrew.
> > 
> > Thanks to you both for jumping on this!
> > 
> > 
> > > I was not very keen to see that locking added, just to silence a syzbot
> > > sanitizer splat: added where there has never been any practical problem
> > > (and the result of any stat immediately stale anyway).  I was hoping we
> > > might get a performance regression reported, but a hang serves better!
> > > 
> > > If there's a "data_race"-like annotation that can be added to silence
> > > the sanitizer, okay.  But more locking?  I don't think so.
> > 
> > IMHO the KCSAN splat suggests there is a missing inode_lock/unlock
> > pair /somewhere/. Just not in shmem_getattr().
> > 
> > Earlier in this thread, Jeongjun reported:
> > > ... I found that this data-race mainly occurs when vfs_statx_path
> > > does not acquire the inode_lock ...
> > 
> > That sounds to me like a better place to address this; or at least
> > that is a good place to start looking for the problem.
> > 
> 
> I don't think this data race is anything to worry about:
> 
>     ==================================================================
>     BUG: KCSAN: data-race in generic_fillattr / inode_set_ctime_current
>     
>     write to 0xffff888102eb3260 of 4 bytes by task 6565 on cpu 1:
>      inode_set_ctime_to_ts include/linux/fs.h:1638 [inline]
>      inode_set_ctime_current+0x169/0x1d0 fs/inode.c:2626
>      shmem_mknod+0x117/0x180 mm/shmem.c:3443
>      shmem_create+0x34/0x40 mm/shmem.c:3497
>      lookup_open fs/namei.c:3578 [inline]
>      open_last_lookups fs/namei.c:3647 [inline]
>      path_openat+0xdbc/0x1f00 fs/namei.c:3883
>     
>     write to 0xffff888102eb3260 of 4 bytes by task 6565 on cpu 1:
>      inode_set_ctime_to_ts include/linux/fs.h:1638 [inline]
>      inode_set_ctime_current+0x169/0x1d0 fs/inode.c:2626
>      shmem_mknod+0x117/0x180 mm/shmem.c:3443
>      shmem_create+0x34/0x40 mm/shmem.c:3497
>      lookup_open fs/namei.c:3578 [inline]
>      open_last_lookups fs/namei.c:3647 [inline]
>      path_openat+0xdbc/0x1f00 fs/namei.c:3883
>      do_filp_open+0xf7/0x200 fs/namei.c:3913
>      do_sys_openat2+0xab/0x120 fs/open.c:1416
>      do_sys_open fs/open.c:1431 [inline]
>      __do_sys_openat fs/open.c:1447 [inline]
>      __se_sys_openat fs/open.c:1442 [inline]
>      __x64_sys_openat+0xf3/0x120 fs/open.c:1442
>      x64_sys_call+0x1025/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:258
>      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>      do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     
>     read to 0xffff888102eb3260 of 4 bytes by task 3498 on cpu 0:
>      inode_get_ctime_nsec include/linux/fs.h:1623 [inline]
>      inode_get_ctime include/linux/fs.h:1629 [inline]
>      generic_fillattr+0x1dd/0x2f0 fs/stat.c:62
>      shmem_getattr+0x17b/0x200 mm/shmem.c:1157
>      vfs_getattr_nosec fs/stat.c:166 [inline]
>      vfs_getattr+0x19b/0x1e0 fs/stat.c:207
>      vfs_statx_path fs/stat.c:251 [inline]
>      vfs_statx+0x134/0x2f0 fs/stat.c:315
>      vfs_fstatat+0xec/0x110 fs/stat.c:341
>      __do_sys_newfstatat fs/stat.c:505 [inline]
>      __se_sys_newfstatat+0x58/0x260 fs/stat.c:499
>      __x64_sys_newfstatat+0x55/0x70 fs/stat.c:499
>      x64_sys_call+0x141f/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:263
>      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>      do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     
>     value changed: 0x2755ae53 -> 0x27ee44d3
>     
>     Reported by Kernel Concurrency Sanitizer on:
>     CPU: 0 UID: 0 PID: 3498 Comm: udevd Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
>     Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
>     ==================================================================
> 
> inode_set_ctime_to_ts() is just setting the ctime fields in the inode
> to the timespec64. inode_get_ctime_nsec() is just fetching the ctime
> nsec field.
> 
> We've never tried to synchronize readers and writers when it comes to
> timestamps. It has always been possible to read an inconsistent
> timestamp from the inode. The sec and nsec fields are in different
> words, and there is no synchronization when updating the fields.
> 
> Timestamp fetches seem like the right place to use a seqcount loop, but
> I don't think we would want to add any sort of locking to the update
> side of things. Maybe that's doable?

I don't feel that the observed data race is a major issue, but it
did seem clear that it was not an issue that was restricted to
shmem_getattr().

What does seem like an important issue is that there doesn't appear
to be a way to annotate "data race is expected" areas so that KCSAN
does not generate a splat. False positives reduce the signal-to-
noise ratio, making the tool pretty useless over time.


-- 
Chuck Lever

