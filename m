Return-Path: <linux-nfs+bounces-9535-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB702A1A5C1
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 15:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2E33A8A0A
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CF913212A;
	Thu, 23 Jan 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YfBDyqkE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mriKauB9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF3A1E4A6
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642562; cv=fail; b=J/P38+Xrtjjd56eHEeITDgI0UN3koGmAqiXqSdCMfFXnyRcGs3uf8Sn+DfNnHcuoMWZI0VZdXk7C+yDLvA/1/Y+R+PpnQZn4kXDN/YW7gqlmdlowHA5Wo+Iupjrv79O0834naHoRhz8deILxK4dPoPEfuDLUuyJnjgLGFycjrao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642562; c=relaxed/simple;
	bh=HwYQAVxmhuMNaPVmtaEAGLl7c9DgcVUsbh0euHF6zdo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CPcSqTYHbUmLqWqsUUVhjFgbki4VesnKwwZZRnJT2EERSm7ZxgDf/nnFEHWNwIceNZnBBTQgm2Xpd2QmGGDk/VsTuOUFkvb/U/UvjVX9iFq8jFvYh/ASQSqne3qConYDAlNLVwFLpIar6Cij8lvTh00AxFaDM+VuF4cWp12GI2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YfBDyqkE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mriKauB9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDaMEF032178;
	Thu, 23 Jan 2025 14:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=F1VjNHOtp9nOKntKd/6syd4IJI3z/2wQd6sMwOY86QI=; b=
	YfBDyqkEpnIR0pFHNs76zi0Pg6IdacF+TOesTuDuYZYiqU2N6H5vj7ISv0xwrV8e
	pGZoTdS27kAoSd3VaOtPHB32wPebJ6Dz/21g3zg5+hfZfFTZ3DNSkpx0B5oq2flH
	cfjvp0VtKgb3/87hYn9zNG0Q6bmYCI9lJSrOQdWWpqjCtWUiN4quR13ta5S6luJf
	M6ZwuRYQfYgGq5yY/jbwbt0D6s0ArcRMAZ/jLCxM3Od6PZbkpGhaZEh0L5tupFPj
	atGxlNKeWQohOVT2Ge3UUmn66w0Ar0p3NYoBp82azBLRyBA5wFS2Yxhs+XbY/t56
	j8Lb9TwD3qyswUkoVULErw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awpx2sbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 14:29:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDBdDJ030587;
	Thu, 23 Jan 2025 14:29:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4491956cfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 14:29:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZnuZCqplyV8WEmGM6U9AXY0GNFAVdul5bssi4xoox/5cwTORRDEjxMBOi1/sLF3QHipmAmxQZkPWy6crX/s/EIwd4gUsO4pyuwkN94nJfah+XMyJMMXb4Any30q2v2/dEEozZdnWFYPukjg+6WQAjiGZ74cM3BdFJtNv9wNPBa+0OQPLNDUiGRfKyGOGpxBcoKjOfLbRTZMsgyd8E+TELDg+VCsWFU0uzs7pjOHycmU+JpJCKpQOrfR5z632wKT1vyyojzeM4QBLzM+md9Z/3FV+aMEcxLUEFnSqDBFjFnViAoSBagfybaDIxWUDd4Hp+68OlYrylX16CMtcrR5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1VjNHOtp9nOKntKd/6syd4IJI3z/2wQd6sMwOY86QI=;
 b=ZmtjNs1IrIa169aanxMadiXPNo2ucrC6Jl0/ma89U7NF4XxVLFyfyvl2AOdM3ssQohoHDTm8TipZ1k53xUGqnlcQi8PHvThbrwUEP7YdYfVi+JQxvmjAVzbkHLfqWxXdvXA+Ur5O06jqb//oWze8gLXYhZUPcH1giSAW06u/2BVigeSYNymaj9bcYY2/TX91hX8v5b1euWjPw95A6aRLVOpQZya3+BqlbhTv9o0+ZRZBGB41Ig4RO0/CahBiZ4IAjZOmzAC0/wA0P61VzF/LNY0yiKcu9/vK+PkQ0SrOrHpaw9K3K10MreMgkPJ3cGq6CoRWWLdewPJsFpOZ7bFT+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1VjNHOtp9nOKntKd/6syd4IJI3z/2wQd6sMwOY86QI=;
 b=mriKauB9r2IZXEkoxQbNBxlAMg1ekyXC6/zl5lPo8Xuzh8M2IeLNogjP4D18c2RkaG0Mm1wRn+MPPT61Oks/oGDe+3oDdcEO2MDY8cSb7Ol51D2gE/fZLf+b+1M3eGw9Bm6aCTO9S6MjI70ORmlXIO7G9K3yGHPl0h9QaVvd4A8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 14:29:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 14:29:07 +0000
Message-ID: <22f89ff9-5fe5-4691-943c-28fbc291677f@oracle.com>
Date: Thu, 23 Jan 2025 09:29:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] nfsd: filecache: change garbage collect lists
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jeff Layton <jlayton@kernel.org>
References: <20250122035615.2893754-1-neilb@suse.de>
 <83ed7510-0a0c-4048-beb5-c4a10c38ca06@oracle.com>
 <173758417063.22054.674648092957982688@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173758417063.22054.674648092957982688@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:610:54::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: fd690caa-2e03-44e4-733e-08dd3bba4b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHRGRGdQRVlrMlU2ekI3Skt4RXRNN0FHTjYrTjROZEJxVGpQaHVEdnVHVHdC?=
 =?utf-8?B?dnlRVXdlR2lhRjJ5dG1iVkxmL0lzaFpTaFZwelFBcENHZm9BMEhCcUlaUVJR?=
 =?utf-8?B?ZE9XNTVCNVdpUkNBRzBzWWxzeXB1SExYeFpkd2NmQzZNeXlhRjUyVWRPanV4?=
 =?utf-8?B?Z2R1UzhjMi82Mnk4RElqdTRQY1Q1dDRpUVpUc0UwSmlxTkkwZUkxOCtEbjU5?=
 =?utf-8?B?ZkJtWlhWZE1WZjZrZ0JDS2tuMklMV3ZYbHQ3WGJrOHVuSU05TjJWckdQV1pp?=
 =?utf-8?B?WFhHL0psSGhFdldoUmQrbmR2RzlucWFpd3NhdTFsSXkxR2pyT1dibFE5NEQ4?=
 =?utf-8?B?UU1mdWZHOW95TmJORzl2M2NRMnFxMFJwRkRQYnNBVllxdzJqVkpLWk1vd2xB?=
 =?utf-8?B?cEludjVVcmtLT2NaTWwwTzgvcHM4WXoydFBjWGg1bGtpaHNxZGFhaTRTZFhS?=
 =?utf-8?B?VnZXT25yc3VVMHR4UUV0aHorNVV2VlVYSU01ellNSHRoUE5CVWx6cXd5WEcy?=
 =?utf-8?B?Z1JhUzZ6U3B1OG9kUktCOUtrdDYxemtoN3FPa1RBQXNlTnlwWjFMSVErZFdv?=
 =?utf-8?B?UW4zc3RMUDRQS1NFMnBwQXdCTGpVZWhKemRUUTRieGkrVGRqYTl4MFNleUpS?=
 =?utf-8?B?cjBLTW52aUQxemZUYTVuTjBBVnJ4MlVsRzZraWRDWEFIelpWUTh6UTZMcmFs?=
 =?utf-8?B?ZXVvTEs1TmV1NTJrbEtlTzlGdmJjVXg5TWZmS2loek8wMVZoMGR3S3RvNUF6?=
 =?utf-8?B?Vndva3IxRXVrQmV3TzBPRG5ScGI0OFNKUnhpQ0k1MFZDU3JJWENTMU9BK3Nw?=
 =?utf-8?B?S3NsVEtRUTREL0E2OEN0b0ZyL0FSakxNelZGVnJDWExTc0REOFhlNUxJZFRV?=
 =?utf-8?B?aTNzRDd2eldLdDA5NzdMeU5DTmtkLzA4Z25iUkh4VnJuczNOUTRzOG9jMWs5?=
 =?utf-8?B?RVF0R3NNOGJ6TUxQdGpBZXRlYlc1L25MeWFZNk9kdmZ0TkF4VDZFTlRVejZ5?=
 =?utf-8?B?NXA0bnJ1QW9FVWZrTGNqcDVJTzVQR1BVd05JOWFZMjl6NlRMWVRTMGhIdngz?=
 =?utf-8?B?TWNVdjVRelM1YXMza3hnZWlKeFU3Nm03dlc2ZDRMbGpSdWIyMTF6QnFDQjFy?=
 =?utf-8?B?cStZMWN4MFphQ04rVmI4Lzh3eFhqbDhNSkFZaUxTNHA3cU1xZXBRMS93R01T?=
 =?utf-8?B?M0FNSDY3dVpsV1VkNk5POExJbWYzckl5WHBaT1NZOVp5L2wxK1JacktoNndR?=
 =?utf-8?B?QnhNb29Qc1RZRVkrTFpjdSs2YkF4elovWmt5OUlJSDA2NFVFVHhVZkozajAx?=
 =?utf-8?B?bjRBTEpVaXdVV0hEbDJUVzBMQVo2VFJ0ckNReUdtQ3BsbW1RWVlVYUJjazdk?=
 =?utf-8?B?NnJJOUp4VmFBdTg4Wk5LUFNHZkQ5WlRkLzNkT3RSS04zREF5bm1KeUd4MkNU?=
 =?utf-8?B?blIybmNxc01tcVNpZW5ZZHhzU0cxNzFBRDZmNzJ6QzhTSThFclNxQXdpdk95?=
 =?utf-8?B?Z2VxaGx0MGw0VGE1MUNlWjZyL2haQXVFeHlPcVVGNTI0eW94b09rTWxBcWpx?=
 =?utf-8?B?SVpQZFNYMGhqaHdldWcyaDhlY2pxelE2UVN0RmEvbldRTVVNbXRtVHdieW5F?=
 =?utf-8?B?Vk9ESHVVWUtTU3VOZHFRMXNRU3Q5elBScndrS2lBTm13U3hDVUMvRVVMQUxH?=
 =?utf-8?B?YjRXZ3BoRGxReFI1UTNwNnh0UlcrNnphQXFEZFZQZDZWNm8ralIzYWVtSi9G?=
 =?utf-8?B?bVhxYTVmbEJiRCt6N2hZL1pKbzV3WFFjcU9ocWJ6VGNvaWZTaFBlOXNZRmE0?=
 =?utf-8?B?d0MyejJCVExnUHFOQWk1eWhKa1RSNWF1dStZbmNBLytsSms1NTJ2ZHFabUxx?=
 =?utf-8?Q?IoRgzMcLWkR8P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG54SFlKbm05YXVqbDFvSTM2aFJNSDI3OUlsTXRxeVg2aGNuZ2NBSGdRS01M?=
 =?utf-8?B?Q1Z6K1I4Y3FXMFZFcWhWQ3gwMG5mSkd4WDRkRjBaRDdZejVnWXdsZnBNbXRu?=
 =?utf-8?B?OVM2eXc1N1l2cG5GaVlsMlVVVFZqYTBITHRhdFk5WStiOCszWmxLT2U3eXJ6?=
 =?utf-8?B?NlF2L1FjaFVlWWpVM3p5QUtHcDUvS055Sm1QN2gzT212aXZmYytYbHZndCtM?=
 =?utf-8?B?WHJBWjBqSlpxTjBlSGRWZkpwenBCcWNONjZZdC9Oc3hUQTNseE0rYk9GRFhF?=
 =?utf-8?B?QU51eTE1enIySjBrNmwxb1QwYUp1S0dIOCswNDVad1BCS0VRemxrRFNwNy9X?=
 =?utf-8?B?TmlUMlhlaHg4MGwwZURMcGpjRFlBMUw3a1RvZ1krZ0paVXovZ3FOeGVsK2Ix?=
 =?utf-8?B?S05SdkY5VGs4L1ZhSy94bGV1dWN3RW51ZkJwUWRtWCtJYk1CR0NaKysrQ1lP?=
 =?utf-8?B?WVk5dlh3VjVNWGVBZnZRVE9kN2gza3RHa0Z6NmdtcTJjVjM5eERUWURXNGx2?=
 =?utf-8?B?aGxLeTBRWlN3NXJaVGNmeWNvNHh1NUZnWCtqL1RMdXpaV2xJbStyWkl6Vlpk?=
 =?utf-8?B?eGlCN3B4ZDNNNVR5L1VBR1dXd0JRV05vTHc4Qm1XSXRjMUlLeEt5NnVIbHdh?=
 =?utf-8?B?MzFZUjBYZFpaak1TUmMwL0duNzFJbnMzaU4rWWFsNnFJRmJCNTQvRTZPamhO?=
 =?utf-8?B?bWJtQTZ3L2RVRUROcTVSMXBlMEpHQzY5T3RYelNRWnRDQ0hPSnhMVTc2MnFE?=
 =?utf-8?B?Y05HMU1FMnRlRFZCMzR6c2lqamxoNEJFTHpHVm9WQjU4UlhyOXU2NXVwckxG?=
 =?utf-8?B?WGV3M3ZtOVBJaTRqMGV0ZWRvK1VWR2gvY3hiL0ZtZnRuaHBpNHVCWUEvUXZs?=
 =?utf-8?B?Nm1kc0xPYkNYQVJBUHJaNjV0NVp2K3BlaVJISEZwVFU1REREdEJvN1BvV2NX?=
 =?utf-8?B?Zi95cG1EUXliSURxUzJpcHVXdG1FMHROUjhKN2VHclhrcUZoV2JoZXF4M2p6?=
 =?utf-8?B?d01Ob0xRTmpkMm1JNC9LTEk0bHE1NVRiRmlsdmQvcHRjOTdhOXF6WnoxSXRL?=
 =?utf-8?B?OUVVTllRMXFwemMvUVA5bnVySTdEQzZwOUpvQ0d2T1diUlpIdXltMElXcmNX?=
 =?utf-8?B?MTFzNzlDK2JvUUN0YWhKMEVBcjN4M3dUQ0R0dFVsMUJ6U3NSYmZ2Rlh2OFhW?=
 =?utf-8?B?ZFdGMUlmYTFkYkpCOExQYTh1OHprdUdGVnIzeTMxblVkMTltcUsxQTJ1czl3?=
 =?utf-8?B?Z0tydlpjd04rcHFsVm5jR1RrSGpsOVpVQkh3ZUQ3Qy9JSkVqdkpaeU5kNFRj?=
 =?utf-8?B?dGlJV2QwbWJjdUdURytlQkVzOWtkSC91SFErQ3N3WVFhdGhVcFc0VHlHdlR6?=
 =?utf-8?B?UVFXamxpK1htOHc2S1IvaFZKWktPQ05XM2RaMTlEa1g3SlhZZ2dYeU1LQ1lR?=
 =?utf-8?B?TVZiQ0NtWmZLdS9NR1ZiMW0rbWxPK0hKbk5MZkhORHp2M3JoV211K0dYZDZZ?=
 =?utf-8?B?QWVuclV0WFZpaWZqbzl2VjhCaUpCamM4K2FUWFJLTWZRamxxTU9zN3h2Rkk1?=
 =?utf-8?B?cUsyaUhxcWJPem9oSWRqMmFOcUJnUGgySFFoMnI0SlVhVCtjdlcxRnVvQ1M1?=
 =?utf-8?B?TzAwUEEwR2NYUFhwUXpWQTlVYVZtZlpqcXM1QkdOckNLRmxRem83cTBKcjZM?=
 =?utf-8?B?anZKVFhOU3ZKUDlBYm9YbWJlQ2xZcmJkbEJjYjIyZ2RnV3RRMGgyN3Ardll5?=
 =?utf-8?B?VERqdk9HUTlhMExSV01kOG9wQ2FKWVcvUHlzaXQ0bXI0cTlNUDJsZVE1MXhF?=
 =?utf-8?B?cnB1TWN0U0tzdXNJTlhQc2FEbkxiN0RKVzVCQjdNTUp6ZlpydTYwU3EwNnp4?=
 =?utf-8?B?RlRmc0I4Vll0by9pOFlQRzJ0NWVkSG85NENkK0p5RkZqM0NtdDFock1Od2pa?=
 =?utf-8?B?citHTEg1aUYvQW1jbElUbkpaNDR2MHBNRXgxaFlBSTdqcHF2N1B6WmF4ZHRz?=
 =?utf-8?B?aVFad0pONW9UQ0RkT2tXNVV4MzZpSFVFQnJkZ2YxcytrbW1WL291RXp0MFJW?=
 =?utf-8?B?Z0s4c1hBWmUwUHBqZVdmT3RoT0taMktXckNkcjlvVTh2bUY3ZFEvcVhsb1NJ?=
 =?utf-8?B?QUVEVmdLNytpaVlHYngrT2NYRUc2eTdPcThJemhTa0h1NlpvVUJIcmdaNkdp?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j+Cz6sMpqzvjUu1DnmeQ13k3FqD79wd/8Aq9GOLx2uPJw/0SwCERdTBE4xRkWUhU4rnSwwg4jXFCUvz/cYx3+bBhjDs5V/bH3ulme0AUezjmM5VvcHPSSdzEEJKmx6flcvSTFsM7E7qEYWXzzgvSV5sCiZ1zGrZ1JF+SP3bwNBC6Uux5vXCxJnSYMLJj6O3stVhlvXMXuoVs3hVkwoO4ORBP1+OpR1mySXmi2qPhQZtaGgnWeq7EwY0a9fKUWjrgkq5ARHmj/rlt1kNLRh79oT2CPgSNkVNMaVUEkIELvXOO/GAnMzMRI8iuCk+DdObcH6T8a22S47y4LXSV8OIjQCYlfVXcbSMYo8e6bNF1r8ZMsoUeqZRAyAl4j9pjd3aVMa75wosWzwO3u8rvV633OIFWllhknOoE0zVjfOfjetxtYf00SomW2s9RMn9XFpTeGeIKN6IBcmyRu7MXw+nTMq2p9lDfW9/3gWM6AC3N/8w8xtxKSq7/7FkD64la+WRUBIL/J9HU70bGOTTbY9WSwz/tKnko3VcJHQnjoidM9WA70JmAnXRMZDrsVMrDV8UqOSGRl67nlXiTIwkN0GkEPO8Whwco/GrOeJihGuGapYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd690caa-2e03-44e4-733e-08dd3bba4b51
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 14:29:07.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+2Z8CdtUevUIvLP2ZcnVkFDaRDLdUSEyczPaPdxOiSC08O+FdMx/OHKBTjheRPkYTCX2n1zoQBK7UM5FPpQWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501230108
X-Proofpoint-ORIG-GUID: dvyRszcyUB8DTJaQKPb1fiYeG0rp5hj7
X-Proofpoint-GUID: dvyRszcyUB8DTJaQKPb1fiYeG0rp5hj7

On 1/22/25 5:16 PM, NeilBrown wrote:
> On Thu, 23 Jan 2025, Chuck Lever wrote:
>> On 1/21/25 10:54 PM, NeilBrown wrote:
>>>
>>> The nfsd filecache currently uses  list_lru for tracking files recently
>>> used in NFSv3 requests which need to be "garbage collected" when they
>>> have becoming idle - unused for 2-4 seconds.
>>>
>>> I do not believe list_lru is a good tool for this.  It does no allow the
>>> timeout which filecache requires so we have to add a timeout mechanism
>>> which holds the list_lru for while the whole list is scanned looking for
>>> entries that haven't been recently accessed.  When the list is largish
>>> (even a few hundred) this can block new requests which need the lock to
>>> remove a file to access it.
>>>
>>> This patch removes the list_lru and instead uses 2 simple linked lists.
>>> When a file is accessed it is removed from whichever list it is one,
>>> then added to the tail of the first list.  Every 2 seconds the second
>>> list is moved to the "freeme" list and the first list is moved to the
>>> second list.  This avoids any need to walk a list to find old entries.
>>>
>>> These lists are per-netns rather than global as the freeme list is
>>> per-netns as the actual freeing is done in nfsd threads which are
>>> per-netns.
>>>
>>> This should not be applied until we resolve how to handle the
>>> race-detection code in nfsd_file_put().  However I'm posting it now to
>>> get any feedback so that a final version can be posted as soon as that
>>> issue is resolved.
>>>
>>> Thanks,
>>> NeilBrown
>>>
>>>
>>>    [PATCH 1/4] nfsd: filecache: use nfsd_file_dispose_list() in
>>>    [PATCH 2/4] nfsd: filecache: move globals nfsd_file_lru and
>>>    [PATCH 3/4] nfsd: filecache: change garbage collection list
>>>    [PATCH 4/4] nfsd: filecache: change garbage collection to a timer.
>>
>> Hi Neil -
>>
>> I would like Dave Chinner to chime in on this approach. When you
>> resend, please Cc: him. Thanks!
> 
> Sure, I can do that.  But why Dave in particular?
> I would like to add a comment to the cover letter explaining to Dave
> what he was added to see and I don't know what to say.

Dave helped me with edead3a55804 ("NFSD: Fix the filecache LRU
shrinker") and a few other related fixes, and he is the original
author of the list_lru facility (see a38e40824844 ("list: add a new LRU
list type"). He might have additional insight on whether the filecache's
use of list_lru is salvageable or how a replacement of that mechanism
should work.


-- 
Chuck Lever

