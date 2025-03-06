Return-Path: <linux-nfs+bounces-10515-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A4DA553A0
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 18:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7725C7AA92E
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 17:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB772212D69;
	Thu,  6 Mar 2025 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PL4Av7Jv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TJ3YdYsD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C825B671
	for <linux-nfs@vger.kernel.org>; Thu,  6 Mar 2025 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283688; cv=fail; b=QdLn6HvyrLMxor/eSoWASO8Vp1/ZU4P9mvXuwXglTzyipswAGJAQM7ctnkv2C83+nRi2czJ7eLqhOcIX/UweDHB3dm41ye73oNvS5j8HBxLIHJ4dfBWWIDQAfg5FLrevqQANFchLZ2585dH236u5nTToFD8NcaSDa186fgDC5LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283688; c=relaxed/simple;
	bh=ArC0zJA0uT6aYyh8oIHBijrz9heYq3bT8IasB6YSsmI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pldIiu0hBpy1p+gpw6xSTXI1qyZgBFz/phnSg4zjwxZoKlnEDSThQY9S2fUbnBCWetHBaB8B4YIu/VUeGcLgkyOLBqcnSzg0ZYo982HtykjN0X5czQ3OgZsIouAgGI/TIjnl6FVxh4g9T2J2h1fMY3BDHKYjKf5AQEnJubAipCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PL4Av7Jv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TJ3YdYsD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526Fi4ek008113;
	Thu, 6 Mar 2025 17:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=E4dP4OlF+9+bRL8yq7A2y/Z6ymK5iPydE2y5wLTa7z0=; b=
	PL4Av7Jv736wFGdKfwscBDdfWhEIJO+O8VKpa9uhkf6n2Uy534FqsDXoCuABUGhf
	5226a2IulhTWrF5ojzs63cfXxV6gnyWrowi/hA6i6RE12dajARCQRr95AHPNBmQH
	2KsAjJQXgXZ8OexRsumRqBk6i/GInVp1nATqY+U87fKnfdxRPe/6OiZjin1ckieb
	kHqJR/I7t0U5N02UXbVRjdi1x+gRhYKASyv04BIdLjp7+POwf/exeHrZ1odhfql7
	X/1hCDD+2VrP8DyMtQuIeL25nuYdlho5dnVUEnInE3oPHxiWg26MNfz3CzuZGMY0
	di6+y7kTKR911KavdQn4Qg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wthg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 17:54:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526HerqU039769;
	Thu, 6 Mar 2025 17:54:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpd5hfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 17:54:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3CMGARCu5ysh5HHUcfcnNxN7OPKnRLJSLQUUZioAGkW8ZXntCydYB8vSZI5S87mu1/cna6h38sGMIwIy3d8DAbXpduXO66GSmN8+YSEO0lASwF8KqGJ/KqU90gOLTH2rU2vW3oeTrgzmkOKWtKsnkm2oeuIpskQp4qiqtxG9vjtTdJU3dCoXhLViLn7JqDKlfo78xHaDGHJCwfGFwJaP9IaLr/i5tTc8KzJinDXT58wjKae4YHh4Hm7RBDe4uH8VcOY5WEr2bA/XLcXTsndgjiKesreYHE4oAFBUKbFuCHd2HfexlFbFhWqevW87g83qGJNHPVYh7/q3c+yJMzlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4dP4OlF+9+bRL8yq7A2y/Z6ymK5iPydE2y5wLTa7z0=;
 b=cM4n7dwz96RRBPZcWNKlcWZR2Dsn+MHL6kPcf3rvde0aVeItY7l6CXrU4q6TF1rHOMT2PIjsC3RPjezSt/bSaPV8qs7Ind8eK8JiZTUKqwvLYeTYDbOawqUxidRQssOTtREE2BEZsbR+EAuhIpS3ozXLROrPVrIKqKojkjAZU2zwhRmNn5gR7Y/XvJvU0IW08bD09u6Dvycd8GG3PPWK3qMHSVg6pBWbcrRV3ESCn0UT7ndvIyVGxElWmBVxIO3+LZ4D5Ny5Gyp48JQr2b8S6UN3YyMy1B+eCBRUjbMfN/ENRYLZ6QyV2Hrb3TYULi1vbG3l736nyeub3WI1uUv/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4dP4OlF+9+bRL8yq7A2y/Z6ymK5iPydE2y5wLTa7z0=;
 b=TJ3YdYsDRMJlQT8Q8/idj6DzN8fxyQ19UWUHYL9nyvFv5/9vVW29M6Akd00laUddJVzV9BtOfZXuSJvbD4sqUKDE56NA2lQR11CnBofdY0mgBDcP2iBpjxkCJ09p03jtbK3epZxICPypHwNpYEJ9Up+6Ru2JD/SrAQcIb7qXR6k=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH7PR10MB6675.namprd10.prod.outlook.com (2603:10b6:510:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 17:54:18 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 17:54:18 +0000
Message-ID: <ea457e7d-9275-4a67-bc56-d87dc0e70cf5@oracle.com>
Date: Thu, 6 Mar 2025 09:54:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] NFSD: allow client to use write delegation stateid
 for READ
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
 <1741120693-2517-3-git-send-email-dai.ngo@oracle.com>
 <22c1c21fde3a5b17851207664571341e3dcfc315.camel@kernel.org>
 <ac7d9408-c1fd-4f4b-88a3-162a9f3cf176@oracle.com>
 <24582f1bb0778852feea0e676b7db163019c1b4b.camel@kernel.org>
 <96135388-c965-45b0-8c81-03b680136757@oracle.com>
 <deb67458-fe9e-4303-b310-587b404c9d80@oracle.com>
 <30e405d15a33d2fd809a6e8daa8c5bc01e677b84.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <30e405d15a33d2fd809a6e8daa8c5bc01e677b84.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0126.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::11) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH7PR10MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f3fe59-ecb6-4fd0-55cb-08dd5cd7ea89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTFXSzl3bkZWVGYzMXhCeCtxekwzeFhlRmRYa244VlFmT3JnMmZEYTE0bzZv?=
 =?utf-8?B?V1V1SEQxeDNySHIwYjBrakU2RTcySFFLZ295S2V6VzNsakRuK0hYMU4xTExK?=
 =?utf-8?B?ZUNLdlRTekhBa01PUEgrSnkzemtNdFJCRlZ3d3ZjS2J1M1U3TVI2M3NVUExw?=
 =?utf-8?B?b3ZsZG1pMTRIVklNN1BjMjQwZkplWFhscXJMellHVUZ4S3FmT1c4eW1JWUhM?=
 =?utf-8?B?VVJTenRFaU5RbE1admxyNHpkcVVxR2lMQ3QwWlVGK2hJcTQ1SE5IcitSYkV5?=
 =?utf-8?B?QitRaFhqMDZ5cExmbGEyY1Q5empQekNhRkJGcy9Tdlg0eWMwYVE5NTdtTThu?=
 =?utf-8?B?ajJwdVE0NVdVNWQ4aTVtSE01K0U4QXJVLzhCaGJQcXVnaG5iSGNUcGdDM1Yy?=
 =?utf-8?B?aStUQ1dlcDFVbEsrNnZjVmM5bnBjWHdpci9BaHRtYm9CQWtEQjdlRVVIVUNp?=
 =?utf-8?B?dm5TbUdhcWJnd2Izc0tZb04wczFjTUlQaHNrZksvN0FWeDYxSVlaQnA5VlNv?=
 =?utf-8?B?RXhiQU1QREh6dVRodkxvcXcvcjljWXVGNW9TclhEakJUb0t5VTR6a0J1Y1NF?=
 =?utf-8?B?NDNPdFZwL2hHSURXSlFWSVZLWVhCalREUHlzVTh0RUhHSGF3am9JSU45YUZ1?=
 =?utf-8?B?ZWU1Rk1tY21ROEM2eXVWSTVrbHFPK0tVcmJsTHAxNllLZWtibTRZSXkzcHB0?=
 =?utf-8?B?Z3JJN2dzZ1E1ZGIzZHFySkhWNzhGVVhyQVVhUjNFUTdiOWpHem0vandkb3VG?=
 =?utf-8?B?UTkwZnNSZUQrRG0yaHAyZkNub0xiajZRYXRuTXkweDRMa1pIdzluUWxrMnB4?=
 =?utf-8?B?UnpwNzBsc2ZObSt1a29hQWVMTy9vWmFZekpVYWl5bWQzd3VNd21WRllCdklo?=
 =?utf-8?B?NVNFUlM5NzhwZUxRZnh6OVRJSW40aUlwZUpmb3Voc1ZraFl0d3B3QmNQS25F?=
 =?utf-8?B?bWNCT1lyQytldi9LK21qcDhWVnVHOHo2TVk3TFh5YkgwTXEyRGVJWndnS1Vz?=
 =?utf-8?B?elZ4am5teFNWbktVRHd5WEJub1N3UFF2Z0tXbG1FcmdKK1N1UWdEUHJiQUxv?=
 =?utf-8?B?aTVudjcwN1VzQ3ZtaFFHYmxrM0UvQ1pJUEVsUElBM3FxcHIvSzlmZWQ2T05a?=
 =?utf-8?B?Myt5UTlEeDl2UGhFK24rOW5rakFNSTF2aFVsbVVNRzVNdmw2YU5CYTdPd1Nz?=
 =?utf-8?B?R1dISGR5dmN6TUlCYmc3RjZjYldXbEV5dWtRd2xMell0cjJLS2xJQjdETU5Z?=
 =?utf-8?B?dU5GRWY2VFM4YUpKMWZrcy9kbmVrbEFrUWVUdDV5UklCQW1XZmRTRFAwY3I0?=
 =?utf-8?B?MGJLQ09sTmdNcFdYUkNyelN6SlNyTE43ZGY2dDFJR25aazFhdE1jMnNsNjVY?=
 =?utf-8?B?b2JBQzlEZk9lM1JYdks3K3dmQkU5TGMrRXgrR3g1YmZQNC9LaUlIV25UenY5?=
 =?utf-8?B?clNDY2R2Ny9rN1pYWW1Qb0w1VnBTUnRIT0pRcUk1MGlIdXY1RnlKcHVVVzVH?=
 =?utf-8?B?c29PVm1oYVRQdjBvWkgyemh3ayt1MzVKTUlCZVllSjVISWNudjNkakZJSFcv?=
 =?utf-8?B?bE5oNHpudXBtSlkySVNqeUtuYXRzTUUyZisrcWVwMXZqcTc1SlFZTGphMzR3?=
 =?utf-8?B?Z3AyK1hjcmVkSzg0K3o2NFh1NnBMejF2UzdBVlRaQk9XV2p1QlErZXRTK1pn?=
 =?utf-8?B?SnNHZi82UjdIanB2aVpFVmt1dG9vTmdFVjhSV2lpcXFFemlVTlVEcnVxblNU?=
 =?utf-8?B?eWZ6MnFrL0NFM3MrWlhwbk4wRjBydUxqNkZ2RVo4Z0JXcFpabzZTbXpJdWQv?=
 =?utf-8?B?TnBSRE1OajIwYWdRRGljRFRqWG83U2NjbFg3UVAyQ3Y4Y291QXhPUlU1Ylhl?=
 =?utf-8?Q?JhOv71LGCMr/Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW1iV1phY0VITVg4ZFY1MHZCaUl6YU9FcjhyUVY3Mmk5a3V1bUxGV0xRM2J4?=
 =?utf-8?B?TmpkSmtyOUdaWmFnVTVkSEdUbksvRUN5ZWhYV2UyRE5jUzRkbHV0bUhaOTYy?=
 =?utf-8?B?SGl0V1ZpTzRpaHdGTHNiZlhrMTduRVFkVm9oZlNsdFEvR2MzWmVYVkthSHZv?=
 =?utf-8?B?QlY3NVZpMHpUa29PRHhDUmFRSWZudUNMUW9VUm1xdTEyYUdaRkdZdVpqV3lJ?=
 =?utf-8?B?bGFiUGhYRW9ock1pamtvWDhDakx3dng4YlllUk8zRTNPU2RncW1mNjdnaDda?=
 =?utf-8?B?UFV3WUNvRzhVWTBmT2tyTXJDQ3N4emZNTXNGbmVoRnN5eEZSbGJWRjhMdnJK?=
 =?utf-8?B?RS85Y1F4RGJrL2M5My9sYUJCK2ozNGhKcUFTcy8xckFOU2hCVHlVMlBhT2tQ?=
 =?utf-8?B?ek9ubWNoMnVwMGJEN1lFMDFWSXFGNkloZ2pKWnl3OXFwb0V4ZkxyOFBVQTJW?=
 =?utf-8?B?SWkzbWJUeTE5QmF2VHYwOEtQRGdIZUxaUGxOQldNMmt3VVhMWjBiMXpaWkwx?=
 =?utf-8?B?WEQyTkNXUURFdStaYlp1QXMxMTFJVUU1Y2xkcll5V3F0dDZkbG9pdUVIVkhH?=
 =?utf-8?B?SXBGOWtOcnpDcVRGdGdKRGJJek1SdlQ3Z1lZK2EwYWJIWTBzRTFhS3pJcmNL?=
 =?utf-8?B?Y0l5L1pZT2p1MTFIQlVPUEpBS1ZjY2pDVCt1d2Vqc0d5S2JDbGh0eGNZTXVm?=
 =?utf-8?B?QWNIQ2w3b3FWOWNPaTdJcnVOemdoZmJqbFRvWHFjbnNSWmc5b2IrQlBGRGdT?=
 =?utf-8?B?aUFWNU9YV0duR3FpVHNPbnlxcnpIZUFNcFlvMmlkWWR2WUZRM2FRZ2hKNU1M?=
 =?utf-8?B?b0tJNVVhVzU1QWRXVVgrNjI1Z01pUXluTnRoNGdMUVVkY1c0T1d0MWJvZDJY?=
 =?utf-8?B?ZDM0L00wOGdSbDlqcGN5NysxV0Npb3lIcTE4eGlUTTFTaG1lQXU5YVZjWUJw?=
 =?utf-8?B?c0prSnRxaWRrMjFjNXpMQ0EveFFPdjkyOERxRldSUENHQU00dTdqb1UycG41?=
 =?utf-8?B?ajk5ZkxmcEZNUytqZFFFNEZsMkVBdENUTTRBM2dqbXdGK1MzQyt1YkpzSWln?=
 =?utf-8?B?V2NjN21DNnlNVVZBaldnOXVBdVJDK1ZVZG5NbVFpVE0xODBmUXNmVDRxVVoz?=
 =?utf-8?B?YWVzNUc3MGdWSTU1ZnFBTE82VmwxbHI5YlQzQ1NjRTBZYmZwdU5FOE5TQWxC?=
 =?utf-8?B?QTB3ZUphOVViS0Rjcjl1QU44b25oVXpSUDQvOXo2OWFLOEtMTzMyK2lXTWNN?=
 =?utf-8?B?RUdaakFBTFFIYlVHbmUrZGhoc0lmazdrYjYrcjUyMU9jVVNDZXljTGRiQ3Yx?=
 =?utf-8?B?dmVXVWQyUFhqV0J5dEgvWWx3WjlQWDJjU2tDL1o0UVBqNTFMZXJ6UHh2VWYw?=
 =?utf-8?B?ZnF0bFNCQ2F0aVlFUS81MjJoS0Q3MUZxYVVVaTBjMkJzU2tYT2tKV2x3Mm43?=
 =?utf-8?B?NVhmRUN1VTZ0akxxR2FHVUlFdkFUQ3NuWUNEVms3QUxFZ1UrTUF0emJ6MlFF?=
 =?utf-8?B?SmlJUHo1cDVnTjRueHByU2l4WEdaNXA1YmwvT25ETUorMWI2eENucmNNdE1m?=
 =?utf-8?B?M0RFcHlyWkdUNW4rVUtkOEwybmFjcXdmaHFZUEF2SllsRm9kdC9EelpZbm5N?=
 =?utf-8?B?bm1FbVdFN3dUTTErY0l2VHRoMktxRkFwc21ydysrM2NyUlZqRHNSWTczM01I?=
 =?utf-8?B?N1JBaEFJYzZIcVMxUytIVkc0ZTNTbEJuamhEb0JlV0QrZVhtaWU2WFBTWHdE?=
 =?utf-8?B?UlNTTjBJK1ZiMjl3NkdNbm9sNUxrc25uMGl1VDYwMzcxa2t1SXZvc0pmY2c3?=
 =?utf-8?B?Z0N6SmRCcm9ETkR3eW1YcWRGZm1vS1QrKytudHdhK0d0b3lpTGR5SG5PalJk?=
 =?utf-8?B?djdRa3NDYUZSTVcwYjE4SUhlc04vMDFyUEp2MHZ1ZkRYZlovMXY2em1Kbi9T?=
 =?utf-8?B?VkFpd1BEU05hd25XNnExTXZSUWtMWm1TQUR3R1owV2xxaEQrQll2S0tPSmRU?=
 =?utf-8?B?STdFSjV1RWFjVERFM1ZRdGIvQlNjdmRyS0xYUmw4RHlSWWFRYUFEZzFoZ0w2?=
 =?utf-8?B?emthUHJxMWJjaWtBbVRWVjlYSmZxS2UydndWNWxHd3Z1U2p0c3MzR3psdDdT?=
 =?utf-8?Q?mcXpDbFj5/USvE4HsiKPwGevS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s4kqLar29CuEW+CWgxeqxOPmjKw0y+jV+4gEAqy3n1sZcmC/38r1Y/yXIQvhiJs8YyVJr0CfXVDGuh2A8bcNITI624IWo21ys+HuNBG+YCa5zH2Zq7Ou02UURhVheuYEdLaNfsu7SDpIUFm8S7rgWNzz8khXQMcY+nunwF8XSQeb+joATlBILBM3JX16pD3Gh+DXJ2Srsy31lgnRYndo+8dgaxmvG87S3akFLC3RJqxWyQmHy/3OFuO++WqEBC6Aeq+VQYLYUgJa2Ma7sBo9KbktEGU/6yOlbF9LtzgzYD8wfou0E3HS8M241cpZSFt5NJm3FmP5PBVMHxwyUR1s5nknod8XXvIEJxSTD5T9plxj0m3gX1+QDW2vs6O7l0c3+IK4hj3OPU6LtlXXL/MEffya0V4Y1XDFMGhui4yguB0NnA3IunVG9Y3mcy7aYFowr0/eW+B6Qu4nlbGXIuDWKgnKM1U0LKerLPEZagrGFKvzNiMLJ5VDRi9TFzG046jSU6YP3qhLUKx5rWC0tQfZfIQc9UypfghaI3FMR4bf/suAQs1wTf979LeHZ+GSdrdTgGWyScd07HchVp+fiDb3i6ro9XifZHhhqTjt5r4/2vU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f3fe59-ecb6-4fd0-55cb-08dd5cd7ea89
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:54:18.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brChwXR+YMMy7A8Y5zNgfO2ygEwZ4whqfKW6fXwHeF8P2J83ArU76G7+kjCEGqoxeCtETEatoHRjBAE1z+WWBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_06,2025-03-06_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060137
X-Proofpoint-ORIG-GUID: 4U6_URqdHhJpdSSLdEfGLaQt_qFy_LPO
X-Proofpoint-GUID: 4U6_URqdHhJpdSSLdEfGLaQt_qFy_LPO


On 3/6/25 3:52 AM, Jeff Layton wrote:
> On Wed, 2025-03-05 at 12:59 -0800, Dai Ngo wrote:
>> On 3/5/25 12:47 PM, Dai Ngo wrote:
>>> On 3/5/25 8:08 AM, Jeff Layton wrote:
>>>> On Wed, 2025-03-05 at 09:46 -0500, Chuck Lever wrote:
>>>>> On 3/5/25 9:34 AM, Jeff Layton wrote:
>>>>>> On Tue, 2025-03-04 at 12:38 -0800, Dai Ngo wrote:
>>>>>>> Allow READ using write delegation stateid granted on OPENs with
>>>>>>> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>>>>>>> implementation may unavoidably do (e.g., due to buffer cache
>>>>>>> constraints).
>>>>>>>
>>>>>>> For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
>>>>>>> a new nfsd_file and a struct file are allocated to use for reads.
>>>>>>> The nfsd_file is freed when the file is closed by release_all_access.
>>>>>>>
>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>> ---
>>>>>>>    fs/nfsd/nfs4state.c | 44
>>>>>>> ++++++++++++++++++++++++++++++++++++--------
>>>>>>>    1 file changed, 36 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>>> index b533225e57cf..35018af4e7fb 100644
>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>> @@ -6126,6 +6126,34 @@ nfs4_delegation_stat(struct nfs4_delegation
>>>>>>> *dp, struct svc_fh *currentfh,
>>>>>>>        return rc == 0;
>>>>>>>    }
>>>>>>>    +/*
>>>>>>> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on
>>>>>>> OPEN
>>>>>>> + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
>>>>>>> + * struct file to be used for read with delegation stateid.
>>>>>>> + *
>>>>>>> + */
>>>>>>> +static bool
>>>>>>> +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct
>>>>>>> nfsd4_open *open,
>>>>>>> +                  struct svc_fh *fh, struct nfs4_ol_stateid *stp)
>>>>>>> +{
>>>>>>> +    struct nfs4_file *fp;
>>>>>>> +    struct nfsd_file *nf = NULL;
>>>>>>> +
>>>>>>> +    if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>>>>>>> +            NFS4_SHARE_ACCESS_WRITE) {
>>>>>>> +        if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ,
>>>>>>> NULL, &nf))
>>>>>>> +            return (false);
>>>>>>> +        fp = stp->st_stid.sc_file;
>>>>>>> +        spin_lock(&fp->fi_lock);
>>>>>>> +        __nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>>>>>>> +        set_access(NFS4_SHARE_ACCESS_READ, stp);
>>>> The only other (minor) issue is that this might be problematic vs.
>>>> DENY_READ modes:
>>>>
>>>> Suppose someone opens the file SHARE_ACCESS_WRITE and gets back a r/w
>>>> delegation. Then someone else tries to open the file
>>>> SHARE_ACCESS_READ|SHARE_DENY_READ. That should succeed, AFAICT, but I
>>>> think with this patch that would fail because we check the deny mode
>>>> before doing the open (and revoking the delegation).
>>>>
>>>> It'd be good to test and see if that's the case.
>>> Yes, you're correct. The 2nd OPEN fails due to the read access set
>>> to the file in nfsd4_add_rdaccess_to_wrdeleg().
>>>
>>> I think the deny mode is used only by SMB and not Linux client, not
>>> sure though. What should we do about this, any thought?
> Deny modes are a Windows/DOS thing, but they are part of the NFSv4 spec
> too. Linux doesn't have a userland interface that allows you to set
> them, and they aren't plumbed through the VFS layer, so you can still
> do an open locally on the box, even if a deny mode is set. I _think_
> BSD might also have support at the VFS layer for share/deny locking but
> I don't know for sure.
>
>> Without this patch, nfsd does not hand out the write delegation and don't
>> set the read access so the 2nd OPEN would work. But is that the correct
>> behavior because the open stateid of the 1st OPEN is allowed to do read?
>>
> That's a good question.
>
> The main reason the server might allow reads on an O_WRONLY open is
> because the client may need to do a RMW cycle if it's doing page-
> aligned buffered I/Os. The client really shouldn't allow userland to do
> an O_WRONLY open and start issuing read() calls on it, however. So,
> from that standpoint I think the original behavior of knfsd does
> conform to the spec.
>
> To fix this the right way, we probably need to make the implicit
> O_WRONLY -> O_RDRW upgrade for a delegation take some sort of "shadow"
> reference. IOW, we need to be able to use the O_RDONLY file internally
> and put its reference when the file is closed, but we don't want to
> count that reference toward share/deny mode enforcement.

The fix to support deny mode turns out to be simple. When we upgrade
the write delegation from WRONLY to RDWR, don't set the read access in
st_access_bmap, don't need it. The nfsd always allow file opened with
write to do read anyway, this is done in access_permit_read().

-Dai

>   
>
>>>>
>>>>>>> +        fp = stp->st_stid.sc_file;
>>>>>>> +        fp->fi_fds[O_RDONLY] = nf;
>>>>>>> +        spin_unlock(&fp->fi_lock);
>>>>>>> +    }
>>>>>>> +    return (true);
>>>>>> no need for parenthesis here ^^^
>>> Fixed.
>>>
>>>>>>> +}
>>>>>>> +
>>>>>>>    /*
>>>>>>>     * The Linux NFS server does not offer write delegations to NFSv4.0
>>>>>>>     * clients in order to avoid conflicts between write delegations
>>>>>>> and
>>>>>>> @@ -6151,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation
>>>>>>> *dp, struct svc_fh *currentfh,
>>>>>>>     * open or lock state.
>>>>>>>     */
>>>>>>>    static void
>>>>>>> -nfs4_open_delegation(struct nfsd4_open *open, struct
>>>>>>> nfs4_ol_stateid *stp,
>>>>>>> -             struct svc_fh *currentfh)
>>>>>>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open
>>>>>>> *open,
>>>>>>> +             struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
>>>>>>> +             struct svc_fh *fh)
>>>>>>>    {
>>>>>>>        bool deleg_ts = open->op_deleg_want &
>>>>>>> OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
>>>>>>>        struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>>>>>>> @@ -6197,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open
>>>>>>> *open, struct nfs4_ol_stateid *stp,
>>>>>>>        memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid,
>>>>>>> sizeof(dp->dl_stid.sc_stateid));
>>>>>>>          if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>>>>> -        if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>>>>> +        if ((!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh,
>>>>>>> stp)) ||
>>>>>> extra set of parens above too ^^^
>>> Fixed.
>>>
>>>>>>> + !nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>>>>>                nfs4_put_stid(&dp->dl_stid);
>>>>>>>                destroy_delegation(dp);
>>>>>>>                goto out_no_deleg;
>>>>>>> @@ -6353,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp,
>>>>>>> struct svc_fh *current_fh, struct nf
>>>>>>>        * Attempt to hand out a delegation. No error return, because
>>>>>>> the
>>>>>>>        * OPEN succeeds even if we fail.
>>>>>>>        */
>>>>>>> -    nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
>>>>>>> +    nfs4_open_delegation(rqstp, open, stp,
>>>>>>> +        &resp->cstate.current_fh, current_fh);
>>>>>>>          /*
>>>>>>>         * If there is an existing open stateid, it must be updated and
>>>>>>> @@ -7098,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>>>>>>>          switch (s->sc_type) {
>>>>>>>        case SC_TYPE_DELEG:
>>>>>>> -        spin_lock(&s->sc_file->fi_lock);
>>>>>>> -        ret = nfsd_file_get(s->sc_file->fi_deleg_file);
>>>>>>> -        spin_unlock(&s->sc_file->fi_lock);
>>>>>>> -        break;
>>>>>>>        case SC_TYPE_OPEN:
>>>>>>>        case SC_TYPE_LOCK:
>>>>>>>            if (flags & RD_STATE)
>>>>>>> @@ -7277,6 +7304,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst
>>>>>>> *rqstp,
>>>>>>>            status = find_cpntf_state(nn, stateid, &s);
>>>>>>>        if (status)
>>>>>>>            return status;
>>>>>>> +
>>>>>>>        status = nfsd4_stid_check_stateid_generation(stateid, s,
>>>>>>>                nfsd4_has_session(cstate));
>>>>>>>        if (status)
>>>>>> Patch itself looks good though, so with the nits fixed up, you can
>>>>>> add:
>>>>>>
>>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>>> Dai, I can fix the parentheses in my tree, no need for a v5.
>>> Thanks Chuck, I will fold these patches into one to avoid potential
>>> bisect issue before sending out v5.
>>>
>>> -Dai
>>>
>>>>>

