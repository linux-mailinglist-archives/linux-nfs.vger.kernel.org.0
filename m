Return-Path: <linux-nfs+bounces-16646-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A732BC7B5B1
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Nov 2025 19:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81D2A4E1BC0
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Nov 2025 18:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A962022B8BD;
	Fri, 21 Nov 2025 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FX9fsZg0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y9jRJPXZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E314B2BD5AF
	for <linux-nfs@vger.kernel.org>; Fri, 21 Nov 2025 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763750397; cv=fail; b=M4FBgTA7LDEKXpuUxtrf+vgcZrgCspTQqRzQw3b8s/GFSI8wCBqbZk5Uy3PA7yWcm95+40H9RF6CKLVT8CV5bLHQL2ceMWvalvMYwVZYJAormslQepqPr0gfg53ABBO3BEq/P8RF2Rt3I9v6FPwDFssxWghxBTnhKnEkSDaz8Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763750397; c=relaxed/simple;
	bh=gmcUSSW303l0kx4XG6y4MIzIM1DGkEQfisVCySoGtA8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IZRrEDOCWy3lwUQ+HQdcqXV9q3drWmadNr4l3gSmq0slyHNiKDwWXJlPinVP/uYMrNspbmjzVinyfAP2iL06A3QKCgK5tnXD6i2/xECwNjefZ+IQncgHcuONOxPwINp4qN0g/s1agA/p/hUVEeJbHfdoa8jvH0oFWvnEpvR/iiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FX9fsZg0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y9jRJPXZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEhHcG028690;
	Fri, 21 Nov 2025 18:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dextRAWhRaU1JipP/aQO/v9/YWBa6JvKYeb1y/zS9Uo=; b=
	FX9fsZg03mR1hMVuleBfEfIDWb/s/g314rRfA5EGQJtdci6SN8ZPABwXO7C5eSAf
	71B4TXlvWU6MoVgXyQQdf762J9+D+/rmknSzAlpxozkkKBjKId75Cq8E4tAX86tl
	ftY3nvop9LAs6OO9uZhsPf8myjMyXcjXPehpp7OxI43PTOO+/3wLoxzyWbGMa84t
	RulaWFaIKFbLU34D4W8Fpdcg8hATX+c2tNzsgTO1LNKSUyBjprCCNZuXiufQH9xE
	s/CTWNK5faM72vP05kimJyIC4+MpLKELUu0nUW+cBkxQHBPvRVMclNzdGOpegZmz
	PXDHtvmtPjTS0Frh/VHjXQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej96c4tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 18:39:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALHjxuf007231;
	Fri, 21 Nov 2025 18:39:44 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefydytwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 18:39:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY1iYWuPOHENVBSwNKn6Lvf9KTvZH+dX6MQZPwQpi0T7rkBeWoZt2f+5wyJw34rX4Q1hVdeoGc/TnVsZdFiycOZ2Eu4dA59Tes8Kg2AwPUJnCq39c4kO7RTkv5p6QMTrS1A5OZkw0eVtqdQr5XERz8Pf+oJ7lepbaXufKzM8NmNkGOHpquesRywTWf5YTgxH+3u7KCdr2Q3P+LLogXp1LRGyHk/67gRmbFTdq33OKA1Jaq7ZTTob4wck9tta9R2GuHB66t4pLDVDyC3/8/6w0mn3IgK1hr8t7Li6wQVhbnvhROTl7fHoK7kWVHtEsIxESmKRkNTjOXjWmdJxGwPPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dextRAWhRaU1JipP/aQO/v9/YWBa6JvKYeb1y/zS9Uo=;
 b=Fcql+EJXY8hKg2xoDJu1sZkI0+URWy2MenWlr/dFjFuASGMS4f6+VsHQ4WVEeXYUReKtjO7uwbccohyAp4KIMv47XcBZXqEpeN0lk0iW95hmGSWjUBoM/SaEGAEOTx/hCYftAOGWtgrHXuw+cFyfD4O1WFNgX6VlrkNK1Pbz6M8fTgvPXgEq2eIETQDW8qJU+7DM17aLhqAyPyYmOENiB9P3ydmkDBShkFp+3385++LWS6ZLMw8FZ0q6mq2H0gn802teZEA39wEmol1qBXyaT1TG301y7GHrXjZy4Ypn3t6Cniow+mrxUHA4ryBt9G/Bdajczt89BcYSqjdTqRFhAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dextRAWhRaU1JipP/aQO/v9/YWBa6JvKYeb1y/zS9Uo=;
 b=y9jRJPXZaVw+0tjgKwPwdEKu1JD3tY4QLfHUXdKQzICYnCks9jAKxImw7WHhxCiP90P3JeXsOGTv0JH1F+aS8A5klmdMc+nAvC9jl1jZubdv9lsdgnovbvD6caEdgLUItRkV1NMcIyQDAVatkJ5XMkOnaqOIBnJGon38/RnGAro=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS0PR10MB7399.namprd10.prod.outlook.com (2603:10b6:8:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 18:39:39 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 18:39:39 +0000
Message-ID: <d5368480-744b-4200-a647-fc77affcdeaa@oracle.com>
Date: Fri, 21 Nov 2025 10:39:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] locks: Add lm_would_deadlock callback to prevent NFSD
 hangs
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20251120174831.5860-1-cel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20251120174831.5860-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS0PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be71f8f-5bac-444e-cb26-08de292d53be
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VFBVWHJrQURYbCtLY0o0WUt1N29Wdm54RTU5bmFzRTNNLzVpV21PQ3BLNzVX?=
 =?utf-8?B?TUZ6d0c3QWdCWE01Ti9xR2k1TldheEdudThUbUJoK04xMDNPSGVCNFJMTUNS?=
 =?utf-8?B?UTc4dGhwN1oxTG9rdWE1Y2cwaUwvamNWQkdHNURTVXhCUjc2N2JIdHVTVmhl?=
 =?utf-8?B?OTFWYmFXckJScmo2eHlWVG1Sd2k5VUlVd0JaY1oxbTB0NTI3cE9BL3VkTDM4?=
 =?utf-8?B?SkdDdmZONURUQmJ6Y1BmQVdrNmJYcjR0eVZtUHVzZEVGWmZUMDJKc2VQM2FE?=
 =?utf-8?B?VFZEa3FlbUNSRG9BczNnV3NCaGhmS0NQY3VRVFdUejJsdU92TmYwT3NnVHNl?=
 =?utf-8?B?RHRWenhrTXpXK2hmZmtnZDlNYm53NFJRUWhMdWRiaGZtYWk1WVo4VEhtTm5u?=
 =?utf-8?B?dUhKRVgzaVNBK0xlcndPSlFJUGVBOEkwcWJKMVhvNGhlY0RjU0lmbVpzcVNn?=
 =?utf-8?B?aWJNZGFPQnFacXFId1pTbGxqd0h0M1YwaDlSOVdaTmxaQVczOHNVbUxLMi8r?=
 =?utf-8?B?ZWRUQzhyRExaZE1Jd1JqQjVtS01QV25IRm0wbmZ2UVhYd09SK2JMQ1ZpSFRD?=
 =?utf-8?B?eE5GekFWMVRDdXd5UmVyRmExckV5S2lpczA2T3dDUHordkx0aklOOHlwMGhG?=
 =?utf-8?B?M0pON3NzaWNIb0FEM3cwcnpzK1NsSzJqUXphK1hqRGdqdm13RXR1UEVoZnl5?=
 =?utf-8?B?QnYxNm5qWURpRnZVSytya2NzcUlWaTZ2SjN1MjBHUlk4MlI5bzd3d3VCOWMr?=
 =?utf-8?B?SWpjNmJvUGovNGZiTmExMkk4YXh3YTRPM3UxWnBrREtkTEFwLzNqbDQxM2hG?=
 =?utf-8?B?SWxBbkFxeW53dzFkMTBXM2dzK0tGS052MTM1dExTTnFHalBmcjF3b0MrN0dT?=
 =?utf-8?B?R3F4cC8vYVpNOGVLSDFROElEQnpndWFkQ0hRMVBEM1YwY2orbEVVVjN5Smo4?=
 =?utf-8?B?TDlmUzJGVTBvVmwwWWE1RnZHUHY4WmlRYUtmbCtCMjRWRTk0S3F5eEZzUVBu?=
 =?utf-8?B?MDVJM3czVjA2aWhjL3B6ZUY5QWdhY01RRTZRY044OVNkQUNVMURpZmdPc212?=
 =?utf-8?B?RTJ2Z1h2TzlMMnRxM2VMM0xMSVpGN0ZLb1pBbkpwcU1pWlFrV3BZNlJaSnAv?=
 =?utf-8?B?OExhNGZWR1psbE5UZ2F4TG1WNWhUcWJ0RnI4NGIwcGlqRmRDSkFNbXdvNXlQ?=
 =?utf-8?B?eVBuQ2E5NFJLVys5OWhheUdFbmlyRjVYZEd5aG5wcEM3RCt6cENSTmpBcUU3?=
 =?utf-8?B?cEZVV3k0OWhSSzFld3hLeXBaRTEyU2dsLzJ4NWIzT0g4OWd0bVBNcXFFV0hk?=
 =?utf-8?B?WmRkSmJXNG1qU3l1VDQ3WTA1WDRmOUZvUXlFMWZMQlExbm9pZTJaVDBXckkw?=
 =?utf-8?B?T2FaNjgrcGFHQjRTbksxeHhhZCt5WkwxZGNJZkhQcXlXSUEwb3NrcWh2c1lB?=
 =?utf-8?B?eXZ4R1krZ1BLdzNEOGV2STVOd3MxclpJRWtUK2ttRWtoemVXUkNWditZMEtH?=
 =?utf-8?B?WExWMTM3aWNzMVo5eFE2cEdENTZKL0dJK1lIb2dWZG8zM2hCV0lmV0Z5QTFa?=
 =?utf-8?B?Q3ZJVWpvV0U0NlA4SnY5UjZkNmIwZktrRGVSODJMZmJIOUJCaEJTVzRyb1Ez?=
 =?utf-8?B?MUJoMDNuSUpDZnRWLy9oNjMvck1hQkdWb3owWEw2b09ieHVycExzVWQ1YURN?=
 =?utf-8?B?aGNJdE10bWNFQ3dvV09zVnJYOXcwZEhNcnBoVElBRGtQZTNTWk8wMmNneEpJ?=
 =?utf-8?B?NjE5b3JRcktyWE4wNnpaRkI2SXMxb1ZvRWJvMWxwd0JWUDlEbS9ROW5vaFdy?=
 =?utf-8?B?L1ppRlRwM1NDakpyL2diSXpPd2tHVTQyemVvZzJ6UmtYRXhHdTBSU1FMUENJ?=
 =?utf-8?B?T2JnQkNpbUpXV2YyWlppTm84TjZKTW9haityR1VBV3BwRllwS3JUR3dZMzhv?=
 =?utf-8?Q?wigpLQa0CxE+hs+0u9bcaF54wXMhOap3?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RzdJdll5dFdzbTdralZ3R3c0RGI4bDluZnorODkxbjlERDFUVk4wV3lWS2pK?=
 =?utf-8?B?b0NBM0NDNDlNTG1qTHV1ZklaNnRaT2dsa1RmMG54UkZ5eUVKMGdGNVJuajJs?=
 =?utf-8?B?VnlaK2pKNHp5dGMyejNxRlAwZUFwQ0cyWlQwZlNNd1dJSVhCU200S2g0dmZp?=
 =?utf-8?B?OW5RL2hONFh0OUV6VHJFVDdmT1BsYjJNempoa3A0YTFZeGhNNGQ5ekhyOUVa?=
 =?utf-8?B?VC9QRTV1RnFMRFArWmlxS2dlQ3czcTg1ZHAyc3hnNEdaYVJjdnkrUEJqWnlQ?=
 =?utf-8?B?bDBrVSsycXVMOVd0NDdyM2xraTlJTktieUVJM2d2SUFpVlRaTHBZSHpyS3pB?=
 =?utf-8?B?MThzclIvdGl2RlhhcCtXSTlUbWpsay9GMHdNbnpGZVpaQmlkbTU5ZFp1Q1pK?=
 =?utf-8?B?WnJ2TGVuVitzTS9jQjAzajR6d3YzT0plUjkvOXVWVnRqQmtkYUx3YjhpYitz?=
 =?utf-8?B?b21vRkNkbTdTWTI2MFFWSTdkUmVmS0tyRWpPQzBkVjVIS2lwM1F5QVg5WDZp?=
 =?utf-8?B?Nmhxd2dNeFpEUW9zSzNHZmtQaHZvWTRGTHljUXBOUnY0UVMyNldGakRyVGtB?=
 =?utf-8?B?Z2M4RkRQN0hwWGNwVFpRTldSaWw1UHo0WmZpNWtYNm4yT2QreCtKcWV6UEZy?=
 =?utf-8?B?cHJoWkwzcDU5OCtCK3drM0oyWWhCT3BQUHRPejNuVUdGejEzVWZNVFBhaG9u?=
 =?utf-8?B?c1g2am9sVUJaK01sOFhkVXd5OTNDeFc4dU1VWmxLUXoxMHJRNzhTMGIvVUMv?=
 =?utf-8?B?UjIxcGYyQ01oQnlKcXNhbit6cXcwZXpqaENxajlaNjZPQTVCcWdIUk9GK1lx?=
 =?utf-8?B?RG42RzNiNDZvS09GRkFWRFNOTzczUnowZ3NXVU92NzNwYTNpdzZzZHpaVHZx?=
 =?utf-8?B?cmVXWnZlR0J5UU93K3NtbUphU3M1YXVvMDZkKzJvTExSSDkySENsdGpWaFQ2?=
 =?utf-8?B?RFJIbmxlaHpDOThnbEd0SERHQmtDTWhNOVFwNmhWekN4TEMrZnBxR1RqSXlj?=
 =?utf-8?B?Y1hacDRQNmFaNEdWMjFLNms0dGFFTnlUVndLNXNjd1dYZ2xVSVQrdHR0eTls?=
 =?utf-8?B?OVZOYTRiQUFVQTFwYmM2U0c2NUhkMjFKdk0rWEtsSzhSbWs0UXAxTUxVVnhO?=
 =?utf-8?B?aE1nR21YREMxTjlSUEMvc1Z5eUtYQTZaWmJRNUdGRStxaXBSSzBpR21tL1RN?=
 =?utf-8?B?N3E5VFB6d3A0UU9qSExtdTh1ZitIZHJ0QUhBSEZqTTlCL1pWMTRPenR2VXBy?=
 =?utf-8?B?Q0RwV1dCNDNJaW9ZTHBDS1JFakkwTk85WkV2MEUrRU4zeGhNR0FzU21jRVdB?=
 =?utf-8?B?NHlITWYyaTA4QXF0Q25qcGYzODNOa3ZtUnRJQXc4RS8zR0FYeUhFZlJyT1FW?=
 =?utf-8?B?dE9FOVVpTmc2TnFLdlZEM1J0N1preDJUZldRMUgrQkcxNkN2cW44U2dsZ2NJ?=
 =?utf-8?B?M2E0ZDgrRUNLMjc4U1ZvbVgwU1UzS09sQjJiSzhka09Kck5MRkI3ZSsyRzBO?=
 =?utf-8?B?clpUTXJHVUZiR2F6L3FGWTRaMTlvSHE1ZnZNWUNEeThyNGw1VVF3aHFTUEdP?=
 =?utf-8?B?ZmpVVE1IVnNuSk9nL0lOK25NR3pYUnpMR2dnbVEwcVBRZXUxbzFNV3o0WGlW?=
 =?utf-8?B?aDBnYkFhRUxSc3VFdGwvaW1LZXZrbmJMMFZXYjZ2OU5iNVk2SGtmWG1wYTJv?=
 =?utf-8?B?aVNVUUlUK1M5L0tKRGdrWFRSWnY5K0tzSFdrcjU3VlpNL1NEbW9RZ0ZJU1Uz?=
 =?utf-8?B?L1lsUVdjWTZNY3ZXZzU0YTlXSW5qNGE4eHRLbmJnRXIyc0x3NHB5a2hpRkZw?=
 =?utf-8?B?clh2TkpSVjJ2czR6Q05MdTRsa2lYbG9LREJ3QnoxTEZ4SllwR3N4SmVNVHF4?=
 =?utf-8?B?Wms0ZXlaOWdrU1ZaRElsQjk3THBZQzhwd0dJWmZjQUROYndHclRnNHZ4YWtm?=
 =?utf-8?B?R0pUUUhGVmxvMjM1RE11eXVyN0ZCNmZTV05zdHdIR3czdExIa21PeHJWYTZF?=
 =?utf-8?B?blhHRE5xU2l5U3ZPZDZoL3RreGRtVm93anNlRCtaS3BUL05sQVRlOVFwV3Qv?=
 =?utf-8?B?aWp3bUlCWUhTUnovYU0wOSttdE8wVGZCWmUrVjFMNjlHNndMY0tPREM1UlBH?=
 =?utf-8?Q?N7PF42USCSqSbiy9vzpX9OfTi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0d3c+Mfk7PtnLGjxQxdw9/DASwT0AZWc0KrpQ7kCG9c/LX73FS+nctchwRTpH0StvQoFaePu+9AfrbgIntZ0fQsVroMDKBBzY1IQOg4quYx46rCoPDxE2cvhnbBMWihWG4HMLFgnvmsExz0sFXvPkqRB3PZaF9Jc1+ViI/UB9B+RFDNxn/vMruyInW/94UPZaqkIOvk/thq/kKheGnBwHQAHV21JvbNPNjOtav/kfgmoWTbaxBmmmbMuB9VK385WU/axwv2OGKhR+74WczpWUsJklVqXM2Ctunc+lo1jUzLJXtDyGW9bxEuRDBZArPE5Tpn3uJLMFZvYbhuvUbQ533h22m/U63HL2MYknpu5Z3t+R/Z2JsPQgkJdNrsaMn6RhS1QY2m1Rt0aNx/9006ZIxSOH+NZ3Dbx9TbLm0hU4YEv4qbnNe0Gp5UylR0a4BzK7QL8ZqjRUjlp050l9Ge+Zg46s7LF9T0cv5GBQhzVn7L2sAQbHjeXkZcVxIzdFjpAIawYHOtHcSd/QWLp3mu+H9Z7yYbVUpVulbkkw3SMRmd4MVY2xCknQabHhWF2u+w9eUDmi3Ozg0buXb0xf97pGMF7fz/WvD9eJI1O67dlB2A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be71f8f-5bac-444e-cb26-08de292d53be
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 18:39:39.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbr2p3lLTd75hH0N+AN5hsHa0jkM3vxlt1GG0ma3RrmWIjMi7UY/lZNwV4D3g5ybkIrprc+IrA2vOjUcwMZQIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511210141
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=6920b1f1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Cl_zYlBAfxDI2oA5XcoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 43q8SaBwCdT7MNiPRhRr6KIYw4xa9iCA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX4cHc9lFz9QXE
 IGR4GJN+I1UcvTTUODt3YgoTPSYXtGF8UHl2hWQFk2i1gEMLyGKpcpFC0gTy4MjdpXi3TyYN07b
 XBQnaL2aFT8DlEh6HMHxiA7/liIhpfaLtASehBl8pcXppl6LU5gFSv/jT8P95mQSORtzM9pvWwE
 E2YdG5CWlZxf1l30pH/DVw7wBDeiE+ENlLoofeTvAGSIZ5zrbeTWyYuifBgxuk/J4xPE3ZSsvGc
 ht4QtdzsuKcknb6/vpgsKrEAY/+VlyyrksLl80jdMx3wYcS99o/0JFo7Jf8R5D/2dGjOaZQru/J
 NnqgK8Ks3Vzz/x3h4c+qXFCDNBUiMsFsKhX5rZ9svp++Fpf2TsVSAYQGB1nCnYB1Gn+gWjl8zZJ
 uZ57jIrJydeH+G1RZgi8dMgq2eY+Hg==
X-Proofpoint-ORIG-GUID: 43q8SaBwCdT7MNiPRhRr6KIYw4xa9iCA


On 11/20/25 9:48 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> When multiple pNFS layout conflicts occur on an NFS server, the NFSD
> thread pool can become exhausted while threads are waiting in
> __break_lease for clients to return their layouts. If all NFSD
> threads are blocked, none are available to process incoming
> LAYOUTRETURNs, creating a deadlock.
>
> The approach proposed here, although somewhat expedient, avoids
> fencing responsive clients.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   Documentation/filesystems/locking.rst |  2 ++
>   fs/locks.c                            | 12 ++++++++++
>   fs/nfsd/nfs4layouts.c                 | 33 +++++++++++++++++++++++++++
>   include/linux/filelock.h              |  1 +
>   4 files changed, 48 insertions(+)
>
> This is 100% untested and falls squarely in the "crazy ideas"
> category. I'm posting to provide an alternative and encourage some
> creative thinking about this sticky problem.
>
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 77704fde9845..6b0cb5fd03fd 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -403,6 +403,7 @@ prototypes::
>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>           bool (*lm_lock_expirable)(struct file_lock *);
>           void (*lm_expire_lock)(void);
> +        bool (*lm_would_deadlock)(struct file_lock *);
>   
>   locking rules:
>   
> @@ -416,6 +417,7 @@ lm_change		yes		no			no
>   lm_breaker_owns_lease:	yes     	no			no
>   lm_lock_expirable	yes		no			no
>   lm_expire_lock		no		no			yes
> +lm_would_deadlock	yes		no			no
>   ======================	=============	=================	=========
>   
>   buffer_head
> diff --git a/fs/locks.c b/fs/locks.c
> index 04a3f0e20724..4ea473c885a8 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1615,6 +1615,18 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>   	percpu_up_read(&file_rwsem);
>   
>   	locks_dispose_list(&dispose);
> +
> +	/* Check if lease manager predicts a deadlock situation */
> +	if (fl->fl_lmops && fl->fl_lmops->lm_would_deadlock &&
> +	    fl->fl_lmops->lm_would_deadlock(fl)) {
> +		trace_break_lease_noblock(inode, new_fl);
> +		error = -EWOULDBLOCK;
> +		percpu_down_read(&file_rwsem);
> +		spin_lock(&ctx->flc_lock);
> +		__locks_delete_block(&new_fl->c);
> +		goto out;
> +	}
> +
>   	error = wait_event_interruptible_timeout(new_fl->c.flc_wait,
>   						 list_empty(&new_fl->c.flc_blocked_member),
>   						 break_time);
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 683bd1130afe..748a1b1b0626 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -764,9 +764,42 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
>   	return lease_modify(onlist, arg, dispose);
>   }
>   
> +static bool
> +nfsd4_layout_lm_would_deadlock(struct file_lease *fl)
> +{
> +	struct svc_rqst *rqstp;
> +	struct svc_pool *pool;
> +	struct llist_node *idle;
> +
> +	/*
> +	 * Check if we're running in an NFSD thread context.
> +	 * If not, we can't cause an NFSD deadlock.
> +	 */
> +	rqstp = nfsd_current_rqst();
> +	if (!rqstp)
> +		return false;

If this is intended for layout lease only then I think we should
check for 4.1 or newer.

-Dai

> +
> +	pool = rqstp->rq_pool;
> +
> +	/*
> +	 * Check the number of idle threads in the pool. We use
> +	 * READ_ONCE as sp_idle_threads is a lockless list.
> +	 * If we have 0 or 1 idle threads remaining and the current
> +	 * thread is about to block, we risk deadlock as there may
> +	 * not be enough threads available to process the LAYOUTRETURN
> +	 * RPCs needed to unblock.
> +	 */
> +	idle = READ_ONCE(pool->sp_idle_threads.first);
> +	if (!idle || !READ_ONCE(idle->next))
> +		return true;
> +
> +	return false;
> +}
> +
>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>   	.lm_break	= nfsd4_layout_lm_break,
>   	.lm_change	= nfsd4_layout_lm_change,
> +	.lm_would_deadlock = nfsd4_layout_lm_would_deadlock,
>   };
>   
>   int
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index c2ce8ba05d06..7c46444a3d50 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -49,6 +49,7 @@ struct lease_manager_operations {
>   	int (*lm_change)(struct file_lease *, int, struct list_head *);
>   	void (*lm_setup)(struct file_lease *, void **);
>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
> +	bool (*lm_would_deadlock)(struct file_lease *);
>   };
>   
>   struct lock_manager {

