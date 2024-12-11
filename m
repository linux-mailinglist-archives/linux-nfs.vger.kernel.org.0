Return-Path: <linux-nfs+bounces-8522-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0529ECD8F
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 14:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3D5282AD4
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8115236FA5;
	Wed, 11 Dec 2024 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RFiTsBe4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UYM2JD/L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038692336BD
	for <linux-nfs@vger.kernel.org>; Wed, 11 Dec 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924678; cv=fail; b=oEg/slDf1JAtQp6OZ6N1vR+l99m+aZb9Uro+P/4g2DOKtIqZjhSnNmSWfec0x8Mf/sTm0ENU/zSqYaJ1lrHVHHk3iFfy+H5uJHmwZe4tCo2lXPU5zGQXqcCBZnlnuCE9aXcp3fe/OnJ1RzsvJCA6aWsL36Bi/YyPiVK/pBAyRK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924678; c=relaxed/simple;
	bh=de2i30qXbOLL56OiGkZ7NigkRKAnfjnAzeaBwRvKMes=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bvq0+JleunA7nRWHdAQRQ1paAYNdaKNrFtoIUdqS+KnkITrg6x+C4r2fudiPhLhWZL8CTTe8BaY7bmu92Q5n0C9yisSfOPRmwLn755APXZOrkuz9Ryi4R0JjG9upDj/PyqQBvEOrQN7AldZ65pBABmU9OAvZ1anNTC2KjtcTdWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RFiTsBe4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UYM2JD/L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB8RKwE016785;
	Wed, 11 Dec 2024 13:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cZ+zskdGLKs/2o9jaCGyOcZHi7IWI1qN4ZVfuZLTmwg=; b=
	RFiTsBe4p9xdq8lxuyJTybl+KZM0JFa2WJbeo4JLdWPlbJLqMcDNr3wCku+1oONP
	bLjYJQjzGD81XRG+rjwX8RLuTcILGZqL8f0tdrrtI27ZLshwUx4F+7QY+U2lGSx6
	Ea3segV5K0hItWPrNct7Zu6YrIN37vC07sfosdfE35Y7EhEgAeOlUx+cUDcepEUj
	sgXGldxlWV3s52RxfqFVkTSwKufwGa7+ZYtBmGplMc/dKPuo+lK5VaGdKYG6736i
	VqoCLXk4e1vgd0lGmOhbYf3Gld4DzC81H5LBb47AvD4RpNCFfji7EShqtotXCWWr
	Wr6g0CiIvZDW0Z2YvhKBhw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr66tff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 13:44:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBC0ZNU019340;
	Wed, 11 Dec 2024 13:44:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct9ywak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 13:44:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKThTNMncDw68RlG1K3/K1xc6iB9s/8nnpHIRW4YAGf3P6NqNEYc3rxWcEJSNcaLtZ79f9OJ7u0l2iIvLRqBM0SChGi/0Isi6U6B9mOzDZdsYESG4B1Y9zXKQuPcqhQzIcjpi5ykpqDyWS+nxRFH6pSsBrGJITzx9EoP0OkmvnR1glZrIO3Um6XNN0dOznQ4MRod8b7wIuYEavQvdwaUWf+hMvcwsoSulRObvYPKz+a7vaOFJPQxdPkG38eqlbivWXIIsE8ql5w1BQJiiCwCHvtf46+yCesiC5GuW5EvV/wRDs/8/gtYPTHv9RiETWWNTmyrYNYd/8YMb2F0xnb2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZ+zskdGLKs/2o9jaCGyOcZHi7IWI1qN4ZVfuZLTmwg=;
 b=ctOvIu7qMeI7z3tBDq9q+QAS6JmJHE0ADxpdL4TRU3rttiiPkmKPel7ZPDjfxkI+lX40jLbsq6EB03da6VULbHzhYAu2dXdD17bZUHdKvzVkVSl77u6wTCaORZE0CipmDK42SnNMfuREiszQgS5l6AQBexIwQdn/oy4E0MbOtN8Bq7F64RlYe5yYZhSuVT+Gbm6Ea1kAG/f9Np/EegRdofQ0Ya506h0zUiqfttneuyF/apw+NDY+NmyqoaqPgLqDJn9YRAC0qXpWOQIMCu0Jrj+1NXTO1okGbueTc93APwYg/ZdHQQ6+EIdLnLyzeckEBH9/Rw1eI/vwNcUVx1PoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ+zskdGLKs/2o9jaCGyOcZHi7IWI1qN4ZVfuZLTmwg=;
 b=UYM2JD/LG3cD7u1+fedI/CDMHm+MLlSXlS9rIXCMmRA6iE5+uonrtIy3/SCswOS5O0ZpsTCe6RkVHx1xJRzjbh0+p9nTIbW1EvF9zLo93J6ZHcTBxxwrQUokgQy3L/jTOZTg+zTedEjkK/vo3yFDohjSB2aCfruVwA02AH4ABV4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5720.namprd10.prod.outlook.com (2603:10b6:a03:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 13:44:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 13:44:24 +0000
Message-ID: <763cd03e-7b5b-4f1a-9184-b74c06532179@oracle.com>
Date: Wed, 11 Dec 2024 08:44:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] nfsd: add shrinker to reduce number of slots
 allocated per session
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jeff Layton <jlayton@kernel.org>
References: <> <526f9a90-6515-4208-a40d-10c5c38a5a11@oracle.com>
 <173388793661.1734440.6914654105982751515@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173388793661.1734440.6914654105982751515@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:610:b2::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c0e0f5-e1d4-4f22-1546-08dd19e9ec8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWl1REUwYXVTQkRza2VrdHhORmNqcUlndml1LzdLU0NIcW1oenFEMU53U1NT?=
 =?utf-8?B?Z0F6QUNCQVZLb0FPeXlBY3dhMHkrSGxMemdkcmNZdHZxN0VOajNWcGNYUTYz?=
 =?utf-8?B?VXQ3WXpLN2lmcXVEZSsyS0Ixb1gzR1hkeklmZnBOYzBRUTFkTzFSWGh5Qm9t?=
 =?utf-8?B?b3FVOUNVUFVYcGxzZnhJOGlBTDVoVmFQWHNFaGlNSHd3Q1FKZzJzRlJwZzB6?=
 =?utf-8?B?RXJuS2hzYjZXU3hLM2V0UHhYejdJWkVYSDg2OUF4TStSZVpNZE5FL042ZHQ4?=
 =?utf-8?B?Sk9EblF5Wkl2M2YvYnNwQk9rSlZiSmorNnV3THBKWHg0M1AwVU1RMDZIQUk0?=
 =?utf-8?B?b1hHMFdob3ZTTmhQRUFmZ2FicDJ4T3VTRnA0WXBuUVNJeUptNit2RnJnTENQ?=
 =?utf-8?B?Y0lrc0Q0KzZ5UFExWGVxSXRHVE9sYTB2NW04WmQyZzJ5ZjVNYU1sbEJGZVdR?=
 =?utf-8?B?bEVyTjd2czFiMnZjaGJWZ051OWZjVGhNSlhCYk9YN08xdWZ6aFRjNjJpOTVp?=
 =?utf-8?B?alFxVTV1dEtHQ1BEeHVhajNNN0dDeEdlUmNjSXJ6akZsN3RNemhNV2VEMEhu?=
 =?utf-8?B?VmNrbUplT3JnVlBXbHJaWnRHUTlZeHNkcmVrdzV6MDZYWklIVXBrMzFpM3Qw?=
 =?utf-8?B?OHVDdEozK09URG9aNk9LcTZJOHFadXdFUmtBcHJkSno0alc5My9Vei95MzRE?=
 =?utf-8?B?akRlSTJjN09lVWNHN21uaUh4OFBkN20vVmdPYWJ6OVRTY1R6YjNTV1UwOWJk?=
 =?utf-8?B?TnZraG9wbUNDbG9icjdIcEZ4WHV3blV3MjRwYUc4RGRUMnhRblIzazVQVmFB?=
 =?utf-8?B?c1I1aE5OZnFPZVhpbUV5V0J3WXZOem1ZVEw3YjkvYVBqem9ORzhzMHFwd01N?=
 =?utf-8?B?OFd6cldSejZ0aXdSOWJXR1pSY0RBYW0ySWQ4eStqQkZUVDhBSmRiT3ZuVkRm?=
 =?utf-8?B?NkpISmt3M3pxNmVKd3BXQ29Sa05OWWNLMUdTc1BnOVowQ2Z4LzZITGF5d0ho?=
 =?utf-8?B?UnpkaWJ3dC9CbnZDYVVmVHdpSlVxaDVZM2EwVXFSTXpsM0xaTWhjYUx5ck95?=
 =?utf-8?B?VUo2Q1laeDNmSXVuSm1uUkdETEM0RW94dEdlQ2FWZHBXV1FzeExjc1Q5aHJO?=
 =?utf-8?B?clJ0K0wzdVJNbGx3b0txd0x2OUN4a1NvNTd2aENDMmdFSUtOb0Y5VC96MkxL?=
 =?utf-8?B?UUNBZ0tZRWROengxQnQyUW1mS0wxZ1BJcVdMMXhhK1M0RFFZdlhCd25xd0tk?=
 =?utf-8?B?RGFqOW01eUxscXhWR3ZDbFlTWk5nY0ltY3pnMGhTR1Nrc1l0T2w3TytTMngx?=
 =?utf-8?B?WWZwV2QyOGxiZXR6Z0FJUzQyRXVLR0QwbFVmcWlxNENRcHdDODRjZWNEb0pQ?=
 =?utf-8?B?SEtmaWNTTG01TWtnWG5RSVVEZVJDazIxOWxaLzJ1VGNWTXZ6N3VYUmtGVzVN?=
 =?utf-8?B?ZzhocWd6MWl3Mk02dGVtL0c1L29UT1J3UEkxdGZ3YjBsTmM0bFZGbXVSdHZm?=
 =?utf-8?B?cGdNVWEyc1FHU09pZFhqWmwzam1sR2ZjOUxGemdHSWdubXIyam5FREFoWi9k?=
 =?utf-8?B?N0JnMVFKR3M4OEhCYzRIVCtwWmFlMVdyM0d0ZkdGWEFGTC9sWXFNQmRMUm9L?=
 =?utf-8?B?MlZJM21TV1o1M1ZJeDZ5WTV3MHJnR3k0Q0h5L0c5NVNHRFdKOUtzR2xzQ0dj?=
 =?utf-8?B?YXF3MjgyNmtxSWdLdGEwS0o1SFplUGpMRk9PMkljQ2ZDMzVFcHNra0VtQXgv?=
 =?utf-8?B?WmIwS05rQmdVM0hmRWdCY3RIK29QRzdacUFXbENrZkR6eW5wYVFuNFo4T2tK?=
 =?utf-8?B?QUJiNnV5U1J3dWlwWENMdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHY4NUZtWUVSVWJxKzlkQWdyUEdLYVdINXFrd1BQWmpSOCtUbUVDSm1ZUWow?=
 =?utf-8?B?UmtGaDF4WEVZeVpUbklZYlB0U1BSZTJjRmJGM2RaWXB5VG9wWWFUdFZwNWdx?=
 =?utf-8?B?eGpOb0VFdmdGV3c2S3FyWkJSQkNBdVNTL003TE1JRFBaM2FPYi9zaUVFTjhu?=
 =?utf-8?B?MDdlazZyUE5WTzBFMTdSZ1IzVWNXcWczeDZLUjBCWFp2NTJZb0pBaXNWUWZy?=
 =?utf-8?B?QjRxWWxwaTFwUWJpN3hXS3JXQzJObTBDR1hUdXUwRHdSL0JBRlM5YWp1NGxl?=
 =?utf-8?B?Q01XRVU5VzhmTHFZZ2E4Vmd5c3gwSVBFZk0rSTM2ZTlvNllYb1Bod0NENU1v?=
 =?utf-8?B?bGR4L3piWjRiTk5oT1RiSVZGMWdSUG5MYWh0bVVRNGRoRWM0Z2ZoZ0lHUnRh?=
 =?utf-8?B?YWNkZW9BYlZqWVErek9taEF4T2xNeDVNdXlUcWFqV0JCYlFvN3E5aEQzVWpn?=
 =?utf-8?B?Q2oyTjZDeDcxVXBkTXpTWnQzKzRjNi9YekhYVWM5cFRXVGVaeUliSTQzZHhB?=
 =?utf-8?B?aHhBN1NiSmQ2WjFPNXJ4ZW15OFZjeldYR1BXa2pPcVBiaTR5bHBKaWsxSTht?=
 =?utf-8?B?UE83QWdMQlpCMHB4dmZOaFVzdWhtdVE3ZmRTdEJ3dy9KUy9xT1ZzRzA3YWpJ?=
 =?utf-8?B?ZTFEV0xJZThldE9rOTU5ME54WHBsaDF2REVXRlZQVkRIdDNYOTNZQUVrOEVG?=
 =?utf-8?B?YnEyLzVqTGhVcHZSY1kxNlhqcVFkZHBoYk84YUdJeVBDcDlTZ3RJcThDVFY0?=
 =?utf-8?B?VEQvUXYwUnBhUXRaK09WQllyRmtSbjFodVI0akk0d3A2NUd0V0xLOFFFYTdY?=
 =?utf-8?B?Vjd1YUxJb3N3Mm1yUERQQzhJK0FYcndOdUpFTHpSR2laWGp6RlZTV2hXOVVj?=
 =?utf-8?B?RWQwUkUzQVBqc2NtMThoTW1jeWkxaWRqK0oySXZvMlVTK2hsZUVZelhjRkJL?=
 =?utf-8?B?YkZDTXIrd3h6TlpNMlBVdU1UTUdZa2JKeVlGa3ozVThCQnhSdERtVVBFSG9J?=
 =?utf-8?B?L3Yxd2psUEt5b012bXl5LzFKK0txN2lCYWtRenMwMTgrem9kSlJOOWJnUWJa?=
 =?utf-8?B?N2ZMZEJTRHA3Z0tETE9BR0FEYitSSzZnTys1bHZWbEpqaGV6c3QrYnZmai9N?=
 =?utf-8?B?S3M3U3dQaWVjakhHUC9uSHJ4d3FZWlk2YjRMdFdJNFdSTVFwbXZMd2x5bll4?=
 =?utf-8?B?VnVxWU85TjdxbDUzam1EL0dpbFN5VUdkQ1BYUWd4ak5KNWdxVm1ZejVtWkdH?=
 =?utf-8?B?N2ttZWhtS2NPN09acWMxUTB4OUcrSlVKUE9JSDlPUlJhWVF3ZENrUU45UVJw?=
 =?utf-8?B?Zlc5TG5OanR1TStQQld2NE1GaEh1blk2U2ljdVBuMHJTV2J5MFhDYUVBRkY1?=
 =?utf-8?B?bUVBenI3SE9wSU0vUzNrNjF3dXFnbTIzTlRlMitqeU9OWjg0dHd3SEtsNUJi?=
 =?utf-8?B?cmFxdnplZ3F5N25YYWNJb3R1N2dland1aHdxeWFMeUs5bkhYbFVwU2NMaGx5?=
 =?utf-8?B?eFJPcEdheHFQK3R5Z0tlNmg1aEg4NllUZGxxRTNkWTh0RDVRMlNlNkM3Sk1s?=
 =?utf-8?B?bUcxSzlBMEkvbVVBeFBLSVR3MU5ELzdjUlpmak9sbzZJdCtwNHptdzlRZ2dz?=
 =?utf-8?B?UUFMZER2TjVISnpiZkplbnpUVTNOdlZyUDZoV1k0ZURMQWJBaHRlWmMwallt?=
 =?utf-8?B?bEtrVklJSnBUOUppMHBuSWZyYUJSUDJMWFYxdHJzYXZqdi9BaDJxbE9Ud1dl?=
 =?utf-8?B?eGdVbUtPc3NVN1hMeUNhaFNGQjMzaFdJMzRNNWJ5VjVaVVVJc2k1UlU5a3pk?=
 =?utf-8?B?ZTB5K0xiamEyK1lPWU9DMFZVUTdmUzB4ZmU1OWFTQUlvakRPV0hlWi9JM3VL?=
 =?utf-8?B?emxOZG9CUUV1b3hTczRtcWZpMmZ1N2h0amlzc2gzMVh3ZWs2bGJHczhEUlo3?=
 =?utf-8?B?L2lDelNoa0JIRC9IYktuZXg4TStwcklHd05QcGtiRkJxUGpCSHBBWVp0UUda?=
 =?utf-8?B?Q0xDb0ZDbVhZK2dpd0RqSWpMTTBZWmpNMGxHNHVLTWlIZTZwSkJxME84UlpB?=
 =?utf-8?B?dnNGZncyaEJNRkE0d3prQUVUUW9jS1dZL0U2VHAyc3R6dlJwOThmbjhvRXV4?=
 =?utf-8?Q?Qzr8IcZUI9NKD4E5L0U1YmICc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZrI+k0nTk9l0jnQw+V40Z5A1L0Q1mp6m/wsnxpM5hqCgKE1N1RlmsMh2F4nB8HOoHpouQe5gENrHmwmQ4uluu98QmmFt7A0r4BGSaB+vjHrOqr9XExy9lU/PIC+FHBfVzyC/vtmPyRWnwFABrLpCryvnxonjWToWpsFXZTs0eqvNn+ecOs9DKei5Y8wQgjQauU1NK6OF3Reg/74R4/Ie9Ug1eT3ZBK41A9QOoTdYJzPFF4SGJ0qwg+LMwoq2zoueef7M0bJquHx6nxYwcLNmQ+B4K8v2K5J/mFNqdkGklbPOpbuMSyCQarxP4ubxb+uYP2XqgszNxB1MWB1Lm33bcjR0GVSikyR4h6qCFfdtqRaXsMokdD6Cgi6Q46pJM/vEexa34CM8g6qlH56d9SprClVB32DYF916ohuknLaVIl3FW6FZQAKlJB/0DHKGwLaQObNI2SejTA+4X8AZgiEaqoGeemm67TxLOaDEpndfgtuiwMGH4peCvEn4qpx24YK9YPdv7UIoVCkgKt+OdvFR3KjFcQr0fwNFT09QQ6mm2ZiG4gTxld3PX4Rs+2pqo7Uy/geLZapLCtWQ3uWXnwQCmO5L7Lh5T3+lk5kkTwVqJjE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c0e0f5-e1d4-4f22-1546-08dd19e9ec8f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:44:24.5080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y25GJMU3PTCPCINBHqjUhLb3+n/2PBpWtN5gBMnOmj9a33lpfETTEZumgjJfLEXK9AKgBXbk2D9bFAIPIDc97w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_10,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412110099
X-Proofpoint-GUID: HeYxOSig6G0kVvXlwESdODYDh4MkhrZB
X-Proofpoint-ORIG-GUID: HeYxOSig6G0kVvXlwESdODYDh4MkhrZB

On 12/10/24 10:32 PM, NeilBrown wrote:
> On Wed, 11 Dec 2024, Chuck Lever wrote:
>> On 12/8/24 5:43 PM, NeilBrown wrote:
>>> Add a shrinker which frees unused slots and may ask the clients to use
>>> fewer slots on each session.
> 
>>
>> Bisected to this patch. Sometime during the pynfs NFSv4.1 server tests,
>> this list_del corruption splat is triggered:
> 
> Thanks.
> This fixes it.  Do you want to squash it in, or should I resend?

Resend, thanks!


> Having two places that detach a session from a client seems less than
> ideal.  I wonder if I should fix that.
> 
> Thanks,
> NeilBrown
> 
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 311f67418759..3b76cfe44b45 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2425,8 +2425,12 @@ unhash_client_locked(struct nfs4_client *clp)
>   	}
>   	list_del_init(&clp->cl_lru);
>   	spin_lock(&clp->cl_lock);
> -	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
> +	spin_lock(&nfsd_session_list_lock);
> +	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt) {
>   		list_del_init(&ses->se_hash);
> +		list_del_init(&ses->se_all_sessions);
> +	}
> +	spin_unlock(&nfsd_session_list_lock);
>   	spin_unlock(&clp->cl_lock);
>   }
>   
> 
> Process Finished


-- 
Chuck Lever

