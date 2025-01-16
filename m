Return-Path: <linux-nfs+bounces-9301-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79077A13BE7
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 15:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8143A0843
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672AF1F37DD;
	Thu, 16 Jan 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FqhaaNfs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GHW6N6Oi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A151A08BC
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036787; cv=fail; b=r4jsymk/YTgmforS5uqS9PPCRdMWIgA/hJVYTDH8IHfc0UAfOVQUdqs1AKAdUebksRwa22ofypt3jFEHU3dBksXaS4/ShYuSK4lJ77gtPaOiPdqty6rXXkzWHaf9xT3zPHw2V1PNNknHqv9C9lr82zGOj3+n3KWAjtbDdqyD1yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036787; c=relaxed/simple;
	bh=ni09ymXp51oUFWIv8SrKc/VUoxXBDYNoQbjr+AcX+k0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bToHpRiNLNvs7CcCfmescYnzIN70jJvV2P6/Y4RcKYgONac5Ru2STW1hlWMJgajDFtQz2fm3EmrzkeWKE/7ijcSFMLvGRrHKuQmTMlVVGKhqM+xeKyz4wP9cT79wGx7XzjShB+ra2sg9RYn9XBngTQrTJ3xCxDy2r8npAWbairM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FqhaaNfs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GHW6N6Oi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBN3Ph028993;
	Thu, 16 Jan 2025 14:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=REYXw8V8kS92bspAd8sq3dkW/BtDnNlHWkriI8m9RYk=; b=
	FqhaaNfsitpx/GUxMVwqiQ0YsBhTS3IzxhjrnkatXaK+2YVd8hPZdZ2naaE3Z4g5
	MZCpwwJUFViLyu7LQBKU4XICbxjS7O6+RWVYa7tHOE2uEpqJpnZrR5t/KoN+PWo4
	Keg9tyiqgVr7P5Pc1toMeBkQm5bfrfKBALdqhmyTz91xhIlw4UMuQsfsDUdNvijm
	uXyreXV0GEu4E9YOc22nV8EsVz1v9QYq9fUv5znmBgjfVtPlpzuHVN1E7mtpdgCq
	6Z9oryc16p3CtZVhl6amHnRa/xCgGVPNguztleaPsbiMBJ6c2scmI+lpStOoIu5M
	iOlB7Z677HFo5xkNTw4wYg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fe2jdyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:12:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GE1Ghn030005;
	Thu, 16 Jan 2025 14:12:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3auc2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:12:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Et+MeNDnVlA6+RdyKo/+xl3a4VbOtxSuLTyYscPgSXEcnU2RivNEbFyyIaF8mPUewFAJW7s9D9s/RYtNry76B/dI1QtiBMVY3Vt+Y4Y95Fmx1uadfp86uKEdBmGWJbQQjGgy7NUQQsBFnSb14bPCK3fMZeII5aUZAOzNbdyO2LBPAIcO9V7RRHjHYEJd4IOSGN0+RPe9ThlsIBistaZVPVYpCJcKD8IRxhQvA3FN2sdW8IvMoUu4s3oASv6lPaZkvWQztmTMlN3UaAUNkizDuMN7QqSQ6lGBEO63iRTXdFnEXrArd/fuXaSylQN/Ft8kNhmAvRkHrTYMUWioV1HFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REYXw8V8kS92bspAd8sq3dkW/BtDnNlHWkriI8m9RYk=;
 b=aXJx/4pQXgf90AE6jk76wm/TOQYO3v9TYJj9OcALgPffx7qkVgydq8277Kd/eLhYfCrDNHdhjlu4Bb/Ep3MC1sXyTtQ6bfKImUHmyt6GJnBddxPZUeWjdRsh7r1FjGZTEagGfVL1suXNska2Aweq+AhidV7affWIsCsAiQhg81AB3G0HN0tOWRKhsuKLRdFk/n04SBFM5evKXN8qB7KHB82YEW9q/BpHl/1q/Z1SpGHxg3FfR3jymllhvdY1GqXaYTH2EOnw2oIKrtmrQ9preWqXMFwsXF7sMmLDiEOzFvhnmHKSNMWCPeXoqOhTY0SOWW81JsSseQDgD2PZzlpKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REYXw8V8kS92bspAd8sq3dkW/BtDnNlHWkriI8m9RYk=;
 b=GHW6N6Oi/641P8IdULEnis1cD0Kbvz2xCgjCi3zSAKgRGOaSRO+dn5NuIg54mCZs4T9m0Yd5Owzf7K3baX3o/S5PrSakcLMmDL6wo6Kyt4HiDX0QI6aAawHyJfSwrVA7IaN+0GrVXbN3CLqvhl8CNkC/IywQbuUY3JHqguxxHjY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB7389.namprd10.prod.outlook.com (2603:10b6:8:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 14:12:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 14:12:54 +0000
Message-ID: <99ea3fa8-ffd6-4fbd-af73-c0dabb261973@oracle.com>
Date: Thu, 16 Jan 2025 09:12:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd4 laundromat_main hung tasks
To: Rik Theys <rik.theys@gmail.com>
Cc: Christian Herzog <herzog@phys.ethz.ch>,
        Salvatore Bonaccorso <carnil@debian.org>, linux-nfs@vger.kernel.org
References: <CAPwv0JnSQ=hsmUMy0VY-8k+dANBLNkJdFJ75q9EEE+Hj0XXB8A@mail.gmail.com>
 <d54d71f7-9bdb-49a4-8687-563558eca95e@oracle.com>
 <CAPwv0J=oKBnCia_mmhm-tYLPqw03jO=LxfUbShSyXFp-mKET5A@mail.gmail.com>
 <49654519-9166-4593-ac62-77400cebebb4@oracle.com>
 <CAPwv0J=ju3fZ8C_FFeDnzzKT-ppXaLCde64hQof3=g641Daudw@mail.gmail.com>
 <cbc55c4a-ac98-4121-b590-13f32a257d65@oracle.com>
 <CAPwv0JmA+29fujmmrugY0AFdtDDqjSvn6RTHzwYNR9a4skXfeQ@mail.gmail.com>
 <75633e31-53ae-4525-ae84-1400ae802359@oracle.com>
 <CAPwv0Jk1UaHqNX27AtR+sPrCdVbckpR5ayQ-u+kZ=w3C+sOsgQ@mail.gmail.com>
 <42da212b-071b-4c20-b7da-97ca02413c5a@oracle.com>
 <02d46ca4-59fc-4760-a9a0-6d8fe41df1cf@oracle.com>
 <CAPwv0JnM=Cz=sMazCSuuRbOjHURQ2bDox7F=OqQoT9DxbsaHzw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAPwv0JnM=Cz=sMazCSuuRbOjHURQ2bDox7F=OqQoT9DxbsaHzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:610:b3::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: c4226fff-0766-46cb-06b8-08dd3637dea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3o0d05pRGIyaWEybVIrVFpSSUtFYkUxU0Vpak9yaWRwY2VUUVRpZFdLUm5v?=
 =?utf-8?B?SWU4WC9xa0xrNldlOFQvUTdvVmd4aU5CclhHSGJna3hORXZVNGFZY091a281?=
 =?utf-8?B?UUgrWGFqU1krc1MrOElEZWNUUU5UUUNMZVpmcUlEZ0kvcXFocVk4dVRaWGd4?=
 =?utf-8?B?OUNqMGdPc2dBUXpldEJ0bkZzbzdvUTRHWkpiVGRrblptUTRMblhsdHRhMVA5?=
 =?utf-8?B?YkFWalFtV2J5TE0vWnBwODZUWTV5eWNOTldBa2pvUzhBSUROSk14UmQzNy83?=
 =?utf-8?B?ZVdKQy9VUjlLbEpOTjNVWlRoZUNCU1hXeWNaTkFFMmhQbTN0UE5Xd1BwTno2?=
 =?utf-8?B?ZVBOSDR5dVpKOUw4NnFLNEZQdHQyek9Fd1JJclBwZ3hqZiszOVZlSW5vTVJN?=
 =?utf-8?B?WFVHS1VkL2x4RGplSVRHSFhGQ3BLaGZzSnljMVZNWUc5SW5XcitMb1hwWWxi?=
 =?utf-8?B?ODdSMVhaWG10OW5Ya2orSmVHellFRXpIT1E4ZHdkN1RKaGdrbXpjMGEvZEpV?=
 =?utf-8?B?QTBwajl6Uk5nU1ZwTlVQQjRTMG4zdm1ZdTRhdFRJUDlYUFdZK0NWT1NseWtD?=
 =?utf-8?B?bDZnSGhPQWdJbU9tYjAwb0RSK0RIdTFPTXFuN1dodkFZZ0lsYVhheUZJVm02?=
 =?utf-8?B?NzAyOExlYzhyWGRucFpIaHhsMEVWckgzc0tBZ0ZRVlV0YnV4ZHhGbGhXYStB?=
 =?utf-8?B?VFhPVE13Rjh1ZjFvQlJpR1V2eUpUV1pUaXlIQmY3c3IvUm0rV2RNZ3pkWTI0?=
 =?utf-8?B?TlYxanh4MWtlZWNlU1NuUWxLZEpYWDdoWUVsU0JmUkllNzFxOG1NVDdDeUdX?=
 =?utf-8?B?UnlTazJzelRmb1ZCeGs1c3B1czRkRFY1UHdJQ3BHbm93QTBtcXFQYkd6WkJo?=
 =?utf-8?B?azBFVmIrcmpRVWMxVGVSL09RQ2hnVm1DUzRRQkswcGYvZWZpSWpKR2RFUUtH?=
 =?utf-8?B?cjllR25HaUJkSUg1L0d2aUZEY3h0S2Y1TkN5SUQ4bHY5WDhYczB6TUdzVytM?=
 =?utf-8?B?OEtnalM2Ti8veU9zYmVOSVQ4NG4za2FMWjl2Tms3MmV2RUhZSCsrREJiOW9o?=
 =?utf-8?B?NHp4REVLOWY3c3RZdUt4ZUZHSjhnVU13Z1pmSER4RTFvVzBOVTAvSU1FbzJD?=
 =?utf-8?B?RS9TUG1nTHlyRW13c1hiN2E4OXdldE0yd0FYeGpLOGFJZUtxVVRPV00wNE8w?=
 =?utf-8?B?Q05IdW9PdjNYLzZXTzViWkU3SmZUSklSbDZCY0xmSkFRT2JyYXpJZjkzLzJZ?=
 =?utf-8?B?NXZVWWMyVW5jMkpRdHdVWkZQcXQrSXdiVzhwM0ZnU1orejJvYi9NdTE2bDJR?=
 =?utf-8?B?Y0d3dVErQzZwSXV1YkVoOExnQTNnR21hMTcyNCtSc29kSzIxaEtPZ3pzNFpW?=
 =?utf-8?B?dTdBRlJuU3d4dlVRdkYwblFteVZlTkM5ejVZWklIck1xV1E1eHZocnpUT2hN?=
 =?utf-8?B?eWVxMms4ZXpVekNyNUdPcWZJbHBmY3lDdmdTYU94MTVGRGNYMzg4M2VZR1Vh?=
 =?utf-8?B?Z0JKQmNjcENCU1VXaG9tek03TUQwUHliM0VvQ01OS1ZlMjdMYkJnemtoVHV5?=
 =?utf-8?B?QWRaOVV0SEdSR1ZpN1dVY3grbHlTU0VSamp6c3Z6UTl3ZGxNdkM2N0pGbEN1?=
 =?utf-8?B?NFlucnFmSWMrV1FSUmsvVFQ0WGpZTHR6bUluK1F0dkNRbncwWWJUZUJSU3hm?=
 =?utf-8?B?OXJTVDdHaHhKd0JDYitaM0M4ZmtqZG1wMEhHVHRCdHJOa04rVHl2WnNMN0hn?=
 =?utf-8?B?WFBKbHdMSVpwU2ZmWUE1eWlhSjV1WURmbVJ6REVJOGVDRENzMGhDYWw1TEFq?=
 =?utf-8?B?cll3bG9sMytPTWMyZjlKeTkxeFVBVUxXcWNteTRBdW9kV2NxeWRIT1BHUDlR?=
 =?utf-8?Q?bS56Mu6K3k1Im?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjhISU9wcmhFeTlXOVdMU3VLSGtNY2VubVl1aWZVa3RQNkloamJkNGJXbURJ?=
 =?utf-8?B?MXRnRnA1bkRpRkJXTDZyYk5yWVArMXowYlpHMGpoanNqK1E5VnFZMXdQWFBt?=
 =?utf-8?B?UW5iM1ZTWERySVFUdUpTV3FyQ1N6UTY1NDl4d2ZSVURaYlEvVVRNWE54Ums5?=
 =?utf-8?B?QS9nVmtQKzdTVjM0UjNkNmtZd3Q3TWE1ZEx1WjNLVEVlZ3dxZzZjN08wbEtW?=
 =?utf-8?B?bmtUNUE4d1RpS1R4bmM5VkZ5NW5WcHQ2UFByeUlOR2Vqdk5zbXErWS9TQVhv?=
 =?utf-8?B?SWhVYmhObjlpM1ZOUkR1dU9rWjNIbHpDUDkwVlRSMmVEZTU0SVIyUXAvK2Z3?=
 =?utf-8?B?c2RyVnRVMGdLR2hHNWFWV2RVVng0cU5OYmozeU9vRWlhWHNxVVY2SU15QTdE?=
 =?utf-8?B?UkRDcG1MUlJHbmMwZ1Uwa1g5dkhYcnpRMUdGbWN2aXJxaDE2VkNaZ0YzWEVG?=
 =?utf-8?B?YXBWWTRZNEswZTQ2T2c0RXNBSmY0RDhQYVdraXpNUytybDRqQ3JXSXBMOHIw?=
 =?utf-8?B?TGJWZFNRaGU2TkFFU3RCdStHcHJsZHRVSDZJRzd4R281cVdEcURDak9maXRl?=
 =?utf-8?B?cGEwZ2VXdGJ4Z0pCTW90bCtrMEo4SkZkS2VSV0VYRVU1L1ZqVFczaS9jTzdN?=
 =?utf-8?B?cXlHdHdLSFRoWkdkdEVVamVKT1FRdFgrbWRpTSsvbXBjckJ3VklidytZMkhu?=
 =?utf-8?B?MVVQczJoeXFxNXdpbExUTWlKQnl4Wk1uRlFOdklHc2dwL0taRHZ2bHl2bW5I?=
 =?utf-8?B?L2o3T2ZtK0pvclowa3NVYXNrZWtuOG5hZEkyRW9YdnRhTjI1UkRKb3c2Nnp2?=
 =?utf-8?B?QkNFR25oTXNLNmRvZEM1N0VSWUhPOVNvd0JGb05Bc2dTRVV2R1drbllUTzVC?=
 =?utf-8?B?bjNNbTZoV2lZUmg2MFJkVWhUMFc1cjFmVWdPNE13UURmTHRyU1ZnTWkrekwv?=
 =?utf-8?B?OStXVzQwd2dnMUZBUWxDanNyOWhCdUJiSHEwRHU2QmhqOTdncnp1Z3ZMUlo0?=
 =?utf-8?B?c2hJYmNwdkpTWWhyRUlxM1JmdkFiQys1YVBrS0QxSUNIcm1aazZNbDQ1U3ll?=
 =?utf-8?B?WnhudnQzQTVhell4NjBnVVJ4VStaN3BaRVQ4WnBieHpWTU5ZK0dlZkRjbVNo?=
 =?utf-8?B?K0k1UDFIZDBLby9uaHh5NUwycDZWM1B5Z3pEU0U2S0o4djBwSzNWdEt5UVVN?=
 =?utf-8?B?YXorc04wUWRjYURWYlp3MkpmcGRXcVo0U0ZLZGVJSm52aGwyVmhCZkpaN1dj?=
 =?utf-8?B?ZG03V0pTR1d6OWRhVGxsaHdxaVlOWlJrQ1NMaHpYeFJhTXE3SDlSZFZ2NjFn?=
 =?utf-8?B?b21BLzdNRGNOOVQxNEVjVWNQMTJya2hscVFDcjBvTUhrcTFWUFBWbE9HWmEy?=
 =?utf-8?B?TFdEZi8wK1dNcjhrd2MrQllWdHpTWm9iRDdnWTY2b3VkbVJoOWloTUJkeGZU?=
 =?utf-8?B?TGpIdXZyUVl6Y3NVcmlJNCtEMjV4NERraWM0QXhmdDBOT1RUYkwzSTNwVFpa?=
 =?utf-8?B?MjU1T0NSbnhacGtZaHRMSkw1V2hkWlN3MENaOVNPeFRYYnBxN2JnZk12cXJw?=
 =?utf-8?B?UjV3d2hScEthL1VpTHRUVDN1bStHWDBsekhCbGdDVUlGdkhLYXgxV0Y2WHRn?=
 =?utf-8?B?d1d3aTZsZTlQZGFzVitML0hWYUx2dE1oM2p2Rmd2blFHRThNbzlUWFFUU2VX?=
 =?utf-8?B?SzFDbTRjRit0dURESUk3TUt5anBUT1ZWcUVYMHhtNnc5Z2pZa0xmd0FPd2ho?=
 =?utf-8?B?b25KUXFWZFhPazFxUng3MUdUTFM1ZjBwY2xCZE9KLytxU3hKUE1NcHJyd2Z1?=
 =?utf-8?B?azhKYXg1Q0hOMktDa0tpZnM4b0FxTjNrTExTdm5QVGZ3UXl6QklwSXo5UHJB?=
 =?utf-8?B?SVVQSjVPN29HaldnNEsvNHV0RnlMemlUaXg4cWJLRmRqYW8wblY2ZlZLYzNh?=
 =?utf-8?B?VkhEZUpBczVSZjFQV1g5VkxXMEE5cUlhUnRqT1ovcURQNlc5c3JmZG45NzNX?=
 =?utf-8?B?TVppUCs1dmVBZVRTbUVCOWVJcmVuNkVGa1dOTGwyaWJUVTQ5aitwQnQ5SU9z?=
 =?utf-8?B?OFBseFhlZENFenBsTEtJUHBDMVZzOWd3aExSQWNwRitocDMxdENhL2FQQ3RZ?=
 =?utf-8?B?dWJsclRsUGRGRmwyb3JoVFdHUkltZXpFeE5NaDN4cWVOSWFvR24vMkVoQ05i?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mofAjKwE1xHvJEyc2RmFwp4MK31uImoZg5KfFjCeAfbd9TmjkUGACY6v+Wex3PR7oEU7MNomEFvKSYqHPmc9C2Fvu1QbclG05q7zPVATG7McONhNy/jM7VijQqkLI42qq9KibrB8aUKge5ZT0BUoBdEao8Shhm2xjHYm4JLgfId6uCuRElzoS5EEczr8yZis2Pu4JHIex17esel1zBRYXB/K5yaIUJoD3/cBvGtxEn+PAHyBH10uBz5thNrSj9SaFBCuGTSQ8Eho9r5NeQULG++zaQ+/3sG3wDPzYE3dnXc+8X/lV5GtXBOMRxtJB6CXdcsb/jt1AGRsgrwj5PBY4vpDE2zkpUIB0u8JeNLdP6kAEdEH/541h/kYWf53j23hg9vsRmsQmvtYUTb07y6oqz2fSi74v3h3q6lDGsqGXuNCfPHYBQ/BpyxPG0NMow4VPpnjJzahZ8U8A9OT/HeSI2Xbk3uWYrvKpojoFnZ3GK03dsmChH6cY4qEsTehla0dTIJdo4s/2oQ7JtEBEt4I/z/oi5BGQ2tvZdMtLgagfSQ+sQ37v4mNuyPb0gwf0VItFGemZEoeC4UykPTfdc6deAL/TCGvjp42mfM8K5kssmk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4226fff-0766-46cb-06b8-08dd3637dea1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 14:12:54.3991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4jMWHQZUy5MTQu+DuPiMWa2GE+1yng4aV5iYysWN56NIdw72eK9in3Y6pGvt3Nw+V9cRVo0tw8I0SM1SZtnVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=962
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160107
X-Proofpoint-ORIG-GUID: Kc3yBV89Rgf8i-bJzqU5M37IOj60EDXP
X-Proofpoint-GUID: Kc3yBV89Rgf8i-bJzqU5M37IOj60EDXP

On 1/16/25 4:03 AM, Rik Theys wrote:

>> The laundromat failure mode is not blocked in rpc_shutdown_client, so
>> there aren't any outstanding callback RPCs to observe.
>>
>> The DESTROY_SESSION failure mode is blocking on the flush_workqueue call
>> in nfsd4_shutdown_callback(), while this failure mode appears to have
>> passed that call and blocked on the wait for in-flight RPCs to go to
>> zero (as Jeff analyzed a few days ago).
> 
> If I look at the trace, nfs4_laundromat calls
> nfs4_process_client_reaplist, which calls __destroy_client at some
> point.
> 
> When I look at the __destroy_client function in nfs4state.c, I see it
> does a spin_lock(&state_lock) and spin_unlock(&state_lock) to perform
> certain actions, but it seems the lock is not (again) acquired when
> the nfsd4_shutdown_callback() function is called? According to the
> comment above the nfsd4_shutdown_callback function in nfs4callback.c,
> the function must be called under the state lock? Is it possible that
> the function is called without this state lock? Or is the comment no
> longer relevant?

The comment is stale.

Commit b687f6863eed ("nfsd: remove the client_mutex and the nfs4_lock/
unlock_state wrappers") removed the mutex that used to wrap calls to
this function.


> Another thing I've noticed (but I'm not sure it's relevant here) is
> that there's a client in /proc/nfs/nfsd/clients that has a states file
> that crashes nfsdclnts as the field does not have a "superblock"
> field:
> 
> # cat 8536/{info,states}
> clientid: 0x6d0596d0675df2b3
> address: "10.87.29.32:864"
> status: courtesy
> seconds from last renew: 2807740
> name: "Linux NFSv4.2 betelgeuse.esat.kuleuven.be"
> minor version: 2
> Implementation domain: "kernel.org"
> Implementation name: "Linux 4.18.0-553.32.1.el8_10.x86_64 #1 SMP Wed
> Dec 11 16:33:48 UTC 2024 x86_64"
> Implementation time: [0, 0]
> callback state: UNKNOWN
> callback address: 10.87.29.32:0
> admin-revoked states: 0
> - 0x00000001b3f25d67d096056d19facf00: { type: deleg, access: w }
> 
> This is one of the clients that has multiple entries in the
> /proc/fs/nfsd/clients directory, but of all the clients that have
> duplicate entries, this is the only one where the "broken" client is
> in the "courtesy" state for a long time now. It's also the only
> "broken" client that still has an entry in the states file. The others
> are all in the "unconfirmed" state and the states file is empty.

Likely that client entry is pinned somehow by this bug.

-- 
Chuck Lever

