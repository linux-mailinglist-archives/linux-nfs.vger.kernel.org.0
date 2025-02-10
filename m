Return-Path: <linux-nfs+bounces-10032-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EB0A2FD91
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 23:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28ACE3A5027
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00445253F0F;
	Mon, 10 Feb 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DtPjk1ev";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fn922+mW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF2253F22
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227150; cv=fail; b=EZVzB3gZKLtP7fruVYf+LgZbzEIhLPuHxf0OEsxgjkaeWrPnStqI1HhQR6JAZ+vs00WNXm0hkTGmT3gsTfWm+UxBtioQWnQU4UwNEUMifzw7nMXUX+mcBg6YJrFZJ4VI+TFj5TNxYZ+qvSL2YqL96FHKaAJ5jbLzTLNXvk7VVfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227150; c=relaxed/simple;
	bh=cIxIVl3JKrVsljL6OA/Y6KzAHB8HTtcyPDGsn7GSJ7o=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FESJ2BVfhTj76rGB0YiO2UYs4WAsrNvxppGYTshVaWT4FoYpG6mi4us2izqgOrrSkzsk8c6JUZ7O/l2uw82Q6ijDbFjAj925WVMiG6SgK5nS8j6tQYYbNUVYeXFtj4solWKTSqLCTIN6TDsJ0sH1SqcCA1KKya7qawo7m8LWWtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DtPjk1ev; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fn922+mW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AKMWPO019534;
	Mon, 10 Feb 2025 22:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=s3ydygA388OVGVfCHQ3pFmCJhAYShWobS7NeVuD+kuk=; b=
	DtPjk1evHEgNGMwlTTC0k+2nNa6U3HKiRI3SpEU8lLW0g21PDQoEzg7P08HocpiF
	ZMq2gJXWHIUoW1Cq+NBoGmef+nk9M4+L1SymEpM1T2VBejwB/qGBlkDO08jn5/6p
	opsUIgaVrSGmzuB9K+CQicYvrh0rKkMVDQ6wP+6o3qZ8Wxq+qeJGrkwLQknxgoso
	G6tGI2UiEhgMiJhhAbYP2iUNAUL/5aWc2t/mHK9HkLXiRRzHJVPZgfpYdGVwInvw
	2bYrxDYq+Tlc0Bym3829Ieci5yHPSXdB6xy0UGkt9nS6vrUso8JsY6+DhNaqmAdx
	Zm1MpOlvx5aJiGiOWD92ww==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tg438w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 22:39:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51AMKQ8A009801;
	Mon, 10 Feb 2025 22:39:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqea276-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 22:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m959qnQNDM1Ilu5NiWFRRSwz0MbQ083j7kDV3XbqghC2HXXFGHagE3cuw3/ZCdxyV0YKLWU+7zIb93t9D2Z4+mE9JQ2sP7UlK2FOiEAIHCYPNSzm4DDCEudBCxh1mvliSZFnl+yNbBAqqfT8NJK9iiLG6gb00ql+ftJvCuP08yD49JxQjE4bvdZmtG4EepNd6fC45akPUj0ZqiUbxqa1LEg7GShngzIEUrCQzNG9DAx1vpprj2nuvnYG4Hfqs9AnzItfVM3DJocUjpXiUFoF2PccGgKTNr0GnW5lXO+5AOIS3iFj5WIET5n4xt3+Q1U4+8lYnRR1h5/EoEvCvdiDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3ydygA388OVGVfCHQ3pFmCJhAYShWobS7NeVuD+kuk=;
 b=LevbPLOQDiZaetvcjpjyDf4B1nL9fuadHOrm377tnmdmKK7VW031Rd1O3BHYSWYvjrfRyWPsYfmfJM+3I7NmrgZgkUuMaYLwdi2YiPHUoTp3MXV9DYJt8T4AEcq/zJvs13h7AVt4ZlNcKs0ShmA1QVigDO2fHwtyb4JNRfppzl2PGwRGvq4avHyNZdzYX6ZUjYtOpWpI2yr2/KO9WHSaRmOwMW2SO5l7OTOsQePOFCcJXZM4/axWi1aIJMTl4SSkkS1CPbpFp0vG3/+1+7//xXLD4ugFU6Cr47Hn/+7B0VZoycOz2exIu2DBzDhlCc98S6IX+9jemRx3c9GE6zM2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3ydygA388OVGVfCHQ3pFmCJhAYShWobS7NeVuD+kuk=;
 b=Fn922+mW+eFFfpXYcYM2JomcWpCir1S2rSn9EHS8JBTqRxdGCCig0iNK7Wl9K3CC5wvZRUgonsAced5Kik6Wh1fDly5VfUZl/aceTteFIlkCNWMI/ySuETv70/1VbIC3BzrSI/1n8RQHSH4YlxLzB5vXQ0RffETQWdLUrlHUUnA=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by MW4PR10MB6560.namprd10.prod.outlook.com (2603:10b6:303:226::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Mon, 10 Feb
 2025 22:39:01 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 22:39:01 +0000
Message-ID: <b8a0f47c-a643-479c-9b91-c24240c491f5@oracle.com>
Date: Mon, 10 Feb 2025 22:38:58 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH pynfs] Move to xdrlib3
To: Jeff Layton <jlayton@kernel.org>
References: <20250122-master-v1-1-3c6c66a66fe5@kernel.org>
 <020c8945-51e3-4783-b852-c89bc7917b67@oracle.com>
 <d409eae2976c25f0121b1011bb2d1aff181aa4fa.camel@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <d409eae2976c25f0121b1011bb2d1aff181aa4fa.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::14) To DS7PR10MB5151.namprd10.prod.outlook.com
 (2603:10b6:5:3a4::18)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|MW4PR10MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 56048dd9-4a40-490f-57ad-08dd4a23b6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGFlTTM0dU9LMGV1dGN1b2tFZHR3ZXhxN0R5clRYSm1ZMVVRMGRBcXYzSmUv?=
 =?utf-8?B?cXFzd1pIV0NYdzRKVTIzZEtFalFYaXlIRmdHQmRkbC9pZDZ6dE9HRVpNVDlh?=
 =?utf-8?B?ZHdyd0Z1WUR4MWs3VnowcW9UWk5nWmpzMVFVOXVyM3FVWjFBc2xlc2REZjhW?=
 =?utf-8?B?T3JXUCtjVUp0a0sxVWE3SFA0cXU3MTNNZTEwUHdBMEFyWmNPRXJ5Z053cnAy?=
 =?utf-8?B?MGxKL3Q0MmtsVnNzZzl2cCtzSlpnTCtkcEJKVEtMbVBOcHhPdTJQMVFSUUs5?=
 =?utf-8?B?RnpweUZwTmtTUzd5OExYU00wLzNBUDlCaFBjRmV2TUdHYXJyZVp4a2laU2dG?=
 =?utf-8?B?OUFXZW8wYm5BWEJ5ZDBVUXJacWlualF2cWtZNDJscnRjUDVyS2l6UVFoV2Ex?=
 =?utf-8?B?WW5HZmxYNDNwN0NjVUZXSE5hWVdpU0d6TzZWQnpMQ1UwTVVxZSsvUVZkc3p6?=
 =?utf-8?B?akJXaHhvd0s1ZmNzZ2lEd2tLQlJUSzRTZUtFQ0dtYmpEdXVEd1d5NGtzbDIw?=
 =?utf-8?B?Yi9QVHlBem9XRjhXbEtDZ2lQT0h3Y0NGVWtlaVZIWVBHc1k3R1VKQ2I1TUxV?=
 =?utf-8?B?bkJuUkRDNTR1N1Y0dmNnQmUxMTBKQ25iYzhPNjlPVFFycTJnU2lpdnZiMWpO?=
 =?utf-8?B?S3ZSMDdVL2p5M0RyZURGZFp4d2Z0djZNYXpxanZDOTAyMWVTVFZzbzllK3V6?=
 =?utf-8?B?MjdJK1lwUEhsS2c4RkxsVis5cWI2Rkp2dDA4dzNoQjlwa0lyQnMxSi9qZmx2?=
 =?utf-8?B?M3IvcDlERUN2Y0ZjKytkMWVIMmtISlhSeXJkTlZFWDlIczgxaEh5UUpUY25w?=
 =?utf-8?B?cVlNUno0K3VQU0NLU3g3YVVwVkhITlFMM3R3bUZMbnNVbHBIcHg0MFA4Snh3?=
 =?utf-8?B?NnlsR1BGdFpVQzJCeERZa1lCTkZtYnlNbXBhbURIYUZMdGZQRlBFMW1qeTF1?=
 =?utf-8?B?TW9mUnE0SEtWbGlzaHBLR2kyU1YyTmZjSFhEZUgwY3Z1RE01aEc5RE4vQTJx?=
 =?utf-8?B?aElFVkc1VkRSdS9TOFpLVzNJSGpkalJFeVBMb250Zm8yRzhRWXo0SVYxMGpr?=
 =?utf-8?B?VWpLMzhvcGhpWVZkeEJ2ZmJhaWpnQzJ6SGlrdkxMZkt6aUM5NlJva244MnNw?=
 =?utf-8?B?VlRRS3RsQXRGREJQb0dBazQwcXBDajI4dU42dWJEcWFxOXZtTWRkRWEwdjNB?=
 =?utf-8?B?WFBCZ0hpc0RObnhxV09tbVhvamdPNGxuMkIzaFRPRjhaeE5YZGNQcTcxbFNv?=
 =?utf-8?B?K3JoM3BKbisxdlBKTGhUQ1N4VnFydHVORlF3bnA0NU8veFZ0MG1yWTBENkda?=
 =?utf-8?B?NUpLbzd3WStET0hmclh2OXZCYWw5NThLYlRldFc4N08vd1ZvaklTVHlpekNo?=
 =?utf-8?B?ZmlPYWx3bmkwN2lySVNKK3lrUUdReXZNeHlBbUNuWmUvWGJUNGhUNjlpSHUw?=
 =?utf-8?B?eWRudTZpWEF5RHdHTUEySEZROXcydUJsQUlKVUczR0ZGWk92SDJJQUJDYWhu?=
 =?utf-8?B?VjR6blJmei9vMTRpR0tlUCtZWXlwUE1kRXd0K2VTemdiT3R0WTBlYk5hRDVy?=
 =?utf-8?B?cENIMUZoRVBUbENBeGFjNkVvWnZFUjBXL1E1ZXhzY2YyVjVDMTdBOHJVWm9w?=
 =?utf-8?B?MjRQbjc5SVppZ0lvOFlHYU9jVnpPZ2ZWZ3BwT1VFN0NvSjFER3JZT2NrZmRy?=
 =?utf-8?B?Y1V6QlNwd2haQ0I5WVNQQWpIL2JJbldNUGQ5cEJvQjMraXdBOVNwQzRScGZU?=
 =?utf-8?B?VzFlbFVEck5aejN2RXlzMTh1eVlySTI5TlZuVjFGTEFtMXRkS1ZKNFFYcVha?=
 =?utf-8?B?NUhZcURjZTN1VVlFZEI1Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHdMc2k0eEUrZEZvclVaaWNidnU3K041VzJmRThONDZPQ1NDdFdkcDFxUWJx?=
 =?utf-8?B?UzhadlZobW9KeEpJaGp3dExCSEtOZVZ0dnlLWERlZWpnV21FZng4aC9ua0NW?=
 =?utf-8?B?RE5XTjk0TnVoYk9UZ3dWTE5sNTc3YzZXZWR5NHNwd25GTGxqUXFSZXBPM0J3?=
 =?utf-8?B?MzVCOUFQd0h4Z0JPWUwvdmdzZ0JRa20ycHBJNkt3WjZBUTlCTlRZcDhxQVMz?=
 =?utf-8?B?TXBzdVFIdUxuZXU2THFkYXU5R1R6WldQaFhSTFYzdndTbVNVSi92MXh1Kzd1?=
 =?utf-8?B?eUMvQ0hwQndVdVRrL1hORjFLcnJRNUkyNFYwY1o4bHJqem9IWFdnUjZ5VHNa?=
 =?utf-8?B?My9xT29BUk9vMDVYS0FpQldNR0VRL1NFUnEyNVFxaHAwTWtac3VOYVVtb1p3?=
 =?utf-8?B?MVA5WlVhbXJqb1hGTk5JeldzNFltRHUrRzVIckIxdkczY3NORysvNlR6dTZT?=
 =?utf-8?B?TUVOODQ0ajIxMFRqbTFLQjBTb1p1NU1ya01wdDZCNlVCbC9QT3ByUEdoZ0xp?=
 =?utf-8?B?WHF6MkVzT29kTUF6Mkttdk05eTBxQm5mVE9jczhGRjN5R0dTdytZOWxpNnNO?=
 =?utf-8?B?WkR3d2piY2o2c0UzYmUrUkg4WWVuSjJ3MHdmT0xMSzNCd25VNVpBYXA2UjNV?=
 =?utf-8?B?Um9VYS85dFpxaU9qUmhpWnFyemRMRURIb09mQVE0U3c2MkVVZU9JNVplOUxV?=
 =?utf-8?B?T0VCMDBHUy9Pd3BZb0dDc2l3NDcyc3ZnTnBXaS9SUENuMmRYR3dLMURZd2NG?=
 =?utf-8?B?QTByYVNZaWEvV0FLejFneEJUd2hpYk8zUlllSDNXcmxnakNMeG1PZDJWYkVn?=
 =?utf-8?B?RUUyUjJsSWExcTMrOWJyM0dVRHVvVXFMckh5YWVoSTQ0SCtWdzRWMisxb2JU?=
 =?utf-8?B?UGNJd3Y3clBnL3U2bG5iZnkrcS9rdW1zOXg2WWZ6bTBPVU0wSEpaS1hVaWNs?=
 =?utf-8?B?UE1jaUVnV0huZ0FjYkFNUVJPdHczT0VVbHBJNnh0eGZ1SlNtYkIrbzJZS1Y3?=
 =?utf-8?B?K1Zod2VCTWh2dzMrSGJCTGNvQWIxb3JoWGxIWmNMYnp4WER0TFM3bUtjdE1l?=
 =?utf-8?B?RW1JcG9UOGx0bnh1RVN3SXY5MzJGNytqd3ovSXltRzlrR2Z5OEw3eHBHNUgz?=
 =?utf-8?B?eHFrT2lnSmN0VGdnNlZ1OVJzMjVjRXdCUnprc0Q5K0NqWnhuWW95aWJGZktN?=
 =?utf-8?B?RFhmektXWFdCemxxR0FsMmVWcGlMeFZZUkxEOEV5djVBazdyZWtUejlscDVI?=
 =?utf-8?B?RHhXQTAvaSt4NWdMekRrSDZNb0NhSzFrN3Y2RWVQOXJWN3NFRVlreVE4bjFG?=
 =?utf-8?B?VjBKV2hGcFFVTHhUSE1YNm02RVV6andpNXpXWkprQmV3dlkwQW0zMDlrOWdi?=
 =?utf-8?B?T3FDVmxiaEkwTE1zeTBnZUpDMks1WTJsRldDRWU4cFRZVjhyU21iZXl6ZHR5?=
 =?utf-8?B?SUFPZnVxa21sVjV5V0kzRTUwOHdFdHpTTmNNNnRvKzU3OWo5ZnV0bGNQWVFr?=
 =?utf-8?B?dFdkK05TYVhkUE5KejB5c1FncWFOVHhGUEltL0hua3VXRURsdndHMnNLRTRp?=
 =?utf-8?B?SXZpQ0JhakhjV2d6eUFDVzVyUHB4SGJFVkE3ZzBIS0tPYzNjT1hvNkZaeTdh?=
 =?utf-8?B?Unk4a1gzeHZHVEZodi85YVRoZ2FWcHpmaXRUVGVJNUlKbENGbTNnR3JhcTl3?=
 =?utf-8?B?UjBUUndmSzhQclpST1ZGUHJudFQ4WU5FOVVrREcySndIMStHNHJTSFIzUElO?=
 =?utf-8?B?Szl1cXNkVzlRaFZqZkdldXRsRFFFdnVlOEx4cDd1MnNTUWwyUjNNUzNxVldJ?=
 =?utf-8?B?VllBc3ZEd0pDd2hmKzN6VHBHbFZjSkIrZGgxQnAva2pXcmVlQVFjOXowek9x?=
 =?utf-8?B?L1cxbThNSDNXUS83QzlHWjJTUzZVTzQweC9iQ3BqRVZUK3VNUDRpWDFwbDF2?=
 =?utf-8?B?MVhHK29KQnRHMTRtcXhXL2VFK1kxVi85eHEreVQ5SUtzUWI5WURMUUIvbWh0?=
 =?utf-8?B?ZnFLME5VS1JibnZ3b2tJRFczRnVKam1nalRHV1RSR0RGc01xMWl5MXl6Z04x?=
 =?utf-8?B?OWZ5cXpNNk15K3p4VGZsSDVJWGsvUFdkcjlsQWdJOHkrVUlrK0JUQ1EzYmNq?=
 =?utf-8?B?V1hEK1U3eFZWenVQeVdCdVpWb1lBWkZ1TEZEejJsNERod2xNaDQ1eWgxcHAx?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/dO3HLQP/X9S6fXzG7iRlUJCiD5YzyhoTfp4Scili+xcjmhzwCc3LccB4O39FR+dkKDVfAveFvEknALoN8WwP4VPouuMIfrWyLXaMt0fIlEFOr2G2u6YMqrIbYynZ2wG1jLddTTtzkuwUyHU+Hji0M38dfsCPZKvPwCFhLv4ym4PROrVPmfrIjtnlcXS0sUn/22oJx7qNpVzK54Zmd2qxI/15ZaJtqC0cwbkp8kFr9+6taNelem4IOxl6sP/m/lgfprJFzbG6q4Pj5kgzOK/ahvUzJEuxwvHKzk9MldRpAwHLuBv9svFbr9xX4EMYDALx8zZyzG7lP6Vs91DKZwbTCPmVul+11TPksAAF5vvr2RrkLC76lefoV/8ye5x5vkuVEAG6KzkDAhhj8frpw593836yS1B/0EpgAiyJRPuMRhfeKo40be1YZopOHB+NUiSTyHhw2VLiurPLbznLgrA1RWQPWtti9I6dXO43HzSOUrQZOr2Ltueq2U6u+UbdWdDNbD3xrVI0izT2E6r4H3QHRmm4qi/21VLnxjk2QCB1dehE2ZpXgXUPa/K8Jc4ifYF4B5YnIVt6Oq9TvCDm1QJk4z7e42PK26FoQVndnw5TqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56048dd9-4a40-490f-57ad-08dd4a23b6a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5151.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 22:39:01.4155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAG7CxVPOWKOf8XPkfrypvhGH7G1zxkZilUuqRidrpEVQXhws08O5ooZm+HovTHS/rFew1HyVWGubxD9CfdcQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_11,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502100178
X-Proofpoint-GUID: gogNV0yv4CA9jwNSfLcG4a_3g6GjjwDV
X-Proofpoint-ORIG-GUID: gogNV0yv4CA9jwNSfLcG4a_3g6GjjwDV

On 23/01/2025 8:50 pm, Jeff Layton wrote:
> On Thu, 2025-01-23 at 19:36 +0000, Calum Mackay wrote:
>> On 22/01/2025 5:13 pm, Jeff Layton wrote:
>>> As of python 3.13, the xdrlib module is no longer included. Fortunately
>>> there is an xdrlib3 module, which is a fork of the bundled module:
>>>
>>>       https://pypi.org/project/xdrlib3/
>>>
>>> Change pynfs to use that instead and revise the documentation to include
>>> a step to install that module.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    README                                | 8 +++++++-
>>>    nfs4.0/lib/rpc/rpc.py                 | 2 +-
>>>    nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py | 2 +-
>>>    nfs4.0/nfs4lib.py                     | 2 +-
>>>    nfs4.0/nfs4server.py                  | 2 +-
>>>    rpc/security.py                       | 2 +-
>>>    xdr/xdrgen.py                         | 4 ++--
>>>    7 files changed, 14 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/README b/README
>>> index b8b4e775f7766086f870f2dda4a60b3e9f9bac6f..efdc23807e8107b8fcd575e8a4c80b9c73e3cd07 100644
>>> --- a/README
>>> +++ b/README
>>> @@ -14,8 +14,14 @@ Install dependent modules:
>>>    * openSUSE
>>>    	zypper install krb5-devel python3-devel swig python3-gssapi python3-ply
>>>    
>>> -You can prepare both for use with
>>> +Install the xdrlib3 module:
>>> +
>>> +	pip install xdrlib3
>>
>> Thanks Jeff,
>>
>> I see that Debian's unstable & testing suites have a pkg
>> (python3-standard-xdrlib) to provide this post-removal from standard
>> Python. Of course, that's not in general release, yet, but then neither
>> is 3.13 itself. Not sure if we should mention it?
>>
>> e.g: your distro may provide xdrlib3 via a pkg (details…), or you may
>> install it via pip…
>> or similar?
>>
>> cheers,
>> c.
>>
>>
> 
> Sure, I'm fine with phrasing it that way. Mind fixing it up when you
> merge it?
> 
> I'm on Fedora 41 which ships with python 3.13, so I think it is in
> general release now. Fedora doesn't have xdrlib3 packaged however, so I
> just used pip.

Applied, with the fixed-up README.

thanks very much Jeff, apols for the delay.

cheers,
c.


> 
>>
>>> +
>>> +You can prepare both versions for use with
>>> +
>>>    	./setup.py build
>>> +
>>>    which will create auto-generated files and compile any shared libraries
>>>    in place.
>>>    
>>> diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
>>> index 243ef9e31aa83eb6be18800065b63cf78d99f833..475179042530a8d602a51e7bad1af7958ff5dd56 100644
>>> --- a/nfs4.0/lib/rpc/rpc.py
>>> +++ b/nfs4.0/lib/rpc/rpc.py
>>> @@ -9,7 +9,7 @@
>>>    
>>>    from __future__ import absolute_import
>>>    import struct
>>> -import xdrlib
>>> +import xdrlib3 as xdrlib
>>>    import socket
>>>    import select
>>>    import threading
>>> diff --git a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
>>> index 1e990a369e6588f24dff75e9569c104d775ff710..2581a1e1dca22f637dc32144a05c88c66c57665e 100644
>>> --- a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
>>> +++ b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
>>> @@ -1,7 +1,7 @@
>>>    from .base import SecFlavor, SecError
>>>    from rpc.rpc_const import AUTH_SYS
>>>    from rpc.rpc_type import opaque_auth
>>> -from xdrlib import Packer, Error
>>> +from xdrlib3 import Packer, Error
>>>    
>>>    class SecAuthSys(SecFlavor):
>>>        # XXX need better defaults
>>> diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
>>> index eddcd862bc2fe2061414fb4de61e52aed93495ae..2337d8cd190de90e4d158b3ef9e3dfd6a61027c5 100644
>>> --- a/nfs4.0/nfs4lib.py
>>> +++ b/nfs4.0/nfs4lib.py
>>> @@ -41,7 +41,7 @@ import xdrdef.nfs4_const as nfs4_const
>>>    from  xdrdef.nfs4_const import *
>>>    import xdrdef.nfs4_type as nfs4_type
>>>    from xdrdef.nfs4_type import *
>>> -from xdrlib import Error as XDRError
>>> +from xdrlib3 import Error as XDRError
>>>    import xdrdef.nfs4_pack as nfs4_pack
>>>    
>>>    import nfs_ops
>>> diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
>>> index 2dbad3046709ea57c1503a36649d85c25e6301a8..10bf28ee5794684912fa8e6d19406e06bf88b742 100755
>>> --- a/nfs4.0/nfs4server.py
>>> +++ b/nfs4.0/nfs4server.py
>>> @@ -34,7 +34,7 @@ import time, StringIO, random, traceback, codecs
>>>    import StringIO
>>>    import nfs4state
>>>    from nfs4state import NFS4Error, printverf
>>> -from xdrlib import Error as XDRError
>>> +from xdrlib3 import Error as XDRError
>>>    
>>>    unacceptable_names = [ "", ".", ".." ]
>>>    unacceptable_characters = [ "/", "~", "#", ]
>>> diff --git a/rpc/security.py b/rpc/security.py
>>> index 0682f438cd6237334c59e7cb280c8b192e7c8a76..789280c5d7328a928b2f6c1af95397d17180eff9 100644
>>> --- a/rpc/security.py
>>> +++ b/rpc/security.py
>>> @@ -3,7 +3,7 @@ from .rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GSS, SUCCESS, CALL, \
>>>    from .rpc_type import opaque_auth, authsys_parms
>>>    from .rpc_pack import RPCPacker, RPCUnpacker
>>>    from .gss_pack import GSSPacker, GSSUnpacker
>>> -from xdrlib import Packer, Unpacker
>>> +from xdrlib3 import Packer, Unpacker
>>>    from . import rpclib
>>>    from .gss_const import *
>>>    from . import gss_type
>>> diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
>>> index b472e50676799915ea3b6a14f6686a5973484fb2..f802ba80045e79716a71fa7a64d72f1b8831128d 100755
>>> --- a/xdr/xdrgen.py
>>> +++ b/xdr/xdrgen.py
>>> @@ -1357,8 +1357,8 @@ pack_header = """\
>>>    import sys,os
>>>    from . import %s as const
>>>    from . import %s as types
>>> -import xdrlib
>>> -from xdrlib import Error as XDRError
>>> +import xdrlib3 as xdrlib
>>> +from xdrlib3 import Error as XDRError
>>>    
>>>    class nullclass(object):
>>>        pass
>>>
>>> ---
>>> base-commit: d042a1f6421985b7c9d17edf8eb0d59bcf7f5908
>>> change-id: 20250122-master-68414e8f6d5f
>>>
>>> Best regards,
>>
>>
> 



