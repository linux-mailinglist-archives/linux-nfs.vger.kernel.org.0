Return-Path: <linux-nfs+bounces-9776-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B198A22701
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 00:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC1C188637D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 23:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC721A2398;
	Wed, 29 Jan 2025 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dBTaPGxF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TFZyBtjb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC3318FDC9
	for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2025 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738194458; cv=fail; b=E/OatS4l20nCRgj88OT8AdtXzI2kKlsDSLfa84bPB6SXsAHAdEyraW40c6NATWFun2UmFa8EO3O7duBCz/u4YIJbr60AHILxPc6Vp4RN5HFSN/m/eSOaCGkglEo1tkrKJHu9d1H3dDI30mhbrKLeETlSY2r3JRwTqMDqgm6E5jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738194458; c=relaxed/simple;
	bh=cTEZXeHoS2t0+Hr+1lMv3XZfzgGaOI18+GUjB6HvWm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DGFkUYeTgHwefIZ28rMCASgcjCqDhBkbkSZy4wh9GsuJOTeUgoAMuEz7TTif5AYNlHlp5XCb9Cg36f9xuVNpE3HSL2LHhLBYYUNCJuj4fmy9rWoQgjuZngAa3AuntFVm/iMrKI5NgcpnOWYNvamtmHVOQzOaUhI6FORJB330lFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dBTaPGxF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TFZyBtjb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TN8Zi7021461;
	Wed, 29 Jan 2025 23:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=n4l2AEQ1iiF/pHwvw0s0FLN7Su5fKa/4O1FlbmiBthM=; b=
	dBTaPGxF6nU2y0pY0cIxs4zIEURrRqP6lsr0VhWKVMWcR9gKior4mjEfAXsp/RrY
	YdG5IbYeybRgexesrCvvKczhNNR8Ln6xW8Jq3n5Eh6Xe4uVc2aSubybWHWUBifbN
	dOPDme2auapvLmFM01RxfqLXjv0lN6j8BBucg8swGBoI2uev7bfUsCKIkKHim4hS
	kWasVStrDy9a03EcQbHyJuhoCmtMy/HypQhBVb0gfORGYXvPIH/7pkaXDQV6rSXS
	8M13E6OVQ2JOeEDZgVlIgzFnDB01Ee78iL8EH9xkEMjPsu73MDV1pbgGD0NaYBna
	ei+nzFyNQQ+/kAPwxL1VyQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fvd9g5v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 23:47:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TLiQjx011690;
	Wed, 29 Jan 2025 23:47:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpda5b7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 23:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwXU+JPQ06SuIbBiUjJdTP+rY9cEZES6usfaoWgzWivL76AgEiK+SucjyC6EYVvpEQqS9JNlF5uFCaJLz2jpbwtVXPGWcngcbl/gMhSAtHER91i2mP7xsdlyzp6MTrj7s7aNoscxUyBb6yitsn/YgM3QBJnyx+hvBjmZx2XjwUNpDY6dwD+Q1xTcfuCOZBU7oRvnmbqelqY4x3i7oCsKpxXPZRZDd21XjEV4wdWSyFJZvx9c+Sgpw1H+ROhSjDmlWV3SmyCDVx4Boy/bdrOlhtiXVt6ZWI0xXC3x7JASn4niY6g7JSLGCtoQ+jqMhs7sD62Hsd9vza9ppqK1+tCp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4l2AEQ1iiF/pHwvw0s0FLN7Su5fKa/4O1FlbmiBthM=;
 b=iAYvG18QP5qOWPQLF28yeJqDs2dbFYsljOl10oDe6h6QDmYTlvs7ooGbip16t40/5b1Fh5VGNlHWqOKPcxA1dlonu3tLYT64u6IwkSSC8kIeOYzIWDtmc/Nm21UOI9H2fHv4rHmQbX1Ip9tM2X3VYaXMfSGTDGKdN/DyqvvoCuLG5t7zlVK3xEGW1hyq0U4nrQ1bTX5hWzZ0g9oOHITjYsxKWig7Vm8HUVBIz2LRaNWnjjrbrqojx1D7d3eWgZz88p2SbmMhy72Xx25Z3mqFlosx1w8Q3UF+sUmA7zDMPivV73CEU69LPsFA2cfe3HZzkt/9vt4T8D58Tpfirwbe2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4l2AEQ1iiF/pHwvw0s0FLN7Su5fKa/4O1FlbmiBthM=;
 b=TFZyBtjbklTCf0yuGgQdNnwoUYwrmOi+0rDkv79A8ROnz7DQlOS+RFSCGJRvbB3P1C8NOSKtONvqDSG8EwNF7qWaaBq435NEzMZZtNQONREk5pDsRiWj72Okg6pKDVIDucP5yC6XCTc8ckUAVEY/h88WPO4VpJwDTtvqKz/ZF3U=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CO1PR10MB4625.namprd10.prod.outlook.com (2603:10b6:303:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 23:47:30 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 23:47:30 +0000
Message-ID: <abccf911-d5d4-40f3-941d-86fb7566a299@oracle.com>
Date: Wed, 29 Jan 2025 15:47:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: fix hang in nfsd4_shutdown_callback
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
References: <1738185446-7488-1-git-send-email-dai.ngo@oracle.com>
 <69cab2b4-ca79-44ab-b622-0f2076eaf524@oracle.com>
 <51d07eb6ddefb73902004877b442750dd05e153a.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <51d07eb6ddefb73902004877b442750dd05e153a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF00013E0C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:e) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CO1PR10MB4625:EE_
X-MS-Office365-Filtering-Correlation-Id: 94047ec1-324d-4723-f3d9-08dd40bf4b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXN1WDNxODU1T1BKMkY2ZlFFNzhZZVNsa3RaY0FPQzZYSzRQZHMzSXBjWjh4?=
 =?utf-8?B?NVF0OG9tVGVCTENTbzJ3R1FDZHRKcHJ5ck5TSUhIZEFubEZVU1pQekJYMUVG?=
 =?utf-8?B?OHJRZlBoeHA2cHl3aGJ6b0hKZmlTZ201OURodGpJcC9NZ253SVdmRGdNY1d5?=
 =?utf-8?B?R2w4SHRRei8yZVpvb0xCMklyN2xqcWNUc2N2OE5XRlJWUGlnRWk2RWNQMmxR?=
 =?utf-8?B?UysxUDJOTG5tWXZwa3d5QksrM0kxY3FyNXhGa2gxWUdjZ1h4OWNwUXZYL2g4?=
 =?utf-8?B?V3pleElzQ01mdzNlVlJNa0pWODdXNWR5Y1ZNQXVVWS9EUC9NbU11bjNRWUM0?=
 =?utf-8?B?SXVXWWRiS09EUUlTZ2ZpTjJmaFVGUi9mVm1KUW5IT2VqQzBSVlBIWE1jMDlq?=
 =?utf-8?B?TzdtM0VXREp0MGNIK1ZScGlzVVpjaWo3OFQxd1FZSmM4ckxicE0zSWxDY1ZH?=
 =?utf-8?B?MFN1d2prMmVqUTR3UDRkV05VZGZ2cWdvakVxUmhiZENWeEtMTTBmQ1NIWVhW?=
 =?utf-8?B?aEU2NGl2cHBwd0wycHhpNzVPOG1qcEFzbkNGRFR5TjlGT0p5WEZLN2o0U0dO?=
 =?utf-8?B?MTl0U2N6MFVqQnRRbTBiS2prbEVFQ2lJNndtWTZwMmpGeWxtMEltdUk0NnUv?=
 =?utf-8?B?SmtoRkwrcDFSSHZUSlV2NGpaUHN0UzVsWXh1NUdKSHhmdTZlMEhCUnU1OUdU?=
 =?utf-8?B?TTdMSmlnZTlwK1IvdjZuQ0FIcVdlaXpadHJUSzVRT001RVJqWTVkTDhKbVRv?=
 =?utf-8?B?azFaTHRRMjBsbGJZTzdRcmd5T2NQdXF2Z0dOU1g2SXkraXhtWllRQkJZckxx?=
 =?utf-8?B?dnQ5cG9nVjJHRy9ldkVtMTZxdzc0WnNEOXlJR2Y4aGxDM1ByQzUyeG5IOHE2?=
 =?utf-8?B?c0FGTHlRanJ1eWh1QkZ3TUZpektVa3N0WVN3OThqYXg4czNlVWVkOTluNkI0?=
 =?utf-8?B?elBFMGpNWkdneXNGbElibDBJeU1FTEdHYVlNYnpQNTM0WURoR1FNL3ROQ29O?=
 =?utf-8?B?cjgxVlcyUVQ0MGFaZFo3K1B5L2xFZGpOZHZuRDhIVnZsTkNBUU82OHl4a0N2?=
 =?utf-8?B?cHB5T05pUHZacGFaWVV3dHNobTNJZ2xIKzVwdTJXMGZCSklPNU9QZHlLMTRr?=
 =?utf-8?B?M0JNc3JFWTBIS2dDbm9TdGJGNlJmMUpZVGNTbnA0MUZEUkNBMmlTWUZrY25U?=
 =?utf-8?B?R09BMTdETlVvR211RGsvM2RnRTFBYVd6akZjRTBlK1dhdGZRT3dhaUJQZ0VZ?=
 =?utf-8?B?UTJtRFVXNUtzZzIzdStQRUkxcW5ZN0ZVeU5yMjdpb1VhL1AxNVo3L1QyNHJT?=
 =?utf-8?B?bWR0ZXJ0VTNlMGZ4TExEbnh0RlFNL245RUw5Y2xlUDFGbUM3MDFYd1ROMGhw?=
 =?utf-8?B?SGdwYXdvZWNjL3FCenRSWjZwR0s1WlB0NEZYNldmRDhTWmVVdG94dlplNXdw?=
 =?utf-8?B?VmRCRjBEQXdwRHZmZWpDZVNWbm5zS3hZZXluZ3ZkOEFTOGYxdk9jMms3MzJv?=
 =?utf-8?B?aHRrUHRzcHcwNElZU0g5QS8xQlIzbTRzd3VtSUhzeEVySjQ3aUtzVjllcVJJ?=
 =?utf-8?B?MlhTQ0lnalpvMElDZUUweWRmRWMyb3NONlArWmpGMHhqb2xaamxsbGpZUkJr?=
 =?utf-8?B?QW1GOXdVNW1venJzcGtoTWowbGhPR1RGMTFhRGoxbmNtVGZrZHhqbUVzU0Fl?=
 =?utf-8?B?bStON3draURCZjYyRFBKaXh5TmY0VVpoRkdzc1NHVHo5Wk9EUkh3VXNTMDRa?=
 =?utf-8?B?cDIrd3FoK2kzam5pcmlJRVlUdlo2cGsvcnloQ2hraHNua084dlBGSkRXQlJY?=
 =?utf-8?B?YlJxVGFzMklWdzIrTXJubW5LVGJMRXhsY2pOOEtXUUNZejZ3VE44RnVXZGxU?=
 =?utf-8?Q?n3iYV6O0KXwLd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enVIOW03MmlFcm5TNmV1enZpVHZlT0JhajB0bFN5ZXF2RXVKeFAyV3BHRmNn?=
 =?utf-8?B?bU1NNFJxVXZwR0svYUxuSVVvMVJHeFRoMjVVQVpWNml4Z0lUR0RyaFEyNDNX?=
 =?utf-8?B?QmpSU1dyaWh1aE8xa1BEKzhlVFNLYUJoczNqNFhPR2VYWVN4Tjl0ODdzYTBj?=
 =?utf-8?B?QkxKaTVvK1d4Y2hLY1FYRTg0aTdZVHRnd2xYUkZJV1B5YXA2WUJzZzlZWEtV?=
 =?utf-8?B?MFJ1YXFBR09KNWRod29NYzJKRzVScU1zdFkyK2sxU2kvajhhOGIrNmRxYkFt?=
 =?utf-8?B?dWpFTkVJQmRrK00ybExLdnF4T21XV0lYamNMYXFoYkZ3MjVieCtoTFhSL0gv?=
 =?utf-8?B?bG0zWUI2WGZUVFhIMjM3dFViZWN0QXk3SUVDVERUMHIyZG1tdnp3WW5nd2Ru?=
 =?utf-8?B?SG0zN0pGeS9xbWFiU25pSDhMRmcza0VYWnhoQi9KQnZEYVdCSkVNU1ljK2RW?=
 =?utf-8?B?R2FXTThpWWNySGoxMlArbWd3TDJYcTBGbHMzM2ZPRWdkRFkrbXJyT0JWM0Vm?=
 =?utf-8?B?Q3ljbWlHSHEzYTNicUlMRzlYT00wOWF4T3lSYk5Mc1BuTVluNVFqVHZJWDg3?=
 =?utf-8?B?QVBVYmh0cFZOZHZXTFByUVZvQnVqNUZRNXFDZTFwdHJzc3h4Q0EyYVJJUmJk?=
 =?utf-8?B?dUQ4d09Ra2kvNmJNVSs2Rm12Q085TWNuY2JtZ2c2V2FMYmpXdHREOXZqd3pW?=
 =?utf-8?B?Vmhod1dHcVYrajJWek1IOFlOVTcySkp3QUJTNGRtdTBndkY2TG11SkhnTnFI?=
 =?utf-8?B?ZXRhYWVmcVUrcUx1SDZTelB3dzNyV0J4aWs4K2d3RW1zUTcvekNVbk5XdUN0?=
 =?utf-8?B?Zzg5d3Raam5sNXV4Q0hiVGRNWitwSGhBTXBUQ1pielZ4eVJJMjdQOTZNa2ds?=
 =?utf-8?B?M0RQSHBjVVlvU1ZFdHZtczVIcHRDUERUVzJwU2RBNUdoeGpZMUJNQ2NRVnkz?=
 =?utf-8?B?bmVEd1lORTIzRmdLS3dHOEc2bmNMNzROVWsxS1V1VzczZHdJY2I2SWhvTEhK?=
 =?utf-8?B?aXd3ODNwT3ErUFBCTmpGb2xQM3Q5Q0MxbWZtdUwwWEVFMnBkVCtxYVc1N1R6?=
 =?utf-8?B?bEk3WDBtWGx5Um9GRTVxQU5ZdmlQU3RpWVZmVVhJdEFQLzB3ZnV1cW9xWE5y?=
 =?utf-8?B?SjBKbHJkcGVEdWl1bXdHTUZkOXhLRlZCNnF2bHNXY1crY05PQlVnemZXTnlu?=
 =?utf-8?B?VTZuY1gxN1VOYytjejZOaXpmMnZiUXJzSHdGZXdtODNKUE1hODFxL0FVWlpn?=
 =?utf-8?B?aTVpRDVUVi8xOExQTnJjT080dkRTVS9ic2x1bG1LU1FTeWtuakhpNUhYNFF0?=
 =?utf-8?B?VVJxbVQ0OGRKL2dKOTZob1U3V1JOemZZNFowRG1sOGs4QmlQZjk0SjlOQ0J6?=
 =?utf-8?B?TkxmQytxekZqUWZGRmRqeG1zZDRGeHJvbU1QQ0I4YXhNV3VqSlFzOENRMDVt?=
 =?utf-8?B?dVoxSVJrcUhmcjdsT283NW00aTNybHIyTFA3dWVhb01ISGEvbVhZT1RTRGpP?=
 =?utf-8?B?VnI2SkVmTFRDWkdJTXVtU1JCZEh1RSt5Uk1yckdlVFBaRU1lMk5JOTlPbEVH?=
 =?utf-8?B?alpOYko0NHNISEV4NWNiMGlSdlk4bEgreU8wK25NZzZzMUZ2UVdlT2hkYStl?=
 =?utf-8?B?eTI0cFU3OUJRMWtnNHhpSFNhNWdJYnQzSG1zbHpkK1lYaDVPZ0R5MjZhSjQ1?=
 =?utf-8?B?QUh2bU5PbSs1VFd1TU9QSFo4dVlxcVNXeVkwQkV1T0pTMHRDMTBuUnlLQlVq?=
 =?utf-8?B?eVZXZnB2cEtDQ1Y1TTRFdzloNW5aWUFHVk1aU0ZLcndlU1dqeCthUElhOXZB?=
 =?utf-8?B?RnE1ZXZqbGZzSmtWNVhCS2h0MzRQd04rT0RLUmhUVVJwNU4xSVhSZ2R0WGtk?=
 =?utf-8?B?eUhiZ3czVGMvQWtJdjdLaGZaOFR2UCtQUjhvQ3FyZGJuQXFublBabTYvNkVm?=
 =?utf-8?B?QWRiY1J6aVR4cG0zRldvTzk4Z280MkE1UU1ldmEyeUNXeTEzUHhCTHEvaE1X?=
 =?utf-8?B?dTJDOHhpV2FmOGZrNWo1eWpVMnpHdzQwbTFWS1hKMEQzdTdvV0RrSEN6ZnJS?=
 =?utf-8?B?Q0JNVGtzcC9xWEV5aUlJc2Q3QW1kTXNSUkdvQ2NXdktEbURvL3RpRjFKOEJa?=
 =?utf-8?B?S2h0TzR5TUYzdERoQ1NsK0V6ZmhOK1BaZVBlVWpQTmpxRTBZMVVCL0EzdFR3?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7KkK7mCZp8dwbMYDYJ44ijVKJHgFVXZjcMrwKNQrIVwkth3AkvcNAvRNQuC9fKoIhhmdjXK0Q9713KX927WWVzVJ8+BulFkcMTz8Lcbi4V3lSmCBm58bgI35tAVRdboKKGRWzOEyp7pK7vxIQVm4Vnz08hfT5Ax0QeNbkDDLf6JtdrQNGevTsSk8huPRQq41psPanJr/Sy5e1rjm34CUZ2iV0hoX0CNrl7RYuex5b200Dj4w735yeSFCKHwshrfNA1k4GYtyN8Jm9Hr8tpn3XZv/61YTsyhXX/5K4uY90j8ukS/mqfZ2BqumILzlz1hQwmYiGcTbJd3UvQm/rczqKKpbpNYhDf6O+Bw6pGe8Wc/nz6t1MEhEKKpz2hDiVnyWHlAngvfDxqFM5aLCfBKEpFAZXzT7nCnIn6aFEsMRZOy1BBRGHMTfTYoF1uAXBBAwb13tuxdtaondbBeCYOgE/e4RZqlFWiTJ9nhb3rrBVVmlCUBjp5RhUOfBn9423CLZ4OZuZmrY152CqdgxtDV85MeAfrtv95CXJDwqdwGPNZ56jqkjhbiW9LCQ2lzMlpjjjPVTQH8Dx7yt7c3b1WaPM50ziP3EvezPFLzQeOYv9rU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94047ec1-324d-4723-f3d9-08dd40bf4b17
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 23:47:30.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PXKsaIzJfBCMBkrLDHf/a3abGXPTXi3lQVr+gBJRg5lJVB6ge6qHwhulfl7LaIzjWs1Gb2XqZPDdZPvfPDB7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_05,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290180
X-Proofpoint-GUID: VDivrpIPqNiuKaRIo_KzUh45TWRqaIMw
X-Proofpoint-ORIG-GUID: VDivrpIPqNiuKaRIo_KzUh45TWRqaIMw


On 1/29/25 2:38 PM, Jeff Layton wrote:
> On Wed, 2025-01-29 at 16:39 -0500, Chuck Lever wrote:
>> On 1/29/25 4:17 PM, Dai Ngo wrote:
>>> If nfs4_client is in COURTESY state then there is no point to retry
>>> the callback. This causes nfsd4_shutdown_callback to hang since
>>> cl_cb_inflight is not 0. This hang lasts about 15 minutes until TCP
>>> notifies NFSD that the connection was closed.
>>>
>>> This patch modifies nfsd4_cb_sequence_done to skip the restart the
>>> RPC if nfs4_client is in  COURTESY state.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>   fs/nfsd/nfs4callback.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>> index 50e468bdb8d4..c90f94898cc5 100644
>>> --- a/fs/nfsd/nfs4callback.c
>>> +++ b/fs/nfsd/nfs4callback.c
>>> @@ -1372,6 +1372,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>   		ret = false;
>>>   		break;
>>>   	case 1:
>>> +		if (clp->cl_state == NFSD4_COURTESY) {
>>> +			nfsd4_mark_cb_fault(cb->cb_clp);
>>> +			ret = false;
>>> +			break;
>>> +		}
>> We could do toss this operation here or at the top of
>> nfsd4_run_cb_work().
>>
> Like Olga, I'm wondering if this is the culprit on the recently
> reported rpc_shutdown_client hangs.
>
> I'm assuming that with a courtesy client that we don't want to do any
> callbacks? If that's the case, then I think doing it early in
> nfsd4_run_cb_work() would be better. That would prevent new cb's from
> being queued until the cl_state changes too.

I'll move this check into nfsd4_run_cb_work.

Thanks Chuck and Jeff.
-Dai

>
>
>>>   		/*
>>>   		 * cb_seq_status remains 1 if an RPC Reply was never
>>>   		 * received. NFSD can't know if the client processed
>>
> Nice catch though!

