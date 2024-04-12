Return-Path: <linux-nfs+bounces-2793-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30A98A3707
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 22:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592C628163D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE81914A091;
	Fri, 12 Apr 2024 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d99S2hYe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0FUNs5BZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEE83D548;
	Fri, 12 Apr 2024 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953458; cv=fail; b=kEM+hKn8Hfycyk9RcL38emNXVABR1qZDlMEOKdyBfwS63I+KWc/muFmA+zXP4WhHXw86xOpOXUXQDMQgFYBvl/wxVOmGFtDcEYQ0026IW0swPluEOlWqCkDrIPRlw/eUBVT8Dp6x0BYQdBA6zm0VKWAORY6yttRh8Am6tiPZ3Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953458; c=relaxed/simple;
	bh=HlBj0rUUu/GXvA9DO+IFLPRjDcwUpmnj/eOMTu6l2cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZuXKf4hbb2vw8IUqOr3N3DJogVYd22xAmA6164m+iMjXThrqxM7qYlB4BULEzQvd3fLycQOkPPXtlN61JOE8abuKco5LLbsnIWW7XznJ5yO5FJez/JpB/d6PJ4y5GzUQ144+QZosx4JC4o/4goGv+ZGK3go3ABGi8v5QPHMLptM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d99S2hYe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0FUNs5BZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CI9hv5027017;
	Fri, 12 Apr 2024 20:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=pmvskkbhU0nFZEFJpMUK7Ce2auDMDFG2zfPYEeVgvQc=;
 b=d99S2hYeOYq0VeE/MWVMV9pqDTuCch5SOd3/X5u+tkkEVmJk0URLotY81ytp3eLfmFZy
 fA2t3NXQBkPoMVSyzaX2oWd9azD3pe42Tjg+tGFbpRdx9/7aAFm71Eo+PbFB8tNTptsC
 CXjdp6dZawo7Eb8Nzf8weOm80LpQsBm+wnXGWaQrLIVYx0c0kVBKZ+W8LpwME+D9719K
 DUhOvHE5Izzwg4KYVeWeZBv3MZy5ePc8+dL+4FQUQyJWlBS0wdieqZfZ9gpiYnIWaBbF
 gmppzBzdJPXEQxhixtcvH61gZ7j4m0uGjQFcmpLafHLMlXsZD+78keGrPVkClX8AfVJY zQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw02ct7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 20:23:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43CJ5KcT002879;
	Fri, 12 Apr 2024 20:23:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuhrh7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 20:23:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI3jEznFHEHiMmW4AhCxli0pam/9kckrVYb11C+OjjcnrR0GXygRsSy9yNgaMlU5aqy59NyXxc/7trwB5itljkZmpsam+7SyPBHlulvdTGELHK/ULN7qC9wbfobCl2jocXdnSBTIt1q0NIAIAPpuPV5PyOsD73zyAFP+zvRXpWc9zUEMx/AALR5gwOgUy+E0PQnaoFqZhGMMdW/BgnNcst1WIQO/cZbK/IsYIuybj2a+FfLaOvv6b8FapDfU+fGhyOgw6+w+NwcMHyDvw14tF8uz5FdbpLz/21KBw4YLC7YPFTF13s6XeBUGcMtTbLCJdiR6HZyHvcrb0csT5br7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmvskkbhU0nFZEFJpMUK7Ce2auDMDFG2zfPYEeVgvQc=;
 b=XomWFx1PaDf+w8irGRlDMk7Lt2QY6jqW5KT3gxAh25wGixig5Es8m+OkL2PMt/j0FQyyBi2q0D7MhhLhdPXRZvYROs18zS4iSbu9MWb8IIqGnDqpz52An6+7wxL+0xG0K6d/z1LXGBc24MCqvRdVp8j2lEWwzxStidBoqN9HjVo1aVBUQNBlCIFoxXk/WwhHEM2DCBvaTgx7MsggMvLC34Zk4kddd5OPSCHqVF4UbVR2Io3YXz3H/dE+P1jj6tT326mRNnid7aAltbZ8qGG1Nz5oep17mSLHgNRZVS8eWbmVDhij4+1o7tSeqG3jPKyI6bJyfthuDnjS5/IfFMOEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmvskkbhU0nFZEFJpMUK7Ce2auDMDFG2zfPYEeVgvQc=;
 b=0FUNs5BZfAoTYIa40Eo0Mf/1lP2QT+22hm0uC/3r1NGTJ9c6JjUz3w1/5kHgdDPrcCwQFZZ59XpB7CF4HGmaYu6GSa8H6KCZ0kb78qR2Z/25SxQQrx+WaZmzTwBMLyx8Q2WU6ZH2z/X9O08PTxkJKjAWmASaG+vS5n9XMHpsgeQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7687.namprd10.prod.outlook.com (2603:10b6:303:244::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Fri, 12 Apr
 2024 20:23:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 20:23:43 +0000
Date: Fri, 12 Apr 2024 16:23:39 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stable <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Calum Mackay <calum.mackay@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
Message-ID: <ZhmYS9ntNbDZvkKE@tissot.1015granger.net>
References: <20240411095407.982258070@linuxfoundation.org>
 <2c2362c7-ace7-4a79-861e-fa435e46ac85@oracle.com>
 <27E1E4C4-86C3-4D78-AF85-50C1612675E0@oracle.com>
 <21c9bcf9-2d44-4ab2-b05c-a1712ac1a434@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21c9bcf9-2d44-4ab2-b05c-a1712ac1a434@oracle.com>
X-ClientProxiedBy: CH2PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:610:5b::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW6PR10MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e16453-3ec7-4667-8899-08dc5b2e7318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S+TwmccRZM/qw4RtIIUcmcNm6/pbHGo0mtV3fNzlP2O8QlQ2Bs4bJZGY8ZKKk3th0+/1CSYUfvIZkPaw0nQPlfrUK3rKaWS96+EDHUlceFuJqaLdWL3yIqxtybh6nxYAZ77pvedcshdjX+b0AG/LIXCa3ad9+EKJi4EeSjAEDNqabDvd7zAZ5/E3lzD/wp1Dp9ZgXEYxU4QmgY+xuejynnzVzYheAQu8f2EGTYEeLdwubENOMY/OBUxLDZ+Jnh+1zP4sCCQVYDMqu8TQ5/+EGIQdgnoJ2b/ERwVg5wy1cXuVNaotMQ7ipQfkcHIGM1r0k5l6I0hh9yDDU6ua+ETw5fMhFh46bFdK0ZyOxi9FiOzt7SYi76DTbtBnJ0tdX728+RNJHEJu2Pu5s0t0BAmsvxf8VX8xz7zmeh9FkpsSBn82uay/WISXdjFiTGIgoCo7gdGQfdd/4wEy4uUsnGSCVUocOt7Y2Bi2W5At58Eeh3Rxgh7b/w+KILa5Y8S3T73kQAoHlfYwtWSNsGIdf8bVy0tdztX+K7IjkZVORa98sG+MpW0BUIHwrzzZePJDhpFp9WHV2SINzLGmUKNKp5fMZi0FTK8DfXJUWpNZMf2Jy7aaq7IMlWJUKH2t4LGwmHPKHlEG94YIeNkHKfRezVIQbIt6+WEcQbsx3NYsFM0d4G8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mM77e4n3UjYB3NrzfZWOiGx188K1rbnRhFnmFRAylF1eUHCpGmLQHGujRxbA?=
 =?us-ascii?Q?n+uuqd0Zy9KjM9/3aPl749HYZIbYEwXpD+hs1Q19cYNHj9xIOb5012xkgJjb?=
 =?us-ascii?Q?utYLdj0d1ABKQkiUe/Oq1I0rhunJ8wG+SwsrJLumjpI5c75XsR8yDAM6BUaZ?=
 =?us-ascii?Q?YPlTAsepFmLzUSAbgwgEXmnCGJj6GIdbQQy2+PjHXbsJW2dVMRQgdL04z6Ry?=
 =?us-ascii?Q?HiM4d8oIoKiw5dXWxh7cD+4G2z2M6dVeyZfhYsBnyYxyvrAjpmzAN5zaKJQH?=
 =?us-ascii?Q?1lC8gJ7VhuDaEbRMDqkh3JTG2gmH/CECOuG/9Ds8iIuSPXLO+/lq0Sr6O+/i?=
 =?us-ascii?Q?hwBmiScz9JWaL61wOeWPdPfzhzfFSaYaTKLpR3lWC37rorWTPykKtZm6IHAR?=
 =?us-ascii?Q?MGdhqDpl1Ae5FOvYg8ts3h4nTgtRaBA9iyp7pqm9YJCYdfl/zKbDx5XxRPou?=
 =?us-ascii?Q?z1SRmmD6M2hpUMbFqwtlqpdy2OwEm0E83mwqaPRsRf6iRUejAfTX/lMrNy6J?=
 =?us-ascii?Q?fw3T2/eKAh/RdB31kQwTaLr7ORtJo2HxiJflg+GxadaBNJWbXJe4vpQ/njkZ?=
 =?us-ascii?Q?ETbHCwuE55cl/A+iEp2/gzOkLLB7EX433iiKlyzE+pA/bOEbZKU1RcEh1NxD?=
 =?us-ascii?Q?GANek/IFO7vCc8BP5ekSaNDUJKMqfynxRn3V5YYNE9DEOKqgOAPlM9M7v/q3?=
 =?us-ascii?Q?m6MWBMB7qRMr9SMv7+XvCKmdO84KsE48Qnd1DKcAKvIVU38fgSrthJZ8+93z?=
 =?us-ascii?Q?B70dT3gJiUHFus3D3bawzSWY3/+oOHFGiyOD5uiF3//zsew4LC9tTtQiM9Is?=
 =?us-ascii?Q?SAI4nXKsqMhq1P1AP3BidZeIuwbJu15SjaPfakPfmbxikGXsg8wxyw7LEiHE?=
 =?us-ascii?Q?8cHuud8HjueefT2AfoJ75lL/W77Tzvos+q2M+97mIi+pUdR7bKM1JM1GxNUO?=
 =?us-ascii?Q?IVoD5pWaHX4vhEcn/syVEDif16Z+3iuQPyozLYF9nLDbWpQxLcMIAj9TFwgD?=
 =?us-ascii?Q?0lchqIU9agu0AP5mp2FdC0SBBELUshigv7nf2jY4Z9paPDp+NlLCsEDOuLTW?=
 =?us-ascii?Q?er7b/eBqBNaq8jmAk6AKj00MjZTeBOWv55YgM8EywiPLw2PCV3Z6+UQDnT9o?=
 =?us-ascii?Q?o171qsPoP+mBMl3xWRsi3EVuJN/NGBTiojKGd7PrIaJWi0LdViZsKk3gx0kK?=
 =?us-ascii?Q?lHG3eD1eKK7l6lqE8Mcn/vyGwrKf981MaXAFMePgUFyZXEZFYQZptQD7aeL5?=
 =?us-ascii?Q?9UaZzG7Gfos7jyhcWBPUMTo1omKgQm+Cx6zF/JzLJHDYMMlL4qLMTkDTEW8f?=
 =?us-ascii?Q?RX9mSa1+EE0+i0yLbAUAqHCqddEr+26enKyrBXPYVs6mkaZiF0mXGpHe19R8?=
 =?us-ascii?Q?soFbvBcvS639EanEI4PqWK7jzp13gmQLzRI9RIVsfwV8exG+CrWSOS0Dbnmv?=
 =?us-ascii?Q?9fhTsSWQz6zEQxgEhoLtcJ8cghUd/1zB0ms8qk/Tj3teT2myn/dVXpMpKM7v?=
 =?us-ascii?Q?iUfNCJCu9xwTnoLPmRWpvb9hktLD3jiHPmTDHzsMoca3aCIS3KBA5pHMSs79?=
 =?us-ascii?Q?pAXo6mt9QOlvzbM/BguBg1dNrs4zbV4Fm3NyZvTz3///kySkIgJgMK+C4Qve?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fQeqnZKIakxmmuXKNw4vVDxIMFtK7UtO/tbDPj1Pq5rvXfkaTPedUdGjwEjlgr6fM9MWCpjhcqFW6OtRw+6Xp/vfGFd03ynWRPyomhwtkm/MO5TkkmZDZnqFOLD90yrMIZwCn7lNoiYOzwE90m5CHJhRY2RLfTnXzEDam4AaistH8tk+V1RD3xgORME+bz83ugGEL/DL+tTSX6izU4FbImdQmrTLvSUtBp9e2ZK59aZLPfIMu8Uo4ylQZ4uAQmmUNRWgA6doEmc2bY1L+rpXs75wDs+b96g+vEqgBKhFhpb3yi2aGI6TQJoskGuLyUJHgngoLVF8+gYUQYKD/CrUW8agtRQjq61nBGd3Ysbdy37jTTlTpoRlK6Hv2ERO+96Gecf5lbMuylugKkTIqgHRYvVi3NUqZ/avfAcdi00tKup3CBwbkIPpGA9q5LRZDQPm6J6Bm93GGcr+t4QtnditMlndfXTCKmyzdE5D5+3hiXK3xj1iR8uFzCdhUOV3vZvuccdwNm0u8JsnJMK1idCiYZ8qAUA3HE/lzt/g5Zo4YU+faiyBYWWi2PiD4MPNVowqnAHCiWjnl7emFt6jJCxYC3bMs5ELbIfh5RTAFTJNdN0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e16453-3ec7-4667-8899-08dc5b2e7318
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 20:23:43.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QF6W9tgGZNFXruyn5LhWeDVzUA93xPrTiI2uciFR5fPSwW8QulVVf66B94Ck6xOLV8rRm8LrqdthujnwKz/Zqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_16,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120148
X-Proofpoint-ORIG-GUID: ibq-hUkF_2ZN5r_Ry9JJaqojSb6O6WO2
X-Proofpoint-GUID: ibq-hUkF_2ZN5r_Ry9JJaqojSb6O6WO2

On Sat, Apr 13, 2024 at 01:41:52AM +0530, Harshit Mogalapalli wrote:
> Hi Greg, Chuck,
> 
> On 12/04/24 21:27, Chuck Lever III wrote:
> > 
> > 
> > > I have noticed a regression in lts test case with nfsv4 and this was overlooked in the previous cycle(5.15.154). So the regression is from 153-->154 update. And I think that is due to nfs backports we had in 5.15.154.
> > > 
> > > # ./runltp -d /tmpdir -s fcntl17
> > > 
> > > <<<test_start>>>
> > > tag=fcntl17 stime=1712915065
> ...
> > > fcntl17     1  TFAIL  :  fcntl17.c:429: Alarm expired, deadlock not detected
> > > fcntl17     0  TWARN  :  fcntl17.c:430: You may need to kill child processes by hand
> > > fcntl17     2  TPASS  :  Block 1 PASSED
> > > fcntl17     0  TINFO  :  Exit block 1
> > > fcntl17     0  TWARN  :  tst_tmpdir.c:342: tst_rmdir: rmobj(/tmpdir/ltp-jRFBtBQhhx/LTP_fcn9Xy4hM) failed: unlink(/tmpdir/ltp-jRFBtBQhhx/LTP_fcn9Xy4hM) failed; errno=2: ENOENT
> > > 
> > > 
> > > Steps used after installing latest ltp:
> > > 
> > > $ mkdir /tmpdir
> > > $ yum install nfs-utils  -y
> > > $ echo "/media *(rw,no_root_squash,sync)" >/etc/exports
> > > $ systemctl start nfs-server.service
> > > $ mount -o rw,nfsvers=3 127.0.0.1:/media /tmpdir
> > > $ cd /opt/ltp
> > > $ ./runltp -d /tmpdir -s fcntl17
> > > 
> > > 
> > > 
> > > This does not happen in 5.15.153 tag.
> > > 
> > > Adding nfs people to the CC list
> > 
> > The reproducer uses NFSv3, but the bug report says NFSv4
> > at the top.
> > 
> > I was able to reproduce this on my nfsd-5.15.y branch
> > with NFSv3.
> > 
> > A bisect would be most helpful.
> > 
> 
> I was able to bisect: here are the results:
> 
> 
> 
> 2267b2e84593bd3d61a1188e68fba06307fa9dab is the first bad commit
> commit 2267b2e84593bd3d61a1188e68fba06307fa9dab
> Author: Alexander Aring <aahringo@redhat.com>
> Date:   Tue Sep 12 17:53:18 2023 -0400
> 
>     lockd: introduce safe async lock op
> 
>     [ Upstream commit 2dd10de8e6bcbacf85ad758b904543c294820c63 ]
> 
>     This patch reverts mostly commit 40595cdc93ed ("nfs: block notification
>     on fs with its own ->lock") and introduces an EXPORT_OP_ASYNC_LOCK
>     export flag to signal that the "own ->lock" implementation supports
>     async lock requests. The only main user is DLM that is used by GFS2 and
>     OCFS2 filesystem. Those implement their own lock() implementation and
>     return FILE_LOCK_DEFERRED as return value. Since commit 40595cdc93ed
>     ("nfs: block notification on fs with its own ->lock") the DLM
>     implementation were never updated. This patch should prepare for DLM
>     to set the EXPORT_OP_ASYNC_LOCK export flag and update the DLM
>     plock implementation regarding to it.
> 
>     Acked-by: Jeff Layton <jlayton@kernel.org>
>     Signed-off-by: Alexander Aring <aahringo@redhat.com>
>     Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> 
>  Documentation/filesystems/nfs/exporting.rst |  7 +++++++
>  fs/lockd/svclock.c                          |  4 +---
>  fs/nfsd/nfs4state.c                         | 10 +++++++---
>  include/linux/exportfs.h                    | 14 ++++++++++++++
>  4 files changed, 29 insertions(+), 6 deletions(-)
> 
> Bisect log:
> ==========
> 
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [cdfd0a7f01396303e9d4fb3513a1127636f12e5e] Linux 5.15.154
> git bisect bad cdfd0a7f01396303e9d4fb3513a1127636f12e5e
> # status: waiting for good commit(s), bad commit known
> # good: [9465fef4ae351749f7068da8c78af4ca27e61928] Linux 5.15.153
> git bisect good 9465fef4ae351749f7068da8c78af4ca27e61928
> # good: [4420d19ed4e4fe2adc9bed8a49bf195db1137458] NFSD: Report average age
> of filecache items
> git bisect good 4420d19ed4e4fe2adc9bed8a49bf195db1137458
> # good: [94e412c945e64579798204aee7bc669d0acfaf79] nfsd: fix courtesy client
> with deny mode handling in nfs4_upgrade_open
> git bisect good 94e412c945e64579798204aee7bc669d0acfaf79
> # bad: [254f1c2521716cafc63530750ce313059f5d5979] iwlwifi: mvm: rfi: use
> kmemdup() to replace kzalloc + memcpy
> git bisect bad 254f1c2521716cafc63530750ce313059f5d5979
> # bad: [e635f652696ef6f1230621cfd89c350cb5ec6169] serial: sc16is7xx: convert
> from _raw_ to _noinc_ regmap functions for FIFO
> git bisect bad e635f652696ef6f1230621cfd89c350cb5ec6169
> # good: [05b452e8748bcf92c00725691437e16d46af7c28] nfsd: Fix creation time
> serialization order
> git bisect good 05b452e8748bcf92c00725691437e16d46af7c28
> # bad: [ccd9fe71b9ee46ebcecec8aec5c4f1e1ddd35dfd] nfsd: Fix a regression in
> nfsd_setattr()
> git bisect bad ccd9fe71b9ee46ebcecec8aec5c4f1e1ddd35dfd
> # bad: [2267b2e84593bd3d61a1188e68fba06307fa9dab] lockd: introduce safe
> async lock op
> git bisect bad 2267b2e84593bd3d61a1188e68fba06307fa9dab
> # good: [56e5eeff6cfa4bd6ffa2b2ae5b8bfc1c28044faf] nfsd: separate
> nfsd_last_thread() from nfsd_put()
> git bisect good 56e5eeff6cfa4bd6ffa2b2ae5b8bfc1c28044faf
> # good: [6e5fed48d8b7b25f8517a1292b62a3a86a5aec91] NFSD: fix possible oops
> when nfsd/pool_stats is closed.
> git bisect good 6e5fed48d8b7b25f8517a1292b62a3a86a5aec91
> # first bad commit: [2267b2e84593bd3d61a1188e68fba06307fa9dab] lockd:
> introduce safe async lock op
> 
> 
> Hope the above might help.

Nice work. Thanks!


> I didnot test the revert of culprit commit on top of 5.15.154 yet.

Please try reverting that one -- it's very close to the top so one
or two others might need to be pulled off as well.

I expect this is due to a missing pre-requisite commit.


-- 
Chuck Lever

