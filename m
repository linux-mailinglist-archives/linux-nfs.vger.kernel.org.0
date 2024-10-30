Return-Path: <linux-nfs+bounces-7585-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E38F9B6D20
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 20:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B461F21F9A
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 19:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C311CFEB0;
	Wed, 30 Oct 2024 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UXeECD+i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hQlzOdc/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F31C3F01
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730317917; cv=fail; b=ns/7932URHo3RhipwOnnEOPLMK6kcR95XOGOh1pU4kipNEtdOSvS8fcvSuwQ+64T6iAOGcIB2Lic/oZz6baPzYKtUs9R+f7WAMYsIHy1xyrx8fz5J1uGWGHUz7uEPgY2OxKWJl5QxKVdybt3EG1i9CTLBh+zkKXWgDin5RKbSU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730317917; c=relaxed/simple;
	bh=3ZMRewAd1IvMliZY71IEvkTb4+bysnN3wjNI1pn3OEU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OCalQaoYVGIX64c6PjDGycqh4y9yQWEOcFatVNKDj1UB0jWGuPqbN9t5ckwX/uE/O5hS773Q70KosiEXYpYRNgnAbc8tI7ml63G5XRlEjm0azs18VT3qOXQojYJcgUIxPiu+ToBAwk7mZ67wDBDH8vkb0dx77XtO8bXLvYknNFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UXeECD+i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hQlzOdc/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UJC8kx026057;
	Wed, 30 Oct 2024 19:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=M8aoCRSZjPL56DXKtzLfZ5I78/Z5dPbmcvuZOI6u1RI=; b=
	UXeECD+iDlSA9rQYgmKebmjbLAXCWgmJ7A2GN/G+SrdwvKV7T+SY2R3V/1sMrlnm
	mXwm14AFRNraZ0CCZ4syk1tUEuEV/Q0H/td35x/bhcmw7JIpf7LCdmVJivRsLLp3
	vp/ESl47HJYN/Qfx5/J5wSwIjIADJNMG3jRXRB9XifhCQS/XGFkFAJYZVCmTaHF6
	mxQ5UT+4A9L2uYMarfXcbjj6gP0sW1EdhDtyliq1GP+HUwat5eNO0ZsVo12hccaM
	+CUDsq0Umx7epC6SLb3eIYIkwz8ZE7YTvdmAK2dcamjRVkL2XpPNKnVGM8zrH+K1
	iPpVQivrzQ+sQWuFrEDumg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwguxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 19:51:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UIGKA5034880;
	Wed, 30 Oct 2024 19:51:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnd9km3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 19:51:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7tUDSe+GUcWuvyYQkZtzywvySj4Ta/c9iIRSRrQAYUPyqXVtYi07QOPm8BgJd7o+SfkS3kcquuWzmfmoGNIkj2Z9e1qPy4kQmB2lyiNAZ3PEKJvyHwSCtLn9ZwOnzyEiOPWJL+lKe6Rj7l7yqsWIFDjF7iHCDJq7skF9iADddrjpcP5YjYGG7eYM++bCxfAHbTZozXedfh1PRWSF0iA5WAMgabCNmVE6BAdyzAbW9NEfftwVY+YvDJ4qbXcjEyX9wL4LxpV5L+ovHQpon0gfi8nbaCxb8GonzTrL267dwII0e+L6MGcaGYErLs2jnv8Vc4pOwnK88LNDbcutg4mLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8aoCRSZjPL56DXKtzLfZ5I78/Z5dPbmcvuZOI6u1RI=;
 b=csWhSuxWNs88c6XVrUxLn3m0E5UD+yOBAVN+ZN6RwtjVhD2JFQQ4HxI6loMlkfiBXmrOAqLusLZNtE8gADgwFOIF6+Egrg32FiwmRsQ/gWdyOOgsoe+MjVESScuFsprvktMGZzWYSJ6SH0NGiSBV0dmfMj8M6q23PeY/1/63sWxE41NtAV195PVgCHZJyalD0qCLnTVzpRy+L7cRcRvoZ9u19IuZvh4kEJTVbF+3C57c878Pb+rDH74vijemHtfL6ndJxRTosqrZiqZA8yRwxfPgAL29AMSF7VCK88X7A8ue6vDuFio2M6sTnVYKLR2Va+eSXJ3I0fgs/ub47useGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8aoCRSZjPL56DXKtzLfZ5I78/Z5dPbmcvuZOI6u1RI=;
 b=hQlzOdc/wI4skCb89fWEBqDAEb4INWVd/gPdUMX+ufvYadZ08hf3KqhnuDLUvJbv3rhCgtFESl9wt9ixItyMZCU/QPb1xa4rWIS9TAqGTjQHtotCf4iwzH4rAXptDDy44rSNZp+bpfHKdnq6IlTetWqXaKgU4I/DBebxNeM5x+A=
Received: from DM6PR10MB4300.namprd10.prod.outlook.com (2603:10b6:5:221::8) by
 DS7PR10MB5007.namprd10.prod.outlook.com (2603:10b6:5:3ab::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Wed, 30 Oct 2024 19:51:47 +0000
Received: from DM6PR10MB4300.namprd10.prod.outlook.com
 ([fe80::2b16:46d:bc55:874]) by DM6PR10MB4300.namprd10.prod.outlook.com
 ([fe80::2b16:46d:bc55:874%7]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 19:51:46 +0000
Message-ID: <bedccb42-4e8a-4b9c-a0d4-982abb7a318e@oracle.com>
Date: Wed, 30 Oct 2024 15:51:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: nfs: avoid i_lock contention in nfs_clear_invalid_mapping
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
References: <20241018170335.41427-1-snitzer@kernel.org>
 <e25a451540d8eb63f35b82652e197b6e207d4317.camel@kernel.org>
 <ZxK73l2yAOcLe_jl@kernel.org> <ZxLVDC_C2CrWvXT7@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxLVDC_C2CrWvXT7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:610:59::35) To DM6PR10MB4300.namprd10.prod.outlook.com
 (2603:10b6:5:221::8)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4300:EE_|DS7PR10MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5b3f8e-ea93-4b19-e3d9-08dcf91c4915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVZLSmthNXdvclI2TEt1dEo2d09hWTZzMTh4VFlyc1NJVm5DR2JUZmRjMFMz?=
 =?utf-8?B?NmtxK3phZ1g5M3pOWkppdTlkdHRjelhCNFVEc2VxZk96YXhwaW15ZS9PcE1t?=
 =?utf-8?B?WENTSGIzU2dsSWVsdVpLWXVjRUc0M1Q0ckdxM2FHVzV0ekJ5R2l0ME90UWgz?=
 =?utf-8?B?NDgvWU1xSU1UbWpRT1FXZjRYZDU5aFE2aGQrQXpJbkp3Mi9Obkdld0tEVDNm?=
 =?utf-8?B?eDFQUTNHOWNWRmRMVU5xRXFHeDBSL3VvbGh2UWZXT2dUQVBxNG9Ib1lFRktN?=
 =?utf-8?B?RnpHUllNSHFxYTB1S25uWFFiam1UbnVtRWJIQ25pbW1sM1IxQWllaFJiTnVn?=
 =?utf-8?B?MmE5K3BqMUhSV0Jsb0kvb011cWZPVy9wNjR0QTFqZ04wOWFNVzBITzliSmJ1?=
 =?utf-8?B?OE5QcEtpRGZPS2JNMmZqMDljblpKZUFqZ09pZ1U0RGU5K0FuQUFqUmVQUWFJ?=
 =?utf-8?B?bmxOd0hZTlB6LzJURCs0TlNMUHdHSkFYMDVxUkxsTEZUUUxuZ2RKczdwKzRS?=
 =?utf-8?B?SjBWcHJKVUpBemN2NE1RNW0xb2FZWW5aWkVGcmVFaGkzVWxHVkkwYUpYbnpi?=
 =?utf-8?B?MDNIQm9qbml3RllZb2o2eVFhWFlFa0gxaXlHaVlDSVE2ZVVDYU5ialBFSFhy?=
 =?utf-8?B?dSt5a3VrVGdqY0RYT0gzU1RUZEdGNGJwcWY5MGhDREZPbFY5RFJ1ZXRhN0xZ?=
 =?utf-8?B?Q1g2Y2g0SWN4ZnUycTJJYnEzd3c5cjVCVWpiVkRtdEFoVE5iZ2pwTzIwK0I4?=
 =?utf-8?B?WW1kMlloQUFpK2d5WU9HVjRQeS9OTmJ3eVp6eVQ2dW1lWU05Vnk0b0RuZUQ2?=
 =?utf-8?B?dTA1eTNGdUNGVEtOWjVCeGl1UkRheGI1bmlmT1ZzSy9GVUtUYlZ0THFlY2Ni?=
 =?utf-8?B?ZUJ4Z0h5aXpEMEFmZG5DLzhETEl5QkozOWhQbkxtNFpTaTI0MWtCVDl5eWlr?=
 =?utf-8?B?QlFxYUtFYm5JRzJYZCt6ZDliNFZic05ubkFVWlhvdTVzUlBLQ3hFYTBSWktL?=
 =?utf-8?B?TlVtNGFNZVV5M1BOZURPZFQ0YXBYN09mcHh6YVVhNEhKN0VOYWRzMVFJZDE5?=
 =?utf-8?B?dmUvck1kb2xlb01qWG93RDZaVXZEaXc4c2VhOVIwSlg1WDhFOXJsWUc5dmdo?=
 =?utf-8?B?bFZLTGRUWmZDQml6MnBKMy9pdXgxSzlzSFphZVZFSjVGc3ZQUzFWZnFnZTlN?=
 =?utf-8?B?KzBlaGZ5blo4OWhtMU9KWFRMd01telJ1NkxieW5IZmZ2UkYzYnZhaDRkNzNS?=
 =?utf-8?B?Ly9tQ0UwZE9OTElreW9odDJFcHlUZ3c4RnlEUFBQSHZzSnEvOXVmWUl0SmNy?=
 =?utf-8?B?OFcvUE1vbFc3aTFtejEwSWc5SDY5dUx3T05qaXFiWi84Y2lDMTJvUVRUL3pG?=
 =?utf-8?B?alRTSkk1MnFWQit2MEwvU0tqeFJOYW0yV3NhNTdiS2hkNVArZFNublB0UUhK?=
 =?utf-8?B?VGpBRytzSWRYYnlCdTRqTGk0ZFNNOFdjQ0dNZTdYNS9oTXVwUGtpRXVhTzBy?=
 =?utf-8?B?S2xoZndkYldBaWs1alRmSWEreWE0dEI4MDA1NklsN2ZmMEREQXliYk5EZnFi?=
 =?utf-8?B?K2pScmlFck5LdG5jY0FSK0RKTC8vZXZJdks4cFVjSUZOelk0ZkhZWnNtV1FQ?=
 =?utf-8?B?MzMrNWltQi9Jb2IzK3VuS21TdXM5MlVlYmJLTWs2ZDVwcExBRjhtZ0M2c2Iw?=
 =?utf-8?B?UTBkVGZ1RHhWRlFMSW96UGRrSEJaMXp1eUJ5RlRXU2dhWGFXQ2gwOUhXYm1j?=
 =?utf-8?Q?RULNubdE84EbZdDCnYjiFR2qCrSlsxF9c5n1I0y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4300.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlI4WGhWUHR6SzdUUlpMcW13MW9JWnJROFVlWUxvZFJNWHBlY252RzRlWG93?=
 =?utf-8?B?dDd5WXFiOXEwa2szR3VDSDlvT25tcENVbHFEcmVsaWJ6b1lSbTNUSS93NS84?=
 =?utf-8?B?WktRcnZqM09LRDNxR2poM1FvS05CWGh3M3BqYVZUYlRXNHV3Tk41amV2WXQz?=
 =?utf-8?B?ZEloSjg4cmpkMWhrTnJpUWhqdXdqK0x5Ynd1c1lKUWdzdWJUOEx3bzk0RFNN?=
 =?utf-8?B?TTFhQXlyUG0wbHM1S0ozRUhRWGpIUSsrbEpjUkxRZ2NVaWVYa3ZFWlJoWllK?=
 =?utf-8?B?RWlINm9uQUlnVlU4azljZHJMMmRkZjVEZHRqaXlaUTdDbi9qWTkwWGt4RUVU?=
 =?utf-8?B?K3JYWTljektkQi9kUHgrSU1ZdmJkekwzR2M0dlV0bkV1Zkp6aUV5aGxrSDkv?=
 =?utf-8?B?S3J3VTZjenkxNDhGUFhPOGNFaGJucDM1TnluNGlrMDVTaGJDaUJaajMwSFJB?=
 =?utf-8?B?b1B1SmhMcmhpa1ZIRkRkRHJMZUZWTDlpTHkzUWUydDI2TTYyS01yMWxZRkky?=
 =?utf-8?B?NFVWVnZEcDAwQStiSEZpcmNGMnlUc3R6TVZQeENwNFZMa3RpUzRHQ0pDTkl0?=
 =?utf-8?B?MjN1WlFhMVRYcHlITmxGdnpvZStEcmxiZ0V3bzZhWnk1WUFpYjA3VkZMSzVZ?=
 =?utf-8?B?RnNPaGluS3BTWWNRb0x3cUxIeVMxVnFlcDNzek02SDNvWGFkSVZqUEhEenpC?=
 =?utf-8?B?aCtWU2tJcU9GNkxzb28yMG41WmlBUWVJYS9FOENCaG01ZGFnZm16UWVLTHhh?=
 =?utf-8?B?WHRGb2s5YURpVjFhNnZCc1I0d0FTWnFkWUNjWTdORHRFeXpFR1h1OU9FaWxJ?=
 =?utf-8?B?UDhaVHk5TzZjNWRSSlVvUU90V2dOK1NkU1V5Q0lSdDhMTlYwQjZGaTI4WHhW?=
 =?utf-8?B?Vm1qOS9SNFFIWUlmTGlDMml3VVNoL2plbUVjalhkUzdyYnNFaTcyNTB3N0Jz?=
 =?utf-8?B?N2g0RlF0VnVja2FtSW03MVFSa3dTSEIyRzlzN2JMeWVxL1ZQUjdFVjhxQno4?=
 =?utf-8?B?OUxZNjVzTG16K0F2aUhzU3NPc212S0dycDArSEZEUWJ4ZEFxL0tFRk1qaFZr?=
 =?utf-8?B?d3VBRllJZjRtb21DckoyQTYrRFZ6Z3NpbzJ5K3lTRm5NSXpnSG1iV2xwOFVh?=
 =?utf-8?B?UVU5dGgrbDRzZWViZCtvSHlsMGxmd0Y0b1M3QWhuN2lXTlk2SmFPZ252MjQ1?=
 =?utf-8?B?TGxzcVBDaEJ5d2VlY2lSdTBDT1B5RTVpTVcybW5zVWtBbEpGYzJhOTQ2VElP?=
 =?utf-8?B?QW53NXJ3MGJNQmZZcCtEV0k2Mi9Ec2ZzOVJuRHNxK2ZiMFFEdWo2Nm0wVFZ4?=
 =?utf-8?B?aWxoM1dYdm1RTWpQMEo5OHh6RzQyT0NmbnlSM3JrRkd4UW55TFp4QU1uV1Jk?=
 =?utf-8?B?SkZBbWV5b3VmTzNqUWJ0S2tEVGdMWlp6UmhwZXU2V1BFZDdLVGF5enQ3bUZt?=
 =?utf-8?B?N25uMzl5NnZkQ0daUmdvZnJSSU1EY1lvaXd3UU5kNUt6NVpZNzROaTNRUzk1?=
 =?utf-8?B?RG85MEljcEFiODNYaEpEWTlzTXRTUVFkcit5WHNMcHNjcDZ3MlpOUUUvWTMz?=
 =?utf-8?B?NmorOHM1MDZwd1kvSzRDNDA3TmFpTmVzRHJmclpRY1pJZEZONldvVVA1aWxP?=
 =?utf-8?B?eklZT2JudS9GMTNRYmwwa2wrV0t1ditMNXluTnJYMGVidGtIdEoxV3IrYiti?=
 =?utf-8?B?ZUVHeE9YcXl2MCs2RzNHNFBXcGMycG94WkdmQWk0MFI3TCs2Wkg1YytkYkdX?=
 =?utf-8?B?YjhjK1pETkZKaWF2RzZzcWZhMWR2UGhOU25JaXp2U1hHbzBHbFJVUDBlaEtS?=
 =?utf-8?B?Q3pMUjQwN0tSNG9KM1BGNVZBQ1JOc0JZZmExeWJhK3FsK3BTTkhwdVJteEpB?=
 =?utf-8?B?eG9EK2ZuZGY2YUxJTzNEeWxQZmxLLzJhY0V4Z2JkSzhNRkRudUY3U0xvRjVn?=
 =?utf-8?B?NURFdHZPczlrRFkwY1VxU3NnMU5HWGhDb3lKaDYyUzZIeXM5N1I5YnVvL1dt?=
 =?utf-8?B?d09URFIxeDQrbW93M0sxWDR0ZWdKZnpKRHVjUDR4OVR0YmNQU0lJa0RjMy9I?=
 =?utf-8?B?bTQrTkd0alJ5eHZhOGtEUDFLWGtzVEZnU0Z2L25OaDMwMUgwRXdLNWR6M2Nk?=
 =?utf-8?B?UkRhaWlKRDUrQ3Z5NDZpVnpHQXBYWXF5UFhWTVRPM1UwN0I5NnJ1VHB0WldF?=
 =?utf-8?B?a0tjRmtwMjJqOGtjN0hYTzBQcWhNL2RnbHZRelE4Rnd0c1N2OW5vKy9rQWx3?=
 =?utf-8?B?S3R4bWxxMFpEZ0w4Yk9XOTBYSHN3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Dzw5yIxcRc+mM13gVZzDjFuUdj0im/PL3T3i8m22HYbsoeAFEmdCXsEsnXopvS+vv1Fgokd5I+F4JgdUIfjCnWtszEAuTvfUGpqulxR+zyDVQlmi9URv7lmySl6VbdF1O4QnQwvQrHknSmmwLLpLRuGgN8nXsnhvpWH97IcsVmBoH8nLRuKerjT3VDcr5rq+L/fhhMH0O6p6R2XD9P3TFcXkNlRD3LUj9SFJNRc+50fb+XQS+A1CsyYY49YZMAuAqhwqt48jX+S7+/wop7ahClhKt4he/TbxbfCWeya3JYnkKf3EmL/psz8EDgG7TbHceRrvHXk5eY0D1DhertNex6BAMl0zGSZ7jFA9eEPWRqMeHKMppe3s9bNWYraHPOzw8XVsQ06VFbGNfjWlO/c806C8LUm8VC/E8Dyrg/bqH3RvleLwsT6XHVSdVUv+0AmnjDZimDfxuVE6XFkb1s932ByLQ9o86TrLhr/4DO9Ifu4WE9a6UV1H02ad2mdwcyn8cXLQTqPLdg8G4H8UWbD6VLfoYaZrg0Gs6w5dYqsr3l5r4NqWRUa1xdXXbuIlC2IF+0jLyXBVYASpi9EwtbThTpCqbvkMFneS/1i8h7qPA00=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5b3f8e-ea93-4b19-e3d9-08dcf91c4915
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4300.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 19:51:46.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnG/oFr+mMsXo8yhykvqVRl1kcC/jOUA4q0i69L8ktPdLG/5dE0Hl6xed0Jr/k5vlNDMl+Z8KrZi8u1KGiwsd2E+KxK1bimpgh5PORxZzjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5007
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_14,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300156
X-Proofpoint-ORIG-GUID: 49nggCK98YuJHoCWWdTG3b3oHHUAskTP
X-Proofpoint-GUID: 49nggCK98YuJHoCWWdTG3b3oHHUAskTP

Hi Mike,

On 10/18/24 5:37 PM, Mike Snitzer wrote:
> On Fri, Oct 18, 2024 at 03:49:50PM -0400, Mike Snitzer wrote:
>> On Fri, Oct 18, 2024 at 03:39:13PM -0400, Jeff Layton wrote:
>>> On Fri, 2024-10-18 at 13:03 -0400, Mike Snitzer wrote:
>>>> Multi-threaded buffered reads to the same file exposed significant
>>>> inode spinlock contention in nfs_clear_invalid_mapping().
>>>>
>>>> Eliminate this spinlock contention by checking flags without locking,
>>>> instead using smp_rmb and smp_load_acquire accordingly, but then take
>>>> spinlock and double-check these inode flags.
>>>>
>>>> Also refactor nfs_set_cache_invalid() slightly to use
>>>> smp_store_release() to pair with nfs_clear_invalid_mapping()'s
>>>> smp_load_acquire().
>>>>
>>>> While this fix is beneficial for all multi-threaded buffered reads
>>>> issued by an NFS client, this issue was identified in the context of
>>>> surprisingly low LOCALIO performance with 4K multi-threaded buffered
>>>> read IO.  This fix dramatically speeds up LOCALIO performance:
>>>>
>>>> before: read: IOPS=1583k, BW=6182MiB/s (6482MB/s)(121GiB/20002msec)
>>>> after:  read: IOPS=3046k, BW=11.6GiB/s (12.5GB/s)(232GiB/20001msec)
>>>>
>>>> Fixes: 17dfeb911339 ("NFS: Fix races in nfs_revalidate_mapping")
>>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>>> ---
>>>>  fs/nfs/inode.c | 19 ++++++++++++++-----
>>>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>>>> index 542c7d97b235..130d7226b12a 100644
>>>> --- a/fs/nfs/inode.c
>>>> +++ b/fs/nfs/inode.c
>>>> @@ -205,12 +205,14 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
>>>>  		nfs_fscache_invalidate(inode, 0);
>>>>  	flags &= ~NFS_INO_REVAL_FORCED;
>>>>  
>>>> -	nfsi->cache_validity |= flags;
>>>> +	if (inode->i_mapping->nrpages == 0)
>>>> +		flags &= ~NFS_INO_INVALID_DATA;
>>>>  
>>>> -	if (inode->i_mapping->nrpages == 0) {
>>>> -		nfsi->cache_validity &= ~NFS_INO_INVALID_DATA;
>>>> -		nfs_ooo_clear(nfsi);
>>>> -	} else if (nfsi->cache_validity & NFS_INO_INVALID_DATA) {
>>>> +	/* pairs with nfs_clear_invalid_mapping()'s smp_load_acquire() */
>>>> +	smp_store_release(&nfsi->cache_validity, flags);
>>>> +
>>>

I'm having some issues with non-localio NFS after applying this patch:

- cthon basic tests fail with NFS v3
- cthon general tests fail with NFS v4.1 and v4.2
- xfstests generic/080, generic/472, generic/615, and generic/633 fail with NFS v4.1 and v4.2
- xfstests generic/683, and generic/684 fail with NFS v4.2

I think the problem is the call to smp_store_release(). It's overwriting nfsi->cache_validity
with the value of 'flags', losing anything set there but not in 'flags'. Could we instead do
something like:
   smp_store_release(&nfsi->cache_validity, nfsi->cache_validity | flags)
?

Anna

>>> I don't know this code that well, but it used to do an |= of flags into
>>> cache_validity. Now you're replacing cache_validity wholesale with
>>> flags. Maybe that should do something like this?
>>>
>>>     flags |= nfsi->cache_validity;
>>>     smp_store_release(&nfsi->cache_validity, flags);
>>
>> Ah good catch, sorry about that, will fix.
>>
>> This will allow further cleanup too, will let v2 speak to that.
> 
> I just posted v2, but for completeness: I decided to leave well enough
> alone and not do any further cleanup.
> 
> (my thinking was relative to nfs_ooo_clear, and possibly moving it
> before the smp_store_release, so that nfsi->cache_validity only
> changed once using smp_store_release.  The interlock between
> nfs_set_cache_invalid and nfs_clear_invalid_mapping is focused on
> NFS_INO_INVALID_DATA, which nfs_ooo_clear doesn't touch).


