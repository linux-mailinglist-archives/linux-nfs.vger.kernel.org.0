Return-Path: <linux-nfs+bounces-8762-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F529FBF1C
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 15:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22064188497C
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A062A1BC9FF;
	Tue, 24 Dec 2024 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G3BtRQvr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aBO6iRzF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6991BC20
	for <linux-nfs@vger.kernel.org>; Tue, 24 Dec 2024 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735049828; cv=fail; b=eQ9NVovrUz0lYIc4PFQA59zAcX+COIbRKk6ymY/q3aB52CG8A7LgbqKXPwoEqRskKjoQ3hp0Aj02OfGMvjBla4KCNkLmYG/jOAjrnzIu9T7zzr/Dmbdthy7FVW7bLygu4j6meQl2Ua0+imSdXuqN3F8kAU58VVN4wreDxfO0GcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735049828; c=relaxed/simple;
	bh=Fd389NkBAkEv11e6T8uw6/kJXp6hZU3gtYMgljixh0I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RYE6Jax5POlK2/6HtfsX9ukkx/pJyqdaVkBW08odlmgM2BZ/8rkfnMOvjyjVTXv+RsLUUFz1rgR8RBRplbssnMhLHvXDtoO4907wN71i1BV3DvuHccB9hEKkXLAkE7Y6glw/zCdvf42kA2ILWZkh6jzBisXmQzdPMDrhp3U8Yj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G3BtRQvr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aBO6iRzF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOCBT0s010636;
	Tue, 24 Dec 2024 14:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Otam2sxXrlnt14d3dTqXPWUr7nc+DRNHOJw2uMlwjuE=; b=
	G3BtRQvrsK65QMWBudQFHcxZ9q7RiL0UxJzRQttJBGOhlSq5t2jx5FQiBgLEfsP4
	/IJTh1ttKuGgry7COdZFIZtt/neyEHjQMpin4KGOTlG/GVulmFEXQQ+8qCx9Lq5O
	qAaogZVU6eqwElOWmILo7uVZSQ4g1Ln65jbtluLeyxq6iaS9NmFNz+AulgJUFCgg
	vsH5AzNWlky2WUokmfRQu8lVjvrn9gGy+5nxWehN5RJv7bqckiMgjxyzX8evGfOt
	0sVpinvGAy87gbVtrioFVGsRWdorEMKQTfAJCMuB5ruewvchEPxsPaZh9u7huNTs
	37tBxx1je98MBv8tx4eb7A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq6scby9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 14:16:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOCSHuG029601;
	Tue, 24 Dec 2024 14:16:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43nm4e97r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 14:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xr7xK4X5p7v8FX7KynGVocFcUIbtudOFXL5dk/OJEkKTD1gw9LFMdTwqonS31H9Ei7iV4tmv3ulyyq3LxN+D8uZZp7tD0JKQ5ZM10B/0QPYGPLSugSVVGfk7aHFGVqI6XeCPzAJvwXP8DzvBFi13Ml5NaXUomgj7RR1d+3IS4kbzDc99RuqQui7GIhzuP2WFX1wOeKF2v1n3V5d/rViNt4MDyan07QqEY39Au7ns99rCIO7tQ6OmJ7eDJn8eoG8Je1+kChsVGX0tQteqE6gXzrOcK2H0jBUPmDzfWKtE93jqAYmflvdjQYR4tVCf9E1l+apNUM+1p0vzjEqSxlS/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Otam2sxXrlnt14d3dTqXPWUr7nc+DRNHOJw2uMlwjuE=;
 b=fRxLKYm/00AJo5+yoX9Za9G+npIIqW30l0bii/hE3SxTMQz5Li1Ccx98X9kAZkSQTKZchDKU26K/fY7i6zx9dJ74IH2F5m7tWYlT72tDP1ZWo748f4i4P6qeLY3a32hz6VJg8WrAblK41vaOf02GcY0Bu+RJKTsddSDtrAG4oD650X8+DP4C73/Jq8J3J+Zo/8sud/Fapa8Y58Pi3ITMrI1DhYEL8YMo4ow70Roww0Q8WbaueA0Pv+YHCcTgBnVyIXY2bJTYT9cyskb6MPeRyIimnZ1j21hxD8+qVYHCQVmFDLZp3tR1g42VcmNqdolfPnOIVaikHviDCcMYF6a4bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Otam2sxXrlnt14d3dTqXPWUr7nc+DRNHOJw2uMlwjuE=;
 b=aBO6iRzFbHtnZ8cZl4KC9JHiMPe1vc5dW0UC34pjwK+ETUjGCnYjIsEmT15bY1UUznlv5qC5d94ntzV0M3TcglP3zCvxmGCuj+nq6wMJLJONpA/h+dHSx4A+KflRws9uxHdojdPwbIy7543EMbu2vatwhX6dJG5Al5F+BFJe9ns=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5602.namprd10.prod.outlook.com (2603:10b6:303:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 14:16:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 14:16:49 +0000
Message-ID: <7daa45c2-13c4-4617-9f9e-7be5ae607b4a@oracle.com>
Date: Tue, 24 Dec 2024 09:16:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix XDR encoding near page boundaries
To: Rick Macklem <rick.macklem@gmail.com>
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20241223180724.1804-4-cel@kernel.org>
 <CAM5tNy74=vqdSaciOKus0SeU4eBB+Vb-TzKO060t1RSdAQYGxQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAM5tNy74=vqdSaciOKus0SeU4eBB+Vb-TzKO060t1RSdAQYGxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:610:5a::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e5a462-4ad6-45d2-03a6-08dd24259b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0hCTDVVSCtySnhrWTVLbkJVcWpSeHhRYWVtR3FVNHA0RkE2WDYzZnAvR1l2?=
 =?utf-8?B?QWg3R1ZHM2RadlFESTZoYWZSa0wrenVhc05KVkpsOWlFS0dTMDIvRFpMYTdG?=
 =?utf-8?B?dWtEK2p2MUNsS25lZjBiclhRcHRobkJHRkg5YmYwbTBjcGdmUjdBRk1oT2ZS?=
 =?utf-8?B?MnRCejBaS0NzV0xwak5ROWVRUm02U3IxcE16Mmc3Nm4xcG10Z1RBRGJsTGI3?=
 =?utf-8?B?ZDVLVWtFYVJrUm8zYStMWU1MTm5pRHZqdzFzMW5vdTk1TXYwNTVGMVZUSG1R?=
 =?utf-8?B?anppT1Nib1JkRWQzUXdYeFkvc1FidXA4UzdBRDk0RXVCRVpKVFFwNXhNbUEy?=
 =?utf-8?B?TDJnMVd5S0FQcFluM25KWXBpQzhNZHBibnpoYjdPdWdnb3ZzMmUwRGwwY290?=
 =?utf-8?B?SDY5K2dLODdWS05NdVFRVDl3cUs2clV1R3lTVThEcTJjYldpTTk5cFJ6SE9P?=
 =?utf-8?B?LzNYWGpwTEVhK2xqUjVCMDg2NngrZktkVjQ4RERIVENrWkNsbDNjU2lkY0VU?=
 =?utf-8?B?aDJZSCtPZ3JTK0pBNUg2UXdhcEtnbWxoQTNrRlhxTTF6a0k1UkV6Nnc1c1o0?=
 =?utf-8?B?VDVSS0tneFVXN0Z5ZGlqbjIwWVAxc3k0Mi93bVBZS0JGWVVVeVZOa2t3M29I?=
 =?utf-8?B?SzRqU0tGZStyaVk2TDNsNXEyclFNazRFNGpQS2JzMGJqUlFXcGJBZ1N6UUJi?=
 =?utf-8?B?UHdreVlqZXN1czB5T0E2bnN2QTBqUVIra2pNUldxQXg5N3NpVmJTaUx1R2t6?=
 =?utf-8?B?R3BsT1grM3NkWmhuOGlBUHJRTWYxYkhQZHh6Vyt5WUZJWW5UZk1YUEh5cnRO?=
 =?utf-8?B?KzFra24yL1ZESXQzaUQxN2pRVDk0VkFSdEY3YkdIay9LLzcwblRmcGVwN2dn?=
 =?utf-8?B?SWVxMXZkUnVaYzNMVHk4a205ckhOUzQ5K05yTFBDTWk0bEVQTEFEWXRoVmdF?=
 =?utf-8?B?VzRCZ29KNTJyZVpIUHhpb2NublhVcEkyemtPQUt6emdNRTZrYnNyUXdwRzJT?=
 =?utf-8?B?K1BTM24vOUVOKzZ0R3hXekJ0YUsxc2EvMTlOK1RhS1BNdDlMSWhFSkM0aDlK?=
 =?utf-8?B?bjlDcG1oM2twRkluWURNYjg0OG1hai9rajlEQjJtRlRtNGxBMVFGeUUxOGlj?=
 =?utf-8?B?U28zRjFyRWUwRnppSUFkQ0t5NGxQemYycERqcmcvN0REclg2TFNFZVJyL2U0?=
 =?utf-8?B?dXYvS0hBMWc0N3B3em5OQ3loK25tcmgrZU12RXdZZUd5b3pUcTJGcjhEWlFD?=
 =?utf-8?B?MXpSWG0vZkFIaFk4aU5WT0d4dEkxQnQ2T2ttV0VTcVhXK0JyUDBKS0c1QUdZ?=
 =?utf-8?B?K01sMUdmeDB5YTRQbHM5WnVXL29EM0dSTjFENW5pWXJxUU5WK1JBMmVVLzA4?=
 =?utf-8?B?MENpbWkySHRwZGU5MGc3TzBpdUtKMzRzLzNMdHcvQmNYL1lHZnoxcHZVeCt4?=
 =?utf-8?B?aGNmTVc3czIyQ1lqQ1RwcDNjeWduNUNXSEJaSzZlaUFEZS81UmV4WGtTTE91?=
 =?utf-8?B?OWY3WENnQ0FXbWFPRmRrWHBWcVhZMFhlV1B6T2wzVytyVnhlVVZzdjZqaEQw?=
 =?utf-8?B?Smszb0RIcjM3cmU5T2RVS3lyR2R6S2pVeFFha2IvSk0zSDBhdU1vMXFJZlQz?=
 =?utf-8?B?YkdyMHZiUExsaXNkdUFUMVN4UTdkQWx6ZlVwOFl3a3gvRTZQN3NQeGs4SjE2?=
 =?utf-8?B?aGhHOENRNXBKTW1uT2xtQ2d6YTFJSVlZT1lLZk9TbDJodnZpS0JIc3lMZ1h1?=
 =?utf-8?B?K1I1cWt5elhUTFh3cUp1WENCT1lQR3VtczZ0YXRjNFp3QS8xTXpRU0lwMG14?=
 =?utf-8?B?RXVJTDlVb0VTZ2hkT3V6cVNzSFdzU2dhTWxiaFFZVHdhTEx5T3BjZ3pCQ2VD?=
 =?utf-8?Q?d7zQmILtd/l+F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGUweC9vakw1ZUF0V1QveVc4VG1US2EzR1dWMG1CWkl6Z01PL05WbFQvaFhV?=
 =?utf-8?B?bEhRQVhVZTVabThvckc4T0kzL2FUbUhocURQSUJ3dTRwL1VadmZHdVFMWTJJ?=
 =?utf-8?B?UFhRQWVScGhtOXE2QzJlU1Q2MHFtVDhJUHVBVy9iRzVwYStPMk9XZ0JmYmRJ?=
 =?utf-8?B?WncxbWR1RTYzcm9pWGRxV1A5THd1alVrY29NcUpsTkpJNFdja0ZpNExsYWNK?=
 =?utf-8?B?bXZkOGlaMUZKeFVIMGNBR0ZQb2hMVE5lQXFKQVREOExpKzlyOVF1cjEvenZS?=
 =?utf-8?B?YStjbWpJcEtJRFFNUlFIOWFCYWxyV3MvV0xSOVFKZXdSLzB5dmx2REtFcVp3?=
 =?utf-8?B?bVRzeVBuMEdXVnBuV2JENEZCMURWTDU3SHl2RHJwZ2Y0TkJrUTFyNE9oaWJN?=
 =?utf-8?B?ZUFMWUN5bkZDSWpMdVNqYmZEYTVreU84M0tKd3ZsanNESS9GWTUyYVR5THo5?=
 =?utf-8?B?NGEreXZMSmlhS21vN0l3MkFuTzBmT1NWMzUvcjZuSFZucm9naHZlbkFaNWxV?=
 =?utf-8?B?bXh5QlduSEZUd1ZhVWJjRjhYU01YZTRVNGpHamdPYjdLQWFNRCtNbXJ4bkwy?=
 =?utf-8?B?ay9ab1MyT2JLL21WOTYvZGJaekk4QmYzTVE2TUFVNVZjeExZOG8yeGpkelVN?=
 =?utf-8?B?OFM3L1BXTTBBOHY5bmZQSXZiNS9WMTRMUjUvWCt3WXEvTmEvcmgyUmdScjR4?=
 =?utf-8?B?dStEdVpUTEtWOERLZzBoTkY1RFh6dlFPaDY0NGRHOCtvbzVWcGFHczNIRGJo?=
 =?utf-8?B?NmVDWTlCbHJzbGZvZGdabWtYbHJheUZmSkU0WlI4ZjNDQUFmV3BGNFlwL1gr?=
 =?utf-8?B?MXFCRnhWNWRDM243bk43SElsdnkyb0MrV0VJbnZKWmpuUXpTZ2hrbHRVLy93?=
 =?utf-8?B?LzdOSWMxRWZHdnVFSitDY1huTytKaG9EVVRxSHlQSFNlaUV3RTJ1clJyZkE0?=
 =?utf-8?B?NnpMaUV4M1dNcFRNR1MrYVRNenJRcElqT0c2UFZyVmJMSEM0blRWVlBIcHIr?=
 =?utf-8?B?N3BnMXRVT1JmWi92ay9QVW15UHZoZS91Q3E0YSsvZVFaYkx0TzF4SHBLUU5R?=
 =?utf-8?B?elhOTDJFdXgwVnhqS1A5Um9FcW1RdWJtOTlHM1FwbkJDalNRR0xWLzNFcmcv?=
 =?utf-8?B?R1pVTGlFUWFCRWRxV3M3OGtqOTg0RHVncmt5TmU4eVdpemwva0d2NnplOG1I?=
 =?utf-8?B?RG5TbTdqNFVIM3FsQ1pxalJrNWlmaTZEVVVVRVZKVDBOcVpPai9ybERqSTI2?=
 =?utf-8?B?ajhwRElwMDg5eGpmQnc1QjUyOFliM3lvSlN6bmZRSHZ3MkdEU3JUM3pXbkwx?=
 =?utf-8?B?b0pEalVHYmsxVDQ0QWIxQ2prL1VNc0VPaVM1L1JMNUIxSTJXc0hCQXJ6SFNp?=
 =?utf-8?B?eXg4OWZ3dThIWTNvYnpINVhYYlpZdnROSE5xYTVNeTczM0RrZ09tT2pvcmtN?=
 =?utf-8?B?WWRlYUg1WkpHSHNZMEVvTTA0V2FPaDYxNjZvbDFlekprZlNreUR5dVJxbmh1?=
 =?utf-8?B?eEl2Q3pqbFRZb2tNNUs4TnQ2eUtvNGZxUTZCNnFtZlRmdGp0NHcwMmhGYmYx?=
 =?utf-8?B?STdqV0NwRlhFcjJ6NTFPT0RhMk1hUHJHcjdTeVRLRlNPdkkwc2xkczFvN2xy?=
 =?utf-8?B?UFRwYjVneWJPaFd0cDZpMStJbEdRMFNleWFyQ1B2Smk5TVYxMXI3bTY4eUlR?=
 =?utf-8?B?MUoxTzVFLzRYVmZCTGp1TlYvY1c1aDBLZ2J4eHpXMnlKS0lRcDV6dHRSWGw4?=
 =?utf-8?B?Y2dvVjJPM3Y0dnNUVHRESklUNlk0dlRLT01BL3g3dWlmdllHOTc2WHFmNjZi?=
 =?utf-8?B?dTN3QVVEdWtSdHNsSnlIczN2N0JjVkZDK3NSUmFkakwxZ1ZVSVRlVHZ6cGNH?=
 =?utf-8?B?MloxNVJFRUtOZzdmeE13UFduK3RFazA0cmdFQ2NoRk9YamxDakVUWENQSHcw?=
 =?utf-8?B?NjFHZGdveVNJMHJMb0E0QWZoZVQzSitaQ0xKNEZ0V3VOSFBITzdPai9ZVkF1?=
 =?utf-8?B?Yk9JNVN1S1kvSm4xVFhRM2VzUFVLYjd5bU0wdUtDeTNBQUc0Q1B5VGY5R0NG?=
 =?utf-8?B?RmlLYVlxdVBycFBQY1grT3ZobGQ1bkY5YjJMNHlCcThPaXE0cjRjWFdKeVhr?=
 =?utf-8?Q?DjsypxpdLb0RK4sAf6Z2Xe7c5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZF0Oqx2ll4GWLCLqPZy7QjQRDXaoygOVNTk9qa2Z7h7SvTr8aMBc2yagPX8CnYkahvgUpqNdB2xgJe61lJxLOwYfr5vfLAXH3FZCSOKlYn64RXk2cUiFk0bjHXv9bVQXw3QK1AsEB7BGITj21cWZVzqu+fqMxF0C795vWYNhZUPZnHnzG2xCL0PZ7uo20lBN1UnxuyZdUKZtyeJeY+P5dUcmN3xtUNZQYzztkqM4Rpx17BRVZ3U4uDiaP+xwBKO57WOcxEfZCg65YePtFivhcZwN1fBcM552Slx8L4ExzvAjEyfex/CgGTxdTL63qU5Bf59/UcKwYtedB/i/QRY3RztZtb3ZtDNBKxEl3wmYqPtyNAXu+YfdPYJSX/gwflGgCZfxQSesqE5F7VoyY3khITjTXoYE/EWFcW4WHi3r5uZsd+cM+cEKWJOz1wDnsf2qc4dshnT4SFiIeUuMHF+zI9M5J2/l0oyC+ELHzSb/cA5TwzW0d/7Em0RQbxMCU5nu7gvsoFgDCmbrWdvVGF9Z2WRujq7qO2U4BfdkYeZ/SsLc4R7mHqZq1qc9GdyKsHMWEYOTwfZSu2hGGJy9xq4Jv5OQGFmKsPVpXmjy+goby8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e5a462-4ad6-45d2-03a6-08dd24259b7d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 14:16:49.8708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRlLUs/ka4CPRG4zbgJUqcKSe2/yeopVd1exXQd/Goe+vrMrnzWs/oiroTB2Vq6m0YRr9HaHlI3dYywIOSy/hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412240123
X-Proofpoint-ORIG-GUID: rvi67nPbDdENjPT-SCPn5NPqW6FlBwfx
X-Proofpoint-GUID: rvi67nPbDdENjPT-SCPn5NPqW6FlBwfx

On 12/23/24 6:22 PM, Rick Macklem wrote:
> On Mon, Dec 23, 2024 at 10:07 AM <cel@kernel.org> wrote:
>>
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Build out the patch series to address the longstanding bug pointed
>> out by J David and Rick Macklem.
>>
>> At least during NFSv4 COMPOUND encoding, using
>> write_bytes_to_xdr_buf() seems less brittle than saving a pointer
>> into the XDR encoding buffer.
>>
>> I have one more patch to add (not yet included) that addresses the
>> issue in the NFSv4 READ and READ_PLUS encoders.
> It also looks like there is a similar situation in nfsd4_encode_fattr4().
> It uses attrlen_p (only a 4byte xdr_reserve_space(), so safe for now.
> 
> You might just regret choosing to not wire down the "safe to use
> xdr_reserve_space() for 4 bytes" semantic, but it is obviously up to you.

I'm 100% behind the idea of making it hard or impossible to code
things the wrong way.

But I'm not sure what you mean by "wire down". I can't think of a way
to enforce the "only 4 octets or less" rule -- just having a helper
function with that name documents it but doesn't enforce it.

My plan is to replace the obviously unsafe call sites immediately,
document the desired long-term semantics, then replace the other
"safe for now" call sites over time.

I've found a few other potentially unsafe server-side callers:
* gss_wrap_req_integ
* gss_wrap_req_priv
* unx_marshal

I consider these "safe for now" because the reserved space is guaranteed
to be in the XDR buffer's head iovec, far away from page boundaries.

I'm hoping that no-one introduces new unsafe call sites in the meantime.
We should be able to catch that in review.

That also buys some time to come up with something better.


> rick
> 
>>
>> Changes since RFC:
>> - Document the guarantees around pointer returned by xdr_reserve_space()
>> - Use write_bytes_to_xdr_buf() instead
>>
>> Chuck Lever (2):
>>    NFSD: Encode COMPOUND operation status on page boundaries
>>    SUNRPC: Document validity guarantees of the pointer returned by
>>      reserve_space
>>
>>   fs/nfsd/nfs4xdr.c | 20 ++++++++++----------
>>   net/sunrpc/xdr.c  |  3 +++
>>   2 files changed, 13 insertions(+), 10 deletions(-)
>>
>> --
>> 2.47.0
>>


-- 
Chuck Lever

