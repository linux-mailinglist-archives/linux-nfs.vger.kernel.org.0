Return-Path: <linux-nfs+bounces-11436-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF4CAA9479
	for <lists+linux-nfs@lfdr.de>; Mon,  5 May 2025 15:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BBD189B148
	for <lists+linux-nfs@lfdr.de>; Mon,  5 May 2025 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8AF1A2C25;
	Mon,  5 May 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PyToIunY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jZBap90m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552F52AF1B
	for <linux-nfs@vger.kernel.org>; Mon,  5 May 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451547; cv=fail; b=qR/z2QEpF6j4aIOEoxxQZqEk5H5Iu5I6L2KTyBWEoqbmFYHGJB2DNthBKMauxqMYu6Gb8QqeFI97dANiBye0fidIg26qMHfcxX7/KbS7oFOigXDlwlEFn6leRTHX+cBSA5DTWuC6OqwjHImmxkCH0arr8gh1Qo0ZyNEpiawlRqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451547; c=relaxed/simple;
	bh=U23uu4QT2ndl+8BqGgV8Dlkj719DquSgC7SYX78QmHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XbCD/2MQC6LB/OkNuWbjMfqV1Xdj4H4fnJTkTlmAx7BfO9bjWLxqa3Js/sqgk6hJTnZgnHUJadbO5JFr/GmHlTxqbEIrTWL8ewrMLvnkXONXevTG0swGvA9aCkdRsuAATpO0G5plwGZoCsdWecAgpn7fHSKF62jbwCd5+ZgYRSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PyToIunY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jZBap90m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545DHCVT024638;
	Mon, 5 May 2025 13:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ljFavZfDyyYMYbGnrCttB3fMCXqEct0KXACvhxq2YNM=; b=
	PyToIunYY2K+Kv+38rxWBZsPCmB7d071JDmkK2v1y+p0BQ7bAyTS/PeHCU0Q9FKB
	Ex1H+EPL3GVvcG+uf+XIyVp4++9AHEtueNfFf9kNMm+8knovQi/8m+NBTdEVau5F
	lJ9H+ewuOx63e+nnyYykljRtSm3AjYHybChYzA+BIh95Bxvy8k544yXd+P9Zkrn0
	F+IiWnuHMwWOY0fvZDSA0S3fv3xcIwC6epa60ATCTHAOkWEZdsXomOWljbKi4zeZ
	GmakF5WUcSatz1hHgNb019UXktW7VCBDQTeB/dmLySc8mZY9OIefwD/KqWh0IbVN
	mg/mPjNPrSJI3o6YfeFF0Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ex3100gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 13:25:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 545CjcnM035264;
	Mon, 5 May 2025 13:25:33 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011026.outbound.protection.outlook.com [40.93.14.26])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k7p9pb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 13:25:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umClunU1pv+17AE78eGd4MRD6FWMUBAFScAK2Bmx9QotEUiBgfVjAph2bp4QZ0bJiRIlLEiUuVZ4vMI9RLs6dGG6IesXVTPs8Kw0As26AOIFMhE0nEMnMqvGdhB8OZDHZ5G72wl0VCcGN1/4WWUld8ml0Oyc0lhMOIAzYdJnfJElp2EXY/uwvsZqLFfJhjOa8x32BMpsJgsRT/Tf8Jfb6aGM96/0aSyOVuYZABiCPI5f01EBOKf/aXUfu5gjqIBw9QE4oW/7N1UpwXqrNSbMqKG0DQpzyJFpdzRO0x6/kqne7YIeowr69Tb+xcEuxnZRFYUksfmosdutSz0sawhjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljFavZfDyyYMYbGnrCttB3fMCXqEct0KXACvhxq2YNM=;
 b=nfWf29nn/NtjjZZHgi00w1bpTU4yJIHBTD3nVnEcoayJJR1V9CY0fJJGDw20q+sqSijWZ1K/YUTgyiCTTKXuukh0utqd7ThsynaaOxIpMP3gTSvkNV73hhJoeFIuOvVUguGp7dKNszzw8xdignZzIB+qIBvUJ+e9dDwRUxyjWqbR2pfoDuvpfE/UnQLbRvngiu3uep8V1/mWkoH92hB6qaeJC87jnbiMRaIT8krl/wbbBBxDhkoOs2XOUsfJ4vRrR/WB0xvdPGsdF3zHReofKcgDyTwO8W5w2tHTDa07DFKcOlyiBy4Sl1Xw0LGBsRf11YE9NMd7X8jtXh9FGurbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljFavZfDyyYMYbGnrCttB3fMCXqEct0KXACvhxq2YNM=;
 b=jZBap90mq15CNWGVOG1HBO/mZi56spu1cYVPlus3FbVA/cLgeGhTZnV5nuFXGz09j0/pH8EQFAmPT3EKLW5YsSTwB0ksXPhmR7JY3lDDaTJ8v4Tqo2Y1+iAa6aGbH8n7MX1C8gWX5M1fSOp61iC2xGy2Gvzn1zcUwZKh+6F0GCY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 13:25:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 13:25:30 +0000
Message-ID: <9489779a-e094-48fe-860f-7181f5d41223@oracle.com>
Date: Mon, 5 May 2025 09:25:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSv4.2: fix setattr caching of TIME_[MODIFY|ACCESS]_SET
 when timestamps are delegated
To: sagi@grimberg.me, linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
References: <20250425124919.1727838-1-sagi@grimberg.me>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250425124919.1727838-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0040.namprd18.prod.outlook.com
 (2603:10b6:610:55::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c57702-cd1a-4ae9-aa95-08dd8bd84e75
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MEpCUjRrNTBvTXJJTkNnd05OM04wNmpJallOQkptd2FYcDhpNVBzOUxhZ2hW?=
 =?utf-8?B?KzFnaTNaaGNiNGpDcVkxa0JCKzhoRkU5MzcyNFNWM0tkcDNYTVZ5cmZZYjFZ?=
 =?utf-8?B?eGd4VXZLcFR5bkdTdklTVG45a0F1aFB0c1gvaVkzR0NGNzAwc3JXU2VuMWFM?=
 =?utf-8?B?UmVyKzF4czZtSUZ1bVhySDhraHZYVmhwWkdTR211K0x0dk1BMW9Cd3l6dHZS?=
 =?utf-8?B?N0RWQzBCcVgzZEtlVDJGSkJhYnZMY3lXKzV6NFM0aXhiWUlQZ1k5eHRkdEYy?=
 =?utf-8?B?OUxxRG8wallIbU9raE5HK2hhWGttMjVpOWs5VVpLY2R0TmZ0dStJR0dhMEpK?=
 =?utf-8?B?ZXRLY25YNFNFa0J6cDlJWkl3TXJMaDdiellXRzFBcTlxN1pjcHNCV0dib0dR?=
 =?utf-8?B?TW5PUFdjdlRHNnJhT0w5b3N6OFJZWEF1bDJyd0oxRk9QWDZZdmxJOTRsYmpR?=
 =?utf-8?B?V2hjZUJaWlFSRU1EZzZGWkpFcml6KzdkNi9sSlZLZ3VsSGN1L3N3YjJSQWV1?=
 =?utf-8?B?TnRWOVJrN3RBR1BTQjJsWFRiaVd6bklLcXNnYUVaNjF6R3VMMjByTjB5aXZJ?=
 =?utf-8?B?WkdLc043dGFqS0JxU3JlTDFUd3FiQ0tzVU5yODdyVFNWaGFwMU9ob3haTlE5?=
 =?utf-8?B?NDBTMkcxYUhxbXdpRGNEc1RkR3dldm1abTBZYXFJSi81YVNFNHZQNmRuTy9T?=
 =?utf-8?B?QlIxSEtWMVdJNjh3VWlNdzFlSTJjNlA4UXJYQ3BoQTdNbC96ajFCbk5QaUs3?=
 =?utf-8?B?OTJjaHE3N2drdnMzZER6MGZPL2RGcnNvUEw5cjRORFpSWFlwOExsZ0NScXJX?=
 =?utf-8?B?MW5MWGpzV3FnY3Z2T1FKaExSNEVlUk8yWEhiYlVNTTlDRTk1OXhSMlI3YTdk?=
 =?utf-8?B?Y2dBMFg0Tk9BZDZUZTFzUXFPM3Z1TWVUbkZGdU9SZ01abTRTSFQycjJEWFh6?=
 =?utf-8?B?UzRoS2ZlZ290MHFLQk1LaEFwUlZBNk1aT21lanh2dE50L3FPSU5NUHVpTlA4?=
 =?utf-8?B?MWswWDVQNFF2eWJYN0haWDRxbHZ6K3RNTHpERjFOWGx5bkZ4NGNTckczRXdp?=
 =?utf-8?B?U1dlMHd1NGdmbTBDdS9HSEFwMnFkRFRVa2x3YWRNRWFSd0dheFk4SEl0Mjhj?=
 =?utf-8?B?RUtKcWMyZmV3UWJkRnBJMGMvUmF3Yndzc0xEUFlwYjV3Mi9pbW8rQlNVVCt0?=
 =?utf-8?B?WldEdzErNE5SenVuNVd5aHRYMnh2bndKNHZaRTNtTzVhZW95RWxoYUxWMmxZ?=
 =?utf-8?B?eUg0RDZwcmY2TllZbVo2NXFCUkM3NXBpYUZVWTVPWGZ1WFNlMHFTZHdodXRV?=
 =?utf-8?B?bjdZR2NwLzc0QUtuTEJwdGp2MW1tOWx3ZWZ1MUQxMXBQSTJ1Nmc4Q29XZkpY?=
 =?utf-8?B?Mis1Vit0SERBbGt6ek04U2hPT3lIbXd3S3VqU3FoTGY4MVBWZFUwUXVsWVlF?=
 =?utf-8?B?Rjh5Y0c0dEtYVko1M2NYQzZTUURib2hQOWtwRkF4Ry9KRCtRaEZrcm5lOHVU?=
 =?utf-8?B?R0tWa0dRbEhvbjdScFRDejRHaU82eFd6aUEvTG9HRk8wV3J5ejdQUkxLOHVR?=
 =?utf-8?B?QXZoc3JQSjd2cDQ0M0NHSVlJWE51elg1bTUwbEQrd2MxMGwwekN2RmtTUUNL?=
 =?utf-8?B?Q2pCM2hvRVprYlRTTW1QVUNHVlZ5Yk8wR3JKSW5VM1ZNREhJaVk1T3dJQW1V?=
 =?utf-8?B?UzRIZjRNYTNxTHUyNzlVZDFyS2lERC9DVFY0OVNJZ01GQldYZlJiNDVYNk5r?=
 =?utf-8?B?RytneWlSdVRkb2kxV2pKcklML0JkeUJCdDVVMWlZZHlZOHl6UGNhVEFwcXgv?=
 =?utf-8?B?NmVvM09MNUtYOVMyazJpVStZUkdxc05YdUZTVEVaMkduZmFwVjdDVDNuY2M4?=
 =?utf-8?B?alJ6VVhtUkVTMW1YN1k0UkkwNU1KVkRFcnZhMU9KQkh3VmpKL2VBbTJRU3Nw?=
 =?utf-8?Q?ANDAovjIco8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NUZpU2RWRUdWVGxKNXZaa3I2OXBjaVZWOUkyVlBhakZVU2tDU2N0dUkyODk0?=
 =?utf-8?B?RWQzUkY4OFZTN1R0eEZEQmV6TzJjcTEzbzFyTmpIcmdxOW5JbjNiL2hERlp6?=
 =?utf-8?B?NXM3QXhhR0hqUkI5WnpKbWNWamdQT3ExYkY5T3M3Y0FhZXJkcndyV0pUcHZy?=
 =?utf-8?B?cS9iYmVGb1I1bldpQ3UrcVZMUkFQQndNa0VRQkdud3MrZ0FabXgyeGg2YVQw?=
 =?utf-8?B?MjVBYW05MERZdWxnMHZuQ2lRWWUvelZMMG83L0Z5aEZTd3U0M1E2dEdDWFAy?=
 =?utf-8?B?SnNjbW1scTR4N3hMM1ArYXFjWEJmdldhWGZJZWtNWStaeVEyeW1FcWZnTXd5?=
 =?utf-8?B?UVJ6RWlLbSsvRVdsVndGQTBPWk9iQjNNSEdMMy9DSUpiZ3M0UVNpMTlQOHVP?=
 =?utf-8?B?bElIZi9TUkdQaHM4enVraWZMUjVtYVJZRVNZUHlrbnVEdjJaZFBXSjhGOHEz?=
 =?utf-8?B?NEE2Mld1c1hoN2VVeVFNVDgrZUM0d3RVT3NyT05lK0dHcmRxVXhvMitXbS8v?=
 =?utf-8?B?T2hoMDdyM3pwV3JheVRlTWcwMmVLdWNGK1FZL1ZJMW1Wcm0yelU3cmdtWG1M?=
 =?utf-8?B?TmNjTlJMR2hjY05VY0QreGw1ZlBvVkFJaHpPdk8zQ0xDc3RIaTBWeENCYjhx?=
 =?utf-8?B?M0R1NitCdzcyOWxiWTd4a2tZSGZkWndBQWYxZDBiTkFEdDZvR1N6MHRFcm9F?=
 =?utf-8?B?OHp2dzBmYnBvd0NpaksxMVd6MjBDVE1JRVEwZEhvVGpydnBpc3kwZmpuUlFo?=
 =?utf-8?B?ZTFDR3hnMThvQmhMdEJwRldmS1Z1UXZCWTc2UUc1Y3BFYUZ2VWZOWVFPa1Fo?=
 =?utf-8?B?a3E1OVhYOVQxVEpCOTFzcVVDZUhBMUx1RVoyc2lHS3JVZzRER29BUXc5WERh?=
 =?utf-8?B?NUZQaEtXOE41MUtBNlg0VElxdjRJbDBBaUpsRENmVUwvN01EdjYrSVdVMVRu?=
 =?utf-8?B?b2Z6c1VuSUhkZWpjWXRBZ1MrSE9TQ2dlazNxUTlKcU1EVWd4R3FuVzdGc2x5?=
 =?utf-8?B?N1lFYnFoQlNKMThnSHFTTlpsMWtVcEtWK0krWjczeUIzUjg0MEZtQjdKdUVp?=
 =?utf-8?B?dkFtSkp0bFVXbFhVUjZoeVlwUEp6U2FpcFQzVkpFWlRXVkdYeHJNUm1obXpp?=
 =?utf-8?B?ZlBzaElrdWJPeDczdERSSHJNMmo1b1Y0YkxrZE1qbWFUenhLZ2lIR2FFWTcv?=
 =?utf-8?B?WnBFYkhETWJuWlZkbVJqc3d3aWx0MHFISVpBbEtMamFhQnZqdmVHdFhqMWIy?=
 =?utf-8?B?cTBXbGZOV0dlakVXcUNBazVJOVBya3FnVGJtdW4wY3hhdXZxdkRCalphN1ZS?=
 =?utf-8?B?MmlZNm1FcjRCQmdmSDl1Wnd6clRPUktGck5PajZ0ODZuVmltOWFNQUxqQVhk?=
 =?utf-8?B?eEU2bFBFNzNNMFBZR1BQMm9nQm1TQjZiSUpyc1B3MXVaVHNqWGNTZW52RE0x?=
 =?utf-8?B?RnlOMXlldUw3OUMwYWdlejVZTXVRODhxWnVxaVJIRkFQQUdkWFBhV0tPVkdj?=
 =?utf-8?B?VUVkZ1o0UHhCRlJzOHAzazVOVzFtNGJtblp5ejBmdGFXNkw5TytLTjljN0pV?=
 =?utf-8?B?bWJYTHlwTC90WDZFU2lmQTRJTHJNWkhWM1U3aDdsVEx4dmRxVXEwdXI4R2Rv?=
 =?utf-8?B?QmJoZ1UrSXVOTGdpVW56TG9QMnl2VUR1clQ3VWZKOWR0a1JjV3FrMFpsM1Rw?=
 =?utf-8?B?MWZ6aHhLajIyOWl1WlY5SHhudlZvY1pJVFZIY3M2RVVGM2VTY2dhYVgwYnlw?=
 =?utf-8?B?bmNmTHJ4U0k1aVJqbXFRdWVKdFAwWG5raE1rbVRoMUNpWmRJRWNheFN6SFNi?=
 =?utf-8?B?M2FQYTlBelJDZ0V6WHlwS0M4UlhXaTlXU3p1RHdXanhwQU9oVkltOWY2a3Nu?=
 =?utf-8?B?dk93VzB2ejdLeWV5NVFocGpJMElnUEJZajZpNVRmb1hSR1BkZFhjVnJrYnVE?=
 =?utf-8?B?bGRuZS9ZSDJVcDVUeXN1ZTcrRU84OW1DVXg1OWt0R05JL0hZWTNneDVmc3RN?=
 =?utf-8?B?VTdWMFpKaFdydXFjSGtvaG9vRFo2M2FHUEpiLzF0b0tiUUwzTzk2MHVMU2Fv?=
 =?utf-8?B?Z0hMUXRhNlJSeDhwbnZLV0RRcldTZE9obEVuTFExMHFvWTIyV0ZGUXMxVG9S?=
 =?utf-8?Q?HOJPQRwu4tKLslvJVGcBU0ftS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jnTzGiX0xKL92gKgOBVPN9z+BGtubda82kGzMJLc0Ixf1fZxPLs0khaYkm0ehGDzbqcHy59j2wStGZcpgVlMqVSOQwbO9PDxoDvsze/dNW1IPL/Z3fYjjX2IK0z2HGtMWE0isE8r3SVuVd2N4JcPIK5qBXxm14oGtPG4eihjcu25K5VeLYbBLCdZMr0hKxDfPq4vxbqdIrIwKJML6AOr8wW6Fg8KOlhSJGFYrh43Y5wROK4dis5IyA0U1fs683ySoH6v3wSBxB3NEY/7FxZxTsU8cWMg7xQbF8mCcZ1C1rL8u5puoS4+XUe9Qcnx0p57LkkMh7+6AItHhEd7n3wArCHujrtz9yU1+kdcIkW/knk8/TxjBPbtnm5bLAYzbEtasbM+J/udQYbtVMznl5QwDI46QEVkg9JV8qTey0K29CbYQaYqmlvVuVR6/+oDbePVvhDeeNN11ZGZjn8Oi0FeNCo5YOMHSEWcCezBmWcaIdD4GTMIMW0cPNCzpm77EhJRPo88uJW0tWPnJZvzJDeirBDCohms02tFkZJ/XGaLBLWJV5MRZvMuOyN15CvM8IKid6golNO1u/5xovtbiuUuVgVBZ6ALmqwgMHuGn8ImFbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c57702-cd1a-4ae9-aa95-08dd8bd84e75
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 13:25:30.3216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g//ipJVjK/tSfXLJ4KzbBWgg7M5RKf+DRhRqJKVUsKf7XJ7M0Hw9Y1b8SI2dxHdNCw7BmsMK1cqwm+zFZqbHEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505050129
X-Authority-Analysis: v=2.4 cv=f49IBPyM c=1 sm=1 tr=0 ts=6818bc4d b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=ILVaFZuKRntZDq_tat8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDEyOSBTYWx0ZWRfX+MZhjcnxVsCt AOf/blksLjXap/ra5bMXMhY2KCwzQLIR0dQtCCAtWl7esh5SyVzqCsf35yEnE0CG+15Gtvq7olh KdObRopffTzeW77Truj2ENP4NQ8Wjoiz/7sOyUePE770oYuuUoJupaC93u2uTKovzlOnOd+XuQO
 F9C1Tp9g5HlSiKb89Y4dML5Z1kTJPgLUdX0Erqxp+F/TAHNz31sOiPfDDJhNJArpl8e81384KMX v9zrE/rwDr6trkOb0FE6gNxYTFDcqF7++n5tXaejFI4Td4j+Ngha3W5m/vc3Cm6gaamjEBtqqi9 iyLOQ7G1QAeKCeWSvlwcZkSxoxSWNC6bD5Cil87dJEsx1r91IrD31FxmAvL6Ts+COJuNQoMA9e8
 l1unE3IvkXoBUaSsiOcNdkX++csPudx0y2yLkfg6X07p+QJ+xGfi6/cg15LB/PXEda86z8/2
X-Proofpoint-GUID: caxJsUoB0E3NL6eK6e_D-zQ_uwS_1PTm
X-Proofpoint-ORIG-GUID: caxJsUoB0E3NL6eK6e_D-zQ_uwS_1PTm

On 4/25/25 8:49 AM, Sagi Grimberg wrote:
> nfs_setattr will flush all pending writes before updating a file time
> attributes. However when the client holds delegated timestamps, it can
> update its timestamps locally as it is the authority for the file
> times attributes. The client will later set the file attributes by
> adding a setattr to the delegreturn compound updating the server time
> attributes.
> 
> Fix nfs_setattr to avoid flushing pending writes when the file time
> attributes are delegated and the mtime/atime are set to a fixed
> timestamp (ATTR_[MODIFY|ACCESS]_SET. Also, when sending the setattr
> procedure over the wire, we need to clear the correct attribute bits
> from the bitmask.
> 
> I was able to measure a noticable speedup when measuring untar performance.
> Test: $ time tar xzf ~/dir.tgz
> Baseline: 1m13.072s
> Patched: 0m49.038s
> 
> Which is more than 30% latency improvement.

That's significant. Next step is to ensure this doesn't cause any
functional regressions. Have you run fstests ?


> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Tested this on a vm in my laptop against chuck nfsd-testing which
> grants write delegs for write-only opens, plus another small modparam
> that also adds a space_limit to the delegation.
> 
>  fs/nfs/inode.c    | 49 +++++++++++++++++++++++++++++++++++++++++++----
>  fs/nfs/nfs4proc.c |  8 ++++----
>  2 files changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 119e447758b9..6472b95bfd88 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -633,6 +633,34 @@ nfs_fattr_fixup_delegated(struct inode *inode, struct nfs_fattr *fattr)
>  	}
>  }
>  
> +static void nfs_set_timestamps_to_ts(struct inode *inode, struct iattr *attr)
> +{
> +	unsigned int cache_flags = 0;
> +
> +	if (attr->ia_valid & ATTR_MTIME_SET) {
> +		struct timespec64 ctime = inode_get_ctime(inode);
> +		struct timespec64 mtime = inode_get_mtime(inode);
> +		struct timespec64 now;
> +		int updated = 0;
> +
> +		now = inode_set_ctime_current(inode);
> +		if (!timespec64_equal(&now, &ctime))
> +			updated |= S_CTIME;
> +
> +		inode_set_mtime_to_ts(inode, attr->ia_mtime);
> +		if (!timespec64_equal(&now, &mtime))
> +			updated |= S_MTIME;
> +
> +		inode_maybe_inc_iversion(inode, updated);
> +		cache_flags |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
> +	}
> +	if (attr->ia_valid & ATTR_ATIME_SET) {
> +		inode_set_atime_to_ts(inode, attr->ia_atime);
> +		cache_flags |= NFS_INO_INVALID_ATIME;
> +	}
> +	NFS_I(inode)->cache_validity &= ~cache_flags;
> +}
> +
>  static void nfs_update_timestamps(struct inode *inode, unsigned int ia_valid)
>  {
>  	enum file_time_flags time_flags = 0;
> @@ -701,14 +729,27 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  
>  	if (nfs_have_delegated_mtime(inode) && attr->ia_valid & ATTR_MTIME) {
>  		spin_lock(&inode->i_lock);
> -		nfs_update_timestamps(inode, attr->ia_valid);
> +		if (attr->ia_valid & ATTR_MTIME_SET) {
> +			nfs_set_timestamps_to_ts(inode, attr);
> +			attr->ia_valid &= ~(ATTR_MTIME|ATTR_MTIME_SET|
> +						ATTR_ATIME|ATTR_ATIME_SET);
> +		} else {
> +			nfs_update_timestamps(inode, attr->ia_valid);
> +			attr->ia_valid &= ~(ATTR_MTIME|ATTR_ATIME);
> +		}
>  		spin_unlock(&inode->i_lock);
> -		attr->ia_valid &= ~(ATTR_MTIME | ATTR_ATIME);
>  	} else if (nfs_have_delegated_atime(inode) &&
>  		   attr->ia_valid & ATTR_ATIME &&
>  		   !(attr->ia_valid & ATTR_MTIME)) {
> -		nfs_update_delegated_atime(inode);
> -		attr->ia_valid &= ~ATTR_ATIME;
> +		if (attr->ia_valid & ATTR_ATIME_SET) {
> +			spin_lock(&inode->i_lock);
> +			nfs_set_timestamps_to_ts(inode, attr);
> +			spin_unlock(&inode->i_lock);
> +			attr->ia_valid &= ~(ATTR_ATIME|ATTR_ATIME_SET);
> +		} else {
> +			nfs_update_delegated_atime(inode);
> +			attr->ia_valid &= ~ATTR_ATIME;
> +		}
>  	}
>  
>  	/* Optimization: if the end result is no change, don't RPC */
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 970f28dbf253..c501a0d5da90 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -325,14 +325,14 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
>  
>  	if (nfs_have_delegated_mtime(inode)) {
>  		if (!(cache_validity & NFS_INO_INVALID_ATIME))
> -			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
> +			dst[1] &= ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
>  		if (!(cache_validity & NFS_INO_INVALID_MTIME))
> -			dst[1] &= ~FATTR4_WORD1_TIME_MODIFY;
> +			dst[1] &= ~(FATTR4_WORD1_TIME_MODIFY|FATTR4_WORD1_TIME_MODIFY_SET);
>  		if (!(cache_validity & NFS_INO_INVALID_CTIME))
> -			dst[1] &= ~FATTR4_WORD1_TIME_METADATA;
> +			dst[1] &= ~(FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY_SET);
>  	} else if (nfs_have_delegated_atime(inode)) {
>  		if (!(cache_validity & NFS_INO_INVALID_ATIME))
> -			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
> +			dst[1] &= ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
>  	}
>  }
>  


-- 
Chuck Lever

