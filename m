Return-Path: <linux-nfs+bounces-8532-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411169EF178
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Dec 2024 17:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5178E189A00E
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Dec 2024 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FBC222D7C;
	Thu, 12 Dec 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kkhGDJtz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y36uc4QP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28664222D6A
	for <linux-nfs@vger.kernel.org>; Thu, 12 Dec 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020149; cv=fail; b=AydEjVKLJDzbdXTS/EHlVtT29PvLi9kesB3+kYY2kcp5BmWZSqiVRNKqpoSp/tawiE6xUCo2jVO67K5XUd0D+lM/BuL3AW/KAHrpfR55TA3FzvogQ1yTJQu5iEfDU6dHibjLt6Z8Bim6kJIFUfklSN5c+jqjpzup+B2ABlSLtug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020149; c=relaxed/simple;
	bh=7Qf63efIym7Dt/fSZaJngUVxu4VNGUoJwmJZi8CQOF4=;
	h=Message-ID:Date:Subject:References:To:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mesbmt7M4gCBeZLOw3jHSPRwcs9qgGgA+WTPMGM+5mTIt9B8v22zaF0lzLtlcNVHNeLKW5/U6/tII/whTLPi+ZliREqCc3ZdrvGdkFwMhGkqOy4pDU73n8Tnkca09ZBO6OMED7M3YF1zznlH5XIkcJkufeMRZRqqXR4wQvzviME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kkhGDJtz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y36uc4QP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCCcxtm026572;
	Thu, 12 Dec 2024 16:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tG1kihcReqnFssDtcmyGjfdA1gn+Yv4i6L8k4aBvAc0=; b=
	kkhGDJtzP9jl+T83XQfxYQBZBbYs9Cq8I5ql/2zqVUOO2izS4dioXSoCw1JO5ATb
	pG8+BY/fq2KOGGenLDel5e4eEo16Y6ZqjuXuruNEdLxMr0myz16Be5fISjxgLbQM
	D7r2mzv6kJJWNj3O9skw90krJ2GSYVrpHUY8LFXJuwZSWCcRNyLvA+2vEO9zPOzB
	5tGfGjdu5Xu1DRoNGRGRRuMXv2gVXzyROzVJB/4hLeNCPwNH/zMRAZdbHjIPRFe4
	AhsDQ3uNEKOjhgqu8boAbv8JMRT2IMJ4J3LkGUxPLooCOSNDvpLXk42RJJYjNxst
	m3TkaRhX+rHaNa9Lzrzu4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedcbjqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 16:15:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCG1miq038194;
	Thu, 12 Dec 2024 16:15:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43ccthxxv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 16:15:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n270WXrJuvSRPoLBPAStwEINKtjZKMNB3XkPCqOGeb6VeaUXLTe0rnTo4l9WXTMcu8o727N4m4ma7pL4LtAQ6XkEsBTZwdkYKz11oT4xvI9e+Ys4MX0iCh9wPHF++yBDrW8bWcyuZaoChKxWLC5rCwqsBQ5t04CH9sBIBLqZlVc+MWcA8YtmBTJuUf4EGjVj9XUm5F/6gHCoyAsNUlTL5WoexyeKPaz1Bape+iE6IT7CUL20QV8fGFlN75syH06EGmmgYpbKT2Gbv4sv+d4XR5XTaXcRv2GCKPaa/wV6+knUgID4iFEFki1ubH5zUWlgslqFqG2n70qxgL/MwcA1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG1kihcReqnFssDtcmyGjfdA1gn+Yv4i6L8k4aBvAc0=;
 b=OQ4S6vEE0R1dtJw5z7WyPBPVsblwkuYK9Tt9wD5JKYf7uxWLVcddrMyrqvptXnCywKxxM0naK0XVIn8CYInaOBGSYQkkb559Cqz0lk9NMZourjm2GGPyfh+mLuIInkGIrkAdh3J8aVGzYDnE9lQx9SftifUwPmGreMF8JPwH2LDlBMKS4AVU5wHbtQowmd3ngX/GcNWWWvNVum4B7NQCx8VdrkScBRZ62uLhs/ALz29n18tvb+TCWYSynWAG1qAjQkGyxcoDCwUInF/me4jDtl584KcHcTK+OlhVRTNVk3s83nwxvK6E3GmB1Og0e5V0+8HMHeUgGz9+RrtDJPhZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG1kihcReqnFssDtcmyGjfdA1gn+Yv4i6L8k4aBvAc0=;
 b=y36uc4QPkd5/lkQXTGX6pp3aIJ8HcBwp66eut1xywlMJAvGBpVFTh4651KK+MSKOrRTBvVmaKCpkiQH0qU7Y+l9Hf8dhXyBpLIjvQsG2yik39Xapl1NXghHYc6nJRNvjuarY1PVj/wajS15J0BWpYwbG3GQB6luK18xXsCfLQ4Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7419.namprd10.prod.outlook.com (2603:10b6:208:449::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 16:15:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 16:15:35 +0000
Message-ID: <45ccbf00-3bd8-444e-8765-637caac5f738@oracle.com>
Date: Thu, 12 Dec 2024 11:15:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Fwd: Possible memory leak on nfsd
References: <20241212-b219535c13-13490047f72c@bugzilla.kernel.org>
Content-Language: en-US
To: linux-mm <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241212-b219535c13-13490047f72c@bugzilla.kernel.org>
X-Forwarded-Message-Id: <20241212-b219535c13-13490047f72c@bugzilla.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:610:5a::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 4178407b-bc67-4bd8-b4be-08dd1ac8356f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWI1VkFTbFl0cXVaMmduTVJyZFBjLzZpWWwrSXFIY0NNWHZSRzN5YXJENHoz?=
 =?utf-8?B?NW1VM2J6V0JTMDdHWkN5My9rbllQYXdoMzZUU3pONUVyWnhlcGNkbi95NERB?=
 =?utf-8?B?aWxWL0x1cklEU2N6Tk9IV3NyUUNWSWIvbGZGWFhuTExRWG5CVi9iQzN2YVdO?=
 =?utf-8?B?bVNPMEtPc01ONmx1R0F1a1JWdnFITVMyZXQrTmFWT3A4YlNFY2xBU0phbHFQ?=
 =?utf-8?B?bG90cXJmajNoTGE5NXNSOVhQakVVeVA0Zit2dVQvV1lrZ29IR1RKd3dLS24z?=
 =?utf-8?B?aVVlYWY5T0t4dGdjM0hFemxjUHhqaHdCRFNJbWdJbGdKVmhNaUNMcEQ3TTVF?=
 =?utf-8?B?UEpwZ0J6enpjbldlYVlicGZCZE00MkNrOTNvcVhBUjV6aEtJSVJpWVBHM0E3?=
 =?utf-8?B?eForRlBzY2w5SjZnMXREbERkNVlHSkRYd1pxNzRERXpOVzJlVkpOTlJ5Q0dV?=
 =?utf-8?B?S1dFSVR6SDJOdWhEWnhCdlozQlA3Ukp6VEhicFM2WHpKZVEzVmtrNFJYcWdq?=
 =?utf-8?B?ZWduQzEwME45cFZwczErSHdPSFZTeHlFcktqK1NxRklnU01UaWdmZDRaRkNL?=
 =?utf-8?B?MG1nR3YxWFVNK3JYR09YWTgxSXlzbC9NSEUrMndQejNJTWUwNCtucjdnNDF1?=
 =?utf-8?B?b0RMV1dlQ0EzL1hZUEkwYnVIUTZ4YWZ5MFEvOS9xREJ1blFidWEyZHpMY0pV?=
 =?utf-8?B?RGxEUC9XdGQycDR6VEtlK3dPTGllemZLMnFhdkJ2bTVMZ3ZIWE5jdzNkQzRx?=
 =?utf-8?B?eGxLWXQvY0FnY3pCY0VtdXBvaXZRTjZQS1lEVG9xQTVMMUZTV2RYV01iTTlZ?=
 =?utf-8?B?NDBnMWNGNEEwN1VUUDY3WHB5VkcwWUFMU21HQ3FBTFBLQW5vVXB1OXp4bEdu?=
 =?utf-8?B?eHQrNWNDQzZQZnptT3M3R295Y3EvMFBhbi9tMUR5eFZ4K3d3ZnhjRE9OM1ZC?=
 =?utf-8?B?dTI0eithUFpxL1BRK3NadE9TY2ptNTFiQzRZbnBKbHUwOHVBYTBVYTRXQ3Rn?=
 =?utf-8?B?YVViV0NoR3NMSk5RS1ByVFRlM0xTY0NoZjBnZXRXSkpsRFVUcnBtejQrMHRr?=
 =?utf-8?B?N2NoYWRnN0QvTDgrWUFDMU9hcWJVTXVlV1Y5Z0owV1VFblB3V2M0dnBsRkNy?=
 =?utf-8?B?YlZzYTdLQjVWK0JXakZiN2JoWEkxTGc2OHZueHMrUGRQajdYa2VHaHkzMjZD?=
 =?utf-8?B?d2l3ak85MXNJR2pYb1NLVk1ZbWNNdE0yRzRzSGZmUS9jRVFyRTZWMTlNWTlr?=
 =?utf-8?B?U05lK3RlUHIrWDZCNEI0eStzQzliek9hZmNrUHJYV0JsMnJhWXJra3hab3Y1?=
 =?utf-8?B?c3dBZy9KZDhtNnhpZDI4YnpIczNRVVlTYmt0UThNVHdaL1NsYlNvdkRFOHpU?=
 =?utf-8?B?TTB5dzM3djIrVWRUcTRFejhuNGZ4TzFqaXExb3hzekJIWGxUckpoK2dkQ05O?=
 =?utf-8?B?b2k4Szhsc1JZZDJsOXhjbXFNdTd2Q29XK0lSYzNHR0pPekRTR1RXcGducGR0?=
 =?utf-8?B?MFpoWEJabzhHWWhERjExV09jREV2Y1h6WW9BdXFJWmc0UFdQbTI5K0l4QUgy?=
 =?utf-8?B?UUpPT3IyOE12cnZuWHloaGxHS0hCUmpXMGk2RW1CRzhDQjhwN0tGZCsrbHFZ?=
 =?utf-8?B?clFuMHQ3b0hNV29WMkVUQXNZT01odzE4YlM0bElVdE5nRVBNcHZOVjdRa21a?=
 =?utf-8?B?K3RQbTA3NjZVNDJMY2k1L0FZRXVzQUZaUHV4M0wxSVliNVJKanV6OUNteW1w?=
 =?utf-8?Q?UYDuyAfk00ZHpzTDW0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3hONis1Y3BmbXZYcnJMU1h5WlZvWVR5QnFia2E3bUxCOHd4SWMwQmV5emVu?=
 =?utf-8?B?MlJ4b2h6NEcwN0tzMDVMdUZsUUdiNk1yai92Z2cyWUhKVG5yeVRSK05MeWtw?=
 =?utf-8?B?VkQ4YzRwRW1PRHVUaXpoc25JcWJibWJJdnBCdENYUC9XdXdrWWxvalRkaGl4?=
 =?utf-8?B?UFRSYTFQcXRSRUVETWpzQzdVOUJXT1ZwSGQxVXN0aUMyYkJaTUp4ZFRUcFI2?=
 =?utf-8?B?SVB6SHNDVy9OekJLQzlpM3VlODJUZUFYSmhpMWFKcXJYaGhNU1BOem0vUHhk?=
 =?utf-8?B?TWp2c1Z0UVducW9hQUZtQmwrWS9QVzZqbHk5TlN1RXgvUjJLRGxWRDQ1bzZE?=
 =?utf-8?B?dTVQSUladklXOWx1dWtva1dkUHlEMGNLclRNSXZlaDZYcmJSZFB3WWNXNXNT?=
 =?utf-8?B?NGgwVVh6ZHFoSUhLVFlzRWd1dnk3N1REZGl4V0JlVDFNV2QvWnJDZlVPQ0xo?=
 =?utf-8?B?Y2pJUG9tSnA1QngyZmoxU0gzN2pDMGt0V1A2enk3RGRyai9jaFZtaUxPZDE0?=
 =?utf-8?B?TUlSTTZqdXVCU2dNMVloKytkZExPSVAvS1llbkpqVzVxczlzT2FRRUp2NEdv?=
 =?utf-8?B?Y25pbXNlckxIak1nQllhWDF6R3VKMituVlJGM3c4ZC9qdDcxVFc4K3dxMUlj?=
 =?utf-8?B?Z3dSWXNQRFlvL3AyUWRLb0VYWGpzS2pZQ0VnYUw0Q1AxdlVvR09TSlc0MGRG?=
 =?utf-8?B?NkQ1UVY3S29tUjk5OFE3TjBnZllGQkxLQ3VrMTVXeUppeTBheExra3VLRmJF?=
 =?utf-8?B?U2tLTHljTiszRjExNVQxQlpkSXBkWGNBYkZVQWtWOVc5Q1pMZTBKZVlkbjFK?=
 =?utf-8?B?VEpGYlY3N1BKNHhvRVQ1U0t5LzlWb2xIbWdyUGZ3NC9ad1h3K242VUZxamV6?=
 =?utf-8?B?dmxZZzdXU1pjTzUvbENIK2tEZ3dTNm1DNzliR1ZWQXkxN1JsaFVydkJsQllo?=
 =?utf-8?B?VjB6cDhCSG9ad2hKRkFoV2lveWsvRE91WDVkZzNYR1pPOWdDUHJKTXFOdWEy?=
 =?utf-8?B?Vm45Z1JyUTA0a3pHdUpXa05Zb040V3lCeFU0eFV3QUN0aCt0SkRSOWdUNEJR?=
 =?utf-8?B?alpRRnpaR2xLRWNOcG5DN05HRWVRdS9aNmNNbERQOGYzTHNvcWxobzhvZGR3?=
 =?utf-8?B?MzlLTjdXV0pvdktZWEVScUVDZXZGak1RcXE3SW5qQko5bGI0M0VuWFQxYS9a?=
 =?utf-8?B?RlZXQnd0Zk1tTGV0TGFOU09YNC9IUWVnWk1TVXg0NTRTNlM2S0F6TE5mMFNu?=
 =?utf-8?B?VlNtZE9UMlRBNTJOOXRvdEdTNXJxSzJ4VjdudHFvQ01nZEFLaU9lVlFlTGhF?=
 =?utf-8?B?K0JBeWlHK08xUnk1OHJtajJVZ1lIYnVFUVNzWEtzYWFMamh3enE3Yk53dUM0?=
 =?utf-8?B?MmVINitIVTg0R1RYUlc4cmVEYW1aazN4Skd1MGorbCs4bXdKa25ZQ2tkckFv?=
 =?utf-8?B?WmFOVmF2TEM5YkRBaThIS1hmWjh3TnVIeElZR1ZZU0tlbStiTllDczdtVlo0?=
 =?utf-8?B?KzNqTmZHYTJMNWlTdkJuYW8yMUt0dC9vbURiZGs5NEZRSVJkdzRXNDEyUDdt?=
 =?utf-8?B?aDI3dDJCZ08xTlRwVW13b3pFT05tc1FTSC96enp4M1g0czRuOEdoaGFUYm9T?=
 =?utf-8?B?U0EvYjk5ZkhSQitZekFWM3dqUWtnOGhQZXM3NnNCNlhQam9zMFh5L3B1bG1V?=
 =?utf-8?B?RlZ1Nmtja2RaZk82MTJ4RS94T1E1TFNIZjJCNTlLUU9aN1c1Q3NQK1hwSTRO?=
 =?utf-8?B?WVE2OEtwbDRLdlBLaFloZDE4VTdzMkxXSzFxeEFVZzVjM3l0Z2NuRlBjekhD?=
 =?utf-8?B?OUFta09TMFM2MExYd2hyV2I1ZDVTZGl2TFZFVTI3UVRGQWFSQXk0WkRhMTVQ?=
 =?utf-8?B?QUYzbk85SXU5WWN0aDk3TkpWMURSRGhmSHAzRFl3VzRNdVJ4ZWxZTFNVbWJj?=
 =?utf-8?B?RG1IQ0pmOTl4am1Id28rWlhRZVJYOUpTcnNIYWwvOGl4T1pOWlA1bzZrS3hz?=
 =?utf-8?B?anhTaE5lNTRlVTh1VlRCQUM0ZlpJVU5oQTBadlBhb3N4MnZrRkk5Tk45U3k3?=
 =?utf-8?B?Wm5hWHJMTHZQc25hQjFKWTFvUURDbEtORU9zOUx0RmZFNVpLWFVEQjBiRmd1?=
 =?utf-8?Q?RDvttvAERkHHM4L8WVm3UXFX5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wpnfxAzmzvZC/KqpDz2A2Fb3H6h22YU9w0RELtx7Fu+o6C9exh3PUmno+N+AlouBBYGyGrUl/xS6uh6aMF1q0FLmYk49ylAkrDZMKObhiZ1vd3DMtkP//gEb7SYBkv0X9T7Xcd8MFCOzF+YLTy8+G0mJt9zFZZrK4X06+SoE+bJsXy0f3HMrO+J8gZydkfYXVkN+Bu+Rrq9HIJBtMqsbkhDM8Iyy3foj6sT5hDhw+cP4rd744lkNkW7m27s3S/RAb69VZ0p1s/4SkXCVx5habZwAx6DyPYih9e3jk38OqjY8/ZpYiOaIUqZbnET6MuFI6u9nHJoHKz9crIrAqNXCoDY5vexQeYe8E6Pz3GICnant/cyqrizDBJvKlpfaPtppTF07yoFUMBIAnQJ5kn1sF4yC51U/7uXBX59pul/NoXRB8ZSPGJ5ufWR8iRgdbRPGYLtG/ENKG/8p8u9uIm8ffiubZd+0sxEJDlZ2gI/QkXpQk+rNngcOudP154NPMFQ8nV1JiR7YGCM6u7a3B+mC4yAN5ySNOjjGNNRULnmWyoz13oKZaCblCFZes7Zp4AI7Ah3g42gW26Y4OelxFETvybShhKJYxw7lVxj5WTe22ro=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4178407b-bc67-4bd8-b4be-08dd1ac8356f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 16:15:35.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMCN6wHJKDAKHw8gHcagX9gTQ/8V33lKJ7a6FDueb6lANXdlI/W5aBUW/kO9PV4l90zxctW7HBbfi6y+pZf3Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120117
X-Proofpoint-ORIG-GUID: PzQmzm0GO6RKoLnHvJhkcf-wtk8v0heb
X-Proofpoint-GUID: PzQmzm0GO6RKoLnHvJhkcf-wtk8v0heb

Hi -

An NFSD page allocation on v6.1.y is triggering OOM-killer. The reporter
has provided a lot of detail, and we need some help steering us towards
the possible leak culprit. Any takers?

(We've asked the reporter to reproduce on a more recent kernel if
possible).

-------- Forwarded Message --------
Subject: Re: Possible memory leak on nfsd
Date: Thu, 12 Dec 2024 16:00:17 +0000
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
To: jlayton@kernel.org, linux-nfs@vger.kernel.org, trondmy@kernel.org, 
cel@kernel.org, anna@kernel.org

Chuck Lever writes via Kernel.org Bugzilla:

 From attachment 307290:

[29924.805968] 
oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0-1,global_oom,task_memcg=/user.slice/user-0.slice/user@0.service/init.scope,task=(sd-pam),pid=4503,uid=0
[29924.805991] Out of memory: Killed process 4503 ((sd-pam)) 
total-vm:173972kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB, UID:0 
pgtables:96kB oom_score_adj:100
[29925.425864] nfsd invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), 
order=0, oom_score_adj=0
[29925.425872] CPU: 0 PID: 1874 Comm: nfsd Kdump: loaded Tainted: G 
       E      6.1.119-1.el9.elrepo.x86_64 #1
[29925.425875] Hardware name: Dell Inc. PowerEdge R740/0923K0, BIOS 
2.22.2 09/12/2024
[29925.425877] Call Trace:
[29925.425880]  <TASK>
[29925.425885]  dump_stack_lvl+0x45/0x5e
[29925.425893]  dump_header+0x4a/0x213
[29925.425897]  oom_kill_process.cold+0xb/0x10
[29925.425901]  out_of_memory+0xed/0x2e0
[29925.425906]  __alloc_pages_slowpath.constprop.0+0x707/0x9d0
[29925.425916]  __alloc_pages+0x35d/0x370
[29925.425921]  __alloc_pages_bulk+0x3e5/0x680
[29925.425927]  svc_alloc_arg+0x81/0x1f0 [sunrpc]
[29925.425991]  svc_recv+0x1f/0x190 [sunrpc]
[29925.426043]  ? nfsd_inet6addr_event+0x110/0x110 [nfsd]
[29925.426080]  nfsd+0x87/0xc0 [nfsd]
[29925.426113]  kthread+0xe5/0x110
[29925.426118]  ? kthread_complete_and_exit+0x20/0x20
[29925.426122]  ret_from_fork+0x1f/0x30
[29925.426129]  </TASK>

NFSD is triggering the OOM killer because it frequently allocates up to 
256 pages at a time to fill the send and receive buffers. It is not 
necessarily the source of a leak.

The bulk page allocator is on the slow path here, suggesting there 
weren't any free pages available on the lists it normally checks first. 
So it is doing one-at-a-time order-0 allocations, a sign that memory is 
short.

We see that Node 1 appears to be short on free memory, but the system 
has not pushed into swap at all. Kernel memory isn't swappable, so 
whatever is leaking is in the kernel proper.

The slab caches all look reasonably sized, so not likely a slab leak.

At this point we would want someone with some MM expertise to come in 
and help us nail down the leak.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219535#c13
You can reply to this message to join the discussion.

-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


