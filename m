Return-Path: <linux-nfs+bounces-14234-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B01CB51C5D
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 17:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5B4D7AB671
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8286224BBE4;
	Wed, 10 Sep 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oZvPk3W3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RWlgZsOV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5E263F32
	for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519280; cv=fail; b=AzD1AbyVWxXqZo09Dg7KfSXS1YuYPrgjGU9xDSY3TPVz2+0qdLUq76++yxW9VSaEHeH5g+UuMQt+af7Kx0k/qUZJXTe8Sc/01Dfajfp0k39ip013TZqNRcjpncwN2ssf1PM6fPHziSH9KI0NZUk0nFNcTqLcFX/nN8qK+yvxBNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519280; c=relaxed/simple;
	bh=QHsMXIipz9jKbJ55Zr8c8vvqzTSaRMPbg13lACEbrZk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Puktqza8gDtRzu0ZyJvOPx/9GZtoDyt2OS3NGVsZoRp3TaQEyv+m0tOafKMeU4rCQo/wWxBQERdXANX7vTfpJnpmDnxTavoZZZFkUhRHQ+InO8rsE9BAloZE1yBPqhHsatIEcz5n21nHGW4xhYdKY5DbCXEXbcGNxQ0SH1SULyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oZvPk3W3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RWlgZsOV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ADBph6031986;
	Wed, 10 Sep 2025 15:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HPph4nH8pvg00BGMMXvYdPlTZcSM5WlWg8zYerWKisg=; b=
	oZvPk3W33jrxUKGjTSQDTieF5x6XgHqFz5i4pjX7l71mmd1J9QDJfSIzoSnMSdnO
	zCBKKh70S1I37PIC4ZsE70OSEsLDpAULXEEwQ48CRQn8SesA0iUUxdKJoB30LUYq
	kVJlkNDZCWGTMuPiF9s22005aMZB4vTpoWLZbS/kFdnoGCmjOfPyoVYZyEgv7715
	URnuF6UF08HmdYMt9peOizgk50TPBY/2/5eRGePTglahJZRPBcUTHRWGS4UDbm58
	D1LtkQvfX9Bp8PSMwTMxiBhDWZ/FFLOvurfttyTTAEh+W1McmZcwGKjMRicuRi7I
	C/lEIdLqtzpBYzs3utXQAA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226svffx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 15:47:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AEqCeI038750;
	Wed, 10 Sep 2025 15:47:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdb6xm6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 15:47:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEtm1ZWgM2fnRri+PNgosiAERN/KHYWApAHFC5QMyBrtDejxcH93HRNvhsTb9dG7YvUKVvIqlLsLCwB+TKMprJGRg8MEGQhq/7sFrCMYcsCSy3rKUADY47+BnUr6TKyJ0BmxOiaInMjytUQulEXIvTp07uc3MTdf04u9SzfzzRQkfEYIOrG1207jbRnNXqBlBDtUr8csqIlXgciylNCDfWTXFV1QOjgptVCElzH4XdykC4PfP8XCg5Rw9sIVtXInEexWVVHeazz4SjOgGY3ZqVtlHvCBvTaLChvBjnMhWEzLw8gm4hpJDyZXTIRFrFTJ7hRYG6VyLV8LDTb0oliZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPph4nH8pvg00BGMMXvYdPlTZcSM5WlWg8zYerWKisg=;
 b=GYH/v4oz92IUvlVZMScEGjFFsqtZMkXzoPnfCtvHuJmHkYj5TLEdKDTi/iUYawFQ3nhQcDEdLIv9nxV5xty9rkFQUAMQpByLSVSj26mHf3wz5Sz/u2ESQjBcpwp7CINFcowcFjj55mcaLr5DC3/PggZSk0xAGYBvMr0ST1EcTswYTLCism1fwKA+dj2elvoTkFhdErHjwj2oUwkRnDdYSW6gPDnrNwjeAkSjFdNkuiJmaXIS17Tq+ubyB7PR5L8n6HgD0rxLBKjiZ+N/ITh4mAHuA9xXFFQAC1gfRs0cbSweJb6XaEDHcNl0DanGp8NR9Gb+h17XsSMEFsXCxr8ykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPph4nH8pvg00BGMMXvYdPlTZcSM5WlWg8zYerWKisg=;
 b=RWlgZsOVq/UepVSBlugfLFuWrLw/NueGeTFX1KZXaM2bxAh892s/VvCF7DnZxGHXpQPoyA22e11f1gmCz6mYcFComtHsvOcxifHCf3VygwOA7/g7UWr2y688adMg1p3spfCZv9uePjVj8LkZapUXzm2cUPPBMioHtQA/P/U05Ro=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4206.namprd10.prod.outlook.com (2603:10b6:208:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:47:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:47:32 +0000
Message-ID: <6519e2dd-a0be-4e85-9ece-758176bdd644@oracle.com>
Date: Wed, 10 Sep 2025 11:47:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] NFSD: Define actions for the new time_deleg FATTR4
 attributes
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, rtm@csail.mit.edu
References: <20250910152936.12198-1-cel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250910152936.12198-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d83bd3f-de5b-4ffa-bbce-08ddf0815aae
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?a2w4WFdNaHBZRlR0SXBSQWJRRFhpaHFOUElWbzA3TzY4a0g0YVAzZEQ3SHdk?=
 =?utf-8?B?a3JNaUJ5Sk9tTk12aGNYNThHUUdVV3prTnIzNnFXcG1GUHBCMnNtQXRWUXNj?=
 =?utf-8?B?ZklzK3JyL3h2MnEwWkQ5OWMrYy9WWS9Sczd5UWM2REFQOXlVL0E2QUNDbW5h?=
 =?utf-8?B?VTZYUStobkFWd2lJdXFwaTlLNHVaYnlONi9obndpTVhNaEVNZE1zVHpaaGQv?=
 =?utf-8?B?Qlk1RkZmK1ZsYWN1SjRqZUdsRytpb2lwbUNsdFdiUzNwYk1VU1pJelJmSUZW?=
 =?utf-8?B?N3dmYi9aNHRocFpndGYrblVWOSs0QkNqd1EzbFByMVhUWm9JQS9TamZyNm5k?=
 =?utf-8?B?VTFEeFpyeVlteWZzQXovMUtGS1I4RWhrMjZWbTlKcFZHTU1vU2ZuR0FDd3F3?=
 =?utf-8?B?clJZaTBoYTFLd3pPbndaZkRIeHFOQnVtV1psOENxWVhpNWZHaXhDUFBMVXZi?=
 =?utf-8?B?dnNaeUF0a1BPbmRnUXVFeUE2eXM5bjNyR3JzNm5BdjlMbVBvSHhZRGtjOHFJ?=
 =?utf-8?B?TFlmckJxVWlXUlFOZnFLSVl1WGV2aGREQkgvbTdRWS9tdVBmUTlwQmtDa0ht?=
 =?utf-8?B?eTlBdCtjNFRpNi9tVWZ6RU0wZmluSEZBNzE1R3RHRkxNQ1hzcXFxaGFrZlpO?=
 =?utf-8?B?VGxGZjJsN0N2bWtNVWw0WmFxb1hpT1RWVk5tV0cvZS9iTTg1d3N5bTZuUTVK?=
 =?utf-8?B?cjUyK1l4NzdhVFBvaStPQzBGU0p6UXU0SlNVWFFUVVhmZGVLS1hqMXhtM1p4?=
 =?utf-8?B?T0ZyVW1UZGVWUkpqelh3UzRXSDRoSC9OWE1HcmI0N3p3ZVhCQ3M3eTEyVXV5?=
 =?utf-8?B?dkdLcnVuMEhDRjVQcnZTQkhrT2NzaVRlajNWUkFxZUZuS2lIYlhHM0VOWW9E?=
 =?utf-8?B?U3NYS2UzeHM5Y05ualpOcW41aE1iUjdJejVMekE2ZVpybW94VjFQL3RlaUl5?=
 =?utf-8?B?d3VxSXl6S3RNd2IzZEM0Q2lsODlWSVpNOElaRmptQXBZUlBVVERlL3BMTjRy?=
 =?utf-8?B?VGVwYVlNclU3TjVTaGdIZ3ZwZnJJLzZQYXcyUmFrQW4vRHJmOWcrMVNyN1M1?=
 =?utf-8?B?UmYrcDUrb0FtVVl6aitwNy9yT0xqTEI5THhUVkUwV3N4bmdDdDI4NUF6U0Rk?=
 =?utf-8?B?ZldJd21XY2ZNZWJpbGx1UXlPcElzTnhNUHBPR0VtK1B1UFlRZm5rbTRkY1BH?=
 =?utf-8?B?Wkcwc0E3Q0o0ZmY1eVQ0WS80S1Z2bmlBb2ZFVVhWQ2Z4bUNkaDFPYXNGa2Ev?=
 =?utf-8?B?V1VLWE9XQmNKS21tNE5SVVZlS0RpSVRIdjFOa0kvVEs5OEExbEJYMytZTTkv?=
 =?utf-8?B?dmxtamxiREtpNENUNytDaTVLeFVvQTlZdmNhc1VwYTRyeHZwTmlBeGV1REY4?=
 =?utf-8?B?dUcxTmdYYm13dEx3UXhaZGgyL0svR2lOM3g3Qmp1ckFqeWFmNS9abWNVQXpM?=
 =?utf-8?B?aC9TMkt5NTExUS9rMTNzQ3hPYVdpcU5HUWE5WFBpYjJhMm9WZGxHeVUvQ0NO?=
 =?utf-8?B?V1ZmVTBmMmdCa0JMc0dNL3hvS1R1L29KMWp1N1A0REZhVWpXSno3OS9LWkhC?=
 =?utf-8?B?MmdObkRJejYvblM1U2MySWYva243RDhkRzhFTkRFS1hCeWd3ZWtLbXF5QzlZ?=
 =?utf-8?B?QkUzNmg2dG9GL2RUTmhkcHIxTkt4WGphTGd0V0hFbmNPUmtXWVNMeHV2QXJy?=
 =?utf-8?B?MjRmL1pNUmlIL0FRUnRwaHJ4eUtRc2xydjByc3lMOVlHRFJUeTNJRi9yZmho?=
 =?utf-8?B?TDFwNHBWMGlnUDIzdUdacDBqcm14UmttRUt0UkxUcmNoQ0EzQ2dXTHdIWDVB?=
 =?utf-8?B?M3NRY3hyM3VEUit6UW93SlIwQ0MzSmJ1ZUZKcDhaUkFkUnVJcnQrK2FsbXRP?=
 =?utf-8?Q?E2CWyosTAP3XF?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QkNOMktUMGdiL2tPTVU2TjZua1VHUmtYaXhTY2RVUEMwSXJ5dHBsSlJ3L0M1?=
 =?utf-8?B?L3ZKMUtFZHVNMHBSSS9NcXlhbTloYjVlTlJ3SVhHMm1NMHgwTWE5VUFVM09u?=
 =?utf-8?B?eDluZXFqMURsdElsV0JTSUlHUmVJTVFMSFlCUDA3RFdEUlpueUF0VmxqUmla?=
 =?utf-8?B?Q09SZXQ4cmFVOW1FTDgvbVhIOVI2SkRFcVNCRlZoYm44WHV0cU9ZSUFtSTdy?=
 =?utf-8?B?dk9RYW1DZDhKd1ZZMkwyOS92OTZLVFhBOXk3ZHd6U29VN0hIWmljOUc2YkhT?=
 =?utf-8?B?SUlqUmU3SGhqOFc0anJ2QVVNd0tOQ0tRZm5ubVcreXVseSs4RkhBWk92SWJa?=
 =?utf-8?B?VWF2dGcwNnNwd2hpZU1lMHNiMXZrOUs5dkhRbG01bGJuY2hSNTFydXVGRFA2?=
 =?utf-8?B?NEtEVDN4TkJ4d1RxQUJYYlJQN2ZuMVFxajZhVTFES1lWUFV0SGdOUTV6TVlZ?=
 =?utf-8?B?WTdMbFVsdEZOaFc4QVhQbmZuSDhWTUw2T3lXWStwTmQ0anNNNkJkeEVhTGJw?=
 =?utf-8?B?VkNSY0tleWkvOExiaHpvdy9NZ0t0MkRhTmNSbjlrT25lQXJIQjdLc0R5YjZW?=
 =?utf-8?B?bGRtZmd5NzlxejNxcm56bGNNSTFoNXYzMDBsbTdLTkdzUGx2QUo4ZDkwWFRL?=
 =?utf-8?B?Mi9xTWJnbkZqMW5LNTd6cXF4U3dRSzFOc2E3UU5wVkFMUDBMbGpwL2loTFJD?=
 =?utf-8?B?ZzhRZm9xOGFpVmx2NUdFUktkdGdtYStoQVl0YXIxR3FPRCtjSURDWk13MXZk?=
 =?utf-8?B?OUZNMEJYY1dGb1UvUmRRUHJrTUdJSzJ3djJ3WEF1WWRZaHNjdEdlM08rdERC?=
 =?utf-8?B?MnkrbkdPVmVxbDFKa3FQNnl3Tk5xUlhQYVRVTkt1SEdRbnR3aEVZTHJ6eUFQ?=
 =?utf-8?B?K0lCa0psU1Erb0w4TEw0NUNlZGRLMWlyUlNTMnplQ3BYM0JrdkFuMHc5RXBr?=
 =?utf-8?B?VUxRbE9TRGx4aklFWW9QQ0orWWxWNzhTYU83Y05GMEN6STRJVnY5Zmozb1Ew?=
 =?utf-8?B?eTgyMDg2QUp1Z2JXK254TGFiZkthQlFsQ3RpbmtqdGZYU3JBMmU5bEtLUFpu?=
 =?utf-8?B?MlVtOUp2dmdyWUNIRXR4VDNQeHJLazNaZ1hpS1k0UFVTTzF0dCsySXZvck9H?=
 =?utf-8?B?elNtN1BPSHFBTEZ6Qjc5QSs4ZDlhbkY3YWVhNzBvNGtLMHZsWVJaWkwwdUtM?=
 =?utf-8?B?TnNXa3ZKTFRxNGMxcG5oVk1NdGhFakhSd0l6M21MNVpMUS9PTUxDQkVqNEtv?=
 =?utf-8?B?bFR3cEg5Y25vS2ZTUWhSNnZuZkc2VjN5TGZIbi9Fak45cjJqdDlPS0lTSk51?=
 =?utf-8?B?UlAzSCtiajMwWTRJc1BXdUp1b01FWE1DN0lZS0xYdkx2MjlaNU5xbUNHWHRN?=
 =?utf-8?B?NnF2bDArdGdlYmZtdnNFaVI5Zk54eUQ1VktGdUI1RGQzRklVNkdtM3VWMEgy?=
 =?utf-8?B?WFFXcXp0K2JIUVN3Q2lWek5sOVJOQUU4R0REMDU3UVRSd2JlNWpJQ2Nzc2R0?=
 =?utf-8?B?M0N2MkdFZDBaRmFJaGx4TjM1d3FCNFRhaldSeGlueHBHZ3dtWkJJZGFicE9H?=
 =?utf-8?B?b21EcG1DdkQ5Tk5XdEhYWm51Q0JLc3lOWkhIanpnUDBiWXdYQzJaVjR6SHBV?=
 =?utf-8?B?S3hubzFvSDJWTDBzK0VIU2k5YlBhN3YxUFl5NjI2ZnNxMy90R0hTaFJQTXY2?=
 =?utf-8?B?Z2JKeW9lNE9aSlhmTTBxcHpuRysvQlhFSG9UZGROdkVtVVhXcitKVWxDZ3FD?=
 =?utf-8?B?WUFiY2pwbUNtRnQzNHRVbXZDdVQ2SUc0YSt3ek50M1NuZEZnTDlLUU5PTFpy?=
 =?utf-8?B?aU5wMzV4WW1PVUhSa3VJWXdlc01BTlRTekpMOVJENXNqNkw5b2RMRm1jd05V?=
 =?utf-8?B?clhJbzVMMFdqUFhzM09iSHV0NWFFTEZUY24zRG5DRjc3aVVWc2JoRElsOVhD?=
 =?utf-8?B?MFNGTkJvcXhoUHhLRDVZMjNwekN0NmRCbFI1RWZhWHRsaHpNZ1BSYmZwZDVh?=
 =?utf-8?B?Yko3MXA4eC9WelJrcTdnOW9pTmJWajEyRjFxbElxSEMxaXM4NlRoMS9PdVY2?=
 =?utf-8?B?VmdFWng5aTh4SmgrOG1kdmtzY3JNdktTdHlvOUhUODB1bW94dE56UVlUeEJL?=
 =?utf-8?Q?iBqUoNBJZuspORGcNjLZ/194c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/yIBfgT4zGJRUjiuotLvIhmY2BZYS7s6WO5VpWck2ky1v5gorYBJRhRACSijbaqWdRtlvdzhCMHD7KV/CtKb4eZ0YwWJ3xC3UlIFEmjJHpWSDzMC/QtjrQZaQ9KQf0zAKTbw6Sgp3i5PiTfYRgZ8B5pmhco5y3bWRSUb1+b+Lw7VF0ATKLLXB50lF7U9CcIgurCJxFEt8lnm2QSb0C47wCNUDubjCD0wsHAOs9Cia6fDeIozpyRLQLO/I8kzHnjDndggi9Qp++LYWmhoR5SmkpNqip9SyZrpm+srQYI8tTxED+/5r2wbcXf2uIjqXEdPhO6hT8uoxub/kra8poFrC5pjzUZFTalrYthmgpXWjKNinhx4WqEHNDdw5GqSY8z2vsvxvkFTsgDbz+K6s/RasUwSORT8rwD6P6q2Asu/A/ttRLPem36RzoUp9YYzxCbVjiDEiBTaJMe6hb1znNRi0iMPtedJuvLhokvNgenELbExx1Tf4CVsvEId+9b1wlJTofKTFFIe57ZJwwt24Gh+6HVWbm4xwPt8Itwc9eFTcJomjU+4hUrXct9riz0mkUXRWLPwqnpFv9MWUa7oFfhcjJcghy5bVM8eeIOS0nKvLKo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d83bd3f-de5b-4ffa-bbce-08ddf0815aae
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:47:32.7394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxlTabx6GJ50c/O+mDjlj1PcqsK3UHJdc3CzcImNjaljrvVLdh9q7fAsogf0zXAsONQ79vECTtLdQSYZIIptjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100146
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c19d99 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=rMHZXbuc-i24VTuCa7MA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-ORIG-GUID: HW6un2RJ3L1Z4HLzJCs2B_5AbXCi0ztN
X-Proofpoint-GUID: HW6un2RJ3L1Z4HLzJCs2B_5AbXCi0ztN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX34tnesuVLSKl
 pZLGwpGy0q41VN+B2W5+8O346d9x25wuqLGRS/h0NIpPX1JvcwtseQSRBuKpjNRclgknRL773Ja
 Tzt/M+dMBv0qRZZoaUOAKgj4P3rF9yjZKZupABM4SRaeRNn+PjSOBxpJNR83j0xZEsm/ozTCUFd
 XYkqCrDcNO4T819Wr7Fc8i9ENmNtz8PqA1g+CF+gMtgN3R+3/iS6ngqQpgqsqdzgaKhTzKDr9cd
 TPDy5vKXhSNEflxcZTnaL0PV8mLSgx0ZVSWe0t0C55WwVNFduSMv2mlKLl+UFDTB4Nxwq0Wy4dL
 toqfXZCNQvPOw6vh3g2V1+qo5knteu3DKYs6+fOcbo/j7zvn1oF4YBULrq5Ic0TeAhjAFJ/iebv
 7xeXj0CPaAdiUzPqGCG83P8rbFsz2g==

On 9/10/25 11:29 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> NFSv4 clients won't send legitimate GETATTR requests for these new
> attributes because they are intended to be used only with CB_GETATTR.
> But NFSD has to do something besides crashing if it ever sees such
> a request. The correct thing to do is ignore them.
> 
> Reported-by: rtm@csail.mit.edu
> Closes: https://lore.kernel.org/linux-nfs/7819419cf0cb50d8130dc6b747765d2b8febc88a.camel@kernel.org/T/#t

Fixes: 51c0d4f7e317 ("nfsd: add support for FATTR4_OPEN_ARGUMENTS")
Cc: stable@vger.kernel.org


> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> Compile-tested only.
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c0a3c6a7c8bb..97e9e9afa80a 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3560,6 +3560,8 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
>  
>  	[FATTR4_MODE_UMASK]		= nfsd4_encode_fattr4__noop,
>  	[FATTR4_XATTR_SUPPORT]		= nfsd4_encode_fattr4_xattr_support,
> +	[FATTR4_TIME_DELEG_ACCESS]	= nfsd4_encode_fattr4__noop,
> +	[FATTR4_TIME_DELEG_MODIFY]	= nfsd4_encode_fattr4__noop,
>  	[FATTR4_OPEN_ARGUMENTS]		= nfsd4_encode_fattr4_open_arguments,
>  };
>  


-- 
Chuck Lever

