Return-Path: <linux-nfs+bounces-11269-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF68A9AF1E
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 15:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BB7467E16
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DD31714C6;
	Thu, 24 Apr 2025 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XTuCOB9R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XLSer4Vz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD813B5AE;
	Thu, 24 Apr 2025 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501645; cv=fail; b=TZkiARRXJEewXfv9kHmbGyOVCZAFSoHOYRtBBIHSPNzCzIDPUFIbCOq9zEo9Iwbspf8TdwkPm/3+2RgksOSJgZwy5m5KDZcVJ1tJhBpEAHGvO/OGKpWLZrug9/EHloMBf3bQRAOLyxk/bmBwsgVa5W46z8b4hwGwbl0322jKkTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501645; c=relaxed/simple;
	bh=YI8ZJp/s2SqrAAK4f+sVD32FBKNhgf+RgXVMFzTgJ+E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VRzo1nvyB4J2HMRdap97sG7gQIlPqug0MWgp/8FR+SAbaRqFvq3yfz8Baj8bOb81JohFMYm1ZkBvx/7Iv2tOPYCHlChP7f9n1FWfCqJAS7mJ7kwsCpDbiz/tuQJAUxBrGgGdd9/dVbvpxjilkktFZcEhx6cbmkCbI/QvL+oSLLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XTuCOB9R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XLSer4Vz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OD4oK4020779;
	Thu, 24 Apr 2025 13:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4qIUXoE9G46hpVbZdsFvcsA0xe1O18cT4Yw/ZNHjeEo=; b=
	XTuCOB9ReFkeywO48J7ks9QXM3S2IusbvrEj+vphuHpGNOLW6mzYa03f/q4qJnUI
	rDqX1mrobKCzEQlcvJtFkUNFI8K/Z8ldLJgBIOIs9a5IjfIL906EqSIQ5+o1+F0U
	gXudx3krKWM++r9BQM8xO0I7hA3JFhGBFzcIOZO4xfpaz3Kc770v9sG/uPqiEPIt
	iQGzRyU61d71hToVFu6VMKb2TOJAnEEzscQvrGaWCJn/XBUwqL5ZmDMxSe9vqR3L
	pUmL7aY0pbh2X79gI0a7SWUhzllTWvzS8ZTxbBWrjIORb5LA2yAgi/Q6JADNqiag
	7vBgYHLth0OB0k6LMIOnPg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467nvar4tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:33:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53OCIADB031145;
	Thu, 24 Apr 2025 13:33:33 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011031.outbound.protection.outlook.com [40.93.6.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k079emv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypoPZzd0tbbXNcDfD+visAPoY3UyQJ2fUQmdCtW9VeE9wDzrqoEztoRor76Vq3KRKiFahfztcZj29B0DexRyBnmWmadkRe2nrjSmKeM0UwkgRwr/e+ySmJCx8a4etNpvODyXYrbXLPf1Uc2JkyKmxdLr98Ljaipf3vnT91Hx0Yfp2mu4dGymeGe+Fz6fUiLwCwfjD+PSp1Kpcnm9VGW5DjSw6SWw5TBqGJGFpg8bzjm0wc3DTh8r+n1uybQjP7pFRpwlQ7St8/EZzrGYIbq1Riq1kEOnS2WeTYyR7NonjmMzj9Jfge8MGWHUD9WMxJWYIP9cRdAHq+9rYPKBv3HmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qIUXoE9G46hpVbZdsFvcsA0xe1O18cT4Yw/ZNHjeEo=;
 b=fzUovQO639Rb0Dvyo9xoH0Y9sF3feP2W1xKs2Mb6RAFcGv/wys6KIJ7OZLPJjtAO3Iwi3CmLp5YGwSwWFnzAnBIQjVdaLps0iLYA/yQOgmaKfvZIrOXd8bVaVVU84FFA/WpLPs3Xj9+h9+UQUID0kYixsmUEVrD7KUUI2e/MiknzbSWWcx6m3oX5kmaa8LS9kBtjXe2Y/if8Qx6B5MrUQX33oOvTWwTG7NgRRmY2GjAGTBeyT7dn2n/niMYp/ezCKgJR00Q7g0k/bCk1WJVrlLiX8IzXVH3vQ2QLxh+npS2QRh4WkgCkoF4N0eYQUCRnmRxI0CRwKF3P97etUyQqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qIUXoE9G46hpVbZdsFvcsA0xe1O18cT4Yw/ZNHjeEo=;
 b=XLSer4VzU3IQXLjj60vX0cw30Qpn2T+lzjbZtKjQRe6Oe2Rd+g5rqNQJEi10nd/y7e0fDam8FLKUna/2U+vnnlvmOWAM/tnA2RtuEbd0q9OOpZHxv4wQPCg/5ng13bU0F+0hcLlaZ9z6GVHkOFA5VWvnHFVXHMNVZfvLoj4UslY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7016.namprd10.prod.outlook.com (2603:10b6:a03:4cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 13:33:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 13:33:29 +0000
Message-ID: <9cb6e931-799b-46d4-b773-9b6fb4fd13ec@oracle.com>
Date: Thu, 24 Apr 2025 09:33:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc:
 clean cache_detail immediately when flush is written frequently")
To: Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-nfs
 <linux-nfs@vger.kernel.org>,
        yangerkun <yangerkun@huawei.com>
References: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
 <5ea1bdf0-677f-4187-a626-a08ccd2ae7e5@huawei.com>
 <CAFqZXNtN_yv-KPfyrnaezX6QturnSbKGqgiY7ZBJmCg533u-+A@mail.gmail.com>
 <CAHC9VhTMc0kJo3Fh-CPPMz9WghANRGB6NpZARgvN-srDJeeXFQ@mail.gmail.com>
 <CAFqZXNtZLPpspu4PcXsSU5Q7H07wgKGS6CmtOaQVXu9OujDiZQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAFqZXNtZLPpspu4PcXsSU5Q7H07wgKGS6CmtOaQVXu9OujDiZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:610:4c::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 97340d8e-fd01-4311-912e-08dd8334999c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0ZmbklLQ2lkeXYyVXVOU0RBbEdxYVJZWmcrVld6akJlNVgzcFdLNEZvK01k?=
 =?utf-8?B?N3cvZ2NEbkxrUFBlSTNZMHByS3BYeTJCZEEvcXRxVHk0YzROeXBrUnkrNEtq?=
 =?utf-8?B?RG1hVjUweUZycGc3V0N1VkFWMzBxZm9qTGFIUVFzempTNUZieWUwN3JFMGNZ?=
 =?utf-8?B?R1RCZldkWStuWTBVTTJpUmFScXBtTUc2dzNkZmN1S1IxRnNXUDFManFNMTFQ?=
 =?utf-8?B?MjNnVnBuemVCd29rS3lqMkJJbjZYRGtKNVkwMGJlZHhpN0NoVjFjeWl1UmZL?=
 =?utf-8?B?amxZVi82MGhqTTgxNnQrUitKblBwNGpqR1U1eTVvY1JYVnVtcE1sMlN3cU1s?=
 =?utf-8?B?VDY4aUc1ZXJaanVMVm1MZjFPYkllaktsKzBxNGJ1ZFI2MnJyNDkzSHdDN3Vp?=
 =?utf-8?B?THJjR3hGQmd1RlF2ZjBVSjV5S3BCcFJhQk9XSnFQZ3I0NjNicEZkYXUwWnFn?=
 =?utf-8?B?OGl4ZkhYTjliVUYza3h3Vk51K1p5T0NlaXhQUlNTMVBPZ2s2SlBLQkRUUlNY?=
 =?utf-8?B?bWwyS2pidTFYd2cyRXJQYU1hY1N3eXdGYU95NUFKK0dPRkc3Tm1ndlFYcjZu?=
 =?utf-8?B?Z1NBQ3JJbEl4NjBTOTZhbnBiVU5lN3ptSjFhS1N2cHZRQkdFQ1dXQ0FDQzhh?=
 =?utf-8?B?WFRXVERMUGY4c0E4MWY2ZHVIRUNYV0ZHdW5tc0JyVFMwcGdmWDRqbGlHNnVi?=
 =?utf-8?B?MVFrQldraUZIcWRIZ0svZ1JuZWo1dktYcWhMdzVHRVJoZFBjSmFCSDRWUmtI?=
 =?utf-8?B?UFd0RFFCOXdTRC9rMEptNnZXM0ovTUZIbWJhUVpjeFFoVnkzZWJSajFWamg0?=
 =?utf-8?B?T2FORlVnUHRDL3g5Yldpb2haL3Z0aUtLbUNUeFcrL1BpdTRyTkljZnJ2SFRo?=
 =?utf-8?B?VzJ4SXJFZjJKYS9CR0V5WmpvN0Q5WU96RWFUVzhjcmtGbG4zZ3BoZGtaNHVn?=
 =?utf-8?B?OUtmK256MkMrd0JlejFLczllOTRIZ25ZZ2ovc0RwZmFCMXE4dHZRTGlDajAv?=
 =?utf-8?B?ZVMrVW00anBOUkdRaFVzMk9zcVpJSktLaXZHcEdiSlJVTWk0QjRzQlRkem1x?=
 =?utf-8?B?VU9ndml2VWxBR2d0T2UrN01LTlNYVS9nRUprK1IyZkdQQjA4Q3kxYnJuUjh6?=
 =?utf-8?B?TGNTK3J2T1Nob0pmeGdaYWxzekwvVmRiSEpqZXR6LzRMcGNPc0VQNk5RZEwz?=
 =?utf-8?B?K25iYURWZkhvWTZqbTErbWp6cHVFQ1U0Uk8zQWNGdUx3VmdBQldOMkxiL1JF?=
 =?utf-8?B?d3hkeHEySGppYThtTmN3OURNdGZoeXVnTm9sL0xiZU9zbCtmcGd1RGc4SlZH?=
 =?utf-8?B?bUNRNi83aXVWSVZKY0RJYlRLanB3cWlpcFJ1TjZjOUhHelluMWloQ2N0TVdQ?=
 =?utf-8?B?TG42L25sVjJmOHRNMVp2VkJ6OGJGaXNvTWZwWE90Vmtxd0dUNE1nNGFqVjVD?=
 =?utf-8?B?ZXBQWHZBN2p6d1NYQlFBT2tPVzF3YXJKa1pLUmVQdkxWbHhYSEJIWmR1TUJF?=
 =?utf-8?B?SzNvSVRaUHpSWHJkVnJnaDhyandsanFDUm4yRTZHRkVUU00vWC9PU3kxYXRw?=
 =?utf-8?B?eEpoQ2kvUmxrbStmL2tJbzFGUmttbjNlNXJYZ1VBVWdZb1gxMkpQWmpEZko4?=
 =?utf-8?B?TWNMYVo0QXRaNjl3TWQza2NYMFJtd2VRd05HOEoyZld0LzIxOUFyVnhmM01u?=
 =?utf-8?B?TUZ3bVIvM2ZSZGoxb0ZRQmNkdzM4YnZmQ1AzL202NWtvY2FxaS9OZ29GQW80?=
 =?utf-8?B?TEpOUFdIOXZNRUo3NmszK2R2ZnNlUTFGL3lQZ3Bhbm5jZHpJWFZrUmxPL1BV?=
 =?utf-8?B?ZUk3MzVWdHVPVVYzY0hBZGFqSVdaeEhSajkxc2REdjl0TlpSTlZVNkdpUm9E?=
 =?utf-8?B?S1BLeFNlNjdtbzkvaVM5cmZSckx0NXd5dmsxRW5zSjBaWExDcGh1eDBMRk53?=
 =?utf-8?Q?m9YzcJR3PMo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2xPZjd0Zk55bDJtOUJkQlY2QjVrcThMeFJzN0tzMy9ZZnhQT21aNk1JNmpV?=
 =?utf-8?B?YklZaTQrL3BuZ1ZSR1Z6UCtwQlpLd2RmNVY4SkZlOEVkOFIvT0ZTeGE1dkVt?=
 =?utf-8?B?bnNGZW5xWm8yNWpuY0tFeUM5S1VJVmM4NVZlM0Z4aGtiNEkyZmEwRnU2UWY0?=
 =?utf-8?B?cldTc3VZcHdUZ01HQzNRNmhPN2RydklPT1NyQm1IcUpvemNId3RWUktsei9p?=
 =?utf-8?B?SU1XRFBxaVRHTXpxRHNoemRKa2g5NGNiaTZaeTBHTGhmOG41TjZqUGJhd0NX?=
 =?utf-8?B?YkJ3VkR1V3NNMWZCd3dDckQzdm9ZOGZ2blRiY2I0K2JLdHAyZlNMWWxNckt0?=
 =?utf-8?B?cFZJdXlMcHJiZWl2YXFvQmhObEdMdzI0aXNUOFRwN24xc2FmVldNVDJUZFJV?=
 =?utf-8?B?TmVKUnFXZTFPMjR0cWoxVTJVcnlmS3l0bHVDblFuZ01xOGZib2FzMmhsaWdT?=
 =?utf-8?B?aEJaTWpyd3BBOFkzWVZwK2k1YmJwWVcvZFV4N2xxUWpkRWJGRkxXRVMvdDRl?=
 =?utf-8?B?T05aMTRNaXdnOVRYNHorVUdNVms1VXB6QUdqS3UwcTJNa2kzUHNoZlNLcEZn?=
 =?utf-8?B?eFlaSFpMek1HL3ZtcFgwSUp5V0ZuR1d5RWhsQnBzeGYzOC9XcG82eVV0WXRM?=
 =?utf-8?B?VWNZMlpRWHAxT3MwNlg1eGhQSzRCZXdTRHltejNDemFleGoxd0twNjFjWVlU?=
 =?utf-8?B?N254UUJjYWliTTdWSDlQZTZkQVhQYlFVaGVPTjNQcDI0N3VjM0FSU1o3aWRy?=
 =?utf-8?B?eWd5UXU3VDRNZG5NRURBTjcvWmc2RStJQjNLdzNZVXVRYjAwZS9kVURZNlAr?=
 =?utf-8?B?c01JUVltWGNlcnZrWUV1THVBVGZJWU13OVpiMkQ4bnV5WHd4NHhsdWJnTzlD?=
 =?utf-8?B?MEpvRzJDZGRCVUNXUjJtVHprTHR3K256Nk9TZDdCbyt6QlNJaXJTdDAwODUx?=
 =?utf-8?B?eVg5WUQ1eXZTTEVSaDdHWFYvM1NpcE1EZnlPOXErdThvT00vdmhpUEEvUTky?=
 =?utf-8?B?KzU5R3UvSi91UmxyUXBCSWFpNGpza005OUR6NHpJcHJiYkJjVVNlSDlGRGVJ?=
 =?utf-8?B?Y1JEbnpnQk5rMk5tcE04SlpCZWk3OGgwV2xObDhqTEF2UFphOHhoWmg3ZmFI?=
 =?utf-8?B?RHFpeFZSMXpBRTFLcCtUYm1PMHh5M2pwY0o1VTVjRWVEQkZleC9VU3AyeEpC?=
 =?utf-8?B?YnJFcUU5eUt5cVZiVW5CRmptTERtWmw4cEZ5TlpMb3ZxaGFNWUxJSW9heXJS?=
 =?utf-8?B?UDVIb3NtUTZpQmpJejV1bE1ESy9rc1g4aXpQOUs4U1cxdkw3Vll0WE5JNS9P?=
 =?utf-8?B?TjR6UW1yQ1BZM1pyRjdXV01YT0w0U0VrU2FrT0x6bWdvak5lZEVEdEpKTjh3?=
 =?utf-8?B?TUtiNzNtSm4yN1ljTUVDKzUvck9WeE1zdGRmUUZYU0orT242cmdldDZkdVBF?=
 =?utf-8?B?cmMwTXpLMTRNdGEzL2tMcFlSUFJRZUNFMFN5NTdPcW9EdlVxeVZsZm42SnRy?=
 =?utf-8?B?eUlGbzh5dGg3ME5xaWtoTXE5NTMvdXZad0dXMENVRFZtSWw2RUUxekNmVzRW?=
 =?utf-8?B?VDZLc1FMV1U4TGkvWDNoT0QxdnZuenJoWFQ4OUJQajNzTFFtWnRMb2pNVCtX?=
 =?utf-8?B?MzFFaU93ZjBJdk9aY1VqMzcrWXBsSzhUSU1OSGRQbEk3WmFRZk1aOGJCZVdL?=
 =?utf-8?B?MWhManhEby9rRVNJY3dOcEpqcW1CaWRxbTV2eGJpN2h1U1FGREczY0JzWURo?=
 =?utf-8?B?aVFMUVpSVEFYb1FFR2NIeVc5MzI4VXAwcXlpZ2lsWExhSHRhallmWjhvOEZx?=
 =?utf-8?B?UmYxWG9VSFN3U0xObFRlMjBBbzExM0VDL2VIWUVPT0RhOVpDaWxjcWxTZmc3?=
 =?utf-8?B?S3NpdndDTlVDS0hxVW9XWjlJU0VjSzhtZkhzNkpnTVI3V0hLUTBwaTQ0eXQr?=
 =?utf-8?B?bTRHQWwrMXBQVjFmcmNFSHF5c3l0bEV3RHJOK0plZmpvLzNxUWxpeW0wZFJC?=
 =?utf-8?B?WEREdXF3VHNDRkhmSTVIUGRYb3hQL0ZvOTI5S1lrVktoQVBBZGl4TDFVckJr?=
 =?utf-8?B?ZkEvUnIxajgrY0hkOHVkNGxaYUNUNEVBRUxuL2c4SnpHcEZ3U0RIQllFcDhT?=
 =?utf-8?Q?4Zswqkmi0BAp39wRdKy/vCTPU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CRSvtyPN5xssH0WRkkW10zUyrkSE5cTECsBbj8/wldADStAdXjuUvb8kuS5WdiYoGZvcEmCScNAgtiKdXbmr4MOtvpsx1smQ+bow6gx1q8dOVWU1+upbnpjK2Vl2RUgry2Hgo71qQFNyqoVWeO9q7oFDjmzVJ2Vm7fgEpOH1YSWhryQkhl5+HRaSiUnzJRgJcFcRYiilFynZwJpboiyi7l6SnhLiGhWJ+o7FpWQEzDLDHY3vfLEcjOfs65NsI7iGrpXjfGdR/pQjBlYaj07/eq0o11v+56fGGL++mhkd6OZCpWkqb+tdPnwGX6oaVDQpeAdCkTdEsOnNJZSEuaXgrJgJulgLEPQKOKv0TvzQJGADw3LzvjAzkThmswkGbjU076Ay38JVKXUQgdFRW1as3D4yD/YPWOOaTqSAEo3ye7Hfsc/nbWEfFts9/i76aBue+GbFW0bRko4L935CY3+GfKw0ejgNfmyx6pEwpGwQne/KKI410O7EOD/b9dwt5kCzH6gi77897MlZ+WFBT36rIZQoaTE2sbJQ76UYk7KFW3OLsVt0yNJMWSzev4YcsNxpvskvyYN/xtQsriljgMRlw5jHu6RjxU0z9JkFwKHLm1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97340d8e-fd01-4311-912e-08dd8334999c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 13:33:29.7688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwfRQLsTd8/EN3VB74U5YePFk2DP5s3Ie6+cRRbBH9eyC3tS0aqHXc1YqsXDBVRhb/fSvvC42E4Oe7WS6sfnmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240091
X-Proofpoint-ORIG-GUID: 7-wd4YvtbbZCr7CfCav2vm8EM38UbdGL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MSBTYWx0ZWRfX4YQMCdiACRtd 8s0PEzSS9DPUcayhJYyM9bGf0rviRhgwwqIgOQ4PGnhtGjz2X4Q/LnIM/KjyAtgTmQuoofA2Aea 4aDVxbtJkGRXF+ZSe3647Uhp/AilDnLYaIhzvrSwB2+hEv/yWmt3Nmmy5/jKWdy18t1hEHkk9XR
 k1XJd/TMnOCzLBLari2Tuw+hofYughip2s4cv/XDEdlAut4sMljF1mLSbwCFpn/mFa1boX2fHIE d3EQ/HuLgkZ2aKbtuXFXV2T9Y/GytQzGuC+cEIpW+fXfsV14oq/xnzhBxjTR1NV2PGpwe5/Y2Rd ivNE/bGct8o4XdU6ZDLF4T3W4mj0OT7TlMaYCQFA0OXZGNifSIjUzbAQ5ItOBENydbRXgZT4He7 tjFrn6zB
X-Proofpoint-GUID: 7-wd4YvtbbZCr7CfCav2vm8EM38UbdGL

On 4/24/25 4:45 AM, Ondrej Mosnacek wrote:
> On Thu, Apr 24, 2025 at 12:37 AM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Tue, Apr 15, 2025 at 5:22 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>>> On Tue, Apr 15, 2025 at 10:06 AM Li Lingfeng <lilingfeng3@huawei.com> wrote:
>>>>
>>>> Hi,
>>>> Thank you for reporting this issue and sharing the detailed reproducer.
>>>> Apologies for the gap in my knowledge regarding security_label.
>>>> Would need some time to study its implementation in the security subsystem.
>>>>
>>>> To begin validating the problem, I attempted to run the reproducer on
>>>> Fedora 26(with kernel -- master 8ffd015db85f). However, I didn't observe
>>>> the reported mislabeling of the root directory.
>>>
>>> Hm... Fedora 26 is *very* outdated and not maintained any more - I'd
>>> recommend using 41, which is the current latest stable release. Hard
>>> to say if it affects the reproducibility of this bug, but it's always
>>> possible that userspace is also somehow involved.
>>>
>>>>
>>>> The modifications introduced by commit fc2a169c56de specifically affect
>>>> scenarios where the /proc/net/rpc/xxx/flush interface is frequently
>>>> invoked within a 1-second window. During the reproducer execution, I
>>>> indeed observed repeated calls to this flush interface, though I'm
>>>> currently uncertain about its precise impact on the security_label
>>>> mechanism.
>>>> [  124.108016][ T2754] call write_flush
>>>> [  124.108878][ T2754] call write_flush
>>>> [  124.147886][ T2757] call write_flush
>>>> [  124.148604][ T2757] call write_flush
>>>> [  124.149258][ T2757] call write_flush
>>>> [  124.149911][ T2757] call write_flush
>>>>
>>>> Once I have a solid understanding of the security_label mechanism, I will
>>>> conduct a more thorough analysis.
>>>
>>> I'm not sure how the two affect each other either... It almost looks
>>> like the last mount command somehow ends up mounting the "old" export
>>> without security_label in some cases, even though the exportfs
>>> commands that re-export the dir without security_label had completed
>>> successfully by that time.
>>>
>>> Thank you for looking into it!
>>
>> I just wanted to check and see how things were progressing?  I haven't
>> noticed any failures lately on my Fedora Rawhide + patches kernel
>> builds, but I wasn't sure if the problem had been fixed or if I've
>> just been really lucky :)
> 
> I can still reproduce the bug on the latest Fedora Rawhide kernel
> (6.15.0-0.rc3.20250422gita33b5a08cbbd.29.fc43.x86_64), which is based
> on commit a33b5a08cbbdd7aadff95f40cbb45ab86841679e in Linus' tree.
> 
> Can we perhaps have the commit reverted for now while the bug is being
> investigated? The change doesn't look essential and should be easy to
> reintroduce once the bug is addressed.

I've queued up a patch to revert fc2a169c56de in the nfsd-fixes tree
for v6.15-rc.


-- 
Chuck Lever

