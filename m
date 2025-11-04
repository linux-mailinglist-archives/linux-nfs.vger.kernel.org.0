Return-Path: <linux-nfs+bounces-16028-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F4C32E3A
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 21:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ECC64E3956
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 20:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B81221FB2;
	Tue,  4 Nov 2025 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J5OkTyPP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TfOPq6hr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FDE2AF1D
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762287513; cv=fail; b=geGWWXHNuYuEU1hkTBOsbhv/cUfFiQ3QvDxAA8i7vVm87nwFbYeW2DuyfOFkWUQYOTaXcqRBArnLlIWekbaipp4CpzqS2bHmi4LatVDElx0G3paPfgq0E4pVfjH6YHWo6tQFMU64Snm+D9jR23g6YrPqCRxs38Q2ElAbcYmZeOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762287513; c=relaxed/simple;
	bh=iSbuuzF0Y39GozT0RhSgkgA+def2GLlb30V4+VoKrqA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IZ13yw7K5lm+V2xT9j7je/U0hw2WcjAWu9jfeK02Kr3TJ8HwV5RU1lbxlKhRv9ItfaETQJx7bIvieTwUSKBBf4L3rlqPvpmcRo3kUcahg6pSyrMAiBl/7Dzt6wPTkNgiz6t/EBWxJVpE8G+dbKYd4PLqjTLiaxgUmQF00Z5EY/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J5OkTyPP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TfOPq6hr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4JxP0D021385;
	Tue, 4 Nov 2025 20:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+NikVDrtT8CXykxVUlLmheWgIqBIlwLbeNW/rRuAUnI=; b=
	J5OkTyPPR2aq+tXC/OYSr8ONint0gCCC8vCkasHHB10x26tkw8cd3yMRU+zlkceT
	fNK+fPyxxMazG7e/wAp01hb5FuKGXoGS9TFXB5nqEygO0mPmhcKwhoxGeoe1Ze6C
	pyeGyx6wAqp0czW+l/bbLCjAp0QPNmjVuykDdcYDsxPzKymAMCgahzPkQnqiisSg
	6aqh351k2Be8umExRyTqgQzfr16ooPabhgP1qN1Bx0k/L2Ad6AQQUkS+MfUi70GJ
	jwmIdz9KD8Lam/phYSMFyfaYcFLJioFhGQpcEzxbohnAhykq1+qg6dBevpvePfWl
	wbkL4m10+b05rny9jDWoRw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7r4m03re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 20:18:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4IUDkj025348;
	Tue, 4 Nov 2025 20:18:25 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n9upc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 20:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAmIDZ+awWJ9ywvf+/bi/AWHXX+Tlxrta4MIEzY25STPQ13v3nGO/2RJULGoscFmAV1TJAGLOoXemWaV7lD/R/58VqZqZJ1lGhgVdNRFw4A2BvPQqNBtj8MyyyqyVPkUH6f44dVbgm/1SNf779HxRE1jDhXIXqK+VXkwz1qonEtGQjvtWV7yURtzKO7MD1YMQEddw3u2/lYY1iqslLvfMn2vnK5Nui04piMSovrM6N8vlh+O1JJuzB1xPxFQLargeI1kjOn6mxLIkuoGam9nNG/Pb6Z4+tzNtESfcdMrob1Fx+LIhVKwQKWiC81nBw5f+TojnaVgcWBt9CW+NBLTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NikVDrtT8CXykxVUlLmheWgIqBIlwLbeNW/rRuAUnI=;
 b=cipQ1rP1eh8J6Yr3KpGTk7O8SEKNe74NN3LrWMLJvQAnzyqlxrVmPNrJe7Fmlfq5mfaIXrgDuqp+r9v4UL7/zOXG5+b5Z5EPXWPn6+Np8Nzw0mpWMu+rEmP/MmRqGP4AS058AzY8OcHdpCjbN6wd2rEB6psP55DGdE7sHZj/N/LNQNQ8wY/XA+xN78FX2pi/kNYKA45FA4HH2r20TD3fdUjcLQWqKMS517Np1CXc2wxKwA1D7Ivq4C/hiDKPqtnKo+21yAayN5yq2MJjlOG7GEOrnTAid4oFJpIKC9L1RnXndwZ9NMVudCgwaclLv9CXXyRWnaTOIIE7CIgE4+3NqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NikVDrtT8CXykxVUlLmheWgIqBIlwLbeNW/rRuAUnI=;
 b=TfOPq6hrswElHisAa2j5mRVTV6xM8rolwGFyOmm5iWjRRAeiAazF3+IpVSCiKB9x0fgQ1t5iVP9VMiujYqxZKay4u+igShEL9KKW0QU7jJ8QZRT3M23o00R/lTM1fYP+HTM31wgCkAoYs3hh9n7/nfZli/cK713/HmMJrrrI+58=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by LV8PR10MB7870.namprd10.prod.outlook.com (2603:10b6:408:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 20:18:22 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 20:18:20 +0000
Message-ID: <83cac4e8-9130-4ae4-9c6f-857a9fa62612@oracle.com>
Date: Tue, 4 Nov 2025 15:17:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] SUNRPC: new helper function for stopping
 backchannel server
To: Olga Kornievskaia <okorniev@redhat.com>, trondmy@kernel.org,
        anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20251103221339.45145-1-okorniev@redhat.com>
 <20251103221339.45145-4-okorniev@redhat.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251103221339.45145-4-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:610:11a::21) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|LV8PR10MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d001630-be70-4338-8321-08de1bdf4bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm9tdnZMWkxobzlrUllxU1l1T2tWOTF1aHJCOWE5emJIT05MYkV6ZUMvTk5p?=
 =?utf-8?B?SWlQVnRtb0FBN01LbFRyREZwM1FQc09tbituL3BJQXNLUXNYWEpSeVdzY2RJ?=
 =?utf-8?B?MVFxZzEwTUxVUHdWODliY1g3VVpXYllaSzkwOUE0dFFxdlNlSUovL1lLT1No?=
 =?utf-8?B?Y0xxSVJsRjlZemU1WGxncW5CcnM4TngzTS8vNXc4bnBMdTNHaTdEWmVIS0pJ?=
 =?utf-8?B?SEpoaGZlNHBFMXl5QVhlTi9yT0syRGdGaWpKcFdiYVVGbSs0RVlsREdwVzBW?=
 =?utf-8?B?QzJ4S3hMZUFFaFllUWM5TXdpeEQwUU42eTVESkVxQjBTY3JjcmovaHN4UzZT?=
 =?utf-8?B?K0ltMGdJczZ5VzVIZXdBMzVrbitDN1JCYzFXWjRYTXZNcS9PdlhRMk5GcDZx?=
 =?utf-8?B?bDV1NWxzOXFmOFBEOElpM3NSWHRWUnVERWY4eW1PVDVCYjVUdEQ0cklJdm9h?=
 =?utf-8?B?TU01cUJjSkRLOEtVejJZcUdiSGlvc1JOeXl3WjI1UkxhRnNHS1J2dXZSd3ov?=
 =?utf-8?B?SlA4ZlBlZmlSQUt6U2FRemVnNDUxVFRZR1RyQmpTSG1sL0hlNzNDcklIQkIw?=
 =?utf-8?B?Q0RGNnRvRnhGR0ZCZ0FTSGcxT0hMSFpsVit0UlIxZU9IZ2lSd21NRVFGVzNp?=
 =?utf-8?B?ZWdjYlRjY0ZiN1BnUW5RTjdYM0hSeVcvT2xEcWRjY2dmUVpBK21kZjVQc1Nj?=
 =?utf-8?B?V045RzQwUTJlWEcxdWRPVTFBUGhqdDQrZEp1L29SVzVlU2ptNmN6ZUJXZENz?=
 =?utf-8?B?MjNCb1hMMC9rQ3lYRVVhVVhMQk5ZcitRM0ptV24wQnEwVEJwTnFmV2VIVTJM?=
 =?utf-8?B?dHRRS1hGYUVFZ1pwcG5WQjFRdWJFWjBsVHBTN3Jtc1V1ZU5jWTMrMkF3aGFx?=
 =?utf-8?B?cEtQbkQ2NHJMZHVtYjB0MHFSbTlVUGorU2FTVUpEUE9YVjYxQzRreWQ1TmJv?=
 =?utf-8?B?bXI5cmh4RTlKMkxmTTNlc0lwMjRBcmtsY2dtbStTeG5PYWhXS0ZKcC8wcU9u?=
 =?utf-8?B?NVlWYnd6VHQ4ZnFrWWdaSDJXYmR1dERybk1HbTFub2FUazM4WVZ3dENLY2ov?=
 =?utf-8?B?MEh5MTN3THpLVTZrUENxQzErbERvYmlibnRWOEhmS0wvbmIvNkpYNlJFd1hy?=
 =?utf-8?B?L0twN0tqYjdFNUlhbFdTV0dYVHRDQ1poeEdpQ2JWZ3NiUkdqMjhuWjBLT1B0?=
 =?utf-8?B?RmlEYVptdmlEd0NIQk85aUtTRGN2OEltYzhYN2QxclJnM1dFeGtqdkV0dzNl?=
 =?utf-8?B?UE50OE5na0hiOVRIN2R4elBhRmFuUlRISVZORGw1bXhSN3ltTFA4UU1kdldB?=
 =?utf-8?B?dS9xaG5HSFM4RTFpT3JoUjZ0QkdSUklhMkh0c2JtTjZZRHZTQjdrNzYyeWFB?=
 =?utf-8?B?OW9tSlQwZFIwYW5LMnptODhLQjFYOUdQdzhBbGExcy9Gc0tFTmo4Snd1cmdN?=
 =?utf-8?B?cHdFNlRlbGtQWFA0eVQzNnRzVkJRS3YwZm9uWmxqcUtRVm12cy9HaFlzSjF3?=
 =?utf-8?B?QktTWW5wOTJBOExUMUxBNVlCNW9BOC9OY3M3S08zOGUwR3h6OHVyN0RuTjN4?=
 =?utf-8?B?eG5rTVhnU3FZOFY5bE5yM0RWS3pOOWZoa2xZNVdHL0t3OTNvdEQ4cU1lZ1ZE?=
 =?utf-8?B?NFNhSnRhaGZZdWpXR29vempUMTlaS2tSOUl5bDdZcU5jb3p6TmtqYlYzZDJG?=
 =?utf-8?B?L3VUQnJRUWZLcWlhdkt6TWltckJ3ZzFFSVhGejd0aUtlTTZMb0owR1NFY3Vt?=
 =?utf-8?B?bEY5RGhQRTNVdE51dDc3SndqV1VtUzBaaFA0U3JUeHNBMVFMVHFNM2VTTWpU?=
 =?utf-8?B?TExCaTJ6RWVHd2UwUmdFc3RhbDIxdXVETHFneVdwV2ZKT3A0NTNZT1RCdmJt?=
 =?utf-8?B?VWNwRmNPbjJPWjJwUExYaDU2WlZHUDZHanF1elpWV3M4UGk2bHRoYW5jMUFJ?=
 =?utf-8?Q?uVxROWNUqMM9o+xh+WTGG5mW5NUA9n/s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUpTWTMyTnhKMU5VVzRleWdhNUJFUG9OdG1rSXJlOUFuODF6RXZpRFVZZ0Fj?=
 =?utf-8?B?MTZTYjh4bkNGUERQV2RkeWFYRVJhQlpOem9VS3lpRzBFV3NwRkQvbFZadTVL?=
 =?utf-8?B?OFV6aCtoTU9oaER4L0k0dXFzRmdCMXhpTVI2dk1GN3RwL0s5TUlXb1NzeXYz?=
 =?utf-8?B?M1RsTU4rSWRWWGpXcHY2dmQyZkhnK3hobkFQRU53QkpRZ2ZmcVFEQ25ycm5X?=
 =?utf-8?B?MU1oS00xKzBnYTN3VFJ0QXpaTHhvOWRHcktQTjAwS2Z6M0p4UjFrNktCQ3gy?=
 =?utf-8?B?cThYNW5UekxyaWd2UUZQY1YvbGhqcnpJOUFadzFtVy84TXdHYTJrejJzYWJI?=
 =?utf-8?B?bXVSMTZnbnAyejVGdEdIUXZFUjl6bXZmWDZjL2RGbTkxejlLbWwxdW9rVTJX?=
 =?utf-8?B?YktpblhkZ0ZKMVFhU2E2U2ducE95MURrcHNJQmN2TUk1NTJHME96eFJ4aFlj?=
 =?utf-8?B?aDA0ZFJ5ZUZvK1RzeG82a1ZBR0RDd2d1ZEx5Qy8zU1IrR0J5MTZ2WDZiMUQ3?=
 =?utf-8?B?dWErS045cmNhZkUxTm5ubjNSa3lROFJ5Vnp1VUpTK1MzRHJ2c2lKZVBTdFly?=
 =?utf-8?B?d1lxREVpZGQweGI4UVNCdklCeGpmbDZKRlNGTTc1ZmxSZkM2UURSa3JWUVZO?=
 =?utf-8?B?UEhVaTlSMythSnYxRE5XVHdtSjJ5bjBSQi9SaWQ5bzhIb2ZYU2FqaU05TTgx?=
 =?utf-8?B?alRjQWFPRW9WR1haa1hIK254bFpRaEYzcys5ZUlMc1Rzb0VRakkyb0JzbXgw?=
 =?utf-8?B?Z1JBYkhqSHhSTTJYTVA3TVNVM0NlUUpHT091V0ZQaWdaaWdadkpJM2xsbVY0?=
 =?utf-8?B?ZXJyUUl6NjBCQjRQZVNrVXVlaHpYQUowdzVnN3MrUHIyZzZJZ2xNb2IwWE9r?=
 =?utf-8?B?NStNa3NQK0JoQ081UTd2dDRWOHdlV3d0Mzg1NzVPVzNDdWpqczJHeHV2dEY3?=
 =?utf-8?B?UEhoMXdweWdkbXNTNWZXU1FIdWppbjVrMnhEQ25reEIxaDJYTVk2ekpYT1Rj?=
 =?utf-8?B?eGpNNzJDZU53QjM3VVBlaE5UeUNnb3k0ZkJXM2oza003dFRXTURJWGlDa0pJ?=
 =?utf-8?B?TlhOVlpnRzJyZXdiM2dlZXI3Z2dnN2duRDkxbEZLNm0vWXJwRHlhUVV3R1Jx?=
 =?utf-8?B?V2dodmk5aW50bzdpSUxNeVNiWkx2Z2dQdlU2czhnd1ZnZzY1ZXArT1NyOE1t?=
 =?utf-8?B?MVZsTHlzcjF5aVQydHhOR2pLQ2VNS0dYOGVuWjNFWkRrTFAyWlc0b01DNURU?=
 =?utf-8?B?OHF4VXU5VVhNdzB5YjQwa3pTL1VqZ3ppZG5Cb2w2QlJtUlhlL09hTlVLZFc1?=
 =?utf-8?B?SnMySWUrOFEyNk9rZlI5SC9CQkJicVhRenFwVjZwRXhhVkYyVjdUMUlHS0ta?=
 =?utf-8?B?d1FqN3k5ZElVMG41bmgyamF1MWtndzRaMVJYdDZ1Ym44Zmp5U2dzQkROY28v?=
 =?utf-8?B?czlMcENsRkNmRStBWThXdXphWENMTzZqWHlxbit1YVJHVzQvN2RvVTcySW85?=
 =?utf-8?B?WWovZ2ZTbiszbmh1UFdjR2tPTTVCMWRFSHpDTUVyaWJ4ZGdMUjZaYUR1bXpJ?=
 =?utf-8?B?RXdLRW53UDVEOUVIeHgrRzBxdnFNWXRHemFuZUp6eFQ3MlIvTHQweXdBZ2ZI?=
 =?utf-8?B?SXZUR21GOXlnVEUzT3c3bGFHcU1WUXlyNXF2NThmVno5dk9xUWtvbmdzeVF3?=
 =?utf-8?B?MmVaYXE3S0xUVVhHOWtMWGo0czZJNXQ1VGpMMnBzWTVFRGpkTUVtVHhpRUJF?=
 =?utf-8?B?bFlLdUxEdlBRRmZrVERUV0s0SUNsS2pxWlNvcGFLUFRjT25YUHNXYWJrS3kw?=
 =?utf-8?B?LzZlRCtPNUMrbjdzQy9CUHhGdno1L1FHdkdGUGlzYVhuTHgxR2RvM3dvMjI4?=
 =?utf-8?B?dm1SUGlxZEtxc0NpR2pPaXYvVUMyaDFpV3h6S1d6UHVFSVA4ZGVIeVUzU0k1?=
 =?utf-8?B?cGVuT21xOXZuQnRIN0NSMzdsYWJxR0hZZFlvTjl3VFEyVXlwdVRWVUNoQ0lH?=
 =?utf-8?B?Z3pTdEtwZ2pBUU9kSVI2TTYxcW4vMWRkM3VJQjNPWWsxbk1QN3JpbW92cVhn?=
 =?utf-8?B?TUcxZkdzRUM3MU5BdmxUdkdPZ2Q4MWo1REJoYzVXc1dscDBJT0N6c3ZZM0ZN?=
 =?utf-8?B?ZzBoOFhLUTlxMXVZSlljUlZ4alVIYjJRY3FreVYrcHNLeGkzV1plRmNPTG1s?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ww0K2eNdimE4dHBSbg08ddHg7htHoTJnqfBqogCzE3yWnja/nnoHI/fS9/91MvVGhd3obvzhojBC2wAtDYCaJZhg2RQ8ahSh7YHeJbsIbwbDIN+gnFWInK85Vi4YxDSHyl0qBgNO18Som2dfR15D+5lKPoRqID7ouxXLh4LYQ/WkHbHzvslT3AKnnqW+rWonwXQMb2DL1T//hbdWtGe9fvfqQNEJWtzePrubnpQ4Z5yGTZMYJuTHKO2YqmSZSMi1nbNHmFg0uPlZ//5aoFgOwA4ghLUNZLyPIrrTcZ3+S2UAIa6QxrtYu3+dYqgujvQ3FiMYGzkS6ebdHPqwphgrc20yh8fP9jQ8YGPjtUwcgaYtvD3d7bFMe8wweolLwzOuzGu21V2WiVThRXWU2aapllV5KHBN9Xvo0Qjr7GD0nIpgX7/10zRQis85pCkHWMGuKC6kuGgc4O1mbDPyL7ZvIqAn75osw/t3OUCL7O3t1hktk9V275IR46zYM1F8xWnfo0tM+gPs0ef/RaZ01pNI7R9UQwK3V650u/yJnEmZ8l5U/OZkdNchk64sv/XUFk1u7Iq0FXuFlEsEg6SR8yJ4TJweA7RnXuM2h4kuDNNh8oY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d001630-be70-4338-8321-08de1bdf4bdf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 20:18:20.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ksf+TU+niJqvRjgufijhSFtZeLAcMmlETdohdtX0Y+KP7uKyuv0CmLrAcL5c/7RoJRXt8OhQB2/Yp+k/RLgqrjARTU4EbUpDD0dPWip4ZmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040170
X-Proofpoint-GUID: Ur-284yxiJOTjZUyHlXN4JZeBlaMYxBk
X-Authority-Analysis: v=2.4 cv=PaHyRyhd c=1 sm=1 tr=0 ts=690a5f92 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=KQVgiZv5QOlK6wXRcCcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE2OCBTYWx0ZWRfXwy2Xf2Ws7fOy
 J8WN0qqs/xwFT7OGDfUoa4i2XziSMgWECJ69II9MQBPLFnjUjfvjYc/Oz8eGJDDh7Nh5qwmQlJI
 lbzZ+wLKnljhEYgG8k8SzTdDRbvM4EVNErGcxXSMhyj9zuvGpsk/vMglje12ep0ytecVPm6Urlj
 41ahhPT7dj2/FTn9supEv22qRC7hEPwm0FanpI5xS1+Fb9+InpC7J0yJsfFLqKRhJla7mH2NUwK
 neSMsYvEhFqgjpl7MO+L+OaDv9I07sTgR1GZpVwBEEqMkRfNXduvTsRhNg7Yb9glGPL0h7vrAGO
 s5coPj5g47kqyTsnIIVilD6SnWLdD8p6YsEZwe2I4I7XGUdqQsIU3lkuSgecC5u9dkMSUrfkOvm
 jibY1T1QBeOcWIDHR3qTDX2x653hdw==
X-Proofpoint-ORIG-GUID: Ur-284yxiJOTjZUyHlXN4JZeBlaMYxBk

Hi Olga,

On 11/3/25 5:13 PM, Olga Kornievskaia wrote:
> Create a new backchannel function to stop the backchannel server
> and clear the bc_serv in transport protected under the bc_pa_lock.
> 
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  include/linux/sunrpc/bc_xprt.h |  5 +++++
>  net/sunrpc/backchannel_rqst.c  | 16 ++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/include/linux/sunrpc/bc_xprt.h b/include/linux/sunrpc/bc_xprt.h
> index 178f34ad8db6..9cac8f442fd4 100644
> --- a/include/linux/sunrpc/bc_xprt.h
> +++ b/include/linux/sunrpc/bc_xprt.h
> @@ -32,6 +32,7 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs);
>  void xprt_destroy_bc(struct rpc_xprt *xprt, unsigned int max_reqs);
>  void xprt_free_bc_rqst(struct rpc_rqst *req);
>  unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt);
> +void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv);
>  
>  /*
>   * Determine if a shared backchannel is in use
> @@ -69,5 +70,9 @@ static inline void set_bc_enabled(struct svc_serv *serv)
>  static inline void xprt_free_bc_request(struct rpc_rqst *req)
>  {
>  }

Can you add an extra line of whitespace between xprt_free_bc_request() and
xprt_svc_destroy_nullify_bc()?

> +static void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv)

I think the build warning is being triggered because this function isn't being
marked as "inline". If you fix that up, it should go away.

Thanks,
Anna

> +{
> +	svc_destroy(serv);
> +}
>  #endif /* CONFIG_SUNRPC_BACKCHANNEL */
>  #endif /* _LINUX_SUNRPC_BC_XPRT_H */
> diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
> index efddea0f4b8b..68b1fcdea8f0 100644
> --- a/net/sunrpc/backchannel_rqst.c
> +++ b/net/sunrpc/backchannel_rqst.c
> @@ -24,6 +24,22 @@ unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt)
>  	return BC_MAX_SLOTS;
>  }
>  
> +/*
> + * Helper function to nullify backchannel server pointer in transport.
> + * We need to synchronize setting the pointer to NULL (done so after
> + * the backchannel server is shutdown) with the usage of that pointer
> + * by the backchannel request processing routines
> + * xprt_complete_bc_request() and rpcrdma_bc_receive_call().
> + */
> +void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv)
> +{
> +	spin_lock(&xprt->bc_pa_lock);
> +	svc_destroy(serv);
> +	xprt->bc_serv = NULL;
> +	spin_unlock(&xprt->bc_pa_lock);
> +}
> +EXPORT_SYMBOL_GPL(xprt_svc_destroy_nullify_bc);
> +
>  /*
>   * Helper routines that track the number of preallocation elements
>   * on the transport.


