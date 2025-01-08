Return-Path: <linux-nfs+bounces-8982-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD983A066AD
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91375167FD2
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 20:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7F1ACEDC;
	Wed,  8 Jan 2025 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nyWGyGKz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="puSyaQiX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CF20408D
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369802; cv=fail; b=F83PovH8YD3g3wigczF8yPLRQsw5Qxj6nQprAOTCwQoMUqObfboRX/E0EeF6A8Q/uCgZ26MgrUR+Qga5NJdvRBZ1s39ECG1H8VxdKjzabKwwTlE/Fzf/5eFc/T8ZTuRmqypLqm+bHWAy/M6i/Kg0AOlTBle4kjij9JLRQlskjOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369802; c=relaxed/simple;
	bh=EZINeMLSHx/50K2KehsKYGFVlbtxGq4cPoi9c9XvHaY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HBMv+qr4wubZ83yQ/prnQiptF8DfJw9d7H8s7xgxOXc3qtbMIncHTYKKAOQH3vXCzLr9aIpx4ai//beKx7l7tHLKMrQvgQPRBGG7DdmVU8pqI9RYoKJTPcWd7xLV1qWrfmduhWMKPc7gGBsPm4wua45GwuGwYddg+k4l8DRtXRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nyWGyGKz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=puSyaQiX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508IMquf032508;
	Wed, 8 Jan 2025 20:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=T18a0S9XI3J6a8Hyj2XGbo7ZP/2f3oawEMTiQ6u6DyA=; b=
	nyWGyGKzwtq3d6c/7SH+04o3pbloyWGrDTKcXckgz+ZKcTt3nIxOLJIGxY60NoRI
	7hvOV+tvIL9ZRxI32Bnw+Bsg8c0QRkPropwlyn7tgl4qK4fl3tdg6pGKCvilzEUq
	Yqpa2HmLFgLit+w8QLxw5T2pXHvx7wBCrRuJZxUbDuCjvN4Z9zZah67bUwejFQxs
	Dk3c+uPJyYA/tVt/1LDOTh6PU+Nmw0JKhG8NE4mk9rLd7wpCfnA+rLYHjRwfWbux
	1bvrnTAvVi3+Ll7yvits4j6Dx1czkkCGcSpqVSf/sDGV/bzzxmFXrHxb4CZLG/zn
	4O1nna7gFOz3M8ItXcCHbg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xw1byjtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 20:56:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508Iv1wV004868;
	Wed, 8 Jan 2025 20:56:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea8y37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 20:56:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRQF538sgfYNjk3ZuOU0sNvG55jseShuMhZYqXLKAeKSZR/jVHedVPrWkwj5bR1TcQpDEWohlENAW2lkQw4GsvyBn3U5sNUmnoYNI2laDL2LRv7wc7THb/Wgw0YochtR/M4sGFmRvbO8Z0t9rEC7u0HaFPSGXz5AAMrXHwQHScVi0BV0HPkOUZGzN6wOVrkj7NEX9Ok3/V/OoXXQApppjZRCX/f5tTeE0pz8yQkvnpWd3yCRl7x2pO8V/UCzIssKGZw0tgttKRzWaEF4GKhwIeuSZfYK7ucSvG6fPASl3atcI3cVVpgzWfQh8biqcMUbWl3xRoqnTXKZMiGaFdhdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T18a0S9XI3J6a8Hyj2XGbo7ZP/2f3oawEMTiQ6u6DyA=;
 b=lXHIQihj3p3FJ7Mjq/CJKya3ZUYAd6H6Y2x5OOyt+9enYgBd7lbeU1B3Qu59HpZRHihWYNZBXoMmyFvBGptwSIfPVp3GXOHosX86dFeKv9/0obgV/Ka+GHW3SlOhk8JfaZfE3vShBjMDC9YnAF3+wSjqM4pjQZ7HJL84e/v92f7j8gR3IMi6p24tXg/GNc6gr9wqIjogTxNtyUwm8r478kE5cd8oF2/kWsJPO9hEQsghkD+SN34tX2rX2nuYliQLgngTSYSkLuvhtCqfrB6lzJYgAeCpT/duNszOzEXfC6sqc3GV4HT4esTmPvoe6xjGCJpp+/3b6bVTOChzGPPhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T18a0S9XI3J6a8Hyj2XGbo7ZP/2f3oawEMTiQ6u6DyA=;
 b=puSyaQiXGhNnGhjwYX6pBjY/5B1UTBv4ZXK7pBzSuDM23BoumPOkPvFgB0RYIdcfrT0Jsv1D130OU24zoQ3khyfqwWKiVSRo+bpRhng9RFkSJKhjhTPwtD9+QI6LgF9EQsFfUeCi5sEb4A8gxq0NXTuepB6N80o9UKh4AVCjb+o=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by MN6PR10MB8023.namprd10.prod.outlook.com (2603:10b6:208:4fb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 20:56:29 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%4]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 20:56:29 +0000
Message-ID: <622e4634-e7d3-4f8d-af45-7178a4e6675d@oracle.com>
Date: Wed, 8 Jan 2025 15:56:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [for-6.13 PATCH v3 00/14] nfs/nfsd: improvements for LOCALIO
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-nfs@vger.kernel.org
References: <20241116014106.25456-1-snitzer@kernel.org>
 <754757a44ac96f894c82338ec3212cf7202d540a.camel@kernel.org>
 <Z0E-e7p5FtWWVKeV@kernel.org> <Z2MG3X_PpbJRNzCw@kernel.org>
 <f0d7f601-a6ac-40d6-9665-e9a40e2dc00c@oracle.com>
 <23bc5e70-9d7a-4185-9645-0ba89cd43de0@oracle.com>
 <Z2M8blaSYonRmDYT@kernel.org> <Z36iY7nJT5ngLddS@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z36iY7nJT5ngLddS@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:610:51::33) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|MN6PR10MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f1ac9a-9288-4251-7db6-08dd3026ec8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXRTQlVuZkQ1em1sNm1YSEZuWkFIWFdwU3FZQkpDYWhvbFZFa2hRL3kvcHdF?=
 =?utf-8?B?QUhJMGJQVitUYy81bjBqNGFBTGxBNmwzRGxjeCtMWkdXUWZybHg2Z2NaVG0v?=
 =?utf-8?B?aUNLeHJMRi9lSDR1M0dCQ3g2VzIvdlQ5dUdqVGgxQnZvbldDMFp0a1hFb2M3?=
 =?utf-8?B?RkU3dVl1Uk5JN3EvVlBMaWM3K0RYOWFVUkk1dVltTGFkRzI5eit1UmtHQzhO?=
 =?utf-8?B?cEh4SHA3R2s2QUxSaE14OXBUbVEzYUVNMlJXWFFBTytiMGhtWlBBTjlpU01R?=
 =?utf-8?B?eDBpOHUxM09WTjdaLy9iQnJQRmdMRXpZN3RGYVo1TWFNRUJzRXNYUHkyZlBM?=
 =?utf-8?B?UkQvTERwNVJKQkdpamxHL0NyeEpPSnFwb2xDcENxZEY2SG5IK3F2S0UzblBX?=
 =?utf-8?B?SWd5K3kySFVKQXoxb2VDTStvd1RDakZnbGRxdEJvZm14SkRyVm1KeVhkTTVM?=
 =?utf-8?B?YzZJT09LdG1KSmlKT2VsT3c1QU94enpHVFI3M0x1bVJUNzJmUG9VWTBBTFdK?=
 =?utf-8?B?dVExc1FncGs2WUw3RHphWldSOUNBdXlxcDNGWEpHSWNEOWhEQmtuZnRSalQx?=
 =?utf-8?B?SGhaZ05Bb3BjQzZWWHRJZmJwaXM5d0o1S3BYUDhjRnJ1bFh3MUJEYUhOYlhO?=
 =?utf-8?B?ZmppdE9vQjg3NmhvMnFTdVFwTGVMMHZYRzBwaGw1bU1EeEo5VUc1M1pPTDdD?=
 =?utf-8?B?N0VUd0xTRVlINTdnYnRVbTc3d2ZYS0Y2M2E0WHZqeVl4cThQUG1GQTYwUndl?=
 =?utf-8?B?S29lcWpkL24yaFpia3IxbXZjSkhheUU3WVFjN0E3QTNwTmVvcHpGd3dwbUpJ?=
 =?utf-8?B?Z1I0NE1KVHRZSmxlM01GQmNabHlFZEk1L2RsUThlVkdSdi90ZzRCUWtVVnZ0?=
 =?utf-8?B?YjMrcU00Sk1BNS9rdko2K3ZWQ283R2YxbytuQm0zNjIwZWlJdGIrVFhaNVBR?=
 =?utf-8?B?VWtIQjFNMTJKUjJQdzFTaGZpL3NzS2ZjVmpLUzZ4QWVkUzVjTFEzZ3ZOZWo3?=
 =?utf-8?B?L1duU2FSSjI2RXlZYjZzQk1JWHQyMzNid1l2b0hNdGE3WVFkVkJFbHZ5T3RP?=
 =?utf-8?B?YmEwRGF4eDNFS0RJdHlOaExUdCtocUhaSVJXaUxkZFRBcVVrbGJDRFNuTmNC?=
 =?utf-8?B?WDUxcURnSEk1enJ5c2xGa1BpV25WdXJWOXBDN2VaMHY3U1lUNzFoY2F2a1JE?=
 =?utf-8?B?M21kRHFwQnBWcUg5di9hUVVpWDB4RUozeFdrOU5CUklDSGE0WjJzbFI4KzFk?=
 =?utf-8?B?RGlsMERoNlVUMFVQckZxODQ1OHBrS0phejVUK1Mza2tibEdxaFl2NXVMeHlG?=
 =?utf-8?B?bWtsTGF4b055QkswUWNJV0FHNkkvUTVjdXIyeVhjMU00ZkYzZnpXZ2tSRmhz?=
 =?utf-8?B?ZTlFZ0drbzZqY203VHJ4L1czSVFJWWpYMXE1enYyQTlZbUpQdVp2bnJnTWhx?=
 =?utf-8?B?ZVdqMElnVzEvbk8zczJwVVhaelBjNExsM2d1d282RFp6OHZvZk5mRFg5d0pV?=
 =?utf-8?B?TTd6Nk5hREJLUHRMTVFYdWwzUjhSOEdKSDhmMUpEVEZybER3V1F0dHRaVitq?=
 =?utf-8?B?U1phZm11dHhFaTFBYVBDQXZzcnBuVi9TK0JVOWwrWGVsaHlIcjN2MHRwdHRD?=
 =?utf-8?B?QitUVTc2Z1B4dk5QWXBTSHFxM2Z0aFF2L05JbXBndzFTOWJ5Q3BFTUZQS0JW?=
 =?utf-8?B?M3FadWE2L3NTclkrbjl3WFVQN1Bsai9VbDFOWG1DOTBqai9QZ2ZaZkpIYTVB?=
 =?utf-8?B?aUFJZ2dSYm5zdEwrZng3OTdMODVreHNQZHV5L1FJQU0rclpKaUVkNkVMWTVQ?=
 =?utf-8?B?UlZ2SHBONm5zSkwvS2FxelE2SWNWc0FrTkVEVHpUaE1iTWVIMG5JY2hqTU16?=
 =?utf-8?B?UDh1a3VlNEhWeHF5VWY0TXhDdTJLdUJ5UEFFeVpPcFJFNWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHZCazhadlJUTERaYUNpSHNmYW84Sy9jcld2U3EyeHpkbHl0SWVWMElyQW00?=
 =?utf-8?B?d0FzUTBaTkgrd05tZ21uRm1ZQlVMeG96VzY5NEIwcFA0ZjZPT2YwTk1yNUlH?=
 =?utf-8?B?MXkzYzNNRU5aczB3b3lPM2FCTjdVSUszeXNwbGdMaFEzNGtLSTJXZmtEeTV1?=
 =?utf-8?B?UXMzTWpwRnp5bVZFcXpFdHIyNCsyQ0VLSGFqcjB5U3FvTFlNS1pCZEYzRXZo?=
 =?utf-8?B?V0FCVFp5ODFlZ2s1UDVDQ1NmN3ZVc0Nib2dORTZlSnZxL0dVMm5RWm9OUjVD?=
 =?utf-8?B?ejFrVDZGdkZSc0RpYURtQ2NyTUJyc0JSSWpXK0twZFI0WUt1ek5IQXB5SENV?=
 =?utf-8?B?K2piNEsydXJ3bXlDTTlGRXU2RWJLd0JibnRQYktBOWJqdWhYM1VjWmc2ckZr?=
 =?utf-8?B?ZUlDdWVjcHhlbjZXZEh1akl2TjRXNmYxMVN3bDlJSkhHZi9VdWYrbVVPOFY1?=
 =?utf-8?B?MURSd3BmdVEvLzkyQUZtOUtXcUt5VW9PQU85YUNML1FQQ1E2VVZEZGxPbkM2?=
 =?utf-8?B?czQ4aXdGS0xTNXlCWjViR2RZTzFVcm10OG5kRkVZcytaQktZZWNKOWhUSjdY?=
 =?utf-8?B?TFRIbTA5Y1N2WDBLakY1UnlBZUFVaFNuMmtYVk1GYUQ2eDJBcTdxUFF4ZVlm?=
 =?utf-8?B?WG9jVTMzcTVNSTc4WC9zOEtGclVIcjBoL25kYnBaTmxZVXNOZDNxaExhYUM0?=
 =?utf-8?B?ekdiaksvTWNoVFE0b3RzVmRJSU1IYUVoSW13UEZhQkYwa3dpMjl2dWFEUURV?=
 =?utf-8?B?QXcvZ1lNYjR1K0pXbXRVWGhBVk05SFNFN1pVMEhUcUlMTzFjQkNRai9SZExL?=
 =?utf-8?B?Unh6L3RLWUNPdnFGempMMzdmdjVaSXRLQmlGV2pZOThmcDducUlid0FSMysr?=
 =?utf-8?B?bkk5NVhLaGhsZDBrSWp2YklrK040dC9ZamRlSk9XdVByOHB5UG51eXpqSW8v?=
 =?utf-8?B?RFV5dG56UjhBby9XUjArRzNKT0VNRnRtYnFYNVo5aW9YWVNVbDUrWUFYM01n?=
 =?utf-8?B?VnhuVVhFRFJHbFRHNm5ERks4NTlpLzdSek1xQm43dXRKNWFjV1VUM0hjYVRw?=
 =?utf-8?B?cE95OXZDdUc1UHdHdG01b0Q0MmhJaHl1NStUVUlMVUdISjVMenZXUTBGTWtj?=
 =?utf-8?B?T21LNkZWYnpJbHN3MHYrNURFS2lYQSs5bk5vVnMzZWFDVitUc2xMbkhyNVBR?=
 =?utf-8?B?OGdNd21KR1RHK0I5NE5wWVQ5Rm50Mkx4dWZkdnZLdEVPc0dHTlNmeVF0NXdH?=
 =?utf-8?B?Q1B0dHVCSXpEUUhSQlBBR3dqMFowZEYyd2UzelBTYjBYT0F6YUpsL21Ra3N0?=
 =?utf-8?B?WkxRaWpvZmxTTVNpU0ZORlpGZGtRL09LQ1VSN0dLbVg0L3dpbUtSdm9qaVNo?=
 =?utf-8?B?ZzJDZjFwT1orS0c2emdjVG43M1cxNkt2OEx0YTJVWFNXeVdxMXA2NzF2Ri80?=
 =?utf-8?B?Yzg1WG9aSk93U2RTZFBMMEhXUHdLbHlib2RrQjZrUmlYOC8rWmRkb25GdXQ0?=
 =?utf-8?B?cVFxdmxsckNnSk1Kd1l6QzZoZFQ5aWw5Yk9jM0h0VXV1b3F5WDJ5REgwTFh6?=
 =?utf-8?B?U0ZGVGw5Y01PdVVhS1p2RWFqVXBRcTg5MWN3T09aczdUc3JJTlhVRFd5RlBY?=
 =?utf-8?B?UjlzRUFjQUkvWCtjbWVPRlZFNTdKSmNpTWxMcHBqalNpNVk5WWVlOWM3azdn?=
 =?utf-8?B?Y0I0WlovczVwRXJYR3drTXBDTGJHVllocHgwckVJOEQ0VWw2dDBxQTU3a1dq?=
 =?utf-8?B?ZGVWNUVic3o4NERaVmpQbmM3RUt4Ry9VZHZYaEUvQStBSHN2Vmd1UnlhaFhq?=
 =?utf-8?B?RXpZOXRTNjh5ME5zcnYxRUhRT1VleVFKTXVMWUoxVzRjUmZaVWJ2TzFQVzI3?=
 =?utf-8?B?bTB2MUp5YlRGamFJci9od3NoekJwSmRJR2xmSVVKWk5IRVRMaVBOalNPYXY1?=
 =?utf-8?B?M2tMZG1PcHN5WUY4QW9yQUwzaFlFZzlGY3VaWUozM1NvaUM5b2QwQjFSdGY0?=
 =?utf-8?B?U2gzT2d5S0NnSE01N2FVb2NmOENaWEtLbVJBY1VqT3pyamZLbnpYZWJKMVE3?=
 =?utf-8?B?akxEZFBhYmYzcHhuazVJVEpYK1U1ZExGZG9ZUWVuNk1OdkRUUnAvTDMwMndC?=
 =?utf-8?B?czUrdnNtTXNMYUtncllCaGFQZTkyU2xPNml0L2d3TjVVRjlLNFFwdVkrR0ZJ?=
 =?utf-8?B?bzBYem9oVjdVVm5seDJTSWZPQVFBcVNValB6ZDhzZmlnNkh4T283aU1ZYzlV?=
 =?utf-8?B?TUE5VDZKcEI0ZjRvakxqRkYyMkh3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FIi0NS+8jtCnOdj11BS4EyJHwSfJfyPBuJ34uqkAeVTQJlFFOfYldDEmXb89W/tJhLonzwyaINnVAa0dK6i3/x7oFllcOYskCPJuVAM3m59KwVtyoRCn5GF9Wvr/LNeJ4wuGXh7ZI3LOLS6z6eWEhfnDiL4r9V3Hmdv8D/EAPnVbIGWNrLJiN6jweicC908/sslxgTXT4Ftz+aIrfhfxVGcRuityvo2pCxX0ok4oRCNZax0Ki5dzBMV7jd5iHokHQoX+wsxZWhX8Jukhv2Nt4Qa3scfAtBTjuFzRgnZcWB8Ee+4+3SEbFMk+LxWxCY2RCodXrXr8t7yRzb8mg5AOzxgzu+EFm1q3m/JdOvJlR8TO0Vd6OFHyUNVIogmx1jKN1cDcmGEatkrVPK7QrWtnzvOdRqDmBDZZDW8E1Hx8Xj4hSuD1oACIScDLHxl1G2P6HjrxUsduM8REoULVh5f4EIERwrRNd4+lBaqYEijzR7TZpgFyXDqbBF6Y3gNY7WX1UAxxmjseWTbZUkV+7njNzgHfx0TJki4VanK10U7MjQrxmh7TWvGKYqOKM+LRrhz/kZ8priktgT/YFCuB0DK3NT3Z9n/YmynS5/40QhBzdMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f1ac9a-9288-4251-7db6-08dd3026ec8d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 20:56:29.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcmwWrGvYmHIyUU4iKk8Qwm8gdaIewdrgcPWWCkWzkKhLH5zZ5j3ZTA44g4q2oRYnoWGapplREHh0WkXaI+iD718iEhqg2Crg679JtW2Sco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080170
X-Proofpoint-ORIG-GUID: 3LlP1JUoloiYU6shlRgCo4BNaAH2CmC9
X-Proofpoint-GUID: 3LlP1JUoloiYU6shlRgCo4BNaAH2CmC9

Hi Mike,

On 1/8/25 11:05 AM, Mike Snitzer wrote:
> [top-posting because of my general inquiry]
> 
> Hi Anna,
> 
> I know Trond has been quite busy, I suspect you have been too
> (holidays and all too).  I just wanted to check with you on this
> patchset.
> 
> Given the 6.14 merge window is fast approaching, is there anything you
> need from me?
> 
> Jeff did provide his Reviewed-by, and Chuck his Acked-by.  But would
> it help for me to prepare a v4 that explicitly adds their tags
> accordingly?

Thanks for checking in! I don't think I need anything from you at this time. I just pushed out a linux-next branch including these patches and your additional bugfix from the other week, so everything should be covered. If you notice anything missing, do let me know!

Anna

> 
> There is also this LOCALIO error path fix that should go upstream and
> be marked for stable@:
> https://lore.kernel.org/linux-nfs/20241227201356.3074-1-snitzer@kernel.org/
> 
> I could put that fix in the front of a v4 resubmission.  I'm also
> perfectly fine to stand-down and let you review and apply if/when you
> have time.. the patches haven't changed at all, but happy to sweep
> through and do the v4 if it helps.
> 
> Thanks,
> Mike
> 
> 
> On Wed, Dec 18, 2024 at 04:19:42PM -0500, Mike Snitzer wrote:
>> On Wed, Dec 18, 2024 at 04:05:23PM -0500, Chuck Lever wrote:
>>> On 12/18/24 3:55 PM, Anna Schumaker wrote:
>>>>
>>>>
>>>> On 12/18/24 12:31 PM, Mike Snitzer wrote:
>>>>> On Fri, Nov 22, 2024 at 09:31:23PM -0500, Mike Snitzer wrote:
>>>>>> On Fri, Nov 22, 2024 at 12:26:39PM -0500, Jeff Layton wrote:
>>>>>>> On Fri, 2024-11-15 at 20:40 -0500, Mike Snitzer wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> All available here:
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
>>>>>>>>
>>>>>>>> Changes since v2:
>>>>>>>> - switched from rcu_assign_pointer to RCU_INIT_POINTER when setting to
>>>>>>>>    NULL.
>>>>>>>> - removed some unnecessary #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>>>>>>>> - revised the NFS v3 probe patch to use a new nfsv3.ko modparam
>>>>>>>>    'nfs3_localio_probe_throttle' to control if NFSv3 will probe for
>>>>>>>>    LOCALIO. Avoids use of NFS_CS_LOCAL_IO and will probe every
>>>>>>>>    'nfs3_localio_probe_throttle' IO requests (defaults to 0, disabled).
>>>>>>>> - added "Module Parameters" section to localio.rst
>>>>>>>>
>>>>>>>> All review appreciated, thanks.
>>>>>>>> Mike
>>>>>>>>
>>>>>>>> Mike Snitzer (14):
>>>>>>>>    nfs/localio: add direct IO enablement with sync and async IO support
>>>>>>>>    nfsd: add nfsd_file_{get,put} to 'nfs_to' nfsd_localio_operations
>>>>>>>>    nfs_common: rename functions that invalidate LOCALIO nfs_clients
>>>>>>>>    nfs_common: move localio_lock to new lock member of nfs_uuid_t
>>>>>>>>    nfs: cache all open LOCALIO nfsd_file(s) in client
>>>>>>>>    nfsd: update percpu_ref to manage references on nfsd_net
>>>>>>>>    nfsd: rename nfsd_serv_ prefixed methods and variables with nfsd_net_
>>>>>>>>    nfsd: nfsd_file_acquire_local no longer returns GC'd nfsd_file
>>>>>>>>    nfs_common: rename nfslocalio nfs_uuid_lock to nfs_uuids_lock
>>>>>>>>    nfs_common: track all open nfsd_files per LOCALIO nfs_client
>>>>>>>>    nfs_common: add nfs_localio trace events
>>>>>>>>    nfs/localio: remove redundant code and simplify LOCALIO enablement
>>>>>>>>    nfs: probe for LOCALIO when v4 client reconnects to server
>>>>>>>>    nfs: probe for LOCALIO when v3 client reconnects to server
>>>>>>>>
>>>>>>>>   Documentation/filesystems/nfs/localio.rst |  98 +++++----
>>>>>>>>   fs/nfs/client.c                           |   6 +-
>>>>>>>>   fs/nfs/direct.c                           |   1 +
>>>>>>>>   fs/nfs/flexfilelayout/flexfilelayout.c    |  25 +--
>>>>>>>>   fs/nfs/flexfilelayout/flexfilelayout.h    |   1 +
>>>>>>>>   fs/nfs/inode.c                            |   3 +
>>>>>>>>   fs/nfs/internal.h                         |   9 +-
>>>>>>>>   fs/nfs/localio.c                          | 232 +++++++++++++++-----
>>>>>>>>   fs/nfs/nfs3proc.c                         |  46 +++-
>>>>>>>>   fs/nfs/nfs4state.c                        |   1 +
>>>>>>>>   fs/nfs/nfstrace.h                         |  32 ---
>>>>>>>>   fs/nfs/pagelist.c                         |   5 +-
>>>>>>>>   fs/nfs/write.c                            |   3 +-
>>>>>>>>   fs/nfs_common/Makefile                    |   3 +-
>>>>>>>>   fs/nfs_common/localio_trace.c             |  10 +
>>>>>>>>   fs/nfs_common/localio_trace.h             |  56 +++++
>>>>>>>>   fs/nfs_common/nfslocalio.c                | 250 +++++++++++++++++-----
>>>>>>>>   fs/nfsd/filecache.c                       |  20 +-
>>>>>>>>   fs/nfsd/localio.c                         |   9 +-
>>>>>>>>   fs/nfsd/netns.h                           |  12 +-
>>>>>>>>   fs/nfsd/nfsctl.c                          |   6 +-
>>>>>>>>   fs/nfsd/nfssvc.c                          |  40 ++--
>>>>>>>>   include/linux/nfs_fs.h                    |  22 +-
>>>>>>>>   include/linux/nfs_fs_sb.h                 |   3 +-
>>>>>>>>   include/linux/nfs_xdr.h                   |   1 +
>>>>>>>>   include/linux/nfslocalio.h                |  48 +++--
>>>>>>>>   26 files changed, 674 insertions(+), 268 deletions(-)
>>>>>>>>   create mode 100644 fs/nfs_common/localio_trace.c
>>>>>>>>   create mode 100644 fs/nfs_common/localio_trace.h
>>>>>>>>
>>>>>>>
>>>>>>> I went through the set and it looks mostly sane to me. The one concern
>>>>>>> I have is that you have the client set up to start caching nfsd files
>>>>>>> before there is a mechanism to call it and ask them to return them. You
>>>>>>> might see some weird behavior there on a bisect, but it looks like it
>>>>>>> all gets resolved in the end.
>>>>>>
>>>>>> Yeah, couldn't see a better way to atomically pivot to the new disable
>>>>>> functionality without it needing to be a large muddled patch.
>>>>>>
>>>>>> Shouldn't be bad even if someone did bisect, its only the server being
>>>>>> restarted during LOCALIO that could see issues (unlikely thing for
>>>>>> someone to be testing for specifically with a bisect).
>>>>>>
>>>>>>> How do you intend for this to go in? Since most of this is client side,
>>>>>>> will this be going in via Trond/Anna's tree?
>>>>>>
>>>>>> Yes, likely easiest to have it go through Trond/Anna's tree.  Trond
>>>>>> did have it in his testing tree, maybe your Reviewed-by helps it all
>>>>>> land.
>>>>>>
>>>>>>> You can add:
>>>>>>>
>>>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>>>>
>>>>>> Thanks,
>>>>>> Mike
>>>>>>
>>>>>
>>>>> Hi all,
>>>>>
>>>>> These LOCALIO changes didn't land for 6.13 merge, please advise on if
>>>>> we might get these changes staged for 6.14 now-ish.
>>>>
>>>> Works for me.
>>>>
>>>>>
>>>>> Trond and/or Anna, do you feel comfortable picking this series up
>>>>> (nfsd cachnges too) or would you like to see any changes before that
>>>>> is possible?
>>>>
>>>> I'll go through the patches once more, but they should be fine. I will need Acked-by's for the NFSD bits from Chuck or Jeff.
>>>
>>> Looks like Jeff gave his Reviewed-by for the series already.
>>>
>>> I had asked for some minor changes, haven't seen them go by,
>>
>> Only thing I was aware of, and addressed in v2, was this:
>> https://lore.kernel.org/all/ZzNm0hekxOyAUhib@tissot.1015granger.net/
>>
>> I added a module parameters section to the localio.rst and mentioned
>> that in v2's 0th header:
>> https://lore.kernel.org/r/all/20241114035952.13889-1-snitzer@kernel.org/
>>
>> with:
>>
>> "- updated Documentation/filesystems/nfs/localio.rst to reflect the
>>   percpu_ref change from nfsd_serv to nfsd_net. Also discuss O_DIRECT
>>   relative to LOCALIO and document the nfs module param (Chuck, I do
>>   think we need it, otherwise O_DIRECT regressions are possible)."
>>
>>> but, for the NFSD-related hunks:
>>>
>>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>>
>> Thanks!
>>
> 


