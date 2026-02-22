Return-Path: <linux-nfs+bounces-19101-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMsmKMVym2kizwMAu9opvQ
	(envelope-from <linux-nfs+bounces-19101-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 22:19:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFADE17063E
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 22:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BE28300B10F
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 21:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DAE11CAF;
	Sun, 22 Feb 2026 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wob212mu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="klfYWU/1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C11A2C04
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771795138; cv=fail; b=Rrv7prSJbk5hYQHP4+kYdZzPN+7Tcrhdm6yjZLQIBHJvnR5bu4P+CRZkuGTo98aLSw2ZYayQdkCgLR7QkAXt3fDqFYn5bo9dOTAXsUcRmaH9z4pMQvEuQOf+cIcPaPPbQSfSjhdebFlQTRW1mXP8PHM6WGi8/KUBWjRc2XKIpgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771795138; c=relaxed/simple;
	bh=u9WBaZv/KPXkkBpdxl0uoJY7q6QmRtQTrP8Y6N77v8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SqrW5RNJNZJYnUwt8KrznB7lj/ndy748wPUoxe6W6wGrmZNE94Jfqk5rrt/mtV7K6i923ObpqnRWgKq9ADlZJzIOCuYLw2r2JyXztA4Dd78DClHrJPZFZIV078Xg6M8pHAKyRz600Q+AAls25o0S1641Cmo50Dd4J7tFHSs3uyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wob212mu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=klfYWU/1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MLHKFX233196;
	Sun, 22 Feb 2026 21:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=V/Pe0c9bOE0IZC5q/LfinTEH/WfsO6HIQsEzIUJJAe4=; b=
	Wob212musOCx1WfPF/eaD4Kc4Yae5n4QYOIbdy9QS5FdvR6mkDfGK8rTXThjtj9M
	QYfJpqQ/bPKZqJUPGLqlDbLV0Xt2sMFBvwEiD6HgJKzrnCmhEzV4ma0DgQFxPZpn
	5qHjan/D+edFazfxhGao4cMA5UwKFTqko+jA2kbKxmwmGprCLAgJ6pG28ep+i4xx
	FkGgLpm12BiB9h6fte/mOwvJreeOaMZJDDmEfhQQBLxnAKT9ZU+w24cSEDjmexsA
	om+Fhl02HTizyzkz6wNdmFj5MeP1lHaUJgIuE9M6E7UDmawsQr77ygjKKvNtRlLo
	eT+FgMOrv3CysObch/ykkQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3g3hah4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 21:18:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61MEnpDD027807;
	Sun, 22 Feb 2026 21:18:49 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35cnej5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 21:18:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMchl27oy/fGX1m/sFYb+UbHlCaqrRx3+lUayusbYJY0Wm69PBeaOJaUFWdhcq/sYpVdFzr0v1lkHwQJyvCw22eRDtElPrbmlyroGDBD9fPEcIYbjlBh1E2rHs9ExVLJTHq86O2a13b9H+Nzp/uYTwI4aoVfKoreP9ypD8pm9IVu5Zz+k2elGkQisCirE/n7Z3UXqcngpOTJUHyW7QcICpyZ/W1QQKVZ8EjFMfWB7R7wa+/uUE6j0CJ6sqlQVoKthUJA44cyM+SheEAq2kT1uDJZDbBwAal4CiXUsAH/PPE5AuC40mq1Yb2kHHtgRBjMcd4uTqF7+DLFx2VI01qYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/Pe0c9bOE0IZC5q/LfinTEH/WfsO6HIQsEzIUJJAe4=;
 b=iM63ZEdd5bOWAz2UF3tjGs5bXql0E4zwiQIIJ4sZoKYPBMRynYnPNa4ddCRpoU08+pJ8kYVKFVPAqgR+9dRq9vzUEBMFRgrH4IinUyR/3AVYSh3oEKN/ZQmrDmzNdkhmPkjecElSb3kYOwl9WXeO5GwXLPNm5L1BnW6n/dAvTbygc/n7XpGKq7kg0VaHGO1LzoSkvyYNXCgz3apvJ9C8xKK3cGcHJJwXeqewZ7WL6gMu3nfVM3tUwprjM4h317pgdeFYn7Bhwlukv0dWJ5xG+hAaTSOF1HVoXGpIEWIEXbiL4zAjy3hjqPNtpRbH/sgLEZFAHaB6ecMaX1KhjqvnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/Pe0c9bOE0IZC5q/LfinTEH/WfsO6HIQsEzIUJJAe4=;
 b=klfYWU/1dPeJDPdE/3k2uRroWWPeEkz7/EXjJ1xIvn9iqW8XV9NpSDfpEu0N5bZl31jK1yBDcYsb1gYm6ARRipEWIaFDWgj/8WmduHChyFcIMp5xw8w3MLoI2OGaIDr78UH/s6/awadiisKDDREF8YfK9M6lXt1Tnsn0j6Vp6q4=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA3PR10MB8090.namprd10.prod.outlook.com (2603:10b6:208:50e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Sun, 22 Feb
 2026 21:18:46 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9632.017; Sun, 22 Feb 2026
 21:18:46 +0000
Message-ID: <687f1398-698b-4646-b9d4-24fbe77d7241@oracle.com>
Date: Sun, 22 Feb 2026 13:18:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Expose callback statistics in
 /proc/net/rpc/nfsd
To: NeilBrown <neil@brown.name>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
        tom@talpey.com, hch@lst.de, linux-nfs@vger.kernel.org
References: <20260221215733.3643669-1-dai.ngo@oracle.com>
 <177173152164.8396.12929618094338409157@noble.neil.brown.name>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <177173152164.8396.12929618094338409157@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::14) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA3PR10MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 9076c470-dec0-4052-58ef-08de7257f6d7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ajQwUTBxK2ZYN3ZWR3FMaENSeldzbjJxN2lSZTd2QXhnakdlRm5pak9laHBH?=
 =?utf-8?B?Lzc2ZHF3K0dYZ213cUs3Rit5Ym1zZVJ3TFl6RjNiK3BiKzFic1BZU2xVTEk1?=
 =?utf-8?B?czNYbTVuRUxDSmRRN1VRS3c1U0V3THIxTEMyOEdDR3N2cDlNRmJ4b1FIY3Nx?=
 =?utf-8?B?NWhlVUord2pYRlN2RnBrY29GS3FzazdRT2pKOVVnWUpqRUNiNjVaV1BSbEUw?=
 =?utf-8?B?VCtSV25qSHRzT0tPUnBBbkY0WXBhTHFOaU92eGJ2bXVURit3bmhQUGtkYTZJ?=
 =?utf-8?B?LzkyeTNYYVFjZkdIYmJveG5WQU1UTE9UMUt4d0NVaWIyby9GM0ZPM0IzSTlW?=
 =?utf-8?B?dm5iSEoxQnJnSm1xcGd2Mk5xMXU1cVA3MFQvcGJCYzNIVURMcU1qV2l0dEUy?=
 =?utf-8?B?YnNzR0t1cy9zcVRCY0JzRXpJbmVJUERuaCtrSjlNUFVPRE5pQnBreTE2dXp4?=
 =?utf-8?B?Mjk1R0cyWXc1SHEwRUppZ0tTZzVpMzJIWW1IQlQvTFdDWmZ6Q2FwYVJtL29I?=
 =?utf-8?B?RThKM2xQWm1GWDFEd3Bzc21acDBPejRrLzQ5enJwVzNGYlRkKzZtTVd0VGxv?=
 =?utf-8?B?U1dLRjNPalN2NmlQeHpCZ2NxTEVaV2sydlExbjc1eUJtVWhZY0prOHRubDI5?=
 =?utf-8?B?QkF1NmN1WDlWaENwNnlSL05aaTlJaXlDVmpLVTFUQkRsMEg0Uy9sTUNrNmZu?=
 =?utf-8?B?cFFTZ3NVWlBUNTdTMCtVVlk3cHJMRU5WaFYyK0dFTHJVdG5TbTlJVkxXNHhY?=
 =?utf-8?B?bjhPYWtVU242eVpBOEtmdGdQOG4yOXZpMVFIV3dNMXhkekxoeU44cXhrYzVL?=
 =?utf-8?B?TE5BVE9sWm1XK2tMTC9Vd3FIcTJuSW9yU1RySDlsR0RtYXo0VjNNbXhQK3RT?=
 =?utf-8?B?d1ZZV01mRXA5NEhua0h1cis1YUZSeHFwZzZXNHV0OFIzYnI2Z1FOeTN6OGRM?=
 =?utf-8?B?eEoxK3NjVWZoOThiY1d0Vjcxb0tTVG9zWFdPV0FSYXhhVnJvWVAvdXR2czRP?=
 =?utf-8?B?RmlIRXlhKzg3NTVFYkZ1dDZuOGpaTUcvRllsOG8yZUVOcXQvVmVGUDZCYXMx?=
 =?utf-8?B?Qy9WSENDWGJ6U2VtTVdxanltU3JPYU5jRG9jQ0dJUkQ4M1dtZUVsZzdHakdh?=
 =?utf-8?B?ZDg1c1d0OE1UUjRENmtDMzdoM3E4OHNrSmR1RGJKNW1CcWtFQUtPTWE5ellY?=
 =?utf-8?B?TE01U0tyTXJVUm1sNTZrZXRVU01FUk5vMysyYlNodlY2YVI2OXpRVjk2TU4r?=
 =?utf-8?B?RWZyWkZ0WiswNDFRaUs0eDlFc0RFNzFIMVVZa3o5QlkwVk1BNStSNjlKaE01?=
 =?utf-8?B?ZVNoaHAya1ZyMkVPUEVjbDhsRzZTTktBMUM0cURxQ05RNW1KZTVPbmpmMjhI?=
 =?utf-8?B?VFZuQi94WmtUamM5VDhUNnpISVZhL1c1QTVkWHptYm42QnZSTnkvOW9xY0NL?=
 =?utf-8?B?V0lUQU9IUU4wSk5rN1NoVkEvVXJIanlndEIwOG1vTS9NNWdDRklaQWxHY1hG?=
 =?utf-8?B?cTk0cy9YQVBzVEdmS3k1WmhHM0k2UnZtRWltUVd5UGxjdHd6N2hDY2NSdWEz?=
 =?utf-8?B?dUFLSDZFc29jdTZjK3M1SWFCS1JTM3AvbitNbE94TmNpZStVem93eWRXNDhD?=
 =?utf-8?B?dnZKaHdBcjNoTG5JRXV1VGwzQksvbG15VkVDc2JETzZLdFVVVzNHbHJ6clZ4?=
 =?utf-8?B?bDVpZWR5bEpVWkQvamtrcTRYYVhjTFFSVWlYeFIyeVlJWDRVcmhpdHF5bkdG?=
 =?utf-8?B?M3l3MG01WmYvbnQwUkh6cmM1TitNRDBLcElEYkVWWCtmaGtvaCtUNjBPZkJ6?=
 =?utf-8?B?Smc4bzUwbm55cjlsQThIQmJTaXBOY080UEErVDlvT0NxWkxoUmx2MzVwMHp4?=
 =?utf-8?B?Y2lvaTZEZ0swbzFiRzRjamFkRkR5M1lKZmNuWDYyRDRsMWpTdWYvbDlidm5B?=
 =?utf-8?B?VHZySmxWeEZiZSsvZkJDdGwwY1B6MUg4KzBjc0txcTd3V0lwQlloMHd0eCs5?=
 =?utf-8?B?L0dUaTUwRExsUUVMRHo4MDRpcXJSV0tsUUcrRTJKRXh6aEJ0Qmd3ZXViM3l4?=
 =?utf-8?B?U3dhbnhsMTVJeVNYbDdsWmhrUEE1NzFxNVh6ZmlzSDNCSXJMbnp6ZEN1Zk00?=
 =?utf-8?Q?tD5M=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UjIyeTB2cit5eVRkalZ0cktwcEpWT1lmT3VqZVZsUTFGSjJlazRiRE91OWw3?=
 =?utf-8?B?WEhuSTBUVEQ1TW14cFB1Q3dpMG02anFvZkY1OU54bFFiVGNTWGQ5cTB6NWZB?=
 =?utf-8?B?TDIrbG8yMTl6Q1g5ZmtxQ3poZ3pidGxTTEZsT2xGeE1qMTNubXpjWWJVTUdM?=
 =?utf-8?B?VEtrZjByVDFQUnRMbFZRaXkzamtNZTdDNE1qV2kzQ0tVUmV3eHppMmttam45?=
 =?utf-8?B?QmlCRDBKZEM2eDBOSnBnSWxlTmlBcHNVaDlmdG5GZldGeXVwNU5xKzZIc0dE?=
 =?utf-8?B?dFg3dGZEMlpIZjdGZnZhcG5IN1pzRHNkOStBMzVMOTlhK1M5cURpSXZ1Tm1q?=
 =?utf-8?B?SytIUnlrRksrdWxGWVllaHN3WGlhZnA5NU9jTnJ6MWxkQ1RheUtIVkFHQ3V2?=
 =?utf-8?B?MHZuSmF6Ukh0b3pQUGliY2JsMUw1MTFwakRoODFEKzluUzU0K0ZkK091ZVJv?=
 =?utf-8?B?TkdEVmpuNU9DVnNTanN5ejJpSmRxMGZSZ3phcEl3ZDRTdkpCbU8rS0NUSzlP?=
 =?utf-8?B?a1JDSktIK0xybmk2Z1Q1TWpYOUxwMmlnMk4xdWY3WEhHcGFiUWNtZC9vUWll?=
 =?utf-8?B?SUc4Sy9kVFc5d29jTFFUUE9LYitMNGxpNFV2MnNBSndLWjJ2QnE2Um5pcmFl?=
 =?utf-8?B?ZFFHZXZBY3dveUZSQ09xMnc4VVlMVjk0cithM0lnVWo1WjM1ODF2VXVZWk1i?=
 =?utf-8?B?OGJ0TXV0SEJGcWxjRFpQeVRWSlJScUlHOFBqdWZUVjM4MlJsdnBuY2hSdllW?=
 =?utf-8?B?YnhVTnFTK3NDMFpJUzhSRytvZHlQb1ZOSmNvVGxhNk00dHMxSmtzSCs5bkNq?=
 =?utf-8?B?ZlB1STdMOWVoem0weXllWlRSdnYxbGhnNlQvcS9kUTUzNDhISkN5RnJvMDR4?=
 =?utf-8?B?eEtpU0xZd1g2clRQdklBTWplLzdyWnVac0JScTRpZ1lVNFRJM1U0QkhlcXVp?=
 =?utf-8?B?SDZnaGE5TTg4akpTYlUrck5Uajh0d0EvVlVOWXlzT0k1SGpVa25rbEVScGNp?=
 =?utf-8?B?NGVkci9DczRUZCt1cWo3YzkrL1dpaG5yb2ZYcEtxWDdwN1g0UlhSS0dydWFN?=
 =?utf-8?B?NDRUalo2OFd0UzF6dldiOEJ0NFZoMVlKcHJ6L3pvOGxoYnNLeGZDWURSM2kv?=
 =?utf-8?B?SUYwR01uNXRsZlJ6aEdUMm8vcFVrM0F6SWl2ZThXLzVxcEdXaDJZeFVBZ3ps?=
 =?utf-8?B?aXh3bVBvc0RsMXZ6d3BqZkVsUGFjMGpWNGN5ZW9lQTFRYlBJTDlhYVhlNFJX?=
 =?utf-8?B?dk9QSFIyazBRSlgxQ3JqMGtTWTVsU0k5ZFJQdU9GbjAvRDNVTHhVblRCd3p1?=
 =?utf-8?B?S0ZIMENvTjkxMk81d0kzR0ExSjRZeERMMmVMdnBmS0NXM1puMHliazZzU2RV?=
 =?utf-8?B?dldWQUZRL3pWWStNR3lOdXJXRXRIRDdqb1hocTMvM2o5bWtOaTRNNklhdHBF?=
 =?utf-8?B?emtOZHlNMFBoS2JJNFZiSDg5dlQ3allxTWZ0eVZlbWZUc3dFd3lMcWhBRkRa?=
 =?utf-8?B?Z3JldlFBZ3M2dWwyR0xGM3hVemQrelJHc01hZHJpSnQ3eWErNTAvUzFaeDAv?=
 =?utf-8?B?V0pnbWdLY2JEa3RXeWdLVHAyS00vUTJCTXV5VlpwbXlXMmF6cUQ2Zm41eXRN?=
 =?utf-8?B?R294dW1jdlRseldBLzkxdkZlY1lkdWdGVnFpT0sxN0JUUlY4U2p1cjFrdEwx?=
 =?utf-8?B?UkNNc1ZlL1BDNW1VdlZReWQram5Pc0VDYXlYL21IWHQydEk2ZHAwMVFsZUxG?=
 =?utf-8?B?ODlmNG1aMzNOZ0crcHhZNVI3cDJEaVZmVlZQMklpR1RpSG5zcC9Sc1RNSkR0?=
 =?utf-8?B?WDZqbnpPR3oybXBqZGZJWVJMMVVnaU5Ga2YxdWRVZnJwN2phU00zUTZmb3dC?=
 =?utf-8?B?UXdCVC9mcXNQZ0J4SkJMYnVtWnhwVEs2SWtKUzNLU0RJRG9zMW9TbmNuaGJv?=
 =?utf-8?B?NndITkJYTzhQZTgzMU5uQ0N4anU4R081eVcxSnlLSU1vU1hFMXk4WUY1eW9Y?=
 =?utf-8?B?TGJEOUlIZWR0amc4dWsvaDU5alV0Qmc4NjFsdDlDelh2eFA2V2R2R05lZ1NB?=
 =?utf-8?B?V3pYTWhWbkgzbUhwamd6L2pGUk9HZEJWdkwxK0V0cHBIeE9iNVpTMFJ5c2JZ?=
 =?utf-8?B?dUZKVVl2OEJQT0tEVE0zcnROVGxUQnlRS0srM1FYeG5TRi9zOXlUZXl6RWpT?=
 =?utf-8?B?UkQ4UFRDMFBpS0pNemZQNmxaZkZjbUgrUXpjNk83TEpGajdacGVscWJYSkIw?=
 =?utf-8?B?aEJnNlE4bDhsRWRnWkI1ejdaK0JRblM0encycVBCMkVURTl6UkhSdnRLY0xo?=
 =?utf-8?B?dXBncDhMdVU2ai9BSG1NUGwvZXlVSXQ4cGZIenBGclY3dERIRHVJQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l7ZzYtPVo2cigsLGQAYsttKIH6MoEFPGGe2NT/OJ8i7A5k0Jms+s88j5S9ZG/fZX2VGZv02afppaLZTmAkmGrVYXJqYxcZ5EdChNC34ocUlGHtQjFBYzuUX/RqhjMrEKUBDYUkMWDDyBLBPMG4+LKBoHyQNe7iwIY6QY5vZoOnS9a8DeWKBR9NwZ95nzrtnbEU+l6qCddFRTzpeWRo3WZ/aNseDGycupaiHzCGFs3Hze3et1ig1bIMRFmUq8ac62S5UDJ90RTmz4Zfa7jPwmER5ggDDp0RydqG0mwo9Ub7RRxdPEMJF0MZWqoAeVG1zhqzlC8G0IknFNMcygGVj5SL9zLZJwKku1nsihIiVW1LJv2FKyisMEwPaGbjNkEzqHaMlf/kwVEgwzJOHd0QJaEMIJI3vypU0QBPOpR8kw288Cw3F7x/cqHDVubFwFzpgSUQuYpBVSQufidLtD/hzLE+YSqB5rPQJxJmzW+M9r3ttgOVsaAs1FhwB5IQ4sNtEZ71ODFNkoa5BI+0knH0DWm8to7bhxmI1LvBDgct8FIFNXmh65SbLdv9cV2YDFnClb3mKNXxuyzHGlgInTk6ErtOeNHDBPPcvVjSA2wO3PsKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9076c470-dec0-4052-58ef-08de7257f6d7
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 21:18:46.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jj5ehzxtwjziYMNrEBgyrOnRaaQ4eyS4RqL2QDIaBxwEYeVjdcxFyBo81ffUdy2U42pZmV8nEI2o60NpCuQ3HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_05,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602220205
X-Authority-Analysis: v=2.4 cv=Y6r1cxeN c=1 sm=1 tr=0 ts=699b72ba b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=27Hs40f94tfs96WPruAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12262
X-Proofpoint-ORIG-GUID: sIo_DBpyma22JSV_8QFE1vjvQfsFS0Ez
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDIwNSBTYWx0ZWRfXzO7hP6Mz28WM
 cxzOOOsfzDu6t0upJMTTEK/IuiYyv8fcicqiLGrhVCRwYHoPm5QVp+rlleO0H26XlPQ6ngsQyJ3
 Y9ndU4cNfoa3UgeAC7n/J7acvBrueUtGfu4M+iV1jReXHgHZXXTK0vyThv75NG0aiqW8Jpgg8M5
 tiXHknEMJ2/zdydZd1LjjtYcaUX1wrkwo58ckwK0wslnUoiXfC9PCSLD0Wqs2URTYgzTapd3Eqo
 ROSOncbbTmI5XrpMQOo4OWZ7Vna3JTuJof0oLPXLTdddzD+PRS3fUfdELrL9x9b9L1n6SIodKs1
 wSbS4TdENSWp6CUXsry3fRqUebCNnHeDOZghyOO3T7dx5voGqmGoZ97pp3NwcimR2SxLlVXZgXI
 tYIi8aDIEoJs87mVIy7qxzx9cYaUHlgpd+YQQs9mDYMl3hobh4U5WuuCnFygh/n9UEErxv2SmOC
 MadXc6qz813vsLInJlrQDESPocWBH2gLb3ikSHZ0=
X-Proofpoint-GUID: sIo_DBpyma22JSV_8QFE1vjvQfsFS0Ez
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19101-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:mid,oracle.com:dkim,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EFADE17063E
X-Rspamd-Action: no action


On 2/21/26 7:38 PM, NeilBrown wrote:
> On Sun, 22 Feb 2026, Dai Ngo wrote:
>> Extend /proc/net/rpc/nfsd output to report NFSv4 callback activity:
>>
>> . Add system-wide counters for each callback operation.
> Why system-wide rather than per-net-namespace?

These counters are currently embedded in cb_program which is defined
globally and not in nfsd_net. Am i using the wrong terminology?

-Dai

>
> NeilBrown
>
>
>> . Add per-client callback operation statistics, similar to mountstats(8)
>>    raw format.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4callback.c | 33 ++++++++++++++++++++++++++++++++-
>>   fs/nfsd/nfsd.h         |  1 +
>>   fs/nfsd/stats.c        |  2 ++
>>   3 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index e00b2aea8da2..5d6c91b2da24 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/sunrpc/xprt.h>
>>   #include <linux/sunrpc/svc_xprt.h>
>>   #include <linux/slab.h>
>> +#include <linux/sunrpc/metrics.h>
>>   #include "nfsd.h"
>>   #include "state.h"
>>   #include "netns.h"
>> @@ -1016,7 +1017,7 @@ static int nfs4_xdr_dec_cb_offload(struct rpc_rqst *rqstp,
>>   	.p_decode  = nfs4_xdr_dec_##restype,				\
>>   	.p_arglen  = NFS4_enc_##argtype##_sz,				\
>>   	.p_replen  = NFS4_dec_##restype##_sz,				\
>> -	.p_statidx = NFSPROC4_CB_##call,				\
>> +	.p_statidx = NFSPROC4_CLNT_##proc,				\
>>   	.p_name    = #proc,						\
>>   }
>>   
>> @@ -1786,3 +1787,33 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
>>   		nfsd41_cb_inflight_end(clp);
>>   	return queued;
>>   }
>> +
>> +void nfsd4_show_cb_stats(struct nfsd_net *nn, struct seq_file *seq)
>> +{
>> +	const struct rpc_procinfo *pinfo;
>> +	const struct rpc_version *ver;
>> +	struct nfs4_client *clp;
>> +	int ix;
>> +
>> +	/* display system-wide status, count per op */
>> +	ver = cb_program.version[1];
>> +	for (ix = 0; ix < ver->nrprocs; ix++) {
>> +		pinfo = &ver->procs[ix];
>> +		if (pinfo->p_name)
>> +			seq_printf(seq, "%s: %d\n",
>> +				pinfo->p_name, ver->counts[pinfo->p_statidx]);
>> +	}
>> +
>> +	/* display per-client status, similar to mountstats(8) in raw format */
>> +	spin_lock(&nn->client_lock);
>> +	for (ix = 0; ix < CLIENT_HASH_SIZE; ix++) {
>> +		list_for_each_entry(clp, &nn->conf_id_hashtbl[ix], cl_idhash) {
>> +			if (!clp->cl_cb_client)
>> +				continue;
>> +			seq_printf(seq, "\nClient[%pISpc]:\n",
>> +					(struct sockaddr *)&clp->cl_addr);
>> +			rpc_clnt_show_stats(seq, clp->cl_cb_client);
>> +		}
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +}
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 7c009f07c90b..cec0c6167ddb 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -591,6 +591,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
>>   #endif
>>   
>>   extern void nfsd4_init_leases_net(struct nfsd_net *nn);
>> +void nfsd4_show_cb_stats(struct nfsd_net *nn, struct seq_file *seq);
>>   
>>   #else /* CONFIG_NFSD_V4 */
>>   static inline int nfsd4_is_junction(struct dentry *dentry)
>> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
>> index f7eaf95e20fc..cc601719ef26 100644
>> --- a/fs/nfsd/stats.c
>> +++ b/fs/nfsd/stats.c
>> @@ -66,6 +66,8 @@ static int nfsd_show(struct seq_file *seq, void *v)
>>   		percpu_counter_sum_positive(&nn->counter[NFSD_STATS_WDELEG_GETATTR]));
>>   
>>   	seq_putc(seq, '\n');
>> +
>> +	nfsd4_show_cb_stats(nn, seq);
>>   #endif
>>   
>>   	return 0;
>> -- 
>> 2.47.3
>>
>>

