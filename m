Return-Path: <linux-nfs+bounces-10863-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DC3A70A1A
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 20:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740E2188AD57
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 19:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A66A1EB1B5;
	Tue, 25 Mar 2025 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JxTKWNUP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A8vmKkY8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D2A1EDA1E
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929944; cv=fail; b=jhRHBpLdsAT9dURKqrPc8al/dA+TZ1/R/EhhjY0yEntIxSG6fww9crZzlxCaaxf2ukwCuRs7mKYLiq33NUZFIFIdT2Ai2dhWyv1RS4J2mu6U9t+gPN1JiMwzFfch1y0OmY8jiNYFTZMZfQO8DCPWJsS9LjJhNZM5oiLtTe8eYkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929944; c=relaxed/simple;
	bh=gZdcM99nREQ4/5ijS2e3t168NleeRHdjTSpGQuNO4Ac=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WowZkRDmcLIbsr3q/bzBxz4DRtFrfm/k/IRz9R2BXxDwrZ2Yz/c1CEpdnMg5aibFbLcLVQyoZMsXvM1iLBjfelqFAvRuEmNZtRx7a5S4ORXl5ESlqKeicQDTnGhpoypEtRNofnCc066fXcg5F8ra/kT8zpx8Vfjni7dzNpIjZuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JxTKWNUP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A8vmKkY8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGr2BR017688;
	Tue, 25 Mar 2025 19:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aa7ZYMIb6P5pefZnQwAG3RGmeulttZnXC3yW66tpQsk=; b=
	JxTKWNUPyTg9RFyPeKIhAfDkFjqilb362jjlThYFxDNlKwSN3OUrn9uxuzOfUvVr
	k7H+YuvIIkoV5fiW7LUgew2QYMy9EQFRGt0GgKa6Pw5uM88wlbyHT6JMxMcc20Vn
	8KlHfN/d9/ajS1bYEiF2zg64WPqXoJvt36boatukN0QFoLEaQGpoAOEETva1Wd+4
	hPzwfnyOyEzBYztCIhLgUStApk/mhcT7b/brQ9JWCz8VTvyvilj5BwQhvS7ElCQ/
	F4OdsOi54ZCAyN74zyBptlcMH9qCYnUxm91yUILnfSBFA62Hsp2W+tKY8LFojiRf
	mw+RI2YYoYA4MOgKNGefCw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnrsfy3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:12:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PJAbI5022834;
	Tue, 25 Mar 2025 19:12:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jjce4bdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:12:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0nlYIzokR7avBVEjnPYvg8tV9a/ebq6bsvhZAUiPvPWH4n6kcS+eItr5ihbInK3pjNjZdho4/Q3+biBekmM+8VoBkV8XYDhZtpacf+DVYnlv2HP026xKLa5gYKG7xZtqaaxI/5JDzoNNc8RADXL+p4N6Vh8CYdCS0CyiHndNqiDmfndU1mdIrqKUtpi6+RljDADgzYG8MLA1jN4C/xkO7x8/qrN/KIt5gDjBjRWyJgVdAfacGM+ZkPUvN9ZPol3UK38cjxSRA2Vzw84PbuacFllP6JgLbmpQsNiTn0jhhdG6J7EeH7OrXousVNnzbXF+AoT4cdOHUeQ1vpgxr1RMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa7ZYMIb6P5pefZnQwAG3RGmeulttZnXC3yW66tpQsk=;
 b=G/Jus07RvMrr7biZbRX3ehrAsXbOqSUoBESY51PuC6MyT+lbC2QqnYaBaS47Gvs0OnFJlfyF1ANsTgwbBJzMOVzECRUGQCj07/8wLnlY4nsKw2v1v/oamMKE9UKeynAYPImx50yt8SuoQJnJ9K4LMjo6iZn90SXUH19I9/K7XnDlUuTjmMsR5bYxAcljJqtOIbSoKOr169CPhzu6rZnySgk/7e2H+nAMEBkc5YF9laRMtL4D9ck32XTUSfsaOopO6u7y80bJIOFSpvrVc9uYdLnbF1pd2TYkXMPdazuZoEsAO/fD6R/adoKpSKGrIo5Jfx+V1KyyEez+Lc++iKR2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa7ZYMIb6P5pefZnQwAG3RGmeulttZnXC3yW66tpQsk=;
 b=A8vmKkY8DsRgchdMLHgqyI2Zk7D3mT+oDUR1lx1uPxDB4JclET7D9bjwFPZoRVTWiZYtB7xR2DHi+kmG80NrrJU/P9ZFPNs6EaOgW4P6FBYrFhvU9rDv4JAz3a0ram68NtcpdmxB9onwiFcHgWsSicIXV+kcgNmltehhDk7zeb4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7932.namprd10.prod.outlook.com (2603:10b6:610:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 19:12:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 19:12:16 +0000
Message-ID: <5c458e04-4be1-4b0b-af99-41d258da5d7b@oracle.com>
Date: Tue, 25 Mar 2025 15:12:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Using Linux NFSv4.1 RDMA with normal network card?
To: Lionel Cons <lionelcons1972@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <CAPJSo4V8WnCz0rrdHK0SdvrhKO9Ex-BONU3bkao5wziCnXfJ5g@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAPJSo4V8WnCz0rrdHK0SdvrhKO9Ex-BONU3bkao5wziCnXfJ5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LV3P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f70ad6-50b5-4113-0403-08dd6bd0f51b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlppcDl2ck1HMXRjeXo0Z21aclJuamc3WlZpMjhJQWdDZDF5ZnZSNWx1S0tv?=
 =?utf-8?B?MmcrcndpcnZWcXFPcWthRkQ3TmFEM25Ub1NQYlpYZWJzbVV1UkU4NzRtQ3FJ?=
 =?utf-8?B?R3N2YzFCMHI2ZGx0cmMwVld1NmFMTGppRlBwbWV5YUJ3dXZsZTBPZUR3cUVa?=
 =?utf-8?B?bHhsMkF5ZGp4OFo0UWIyUmlMMHNtMUNiNmIyWGtucHlWL3BnN05IbjdlNitW?=
 =?utf-8?B?eU5tMGZEb0VBQzNTMVdVQnNJNU9yOEsyMGc5bTJMNlJ3NzNOekJMSldJUTE1?=
 =?utf-8?B?SUV0UXQ4R0JlVWhuaTZ5TUgrUnk4MERDQzRxc05WZjJiV2hDRkl3THhvOS9k?=
 =?utf-8?B?RGxPTTJkTWp0eFhjMWRRTllWalhwYndFVWJhQndTL1kwcXlsYWxyc3BhaWtC?=
 =?utf-8?B?bWNwVUJnTC9TVy9oOEF1RzlTSGhkMXZjUWhLcUxXa0VUZ3ZkTlhQMHJGcDhw?=
 =?utf-8?B?Q2dPNVFnK2ErUVVMQ0FqSmszbVV4TEI1M0RMaDRDODMrN3RXTnpOZmY3Q3Vt?=
 =?utf-8?B?UDJoRzJvSGgrSUVwRlA3VlFKdjRibkx3VXBHdE1PenJPdldnTmxGaGVCc0hi?=
 =?utf-8?B?Rjh3M1UzTUpmQW1HRnZGbDZhMWxyNVpSTjFXTEJZY0NUdTVhNm1ZVzRVdHBV?=
 =?utf-8?B?V2MxRmFNYTIyZFV4YnovbXRUSS92NW05Y3NlY1IvTmN3ZUJDVTFJeWxqbEpm?=
 =?utf-8?B?d2t1d3pyQ2dXaGoyakF5d2YvOWJqcFZBQWNaekJRbGo1b2dMR0pQNmtBbkVQ?=
 =?utf-8?B?T1AvU01HdjNXcEpaZUlBdDlBUUJLQWZOS3ZOM0NTenZZUllkSnJ6bkNZaXZm?=
 =?utf-8?B?c0l5dW00S1M4bHpmVDV6dHhZb2YxS1MzdXgzZ1lleFlJVnFrS2dhdFQ1a3JM?=
 =?utf-8?B?K000T3pjT1F5cXB0eFphU0Y5UzQ2eGtBMjdybE5tN0tHUWxhU1dQMnY2NVB0?=
 =?utf-8?B?WG9kU2daY0ZZZ2VWaE80RG9sNitlMXV4VWdOUUZuZUhiMXN4b0F3S1BaYlQy?=
 =?utf-8?B?eEpMZUtJUlZsYWRvbEUwTzluSldOMTZjMVZGYjlVUC9OTXRjbjBXWWttVjRq?=
 =?utf-8?B?WGNJUGdEbnJnbGkzOWxzbklmM2xYZTc2dXpjQ0VBSzVjRlY0dUd0bGY3NXEr?=
 =?utf-8?B?djV2NjJoU3c3Y1h6ZjJHWWtFdk0xUTBTNDBlaWJXUmhKd2YyTnJVSXNlUjRl?=
 =?utf-8?B?OXNETEZjQ2ZhL1A0LzFFQVJ2UFZxWmhaaGJiaUVyOU12RXBGbnNKSDA1MDJV?=
 =?utf-8?B?MWI0TVoxdnhEOUZDQkhubkhSQ2NZN3JJMlF4cUNQdFJWRzhDREVyemYvN05T?=
 =?utf-8?B?bXVyK0xYRlVEM1orN0FvU2NpQXRXZGJJbkIvd2pJT05IUmFsdTV1c1IxV1BR?=
 =?utf-8?B?S1ZmYVNsc1pvTHM3cUlHRUppSXcwNGxFcGJrSGxGbEZ0TkRHT2dhYXZBdkxk?=
 =?utf-8?B?UFMrN0YrZXJocTVueWl2a1RXcGt3RWdYRU9ObE1BVTk0eFBkcWZveXVMUVJm?=
 =?utf-8?B?MFFKZVFKTkRCUjdaVWlsRGc5NWFna3RwOXRUV2d6cnZCakpaSExjOWRLcTJx?=
 =?utf-8?B?YVRsLzZqTGZTeXBCZVBwQUcwOUJoaWthQmFRcVBGVlUzM1ZpeVc1TWRIWEZv?=
 =?utf-8?B?bjZKZjNqS095a2pya1c3eE1tWldsaXc2c1k4ZTV3U3A1SDZKdGo1M3c1VnA1?=
 =?utf-8?B?aFhocmVhNjNSem5NZUhjY1ZVaDl5RDJlTnpETWFBQTBvKzNVN0VIbWZCaW1C?=
 =?utf-8?B?SDhkamk5dnU4WFZhSzNtNzhJOTNKMlJJMU10enZyUjl3Q2ZOQ2VXRlBUNE1l?=
 =?utf-8?B?bmtEblc2ZW9xZzZYNk54bGxNMHZjUi9JazRvMlVxYWZrR2gvN2lFUlBSejdP?=
 =?utf-8?Q?s90aMfVt8AnQU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWJkalZ4RHhmREdJVXh4VXM2WHd0Yi9TYzZyMkhqcndSK3ZqN0JPaFcrcnkz?=
 =?utf-8?B?WFZ2SCtsRUxjZ2RKM2dWWjdBMmFNcEozT0E0RTJkQU5oL3F4YjZWYTJTWFk3?=
 =?utf-8?B?cndqUEJPZ0NrVlpIWjBjNjUvWkhOU01IMUljN0d0bGdVRENONVpLNXVWeEJ1?=
 =?utf-8?B?RmdhSmNHRXE5M1RQNEtaUERCeHRWaUpmT0RSc1Z1c1VuOGlWeUpDVGhPSTZz?=
 =?utf-8?B?ZUx2dFpuSVZTNldsZXBCaXJXNDdHaFQwS0d4dEJoQmZLa3laZTNwVzBUN2cy?=
 =?utf-8?B?dWg5aWpXZTkycXVyWXg0Y1BpdDAvTlRYNFkydGZnSVlkSVlqNXFnajk2cnNV?=
 =?utf-8?B?RjJTVlJ4alJhdDNsR245R0o2clB4TmdhWTZEZ0xBSkxjVFo0S1NWZ0xMby9j?=
 =?utf-8?B?NWx1Ri9OUVVqQWVHaHNPQmI3M1dqbXpkcGgwY3BvNkNmWXVzQUVkWXJQdGpm?=
 =?utf-8?B?emhQdmJNR1RQNzZrUmgyYWlyV0hLVXBib1p6aGJaZW9uQnl6NlpNc0pmbDBV?=
 =?utf-8?B?UlJDL216bTZFRVluUGxESXBlV3JFS2VpRjJSVS9pUXc4VDZoZWVkaXZKWHVn?=
 =?utf-8?B?ZXVWZk5ka3d0dk9aQkFQekRNY2p5cnRDNUI4L3g4V2F0Q0V6dE9OVDlQUllQ?=
 =?utf-8?B?ZnNnNm12Y3VOUVVCaTJrOGUxdFVIcW8rQ0JrbzA2ZU5CU0ZCTlhVTjJSQ3VQ?=
 =?utf-8?B?ZFF4WUgwalVwZExvclRodVlFWGNZc1lDN0RWVzZ0dDNRL0xoa21JZXNTK1Zx?=
 =?utf-8?B?UDYwSHdzdEExaWdCUllsWStoemsybVYzZk1aVkdERUV2TmpJVUtPR1NGRU5G?=
 =?utf-8?B?eTBBd252dzkxZEp6Z2c4RDVZU2JrYXRldzhRbUJCNWczbmZtaHZOYW1wY21Q?=
 =?utf-8?B?VFBMQW5MTjVzNTZXbGdPSlltVEkxZHI0OS85bDJieVh3TkZ5TUxtbEJuMHNN?=
 =?utf-8?B?bzREdUFtNkZIY29NQXJjTjg0bWYrUk9vcWt6aVZuaWQ4NmJmTG5xQitNejlm?=
 =?utf-8?B?aWtvZHFZT1B0V3llVlI3TjUvVzROUmFsUnhJSWF6cU9SMXlhSlFoM2FKS3E4?=
 =?utf-8?B?VitzR0ZqeHFYaU1COGtWeTV2RUtuWEtmVjdsd1ZhYTJ2YTdLUDJCcVZ2REUz?=
 =?utf-8?B?bUxWTVRYTlpEMkVVQUR6K3VSbFVRVmFWT2RNZHg3cFp0c3hMT21UNEludFM5?=
 =?utf-8?B?U1BKYktqRG96T2tJK3RKMW9nRzUwNFpyUUx4SHNLWkxDOEVCYXJUYWZEZE9S?=
 =?utf-8?B?SWEzanM2TlQ1NXdXb2lUOHEzZTBkTENobzVBTzl5MC9nZWwwK250Z1ZXWDA5?=
 =?utf-8?B?RUpvQjJ1OExUVHVsa0RhWVl0TDYzaGdnRTM2Y01COEloLzJLWFJaV09wc1Ix?=
 =?utf-8?B?bnoxclpZSVRKMEFDQ0wwMWVOejJsTmNxamNNY25lVmFteFVmVWE3bGZIUElU?=
 =?utf-8?B?U2MySXJhZmpYMVdsV3FuTTkycFFwN080bXBMc0lFUnY0djdqNmZ3QTBkVjdw?=
 =?utf-8?B?UDRXKzVReStJUDdyaGJ3WFQ2TW9tU3BSSVhhbjNyNk5PZWpiUTNKYXl0V1Fl?=
 =?utf-8?B?bWgrM1hOQTZ4Rm5iU1k1emN6OWhPRkpQWHk5b1BOM3Vtc0szTGoxakQ5QmY3?=
 =?utf-8?B?dnpCUHhEWWs2QndWSU5lWFRTM3dPQ3puVkxvVlI4dS9rbDRNQUIrZGp6SVds?=
 =?utf-8?B?S2kvN28rWnlEc2ZKMVJ0NEVGN0t5OUlXajRmbW14cmN6QnJmRHJ0S2VDYjFI?=
 =?utf-8?B?aWFiTFNBamNQcGJ4cnRvdXkwQTNIZVZhMk1UdldVWkdZc3pDaXVkL2VjaDl2?=
 =?utf-8?B?ZjRBWUFidUZsck5WK0I2Tk9NUm1iRGFtTVdCa1BHSHZuOUI0K2ZIam1PSkhp?=
 =?utf-8?B?aVdaTmxLOHJEQlFsZEMrbUxWRXlWTDd3OHJ0YmdOa05PT2lTUDZJQkp4a0V0?=
 =?utf-8?B?NTNReVVRN3krQmNFNURLM1p1WE1TY2wwWUVkbHlpcUtmNkQ4T2xzUHpMcHVZ?=
 =?utf-8?B?VVUwbHdpVzFUc1V3cVVMQVhoQnlIU1RGcFdEQmNiQzJoeGQvOXl4a0hFZGVJ?=
 =?utf-8?B?MFk1N1pkRFV1NzlvYkxTUnFzOVpkU3lQL0ZYdFhLdnNrZ0VpTEg4d3d3WXoy?=
 =?utf-8?Q?KCEtSZ9PwOeAjA+BlNqIMB0wi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F4cdjTE3myD/hcSYqKkFEFEX7b+NwE4fd13QhhReTenD0x206GUnOquJ2JaiDDSTyeftQ+iFrFsCES7mrkIrmT9kZRPfMDXBY16eTOQM0hqoe8SYCGjXVUOw19DyWNbbQS2p+NpFt95Wp6QRKJM4FWidCsZ/4p+QSI8PABhx9Ij7ikdarvcQLsXft0p+LYzGwvJbm0sNP8U6vmukkO8bn55Iy0/fMwenPN7LMlE6S88NqJ2752BMNeut2RlAG02IueHKnR5Gfw3FrrTm5TyDh6P/sX4p/mgfdAerw2AcsPNZYCRcXfXYTIC5g3lmCcFBhRTPFmgKF0jv/VxyM7CNKPNBh6SNuUixTH9xpbhvL3ZPCFPqh7FNeNPp/n66WL5PjfWYJYN2zHVJROBZDJBcxRDgAgH9JpAfpRRdUJCk72WROYI2o+vS7oX8aJ2WlHvskt/wTR+kUWW6qRPULy0DK7P4ETOHN6jOrj6vgbDhByBqP6HzFb0be31BtrQnFuMke+xP9JfV2+UCOqyeMO1WrvVZw2ZfWBayRQb9Rik76bjwB1aBr3eCiBj74dx5mgCJf7f4lWX1/1WLAeBYSNWqwcgEZpMO008UJseZhr6etPI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f70ad6-50b5-4113-0403-08dd6bd0f51b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 19:12:16.7475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FubILk8Dg0TPGFU3z/umO6uqXmKOyFeVCx4t8KmtakFCx81Sb36BrvGmn6qc2bQj+gUWako6fW+mcmwe7NviIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_08,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=974 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250130
X-Proofpoint-GUID: HKXVlla0kaIIbTA0IMwAE8AeY5Eydf-e
X-Proofpoint-ORIG-GUID: HKXVlla0kaIIbTA0IMwAE8AeY5Eydf-e

On 3/25/25 2:53 PM, Lionel Cons wrote:
> Does Linux have some kind of RDMA emulation for "normal" network cards
> (e.. not IB, not 10000baseT) which could be used for Linux
> NFSv4.1/RDMA testing?

Linux has a software iWARP emulation that works with standard Ethernet
devices. I use this with NFS/RDMA in test scenarios all the time. The
driver name is "siw".

Linux also has a software RoCE emulation, same deal, but I don't use it.
The driver name is "rxe".


-- 
Chuck Lever

