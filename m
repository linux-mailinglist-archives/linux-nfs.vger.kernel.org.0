Return-Path: <linux-nfs+bounces-8390-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3B19E74EE
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 16:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94124282972
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35631494B2;
	Fri,  6 Dec 2024 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M07YInKY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uXnf5pdS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBAC62171
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500466; cv=fail; b=TiJ6/GQHzdlBK8DscStqTBfT0f5tXRCdnJFAnfjeRT1Y//LA/XRwB5xg5G81UZY2DlP9T3Onee0wHwCd7E90BYaf5kENv/EhasVWFbChHkmN/obmf+VgCnzt9wvu/ZmpCnQ6Eft0C0UloqvwxFbkuaOAR5gaRy9/0XfSK/e6M7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500466; c=relaxed/simple;
	bh=ukiSnWDnul2l8xuObQUSVP0e/XwSZbfZs4DJJSvO1U4=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=GbgONbT+ht0mOoHcX0V6gVRBJT92AOtZLZgtLcLdyeuMJENYQFzoKbCLWImw69bDbXxG++jQ0rd+pMUK1dO4wmbq6eNjCTxE3lmbvh2ml70jU9LFVpbpW5VwSof5nw6jM5GAaz5ezilE3b/fYSdXCvppIQbFrCtpHvMg69HGwb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M07YInKY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uXnf5pdS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B66s6uZ023424;
	Fri, 6 Dec 2024 15:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6JiQnYlyQ/XnZwuFVmyt6ILUKztd8MtQ1m4MiH/aIHE=; b=
	M07YInKYM35HrOkQx9yI9Qm5cJU2CTzOop8VVPOWeRCWvkEpW6wuvsx9D7318KoR
	9uC/n/XhGXQqV+AC1lB8befDZ5nmiXaU5pdCjOZ59tVPbgFn0xmXUiVG+Dl5pPhp
	YJoX7VKFEzEY43PmDRL9L40FVsKRmbP3JHh7PvTDb8C3J4KFsyDOKoKpgEYaVjU1
	ylJGKQ48cIxeYPoWPZH1X/zftRPMLgl/Lf2RpsatwzRGAbAWn58VbWmbfYFhV7Ov
	a/YhvKP0ggvY8ljuYC8KNdAJDTLzjeg5bq8OnFg5r1VVkjwtjtr/D/tczf91PXOp
	ioRcVFG3sIAC6lLSkLBpaQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg2dpew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 15:54:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6FhE7p011632;
	Fri, 6 Dec 2024 15:54:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5ceqnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 15:54:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFcQEMvEoUmqqvBWWo4YY6uAdZVK3xDVZSKT+0EJGW16oZCMGB187y31jYE4lOrVWfZHzVhc55Sx7QOe5gSlk+Lq1ZeT8y6bVLSHPcvlshJDboVUDDf3RARYRixhrkha1vh3GhuM7z4aSTW+j7+TUy0mPy6qzKovuak+XRyCX10GwR03Hz+rYUxPmuOWqpfPowFOXEAz8vv/r09Twy0e9xpkuo7qE5xr5yesMIDoJQFwiM8RHFT0t399ES+ouGVdiJi7IMMvo89eQCLRuEdxWVEIbky1KJw62jkfmhav02C7/72anPa6CbXJkFWrbLDuR6h2VngOWpDq5QKzK5s0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JiQnYlyQ/XnZwuFVmyt6ILUKztd8MtQ1m4MiH/aIHE=;
 b=wgmnC/8fnxkl36clv1AwfB1N0Wsz2FSACvSUZLDFSR6UU8iiP9HUwYH+YfHqp0M2UPAXEmFrFirTqI0VkyGIIBf4fIO91LT6HAUs28izIu9wrvDrEzr7TyTWCDcwx0ZILbOYtaGE68BoO9wlJ8QKHwtu07Cv4AJyYgO1AyXMoL49luvBmS/tpxzUiwM/n+Ptopfc/UtA/gxRRKlGt6xUXLYP2Fys8sGb+/XH1ey2+834bh66PKYR/ZvtzLWTj/fJf+Cf6DoHaXs5dzkg9nd9uYd3v4go26bJAFek/TCIHPNbxJoawhcjwB9pPeJdMRiFJdwqpHRSyiWjcmG0Gn/PQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JiQnYlyQ/XnZwuFVmyt6ILUKztd8MtQ1m4MiH/aIHE=;
 b=uXnf5pdSdEqZCcWp7ZQ+iwtFhPQXiT9od92I1LBgr/ck5RHK7ztVjGLQfj9YIdtlWFjMg68sz2fYRGtYaHEsZLsS5bGKQW9dK0FYDYcPsGFOCGxhz+odI2ZLTuMQ3exFWtUov0yHUOX7gGaTTTbOpKe+mBrbKK2s/ZjzxHkIGUU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6528.namprd10.prod.outlook.com (2603:10b6:510:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 15:54:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 15:54:15 +0000
Message-ID: <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
Date: Fri, 6 Dec 2024 10:54:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Roland Mainz <roland.mainz@nrubsig.org>, Steve Dickson <SteveD@redhat.com>
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: f233cd46-6101-4253-b318-08dd160e3c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Skd3YjF6ZEsrelNydzA4L05uQVBnUVVFcml1ckV3d1JIMnJDOUM3bEJZZ3Bp?=
 =?utf-8?B?UDJwNWxycjZLcENjdEUxRkM5bjJLWWEvaGU2dUpCWXJSK2Q3cW1vUTJjbll5?=
 =?utf-8?B?L3ZueFBEaTFRaHhIU1F1SXFxVEdkemdhUjViQ1NiRDZGVG5vU1h6aE4xVGxK?=
 =?utf-8?B?TU1ZdjAzbVNFZTRnOEg3b2NQWkNvZWkvb2FkY0IwNUFVZ1ZTd3VwS1Bpa2Z6?=
 =?utf-8?B?NDRHRGliYlA2YlFHWTI3bjZGSGlmZkVXc1AwcGt0MnIzK3dvM3czV3Y2dUJZ?=
 =?utf-8?B?MmNMWmM5N1BLNWV0OWVOeTNaZFVWcHhDTXFDcTdKZ3U0Tm0xUzlKUHl1Q2R5?=
 =?utf-8?B?NE5vWDBvVkVXanArU3RkV1hGWUY3NWRlbWFTODhhSEFqeGFkMW1kaERSRU42?=
 =?utf-8?B?WjBrS05saURsbzNQVENDUmNnZXZ6SjdyZW9sV3owZXdySkpUK1ExSEFFaHNM?=
 =?utf-8?B?eDQxditKcXlGZWxoRVgzSkdYeHFQb2RmeS85Y3ZQeEU5R2RKN2ExeWh5dVFh?=
 =?utf-8?B?d1RHdGhFSnRoUmpFcy83ZDlXQTlBT0pVWDJjdEY4ZW5ZbDk1MXorZWR4OFNI?=
 =?utf-8?B?S20rajBrU3BSLzZqc2l2TlQ2Z0dSNnpUdmFWWUJYMWk4MjhuVzBzdmZCbXI5?=
 =?utf-8?B?QzBmN3BrdWE5K0lRQXpqeVZZTk00TllFMUFjbVpkTjVCeEdCZDJsVmd3dWJh?=
 =?utf-8?B?UVpnRlNFZ1hudkFzK2ludDB1SlMyYzYycEN3bU5nOVBacmUzRUtxMDJtYXZw?=
 =?utf-8?B?alFPc1RZbmZjM2Y1NlpWM0N4cyt1TzN5WGdyMUdQVFpUZXRSamUvY3VScmVF?=
 =?utf-8?B?UzZWaUtaaWplVE9vU1VkNWc4OUp1d1BiZC9nMjdhK01pbU8zd3FpeXgwNlZK?=
 =?utf-8?B?SlhRRDZRVnQzcVF1S0xnbkVxNnlaSTV5dEZnUmMvUm1DcDAwNGsxdE5BWDVR?=
 =?utf-8?B?dGdWeHR2MFB1c1U5TkFxN21ycXhWa2RmYWo0RmNvQ3JNRFp5UitzK25sNkFG?=
 =?utf-8?B?SERBMGNGaStqMWEzYWpBVEd0QjA1aExZMkczcjY1ai8wVXdId2pybmR2aVdv?=
 =?utf-8?B?MkNjbEdJZGRURjZKNENwdXpDRm9Tc0VaNVR0bVI4ZjI5M2Z4ZldWeVZraWVL?=
 =?utf-8?B?SGRMTE9OY3kyeXA5SldVR0RlV05hdkYwODV0dmRmdVVzbEJwb2hRZ2FFOW5s?=
 =?utf-8?B?MEs5M01jOUlsNTlqcHBDa0JvbkswM2ZRU0ZmbXByWGc5L1k2RXlSNHJYZ3ZS?=
 =?utf-8?B?OThlRFFDd3hFT3hWR3gyVnZLdHZPQWtrOElXd1p6RGFBeS9YaFR5azQ1S1BM?=
 =?utf-8?B?eWF2bUUra0FaOHF1b1pEd0t6eE96STJaazhsZnVyYmI3ajVLWHNNL0R0UDVT?=
 =?utf-8?B?M2JHZXg3TGp3dXg1ZWhrNDEyY2hGMkJuZy9oRnNuSCtZWnV0ZkNVeExldVNV?=
 =?utf-8?B?Qmo1WmJreTdRZ3RNVjJwb29oOHM5dmhiMjJ1ekZZK2dhbDRBcEJmTGZEVEJu?=
 =?utf-8?B?YWFWOXpyNlpNUUx2WEMxOVVYRTVRdGpaZHgxNEV5Vkt2VkRyY1c1SWpuWlpp?=
 =?utf-8?B?RU1uWHczU0h0YzNuVmNyRFkzM2NSR3RubTkweUJRbmxZNVBHQVBXUmJQbmh6?=
 =?utf-8?B?Mmg3Ukx6amp2V3VUdXZtM1VhaHJhbnBYZ21aVFlZdG83VXpjcmNXMWRjREtJ?=
 =?utf-8?B?eHEzc1lhNFFEMHBEZEhST0EvRlVHc0RxOWpFajM1bTl4STVFa3ZoZlhjemlN?=
 =?utf-8?Q?16fqHe7ihK7htgC3oY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWp0SWN0R0F0dGx3U0FVNTRNYWwxd3J3NzF0WFlkNWRIckwwYmFmR1JDVlUy?=
 =?utf-8?B?cHdOQ1hya0NhQW5JOTd6OU91OGFnK09WZWFZd0ZCZjZzSG43bVNpOStybmdG?=
 =?utf-8?B?MnBqUDB3VUlEVkZlTzZDak9PUXFBS1ZqUHNwQTcrQy9oVHZBbHF3cTFwNjl0?=
 =?utf-8?B?a2lreFlacWlOeWhRb3BUQnFiQ28yNDUwUUJBdXpLTzFqcWV2bjdKd0FWaDFk?=
 =?utf-8?B?SEdPbnpidlBWMjhNWFA5MkdYSGkzZldtamQveUFwTFRQVXJIVjJ1ajdGWDc5?=
 =?utf-8?B?YTVUQUFIaCttMzlOdXNFbjhhMzgxcUZ1SVhWd2FJbnBoc080MEI4TlA3YkhI?=
 =?utf-8?B?bE5rV0lkdTBrNTJNQmxmaVdFOXUyR0tCL1hjSWhUMURqU1pCNExyOW1QWEVT?=
 =?utf-8?B?aVk4aE5UN0IrMzJtWmZPTkF1c3dEWGx2Y3k4c3VUcGJwSHVvLzdmZDQrUk83?=
 =?utf-8?B?bWNRQ0VXRzEzN3JQV0Y5cUthSE5INm1hOGw1TVdnZWd6Q2NxcUFvMVJ4eWNO?=
 =?utf-8?B?MWh4dG81SWlhK21ScjVwc3dTeU8zcW9pVlIvL2RKaURscnlwTDJ4RlJXT2Jt?=
 =?utf-8?B?OGdQYzJLaVQ4TXpBbUNLMU1NQ1NtQkxCRVZVeCtia3BSbmQ0aktWTnBlaFJn?=
 =?utf-8?B?OStvZjEzZzdMMjhoZVlvNCtrV3lsYlQxVU4yRFhWbS9zQ05JU2h6TzE0WllV?=
 =?utf-8?B?U01HYjFISzYvYTdGY2gwdTVkYVBhZmhGNnBkdEl3RG1iSHc1V1VBaHg1bCs2?=
 =?utf-8?B?S3g2czFKbVhmQVFMbHp6ZWpub2tPQzVTSHQwaDB4dGU0TlowSmRMVnVrR2ZZ?=
 =?utf-8?B?ZlFibVo5L2hMQ0Q1SGtzRXZ2TnFFK3Nzc0R5b09xYk8weVcwZ29VWk1OU0w5?=
 =?utf-8?B?bDBhU09ETmpFSkRydzdQVkkwTHZHazlRRHQ5RTlYc3VSbXB0c0VFTFJWM093?=
 =?utf-8?B?di8rYVVuYk8xMHJrZUozL1lzQmhsN2J1eTBKcFpBSGpWYks4c1dDS25oK3RY?=
 =?utf-8?B?bHVWWndZOXVzRkJHQU4zRE90OUFFWUNTeWU3RDlJZW1YK1AwdUpXOUhMMUwr?=
 =?utf-8?B?bTFJazJUNW1BbmZSRWxVUmMyNWpadlhRNXdMMEFURzJ6b2JRWnJDdk53L29I?=
 =?utf-8?B?dDVYYnB3cHNUWGg0Tzh0OEI2Mm9TSnM4UkJNU0orMk5vdUZhczJ6YUtmQVh6?=
 =?utf-8?B?NDFJNmcwT29FaUZIVDQvVUdrTExDTStFc2hQcnhxQ05YNzlDYTdFNjNpQXlv?=
 =?utf-8?B?Z2dnems5VjBpQkN3Vms0NFQyN3l5Vzhja0wwaEt6L25jMW43empmOWVCVDhy?=
 =?utf-8?B?ZTNldFg4WUROS0pvM05uQ1B6WVZuOHY5dTIwT0JXM0VZazNCZTZXRG5HNndl?=
 =?utf-8?B?b0dmckduU1hhVDR0cjlxNFA5TGlDYk95dEp5THBJTTl6aGF0ZHZGeGQySC91?=
 =?utf-8?B?dHhrY25hdXl0RENURVdDUFA0QitJWU5QWDFSODJRREhIdXM0amdaRU1xVzU0?=
 =?utf-8?B?emMwcnVlUFJjeGtyY3lBQXBCQnJqYlBRYklhdDIrem9SSE9STEFja3hwRGRh?=
 =?utf-8?B?K3BQcXhQWmJKbW1oYTBkS1Exa1M2Lzl0a0Vmcm00TnRyaThHRUpKNCtVb1Fq?=
 =?utf-8?B?SDFkUVhoNy9aSitmK1dmYnprNVlqOWJqYTdvSnlOM0pGM2tpM2JVd1NCaHg1?=
 =?utf-8?B?ZERnWVU3VFhOWUFrV0UwU1ZCVWJ4QXJ3TEZmRlBqSmJpVTg3WWhoVXZmbUtx?=
 =?utf-8?B?NzVkNWZnMmk2YXo0VHpJN25ESERoNTFod3ZqaFBIdGNzNWxEMm9YeUcwRFlm?=
 =?utf-8?B?aFpOLzE0cjJvTE5hclI3bllDd0VQc3hZSGFrL2N6QThFdVZPcGZ3dVhrcHU4?=
 =?utf-8?B?ajBramJFVHVrTWIzQXVXd0J2Q3ZwV3NUQy9lYktKUmZlNU5JM2dJdWN2QkNa?=
 =?utf-8?B?a0kwOFlPSW5IWlJEL2xCVE1qb2FnMk9CYkhrNWxHbkxrUEJ6VHIxaC9hYXdn?=
 =?utf-8?B?bEFPYkRidUdXSGVxNWNVTkNWZnlxZStiVEZHNndiNFJBRkJsV2wrQUVNNHNZ?=
 =?utf-8?B?Wkg5TkhvbnRkUW14dDYyMmFoditUUjNMb2o0SWFpelIybVRpM3Q0c0JMVFcv?=
 =?utf-8?Q?jGhTwEKK4vbFWz+93wGaeWubw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zCuK8476SRIOw9+HON1B+6rONpNckBjlD/FXttq5nUMmW/qv1vhfdV/Qfsx/qR+p1Kmv6qZDdtYg/OKRlTbboB2XjubN2ahI+B7bX9HQjNBL9JddqNmV45mmGM2otSoy/vNfcBuUkbAT60O2nAEz7N+f9ZdvyAqJrKhk8U6bQyjE1u2sx024TvSRaIi24NJN75rMXNgSgqukw71Tj5WL92LbQjcPexBaKq9Mqzf3TcimEEK9GrkrvSd6HyN4VpyFxCvd7vfn/zHQETmt6mrYZ/5LAq4peIGVt7Igw7eFxe5hBu5krVeqAETK82xrCZ+5RxLYMOfE2XFf9sK1UydeHBd4oNVH/QCaN7o6eibPlHZS3w1lQN5m+oQ9e7/j4STqgzlJDEVTaqr+p7qQ+RVr2pNI0q8uNT0+Mb+WUiwJFVkoQGEHtDBnltWjS/VJDQ+wDOyvOXZA0b0YWmCfF4rpnIPXI0tInfexnzGDyRZ4DYWFa4/wnnbBP+vihgBmwOXUmMoZhaOTljkd4VImKRjYmWZpvANFJN3I3MNQznZoz4Rs9zLWMqMOM5N+TykLSwD/+7SbmDrciNu9A6aNQfZMGOVIfn5N/QbBuyU2jgsShsA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f233cd46-6101-4253-b318-08dd160e3c34
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 15:54:15.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmyX+/Ur4ExQy6FoRTxY3b0wqrn2wtp8lM8FG4FZ8+nRyBujLZJV+pHL7aCxnuUA2rqHGNuYxTCMhhxvX9p2bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6528
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_11,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412060120
X-Proofpoint-ORIG-GUID: 8XWzF6DXY2ZJ83fumlh8GllWp5s_P3oQ
X-Proofpoint-GUID: 8XWzF6DXY2ZJ83fumlh8GllWp5s_P3oQ

Hi Roland, thanks for posting.

Here are some initial review comments to get the ball rolling.


On 12/6/24 5:54 AM, Roland Mainz wrote:
> Hi!
> 
> ----
> 
> Below (and also available at https://nrubsig.kpaste.net/b37) is a
> patch which adds support for nfs://-URLs in mount.nfs4, as alternative
> to the traditional hostname:/path+-o port=<tcp-port> notation.
> 
> * Main advantages are:
> - Single-line notation with the familiar URL syntax, which includes
> hostname, path *AND* TCP port number (last one is a common generator
> of *PAIN* with ISPs) in ONE string
> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,

s/mount points/export paths

(When/if you need to repost, you should move this introductory text into
a cover letter.)


> Japanese, ...) characters, which is typically a big problem if you try
> to transfer such mount point information across email/chat/clipboard
> etc., which tends to mangle such characters to death (e.g.
> transliteration, adding of ZWSP or just '?').
> - URL parameters are supported, providing support for future extensions

IMO, any support for URL parameters should be dropped from this
patch and then added later when we know what the parameters look
like. Generally, we avoid adding extra code until we have actual
use cases. Keeps things simple and reduces technical debt and dead
code.


> * Notes:
> - Similar support for nfs://-URLs exists in other NFSv4.*
> implementations, including Illumos, Windows ms-nfs41-client,
> sahlberg/libnfs, ...

The key here is that this proposal is implementing a /standard/
(RFC 2224).


> - This is NOT about WebNFS, this is only to use an URL representation
> to make the life of admins a LOT easier
> - Only absolute paths are supported

This is actually a critical part of this proposal, IMO.

RFC 2224 specifies two types of NFS URL: one that specifies an
absolute path, which is relative to the server's root FH, and
one that specifies a relative path, which is relative to the
server's PUB FH.

You are adding support for only the absolute path style. This
means the URL is converted to string mount options by mount.nfs
and no code changes are needed in the kernel. There is no new
requirement for support of PUBFH.

I wonder how distributions will test the ability to mount
percent-escaped path names, though. Maybe not upstream's problem.


> - This feature will not be provided for NFSv3

Why shouldn't mount.nfs also support using an NFS URL to mount an
NFSv3-only server? Isn't this simply a matter of letting mount.nfs
negotiate down to NFSv3 if needed?


General comments:

The white space below looks mangled. That needs to be fixed before
this patch can be applied.

IMO, man page updates are needed along with this code change.

IMO, using a URL parser library might be better for us in the
long run (eg, more secure) than adding our own little
implementation. FedFS used liburiparser.

Again, Steve, I would cut an nfs-utils release now, and then add NFS
URL support just after releasing so it has a some time to soak before
the next release.


> ---- snip ----
>  From e7b5a3ac981727e4585288bd66d1a9b2dea045dc Mon Sep 17 00:00:00 2001
> From: Roland Mainz <roland.mainz@nrubsig.org>
> Date: Fri, 6 Dec 2024 10:58:48 +0100
> Subject: [PATCH] mount.nfs4: Add support for nfs://-URLs
> 
> Add support for RFC 2224-style nfs://-URLs as alternative to the
> traditional hostname:/path+-o port=<tcp-port> notation,
> providing standardised, extensible, single-string, crossplatform,
> portable, Character-Encoding independent (e.g. mount point with

As above: s/mount point/export path


> Japanese, Chinese, French etc. characters) and ASCII-compatible
> descriptions of NFSv4 server resources (exports).
> 
> Reviewed-by: Martin Wege <martin.l.wege@gmail.com>
> Signed-off-by: Cedric Blancher <cedric.blancher@gmail.com>
> ---
>   utils/mount/Makefile.am  |   3 +-
>   utils/mount/nfs4mount.c  |  69 +++++++-
>   utils/mount/nfsmount.c   |  93 ++++++++--
>   utils/mount/parse_dev.c  |  67 ++++++--
>   utils/mount/stropts.c    |  96 ++++++++++-
>   utils/mount/urlparser1.c | 358 +++++++++++++++++++++++++++++++++++++++
>   utils/mount/urlparser1.h |  60 +++++++
>   utils/mount/utils.c      | 155 +++++++++++++++++
>   utils/mount/utils.h      |  23 +++
>   9 files changed, 887 insertions(+), 37 deletions(-)
>   create mode 100644 utils/mount/urlparser1.c
>   create mode 100644 utils/mount/urlparser1.h
> 
> diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
> index 83a8ee1c..0e4cab3e 100644
> --- a/utils/mount/Makefile.am
> +++ b/utils/mount/Makefile.am
> @@ -13,7 +13,8 @@ sbin_PROGRAMS = mount.nfs
>   EXTRA_DIST = nfsmount.conf $(man8_MANS) $(man5_MANS)
>   mount_common = error.c network.c token.c \
>        parse_opt.c parse_dev.c \
> -     nfsmount.c nfs4mount.c stropts.c\
> +     nfsmount.c nfs4mount.c \
> +     urlparser1.c urlparser1.h stropts.c \
>        mount_constants.h error.h network.h token.h \
>        parse_opt.h parse_dev.h \
>        nfs4_mount.h stropts.h version.h \
> diff --git a/utils/mount/nfs4mount.c b/utils/mount/nfs4mount.c
> index 0fe142a7..8e4fbf30 100644
> --- a/utils/mount/nfs4mount.c
> +++ b/utils/mount/nfs4mount.c
> @@ -50,8 +50,10 @@
>   #include "mount_constants.h"
>   #include "nfs4_mount.h"
>   #include "nfs_mount.h"
> +#include "urlparser1.h"
>   #include "error.h"
>   #include "network.h"
> +#include "utils.h"
> 
>   #if defined(VAR_LOCK_DIR)
>   #define DEFAULT_DIR VAR_LOCK_DIR
> @@ -182,7 +184,7 @@ int nfs4mount(const char *spec, const char *node, int flags,
>    int num_flavour = 0;
>    int ip_addr_in_opts = 0;
> 
> - char *hostname, *dirname, *old_opts;
> + char *hostname, *dirname, *mb_dirname = NULL, *old_opts;
>    char new_opts[1024];
>    char *opt, *opteq;
>    char *s;
> @@ -192,15 +194,66 @@ int nfs4mount(const char *spec, const char
> *node, int flags,
>    int retry;
>    int retval = EX_FAIL;
>    time_t timeout, t;
> + int nfs_port = NFS_PORT;
> + parsed_nfs_url pnu;
> +
> + (void)memset(&pnu, 0, sizeof(parsed_nfs_url));
> 
>    if (strlen(spec) >= sizeof(hostdir)) {
>    nfs_error(_("%s: excessively long host:dir argument\n"),
>    progname);
>    goto fail;
>    }
> - strcpy(hostdir, spec);
> - if (parse_devname(hostdir, &hostname, &dirname))
> - goto fail;
> +
> + /*
> + * Support nfs://-URLS per RFC 2224 ("NFS URL
> + * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> + * including custom port (nfs://hostname@port/path/...)
> + * and URL parameter (e.g. nfs://.../?param1=val1&param2=val2
> + * support
> + */
> + if (is_spec_nfs_url(spec)) {
> + if (!mount_parse_nfs_url(spec, &pnu)) {
> + goto fail;
> + }
> +
> + /*
> + * |pnu.uctx->path| is in UTF-8, but we need the data
> + * in the current local locale's encoding, as mount(2)
> + * does not have something like a |MS_UTF8_SPEC| flag
> + * to indicate that the input path is in UTF-8,
> + * independently of the current locale
> + */
> + hostname = pnu.uctx->hostport.hostname;
> + dirname = mb_dirname = utf8str2mbstr(pnu.uctx->path);
> +
> + (void)snprintf(hostdir, sizeof(hostdir), "%s:/%s",
> + hostname, dirname);
> + spec = hostdir;
> +
> + if (pnu.uctx->hostport.port != -1) {
> + nfs_port = pnu.uctx->hostport.port;
> + }
> +
> + /*
> + * Values added here based on URL parameters
> + * should be added the front of the list of options,
> + * so users can override the nfs://-URL given default.
> + *
> + * FIXME: We do not do that here for |MS_RDONLY|!
> + */
> + if (pnu.mount_params.read_only != TRIS_BOOL_NOT_SET) {
> + if (pnu.mount_params.read_only)
> + flags |= MS_RDONLY;
> + else
> + flags &= ~MS_RDONLY;
> + }
> +        } else {
> + (void)strcpy(hostdir, spec);
> +
> + if (parse_devname(hostdir, &hostname, &dirname))
> + goto fail;
> + }
> 
>    if (fill_ipv4_sockaddr(hostname, &server_addr))
>    goto fail;
> @@ -247,7 +300,7 @@ int nfs4mount(const char *spec, const char *node, int flags,
>    /*
>    * NFSv4 specifies that the default port should be 2049
>    */
> - server_addr.sin_port = htons(NFS_PORT);
> + server_addr.sin_port = htons(nfs_port);
> 
>    /* parse options */
> 
> @@ -474,8 +527,14 @@ int nfs4mount(const char *spec, const char *node,
> int flags,
>    }
>    }
> 
> + mount_free_parse_nfs_url(&pnu);
> + free(mb_dirname);
> +
>    return EX_SUCCESS;
> 
>   fail:
> + mount_free_parse_nfs_url(&pnu);
> + free(mb_dirname);
> +
>    return retval;
>   }
> diff --git a/utils/mount/nfsmount.c b/utils/mount/nfsmount.c
> index a1c92fe8..e61d718a 100644
> --- a/utils/mount/nfsmount.c
> +++ b/utils/mount/nfsmount.c
> @@ -63,11 +63,13 @@
>   #include "xcommon.h"
>   #include "mount.h"
>   #include "nfs_mount.h"
> +#include "urlparser1.h"
>   #include "mount_constants.h"
>   #include "nls.h"
>   #include "error.h"
>   #include "network.h"
>   #include "version.h"
> +#include "utils.h"
> 
>   #ifdef HAVE_RPCSVC_NFS_PROT_H
>   #include <rpcsvc/nfs_prot.h>
> @@ -493,7 +495,7 @@ nfsmount(const char *spec, const char *node, int flags,
>    char **extra_opts, int fake, int running_bg)
>   {
>    char hostdir[1024];
> - char *hostname, *dirname, *old_opts, *mounthost = NULL;
> + char *hostname, *dirname, *mb_dirname = NULL, *old_opts, *mounthost = NULL;
>    char new_opts[1024], cbuf[1024];
>    static struct nfs_mount_data data;
>    int val;
> @@ -521,29 +523,79 @@ nfsmount(const char *spec, const char *node, int flags,
>    time_t t;
>    time_t prevt;
>    time_t timeout;
> + int nfsurl_port = -1;
> + parsed_nfs_url pnu;
> +
> + (void)memset(&pnu, 0, sizeof(parsed_nfs_url));
> 
>    if (strlen(spec) >= sizeof(hostdir)) {
>    nfs_error(_("%s: excessively long host:dir argument"),
>    progname);
>    goto fail;
>    }
> - strcpy(hostdir, spec);
> - if ((s = strchr(hostdir, ':'))) {
> - hostname = hostdir;
> - dirname = s + 1;
> - *s = '\0';
> - /* Ignore all but first hostname in replicated mounts
> -    until they can be fully supported. (mack@sgi.com) */
> - if ((s = strchr(hostdir, ','))) {
> +
> + /*
> + * Support nfs://-URLS per RFC 2224 ("NFS URL
> + * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> + * including custom port (nfs://hostname@port/path/...)
> + * and URL parameter (e.g. nfs://.../?param1=val1&param2=val2
> + * support
> + */
> + if (is_spec_nfs_url(spec)) {
> + if (!mount_parse_nfs_url(spec, &pnu)) {
> + goto fail;
> + }
> +
> + /*
> + * |pnu.uctx->path| is in UTF-8, but we need the data
> + * in the current local locale's encoding, as mount(2)
> + * does not have something like a |MS_UTF8_SPEC| flag
> + * to indicate that the input path is in UTF-8,
> + * independently of the current locale
> + */
> + hostname = pnu.uctx->hostport.hostname;
> + dirname = mb_dirname = utf8str2mbstr(pnu.uctx->path);
> +
> + (void)snprintf(hostdir, sizeof(hostdir), "%s:/%s",
> + hostname, dirname);
> + spec = hostdir;
> +
> + if (pnu.uctx->hostport.port != -1) {
> + nfsurl_port = pnu.uctx->hostport.port;
> + }
> +
> + /*
> + * Values added here based on URL parameters
> + * should be added the front of the list of options,
> + * so users can override the nfs://-URL given default.
> + *
> + * FIXME: We do not do that here for |MS_RDONLY|!
> + */
> + if (pnu.mount_params.read_only != TRIS_BOOL_NOT_SET) {
> + if (pnu.mount_params.read_only)
> + flags |= MS_RDONLY;
> + else
> + flags &= ~MS_RDONLY;
> + }
> +        } else {
> + (void)strcpy(hostdir, spec);
> + if ((s = strchr(hostdir, ':'))) {
> + hostname = hostdir;
> + dirname = s + 1;
>    *s = '\0';
> - nfs_error(_("%s: warning: "
> -   "multiple hostnames not supported"),
> + /* Ignore all but first hostname in replicated mounts
> +    until they can be fully supported. (mack@sgi.com) */
> + if ((s = strchr(hostdir, ','))) {
> + *s = '\0';
> + nfs_error(_("%s: warning: "
> + "multiple hostnames not supported"),
>    progname);
> - }
> - } else {
> - nfs_error(_("%s: directory to mount not in host:dir format"),
> + }
> + } else {
> + nfs_error(_("%s: directory to mount not in host:dir format"),
>    progname);
> - goto fail;
> + goto fail;
> + }
>    }
> 
>    if (!nfs_gethostbyname(hostname, nfs_saddr))
> @@ -579,6 +631,14 @@ nfsmount(const char *spec, const char *node, int flags,
>    memset(nfs_pmap, 0, sizeof(*nfs_pmap));
>    nfs_pmap->pm_prog = NFS_PROGRAM;
> 
> + if (nfsurl_port != -1) {
> + /*
> + * Set custom TCP port defined by a nfs://-URL here,
> + * so $ mount -o port ... # can be used to override
> + */
> + nfs_pmap->pm_port = nfsurl_port;
> + }
> +
>    /* parse options */
>    new_opts[0] = 0;
>    if (!parse_options(old_opts, &data, &bg, &retry, &mnt_server, &nfs_server,
> @@ -863,10 +923,13 @@ noauth_flavors:
>    }
>    }
> 
> + mount_free_parse_nfs_url(&pnu);
> +
>    return EX_SUCCESS;
> 
>    /* abort */
>    fail:
> + mount_free_parse_nfs_url(&pnu);
>    if (fsock != -1)
>    close(fsock);
>    return retval;
> diff --git a/utils/mount/parse_dev.c b/utils/mount/parse_dev.c
> index 2ade5d5d..d9f8cf59 100644
> --- a/utils/mount/parse_dev.c
> +++ b/utils/mount/parse_dev.c
> @@ -27,6 +27,8 @@
>   #include "xcommon.h"
>   #include "nls.h"
>   #include "parse_dev.h"
> +#include "urlparser1.h"
> +#include "utils.h"
> 
>   #ifndef NFS_MAXHOSTNAME
>   #define NFS_MAXHOSTNAME (255)
> @@ -179,17 +181,62 @@ static int nfs_parse_square_bracket(const char *dev,
>   }
> 
>   /*
> - * RFC 2224 says an NFS client must grok "public file handles" to
> - * support NFS URLs.  Linux doesn't do that yet.  Print a somewhat
> - * helpful error message in this case instead of pressing forward
> - * with the mount request and failing with a cryptic error message
> - * later.
> + * Support nfs://-URLS per RFC 2224 ("NFS URL
> + * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> + * including port support (nfs://hostname@port/path/...)
>    */
> -static int nfs_parse_nfs_url(__attribute__((unused)) const char *dev,
> -      __attribute__((unused)) char **hostname,
> -      __attribute__((unused)) char **pathname)
> +static int nfs_parse_nfs_url(const char *dev,
> +      char **out_hostname,
> +      char **out_pathname)
>   {
> - nfs_error(_("%s: NFS URLs are not supported"), progname);
> + parsed_nfs_url pnu;
> +
> + if (out_hostname)
> + *out_hostname = NULL;
> + if (out_pathname)
> + *out_pathname = NULL;
> +
> + /*
> + * Support nfs://-URLS per RFC 2224 ("NFS URL
> + * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> + * including custom port (nfs://hostname@port/path/...)
> + * and URL parameter (e.g. nfs://.../?param1=val1&param2=val2
> + * support
> + */
> + if (!mount_parse_nfs_url(dev, &pnu)) {
> + goto fail;
> + }
> +
> + if (pnu.uctx->hostport.port != -1) {
> + /* NOP here, unless we switch from hostname to hostport */
> + }
> +
> + if (out_hostname)
> + *out_hostname = strdup(pnu.uctx->hostport.hostname);
> + if (out_pathname)
> + *out_pathname = utf8str2mbstr(pnu.uctx->path);
> +
> + if (((out_hostname)?(*out_hostname == NULL):0) ||
> + ((out_pathname)?(*out_pathname == NULL):0)) {
> + nfs_error(_("%s: out of memory"),
> + progname);
> + goto fail;
> + }
> +
> + mount_free_parse_nfs_url(&pnu);
> +
> + return 1;
> +
> +fail:
> + mount_free_parse_nfs_url(&pnu);
> + if (out_hostname) {
> + free(*out_hostname);
> + *out_hostname = NULL;
> + }
> + if (out_pathname) {
> + free(*out_pathname);
> + *out_pathname = NULL;
> + }
>    return 0;
>   }
> 
> @@ -223,7 +270,7 @@ int nfs_parse_devname(const char *devname,
>    return nfs_pdn_nomem_err();
>    if (*dev == '[')
>    result = nfs_parse_square_bracket(dev, hostname, pathname);
> - else if (strncmp(dev, "nfs://", 6) == 0)
> + else if (is_spec_nfs_url(dev))
>    result = nfs_parse_nfs_url(dev, hostname, pathname);
>    else
>    result = nfs_parse_simple_hostname(dev, hostname, pathname);
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index 23f0a8c0..ad92ab78 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -42,6 +42,7 @@
>   #include "nls.h"
>   #include "nfsrpc.h"
>   #include "mount_constants.h"
> +#include "urlparser1.h"
>   #include "stropts.h"
>   #include "error.h"
>   #include "network.h"
> @@ -50,6 +51,7 @@
>   #include "parse_dev.h"
>   #include "conffile.h"
>   #include "misc.h"
> +#include "utils.h"
> 
>   #ifndef NFS_PROGRAM
>   #define NFS_PROGRAM (100003)
> @@ -643,24 +645,106 @@ static int nfs_sys_mount(struct nfsmount_info
> *mi, struct mount_options *opts)
>   {
>    char *options = NULL;
>    int result;
> + int nfs_port = 2049;
> 
>    if (mi->fake)
>    return 1;
> 
> - if (po_join(opts, &options) == PO_FAILED) {
> - errno = EIO;
> - return 0;
> - }
> + /*
> + * Support nfs://-URLS per RFC 2224 ("NFS URL
> + * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> + * including custom port (nfs://hostname@port/path/...)
> + * and URL parameter (e.g. nfs://.../?param1=val1&param2=val2
> + * support
> + */
> + if (is_spec_nfs_url(mi->spec)) {
> + parsed_nfs_url pnu;
> + char *mb_path;
> + char mount_source[1024];
> +
> + if (!mount_parse_nfs_url(mi->spec, &pnu)) {
> + result = 1;
> + errno = EINVAL;
> + goto done;
> + }
> +
> + /*
> + * |pnu.uctx->path| is in UTF-8, but we need the data
> + * in the current local locale's encoding, as mount(2)
> + * does not have something like a |MS_UTF8_SPEC| flag
> + * to indicate that the input path is in UTF-8,
> + * independently of the current locale
> + */
> + mb_path = utf8str2mbstr(pnu.uctx->path);
> + if (!mb_path) {
> + nfs_error(_("%s: Could not convert path to local encoding."),
> + progname);
> + mount_free_parse_nfs_url(&pnu);
> + result = 1;
> + errno = EINVAL;
> + goto done;
> + }
> +
> + (void)snprintf(mount_source, sizeof(mount_source),
> + "%s:/%s",
> + pnu.uctx->hostport.hostname,
> + mb_path);
> + free(mb_path);
> +
> + if (pnu.uctx->hostport.port != -1) {
> + nfs_port = pnu.uctx->hostport.port;
> + }
> 
> - result = mount(mi->spec, mi->node, mi->type,
> + /*
> + * Insert "port=" option with the value from the nfs://
> + * URL at the beginning of the list of options, so
> + * users can override it with $ mount.nfs4 -o port= #,
> + * e.g.
> + * $ mount.nfs4 -o port=1234 nfs://10.49.202.230:400//bigdisk /mnt4 #
> + * should use port 1234, and not port 400 as specified
> + * in the URL.
> + */
> + char portoptbuf[5+32+1];
> + (void)snprintf(portoptbuf, sizeof(portoptbuf), "port=%d", nfs_port);
> + (void)po_insert(opts, portoptbuf);
> +
> + if (pnu.mount_params.read_only != TRIS_BOOL_NOT_SET) {
> + if (pnu.mount_params.read_only)
> + mi->flags |= MS_RDONLY;
> + else
> + mi->flags &= ~MS_RDONLY;
> + }
> +
> + mount_free_parse_nfs_url(&pnu);
> +
> + if (po_join(opts, &options) == PO_FAILED) {
> + errno = EIO;
> + result = 1;
> + goto done;
> + }
> +
> + result = mount(mount_source, mi->node, mi->type,
> + mi->flags & ~(MS_USER|MS_USERS), options);
> + free(options);
> + } else {
> + if (po_join(opts, &options) == PO_FAILED) {
> + errno = EIO;
> + result = 1;
> + goto done;
> + }
> +
> + result = mount(mi->spec, mi->node, mi->type,
>    mi->flags & ~(MS_USER|MS_USERS), options);
> - free(options);
> + free(options);
> + }
> 
>    if (verbose && result) {
>    int save = errno;
>    nfs_error(_("%s: mount(2): %s"), progname, strerror(save));
>    errno = save;
>    }
> +
> +done:
>    return !result;
>   }
> 
> diff --git a/utils/mount/urlparser1.c b/utils/mount/urlparser1.c
> new file mode 100644
> index 00000000..d4c6f339
> --- /dev/null
> +++ b/utils/mount/urlparser1.c
> @@ -0,0 +1,358 @@
> +/*
> + * MIT License
> + *
> + * Copyright (c) 2024 Roland Mainz <roland.mainz@nrubsig.org>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the
> "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in all
> + * copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN THE
> + * SOFTWARE.
> + */
> +
> +/* urlparser1.c - simple URL parser */
> +
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <ctype.h>
> +#include <stdio.h>
> +
> +#ifdef DBG_USE_WIDECHAR
> +#include <wchar.h>
> +#include <locale.h>
> +#include <io.h>
> +#include <fcntl.h>
> +#endif /* DBG_USE_WIDECHAR */
> +
> +#include "urlparser1.h"
> +
> +typedef struct _url_parser_context_private {
> + url_parser_context c;
> +
> + /* Private data */
> + char *parameter_string_buff;
> +} url_parser_context_private;
> +
> +#define MAX_URL_PARAMETERS 256
> +
> +/*
> + * Original extended regular expression:
> + *
> + * "^"
> + * "(.+?)" // scheme
> + * "://" // '://'
> + * "(" // login
> + * "(?:"
> + * "(.+?)" // user (optional)
> + * "(?::(.+))?" // password (optional)
> + * "@"
> + * ")?"
> + * "(" // hostport
> + * "(.+?)" // host
> + * "(?::([[:digit:]]+))?" // port (optional)
> + * ")"
> + * ")"
> + * "(?:/(.*?))?" // path (optional)
> + * "(?:\?(.*?))?" // URL parameters (optional)
> + * "$"
> + */
> +
> +#define DBGNULLSTR(s) (((s)!=NULL)?(s):"<NULL>")
> +#if 0 || defined(TEST_URLPARSER)
> +#define D(x) x
> +#else
> +#define D(x)
> +#endif
> +
> +#ifdef DBG_USE_WIDECHAR
> +/*
> + * Use wide-char APIs on WIN32, otherwise we cannot output
> + * Japanese/Chinese/etc correctly
> + */
> +#define DBG_PUTS(str, fp) fputws(L"" str, (fp))
> +#define DBG_PUTC(c, fp) fputwc(btowc(c), (fp))
> +#define DBG_PRINTF(fp, fmt, ...) fwprintf((fp), L"" fmt, __VA_ARGS__)
> +#else
> +#define DBG_PUTS(str, fp) fputs((str), (fp))
> +#define DBG_PUTC(c, fp) fputc((c), (fp))
> +#define DBG_PRINTF(fp, fmt, ...) fprintf((fp), fmt, __VA_ARGS__)
> +#endif /* DBG_USE_WIDECHAR */
> +
> +static
> +void urldecodestr(char *outbuff, const char *buffer, size_t len)
> +{
> + size_t i, j;
> +
> + for (i = j = 0 ; i < len ; ) {
> + switch (buffer[i]) {
> + case '%':
> + if ((i + 2) < len) {
> + if (isxdigit((int)buffer[i+1]) && isxdigit((int)buffer[i+2])) {
> + const char hexstr[3] = {
> + buffer[i+1],
> + buffer[i+2],
> + '\0'
> + };
> + outbuff[j++] = (unsigned char)strtol(hexstr, NULL, 16);
> + i += 3;
> + } else {
> + /* invalid hex digit */
> + outbuff[j++] = buffer[i];
> + i++;
> + }
> + } else {
> + /* incomplete hex digit */
> + outbuff[j++] = buffer[i];
> + i++;
> + }
> + break;
> + case '+':
> + outbuff[j++] = ' ';
> + i++;
> + break;
> + default:
> + outbuff[j++] = buffer[i++];
> + break;
> + }
> + }
> +
> + outbuff[j] = '\0';
> +}
> +
> +url_parser_context *url_parser_create_context(const char *in_url,
> unsigned int flags)
> +{
> + url_parser_context_private *uctx;
> + char *s;
> + size_t in_url_len;
> + size_t context_len;
> +
> + /* |flags| is for future extensions */
> + (void)flags;
> +
> + if (!in_url)
> + return NULL;
> +
> + in_url_len = strlen(in_url);
> +
> + context_len = sizeof(url_parser_context_private) +
> + ((in_url_len+1)*6) +
> + (sizeof(url_parser_name_value)*MAX_URL_PARAMETERS)+sizeof(void*);
> + uctx = malloc(context_len);
> + if (!uctx)
> + return NULL;
> +
> + s = (void *)(uctx+1);
> + uctx->c.in_url = s; s+= in_url_len+1;
> + (void)strcpy(uctx->c.in_url, in_url);
> + uctx->c.scheme = s; s+= in_url_len+1;
> + uctx->c.login.username = s; s+= in_url_len+1;
> + uctx->c.hostport.hostname = s; s+= in_url_len+1;
> + uctx->c.path = s; s+= in_url_len+1;
> + uctx->c.hostport.port = -1;
> + uctx->c.num_parameters = -1;
> + uctx->c.parameters = (void *)s; s+=
> (sizeof(url_parser_name_value)*MAX_URL_PARAMETERS)+sizeof(void*);
> + uctx->parameter_string_buff = s; s+= in_url_len+1;
> +
> + return &uctx->c;
> +}
> +
> +int url_parser_parse(url_parser_context *ctx)
> +{
> + url_parser_context_private *uctx = (url_parser_context_private *)ctx;
> +
> + D((void)DBG_PRINTF(stderr, "## parser in_url='%s'\n", uctx->c.in_url));
> +
> + char *s;
> + const char *urlstr = uctx->c.in_url;
> + size_t slen;
> +
> + s = strstr(urlstr, "://");
> + if (!s) {
> + D((void)DBG_PUTS("url_parser: Not an URL\n", stderr));
> + return -1;
> + }
> +
> + slen = s-urlstr;
> + (void)memcpy(uctx->c.scheme, urlstr, slen);
> + uctx->c.scheme[slen] = '\0';
> + urlstr += slen + 3;
> +
> + D((void)DBG_PRINTF(stdout, "scheme='%s', rest='%s'\n",
> uctx->c.scheme, urlstr));
> +
> + s = strstr(urlstr, "@");
> + if (s) {
> + /* URL has user/password */
> + slen = s-urlstr;
> + urldecodestr(uctx->c.login.username, urlstr, slen);
> + urlstr += slen + 1;
> +
> + s = strstr(uctx->c.login.username, ":");
> + if (s) {
> + /* found passwd */
> + uctx->c.login.passwd = s+1;
> + *s = '\0';
> + }
> + else {
> + uctx->c.login.passwd = NULL;
> + }
> +
> + /* catch password-only URLs */
> + if (uctx->c.login.username[0] == '\0')
> + uctx->c.login.username = NULL;
> + }
> + else {
> + uctx->c.login.username = NULL;
> + uctx->c.login.passwd = NULL;
> + }
> +
> + D((void)DBG_PRINTF(stdout, "login='%s', passwd='%s', rest='%s'\n",
> + DBGNULLSTR(uctx->c.login.username),
> + DBGNULLSTR(uctx->c.login.passwd),
> + DBGNULLSTR(urlstr)));
> +
> + char *raw_parameters;
> +
> + uctx->c.num_parameters = 0;
> + raw_parameters = strstr(urlstr, "?");
> + /* Do we have a non-empty parameter string ? */
> + if (raw_parameters && (raw_parameters[1] != '\0')) {
> + *raw_parameters++ = '\0';
> + D((void)DBG_PRINTF(stdout, "raw parameters = '%s'\n", raw_parameters));
> +
> + char *ps = raw_parameters;
> + char *pv; /* parameter value */
> + char *na; /* next '&' */
> + char *pb = uctx->parameter_string_buff;
> + char *pname;
> + char *pvalue;
> + ssize_t pi;
> +
> + for (pi = 0; pi < MAX_URL_PARAMETERS ; pi++) {
> + pname = ps;
> +
> + /*
> + * Handle parameters without value,
> + * e.g. "path?name1&name2=value2"
> + */
> + na = strstr(ps, "&");
> + pv = strstr(ps, "=");
> + if (pv && (na?(na > pv):true)) {
> + *pv++ = '\0';
> + pvalue = pv;
> + ps = pv;
> + }
> + else {
> + pvalue = NULL;
> + }
> +
> + if (na) {
> + *na++ = '\0';
> + }
> +
> + /* URLDecode parameter name */
> + urldecodestr(pb, pname, strlen(pname));
> + uctx->c.parameters[pi].name = pb;
> + pb += strlen(uctx->c.parameters[pi].name)+1;
> +
> + /* URLDecode parameter value */
> + if (pvalue) {
> + urldecodestr(pb, pvalue, strlen(pvalue));
> + uctx->c.parameters[pi].value = pb;
> + pb += strlen(uctx->c.parameters[pi].value)+1;
> + }
> + else {
> + uctx->c.parameters[pi].value = NULL;
> + }
> +
> + /* Next '&' ? */
> + if (!na)
> + break;
> +
> + ps = na;
> + }
> +
> + uctx->c.num_parameters = pi+1;
> + }
> +
> + s = strstr(urlstr, "/");
> + if (s) {
> + /* URL has hostport */
> + slen = s-urlstr;
> + urldecodestr(uctx->c.hostport.hostname, urlstr, slen);
> + urlstr += slen + 1;
> +
> + /*
> + * check for addresses within '[' and ']', like
> + * IPv6 addresses
> + */
> + s = uctx->c.hostport.hostname;
> + if (s[0] == '[')
> + s = strstr(s, "]");
> +
> + if (s == NULL) {
> + D((void)DBG_PUTS("url_parser: Unmatched '[' in hostname\n", stderr));
> + return -1;
> + }
> +
> + s = strstr(s, ":");
> + if (s) {
> + /* found port number */
> + uctx->c.hostport.port = atoi(s+1);
> + *s = '\0';
> + }
> + }
> + else {
> + (void)strcpy(uctx->c.hostport.hostname, urlstr);
> + uctx->c.path = NULL;
> + urlstr = NULL;
> + }
> +
> + D(
> + (void)DBG_PRINTF(stdout,
> + "hostport='%s', port=%d, rest='%s', num_parameters=%d\n",
> + DBGNULLSTR(uctx->c.hostport.hostname),
> + uctx->c.hostport.port,
> + DBGNULLSTR(urlstr),
> + (int)uctx->c.num_parameters);
> + );
> +
> +
> + D(
> + ssize_t dpi;
> + for (dpi = 0 ; dpi < uctx->c.num_parameters ; dpi++) {
> + (void)DBG_PRINTF(stdout,
> + "param[%d]: name='%s'/value='%s'\n",
> + (int)dpi,
> + uctx->c.parameters[dpi].name,
> + DBGNULLSTR(uctx->c.parameters[dpi].value));
> + }
> + );
> +
> + if (!urlstr) {
> + goto done;
> + }
> +
> + urldecodestr(uctx->c.path, urlstr, strlen(urlstr));
> + D((void)DBG_PRINTF(stdout, "path='%s'\n", uctx->c.path));
> +
> +done:
> + return 0;
> +}
> +
> +void url_parser_free_context(url_parser_context *c)
> +{
> + free(c);
> +}
> diff --git a/utils/mount/urlparser1.h b/utils/mount/urlparser1.h
> new file mode 100644
> index 00000000..515eea9d
> --- /dev/null
> +++ b/utils/mount/urlparser1.h
> @@ -0,0 +1,60 @@
> +/*
> + * MIT License
> + *
> + * Copyright (c) 2024 Roland Mainz <roland.mainz@nrubsig.org>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the
> "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in all
> + * copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN THE
> + * SOFTWARE.
> + */
> +
> +/* urlparser1.h - header for simple URL parser */
> +
> +#ifndef __URLPARSER1_H__
> +#define __URLPARSER1_H__ 1
> +
> +#include <stdlib.h>
> +
> +typedef struct _url_parser_name_value {
> + char *name;
> + char *value;
> +} url_parser_name_value;
> +
> +typedef struct _url_parser_context {
> + char *in_url;
> +
> + char *scheme;
> + struct {
> + char *username;
> + char *passwd;
> + } login;
> + struct {
> + char *hostname;
> + signed int port;
> + } hostport;
> + char *path;
> +
> + ssize_t num_parameters;
> + url_parser_name_value *parameters;
> +} url_parser_context;
> +
> +/* Prototypes */
> +url_parser_context *url_parser_create_context(const char *in_url,
> unsigned int flags);
> +int url_parser_parse(url_parser_context *uctx);
> +void url_parser_free_context(url_parser_context *c);
> +
> +#endif /* !__URLPARSER1_H__ */
> diff --git a/utils/mount/utils.c b/utils/mount/utils.c
> index b7562a47..2d4cfa5a 100644
> --- a/utils/mount/utils.c
> +++ b/utils/mount/utils.c
> @@ -28,6 +28,7 @@
>   #include <unistd.h>
>   #include <sys/types.h>
>   #include <sys/stat.h>
> +#include <iconv.h>
> 
>   #include "sockaddr.h"
>   #include "nfs_mount.h"
> @@ -173,3 +174,157 @@ int nfs_umount23(const char *devname, char *string)
>    free(dirname);
>    return result;
>   }
> +
> +/* Convert UTF-8 string to multibyte string in the current locale */
> +char *utf8str2mbstr(const char *utf8_str)
> +{
> + iconv_t cd;
> +
> + cd = iconv_open("UTF-8", "");
> + if (cd == (iconv_t)-1) {
> + perror("utf8str2mbstr: iconv_open failed");
> + return NULL;
> + }
> +
> + size_t inbytesleft = strlen(utf8_str);
> + char *inbuf = (char *)utf8_str;
> + size_t outbytesleft = inbytesleft*4+1;
> + char *outbuf = malloc(outbytesleft);
> + char *outbuf_orig = outbuf;
> +
> + if (!outbuf) {
> + perror("utf8str2mbstr: out of memory");
> + (void)iconv_close(cd);
> + return NULL;
> + }
> +
> + int ret = iconv(cd, &inbuf, &inbytesleft, &outbuf, &outbytesleft);
> + if (ret == -1) {
> + perror("utf8str2mbstr: iconv() failed");
> + free(outbuf_orig);
> + (void)iconv_close(cd);
> + return NULL;
> + }
> +
> + *outbuf = '\0';
> +
> + (void)iconv_close(cd);
> + return outbuf_orig;
> +}
> +
> +/* fixme: We should use |bool|! */
> +int is_spec_nfs_url(const char *spec)
> +{
> + return (!strncmp(spec, "nfs://", 6));
> +}
> +
> +int mount_parse_nfs_url(const char *spec, parsed_nfs_url *pnu)
> +{
> + int result = 1;
> + url_parser_context *uctx = NULL;
> +
> + (void)memset(pnu, 0, sizeof(parsed_nfs_url));
> + pnu->mount_params.read_only = TRIS_BOOL_NOT_SET;
> +
> + uctx = url_parser_create_context(spec, 0);
> + if (!uctx) {
> + nfs_error(_("%s: out of memory"),
> + progname);
> + result = 1;
> + goto done;
> + }
> +
> + if (url_parser_parse(uctx) < 0) {
> + nfs_error(_("%s: Error parsing nfs://-URL."),
> + progname);
> + result = 1;
> + goto done;
> + }
> + if (uctx->login.username || uctx->login.passwd) {
> + nfs_error(_("%s: Username/Password are not defined for nfs://-URL."),
> + progname);
> + result = 1;
> + goto done;
> + }
> + if (!uctx->path) {
> + nfs_error(_("%s: Path missing in nfs://-URL."),
> + progname);
> + result = 1;
> + goto done;
> + }
> + if (uctx->path[0] != '/') {
> + nfs_error(_("%s: Relative nfs://-URLs are not supported."),
> + progname);
> + result = 1;
> + goto done;
> + }
> +
> + if (uctx->num_parameters > 0) {
> + int pi;
> + const char *pname;
> + const char *pvalue;
> +
> + /*
> + * Values added here based on URL parameters
> + * should be added the front of the list of options,
> + * so users can override the nfs://-URL given default.
> + */
> + for (pi = 0; pi < uctx->num_parameters ; pi++) {
> + pname = uctx->parameters[pi].name;
> + pvalue = uctx->parameters[pi].value;
> +
> + if (!strcmp(pname, "rw")) {
> + if ((pvalue == NULL) || (!strcmp(pvalue, "1"))) {
> + pnu->mount_params.read_only = TRIS_BOOL_FALSE;
> + }
> + else if (!strcmp(pvalue, "0")) {
> + pnu->mount_params.read_only = TRIS_BOOL_TRUE;
> + }
> + else {
> + nfs_error(_("%s: Unsupported nfs://-URL "
> + "parameter '%s' value '%s'."),
> + progname, pname, pvalue);
> + result = 1;
> + goto done;
> + }
> + }
> + else if (!strcmp(pname, "ro")) {
> + if ((pvalue == NULL) || (!strcmp(pvalue, "1"))) {
> + pnu->mount_params.read_only = TRIS_BOOL_TRUE;
> + }
> + else if (!strcmp(pvalue, "0")) {
> + pnu->mount_params.read_only = TRIS_BOOL_FALSE;
> + }
> + else {
> + nfs_error(_("%s: Unsupported nfs://-URL "
> + "parameter '%s' value '%s'."),
> + progname, pname, pvalue);
> + result = 1;
> + goto done;
> + }
> + }
> + else {
> + nfs_error(_("%s: Unsupported nfs://-URL "
> + "parameter '%s'."),
> + progname, pname);
> + result = 1;
> + goto done;
> + }
> + }
> + }
> +
> + result = 0;
> +done:
> + if (result != 0) {
> + url_parser_free_context(uctx);
> + return 0;
> + }
> +
> + pnu->uctx = uctx;
> + return 1;
> +}
> +
> +void mount_free_parse_nfs_url(parsed_nfs_url *pnu)
> +{
> + url_parser_free_context(pnu->uctx);
> +}
> diff --git a/utils/mount/utils.h b/utils/mount/utils.h
> index 224918ae..465c0a5e 100644
> --- a/utils/mount/utils.h
> +++ b/utils/mount/utils.h
> @@ -24,13 +24,36 @@
>   #define _NFS_UTILS_MOUNT_UTILS_H
> 
>   #include "parse_opt.h"
> +#include "urlparser1.h"
> 
> +/* Boolean with three states: { not_set, false, true */
> +typedef signed char tristate_bool;
> +#define TRIS_BOOL_NOT_SET (-1)
> +#define TRIS_BOOL_TRUE (1)
> +#define TRIS_BOOL_FALSE (0)
> +
> +#define TRIS_BOOL_GET_VAL(tsb, tsb_default) \
> + (((tsb)!=TRIS_BOOL_NOT_SET)?(tsb):(tsb_default))
> +
> +typedef struct _parsed_nfs_url {
> + url_parser_context *uctx;
> + struct {
> + tristate_bool read_only;
> + } mount_params;
> +} parsed_nfs_url;
> +
> +/* Prototypes */
>   int discover_nfs_mount_data_version(int *string_ver);
>   void print_one(char *spec, char *node, char *type, char *opts);
>   void mount_usage(void);
>   void umount_usage(void);
>   int chk_mountpoint(const char *mount_point);
> +char *utf8str2mbstr(const char *utf8_str);
> +int is_spec_nfs_url(const char *spec);
> 
>   int nfs_umount23(const char *devname, char *string);
> 
> +int mount_parse_nfs_url(const char *spec, parsed_nfs_url *pnu);
> +void mount_free_parse_nfs_url(parsed_nfs_url *pnu);
> +
>   #endif /* !_NFS_UTILS_MOUNT_UTILS_H */


-- 
Chuck Lever

