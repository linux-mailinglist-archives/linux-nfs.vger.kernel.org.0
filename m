Return-Path: <linux-nfs+bounces-5038-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB2993B6EF
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 20:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83010B20C53
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FCC158A02;
	Wed, 24 Jul 2024 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HF73paTG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MsM7D2EY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22424D8B9
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721846524; cv=fail; b=HqWe7v2LRb4ubARwePaYC4ylAWhCFYqLjyexklcYacvvTQl8svtMVJxWJtqSINJgHzj6W05VT1V8UzHDoeIBGgf1U7ChG41FwtWGs6/NzZxtgxGpc4PGny6jLwe4jJnOvSEPepziHqZGXKDwsjd4A/oRk0uwh+MdLwD5l0nJ1E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721846524; c=relaxed/simple;
	bh=R5LhDjTWUlu7k2HJ4JEknsMDQNQmpIbUOji2I4lvPkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Edw/7yK0eH1Ym3/MXrLz0xW+sblJUOBlv/yYO2mjIfDC6c26+ihbJrrbTl1ai+w8gr0DbtAPLlEFNgoMVSxiRQI06HgZQtbydh5XR3dhX9ZHbzz6TRj8HvLmhsO1nQTkaj4NktotwquVjb7E2ycWQAvS5oOg13KYAAYwsdSzYv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HF73paTG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MsM7D2EY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFXrcd016724;
	Wed, 24 Jul 2024 18:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=2AXiw3o4TZTf9EZ
	oyF4ujTMhNdPJrSYlG9X90pexdoE=; b=HF73paTGrkUxvFo2Mk3H1zhhfFLqnfU
	Q9LZNuHUR0GXAek4p9C9BuYViJLgtUuE2DOAI2OVpex1PRD+yBx9cFKWltmuAqIq
	SgBL4SZz9zslIMh3UCmkQ59cNx6Fx8oxUTdxoqrIjuIqmGLLldq4G/cJ8oFMrmcr
	j9ZvJRmMNQ5gPSjQ6Lk9D0STAPwulteScerFh0PWu56ylkesT05baymqO3v8ezKP
	qaa8UIDoNQuj8EQwU8pWxPTONNQ5rc4Y7f/Q03D652+bUUkYYTKNzDPsi/m2jNSx
	0Tbl3i8e1PAYSdmvs5430fv7b/z/PZ/3YfKwQsr1XBk9bFlo+7IhSkA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgcrhrah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 18:41:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46OIERXq010996;
	Wed, 24 Jul 2024 18:41:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29t1qbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 18:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T901JwMkDiO+uZTo3Y2Qgfi8ZBqTY4Ba0jwB7M8Iyux7vJyMRBPxaj2kpCXjB+E4CfAKiZmqXtRYLUexVnY1YBm1OrriVVWQvkL9eUnm3mjHX1DFBDMCRSUScGe1IhDThQwcRKLlsOxbZXw8QKfwgdfKnvl8wjC6Lq5U4N2wSz9B+DSSeUXiu435ZU867VE8FGryPrs0je3NDPQNkcI+fj4qbEicVCm0muvWVzJsTjHmypJ/lVOYAGMV3X0+9bk7mWVBf3nWZYO1HmnvsuOymu4xUCD3KuL8O5/ofOab/Q29s050FRkkVS3T6eAeNE/ZxwJALFX5hqn45QKN8JCWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AXiw3o4TZTf9EZoyF4ujTMhNdPJrSYlG9X90pexdoE=;
 b=CPqcAWIzr0lr0kq2eaggK/QBOjNwLOqN62GT1vkpA+1ulogkAG9OOr5tATcQ6PVf9Pv7r4uEg+L+liFeIbhlsnqKr74yYBwfXKYrRJHSGQ3r9Of5IArXyWY4UUfrVwReCeLXCdfRFE/BI9fgrb+mHzYj4G/1G5+Coim++vGhYtn4x8N197WoDy0RKMKDznHTut3G1mhtdt7d+h692L1yDSzedx769EdsICpzpFcBoW0Iu8Z6eaDQW32cXaVij8RDj8MGaJr2a1BuRYLI8j2Mpm7y50jlfPnvEiMy4Wdb/vTvNawdXIaaZepkEafPz9zbwGSdFsElHYQcZ2t34LpSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AXiw3o4TZTf9EZoyF4ujTMhNdPJrSYlG9X90pexdoE=;
 b=MsM7D2EYmOyJIq5z6Z5PRAY219X7IhiTkDuqe9a0j0YtuJyYl0yJ9YKhYWVJW6QDOjPUY/IK3J8ncmgZpN1KNHhZPcy7uIIHEYGwXpDR2uHz+wFhKsMcAss5MJP3rFoKNYUKxVW1e7OZF4z3okhQwn/UDp3+R9ojcsZMnnsH0aE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7534.namprd10.prod.outlook.com (2603:10b6:610:190::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 24 Jul
 2024 18:41:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 18:41:47 +0000
Date: Wed, 24 Jul 2024 14:41:43 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: don't EXPORT_SYMBOL nfsd4_ssc_init_umount_work()
Message-ID: <ZqFK56NbnBzpbRVY@tissot.1015granger.net>
References: <172178974983.18529.7196430427173527960@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172178974983.18529.7196430427173527960@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR19CA0005.namprd19.prod.outlook.com
 (2603:10b6:610:4d::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: a339f33d-7f5b-4c9c-43e1-08dcac1045dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QC9v+4X7xWOZDtkVErkXcNG5ktfKN+T1c4A1/Ug9ubuPdDqW3zFdUQXoJ0oi?=
 =?us-ascii?Q?BrKYleY4lJIYwTAb2Ke0RaPeXCLS4p5msVjR2mUhWoETwmCe+CDF3WsZjMKq?=
 =?us-ascii?Q?db5RWwdaVTPpenHceJqhWYwCuL6xMQDgTP2jqHIH3Y/EKCGIXWINHkw2UGaB?=
 =?us-ascii?Q?FLFVbNNl9LcgRYUo/C+fVfRMdwiIHQ+hZTArDYh/zhH9hLXLEjC/qUYKx34x?=
 =?us-ascii?Q?tAv2MJb4xYLnaOUO3O3ZQ8bFnR0gmNwcVK6cRPcgKk84rh+MsRcOj0lbxqIp?=
 =?us-ascii?Q?Qhq9NbN89zQrMXBHXjWxVZMxyKgy0voji8/XJ8Uf/x5EIYbMI28K4BHz3WxS?=
 =?us-ascii?Q?z0YJ1ht8er4zj8aJKLdEUsQnh/+m1sU3tTnBLTWxkjpLen3xQbWa8wmPWkXS?=
 =?us-ascii?Q?Dkh/T9+PzyTn+EhYfAr3pilGH3mEjtzdQxVx0yeRE7w+w4sLbC1EoL+d0lTQ?=
 =?us-ascii?Q?vxoXzdq5wOkro+YHQ3IR+1LkpMcCscfdz8C6eaahfvZYxyDXtZGfF5aM6tdE?=
 =?us-ascii?Q?qe0rvvEkwsi80NWVjIBZY+ezqQmVtMpYn4+Df2er/80m0sphfOzrhsoroPHG?=
 =?us-ascii?Q?611ahAr9MX00VKmRrb+j8wNPuP96H/kgBCKkN6CiVjxXX8lyBSLBBMMShug2?=
 =?us-ascii?Q?nxiqDerI1pKextmInA9agZfd3ydvyRwOSVYBXEaM/Nw2VN6gzJVihiUbmB9p?=
 =?us-ascii?Q?HT1N0M8QSa4dwWhFT7cHaNh6IKyH3g87VbVznbsB5EErksA7DwRULjYjpuJx?=
 =?us-ascii?Q?pc7E31e4YdM86AsPVaF2dJW6KcCFtoySgToBPFkVNOAFPekUE/Tpn5YTTLE0?=
 =?us-ascii?Q?jMQsc/SIHW+Uzp0662jJCqhK6YZa2FPmRw8V85gNqzm7z2/i3bl//2VAT3dA?=
 =?us-ascii?Q?yCC4o0/tZdePX6+sEbfXGZDUQjeUekMyc4RiPdSXM1QAuT39mOstdegdMcw9?=
 =?us-ascii?Q?SXHYXiWmgQ8CRVbjRCpocnSq2FU4qOgWhGH0m9stD3M8KT2bICs9tj0ENXNL?=
 =?us-ascii?Q?ML1H0iLnkiT4ksCh8uBhQFFh1O6FFIGIQq7XrLfDrOvlQoMwGMFw2ohDMzS8?=
 =?us-ascii?Q?rwq4yfU4U9Yv+GEpBi4Rst3IbXCs/CzhX7lpTk79Qh989Fy0xbJW03PAWZYH?=
 =?us-ascii?Q?9OMsAhhPF2l/iaB5TH/gYU5la1FBaoyTIp8PovryGqVXesN/cRHBi7Ri+avA?=
 =?us-ascii?Q?7V6upxjFaoffSublfUlLp7PIpBg1agiuOlGbznhRwYZx4Ocb4cJkjnPQX7/3?=
 =?us-ascii?Q?HthU5O/5e/LmymH7Pq44Wwo9+hjU/3vIrU80NYzEP8BSFDdxsDRcCdU4QvuT?=
 =?us-ascii?Q?W/Wok1IZTBD96SGac2Yxo8Xo4VeKmq7FSbpCLyj0aN8zng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pbPG4JZwh8MgDXcCNsOBatCc1Ojp04TyjWiIL5JS8WdQq0XXwB3O5IZVlRhj?=
 =?us-ascii?Q?QD+gkdYiJwfu9OUPsPb4d2ZPYo/gKEQlZffwedmEFnnJCk9r6er+ncxEOZU+?=
 =?us-ascii?Q?LGgHEmuAxWGyM1WZoTGksNKokgxSUTtYakRb37igAQdm9i130bI35amb5/f+?=
 =?us-ascii?Q?jQ2N8fKzRYWttD4MtY+xhd9U9ZKlSnei/cHjdqv20V55jg1upWt85d8GUmBf?=
 =?us-ascii?Q?AxWIHmVkLskAinGQBPDO/mm8luw2MIaZf51BMPsMYDR3OET8352ilHFWziu6?=
 =?us-ascii?Q?ojw2VsSQ6Dm5WI/+yVQoWatM/BO/poMoY8bCSYG2IQl54aWtEusHUW+THN5o?=
 =?us-ascii?Q?0FaGJ6wFVOgyJnD6HXd1EfEBlk2lkpHaIcmJ/jmTvTnfuLtEW4BxYaqks8yO?=
 =?us-ascii?Q?h0s7UEhZbfxz6tFQT+BOGTrq9UaIG/I37nHr2F2HcI3ZB8J4lWLZEHTXAn3G?=
 =?us-ascii?Q?ydbFWWb2PsXIPs8Iv/jePJmGp86vBbey3tYy6cC1WfxVnpMqvTZZq/a0WJ01?=
 =?us-ascii?Q?VkRVV8TAo/11BjpqTWTJ+L839qxM4/1GZf/SFKUYsw7q/TYl1+E6KXj4HDDR?=
 =?us-ascii?Q?fVMD9XlkK1r2sVzmT5lH4MSQlpWVqk3vwsVloWnLLlElkELdz/gdRgNLuF+I?=
 =?us-ascii?Q?91rwrerAN0oarDIzVPT6xwLPN8yLO9RCHTShT6BQZVvt5IVKzRW0ZbcUq0ng?=
 =?us-ascii?Q?suGkVfjUbDK4TaAsqnIMRw3FX3YBeGvwghjtXeFueTAwb+ao84jC4lSNRson?=
 =?us-ascii?Q?a8C2z8p618C/rvafAtfQ1omdjjvSpN2FEPx8SiuSxS6bUxwhQY/DQQbWxUUq?=
 =?us-ascii?Q?OGw6FxuPrbCAsYrJbHEv67Cgp6KAW5zxHjZKnwstGLHVF5ZDc4zyaXmtSGHh?=
 =?us-ascii?Q?tny1GTpsUNuHSAcTj5ZK4x2/5Caewb2FWINZd5BeLkZ9xlIf/iwPn1Gmb1rI?=
 =?us-ascii?Q?TAgSM/WLLd1BxAxqQmZgqyMj49TVQnVHa26U0ifsNihtbYnpiZqb3oAA/719?=
 =?us-ascii?Q?UGL/lSrKZyVd/V7mu+vDdVMMsb8Ze+51ZFrwG8rUcqjP8hLalFWi2+wHOpjU?=
 =?us-ascii?Q?+935WjJ78qJ56VgfCRjOLFYTcwsgOwacQYsrtycgtTBnFsCvNGNOCUxglW+4?=
 =?us-ascii?Q?mGe9i7VQ17YzMYJnXlLrkAB/bv9/Q4XSyPuY85C0PG5QynLshu1ej93G3Ayx?=
 =?us-ascii?Q?iqaBIqMcP5QJrO7Ca3e0ulQxSnElVE7hBfSh9b+3SEqmVimReATI0gdNd/DQ?=
 =?us-ascii?Q?BUiPk0RiehFHVy1LnI1EpdcSsibatje5B9zA75EpbXQvED6WaMvDzLcZyf7o?=
 =?us-ascii?Q?b2S/bYLnt9NaiUjP7wzoMOXki5oq0exLP86mEHCltcFXYwGK/XhYgrv7pdbq?=
 =?us-ascii?Q?ACa7TPpFlgMVrFY6usXM3WvEh35DFYufv1WJvoOFw2Kh7+u/mbUb69bQL1xW?=
 =?us-ascii?Q?w9IETvvjdgh7dA1X7VRRfskHd70q4GnjKkjn/OSDSbbnt4mlTtDicnJW84J5?=
 =?us-ascii?Q?rDTVB8/7loUV9RzC1fD4ZxL5PryGOf6r98jrgkyTPF63UHR4aWcLCqgAtFXl?=
 =?us-ascii?Q?AngR3WjsmDuMy8XEP6dlIXEFWO4fh1luo745Z1XqgxmjFGxvuwDV9UqflLSV?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bbi6+3LYswmhQOjwftclAwiL3A36GpjwBjh7FaEQiyM3z1gfWW8SUplOt0V6WUAcwaLyyWWAGG889QhG1dCCU+JHRd6nfwfhD1O5IW6UI4eBZYJtS3oH7YnOtJTGL3qqy7usvsdvEkklmR10l0oK1nUxK6YVMdfNK7N29z6fMy2yu33zGa/frk3YZG+Iqx11mXWNxI89WUnSSkuiaRGIxHc1FsiIQSXnKziOzHEqfVOaAqtKdJu2gJtudp5JcsnH3+wJ+Mvu+l7afv4ViIbPsqPAUg+KWy6RYg5XRtUVa2G7U9WoIDIk+S1+Zk3Sha3I8R/aHcqN8L2aC+lf+8A3bB3n5LNVor8kLy2QHcx6bsPWTFmqlEIxsAPqTsNjmgzVDTUK/LpA9izHq2y785U7NcDv2t+Aiho+kLI1q+1tvVhKqjyZFTgWV9vc7N+2w/fHMp9a/nB/L280uxXlnfuV4+aAOlx9YpUe8N5w8mo9iZlt1beD9YWinuBgBGNuvfYLT3o+e83DKfi/6EtZogGS8wlnemuVzdBP3GDu7mHSPoEy1LI3n5W9O3Dh0kvtNGKUkCywbPEt6i0X6/LDzW8N4+c2LqvgFPpD6KINDGv3TDI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a339f33d-7f5b-4c9c-43e1-08dcac1045dc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 18:41:47.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3nPUFEUS1eoXgW875uENbcQQNDAaH/DNbPI8oktKtVPX2uhLzPuwrsui8V3POY5OYcDLzXM3hjAvsLRerzCiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7534
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_19,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240134
X-Proofpoint-GUID: W0cUZaUDqAYnlSsAptePdVWxkgrfK4hw
X-Proofpoint-ORIG-GUID: W0cUZaUDqAYnlSsAptePdVWxkgrfK4hw

On Wed, Jul 24, 2024 at 12:55:49PM +1000, NeilBrown wrote:
> 
> nfsd4_ssc_init_umount_work() is only used in the nfsd module, so there
> is no neex to EXPORT it.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a20c2c9d7d45..1795bd8e7ae9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6268,7 +6268,6 @@ void nfsd4_ssc_init_umount_work(struct nfsd_net *nn)
>  	INIT_LIST_HEAD(&nn->nfsd_ssc_mount_list);
>  	init_waitqueue_head(&nn->nfsd_ssc_waitq);
>  }
> -EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
>  
>  /*
>   * This is called when nfsd is being shutdown, after all inter_ssc
> -- 
> 2.44.0
> 

Applied to nfsd-next (for v6.12). Thanks!

-- 
Chuck Lever

