Return-Path: <linux-nfs+bounces-16190-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50BDC409DE
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA52564E44
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DAA2DF143;
	Fri,  7 Nov 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gEMfAWNF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hRlLwDZJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C522F549F
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529773; cv=fail; b=FyvScz6j8s9BSqhhctm7ozzFIqMvkGGL/MXZknEYnJ+6hj/K9CWmgGr8eFQPNy8JR1ZHcQELPBwzKJQUs+1EP017sqBC5kfIneKiawza/HbdEu77Uu91XP1oJMR/twlDzgjR6MC8bmhDWIb4VlyhMHFErk0Dbl/+wcuk/zBpVLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529773; c=relaxed/simple;
	bh=xn/KLaPNIhb9R7EZ7R1bY5QQm5nEV4hlGxpDEYJ3Ckc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J1pnrgJwYgyDwH1AVy7EvWL+74SKy6ZHcZgqXmMy9MMHDH03qbb/Ayy3Z6OIiSDAQXkxWKaaWfzPfSva5xm2so6Q667vEdPhyvfHQzhlPUUr273nrZhcEkM5iayACKifMl4O1Vl/nDTr1dIGnrVKHam9KtOyTCG0LFR8UKCFF/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gEMfAWNF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hRlLwDZJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7FLOUD009565;
	Fri, 7 Nov 2025 15:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nrE5rgIsSrlZYHAcPy3zw5r8dgJN2qmdImQathtfW0I=; b=
	gEMfAWNFyK1hoSzwZzGAMaQqQM0RcRiC88Rs2wd6p90IDHJo+8QXBkcUplLa3lmj
	nH1n92f7xlBYAOQcYi+P2aWfxdNEHeiCvp4aNnLk5uvOhyUPO+Ue04AeSgCzeyA1
	9mWo47VpSBwOxMOsrA4UuKX8BErvGZloYtemQuT/joeN8xalLx3V5GgmSZAViIQo
	Z+SthMHbgqVJURVYCsCyWudViJaX4SZGSUx1Js1Oov+arH6b1DgLo+Koh7hJ6Aev
	BFva1VlDqdWgpLqvvWmCfqZgW2Ov3PyMVpT9cAjs274CDDdbIkCWy7ZUROVvWUF+
	39RgLYxtXgPS3tflOstUPQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9jgk845j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 15:35:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7FRZRu010914;
	Fri, 7 Nov 2025 15:35:58 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ndx20k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 15:35:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvgKiUDkl4UNEszaNvMQjtpghg1TprqL+UhU1gAvmYQHR4PbPGhK9k+ZMP9RiJvHK33MeyNaBmVjxeEQ9asgKCOapz6ge1qMPInv9xr/SAZYODXIFn3anEGA5uMW45Q4pXgySUkGvrgqI/DNGNOo41rp5ULIKoH1LZk8fPJQT5Gp1t/Ap/A6v98xnsVBgKCNY9RA1yekjLQNTgGbvj3xwI2QLWK0wZvnEqqnoAOpxpJgcRSmbDXJoqmG+xmoxKwE5VGQUMw9xXuItyYAwjm4xbqKLPcQs+7xu2Lvg7P8qDoCv7aTMpeH06d9sApDI/iZ0PPJb8nWglohU/8n6bQv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrE5rgIsSrlZYHAcPy3zw5r8dgJN2qmdImQathtfW0I=;
 b=sZtNH0DgqnNIu0fVhkuPG9HQqQFLEKNhW58ZZNMY0NzEe5KvqYbn7skldHMAQHbyxYZ5olc9LCqUh+CM0u/ryJ3AV+cZ43Ne1tjdP7IwxsfhKVkhO3bCzxT8Y98f0kqyjpqFX+xngqRPNeHv28FJJ1ClgzO2MAeanAOXLesSkALtMPbqFk0NV6NfW9Li2g3sejh4GYL0n1mJqGPivTxCmkqNPCVFb9BmNVEy+x7Iic3/Ikp+Xc/bTMS/YYtRvxa5r2KP3ZnGLrmYVfDEqVPNPsG5vdY3sNSilspfIUUQyWLEb2j0w9iChSZjUPfbJZ7ILz4zs0vTzP8ScN4MARgm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrE5rgIsSrlZYHAcPy3zw5r8dgJN2qmdImQathtfW0I=;
 b=hRlLwDZJLLvXqx38CC2JcYocsxZ9YvYnO7cxpnoMPuHFom0kFJpQ1uMCeD+v74kYNkZ1MXVIF1ACo/cz3l7D3D+Ttwdpy38xFtTR5dmudwt9P1FMWoKmTu7UApHDNoljhjyZxYXveVQeV/2EjQxPvOCjcpIEvajhMCXYKG8iP3E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB8047.namprd10.prod.outlook.com (2603:10b6:208:4f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 15:35:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 15:35:54 +0000
Message-ID: <543c9183-40eb-459b-81bd-078e6ecb7687@oracle.com>
Date: Fri, 7 Nov 2025 10:35:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] NFSD: add new NFSD_IO_DIRECT variants that may
 override stable_how
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20251105174210.54023-1-snitzer@kernel.org>
 <20251105174210.54023-3-snitzer@kernel.org>
 <c1f4d144-826e-4c27-821c-47652a7b67d2@oracle.com>
 <aQ0CUPcYYg6-5IJ1@kernel.org>
 <7d9bcc0c-d997-4fb9-aa0c-831b8f08a9b0@oracle.com>
 <aQ0noN473a-QFqpz@kernel.org> <aQ4RftwuYIxwvLgb@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aQ4RftwuYIxwvLgb@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:610:cc::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: e3bef693-3b4e-45db-7fa8-08de1e1356b1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OFlQTE9zQVZoY253SUtvdThRcHFnYU9CTEJNeWhmbXozWFltQjdxUTBLTTZj?=
 =?utf-8?B?ajdjU050UjRpSFpwcUx0NjZVaTdBamx6Z1JjcVViWXg3cGppcU9PS3pQbi9V?=
 =?utf-8?B?Q1pLT2MvdmdYWWhqVWVMSTZiT3U1YVNBdTA1WmZTRHZpUjY1L2E4MXBYZzVN?=
 =?utf-8?B?ZzBPeitsUnF2dzZiOUJjWG10eE9wUmxSZEpaSVRLYlpCWG9YTDRzNTdLK0Mz?=
 =?utf-8?B?bU11SjEyUlU4N0hjRVJET01ONlVNOWViQUNpOWttRG9EQzN5SHNFd05ONjNq?=
 =?utf-8?B?b0J5RUE4aGg0VEpRM1RIcUZITHNrWEJwMTkwTFdrR3FKZlJaREJEbUpCcXNE?=
 =?utf-8?B?WlhlbldmeFgwSk8ycEpudWlSck1pc2kyNnZ2eDJPVlE0TWRpRHpvb2QzTzcv?=
 =?utf-8?B?Rmd2T25yUktrVE8zY1oyZkJMemowU1gzWHJyYTB6MjFvMDdqay80UDFyK3ZQ?=
 =?utf-8?B?OTJMSklDSjdKaEtNT0gxMkxnYS9jNHhrR0Q2MTBvL0ZxdFgwOXBQd1Nwdi9q?=
 =?utf-8?B?WjQ2RGtsbnVoQkpZV0FpNTd2WG8wd2ZaaXZGall2czFJaXhzVU5qOWtkWXFH?=
 =?utf-8?B?dVFVcEhOT3FlakdSOGtVVHJ4SXc2b2Fzekd4YUl3OVNoWVVvaDdiMVZtUThn?=
 =?utf-8?B?Z1dWWkEwdkZyUVNOVWtaa25za2JzelZWN0xlcmVYKzlYMmNwdVREQUJ5RitQ?=
 =?utf-8?B?WUladWZVcnNNVWt1WEFRV210OVVUNlhkT2xBZC92YlNYNmN3MmVMRWg5TG52?=
 =?utf-8?B?M2g5Y2p4Y2EvVUFlY1k5aU54Tlh5bWlOMmZjSElGMXROQVVPNEloVGgrOWdI?=
 =?utf-8?B?NnFvVkF5K2UxQzNWSmRHem1aT2g3OUF4eVlnTzhKRTZmOCt4TDJabEwrK0tt?=
 =?utf-8?B?L1FJSEJId2pLYkl4bCtDamJVWlJWOE8yYTZWanVBZnhrcVVZNE5Lbk41UlNE?=
 =?utf-8?B?MzgyL1RnZnR3NUlmRXhTM0t4T0RjUVFjRWJ6K044aDAvczd3a0FqdU5vbUhI?=
 =?utf-8?B?SzFoZ2FHc1E5YnNlaWljS1BQZUMyRUZodUxHK2ovRk1YWWdHUG5kYW4xSk90?=
 =?utf-8?B?MzRJdERiVzlyY1FvTVdIYjZiemViazVMTEloQmNDcVUxeCtvMllrYWdpK2hX?=
 =?utf-8?B?ZVRiMG1BMUxvWGRmVm4xTEtJNC94ZlVDV1ZUaWJUMHgvMmVoM1pVbXEwc1Bv?=
 =?utf-8?B?MW44eHFtYkdzOW1Ha25qdVRMK2FEYnlOdGZ1QUl0S3dydlZFMlJneWsvNHha?=
 =?utf-8?B?VFJVSmkrakx3OXpXbDVlaWVKQlc0b2NseU1pSE90MG1zV1hvMVNEM1BaclVu?=
 =?utf-8?B?NGZ6SXUwZ3JBMTlDU1V0cDd2cFg5Q1hJWVhWWDNrNDd0RDJMMDJKbWxnYXln?=
 =?utf-8?B?T1BFUnpISDEza2I2My9BWUR1WjhVb3R4SEUwNm53QjRJZlNpancrNVhRRE9Y?=
 =?utf-8?B?NVZHVEh1L3d5dDdzVzI5aklzcnVDVitSeHdWckp6R2IxV3FDYWV0cjVQQVFP?=
 =?utf-8?B?Z2l2Ulg5Q0VETzBFM2lDTmhGeVVjZmtta3pkaGRBaUdXZytYbjFlQXNwcmdh?=
 =?utf-8?B?c2FDVnZ0YThvMnN4eFFHVzY0NEg2WExnQ1R4d1NVYUx2UzdSdXlWVjV3cFZ1?=
 =?utf-8?B?RVRoUG9xLzNRaTJXTXpTZUVLL1ZNUEdQV0p2UmlEVE9uUm9NdUk0aHA1ZHAr?=
 =?utf-8?B?MCt3NzJrVk1BWmIvRWgxV1gwdGI4QUhzRWRPMmZFTHRQUDF0WHhUZkpObTRB?=
 =?utf-8?B?L3hvK3M1SjFWRll3UWYvM2ozbHRtYXBkRnE4MFhLL3p2dnNPemY1cHk0QWF6?=
 =?utf-8?B?dHdic1JPcDN0RFI0c0ovTUxvWjdEbGZXbFRjaTJSR29YWDJJMHgvY1lWTks0?=
 =?utf-8?B?SVpzNGZzaUVrbkhlcGJIeW5CMC9OYzQ2Z0hwci9VMSt5cVpEM0FxOFZEZGl0?=
 =?utf-8?Q?opkogpoF0xvQu5YdKFzisS2BEGLpDG5E?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bnFDdHRzUUdtRGI4WERRMGFCckpwS015VjlhczNRR0U3dFZ1Q29hZkM2VndH?=
 =?utf-8?B?SmE1L2JRRTVySVMycW4reC96VStKTjRlVnU5NHFpVDBNcHB0S2NpczhpQUFz?=
 =?utf-8?B?MnpRY2lObHB6TGpLZnpnaTF3T0s5L1hnRnZtb2ZnRVl3Y1puYWc3ZUZOOGJP?=
 =?utf-8?B?QUxMaGQ2enhtanpBaGVzOEhUc1lFMWlnUjBmU09HMEhXVncxZHBMVjd0cVFr?=
 =?utf-8?B?VE5sWnJqWHN1V3YxL3ZGb1RESWxFanRtb1I4cjNVSEFzSzZHUm9LLzE2eDEv?=
 =?utf-8?B?bWIyVEJkRFl2eEdEL00yL043UFdYaXdDczVkYldVSzV6blJleS9RL0tkeHcw?=
 =?utf-8?B?VTdHMll5OEJ2bDZobHpnSkNocFJWOEpSeHZXbDZGVERBY0hKVEVPUHhZU2lH?=
 =?utf-8?B?SGpDSmVkK21EUnl1RnRPM1lJMUR0S3ZRMlhsQjE1czNkdzZ2aHRwbkkxVHdt?=
 =?utf-8?B?U0N3M2Vkb2laQkhhYlZQbUkwWEQ4QzRnMW04bFlIY0xrTTRRbHhGbGhnVTlN?=
 =?utf-8?B?S1FWU0pCdFlZRlJTeXc5K2d4b1BOTGtQWERIWmc0cXlLS2xkaGRkZElHcVhw?=
 =?utf-8?B?SkxRSXBkQ0x1ZmxtaW5xLzlWcnlCbFkyZVh4czdpK09GcTJPU0pCQ2cxY2dP?=
 =?utf-8?B?TzJXYy9UUzJ1eFRLeFRTN0NVSXgxNzRINGhmVjBEaWVZdlo1RmlTVzQ1MmRW?=
 =?utf-8?B?eEVrdmRCZkxzMllROTV2eDU3THoxT3JxUmt0eHM5L2JJNi9LQWRFaDRCYktY?=
 =?utf-8?B?Wk5GdVMzUUIxcis5TDBsK1RDaVcrZW41MUFwd3JHTGVTbFRyZ3RPZWxlc3BZ?=
 =?utf-8?B?T1lDUi9MMjZoN3BkaFFXMERJc204ZVptdzFnZ29GNXFFL25qREtURFZUbjlI?=
 =?utf-8?B?RnEwMy9peE50dTkxd1JqZ2ExcHBHNGFSc1hxbWV0UGh6RWM4SXlXZjY1ZHl1?=
 =?utf-8?B?cmlYeUczeXkxUDFsU0FLVXhPMFpxZk5SaU9Fd1V4aE93c0xtVHIzZmRYTFho?=
 =?utf-8?B?ZjQrT3RVQ3ZhcUw1SjYrOWJGS3I4eU9HLytWOG9UTUd0TWFoTVkwakNHTkZD?=
 =?utf-8?B?bE0xeHpJamtTbFAyTzR4Ymh0aFp0QUR5UXYvNzVqNmwwTWRxaTQ0NmNYMFMr?=
 =?utf-8?B?NXlnNGJPNkE3SG4rZXZGbHNnZloyYWZpQTU0WE9CUGRmOGdFUXJlbUJCQlpy?=
 =?utf-8?B?SUdINmp2ZjBSRDNlZEhGL0pLSE9kRFFxQVNYV2hTd1U0ZHpzRGRoUkJnb3F4?=
 =?utf-8?B?d0RHeHpuYnRZTlAxR3pTNXd2RGZ3VkVrMnIxUHl2VlVieEFCNnc0TnV1akll?=
 =?utf-8?B?b2dHVnZhU3VQeVhUSUdaZFhJNnBKS2Yrdy81UFp0N21FT3dUVFU0UEtaMDNp?=
 =?utf-8?B?YzJuWGxxbWRGTW9OSVViUGhublB3MHFKaVl3RjFqb2wzRUFxZ2Y1a2Z1TVdy?=
 =?utf-8?B?azZDMG1DckgvUFo3NUxySnhIVW45T2hDaDhPNEsyRkFxZktUUWNPbklyRzRw?=
 =?utf-8?B?MmdkdUVlbURLc2RoVHpCRUZsVTFsQmtYZk55dlBjbDFPWkJ0RXZxeWtybTc3?=
 =?utf-8?B?VVg0M0lFMVh3azNCL2E2T2xkMGtVUXVYaG9IOU5pN3AzWGJYQWYzL2pYRUZK?=
 =?utf-8?B?cFBWMnRPOHRVbnZJbndITDNCUS9SeVp4L0dSc1pzT1NnYUJ5VWZGUkxNLy8w?=
 =?utf-8?B?UURJeTBWV2kzRXRYQlhjZkR5NHJ4b29TRGJLQWw0SytlRS9WcVBOa0ppRlhO?=
 =?utf-8?B?UnhDa2NTNXYyUDRHaWFXd09QcTd6VFAweVlkekNqeFNCRmpTTGx2UnhvVzZn?=
 =?utf-8?B?M2pMNmQ4ZlZRQVFkT3pLTGRZWUNDNVNoMU14TDlhUnBDTk01QmdRUDRJb3NB?=
 =?utf-8?B?SlBKWWwvNDBCdndyM2h4Y3NySm1rcVZJNU1BaCtFeFU4QVZrYVVuSm5kTnNz?=
 =?utf-8?B?ZUNwNG9NTm9XV2s2SkpGdFJuWHVlbC9lMmlFQ1FUdFZvYXY2TEEzRGYzS1hr?=
 =?utf-8?B?M0JGVFVJVEVxMmZQaUhHaWdSaEdXcEgvYWtPeks5aTl2U2xXZFdmRXdhT0Zw?=
 =?utf-8?B?NlFIWFFQTnYwcVdrNTNQMWVxa1RQeTduVmZXckxJYlVSM0ZLdWRLU2F0YXQ2?=
 =?utf-8?Q?/qbyLdT41+kej0e6tPU/3c6GS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5/mJENqgLr7eou9NmMRkQxIrw59Cz4o3bttj/7POwpXNEAxLteUe+FaFzCjZr4yPOIM3KC9tpb/W9186AoBaAkEqC3rZ+lr/RUKxVZZV80kWrQuDr9yDRIYgnwj4ak7ivCeJOUk07RE/ykDKQy+Ysvyqmya6YfYRzz63A0S4dSGGHOmTutcAJUcQnk9Mb6oDLd6MnMx+GoyCaipxBYvVjckCNXLj6MLU3K+JPAvMmXLVA0Sc/QJqf+6undDcOYRm+PVmSTCjBK5O++YXkxHzP1AJ6YRd67Gw8knPCR4PnT7Pth53tn+E1iwz0Vgns+g/0jzcYVNxj6SDr25+OaMgKiqxzTf1PaX0xGkTlrueqGrocWAufl4fSZALu81lr4oS8vDg0TlqbfGHiTImGbCpzaP7Z1l+YBmjiXD4gojJbNt7y9iafdYXiF0H0lCD27pk2SQHmUmgHujA3K5J+BxaVbFrF/dSqj+eSlMMx0OB2DZawCHJzWSn3MrbygTmjEgckpSskXmwCy4FY4G9OJbYB1hbdSJBgS3Cu8LfDeEA3qgfJnmN231VfOznGaT5XdwN338cslPlIr/GY20tSVz9IH3+1jqlZNpVIgzE8TWZy/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bef693-3b4e-45db-7fa8-08de1e1356b1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 15:35:54.2454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qo5EBT76aDOXFhJhx88U4JLlRfa6V+MF4+v8cA7KGY8C/M3NTUmcyQKxgbWEu6Jwt+1DUUMN+wLxp4FQ5Fc7IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=692
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDExOCBTYWx0ZWRfX+wSU90kT4NMm
 8t8ul61DAX85G6RnNdrAcUM8SR4PpSsjCwradtdiUfcHTnpazzoIMuN3n3cMaD2ABfKiCFNun5u
 MlT6Dr0Nvd8MmBzdSXy2CFk8Bt6NJliyCSJf7N+UiGOENfhm+8Xua/WHPbsvJkwljgf5vXIr73N
 Dj6pOaMznjFVvQH6W5N7irfUDoVlz72psYQnBAUzUAggClzrCP2EmECr0AIdMVzLOL7F2papzsp
 qk20SWVJf23Q76iBP9kkiAX7cF05zfXUxLdxQD4/5bxNwuQGnNxyLR0Q+E0mYfEwvKfROVgPdP9
 zzo3xW0AXxaBNAafOipksHgj4pkIT/6XVhJX779as/B9On0T2bAdlQ+rigORu8a4ntGB9skLBn3
 Iskb7kKpKv5q7c1Su6r1lrUk8KVAaA==
X-Proofpoint-GUID: AaguK4JMAeA1rT3yC7DA0SS7zOL9KXd7
X-Proofpoint-ORIG-GUID: AaguK4JMAeA1rT3yC7DA0SS7zOL9KXd7
X-Authority-Analysis: v=2.4 cv=Utpu9uwB c=1 sm=1 tr=0 ts=690e11de cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jUpwvIwzBoSS2QEGv-oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On 11/7/25 10:34 AM, Christoph Hellwig wrote:
> On Thu, Nov 06, 2025 at 05:56:32PM -0500, Mike Snitzer wrote:
>> OK, I'll take a closer look at NFS client controls for stable_how,
>> because NFSD clearly handles NFS_DATA_SYNC and NFS_FILE_SYNC so I just
>> assumed its because the client does actually send them.
> 
> Asking for NFS_DATA_SYNC / NFS_FILE_SYNC for O_ЅYNC/O_SYNC writes or
> even fdatasync/fsync calls that translate to a single on the write write
> request would be a valuable client additoon that should speed things up
> with most if not all servers.
> 
>>> And as I said above, "no plan to merge it for now," meaning it's still
>>> on the table for sometime down the road. I have some other ideas I'm
>>> cooking up, such as using BDI congestion to control NFS WRITE
>>> throttling.
>>
>> Hmm, I thought the BDI congestion infra got killed (by Jan Kara and
>> others).. which made me sad because when it was first introduced it
>> was amazing at solving some complex deadlocks (but we're talking 20
>> years ago now).  So I haven't kept my finger on the pulse of what is
>> still available to us relative to BDI congestion.
> 
> Yes, BDI congestion is gone, mostly because it didn't really work.
> I'm also not sure how it could have solved deadlocks.
> 
> I feel a little out of the loops, though - what are the NFS-level
> write throttling needs to start with?
> 

Let's not go down this path right now. I'd like to stay focused on
getting the direct WRITE work merged.


-- 
Chuck Lever

