Return-Path: <linux-nfs+bounces-11917-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B8AC4F06
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 14:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B21189EB16
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB6725DAE1;
	Tue, 27 May 2025 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dVw2S2mX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bnTLjL3w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F23212B0C
	for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748350717; cv=fail; b=bLUf/KQy3bLs76ScSlwH9XLSASkFuq4sdT4v1NXDv4mSgowzIiWEhcLhNs+w81O0b0dqB8zieakEuVzMYHyTtXWPTnibzdsoNvbfVNPPnMhIr9WAjRUwGSYYw7S6Kr0XGaAN9DZNPgBhG7aMfTV6+EwrndwIJ0j2t+/uumnE+SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748350717; c=relaxed/simple;
	bh=hbeMUgWbpo/vViuYEWFMFXjpn1cUGqK7bZPZsKD+8DY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SFxlQUiYKqJLOpZaHOhP2OaZLU1n1WheHKk1ql4Xpe0m/MtRGfaBfks88w/N31vKhWnTBDyDe39PKgh0VcA90N/lDcPYv/aa/qjOeqmAiZiqtVGiUK2DkFgSfyc8lTbvW7KBWL5cyNh7L2GhiW5YFJyNaKItuwp7TR9b5q7ieXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dVw2S2mX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bnTLjL3w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCjduu008398;
	Tue, 27 May 2025 12:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nVPOhVYHjVbqUejjCb/2RZlr02JmQyzM84P0qrSLCPQ=; b=
	dVw2S2mXyU5j8qArDIikfHoZ3dntnWDD4Nf9KkUprPg8XJd6p4vil6vxSA+ZJ5a0
	6Tv3mbbtAxDZrkh+B+zZw7N+L0ZP/c0ESQGypGUSJkANCVd1SdvPef16kTXMMdn1
	h6UtnaptC8/5eom9BSwJL1P/pyUVlKqacEbdC9k3LU/b/ZwrO4pNVN3SWy/qLYfW
	x2kEwPPPDcbsEptw7Tf3nrZVGBfN/XjTpPHZ1FpPKbEElotBoWZb/jNrd7924kQF
	oFvvGZqq0zdMS0B164+4JF+fT4JV29sUQSwU6wa5Q4GEnKV89JxLKVUJdQ6OyweM
	ExjiYDjszfo6nWPCPnYOtQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2b6b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 12:58:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54RBe58V024460;
	Tue, 27 May 2025 12:58:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j937ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 12:58:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLMKwz4Ekl4WJAD/G+Nzwt+k/FTFQOP1xVjDNFhgLMHZmpJ19UrUKxR2RICX7BLI+J5LGmq+sW6EISQ3QmMhCgnE/PrQ0lsdpvoisaVYGXUMBSGHwK96b8lwjP1ZkoELQ0VsoIshqiS0+hmLhSS8a6u8h4EJVvOhJ50gtQX0Gqn+hYcw0KiqDlL1v5SKVvaWwlC7YWfHmDB1tlhi66Mc5YOntFr4ras7qfD/G+CifdANV4FVImaGmgE90Mb/OsTPyIy3Yv5urZ6WU+i2pDnUlT64ZBR1vbIhoh49aPYwC397qTse7gJw8yq50gU06ScSEu8g6Eord0obM+wRTrCNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVPOhVYHjVbqUejjCb/2RZlr02JmQyzM84P0qrSLCPQ=;
 b=CPFGRPElyHNFMCIT5E+lgXtRrfvuGjf7YMSYHMxy6CkPZ55K2c+/nzgu+ZoiVXVZOc5QGBIJLr07wJRpxQMCfQ38SNjMXtt7pdCfGBCHsSckNesKF2I0KGndDeX1aUrgOx3gG3b2cf2NJtEAk1qsx9zS8Bnnaz6VWX9H9/BDp3jDBhUErHcNFmaBG/nhCSRDwgyWq3TE9t4wMv/fJC5G09tRoZLHG5lEOnYBKos+FaBEPXrykl5pL89M1han4pfFeefgA7hLZNs+hoeC+tMizgNdJKefHWHNbG9bqNMGzI1hlNdkJGlpY4gERMeDY79b2lCXLGzP5wtbBnL9PM6DlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVPOhVYHjVbqUejjCb/2RZlr02JmQyzM84P0qrSLCPQ=;
 b=bnTLjL3w07r4dXQT5UK6Kq80rdWANAHMtDNnufHCh05KT5H+HYb4PhV9Ry1aK7rmHqkh4vRAptZwittq5yEj1joMYgpiuIjvHdqbtDJKDovZdljVBIpX3B9LRlEcwfxA8SngQljtTa+koiPstmr1oDhbx6IGDTjstIcSnOw2S4c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPFF6F8BBAB5.namprd10.prod.outlook.com (2603:10b6:518:1::7da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Tue, 27 May
 2025 12:58:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 12:58:31 +0000
Message-ID: <8b83e1ef-867b-4b4f-95b6-9dc03d6d591c@oracle.com>
Date: Tue, 27 May 2025 08:58:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Questions Regarding Delegation Claim Behavior
To: Petro Pavlov <petro.pavlov@vastdata.com>
Cc: Roi Azarzar <roi.azarzar@vastdata.com>, linux-nfs@vger.kernel.org
References: <CAN5pLa6EU6nKe=qt+QijK1OMyt8JjHBC2VCk=NMMSA4SJmS4rg@mail.gmail.com>
 <2529724b-ad96-4b02-9d8e-647ef21eab03@oracle.com>
 <CAN5pLa4z-v9MSwZCxbW6oMy1Fa=b9GFEwmVxdDTnguO6_9-f_g@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN5pLa4z-v9MSwZCxbW6oMy1Fa=b9GFEwmVxdDTnguO6_9-f_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPFF6F8BBAB5:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd2927b-7ce7-46d4-00a3-08dd9d1e2e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2pjR0g0b3ZZeXRGWHBaOTNpVXFxUWJCZGk1STMyR0xTNGRObEVNbUszVFJE?=
 =?utf-8?B?K1c0eVpleDhlZXZRT2xNVlIwYVhoUVFnRWZnNERjZTlWRjcwamZuY1J0MG9V?=
 =?utf-8?B?U0JzQzBLSm5GT1hJOXBlWmRZZEw1c2tVSDhxVE91T3pDbEJVVUFUY3EzZCtT?=
 =?utf-8?B?ZFYxL3pmcVF5THBPb085NFBRa1FxR2ZPSVJGR21hZmZRYlhtMDZwWUJDRWlk?=
 =?utf-8?B?Tkx1ZzBVOHhjajZXcXJFUUdmQWppWHRuL3lCYjBPRmJUMHZEUy9NQy9RS2l6?=
 =?utf-8?B?S0crUk9CcXZRa1dBUStBUXFlcjRUeWxKQnJMZ2lTMk9EbWxzY01Vd3lXTGk2?=
 =?utf-8?B?b3ZWQzR2UWZLQ2NBOEs0ejlFUmJEQUg0am1aVTdmeExYSzkxNHFCbjBTZHR4?=
 =?utf-8?B?dVIxWlhHQ2s0TGVud25FaUhPVXlOODBKOHRQSXlSMnlxcEMyaGkzLzdJOXJS?=
 =?utf-8?B?a04xK3BoUHN0RllYSEJZODFxTG5XMFVKdktDWmtSc1p6STRkbHRFeHdJbEkx?=
 =?utf-8?B?NFVtUVg3Y3dHWSt5MHlNSDllOXZMMVdtWEVTRUdCY0lQZDhsV3FnUm9ObjlS?=
 =?utf-8?B?ZnNJZ3dZdzFkdUNUV3lZWEdPUllwZWUxMFh1ckpESUJjNW9sSDNKTms1YW9t?=
 =?utf-8?B?dThCRGYwSnp6VGVyc2VQN1BZNWlTMFk2aE1uMU9EWWtFVk1vNTFTUEN1Q1Ft?=
 =?utf-8?B?Wi9NZ1BUVk9maHV3ZUJJMFFsSjBkQnEvMEk1cXRkWEJUZVdGdGwxMjRkajlU?=
 =?utf-8?B?NUhXT1ZoaEZHeTlvRzhYMVBhK2NtTStmTUxsWmoxcVo4ayszcW1zbDBGZFBj?=
 =?utf-8?B?eGRHa01RbktmTm9NVzNFWXhwb2ZXaVBSdHRsUkFWa09SUHZ3YU9wUG16OUdN?=
 =?utf-8?B?QnhZV29XUXJHVDhvZzFwYkJyeHBlUGE5SWxxTVFLUno3RXBpSHdtOXFhR3BW?=
 =?utf-8?B?NjdHTy9ONTNOQXBwRFhpWFFFb2lQZjlTdjZTMi9TUzRLUVFlTGpJUjZTenUx?=
 =?utf-8?B?YUdHbnE4cHhVSWJ2Z1NLakJVb0prVkV4S0ZIbDM1VG1vckdNeHdPNks3TXcz?=
 =?utf-8?B?aFh0NzJFNWZYK0ZNUENtN1VpeHJqc0hLOHI0VTlvOWY2NkZycDNnQXFIeVAv?=
 =?utf-8?B?emdJbVlnVVEzYTc0S05RZkpaRXhaYk1uZkhscGdLbHVBdDNCTXFqNDMxSUh5?=
 =?utf-8?B?d3lLSlZUaFlLNmEvM1p6MkpGWWk0NVJYYjkrTGF5VE4zZXc4b2p6aGozT3Mx?=
 =?utf-8?B?WWxYWmtaN3oxdGJTWlgvSHJhSmVMcW5wV2hINytUMGMwTEVEcVE5b21jS1ZJ?=
 =?utf-8?B?WGNuMGkvVFRLS2NMOTZZM0x6OW80ekNIUnNQUlJGajRTVVhPNTA5dVlPYzg3?=
 =?utf-8?B?S1JhRUpmdnpXYzNaS0F4S3pyaVFyWFZOMWpQUG1kcFZsdnFlRWRPS3V5cjhV?=
 =?utf-8?B?NXV4VVQ4TUFnTEQvR0I2M0lRMllPY29QSHFHTEN0T01PbTlvWndTVy82ZC9H?=
 =?utf-8?B?Y29ZRFFtTUFiUkdsK1dacGNMZXJGUDFsdGFTMHJHc3UzdUZhV29VVU96WWJY?=
 =?utf-8?B?Y0xodElQWENjVEN5NGNnNmhzWlJEUytSdFluSnJpOE5FQU81QUxQREd6bWpL?=
 =?utf-8?B?aUZueCtJbGtyL2w4STZybmZVNTFLNUtiOE50Z2VYZElxMVB6eHp0dXdnVHly?=
 =?utf-8?B?Y3AzVEF6VFFUOGJ0QjBacVdONmk0d0pwRWd5Nk9iNytPQi94KzhEQXJQZXdL?=
 =?utf-8?B?S0tGNGVzUHk4QTQyQXE4NllBSC9XK0Y5eENDdi9UY09LN09UTnNoSXNQSDRp?=
 =?utf-8?B?ZzExYjMzWkxXRktuN1RNbmczN1dDVUU5QVdZV0p5SDZzZVlvNkg4WVNHa3VX?=
 =?utf-8?B?WnpOVnNYZ2lJcFlldjdubnA3bStia3N3ejVBTjhNdDNjejNjdHJ2NXlzZFRZ?=
 =?utf-8?Q?tX6667SAeCY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnJSU0hGSzIxL3lsRDV0U2hoVlAyNHlaZzd2ZU9uT2pQQWdxdkFpTEZNdmdl?=
 =?utf-8?B?cTgxdXBiVEpPTHIrNFRuYUNMVlNqaktPMVRnUzg3NFlPZGRtTnVQM0VRNHg0?=
 =?utf-8?B?YjJJNS9XR25sZGFzZEJNK01iWDNiNm1COEZjSkhYVzExREZXVldsZ2ZicTFh?=
 =?utf-8?B?NVlRakxqVEZIOER6ZTgxRnMyU1cxS1RmVUlCdFo1Ym9NWThXSUdSb2MxT1Vn?=
 =?utf-8?B?QnRsdkRzakdoVUFqb3hqOERVcTVDU0ZVYUpER3BKckozdUxZS2p3VW9vNzJy?=
 =?utf-8?B?YXdwM2RJNTBXQXdqY2xwekV4Vmt0cm1OOHV2djZ0dzFvcm9Zd0hNaXJSRTRR?=
 =?utf-8?B?SitQdlFpWEl0S2FJZGZIb1dDMWJhUzMyaGV1MTl5QmJOSm5WdUdpU1VwLzBO?=
 =?utf-8?B?Vkt1MXdnMEZZOXdXZnZjQ0hlUXdzbG9wQWsyRGpUQWhaSkJXYlFqZXN5MXpX?=
 =?utf-8?B?bWN0TU1MY3c1bWJ5Q3RheHZqdksycitKaWUraHZ1RXE0UW5DdDkyU09vQTFa?=
 =?utf-8?B?NlBSbWxVbFZ6M0VTZHpGUnFVbTdkK25TdUdFckZxOFBWRlZ6VFpmYVF3MHQ5?=
 =?utf-8?B?bERGWlZuVFdyVXdzRHJLYTBKRFlpekpoTWZUNXllZzhWakd0Q0ZDSHQydlpm?=
 =?utf-8?B?ZW1SR3BDRWR6QXE0U0lnOFZXaTJpUnN6K0JiVjUyeHMrK1cxL0srZUF6SktM?=
 =?utf-8?B?c1FSTTBaQUJROXd6aERWL2dyd2M2MjlpU3M4TFQ1bWpjSFoxazIrSGYxem1s?=
 =?utf-8?B?dkxLU0hKS21lRDRoNVJKb1ZUUG9RM1ZKSzlsOWc5ODM2UWhXdnh1RFVWTlZB?=
 =?utf-8?B?MUk5ZGtNRmZKS09pcnBVNVRsdDJRWkt0eUZBT09rUUxKNTJPTG5YVC9BREkx?=
 =?utf-8?B?STdkdHZjNG9MZ0dXWU13UHJYZ3NZTUVUbXpHdmtKdnA0K2U3WXpSNXFnN0dl?=
 =?utf-8?B?ZUNmUWlkQS9nWG9yUkRKbGxtNHFyTzVETlQ1UVhJN2E1TlMrc1hrLzI3TktV?=
 =?utf-8?B?V2JRRzNjRlEvSmwwUlVaRUx0TVFnanJuTmQ3M0p1VHFVUlhkdzdMSFhwYjIy?=
 =?utf-8?B?LzE0KzNCWW1VeUV4ZE81N1U3WG1STEJyREppTDcrUm1YRzIrM3ZSbTdLRHlD?=
 =?utf-8?B?ZU56V2d4ZU1Tck9IODBLbkJLaGhwajJHdHQwdWlBU09jRUF4YVBuR3lJbjJv?=
 =?utf-8?B?bGhRQzhRWmtqeG4xWFFGQVJ6MlBHU0lYL2JrelFmRkJVWWM3dXhpMXNnK1J0?=
 =?utf-8?B?MjVISmlGM1E4b2xyTy9sS2dXZjA4bUczdk1iZFBrbzVZMlJ6dUV6cWR0UjMy?=
 =?utf-8?B?VmdsY20wdlpQNXpNWFFLR2NjdlRpbWhYZnpvdGozcWNTY2RkUHA1T1F4SE14?=
 =?utf-8?B?NGdtdUdWN09qdGpuS21sTjVhNmM4REUwN3V4VW5RN0lGQ2ZOS1JkOHZ1YUFR?=
 =?utf-8?B?NDd3WU1VTDRUQ2d4bGNaOFRSQWVYaTVOUU9FQVAyNWZiSU1OT2hyNWV0WElq?=
 =?utf-8?B?R2hTQ2xBWUNyYmN3WFZoTVJNWFI1UXlDcHJXeVlidGJkVlRoVEE0bU1TaWVW?=
 =?utf-8?B?alhCV1ViMnRLNjY3STZSdjVLYmJ0amc1SGdjdTBWN1JKZzNuMjlUcVFuaTBD?=
 =?utf-8?B?c2dzdm13b281TkVJNnNCRDFKdkRsU0dNU09lampLTkxoUTQ5SUpJd0NsVVZh?=
 =?utf-8?B?VkxwOUJNZytvVW4xZ1dZZm1NUnZVNXl3V1dWNWZsaFFjNDI2dFJRNm4yeWZy?=
 =?utf-8?B?QXU5Q0lpK0Q1eVBJRE1QbDBtWEFVSHU1V2dtczdHendXbmVpTEZ2MVV0M3I2?=
 =?utf-8?B?OUpaelNGdXJhRzI3NEhrQ1c4S3BCbllUcng1dzdLckwxdXVVdmo1RTVFRTdV?=
 =?utf-8?B?TjdQbXY0clUyTlhaSHhRTVpldHA5NVZQRkRYTHhra1RkL1VTZDZVbUpLTnU5?=
 =?utf-8?B?Nkd1Q0tRYXEvU2NUeU9vRVBUQ1N1UzdtZGNnT1pXUkRVSmhyT3FvaTZBZFFZ?=
 =?utf-8?B?Z3k3QTd1bnF5M0x2dHBQRkczcUxHNElweHdBUTMycThRcFUrcHdhN1dSbFpE?=
 =?utf-8?B?ZmNRSUpOdTNEcytsbjViSVZPQWluSG1OV3l2Y0FPUG0xQVcxN0cwVm51alUw?=
 =?utf-8?Q?esSlllfs2jkXJxn/zn71xMzPb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n8vDm6Hz0qzE69ChDogz+l1c+ytHJkDynZGhGsQV+2axc++O5FyUnMmmKfc0LXK+mwO85s7uPG/pJufIXN5Xx4JkGz9GsfY06lxVqUA61mIpZCjLrNqgZqNYmwiAR3tNFfjY7TZfh56TVm/e8C/YeUrR0vsNr648Aox4ACki5Ibw9Vo3S8o5zj+TVI0Dg6tkILz3BvWjVfPdgm9oAW8YXfRdBSycP4fVPRAkexMtoJkV1YItDOVejAyLFqFtT7cbTzkO/vYdiiKH58iycZjLTWKaAde++w6dqvsdJb6+PuS4poacasFr1aqoo5oFXTP9AqpebQLzDj+OQ/zSrKl2ePW5hYkDRXeod97pXrytbZcfbF2AyYRzkk0N+20Ht20Hx9ZrxquL3C5A/SnYEiJDcltD2V7mzyQ14Km8IPP8U9AU8QCfER+X/R8boVZ6ZJR6VOxMx7/dtfYRDH1f+36ZOlUWIEj2rgMKbY+PWfOTne31YN4x19cvj4pG6A8H/yvYKbYErQAanZNfAUP21JMm0C6SyijeEMxB+q4/Ueejx643QnIO+oVTom2Ts176MH2euSUBP8j5EFck5KeSx7jYeNpAY9AihMr6hfnp50H1HnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd2927b-7ce7-46d4-00a3-08dd9d1e2e67
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 12:58:31.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gYtsjMdqaGLxd8NHIoJTE9UPLDNIx93n6988ucgvOHYVILfOYKgynlU2z/AYmB/2J/0VasOc3hRsbn188lPlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF6F8BBAB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwNiBTYWx0ZWRfX2B+LCo6eATpb eBjfnXL9jeiWclWwpga4+XU8L0I0J1yUK0l4mW7kzFMY8rZ2A+rHLBNM/YkS+tL85w//+VJFgBJ VvW/lbKVhy9tQuzD3LwNhf+XB1oEdpyFq60T2jly+6qHDRFr0Lu1hi3VR2FrV/cvUcQqHRgjPhb
 1qHpA5Skh48ligdJoKcG68/PnuHFhNNgDXHI3Spf/IXwTr3dcWkSoa+Uztp9D2iaslP98SF7FoL ORj5IqCZpa+bt8odKBU0s2TcaTFsBczY7PWfjPmvZqF4ckF6BdEmYz29dMoo158ER42eBwbgC/F TyrllRGb+art35l6FNQUkGSUOGGGSrgWO2Pno0pIteReDToKl1yfC1xw32pVK0sqStlongJZzoq
 Ggj/CbLLrhQNZ3PIOuQs8vtaGjQChfKD21wgGQ3xvOlAI2y0nEko0E389BQHauev3kbl0HsH
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=6835b6f9 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=27amEd3Yj8HDjJFv7hIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: 8MKem72CW732ASrQHALp6FWhSszrRciV
X-Proofpoint-GUID: 8MKem72CW732ASrQHALp6FWhSszrRciV

On 5/26/25 7:10 AM, Petro Pavlov wrote:
> Hello Chuck,
> 
> Thank you for your response, and apologies for the confusion regarding
> the kernel version — the correct version is 6.15.0-rc3+ (I believe it's
> from the branch you gave us). Regarding the client, I'm using hand-
> written tests based on pynfs.
> 
> I believe the following section of the RFC may be relevant to the use of
> a delegation |stateid| in relation to the file being accessed:
> 
>     If the stateid type is not valid for the context in which the
>     stateid appears, return NFS4ERR_BAD_STATEID. Note that a stateid may
>     be valid in general, as would be reported by the TEST_STATEID
>     operation, but be invalid for a particular operation, as, for
>     example, when a stateid that doesn't represent byte-range locks is
>     passed to the non-from_open case of LOCK or to LOCKU, or when a
>     stateid that does not represent an open is passed to CLOSE or
>     OPEN_DOWNGRADE. In such cases, the server MUST return
>     NFS4ERR_BAD_STATEID.
> 
> 
> I did some further investigation and identified another scenario that
> seems problematic:
> 
>  1.
> 
>     *Client1* creates |file1| without a delegation, with read-write
>     access. It writes some data, changes the file mode to |444|, and
>     then closes the file.
> 
>  2.
> 
>     *Client2* opens |file1| with read access, receives a read delegation
>     (|deleg1|), and closes the file without returning the delegation.
> 
>  3.
> 
>     *Client2* then creates |file2| with read-write access, receives a
>     write delegation (|deleg2|), and leaves the file open (delegation is
>     not returned).
> 
>  4.
> 
>     *Client2* tries to open |file1| with write access and receives an |
>     ACCESS_DENIED| error (expected).
> 
>  5.
> 
>     Next, *Client2* attempts to open  |file1|  with *write *access using
>     CLAIM_DELEGATE_CUR, providing the stateid from  deleg2  (which was
>     issued for  |file2|) — unexpectedly, the operation succeeds.
> 
>  6.
> 
>     *Client2* proceeds to write to |file1|, and it also succeeds —
>     despite the file being set to |444|, where no write access should be
>     allowed.
> 
> This behavior seems incorrect, as I would expect the write operation to
> fail due to file permissions.

This is a server bug, since the permissions on file1 prohibit
writes to the file.


> Please see the attached PCAP file for reference.
> 
> Best regards,
> Petro Pavlov
> 
> 
> On Fri, May 23, 2025 at 5:41 PM Chuck Lever <chuck.lever@oracle.com
> <mailto:chuck.lever@oracle.com>> wrote:
> 
>     On 5/22/25 11:51 AM, Petro Pavlov wrote:
>     > Hello,
>     >
>     > My name is Petro Pavlov, I'm a developer at VAST.
>     >
>     > I have a few questions about the delegation claim behavior observed in
>     > the Linux kernel version 3.10.0-1160.118.1.el7.x86_64.
>     >
>     > I’ve written the following test case:
>     >
>     >  1. Client1 opens *file1* with a write delegation; the server grants
>     >     both the open and delegation (*delegation1*).
> 
>     Since you mention a write delegation, I'll assume you are using Linux
>     as an NFS client, and the server is not Linux, since that kernel version
>     does not implement server-side write delegation.
> 
> 
>     >  2. Client1 closes the open but does not return the delegation.
>     >  3. Client2 opens *file2* and also receives a write delegation
>     >     (*delegation2*).
>     >  4. Client1 then issues an open request with CLAIM_DELEGATE_CUR,
>     >     providing the filename from step 3 *(file2*), but using the
>     >     delegation stateid from step 1 (*delegation1*).
> 
>     Would that be a client bug?
> 
> 
>     >  5. The server begins a recall of *delegation2*, treating the
>     request in
>     >     step 4 as a normal open rather than returning a BAD_STATEID error.
> 
>     That seems OK to me. The server has correctly noticed that the
>     client is opening file2, and delegation2 is associated with a
>     previous open of file2.
> 
>     A better place to seek an authoritative answer might be RFC 8881.
> 
>     The server returns BAD_STATEID if the stateid doesn't pass various
>     checks as outlined in Section 8.2. I don't see any text requiring the
>     server to report BAD_STATEID if delegate_stateid does not match the
>     component4 on a DELEGATE_CUR OPEN -- in fact, Table 19 says that
>     DELEGATE_CUR considers only the current file handle (the parent
>     directory) and the component4 argument.
> 
> 
>     > My understanding is that the server should have verified whether the
>     > delegation stateid provided actually belongs to the file being opened.
>     > Since it does not, I expected the server to return a BAD_STATEID error
>     > instead of proceeding with a standard open.
>     >
>     > From additional tests, it seems the server only checks whether the
>     > delegation stateid is valid (i.e., whether it was ever granted), but
>     > does not verify that it is associated with the correct file or client.
>     > Please see the attached PCAP for reference.
>     >
>     > Questions:
>     >
>     > Is this behavior considered a bug?
>     >
>     > Are there any known plans to address or fix this issue in future
>     kernel
>     > versions?
> 
>     AFAICT at the moment, NOTABUG
> 
> 
>     -- 
>     Chuck Lever
> 


-- 
Chuck Lever

