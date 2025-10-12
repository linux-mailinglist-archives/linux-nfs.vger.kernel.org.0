Return-Path: <linux-nfs+bounces-15154-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2567BD07D9
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 18:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7364F4E3410
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 16:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4180F2D3A6A;
	Sun, 12 Oct 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XavOufiS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TVnBXZI8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C252D3720;
	Sun, 12 Oct 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760287477; cv=fail; b=o/bAHGnhsKHnnwyCCwKcc3cshNM2dDOdI3NSgc+wQoB9I6LYNWHWrEYhNynA9t0nkMCNa9vG7kZ1vPDL2Q4jtQ1xZ49ns84UJhyU3fYx+df1hDJaGKF5wtJGBiIF7chWYRBXZbmZhWcF2+RzvVMH0vWxTM5FLmjTtzOb98xuuqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760287477; c=relaxed/simple;
	bh=QtZGRuzbUeD7oHmO0OEnh0IyVx44L7evUghBi2zke6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nsxqwmWKsRou2FNJm1Sre+BODruRn5nH2CCsTh55lgntIRzTAHtbnuNTaKPipmi4M+h5zj8W12Kl1lWooT+8x8IOVkmC+VF+4b8BAS5pKpx6me5lfOBQvf1PNb9YsjLgswZ774je/aidtx3nFMcG0dhTSh/YgzersUhKLriug8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XavOufiS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TVnBXZI8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CEidSG014783;
	Sun, 12 Oct 2025 15:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Zjzs+4xnxDU37supMZp2u8b9IurSkUgx3bdsOFmXdq4=; b=
	XavOufiSHKgDyIX2rRLuCEKB9iXhs0BkR3Dye03nplRFLm8RL6ucAJ1DtWYEYRTE
	++Phmqt031I2X/frO4GsQph8o269UfzvuBCVwnM1cuKwbgB6mc+FnB2yYbzqCVf3
	ONnjln4pRYRPSGBS4XSGFM8Rs8YYkDl/CQn9SfxlDisCbQ4q6H41R6QcgMcHIPTE
	44cEOUHs4TG7ZTihF3OUlnXL0yFOiR0E/mzwKBmtzLqMdJzEAnI76trqrVwNn75/
	NbZHfHjqfvhR1CDXfcxurlSA0ONG9VnYe895aewmWGyUxBnDSDRi8JBCgTTnzb+8
	pD/FDqcpOkX4ljtVl4OZ5g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfsrs1st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Oct 2025 15:59:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59CFVfPF017139;
	Sun, 12 Oct 2025 15:59:40 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp6q5s8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Oct 2025 15:59:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgSBz9oZYRL0OaR3amSPqnDTImdIF5jnC8XkN55kEth8tBZGdXAQYUCzlOOPaDdTK+0a1EJ720iJLqHuD6IL5JDjoDuUhSKJpu1s2ZkJBoNe4CpWnf6540LPRVcoDQ9lIkiu3snA8ji/SP+/et4JGJqzQKb1hjkDQqrk/tlDeslwGVTIazKYUyzd5PLyNiM9q2a9sT05MRm6zT/5QAaNaqGV0KPyQiZGbZTzoCo+Lc1Px4PP71NG4+JeUod87BcEATl6cmSmxQEREZ0wJuRdMmKMcWqJzJgq6VXCo7cKNRAoM346Il4hOAJeAGKb2gY5b9s9SQkkGewIUQuN8Vl1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zjzs+4xnxDU37supMZp2u8b9IurSkUgx3bdsOFmXdq4=;
 b=ytiXTPVoNZ8fL1xvVGWxm1Srf6tacykakP3XCbZNDZCE8ebIuMEN3kNXvqdYhrFda/8KPYV8yMi7w5Xm1vRTeEIuMw/F2gHQxHMwM819BBTJ78btdfcOAYIGYnEc/PrRyFScE4KjM+8gJ203KzwpEugKHG896p5QnTEZ+gRB4CnL3ZuKhoP+61nKQtNGKZ3ZAp7XQC6pxPOTHTmznHlSkjH90GLOebSEQVTBDWVnC9kSHOuM63pyH+vabo3m0rWoI54QJ6JPUhBOXUGOeQ+XvaQLQv6+MvCDC1G+vzPNM6WKsL+PqVJWd+eE+Oz1Yb42B5Wp3dRt/fsq6dA8iSj/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zjzs+4xnxDU37supMZp2u8b9IurSkUgx3bdsOFmXdq4=;
 b=TVnBXZI8W6pxnb5hbuayhUKqkb6akoMYsrzh7Njju+ju1f6ZK7tdW/umWTJkH66+/E4NQ62A9Nr2quf5qpY71j1IGKPSVeICqG0bXWjQjULB31Aen+/OXqLycYSoOYqU9Z9/c67GQ+/ghD5f2CEKCeTRnQ5Vah7Wy+IkUc/ySgQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Sun, 12 Oct
 2025 15:59:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 15:59:37 +0000
Message-ID: <5f405581-e7e2-4e77-8044-0496db85aa27@oracle.com>
Date: Sun, 12 Oct 2025 11:59:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Use MD5 library instead of crypto_shash
To: Eric Biggers <ebiggers@kernel.org>, Scott Mayhew <smayhew@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20251011185225.155625-1-ebiggers@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251011185225.155625-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:610:b1::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: a81e1fd7-2c6f-4751-2130-08de09a85813
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TWxzbEVUZmhSTkpUVncyMVdkS2VLaU5TQmhISVNMNHVyTWJ5RnN6aWNvNzQ4?=
 =?utf-8?B?NlgzQ1l6d0dXVFNlSVMzOVd2MTJDd2RHMElnMWpaRXgveVZDSHA2OWl5R2t5?=
 =?utf-8?B?aU9WUHlrS1VBVENnU0ZTUXRJMWZvYk5vSThDMy9kbExlVjNTSFhKbFNpc011?=
 =?utf-8?B?eEp3VVF0RXArZVJid3pDUXNQbm1zdThkQkZVOFBlSk9FcUhNQ0NJb2Nzak4w?=
 =?utf-8?B?b1VFdHJQSEdOWUZ3dXpPaHJQVFMvVERSeFpWMkFobGJIR2lFemJpeHVheTZS?=
 =?utf-8?B?aWNwMmdib0pyanNwM0ZyMXl1RWNKWEREMjFLL0pZMEh4MWtnVE5vY3dEM1FH?=
 =?utf-8?B?VnpWUUNIZ2FqU1pzQnROdUlMZENxaytuNWt0WjN4dVNvWkZBZFMyd3ZPV0VD?=
 =?utf-8?B?S2hiNEEzdFJyYlFoc2RFY3JYbFdwa29WRUw2MTFUeVVHYlRWRHY2Y01FbW96?=
 =?utf-8?B?SlE3YTNsS2Q3Znpqa003cjNUcW1lTGRLTXJGTy9mTWtaNWRSNGsyeXpseHRL?=
 =?utf-8?B?aHNxL0h6QWZRWWVYVkY0K0NEWHBCQVZNK1NjcUhybUlDVDA0cnY2MmwrYlV0?=
 =?utf-8?B?RkZ5VFZwdTdKK0ZyemRrMm82TjA2MmNTL3o5ZFZvTzBMVUN5eVBmU1ZBdTJO?=
 =?utf-8?B?VkZDVHZyRUxpTVV5L0x3cHlldlJVcE9nTmpxL2E1SEpud3JPWnFpWXZlOHpv?=
 =?utf-8?B?QkhFSjdFa1ZGUE1xWHBhNGhUNWVJVThtTXJiRGNZVWJ3V3JHczQybUd2WTB1?=
 =?utf-8?B?NGtSN3N4NlNnanJYRlh4QS9kcWhUQzU5WnEzZGhUTDdGV3c4eU55UE9oRk9T?=
 =?utf-8?B?UVBkSjQ4aEk0RVorczZhaE5UWlViZFJrM1Vrd0lWeUNZajVGTkZwcDBpV1M1?=
 =?utf-8?B?WENFRHpBYVZBVjZneGRjOEhkSHN6MTFIeXc3TVBUdEFEQzBBdDE0aW95Zk1w?=
 =?utf-8?B?YlMxdUI5aFBLLzIwVXBhN2h1WVJqZ1BoclMvTWE1Q0RhR1M1eVRwNmVVY0Jt?=
 =?utf-8?B?UHoxZnVXaXl5VysvajhnYkF4dVNtNndkZWl5Z2dmMTBqWjcza1NoaCtIL00r?=
 =?utf-8?B?NW8zSWpqZ2w1WUZmQVRnMFAzT3AzVmR1c0hoRUVnWFMrOHhpMXpLYURmRTh0?=
 =?utf-8?B?TWd5eElTWU0xbXhHaEFtMk5ob0lqNDR4YXZ2SWZmcUYwZzgxMnBWUDFpOWVM?=
 =?utf-8?B?WXJZS3ZlaUF5OVA1VEdMWFU1aWgxQ09ValM5RituOVBJdXN0dERZeUF1OVZX?=
 =?utf-8?B?SlpVYUpsOU4ySFcwSEVQSkxoc1ZNWUQ0S05xOURNbXRxd3pac2RPU08xb3k1?=
 =?utf-8?B?eDRqQkRVMjBrYlk2Nkl0QlJEYnRWaDVsTk00cUxKUlJ4T1BuYVBvOFhQSW5k?=
 =?utf-8?B?SzkzWEN5clhDMzlYbGh6bHA2UEkvYWg1TWlYSjNrMkdFUW9wWDJxaHdDYUVE?=
 =?utf-8?B?M0tlbGtLQkZYUVpiRmxtVVRMYUdJb0o4cVBXNTh3Y2VDaGVoVFdueXlVMlJ0?=
 =?utf-8?B?cUl2Z3dDcmpCeC9DSzJ0RGtUNFJFUExURk5EYlBjVFFKZnBFL2JyYzZNb291?=
 =?utf-8?B?VWpheFJtYzIxUzdyS2ExTU5lamg1cXdyOE1pSzIrYXJQRFNmVk1yRHl2YnVF?=
 =?utf-8?B?dGc4U0lBLzdHN2czRkg1QXg5eWVEYTdvd0VvYUlyc3g1eHZNQVBlOXVwaUx0?=
 =?utf-8?B?aklZSWwrd2NDc0FlWW5LNHBmYjdKTDVIcFpSYkVHRnNkU1pYL1lXWGRTTDJn?=
 =?utf-8?B?eGxTM2dUbk5SNVZoSmp1U1JoZGhxWkZkSmlnS1g3UkZWUWJBZEhBN0dYYmpy?=
 =?utf-8?B?RkhkcTF4WUs2bGU2aE1HbVlTVlh1WXZQMUY4RW05dzJEMlJocGszUTg4eUYz?=
 =?utf-8?B?cTZlNmdOaFJXZlRtYTlCNWQ4NXN4cUtWbkRxMlc3WHFwVmxsdFVUUlBmUGtJ?=
 =?utf-8?Q?HWuUIiwd7Gdu3GXZcUJeoordfkhkNBqx?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OUgwZU1FS09JNy9TeHd6RVF5L0dXTXNIUWdtdXQwUGg0dDNrVUZ4anNaQlBJ?=
 =?utf-8?B?MnRxSDRXdVNLS0ZYaFQ1UjJ4NDhDQmJITm1KcjE0ZWNDWkQ4QitIN3JuRmE0?=
 =?utf-8?B?QmJ2UXYzaFNSYVBvKzJZYjdsS2RvRklLU3dOUWR5eHBiVzFEMTh2bWNrb1d6?=
 =?utf-8?B?TnlWeVNseGwyTkJZYUFKUEhBSFpLd01UYVdQTjFpc1pUZXZiRkp4WFppTElN?=
 =?utf-8?B?bjh4MkVydFpKT0UxQVh0OTlRRGpMdWFJWTRHSTFzZVF5UDB2bmFOV0VyOUV2?=
 =?utf-8?B?YUJuQ01EWnVLSUZNUVNURGJqR0hLNWtQenl0M1hDY05CS2swMmwxTU9NSXRE?=
 =?utf-8?B?V0dpbkMrRWExWDNRUnk3VWh0T0RaU1FBSWNVblR3MzB5ME5kT0F5azY5L2V5?=
 =?utf-8?B?VnBSSURPSER2T1JXSm5lcnRaZkxuajE5TE1XSCtlbzlhVWN5bXJxOXlRRHgy?=
 =?utf-8?B?cjNsODRNYnI5SldKNURTSkYraXlmdWsxOFIrT2lGL0NpdXBJQkpaVXRXWkdX?=
 =?utf-8?B?STBGUkMySlRHMENXeG5ubkJCR3FFWEF3ckpja29xNVdnRnNwbFMxMzJHbmc3?=
 =?utf-8?B?ajY2bmJsVG5WNlhxdFNYcUtMQ0U3aXNZTW1oN2U5UlhzdVRXZ0NmNHYralZo?=
 =?utf-8?B?TzhudXMyeGNvRHRzOCs4YjBzdFlneVl0TXRtU0c3bUZ2Qklib0lNK0wyU2h6?=
 =?utf-8?B?VjJnVmErMFRROE9lbjJqWmZuT0VYbUpHRUwwU2xoanp3STMzZTh5c3hLdFdx?=
 =?utf-8?B?QXlYa2g1WDJBQ09rNmM2Y2l3VEhzYVJkV2tIYXJMMW9FVElTY0FhVEFMS2Fh?=
 =?utf-8?B?dW9aK3kwTityNnJHeUVGWFF2MlRJb1dabGgzQUFzeWg5YytuRG92U1phd2JC?=
 =?utf-8?B?L1EwU29uRWVsSGdRdzl5TXplTE9pWjZiZGhXS0ZKNXl2NWsxb2lvQU8wNSta?=
 =?utf-8?B?NjI3S3dwUUF5Vm9wVjRGZ0pYM2s2bzc5a2ZzTlZqRW9aUE9CMERvM1pScXZo?=
 =?utf-8?B?b0hBOUYzSUE5NHVYcCtrRnVkNkV5S0NwYlUzbm9rRU5QT2VxbW1zdGpLUm04?=
 =?utf-8?B?RGF2TXMvcGhwVnppVHpHWGQySWUvNFhTaGJZUURZWWlJZXBYN3Y2SHdrd0Z5?=
 =?utf-8?B?M001TTJwWitvUStzaWNXQkxxbzJvS0x2bnBaaFZqR21ISTF6K2hqWk1sRXQy?=
 =?utf-8?B?aVU5UTNYRGpoSW0xR0RheWx3SzdLNEo3RXhycDlmdmRUcU5HdTYyN1ZsbHBq?=
 =?utf-8?B?ZVJlWGtDa2I1QjhWU2RhcjRIc05uSUdxamxKVUxibWZOSEN6Mi9tdmlBUEJ3?=
 =?utf-8?B?Q3NGdXlla3MvRHJ5UXlmWmg4bWMxSW03cUxqQ1VGYkJnVkZOTGd0L1ZyaDJx?=
 =?utf-8?B?SUZVS1VhQ3psa0UxNjFGcHVGOE1jUzFtbVRhRWN3eEJKWkRCN0VFV0IvSHJD?=
 =?utf-8?B?T0tQZnVUbElwK2JMTVN6MmRvSUZCZ1BmaGpTMHJITGUwZmk2Nlp4dCtKWG5B?=
 =?utf-8?B?MXZ6c2R6TnFSclgwRlNteVF2RHhsbGxWbXBBNzRjaGkyMmt5eW9YRUdCbUpZ?=
 =?utf-8?B?RXJsUUVvUEF6dTFBZnpPd28xNFFFVDhCK2MvTFdWYnpZWFVMYUFxdkZCbVBD?=
 =?utf-8?B?bkYrbE1GTWxqQWh4YmZhM1pPUGxuWGc0L0x2QkYzdG14cVN2aWNWR0dJSTNH?=
 =?utf-8?B?S3VNbW1VWHBHUlV5MytXUlZKZmhKdHZSQkYvRHJvZFQ3eVphSy9iUFFubCtG?=
 =?utf-8?B?WERBUjBYajVzWEEyNGJYLzlzeldDOFZlNlBhM2Z4OTY4ZVVnVDN3eXRZZVFK?=
 =?utf-8?B?QUV0aFoxblBTdGpWanpmaWljdFRxMkhJYjBwOWpLUUNqSFk2dVBrbnppdWtH?=
 =?utf-8?B?RUwycWtYY1BRREFIZ204ZStZaDh6UVkrajVOMHZNb214RUFxZUNIN200Vjc2?=
 =?utf-8?B?VXhKN0xUOW0yTUh5UUwyckJOME1ta2wrL2RSN0NxYVNOZVU1ZGpna0ZoUm5u?=
 =?utf-8?B?Z1dhTmdrWUFlcC95UElpdUVOaWhkZlBLRnhFNE9TVDZ2VkxyU0tNYk1xbTIv?=
 =?utf-8?B?YVN3bHpmci9IbGRGbEdDVThZZGJ4MFowK0NldEw2UDRWNWhOdHNzY3ZtTmFE?=
 =?utf-8?Q?5xX9NY4L4AIeTwL6JeyV9k2A2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EBAzGtFKTCqFdfMhlRb76KQ6o67N4vJ6LCTEmr1EkDDv2QqsskcSfSYCth5sw62lCBwHzG97k0JkM83Ui+QX+yoZQ5dvWWeq88qyxKYKq58FNohu42lVj70Jzd3/+XSGh4edUh1Dep9kmQaGEef2TtE6lJpdsMF4OBdvyZgUWhyEnRkC3TyCVIoG1wQ6G9Hh5Kh+r3WsG1zj1au0O3CmCM1/bc+2783GFOZPrW+7wxS+yYmDq9Agyy+TOVR46f/GrEfBOrloyG7/BMeeszRB/c6LA5sxUzrn1KEnjltNR9m+NIrXyQoEE7UESm6Zp0mf/atyhOedmY6uevoS0oUwUM2qylF1KD2Neb8GH0/ziHCY45D1Z+B+KioeviJJBT5MFUOwTgIifkV0XMOEKiNwlaPs7lNy0Z82Noxtrsuz6ZtOlscvlPZDzXERS93Rlb7t2YvjigcKskuWa/4rBSuhckHH/KIvPbJ9GGLA57x8bA2LCYNCiyYvme2VG6Xxak+1h2eYODEapl2hKEF1zi0AjX+FsSvM2HKbb7iQNfgj/GTFI2gmiwd0IpliRFa82beKjAUTmWcZY3fXjnQkvXDMXqlfUb5R1aQjzj1lx//IOfQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81e1fd7-2c6f-4751-2130-08de09a85813
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 15:59:37.2475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqrcTHiHZH/d8V4Uvk/vL7ebx8gEr2QgpBvTjYD6i/odg40E7AkqD2GkqGfQ6apFIfBhvYdbUOKHRO+LOvgk8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-12_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510120084
X-Proofpoint-GUID: yQO0F1FIOQWcKzT_qcovXgHqjz9fVRxL
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68ebd06d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=gxWhIeX5H-YxKww8RJ4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX3fIwbgGqI/Sd
 +pqXV5WXyKZkmqf7JWw6lqqDFfwa7okso8NiFgL3HN/AsgHdwdrIkb+xxt209I0XzwsEhkh/OLH
 tlgsZxtxm8ux9CppiwZoOsW68qfZn0ibgqJIVEkGShmpy5ajMjJLPNRDead6gMwR7AcCmdmIbIA
 +yOXabgxWfFJkoHyMreSF3PlNG5OwevHsao4arPyvmdch8zoU/2iBoZvMvpo6I9C3pkhMPrHEB0
 k6k4k19wUtuAOdaOTTngohkBsxFmnUHGuLC6N4gkd9KIi9rGKmZZkxw3j+VY2Q2J9dX9XnE6YU8
 +m9LNe+d3Bm+NtJT00vxKATq2ysQvmZCLxlp3d0jxzq0dLFVM6PZx/2hB30jFg9pvurU9jNswXS
 Mc9N9hijKUV6GDlVjtK9iYeZFP4N0w==
X-Proofpoint-ORIG-GUID: yQO0F1FIOQWcKzT_qcovXgHqjz9fVRxL

On 10/11/25 2:52 PM, Eric Biggers wrote:
> Update NFSD's support for "legacy client tracking" (which uses MD5) to
> use the MD5 library instead of crypto_shash.  This has several benefits:
> 
> - Simpler code.  Notably, much of the error-handling code is no longer
>   needed, since the library functions can't fail.
> 
> - Improved performance due to reduced overhead.  A microbenchmark of
>   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
> 
> - The MD5 code can now safely be built as a loadable module when nfsd is
>   built as a loadable module.  (Previously, nfsd forced the MD5 code to
>   built-in, presumably to work around the unreliablity of the name-based
>   loading.)  Thus, select MD5 from the tristate option NFSD if
>   NFSD_LEGACY_CLIENT_TRACKING, instead of from the bool option NFSD_V4.
> 
> To preserve the existing behavior of legacy client tracking support
> being disabled when the kernel is booted with "fips=1", make
> nfsd4_legacy_tracking_init() return an error if fips_enabled.  I don't
> know if this is truly needed, but it preserves the existing behavior.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

No objection, but let's cross our t's and dot our i's. Scott, when you
have recovered from bake-a-thon, can you have a look at this one?

Thanks!


> ---
>  fs/nfsd/Kconfig       |  3 +-
>  fs/nfsd/nfs4recover.c | 82 ++++++++-----------------------------------
>  2 files changed, 16 insertions(+), 69 deletions(-)
> 
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index e134dce45e350..380a4caa33a73 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -3,10 +3,11 @@ config NFSD
>  	tristate "NFS server support"
>  	depends on INET
>  	depends on FILE_LOCKING
>  	depends on FSNOTIFY
>  	select CRC32
> +	select CRYPTO_LIB_MD5 if NFSD_LEGACY_CLIENT_TRACKING
>  	select CRYPTO_LIB_SHA256 if NFSD_V4
>  	select LOCKD
>  	select SUNRPC
>  	select EXPORTFS
>  	select NFS_COMMON
> @@ -75,12 +76,10 @@ config NFSD_V3_ACL
>  config NFSD_V4
>  	bool "NFS server support for NFS version 4"
>  	depends on NFSD && PROC_FS
>  	select FS_POSIX_ACL
>  	select RPCSEC_GSS_KRB5
> -	select CRYPTO
> -	select CRYPTO_MD5
>  	select GRACE_PERIOD
>  	select NFS_V4_2_SSC_HELPER if NFS_V4_2
>  	help
>  	  This option enables support in your system's NFS server for
>  	  version 4 of the NFS protocol (RFC 3530).
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index e2b9472e5c78c..dbc0aecef95e3 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -30,13 +30,14 @@
>  *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
>  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>  *
>  */
>  
> -#include <crypto/hash.h>
> +#include <crypto/md5.h>
>  #include <crypto/sha2.h>
>  #include <linux/file.h>
> +#include <linux/fips.h>
>  #include <linux/slab.h>
>  #include <linux/namei.h>
>  #include <linux/sched.h>
>  #include <linux/fs.h>
>  #include <linux/module.h>
> @@ -90,61 +91,22 @@ static void
>  nfs4_reset_creds(const struct cred *original)
>  {
>  	put_cred(revert_creds(original));
>  }
>  
> -static int
> +static void
>  nfs4_make_rec_clidname(char dname[HEXDIR_LEN], const struct xdr_netobj *clname)
>  {
>  	u8 digest[MD5_DIGEST_SIZE];
> -	struct crypto_shash *tfm;
> -	int status;
>  
>  	dprintk("NFSD: nfs4_make_rec_clidname for %.*s\n",
>  			clname->len, clname->data);
> -	tfm = crypto_alloc_shash("md5", 0, 0);
> -	if (IS_ERR(tfm)) {
> -		status = PTR_ERR(tfm);
> -		goto out_no_tfm;
> -	}
>  
> -	status = crypto_shash_tfm_digest(tfm, clname->data, clname->len,
> -					 digest);
> -	if (status)
> -		goto out;
> +	md5(clname->data, clname->len, digest);
>  
>  	static_assert(HEXDIR_LEN == 2 * MD5_DIGEST_SIZE + 1);
>  	sprintf(dname, "%*phN", MD5_DIGEST_SIZE, digest);
> -
> -	status = 0;
> -out:
> -	crypto_free_shash(tfm);
> -out_no_tfm:
> -	return status;
> -}
> -
> -/*
> - * If we had an error generating the recdir name for the legacy tracker
> - * then warn the admin. If the error doesn't appear to be transient,
> - * then disable recovery tracking.
> - */
> -static void
> -legacy_recdir_name_error(struct nfs4_client *clp, int error)
> -{
> -	printk(KERN_ERR "NFSD: unable to generate recoverydir "
> -			"name (%d).\n", error);
> -
> -	/*
> -	 * if the algorithm just doesn't exist, then disable the recovery
> -	 * tracker altogether. The crypto libs will generally return this if
> -	 * FIPS is enabled as well.
> -	 */
> -	if (error == -ENOENT) {
> -		printk(KERN_ERR "NFSD: disabling legacy clientid tracking. "
> -			"Reboot recovery will not function correctly!\n");
> -		nfsd4_client_tracking_exit(clp->net);
> -	}
>  }
>  
>  static void
>  __nfsd4_create_reclaim_record_grace(struct nfs4_client *clp,
>  		const char *dname, int len, struct nfsd_net *nn)
> @@ -180,13 +142,11 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  	if (test_and_set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
>  		return;
>  	if (!nn->rec_file)
>  		return;
>  
> -	status = nfs4_make_rec_clidname(dname, &clp->cl_name);
> -	if (status)
> -		return legacy_recdir_name_error(clp, status);
> +	nfs4_make_rec_clidname(dname, &clp->cl_name);
>  
>  	status = nfs4_save_creds(&original_cred);
>  	if (status < 0)
>  		return;
>  
> @@ -374,13 +334,11 @@ nfsd4_remove_clid_dir(struct nfs4_client *clp)
>  	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>  
>  	if (!nn->rec_file || !test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
>  		return;
>  
> -	status = nfs4_make_rec_clidname(dname, &clp->cl_name);
> -	if (status)
> -		return legacy_recdir_name_error(clp, status);
> +	nfs4_make_rec_clidname(dname, &clp->cl_name);
>  
>  	status = mnt_want_write_file(nn->rec_file);
>  	if (status)
>  		goto out;
>  	clear_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
> @@ -601,10 +559,15 @@ nfsd4_legacy_tracking_init(struct net *net)
>  	if (net != &init_net) {
>  		pr_warn("NFSD: attempt to initialize legacy client tracking in a container ignored.\n");
>  		return -EINVAL;
>  	}
>  
> +	if (fips_enabled) {
> +		pr_warn("NFSD: legacy client tracking is disabled due to FIPS\n");
> +		return -EINVAL;
> +	}
> +
>  	status = nfs4_legacy_state_init(net);
>  	if (status)
>  		return status;
>  
>  	status = nfsd4_load_reboot_recovery_data(net);
> @@ -657,25 +620,20 @@ nfs4_recoverydir(void)
>  }
>  
>  static int
>  nfsd4_check_legacy_client(struct nfs4_client *clp)
>  {
> -	int status;
>  	char dname[HEXDIR_LEN];
>  	struct nfs4_client_reclaim *crp;
>  	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>  	struct xdr_netobj name;
>  
>  	/* did we already find that this client is stable? */
>  	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
>  		return 0;
>  
> -	status = nfs4_make_rec_clidname(dname, &clp->cl_name);
> -	if (status) {
> -		legacy_recdir_name_error(clp, status);
> -		return status;
> -	}
> +	nfs4_make_rec_clidname(dname, &clp->cl_name);
>  
>  	/* look for it in the reclaim hashtable otherwise */
>  	name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
>  	if (!name.data) {
>  		dprintk("%s: failed to allocate memory for name.data!\n",
> @@ -1264,17 +1222,14 @@ nfsd4_cld_check(struct nfs4_client *clp)
>  	if (crp)
>  		goto found;
>  
>  #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  	if (nn->cld_net->cn_has_legacy) {
> -		int status;
>  		char dname[HEXDIR_LEN];
>  		struct xdr_netobj name;
>  
> -		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
> -		if (status)
> -			return -ENOENT;
> +		nfs4_make_rec_clidname(dname, &clp->cl_name);
>  
>  		name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
>  		if (!name.data) {
>  			dprintk("%s: failed to allocate memory for name.data!\n",
>  				__func__);
> @@ -1315,15 +1270,12 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
>  
>  #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  	if (cn->cn_has_legacy) {
>  		struct xdr_netobj name;
>  		char dname[HEXDIR_LEN];
> -		int status;
>  
> -		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
> -		if (status)
> -			return -ENOENT;
> +		nfs4_make_rec_clidname(dname, &clp->cl_name);
>  
>  		name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
>  		if (!name.data) {
>  			dprintk("%s: failed to allocate memory for name.data\n",
>  					__func__);
> @@ -1692,15 +1644,11 @@ nfsd4_cltrack_legacy_recdir(const struct xdr_netobj *name)
>  		/* just return nothing if output will be truncated */
>  		kfree(result);
>  		return NULL;
>  	}
>  
> -	copied = nfs4_make_rec_clidname(result + copied, name);
> -	if (copied) {
> -		kfree(result);
> -		return NULL;
> -	}
> +	nfs4_make_rec_clidname(result + copied, name);
>  
>  	return result;
>  }
>  
>  static char *
> 
> base-commit: 0739473694c4878513031006829f1030ec850bc2


-- 
Chuck Lever

