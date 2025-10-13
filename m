Return-Path: <linux-nfs+bounces-15179-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2E4BD3441
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 15:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6405B4F26AE
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE833081C0;
	Mon, 13 Oct 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="se88XIML";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qmKwl4R1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862FE2F28F2;
	Mon, 13 Oct 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362943; cv=fail; b=X18UC6ooY4x7WQzrebG+1WEEPQa4QaUoyZGaAb/OtTHFjpXr1nHletXd5oQ0ap/MLQSdkA3PoyPP5+4dFvO6xwo+41aly1D2YX44JlATymdaxEbN/cAk3ez7tAf4fp3xRZDsjkYKHsJDH/bM8NduUZ0onDr8LHnfYYhFJRUS50o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362943; c=relaxed/simple;
	bh=aaVZmN66R+y/BmBhh9Eaj+2epPahTr9VD5Z8fId/k9s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bdjya0zn3regDja/DtLkATGvEbSMxNiN+43JkAfg4djy7ifBuKn36N3unjSUfVwsmRE2dm5QXfTzptTOsdnkD3Xz5UKRCqBs0nX8YBbI+7AY24xfInRSu/HpS79AgvDJXGdVzAL8v8ciNYxXbjPzLlXfVTgIXZSCj6bmiad0LWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=se88XIML; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qmKwl4R1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DDfx0C030974;
	Mon, 13 Oct 2025 13:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IlNRhoi7krsJ1JoWCa6dq3LMEDvNbPRHBCTZq3Z1Orw=; b=
	se88XIML7fLq68fwJ6giV9qPm6xYqZpuhZ6SXdebPwDraJcTW15w7QNH53Gq+YcD
	EgpPmq2M2Vl9/GbR9RKoS88/Gab0Zxef+UhXYQWZdZhLqUq3ej4p/HCKkCN03jzU
	iAgHf+wYadFfJyFUHolSUoxkCM639yGoQDJiQ5pw/njEfWZ3tfCKtoXlsQ3+h+ZY
	sOudFwrToqXVdBQ1tv5Yfs1XwC9YmU6HteR2wo1Y7fX1hjCguu2as8CEaRBg/w3M
	mMg9/NmUOz3xr9inq1xhxpcwx9WLl1NdBuu5Vxb0FzbnkDextOMycjPEj2yMNQBR
	OytytxAPtx+OCkScK3KQig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59aava-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 13:42:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59DBsqo0017715;
	Mon, 13 Oct 2025 13:42:08 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010061.outbound.protection.outlook.com [52.101.193.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp7ja87-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 13:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwW+UQ+upGES2/TSbNsJG2Arao734mlIUH6ME5zA0/Gv1T/oVozqjUA4arG7javJzyuOkq/0/VrPCH+w1vv3iHEkzVCvVF/JAUvgKsCdmLzBtCK/BMoBrowd4xSuMWfjgAnGjpvC9BzZuuPd1NdFTVGDbmSG0OzDmJZ4RbxMdxhyigoJfk7+/iqdVdcbZy0c2e+7jn4A7mmas+F0Vcasoz7vgWhkHmQDfhtOR44bL+9gIjBmwx1uR9EnBh3Wjoke+T/wQ13WBzwsyb0+Cp0zWCpUf+hxVCSnELZC9dnsL//oqBr5GHV9aWioiB5Dd8xGlLu56QEp1B7RbPwhZS1cZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlNRhoi7krsJ1JoWCa6dq3LMEDvNbPRHBCTZq3Z1Orw=;
 b=EHgw0hCuDvjTGFnNBgkkslB9HmnAWEvh687Tfoxc87AotSf+ZHAerDFqoglDZTAY6ZvgVe9f++Mk5yQ5y6foIn6OmCeL3sm/ZKEjxkI/xHCH5qX9zJRv5qy+dd6PFs9Q5S2l8YTwbdCQdrM9/6D+jj88x/Z1KazFQojs8oH82vYTkSAvtJygjc9IafSRbylZ6BAbN1cqP9kQOnmt1CqajN3JG9DWfhgtGgZ7thblloOqH5QfeVWfHncx77O+YxC+JXDShdeT97mAtnGmjcZ6r7ZMYDG6awluRGHQ7I3/SEcbdDzdY19m75iHn2o+PRApaaSI2LlHIsHUGJ+CpRoEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlNRhoi7krsJ1JoWCa6dq3LMEDvNbPRHBCTZq3Z1Orw=;
 b=qmKwl4R1elontz7pGliyiIYlmZdOEFrkqoaBkYw17/KCD7xwAb7q6Z1qupJIhDLrgA3dnO6Hz9A6ZHw/bVC91dxwlbnsb2osS30QZ1kMs9gyvaeeUqCjwBfH/lH1nmoBt1Q82MKjaO86HTWcYb71H79zyhWJmolC5nWf7idCw9I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7196.namprd10.prod.outlook.com (2603:10b6:930:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Mon, 13 Oct
 2025 13:42:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 13:42:04 +0000
Message-ID: <30abf63f-4aff-41df-9aa9-cdce14c6c7bf@oracle.com>
Date: Mon, 13 Oct 2025 09:42:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] sunrpc: allocate a separate bvec array for socket
 sends
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc: Brandon Adams <brandona@meta.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251013-rq_bvec-v6-1-17982fc64ad2@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251013-rq_bvec-v6-1-17982fc64ad2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:610:cd::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 04aff389-bc8f-49c8-20f5-08de0a5e4b50
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?b0o4VTlvblROWVFBaStBa3YzNStzaHlPMTZ1NWhNUzRKM1F2Um91MGFQMVFp?=
 =?utf-8?B?R3l5ZEN1M2ZpdVBGUlN3cW9VSno3M2Z4eC91U1VoNWdoMHY4b0pHYjFHRnhq?=
 =?utf-8?B?ekVURmk0YUJLcHo4dkxUZWdsTFhOM2s4Y0Z2Z1VQaUcyQjg1RUMwQUtmWnJt?=
 =?utf-8?B?SFhiN2NLY21MNENsTWdvSm5nSmttcDR0VGdZdFhEaDNvV3pxS3E4R0ROcVg3?=
 =?utf-8?B?OS81Z3RpM1pVa3lUVmVCS0N1b3JTWHZ6S2RBVjVSTXlXSktuV0dHSXRkWlEr?=
 =?utf-8?B?WEpMaGNBUlVkS3ZhSjRXdUJNNzBMb3g1alduU3lwMlVOSEwxeXE3NkNQTnlG?=
 =?utf-8?B?K2NxUXFkSHRMWFJRbGVFTXpGRVFlaDVuVnI3T0tPQWFmM0Q1SytVUXBhdXN5?=
 =?utf-8?B?WDZuWmN2MXdjZmx5K2w4L1dPZnBCcUNKUHlHejY1QlFvYWpJV25iR3dybjlT?=
 =?utf-8?B?TTRyV21LYmtNV2ZHODBVNlRwQ0NOdVloM3pPWk04NmtxZ3VzUVJBTWIxc3ZK?=
 =?utf-8?B?VmZkTi84Y1Z3SUhRNTVtSlBnc3Q0bUdhUzhRRmsvNUo2WHBNQi8wN2Q4TUpz?=
 =?utf-8?B?bGRYYk9XY2lSdlVWVjhyMlhvaHZ1eHNWTVVzaXAxS2Q3Q2tNQWpaWkZ3dnVG?=
 =?utf-8?B?ZXdDM2g5TkdmOUh6bWRPU2dCa0xIbi93OW5UY1BlTlVUQzNkSTBlZHB1bUF5?=
 =?utf-8?B?L1M2ZUhSWmFwazdDYlY0V2xsaUVqL1o4bis1dVVGcHJYc3Z6cHhzaGpQWHBF?=
 =?utf-8?B?c3ZyRUs2cXA4aG9kUm55NURzYUpoeGU1clRCUUFLT29HK3BTR0J2M1kwbWh5?=
 =?utf-8?B?N3RScklsd0dNY1dyWm9tSlV5TEJvMVZWNlRMcWsrcTl1SUlWQm1KUGVleDl3?=
 =?utf-8?B?d1NlODJJb1pNL0FDaUE5TmdSa2tXeVJBVUxEcjV2L3lRWkRtUG9YOHVCZ2hP?=
 =?utf-8?B?UWV0T2dITkJpNmJPd0N2d1JnaDZzK2xLdy9BcEIyMjlsR0dheS8yUGFzNVh3?=
 =?utf-8?B?RDA3b2N2MzZDWUd4c0U0RzJBTmF2OVcyaWFVekdqM2kvTlRGVW13aVhDL3JT?=
 =?utf-8?B?NEhCbEJEOFRiQkYzWGlNSElCODlZeS9Mc0wrLzd4RGY2QXRnTGJtVFl6WmxE?=
 =?utf-8?B?VS9BL1Jtd00wYzVvMTNtS1k5b3B3K3RCTUVzUldBWldPVjlUTWtXaFhWajZl?=
 =?utf-8?B?bWR4bHBXa1l5QnVOOXJ5bk9nQ0k0eWg1WjRuSUgrdEhOSFpmcHNIdGFWbFpK?=
 =?utf-8?B?eE9pNzE0OTNJcFRlMnVkNWZHZlhnUHc3MnFhY3FVcVU1bnZ4Mm13Q3hoc3dQ?=
 =?utf-8?B?ajRCWTVmQzRUekN0cEVHWVFhZFU3V2l6RGNNWmF2blFNUUR2VXc3dnVVWGU0?=
 =?utf-8?B?T1lHaW5sQi8wdis5aU1sdloxQ3lSS0FtSm9ZTTdwNXpqTzl3cE1GYTJVVHJH?=
 =?utf-8?B?RlFjeTNHQ2IzaFNGdTVCWGpxcmkwanhIQVpVMWlRdDV3ZkgrS2c1ekpmR1Bs?=
 =?utf-8?B?dnZuRit0VFZyTWhlZlp1cm5LRVd5NVFYOUMvaXVwZUFLUnVMSE5Mbi8xTnhJ?=
 =?utf-8?B?REFibkE5RWRyRlp5cEJ1M2p1Ui9ZdElHaFVJc28rZ1J4d0RrSnYxRnhLeUFI?=
 =?utf-8?B?aCtOdVRyUXEya1RZU2pjNC9PSUdVVFR6Y2p6N3loQW1PVlFqNCtHZVA1VjdY?=
 =?utf-8?B?dDBtdDdpS2YwSk83L1ByUFNoQ1loV0tzNXp0Z2VHZUlyenYvbjBsb3lBekNq?=
 =?utf-8?B?VnMwVSsvaDlCQllZaGI5V3poUEVJRVJsY0ZlVXlveDFMT2pqQ2NtTmJUeFBU?=
 =?utf-8?B?WGJncFJvdWJBNVpIWWtIZVVmUy8yditJdEhVL1NNMi9MNzVLVzBGbjNzempo?=
 =?utf-8?B?ZnpBcWs1K2IxckpURGlYMlY3UjZHZkorc1didnBmdFhWbW5kcThCeUM4Vkxs?=
 =?utf-8?B?NnMwbmd5ZGlPMjJaK3lMRHZoUk5ZUzdzUzdxUEtVdFptdjF0a1dFSFRMNU84?=
 =?utf-8?Q?HsEz5KQ3TbnokCzFvXuTrF2Qqy+mE0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?R0ZnRWY2SnFod3ZtVHdDRHVNRXNzMUNnWXRpRW5XbVcvMnJXWWFHSlltbmY2?=
 =?utf-8?B?N2tGaTVpZnJEQTduSC8vRHdPZ2pPK2E5UElJUmc0Y2xoZWFNemJmL3dGT3o4?=
 =?utf-8?B?NVRWdm51WURBUyt5TU9OUmw5ZzRjWHRsTFRwZXRUVVNiYXoxQnBKSnk3bllx?=
 =?utf-8?B?cGNsTU8raGhJYWJPdURGVGd2Yjh2SUVyWkpES0xZNzk1R0xkR1VJY1BlODQy?=
 =?utf-8?B?RU9wVjFFWmNYdm1aZkZwRnk4WEV5Zkp1ZkhxZ2JTOTEwc2lTTFJwdWV6dDBw?=
 =?utf-8?B?WGtybnA3K2s5QkJOU3VnVzkxWlhNKzhhVmFpNkxpb3AyT1krVGM5S1grTWwz?=
 =?utf-8?B?bExKVFdBVVd1a2F3TnYyRzVDc0J2RVorRS9kcHI2UlJjenE1Qm0wZTFwNFpu?=
 =?utf-8?B?YXV4NnBTbEIxbXpuNDlYd1VKVlpsb3NqbmZpUXpkeXJTQ3pxamxlb0FiUzNV?=
 =?utf-8?B?U2o1OCs3eVovQ3JIenBnVzZSREIvelFxdmFQYkU2cHRjWXJxSGc0WVFwc1VM?=
 =?utf-8?B?cm5MUEVEd2o2aGVleTRzUm94WlovUWFVZmlEUHNubzY5eVM0MjJQK0czRitM?=
 =?utf-8?B?d1lSdllhanowTmp6ZU9sKzB0a0d3RU5SNWxNOVk5elB6cGpPN3hyUHZFMm0r?=
 =?utf-8?B?Ym8wRDdydktSTXpsYkhvaCtqMWgvaGdDNFVEaWNOcVRMRU9TYVBWRzJzUkJw?=
 =?utf-8?B?TWRsdlZ4dW1qbEZMYW1FU2VsREtkQnBDSnBGUnZIQktBVHZ5OW5ydThUSzJt?=
 =?utf-8?B?cEgwR1dhbFE2NjNabGJMbFNLaDR5K0VYKy9wTlpnK2Vtb2RlWFNEWTcxYTBN?=
 =?utf-8?B?Tmh1a0Y5bXRCd1pseWVyOXJ6cExROGsrRkF4Y252R0xuaFpqWFJyRCtNbVFq?=
 =?utf-8?B?YnJCTmM0VWtxRzNsNU41bFRGMXJNWFBSNVhGTUM2OENybmZlZ2YvZUo3TTRD?=
 =?utf-8?B?UHVnNVdEZWxhSFU2SCszaG14MWxySEN2TWgrcG5rWUw3YUpvbnNPM3JWd0N5?=
 =?utf-8?B?b0ZhWnZYR3VpVllXL1NVZUdpcXJxWm9NaXZRbHZuOFF4NmhFYklMditrYVBH?=
 =?utf-8?B?dHd3UzJJcExFK3c4OC9FaVFSK0V6RVJRV0Z3YlgzdnFjYTFQK1Y4Q0tBN0FU?=
 =?utf-8?B?U2o0cFlpK1haMERzMm5SRDNVTzl3ajdsN0QrU3d2MTc2c1VUOXpURnVjSXpv?=
 =?utf-8?B?cVNUY1h4bGxzdFlXQ1Rvd0RrMVlKMUNYTXBNbjhlUTZZNW94Z2JsNlVjRk8z?=
 =?utf-8?B?Nm9HU1NPWGxWTVl3TmpUQ0trd3dFeXR5b2pWRDlHMGhidE41Nmx3dENNczF5?=
 =?utf-8?B?QS9WWFVpRTYvc1AxK0ZzUXZudU1QMWUvenV6bkcxZlIwNmcvcDdIMlBiUkpJ?=
 =?utf-8?B?K1VIMHA1UGFack4xN2lpemhzaG1KMW5tUm96RW5qTUdxeUx1TVI0Q1BTSzZ3?=
 =?utf-8?B?eGptcVdOYzNLWHM2TzZaMk9pQVJvUHl4S21kOWpqT1hqaXZwZHVlWXdWVEo0?=
 =?utf-8?B?WjRJUHI3aURFODdrQXpwQVEyWlQ3ZlZ4d1lPWTZvN0E3NGdPdUJBYnpQWjFS?=
 =?utf-8?B?VWp5ZjNVS3lGT1BYaWhvTS9lWTUwVThYYlJVekdpOHR0TGpjTWJ2UVRMNjF0?=
 =?utf-8?B?MVRrWEhEaUc2ZVhvbXJ4a1l5QlFJdGZOWng5a2dlWkJKWEtJaVpzK2k2d2J6?=
 =?utf-8?B?ajQ2cXFDODlNM3BBZmU5bWVtZDlEUnJ2U1NVN3Q3amZUeVhmdEtPaFJiZkdZ?=
 =?utf-8?B?N1pOYi83U1JpR2lqT0FYa09neXBjcmRRTVIrSElZTkNrMzc3YWdhOFpUQjFp?=
 =?utf-8?B?aStHeWNpR1QvU0xUZmNIbHBmRjFMbEZ2R0w4ZXRQd3pUK0V1aHR1aXdPQmZh?=
 =?utf-8?B?Ylpuem1tMGFNLzRoRUFPdUtVWDNpSEVVZ1dhWVBlSHJXZHFaNXJRajlKaVVZ?=
 =?utf-8?B?QVR2K2YvWk0zNmZUWUcxc3BpbGVleWtPNXNUS1dTbm9CdDdWYlZnZkdxNzln?=
 =?utf-8?B?c2hhWWVFTlZ3U0NwOFVwOFVROEZIOS9EZENjZFhwK3h5cjFqYXF0d21TSXZC?=
 =?utf-8?B?NHF3TnhtRnlCNSt0WUxmOXY1VkJzOUFRS1BWK1M0Q2hPUSsxQkFWd0xxTVZ5?=
 =?utf-8?Q?VQD+cxxCCqSHfnFqsoPg8Uf8X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B8yVOQhKZmO41txaVLhSB3QWcGN85TnuF/8oEGiTI4rzOnh5EtvBWeLXNwPejQsHUcelo+UNmIUnaWsFF2MaWaFatyFCof4lyBlqudW2mWkRZuf296cpQmw1EBIH51OEO5JppIEqmspo4ipBeHo6i6yVJN8a/Ear/8eHv58Z3NMe2inDzVRp5dF1QCiRXW/yL27Ptp+BlyHyjTpbVa05jcOKjE9xmVFVGj7m+ZeWEsleg47eoMY9Sz5K/fTleI/TLS6/Fwkun0Jsgfm8mQyxVM3ZbH8A9gY99o4RVsE6GJLdRXvhlqRZSdhoJ1KyElhkRKngs6DBmEZb6/H+CseN0wmD4XI3CGCAZbR/aBX/4eHCRLYgOfUiMZ1X6qdPwcxnIVDt2BMt5KQozSEgKGlwhhQmpBOpXEGiOUFf8gY5vMbMQveZ8qBGiXWL2zEsp+fcF0dUqmduA84dHtqmeh3x+9HmoeeDw48DkZy3843303+2CqIgB6IvqeizAujvbrPExEyBI2U0MlZvI9d5ghTaSlI06y4RiuOlyDTEXWyX2d45srLjdeMwrh52h5V/9X0lWJhgYdAHOBuff3IJKZFUVBjjLgKTPGXPpHKdt2rIJ1w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04aff389-bc8f-49c8-20f5-08de0a5e4b50
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 13:42:04.2113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RypmP0fXyFP69dfZqN1YetLLxB3XnIncGdqEkhApxfDCziWIBaVIZ2dk4jsVQn57PuTfQYqkFIbq27ccH7P71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=913 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510130060
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX9j/KyauR8Bkm
 H7uIQkTQAnsNTYQC9fE7TseRdfthtmVuqiTzNebmbtsB5W2QBBCOw2VEca/0XG64Z/pa0B0DvAp
 28ZyrVHfnCMlvhA/mbOvj/nEJ5TkIxRiCDzgc7ZHAbN5DUbX8LagZYd6/E5t/IdMi41LbdN1F4g
 iUItasZ71j3gvYV5vUYdhpHGWlGs0m2DNVyqNd4qKbt9Abeyc/zEe7kx8mXJIljZpfk592JoWmR
 tVH+w2CIJGqZuQUs6ro9b12UV2Pps2pRnAVWVlT2it2qt9pCyYVkOvrQwAj2/Ev1VI3GwaWWBvr
 VWV21Vf/PPhWcU4Z66BmzPl4WkQQ56//nP8fJxBI43nQwLJ2VxXiQVc2D9BXbl4dXkR55OBbQaY
 ddzRxlHOhJ2lqFcc8Q/KysQ5ULa7XQ==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68ed01b1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=cttHg1lYd63t9G467PgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SqUPPBK0XKGipTZas_haE22rUGj3HKtm
X-Proofpoint-GUID: SqUPPBK0XKGipTZas_haE22rUGj3HKtm

On 10/13/25 9:38 AM, Jeff Layton wrote:
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 0cb9c4d457453b26db29f08985b056c3f8d59447..e979505a21b69267a10d39f9084b557db4c9369c 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -68,6 +68,16 @@
>  
>  #define RPCDBG_FACILITY	RPCDBG_SVCXPRT
>  
> +/*
> + * For UDP:
> + * 1 for header page
> + * 16 for up to 64kb of payload + 1 in case it's not aligned
> + * 1 for tail page
> + */
> +enum {
> +	SUNRPC_MAX_UDP_SENDPAGES = 1 + 16 + 1 + 1
> +};
> +

Remember last week we found the maximum payload size on UDP was actually
32KB. Should you use RPCSVC_MAXPAYLOAD_UDP instead of a raw integer?

Otherwise, LGTM.


-- 
Chuck Lever

