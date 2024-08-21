Return-Path: <linux-nfs+bounces-5558-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F8295A65A
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 23:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5828A1C2272B
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 21:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12613A3E8;
	Wed, 21 Aug 2024 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R4acE9kH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rnKxP6+h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA71741C6
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724274862; cv=fail; b=eQL3NfSA4sW4hhGHgkceeC6hhVQ7q//g/COdOzt2jycTVLCd3UpAIx9MOiWqvmz27gkCdVYX3bm+f0B6D85DIfgupEOcQkB7cKTHG797jsFREt9SO2Ej5QnoRHe45CJl7rLjWdvYJQwxopsMIyEDzDiKhAH1Ob6zRpov9IjYaKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724274862; c=relaxed/simple;
	bh=vZnZFt6R2NU7qC7LZQT1G+CgTqoBUKl7Z/m/95mG4i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uSCGbDe3Ty3uypS23godpn8TsULt5tLmOtzQW41pmwRrAmADf4iCsiLIsvr1cVWv9hyyPfqCrlYZmRibmDocixdPxlzDxRXGPTT/qps/oKfNlhkFZS9y0ZmG4GtTGvLFy4gNZk6fUCkrpmIj+ZXMJREIYSVi0K0ry9trjFGnVys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R4acE9kH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rnKxP6+h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LKtXke020180;
	Wed, 21 Aug 2024 21:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=bRKxA2kQKccqjBiNDzasQZN6UocTcLX3/+SBWnFIuXI=; b=
	R4acE9kH4kpy1pAtiShxtMY69QDNlZ3Kl4s9i61zulEyCY0OvarqPiUnarNMnc8B
	VDLXZtdK82Uf1Y39gOqtdwr3VAg9ibvUkFza0Z2jrhfBfAjAWjJlkSU8ZOqVVcBx
	3gYDz3TCMw2CfjTLFbsV0xNcprLUQsepSsTF8PUDKxIG3AFdmoIG0tcmV/S6wVzt
	0uydQ07qigj/vhp8T9Kyc9vE0QNdBJ26BQ+l6yJyLoWZkusc41ANqG7w3yicYewJ
	YPppa03elNdpbIIp2dLqlW15SVXC0X5zQKa9/9IGWWtFp+V/DGGd9bFM8J/MN+RY
	M1wMlpab5ZKu1anfn5Zoog==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 414yrj2waf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 21:14:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LKYbEY025067;
	Wed, 21 Aug 2024 21:14:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415qd19cux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 21:14:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzaXAuNdCS2IBN9ETvjYklMYuh3LfP37K0GWSxDOgXp77EOWRUPt5LUzmhpwEGvlvjJCvjm+oNVLVxZZxB232dQ7zrAznn2dtROGJT8Te4Raxbn913LW3/VexJb4Tw5ciMOPh1QmCmnvedVXkgmSrQaNid1h4QbM6OIq0c8mPQnMVhTFepUZwMuSX3GS6ngv9bVs1Tq6jofyNaCsXFxtRoCJBnPcmdEh0QZ6xQyUd97lDFX7S66w3PQZhf7ushsr5HjQP7FPsNym1gzr6mm61knU2KMzSsLrpK3KSW9phHyEGq1ENpFbzKeDlfBjINMBUgoZ5naB9HXx+UkvgvzfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRKxA2kQKccqjBiNDzasQZN6UocTcLX3/+SBWnFIuXI=;
 b=ubq5qKLPGc8KbJoPuUZQyevmv/nBAUyDvGKKMFnnhPf7lyckli+GF0o/azbEXx0u5vLSUqIhRuGDOOhcs9p7bvb92jdTlJBWWFylPjDFj2kcJMHBx1D9h3fW0TWoMDDFJCS+uYxvo7IM6mT3eY47ekFqHNXJzdrt3Da7WgybfYJpI1qhS11gI/qem31IRlfio738Z92GuGKhdBUx60IT48LPxxfwp1sp5YhAmcUb2Cp720Q3x3hD5yyAkjoojKP6PdXHrPla4/12tngFZqRq2il3S9U9cfqbrqgl/NBfAyn/XFTeSYPWHGxGqlnqmeTxlyXckAP3zW1tSm4RNHVpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRKxA2kQKccqjBiNDzasQZN6UocTcLX3/+SBWnFIuXI=;
 b=rnKxP6+hnl1YxGjMlQfWYNazXVGuEBvRymxAEJQXTwslhmj96Mv/8WjZU2RhTmLPb9wkupzuqT8ZgrgHgD/zJDO+D5ozJ3+hXCXSwUy+KaT2JtWBKQNMeREkLl+YSTV5NNtNMswRWY6PsN9KHfPlYJWyoTjd/VfO7Pm2xlvBdVY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Wed, 21 Aug
 2024 21:14:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 21:14:13 +0000
Date: Wed, 21 Aug 2024 17:14:10 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] NFSD: Create an initial nfs4_1.x file
Message-ID: <ZsZYou+8+8nXWqWc@tissot.1015granger.net>
References: <20240820144600.189744-1-cel@kernel.org>
 <20240820144600.189744-3-cel@kernel.org>
 <6a3d9288fdeb6409dca7c2ceedf249d3b40a7d97.camel@kernel.org>
 <ZsY6BeHYcJiFOrHc@tissot.1015granger.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsY6BeHYcJiFOrHc@tissot.1015granger.net>
X-ClientProxiedBy: CH2PR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:610:5b::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: 276b84d6-5afd-4f48-b55d-08dcc22634ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUVrWXdRRElrTmZxZG9ZTkJYM3JlNVZHZkZyak96RG5mUFlUUkhRbk53WVdW?=
 =?utf-8?B?S3NFWFpEM0hwQmZid0lvWFZUR0RjOXNCbXMzZDhqWE9KT3FGZkxkTC9Va3VB?=
 =?utf-8?B?enU1ZmkycEU2dVlrZmUwTk9IdzRVT1l2OUdoaGhhZ1JsblB2MjNjRFY5bGtL?=
 =?utf-8?B?aWJKR0szYkpRVUZweE13cUZ3ekhWL2lsODVIdDZQMS9lUHZ0TFh1YkhVOG9R?=
 =?utf-8?B?Y2NWYXdSa2pXdE85VDcyajBoS2VtUmRJWXlVZFVpa0VmaHZhWmhadHB4SGhw?=
 =?utf-8?B?M2RJTnFyMmNabXR0V005cm5HaytvaUNLUkJjUlUza0tFS2RMTVBjalRSM1Zh?=
 =?utf-8?B?dEtpUUQ3VHNWWGs0MDdWVGY1RGhwRkNUQlhQakdGY0g1L2pKaVNEWVR4TStJ?=
 =?utf-8?B?a0ZnamNpQldwT3Nkb1dyZkhNUTFsR1BjelFtSExpdmYyVjVaYm5DWEZRTFd0?=
 =?utf-8?B?MzhZQ1pGQW9sWi84RTVOcG04ZkR5YUM4OUhVR2xRaDI0YmVLaEp0WTk4ckJP?=
 =?utf-8?B?QTRvZm1tSTlUOHhCWk9mTzBCYnVNUXhLS0dNQyt6TzdEbkpBZEdBcVJ1MVdu?=
 =?utf-8?B?L0xySDk3Q05uUjM4WGF6aTM5UiswWXdubTRqN20yRmh1UGVxOXp2bzArQ2R1?=
 =?utf-8?B?U3BDQXU0UWxIcnYySEx3REZ2dnZxT1RJRlVyOUFhUG5ia0R0c1pMY0NnTHVL?=
 =?utf-8?B?cjNpOE5qUGFxdEN0OGZTKytZQTdRZkRJcVo4SFVlS1VtQTdhNzJnR3hlSkNk?=
 =?utf-8?B?U2xzWVFIekxUM29zZmQ5S2lrVXN4ZlFZY3VZcnNQcWpOSFFQejJEMzY5NFI3?=
 =?utf-8?B?ZzFyYisxSUx6Q1NBd2o2cm5ibjNQbEwzK0NvYVpHV2pYeWNmNnBNZ1hHdGl4?=
 =?utf-8?B?dWtuejhoTjg0TDdNNXErUEVQMzRlVXgxOXVFRUtHZzExZnNuSzIrWGRsQVFL?=
 =?utf-8?B?L1A2S0VRaVBzOEJIVVUrRXcvb2pjM212WWUySUhMSVd4VjhMdjQ2a2todUdI?=
 =?utf-8?B?MGcrdDd6TXNqN0cxK1dFRjlROE5IZkRZeHY4ZENqakZxOW92V3pRZlVXUjZI?=
 =?utf-8?B?eGJIdUNvajNjQ01vSVp1NkdPVmJtc0REdzJwNmNkY3VSZGE4dFRES1RSVlEr?=
 =?utf-8?B?cUIwRUFKUzU0ZVAvR0J5TFM3SXV3Tm9tU3JzS1NoQ3dOQm41cVQyMlRETDBK?=
 =?utf-8?B?SXhZYlB5RkpMYTZoT25SK0tCTDI5RldlbmN3UDUwSXVYaGcrMVdkSEJYc3h1?=
 =?utf-8?B?dmZWZTFUTmJ6SEhmSDRIdHM3YWVIYzhQdHUwK1M5QmpwVThUTlp2UkRvbUNr?=
 =?utf-8?B?Z2hQSEdBeTlNM1ptc2prUGxsNThZOXdqK1dqWnhiUjhRNjhGYmZML3VxVlNy?=
 =?utf-8?B?a1RlUDNucnQvZ2g3cExjVDhtUThuT3RWbnlKbTZSU3Nua1NzaEZ5VW1rQmtz?=
 =?utf-8?B?RUVFMDdVeXcvTzVwN2ZGd09FNm9CTkExaXoxRlRRTVRXcnpMRDM0bmRQVXgx?=
 =?utf-8?B?bHlQaW9udHNCNDN2bkZhVnBCbzR2YXdjbDdRMzRXcnAwaS9XbWttbTJOakFG?=
 =?utf-8?B?M1hGODNEbW9tY3ByS2lxVVliczBMcndBQmU3ZFNEZlJoOVJhbVFGNHRoTkNw?=
 =?utf-8?B?MXRqSU9kNms4cy9nUzBmNnl6Zk9qMkFKZTFVWllFZXR3UUtxeWZFcCtnN09N?=
 =?utf-8?B?c3NpeTBIMVc2b2FPMnVwTlFwalJJNmxJL2kxYThQbXVpMnNJWjRDaTFZK3pj?=
 =?utf-8?B?dEhZeGdWWTBCQjlMenU3R0pKblViYXhEZm1aVUQ5ZlhwOUdXMTllWCtpa2RN?=
 =?utf-8?B?MlpVY2JQTzUwUWhxdEp2dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnZRVU91REZpbyt5b0g0aXhSRXE0WHo0NTBvbEpmcTJucDgwVFpxZ0YvZzFP?=
 =?utf-8?B?MEZzSyt5bElBYUc0cm5Dci9TSGd4bzZBRENqOGJVWG8vTHpKRkwrNVh6N2ts?=
 =?utf-8?B?WEJEcDJSWnZpdnRvYk8vMDRybVVCUHpDMGdpcXNKNkE2TGgxeFZYcmk1ZlRP?=
 =?utf-8?B?VkZrbW5qZEZQZE1ONlZqUTA5NmRJSXo0RHhUblZHdlFNRWxzTmZ1SXU2YWto?=
 =?utf-8?B?ZERzRUdXbjVGT3pMQ0pnaWZSSVI1R01LczZEcUovd0RNUll2VEh2K0NRYWNK?=
 =?utf-8?B?QVY2YW5ZZFEwS1Y4czJhcis3eGt1bG04SFFpQ3VSQk1qakdobTdlZExYSnJ5?=
 =?utf-8?B?VUxmaW8yZnp2aitVYWg2SURtM1Zoc3JVdnErUnc3VVpDNC9pbU9WSFYwVlVQ?=
 =?utf-8?B?bVdLMjRUOTU0SFRDK3FPclhMWEdyWlFBZzRrUGdXSUxEZU9Bc3htNnZCS1RB?=
 =?utf-8?B?aHAzaHI0T052UHozcktocXgvcEpYYmNlOGErRUEvWmxheE5tRjQ4TXp4aUEw?=
 =?utf-8?B?Y1NhOVVJcFFHM1haV3J4YWo5RnRSZHJmb2QxNlo3cmZESHpzckJEdEVjQXBV?=
 =?utf-8?B?K21EeEErZ3pDbDJjTVdmaklMVC8wNnFkanlwL3c2d0hCb3JLZ3BaUVJSUWJa?=
 =?utf-8?B?TE00M0dVQk5HSTM3eEtzUFlwSUU2VGl1LzY2TnZMODg3QVYrU3hZZERTbVZz?=
 =?utf-8?B?WFdYbXZGYm5LaFFpOTU2V2MyR01DOUJoTE8zWmdNRkJFVmNQdzdoVFhzdGpE?=
 =?utf-8?B?MlRyQzd4REhXc29UcFJUK2tCSzBDRG1YaFd1a3RQRE1zbVVYR3dvck0xU0Vw?=
 =?utf-8?B?aFFOR0pMQ0dsR21EUG5EN0RyNndqU2hpVDFmNzIrWkFxa2drbHIvODlsQWpG?=
 =?utf-8?B?S1Z3Q0lWMkdVZUFjTmp6RmdqemdReW1wVThUdk0yUERMcWg4MFFRMGNVK1ZW?=
 =?utf-8?B?VWIxZWdPeE5mclo2YnRvbjdkcnRMQWxWWDVybVZHaHJ6RWlyZkI3VWVGeXJl?=
 =?utf-8?B?MnJnVFZMSlVLVWFVUVVSa3ZyOThPYkYxbFJGd3Yxb1c0RGdPRFY1bkcvNEM3?=
 =?utf-8?B?RmZKdGVRdWFkU0N1REVCNGdCUlZEZ21HNzczcDZ3bStpMFYvWXZsd2FiMkF0?=
 =?utf-8?B?RlFxc0RQVjVqVVgxQzBnMW1RRzFacVJPTlcvK1UrMkp1R0JQTzIvMkJJZ1Rn?=
 =?utf-8?B?amFrekRqNzBoa24xcnRZNmNBWFVvSWsyRUYxM0dETlhSN09RQlYvL1oyeGd2?=
 =?utf-8?B?UGVXcU05Y3VCV2lncHk3dFpaTFdXdndCRlpDaEtKUVRNRmxuejAvcTNVM0Rq?=
 =?utf-8?B?blQzZHRGZmFZVWtFTVlsWkVUN0ZrdGlzTDZLcSt2eUd6cmlHbjltdFd4T01i?=
 =?utf-8?B?Nk4xcmdkVFp4UU9qdzQwKytBM1M3bURmRk5jVzRhKzJMUnJ5OUhqQnlNaVJz?=
 =?utf-8?B?Y2ZVbzc3cFhQUmR0MTVjeXBWTVpZUzNUdGFoTTBldFJzTWMrVG5HTnpVQzhI?=
 =?utf-8?B?OXRtME9VWGRZMnRiRHR5K1hpdUlobDdldmhnbWxHR3A0N1dUVjFMOUpLbjI2?=
 =?utf-8?B?VE5haGxpL2dKTGRFMWk2UTBGOTZUMThqN3R5QjRxcS9Kd2lvOTFqRTd3a09Q?=
 =?utf-8?B?T3FvTWxYSEV6UmJienRZOGVSNlNjbEgrdjQvWXVEVVN2RkVPRE1hdGJYSGFy?=
 =?utf-8?B?ZS96aERYMm96cG9EWXN0bXVIR29wWW1tbHI5SlRwVVU2enVUSHB4MkZsSHhw?=
 =?utf-8?B?dHQvc1VoSFA0L1MrWTJIREIxWGRza1UyandpbkFOeWw0dVZJdmpremN4UzRI?=
 =?utf-8?B?bk84eXg4Y21vNi9aWFhxU1dVQ3F2TnNweWxUUm5OMFdyUVpLTWVJd3ErWXdo?=
 =?utf-8?B?RmdGcGxYZi9MYm5reTJvZ1hDWktzb3pIMCt3a3ZoVzZpUHV3RkhkdGh4UklX?=
 =?utf-8?B?ZVM2cCtUbEYvaDhoUzNZNjkyN3Y1Wmt6OFJEaUVMZFJ2RHNJcnplNmpES1Q1?=
 =?utf-8?B?QU5EZlhMb0VIUjVUQ09zdmpVa1o2eWRodEJEaFBKRHNtQjV5R1J4NE8zcnFP?=
 =?utf-8?B?M09nYjFuZ1Z5WGJsbTJHa3JUUmZvNFhTd1ByNGZkaEVZQVlEemN1d2l6cWN5?=
 =?utf-8?B?Yzg0QmozWVVtLzZzcVdoNDQ3NVZqTkFBbDRuMWdOVkRYWDBCMlRMdkFUcmlK?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0w7XH0O9HC2I/YUcfUUfleZs6OGDznDc8mMnD+qrvAsTiEVFUIkPDicmY9fHqL4mdjXfweyhDwZVOeOJ4H44M72O8g35BFktDZGXuVPL2AwmVx4rJPYerE0hnVDGG1rHPhysb2VuN0QtYhR8AsE0DK7YODtZfW2YlIZUFEXo8AG7pr0AxL3Lxx2YMr5pO+fTZXBhsUjpWuyaiunyFvwwd2ptUvXJFJDICnkNJGF2D7u7g+qsJ+bOwREzZbi16wiRTBbKpJgtj+tLq42l9ZrhFzded1KFv59xjuK7xJPe4fJ0VhWXVIr0fOS1IchZ87wEjFfyclGlMqClIqDQPACyS8SIN8Fk23mzi/iXMB/Olk++urP2pQWYEFcQvKA92lIVo9hAaThcE/IZc3zJwujYWRwrYeq6gxMKYHdeuK+gC6zdHMwTcLDFEY3P0lruUVYEJZtQw7ca1zEY8OYSkBMrZBwx6Tb6rEBSPjFKtxNd2cSWUafXCUe+vKGQFCUkGkFmB5eh7zAefgp+LGbCYF1O1PKo++1UO6dQ2d2oCltJBM2kiLgXUXD02coQZSw5a8mtiPcgP73zKlhaeD4orxSJWXoJEFkVh5RmBn4yAwCAEwE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276b84d6-5afd-4f48-b55d-08dcc22634ed
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 21:14:13.4273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWhMsXc6CHS+Jv4u7IatEDIpy5iVSAky6Oij7LauAytVmrbNb3u2vadBrHpTqsHwMJuBZDTN76YeR6antMpJGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_15,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=605 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408210156
X-Proofpoint-ORIG-GUID: g1yPd_uj5YXrp2tYjx-T-L9dOrUlsKY6
X-Proofpoint-GUID: g1yPd_uj5YXrp2tYjx-T-L9dOrUlsKY6

On Wed, Aug 21, 2024 at 03:03:33PM -0400, Chuck Lever wrote:
> On Wed, Aug 21, 2024 at 10:22:15AM -0400, Jeff Layton wrote:
> > Also, as a side note:
> > 
> > fs/nfsd/nfs4xdr.c: In function ‘nfsd4_encode_fattr4_open_arguments’:
> > fs/nfsd/nfs4xdr.c:3446:55: error: incompatible type for argument 2 of ‘xdrgen_encode_fattr4_open_arguments’
> >  3446 |         if (!xdrgen_encode_fattr4_open_arguments(xdr, &nfsd_open_arguments))
> > 
> > 
> > OPEN_ARGUMENTS4 is a large structure with 5 different bitmaps in it. We
> > probably don't want to pass that by value. When the tool is dealing
> > with a struct, we should have it generate functions that take a pointer
> > instead (IMO).
> 
> Meh. xdrgen already generates pass-by-reference encoders for
> structs. The problem is actually this bit of nfs4_1.x:
> 
>    typedef open_arguments4 fattr4_open_arguments;
> 
> which generates:
> 
> bool
> xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const fattr4_open_arguments value)
> {
>         return xdrgen_encode_open_arguments4(xdr, &value);
> };
> 
> So, it's a bug in the way that xdrgen handles /typedefs/ of structs,
> not in the way that it handles the structs themselves.

I've addressed this in the lkxdrgen branch on kernel.org. I'm sure
there are still bugs ;-)


-- 
Chuck Lever

