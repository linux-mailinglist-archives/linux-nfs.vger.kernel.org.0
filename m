Return-Path: <linux-nfs+bounces-16358-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 725DCC59747
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 19:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF4484E80FB
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 18:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C0D283FD6;
	Thu, 13 Nov 2025 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fl2onfhg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0Np2PbvR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3E299AB5;
	Thu, 13 Nov 2025 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057580; cv=fail; b=uL4Xmc2cp50LpVZEHjTuoDM5QkPVOHGjaa2WSyRfEzM70zJBlKqctEnZKE2rEYa8QBIoakY6BjsdngCZ2UkC5qH4oaqxOmphr437tM+tNWJQ7Xx4f2GBKmc12YH3DsordVHltJwssz3UmpNpKjjQA06l3KPzeuhqKXjFnG/XsIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057580; c=relaxed/simple;
	bh=ogJEjDuEO99bFvbBcGDvOOScZOQh0NvEetPVydI4lr4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ova0rN23NSzL8/QqKN41w2uOyBmfq+h82HrwQLeTHthsC5uPEOmYqKWNkpBNO8u3DGLaqb2C0F/ao5kk5i1eAfD8agxr37FJpLbhVXkCd8x3cxnK3otG7m0MYEQcpo/cEptMnZDGbrhsbyMGgCa3o6G8rvTubSag7afuWO/vRzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fl2onfhg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0Np2PbvR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9w93014753;
	Thu, 13 Nov 2025 18:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=I90OU2aYkkI7r5yoREeMGJYYEZ3UePkM7e1eg256Sb4=; b=
	fl2onfhgSE+7YaZRzSLzr51Xm7WDjWII1s0SNlLRXRsHjW0EfR0ylESMxbLFhk50
	glzeVZaplIfxh3HlhTCov96hpQjj7TfYkDxntAGffoOSd14UvPxr1Lcp9GHWZmol
	CaFVS1/dblvM52cPgp87vFpgguqM1OcWEp0IA6RbRp385Ob0eoqtZ7y6y8Qk3PI4
	2OqItF0zFnf/f2asjZvtCid3E8oTuYbprRvWAf8pCZFgjPhZ9xcBPnh34KntUUnS
	LbwriVqAv72Ajx2lACG51u4D+4xbCLqdq6E3avwEqSTPG6ey9lHew3+MP/H0aqLd
	N15yKFpFnjoqorwIVXpvFA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxwq2e2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 18:12:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADHbOsU039272;
	Thu, 13 Nov 2025 18:12:40 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacfg8w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 18:12:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gc38yrphCAAuPRaodAjzBiBbIxww1W/7J/1/9B/ERTcD3k5HRgPkTskdr/QRgdtjKHiRKSO8Ok072alD/rHspoE/u/aHG9bXr2JAuM9L/nUYuazRSja6oE+poI11XuKgYSIiAnw6rbpdbi+KWUDrK3+y2H1pQxu24cc8bwPOqXD4fQB70IOO2OW1lDcq+huGBnFVN0Q2PehWl/zcnDU3r6S3iWrTqUBg78NHYU1+iNIfcoNm+WelAsD4Ig/xEVSCrIMHV4+uqY2/YmECY+i8/npAZ5vhhHYpUUXO9yYptF3WQvXXG2sxID6svPFKtga0mo1qfIYqvJlXpkr/fjo6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I90OU2aYkkI7r5yoREeMGJYYEZ3UePkM7e1eg256Sb4=;
 b=cEA20rgr7FIK15BN3GQoMxpAeNo/8A4QzSBmmRy7wLwnOch+uwbGS9NuIcebmDMgP91hcukSm3NDo1uksMFLheCflI4ugAjJ8RAge+wRMWR57u0Y6bcykc2Y2fuZv2kATMZ7l3kjvMUI+y4d8Ch0u28Z9dBWqVMMDuwuF3Srns6HGkH7IDmGPm1gUfAMpQrGngwNDGqoXqR/r4M4wZKNeex/qe+S29HqMI/iSh75BYEVTSfcl4LBRRAtMY76G/LhQ2AXg4YWzKWT98hzECXYyR+DgRrehKw6re8uw420CrmY42w7RkUed01rT7FaMDNTy6F0/rqlb8nSxTwX7+zebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I90OU2aYkkI7r5yoREeMGJYYEZ3UePkM7e1eg256Sb4=;
 b=0Np2PbvRTSQ1hs4ilJDmNIHb86PlWMqfs6h0sT49anH5mr425MLIJcXGq3U3PvXHx/58MEX68sipt5qsuKDM+hqGWC1vx8FHUQrstSdH2USc+/1XTK23KsiqpSPtPSiXUFVYFmRu0v0r80Q9phTyzo7zrTWkx/LuiFMol5mpQpc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7592.namprd10.prod.outlook.com (2603:10b6:303:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 18:12:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 18:12:32 +0000
Message-ID: <4b77bf39-bc1a-47a1-9a16-14c44c31614f@oracle.com>
Date: Thu, 13 Nov 2025 13:12:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
To: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: "1120598@bugs.debian.org" <1120598@bugs.debian.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
 <aRVl8yGqTkyaWxPM@eldamar.lan>
 <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com>
 <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com>
 <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com>
 <N14GL1WKSGqrFl8nF0e6sa0QxOZrnrpoC7IZlZ20YqUyfsxpsoqu2W3a31H_GfQv7OEqaEWKwDXdgtAV-xv613w_slTAFZIoyWMutIE5pKk=@tylerwross.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <N14GL1WKSGqrFl8nF0e6sa0QxOZrnrpoC7IZlZ20YqUyfsxpsoqu2W3a31H_GfQv7OEqaEWKwDXdgtAV-xv613w_slTAFZIoyWMutIE5pKk=@tylerwross.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0041.namprd18.prod.outlook.com
 (2603:10b6:610:55::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW6PR10MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 3209f1f0-bc1c-461a-a83a-08de22e036f3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|159843002;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cUFmUWJKTHlPK2dCaUFjTytwTlBpZVptbXM3Zy9nUVE4R2hFVmhuOWxOR3dW?=
 =?utf-8?B?NDhYeGNWajhXdTY1anVYVE1pNm1adWI2MzJjaWNIbWwwYWgvWmhNZUV4YlAy?=
 =?utf-8?B?bHcvWXdyZzFJY0NOTHhmcjBmY09yNVF2K2lEUkFudThTK3lJUnV0UmJFdVJX?=
 =?utf-8?B?TDZIQzZvZTRuSXVaWEh3ekRhaU4ycnhEMDMrSlFIdCt3d2lZcmh5bkJ6WE40?=
 =?utf-8?B?VjAyOWJvU29TaXRFdGV4b2VZK3NzNnprRkNCWXl1NUNUQTF0K2FZTUFHNGwx?=
 =?utf-8?B?QVN2Z1dYK0tuYytsbnVlSElsYmVWSUt2K3VGdVRmdjdOK3doUXQza2JNWGRD?=
 =?utf-8?B?VytuMXpqRkVaa0w2d282NFp4VmMxcHk0Vlh4S0c2TFd6VWZ3end2Q2ZDek5X?=
 =?utf-8?B?czlPdzYvRGJFYW9pM1lXZXpxRkxBVTBBNXpqSEpIWTBMR3RQU09tTkZRaGJY?=
 =?utf-8?B?VUk0QU1UVXhaVzhLcUZNK3V4YmM1NHp5MmV6aDJWWTlreHRUNGJXc1NHRGxs?=
 =?utf-8?B?R2RVL1dTUnRFMElKWGsrWUJRYnRJRXNoYzNnc3VpMXJ5c1c1Um1mZ1hQMGhy?=
 =?utf-8?B?R3F1VHFOYXovcTRPc0JKT3hLV25KTGNFdlRpWTNIS252TEh0a2xublRrRnhh?=
 =?utf-8?B?VlZaWVdLdTlKVHdiSTVCQVltVmt1aEpCaS8vMFhyMDA0cG02R3BDd3YyZkFj?=
 =?utf-8?B?bG5laWlqRWtWc2VVbEFCR0R5WGxRbVgyNnloSURhOVpEemM2SzJYWC9NbVRF?=
 =?utf-8?B?QkFyekFrdDJ1ejljOS9QQ2MxSWtMVmNZOFF5R2NubWJVRkhEUXNYMjc2bzNx?=
 =?utf-8?B?dGpNU20rc3d5UFExSm5kN05aRjRZMW54M29RZHdCMTRTd0VxY01ndmpjNGMz?=
 =?utf-8?B?ZVc1di9WdTh2OGpReEplaFNPVDFERnNOMW9JTWVtOVBHd2lIOFpnU3dYRWdN?=
 =?utf-8?B?aEcvbWtDZ0p6WWl2R1hZclZteWU0dzBjUnRwYytseHRBek1BUkpRaW9RckYy?=
 =?utf-8?B?TVBZQS9CYlM5Qk0rVEFLU0VaS04rRFhubnNkTVpmRVhtOUV1NWsxdEJLSDFF?=
 =?utf-8?B?YVdhMG8wZTllSy9jYjJzWHJKZlRIY2plV013VnhuVVlnM1lSMzQreEp1VUox?=
 =?utf-8?B?WlltM25UaVRWRjZ4Y2YxaTZVemNzSDQvODZDeG92dlhIaWFMSzhPeXNLaWJN?=
 =?utf-8?B?Vlk5TElINktFSE5DMVpLdW1qNXlzUkZWQ2lRNGFsV00xN0ZjSkhkdDBISUk3?=
 =?utf-8?B?SjNvK1JrZGxJbmRHQU9uaUpZajZ6VmVGL1htRFZabWUyK0dwbUVqVWl6NElY?=
 =?utf-8?B?c1FhZFVEblBHdnBFMnNTWld2RE5wMG1SSVdZWmdmODVHVkhXUlJHL2dJNnNE?=
 =?utf-8?B?UUNCVmV5eFgyTHpoZlUyVFdONnRYY0V2MUlrOEZmbG05aXYraDNxUm1tVm5q?=
 =?utf-8?B?SjhXUzdVUmNuRU91TmpCUEw1QWFydjduTHF3dTZ1T1BJV1JiTytwbUlDbVdv?=
 =?utf-8?B?am5qTk9MRm5KdE14WjVlRktXeFlnVCtLRE5xL0pnZDRrbUp3YjZua3BwVnl5?=
 =?utf-8?B?aWRvZFRsdDgzbmZSVlArR2RHeXNQTkl4TjJrdTdtTStJZTJxb0hoZHVLYVNW?=
 =?utf-8?B?MTFVTnpUVFhRdGduV2dPZC9UekFlOE5tNk82UThVMnlML2dHc2FKeEdwKzRr?=
 =?utf-8?B?Yk1WaGFQVGpQQi83THNyWUxCSUljMmhXMGlUYjhaUTZXM0JTWVRjRjA2ZFov?=
 =?utf-8?B?aW9SY1hHQTFCcWhaOE5PUXJMZTF5dWhnUmprQTBQYjJSNjZqdGVFblZNMEVQ?=
 =?utf-8?B?WlJveXk4MlhkK2dSSXRnM2tDbm9DczRPVXZUZVB2eFVMZERRR0NDaXNyMmx6?=
 =?utf-8?B?UG1oUEEyTEdFNndkQmk2ZVBxSER2RGk3TUhYTHRrSFl0SEdGb1BJNHRlWHJK?=
 =?utf-8?B?M3NqajNEU040bmdlNlY0dThLZXM0S2ZLZGNqdFlGOWY4a2xUdjhJMkFZdG9V?=
 =?utf-8?B?YjQ4NzVzNGkwQitINExHOTNDQ2lHUm90ZnpQQXY1Nldxb3BOUElZK05JYWRT?=
 =?utf-8?Q?lnuehP?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(159843002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eHphaDhhUzlzRFpONHFoK2xuenhOK05ndHdHaUZpTWIyS2tWUU54OVkweWZL?=
 =?utf-8?B?Z2hBbG96WURvL3N4VDRONDF0UnR5QWxEY2NWdnFVRnBjUWhsYmlaWVkvUm5P?=
 =?utf-8?B?ZURORUs3OEdBQXppWGxkbS80MWdncnBZYXl0UUgvMzR0eVhDcVA2b0xQSmli?=
 =?utf-8?B?MVVENFFEUlFGa3RLMzhHN1QzazB4ZWoxK2NqN2hEd05uOXlBRkxvM0dJWUVu?=
 =?utf-8?B?V3gzYXJUWk9lTU14d1lwdTdkM2pYTXo5QkNxYklLUlNrMFZWeFBoa1FnYllH?=
 =?utf-8?B?RG1JVWlyUHpKR2g4a2ZyWEhZcUZJSHFtVzZHUGZNUGlSNjNJSThxNyt2VVFD?=
 =?utf-8?B?L3ZNcUNpTVBzU1ZSeWFWOXgyd1N1QW9YOGhRbXYrelYvVEQ4dmFlR21nVzdj?=
 =?utf-8?B?YWpBT1hDWHE2M2ZGOW9GZmdHZ3k3WkFNaVRPb0dsTTlvN1hQUzlBVy84clE5?=
 =?utf-8?B?VGtBeGlRL0F6WTNUc2QzaDJQSmJYK0hTaThmRHZ6N0dTKyt3aCtPcmtRZVRW?=
 =?utf-8?B?Mno3dE0zTEU3TEl1ZTRDOFRLbDZTZzVBa3RHVDVqNm5DaEF0MnUzbitvemZo?=
 =?utf-8?B?Sk5UNURtb0w2dXhkVmNsTDJuODk3MUd3R1VadUYrNWpxdnZXM2F2YUNSK2dt?=
 =?utf-8?B?OVFuVXhNRm14TWVMRkJTSFBQLysvYnp2UHFCWmRRZG1RVEdrRkI0YkZabnpv?=
 =?utf-8?B?ZC9WRjFtWkZHSk0weStPcGdPdGsvMGh4REFYemtOdW4zYzFWTzV5VkRyODNq?=
 =?utf-8?B?L041aXdZSUtsOU43b1UxWDVEOEZHdWUzSWZFcHlydVZ5MEVkMTBacFBLL1RB?=
 =?utf-8?B?aDRQN2pES3Axc1QzS3RnYUlNMTBnODVKRkdZa3p3MC9pdE9mczhBUit5aCtY?=
 =?utf-8?B?VUg0WStaa2w3Qzg2Sk9lK1EvZHBzTzJDR3ZmZ1hxS1A4VllmSHRKN2lkbXpw?=
 =?utf-8?B?MkJ5WjdFOWdwRG5OZ0VpM0FPSFFIVSs1WFRPaExtTjR4TWJYaklZV0ZJbkxW?=
 =?utf-8?B?ZEdhTTFINnR6V2pzT01NVjBXZEd4dE03Vm9KclgwRnNZb2NNVlFEMytqNGRr?=
 =?utf-8?B?LzVpYXNoTFRYRWN6K0duU3lRWmIrY1dwNFBCM2RCeXc1cFhJSnVMVktlSHlw?=
 =?utf-8?B?Z0gvMmZ5OGhlTVREaitvU0RtdWQ1NS9xelN5bjN6MWZxUVo1dktjeWsyK3Bh?=
 =?utf-8?B?YnZPZVlNMzlSc25OU2lvMzU2bnZVY2pCU2l3TDRVbXkvSnJYUmlNdzFlSnM4?=
 =?utf-8?B?Y0tJOW5QTjc3M0Nsek9VWXhrTVFqblJCUnFuTk9UbFdyeUg4dVd5RjAyWmZ6?=
 =?utf-8?B?M0RnOXZlS3lORjVZdFRiWUx1Q1JxQzRiWDZ2MmFoc29FTjBoaHR2R1pRc2o3?=
 =?utf-8?B?dEdmTEtraUd5SU9STkppRUdKS0tuTll4VEtBMk4ybVp6M0FZWk5jU3hFMENz?=
 =?utf-8?B?UWRxM0pLQzZRYW9qUHRDOTRKOURXd0lpdWVhMEZCQnZKMjdhaW1tc2doU1Zj?=
 =?utf-8?B?VEVyZ3lrT0lxZFc0N1hRbVBvLzhoT09ScWNKdjhjRzBta0hLRTIrN0UrdHRL?=
 =?utf-8?B?L2VpUFl6cnhna2hoRmVsaEdZa0ZBRlE2WlVJNEFTa2hYTzRKbGpkbW5yaGxl?=
 =?utf-8?B?d0FrallGK2tzczhuai9jbU9EQmpvU2RiOUdQb3BCd05OWjhyWFBiOFJSbHpQ?=
 =?utf-8?B?R1FCYTFkcytGVCtQQWpUZCt6c05CTVAzS3UxSURmM21TazBoUm5WTW0yTEJT?=
 =?utf-8?B?L0hTMGo0ZVUrbGFHazdKUzgyOU5ueGFwc1NaUGR2dUtJV1gvbXE5aFVqa3dX?=
 =?utf-8?B?cXo4aHM4UFBpa2tIaTNTbXlKdDhjcWlNdFRFem55TWdaeDdMRGl0YzVpRllM?=
 =?utf-8?B?cEc4QUY5SW9maWd2MDU4NFh3TzNNR1p6N3lqcE44dVE3M2xwQkdqRG9STmFX?=
 =?utf-8?B?dGh3c2tMc29MUDZId3JXa1k5WWErd3hLcGU3VGtUUk5Jd0s0d1piNmFxdUVa?=
 =?utf-8?B?Q1FFR0RteitZcmlBU0hCTXlhVS9XNUw5eWV5Q3l0ZzJZR0JSY1Ezem5HWlJy?=
 =?utf-8?B?a01qYU01UFZjU2pqYk0rY3dEaGNwcjRXWThNd2s2T0dFQUN4alZsTHlxQTNm?=
 =?utf-8?B?ZGwvWkFyVUdNRmlaZDJRa1pqQVB0R0NGZnF0Mk9ZUER4V041d3hKZG1LenEw?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EZSVlH1mMZCM9qAjzAhNus/LotsQG8dDTkUCd1/XpojlxSUEuwJW0Z9OHNp+cJbs69Uc/rFtwVLrbzDBYYvrjZRsh3f2UQzWmeIMJE3WTB7l4kineSEJbZ/pia/0Or3NTrcrQfaUrNjQCSGSrRB445e3dRDq8r6QCTwmRhAdqyXn7T0ZxJygpLKtedpf06epfGHtL52gMPCkh9mHKDH4+NkcBjZl8EGpBASwnLayUG12Pl3UZ3LRqgcm1YE5r1AdFLe51H9olArUnhmR5wkzjSxZ2dFNb3mi0Xk2EiFzJ0TEyMnKcv/7vjfJdyuJQJxRNruVRMYyZI796zGf7ipMPhmVW/WgVWKElcw5V80qitsGsid6kpppsYWJTrIWYyMJhsjYsTXrG3H25r1kyhBRu7xr2QHAG7I3M4chfRGom1CJcFr7OvNRHNAwnd4UBlHp3G/B+AQKipCaqZV7KGl/t1XzZn2+E6cyYAG7/6QyVPoKV2G2SDne6MSc7TJD3VU+8JQ8RWzeE3k/LKxywWFRqTN99+x1NoKeQUaL7wJjT7QDLi1Fd4yaARiXfFYuan7kMDVxg2C7I0hIYce5TxZkXtv08ayTBGoCJbHOjgH+yVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3209f1f0-bc1c-461a-a83a-08de22e036f3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 18:12:32.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnRpq5osrrkPpvP1qosfj4jbh1aV92Z0Sua1jYDy68OIXnkAmyY7s4E3KoOFzU9iFKUjbfEvzNkZYeOdLPXl9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX0C97oN/5I0yX
 oM6knNeabVANwQH0Vu3DqIg1lnB134s7Wiyufi3w4B2Ej58Y7cNo8J8fm2LTApCg7T69ywYWkXK
 VGJIRNauWZlf0usYO2lPNB5ffNPWC6rki+GjTAMEbk8q5NYPGBCAPwNWq4DfeWyepufVSGc/VcJ
 lWKJFleMO34VCRmsBGp+3UBs5P1ojkj6p0adySEvfrqvOoomuZ+zZodRlNN6cK+102CqJJ3Eo4Q
 ddrMXSWakzjLnWwgFdqGe4a3FE6FOgNIeN3xDlVk2zDL/bWGR0knJKj1ZKPZGTEZdQ7q9d3/BJ4
 iwBk55s/FFtcwKY0U+gRYEWfo3Ham8x1CiUfg23raj8Z5eRZK0KE0llfNVu69MS7FZO1j/J+gny
 pFTEKYp8BkQxt2ICiNDHgB/ixlu4sA==
X-Proofpoint-ORIG-GUID: B1muEgen7fUn0wYk0HoFbmxhhVS3GwP1
X-Authority-Analysis: v=2.4 cv=RrjI7SmK c=1 sm=1 tr=0 ts=69161f99 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Kq4p5Eb50wfIDcVisxgA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: B1muEgen7fUn0wYk0HoFbmxhhVS3GwP1

On 11/13/25 1:05 PM, Tyler W. Ross wrote:
> On Thursday, November 13th, 2025 at 10:47 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
>>> ls-969 [003] ..... 270.327063: rpc_xdr_recvfrom: task:00000008@00000005 head=[0xffff8895c29fef64,140] page=4008(88) tail=[0xffff8895c29feff0,36] len=988
>>> ls-969 [003] ..... 270.327067: rpc_xdr_overflow: task:00000008@00000005 nfsv4 READDIR requested=8 p=0xffff8895c29fefec end=0xffff8895c29feff0 xdr=[0xffff8895c29fef64,140]/4008/[0xffff8895c29feff0,36]/988
>>
>>
>> Here's the problem. This is a sign of an XDR decoding issue. If you
>> capture the traffic with Wireshark, does Wireshark indicate where the
>> XDR is malformed?
> 
> Wireshark appears to decode the READDIR reply without issue. Nothing is obviously marked as malformed, and values all appear sane when spot-checking fields in the decoded packet.
Then I would start looking for differences between the Debian 13 and
Fedora 43 kernel code base under net/sunrpc/ .

Alternatively, "git bisect first, ask questions later" ... :-)

So I didn't find an indication of whether this was sec=krb5, sec=krb5i,
or sec=krb5p. That might narrow down where the code changed.

Also, the xdr_buf might have a page boundary positioned in the middle of
an XDR data item. Knowing which data item is being decoded where the
"overflow" occurs might be helpful (I think adding pr_info() call sites
or trace_printk() will be adequate to gain some better observability).


-- 
Chuck Lever

