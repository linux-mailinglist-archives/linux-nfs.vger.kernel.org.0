Return-Path: <linux-nfs+bounces-14765-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F24BA9493
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 15:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A361892B7B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 13:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB7D3054FC;
	Mon, 29 Sep 2025 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iF3/C3h/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ufJJ6InL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96AF2FCBF9
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151418; cv=fail; b=JITLHg7dmmKCQ4nI2ZwntOvMZTlJwnL1skMMitV6U5zHll7OhaCSfPIa2Hx8I5c3v5iEhX2skm+3cwqtY1pPs47z57FWVbD8yV84EdvtRRWKNt1XtH7YKPrb1vtqFt/2Mdqs9fAAjaJxdbLKVhneGu2XzRquvyDH6YlkEJh7kTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151418; c=relaxed/simple;
	bh=czWX8gjWfO76DdViZc+A0yIE7DoX+GKiYbK8DApoGSs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SXYUvXotg1TJ2wVXtXy28/92s2OmzQ8Bxt6icVeFe0Dufw1J37Ld5dUjloNQR3YwqPsT8/8mS4Ori/QxO9yQLPio3lyDs7b6DIGUyA9DizWKRcbyXKpX8svBOVlGu3UdjUNxgVU7aCLEOQGR8BXKnOoAujoFKq9+hZKd6FzyPqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iF3/C3h/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ufJJ6InL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TCQvOH004266;
	Mon, 29 Sep 2025 13:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9I1JirTLajQZAsC32Wj2mvkO93vIZOYgW3mbt9AGjqM=; b=
	iF3/C3h/nKTgp6ToZUkt51Zw2vgWIG1tL9nCZNZ9E95WyUlcBJ79JRBK0QjH8I9m
	/agARiBuSMu1wYe/CarGldSp/mO6KNxVxCVx3uymFVN4fyE4HHfA25uJOQdVlDtT
	AkaVurfMkwk3vOqHbbE3ko4XtM96IMUiTWRyiahbtK092lIFV0+UOdqB5VSdTJHY
	i7s16sZ63f4ogVBxUVZ9hKF+O+B9mmLB4O96d/PVc6izL4C+9tN+cWz3UIuAFY8N
	CEU+ehTlG0VKcB0ej5z4OGka/2oCPFUrU7LFStcUg3IJx8L1XB+qR9DMMe0suaH2
	DtrEEgE0DeRc1UIZdW3X2w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ft3er2yq-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 13:10:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TBJ6He007762;
	Mon, 29 Sep 2025 13:06:20 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c7dh19-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 13:06:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/24JsVNZxhSe5DdFCqoJvtGC87jFc25o+EnUB9MgA3KCtQJsfP7qE59z4ZCkir6lpYNIt1wLswxJp3VyqDRfzCGKUkxbOIai8nB160T70BzUDdcMaqwHPhvgOipggWxpMDsUc5ASsERMkx350gCcY9yxorB9nAbu1ajbyTKIBwS1cuVfpZl0KfbTFhjWWp2djdx99C0Y8EEBP9taDeC1YEwgOhMPdaBUyn+526xv84fK/pjc4wXyM9HUscI/ZHSmbW2hGU1631cACIHakn3IUqFF5Xuqk9muZxvreiyhidh40yMb0LTZZCUCICNjzzpdqr775CxdCitEJb8AP3Psg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I1JirTLajQZAsC32Wj2mvkO93vIZOYgW3mbt9AGjqM=;
 b=agNuLyqL1vaNNbm8vg+TdxZcWmsdWVWGtxNaZq23nDP5cAlrtr62LfKYWVEyUXK7P9aP/5quMKPomq/hHStTASO+a8Mt00NZelRpCC6AQwQ6cbVXetRAb56uKqBPTbQxLi0C7fVsjOttXy+UJ1NB157jzRB8ucJTdIjWyTRtIIU6zLIE+N1QLnfjA789phBL4nrKn+7cBxY+ZjCQjYz380b31hLKb4gZwDJ/Ck8hJJuLdOGpoqK3gwwO72hgRYOG7yj/p7fyzvenW3fhbZ4pCP3ijk1eie1OZtWX02hRTEl8P6Rhw/Wk+OSkQtQVwhasKf8Pp4TtKIt4SG+RRbT2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I1JirTLajQZAsC32Wj2mvkO93vIZOYgW3mbt9AGjqM=;
 b=ufJJ6InLWmhyCG55StiBQoayfKRwGdq8jMiwhOHCI9S0w/kvvoYhHsSwd0S+myu7B1/FfUmKorahZer5pKehMdehrGA2X3gdlPtfrgmuikmsJWZUtHiGgGwpRKiZEOIXa1rHSB+diXduLoO5imxyP2Em/fFTQxuzW6L3DgqIr+s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6225.namprd10.prod.outlook.com (2603:10b6:510:1f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:06:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 13:06:15 +0000
Message-ID: <2d231b3b-dfa8-4f95-bd6d-4d90629e5d50@oracle.com>
Date: Mon, 29 Sep 2025 09:06:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] NFSD: Implement NFSD_IO_DIRECT for NFS READ
To: Chuck Lever <cel@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>
References: <20250926145151.59941-1-cel@kernel.org>
 <20250926145151.59941-5-cel@kernel.org> <aNo1PdbeHsd_rpgl@infradead.org>
 <cf8976b6-6a81-44d1-8966-727edf9e1f54@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <cf8976b6-6a81-44d1-8966-727edf9e1f54@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0034.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: aada42ef-085e-453c-3ce7-08ddff58f892
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?b2RtRE04L1Y3UE9hZWZ4Y3pxT2hFMmdwamFxeE8ycnBUVjJhTWJCNFEzeDB2?=
 =?utf-8?B?MllxeDhHTDBWVU9ZNWVJbHV6dzkzY3FHVVVjc0xJNU8yRFZNbUFmeWNyNTB0?=
 =?utf-8?B?UkpXZFVsOENrQ28zU3dZWEF3dkdxVUVVclE1VG5EbHlkQzVPcWdEcG1KRHhu?=
 =?utf-8?B?SnZ6RXNqb2JVWEc5WUkxemIvNUVpcjlkelp6K1diVGNyeDFxSXZBSnQySml2?=
 =?utf-8?B?QTBWaWdPODNZRWE2ZXZYUWFpUXkrbTgwRTJUcEpEdi9vcTZiREE0K1hNWXNX?=
 =?utf-8?B?bUtPaDJUS2gxcERSbGRhdXpiVmRDUDVYWERESkpjaUF6bGQ4NTlzbVo1MmNx?=
 =?utf-8?B?NzBXMklYdFBvcExHOG1SbzJ3T2VNREtTbGU4VkVEN3h5ZGNwV29yT0xZMFhn?=
 =?utf-8?B?T3JTOUxEWUE0aS9vUGZzUHAyTWxKWTBKMHpMdXp5U3gxTkpUYXZXaHZqQkFR?=
 =?utf-8?B?UjlJSkszaEc4WXYwOVNTaHJKK1NjbTFRVW9Iam12SjZLcTVydkZoNDJRbWxy?=
 =?utf-8?B?S0h1UU0wbVNSaWNYUld1enpmcUNlTzdmTkMzRTZmOW1sQjV2SDBVaHlCZFZx?=
 =?utf-8?B?UlFKMUdBTWlRQVpvSzFzQi9yczBVTGtZbk9Qb0J0R09aOTJXSFZSZkZ2bHVF?=
 =?utf-8?B?MTJnKzNLR2xCdm1nMVN5Ly9vcEhxQ0VPUys0YS9JRzQ5VytJWVExSVdJdXpa?=
 =?utf-8?B?TmI1QUlOL0djT1FpTzEvUXZZakI4YzBxK0NTc0hZRENUV3pVVkFXVkhqcC83?=
 =?utf-8?B?QWNFSVNoMmJTL3M1Sm9sSEk3REUxWjlVK3g1WGZRMWRPS2xCY3JlVzlqdWtD?=
 =?utf-8?B?aS9WVEZwanZHb2VxNlF2eG04V3U3ak1mckhUZGcxUmNpajh0SkNuMDArVWV2?=
 =?utf-8?B?b1NQanJpbjNvcm1EbS9NVEFJd2VVcElqT3FPVEJ2dUhVOWpqUW9UMG9oZTF5?=
 =?utf-8?B?eERjdm9MZkJhK0xkeEZLWHl0STUvWFRycHRMTTREaUZIQXJZb3BDdDhnVXd5?=
 =?utf-8?B?eVNUbDVLQnZjaDI2NWlPUXdFVjYvREsxZG1XVlA3VFJDaEp0Uzk2SmdURWlL?=
 =?utf-8?B?U1dQRXRJUG1ndGRyQ2crQ083aHFiUzlER1VjOXJKd3hsem96Sm4vNmQ0Y3cw?=
 =?utf-8?B?d1ZCM1dncmJncHJnWFErWHZiWFNuLzlYOC9IYi9ZZWxVTGhBa0xKOWw0dG8v?=
 =?utf-8?B?Ykx0Vms4WE9SSThSbEc4NWtBN1owNmRqWU1jS3RTb0xmQjA0ZGRUYURJSmM5?=
 =?utf-8?B?ZDliYi84ZkxHOGJiVkF6WVc5ci82NEpFNUdSVkJ2Y1RBVmtFNnhvMFNnUHJs?=
 =?utf-8?B?c2I3R3BwRm52SUJiYkkyTFNNTy8wNlhySUluaUV5TTFydjdNMzlVVHp2bTdV?=
 =?utf-8?B?OGJyNENYeGk2aWpaekl0bWxuaTRLcFJWQzhPSGdBbXRIWlBDUWJxV3JzcEZr?=
 =?utf-8?B?aFBNR3orWnpCTUN4YjMvcUEvWEp0a1JyalJCVDh3NVo0OXdmZ0ZYOXZYRGQw?=
 =?utf-8?B?elNxN0JRTDJUYnYwVHF3U3o3bmhDMVRNb3Y1SEFwKzNJWllRa2tJZC9RS1NN?=
 =?utf-8?B?OGo0eUtzZFhzR3Nwc04rL1pTZUVyOEdadEM4QnRBWHVVeUkyKzk4N1ZYN20y?=
 =?utf-8?B?bjlCSkZya051MHVGTmtnUldMWXZGWGFHb0Y4U1N0K1BsMGlySkkvWFI2V0tM?=
 =?utf-8?B?ZThQYmZqWlpFL3orNitubzdaSjZNKzEvVnhmNDRPMWFQWGNvL2FCbDUyUVhP?=
 =?utf-8?B?cVowbVI1dlZvVDlxZmNBaFZIWTRaalJZYjZpUk1LbFZwbVR1SGNEQy8yN3F1?=
 =?utf-8?B?emkyQmswK3R6YTJsZTJzM2QvcmYza1B3Z1VwWmdaQUdDYlhMa2JZYzJDNDd6?=
 =?utf-8?B?UTRST1pXUE12M3ozclk2VWJRSGtaZHJmb1U1QXhNSDV1WUdaSWJEclhXcTZE?=
 =?utf-8?Q?hxx1H5QfTBu5X3YF65ZYyLQCcAYo4gSI?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d1V6dWdrRTR2VVJhNkVRRmNoNEp4MVhFV1hRUHcxL1kyWGZaZWZ6ODZqMHo5?=
 =?utf-8?B?MDNNUktwWkF1NU5ZbFJJUzBlbmF6WVpJclc1Y05VMnUzZkpjTm9uK0YwRWZU?=
 =?utf-8?B?RHZrcDhBbnZMN3VYQnNGYnd3TE9XTytndmx3bk1yc3VnTzdCU0tvUER1M1V1?=
 =?utf-8?B?dHdBSGFHbTdFaTVVdzM5a1Z2NXVnUEVxL1dJSHVTSzhtOFVJV2JLdXd0UkFm?=
 =?utf-8?B?SStxQlNtaGhCbFREV3hoYjBFYVAzSE5WMlJteTNndDhtUlUzS3BIeXMzaHl2?=
 =?utf-8?B?TlZGWXhVbU11eVhtOW0rNzJnS2ZjWXpnOWFYcEJWMXpEZGVKbFgyUjBRZ1JJ?=
 =?utf-8?B?clZTVFZFTzQ1WExsR0kvRnl2TVdqUWdhUW0wNWVCV3VVcXo4NnNaY2oyVW8y?=
 =?utf-8?B?Qlk1cm5lQ3ZOcjBpOEhwb2piYlB2SmovTVpMQ1ZQSmo4Q1RhL2NhcURSdm5j?=
 =?utf-8?B?NENMRVZtSi85eExlaW0zaEsrZjYvdFlNSnpRRU5zYVY3MDdGNVFXcHVSbFFs?=
 =?utf-8?B?K1phL2dNTWpzalo3N0lIZzJqM1cvZnhoN3RwQmo2UGRtNFlHbE9BS0tRTFNR?=
 =?utf-8?B?Wnc2SGI4TFdTQnJDbHFUVWk4cnNLazV3N2NZZXRFemFyN0JCK1hLN2VFSDIw?=
 =?utf-8?B?bUZweHVBSEU3NmhRejdOUUFtL1BMZGhveXAxampPcmY1T042Y25oK2ZVeFFJ?=
 =?utf-8?B?NjJ6YVpWK3NURVg4NVBMTjdoa1ptQnd0ZGFiLzJxa2JkZVd6T2l2OXE5Q0VB?=
 =?utf-8?B?T1N4WDBoUHpvTnM4aDNqQ24xM3dHMlhEN1hpZGJCUVBLcmNtbXdKcjFsaTJw?=
 =?utf-8?B?M2lUb3VaRWFOQTRXRkpjSEticVF4UU50UThaN1VHZWk5TFR1SXQ2WC9DRHhI?=
 =?utf-8?B?OUg3aWhIUE5UbVNGb09IS2lYcUQ2d08wZWZrd0s1ZEdwaHpXSGNMQUZQcTVX?=
 =?utf-8?B?OGZGR3hDOWRhbzJMaWxRdzJjNWdpSTJnRGxsSnBlYk9NaEU3QzlQdXNsTFJ4?=
 =?utf-8?B?Zy9mbDR0YXpjRkZFYldIQms0TEdaaWdkT1lqdGZ3cW9HNS84MmNaZEpaOTh1?=
 =?utf-8?B?U2lTU3dnUWdQK3BDOU5Rd2pJL2RWQjBHL3dZYVBiWVNqV0Q4SWl3QWtaYlZw?=
 =?utf-8?B?cTd1L2p5OVNwUFpLUjMvZC9rZU0vWGhxZ0prZ2RpQ1ViR2grbDZDSWk0YmdU?=
 =?utf-8?B?RW9KS2Y3MHBYZTBBK3NLWTEreE9MWk0wYTNDeUI0eEdmZURrd3JBNVU2L1BY?=
 =?utf-8?B?b0dwc0N6UVNXVzUyL0JIOGQrVVNrTnBEWGQ2blhVSTdBZ2R6L25ETkxIQk9K?=
 =?utf-8?B?c210SXFKMzE2WThhZER5L05ueHlubm92SXlDL0RwY081VFEvQjNaOTBCOTNY?=
 =?utf-8?B?QkF0WFgrUk15b2RFQ25BVk1wMi9OSFdBbU5tcUh6RURoWnR4RW5aMVgxS3lj?=
 =?utf-8?B?SC9EelJPdzlmRUVqYWFEalpUQ3ErREl3SHBvK0krRVhzSHJuS1FuSll4dlpF?=
 =?utf-8?B?OHdFZ04yb0NZaGVzaEdBZUdUb3Q3ZitxbWRaYmtXem9ScTNHMWpFYmJnZFFo?=
 =?utf-8?B?cEp6ekU4QkRITExSMFhGR3IxWnFHbWxNcDZTeG1TRlpOdkdHa1kzMWFFaW1r?=
 =?utf-8?B?WVYwMmdPWGNrRERrT1B2MHZDR3laazlkbTdCWG1CK3JrQk5GY08zVmM4MGFj?=
 =?utf-8?B?SGY0bjZ4ZGxLTnlzZHlKdjNJZnQ5WDJXWnMyVXU2VDRWbTF5VFh6aTlORm8x?=
 =?utf-8?B?d091dDNEVDN4L29tUXovN2NmcHZlc3AxSGRiYTNSZXlRdkNEdnl3UmJpVEJn?=
 =?utf-8?B?NlB1QUJ3TS9pVm96QWo2SXdLMjZhTVQ1dWJUQnNNa3JpK0pHZXFtZmsvMWtX?=
 =?utf-8?B?ejlFVmJtQkVCZ2RlKzRnSlNsTlp3SjA1QlRhUi8yN0dkQTY4ZzZWaWJkS0RI?=
 =?utf-8?B?VCtxSlE5UjlCWmROSVZVQmZKb3ltVE83eHREQ1pDZUFLZlgrd3VmYVVDU09D?=
 =?utf-8?B?TDFETldCeDlWN3hkQjlTamdVZjcrZkdqU2JHMUV1ajRoaTFBbWpIZFhYRG9P?=
 =?utf-8?B?RDVnZnpzT1hlYnNzSW1IYytoUjJUNDQwVENiREgyMkw2MERzM2xHaEdzL0pj?=
 =?utf-8?B?L1dQb2hsdjloZmpWVFVSS3dmVDh0RmJDR2IyNFRXcmRKdW03RGJJVWJLTHBP?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LPTRnJD38Nw05J3PDtC0k/Qrf6sDpmBcQWimCI2WVToqDLVQek61hZnRNlk0IM/1q/pt6BGoTq1lkG53F62izYgXZb8QBPhNqdhcgGgiOhY6SemZ1VXs4yHa47ghQSa6TCOMaNGPxSyJwCkV7kHxkqwPRBp+vsPKnHvci7U427c3qT4OCaL66SbRA2mo4WfGMHKJ+15qsYVy3pLFnVWw8wm2qjPm1yaO3RCOudYTfj2xJIKSph+mMdUCAhYZdPDAA6n0qAzn9xcZgGaY7C1Fl7yysTXoOVNDVsJQYgKkg2dC2DQBHoGFgIYkVpF0NIbQT1X4FlTqlewLTv5ZnYixeHEapv+lf8T9qgFljyM41WHnjrK2oJXDEkWkdK9cF9j5qgKUryY31Qv249nnPs7jfX6XBfaBYt2fSwE6pnyYDHr/K5DWnhtWX+/x/dvsV9GJThUK7+X12J4PwGn9ZQiabNFdfrP8DUfm1NhstwHNc9hrryo4yTSS8gZN+8X807G8kMlOV5miI+XoZ6AlqBhGEKPFKSkTcUvsqV1bVT8CJc38ngDiXVFy/uE8tmeunul5IZKHlaWPKKzxD9sgG3WOp+n+pDE5LUrWg7SYPg9xssA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aada42ef-085e-453c-3ce7-08ddff58f892
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:06:15.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOwMMwAcYqpwXEtaeDysYpjadtrZspjbzTBcnvQtgEUKCpDf3b5u/slGB+w0MzYZzZdItulQQs9sAOgVh7JuGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290125
X-Authority-Analysis: v=2.4 cv=EczFgfmC c=1 sm=1 tr=0 ts=68da852e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=DPLynbz7qbUbw8Nq_MEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3N-B6JzsGICPkMKpLtIOVE0YCc8OFKjx
X-Proofpoint-ORIG-GUID: 3N-B6JzsGICPkMKpLtIOVE0YCc8OFKjx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDEyMSBTYWx0ZWRfX7+wD6N8uMPkb
 LrATvRVdhWp3CvYne7qk4MdlnVVnGG74NjSS5gLD3Gw4LkD9tX0mYGeegCfjPYZ5OTw0XHfguq6
 6eWSL9cQcvxn3roNVxkE2TKDgP5ZfAng3ByQQRlf5lpPfl3cm3/9FzQF0bzDr7LBfzFjnPVOHcJ
 P7pWDQgk5sqk1oGsDP4nmOZCMGXDuZVsjbljYudT7KToI7uXmjrtmmPT7hpYbHHW0te9zycLjyn
 PgxqIXFRd16+Ssrlqvzad4cW3VOiwU3rnn/b5/QBIDL6UDzqPdlUzNrg4kepIpaYZi0pUXhNuf2
 cSymNCjhFku6PgysvufOzRjY9JYYYCT2jk+a1jPm9YZ6gQXo8MpQfOl40KNwzPUILvGbAQ0MI78
 ZMOnfrzT3WEE9DkMQtCfsu6fmJi8zw==

On 9/29/25 6:03 AM, Chuck Lever wrote:
> On 9/29/25 12:29 AM, Christoph Hellwig wrote:
>> On Fri, Sep 26, 2025 at 10:51:51AM -0400, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> Add an experimental option that forces NFS READ operations to use
>>> direct I/O instead of reading through the NFS server's page cache.
>>>
>>> There are already other layers of caching:
>>>  - The page cache on NFS clients
>>>  - The block device underlying the exported file system
>>
>> What layer of caching is in the "block device" ?
> 
> I wrote this before Damien explained to me that the block devices
> generally don't have a very significant cache at all.
> 
> 
>>> +nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>> +		 struct nfsd_file *nf, loff_t offset, unsigned long *count,
>>> +		 u32 *eof)
>>> +{
>>> +	loff_t dio_start, dio_end;
>>> +	unsigned long v, total;
>>> +	struct iov_iter iter;
>>> +	struct kiocb kiocb;
>>> +	ssize_t host_err;
>>> +	size_t len;
>>> +
>>> +	init_sync_kiocb(&kiocb, nf->nf_file);
>>> +	kiocb.ki_flags |= IOCB_DIRECT;
>>> +
>>> +	/* Read a properly-aligned region of bytes into rq_bvec */
>>> +	dio_start = round_down(offset, nf->nf_dio_read_offset_align);
>>> +	dio_end = round_up(offset + *count, nf->nf_dio_read_offset_align);
>>> +
>>> +	kiocb.ki_pos = dio_start;
>>> +
>>> +	v = 0;
>>> +	total = dio_end - dio_start;
>>> +	while (total && v < rqstp->rq_maxpages &&
>>> +	       rqstp->rq_next_page < rqstp->rq_page_end) {
>>> +		len = min_t(size_t, total, PAGE_SIZE);
>>> +		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
>>> +			      len, 0);
>>> +
>>> +		total -= len;
>>> +		++rqstp->rq_next_page;
>>> +		++v;
>>> +	}
>>> +
>>> +	trace_nfsd_read_direct(rqstp, fhp, offset, *count - total);
>>> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v,
>>> +		      dio_end - dio_start - total);
>>> +
>>> +	host_err = vfs_iocb_iter_read(nf->nf_file, &kiocb, &iter);
>>> +	if (host_err >= 0) {
>>> +		unsigned int pad = offset - dio_start;
>>> +
>>> +		/* The returned payload starts after the pad */
>>> +		rqstp->rq_res.page_base = pad;
>>> +
>>> +		/* Compute the count of bytes to be returned */
>>> +		if (host_err > pad + *count) {
>>> +			host_err = *count;
>>> +		} else if (host_err > pad) {
>>> +			host_err -= pad;
>>> +		} else {
>>> +			host_err = 0;
>>> +		}
>>
>> No need for the braces here.
>>
>>> +	} else if (unlikely(host_err == -EINVAL)) {
>>> +		pr_info_ratelimited("nfsd: Unexpected direct I/O alignment failure\n");
>>> +		host_err = -ESERVERFAULT;
>>> +	}
>>
>> You'll probably want to print s_id to identify the file syste for which
>> this happened.  What is -ESERVERFAULT supposed to mean, btw?

It means, there was an unexpected fault on the server. Software bug.


> 
> Note, this is a "should never happen" condition -- so, exceedingly rare.
> 
> Clients typically turns NFSERR_SERVERFAULT into -EREMOTEIO.
> 
> 
>>> +	case NFSD_IO_DIRECT:
>>> +		if (nf->nf_dio_read_offset_align &&
>>
>> I guess this is the "is direct I/O actually supported" check?  I guess
>> it'll work, but will underreport as very few file system actually
>> report the requirement at the moment.  Can you add a comment explaining
>> the check?
> Well, it's to ensure that the vfs_getattr we did at open time actually
> got a valid value. But effectively, yes, it means "is direct I/O
> available for this file?"
> 
> 


-- 
Chuck Lever

