Return-Path: <linux-nfs+bounces-5501-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F6395A01B
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0181C2223F
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197571AF4ED;
	Wed, 21 Aug 2024 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nD/dWSnV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xGeH1Cma"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A141D1B2529
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251139; cv=fail; b=NPWSizn9lpUtohjL4ABzb+MBA55FxEoT+ObsyHqKBKVqFM9fiy7cgiSIpb7HX9kxeTKCYCju9Ho7ya7WyRLkyj1HMs9R0UJWzcp7NuSyTjalZQXdiUOwYfFNIOARTKJ+nPQ/urGlXXU2B/xlEHV28s3s9ghfc4c4M/PdilSWfHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251139; c=relaxed/simple;
	bh=NT3d1rT8K1/ifUL3KW98gaiDMBfpYmMuJMAddT03+e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MufkGtqwfc3zrrQfnkhZTskQ7XkS8fR3GOKmw4LB0bJ+ovP+bBpFK3Mb8nulgjcbnGl0ByMq0DqCHKYdfb1andSSosCHicOf5qG+fI5geJEFHJ+DzSSee8qW6bY5HqjqhZj20EGD88hcEbAz/0XHedG0uQKBspIVegP+xY3ooEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nD/dWSnV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xGeH1Cma; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIYK5013730;
	Wed, 21 Aug 2024 14:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=9598CtoeFVoS6mVkYhgDGLELdmqZ4Gm+wXZBgITUOiU=; b=
	nD/dWSnV9l5exNiVLsspJcszUezVhEeCG3+RSk2oRt7jiQHLF3JAbunlS7N47AAQ
	B3Do1uH3eXm9ti+FFIF7oscnFznOPY0CmR3fJ6qGjf8J3XxeldtBlb4j9hKQ0N0T
	PPPeBAGlctfwYPWTklHyodPDNNlsjCVP7gJRb5OKHId5CY/o9RHqqYPP+CJrvJXe
	PW1VQPRrFbNxoSoA+/+SlBNzprzeKvBjH+YQY1hAPAsaZh5XbS6hjc1FVJz4/PHu
	byZJgxc37K/iP9ItmiP2h9eVVbS6dxVn1lMfYhEF36z8zrVxXHLVKYnsf2nLKB4Y
	2M5NLTccwYcuu8cXshFtyA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6gfrhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 14:38:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LE46qB019381;
	Wed, 21 Aug 2024 14:38:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 415hp39p32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 14:38:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urd6jDUGYnXkVN1xdmtObELgF4FJk9GyPGGU18QvZpiPgPOGyyIZwxCAjAu/TUhzdbqDgiK5S++dJ+Tu77QZ/CW2EmOpVwbcsfvwTAmnoirJby2UHu3Wy2tlBxXd8+mGdnXDV91cbcqFBlA75T6o0PhF3IFYm9UZffh1++040oRxCz83sU6ZizEMoyyjEiD/sqvfF3+seyOT+KYXK82Pt4xeeUorbOW6l6p8cxWvjcoZz7UORT/Qvug65WN22X+JSrKRzBqqfSSI3M9FiezKnDhxzEDCySSZ418uBPm4VgUrmWhyERk1hG3EZlJTdUFB6HEaVH1jPJ6iVwB8y/JnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9598CtoeFVoS6mVkYhgDGLELdmqZ4Gm+wXZBgITUOiU=;
 b=yIfVDP0ybSBQDpvb9PATKt5xbdaH9S/LuAnW/Vka8wHWyPHwjt1HzkTN/Fyt0om74pvT1kaDNF5o4eD9SRKa5Ugq6g0xobd+unIkV3Id8JWpbyI0VKpXU9nwBhsgFdU5ThkelqcJmf2jMG1Wnl00CHYVsahx4WuZCG28n/oFVoUgjm/ZTVTafYDvrs4bUsKL3/fkBJcl30bvUfKKm6Nc9knrAk/PXGsTfaXnuMRfOsf9WWK6wTKuaJ/SprrwKMOASKGQURpajQBvG2pBKnWyYKIRLf1Sj/bAbToG7Jd5cxSVI6a+QY2PsWUINB+0NnmT6ZTQGFJS1qukKkenkIXjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9598CtoeFVoS6mVkYhgDGLELdmqZ4Gm+wXZBgITUOiU=;
 b=xGeH1Cma2DapdNmwaGkY3U8wY3uciEqE5t3oX3vIPMxDGj0Om4z78yus2FqZXV69xENS7qHTyy1XhRySaqYvDLr1sPMt7stTOKqKuFP+HMjDgFoX2wjbGoOr1n1sLat9BM4TvRGMzRbm/7IaBi9Ycfgtr5TKibbo1uH+QbsbygU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6566.namprd10.prod.outlook.com (2603:10b6:806:2bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Wed, 21 Aug
 2024 14:38:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 14:38:48 +0000
Date: Wed, 21 Aug 2024 10:38:45 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] NFSD: Create an initial nfs4_1.x file
Message-ID: <ZsX79e6NPi/4/rxC@tissot.1015granger.net>
References: <20240820144600.189744-1-cel@kernel.org>
 <20240820144600.189744-3-cel@kernel.org>
 <6a3d9288fdeb6409dca7c2ceedf249d3b40a7d97.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a3d9288fdeb6409dca7c2ceedf249d3b40a7d97.camel@kernel.org>
X-ClientProxiedBy: CH0PR03CA0375.namprd03.prod.outlook.com
 (2603:10b6:610:119::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: afa414f3-fc6e-4334-4e6c-08dcc1eef7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGt1WDVzbVNaK1JLYjlERnBCdVh0a3BlNXdsN2FXSVVLZjRlNVFoQS8yNFZN?=
 =?utf-8?B?bnRSRFdDVEZSV0svUGFrK2lZaWRsb25ORit5WklvWDYvTzU5Z0hpL1N2S2kw?=
 =?utf-8?B?MUpUT0pjY2VlYklyMUtTLy9xWi9hd2J4dDd0TnBadVI3NDJtS3RvbXFtRE1K?=
 =?utf-8?B?ZVBXNllLdktabWJPZ2lXa09oR0g2dzlIVDdHNlJ2QVJOYVBJYjdGMkxMU3lB?=
 =?utf-8?B?anhMbHpvUStwVXNiN2xRMFJEWlRKQUhKRjZzT3hEZlJHWHpPSUM0V3pCV2JM?=
 =?utf-8?B?RFF3VW0yL0daN2xIbFZ4TVh3Wkp2bThWNXB4WVhic1dYSE9WWHpqNG43NHUv?=
 =?utf-8?B?akRFMTdJejRaM0w2Z0RtT3RXaTg4NFVpbEJQa3dqdERJeXFEWVRCM3l4Zkgv?=
 =?utf-8?B?SDc2MVdnb3pzT2RzSWFlWWZOWDBZemxFT1BZZjd5dVRxSEYyOHdCNUg1ZWht?=
 =?utf-8?B?S2Z2UHpsc2hRMEFnMjd4SStYSzBNTitKUUhoSW14SW1NWjhIY0kzUWFtc213?=
 =?utf-8?B?Wm41TmJKT0Y2UWVDVHhnVVpSYTBJUjZnVXVXcldQdnhFZ3U4U2lyc3owdnRD?=
 =?utf-8?B?RU9HZVQ1cExtbDRtTzdwWUtRVkFsaTZBVGIwRE51Q3ljaGFNUEQvTWhCbXRK?=
 =?utf-8?B?RGdTbHErKzlBTHhaVENVS3B0WE9abGtzQWlCbDZteVk5NVZIZEtNMnhuYlJO?=
 =?utf-8?B?MytmRnllSXZQU2NIR1VPOVRDVzcrS2tMejhNVGdlSndBTitQOUsrbE55MW1i?=
 =?utf-8?B?ZThHcE1hOWNHWDhLSlU1OCtYQlJuSDBRT0R5UGg3Q1duYUo1K2ppVGF6R3dk?=
 =?utf-8?B?Q1c5Q2xESURYZ0Nrc2xkUWF6QmpPMTlITVlzMnlERW44aGk2L29Dd0xHVnEw?=
 =?utf-8?B?ZllTMDdlWHNqWlh4SHpnbUVaUHRKUFQ5SnVIdDUxSzc2SmxBMG5PT2JlaWh4?=
 =?utf-8?B?M2RWZ1VObXBadFpEanB5bk9rNktndzg3MDY4VUVnS1lkbngvOGM4VEJMdlJ4?=
 =?utf-8?B?SXpxUWJzSURaM2JBRGJwYko4bHlUMjJzV1M3SXpvaU44UlJwR1JGaXhWT3Fl?=
 =?utf-8?B?dTVyb3N4QlY2amRUNnF0VW5MeXZHdldSaytSSUtyODBpbzRxRkNxK3VYTFU1?=
 =?utf-8?B?RHVPZndtTkJHV2I2bTlxV1RxelZpWkFFTWNQTTRXbzR1ajBicU51R2g2RTIz?=
 =?utf-8?B?SHMrcjVUVGFuMkh1NWhiSkM4U1hPZnZyakRWTEU0NWY5M1pPZVlzWnZoZ0c1?=
 =?utf-8?B?SDFmckUyVjAxSDZKZzlnL0hwdXZESG4vVkNRZkMrWEhpT3ZIendmNU1pUE1R?=
 =?utf-8?B?M0pqSlJMazlKUGVyRVZDZVlHU3VVSTNNSXZOSHNpUkRMWXZCSWVNTGRMR01m?=
 =?utf-8?B?WXQvL1hXa2NOK09VZjZXT3N4MXFRTWpHQkFUSE1JVVJFRmNqTDhJQ3F5cklJ?=
 =?utf-8?B?WHVhSFR0OWdtRG1BZ21GbWRSc3JzNDB4aU9yUzlFTHNmTGNPSVRiUzdaZzZ2?=
 =?utf-8?B?T2hLeTNrMmhPTXh2b3hWMUZtbmE5RVVpQ0lNb2lzQ25BbmY0RytVM0g5WXRX?=
 =?utf-8?B?TFpzdkVXa0lCVGJKdTdIYW51U3JMT2Q2Sk9KU3BSSTUyNGdIVGlBdTg4ZzJu?=
 =?utf-8?B?bkZlaUVPcldtMDZtUEd1Qi85RjlGY0ZLMnB6Y05ZZWdGK0ljSkJ0eG5YeHhx?=
 =?utf-8?B?d3NvWFZrZVRDTG5YMUJxN040b2MxbTJwTi94TXlkeHBCYWNHMkVQNnZhTWMy?=
 =?utf-8?B?Q3BteE1JeXhLQ3FqZEszWFMrZU5GejZYRCt6NkY2REFiUUdMSXgzcExHZ2sx?=
 =?utf-8?B?VlNYM0NGcXVmU1ROS2UxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWhEOXVCYllZSU9QbWNwaHh4TWNMRUVJZDdrSmlrNEJVRjNLOGxiL1ZZT2VE?=
 =?utf-8?B?d3RDQTFaaVpzUXBHYndxRkJLMUtoTzYwcHl4VStFTGtidHkxUlRGTE5hczVF?=
 =?utf-8?B?SFB6L0JoUXg2cVlzK0NjTmdWU2NmSVhqUHFrdE1wVXcrZ3VuR1dCdXkrTWFs?=
 =?utf-8?B?Vmc0cllVMlhONlZwNW5MTmw3Tm5iTTI4bmxlc0xrVStrT0R0d0ZqRTFTT1BF?=
 =?utf-8?B?bE9ucFIrMm9NVTR5akhjenFjTzY5eUk0ZUc1TlprSVJZbDJkZmxpc09hUFlj?=
 =?utf-8?B?SEhRSEEvMVVhRDZTQnBncE16ZitTenNTWG56Rjl4MHNQc1BDTDZFa0ZnS3BZ?=
 =?utf-8?B?TGUvOXJrZFZpdnh3bkFpZzhEck9qTDE0SnUydks3L0NTUjNIL3NkcXRMOWU3?=
 =?utf-8?B?R0R3d1JpNXliQ24rOUdwdFBlZUwzZnF0aUdzcmtlYXQ3WWRCZkNqdVBIUzlk?=
 =?utf-8?B?TmJ6M1BYYXBMbGlMbkIrN1QwekxSa1JsVUZLcFZSYXp6MUZ4TWR5ZzFUbEs3?=
 =?utf-8?B?bkZXdkgxaTFGTXRSZmNDTFo2Rm9ma3I4UFlpclhVeDNhU3lXd3BDYnVoekk1?=
 =?utf-8?B?dTV2ckNjMmVTcjA0MkVqQncwcVRLZXVxNEgySVA1MTUra2VCVFdjTE9MRXRm?=
 =?utf-8?B?VjZmU0hSN1FES29UNEhSVFNaSTlwSk5iQ1pOUmwzZk8yZ0NQejFtaUdxMEp0?=
 =?utf-8?B?R2ZoRGp4VENzRW44cmx3SXdIMlN1YnhKSnpFWEljK0xNTVJKSkQxeldOWm0r?=
 =?utf-8?B?Z2hkUXBsMU1NS3FMSVdaVjRrM0wyaW8wRnBtTEFTV2hpWldqcGpjV0V4SFg5?=
 =?utf-8?B?TGZvR1k4NjE3QWFxQUljdXl1RzIzZFlEaUdERi85bmZjOVpuK2prOVNMM01D?=
 =?utf-8?B?eHc4QkRpcCtJdTk1emlheVlad2ZpdmRhZms0VWNpN0h1SXFRVDBuQ3IzRktk?=
 =?utf-8?B?cGdTUjYwaHhCVlU0WUhBVTdLS3pvOTBPWkxPQ2xSMEMyVDVVcGdWaUwwSUx2?=
 =?utf-8?B?T1Vqck1MQkZMZHRzbm4wdVBQNTM4bGo4WlZIMUtkVnlzVXIzSDNqU2ZwWXRZ?=
 =?utf-8?B?ZDdOb2ZHS1B3ODFvZEUrSjhkK2w3ajlTM0pWV2NuV1B0SGNoTEt1ejhkNjdh?=
 =?utf-8?B?ZGVGdlYySitPZG42L2d1WTJVeWFNdlBpalUxdlBGQ0pucmY5WlUxTEM4NEh2?=
 =?utf-8?B?c3VGYXdIV0JZL3FrRTFLY1ZOSzZNb0VRQlJ0bllBVFJnVXhIL0IyT2cwVm5R?=
 =?utf-8?B?L25UUlpEc2pHallYelNjSktFUEJSTEdxOG1yeG9oMHdYRjVCMm5VOVJFQWZW?=
 =?utf-8?B?L0k2K1hSVlhqQmN0RFlwVTVVbmRKb3hDSVR5NHJFNEo5YmFRNVhLZUFNY1NW?=
 =?utf-8?B?WGNuUjNMWGw2UHJ2d2lReVM4bU1QelBFeDhpeTgvTVJMU3puZml5aVdFUUxB?=
 =?utf-8?B?TFVoQXFjYit0eWdQcUlMWFhuZGdaNG5OaTJ4amhSNmZjNWhXWEdSQjE1OGFC?=
 =?utf-8?B?QnlNSG5XM3JlMndmT3JpNXV5Y2tPTmE3NGgwVi9VTlEzUnlCc0JLZGY5Tm1k?=
 =?utf-8?B?K2xIaERjQzBGdlBUdFpYVlBwVVNFTDZFWGJBb29iTkMrZFVZMG1DMGw5OXln?=
 =?utf-8?B?RjJqdm0vNWJpMUJaMExhbWFlNkpNWW4zNndaQ2Rzb1lVcEhjWFJvcGp6dHRm?=
 =?utf-8?B?c2xnUDFXbDlyQWcwcjAxZy9OK1N6OXdSTDJ1THRVVWM4TFFuMlZRMXJpeWlK?=
 =?utf-8?B?b3RuWTd5Mmovcjl0NEVBK1NHb3dJM2c2dDNtZE5DQjM3NzNEYWRoUGV6d0o0?=
 =?utf-8?B?M1MrcWEwbHowc1NIdXZxZEV2SWV6eTRrcnVtRFZUTitRZEZneTM5RVdmc3or?=
 =?utf-8?B?M1BUeC9wbGJvZEVuRHBMUjAxdTRwVHRhcXM3S3FyUDRpdHFNSCtXOXpYUjR3?=
 =?utf-8?B?WXdWdHF0UHMyemc2cWFTcDh2V1pRSVlOR0RnNWEwWXpVMG92UHF1Y0JoTUJr?=
 =?utf-8?B?ck9BRWdQbU9UOEIwOHJYTnhPMGJFK05Mdk5kdTdZcGVQNzErV1pHN21NNUp6?=
 =?utf-8?B?QUZXTXo4NGZyMTdaTjRGNWZRRkJ0VFpFM2F6TE9wRmNBT0NJVU9odnNmYjJ1?=
 =?utf-8?Q?WGgZDoEQHJc5IkKHfwcohkpuh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YLhYiK3Cz+l/1gEnJ7mOJjr2J/e6ep9X7/hFPQU4AvxVgS3pDCnGmRfr+X53Uo3nguKafqgAfCP0TTdLfKegjQWyGpKMMPQdRAxfbDdG7Y/GbPQnaypuvc2mmTP/zrbqyRvA3DQIkvKD+sb/IHAMbdzkPmB3It/pcaADRjfYgUPvyZh82hXKbRlgA10cLWBJhbx5VjHmmRzsCcAukGupEIQE2n1NodJ9A8gHpJ4hox7G500FfUorQY1ve66EcrmYQXiAK2ai24fo8REtmsSh5PiJMN1uK6gN1NPT+ebcDtVKTQvdm8rgfPrcVbRlohNjWKWr+1i9RPJSAM7Qh0m5DmXpmQ1/aCoCL+qgWI3AZS8HxWxunAaIB+uoi1lz5MMcf2zr9X+D9xUdHeG0XuCykNRB0ehReD4vbfsswuprtXPxfvLCs/fv6MUT8CyZWHLxj8y0CDM364R4McPqnLv1Oe600RT11ifU3zBpbrA8h7wkhK+S7eu5VcBs49D7Gy2hkZp2wccoHVWS31KVSdhVDyzXPezraj5Yx3Lda1eQox1Palx0WZLvhR2WtsjUSMc04DUmJjfmnJsFSd3oOSg9QDMnKnAqdrkLso8lEz370m0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa414f3-fc6e-4334-4e6c-08dcc1eef7ac
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:38:48.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuVTc65r5He2a4JPCWki2GBiD52ENWvlKsKiv6YcHYo3o+7V1iVyBBWYN7TCep79nyJ66nc/WCXiJhLFkCDFyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210106
X-Proofpoint-ORIG-GUID: vErrLS2m1AtpkwZ8vNaPnJ4P9sIqrvMY
X-Proofpoint-GUID: vErrLS2m1AtpkwZ8vNaPnJ4P9sIqrvMY

On Wed, Aug 21, 2024 at 10:22:15AM -0400, Jeff Layton wrote:
> On Tue, 2024-08-20 at 10:46 -0400, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Build an NFSv4 protocol snippet to support the delstid extensions.
> > The new fs/nfsd/nfs4_1.x file can be added to over time as other
> > parts of NFSD's XDR functions are converted to machine-generated
> > code.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4_1.x      | 164 +++++++++++++++++++++++++++++
> >  fs/nfsd/nfs4xdr_gen.c | 236 ++++++++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/nfs4xdr_gen.h | 113 ++++++++++++++++++++
> >  3 files changed, 513 insertions(+)
> >  create mode 100644 fs/nfsd/nfs4_1.x
> >  create mode 100644 fs/nfsd/nfs4xdr_gen.c
> >  create mode 100644 fs/nfsd/nfs4xdr_gen.h
> > 
> 
> I see the patches in your lkxdrgen branch. I gave this a try and
> started rebasing my delstid work on top of it, but I hit the same
> symbol conflicts I hit before once I started trying to include the
> full-blown nfs4xdr_gen.h header:
> 
> ------------------------8<---------------------------
> In file included from fs/nfsd/nfs4xdr.c:58:
> fs/nfsd/nfs4xdr_gen.h:86:9: error: redeclaration of enumerator ‘FATTR4_OPEN_ARGUMENTS’
>    86 |         FATTR4_OPEN_ARGUMENTS = 86
>       |         ^~~~~~~~~~~~~~~~~~~~~
> In file included from fs/nfsd/nfsfh.h:15,
>                  from fs/nfsd/state.h:41,
>                  from fs/nfsd/xdr4.h:40,
>                  from fs/nfsd/nfs4xdr.c:51:
> ./include/linux/nfs4.h:518:9: note: previous definition of ‘FATTR4_OPEN_ARGUMENTS’ with type ‘enum <anonymous>’
>   518 |         FATTR4_OPEN_ARGUMENTS           = 86,
>       |         ^~~~~~~~~~~~~~~~~~~~~
> fs/nfsd/nfs4xdr_gen.h:102:9: error: redeclaration of enumerator ‘FATTR4_TIME_DELEG_ACCESS’
>   102 |         FATTR4_TIME_DELEG_ACCESS = 84
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/nfs4.h:516:9: note: previous definition of ‘FATTR4_TIME_DELEG_ACCESS’ with type ‘enum <anonymous>’
>   516 |         FATTR4_TIME_DELEG_ACCESS        = 84,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> fs/nfsd/nfs4xdr_gen.h:106:9: error: redeclaration of enumerator ‘FATTR4_TIME_DELEG_MODIFY’
>   106 |         FATTR4_TIME_DELEG_MODIFY = 85
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/nfs4.h:517:9: note: previous definition of ‘FATTR4_TIME_DELEG_MODIFY’ with type ‘enum <anonymous>’
>   517 |         FATTR4_TIME_DELEG_MODIFY        = 85,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> ------------------------8<---------------------------
> 
> I'm not sure of the best way to work around this, unless we want to try
> to split up nfs4.h.

That header is shared with the client, so I consider it immutable
for our purposes here.

One option would be to namespace the generated data items. Eg, name
them:

	XG_FATTR4_TIME_DELEG_ACCESS
	XG_FATTR4_TIME_DELEG_MODIFY

That way they don't conflict with existing definitions.


> Also, as a side note:
> 
> fs/nfsd/nfs4xdr.c: In function ‘nfsd4_encode_fattr4_open_arguments’:
> fs/nfsd/nfs4xdr.c:3446:55: error: incompatible type for argument 2 of ‘xdrgen_encode_fattr4_open_arguments’
>  3446 |         if (!xdrgen_encode_fattr4_open_arguments(xdr, &nfsd_open_arguments))
> 
> 
> OPEN_ARGUMENTS4 is a large structure with 5 different bitmaps in it. We
> probably don't want to pass that by value. When the tool is dealing
> with a struct, we should have it generate functions that take a pointer
> instead (IMO).

The decoders are passed structs by reference already, fwiw. I had
been considering the same for the encoder functions, for efficiency.
I can give it a try.


-- 
Chuck Lever

