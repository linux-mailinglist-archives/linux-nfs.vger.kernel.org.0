Return-Path: <linux-nfs+bounces-8839-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0196A9FE0A6
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Dec 2024 23:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFCF3A18A2
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Dec 2024 22:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE3870805;
	Sun, 29 Dec 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XAxjXmRN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pVqZnW1c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF50E18C31
	for <linux-nfs@vger.kernel.org>; Sun, 29 Dec 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735511903; cv=fail; b=REU8E4S1h8uAv/vBTokNLBIkZMUudCXW1/i0qSzbqlfJbSXU9ytuLFBHD9AEJsshl/2wSOHDowVS0aICYyXx+Ci5rDtDLhMtKdMwN73Gc+H1OV3PbwGSKV+RcSktV/1xLUeJkZQFiED9y80X53qnX5kOOqOOUu4g0jt5wFq/cKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735511903; c=relaxed/simple;
	bh=mbUr5ARRBPm5PY5+rdKjNoMi2jGnNbbKJLit89lqIcM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tAHFdoSfydtXRtW8f8WVGkPYXIbEHY5xCdYGE2rJgK2TyIw/n0/FXRXyGJoUFAdczGS081Zba9AH+cM4jrsMtmEKv42CBcNYAFyyIJxVcq44Y262ZPnBSnD3awyvIQL6SQTXXdKJdLlTQecrNX/ZoZKkxyVcWxuMCq3T09MDDeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XAxjXmRN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pVqZnW1c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BTMNLXA032734;
	Sun, 29 Dec 2024 22:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7/1OLbs6OdY0uNRN6t3j4xt63dmMfCBWmqDFnRISQ7w=; b=
	XAxjXmRNyBlqF3mgCZoB9Jme/6oh6IPb13IcDx5qWH3eho3BlJzRPCKrM4fGSM9A
	bR6exwiGsNNYpRMa8ANpQsqqWMv/u1XzjJqX61scEDFTvxYZrea05DWWG7TcKPe0
	FQTM9z0SpI8o2W1l6EPRELKJZicgPgDgbKWA7sRcCUqwG2JPgZO3ViGxpAZFkpYa
	JdxAD1EDC2KTH3OekKKbAi3j56RA8FVWXWvMpzfyq854/oIjC1jcVl9XtoywiWT9
	1VjLl+I5JedJ5jX55iT4NRy2nS+dLYyn41eXKr5CtXVDLO10ZYoXfNApOQlqa+HK
	6SpM5yA/DldjJsrTeF+M/w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t7rbsfj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Dec 2024 22:38:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BTFj4on017036;
	Sun, 29 Dec 2024 22:38:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s5ye7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Dec 2024 22:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEGbjtQZ8r8pYQDh84LZCcJ53pSGw8T5YX98fByt1oxgxE5yeN+Tw4kCOFnK0oIPdYr1SrzN1a6FCFq16zRUWEWCoT68omarOtFuAtOr9q68xgZ69luYMM5cJ4I4C6Av0N194Pa5ZVu2DiwgBTdSMa8qqGUd1AU5SG6ib8AiFVtnfkvZC7SS74eux5gdl+QKdfNb72hoWDZ+8BjH4dJ6bx1vObuPJHFU0qZwf+s0bQRTQnUiN0Wkmt4hrCDMbHLV47YdYZiBrBLZCc4Pp24YNjbqYbaklqqDf5+IP35HNXOBYEUeMouqp5DICcGRaJBsVod9RH+jCMsGRXUmDXVoig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/1OLbs6OdY0uNRN6t3j4xt63dmMfCBWmqDFnRISQ7w=;
 b=T/dAWm6/FLYDduJ+XMh1jw2Qqp6Ut/rhRy+pCPe2I5PBjuGHxKxg0Edk1rB2P7+g0vKVtphBDCASKvhfDYfISoXr0CU4gYhEx/YHOK83yjeB05aULtK/9JTirIFiNjtFzTIvHD3yU0blRj6ULh3+nE1lEQZ4rR3c2o+1OzHz2/YVDGL6fEA6UReib5SzIeRYMOVYf3C92fPmPxlGIy9t9uVLo2JoOOJvI26ISWEwKKWIp+TskptfX88PtvG5caSUbhaCCM/XxjvcatwJi610/LOihU/QuH+J7s3YSYZd1OhVwmBYWjK7o8tDkIfe5LQJqO/qT8pe8SK4I9t16Y1zFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/1OLbs6OdY0uNRN6t3j4xt63dmMfCBWmqDFnRISQ7w=;
 b=pVqZnW1ctD85hmsP2gNhHaWe+DtFx7fd+Jmqeacgi3S81Y9Boqcjm0b8Nrz5tyPu2hgEBgSUBIZmZoe+/RVaQvZE4+XeZvBroQAv/XCwFCAJ89ZCFFTifxfU8cgj1/yJSUugk0R0eOIDIQgqJgyVirQXZT0TQo8FifAU+R0/L/Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7050.namprd10.prod.outlook.com (2603:10b6:8:14a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Sun, 29 Dec
 2024 22:37:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8293.000; Sun, 29 Dec 2024
 22:37:58 +0000
Message-ID: <5056f1a4-cfce-4213-a605-1803c387e555@oracle.com>
Date: Sun, 29 Dec 2024 17:37:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: fstests failures with NFSD attribute delegation support
From: Chuck Lever <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, loghyr@hammerspace.com
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <b00b609b-13db-4404-8bdb-4550195362cf@oracle.com>
 <49f7f3ce-bcb3-462a-b1e3-a99ffb85f10b@oracle.com>
Content-Language: en-US
In-Reply-To: <49f7f3ce-bcb3-462a-b1e3-a99ffb85f10b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:610:57::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ccd443-82cd-4cbd-f87e-08dd285971b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU12YWtKdllPRjhGMm1lOHhHMXRtelFRSU9LaG5tTXA0ekVKaGozMU9IUkdr?=
 =?utf-8?B?REcyNHdNeDRsM0hNdVNJaEx2dkVNYTJ4REt0QTRPbkx5Wk5zbVIxNEJJc3R6?=
 =?utf-8?B?QmYwVGwwenNHRzNCYjFuaGQ0UHVEa0FLVzMvK3p2UVdJSmZuN0QrRTBSTUYz?=
 =?utf-8?B?NVhYTEJWd2swbnVSVG5RYUFQSnNsRnZ5d3FHOHh4M1dkVW1GeDJyUEUyYWg2?=
 =?utf-8?B?OXp6em02Yzd4WGxXMW5SblQ0NERneVdWSzVhU25RYXNFUXYzMXdBSGNReWF0?=
 =?utf-8?B?eFRSVGU0UE5wK1JScjEyaUIrcGJKTFpsaWtDZmlvbFJOcmtMbFc2TlY4S2VZ?=
 =?utf-8?B?dU9SeVU5WTZ6L2xld1czNGsxcU52YlBtLzlHTy9YZ1NKYVltSnRNSTBTcHVT?=
 =?utf-8?B?bVRQazVrN2N6WHFBTWRUWUF6c0hoVHdOYUExU0ROZ3lmSEI5Z0owRjhuSUt6?=
 =?utf-8?B?SzNQZll3VW9YN1Y0ZDhaajEzTnZaaFNOdnliR2daK3lQUDRoM3hFVk1QcDNB?=
 =?utf-8?B?bDlrcGNIa1BrYjNuL2lLSC9kblUxV1RzaUNaV1lXeDNSbkQ1bFh2K2xRVHA4?=
 =?utf-8?B?WnRvSXl3UG1VMDczTGVIMGg0ODRZOUJnSWhQdkhFeGpaSTcwclNKZWJhSkpv?=
 =?utf-8?B?U3Y2RmJ1cHU1SE1qb09FbFFUYkFYVHpTdTVTVXBqbXF5dklrWE5NU3F6eTRV?=
 =?utf-8?B?Rk9jRGttWGdXbDVJWFRMUS9ZQm1obFJnSFlDYldwcUdsL01ZSzZKdFZOVnZO?=
 =?utf-8?B?NVBWdlluVm02MHlKK1ROd1NIRGt0WXJJMzFYcEVmeUxIeVltNWlPM1V3WHJS?=
 =?utf-8?B?MzVhVGgxMExTejIwM0ZoNVBWU3ZBUHJZVGlSNXhNTW1GWm0rT0s1THVXbm5n?=
 =?utf-8?B?ckZORWFVTmZpQXZ2c1ZFQkpGd1hYSmw5SFhFOG9nb0tLalFKY3dDS1lPcElV?=
 =?utf-8?B?dURGUGRQSVF1MXJydXRobE9IdGFCU1JRdlUyanBIQkkvSDJGeUI2TThLRFdE?=
 =?utf-8?B?MzJNbi9zdFpaUERBSGpzSFdENU1BUU1aTjVqeXFweXFoSWhwUHMySzVqd2FQ?=
 =?utf-8?B?UG5tWTIxN21VYVZucVZRVkt4ZUZTdXAza3dWU1VjVjFTWFlSM1JObkQvQWpv?=
 =?utf-8?B?eENCUHZCQ21ta200dzhWVkJBa0trZXNoTDA4dWxIVDQ3VlpsZ096VkFEZlZK?=
 =?utf-8?B?a3JBYzN3RFlOOUVOZHBKYlRsNThzOFdrQVRFZHhFVm5qL1pUSTRtOThtc2dj?=
 =?utf-8?B?TWMvWElGNDFqaGRycGJFSk9oQk9DcUQ3MS9uR2VGMExWdnlzUE9ZSDZDa1NG?=
 =?utf-8?B?NGlaZ21mMU8wTXBVT1FOK2JNTHZWdVh4RW1UQ29WM3pJc1g1STlEWmRuaThK?=
 =?utf-8?B?VnVCbXErZFBFVGRIOUh2RTBXOC85Q0ZhbjRvNDl2cmVEN0xLNWlObXdSVm9U?=
 =?utf-8?B?ZnJoWFUvQ05IZThNc1ZpZ0lNR1kwUzVqUzg1VmdWUExIUDFRK3VVbFYyWVhj?=
 =?utf-8?B?WmtqSEw5eG1TdE9IaGQ0YkIzUHdWMHI4ekVET1YyUEROR3pzZFhXSkNQdUl0?=
 =?utf-8?B?QzQ4cVJGZk16TE1lSmcyalBMSGtIWS83dDh2cmpydkcweHp6d2Z6aEgxRy9F?=
 =?utf-8?B?b3J1dTdjVnZtNHNzZVdsUnMvekJFWGNkYVQxRjJWamREWEFxV1ZqK292OVRt?=
 =?utf-8?B?emJmUlE0Ump5ZDFscVFCVTFtNmZQMFRsMGFOZC9PNjRVaHcvaW1HdU1jU2Jr?=
 =?utf-8?B?MEc1MHVSdFplRFpHajRLOGE0NEpreWUwcnFvYlhwdFBpejZzTXdqU1pZTFVW?=
 =?utf-8?B?MmZuR2I0UzZFMnJNWFhVblNHYnU3aEduU1gwQ29EbE53U3FuR2xrWUkvc0RM?=
 =?utf-8?Q?dAA0r8kxbSjTb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU5ReVhEQXZtZ2NDOU5QSzQ0T3JHLzltTGVmcW5kanNIdkNjMmYrMXlrUXhE?=
 =?utf-8?B?clE4Y3VKTnhLQi9IdlZoUHgvcnZxVGd1QTVuSmdjRnFzUnhIQXZ5ZzdVUURR?=
 =?utf-8?B?cnRSRzZSaFdRWkJlSUNVcXd2QjBpL2dGZUVVYUlDdi9oY0VvTmVsZU9NMEE0?=
 =?utf-8?B?MmtVNkYxY0xnTFYySW02TWRMcmQzek5rM2hSSlNKa2VXK09mNCtRMzU2ZVNq?=
 =?utf-8?B?ZEhqdzI1YU9pcWtOQ01Xa3VEWUthYlBPVEJJcVlrUGlxM3Jqek5PK081TzZv?=
 =?utf-8?B?VFVRZk9qamU2ekZUemFkY0ZmbnBRSEMrYi9ZMXBYdXZEMXYzNVN6VVE3NjNZ?=
 =?utf-8?B?dWdFV2s2WWpTakJIRkpnQk5naGhBeEV2YnlBTk5mS2hFN3hDcGlEVktCRGUw?=
 =?utf-8?B?eVBWcU1aa3BQUkUveEFwNllGMTYxU2ZTR01BTWVMWDZCVmNFeTNqeTNJZFB6?=
 =?utf-8?B?aERKU256cEZJNWZQTmovdDhsR3MvR204NE5PeXJwQlhPVTFaWkRuK0RTcXNl?=
 =?utf-8?B?eTNCV00ybWZ2ZWhMWmp0d04rdFRXK2FzZzd4Tll3L2E0V2l5QlJLeTNvQllt?=
 =?utf-8?B?ZlF2R2g2aE9GbElDV2szQnhHd0E4NkNUL0NWaGptcUNVYXNsQ3UzSmc5U2ZQ?=
 =?utf-8?B?T3RWRlBmWXBxTWd3UEFwR1F2TmFOR0pBMThnTjhwdlRqc0xFUVdHdU4wY3dF?=
 =?utf-8?B?K0IvcGxCWlpmenVoVXVuZDZINUFFUGN6ZDkvNXhqMjVOenl3eG12RTdsc0xE?=
 =?utf-8?B?RytkeFUrSWNOZWJIamlpbnRESFR0UzZIdWhPbmNVcDhYVmc1ZVpNVkFmUnhT?=
 =?utf-8?B?cEI0bFc3eWF6S2tRajNwc0J1dFZCTnI3REdxUXd3Tjc1YzFQSlNqSWt5RWpG?=
 =?utf-8?B?aCt4ZWdTVlo5dnBZTldQTCtTU2w5OXJjbHIxN1l6T21Ec3M1WERIVkJZaFFi?=
 =?utf-8?B?bTgyMjM0UWVnVzlTYzRlWGtFM3FDWG5haVJ0MmtUWjdjNFM4RmVuVTh2eGlJ?=
 =?utf-8?B?L0lpSTB3ZjdhNnhnbngxVTA5WXo2K1NTMGJJQWV6SlYxS2Q4UlVudzlpUTk0?=
 =?utf-8?B?UGpveWdrb1oxck1hSWhWc0lSZms5ZkNPQTd5Q05QQTdEVnllZ3BPS3lBZzlQ?=
 =?utf-8?B?T3BhSk01ak1WeEwwUVhZaVh0YlNrWmtSbmZKZzBnQjF5czBUODRPY1pzc2Z0?=
 =?utf-8?B?WXdBd0VLbDFIcUVPcjk5Z25wTSt4ZXJkZjM3eFp2Qmg0djFCdmhCaW9WY1RN?=
 =?utf-8?B?bGh6Y0I4Q2xnMWNuTkE2NEdMMysveUNMQUFMaVIrR3BXOC9keXJyaiswOFBh?=
 =?utf-8?B?cGV5MVZiRmxkeHBScUJUUTYxa2tUQjZVM3VoZjBSajNQQU14aTlWUmVDUUdM?=
 =?utf-8?B?dGtkdWQ4azRMQ1RSQU51Q1VBaVVXbFhhTGxrb2wxUWRmb1YrWTVRUjRIYkNJ?=
 =?utf-8?B?aCtaaWNNUjNuZ3kzRDBmVG1yczlzWExUejh5UTdMMzB2UUlxVHY1cVpWcUlh?=
 =?utf-8?B?T2JJZzQ0SG0zY2FwSHJ1TlBHQmpqb2lBdkxXVFlNU1VuMDVhaDd5dkpPWU12?=
 =?utf-8?B?ejVKRGZFQ1RVQkdnS2hmZ3NHWUUwaCtlMGxHSUoxRmZxR3U5aTh5QmZrb09r?=
 =?utf-8?B?TUFkV3ZqT1Y4SzNIU1JEYUVTQ0JMamVmY3VMbnJ5OFVGWGxCeCtNcnhmdTlG?=
 =?utf-8?B?YnE2WEtzMDBiNkcwQ3dSRTJSMFlqbEw4QUY0cHNkT3dXQUpzWHhoTjBvZ3cx?=
 =?utf-8?B?clIvRE1rUVo1RHBuS2grVE1vdHNZVEZQMXVsRjQybW5zT2RvS0JKOTNqMzlT?=
 =?utf-8?B?a1VHZVRMNFg1ZzVxcGJ0aHdDVmQzQmFhYjVGMTJiRzZBN0k5WTU0L0xlUW5m?=
 =?utf-8?B?bndkaFc1bkVtYkpGZWVwcGZCME5Td1I5QjRMbjRESXNmbExxQzJNL0F5ZHRx?=
 =?utf-8?B?UHQ3TkY0SVJ6L0QrSXE0UC9ZakQyRjhKWlFMNkVOK2RCdWdDMzRqMzNINldQ?=
 =?utf-8?B?V2RpeXlOdEJCU2NWQTdtREhjQ0JybjZCZFJPQUYyTVZsWFI0VEJqMTZYYnZv?=
 =?utf-8?B?eXEwZU9VM0JKZmMrS0d1R21pRFJyWTFNTVhIdFJ2L2I3QmZvSWpLU0pFdStt?=
 =?utf-8?B?RERuUytwMlZ6eHVtQzhWbnVJSE5zRXMybFd2MXpOOWdBWVVyaVI3YTlNZEEy?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l7K7T/j5x+3MgiwZ+WtxXP5Ff/qNXjUc7OVsu/gqmfBW9QS4ibfoXcjwcLtq0g+/kiFASQcjTxYGgpEieOWN7EggC30lnrZ7TDiPmBiyr2JHILnW1jw8UAZ+9H8QtPUh60H/t8x9XduLJMYZVbifOYDxKd31ygfvLtwqdVtFUzR3ksL2UZE1MTnCwUDNrZfvIQrJRYH1bS7qu8R33djoD+tbRgePpSGSOxvJLl5yL+yJOUncn91mr+qFOkAnXXgBxjVvM1EWJ2eLRXq5EWh1eNKmNyQEv3/biAQNmrVUWpkYvDjExItcxHXVbjdcYYw2lWbI5xUBih2raOHNkKhXrVRyVVnLayXYaRdjdtYFFpTTZnoyQUXMp+ThrXbUB832N5G/EwyH3Q9D0EsY/HRiOK8s9lPqpRW7Ia3QIYMX52uw9rVyn6VKt9HcZQ3Nwq4wIB/HiQ2UlJR+DIa/bqVFi0UnUt+rL6tOMZranX6k1SQPRVKxYqegeG0mezZhhdkgWu2v8mlpYBvZtkhSmjH7dQkN98ijjniv9cDkpks40Pfpe0RAsIxvhIGDougb74QMk/HXI8ARH6SSVG+b4d59vTx5a8fjDtE2TdxvMEllQZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ccd443-82cd-4cbd-f87e-08dd285971b3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2024 22:37:58.2705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfnHUhNNondG35eGvfv1R5mow9WK75NGA6i8Z9bXBtpysCpsWFeeLqYWFYNIHMdeB5EFe2oxET3MRgFF3TwY/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-29_10,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=868 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412290203
X-Proofpoint-ORIG-GUID: miHfoQlKl4tQ4oGRl228YA1QEtieDalh
X-Proofpoint-GUID: miHfoQlKl4tQ4oGRl228YA1QEtieDalh

On 12/19/24 3:15 PM, Chuck Lever wrote:
> On 12/18/24 4:02 PM, Chuck Lever wrote:
>> Hi -
>>
>> I'm testing the NFSD support for attribute delegation, and seeing these
>> two new fstests failures: generic/647 and generic/729. Both tests emit
>> this error message:
>>
>>    mmap-rw-fault: pread /media/test/mmap-rw-fault.tmp (O_DIRECT): 0 != 
>> 4096: Bad address
>>
>> This is 100% reproducible with the new patches applied to the server,
>> and 100% not reproducible when they are not applied on the server.
>>
>> The failure is due to pread64() (on the client) returning EFAULT. On
>> the wire, the passing test does:
>>
>> SETATTR (size = 0)
>> WRITE (offset = 4096, len = 4096)
>> READ (offset = 0, len = 8192)
>> READ (offset = 4096, len = 4096)
>> SETATTR (size = 0)
>>   [ continues until test passes ]
>>
>> The failing test does:
>>
>> SETATTR (size = 0)
>> WRITE (offset = 4096, len = 4096)
>>   [ the failed pread64 seems to occur here ]
>> CLOSE
>>
>> In other words, in the failing case, the client does not emit READs
>> to pull in the changed file content.
>>
>> The test is using O_DIRECT so I function-traced
>> nfs_direct_read_schedule_iovec(). In the passing case, this function
>> generates the usual set of NFS READs on the wire and returns
>> successfully.
>>
>> In the failing case, iov_iter_get_pages_alloc2() invokes
>> get_user_pages_fast(), and that appears to fail immediately:
>>
>>     mmap-rw-fault-623256 [016] 175303.310394: funcgraph_entry:         
>> |        get_user_pages_fast() {
>>     mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry:         
>> |          gup_fast_fallback() {
>>     mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry: 0.262 
>> us   |          __pte_offset_map();
>>     mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry: 0.142 
>> us   |          __rcu_read_unlock();
>>     mmap-rw-fault-623256 [016] 175303.310396: funcgraph_entry: 7.824 
>> us   |          __gup_longterm_locked();
>>     mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit: 8.967 us 
>> |        }
>>     mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit: 9.224 us 
>> |      }
>>     mmap-rw-fault-623256 [016] 175303.310404: funcgraph_entry:         
>> |        kvfree() {
>>
>> My guess is the cached inode file size is still zero.
> 
> Confirmed: in the failing case, the read fails because the cached
> file size is still zero. In the passing case, the cached file size is
> 8192 before the read.
> 
> During the test, the client truncates the file, then performs an NFS
> WRITE to the server, extending the size of the file. When an attribute
> delegation is in effect, that size extension isn't reflected in the
> cached value of i_size -- the client ensures that INVALID_SIZE is
> always clear.
> 
> But perhaps the NFS client is relying on the client's VFS to maintain
> i_size...? The NFS client has its own direct I/O implementation, so
> perhaps an i_size update is missing there.

Because the client never retrieves the file's size from the server
during either the passing or failing cases, this appears to be a client
bug.

The bug is in nfs_writeback_update_inode() -- if mtime is delegated, it
skips the file extension check, and the file size cached on the client
remains zero after the WRITE completes.

The culprit is commit e12912d94137 ("NFSv4: Add support for delegated
atime and mtime attributes"). If I remove the hunk that this commit
adds to nfs_writeback_update_inode(), both generic/647 and generic/729
pass.


-- 
Chuck Lever

