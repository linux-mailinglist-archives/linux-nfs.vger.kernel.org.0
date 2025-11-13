Return-Path: <linux-nfs+bounces-16363-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F155DC5A19A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 22:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F4D3B2688
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E73F21FF4D;
	Thu, 13 Nov 2025 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C6k4zIHo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L3SEMMUB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D797261B6D;
	Thu, 13 Nov 2025 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069067; cv=fail; b=lbWsKFutA8cvgMxpff2NKzO+/BXrW61FKAykuhKxEw3o1gkv1mXDbJpOfjbPO8XDtUyuQm4Lzpp6RsUDHtRM8Qo70pqU+FqN5og7tn7xyZiVZ2r7ZIEUHqnhKSILiSxLq8hNUiVSGCpnvM8/6HsTR0nNjT2yfj6gBgZ7J2cawIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069067; c=relaxed/simple;
	bh=bP1lCwCewH74m4Pvp+i6ohwgufV1VsOCDMPVEEkBQAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b+i6rGrPTTtcb9q/cFE3Uqxbma/qAoS2DXt9lhfBMfQaGT85Q9KINRdgUhsKTLUPRvhstA2WbsNGm2fiTSI9ZgW3MVTToBlaOr3tH2P7KoGZ+CRUsBgRnPk0A03RdPI6Gyrf5avrLI/4DREUFITzD46FVDCUiTsXkBAXL5dsjNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C6k4zIHo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L3SEMMUB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADKN3cM009574;
	Thu, 13 Nov 2025 21:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Jwhr+66AmOyiz3nbqXJm/GzmeX9sZvpEeONTm8j1P08=; b=
	C6k4zIHo6HTK67qDZn/9TrIqcW6AGT5rcSBxa7napmGE10gEBeLEGrd3kc+NnY4o
	2Yc3+bmUcdkcJkoblEZFmuaaH86K1feaDLbVhm2s/a6GbUJeiLLq6UEXjwJ/UuK0
	u3cfAfeHL2Sh1SQi0rEZ5CjG9YNuPvo5JeZgVakdDH94/0DCsdL3KSAclVhOQ+YG
	atAiTW1C9AY1tfMid4xfoyZu7uV/RVw1BwXnoDEiKmFQI/Yn4yIlJeZd4C5nDlWx
	szmyrOKZAeZPDDis8M99cnJUSqct63+kPhV9gef2qwtdkTaMZww5dNGvqDHqiCvV
	/TEWm+rRxi6Z8DRVQEHt9A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjsatje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 21:24:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADL7Cpc027744;
	Thu, 13 Nov 2025 21:23:59 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vagrsfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 21:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofR1UpzK4masCkj4SRj0S+vybMN41S0syr1yzR7e/qpSVzNBlafvdLBa3uNsbcFqMlU5P6dnUhpta0OZMmRqOSbFjFpZde2C3btS47hYN8aRNhHtQl3NIV3x9A1GwvdUcRUEvbtr8qmEbXR82dfc7ywh+4JUdfBAAt9j2JHtADDJqTxGXIQPVoYXGgLDGmcIMP9qFqmo6f7lniwTLj7Tg5s6Sk9MeQlgcbc/jmAnV9XcwhpukT+vaYaC+7X3+1GyTJkl0TtAVOy5CxKH07zwyHDyxaNwwp0bcE2u9Ez/OoTkAm+MBQrQSvePa0/gD/a99wesADdcBUKH4eiRtRd0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jwhr+66AmOyiz3nbqXJm/GzmeX9sZvpEeONTm8j1P08=;
 b=MA3P+qm5yM1nLlgPnqKs0f3wffxadl7xTuj/t0BYqL2T4Lw0JDfcW9iDfuTR2K6aNl6Sw5b1OWDBBnuNOT6K2/N/da5a5Tw4/bUuDHQJFMub2NOt2VdBBiSbOm10KyrzyGjMdfo3CtiljQCsuKslVw//iuE5WK+5gXEb4bA27XVJAq5DfUdVC71iAqO/V2Awh/EzV4TxHfMbE3vfV+sbUVlvUx+myuGLw/5C+QqWaYZZnPYdQtejM5aLLWztKNH4KPDXpwK4IyrQhzgc9Qfx6+6FEgY3wWaaXUd2ZIy7xsP2vaswLIYs4SLRR7LTmF+S763W2x/dMJOaKPfWM2hk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jwhr+66AmOyiz3nbqXJm/GzmeX9sZvpEeONTm8j1P08=;
 b=L3SEMMUB7N2bRkfWnSzGPERXkYqvBzv8XBAUszTff6gCcRUzG4iNcUVSbNjhlHnF1TEkxuqy4bR+2TXzyAQp/dTAoZFnrPtWGUOKgOGrWsMFfnY/zSqApFPcx/5YteoujzRJq1f1zWpGJX3YyX4H1VdgJt1UnljibQE89C7j4yE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6508.namprd10.prod.outlook.com (2603:10b6:510:203::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 21:23:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 21:23:54 +0000
Message-ID: <1cee1c3e-e6b9-485a-a4d4-c336072f14c3@oracle.com>
Date: Thu, 13 Nov 2025 16:23:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: "Tyler W. Ross" <TWR@tylerwross.com>,
        "1120598@bugs.debian.org" <1120598@bugs.debian.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
 <aRVl8yGqTkyaWxPM@eldamar.lan>
 <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com>
 <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com>
 <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com>
 <aRZL8kbmfbssOwKF@eldamar.lan>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aRZL8kbmfbssOwKF@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:610:b2::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: 44523688-c80b-4ccb-b0d1-08de22faf2b9
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|159843002;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZUQ2Y0NHNEliZU9FeFY1Y2ttUHladDhBTHpCUmhDelRRMXg0NnRBdFFQZGVy?=
 =?utf-8?B?VzJDMnQ4YmdESm5WbzlJQkNYbVNUazVRbEl6NVlhZk1acVBnOGtPQkRoeHk0?=
 =?utf-8?B?dTVYbHU2clRXRm1JS2NrYmxmUFRCb3ZpamdLSUZGYjRhNDRidWNtNTEvTTJs?=
 =?utf-8?B?VnJhbXpNSFo2Q3UvRUw3bnZWR0tDa01zaC9tbEo4akZuaC9nYjBxTFJYS1A3?=
 =?utf-8?B?TDFkY1FKcTR5Z1VCMVhlQ3JJaUZUYnZhb3NGeDZuSGZERGZDS0pyVVRyaVRh?=
 =?utf-8?B?aFNocVF1MnF4UG9GTXNFOXhhMjgyRzNSRkRsRXhvM3hMVmc4UG03b2RTb1Bm?=
 =?utf-8?B?ZmUwZlZLL0hLUytrbmxNL1pqTmJPSVhNRXU5YkJ6aCtLMm1uT0p6b1NRRmpP?=
 =?utf-8?B?OVRJOExxbm5DeHhITzl6SGlEY21nMXZIMXVUQkJ3NlR0RGF2WDZjeHErY0dp?=
 =?utf-8?B?UWFiOFFkaUxNUVJnWDQ0Tkl6RXphbnkwaHAwaWNCZm42US9rT2dBY3RldkVJ?=
 =?utf-8?B?K09FSjNXa01WSUJhWDRncmQ4ak16d0JTRU4rRy9OVkFLNDVnMzBCQ0ovRWRk?=
 =?utf-8?B?d1J1YlRaWXNPZjh0Qk5Bcm5XZVlNWmlKejU5Szl0aE92TUIxbTNUTGhhMWN3?=
 =?utf-8?B?enFRWlZ0b1U4dDdLR1MvclBLaU1nc2lOOTRLdkUwU09KRVNkL1g4OWxqRkIy?=
 =?utf-8?B?cXdFaHRKWFpGVXpvL0pLcXJiQ0hKMXdFMHVqUzNBYVN4YjArRGZkQXVyM1JW?=
 =?utf-8?B?U002ZlMvWk50UXJick5QS3FiZE1TNG5ZT2VrNnMzdnRZcDBFVHRTTWdYbWtM?=
 =?utf-8?B?YWpXdHVpcHZnQ203S0dmMjA5all3UzNvdm1CNE45aThaOEloUGozeFc2R2FC?=
 =?utf-8?B?bWJuc3VVdEZjMUZxTFBMZEtpcG9pVzV1WUR2SU5TaGlRRVVHWmQyVjkyQk1r?=
 =?utf-8?B?cjl2UWlNTE1OQ05EbllVR1BVaENWQkl1YlBZbFd1QVZYcHJibFNVYUxJODVy?=
 =?utf-8?B?MmNRQ1dVd3hSS25sM2xPcjJXNkR0TE5uWmhCamQ0MFlvaXB5WmhZbHk3UG90?=
 =?utf-8?B?WnNZWkN5c3FUZGNCSlFIRTIyR3FCek5XM25XR2U3aHFKM25PMHZzODA4aFNi?=
 =?utf-8?B?YmEvNzVVa1J2WDlHZzFtSUVjd0duU1RJc04vWGQvejRkeUZoZWVlRDA5MERE?=
 =?utf-8?B?SEhTQmlOaFdaRjI1bzQ1cndNcEFXOE9wYURtdzVrbWJ3cWhBVHpZc09GeW5q?=
 =?utf-8?B?UVRjb0tXKzVlZXRsUWtyRmdCWFc3L1BxMEdwVnNSR0IyNHltazFMVUZNWXpJ?=
 =?utf-8?B?UkdZLzhSYkh2MHUydzVzSjJwb2FGYnE1aHc0MklzaVY3YmZLdEhjcnlmNUha?=
 =?utf-8?B?STlEc0NxemZkbEJheEx2Q1k1RTFORU5TRVlZa0JOd2c0RkVGeEZnakpXQTRm?=
 =?utf-8?B?WDFqMElWOTI4NDNkd3BQWG9rK0t6VG5aY0NqMjVCTkNqZlV6TTFDTjlrbEk1?=
 =?utf-8?B?T25MZDZHb2lIRUpMT1M2bW15S2Y4Z3Q4c1pQM2VaekY4OHFDRGRFcEhjTitw?=
 =?utf-8?B?R0RTQjdObE92czk4UzE4YXkxUVV4eUw4MUQ5ZjBuWVhlR0g1T0ZZWFBPY1k1?=
 =?utf-8?B?SEZ6K3ZwdmU0Y1YvZU5hZ1BJUTI1dWxQNHhFbzhZS1MyRStzcDhyTko5cWRN?=
 =?utf-8?B?OWZXemF1Rld2QzZ3d3BlSGNTYzlqTzdyclo2dkRhTFRHUG5EODlmenZCK0do?=
 =?utf-8?B?aHlMWFVSMEROQ3h0RG5abFRIYm5sTVdXcUV3WUV4bVpPK29HM1VWdFZkQXBX?=
 =?utf-8?B?UXBIOGx1ZHo4RiswYjZSSExZL1FUNUhBRGFMczM4cHIzM0dJYjRRWG8yK3N0?=
 =?utf-8?B?K1dKQU51NXdKSldIemljNXpJTndiSEI4b3NCQks5VmNoSFJzTkFNU3JZRDZk?=
 =?utf-8?B?R2UxU0FubnV3Tms4ek5mcHhHbTVSb05XaUpDSFhUTEhHZk1oRGU0cjlmNytr?=
 =?utf-8?B?SWtyQW5JZ2lmZ3V1RWhRNkxvVnlDKytRbGg2Uklobjh1ZG96ZzFuZVlSdXVV?=
 =?utf-8?Q?RshUp9?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(159843002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bGR5bzY4Sk1XK1Q5dGpnN1J4R293RkJMWjlqMytUSVMwd2hKZlFxT0FFUGxp?=
 =?utf-8?B?cWprblNUQzFTOGYwcDYyTHlLOUl3MFFyc0hVVThJS1pOREF4czF4aTYzdWxD?=
 =?utf-8?B?aldBMFhRM1lQemZYci83YUFiVE1FNGRmWUhyZ0xDbG1XcHI2UlkwcjB6YUk1?=
 =?utf-8?B?eWZpUGk2REdURjlUWEtLbGp3QVE3VVVsL2paRUs5U3dBMW5LK2N0cXhDT3lL?=
 =?utf-8?B?UmRKQjFnWi81ZkJSbXcrbWdQZFdmMFVHQW9ESVAwbTI5V1lucDQ4eUtpb1BH?=
 =?utf-8?B?RlZYRThIWDl3NUlyQ0g0Q3BvVmRXTmZwSjJVajgzY2hwdThsbVQ2eGhzN25V?=
 =?utf-8?B?Snk5UWs1SFhlS3AyancwNVp3ZUdSSjdGTXFEbnhmaXljaXQrT3RJTUQ5d1lh?=
 =?utf-8?B?engzQ3grb29aem4xQUdsaHlSZDlRQkF0MThqVjJEdzZYRWdwMzg2c3RyOHBS?=
 =?utf-8?B?blowZ2xSNjNKYzZPRFF6TGQwaVlOaWRpR2l4a1lqUW1Ha1U1WC9EQkNkVFpM?=
 =?utf-8?B?RUxvNVFSa2VBSnFoS1YraXBsK1kzZzV2WVBwMGJkdEpqRzd6Y2FTQkV2OHho?=
 =?utf-8?B?YnFFK2ZQUy90UGdoZldtU0hFYU54UFdIbDlFa1pjSHZOdjcxaUVFcHcyQXg5?=
 =?utf-8?B?K2xyNndUZ0xjbXc1ZWptN0dVZEJTTDJBVUpURklGMTJEMlBOZWNlZ1pDdGVv?=
 =?utf-8?B?ZUErTkVUTHI4MDVUV2Rjb09vQmNRTDRXK3haZmtWSWM1dHpNUWF5ZWJqc0l1?=
 =?utf-8?B?d080RW9ERFhKNmtyajFHYUdON0p4OTlYTWh3d2ZhWmtUK0dUclpSRFdmbGhP?=
 =?utf-8?B?OGtoTldCZGI3VDFCRjhnc0U5cFVDRUtyMjBDNzFLa0hPenkwdEVDZG5MODdI?=
 =?utf-8?B?citXZWd5N0Z4RzNwdktZV2Rwd25jRDlRejk5dkR3RUtRa3ZCRExrdXNhaWFU?=
 =?utf-8?B?SUhFTXJrRGxSUVMvYXRtcUdNN3c3cnJnTC91eXdFaHN1M0lIUldnWFVTc1dM?=
 =?utf-8?B?MzVHUnFHNDBQb0o3VFYwVHBROEVCVFIxM3lWN0tlam4xeG5XMm5OL21QWG1h?=
 =?utf-8?B?S3pCbDZMaGRkYmZRQlpaNmVpOTJYbEoyRTRuOVA1TndsMk1UMk9HMnVWSXU0?=
 =?utf-8?B?Q2xRaHJ5aFc1cEduWnhiUm5PTjhmYStPMk0wQXI0MGpBb1dOM0lFOGcrY0ZQ?=
 =?utf-8?B?QWU4dDhlVjZYSG80RC9pN3lUckxyUWRuTVAzVmhveklrck4rYnR3ZjlJb3Z6?=
 =?utf-8?B?cmpFazl4S0NxMzRLREpSaWx5Qzk0d0F5MEJwQWU1QnY4VG1aRUk1ZmFaaWNM?=
 =?utf-8?B?dXlDWnlzL1NxUWVsdlNmNHlyaEYzUWJHUHhncDRnR0lBeEtkLzFFeGVORFBN?=
 =?utf-8?B?M2pVeGQ2aGplOVZFU2piMnM2TStyLzVNWDlqeUh5VE12VC9ZazdvK2NRc3JW?=
 =?utf-8?B?aTRBN0F0VmlDRjYzaHJFNER1RFNVNTEzL2FpbnNXMVp2VzVtSnZpVzRvUUFV?=
 =?utf-8?B?U1JnczNKVjdvM0xFdlFhUDhjdE5uUU9UNGlRSVpMN3U2Y3hXSndDSVNEMTVK?=
 =?utf-8?B?eGNkY09STlNxNG0yNjVNVXlieFBZYzY3MGJvMHBBeWFXcm04VUxFb1dKT3Y5?=
 =?utf-8?B?UUpsdUVQK1R3RXA5VnBWTkJ4T0VXVTVtM0VyWDMyQkJjak96NFovZi8wMW9t?=
 =?utf-8?B?eGpPVDBWTzIxd1ZOSGUwcEpLY0s5K3hkVTRrbDkzLzFHdzZiYnhSaHlGV00v?=
 =?utf-8?B?dmt2TVE4d1JWYnd6MlFRZ3h1YkYzejczVVhGUWs5dmY4Vnl6U1lrVmdXOUtt?=
 =?utf-8?B?UmtXUkhCM2p3RnZGUWZSdnR3MkRpSktCZk1yZjUyUVpuWXRuakJnM0QwdVln?=
 =?utf-8?B?RVlkcG9iczQ3RlhHc3h6WTZPSlFQQzdFY3Ftb3c4a1k3aEpIOUxETHZZVEhi?=
 =?utf-8?B?ODNXZTJ5cEVPclRQUXhKN1BwK0pBNWh6YjVXOUhXR3RGY3JKMU42R1B1ci9o?=
 =?utf-8?B?dDZIdTFXSjRkazVrUDZWakgrL2Z2VHQwTlh1a05jSkF6NDVTaW8yZ0V3MGk2?=
 =?utf-8?B?a1pZL290aU9DQ2tXZXhRUmt2ZGpFZms4WDdkZHBTZHF6cUxtZkMwRDZrWmdT?=
 =?utf-8?B?ZXVNNThnZHFEUnFDcnlUeUYweDdHTzh4SklvS2M0ejVzYVM4aXBKMFNnZ1lS?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ehuxgddd3olkIjlyieK27Fnqhzx2dxnQdGWqiq4aoG1eZuroCoNKr1wCDwZegWISslNtxZYYRl3VZGRYH6t481siZttQ9V2wG453eVL/mN7h0qmYSZAcxbYtpkyo6DFnS306M7mMMGRVx1d0gCVWpadh9ixTv2lfp4okcE6hpFqh0nzoS33WRpBpbL6ieOmA2/5gsyeF/5hf7U9k4bRP6pCzYzBJDrL+dv4Diy68yVz5kmBc7BOPuA/LJ6DcKUQey4kmO1TrFVsFbuhLksTXBnSy6EH6ZpX89RjsZ4Sq3AUyNFQ+GeyN/yxrZZlpZdqnppfG+ofjWu3tw1tAebFTmK8xJ2J0tUACt9EfX/NxHQLuZzt3cgWQCkoy8IK4eysWJc0TL7+A1N+jjEhZbRHqsVuLvBRi273IU1IqIbB/0D+YNS9Z2KOQF5WZWdnIX11I9cpp2CmkgdbVFBssryvQI0yr8RDD9DTjElqXjvkEdyH1v0T8ot+gJzA/kTMsEfKGTZj8p564VJEbKzubjrRC34sHR15UxxAnJWm7BLuv8jkQpM5DrJqaZ2ueGcmv5OvfsTU248UYU/eXRxTHU7TxLPGdXJEr0E9Cg9HUuXNnl2A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44523688-c80b-4ccb-b0d1-08de22faf2b9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 21:23:54.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMfSPB+1QoHM23mJiLRpLkdt7v2aYiOQYdq7epSPZXDLoKrkhZ9tAgyHoyEzANZhzuYJIF3EQ/hrhFVageSQMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130168
X-Proofpoint-GUID: cypXezH0ruS4Gxesf0ijICW1u1b4Dn94
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX0fPBP47jZyLg
 r0m4inTYM2YAQOxGZoOASd+3Qiboongv+OJz5P/I/Zltb2d72CEx446QeT4tOSpu/nCZ8pUt2Yc
 1RmqmyAQiuzbBALNRF9lJPB5Ho2GBsy1l0CIrVrXJay0rkibKSDK9lpexijvOZFjNNy9XjttcpH
 FFarS609eOkz6OpIBOTSkcP/ahkcxvoqcbX062OjtaDDpWnBzK9e3jfafogqMH7RCBQYXZlSIez
 +3cZ462x7dx2OlexmwgyNxhH3FB9R7j2cznwxLHJ5i5tcOq0V1HvyNFA0qUZPBqjs5vLqvYpea7
 beth/LvEYng9irGZIEZF8BiCS5fkg8zlFOm2I3Q8atPoBjUEFaVyOSV84p6LlYPirC+7LIeb4wW
 6SfO4UsMGxn2MGoWix7q8evrYajEW/gU9XAUedimV7ixnXKv/T8=
X-Proofpoint-ORIG-GUID: cypXezH0ruS4Gxesf0ijICW1u1b4Dn94
X-Authority-Analysis: v=2.4 cv=HLzO14tv c=1 sm=1 tr=0 ts=69164c70 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xNf9USuDAAAA:8 a=lKAPlzk8MYohwNjfRBoA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13643

On 11/13/25 4:21 PM, Salvatore Bonaccorso wrote:
> Hi Chuck,
> 
> On Thu, Nov 13, 2025 at 12:47:23PM -0500, Chuck Lever wrote:
>> On 11/13/25 12:16 PM, Tyler W. Ross wrote:
>>> Thanks, Chunk.
>>>
>>> Suggested trace-cmd report from the client follows. Last 3 lines appear salient, but I've included the full report just in case.
>>>
>>>           <idle>-0     [001] ..s2.   270.327040: xs_data_ready:        peer=[10.108.2.102]:2049
>>>    kworker/u16:0-12    [001] ...1.   270.327048: xprt_lookup_rqst:     peer=[10.108.2.102]:2049 xid=0x7b569c7a status=0
>>>    kworker/u16:0-12    [001] ...2.   270.327050: rpc_task_wakeup:      task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=0x6 status=0 timeout=15000 queue=xprt_pending
>>>    kworker/u16:0-12    [001] .....   270.327054: xs_stream_read_request: peer=[10.108.2.102]:2049 xid=0x7b569c7a copied=988 reclen=988 offset=988
>>>    kworker/u16:0-12    [001] .....   270.327055: xs_stream_read_data:  peer=[10.108.2.102]:2049 err=-11 total=992
>>>               ls-969   [003] .....   270.327062: rpc_task_sync_wake:   task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=call_status
>>>               ls-969   [003] .....   270.327062: rpc_task_run_action:  task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=xprt_timer
>>>               ls-969   [003] .....   270.327063: rpc_task_run_action:  task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=call_status
>>>               ls-969   [003] .....   270.327063: rpc_task_run_action:  task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=call_decode
>>>               ls-969   [003] .....   270.327063: rpc_xdr_recvfrom:     task:00000008@00000005 head=[0xffff8895c29fef64,140] page=4008(88) tail=[0xffff8895c29feff0,36] len=988
>>>               ls-969   [003] .....   270.327067: rpc_xdr_overflow:     task:00000008@00000005 nfsv4 READDIR requested=8 p=0xffff8895c29fefec end=0xffff8895c29feff0 xdr=[0xffff8895c29fef64,140]/4008/[0xffff8895c29feff0,36]/988
>>
>> Here's the problem. This is a sign of an XDR decoding issue. If you
>> capture the traffic with Wireshark, does Wireshark indicate where the
>> XDR is malformed?
>>
>> If it doesn't, then there is some problem with the client code. Since
>> Fedora 43 is working as expected, I would guess there's a misapplied
>> patch on Debian 13's kernel...?
> 
> if it is helpful: Debian follows the stable upstream releases (6.12.y
> for trixie/Debian 13, right now 6.17.y for Debian unstable) and we try
> to keep the patches limited which we apply on top. So far I see none
> which touches net/sunrpc/. The patches applied:
> https://salsa.debian.org/kernel-team/linux/-/tree/debian/6.17/forky/debian/patches?ref_type=heads
> (in case this could help narrowing down more the issue).
> 
> But we could try here additionally, if Tylor has the possibility to do
> so, to try directly the 6.17.7 upstream version without Debian patches
> applied.

A bisect between broken v6.12.y and working v6.17.7 could identify
what is possibly missing from v6.12.y.


-- 
Chuck Lever

