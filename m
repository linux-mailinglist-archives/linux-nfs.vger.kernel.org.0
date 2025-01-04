Return-Path: <linux-nfs+bounces-8913-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882EFA01703
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 23:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DD47A1A0B
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 22:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA901D5AAC;
	Sat,  4 Jan 2025 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C2wWc6tf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VoCFoRox"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD821D5CEB
	for <linux-nfs@vger.kernel.org>; Sat,  4 Jan 2025 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736028034; cv=fail; b=HKY2AD4ex03G2PMdLvfgOMlqka8VJq7Skwc7KAJ93CCaSB64eDN891FPA8ySaq6t+FE/y2FJh+Dya4/VRbPN9bwWdTOQR4NJuDmqnD5ZDiceLAJ1Eg9kH1X0o28CZ8fmUxBf/9DbA8iTqzaKabksNq2YL3SPStxjJTio+mZuBXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736028034; c=relaxed/simple;
	bh=+rfdwEXXYk4J+75pD2Ckc9WeLXBtrsMtaKOF8zMQqWc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C9xgf+ZfRCzQLJi3X3pmHujwqh+XDEpjPAHEI4hDm4Z3WD0xv3bO4gIvXbm17BExmGXgCBOxv9CdPC74YkApFAAaQ2OfXHYqSEHKgyrlGASptPiifViVtfn77vX/35ggYnZm21D1hvfMXQ1pdovNbTcbz5T7NaEi0ssNsrpLTSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C2wWc6tf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VoCFoRox; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 504KZ25P008606;
	Sat, 4 Jan 2025 22:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pbXSuDFix78hJg8UWWsVbjhNDgszOpvXpGWbA9ZRuz4=; b=
	C2wWc6tf40uDrvyKrkhBiJKT86dyZNZGnDpX2xwNS+3rOiTWsCozZe8RhfMxsF3E
	AllViP0Ow6wikwPKA8eSYrAf4YHmy/avCnvDPk+CvG3REkTvf9d63Srmp8CBR9gx
	Tq2wfwUi7cKaOQMDfCO6nyXcVyfUcjgw9bMVOkXr/SRXCRqj2A9fCLbGt56N9PjK
	Tftg4a0POvySML/BRe2obNXN9OTPSAsc46eQ9pFSwDJE7BWEEvpNfgQAHioGJjpq
	s0rEbHIpqcOxGKBa7IouFGXd6oD9D8eXQD8gTcger6m71/CqeE0CO9pk7mtjN1TL
	sszZhaddpkLurX0M7sXNAg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb0rws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Jan 2025 22:00:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 504IMxnf002824;
	Sat, 4 Jan 2025 22:00:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue62jjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Jan 2025 22:00:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkRPvxjbW8cUqmXFI645eylD/RUucy6zo573pouLbfvJHeuGVEiS+Ye/hO/cYBgUi58pXXDUhE4GQa8kPRm1r/Q5AblGNmAHJHs2jgghVUBaZIRe4K/ejh8zZu330gsHBEJpkhBjiJaE0BlpdLP+Gfcu52TvFu4EvM0jcPCVrhnE03cVXdW/GLKCtwTkc81kA4NDUHuM0rzOTreVF7blogidg/GiXAc8leDsSgoz6ghq4OnnhMbDNZzxKFQJ6FI9w9uJq12Dz1WYastYncRZ3b/Y1Zh1+4BDjZD4V6pTLP4ka1s/CZN2eP3Q47Ie7wpPugdKfd5XBcYwhL5J9xboMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbXSuDFix78hJg8UWWsVbjhNDgszOpvXpGWbA9ZRuz4=;
 b=DJIBFYccb2AjmKfSfbi4WR0LHwcl7W5gF1qO3BH7uvPTacPDFemdFVy5swQ6l69Z0zj31C9P2Y0A+QN8WfSDeA2vmI0l3fE2/wyAVaF7SvbJUUDu7u40ARpRRM2D3cvagzl4EzX4c9HnoSwMfeAzbRg0qTyZpUpwZqP1ohr4sSnKOnSplJgkX0Mgvz9gZUNcCTB9PPH30Rv2Ioyc/vogwVGATZXzeQ354G0rrFR8cefcwfY1RoyvyX/+Q7Zo/yvSnCFqR10QrMXvQ5nBQwjAyuApE+7iYklU0vS3ySjsDPbtqVmw/j+ZYch1KfgZPOrWY9pI9LtKV4DlnI1Y0eQRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbXSuDFix78hJg8UWWsVbjhNDgszOpvXpGWbA9ZRuz4=;
 b=VoCFoRoxbVBehykiEQB2mg20DerhSKUoz9rYXE1NEKgmuyFW4S+HP0OuGWI0XrHKztohIms2t/0Off96yb+KG1/IueW2CDDy7gSqjr34Hf0SHmrHBl24Oru7AgGH26YTKQol3KGS+fcdpros5omOiGMHTSMFyXVIsi5d2egluas=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB6820.namprd10.prod.outlook.com (2603:10b6:208:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.11; Sat, 4 Jan
 2025 22:00:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 22:00:14 +0000
Message-ID: <afb9f3f0-0fd5-4b8c-b407-7676a9267e8b@oracle.com>
Date: Sat, 4 Jan 2025 17:00:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: fstests failures with NFSD attribute delegation support
From: Chuck Lever <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>,
        Thomas Haynes <loghyr@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <b00b609b-13db-4404-8bdb-4550195362cf@oracle.com>
 <49f7f3ce-bcb3-462a-b1e3-a99ffb85f10b@oracle.com>
 <5056f1a4-cfce-4213-a605-1803c387e555@oracle.com>
 <a2ffc62e7698aa4b40712e11cf766d964a7cc646.camel@hammerspace.com>
 <24c6c65e-4e6e-423e-afea-b9f3407be4d5@oracle.com>
Content-Language: en-US
In-Reply-To: <24c6c65e-4e6e-423e-afea-b9f3407be4d5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:610:cd::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9d6782-20ee-4ac6-2259-08dd2d0b2aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aW9YS2pkR1JrUWdIZEQ0a0FTTnliM1hKVU1reWJ0RkFoWFdtTjA3M01GQlBq?=
 =?utf-8?B?bVZRL241S0xxWnJMbzZNWWpPUGU1NTNxbnY0Tyt6TkEzWURGZnJheVc2NGY4?=
 =?utf-8?B?N1JlYktab3lKNFRJeXFqa00vcXk2TmhTV3MxbE9JeXRoWm9URGRESnNXQjFn?=
 =?utf-8?B?WjgyWjMvdWZtYjBvbnp6eHA1V0JSZzV6Z1hZYmIwS1R4SFgxNFRNNUQ1MFI1?=
 =?utf-8?B?OTBmNU0vL0I5aFNMdEw1WURKQm5yL0RIWFNUVmFjRFFLaERwcTBmYnpSM3dK?=
 =?utf-8?B?ODVnaTZSSnhqMmxtWGI0NmFrMXpaQ2V5ZC9VUDQ3NnArWFAyamZXaVVwa2RS?=
 =?utf-8?B?ZXMweWJNQnpRK0NVRnFpd2JpQ3BJeVJTblhtZ0VPc1d0eUJJeEgvQ2pSMlQ0?=
 =?utf-8?B?cnNMR2ZOWEM5R0RSRG5NbVV0U0cweGZ2UWpJNk1jdktvQ3JLZnN2L0wzRkNa?=
 =?utf-8?B?RUFiZWIvMDk2TFdqZDkvYld1a0xsVUNwWklESFZvbzFXMGtDbGU4dXhCaEpj?=
 =?utf-8?B?YXQ2enBiOGlndmhNUFZ5czZ4MmVPL3ZGTDAzVmw1V2NlZkdvM0VuYnFvQTdk?=
 =?utf-8?B?em0ycGZqSWRQTkVCM09LQ3QrUW4yTWJMbFhveHZ5Wk5iR1AvQ2pMSHFjYjJo?=
 =?utf-8?B?VFBSMmpxbW42TDI3MWlPYXgwNTQrZFdHVG9TR2ovQ2VOc0FSWWUzNGJQU2ZU?=
 =?utf-8?B?ZFd0Mmd3YUUwQ3N4QlRoRlRxazJvVURqa1N3aUxKUkRkRTdKU0hJekFUbGxk?=
 =?utf-8?B?cVJKbVNPVnA1NHVsYzdOM2h6SHg4ZmxmeXJYd2xWTk9aWkNETFRIL2srdUI4?=
 =?utf-8?B?d0doWTVJNENhUnlidzhIOHZjUkhnTU9xQVhlZ3dia0FBLzVpMmFpZWVNQ2da?=
 =?utf-8?B?WXBSZFQ2NkRIRmR1SFMxMlkzMWRHRTFaRm1SYXhvQlB1U0RnT1hDdUVjSFh0?=
 =?utf-8?B?L0tQV3RoaXhtS3hXZjFoazR6TmNKQ0gxTW9WbTNKbFpKVlpnMDRRZGlZeDRl?=
 =?utf-8?B?dkdSYUJQSUtmWnErenUvaStWSkNYZ3M1MmhVc2xFZGdoMWNiNTU4NXNtMC96?=
 =?utf-8?B?MkJ5Znd0K09laEpvcFBxRVdmeGJYQW5GZ2F0SU5DZGhuMHpsV1lXeUJmTE9z?=
 =?utf-8?B?RGVPUnI0NGhGdkVkRlVnVHRiKzRjSXNscUlXMVJaZ0xVc0hZbXNqSGlmUUNh?=
 =?utf-8?B?S0E3NmdCYXdIMDR4OU1PRzNJaDVmbS94c2g2dFVGUkt3QXBmZUF6bTUrUHQ0?=
 =?utf-8?B?bm5wSkpTU2E1TmZDTUkwNlFxMXhYRDNXVE9DUUV4b0R3eVJjWjhoMVd0N1A4?=
 =?utf-8?B?SW5Db0xwTmdOOGowdzJKSHZhdlNLNDYwbDhUYk1JM0xlZU53RjBTdFJ3Y0x6?=
 =?utf-8?B?QUdkWXBjRktxdXVEN0VzcDk4bkdUMlZlTHlQaWY2U0U2RFE1aTdNZTJYcmR1?=
 =?utf-8?B?ZmhxQUxmT2hZRGdQaHhucFdLWldIMVpKSmMxU3VEbUdQL1NvN2pLdEQ4Ym9U?=
 =?utf-8?B?aTM3YXh1ZzlNNTdBVFpDYW1yeVdBUkdROGdERmt4Q2tVa2tMZUhRbDVQR25Y?=
 =?utf-8?B?bEtTbTNuM0Rkd0tnQmZ0SXZNUHlPTkRtOCs5amtuNjRyQXJUeEQ4ZGZxcS9u?=
 =?utf-8?B?Y1h2WSszOGQxbWZRMnJwTGNMZ3VTZzBQT3dOTU9CNDBJNkVsZFgyU1lIU0t6?=
 =?utf-8?B?ZDl4bGZFSWQ2MWhLakRyVUM5MnRaUjg0NzBWNjl0cEZKVlBTQ3ZjSDQyVVA4?=
 =?utf-8?B?UmxkTzFsbUgwV0w0ZUNsVmVURmZqempVSG9RK25JM1QxL0UwWjNVZ2ExN0ts?=
 =?utf-8?B?M1RaQTJZTG93cGNONkVIMmR6TWpJSFFkaEMvTXZ3ZThUSmU5L2ZwQW00a0lQ?=
 =?utf-8?Q?JFjwbjkzMyWsG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjYrdVNWQmpjb05FUStQbys1ZFJjM3JtT1g0em50WFJ4eFAxM0xTSzFTZnRI?=
 =?utf-8?B?dWRpS0ZYam9QVCtMdEdNVTBRL01RSjN3MGpxMVFkRmdKSDBBUVdpS3hCc2NW?=
 =?utf-8?B?ZFAzdUdxVVBTNWttNGJ4TkpFdHkvVUIrL0QyQkdqNDg2clc1ZWNpaEFhRHhN?=
 =?utf-8?B?ck9RdVlMaTE3WTlBb0w4UTFNVmd5NWNzbUF6WHhqamhnVm93WkJrazF3MG5j?=
 =?utf-8?B?UG9yNHo1NVlWd3pDclJORXRBb21vSDhZQUVtTkV1L28vQ1cwUW5udUVFVUxO?=
 =?utf-8?B?ZERQVUIrTWFxU2FWdnNHbThMRFpFSUFVTGptU3dKMEFra0FsanNjRzRTODJk?=
 =?utf-8?B?dVpCU2JXcFRXQWt5cWdGeGFYNHk3bTZ0R3QvQ00yVytIWElHRVdjdE5lS0Rq?=
 =?utf-8?B?NzA5U2Rqc2hPb2F4cUFiQ0tuLzdpNEs2Qm5pbUxCZUZoR2NwMFg1dnErWSth?=
 =?utf-8?B?c3lzVmZTSERjbnBnQWN1SzhqZFNDTkVjUTQzS2tUQnVaTVlUd0U3dEFxa3BR?=
 =?utf-8?B?Q29RZlpxYUFuZ2tybkxzNHV0ZnphbFRBTUxES1pDY0pncXlMUHpLNUFNZ3RR?=
 =?utf-8?B?NDR6SlJNVEJLK05rM1lkdGRaTzRaaXJtT0dzMThMNWhUbzE0OWdyR3cyK0RW?=
 =?utf-8?B?QWhCWXNGVlY4bGRITUczVWxzeEdydHVYcTBiVjlBV005QzJ6NmpQZkFuYkFZ?=
 =?utf-8?B?aDhkUnF1WmpWekhGd3YrSitQcWFWMUZrODhIRWp6VDYxOHlXd0xDM2FLQkZY?=
 =?utf-8?B?S2F6QUttYU5EeUhKeEE4d24zdThtYmxTK2tKbS9LNGc5TWtweDhubUoxRk9Z?=
 =?utf-8?B?N1M1OHZFUzVtZ2d0TzRTa1NXS0ovNGFSQWJIT3piR1N6S3B2YmozZmtuVG5x?=
 =?utf-8?B?SUg3dDBIbGdIcWdzSXBQUGM4em5DZXBSTWNvZk9YTHJGS0xYL3V0ZUl4Rjlq?=
 =?utf-8?B?YlovSzRJMndPd0VzZ0xVS1N6YSsyS3k1WVY3c2JaWE5wdE1QT2I4bG1PS3pP?=
 =?utf-8?B?VWhSd05KTzNFYlNUKzNNNTRiZ3dPMUc1d0tmcWluZE1odVJsTWJ0U2hwWEV0?=
 =?utf-8?B?RHMvZW5SdXNWZFF5Mk12WmFYbE9RRDVVVlJlclVuVGJLaUFGcTF3RWRzT2lp?=
 =?utf-8?B?emlCdEZNb2UybCtSZlU4QmxQSjdOOFJ6WUwrREVQNldyYXhqWHd6ZDRGWU1F?=
 =?utf-8?B?MTJGeFpsb3IveGJsa1U4TDMvYlE5ZGNZWUFmQ3FFaEc5UHlVUUJKQVN6RGFv?=
 =?utf-8?B?ZFlxYVJSbFhRaGZXOXpqaHRPZkFucnRhMStwMlQ4WFNiY0E5Q0Uxa2p3MTMz?=
 =?utf-8?B?YW1hL0ZnS09xa0tpSndtcTVRZjkrSTJNYVBaWVJJUDFFMnRibG5NS3VUbnV3?=
 =?utf-8?B?QlVuRkpUOFZLRW5IUVpCdTlrYjJ3d1hoUHUyN0U1RHV6cWc1RGhFWVdleHM0?=
 =?utf-8?B?YjdIV1YyRlU0R0FZR1NjOXFzV3FWanlHWEExSXBBd3hhZitOeE5mbzR6U1Bp?=
 =?utf-8?B?a2N3SGRQOENhNkV6UjNvREFPbm8ydTVDNkI4S3I5MWNTa0RseW1ER3lIRldr?=
 =?utf-8?B?RWN3bU43SXZJeXZOUnFJaSthazJoU2xYNTJKYUx4Q2Q2bGxNbURjcmZEQmZ6?=
 =?utf-8?B?ZUdPYVBaZEg5Mjl1Y0ppditBSUNVaGg3MVF3NlpMM0gwVmVPTERmdmdic1p5?=
 =?utf-8?B?WXAvc3NSYnAreFZTd05MN3BldW1mY3lTTmhrLytPZDQ1dktOTDc2RjBLanR3?=
 =?utf-8?B?N1FpbitKeFlEYzBad2RrOVNtaFdRcVo4MkdoQk9zNjlDczhYY0tIeUJoZGVk?=
 =?utf-8?B?SDhlN0I5d1lSUzJlbE54b0ltVlZSdlpuMDN2bnJJTXpNb1hkeUJEckU3QWlG?=
 =?utf-8?B?UXc5MWdWcjJLSnJnQjQweTFpdW9naXcyYTdiNnczMDFKenhlVW9zQ3dOMDZI?=
 =?utf-8?B?L1h0NCs4U3p1NUdtaStISDU3cm9VR01uUVc0bjJFZ09BdkFWL0hOMTQ0YmVV?=
 =?utf-8?B?S09GWGhjdkZDSUhWcSszTW1oc2x2UkRQbG5nZ2N3T1FNMStjaVVJZ0pxWHJk?=
 =?utf-8?B?NlRKdHBQa1QrL2d6cGNxYVZKQnQ5VmJobUNCUzV5eHZDS0FGbi9pbXJTYmNF?=
 =?utf-8?Q?oZ5I61BK9y7wq9l6iEa0VU0Od?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oFUh8GvYx7DBRyA8jreaU799hqo/pR50JbwzK+AsMGPKWn2DfLYr6p5gMSn0xW2owMNDSme28ScrTVvQUtP+DZ7QsHEuPplWdv34vRX7jCC5YcWg/USQ2acKMWS9gSjtqztpjQHFgDrBFLLEjwYQsCY7eMrFCWrI6mGibJx9gPFfRJ/McWQTUQxnjp86z21oFj+pJM7Y3UXQ2LOLjeRJwB3qklPuHjwojpIwPTSsxrK56m9w0gOkQHasIk2hfqmsEMOhGf+H9IjeulxjvpiVMXVZtpDcdr/0L3IJ3w7UuMQwloxU6V+luku8mK4bJu/QH9ctGd1WwkmFe+CsdXK3tXKwbLRQ7ugiQuWFvhEajmLDvShuL+HpQoUVaWcBpMbWHcEak7PA5FTs0s+US306DcdWcrgyWJhd3i5xqxoT+s9kUhsFIoWUgaCODnkI9X2b/8pbOyIIhFKCvgm6W9x84vTFbsaynE1gX3tej5cGDXHjnvVSNMUbFm4b4t1srChs+3Fg019idAhX2msG5KUyCGPcCLf6HrZqZq5+YLeIIB6x0cNFJYPAKseQIJuxqcQlzOST77+4NXbgxbFLZ/iDwmibIiJolW0S+5NpzTl2wME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9d6782-20ee-4ac6-2259-08dd2d0b2aed
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 22:00:14.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzWnKlowr/iK2Lsd++9CXRqObAHt2GjKkBFYMJhWO1t1YlGMgAE3FComdevnJos2uXTPEEYMAQASSLHQOMvcog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501040196
X-Proofpoint-GUID: 86zNYRnDHqr4cg_-9AckwvIvhr58ZKSQ
X-Proofpoint-ORIG-GUID: 86zNYRnDHqr4cg_-9AckwvIvhr58ZKSQ

On 12/30/24 10:33 AM, Chuck Lever wrote:
> On 12/29/24 8:52 PM, Trond Myklebust wrote:
>> On Sun, 2024-12-29 at 17:37 -0500, Chuck Lever wrote:
>>> On 12/19/24 3:15 PM, Chuck Lever wrote:
>>>> On 12/18/24 4:02 PM, Chuck Lever wrote:
>>>>> Hi -
>>>>>
>>>>> I'm testing the NFSD support for attribute delegation, and seeing
>>>>> these
>>>>> two new fstests failures: generic/647 and generic/729. Both tests
>>>>> emit
>>>>> this error message:
>>>>>
>>>>>     mmap-rw-fault: pread /media/test/mmap-rw-fault.tmp (O_DIRECT):
>>>>> 0 !=
>>>>> 4096: Bad address
>>>>>
>>>>> This is 100% reproducible with the new patches applied to the
>>>>> server,
>>>>> and 100% not reproducible when they are not applied on the
>>>>> server.
>>>>>
>>>>> The failure is due to pread64() (on the client) returning EFAULT.
>>>>> On
>>>>> the wire, the passing test does:
>>>>>
>>>>> SETATTR (size = 0)
>>>>> WRITE (offset = 4096, len = 4096)
>>>>> READ (offset = 0, len = 8192)
>>>>> READ (offset = 4096, len = 4096)
>>>>> SETATTR (size = 0)
>>>>>    [ continues until test passes ]
>>>>>
>>>>> The failing test does:
>>>>>
>>>>> SETATTR (size = 0)
>>>>> WRITE (offset = 4096, len = 4096)
>>>>>    [ the failed pread64 seems to occur here ]
>>>>> CLOSE
>>>>>
>>>>> In other words, in the failing case, the client does not emit
>>>>> READs
>>>>> to pull in the changed file content.
>>>>>
>>>>> The test is using O_DIRECT so I function-traced
>>>>> nfs_direct_read_schedule_iovec(). In the passing case, this
>>>>> function
>>>>> generates the usual set of NFS READs on the wire and returns
>>>>> successfully.
>>>>>
>>>>> In the failing case, iov_iter_get_pages_alloc2() invokes
>>>>> get_user_pages_fast(), and that appears to fail immediately:
>>>>>
>>>>>      mmap-rw-fault-623256 [016] 175303.310394:
>>>>> funcgraph_entry:
>>>>>>         get_user_pages_fast() {
>>>>>      mmap-rw-fault-623256 [016] 175303.310395:
>>>>> funcgraph_entry:
>>>>>>           gup_fast_fallback() {
>>>>>      mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry:
>>>>> 0.262
>>>>> us   |          __pte_offset_map();
>>>>>      mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry:
>>>>> 0.142
>>>>> us   |          __rcu_read_unlock();
>>>>>      mmap-rw-fault-623256 [016] 175303.310396: funcgraph_entry:
>>>>> 7.824
>>>>> us   |          __gup_longterm_locked();
>>>>>      mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit:
>>>>> 8.967 us
>>>>>>          }
>>>>>      mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit:
>>>>> 9.224 us
>>>>>>        }
>>>>>      mmap-rw-fault-623256 [016] 175303.310404:
>>>>> funcgraph_entry:
>>>>>>         kvfree() {
>>>>>
>>>>> My guess is the cached inode file size is still zero.
>>>>
>>>> Confirmed: in the failing case, the read fails because the cached
>>>> file size is still zero. In the passing case, the cached file size
>>>> is
>>>> 8192 before the read.
>>>>
>>>> During the test, the client truncates the file, then performs an
>>>> NFS
>>>> WRITE to the server, extending the size of the file. When an
>>>> attribute
>>>> delegation is in effect, that size extension isn't reflected in the
>>>> cached value of i_size -- the client ensures that INVALID_SIZE is
>>>> always clear.
>>>>
>>>> But perhaps the NFS client is relying on the client's VFS to
>>>> maintain
>>>> i_size...? The NFS client has its own direct I/O implementation, so
>>>> perhaps an i_size update is missing there.
>>>
>>> Because the client never retrieves the file's size from the server
>>> during either the passing or failing cases, this appears to be a
>>> client
>>> bug.
>>>
>>> The bug is in nfs_writeback_update_inode() -- if mtime is delegated,
>>> it
>>> skips the file extension check, and the file size cached on the
>>> client
>>> remains zero after the WRITE completes.
>>>
>>> The culprit is commit e12912d94137 ("NFSv4: Add support for delegated
>>> atime and mtime attributes"). If I remove the hunk that this commit
>>> adds to nfs_writeback_update_inode(), both generic/647 and
>>> generic/729
>>> pass.
>>>
>>>
>>
>> I'm confused... If O_DIRECT is set on open(), then the NFSv4.x (x>0)
>> client will set NFS4_SHARE_WANT_NO_DELEG. Furthermore, it should not
>> set either NFS4_SHARE_WANT_DELEG_TIMESTAMPS or
>> NFS4_SHARE_WANT_OPEN_XOR_DELEGATION.
> 
> Examining wire captures...
> 
> 
> In the passing test (done with NFSv4.1 to the same server), there is
> indeed an OPEN with OPEN4_SHARE_ACCESS_WANT_NO_DELEG followed by the
> WRITE to offset 4096 for 4096 bytes. The client returns this OPEN state
> ID immediately (via CLOSE).
> 
> Then an OPEN that returns both an OPEN state ID and a WRITE delegation.
> The client uses the delegation state ID for reading, enabling the test
> to pass.

The above is not correct. Upon closer examination, the delegation state
ID is used for the direct WRITE in this case, even though an OPEN state
ID is available.

But since nfs_have_delegated_mtime() returns false, 
nfs_writeback_update_inode() proceeds to update the cached file size.


> There are three OPENs on the wire during the failing test.
> 
> The first two set OPEN4_SHARE_ACCESS_WANT_NO_DELEG. For those, the
> server returns an OPEN stateid, delegation type OPEN_DELEGATE_NONE_EXT,
> and WND4_NOT_WANTED is set.
> 
> The third OPEN appears to request any kind of open. The share_access
> field contains the raw value 00300003. The rightmost "3" is SHARE_BOTH.
> I assume the leftmost "3" means WANT_DELEG_TIMESTAMPS and OPEN_XOR;
> wireshark doesn't currently recognize those bits.
> 
> NFSD returns an OPEN_DELEGATE_WRITE_ATTRS_DELEG in response to this
> request, with a delegation state ID and no OPEN state ID.
> 
> The client uses this delegation state ID for subsequent write
> operations. The write completions fail to extend the cached file
> size due to the presence of the delegation.

Here again the client presents the delegation state ID during the WRITE.
But since the write delegation also permits delegated time stamps,
nfs_writeback_update_inode() skips the file size update.

In both cases, nfs4_select_rw_stateid() is choosing a delegation
state ID for a direct WRITE. In the this case, it's choosing the
delegation state ID because it has no OPEN state ID (due to
OPEN_XOR_DELEG being set).

nfs4_map_atomic_open_share() seems to be selecting the wrong
bits to enable for this test... ?

-- 
Chuck Lever

