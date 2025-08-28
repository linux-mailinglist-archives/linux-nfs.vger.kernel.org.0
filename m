Return-Path: <linux-nfs+bounces-13943-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AE0B3A9BC
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 20:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544551C81C66
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 18:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B1A217654;
	Thu, 28 Aug 2025 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OJu2jR7Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DzlocoWC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B99271452
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404996; cv=fail; b=azWlYLCyQD3yW+26qzJCGpebohqPCTAJLwy32hHXwSPEJ8bz8SESOiAm6Su8VJJy+JLY5MJpRYYZQpAYxTqS1aKk5fYMibNd9McQiedbELPRflapoeycT/Mvk4weEJ9qnRPq92IEeGVBcKbRQzasYKqBkJaixfdmxwTQqdpyZbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404996; c=relaxed/simple;
	bh=CehGx3svc26qZUde+uwR5ksQze5ss8Ci/Xn0rbMFNKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BDHv7/8C0J2OUwM+8zxOM/capYlYNrGuL94LgdJPYRc5jAb/nFHaXV8NaXRuKJhe65ILmeY4SOzQgGpWs0SWtnelQFKJz3PzaQXebLGQPbTrI+sedxkIQSyRxAYAC1FI2nOSNBtKwqH2+HN3no0ju4GAx3JV51YVUjwukBNluLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OJu2jR7Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DzlocoWC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SHNRXu006087;
	Thu, 28 Aug 2025 18:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FO98En4w5qn9Y7xTKNIZ0mEdSL02FL+dBLYLBo/CjCQ=; b=
	OJu2jR7Z3yfsUu8ozzFSQZk+nFmUCPvGnElO8uVjGX22sCtrxe3EmRLXuC+BdnDt
	dix29T6USwupijdxoNfwiQJXH87miHJPsosuBTFxKqlhqJjdbY/gfjXq+KdXZX0K
	jIMSb2NbuCIawRkgxPisxzSuOHeg3P6gTJyxoa9Px1NuRp4eUlhU362036aPMvAS
	VmdXVHff3vxTCRxPvc9Zfd4eFJtHb5enMJ9+U84X1amxkapIi8w4gydPdIe/LaqD
	xrSClCEFsceuZfS+c93ECRwjQ8gBDMSdJIwAkgAQ7cxMt8ImE+sT/lqi/SHOR16l
	l8zB0JFDFH8V4zlYXfcXDw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q67914mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 18:16:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SI1xY7027303;
	Thu, 28 Aug 2025 18:16:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43c3rv5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 18:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtAG786Ui3x5x63e2PX7Ps5R/phhIrrMyrHX6D6weJvxaotkNrJWzyZ8KwFPXWPDIxZMkFft2zK8A2CPqjzFRaYl0nvFfw+Vvyb+NjZYU78z72EKD+Iut645ZAfADbpIVFuoDIAdQ/0p/INIzF4qj9SELxZPdA1gCdNdV28wVEAMbRGZKB1Pwi1vPGHfrfhQI8CkL3duyl6WsE6L7EOkI1eqKenHUAPwiKrh1gi9BR2ZWjYabqJUPXT9Z44aaEdhq3T5oC6Mn+IVSYeKMM0IgMfUV/9rF+NB1wvKOEKNlRTeJEx/FP2R5qKFi0uikmK+0grLqwwQpnE0gH9xaH8A+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO98En4w5qn9Y7xTKNIZ0mEdSL02FL+dBLYLBo/CjCQ=;
 b=L/lVHN8JHM/MKGvPXh4vCYlRHlgfXF0mWjYIyuTeB+qKGsBZYu2IrEnKR1L1tpAMmmu6KTtvYe/SxwMRbXh3IJ3kiN/ORDdVSAOAYF4OL0FPtIGPMS2mGTGQVfTIlzGE/tYDNSbQjdPGR2E2G2cNabxS1WNCoxeByH9uzmtRIjnMwUNyFKh3jjA/m79BjOA7duhRZI7P+rJuRm6BH114KF8LA69DgybAWHQjMExqQ2zcPCQVMGOULJvE73NPk2HC4kuV+XgtO1Glh2IUS3D3chqMPENWxsO8+woLxYD6xtJpTe4eCCeFpLTJJYHxHu34EDx6Yxyi4CjE7JLDdZZ5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO98En4w5qn9Y7xTKNIZ0mEdSL02FL+dBLYLBo/CjCQ=;
 b=DzlocoWCBgxIGw5zq1EHnF6ujv0BnxP1894Dv8QQtwTNZZAN0yc4yCnoWKKW8V85hHt6rX1Dv0SrPjwbxJvh6Kn2U8+fqq60hC4dx9zpjeODfQMI5nqlBnSsN4UVqqry63rgZcun38eEctsLbiD4vOgKUA8mI0SR9Fnw0jJTpuE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6438.namprd10.prod.outlook.com (2603:10b6:303:218::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 18:16:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 18:16:17 +0000
Message-ID: <adddae47-63de-4e93-a53a-352ad0e5c772@oracle.com>
Date: Thu, 28 Aug 2025 14:16:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] nfsd: rework how a listener is removed
To: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org, neil@brown.name, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <20250826220001.8235-1-okorniev@redhat.com>
 <41502e2f-0d97-48a3-876f-62c33ae6d657@oracle.com>
 <a641de95-07d3-479d-be64-11d99e56e08b@oracle.com>
 <e56f9194f0e65e85d92da4129f636fe40b34e54c.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e56f9194f0e65e85d92da4129f636fe40b34e54c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 14763a49-a0e8-47a2-04c5-08dde65efb81
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UGZ4RzVWMU1tWmN2OGs5K1psZFVwQzArdEFtVnZjN0lsMVpzTjhzK1VaK1Zw?=
 =?utf-8?B?NzZBWlN6ZUJNQWhUbUtDMjI5ZkFOQVpOdzdaZXFmWEVzbTZKMHJPQXNRNnFh?=
 =?utf-8?B?ZUVNQXBaamx4ZW9QSkhIdXRFWWtDTldKSFNaWUVBVU50dWRyTThteDRPSlkx?=
 =?utf-8?B?MTdkMGNjcVcxcFNScmtnc0VKNTNZSUdtSUVXWDB1MUxSdjBsSjZEM3E2V1hL?=
 =?utf-8?B?QkcvUDhDV3l1bUdwNkxYNW81SzJwclFXRVpEK29VVWtZQU5kcGJiOTRhUFlI?=
 =?utf-8?B?ay9UUUgrSTJ0bkx5WjNnY0l5YUowK3dweXRLVzB2bEU1Vk56ZWZVb3U0SjRC?=
 =?utf-8?B?N1BUZEtRVzB2Ymtja3IxZmpiNU9jcUFJbnM0N1Rwb3NvaDRLYnIya0ZBUXpC?=
 =?utf-8?B?dUp6Y09MdUFIZnJYcjBBcmZrMTVkOVZTZUxRU2p1S2RINXpBMTVuNGVvMjdS?=
 =?utf-8?B?cmdKNkZqamllS0d3UWV6TlA3RnBZUnJ2ZUhod0JqdnhQMzNGeDFYYVhmYkor?=
 =?utf-8?B?T1pFUi9obTc3U2NacTk4dUJqbzl1VnJRVnA3OGk0NnR3QUJ6K2hFVUpMSU9y?=
 =?utf-8?B?V0drY1pBZWdKT2dGeEdIU3kwbW5MaVlLRnZzMXh0UzZqbVE2bWpFUmRvSHVJ?=
 =?utf-8?B?dHpkL2N2WHMrV0VxcWxES2dYZHN1U21qK0pJVXpxRnBiR2crd3liaCt0ZzNM?=
 =?utf-8?B?YVRDdjdoakozTi9iaEtOTGhhYTNmVGVoMFpXcmdoRlZOQWJZZHZseDZaWHli?=
 =?utf-8?B?WEhsNWNGczgzMzJMNkl2MHR0YlFrUjNuV2dMV1ZOSkpoekk3ZElYVU1wQ1pt?=
 =?utf-8?B?N1M3VG5TamViLzd3ZVhhMm1wZTdGNEZCcUNCZHljWjNPT0w2K01nU0FGVGY3?=
 =?utf-8?B?RnBOSUpVL2UwcTBCV3k2NXdkV2tXS1lldDNqMTY1aG4vK1JlcGVqNVFKMmxl?=
 =?utf-8?B?RzVjOHRmbE1tbmRCb211WlROeWUwbnRkZHRzWTFoWjZmcU9GNzJOanluSmNX?=
 =?utf-8?B?WmNEaEpvcDJ2RnNTNlZPd1Y4UU5KM0paTStrMVNPdldVbFlGdU11SDJZdCtw?=
 =?utf-8?B?S2ltVUR2UE5MNGw3ZXMrWS8renJWcUdQMU9qcXNncU9uTFNzMkdaR1pWS2J2?=
 =?utf-8?B?ZnUvYjAxTkZsd1FOcytMbUl0bDlYeUw4cTZVeGovVkpncFRwRGZHVkJXVnN2?=
 =?utf-8?B?c3Nyc3lidEhiMDF0NjFOM25iU0VPaUZZb1ovSEJUYXZzZS9VOVFBaWwyR21v?=
 =?utf-8?B?MFVoMmZuY3k5a3RFNW1nNWI0aXdIWDZlZm90citETStzcjVqalhyQUhGR3BE?=
 =?utf-8?B?b2xMbDhOaW1MaWdhUGh5R3J1WVFoZ1RlZUp1Q2oyeUp1K0c5SkFNNDNXV0I4?=
 =?utf-8?B?VW1PTXY4M2pIZ2J6bkszQzltelV5ZFd2ZDZpS0IrSFM3QjI0VnA5NGhHQTh5?=
 =?utf-8?B?MzVMWElMOWZtNDBWeUFjbHRhaTBjVlRTelppM0IyUjNvR3NxRmN0VnpDM1ZH?=
 =?utf-8?B?OVZpRHZOc0xQRmpzeTRDamJXOFd4bUxrVjFJNkx0dzVIN2xqTmUvVmswQy9v?=
 =?utf-8?B?TVRhQVB3M3dacEZRdmtVNG10YytWVEV4Q3dwSFdldjR1M2Z1Qmh2OFh2c0dU?=
 =?utf-8?B?SGtJR0VzY2haYXdPMlJqZmlLSDVwWGdQSmU4am9JYU91eFJYRG5DdVhnQmh6?=
 =?utf-8?B?bjNudTJXeXB3YmZ5cGRLZjlJL00xZ3A4ajUxYlhKYmkraXB3TFI1UGE2MXEx?=
 =?utf-8?B?dkd5NnlxOVFtdVpjbGZtSmJXVkl4ZHdENjRZcEcyanpSWk1iNDJWempmTjFu?=
 =?utf-8?B?US9RTXVMaGZvTWJyZkRYelp4MUtXVU9NNS9yUzliUlRveEE3aU5pbitXL25S?=
 =?utf-8?B?bFlwMDVwc0xPOWlmMnBZK2JVeVRIUW9NYU9NTmtMLy9NSmRtUXFEeE80Q3JO?=
 =?utf-8?Q?bgHdA6G9Utc=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y05MeDI0eTNOaEtkS2w3aGJJL3RLbEZOdHdjOE15OWtZdHpmN3Q2aUQ5TUpS?=
 =?utf-8?B?R3hvZWRWdytWZEZ5c0lqcytLckhnUTkwdG0vMVRHcEpVRUFrUEhXTFA2a2g2?=
 =?utf-8?B?dk1oK2xDV2t4cm1aUVl1blpqdjFvSkFFUWlSZmdHMWdKTFlWVjVoU3Z2NkhW?=
 =?utf-8?B?RHZLZWlDdHF2S3R5WWJuL2lJZVV3Sk5MTkYzem1mZnU0NlQyZVRTdTFnUTdu?=
 =?utf-8?B?WGx5WWdKM2t1aEhreDc1Y04xRkZyWW5UbS9Xa1IrMnFIME5xU1lBVHpNcXRj?=
 =?utf-8?B?WXJQRHlveWwxc2pRTXV2SjZackRLdnV1M1lzdHp3b0JDMDdMV3FUazk3Kyt2?=
 =?utf-8?B?dTFxMlJaandkdDZJQnhHekhuOGVhaEVEaHNtSlNqeUl0K3pTYVpUaHpFTW5F?=
 =?utf-8?B?dnBXV3UrWG5zWmxWeVRmb1lDYnJzUjVrcUVmYTFFbExNU0t3OWMrVGp0UkJl?=
 =?utf-8?B?aXg4Y0J0TFpOSG8xcksraFJDRDVXSi84aW4vZVBuSGx0YWVkN0xtNjBaWXpG?=
 =?utf-8?B?T2I3bzFrTC9kZW1XSWpwQ1JhODlNTk9hN2JDOVRQSDFOSmZHK0M5dFBQb1J2?=
 =?utf-8?B?WXQ5d1dFYlpOYmQ2bnVoM0FvVzVHZlZjTFgvYkNRQzRPNE5yb01yNFN6M1ha?=
 =?utf-8?B?SkxubVIrbVJqMk9DN0NsK3M2dG5LS2FwTENGcXM4a21PaDlwOGl6L0Zsc0J2?=
 =?utf-8?B?dkVZRytrV1NmdFk2WVphUm91azQzb1gvS05FOHc3SVhOVGFsUkx5ODc4UkZQ?=
 =?utf-8?B?TzY3NHR3KzBlRTlnTloxclZEWUY4NlRGMytiejh2UE1RSEtkNnFXem5HcVlm?=
 =?utf-8?B?WU5Ycy9nNjNqTUNtSm5tVEVsSi9tWkFYMVhJWklhaW9La0xIM2E2YXdwWXl1?=
 =?utf-8?B?N1lrTmk3UUJ6bzdUNnhsTm5FNmd0VWhRNjEwOVZwQ3RNRE90TUtGa201eFR2?=
 =?utf-8?B?N2NXNmI4UXc5ZjNYQlRFK1VtT2ZJdWJvbDhOakFoaE1DWEkxdFdQa1d1NmNG?=
 =?utf-8?B?SWR3ZFVPUUZCYjI3Zm9IRDduTUhEb2lkcUF0dmJDK29uY0FjcVZOMnRTc09T?=
 =?utf-8?B?ZnNkcDJHWkpvRzZKeVRwVVUweFF1U2M1QnUyQkZjRjg0UG1rNGtqeGM5bmdT?=
 =?utf-8?B?cjNScWpVWXhZbmFRbnV6MzJFdlM4ekx1UXd0ZExvRnRQWCs0bEgxYmF5Ui9r?=
 =?utf-8?B?MGlUdGU0NUcxeUNNTzRjUDBIUWl0a0hhUTJsWlllaGNYcEQxZlNmZ1VVRXdY?=
 =?utf-8?B?MndYdnlIRkhCbWJVVHNnMENZQUREeHY1dk5iNkZZamZNYWtUY0FLU0k4ei9h?=
 =?utf-8?B?MjA3b1RoYXVnVHhLZGFLaGVMbXF5QXhxajBLaG9ReGk3Y1JVMlpITjVtOUFG?=
 =?utf-8?B?cnFCT3doVVdnc3phS1QxME9qZThrVW5qTzliWlMzdS9LM1VSSmpEOFR5UFln?=
 =?utf-8?B?VS9QbGRJL2FYWlBOcXV6TTVKWDAwQXAxdGZta3VYZVN4dWdyQk5DNlZnRHFG?=
 =?utf-8?B?V0UwYUtwZmFnU1YwWFlyenk5RFVSVUdPRjRMR2YvbEhnYTQ3cU5YOWlPcWl5?=
 =?utf-8?B?U3VoWXhEWDMxVzdHaEpBU3REejZNNk9ONHk5bTMxcUU3VG8yeXJwRmhMRlBo?=
 =?utf-8?B?NG1lN2d2UTFyQWxPV0x5ZEJOM3Q2WW9pMzFld1NtNWJKeDUydzBGTDJObTlr?=
 =?utf-8?B?UjZRU0NlNGsyYzM3dEFwSG9neHdjTnQ4aVJkZ21XTlRSNUhLc293Tks5UWR3?=
 =?utf-8?B?WnhPWWhPSnVyczV2dVdWOGliL1FGUFlJU0FWUlp1Zng2TDBWWHlzbVVVNjdn?=
 =?utf-8?B?RGQzbU40Mk5tWmgwWHZtT2NSRnBDb3h6MThObDZIY1puZzNTb0I5SXZ1Nm01?=
 =?utf-8?B?UFFPbjZWUXpxdlRHSnlBWWZ6amhoY0hIMU9NUXh6Vm9GTVViQ0x0TVFYZkdQ?=
 =?utf-8?B?QXV6ckVPNys0aDcvTFZMbmF5T2J5blUzVmkvbTRmWTl4cUtBenhwNEExT0FB?=
 =?utf-8?B?Z1VrSnRpYWFHbWdsTUdsdnFPazFlUzQ2aHFIdkxlVFA3bC9DM1h0S1BxODZt?=
 =?utf-8?B?WXBUK1dINkxvTUh0aGcxcTYrck11eUZSZ3dkUWVVSnB0T0ZjR1BMdE1XQU4z?=
 =?utf-8?B?WFZGTUgxR21Bckx0czJTVDg5NkgrK1VhRGJCOEhtb0I5ODZkU3FSUERLdzBq?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KOxpbkyy89YG2BkPDgs/boFLNLXCiORi/ltPSYmu98pSaJcgAoNDR0eRJhEuHeKAi2pAUqVdUz96U8txI2oFnLUp+kGON1X2BGF6E75+UkSOLxsNVdpIvCpTMxcxK+i3/ZdiKoIVDaPTPCIqB8KyfVpLmsiCxT5wRH+bZlNu4nm9KH4K05ctw43LHFCYiGhUxYccGK+1wW9xfHXRlIHTzi720CjRPZy/eYJWZuCA9t12lx6zrFmGhrtM2oY6A5XfJQ1wLJ6yTV1TayvhzIbUIkcj+F4TgNlziUxCJpdgcyt2y0yVpgBLTroeSZsiwO2PzWPKhNPq//IzRp2TbLCWtUZCeYCkjlFB6HPiNiZ+qCBHGTh3HzRpkAllxo1rZVhydnOiHUGMq3xQHTkFJqkMUSpR//pd+Rl5XYkVqA7/RdZrP5co0J0Wm6ITmHjgKDWrbGByhAi9qvrQ0NTyKWTnnbLWN52EkUyFYnf4KOPGhEdkAbHD5hQRo5/4rDOrgFO9OTd474uvIK9BMkeYOt6mE2ln/0QvEPnL4kwLze8EZJtPaKbQKy1iSiufklzCJ8Rp/pvqUnJSVXIJ0TpIUzpBOeunRsPceUDK/RENhSlm55A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14763a49-a0e8-47a2-04c5-08dde65efb81
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:16:17.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9wXFUAXtP8ssuVsO0dZK8R6Fbbf5TbEc7+yfZEYSYcy4Mn/V+oX3vtSjko77Hm6UxiH6sdv9a7lzTnrKGQGnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6438
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280153
X-Proofpoint-GUID: EmJaRY44oxeAM_juNGfotFMBGxgbzIRe
X-Proofpoint-ORIG-GUID: EmJaRY44oxeAM_juNGfotFMBGxgbzIRe
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68b09cfc cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=wBb9nDm8n8QG723pn4QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfX2LYGL0aueug1
 jSL6LUgFr8aueCeCqZl8scljt7McTG/eKdueV28OX9DhxIacIBYdM4njIdyEFAupDgV8GZBxML4
 bu9Bf04G6FZFhMZkY6xz0TBXg47wR40loW6jS8XDNbalV+KO3Uc20ZftvXaXmQZgCibNmVwWH+C
 bM3GdNAMS22XJGKU0QiHNniLu4rDthJFuYZldDRVraxtszPefXfwYJZIhbluaBt24pb8VVllC1h
 rnEV7HjW9a3na+2Bj/IHU0Uny4h//92Ezhi2aVnkWDQe3iRBnCv4s/cg0blN11emwkz/rMM3dga
 ltT33B1s6u7cLwy4UBtjek+VPYkOqzu/mxlPB47HQ/uawIi91PUlSTtsCoOznH5giBclrNAofFP
 iNaBmgVE

On 8/28/25 1:29 PM, Jeff Layton wrote:
> On Thu, 2025-08-28 at 11:21 -0400, Chuck Lever wrote:
>> On 8/27/25 10:21 AM, Chuck Lever wrote:
>>> On 8/26/25 6:00 PM, Olga Kornievskaia wrote:
>>>> This patch tries to address the following failure:
>>>> nfsdctl threads 0
>>>> nfsdctl listener +rdma::20049
>>>> nfsdctl listener +tcp::2049
>>>> nfsdctl listener -tcp::2049
>>>> nfsdctl: Error: Cannot assign requested address
>>>>
>>>> The reason for the failure is due to the fact that socket cleanup only
>>>> happens in __svc_rdma_free() which is a deferred work triggers when an
>>>> rdma transport is destroyed. To remove a listener nfsdctl is forced to
>>>> first remove all transports via svc_xprt_destroy_all() and then re-add
>>>> the ones that are left. Due to the fact that there isn't a way to
>>>> delete a particular entry from server's lwq sp_xprts that stores
>>>> transports. Going back to the deferred work done in __svc_rdma_free(),
>>>> the work might not get to run before nfsd_nl_listener_set_doit() creates
>>>> the new transports. As a result, it finds that something is still
>>>> listening of the rdma port and rdma_bind_addr() fails.
>>>>
>>>> Instead of using svc_xprt_destroy_all() to manipulate the sp_xprt,
>>>> instead introduce a function that just dequeues all transports. Then,
>>>> we add non-removed transports back to the list.
>>>>
>>>> Still not allowing to remove a listener while the server is active.
>>>>
>>>> We need to make several passes over the list of existing/new list
>>>> entries. On the first pass we determined if any of the entries need
>>>> to be removed. If so, we then check if the server has no active
>>>> threads. Then we dequeue all the transports and then go over the
>>>> list and recreate both permsocks list and sp_xprts lists. Then,
>>>> for the deleted transports, the transport is closed.
>>>
>>>> --- Comments:
>>>> (1) There is still a restriction on removing an active listener as
>>>> I dont know how to handle if the transport to be remove is currently
>>>> serving a request (it won't be on the sp_xprt list I believe?).
>>>
>>> This is a good reason why just setting a bit in the xprt and waiting for
>>> the close to complete is probably a better strategy than draining and
>>> refilling the permsock list.
>>>
>>> The idea of setting XPT_CLOSE and enqueuing the transport ... you know,
>>> like this:
>>>
>>>  151 /**
>>>
>>>  152  * svc_xprt_deferred_close - Close a transport
>>>
>>>  153  * @xprt: transport instance
>>>
>>>  154  *
>>>
>>>  155  * Used in contexts that need to defer the work of shutting down
>>>
>>>  156  * the transport to an nfsd thread.
>>>
>>>  157  */
>>>
>>>  158 void svc_xprt_deferred_close(struct svc_xprt *xprt)
>>>
>>>  159 {
>>>
>>>  160         trace_svc_xprt_close(xprt);
>>>
>>>  161         if (!test_and_set_bit(XPT_CLOSE, &xprt->xpt_flags))
>>>
>>>  162                 svc_xprt_enqueue(xprt);
>>>
>>>  163 }
>>>
>>>  164 EXPORT_SYMBOL_GPL(svc_xprt_deferred_close);
>>>
>>> I expect that eventually the xprt will show up to svc_handle_xprt() and
>>> get deleted there. But you might still need some serialization with
>>>   ->xpo_accept ?
>>
>> It occurred to me why the deferred close mechanism doesn't work: it
>> relies on having an nfsd thread to pick up the deferred work.
>>
>> If listener removal requires all nfsd threads to be terminated, there
>> is no thread to pick up the xprt and close it.
>>
> 
> Interesting. I guess that the old nfsdfs file just didn't allow you to
> get into this situation, since you couldn't remove a listener at all.
> 
> It really sounds like we just need a more selective version of
> svc_clean_up_xprts(). Something that can dequeue everything, close the
> ones that need to be closed (synchronously) and then requeues the rest.

That is roughly what Olga has done here. Now that I understand the
problem space a little better, maybe we can iterate on this.


>>>> In general, I'm unsure if there are other things I'm not considering.
>>>> (2) I'm questioning if in svc_xprt_dequeue_all() it is correct. I
>>>> used svc_cleanup_up_xprts() as the example.
>>>>> Fixes: d093c90892607 ("nfsd: fix management of listener transports")
>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>> ---
>>>>  fs/nfsd/nfsctl.c                | 123 +++++++++++++++++++-------------
>>>>  include/linux/sunrpc/svc_xprt.h |   1 +
>>>>  include/linux/sunrpc/svcsock.h  |   1 -
>>>>  net/sunrpc/svc_xprt.c           |  12 ++++
>>>>  4 files changed, 88 insertions(+), 49 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>> index dd3267b4c203..38aaaef4734e 100644
>>>> --- a/fs/nfsd/nfsctl.c
>>>> +++ b/fs/nfsd/nfsctl.c
>>>> @@ -1902,44 +1902,17 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
>>>>  	return err;
>>>>  }
>>>>  
>>>> -/**
>>>> - * nfsd_nl_listener_set_doit - set the nfs running sockets
>>>> - * @skb: reply buffer
>>>> - * @info: netlink metadata and command arguments
>>>> - *
>>>> - * Return 0 on success or a negative errno.
>>>> - */
>>>> -int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>> +static void _nfsd_walk_listeners(struct genl_info *info, struct svc_serv *serv,
>>>> +				 struct list_head *permsocks, int modify_xprt)
>>>
>>> So this function looks for the one listener we need to remove.
>>>
>>> Should removing a listener also close down all active temporary sockets
>>> for the service, or should it kill only the ones that were established
>>> via the listener being removed, or should it leave all active temporary
>>> sockets in place?
>>>
>>> Perhaps this is why /all/ permanent and temporary sockets are currently
>>> being removed. Once the target listener is gone, clients can't
>>> re-establish new connections, and the service is effectively ready to
>>> be shut down cleanly.
>>>
>>>
>>>>  {
>>>>  	struct net *net = genl_info_net(info);
>>>> -	struct svc_xprt *xprt, *tmp;
>>>>  	const struct nlattr *attr;
>>>> -	struct svc_serv *serv;
>>>> -	LIST_HEAD(permsocks);
>>>> -	struct nfsd_net *nn;
>>>> -	bool delete = false;
>>>> -	int err, rem;
>>>> -
>>>> -	mutex_lock(&nfsd_mutex);
>>>> -
>>>> -	err = nfsd_create_serv(net);
>>>> -	if (err) {
>>>> -		mutex_unlock(&nfsd_mutex);
>>>> -		return err;
>>>> -	}
>>>> -
>>>> -	nn = net_generic(net, nfsd_net_id);
>>>> -	serv = nn->nfsd_serv;
>>>> -
>>>> -	spin_lock_bh(&serv->sv_lock);
>>>> +	struct svc_xprt *xprt, *tmp;
>>>> +	int rem;
>>>>  
>>>> -	/* Move all of the old listener sockets to a temp list */
>>>> -	list_splice_init(&serv->sv_permsocks, &permsocks);
>>>> +	if (modify_xprt)
>>>> +		svc_xprt_dequeue_all(serv);
>>>>  
>>>> -	/*
>>>> -	 * Walk the list of server_socks from userland and move any that match
>>>> -	 * back to sv_permsocks
>>>> -	 */
>>>>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>>>>  		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
>>>>  		const char *xcl_name;
>>>> @@ -1962,7 +1935,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>  		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
>>>>  
>>>>  		/* Put back any matching sockets */
>>>> -		list_for_each_entry_safe(xprt, tmp, &permsocks, xpt_list) {
>>>> +		list_for_each_entry_safe(xprt, tmp, permsocks, xpt_list) {
>>>>  			/* This shouldn't be possible */
>>>>  			if (WARN_ON_ONCE(xprt->xpt_net != net)) {
>>>>  				list_move(&xprt->xpt_list, &serv->sv_permsocks);
>>>> @@ -1971,35 +1944,89 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>  
>>>>  			/* If everything matches, put it back */
>>>>  			if (!strcmp(xprt->xpt_class->xcl_name, xcl_name) &&
>>>> -			    rpc_cmp_addr_port(sa, (struct sockaddr *)&xprt->xpt_local)) {
>>>> +			    rpc_cmp_addr_port(sa,
>>>> +				    (struct sockaddr *)&xprt->xpt_local)) {
>>>>  				list_move(&xprt->xpt_list, &serv->sv_permsocks);
>>>> +				if (modify_xprt)
>>>> +					svc_xprt_enqueue(xprt);
>>>>  				break;
>>>>  			}
>>>>  		}
>>>>  	}
>>>> +}
>>>> +
>>>> +/**
>>>> + * nfsd_nl_listener_set_doit - set the nfs running sockets
>>>> + * @skb: reply buffer
>>>> + * @info: netlink metadata and command arguments
>>>> + *
>>>> + * Return 0 on success or a negative errno.
>>>> + */
>>>> +int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>> +{
>>>> +	struct net *net = genl_info_net(info);
>>>> +	struct svc_xprt *xprt;
>>>> +	const struct nlattr *attr;
>>>> +	struct svc_serv *serv;
>>>> +	LIST_HEAD(permsocks);
>>>> +	struct nfsd_net *nn;
>>>> +	bool delete = false;
>>>> +	int err, rem;
>>>> +
>>>> +	mutex_lock(&nfsd_mutex);
>>>> +
>>>> +	err = nfsd_create_serv(net);
>>>> +	if (err) {
>>>> +		mutex_unlock(&nfsd_mutex);
>>>> +		return err;
>>>> +	}
>>>> +
>>>> +	nn = net_generic(net, nfsd_net_id);
>>>> +	serv = nn->nfsd_serv;
>>>> +
>>>> +	spin_lock_bh(&serv->sv_lock);
>>>> +
>>>> +	/* Move all of the old listener sockets to a temp list */
>>>> +	list_splice_init(&serv->sv_permsocks, &permsocks);
>>>>  
>>>>  	/*
>>>> -	 * If there are listener transports remaining on the permsocks list,
>>>> -	 * it means we were asked to remove a listener.
>>>> +	 * Walk the list of server_socks from userland and move any that match
>>>> +	 * back to sv_permsocks. Determine if anything needs to be removed so
>>>> +	 * don't manipulate sp_xprts list.
>>>>  	 */
>>>> -	if (!list_empty(&permsocks)) {
>>>> -		list_splice_init(&permsocks, &serv->sv_permsocks);
>>>> -		delete = true;
>>>> -	}
>>>> -	spin_unlock_bh(&serv->sv_lock);
>>>> +	_nfsd_walk_listeners(info, serv, &permsocks, false);
>>>>  
>>>> -	/* Do not remove listeners while there are active threads. */
>>>> -	if (serv->sv_nrthreads) {
>>>> +	/* For now, no removing old sockets while server is running */
>>>> +	if (serv->sv_nrthreads && !list_empty(&permsocks)) {
>>>> +		list_splice_init(&permsocks, &serv->sv_permsocks);
>>>> +		spin_unlock_bh(&serv->sv_lock);
>>>>  		err = -EBUSY;
>>>>  		goto out_unlock_mtx;
>>>>  	}
>>>>  
>>>>  	/*
>>>> -	 * Since we can't delete an arbitrary llist entry, destroy the
>>>> -	 * remaining listeners and recreate the list.
>>>> +	 * If there are listener transports remaining on the permsocks list,
>>>> +	 * it means we were asked to remove a listener. Walk the list again,
>>>> +	 * but this time also manage the sp_xprts but first removing all of
>>>> +	 * them and only adding back the ones not being deleted. Then close
>>>> +	 * the ones left on the list.
>>>>  	 */
>>>> -	if (delete)
>>>> -		svc_xprt_destroy_all(serv, net, false);
>>>> +	if (!list_empty(&permsocks)) {
>>>> +		list_splice_init(&permsocks, &serv->sv_permsocks);
>>>> +		list_splice_init(&serv->sv_permsocks, &permsocks);
>>>> +		_nfsd_walk_listeners(info, serv, &permsocks, true);
>>>> +		while (!list_empty(&permsocks)) {
>>>> +			xprt = list_first_entry(&permsocks, struct svc_xprt, xpt_list);
>>>> +			clear_bit(XPT_BUSY, &xprt->xpt_flags);
>>>> +			set_bit(XPT_CLOSE, &xprt->xpt_flags);
>>>> +			spin_unlock_bh(&serv->sv_lock);
>>>> +			svc_xprt_close(xprt);
>>>> +			spin_lock_bh(&serv->sv_lock);
>>>> +		}
>>>> +		spin_unlock_bh(&serv->sv_lock);
>>>> +		goto out_unlock_mtx;
>>>> +	}
>>>> +	spin_unlock_bh(&serv->sv_lock);
>>>>  
>>>>  	/* walk list of addrs again, open any that still don't exist */
>>>>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>>>> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
>>>> index da2a2531e110..7038fd8ef20a 100644
>>>> --- a/include/linux/sunrpc/svc_xprt.h
>>>> +++ b/include/linux/sunrpc/svc_xprt.h
>>>> @@ -186,6 +186,7 @@ int	svc_xprt_names(struct svc_serv *serv, char *buf, const int buflen);
>>>>  void	svc_add_new_perm_xprt(struct svc_serv *serv, struct svc_xprt *xprt);
>>>>  void	svc_age_temp_xprts_now(struct svc_serv *, struct sockaddr *);
>>>>  void	svc_xprt_deferred_close(struct svc_xprt *xprt);
>>>> +void	svc_xprt_dequeue_all(struct svc_serv *serv);
>>>>  
>>>>  static inline void svc_xprt_get(struct svc_xprt *xprt)
>>>>  {
>>>> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
>>>> index 963bbe251e52..4c1be01afdb7 100644
>>>> --- a/include/linux/sunrpc/svcsock.h
>>>> +++ b/include/linux/sunrpc/svcsock.h
>>>> @@ -65,7 +65,6 @@ int		svc_addsock(struct svc_serv *serv, struct net *net,
>>>>  			    const struct cred *cred);
>>>>  void		svc_init_xprt_sock(void);
>>>>  void		svc_cleanup_xprt_sock(void);
>>>> -
>>>>  /*
>>>>   * svc_makesock socket characteristics
>>>>   */
>>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>>> index 6973184ff667..2aa46b9468d4 100644
>>>> --- a/net/sunrpc/svc_xprt.c
>>>> +++ b/net/sunrpc/svc_xprt.c
>>>> @@ -890,6 +890,18 @@ void svc_recv(struct svc_rqst *rqstp)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(svc_recv);
>>>>  
>>>> +void svc_xprt_dequeue_all(struct svc_serv *serv)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < serv->sv_nrpools; i++) {
>>>> +		struct svc_pool *pool = &serv->sv_pools[i];
>>>> +
>>>> +		lwq_dequeue_all(&pool->sp_xprts);
>>>> +	}
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(svc_xprt_dequeue_all);
>>>> +
>>>>  /**
>>>>   * svc_send - Return reply to client
>>>>   * @rqstp: RPC transaction context
>>>
>>>
>>
> 


-- 
Chuck Lever

