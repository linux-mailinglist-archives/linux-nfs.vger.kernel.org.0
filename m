Return-Path: <linux-nfs+bounces-16560-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4160C701E7
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 17:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6913E2CD23
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63334105B;
	Wed, 19 Nov 2025 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jpi6GUKx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UjsPs0sd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE035A15E
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569661; cv=fail; b=EDh9Jqmwdxyx61fwRLChXBJfQBGNM/monWTLhBsBoBL+tIhmlY4ezGuOk17SlLBvS4DGusmXd6d7mY72XSTwOoTnIwWaZsll/NL8gxKURm7nQwKU68/H214Mn8gZEL2mBaTZnVx759ehQtStss+fV3j6eLEZ3UmpNtn56LHcK1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569661; c=relaxed/simple;
	bh=IzPQfXxwm4CbhiVZgJXyt8cA8zo9oJlVSWSZKRwSACo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iVcfS1uPgSLS0i6e1FXiiXqijg/fPUE1aEyh17M25hIm1dox5cwYLXgAUOjiQx5OQkFjVaqmqSpB+/O2o4fOHP1pwJoXxGCoNQhdGOnNJsZutSZ+LkSlyI7y9kADg61RgJMAGLdtXeZzjQXp/8v0ChFP0XtdW4vJ5ElJHRoJbnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jpi6GUKx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UjsPs0sd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEfvZa021304;
	Wed, 19 Nov 2025 16:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=g38LW0dgTlswL6lxY8qXa5V2vWrj0acjIAOyp5McSkQ=; b=
	jpi6GUKxgIOr0YgXYKfvQ3vqe61/i+S+mnfkCsVQkX06VG6VuymtuKc/Jsvv4Y+S
	hQntHg4r1/gNyYwlxUfFUctozjMAr/QpFiPAIxpjZFMkPnLxxXbd4sKZSsIkFrzP
	zdDqOVD1KVT9wQaf/4RyCyWLTKU1PcubFHvj9kBrBuC19YTj7plzx9L7V2A0ADDS
	ne77yu9ko/ZPpcI/EzQjCv/GazJGcj7frBbJ4ihJiSeKJDqkuj4y8kIVdVJ4YdVy
	fIJsnP0rx+hjMBQMcU4gnHZP2y/0ypq6JFHZppM2kE7HxayTKxgqcQ4+eYqor7o1
	Rv8zaikKjVtsZaGjPzK2nQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej967b7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:27:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJG50ud004488;
	Wed, 19 Nov 2025 16:27:27 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyajsm9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:27:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmTOKItI+eTNfpVOXZO2ju01O2FghCK0UCWQPtQgsRbyMNGkkvihN8wk7h485Lby3DNPbAK1d0pt+KkY2DVpHQFzsLr4qgYpVCRh25z70VhJVCEJbH1pUr5U72iARLKGzj6LoVLHhZle91NVME7/BOv4/+uVcOWryQX93BVXgCwe8nLehfGcOubRsaXniBnrl6DIEoUE7f6i+QtzlOorteG8rubYlO1ZRMALQxCBhqgRbyTk0flAPq29ng+BkqZQf7S74tI2uBhb5hehkTBsU3HvfJhYxH/ZweTkEaOkxdt90vtjoDvcZCIMw4KIGvyz8apDYiKAvXNHfx4gpgllug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g38LW0dgTlswL6lxY8qXa5V2vWrj0acjIAOyp5McSkQ=;
 b=ZEB71/LXJ2hmh6lKpf6VfnUQ2vUYpIphyRKfjsYwPU86ly8DIza70RaYdVEXTVhZ96iwyFaVPg3LCtLMqtjZKa054SJg5V42aa4hwh1uMOwxqdygkoKI6wvIDv3DP+tmKVq/xWfGz69+zMfuTRtUMG+KOiyaW3i9Gmp0ft6qUjGdoi4t2uU3fcGrruFlVrxEdO4VNa6EHSGqTPPw640RKerMiaNA83kT8sLGvX+OnWSnRY27ZK3n1w5i2WD+h5oOgOCfE/XiyEigDNM6rMVzV2C+K4GSP7Y1RWcF1tYQdV6mUz59281eIgYtuydd1ZS0S81knO8RgYhf6OlpUCAJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g38LW0dgTlswL6lxY8qXa5V2vWrj0acjIAOyp5McSkQ=;
 b=UjsPs0sd1ONDy/p+o7bCLT4wyAXRo/hMnuNOVW8d5dqjtUjLpmWlowk9rWd2AioCc1qZPfv76OOnARytI9jcIgywiA7iXkgeL7ALrcBsauEwnenX7kttDl5qjVXsm2AgC6jFtpaD3IxFzbwYAOLXSNAgOB5QAm4863q4x9kn1rE=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by MN0PR10MB5957.namprd10.prod.outlook.com (2603:10b6:208:3cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 16:27:22 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:27:22 +0000
Message-ID: <0958c74f-afef-4063-9c91-d78462af2315@oracle.com>
Date: Wed, 19 Nov 2025 11:27:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/11] nfsd: discard NFSD4_FH_FOREIGN
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251119033204.360415-1-neilb@ownmail.net>
 <20251119033204.360415-3-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251119033204.360415-3-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:610:50::38) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|MN0PR10MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: b3dee81a-4479-45e4-503d-08de2788844c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?blZGV0RST1o1Si8yL0l0a2t0RGtHZW5aZ3BMTHh0QlEweldyZlhCQUZ2a29X?=
 =?utf-8?B?NG4xYkZUVWNHQmhLVmdPc1NVWWhvTVVjSllGQUhpYzUxWTZnTElkYUg3L0Ni?=
 =?utf-8?B?dzI0UWFiWTNaakFJeWtSWUx3NlVLWXFQc0piUVVUS2xtRXBLYS9nUzBKWCtT?=
 =?utf-8?B?ekZ6d1dZcFR6Z1lUTkt1YnR5TklhVXUvNS9SQ2ZZOXA0R1NldXlWaXllRXU4?=
 =?utf-8?B?aCtOYkdoVm5lVjJsSDAzWlZsaWFPUEw3VVd3QmdpR2MxZmFUeHY3bzRJYVdz?=
 =?utf-8?B?ay9sQnR1Mk5qZUN0RVlOQnNSZ0VMdU9xNUdsTUtrR21SaXcxTFBoT01QbjVX?=
 =?utf-8?B?VjhCcGlHcmpUVm5BampsTkdXRmhQNm5lc2Y3LzNSTW1hcWVVcHJEWWsyVXVS?=
 =?utf-8?B?Zy9LWjdoUWgvZVJvZGgybFVablBaSDlNM1NqRmxwbmJ0WWU1cGtjRmFNekdP?=
 =?utf-8?B?RlJEa0tUZlRWUzdlZ2JlTk01V05ua0lwY0o2Y1hacGhVeGMyUElUeXFCOXBT?=
 =?utf-8?B?ck1ZaXlMbDBTbVdxYVE0aCtLcXpZdWZZWXhIQjNpOVJCaHhlNEJ5MUI3RXJp?=
 =?utf-8?B?enhKR3pTcy9rdW5NbGdBUzJJUWVqWTVuNk9zT2FYcUxwVUpJWVN4TndHNTFm?=
 =?utf-8?B?R3prUkZSa0JrUWNrZkNJS0tIUTBlVkJHeFdPaXAxajh0L3FBS0Npd0NhTnAw?=
 =?utf-8?B?aU5iMWRManhpSDEyc2xvVUlZZ29XVXVkU0hPNUxFNDBZc1RSbm9YOVE4aE9k?=
 =?utf-8?B?RHkyL3pDNU0vVThDRXBzdW5uKzJXdllVRE5MUUM4czlZcFhkN0I0SllQVFIy?=
 =?utf-8?B?VmxqeEkyZTBQWkpNd3lRbWoramduK2g3VlhSdk8wK1ZqdXpzZE9hcDYyY2lj?=
 =?utf-8?B?QmlpQjNCVFNEeU1nbWpGMUR0MDhmbTJlRmF0cVN1OGlOc1BieHBOZmozcjdC?=
 =?utf-8?B?WHZwYnJuVUI5eUV5aVlkUkZySHdnWDVOM0VYYithclphTlpkMWdVakNDZ3hP?=
 =?utf-8?B?RXhLMExGeGIvUzZBNFJvRTVPVjE0OEhnMmFxL3h1UHZ6aWtsTG5leEFINkh5?=
 =?utf-8?B?Q0ZhaU1ITGh6djdUMnB2VkFVWnFCd2ZZMEYvNGhOOTVWbjZpb0Npb1pwcnJY?=
 =?utf-8?B?aUc1RUpsMnAwWnpkMUg2NURIaUxJRGRhZEdXMVZVZTZrZFVIK1lUYTlEa1di?=
 =?utf-8?B?czBBUWlhdmw5WTZhSWVvZmR1OC9vUlFJeXRZdDFBMXg1Y3RrQXRuVDVFU0o3?=
 =?utf-8?B?TFBDcjdRVzNXU29pSVVabkI2QisrUUhsLyttVzdPMnRnQXhKbXYyVFNjSW9s?=
 =?utf-8?B?RjNac1ZPM0trK0UwZWlhMi9MbE04aXk5dUtsMU1sckorblVoWmJKazU1YWJ3?=
 =?utf-8?B?a1cxUjVZU1JFeWdETVVReE9SeE1xZkJpbFUydVN3YlNKSWdxMXN0WVFNdGJk?=
 =?utf-8?B?V3l2ME5LTXBzc25lQTVtY3B3TlE2a0hVU2R6NGlhN1lPaUZuUk5hVVowU1pm?=
 =?utf-8?B?WkVNK2N3TXNQOEZrRTNjdHJKZ1ZWQUtLOG1WclRCcDFPTjlGbkprd2RMOTNW?=
 =?utf-8?B?UStNSGxRY0V5ZXc1MzNuamx2Nm5ub2hOdWdMZk15UlRScS9ONkxRL2Y3aXV0?=
 =?utf-8?B?OU11Q0pjMjJZZmxqMkZXL2llQWwyUkxoVEVYUU1JMDdQSzJsZDRPUnZPUVNP?=
 =?utf-8?B?LzhZeGZTM0J2VVFUS1ZjZWFTTnlJVFBuVkdGOTliWEp3VndUZW5zVTZpeXJS?=
 =?utf-8?B?U1U5WGVaNFZUNmNLZmJvK2dQMXV0b0FybjEzRlBMdUs0RlMxellZOEVhUGJ5?=
 =?utf-8?B?WlBVc0tFVzByNXdDdHlNUlhYcXpkV1dKL29FY3JWM21YZHVXckdzaXJ3ZGRl?=
 =?utf-8?B?K3k0UFpuWFpQd2Y3c1R0NHFsT1JEaFkyVEQzTFZDc2dsMmxYZm52NW1iRGdX?=
 =?utf-8?Q?xlBnDSrFwRUVwnJuE+PYb28h4Efay8Ex?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UGJKZ3JHOEsvSWVtS0l3WGpCOXRGbzdQYms1elhqSm0yV0RxRlZZYjhoeHFw?=
 =?utf-8?B?MERQeWd0bnNReTlGRTRFaVd2TFdKaFVmYTRVRFh4emtiRmQ0bXQ4Y1MwU3c4?=
 =?utf-8?B?Wno3ODcxMmdyMWhhNGowYzFjU3ZEM1MzTTlIbHNSQ1JmR3VVVEcwQVYxR1Yz?=
 =?utf-8?B?NlQ0ekJNYmVoSjlnbVZSYmVKdUszT0xoaEVaZDFkMkhaZHVzTy9adzZtUHkr?=
 =?utf-8?B?aENDbzZjTWQydGtkZXJWSEVOZ1hOb1locWM0czM0SFpYTWVVM0VSSWhYVG1T?=
 =?utf-8?B?NTU4WU54WTNhOGFOYWNuWWZsUFkzMWdVVUp4MlBLWlFydzJzb3J3cEtEMG5E?=
 =?utf-8?B?Uko5aFNJcDh3SjhrYUlQcE9RS0ZkUFpvTEpubVRVYjZBS1ZwSXpaUktRNUpH?=
 =?utf-8?B?dWxkZnYzd0RTbThOY0sxOUdpQmxtSFpWc2o5ejRseEFaNTh3OGVCWWNzWnlz?=
 =?utf-8?B?c0tPUlBIREhlQXRyTERqN1R4MFR0QTZYdnRSTUo3bTZvVkp2NThUM01ZaHlG?=
 =?utf-8?B?TTFKM1M2WEE1YWpvYmNtOGNPSnE2MUpBR2xuN0hXVHhuSnBHQ3JkUzFzNlVp?=
 =?utf-8?B?VnI5UHRpb3ZmbE55aVpKc29INzUyUWFEWGF3UFJ5WkdzQkUyb0J2ZEs5N2VB?=
 =?utf-8?B?cmRNaWNYTytadWdOR1dBQ3Z3bHVqZHBsUEZvTHFlS1Fod1MwdUxLVlRJZ0tq?=
 =?utf-8?B?TTRGaXFhODVVR0JPU2YyTCttM3lOTUR4dFBwNHFmQndQQldocGJScGFuQ3dQ?=
 =?utf-8?B?dDNQeFE2ZXlKUmhqcVllZGtYaDBDTzRXTllLYWRwMWlEVWpDSTNieVJEMllv?=
 =?utf-8?B?b2w2V0tWRUJkNGdqLzBMaVk3YjBkOWErbGdoRjhqTzdGc1B6eStLR3BGd1Jk?=
 =?utf-8?B?S1NrcnU1TjJnOVh2OEoxWExNSWt4WEwzN3pwSUw0NFMzd3lxemMyZjJCT3hz?=
 =?utf-8?B?YTZ1Mml6OU5PVktIeVVsYWg0bUhnV2RFRVNaVE9pZmtQNkVJV3Z0YzRYZy9p?=
 =?utf-8?B?b21rYWR5U1l1eWgvK0R6cnJxYzFUWVI2Uk1KSE8rVktBR3NSUmJPSlNzNUFR?=
 =?utf-8?B?bW9UVW9OU2xaQXd1YUpUa3VJdDNWZVVWVjYyWkdaZXJ5VXZ3ZUVoTEIrUUpT?=
 =?utf-8?B?QlZ1emtmajNmVHcvUlRpdEZ3WUJRaCsxaklFQTZMNjlpZ2xpRk5BWC9MSDRU?=
 =?utf-8?B?b25Wb0pBSTlPam5mc0pMM3lsMVNBVFQ0bVFnL00xUGhuZ1dPVlhDaUxHK0Jq?=
 =?utf-8?B?SDFYTUJCVzR5UHpSRHBjZzk4eGM2WHE3UDhpUXlLY2owVmc5d2xiNFB5OGs2?=
 =?utf-8?B?dGMwT2Q4YXg5UXBmdFN1K1VKejVBL1QxL0VOWEZnUWxBQ00wSlhwenpERUxN?=
 =?utf-8?B?QjVkc1UyT25LdUNCMGtVejc1cXhnOFFLa3lBTGdXR1ptcFpNWmZ5WEpDTVNr?=
 =?utf-8?B?OTdJUnNjc2xXS0JzVkUvd0thNlpkbG9uTllkSTlkalY2UXBTazJKOUdCKzcy?=
 =?utf-8?B?MVB4QTAvUTlCNFZZRmF6R005a1ZncCsySnU3OWtHVmloYVFtTmNOaXhnQ3Vy?=
 =?utf-8?B?di92RDJ4Q3N1dVUrTCtqb2FUUkJhbW5CSjRTczAzbjhYQ040aTZyTjBxdmZ1?=
 =?utf-8?B?S0dNSkdXY3V4dm9zVDhWVDc1OXpJWUhybzZRMGZXdlZBQXMzNXlrcVBPU3l1?=
 =?utf-8?B?K0ZtT0NqK3dNRVFjZ3hUVTZzVmVQa1FkZ1VhYXU0UHlPeEYzNDRxVitua3VE?=
 =?utf-8?B?Lyt1MFhydWo1MVBYVy9QZGpRSzZJbTZiamlTUm1LRGlPU2JQL2dGWFRYbW02?=
 =?utf-8?B?bzVzVTlva1dmVVJnTjMzNWZiYVRXYmdTa3lGMGtsOXlWK0JaMUUvWXB5c1NR?=
 =?utf-8?B?cEpQajZVQTh6U1JFa09rZjBBSTVYSTQxaFA4WjRBNWx3My8ycmR1N0p0RFVx?=
 =?utf-8?B?TitLTDlTWWdRUGYxZzhJbWdGaGpINVZ6aDlBTUdSaHZSTlovdHZwRHlXSFgz?=
 =?utf-8?B?emxwd202RnoySTQySWhzTVhkbllGWkpIZVN5VVMwWlI3ZnVBTmREM0NjM2c0?=
 =?utf-8?B?Yk9MN0lGMldpRVYwdU04eGdsRVk4SldwelBBV1NmeTlUZGVUOFZBTFpZa01m?=
 =?utf-8?B?WkZQbFlEb3lIeDQ0TGFkTlhxdG5xTERSbGJBTHhaejk1SmhDS3JaMWxKcGV4?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DH5cu9PIQ70IkIpIxmi3VI3SLWURVCnlr8rRXJobnxLc2Ze/jPnvndq00g2A8N/IYOmPlzK72HprpkqP6O7uA3K59HqCMH1+2/v4P3N20xdRFcpu3xnlicXpR8LU7DOFkSXHOhkKROcqagF0/fTMTQPeLhxDEcfdZSmgNysiBEqFoICyoIFUGenBE9A5JFrqLWi9TIK6G+gwnPH4hjQbRH2COzI6bI5uI2SPuQ+lEuQnNsbbG6ynJAVT/WyaS/Qsf1/Q3pKeRALRxugNO9nd2Hv71H7OEEQGBfiL3+XdVBSBNdthAsLWGHN+6yN4nC495kVeGkBHiK5CtqjDtpnvg+DTEjmRN0KThSUmloIX3kWbUyrzD/ojrIByohtP48zp9idj+ApJ2Sj3k4qKysiGAdBpypVf98DKxnxCpQlmSr3DcIUNclcyFuiDwMEkprb0S5SetSZUsyqm8REmLmK8M2n/P0L5RDBlRpHtMWJdgSH4T3+Ijb2lmqRwdXtYEvM7JZ7rP7qAuJ18nOJiov5YvhyeHv4NHkB3dn6EyU95mBHbS2sS/eVR6UyUwjlGpQpb7b4fUNcAsmNAISq3TkqPISLL5jvaIgENGY5eEsJHrfk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dee81a-4479-45e4-503d-08de2788844c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:27:22.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1yRdHu3oUa0s8Fb/H69mQNybUX5Ml/XzfcM0uZOzGg0CbHjaXbY85sReRivezg6FmgA0o4IjhDFElY8ZGnYWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=758
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511190129
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=691deff0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=K1lVYQgpXJRD23h8tx8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zvYtBKfd_cpm9sqF3aeCjwD7d29LUKTa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX3m8BZltOhPXr
 AdnSOOHLpdkQ7Egxknq0b8GnehXVfbsb7hBSggGJofMtUsBiOJ1gNpxi785nF16dsx535JBiXp/
 YYf12pPVEDChrLgTjDQ8wRak5Ts9MWwy7XB7W5p/bj3QQN9O7y8brlqlUhj0heCOUnKiH7wC3n3
 hlGPPHkZ2quYw21qE88Mav2PZGVCW/XV2Qcj/ik3VE4677bbF/PKoLA9TQeZXcJoT7Z1EF18O5n
 DOS5kUrsJR7AnGzihDle0FwNKBp1ToXXnrXHXzqu0qaHvsowxgdXnOrhqakZY1jLiViBR8BNAHO
 UHk/Zf3iGPzi2fJS+tRk+9Bc1YM+V3koJ1oS3u2iz2tmUxZen8Ey4oSWUpdnZdEGxg7tegZht33
 Hvz+H99ww4LwbGdCWbhx6/gedNmX2g==
X-Proofpoint-ORIG-GUID: zvYtBKfd_cpm9sqF3aeCjwD7d29LUKTa

On 11/18/25 10:28 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> NFSD4_FH_FOREIGN is not needed as the same information is elsewhere.
> 
> If fh_handle.fh_len is 0 then there is no filehandle

s/fh_len/fh_size

I think to make this new mechanism bullet-proof, maybe fh_put() needs to
set fh_handle.fh_size to zero?

An NFS client can do something crazy like { SECINFO, SAVEFH }. The new
"fh_size == 0" check would pass because fh_put doesn't clear fh_size,
and then NFSD would proceed to save this no-longer-valid handle. The
current check catches this by seeing !fh_dentry without FOREIGN flag
set.


> else if fh_dentry is NULL then the filehandle is foreign
> else the filehandle is local.
> 
> So we can discard NFSD4_FH_FOREIGN and the related struct field,
> and code.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4proc.c | 7 ++-----
>  fs/nfsd/nfsfh.h    | 4 ----
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index e5871e861dce..3160e899a5da 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -693,10 +693,8 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	       putfh->pf_fhlen);
>  	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
>  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> -	if (ret == nfserr_stale && putfh->no_verify) {
> -		SET_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN);
> +	if (ret == nfserr_stale && putfh->no_verify)
>  		ret = 0;
> -	}
>  #endif
>  	return ret;
>  }
> @@ -734,8 +732,7 @@ nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	 * is not required, but fh_handle *is*.  Thus a foreign fh
>  	 * can be saved as needed for inter-server COPY.
>  	 */
> -	if (!current_fh->fh_dentry &&
> -	    !HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN))
> +	if (cstate->current_fh.fh_handle.fh_size == 0)
>  		return nfserr_nofilehandle;
>  
>  	fh_dup2(&cstate->save_fh, &cstate->current_fh);
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 5ef7191f8ad8..43fcc1dcf69a 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -93,7 +93,6 @@ typedef struct svc_fh {
>  						 */
>  	bool			fh_use_wgather;	/* NFSv2 wgather option */
>  	bool			fh_64bit_cookies;/* readdir cookie size */
> -	int			fh_flags;	/* FH flags */
>  	bool			fh_post_saved;	/* post-op attrs saved */
>  	bool			fh_pre_saved;	/* pre-op attrs saved */
>  
> @@ -111,9 +110,6 @@ typedef struct svc_fh {
>  	struct kstat		fh_post_attr;	/* full attrs after operation */
>  	u64			fh_post_change; /* nfsv4 change; see above */
>  } svc_fh;
> -#define NFSD4_FH_FOREIGN (1<<0)
> -#define SET_FH_FLAG(c, f) ((c)->fh_flags |= (f))
> -#define HAS_FH_FLAG(c, f) ((c)->fh_flags & (f))
>  
>  enum nfsd_fsid {
>  	FSID_DEV = 0,


-- 
Chuck Lever

