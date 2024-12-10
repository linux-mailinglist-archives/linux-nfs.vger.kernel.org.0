Return-Path: <linux-nfs+bounces-8507-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E230F9EB2E6
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 15:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A99161843
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84EB23DE8D;
	Tue, 10 Dec 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cx9XTyTc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jmIYm/9r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B97C23DE86
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840145; cv=fail; b=cfbtTn0R2x1LeRxocsthmUgeN0KiySvLUhlK+rR2KtYCWsxoMCgrvh1QbIUiNCCTpOn+SmU2PEXgX6e7SXonbsH8kE62EvtUz5lbxTazDXN6IDWUXeuab7R5DguiOfZ2znkcKChwDOV1bmqXqR4W+GlubA//ekH7tmTceQ2AboQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840145; c=relaxed/simple;
	bh=1ETCAhXlrkdJDu999hJ2BnsuRQYHaUyP2HJgtTKdZOY=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XX2G/553EYutREGOd5I7u8qTkb7f/5LcjO60FypN6re0cNZO9IY297Ix57OvWDw2ro0nSl9a+CzxeKlMyGMzeCyyleHcLJU7UFk35K2Ns0LQB2E+rdS+QROsy6lTSMc/hEEw7tHeCnDkzdOych94hUKQ+gFIbT6nq/EWz68qbek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cx9XTyTc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jmIYm/9r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BABeZRM028597;
	Tue, 10 Dec 2024 14:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=M0pvRmPYbRGIfKL097Xdf62bL/N2pEOO4bxuc5Ddn+A=; b=
	Cx9XTyTcI7MmqBFvS++vV5ZXLjeRxgyIrT1hLURgEWuosb/2R34R3OzUYo10/Wfa
	Eu29bC0x2gQoSn4u18hi1EC2W36mGn//cOxlG/r/EyVmmYvObhguAlwWOBJG8pg5
	UkylYloLWNuvKUb2VVwEyunqKJWy92pIqknSjuUlsXgFTe4Vje86Y1UFfvYQr3KK
	D6YR5EPXgtYJrjk8oWiX+FLpBuFDBXIEwyaXMgj0CCijfj6rKtCoarqFVIHha1E4
	/pg1EOOZXRwEiHTTIzxSXT/nKPBPDt5E6+/ahMeqUFXkrivAiJo8/V2S/PGV+TPA
	y3Uc96Xwjss7z1MJfri6pA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce895rup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 14:15:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAD0Nv5035101;
	Tue, 10 Dec 2024 14:15:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctfumd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 14:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbTab6t8OgPJsUKfJP4vQJsyeSc3MnpaGWm0dg8FyZq3eNWZaJCeG/G/Qp2kbHukujdYxYEj8aMMs1nlGOhthaWWuOQzPzoj+zT9xH2z4eQC09Ytq/e6fPO+qHgSLU1oTHuORwicgtl8k7LHr62YA+5yY2nB7QzezVtPiMgLD0sWobTlwLCD5BCZsJTMtJzrp2k4TdwO3F3WSr85jRLVPGuAjjutFU6dYqXZy6f0NcU5IA+EINfWjR8vdG3h1XLhfMVGAiA1+aADvyloK36GyMMRG7DEoCOZ+dCzFtcgGrBrKFB2VeiPFKnSb5bHucfr3wfjU9kf9nWvt/m53lcWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0pvRmPYbRGIfKL097Xdf62bL/N2pEOO4bxuc5Ddn+A=;
 b=OpaMLlcHFjKnNkOsWXFzfubVz1oppTplrSvggS6t8bua3WEc+emduYQQQxMFaNrycIty+/hQ5freATbgE1exGWNqy2x6X+amK/ZtDTEnNWy7+m+7zsbEzh7SVUzY/iaCyczyNxGcVOb0FE1qo54zSMPjUtaXM1pU2VFNpeML0h3HeALcK9zV2DnmpfFe//UxY6UEtmGQ4xN8GbyA+zGqhfXPw9gCJMJ6Ryomw9DrTP7NQhlVCQxIlZ99leTo4LoCS47Zr1aPE/Q6IQuNma7uc/nRyOtcCiMQz+ZHsxkXSFAUf/YY1XloNyFI1lNa7gr9TNRujGnIZ/S8HWP7iKdZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0pvRmPYbRGIfKL097Xdf62bL/N2pEOO4bxuc5Ddn+A=;
 b=jmIYm/9rZmvK9dlfvjBS9NrXhgV8belubI0I9IU7s7AnF/WZPBT3RkbxX+ISxHGCF+ULK+QVFgu5kSrhmuXjzYXZEn9iDfbPG9Ows7DbGQ+NscuJf+GFgu03dQXYzGY72k3lmHmuJXKn8OOLortaBRiMn7XFht1ZuyFMPtMzFUU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5771.namprd10.prod.outlook.com (2603:10b6:510:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Tue, 10 Dec
 2024 14:15:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 14:15:37 +0000
Message-ID: <71e31b5b-1318-4d5f-a96c-abd0b2fc0018@oracle.com>
Date: Tue, 10 Dec 2024 09:15:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Cedric Blancher <cedric.blancher@gmail.com>
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <173369594365.1734440.14357278787243353853@noble.neil.brown.name>
 <CALXu0Udmn=AqRBAcBPf8=VAP3KN4f-vnEJFLg3OnkyRdT3b9rw@mail.gmail.com>
Content-Language: en-US
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALXu0Udmn=AqRBAcBPf8=VAP3KN4f-vnEJFLg3OnkyRdT3b9rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:610:b2::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: a55ff22f-1618-4702-5014-08dd19251e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnZ2eFRnQWpTQ1IvMjQ3THYvb3k1c1ZpRUd5bzJmbEFzWmVXU2VMdUU5UldL?=
 =?utf-8?B?VU9BeGZRU21kem80ay9iNm9vd25xcHVmRWF5WDJ1TWlkd2ZCY2hJTlhXS3cx?=
 =?utf-8?B?WHdmSUduTFY1cHhURit2Qm9QNUZjWnBHdk5tYk5HUzNoMXRMZnVGaVBrY2Ry?=
 =?utf-8?B?RzZkSStKQjdzMkI5TjdJdy9sV1NibmdOQlB6ZFAvcGZhR2hJSkxkdFVhK2dR?=
 =?utf-8?B?bWlyZnZZdkNHV1ZkVHJOZDFrVWpwdENHZ0owVmlMVWV6RUdTNkVSMFJQa0d5?=
 =?utf-8?B?ZkdFL0VIeGltZ3lER2VRTjNleGpsK094TDhIbTdUeWRBdmZTZ20zNzFvMUdW?=
 =?utf-8?B?ajYwVkhXUnlIOTRWUFJzTERZWTRZWHJKWG1Fd1pEZnR3emtWMkhXS2FtRzRX?=
 =?utf-8?B?YmZNSlBBRUdubkFod3pXbHVrdkFYMWdSR2V1ZWFGMUI4cTBZbmswMUlwVWxo?=
 =?utf-8?B?eWlnd3pNb0tFalRGclNFRm9pTlJrQUQxQnE4djZqYnRieW5iVU5lenBxeFpO?=
 =?utf-8?B?aS9VMEI4V0JKdWRjWWtpdUFCV211MDEyaERKK3FpK3Z0czFFbFpwZDNGTzk4?=
 =?utf-8?B?bHcxY3BGRnFqUlNBbW9QcXVHSUZrWnpZWTVvUTg5dE1NT0p6UlY0NzkyU0dV?=
 =?utf-8?B?WitBYnVwSDVMWXZHQk1HNFFGZTFoV0ZyVkpJMzBCaC9NL3BSVy82UFJYZWcv?=
 =?utf-8?B?QWU0ek9GNVFBMm5kcERGUkc5K0hEbysvS0RXYS9JMW1qK3UyZ3ByOWdQUXEy?=
 =?utf-8?B?ci9YQkM2WGVTaE0yQTJmL1E1cjJDaXoxcTJjaXQxOVhzMjBYMlBDWHM1cnpH?=
 =?utf-8?B?S2NyTVdnVFFiMXFhQ0xsL3lKRTQxUHpZekR4WTRFNFpVVE00T2Y1V0RtUXYv?=
 =?utf-8?B?d2lkazJ2Ly82NzdDelFmaWRzTWFNbGFlSXRtQmxKSzhGNnZmZmJQcFUvYkVi?=
 =?utf-8?B?UlNRZHFZZmpXQVUvaUlDbEM5OThnU1VPQm44UmJiSElZSGVtbHBtTDNJZVlj?=
 =?utf-8?B?b3ovZXBmTVUrcitpcnhQOGpwRGdTSDZQVDlzcWNVS3pCblQyb3JreGdwMzdq?=
 =?utf-8?B?NmtETG5pdGFCY1lNSkNwU2doazZvUThBRWJDaU9qWFhpUjYxbHdBbGpRVUFT?=
 =?utf-8?B?ZC9MSXY4ejNCazJoNEw2WXplSU1JZGltOXB4c3NsOGpRR2ZudnJvRnJyUDVh?=
 =?utf-8?B?L2lLVm1nN21jTkRZZGhiejNBYStnaWdPUUZ5R0E3bUowMHBTTmcwMUIwZTUw?=
 =?utf-8?B?dHNxbEx1Tk54MFhmSSsrM3I4M1V5Njl1UlB1RkRFSnZFbE8wMXY1VmJOc0pu?=
 =?utf-8?B?a2N1d1dQSks2M0NUQm5LMkROejBSb2tieFh1UlZYMUNyWVBhdkorWXAveVlN?=
 =?utf-8?B?bTlpZUtJOG1MSm9TSlRLL0xUOXpNVmU2MGdCeldMS0w0TUJyeERRdVQzNUth?=
 =?utf-8?B?cmMrTStITnZva3QxMmZ6K0pJQ2lXZVlYMEVVWlZqRXplUlZhNUdBT3FmeWsv?=
 =?utf-8?B?Rm5xcnBldmZFOUhEV1RnR0lsOGN5aXptbGk1bDV6UHo1dVhBYm9LRlZ6SUZD?=
 =?utf-8?B?RkFsVFFTQ0YzZWlaR1lLMDJMS3lrWlBQMkc2Q2xnRGdwRW9XTmhhQS9YWW5U?=
 =?utf-8?B?cjdvNE0vYTNSbG8weG9hRi9XeVBWMmtqM21HMGFnMjRrSW1RREtndm9KQ05D?=
 =?utf-8?B?VW5Wc25XOUswUXVHUWFvV29sU0lzVnZqVkhuNVU3Y3JBOE9IUVVoL1E3SHpC?=
 =?utf-8?B?N2lWVjFWQ3ZVSGtvV09pcHBVUkRYem56YS81OWZubjJ1UFJJd2MyMnJJUGtD?=
 =?utf-8?B?UTQzUDFFU1NlcUxkMHNZQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHdVcVNBNCtaNGJ6cjd0VHQzQzFRUHNseDVVYUVqbkdTWVpaVU5DaGRGaUds?=
 =?utf-8?B?L3owQUdMb3Juakh0WUtvUG1kRGhNV0RRUjZDczhSYXU5MmhhNmdqUkNXZy9n?=
 =?utf-8?B?QWNwTVg3dUkrQmpzdTZVZUZsdlA0b1lyZXNmMkxsZ2hvcmJ1Y3Fkc081WkVi?=
 =?utf-8?B?ZG9acUxsYVFiY1Z6L1NsUVZTeHZSUGp0WS8zTVFnUUFqcHFmc1k0djVjQ1JT?=
 =?utf-8?B?MmJ1ZTB0ZitXSnBNNFJFdnBONlJaLzdXTzB5Q0k1cCt6bzhjdU9ZWmxPRDBR?=
 =?utf-8?B?aW56NFV3WW56V0g3VTFBbTdGU2dHdllnaE8rbXdDVEltK1VkeW9Xcng3bXBv?=
 =?utf-8?B?d0x1THprVGNMS0xQOEpLMlFtZ1dpUnVtbEtFQjY0Y085a0JaenBkTzFwaHVD?=
 =?utf-8?B?djFOMlBlUW1ZdFNENTUxS3RmSTFHNEJDRUR0UWpHYW0zV0YreEp5aE9rWEcv?=
 =?utf-8?B?cU4xT0Y5TmNZdEVRNnIvQVNtcG9VQVREQ3FkMll5dEFXenRkcWIwTWgvb1R4?=
 =?utf-8?B?M09EaHNhNjAvazQyNnAvVjhiQVhLa2pFME5KZWZuOEFNM1djc3hNSXZTZTVy?=
 =?utf-8?B?bDNQZFk4MHMzTmU5NFhuSHB0TzUvTDVRdWw5UCtZVmt5OUxLQkZPT2RCNU1N?=
 =?utf-8?B?MEVGSVRYYUpjbW1RQWh6bGlBQWZER0JndC80clpqUUNiUnVDUTNFSUl6cDVP?=
 =?utf-8?B?THMwSi9pSFdlcXZqcGFFTUFuUzBuN0doR0Ftbk5qM20wSlhRd2VEalJWQmhl?=
 =?utf-8?B?YTZNOCtoZUJLVm93L3lkWHUwUmZjT1BJeWtEVSt6LzAyOVpnQk04UDNza3Vv?=
 =?utf-8?B?QmhMeGJFcHNYVXpmTG9SMGpyMXdRUENoVjlSeElVM0xhLzQzOVlNamhuK1ha?=
 =?utf-8?B?YkhaZVJnckloZkRoUy96d0V3cktTUjZjcHVJSjBQWUtTVE00aHM2UE0rY0Jv?=
 =?utf-8?B?NnhqZWFIeVlsdW5HY0t4bFhHWjFMNlhENzJLRjE0RFRjcmI0OFBjd2NSMUJy?=
 =?utf-8?B?Sit4ZmNtVXBLcHRmSTFrd3U5Q1Yra0pGU09QOGgzaW5ZUThQWld5R0w5WWJ2?=
 =?utf-8?B?bFN4TXhRSUNZeFRvcW1kY21nOTd1MHV2VUJEOWpZaURlL2gxd0pOZDZJR2dt?=
 =?utf-8?B?WllNUzRpQ2RYeWxiVFB5c25YVitLcUR5a2tuUWJkQUhMZEM2SDdRZWR6MFBu?=
 =?utf-8?B?N3BVcytHaXBKUC9lczBqUkxpQ3dEbWZZYTMwMENJRHRWRVB3bUtIQjROREd3?=
 =?utf-8?B?bi9ENVpmWlplOFF2L1c2M1dEbkVuczcvZE5zbmUvNHlTS2JPMmNIeUJHdEtW?=
 =?utf-8?B?ejZ5UENpVTdlQ203K0VRbDF1ZzhtUzRNL2FndkNSZ3ZKS3hOQVMwVk1GNkFU?=
 =?utf-8?B?V3ZEVXBsNmNwVXdBU0NPZ3pTRDVvRWkybXBHNklVaUFqZnR0ZlZtNkFoSkxp?=
 =?utf-8?B?WmJ2U05GWWRJUnRwQ1FzZFAyVzZiSW83ZGhzZ3dIZXpQTHFhRFMvVHo5VlNY?=
 =?utf-8?B?QXNLdS9ZeFNESDJ0M1loNkx6bTNlcXJXZlhBSktyMlQ0T0lsUndYNm5TRHVP?=
 =?utf-8?B?dncrSnhENjdDUFZFS3RLN3NOM09LU1FLa3QwaTA1UW1idjRQREZaUmhOaGZr?=
 =?utf-8?B?TkVocllZc3granpzWFZmNTJXalRLakJsalZaTkdZcmpvbE5aME1VSWRPTFda?=
 =?utf-8?B?OVlqdUxYcnA2cmRzdlZPZHYrenhJYktTeWN0UHpmQ2IwSHNLeHhQYVg4UTNW?=
 =?utf-8?B?T2VwWFhUcFYwYVhPRG53anRRc0RUT1kvQzJtV2JwclZmYXlyajFsQVJST0VO?=
 =?utf-8?B?V2RBaE5vdVZrVWRtMHlJZG12U3FLbUh1WW0vTHhoUUh0dndrdDlkNFRqQVhD?=
 =?utf-8?B?Yjh0QlhONlBjby80SzVXVnM1dGFqLzMzRWlHaERmK2FVQjBFbDlvN0NoVzB1?=
 =?utf-8?B?ZFh0VS9ZMXd3eHg3NjJTS0ltT0FkSzNiY1ZDVW9SdDNGcXdaOWpBVFlCNGwy?=
 =?utf-8?B?ZXJHZlhXaEhxaTl4V3JEYVJEd3ByaEtLRDk4djhlVWkwUDF2RGlUUEowNjkv?=
 =?utf-8?B?VU9pOXBZS1p0ak9CNnZEVzRMM2djNHI4NDVJcUthY09WdkxuWExWeUwrL0tH?=
 =?utf-8?B?b2tGdmMzTmF0TXZ6VTdpRlpVSy85U0s2RVA3dnJSYUt5eEZUeUJ6L1ZLOHda?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FkrsEYQWbMmIOl66+PFXhaVlPWtkDm+J0YxkbbvQXR0peUkw49sJi9XggUPZFgjkpMYpqzzYV241xuqqRCm1ktzMyq4bI2pGvjnDZLYGXZJMTN4Lpbkeg4fUtAxjCF6hPyoC1pUnkwmY/ajlfzcF8/Wsy9sL9Zw2Y9qKmATCqzMTB+4AI7s/qYngc0YrYFiTnFQWLB4K6J+MnCoOh8O65zRian2qqD4dHz8et7PFrIztoMlGc+QwjN0pC5z3qlvCWkY3hWK4eC4MxxeanEogzIf9Cvd9LnTpmBgx+jSopxPQJ7ZaYcji3eZfuAPQzsp0Ya8xdk4ROMtRertpOfHFcbT+E7Yb3b2MQxanfVVykZF5eW4eJf4ss33YrnGhTRJIjvJeBUMvgkZMMSbyfTYjhtfW6kTSFc+F8gg9Dzg55fVLzp26t44gjSzzU6O9CfaoM073vmD2ezppb3URi4tZdni8YrYN0vYwy7loA0ZCpLMhA+oqGT4nFvaXlBaNIxpgAGfaEYlFkBwazBHtWvkPFdu49PBC/Ou09G8CdbMsaq3kX4x8As01VGp+XZa6IxT5ck9POAot1Hq7f3R0h2Srt3+eCVqIEL2L6GrzhO1kUWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55ff22f-1618-4702-5014-08dd19251e62
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:15:37.1999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vJCeacK/DUlrgSjB6onqBSeEfizxk+7ACj7kemljhjCt5wY5MqNFlXT5CooXFMqi+XkHt9pAwGIs1KIJeAD3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_07,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412100105
X-Proofpoint-GUID: LkOVYB8z-RK_ZhckcWYeXk0TMVBpjnkQ
X-Proofpoint-ORIG-GUID: LkOVYB8z-RK_ZhckcWYeXk0TMVBpjnkQ

On 12/10/24 7:13 AM, Cedric Blancher wrote:
> On Sun, 8 Dec 2024 at 23:12, NeilBrown <neilb@suse.de> wrote:
>>> +
>>> + /*
>>> + * |pnu.uctx->path| is in UTF-8, but we need the data
>>> + * in the current local locale's encoding, as mount(2)
>>> + * does not have something like a |MS_UTF8_SPEC| flag
>>> + * to indicate that the input path is in UTF-8,
>>> + * independently of the current locale
>>> + */
>>
>> I don't understand this comment at all.
>> mount(2) doesn't care about locale (as far as I know).  The "source" is
>> simply a string of bytes that it is up to the filesystem to interpret.
>> NFS will always interpret it as utf8.  So no conversion is needed.
> 
> Not all versions of NFS use UTF-8. For example if you have NFSv3 and
> the server runs ISO8859-16 (French), then the filenames are encoded
> using ISO8859-16, and the NFS client is assumed to use ISO8859-16 too.

I'm still trying to understand the usefulness of supporting NFSv3 as
well. I understand that your usage requirement is only NFSv4.

However, does your comment mean that there might be some cases where
a client administrator might want to mount with NFSv3 using non-ASCII
characters (of any flavor) in the export path?

I'm also wondering about non-ASCII characters in the server hostname.
That does not depend on which NFS version is in play.


> mount(2) has options to do filename encoding conversion
> NFSv4 is an improvement compared to NFSv3 because it uses UTF-8 on the
> wire, but if you use the (ANSSI/Clip-OS) nls=/iocharset= mount option
> you can enable filename encoding conversion there.
> 
> Traditionally it is assumed that the admin runs its shell in the
> locale (implies filesystem encoding) used to do the mount(2), hence
> the iconv() to make sure there is no encoding mismatch.
> 
> Finally: Not everyone and everything will use English (we frog eaters
> are proud of our language!) or UTF8, and it will remain that way for
> the foreseeable future.

I'll repeat: none of us are denigrating languages or usages here. We're
attempting to clarify the problem statement and refine the use cases.


-- 
Chuck Lever

