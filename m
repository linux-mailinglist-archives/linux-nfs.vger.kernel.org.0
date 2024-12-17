Return-Path: <linux-nfs+bounces-8637-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF539F5842
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 21:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0A0188167C
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119D21F867A;
	Tue, 17 Dec 2024 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Thd0EnF5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M7aI31tQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E5150994
	for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2024 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469074; cv=fail; b=oeEyq//bXkK5IMno/dnNGmJqGDpxmj+7ttnQGcZZbvAWqqACJguDNAemtMuggtW61ESmP3Oz/mujCQnphutmBbZpGgp4Zch9YTpoV3iFFvCC67idylMYWhQRGjSTWdDfdd0MRQcfcXWB/DkrXUIkzngUr2vYDJUMQvsR5z2HEVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469074; c=relaxed/simple;
	bh=98PQRKAgLlaaSro0Z8Hrn109ZhDJoY6WS96/A9sBjLI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oZhuI1mw/rDLHhLoRCY7CwjXyjy9Rvhh6o7cjuqiaFNUGhV1NJYUX5l0eayeHKEhbmTZ4HMyYjyEKLSr2mzWfOiGEdAj+VZWLfbFcwv+IG7WrcgtgQmfbeEUPcH3SGawEIBQkg1OHSSS4nLNDlo1dz0WbdcHMrRmPkCHYF89tT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Thd0EnF5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M7aI31tQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHKthdk016869;
	Tue, 17 Dec 2024 20:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TGn3CYSRWI+kjWCGRZOp17X+Mo1Kohjj2sJoNK36AX8=; b=
	Thd0EnF5ZPCZAMdjrwLrmrfJOXKvwn92+nCuXQBSQyGqfnIlX4NKCHPhaxG19GUT
	AnLjeV+ptyTuUpgYK5juoCYfUb58gfSOwpeUtTVWbDgNvPIGFL9rt9Yyp76pIF+X
	WbNI9zxfRVHA+xfm6GqgJOrtqHe/Y7LTiOu2/VZV5ouGrVkCCs8dR0LsLzNfNwZU
	PxRGAwT/P1XgSGckrCajpuZi67c0n+k1yyKxgR+FpUBWREUwePFXnVtLKu8+z5qm
	g6rVMcobp6ROSu9CLOuLiNjKK/yxwyjN611yGEoRwHr/xCOsm/Vb2YcVSx/Q6PKe
	LsWqfWErLULDWhkJvmD/kw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec71c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 20:57:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHJ9nha035452;
	Tue, 17 Dec 2024 20:57:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f8yvv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 20:57:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqx2NL9K8YyJ+COFSZvNQoiAyq4RpYHBcbQivI43+XpypaI2/xoiFdnY7ZgkZwvy1sdHmpo/6yV2oVb8Y473qPOM/AMNLU+/mOZA96O4jvdKJMPLCfWl8YajCXEmv0V1fby36VCLRk3cf74GUBYcd/AmdjxZBwomQbTGHpyjLLiEV28VXPgZp/INXNW4/pNaCF0gAl/uElxMAZ4a63xf6I/zvFrf92UmGqoJO+ErfDX487hYEOyoRswckPTiv9CCwNE6RQ/AprC0RDYmkV07QmRNDxTpGFJeXIG2PnAqhsuFTaRt+RsqIe+/bBtIw/Wguw7Qtu+0XS6M3x3b00MUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGn3CYSRWI+kjWCGRZOp17X+Mo1Kohjj2sJoNK36AX8=;
 b=BPdL8xSXhXNYX8H8J+24STgBGrdQ8MkfX0uj7Lon6fiH7FlaTN6Q7exCQ3fVakyAMT5WxlTWVyMXxEZyV1CtBHmL/YEznTNUvorZqzICSkEc3A+k+3RbI6Bixb916x/C2gxgzB4i4Czq9kafd9rlAB+TKYfzDpbL/SnyzlARde0E09FLqUncupzElkvZTAZP4h5JlUX59swgf8p9lW3+p844pP5fcdTGx7L2nfv0z3xzWa4O8iZu5z7uF6SVXc+CogEbnTGfTKwtvre5pKl48rdGC6rLRBl8hwaHVx4s0PlkJqnpGXNYvHUF09ZtmfiZNjBEbMR579KnlKGihOqXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGn3CYSRWI+kjWCGRZOp17X+Mo1Kohjj2sJoNK36AX8=;
 b=M7aI31tQzVsH7bjKE2re49uV3o6SebG+OZ251o0sZXUzPFsK0i/GMMGSkDADoKNnoFMPGFqoCDx2fHgfIxXfyAbR34HKWKHxMMk0e7Ijju6Itp3G90lAduayROn+pf7r9+qrYC/wea6xlcOi9Lexj9/fnXed6WRj25DdVVUqWkw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Tue, 17 Dec
 2024 20:57:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 20:57:33 +0000
Message-ID: <fc6c6fc1-f9b3-4ee7-91e6-c5b53fb87005@oracle.com>
Date: Tue, 17 Dec 2024 15:57:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: fix management of pending async copies
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
References: <20241217192742.97306-1-okorniev@redhat.com>
 <91943f72-aaa3-4431-aaa1-a6d9a6f13b3f@oracle.com>
 <CAN-5tyETNF3VQXbc9+iD8PD079j96n7mNs9-=bdbtCz7uuo72Q@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyETNF3VQXbc9+iD8PD079j96n7mNs9-=bdbtCz7uuo72Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d50d186-6c24-4574-d4ac-08dd1edd6d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmxIc1RDNTZtMTgrR1F1V1hnKytlSEJHZEdXbzhFNTkyaEJMN0c3Wi9aV2xW?=
 =?utf-8?B?ZVRFdVBiSFJySG45TldJWTNvd1JyZFFZbFdnLzdDZ0tTTmRlV3EwTVhlSTNB?=
 =?utf-8?B?NFhqUkxJdG02SXdYVW9ZRGF4M3VnS2oyeTFiN0h5UWJWWk9IWU5vNmQ0RG4z?=
 =?utf-8?B?NE1qRXJYUi8vMFczazZqKzI4bERtRUtISDUwVGRwZCsvbkRmVERMbEJuLzNL?=
 =?utf-8?B?MmhBMk92VmoyWnVOWFFBNXN0OEsrTFBvbmI2blZNWWd3cTVjL0VUZFJjejFJ?=
 =?utf-8?B?RlhOMENWb3dzY21aWUFzKzVENjF0Q2hWbmJhdHg0RVBkc2c1NWVnbTNyWkpm?=
 =?utf-8?B?L1JqWHErRVMwYWpPY3Y4M0JLdk5jaDRVL2JTZEU4VHpUbWY4TXB0a0o1YzBj?=
 =?utf-8?B?LzhwalR3MFlOcmpGWThibStyd3ZJTTdUZXhBd2w0NnloR09lQ1dZMmtqYll2?=
 =?utf-8?B?SDArdUlUWTZMR0xGMHl3UnhFTDBTbFZVM3RuZjUyOG04MFRDcUoxNVBQaURx?=
 =?utf-8?B?MlpMaElEZllmNlVIUVZ6VnRLRkVJaWI0cnRia29sRk0vbzl2RnIra1FUckV2?=
 =?utf-8?B?Uzh5SkNTZm5VMTBFWm4ydGxKMEMzTTRKQUFMRkVUeVhtbGZhcHViSG9TQyt2?=
 =?utf-8?B?em5vclRuOCtsNWJEZEN1UzdINWkwWWNtc0I2ajZtcGFXQWsxVUxmSTg5QXBW?=
 =?utf-8?B?UXhjUzRzR2p0VEJDWmdCL2tqNlA1dk81LzRUU0NXeHJEOE56akpKeUVOR2dG?=
 =?utf-8?B?dUE0WmJ4d1l5L2NLT2w0N3RIWnY3SmoraUlDR0l4d0dyczI4L1RiRC9XbUc2?=
 =?utf-8?B?eFdkZmgvN3p6OWZINEI3VzRsWVh4QUhISEc3VTN5b2xlS2NUVDFQaW4wZUZq?=
 =?utf-8?B?S1h5d3lDWGEzYTY2UGhOTTlpMEFhQmZFVklTQnhqUGExVEdQZ0VQanVIcFFs?=
 =?utf-8?B?aytrVDgrUThxNTNyVjZoQmtwZjlFTkQ3cXFySGtkWUdTV05NU25yWnZwUUNK?=
 =?utf-8?B?N25sYnJwbUowcE1CenZlakRLY1ZHSmFiUXc4Qm5obFJWRVV1MjZXTnY1SnpM?=
 =?utf-8?B?ZDZuZEtDeUo3RWRSYmNwdk9qREorN0c4bCtGS2FFVWFDdTRuYWgzdzVraCsx?=
 =?utf-8?B?dFhJMEdwMEtzWlhyVTZyOVllMzVmcTdZNVFvdzhtQmZWM2g4THlEWXZrWTNU?=
 =?utf-8?B?QmFvMTRSVU5LN2M4TW9XR3ZPR3M0WjVvT2pqQlVYZC9qT1k3VzFFcTlQaWY1?=
 =?utf-8?B?dnRWZHhCaEk2RllnNkdiWkJqS0hMS1dxWld0R0ZJQVYxeE9NY0tvRXZyRXF1?=
 =?utf-8?B?bU50endoL0JVd1RKT2FqSGhnM0R3dGJ4UnE1bm1HdmZXQ0ZETFRLN1JVTXVP?=
 =?utf-8?B?MFB1alVuOW9aZTJIMmJiYmhkS3BncVhtL3lxV3RTMzQ0QUliUitoZTlMR2Q4?=
 =?utf-8?B?WW5xSmxTd09HbmNra3l5cmF0S0ZPaXB2VmtVVDVsaXVsV2c1OGdIL1FNc2pr?=
 =?utf-8?B?S25pZ2RjUWpYUlZFQUlZRmtwNDVsaFpSV0paUk1Eay9VcXNpUjJKeFNSSTRo?=
 =?utf-8?B?Y0JoUWh5b1JhenRuNHpkWklOdytOeG1CVk55OWpDVTcxUllNcDNBVW1PY3Fv?=
 =?utf-8?B?MkNyNTIxSEJjNVlJV0FsVkY3UXV1NndnYUlkS0VOcTkxeTBCL1d3T29Zam9x?=
 =?utf-8?B?SFV6anJtQ0dVVURwNG90OW9wVHJKcTBYQm9aempFcWtZT3BONFJsTGpqWFVU?=
 =?utf-8?B?NDRRRlVvK2UybDRmdjNVOXJEcnFtVjhoU1hVNWxhUUhjT0ZseXM3UzZzOGl2?=
 =?utf-8?Q?HV4ps3eZ7MC6fgOzpfQB4o1CnA81oHalvt4i4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qkw3K3hFdFlvQUErVnE2NHFvakRZSVdpQ2o3d3JKSllDTDYvS0o1bXRIcitT?=
 =?utf-8?B?cHFiK0I4enJMS2QySXM5ZmVGd1EwUVBnUytTSndVTTl2V1MvNTJWR0QzQnA2?=
 =?utf-8?B?VllnZkQzZFBJRkJiNjJZeE1GUmtlWndXTjIvcHlJTk5CQ2d0Vm9ObExhZkkv?=
 =?utf-8?B?eURRcnZsMEgxUjB4UUxBOFhjVGpDVkFsNXBkaTRseDRyTm9Ka0w0WER3NnNM?=
 =?utf-8?B?ZHRKZGlEMUNFRlpWZnUrbHdNakNldWpieEVmSkZ0VGR3UG5XMTQvZzRJMEl3?=
 =?utf-8?B?SXJlTERLRUdqeW9rdENkZDV5YWlDWlMxdGE0dkdaTUhOWUtzWWg0VlEyTGtL?=
 =?utf-8?B?bG9HSnp3bXBwYm5LSWpYVVYyamFWcVV2VXBRVFpPU2lMc2ZNSWdBV3RtRno5?=
 =?utf-8?B?Y2pSOUJOL1hPa09xQ3JEalkzMEV1SGFuNHZveXlQR1FjVG9ZeVlsVmFEeUtv?=
 =?utf-8?B?bWhHc3E4Z3JIZXNqU2Uram9ldnliaFdXM1pQV2hwQXB4NmdMeXFKaHB3NlF2?=
 =?utf-8?B?RTZWaW1sazJTdDNmZHZzSTFJNkNNWkErUkg0RTZKM0VSTUtuL3JJVmwySHFl?=
 =?utf-8?B?ZG1iOE9wZktzYzk3cm03NGxybkpyQ2RFUGcySXR6LzJtVFRIWHVWOVNnUGdU?=
 =?utf-8?B?TTNjZVNIZ01tY1VTQnBTa0hYV012VlJEVzM4Y21SRUpacEhjQnNBQjFVSUZz?=
 =?utf-8?B?VTFzU1ArRWJjUURJZkVpV0JUNnpsM0Frbi9iZFRSVUZ1ZHJ6SURJOWovUG1C?=
 =?utf-8?B?NnJzakhNWGxvejl0VEVEUXVsWndrY3NCWUxiczM4ZHFZdTFOeUt2YmxIVEdP?=
 =?utf-8?B?LzlEbm1MZllsSi8zYUdXem1oSVMzZlhXR3cwQXFIbGNldzhFWkNBL0w4L0N5?=
 =?utf-8?B?ZkJFbHdqeGVGeTl1M3pCK2UxUjJMdmlTeHNsNkduOFVYYVA4Tjl2alZ2QVlv?=
 =?utf-8?B?MkVmWEtSZ21rZXVjSWZ0SDJWSDNPUXFiYmdrc0xmMW96S2poWkRqZXQzSStP?=
 =?utf-8?B?QkpWVTV6WDhPVjFKQmVCQXpJZG9YaGlwK1hpWHduOXkzMm4zVkRRYlgweWhy?=
 =?utf-8?B?Vjc4ZTR2Z1NKM25CeGd4V3M0d1YvaXQ4Sm9wajhaRllrc21IclQySzNuei9V?=
 =?utf-8?B?N2FLZWszN3JnTGcwVU8xaDVvQmcwU0NWeFJnQmxSVlltOVY0UUdBTnN2L3Vm?=
 =?utf-8?B?Q29icXZmSGoxUnlPNHNyY0lSay95bGRZTi9ub3dGWXhuREVjSU5PQUpyQk1L?=
 =?utf-8?B?T2ZHeFVaMnQzbURUMHlCNytSc3BQQndmOXFhdmN6N0pXbmYydG5sRUg0NDdO?=
 =?utf-8?B?RWVjL3dsd3VBZjlyRDZoYlpldmVMTVFPVWNHaGhlR1RoeVNjRzc3clk1WXdH?=
 =?utf-8?B?M0ltL2dsS1lPRVNBSGtlZURMNlBwaHowUEJxMUNZTC9LVWtYS1NOQVg0NHA0?=
 =?utf-8?B?ZFIxWUhlcGZURnQvaWhmZzhqSEhnOWROV21YWUptdWFCRjJJWWdMZ0N0eTlt?=
 =?utf-8?B?YXNLbTFHT2h0QjRhUHVFNmR0ekM3T3NDTmxOTU40ZzkwL1A1Z1NPa0JSM0g1?=
 =?utf-8?B?R3RPUXRvWUJtTVplay92dDluYXV0RFZDNmwrNFppMFB3SVVYZ0orNkh5TlJ2?=
 =?utf-8?B?WDdGM1NnN3lhNEdYbmtjaTUyOHRwREZXZ2NjSW0raFZFbXRidjZ3dXIzeUp4?=
 =?utf-8?B?REo3cHFuYWRHb21jL1QxdUtCa0s5QWI2MXByWWorUXk5RThrbVhPaVozcHlr?=
 =?utf-8?B?NWw2VGFyVDlmVXMvbkFPUFQzd3V0bnJZREZBdElhdHc3NVNCTGx2eHNHc2Uw?=
 =?utf-8?B?aTN1Y3lRbjB6bDhhMFdOY05vdzYraCsrcGR2b0o1SkY3dS9IbzV0YVhvc1Ns?=
 =?utf-8?B?cW5Dd2tBZll5YTc1UFZnY3A5Vm9qblJ4SHU4MXdua2Via1I4UWltcjFxTEoy?=
 =?utf-8?B?TFZsSVl0bFhKTXptRHlkUUZkZ3JTT1ZTKzBWNWZUY1dadEZtTytFL1VDV2JO?=
 =?utf-8?B?S28vWWpDbkxZSDV6aEFFYStaUFpTNDRjQlVxNFV2LzF5Nllrb3lnTitFb3hF?=
 =?utf-8?B?L1FMK0VGYkNQd056VE1EdUF5VzhCb3pieStRUE90MnFLR3dHbUhDVnpxNVM4?=
 =?utf-8?B?UzVQQ0dsckJnRmlDbi9HMTRDa0FBUVNnb3BRUnRPaFZnWTRUVGkxanljbHZr?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aAFol8QdE4snrzubzvVrnp1ZSTU5DAWL/ELno2WkhJ0pAwjoD2FZNqLICXnGeOWd7ZZqPw5ZtcnQjaA7B+71gn3MoioAE+N6uqreuwN8n7bzxiRZ9YhjpLAKBfdxTFRQMgYMF1LVcQvdYJQEXzAOEqI2rpE0Bl4MkOua+7j95x9126lbDxjM0pC36kqkSDS3Zjm8uQ1UuJM1RM9WWOC6y5AKSbZezNT0EAPaOcFgBq2Ct+X9kPsMESgxvA4Q7lwg6c9k70drF0yvxhDsWSWb68jCI4dZil4lMpAmo/ix/c23DTnpeDuh2GTfnXP3tOAjMPqCjFryOnoqHHb375gom0LShES31UiSB9pXUBUU5TPMP056GCoZushzoczN2sl1X29KzsrjIQJBazcsI3oEotjGoMN+8arTiV3zDXbLx4fk1WTzJx8unjTxsgS+nAVwsXZa+EAevFGUquTcKJJfj+4yn8Z1jkKTEmexK7kNdXnXNb+wQxlIc/MbSMqo1hXIm+c7+iKy+QYZTiHeUYfZuwxE2Z2dLHIcrH5VnTk/Lv44el/3h33Q0tmZeefCBmjS5zCgKVzYyf98C1uW8stOlnFyQzJLrYrwFOY3wg1HrT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d50d186-6c24-4574-d4ac-08dd1edd6d95
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 20:57:33.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKu5nolg7WLQdQ3WUZj+ZY/br2MXAcuUhrt5HkwtLwi5LfYGjOjuVPgoAj8aHu+ICeNVBsj3/ek/mm5r1Wbuyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_11,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412170157
X-Proofpoint-GUID: Sc0qX7VA6TS6fCtXK20P9371zs09Xu4v
X-Proofpoint-ORIG-GUID: Sc0qX7VA6TS6fCtXK20P9371zs09Xu4v

On 12/17/24 3:47 PM, Olga Kornievskaia wrote:
> On Tue, Dec 17, 2024 at 2:45 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 12/17/24 2:27 PM, Olga Kornievskaia wrote:
>>
>> Needs a problem statement. I suggest something like:
>>
>> "Currently the pending_async_copies count is decremented just before
>> a struct nfsd4_copy is destroyed. But now that nfsd4_copy structures
>> stick around for 10 lease periods after the COPY itself has completed,
>> the pending_async_copies count stays high for a long time. This causes
>> NFSD to avoid the use of background copy even though the actual
>> background copy workload might no longer be running."
> 
> Sure I can re-submit with this change in the comment.
> 
>>> Consider async copy done once it's done processing the copy work.
>>
>> Doesn't nfsd4_stop_copy() need to decrement as well, if it finds that
>> the kthread is still running?
> 
> I thought so. So I tested it. kthread_stop() sends a signal to the
> thread (thread needs to check kthread_should_stop() which we do) that
> it wants to exit and then waits for its completion. That means the
> copy thread runs its course and by doing so decrements the pending
> count. Otherwise, I found out, we do it twice (and end up negative).

Thanks, that sounds good. No change needed, then.

Send a v2, and I can plunk it into nfsd-fixes for broader testing.


>>> Fixes: aa0ebd21df9c ("NFSD: Add nfsd4_copy time-to-live")
>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>> ---
>>>    fs/nfsd/nfs4proc.c | 13 ++++++++-----
>>>    1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index f8a10f90bc7a..ad44ad49274f 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -1347,7 +1347,6 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
>>>    {
>>>        if (!refcount_dec_and_test(&copy->refcount))
>>>                return;
>>> -     atomic_dec(&copy->cp_nn->pending_async_copies);
>>>        kfree(copy->cp_src);
>>>        kfree(copy);
>>>    }
>>> @@ -1870,6 +1869,7 @@ static int nfsd4_do_async_copy(void *data)
>>>        set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
>>>        trace_nfsd_copy_async_done(copy);
>>>        nfsd4_send_cb_offload(copy);
>>> +     atomic_dec(&copy->cp_nn->pending_async_copies);
>>>        return 0;
>>>    }
>>>
>>> @@ -1927,19 +1927,19 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>                /* Arbitrary cap on number of pending async copy operations */
>>>                if (atomic_inc_return(&nn->pending_async_copies) >
>>>                                (int)rqstp->rq_pool->sp_nrthreads)
>>> -                     goto out_err;
>>> +                     goto out_dec_async_copy_err;
>>>                async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
>>>                if (!async_copy->cp_src)
>>> -                     goto out_err;
>>> +                     goto out_dec_async_copy_err;
>>>                if (!nfs4_init_copy_state(nn, copy))
>>> -                     goto out_err;
>>> +                     goto out_dec_async_copy_err;
>>>                memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
>>>                        sizeof(result->cb_stateid));
>>>                dup_copy_fields(copy, async_copy);
>>>                async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
>>>                                async_copy, "%s", "copy thread");
>>>                if (IS_ERR(async_copy->copy_task))
>>> -                     goto out_err;
>>> +                     goto out_dec_async_copy_err;
>>>                spin_lock(&async_copy->cp_clp->async_lock);
>>>                list_add(&async_copy->copies,
>>>                                &async_copy->cp_clp->async_copies);
>>> @@ -1954,6 +1954,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>        trace_nfsd_copy_done(copy, status);
>>>        release_copy_files(copy);
>>>        return status;
>>> +out_dec_async_copy_err:
>>> +     if (async_copy)
>>> +             atomic_dec(&nn->pending_async_copies);
>>>    out_err:
>>>        if (nfsd4_ssc_is_inter(copy)) {
>>>                /*
>>
>>
>> --
>> Chuck Lever
>>


-- 
Chuck Lever

