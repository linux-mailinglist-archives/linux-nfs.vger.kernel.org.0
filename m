Return-Path: <linux-nfs+bounces-14035-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E728BB44029
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 17:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC33188C867
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD1D30BBBE;
	Thu,  4 Sep 2025 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hvISzkiq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="meiOcycZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5D3101A8
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998741; cv=fail; b=NKgeOMutXcONFe45MAZPI/3gc7+ck0XpnR1Jrx9b1AJA8m2+q2X34uRvljvP4wNW9UdmcFuvGuUytNEZWHy4IGVJC/0DpVDEvTituxJCs9UyyIPlwiHyloqikx4thmqZJe5UIZ0/JnAcRYtmB5BgSlz8sB3Qtsyoh0pRVHgLf7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998741; c=relaxed/simple;
	bh=LfvaLutaKvbcWvKhPsmOjdx3YuRhlFRkDRKkpaJaagI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tFCbAI/695nFTa5Kuy6HdhghI4SikxquT8JT0RM4ofLLbiOf3MGHcSUnksc2lPJOAaX+KezPd6LoUboQPXcu273alecgNfNScoRI5qz8VJxDCB5epeqXPpuGjJNrMML2RLKGtRRvf3F+0VM3QwxmWOU4KgukQnQmACe4aEli4NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hvISzkiq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=meiOcycZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584EuHkk026175;
	Thu, 4 Sep 2025 15:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nU9F2IpL8s420o3dVNKss44OHwFz90P7j84FcmAxUww=; b=
	hvISzkiqytG2bMjeSAU3Dj08rUENW3sbBuu9Da2DZ2e0r/VBgTONAooh0BbQRn4F
	GlD82Y1/10yIXhMelYN/Z75kBFTv0p7W5AUCE2wCmcAyIfjCED4jtSpfhQrcXcjm
	2qbkaebqlzlSXmPmcSBxDkQt10rnPfy+5R7PdYX1A7eCRws8DfN0zMXhjAsS875N
	gNyMiuLlT4KJ4j4/YwENgi7GG+Zyv3lvc1S3W3tuPlj7jY4nMqIlmwUaK5kvUmYH
	tKlE62wwGykP65pvFlFCBJ2qMHmZUjJNN3cIK7yPGo0DIx11/zc2iujRyJF6pDF0
	1MrATIUzy//dVNuy3iii1Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ycqmr2tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 15:12:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584Ei6oe040672;
	Thu, 4 Sep 2025 15:12:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrbe3j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 15:12:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWWwNnDQKvLweKPIoj2s/bsM+AMmKhnV4B+2wE/GzQzaLshNKq7fRP2LvvuatKAY4tkx/fLwVWua8jYJe0AnXqui6SuPjbFxt524d9CmmFGuKEkKac2a7v3XIScgK7arE8fmRnDxrQEwOLns/OfOGsksInx5RG65dpuNd4jCKomQzm+B4mvkV9RCGEcX0EOhZhMklPUs3WhaH2WKwwwKxxFtOErkOTKTFii/DMnvA1W+cSxNottHwa59UmgOYi8TS4FN7kI+kxkpFxoRLeaNPvPedRuE0FZpenyGtttPtiEGZrIvLM0wfumm/o63y75qcY+QPDNKXsaNiJycXufclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nU9F2IpL8s420o3dVNKss44OHwFz90P7j84FcmAxUww=;
 b=WXjqogzZ9LghUOemjVKxWydnrMD5jPNGk1MTqpg+m4V1KWGPcSvK+W9qZUjzuWwagSM37FUQ8DMaimPetSv6MC3Sf0M/jMDDOF/oB/lVuWBAP29YsSTDL9YdzMLBrZWlYhdtH7ZxIIoeRtEXnFqpU52NslylOpER6lKB5L9f3XcN1rDNsYZeWFy2WsFDiO2dPehdMSFE0AwjcyKo1coCwM4QNL0KBqh2AiJ5ScQ7Xq4fk7IkdEwgGw6wDi9Dt80ceCVEJTualwpHGxuQI1dCYFgoJYQgRGc7l4Z1QUN4hZn4hn+PNK8NNPQUGt9h8eiODUT5RbdrWHmax83rpzYL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nU9F2IpL8s420o3dVNKss44OHwFz90P7j84FcmAxUww=;
 b=meiOcycZUdqZWGNeLVrhLwp4U1GwtKVlxr5TTur6QfdeGKsssjQxXeGHNVbAR3K2PSFYWPeKZVZX2QZrwGjfjoKxZx5AoP9gZ7N4hrpWmxvi4KV+kiB5NL+AUKHlracJG8kTCVauAioIdoGGKqoVMled/P81UGfVpVQSl4vYv5c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7607.namprd10.prod.outlook.com (2603:10b6:930:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 15:12:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 15:12:12 +0000
Message-ID: <70cae03d-1ed6-4132-af64-46e25f059006@oracle.com>
Date: Thu, 4 Sep 2025 11:12:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] NFSD: fix misaligned DIO READ to not use a
 start_extra_page, exposes rpcrdma bug?
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
 <20250830173852.26953-2-snitzer@kernel.org>
 <2559f795-bdc9-4d39-aa03-e6a6d89e9f84@oracle.com>
 <92908105-9261-42f9-a0fd-ebfaf3e2f564@oracle.com>
 <aLdcbnELMGHB-B_E@kernel.org>
 <18b20826-3c9f-4763-b0ac-c7f1dc2be4d4@oracle.com>
 <aLdhL7xFxR-r7H_m@kernel.org> <aLmlY-xdYh73UaAf@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aLmlY-xdYh73UaAf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:610:4c::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYYPR10MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 7718a9d3-5945-4c6a-8f19-08ddebc56c8a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VWYrZzY2VGF4RXRJQUFrODY1bW43SUhJdHhqanJvb2cyTFFwTGdMNFpPS3Rq?=
 =?utf-8?B?YTY4WHFMT3V5ZlBxTXIwOW8xTllHQ3lSM3JuVndJTC9qVUk0N1YyRFc1cmwy?=
 =?utf-8?B?M3VwcFhaSTJ0TmJjUTJDNWordXc2RnRDUktxZnE4ay85a1ZrZHp4RndFVG5O?=
 =?utf-8?B?dVdDV3kzTkY2RkExVy8wTHR0RmZHQVpKMHd0cEhMTjNnbGJwSnA4VjBtSTJN?=
 =?utf-8?B?RlZMaHVpdDNKODdMa1BXVVlFMmpYMm1DSDArUlE2dlRlQlFKQkpwQWhCMi9J?=
 =?utf-8?B?NlpubGRkbGFaQjRLaHBsSE9lMVlSaUdOZHMzd29MTHNSS25ZQnpqVVphYzQr?=
 =?utf-8?B?ZGxxdzhuNWs4cmFOYThjZWNYYkFhdWFMSW5Kcy9PYzl5c3o1MmJETThmYVdw?=
 =?utf-8?B?ayt0UTRHYkNuYXNUcWFMaThHa3hWbkpUbllxd1RiRkNZek1iTFhURmVONm5t?=
 =?utf-8?B?WjNGZzVCMS90aWxPZlNUeHQxcDUxc255WmZMRzV6aTNYSzBBc1R1YnhacWVj?=
 =?utf-8?B?SXZjaDJ3M2xKNGhrdEJ6ckdpcUN4dFZ4L3ljRE1pU3JXOTlEcmRYbURVdGhY?=
 =?utf-8?B?bVMwVEhBbU1CNEtBM0h1YTJkanBGUjJnTjRzcjNWUTN3L01tMWZ2K1ZWNmFx?=
 =?utf-8?B?aG9ldG9pbGRUK014L0ErdnZtV0IvelAwaHlDb1NBWTI2RXYrUTQ3ZkJiRGZx?=
 =?utf-8?B?cEtrMURESUdjS3pxNEtHNjVSQnlrdXBDMlFSQ296NzU3dmJWajR1amVUOUNy?=
 =?utf-8?B?c2d1SDFZd3ZBM1UzL002RDlwRC8wZkh1MjhURWk1ME9Ya0NKeWp0NFY4UlF0?=
 =?utf-8?B?ZVVqOWdTejlobTkxZmpCWFJGNlNXNGxaYTZjNUh0RmpFQ2lGNUtrZUFMTDJ1?=
 =?utf-8?B?WFhUbEN1YVFHSHRuUWE1aFZMQjZ5a1lPd0hMdzkxRk9yNTJlZy93QnQ1OE5O?=
 =?utf-8?B?VjFnRzRCUWdraDFlcTlybGRHcFlBRklDOEtVZEF3YUR6OERDN0dxYWJoK1g1?=
 =?utf-8?B?eldIQTZyTWFuQWVaMnYxcHZtcThxbVFFTm9JSjdJRDF5MmtjaWd0aTFGKzQ3?=
 =?utf-8?B?YmpqdzUwZTlFL3hVTHNNQ1J6azJNbExUcTB1c2Y2K282eFh6d04rV0ZXOXJY?=
 =?utf-8?B?bzJQeHpZTTQ5MmV4eVEzQ1NlV2U3TFZWMTkxeE5JUDJkVHRyODRwS21ZUzJB?=
 =?utf-8?B?Uzl1OFBMbDNrM3ppdmwxeXNkRXRXNzBHdFNMYXkwczdsSk1OWEJuMXR2alRh?=
 =?utf-8?B?enM3K0VVcjZMU0cvMGpTZTBHbXBhbzhLZUZlclYwVjRvdVJoM2c1bnpoTEFV?=
 =?utf-8?B?K0U4RDVqY1NlQlFxa3Nhdi9kU05EMStZL2FRWXdXeklMUUcvTUs0S2ptb0E5?=
 =?utf-8?B?V1YrZHlHUHJHRWt2Zmp2aEtRdEt6aENlMzZVMFhhWmhKd3FiTTZuQkFiTmZL?=
 =?utf-8?B?TTlqWWRUTmdiSHlyVnpQY3Jlb1ZNS2l5Skx4dncvMXg4RVhXSnIyL0RIWnFW?=
 =?utf-8?B?NnBDdjZ4ZVhNUU42OFBpdHhLNHlsNm42Uy92MXhDVmh1dURSaVJZRzd4bWoy?=
 =?utf-8?B?YmQrSEpEblhrM1NtRU1NalBtVGNFRzVxMFFjV1hmVUJuYW9BbHcyZGovVmR0?=
 =?utf-8?B?emI1eEZMTHdURDhwUGFUa1BtVDlyQ2dzaFhwRXlFWUNHQUp0Y2VCYWZndy90?=
 =?utf-8?B?QWVsY0ZlaktVZFc1U3BxZXg4S3pJZG5pNEpTaEZSOWJYYlQwb28rVm1GMWtO?=
 =?utf-8?B?OHNMZnhFREZNbTFnZXRxdW5XRzVLcFBETVJ2UElwS044cHVJV01BbFVJaWs5?=
 =?utf-8?B?MEZkOEhFbkNmeHJVeFVNNFZOS1NGdTh0bnExVitzS096SksyV3JocDJqUHJ2?=
 =?utf-8?B?ZFYxMlV3L29BV09XbkkzUmVjc25LUlZrT3oxSXllRUNUYmNnOHBmVFdJRFlS?=
 =?utf-8?Q?dnlTnPsylJM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eC95VUQ3M0FMRDJNdmZ0ODcyMXJkV2laay9RMlozNjlJYSsxVGxPdUdLaFo3?=
 =?utf-8?B?dHVVL21rdVRTeGZIVEdEa3U1dDNqV2FPOW9aREcxa3JvdkdDSmdycFZJUGM2?=
 =?utf-8?B?cnZlSnFwMytQRkxKLzBnUnExMWR5dG1NeHpyL3JGaml6YU5QM0lLQXBVUEhM?=
 =?utf-8?B?YisybHZkQkdQdHJ1eE1EMDRzTUVMRDlzSmFsOXpWOWFCNkpSTko5VjluR0pa?=
 =?utf-8?B?RUtjalovNGxEMHhVaGRmc2tyTVNYMUhwYXl2b3RyTUhGRTAyeTZKYnFZbnY1?=
 =?utf-8?B?aFcyZ2lCc0lvenV0N3N6MWVUSk1vaFc3bWprN081NCswQi9EVGd5SWZFNDVY?=
 =?utf-8?B?TDdaV0lNQWxMcUpNNlhSdDFsc0pRR3lnRzNoTXQxanBlZ3VaOC9HRFVIOGcy?=
 =?utf-8?B?bnkzaEdpNll2TW5VVmwzRnJMSlh5bGdqZmpiWFhsZzZ6MDZKOXA3cllvN3dU?=
 =?utf-8?B?ZkdORWNyNGNkMUFwQndhV2xCNzlZanlQSkprakpHTCtNOXVseHNYNkh3SUV5?=
 =?utf-8?B?SE9TSW82eVRIL3k2amMzRmgyVTdJSTBYWURrcjFBL1E1eUQxSFFyN3hpQnFW?=
 =?utf-8?B?Qk1tV00vbjBWdVExS1RkeFUrWFpLY0pBR1R4OWtjdEtSQ2dZV2FBVG55Q01I?=
 =?utf-8?B?dHkwdWo4cWN0TUd1dWoyWnZmVnR5dmhGK3pPcld2cm5zRnNwLzJ2ZVJpcDN1?=
 =?utf-8?B?TE1YZXgzbXRYeHNBNmhKY2FZcjR2S1d5bGdzZmJUV0d5VEJHVXFKNGlFdkVK?=
 =?utf-8?B?ZTcvZjBuUm5NcTdRcVgvZStYWnp1c1NwZkNMRHBBQnZlanh1cnlkeGhqV1Za?=
 =?utf-8?B?RVpCUURJdmcraEhxdTlkZ0hEdjFVd3p1V1RIZXEzZC9vNS9uVzVhc0R1bGc5?=
 =?utf-8?B?eUdaQkNjK1FDMDV5amx6ejlNRnBGNXpkQ1YrQWQxRkdJbHBBVThXMjVNWThZ?=
 =?utf-8?B?Q0hpUnQyM0RmTjhUQ3ZoVVhpQldiQUkxV1I5bnBsaENCWW0rNWJrVlpnZW5G?=
 =?utf-8?B?SjlWVUpMaVZxT2hiQ29xRHJCUmxSNEpwQ3kvYlo2akVPcmo5bXAwTnhaNHVY?=
 =?utf-8?B?SHRYYWRBZ1VPdHQ0OWdsUGVGRjRDbE9kRlNlV1RVN2lsc1BVemhKUG9xMkYy?=
 =?utf-8?B?NlRwUlNPV0dGeWZabS9ZQ25PdmtOaC95eFR4QkJuM0d3N0l5QVExbElDVU5o?=
 =?utf-8?B?blBOU3hTT0paSkpiQWMyWWtkcjlmQkgvWGxwdHlmQXRITzlwMVhCVURrQkl6?=
 =?utf-8?B?elJ5eGdFZTJiajQxa3BsVVBSdmFwblE4UkFNVGpYOTdqOUVGeUMwM1Jna3V4?=
 =?utf-8?B?ek5YWGF6S3JYSFIxbEhpdlVLcUhZV2Y2a3V2SGZtYUFWaDVGVitySUhoNCtZ?=
 =?utf-8?B?QStycHpSa1lranRLR2MrVzdSUUowbTYrS0ZST01IUnFrb2JIRnZkNHd6ZlNU?=
 =?utf-8?B?N0pMSk5pN1Via0s3L1liZFBuNnlQTHc2Wlk4MzYwQmpEaHNybFp4anhRaUl1?=
 =?utf-8?B?WHBoKzJ4bVI1UDFmNytoQ3lNRFdLZFF1ZmN1cTFhbmhqM3BTeFFQSzI5ZExT?=
 =?utf-8?B?bVdxMzg2WUg5WjRjdmZGQXRBalJNNUwwVXMyOFlkNzBOd1MySlhINVRCdVRI?=
 =?utf-8?B?ekhCRGh3K3QydUdZWWZlenNCemhOQ3l1MFovamptYkZkLzhlY0ZEK2UvWjBh?=
 =?utf-8?B?anozSFhjZ0N3bzVSaldFTUJvcHdhNFlwQWoxYkxlc29PbUkwUkRqQ3hKdU5E?=
 =?utf-8?B?UkVrRVA1dy9YSFNrNkNUWjlsSjJPVEZHQkdGdmljVXcrRDNNZVNGSWdCVGlW?=
 =?utf-8?B?ZWtzdWtPWVhob2gwQ0pJRmY3d2p1VU82ZXh3dzMyQmVFa2duN2owem42bnNs?=
 =?utf-8?B?bzN3N1R1Vk0vS1FiYVhhSTF2SklFTlExcUFjbzYzaktjdWlJVWQxUlowWTRF?=
 =?utf-8?B?aG01NElBczRvRktvcmxZbG9SQk4vTThTU0taVTZGOUxrb3NPbG8veWFtc3pZ?=
 =?utf-8?B?d1NGWTFraStkV3hsTDRxQWM3dForbHBiNnlQSEZLQkM0OUcwL3BVd0NCYVhQ?=
 =?utf-8?B?L094M1V4ZDVqREl5MDNUc051RGhLSEc5bm1TL2YwZmdwYkR2eVVES2pKb3dX?=
 =?utf-8?Q?yoKN4UJTw3kuk02RZZqBFFMKS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mAn419XYmcRpoPD9W2hLDOx2e3xth7hTaFhzzXiKGtkyHvaA9p2+nic3/hkrxUSEa+jAX20RJ+ckUMOKuWXGVTuLjryeKlqJT4GZFA1eO3LpOtD/D88BEZxf4lAwOc6O0d+C/fkW9Wx8CEflMXpLvDrP9Cc4VWedWP825+dGjfsvXA6qfdtnkD/Vq1TAOn0WTPnBJ7EJqmA2mlGgUGHoSSGBSVRAq0dMJkCm7xd4s4x71KP8KWxJtsLDa0AMVODu3xdbQMth4PYL3bPijM4uiL4p0SVQQisWCpdEcyNEk+R+sboV+9r99yHETxalhB5kUOCYkTgYGJKAa6GhBxkAB2ByrlEPTA2SnvZKjwkgfPeTdGPT9aMZqZyH2dKxnqoZ7jaOuUB8W2SWcPJFER5Uik15xSY444TmkkAytRRuTnbZ6SLv/Xsh3QWneseTEh9wuR4GFIvMylcEX9OSVhtkJlDC2nhYDwhoRjOzKHgm+2XEJFL8v3GlEIncolhEbUxhUIvzDwr4B5a5XKfaNfrto4aQabxgwGNwAf1+nPZgtFA6+sLfzS3vo0PnPYcdSuxeV84GzZzmaCbC9C2eocw5mpZJkPPLo99SU/6XVfhcnow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7718a9d3-5945-4c6a-8f19-08ddebc56c8a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:12:12.0514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70yfMES4H7snP9IHco+MJpA93WqpXs5ZnmEU4YMkXECrWepuSbudrtMAxa6nF21LLswFTzedagS39EquAcsvTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509040149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE0MyBTYWx0ZWRfX02S8ceAaxdZa
 KzRDMhANvqGWJVncfT+aSOZPgQSe6zQKwSnBiAl2GXN0zH6+M8ID7V0lXjstfr4YoWrWtBQYqvg
 rK1WtyND68J25tLcBlZ8SPzulj2H3PUuD1h7FS55kp3TEUP8kWXgRku7tBh5Q+c0iSM/sGZNBc9
 Q/t3cZgWr9jZ808QbOLyEZOB10QKmMDyUukqXCzM2g4XhOVM8whXPJ9MgjoTwVHVkL3Yhe4nhrr
 um+stE7Ab7yra6iCPwuIsjF3JWliWJDHIYj9WcSxYeqsoGInK8z2YTA7Legh6PvpbPV2gJhnx4W
 BJXYQbteyCaIp8iNd/ghT2gtd1wSZUZUcfFk6K0fGfKyN878plxOUpFu/yLf1j3DAlqOo2weEVd
 zfUlk7gY
X-Authority-Analysis: v=2.4 cv=O6A5vA9W c=1 sm=1 tr=0 ts=68b9ac50 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=rqkTTtBmeXmQMY-pL30A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vqZGWm-VQ57vb13v_L_AIRnbgyB3TZ6w
X-Proofpoint-ORIG-GUID: vqZGWm-VQ57vb13v_L_AIRnbgyB3TZ6w

On 9/4/25 10:42 AM, Mike Snitzer wrote:
> On Tue, Sep 02, 2025 at 05:27:11PM -0400, Mike Snitzer wrote:
>> On Tue, Sep 02, 2025 at 05:16:10PM -0400, Chuck Lever wrote:
>>>
>>> I am testing with a physically separate client and server, so I believe
>>> that LOCALIO is not in play. I do see WRITEs. And other workloads (in
>>> particular "fsx -Z <fname>") show READ traffic and I'm getting the
>>> new trace point to fire quite a bit, and it is showing misaligned
>>> READ requests. So it has something to do with dt.
>>
>> OK, yeah I figured you weren't doing loopback mount, only thing that
>> came to mind for you not seeing READ like expected.  I haven't had any
>> problems with dt not driving READs to NFSD...
>>
>> You'll certainly need to see READs in order for NFSD's new misaligned
>> DIO READ handling to get tested.
> 
> I was doing some additional testing of the v9 changes last night and
> realized why you weren't seeing any READs come through to NFSD:
> "flags=direct" must be added to the dt commandline. Otherwise it'll
> use buffered IO at the client and the READ will be serviced by the
> client's page cache.
> 
> But like I said in another reply: when I just use v3 and RDMA (without
> the intermediary of flexfiles at the client) I'm not able to see the
> data mismatch with dt...
> 
> So while its unlikely: does adding "flags=direct" cause dt to fail
> when NFSD handles the misaligned DIO READ?

That make sense, I will give that a shot and let you know.


-- 
Chuck Lever

