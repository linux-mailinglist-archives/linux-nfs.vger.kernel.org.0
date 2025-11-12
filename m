Return-Path: <linux-nfs+bounces-16304-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AF4C5342B
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 17:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7ADE25602D5
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C06F31B11F;
	Wed, 12 Nov 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BCQLxQ4C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DbiH1WSx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FBD2BCF6C;
	Wed, 12 Nov 2025 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962477; cv=fail; b=b5qhOALa9qzIi6lHfTJchZ2DpCPDy8nInyx0CytQJkTtbrDRhUz3fKDRcmBpQg1IiqKsbEHu/x6o0e/KXeSKvKfxKR4Z5Y2BAvwZVuEbdsDlXJTGtFYclpZU7GR2B2MCRLeFqCQmXn+DvWYT5KcugfIcgKjt0ra0yeBZVUbu7zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962477; c=relaxed/simple;
	bh=mncFDGY3+/945SVUg5s1gAOOrQg5NhUMeQ6kzLmHCQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BdPtgAWz6oNwedq7sRxBU8UFkpW+ezpKZQC/hV5Zd/Z14m3OJ7fvqXqtJPSewEh7cmaJ5225JjEVMtZXTeYUDfJSoZnRh4Cal5USavoP8ZF5WvHQ9freXXXecBiVQPe+AZNpqmnzQ4xTYQ0C6r/5oxxh15lk+6PMQIrnqaAybgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BCQLxQ4C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DbiH1WSx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFRCFM008527;
	Wed, 12 Nov 2025 15:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=R+4g7ii9dxK/ak1xJw/apb9dBOK+CHzYsGXFD8xN0Is=; b=
	BCQLxQ4CPm1dHjLlV3XmewHnFZieYLODYpCe5qdAiN0V1watRIiHHvUpM1BSSNi1
	fGbKL0vLp+8R3baK2B5t07wyWK8GfN6KE9MinqBkoNpz8bjoucupAWImD75TzxFH
	jx+qumPOXCeHTD6SW1fX7cdD8bDFEWDBOU6+o+5wg2q1vd6EvZ1pqND4UmE5mnVQ
	6VgZlCdms6GMQC0G9gXbYil93Ek6sD3U/AvORnqyG5FZJrjISmlXYenBu7YTygHm
	9iROcIhnHRTX3NC/PiKddjyXzJXNXu6Xdeyd6WrdMIo6wugJaJZ9cYFBGYrI2io+
	1OcGi76LmYuArGFjZijeXA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvssr31t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:47:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG3nB018618;
	Wed, 12 Nov 2025 15:47:18 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaaux6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1USuMx3llxDG4JLwJ5QBpOWNiZAc15GWPhB0Km7y/Vcz9AlH3j/SdNiYQ1miVRukKw32GExbjNRz73evXzeyr3FC14Etv3kFvsgADjVqbaYXkcM+mf1lFK6gVu1qpCYNFgQZXcrFV2TQ7aoafF27xuXX47RfuJRLZKccDqTP4HRwKhhimPdM0Uxs7l4nWFuu12uU4L0nLyqogFiPl/SJk7dzHGpOu+IP58Vx52jXN9dK6P6W4A/iTCNFGAtADfNTeA149+gLTGVF5AUQ39Ch6Xc6S5UacwKKTcEugbYK9Q86h3OiUHY00lWrQtItsZyrI8PAkPRWImXV6Vs2IDBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+4g7ii9dxK/ak1xJw/apb9dBOK+CHzYsGXFD8xN0Is=;
 b=Bc73QJmvfhvpZ47FQJ743d5r7EIUrsg5DbPjScraGMzfHv97aRPnrXj1MxPR6HSiWno8WmBmx29+cMK+TQSg5RNGhP5lyrvdG02J9xi2Cmt0GCTnGX2Fy1UzGm27MpcsemM0tYf6IbjMVTlRZdxgNO9F9Cksn3RntjaZloCmD0KS83iQSCHjEvXLUJh+3Q2YST1iySmLXvo2Z5ZAN9QnaEgF+A/Xuswchhb9F8hCBG5K4YltgIC03rYb2WyQjIy0VAUPTWGG66G4K9aeBUHp9LxYXaV9UA5cwM8NIQ/hfVyOseofDFFwVZ7E1cqP4mxQlTxUe4jngBngHINtwU53wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+4g7ii9dxK/ak1xJw/apb9dBOK+CHzYsGXFD8xN0Is=;
 b=DbiH1WSxtEdJKOl+qXJNWysqAbIEpue9X2hfaLxh94cOC/W7trV57E2WoLOJH6kve9oSMK9WwEARpYZi37KYGQ6IuNgHDDGMiF+4PmjKg5U1N+DOOb3nI06nAZ4S8wvgPcyrV43mQZB6VwowKxQZh1Wr6IlQ9R6+yrSmxccLpbE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4372.namprd10.prod.outlook.com (2603:10b6:a03:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 15:47:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Wed, 12 Nov 2025
 15:47:14 +0000
Message-ID: <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
Date: Wed, 12 Nov 2025 10:47:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] net/handshake: Define handshake_sk_destruct_req
To: alistair23@gmail.com, hare@kernel.org,
        kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, hare@suse.de,
        Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-3-alistair.francis@wdc.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251112042720.3695972-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0038.namprd18.prod.outlook.com
 (2603:10b6:610:55::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5baeb0-7947-40fd-c698-08de2202c04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUgxd3duSWU4YU5nVWFKM0NmcHpRQURpc3JaZHlvUkhObWVKOWVTeGdtRzhV?=
 =?utf-8?B?UjYwZmpCb2pheFd6WXE2MU53R01pbE9wTzhtQW1wMUNHdlBBSDNTZTJiemJB?=
 =?utf-8?B?dUFuTzVLSGVqWVl5eENmUUhQbTJzVVRKTW5zQ05HN2FKMzIxUUlPUUx4WUZ5?=
 =?utf-8?B?QnlYeGp5eHNaOUhpRGJiU3NNc3pMVTlySlhJdjBGNUo1WmJYSW9BeGIzT00z?=
 =?utf-8?B?RnpocXE4Ny9SN0hNUS9LYmdXRFlpL2YvQjFJWTVpREwvRVliMU1SUXZSeCtG?=
 =?utf-8?B?WVNUanY0dGFBRmhaUkxOMXowNmxpYnVDVE42RXRDQVZMYXlwUVRhNFRXS3JO?=
 =?utf-8?B?alloQTVKdzZSMGk3WEhWUXB6Q1FSUUpELzBmNzlUc0JreW1DZjRacmxGeG1I?=
 =?utf-8?B?Z1hhMEcrZDJBNnVWVXAwK0hML2dIVnBEdEdCYU94TFM4UWNpOFowU3EydFVL?=
 =?utf-8?B?d09nVVlkMkJwbVhyOUNweHpBUXdEeEhRM1puRDBoWGlTMVEwVkhlRHRSZmh1?=
 =?utf-8?B?d1RncEFRV21nOUp4MGFIeFpzQ1VWeUdEa1J2dTlDYUdzZmN4eHhseTRaendu?=
 =?utf-8?B?RlFWaURPckEyUFBjb2E2cSthTGpLQWcwS09jZ28zbVNrckxRalJvNTVZLzc4?=
 =?utf-8?B?WmRaTFRHOGp1em16aDhmZGVSZjUxSWdRVkY1V29uRmFwcDhJaEc4RHJpN1N2?=
 =?utf-8?B?MmRkazBCYW5XczgrSkF5dGd5UWtKWUxReXUyRU8yeDIvV0RHWC8wZlZrTFRL?=
 =?utf-8?B?d01ubXRxcWNwUEkyNjRucFNDZ3pndWcyL1pTL3BEZ3dneHdvcHA4Y0xBS1ZB?=
 =?utf-8?B?NGpZNGw2K2w3cWdNYWdKV2JoeUQ0TjBkdGk3VTExaTlWNk02ZU42SExRSnNs?=
 =?utf-8?B?ZHcwVUdmazBLYkphTHl2dk5HblliUzBFMmVwMGJEeTN6b1BjRGRRYVBab3c4?=
 =?utf-8?B?eXZseU8wUXJyOGJoWlVQSDUrZGFmMGZOYWk2bFVWRlhPQ1FJbmd6cWdGRDlL?=
 =?utf-8?B?M2M5aWR3OVJQZkUvWDgrT2VLdjB1S1UzTlBuQXMrWlhCV0hOcEVOT0FvbHNJ?=
 =?utf-8?B?MmtsTmFuYWQzcUtDbUhtdFFxMmpxMGZYYnR4K1Q1Y2l5azY4R3hPalpXR25N?=
 =?utf-8?B?UW91SEZLS2g1Y2JOSE5oc2dzblpPRUlRdExhYmdiNG9mK3NzaFZUaXI3SkJV?=
 =?utf-8?B?L1R4cEt1RXBmeWN4RGRRb1VTSS9aZ0oxVWJsMG02YXlFZjlGQi80eGZjcDNx?=
 =?utf-8?B?a1lZUTUrZ1FmUDE3WGwrTnp3Mkxud0xRZklGMFhYK1BHTGljWitFVlhQNmdO?=
 =?utf-8?B?WGZHNmVUZlA0aksyVVlNUWNhSmMyVHBHRDdRZWNseGJHcmJtaG42cjBrWGEx?=
 =?utf-8?B?RFhWdnd4dmVLUXl4VncwdVhSWWxXMzFtcGtXMzRWU25Bem51Q2NwR3BTSmg0?=
 =?utf-8?B?L1k4NlQ4S3AvaFJPM0ZmYXVTb2w1YzNEVGN0YjltRGpXOEsveElTYzgyRFJ3?=
 =?utf-8?B?M3JQTDIrR2pPSzJvTnBlK1Vick1MR1ozTFpMZUNTOEdpQzJ2UmU5Q2VSVkdW?=
 =?utf-8?B?a2twSGF4dnFIMUNGeWhuQ2xLSXVXYzI4akpSaHdsNWFlcGJ1cVhzVGdBSU5M?=
 =?utf-8?B?QW1MK2UzaVY1azJMc290NDlidDJkN1dQZVBOZWU5NU1OWGVxSDl5dnJsUWZr?=
 =?utf-8?B?MFpVNnNNZ3ZoNGRoOXVHTEhtSWtVVkZRbFBVQWFoNUxZbXRLRFJZUUtCTGh6?=
 =?utf-8?B?eVQ3RHp0ZW9BcHN3QWF1MVA5MFluVWdwZVEyV2JBZitEUmxCc0xFdk1sa1I1?=
 =?utf-8?B?VHhDMVNVZ003THk3VitEa2Z2Q08wenNsc2RzUUFibHZlR3BQTUNxdnN5eXBk?=
 =?utf-8?B?QzlzTkp2eGxQSnVsRmVPbTR2bWFHMUdiK1llY3dGb0JtcEt3em5RcG03dVpD?=
 =?utf-8?Q?lo1WbqCji5dMNHYO8uprHIvGyJX9+7Jf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amNVSzZJVmxpbkloMll1VERPc2o0eXdQQitDNzNDNkdHR2t2VHZhTnBhVENm?=
 =?utf-8?B?Ykg4clpxb1BHdG1ROTMrN3BZV2ZqcnpsamJYRkYzY0NsRVo0MEovR3FwMEFE?=
 =?utf-8?B?aXE0WWxabUJBNE10SGtlOGwzbCtmRnB0bis3V25pUWUxU3Nwb3ZINy8zTnRF?=
 =?utf-8?B?WHNZZ1FiZWIrRzlCa0cvbGlpN2JyaUhSVGJNUEVXQU5oY2VVVzVBNlpaY2p5?=
 =?utf-8?B?ZTVpM2F5NSsvUjN0ajllL1RiVW5sN1BPRi9rcWNMQVZvSWovMGlzZS9VckVD?=
 =?utf-8?B?RHBrZWpDRDFNTC9uZksrYmlPdmJ2cTk2SFMvWHQ2T3pwbDdFcjlRQ1kxbXBv?=
 =?utf-8?B?dndlVHQrSUtZMUppcGQwOHlDL2tpbFRhNUFSNlFVa2I3Zit1bllQcW1yVUd3?=
 =?utf-8?B?V0ZrTVFCOWFDUjJXNzl1Sk41ZHQvN2o3VnJ0ai9MNDl5enl5cVJWb2ZUd3FE?=
 =?utf-8?B?Z1dwU2pDcDVtUG9mUU5lNTh2VVFJWDMwMzlidU9PT0V2VDZtTEwxaHJRLzE3?=
 =?utf-8?B?d2U5U0RLcFVQYWxuK2lPNnlMajRmanlhS3RmSWhGME1jakpGUnVtN2dMcHNn?=
 =?utf-8?B?eVZobzJ2OTROWmFJdHlpLzhXOXp4MWxQVExkZ2diSGUzS1RnSTF2Q2YzRi9p?=
 =?utf-8?B?dThiVllXcC8vaEt2a1p3TXNmYjc0a1dnbWJaQzRwNFdFd0I4cEthM2VFSHEw?=
 =?utf-8?B?cVl4LzZtaERjRXV3K2poQXFNNngyVHhHZTdnOXJnSEpkSTNmT0dZTWJtWkF0?=
 =?utf-8?B?ZU5rb2ZKUG9QdUtiakF6bm55c3plTFQ1cG5kSlZwZUZMVWlteGptQUxoY3BT?=
 =?utf-8?B?SFBWNGg4VndZWlRXUkhLbTdCV0VsNHBtN2hOTmwwYjFTemsvcG1rUWpkcWo0?=
 =?utf-8?B?RzJKR0hwdFluQytYZmE0Qll0QnlLTGJUS1RHaDJFMGtGb1hIOGVieEd3TWVo?=
 =?utf-8?B?a0MzSGNnK1A2KzYzSURlK1hoRktXRUpVY1NLcjdWcS9iWkZtZW5tN0YxcWdt?=
 =?utf-8?B?TGNmemplRmFUb2cvSkk4Z2dVVHZobW5OdnhpTWpUeENiZW11Mm1yTWVvRUQ3?=
 =?utf-8?B?ajUrV2RqdGVHRE5JeXNpUTU3a2ZYQkUwUlZ1dk8waVhnSkwvckJVZmVvYzBp?=
 =?utf-8?B?OWViUm5OOElNZVpjVkFTOS9sK2c2ZjBxcjlzYnVCY2VEN1RiaG1pSzV0a011?=
 =?utf-8?B?OG1QcGt0SXBaNTc0Y2FjVTVZdGFWNDREQ3AxSEI5R2gxN1I4aExVUGJLN3Fp?=
 =?utf-8?B?R3ljdzFJUk1zdHpEbUpaQlpDeGdyNEwxV0YvVWYzaGRpL0RJU1JhQzU5ZldN?=
 =?utf-8?B?RElnRzArTE5jUFBNKzYvbmlYYVFYTnFocUwxbHpvYit5eThSMHloRWdhaHhm?=
 =?utf-8?B?OXRhVkZIZ0QvZkZkVGZHRXVBNTFCNlZYVmhkUUF3MjJRL0MrVVlqNTBqczFR?=
 =?utf-8?B?K0R2YzMzeVkvUVo3UjlJejFWSGpGb0haMHhQU1NySXRmb0VyWStsaWFoZGdY?=
 =?utf-8?B?NXdidkFUMXJOTWdZQ1R0WG5DWW1rNDdhb0c1c2ZBUHphTzNSZ0JTcmViNXd3?=
 =?utf-8?B?WVozenJQSnB6OXlIZHZHQ0JCM0hrRGR2WWRXT25iTFBjNStEZ0hrNXRidm95?=
 =?utf-8?B?b0oveWN2VVZ5ODJVVlhqdVphWEZwN1lTVi85REYyODM2OUErWVhhTGUxZmt6?=
 =?utf-8?B?d3IxVXEvM0RNcjBGMkQ4OW9EZ1hSamIrdUVsM01WM1cybWJCdlhJWmF5Vzhu?=
 =?utf-8?B?VjlIYll3UE1TTEpTZzUzUi85aGtPVFQxM1RUWlRvZ0EvSlh6ZnR2VmkyazFE?=
 =?utf-8?B?Z0gycDBOVnYwcnBpaEZNYWVYRG41VUpZSDI3am1IQTNrUEFBUEpPK1JZVUN6?=
 =?utf-8?B?YmVna2piOFdDb1RIZ29FRUFlQU5NRlVvQXpGNVN0WVVaRVF2ZzRGSmpVSE81?=
 =?utf-8?B?SDcxb2M1RzlaeUVVRW02RjhYN2FaM0ZnZ1hrVVRDMDdFNnU0SEo3US9XeUxI?=
 =?utf-8?B?MlVuZDdBaVZLOUlsd2ppZ2NmbUJxY3pFTDVxNWpHa3FrMGdWNHhXaVkxL3NR?=
 =?utf-8?B?V2sxMjdXaE0yTEFNa2ZSWFBiSE14TDBBRHhwY2ZxSnhUeFNZMEs1TjA1bzBN?=
 =?utf-8?Q?ADaaLyJl6GdWo1STU69xZywHs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PyvWd2zk+Yk/T0cCMv48AOuWyc0Z9/zMhj38SYBKQao+5+uHqrdEAfIojFOJxRNZfQkk4wqJboYbGtkjyZl2woWdTVylf0curAXf6v9H/mMq9ZIsSFmadED0XG7XZoMKR3lPycshhYsUF7hsABOFpqDq8eSrfv7uWyqINnRTxWTzSLbEbxwiM47JOmalNjKXpqu4l43QVTGoZO4elpRuAATTJLpvpPiKdsOEkIs4tKDtSZ3fjXomXqUSFrWFOU6UfsDCJJEgwfvRBGHECe9LRIx67/6B1vHcZKOaoRD+hrMyGJLvlMJewz7LdEf/oKjnyQOlOlTSak+5CNo5KcarpsLCs/gcZwgY7KkbRqqdI/nDWBLQn/n3H2ztQpEAIpDr4dONUnoQkaogT9ciEgc+phNRudtjHfsGywlRUp3ERsTVVtXdG2XKczUAh7BXloywIS2teajAAYZXWVy0b9TBcBf35m4T9PgnJffuCqMwFGjIpHs5OsHNgHJF+Efpgs+UDXMiSXBKwgi3bPy7ltO39OJadfyX+s+vnw/uz5LfUfEdQsu5OcZW30XT30ZcHzcmTXF6FQCvTB1rzXPKVXmB4Gso1a/nDz6+yayHFNEcCbI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5baeb0-7947-40fd-c698-08de2202c04d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:47:14.6024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYOBzaEgO41Es/Edli/lH3XLVUQ/r3We94dku8s575qbvV6HLQid4hgMtWF2KvRtKDgL2t9VFKrYIK37LyPabw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120127
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=6914ac06 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=c2cqNLOTf_ciDq2IyfIA:9 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: wc1Tu0eVLOMX56gR3b3rX6mAkwg9FOaN
X-Proofpoint-ORIG-GUID: wc1Tu0eVLOMX56gR3b3rX6mAkwg9FOaN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfX7+UM2qlUxiBn
 RVK+ed3rKXpX3x1xfEVpKZTVE6LdrNJvrWEcVDYSN2bwjMJXW6wAMTon9TOo/NtIf8mhvLie0eL
 eD8IMC/UdB4bxsSuaGyrcOfKDRBVb/Zcgzw5H5WM4r4jq4+uuLs39+cYYboxexJXuwAFjxeG+2F
 ZGl1+tiZCXo5qaoVTkmrb3e0Ad692CIA0WRvIoyUDr62Prvxk+OVv/6/3Wh+fCl34G8mbdeK4m6
 jgmZuu0S4jPQ45aMv9pLxzO496iRrSBhHHHXvSq3iTiv8C+qDJrd/xew0vtY73xIqBV7l7Coenn
 AazwlpKMn8wWWjlzKm0odxvgZc3oWrd+gireZ1TD6aORxq6GTZxhlKvNYzCjz/GZVn3a3SHN0R9
 sINFxFa8vlSdgnHEMEZADrtxRHRcTA==

On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Define a `handshake_sk_destruct_req()` function to allow the destruction
> of the handshake req.
> 
> This is required to avoid hash conflicts when handshake_req_hash_add()
> is called as part of submitting the KeyUpdate request.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
> v5:
>  - No change
> v4:
>  - No change
> v3:
>  - New patch
> 
>  net/handshake/request.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/handshake/request.c b/net/handshake/request.c
> index 274d2c89b6b2..0d1c91c80478 100644
> --- a/net/handshake/request.c
> +++ b/net/handshake/request.c
> @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
>  		sk_destruct(sk);
>  }
>  
> +/**
> + * handshake_sk_destruct_req - destroy an existing request
> + * @sk: socket on which there is an existing request

Generally the kdoc style is unnecessary for static helper functions,
especially functions with only a single caller.

This all looks so much like handshake_sk_destruct(). Consider
eliminating the code duplication by splitting that function into a
couple of helpers instead of adding this one.


> + */
> +static void handshake_sk_destruct_req(struct sock *sk)

Because this function is static, I imagine that the compiler will
bark about the addition of an unused function. Perhaps it would
be better to combine 2/6 and 3/6.

That would also make it easier for reviewers to check the resource
accounting issues mentioned below.


> +{
> +	struct handshake_req *req;
> +
> +	req = handshake_req_hash_lookup(sk);
> +	if (!req)
> +		return;
> +
> +	trace_handshake_destruct(sock_net(sk), req, sk);

Wondering if this function needs to preserve the socket's destructor
callback chain like so:

+	void (sk_destruct)(struct sock sk);

  ...

+	sk_destruct = req->hr_odestruct;
+	sk->sk_destruct = sk_destruct;

then:

> +	handshake_req_destroy(req);

Because of the current code organization and patch ordering, it's
difficult to confirm that sock_put() isn't necessary here.


> +}
> +
>  /**
>   * handshake_req_alloc - Allocate a handshake request
>   * @proto: security protocol

There's no synchronization preventing concurrent handshake_req_cancel()
calls from accessing the request after it's freed during handshake
completion. That is one reason why handshake_complete() leaves completed
requests in the hash.

So I'm thinking that removing requests like this is not going to work
out. Would it work better if handshake_req_hash_add() could recognize
that a KeyUpdate is going on, and allow replacement of a hashed
request? I haven't thought that through.


As always, please double-check my questions and assumptions before
revising this patch!


-- 
Chuck Lever

