Return-Path: <linux-nfs+bounces-8393-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CA99E768D
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 17:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122F02843C2
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D128E20626A;
	Fri,  6 Dec 2024 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SWfi8kRI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dTgPbDnm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C781F3D31
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504336; cv=fail; b=QmZNhhnWhIqMX3lKoJmiRTq9o88eYjqU5wroXQnHYmwErG9SRuAernV75TdMW8JadVFY2NEv4DWuUEdQgQf4B4R6Pjx8gFtTlN8yEkcjFn288w8SHmH9HTIrCgCAhpQw7Sqof35S5crGdS4zBnGlgpqy4sHy/YwLZ6pyMq4UVcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504336; c=relaxed/simple;
	bh=Vi7BF5qE71WGGdb8pV4x6Un/g1P/cbGUbikkF/5n08w=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mjENbyRhtmjREee4d21rcaOba+dvrBhhetRu/IpAOtafaCOdFZtSU0bAqIkioHdnk0jnPrjuCEQ+Jor1Em4BIDAQJdNY2OvpsKAtfV/mrI4LU7TepFhW2vM9aQn+O+tmm2u8XPiOuZqd3s+RMbYrcbySk1tcdL+DnwAG0DMP3Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SWfi8kRI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dTgPbDnm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6GJwrt025392;
	Fri, 6 Dec 2024 16:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uIM6m5fq4nmE6nAiDNkh2dEFmXX4iePzUjbkOeFiznM=; b=
	SWfi8kRISM3/ravBIGNX2O7gK6wgwHZUwtXI7IzdtdB6UvoGjxGImK3+h0uKAEVw
	Ln7wofFtoz/2N240Y4DJgxaN08tTUSEIPUqOzd5mGM0pQzDisxGEAU8pfW4dq+jQ
	oDuAGzXZVz8uUn5fu3Jz8lA61jdLLwweNo2SOdjexcIFWUvXkvPserNtxtC14Yba
	0xEIKYXkyw/HcyozDSIc8t5kV/8kegqt3GbmCTW0qKNDhPy+3R8jaIZvBbxrVB+X
	tCkwX60s0xCOMZYqtTwNm4XIy/9c+3oJWbl5SFdQM5s+ap+FM8jNumm+Wr0O7UMP
	+cWKhbHKiPbXJrqjCw4wbQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4cdr8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 16:58:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6GJTbe037042;
	Fri, 6 Dec 2024 16:58:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5d2cqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 16:58:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngcyElpT0C9anwPA4ltnBC8wYloMmN8bjCC/Iy5pRTzvTj3jIAKmswJGVyvB1f6/Or4AZzaobE1UluStm1z8Fi4GosMcqwk2sr59RXuX5vUeaFhZphbiWXBoEyoc4GvBpqmfqCSuye8YyDLPxBtTsLvEGJf9/SN94XztCYUuOOfGgysBIvFOlZR+z8CmB4Bi3S7DiyMKEOxTnf77JoMLfOWxwPeUMnJzV+2DXrZeLnZq4zy5+EEcMpQvmUgjr1NIur1C0MwzoqKM86ZmY38uq3bY1n3NWp9Kwt9uVg/k5xN9OO0dnkd6wqtjjOvjKSlCfoJzDfFwY8PeLwqzPVyZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIM6m5fq4nmE6nAiDNkh2dEFmXX4iePzUjbkOeFiznM=;
 b=Tcyjj8JwLxinXz9YUYkQ58WGgeuoXJ1HuQLEBe4IA4vsExRlWRnmJa2HIjyF7Gy+pbtKYnDY/bDI6ZHiCn05DIR211Q3QjqG40V1v6dEtm9fzX/zCGYECJ+9An1YRGUPgphBfslgM/buCAkhVZ2Z490IZ2YQWQRTAP9/bYRtnHh3Bq6yBsuBLUVs2tNGAvHtAEXUH/CV4e2gaFqV3XEDlhOvmrkKy4cmI07pbOFEoH0EGdJyDkWbnRXOaw6dXdU3RPcbvocV9I797L9Z4YyG4YtJrxBKcNW2fZnBAk5WSV5RpRxOjq0NSLj0veNZMwdvHRAXus5YYftjPWYalO/O9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIM6m5fq4nmE6nAiDNkh2dEFmXX4iePzUjbkOeFiznM=;
 b=dTgPbDnmEK71rjVryIcJbPLXT5JT7cL/p7/W9LWrhm3wF9zRpw2gc5y/ghlq+WXqLl2VvuVnHE2BRtTGFuKRCV/EFnXj+FeH2vbYZ3+ORLShnin4XJBEWp9gKgtYPXodtm+DstRRtbaKRNBcPH42J2hMfS/O8DhkewdN+4E3FfQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7265.namprd10.prod.outlook.com (2603:10b6:930:79::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 16:58:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 16:58:50 +0000
Message-ID: <15b348d5-abfa-49cf-b605-3819feecc340@oracle.com>
Date: Fri, 6 Dec 2024 11:58:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfs-utils library dependency littering - fork nfs-utils for
 Debian? Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Mark Liam Brown <brownmarkliam@gmail.com>
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
 <CAN0SSYyzWqp2CMziwQ9dGQ8X4+cL42P78oLZDZDrxbPTK_racQ@mail.gmail.com>
Content-Language: en-US
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN0SSYyzWqp2CMziwQ9dGQ8X4+cL42P78oLZDZDrxbPTK_racQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR19CA0029.namprd19.prod.outlook.com
 (2603:10b6:610:4d::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f205f2-af92-4883-acb6-08dd161741e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW9pS01EWWlrWlh6MStmVlBkYkw0QU1wSW9QS1J3QkNXTUJhMHM5RXczNVd4?=
 =?utf-8?B?OWM2eWRjakRxQzJMYUFDMVFzc0g5VGhCMEhiUUd4NUlKTk1XVDR4UmIwdnRK?=
 =?utf-8?B?OGdPczdjTm5EOTd6dWxjUGpGSnpLZXdBOU1vRDZFYUNiWVRzckRCK2ZsZVpp?=
 =?utf-8?B?WnFoM2JhNmxlTFFySmxoQ2JsdFVRbm9tSXREVVRCVEFIOTArWFlhTTdYMkha?=
 =?utf-8?B?OHhUdFh5dVNjZGtleTJrbUJKVTU0ZmpLM3A1TE9MdDI1ZnhPQ3NFaG4xOE5v?=
 =?utf-8?B?ZFVQQ0Z1eFJwZkFTOGwwVVdlN055aFgwdVphMUJUUGxHNWIxS1lmUUhyeW8x?=
 =?utf-8?B?U3VtNzRydmVlT3UvVmorMVFOWEhnaHM2VGJZZnZsWmVaczRWMTREdmVEM0Jm?=
 =?utf-8?B?cytIb2svYjFlVHZwM0VYN1JLTjM2WVliV2l0QXlEMjQyZTd5L1JvekE0NDZK?=
 =?utf-8?B?d0FQcGhqN1BaL3ppdHpKTGtEQytKa2VDR0o5L0JpaGhja0twWUx6bkVaNnlu?=
 =?utf-8?B?QWpEY2lTTUhuQUd5b1AxamV5eVAvK2FCcHFFdmdhQmNDKzkxSHZ0bDBXU0JW?=
 =?utf-8?B?ZzZTVmt6TkxVUExzT2pORGZoUDhSVG9QZXpPUlVrYkU0bWtCdUJXL0hBVXlZ?=
 =?utf-8?B?cnh2YnBETmVaU0hyVHNqZEoybzAxTm11c1kxZWd0VytocU9nUlpEN09lQWdq?=
 =?utf-8?B?bWNiRnJSMGZXU3d2VHA0eUpLbzk4NlFsR1lVcjR5WjJGSURoQ2pwTzNQaHlw?=
 =?utf-8?B?MEpFZXBpU1JyODBqazB6blJWUUgxU1hybVRhZjdRS3c1YlNhYVZNWmhsNDBQ?=
 =?utf-8?B?cTRIeWxzZWFzT25QSkswZnZESmNaNWV2RWE0Qk5Yb0FPdE1MNXJUUDVFRlRM?=
 =?utf-8?B?WUN4TSsyR3JObWE1cmxwRWxwNlVJNmNBM2tVZ2lyMjlvSk8zYk9QWEIzY3E5?=
 =?utf-8?B?eEZyZHdZYlI2bjBvSFlNbE94R0poVHZmOVdqQkREQ0pQQTJXaW0vV282Z01U?=
 =?utf-8?B?QXlCLzNOV0IwQzNqNjhGeE1nQW5LUlJoRFpXMkxhVzlkdUg1VTg4QmdZaFE1?=
 =?utf-8?B?YUVpVmhkckRsWlMrYnR6S3lOMWx5WVdhVzBwbE9WaHY0dmYwMmdlQmlPVTM5?=
 =?utf-8?B?czU5VmNDbkRCOExZTnJIYTh1anlmQWlacnRMZTNva1dTZG8vV1lSSWJ3cjlP?=
 =?utf-8?B?SG9lWUNQWG42Tmo2NmhTMWV5YlVERFhkZ0pMV1VvVFgyVERwbUhxSEZYUFJl?=
 =?utf-8?B?TDNpeUtOQ21CbndPZEQ4aDRWV1dNeGtTVkxQLzZoSDV0aWFPTlZwMzRIQ0t2?=
 =?utf-8?B?OU1kK0lXYjFEMlREQW5RTE8xSEtabUhGekxodE85K0hLWVppVGNPeEpIZjVv?=
 =?utf-8?B?MjZEdCtCVDNEOGlmWVpPWGVISFJDRGcvZlFCZDhqSXRyclV5R3VCa3M3SWcv?=
 =?utf-8?B?V08yTTdpVUx3bDFUcFZmVnBIVG9zQk9QcFNIRi9kUnlIeXNsNG5QOWZlM0l1?=
 =?utf-8?B?VmNsS3NwYjREa3NoZWo1SUQ5bmcxVGRMTlhROUcweEErQlpKNm12TUI4bS8v?=
 =?utf-8?B?eHdhWW8yY2xnSXJRVWwvR0JsVkZ1V3pHQUhVRUFyN25MRHVSM3NrN2poWElx?=
 =?utf-8?B?UTdpV20vcktkTnBncFFjV3ppdEg0aWt0SVVNd3hRK1hzdE01Zkc2aUVXK2l0?=
 =?utf-8?B?K3hGRXRKbDR0Ni80T3pPMndCV1hxS212REFVYTJlNHpWcEppVzQwSGlVb2t4?=
 =?utf-8?B?Y3Fub0hYMTNFUUhMZURGRmY2TXh1NDRJV0N0em5kb0R6aFJQWjkwNHVVVVh5?=
 =?utf-8?B?eHc5SlpRQ01BY3lKYUREdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REdyTUZYTEdyTjJxdVNwa2w2RHhCM2JWTmdjMFUzUG9KYm1aUHJpM3ovMnRL?=
 =?utf-8?B?UEJkL2sxMzJjR3Vpb0RXYlc2MmpldTRMVEV6Q205c3lDWmlCYTZCSWNPSFo1?=
 =?utf-8?B?NFRmcG1zWGdLMTZjejcrTkNUc01FRkM2djBOZWxvdHhNWFB5b0tDSDc1aG85?=
 =?utf-8?B?OWM5aFJyZnRWUUFTUW9XRmk1aktvMGpFTC8yUlIycURKK3BJc1UwVlNYOVpw?=
 =?utf-8?B?blNPdk1yR05wQi95YjlmMktrQUFJOHdscUl0Nzd6b0tIOTdlT040SW84ZzQr?=
 =?utf-8?B?eVo4eG5iUnpsenY1LzZrM2Q2ZVNMSUcwS1hBTmh3d2IyaTVQcEtNTUtmWTIw?=
 =?utf-8?B?c25iRzhRM3IwdHpsZEVxZWljUkxyVGpVMDEwVmszVG40SytZQ05GWVFzNEtT?=
 =?utf-8?B?YmU4eFB5cGFweEFJT0N0V1kvb211cjY1Nml3WDRxMzR0M1I2L1RUdG9vT3Vl?=
 =?utf-8?B?TmJxdWdWRVlDNlIybFAzM1FPaFlaTUtKVVBjNWdaUjNUdUxNYWpSRXNNL3Fx?=
 =?utf-8?B?NlR5NUptQ0lBRGpqOU9JcWJoTjd1NlBhVmcxdlo1Q0paWHp0SklTTmZhdk11?=
 =?utf-8?B?dm9Ka2VjekFvWFFNZFBKYlIrcHVDM3ZvU3I4L3A0T3JxVDB1RmFRdmhhaFQ1?=
 =?utf-8?B?QXVSWUJIeVBScTBSY1RRRFlTZzIvbGFXQlRUdm1hTkxyMHQ3V2U5cjBnVk5k?=
 =?utf-8?B?eE90bGhadldQLzBXM0wwZXp2SjFGcVNvSHBKazhWRjU3YnVoeFM0TXQyekE3?=
 =?utf-8?B?TGtaMDZVRVQ1bVQycnV2c1FHbHhIM1hFUkZ2dko0RENyRi92bE9OQ3RlQWMw?=
 =?utf-8?B?d2tXd0owb1dVMHdpYWd3UW9naEREWEZScHVaVkZqWkc1VTVuS0RUMis1Sk9R?=
 =?utf-8?B?eXNQUUZPbXRqVkZYNjFFMjEwK3lpcVZqSUQzSEpCY0xPOVVFWElndjRzcHM3?=
 =?utf-8?B?Ny9ZM2J4Zi9SbmVUL0ZYV3ZzVmE3YTUvaG8xNlpWNDNVeURPWXhjT0lNZTQv?=
 =?utf-8?B?RFVvQjRib2E3c2ZUa1JWcnpBQTJCbzNQaUZRUjU0RmRlMlYzalpiOVJ6eURl?=
 =?utf-8?B?U0xwSjRWT3Qva2JaK1ZBOUlnM0VCTFowb25mU3FNSXlISkpQQlcvUlVEaWxv?=
 =?utf-8?B?NTVOZTlCWWR5d1pBeDNjQVBjeGRCaHZhVVpjQlFPVlU2RTJTMnhVWFRjWEVs?=
 =?utf-8?B?SHBNbW5Ed053UTlhYTlxZ3oyNWJIZEFXSEw5L3RmdGMwazVOZWQ3Unh6R0sy?=
 =?utf-8?B?cTNxZDRLRm0xdk5VTWV5TzVTSnYvbXE4eFRCVzltOHIzV3NwNlRYRVZXZzFr?=
 =?utf-8?B?L0VTSDYySWpFNEROUnp0TVJaR3Zkb2xSSjR4Qk9CbXdJRWRmUkJyQXFOUDY3?=
 =?utf-8?B?VXg0cmN0b3g4L1UxeGlQWVhhUTZ6RmdvNUZuWWRpNldQUmdYY2NvVFVmUHkv?=
 =?utf-8?B?Q3oyRlpYV1NObVAyam5TVTU2cEVtbXNZeHRZMUd1R3RHVmFlRXhad1JRVzZW?=
 =?utf-8?B?alIzWnZTaWlpa0NsWVV4dkRXUUxNZXhONlVJZWlMUjY2RWtTd3NzcTZaRUkw?=
 =?utf-8?B?NnVTaXhEWUpKSVliWVJicWFTa2dScmNQMk5SWUZxMmFzRXdhSi90SGRLcXRi?=
 =?utf-8?B?UmgweXdmcGwwa0JuVkdIdUNkMG5tMDczeUc3aHp4dEs5MmZNMG0rejJMbGFJ?=
 =?utf-8?B?SVdSemdXQWo3d1JmSE5BRDBSbVFBM0pMS3lyWW5aWUZwU2VyQy8xTklzV1Ja?=
 =?utf-8?B?Q3dQKyt2NG5SSlNqUWh4MVR5aEppTzF6MWI4VEVVeVprWnQ2bTZDbUtadWZM?=
 =?utf-8?B?dEMxd0p5T1RETnk3cS9pUkw2S0Q5Q3lJcUxMV2NWKy9GZUNKYlZIVnRheEUv?=
 =?utf-8?B?Y0FqdXUwdm1adjRzQW5VSzZ6VXVIbDVEMlZkN3o4WUtib2NXL2o4elBESita?=
 =?utf-8?B?NnkzQ2hveDhxM2xPWmRZTWVQaEJMd3UxZnFhY1JFOEN2Sld0NUdxOXpPT210?=
 =?utf-8?B?M3ZDdDFvaVE0NHVSRTIyRjM2OU1ib3RYMXN1cFBXU1IzTlFYUUthc202bGJJ?=
 =?utf-8?B?ckJwRUd3MEJYZnZFRk1Vbkl0RGZ5aThQcTIvWG8vQ29VeThXSDE5bVRVM3JQ?=
 =?utf-8?Q?c73UGtOZjFhY6UXA9zdSx+wV7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pstj2xHJL1z1xg/s9+MV5St3KMDLY4XAOxwlik/YFGojhcW4sX+IsLaK8u9caNJz3YKo/QbvHt72U5NtnoxWPKsN32P/bc4tFIRrfNYNfw83JzoILcHNA6qOtD+zdCmP/FQDVicahN5Rxw6m5OBZ7QVw0IzTzXuRUXzZ2oshrH1dVcoEDmRR641c1NboRU1vyNXOTHsdgYO+XH2kGD771K7ri3p+U0So5SM8XxuonyeQLKSdgewQdtIeUmR1zSZzQpZray92sYe6/Yubo3T0CNYSfIhbjzPFn+QIbnT+MN8NGRBTBebDav+ackBC7vgS4XBSS7lPv6MLEqLHJ5r6xM1BbK6yJlYKe3Tw3RiT6cB8RWDuCUXWmaqee5AJaGRUtGZ/Rer5AS8tHCDv2wgvYG+H59bi2Ca8n8Ch2E/wVOFSTmyytjrOIkXKoQyiESZ00NRHksDn741SENP+TWH4ftTGlRxTCZY8IeVRCLbe8j3Kiz5pcEKhWDKphUtIyOCBX+Y6t0EYH04FkKp+pl6VOLhsc62B6UeFMuotf5ZxTOxSZmb6Qu4D5ORLfGs7Pxe0WYwj42YvNCZx59aPf49wZFYPO0RG6g6Ibc719NaXXGA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f205f2-af92-4883-acb6-08dd161741e9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:58:50.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnKncCPxrX0hVaDQUY7US0Jc7iNEDu/AagWtfstOMPpf+r21mHYVjQewDslVDNy8iFbYpIYmLKN1MhGsQZmmWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7265
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_12,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412060128
X-Proofpoint-ORIG-GUID: F3asCbwNlCU-faaSyUcAWEaaoNpU9TXH
X-Proofpoint-GUID: F3asCbwNlCU-faaSyUcAWEaaoNpU9TXH

On 12/6/24 11:15 AM, Mark Liam Brown wrote:
> On Fri, Dec 6, 2024 at 4:54 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>> IMO, using a URL parser library might be better for us in the
>> long run (eg, more secure) than adding our own little
>> implementation. FedFS used liburiparser.
> 
> Yeah, another library dependency for Debian? First you try to invade
> Debian with libxml2 via backdoor, and now you try to add liburlparser?
> At that point I would suggest that Debian just forks nfs-utils and
> yanks the whole libxml&liburlparser garbage out and replace it with a
> simple line parser. Does the same job and doesn't litter Debian

This is a political screed rather than a technical concern. For one
thing, a fork certainly isn't needed to remove libxml2 or any other
library dependency -- all distributors carry local patches to such
packages.

In any event, I had thought that the Linux community preferred to
de-duplicate common functionality like this. If distributions want a
less secure, harder-to-maintain solution, then they are welcome to
speak up and explain themselves. That's what the review process is for.


-- 
Chuck Lever

