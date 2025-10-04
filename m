Return-Path: <linux-nfs+bounces-14981-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF2BB8FD6
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Oct 2025 18:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140A8189C272
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Oct 2025 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554901917CD;
	Sat,  4 Oct 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bGMZE1EH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nbxek2Wo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFFA14F70
	for <linux-nfs@vger.kernel.org>; Sat,  4 Oct 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759595979; cv=fail; b=FPrcXyCON5VJXLK2LPTA2rMEZbMsnAVlFRAKqZO5wuc87VfU+Ju/UpiN8P8jLuj5Qj3ttg6TaffQ36R/NiFPqTJ3F9Dd109PE3VZENG3Pq+4tFQrUteWH6ZFwFA9LwBMCXtx7iBxir5hrGKvtCphxT4YgpDb9bIL3trMMgqrQ4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759595979; c=relaxed/simple;
	bh=T8UYPiIK+S8I8BFsudj8qDnCj6XbjY2NbeVzzrzbtLY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cWRMkvCWRPmb3tRPF0t+NGDN9+7g1Q9nAiX3+en3pPNbh+ZBhkUlA/HqjGKhtSPu8jrjImb36pmXMzl3ssNC1RqFHcT2shaFmDkyeQthH5vaDvpXi3DRnS7bfEgHMh719XhahHorYrd6wZzZv26GI31cmpg5CH5lFYBFCIwMg7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bGMZE1EH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nbxek2Wo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 594FNTKB012814;
	Sat, 4 Oct 2025 16:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JhXmMUtAKRxXJ5sM1pntQ0vWDmB1bW88o6UBB5xMFZo=; b=
	bGMZE1EHcXDCRiqkopLmgFSLVJEemAqzdt17UixV2k2FUsUkI238oQb8G3aQHe5p
	2kAEXhAlLZZKXCLQdz6LiMpxAd/6+eVZX34tAulrbyowTUAvuHsvHYHHUkK1iLE1
	qhdYBes/5sMizuFJUPeIH6adxL7SR3zZwz/OJcr3tHpZFNGjlxOYtAPeSg+owJTG
	Lcys7SDZm+1UyMFfXMLmGuyEW1qKV8V5buvdUG3ZynPHJJ33u6kTTJNV0GuBtS7T
	HNK7/thoCMVRabTUY5k2ikL/44RL811VZ2oyJhsrbLZgzvXKuHHm8QCfHV0b1Uij
	8v/F7kqQBQ58GpRBJZTqYQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49k4eer2kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Oct 2025 16:39:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 594C4Z7w022684;
	Sat, 4 Oct 2025 16:39:17 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012010.outbound.protection.outlook.com [40.93.195.10])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49jt15dmjh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Oct 2025 16:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGhMIzKuHG6VMED5OcthTmGFW9SbtZLH2MKo1M/a2PrOhjcyOvkollxPnYKYimdHhObCM5RhifS4wJXJ3UAtPMzRWWaTo6EkYv68YmIqlIcafBllRS6fSdQLT2tRLoAgr5We24D5NkH18ni4PH5KAmuhbnikxPewmSNx7KKACLol9WCKJ/JbU5lilnpyFkKLhk0N62ZBK8lhJMzM9vf4ljEITrN97WCkD0inzZ2it297EhfAhwQaU+XKSzhB1PBD7htE4aKbjQm6HIL9CZ6YUeeQqqcdFvsmPYB2wAYJswLGUIjK+EpESpkU8bvbpCPzkczcjiWycELyaiboAaHdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhXmMUtAKRxXJ5sM1pntQ0vWDmB1bW88o6UBB5xMFZo=;
 b=GCFDCxIBaZ4Sg2pKxGGw2/7rbQDRXuwpJBAY5YKUQp2w9UYCyYxHqpxO70KUUrFOZ+VZVg2yRlN+04o/3p1E6Ect2T/NMuWnklK32GmfDuPT66uZ8SBVkjemfqZXa3myKe7vBJmOzBKP7blqJkDsMyBTy7TVd/sRB5VjbzYIvBQVXm1NqMd/smqTFujPOFez8GWAoK7qeGwRXr89Bnf4T8LuK3QIQ/HBbi5D7y+TpSrafVwEEgMTJBqphe7lH0SNjObJz+Ge61mdJ9pHnHfSVxbyQjaQJfQXoj5qaG6bcCK2dc1xpe2wg4FVEIwVUKWmbVCBqDXEmTQ87NZz5OcuvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhXmMUtAKRxXJ5sM1pntQ0vWDmB1bW88o6UBB5xMFZo=;
 b=nbxek2Woub0HrkDNKoXsArf5vz84ynFVXkkXBSZ/KmJFNJlYG81zrfMMhO5OvcZ546xzNjcOQXWT3cievq+IfNbbZe7w4PhnuzGioJWMNVbZ/sVDuDFxlat10OFPJRlDyrBty7nBHHEIRcHTpLpaGf+iTBVJ5vyWRckEJdUmcC4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5703.namprd10.prod.outlook.com (2603:10b6:303:18d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Sat, 4 Oct
 2025 16:39:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9182.017; Sat, 4 Oct 2025
 16:39:09 +0000
Message-ID: <c3628d57-94ae-48cf-8c9e-49087a28cec9@oracle.com>
Date: Sat, 4 Oct 2025 12:39:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: buffer overrun in nfsd4_store_cache_entry()
To: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Cc: rtm@csail.mit.edu
References: <91299.1759585988@localhost>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <91299.1759585988@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5703:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab08a82-b4cc-4a6e-057a-08de03648ad1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?T29MbWR0YnpiVDFnTkxCUkxVL1ZISHFvWTRsTFZmQ1VueGhiYkhObkVLTzI3?=
 =?utf-8?B?bEMzdk5HNXR4bjRGT1orV2s4dG1FZ3hNV3YraUxLS01ndldHSTJuQ1F0UFFD?=
 =?utf-8?B?Qk1FN0thQ1ZTVzcvdUdZWGhDVUZTZjBlZTVVd2tuR2hDa0R4b0liVTNKMVRx?=
 =?utf-8?B?MGF5UWdLL25Sa2YwbTBvUFZ5bTVjd1o5ZVhTa3FkNW8wVm4wVkxvSWwzQkcr?=
 =?utf-8?B?SGw4Vzg3MGpXbG1zKzdWL2JqZExzQUxjeVVlMkcxUDlub2FGOURLeEJNUWl3?=
 =?utf-8?B?RFV4V1U0Tm9ZTmMxMmVTNjhYVFNFRVJpTVZlL0tEZy9ISVF6MndtSXRSV05r?=
 =?utf-8?B?WXVmeTZyL2RSNGFMR25uVEo5cEo1VTU2TkRoMUE5R2JmMTh6REtCYVpodmty?=
 =?utf-8?B?MWJqWXBteDRiLzZQRk1BMUZkQ1J5a2JWUWdjd2pqaGFPTDQrZEpOQ2xIeE9k?=
 =?utf-8?B?OXF2RmdlZG13VW52OWZvMHR5Z1FzYU8rM09aUmVYNElXRFBnbm1xWnAyVmF6?=
 =?utf-8?B?OEszYmZkd3NsMkUxYXU4Y0UwVDNhMkNsNnpaalBrOEtFZklEeWJGaVhJeHpG?=
 =?utf-8?B?Tlo1RVk5Y2JPTVpwUS9VbkZBQ1BRbzZKTEdWbCtpdFVsRHk5Zk8wK0Z4WjdO?=
 =?utf-8?B?OTJOQWFaTFREOWxVU3ZVREY0TVYwa0w2bk1EaTZpdWtzNjg4NHdjeXZYN3hQ?=
 =?utf-8?B?L1pSNWhQV285aSs5OHEvYlJjbVhxS2l0SlNwQ3NvSFgreVRiL1UwOTdVaits?=
 =?utf-8?B?OEhoUlZROHBpSmNsNll3WnJGV2NMbE1obnBUWkxLbS9qV0Q0NG9QbjYrVnV6?=
 =?utf-8?B?ZUx5OWUya2xOQ2k1NGN4QkM4cHBvbXM1MlVjcy9LR0VMQnhWR1pqNlc4Z1l4?=
 =?utf-8?B?bVJlM0pPeDFoVHVyaTZ4bXlTQkM2cFZzSU9zZVBxU05VNHZEOEJyRlExRDZ5?=
 =?utf-8?B?aWZGN0lxdWRKSnRjUklRSzZjSlZLNnhub0d2aXVWS0FvL0s0akNvVVcySUFy?=
 =?utf-8?B?K1VSY3FWd3hGWDY2VHZnNytmWTE4SDZuTXVhVGdteU1uaVI3V2gwSU5jV0pu?=
 =?utf-8?B?WGJoRFMxVHo4L2VFTzlWS3JYS0JVZ1UvUzJSMGxpakFUc3Z2MTZGV2pXU1NK?=
 =?utf-8?B?KzJwZnlqaWNOdlgxbGJZNnBqdHdIQzg0aXNETTVxOG8wRllLd2E5M0dkWGhp?=
 =?utf-8?B?VXJqSW0xQ0Fvcjk1cWxSY0E2VmIySEJYQnhKaCs0MDJxWWc5b0xaU1VmSWFw?=
 =?utf-8?B?TzFOUkh5dEFGRjVSM2IrdDRncGl4cTZoUnNjVlNFRk5vNkxUMkxpNHQzSGdS?=
 =?utf-8?B?L1JOc1dYektZYktPRWVBbEJ0QXRXb3pYSUFEWHFUTWw5VVlSZGZkMzgxWnhr?=
 =?utf-8?B?ZHZsYmVMN29QYVVKbVlOYzFtenJMSVVneEcxVUt3cElTbTI0VVNzdG9CMFVE?=
 =?utf-8?B?cGxqdXlQck5nMUpFUVNBT083VnZWbXJtU1BDdlM5SjYxMmpnTTh3ZlplUHpq?=
 =?utf-8?B?Rm5DN25yQlV2SUxxdFVkY2hTVW80UWEvSlBPZDI4TGxZaVgrcXU4dWJ4Q2t4?=
 =?utf-8?B?Q01ZbWdMZGJJU3NrUHVZejRPelBNZzVNQXF6Z2x3YWhPeGp1QzJVaWNFS0VF?=
 =?utf-8?B?blNjeUJTNHBhK29lUC9MODZJRnRhSFhoZ3hlcWhzWFZqWjBqKzU1UG9EbEp3?=
 =?utf-8?B?SUdkd05iM0tEeDB6TlpxcktEa1VEN0x2Mm1CelFzcmFHN2hoRXBpVmZnVXZE?=
 =?utf-8?B?VGlzbmhVUUtrbTNTTW8rbHZudmlOQVhuRmpPRmV2dUVBSWw2NmdmVUdXek9T?=
 =?utf-8?B?TjFvUHpSZ0pQK0NaZ251TWNnVGxnSitMZlZLUXNpQStOVjR1Vk1YNjhFSTAv?=
 =?utf-8?B?Sk50WWtYNnVUY09JSVE5ZDY2SStReFBQdHl5Q1VRZjgrQ3FzSmpDTUQ5STRv?=
 =?utf-8?Q?RNFo/MUbOVBKpKgk9NpaYuDBlngBbOKx?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?S2VXbWR3TVV5eGRvODdTc1pDZHhXYXhsOFlJbEdsRkZLWGxUczY3UFFUZ1oz?=
 =?utf-8?B?dkw0NXpQZTkvTUEzS2hYTkNPRFh1NHhoNzNtUlZndnEycVdPNk1BS3dBM2N3?=
 =?utf-8?B?aXVtcGNOTytuNTlScVZzM1l2ekRKcHUwa1R5VU05K29TR1g1ZTNEbEVZR0tN?=
 =?utf-8?B?WW1UbTFKV2xOS1Ruc1gxVW9xL0g2ZzV6WGY5KzVjTnNLVy9pcmxIenNuMEpl?=
 =?utf-8?B?SHBwWE56R2c4aHhGVWJ6OG5ScWtISjRkUjdyU055aEdLZnBHemtSUURGOGZ5?=
 =?utf-8?B?RnZUTjFkMnEyVGlBMzI3UmpxcnhTTjVBUkVFR3ljOW5Ydjl6c3BzQ2h0L00w?=
 =?utf-8?B?WnZhT3U5V2gySmRJRFg4b290SWYrelEwdm1mRE9Oa3Q2a2FsUFMxYm5kMTQx?=
 =?utf-8?B?bm1vdkNibEM4YWI1UXAzWjRhS3JUOEJDd2ZySFRyYjA0c2F5MURRVTZ5K2Mx?=
 =?utf-8?B?U1BtYTlybjA5dWVBT28xdVVhQzZnU3FUZHRGZGNyc1ZtdFFFd2VXb1lvTzdm?=
 =?utf-8?B?OUxSQ29iZ01aV09HVmdSajIrOWZaSEJKeFZPeWRncGZhTGoyYjZrR2VVb0Jh?=
 =?utf-8?B?b1c3U3BFQnBSNEh6VmpqZkdMWUQ1MHEyV3lSQnFZN3NBR2tvUnJ1aitWSDFU?=
 =?utf-8?B?YUg0b2MzZUR2NjViclpleERGUWptbkZmSVBPZ21YelQ4eElkZGZpb1Q5RlNS?=
 =?utf-8?B?eFhRYkN1eWJtS2Z4SWltd2lHNkM5Q2JkR3AyT3FtR2hsOTArdS9ZaTNhOWVx?=
 =?utf-8?B?RnYrbFV3dWRBdmRJVnJEZHpyUDlJTXpHZHZpNlhHSHJLcHZNd0Z1Y0NkNzZX?=
 =?utf-8?B?Z3ltOWY1SGFQa1BEQ3FHQ3BKeWtsS3RxakRaQzBzd3VpOGdqc2dYSVZQd0Rj?=
 =?utf-8?B?Y2RVNlB3RXgwVzVDWTZ5QkVNaHVXSzhQeE1WY01LaEZrS0NEd0RXNm9ESUZk?=
 =?utf-8?B?c0NmazkzcVdqd3hTbUsxSkRVS3pCNzBIaElZd1pGUzdMNHZRb3J6Z3JFSHd3?=
 =?utf-8?B?QSttZnV6dWR4YzZ4MzJXQjhrZG5HZVVLWWEzcmtVaVB6cDVCc2RFUGxRUnhR?=
 =?utf-8?B?d3M2VU5GaklldjNwdUwvRitDNm44UGdnL0pmMzhZcE41UFBDUXhjR2oxV042?=
 =?utf-8?B?OW1Sak9kRXhnZjJRTUtMVVp2Ylc0c3loZGFoMEZucU9HTU5zeEFPOWxxeE5Q?=
 =?utf-8?B?YVd2bWZMekFPRC92eFlTbzcyOWNXdVFYN09uUEJYcG1KYS9CYmJtU0xZV1Y3?=
 =?utf-8?B?RUxtYS84R1hYTWpyNG5MNnNWWHhzNnNZT29jdGRmTFBvd3RmUk82enJEc1ZS?=
 =?utf-8?B?OGNNNGpKVFpQUTVkR2o5cXpvTEtQZzdyZjh5TVpncUQzTGtubkRrNVBuWVVw?=
 =?utf-8?B?dXRlQzlucE9pZFgwdzNMYy9wR3h3QTl5TFJwU0hoSXhQcWZQbnk5TG5oSkFM?=
 =?utf-8?B?eGxXWWFCNmFHWFB6RENWUkU5b0hTMjQwc0tvdXJNSCt3VU9qaDVtNy9Da0Fh?=
 =?utf-8?B?anduNU9jY2ZkRldVSjlhME5Pay83K3NVSExKWXBNZ08xbXNJQVZFOXAwZ2Jz?=
 =?utf-8?B?b050clBBdmtDOHJlOGVGbWN0UkJmSENONHBzZnIySWIzY2VraFZIMGpYSUVo?=
 =?utf-8?B?QjJxNXd2NFlEQ2JNUzFVV1M1WEhScVVaaVFFbGh2SmVNZ1ZJUmo4c0s0V21C?=
 =?utf-8?B?REVPT1htZ3dqZENySGxJSzlrVTl6VnM4Ukh3TytuQUdWSEhybkR5Z2NmUWsw?=
 =?utf-8?B?V1JMVVRLVWFwTkRYQUdGcFJHam5Fb0k0ZDJWRC9TZ3BoZDcyNUhOLzFzU3Ft?=
 =?utf-8?B?cmRBOFVyem5KTHdjOUNjWVNndE9aT2xxWGhVMXBoaXpZSWR0MDNXcUdiTFZ5?=
 =?utf-8?B?MlhtTXc3aEFEMVV2WnJRVEwrWHF2R2VxcE11RVdVK1JwWUdmRzhic0JVSUlO?=
 =?utf-8?B?N1BkVVhFVmpoRzkxU2lEUmFPWUMzeEx6OVdDVjc0MXZ3RXBkUUdhcWk5bW54?=
 =?utf-8?B?VHYvOWNZMDFYNzZwcGFnOTVxckxSVmp4RmlMa1Znb3BkQ1Q4V0lYUkFDVVRD?=
 =?utf-8?B?b09mVCtoVS8yR1JWTlVkRTFOTkhPYlh0L2VnN2VqM0NNc3BZcG1tMkVaTWRZ?=
 =?utf-8?Q?lohkIa/eGKSH1Y4JesdizOrL5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L+n/cCxnLBihhPaQrCcIZDw3L0Mg+xmchzS6DXKZuBj2i231M9ZBqqwKr4GVLXcbSAPNnE3K5lwe/JbiIo5G4+ua8jGpVqfRjMn72wZD8eLUmrKruiszU+6y39mk0XjdwRDw/btXnvLPDoH1Yewrdmq9eLoJ58oJ6y9ambM2uQC9tYJzg6gOvtfLKH2V4vzeqqCxZOhWPMDS//aKjMSF9stkeTGwPXVRXjQg0zeUMkoGQZ2Cy3lywtVHj2xPx5Z/JMwPTrqqyFdNdw95rvAbuR8Ed6oiLE5UKowaEcILVCeXxhWnns+/K2Wjc8kB9cLnBxCb24or0auKpenLnwE11djD1bRJzWk+rF2k3rD9pP86h3umNE4smA7c3BK/o5xAymR0Buun4n8MB3wAT51XpMXwBCcM+oxEz2YDhwd0NX7SAyLH9rAKtyM9w0HVMVVUs5UodOYznjhWraZWFxnTnq1JT8ZGkd8k46Q6ba0FHpFFBvuX6IuKj/TMkIM2oJCITEQXNEsVeKXuq2pWE93ueEdXoGavatLNUimpXMNycoSPa7sNCCt6Y1XraUrmJrNT5TjgJAqSwtv1eagfzN7JqWpZV+6Ox0WcK9MU4hbqQ6k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab08a82-b4cc-4a6e-057a-08de03648ad1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2025 16:39:09.8177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYe+f6InUfLBrsbMzz3J6uIrJ3WYqvR5B+4M/UjJZDbfndLN2ET8UHLaRcp+4ktIK00YLnNQS0QjlMHZ3Sy6sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510040146
X-Proofpoint-ORIG-GUID: -fxJKSgz_VRijGAvdWBr5ozdRly50NHJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDExOCBTYWx0ZWRfX5f3l9zV9BJ+2
 /44oZo/pAUpc6PJHPB2W+AKwdNgwpHfpg+gS2P6HHc3/xdOO7lDF5nXCmYhx3zXc+wCUwMqNtCa
 IinHGGlVkIzVUTWTtWkZ5+XR3EAhU9kY0gPmnfwT43MKBwwFJ8cPg64pT0xNND4AfeF/CffLmif
 ivcRe9yYSMDK7qcXFS56cu6GlSqLzyFFWZzbfPDNpu+gXViygC2yAqCafI6+cmKD+aiZMtMFAq7
 lC+NK4s9VizV8TE55wwnHUKqAkeRQOh6ObnLSuxkOF7QyBCGMbFPpLV5R5TTlrqYASnihSnQInk
 6K/w5ZqNKRb/4astTsclOsbBMl5IZmvCIkbR2QLLMKozkW58qXh/v36SAGKtoK1ILfln7jhFqpn
 6xcwxi1bk3LR/RIAw/cmZSFomne2SHKD254nnKicMqbMTKFc5zs=
X-Authority-Analysis: v=2.4 cv=YZWwJgRf c=1 sm=1 tr=0 ts=68e14db6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=f8l8DDozHMi9xiwIWTgA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092
X-Proofpoint-GUID: -fxJKSgz_VRijGAvdWBr5ozdRly50NHJ

On 10/4/25 9:53 AM, rtm@csail.mit.edu wrote:
> A client can cause nfsd4_store_cache_entry() to write beyond the end
> of slot->sl_data[] here:
> 
>         base = resp->cstate.data_offset;
>         slot->sl_datalen = buf->len - base;
>         if (read_bytes_from_xdr_buf(buf, base, slot->sl_data, slot->sl_datalen))
> 
> The demo below does this by sending a CREATE_SESSION with
> 
>   maxresp_sz = 64
>   maxresp_cached = 80
> 
> The result is that the next request that includes a SEQUENCE causes
> nfsd4_encode_operation() to decide that the response will be too
> large, and to return just an error response to the SEQUENCE. Then
> nfsd4_store_cache_entry() decides to cache the result, because
> nfsd4_cache_this() (really nfsd4_is_solo_sequence()) returns true. But
> the maxresp_cached=80 caused nfsd4_alloc_slot() to allocate slots with
> "size" of zero, so that slot->sl_data[] has no space. But
> nfsd4_store_cache_entry() is not aware of the true size of sl_data[].

2020 static struct nfsd4_slot *nfsd4_alloc_slot(struct
nfsd4_channel_attrs *fattrs,
2021                                            int index, gfp_t gfp)
2022 {
2023         struct nfsd4_slot *slot;
2024         size_t size;
2025
2026         /*
2027          * The RPC and NFS session headers are never saved in
2028          * the slot reply cache buffer.
2029          */
2030         size = fattrs->maxresp_cached < NFSD_MIN_HDR_SEQ_SZ ?
2031                 0 : fattrs->maxresp_cached - NFSD_MIN_HDR_SEQ_SZ;
2032
2033         slot = kzalloc(struct_size(slot, sl_data, size), gfp);
2034         if (!slot)
2035                 return NULL;
2036         slot->sl_index = index;
2037         return slot;
2038 }

Perhaps the internal minimum slot cache size should be the size of a
singleton SEQUENCE response, and not zero.

Is there any logic that checks that the response to be cached isn't
larger than the slot cache we allocated here? I don't see it in
nfsd4_check_resp_size() for example.

-- 
Chuck Lever

