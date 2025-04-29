Return-Path: <linux-nfs+bounces-11347-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDF7AA0DB3
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 15:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829E7484B19
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 13:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585162C108C;
	Tue, 29 Apr 2025 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="li/R4h5c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RCj89B+V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DAF2BEC49;
	Tue, 29 Apr 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934321; cv=fail; b=IJ26xe6tKtDp/nXgG9AkC+6RcCISHs5/ZwbF+zP9X8ago+Uc328GaQifJCtSJk/fDBfkbum8+CQGPKT/aRhmh8Gvp2tUkBar2rC5zkzG/zAcK7oouwsX01GaW7GreErKFG5PFS+X2XvpoiyJt/silE28+6Gw9GWSHhNtDcPHSKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934321; c=relaxed/simple;
	bh=tW1MbOTqL3I5vW2QLY/nMkM7RyIXEvVNTxJyiljgwDM=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5pKOyULWrk5CJRb6QjNyVk/AefEysqViRWsxp3egK4VtPSnLV08Nrot+Fy3O69w79sKbsBzGmL6ycf0Fb3n8PunliqMw6vLAFgOjXTvas1TXtM8SjwFOYyC0gnocsivR2CWbhBbjU9qp03dp5M31PApeyh8N87KO87mWpgPwJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=li/R4h5c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RCj89B+V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TCUIBf008129;
	Tue, 29 Apr 2025 13:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dHJQQbWfo2+6TNOk80MpSarGfDo9rzGfkNcJmdDQHbM=; b=
	li/R4h5cd+P17URd3w6EhFT9CtiQ3fK3ewi+tn6xN6s7H+hp2hsCOrZebx5IwukT
	weSVfqL2S7aYmbD7/xvLXBsJWeYtTO596Knt5PKsixGcZwYj2+5jNYRuxPc+cmMQ
	9V4CQ7zMKAI4FP8eWKWjaFtxHvBVqmsFs4Nn98Y9KkjQuJKbVwRE7F3OE4e1dR5Z
	mCuKwPGswGYVV1mMk1kVXQb6+VUZGboxKCjJR93RuUfjKFMg5o3EWAEHoVd0TSKD
	EgO1qDlZ9rXhp7AjVt6y3dKqzq0jVTOnelMWd3fqPKL7xrhpdH4W9nTh57GsqNOv
	kPqelmJJ0JXHw2j0Tkw1cQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ax4j09as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 13:45:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53TDFbfH033529;
	Tue, 29 Apr 2025 13:45:17 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010006.outbound.protection.outlook.com [40.93.11.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx9vppb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 13:45:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVHZVTaf9btqvyIR9kPAtA52tbT+FQ1+MtGjgaMoR/DFdW51P7X4kWp4mHZWeJuoAkSHOGyB+KSgjlgcmLO1aEkmeF/hapH8HaURmUnTMqkZYuIobKaId5S9+PK/2MSck9L60wE8BTKROSoHOBXrgW3d2J1rSxqqwCWDgbWu/zXT2hx2gLly+11Ect8wRdltLOEB/++y9rHV+iMHPDBewih/WkoIAFKlg2ucMHVCo9yyxFuh9k3J/23g5geB2eMgwKpl/j5m/LgfHke+nsbpYfZ+TTFoHOabhCv0LEKbopvqXZfMI1iUEkREaTMJwjfRMmjkEWqIzh5LShdylbAnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHJQQbWfo2+6TNOk80MpSarGfDo9rzGfkNcJmdDQHbM=;
 b=d9rc5OX92y0FIeQbqRkhNJhpa8NI91Ebghn9Y+8tS5XXlhV8WmPfgnH559Qt8We1iTcdNkoHyiAMH9apkDHK8FL8J3LRBIqnyKz1TYbthVMppuD5qQmosd7OG0xJ6sQ+G5VtEO7IzpGhU0ROmALIh+apOtWV5NJi8G0u5/Gp7CXccYYHliwaZexn1aNtFrjPWFGpLJk/Ef5IBaXDIsp6j79a5ouc+1uZkKMcaRgJ6HKieUEq1dFlzRqYZxDCOkD1EnTjISBy9qJIidO8Jz6mWZdSGr4k1wqj6/Q6BuKoCBrB78kHZMvrN6hr+PJqXJ3WVBCJYm28Dc9yGSPyVM4LDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHJQQbWfo2+6TNOk80MpSarGfDo9rzGfkNcJmdDQHbM=;
 b=RCj89B+VRja/mxMoDOH/QZUlCREwWQp1jDSw6ygaa4HRoy/7ZYf6uDX2V0ALFgSeUT1olc1VlXxIjtKNtYggc565pb53BYGiWwODpD4Vb6wvVZaknUT5jq13+XokwVP2+EJITp6Ow/tfCvishZ5CzR5ih3ooCy605fhmbfhoVEI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 29 Apr
 2025 13:45:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 13:45:14 +0000
Message-ID: <41e9ed40-311d-42ee-9fe2-5af3ecda67d4@oracle.com>
Date: Tue, 29 Apr 2025 09:45:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: fattr4_hidden and fattr4_system r/w attributes in Linux NFSD?
To: Sebastian Feld <sebastian.n.feld@gmail.com>
References: <CAHnbEGLHGX2rMnf=S6CasoNyc939DTe-whcsjt9WhSWG920OoA@mail.gmail.com>
 <434f6474-b960-4383-8d61-0705632b4c33@oracle.com>
 <CAHnbEGJq-w4CMS1dg8UBraV+6kLMkmC-hO4Dq7f4z8Af6maitA@mail.gmail.com>
Content-Language: en-US
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAHnbEGJq-w4CMS1dg8UBraV+6kLMkmC-hO4Dq7f4z8Af6maitA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:610:4c::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 592fec79-3431-4ce3-2e2b-08dd872411fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkxxUnhObjZkbVRhbitmK1hMZHZGYmJQMEpueGFDOWVsU3RsZEtwcDY0YlMv?=
 =?utf-8?B?L2t4ZThkOE8rQjlabC95V25Pcjh1QjBXcW1ENkNIOHd4SlpLWEN0T25lNlpw?=
 =?utf-8?B?dzdyamRua3Zld1AyUGsvTUgvTlhSM0J0dlpVdkRmUktteS9uR3pYbXMxOTBi?=
 =?utf-8?B?cjI3akswdnBhaTNEaVJsQjh3ZHM2RkRFdWRXTGE0bDRtQ1VvMXJhRHlwR21j?=
 =?utf-8?B?M3hacXZKWi8raGNoNHlUWXJKTnpXUHJPMzVNYllzSFhoUjNwK1pNQ3R6R3dI?=
 =?utf-8?B?TVVBcmhuMHF0ZjJvdDV1aTAzTFAwdWlYdDgvVU0rR0JqOWtRR3RiTTZYRFIy?=
 =?utf-8?B?Skp2bHM0Mm1Uc3AxMEExTmJGUDI1b0RMNmxyL2wxYkZPYWdVVDRhenFQeThk?=
 =?utf-8?B?cHZnU0V5WXFwSDVmTHVnR3Y4MFVyZDdZZzF3RFZLSXdmZGZudlE5dC96VUJn?=
 =?utf-8?B?R3ZRTVlyaFdUTWplSEh4blRPMUJKWVREeVQvZFJvdU01TVhuLzNNYU5GbTY0?=
 =?utf-8?B?Y3ZyTWZHVEU2YTV1b05qblN1NTdMR1ZnRS9oWDRSMS9yekdsY3hiQTNXMGZt?=
 =?utf-8?B?ejI0UHBMZ2NIUzNtRGp6dUFHV3R1TUh5b0J2V2xtK081cXROZVVMZkVPYUlF?=
 =?utf-8?B?a05pMkNqTmFQb3lqbnVjYy9DcTg5MThNUmRHeG5Kbjhtd0xsTGtKOERaUGND?=
 =?utf-8?B?eFZGdGY5bnJ2N3k4emZoSGgwVGdVT0VLTDJnZFNObUd4V0Vuc3lBSnJBdis1?=
 =?utf-8?B?VEZscjFZcDhTSkVmRFR6UytrdTA4WjYxUTVRK3R3Uk55c2tNTHBvNDI1RnM2?=
 =?utf-8?B?cGlYYTc3eG0vcUZBRm1JbnJmdTFORTNaU3dBNUdhVEd2WVVRUnNqWmtLbXZE?=
 =?utf-8?B?S1kzdDRad3NOQVJ6UjlzQWsxcGZCWVcvUGE2Z3hudkF3VHNIbFpoRkQ1L2ZP?=
 =?utf-8?B?VkJxdlZncUpRQkxnWTdmTkVKYlp3UWRvTmJnci9nb1dUbTM1YkNHbk9EMEow?=
 =?utf-8?B?MUFqZEZZUHBpQUIra0djQlBnWTJNc2lxd1FKUUlJeW8wMWppZmpaKzI3dDIr?=
 =?utf-8?B?ZjJ4a2p3aDFROTNDTmdaaThHOGxkTHk5T2NQdjgrdUJocm5MMG1CRUUvdHJG?=
 =?utf-8?B?TVdWMmxvRk9ISFlHbnRFZytZajVmK3FKTWQ1M3dUMjJlMWVxRVkrUmJFZk45?=
 =?utf-8?B?TjNhYlpDSlZkVXdWRGw3WC9pQXlkWE0rRXI5VmU5M0h5VVlMREhhazQ2ay9X?=
 =?utf-8?B?OW5tbjc4TTY3dEdXWUwyVnIwQkNteEVnaDVNZ1JBR0NLNXlhVXFENjNxbjNn?=
 =?utf-8?B?OG9yWWVkUE9IMmUxSzFDalRTQncwWHJac29mMFlLNGp4K25MOWVwa1BvcTBM?=
 =?utf-8?B?Nmp6dnlKUjlnYVovVjBxdHNvQ29OSnltaTAxa0ppNFlQOVJOT01heG1xSzJ1?=
 =?utf-8?B?Z3JDS3hLNlJqcXZvN2U3ZUZJV3E3aU9nS3hrb2RjRTY1M3FrY014KzJYQjVY?=
 =?utf-8?B?Qlk2UTdkN004SkYzeVI4MHM4dGJpVDBHVVYvYXJ1aEIxNWhlc2hVbWczMmhv?=
 =?utf-8?B?eGFYOGplTmEvMnpLVXoyUGR6d2d3em9YaHIxZXdXcmZOT29rYnpaSWgxMk83?=
 =?utf-8?B?OUFpemcybk15U1BEdFd2TmVjbk0vWVg4T1pDTjFCYkZ4VDN6L2FRK0RUQi9n?=
 =?utf-8?B?N2dGMGg2REN0dUV4bG1ZTENaMSszQmhEb2RjdzM0NEtyMzhCQnY4bXlTS1Zy?=
 =?utf-8?B?SEhYaU81d2dkSDcyUXZhaUIxUENFbXhhVG41TUNFcVpTMXVTZkh6QlJXMWFN?=
 =?utf-8?B?a0pwZ2xnWlNRRWd0VDBFazBPNm9GeDlxU2EvQXIwd01KY01SaFhhdUlIL3ZC?=
 =?utf-8?B?RjB5OFE2cnVubFBBODNYQXRYUzk4clZscHBHL0o4OE5YTHpLSGw0SWVMbmZn?=
 =?utf-8?Q?XB6CVZvVG/M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVRFYW1KL2tZTkpJTUp5QjZZRzl0SGEyQ1pqb2lydUdUKy9VQVFSNmF6Qld0?=
 =?utf-8?B?OGo4MFF5SlB1NWkzM1RSUC9RcEQ1dkRRdzJLeHlxb0V0S0dJTVVDZ092cEwr?=
 =?utf-8?B?R3dIVXQ3M1IycGxSU1NpZUh1Q01ML3R3TURBeUk1dWhSV2NJV09CTDRCRlJu?=
 =?utf-8?B?bFk4MWE3RVd4Nm50b2hWRDY2aFQwckV6OU9tVWJ0UTRqbXZHUkRwTzF2Um9u?=
 =?utf-8?B?ek5RaW4rS2xEamhYOEs4RTNlSjNSNEdiMXlycnM0TVcxS2VCV0wwMnRPZ1lt?=
 =?utf-8?B?cis3SlhiRlB3YXp6YTNBSWdaY0J0ZmtKZmlOZG8wUFBpWHJkanI4NjIvTUt2?=
 =?utf-8?B?RC84UDE4SitsQ1FjbEdiL1JHMWJsTzBQMmpuangwRTdaREJRK3JVc295M1U3?=
 =?utf-8?B?Mm1heGNRMjRmek5US0tzKzd1ZjJGZkEwWGdnT1VaNkZMUkJlWHlHclZKai9I?=
 =?utf-8?B?N1ZvMHR4bUU5YWowOGhqM3ArelhTMkR6emZ3WS9kZlU1cHNNY1pucW1ZWmV4?=
 =?utf-8?B?WkNiMkpuRmtza3hNcWRXMmJnekxnakZWN3Q4anV0dW85cksrbktrWjkwL3pB?=
 =?utf-8?B?dnYxUEVCVWFNSlo0VE9FZlZqd2FNd2sva1hVYTM2ODR0b3NXM1N0Wi9Day9Z?=
 =?utf-8?B?NmIyRllhK0JBOVBBL1UxdFNmK0xMRC9HZ1ZBRnRtcWNvMHlZTDl4NFdZWlRp?=
 =?utf-8?B?Z1V3UjIzT29mN0U2NXJDUDhuTTBpcnpid3ZGa3ZJeTNKMzM1Wi9QSVVFdC83?=
 =?utf-8?B?c1BoQm9XQVJrWGVNemtOSmQvclpsQ3BVNU1jZ1VVSGJDeDhpY3ZOUmw1UVpy?=
 =?utf-8?B?UTZBR2NKazJkbEVVVDQrOW56S1NEUWdBeHNxMSt3aHI3dlRkeDdxTzNxVmtB?=
 =?utf-8?B?a3M4M2pHdHdmQWVWcHNDVkZOdlhkOTM5Y0RJNFMySmRhQ1FlM0FWc09qbzR0?=
 =?utf-8?B?MDBZSSsyenFYL1JORXVYdXdZVlE0eFk2R1dqeVNicVowc2NsaWRtb0hKa01E?=
 =?utf-8?B?MzVIazlVYXR2S0pwVExMbGNpNXJmWEpMcHFrZ1I4YUREblRQVzFKY2lNK0hY?=
 =?utf-8?B?ekEzNjBpcGtjZTdpTTR2cGdmUUFNaUM3T1FaRnY0d2swWXhtRTl2OGJ6R213?=
 =?utf-8?B?K3dJeEtvZHNzR2xtUEN1eEM3SkUwTzVWK1F4S3NPbjgxMlV4Y1VYMzdzNk5v?=
 =?utf-8?B?anEvMkZPb1ovb3FJYzc3NHNzWjJmS3FDSlNwNlJjUG8wRkFsaU8yODVQT0pr?=
 =?utf-8?B?UkFsUFVVemdrR3hvVThWdlk1elBId2pPa0ZOazZBaDRWR0Q1b0t2U1c2QnQ4?=
 =?utf-8?B?Ui9PVFZ6ejdCMDkyNWd5T2svM0VWSTl0N1RxWjZObE1rdXZRdXFjRDNSR1p5?=
 =?utf-8?B?OGtQQk1JNHordGc4TVVZNXhsZ2FGMFc2UG5yN1diNXdnTXNjMmVvNmxUbUVq?=
 =?utf-8?B?UEh0Q2NCT21aQ0FrUGhIUzVvSXZFTjV3ciszQWg0L0RHbWZoUHRwWUF1Mi9p?=
 =?utf-8?B?SkFQbklpOXFhaFpXclozVTVBd2NBMkI0VVdML29JMHdiUnNCWXVIdjBRQnph?=
 =?utf-8?B?eFRrK3FhbUdiODJoU3dzSGc3dVNwZGtCa3llbDJkSXFlejlNRzZzTENTNE9D?=
 =?utf-8?B?YkJNUXc1QStXc2lCY2dZQ3JiMHkzOUt4blRMUEFFYWhIelhSNXFpZTlYRmVE?=
 =?utf-8?B?MHcyakFJVXVvOWhJNlJzTGRYbWthbTU2MDZrUjJ6WXd2K29aR1RMTmZ5c3A3?=
 =?utf-8?B?VFlBTnVmQnV6bGVTRVl3alA5bWpUeTVRTitJWGZwOVkrZ1pQOE5vL05vTU90?=
 =?utf-8?B?VnpZaEpqOGxsQnovWG1sL3JadnVQUzhMTmNCQlFkbVNXdGUvaU1QU0dBeVpH?=
 =?utf-8?B?blc1M0ZtRnpUZTR3OExFNFI4bmZEdXhveU5haFF1NVZUTC9OQW1oVWM5bytK?=
 =?utf-8?B?WWsvbS9vYzFqMXZWRnFyWkNLUU92dXhoUVYxYlFZMkM2bHJBcitYK29kbFBK?=
 =?utf-8?B?RXd6WGlyMUdWdTNVMVV3QXNJakpjNXhMdTc3c0IvbTlBZmFCVDdaa3RlSUQ0?=
 =?utf-8?B?S3QzRDVqQldaTjJyMzdFRVhwMmU2N1JJVDJDRlYraXRDald1V0pVWjdhcnVF?=
 =?utf-8?B?T0czRGVJV0RlS1pSM0N4S2JLL0NKWVNqYWYrVmlCS1dHRzFodU1ZYXg3Q1lP?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7XZxeW8YVysllrSXFcb9q3DA8hWY234D6Je/8DN10V9azcIQEX8bYWZUQmHyjByhx8kXCROa3AYwCXKDbXWkXZxN0YLR+Iq6ed/d+MuE4b4/WkgkEkYQzpvM1jm+vuoK9GFNnu5V0JVlMwR6CZJyRHYZeALxWR56hTn8e4lZ/dsA5ZorL7P3/Q0IKDK/VDWpXGs7JoLd70UWa90qwVRrnAE3hLBQUlIguRWzu15XM2Q7MJjd1kgnRxbCN4FVoZIOPHlGkiCCIm5Obex4AFo2GWAbAgykUD5QSbjkQWtIPwu4yDhCR0uEJjayMcSCiX/2jsSoPLsPQXymUYsLsrxNdmvlGKgjIR1eLvmU+6S9lmFY4RoVFVChMEnCtvv2TtWxOiPfUigqkYdRMv8s0otcpDHZii7qq2y+oSNzoLn0S3hI8wuUjfX2Q3LQK0e39ZkkrXxaqXZlpRs4vBdsPh5M5nvTrN8jtv8TWYHwIGOsuE9i14COKp3okoTl8JmM7hXa7rnJCHmTV7Qd8KVAvOFOk6lnXjQUbX8dD1e1R3ieLeSzWjEDFTzdonEbmU9py+IgkGJSsQ2PQILUFCR/ATMSwYU3z9b6FpCSTA2rtfXRDzg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592fec79-3431-4ce3-2e2b-08dd872411fa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 13:45:14.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuM4/4AGlH7rMy8XmXdYsqr8tjSVjtZUtR5+OGWcM6FBozinT+cfYYY4dadDbFLcpT6lvhP/RmCmgGozt4d81g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504290102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEwMiBTYWx0ZWRfX1M6JT6uPPSJT nY2Na6FVvd8N16P44Un7yziwsY0t9AAUW2QN6k3HRoj4bMSYMtUOsCuRXzWEaU6a24r9n9lXQqo HfIXQFHnEOTLZmG7gPW7z5uqPzhVPnjsafeIz6+437tDTIDVM70u1625f9j+Xnf5DxWksqXeHBF
 9YmV2b2oQ54gsygou31cBborxyjHTkzsV+bvvTHxvYn4xJ5eGsPd1ijlZUHphVb2IuBJALcabOn Nj4j/oBUymMM2P/IxeJEkqV9iU1G1pYX1sbvn4i9DMRrLTbR7eIXwsBblr4tN8/v/soKhXIODLx y3TRju0MCI2LQ6kzqH/37d4aY/N0G87VpwUVp2CD9CUWMunkJIHX4Qkh9dS1AkzdM2+BysijEfB tMHu21wb
X-Authority-Analysis: v=2.4 cv=WZ0Ma1hX c=1 sm=1 tr=0 ts=6810d7ed cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pTi6002dgiwkhScAILYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uFPwA1tIPu3_QWXaLmWaRcTbWxjmW2uB
X-Proofpoint-GUID: uFPwA1tIPu3_QWXaLmWaRcTbWxjmW2uB

On 4/29/25 9:10 AM, Sebastian Feld wrote:
> On Mon, Apr 28, 2025 at 4:15 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> Hi Sebastian -
>>
>> On 4/28/25 7:06 AM, Sebastian Feld wrote:
>>> I've been debating with Opentext support about their Windows NFS4.0
>>> client about a problem that the Windows attributes HIDDEN and SYSTEM
>>> work with a Solaris NFSD, but not with a Linux NFSD.
>>>
>>> Their support said it's a known bug in LInux NFSD that "fattr4_hidden
>>> and fattr4_system, specified in RFC 3530, are broken in Linux NFSD".
>>
>> RFC 7530 updates and replaces RFC 3530.
>>
>> Section 5.7 lists "hidden" and "system" as RECOMMENDED attributes,
>> meaning that NFSv4 servers are not required to implement them.
>>
>> So that tells me that both the Solaris NFS server and the Linux NFS
>> server are spec compliant in this regard. This is NOTABUG, but rather it
>> is a server implementation choice that is permitted by RFC.
>>
>> It is more correct to say that the Linux NFS server does not currently
>> implement either of these attributes. The reason is that native Linux
>> file systems do not support these attributes, and I believe that neither
>> does the Linux VFS. So there is nowhere to store these, and no way to
>> access them in filesystems (such as the Linux port of NTFS) that do
>> implement them.
>>
>> We want to have a facility that can be used by native applications
>> (such as Wine), Samba, and NFSD. So implementing side-car storage
>> for such attributes that only NFSD can see and use is not really
>> desirable.
> 
> I did a bit of digging, that debate started in 2002.
> 
> 23 years later, nothing happened. No Solution.
> Very depressing.

It's a hard problem.

Focus on the recent work. It appears to be promising and there have
been few objections to it.


-- 
Chuck Lever

