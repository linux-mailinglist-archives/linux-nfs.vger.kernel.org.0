Return-Path: <linux-nfs+bounces-10141-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B26DA36F82
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Feb 2025 17:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 292577A21D7
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Feb 2025 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762581624CA;
	Sat, 15 Feb 2025 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="klIiTYw4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qoE/brQ8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506911624F0
	for <linux-nfs@vger.kernel.org>; Sat, 15 Feb 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739637698; cv=fail; b=FdD48Qnjl9pcEG1opo00gv95xwB1TwETEaqDi8iXnVFBMazN0hiFoGzECkp5MRpUng6mwFSwWmYTxGmlP/Wo0adcn2+AZqZRrAn0bd6nQfHv4s0MYPGJvpWSqItGTw01FNYpV1jo/dNLBRcmwvREmRZh7Wd6sE6B3bn2/RuMjQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739637698; c=relaxed/simple;
	bh=dP3QHUgq1zKyOBPdUxes+9sPnqCCmGNT/dHvz/1FDZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n74K56BkcmwFZhzAcsVTbAqJjKTy0QCO9jwoSaZtlddvQwEUUNICfM/lJM3gbs20j26rYT8e/Dur1RdQ1/X0+mstqza10fEnXJ/eKdqza/ijUb9e7c89yvHaqy90XRszSYuRoCDlHwGS496IliGRsS1f/EwnG5Yu1XrPr1/laBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=klIiTYw4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qoE/brQ8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51F4rmGm021844;
	Sat, 15 Feb 2025 16:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JG5x5rQ3XJ+IlJTqj1BYouKH9Wd4lfnM40y2pD/xsqA=; b=
	klIiTYw4Rlp5Jvj2Lo0dnsUwCSjJbjcj4HyVpxp8UtG6M3mNEmhICjJaZYZCMiW9
	3sS08UQeIKwyoGW9Uv5vMq7awDbzCK+mUtVFAmrpJY6Nu+gP9ItVmVfvBLYaNpp+
	1mK7TclV2bJExsF++G2haCyNnlWmmd212qqBcRVKMm4SgRlmy3U8gzwzUffzk9Ux
	YFhBzZROOVG2d9FS8tCgVAD/7TtmGA6AUXHrevbaPwa7uIQ8BzabIJYfqQgtbISp
	88vkb2asTuNRnNNgLV9cL1xyYBPZLvChT3gLR2fKDxiN11NN4EjK+NDf1nPghNFp
	DKhP8t05EtJ4PwojpOVFpA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thq2gjfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 16:41:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51FDvlXL036697;
	Sat, 15 Feb 2025 16:41:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc6dhsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 16:41:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qksYf/vKJvRz40hHA1erJfAUr+Y/h9/09KJYcnsYcwY0DqAFvkrP3JRUfvtbLxUcZAQdsrYfnh5NiiIKD8OoohqK/Zo2K6L0aaKLHCbmrIM6LBiTLM9CaibSdGfsui+XT3LmPt5khXAt05msKUlDKH2GzWcdMPwWu9mf6erQJWiPAaOMk5Bnk9pCIUtlmXkAxTYvK9OQpwyAKRkNigpiufVq3wVVpfkh9qw1dHBVmnTyHb0fum2XtVAvxWVYpLK4urynXaacilsdvz1VKRrKS0uPGHsZhsU7dt2MqLXVyU/MKC/Dnorap/cKzHCwknHIfbLpO06Ol6mzui+p13Nnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JG5x5rQ3XJ+IlJTqj1BYouKH9Wd4lfnM40y2pD/xsqA=;
 b=URndQqbhgmDJUYJskPTRd6Fa0cIp8RpRflwOMfbprCWLztuYE+O76P9JBN437sRAqqK+l0hXz6CXmP/Mn620kpqlFQY6LmRXQmO8GCLcko19AhSrJXWF0r6WWPnceX6MsL1SaNG5q3LVoMtxmn8idYov8EJEt+tje7al23QcSNvt8cLAXSPXYhHEcM2/YjC8115qyvF2dxEo4nnmsSRkl2aublmNRUouRBt/lKis73r2d0SqCfWoYeinhksJscdRkrcPMO0ei4PimVGlfQqQnUv0r6ugEWI3ilnuDBw3F+w3EiwnZg7HhTGpWTPmZFeEPNlXGjpIJdUIavgi7vwU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG5x5rQ3XJ+IlJTqj1BYouKH9Wd4lfnM40y2pD/xsqA=;
 b=qoE/brQ8f8uLwkeUOuzgc0QS7RyiYdI18vXKtyqVZbctaxOtUq6RUucPFySbsY+6BS0bP+t9p3CfuJk3EpLJk3sFAFuB/l7tNAnPouhxI6g3jZz6Pnk8pzvVVWmi1eicyVLEHEaxdG8R0uSiKoqEVaEz7nCf2XhePqpwQWwa6X8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5826.namprd10.prod.outlook.com (2603:10b6:303:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Sat, 15 Feb
 2025 16:41:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.017; Sat, 15 Feb 2025
 16:41:26 +0000
Message-ID: <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
Date: Sat, 15 Feb 2025 11:41:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfs compile error nfslocalio.o and localio.o since v6.14-rc1
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Mike Snitzer <snitzer@redhat.com>, linux-nfs@vger.kernel.org
References: <20250215120054.mfvr2fzs5426bthx@pali>
 <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
 <20250215163800.v4qdyum6slbzbmts@pali>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250215163800.v4qdyum6slbzbmts@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0301.namprd03.prod.outlook.com
 (2603:10b6:610:118::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb7ba35-c108-40d0-66cc-08dd4ddf9723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TENQazNhRUZJRjU4bjdrcjNFaldZSXV4RHpmbFd4Q2ZUYXJyMUFtVGhPUEhL?=
 =?utf-8?B?aDJHbmhOQ0ZNSFRwQWRwRDMwVTVxSHZPcnZBRzNCUHFGa21vMENEZldoQXND?=
 =?utf-8?B?TERudWtJVnJnQ29XVER1Q3AxRVRDTVJXZnNXaDhGS3B6UElkYlp6enRxYnBs?=
 =?utf-8?B?aTZPMEhsbzZnTkpRMnpScHVhVTdVRFN1NTZqbGI1ZU5EeUwybEQ5Z0duZzh5?=
 =?utf-8?B?cXhDdVBmdVVzRE1Ld3lmTGNMakk2UUhvMk1ObWxQQkZmdUFRZzJzN2EycVFW?=
 =?utf-8?B?bS9tb25Za2w0U0xKUHIrUmVUSGxQZ3JDRVE3ZWk1UmdyOUJEWG53Ylk2NTdm?=
 =?utf-8?B?MXIrMk5XdjZFNW43ekFiVHpYNGVoK2JjWWhtdkxPUWxiY3VCRkxIbkdUMEdu?=
 =?utf-8?B?OG5OYUNOQWVxM2dPSDRsZEtPbW0yY2dzdTVhU2lmTUJOa1RIZU0rMUJOVzBF?=
 =?utf-8?B?NnFFUUxpaGt6N1FWNm1wek1rYUxTKzY0MWFMUXF4aHhDdkk1Smp0UmoyZ2xC?=
 =?utf-8?B?MHNOVWNsSStiWGRoS2ljY2Jzd2lNNUNiaHI1TkFxbktSRnFha294VHdMdkxJ?=
 =?utf-8?B?S3c3bWMyVEVaZXV5aytXc2xDcXZoczhnQ2JMbFVKYTJhZFhPR3JaNGtMYXZm?=
 =?utf-8?B?eXNXMXZJQ3NuRFNGVndGdVNtbnZVMk1lRGgxR3J0ZERWdklWdU1hOVlQaHhl?=
 =?utf-8?B?SVorOVNyTXVJNVgyQ2haVnVPZ1ZXcG9yUWhZaStwUm1jc0Z0YkIwUGxRV2dk?=
 =?utf-8?B?ejc3RkpEQVQzSUs2L204UzNmUFc1UCtoMWFzQWJIQkdkYUdyZ1pWNURCdmVr?=
 =?utf-8?B?UUNKcWtaVDZ4WmY0TlFPTFhCTjlhaHNZbTdBNlhNcUxrK3VGQytOVmNOUUJs?=
 =?utf-8?B?a3VITy9lOTlzRzNrQVhEUDdiWlZseU1rKzhjUjFHVnJwNjd0UHlyQXFralBJ?=
 =?utf-8?B?dnlaZ2RBVStpNkpLMDgxWmFFV0U5QkhqRGZ1ZzhVbWFjT3NVU1ltOEpZSXBH?=
 =?utf-8?B?OEdZRkYxMWo4WXp2b05BNFd2bmM1dnVqSldoUjlFSUZOWVJNRWxhSDJkZkFT?=
 =?utf-8?B?VS9tUmlxdkw3Q3F6bUxpMXVEcFRqNm9LZEU5ci9mSlNBQWJDYjU2Z3oraWsv?=
 =?utf-8?B?Y0FkdVZ0dlQ3MDlMZTJlSWhZMVNURFRVTlA4TU11ajVmYVk4Q3hma3NNYzd0?=
 =?utf-8?B?MlI3V3JJSFBZSXdWd1NlZXg4MU9QM29xVWtMR0lUOVlOd2NzQ240bHNiVEhM?=
 =?utf-8?B?a3M4VHFqeDBSVWV4eW5XUnNGQ1cvTFVFVnpVS0pxNE51dnZKNktUdUd5SkNU?=
 =?utf-8?B?bW9aVmcvWkV0N3hJdkh1UEhPS3FVYzg3elFuTGdSM2dONlVsbWdzRmRUSXpV?=
 =?utf-8?B?Ulp6YWNLakZyN3FpV2luNXV0RlI5emdPbjdlUXFDU1dWNXo3VDhrL2JzL2RL?=
 =?utf-8?B?NlpVMEpiKzFxM3h5eTVIR29YMEpENWJGSW1WK1JRbjFQRlJ0Zm5jWXVvOExS?=
 =?utf-8?B?TFBqZkkzdlVUSFpleXNYaGdaK1ZaZm9uOTVPYnNFQjh5Ty9DVWZXVFgydkFB?=
 =?utf-8?B?SEdrMFVuUFgrNjlURkZ5SkpXRVVoaU1kamF2dXl6Y1M2dUJQYkNPSklsYUlF?=
 =?utf-8?B?YlY1MEk3K2VHaUF2RVlDZmoxSHBkaE4waW9mNkhvaTNIbTFnSm5oYmlJSW96?=
 =?utf-8?B?ZGdibUdIY0xlQWVQUjBzb3RrRXRIQnZDeGVhVlRxK3I4bUVCOU1BdlgrYXJO?=
 =?utf-8?B?QjR3eU1iVXI2QWZqTjErbWVwWVc2YmttUjUrSDdLT2l5SDVoWXZSKzNpcW52?=
 =?utf-8?B?akVuODJJZE1EM0hOSWRlZHRYZTNOWFFPamQzbjBWWjBTRjM4Q0dyd1hSK0pu?=
 =?utf-8?Q?Cxqx15p6us4cs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGJyMyt0RHlmVUlrc2pEa3R6cjRxNzJqVUVMSjBwWlZrWEFlV3pVdXdnYkRa?=
 =?utf-8?B?SUx4dWZHYWh1T2c1QzZDSUJONEM2WHJGeGdidmhSQm1xMExXcStIa0FlRzdI?=
 =?utf-8?B?eEZjd2xidDFaNmNIK2ZHek14VlJ0dW4vUGRPdFo4Q3ZjTVJhc0c0SVFnSnR1?=
 =?utf-8?B?VWtPV3lSdGhwbzJnalRYbENoMTFHYVJEZG1kdG1UVjJPTzZkSU92U0VrdTVk?=
 =?utf-8?B?SndXU2grai9QaTc1Q2lpZG0xNFNCdUZuOG9QNHh5L0hqdlY0cHVpbmh4ZmlU?=
 =?utf-8?B?THpsRElJOUlXSGpOTnRQZnEvN3hiNzRaY3cwWjhpRFRRWFJxZ051alhxb2tY?=
 =?utf-8?B?cGdXTmRRdXZTTWlPK3RBaUZEa3dTcVhyQ3BmdEgrUXVRZlU4Tm1Xd3RCTzBp?=
 =?utf-8?B?cGsyK293L01BUkR5Z0xicytuMUczeG1veit2M1M1U2hPV1ZsbHBUVjc3eTNy?=
 =?utf-8?B?WE8wYXdOc2lyTmM5WXc1V1NzQWl4M1hjVkNYcVZUMGs0b0YzSkpHYnYxdjYr?=
 =?utf-8?B?T3pVaGdiUWc0Wkh3bUM0SGhGWjk1dUwwc1g4azlYaVBzeVJta1dLeW5JWkxE?=
 =?utf-8?B?QzhQSVV4MHdQZTk4WkNtTWg4SW9saHlKRFAzNldFSHN4YW1peEFvalN0ZFFP?=
 =?utf-8?B?eTlxaVpRNk9aVEpCc3hmTGN3dER3ZE5HSElDRE5ySjR4bE1wT3MwRnd4MVIw?=
 =?utf-8?B?cTRsMUhSSVlSN1dwbkdESTRtMzJSQ081WjdSNVkyNzEvUjQrTGd5K2VQNlp5?=
 =?utf-8?B?b2JTMnJFd2czdDg2TFY2bmptVzJZaHpRNDNYQkJSRVpSQ2N5bDVSVkI4Kyt3?=
 =?utf-8?B?WS9QT1prT1Uvc3ZzNTJYVEdlVmhvbUsyZVBEV1VLUkNaNjR4RkFZQktiaUZp?=
 =?utf-8?B?bDFJUTd3MDErMzRuQURhUVBTSERPNE8vZjFwQWFGOTF2cVhnS1NianRFa1ds?=
 =?utf-8?B?Q3dxcnVsVmUrdU5xSkxvakxOY1RtNCt2UnhTOU9NTzBCMjNHcXNwZjZLcmFI?=
 =?utf-8?B?eno1KzUvSURHSWxmRHpLUnZXb0V2V2ZnS1MwWnZCdVdDUlAwYkVmaHcxVC96?=
 =?utf-8?B?WGNNbitVUS9HTVFFSHkycnlibXptcnpwU0wyd3RuUFBZbEEwOFMyaFhFWDg0?=
 =?utf-8?B?cjVGZEpVZk1hMnEzMHNHQzNzaGtaU2lWN21BN1VRV01BeVByQTNOU2ZHYmhj?=
 =?utf-8?B?L2ZWRVR6eVFmV0hWTktpVk9yK2NkcTJkQ05ZYmdZeGxUVGVwc3prQW9FNmtZ?=
 =?utf-8?B?N3phcXhRVlRQYVp3eUVXelF1djFVZWNrYy9XMzJiaW8xVlFFdnFlaWxUTXV3?=
 =?utf-8?B?VjZqamhMTnVqam5scDFXYUdJMHdoR0ZkSjJnWXFOSVR4UklpaGx0aXYrVUtD?=
 =?utf-8?B?MEExM2pHRmk4Q2ZUMTh1OXdScndjK2JiTVR3NDVRL25aVWlWY3BYUDJFK1RK?=
 =?utf-8?B?cG82WUVKamwxMklmRXdyVGJCclpXMSs2MWJGeUcwODRqSGxmUWFhR0lodUFO?=
 =?utf-8?B?Y2pWMDhjQVErMllpMU01dENLWTQ2TjZISitCRXJrZFg4aG1WOUFnbFc4SFhl?=
 =?utf-8?B?YnVORTlzWTdiRzlhazNYL3lTQlJBTENLTXdwbklUeUoyS2FvQkNyTmNGZmJR?=
 =?utf-8?B?VGxKeTkwYjR4d0cvT2xMVVVKTXZjQU1ZVVlpT2NteE1GQWQ1V1N1OW1mSGVk?=
 =?utf-8?B?ZVMyamJkMC80QmRua2UyL3Y1Mm53WGFZYllRUEw3ZnVGQzlSd2Rhd24yVGVP?=
 =?utf-8?B?M3JUWEdyMEdESlEvT1hvMzdpTG5BTDc5QktCZVhlU2RDa3lnWHQ1RmdRelh0?=
 =?utf-8?B?Mnp3ZlRZZThIR200KzNnWVVld28wNURLbkZyNXpEZThVaTlQSkMxdVNQUkpB?=
 =?utf-8?B?eDZ5NHNwRm9zVGU5Z2Noc0NUNnVSdjY3VjJqOERPNVUySWVGcDU4ZmFrWGUv?=
 =?utf-8?B?UGluNUt3VmY3Qzd6WjY0UDBTTFRrYzBjd0RHZUpOdjBJd1BuamQ1ZWxFTkl4?=
 =?utf-8?B?MzlxSlBUT3d0SVJNU3NNRmJCTXZVL3U1N2ZnY0E2YTZKMENjMlJFYXhRb0VP?=
 =?utf-8?B?KzFtQnFGU1g2SGw3czUvTGlVZnlQb3hDcDJHR1JTWlpEUjBuWjU2SGlhdVhr?=
 =?utf-8?Q?TFHa/AAT6YS/u3t+8wBgxymZ5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IuFO1Lw0ErCKKBhzQT9d/BCYehieAn2kJs2FLvlBOKIBrfyxoCQpXf8OjbXCETvD8WjLuQFZTiNT0z58L7YHlSACSlhA37sdVeLJV4epOqWbb2tHH1WEjrugm+Zh09d3L6KILOmZq59gTUFlt6mCkdYEC7itxvx5d97DHP1+zbYzRZTED2s3LFmlxPyN99wh49C3LKNDB/I5keGk+iHqXlQItxURA/SC2vgCigecb0fbxomRQURvcOMsYL0RsVjOPfjHyPZ3WKx2nZxMW9yJxL4ue67K6zR4BXd86Asb+idJ08L6r5xtp+eghXB9iKEH+1gXju3zNB6lIAXF8S6qPl0e39db4uMtkK6e/qLwQxqmmIw5gIC8+qwBRyk+NcJQ4UdzgltKGqEJc7y3lZCv57+HmAlacpNGCnPe5eyxwiBkZ2TI6wdZ8+6XYVt9hOxfAPfx5lvRfW/YziWc1yKYEcTp5VG32d5gytSMoVftBOamtXtJyMVlugvOCX8aTCpoFZcCH8Uadd9mWewLtHkEFWLnfPY/EaKPUriuocfspZKjAUo7fEBckMh6PDmqlMeJshhkwQLaaKV+UHH/PRFJM7cOv80fm9rrl8hWo2X2cqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb7ba35-c108-40d0-66cc-08dd4ddf9723
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2025 16:41:26.6371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzmNPcG+L2kyHx74ZlEDvLLbt6E/+5rcPyNaQM1FCAhpYl/vLrjRyONT+1JQfJT8rpSQ/v3eJLAbv0k0JFs39w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-15_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502150147
X-Proofpoint-ORIG-GUID: RsD9w3k9tXZKvAZ0C5lpcHqgqq6_8ROx
X-Proofpoint-GUID: RsD9w3k9tXZKvAZ0C5lpcHqgqq6_8ROx

On 2/15/25 11:38 AM, Pali Rohár wrote:
> On Saturday 15 February 2025 11:29:45 Chuck Lever wrote:
>> Hi Pali -
>>
>> On 2/15/25 7:00 AM, Pali Rohár wrote:
>>> Hello, since v6.14-rc1, file nfslocalio.c cannot be compiled with
>>> gcc-8.3 and attached .config file. Same problem is with localio.c.
>>
>> If the interwebs are correct, gcc-8.3 was released in 2014. ISTR that
>> recent releases of the Linux kernel no longer support gcc versions that
>> old.
> 
> Hello, I know that this is old version, and I specially used it just to
> check if everything compiles correctly. And it failed.
> 
> Per https://docs.kernel.org/process/changes.html the minimal version of
> gcc is 5.1, so I think that compilation with gcc 8.3 should still be
> supported.
> 
>> It appears to be snagging on kernel-wide utility helpers, not code
>> specific to NFS.
> 
> It looks like that, but only those two nfs files cause compile errors.
> Everything else compiles without problem. So it is quite suspicious and
> maybe it could signal that those helper are used incorrectly in nfs
> code? I'm not sure, I have not investigated it.

A bisect would be helpful.

Also, what is the CPU platform architecture? x86_64?


>> If that's the case, it might not be possible for us to address this
>> breakage.
>>
>> Adding Mike, who contributed this code.
>>
>>> Error is:
>>>
>>> $ make bzImage
>>>   CALL    scripts/checksyscalls.sh
>>>   DESCEND objtool
>>>   INSTALL libsubcmd_headers
>>>   CC      fs/nfs_common/nfslocalio.o
>>> In file included from ./include/linux/rbtree.h:24,
>>>                  from ./include/linux/mm_types.h:11,
>>>                  from ./include/linux/mmzone.h:22,
>>>                  from ./include/linux/gfp.h:7,
>>>                  from ./include/linux/umh.h:4,
>>>                  from ./include/linux/kmod.h:9,
>>>                  from ./include/linux/module.h:17,
>>>                  from fs/nfs_common/nfslocalio.c:7:
>>> fs/nfs_common/nfslocalio.c: In function ‘nfs_close_local_fh’:
>>> ./include/linux/rcupdate.h:531:9: error: dereferencing pointer to incomplete type ‘struct nfsd_file’
>>>   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>>          ^
>>> ./include/linux/rcupdate.h:650:31: note: in expansion of macro ‘__rcu_access_pointer’
>>>  #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
>>>                                ^~~~~~~~~~~~~~~~~~~~
>>> fs/nfs_common/nfslocalio.c:288:10: note: in expansion of macro ‘rcu_access_pointer’
>>>   ro_nf = rcu_access_pointer(nfl->ro_file);
>>>           ^~~~~~~~~~~~~~~~~~
>>> make[4]: *** [scripts/Makefile.build:207: fs/nfs_common/nfslocalio.o] Error 1
>>> make[3]: *** [scripts/Makefile.build:465: fs/nfs_common] Error 2
>>> make[2]: *** [scripts/Makefile.build:465: fs] Error 2
>>> make[1]: *** [/home/pali/develop/kernel.org/linux/Makefile:1994: .] Error 2
>>> make: *** [Makefile:251: __sub-make] Error 2
>>>
>>>
>>> $ make fs/nfs/localio.o
>>>   CALL    scripts/checksyscalls.sh
>>>   DESCEND objtool
>>>   INSTALL libsubcmd_headers
>>>   CC      fs/nfs/localio.o
>>> In file included from ./include/linux/rbtree.h:24,
>>>                  from ./include/linux/mm_types.h:11,
>>>                  from ./include/linux/mmzone.h:22,
>>>                  from ./include/linux/gfp.h:7,
>>>                  from ./include/linux/umh.h:4,
>>>                  from ./include/linux/kmod.h:9,
>>>                  from ./include/linux/module.h:17,
>>>                  from fs/nfs/localio.c:11:
>>> fs/nfs/localio.c: In function ‘nfs_local_open_fh’:
>>> ./include/linux/rcupdate.h:538:9: error: dereferencing pointer to incomplete type ‘struct nfsd_file’
>>>   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>>          ^
>>> ./include/linux/rcupdate.h:686:2: note: in expansion of macro ‘__rcu_dereference_check’
>>>   __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>>>   ^~~~~~~~~~~~~~~~~~~~~~~
>>> ./include/linux/rcupdate.h:758:28: note: in expansion of macro ‘rcu_dereference_check’
>>>  #define rcu_dereference(p) rcu_dereference_check(p, 0)
>>>                             ^~~~~~~~~~~~~~~~~~~~~
>>> fs/nfs/localio.c:275:7: note: in expansion of macro ‘rcu_dereference’
>>>   nf = rcu_dereference(*pnf);
>>>        ^~~~~~~~~~~~~~~
>>> make[4]: *** [scripts/Makefile.build:207: fs/nfs/localio.o] Error 1
>>> make[3]: *** [scripts/Makefile.build:465: fs/nfs] Error 2
>>> make[2]: *** [scripts/Makefile.build:465: fs] Error 2
>>> make[1]: *** [/home/pali/develop/kernel.org/linux/Makefile:1994: .] Error 2
>>> make: *** [Makefile:251: __sub-make] Error 2
>>>
>>>
>>> Reproduced from commit 7ff71e6d9239 ("Merge tag 'alpha-fixes-v6.14-rc2'
>>> of git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha").
>>
>>
>> -- 
>> Chuck Lever


-- 
Chuck Lever

