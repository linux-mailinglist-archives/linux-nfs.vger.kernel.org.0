Return-Path: <linux-nfs+bounces-17257-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6B6CD6E8E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 19:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC90030039DB
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 18:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5724F326D4A;
	Mon, 22 Dec 2025 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VA0l8Jw5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JjLcYfD3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB832572D
	for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766429923; cv=fail; b=Ynv4GyjRoELZ/wgHARwpsXl1izsCHbIdqAT0bt81W+2bgxqyI+ZmxRDp9wZ6VqM/Px0MU7f6u+4ip0Q5iix1RDHEJRZy+XlFyEVvDXG+HF6FchisTulanMC5lxHwySAHhh2fKqbs7wDZNceo5WH4ts6rBCzk7FZClM6i0n2egmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766429923; c=relaxed/simple;
	bh=yhkM6zVa9Ig+gr3s05HV6FWJ7SOUvrXwUJq4WIj5EQk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PFfNIHuBTaeadtxC/eLbStHEMKOQZGr7McTLOHigu3oYatWs4oZODlBezYeBu0frlSu3l0d/WO7yqj7bbibCIxg0C45EdjslOs6/OZ7RA3e4eTefCMqQicF6pbcU74/4d4kMlXBWXMxJud6aAyZYZXAloOwV3hKM6HLdrxkiohY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VA0l8Jw5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JjLcYfD3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMHLOp42698047;
	Mon, 22 Dec 2025 18:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3sDugSgWwNWKZgVUOJAI4SnSIjNAbcGpRaq81hNVHyA=; b=
	VA0l8Jw5YR14hh50JfR0b+tFvYFXUR1Ig063odXcqEq1w0L/QMNjgZXxDErd6zID
	IAfVHOtVncWmq0KQYFT1quzQWPjVdgWhpVyJXdLNhJ5tU/GIBnCk4dLjMQVbwX20
	H4I3GLQI23vboBcW4tA8unuYZvvMEJmsgkPeLYniRGV15hqNF+l1XXNYEDyYSgQm
	3PU/nYLFfNl4QgU0wSmFA7G/6Z4z1/6SmM4cU2BqsWEtegkgnSuKzP4LEFXtqm20
	XDkazj57AxJHuIDKnwvAJjUXrNcuVJuEFScfIrfYUkv/85Kn6PTS8nbtTickry60
	zMhcZUu2UHj8oLPFBRNVIQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b7aaj053e-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 18:58:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMHMqZw001872;
	Mon, 22 Dec 2025 18:56:02 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j87muq1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 18:56:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeXGw66z+qQl1t3XZh+FrkGVx+rMde0Ifo6xU3NnXjqRnEvsNI3Dnee14caJIMM8z+qDzviTMjFs93xooqacP3mqsxVRynUIsAblkqe1mWm/W1ozGiKpMxMmD/BaghRbBT4UTIps5O/b5fM9wCsFfLUYedMogLgGIvwT/jBlaSQWmYDO5mWlSNJTx0Z0iqmVrUSuJ7wgWo6OM6mh6Cbw74hT8BEDhqJCIqa6eqQKJigxV/CSmgPjaHLtcwT50zCEQ8oLPfnS7jSWx3HfN07J9Vx/jjFW2K7tLqPwHWl8Dhi5W+MGC2XVGWy9M4aG6sgMP4q7qEVq1Fkah6vCh+XFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sDugSgWwNWKZgVUOJAI4SnSIjNAbcGpRaq81hNVHyA=;
 b=BjODHdZ7mFkTTxGBc9xNDPdekw5zLYtQamnu+7lHmyfW4bDUyXet3u5zor5oGpJrDwe8RwNyFFSvSpBA4hAPXiZ+ubDDuO+we7l6g0IeeU8+C356xX62FozKt4RO7KHcsXzhwBb6mqPs1hWhtN/rjLlJF7pVnks8d9dqrpMF2jOe3ZCoTYzCXkPl0etOXxwT/YSzl0FAXiOd1k8491Sjk6OoC6C9c50pRoXVG4fZjXIHs33vFpNoYK89znkINYP6yC5XyCRZkOiPTjrIu8M1h7JlnprSsVN4THZW6uBG5AFRjshYTsbCXR/PAS+Fdfboyxih+o6q05PhipokEnYjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sDugSgWwNWKZgVUOJAI4SnSIjNAbcGpRaq81hNVHyA=;
 b=JjLcYfD3SW+ApBqbH/eEhg/RLbelpzuRBG3eOkOrPr6mXpppdNWHR+mCfkUrWNMgW4xWfWQq9O9564Ewew9+ER/dwCkVVYsNTTPZ5hfivqPE7uZtRdW9eVCB48rdE5PjY3mBJbR4RzRCA3fWoomFocE7WcUjMa38KFH+GHZlnBc=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CH0PR10MB5033.namprd10.prod.outlook.com (2603:10b6:610:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 18:55:59 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 18:55:59 +0000
Message-ID: <4ef8fa3c-93a7-44f1-9a5d-615169057205@oracle.com>
Date: Mon, 22 Dec 2025 10:55:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] NFSD: Track SCSI Persistent Registration Fencing
 per Client with xarray
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
References: <20251222021002.165582-1-dai.ngo@oracle.com>
 <7c18c1b0c89860a17e4b1bb7eddb7d2e489cf6f1.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <7c18c1b0c89860a17e4b1bb7eddb7d2e489cf6f1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::18) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CH0PR10MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d4fbfb-48eb-48a3-5cf7-08de418bbeb4
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dUJUUkdnL1o1YzJnbzBUaVpZZWNVWXpvLzdSc0JqSlRDWFVmaFk1dzFLdXJF?=
 =?utf-8?B?b2hMRFhjL2ViMURUeUJBNHVub1BNSkpVRmVDRVNOQVR5ejRFb2h5V3c5bkpH?=
 =?utf-8?B?eWlQUW1wYlM1OHM2Mk8vbHpyUWlONGV6aVM3TTBlTDRySzUycVFPQUo4ZTBr?=
 =?utf-8?B?Zy9uakJUdDg1UzA4aTBDR0hRc1pUT1VZY0tKMCt4OFB1Z241b3V1WlhzOUpV?=
 =?utf-8?B?TjdOYlJJdjhHYzh5U0tTbEMwYVJSaFhaZDFVbmVSaklQSElIMDIwNWFBZndV?=
 =?utf-8?B?Tyt4NnNiZUVoNExsQ0RsaHZnc3ZFaTZQRlZZdkk3dGpZenJ1WlVXU3B3Z1FP?=
 =?utf-8?B?eXRlZldXUXdtTHJMNGtZVnE3Vm9ZSmtpK1VLMEltRXg2eUxydko0cjE1M3Nt?=
 =?utf-8?B?NytYUGFmZ0VadUZrSVJXa0taREFoaXMxV0RNSklQTzJqc3ExR1lORkZCcEpN?=
 =?utf-8?B?UjZRbDM5bTVqY3loczZmc3k5VVFSZGgyU3U0UWpGSVFGYjZxeGhaUWw1aWdz?=
 =?utf-8?B?SnFXdzJWMVJjNFJmVXFVeUUvUnlycHJTemVQUFBnWFJmVXJrb0RYTTc1NzVD?=
 =?utf-8?B?eDFTNStMVytOVWhTTE9pMWtTS0FEOHFOYkcxc2tjQnpyRFNuakpndUtMcGk4?=
 =?utf-8?B?ZWNmbDgxSFVJd0JoWjJCbXpRaFpzWUVPRFFzamc1SCtnbjdvVmtvQ0JodWMz?=
 =?utf-8?B?NEtic2dVYTlkd2xIS2FBOXR2dmRRdk5uMzZkemc1K1E5K3lJQ2l0WkZTN09R?=
 =?utf-8?B?SS9UWjNDa211ang1aEFSMkVmQkcvMzgrQ1YyNnI5Yko5bzJERmJwdjlMVTFG?=
 =?utf-8?B?dkJTOTlmSzdobkhIZzd2QlpJR0ZNN1RMNjlhbXMvUFFvQmx4MUNoV3g0VlRR?=
 =?utf-8?B?MU1FV2o0eW5tZ3N1Y2h0OFNmMGQyYnN0WjRBU01hQnZlTW4zcEE3bVFXWjh5?=
 =?utf-8?B?U0pvWFBJV2J4WU43SjRHcmhVdG8wc05OdVBuMGtRQzFuRWhaU3RocGRoY2Vk?=
 =?utf-8?B?WWZuMmgzbE12WkZMTjFrVHY4YkhjakZBL0JQdHRkV0hJaVpFaDZQREJNTWRw?=
 =?utf-8?B?elBiL2ZkdEpaSGxmSGhXRHhhK3ZVK01ubHc1ZzNiT1JVYjBPTVRLaUlsU2d6?=
 =?utf-8?B?aXdOSTdIbFg1a0xsVm1oejFZN3R6NnhtS3ViZTZETkxReWh6M0FJaW8rOXIz?=
 =?utf-8?B?emphZVcyUWZJS093czZlalNvakVEN2lkMHNoSy9YcFAzR2VGSGhCTHVSMjRo?=
 =?utf-8?B?VlpoMzhTelNmZDc0QkxSdWpjcW15TDBHS29USVZlaHB4MG9rK1J1VU1uVWI3?=
 =?utf-8?B?WklrN2NxTzR6aXhyQnhxMU91VUx5MlNCYS9mK0lkdnNKZlAyeGVwaGt3UEc5?=
 =?utf-8?B?V0EzMXoyVDBoVWpFL0N4bXM0NUVGcnpVL29iMmY2My8wdmYvMm1qWjc0d0kx?=
 =?utf-8?B?T1hVejdKaHlvNDlQNW1lazZLQnNScnRFTHdYWWk0bzhzeloyWXdCWlc5SnNo?=
 =?utf-8?B?YjZuK2VsMldrQXRGd2tRTW9qVHNhMDUydVdlcEhMamNKT0xudEdVR3hmby9V?=
 =?utf-8?B?R3BMYjlPRUJTTHRzU0c4aU01VUV4eFlvSlF0S3Z6bWwvUzZ0Qmxxdkw5K3BE?=
 =?utf-8?B?SktjVERDQXFkOEFYR09SWFd2ajY0MGg4SE9FVHlIY2xXSnNYbVBEYmRTZ2FR?=
 =?utf-8?B?cVMyRHhNVmNYK1RPWDJEeTZIRG9vOEM1ZDJFM0phT1pUUlppaWtCUEVnTk51?=
 =?utf-8?B?QXdzQlJ4M0NybU1pdmJ0bE5BSWxhQkRHN3FyQ3M1RWgybUc5NTBQYm15eVNH?=
 =?utf-8?B?TWpnbEsvcFFlMEdyL2s5ckNQWVpoR1NmRWNpckJ2U1pPbW55SDFHdjVZWTAz?=
 =?utf-8?B?NTlPK25RSnZDWUhYNUlzaW13MjBkTTN2QWhLQmtSL0QvTi9JR2RYdytLdWFZ?=
 =?utf-8?Q?/OlFtJ5XaqXzi6xUjd0f+AHW6vHnQoZ9?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MFduaGt1SXBtcDRIcWxjM2ZXbzB4TGhINWFJL3hGeUFqTys4bDBZWVRvdE1G?=
 =?utf-8?B?ODA1WmZKWC8rczArVVpDNDkxWDFYTFczU1hXTjg0aGpoWlNXY1RtajVqM3d4?=
 =?utf-8?B?N1JjbFFBT3RCNUhPZ0Y5SG52dWVJTlNHek9SR291RGJPbmZHeTlNSlVqbU9y?=
 =?utf-8?B?ZHFtVmxLaUdOK1ZtN2lFVkFLNis3OWdncEVrY0VralhqZy9SSHBhSDZoZmh6?=
 =?utf-8?B?Zm1xbWF5a3hHRytPZlUyMmlQbDRwdjdESWdOVU5IMlZpR0kvdStBVWV2Y0NI?=
 =?utf-8?B?cnRQY1V1ZkREb2wwUklzei8xYUdEdHIrL1hlamVxNGgyaXVBUGZEdXJCZ3p2?=
 =?utf-8?B?TnA3b1VjWUt3MnJqVlZqVkMvLy8vNjNyd2lHazFzVEN2RVZJbU1PblVxZUFh?=
 =?utf-8?B?TDc3eVJhYTVBVDJ5Wm5VOFZsYkJxelIwSkVsNFkyN29wOWc4aGoyZ2lSOTlQ?=
 =?utf-8?B?aExJd1BhaFQ2Rnd1Z3duazVJRmQ2OWllUzQ0UkhsM2JlN0lML0xzam9DQTVP?=
 =?utf-8?B?d3FOT3E4c0hxd1MwcE5wbWFFc3N4c3FhNVdqQ09sQ2hsWllxeTNnaHZ2eEd0?=
 =?utf-8?B?aUN0WTdPYkk5eUUrNURKZzBBN2hlYnJkZ05wQ0hocGJ4dTlaWXhERjZmMTZ1?=
 =?utf-8?B?UUtKcExSVGlRZ2pGbVFLZUgrUzF4Z3dvNmg3MU1rN2tPNUtpY3BKM0NNdnZr?=
 =?utf-8?B?R3FHanJFY3I1OWxLTFdZR3lpVVhzWHRablNoR09DMHhSSm5DeHBBNkQ2Rlcv?=
 =?utf-8?B?TlVXZlh5MTNDeFNiblpvSUtVTTRoSC9penVnRGJwZEJYSFBCOXJkSXJxQUll?=
 =?utf-8?B?TjR3U0kzZXp3djJOTnFKMXQ3Q3phZXdxKzBqUE9WTytmWlBMb0hLRnlKVjha?=
 =?utf-8?B?dFp1WVBMSVo0VStyVjRYaFRJMnkwOUs5cnBrNnk0NDdZZGdsalNQaXJLTHVM?=
 =?utf-8?B?NWdncWRwUWZIT29EWVlOR1paZUF1bTd3Q3VVaG9uM0tFRmhkbVN4Q2tUN24y?=
 =?utf-8?B?a2k1bytaMkR1dThhck1US0tScHZIOEtXb0NWaEk1WGR2ZDBuc3ovKzlkNDZR?=
 =?utf-8?B?T1lYVXlXMUtsN0MrbXRXSUhhUllORlRsUTlJTG41bXFWc29xa2FJVHcvV1FP?=
 =?utf-8?B?UnV0VzE4UlRjQzhYZnpmQ0pYZ0xFQUlRT3l5WVl3RTBLeEp2RHc4eWhzbHZu?=
 =?utf-8?B?U203TmpCVm5TU2s2NXp3YmM1UEV1aVJCNzl5YzdVanN3V2JjVWdRcS8rL3Z4?=
 =?utf-8?B?MHlaNlR1NEJmRGpqd09jdTg4ak5CSWRHVHVkc2dVMm1uWnBXclZFbmM5ZDJR?=
 =?utf-8?B?UXg1bTRGZFRNeGlFMUxKb1VINzNORUpKWHZJSjl2Z3JqNmZLRkdPdHA5UXAy?=
 =?utf-8?B?OTBlMjRzL2lxYndVZWFWODRucXBEMStyR2JtNFNtTUlvU3FrN2JUc2crR20z?=
 =?utf-8?B?dVI5d29zL1h6bVF3Zm5kazlRQ2FXUGZQTWtaTW9CaDNGNm1hVWorK3dBaDFm?=
 =?utf-8?B?MEVseGFEMERrTUJnYStmaVRvMDJ3c2ZLNTIrVGRCZHVOdVpPYjI1Y3B6UW1i?=
 =?utf-8?B?MXZxR25TTzQ2YmxTZlpZaUVSSWV5WlBZUzcvd2ozemlHOHk4NUh0Q2V6MXBD?=
 =?utf-8?B?ZUxSbnZmK2d4dVJwa2VodkFvdFJTV1dLR2l1bnBKaFRHQnpJbXlSMzY2dnBt?=
 =?utf-8?B?eExJVzFUT3BNZnlEZldySEZJanNYOWxFU213cUo3WWs3ZC9tTUVVMlJIWDgz?=
 =?utf-8?B?NlgrZUcyQUlldVlVQnQ1M3hmemN6bFl3ZTVieTVid1dodmx0NkhQMGV3ZFRH?=
 =?utf-8?B?SjJsTEduTklpbGtnaXYvb0Y2aWNySlFLWmVyQUlqSDVwWlozbG5ZdjZwSG5U?=
 =?utf-8?B?S3NFL2RLYmJiUG40cGh4NEQ2U2ZQTEtETVdVdGxuWml4MVV3WWZEbkExbGUw?=
 =?utf-8?B?aGd1UCt3QTJ6V0h3bThiY0JpVXFvQWRLM1dDdjlqQjRQMjF5LzZZY3g2blox?=
 =?utf-8?B?Qk1KWEFlN1B3ZVZoQWlFMHNFNzlxaFZ0R1RmcCt6d2J1UUcvQU80c3BmWkQr?=
 =?utf-8?B?eXJncW0rK2tPM21YcjJtanVJYzVIZ0dJV3NwNVloU3R0TTU0RUxZczRIQWdl?=
 =?utf-8?B?Z0NDTXZxVmx6QXhEVXVBeUJ6YURXRW8rNXB5QkpJcXR2bTI1WGo1V1VWZzFk?=
 =?utf-8?B?OFB6bWdUalZrdk5oZlV1UnJ1K1hiUVZJY0xiMVY0S0k1YkZUOE5VTVRjTXZT?=
 =?utf-8?B?ZzVCbmZNcnF1RUJuRUE2VUhaUFEyMTQ5SkpLSzVSMHpjck5WcmZCbzF0aVcz?=
 =?utf-8?B?N0dFN2ZJVERjTGtmeFNpaWd1aGFEcXR2VlJGYTIyMDh3U1dpR0xFQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7+uoPWnT7NFmuVzbv8Ggtxtj3ga8UGByGeqkTTpNaV/Q0cUXZoRg3BOHokNXhq5Lc9AmhU2PVRef1hG/zPJRoZi7xcQdTjumOCK1eNV3+bCLjzy0hBHWgQjshCcW8aVabDw20ZD4UJfJ59huE8J2zz7jzpGHGGpGA54FMARZWLwq+WOyh8gcHcklh12NSdgi5jYTwFHqCvDCmKpTNH5W3uc6Ju86USoPwhCVBkzKFCNM+nsry9+nJrIYXj1R1E7/rkzX3PIZltAd7pVlQOC+gL+Oo/6VQ4gbQ3XyoScIUU26DzU4aX9TTbWxFz0ZkGaDj01Pgu2MLnKnMMQ3yBq4FUF6A6gCttL49s2aMaq/3iz5hXkE6leJYlQNaAFJbz3BU5SypZ/Km6HvVXBFfQqxe5cS5CPiGUU2hEgWYHm519EMIjKvFkEkNuCBlIrxCGWdi1a0sHkCQLXQuOeKTg4YKbC3DGNmgyCA5CP5XV6QzBCaG+5rt5bav2m+vjUwtDMR0M3JKNIfRlY9oQycz9I3Qrp/EL5DazxgRjOlv3IwyW6HusTgEAPYUQkiRUVkfeqyZs81BkQ9u2aWY1qGsUb+Wl7vR+cW0C/p+e9fekoCFqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d4fbfb-48eb-48a3-5cf7-08de418bbeb4
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 18:55:59.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Esy7PuR1dQVgI1ybdCZCnBZQYvr/QHHNCIcC20BedxUl6mjU2bFrn1I3SqDz/TdmWiXHfUm1t6DTWPBaRLY7eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220172
X-Proofpoint-GUID: RGKX-pJezInQl4YuggrohzPDECtbSffA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE3NCBTYWx0ZWRfX8NJNOcqq0pLR
 q1eOZTIhL+1nrLKTUPVoKAgZ74YfvDfEIWQDp9b/ZRfUje+IKxnMnzXdWdpZcZKJRjHetEQ+/V0
 dZTELYeLt6q0jy+mZ4rFOhv6ClbAsysLh5EBOfVdAfanipuRpxKsPfUcEHBpD4ZMNlkREFZfx0H
 JUMNDRdAkYFnpLfAfn4ntO1gOVwGd67LcyU0z2JFVaqRLK6i3CE0h5NLZfrBZ0WE/FQ1FHYcHOC
 2/dul94kA3EQF4oI7twJ1HEP8m2sM8uvF2JX4uDlAmkH8bhF3e5F0ag1HeNJgv9ppbOlCEZRTCZ
 FbB+sD77EyTFVcSumBEUEB60fWsHwBDj6PitJEmsWToJiPgw9wHCBiJRq0JlwH4QsaUnsCwh0J8
 4TBWV6vLrMPTRABs0Sbo4Ju4wbHzx/n/dIGhaxABtbq3vg2//xiL2+6CiIQb3YFK5jtwBxgZ+ug
 fwIwkCi9J6YsAzfBxkg==
X-Proofpoint-ORIG-GUID: RGKX-pJezInQl4YuggrohzPDECtbSffA
X-Authority-Analysis: v=2.4 cv=WMByn3sR c=1 sm=1 tr=0 ts=694994ce cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=Y6tBAfPya_PXm0c1Z7AA:9 a=QEXdDO2ut3YA:10


On 12/22/25 4:41 AM, Jeff Layton wrote:
> On Sun, 2025-12-21 at 18:09 -0800, Dai Ngo wrote:
>> Update the NFS server to handle SCSI persistent registration fencing on
>> a per-client and per-device basis by utilizing an xarray associated with
>> the nfs4_client structure.
>>
>> Each xarray entry is indexed by the dev_t of a block device registered
>> by the client. The entry maintains a flag indicating whether this device
>> has already been fenced for the corresponding client.
>>
>> When the server issues a persistent registration key to a client, it
>> creates a new xarray entry at the dev_t index with the fenced flag
>> initialized to 0.
>>
>> Before performing a fence via nfsd4_scsi_fence_client, the server
>> checks the corresponding entry using the device's dev_t. If the fenced
>> flag is already set, the fence operation is skipped; otherwise, the
>> flag is set to 1 and fencing proceeds.
>>
>> The xarray is destroyed when the nfs4_client is released in
>> __destroy_client.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/blocklayout.c | 18 ++++++++++++++++++
>>   fs/nfsd/nfs4state.c   |  6 ++++++
>>   fs/nfsd/state.h       |  2 ++
>>   3 files changed, 26 insertions(+)
>>
>> V2:
>>     . Replace xa_store with xas_set_mark and xas_get_mark to avoid
>>       memory allocation in nfsd4_scsi_fence_client.
>>     . Remove cl_fence_lock, use xa_lock instead.
>>
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index afa16d7a8013..348083488823 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -357,6 +357,9 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>>   		goto out_free_dev;
>>   	}
>>   
>> +	/* create a record for this client with the fenced flag set to 0 */
>> +	xa_store(&clp->cl_fenced_devs, (unsigned long)sb->s_bdev->bd_dev,
>> +				xa_mk_value(0), GFP_KERNEL);
>>   	return 0;
>>   
>>   out_free_dev:
>> @@ -400,10 +403,25 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   	struct nfs4_client *clp = ls->ls_stid.sc_client;
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>   	int status;
>> +	void *entry;
>> +	XA_STATE(xas, &clp->cl_fenced_devs, bdev->bd_dev);
>> +
>> +	xa_lock(&clp->cl_fenced_devs);
>> +	entry = xas_load(&xas);
>> +	if (entry && xas_get_mark(&xas, XA_MARK_0)) {
>> +		/* device already fenced */
>> +		xa_unlock(&clp->cl_fenced_devs);
>> +		return;
>> +	}
>> +	/* Set the fenced flag for this device. */
>> +	xas_set_mark(&xas, XA_MARK_0);
>> +	xa_unlock(&clp->cl_fenced_devs);
>>   
>>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>>   			nfsd4_scsi_pr_key(clp),
>>   			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
>> +	if (status)
>> +		xas_clear_mark(&xas, XA_MARK_0);
>>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>>   }
>>   
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 808c24fb5c9a..2d4a198fe41d 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2381,6 +2381,9 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
>>   	INIT_LIST_HEAD(&clp->cl_revoked);
>>   #ifdef CONFIG_NFSD_PNFS
>>   	INIT_LIST_HEAD(&clp->cl_lo_states);
>> +#ifdef CONFIG_NFSD_SCSILAYOUT
>> +	xa_init(&clp->cl_fenced_devs);
>> +#endif
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>> @@ -2537,6 +2540,9 @@ __destroy_client(struct nfs4_client *clp)
>>   		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
>>   	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
>>   	nfsd4_dec_courtesy_client_count(nn, clp);
>> +#ifdef CONFIG_NFSD_SCSILAYOUT
>> +	xa_destroy(&clp->cl_fenced_devs);
>> +#endif
>>   	free_client(clp);
>>   	wake_up_all(&expiry_wq);
>>   }
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index b052c1effdc5..8dd6f82e57de 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -527,6 +527,8 @@ struct nfs4_client {
>>   
>>   	struct nfsd4_cb_recall_any	*cl_ra;
>>   	time64_t		cl_ra_time;
>> +
>> +	struct xarray		cl_fenced_devs;
>>   };
>>   
>>   /* struct nfs4_client_reset
> Patch seems sane, but where are patches 2 and 3?

Oops, this version only has 1 patch. The 1/3 was a mistake.

>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thank you Jeff!

-Dai


