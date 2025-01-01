Return-Path: <linux-nfs+bounces-8864-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63879FF52D
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 00:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0447D3A1EAA
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 23:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7281F5FA;
	Wed,  1 Jan 2025 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BcU8XHE/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z7wULBjc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B52DF49
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jan 2025 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735772717; cv=fail; b=F3d+ab4fMhnMkRyZNDmw2zF2ke/VcigVxEwkOKTvmqAkEmRmLcdaW2rWxyGifIIpZrcqR3ZgBBg/PbCR/p7KsTYBgOmBMNNK5x9t2uplfbXuzHE1NJXhGKYSZPMPECIMTyedjE9/NstLKUEu+Y+CeDzsFFBWeCSMVhnLjT33uos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735772717; c=relaxed/simple;
	bh=gWBv0ifIrySqgit1K3Q4tIow1d4GqSpkvotepkq27VY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KHY0YbUloc6RJUMUe7IlUvMMnxQawuuoKFL04myj35f8Uq2y5M4flWCuPNl3xBu8B0gSjCE6dh6x3f3XwWaiss36kOJw8weQz8PgqKPm7cngrGfj89yIaJiGCHZGugdLtuTykoAOIkNBV2XITwbaoOzf3F7+XB6EbGYFBgBE8xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BcU8XHE/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z7wULBjc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501Me2Wj022047;
	Wed, 1 Jan 2025 23:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=44PAJ1Z4f90lCRVdjvIks+OdVaQ4fThn7yEl8fFeHSU=; b=
	BcU8XHE/OMhBwr1L0oOIRovy/KiBEy5o1c4TqsfUuzosJD8hjV/3367gpk42ZHec
	Z+vEp1zcc+VTnzlwZa4f1BM0QDkbtMZuxVznErrDJ2jMT/cGd6grR0nprniUun4q
	swF7AS8gJfFB/bRvYmbn+szRtq2uA3WqPyYModi366MrIsFicC4+zqUkzvz2ZE9f
	b4shbdJq62/T6Yi0yRX7lq+0sILIvdf5vQzFlZ5maNkLH5ckNrohoZ26bD2zSDnF
	kgtP47EINkYQWp+hCa1WgPBSwttFbh8Z+wVT9yoT4l3jr04lI8Wy2R+KI+/QHwDl
	BcffNuOd9+W6JmvIekpwZg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t978mh7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 23:05:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501JUw10009525;
	Wed, 1 Jan 2025 23:05:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s812s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 23:05:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMQlzcQJrXz0Fpv/aK2LSwX+0DhqX7aadJs4ksgrk1JlhwOh6DTMH4/GxocizDda6er5etesDBDQ56sd8L/pRZa6ptxhdfXBTiDDiLw4b9L8xf27C7RzYpxe3fl2qkV0ieCAZUYgSYG1ngpxJsHLH9WQcqb8P8unfmmO67ZZqj1coJvPVd5y0t0UxdrOPq2ulGfjQ7Sg8odkj2TeW79kI9+prukfP9K2bGHylmxvFYPMdRq5YZ5Lg2saKVIxJ/U8k7CyIwdloRpoHDhlkubh2YqHhz9/tjk2ZJzWTwRbPsAMWcbph00GoO3n2Cv1nIc8Vlzt1zRj0Vhi2eECboOjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44PAJ1Z4f90lCRVdjvIks+OdVaQ4fThn7yEl8fFeHSU=;
 b=Jwmr4AhFf+LnZhcv+RRYwSaaexbBFnNj528GSZh4P/N1ejePlJKmD//f+tu6xOp7bYRE4zAVvsuTYhJMcPi/b5YKooiF49xDM8icLlqxonYDlCnClhY4HWbtfHcjiL8VihpA6btsoE3VTg+9n1jH8avZCaG6CDqfrFcG3eBfBIs0jV+V1iy0acKJSzEQJd9dgPYqZ1GjybU/NdG+lPb/8N2AMfSstVjsOuseUtjUYanC49FfKupQz5H2EqElVA+QOPgtdCJ1lWNcU5wdQzfSgiPjFTCizxzWrq2iltFxn3TP3O6nDe0FrcQMIbk+ykxCWTc2OxeHiYbhaR8vYO5D2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44PAJ1Z4f90lCRVdjvIks+OdVaQ4fThn7yEl8fFeHSU=;
 b=z7wULBjcHDHOyVtSDweOWqaIq6S6FenF7jtmAZrVEKZ85+0UKVL98R4DPS+ywTJA2ZJFQc8QsPeh/YvkQO/UDpeh4aBMJR5zSbbZ7E1IGHYq7syDhFiHog6BwtFnwO1gu85e7p3SExqN1veUEaYjRO2YJDE3dWxn2kuB9HEgOyg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 23:05:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.012; Wed, 1 Jan 2025
 23:04:58 +0000
Message-ID: <1bbaf5e4-ab2d-4a11-b07d-c775ddbac49e@oracle.com>
Date: Wed, 1 Jan 2025 18:04:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Clarification on PyNFS Test Case Behavior for st_lookupp.testLink
 in Versions 4.0 and 4.1
To: "J. Bruce Fields" <bfields@fieldses.org>,
        "Gaikwad, Shubham" <Shubham.Gaikwad1@dell.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Godbole, Ajey" <Ajey.Godbole@dell.com>,
        Calum Mackay <calum.mackay@oracle.com>, Neil Brown <neilb@suse.de>
References: <MW4PR19MB7103BADC7FC3CBC1B2B8FAA5C40B2@MW4PR19MB7103.namprd19.prod.outlook.com>
 <Z3W1yPzJs1bDQGo5@poldevia.fieldses.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z3W1yPzJs1bDQGo5@poldevia.fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:610:b3::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: f4dc489e-6b74-4346-934a-08dd2ab8b6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlNNZ0FEZkwzWC9JWkhRUjNLQ29ZNTRMLzEwVjJHc3Iza0tWcXBQYzVRWGRu?=
 =?utf-8?B?YnFUMkZaYitndVFzTXBCMUg0N2pMK1dtb05zUE82eDViVmtNekFmcUcwK1oz?=
 =?utf-8?B?SVBmVG9kWVhQVTJsVy9IYVdMWTk0OHlOQklqQkRNNU1YMTZqblZPeUFvNCtO?=
 =?utf-8?B?K3o2YmI5bzBObHFhV05zQkR4WTVCQWEzY0JPQTlZbEpwNFQyVTYxS0JFdUN2?=
 =?utf-8?B?TDNhS2k1cDBodkRMZnhISXhmcVh3dTh0S2VCaWR0Y3VFNkJyS0hib2pHT0NN?=
 =?utf-8?B?c28zWG5yTVcrYXdwQVRCTVdtSmRMYnlYNGs0cGI4Ri90anhVK0NMK0Q1aUV4?=
 =?utf-8?B?cWNrUXUyM2dTUmVRbjQ5SXFHTjB4NlVSNDc2MUNDV05OSDVnT2FLSExyUjMy?=
 =?utf-8?B?S1RhZldxRFhJdFlXbzJpQmJha1E2RnU3bTJSZXowenZVR3dwQjlIemxGa3I5?=
 =?utf-8?B?T1ZscHJuaXFXamhVUnUrKzNEWmNDUTNWMHJvV2VSYUVpOEdzRDV6Vk9hK1pM?=
 =?utf-8?B?aXliQ2hwd3Y0dm5OVE1RRDB3N1gzK2xzbHdhNVZ4ZkdaTVhFRzh5UmRlNXBP?=
 =?utf-8?B?Zkdpb3lBTGZtUkdMWDU2MHc3aWNzenZWRWdYeTBsWWhiOE82eEpVZVZwekQ4?=
 =?utf-8?B?SEVBUlNkVXYyTDkrN09Fd2Jpcko3R3lJRTRQUlllUXRCN3pWVVJzSjhvNHZC?=
 =?utf-8?B?cmdWR2t2YUcxeHdyNDNId3NXdDBUbS9pT3p4QkNLd0ZLKzk3SG5VUnJkY1Jx?=
 =?utf-8?B?RUFXeVBBQ3pXdkhWOHNBZVNpQnZGckNWd2NGOG9hc0VhOXFFTWpsQytZRTBy?=
 =?utf-8?B?S0pTeitNd0E1WVgzYXRnSjdMQk1IR1hQbDdPVE5FcU4yQTJyU0xlNjY5TGdw?=
 =?utf-8?B?V04vQWYyVlFQVjhkajhmRy9NSmNvLzlOZCtXTzhjbGpHSGNPcFhPa25BZ0Ro?=
 =?utf-8?B?MVFCeitzRFZKRFZGOWx0eFp3SGN5bHMyMWlkdlBEd3gwajVZb2tMbFlZWEho?=
 =?utf-8?B?VWl5Ujc5dFhiNldLVFZIMHpYdVE3NkRaS1hvUDJ2Ykk3R1ZhZ2tpUldBTWxj?=
 =?utf-8?B?NlRFTElSMGdLMHJvQ0ZNaDRQRlAvcHZpZzNrbWQyOEJ6Y2ZveDQ3YU4xSmgw?=
 =?utf-8?B?SEZjNExGVExKQ056cmdnOElxYTJ3amh4UXViM3lVWEswZG9oYWZ3M2g3TytI?=
 =?utf-8?B?Z2xrZk5LeThSRThpU2N4bGh2Zncyc0tBeVBiT1Y0Qm1NTHpCSDR0OFpFd3g4?=
 =?utf-8?B?ZytDaHpTaTFGNm9RUFhpNE4yeGFyZmxKQjczOXVtUTNya1dzSWpCL3oxczh0?=
 =?utf-8?B?clBLczhGTTdSLzQzdkI2SlZyRk43V0N1NXFPUzJpRElqL00xQVFxTElLbHpp?=
 =?utf-8?B?alJmOXFTM2IwVjczM1dadDJKdkZsU1hjNElOd3c5WERJZlJBK3VoOHNaZWww?=
 =?utf-8?B?b0dqMHNZYTRRc21QbklKS0haNFlSdWJTUm41d2ZBMFQ5eThhdFNuUDhydGVK?=
 =?utf-8?B?SHJ0Nytad2JBUkFUS2ZjVTdnUERIdzZweEZWSGlOR2xrL3p6eUl2ZFpvS2ty?=
 =?utf-8?B?RVZqd1VjN2hDNFBYZEU2TjlHUmpKOTh2c1NKcEs1am5GTHhEKzFYdWVTTTBv?=
 =?utf-8?B?Z3QyRHNDTmNRM3pyd1Y3NnNYVExqSzlsZHdvSmczQ0xQdG5pTzU0RDB3UWs4?=
 =?utf-8?B?VXV3Q1FBek02UmtOUGNCUDN5elIvQkFNYTBkb0dWc0RTZi8xQmxXU0J3VUQy?=
 =?utf-8?B?WUJldkZVckZuR3lZUTBlUm9DV0NBTy9nL0ZkUERvN0dqRmZXME1FZ0JOOG9W?=
 =?utf-8?B?QXZkd3BwSXZjcDR3VWVBQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qlc2YXBjbUl5ZzgvY0dzcjZ4TDBCTGNxcHFhRmEyNHl3RUtPOHZoTnkxV2Jy?=
 =?utf-8?B?M2VsdjN4YW1CNkJsL2dXS1dJZ1VtNWFodzJLSnFVMWpUdmFIUkdldXlPVXdF?=
 =?utf-8?B?Q0NCQlFlMUVZTW9INTFaZDVUU25aSFZvUGNTU3F6czIvVEtDamdXWXZpbDF3?=
 =?utf-8?B?enlsc3EwMGNWR1FnMUtmWDkxbXJKMEJpREVEcE9RL01uOXhqSStGeWdscmh2?=
 =?utf-8?B?RCtpWkFHWGpLUVI0T2pGM1d2OHpiVCtodzhWam9mU0p0cnhTN0lCa3VqNUxY?=
 =?utf-8?B?em81eVBaVldJaTlxK0dVSjJBcEtkaEtCNm8xak1QaXVHSnQ0dUlGSUZVTm1z?=
 =?utf-8?B?Mm5peHZONnkwTDRXK09veU5TTUtyL2Ezd3k0cmtYZWpKamVRL3pRSmlsODdw?=
 =?utf-8?B?ME5wVUZ5QWEzY0w4NlRESk1PVWJ5dUoxUllaUGJUZFh4c25zZEw3cEFsUWw1?=
 =?utf-8?B?eVVZMWh0MnZHdHI1UkxIS2o4bVNNV3F3WTdiZGViQk5neEtqT1VxUTBoZmdN?=
 =?utf-8?B?enBJOUZwVDBlaDJIOWoyVG1ycTliNGY0eVlTd0VtZTNTR0hSdU4wam9iNUQ3?=
 =?utf-8?B?MFhneHVBYTBMVVpRaTJDWlErTkxKSjFJeHkvOTl2c1N0SVhwdDg3VkgzeVlV?=
 =?utf-8?B?NjNBSkdNUncwL25mVk1mTHpraHlmTW92V2t2VEpabjRITmUyM213L0NkL0NH?=
 =?utf-8?B?Q3F5MDd4RDRQSGxFZFZpOFlVcTV3MW1JOWZGNmVtOHVYRWxtd0dsSVJBSi9x?=
 =?utf-8?B?cFFOY1Uzb0NaVEtmaS9MTmhYNWg2d1M4TGVDd2M4azVUVmpkZFZjQ2NXMU9x?=
 =?utf-8?B?ODk5V0pPY3NSWGFzSUhkVmhpMTZEbjZhblJWV2p3T1d3WWk5WS8wS1RRd2xD?=
 =?utf-8?B?cVJDL0s0SFlIekgzc05nUWJrMkpURFpPTy9jTzF5RUNVdFdyZlJDc2wwWSt6?=
 =?utf-8?B?cWlUL3Z5b0FrYVgwQ0cvbFlGSzZVZWRQOTdZdSt3V1BEa1FEN1c2a0FUMmFX?=
 =?utf-8?B?RGZyZUM2ZnZhOVg0REQ1YkJDQ2NrM2tHU3ZuaDRaSVllbWF4TllZaFg2T3Nx?=
 =?utf-8?B?NnpVclM4bGptOVdIT1VsUjVxRmRQdTVST2JRZzR1UEpoY1djczVIN29JVDBD?=
 =?utf-8?B?cmd3d0ZqWW1vYTRlaWlORU9iMVVDUkVsQkZrN1NGd0ZwQmZSWUczRk1Lbm5y?=
 =?utf-8?B?LzQ3RUlPQ1pZSVZsVkE0SDUvdzJ6Q1JNMDdaZlRtMmtzSDJwU09xWW9zVmZy?=
 =?utf-8?B?SUVkM25pUWsya0c1WmJWMFA2QUkxYXdQYmlRTkx0QmJoZ2FkR29KUmpkRS90?=
 =?utf-8?B?blZGbWtjRHVlM2hxSVdXQi93M0J2S2hVQjZmTVoyaGplOWdDbUpzUkt0dXZk?=
 =?utf-8?B?eWJPYlM3MDNTandiNExyUkh4c2VYUXVQYmZVK002RE1lRjF5SDR4UE9VWmVF?=
 =?utf-8?B?VU0za3YrZnAyemhpS3A2RGlhbDloNHZ3aStyd3hDbmFkRnIwSUtZY2ZuY3g2?=
 =?utf-8?B?M0kzZTVjSklXek1ubzBHR3pXRm1IMkYycDFuU3V1eGNNMXVoRWZ3dExBU2lU?=
 =?utf-8?B?ckdKMUdxc3Y2SzgzZUJFdFk2NnZGMFlGaUZtY2NDNkpTTVpGUEpmTXRxQzFL?=
 =?utf-8?B?UWwrbHo5QmFOTWRYVEc5UEJsSmp4VlZXdCtDdG16RjF1dFZXTlBqWXdYOEpQ?=
 =?utf-8?B?V2QrMzQzZW5pbUJQaVFpL09uMlRkd0RRUUxoOWNNZ0NJRFBZYnZkVlpaRGow?=
 =?utf-8?B?UzlrczZWWm1mWnF2YzlsVmI3ZDQ2TlNlRU5tOEJ6dHRtZmhKUTFkdEhYTm91?=
 =?utf-8?B?RllHd1I5YXI4NEZXbEMrM1I5bVZndTdCWG5zMmRPTXVMKzBKRDErS01FOE1C?=
 =?utf-8?B?c1Y0WldiejFITzErYXRJTXpaQlMrM3M2K0RqMkV1ZWFlbDg2dXE2VW9IK0o0?=
 =?utf-8?B?WGRUaFdUeS91ZHR0WC84Q21qaHlOaFFNa01yZmhzbjNvMXBuakRRY0h1djFn?=
 =?utf-8?B?MmNNQktLQk9SSVdUTDNmMGNaVTJpLzlMR3k4TytCOHRZcHRIL0dNMHNVa1Zo?=
 =?utf-8?B?UFVwSk5mcCtXd21MNDRmWEpndC9ITUhzRlgvellZaDVUOGhWSmJ1aVNjaEkz?=
 =?utf-8?B?TGRRQ0huaEx1WEdpdGtITVRleUU5R1RNRm95dVZwMW0vclFJaG9lc21LTVhv?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6v3rQZXwqQRGWFUN5We+ae40WzIKB2DKBIPfvIPYYzhU0l+ESM0vknJ8EO6/ECG4dZJvKJwlhNyo/fBKeYkvPXql3o4i0JEpX+kk/e/LD8fyeHvDVESjmH8UoiHCc3wqV/q+ArAwU8lR7frVF+Jzbgiea5uXpOKoUzwEsUq/3cpDW/Xa/YsU/h3FbkEfIgy1PKV2vF2FlDyhbSZ5uLllaK/tdaClQSwBEq7oNVqOEJW2z02wcf1Z6g8O8tiVKPZMyqSqr99JRC6eKFcNl4SJNa91sKBXcKzoVu6tzwLY5lGRS4Dn5hCIw7nnEtYvsc3RLio64KoGrFtFf3fWMuBuvkQhvZlC7ARcnNTZazCujjW2MxMyG4Cm++ir26Wv9tdoKByvZqVqpJlqA8EIeCGD7r5vTFLYnao5vBseTLeimc+xi8+u1o7G+bvP7IWTZkei2cLj4XrrqUP0IwnSlAojo02MR1bB9xiWivS3JDmnVKhncQJfNaHrshR9ZEZtWJm+bVs4z2tAqmddGg+uQYHXLV4XplV9yXn0SZvySNyGLP8uGKJsyn6MK8CejlkYwDvGsJGSK6OQCsarQcmyGzQDHErSoDZwdXZ7y0T962A/YWA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dc489e-6b74-4346-934a-08dd2ab8b6e6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 23:04:58.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yMkz16pHM1/pgeCHMP8dk6D5DIbvNd/KV97QK8wes7sALcBn+Fy5h8Lkd4PUCgK3Q8ZNXyzLDBGl52+w55mjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_10,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010206
X-Proofpoint-ORIG-GUID: 8ydf_3WJKUDwDWMc5EjcwNNsOeF-04Tq
X-Proofpoint-GUID: 8ydf_3WJKUDwDWMc5EjcwNNsOeF-04Tq

On 1/1/25 4:38 PM, J. Bruce Fields wrote:
> On Wed, Jan 01, 2025 at 06:28:12AM +0000, Gaikwad, Shubham wrote:
>> Hi Bruce/PyNFS team,
>> I hope this email finds you well.
> 
> Thanks, yes, but I'm not actually maintaining pynfs anymore and I don't
> remember who is....

Calum Mackay, copied.


>> I am reaching out to seek clarification regarding the PyNFS test case
>> 'st_lookupp.testLink' (flag: lookupp, code: LOOKP2a/LKPP1a) included
>> in the PyNFS test suite for v4.0 and v4.1. Specifically, I would like
>> to understand the expected behavior relating to the error codes for
>> this test case.
>>
>> In the PyNFS test suite for v4.0, the test case LOOKP2a (located at
>> nfs4.0/servertests/st_lookupp.py::testLink) initially checked for the
>> error code NFS4ERR_NOTDIR. Subsequently, an update was made to this
>> test case to also expect NFS4ERR_SYMLINK in addition to NFS4ERR_NOTDIR
>> [reference: git.linux-nfs.org Git - bfields/pynfs.git/commitdiff].
>> However, in the PyNFS test suite for v4.1, the corresponding test case
>> LKPP1a (located at nfs4.1/server41tests/st_lookupp.py::testLink)
>> continues to check only for NFS4ERR_SYMLINK as the expected error
>> code.
>>
>> Given the discrepancy, should the test case for v4.1 (LKPP1a) be
>> updated to also check for NFS4ERR_NOTDIR, similar to the modification
>> made for the v4.0 test case (LOOKP2a)? Additionally, while the RFC
>> 8881 section on the lookupp operation [reference: Section 18.14:
>> Operation 16: LOOKUPP - Lookup Parent Directory] does not explicitly
>> mention the error code NFS4ERR_SYMLINK, it is noted in Sections 15.2
>> [reference: Operations and Their Valid Errors] and section 15.4
>> [reference: Errors and the Operations That Use Them]. Therefore, would
>> it be reasonable to update the test case LKPP1a to allow both
>> NFS4ERR_SYMLINK and NFS4ERR_NOTDIR as valid error codes, ensuring the
>> test case passes if either error code is received from the server?
> 
> Not sure!  In theory I guess 4.1 could be stricter about the error code
> than 4.0.  Language for other operations (e.g. LOOKUP, 18.13.4) does
> seem to prefer ERR_SYMLINK in the case of a symlink.  I think the Linux
> client probably only uses LOOKUPP in the export code, where the choice
> of error is unlikely to matter.

There are some differences between NFSv4.0 and NFSv4.1. Neil recently
did some work in this area. See:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=438f81e0e92a780b117097503599eb030b77dabe

Perhaps he missed a spot.


> I'd guess it doesn't matter much.  What motivates the question?
> 
> --b.
> 
>>
>> Your insight on this matter would be greatly appreciated.
>>
>> References: 1. git.linux-nfs.org Git - bfields/pynfs.git/commitdiff --
>> https://git.linux-nfs.org/?p=bfields/pynfs.git;a=commitdiff;h=6044afcc8ab7deea1beb77be53956fc36713a5b3;hp=19e4c878f8538881af2b6e83672fb94d785aea33
>> 2. Section 18.14: Operation 16: LOOKUPP - Lookup Parent Directory --
>> https://www.rfc-editor.org/rfc/rfc8881.html#name-operation-16-lookupp-lookup
>> 3. Operations and Their Valid Errors --
>> https://www.rfc-editor.org/rfc/rfc8881.html#name-operations-and-their-valid-
>> 4. Errors and the Operations That Use Them --
>> https://www.rfc-editor.org/rfc/rfc8881.html#name-errors-and-the-operations-t
>>
>> Best regards, Shubham Gaikwad
> 


-- 
Chuck Lever

