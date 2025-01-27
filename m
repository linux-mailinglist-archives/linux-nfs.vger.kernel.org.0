Return-Path: <linux-nfs+bounces-9660-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFC3A1D6D2
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDC93A30A8
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD451FF7C2;
	Mon, 27 Jan 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hdHmDQEw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iUWJMEPy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64B1FF7B4;
	Mon, 27 Jan 2025 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984573; cv=fail; b=SBhbC/Tct60MDk9iw/+8qX6NlBGqoHg5hXZfW2Dj5CKOeZe1cC94ZVM8kmX6rdhFRZE64TyqPvbwgW5u+tZi6lihjipMWVMue90mpTqXLW7OYe7mVhhw7ze6Nc0hm5jrXkvh0NU26ouus//qgQypmepi2y9eAGZoZMRkNlYKi9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984573; c=relaxed/simple;
	bh=aErLY7xs9tL3HDUcGg4Ke+UuU2vcgD+wyfGSD67kMD0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NqLlvMtQzJ1Z0Ueg3hvMMyt3GLL8T3NnElYXMGiCr8yiJiYh3VSpOAO/kUOPDWA8ASBlI+Wu/zbkA6KTeKUEOpY8W2jHrP7deIz7csJpnPuYAGWTVddEBvs4WXog48PuEo4xiPD+tVwEof0GG2Xq2EhGg6txObqX1hf3ZI9K+Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hdHmDQEw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iUWJMEPy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RB7HYL010906;
	Mon, 27 Jan 2025 13:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VaKqPb1kJSf49kxUw9WyS02BFzzXh8q6n6IFDCZx3vM=; b=
	hdHmDQEwOsA21yWkszgY3C1LgFJjudFWyzklEunsSSmrYZi5ZsGQhJK5Z/ptpAmM
	9WMymvh1bAhQNvNc2nE++KU8PsHaUylmCnrP8w1lU0g6MFYj77qiCDQSBH/L+tc4
	o1dTqF0r6/knwSa+Mj9zQFqBGy2g8r/StGa7ivi1eOUaUOY614Sjj16mJbj0C7B/
	2ieeoW5erHSKCEaGievqwi5BqrwONOiXVXoESDtiplW1V+Q84ZBf9Ks68/Ppk4up
	5x0EdA4er6G3S2HR6bg6LPgKJWI7BCmfET+YG6hpq7KGDrOEGkUjaXeXiXNlUfAx
	d6+UT3Jv5aEYbeW+fCP98g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44e900r6jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 13:29:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50RBCGVM034174;
	Mon, 27 Jan 2025 13:29:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd6xtmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 13:29:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKXoNl4oF8Dc/H4Uwlbv2uq/vLPSQYfns9hz72CLEpp/SmXJcizzzq2JyaOMsejomXXRirVyyCBYaBpgMhqf0Q1rM/+aco4rvUYkquomTXyubOxv58r0FNhlIRoZrri4fOsKDwaI8MG73mUKX9nmqmyvBa2bKhUlco04+WmoZYhcmg9Z/U758jsBt/I8jFbUIgL2zUFx/9rk1KhQRbfv7EPOAlHFjLV0L9O1yQArOlCes9ODOLBVCNmDIH5QmhnBKlAJxbMf4ejnkPKUStxj127an0PWpU9vNkYFklAG4AJvQstYoG+cv9A2ovezK7FQH+HRCedcaBNQyayO7ezVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaKqPb1kJSf49kxUw9WyS02BFzzXh8q6n6IFDCZx3vM=;
 b=ln/CQ8w+iaJr5vHzdIF1NhQiyV0GbYb3dqOuzq3wE9vCZ/UDtZIm9WImUdAQLHH+szgpxrC/YtCLSCudmWxkIBzNPN4NJ4iYomjuWz149hRLB/8CN/uPlTDTvS/E/bdJcrLOXkH4xGZk2oIme8dq46u3DXwyXyklmmP0866R8m/k449IpLyAWs/VSf3PmVEUPC+oRxrjrnRjOYeyT1ZN1HboLVcZxamXQ30ZWfOBWg+b1Vl3TedkPf1b/WR/PJqu5PVztuSZgyf/39iqukbQttuy7/4oRackBvg98xKFNkDp4+PiMdScHvJkJEgaA+sgHUIJXf3GAWtSI8FfP0f3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaKqPb1kJSf49kxUw9WyS02BFzzXh8q6n6IFDCZx3vM=;
 b=iUWJMEPyPtNo1w0qLdiVNcGF9v1e+X9ZyDxfkA3uQsbaKUhODnKjoE7BeMkfI/DKh6GQfyjUF1tf0lfAi46yEJ8TbU7xvs0lM+LTnHbv37o0ILZFbRT4ykDNxvRIEzWNK1seALS6PYUfxDKcbp/a1pzQMYTwXhjW9leHvaqhuac=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4793.namprd10.prod.outlook.com (2603:10b6:806:110::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Mon, 27 Jan
 2025 13:28:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 13:28:58 +0000
Message-ID: <04b06966-ad5b-46ce-a629-b6de7b428360@oracle.com>
Date: Mon, 27 Jan 2025 08:28:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nfsd: map the ELOOP to nfserr_symlink to avoid
 warning
To: Li Lingfeng <lilingfeng3@huawei.com>, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, trondmy@hammerspace.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com
References: <20250126095045.738902-1-lilingfeng3@huawei.com>
 <20250126095045.738902-2-lilingfeng3@huawei.com>
 <e9a10562-5c8e-4bc1-a767-20ee1b07e4b6@oracle.com>
 <7edd3481-df5a-4d22-87f5-367263b19ea8@huawei.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <7edd3481-df5a-4d22-87f5-367263b19ea8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:610:11a::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: 75daf09f-7204-4ad4-4512-08dd3ed68e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2k5QWt5MngyZ2ZUWnlUSW9ORDczY3AvTnJFUXo3MTk3UmNkR2RlbEVSWG1X?=
 =?utf-8?B?cWJCN1djM01ZSU03M3YwK3pYU3hvejZrOEt3YlVCRi9JWVRPdVdIT1hXV1Vk?=
 =?utf-8?B?SkJkVFNEbjZ0U0ZLNi9CY0V1R2NjdExhQVE3THN2SXIzdGZ5QlBzalhaRENv?=
 =?utf-8?B?TG82MWcvZnRTeENXbm1IUjQ2eklVZEZsQy9na2IwS0trcTl6VzIxcVFpSmlB?=
 =?utf-8?B?ZU5yS29lNjFNQmY5L2VnZEhsbE82bUZCRjNIK2ZTaGFJTDVDell2M0hWRnVT?=
 =?utf-8?B?YU5XL2t1dSs4ZlUxQmNGcHRkbVdvd1UzVXdrN0lySlBhSkJKU2EvV1EybndC?=
 =?utf-8?B?S1NsU3VZaThaVVBnU0VCVUlHYlNibUZ2V3A2aWk4OFVUbGZ5c0ZhbTRPWVht?=
 =?utf-8?B?T0NnR1BibzZkZGp6b2dwM2dVcjNGc2pqZ3JYOVpwWDh1Zm1RKy9zKzJYQVB3?=
 =?utf-8?B?dVpEVW56dFI5RHNxUUtHbzNCaVVwVTVTWGpiWlNzTUtMa2tpWWZ2MnFndXRR?=
 =?utf-8?B?azBoNGVwOXB4YS9WcThzNWU0MUNDWGE5MnZKd3RXTHd1THlEODM4eWRsdUhQ?=
 =?utf-8?B?T2JkK3luK0FjZzVUQUtPNVRaTHlyTmdrV0dsTUpLbFA1enlnLzBCOVVySG9N?=
 =?utf-8?B?RC9sZVRqWFc3Q2plVmpqd0lnZnVmQmtlaTlmcnd0bWJmM3V6NEhiTUJ2V3Fq?=
 =?utf-8?B?TzdyeG1OdkVYd2JpUTkzUGwySEh2ZVVWVE5ibmNzcWpITkRqK1UzajBCMEt4?=
 =?utf-8?B?K2lvRnhETWZ5eERYQ1czekQxNjRKakZLU1lvcXhaMFB3RURYcW5kaFVhMjlw?=
 =?utf-8?B?RlZCM0ZYNmp5cVhMcVM3ZEZ0Nk9BMk5leWkzZVZ1bjZlb2tnVUpNY0hvNGE4?=
 =?utf-8?B?MGtUK0VsZ0NqcTllT1RzK1VvMEp4N1kvTVNSOGdlN1lVWDFlVjUyZ2Zmek1W?=
 =?utf-8?B?YkRQVE5abXVZc1d6L0FTdUhlZ3djQ2RLSWpQL0kwaG9rL1hvRUczckxETk5N?=
 =?utf-8?B?WFdLcm0xd1NpOWdUQ3pUdUd0VXNUbjFzUDhsU21OLzRCQm9GdzdENTJiWFc5?=
 =?utf-8?B?b0c2QWNxS1c1TlhQY2RVcmRqb2RoNFh0cUIyNkNjVmVSOExqeTZ0cEJaaFBF?=
 =?utf-8?B?WDJ2UUkrdG5YM0RIUHRHbG43T25xZ0lHTGRjSDl4K24zZ0tKNXpuaWJJYTRl?=
 =?utf-8?B?NTBteHQ5N0VsbjdwVUZaeHlub3FuTTRQTXNHSGNHdXFQOFIrdjVaUWp1ZEY2?=
 =?utf-8?B?Y0gxZkwvYzhWN2lJcEdud1FGVlRKQTVnaEdibWhERUFJekVLVEtURm9aMjdO?=
 =?utf-8?B?QkdjNmYrWXBGUTRmZDRjNnU0SDdoWmxVY25pUnpadG5mOEpnWldwbC8zL0cr?=
 =?utf-8?B?RHhvR1dsYjNwNUpGYkN3NlgzbnlSeE1KbEl2TjQvMktOUXRxMC9tbmk5cDdH?=
 =?utf-8?B?SjZIZHp4V1Yvb2NNRkJ4V2VxWVZWNmpaTWtkeUtQMEZlSmFCdjEwM3NsNVhG?=
 =?utf-8?B?aEtxUjNzNk5reTdqN3Rwd2hUWXd1dWhPTTFRZ0N2aEJ5OWlwNUlYY2RJSUJz?=
 =?utf-8?B?SThMQWJKQ2xCcVhhZjJyRTZkbE56MkcvRTJkWjQ5UkU2S25KSDFtVHpmZHNY?=
 =?utf-8?B?KysvMHhBQVBiTVlocm1EVWF2MWxSRGpyYVluMEdPODN1eGtrSlJ1dTVZWHh4?=
 =?utf-8?B?bjNiWkNlVXo0aDBlR3lRTERWZGdWMTlYOVZsWFpPUjlhNmFLK1ZoWXNPK0F3?=
 =?utf-8?B?Yi9iUXlJN3JxQmIvTE5Sb3JrUVYrdXF6KzN4WGY0WDg3K3dJdVk5R3RIRHU3?=
 =?utf-8?B?QURzcmlVNEhvUlMxTHQ3b3h2dE5ya0RrU1BkR2JXd0FsYUgyTXpCdmF4cElH?=
 =?utf-8?B?U1VOa3ZiUnB0WFRDbXoyWEpWRFdycHdCOTNOMWJmcHpDZ3FpUEwvL3VaWXVi?=
 =?utf-8?Q?+j80cmOZp8g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGQvV1VIYktqN3cxSFdsMkUyWWtuRVpQN1lMckV1WWJYNmQrU3hRWlg2K0s5?=
 =?utf-8?B?R1B6WG1YVDZKcnlpMTRHUlhrRm0rVHZ1ZnVQTFU1Wnc0bFc0bWN0OXJvVFVz?=
 =?utf-8?B?U0NUUVVFYmE0N2NxeHBRV2tWZFYrZHduZUFyRExDNmk3WTVuTGF1dnEydEdQ?=
 =?utf-8?B?aG41RTUxN3ExNXFLc2tRV2w5MjQyZXR0NEFhcXh4VnBxcTNNaHZudm8xSG5M?=
 =?utf-8?B?WDVuaytLN2sycGE2NzlVS1FsdThKd0YzamZXUWdoK2YrZVhjbTU3RXBiOGRm?=
 =?utf-8?B?c2VPYnhvNCtQOGZDUUwxUWsrU0pMNDNsNlhNQ1lUSndlalI5d2E0THpwV0xH?=
 =?utf-8?B?UUlqamowUDZSclBIWlJLRmZCMlNCSzFiNUc1ek1UeEhvT2FCWXk1YU0xWjha?=
 =?utf-8?B?OU1mMkN4a1dNTUtoL1luL3dFMzRhUG5tZnUvUzk0eGI5QTFYcnVJZ0JtNy9O?=
 =?utf-8?B?dzc0ZURlM0pDbDNQeVJSazhvQjh3MGkraGNVczdwL2lYSHBPdWYwMVBpNkRy?=
 =?utf-8?B?RmRNMUE3bHJiZGNmYThHMXJnTmUzaktCZTgxWmRGNjZFQ2l6Um05bk1iSXIz?=
 =?utf-8?B?bHZ6ekxDK3VlRm1JN1JBdHhSSk8yUlBQL1lWdmwzRm41cE05NTM5U3VTZytk?=
 =?utf-8?B?RklpZUVQNlUvei9ka1BPb29TUnk0a1Uwb3Y3Ni9VRFF4UFlqanE0c25veENp?=
 =?utf-8?B?Y3VhZHNna0hnZUtxcVVTZmlDWHhPWWZnWlJMcFk5NE1wOEl6NXl3Y25odzkr?=
 =?utf-8?B?N1FVMUF5WUxKalE0d1daYThJUjRKNVZCMWRlNUYxZEFZN3EwTUh6Y25aUjM0?=
 =?utf-8?B?YVRRY1JETHJsSVFNS21HQ2xxYTd0TUdQV3NUUjF4TGM4WnZsMXVkTTVBZXZ0?=
 =?utf-8?B?Z0JHQ09yek50MVhBUVo4OFJ2M2hlYjZQU0pXT2NMNGQrbTVnRGNSN2JoMjlr?=
 =?utf-8?B?NkJNeTh2clR5bitWVlRlTDBXOWJzTnlZM0l1aXd1KzBhTHhyeUV5aWtjc1dy?=
 =?utf-8?B?QWczaWxRamNkdVdXdXoyY1R5VDY4RU5vOXMrYlJoenRMT0JxZ0N2bm5uNGhk?=
 =?utf-8?B?TDR2QlY0RlpRNmlXMTdXSjZvNjliN2tGb2k3eldGQUd4ZlJEVm9jN2ZLbkFV?=
 =?utf-8?B?ZUk2UmUwVUxnOC9qemVtcXFvZDlFNElVR1cvSklXWVREcUJXbFRqMUtyYUY4?=
 =?utf-8?B?U2YzSUdQSkFsbkRZQVp3ZDZqL1ZQN2hqekxXWlN4MTVVbGQ1U1c2Zll6TzBx?=
 =?utf-8?B?czNUNkYrbE9iZ1VOb0dNN041WnV1anJHd2ptbERma1Vpck9aMHozbmFLRk4x?=
 =?utf-8?B?YXd1Y0llR1VyUWpQRHFXbXA5enU3Y3IyWHBPVm1NNnBYVUt2Q0hlMHNlZGlC?=
 =?utf-8?B?U1pvc1BRSUhCQW44bWxuQ1pQVTlTVzZIWWQ5R1Q3LzBEV0E2d0VVamhlTTJR?=
 =?utf-8?B?V1MzaEVGYUoraHVHWGlEblZkNVBNNGZaTkNUc1pwT0ZlTmZ1UFZCaE1jZ1Fo?=
 =?utf-8?B?TXRZbUJSc0lud29ySkY2YUU5b1hFb01odld4QURuZTRLOU9jaXl5cWh3Zldn?=
 =?utf-8?B?NTJTNWZlYUhnRlM0bXhqdzBGOWIyM1FydWtVcVFIQXNLaW0wUFM2Z0ljeWlS?=
 =?utf-8?B?Tk55aXFjaDVMQUpvdEQwM3JHcW9ldUlXSnVZSmwvdnowU3ZTcGhCRXlmL29D?=
 =?utf-8?B?SFY0YURQRDdRbVU4K20vYkxjTUVzK2dGcmUwWXpqeWV2UFRnZVVrMUl4blUy?=
 =?utf-8?B?VS9ITEVxUWhldmlpcWdXNDJvWjFCeFE5dllwR3dRdW01ZmJyNVdqamlYZmsx?=
 =?utf-8?B?MXc3NkxRWEhkNjhyb21kaDQ4MXNFeUtQc1BLQ2VsT1d3cTV2UmF0U3RZUENG?=
 =?utf-8?B?VXdyanMwUk5jemN5cGFqTm9aeURRZTYraXFkMXpQVURlTG54SXNncnB6T3Fw?=
 =?utf-8?B?WmhIeEhxQXZVMGRLczhNcXRTYzZlUHNyaFhDVnRNU3B4S1Bkb20yZGNQb01U?=
 =?utf-8?B?N05DNDFhd3lDSXZsUmxiamRUQ2xiQjlIMVVpeVRsTE1WQlc1ejZocUcyaFZJ?=
 =?utf-8?B?OWwvNGNRMlNOMFZta3lEb1A2alJKVXpmNzk3SmJPWlBNOUxvczVrMy9xdzRw?=
 =?utf-8?B?K2xyTEc0RndZK1gzR2VLTGxBc0RTcTB6QUVqMUFic0wrNXVLcUpmWENZRkZp?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oyjI0HOfc3uTXMbWEphCvUakgmm4J3kTOhSax2TSRZOgdwX7ek7uiuXACWC8m7sthHSYvrxjtLm/Y0oV1WiYAySLPklfHFM+Dp2yvehNvVywSyDAreuZyw2Api2vPOenugoyUcZpvJ/LhHjnAWk4VDxmP63y0eGhU30E9wEZoypaqMv7VbMCEyjkDzL7btt2dRuSBFCcDSOj6HakV4ETsnrI4ncnXJvzfdeQ1Onw4d1lh8NW2CJQk3IPxuKaWJxHK3W27dUvWxHpUNjLn84/o4jqSvwFZROaONjCC73dJjfOO9pCK1BOOdd4XDMHFt3jWKG73CA57r0FuUYj0zcySHnzJUOnG1hW3FJxU+suutxJ0wyOlIBJrWst4uMTf0n7dGgSzukk/HoPdcJHrG33syb1OteWJNECa0Qf8pgY4bYYaEqI02FkM5AJbHHOXuZj7SjBBz0fPejC/I0qOZCz3elUhp877liNjlXGAaY3Y/a+vjAGgdPtseOESxijm1CXzlbWGN9LvNFFRX0Cns87Gdb2ZBir3/x7RDnIEumcy2imL/RIYf49q2ut02XeayOm5J9uc1bbJccE0xdXAbaqwFiDMYKbIprZZAQ3F0v/mMM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75daf09f-7204-4ad4-4512-08dd3ed68e16
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 13:28:58.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfSh2qtcyb23MXOc4UgitqUz36VY1CZtS23LmyRvUzzWkuTewmCQ5/bbbswkYYzag3EU63E3CZ7IRCT3HqumAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_06,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270108
X-Proofpoint-GUID: LMJQCAUnyVAtimdHQq-8eVM8ssrPFNNj
X-Proofpoint-ORIG-GUID: LMJQCAUnyVAtimdHQq-8eVM8ssrPFNNj

On 1/26/25 9:33 PM, Li Lingfeng wrote:
> 
> 在 2025/1/27 1:27, Chuck Lever 写道:
>> On 1/26/25 4:50 AM, Li Lingfeng wrote:
>>> We got -ELOOP from ext4, resulting in the following WARNING:
>>>
>>> VFS: Lookup of 'dc' in ext4 sdd would have caused loop
>>> ------------[ cut here ]------------
>>> nfsd: non-standard errno: -40
>>> WARNING: CPU: 1 PID: 297024 at fs/nfsd/vfs.c:113 nfserrno+0xc8/0x128
>>> Modules linked in:
>>> CPU: 1 PID: 297024 Comm: nfsd Not tainted 6.6.0-gfa4c2159cd0d-dirty #21
>>> Hardware name: linux,dummy-virt (DT)
>>> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> pc : nfserrno+0xc8/0x128
>>> lr : nfserrno+0xc8/0x128
>>> sp : ffff8000846475a0
>>> x29: ffff8000846475a0 x28: 0000000000000130 x27: ffff0000d65a24e8
>>> x26: ffff0000c7319134 x25: ffff0000d6de4240 x24: 0000000000000002
>>> x23: ffffcda9eaac3080 x22: 00000000ffffffd8 x21: 0000000000000026
>>> x20: ffffcda9ee055000 x19: 0000000000000000 x18: 0000000000000000
>>> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>> x14: 0000000000000000 x13: 0000000000000001 x12: ffff60001b5ca39b
>>> x11: 1fffe0001b5ca39a x10: ffff60001b5ca39a x9 : dfff800000000000
>>> x8 : 00009fffe4a35c66 x7 : ffff0000dae51cd3 x6 : 0000000000000001
>>> x5 : ffff0000dae51cd0 x4 : ffff60001b5ca39b x3 : dfff800000000000
>>> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000ca5d8040
>>> Call trace:
>>>   nfserrno+0xc8/0x128
>>>   nfsd4_encode_dirent_fattr+0x358/0x380
>>>   nfsd4_encode_dirent+0x164/0x3a8
>>>   nfsd_buffered_readdir+0x1a8/0x3a0
>>>   nfsd_readdir+0x14c/0x188
>>>   nfsd4_encode_readdir+0x1d4/0x370
>>>   nfsd4_encode_operation+0x130/0x518
>>>   nfsd4_proc_compound+0x394/0xec0
>>>   nfsd_dispatch+0x264/0x418
>>>   svc_process_common+0x584/0xc78
>>>   svc_process+0x1e8/0x2c0
>>>   svc_recv+0x194/0x2d0
>>>   nfsd+0x198/0x378
>>>   kthread+0x1d8/0x1f0
>>>   ret_from_fork+0x10/0x20
>>> Kernel panic - not syncing: kernel: panic_on_warn set ...
>>>
>>> The ELOOP error in Linux indicates that too many symbolic links were
>>> encountered in resolving a path name. Mapping it to nfserr_symlink 
>>> may be
>>> fine.
>>>
>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>> ---
>>>   fs/nfsd/vfs.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index 29cb7b812d71..0f727010b8cb 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -100,6 +100,7 @@ nfserrno (int errno)
>>>           { nfserr_perm, -ENOKEY },
>>>           { nfserr_no_grace, -ENOGRACE},
>>>           { nfserr_io, -EBADMSG },
>>> +        { nfserr_symlink, -ELOOP },
>>>       };
>>>       int    i;
>>
>> Adding ELOOP -> SYMLINK as a generic mapping could be a problem.
>>
>> RFC 8881 Section 15.2 does not list NFS4ERR_SYMLINK as a permissible
>> status code for NFSv4 READDIR. Further, Section 15.4 lists only the
>> following operations for NFS4ERR_SYMLINK:
>>
>> COMMIT, LAYOUTCOMMIT, LINK, LOCK, LOCKT, LOOKUP, LOOKUPP, OPEN, READ, 
>> WRITE
>>
>>
>> Which of lookup_positive_unlocked() or nfsd_cross_mnt() returned
>> ELOOP, and why? What were the export options? What was in the file
>> system that caused this? Can this scenario be reproduced on v6.13?
>>
> Hi,
> I got a more detailed log with line numbers from our test team.
> 
> VFS: Lookup of 'dc' in ext4 sdd would have caused loop
> ------------[ cut here ]------------
> nfsd: non-standard errno: -40
> WARNING: CPU: 1 PID: 297024 at fs/nfsd/vfs.c:113 nfserrno fs/nfsd/ 
> vfs.c:113 [inline]
> WARNING: CPU: 1 PID: 297024 at fs/nfsd/vfs.c:113 nfserrno+0xc8/0x128 fs/ 
> nfsd/vfs.c:61
> Modules linked in:
> CPU: 1 PID: 297024 Comm: nfsd Not tainted 6.6.0-gfa4c2159cd0d-dirty #21
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : nfserrno fs/nfsd/vfs.c:113 [inline]
> pc : nfserrno+0xc8/0x128 fs/nfsd/vfs.c:61
> lr : nfserrno fs/nfsd/vfs.c:113 [inline]
> lr : nfserrno+0xc8/0x128 fs/nfsd/vfs.c:61
> sp : ffff8000846475a0
> x29: ffff8000846475a0 x28: 0000000000000130 x27: ffff0000d65a24e8
> x26: ffff0000c7319134 x25: ffff0000d6de4240 x24: 0000000000000002
> x23: ffffcda9eaac3080 x22: 00000000ffffffd8 x21: 0000000000000026
> x20: ffffcda9ee055000 x19: 0000000000000000 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000001 x12: ffff60001b5ca39b
> x11: 1fffe0001b5ca39a x10: ffff60001b5ca39a x9 : dfff800000000000
> x8 : 00009fffe4a35c66 x7 : ffff0000dae51cd3 x6 : 0000000000000001
> x5 : ffff0000dae51cd0 x4 : ffff60001b5ca39b x3 : dfff800000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000ca5d8040
> Call trace:
>   nfserrno fs/nfsd/vfs.c:113 [inline]
>   nfserrno+0xc8/0x128 fs/nfsd/vfs.c:61
>   nfsd4_encode_dirent_fattr+0x358/0x380 fs/nfsd/nfs4xdr.c:3536
>   nfsd4_encode_dirent+0x164/0x3a8 fs/nfsd/nfs4xdr.c:3633
>   nfsd_buffered_readdir+0x1a8/0x3a0 fs/nfsd/vfs.c:2067
>   nfsd_readdir+0x14c/0x188 fs/nfsd/vfs.c:2123
>   nfsd4_encode_readdir+0x1d4/0x370 fs/nfsd/nfs4xdr.c:4273
>   nfsd4_encode_operation+0x130/0x518 fs/nfsd/nfs4xdr.c:5399
>   nfsd4_proc_compound+0x394/0xec0 fs/nfsd/nfs4proc.c:2753
>   nfsd_dispatch+0x264/0x418 fs/nfsd/nfssvc.c:1011
>   svc_process_common+0x584/0xc78 net/sunrpc/svc.c:1396
>   svc_process+0x1e8/0x2c0 net/sunrpc/svc.c:1542
>   svc_recv+0x194/0x2d0 net/sunrpc/svc_xprt.c:877
>   nfsd+0x198/0x378 fs/nfsd/nfssvc.c:955
>   kthread+0x1d8/0x1f0 kernel/kthread.c:388
>   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:861
> 
> Although I don't have a reproducer to reproduce this problem, I think
> ELOOP should be returned by the following path:
> 
> v6.6
> nfsd4_encode_readdir
>   nfsd_readdir
>    nfsd_buffered_readdir
>     nfsd4_encode_dirent // func
>      nfsd4_encode_dirent_fattr
>       nfsd4_encode_dirent_fattr
>        lookup_positive_unlocked
>         lookup_one_positive_unlocked
>          lookup_one_unlocked // ELOOP
>           lookup_slow
>            __lookup_slow
>             ext4_lookup // inode->i_op->lookup
>              d_splice_alias
>               // VFS: Lookup of 'dc' in ext4 sdd would have caused loop
> 
> This scenario may be reproduced on v6.13 like this:
> nfsd4_encode_readdir
>   nfsd4_encode_dirlist4
>    nfsd_readdir
>     nfsd_buffered_readdir
>      nfsd4_encode_entry4 // func
>       nfsd4_encode_entry4_fattr
>        lookup_positive_unlocked
>         lookup_one_positive_unlocked
>          lookup_one_unlocked
>           lookup_slow
>            __lookup_slow
>             ext4_lookup // inode->i_op->lookup
>              d_splice_alias

So: lookup_positive_unlocked() is the VFS API returning it. Got it.


> According to the information provided by the test team, the export option
> is "rw,no_root_squash", and I'll try to reproduce the problem.
> 
> By the way, could you suggest which NFS error code would be most
> appropriate to map ELOOP to?

NFS4ERR_SYMLINK is closest. But the spec says, you can't return that
status for every operation; in particular, READDIR does not allow it.
So I'm quite hesitant to correct the crash you found by adding this
mapping to nfserrno.

In this case, I wonder if READDIR can simply not return attributes
when it hits an error.


-- 
Chuck Lever

