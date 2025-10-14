Return-Path: <linux-nfs+bounces-15250-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C784BDAE36
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 20:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 315524F4CC5
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 18:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E684F7083C;
	Tue, 14 Oct 2025 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rFTssIME";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nDhKXwRG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18B29AAFA
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465092; cv=fail; b=I9H4AvxKID0iF6h2dikn4XlOBN1BN3BtdP77q/Zdg0FxrCVgOvtInTXlMH+lGZTFS44RoWs3+Si+HFDxtSd/gYn0PMe2P0SSNbf7caEY+0UORn3GVK6BLzpFpSbGR6DtZH5CD1X/5jhT4FpvZJesDJVxI39Vg1BmutHmc+ctTnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465092; c=relaxed/simple;
	bh=EetOGvuOxLq1yFvUo8N0bEO4DsMjH/Lv95g57cT2fMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uIa2NtTz37A/3pqVePlJwlNk0L1Fgdd7tX8n3+5WvZxxV60O1CL3x5goCl8ZfG8cMG3yfIM3BJ8O3BWFkaJFukMSjRZO2y2gzYbTqY+6puVVXf2xeaNPYbb3c568SwdTgLErjhaGAQmmEGem2iXtkzEE8Z5txB6SevsrniUYBCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rFTssIME; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nDhKXwRG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEf6vb014379;
	Tue, 14 Oct 2025 18:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Arej2KPg9UupaGCbceIx1JKrPhjDV4DQnCTHPyDJJ6Y=; b=
	rFTssIMEEonNSwlyIpis8AJ4mPRO5RvuH/JKOlHH+QFhhm/KhNb26LbNiBlzio8w
	t1ml4uKrwgogvEvpzrr0w5ab2p4LrCAFtYxsaFoERKMOb/NHVIRn9vU7GzgALbw0
	azZKHHgYC9qYPzTFM8vb+FzYCPwW1ZiYAAY4Xi+R8qVmFD/cpL8K9oQJvRnDJXLC
	t4Ls7ckkrP1DHmOAjPiYzzV/GkVucuzPiONCSecbHCb7KJnmLfbMBgXbGchvLQi1
	YoF0SDvKiKtsGhLNMfz+wEtvGJ5TJkKXNWuXcv7Xm/18vAD8GoIbfvA7C3qNTvQ7
	aMR1wL22Rg/S9YmWweBupw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1qc3cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 18:04:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EGRuoO009738;
	Tue, 14 Oct 2025 18:04:46 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpf9nca-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 18:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJnyoRz+PkFT3e/YGkkCoPQyByNuUen633rDCElmNg/iIQ4yiYgLid7rHfghcipvoZPyIJZAhZpMTG/oKF1vUhkprJfhn9XOK44hOLtZb6UeVIwSKdkOFTiAibEBzJTxn7D2DcOH2Cubb8XVviONw50nGMStjdlwMI2QXXFJprqmbT0SHdJeIM7v61VQi+qe2GrY3eDguRBjNWENa403E0CzWirU2zEo0+3i2s1iQ6KWETP/fS0R7YFzWiBsn9Z4Yj2VNGeqAPc1+LrpQfEcG5eAId1O/0nkE5Iq+u2bKsYoX1PJ72ehqINaVAXZ3avBGTZv3eBbAAPuXuq85/VAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Arej2KPg9UupaGCbceIx1JKrPhjDV4DQnCTHPyDJJ6Y=;
 b=Nyo+bCU0Lcu/4u3sVOYPCuLQPjdzQyFY5z/GOU0kpq3zKu3zmL64LNxGPPb/XtiELWeC+0RtghTOtW1FaBknW1KYywCi0HFwYtlZMiViFpLQgBKNmDGXflYWEvQSqIgTIk1XgsWkN74/BqLAkfn280HHZvnSfwj/kA4gPRgE6nakpmzP6GbsfyhvfyelFMtCd39UQpPySF0zn1WygPvU55u99XbERp9ZAwFlvw6GHaxGwkw1xGZYkVSlvyBss83ZrVrPt8oFqz38JJWP7wLTPk4KvKMhcWGVF+3tylZmq9qc/of3Wd49Syab/bTSelclvQhqk1wjp5G48pb1fCIhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Arej2KPg9UupaGCbceIx1JKrPhjDV4DQnCTHPyDJJ6Y=;
 b=nDhKXwRGO+Fq4B6If4cbLiSRxm2rpWZVx11AUWWn7wHS3lGFO6Tc8rECrzsuers+az9cIBJVEh/Fuz9O3xNkaiyoaRmL9JO/CtEOS6yj7CLnUDO3TVkrr2tfPZF0UV2PGXS2ShPNL2VzDNFHxHmTC5hmelLcfpHWdlGTvWmaLPQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4699.namprd10.prod.outlook.com (2603:10b6:806:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 18:04:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 18:04:43 +0000
Message-ID: <53d794cc-daa8-489a-8fcc-173e5cb8ef75@oracle.com>
Date: Tue, 14 Oct 2025 14:04:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: free copynotify stateid in
 nfs4_free_ol_stateid()
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <20251014175959.90513-1-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251014175959.90513-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:610:b2::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: 756ca8f6-5528-4869-574e-08de0b4c26d4
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L1dUK2ZBOW1xNEt3UXc0MmIyU2YxUGVnT0gwcHRoTzh2NHBHQWVqbzkzV0FZ?=
 =?utf-8?B?dFk0UFh5N0RXaU1tQWorSDZVeFg3Q2kyL1BwQThCWXhaYkZkR2VaZUlJL2dF?=
 =?utf-8?B?akxWbklFalR5R1ZnUjU1eHRJREQ1bVRMUjM4bDgrRTZNai9WOERRaWd5dDFE?=
 =?utf-8?B?eDNNVm5CeURRRVRzTGp5VG90elpqeWFRaGF2blFNNy9vNjRyRE1zb0ZlSG5v?=
 =?utf-8?B?NVA2NGh5SXNMdzlRSk5mTUxYbVJRNlhRbkJydUhBd1ZXMHNWQUJ1RkRyREJ4?=
 =?utf-8?B?bzR5NndnY1FqaFNWUkVHY21GRnJHNHJ2cVRjdmo3eUVaenhrVzJjdmxsQld0?=
 =?utf-8?B?dzkzZENjMS9Sc3BlQW42MDJ1ZkUxQ3ZuMlpKQmR1ZFExN1U4WWo0MXpTZC9Z?=
 =?utf-8?B?MklINDdwYW5SRFVVRjlJOUxITkxkR1VCdEpzc25ybXI0WkpaN2VnTytycXlL?=
 =?utf-8?B?QmFRakZ3T25kZDlDRUppamdRamtHUEUyR0pBSVpJUnQ1c0dLZnE5V29MYWxi?=
 =?utf-8?B?VG5BOFhqY1VyL0lQNVR3RTdZdHYrYjRwMXRyWVlkNWlSWTQ1ZUdydXI0Z2M0?=
 =?utf-8?B?YTNBMmJxVkMvcEZVS3czVmFoMlVsbktadlYyTjVmb1dVbXlqSDN4WmViQ2R4?=
 =?utf-8?B?V1c4cDZvT1M3dFllR3B5WjdPSHNNa0M0aTNIWWxuUEZScXhwWjFFTVpNMS9K?=
 =?utf-8?B?NkNtenRsTjRjOVZVc2tZMUtiL1B6L0Z6Qlh5WndpMDdmQXFOUnk1YjlZemZG?=
 =?utf-8?B?SHl4VTNZMmxlM25IRGt0RGxtY2F3NDJhRk11MkJPbXNXQUZlTGVCN1ZwUm9N?=
 =?utf-8?B?TkVwZkRCWjJxZ3I1L0hYQU0rSjBIQllZeGpVYXJrRkhET0hMY3BEeUZJOXFh?=
 =?utf-8?B?M2pvNGxjS2xHWi83Y1NyUVp3Y3JnYXl3dUlDR3ZLRUZjT2h6TC8rR0VnY3ZX?=
 =?utf-8?B?N1Qzak4yNGt3RXVabEQvTE9HZUtnWmpQZVZxSkRBYUJVVFltK0d5VUpDaGMx?=
 =?utf-8?B?LzZMUHRtWkJkeGpGK0lYZVdjWEY5RGxKR1FGYVpOajFyTlZENFFOQjI4Zk5H?=
 =?utf-8?B?ZklBV1ByNUpSYXVXVjBaa0UzT2xOUFFkN3hMcjdzV21wSGgyWThuY2RrT3M1?=
 =?utf-8?B?UWZWQUZ6bHVEbU5TeUF5MlpmRVY3bG55eXI3dmZLWVRROXd2YnUzTXlLTTBW?=
 =?utf-8?B?YTVBR0VwY29Eb05EdEwyNnFoWHhERC9LMGdDQSs4bjI1UVZ2NWtUZFlaNHE5?=
 =?utf-8?B?dGJRRExTK1k4clQvNi9mV1pUOTJMQXd1SDQxc2dlcFliUm0rWS9OdVBZTlZh?=
 =?utf-8?B?MEhwTm15S3BqejBXS3B6aHdVczFOM25NazFFa3h4WHlJTXNicE9tSUNVR2VC?=
 =?utf-8?B?WktQQ0hhaXRhWWNKdW5XOTlOVmQzL1VmQVdkZjBEWGFYK2ZBTjNpWUFITm4r?=
 =?utf-8?B?dmZqV3RHN1VtN0xUT204VWdRUXk1SXUwdGdMNDhTbTl5T3ZFVXY1TFZ2bzdm?=
 =?utf-8?B?UlYzUEt3ZWhDNWZUMjNRZis1T3YxWXJ3cG91dnBxcjZLOTdwZTZHUkxlQjJ1?=
 =?utf-8?B?TDB4dXJmaWZnSTRzQUtZS214T0tDZ3NtZVAvMjRnZWVybm5vNm1nVGcwTGRu?=
 =?utf-8?B?dk8yV0o5SmNRQ2xQY3JVREJTQzQ2b0l1WFh2R2dvRG11YlBYeUk0SWFRWlQ2?=
 =?utf-8?B?am5TZFBIbVZVajMzTlhqRXZwZWtFdFo0S2JIZ1phRWFZeG5qbWVLOEw3OXRO?=
 =?utf-8?B?QnRRUUUwbmFvZk1ZTFNSS01TNUorbXdhV3QxVnJvVUNMaWxMTThSajIrTDNn?=
 =?utf-8?B?L0FxV3FMZG9uOUxwZzdQNFQwOEliZ1ZTVUQxNC9uVDlJTzhHMmUrVEZSSms0?=
 =?utf-8?B?Zzdjdi9sbE5MNVBWR1duVUVPc0F2Y2tsZmp0VzJSeG53eFFpUUl3UUZ2WGRw?=
 =?utf-8?B?RWp0TEVCdG1rZVY4MHRBd2UyeHFXbTZ4dStXZGFEMExKdTE4YVFZQ3c4R2FV?=
 =?utf-8?B?NlZzSm16YnNBPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bzZ1ZWlFY2FkZk9CdVcyS0tNcjgxNWhVM1NJaXlTdGl1NjVhSVVXTEZEcGd3?=
 =?utf-8?B?REhuOEZpcWJHb05rU25jZ0M4TnFZWnVLMDBZY0NRdldET3YrajhoWWQ0RnVv?=
 =?utf-8?B?WndNb3dDUjRtNkFqNnpOZXFqa2FvN256c0swQ0N2K21JSWJWcmxCdTVlNDRl?=
 =?utf-8?B?Q0pOVlYwOWhsOGdVbDY2Y2lldGVGZUpKSFdCQ0hsdGNDV2dUU1hiMGVEV3pR?=
 =?utf-8?B?YkVnay9IZERQeVR1ZkJjbUlMTFc3OTZqOE1jOVVIV0lHeW1XeE1VS3MxL0Nw?=
 =?utf-8?B?czBoZ0tGVVkwUjhjUUhZNmFhVmp6eDd1OE9zNnN0YTIxRi9ZTENIUENNdGtR?=
 =?utf-8?B?bkorRjNnYkdQQkVqbUYzTHRsbDZOaGFJV2N5Wm5iSEQ3S2FnQ0tnSlRGQTBL?=
 =?utf-8?B?UmRrUVVmY1BBNUFBTXVGNW1Va3preVhLMUpBOC9VYzdRUW5PbmFYRnNPeWdL?=
 =?utf-8?B?MFFXMHJKSFI4YzFiUHc5NmV4eGdCY3c1QnltVWJtRnVGSklYRE9pV0dFZnJH?=
 =?utf-8?B?K2pLOGlBYkFmR0NNZ3BaWWFEMUcwZGZKUzVBOFRlRXpXTEhnRkh0S1JoVXlC?=
 =?utf-8?B?b2R2R3BmZ3B2VGdFTHUyUGtySW9OR2NPaE9HcERubUhrTnNLY1pOb1JQem94?=
 =?utf-8?B?dkNRblRKVTVoQ1NSUGVXNkU1Q0xFTFY3ZW9sRlFCTi82OWVrQW5uOTBxN2Yr?=
 =?utf-8?B?MVVUOHFiTkF4OWRwRWFJMEV1b0M5K094OEV5cHFHZDg5ZEVrWjNnK3NsVmlz?=
 =?utf-8?B?U290OHpzdzNwZ2ZrUEpwK0FTWFQvVDNSemlVMEVzdHh1K2JSTUVWQzZ4TXBp?=
 =?utf-8?B?RGdzanZwUk9CanE0aVNlb2FyQ0I2d2F1b3podTBHdUx3cnpqQ0g2WmwzbUVl?=
 =?utf-8?B?cWVTcjZ1dk5OQ2V2UzNKVDhlcEJzcjNxbDc5SnhkWGRycTNZU2x4OWhPY01B?=
 =?utf-8?B?alg5NnVwdEVwRjl6VEhNSEdsNFVlT1VKRVc5NlZsRmJoa2pOUmNZZEZGaHpX?=
 =?utf-8?B?ZW0rQXhEdWhRRmR0RHRRcEEzc2pnekFXOG55S3BtNG9RM1FTb0JvSlJYQ3hk?=
 =?utf-8?B?bVk2MTZkZlcybTFGbHgreUZaVGUzZW9jUS9sQ1NZejh1WVJBNDZnSStQVE1V?=
 =?utf-8?B?YmtBQWJORVJyK3AzTFRueVZBTGpKbFVWUW5wV2kwZmd2NEhpSlBQa3FwWGlx?=
 =?utf-8?B?ZU5IZzJrdlNtdnRFWHJYay9WQzc0K010Si9UMDN4b3o0LzJoWmRzVkN2MWR0?=
 =?utf-8?B?bjIxaS84Sm90RGNZaVJ4ZC9BSGFqeVZ2b3BWY3dSYmhiNEtkbzZMb0p2aDF3?=
 =?utf-8?B?bVhNbTRNQVZ6SGxraDFISmRzN0lxY09NSDNXNzBaSFk2b2hMeURPNFlnaHp0?=
 =?utf-8?B?UlEyZXFNbjVXdGhyVVNoSEhJWVRvMHltUHl3b05hRFR6REl5WWYvSDdaTzJX?=
 =?utf-8?B?bUFtS1NIZnVnY1E5NVFOd0RVR1dWYzNhaUsyREM4L1cxQ3lQR1Fvb0hGVHM4?=
 =?utf-8?B?VWtPMGw4aHgzRjVqS0dKemhTY3NxTmRscUtmdG1MTHBpbGdUSTdPUlp6dTdV?=
 =?utf-8?B?cW9BbXQrRUhacVpLZjRnalJseDMvR3AzenhQSDkxbFFYb2llQnZVTjB3V3Zi?=
 =?utf-8?B?QkI1UE5oWnBYbk1YNWMwdHgxaERvOExUOTlxR1lHZnpDN0xYRytLWHpoNlhR?=
 =?utf-8?B?UGVWQXJqZGZOdTlKS2ZhdTNpa1F2c3I0VEVPSlR6ZXE0am1EOThXaG8zWGRl?=
 =?utf-8?B?dnNPT09kYjhXR3Bldkt1N2tnZjZxM0dMVXcremVyODBHR0FDWE81eEo0aEZz?=
 =?utf-8?B?RUpUd0dYSFhsWEZjTWk3V0hyUlhiWWlWL3VtK3pLSTFMSWRmOVJTcUwrTHhG?=
 =?utf-8?B?OHhlTFZlYi9nQlVUd2sxNlgxcjNUeGcrNlkzRVArMEsyQ29mUS9sQVZJL05V?=
 =?utf-8?B?NnJXTC9qNkFjRTltOGNFVWRFT1RwVzlCbWRIM2gxc1I3YlRYKzB0MnhxTm8v?=
 =?utf-8?B?TFhvSjhNc0lIZk1yek5wdXRNMldabHA3S1MrOHFnS29zWi90WncyOTlnQ1N1?=
 =?utf-8?B?T3JmZ3FVZllQOFBVRjN2KzJJRjRmampEVFU1bXJ1N3ozYk5XcTM3MU9SWm1j?=
 =?utf-8?B?aHA5aDJvRmhTWi9RbTdyenUzTHhzUzYyd2xsS1R5aDVLQUlRVjZYWFc1cG4r?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x+rMFTx7+L+cXf7u1M8mxJDxWdnUvSEJtjHI5Cf/bviPRhh7sw6n78sSPGwrO1DOTzjnYitvA3NTKGvR9UJQ2dZiqc4LuA7Vnwx6kN0ZlL0+QKSx3DtgYOXhXfwzQhWHazbSvenBySely8feRKKQqVgFp8rsqztd50ODgp12OBgpL1kxfYsQUneOtkd4/dpKsjgV6oTI6S840CncWi43YmEH2UktiOFMkMDkjCm1GzYD/HkfqFXf9RlHr/MkZl/FftrcpNqxzW6Jq0Qcq04cUMe6hdhnt10DCfuyWTPVgQhjbpbcB0bvZ4zpEYDvrPq7tyZp6ij5Ng0NKhkGgdURI32sjA3+wnWhqTSR+5YpXgDEo7cfxX63etuvhWjZOrlCvOYOd433VZaO3Lkn5kqlMBRa5FYAannN2tk/9IdiX3ng8sTe0+rF3EzC27/P9SLVNo8ZzWj02nKyRMpuDF+igAJOBhRuDhDbDZnCrMXzd45Y8RxFsEsT+i/no1VDC4U2PZWxZinj6D9DBzOaKiOoZRHsb8G0w4W2L6La3W2lGBD/5v7Nn2tMw3CI0BVqWAVrDboVMyDEuOHiFzxsMIDOsDz7hpwTyPxby/U1yKM1vdg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756ca8f6-5528-4869-574e-08de0b4c26d4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 18:04:43.2079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwh6mjsFD1gEeRt43oNTkoEgOxtp5v9WpMYqIBJx/TfGHuXaAeXun4PSsBw4srn9DwSUzB7zljDoCTzP94P6vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfX76HjmMHiZ2DN
 RjmWtV0A+8HVIARB9+6ZQ5sA+CsElo4YlNXcsUQW7tmoYnU9TeKWBX55rrnBww9XwGZm94uTFE/
 +95og0noh+UREXo/k/2abrj10TpEc6GQrZClyyCRRXaz0sB9rf3fRhly1HeAN9umtANBWnwM8G+
 fj9tWeTnuoIWolqKpcoVxV3BdT64PqGioB6f3qow+LO8F4pyvusBUNF7Ihcxs9BxkR7eFLFmFd4
 u+WsF+aUk2KaWOkVBBJ1vC6gVL0WO/5BusMuC4pJ7D1LeznUeL5B+8BGrsH/bq+ACB8KLPH0mM6
 YgSeM2doSCMe9Jl/SpIDIaSohxKzSm9+zMWpQN3MpsNlVz5gw/xpwTbm9hv4OPzr1s1YQJbfz7O
 5WW+arOmNfhDWeIOQA+aOlOWP4dhGjsQ8i8P123zzi2Zgfc9BqU=
X-Proofpoint-GUID: vIZTEueWH6EnbybtkzoMQ1NZdS9mfUtv
X-Proofpoint-ORIG-GUID: vIZTEueWH6EnbybtkzoMQ1NZdS9mfUtv
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68ee90be b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=Cz1m2bjIdbIP_xI71TQA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092

On 10/14/25 1:59 PM, Olga Kornievskaia wrote:
> Typically copynotify stateid is freed either when parent's stateid
> is being close/freed or in nfsd4_laundromat if the stateid hasn't
> been used in a lease period.
> 
> However, in case when the server got an OPEN (which created
> a parent stateid), followed by a COPY_NOTIFY using that stateid,
> followed by a client reboot. New client instance while doing
> CREATE_SESSION would force expire previous state of this client.
> It leads to the open state being freed thru release_openowner->
> nfs4_free_ol_stateid() and it finds that it still has copynotify
> stateid associated with it. We currently print a warning and is
> triggerred
> 
> WARNING: CPU: 1 PID: 8858 at fs/nfsd/nfs4state.c:1550 nfs4_free_ol_stateid+0xb0/0x100 [nfsd]
> 
> This patch, instead, frees the associated copynotify stateid here.
> 
> If the parent stateid is freed (without freeing the copynotify
> stateids associated with it), it leads to the list corruption
> when laundromat ends up freeing the copynotify state later.
> 
> [ 1626.839430] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> [ 1626.842828] Modules linked in: nfnetlink_queue nfnetlink_log bluetooth cfg80211 rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd nfs_acl lockd grace nfs_localio ext4 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops snd_hda_intel uvc snd_intel_dspcfg videobuf2_v4l2 videobuf2_common snd_hda_codec snd_hda_core videodev snd_hwdep snd_seq mc snd_seq_device snd_pcm snd_timer snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs 8021q garp stp llc mrp nvme ghash_ce e1000e nvme_core sr_mod nvme_keyring nvme_auth cdrom vmwgfx drm_ttm_helper ttm sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
> [ 1626.855594] CPU: 2 UID: 0 PID: 199 Comm: kworker/u24:33 Kdump: loaded Tainted: G    B   W           6.17.0-rc7+ #22 PREEMPT(voluntary)
> [ 1626.857075] Tainted: [B]=BAD_PAGE, [W]=WARN
> [ 1626.857573] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> [ 1626.858724] Workqueue: nfsd4 laundromat_main [nfsd]
> [ 1626.859304] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [ 1626.860010] pc : __list_del_entry_valid_or_report+0x148/0x200
> [ 1626.860601] lr : __list_del_entry_valid_or_report+0x148/0x200
> [ 1626.861182] sp : ffff8000881d7a40
> [ 1626.861521] x29: ffff8000881d7a40 x28: 0000000000000018 x27: ffff0000c2a98200
> [ 1626.862260] x26: 0000000000000600 x25: 0000000000000000 x24: ffff8000881d7b20
> [ 1626.862986] x23: ffff0000c2a981e8 x22: 1fffe00012410e7d x21: ffff0000920873e8
> [ 1626.863701] x20: ffff0000920873e8 x19: ffff000086f22998 x18: 0000000000000000
> [ 1626.864421] x17: 20747562202c3839 x16: 3932326636383030 x15: 3030666666662065
> [ 1626.865092] x14: 6220646c756f6873 x13: 0000000000000001 x12: ffff60004fd9e4a3
> [ 1626.865713] x11: 1fffe0004fd9e4a2 x10: ffff60004fd9e4a2 x9 : dfff800000000000
> [ 1626.866320] x8 : 00009fffb0261b5e x7 : ffff00027ecf2513 x6 : 0000000000000001
> [ 1626.866938] x5 : ffff00027ecf2510 x4 : ffff60004fd9e4a3 x3 : 0000000000000000
> [ 1626.867553] x2 : 0000000000000000 x1 : ffff000096069640 x0 : 000000000000006d
> [ 1626.868167] Call trace:
> [ 1626.868382]  __list_del_entry_valid_or_report+0x148/0x200 (P)
> [ 1626.868876]  _free_cpntf_state_locked+0xd0/0x268 [nfsd]
> [ 1626.869368]  nfs4_laundromat+0x6f8/0x1058 [nfsd]
> [ 1626.869813]  laundromat_main+0x24/0x60 [nfsd]
> [ 1626.870231]  process_one_work+0x584/0x1050
> [ 1626.870595]  worker_thread+0x4c4/0xc60
> [ 1626.870893]  kthread+0x2f8/0x398
> [ 1626.871146]  ret_from_fork+0x10/0x20
> [ 1626.871422] Code: aa1303e1 aa1403e3 910e8000 97bc55d7 (d4210000)
> [ 1626.871892] SMP: stopping secondary CPUs
> 

Reported-by: <rtm@csail.mit.edu>
Closes:
https://lore.kernel.org/linux-nfs/d8f064c1-a26f-4eed-b4f0-1f7f608f415f@oracle.com/T/#t
Cc: stable@vger.kernel.org


> Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 1c01836e8507..c197438765db 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1542,7 +1542,8 @@ static void nfs4_free_ol_stateid(struct nfs4_stid *stid)
>  	release_all_access(stp);
>  	if (stp->st_stateowner)
>  		nfs4_put_stateowner(stp->st_stateowner);
> -	WARN_ON(!list_empty(&stid->sc_cp_list));
> +	if (!list_empty(&stid->sc_cp_list))
> +		nfs4_free_cpntf_statelist(stid->sc_client->net, stid);
>  	kmem_cache_free(stateid_slab, stid);
>  }
>  


-- 
Chuck Lever

