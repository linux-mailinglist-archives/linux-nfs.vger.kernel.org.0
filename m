Return-Path: <linux-nfs+bounces-11820-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E432DABC896
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 22:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE634A33AA
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 20:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2A4A92E;
	Mon, 19 May 2025 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dBfNVcPv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fLQN6JCp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3D21DA21
	for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687548; cv=fail; b=IvbIZGroTlmoWs8vcWSE+G2/DOKwtpBxi17nEcLW2eDIv4GhktCMGAwNaPc1kKdRwdKZuyNnNxYcXsFsNDPRyoqvLhoSae3bAzQHrphuO4ZKAGoXL63C2nCqai9HV2YUGCRlALRy/DEQ/bGuBNq31g5BZt2gt9NNcWDdY2Jh6Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687548; c=relaxed/simple;
	bh=zmKSUrD/ECU5WDMWEpppD/oJwoP3d6PaOS9X6o28a88=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f6sSNmmxEMHvkaEAyqM0BpmwKeJXlR7+JlCIvTUsZc5fUWl1faS1YF6ztM/gM388V6vKuB/ecCW6rRPSlbVTTwGweTinNWPBtCyCGAj6xjTT8PFGyUISg4UZYvl4RdNvIQIGO41h2g2XFHCR/WZW4F4J88G9n3B5KdrDN3NJqdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dBfNVcPv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fLQN6JCp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMo5G026215;
	Mon, 19 May 2025 20:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xiZ8v3VlyJnz5Q3S3DQZ3ejAwy1+fykiq9kO/mP1hnw=; b=
	dBfNVcPvwZZi/euW+js3Ca0UpuaoxGryIKkAuW3pq6Mc2wxtiOw/GTU0S1/oRoKP
	OMfhUJMeHkuR0a3HpZfjCCb9J3lLQPE0T3jhpfWZU92bdKyMFIftqb7cmjPZbWi7
	Py/5cOSGOxt82JvB0HqRMIjXcb5aOq7QlgqTttpizEWAUbcweLbqHcJCjfDyfV58
	YyHdmPB1AVazQnlXlxQ6PJ0N6rA2DacqhRIQu4fbYjz9DJa0DNaD1e8Vl6yh4qgU
	t+s2rCWzUrn76UNCvoNqPITLhGf7PIA7CTPfoaCdecN6exDNRBMhxnv8hA2hWvA6
	wD2HfaD037TSgMvR5AG+jw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph84ky4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:45:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JIstuD029004;
	Mon, 19 May 2025 20:45:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw75nuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:45:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRG8bddN7TmiQjusPREjl4vGuUPlVLCHNi+LLxdvlhSPRgG5d50ZAzMlxQMgzRXhEwaOtEIdaTIFEq07knSi+iK6Y3VUpPkjwGbKcTnrtboZSZrA9MRRdrPHs7DpEDs8J1dUGLW5KOwzVsve5f4yUoiSRe5+yJH2xSZV7Swe1IpjvRrl3xh8YAGAO6YPmgwIfUuhO0KjksYQ0fQM8rTj67TQmRgrUuyUZKJaxqKJ5P5SDAkm30WOCFWOPxLjyqiTc+6sZuGM7uEtblDru3jy8Ns7Mpo+B0hJQbn0PRcKwMdqgRNZnBbAxkegRAewbs9Nqo0P+KHFRuxXkyC/ptRXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiZ8v3VlyJnz5Q3S3DQZ3ejAwy1+fykiq9kO/mP1hnw=;
 b=u55SdhGkpteez/Yxo7SY0nCW2pFImg6LGV4donaCmKRr8QIBwwpqCJPOJ+z8SRFVBZGADeTy4rNm2rvjrI45I8gqRg+HnKSpPj0H4YqwU5OpT7lDHqIkJ233MZQEidhHWlTxF7Oci3fE8IMfq6y1VMMapvGKkOGTLftg/cG2lzOR5xECGlEjUKK/ti9a2eHJQyCQKhodSSy8F1tqG7jlPlCOCVFjlos/R8b+fYantEbDd3CEZGUFcuJcji1V1NWE75+wXe+y1UcZ4SSfKbS6rmtHBsUQTWcVs0fgZ9PKGMOQPn99LbBDih5UxPFf/kGsComxAboqZRlve7DF1j0zYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiZ8v3VlyJnz5Q3S3DQZ3ejAwy1+fykiq9kO/mP1hnw=;
 b=fLQN6JCp6Vdr+IYBkQ/UC356Y7ES6bMDxaNDpD5QdzmkeLoaZXYlumUqhLvcx4ThjH65kpg6k9AvdUzXQK9K/t/Yr8kX97hCTndZxwx3N9RQgaIF+Fx3vj051dwFavmdyAuLugGXQiqnfLh/OApzycEErWVaVwYAPOdWVczm6gg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5187.namprd10.prod.outlook.com (2603:10b6:208:334::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 19 May
 2025 20:45:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Mon, 19 May 2025
 20:45:27 +0000
Message-ID: <b2c1bfe1-2272-40cd-a4a5-784d03b214e3@oracle.com>
Date: Mon, 19 May 2025 16:45:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Why TLS and Kerberos are not useful for NFS security Re: [PATCH
 nfs-utils] exportfs: make "insecure" the default for all exports
To: Frank Filz <ffilzlnx@mindspring.com>,
        'Dan Shelton' <dan.f.shelton@gmail.com>,
        'Linux NFS Mailing List' <linux-nfs@vger.kernel.org>,
        libtirpc-devel@lists.sourceforge.net
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
 <CAAvCNcBPac+uDC6x_V_jW1q_JCG3yEeCMjvpc869AmBAhti3Xw@mail.gmail.com>
 <001201dbc8ee$07bb7920$17326b60$@mindspring.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <001201dbc8ee$07bb7920$17326b60$@mindspring.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:610:cc::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5187:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fef771-85cb-4dd6-4fab-08dd9716160b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHNNZmNaWk8rRzc3ODNvSHcvVDByUkZFMVl0cURnRXJXTWttcGpES2IwYzRq?=
 =?utf-8?B?Um1MNE15ZXgyN3J4SHNoN2pONEJGeTY3QkFIeWZ4TWp4SDBXTXMrS3NhWHpO?=
 =?utf-8?B?Wk1tQzZ1bFl4QVhaK1JZRWZCODNFb0tKemt5ZlhpOE5QY1NjVEhMZUwrNDdF?=
 =?utf-8?B?YzN6cnU0bkNhYStvRDFrYUQ0ZUtReXNHYlNLOFVEK0hLVklRaEtHc3o0cjE0?=
 =?utf-8?B?Tk1PaEt3UitEelZVS0FocFE5azIvVkREMHJ3dlFhejAzd3NNTnp1K1cyTnhm?=
 =?utf-8?B?bWdlcWZVQXdoUHdmb2xiN096L1pnckJUeUpwc0draVdrNWRkM2Ztb3NZY2Jq?=
 =?utf-8?B?WWF3RjBhVVkyZ1grQ3lQUFdwdHR1YzdScGhNeXpjOHBFaTFLNC94Z1lxWE1w?=
 =?utf-8?B?S1NieXdGdEJTQ3pmbXJkTlJPUmVCSEIwQ3BBZWFHeDhralUxTWJCcjcvejcw?=
 =?utf-8?B?QXJrV1pOZVZBamRnVlFQUlNVSGc1UWxMTldieEdvQTJzVDJ2T1pzWjN2dTZu?=
 =?utf-8?B?WThVYlYyTC83eDVUVWh4UkRBMkNmVUMwQXdOeFI1cm5vK1JhT3A3Vm9VMzBp?=
 =?utf-8?B?MytmTXN6ZGdPZzd5T0VPZzgxN09ITWsyc2dKQjFPcVl6QmRrdk1McW5TcWF5?=
 =?utf-8?B?aTlyUFZHQnRGNGhLcVV4allrc01jTmZpeFQ0ZHNlYkkxNHE1dm5BaEJUem82?=
 =?utf-8?B?Yld1K204QkFOVCt3M1puYTNwdFNNWVk0OU85VDB2UTY5SG81NzRxQTRySVli?=
 =?utf-8?B?NTZybHdKU0I4T2FZUGZwbklEUEU1S1pPeU5FdmdkdzRKT3VKMnhWcmFjLzZO?=
 =?utf-8?B?dUhyaGd6dEpjUlU0NnNVZjBXRTBoZU1KbC90cTdNazliOEVMK1E1WTUvbXA3?=
 =?utf-8?B?T2FjN1BycDZBN0tzZGV5R0pidWZtQkZzNkgyeEF2N0Q0V3N0c2ZKTmg4SzRN?=
 =?utf-8?B?QVFVa216OUpNQm4wVDd3THBoTm5QbkZkTkNiQmVQTGUrTURCbTU0QTJpWjFo?=
 =?utf-8?B?N0c0eklxWGVyN2kxcUpPaGttcktFZUVpZXU3SER3VmJPNkMxcEJvTUNudDU0?=
 =?utf-8?B?OFZBOFBsUFFFNzRSQ1U0Tmlqek5NOXRRblRNOHpsMy8vNFpjT1g5VEMyTTB6?=
 =?utf-8?B?OStGRHp2L09mN2tNM3htemlScWhpSDRwbE5XUHJEZ09mdUQ0V01pMG1WQ0FR?=
 =?utf-8?B?M0VUc0N5RzBpY09FMmRTTnlpcENaOTg5ZE5hY2tSd2RDVTNURis1Tzl4ckFz?=
 =?utf-8?B?SUtON3pRaVNucmk4N3FzU2psYVJ0ZjIwclB4a240ekxoUCswN2VPVHJTWlZi?=
 =?utf-8?B?N0J5blBhb0dJMHNTL0cxLzNMV1kwQUVZMTFkWktveWh2U09tWEpEUDNHT3RK?=
 =?utf-8?B?NHdURWhUM0N1anAreUZuNThmek5JYzlqK1oyUk9XNnM4NnNGdW9TdmxDelpa?=
 =?utf-8?B?RE1TMlZMeTc1azV5TzNRd0ZkR2FURGs1U3F3aWhnbkVFc3Fid2lwa1lFRlFQ?=
 =?utf-8?B?c0pLRHZoZGU3QU5RL2JwZllDQSsxQ3FKYmZ5NkNZQ3JPWjA5VUU2V210SFp4?=
 =?utf-8?B?R2RFSXNJZlkwNzJBMitIZ01laEVnZ0FHV2FVMWpDaGY3K2QwR0hVcXFLTWtr?=
 =?utf-8?B?YSs4NTYza3QvSGNrQ2IxQUJzUmxsRmRySmR2b3QzNGRqL3hKbCtRUjJ5YzY4?=
 =?utf-8?B?S1pGTXphZWN3ZEhXcHZzcGo3M2RpTmlpMU0rbnZFS3Q5RThvYVFTN2NxSUhX?=
 =?utf-8?B?cGEyMFpOb1I1M1U5VmpuSEliSXVLMmtieW1KbldMMEtVWnpCN1JVbWNiOXpV?=
 =?utf-8?B?R0duSWJjRFRPL1h2WUdSUVdLTVVkRzlkek9SSllJakJmK1ZxMHEwelNzbldk?=
 =?utf-8?B?VUc0dmVWd0NTUWtzVzl4U01IQjNscUplR2ZWZmd2RXpXTXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE1CK09zQ3R1akhpZllwWk9FMTlyVllUM3NyL1dTRjlLeWk1b3dHS2VtREJB?=
 =?utf-8?B?RmhXUGFobmFhT1MrVWhheXVzM2dsK0h0R2QyMEhUMzI2QzlpNU1wQWhpZFk1?=
 =?utf-8?B?Nm5teHpOL3pnQy9TYUZZWmNncGdDUGFQOW8zTWhiMWptc2FMQlBNb2ZPaEp0?=
 =?utf-8?B?OEZRNXdvZXVJb1FNWnNjWHFHUlRlaVVRUUJmYWZ3UG51UkdVWXlXRC80cVlp?=
 =?utf-8?B?WlNrdHdNZW9kclZIMVBLRU15VFU2WGp3ZlljYjZuQ0hyZEFub2FzbWlyRW1V?=
 =?utf-8?B?dmQ1Zm1UNUtVYnhkcVkwWFdhSDN0cEpTaHVOQ0JqNGo0dDlUNTd2MElDb3Ja?=
 =?utf-8?B?VEhyY1QzcE1pczRnbmtCQnpsVlRzK1FBaFdoVkRuY1ZQTk5PV1pjMklNR3Vo?=
 =?utf-8?B?NitTU1krQW1aVVlYcHU1V2UwUkZqaXo0ekR0K1FqV2ZJd3hKZXA2VDFzVDRl?=
 =?utf-8?B?N0xPN1FCUHI2eTg3ay9EKys3eDVwYU9vVk9GMUZoSmxXekhqL2M3VGw1N3Bv?=
 =?utf-8?B?MWxVYlR0aFV6TWZIbGNyMFIrd05sRjRoTmJMQjlzK2QyM05Dem1xK1ZqZGl4?=
 =?utf-8?B?anZKR1VBSGFCNGZxK1ZFZDJnakdQN0I5ZFp5bjBqUytkdnQrOVRDOGJESVN5?=
 =?utf-8?B?VTFLanE0c2dBbjdNRlM2aEFIVGtLb0NHTUoyTldjWklwbktsUWVQb0ZnY2RS?=
 =?utf-8?B?ZFN4OVllaU5ZSUM0VnYxcm5CWUJHK1N4bnNTRXlOd1FiS1NWaE42NUoxekNs?=
 =?utf-8?B?OGVSeFlHZjFDdGdrWkl5VStIVmM1clBkcDZtL0ZpNjhBeTJLWDRJbVhuZXVu?=
 =?utf-8?B?UWJ4VmhWeTVhbnlsQk8zV1VqQ1FYRW9OMmxYRXQ4VkJ5Tk1iUEhzSWx3Q1Vm?=
 =?utf-8?B?WWhKVDZWb0Z4UjVydEZaWWlUMzFQaDJwZ0g2SE8yWTZ5Mi9zWnd1eGNYZUMr?=
 =?utf-8?B?S2k0ZmFYbjZwZVNsWDJXaEFXU2sxVDBkcmM4MTUrRTlPVkRyQzlsdHdJNmx4?=
 =?utf-8?B?aFhJTEx1MThjakpCaW9GT0t4RVh1blcxeW00b2tyaCtRZkJiRkNoQ2NQTEhD?=
 =?utf-8?B?TVRBRGZyTGQ3a0pVMWVwOXBzbFVIVUgrYWJJeUFLUGhaOVFaS2ExdVF0cHBY?=
 =?utf-8?B?STBHaVV2V0Q1SFUwQ201a09YQjUxQ2V1TVFOMGNLcGx3RDRUVEhCMVRibUJK?=
 =?utf-8?B?M0JnalZjOFowTTJ5YW1haUhVVVRwd3hCY05NWUM5bmNPRC9uSDB1eDY0ekVo?=
 =?utf-8?B?WFRBbk9aSytST3JzT1VvTExBUUJhaVI1bHdPVy9QYlliQktrYXVLSFVHYWtM?=
 =?utf-8?B?aFlPaldZR0g0SWJmM2dDaXpDYlJyWm95Q1QzaE03NGdXYU0yUkRGMk4wdUZB?=
 =?utf-8?B?ZmNiWU53bEh1L294ZXRLSDIwa25xZEtpL3JKNFpYNSt3RnYwRVA4R1lFTndG?=
 =?utf-8?B?L2llS0NJRlNISlJrTE9PdUNHK1NNbjFMSE9BdmY4M0ttb29nRUNwbXp0RnFw?=
 =?utf-8?B?cFRibTdqK2Z4MHFXYmRFa21KV1dKZ0JVNlhiTXJ6ejN1Z016TjRtYWpFTVF1?=
 =?utf-8?B?VFFzbWFOVGpTcXBkK3ppQU9HaHZSZlpyUlpkckJpK2RzY1hqRE05SWtvbXZt?=
 =?utf-8?B?b2dxeDVnQi8wZHE4S0dBYWRITWdUSVRaR2V2eE1IOTlLMDRWZzIzNFc0RWFH?=
 =?utf-8?B?anBCZmhjSm82UFgyT1lZM1VZMFN5UElJbG9meTBtZ29wN3BieWlWSXJlWHl1?=
 =?utf-8?B?aW9sbThVaWE5K1NNRC9LRzlmRHNxZWdaa1NOMU1qRjArZUNla2szMDMvVW9X?=
 =?utf-8?B?WExhRWI3Tk9EMlpOVjhKNUFvNTBRbk03eFZUQjd2M20vb290dCtQZko2dGp6?=
 =?utf-8?B?eC9tL0orNTBEVXkvc2UzNzQ5d21uUmJVdFlIQU5jNmFmUlNsR2p4U3FqSGtQ?=
 =?utf-8?B?QWwvOUlnWkhwL2k0aU5EWXlyWXRKZFBRQ3U1cXhlRFVTbDZMZ3kyeFFjcTRn?=
 =?utf-8?B?ZHJmWS9JSUhmUEZ5ODlqUWJyRlZCYVpUMXphbW9IZ2dFOUQxdVMySTJaMXVa?=
 =?utf-8?B?MEVOYndxVVVHeXdybUd3RCtCbjZOL0ZyOWlYanBlS0NPdFJocUtkUFo3Z09q?=
 =?utf-8?B?bXVIclNUa25UaG1yODQ5N1BoWUlLUkpzeGtyM3R2QTM0cDNkdExvZ2VBSkJI?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EbY4BWwnJGnsY77zPXbmI84fTNU9YfaEB4ImYqlMDcHzlgooyYGJHm3ET6mhrhkjYeDdryiyLSH7qMu+8QjHySGzqlOaplfWEMjrE5Ric1g6QQ73+pex7xic69/16ttTFWkD72rYXkbVOmSspL53OV3yfiSepktge9F3TJWuvuiOnmx0XYoITQSJmw6x8+uyouL+0x7mI5Vxfki+DRtHXR5VlAOWgdGpKj7XPrO3r6fb9KylO3UyLSGkwze6UNrkAgMajyZTolMhQdIWlsaSPUlLqJ4XgLGFIKEHFwORUn9h4x4lVFBI0Dr57unk9C0BaaC+Ln/ToygvMv5nXBWO4O5viFC4JPV6Eu6zIirWcCgzl3ene6KU1HbaRs+PoJNOX2vdxCskNVUxUl4NTZKoGFNcGR4iHelRdcyXnPiK0G/IZpXQc1uFNnpPTbji56nKfq4XMJmoElYk2h2IZiIV0Ocj3S6usAFRDP8DjBQlDgeGxaXLAU2kkyaD/KlIIF5UkXQcmC6FnOyV9j6bN24KYj29Cyyozn2Hw2/i7ZwghZmVjJbGx72LmwTEhTxbCrRZs59MVMHzy9Bqane/DEQLDNvR+ayRAqTG9b1iMR8R7So=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fef771-85cb-4dd6-4fab-08dd9716160b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 20:45:27.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXmY83zM2yEgvnpfIb4uubiTnfBjqg3kXmFAO7p5PPff9qtYuRdWTjN9LCqqeStSGKEHKsRyJZev6Eg1UiuI7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190193
X-Proofpoint-GUID: VOJ_2V9rmPD-dMdaA6Sgqb3y0F11O8rS
X-Authority-Analysis: v=2.4 cv=YPSfyQGx c=1 sm=1 tr=0 ts=682b986a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=6nNOuDHurVVFeN1Q:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=FP58Ms26AAAA:8 a=wDx7Vja_8ncbRHgA4g0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VOJ_2V9rmPD-dMdaA6Sgqb3y0F11O8rS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE5MyBTYWx0ZWRfX8rQXOLRfAHbi hMPc3PG2n8Ey258QxfQ/GeduIVbflcFg1IZPwKrln4dR3++Z0C/Cj7Ly4SEZcmMZo3axQ23erGG sqUcy4LWtms3jC3pDigRDI4w7jybkATq/v65DO7KfuYw+PQNKgp5EbFqamgpqVYHIrFsp+JmUY4
 aPQOucDTh/f1dNlOUXjQT1D4oYcF/2wArt1nZ620W/pMtUHN9a1ctHyYxecMWmp3ACgWXrGa1Rp Ps8CIx4LE9fRNGpmJQX4/roXPDMTCkxxWPQGmVdEaZw2wXMwELX8bpL666V6rfKsnc/0jfVFRwH pBegh4WHEkykNz9Ry7nXjRp06AGjoS7rzni/bq/NA3Ei18YERi/nAsOjltqQuRswqwMsAWOEbYU
 2wDMqFa69ph0SHoiwOsyiUaGLMX79ySkkjfjdLfGrMbvTKcOjFzBdk21JYaCx63/obpzaQwj

On 5/19/25 2:44 PM, Frank Filz wrote:
> 
> 
>> -----Original Message-----
>> From: Dan Shelton [mailto:dan.f.shelton@gmail.com]
>> Sent: Sunday, May 18, 2025 7:14 PM
>> To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>; libtirpc-
>> devel@lists.sourceforge.net
>> Subject: Re: Why TLS and Kerberos are not useful for NFS security Re: [PATCH
>> nfs-utils] exportfs: make "insecure" the default for all exports
>>
>> On Wed, 14 May 2025 at 23:51, Martin Wege <martin.l.wege@gmail.com>
>> wrote:
>>> Interoperability is also a big problem (nay, it's ZERO
>>> interoperability), as this is basically a Linux kernel client/kernel
>>> server only solution.
>>> libtirpc doesn't support TLS, Ganesha doesn't support TLS, so yeah,
>>> this is an issue, and not a solution.
>>>
>>> Fazit: Supporting your argumentation with Kerberos5 or TLS is not gonna fly.
>>
>> I tried to add TLS support to libtirpc, but I think it's simply not possible. The APIs
>> are just not compatible.
>> Ganesha folks also tried the same, and failed - their ntirpc would require a major
>> redesign to support TLS.
> 
> For what it's worth, we (Ganesha) are still working on offering TLS. There are options (including kTLS) that seem like they would work (mostly) for us, the issue is if there needs to be a rekeying negotiation.
> 
> I can see how once a TLS session is started, we could integrate a ktls socket into our ntirpc epoll loop and send and receive packets on the TLS session. But when rekeying is necessary, I don't quite see how to get back into a library to do that, particularly in a way that still uses our epoll loop. That is the same for user space libraries. We have looked at OpenSSL and s2n.

The current behavior for our implementation is that when re-keying is
needed, the connection is closed and a fresh handshake is done. This
does not appear to happen often.

KeyUpdate support was added to ktls recently, but we haven't plumbed
it into the Linux kernel RPC implementation.


> We do see a demand for protected RPC sessions for NFS and TLS seems to be the best option at the moment.



-- 
Chuck Lever

