Return-Path: <linux-nfs+bounces-2505-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAAA88F019
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 21:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3AB29A90A
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 20:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0439F14F9FD;
	Wed, 27 Mar 2024 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iEKCntZP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UKrQywkv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0321514F5
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571320; cv=fail; b=DCeNeznrXUhBZZXQ79d2EkVUaLb1OimsoiXKBH4pn+8wtZbIuBIBkg0YKGEHNcXm3Bw+09oR/DZGpM9TwQXxGC9JPQKhWnigp3PhEJkiWQ1MHEoTCYq3QuIuoWnzNFaWbE2AJzGLx04j5DnNIonze9oDpvMzMkpIjP4os9u8+9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571320; c=relaxed/simple;
	bh=uunIMJqRvk3TZ56kZ5DocFtONcXaW+rsVBH4t2Sm1P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W0z3fOY005+tchT9/NHaWHKw+b1+MhWjo2gjG4SLC67GUpsPqpRap2kdGVJzLqvR3rukP54o9cD9xFW9hy690SEDiKuOYv1BxGeLE0PHlRrO0FsNjLCHX20jjO79SMTDF5cTFYCXcYtORReqMqgbpnvw+kC4ZAof8ImoNUPm4dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iEKCntZP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UKrQywkv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42RJudRW017291;
	Wed, 27 Mar 2024 20:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=OATERXpF2I0dCjxV6LeCImi+cak2RD/21TU4wdTggcU=;
 b=iEKCntZPNIFdK54OnRyp86lZaLHsNc6SsJsDUx1mPXtL1bFnNeVh31j14+awT7ewP954
 jYh4BHwLMEGz2jKBM4HrAlCWzhGqQO+jkBQxwFs9dFfykiaFebL2GVPrZPXaDAdLe1qb
 UaF14NVll6itMv2ZlujIKT2uD+dtAz9We+ZBnpp1RJSw3AEOcx/SjSe7ojS1ZGPpPS6j
 1hWU9WNsHFsrW1Nub9IyMPO2075jr8JbjzqYhDyfzTg50H9vQnU3NvobICzd3WjoJBm5
 E3fH9eVxSVy1ouaqXql/sAhulAF7dDegYd38yoSw/PMz3NpEo0VNldJD4mYegWMlAhEF jQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1pybr9g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 20:28:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42RIiVJ8018137;
	Wed, 27 Mar 2024 20:28:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh99xsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 20:28:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3fdNn+HC9MRS4Em/nsdkJUogl4JrNiciUtdD3eFaNGCcMsPNVp1VNgjoS1NVTIhDmHFX9ElbmxzRYIX0hpLG2hnJapKSDBkjFIwnM9OwB+m5NZLw/7aMHd5qMhjjwr8QUCEnJ0/HPPi1Fu52FzffVg727MZ6e/J0XCvNIvlj30iF0W+futfKUKMVxZUfM5b8gBUF8zvoWobl8qqKXl3rfMPx2ecPkbF+udijzDTqD9g/CI6pcxTXjDpwzJf4pYpsabxMPTdUlT4de+fGXLqT7uA5jIw6rYoBhcDaObEBgMgBHB53B32bOTOMak77bbL/5m5h+pwiB3dBFBnWTonNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OATERXpF2I0dCjxV6LeCImi+cak2RD/21TU4wdTggcU=;
 b=HfIyWmYGTMa3V0oO2ayBnCn5ajWAE2BFfh7nelddsnWST/YeqwZvwALwOZspZG08I+PNjq1heLJRsUt2gsufC4X02Vxca3AltQWNzwfWchxoeCJqi9pv6gih4Y/E4+GG09RKZSLqylsubCOPRi28DdwQmLggvve1QQHd/QZ1RzHj+6HQJzJC3CxoH+vo9nueeBM1URqOJmYaoBVoUm5+X6lIHrdYB/lZpIIQUJA7pbkZ8djVU3pv1naHOwQk1lJdRdc2tkdofK0EJcU2GXB8d68KBbks8qkZQF0wA2BbkcW88uBfHVkgu5m5pWDmdUiMNBgRlYqHH00rrtmf3FXUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OATERXpF2I0dCjxV6LeCImi+cak2RD/21TU4wdTggcU=;
 b=UKrQywkvkhJrxqixfa8VHPIvXbip4KLC0lGJtGKhmkJr0QJaGAdxCOd7OG6acMq+e1kPGbl8RIZ5wBo29MzlDWcevhKcKTUBSj6YgntN5tVXBmTwZh+rjjoBdRzn+uSlVjALJ9aUfdY0TFemGoQ8LzUrrr4b2Yj4i7o5UhVjU9c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7871.namprd10.prod.outlook.com (2603:10b6:408:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 20:28:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 20:28:33 +0000
Date: Wed, 27 Mar 2024 16:28:30 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Roland Mainz <roland.mainz@nrubsig.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: "svc_tcp_read_marker nfsd RPC fragment too large" with Linux 6.6
 LTS nfsd ...
Message-ID: <ZgSBbtjBwd5nOXSu@tissot.1015granger.net>
References: <CAKAoaQng8vUV2uHNwNxhcL-d17ULPqO0iCSUmVKHunfSaHLMTg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKAoaQng8vUV2uHNwNxhcL-d17ULPqO0iCSUmVKHunfSaHLMTg@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:610:e5::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e95f18a-e3b7-41e7-4a71-08dc4e9c78eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Mx1RS0UCX4jTbo6AlzGVYoj2039wk5OQ5hP1ibPgH8vqg10EBgkhZa3FPaMTk5e+rllYGYM+WKkJLOHW9bD4MwneShoMEsQ4tkCkQJyEmxBH53IKBEEM8AMEE5kcohTFZkZ2yJRgdnboUSrvXnJY+CFR9HfzLSCO5CT74x4h/Crio63lSIHiaaxcCX9syDuPbmONtNMsgVLhFP5lmS1w25iegvSjTBo8dpSYINIbINB51hdP71F156EzfpeiotFoXe/Do+pgY0VajjAjbi1lXJ/CGJf8aIhdHD9z91/Lm5A2JqJT+pRlS9uLeSjfHfVunmeM19xFoQQ7ggnWhh9qvkPHBMxT7+7EGxCsrm8x9vhVf+lpYvci8STasUr5Hwhx4e9swszOtoXERMYl4CqK4TbIwNzdRQaEmjVtt2zqwmpkFr8fu9VfkI7ufs9sM10R0eCTGP9DbZre8rYLnJqB45hz5orJ1ToCgp3PKVnGeH3vb6hrxwWtwwUFR0q6QUE5XgV2XoEw2dhwIcb7qg9YutQ+OQlZJkQMdsYBVtssTM4Kqw3xGMsRGH4pp65PrZ1uAZghUpCAiV8Rrgh5t2dEm8YqYwNVCohOvTE+QTK9GaPGnBkFAbqJrrwj+d2sz4m3lI53wYDVMxKY3LHUOJ2ydb20QwVwQn51JYyQZnjoBHQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kvi7jtWHD1r9y3FQFpF6FB3K3vfDvB+f0bi+v6eMRwfTWEoFw14b6VhRnyWG?=
 =?us-ascii?Q?s+Kj4QGY9PKtQBNE4HZ8fbbCbzxxNScw4O0YWvu9FfTJGR5or7/EROqBaX4S?=
 =?us-ascii?Q?c/Lma1zehza1dXqq6oFfk73qlx0d0byStEnzy7NunKqSc+EFCS4q32lFU5kz?=
 =?us-ascii?Q?QjTkx1sd76WyrzCiFgYIVyCacWlr3TShK8nZwY+O7zqHq2dNC989oLD5QNmw?=
 =?us-ascii?Q?WnN7ETvGHH/5Y7kQXXmW8z+HpZ0VEEZ8FUP0gMq7Xru3MZpNmxlRC8RhCBcH?=
 =?us-ascii?Q?8bZm5bdCN5yKkXsJeOMQ5Fe2PdKI0zXz0KC6TPMvSYkIgnR/yrOIYEkXJ0xM?=
 =?us-ascii?Q?JSVkhVfEQlFR1a8MgObhxNce2qRNuLM6+yN0k6v/w6bGpX3iicpoH/X4JCnF?=
 =?us-ascii?Q?IvjKLHDpmkpwS/+qi11EnVY+4u2kIrtfI1opBcrujRQxUAqp0u3gUkcQP+Vz?=
 =?us-ascii?Q?KfREUSugmHx7Yj3xUfkMbBlRh123hzyLWacBUKS39/tibdDi4O9vAPDieA8r?=
 =?us-ascii?Q?17jicWlE0Mm7NbtycuC5+vPOIM+E6thbmtCDvPpXEyxOL2ARrYysZxWHlD2B?=
 =?us-ascii?Q?vAV24TwhS0fAJK1puCFp2zZHIVz0KtZ5uat7qNtIRIvDLvGS55ItZkb0siEn?=
 =?us-ascii?Q?DmMl7mV9D7QJc7g+LtjGFOYuGlVVZ6auV6KpH+wVxHIn6Cc6x3E6KyqUd8VA?=
 =?us-ascii?Q?OU0ZU7nrIPmccRmJ06C7fjyO1Gjlu2RYm6m1a+8OaIl608qCFEhnQJ5LqZ9N?=
 =?us-ascii?Q?rr4ECnoLQNzCLvK+xv0/mkad8479rR8STB37PhwPZiXg5YmRpCIxxmvGYEBb?=
 =?us-ascii?Q?/gHbfswhdOJaPZt9f6FITfshsRWkuyhpIS+U1ZPnt0bfyUCNb1nx/BPhWZuW?=
 =?us-ascii?Q?K5xb+ruUFjTuKODNZkS4wHsYyYk+G7zlwJTJ+FxmDxrP3hz/7jvVSf3LUhHS?=
 =?us-ascii?Q?BLKLelwuSjwWC4/+ht8MIigATWBg9zovE56+ruyFpKlkMtmA4sRrMliYTVeN?=
 =?us-ascii?Q?vMEt8R+MQ56kxKGbGOEzFJwPz3hFrPOAfSz1OMuytMsUMl7J/XBGopYqm94K?=
 =?us-ascii?Q?r2UrFwDik4VIAJNBuYrUlf4+1Fr5QWCj4E6m3MtJG2dPyzwJ+QxPrC9oNowM?=
 =?us-ascii?Q?d01sSV3ByeoVy8upZO24YjEP0mwD/toQ7zNZ0U4Amtv9w9jxxi6nwjvP83/4?=
 =?us-ascii?Q?U69XtL1yGTUYE7WaLakeQED00hYSLz0vzm/Kz4PtDNcaFgmsm9pxeB74km4Q?=
 =?us-ascii?Q?GBdSwRlVqkNtvMfXiBc4RJfyXhm8QKH+EeGqnfbeMfVjhbwitTC7TN9y0rsJ?=
 =?us-ascii?Q?apN7rJIbLy8TjvuHXV/WlRbr/+r8nYBTGvm060M2Fd+rxaTV4ifGUGTCbQHz?=
 =?us-ascii?Q?Aud6jl5m5tX6EY1Z7UCN59Tx+qeUn9LRL/HO3RLAafiBL+liX0tQezTqS9tB?=
 =?us-ascii?Q?skRsSAavg1oSaA6l9gvAD7CnhmTmiDYIZwKPrxuFAhYQRMEodRXBI0+5+Q9G?=
 =?us-ascii?Q?KZVsdYdRJ/hAKUIx8TjqeYsBRr+6RDaxaHQ/o74xhlazRDpE+hkMIfg3knqL?=
 =?us-ascii?Q?dVa13Omoba7uwGra1eL4nr34sfdz/OO5HYtwMbNuitYbTBTGUhJr0/df2bRs?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vXDUc+KJjI2pnmlubhp6e1IpFbIIoyUmdj5BPcuaONCquEjiOUp7+Ld9szrzI7lgHNndTLYM8cNFQyjLRtZQlpnVExJoJV6ToAWJZ63y7vTKKluZegLftII11WOBmghhB3E2sXirPkmE3jq/D7XJkcD7s23HZ17cW3sKRWt9re4H/EegueX6bau078EtqSWh1uPfOHKopcAgZYTZdde6Bj6tUJxmCELL5dBIb4b8ajZmPreEczV9IfRVJ9Zhpyige/DvWR2sDH6XANZZOUUdDpPia0DGdn4avT8GATmF00WaEpaJM+g2nHIU+QfQHxwncQWeHobPvVLMBvx3Z3cACJTPIDUqDAxnV/hPxYbOrfAn1aYBC9X8zjt6uBByH34MLJk6jIsApWDqLLofuNpsyaHFvpI9c5JTQQMgkt2eT6G1jUOCVxUOw+YHDORIVR2oP0ypi0mCxpu2RxnSdp+MO7SVAMq0gz+zO2euoOmL5Xp0il1xY6AyxBUk2Oz47Bz0BzZ2etThhfc5ExpZY/dAiSoYPO8kynNPTLX2MjWethKWlpajDn4RnqIuKegACbjxiIPvHKkuFvOuL0WPZ1UTznqeW4SrhiPzZgVmzLwqvTM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e95f18a-e3b7-41e7-4a71-08dc4e9c78eb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 20:28:33.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5yE3g+jCt3QqimejQXs0+H6rLaU/DfjWZcvUoxax75MiTjjGwDNa6wZQ3/hXgagY3rEpWeF9Fi5nYTX9Z9C0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_18,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270144
X-Proofpoint-GUID: Gmppmu2YlRFPqfXVuM4ornTBsfg2ef_H
X-Proofpoint-ORIG-GUID: Gmppmu2YlRFPqfXVuM4ornTBsfg2ef_H

On Fri, Mar 22, 2024 at 12:11:44PM +0100, Roland Mainz wrote:
> Hi!
> 
> ----
> 
> After updating my Debian 11 and RHEL 9 installations with Linux kernel
> 6.6.20-rt25 I start getting the following error messages
> "svc_tcp_read_marker nfsd RPC fragment too large".
> Client side is Linux NFSv4.2 client (Debian&&RHEL, both default kernel
> and Linux 6.6.20-rt25)+ms-nfs41-client HEAD.
> 
> Is this a know issue, and is there a patch for it ?

The "fragment too large" message means the incoming RPC frame has
the high-order bit set in its TCP record marker. It could mean:

1. The client is trying to send an RPC message that is split over
   multiple RPC fragments. The Linux in-kernel RPC server does not
   support that.

2. The TCP byte stream has gotten out of sync with the RPC
   framing. That's a sign of a bug or misconfiguration somewhere,
   though not necessarily on the NFS server.

Wireshark can help you sort it out.

-- 
Chuck Lever

