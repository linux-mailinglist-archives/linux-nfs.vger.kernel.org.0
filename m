Return-Path: <linux-nfs+bounces-13245-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2615B12353
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Jul 2025 19:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE370189C165
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Jul 2025 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA6A2EE987;
	Fri, 25 Jul 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RGO1/0IW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UBdgFtha"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C902F0037
	for <linux-nfs@vger.kernel.org>; Fri, 25 Jul 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466068; cv=fail; b=eFsKt2WCfQkNL/T3rDnu9d9MVvT5KoWuICkxhaZDFnPJ1F1qHq3EhR9Dj2bDT84Z/3gV7mwnDbmSUsz/ZIcbWOSNWWzMezT6GNuBbnbevI6Yz09YzNZ7hr2w75ap8PiiBNs7uVyZH6J5mnRWZmlErmc3ira8jZQmC7S4Z+RmsWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466068; c=relaxed/simple;
	bh=b5pyyffBp2zsm2aFgFngeN+U69u/qLZJ/yM3koe7WKY=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=YKuNKUj1TmP5zYPmSp7S2HJq/3dKY/DKwMOBqjo0voiYFdjxWS+yD+L7F8j6DNgA9pQg1h69ARTjsElMZWmpSBzZOzxI4uWs/l4j0wcFTZl5iNHGwRwnMWuX2qzJYBNnYrSECbRQB4fOsbdR1cAICh0XQY6XmLWe5K6vdRL7920=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RGO1/0IW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UBdgFtha; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PGC7NF007400;
	Fri, 25 Jul 2025 17:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=BzuryD/m4fhr6Atx
	VzaEjVlDBhtW+UzCOyvSM+CRlSQ=; b=RGO1/0IWqrB7Sy+1D7bqCOruQFGgcwoC
	Pg8AyEdgbKmukLyjTWjRYm+iOAz/mTfeCsAq6iMO2ZL8EG9/bzC5wzbGl8817ZWX
	6GeA/E9MsTK7UTbS7HF1IEzmx81J6MGlVwKTFZFjRdZodhJlgPjuM013nTEaTrPa
	uYW8mrmgN52C/hAeFmcZPHqrippb43zS+G6yxH8drUebTsBm2Kxrjp3M2hjjozsF
	fdaFy9D6rOm1R4voVuhqOCguN2LbR8IWuU3ybRGKsVIPuQXeXvxY5HPbyboW8nyx
	8vn09qHEHjYRREKq+hNlAyltWZEou9WI+xomAccAdN+R0gkLxTiCjQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1k9jyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 17:54:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PH0aNX031526;
	Fri, 25 Jul 2025 17:54:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tkpwey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 17:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRAbzFAmlQnfvWzcErKINLwSzYDBz6xBHQrVr8glUyQhiyc4lHkLj2jlYDqokIAbVQ1e590frwHVDmbwtIwpgT2PZ67u1oSd7dt5uWVKp2uinvETIY3sie0j6F/vAmYt3ANGvbKOVnyfYkChP4lCVz6oB5ae9BoxJ0ic7ftvMAuDekSioqLLNDt10mS+uRnXYE/kZYLiAu/2DeZOXkEAmlTDDvMZ+suBvQi3f01EukGDR/PM8swbUgek2//XugXi5Op8lXUpzkeO03eyL/htzHFnxnobIF8E+mC21OQxJkz70J+yHgqqFIi391TNhusmnquzLdUcrv4WuI62fQLM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzuryD/m4fhr6AtxVzaEjVlDBhtW+UzCOyvSM+CRlSQ=;
 b=gL8Vtjxvp3TQ8NiCIwpqiaFMx1be+ogUuN/eZtpTHPAU1rc+C++r6w4Nicm0oVny2ZIE3JFHX5dvjUlrwAbcOpeUv/2U3VISlkWNnGSDWgzjXWa1s3YLyt2bZLi25jpcly9ElobHhaaSOo7S0QeayLfLf8IG8aPGZuMxkpkfXVeTE+mlskbnSf5lFup9jGNLSIPfY+zT955UsjhHAZkS68cT8LVnDcknQenW5l2+r1AWT/kZiZEI2G7IrZRlRNwDDY0SXlxl0j1cArUX4166hYJBlAsm3rZl7U8zLMOeBnJihHibCQgHkYSPdgE5WUzaHsFbjjyOC1oKc/cnZy/Gvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzuryD/m4fhr6AtxVzaEjVlDBhtW+UzCOyvSM+CRlSQ=;
 b=UBdgFthayslJ+RV431nvk9HR9m8m/FQEcHponFuV6sJVme+nQ9OZaZg4mZhrnMYZ7KFgsm0ISyJIfvy6JYfqsq0n/R41CV4wS9O7/WT4MS+eflY3N6JVcV0P/6fEDGY4WST88r7oFOI6SHKvJqQscSkkPJdBF1/Cpgj0qHURuOM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 17:54:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 17:54:19 +0000
Message-ID: <d648ab93-03ed-4852-872a-b1e2976af19d@oracle.com>
Date: Fri, 25 Jul 2025 13:54:17 -0400
User-Agent: Mozilla Thunderbird
To: Jorge Mora <jmora1300@gmail.com>
Content-Language: en-US
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: nfstest_lock: Key Error: 'fcntl'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:610:5a::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbf6be6-e1c3-45c1-1d7d-08ddcba44780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXJ0VWtqZ2Uyb2RsV0EyeC9VbFFtQzdFQmUxUENnVVN3elVKM0dxRVJnV0Ra?=
 =?utf-8?B?OWVQUXRyOUxWRWwzZ0FLczBtRStqZmlTV1hUQ2U0ajkxbTB0YjUwZmc3Nm55?=
 =?utf-8?B?MkpHckF6NzRZU0dmeHRBeGNCcFYyQ1B1eGtGa0xzdC9IcDJIU1F1N05Wcktu?=
 =?utf-8?B?V1dlVTRLNktSYXRXZks1cFlPNWt0bWJCVDJSOVdpQkZhTk9Id0ZsRlI4U0lJ?=
 =?utf-8?B?TXJlcnJQcFhjK09yUUV0TmtUZENXVVFpZGcrODF2aEEweVpSS2orUWJ2S0dh?=
 =?utf-8?B?K0NoUlBLRHRzVkZ1dGtGUGIyeGVmNldySGI5cWdlNjR3UVhQcDMzUkZuTnJD?=
 =?utf-8?B?dFpKNThsRkRyQit2Mld3MXc3UUlwWkxKSlYxdUlVMjQxQlE2NjRmVkFycUd5?=
 =?utf-8?B?U2FEMlowME53UzhMbTJQcnIzbHMwL0tZVUNOT2U5T2dkRVZkVU1SZ25LVzN6?=
 =?utf-8?B?bEFXeFlDSjExcytzQ0hPNy9UYkE5N1pWNTYvYmJwY2MxT05Hc3lxWkdvNlV1?=
 =?utf-8?B?N1IzUmVKTFk0SzMvS3pCOTYzbmkwbFViZm5Pd1FUSEVtTWVTUGpPUEN3ZVAz?=
 =?utf-8?B?a2VXZlZQZDRKWU5ab3J1eHQzMzdJUUxaWG10VEVzQjhueTZuM3lleDJBaTBp?=
 =?utf-8?B?U0pIUlZaVVp1aEtpN3ZGZWFycTJiTGhCZ1lNQjM0QjZSdldnVDBTcHMwY09s?=
 =?utf-8?B?dXlBNlJMak1UTi93c09YaDJEZDRsQ3p0andaNGdnd29iZjM0TXU0UHpubjZV?=
 =?utf-8?B?ZHFwSnBnK3hCUmhHK0Q5cUVBMmpRaXo3ZVdaSzZJeWY4cTg5a3dIbXRjSXda?=
 =?utf-8?B?VS80US85NUphQ0V4a2hZczBiSStDQU5PUTNqeGd4T1VpazNieFFRTmlXSzNm?=
 =?utf-8?B?eTJpK2U3OXlGQ2FPbk1kcWZLR2R2d3FiR3VHQkp4K3dTclpyQ3JDNnFKWjhL?=
 =?utf-8?B?VkU0RFJGZVdPeHYyaG9tNWNqTXV4S3lVc1VjaXlaYkhKaWY5OW9mZFArQXpo?=
 =?utf-8?B?NWIzWU83OEtSMmlBUkFRY3JSQWxZSFh6VkZkMTQ3L2lhRmlpRWUwMG1jcmxp?=
 =?utf-8?B?cXlEcVpSSHh4aHRXUnVUcjQ5NDNadXVBa0ZUN0pmUDdYdWRMSnlZeEFSMk1X?=
 =?utf-8?B?T1BYUWRnanZiMU1xa1dWaFhxcEVUeURIZldHbk9BQWtxV3JlWjk2ZVNtRXRH?=
 =?utf-8?B?UWpWbXRTOUh5TEQxZlFSUWt4cFlpaXRuZEFxY2wzQk1DcXhiTDI2emFUY1pG?=
 =?utf-8?B?RVd2TERNdFMvaXM4azVnSVBLQmxvaG84cEVVS1lMN2kxZ1UyVWNBU0pWUlRP?=
 =?utf-8?B?YlhRY0svckpqY1B5YnVpWThEVHhsQjdKY3ZFSUFoMGg5c01reWpMQ1lKbDZj?=
 =?utf-8?B?NklHck1jVmNYRUE4bEd6NlRPUzNKMnJOb1RjWkhrbmluckg3aDhINWU2ZnlK?=
 =?utf-8?B?STFTaWZ0SW8zTTN5RnptMmt1bUdUZGNPekEzQ0xTNzYvU094clR5SVQ1cHBw?=
 =?utf-8?B?cUl0bnE3cFZKbm9Qam1Jb0J3Yktoak1WcWJtUEs4SUpKUmE1cU9GcVlVZXpQ?=
 =?utf-8?B?UWI0Ym1FR1k5YXFsRUVMYkJpWHJKT25zaTUzNzJpVkkwcnpCblBUNGlwZkN6?=
 =?utf-8?B?RWM1blN5QWdNcE5EcVZkL244S25VMlpkdWZZeGlWY2tVR0hoRzFPSDRNejFV?=
 =?utf-8?B?a2Rva1pLdzliY3lodTBwTXRmbGtUbFFXamhLTUFseXRpeW00RFZLdWNRT0ha?=
 =?utf-8?B?djdEYmw1aitHdHJvUXJib3k4aHdLckQ5YjBMcnUwdDRpMUdQek4vekpTVGRV?=
 =?utf-8?B?cnNvYkUxZ1p5cmJjNCtFVzZmSVVGa00wYyt3NkFiZkpHYTNqKytKSFUrYkph?=
 =?utf-8?B?b1dYUjI5U3VsQnMrZzRiNzhqSDAxSW00b1FyeUQ4bDBsM1pRdHk3QXZQT3NT?=
 =?utf-8?Q?tohOqAQN1YA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTZValkzbkxzVm5CTXFQbmx1SmJKMlZxd1dKUkV3RU1rQk5vOXlNYTc4UEhQ?=
 =?utf-8?B?TEgwdWJVOWpyRWhYMnJuQ2FlNGxlU1pzL09ucXNRaVJqZ3QwbnVQL0FKM1hT?=
 =?utf-8?B?Z001REpnVG0wc3lVNE9MMXVmcFdROFd0cHl4U2JQK3ZoZU1EVUh2ZDFwREZn?=
 =?utf-8?B?Yk5HczAzTTUrL0lBVlVndjZ3bG9tSEErZVJLamd4WEFUUHVzdmJiZmhhWWFG?=
 =?utf-8?B?WEtjTVVjY3pLc2pONHd1cCtGVVFTYUpTeThWTWw1bFdObklndkV4bUR2RFlo?=
 =?utf-8?B?K1djM2dZSUlHYVM3Zkc1MHpRb1VzdXpMRkErTzdjRWxlSkJ4T1pIdlFxZ2FZ?=
 =?utf-8?B?cVpNSFdrS09MbklHSmJET1liOHlRWWJmMk55M3BsbFdDa2xVUGs3eGhJN0c4?=
 =?utf-8?B?Wm5LZ1R6dEJnSVRBZW1uZFpCLzFXbnplUXRrRHJBb0ttWHJjVThPS200MFVC?=
 =?utf-8?B?ZHZCWnExWWJOcFBVRGRrU2dvK0hucXhBRkkwdjBDMEM0YjY1aU1zdzFsTVZr?=
 =?utf-8?B?ZWJ5ODBmbGdRYUJHYWJtUVJtRkJyaU9NQmpRLytDZzlmYldEVkxkc3ZYMEtw?=
 =?utf-8?B?RWkwUzR0SUZiaEkyeDVSVElwLyt3ZzBpSHZ4U3V0akNMd3lnVVVrVmlrU1Bp?=
 =?utf-8?B?Vkx6bGc2SllhOXFXajdiREJ1YXVzckhJUWdQUkVRQy93RXZrZ2hCTVRtSnJq?=
 =?utf-8?B?WlFhSVU0dU5TR0xMNXo1WGpPRHl2NVh5cm84L1pOOHJ5d0RHWHBsUHpZcVc4?=
 =?utf-8?B?ZEg4MEU5cHFRcnNWaHcvOUh4TC9icDZ0eWJuOVBmUER4K2hVQnZyYk9ZWEJH?=
 =?utf-8?B?NFJrSlNLanQ2bjgxcHUwYWRlRm1IK2Fub0FPeERwb1lRZElsRlVPUFBtOHE4?=
 =?utf-8?B?elRzdEg5Q2E1ZVJmV1BZZ1Z1ZmFjQll5b2tQck1KTUR0a1FhWlpZdm5KSnk1?=
 =?utf-8?B?ajdmdFlvcytMQmRTYmowYnA4eWNiWklPMXhCa3JvVlhGdEVtNUVFbzBWMW9u?=
 =?utf-8?B?Z1pTNUxEWFJxTTlJdVJSRjBkZEl6RUJVZlNmcEZFbU8zT29oU0RBYVdTUzhG?=
 =?utf-8?B?Ym8vRnZ4MmVUOVNsNXFGNFFQTnpmVHl4anFhU2oxWnFhODJtQXRTaFJ1VkVR?=
 =?utf-8?B?bEJUNXprL3hleXEyVHFyUGIzQTBCVWVhRkFFNFRKVVhBNFlaUTM2KzZHbGNK?=
 =?utf-8?B?TTc0QjcwSWZJRjRteTBOYVJYTjhmcXdEcGJ4RVF5NVdMUytaZDBJZlpyZFBK?=
 =?utf-8?B?T2JWbDQwRCtwRzVOYVArNnNwWk4vU3hOTG45eVdqdjRvam1KTmJpNmliR3Nr?=
 =?utf-8?B?V1c2WGw4SXpqVjRMKzVFVVo4OWZkSlYyK1NPMktGK2h3SmUvRGdYSEwyc2x0?=
 =?utf-8?B?SjlxS2FZQmpVTGZhWXdNdlloR09BTkZWbUdyQzFiL0hjbmZwM2JTZWpiV1dJ?=
 =?utf-8?B?VktWQ2ptbGVHZERrWm40ZHVnL2V3b1lsUUJCK3QrekxtcHpQRWxaa1lSVXQz?=
 =?utf-8?B?K2w2MXhWbDhuajVFbU1KbnVMMGlVbjMyT3lGN21KTTluS3ZFV3lqQk5kOHBR?=
 =?utf-8?B?eU9NZ1ZaS09OTXdIVHVSTHB5WWs4SkJPbU5vbEVUWTdhb0ZtWTl2OU0rS0R3?=
 =?utf-8?B?UmdRVWt0SGc1OU9MdXN6SUFCNWp0UHdYeG1LMklnaTFzNlpQa3BoTmljbEZi?=
 =?utf-8?B?YUs0dzQ1TmwxVitmRy9MZC85VlN2dGE4bG1Wdm90T0MzZDA1UmJDUytUdTRo?=
 =?utf-8?B?ZEsvT2x4TGhHRktIYmdvcC9IYnJXSCtucUFGU1pGWGlwTURPZjhLbTg1Mmkw?=
 =?utf-8?B?UG1scUtiTEJOdWlpMFd6OHRUbUpPenYxczA4dU9Hd250dVd2cnFxdFN3bmY0?=
 =?utf-8?B?TUpsT3VXdGZCL3RGSU9mVC82RGc4YUphV0dEQWkzaER6SjdENDE1RncvY1Uz?=
 =?utf-8?B?ZnNwY0UzcjdiTTYvNFFBMTdzVlppSWkxSWV1UVhuM0ZTdGpVZFhiWkY1cW5k?=
 =?utf-8?B?ZXl4RUlCaGx4LzVsZ2U3SStHSmU3R0NOMjIyM25nbVBtdjdWMmNLdzI2cldz?=
 =?utf-8?B?YWpTWFZFaUxTRzNtaUpUZjRqbnNmcUpqbkcwWGlEcFUybG5rSDZBZ0JjMm5u?=
 =?utf-8?Q?B0AS35XHsM3SceA6btxhUuwEm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9hQYT/omyjcRrYDqDxP/Fgw+8xDeJCSNWk7WIl7Wa7AwEWoaWmq+5zxZLGbMleLDNZH8qNQY/Fj0kTdXe4hmpGliNwmaYr7Du//p68LnWjdovCbcQSwj3foa8XJ68Yi3bf8Dc85WMu+ttwGa/Gm7IlWzeuQFMGlXuo0mA1aTyiuQtksiLHoP6uzKBQ3xzITHooJR+pXhDYzo8bxf9Ors8BfhDbNcKMX0NLRt4a4G9DvS6PV6qFnbTpOeGnI+pLhRzgC9G1Zy0GkYcv6c32jj7tJg1T88i2SPosU4ckSs8S+2JQ2t2t35EK5qURAQgLfK3hR+o0mva17ncUDEe8Zj60M6BslgmdfHXUsGPID9yGiFfbXWVnXC17d9ToEFb4hmPMw2JwPyTd+Da/HPg8UDjp8SORXfxXZasaQszP8LdBHnpLQ13vVOpJLxL5hfBFIVmzOhBllTwh9QhOAbkX/uQK7QxyF87PzayIYZQAj0CjXF2HDAOVIPQYkkP/fv3v6Vdv2Hm9kR9FOQ/4Ks+C3bbLrHR4hsyYqCwQRVyVlH2eF/d3z/VP5ZGOStDOt7CO1wxlGFB3EvQ7wKLKqZUSqX1O8DLyKcNkQFe2uiMczfvoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbf6be6-e1c3-45c1-1d7d-08ddcba44780
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 17:54:19.5294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEBot0MJCEAe1CM1fxJgQpQEwa4ZknWN61/eyCTvCacJiA6OhsjTEBhOUCR5SXSmQs5l101KIjOWBGEUYSuV3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=948 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE1MyBTYWx0ZWRfX2D6LRe7B/KAy
 dFqFKU4GvezX3herkDo0zDElwyI5qO+cK+05PkLVcUcs3JSuHpoG3X+DOTRltVlzZG8vhCMDWWD
 OsXUXthpigkckIGG/Wbg0Z2dXj1shyPA7MirAVGcRiFTOyE4abMmQBTZrkby4fS8d9SW+/52NSK
 4cLsGPz0ZLmhyKnxZMXW66om6D3lOSky986RGORRWWoIxDGChr9rSsEhqaj3FPH6x1oXLq7C31H
 euEWD48P1hx/k0QWBD5hAN0iDXypxIFWUjFcjGkSlqn/dsjm/WULGR8Cw9R5KouvfmwXPSfHzdK
 NhZexCENgOjC84lqW1ioiqTEFzHyOfLXHgP7we8xxNBF+9eKzaaeabmcUPr62WTa8BGncomQjuV
 ilsbt70vU2j4rLXOzBlgX4JwttDgNA6gz36f14EMT5B7KdXI80Jhk5iVSncH0tYprEpnJzP1
X-Proofpoint-ORIG-GUID: w7RQ9sjVG9R1gAWs-HQARN24X52HHDED
X-Proofpoint-GUID: w7RQ9sjVG9R1gAWs-HQARN24X52HHDED
X-Authority-Analysis: v=2.4 cv=JIQ7s9Kb c=1 sm=1 tr=0 ts=6883c4d0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=zFmCi4dpK7qFhwW0U9cA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600

Hi Jorge-

Disclaimer: I know only enough about Python to be rather dangerous.

Recently I noticed that nfstest_lock has started failing.

    FAIL: Traceback (most recent call last):
            File "/data/nfstest/test/./nfstest_lock", line 1344, in <module>
              x.lock_setup(nfiles=1)
              ~~~~~~~~~~~~^^^^^^^^^^
            File "/data/nfstest/test/./nfstest_lock", line 397, in
lock_setup
              self.create_proc_info(nfsopt_item)
              ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^
            File "/data/nfstest/test/./nfstest_lock", line 445, in
create_proc_info
              pinfo = self.start_rexec(clientobj)
            File "/data/nfstest/test/./nfstest_lock", line 424, in
start_rexec
              execobj.rimport("fcntl", ["fcntl", "F_SETLK"])
              ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            File "/data/nfstest/nfstest/rexec.py", line 449, in rimport
              self.rexec("globals()['%s']=locals()['%s']" % (item, item))
              ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            File "/data/nfstest/nfstest/rexec.py", line 413, in rexec
              return self._send_cmd("exec", expr)
                     ~~~~~~~~~~~~~~^^^^^^^^^^^^^^
            File "/data/nfstest/nfstest/rexec.py", line 350, in _send_cmd
              return self.results()
                     ~~~~~~~~~~~~^^
            File "/data/nfstest/nfstest/rexec.py", line 401, in results
              raise out
          KeyError: 'fcntl'

The code in question is:

    def start_rexec(self, clientobj):
        """Start remote procedure server locally or on the host given by
           the client object.
           Set up the remote server with helper functions to lock and
           unlock a file.

           clientobj:
               Client object where the remote procedure server will be
started
        """
        # Start remote procedure server on given client
        execobj = self.create_rexec(clientobj.host)

        # Setup function to lock and unlock a file
        execobj.rimport("fcntl", ["fcntl", "F_SETLK"])
        execobj.rimport("struct")
        execobj.rimport("signal")
        execobj.rcode(getlock)
        # Set SIGALRM handler to do nothing but not ignoring the signal
        # just to interrupt a blocked lock
        execobj.reval("signal.signal(signal.SIGALRM, lambda
signum,frame:None)")
        return ProcInfo(clientobj, execobj)

Some brief web searching suggests that create_rexec might come from the
deprecated Python 2 module "rexec". This failure was observed on a
Fedora 41 system, it has no Python 2 installed.

Have we hit the end of life for the rexec module?


-- 
Chuck Lever


