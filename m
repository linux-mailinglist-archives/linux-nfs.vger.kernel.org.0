Return-Path: <linux-nfs+bounces-13515-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1628CB1EE1C
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 19:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC215A35C0
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 17:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD661F76A5;
	Fri,  8 Aug 2025 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hITfbcOP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XldVSQid"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26C5CDF1
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675929; cv=fail; b=KblVVMzrmQHp14r3M54a68y3KUIUKt2xpK4kSAfAbSOry08UiF9xkZ7qow2A3DZBhES8QINUndW2QUFuqpk8PQFKX3ww1uL3SfiYjZyxBhAg1zUt0wPf+UExBPIrAyNzVh61sN98XDSPs8fpOuZpqIFVz2wlyUHJmiBhBKKYi1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675929; c=relaxed/simple;
	bh=719FYm66m9O0TjntZrVIdiBZpZJvtkVen8w9PFWZYw0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hT9G9wALBsnHM6rc2vPR7F8N4VC1NB4wRwTN/0RPZ39YiMh3bFavL3xNQd2uLdBqFeW6vyY5cbpkc63emVnfMO2e2Bm9PT6lWDaJDHnFCpFyDvrk7od47KROGbcj9V3EWDqL7l47gD+RYN1MkLzWAaHJ7quqVPCc7vN7jM15500=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hITfbcOP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XldVSQid; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578HvUXw002587;
	Fri, 8 Aug 2025 17:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=v6k4ayQ5e5dti2cq70JoTKoaJqoxL9f7a4X7ngZHKyI=; b=
	hITfbcOPEDyVNaimYebnxveF4KzFGv3HzYgz+qMOpLn7WKVv0XYSkjZcbGjfwbHA
	JMyUjKdcpUoWDKknSJ4bfnLBRZ+H7TOIkzg/veBlg1DEMqBacKelXTA/1uHFbL0y
	LlTpgxLQvnAyv30HuyYGBi0ojtaNAMC8JriKagr7x6DDHaO53jwdVFnPDrQTLdmd
	ADchSF2q7UxvBwxbv8wSxOGusIeU4HKmVcQlqdgMmNg+ITaJmFbiBRUHe+UiC3gw
	zkU13g0PlOvV6T/bprepIy6zeo27nLLu7cvp9CCqt1fQyCwsOI2aWICmQDGTzH8E
	+dAhuN5dFsubrCzn/ctCVQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvjxwue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 17:58:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578Gd636027112;
	Fri, 8 Aug 2025 17:58:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwr1de1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 17:58:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgG/esd2UIMtjy3FvernI70/Uf7wzR8908ub4zo+ir4xs2ZcPECzYuSWvU8cmTBZzUrxhW3E8vdbaLOs05gMlO7xk2IZCoDBVBHYMRd2WAfJcDzWiJfxFaUB0vy4ZiWE+5UHL+o+0xAjnrwJkf2v41YL6Kfa3O8R1Zqzqe6h77oheKbK3vyR6PPxXZ0/sVppCQwssIsd6M9n6rk0C3CpB0+sQ0H58lOJvaHHn6/nV7+eiljZrcQFw43+8aKydOsaHCKve/dT3AXTw9GImk58GB4o84LPKNG89M2/sov3lbYCbJPl0Eix4ms/7rYK7f1cy5F+wFeJx1mGn6/rJJ9TwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6k4ayQ5e5dti2cq70JoTKoaJqoxL9f7a4X7ngZHKyI=;
 b=LqY5IpbEHqZi75ftPjPyOYSGBPWmgcld5vsGT9uhciVAl+gu/gla25hZXBWlJL4ykV5i6R3ywJ2qv4sMawycvfphAYFisCKSE4KiiksWmnUCOyZFmc15oQ5wTdaiLkNArj0ayAYFphfKkHxozB6Px9Anm+cetCIEpzjENzkIR2SPds9bp6Ig1iHeDgODFNd5ishtNbIoBuZjzdlzxadVBdSCCzkk9lw6FuLqhLxnpE46vUNHDiRB5ggfe4xsnYe+cn+EO2e7qTNdZwtyHgBgjyV9bziBNlUfwIumcEi304PzuyNvTfLOLXYHZe0QhRLGensVeFkiUfe44O6ZkYDmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6k4ayQ5e5dti2cq70JoTKoaJqoxL9f7a4X7ngZHKyI=;
 b=XldVSQidhdmIL5gt9RXU5rTjmSYnGY68+ojQVk80+OI6dDyd9WL/IvITA/egUst0ncKjYRc6jgjJdSjskt4lZc0NGkyZ/eec26MVECjniM2kjid1dt5cyvJWrrCPzdgi/USFcexcb70KNm/fOcSbt4nJ4lG607edg8KSM1zB/0I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ5PPFA634C6E92.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7be) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 17:58:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9009.016; Fri, 8 Aug 2025
 17:58:40 +0000
Message-ID: <6a37dbfa-8a27-4eee-bf7e-154c7f0049cb@oracle.com>
Date: Fri, 8 Aug 2025 13:58:39 -0400
User-Agent: Mozilla Thunderbird
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 3/7] NFSD: add io_cache_read controls to debugfs
 interface
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20250807162544.17191-1-snitzer@kernel.org>
 <20250807162544.17191-4-snitzer@kernel.org>
Content-Language: en-US
In-Reply-To: <20250807162544.17191-4-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:610:57::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ5PPFA634C6E92:EE_
X-MS-Office365-Filtering-Correlation-Id: 439b2703-667c-4e06-6324-08ddd6a53508
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?S2w5UldTL042RS9mUnNzZmZkOWg0eFJDeTF4NjZTSk55UGh4cDBzUnFjS282?=
 =?utf-8?B?L1haOFhibTR6S0NYU092OHpiRkd2UFh3SHQvczlCOTNTdUVldHA4TSttQzZr?=
 =?utf-8?B?RWMwYzQrdVZMVzhRTGVVZ0VnckoxMXlxSHF3SUJBQm04VTRUMzZIbTNCNXNJ?=
 =?utf-8?B?anFTaWx1NVpvVy85eWpIOTFqRG5hd3hONnpsMGRQVWU2bkV4bHgyZUx6S2x4?=
 =?utf-8?B?WGRsTlJWUVNwbC9SeVkxc3dFajJPZmM5LysvckZoOFQ0M0ZsTktYM0hsZHph?=
 =?utf-8?B?YS8rU0FTYnBCSkVlWUVyVTNlOEttZUJsWTNYREZnbDY0US9FOGxRSG16YmJR?=
 =?utf-8?B?VjNKNm9yREpVSXMrYzNvNzdvT2dmL3ZUWWFaQlh3OVA4Q2JEOUptV200eU9r?=
 =?utf-8?B?SDY4NUlwN3RRMVNnYWpqNmNiOGhWQ0VyR2pRbHJlRWFXVnF1YzVuaHh3WjNF?=
 =?utf-8?B?eXVhY2M3OWVwSEU4eUZVSWovekpaU2c4anJ0c0M1eW01SlQyU00yVDVUKy9t?=
 =?utf-8?B?dmhlZ2hqcEhtKys2UHJEMitXc2VZZVA0ekdReUVQdlByVW53T0RVUHdBektS?=
 =?utf-8?B?YUZyY3BTZ3BpTlVkNGR6T2dMZmpiUzVwRGNxRGhNY25VOXZZZmkyTXMzY05L?=
 =?utf-8?B?LzZpc3BGdUJzZWJNNitrK3dNRC9wMHdLY2hCUVlKa2xWQ3I1QWUySDE0MFZD?=
 =?utf-8?B?UmFVQVJ0c2w4S2R2NnEyQVo2OUgzZ0pORHl0VUVNQTdOS2ZWVjRxS3NDNExw?=
 =?utf-8?B?OVRaL1Q2T0hlWnVqRzhlNmRzWGFpQWtieEtVNjVTeG9zaE5MMEV4Y3k0N2Mv?=
 =?utf-8?B?SzdTYUhqOEljSmd6TnFLdnpud2N1cjBWMVNQQXVOV1A5bXV4Z2o5SG14U05I?=
 =?utf-8?B?bktLV3k2OG5hTHM1eGxkc05MZkY3eU5MdzNwZ0dIOGFIekk4ZDBEcDhDSklS?=
 =?utf-8?B?SElKaWNGM29mUDlHeGIvZXRBZHZSUDdlUEV1M2o3dEN5bitTOSt2NUdwcDZU?=
 =?utf-8?B?NmJzWHRPUm8zZkdiZE4yRFF4TVJab2hUb1g2UWlMbkFManlMTDA5UzJQalI4?=
 =?utf-8?B?SENCa0ozRXBRRmRUbHlsOUEySk11M1RzSVQ0d2M2Y2ppOXBmSk9LNUFRMTBO?=
 =?utf-8?B?TmJQajVzNXl2cHppYTBNMnpzVVRYU3VuS2hMTkdza0RKZ2FlWHVXMXJlNWsy?=
 =?utf-8?B?cy9Rblg5K2pmdDQrMDh1SUlLQlFrbjdmL3BITTA3TU1Da1ZTWSt2TEdDenpw?=
 =?utf-8?B?cFlNelFNS1R5WmVYeHJoRXpSL04zZTRkaXRrcGRWcEF4cjNOVjVhemJXd2oy?=
 =?utf-8?B?c1hzZVNZTGZKcTFOUUIxOUR6YWQvYlBER3E3Sm5zeUdyWDBDSWJ5TXhCYmNt?=
 =?utf-8?B?dUZWRis0SWVoWXB3bmlzVFJnTXB2TVdMZlI2a1Y0ajdodGtBN2ZtS0xDNEVt?=
 =?utf-8?B?NkpuOUwvdzhwOWlTdUZGeXJzY0tDK0lwVGZ6VmFTclU1QnBKcDdPelR3TEFG?=
 =?utf-8?B?TFVaNEpzQWZpeWVsdzhmTzNaUHo1cEZLSDNMbFg5d0RIMCs3YzAyNEJ4RG95?=
 =?utf-8?B?a2ZEaXBmSElKZUpRenBySDM0L1poeDBpaFZRa3FBakg3aVp6RDN6V3VURlk3?=
 =?utf-8?B?RStoZW4zRTJzRjgvUzJzbUR0NlZZWnNRZW40TnBXcmVaaEVDdUs0Q0xESkE2?=
 =?utf-8?B?SEZJTDdWcFdaak1MTWxmekJyQWJqRzA2RGdpY3hwa1dkUHNhZ3FYdFYzQlJN?=
 =?utf-8?B?Z1lQZWtiVHVzVlpudU5vRndUV0Y5NWx5MHBUbXRWVkxYRTNMYmV2SDdFbXB1?=
 =?utf-8?B?elJFaWtpallOaGpKMnUvRWhDUVA2L3VBR1RPQkxJbkc2di9mdWt4MGg3VTV1?=
 =?utf-8?B?M2QxVFBLZXVqWngrZEhkYlZ0SktaaWpYTkUyNDgzR2ZKYkE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MHBKaXNhYytTL1lLU0lPbjltN0RwS29xQS9OTXBCa1BKY0t2MmxBakdYSHEw?=
 =?utf-8?B?TWR5OUdSVXdKYlZPV3VhR3BPbmpBUzgrUksvS0traFJMQ0lpeE9XK3l5SXNS?=
 =?utf-8?B?cUpEMEZnQWdoR0tlMGNPbGluejZWaWxpNCtFTVVTVTZBR2tuUmxnKy9HQ3E1?=
 =?utf-8?B?UG5KWVU2TldmRDVrdnMvZllCZGthVU5mOWpzUXFsVTcya2dWR3M5UzlsRE16?=
 =?utf-8?B?Mm9QNEEzcXlYaCsvSm9ydnhaSktsWUNBWXpybXFzcjlaN29LRFBMTGI1TGIv?=
 =?utf-8?B?cU56b2lQUkxjbWQrZ2tWWFd6Y0J4YWFvdFJyK3hSajVCeU9uRGRYaW01cFZZ?=
 =?utf-8?B?MmZrOER4UkJBM0c3em53dnVNTDArTzhYcHVsTmYrMUlVblVZRVRZQ2pLUklH?=
 =?utf-8?B?QmROTFRhRm13S0lFYjhxTm5kdzJML3lMWS8zZnVDZXFVa25ES2lGMUhOejBE?=
 =?utf-8?B?K2JOQXQxd2N4NnhTOTQrdzBHaEZwUXRHM1RsZVNBWVR6M0RZMXMyWjVoZDM5?=
 =?utf-8?B?VEhtbjlaYjJRUGtnd1JqTTlmQzVpOXVJa2cvNCtGRlhNaGVhQXBjRHFNQzNU?=
 =?utf-8?B?MUw0b3NqVmhuZFF4eUNFemFBakJjMmU1Y1VjVnVGUTB3WWgvNXRFL2hCSlZs?=
 =?utf-8?B?Y1B6RU12SXFIOXUyWFpYaGJhRjV5U290NmJnY240UmpJZjcrdFF4Rkd2bldJ?=
 =?utf-8?B?NkozVDFRUEFCdHVPVzZPYUR0aGhPbGNXTVc1NFIxZUx0WUl1Q3hNY0NqeGJO?=
 =?utf-8?B?WnA3ejk3Z3FhZzFmOFppWTlCekJ5clJvT29XeitIbXNXcTZaTHJEbWpnZHd5?=
 =?utf-8?B?clRyY1FBWExQOUtCUkNZWHlOeXI2aEJ6OWNXdWdsT1hkVjgzYzh2U1lJTUpw?=
 =?utf-8?B?OW11MS96WkZhSldWN2lIZ0dScXNSSGxaMjN0dUtPeW4zMGExanlGSlFpMmp6?=
 =?utf-8?B?ckNkOVVsYld5Q3JHdllVWUlEVzlCMHZUUDh6R1lIN2twemYrRS9HOEQ5RTli?=
 =?utf-8?B?TTAvNnl1cE9xYjgvWFB4cmRtNGQzcTJXUi82NU8wZXVwS0wySEQ0K1AxdjZX?=
 =?utf-8?B?cmVKUWg0cGhpMUFTM3daZnpSbDRCdnhKVmliRUZOalpUSFhSQUN3dWtiYmRy?=
 =?utf-8?B?aGhTTlIwWVpjZnFzNUxFQnJxUExmSHFIQ1Q3RTZnblI3eUJBTFc2UVJwalF6?=
 =?utf-8?B?ckZUNzlYVXFmNStzQlNuMVgzNXV0V3NyRXZBZ05yRlh0OURGT254SUR4YSs1?=
 =?utf-8?B?MmxFUjMyR0NWVEZpUUpOWDVFUmNCYUNjTFlwOXh1eE9rbktTZ1JWN1E1TFBa?=
 =?utf-8?B?cmRESGdhV1BHUGlKdCtiSWZKV1RqWkJuOUdDSGdBNjNJUkdZbXpJVVlzZXZi?=
 =?utf-8?B?eUphazJTaFI4Qis4QTRuak1vdFRLVVRURXNuK002MnIwc1QveitvWHZDOVhi?=
 =?utf-8?B?UEUvZUVPOXYxQkRFcVl1cENMUkk3UXVlY0loSkFuUS9iSFJ6dk9JeEFYek5s?=
 =?utf-8?B?ODdmcjYwOEJlZHd3WFdHT1c5bE84bkg3azR3OHVwMUwzRXNwSHFReCtmZlho?=
 =?utf-8?B?MjJ4eHNpaWtoQysxaDJtK3R2d0JuOHJuWk1nQ3pOY2VrSHBDVXB6aU5SY0RY?=
 =?utf-8?B?b2VlYmt6SDgxMzlqMjdocjQ3dklLVW9INVFkcFVsRkNReHVvUytHWFBreFpL?=
 =?utf-8?B?dlBUSCthT0lTU3U4WXRTTWlPZGVUNkFHajBNSjZpNmNZLzlpcnRxVk5JL2R0?=
 =?utf-8?B?bStvL2Y4NDJsMU9iS1ByV2Vka3VRMXRsYitrR3AydHVyTmhET1Z1YzFpVHlt?=
 =?utf-8?B?T0E1WlFFQmlYSml6VDA0M2huRmVaYUxFeHNaWDJyYUpHbzFCdzMyOFVqQmEr?=
 =?utf-8?B?eDJvelNlQWtpQ2RlRFhqWEVNZzVyQ3dKajM1cDR3a3BJV051QmZNWm9kTG12?=
 =?utf-8?B?NEY5cnArcVFuWm4wMDBqblRxVkNLQ1AwOFJvT1ZSYzBuaW1yRHdGV1RvQlpx?=
 =?utf-8?B?Y1MreE8rdE93UXpNNHF1STVuT0pBUHkzdStKS2ZUbUtFblZjM2RreWxNZDJz?=
 =?utf-8?B?SWVJNm1IanFiT2x1NUlDQVNMdm9XUGx0Vmg2K2pSZFc4YVFaMkkrZEVyOHYw?=
 =?utf-8?Q?+Z+OtIj+9gVkmVkC3Uxh+jks9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	02JRkUGocJkHzaXzPghZo7Q7mOxeD/pZppjUuo4bDf1qBlLzOQlHfgdLfvFwJFdUASWQHfhaFf4rJ4fNly5HzvbMmilqa5jqlk/jan1G/SYSmo3yH08vIcQDRZzx95ims1AocwTzJMRAtHP8EJE1w2WQ0IuPVp/fv4GjLJg283wQtuRv2TwvqOm5Fw0iGT9Bje291tdDeso0lQDOYgXBkpggyZ5eXM9c60I7dvvzv0sAm6wQqybLN1EU0TTIUI5965xrjGem2uFPqTZfUDA+tRuVx8kfFEsRShOM0Drb7xwfhQwn9yroSM0dM7S6pxQ2Ho8mR1SgEHgk2rc3BdDE56RbYnzMOP/Q38gMIbSMTL1qS7uwGeY5tgVczPAHVL//At65CYa8ESaAmrKK3ZJeN5AufyGWKxkhUrO9XP4HsPP1DtFjYubme0mC/40rEZ8pK2CEL9gfCsvYlPmdpKlS4l9wgIPRy/rTiy4m1sRcNZ+X/c02tIPG0Yrtc55ylHthBwXvuwmaqVmZsh98Otd/ZDQWWGle0k+D3oDzUralnf6g3OIIirlsmPnLFKg1vAR2vgjsdN/i/zKgRfqLB9G+ESzYCRatnryVVpyeDHtr8/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439b2703-667c-4e06-6324-08ddd6a53508
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:58:40.5921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcjkIFl0f6PpCtH8SOSsgLppDv3YsqT0LoR1l9apfc7/BntvE7Ye90vuaYNFnjh323ZqpVCiMcOBSt1BZUuz8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA634C6E92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080146
X-Proofpoint-ORIG-GUID: WsygL8bakofXGYw0Y_misG_C--T8yLbv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDE0NiBTYWx0ZWRfX8+zzGUCRMoVI
 fpRm4PW5XhUUvllRNDmXhPMIpD3l02sqSmQmdV8+344HRn0+v2vdDzzkK0dDy5+Is2fbcgaXMB1
 K7zLOV7K3pBez8nxbGhA3ewdtgfPFvQoOuLDNE94ry0knP0Xi62UBdosnQ4BLeYeEPt9mD/YIMJ
 mGdcaOSsDell0xZTdMYdMASN8SUUcnEnFoEDAAviKCKt71+ULcP0PxCovwvWSUk0f3GV4ykh9eC
 z9cAGM6rLLZAKNkUDpiNle1MMDNO7qXB8GZWIHz9dPzTa9zc9O0nriCu3q5Y5vrW1wXbfU/695r
 Ct5EBx2FKLk7HMMW2P4jN8qjzwxMlVY22OB8/g6XkM+FmClWQU79wZa1uXZe/nfTBccKD7hS0k/
 Gcxxq1D+25JHIpXk/NQzM0lRgIrvTnQRDaFVStQhJkq7crgGpG4BRnJz3EFEP+FxhduZo07L
X-Authority-Analysis: v=2.4 cv=dobbC0g4 c=1 sm=1 tr=0 ts=68963ad5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=zo9pqF4ySYuyIBEvR9QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WsygL8bakofXGYw0Y_misG_C--T8yLbv

On 8/7/25 12:25 PM, Mike Snitzer wrote:
> Add 'io_cache_read' to NFSD's debugfs interface so that: Any data
> read by NFSD will either be:
> - cached using page cache (NFSD_IO_BUFFERED=1)
> - cached but removed from the page cache upon completion
>   (NFSD_IO_DONTCACHE=2).
> - not cached (NFSD_IO_DIRECT=3)
> 
> io_cache_read may be set by writing to:
>   /sys/kernel/debug/nfsd/io_cache_read
> 
> If NFSD_IO_DONTCACHE is specified using 2, FOP_DONTCACHE must be
> advertised as supported by the underlying filesystem (e.g. XFS),
> otherwise all IO flagged with RWF_DONTCACHE will fail with
> -EOPNOTSUPP.
> 
> If NFSD_IO_DIRECT is specified using 3, the IO must be aligned
> relative to the underlying block device's logical_block_size. Also the
> memory buffer used to store the read must be aligned relative to the
> underlying block device's dma_alignment.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/debugfs.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfsd.h    |  9 ++++++++
>  fs/nfsd/vfs.c     | 19 +++++++++++++---
>  3 files changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index 84b0c8b559dc9..c07f71d4e84f4 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -27,11 +27,66 @@ static int nfsd_dsr_get(void *data, u64 *val)
>  static int nfsd_dsr_set(void *data, u64 val)
>  {
>  	nfsd_disable_splice_read = (val > 0) ? true : false;
> +	if (!nfsd_disable_splice_read) {
> +		/*
> +		 * Cannot use NFSD_IO_DONTCACHE or NFSD_IO_DIRECT
> +		 * if splice_read is enabled.
> +		 */
> +		nfsd_io_cache_read = NFSD_IO_BUFFERED;
> +	}
>  	return 0;
>  }
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
>  
> +/*
> + * /sys/kernel/debug/nfsd/io_cache_read
> + *
> + * Contents:
> + *   %1: NFS READ will use buffered IO
> + *   %2: NFS READ will use dontcache (buffered IO w/ dropbehind)
> + *   %3: NFS READ will use direct IO
> + *
> + * The default value of this setting is zero (UNSPECIFIED).
> + * This setting takes immediate effect for all NFS versions,
> + * all exports, and in all NFSD net namespaces.
> + */
> +
> +static int nfsd_io_cache_read_get(void *data, u64 *val)
> +{
> +	*val = nfsd_io_cache_read;
> +	return 0;
> +}
> +
> +static int nfsd_io_cache_read_set(void *data, u64 val)
> +{
> +	int ret = 0;
> +
> +	switch (val) {
> +	case NFSD_IO_BUFFERED:
> +		nfsd_io_cache_read = NFSD_IO_BUFFERED;
> +		break;
> +	case NFSD_IO_DONTCACHE:
> +	case NFSD_IO_DIRECT:
> +		/*
> +		 * Must disable splice_read when enabling
> +		 * NFSD_IO_DONTCACHE or NFSD_IO_DIRECT.
> +		 */
> +		nfsd_disable_splice_read = true;
> +		nfsd_io_cache_read = val;
> +		break;
> +	default:
> +		nfsd_io_cache_read = NFSD_IO_UNSPECIFIED;
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
> +			 nfsd_io_cache_read_set, "%llu\n");
> +
>  void nfsd_debugfs_exit(void)
>  {
>  	debugfs_remove_recursive(nfsd_top_dir);
> @@ -44,4 +99,7 @@ void nfsd_debugfs_init(void)
>  
>  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
>  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
> +
> +	debugfs_create_file("io_cache_read", S_IWUSR | S_IRUGO,
> +			    nfsd_top_dir, NULL, &nfsd_io_cache_read_fops);
>  }
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 1cd0bed57bc2f..6ef799405145f 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -153,6 +153,15 @@ static inline void nfsd_debugfs_exit(void) {}
>  
>  extern bool nfsd_disable_splice_read __read_mostly;
>  
> +enum {
> +	NFSD_IO_UNSPECIFIED = 0,
> +	NFSD_IO_BUFFERED,
> +	NFSD_IO_DONTCACHE,
> +	NFSD_IO_DIRECT,
> +};
> +
> +extern u64 nfsd_io_cache_read __read_mostly;
> +
>  extern int nfsd_max_blksize;
>  
>  static inline int nfsd_v4client(struct svc_rqst *rq)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 79439ad93880a..26b6d96258711 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -49,6 +49,7 @@
>  #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
>  
>  bool nfsd_disable_splice_read __read_mostly;
> +u64 nfsd_io_cache_read __read_mostly;
>  
>  /**
>   * nfserrno - Map Linux errnos to NFS errnos
> @@ -1099,17 +1100,29 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	size_t len;
>  
>  	init_sync_kiocb(&kiocb, file);
> +
> +	if (nfsd_io_cache_read == NFSD_IO_DIRECT) {
> +		/* Verify ondisk DIO alignment, memory addrs checked below */
> +		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
> +		    (((offset | *count) & (nf->nf_dio_read_offset_align - 1)) == 0))
> +			kiocb.ki_flags = IOCB_DIRECT;
> +	} else if (nfsd_io_cache_read == NFSD_IO_DONTCACHE)
> +		kiocb.ki_flags = IOCB_DONTCACHE;
> +

Personal style: let's make this a switch statement like it will be for
the write path.


>  	kiocb.ki_pos = offset;
>  
>  	v = 0;
>  	total = *count;
>  	while (total) {
>  		len = min_t(size_t, total, PAGE_SIZE - base);
> -		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
> -			      len, base);
> +		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++), len, base);

Nit: changing this line does not appear to be necessary.


> +		/* No need to verify memory is DIO-aligned since bv_offset is 0 */
> +		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) && base &&
> +			     (base & (nf->nf_dio_mem_align - 1))))
> +			kiocb.ki_flags &= ~IOCB_DIRECT;
>  		total -= len;
> -		++v;
>  		base = 0;
> +		v++;

Nit: I've actually measured pre-incrementing to be slightly faster than
post-incrementing, so I'd like to keep "++v;" here.


>  	}
>  	WARN_ON_ONCE(v > rqstp->rq_maxpages);
>  


-- 
Chuck Lever

