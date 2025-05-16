Return-Path: <linux-nfs+bounces-11775-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14786AB9D9B
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 15:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DD91BC13C8
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 13:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE84CE08;
	Fri, 16 May 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I0yarPZX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p0dZtc2a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5892A1AA
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402535; cv=fail; b=Y8DYCC7sNrHr2dvL4ozEmtaaMnW45tdlnSQf77LYinUWVHeG5jE2t4zIycRe/afR3ksnQgjtOlDyZh6/AtCmMy5G4BuLwmbCUd46bYYJZuUX1GvLTvQX1FuYDFY9dr9GGmZd/x9r3gzZo/pvvtFqmQcggYf7hpKoJCopQz00zt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402535; c=relaxed/simple;
	bh=UN5DV3xM9oY4txGkBc47eqlm41Xjm9h/lZpRdW2wEGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qh4KMs99D29hhMv0E7yeJfHnhRdHey3lxOZss8/Wmh1+cUzCpQY7NHyYOnU9CG/qfBU2W2CU9s1Ohkvzyd9jwp69jbnHOdH2wJ37HBcRnsOWt3CL1euUHUXbB6miyIBsChsWd7YrnqI+oU3DY2svuOZTBVXn5CdjQXwUVmsOI2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I0yarPZX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p0dZtc2a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GCg0eB018656;
	Fri, 16 May 2025 13:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=39YSi2lqG+0XIO08xiBzLpJXz+5hfM9H6u2nS6UpelA=; b=
	I0yarPZX5ltMsSbLVRgWpmZEDoAs503DcVmD6wrdc+pi9MlUPl8tx9w30vkSNVs/
	HQdJlUMzUfI38fBaqHexaGV2l2fahE5OvK78EDbElHQi6YMRNc7LeBNuvGGzfkmm
	fdPMPAvHHiKHqGWhwKucIHAdFT1ombVr/x0KlpUu+cYl+TI0rLj5pNeokCn1b5RP
	q0I+/yBLDn2Ja5dbgE1HekTzjWq4YexPO8PkdApZ8wvEUKe13zijfRLGujOBajaZ
	Sj8IX1trUkHHdJTJIA0ZRrvw7awH0WsdCmnEdL6oqmJfFpL3alZF4g96vaetSzXN
	eVZiLE+bEjDXWob5U1DWdA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbdhd48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 13:33:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GCAFaL004590;
	Fri, 16 May 2025 13:33:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mshmtse3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 13:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COz7fxbBNrmES9r8jqjEdx4OM/LSjANRqVDKan0232bd/45LBuB8n0mBB+cJeWwwr/bnKx6ups3xenQGLIVCF8B0EdM+yvM4PBNbw44LS2RT4el1eBYDPx346vxIsu293cVn2NQjIsfK6rkZIfqkcsv48Wapa6b+duDCsdG0EMZ+sLuojx8qExv1ot1qh/7iUSDXCyRzUmj9TfKD0CKPMnPmN5fQiOXtfkVTkHM7lBX2WFBI4zQCWaDbUvdIfVASkGOoWc7tbGv5F5HBTAA8R817hD48ckoBzQ60s2tdLH5gFYZzM2VQYbi4G1OP+FfqFzkDd0BRP8Hu2OkVnhcclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39YSi2lqG+0XIO08xiBzLpJXz+5hfM9H6u2nS6UpelA=;
 b=VUvRTcvnmdCogceZRJhd/1SmvyDdgpY8+cqud57MxmkPT8/MmLuIMu8Rh/r4a9aavv1XXV6KWb/GUJbXlQowP3mgckIBT2CJZ5YuCyefR8eFJ2oAk/42vx09ZfzqlVVVlGs6NIqTJDQl8x6eZdEWybzBVA+rsKvFS1effnnmdUP0uzZFrZ8kseM7ZksirgrKzCmAkNXtX6GqvTcQqWmHMiykmhdYYbCweXxjGz+VoBv+npDQI4XUjIxv6kXB6B7x6SpeNSpCOgjP0YA3CydcL8JoOGn80UkmBOd9ftk6XJLfNdb7WwatBeVid1CTJNoXICKRKd3Y57SIZu2TUIiGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39YSi2lqG+0XIO08xiBzLpJXz+5hfM9H6u2nS6UpelA=;
 b=p0dZtc2aKNZW2QdJdXcNJnnOyeFQaxfaZcMvP9yg/GeEg5VtXqPerWLLXAJTq6jgDwNqAxnPXmWvv6161i47CLRDEezUxrue7h1eRheAbydf+ws8cAtKYQb4RBxh0TBm8Fln+tWutvboPCYk+P2jOhDbytz/TEJQCADxWOl5HvU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5770.namprd10.prod.outlook.com (2603:10b6:510:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 13:33:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Fri, 16 May 2025
 13:33:18 +0000
Message-ID: <a2cdc233-4a3e-4fe4-906c-aa87e4f620a6@oracle.com>
Date: Fri, 16 May 2025 09:33:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: non-stop kworker NFS/RPC write traffic even after unmount
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
Cc: Daniel Kobras <kobras@puzzle-itc.de>,
        Linux Nfs <linux-nfs@vger.kernel.org>
References: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
 <2c1a60a7-051f-4952-84fe-c3a4b6b0327e@puzzle-itc.de>
 <42c84eb6-ede0-4e68-ae70-334365e2ae7f@esat.kuleuven.be>
 <62cb66ff-b718-4369-a7f1-fd3bb01a7b16@puzzle-itc.de>
 <4d4f781a-d668-4f49-9cfd-2e9e94a8cb71@esat.kuleuven.be>
 <b8f4f808-48df-4659-9afb-2f9994b22e7b@esat.kuleuven.be>
 <8abc8a16-cbdb-4285-a2da-62f57fbbb165@esat.kuleuven.be>
 <9c446dc2-fe2e-4bd2-9ad5-f4015b0e2ffa@esat.kuleuven.be>
 <3c1acadf-b2ed-42b8-926e-662df5a8aa4c@oracle.com>
 <547993bc-80ed-47ee-b1b7-cbe83da1eae3@esat.kuleuven.be>
 <c8f5e130-f837-42d4-be8c-1b26eaec587b@oracle.com>
 <e37b3b0c-f9d0-40c7-b116-488fa93b68ca@esat.kuleuven.be>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e37b3b0c-f9d0-40c7-b116-488fa93b68ca@esat.kuleuven.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:610:118::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: aab96e41-1098-475b-4a89-08dd947e37a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmFZUlMvV2Z3VHlzS2psSjE5bks1eTd6YktmbHRvWkZFNXpqdUtjMUljZ0Fx?=
 =?utf-8?B?cXBvaWdyVmpMKytuTWNZYnMyeVZRZDZ4Zmp5ZHhCQ21Ib3g2S3Y3TGphT2ZB?=
 =?utf-8?B?cFRYZERUcFNKY2NkaW9VS09sajJoUFFBeEZnMFBFQVNUdjB6T25XdnRFcVQx?=
 =?utf-8?B?NXNSS1ZLN0Y0cWxzMTJCcStjdnVOdGNaVHFCaWRsa0RnQjh6amdKWmpZU0xO?=
 =?utf-8?B?M1hiSThrQ2U0N0NYOFlMWGhMeGdidkJCVHRJbncrMUxBNS9ENEh2eFZyb0w4?=
 =?utf-8?B?V29na1YrWG5FMUhuMnVtTUxNamFrbmFNeVFjbWovZFk0cUdDNnhPbitJNEpp?=
 =?utf-8?B?Vi9acHZYeXJocUdyYkVnQVJXRlYyaXhOcVlYMTZXK05ubW9nSWtmU2NPMDBv?=
 =?utf-8?B?Y05id2NYd3F0SGowZDROenZtV3NXY0dQdTAzUzhnYkhnelRocWkvc09TSE5M?=
 =?utf-8?B?U0tqWG8ranF4RVhDcDAwTjRDMHQ1c3RCQy9USVdQWXBCRHJLdTRIS1RBSHJz?=
 =?utf-8?B?QXdWcmlSdmt4bmlDL1ZMdXNwWFp4TWF3aUZxSkw2Y3V6K3BQZldxVTVRbU96?=
 =?utf-8?B?WGlnd1YyTXRrQ2hYZkg2M1UzTDVxSW9wWTM0aEhSMEwwMFh1VURjdUh2dUkr?=
 =?utf-8?B?c0h1dkZpT214bjY2ZjZySWtkOWYyWDdCNXR4cTNuS2RyRE5WemZHVDZDSkpq?=
 =?utf-8?B?R041eFFqN0xZTmlhbDNCekxjRGJ3akFOUUJtNGEwRlBtYTFiYXlSUlI0Qk5S?=
 =?utf-8?B?ZnNMOWJkZXExbFg0V2JNalozYmV6VnErUUFISjJGSWd6Q0xXSTh4TzdEa2Vl?=
 =?utf-8?B?MnIzYnR2MEdBYk1waG42NHBmbDJ6UmRpcE1YYVBFUVJ2MHozWDdRZzJqL21W?=
 =?utf-8?B?NEVuV0Nja3crTVZza3hhL1UySUh3NXF5UjFZcGZTb0hrcUFxUkVIQWdUM1Nh?=
 =?utf-8?B?L2w5d3hlL3dOcW1EQWd3WkorcFNEWUowY0t2QmdJeEVDZnVObVdPdVh4VnNv?=
 =?utf-8?B?amp3cFlqUnNBRDhsUTRmdmFxS3doVDc4RHVDMzFBdi9henNsU01XL1d2WnJ1?=
 =?utf-8?B?MEE2eWF1THcxWjBTZ0lyRXI2ekowNnJVVGp0N2xiOFlGT09mOTh6R0JXbkFl?=
 =?utf-8?B?a1FNa3FjNlJzc0I2Q3JpUnptSzI4SmVoU2YxMTIzU1RKY2RndVZxV21EVkNk?=
 =?utf-8?B?RjBISmcyR2NLekFoa1hNY3JYVnZGLzc0eHp6amhIUmdFc0RDVEIyMUpNNWFM?=
 =?utf-8?B?dUQ4NnhnZG1RcnM1WmNsNTZKU1ZpQnpyZmo0WTJiOTU4SmowaW9SSmVYM0pa?=
 =?utf-8?B?aW9EMUlqL2xveUZvVUd3OVJncEQrVE9oZGh0Q1lyaFZnMURIeVdpQzh1TmI3?=
 =?utf-8?B?ZHJ4d3BCVDFNMS9aNjBGRHZ4S0JOVUpjUjhpb2gvYkh4LzF5ZTB6d2owVlBa?=
 =?utf-8?B?cFpwZTY3dG43R0hyVkFUSjM0S210cnJmQlBlNTZtRUgvRFVvVDljQzlDTWxL?=
 =?utf-8?B?dWZuL0pYNXladHg1dXVNTzFxN2NkN1o5Q3NTeEV3Y0wrU1FUVy93ZFpJWFVk?=
 =?utf-8?B?V01DYS8xK2pMSlJEMThhTnZvY1M1clJuWnJ0LzBXV2N3TlFhTjFFZDVneFJk?=
 =?utf-8?B?MjlwL0FLV2ZsTjRMbjYwZHdBcDgzeUMzeSs5WVFSNytMWlRnU3JGa3hXYTVz?=
 =?utf-8?B?Vy9Na0VTc1FlQzBETzVQeEFqVTVUSEN5cit2ckNpVmVTSERZcldFZ3Y2aWVW?=
 =?utf-8?B?YWpXVGs5MjlFL3lXU01nOVhZL1BIZEluNkpRWHJRbkZ1d0l4L0hIZ043ZGFv?=
 =?utf-8?B?Zm1kSGNPWEdnMzc3aWF0ZU1CaWkrVmpzTXdQWDRWc05oL284aDFvK1hqRjNy?=
 =?utf-8?B?ald3Z1UvaGJ4ZXlURE5wREVsMGY4TnY3RjlkNDgyQ1daWjRhM0pBQkltQUdG?=
 =?utf-8?Q?NkNTRYdByNo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emh1RExEQllpMm9mcFNqNTNGSzQ1UHpocmtOWXR1NWZlN3QxZ3p4NTF1dlhu?=
 =?utf-8?B?citycWxOalVQOTNSU0c1VHkwTVI3U0lac1JvUlZDcDZJbG9RSDN4b2pGNG1p?=
 =?utf-8?B?OW1ybWc1SU82WW5BZkQ5QXVvTGl5L2I5YTVZV3JvYW5XQ1ZESjlnSGFMTTJM?=
 =?utf-8?B?WFRhck42d1ZIWjJhMG90S2RmN2tiU1JnSzlCNmdPRm13OEZXTXdIQjdwUzhR?=
 =?utf-8?B?YTZEeDkva3RIamVCbytDaGg2a3RyMjdSK0UyQjM5L3o2c2hrckxQaWh3ZEZ0?=
 =?utf-8?B?SEQzcXNLZitKQTd3QXZ3NVhuTVJZNi9oVC9zNVEwNHdRSm5JaytGMjhXQTZF?=
 =?utf-8?B?SllMd3I3RUhhc3Vma0Z6UXlicmE5NHRYbjVhLy9lUzlsMGYvSTdLVWVGSnRR?=
 =?utf-8?B?bklSTjlNaTlIM3pQQ20xaXJxMWpjbjdTZnc2SVZyU0lsVllOY0ZkSzFrMmU0?=
 =?utf-8?B?OWxsTTFTR0xCYkhpeEJTckdiajlDYnQzcDFZcXdRME9vcWFBSllybmlQMGZ3?=
 =?utf-8?B?SlBCK2tGK2IyTmNGUys3b2FoaVU5U2lvZG9ua1NTeWVFbHM2algxelkwQ3lU?=
 =?utf-8?B?RXg4dGpvSGNYOHZtbTdiYWtNeGVxUEJSME9tbkdOZVNpL2FGRHN6ZlVzQStj?=
 =?utf-8?B?WkZQRVU4TjhHQ00vWnhzZGpKZVBsNHFkM3kyY2VQL2N4Rzg1ZFpUUzhJMVhD?=
 =?utf-8?B?UlhlZVVrQ2ZLT2hWek5sUUdaV29hd0RWNGJQWk5QOWoyaWsxRE1XWERscWlI?=
 =?utf-8?B?WTF1clRjeXFCKzJFZHFXM0ZiN1liYStSMzc5U2NSVTBSWFBOSTAvZmgzR2lv?=
 =?utf-8?B?K285K2VxTlRvUUkvZlJRMEM4THVGa09OS01McVhHeElOT0xjRHIybTE2d0RQ?=
 =?utf-8?B?Wk93Q2hmT0trRTZtSEp1Z2QyMzkrVU84T0srdnhKVWU5OVpnV01aOTlPN1dZ?=
 =?utf-8?B?MGVtZjZMRllvNVR6eWdhbC9xUU9hRktKMWkvaDJobEMzVkY5T05MMkNWa0E3?=
 =?utf-8?B?cldDc2g5dTlUSjZEbDdNM0oweUd2WXNBMFByVmdzZ0Z1UE9NY050MDN1blNz?=
 =?utf-8?B?enhqb04reERjekM1a2pSNGpwRC9ENm5BYjlsaElrblI2Z1BWRnpBNHNDWDR1?=
 =?utf-8?B?R2MxSEEwY2IxNmJXcUJMWnNOQmQyK2VzV2hUSDduTDlQaW1Hc1o1eXZWNWNm?=
 =?utf-8?B?aVNyV1NIUmkzdDZldEhIR3lVbWJ6MHRCSFY0enlyOXRkUFp4QkgwSmQ4WUlO?=
 =?utf-8?B?Y0dISnpjVUUzcjM3a3orL1pKZ0JrL0s0YVV6RHFNODYrNjh0cGJCc0ZNUk1w?=
 =?utf-8?B?M1FwakdtU01OL3FoR0dhUmt0WWw1YVBJNWh1Uy94cXR1Y3FweWpHL1NDQ1dG?=
 =?utf-8?B?S0ZMWncvRE5lbVIrZGszcEhvbnc1K0cvTHhQbmIvajkrTjg5b0FvV3lRMWpl?=
 =?utf-8?B?NkhBcTZZN0Uxd3Y4Z0lLWTdjOG1XcjR6RnNUdDh3eEhQUk1LTWtrUWVqRmNG?=
 =?utf-8?B?STZVdEVJbEZlZUlERkE2RU80RElVQmR3M1N2eUtJNVorYmV2MWV1c3hrNURo?=
 =?utf-8?B?NDUyVkZrZkhmcTI2SlVwS2Jab1NRTlRBZnVDeG5KRVA4SlpJV0tsL0p1VS96?=
 =?utf-8?B?SkpTOEw4WmVaZXUzWjBlV2pFT1ZWTnU1d3lzdzhuVUVHUTB2bk5oRnB1dkU3?=
 =?utf-8?B?VmpkRVI0MXJoQlFNcm1pUWR4clAxRU1kcTcxUk5TM2ZQZHpBdmhaN1VlRkNP?=
 =?utf-8?B?S2tETEM5QkM4cVVKbEhXdWIyT1R2Y3VJTjhGaUFKUWw3d3JSclczbEhnMWdX?=
 =?utf-8?B?K09TTVp3cUlCSFJ6SmhDMGpraDMwK1l3a21FZHYvVHA1bTZ5dUc0cDAzRzc5?=
 =?utf-8?B?MmVoYXBveDViZ0VDSjlOQ1BvLzJDNGhoQXBKMXR0OEVNdTBQbUJyck1lUGJR?=
 =?utf-8?B?emhDZnYxVnpUZVcvQmFZOXk1TXY0eWdGWmQzekVndURzcjhmTUhkTHpZRGRW?=
 =?utf-8?B?ZDdvUGpWVXU5NTFCbitvYnBDYWl1aER2S0o3cjJOVnpyRmg0VVZzdFVWQzRj?=
 =?utf-8?B?LzNEeWQzTHF4K0RaeXJNdWZvaXJBejBzb2NidjlJUFMyb0lnME1FYURSZ0Ju?=
 =?utf-8?B?cGYvdGJ0UHNVMndhQ0dQV3RvYUJVQU9QajJUaEIvTmtIR2JEVWo1Q1FHV3Rx?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SdKlKoh3JOpVFp+X2IlnY6yJutZCXtcO5z9j6bVEhY71RKlWodLMITkxMHinsWlqLgdIucUaJzcnaFyU6WZz+Fy8hdG5ruZBJkk8+4d1XyV/qWzgbi6NXVwxBT1J+soYTm5pvfYXBazRaPSUTuXeIjIGS3nlP6RrBU2lXyAN51sZ6PPOjItUMM9o44/jJn0bmUZxNPxBohBPVyp41nQIlo/qvXeDAKXeUMjoEOq3fdPdKfZha9GddSh73CdHXu6R0gUXTWaeIvUO/96kKXT8/iLb6NNmiwWFLxQEDeczEM6V8CN4rqVJ0LErWBgu5vm+tzvn2dTjoXIy8AMX6tMdlCoKoIQ/S4lNy3K3geGkE0YtYA/4zZS7GHkodBf+RLZSYXIoyeGr8IYVtFsbH1QPWf7CYitB0zHPCW3Vnr+qREWJQMYjDGff4SR+2PawfgMmKZbp/WXrYyiewAOatEmwGWoV/8+v6xG3vF+RtNolD6Wx7v635auhSs5Jo7ql/kqMsUWpJYIZwInwNuqrBXhgcy5DG8ZERoqbploDacBm/QKJBQ1fHG3yMu80001KDTvbznKfMPjjTipox2rkwYyfhG3bmigJV2MRQzYiwcVorJw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab96e41-1098-475b-4a89-08dd947e37a7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 13:33:17.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTQkGtKYpsPNCWrm0Atln1YFROiW0PLaCFX5ra3uimWdbjgc51xtqrgB8+N/KGMJzGoaUhOre0ati5w6ErkBiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160130
X-Proofpoint-GUID: VXrcMOYPyOalMPGX-i3naFZ6crUksP0s
X-Proofpoint-ORIG-GUID: VXrcMOYPyOalMPGX-i3naFZ6crUksP0s
X-Authority-Analysis: v=2.4 cv=G/McE8k5 c=1 sm=1 tr=0 ts=68273ea2 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=cBPnGxsydAFukLISLhQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDEzMCBTYWx0ZWRfXzXrNsvHLClm6 8WTjwknLlOtHWgL07QMfCzWbv1wcxVKt6lxFvqJGNMCuY87D9iUj6fVZu/3Joy0gMOonCwRjttb cpnUSOFdAhNedm0gg+wX32CXFpvCwfqOdoiBqzz6cUPTXUy0/U6qKmEnYjQn/DPmq2XUGUd/9nc
 3A2iKj+1S6tICNFCxcPPSll7modDa8swyHO/mLoSCFq0sfs/mFI+R1R+lA/rH1Q8Yuf3qiaeXCK IoSJu+r04G4BenP+BDy6gxh8R2BVeHDxGy1PZr2LZ29G1054YVZVcNxbZNI0U+b1HKVDB6QAQ7H sXLl4LgxA6ldidzRUV0bL/ttMPmkjTw0ZDOL84VMplBbpSLXv36j40xt7tsz+hm5smy4ogd2MRT
 F/lGj1eAIynPnGCEOEEitIE1Qc73Yl0Mh7Bsb9vOj1Op8zmHMTlOQ0GBHYs4OCU159FcPaG3

On 5/16/25 9:09 AM, Rik Theys wrote:
> Hi,
> 
> On 5/16/25 2:59 PM, Chuck Lever wrote:
>> On 5/16/25 8:36 AM, Rik Theys wrote:
>>> Hi,
>>>
>>> On 5/16/25 2:19 PM, Chuck Lever wrote:
>>>> On 5/16/25 7:32 AM, Rik Theys wrote:
>>>>> Hi,
>>>>>
>>>>> On 5/16/25 11:47 AM, Rik Theys wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 5/16/25 8:17 AM, Rik Theys wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 5/16/25 7:51 AM, Rik Theys wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 4/18/25 3:31 PM, Daniel Kobras wrote:
>>>>>>>>> Hi Rik!
>>>>>>>>>
>>>>>>>>> Am 01.04.25 um 14:15 schrieb Rik Theys:
>>>>>>>>>> On 4/1/25 2:05 PM, Daniel Kobras wrote:
>>>>>>>>>>> Am 15.12.24 um 13:38 schrieb Rik Theys:
>>>>>>>>>>>> Suddenly, a number of clients start to send an abnormal amount
>>>>>>>>>>>> of NFS traffic to the server that saturates their link and
>>>>>>>>>>>> never
>>>>>>>>>>>> seems to stop. Running iotop on the clients shows kworker-
>>>>>>>>>>>> {rpciod,nfsiod,xprtiod} processes generating the write traffic.
>>>>>>>>>>>> On the server side, the system seems to process the traffic as
>>>>>>>>>>>> the disks are processing the write requests.
>>>>>>>>>>>>
>>>>>>>>>>>> This behavior continues even after stopping all user processes
>>>>>>>>>>>> on the clients and unmounting the NFS mount on the client. Is
>>>>>>>>>>>> this normal? I was under the impression that once the NFS mount
>>>>>>>>>>>> is unmounted no further traffic to the server should be
>>>>>>>>>>>> visible?
>>>>>>>>>>> I'm currently looking at an issue that resembles your
>>>>>>>>>>> description
>>>>>>>>>>> above (excess traffic to the server for data that was already
>>>>>>>>>>> written and committed), and part of the packet capture also
>>>>>>>>>>> looks
>>>>>>>>>>> roughly similar to what you've sent in a followup. Before I dig
>>>>>>>>>>> any deeper: Did you manage to pinpoint or resolve the problem in
>>>>>>>>>>> the meantime?
>>>>>>>>>> Our server is currently running the 6.12 LTS kernel and we
>>>>>>>>>> haven't
>>>>>>>>>> had this specific issue any more. But we were never able to
>>>>>>>>>> reproduce it, so unfortunately I can't say for sure if it's
>>>>>>>>>> fixed,
>>>>>>>>>> or what fixed it :-/.
>>>>>>>>> Thanks for the update! Indeed, in the meantime the affected
>>>>>>>>> environment here stopped showing the reported behavior as well
>>>>>>>>> after a few days, and I don't have a clear indication what might
>>>>>>>>> have been the fix, either.
>>>>>>>>>
>>>>>>>>> When the issue still occurred, it could (once) be provoked by
>>>>>>>>> dd'ing 4GB of /dev/zero to a test file on an NFSv4.2 mount. The
>>>>>>>>> network trace shows that the file is completely written at wire
>>>>>>>>> speed. But after a five second pause, the client then starts
>>>>>>>>> sending the same file again in smaller chunks of a few hundred MB
>>>>>>>>> at five second intervals. So it appears that the file's pages are
>>>>>>>>> background-flushed to storage again, even though they've already
>>>>>>>>> been written out. On the NFS layer, none of the passes look
>>>>>>>>> conspicuous to me: WRITE and COMMIT operations all get NFS4_OK'ed
>>>>>>>>> by the server.
>>>>>>>>>
>>>>>>>>>> Which kernel version(s) are your server and clients running?
>>>>>>>>> The systems in the affected environment run Debian-packaged
>>>>>>>>> kernels. The servers are on Debian's 6.1.0-32 which corresponds to
>>>>>>>>> upstream's 6.1.129. The issues was seen on clients running the
>>>>>>>>> same
>>>>>>>>> kernel version, but also on older systems running Debian's
>>>>>>>>> 5.10.0-33, corresponding to 5.10.226 upstream. I've skimmed the
>>>>>>>>> list of patches that went into either of these kernel versions,
>>>>>>>>> but
>>>>>>>>> nothing stood out as clearly related.
>>>>>>>>>
>>>>>>>> Our server and clients are currently showing the same behavior
>>>>>>>> again: clients are sending abnormal amounts of write traffic to the
>>>>>>>> NFS server and the server is actually processing it as the writes
>>>>>>>> end up on the disk (which fills up our replication journals). iotop
>>>>>>>> shows that the kworker-{rpciod,nfsiod,xprtiod} are responsible for
>>>>>>>> this traffic. A reboot of the server does not solve the issue. Also
>>>>>>>> rebooting individual clients that are participating in this does
>>>>>>>> not
>>>>>>>> help. After a few minutes of user traffic they show the same
>>>>>>>> behavior again. We also see this on multiple clients at the same
>>>>>>>> time.
>>>>>>>>
>>>>>>>> The NFS operations that are being sent are mostly putfh, sequence
>>>>>>>> and getattr.
>>>>>>>>
>>>>>>>> The server is running upstream 6.12.25 and the clients are running
>>>>>>>> Rocky 8 (4.18.0-553.51.1.el8_10) and 9 (5.14.0-503.38.1.el9_5).
>>>>>>>>
>>>>>>>> What are some of the steps we can take to debug the root cause of
>>>>>>>> this? Any idea on how to stop this traffic flood?
>>>>>>>>
>>>>>>> I took a tcpdump on one of the clients that was doing this. The pcap
>>>>>>> was stored on the local disk of the server. When I tried to copy the
>>>>>>> pcap to our management server over scp it now hangs at 95%. The
>>>>>>> target disk on the management server is also an NFS mount of the
>>>>>>> affected server. The scp had copied 565MB and our management server
>>>>>>> has now also started to flood the server with non-stop traffic
>>>>>>> (basically saturating its link).
>>>>>>>
>>>>>>> The management server is running Debian's 6.1.135 kernel.
>>>>>>>
>>>>>>> It seems that once a client has triggered some bad state in the
>>>>>>> server, other clients that write a large file to the server also
>>>>>>> start to participate in this behavior. Rebooting the server does not
>>>>>>> seem to help as the same state is triggered almost immediately again
>>>>>>> by some client.
>>>>>>>
>>>>>> Now that the server is in this state, I can very easily reproduce
>>>>>> this
>>>>>> on a client. I've installed the 6.14.6 kernel on a Rocky 9 client.
>>>>>>
>>>>>> 1. On a different machine, create an empty 3M file using "dd if=/dev/
>>>>>> zero of=3M bs=3M count=1"
>>>>>>
>>>>>> 2. Reboot the Rocky 9 client and log in as root. Verify that there
>>>>>> are
>>>>>> no active NFS mounts to the server. Start dstat and watch the output.
>>>>>>
>>>>>> 3. From the machine where you created the 3M file, scp the 3M file to
>>>>>> the Rocky 9 client in a location that is an NFS mount of the server.
>>>>>> In this case it's my home directory which is automounted.
>>>>> I've reproduced the issue with rpcdebug on for rpc and nfs calls (see
>>>>> attachment).
>>>>>> The file copies normally, but when you look at the amount of data
>>>>>> transferred out of the client to the server it seems more than the 3M
>>>>>> file size.
>>>>> The client seems to copy the file twice in the initial copy. The first
>>>>> line on line 13623, which results in a lot of commit mismatch error
>>>>> messages.
>>>>>
>>>>> Then again on line 13842 which results in the same commit mismatch
>>>>> errors.
>>>>>
>>>>> These two attempts happen without any delay. This confirms my previous
>>>>> observation that the outbound traffic to the server is twice the file
>>>>> size.
>>>>>
>>>>> Then there's an NFS release call on the file.
>>>>>
>>>>> 30s later on line 14106, there's another attempt to write the file.
>>>>> This
>>>>> again results in the same commit mismatch errors.
>>>>>
>>>>> This process repeats itself every 30s.
>>>>>
>>>>> So it seems the server always returns a mismatch? Now, how can I solve
>>>>> this situation? I've tried rebooting the server last night, but the
>>>>> situation reappears as soon as clients start to perform writes.
>>>> Usually the write verifier will mismatch only after a server restart.
>>>>
>>>> However, there are some other rare cases where NFSD will bump the
>>>> write verifier. If an error occurs when the server tries to sync
>>>> unstable NFS WRITEs to persistent storage, NFSD will change the
>>>> write verifier to force the client to send the write payloads again.
>>>>
>>>> A writeback error might include a failing disk or a full file system,
>>>> so that's the first place you should look.
>>>>
>>>>
>>>> But why the clients don't switch to FILE_SYNC when retrying the
>>>> writes is still a mystery. When they do that, the disk errors will
>>>> be exposed to the client and application and you can figure out
>>>> immediately what is going wrong.
>>>>
>>> There are no indications of a failing disk on the system (and the disks
>>> are FC attached SAN disks) and the file systems that have the high write
>>> I/O have sufficient free space available. Or can a "disk full" message
>>> also be caused by disk quota being exceeded? As we do use disk quotas.
>> That seems like something to explore.
> 
> It's also strange that this would affect clients that are writing to the
> same NFS filesystem but as a user that doesn't have any quota limits
> exceeded, no? Or does the server interpret the "quota exceeded" for one
> user on that filesystem as a global error for that filesystem?
> 
> 
>>
>> The problem is that the NFS protocol does not have a mechanism to expose
>> write errors that occur on the server after it responds to an NFS
>> UNSTABLE WRITE: NFS_OK, we received your data, but before the COMMIT
>> occurs.
>>
>> When a COMMIT fails in this way, clients are supposed to change to
>> FILE_SYNC and try the writes again. A FILE_SYNC WRITE flushes all the
>> way to disk so any recurring error appears as part of the NFS
>> operation's status code. The client is supposed to treat this as a
>> permanent error and stop the loop.
>>
> Then there's probably a bug in the client code somewhere as the
> client(s) did not do that...
>>> Based on your last paragraph I conclude this is a client side issue? The
>>> client should switch to FILE_SYNC instead? We do export the NFS share
>>> "async". Does that make a difference?
>> I don't know, because anyone who uses async is asking for trouble
>> so we don't test it as an option that should be deployed in a
>> production environment. All I can say is "don't do that."
>>
>>
>>> So it's a normal operation for the server to change the write verifier?
>> It's not a protocol compliance issue, if that's what you mean. Clients
>> are supposed to be prepared for a write verifier change on COMMIT, full
>> stop. That's why the verifier is there in the protocol.
>>
>>
>>> The clients that showed this behavior ran a lot of different kernel
>>> versions, from the RHEL 8/9 kernels, the Debian 12 (6.1 series), Fedora
>>> 42 kernel and the 6.14.6 kernel on a Rocky 9 userland. So this must be
>>> an issue that is present in the client code for a very long time now.
>>>
>>> Since approx 14:00 the issue has suddenly disappeared as suddenly as it
>>> started. I can no longer reproduce it now.
>> Then hitting a capacity or metadata quota might be the proximate cause.
>>
>> If this is an NFSv4.2 mount, is it possible that the clients are
>> trying to do a large COPY operation but falling back to read/write?
>>
> All mounts are indeed 4.2 mounts. It's possible that some clients were
> doing COPY operations, but when I reproduced the issue on my test client
> it did not perform a COPY operation (as far as I understand the pcap/
> rpcdebug output).
> 
> Are there any debugging steps we can take when this issue happens again?

Since v5.17, there is a trace point in NFSD called
trace_nfsd_writeverf_reset.

I really don't have much experience to share regarding your filesystem
and storage specific failures. You will have to use Google and
StackOverflow for those details.


-- 
Chuck Lever


