Return-Path: <linux-nfs+bounces-10203-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2528A3DCE3
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 15:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DA0165A0A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC441F1531;
	Thu, 20 Feb 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V0Bu5L7g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="czqUYLuR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078BE1FC7F1;
	Thu, 20 Feb 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061879; cv=fail; b=kZxBZ1Qm/idvWRSrU92EfLPlcre7HVLWp45sdZe4Qm5bZXxMdYPZUrNWf9z66jQ83puvarZsrt3bD7O6fySxV2khuvhJDhOQ37pqxEomHZzm4XputtVnr0vfKUNGjHMonHDvjE+ng32EFiPz+CsmFZEFivVhkzLiV8RKmFvr1W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061879; c=relaxed/simple;
	bh=1biEl0+6PuMsWGsm/IxGWmL0gChz1LFNN5x0r1w7w88=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bia/blUC3eYI3yzPKfHZUWITEuoaig6k4sarJOyZaO6q4cyneYFH7dAVN2u4TbsHGoza+m8nIL1X3ioRMw6haE64QkA6yaYX3LHuckR4VTGDbUYhCFcl5Ni+6TNCW7YFYhc5WqpHTrEpgUTXTEwnpaGcEVo0owTHQ+xuwku2w2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V0Bu5L7g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=czqUYLuR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K9fXbP020876;
	Thu, 20 Feb 2025 14:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Hbw3OWNRLsaUaJrXigCnsdjK1me4dzKPfFJ7PDAgxUY=; b=
	V0Bu5L7ggDGFBsosNgrhbjB5J2rItKQlkRs5AxLsGfPMj4WdBuYW0CIzkuKIIUuN
	+gRCg96z5MoCgJVQ6ysvavjND7CJSOY14SCUVQDRKvb2h8HUwlj1WwdPEix45JaB
	VR0FgF1WSA8b5gc11zci8yYW2x7w2JV3v4ooheIn9XilgrUtjpNoMQ8N7Y/OuPDu
	4ONbX593xPFixA9N0zToJNpeMzkOIGN2bsKsVXfd83VgSMN3pvS6AEBRyeDfFR3d
	IUmTv+CPPamdmgk5evWZE4gexHt/UVwZQOFsqgu+7bEug4S8oSZNEq++PYD1V9EH
	X8nGPrNJHuMjHt59IrTppg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n47yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 14:31:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KDtxHN026502;
	Thu, 20 Feb 2025 14:31:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0sqfey6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 14:31:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r50Em0FwfSdMvH6uleIlwKGz7m8l4gYS9v6pVbBZ7T4wnJF+c+hqm0uN9vsjLMsSNcwyifgIz7qvoLpq1/1S/De8CjtuaOG0vlxU5VNEhLFeQ4oNV3FrcG/cJAyOQm3TVt7Gamn743EL55f1EK2zpBz7BKHsB1cvzwfr/N8QZKywlBD3+4YGG59vfTOsFRIZ/2gztubLcUEtpbCVMtpfBAHWFxv8DmyhxPPYJLOHe55IufRcHLFVk1vmPWZAhjIG1EE4wp4Yl3H5q8CpB9rz4dBlwyrH/7EwKygfqnRUg4rAQUFYrnrfUjQYBR/d7oLQZd6CJn9S4T7kvrk0OW00CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbw3OWNRLsaUaJrXigCnsdjK1me4dzKPfFJ7PDAgxUY=;
 b=U8E9Zkk3g9y4WhbAbMu1XkIUJMtC3LN77oXumtAVA6EAftq7Er18kbPO3kz6ibCFXd2ZqKAGvYCCwx+Z0tTZKqfgp4+Unxm5kiv23de+HsxLPEfgaL9xCIG/KHzb1smZOvK603ebWwoaSty4iopcCtZA0pp3VrxvNQwXHhVRYqoR46YDSGA94seJVDhMNp4N/l+AGrFL7juib9YVMjf4+m0B+q0HtYczsa49vX3bU6wWwNWD5eMKo5wyhFyBOI+xeiDbQkPI/K+EtUBuKCXVLFOrf9ChRBkOnskMeHgIrcMlRVXfGthi4boKcTFpsBvO5q2nWodJOEeDBe5/emLl5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbw3OWNRLsaUaJrXigCnsdjK1me4dzKPfFJ7PDAgxUY=;
 b=czqUYLuRE8us0djd/GhyaI/wuzlYXxfuyMm0LWnsFVEmdlh8JqOjV1rnLjdQl58dp5M4zldwp4cpZxRDFiScgqPPyyzPjar7WXkaBsjK7FUEtIjcdIP0fGm+vX1qFCt2x/Ps3dnnP2ivxguuXC2ORJx41ayfwFZeUfob5ZyU1Bw=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH0PR10MB4614.namprd10.prod.outlook.com (2603:10b6:510:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.22; Thu, 20 Feb
 2025 14:31:01 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 14:31:01 +0000
Message-ID: <b0e214ad-ead9-43c1-b9ec-cf8f365079e0@oracle.com>
Date: Thu, 20 Feb 2025 09:31:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd 6.14-rc1 __fh_verify NULL ptr deref
To: Mike Snitzer <snitzer@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
References: <CAEjxPJ64Nt6OHzi3V-reGnyxujGJpw4ZoH6f3H=4XV2QmHWnwQ@mail.gmail.com>
Content-Language: en-US
Cc: SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeffrey Layton <jlayton@kernel.org>, Paul Moore <paul@paul-moore.com>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAEjxPJ64Nt6OHzi3V-reGnyxujGJpw4ZoH6f3H=4XV2QmHWnwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:610:4e::31) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|PH0PR10MB4614:EE_
X-MS-Office365-Filtering-Correlation-Id: 13603e43-fbeb-431a-cbe3-08dd51bb331f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0lkUHZ1UVZZdEJMOFhpQldDVTgyUGZrNDY0NndtRjFZMnl3eG85eUxST2NU?=
 =?utf-8?B?SWVrUXhIS0ZnUi80aktpWVVicXYzNUpRZ0pJNDZLd3pkU25GL2MzUXBvQThY?=
 =?utf-8?B?aHYwWTRkeWNnY0hGcmxmaXFKTGFoZDU1cmlhK0JYMUM1a3RFdHQreW93eXg4?=
 =?utf-8?B?TzNYWjdQZytMNDN5ZW4zSTRTRFNFajVzZHFsVURKNUZmNm5KazU0Z0VFOTdw?=
 =?utf-8?B?akxEcDRRWlRiNE1EamN1Rk1oT1J1NEFnVXhpN2F5K1BwR1g3aHd2ZTk4b0h5?=
 =?utf-8?B?dUVsRm9KUm13RTdKRkFiQXJwRkxraE8yRWYwam5MM0I4VDBGUXRsZFdocUpl?=
 =?utf-8?B?cHRMaTRSVlA5NllFN2p0b2U0MDF1Ty9wSjJ2U3h1NDBGYmFkY0YvRm5PTXo5?=
 =?utf-8?B?bDhKV0p1eGlMUUE4SGpsSFZjQ2FPUHFJdXpLM0ZMRW1SR3hkWi9Pb1NCZUdm?=
 =?utf-8?B?Qk12U090eWFVV21mZW00VjhxcEkyN09SbGdpS21GcGFFVDJVM0RoOUpXTjMz?=
 =?utf-8?B?Z0trTnRUOVZzaEdibUkvcVdVa3Bsa1VaYUNzbkRXaXBYSTMvb1Q3UjlTZ1VL?=
 =?utf-8?B?SVZkNXN3ZEJHeW1LZVBhREIzZ1NJUzdmNVFUMk5SbEVBNnMweEtTTVNzNWI0?=
 =?utf-8?B?RFpiODd4YnVsUEE2dXI4UHEwSDZkaml3UEFLSmV2NEpKeUJ0TTJCTm1yS3Zv?=
 =?utf-8?B?OVJQSmh5bWovSjNwV1FNSWlDbzRCNzN1Ry9vL0FobEllbVJVRUpnR25GYTJP?=
 =?utf-8?B?cldxakt5S0NhSjZFWlcvMHBHc0lUdGI3cHBvSGdjdUVLMXNmMGF5djN6V2pU?=
 =?utf-8?B?UlgyTDRKb01GOVUzNnI3empmdzduZnQvRFJDTldyR1ZyYzAzdWRoU2lWTU00?=
 =?utf-8?B?dkJwa3hIOTJmUFltQkdQcGxaaklXdTYrQ3VBbFpxalcvaTNOV1FsZ3BJVDhk?=
 =?utf-8?B?VjUzT1lFTUVQajVDcytCWkt4OGZwTVNMNnhVeThUNFpNdGk4bHFaNWVsZ1lT?=
 =?utf-8?B?TytheW1mWHozaktZcEtGSHJ3dVB3SXhybTE3UWhVV09OeFpXSnNUd0o5ZUdP?=
 =?utf-8?B?eWd4UXNoU3JYT3JJRUxHV2tsR1ExcXRIY3Z3UTdVMkJ4OW4rNzFXM281cjVl?=
 =?utf-8?B?N3VxN3hQOEJiR2JlT1pKS0liSEcwN3dQTUszQTRYaE5xTlhrZVg4THZsQzdw?=
 =?utf-8?B?MlNhZU5hRGhETEFyb3lEWlVCREhZU1hWcW5DajVRL2RMdFNHMDBkRDA0aHE3?=
 =?utf-8?B?bFNZd2RoYzlId0JHL1RBUk5XU2wxc3FLYnRLUllOUFhNVXlyUk54MjZaY21x?=
 =?utf-8?B?Z3ZtNEtYbkxzaU5nU0FVdUdnQ2J1REZmaWIxTnlFZVUzZTVuWEVxeU9uS1lI?=
 =?utf-8?B?VEFBWEdkWVdOZkh6N29FR0pSZ2VtYVpselR0bnc5K1o0azRhd21pOUVYcXdN?=
 =?utf-8?B?eGlkNjhpWTBENlN1anAwaHlOdXFUdTBGRlpyRUh3eDczdzU5SUpKV2Z5OGV1?=
 =?utf-8?B?SmxaRmdpejVtYnJMQXI5OXZYVnR0bklwNTZxTTh6MDNNTVE2bzdMK3YwZW1R?=
 =?utf-8?B?cEs1dWJvTUIvYnNsbXpxS2RKNHZzUkszdVZzZ1pwWHNsUW5mZjBPYmZsdmVn?=
 =?utf-8?B?YW1XdEdlV01qa1hORUxCWE5WbjEyUEZjdHpsMEFJOUFXYS9CZnZacTdEVmpB?=
 =?utf-8?B?YStTc1I4dDFSU1BPMC9oZ3ZLTUdIWWNtcTQ0ZWpkcFJ5SzVTMWEzMXQzTkVs?=
 =?utf-8?B?blE1ZnB2WjB5WXVZSGx4RFFKOXFiRU5ZY3ZRTmdrTTVHN29FdUlXUVh3ei9q?=
 =?utf-8?B?N2pZSENLeEc5QmR3V1lOaDB0STRiUGljdUd6RXRxN2dMM2UyYmxTQkRrRmlj?=
 =?utf-8?Q?GdN9O9PNKA/rR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0Fqem9XalptWnFGVCtpTXpSM1FValFkTDQ3K21TdXhwVFhld054OExqWGo2?=
 =?utf-8?B?TGlGVXVCd2ZaNW1kK2hkYkd5b1RCS1NrY1FKdk5Mck5YaEI4YUs0cTFTT2l0?=
 =?utf-8?B?VHo4WStuWGN3K1U1QVZ1TDZrQnRWa1g0UjNXMmZmTVB0UWRaaE5PclBmZmFa?=
 =?utf-8?B?Q3lhWW11SE9aY0lEYk5pZzduMDRGcThhTEI2NXlCaWpxVGlacEltaGpwNkdV?=
 =?utf-8?B?bUZta0N3V2NadGp3a0d2SzBGSHYrdkVKaTZwSUxPNGhGZFV6YzFxZ3RBZWdv?=
 =?utf-8?B?VCsrUENBazh2UmFkWm9heDBickw4aFlWZ3hmWE9sbENYSDhqSlBVRVIrTUpF?=
 =?utf-8?B?RTY0aXhyTTVEMGswVlNvdU1BelN5ME9PQ3BEVWUzek8vc01zSmw4VGV3Tjhz?=
 =?utf-8?B?WmVsSnVlWmFCL2h0SjZMWU1rQnArNmhsSXB1WVhGODdUS3VHck5iZVNRRDN6?=
 =?utf-8?B?ZC8vdUJJUjdqclY2blZET094b2VCWTNCZUV1N3FXNERqblFBSk1tSk8wSm1l?=
 =?utf-8?B?S1kzYU1NZXZ2eVpQaDdZdkg1WjNUL05JenFHUUVOaHBoNDljZlVyTElYTjhv?=
 =?utf-8?B?b2VIOG85T2pXOUFVN3ZWQ3ZxVmdCV0p3cUh4cmdPVkcrYTc1TnVLbFk0OWc3?=
 =?utf-8?B?Z2gwOHI0RS93K2VNWHM1UEJKVG9VT1JXOXRXV1BWQ1haQjVyVDRhS1dIeXpU?=
 =?utf-8?B?NkgvaDhYcUNoWkM4eHNvQjArSURxV1J5ZUhoTXJ2M3F4RUNVYUtSQVFsd0tj?=
 =?utf-8?B?VGNrbTA0NFF0ZVV1YzRsM1VQQmY5RDFOVVV3cjMyTkZFeEl6MjJFQzd6V3Zq?=
 =?utf-8?B?WFpsOFEvYjJBeUYyZTF3Ym1VSWVWTHZBRjF2OGhzV0JUWGswN2VXZjZUa2pw?=
 =?utf-8?B?aGFKUnAzVmpndDRWVWpmY090Z3V1YXpKYnl4V3VYZW9veXI0dmcxSDRVVExt?=
 =?utf-8?B?bzBUeUYrY2o4SGphSEhhTkZaaEl3aWwybXU5dURIM3gwdXh4cWhtTHB0Y2Zz?=
 =?utf-8?B?dStCUDVyc3V1dTlhclZzRDQxaFNBanZHKzFjdlR2YWFZWWllUGYyU3liVHFV?=
 =?utf-8?B?YWc0OUVWSWVFb1FPWnBBazduK0xIKzNRYlVQZkoyNEJIUHAwMjU2NWx4OGFZ?=
 =?utf-8?B?VDNpbHhKOXZicUVXQkg5MXhpaldGUVpuRTRtalBHVUlwdGVjV0MvVy9uV2Vo?=
 =?utf-8?B?VFAxbG5lVk5UWlo1OHJqcVR2RFBrSHIwTUFxaXM1WW1DME9QUk1la2REUUx1?=
 =?utf-8?B?QjBudCtGdVMyNVNHSEZ6RmdZYkJJYlhIR1RUVDVJZTlvbTlhNjdLLzRmNk1H?=
 =?utf-8?B?T0k3dHIxY0lPaEVrQWROZjk3RkEzaC8rS2pSM1cyNVpjZEhwbWVGb2k1bEs2?=
 =?utf-8?B?ZlRSandPNGkwOEdYMDArNlRoTnFWalNRMk8rYUpTeEVUVnA3YVF5ZTZqdWxU?=
 =?utf-8?B?QzV3R05lRHFoNXlrK1E0akJqc0hyS2ZTR0x2RGVrdWRFUlMrR3I2bE44UXJF?=
 =?utf-8?B?WlBFUHdnVGRNNTk0UCtjSTE3aXJTbTlzMU5GM0V1bFl2RlYzWWFVR3haaGpX?=
 =?utf-8?B?WWdtb2o2bWNzTEtaQjA3OG1LS2ZUNWFqblFkVmVUVHloaExVSHRhNldzNjUr?=
 =?utf-8?B?Ymd5ZHNJZEJOcUdBRnB2RmVYL1hGTHBDQWVmWFVxVEVNY0FOS3o0aTBhRDM1?=
 =?utf-8?B?YWE2SXB5a2lsc2FzZUswanhLTUt6UUxNY2hDSzRCallzOFo1V0duQWpsdUdo?=
 =?utf-8?B?TGoxVXh5Q2l3cWowYjdTUkJ1OGVTZG5FTWVGclZKL3FBQ3NjeDhmeHJwUXht?=
 =?utf-8?B?N0N3bjZpMllicWpXRjc1cVJueU1LdUplOE9UeDZDRDlrVFZmVk82VlZVRmsz?=
 =?utf-8?B?cWJLQUh1TGRwMDdhZ0RSczJwM3BJcVp1cFdNSkhYcTZDbVAzRDFYRFRCVG92?=
 =?utf-8?B?WWo2SXViSlVVZS9vS09RZ01yWWE1UnN6TGwwaVdDaXkrTW0zWEorTm96TzlV?=
 =?utf-8?B?aHkrT3pnWnhCb1RhK2xBMFZlWEw0R0xRcS9FN1N4QkFqRnZURUd3ZkFuYUJ3?=
 =?utf-8?B?U0hZaWxzYjc0RFp2dENRa3RKVURucGtSaXNudjlyVThCTytMa2JPdWo3TzlD?=
 =?utf-8?B?d1NDNTJuZ2wrNXIybUJyZ29ERlVOK213K0o4WW9WZ1k3dEZtYXFTcHJIY3NU?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/jgyuOBtrHaXXfqjt+Y0K8sKWnFb0Etgtfxh6NH7zMw/oOmcSwNcH8dGhQeirv9SwuEfeW0v7fvzYuQ+RqWgxrN9N82zWQjfKazrg7rLQNlteZllOmpSMES117KIHWZzO3Q1xRRj4GVdwKlLIo0StiLR78F0ONHXlDfR+i1B7uaWrCl3V98NKLzn12X57fpV+/ksXphzNdePxC3lpy8wALBkE/OHl4DI0JtQWaLS5IO9gQ4r9oCUXFpKMfB1GCSw/dSJTDVayEdUc7ToHLZWtxY01quw3vxd9kgVUhdzyreui5nm4hKp/03aU/507fxBsBj7xUizVZZA7lh2chBlAg3eLtXVm2oQ21TP8dM/B/YXxS1L9ptZR2BFuHQsr/xZf3Qn6yaha3l4RXSO++jiBvEBGfz9w40VtWZpK4QwMkLgvk1J3tuOU4a7jJgNDTXuI5OzwSk1krFW0Sbw4gUDiWmN877hJZDgV/TOGKEm+0FLAJIfz16wDioFRNJAhF3FeS3fi1qhWh1Ta6BpSea+5GqAlh/CGblQL0+8kur586vrfICYp8HrxDKVx2Aq+Q+Um5LQitZfdCtN5TwD3sWp2bta6F317cEN9Bxm/u8iZlI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13603e43-fbeb-431a-cbe3-08dd51bb331f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 14:31:01.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlsKhCn2D51G2ZmUM1HPPGi6Xe6yz10J58BfZxDTjLz1S9Rr81lgJkNpP4X106YJyfHKAu2F/ijiqsLmzCsZjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502200104
X-Proofpoint-ORIG-GUID: cT1Fg2b_4dzCdetkxloovbX1_-lS-IVC
X-Proofpoint-GUID: cT1Fg2b_4dzCdetkxloovbX1_-lS-IVC

On 2/20/25 9:27 AM, Stephen Smalley wrote:
> This was on selinux/dev so I will retry with nfsd-next too but I don't
> believe we have any nfs-related changes in the selinux tree. Config
> attached.
> 
> Reproducer:
> (enable SELinux)
> git clone https://github.com/selinuxproject/selinux-testsuite
> install dependencies as per README.md
> sudo ./tools/nfs.sh
> 
> [   55.726787] NFSD: all clients done reclaiming, ending NFSv4 grace
> period (net f0000
> 000)
> [   55.754588] BUG: kernel NULL pointer dereference, address: 0000000000000028
> [   55.754608] #PF: supervisor read access in kernel mode
> [   55.754617] #PF: error_code(0x0000) - not-present page
> [   55.754625] PGD 0 P4D 0
> [   55.754633] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> [   55.754642] CPU: 4 UID: 0 PID: 2720 Comm: make Not tainted 6.14.0-rc1+ #254
> [   55.754669] RIP: 0010:__fh_verify+0x473/0x7b0 [nfsd]
> [   55.754755] Code: 01 f6 44 24 71 01 74 09 4d 39 75 48 0f 94 c0 09
> c2 0f b6 d2 48 89 ee 4c 89 ef e8 b8 80 00 00 41 89 c4 85 c0 0f 85 48
> fc ff ff <48> 8b 45 28 48 8b 50 30 83 e2 10 74 2c f0 48 0f ba 68 30 11
> 72 23
> [   55.754781] RSP: 0018:ffffa12a410eb358 EFLAGS: 00010246
> [   55.754791] RAX: 0000000000000000 RBX: ffffa12a410eb508 RCX: 0000000000000000
> [   55.754802] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90590e38e400
> [   55.754812] RBP: 0000000000000000 R08: ffffa12a410eb200 R09: 0000000000000000
> [   55.754823] R10: ffffa12a410eb260 R11: 00000000ffffffff R12: 0000000000000000
> [   55.754833] R13: ffff90590e38e400 R14: ffff90592be77080 R15: 0000000000008000
> [   55.754844] FS:  00007f2eb9c1b740(0000) GS:ffff9067ff800000(0000)
> knlGS:0000000000000000
> [   55.754856] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   55.754865] CR2: 0000000000000028 CR3: 000000010c262006 CR4: 00000000007706f0
> [   55.754897] PKRU: 55555554
> [   55.754904] Call Trace:
> [   55.754913]  <TASK>
> [   55.754920]  ? __die_body.cold+0x19/0x27
> [   55.754933]  ? page_fault_oops+0x15c/0x2f0
> [   55.754944]  ? exc_page_fault+0x7e/0x1a0
> [   55.754955]  ? asm_exc_page_fault+0x26/0x30
> [   55.754966]  ? __fh_verify+0x473/0x7b0 [nfsd]
> [   55.755023]  ? __fh_verify+0x468/0x7b0 [nfsd]
> [   55.755069]  fh_verify_local+0x27/0x30 [nfsd]
> [   55.755116]  nfsd_file_do_acquire+0x59b/0xc50 [nfsd]
> [   55.755167]  ? get_page_from_freelist+0x17d7/0x1bd0
> [   55.755180]  nfsd_file_acquire_local+0x4e/0x90 [nfsd]
> [   55.755229]  nfsd_open_local_fh+0x121/0x190 [nfsd]
> [   55.755285]  nfs_open_local_fh+0x96/0x120 [nfs_localio]
> [   55.755590]  nfs_local_open_fh+0xb1/0x200 [nfs]
> [   55.755908]  nfs_generic_pg_pgios+0x96/0x110 [nfs]
> [   55.756190]  nfs_pageio_doio+0x3b/0x80 [nfs]
> [   55.756450]  nfs_pageio_complete+0x7d/0x130 [nfs]
> [   55.756727]  nfs_pageio_complete_read+0x12/0x60 [nfs]
> [   55.757000]  nfs_readahead+0x244/0x2a0 [nfs]
> [   55.757255]  read_pages+0x71/0x1f0
> [   55.757488]  ? __folio_batch_add_and_move+0xbe/0x100
> [   55.757712]  page_cache_ra_order+0x272/0x390
> [   55.757934]  filemap_get_pages+0x140/0x730
> [   55.758176]  filemap_read+0x106/0x460
> [   55.758397]  nfs_file_read+0x93/0xc0 [nfs]
> [   55.758638]  vfs_read+0x29f/0x370
> [   55.758855]  ksys_read+0x6c/0xe0
> [   55.759083]  do_syscall_64+0x82/0x160
> [   55.759334]  ? set_ptes.isra.0+0x41/0x90
> [   55.759567]  ? do_anonymous_page+0xfc/0x940
> [   55.759799]  ? ___pte_offset_map+0x1b/0x180
> [   55.760028]  ? __handle_mm_fault+0xb6c/0xfc0
> [   55.760287]  ? __count_memcg_events+0xc0/0x180
> [   55.760526]  ? count_memcg_events.constprop.0+0x1a/0x30
> [   55.760751]  ? handle_mm_fault+0x21b/0x330
> [   55.760972]  ? do_user_addr_fault+0x55a/0x7b0
> [   55.761188]  ? clear_bhb_loop+0x25/0x80
> [   55.761426]  ? clear_bhb_loop+0x25/0x80
> [   55.761619]  ? clear_bhb_loop+0x25/0x80
> [   55.761806]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   55.761993] RIP: 0033:0x7f2eb9d05991
> [   55.762188] Code: 00 48 8b 15 81 14 10 00 f7 d8 64 89 02 b8 ff ff
> ff ff eb bd e8 20 ad 01 00 f3 0f 1e fa 80 3d 35 97 10 00 00 74 13 31
> c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48
> 83 ec
> [   55.762615] RSP: 002b:00007ffd23dd62b8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000000
> [   55.762826] RAX: ffffffffffffffda RBX: 000055939883d6d0 RCX: 00007f2eb9d05991
> [   55.763034] RDX: 0000000000002000 RSI: 000055939883da40 RDI: 0000000000000003
> [   55.763241] RBP: 00007ffd23dd62f0 R08: 0000000000000000 R09: 0000000000000001
> [   55.763452] R10: 0000000000000004 R11: 0000000000000246 R12: 00007f2eb9e05fd0
> [   55.763671] R13: 00007f2eb9e05e80 R14: 0000000000000000 R15: 000055939883d6d0
> [   55.763880]  </TASK>
> [   55.764085] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver
> nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd nfs_acl lockd grace
> nfs_localio vfat fat jfs nls_ucs2_utils nft_fib_inet nft_fib_ipv4
> nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
> nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_mangle
> ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
> iptable_security ip_set rfkill nf_tables ip6table_filter ip6_tables
> iptable_filter ip_tables qrtr binfmt_misc intel_rapl_msr
> intel_rapl_common intel_uncore_frequency_common isst_if_mbox_msr
> isst_if_common skx_edac_common nfit libnvdimm rapl vmw_balloon pktcdvd
> pcspkr vmxnet3 i2c_piix4 i2c_smbus joydev auth_rpcgss sunrpc loop
> dm_multipath nfnetlink vsock_loopback
> vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock zram
> vmw_vmci lz4hc_compress lz4_compress xfs vmwgfx polyval_clmulni
> polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3
> sha1_ssse3 vmw_pvscsi
> [   55.764153]  ata_generic drm_ttm_helper pata_acpi ttm serio_raw
> scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkcs8_key_parser fuse
> [   55.766222] CR2: 0000000000000028
> [   55.766500] ---[ end trace 0000000000000000 ]---
> [   55.766813] RIP: 0010:__fh_verify+0x473/0x7b0 [nfsd]
> [   55.767165] Code: 01 f6 44 24 71 01 74 09 4d 39 75 48 0f 94 c0 09
> c2 0f b6 d2 48 89
>  ee 4c 89 ef e8 b8 80 00 00 41 89 c4 85 c0 0f 85 48 fc ff ff <48> 8b
> 45 28 48 8b 50 30
>  83 e2 10 74 2c f0 48 0f ba 68 30 11 72 23
> [   55.767785] RSP: 0018:ffffa12a410eb358 EFLAGS: 00010246
> [   55.768119] RAX: 0000000000000000 RBX: ffffa12a410eb508 RCX: 0000000000000000
> [   55.768434] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90590e38e400
> [   55.768751] RBP: 0000000000000000 R08: ffffa12a410eb200 R09: 0000000000000000
> [   55.769089] R10: ffffa12a410eb260 R11: 00000000ffffffff R12: 0000000000000000
> [   55.769408] R13: ffff90590e38e400 R14: ffff90592be77080 R15: 0000000000008000
> [   55.769726] FS:  00007f2eb9c1b740(0000) GS:ffff9067ff800000(0000)
> knlGS:00000000000
> 00000
> [   55.770069] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   55.770393] CR2: 0000000000000028 CR3: 000000010c262006 CR4: 00000000007706f0
> [   55.770756] PKRU: 55555554
> [   55.771111] note: make[2720] exited with irqs disabled
> [   55.771477] ------------[ cut here ]------------

Stephen, bisecting would help us immensely.

Mike, are you free to have a look at this one?


-- 
Chuck Lever

