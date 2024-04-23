Return-Path: <linux-nfs+bounces-2966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A21A8AF638
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 20:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EEB286239
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 18:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FDD1422C2;
	Tue, 23 Apr 2024 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gx3M2PKk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SMLBHSZH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091AA1422A3
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895370; cv=fail; b=b4j9LJz5B42AIW/fj3j4b5TzP8DHCoYpZzJK7r7THRgVWEzFxmVFYNRB2S+HYEqJyY3Guso/wMDYGfjd8Yy+B49bw7eojGICJdzrYX8rdyoR/1rHk63lg2B9kSpDqC/9qzt7yeBsLkrhr8zZ2DlEogSSxuaxeki7u4rAXexMydg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895370; c=relaxed/simple;
	bh=EoyTSbUqq7OXU6psjdIv6u0hzJkQM52Qr9YIYlvmEWY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WCHO3L5CNfpxrhGm5Vnsn/iMmftVLoQhoQeenXXtiWAFIxa/drwIe1nICcaw7F5aYnEX9W+Z12nYtdVxHYMqF6MOZFmcUqpp0aaoke0zvul72Fj2Jlx4EMlK/yG+RPn6G4dvS9mZppmnSRU28D8iCOgga1gtNuWKSxBgSh/v5IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gx3M2PKk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SMLBHSZH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFUcfb008172;
	Tue, 23 Apr 2024 18:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8FSdutA6HQ01waSKg09MJfC3d8WsFrBvotb0kKVLdwc=;
 b=gx3M2PKksHVn1yC+WH5mXfhNEC5RnBf2xXfOXIQph7vVeWmOGfk9Sg4UtJBfLQ2XIKOm
 Mzp1jtuIM3Wg/qRrksZXGerE9jo4mz1KNQQ9fiYaSA4GPs0vuRJPzGHuUDRUEm6ISEaa
 LLxL4201f+4Nl0nCHIztmZkr9m4lFEqDSST4jFabdk0BstceGkXKwUDO7zcHc2iXiFuQ
 LM/NBSoo4md9PSGwvDvFPdyT8aSwukobNHOugnqYzSGLvEkL+V/n8cleKQ/18bgdJDrn
 0Li9xzmse8QA2QH6p80ud7BdBy1iNbPMsUX83XVbc7QLREmkK6m85fD0j8SmXvPRpIVG sQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbpkvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 18:02:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NHwAnX035548;
	Tue, 23 Apr 2024 18:02:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm457nh4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 18:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y25VFFlBA6hrUr01x2K9LFrRzMUYTmNaLx3j2lcXdJIYqNhX2APmBSGWfhdqHx33ACAJV+uwATK9F/OETSsAjctg/MU7Fm/X6Z8TYir2nksje0FKHG6NHszH/t14kD/tO6RDc3R5DLv5/nNOWyGs07ZH0sUhkwdwll+FmAye44KOKvNbA2h/f2uO9KoTMUyVS/pL8aSEq91xK4xq4hYwjevXft7D7B5QH8p5T/vL/JqO0B1PDPBeAvGkKSELmKyaKrCNH2Q25BiV359NrkjMNAMDi5CRiurYJoaQkKztDSfM1siJoSqrY39qQBIdp2sT3XvoWcwM54w7IeizwqUv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FSdutA6HQ01waSKg09MJfC3d8WsFrBvotb0kKVLdwc=;
 b=Mem8Xi1g9qHv4M9eoyBrdxC99s1XN97Mhhst1glIx4KDgmi8ybgHUyi6hqEJFVl1ufXnR7n4BYqEreifPJkOXCgSM/SpXAvUmxOvBDfuU+vl9alqytbhTJVyq4lsooPRnrKhxgFYWhrgZCKyTUp4tKHzQCCSjkzfUb6cxxD4PAphtSUE4vuuRAzhB+mBbn0g2wOHwYIB8HIQ9TnGK/8Q2iTId2Tf/wBC3czA57rByL5neF85GiIMRl0UOpqTt1HRR6JWMXBX3SA70d2RWxqFplgrWmcEOKTzMbumTclClJUSyzT8UQbgzIXLL8iNYnAbtqG0RVB2vxe9DbV20qqXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FSdutA6HQ01waSKg09MJfC3d8WsFrBvotb0kKVLdwc=;
 b=SMLBHSZHI6IexKd3ZetoJen47cRC+HVfdT3REnv7BNl1FWGOovcIMi5qtKUzm9pd1GJIJssDAfIYeUilHHmnYBVuGlsAvin2sSGnH02gD8AEfgJ+ink1By7G+Yqsit5SI7h9oXIj7RhlXsfeBYl/RwtPNig8PFSIZP0x/0GN4fo=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB4917.namprd10.prod.outlook.com (2603:10b6:408:116::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Tue, 23 Apr
 2024 18:02:30 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::4c3a:47c2:806d:2e16]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::4c3a:47c2:806d:2e16%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 18:02:30 +0000
Message-ID: <86dff5d9-7053-4b4b-a1f5-ebcb3380e3d0@oracle.com>
Date: Tue, 23 Apr 2024 11:02:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: don't fail OP_SETCLIENTID when there are lots of
 clients.
To: Chuck Lever III <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>, Petr Vorel <pvorel@suse.cz>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <171382882695.7600.8486072164212452863@noble.neil.brown.name>
 <62B41B1D-0A9C-44B5-8EC3-962AC862EFB7@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <62B41B1D-0A9C-44B5-8EC3-962AC862EFB7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BN0PR10MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c9d99d-72ca-40a1-3a16-08dc63bf8aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZnZNNWluUyt5M1JYNytqb2dadktUL29UOEw0cW8rYkVZazlsWmhDcjd1S0Uv?=
 =?utf-8?B?K3FXRytaTWI0Wjh6T3FFS0Rac3ZOOStwd2pndHRnd0cvcmxtMzN1d1kvNmNh?=
 =?utf-8?B?ZVVLN0p1UVVEWkNRUWZxbkNsaUhraHZlcm9hUDZ5OUV3SnBGOHNUakNRekha?=
 =?utf-8?B?WXZUOWNObmhVOVJwaUVzZEk0Q281UmhRVEVoMkJCdkozUW5WTExQZHJVQlRz?=
 =?utf-8?B?OGk1bFduYzVsbVROWSszL0p2VHZjanJ1QndjQlY3VXJvN2RqMnJjY2xDSTQ5?=
 =?utf-8?B?bFpITHVSUk5CUjQyZzExdUZrV25hRUZNL2x6czlPZVZDS2hXUEFKNFRDcnh5?=
 =?utf-8?B?K0Yya0dBZXdKbitnU1NFcU1NUEVqSlVDUUlLckM5b2ljRWpDRDVHcFRxTXc4?=
 =?utf-8?B?eGpGNVR2TUtDSk9qditLOTZOUnhHd2xsSmpCYThiMStJQzU0N2FMUVdrZFk2?=
 =?utf-8?B?WlBuUUFVdVp6OTNVelE1cmhSYjdQN1BaMVQ3UHRuWTMrK09GNWpUemZSU0xI?=
 =?utf-8?B?ODd0Ui9zRFNsR0hSQ3pLZXZIc3NVNitFc2lJNWRzKzliTHZ1Y3ZSQ1A3RTEz?=
 =?utf-8?B?djdXdFdBMGc0aEV5V0lpVld5eEFTSmo4Zit5YlFibERsekFjQlBPYnNqYjlr?=
 =?utf-8?B?V1M1WTNBY2NRei91YXJBZTBSTkhFbXRwcE1tNS9VZkkvQklpOHlFVlFWS3Rr?=
 =?utf-8?B?VHZ6ei81dW5hRDM5d1lTdzQ1TjI3bzNSTUdiMi9GMFY5Y0hyMXhxTGlwZFFI?=
 =?utf-8?B?SXhGcHhsUndnd0RiSEgyc2xYdHFDdWRBYk1jUkRZZzVpbkpFN0lyMkt0RFQv?=
 =?utf-8?B?NUQ3enQvcjVLdGJ5Wnc0eTZGTDRKbmNuVHlDR04yNlFlZG0xZitGbjNsdGI3?=
 =?utf-8?B?WUx6eUg1Z01Bc3JCOFByN2ttQVppM0twUmFLdUF2RlpWdy9zbEY5OGJYbTJG?=
 =?utf-8?B?RlNLdnVvOHRXNFJicmR6d3FCSk8vcDBWelhRa2d6TkRyNjdDcFkvV1phSjE4?=
 =?utf-8?B?UG80NzFiN1REcWJ3QWxMTU5hc2JnclRLeTNiTE5kNDhOYnZYT1Z0V2ZrTDVk?=
 =?utf-8?B?VDF6Y2xCelRRRUtuZnVWQU9YUmhVenZBelU0WmdJWjh0UWt1ZisrNEt1cmp0?=
 =?utf-8?B?UmNMWis4M0NqdE56Q0UzVEJ3ZGIwWHlmT2hJLzUxditQL2tHMWZPbFpudEFm?=
 =?utf-8?B?SXNyOWx1aE13ZUU4ZFVjd2tUQ2JtaXNLcGYwQlUyNCtEVmVzeW05MWpuZU03?=
 =?utf-8?B?VXkySjFyTEVXZnFsbTRobVpLelNjZW9pelZMUDVDa2dmRit2N0lLL3ZHb3kz?=
 =?utf-8?B?eFpBQUFiamtibnZ2SzIrd3J3ektDTmxtMVZiN0RqRzN1OG9reVhUOWRrSjZy?=
 =?utf-8?B?TnlMZzFLTEdsUTFhQktHOCtLTnQ0Snd3dEJadHphSTJpWHVqekk3VXB5eGZS?=
 =?utf-8?B?L3ZIazFZMWcxNkxkbSs1YmNaaXo4QW5EbjM5WEhrdnhPandPTE9heGQrUkVz?=
 =?utf-8?B?dnFmeXY5UjBUVU91bE1NK2kvU0VpRWkza1RvUDJ0VEN3NnlPM0pNcXlFNzRI?=
 =?utf-8?B?VmxaY1F3OGdpS0hFUyttb1phczFKYlJ6Z2hzREpEYjUvTFhDeFJjaWx1eW9y?=
 =?utf-8?B?bFo2cFRrMXJtNDA5WnU2aXJ4NjBNL2JBRVNlMkNWMGt2VjJQdTBpNDhnaVNH?=
 =?utf-8?B?cUJ2UFVWTERiSjE4UDlxTWRQTzBwVm4wVVB4VW42UTBRdVVGV3h6K3dRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFQ1T2FlUmN3UWc5OGF2aXNmS3BybUZwaU9GN2hMMlN5N3BDZ1g4cXhsZ3R2?=
 =?utf-8?B?cEFoSnFLQ25qbXhVV2RrVnA1eXJwWmhtKzJkSklyb3JQZjFiNzZvVXcwRkZT?=
 =?utf-8?B?R3dsR1BPVm02am83RjZQemwweW1DZEFDZDFLSnQzVHZUVE9YMUJmTVlQNWd0?=
 =?utf-8?B?dVFQdzd1MFltWXBrWUtkNUUyUnhIMExQT3ZMWENvY0RYMEtEZVR3WFpSR0dG?=
 =?utf-8?B?TDNHVmdyc09WZnlVZTR1czg1NmRad0xGVFN3bVBHMU9UdldIUmFGV3cyVU9Z?=
 =?utf-8?B?TjZwQVhNbGhzbWIyREVucFhtaDBXdHQxeVo5SVpRckxHZ1FBR3U0enZxZC9z?=
 =?utf-8?B?THpGTkt5eFJFQUtiTFQxQklhWGt6N1QxUStIQ2ZlQmR0UGY0MnBFV3YxTnd5?=
 =?utf-8?B?Y29zZ0NTTGViMVk5Sy9pZGMvRFdTUjBMdkRsSXFoeE80M3ZsY3ozM1hpMWZ2?=
 =?utf-8?B?bGNBT3pKVGZnS1R5L3ZDU20yN2Npd2hDcG0rcmlkQzFuNlMwclNDZ0pXbURW?=
 =?utf-8?B?NVB1NTRTcEpGOWJrSXRoNGVJNm1IRy90cWpucFBqS3NsU1RkWUdGbS9LM21o?=
 =?utf-8?B?UlhHMzR4blpYV2pYeEZ4dFhnQXp6bnRFSm5rQ1Q0WHVOMkVKL2dXV3dENDU1?=
 =?utf-8?B?NUVUMnZGdTJNVjcwdmdZUm9aM2d5TW1xOE1zWGJ3dUJ2TFhMTzBMVzFxNW5u?=
 =?utf-8?B?VkFFR0FyMGQxMFNzMk5QenZDb3ZpRXd0b0NsUlBPNTBBaFNEQWt5bXR5bkdM?=
 =?utf-8?B?ZG4zaU1CWjFMWGsvdHdMMDVXbjdiZmg0T3ZjbjFHc1IwMVVDb1hiTFN3UjNW?=
 =?utf-8?B?ZHdNWC9yZUc0YVp4ZXRySXlVWEw2ZnNQRmVRV2ZOb3ZvenQxREhBRE91N2V2?=
 =?utf-8?B?WnVlZTMwWi9JS1J1UUNyQlZwcHJ6eWd1eFk3Q29xb0c0UFl0aXJPS3dTb2FV?=
 =?utf-8?B?QWxRanEzS2FjM2dTbC94ZG5LRURvZlRVZ0JEUkdRM1AxRjZ4dlp1bXBiSUNI?=
 =?utf-8?B?dGF0OXJtN3pNR3R6S250OTBLSm9IT3JiYW1EejZYVVFveU5VaGhHYnVZZG1I?=
 =?utf-8?B?aURyNy83emFGR0tKWEU2VmFwVmNtNEhvZ1NXTjg1b0pXcTBVMHN1R0xRVUU1?=
 =?utf-8?B?cFBwbVY1V2hzU2NOZ0w1M3pGdWdTbHpkRnFHNnNVTmwvb3o5dHBVKyszQnZv?=
 =?utf-8?B?NjNGekNHNzV3VCthVUVTV3QySUx1OFhLWkJCVk9FenpuaCtFaEUxcnYrQkh6?=
 =?utf-8?B?K0djeGNYK250d2ovU3UzNXpXSE1Sb3FKdzNrbHA1eTQxZ3RUUXVuSnd5SDQ3?=
 =?utf-8?B?bW9HWG00V0tXVVZiQ2EvNi9tQ1lrNEdIQ20yTXdscGhkTFNaZXEwZmhzUHZR?=
 =?utf-8?B?WDBqNE92a3ZWUm5pNGtHL2ZqL3cvdTYzb21TOWNCbFVTSVhzakdVREc0Tmli?=
 =?utf-8?B?aEdFOWtSR083RTA5Z1lFOHhJd0F2aitPQ3pKd0FDazVWeHVvQ1lHQ29ON2p1?=
 =?utf-8?B?RmxPc0tWREVHdFhMNWNNcGo0VzhOcjZjeHB1dGltMGZxUEFRaU1DYm1ZZjc0?=
 =?utf-8?B?WTJFMzNmN3NoQmtYdGUyUEJHZmorWWZlY0NHZzdNM2hTRm5uUnBFTTFvOWhG?=
 =?utf-8?B?QVozTWdaR2NsbXYrcm8rVThwMUtQS2s3QkN0ZExCU3FCT0pUMHN4eGY3b1Fh?=
 =?utf-8?B?Q1I2eTBabytRQytCY1Q0MnFsV1RtQy9nRGhNRlQyQThsYzBWWkd2U2JtWS9z?=
 =?utf-8?B?YS80VkpRWlVoSlRKdStsZzYwQUVyV1d1TzY3RUh6T3hyQzdBNFVuVnAvVVlM?=
 =?utf-8?B?UllkSWVheDVKYnQyZ2h5VkVtVlhndTFkQW0reEhJejFxSVdMOHVJZ0U3Ym9o?=
 =?utf-8?B?Vitkd3llenVwNFZTRWJBZ2ljT2hONmhWWjZLTG9scGpzMSt5bER1cElUL1Jo?=
 =?utf-8?B?T2dWQmEyVVhCUWhOVURlMlBrRVBwZ1N6ZzlQVE00a1R5R3ZmaXF4bEx1d3hm?=
 =?utf-8?B?RVZ1bHI2UUNDa01DM1B6RXUxU3Vzb0NwNDBaWEZFRWlHRiszaHFkMVJGSW1S?=
 =?utf-8?B?Z1FsaGcrdTBQK2NQWEd1MnAxOU00M3pmcFQwNUxGenNPRHMwQXNmdjgvVGJY?=
 =?utf-8?Q?e1xPpI+cwAQxNz9awf16oSN+I?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Gt1NQ6JgcL03uTcu7G+nSxc1UY1a/+6pkzUkFqBiLZFAGjBf3IBxJj5sc6UhX4Sy0RRMCP18vBp31KYSDqddo/lIIUHeZWTJfVI++soGJc+/Qz1wyIXS9TMG9mh/tXsiPXPxyUPzedp+NKboI37h4dEklGSG1db9JJ/MD4luZ2QvHy+OxgFUpTMTtWzqLYImlKWTWgdDV5Itg1GYnh2KugCBLLEje+sh9GA0hl+y+pNTTvbZY+48RQh5z6T0oZekbveggaOs19pHuWN2wW3YZIRI0H1cUVOL/r56GRXB6e55fdQkjFCQpVRKX03ho4JCtzNsHMOYQsERJ+7O59ZiMoOtLoGGUSYBKd5tflwrNodKeNsTVLhColPdh35kGuEHdxDdpEDYN/u0j2vruNENeJ7uUDKWSgh26hQYoQdTqSs/ZpdWc2xwLjb07yoS9HqVPTEHkupXjRfjMb76bqYPwprcFnwyejnxlGNj3uOvZU+DV2xAJgTFlu8BMFRKf99hk0v+ISbG/l3a58Lq5V2bR/FeO14dYjSDN0zzdW3C0wH0QQsiorri6s6R1dSsjVrIOjWqoX0Fd+KkFPPB2rZ8OWxL+D7TEe+h+SheGi5IlTU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c9d99d-72ca-40a1-3a16-08dc63bf8aca
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 18:02:29.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVNV2YTzXrTir+sW7wUhUai4YhYHHSruCqv3p+QhNwqNasx6Wj2bHEdYGIAExU+A1ijYvonBB6qlV1yr+epMqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_15,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230041
X-Proofpoint-GUID: t5uAsX-yPWVriZOFJkee8xVKmkI6OG-1
X-Proofpoint-ORIG-GUID: t5uAsX-yPWVriZOFJkee8xVKmkI6OG-1


On 4/23/24 6:15 AM, Chuck Lever III wrote:
>> On Apr 22, 2024, at 7:34 PM, NeilBrown <neilb@suse.de> wrote:
>>
>> ﻿On Mon, 22 Apr 2024, Chuck Lever wrote:
>>>> On Mon, Apr 22, 2024 at 12:09:19PM +1000, NeilBrown wrote:
>>>> The calculation of how many clients the nfs server can manage is only an
>>>> heuristic.  Triggering the laundromat to clean up old clients when we
>>>> have more than the heuristic limit is valid, but refusing to create new
>>>> clients is not.  Client creation should only fail if there really isn't
>>>> enough memory available.
>>>>
>>>> This is not known to have caused a problem is production use, but
>>>> testing of lots of clients reports an error and it is not clear that
>>>> this error is justified.
>>> It is justified, see 4271c2c08875 ("NFSD: limit the number of v4
>>> clients to 1024 per 1GB of system memory"). In cases like these,
>>> the recourse is to add more memory to the test system.
>> Does each client really need 1MB?
>> Obviously we don't want all memory to be used by client state....
>>
>>> However, that commit claims that the client is told to retry; I
>>> don't expect client creation to fail outright. Can you describe the
>>> failure mode you see?
>> The failure mode is repeated client retries that never succeed.  I think
>> an outright failure would be preferable - it would be more clear than
>> memory must be added.
>>
>> The server has N active clients and M courtesy clients.
>> Triggering reclaim when N+M exceeds a limit and M>0 makes sense.
>> A hard failure (NFS4ERR_RESOURCE) when N exceeds a limit makes sense.
>> A soft failure (NFS4ERR_DELAY) while reclaim is running makes sense.
>>
>> I don't think a retry while N exceeds the limit makes sense.
> It’s not optimal, I agree.
>
> NFSD has to limit the total number of active and courtesy
> clients, because otherwise it would be subject to an easy
> (d)DoS attack, which Dai demonstrated to me before I
> accepted his patch. A malicious actor or broken clients
> can continue to create leases on the server until it stops
> responding.
>
> I think failing outright would accomplish the mitigation
> as well as delaying does, but delaying once or twice
> gives some slack that allows a mount attempt to succeed
> eventually even when the server temporarily exceeds the
> maximum client count.
>
> Also IMO there could be a rate-limited pr_warn on the
> server that fires to indicate when a low-memory situation
> has been reached.
>
> The problem with NFS4ERR_RESOURCE, however, is that
> NFSv4.1 and newer do not have that status code. All
> versions of NFS have DELAY/JUKEBOX.
>
> I recognize that you are tweaking only SETCLIENTID here,
> but I think behavior should be consistent for all minor
> versions of NFSv4.
>
>
>> Do we have a count of active vs courtesy clients?
> Dai can correct me if I’m wrong, but I believe NFSD
> maintains a count of both.

NFSD maintains both counts for active clients, nfs4_client_count,
and courtesy clients, nfsd_courtesy_clients. However the 'real'
active client count is 'nfs4_client_count - nfsd_courtesy_clients).
   

>
> But only the active leases really matter, becase
> courtesy clients can be dropped as memory becomes tight.

Yes, when the NFSD shrinker is activated it calls courtesy_client_reaper
to remove courtesy clients.

-Dai

> Dropping an active lease would be somewhat more
> catastrophic.
>
>
> —
> Chuck Lever

