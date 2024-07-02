Return-Path: <linux-nfs+bounces-4558-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343E39243FF
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66541F23FEF
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3901BC06B;
	Tue,  2 Jul 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eMxZmnLw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uIRKbFmb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCD51BD50A
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939321; cv=fail; b=dm0FMbRvxib1zQtRUFrjkeOuxxxPM9CtYSWFLAdROLfVHfqYjGGt6bl7HHtzuiqbvQ3n1dsaZA3P1ksjgftIF3bDhk7N5vVVWWvZ/3C59eOQDf272z/d8K6/EDFZYSFZHvJ0e52rIIaqU1o+wp3lTYCnpeo9aRprGdt4mv1rt+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939321; c=relaxed/simple;
	bh=d8d102SIn/sCvuBUDm76yELogv++OON9igM70qnlFbw=;
	h=Message-ID:Date:Cc:From:To:Subject:Content-Type:MIME-Version; b=Pa2tM4491fq6mb7CA4ZFCLn+CJOh1A/wJBvxDyFAgRMNqebEOEciJCkiUawbG9qdgzsmAnOHitUA4jcJJMQ7eyY2Rt0vK+48npTk5xV7hAFqNG4dWbVQWbclL2PoGILLlcfxpZ7Fyrzu+WWE6niAPunwozVNtGf+1x7ap1wE9Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eMxZmnLw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uIRKbFmb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462FMU2k025337;
	Tue, 2 Jul 2024 16:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:cc:from:to:subject:content-type
	:content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=M
	pyWizhK1G9vPd5NnHkM3mNkWb42s8rkbO2JXaP7+C0=; b=eMxZmnLwBMWBE8KwO
	6F/BhLV4ci4KrmYklOGdWm+3con8P7Xhi+oiKWhaeNUk0ZMOj8Aajj901hJsQPRd
	VCMm+M3SJekM0E27Gq0FfLZT/Ik9dg9oAezDti73BTtYX98fHLkVGveOg+nAn8jx
	h4TmrPf4LxDuFO4aLL6GgCuZZ2gf6YtA2+1KZaRmXmZ2AdXEQ6rgFXckqejaBP6O
	vwqyNBp5eYFKyGJY8MAZAcMrxk9U0kQtACl0d2O+6x+HrEyMEpDREVcHbOeGGWNn
	99s2+ina7Nyr3TJLIku68WBvVMfq6cNAsa8cS5GBN5tdqXH0bt5ETWOrv9BeWtri
	wdc7w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0pdp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 16:55:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 462GMMDK023479;
	Tue, 2 Jul 2024 16:54:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n0y1bwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 16:54:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs8G3iAsXewQUyLS+H9M+P+Ddu3HlTZNadAFAfZLa0bkGhvoxnT+I/i6JzTWO1lh/+8POQRB+E+0hsbmT7OCtvhTGyqo41XlIYNf7G1x+2CaY4qtk2sCb1T6knrup5QnhKTYTJPYJcRu5iNTWzZysCSZmrhNpVIhiarybN6bfcr2JOwBQqxd0wuTSHK5GeNl9uoran/ndIk/luQjdFHST/289Qgx4od8GzvkALa+3m+9OXiSLlo02FEYwnyfTBj3ue0DGfHh3qkOBL5DaPERX1KaqQ0bnjPM66ljmHpiB1npqmgLdF/PpqmEASlbY7IcXzo0SuJnw5SYdtYcddDOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpyWizhK1G9vPd5NnHkM3mNkWb42s8rkbO2JXaP7+C0=;
 b=g5rCsR6Pte4MO9hq92QSIwIKGUcAp162eXOHkp93CRqrV5UQTD1u6ISdg+FMecSiUsV/a1ZfMbKgf9rjqt0TDNBAEU45cywlORbuvc6hk2j4dO9/dkvcEc3HpOUEfFRrPHq/6rxGUn0Z64kSmPes3p2/XmK+Dj3n2kKTtthKUPap7T7kv1cVSXATzjqyXiUrC6iNeyujjuqz4g4DD4b/tmUw3jo2ZRa3NYfqNwbxpcwhtJUTxWxT1Bgtq/P46KtJvuZFM0Bx0IDfL79oR4Uwhzr9yueT8WBiTpugXDarTLtCrb5XCz7AzN3bEq5l6eyqwXVq4GxJGoK5w8PO7chCEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpyWizhK1G9vPd5NnHkM3mNkWb42s8rkbO2JXaP7+C0=;
 b=uIRKbFmb5D4CecWevIcG78t8+ZYeIqnM924H6CKV8ige0x+2M1pLmRKOb6hVNCMyDzWOlKcHB6qGcuPJPOe2PDr7JZhXpmWaAxgjrSA5q6V/pKrhGpCmBuubyVPKwv26+Y4EWXq8DKf3T4u5xPd8gbXVxXIbX8N1IfGUs5Mnv0Y=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by IA0PR10MB7255.namprd10.prod.outlook.com (2603:10b6:208:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 16:54:57 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 16:54:57 +0000
Message-ID: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
Date: Tue, 2 Jul 2024 17:54:49 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>, anna@kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>, kernel-team@fb.com,
        ltp@lists.linux.it, Avinesh Kumar <akumar@suse.de>,
        NeilBrown
 <neilb@suse.de>, Sherry Yang <sherry.yang@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
To: Petr Vorel <pvorel@suse.cz>
Subject: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel 6.9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0692.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::15) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|IA0PR10MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3bc77d-e313-4cb7-4495-08dc9ab7b427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NUFrajJQOU1kckdhVkpBVjVrd0dWYzhWUHYzVWp0dGhpTktXaHR1dklKWW5C?=
 =?utf-8?B?UGx2RWkwVC8weXQ4MkMxTnlPK0twOFZBRnlERzdHaTlYUXNkd1MzTGxnWWNl?=
 =?utf-8?B?MjNQdkxmUVVMNkJaZ210Q0JDV1grdjhEYUN3S2FCSEhlQjEzNGxlZ2MyUFVQ?=
 =?utf-8?B?NjFNSGI3eE9LSEUxcmRFUmQ0bWVKWEtLUERLbUV2RHEzajRXTmpSdy9GdXB5?=
 =?utf-8?B?Mis1QXVyMjFUbThlT3owSHR3QWU0TitIck1BUEh6dW82aWlYbGZiUjJ2WkxD?=
 =?utf-8?B?anhWSHFwVlM0US9KNWpjWmprYzN2RDBPMVUzNDhyOTFQR2JYM09GZ3JkVHU2?=
 =?utf-8?B?ZGVYaXFPUk91QStUZnNmZXNHVHh4SzVCWmo0SGw0U0tjcnZFaEprSW5TbEgz?=
 =?utf-8?B?R2JTdFN1L1BrNkdGNEpYMUJad2xVRGE2L1hnK3k5cnR0bDVhRExnL0lCbTZJ?=
 =?utf-8?B?MmV2bHQ4Q3crdUJiZ0NaTElZMjVnY2dKWXE1QkY2cHl6Q21LUnJaQmhSQ2JE?=
 =?utf-8?B?M3hJbmxVekxRWENWb2J5cUxOZ1lvcGRxbFNDMTdWWnhhWlJ3UWROZy9Zdjdx?=
 =?utf-8?B?bTc3YjBXZHdMSG5kZlZDZGQ0SVpYUFdUWEs4OU1ZRGUyY1FEcVl1NXZjZlk2?=
 =?utf-8?B?RDB1c1ZrdnRmODNHYllPQ01nZ1pnYkNKUkh1R0c5QSt3Vmpkb1ZyZXVpWW9R?=
 =?utf-8?B?Z01waWhibTJBNFphalpCZlUzTGorWXViNG1hZmNaaWNUdDd2NW8yeVhaSXdW?=
 =?utf-8?B?RjcvSVg4K3RUbDlYNzhZVDArSXd2aXNtQzIyYnJ2c29JVTBDR1NzRFhveGRv?=
 =?utf-8?B?WHpySUljeUNPMXFjNkU5Qm8yZVNhYWx6dnRHWXloRGRnb1ZZeStIc3E1YlBl?=
 =?utf-8?B?SWVORmVZM2plS1pONldTSzF3V2hIUnF6S0dWNUZOekRxYy95OFY3d21hTi9T?=
 =?utf-8?B?MVlvQ0huVTVmWGZva3ZMd1ZKeFNYQXhTVk1xWFZuc1R5SFRlYVR6YStDNVg5?=
 =?utf-8?B?dHc5OWowc2JDMjBVV2E2a0NTVWVpQi9Yb0dYTlB6VE9TdmI3eFRXVjRDdmxL?=
 =?utf-8?B?QjU2a3FjSkIvM0dtMGJaMHhqN3ZLOVNkaXFtOTJrVWl1R1V3L3NZVWp2S3Y1?=
 =?utf-8?B?UkU0Q203bUYzMzBMTWtXdmpZaFZ4V3JFZ1RlL01DVnAwcCtlUzhBcU55NHI2?=
 =?utf-8?B?N1JBcmpCNlk4N21ZVHRNV3VoOXN5dFR4Y1NUaDV5RVZKdGRYb2JWMHc3a0s0?=
 =?utf-8?B?MCtwRVF4UktCUzd1WmV2V3JDckwrYmpVeVdEUFZtZjlKUExqQ2xOckZPbzJu?=
 =?utf-8?B?UUdUMFhMYlBVYkJnVWpyVGptZ1R5QkhBakw2K0plVHBMR3owcjErMHdQUUV4?=
 =?utf-8?B?NzNaNWNhR3VpV2I4UjVzL243Qk1mTnlqck9aNXdmL1dLaDJDV2JyQzg3QTND?=
 =?utf-8?B?b1ExTlRsZW0xUndpRnF4TEhLSC91K3ExcWFWMGMwd2U2M1BPMDNpRWp3ZWZR?=
 =?utf-8?B?UkVhcUVtTHRscVZkWG9WNjdVQVdNelhyM1pTanpDK3J3d2NkMTVPSWN2WjhF?=
 =?utf-8?B?UDZLWW1mdlF5OFFCNWVsbzluTGxoR1pwNVlCVVhEVGVocjJIVlJ6U1BLOVM0?=
 =?utf-8?B?VXBFbGJoY25tVEkyQXA0RVV2RHBjdldpN1UwT0lJM1Z0SGhBeUluUW5la2R3?=
 =?utf-8?B?L3ZBWW16ZWxTTHBGNEZMZU1OSDAyWnJnRFRlcHcvK0crTVhmOWIrek42NnJB?=
 =?utf-8?Q?S2yW+nlppHSCJp0NqM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cnZ2S1dkeWhFcENzWUEwQVhqWHF5QldFUHFNdXJ1TlpaOEVYSlBxTVpIc1Ro?=
 =?utf-8?B?MCtLN3JqaDZyeDZnVlZsaThOOUNUMDFHL1lyV3lER0RxZWdjTUZEWHBJcXd0?=
 =?utf-8?B?QkJSaUd0WnpscEFDQ1BzY1FBTWxtZ1dNd1l4QkxQME1kbHdlOTRBZnQ5Mi82?=
 =?utf-8?B?R2FjRWVvZUtxMFc0L0VTL0QxeEhLVHYvbWN5UWc3NlJGZlIrN3huc3ljRGVZ?=
 =?utf-8?B?a3pnb2I3d1Rua201VTZ3MVRUdHhWUGpkSzE1VXpidDcxQXF2alNmOWE1MHdj?=
 =?utf-8?B?VXNwRjJkcVRuYzVDMkVVMkQ2MDJnQmpHNFhHcFp4RDNmY2ZjUFIyUk1PczFn?=
 =?utf-8?B?WTJSRzh3alB0VlBPd0l5OWhqM3RyY0Z6MWRha0xuTDVtQXh4ZmNNMnlyR2ZD?=
 =?utf-8?B?SHlITlRhL1JYRXArckQyODhLbktteVgwL0Nzdms4alIwTEFMTUxDdmF5c2x3?=
 =?utf-8?B?d1lrYWRxVmRMcUZDWmVlSEdVYnl6a0IvbURXcElFZlJ5ZDZQZXkrSHYwdXlJ?=
 =?utf-8?B?MS9TMUVMMEFnRnFSUVdmSjJaQlR0Rm5MTXVNOC9hM1NYT1dMR3pZTm5TV0JZ?=
 =?utf-8?B?bWtaekVicFlKOW5ZUlpucHp1cXFnTC85dkVnNDBueFdIeUdsQ21pWGxPT2tV?=
 =?utf-8?B?SXBLbGNGbkZtR2NocVI0TUY2VmhXc0ZLRkQzcFYwdUt0RDBDMDA3TWxwaXVI?=
 =?utf-8?B?STlxdXZ5WkUzQUpSZXZ5NnRpRjNTMnhjMkNXL2FDSitjVUJPZ0pycGNpVWFU?=
 =?utf-8?B?enZHTi9EY0ZuL2s1ZzgvdDNIVXUvTnNmMzVPOWlGM1FOait2Z1NZam5LRlB1?=
 =?utf-8?B?QVNIRTVFellaLzBTekdjUENlRVlZUFRqVGxGbmxJM1pJb0lyYVhYVVlJc0Rn?=
 =?utf-8?B?VUpEYTlOVHN6NXpyWE16VW5nSE11eThTcjRtbEJDZEFYeFp1QjN5Yjk1czEz?=
 =?utf-8?B?aG9qOEEva2NKVzZ2OXVqNWEwVmR2ZlJjRkNPWUtmMXZpRDlvaDRmZVgyejUy?=
 =?utf-8?B?dFNyUGN2NFVCYWhqaXVOMkJ6Y1JleEJ0ejlWb1JXUDBPT0JpTzlHQVBQSjVQ?=
 =?utf-8?B?ZlNmYlBJbGJ4MnBPY2phTVN3NmZBd1pWalBuRUJwZG1ML1ZiT0lScm44R3JW?=
 =?utf-8?B?RzFNZkZ2R0wzNVhtTkZ3bFgzeDhLc21kMzVTNXc2ZTh3QVEySHRoNEE2UUdn?=
 =?utf-8?B?czZyM2xBZ0VONzNtVlpCQlZaYVRIRHdhS2o0bmQrQkRydlpqa0M3eVdkTnFp?=
 =?utf-8?B?cjEvOVpxSktlYmJCbXlSTGRPOFlHcDF3L3FEb085em9PbmhDcWIweDR0cGJu?=
 =?utf-8?B?emRFSXhySWIzWkVhU3Z1MitLSFNFci9EM3RPOW9qUnZtbEI3RVBMcE5qT2Zj?=
 =?utf-8?B?bzZHUmRITFY2NTczaS92M21iMUsyTHlSalRNY1ZzZ0tidWxpQXZhWFJWeWtk?=
 =?utf-8?B?b055ck9FaHFqeHRHZjRhcDlmR0pta2tTK2pzM1VacjJGNzZVK3FoeHlSQjh3?=
 =?utf-8?B?T2p5bUU2eUVPbEtUbkF6bjJGVk5RTVZLU1RRQnpoeFllZDNVb2lXYzRkMjJ6?=
 =?utf-8?B?YlVCcUNNZnB0dnA5dmtjd0cxWFU0OXRqYXNpdVJyaHpyaWlhRVFpdGZBZHlS?=
 =?utf-8?B?cW80WjFDN2lqWDdNM2M3aVZraVVNcEdCUlBZVlovd2lSQVNjQkFBUkdIdXBN?=
 =?utf-8?B?SmdBWHB5ZGhURjBGSUhwZmtZV2hTZ1lrV1NKbDMzRE4ya0VmaGlKT3o1bU0v?=
 =?utf-8?B?UVBVVENlWjRiL1VDSmk5T2ZZbXBjdWRpZzVSNlJvTUxXdnZSSXlhbFo0WWlm?=
 =?utf-8?B?WGNHdkI5OVBJTFJsV2p0YWdiMmZrVnAzRStMTkJ3MTgxTjlCbVZ5MzJIUWY0?=
 =?utf-8?B?c0NlVUtnaEhERXRUR2U5SU9mSHV2TGpuTE1ONmJ2RWx3SjFrOTVIS3ZyU1p2?=
 =?utf-8?B?eHAxazl1Z0E2ZXgwZVJNT20vOHVad3JIQTdJMzZ2M3huTVF1NnFVZ3hNMnBk?=
 =?utf-8?B?MEl4aGZmNWpmd01Sckh6MGR6RmluUVRmdmlOc2lYSGU1MXBZa1JaakY2VVBK?=
 =?utf-8?B?SzdocWs4U2pzdU9BdVcvVmJTcDV6dTMvZUJoQUUrMkE0SXdjZGVrQmRqbTAx?=
 =?utf-8?B?M1RBM2dVL05FUDY5MVUrVGMxUXg5NHFaRmcyWUJLVC9OK0JYazRyeDBCNTZu?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PRe0NpqAGyWxQJOILUOFMGVfDTWcW1bLHLdD2XiFDUaKckBd+x91dQBVu889yFxusgaYrc9xjJC5WBfeuWRV0ndW1qVKcjIr8UuuIs41dhoFnh/D99ZbumGhc8/3dCCrsZozTSBvlq6nLqSYHgxEe6Wco8EAr7m6RUM7jXehC0XiXHfEbKRX7fCqSzTRqSf9P4VOcC0oDgRAj66soKLFs3tG4h8WCs6WPDueXMlN3GKcyP+121Mqzc18jZXpCDkeihLyP34RiHbkOBThXPByspXjGTQeSU9LFVZl4mbgf43Z8+jXweGytHnQHsnsoHZ1sl+2bAv8oh/mntjrI+OSXF9GXjR1l9uZPLWuCNq4kC/3WFYQX2bV/uvYHfnAYqsKVmWPsRK5SE022CTJxAMjkHUVltxXUthQViOsrxhwLpH/9P2w0Vi33PKnOcSpfIrD25W4gEX8iw7mCIoFwtvVUxVOK6nilQg/6HXiDMNv1czx24YC5rK4J8KdP79eeOn+7RP16NCo5VK3+ENUOXXGTzAqEvl9TS+iM7tQM65DFPQXwNKE4rgtbE9PQmAl7wd7DvVy5d5qHe4ygYPW1KQBxKrg7BlKgZeSewHl5/SpLTQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3bc77d-e313-4cb7-4495-08dc9ab7b427
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 16:54:57.3874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ef4vznso/iuHJ8o83/8OJRUIncBOsn7yXDk+13abiRky4NLkVnO2aBAU6YhmnzAFo6mH1wB8d6cxtz7gJCDQhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_12,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=933 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407020124
X-Proofpoint-ORIG-GUID: Gn9qwOfHhwsZZr928ideadzgCkZUu1mR
X-Proofpoint-GUID: Gn9qwOfHhwsZZr928ideadzgCkZUu1mR

hi Petr,

I noticed your LTP patch [1][2] which adjusts the nfsstat01 test on v6.9 
kernels, to account for Josef's changes [3], which restrict the NFS/RPC 
stats per-namespace.

I see that Josef's changes were backported, as far back as longterm 
v5.4, so your check for kernel version "6.9" in the test may need to be 
adjusted, if LTP is intended to be run on stable kernels?

best wishes,
calum.


[1] https://lore.kernel.org/ltp/20240620111129.594449-1-pvorel@suse.cz/
[2] 
https://patchwork.ozlabs.org/project/ltp/patch/20240620111129.594449-1-pvorel@suse.cz/
[3] 
https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/

