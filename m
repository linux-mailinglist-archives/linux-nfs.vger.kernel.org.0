Return-Path: <linux-nfs+bounces-8761-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE4D9FBEDD
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 14:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE521883ABA
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3DE19DF98;
	Tue, 24 Dec 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LaUjOXwQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JmpXovqk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5267D2D627;
	Tue, 24 Dec 2024 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735048467; cv=fail; b=uG0IOgLiCNAKkaZWBrFJCrrftA4Ou3Nopn2KsluQ+xpYStsVGK2L5aCM2jq7Lrj41c6cDujWJjGr51OXOt9yjJ2QlTj8CiN/zOfr8ce8Xu+qGiI9A6mYyQ5t/ljiZrSLUG+iKxdVAXQT+hB0JK55TsluLO14CfSplER51ARQVM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735048467; c=relaxed/simple;
	bh=eeW94RE5uEX1lqreK0rMUkrrfNDtWzC6pXJcCMzUma0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SZ5bfwt8xoM5T6BPPPFgS+vkrmRmR0Zql66C1qeJvCAaE9llcEGfSYY61du6Nq9x3cEokO0VvFuWuyZSURkFaImbd32UIRsR2irIu6CJuL+2BjH4XV/0rgXqsErpOJSJWYE8GunPUqtPJQHTBzdTh+xFdE2i+viOY3ObPWRjW9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LaUjOXwQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JmpXovqk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOCBaZx030891;
	Tue, 24 Dec 2024 13:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=B4/GOMgORk+/sr8a57VthrnnQM8xiSjah1rf2j3Sr4A=; b=
	LaUjOXwQHfbLYDqxWmOgJz7A7vvKtgoyCX2Yqj7tuWb+UhvhNNSpSBrIjsrJ3oZi
	9tmWWWKvwxnFxsxl3ZH2LR9nZVJ9e883VRm1fNQBf0MJjWbCtZ5x30ZMez8eyLhl
	YUTqa83tTNaEkJ3n0EybHd5sp8bY/IVt1Y801p3ANCRTWAcTooDcXgDvNszZ5C4P
	fGBDtIZBY5VB/A2Z6Je+wwN7uvslTvGEOUHPEomAqdU3vvtFF4F/Ruvejh8ZEx4L
	8g0Y2v0mSaP/RGikaOV6lqk1hi5br+DXREUuzmJ1F4DGLqkRDk8OpX/57lIh1XMo
	JDwCpGw/597D2obOBlJAHA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nqd5m9um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 13:54:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOCebrd004453;
	Tue, 24 Dec 2024 13:54:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43nsdgtsgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 13:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzPgDXCSCGlWyLxqis/WaPiRHbHPRtlMcpGFgJDhgLBd7JG1oCEocW+cvfWk2nqrukgMaT6xh64dkNwDIIUPVGYqSwaD91wuENiGUx4S5DawtIVTCADRmgEKviLTKFZafjOPrkQ6Y2qONEdrddaYtdQM2iCCH8l70QOypXE8ppY5m7JL4qdCAglYvrjmJESMIABtxe79s/TxIrycTGL2xspeYcjiCAwTJS3T5ZGk/JjXzEvObjDHDhikBImoIlaBIiwhVkvjdo0He9lUTo0AFU77ohzMdmnWzv9a84TlnL9Q6TbZuYday8+cfVmRyrTzoUf0LIQGC/cEQRsTuAyZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4/GOMgORk+/sr8a57VthrnnQM8xiSjah1rf2j3Sr4A=;
 b=XFL7wYNqONpwxfRCnN3OpFv/FeOSHBTS65GPHHtS4pcSyuO9sSn+jHK2KXwIrbIX7KSlD0Z9DgOWh/eIHwOG2C1i2/RnMO41/96j0yyQf/26BjbtsXasNB4DUYhLpskDgkCpZkahqzpSN3dGdgC02iEdvcrX1/PAj3oVZEoYCKdYvCbLka/KzFkOxSoH23aOlhzbQQdOANOKiE49e8yJepxppdpfB1OQ1qheBb8sil4KinUTHL9mBIitg43DDtAFdfpqsi/V7SloWD1oRPohQERJ9xRKnXAIhMJoQTL4bejJT3Zqt557V5RUo34vWa6itCHBAikGY/ZNsfPvPNC92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4/GOMgORk+/sr8a57VthrnnQM8xiSjah1rf2j3Sr4A=;
 b=JmpXovqkBlJXaBjtwxK+Kyu9agLvoBid3B4voY6frjI45jpYEFsH0NIFuSQyeQJT3iY0klDvlj9kPbMCxI/Xmuocn0XZcC0UpKEbbKqlXRm3XHP5atH8HiN9svUj4l3Qxq+HAlLKRP7W1Hb6ITMq5qEk4w15nr2I3FFimkVHLA0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6246.namprd10.prod.outlook.com (2603:10b6:8:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 13:54:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 13:54:02 +0000
Message-ID: <603d1173-e249-454e-813d-e6a1393cf9dc@oracle.com>
Date: Tue, 24 Dec 2024 08:54:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: fix incorrect high limit in clamp() on
 over-allocation
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mailhol.vincent@wanadoo.fr, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        David Laight <David.Laight@aculab.com>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241209-nfs4state_fix-v1-1-7a66819c60f0@wanadoo.fr>
 <6c287aa1-9d94-467e-a85a-7b7076fc080c@oracle.com>
 <CAMuHMdXSWmkK-SDPxGGX5qJtakSTiQCUzKCJ4awtVxFxNCtr6A@mail.gmail.com>
 <d4f9d5c2-6919-421f-b1f3-bda6986e878a@oracle.com>
 <CAMuHMdVZFT2LPNSS71UyNnQnh8errW40TOJTtwTXpZe5u7FnXA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAMuHMdVZFT2LPNSS71UyNnQnh8errW40TOJTtwTXpZe5u7FnXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c433ef-eeae-416c-e20f-08dd24226c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bld0NjNqWDMvNk9pYm5LaGJObDEzRVRWZkNVZ3k1OHlrQnJFOHcxbEtlaVpz?=
 =?utf-8?B?eDl1U1lrc1lpOVhWQVM1ZExlMW8wYmo0bTJjRjhYdUZ6K3hsdjhqSFF4QjZJ?=
 =?utf-8?B?aXNHa1JQaUU2MHhWcEFvSEpVSnVvSUZUdkJTVGM2UjVBaTd5bGh6aDRyVkdM?=
 =?utf-8?B?MzBVWTE5S0srQTJBd0IyVEgranh3akp3RTIxWHdjOFF0dk1XTkJNMDZOc0Jz?=
 =?utf-8?B?cmR0a1NNVklabU02NG0zNWNYYjA0QmJRNUhKRXd0MW9Fa1pBUmI2MXZ1UnY3?=
 =?utf-8?B?SlhWbW5BbXhVVFFZcW5FMW5pTDl3ZTZlWkMyVzlEbUJwVEhDMFdENnByNVpD?=
 =?utf-8?B?R3JJL2IzR2hvRVd1YlBRSXJhR0V4cU1HN2k4MUM4d09QUkY1OUxpemN4OEMx?=
 =?utf-8?B?WXBzbmE4SjNSQldERk4zQVVubTU1SldqQ2ZNN3JpTXlQQVJFbDNMQzFKdm84?=
 =?utf-8?B?SW9Kcm8zbEZ3N0hyU09Yemo1Y1hyNm1FWXBUTjZpMkhCMEdseVRNbDlJMkNw?=
 =?utf-8?B?dDJZSm1KdUZSbThrL0RlSlVnb2FuTlpHckhmdU5MakRETmw0UXRObUs0b3hs?=
 =?utf-8?B?Z28zVFg3SVlwNTE1TnpJd0JzQVJYRzk0WUFLVmc5TG9IdmxPOUVFVy9oRU52?=
 =?utf-8?B?OS9JYUJmUy9PMzU4Tk5GcG1QV1FhM2RXdHAyTGsxZDExdWViMmxPWDREbHIv?=
 =?utf-8?B?S1YwUFV1MjEwb3B5R3k3bWMxN3lmWlBEbzJadFNxOFJEa3NCeDE1Tlp0ejF4?=
 =?utf-8?B?TGRseHdTUGJmQmlCdmV5ZXZKOElhL2huU2QvdFZRNUpnakFJTTh2a1JwOGVM?=
 =?utf-8?B?Ukpva3F0RndJUnNJTDZUV3Ryc0RwRE01ZjI0Z1kxMmw0cHRxZ1VQNUh1cHFr?=
 =?utf-8?B?QWwrTno4aHE0U0JqN2RGQUovUUFXcHFiWTJZelNQTTFCb3Y0WFcva3BsTk1t?=
 =?utf-8?B?NXFQVnZLQ3M2bHVXRDRITG9vMEFMQ2NWSXlSRmFybmZ2L0twR3Y4dTdaMTRt?=
 =?utf-8?B?Sk5oL1VIWXAvNXAxL3dFM1V6NUZCZHRHbGZnV1RoaGlFM25URVlRekM3eC9J?=
 =?utf-8?B?UDFrUWNGblEzY1h6VXNWdlZXamJnaDd0UW5LYVp6NkRIZks0enJrd0ZmUk16?=
 =?utf-8?B?RzlIcnFFYXZ1Y2VBbmVxRy9qOFU4VE0zVmJMR0JQc1pFWVNLSVJHT0VDazFU?=
 =?utf-8?B?SWNGdXRCNTI0a3M2YUdDUEZJcS9YR2ZjSXgrVWF3QXczUEJIdEI5MzM0Qm9v?=
 =?utf-8?B?WENuaHBHZTB1YXF0RG5OdXRXUkFVM3I3aG9aYjlBMFg2cHhjYjNIVUFWbGU3?=
 =?utf-8?B?V0ZUTGNSRkw1MTcvSy9wdGVaQU5qTWxoYTFBRTc3NkFsN1VFSDhKdTM1ZFlS?=
 =?utf-8?B?clM2eFdGMGhCbC9wZmN2Q3ZBQzlqd2p4QUhpOWdnMjY0R2g1c2R4Q1ppSUdQ?=
 =?utf-8?B?Q1FMV0gvV0ZuYURrSUhBYnJwMWFHdWNiQXVkNG9GTG9ZMmMxLzNJYytoWmE5?=
 =?utf-8?B?cS9iUCtvdXRjdTFwWWJuR29kNDlzTmg1bDBkWk9rSm1LdzZyUlhxVlBkdWx4?=
 =?utf-8?B?SzVDNzJ2aE9oclVrVG5vdFdGNVlzU0xhOXZIZzBXM2tsVUJmYmJKNThVZzho?=
 =?utf-8?B?QjFCTE5pY1lTaktZOEk0YllqZ1ZGNXk1cGNLRXVqdWtsV1FqYzVWZUcrV214?=
 =?utf-8?B?TC9CRVF1VEs4K2YxY1daZjJnY1BnMUNnMDJDZ2VuMlExUEFibHZ2SHpucUNC?=
 =?utf-8?B?OHJmVUx5emRtTDFJeWgvSE9uSFhWM3lLeW9zZ1hmUlJVelFwTE10RmhmRnFY?=
 =?utf-8?B?d0hiZDlJcmNtVUcxMWhZdGdjaS93cVJpS2l6WDlFdDZkMUJCZ21seUpDZlZN?=
 =?utf-8?B?anpGU2U3QWdVQWN6SG5kVEY0VFBKLzRwY2NsS1ZJYmpqMHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW5YQU1KSVNrTVVWd0FXbmFvcFRtcEdIanErMFlwL25NdlZJUUZxTjhSeklp?=
 =?utf-8?B?TEIvYjFxUklkUWhnWXFUOUhyd1Z3Zjk2SDZZOHRYNnRYM3NOZUVTcmN3a05h?=
 =?utf-8?B?T2dtTzhVVm5rdXJ6QUpOOVR5d3Y5dW40TG1KcWljWG12UW81cGd1QXQ5Q0hS?=
 =?utf-8?B?YmpHa2tLVGNUOGhKdEhYd3NucmkvK0pkaC9lbHRhdyt4ZTNJdjZJQlgvV1hr?=
 =?utf-8?B?RWFNc2ZMalRyNC9ucG15b2RrekYrQWxDTFY5YmlUMmM4Z1ZLbElZV1hkc2I4?=
 =?utf-8?B?Nk1ETjh2clJQeVNUOXFzTEx1TXlPcjhjeGQyZnVxRm8yYkZMdEVIb0tlN0JO?=
 =?utf-8?B?UjFyK05ZSTlRRVhEYkJiekFUNzlmakJmeXJoV3RBSFZhTlFveHRuMW04YXBW?=
 =?utf-8?B?S1ZMeGJpaEJmbU9oanBVZFBtQnJWVm01Wk5uM1VnZTZQTlZBV3k0RnhSK3Zw?=
 =?utf-8?B?QnlRKzBUYkdlTUs4YXRkMlM5TWVGTTZ0QnJqNjVGeFhmaDFZclh2WVB0M1Rz?=
 =?utf-8?B?SEU0QjNrbXZVWitFQS94Yk9raG5WSElHNVgyMmpvbFlrZW52MzlFUVNLRmlw?=
 =?utf-8?B?SEcyb0JoMDlUemIvVmxtbUhld0F0dHg1WnRRdTNRYzlVaFg3ck9OVDZ3Y2or?=
 =?utf-8?B?alNQOGo1Nk5LQkZ5TmpFMmcvSWppUFYyK1c1ZEpmMHZVSVhZdndlR1ZqOUNC?=
 =?utf-8?B?Nmx5MTZ5ZGdsMTc1ZlROaHN6TitFL2h6MEFFYzB3eEoyZ2ZtbGppUER5M3lz?=
 =?utf-8?B?RHhtLzJ5eG1rMUQ3TEs4bzFJM2ROd21Ra3VXQVgvdExJNEpsMnpnK01EZVBN?=
 =?utf-8?B?bC8remw4VzdhdzZkNS95djlkVXlWb09lby9IQXpEa1BDZHhpMXVWbmtaTkxJ?=
 =?utf-8?B?eXBZVHFnTFVYM1hJM0JZQ0pKc2U3VloxMDNndnI4REFnd2loMTlycXFDWUJu?=
 =?utf-8?B?UHdYOTFhU3RtelJqalNJb0tsd0FiT291UnpraHIyak92aE9vRURSWk9kczhw?=
 =?utf-8?B?aTlYaS9WS1JtTkpXTnNycnRrRE5EQitLZDU0dU9idFk4UVhpOEt1NXA1ZU8w?=
 =?utf-8?B?NXRPK2kzTk5JZ1pQT05JMUsvMXd2VnF2ZDVQRTJTdFlXV3ZYQVNSY1hITWV6?=
 =?utf-8?B?NTVBOEdWOUwxTWliQWU1MjUxZ0J6bnQ2R1ZZN0RURXpEbjBJd1VyUk43OGxO?=
 =?utf-8?B?dXdXZjl5NEdHbUczSW9oTzZPR1diVmx6YVcwbGpFTGFld3VLVDY5UjdORHRJ?=
 =?utf-8?B?SUExSE5mMWdsRkxJN0tkWHlTNjZUSnBlcERhcUsvS29aZDJtckdRMzZMeGxN?=
 =?utf-8?B?MlZUdC9KRDRHY2lJVUwyVDRkZ2NzS0IwelZMdE1nS0poQ21wRXN2TUJCRC8v?=
 =?utf-8?B?azRkMit1dzNmVFVTR3FDTSttQk5WVVNYUjNNNHphODhZS0JjUjNOelZFQ011?=
 =?utf-8?B?OFp1eThkR3EwZ3ZRMkV1Q29oTWM5OWZsZjJGSzJyYnZkZFBLbDdjWk5nQUJ1?=
 =?utf-8?B?L2NmVDBSbXFoSktMdzcySUxjY2lXZ0hRdm8yc2dZZ0haVVNxU2I3TmxTSVVI?=
 =?utf-8?B?YmJKdXN1MTNhTGI2VGpQN0UxdDFPZHFJL0FXWEdYOHJCY0FNQlFXMjNNaXhj?=
 =?utf-8?B?bktVTUJSTmxkZ1FnTjhvaS96UmE3TmZsK0hXdFdMV0VxUUlqbm94ZWNSblJo?=
 =?utf-8?B?VENja0ROcm41WVcvYlJ4SVVQaTdpSTJwWE1GSGFvdXdZYWpPcEZUQXM2b1dS?=
 =?utf-8?B?ek1UNG00SjIxYlc3RTRvZnBHblhzd1I5QU52c3BQZDM5LzY0Q2huTUJySWln?=
 =?utf-8?B?Wm5uNjBCcmpVUnpmZzZhZ2V4cUt0WU55M2JWa2NKUjdLYlpZNTk1RkdocFZ0?=
 =?utf-8?B?RmNvTXhScm4yVEhZUCs5Y2llMkc5WDNrdjU3K3FKU0tBaVpZWThOTGtTdUdH?=
 =?utf-8?B?cVJxZjhoaFVZK3lsc0pqK0tndms2L0gxTWx5ZEk4RDdyVDVsTkZnV3c1NHhS?=
 =?utf-8?B?Y1BBMjNrWEg4Q3BsNHcrN29SRjlZWkphODh5b0FOSHoxbU5KdndEcERxT3lG?=
 =?utf-8?B?K0doZHArY0FacGFidXFxY3E4dEgvUGpJRGJxU3JFN2loLzRxVWQ3VWJDZUpH?=
 =?utf-8?Q?kqaD7X9ewqHbuTNWtySfUlEuh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oWl+MNYKETzJTsKJVgnExejyZSrE0J9NFacbOBGGwweNYzT8mrWObnqlOk5gGkeiEuG2bZmXRLMZIx+q4CdPclXlLzzrhgB9gzPuPMWr6yfYjJqkg7nnr7hAbhn7B+oWnuegt2Ng/Dlps1WOZgDT2wHE6bfQCsffXXifkz6tylMnj37eQK8xfRNZ4CHEJel61EIwEjJ12VA07TRNQczYYq1H6O0xlGpdXtIaVYdVEFirOr1zt+Kc8CZ6HT/xG409MV1MMXhd/sa4G0Rjf05Jw6ZQC0S9+p1Z+VBfofvKk3fl5ZqbKznmpWVff5qJmBZJ98ub1sZIQpoOxJNp4Ra5f7yyMgyBnXoYNxjvBhp+VbKkZ6MMFge+j7DsvXGYtgMsobbHvs91P2hdpArmYgZ3X5nyVFhv335ylWPnx9XrC0ToVs4zkpbFbbCfFHLWR1nvtnN967x468+LMKfyNfMg5M10/HrOMEW5PtSq0vhvUId5E3FrW9uDM0Ip5GTKmiCtJ6zKg8+Zy386fhen6hfQQsS6PlCWPwrrCfr1O8kkQBQv7+k/62pLXi6dBczvibohbXD+qQV2gdj7Nc8sLa35ulOf2EUnxOwTcDyQPb43qO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c433ef-eeae-416c-e20f-08dd24226c97
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 13:54:02.7099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MweM4aNx11Znun4QvjaYRImdtDAsz/fxun/Z6+yH0r7N4Efs2RAxje0LDh7nh1eWiV8vy+8CUjbrtjjZ+Wj1Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412240120
X-Proofpoint-GUID: eKP06SXz59d22oUucMCYNHtRQW_nELao
X-Proofpoint-ORIG-GUID: eKP06SXz59d22oUucMCYNHtRQW_nELao

On 12/24/24 4:16 AM, Geert Uytterhoeven wrote:
> Hi Chuck,
> 
> On Mon, Dec 23, 2024 at 6:49 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>> On 12/23/24 11:06 AM, Geert Uytterhoeven wrote:
>>> On Mon, Dec 9, 2024 at 3:48 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>> On 12/9/24 7:25 AM, Vincent Mailhol via B4 Relay wrote:
>>>>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>>>
>>>>> If over allocation occurs in nfsd4_get_drc_mem(), total_avail is set
>>>>> to zero. Consequently,
>>>>>
>>>>>      clamp_t(unsigned long, avail, slotsize, total_avail/scale_factor);
>>>>>
>>>>> gives:
>>>>>
>>>>>      clamp_t(unsigned long, avail, slotsize, 0);
>>>>>
>>>>> resulting in a clamp() call where the high limit is smaller than the
>>>>> low limit, which is undefined: the result could be either slotsize or
>>>>> zero depending on the order of evaluation.
>>>>>
>>>>> Luckily, the two instructions just below the clamp() recover the
>>>>> undefined behaviour:
>>>>>
>>>>>      num = min_t(int, num, avail / slotsize);
>>>>>      num = max_t(int, num, 1);
>>>>>
>>>>> If avail = slotsize, the min_t() sets it back to 1. If avail = 0, the
>>>>> max_t() sets it back to 1.
>>>>>
>>>>> So this undefined behaviour has no visible effect.
>>>>>
>>>>> Anyway, remove the undefined behaviour in clamp() by only calling it
>>>>> and only doing the calculation of num if memory is still available.
>>>>> Otherwise, if over-allocation occurred, directly set num to 1 as
>>>>> intended by the author.
>>>>>
>>>>> While at it, apply below checkpatch fix:
>>>>>
>>>>>      WARNING: min() should probably be min_t(unsigned long, NFSD_MAX_MEM_PER_SESSION, total_avail)
>>>>>      #100: FILE: fs/nfsd/nfs4state.c:1954:
>>>>>      +          avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
>>>>>
>>>>> Fixes: 7f49fd5d7acd ("nfsd: handle drc over-allocation gracefully.")
>>>>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>>> ---
>>>>> Found by applying below patch from David:
>>>>>
>>>>>      https://lore.kernel.org/all/34d53778977747f19cce2abb287bb3e6@AcuMS.aculab.com/
>>>>>
>>>>> Doing so yield this report:
>>>>>
>>>>>      In function ‘nfsd4_get_drc_mem’,
>>>>>          inlined from ‘check_forechannel_attrs’ at fs/nfsd/nfs4state.c:3791:16,
>>>>>          inlined from ‘nfsd4_create_session’ at fs/nfsd/nfs4state.c:3864:11:
>>>>>      ././include/linux/compiler_types.h:542:38: error: call to ‘__compiletime_assert_3707’ declared with attribute error: clamp() low limit (unsigned long)(slotsize) greater than high limit (unsigned long)(total_avail/scale_factor)
>>>>>        542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>>>            |                                      ^
>>>>>      ././include/linux/compiler_types.h:523:4: note: in definition of macro ‘__compiletime_assert’
>>>>>        523 |    prefix ## suffix();    \
>>>>>            |    ^~~~~~
>>>>>      ././include/linux/compiler_types.h:542:2: note: in expansion of macro ‘_compiletime_assert’
>>>>>        542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>>>            |  ^~~~~~~~~~~~~~~~~~~
>>>>>      ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>>>>>         39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>>>>            |                                     ^~~~~~~~~~~~~~~~~~
>>>>>      ./include/linux/minmax.h:114:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>>>>>        114 |  BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
>>>>>            |  ^~~~~~~~~~~~~~~~
>>>>>      ./include/linux/minmax.h:121:2: note: in expansion of macro ‘__clamp_once’
>>>>>        121 |  __clamp_once(val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
>>>>>            |  ^~~~~~~~~~~~
>>>>>      ./include/linux/minmax.h:275:36: note: in expansion of macro ‘__careful_clamp’
>>>>>        275 | #define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
>>>>>            |                                    ^~~~~~~~~~~~~~~
>>>>>      fs/nfsd/nfs4state.c:1972:10: note: in expansion of macro ‘clamp_t’
>>>>>       1972 |  avail = clamp_t(unsigned long, avail, slotsize,
>>>>>            |          ^~~~~~~
>>>>>
>>>>> Because David's patch is targetting Andrew's mm tree, I would suggest
>>>>> that my patch also goes to that tree.
>>>>> ---
>>>>>     fs/nfsd/nfs4state.c | 46 +++++++++++++++++++++++++---------------------
>>>>>     1 file changed, 25 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index 741b9449f727defc794347f1b116c955d715e691..eb91460c434e30f6df70f66d937f8c0f334b8e1b 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -1944,35 +1944,39 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
>>>>>     {
>>>>>         u32 slotsize = slot_bytes(ca);
>>>>>         u32 num = ca->maxreqs;
>>>>> -     unsigned long avail, total_avail;
>>>>> -     unsigned int scale_factor;
>>>>>
>>>>>         spin_lock(&nfsd_drc_lock);
>>>>> -     if (nfsd_drc_max_mem > nfsd_drc_mem_used)
>>>>> +     if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
>>>>> +             unsigned long avail, total_avail;
>>>>> +             unsigned int scale_factor;
>>>>> +
>>>>>                 total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
>>>>> -     else
>>>>> +             avail = min_t(unsigned long,
>>>>> +                           NFSD_MAX_MEM_PER_SESSION, total_avail);
>>>>> +             /*
>>>>> +              * Never use more than a fraction of the remaining memory,
>>>>> +              * unless it's the only way to give this client a slot.
>>>>> +              * The chosen fraction is either 1/8 or 1/number of threads,
>>>>> +              * whichever is smaller.  This ensures there are adequate
>>>>> +              * slots to support multiple clients per thread.
>>>>> +              * Give the client one slot even if that would require
>>>>> +              * over-allocation--it is better than failure.
>>>>> +              */
>>>>> +             scale_factor = max_t(unsigned int,
>>>>> +                                  8, nn->nfsd_serv->sv_nrthreads);
>>>>> +
>>>>> +             avail = clamp_t(unsigned long, avail, slotsize,
>>>>> +                             total_avail/scale_factor);
>>>>> +             num = min_t(int, num, avail / slotsize);
>>>>> +             num = max_t(int, num, 1);
>>>>> +     } else {
>>>>>                 /* We have handed out more space than we chose in
>>>>>                  * set_max_drc() to allow.  That isn't really a
>>>>>                  * problem as long as that doesn't make us think we
>>>>>                  * have lots more due to integer overflow.
>>>>>                  */
>>>>> -             total_avail = 0;
>>>>> -     avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
>>>>> -     /*
>>>>> -      * Never use more than a fraction of the remaining memory,
>>>>> -      * unless it's the only way to give this client a slot.
>>>>> -      * The chosen fraction is either 1/8 or 1/number of threads,
>>>>> -      * whichever is smaller.  This ensures there are adequate
>>>>> -      * slots to support multiple clients per thread.
>>>>> -      * Give the client one slot even if that would require
>>>>> -      * over-allocation--it is better than failure.
>>>>> -      */
>>>>> -     scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
>>>>> -
>>>>> -     avail = clamp_t(unsigned long, avail, slotsize,
>>>>> -                     total_avail/scale_factor);
>>>>> -     num = min_t(int, num, avail / slotsize);
>>>>> -     num = max_t(int, num, 1);
>>>>> +             num = 1;
>>>>> +     }
>>>>>         nfsd_drc_mem_used += num * slotsize;
>>>>>         spin_unlock(&nfsd_drc_lock);
>>>>>
>>>>>
>>>>> ---
>>>>> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
>>>>> change-id: 20241209-nfs4state_fix-bc6f1c1fc1d1
>>>
>>>> We're replacing this code wholesale in 6.14. See:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=8233f78fbd970cbfcb9f78c719ac5a3aac4ea053
>>>
>>> Bad commit reference?
>>
>> Expired commit reference. That commit lives in a testing branch, which
>> has subsequently been rebased. The current reference is:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=94af736b97fbd8d02d66b3a0271f9c618f446bf0
>>
>>> And hence this is still failing in next-20241220...
>>
>> I haven't moved these commits to the nfsd-next branch yet.
>>
>> Is there an urgency for this fix? Is this a problem in LTS kernels
> 
> Currently there are build failures in linux-next due to this, possibly
> hiding other issues.

Understood. I can start moving these patches to nfsd-next today, and
they will find their way into linux-next automatically.


>> that might need a backport? 94af736 is not intended to be backported.
> 
> We'll see if the issue ever shows up in stable.
> I understand it is exposed by stricter checking in the min/max macros.
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 


-- 
Chuck Lever

