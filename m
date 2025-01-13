Return-Path: <linux-nfs+bounces-9182-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B543A0C418
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 22:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1303A57FC
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 21:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC021C68B6;
	Mon, 13 Jan 2025 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MEZ8sbZj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OhjqSXj6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BEC146A66
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805149; cv=fail; b=hH+//RxNOXW8jOm84eTq63KwPhJz0rQXrwoa8wV7Bws82xZPuOH+0tYBX4PQzVUE8bfJnijLTgq8U+oAzA37uE2lxfCW9ldZmahl5uRpzGJsCWeEUdsRNB5zR2UPo4bUEPIX8JljyfFEGdBY63Jd4bXh0lOzcjjAuCAuseY2vN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805149; c=relaxed/simple;
	bh=oQnIAZ4fhRg+u0QM1H8v2TcrlcKT2IeD/pasffzT+RE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gT7Bm0nxhr2lj7Gs2/LPE4wC21FkGfUbB0GnXycZwvfJBF/srUrHQV9YPNgOzTDGB2P4KH/Prwhd3v09KLafbFjh2+hgShkhMPzq0XLIahIoQiilU1n2Cxdp4JhjyLBkunOPiOAaWW3cX1ie8+X/D8PxOh1n1MrfKZJKf5LM/Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MEZ8sbZj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OhjqSXj6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DHMt3F029391;
	Mon, 13 Jan 2025 21:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/qt9Yy47wCd+01FEdopWvYDCX5mIVgJKZ4YQljPiiBA=; b=
	MEZ8sbZj7I8fs2usjU55lM+5Hw6wPwnzcH3nKnE1hf0CYX9v7L9x3HR7E94O+M5C
	Oxv8lNWp/Y8mlBP2gTtgoVJ9jCbsgIRsgbdSnJ0bNvG7ZX2N3hT3/ghnUFlHvMFl
	bzgWMFeMUheO8tSF66iC5gx7QANMzXG6/ykDE/CuFgk52hzjGH05wn2czFvCZqdr
	lUWiiZ7yo6oRt8wczjvsoGk4z9vqHdzzmUoZ6gfLTzo/FKEQ41J8NSxF/682OXKv
	DQ+ap7jzBG1bFB1kXP9AGravgrRTTMEJ10hHd5AqbBcRHlTEvEs2VloIzn4hYjzv
	cf8jR4aw1McnRFh8605kdg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gh8vgek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 21:52:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DKVMoj038139;
	Mon, 13 Jan 2025 21:52:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f381etp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 21:52:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsWIYGwjkGy2XgkI2r7qzs/HpNC4+BbSLR1DynxHPdeSc8T15yJe03bg1Z229KG/SASp3m+pEj/vAv/fzKQSaSG/NP5XoRsatrN8HW4CcsqQwo1WJKRxe8Wqv2ebGmy4wXc7xy21zqbvRncFaElFLo6Nl6TFmxUjQbcQjqaYiLPkLqVZ6aeCyzLahWY/iMD0Haod5RPGURcaQ5vjabEYr5GO5rNcOuR85I0VnQ5OX7iEZZOt64X3oOAxlAeWdRDw9QX/z+FpMcERi8R6xL+p/ckeXyZMTa3CL3rjNVDxHnZUNXy4cypUyNX9MKO9sprhat1OhonZ9Scwyw3WnOTGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qt9Yy47wCd+01FEdopWvYDCX5mIVgJKZ4YQljPiiBA=;
 b=zEDptDEWMn/uBpBB/M3OBKYDAKOKLGO0ksgkNLiOymXqY/EM17plLY7Ai/tvkeVuueb/Sbsvug5uHBSHE3BdHVAxsqud98TsqO3sjXmwjvGmSjhunLgX3HvKd8ZetnL2p795Jv3ESbGeRz41djyD3xbOXaFg81xTWLjGQKf43tOv0qLZf0JWHSbOhn6aN+v6ibP+pGch4Fuyp6zy18CI/HdZd8jNHjZbf9PaPsXgxgexoLfunbYju98eYzdsUrBjES7FxnJPTnf14odPGA65Xk5UsvPUkC2Yl/7xy7g+njlFSDKPEP2ZX2Hs5iBxhsmaq1p0f4HEzhjEkm0g6mLE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qt9Yy47wCd+01FEdopWvYDCX5mIVgJKZ4YQljPiiBA=;
 b=OhjqSXj6PulUkfsYGFVpWplk8gbLWiHXJaYgG8mPyZwmPbFW4nXKTE/EygF26jyR+gOTdeZKGzXNld30GhhBQGjo+X34FYUTs9sKhcdDmFMYGRCATqaN0aTymHc23p+rdXYUb2cl8RAm9eJ+MOer+vVWA8uzEM8md7UOVCNRdjc=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SJ0PR10MB4656.namprd10.prod.outlook.com (2603:10b6:a03:2d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 21:52:14 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 21:52:14 +0000
Message-ID: <15a6d57c-569c-46c9-ade9-59e274226d88@oracle.com>
Date: Mon, 13 Jan 2025 16:52:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] sunrpc: Add a sysfs file for adding a new xprt
To: Olga Kornievskaia <aglo@umich.edu>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
References: <20250108213632.260498-1-anna@kernel.org>
 <20250108213632.260498-4-anna@kernel.org>
 <CAN-5tyGk_Nh4u_m=gEEGH8DbdzoU7XU-2PhOWC3xbBdvEi-SDQ@mail.gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAN-5tyGk_Nh4u_m=gEEGH8DbdzoU7XU-2PhOWC3xbBdvEi-SDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:610:5b::36) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SJ0PR10MB4656:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3b7faa-0a7a-40a7-fbff-08dd341c8a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3Z5Q3dtckNoZGRDVCt4cWVLSE1tOGlabGlIT09TemR3aC9hZHE1cFMrK2ZS?=
 =?utf-8?B?YUNVdTAzSS9OVG5uT2V1Q0toQ29mYWxsTGtBL2s1YkNqR01uR2tZZHUySUh4?=
 =?utf-8?B?aFQvWkphZmxCUk9GalpDcFRWMklKVWpHc0xuMGh5Y0NuaTJBVUtQNjJGYks1?=
 =?utf-8?B?T1JGdXJueG1tWnN4aHR6NlhVekM1dEs1dXk1N0ZOT2NqNndBWmhCckhobFZY?=
 =?utf-8?B?OFByUW0yd3duMXM2UUFEejNOUWJSVHhIVUZqSWxFVDk2c2haUnVXclRRc1A1?=
 =?utf-8?B?ZHFySTNzSUFyalFBSTh3dTdtUHdoaDlNcGVLRkd3c21rcStCZFBROHlseDFs?=
 =?utf-8?B?K0VNbWluazNPTG5YNlBWQ2xGQXFwa0tEazlhblI2ZmpuR3BaYUREeEVUT0Vs?=
 =?utf-8?B?eTF0cHUrdWRhNUpUbUhaNFJYNmhFcEdpQ3JwUE51VFh0RTYybHFBWjVSRVVF?=
 =?utf-8?B?OW11dHl6ZzhuaklLa1R6eVR5SXIvRHZCZTZNNkE2YXpqbDNiSU1JVG1kOHZQ?=
 =?utf-8?B?V1Jid1ExazFHQ0oyNy82MnRRejRFenFWZzRQYTI0MjhqT21FakxFSWZvTkRD?=
 =?utf-8?B?N0xhaUxkMjNJUTBjQ0tLYUhuWmRKVmo0NjNuK3BmcC9zYitSMmt0Z3hDckJY?=
 =?utf-8?B?QTdnUEhvZGU5UmpiMzlveGZYdWlaSlhsM3FJSWNtTGcxK0ZIbEw2cUkydTV1?=
 =?utf-8?B?T3E0L0dPQS9FZngvby9vUE92OGJQTks3ZldjbEFhR0w1UlRYcm1wQkZXNzhI?=
 =?utf-8?B?eWQzS3BJQVFXVlo2UzNPM1E0TUtXeVhXTVJlb1Zia0o4cFA4L1Rsd2lwcU80?=
 =?utf-8?B?alFMY3pmWURqWWtRREhTbE1rVXdPWE9hRHVVeVJGbmhmdkFkaGRhWHE2MGFK?=
 =?utf-8?B?QUtBTFI2dkNpZ1ZuM2I1YWdBR2xlSXpNVFQrOWJ6MTJUOE5UL2FHd29wZWJ3?=
 =?utf-8?B?REZjVzRsN3Y2cnpWb01taThOd0NnNmVNNkJPV0xROXQzNkNYVU5EU2tNZy96?=
 =?utf-8?B?T3YxcVVsSTI0U0xibWFDVGlFTTJxaWQ5c0pNOEtiVDFiUXRoVytTQzM3NFVV?=
 =?utf-8?B?M1Y0ajkrOXNuMktUdWJySFRlbkZZVmhPMHM0TzFnYjNIY01xSXVGNWVtUmQ2?=
 =?utf-8?B?WWwreFNxWkVCeHVsbk9NalBmY042elhkYWJGV2ttNm15alBWU2J6RlhsSU90?=
 =?utf-8?B?ZS9vNUVXbVBDSmJiNWFaOTRRNFRnQkN5OVgvdDczdVJHVHpHeitYcDdFRXh6?=
 =?utf-8?B?UTJaTkVpcGxXNG9wejJla214NVlsL1ZqMG9wUCt4ckl0TEhxbS9lNGYxVTN1?=
 =?utf-8?B?SVZzb2cxUnZjSTVzU1FmR1BRZit0SUpTV0UyQ0J0VkRLcE44NHZPbXRGWXVu?=
 =?utf-8?B?ckpCck9KUnBldFQ0MWlYT1FnTDBzYmpMWU00SDRwd3dJUnBGZTV2bzhLM2ZY?=
 =?utf-8?B?NDJhdFpjbEpSRVdrUG81QkFOR1hkS09DdXNGbjRhRGplTkx5NEpzaFozZkx5?=
 =?utf-8?B?Q1I1ZHJaQUd2REdRQmF1ODRSeThVL2lLVW9CWWRvWW9jdTlWUmMrUW1QY1hT?=
 =?utf-8?B?cDcwYzlsa0FrajBHUUtFWkpEd2lVK3MzZHpWQmpvejVSeUFvVkt5SzUxMEZp?=
 =?utf-8?B?YUJCOEVDU2xNRlN0Z0d3bnhEcTNJOVg0TVV6eVdmOGxSY3UrMzdoOGpFYTg2?=
 =?utf-8?B?OTBYZzFtN0RHMEVRMHpvN2Y5OG9FN3V3emFqbnQ3dS9TcnJjY2ZicS9MT0Vs?=
 =?utf-8?B?T2QzUzREeURaaUQ4S3JNT0YvaU51bXlONTcyNU5zRnVDK1pBbmlHK1REdFBQ?=
 =?utf-8?B?K2hvSzN0YThEYitBSUJRa2hVY1FDcm1RUm9VUWM4VFNoSFVpUWpXK24yMVJM?=
 =?utf-8?Q?eUIBuqumlAKxC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHpVMXZ0cjcwaUI0L2VCZTdzNFE4TllwYzNqRGUxbUVvVkJUbHc0bXBkYVFh?=
 =?utf-8?B?RWtRTEVhaEszc3VZZ3FFYnZpTFlMbGpnWWFOTTJxYUJ1eDRuczFWK3F2THlZ?=
 =?utf-8?B?ZXgzUnE2ZEUyY2tVS1IxQXVtU1F1aFNBd01MRjlxaURxVWo5aWJUV0I4WTl1?=
 =?utf-8?B?bzdlK3hqdTFUSU14L2FQMTZGRVo4MzA4ZGU2djVMaDdxM3FySVE3Z3pjcm1V?=
 =?utf-8?B?L3JEME5ySDZhbWd1K092SmZQRW1CRm1SRXUzdFV6RU1zYmh6YlZhTk9LNU1i?=
 =?utf-8?B?VXRBS1Bub2R6U25UOHBKdWxVcTNlZXYyd2czUThWZGU5Q1pqL1JSTWNZcmZy?=
 =?utf-8?B?ekxiSm5IaDRQb284VjJIWGt2Tkt4dDBaZ1NOSUJVR1B2T0FGMnhod3Q3OHJM?=
 =?utf-8?B?aU5zbWpvek9sM25HR25JTm1JM2dOWnN4Q3VPcVYvL0g4M1FTU2JvZGx5aXhP?=
 =?utf-8?B?SGhIVzkrMThyVjdoM0ZaTjcyQ1FmcE5UTSttME0zVVdNWlU2VWdTb2FPOGdY?=
 =?utf-8?B?azFDYjFwT2FiL2w3K2wyV0xHU1o0RVZqbTVUcjhTcDBIMDV1WndIaVNZT2Jw?=
 =?utf-8?B?OVVXVFo1NFR0RWZONFhxdE5Ga1VzZ1JxVlpKQkN5WDdnanplM0dyb2NEWjJr?=
 =?utf-8?B?NG9WWGFXTElrUWpNdVdZbHhGcnp2bjEvSTVqR3g1Lzk0dllwSzJnd0twaDdC?=
 =?utf-8?B?MDgzdnVSbm4ydWdIQ1c3cys3cHRUenhMbGxvQm1Tc1RzTFhpUi9NU2ozTnV5?=
 =?utf-8?B?ZWhNbnE5WHgzQlZGZDcvVEhUM05jSFJmcTd5MkU3bFIreUc0L0VjUVNFY3dw?=
 =?utf-8?B?bXFuODZsbVZWbmp1MTl6eWZNbTlEcDBpNWpWTlcxNFpJN1pkeFVoUWRLNlpT?=
 =?utf-8?B?eThtcW14b1paZGNKY2hPLzBUSmpFblk2cEFrR1hPcG1qL3o1VUw4Z0lOM1ZY?=
 =?utf-8?B?UGdQRENKcEFWYklESHBrZUZlL2Y3QXM3dWp4cW55T3hrU01hMElDbXJhYTZx?=
 =?utf-8?B?djJxNzZOMzhLWFE1WlVEZ1pLOTFpU3MvVm52TlVrcmxYam9QbEdjbHdOeUZn?=
 =?utf-8?B?dFFQTFd4VytGdkQxZ0c2NGV5TUJNakVWZ1pVSndPTU1aaVVPbkpaU05vaHlS?=
 =?utf-8?B?d29NUkIxdWVDZkFFSzkvK0pVQ3V5SExxMnRxNHBFK0hpZVVhSkNSNk94UDEz?=
 =?utf-8?B?RjF3enpCNm5tVUo3ZmZ4dGMxcDMxUnJNaVM4eE12YkhHZmdnVEZ0d3R0WE5j?=
 =?utf-8?B?VlBUZzhWeC9DTEV0Z3RrUFVxTEFiSGUxMGRSaHRCTzZSSWxlKzhKQitFYmlF?=
 =?utf-8?B?ZDFVZkRDOUtVRm8vcEp1WEJVc21XUXE1ZmcxU3NkbFlYRHZ5eFVhYlRJRVd6?=
 =?utf-8?B?WU9ScWJWV1VHM2I1MEkzUlBERjRMeGlodXM2VVZUWi9IenFxMWxzTURQanM2?=
 =?utf-8?B?Vk5VcWJ3cENsR2tHN2VhZGxEVjlHMkRFRGhBTXk1bzNNVmhlV21FbHlCaGNJ?=
 =?utf-8?B?di9mZi9KVjBXT0dkNHlqM3h5MDIxV0xGNlFzQVFJTVFXWFpGcWpZR1gwVDVk?=
 =?utf-8?B?TnkrUExrcDRmaDF0em1xZXhDRUwwMGZJM3duT3lVWmVmVE9UazRGMjhNeU5E?=
 =?utf-8?B?cDJHOXJxQmVtbGFKL25BRkpEWjhYSUc4NVovbkYveEwwY1FuNGVUMVBwcDVq?=
 =?utf-8?B?aFhVeGdVSlpERzlralhnZnoyYW4xUEczcmloM2tvam5ud1VOblA5NzNlSVh6?=
 =?utf-8?B?TGt1N2MxalVrRU44MzdYdkFyVnpOaDk3SDNKMFdzeTRneGlCRHNKcTZ0SzNp?=
 =?utf-8?B?MVFLZHYxdFV1dEFvTnVvUk40NS8yOXlBVDA4RDJYRlhmTW5GZ1NUN0JpYnA4?=
 =?utf-8?B?T3Rmd0tQOEVGeVpRU3ovM2Y0SEpCOXk0NUZ1eHRjZWNPN1FYSm5tcUlQaDV4?=
 =?utf-8?B?YmhrckxFK1RWUDRISDdDdytNT0FHc2VrVCtndWtzRlBCcWRvMjM2T01yOWZ5?=
 =?utf-8?B?Qlk1VTlGSFQvV1psV2xibWNQeWxHRGFGcmlRSUhnclRMMTdRV3pOWFFjWWVR?=
 =?utf-8?B?WXlqeXBKajVzRXZJbE0rQ1NYcGpHWDJBbnJ1RUxFZ1FTZ2ExNzBOMDUxZmtQ?=
 =?utf-8?B?b1lkL3JjWkJJdHA1OGgwY3FRalA4VW5ZYzdCaDNvSjBsQ3oxTjZLbE41L2hH?=
 =?utf-8?B?bFBxMkVqMVB2OVFrUjZmck01RGFjTytjMlM0RHhCUTY5dHJDQ2lUanRIUnQw?=
 =?utf-8?B?VGZsQXJhOGNDN1JZQTNuYS83K29nPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O6f8Fl2UG7RpjeeDYE5IvAWoS1pjAkyWpSYmxKrus0Kp0+3pTiDBOnazS/HLJOr2khXAwjLoJDGGtRlMxVjr8KJz5Q7PAgv+elrUJuqA1p5ArKmNpKiVQvukzo82CMpiCAxPMAV2s2qXE9ApXeK64MtMQ+lG29xalh1pKt0Qce08CZMto8cAycf+ar9IdjF77nuyJXuAioAoF1yyhBO/XevL4UBNP5lJ0D7JXX5ci+hgghXuFbXWZzYyrLOD1cK+exuC5PnzneHzSU9a5PoFTcPUGIlfhjUH4swYIU4TdTFLTSL3knhdnH2HMzzLYfrGLT8/taqid30eucgarg6OI25YYY43F5owDM/kzBtoqP2oBalEhlTRPEUgUDHnop5yYLsR3c0MsWlLCvjDE7/g572o5Xldn4nN9qZdosDHM8xxiXkmy71hgxpzdlYhKm69Mbs7m0w1pUkfXnTr62tf6jw6bD5rJZWD9ycphFO7AdM9k6uXQ/UcQcgueJfxyRiA9ohWmMJe6PK5vECuBWcbfTsqScXtzJIAzj67r/oexeDNE4R5HBTBoxfsxR2jGraW4dO8TjYROaX157AaBWoHOzjuKN8raXJLPW7XF0I06KI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3b7faa-0a7a-40a7-fbff-08dd341c8a4d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 21:52:14.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2HCHAnlKGJtuh7HdMcoVvgOrVLGGt3Ft20auTD8NLzh4K7RlfjEV8zw5+Oho59k6DTGHQ63DwYwh8TDD2HhIPXS4lLNaPec4uZnTs0uNfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_08,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501130172
X-Proofpoint-GUID: 5bEYeS3zqxyerAv-rRzAOOlK9T6HsIB9
X-Proofpoint-ORIG-GUID: 5bEYeS3zqxyerAv-rRzAOOlK9T6HsIB9

Hi Olga,

On 1/13/25 9:10 AM, Olga Kornievskaia wrote:
> On Wed, Jan 8, 2025 at 4:36 PM Anna Schumaker <anna@kernel.org> wrote:
>>
>> From: Anna Schumaker <anna.schumaker@oracle.com>
>>
>> Writing to this file will clone the 'main' xprt of an xprt_switch and
>> add it to be used as an additional connection.
>>
>> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
>> ---
>>  include/linux/sunrpc/xprtmultipath.h |  1 +
>>  net/sunrpc/sysfs.c                   | 54 ++++++++++++++++++++++++++++
>>  net/sunrpc/xprtmultipath.c           | 21 +++++++++++
>>  3 files changed, 76 insertions(+)
>>
>> diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
>> index c0514c684b2c..c827c6ef0bc5 100644
>> --- a/include/linux/sunrpc/xprtmultipath.h
>> +++ b/include/linux/sunrpc/xprtmultipath.h
>> @@ -56,6 +56,7 @@ extern void rpc_xprt_switch_add_xprt(struct rpc_xprt_switch *xps,
>>                 struct rpc_xprt *xprt);
>>  extern void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
>>                 struct rpc_xprt *xprt, bool offline);
>> +extern struct rpc_xprt *rpc_xprt_switch_get_main_xprt(struct rpc_xprt_switch *xps);
>>
>>  extern void xprt_iter_init(struct rpc_xprt_iter *xpi,
>>                 struct rpc_xprt_switch *xps);
>> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
>> index dc3b7cd70000..ce7dae140770 100644
>> --- a/net/sunrpc/sysfs.c
>> +++ b/net/sunrpc/sysfs.c
>> @@ -250,6 +250,55 @@ static ssize_t rpc_sysfs_xprt_switch_info_show(struct kobject *kobj,
>>         return ret;
>>  }
>>
>> +static ssize_t rpc_sysfs_xprt_switch_add_xprt_show(struct kobject *kobj,
>> +                                                  struct kobj_attribute *attr,
>> +                                                  char *buf)
>> +{
>> +       return sprintf(buf, "# add one xprt to this xprt_switch\n");
>> +}
>> +
>> +static ssize_t rpc_sysfs_xprt_switch_add_xprt_store(struct kobject *kobj,
>> +                                                   struct kobj_attribute *attr,
>> +                                                   const char *buf, size_t count)
>> +{
>> +       struct rpc_xprt_switch *xprt_switch =
>> +               rpc_sysfs_xprt_switch_kobj_get_xprt(kobj);
>> +       struct xprt_create xprt_create_args;
>> +       struct rpc_xprt *xprt, *new;
>> +
>> +       if (!xprt_switch)
>> +               return 0;
>> +
>> +       xprt = rpc_xprt_switch_get_main_xprt(xprt_switch);
>> +       if (!xprt)
>> +               goto out;
>> +
>> +       xprt_create_args.ident = xprt->xprt_class->ident;
>> +       xprt_create_args.net = xprt->xprt_net;
>> +       xprt_create_args.dstaddr = (struct sockaddr *)&xprt->addr;
>> +       xprt_create_args.addrlen = xprt->addrlen;
>> +       xprt_create_args.servername = xprt->servername;
>> +       xprt_create_args.bc_xprt = xprt->bc_xprt;
>> +       xprt_create_args.xprtsec = xprt->xprtsec;
>> +       xprt_create_args.connect_timeout = xprt->connect_timeout;
>> +       xprt_create_args.reconnect_timeout = xprt->max_reconnect_timeout;
>> +
>> +       new = xprt_create_transport(&xprt_create_args);
>> +       if (IS_ERR_OR_NULL(new)) {
>> +               count = PTR_ERR(new);
>> +               goto out_put_xprt;
>> +       }
>> +
>> +       rpc_xprt_switch_add_xprt(xprt_switch, new);
> 
> Before adding a new transport don't we need to check that we are not
> at or over the limit of how many connections we currently have (not
> over nconnect limit and/or over the session trunking limit)?

That's a good thought, but I'm not really seeing how to do that from inside the sunrpc code. Those are configuration values for the NFS client, and don't get passed down to sunrpc, so sunrpc has no knownledge of them. If you think that'll be a problem, I can look into adding those checks for the next posting.

Anna

> 
>> +       xprt_put(new);
>> +
>> +out_put_xprt:
>> +       xprt_put(xprt);
>> +out:
>> +       xprt_switch_put(xprt_switch);
>> +       return count;
>> +}
>> +
>>  static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
>>                                             struct kobj_attribute *attr,
>>                                             const char *buf, size_t count)
>> @@ -451,8 +500,13 @@ ATTRIBUTE_GROUPS(rpc_sysfs_xprt);
>>  static struct kobj_attribute rpc_sysfs_xprt_switch_info =
>>         __ATTR(xprt_switch_info, 0444, rpc_sysfs_xprt_switch_info_show, NULL);
>>
>> +static struct kobj_attribute rpc_sysfs_xprt_switch_add_xprt =
>> +       __ATTR(xprt_switch_add_xprt, 0644, rpc_sysfs_xprt_switch_add_xprt_show,
>> +               rpc_sysfs_xprt_switch_add_xprt_store);
>> +
>>  static struct attribute *rpc_sysfs_xprt_switch_attrs[] = {
>>         &rpc_sysfs_xprt_switch_info.attr,
>> +       &rpc_sysfs_xprt_switch_add_xprt.attr,
>>         NULL,
>>  };
>>  ATTRIBUTE_GROUPS(rpc_sysfs_xprt_switch);
>> diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
>> index 720d3ba742ec..a07b81ce93c3 100644
>> --- a/net/sunrpc/xprtmultipath.c
>> +++ b/net/sunrpc/xprtmultipath.c
>> @@ -92,6 +92,27 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
>>         xprt_put(xprt);
>>  }
>>
>> +/**
>> + * rpc_xprt_switch_get_main_xprt - Get the 'main' xprt for an xprt switch.
>> + * @xps: pointer to struct rpc_xprt_switch.
>> + */
>> +struct rpc_xprt *rpc_xprt_switch_get_main_xprt(struct rpc_xprt_switch *xps)
>> +{
>> +       struct rpc_xprt_iter xpi;
>> +       struct rpc_xprt *xprt;
>> +
>> +       xprt_iter_init_listall(&xpi, xps);
>> +
>> +       xprt = xprt_iter_get_xprt(&xpi);
>> +       while (xprt && !xprt->main) {
>> +               xprt_put(xprt);
>> +               xprt = xprt_iter_get_next(&xpi);
>> +       }
>> +
>> +       xprt_iter_destroy(&xpi);
>> +       return xprt;
>> +}
>> +
>>  static DEFINE_IDA(rpc_xprtswitch_ids);
>>
>>  void xprt_multipath_cleanup_ids(void)
>> --
>> 2.47.1
>>
>>


