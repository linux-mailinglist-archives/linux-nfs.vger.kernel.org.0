Return-Path: <linux-nfs+bounces-6307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0E596FCEF
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 22:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF1D282A36
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 20:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0F161FF2;
	Fri,  6 Sep 2024 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="otbiy4KI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aq1LC20u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C73D0A9
	for <linux-nfs@vger.kernel.org>; Fri,  6 Sep 2024 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725655960; cv=fail; b=HqGLmdrUccFDAkeMdyEwkf7A4mDRdxxdrMiyo67ka42D+5AC3ZMV3aMqS9C4icmWyfLa0GrEBpsM+CFaZPynN9U0i5pC+Ii59SeKfR6YQcjLqX8nCP8mJEwiuTxgRVX4o4opAiDyWA7oPsnWB9gGXE+XMHZg4ZjCNO7OXVwrQzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725655960; c=relaxed/simple;
	bh=sVe8qXgG0hMrMHrxh86t58a1ZYifrJMfj7ydjltGhcM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rwQ2LiGKdaUgP4WPhGCZ7bex3K8cmvUR77uiev+5J9yYqBGlpMvTqu3e7YyVs0UYsMmegugFb8oj96ktUE0FLFK7o7dFtoqqtlqO+vFgEx5y9TK5dexJs941Z0ckht5quxfyRtdC283AhpPCKdetqG7wTZuWI50bkADJvoJk4xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=otbiy4KI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aq1LC20u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486KXW22027379;
	Fri, 6 Sep 2024 20:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=KJe4hCPs53Jj+4C/FdfZFr/xVuFzvrHDgr9knh4FS/M=; b=
	otbiy4KIajvSlSe7i/msftefX6soLyMFQqPvHuRDR+XC4JueyK09ymEPe6f25LvP
	w5Kv2p7B9v4NP/U/6K1NowNhoTbXkyIsIzZUs/eokVH/O+fM0FF9gUOdmDHKXxco
	IfGHMJt416xVpeu+0V5Pk/zXJpEy71gHvWopynnKxyqmd3AOgSkgT7Zu4+49OEn1
	e1/JORTaHsnzzResjKebHIBBId7frdO2zF+QMSYJet8i0hNzFShWQc1PpeNEBsDh
	nrM9QTnKs/44wUH8vkf85GX0OqJa3PmiW0aj4sHj/sHccHXzv7a0cEe8LJ6w4xwF
	Qi3nyDgKClERbPGu+m5cIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwqjgeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 20:52:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 486KCnV1006926;
	Fri, 6 Sep 2024 20:52:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41fhyde100-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 20:52:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZarZsrIPOcxzYxx3/4PTztpMEjUQ63/tbAI/K/4lcV6lXvEV42BNhEedv7eqP7iM40zgKUxoFW9PfArMiRj+nWjQXEBLNKUgpm3uzr/0JydVmoUz6cR8StFuaKf1vLMARg+nKlfzjh4/+4O/L75k3w/XDFLzCx2wi3vuTWA09cPtfgeQIgN5i2LgwfuZRFlD95IMkvjaC5t5zmjH0UuMSIxoEcK4DQtneGahHqqVy7qCau1Z5CpvnZ8L7z6BZJlLVxIpbk/GV/20MhwuL2N/ShFXA6d306/CMOcckMc4pSMZHIQpABfPAfkU9PTqK1HKXI85EuDOgyWuC0mzKy+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJe4hCPs53Jj+4C/FdfZFr/xVuFzvrHDgr9knh4FS/M=;
 b=BTNHehYW7JszPLgX0WbTGGlfRgfB17LgRR9xSQUzgl7Efu/3pQEeAFLHQhmfwN7GTPiOnPC3SmFngkqSl9ges79oi18GN77RZQPBZDWjEJBmEOUJiv3pV69bRqBUKdDZI6Ga0s8+Qn+Pry0tmmj/LWzrxwjbF0WwBtzIDBzhAhSV8xcqYGp8FEQKnSAFrGO7+B3HGSnx8QMPJr9BJNnlO1BifvlWtDYdagpl6oRdPKogmzSy1kK/XH6+Hq472ToWYS0MwjZLBPrBXGhj3f5lPv0fqxMEgnho6YhS4y2xbu41di889qUFEv4vFBeG8Tl9rUg3h1kgyDHOt0nbbhba7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJe4hCPs53Jj+4C/FdfZFr/xVuFzvrHDgr9knh4FS/M=;
 b=aq1LC20uMjpQNPMXOX5aPvU4WW+OSiWpTG3j4N3mElEWRBMO6rN38+ksnslAHqDwx9LKjT0om+Zq8wfwaYEVvkPM32o5M7weB/hs+0OoKfwd//BL4M4saOJbD1UjK3jjcKFz7BgCx4R7mCzbN+5w94NOshwgrf/Cg7ZQBUoLwtc=
Received: from SN6PR10MB2958.namprd10.prod.outlook.com (2603:10b6:805:db::31)
 by BY5PR10MB4132.namprd10.prod.outlook.com (2603:10b6:a03:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Fri, 6 Sep
 2024 20:52:33 +0000
Received: from SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932]) by SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932%4]) with mapi id 15.20.7918.020; Fri, 6 Sep 2024
 20:52:33 +0000
Message-ID: <fca5699d-0c25-4b1a-8280-e559641f7cf4@oracle.com>
Date: Fri, 6 Sep 2024 16:52:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Yet another newbie question w.r.t. kernel patching
To: Rick Macklem <rick.macklem@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAM5tNy7VdgPaiKGtVg8de7HXcv3Nu8fibhhae9vp=pWgrX-EVA@mail.gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAM5tNy7VdgPaiKGtVg8de7HXcv3Nu8fibhhae9vp=pWgrX-EVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:610:b3::10) To SN6PR10MB2958.namprd10.prod.outlook.com
 (2603:10b6:805:db::31)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2958:EE_|BY5PR10MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b234fe-1e26-436f-e0ba-08dcceb5d4ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ci9nOG1saG9iK3RNNWN2Y3V6em1lUndHZXBJWkFpZ09oTTBydWYycDJwZi9w?=
 =?utf-8?B?Nis4aExZRThDbTg1NGJVV2JXM2dZQjU2N3puU250ZlIyeWl0bW8vbC96YmFp?=
 =?utf-8?B?aWZlaUJFZDZPM2d0NVFqakdrc3hqWEVnNDFCcitNUUR3RWFEUTJ6NkNkSjkz?=
 =?utf-8?B?c2EvRG1DR3dYWDh1K2w5NVpaK0Exd01QQ1dkTzY2TFVBeFVoVmdHZ2t3Y2Q0?=
 =?utf-8?B?cXJ5dzVDMU5zK2dKTUpHMThNWTBoRTA4bGRkZFdPZHRVcS9uU2JoRjNIeFZx?=
 =?utf-8?B?Z3p3OGFnZ09xaFZ3eVVFMXNiUzNrbkwwOTZxMG9ZYlFoRktxQXpYNXRXR2VB?=
 =?utf-8?B?a3VBUnQrK1RaM0M3Y3VEbzJIZDRIZGJHU2ttZGhDcVk2ejQ1NFlDR3ZRT1kr?=
 =?utf-8?B?TElXRUUzb1VmVTQ5QmFGUjdUZDdlL3hPL3RPakMxWG1nZzRsb1dwa3Z3SCth?=
 =?utf-8?B?dGc4THUrWVdhMWxscE5LeUdBQmxObFNyeFgvcWlDYjArbTAwVkFIM2h0SEdq?=
 =?utf-8?B?czhMN0RyRUt4SjEyTTlpZDRIZS9rUVV1cmJuQnN0VUxWYk5PQlU0UTNrODdi?=
 =?utf-8?B?Y24wd3dVVFJvRFY1R1ZzVjlFOFVJd1gxRUJrYWVmSzdDZ3FxRGpEMENiYkpM?=
 =?utf-8?B?UXJMcEtRMGoyRGpGQTdRZVhXbnVzLyswd2NFWVM5YWRRM0pqUmVZNVluZ2dh?=
 =?utf-8?B?eGpQbzZKZFFrZ3Y0MUMrZ0dQMGNBN3IvbktRWmtkTGY3QTJ0SXc1QjNZcXAx?=
 =?utf-8?B?SklFMVU3RHZWVVZKZkJDWXU1T0Z1eVJYeStHUmNUbWtyWGsweERZUlh0RHJH?=
 =?utf-8?B?UHI4ZlhldWh4RVVoalpRZ2tsUHQ2ZmdkN2lQOXRaZWkxaFRjeERYbksxWkZH?=
 =?utf-8?B?RjNwSW9OcmZYNWQ5a2tobGo3VlpUMlV6dVlYbmRnMXlNVHlyTEMrWFRndmdv?=
 =?utf-8?B?QVl6dzF0VXcybE9VbDZ4bDNkK3RHZ2ZXRTdyR0FFWStWSGFJR0JPeUZZd3NK?=
 =?utf-8?B?UmxtdiszaWtEaXBTS1lER250enBrakJmNTFLSkNEQlVpM3JxekduZmtZaW9n?=
 =?utf-8?B?aE16SDd4d0hFL2dKUWJxU1pselh4OHdqK2dLS05IZUlhZXJXTEVML1dkSGFl?=
 =?utf-8?B?c1FnN0oxNGc2NVlsTjhrZTN3dHBia0prMGpuWTZDbW5memE1YnFCYzgvYW1K?=
 =?utf-8?B?VnBzamh0UzFsd0NpTk1UY3crYmFCNXhHaFpkdDFxTjg1QSs4dFp0VndOYi9P?=
 =?utf-8?B?eUc2UFY3eS9KSWpIdzBmNXJvZVdFTENKbTRDYTZyRXVmSXBXb1h6cytuVnlZ?=
 =?utf-8?B?ZGxjM1dYT1dhTU5OeGJCK0tUUG04M3lvVDdBZ2Jya0NLdUh4b2hvZTlQdkk4?=
 =?utf-8?B?TDhIeW5VRUxlMTJ0ektXUkZ3ZG9VN2FLTm4yb3M0QTVnK0JUcFd3YzgrSFhW?=
 =?utf-8?B?OEpPQ3V4aTFMWmV3UUxLZTdTZXhNb1g5a3NlTW03akFPZHNHZEJqWmxOallo?=
 =?utf-8?B?SXZDbmt0cVIrckQwdklENHNOaXk4VTZRSmgvQURDalFRWlp5N3d3WlYxT3V2?=
 =?utf-8?B?c1FkMUlqZmh1emJaSFhrcjdsSzFBNHdFaTdic2ZRNktGUDh5eHk5M05Ia1dQ?=
 =?utf-8?B?aDlUbDVBT2tOdHltbFRpWnV2L1JWUitNMlJlOHR2Y2V2RnVtTWp1RHJEUjNH?=
 =?utf-8?B?aURxMUQ2bEc0T1VZa2M5NVBSc2VIamZtbmxOcUtZcFk1amhkeERyTVloQ09M?=
 =?utf-8?B?OEIxRlZtMktkZXBoZ0ZrdzRrc3Y2aHZrYzZybjVuRXBBQVZFZWE2ZVhvdi9D?=
 =?utf-8?B?YjlkVkpNaW1PN3VKLzQvZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2958.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHEvWkpyS3NPNzErcnBadWFDV3JiNzNEaSs5NWtraWkwSm1XOGNzUXdQMGFw?=
 =?utf-8?B?enBqMUUxZUpzbytuTlExVFB1RmU4elNnU1JCOG1tNlQ4dUtjdXl3K3ZvL0pU?=
 =?utf-8?B?dTZDa1BjZkZ1d2x1YXIwWmhiMlBJRFFOME4xV214bU1tMDZzOExoVTVhMlF1?=
 =?utf-8?B?S3dMU1BjWEQ3T2ladTRFVkE0K0MzVmgwVXpXMkQvZHFvdUxqSmIzaVBPdldn?=
 =?utf-8?B?eENZVkhsNVlxU0Y0bCsyRENuS0h2L2hSUzdQanFQdWJHZUZkc1crV0M2RmZv?=
 =?utf-8?B?cFdKMk1oNVdXMEdmbmovUU1tVmo3TlgzQTk4UG9OUHZvRFUxc0kyTWYzZ21H?=
 =?utf-8?B?YSs5L0pWZjN6TDY0clBIbTE5ZWUycnAzYXE5ODJoc01BYnhqNHB6bThNMDhr?=
 =?utf-8?B?UUhocE1xRmJTcWllNGMvc29VV1JVOVhhRm1tdFdPL25YSkZ4cHJ0cm9pbGNU?=
 =?utf-8?B?bEF4TVJkRXpsZnE0Ky9mNGFjNEdWRjhUaWlmL1ppU1o4blgyZDRDaEtzM1BQ?=
 =?utf-8?B?SXVuM1NyUGNpTFFqcVIrL3RKTTF5Nk5aRE1wMGQybFJHdjRJMXI1M0ZiMnNX?=
 =?utf-8?B?MUhPa3FEclRQSko5ME9nRGhqazk1QzZja2l4NFllc2xFdXQzbmEvaHg5M3pX?=
 =?utf-8?B?RHhaaDVOanR6U2RNa3hadElxT2pLOWV1L2VGZkNLdWpRM2ZYaFJoczQxMElU?=
 =?utf-8?B?TTNxM1hGTFpTVDhBcDZkaXZ6em9mYVgwbkJFYk0rMjMxOWlGSm1Kb3oveU04?=
 =?utf-8?B?Ukg1TDUwdEc3VEVCTEtKaWpZSG9DZUNnNWV6aVc3WnA4dElOZ3NBRnFtNWlR?=
 =?utf-8?B?aUZ4YmV1VmIyOXRTS1ZsMEllWUcyKzVNL1lnWmQ5OW9WZVlWV2lkUWYvN24y?=
 =?utf-8?B?WTVkbHFwb0lCNHdSeFRhZitjb2NINVdiYTJ3ei91dS8zM2llbnJxZ2VKd1Bi?=
 =?utf-8?B?RDJsSU52MDhiSGRMUXJ1RkZFWjBrVCtDN0NYNTNkbnp4citVQ0U0UDE2dFho?=
 =?utf-8?B?ejRFOXQ5MDlVdGRVMkxjMGFpRmY1M2pzUUVzRWR1MGZ4Yyt6WmZ5MWFtaFBR?=
 =?utf-8?B?U2w2TE0ra2h6Qm5HS2dEVTVzbU1DQVBjWlVaWnhUL1NvcTBCbzB0VEloODhI?=
 =?utf-8?B?MEp5ZVhYL1NjdXR6MmJ4N21KWlFTSHFyQ3A5bDhYVlREbjM1T05nQm9MRGpz?=
 =?utf-8?B?dWI3ditHZWRnR01SY2JiVU5hUVRMZUt0RnBKdUpoSW9ZMUMyUUUzTXNtK2ZO?=
 =?utf-8?B?aWFBZDg1UTZ3OVo0QndiSzlTeUlmRGVsbkd6Yzd6YjY1L2lnTjNqcmJ2aERp?=
 =?utf-8?B?TkdVUUNkZWtIRlROTk51ZDFRK2grTTBzeHFtN1Z0N3ZDMnkzdWp5TVNpWHpv?=
 =?utf-8?B?NjU2M3J3ek5FTExBZ2JLVml4TU9PaC9YTkw0azR4TmZVWXJ1OUxMSE9FTDBT?=
 =?utf-8?B?QXAwN25UR2N4V25nQTFtOU5RZFByNE0vdVI2Z0VYZmlaaUdLRTI0YVZhZkVS?=
 =?utf-8?B?UDRGZmI0a2hhdWhFeDA0NDkxVkVyVmNyR1dqNnVFQ1loSHU1R3JqZ3gyOEhD?=
 =?utf-8?B?N0FBZ1hSRHZiMTY4K0VsWldya0pJdFlZdHV6c0pQVzhCdDBqdVVpcVp6Tnln?=
 =?utf-8?B?UUJ3SnhYOUN5SDV6eTgyajZWQkxHUHAwcTZFaDJDbFVxMDQrc20wZnc3T2Rm?=
 =?utf-8?B?WHlJalNIYk5CQzIzS1k4VnRBVDdCRXZocWlEZGx0YWc4dWl4WG82ZS9Xb2JL?=
 =?utf-8?B?QTVMOW41RGFhSEU3bTRsNjVFczR4UGRjR3E1NWlhbVhEeTdSK3NRTVZpd3Vp?=
 =?utf-8?B?OGgxWU4wTk1qUnFJU2ZSQUNvdHNkMGpLVUdrS0poaFpEK0N0RWJUbTFmMWRz?=
 =?utf-8?B?QlUyeVlOSERlaHcyZzQwWXU2MWlyRi9iSmROSC95Yy9HdjFlTXZzcTB5OW1i?=
 =?utf-8?B?Wk1tcHVRb0VnNGdZbDFzS0MyclBLOWlYTGVLWW1RVithbmdFQmpHMFB1Wkw3?=
 =?utf-8?B?VGJyWWptSktWbS9CM3d1b0RGVmlkeUxzbXQzVS9JcDBJYXBxS1hNNlF0VFpZ?=
 =?utf-8?B?bTZQdjAxb0JPVjNsVUhOdHNPRmN0ZWFoU2FIRitqME9ONHh0WFdad0dIb1l0?=
 =?utf-8?B?TW9FTG5VYy9ZVm1aT2RPUVFHaktRQkVrd1l2YTFTYkRLYkNLVm1wUG9wSDBE?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Eq8uUYObuqpCNN7CxPI9WRgCeIEm2LDyT6wesJtEKOvnU995HSFWFTGqyGEZN439+0YCXSUPWQDPeq/9RlGTVh3ldFlYzb4rsisWxn8ZSNTNFlXagP9emVxEK6IvWz6y14Hgq0kag845hbm0w9igq68EmLbvrA+0f4Ow3p92gKcCS03qn3SmcEch5BKqBM5DUFw0y9REvvXMl07pMi9ySRwuqpXy4+9kU81xGSd6CGRK8+dWEgN8u1dogmf5x/Xz7UJiUXJSAa3fGORHfGQaZlUjqncvIZk1XX1hryFCO2fj1K6GpS9OxaZuE9IwNHqJ1CHifEiWiVesK3BjmaxOf6ceQdN3qar+ZssE7cPM/mWCnTXqh5jjx4csFZ8h2ke5U094chEjCODOHpuSMwnji7C/aAGTl7jcs01f2CCE7/17D7A/GGygCe3Id9jFmIc61HZ+8EFqagq0xyRDwdxrcaJaUSEMv97tBTTiML9yhG+urDD59ukjSCHbf8SOcwAamGK/0MoCmR0lfwxhlRh+4FLBzNlyLD18T1ozhvffoH4JIr7I56bEGSI35BVHiyZFCmP3tIRdjUpMYLQeeziPsZqDcgnO/bcsDwLHmOyFodw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b234fe-1e26-436f-e0ba-08dcceb5d4ac
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2958.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 20:52:33.3543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvE5O3ZbpwOA3alKQtsSNVMOzibJvz6AKem4gSZuS2GX1WYKDL4aESBqot/H/utxTEsxSjSBJuOtLkLyMNl/WNx9W+eUudi35dLzmHGarWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_05,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409060154
X-Proofpoint-ORIG-GUID: VTtTr02RY-MJQzjm6rlTBrDDeTLERz5q
X-Proofpoint-GUID: VTtTr02RY-MJQzjm6rlTBrDDeTLERz5q

Hi Rick,

On 9/6/24 3:55 PM, Rick Macklem wrote:
> Hi,
> 
> Another newbie question that hopefully someone won't mind answering....
> There are a few functions in fs/nfs/nfs3acl.c (nfs3_prepare_get_acl(),...)
> that my patch uses for NFSv4. I just copied them into nfs42proc.c to get
> things to build, but that obviously is just a hack.
> 
> So, the question is...what should I do with functions chared between the
> NFSv3 and NFSv4 clients?
> - Put them in some new file in fs/nfs_common, maybe?

Since they're shared between client modules, and not the server, you could probably put this in a new file under fs/nfs/. Maybe fs/nfs/acl.c?

> 
> Thanks in advance for your help, rick
> ps: If you create a new file, do you just update the Makefile or is there
>        more trickery involved?
> 

Yeah, you should just need to update the Makefile.

I hope this helps,
Anna

