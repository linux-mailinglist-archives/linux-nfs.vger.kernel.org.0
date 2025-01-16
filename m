Return-Path: <linux-nfs+bounces-9307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DE4A13CEE
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 15:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B59FF7A277C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D8722A7E7;
	Thu, 16 Jan 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E++1Hfzv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XmdF1G+c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6419ABD1
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039319; cv=fail; b=elkCf+NO1Y9oHM7Z4XvvKdDRoW+IzUh45MgmNcm+6sKP06A+nbzieJCNTBUOxuGcd1MZrZFFcvQrYI6BYTActTttkwkNn4oNrZkBxEG3DbLdGzK4UVccYMOVdpIAXtN1ePpUU8qmerwDEJ9Ik6OyJtVWMYhRAB+U/nrjeQPv21E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039319; c=relaxed/simple;
	bh=m5H9ziRh/ouNFLsENO4fEiFUoXYQPVDmdlz0wFqFJRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cypjelHkRndQ9oFUGHnTG87J5Vy4TwfuCoKINRb+2Wu6u42x/BR0DGz+s3dcO9+Im/xobbJjuwxCZ7R8lwI1E0PVFVDp8lfx77AW/+MBaN2D7FjrcaGGixaIpCa7Dm7Wj9ZhMaeD5zc9Kg4Uha2pyBqRnIosQk9dRAY8xBSycYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E++1Hfzv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XmdF1G+c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBN97E029017;
	Thu, 16 Jan 2025 14:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ya+ZYTndumyPy2wrx1y7Plge2Ghm33NGtPcb/VVk4HE=; b=
	E++1HfzvAOzhBf3C4oqZ9fxvjQ4QosjRTPorMpurWRkQoPUulWQqBkI+K5fGJS5o
	nZeuGw/8Dzu4HmsgtJCom+q7cFhgEDIwgVj71yBwkQ3UBlOEMJX6zru/wMsFGKW7
	T5Rumndp4zTEoc4Rj5/Q+CB/stynlk0ePqcNOiVyMftewZoLd++CpX12ARC0RGjd
	kt+0Jkoaruga+7h9CTZaT/pzDryfsqLq99gp4PjWlbo0G1OE5+9/TT/j//Z1M3Mg
	joPpRnDVWxtY/UjQY+NBto0xUcGLZbeIzLnZRVCJCDaX7OJdwTiwdDU/i8W0Z5FA
	k2zg0OjcOSncqpZE3q0YFA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fe2jh66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:55:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEfdIp035098;
	Thu, 16 Jan 2025 14:55:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3avv1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:55:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tlmf/xI2qay7gNQ05WfMwghzVhnfzOGvFayR6ogyYBI2RmVa94x+QKKed4E5gF3eMSGk//AiyU9JtEGqUJYkL2HaoNjVHer0Fsg9NGhDHrrUNC4Rg9F849X1QBbxFrbdEJGbM01USKS5xxtQ5qvQNOBrpsMJdmUQNAgGCERDBFQBxjxZt0Gr7hgqN9+kZxVNkefmkDcWttXL5V5RfsNKYgFCmcyRV8Wyaf2VqSAVYHVS3urNYtBkhLlV9+/HCuwm3JeiQL6AFAnF+VMExwssMEblAqU84kjwhD6leWyYWtzwx6Do2pD4sH1oDQV4n0SneJutOfEKxYXLG9ut2OxCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ya+ZYTndumyPy2wrx1y7Plge2Ghm33NGtPcb/VVk4HE=;
 b=VqafXPPqGqHObmE1LGJ2hEMdDllJviHubFDiO/7WkqozwL/RvAh6ro0/e1C/izD57lCeOVpkM1UrA+QkbJYHbFJ92r+DdnLqIEEvWKEqn41IBcm7BWMxxH9e5jhjl+Aab4Dm3wcOVRC3fKEVoINcVx/2ns5SLieXnm/Jt391XTQ+G1Y+U/xTbcTamNwpmD8o8YF/YVCyCOPcJ2UEHEmDTr12CrZTqPub3vpsQOiCG/yNgH9zJZu2Y4ne74bAqVTqAHpGn5+N0RqXf1vtEdJyU88H8R13oNJu5npRZgVuaPbDhNqzJYSzBRyjDEzdBkEQh2xUXjGFVtvwsinAUqwwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ya+ZYTndumyPy2wrx1y7Plge2Ghm33NGtPcb/VVk4HE=;
 b=XmdF1G+cAiVGmc/tP+pXm8kO+dj9AyxZqp6u8yIunGH+jWb7PJuFFjv1AnxWRAc6foMJ7RQpa1ngaW1KXwfo2Bt9SJ0HStfFeilgxmQu8DOjfRx26wsAZzW8fkqm7HycAS43qBnLbSMXtFmNxEA06n9B5DP27tb8uSlbpNrmDsU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7758.namprd10.prod.outlook.com (2603:10b6:a03:56f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 14:55:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 14:55:09 +0000
Message-ID: <1db5da8c-6608-4f0b-967b-a7ba564af6b0@oracle.com>
Date: Thu, 16 Jan 2025 09:55:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nfsd: fix management of listener transports
To: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20250115232406.44815-1-okorniev@redhat.com>
 <20250115232406.44815-4-okorniev@redhat.com>
 <62d3ced2-8c90-4699-b3c4-c58489ec9f19@oracle.com>
 <62694be2aea08c40af7b0cea9d8c1b67a7b2cbe7.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <62694be2aea08c40af7b0cea9d8c1b67a7b2cbe7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: a73c141f-0e2f-4863-ebfe-08dd363dc55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm1RZlVITVFjNlVIM241NUZMVS9RUkNNZVJEd1Y1QXozU3ZwL3Jsc0pTNXZW?=
 =?utf-8?B?am0zbG9NNWR2RXJPOENWd2RYSlF4N0tVTk0zd2I0emp1RVNSZTRNYVVGbHpS?=
 =?utf-8?B?akVFa1dCa1d6ZklGVDJlazBSV2h4SFBSUTZXcmpuTy9yNFFRTGIyb1dFVENF?=
 =?utf-8?B?VTZpZ2RlVHhybW9lMEpQM2RTc2NCUG5ydW1LdXhOOGF3MkpqclJHM3NTS24r?=
 =?utf-8?B?WU9xd1ZweEd4dkJ3TWlWS3F5Z0pBS1ZkZlNDTWtHQTFLN0tPUmlXRHJGTUpk?=
 =?utf-8?B?MTB4VU5rbS9Pcm5hd3RTWjhiTlZuaDQwTmx6bnBXTHdjcWJWUHRtZXNKM2hN?=
 =?utf-8?B?SEZjMVVFSStJOXREZ1hZYzN0d2lXcEk2L0lJZUFHMHFxbjRwVEhHZEE1RDRq?=
 =?utf-8?B?OXFCNGxGSWhOT2lqVmZkemwyMkdhQWFYZ0F6SnczS2ZLM0tkcXBFNlVqRU5D?=
 =?utf-8?B?a3FGb281NXRGblI2dHdWaThxb2RnbzQ2R1BqQksvcFlCQjJVK1JEZW5DT3Fi?=
 =?utf-8?B?NEZEVEpPZXN1TUhsYmxaU3Jzb2pwQzBRU2xzQ2dUS3J5T3dxQnZkbUFKT3Fm?=
 =?utf-8?B?SGY2Y093SFpGaS8zNVNNcDVyanNVOXl0ZGMwZDZwdVpRTjRBSTdRU0JFNEdI?=
 =?utf-8?B?ZUZOWkI0UUtoemRxd3dQSDM5RkdnRDJRNlZrU25pVE1FYVR2aE5LWDFaZ2d0?=
 =?utf-8?B?VlRkOVUrTjByNTBxV2dOaUQ2VlZOdW85bktVSUpVUW9rUkNiTzNTclQrZzIw?=
 =?utf-8?B?ZklRdmx2dGd1QVJ1bm51TnFMeTB0bGN2WnQ5aGdmSUNIdjMvNWxMQkxrT0Fj?=
 =?utf-8?B?aUpLTFJ1WGpjSWkxd1F0UVdjWGc4SHMvR0I5T05NN0ZNMXUrbEF6YzBpcmY0?=
 =?utf-8?B?a1o4NmRlb0R5MTNCQXVQMjJ5S2F5TnM4ZTFtajQxYVdmbHhKc0tUaC9sTStW?=
 =?utf-8?B?RmJYNW92R29heUd3N2tVRkJ4OHRuYmtYNFhlcTJmczA2aDVNMDcrbDFNVHhO?=
 =?utf-8?B?dDZaU2ZaU05NUFVFbGpHUHJtSTRhRHljTmE2TmhtUitqSXdhdU50R21zTy9j?=
 =?utf-8?B?b3RYRVlsTk9XVFM1eldvMDhyOGNpM0hvNXlma092bHpCelJEcjdoOWlkdU4r?=
 =?utf-8?B?UnJST2xkRkhtU0NlWmM0Wm9nTkkwWFpzcVhYNnlUdUR0cG4yQlVDWDh4SnF2?=
 =?utf-8?B?Qi9id010aGNicktBWWdyblozcFRzdFJOUUpHQ2JXREc4eEdFSW83QWEwZU41?=
 =?utf-8?B?aE9tT3hiSmZEV2JtY2VUdnp2VGR2a3E5cEFxZDNQMEZMRVkxUzEzQml5Q1FR?=
 =?utf-8?B?ZnlMYm42elJ0RjdGQ2tSV0pvZmZ6VWRrQzF0cEV1Nm5VSU8zUFZ0MTdJc3ZU?=
 =?utf-8?B?NzdZcXBzK2RvTFV5YzZNUS9nMWJrYXhwSkxuVVJwMTFUcVphNmYwM1o5NUJO?=
 =?utf-8?B?L2huWU8yTzZ2TEhYbGpkYm14TkZsK3F2R0tuZkJWeEZ2N1BQUGh1cGRSMEpn?=
 =?utf-8?B?bzBJYWVkcjBYOVBwbllkZ2RGcU4xLzhBL2xlVFhxRyt1R1hLQTZscEY0TGpi?=
 =?utf-8?B?YWx1MWFWS2hndFExV053VWlLR09XbE9pV0FHTks0UG1RbTk4UjlkMXF2ckNX?=
 =?utf-8?B?MFg0eFJHZG9paThvcjBMRW1ZR01GbUNBTnUrM0UzdHFmeTRPbnNWenR0c3h2?=
 =?utf-8?B?MEg2RmFlUDB6SEJnMWdMVyt2YmpYaWxpY25qWVAzZE03YWFQM0hjaU1zYnFR?=
 =?utf-8?B?U292VjZMN2ZXYXJ3L2tKemZWNUJNWnpndTdjdHB0U1czaFIrT3I2YUt6WnEz?=
 =?utf-8?B?bmZ2eGlyL09yZVF5NVRZTncycmlXblhoZUdBWUdoWElNYWpMRFM5d05TNDJO?=
 =?utf-8?Q?n+ZMHl2SK8IBQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk44bk80YTJYUEJrbjBLaitITld3RHErUGhDclg3RWl4OVF0alJLaVdMaHdO?=
 =?utf-8?B?VzhvbkFXdUJjY0FHZVJJSERGMjVsOVh0b3lSb2hyNE1VWmZ5ZTNUKzkvbDJS?=
 =?utf-8?B?QktjcnhwMk1qMmk3KzV0UlRnOWtJcEtXWTB3ejZpb0plL1pOS05jdG02eUxD?=
 =?utf-8?B?UitFcFlMc25RaFg4ZjFEQUxsb3I1QXdSSTdIb053aDFGOUx4b0xFZjc1UjZB?=
 =?utf-8?B?eVVOWm1NTzJyN2xsRzJsRnhMVGZubjg2WWhpTEdsSEdjYWtETExSTGcwTVY3?=
 =?utf-8?B?RUVSa1FmSGJNUFJVV05YVXA0YUxVNC9tdW1PUUJtNDhFRnBWQ1FLbEJYcDRF?=
 =?utf-8?B?QS9RQnpQTlJkZTh0anlDYzBGUHB0ejhEdmJnQzZCa2ViUnZuNmdObjkrenFt?=
 =?utf-8?B?aG1mWmh4QUR5aHpxdUlWUjA5MWNIZnFSNzMrSE1MVEdLVUpoaG1zR3pyNUNW?=
 =?utf-8?B?b0FVcXZHbmFmK0ZnSVhDU0tTVUJ0bDVsTEdhOEFialVhVDFQcjlEZ1orYkV5?=
 =?utf-8?B?RHYwQmhsYnM0Mk43QmZ1Z0hoRTR4V1hvTmZUQkVyU1BFYWlwczFvbjN0Vk5O?=
 =?utf-8?B?NVNYNFVEWTB1Z3VPZUV2NHhmU0xRelp4VFVHMWxFaUFZM3ZVZGxuUmlESGh3?=
 =?utf-8?B?R3hHRE1pTm9uZWVMb2cvdlNsTVJwWFBHQUVFakpndWZ6RFlqanFiYmpiU01o?=
 =?utf-8?B?RUVUVlMyL3lGRW9uZU5IS3ZzZERUYWhsbzlTZUpBdVd6dUZ0TTE5SUxkbTBu?=
 =?utf-8?B?VnFUcUdJbE1wcUxBYWRBcEx4VkJQYVBWNWt2VEd2TkduU3lnd3lqQm01WCtl?=
 =?utf-8?B?bWRkMlI3eEljTDMwc3JQUTMvVk1vaEM0bG1ZaXRyKzk0TEkvQk0vWU5za1VM?=
 =?utf-8?B?a1FiUGxXdUphSEcrUW9qSjNnMHJ6eWRpY1k1S1crTW5YUFpLa3F5aTBIRHFI?=
 =?utf-8?B?clZiTTNRZ1QwM1ZSY2d0RktYMjZlUndHZmJvQXFNZThFTUVkSGYxZDF3NWd5?=
 =?utf-8?B?MGJLZmo2Q1dqNUQrYlNzV293a3d2UzZjWCtvRlZPc1NUQUxwWHRQcEV2WHhs?=
 =?utf-8?B?SzE0dnBVeUlUWnZBS3lTNVJxcE5KQjY5TjYxdDVxNjBqbFJVckNUZGZvM3Zs?=
 =?utf-8?B?SmpGVjlPWmhLVWg2N0kvSjdMSjBkS3B6aGFmTGJ0a0l3Y1hYdGZreXZmN0tq?=
 =?utf-8?B?NXQrVWZ5Ulp4clhlS09qOHpUOXZUcFZkMzlVN0xGT0U3SExMcElDOVdkR1M2?=
 =?utf-8?B?Q0hZa0MvQWpldUIxUEJhTmx2L3lmcGJJYTYyWEx0bUhyMkdlNXV2Y3hNR0lY?=
 =?utf-8?B?WXY2aUZMUHZNaWRwQ04vcE01MTBZSXFPTTNBUzFPWlhIclFjcFRaNHRHd2h4?=
 =?utf-8?B?T0kzLzUrQUxVbFoxSkZMbFUxRFRDSkJYOG5RYXBudmt1b0pweTdQWEZVb3Y5?=
 =?utf-8?B?L1VoTVQ3bHNHMnZwYlMzWVpBa0YrZ0Z1cmR3Wi9FNmY0VjZBbE5xZi85VnNx?=
 =?utf-8?B?ZUJ5WGNWS1lRQ2lIQlNWMUl2eC9vOGZrdUhPdDQzMjJiTE1VNWNrUWFlTGp5?=
 =?utf-8?B?M0d1ZVYrRTRoM0tDZXBHK1pJejBZTXJ3OXRjdTFlSi9mZWI2akRNVnVDUEp5?=
 =?utf-8?B?YTJ5QWtHV0J3OFRrbmlpRGxVanQvUTNQYmlQNy9lL3oyLy8wcTAyMlM3OTJn?=
 =?utf-8?B?NjZCYlJOaEJaNUk1MjVkSldyY2dMRTZ6Sng0R21UV0Z2djlzUm9NRytRR1hM?=
 =?utf-8?B?Z29aZUluVlBjZ1M2Vy9ocU9IaGhUcCtYUUUvcHUxeFJ0WkdXR2Q3M1BRS010?=
 =?utf-8?B?dGFmNW9ZcFdZZ1o1ZW5PSm5qWG8zVzF3OFFPd0xEWDJ1N1RCU2NwdGZEcDBW?=
 =?utf-8?B?VEFHVXhUU29SQ0J6RGk2WHdiM1RXN25TVzRHVkM2dnVFREo0R2xHUWRqbW5K?=
 =?utf-8?B?SHJwQ0p4cjVLRUl6WnE2Mm9MRHNjYmFXcEdwZjg4c1VCWGtVWkpNRktJZ09h?=
 =?utf-8?B?QVRmSE1JcDBTWUdLbDJNZjNaSzdjYVBtMUpXYnEzaDNOSXF5ZFZEanYwcm1B?=
 =?utf-8?B?U3NyWTUwZ09UcytqNmM1N3FCVkxENVYzdUxzRFlCc3BJbWNqYnQ0aHU5ZVJO?=
 =?utf-8?B?L0R0clYyVWpaaGJSSVlmWjhIYmVYY2J5d2QreG8xSytXT3pML0NieTA3UW5z?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vg2P6pbKJthbwetQ33P4gWFlZuF2XbEY3//rgSzL7DJwgiqLvQ/+k1C8MVqW6ItKgE9AE12DjGEmT0+FMNWuAvGQLOBJmZwg2xepoxFSQcJjZqpKowQ1l4325f6XClTsed/eX87ko7yjswRX2z1mWhf5KCTRPmMIJjrZNyk5yVXwHgjdwQuVYjK6g/w7ci7M81/14dfKeHu5nEjRNygTmPexAmRi+nrd1QWkAty2lVwtbfQWkEUckZ9z0vbqWVpwqQfzkK6BodIvBSVKd4ZFkk+PU5uEZJw1FJbWf96jpy6TSZHhXsQuQvmyP8KB6iKLYmgAnBXUdJFxn43/f1QoDfRYJQ9ChwlJ0YukyWirUvP5qqV8ccCA9Mvs29TjL3lrMX/sDQXxae1fsZfSua8Im5Cqegf3sR9yj2V2rcuituBPyuVvDcASCSxgxJ2I5d9gZ2mTv9Bp2CDN13LGaYb5bu1c7TCZtmJPH1jTYzlrFx8KfZmgU67EWaFRXi05u39Xj2IIlSlWesbiJ/8drN/luZqn7swRGQupjurQYbKW2hcIMkkZp8xgPdtvGOM+783ICH+82JEUeUmKMLce8aRw9pqI+qOmGt7bQ/5BHKb5WJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73c141f-0e2f-4863-ebfe-08dd363dc55e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 14:55:08.9974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A03DC2u8LUHvHUYMWKXQcU+5yAzh4i1dS6IKPqtmOM1zaISgQgBvM+a5cIWow4H60Xr95XTg6fYgrbf+p/f07A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160113
X-Proofpoint-ORIG-GUID: fiai9AtGAhUvRtKm_iRqTFhpzb0plrvM
X-Proofpoint-GUID: fiai9AtGAhUvRtKm_iRqTFhpzb0plrvM

On 1/16/25 9:46 AM, Jeff Layton wrote:
> On Thu, 2025-01-16 at 09:27 -0500, Chuck Lever wrote:
>> On 1/15/25 6:24 PM, Olga Kornievskaia wrote:
>>> When a particular listener is being removed we need to make sure
>>> that we delete the entry from the list of permanent sockets
>>> (sv_permsocks) as well as remove it from the listener transports
>>> (sp_xprts). When adding back the leftover transports not being
>>> removed we need to clear XPT_BUSY flag so that it can be used.
>>>
>>> Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>> ---
>>>    fs/nfsd/nfsctl.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index 95ea4393305b..3deedd511e83 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -1988,7 +1988,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>    	/* Close the remaining sockets on the permsocks list */
>>>    	while (!list_empty(&permsocks)) {
>>>    		xprt = list_first_entry(&permsocks, struct svc_xprt, xpt_list);
>>> -		list_move(&xprt->xpt_list, &serv->sv_permsocks);
>>> +		list_del_init(&xprt->xpt_list);
>>>    
>>>    		/*
>>>    		 * Newly-created sockets are born with the BUSY bit set. Clear
>>> @@ -2000,6 +2000,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>    
>>>    		set_bit(XPT_CLOSE, &xprt->xpt_flags);
>>>    		spin_unlock_bh(&serv->sv_lock);
>>> +		svc_xprt_dequeue_entry(xprt);
>>
>> The kdoc comment in front of llist_del_entry() says:
>>
>> + * The caller must ensure that nothing can race in and change the
>> + * list while this is running.
>>
>> In this caller, I don't see how such a race is prevented.
>>
> 
> This caller holds the nfsd_mutex, and prior to this, it does:
> 
>          /* For now, no removing old sockets while server is running */
>          if (serv->sv_nrthreads && !list_empty(&permsocks)) {
>                  list_splice_init(&permsocks, &serv->sv_permsocks);
>                  spin_unlock_bh(&serv->sv_lock);
>                  err = -EBUSY;
>                  goto out_unlock_mtx;
>          }
> 
> No nfsd threads are running and none can be started, so nothing is
> processing the queue at this time. Some comments explaining that would
> be a welcome addition here.

So this would also block incoming accepts on another (active) socket?

Yeah, that's not obvious.


>>>    		svc_xprt_close(xprt);
>>>    		spin_lock_bh(&serv->sv_lock);
>>>    	}
>>> @@ -2031,6 +2032,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>    
>>>    		xprt = svc_find_listener(serv, xcl_name, net, sa);
>>>    		if (xprt) {
>>> +			clear_bit(XPT_BUSY, &xprt->xpt_flags);
>>>    			svc_xprt_put(xprt);
>>>    			continue;
>>>    		}
>>
>>
> 


-- 
Chuck Lever

