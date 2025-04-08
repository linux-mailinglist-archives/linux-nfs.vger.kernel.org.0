Return-Path: <linux-nfs+bounces-11040-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D50DA80CA3
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 15:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D6D1895F43
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2388145B24;
	Tue,  8 Apr 2025 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XHY6dr4a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="st3JVpsq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142486358;
	Tue,  8 Apr 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119323; cv=fail; b=ddIdZ/WFQoQdF3KKiMV8Ji1SzFBi3Qe2hEJDQ3PNitykuVrn8pIS8w4Q8v5lKLUxZZ1ASfgBTmbqLJF+G3xBzK3Hig0OVKxsclUvSiUmCU0+CVlgYcoXT4b2mVJwUckz7Mi8nk+e7XKNwyc+BA8KGalIHUyQVv829dH5cmCizbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119323; c=relaxed/simple;
	bh=wQfVidREmcgLjmY70GhWs9tAIxW0512AzCCmdbKW6mo=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=MtDk1WFrxKAypSeMM62NfLGHNV4ZiZBlO5sOmGppU/phE7e+dwj7K7tslGf592CDj31ptXTVymEYg7fnAn/uSfnBUGC+cnhrefGoKVunTpXimJiF4GjMOpKDguJ3nFC3WDJHPHUECMMBdnV7X87SryBVBq9Xc6r24891djlXi7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XHY6dr4a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=st3JVpsq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538C6hMO029669;
	Tue, 8 Apr 2025 13:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=rtMmgNrkN69Qr/US
	E8uDYdII2EHJ5H3EmCnBtGHjZ5A=; b=XHY6dr4a4xcLvf+1CB41YUqojWvRR10X
	UsElulA4QvMErxnb4ggw+01L/ewljlTGy1QhN2ilBwhpOBqMpx8j6wvT2RrKcgtY
	q4+YAY+gitZ46Fhoh89kvDuX5Dt1kwJUnCFhr6+lQyy3IDdmdpO19QvL6fqriz4c
	cYLvCAS2e+VB4fskbIxGV90NV7X+oVAPCWKfIxPCragJ2vdQ6NcMB89o+orRKuqU
	kVkZAQMqmaVGsxfXwrBRXti2nLZ7G2XtJGKb5zUHZY2lH/LWOpDcQJ+avkGNeO9O
	febUXjlbdRCkQXtN75syeBqxTWSGKwf0zAxCau+NSCw5fudglYGmxw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tu41ctf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 13:35:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538ClUCt016239;
	Tue, 8 Apr 2025 13:35:19 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011028.outbound.protection.outlook.com [40.93.13.28])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty99dgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 13:35:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCMJ6JjIyZuDIcU1jS0+KXYPdKeC+dfQXy/P8+zEwgfviiTkhJ47aVME+Z7wS2dn2PbDtYx9ZcZdT128PCT3g8Ztj66tnvhLPXGxsLUHAUfiLMlsEMm45Uy46SC/tZpU/0BcAv1BRq1+7X7UO+1Xl6sQcYthrcS6HXHOccM0mGye8rWJ/BFD+LhvnuVg00Fg4WPqvDtAv4Z5dAaAMCYzEA2Ufdp3QLhX5ljSkOGExC0X5ryzyUCADbTgBuuA9qbPCQeFRKCJXmUGWzYGIPK1fWzrmDDs5+dwFPFYD1BPbDpJhrnn/iKxYu8J27aKCfqwvFY5h4xrqxBAzqabx/LjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtMmgNrkN69Qr/USE8uDYdII2EHJ5H3EmCnBtGHjZ5A=;
 b=riNAaaGr2SMFi3xsSSYHw+/KHUWJ8LSXEO8csW8UXSZBvqqH7yQJ8YujCVCYf8/sA9PJjmV1BprRrG6unaH3y0k9QnGnMkZsNEmyRCNHfYXqnm9c2jjXYgHjU9SsKjoAn8d6i1+3oFCinC3WJpsvEaeewqQ2TkMyKmNsuTbzoAZk2A8FbWqwyPtXyGYs47bHWzWVFIUSoIFa7MQB7Vrc+OUPSdcPvG+JqDQoJOWbQGdODbMLiMBMJKoVGMGUNNdMJ7aaIVshxws10zEpLEXTAs4OvdCdWlmX9SjUcoIfk5LErwOh8L6dJbmlgjDdeB3s0LxdKzi9Ype7OVB/+Yypyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtMmgNrkN69Qr/USE8uDYdII2EHJ5H3EmCnBtGHjZ5A=;
 b=st3JVpsq/l3J+9hp02T8gCP80vnkCQoxQO9yzhK4L2j7EaqsCHmOnhz+zs9Dk8kTAPZoNvv1k37EEjhCgu4/bWdsTiV1WvTtqXnJ69QEXPplwSOtR/rsPonXsAX32p3+u+iVTUzWtj+WPJ9cNmi2zTcgiffULM7ydw/7alNV+iY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA4PR10MB8566.namprd10.prod.outlook.com (2603:10b6:208:568::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 13:35:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 13:35:17 +0000
Message-ID: <5ea93daf-5419-4396-96fe-91249ece26b6@oracle.com>
Date: Tue, 8 Apr 2025 09:35:15 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Rik Theys <rik.theys@gmail.com>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Two NFSD commits for recent LTS kernels
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:610:5b::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA4PR10MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad4bf67-5bbe-4370-07a7-08dd76a23357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDV1OEIyRUtudk9IN1RRL0tNSC9CajdRNlBkV0l3cVVNbWZFSmtuTGNhei9I?=
 =?utf-8?B?TmNFQS8yZW05WHRJTFJkUVJHTElJTTVvaXJEUTROM1hZVDFmNkJISGc3M1B5?=
 =?utf-8?B?L09LY1M3QmwvYlY0R3BmaXBHUUZUWlpyeTQrYUZBOUhFVVZTWkNUZGZuaDJp?=
 =?utf-8?B?YXNTL011OWxNRXN3OUM0eUloSGZKd3VqWnEzNmx3d25INHlXWi9sVDdoWHBH?=
 =?utf-8?B?dkw2VzJaR1N1Q05uN1FRNTRaOFFGYTBPTTV1dXVjN0xkQmkrMEpvemFQTWp3?=
 =?utf-8?B?QnNwcm1YTzM0am45M1BFM0xxalJwUDlYR21aRFlIRnpQQW03YVNQdFVqbEJS?=
 =?utf-8?B?M1JxcVRFMGNJeGRSeW51QVdsUmV6c0I4QTE0eHZlVXpkZFE4Mm5WcWlWR2No?=
 =?utf-8?B?a29WOTdRRkNQUFNDRjFSbm0yMHdVQUd4OTV3b0xEOFlQc1ZtME5VcDVldk1w?=
 =?utf-8?B?b1R0cGwyeS9jRTR5ZWdTRkxNbFRKVm1LTFlPSDNEblQzVTVBTytISFlheEs5?=
 =?utf-8?B?dHlRVjllRGMwbWFCRUtlODVNRXJSM25Eck5VY2NjOE8rY2NKV2Y2VU0xcG1Z?=
 =?utf-8?B?S2YzcVlzNCs1NkVxSGFZWkE0dU5hU0JON29EM0FxeTdROFFteWVGWWg3UDFy?=
 =?utf-8?B?UDQ5VUgyZVl3NlQrTFR6d25Ha3IvdVplaFhzSlYraVUzNDc4RTk1eFo1NlF5?=
 =?utf-8?B?aWhpTWdxY216VjI5TTNNbGliNnlvNUd6YXdPZzZVakQ2cEFIMkxNeTdmbVoz?=
 =?utf-8?B?L0tRcDhtL1orZkxwWUdiM3FBc0JqYW5kQngwN3VxVDdpWXhTUXNSNFRScGtN?=
 =?utf-8?B?cklFM2VkYy9VRzBNQU8vUW5kb1laMXZKTGpoUWJhOHVRTWFhUWF2bCtBTFp6?=
 =?utf-8?B?YWRyTUEwcmlwMi85T1RxVHBKNk1PWGVuMXJyK0ovckt3YTR4WndHY09qSERZ?=
 =?utf-8?B?NXdFb1JUMjdCbDB1N0NLTU5PYmpnSnB1emt4MHlXSnU5akFSWVo3RmhRWWhy?=
 =?utf-8?B?NWNaUHJrZHdsaUtveWZIVTNwKzRxY014SityV0F4cjE5L2dTalJSN0lkMTc0?=
 =?utf-8?B?QmFJdnRtbGpnV05GSHZDTjJTcG5tbGZtREpjVnRPQnplYVdiSjljMElBWnVH?=
 =?utf-8?B?T3JjbXVySHdnUnM5UHg3QjZjRHhLZ1RLUWdJVkdWSjRGMU9QWkswSVNoVSsy?=
 =?utf-8?B?ZGdVZzlBaDhRQVFtNUZFb2Q5VzB5dDB5c2taWnkwQUg3UHFVZ3RKRGd3S3Vq?=
 =?utf-8?B?Nkh0NWN4aHdwZisycjRvOEVhdlVlWURuSDF2WXI0RGYwYW5pTSs5RFhvb0Nz?=
 =?utf-8?B?bnRXNGYzQUJwSXVxUU1vbkVOMU5weFJPWDlBc1pJbENKYXI3N3RZVDlYNWJj?=
 =?utf-8?B?U1huRURla3RJbDFQcE4xTXAzbVdGQ3FZbjB0czVjSmpzemllNWdyTlZjMERU?=
 =?utf-8?B?OHNoeDZUYWJHTXV2ZFNLcHZlZmFUSG5wWjBTbHhCUG1nb3NFczd5TW85K2xm?=
 =?utf-8?B?aElsVGkrY0dKMCtyUTNYOTNXalUrUmxoZVo0cVR5OElhZlprYUQrTi93cERT?=
 =?utf-8?B?eHdhT3h4ODk4YTZVb0FPQjY5eXFPK3ZWOXdMMm1BQ3JFek5FZ0lxdkhWUm5s?=
 =?utf-8?B?ZlFPWUZVMjJ0UWdDUGtSdWRZdGRmVnZUQjB6MTI5bFhlWEQvM3VMSmJvNExE?=
 =?utf-8?B?NmpsOENyQkNLaU0xVXNiNi9ib3hPNVVJdkRlRUtiVmxXcTBuaXlYUkU1eFVV?=
 =?utf-8?B?QmVOZzdVZ1RSdFdSZitvUUlEbGE5RXFsaU1aVElVM0txM1Z3aDhISlhlNVZj?=
 =?utf-8?B?T29lUzNGQUJjUnBTVnZJVWp5WGRkbHVSVHllYUJaTUJKME5xOFRUYjFXcW9O?=
 =?utf-8?B?MnVSRjhPd2o4MWFvaEg3eHZ5RHZIZ0hsL0hhUjNrN2hNWFZxNjc5ZWFKU3hP?=
 =?utf-8?Q?iBpd4r/flQg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFpJRUh2OGpTS2VFSXBpMXpjcU4vNUVzT0k0QUFnYU5lM1FQQjhHNnpuanZa?=
 =?utf-8?B?TVcyUmlsbVlFYkhCQ1J1QlBNWDZZWWNTaDI1dGhDMzZOK3k4bUFKUlNmdTRO?=
 =?utf-8?B?aTRiVkdDTHR5SzREckJKWXlDVFpmbUM3N3RWSEU2SnkwSUtocDgwZzA1a2Zh?=
 =?utf-8?B?U2RqWjkrZ3hadEptdDNIKzZhc2NFQ2pMZ1YzOUFDM3VJeTVzUUpENG1OekNp?=
 =?utf-8?B?WVZoTEtpVURSZ2I0MldqZWxpTGpwOGxxeVJmVUJhcGdSQWI0akZIS1F3ZU5Z?=
 =?utf-8?B?SDJlTXRja2xianB2N1hOd05tZHhNUXRtd0lPMXVuY0tGZXRrVUxWRnpTdTQ1?=
 =?utf-8?B?K25YY0RvMjMrbmJ0b2JyWkUwWldtN2xqNytXcjdBdUIxUHlMcUNCNFhvbGJM?=
 =?utf-8?B?YTBld3VZRjlLZTlCSHYzUi85MTdxQ0tPSFhCSVREUzNTeDlDZUpScEFkd0dy?=
 =?utf-8?B?ZEd6SERQMkljK3NYMm1rQkMyVXlCMzBFSHRUOS90WkRkcmxvcUR5aE1hL3l6?=
 =?utf-8?B?UTFxT200MG1QOWNjSVVxRzc0TVBBaldOOU5QQ0Y3SHFaeTBpYVc0QVJmNnF3?=
 =?utf-8?B?RER2UXdFMU5yd3lkeVZuTVJEUnkwTmVuL21OajlJM2JFV01SSzMxNElMK2lj?=
 =?utf-8?B?WEhQam9DRnJ6K3QxbmZjK25zUGlOMlM3dWNBd3N2VGF2bWlpb2xIQ25GYlNm?=
 =?utf-8?B?WEx2OUJNSCtIc3RhcXVwK1hobEpRVjIrYmR0Q3ZIZmdXVGdWRzZHb2p4RG0x?=
 =?utf-8?B?TW5SY0g2Y1FjREJMQWxoN2V3WXlMNHZ0MEM1WHB4R2ZUei8rRmFmZjBVN0ZQ?=
 =?utf-8?B?c2VlTWZsTlYrNXFycFl4QTRDaFJOT0F0dlhpZDdET3RmSGRma0kzOUk3b0x1?=
 =?utf-8?B?d0JYV1dLYU1rR090QktLenhrbXVOMER4VnlrTXRNa1p6SVdUMitQRU8xYkkv?=
 =?utf-8?B?MmZDb1VFcktxSEwxalBLZnlSc2RaNUpyT1U2MjhhdGxFR0g3L21WN0lwWjRL?=
 =?utf-8?B?SitxaHhkc1lKaGw1TDVkdEFsUU5QTnRXMmF5Mjc1cURTSGxybWcwVjlTK1g0?=
 =?utf-8?B?UlhBS3Z6cmlTMmVHSEdabldEcTBkay9DU1dRYkh0cmo5SnU0b3lCTXJDZE9u?=
 =?utf-8?B?K3pVMk5MT1JyTUFjK2dHbmF6enVSUUNLL1k3NUhlbWQ3U0Y1N0g2Wm4xUSt5?=
 =?utf-8?B?dXpjemN0V1FaSnZROUlrYjZCTGRVNHNHOHdTbFIxMUdjenc5OXBVZFpOdWQr?=
 =?utf-8?B?TGpJeEt6NFNrNHM0SVE4Umpnd05wQlB5UzZDS1FCUXd2UlZKU2QrWEhIaTRm?=
 =?utf-8?B?YWF3c0ZzK1RMeUU5QnMxMitRbUdjWGRKVk00cXpER0RqSnNZb003ZndUaDRw?=
 =?utf-8?B?R2hhaS9hRVhMUHVPc3QwaGYxakY2U2xha3JpOXZIYS9la2NGbU1saVgyN1Aw?=
 =?utf-8?B?YUlIOW96SWdMMXduV010MU9YMGdFY1JDME4zd2tkdWx5Qm5BZDNUdk9PanYy?=
 =?utf-8?B?d0VFMEVLdHJHTjd4a2E0c3FRaDl2TEx5alpHdWVuK2d5KzdOUjlnUm14WWRY?=
 =?utf-8?B?RVpmdDFwbDJleFpsNGNiZ0p0TFZENWpqQ0dOSkFGcVlXZmFDUVZtWnNlbGFx?=
 =?utf-8?B?enhnWW5JUkwzancvcldkRGZwbkw1RVptQVhBbE02ekJkQUJrK2h3eGprLzJq?=
 =?utf-8?B?MEhOR2R0ODVSbEpud0cyQXRzaVBHdkRrVjFFQitxK0wxNk0zaUo5aTZWTmZt?=
 =?utf-8?B?MEZla1VrbUh6SjNLYW9qWldsaWcvZitUZitVanZBWUFWeEgzR0xSY1FYTDNo?=
 =?utf-8?B?US9PcUhQdUY0M1JadDdRc1ZycE9TWXlUK2NKWEtUeWdjSlc0cE13M1ZZeG8v?=
 =?utf-8?B?aXVlc2MxWXgxRTZFVmphb2hjcFpUeDZzNlZWdzFPZnU0MTllbThiRDhDNEcv?=
 =?utf-8?B?WG9MVHRZQUc0VlVDVWRkOTViS2xRamMxQjFlbUlzZlZOVE52MjZCY3JKM1oz?=
 =?utf-8?B?dFg1UUw5WGdzd2o4WjR5cnhkanlhNnpMVWF0UG5uekVTVlErSW00V25WNXN4?=
 =?utf-8?B?TkJuTjdUTjVhMENZT2lpUEFqZXB6T3Z3aEdjL3YyZ0ZHUWtkVldXekhpcnZt?=
 =?utf-8?B?WWlJZ3cyOXpqUCszdFVVRXFBQm1Ya1FIT3VFdjh6dXBVaEFqbDNEL1AxNVZI?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6Axm6aPFhYTIj6SAg6iPvZFRusZl0cFffuyp/JsJfeiWy03h4FhRUIeu1/CLZLmxYtrwKu/3Lm5jaaY0ZnkyaLhQsAVciyUxeDKzDaMWEoRcUAy9mkCZ0c7hoMJ7YvfhcbU8kmzbWJ/VdVh8tWB+AVW1YYxENR8D5AhHj8GgvFxBGPIgoSxOPZr2Z9IcOG7Y3Vaf7zWSixVgDx7KuvzG2aFzGH80lDhqvM8o27PBTOnrh4t+lcPNCbU+rjpsCX8QA4lLGt4VtvTkGCcliFkqeLO0jiuZDZuxNKMhHgIky8M4dSOeyJdFdXLUdPOKOq0A/guDFhj/hFc7C+iUHFnojdj9+HkGQs1Lv0jVTpVSjgf0kDd/DJOfBntPXjP/YEFCXps5/Uq97sOZVguNBN5F7uBj7oUmPwFuY/5nAMMf7LuAh08tH0jpW7kH2To2cP1d5g39TlokC2qirGUkpT90bSiu5cJhZyVojGU8U4klEt5bmJCvD+wxs4WTL3aAP21sakDXpZ8sC/q/UPKiUxZzpsfrAP9QFdyDKJzU18rtCpOhoSqYfF5cy0UD+3IqUQyPjZuGSPB38Adgmtb0psH4RriUprwW0BHHIOhGHI4gSS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad4bf67-5bbe-4370-07a7-08dd76a23357
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 13:35:17.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXQT26VmBCs/g2mKdyvDQeWv+tqcJ2UFkeDCyCSCPWjx9pquj9bGnkNF6DYBZEIBvJcE3gsqAasZ/GfzixZpSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_05,2025-04-08_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=684
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080095
X-Proofpoint-ORIG-GUID: cCf8hFFFOFX7btT0X-mESOAuabarjM5q
X-Proofpoint-GUID: cCf8hFFFOFX7btT0X-mESOAuabarjM5q

Hi-

These two upstream commits have Fixes: tags, but should have also been
marked "Cc: stable" :

  1b3e26a5ccbf ("NFSD: fix decoding in nfs4_xdr_dec_cb_getattr")
  4990d098433d ("NFSD: Fix CB_GETATTR status fix")

As far as I can tell, they can be applied to both origin/linux-6.12.y
and origin/linux-6.13.y.

Thanks!

-- 
Chuck Lever


