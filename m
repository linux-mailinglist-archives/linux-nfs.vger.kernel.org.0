Return-Path: <linux-nfs+bounces-10165-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3072DA39FE5
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 15:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362C41882E1E
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 14:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6C26A0ED;
	Tue, 18 Feb 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mSdN9NZs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lydgf+jD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DDF269CF4;
	Tue, 18 Feb 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889126; cv=fail; b=NS8lLkJ4Xog0O31t4ErlHfMLNWKnUBDPYT0r75vEKo5JoEiybt2flCUDQQtPJyvBDrHcNREcY+0RmAswt7sI1ROfAv68Sm+pdJnL7X+WLVZZS7NQHh/BtJwv0BD6ytu+CIxHqTrfTYw8lezO2W2iKOa35FWHm3wIvqAQXhUIvD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889126; c=relaxed/simple;
	bh=l3mvYqzvHXDVGyqkNzsUBuW0ujK3NpNog2ZNJFIzFmM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C/ZtJaQ+x5OW9Yf2YzTJdg+kOxUr9OGzS6/xAk37ngGrlijRjkiXYDUbam2Yk7kXUsGU8HY4M0j6ZXJMrG8OcArzamq/WMtN817jNWKo4jtXTP5Lik2I1HxNdWOOlxkStDS77u7ytg0iZThzzHd2QhxBjBgO3yYqL+QqN3hsm3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mSdN9NZs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lydgf+jD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IEHput008532;
	Tue, 18 Feb 2025 14:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7uBwSQ8MQR2cObPIL8eCZN95qtVFBIpR+ld4x08AYUU=; b=
	mSdN9NZsug61faMJleoq61L2mvMJQtzAhksLZG2r+btJiGKYSHn7btlJx1HmuLUq
	5SA7VqbgZJB2dTVxeL7l2s6M5TWKrmMvf8V4uFJ39wmu5s0AHofTpqJnP7TJc3r4
	tsdt9sKLe85GY748tB4ve0XMsLwdpCxyEppfm1iyemRpHwHRal3Tas3ataGe0WWZ
	VU3CPue88/YmXoND8rVZPY2dKhOopPTS+ylzvovmCZcNKz6JjWjJnzWpAxGUrVBX
	MrMVfMnSxhJo0xT7HDMPedKCwcOdE//lBEqJsVJRN2BWB7Iqy3k5wgSYGTLX+Qx2
	2kYaIkcFHp2+OBsp0HlLIw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tkft6m5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 14:31:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51ID184m034446;
	Tue, 18 Feb 2025 14:31:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc93n98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 14:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=purSdYIG9cfDzsP5ySzqWV4TCmV2ALwVs7SRKbM3eEgHSNBH0h/5giekcjtlgy8ysnDO7uhGdx/GzrEqWoBO3087yRsREsuKRPQHlNamYeoLcplCOclWzKAeBZJe4U79LOsixBvC+7BKiaeTGwBH/7oAlD8iCfau3ecPeYNaZNShs+j2BAQBG0mbM/DRLQfbJU1T2+6E46UwJo4haNwug3EzRA2ihYtds99U4UUvqWsSALUt20x2WnriMtmIPI1IKZ4ju7HYq+CAxWuKjgQOtPNFeQfn1GrWp0hKv+G41IDHLfiFNljaYcGGJ17xrXGEYoRuRlyo9MDy1qqs+lgq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uBwSQ8MQR2cObPIL8eCZN95qtVFBIpR+ld4x08AYUU=;
 b=v7O3BFKjkYeL5bYLJK9BF90nXnFndcDMo4lGgLof7elIjxrN1WqRZoqmyJ0nVE5V8guDO25uEhD6UytseiMCRlfOfSKmHLoK3aMYe9e3OOGerb/7WDk26nVAJXf9b3HOm7U/QxGKMcfOJk0PwriYid2agHq2oj1p69CzdcpC8op8XfZDY7yB/2WUofcoqJWl4007sVArYVISLr3HdkcPO3GuHvGn1LZxhsA2zQ0ze9jjU9UlFRGtujVcD8ya2C7nvuIAll7HZArRCx43ZP6KvkmPEZZIK+L3gefThdT+N2edcUULDJzqjNZKcL2pic1h6Xo8v4jsfeqgzJohqV0Gcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uBwSQ8MQR2cObPIL8eCZN95qtVFBIpR+ld4x08AYUU=;
 b=lydgf+jDe95jkmyeRdz40LWgdQLvqYK8eoYoDV5UKXhwEAZIJ0BhZhF/64pydLacQth+h/K5vDm9q2esRH8jx8/Tyn2B+YzqfU5HMaTVWqhzyslNeZH2bNUhmEOT23nhLlkdvHFuFjjjLB9cCle7f49QfM1udvq3pv44QW9zCCY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 14:31:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 14:31:31 +0000
Message-ID: <9cea3133-d17c-48c5-8eb9-265fbfc5708b@oracle.com>
Date: Tue, 18 Feb 2025 09:31:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: decrease cl_cb_inflight if fail to queue cb_work
To: Jeff Layton <jlayton@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>,
        neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com
References: <20250218135423.1487309-1-lilingfeng3@huawei.com>
 <0ae8a05272c2eb8a503102788341e1d9c49109dd.camel@kernel.org>
 <04ed0c70b85a1e8b66c25b9ad4d0aa4c2fb91198.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <04ed0c70b85a1e8b66c25b9ad4d0aa4c2fb91198.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:610:e7::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9eee38-2bb6-461a-0899-08dd5028efe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzIxTE5nZWFqK0lSalFDaktVZXMzTklRV2xGR2NwWkRtUHZaSVJ6NFNIeWpD?=
 =?utf-8?B?S3RRL3J6dE9qQlNpUndPYmdNVHJGWjlHSWpoYVIrK3cra1grSkozYWtpc29z?=
 =?utf-8?B?ekNuQkNnL3lxcnlFR2dkMXVNZG10YnIrZVg2dHdZZVluUWNVQUIyOEZFdzlz?=
 =?utf-8?B?MEl4NFdwRy9vNDQxWDlFS1dKMXc3dHJ6SEpqditHSkxhY0s1ZVJCMW5qSHZz?=
 =?utf-8?B?em51QXdHN29wUVBhRmRJTzRkQmpyOWF5S05VRVBFNEVhb3lrV2VEdzRRRTlz?=
 =?utf-8?B?OTRoQVdsSnc2aU4xQXZ6bTN1Q2tMa3FNMTlzeWhUcXRMV3FYZ29rVTFQRVNQ?=
 =?utf-8?B?UU42YU81cUpZN3BXdEVjTGRWb1dNSzhDNmhIWG8wL0tDS1VDcmJVVWw4ZVV0?=
 =?utf-8?B?ckM5NXNRbUlha1l6YWcrc215NG0xZDR6RWExTlduTWhaTzRjRWRLRE9aTEZK?=
 =?utf-8?B?d2JRVFM5aGR1YlpzdUs3N3pLakh1eGJtajhKN3gzRVRNek1BUkZKOFVrUitw?=
 =?utf-8?B?RWtUTk1GTjd6Z0xjOFN3aHNqREU3Wm5sSDhkR2pZQnR5L2pnbWNyVU5KTTdV?=
 =?utf-8?B?VnV4eEhDZktGMzgvWEVrbGVoNmFhZ2N1MXl6WVlaaEowamZYQXJuQlg0UU1x?=
 =?utf-8?B?WGxkTjJmSlJhZUFmQ0o0eVpsOUYwUXpmWVlRY1drTWl6dlJkOFE5d3Fhd2tF?=
 =?utf-8?B?MzFFSmxNRFJGYnJVZVZxVXNBMVhleHVMMnRvODVyd3FjMTA3NnlmTExJWXh1?=
 =?utf-8?B?U0VNM3dUbThpcWVCcnJ3V1gxQnAzd2kvdTh3UmFOckRWWlp5SGMrLzhIUGJY?=
 =?utf-8?B?dXYzMDNzTzljUXJscGM3WDlOL3BZdjVCNXR2NTFzSGxJcEpxVGJ4Tkt6UDlO?=
 =?utf-8?B?MkNiYWtDNVR4NnFCZzJNODJadzdHaEp4NWtUUzB2TDhBekhtMzJNUE5QUUVB?=
 =?utf-8?B?SVJ5ZzZTcEM3bVptb2NMVjBxOTlQaTJPWm1DNUhRMVUvMDV4VWk2Wjk3UElR?=
 =?utf-8?B?NDJEbXZQOVBZeENyMnhTTnVqL3AzMVRlRGFXZ0tBT0tlaHA1Wm02Y2VlbDV4?=
 =?utf-8?B?RDVDSms4UzlLbHlGRjJMck91R0Ztckh6TkJNa0ZDSlBuYkRZNnlrT0x1YXZE?=
 =?utf-8?B?cnpDWE1zK0hCMk5qcm8yaTdUSHIyN3VTTmhEV2JWalJNL21ua0dBWVNvSVdJ?=
 =?utf-8?B?Z3JoTnlpNHV2QzdUZDBaL1NaSTdidlRNVGNyNWJJMUUyaU5DNVc0U1Q4WEsz?=
 =?utf-8?B?eTI3VU5jbHJRV1N4R3lqMzYxcHdzdjhBMFZWNE55cVhxeTNDaEhuT011MnFp?=
 =?utf-8?B?aUZtSldPTE9uaC9lcjZKd2V1QjFnem9zZzAwUE9KRmRBanBFcDR0QjhPZWx1?=
 =?utf-8?B?VWFzRHY3Y3dvWS9sZjlocUJJWUZ4MXZMeGYweUFSdFZ3cXJDVEhuZzUzMG01?=
 =?utf-8?B?OU1MUG5IVzBmY092NXJHeFVkaHRMTlZacFhHY3MwanpWNEM4RThBNDJnOC9G?=
 =?utf-8?B?cVBvVVBKV0xKem1MekJEeTZWMTU0R3JOYVpTUCtOc3d5OWNGYnZ5T2dBcHBK?=
 =?utf-8?B?WVdnVm44R1pyM2ZGN2VmYXZybFdPdE9UdU5iUG9zTTBEQURHYm5sbG8yc1VN?=
 =?utf-8?B?bHZmcnp0a0VoaDdaRFU3LzUxbUh6VWVVcTdPc2ovcG9LUys4dkx1ZFp0MnNr?=
 =?utf-8?B?USswT2JRZVc2L2xxTXluZG9QLzJpR0pZYldCTFN4KzhpQjhoMGxCajBTRTJH?=
 =?utf-8?B?QjRnTEhQemZvQzJOZGxjVHhUeFlaUDJSNG1URnp2MXUyam5PQ2p2aGVWRXZt?=
 =?utf-8?B?TFlCQUV1WUxvZy9lOXlXaEl0M3ZTRjd4OEhmTi9GdWt2YjBrZi9zZi9STzdU?=
 =?utf-8?Q?Wt05THAgVe13p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE5iTEEyZEtDU1phakh6RXJ0SWozNmsyM1c3L1dKclR6MTVSNFdadmpJeEVV?=
 =?utf-8?B?TWgrMUVDRGI4R3VreUJaY3pmVnZ2Q2pKZzNnelFWeHg5RUtFaUFWY1FJQW5M?=
 =?utf-8?B?a3lpVHVqeFdzQkltbzlqV2ZJQ2t6TURJMzVJbzlLYmVhbVZNL1F5cW5ORGpK?=
 =?utf-8?B?QXh1WWVscmFuK2o4aXkzRE12TE04dC9zdzI3V00yOG5aZzIrUS91NGhnQ2VE?=
 =?utf-8?B?bU5tdlZSQUcwZlQyTExNOHJkbGRYR0x4WDMvWTJ6TEJhaFdsd2NFMS9sZU9y?=
 =?utf-8?B?bFJ0SjkzcnFIUDhxc2ZWOTFXNnNrbVZLemowMDdPZ0dyazdwM3FwSnJJVkpN?=
 =?utf-8?B?QW0zbHdqWUxIZEhmRWpRbjVOMEhkOG1MSzQ2NzZsb2cvWjB1SEJkbHdsRVlL?=
 =?utf-8?B?cjRMd0UwMXVkUDU5cTMvWXBCRzNaRENIbExWWWlJTWx6b00xb2kya0N2ZVJT?=
 =?utf-8?B?K2k2RDFFQnMvbW9Fc0lIcjEySU9jejFvRGwrTXY2QzBxMHN0emJWYzJoS2Vr?=
 =?utf-8?B?Wkw3b2VRSE1oOG96NG5PTGJuZUYvMTd5Q211TVhGNDM1MnhFdVJEWFByUXpX?=
 =?utf-8?B?czZFMC9GZS90czNtRktlQjRJRUt4Y3R4Ky83eWlVL250ZlMvUnlkcjZJVlRM?=
 =?utf-8?B?eDl0aDVCRHhSUWZKN2k0c1JUQWw2bitNY2J5eW5PbFVac2w0dW1SL054ZXdm?=
 =?utf-8?B?TXNrT0h5NGhPNjVmM00wUEJTTVgzUDdTQmJlWjNqc3dtdWswTWErTEY4TnM5?=
 =?utf-8?B?QzRQNkRHdU1CTWlWZ0h0NGRWZHplQnRSR0VMSmlQM1RHcWtwcnFCNXRqdXYv?=
 =?utf-8?B?UmpFa1FSTTdydWFGMlN3Q0h4SmRmK0doS2JBVmg4cUhTZUJHUnhqUzZhTEhx?=
 =?utf-8?B?Mnc4aUUyKzYxSmQ2clp6MWpUUWVud3RqdlFTUlAvenZlR3dqWERtQVMxekMw?=
 =?utf-8?B?TGpzTFFONWZPMnBkL09NalNEZnZ5T1QxL1VSRXg3cmVhM2dxK3RaTC9UNS9v?=
 =?utf-8?B?NFU3WGJaMDN4SVR1Z1c4ampybTRmT0lNbERpVjYrMjJveEp2YkFIaVROV2RP?=
 =?utf-8?B?OU9jODZDWUMwck5JbnlMbmp3S1R4VjZkVkhBMThYTW9ra3RvY3hlS3lqNm5O?=
 =?utf-8?B?Unl2Ui9NMWV4OU9jSzQ1ZUVHRExhV1FvZXV6clJ5amRqTHpiRlltcFZzYWVm?=
 =?utf-8?B?NURGUGxvSDhuc1pJUEYxQjU4Zk9ERTFuMUt2VS8vSjdMVk9HNE9QdnZUMXdo?=
 =?utf-8?B?eS9EWFF1b1huMFBFL2FjcTZldXgyY2N4S1N4bDY5MGVBMHI1MkxFK2R1c2xS?=
 =?utf-8?B?K0RWUmtXanF0Zm1VbXozYnRKNXZBZWZrUTBSSmRsTU5pbWxlQzVna3E3T21Q?=
 =?utf-8?B?Q2V1bTZDSWdoQnVUY2hLVTgxUlFXTFhqRU5YcXRZOFdFeFNLNW5wQVRGUEVi?=
 =?utf-8?B?eUlzcElUWmJoS0pmUnBMZU1kRUlwSmx5cWZFeEcvWFlVU01tRmliVEpEU01F?=
 =?utf-8?B?dHJyUGtrSExQanJJR0EvWWx4OURUR0tTV2FVRHRqcUdNeXFDR3FtU3kzZzM1?=
 =?utf-8?B?eTRPYzJzSjI4SmFSUHpRcXY0dGtQeEdMdFkrZDZrUkovNzdGTDRCS2ZnVThD?=
 =?utf-8?B?ZmVIUTVWME1jWXdPNnJrR25FQlFXRnJORFpmTjVsZmpEektLYXljUTAyeERs?=
 =?utf-8?B?b2NrRWFNNjd4N0VBeUpTTGZMcWhWbE9NVkhyWVRvaytpYnhnQ0V1dDdMMlRX?=
 =?utf-8?B?TGhvamZyWCtIOHQxWmlnMmpySXJ1REZoa3BYZUd3MjZBdTVVb0lLakc0ZzZW?=
 =?utf-8?B?SVpHUmRuY0hqL3NGWkpSeFRGYUoweU9qT0ZHUjN6ZXJnMW9uUXJiVi8ybWdD?=
 =?utf-8?B?TWZ5OFFsRHRMaDVKWXNHYnBzSzYzNDJPTlBMOWJ4WnlKa3FGN1JQNmw2K0s4?=
 =?utf-8?B?T2diajZlc1BJTStnM3ppeFVxM2pidEVsdEFjeWlURnV3RUJzQ2RVMmJhVC96?=
 =?utf-8?B?WnJpcndacmJkUEg1c3ZzV2hwL2Rxd1MxcmtFNkxEWUFsSlhHdTFVdEw2Rkg4?=
 =?utf-8?B?Q0JXWTVuK0hzMkFUazEzbm9VOVpYLytyZjg5NmcxSjBvZmZoWmFZOGE0V3Rv?=
 =?utf-8?Q?JazSMwAIEwnfMjusSaSY+G/LU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U1airr6d0NAYQzM3f3W6LEyLWyinmVli/4MOnrOa5tTWFxJJ5W8PWakc4hEMuxi4ySg6oqQ4v6s1GzngxbP/bSQ857Yn7Qm03OTOyLWJvg3WeKpiSp3OJEpRQXxt0gyiR0S7nBSM2r3iccDtW00vTXIiKjSwW2AIqkNnUZfzOpJBXqL47sSne+f+D44mwLhgIRFFvXDOrxOBmlv0e0YDx0qRfORjbW9c8ZcU8fjCmSLb2AVubvKrcnlO9ITRVQA1mYwjLxtkGeubLNlmcrcp1QBQnlprda477MapAsKlJKZGE9S4+TE/4h1Ps29sMw7Ll+ViFU+4fM4CYyYmXfpZHYGkZFOctPxPYlB2dNKXSmTzVyg1O4ekrvLPqc4b8XiPnAhgjAqoMnDJeD1EA59ng0oEmjUI5AOfAXtBI+o6y4MX7qcUWpwcqBZRsHloFqE+pC/+sJ5fO+JQyYUA3KWt6bqdmiBP8OsTSO/2hgpjnPDf32WUhAfYZWlBsBXiCM1Gb8cZoCXykOCEcUYBuNM4+low4TOutvePTJketI9vux1SOKX3U9TJFCCHP1POrOUA73PG4SHd1tsEgNl7MKb+171zIqq1aYbqxkfneqIZQ34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9eee38-2bb6-461a-0899-08dd5028efe1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 14:31:31.1688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPzL7AF385LP8Br+cQ7Thb6wMVl/pVd58+Bsj1SWprWBOmkjpSyy4/cHOt5fuGz+tCDomTUdDyvDbPZUWhJoSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502180109
X-Proofpoint-ORIG-GUID: fm-cFbQI_5Q4mQql6T4XaPEb8NInyjkg
X-Proofpoint-GUID: fm-cFbQI_5Q4mQql6T4XaPEb8NInyjkg

On 2/18/25 9:29 AM, Jeff Layton wrote:
> On Tue, 2025-02-18 at 08:58 -0500, Jeff Layton wrote:
>> On Tue, 2025-02-18 at 21:54 +0800, Li Lingfeng wrote:
>>> In nfsd4_run_cb, cl_cb_inflight is increased before attempting to queue
>>> cb_work to callback_wq. This count can be decreased in three situations:
>>> 1) If queuing fails in nfsd4_run_cb, the count will be decremented
>>> accordingly.
>>> 2) After cb_work is running, the count is decreased in the exception
>>> branch of nfsd4_run_cb_work via nfsd41_destroy_cb.
>>> 3) The count is decreased in the release callback of rpc_task — either
>>> directly calling nfsd41_cb_inflight_end in nfsd4_cb_probe_release, or
>>> calling nfsd41_destroy_cb in 	.
>>>
>>> However, in nfsd4_cb_release, if the current cb_work needs to restart, the
>>> count will not be decreased, with the expectation that it will be reduced
>>> once cb_work is running.
>>> If queuing fails here, then the count will leak, ultimately causing the
>>> nfsd service to be unable to exit as shown below:
>>> [root@nfs_test2 ~]# cat /proc/2271/stack
>>> [<0>] nfsd4_shutdown_callback+0x22b/0x290
>>> [<0>] __destroy_client+0x3cd/0x5c0
>>> [<0>] nfs4_state_destroy_net+0xd2/0x330
>>> [<0>] nfs4_state_shutdown_net+0x2ad/0x410
>>> [<0>] nfsd_shutdown_net+0xb7/0x250
>>> [<0>] nfsd_last_thread+0x15f/0x2a0
>>> [<0>] nfsd_svc+0x388/0x3f0
>>> [<0>] write_threads+0x17e/0x2b0
>>> [<0>] nfsctl_transaction_write+0x91/0xf0
>>> [<0>] vfs_write+0x1c4/0x750
>>> [<0>] ksys_write+0xcb/0x170
>>> [<0>] do_syscall_64+0x70/0x120
>>> [<0>] entry_SYSCALL_64_after_hwframe+0x78/0xe2
>>> [root@nfs_test2 ~]#
>>>
>>> Fix this by decreasing cl_cb_inflight if the restart fails.
>>>
>>> Fixes: cba5f62b1830 ("nfsd: fix callback restarts")
>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>> ---
>>>  fs/nfsd/nfs4callback.c | 10 +++++++---
>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>> index 484077200c5d..8a7d24efdd08 100644
>>> --- a/fs/nfsd/nfs4callback.c
>>> +++ b/fs/nfsd/nfs4callback.c
>>> @@ -1459,12 +1459,16 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
>>>  static void nfsd4_cb_release(void *calldata)
>>>  {
>>>  	struct nfsd4_callback *cb = calldata;
>>> +	struct nfs4_client *clp = cb->cb_clp;
>>> +	int queued;
>>>  
>>>  	trace_nfsd_cb_rpc_release(cb->cb_clp);
>>>  
>>> -	if (cb->cb_need_restart)
>>> -		nfsd4_queue_cb(cb);
>>> -	else
>>> +	if (cb->cb_need_restart) {
>>> +		queued = nfsd4_queue_cb(cb);
>>> +		if (!queued)
>>> +			nfsd41_cb_inflight_end(clp);
>>> +	} else
>>>  		nfsd41_destroy_cb(cb);
>>>  
>>>  }
>>
>> Good catch!
>>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>
> 
> Actually, I think this is not quite right. It's a bit more subtle than
> it first appears. The problem of course is that the callback workqueue
> jobs run in a different task than the RPC workqueue jobs, so they can
> race.
> 
> cl_cb_inflight gets bumped when the callback is first queued, and only
> gets released in nfsd41_destroy_cb(). If it fails to be queued, it's
> because something else has queued the workqueue job in the meantime.
> 
> There are two places that can occur: nfsd4_cb_release() and
> nfsd4_run_cb(). Since this is occurring in nfsd4_cb_release(), the only
> other option is that something raced in and queued it via
> nfsd4_run_cb().

What would be the "something" that raced in?


> That will have incremented cl_cb_inflight() an extra
> time and so your patch will make sense for that.
> 
> Unfortunately, the slot may leak in that case if nothing released it
> earlier. I think this probably needs to call nfsd41_destroy_cb() if the
> job can't be queued. That might, however, race with the callback
> workqueue job running.
> 
> I think we might need to consider adding some sort of "this callback is
> running" atomic flag: do a test_and_set on the flag in nfsd4_run_cb()
> and only queue the workqueue job if that comes back false. Then, we can
> clear the bit in nfsd41_destroy_cb().
> 
> That should ensure that you never fail to queue the workqueue job from
> nfsd4_cb_release().
> 
> Thoughts?


-- 
Chuck Lever

