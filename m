Return-Path: <linux-nfs+bounces-10888-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C720BA70F55
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 04:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CD5179488
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 03:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18012CDA5;
	Wed, 26 Mar 2025 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SqjYX6i8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JLGA8rWD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45894F5E0
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742959257; cv=fail; b=prmjMHwhdvmRuEiE4aU8xhb5X20HcfCjXtdxIst7U6EO+PoKT4gAjmRBM3ncpGBR4ci4r9k5bf/d6MM5AAVw83eMLS6VP2/QhUxjk22AtUP1V4ev9cKWjMbzp22RGMBmr/oKI3N0Pk/59e8ln2TKBtLHLTidJxap9Bb53/01VDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742959257; c=relaxed/simple;
	bh=V2Ov1o/7gSM9uCS88/FbX5EZAu2w195qMh2YJGB2B6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BH1yBLQ+N8J7d/H7RYsFrTVCLKLgGRLHhEHCQXhASbeHG7beVkrGUAuZ/2UzvBn4Lbpy452aVFKhzQYX+mvWZNoHO8NUHWbRPZ5Ke1dOg1Q2DJxnvwFaDYyv3uChJxXceY/rMevsMg2xFbDfmseSv3RyMh5NR5j1mvNYFP0fRF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SqjYX6i8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JLGA8rWD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PLtvHi032312;
	Wed, 26 Mar 2025 03:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JTynB/rom+y1jYViWkZMHbQ+7Lrknrmew4OX8HziCLA=; b=
	SqjYX6i8SFd9wRcyzwQDrZpDh/OjNAI8ktEScWu/MjxJrF+fyMN04YsPeLllfxuw
	KylUZQ0RZUi+8u9s0Xit2tzcFpRPsVQICx4ZcdVAkeDXRyPakt7vokmLFzJYCiKL
	KDLMdekf1aJ05+szcBgH1h3wJznGeKkSS3BK7f13dRdL1JKu02qtTTe1CLRy3CSo
	/TkoUPnbXbjmpbWoZR57Z8Eug3lBVyHTvrfBa0EZ2FmoHGdA5U+GyHiUUz/p9lqr
	HbQOjACNvvw2ezu/caa08nY0gT9XuLaydA4farYxPzRKr+COrG5NL2m9BYXKnTKX
	uUirr2JokX/7puG/VZ6syw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnd68fgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 03:20:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q0GBZB015110;
	Wed, 26 Mar 2025 03:20:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj92tnhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 03:20:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvIdyzzMRkINCHLDbHjlt4JPlaz6+qV11zFIxurXWoxCGpZVsASV+4l+LEa4lOEPv42Jb8kJ7LIoF2fMG49su1SI9uAcOBWEp3dvEPDyptNPyBF7pO83gDFtwwcVpFppkAyNSaJHVbzbA8L4HUAUD6puhUZvJYNkeDcR4MrI1zH6RGWCAELKWyjd4UQeiMgc6LlpG8ZR3BJXKZz4QAIHtxY+pGDKafHpRnJzed7phK+TtZGjTTI8nIC22V9jkbiFRXwcVJkDjA0FrrwhwZfK5q/C42zqK/HXB2AY8lZxsV48aE3GPC2+3GeWdq1EBfZ4ExX6d1loBe2gUEfIcHXK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTynB/rom+y1jYViWkZMHbQ+7Lrknrmew4OX8HziCLA=;
 b=PjQkhtSiGXTZHyACzZ2LBdaT1BP7IMjIcByJNkDHROpJfkTnKGq+66t8kj1I8Gec23PZtReqNgcQOnG8YvqaM/ClLJreImkUiZNxzv+rjInKGekZaF9RTva02zN4EC6Ru/rhVlPh5MqVveifv+SoTFzEFWQQ26dRiTcbgsYlG67XtknDQJuJOMsdbJOHTdHhHTC9z74gl1JfCE55QcYvooHKEyC6ZE0a74G1KxzgkiD3SO9Z+jlwPvkVMJhrqesMaX3B3lmam5H+F5xdyBfgSP1WOTG9E/CPl77CygZJAohFGYgjXPqN0d42LkJZa0CNElSV5IVxHME72QZ6SaHWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTynB/rom+y1jYViWkZMHbQ+7Lrknrmew4OX8HziCLA=;
 b=JLGA8rWD4N9BA7v1dBetDAi/AXuQsbVvymBN9cAiZdRLu8Es2MK179BSicUb3PQqf/GrXWnbjYemoq/MeO/BWb0y0AYD31TTRXI248FxKLYLFIq9wLqX6R2DY3Ge60wHctnBqd5pKof2+ScMmqxePWDSzKbO1zjKV/KWg7h+V7A=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SA1PR10MB7585.namprd10.prod.outlook.com (2603:10b6:806:379::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 03:20:43 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 03:20:35 +0000
Message-ID: <8787b756-2003-4a2c-a56c-8f8c626756a1@oracle.com>
Date: Tue, 25 Mar 2025 20:20:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <> <202ab884-c011-4a8f-94fe-37aa11b9d32d@oracle.com>
 <174294858765.9342.3077110145854589812@noble.neil.brown.name>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <174294858765.9342.3077110145854589812@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:208:52d::9) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SA1PR10MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbe3c4c-12ac-41c7-b956-08dd6c152cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anY4ckNMckJFS3FrZ0pEMEQrNng0L05CSW82TEk0a1cvMGt2S2trb21qc2lH?=
 =?utf-8?B?QS85bU1uT2ZiWSs2cnRNUWU0L2ZYbzRTZ3JGMml1VXU3c2JLMWdjYXlGamN3?=
 =?utf-8?B?MWNPR2FRWnVra20xSDUySTVRNUc4ZFNHdGpsOU1CdkdQbmtKazlqeEZVTTZl?=
 =?utf-8?B?NTRjSmJ0WWxrWkM3RDh5eklnUFpxNjRrQXhUZ09VY1VrQjZoREZsUkk2bHNh?=
 =?utf-8?B?TVd6RTJLNjJBclZSczZvSk1ZTmQxdGo4VUFLM1M4MHpzWkxOR2dUVW5sWXBx?=
 =?utf-8?B?RVFZb3ZlYzdGYzJIZlloeStMUmxWbjkrUkU1R1hacFRWVElvRzFWNUJYRE1R?=
 =?utf-8?B?cXV2alNKTGVDQllwdnhhWjhkZjU5RVZTMDcra1hEaVA4eWtqVHJsWHY3UlRh?=
 =?utf-8?B?Vzg0aXF6SEN4VkhtV2d3NVRsRGNhcXN5dnBEbXNGeFdwa0ZEdjJkcUt2bGxi?=
 =?utf-8?B?K09TdE14aUU1OUZySEF6czEwbjlSdVhoQ01TOWhlVFJNSXZ3NHJCRUIxTFl0?=
 =?utf-8?B?L2lDT3FkbjduMTFkNWoxRkV1SXFUd2s3UG1TN3VCekFFRlNXUGlRblpDM2cw?=
 =?utf-8?B?dW9rM2h3a3Rhd2ZwNUI3bnFUSjlGVU9teG53eXVVZElYeVBtREE1c244azQ5?=
 =?utf-8?B?MUdkWFlJYUNqNHR4YitneXliL09aTFNsQlF5QW9WMjhLNlp3MDhIUDRBV25M?=
 =?utf-8?B?SnRCNEgyY01xaTJISUJHOHFEMDEyOGR2cXBRNmpUM0Z6QWZvTzgwYzlyRVZH?=
 =?utf-8?B?RmpqdktwbXF6NE5VK2FDRUs4WVdnWVhSbnRFRVJMR0ltNlFESUpVeE1ybmFn?=
 =?utf-8?B?SnJmU3pwNHpjWFArL1hFaXhheXp2OE9jVVZLNXZaekMvckxhZUFOOXA4ZmVq?=
 =?utf-8?B?d0NmSlhjTXhLb0xpTUZ5SEdJRnpOMWhzcE03dXVjN2JDM29uZFAzSWh3dkJV?=
 =?utf-8?B?clFSQzdTT2RWNkZQUTZsU2tRWW9Pc0ppWExRV0ljZXJmNlpNd3dZNytTOWhO?=
 =?utf-8?B?OFJoalpvdFJxQU1jQk1tRDk0NzhoYkt5Rnl3WXkvRzVOd1pVREdrVUZJb1ZN?=
 =?utf-8?B?OU9kUWZpUERsZzRCNWRGQVlZZTFlVGt0QXdZTWJCa1IycnBFeGN4eEdhUGc1?=
 =?utf-8?B?eWpKRlUzYjF5ODl2cnYvd3k3THl1dnhuVldXUTF5aVhabUpwTkdzSjEva29v?=
 =?utf-8?B?MWYzVG9ic3k2RWxCQVpBWno1YmJsbXNBd3krNllHYUx3ZWczam9hbzN1cEFj?=
 =?utf-8?B?VEtvVU5mYkVweFR2UXpKWVNpRDQ0bDQ5Rm9Lc2dvS0hpRWFQTHVvelZjaDhW?=
 =?utf-8?B?OHVqWk9hYlR1NWRVa1hFUEpudklTSXgvcXk3Y1QxM2lCY2JVOWxFZnptTlB4?=
 =?utf-8?B?amRaRWJpaFNueWdvQjRUZ1pOUVAxK1JkcGZNelJ5SG02dkZxWURqRHIxeU9i?=
 =?utf-8?B?VHNLbzQ2VzBYc1FDOWlpdGVZYWRVU2s5RllDcnk2TGx1dlVEd3BxVXVhaStE?=
 =?utf-8?B?SVpqWDQ0NVIrUzh1NkllMWd3ajFUNmdleS91b1U5RFEzbDRsMVhqVVZpNHNK?=
 =?utf-8?B?U1p2MmFCTzZqSzFYeGZ3ZEEzdnRQZ3Q4Szk0TlkvN3RNL1ZzNnV0Wmh6OU5s?=
 =?utf-8?B?d3NNYUxJY29BVXJHU3BiaE5vUGpVbDlxN2lzQ0NaSlI0Q1VHSVFiU3g1VXlk?=
 =?utf-8?B?SkhHQWJQWEVxYmNrb0laZVZSUmVXVGZlcFBpY0l0VW55RjlTaEVHRmsxcXN1?=
 =?utf-8?B?L3hHRkU0ZXRDZHNhdnVWUlZmazNqVWpteTk3MklOYW5pdytQMGRTelg3ZzRn?=
 =?utf-8?B?SFR0N3BvdWp4YjVnc0JhRjlGSWlFbHZiRzRHR2ZoUWV2VHJmVHJVWHhIdDFt?=
 =?utf-8?Q?2j07X4kXxQ722?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlluZm5JcDVLYkEyVDU1dldpQ0RVM05xNnhMenNIRW5IUkxNOE5IQkRyaC83?=
 =?utf-8?B?WGhNd3ErZ0NMcjJISExHNnpzN2dvdGtLb2t2a1BTbS9Ea2VXTm5xT05Hczln?=
 =?utf-8?B?d0tHZHAzS0xVdHhhN1VlNGlQNVQ2c29oeEYzcjhXejF4MjcvaWllaDVOZDNP?=
 =?utf-8?B?YzJGTUZLSGppb0pkRVB1dnBxbUhReklveTZWNWxlRjVMaHZhZC9nSFI1RWIv?=
 =?utf-8?B?MXRtbDB5YWJiV0FwU1greWNWTzVQNTlKN2d2TkxqSVpySnZKU2NMelBYK21n?=
 =?utf-8?B?K3J1N0FJemdiUDArbEE5akpuQVdlUUNLcUl2eDR2eWdvb2s5eUdlblUwRnFB?=
 =?utf-8?B?REVBVmw1NTFHZzl3VjRoMXZyU1J6QUxIcUlzU0lsL2s0S0pCYkczbjhLdTBW?=
 =?utf-8?B?bFRyUVExdjdvMytzckI3WFRaT2RHdE1HTmZrWGpOSndFTEsrZDVHUTl6RHNu?=
 =?utf-8?B?dERsMTYwOWZrME9QZFJ4VXNKWVo0S3dqdGZ5NUlCZ0tqQjdOcGJzWTdBSnhO?=
 =?utf-8?B?Y2FPUEtvR2F3Yk5rYkpsOHZBa3lQOVhvelpPTU04eEpybmlSczFPWFBYQzZS?=
 =?utf-8?B?eXhDNFZQaTFsMktWeUdhenNxTUVmNHFkNGt1OTA3TkVhTnBoY0dtcUM5S3F6?=
 =?utf-8?B?R2tDd1crZExtRncyaXRnTVVHTFdTT1dPMEFRbHNSVUlRM2JPaTV5QWx2UUJV?=
 =?utf-8?B?cmpjRUZBMVVkbERTOW9oSmt5NEZzVXpzSXBmSnNvK1hMc1gvQ1lCeDNvb0pT?=
 =?utf-8?B?MFp6M0w3ajYxWkY1Y2NqbW5FU2dWdUJEVEo5aDNMVGtTN21jTCtDUGVuVkQy?=
 =?utf-8?B?WENob0NXQ0V2Q1hscHk3YmFxMDhzcW5rVVlGMXRiZGFqMW4zZmdUM1ozb3Vh?=
 =?utf-8?B?ZHp3NkNCWEtlbTZTRWJFdGllQ3FmNGQ1UzBvU0Vra1JtWE5SUml6UWZrcXhw?=
 =?utf-8?B?c2xlRE1GbG94eVdIbUlBMmNmUlBzK0FkSEVtdEFmeVZ0TXh4eXduVFVuVHgx?=
 =?utf-8?B?dE8zN2lIRjYzd1dNOVFnRUUxekVuNXNBVG9OUlMvQlp0bm84Wk4yWmlDUGsr?=
 =?utf-8?B?LzF0Rmt1U21INFBwTGFSRXc1TjR6Z3VVY29PalVXQk1nOEFNUXZockVrZEpX?=
 =?utf-8?B?UWNoOExWbUFsU1BLT3NtTks4aDM1ck9jeS9SUEdNRHhEakNKMm0rOFV5REpy?=
 =?utf-8?B?R2k2bHBnMVZhRjV0S2xsMjlrVGEyUUkyZ2ZqZnN1dmdjaGp3ZzJEOXpLUXRn?=
 =?utf-8?B?S3p3K3VieGhsU2VuR05IckFXVWZkSmhZZ1VoM201T0x6eEhoeGRXb3h0RGxh?=
 =?utf-8?B?RWVrcGh3V2diVEJPZEVGUjZQSmNpTk5mcmJ0ZEo1TmZzNzJtQzJNejBZM1VE?=
 =?utf-8?B?bHkyNlozSTFVWmE0VGx0QTFFYjIxZGkwSW9hMEhZQ3FSME1xVm1oZFNHaW1k?=
 =?utf-8?B?YzFuektyT1pBN09nZ0xydEx5dDNzL25sZkFnZjV3U1BvQVlJQ3ROVkFYdG1L?=
 =?utf-8?B?aENiVjlrSGNIZ0VOcXBZeG56bmIrRkVqWmdIbXNSQWxyUnZhQWFnazZDUDk3?=
 =?utf-8?B?UTN4b29UbHdJaG5RZHcxTXRoNVpFdVlBZkNhWDNabFUvNWNrR21tTnVLWEhl?=
 =?utf-8?B?Q3NiRi9QWnBtZkRyQ3ZEaVpmVzFsTEs4N1hoQ0REbmlETTBsakNyd1RqTCtX?=
 =?utf-8?B?S2FvRDcwU0dmb2RXTno0QmJQaHNnVnZJbXVqcW1EdlM4eTBZTUt2eUhIN3NM?=
 =?utf-8?B?dzh0MGVGNjZaa2tsaUNzTWhSVThaNkdXbVFMVmk1UnZOdXFFRkR4VWR5czZt?=
 =?utf-8?B?YnJIMEdqM29zSXdJNEhva0FkVldTTlQ2ZXIxSkdWV0ZrMk54ZC9aeUFXbzho?=
 =?utf-8?B?cW96VnZacHNPK0xSV29rT2pmeDc0blJvcDM3dFdQM0w3ak5vRHplM2FERFQ1?=
 =?utf-8?B?Rm5RZXNnNHFzc2xjOGk5bFZWZ3NWT3p2WmNxT3hHZmh1ZEZCK3JhTlBJYnQ0?=
 =?utf-8?B?S3JjRjhZRTl1YTlyaG5EeDZhUUJ4aXFRWTJybFVUWEdnamVVZWVWVFAwK3hq?=
 =?utf-8?B?RzhxL2dPb2QwaXArYmthQzY2bkR0by91MUUwUzhGRkRVSWt4M1hacldFUXdu?=
 =?utf-8?Q?s9ugQBHmy1Pzj192wrrXAovOG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1EhzSmQqVXvk4VHdDwQOZUB/5/7adRWa2t04v0l+7WqhyrxbiR1z/f1G7pnmI5ZH+enfigZZ0A7rHqB7RmVzZ3sX6M/uVjuOwPJdmTN1Lfg+FIFR6O+otWpPWIonCGgwDpIL5Xl/YtWkp0eyMyJX+C6e7JY7KcdimceeHCckhJNUfn4w7BKxxTJ5H6YDDdPpsNhavyToZnSewtAhHBuZQb83as06Q3VzcxFx7Cd/tVGSv8klB+Q2+0B2a1kdfVNWSH2E4gQyLeqQQVmRAJSMP5P559c9wZBVv1cgL9h2/HgnSdtxof6SKJyAbViYTe2RseHYD0YoSK+zq6o7gjDAZf3Nzsy4E7B9ny6d/BxFlFAGSGWKycnywWn1w5XV4iM6hR109u88o1/YXLuQKzjkqBoanTv5bkk5SKTA3c+66W2KRu1qvKKV6VVMghckf0EB3tR+RY/4Frqfq6wRwvhTq9LBqV3OT1evZu8Uv4Rgc42CxpQW4qM1VEp0OxoJWsvvyC983nHLZM8EwdPLI83dj3GWBG8qsAluTIW6d/Rin2QlS7esfjYI6+yih55ztfsjzi7NupphY9uLhoyGXk80IMp5+PyRO5V0M1q4G00x5Fk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbe3c4c-12ac-41c7-b956-08dd6c152cbc
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 03:20:35.9204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpmbc9LYYTeHbzIp6KQSB4O4ZFLhn4GA4ie6geaPpSGt3XOhJ3Jg5VjrY7d/vfyYG1AcW2KmKch0Y4PTKzT//A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260018
X-Proofpoint-ORIG-GUID: eOo7GkEzf5AVJqMwrRCOIo181Ie60m4I
X-Proofpoint-GUID: eOo7GkEzf5AVJqMwrRCOIo181Ie60m4I


On 3/25/25 5:23 PM, NeilBrown wrote:
> On Sat, 22 Mar 2025, Chuck Lever wrote:
>> On 3/21/25 10:36 AM, Benjamin Coddington wrote:
>>> On 20 Mar 2025, at 13:53, Chuck Lever wrote:
>>>
>>>> On 3/19/25 5:46 PM, NeilBrown wrote:
>>>>> On Thu, 20 Mar 2025, Dai Ngo wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Currently when the local file system needs to be unmounted for maintenance
>>>>>> the admin needs to make sure all the NFS clients have stopped using any files
>>>>>> on the NFS shares before the umount(8) can succeed.
>>>>> This is easily achieved with
>>>>>    echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem
>>>>>
>>>>> Do this after unexporting and before unmounting.
>>>> Seems like administrators would expect that a filesystem can be
>>>> unmounted immediately after unexporting it. Should "exportfs" be changed
>>>> to handle this extra step under the covers? Doesn't seem like it would
>>>> be hard to do, and I can't think of a use case where it would be
>>>> harmful.
>>> No. I think that admins don't expect to lose all their NFS client's state if
>>> they're managing the exports.  That would be a really big and invisible change
>>> to existing behavior.
>> To be clear, I mean that a file system should be unlocked only when it
>> is specifically unexported. IMO, unexport is usually an administrator
>> action that means "I want to stop remote access to this file system now"
>> and that's what unlock_filesystem does.
> A problem with that position is that "unexport" isn't a well defined
> operation.
> It is quite possible to edit /etc/exports then run "exportfs -r".  This
> may implicit unexport things.
>
> The kernel certainly doesn't have a concept of "unexport".  You can run
> "exportfs -f" at any time quite safely.  That tells the kernel to forget
> all export information, but allows the kernel to ask mountd for anything
> it find that it needs.
>
>> IMO administrators would be surprised to learn that NFS clients may
>> continue to access a file system (via existing open files) after it
>> has been explicitly unexported.
> They can't access those file while it remains unexported.  But if it is
> re-exported, the access they had can continue seamlessly.
>
> The origin model is NLM which is separate from NFS.  Unexporting to NFS
> doesn't close the locks held by NLM.  That can be done separately by the
> client with a STATMON request.  In fact NLM never drops locks unless
> explicitly asked to by the client or forced by the server admin.  So it
> isn't a good model, but it is what we had.
>
>> The alternative is to document unlock_filesystem in man exportfs(8).
> Another alternative is to provide new functionality in exportfs.  Maybe
> a --force flag or a --close-all flag.
> It could examine /proc/fs/nfsd/clients/*/states to determine which
> filesystems had active state, then examine the export tables
> (/var/lib/nfs/etab) to see what was currently exported, then write
> something appropriate to unlock_filesystem for any active filesystems
> which are no longer exported.

Is it possible that at the time of cache_clean/svc_export_put the kernel
makes an upcall to rpc.mountd to check if svc_export.ex_path is still
exported?. If it's not then release all the states that use that super_block.

-Dai

>
> If we did that we would want to find NLM locks in /proc/locks too and
> ensure those were discarded if necessary.
>
> There is also the possibility that a filesystem is still exported to
> some clients but not to all.  In that case writing something to
> unlock_ip might be appropriate - though that doesn't revoke v4 state
> yet.
>
> Thanks,
> NeilBrown
>
>
>> And perhaps we need a more surgical mechanism that can handle the case
>> where the file system is still exported but the security policy has
>> changed. Because this does feel like a real information leak.
>>
>>
>> -- 
>> Chuck Lever
>>

