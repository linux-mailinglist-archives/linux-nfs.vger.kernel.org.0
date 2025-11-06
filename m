Return-Path: <linux-nfs+bounces-16149-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 662EEC3CF4B
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 18:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F62C352823
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 17:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7A234FF7F;
	Thu,  6 Nov 2025 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="noKehWL9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AjZc8MXG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5134EEF6
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451430; cv=fail; b=J2lcNRVegbZXq72cDBQtOZ3+tJVTE7jjTpfsRbg8RzuRxBDdV9p3bPqXT1NAxkT2A8Uf/KQb8kErKow26KYeL+gnfG9T0xNvjEGb5qJwMLdj9pIaWmI6M0q+b3JvPgBwRDZoXTmirwQgoB2ZEwSdXXTYrFLUSu6uGM2cP+diV0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451430; c=relaxed/simple;
	bh=Fje3gtnd7FCkQoKWqSDxCs3eAHkISsYG1Qht6bgFNtE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ds/9XZfceo5m8Ch1uE50HdzBoMTCk9PeeeVGLJctDSREYc51sGlCbrEjcBJLNTf4BPp2CO1E0z73jkBYBKQ0DbVNpqXGQUG7FSxEpotYwOAYCUxeStTcu/IyMvoyQoPjjWbuOlXky3ALYiT1kMLSB++nsUOmpOQ1Lp9lTEy1uuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=noKehWL9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AjZc8MXG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6HTuba010967;
	Thu, 6 Nov 2025 17:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Kr9J1sYsTaHigQZ7vaHVyvT5hyBp9k15kKrZKTE++uo=; b=
	noKehWL9VRnpPLeAH5aiKUCpANO0+rrUv26QJuU0e3fKNhHn3B/+ViZl3NZQG5WB
	jriMku3Ai39plD44TjtF6NhvGYfFZszLnOu+fFB/P1TgDNeyPxr5g+6C6NfZOEtx
	nfk5QDuKuvYE4lsBPYyyLWJ2zUTy8Wh7ohu0jIKytS6RLXvfwYbc1e8ozyKUdnFA
	j52aIHE8BAqFkoOB7L4GPunZHaJXJVbqp7vFXS1dNOSKbY0A+DOZOm6iz5N9TcaX
	Lu4BagGnSEAnOuq8mwaYOj3LbLS0vMztGAUggksbSrEwJbsHkrdbvMAHqkLWcvuR
	zdwSZt6viL7BM1Q6894vfQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a904b01j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 17:50:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6HKRjU014887;
	Thu, 6 Nov 2025 17:50:17 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncg472-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 17:50:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeCSrZQBQbYcBRBYUKFXjcKAf6nrx9yYeY1eWh93iLRSvIkfyZh7XUqhMZsy7IE2OI/ZscIMVQ0bdxJonadIKgA+rKJALoN5Tyq9GwvkV3GMZ6M4YBJ3SLwyfP+/fDdyLLnASNk8xmj/H14kRNwgC6gY9N+Ow980p5uN7MKGAZ+hPoR+FRgL8OSwBdT11VStGPVNexpHAN/N7dq9OJDPxR04T6Mn5yYrTHWUZ3AuYMul1SXsPzJY9Il492Nv7XcAXdHg0574S626cKnFYe4zq8upwlVF9JPfUFbx0yQwQCZHQryVclsZ6rySPr/KGMzYw9feODzJyfRRjKuzv884/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr9J1sYsTaHigQZ7vaHVyvT5hyBp9k15kKrZKTE++uo=;
 b=ugXORZWxCA4h0A27WaMeliGJHlXc1QRC08guwmDUw0en1HERmJJJmvmWDg90DDET0dvqFm2HHQ++3MVyoh3GpV9Kjz3TP50zem6c+iBGCvDsDP04VBbZFQPZjgLCylXb8BEnN9J8xQ4OteF32v+nn6hj8unExqOUq6lzKH649CYMZeksfjgOPchzK8DSsw0wWpy6jdbfvVm3/3MF5+xrlwAArden7UKdCC2Lle8a44iX0SiueuKmVt180mSMAXfhm+E+Jn8Qo3ruVrDVPfhaCaUKyxUCdtNvW/7/3b+Ww0q2WbkOtisTVRCEhu02R9BeJWSz9aOHq/wuS1vkKrw8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kr9J1sYsTaHigQZ7vaHVyvT5hyBp9k15kKrZKTE++uo=;
 b=AjZc8MXG9Vt5+ax1SwqccYiMENZKTicgin95lxuJNwQx6YJWzpLxQUkLgPJ7P395zfX4d0b2/nwZXKMqKEXNt9qd89S0bkCTvyNr45rLGKpK8lwn4XCfEq1MLKLf38LtxHuG9Ch0bfcCrvJhsKc9vlTerVdjOywzZ/LJpEx8CxY=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by BL3PR10MB6163.namprd10.prod.outlook.com (2603:10b6:208:3be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 17:50:14 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 17:50:14 +0000
Message-ID: <0c7a12e9-db9c-40f6-a94d-62c2a49fe892@oracle.com>
Date: Thu, 6 Nov 2025 09:50:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] NFSD: Fix server hang when there are multiple layout
 conflicts
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
References: <20251106164821.300872-1-dai.ngo@oracle.com>
 <20251106164821.300872-3-dai.ngo@oracle.com>
 <f6eb3ffb4dd88e63e27aedcdedf70fb6153defb5.camel@kernel.org>
 <f024e6a7-b6e3-46d4-8c5d-0f00f9700a09@oracle.com>
 <9922e28aaa5197493d1be8e4881ffad7ed726f84.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <9922e28aaa5197493d1be8e4881ffad7ed726f84.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:510:324::16) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|BL3PR10MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e49e91-e77d-4346-bc8a-08de1d5cf061
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aFpYTGZKS3FuTHBWTnJONWoralY2MW44VjVKb3krWmQzRGpvejVXWnBtS0Jj?=
 =?utf-8?B?NUJwNm5sTEkzdktUd21vN0pvYjNjVXpwWGVtdFBzTk9Ub2RlOWRLMlNBNStS?=
 =?utf-8?B?YmVlN3R3bVg4NU9JMnhtcU1STk1oelc3Y0NVQlZvbi9IUWE0RXBqTEFYd3lP?=
 =?utf-8?B?VFhVOU01cGgxc0M1aXg1d2grVzhWeWlpcGtjZlZGdlFsM0hDQlA3NVMwQ3Vi?=
 =?utf-8?B?d2FNRDk4RG1wQlBQM2dQd0hkRjhLLzhuU3pINmFhRjdDN3ZhYi9CNzR1VnNH?=
 =?utf-8?B?QjJ1bTljdXRjbmhDb0FMTWxhR09hT1Zzd3pZcXdBZUdKYlYzL2lSRnd2K1ly?=
 =?utf-8?B?UmtGZUtvK0ppbmYrbllCaUh3amJtcUtNMEVJSDJuWFV4K21ZYXJES245MVdi?=
 =?utf-8?B?NmdxWk1tUU0rcjBuRVNkaHB3SUVKdkdmL2FzUmUwVURCVUNQcGQvOTNiZVlv?=
 =?utf-8?B?djRrdjA1OHBNRzNhb1RkTGRHMHdsd2RJR2hZbTBReER3OWtKUnpRUVZRYnZw?=
 =?utf-8?B?NUUzK1lsWm5FWFh2MjdJeFZKcGdqdHl5M2MvRU5YeHhFbThZeTkxMDVjYVpq?=
 =?utf-8?B?NzVlN0ZxWGhtN2ZuWFN2SXl4QjViTzN6NVFvZ20xTzVqSWZYVitJTWlZUUNB?=
 =?utf-8?B?NWtSdXpvWW81UFNwMG5JZnBNVUFISnN3bUlWWFloWGt2QWI0Qkp0VmVXTytt?=
 =?utf-8?B?R0dFUzI2QmF6NnRuNTFkOFkyd3U5MlQ2ZllnVWtvR3UzTkVSWlNsNHBZQTl2?=
 =?utf-8?B?T3dJMDZOV2s1ZGRjSit5ek1YSlJIbnlUZTJiS1F0TmEwaGp4SXltaHlzNUdp?=
 =?utf-8?B?OGxUcG1GTisrRkpaWXJ1MFJaVEIyVVVOVFNmM212SndjdVpDbHNYeVlhOW9u?=
 =?utf-8?B?SnZvV2ZxRTk2VjArQ3JKUHpDRUVXOXVsRnZ6ZFNBZDU5aXJ0cWViSys0a2ZB?=
 =?utf-8?B?bncrTHY3cHAybUFBd1FQcnNQUnZ2cXZuU3hvV1lCK2dOa2lOcXpOZ2w4ZG9v?=
 =?utf-8?B?R3paTGUyaklCbDI3c1NPVnNGQ0pCNzZYTDVYbEppOG5oVHhES1hLWUFQekhQ?=
 =?utf-8?B?a2hwbUl1OUUrRWM5bWRqajV4Tzdac0YwNzlFTGNwUXNPZjZ3cE56R3NuMTVo?=
 =?utf-8?B?NFJDWEFmT2NBOE0vTmEzYTZLU3p4SkZSTlpZUEVvcm90TkRvcy9nbWlVTmZa?=
 =?utf-8?B?UWZCaFBqaVZoWHh1c2Y1eTA2RGV0UFFkdzc4OXlmOEZiR1FhcGxycVRvWThF?=
 =?utf-8?B?YU1ISWJ2WjNPWFZET1BTNTVXTWd4Wi9ueDVGb2NiTGUrRFpIZExNcFlNUzZP?=
 =?utf-8?B?NWFENkd2aVZ3MnRnU1pWa3ZTUmhkYXdJc2hTUW9yMTlwZVJHczY3bkpMdXVw?=
 =?utf-8?B?dXp3bWtPTnBEci92elRFazdUMjVnL05SVHBrMUVSankxSk4yNDRDa0E5TXdy?=
 =?utf-8?B?STFGV3I5S0NLb3J4eGhOUlpQSThBcjI5RUIxVmZ3N3hwWTFzUHlHSUVkQyt1?=
 =?utf-8?B?MC9vZjlsNFNXVkh5UzBIQW1lT09GWFMrY1JJUkFzK1F4cFc0bDNQd05NbjIx?=
 =?utf-8?B?YkJldFZjOS9LRlowU0JHM1JDVEhSRmxMd0s4aUt3a0hCMGlnU21VQ2NwVzFw?=
 =?utf-8?B?akQyaDBEb2l1MS9YT0tzU01JemtwYzI5am56d0JRdUhqTFBJRU5mUzFrRFR1?=
 =?utf-8?B?QnVvWWpkL3VIWC9NeTQraDQwMFEvUGFhNXZ4M0VaUXJzYTUwWEpKRGZvTVJT?=
 =?utf-8?B?MHJTb3ovaVdsTkV4ZFZWWEZvUzdCOEZCcUFvdGdKajlWVlVOTHI4aXdPdkxm?=
 =?utf-8?B?VEJuYUpMMm5mNFZKSW4vYUxlbXRUdWlRcUJEY2dxdnJZMHR1ekxiZituRHVY?=
 =?utf-8?B?ZjFFLzIzVmhEa2k1Y0ZkZWF4S0NEUllwUHVXb0hhNmFRNHNjbE9QMDR4M3lu?=
 =?utf-8?Q?Fj5Nr1bxuB7yzxvCsMDbzdCTuN4dt6ii?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y3dHeDdqYnJ6R1JKdzNMOTZpM2ZJZjE3dVJzVENSMEI2cXRzSWI5RTFsTitD?=
 =?utf-8?B?UEVLb25vZTFDazRhdHZFbjJESDN2cU1IWTZjdG9yVUowenVrblBncTczSzNk?=
 =?utf-8?B?K25oN0VibElmQUNEbTFuSkNIanN3OXlZVGhiOFhkeUdNaUtzUmV5eGpNV1JM?=
 =?utf-8?B?TFJnQktVZk9kT3ZuVmJCdytaOUdPWnpvSEhSVnZFcTJRWTBmdnU2R2ovcEhZ?=
 =?utf-8?B?cVo1THNvUEFVSWRHZmd0c2wwZWFtVjN5NktlUzVoYy9wdVRjcWZ4S01pMEEy?=
 =?utf-8?B?OTgrN1dPb3BCd1pZMFAyM1hSeTEwVzQxcUJqTjlMd0p2NlNzNUdvWXgwZ1RB?=
 =?utf-8?B?NmVsV0VtU0JNMDJzT2tveCtkZ2lMNjJjUmZyVlBuUDF0U0xoeVYwK3FvYlFi?=
 =?utf-8?B?ZVVnYzZUL0I3TzhJRVJScDBkREFmSC92NVBiTE1EUjVVWEN1amtZakR2VVJx?=
 =?utf-8?B?VnAzQUIxK0xrSitCOGRmZVRaeUlScGFSK2VQanZvRWxFMWo3WDBmK0FCS3dl?=
 =?utf-8?B?U2RreW54MjYrQ0NpQVJyUE9ibHNLTVcyTE9sMU93TGF1OTBLWnNQaGtrWVRW?=
 =?utf-8?B?WlNhTXBscFJWNHQ0Ris5MVlIMkErTVBoVTRtQ3NuQ0JoNGpDYTRoK1JnWW1O?=
 =?utf-8?B?YkZnREhnd3JDRHpKUGZiMFlVbFdmYmFpU29VclR6emxLTkZwaDc2K2RuQ1hj?=
 =?utf-8?B?OFdjOHNxMkxtUWhtTlA4U2U5dE9yTVR0T2hFSnZ2a01ZK2FSUS9ZVXdaKzkr?=
 =?utf-8?B?UVpkQUgveUJ6aHNGMnNtc3RuTVROWEgyL1JtUnNMcVlEV1pjY0NoQ0VPWllL?=
 =?utf-8?B?MTJEbWRoV205SUlLUHM1Vkl0UHBPaDR3QzFTbHNnb0dQelg5Y0xzWEx1OE95?=
 =?utf-8?B?cjJtbkJ6Z2QzMEEyZDlST3A5RFRiWENwQkpkMlQzVTRGTjZFR3BYbnR2SVhX?=
 =?utf-8?B?cTFNM25mZTM4amlNOWkzS056Q0VtMHFFTHo0VGZYcnNsMHdXbkRZMTgvaC9t?=
 =?utf-8?B?dmxXaWZab2szcHF0TnBiNVRTaGRyZGlRTk5ycFdoV1Q3eGg3ZnhERjlqSW81?=
 =?utf-8?B?alhzVkdqME1wandnU2k5UUY2dFY1M09wenBRUUpBcmF1WXlDaERVenYrUkdJ?=
 =?utf-8?B?d3I0L0xGdnltWUFWNFRoTXRPUTlpM3NZay80cEFFVlR0WTNqY09ndW9KSTFj?=
 =?utf-8?B?OGlxWXVYUTd1dThDMU55eVp3eXFYVkNyUXNPejBNZnFoTVBubmE0NGdFdnFx?=
 =?utf-8?B?S3ZuMVI4Z1l4MGowUS9OL3QxSTBvS3pTSUJOT3g1Y0d2MFQzbHpyeTd5Zi9X?=
 =?utf-8?B?RU8vbFNqa1NicFc3UUN0bXV5NE9ZNnVHblJ5a2ptbTBUdEVJNjAvMlRoL3kr?=
 =?utf-8?B?eFFtWW1pUDlBMldvdlI5NjFpNHVLK0Y3T3NQUW1MVzRlaEFwRlVDZUJoVFYv?=
 =?utf-8?B?aVZRQjdBcGlScThtY3NNdzI3b0EzbWI1TWhwVVNKK3lnUklFT211eVRMYnY3?=
 =?utf-8?B?T1AwRXY3MFQxN3pTY1hySEp5QW41WlZzUVZHaHBva0Uvc0NkalBwbElJcExQ?=
 =?utf-8?B?M2FkNUl2OHdud3hobFRaaFFJOTd4M2hjdFhSYXI2c00vTXVvYjRLMWduQjFH?=
 =?utf-8?B?cGtoaUdOKzJYRE9FMEovMVQwZHlpYWFnK1p5VEtCc0NxZTFJcUMxbDgxbUZ2?=
 =?utf-8?B?a1lGVXd0RWF3QTRJSUhoTHZCVVJjVlNHMHhRRGp5dGoxS2gvYUljWERuWW9R?=
 =?utf-8?B?dGpSeDYwbmpzbHdmQ1dIVnFlWVlCUWdRd25GYWdBN0pvYWJZUnB2Vmx6TXpw?=
 =?utf-8?B?MmlPcUhnSmc0ZUlFeGpzWnp4NXR2d01CY3VXM2JNY2FPUmliODFaMGNhTSto?=
 =?utf-8?B?M3lGbmNYYWpRa1BTbFlqUkVFK0h6RTBQenZ5VzZHdkt1RGVTckdidVdkNmJM?=
 =?utf-8?B?eDBZZ21NdDlDTVlsQ1V3dWN3TzZIbjIzL0NTbVBkcWxLU05IT0xFNUFSc2F0?=
 =?utf-8?B?ZXdvUlJ4V1hNbU9zbFpLanhzamY0UkxNWSswemJlRXZyRXV0em5LdWNhdkhi?=
 =?utf-8?B?Zm1VQ09MQTJIb2FhZm43cTVRUXZ0VEloR1cvemt0RmdjWlJRMFFMZW1GeFZm?=
 =?utf-8?Q?iF54q/oC/nacNIRtmh6eoONWI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1EuwhUPyolkI1cPhPpuSb+8btSEXRqsScGknhJ0HFlyagayBcBR2ueNiN3no5u0i3XIzI/sRB9kPNnhHAdLKKBCO9Vdh5MAQ963Yb0YqMXTpfN2B40IltVdKCvNrn1JZfSm/Y8N824XeCh2b39xGyc1xyosSVJ1iSkGUk/HDMFHET11FvF183KBAwMPjb6xEHAkslK92Wtn6JsOO26oRCp0HIGrW4fJ6HsZ4p7174wym9cNxx2GT6PolaF5wkxIj4+oAxGdUNt065u1rFWnfQVoEKU/Lf6zTzpqaclqbfjakNsEPjZWGzHjPDyXTrJXVP9DthU16KapZk2l0fXgiSa30i6y7fig9vT2lqDN70qkZ7Ug4cGpFmR+6AkDZ3PyxxojN1r6TdO5UYAZHtUHeTjQspSIdojIi0wUUdXFfe6JkA4c1Sb/ehYyY7/3DeLo1MuNlYFd7DAcugpenANi8TcmqUipxkgndJDzQt61mWgopYYa6ROJZDgjWwyKYWes200UoTacBBjDAv3Lts401qZCf2mggjrYD6G0ZMkQg7PtUB4xpLGcJme/TRP15dvN6oMRE70ri6uvLA+mO2s6Ny3Vg8D7iiRlUpAa37XiIZPA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e49e91-e77d-4346-bc8a-08de1d5cf061
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:50:14.2567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6AgHNdVlZUXZgPYs9/wfch9gQd4TTlPoR0LcJRKjcJ4zyxXOr3CJ8WgVmLtmPwPAZv46Y7zPPOUtab1BHLYCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060143
X-Authority-Analysis: v=2.4 cv=DPSCIiNb c=1 sm=1 tr=0 ts=690cdfda b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=RTMDOkok37rQ1t61wkkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WnbRBhgBdDURXMBNfhU3RtkXJP6J4T2q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDE0MSBTYWx0ZWRfXzQfOHUc9NxgM
 SKvxWd2ZU1artqySb1Py5h9dm6Md8bWWYjJLQTK2/b1MhECbTl9kwlpo5P3iszypjX4UtaJlcXF
 qxeJCG7basO8h4GfkdSMJ6xBmA1ZilF53MPkEnzBaOJS4oUll7+WDTZY8HA0pJGOlx9deGzLiX5
 8eEwSr0D64NNvo1cMIfiHnbE9bIr6puUJFLvGemXSLLYXKKdh+lypmut8w1CvNOnhuIDX06Hx61
 lS0b4e26tgX6byB+WhvOLVPTe5iCEial7dAu3E67Pgh56zvRRMy49J4BhRfk6SF5kyGgnxFMgXM
 cG475lMGznjIFIPytTz2d9lQfgcvXy8lIKZCMs1pQ/ySrq7cp+EZoN6BPDvyQYTRbvjclxZHEMM
 YZHFiqGm5BRC4Ju1JRobnryAxcLJlg==
X-Proofpoint-ORIG-GUID: WnbRBhgBdDURXMBNfhU3RtkXJP6J4T2q


On 11/6/25 9:36 AM, Jeff Layton wrote:
> On Thu, 2025-11-06 at 09:17 -0800, Dai Ngo wrote:
>> On 11/6/25 9:14 AM, Jeff Layton wrote:
>>> On Thu, 2025-11-06 at 08:47 -0800, Dai Ngo wrote:
>>>> When a layout conflict triggers a call to __break_lease, the function
>>>> nfsd4_layout_lm_break clears the fl_break_time timeout before sending
>>>> the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
>>>> its loop, waiting indefinitely for the conflicting file lease to be
>>>> released.
>>>>
>>>> If the number of lease conflicts matches the number of NFSD threads
>>>> (which defaults to 8), all available NFSD threads become occupied.
>>>> Consequently, there are no threads left to handle incoming requests
>>>> or callback replies, leading to a total hang of the NFS server.
>>>>
>>>> This issue is reliably reproducible by running the Git test suite
>>>> on a configuration using SCSI layout.
>>>>
>>>> This patch addresses the problem by using the break lease timeout
>>>> and ensures that the unresponsive client is fenced, preventing it from
>>>> accessing the data server directly.
>>>>
>>>> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/nfs4layouts.c | 25 +++++++++++++++++++++----
>>>>    1 file changed, 21 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>>>> index 683bd1130afe..b9b1eb32624c 100644
>>>> --- a/fs/nfsd/nfs4layouts.c
>>>> +++ b/fs/nfsd/nfs4layouts.c
>>>> @@ -747,11 +747,10 @@ static bool
>>>>    nfsd4_layout_lm_break(struct file_lease *fl)
>>>>    {
>>>>    	/*
>>>> -	 * We don't want the locks code to timeout the lease for us;
>>>> -	 * we'll remove it ourself if a layout isn't returned
>>>> -	 * in time:
>>>> +	 * Enforce break lease timeout to prevent starvation of
>>>> +	 * NFSD threads in __break_lease that causes server to
>>>> +	 * hang.
>>>>    	 */
>>>> -	fl->fl_break_time = 0;
>>> I guess this ends up with whatever the default fl_break_time is which
>>> is:
>>>
>>> 	jiffies + lease_break_time * HZ;
>> Yes, currently is 45 secs which is, I think, is way too long.
>>
>>> I wonder if this should be based around some multiple of the grace
>>> period instead?
>> I think the time to allow for recall reply should be in milliseconds.
>>
>> -Dai
>>
> I don't think that's at all reasonable. We'll be fencing slow machines
> all over the place. Clients expect that they can be out of contact for
> a little while (a lease period) and not lose their state. Fencing them
> on a timeout substantially less than that will violate that
> expectation.

That is fine. But the way __break_lease is implemented now is that the
NFSD thread (limited resource) is tied up for a very long time to wait
or the client, which does not seem right.

Also, in __break_lease, if the first lease in the flc_lease list is not
the one that causes the conflict then its fl_break_time is 0 which causes
wait in wait_event_interruptible_timeout to be 1 sec. And that thread
just chews up CPU cycles in 1 second interval.

For long term, perhaps we should find other ways to implement __break_lease.

-Dai

>
>>>>    	nfsd4_recall_file_layout(fl->c.flc_owner);
>>>>    	return false;
>>>>    }
>>>> @@ -764,9 +763,27 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
>>>>    	return lease_modify(onlist, arg, dispose);
>>>>    }
>>>>    
>>>> +static void nfsd_layout_breaker_timedout(struct file_lease *fl)
>>>> +{
>>>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>>>> +	struct nfsd_file *nf;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	nf = nfsd_file_get(ls->ls_file);
>>>> +	rcu_read_unlock();
>>>> +	if (nf) {
>>>> +		int type = ls->ls_layout_type;
>>>> +
>>>> +		if (nfsd4_layout_ops[type]->fence_client)
>>>> +			nfsd4_layout_ops[type]->fence_client(ls, nf);
>>>> +		nfsd_file_put(nf);
>>>> +	}
>>>> +}
>>>> +
>>>>    static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>>>    	.lm_break	= nfsd4_layout_lm_break,
>>>>    	.lm_change	= nfsd4_layout_lm_change,
>>>> +	.lm_breaker_timedout	= nfsd_layout_breaker_timedout,
>>>>    };
>>>>    
>>>>    int

