Return-Path: <linux-nfs+bounces-9000-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9EEA06841
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 23:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B8516232F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A801E1C3B;
	Wed,  8 Jan 2025 22:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LaU5+Q/j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A84cC+5C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6343119D8A3
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375311; cv=fail; b=QIStebELtkBjsEsIZJHP0lNMPlA0YOSsPHj1GSv9Nz0DZ9m49dPwBVwXpKEaCkvnZk/hmNby+jBiFBW4fEkQqVN4IdPh9qlUotZOEMaO+5lmNJzDIXrPuOiRtMQzr+ccyRt7dQPJKBH9aN+onlJIn/MJ4jMNBuVrUpUEVzmpIko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375311; c=relaxed/simple;
	bh=nj3+yc7fwfst1ycyC0X+mRRF+9i5kKfZmUZ8WyFl4do=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DEucvpT6dXBpwxPtufktetg1z72o9tTfv5lVT7Vn434aSTuQ40QVMtlPAxXyIQFbgBS5X6UOpfPxsh4FXXvsyDBcD2iNhv9wceSRdwxIlbadKRHaM76zxd2XNLBnWttd42OarQXq5T5yX+BCUkg9Z9LRfLOMzMlCeJLcYvbfLpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LaU5+Q/j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A84cC+5C; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508MAKiI030518;
	Wed, 8 Jan 2025 22:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dXAGSzXJJ4l21ZyvM2ZLs74OO7aK+16f+nkkxgVgqd4=; b=
	LaU5+Q/j61sJLaM8AHQ9+8KqtXIi+ukRnqSa4BJPjHJcHJodjoWdN4PovSQ2zeMh
	gRjDznaNrvc2GGQ7hMgLyZTlwQ3q7qAPsM6xZsuZwyBMZx7o39gbm7o0b3tzZPci
	nPPdRHisFnQDwpP/YZEyVjQt5NqP7KsLeXkwMxJODV5KMsTkYo1V39T3w2b/f99z
	GGoSroP92L/3kitkwTKVYUUCE26ckUIfhL4UlgtUl7le8hvAsatsTA9NOeVmP0mE
	mBVJycJX8uuOMgJg2YMLCTiOHTvnSAXV682qNQCCVTVpBAWIbb5K03lDjTv72z4n
	V85DtjmEGDN7u0xvFE8rRQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudc822g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 22:28:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508MF9Im026551;
	Wed, 8 Jan 2025 22:28:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xueakkam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 22:28:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FM5DxOv4WOLQhub2QpEtw4kL1TU4ADyL0HDZ4T0CLNZQLSZk7/BJRR7UAg4+axuanAWcmsBH3pbk4lb2N6RapkAO9vDK04SU9W6SvR8JfZ2ZCKPTkmv/fq4GSZjun53+wS/+lFPxDvb9NsiOByzbZ1IXzWzQUG8qtmsQXqJcDJIawlUHFkJjVuoXsF1apejd90epoCp74dq+2zwFZDULCDB1FxE0af+f7VQg/4GNShsSQf1+j5UjRXi3JgMhwSkejfe+vLDabfKv9/ORhvRijGpzpwFyh/x/CalbvkUEO0oprcDBRrbUIZVg8BtNNQBl9lrZuQ7zPAWwVs+PwclV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXAGSzXJJ4l21ZyvM2ZLs74OO7aK+16f+nkkxgVgqd4=;
 b=htk7QXu96wX6/i+4yNlHG6sDu9mREvdIuEap7wWMFjwzXE3YnaH5Xe2R7hYSY+dpsWT6gH+tRCguStEA/+jvciZd2yet/ONtjG54zmHEeSpXxNZK+92x9WF0di1DGvKLwwmrypneqrn4ZHhb6QDcx1xP5F0s1sCkrAYtvtMqb0IHEs5T3DrOgpJr3BMLdQ0Vad8cQQUPSxUxb8YJlKdlMP+aWZ2neO4DXIBO6hwiXHomYiNjEkCQil7KwSgoiZAIHKPR08ROPScV+mHmXSN/EFWtD/1uh0q3RqQ2fYCQcndEGPIvJYyst2hq2YgOh/KNdn3Ib2/8nBiJrOPzq7V3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXAGSzXJJ4l21ZyvM2ZLs74OO7aK+16f+nkkxgVgqd4=;
 b=A84cC+5CIFpNPxZxoV2t6bCDb8eGz0mMxNFLt6LMYY+vzjIrD/gREILvADO4xH1bS1dwm58hGyR8fxo17lraJI7N3T4FRJbJnawx8ZG3xev2wS/i3iutAwUswJpqV5VA2BOp5zjklndjn2qnOnN+/O6xzrdPrXFBIfVwUjCiPwE=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SJ0PR10MB4592.namprd10.prod.outlook.com (2603:10b6:a03:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 22:28:01 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 22:28:01 +0000
Message-ID: <51c156f5-e70c-4a75-873b-68fed4fad998@oracle.com>
Date: Wed, 8 Jan 2025 17:27:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: add scheduling point in nfsd_file_gc()
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
References: <> <c205384d-cf12-4dde-8875-e826e4a7c2f6@oracle.com>
 <173636890368.22054.15435316321445899208@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173636890368.22054.15435316321445899208@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::15) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SJ0PR10MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa5b5f6-64b9-4616-6647-08dd3033b5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UklnV1l2RzltOThTazhCM1FRRmFQSEVqdExPblFmcDQ2M1M1RExtUGQzMkZm?=
 =?utf-8?B?MXBsUTdwR3lRZHV6RlNqYTFUeFczaUFVMFhvOFBHOUszdlZWOWhhZmRRSGNM?=
 =?utf-8?B?SHJKWDIwQnpFVjlWV2J6NDZEK01RaDExdjdoK3RybjgzcGIrckVRZjNneGp3?=
 =?utf-8?B?ZGViY3hCVGJkQTdEbktCS25pOWlrMS9nZnNTc01EckFsTU1LMy9icjZIMG4y?=
 =?utf-8?B?VndUTFRjemhURjNhSVhSSGh3V2NUTjVJcVJrNkEwZ2pSTXB1Y3Raenl0TWdL?=
 =?utf-8?B?VytnY3pZUUN3bE1hVzg4NXNURkZCcHRhK3FlNzNkUGZIRGlNY2J2WDd3bmJL?=
 =?utf-8?B?aTJnOURiVVdCOGZRSi93bVBGeVo0eFBrZ0crbHFhbzBHdCtKc2lUd2dPRDZ4?=
 =?utf-8?B?TjUwaENwY3pQVVM1QXhTRUtzc3JkSWdZOXZLS3BjZjVtY0JYY3FESmVsdTQv?=
 =?utf-8?B?dE5IWlN1OWlSRmFRRmRaM214VHhoUlpOWnozcmhiMkhIa0ZlSGxEUXM4SHFW?=
 =?utf-8?B?OXhzTmVKYnI5ZUpDNDdaNnhheGs2cTFBaWI3QVAzaTJ0Y3g2eW8wbnpvWk5T?=
 =?utf-8?B?TXlua25ldTVrUEJacW9DSmNMY2FiRHlmUFF6blNnVTFrbHhMWm5TbElmR2R4?=
 =?utf-8?B?UExVTGdJeHVoWVhQTXNBakx4L2NkUUozMGpkR2FOYU9rZGJ3VzdkUzcySFlJ?=
 =?utf-8?B?NExFZDNrVkxoaGFEbHFBa0FJUXhZTnFqYThEejhvN1h2cVFId2hMcU9xQlVq?=
 =?utf-8?B?ZVZMcVFINDFOZm5FTWdWRStJRlFpbnVyZS9jcWVXS1pqMi9aRjhJQk1WeW9J?=
 =?utf-8?B?bmQ1OGY0NkF4VWNwZDRaL0ZxUHZMVU1EREwzNlh2ZThJb1RmS1Vzb3FxZDNv?=
 =?utf-8?B?NWtqMEkvWXdjSXlJMUdzK3dhc29SWTkrQnNJVzNrT2RzSFRxRW9Pb3VlenlT?=
 =?utf-8?B?TUwwemtxUjU2dlVIRENwNlhZcmNZc2dmSG5jelpqY2pJbCtscnhhWlZQNlRJ?=
 =?utf-8?B?M1BCbTl3QWZETVBxYm90V1BvTFlIVWFYbTJUek5yNDZuU3R3dVNzYTBwdkFr?=
 =?utf-8?B?M0ZNdVN1Z0I5NklEZGpwK0V3ZWNUL1ZETTd4d3ZjOGtvdG4xWS8vMllEU1pn?=
 =?utf-8?B?NGtaTk00dmtvd0FKaUprakZvS05LYjFNL2hKYzZuZXR0am93OTJ4QnhDVzZG?=
 =?utf-8?B?ZHovM2hPU2htQ2VDU2hleTJKb3ZZUzZQWEVONENCeElTNnI1RmNMczV2YmZq?=
 =?utf-8?B?ZEZtclZWendFLzByZ0E0T1BjVTgwTmR5UUNmMGliMHRBeGlReWN2NkNMbE43?=
 =?utf-8?B?cFYxNnZGVmhFM2NHUUtYaDgzVnBwUFBnNUVHSnBub2podFRUaEVxcTZlV1hP?=
 =?utf-8?B?My9veUdkeUM5clZVT2J3Nk9idnpCcml5Mlp5Q0U4TXl1SUNLb05ZSnRhVVF1?=
 =?utf-8?B?TG9Rc1hzbXRwa0lkYVdFamxWTEdKSTZveThJclltSWhwSUtpVlQvdWFCaXp0?=
 =?utf-8?B?aFZRMEJLb1krRlNra0krbWp6QWxOMEJFMC9mWHYxaDVaUFd5cDdsMCt6Y3R6?=
 =?utf-8?B?aDFUNkVzY1ZveVVNZnovRjNib1IwelBnUEFrYXE0d3YzRnRRMzg2Q2RKeW94?=
 =?utf-8?B?akRGK2hPRjM5WUtpOWVwVWpoZndqdkM1cDczL2MrRktkdlFSYTFhQnJndlBy?=
 =?utf-8?B?VWRNcjYyMlBxek9uN2t2SmNWWDFhWEVlUStVdFc2cnBPaGtodlloS0xNTXkv?=
 =?utf-8?B?UkZMN0pnaHBtU0laY0UrVDZES3lrV1VGT3JQaGNRNGNzRG13QzAyV2xOcC8x?=
 =?utf-8?B?WjlJT3ZWZW1QS29RVGFQT3p5UzZ1QmdMRG9aRHFTUFZHNXV3c0NUWE5UNStF?=
 =?utf-8?Q?jPoJLXqyBwd5H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUU0QUx1dGt5U1pYdHU0OEp1akJJRVdkUjh2eFVVR2FwQXc4OFkwZzV6VS96?=
 =?utf-8?B?VjJwQkNlN2UzTkNTc2w3VjBkZlBDbXF6VFo1ZkNrNHYvYjUzM25DT1luaHU5?=
 =?utf-8?B?SkpTSkZWKzI0R1o4bWV5ekZySTQxOTF1aU81VGdJWW5sYU9CeWRQY0NKaENq?=
 =?utf-8?B?UGJHbndHcUFwUnVGV3Fqb0FDcFUxREVlZkZrZlI5aGptSFBRM3psU3ZhN2Vt?=
 =?utf-8?B?ZGtxNW1JODRrekIwMTN1WWFSL0pybGdhek1JbjRLemJuN3lFbFRlTjdrT05U?=
 =?utf-8?B?NjVlc2lCRVZSQTEwR1VjNmN2Rk9lSUk0SGdISnByMjEvOHl1VDhzT1ZUTUZH?=
 =?utf-8?B?TkdVRHhqOVdmdGJ5M0pyT2htYTJOa3ZWUERZblhGUy9zcUhEblBvaHdMYmJK?=
 =?utf-8?B?TVk4S24xWkFIaFpvcVM2Mkd2aXgzZ3VzdjQ4TldQOWZPek9rTjVsd3NlV0c2?=
 =?utf-8?B?cFc5WGZRQmtuMDA0QTZzUHBOVHp1RXJncDNSVm1aSkVlMlpDblJ0ZTJSdURG?=
 =?utf-8?B?ckIvMVpNMHd2bXR3Mi9pamh6ZE9zRU4rbE1lT0lIdnpWdS9CQVVoK0RzV0dh?=
 =?utf-8?B?UjdNKzFpdTl5Vkd6OXAyS0txa3dwbWo1U1dFYzF4REpaUmlpZDBZS2cvZGpz?=
 =?utf-8?B?cDlFdW9wcjVYMkxINklUOWRSREZxM2ZNSURIdmR5UlFHZ1g1d1ZZenhHM2h5?=
 =?utf-8?B?K2hUZDd4dklmRDFiYzlmVm8rMlpIWG5DdS9XWFFqWUxUdG9wdUpTL2JkdTgv?=
 =?utf-8?B?UU1oL2h3R0FrNnV6c1lrVENQM2VkYzVUaldaNGZRRlFJT0ZBeHpXRnJrWmEx?=
 =?utf-8?B?NUtkT1JXS2NTNDRUcXZmV20vZktrZUk1dE5Qb3lxM0RxaWYwTmJ1d2U2Yytn?=
 =?utf-8?B?blBYcU40U1I5UmNOQzZsSWkvbkRNcEU3cWpHY1hQWDRRWGcxMmpsQjZTUmxE?=
 =?utf-8?B?RU9EOEdoUzlNSC9KZXg1c0dyaXlUQXpFN1NrV1ZHZElwYjlMN1JRSDArQkJO?=
 =?utf-8?B?eE1iRVB3bEFxWXV4LzdnbWxtd21MSFY4cFhYV3ZkaTJ3cTMvdkk1aHdQdzVT?=
 =?utf-8?B?UTVBaDA2RXZ2NDBxQWRQYm9taFhtVzM5NHJEczlRaDZuRTA4RVJhaW1nWER5?=
 =?utf-8?B?TzFQOFdCMkN4MEZFeXFSbFRvYU02WFErQjFEWm5ZcEJtQWVhNittZmlLUDBw?=
 =?utf-8?B?MVBUR0hMRTZvRXlzaFpITXY5ek1aS3BPeWk3VFAxNkFEamJpNkhTL0lEaGR6?=
 =?utf-8?B?QUxVb1lEbXN5OWVlSmNOMWdUMHBKUzV1eldONUtGVXV2Sk83eDdCanFRY2RJ?=
 =?utf-8?B?VnlPQ2g5VWVRTFZDVitmOEw5Y1Q2Q053T3ZmYk42Z3JXSEhSckhRUi9VNk13?=
 =?utf-8?B?UHRZbGo5aVNoR3BGMXBqeTFObGVPNzlKK3dhQUJ3NUxVQmJjcTk5ajFQdGZW?=
 =?utf-8?B?cWFybDFVNUZDWVNsL1dNTHJJdDNZQlRBUVdLWHd2YjM2MDE3SXhaejZVdkFw?=
 =?utf-8?B?U2NmcDYxVCthUE1qMStlRzFBV3QrRlhzQWlva1VaM3BRSXprclhYb092czlp?=
 =?utf-8?B?dWpQWnpmcWdnaHBocGhKb056cTd2cm5YOHdGaHFlMGoxZk5oOHdVRm5iM2Jq?=
 =?utf-8?B?QWdsWE5qRUhHWEdwTDRtR0xQckRrR0E4RlJ3T1Vad25GdHIzZUtmcy9EeWEw?=
 =?utf-8?B?eE5hbHEzVW9WMUtpQzdmYkRYNTRjQmVmdDdXSkFDSHc4QXV1bFVaT2M5MjJH?=
 =?utf-8?B?S3dvVlhYZDVrS3ZIYXlwcDZxTGllbmZFdklOYlpOdHZvNmxUYTFkQ1Voc0M4?=
 =?utf-8?B?VUoyUGFEN3hsRDFEZnVRR2p2TjN1RHNwQU45UklvUkdLUit2T2svTXQyL1Z2?=
 =?utf-8?B?ejJnN0dlM3ZQanpUZzFmbnY3MVp0L1FkcGozbWJwVkhRZ3Q5NVk5UERSbjQ0?=
 =?utf-8?B?bnYvM2l0UWdxRHZGVEUvMHI2QmdWUkoxaUFaRXlsNml5V1pCeWhrN1AraXR5?=
 =?utf-8?B?YmZCb2pkNmJlbG5aU2hRenhQNWxOeURLd2FIcng4SUttWkV0Zzc0UnZLUHdL?=
 =?utf-8?B?c2JQWWVTYWFlVnBmaklXZGRrbHBpMUhzVG1VN25uMXVmMUVMWkJVNHRYNHNH?=
 =?utf-8?Q?duml4xVUyhqXF1RNv+y2FiXLS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	48LgTJ3W7TpRZ7kKlcsZiREtM9ku88BSxENDb0nqyoB+QOPf1iAG1HHk6FcYQyUGdOIEqD6uE/XaQKf88g3IhdIDBz79AUI7XHOGmfu7DR+BhjIaK/uZEURhQB/MSWFMYb5T1mEHyfN9KTekZ2eQToEmhc5B/OFXBDXAuSc6M2zuUo+r0j9v7Nfh28FunN+Mb3ZXjfEtbBF0jty7vhxUjwjtK5FZakyYLyN2EttGUx3L+zgS+4KZznWzPRBDvOCWlsI1rOl4jkbgtBnLzZigq1ptshfCzMdlKBO34fZr3ZIfLtdd0IvpoBxueow3h7NOWJXApr5zELlzg8NpEL+H2FCm7UmoMTQcru23+Woz5R7aaGsDRydf6SlcJABnKmSmP9OvRsVR8ZWcMhOk4IYTdamMs9jAI3jRz9t2yyXfbqNnzHicjK7OIp099WEL6vVUoZTWUmFMXs3nFXEZhpmH+fM5+XF90YrAe56U8pOAY8DGDrKV84xkPD6GZcDvIeZtnfr65Bo7e8wDzxxobCJ1D9WCs9+ALZT9tzBfN1deZQ+/ewx2Livmu09/Aw5hp/kpllUZXjs+4/Az1QeHUBbH2Lgw6HoEPxZ+VuzoYENLQSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa5b5f6-64b9-4616-6647-08dd3033b5d8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 22:28:01.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FUc+O4ZmybvtdMLbELk3HLLTibtJXOQc108Iw9hmIEhr1xWb+oE44EqQeyhUckmVAj/3H971GPJbdFrulEU2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080184
X-Proofpoint-ORIG-GUID: BwYd-a6VbL3ilSez4McSsjb3VBOe8rhP
X-Proofpoint-GUID: BwYd-a6VbL3ilSez4McSsjb3VBOe8rhP

On 1/8/25 3:41 PM, NeilBrown wrote:
> On Thu, 09 Jan 2025, Chuck Lever wrote:
>> On 1/7/25 6:01 PM, NeilBrown wrote:
>>> On Tue, 07 Jan 2025, Chuck Lever wrote:
>>>> On 1/5/25 10:02 PM, NeilBrown wrote:
>>>>> On Mon, 06 Jan 2025, Chuck Lever wrote:
>>>>>> On 1/5/25 6:11 PM, NeilBrown wrote:
>>>>
>>>>>>> +		unsigned long num_to_scan = min(cnt, 1024UL);
>>>>>>
>>>>>> I see long delays with fewer than 1024 items on the list. I might
>>>>>> drop this number by one or two orders of magnitude. And make it a
>>>>>> symbolic constant.
>>>>>
>>>>> In that case I seriously wonder if this is where the delays are coming
>>>>> from.
>>>>>
>>>>> nfsd_file_dispose_list_delayed() does take and drop a spinlock
>>>>> repeatedly (though it may not always be the same lock) and call
>>>>> svc_wake_up() repeatedly - although the head of the queue might already
>>>>> be woken.  We could optimise that to detect runs with the same nn and
>>>>> only take the lock once, and only wake_up once.
>>>>>
>>>>>>
>>>>>> There's another naked integer (8) in nfsd_file_net_dispose() -- how does
>>>>>> that relate to this new cap? Should that also be a symbolic constant?
>>>>>
>>>>> I don't think they relate.
>>>>> The trade-off with "8" is:
>>>>>      a bigger number might block an nfsd thread for longer,
>>>>>        forcing serialising when the work can usefully be done in parallel.
>>>>>      a smaller number might needlessly wake lots of threads
>>>>>        to share out a tiny amount of work.
>>>>>
>>>>> The 1024 is simply about "don't hold a spinlock for too long".
>>>>
>>>> By that, I think you mean list_lru_walk() takes &l->lock for the
>>>> duration of the scan? For a long scan, that would effectively block
>>>> adding or removing LRU items for quite some time.
>>>>
>>>> So here's a typical excerpt from a common test:
>>>>
>>>> kworker/u80:7-206   [003]   266.985735: nfsd_file_unhash: ...
>>>>
>>>> kworker/u80:7-206   [003]   266.987723: nfsd_file_gc_removed: 1309
>>>> entries removed, 2972 remaining
>>>>
>>>> nfsd-1532  [015]   266.988626: nfsd_file_free: ...
>>>>
>>>> Here, the nfsd_file_unhash record marks the beginning of the LRU
>>>> walk, and the nfsd_file_gc_removed record marks the end. The
>>>> timestamps indicate the walk took two milliseconds.
>>>>
>>>> The nfsd_file_free record above marks the last disposal activity.
>>>> That takes almost a millisecond, but as far as I can tell, it
>>>> does not hold any locks for long.
>>>>
>>>> This seems to me like a strong argument for cutting the scan size
>>>> down to no more than 32-64 items. Ideally spin locks are supposed
>>>> to be held only for simple operations (eg, list_add); this seems a
>>>> little outside that window (hence your remark that "a large
>>>> nr_to_walk is always a bad idea" -- I now see what you meant).
>>>
>>> This is useful - thanks.
>>> So the problem seems to be that holding the list_lru while canning the
>>> whole list can block all incoming NFSv3 for a noticeable amount of time
>>> - 2 msecs above.  That makes perfect sense and as you say it suggests
>>> that the lack of scheduling points isn't really the issue.
>>>
>>> This confirms for me that the list_lru approach is no a good fit for
>>> this problem.  I have written a patch which replaces it with a pair of
>>> simple lists as I described in my cover letter.
>>
>> Before proceeding with replacement of the LRU, is there interest in
>> addressing this issue in LTS kernels as well? If so, then IMO the
>> better approach would be to take a variant of your narrower fix for
>> v6.14, and then visit the deeper LRU changes for v6.15ff.
> 
> That is probably reasonable.  You could take the first patch, drop the
> 1024 to 64 (or less if testing suggests that is still too high), and
> maybe drop he cond_resched().

I will make it so. Enjoy the rest of your leave!


-- 
Chuck Lever

