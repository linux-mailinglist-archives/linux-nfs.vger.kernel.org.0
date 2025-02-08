Return-Path: <linux-nfs+bounces-9962-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934AEA2D7AE
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 18:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9453A8ABC
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BE51F3B83;
	Sat,  8 Feb 2025 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="msmpYiKZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wNRFiBPb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877BB1F3B80;
	Sat,  8 Feb 2025 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739034100; cv=fail; b=RzLX3Jg5HzxZTtE5ofUrSindZWyI3qyfemAuert6FYiWOlE3iEw3h+UDu4hLkcuvSpI1RRe/F1WsxZw5XuBz64MlhbbYYzcwIoXdaQjnLDVSksf8tNKkSxJAcJlLIEImtyYO2/KHiwUAgYt34oYQo2kuLK/Sf7UroRA1DMazSFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739034100; c=relaxed/simple;
	bh=7QJzOQCK+FBhXqTYSs9BiWda7LJq2Df5mMJ2QaL4qyk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c7pZ8xXjBAWOVzWT+x+Me+b1mmqmJr1k7zf8gJpakNxpsO3BOX1ubNCinrVlUnJs7ch0tWz/lzzIEarCNZUhSMg7drZoIonm7++GQ28Y1k2NR8CqF8dq6jTn2iAyFGvsdtQcpiZrqYjgjxHRVwh8ho7x3bcNNWqGgjkuAIN3pRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=msmpYiKZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wNRFiBPb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 518EfkAJ008422;
	Sat, 8 Feb 2025 17:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LLmI5O4QhFtNMNa5VcwbI4rr9F6lWZQQZp9OwbUVWH8=; b=
	msmpYiKZX2OW94T6pbVZ8NSuM/IhjRjc+Ls8Vm3NglX0I5hJHigMYWIa1eC9Weit
	vJ7SsO+CxdLnnFfyPYkOpRMxRWvVTfxQUZ1yr2ENVYNwM4RvzpKq9CT+RvZETCAy
	pcKRVuSVWUU9B5g20lIfzbzDc8EcWgc08LkRpk4PYrbyjUtQD+jH3sD050SryHEZ
	9nglFa5OFIO1645D6FvtA45AJa0vF4gCrGlXzPA0tpQJVgK2/MpCvJwfXJ7+jjue
	yR78aJAbTD9rwiHFKwqIXvJJbsgWrRyKOV46vRCWwMcQ21wE2IgdyG/4irhgKwtl
	QE3D49K3/tV6o9dP4jKlEw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn0ccw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 17:01:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 518F19JH017892;
	Sat, 8 Feb 2025 17:01:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqc6dg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 17:01:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0xAeEeHg31rzMyf9VvWB63/T0/wJRmpKpUUyhWeB6iYCQ1jPCUvM91BqfGWvgHDzpAcG0/NztoXlKf8oIJY2BXcUEdw6yNruQgJXtXPbQyjc7e2LPRo73/krjhfd/YLhCaG1sm2YnY+/Si+y2Jd0aufMsjVVfOnBkXQAOCoKUjkEYHJl4T+fRz7QpwTEk4b1r76k/eLkgLjZwRrw10D78CumN/7MMyIYxUEEJjC6FOughGTtY3/5tdEcPrIj/Y/i74NlCwxN4JHQS20LRUW1hzezuZYOcjoXhZepBp4kZ0fjYd0YuAwibZwu+cs32tiTLYT7R6pNKQixAQuvU2x1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLmI5O4QhFtNMNa5VcwbI4rr9F6lWZQQZp9OwbUVWH8=;
 b=VajuX6wiAIn5xj3ELO2u2uqsbuXXxQz9zuSnae8TdAR0ta21Ldo7M54xOhldTnh4kisxl2xnRrqEM2hsbtgFj6EB0hYacv6oq0JRBIiWdqzodXcEf1Nfvn/D1kxwdfmbBssoCV/RChGi4ri98Ooi2D/D8MsnxVTsdzwlCkd8uPXAtCwaSLYxT50a/QaoRzg+kqXt4eCDIADA9ntjgl0Pp5EUKKEEgvdSYsTeCUln84cqFJJEku0bFmNRSC0UP1Uolkub+jHug2M/5WIzAJL8+Kq9U5J81YBU8+FIhqnyW8ELKM4aEhhihgdyTcM5IBVXABTkGbAQapVFthM/sXf7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLmI5O4QhFtNMNa5VcwbI4rr9F6lWZQQZp9OwbUVWH8=;
 b=wNRFiBPb8QsQTKm6FJBilDZghHIwuvbe2/1/d7NdUuiv8Sgis/GWU8+7SZGLBfMgXnpfSV74G77JT1c3es9xIxG33sgv3XWz2lqO5uCf3RB6KqhVd7SrFaehOXtt4lkpHn3Cg8rBeJ04vEeSEEcJO31Wrr5FHnonr6NpZaEEWk8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7913.namprd10.prod.outlook.com (2603:10b6:408:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 17:01:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.012; Sat, 8 Feb 2025
 17:01:20 +0000
Message-ID: <28174296-129d-4459-aa23-a94bbf00d257@oracle.com>
Date: Sat, 8 Feb 2025 12:01:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] nfsd: handle CB_SEQUENCE NFS4ERR_SEQ_MISORDERED
 error better
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
 <20250207-nfsd-6-14-v5-6-f3b54fb60dc0@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250207-nfsd-6-14-v5-6-f3b54fb60dc0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:610:20::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: ca787dde-327a-47e5-093b-08dd486235e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWJWV1ZtZW03ZWkwU0JJMEtEb0RDSENXWENDU1Y3dmV5REc4bWFVZ0hRWFNK?=
 =?utf-8?B?SEN5RENhUW96WE9zMWhZS2JtVXRuZE1zOVorbS9HamxhWkpDQ2R6ZXNkSzdO?=
 =?utf-8?B?Q3NTR290SWlqZ0ZUemlITURmVllscFJqMUdpREx5eW1QcU5LZWNNRFAzNDhm?=
 =?utf-8?B?RURudWQ0SldCWWwxU0JHSlBINFJTWk9CY2J1eUd6M2ZMVFU1WjM1TFlJTWJ1?=
 =?utf-8?B?cjJGTFZyOVE5WnE0Zm9Wc3Arbkp0MHkrd1ZweU8zUGJ6VWJ6L2Z0dmtxZnc3?=
 =?utf-8?B?Yi96R0pMUTdzMW0xZmpZYXVhZkZjR3h1bFdnaG9NdTB4WmZuc210aEJ2MkhJ?=
 =?utf-8?B?T2tHMTZ0TFNpd1NNSWV0S0NtakFtQXVGQ1JSOE9QQzhFekQwT2ZMdnZpTXEx?=
 =?utf-8?B?ZEV4YjhhdG1MWGRHU2lwYmx2anpRZFZwYW9HREt2TzNWYUE2TVplUFhsdkdE?=
 =?utf-8?B?aXNUTG9UVTFlcjIvalA3TzFDdVEzMWhQZ3VDSXVFMm56TzRIZnh6VUprU2d2?=
 =?utf-8?B?cHVFUXBzenlPU0FRbHJ4T0ZQajY1ZTE5Y0tINTdSZjhXWVdQTDRHL2NBZDV1?=
 =?utf-8?B?SDVlMUZGc1BTcStLZnBHVDF6MVFGbmRlYktLRzdtV3M4TllGSzJWWGFBcmIv?=
 =?utf-8?B?MHhaUDZWc2NHK1lwckl0V09KY3k0eEpoUHFySFJFc3dGU3pIb1BBVndsUEtr?=
 =?utf-8?B?bEdCajloZXd4c3ZDbEhTSUZSL0JLZzZjQlFsdXc2QytrNGlYVVRCUi83dEFL?=
 =?utf-8?B?Mm94WEF1b1ViNlBzYWc3MEVzQS9pQ2xqVVViMXpLM1ZRV2NOQlAzaXQ0YmJ6?=
 =?utf-8?B?M1laZ3N4VmZ2UjJGUUc4cU5STHozbFlydVVVZjlTaFhXVGg3ZjhlQUYwVlli?=
 =?utf-8?B?S21sRFI0dUdGOGM1d2dTLzF2WXl3c05tRDVET3MxaVRDOThjWHRZY3MzNk5R?=
 =?utf-8?B?eE9CKzdmK0pPc1RjUjBUK3JMN09YckhLRXhlQWJBVnhrNld6OGJodklVOFlF?=
 =?utf-8?B?VHpsZHNkcUdONGJRaVRWY05ybmJsWG9MRzR1QjdTcUhwM3N3QnliN01tM0Fs?=
 =?utf-8?B?V0tIOHd0SC92ZmEyMlkrNGZNZVhHKzQrVHk1ZHhZUDJrbkVyWkJCbEJ0Mys3?=
 =?utf-8?B?M1pCbjV1ZklIV1hROWJjT0hteG11K2F6bmRSWmNkWE5tYUhIMEFhVGhrK29p?=
 =?utf-8?B?Mk55TWVRUHNSZlFOMUdQN2F3elhMUUZTdTRvRG52aG51K0VVeTNycFlsUEZv?=
 =?utf-8?B?Y2lLSUdnNmIyTzJQZGFKcnBISVV2RnJrVFFoOTl3RklweUNsMHBoK1BiaUFW?=
 =?utf-8?B?OGRhaGFCcDZBNHZBNk4wV3dDSEhGM3ZsTDZTd0NPUGdxMlpGdW1YYWdzVit2?=
 =?utf-8?B?dWZMSllXa2hINC9Yd3dwRVBBN3hUOENOdzh2OUVpNFNiNEgrR1F0OTI1MnNH?=
 =?utf-8?B?ZkpWQ3hsTkhvdUlMenFCSmZKSTRIc3AzTGxtTDJTcVpQL0pvWUdjSk40NTRz?=
 =?utf-8?B?S0FXTUdSTzdQWEkrQys2ZHZ2OVFUcmtRelpRZHVhZUdSTTFoa3FoOVFGdVJJ?=
 =?utf-8?B?UUpFZkdhV2taZnBHZlVjMWNnYTdYMzh4UnNWK2xpd2NVZzhDdnhIcHFqdnJh?=
 =?utf-8?B?cENHdVNJVjVyUkhyMnU0am9zTENuWTl3aFB1cHFuS0FmSWp0VE5pQldhbExs?=
 =?utf-8?B?bjBXMHArbkg4azhkSWd2ZmtpSmVrd2VoS3R6RTFRWktycEpvL2FmcmZSNURa?=
 =?utf-8?B?MndsMTRtMDZKQ0UrVzlqNmY3RDE5aVJiUHdscFBnRVlEWmJlVzhTMloyRVND?=
 =?utf-8?B?amtCdERBVHV4TC9xVkhIQ2krdWFITUJQVE9oT1hsV3ZuWFZ1aVBmV0tSeWFo?=
 =?utf-8?Q?JLQSe7dngiSo/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUE0UkFIRytPMzJYekFIeXpXRlVRQW1OKzBBdHhJVis1MGhHYUx2MEFWWFRC?=
 =?utf-8?B?cnM0eEthd1gwaWFqS2tpKzA0WURXOU85eHNrdGdldHFwV3hiaFB0dXdNcDJX?=
 =?utf-8?B?MytBUGoxT0RBTGx4bjFIaGVNdlFMc2JxQ0ZVOTBoaUpYSWE4bzBpcnFSQzd5?=
 =?utf-8?B?bHBjZVVnZTFtQTg1M0hoR0F3eGlZMzg5YjBLOGlRRS9BUHJJQzROYmdMVTdF?=
 =?utf-8?B?QnU2TnUrS0Ewb1FVYmQwVnVSeGFWSGNkaHNNUlVSZ0dlYTdoQlUyREhWaEdr?=
 =?utf-8?B?eEpnM2tQRUVPdHNKU1VBb281ejkrQXdCRWJPMTZVdXdic3Myd0JCcVpud0Y2?=
 =?utf-8?B?WTkxNUJ3alJwb3puNGkzU0FuM1cwaUNFVEM5bStFRDBjbURkSzZ4QUpYeitO?=
 =?utf-8?B?cEI0dFdMSDB6QUd5RWd2UUlQNGI5OW5uUmJkV1RLTGdWQ3FHQWRRNy9mUHU5?=
 =?utf-8?B?UmtWMnBXNHpPRHJWUXFBazNaZ24xNFN5YkZSeG5vUmwvcTROTG80ZWo0bWJr?=
 =?utf-8?B?SWlSVkhJOXNoTnNVVjViSmxpaVRqa1lzZjhoTlg5aGtqc1ZtVUZEemhrZVd5?=
 =?utf-8?B?bEpmUUMzWnlxZWRLR2d0djBmR0ttTTExMExxUnFPcTllVWVZWTVqaFdDc2tw?=
 =?utf-8?B?WFJKMjBTaVlmblIrYThNT0wyTzNXMlRXS3FCU2c3NU81OWpCWnhrMFJFaFkz?=
 =?utf-8?B?Tm5WQnU2QXVkaCtJY1QwOXdpdFhxY0ZLZ0JGNHBoT21ibnk5U1pMZW1Sb1dH?=
 =?utf-8?B?SGdoTG5yUHBGR2FrbU9laCsza093dEV2MFR6K2VTUEh3SGNqbXhuMWJYTDM0?=
 =?utf-8?B?UmFDeDRiVHJBeEo4RVlWQkJWT1MxWUJHRWtJZ3c2ZHZDRjFHWFErKytSUVF2?=
 =?utf-8?B?M3NHdHpwbDRoRklYbmNtQThNOFVzTnJTdkNtTTFTbm5pQnhQZ3VOQjlXVUxE?=
 =?utf-8?B?Y1NVd0RNUU1CcGxSTThCaXQ3WVBaZDdnWit2dDdWVDF0ZWhCVy9YeUFqSUcz?=
 =?utf-8?B?UjFCMGJnazc5UUhCcSt3VW55Y0htcFpaTm14a3B3ejcyK2NNbUdIUUhPcE05?=
 =?utf-8?B?amhIZXIyNGlHLzBybWJmK3A5Q3dGOFNNaUhINVQ3clRETEJzc3FyVTR3SGJ1?=
 =?utf-8?B?aU5WcjBWMzRvbW44OUdHb2VDb2xOWGU4Z1lLL1F6OE5uc3VZc0NiQ1c1enZG?=
 =?utf-8?B?Rk1Gc3JJSmpka0R5MFFUWGQySStSNUh1WTU5RWRVMXU4MzU2SEFsZEc1RUJP?=
 =?utf-8?B?U2pQak54c1RuY3FHRExDSGpXbk5temRBb25jVnNPN252YWJVMjQ0TXd6Uzk0?=
 =?utf-8?B?dWFwNXN2bVhIOWlJVzF2R2lOeEJmenl0WSt4Tmh0aXJacVFhVWdLaEhMYUNr?=
 =?utf-8?B?Qml4UVFaK3hGTkV0ZUVhT2NUT292OWJDU1N3dUhCODlDV2c1UkpZWE54WmRr?=
 =?utf-8?B?RW8wRnVqT1NmdWtaS3hEM0VqcHcwM3JrRjNlSnZsaUNrSUxOdG1mZmZqSm5X?=
 =?utf-8?B?Wkd4OFNvRWk5RC9VOGtROXB6bkFFZDAxenNJM0ZxUHBCcmNGSXRGVFhodzVv?=
 =?utf-8?B?Uys3dDZicTFqWktSa1AzSDhFQjgzdy9hYzlVN3pkdkJWTWNCZmdmcnNueDNM?=
 =?utf-8?B?OWExeEtFK1VMbkZvTkRxRld2ZEhUYlBzb0wvR2FVMXhseUFsMkJKMTdyOEEx?=
 =?utf-8?B?YnFiZHovN2NqRUJmN3REd3QrTjZPRXNNekZmL24raUp3QXpnTjVXeE9mbHcz?=
 =?utf-8?B?cUxESjc4ZzJ1eVZyM2g0Y3lSNDJBWkFtZU5janV1S1pqbjBsL1hVYUhzdjVj?=
 =?utf-8?B?Q3JOb0JDWW1jNlUrd2FqZk0xcS9mSHRQbDhaa1AyV1lTMlhlL25MT3RLRUFt?=
 =?utf-8?B?Q2JvSEZ2UnRBMlVKOUFUcmdReGFSTWxBbVJIMkx3ekJwamRZTWt6MDVYVzhT?=
 =?utf-8?B?b3owcGl2V251dVFxeEhabnpvNFF1ODRLRVpKRG9hbkgxTEFUV0pOZWRicGFp?=
 =?utf-8?B?TlVzNitaNmN0UDlUZVZUeEhwaXFGY2NCOG5UekZLejl6WFViaVpGZVVoaERQ?=
 =?utf-8?B?YmN6eHRRUDh4ZXNia0V1QUpGRGM5RERud2hqdWxGL0JkbXpPVTVUYWpjZnZY?=
 =?utf-8?B?dXRHUGdIck5XZVVGaE95SHJzNkxHV0RGSldSR21ZZVgvbW1oUktWVGdhaEZr?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QXUE15TMc5YoewZZSnPXEzt2hom8kZ9VFxFqv8sJzz/GigV+r8AABZZKgQ0Nhd/i5KroNhxujWP/8dcrXROTDBKcLr6zdmupqqopm0jK6D3suyUphh+oWJhS8llJWjH+VVGjV/cNirEslFgtxUjEa56aIBD+6+KXp8utPZyBy1NX7rRwt/SK5Vo7SsotwHaPAUm6UnHJFWDZM1en1vja6Dr90tZEDEheAbigqZNe+Vn2F6WkRvff84CB1712KiNtlx/ZpdEOyXemlP35qlV/Ps2kvVC2moHX9DYRP2E90F29VPu8LU1suaJ4nnFEENJlCLu/+p/jK3L12fPXtd7Pxa++Kq0UKVGfNevpSMO2zi6D7dKxaL3epVgENuTGS45+3cBE48b9kM3Z3/5cK/sBKGU7oeMs+Xs0F7/tnLzhvS6qwWxmb7OupnSQ7Re28U9qOHSFLh+7jYdGYm7//kytSYv29bvayNE7b6xrIAlI3Ideid2KIhKYqiYiWkDPn0fNjophBDnjI3KhiNKlaGF9LkgzkHWtCuGibJF64YtWnNBf3sKw8HVUmXgFcEY7eGYJ+xW3dcgNDz+XkXx095gxXxpVOZse7s6ceql5A68ex7M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca787dde-327a-47e5-093b-08dd486235e3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 17:01:20.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eh6UUqDOFpGIrwu/rdA62ctR76y5CMomyi/sqJnKFtbaSOfrXL36Xf+Ubfq6ZU4DEFWKj3YUgq3Dy1pYGUrag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-08_06,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502080143
X-Proofpoint-GUID: 4ByvblYvZvLjMDajOlih3N9fL6tTSpWp
X-Proofpoint-ORIG-GUID: 4ByvblYvZvLjMDajOlih3N9fL6tTSpWp

On 2/7/25 4:53 PM, Jeff Layton wrote:
> For NFS4ERR_SEQ_MISORDERED, do one attempt with a seqid of 1, and then
> fall back to treating it like a BADSLOT if that fails.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4callback.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 10067a34db3afff8d4e4383854ab9abd9767c2d6..d6e3e8bb2efabadda9f922318880e12e1cb2c23f 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1393,6 +1393,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  			goto requeue;
>  		rpc_delay(task, 2 * HZ);
>  		return false;
> +	case -NFS4ERR_SEQ_MISORDERED:
> +		/*
> +		 * Reattempt once with seq_nr 1. If that fails, treat this
> +		 * like BADSLOT.
> +		 */

Nit: this comment says exactly what the code says. If it were me, I'd
remove it. Is there a "why" statement that could be made here? Like,
why retry with a seq_nr of 1 instead of just failing immediately?


> +		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
> +			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
> +			goto retry_nowait;
> +		}
> +		fallthrough;
>  	case -NFS4ERR_BADSLOT:
>  		/*
>  		 * BADSLOT means that the client and server are out of sync
> @@ -1403,12 +1413,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  		nfsd4_mark_cb_fault(cb->cb_clp);
>  		cb->cb_held_slot = -1;
>  		goto retry_nowait;
> -	case -NFS4ERR_SEQ_MISORDERED:
> -		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
> -			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
> -			goto retry_nowait;
> -		}
> -		break;
>  	default:
>  		nfsd4_mark_cb_fault(cb->cb_clp);
>  	}
> 


-- 
Chuck Lever

