Return-Path: <linux-nfs+bounces-11660-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCAAAB2B87
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 23:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8DE1666D0
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 21:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51423261591;
	Sun, 11 May 2025 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VdD57G6I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VbYHUD+0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5662609F4
	for <linux-nfs@vger.kernel.org>; Sun, 11 May 2025 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746998032; cv=fail; b=uRVlpx8x5cYQN3YqgMnhzpFEUR9i1hy42yRKwvbsG8nc+bZhp9B+CR9/IceYk798V8kWmBiZX4xTvGV0ZRgnAT8Xwl0EhlN8Hai1OQ+FEsG994ex2LB7EOa99JQ85I3jneVuG1COLTClIqF/oFr3bczqSJH1ygCZF4o+A/DpOd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746998032; c=relaxed/simple;
	bh=CRI78MCoxmj9pHjPwReNWBEEbDUyddFqd1G1cxT+Vhg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GuJe7Oclig3xFokotdRTZc/BHKCILJAjqCQHN/gEN6a5Bp0a1Bc39eeUQ1O8J+wdC+ScED1QL7mh0PJRCFzEXO5UY9O9vNLwvIB21gdy+TcRPJqL1gJE4majWoJ3xtrXVUJZml1JXZjTqOHr7omyK7JXI2ZIoMGlKXEkaGGsujk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VdD57G6I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VbYHUD+0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BJmBJZ008229;
	Sun, 11 May 2025 21:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=izkHJj6Iok9834QRCTnsRS+bORa/fv1Tie5b9/jKVXU=; b=
	VdD57G6IxnRF3ywEGHuxE94WPqznYyK8wTcj/8k4lnT+4Qb5Mqd0rF+IigajyVLe
	hOzz7gdakTZMiP9waW5Ka05G3t1TJtMkGPFRcsymS5oYmTF5hSOhag5f9VDfRUws
	wxP7TpKSZV2iNCejEn3jGhWLJy+24mB0wWqmm1FZ9qeXv0tJvJn8ZBcukBRgssez
	ooN7+XfmCSXpFDdVsYHnA1VC19My+NmuC1XroHbt5kyIafiO9JaAD2/Ruc/vhwtW
	IuntITK+IgMnBqM586KSv+W7fbbkqoqWN47NmOv2TGr44RbNS8/emzCSufwxra+O
	gJfgbjCqtGYGOBADZBb9Yw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1jnhc0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 May 2025 21:13:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54BEimXW002503;
	Sun, 11 May 2025 21:13:34 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010002.outbound.protection.outlook.com [40.93.11.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46jwx2c0ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 May 2025 21:13:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1IQLyTfUteAaTxk2AgTTt1dDn0Nq66WLI37UqGqnWoX9juu64h/NdDqNuWF+JlnLcUWiiJ0SNM6cqD2eluNrWykFkZZpLhH8DUlNAzj1IM+xceQzaOxIX2ok3Af0N2E6LaWTm/AHTNl1cLDneglCKPTvaUL+9aICYZ52cxJwEquLd+B02Rxv/GfjZTZE/EYhUvTX1Ulrj8aZ2dUi5lVXrLyD/lsS66TIobWbrOIILPvCMy0l3Vzb45EbBSSKJSKh3Rt6xVFNf+sg0xk9huqxRChCvAD5WDXIfHUZMKhFwFSfozXfrdv7llMG3usclk6GHID8/BMFrxIgsktkLwSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izkHJj6Iok9834QRCTnsRS+bORa/fv1Tie5b9/jKVXU=;
 b=FuN1X24bN60VinLagzisp6gZETT4I9Q1ECzdMe7CcVgmNqgONwjWjUtmNmNd3WLmkTSAtBCxzax0pGkv+sSY2EHsLy2XbXViSmk4ElzwItvc6zvdmtzlvCfbuWVEQ40Gd+cDJfXZcE/wpztCC3sRCiBdIx/nu3OwkxmUr2/+JaT/5yB4Hik/gTX8ge1kid+Zm6e9YxJ81diiSw3ZsjU8aOtOhMRXiG58vBF8bXMDoUtPs9+CNVbKahckyR0RxejLj0KzbVeVxxDu9zDi5pKurYEpCjNlFDkxHnIraLAQSVrLcmlcRPG6SXkyWb/JGp1HgelGnuLve0p83n3YJwdVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izkHJj6Iok9834QRCTnsRS+bORa/fv1Tie5b9/jKVXU=;
 b=VbYHUD+0hQ+PhT4i8al3o0W2p9Fg8Ea1ViO7nmaQW3xxmm+vbswnWFPmZaF0SXUR142AVmCVUUCHjyfjGhEgTCrFjRppxsM79VsCf5fKmWpdSlGijOvdKLzbUSyu0n8Sesk0/g7zidefViIe9DEm0PJFac+PTeXQLuiymnzu5Zw=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by BL3PR10MB6210.namprd10.prod.outlook.com (2603:10b6:208:3be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sun, 11 May
 2025 21:13:32 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8722.024; Sun, 11 May 2025
 21:13:32 +0000
Message-ID: <6330ee2e-eb2a-430d-afe5-1972d2da1bfd@oracle.com>
Date: Sun, 11 May 2025 14:13:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/1] NFSD: Offer write delegation for OPEN with
 OPEN4_SHARE_ACCESS_WRITE
From: Dai Ngo <dai.ngo@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1741289493-15305-1-git-send-email-dai.ngo@oracle.com>
 <1741289493-15305-2-git-send-email-dai.ngo@oracle.com>
 <ac9d076fb33f7ad5d536ac593a2eb6afd09015b0.camel@kernel.org>
 <2f2babf7-7d70-4c81-995a-1a671590b08f@oracle.com>
Content-Language: en-US
In-Reply-To: <2f2babf7-7d70-4c81-995a-1a671590b08f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0052.namprd08.prod.outlook.com
 (2603:10b6:a03:117::29) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|BL3PR10MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 62aad65f-7f01-4c0e-5b3d-08dd90d0aee7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NndBeGdUQkp6bnJ0c3BldlhaZmRuenZ0OTluQ1dIQkU3eDlUNXd0Q01wYU9P?=
 =?utf-8?B?bC94TE9IVmtMNFF1Yk1VbEJ5aU14TVQ2aVBibGlYWVRSMXNJVEowQUZWTnRU?=
 =?utf-8?B?cSt5NHE3WllqLzVaaUtqNlRmOWVjTmVhQXpabHdpYWQvMC81bEdCWGk0eUZp?=
 =?utf-8?B?dXozM1FNYWp2M0VWc1NsYzRoT2ozcWlOemU3V0ZJeExxbEg0eXhoRlRkeUxL?=
 =?utf-8?B?WEtXcGxlQXJkMVp4QSs0Y1FidFBvWUlJdGdpdy9UVzJlclFoVEdab2JzNXdx?=
 =?utf-8?B?Qm9JZHJUK0NuMUNreFQzdzlHQ2pnZ3l3VDBFVWFHem1iUWhpMWpQcnJYc1p2?=
 =?utf-8?B?NTJ6YXo5OTcweDZIanNpKzRkc0dXYmpPTTZZUFdlVnNUbGZqVCtGTUtlNU5o?=
 =?utf-8?B?dU9rc1J3SGdkVHBEQlVwNmFNOUFzbkFqVUxKdjdoZ3RmZlZDaVNabFZ0SmFC?=
 =?utf-8?B?WTZMOE10dWg4c0JmYkJraVRPRDJVNmVJeHNCMW81Z1JpOFNXTksvRlU5b1da?=
 =?utf-8?B?TVRnYnRBbExlY0R3dG4rS3J1RGYzeFRRTDN0TmlGQ3JRNG5tZTVFRC8vSU9p?=
 =?utf-8?B?ekt6dVRrRkFoUEtvN3hYaDF6TWFGOE4zQW9Pa3ptVmk3UE9sWnJLdjFJWkVV?=
 =?utf-8?B?dVFxZmw3SWVTc3M2WDk0S21kSnNKeTBxcU1tSiszUjdybGI1MUNiOGFTSlNY?=
 =?utf-8?B?TFlYSlR1VEZzYk5keFlXdHJnczV5LzlLcUpORDQrcEV5RUF3OFhoRm5tMUx5?=
 =?utf-8?B?bll1YmFyTzlGT3ZOVHRNbUlEcndsTEFEUFhTYWhmMG5uRGlJNjJiWDhzaTRQ?=
 =?utf-8?B?T1FHdFlGK2pZNjhOcTMyNXFQS0tJbkFjb1FZbHJZaUFRNC90V2M3K0E4Wi8x?=
 =?utf-8?B?c1NJc0dWN0hTNEhGMlRUbVJoRDNGSkpTRjhxaEVScFJDOURoZlBGaXlSY1k2?=
 =?utf-8?B?T1QzZnNMUnBhQk1JN0dOWWwydUhBWGwwSUpFOTB4NUVHRUY2blJoMWlKZTUr?=
 =?utf-8?B?TmJLd1o1eHFUYVptV1luWWN5Yks5RWVhb29ZSVNaTVlQeVpsdTEyNlpYL2hL?=
 =?utf-8?B?SXY0SlFwYW1FSVNNeU9qeUNpNFhaVWdWaGI3NUVoYzJMZXA1R29aS0hXbG05?=
 =?utf-8?B?STYvWlQzRmM3VFdxem45QUVVS1c2Wm5IM0xwU2RwZXpwaXNkMU5ZSXRBMzhD?=
 =?utf-8?B?bC9yY3g4amI3alVxQjdYRFRqWnNnNFk5YXhDdkpjeUdSaXFkWExDQ2pTQll6?=
 =?utf-8?B?QkdNa1I2VmJvdmFGKzZzVVlybUdveG1hR0tlRHVhWHlFU29KeWkrU1k5S1ZB?=
 =?utf-8?B?dlo3dC8xY09ORWMxbmF2TGdQR2dNbmpta3ZVamVqVTlpRmcvNGx5ZEJycUVD?=
 =?utf-8?B?NEd3cTF1bzRoV0wrRHhYQU5mcFNObVkzTGFnNzZRQjFRNDNFcTV0eHhTdkEr?=
 =?utf-8?B?YU1zcUFYU1NsS0VqZHB2Q3p1Q01aMzBRbEhIVHR1RUFpTzRKYTF3cG1pczJ3?=
 =?utf-8?B?Mm1zanZwY3ptRGlKdEQrLzNSYlpnb0JCazJxTHpWaElxWS9kYklwMXZSQnlO?=
 =?utf-8?B?SDYyekJ2MTBBTHlBQTMxamZlZGhEU1YrK3JLS0E5VUZpOUNIVytlK3BIQzg4?=
 =?utf-8?B?NllhUHdURjJTNHlRSFVzeTNINTNqMzhYQ1N6cEV3U0t1K0VCLytzWVBtdHMz?=
 =?utf-8?B?bVk2cENJRm8yQjRMNE52OGxrcVZBTXhUUVd5WUFEYVRremFPRnVoaXduazNx?=
 =?utf-8?B?ajdibWdWL2hhY2Z3eVIzcUVRYWcxaEFUU0xyWHprcG5HdlNDR3V1NVpPQlpi?=
 =?utf-8?B?NG5rT2Q0OXdEKzZvRDg3R0hLc3cwNUx6Um5hSHFmeGtMTm9lR3A4UTdCUzBH?=
 =?utf-8?B?VGhVZkN6Q1ZEZjFFZEdqcnVKMU04L25xbW1TVVYwemRMNklCbSswSWMwa1NG?=
 =?utf-8?Q?/4eppM+eSY8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ekFoaDg1ZlR0ZXJId1c0SUtBbk9qbzQwZSt5Qm5IcHpJODBvSm5UTitwZVFB?=
 =?utf-8?B?dFpwMnF2WWg2cmMva1JST3hCMEhmWXMydyswVFJVck5tYUpvbmJ3bTlEYnJG?=
 =?utf-8?B?bXJNeTI3Qk1HOEtBN1ptTUhGZE0yN0JJenlMRXdqMmlVMFRXTGpGSEFIZHNQ?=
 =?utf-8?B?NXIxZjZnMmRQbGZKZ08rcGt2bG1zeWI4a3B1OUZYall3YnNkY3lvclI2R2ZS?=
 =?utf-8?B?UStXV003b1U3Qk1rbkpScTN1WXRZQTI3Y1poQ2JUUzRxc3FpRFdIR0Z1VmVs?=
 =?utf-8?B?NWNLaUdUVW1wZzhnYWFBOXNrcDFlYUx4SWVkSGxtVkNMVzlTemkvSHNaRHJW?=
 =?utf-8?B?a3daa2VWK2NHY2Y3N2NiSDZseGp1T1RCN29pY01kRmRKT2VKRGlaZ2Rya0Vz?=
 =?utf-8?B?QzRzRWVEaTdOOHhJYzR6R1FBb1JISTdsT1RybDJRdUxrZktURTZWV0RsbWds?=
 =?utf-8?B?M3M3cnpWYUcwaW9LKzhRWnZNeG05azZBdDl5RHRKQlZyVkdFQzJpdlNBZkdG?=
 =?utf-8?B?UFhiaGFXRk5BL3hDK2Z6citqcUJEZWNZcFBCWE5OYXpSS2hHU2Z6UVRpSkY1?=
 =?utf-8?B?VFJtN1ptZ0Q4K2NPZDdyNDZialdWMEgyMzM0TmVJdWRUa0NYdXhkMzhKaThx?=
 =?utf-8?B?V1VPZUtLZld4b0s1ZFRnaEgrYzAyZ0pzSHpoNUlzNWhXSmZFcUFXZjFaM25r?=
 =?utf-8?B?c2hXZFVwcnZOaXk5aERuNHoyaHBZanA2TE9SbFhqdXhFY2t1SWwrMUdRNHBW?=
 =?utf-8?B?ZXQ0ZldFL1U4OXhJaWRjcXJ0U0JCZE5JVENEV3E4RHlYeDNxaXdoUXI4UWNT?=
 =?utf-8?B?RGNzVFBIWmRZMC9vM1grMlZ1bTJ6NVZUdEswS2tYb20wM1E1cFlQakREcW0w?=
 =?utf-8?B?eVVjcWt5Vzg4Q0tFQ1BRTjl0ZzEwOFQ4N09tQTg1VmJ6dXYybkVOWHBiZW90?=
 =?utf-8?B?N0FBc3pKTnVRaTFkOG5NcTFGSzhra0lPbU9kT2VhdGJYL2paUnlxS0sxY0Yz?=
 =?utf-8?B?cGhOdkNnbWpyZUdOc0RhN1BNMy9FYzJoaXJOc2xQbVVadVlWT0Z6aUtHNU9j?=
 =?utf-8?B?Y25YNUdnWHArTjgwcDg2S0VuNHJzY1lqcnR4MkRvenFNTGlRSmJnUW5BaWdw?=
 =?utf-8?B?L2o3b2lJTkFmb2xuelFzSXc0V3YzdGMwWThZMEdzeDJjeWRYUnl5Szd0aXF0?=
 =?utf-8?B?OGdzL2MrNEJxd090UmxidFZlaktLanVVK29NbkRhNnVGTGpwSnNWKzVPdlY4?=
 =?utf-8?B?bkJ6YXhSKzlVZjh1bS9rMmRYV1Uwbk1qSXJzRVJWUEYzYXV1UllnRGw2MUtG?=
 =?utf-8?B?bndoa3pPTDlDQ3FncXN4U1BSYWJZWVFnRTl0c01JRHdiZWQ1d2lEN2tsREpN?=
 =?utf-8?B?b3g4NmNTazZhK1pvdE1YQVNMbzU5N1hVODNPYkErT2l1YzdUM29hYTA3RjlT?=
 =?utf-8?B?N2V2Yzc2UGtiRG5YRjRqSi9zNUpWMUtkOHk0ekdweFZRV3lDQzJraU9NT2xk?=
 =?utf-8?B?TEVieWlKN2grUW1PdEVLckR6K3Y5czRUVDQyZUFDelBlUVhtNlJCdzFOUG5i?=
 =?utf-8?B?OU5BVzlFZTQ3Vkp6VXBCV1J5ODg2NlVHUU0zelhlUFJuUFplRUw3SU13Qkp3?=
 =?utf-8?B?Nk5yc0NZNUUrOEdEdlkxUmVEWVhUYXR1ZFZGb0pvb215Q2xMMmNPdjN1YW9Q?=
 =?utf-8?B?T0IzTmlMa04wUEFPRnNPUjFIaXorMGtrVEpQMHRENGFUL2tZTml3R1Q1Z3Aw?=
 =?utf-8?B?ZXlYeTNNVldxNHR2YkVHUm1OOG5oSlpRc2gwcUF3TFJzVjYzcSsvUjRoOHdu?=
 =?utf-8?B?RDkrTm91eWkraTBPOVdFNlNURjRZeE1MbDZhb3Boa3g4UG9ldzloV1NGVmpE?=
 =?utf-8?B?NDAwYUVaOEhLQ1VWUWliV3hzQTdIdjN3Zm5IS2FpMFo2cks2TWt4dnIrakxx?=
 =?utf-8?B?YWxRWTJmNzFFcitWQy80T2ZJSlhTZmJxeFJHcUhCbitHRWJaMVM1Sy9QdEFy?=
 =?utf-8?B?UEp3WGlrU3RHTXhUZmlCd2tTNTd0Y1JMMHR5bnQ2UXZMTjVHT0k5V2FjYVRa?=
 =?utf-8?B?R2NIS1dlVTV5OE9qV0VQZzFYWHAwb2t1K2cyMDZ1MENXV2t3bDIvV0kwUUdR?=
 =?utf-8?Q?c4lqvdbftEQ68la/vPh7aslZN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ejpeHGeRJHi/3TRMS8KX1MHWNogVnUkxd16Csr/mjAIMxF8xm88JU30QJ8fHibChigUi+O3+Mx1oYsnDK8O7FWd+J3Wc03lGZqpsBV2gLAOd9k7HP7EQ7oAT3LJ7JqF1VjYXA0ubd+m73j0Pi/y+yFgV4WHL2BwReYKLTrPGMKdNroJe/bgbp8+9tT9A4xPYh6SxHuU5pI3OeJZcr1Yp6wZQiP5tLvgJPA04hIrDZWoV2SUg+jG0/myKXGaR+lSKn7z+GmOfGdTF3RdGPiWbv/iukIO67GNYTS2W/qdHa8+OzVmY8YeAI5hdN/9cpYKLa2abln+bmJ78CHrQTGPJy480+RTwXF/Exp6FZMNSb/pRRioQgDsnROBBoeJtxkhJuUZMsFP5BlE36BB7cCaOvwPXANbP5h0kiiejA2x9NuE3HRTwUkb2b4Q/XiBZ7205xMsjnCdX4Vi8zS0A7mom65nSkDuZ6+A21DHIvGsdDqRFIlm1YT6givvDbrr05x06BOXF/EW2XD+0rsfcTriI1vxsYyH5fZyBXtcuepjp6KmazoVMrKSXyuAGHr16Errf0OaX9OQg8AJGSy2Xs4kD7xJ/4ZxA6p+hbKhqt+R7XAQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62aad65f-7f01-4c0e-5b3d-08dd90d0aee7
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 21:13:31.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNPlsiT9FTGMjTSPX4fm83DzOctemVMsgLT0JkLEhpR6muSzyBr2Pgk0946iGejriaG7suBfWswdH5gFUasgDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_08,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505110226
X-Proofpoint-GUID: Eo6g2cVr3UAAci3FlAwPCPXk2CABCCDJ
X-Authority-Analysis: v=2.4 cv=PeH/hjhd c=1 sm=1 tr=0 ts=682112ff b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=JpgRudga4ATnGNqd3ccA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTExMDIyNSBTYWx0ZWRfX0HkyMyY8qugp Au4FNAqwKi81JCPTntECwMAoZohUdd0U5zKytGJjA0ChwQUiwe4TbbuaKmfYACdwCC7UlKxngba 1Qls9XCQ/7YhANAdK1Z9QEbDxztIZ9NJBD6r6+wH9Q+xxXIDltBRt3In4vNai/j89pg3DZFTTqj
 o7kPuHeyBxdnLYNuKvpOxL6utNa/0d2RsFLbIrF76F32ElvoCxzDxS8L0nBqYqBPE5IoyLzFHgc ZCo259khr/ooATiOQQ2qUbghkKPf0SqJnZS1kKzndjhN7d6/aKuhjiNtuSgng+FXrxj6cqW9I34 hDfYM6t2Kw4T6BIw7vdFL0KUyCghBrk/iVyck1lh5Q35iD0o67w2qG3mzum1TDlQ4A9e1N0u9yo
 cVrW0J18F84tAOOj+4VFFML5aQrAZWZcks5W71aRmZdXDDooLxdeA8CVy2j5pfE2s1GakbGA
X-Proofpoint-ORIG-GUID: Eo6g2cVr3UAAci3FlAwPCPXk2CABCCDJ


On 5/10/25 12:23 PM, Dai Ngo wrote:
>
> On 5/9/25 12:32 PM, Jeff Layton wrote:
>> On Thu, 2025-03-06 at 11:31 -0800, Dai Ngo wrote:
>>> RFC8881, section 9.1.2 says:
>>>
>>>    "In the case of READ, the server may perform the corresponding
>>>     check on the access mode, or it may choose to allow READ for
>>>     OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>>>     implementation may unavoidably do reads (e.g., due to buffer cache
>>>     constraints)."
>>>
>>> and in section 10.4.1:
>>>     "Similarly, when closing a file opened for 
>>> OPEN4_SHARE_ACCESS_WRITE/
>>>     OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
>>>     is in effect"
>>>
>>> This patch allow READ using write delegation stateid granted on OPENs
>>> with OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>>> implementation may unavoidably do (e.g., due to buffer cache
>>> constraints).
>>>
>>> For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
>>> a new nfsd_file and a struct file are allocated to use for reads.
>>> The nfsd_file is freed when the file is closed by release_all_access.
>>>
>>> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>   fs/nfsd/nfs4state.c | 75 
>>> ++++++++++++++++++++++++++++-----------------
>>>   1 file changed, 47 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 0f97f2c62b3a..295415fda985 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -633,18 +633,6 @@ find_readable_file(struct nfs4_file *f)
>>>       return ret;
>>>   }
>>>   -static struct nfsd_file *
>>> -find_rw_file(struct nfs4_file *f)
>>> -{
>>> -    struct nfsd_file *ret;
>>> -
>>> -    spin_lock(&f->fi_lock);
>>> -    ret = nfsd_file_get(f->fi_fds[O_RDWR]);
>>> -    spin_unlock(&f->fi_lock);
>>> -
>>> -    return ret;
>>> -}
>>> -
>>>   struct nfsd_file *
>>>   find_any_file(struct nfs4_file *f)
>>>   {
>>> @@ -5987,14 +5975,19 @@ nfs4_set_delegation(struct nfsd4_open *open, 
>>> struct nfs4_ol_stateid *stp,
>>>        *  "An OPEN_DELEGATE_WRITE delegation allows the client to 
>>> handle,
>>>        *   on its own, all opens."
>>>        *
>>> -     * Furthermore the client can use a write delegation for most READ
>>> -     * operations as well, so we require a O_RDWR file here.
>>> +     * Furthermore, section 9.1.2 says:
>>> +     *
>>> +     *  "In the case of READ, the server may perform the corresponding
>>> +     *  check on the access mode, or it may choose to allow READ for
>>> +     *  OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>>> +     *  implementation may unavoidably do reads (e.g., due to buffer
>>> +     *  cache constraints)."
>>>        *
>>> -     * Offer a write delegation in the case of a BOTH open, and ensure
>>> -     * we get the O_RDWR descriptor.
>>> +     *  We choose to offer a write delegation for OPEN with the
>>> +     *  OPEN4_SHARE_ACCESS_WRITE access mode to accommodate such 
>>> clients.
>>>        */
>>> -    if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == 
>>> NFS4_SHARE_ACCESS_BOTH) {
>>> -        nf = find_rw_file(fp);
>>> +    if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>> +        nf = find_writeable_file(fp);
>>>           dl_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : 
>>> OPEN_DELEGATE_WRITE;
>>>       }
>>>   @@ -6116,7 +6109,7 @@ static bool
>>>   nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh 
>>> *currentfh,
>>>                struct kstat *stat)
>>>   {
>>> -    struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
>>> +    struct nfsd_file *nf = find_writeable_file(dp->dl_stid.sc_file);
>>>       struct path path;
>>>       int rc;
>>>   @@ -6134,6 +6127,33 @@ nfs4_delegation_stat(struct nfs4_delegation 
>>> *dp, struct svc_fh *currentfh,
>>>       return rc == 0;
>>>   }
>>>   +/*
>>> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on OPEN
>>> + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
>>> + * struct file to be used for read with delegation stateid.
>>> + *
>>> + */
>>> +static bool
>>> +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct 
>>> nfsd4_open *open,
>>> +                  struct svc_fh *fh, struct nfs4_ol_stateid *stp)
>>> +{
>>> +    struct nfs4_file *fp;
>>> +    struct nfsd_file *nf = NULL;
>>> +
>>> +    if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>>> +            NFS4_SHARE_ACCESS_WRITE) {
>>> +        if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ, 
>>> NULL, &nf))
>>> +            return (false);
>>> +        fp = stp->st_stid.sc_file;
>>> +        spin_lock(&fp->fi_lock);
>>> +        __nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>>> +        fp = stp->st_stid.sc_file;
>>> +        fp->fi_fds[O_RDONLY] = nf;
>>> +        spin_unlock(&fp->fi_lock);
>>> +    }
>>> +    return true;
>>> +}
>>> +
>>>   /*
>>>    * The Linux NFS server does not offer write delegations to NFSv4.0
>>>    * clients in order to avoid conflicts between write delegations and
>>> @@ -6159,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation 
>>> *dp, struct svc_fh *currentfh,
>>>    * open or lock state.
>>>    */
>>>   static void
>>> -nfs4_open_delegation(struct nfsd4_open *open, struct 
>>> nfs4_ol_stateid *stp,
>>> -             struct svc_fh *currentfh)
>>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
>>> +             struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
>>> +             struct svc_fh *fh)
>>>   {
>>>       bool deleg_ts = open->op_deleg_want & 
>>> OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
>>>       struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>>> @@ -6205,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open *open, 
>>> struct nfs4_ol_stateid *stp,
>>>       memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, 
>>> sizeof(dp->dl_stid.sc_stateid));
>>>         if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>> -        if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>> +        if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
>>> +                !nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>               nfs4_put_stid(&dp->dl_stid);
>>>               destroy_delegation(dp);
>>>               goto out_no_deleg;
>>> @@ -6361,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, 
>>> struct svc_fh *current_fh, struct nf
>>>       * Attempt to hand out a delegation. No error return, because the
>>>       * OPEN succeeds even if we fail.
>>>       */
>>> -    nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
>>> +    nfs4_open_delegation(rqstp, open, stp,
>>> +        &resp->cstate.current_fh, current_fh);
>>>         /*
>>>        * If there is an existing open stateid, it must be updated and
>>> @@ -7063,7 +7086,7 @@ nfsd4_lookup_stateid(struct 
>>> nfsd4_compound_state *cstate,
>>>           return_revoked = true;
>>>       if (typemask & SC_TYPE_DELEG)
>>>           /* Always allow REVOKED for DELEG so we can
>>> -         * retturn the appropriate error.
>>> +         * return the appropriate error.
>>>            */
>>>           statusmask |= SC_STATUS_REVOKED;
>>>   @@ -7106,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>>>         switch (s->sc_type) {
>>>       case SC_TYPE_DELEG:
>>> -        spin_lock(&s->sc_file->fi_lock);
>>> -        ret = nfsd_file_get(s->sc_file->fi_deleg_file);
>>> -        spin_unlock(&s->sc_file->fi_lock);
>>> -        break;
>>>       case SC_TYPE_OPEN:
>>>       case SC_TYPE_LOCK:
>>>           if (flags & RD_STATE)
>> I'm seeing a nfsd_file leak in chuck's nfsd-next tree and a bisect
>> landed on this patch. The reproducer is:
>>
>> 1/ set up an exported fs on a server (I used xfs, but it probably
>> doesn't matter).
>>
>> 2/ mount up the export on a client using v4.2
>>
>> 3/ Run this fio script in the directory:
>>
>> ----------------8<---------------------
>> [global]
>> name=fio-seq-write
>> filename=fio-seq-write
>> rw=write
>> bs=1M
>> direct=0
>> numjobs=1
>> time_based
>> runtime=60
>>
>> [file1]
>> size=50G
>> ioengine=io_uring
>> iodepth=16
>> ----------------8<---------------------
>>
>> When it completes, shut down the nfs server. You'll see warnings like
>> this:
>>
>>      BUG nfsd_file (Tainted: G    B   W          ): Objects remaining 
>> on __kmem_cache_shutdown()
>>
>> Dai, can you take a look?
>
> Will do,

I found the problem, the nfsd_file added for READ did not get freed when 
the delegation is returned.

Chuck, do you want me to resend the whole patch plus the fix or just the 
fix? I'd prefer just the fix to make it easy for review but it's up to you.

-Dai


