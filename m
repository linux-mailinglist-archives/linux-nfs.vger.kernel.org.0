Return-Path: <linux-nfs+bounces-13226-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD60CB10B32
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 15:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF8C1CE39F0
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 13:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488012AF03;
	Thu, 24 Jul 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jMp+Vbw4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xp0STL1o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8494400
	for <linux-nfs@vger.kernel.org>; Thu, 24 Jul 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363070; cv=fail; b=gcc5WegEt9B5lbfSScAEjXB7ily9pJv5lyOG7soeLIyjigITARrjdhznBBi+C9JLkNp0kTTHKTShph/kyQzsTZtrSEw/O/4qe4d3Z8N0Iyov2f7xsAVHrhqVawfWGbpnpeYsNWWHA7IKhDpdSCHxgE5UcEjRZl5143l6gcy5PTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363070; c=relaxed/simple;
	bh=Yx5xEMqJGzySG8tvjorAExeIP7CY/lm7J+faXeehDk4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gSoZxU2DWpybVYP/4wC5PxAC/aqTr5VvqeHcQWHo/+dOs42ShAtza4RtBE9ouhF4S2NHpR/u8bbAMo8L86JUjGC9hZBrDOPxkKvQYGsOiSMx20IbErBD8Z36JKddFxxQNh61tbZRZYXUnSWkbFUDW7un5IIVOPtRa7i5JSXsAgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jMp+Vbw4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xp0STL1o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OBCVow012360;
	Thu, 24 Jul 2025 13:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=olwyNgYDPJstk3JsIJRXCRQrrAE9gwSnGD3vGD7SOgo=; b=
	jMp+Vbw4YFOn1wlz48giPa/5cj8molPS4o0FttWybYXH/YAmfybofAR1KSptyXBN
	eU1qstpuW2O/FmUn4qSODl2z7//YYx73x+A1rLDGmJWe/zn0BIxgmm3iMgySNxgw
	7+RVB7SxpEto7htzD4IX3MA5434OXjicWAfHawo9qTSvPZE5bU130YhTAEjmfICl
	9B/EeZlj0GRCxenjN500UyQ/NNLwERtUpTQJ2hxuXRtM4Nc/bamIPzzPfTbBkptR
	CB4RBB5CDq8GIuJHMHK4fpgukY/Z00CWIscAWjSDSKTdTB/+UNbIAYyBVZwHsKzr
	Fe+o53J3FOxvloClp+YTDA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9sjcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 13:17:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OCbUbr037670;
	Thu, 24 Jul 2025 13:17:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tbvm79-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 13:17:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgtHcWOG0RfnfsazGGtcpPl8Zg2erm02EXchhIF87dhs2RClWEYevgonPVuwTDU1BFTsAjpDNwp1Mc1p7otrR0Ei59cq4Gvzb/mPRg+irKbs2d2CPcOfOhFE84qz//oGbeIEj6Izb1MpofxjamHAW03VMfO3TaOnEiwWbbE+Dka55ZoA1AjAj47eGpoZe8UT7dKmItsL3/focof2iA1Q2AJ7OzBYmC9of4HJ4EvGKCqxZgty5jVpWTOWRiRsc8ZYkHvsdtloKhheMsDsCj5k1y+hdiLO+R02A5Lo8biY0SWwup0QosLox+5vkXvTtVZDP3pWChaDDN0MOU2k9ySCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olwyNgYDPJstk3JsIJRXCRQrrAE9gwSnGD3vGD7SOgo=;
 b=vXecyxaCrEleS7byHlUlcGD+5QheO6LdZStbGU6PqaGNj8msLEbPslOwiijs/2DBbv1l6NWAFbb6uWvUGhmBJC3cfCDLqeo8AT9IEXK208xUGxfClO9dPqH42vupswAVh+juojDSd/jZTG/RpxXCGWm0tfuIpUGmgaMqoa1PB1kxRc5vwuxgtScCaAQf/fxTU5l8PyM49lrPLcSlMjQPtXX2APYHY7SeWh31WzJ0HL010xIcr936C92TyNZlW/dEu+En2KpYuG8o3fx/A4Bn9oKoRyNCrzDDrhaGBruYsXR0tBgXAKM+P+beK+F+teP1U1v3/648/WbWLHzNyVisZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olwyNgYDPJstk3JsIJRXCRQrrAE9gwSnGD3vGD7SOgo=;
 b=xp0STL1ot2RWwI/vuKqbN7/3sbRh/wwXfLuuk9Zl5vy6/1PcXUz9tGc9ppM0db4r+WSXKq43L5B/CByQY6AA5cJ/kktuyepTK4gcP4U0izIxyE7OEFmNiypYMyaeMxuKPFG2jsRu/aB/fHHSGQ/tR9IyIt718ytIn+QpY3Unno4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL4PR10MB8232.namprd10.prod.outlook.com (2603:10b6:208:4e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 13:17:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8964.023; Thu, 24 Jul 2025
 13:17:37 +0000
Message-ID: <7ba08aaf-dc8e-4037-8d49-fbdca7fac92d@oracle.com>
Date: Thu, 24 Jul 2025 09:17:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] NFSD: filecache: add STATX_DIOALIGN and
 STATX_DIO_READ_ALIGN support
To: Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20250723154351.59042-1-snitzer@kernel.org>
 <20250723154351.59042-2-snitzer@kernel.org>
 <41640810d384003d1e5ac5c9833d44fab7f101ab.camel@kernel.org>
 <aIEymBV9tIynQIE9@kernel.org> <aIE7ezLZSNVCJgS4@kernel.org>
 <00b0b5cffec55c28c95441107b55fcd16ef73297.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <00b0b5cffec55c28c95441107b55fcd16ef73297.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BL4PR10MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 9733cb98-3c6a-44b5-9bf1-08ddcab47530
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cGtZWGdlMzZwaEQvWS9QNVU2VlRxL1lnRk5vcXREWWlndk1vUU9VOFJROGNE?=
 =?utf-8?B?N3ljRWNacUtaSUIvaFdzTXlJc00vSHBBR05UenhJMzc4MFFWNFN2RTBLanVi?=
 =?utf-8?B?RlZ3SVBDZXFiSDUxem1lSE1NRTNQSHpzalJtYXBzVWJwYkJuaWJtTmRUKzFH?=
 =?utf-8?B?Q2kzWmFwM0VNV0xKTDlITW1qZmNWS05MSWRCQ3R1SGVIZmVHV3FNUTByR3pO?=
 =?utf-8?B?a0pGQjhsN1hXRDFOUGFkblVFY01NREc0TFhsTjlFalZhREpISDk5SXZzZERM?=
 =?utf-8?B?aldZSWhVYUZYWW1QOTR4ZCtDeWtnciszdEhBVE9kWTB4QXAwWi9XMUFrVEgw?=
 =?utf-8?B?RUNkUXYzYkNFMC95YzRWQjV3MFJoVkF4RmVDRjFRZEwvSjM5SWUyT2ZqcURB?=
 =?utf-8?B?bFA0YVNGWFFBTk93RnF1SVpOaFovSUd2RWx4bkZKWmdiY1pUSmVERmxuMWhz?=
 =?utf-8?B?eXh3Y1phWCszTGlnVVRpTmphZmhoVEZ3Nk5IQnVRRlZLWlNMdHhPNGltd2ZN?=
 =?utf-8?B?N01aQkdoL1ZSVmdYZmZlTXBLbXFWbUpkbUZnK3FFaUc5NHpXV3o2WENabnBZ?=
 =?utf-8?B?MnZ2YWlLRlQyQTFKYTYyTUgyblpvSktNK0o0d1FKT1pRMkZRWTNjWmd4RVRF?=
 =?utf-8?B?alFFRkhhNElNaGhvU1FnSGFQbjZXZG4wdUtuemF5ZlVnMk14M0tMTEVNREMz?=
 =?utf-8?B?SXFUNENPZEZ2cmVpaDR5NkZSdnpPdUdWSGQrcnVqNU5ia0Q5YTlpRTd2RGc3?=
 =?utf-8?B?ZTRTc016bzNiMkRVYjVGcXlCeHpXV21NdUNQTEZwdGtPS0NaT0lKUHd3NTYy?=
 =?utf-8?B?K2ZhamdBVFVqb284c0xhQm0vVFNucDdibjFtVmdZcjFZQ2FhVEFjT3U3UjZz?=
 =?utf-8?B?bG5RR0Fma1NDc2VFdGRXVFJXakdNUjJpMGJXT2lkVyt3andOYnVSU0xXaUVQ?=
 =?utf-8?B?Z0V3VVkxTjVaK3lDVnU2SW8zWEVwK2lhQmNabjNxK1hZQWJYQnFMMWdVZWts?=
 =?utf-8?B?eDRuTUxCb1FoVmFxZzlwSmh3blZucGpjVGw1a2dpaHhkb0JGQWgvaUY2N3FZ?=
 =?utf-8?B?K0gyd3dYZ2VmZVBIUUNGZFROYVpwTTducGZscnVDSHEydGRzQjVZS2tpcUtm?=
 =?utf-8?B?WVdFNURsZ1pWekhrM1ZQT1dPQjUzYTU4Sk1SdTRUU1dPbHhuV2pDTHJZQ0RH?=
 =?utf-8?B?UTJCclArQXMzeDIxYVJwTVE3NUFreXlCZTUyTmZYanpUR3NhODhtL3E3VzFt?=
 =?utf-8?B?TVBsMmVFZUd3REs5K25NcjZ4Q2drSWttUHpzK1BXK3kyN212My8zRjRjWUxo?=
 =?utf-8?B?MlRVcnhpSUtQT1pvZEFVSHV4MDBsbUI1L1lRTFJ2YU1XRkRLMm1wVWRac2l0?=
 =?utf-8?B?cFJkS09QRWtkNHYwbm9kU2JxcW9jY01aeDh6RG40VWg5SG05bzh6OWtMTnZh?=
 =?utf-8?B?MU9jK3Z2dFV4NTNYRW1UM3dvbXVjTHJUWElKV042Y2hRR0x4N1h5WGhQeEIx?=
 =?utf-8?B?MXdxbFN2RlVwdHBQODVRbXZsaEhFMG1QOFAvbEFyWTFVN1RnRjZMWE05ZVZ2?=
 =?utf-8?B?WFJzWG1aWWZ3anRka05URXZxUmRKbVc5TVlianBQRDhlRmdUTnF5cXpLNTFD?=
 =?utf-8?B?cm1NMUFYMnR0WHRJa0FQSWRYYUlYQWNzZFQ2UzkwYXprQjAxOEtlOHR4MHFE?=
 =?utf-8?B?cGZhdkFhK0xhMGw4Yk5Tbk5hbVdWS0k2TEhaUGFhRVM5RFBnR0s1eFdGdFBI?=
 =?utf-8?B?VWl4QzVxNGY2WlRVWUJiaFhmRVZUaHF0K0UrZDJaWmxpQlVQYUM5bENURUNh?=
 =?utf-8?B?S2d1SjFxNmJKL2VTVkdDZXVHdlBhY3NUcUJQWkdJdkpMSFNERlpkTG83anZy?=
 =?utf-8?B?WlVVcHU3Z0tuVWxNUHlMRElXQVZjekFWVDVaZkpXTDhrb3c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aHVsQlhzM3BOMG0raWFoM09XN3VoOEdxRG5mY1VxdjJrdjh1K1ZsbTdsN1ZK?=
 =?utf-8?B?K2VVSHIyazRhalhqbExDWmoyUXFHekJhSXdodjVmaks2am1RNjMyd1RxekhE?=
 =?utf-8?B?b1hld2duSUdoMXBRWjNqWkhZR0lwcmhHdWJVbW8wdEszQ2VEaElxY0FRQys1?=
 =?utf-8?B?ZzFwOEhRZ3A1Z2dVdWUwa243aUgrc3VMRXE2OVFJYUYrdDB2NVdPeHBSLzBT?=
 =?utf-8?B?RmJaQnFlRGhldlZZUXdRcmZ4NkJDRFVDb2pLTUVHZlQycFNTQjQ3WjBQMGtS?=
 =?utf-8?B?aXhDTlozL29wN2tPV0J4cGZ2eVY5N0dBL2dPU3NJdEptV0JKU0lZWU9vRXVN?=
 =?utf-8?B?dEdXeHlSUXd6WSs1eHR6UnIzSFovazU3a285MzlBOXBKMWU0TkgwY3ZBVVRO?=
 =?utf-8?B?Zy85aHh5b1hCcUh0RldvSmpPRzc3NDdyMEI4TnJuSjVJdzRydHpuV1lIWkJy?=
 =?utf-8?B?WDdadFhGWGtPZzJGS3Bad0dlVEVzTU0wdVh2cmtMSEtBWkZ2emg0byttMDFh?=
 =?utf-8?B?UGI3SEtrcXdmcHo5d3F2K1RSN1BJQlBxTGdQWTdScHA5aTRIMWpuaFN4RmlG?=
 =?utf-8?B?K2N6RVZVQXZVSHBMd1dyYXpuUGwwN25LTk93d0V2ZGZwU0lESjlBazUvZjJt?=
 =?utf-8?B?aVNpbkRUaGZWWjVReW9yZmt6eVlGUlVBOERra25FUEc3aUk3ampnYitBTlF3?=
 =?utf-8?B?dUZNcWNTcDVPOWk2SHkwbXA3UWFBeTRRUlI3blgvOHpvR0I3T0I3ZEpSLzNx?=
 =?utf-8?B?VXdnaXNmNnlkLzRzN0htTTZHcmpCNERySXpNaHpyaHJUc3dVUERPY1JOZmFG?=
 =?utf-8?B?OFRzTDFoclJIM3lGVnZkWjk4bGJEdGoxb0tDUWpiaXg1WGUrMzUvUWhhK2s1?=
 =?utf-8?B?dmVPRVczcGp4cjRXb0p6enBFUkRZQmMzNGlDKzVSQmpKeU9TSTFBRGF3NG1T?=
 =?utf-8?B?Nzh5TWh5OTdGZjVFTjlIZllmd0dhei9UMmpnRCtlZmc2OTdqSEtvTHFSYmIx?=
 =?utf-8?B?MjRnWnB6cmhDRjU4a0gyY3pyNFBhMVM3S1I0enJFRG4zWksvUW5NWnNESlpZ?=
 =?utf-8?B?UWgwY3d2Wm1XdG9ka2dPUjlnT0gwNExvYVBRdU5ON0FTZ1dMQ1ZQdkc1Rzdu?=
 =?utf-8?B?WnV1QTVZblVVV3RUWnJ5SmFjeloxTlNnd2RHT2t1dklXbzBkbVJKc1dZdHM0?=
 =?utf-8?B?S1hhV0dPbU9ZbFI2eUo4YzdVVTlqK2drZklTTHl5SW1XY1ozVDNWM09LYkRS?=
 =?utf-8?B?MlpsdXRmS3gvQ3krakJyV1RIeFVLVDhwRDUvQ2FudkxUYU94VlZPT2JhaU4y?=
 =?utf-8?B?dmpVR0laazMvblNoMC9JdGl3SG03TUprT0laL1Z1U0FEODhNQjFOTnJIZ2x1?=
 =?utf-8?B?elhJZXdLYytZajlxaXhRUkRvc2lLUlcwNVF2L0lVbXVtY3VvTHlTamE5TWt6?=
 =?utf-8?B?N2d6MzhJNmg4QmZQdHNIam5IYkNvdnJadzFwTEw3cXAxcWVURVZvWlpwZUZC?=
 =?utf-8?B?Rmdtdi82aUN3TWNVL0JoaytIZ3VOcVRZS3pFYnpXcEJLNWJSZWx6RGYxQnVF?=
 =?utf-8?B?aEN3ZW85b0I5L3dPVk02UnZncGEyMC9FVEwvUVo3ZXUrL2t6S1Z2ZVBxWDhv?=
 =?utf-8?B?blRNYzdYa25aQVcyMmQ4czhOSXZ2aGsxaTY1TVFzNmdETXpzV3ZqcTAyOFJZ?=
 =?utf-8?B?Z0lsU25wem11WHM1YU40bjNxcVJmeFNUVW1EeGsrcVcxZi9PeTNSY1NWK1pw?=
 =?utf-8?B?QVJBeXFOc1ROcjR2NzR1Wnd0ZFBDejY3eWNVYWJrWEpDdTE2UVl2SEoxblpL?=
 =?utf-8?B?MW1zL0RINEswdjh0NEVTRm5mZ21SSlR6NEtwWHR5TnUvMVRrb0F4aUs3SVZD?=
 =?utf-8?B?ZW1CZkFTZFlpd2NHT2dHYk5tTXNsalZIcDRjUW9yQWJJSTcrc1E0N0hyNzRL?=
 =?utf-8?B?M3Z1WFNmdGZ0anJJWEgwb1gyMnJneGhsYTVic0ppcE8rMEpjUXFlbTlGbkZm?=
 =?utf-8?B?VUZpeXFIT0NubTNjSytSa25wRzZTSG5SOWpZUmx5elBsWWlzTFdZc2JQdW5I?=
 =?utf-8?B?UHlNMFU0SXphY3pqYm9TdHl5OVd5d3NVdzN2cDU1blYzQmpMY01QY1ZDdVRy?=
 =?utf-8?B?TDVQSHZaUTA4cFZaQ01KditvM1htMS83NkQxRU5Eem5vVzBlcWtJV1h6NHBF?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UWlIGt04qaM6+UtserNqijuyyt1Kw3sHC3iCKcj8yvoAvEvtpYsKqJefiJ1v8CmpboIxSKlLPbrxUS520UxxATw5uO21iT4aIues7J2Hr1NPu3cqIxw3UMWleE7gep5NNb0FZVX0u7CzmN2Gwi3iHln88jlNQoH8TSNBs/XbqBNu1JsZDk9Udn0KerhhbSkr4+eHw3vy8C06OJIi5fAHw1+eGKtNanK8TeHqxbOl3yKFgE/PEhHfM+Yy8kRQx5BD9700MnIjq6kHkNbzu/j5ekJxATHnVW1omYr4xcVbp8vIA3A3hhtQgb2SgbN4SkaY8f43euQH6P/IOYLYhWg6OeuLRESMH0PwhegptSVReJXshVgevAnjV0oCA05tsdPy9lHZeQgHPTjv98Z88vhkdRmFoAZ5x1qNmJ3N1jD0HJ8RMsv/GG8/y0X43sdWnSizdrSgQM+mBZ71h3CciQkTgLrL1Qcv80BgPO+GlfxLuxXN0u6mRAcQidndE1xatOnBhgyThQZ6hg3LUtIfYn5Px8n8HqKMWGOltynfg5jJ69jC1vv1MjOc6a53VyIu8QAB2x3J216hL0wOGpouYc93RNBPD9WVDTCNOsKCXTQJH/M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9733cb98-3c6a-44b5-9bf1-08ddcab47530
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 13:17:37.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vq/SfZdQzD8PTkAIvR0mZi66c24+s0cXLeHWw4BrGvB57O6RyrmkkOh337WV9GdusRiwzMklAUO8KRfsxEChcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR10MB8232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240100
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=68823279 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=GO9jEllHx2TYRDvRZzIA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12062
X-Proofpoint-GUID: DDN83y4rlbqXJEACBP2oJEEV_1-Q34qV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEwMCBTYWx0ZWRfXz5K5iMtOPRdd
 T/bwpInALpf78Vb9YayJwzVIDyhQzFv93sjQnsNAsE0ma0vCqsl5S5LhiCghmF7m1qKuIFKDokr
 XNw4w/YqueTb44z4t0hLa/jFaNSriHxRM6p5TMM2uKgsCW26aLkBQ+eIO9yrJ+CJckppwXhhW8+
 ti00d4mhWtDq/wipa/gP8+YWffogj14c2o+lHAfntEySL9DTjTarEpe+2UgFLYodeBw9d1nnOBf
 +J7kRCvZy/9JrrNOA0wXRiY0bAClOBr3SnhhDmR/PxEZmtHf0DaJKFJjyHYsVlTEMPHY42VSC3t
 dTHfgZaOtltiK122YhqCTG+tQvJnBAY97u6GexNjKClMxnyONNNi9ipbvlbrDLAaSk1/2x3Y6jL
 GP+IEiSY/D1nQ1lZmlcdG8EbQ9nFg1cqfzmuS7UpJrZFaJSQNYLTh+DaGH7biY79cWui4y5h
X-Proofpoint-ORIG-GUID: DDN83y4rlbqXJEACBP2oJEEV_1-Q34qV

On 7/23/25 3:56 PM, Jeff Layton wrote:
> On Wed, 2025-07-23 at 15:43 -0400, Mike Snitzer wrote:
>> On Wed, Jul 23, 2025 at 03:06:00PM -0400, Mike Snitzer wrote:
>>> On Wed, Jul 23, 2025 at 02:58:19PM -0400, Jeff Layton wrote:
>>>> On Wed, 2025-07-23 at 11:43 -0400, Mike Snitzer wrote:
>>>>> Use STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get and store DIO
>>>>> alignment attributes from underlying filesystem in associated
>>>>> nfsd_file.  This is done when the nfsd_file is first opened for
>>>>> a regular file.
>>>>>
>>>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>>>> ---
>>>>>  fs/nfsd/filecache.c | 32 ++++++++++++++++++++++++++++++++
>>>>>  fs/nfsd/filecache.h |  4 ++++
>>>>>  fs/nfsd/nfsfh.c     |  4 ++++
>>>>>  3 files changed, 40 insertions(+)
>>>>>
>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>>> index 8581c131338b..5447dba6c5da 100644
>>>>> --- a/fs/nfsd/filecache.c
>>>>> +++ b/fs/nfsd/filecache.c
>>>>> @@ -231,6 +231,9 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
>>>>>  	refcount_set(&nf->nf_ref, 1);
>>>>>  	nf->nf_may = need;
>>>>>  	nf->nf_mark = NULL;
>>>>> +	nf->nf_dio_mem_align = 0;
>>>>> +	nf->nf_dio_offset_align = 0;
>>>>> +	nf->nf_dio_read_offset_align = 0;
>>>>>  	return nf;
>>>>>  }
>>>>>  
>>>>> @@ -1048,6 +1051,33 @@ nfsd_file_is_cached(struct inode *inode)
>>>>>  	return ret;
>>>>>  }
>>>>>  
>>>>> +static __be32
>>>>> +nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
>>>>> +{
>>>>> +	struct inode *inode = file_inode(nf->nf_file);
>>>>> +	struct kstat stat;
>>>>> +	__be32 status;
>>>>> +
>>>>> +	/* Currently only need to get DIO alignment info for regular files */
>>>>> +	if (!S_ISREG(inode->i_mode))
>>>>> +		return nfs_ok;
>>>>> +
>>>>> +	status = fh_getattr(fhp, &stat);
>>>>> +	if (status != nfs_ok)
>>>>> +		return status;
>>>>> +
>>>>> +	if (stat.result_mask & STATX_DIOALIGN) {
>>>>> +		nf->nf_dio_mem_align = stat.dio_mem_align;
>>>>> +		nf->nf_dio_offset_align = stat.dio_offset_align;
>>>>> +	}
>>>>> +	if (stat.result_mask & STATX_DIO_READ_ALIGN)
>>>>> +		nf->nf_dio_read_offset_align = stat.dio_read_offset_align;
>>>>> +	else
>>>>> +		nf->nf_dio_read_offset_align = nf->nf_dio_offset_align;
>>>>> +
>>>>> +	return status;
>>>>> +}
>>>>> +
>>>>>  static __be32
>>>>>  nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
>>>>>  		     struct svc_cred *cred,
>>>>> @@ -1166,6 +1196,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
>>>>>  			}
>>>>>  			status = nfserrno(ret);
>>>>>  			trace_nfsd_file_open(nf, status);
>>>>> +			if (status == nfs_ok)
>>>>> +				status = nfsd_file_getattr(fhp, nf);
>>>>
>>>>
>>>> Doing a getattr alongside every open could be expensive in some
>>>> configurations (like reexported NFS). We may want to skip doing this
>>>> getattr this if O_DIRECT isn't is use. Is that possible?
>>>
>>> Good point, yes, should be easy enough.  Will depend on the debugfs
>>> knobs, so will tack a patch on at the end.
>>
>> What is the best way to check for NFSD reexporting NFS?
> 
>> I've done stuff like that as a side-effect of setting/checking a
>> particular flag, e.g. commit 5cca2483b9fd ("nfsd: disallow file
>> locking and delegations for NFSv4 reexport")
>>
>> But not immediately seeing a more generic way to do the check...
>>
> 
> I don't think there is a reliable method, and we probably wouldn't want
> to just limit this to NFS. Other filesystems might have similar
> limitations (e.g. Ceph or Lustre).
> 
> I'd probably just base this on whether support is enabled in debugfs.
> If it is, then do the getattr. If that slows down reexports then we can
> figure out what to do then. If and when we get to converting this to an
> export option, we may need to do something more elaborate, but I
> wouldn't bother for now.

Fwiw, I would expect that re-exports would prefer to utilize the NFS
server's page cache.


-- 
Chuck Lever

