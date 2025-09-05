Return-Path: <linux-nfs+bounces-14068-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4E0B4595F
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 15:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2196D3BDF81
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A2635335C;
	Fri,  5 Sep 2025 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LTroOPJ9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yVFUDwdV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598043568E4;
	Fri,  5 Sep 2025 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079695; cv=fail; b=rGmF4pII8ueOkeIKiu/+MOw918n3tqquIen8gKnFUy4yVyWXuswBerbGd8FWsxfIBSru3uL8aHq6CLU+RDXpsAfEJMX7Nn1I1N7myVnP7q675DhmTp+ybOz2N+WgzOwl3XP09REtJNJayecN+iE0Qi8DKlhXTjeQYwdJNzxQOIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079695; c=relaxed/simple;
	bh=/Eh+uc8j5sJ88ZgwglEprMb0Yv6aMIXyx3W7pdHNf8Q=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o5jzJjbAEG9tSCzmbVZBQxi+BFSjL1GHbInpF59+T09/ZMs8i1+501zA0g3/S5JF36Em+qJxwF3hn+5UvT9OAruhMPIzCuTaRRAqFvKARhyMUVQ2Z06uaUZxQVGF4LWwA1G9lSTD8CPUMKMPZGz67xSGhLILtrE6PcnFMQDetYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LTroOPJ9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yVFUDwdV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585DAUsV002543;
	Fri, 5 Sep 2025 13:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fxtKlXzrr9VP3cvoAF4qvVVXlvr1wzfxeU6chbS0m9w=; b=
	LTroOPJ9ItR2gowGcnz58FhncmpTDbN2ca2EuLBD16aMG0nAiLfwy8AZUG3mBTgb
	nK6OuRO1JweoEMD3OQST+CAnQoh76aT58+iqMprqWIZWn3BjmzmVxWO13UH2WY7G
	5stZwIeKYNNq2HVFuiE2dpcA2K9jp+P9yp3Fs95roChcYpc0mNy3cmh/UtTh7lGy
	s0xoz5D2etp1XZfVhRj74cR1f3e6VcfI/WwI8M+sijnNAFtFsWpmTybfGVV3aSqD
	iHw2c0cF9p4MxYeNOJlHEt8yPgbyTgkRURU1Vao9tIbcf5mkYd2IAdc09aVD3kj8
	OoilGu8QpI9kUlgnT33u3g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4900ggg22t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 13:41:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585BgmN3039513;
	Fri, 5 Sep 2025 13:41:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrk0ewu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 13:41:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTU/2zGWC72ajiarzRt3dCpAQ/qKOgMFBGVJpRn6zwkXFRcKJpRc7vbhaMHmI1icB/BHRhJNdAA4HLqtxc98XDYGCPU+bYjDBa+Vu3AAl6CHBdeKnVN+xh8zd65ESaCDDX54H8btBrq849s+UX4BVC1891l7uGxxeoocK1Yb8xqeIuP7/aJjKRunEjQQqgTjiUDvqZ7Pa6LHvt9VPGx+l8hW/XC2LrrWtLqokro6SdZyjHwxm0rh2zDpj8EhlfhVrKfjCqo/8GRh+ZUsWZdmv/TAzUFd3LIqaIemVKkUZi8cDf+HrC/O3deKK3DTaGhs/obP3nMgxZDFU6MBSLkG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxtKlXzrr9VP3cvoAF4qvVVXlvr1wzfxeU6chbS0m9w=;
 b=QJ4EkbfljZqoi//7G8PUzNbPckOLUY/JHn7Bf2FXrDoN1lEhaW22PnXggpV2gbPiybY/2eNv5mWJncQkoPIxjzQiQL8lI+pHuk9vb7RaS5SQH9ZW66KuCahUrvYFcqZz6FCHfI6j3OW/3pVwilF7XrzDXFtcZYmxJc3o3q/Ha3d4Bfk4WFenviDMWLWnxiZJLs4yPjmWBXTqfgUHIiWf9wXuBDPaV83EK8GdOU2P934TF4kyMhqpcoPUV6+/8osI174EUWpjC0jr09RhknOOzo1o0cMMoNdy6g0ncvuFNi52r5rLteInXMKqW0A1DlO/sn/Fi+nIT7TkJXVs+0KR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxtKlXzrr9VP3cvoAF4qvVVXlvr1wzfxeU6chbS0m9w=;
 b=yVFUDwdVuPPO5UmIteCmTX9htX+vtA5BlXEgo83OkKSnmk0lh4ioDs5VjpqL6MLYhEkAuvIU+pNLXxvlL3hc9wr6N3/w2v7/UmjXNgJwUKd6KCzdA9V1Es2F9AaFlTiVaMQLbDwqYiyEGoDI8sewaBtM+89fW6+dq+q6enAeoVY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB6998.namprd10.prod.outlook.com (2603:10b6:806:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 13:41:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 13:41:21 +0000
Message-ID: <2be32654-242b-4c4c-b909-9058767b1b53@oracle.com>
Date: Fri, 5 Sep 2025 09:41:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] NFSD: Disallow layoutget during grace period
From: Chuck Lever <chuck.lever@oracle.com>
To: Sergey Bashirov <sergeybashirov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250903193438.62613-1-sergeybashirov@gmail.com>
 <503ab8d0-d4df-488c-8513-abc128624d59@oracle.com>
Content-Language: en-US
In-Reply-To: <503ab8d0-d4df-488c-8513-abc128624d59@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA3PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5196c5-3c89-457f-3bbc-08ddec81e5f7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aWkxM1ZHWUt6V3hWc0J0ZWFMWkRhT3FWQU96c2x1R3l6OUF5VmtwYmRmbDdY?=
 =?utf-8?B?aC9leFE4UEI5V094bEZFakorNWtqQ3lCVEtOZ0VqMm9PVVQ2SkhSUHZQQkMy?=
 =?utf-8?B?MzlqSUdEd1lTWUdoTGFKMTR3QVV6aDZiNEZWUFN6VTEvS0xpQTl5eWFsSmpX?=
 =?utf-8?B?OHNERDMxOXd3WFdUcVUwRDFvUkthVFZYWjN2N3VGSENNekhJU05GcFh4SVNG?=
 =?utf-8?B?NXljbUhMU2JtNXRiVFRITkZFMTZHWXo4emI5WXN6S280MUNzc0Q5QVVGR2s2?=
 =?utf-8?B?MjJrZkZORUdMRkRFOTBXWWpPMWJ2MDBJakZRbGFWUzhFbHVwMFE1OXJPbzFQ?=
 =?utf-8?B?SU80S0xRRFZoMCtTcTN4NHMyU2VOTkR6SGhwUUs2R1RTZDUyQVNXUytMNHh5?=
 =?utf-8?B?OHMyazVWZmJ0WkMyNnJCa25tNlJWZThxRnYxUTM4VDFqWW8vM2poUjc5alpW?=
 =?utf-8?B?OWI4OUVXQlE4VGFyRDhYU0hYbmRKbnRqSktjbC9TTWN4cnhVTVFEdC9WVkht?=
 =?utf-8?B?QlBpMHg2YnNsczVnV2V0OXZmV2VsTDZKQXQ1RXRyK3dKeTBkNGt0UDdlNVoz?=
 =?utf-8?B?ayswNmJkSTVTQmpUeFA3TDlLZWpxdzlFRmVhZmxKZFZ1ZTNUT0ZRNTJpRHgv?=
 =?utf-8?B?b2lpZlRocFJxTGkzWllJVmJ1NlZSN1lwdHRCdHh4ZFRlZGdGbUxmYllveFBi?=
 =?utf-8?B?Y0JsNWFHUmF3eXBqNEJ0MTJXWHdJclN0T2tmeEFRTjczK2U5c3VNMzRkMUJ4?=
 =?utf-8?B?amNCbmVzc3ZEeFVtVTVYSEJWS0ZZZXlMaGc2a1NqZnhEMnE1dHBXdis4dEU1?=
 =?utf-8?B?aGIxVjQyL1RyQkJZMmxIbk5namhGOXM4WDhUU1Z0NVJxb1duUEtHSEFpOXVi?=
 =?utf-8?B?TEhveWZEQUNMUm8rbnVmN3pucU16MGRUVDBiOC8xcEdpU2E5N2lTYVRXK0xW?=
 =?utf-8?B?R2F2UkhyN0l4c2NERHYyc3YrM3Jad2hZQitjby9YVnZTOS9Vb0RpamllNjNB?=
 =?utf-8?B?UG1DZGoreUVDVFhoZHZQenNQVWVDN2M1c3p6bG4reFFweElUZ0dQVDZ2T0ZU?=
 =?utf-8?B?R0swNXpBTUJxYktPSHIzLytPd3loLzVZaVhFRmphR2hmNlBCakt1OWxrZkZ6?=
 =?utf-8?B?TlVJOGVDZk1yZnZLL2NkUExRejh0M1ptbytnMUMyZTVCazZETnMwZFJ1Vzdx?=
 =?utf-8?B?TjZITGFZNm9rTWI4R2hreTBHYTBoZ0ZpVWsyOEFlNmROY0FzUGt3R1BBRHFj?=
 =?utf-8?B?VUNTVXZrckRTQVNXV0ZKc2p5T3FRc2c1ZFdRbEc3cHBpNHVyV2kyanFJbjBY?=
 =?utf-8?B?NmtaRktGNXdyZThINFI5bFJGUDdQb21IQWpHclZWd3dtVllCenlwMi9BUnhI?=
 =?utf-8?B?aHprc29VSFJyOGdwd3VNVnF3TWNVOC9pc0RhNWpQYmpLR25KZzlmK2Z3MUh0?=
 =?utf-8?B?MVRSaHdidTQyaER3aG1tRmI0T1ZHWHl6RXlZaXdQY1U1OUo2R0h6TEpSOXRW?=
 =?utf-8?B?TDFJWDJSRHVyM2xnVjl6S0M2R1ZKZ01scno2T0lZMTR0d1lYdjhXcTBiZ0do?=
 =?utf-8?B?RjQzNHl3eVJPMnZrOUVndjgyaXZCQmV1aGFIUmp5cklkRlFUMUZaQXVFTGdS?=
 =?utf-8?B?QmtPSk5OcG1pRFY4dGI1OWhUa29XUU9VL2Q0OWRpMWJ6cE1IT28zNzlPRG90?=
 =?utf-8?B?enc5SGozM1FHUUVZUzNTRjdyYXFnV3pBcUppN1BBQ3R4aDBxL2wxc1RqM29k?=
 =?utf-8?B?RFdTKy9qc2RRTTVGa1I0UlFycWpaUmhSM1RHaGR5WnlMNXdlNDE3T0x3Tkoy?=
 =?utf-8?B?ZWRBd3NRb0NpOWtpSy9NcEVmMFRTaWtvRlgzUVJKYkZrODZ6aXYwbFBia214?=
 =?utf-8?B?QjhQalpjSDF2Q2dIelNrMnE3Y0R5RXVRanlJSll6V3M5YkE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RHZiYmdJbVg0QXJ0QmtlTHdHS3J0TGlmeUV2QWRpZkRMN2N3ODFXV0xWYzBM?=
 =?utf-8?B?a2U1LzRmWlUvNkNTQ1ZtSWJHbzg4aHl1SzQwb3F4dU9TRkNlMVI4QkJ1cEdF?=
 =?utf-8?B?UUFPTDI0NzYwMVgveVczOWhWS0NvM3Z0bFVzNi9MaE5UbmNXMnVidlhiUk5K?=
 =?utf-8?B?RmMvQlVOL0dmdTA0TU1oQ3BvYWV4WExPa1V2MXVEQ2pQVFJXQm9NT2hYUmUr?=
 =?utf-8?B?VDUvQytNV0dTSVNPQ3dSZ3k4VVh3RG5ra2dWalB4ckliQ1Nzck0xWnlEejNn?=
 =?utf-8?B?eTlFR1l2SzJ1SWdicXhQUnJDYnA1V1RuaWtEU1NEVDRFbHNNeG9lTk8rdE1z?=
 =?utf-8?B?MVc0aGhjQWN4a3JnbFYzeG92MXBlNW9wdEQ5UEcvUm9ZcWpZTEhOTXAwa29D?=
 =?utf-8?B?bER3Q0tZTkcwQmkvT0N1YmpXQ2lzNzBvblZ0dGZ5bWZMNXdKVkNyUFRyZnIz?=
 =?utf-8?B?ZGVCR1IwVjhiNTE1K1pVdGVXNmlvU1l3TmoxTjM0QjlJS05kMUdsSkxvQTBh?=
 =?utf-8?B?c3NoVzRVbWF5eHhUajFzQlpYeEdXLzBPZVZINEFORXMzVDBtRzg0VGpMSE4y?=
 =?utf-8?B?QzBRbmNLMEpVQVFncTRveDdYejJtQjZaZnZVeGFFd1lZdVRBT1JqWXRTNDh3?=
 =?utf-8?B?RFpCKy8zSTNPTlNMa3lFU2pTNlprczdqRUkxMkg1ek5xSGx3MEY5b2drWmZv?=
 =?utf-8?B?WElSNno5TlFUMXhHVE5EQzVLZkRCMEVOSEUzMzJpS3VCV0V1ZXErRXpvbDJK?=
 =?utf-8?B?Q0dIZXpMeDl1WCtuRVJ6aTBMRjB6MGFaVWM5VlJ4SVVDQ1BNYS9DK1gxVEVS?=
 =?utf-8?B?bWpLdkdMNWo2RTN2UFE2UUd1WDBGVWVFbCs1N01lRWFadmFYMThEZWZJcFQ4?=
 =?utf-8?B?OFFob2pqcjVQM2Z0d3MyUEd2eDF5eVVXRitNYU9iVTRxMVcvTFZneVA0YnhF?=
 =?utf-8?B?aXdsbzlsQmpNM0ptRVdwS2xUaDBNbm0wMzBwQ1hCTFdJaDFEcFJGWE00VW1p?=
 =?utf-8?B?RG1uVFhPN2ppNFVpa3RZdGhMTW5OQUs5cnBsQVhOMEplbnB2OFliYmVzSnlE?=
 =?utf-8?B?QVEva3ZSOXo1QURhSGtmNWZJSWFPUytkdEM5OGxFL1l2UGhTUG1ETk8vU09S?=
 =?utf-8?B?TElGMzBMZVBUaHBGM215bXJXdG9NNFowMTk5blo2a21wN0VVbnZWMTFUVGQx?=
 =?utf-8?B?MVRmU0xVdjRIdmtZbUd2dDBIT2d1VHpWTUcyS0JmMVlxTVdhRS9tRHRzQTlN?=
 =?utf-8?B?dC9UQmNsMEM4UFNOY3owTXZPd1pWcHZxK1hGU1hYTTQvbXNud0M3YlJJa01h?=
 =?utf-8?B?djNYUndsNEZzT2ZrL1UzSzZxKzFsV1BwTTlwRnludzMyTkd0cXJOelc2dUtD?=
 =?utf-8?B?VU01Y0NBZHR0N2pVRFhpRnhmZTdyY1JvRzRZaGQvcE1HcXcvdGFxNUVxTlR4?=
 =?utf-8?B?SWpTcUZiUnRDUFcyVzB2RmE2Z0FJUk1xUEtlMmFSektEOHFVUHJUSW5LWjM5?=
 =?utf-8?B?MnY2ZG43UkdRTXdvSnY0QmZiYkFQT3VLQUJPMzBIMGRpN1B1RVRpdkZTUFBW?=
 =?utf-8?B?ZFZtUFJkWGQzMDRNSXJTQlZXcEsrZmpzdEF4enQzaEo2a0VvRFRUb0w4UHF0?=
 =?utf-8?B?MFR4bndCaVphWnNUWm1LaUF5U21GM05ZSWtlK3pTRTR0UjFNL0NtRzFkNVVr?=
 =?utf-8?B?NHYyY1hVZ2dMdzlpRjhtNUpIdGN5WmdXSWVMSjhGWFcrSm5uWThUWGdUZWlq?=
 =?utf-8?B?Nk5hWTJoL3J3Q0RRWFQ2dm5XU29YMENQTWNXQUx3empJd1FhMjZ0NVE0c1Y3?=
 =?utf-8?B?REZBejBsVVRTSjY0T0FuMzVzM00xUkFrY2NmSDUwSXhMQS9STHhvblZLbzlQ?=
 =?utf-8?B?eGV4eFlLNForWFkydGIwcGdvemx6eTZlRi9vS1gvWXhtRFZlQU93SmtGRk1x?=
 =?utf-8?B?YkQvWDUvMTVXMUhCQ1lQQnJOalYwS0xlNEtqT1NHME95UFcwKzZ1MmZDeGxO?=
 =?utf-8?B?eUZpbVpqdWNVa1RTZGJ6MkkrcU1YbVNlSjZ4a3IzU3JIWDV5NVVLUjN4d2Nq?=
 =?utf-8?B?NVBWdWFZZWtoYW1pNE9DSE9nWnk1SWZxOVFTSy81Sm9NYjlDUnhZOU1nS290?=
 =?utf-8?Q?XSLWwv4AyC2W+wocO5QtmHDln?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tpTyo9cPOeQlBSF9uazIsJXKN4CM+5ACs3GKxGGS7nmQQQ0KUD+QMmMGO6v2fhKuDIiDEnvgO5zqxIUAbImVBw1+nNa2Xt3398jseLaARKUkZ5To+R/y6M7pHbsrmNHN/7dFaoeOehLuLA/srI885lTCbV/q03cGp8it8cVgJg+gHu/FijOjah4iIhA9DfyUv3T1J4M2aPLZUJovaEfprnC6Jrq0hd0wt21HfhXj4wyBFSMack7ei6746U8bbGHaTUTiRUpdmp878hJFzF0xKUr03F+xAccktpONv5JDxrVeZg148Y89AU7EbvvqiITAl+1cQ3/udvS2F6o0aNLEAzwmstyt9u1gq8WztFVTnhW4DJqhcSSPXvYtBp2Kgvagt+0VbXrQ5YdJ0W0D9B3qlAWCTFdfUbbuS50u7V+WeOsijco/gtThe+9WZ2M5BVQ3HuUqwy1UE1UcY4nhzDjR1OV29ZjQAlm1dQ4ZV2DQ8knuanARnNF36V1DFl37/jrobBDRwhS5u1+wOO6T+u30fP9fckF8GAACnj3MgD0FhIo4N1cGMizlvPg63eq3ecqwJNRrmggm0aJ5l7EsX7P40vr8BeCsyGOYKwD2oXpmZh0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5196c5-3c89-457f-3bbc-08ddec81e5f7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 13:41:21.3787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lxNdGofxuFIowZUA5+IO2eEH339ChrH7JNNTwwG2OTyLxzP7scU0dzvshPOVeFejk6Hkrpk8FkoR6WcXrmVEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509050134
X-Proofpoint-GUID: Fg3ccoE6w4En73yNe6WMBBcZsFvchhrn
X-Proofpoint-ORIG-GUID: Fg3ccoE6w4En73yNe6WMBBcZsFvchhrn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEyOSBTYWx0ZWRfX71s8Ti4tevl6
 B7QG0jLH75g3zTNnPPv747mBZsrVmh89lkoRx9LqGZn/WE9KVcYFPuYBAlB5iYzHQZGk9hB/0Kt
 y1PUBsea4nYb036X/eYKhhLbAWu4Z0AOhQaxQQBH3IvrsCwtDEmZOFLXg2J4jDLAPtf3bkmYvnw
 KyGSlIFkVcc2K/3BuUHtXhSc41Tls1aZrrFOlW/AkWzPeIrvbUyv08BgBViXMFcK0wUxjVeI2A7
 E/5Am+dSjHjiS/4a8QDU7QhRZllwyrMud6xMFQD2x+Va0/mLxHXiI8Gnec/0FCccWPrwRFenpne
 tOXjxwld1iBsUbddbhHfUb/zpropMyZI9GoTqNsMk7H0vecike2asIhaV+xBb7Ivx721iTxG+2b
 iniIbJzAR5u9OeBeWkYyARw+rnxZIQ==
X-Authority-Analysis: v=2.4 cv=L4cdQ/T8 c=1 sm=1 tr=0 ts=68bae885 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=BMxJXzqDAAAA:8 a=pGLkceISAAAA:8
 a=A3ntX2QwQT0OuX_0OPUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068

On 9/4/25 11:54 AM, Chuck Lever wrote:
> On 9/3/25 3:34 PM, Sergey Bashirov wrote:
>> When the block/scsi layout server is recovering from a reboot and is in a
>> grace period, any operation that may result in deletion or reallocation of
>> block extents should not be allowed. See RFC 8881, section 18.43.3.
>>
>> If multiple clients write data to the same file, rebooting the server
>> during writing can result in the file corruption. Observed this behavior
>> while testing pNFS block volume setup.
>>
>> Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
>> Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
>> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
>> ---
>> Changes in v2:
>>  - Push down the check to layout driver level
>>
>>  fs/nfsd/blocklayout.c    | 8 +++++++-
>>  fs/nfsd/flexfilelayout.c | 2 +-
>>  fs/nfsd/nfs4proc.c       | 3 ++-
>>  fs/nfsd/pnfs.h           | 2 +-
>>  4 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index 0822d8a119c6..1fbc5bbde07f 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -19,7 +19,7 @@
>>  
>>  static __be32
>>  nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
>> -		struct nfsd4_layoutget *args)
>> +		struct nfsd4_layoutget *args, bool in_grace)
>>  {
>>  	struct nfsd4_layout_seg *seg = &args->lg_seg;
>>  	struct super_block *sb = inode->i_sb;
>> @@ -34,6 +34,9 @@ nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
>>  		goto out_layoutunavailable;
>>  	}
>>  
>> +	if (in_grace)
>> +		goto out_grace;
> 
> Taste/style nit:
> 
> I prefer that the controlling svc_rqst is passed to ->proc_layoutget,
> rather than passing a boolean. The ff layout can just ignore that
> new parameter, and the block layout can deref the network namespace and
> do the locks_in_grace check.

Never mind. I will take v2 as is and fix this up myself.


>> +
>>  	/*
>>  	 * Some clients barf on non-zero block numbers for NONE or INVALID
>>  	 * layouts, so make sure to zero the whole structure.
>> @@ -111,6 +114,9 @@ nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
>>  out_layoutunavailable:
>>  	seg->length = 0;
>>  	return nfserr_layoutunavailable;
>> +out_grace:
>> +	seg->length = 0;
>> +	return nfserr_grace;
>>  }
>>  
>>  static __be32
>> diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
>> index 3ca5304440ff..274a1e9bb596 100644
>> --- a/fs/nfsd/flexfilelayout.c
>> +++ b/fs/nfsd/flexfilelayout.c
>> @@ -21,7 +21,7 @@
>>  
>>  static __be32
>>  nfsd4_ff_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
>> -		struct nfsd4_layoutget *args)
>> +		struct nfsd4_layoutget *args, bool in_grace)
>>  {
>>  	struct nfsd4_layout_seg *seg = &args->lg_seg;
>>  	u32 device_generation = 0;
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index d7c58aa64f06..5d1d343a4e23 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -2435,6 +2435,7 @@ static __be32
>>  nfsd4_layoutget(struct svc_rqst *rqstp,
>>  		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
>>  {
>> +	struct net *net = SVC_NET(rqstp);
>>  	struct nfsd4_layoutget *lgp = &u->layoutget;
>>  	struct svc_fh *current_fh = &cstate->current_fh;
>>  	const struct nfsd4_layout_ops *ops;
>> @@ -2498,7 +2499,7 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
>>  		goto out_put_stid;
>>  
>>  	nfserr = ops->proc_layoutget(d_inode(current_fh->fh_dentry),
>> -				     current_fh, lgp);
>> +				     current_fh, lgp, locks_in_grace(net));
>>  	if (nfserr)
>>  		goto out_put_stid;
>>  
>> diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
>> index dfd411d1f363..61c2528ef077 100644
>> --- a/fs/nfsd/pnfs.h
>> +++ b/fs/nfsd/pnfs.h
>> @@ -30,7 +30,7 @@ struct nfsd4_layout_ops {
>>  			const struct nfsd4_getdeviceinfo *gdevp);
>>  
>>  	__be32 (*proc_layoutget)(struct inode *, const struct svc_fh *fhp,
>> -			struct nfsd4_layoutget *lgp);
>> +			struct nfsd4_layoutget *lgp, bool in_grace);
>>  	__be32 (*encode_layoutget)(struct xdr_stream *xdr,
>>  			const struct nfsd4_layoutget *lgp);
>>  
> 
> 


-- 
Chuck Lever

