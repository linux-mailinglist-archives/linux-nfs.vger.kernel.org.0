Return-Path: <linux-nfs+bounces-10736-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE4DA6BBD8
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 14:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F2B464B48
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F293822A4EA;
	Fri, 21 Mar 2025 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TsiZrmgN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sfUmrNgf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6BE216E01
	for <linux-nfs@vger.kernel.org>; Fri, 21 Mar 2025 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564442; cv=fail; b=qDP1xve7CIgnLiuob1InWuD4SI/rircvNDd9TsmAlG1coe9zHfVXPGR7Y4w2bMp4fT5EAhYSSRRgRVHwXhlPXAiaPJtjZDTi4317Uc2y9+xW0mXlQP+ESiv9Q/PjL1+G4Ipj5GSqGQBZ85uiZDzn6Ixh4Hmmtcjr6PMAOxrAwl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564442; c=relaxed/simple;
	bh=9GA6/qqO3TRJfVNifOy3x9d6Kzr+MLN19lYoSEHYAlE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aBLChzl4lf3TLVUV8C/T4n8bsteGFwo65OCZWspwZYcCH3XclD6qLDqlbJk+LkJIi3vyrQXeOW7hv5c47fpWirFq4fdvEDrBcmQPfyX91mnKS6fMRbNkGGSlGhjn/yXwPZYSh6Ui2uXLy36ANsKgoI4arQQqp+zmq34ooAmJkhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TsiZrmgN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sfUmrNgf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L4tqc5028491;
	Fri, 21 Mar 2025 13:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uRI9/sn1DHzGcO4E4QgjEmAEji63ozGf44kU20UaXbE=; b=
	TsiZrmgN+x/EeoZ3Yef8axGOyZiYcNr3fvR7gdQg9q2jOWfpUcwVStTYmSNqAc/r
	H3RbyAAs18rsCGSkbbE8prq4zaX8vNBYM0K+3odJc4lD/rH9zVWLE3D/pXC4o/65
	8PmLxBwPKT5ejPx4sdxw+yToWUncfxez/dxNEs0er20MdsOf2Y+HXiTc9/QfV5tD
	OccVnPLNzRmSQWItWVezY2cyymRC4DSxWpbKKCJR9hDSOrtrh1jMu/nIhAsoWzco
	b6jcmIHGJPskcy1HZlx+WrFW1EfWucwxxQnY5rFkBMCuspOoDedBQ9TV7Q8Eu+8V
	Kpw0Cpu1KiKGqbOqfQtjnw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23s8pps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 13:40:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LC8r5u009615;
	Fri, 21 Mar 2025 13:40:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm43w6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 13:40:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CucHZOjxxjPtIWwo4x1nEg4TRgZHb/Yky9WS0QH7vdt389m6i6kjZmTTvtVCE0BOa8+j2EB/htHaU3iiFY3xcQxVOVvH147CO59i/4rwPOzciLMplsjRF3Mqs3iasTR+4zS1+YMpF2lLd+WX0J8K0isKm5qF22vjmPjWrJwZt3FYdMnjRxJN/KxFU5So33KovqRjNdvnGuHB77crJ3gdNKMJcUoNJ+Xd2wiGid4oSnin+MSy7xPgZ0m5pIxGZyPJpmL82g65DwyhsgCobgfEmrUEqc+Lp350RlZhI776xCSvSca+r3RRejSwYvb4koznuMXqnTXsQ/gTjOmgnyx8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRI9/sn1DHzGcO4E4QgjEmAEji63ozGf44kU20UaXbE=;
 b=p83Q3ggBB2JY8hlUsIPyNcE91ihVj/nCt1Cgq44JvPkc09z9vf2v6uERxXFRghCYy6WGTe822Gz/LY1u8uZlPT4Nzr7CzYm5NdNcrxntG+lGqGUKIMr0ZRuH0h094DXIbNhRkh7pq9GkdJKaRL7WC9OT3Zdk3IT79Qe2yx2tI0FO6Fy00ZNAYQ1MmpXvda3Q5KHczkljl3jgvy8clJKSvW1CaZTGqiq+/eB/oSyY4JVGdrIuy8z/yl7MIOCwHSBZYCv5PQxAPT8HbpkKE+JrPRf4/pwBUVyL6jvgrFgvBko9mMwReOWUqKMcJvCYYd3BO9nYAkUGPJfxuFx6k34WdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRI9/sn1DHzGcO4E4QgjEmAEji63ozGf44kU20UaXbE=;
 b=sfUmrNgfDNuRrB5vq+rSkwz8ZVrUKnBi07g7xKx4h+xMs5ARV9yKfvL6Ncud/W+xRkMulb+n+0FCyDGOGtHLuSG7mjQ+3hVsJMLeThWtMw4Fy4SVPKiTvaVSYPKfqg7as9r+/dAAk2KZ8ey2iiT39y5xSxgppBpAjgvXMqsij9Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7232.namprd10.prod.outlook.com (2603:10b6:208:406::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Fri, 21 Mar
 2025 13:40:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 13:40:24 +0000
Message-ID: <57da1afe-2fc0-4d75-ad6d-8f15c28e5d7a@oracle.com>
Date: Fri, 21 Mar 2025 09:40:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: fix NLM access checking
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org,
        neilb@suse.de, Dai.Ngo@oracle.com, tom@talpey.com, jlayton@kernel.org
References: <20250319214641.27699-1-okorniev@redhat.com>
 <c8262248-2dcc-463e-b76c-7beee2786171@oracle.com>
 <CAN-5tyHgjfGDnaJkKaPFmU4M1WJiGnUh0LRFJ3GT2bvXNMdM_A@mail.gmail.com>
 <801ded98-5661-4e6b-b39f-2b3b7ad0981b@oracle.com>
 <CACSpFtD0T+avEk-gecCZkmEbQ5qKNf=K7mBUKMAYV1e-khV7-A@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CACSpFtD0T+avEk-gecCZkmEbQ5qKNf=K7mBUKMAYV1e-khV7-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:610:118::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 967d9f89-4ac9-4832-e8ff-08dd687dee85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0hObHp5VVNDT1RvdGtiSkpEVEZTd1dlcXVyVm44VlNDa05UOHhaZDl3WlFl?=
 =?utf-8?B?bGU3Tk9tRThGVXd3YkVFams0a2tKTUJtT0QvaHBwMnlEUGVZb0F2Z0ttYVhj?=
 =?utf-8?B?eDluTEZ4eTBLWkd0UzRRTUl1RUNOTzczeUtoZmNiVFdNMkxQbUgxS1ZXTlM2?=
 =?utf-8?B?M0JnWllvcEVyRlp1UXFRSnp5RitYenNOdWtBeElCcUhKUzNqd3ZERHpoalVl?=
 =?utf-8?B?RVJmQVNpRXEyWUJOZUxjV3R4Nnk5VXBUQjVtWW8ySVdzNURYd0Q5YzlPVllG?=
 =?utf-8?B?bmNrWFJoME5DNkpPWGdNU2FpYmRobmdobXFtWElkZmpUK21RWHJDdGxlcDVW?=
 =?utf-8?B?RDQ1cGV5bi8rRElmSkZDc3hzZUt4UlU5Y0JobnRCVVBNR0wvdG5GQjhwMVV0?=
 =?utf-8?B?R21HcGVWTzh2NlNTUGRUdlFaTzhWaE1vckhjcUZBbU5PRW13WklLemwydWY5?=
 =?utf-8?B?U0dHV0p5ZmRZdEsvNkJSV3kyeXpPMFpQSlpVZjhudVJrQVltWmFYSU1uMjVR?=
 =?utf-8?B?YXBrVkdHUUZDQkZONmhMNHFWS2Y4SGJkMExIeU1WV1VVb1pQaFM5b0VQL3cv?=
 =?utf-8?B?SUMraVlkb3g1K3g0QmlZaDcrMHN6b3lYdEdQZzBpbG02UmlpeFlHT1lQbFFR?=
 =?utf-8?B?NWpkLy9CdnkvbjdwVG1xSHp6OU1UTldxZHhlcjRtcVRHeVVhc1pBcGRxZ0s1?=
 =?utf-8?B?RWxVa1IxNU9FY1preVo0Um12enFIa1o3Qy9vNmpOTEh6S2E4MWxZMzBPV2JI?=
 =?utf-8?B?eVNJYmtSVjIwVEp5OHNSSnIySmFSWjZ0cmZGZXVMQk5OdjhUb0wyS3BuZUlB?=
 =?utf-8?B?NFBVRis2ZUFvUTRwdGg2K0V0SlNTaURlZG5RVElkNUlUeG9NYzk0RTl3cWJk?=
 =?utf-8?B?cU80TGdid1I5elJxWmQvMVZrbCtoeUNBd1VOMWk2TElOVG9aMytmVHhGRFgz?=
 =?utf-8?B?WFJYcUFEUlp0Q29JWTVNUS9qNncxVXdZaWJmeXUxNVkvdmlzZUpkNFZLVGdi?=
 =?utf-8?B?ZUVHYjhXV29rOEVLZlMzMDBKOWM3ZmlIYUhhNFhTL09Qb1NCOURyS1gzSHhN?=
 =?utf-8?B?OG5objY5WVBYcWlibUhEeDhZYTIzbXVLcU1hbHNrYnJBcXdaS1JyMXN0R0kw?=
 =?utf-8?B?TzJBaVlFVjJvUDBmanRmY2NidnkyY3VvOExGSWdNemppeElOVStFVU9FZTVP?=
 =?utf-8?B?L3RXWEFCODFUejVxeFluYTdvMDlzM0NnNXo0VVNXOWd1QzBkQkY0RnVYY3hZ?=
 =?utf-8?B?SGp5MzFnMFAxa2ZYWDBuMjY5Q2ZJU0d4K1ZmNXF3SVVQMnRmc2lJWEovNU9H?=
 =?utf-8?B?NUJ0QVllYithQjQraXV1d1lFRnp6RWsrR0xLMEJIOGFkZ2p5ZE84TlZ2MSta?=
 =?utf-8?B?enpkaXdDUFY2NlBGd0lGS0lacDNsUzBZM2FRVkVmQmFXVDh3ci9hZmRzSTR5?=
 =?utf-8?B?b2hXVXNKNFlSeVNjVldSeGhGeHg3T3lML2VaRWlTRUtlRFFtNmZtTTRjaVZJ?=
 =?utf-8?B?VWNZNnRqOFJTbGh6TGRWRUg2eFRWd3M3a0Q0QWw3V0Q4OVB2dkR1akRrNGF2?=
 =?utf-8?B?cDdPbmxCOVRINzRPdlpBNDQyZHY1Y2ZvUzl4SGpuN3paUER6cjNDbTEzOGxK?=
 =?utf-8?B?LzZVaTJlRklmOUlvT0I5N3lIWWIzVkVMRllXMzBlRXRVTkwvYm44OGxSdFJw?=
 =?utf-8?B?cmtSbzFBUEZHZDc2aWxzQXZMZTBmbEJvOUIrZlhhckoyNDg5OEZrbTFtVnBR?=
 =?utf-8?B?NTVWOTZVdzBjTXhQekFLek9JMmdEZE56ejhDRThoVnZNTUhiVDFXYmZuTzYz?=
 =?utf-8?B?cmlBUHFXZDU3UkVoNS9ONm1hdEpqWURXTUd4VUtLejJuaFJYeE15WjFtK0xn?=
 =?utf-8?Q?PXmldwfg1xj7M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2x2Rys3Mi9PVEowdUV5ZWdJU0MxNklRNDNHMlZJZFl5VXlxTlF6OWhxd3p3?=
 =?utf-8?B?bXJ2N1lnZ3k0UzlEeURCY1ZSZEwrd3RhUEZ1KzJHdjdqT2JzVjZoeWVMZS9G?=
 =?utf-8?B?cENGRmtFUEVOckluU3VEbnJIQlkxSnljc1ZHTitSOEVxRVpNaUxOZDVzRWI3?=
 =?utf-8?B?ZTF6LzFINjBhRTlLYWsxNjVkSmZrN3libWtTSTJ1TzVrVUZJWTIrL0FDeFFB?=
 =?utf-8?B?Y3NkM2RWdjY3UE5LTDRaWGFsclA4Tk5mbzN3WEtDL0xwM0RndlE5T2x4dXpX?=
 =?utf-8?B?cUR5RjBWQnJzM3NTdzhxUjVVbkFESFlVT0MzL3E2L3FJdituQUhIaG5vd1hT?=
 =?utf-8?B?ejVmejh0d3d1Ym1Nbjg4bE9MWmo1VEhUZkFGRS92bjdEOGhCR0xxTGpaelFz?=
 =?utf-8?B?MjhYUXROaW96RFM3eFhoWVA4dUVBMDhJd0ZLS0c3dlFTa29IeDd3NitVTUZ4?=
 =?utf-8?B?bVhiNmhzdHVxZU0wZnZqeGZIVFZjTldWdHd6RjBGQUZ6L2diVjV6aTFGd2hw?=
 =?utf-8?B?Tlo2aXl6T3VJVXZaNWpRTWR4SlNoeWxlb2FTOHYwQTZoa04vd0VmN3VVdzZq?=
 =?utf-8?B?UThIWC9XTVNRb2p5V3dJc2NqVXlmME45MzR5aVBwaUZ6d3R6ZG80WlhWemhX?=
 =?utf-8?B?QWVLUmozbjdweDh4OUdoVGplbmkyV0xvYUpqWmJXUFJobWhmVVZZRDBYZHBJ?=
 =?utf-8?B?bllpOFFrMkI5TlNibDJoYklzZkpIZktGcGNrcjBsbHNkbnZPMnhmOThiQmVs?=
 =?utf-8?B?dlFtSWVaUXBNaHZvMnhucTZsTU1FVFIwMlc0eG80NzRUQ1RYYjR4ZW93VUFa?=
 =?utf-8?B?Sm1waHlaRXFSVWp5NHNqcE9tUUNiWmNlY3QzZWkvQ0ROVkdSbEhoNXJtemJS?=
 =?utf-8?B?T2R1dlFTemJqME5UZVhibDRibEhXb0RnUUVFQithNEpGZXpYWEI3L01heWpE?=
 =?utf-8?B?WUxORzZNME50MksxM3dTell1dmNVYjFPYVd4bUtCNHh5cHVxUHdEbGFzekI1?=
 =?utf-8?B?dGFVSUZ6WmNhdWRCU2d3amtWOHpuTHdxL2ZQVzM0UW9FRm1EY3BTdS9Iek54?=
 =?utf-8?B?dGV4a29iVnJWdnNUQ1V5WTUwRWlHcEpzWjVOTm9RRUhTdmRwWVJsZWQyMDc3?=
 =?utf-8?B?Uno4OUl5aHkwMTJvNjU5bTJIYzcxVHVQNnNGdjR5Q0paUCsrTm1meVA3anBH?=
 =?utf-8?B?N0VDbTUxNzBFRmFRUnlRTXpHa2pSbkJ3WXlJVWdWUm56S2J0TnpTVkJrZmNR?=
 =?utf-8?B?VFJWVkJVOHFDZktZTXJpZkh1aUNrME9yU2Uyd1Z0bVF6Ull0b25LUXdFRXdw?=
 =?utf-8?B?dmlzaEFkeks2azgzbUwxVGtIZ3NRL005R1FlclpzSmFqdHNod0tuWEhxL0Ru?=
 =?utf-8?B?MDVReDZnTWp4aElCSVpSTHlHRHNwQUNWMUpTSEFueVc1WVdmMjNsSTR1WGFR?=
 =?utf-8?B?SkVJQWpJTjRDTHNud2g0VUNzRFNoQnNja0o4S3JFZklrdWpqTEREblU0WGZk?=
 =?utf-8?B?c090SUlldWxRMGV2cDJCbkIwVXIwd2RwSHpXRFNVS0RjM3VHTlYrRFJLOWMy?=
 =?utf-8?B?RDM1ZmQrdlFVYUdoSDZrSHRJaUNsNEZkTFFoSDNxVE5rYUYwY0lrdEEwbGtY?=
 =?utf-8?B?ZUdDYldBUmIrdDJ2akFoZjlHenErSkh5aFNLa1JrYzFWY3RxZFpoYU94UHd3?=
 =?utf-8?B?WVF2a0RHaHlhN3hNdGtpQ0lKajdEcENFYzE5R2hVL3l6eC9MS3M0QXJ0alNZ?=
 =?utf-8?B?SjJhNTRPZmZsTGdibkFXaHRGOUdmYUZ4cUxCWWJ2UmxmQ2p6bkRBSVBPWUVn?=
 =?utf-8?B?VmUxUXQ2NTlsYURsTkJXc2VwSlBLUUkxcjdWR1pWTXZSWlJkSC9Ceit5LzF6?=
 =?utf-8?B?cFd0TUp3Vktoc2ViMmRlN0E0WGozd3dDdGlsNzlqMFVsYmF4cUZhTFd2ZG5k?=
 =?utf-8?B?d0RxRGdPa2hra1FFdWxuVFVTNEcvUnF5L1h1b2ZlWkVaSzNZU0x1V2JBT01s?=
 =?utf-8?B?OVRKeUwybHB5N05iY3VNbUVKT3Joblp1K3pWTUhvUlJVVTNVTHRpNytmbVNC?=
 =?utf-8?B?Z0xsblllNjY0Y2xGTUVNSjNkVThDTG45eVFkZ3k4WHZCSktzeE0vVCtxRWly?=
 =?utf-8?Q?6hkOeGTGD628kSkl8lL2w8MYZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/VDNs3hu9w6ZALC6io0LbDkS2KNfxb+VHJxUNSkGW0Fjad+p0tlyHAJ1YfzfO0jBIWgbDH2uUhICwpxYSHwbZTBAdtYVr5tU+Dz+WHarFoAY0FFT/jSzKs72SjFxunGBd3r23GAdGvV29CtTrLQBLeXikQO470woczidlbNfP7oypkAwCcu+Dz0nsMnkg/7WaRuFgbiuFWE22TGL7ZHI0VVXpOKpYES1LPC15ulWQ8SQCsw4OfLQcxFjxNpfFp4E0bJm5qeURxhMZxadTgayNbikyl0Q5cLa5wV1MqyA65zYM9SWNB668UlQduUch5FNrtw0jdvs4fI5jsPJcutPQsfDI1b1RGU08hZDqefAv96Lbftu1I1VfZUgYRReXSqTl0YDcduXuKhzRwDD19iMwKUw6MXkUH8pIXkgBOGFwUTjVjJpbLBXTuUTYMDJEnsjQ2WIA1/NWhjXaAiTBl1/3/6RsEIqrP+s0Q8eMYnxHXUJkzVnrFNnF0ZcUZZhCvaj69JJzKudkBiPGHu2HWPp2XU7PRf0I9T0EhaVGz1YGHLOdlmq1gnrwdraFP9oYbdSUQcjQwqUxq8u4cIt8wL2cEYrt47YYuQWhjeWZ3e5tcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967d9f89-4ac9-4832-e8ff-08dd687dee85
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:40:24.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1p76DFp6LbaJ6y6MlxhgUNqYSYivGFDeAlXjsisRnCe/4Om3q6l3DlVld64w2WKAFcEjqXtDeQyzyBxATciPaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210101
X-Proofpoint-GUID: MzNtJRWxiwBf_t7jFd1fqmaOCjzYyHnK
X-Proofpoint-ORIG-GUID: MzNtJRWxiwBf_t7jFd1fqmaOCjzYyHnK

On 3/20/25 4:46 PM, Olga Kornievskaia wrote:
> On Thu, Mar 20, 2025 at 1:32 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 3/20/25 12:29 PM, Olga Kornievskaia wrote:
>>> On Thu, Mar 20, 2025 at 9:58 AM Chuck Lever <chuck.lever@oracle.com> wrote:

>>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>>> index 4021b047eb18..95d973136079 100644
>>>>> --- a/fs/nfsd/vfs.c
>>>>> +++ b/fs/nfsd/vfs.c
>>>>> @@ -2600,6 +2600,10 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
>>>>
>>>> More context shows there is an NFSD_MAY_OWNER_OVERRIDE check just
>>>> before the new logic added by this patch:
>>>>
>>>>         if ((acc & NFSD_MAY_OWNER_OVERRIDE) &&
>>>>
>>>>>           uid_eq(inode->i_uid, current_fsuid()))
>>>>>               return 0;
>>>>>
>>>>> +     /* If this is NLM, require read or ownership permissions */
>>>>> +     if (acc & NFSD_MAY_NLM)
>>>>> +             acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
>>>>> +
>>>>
>>>> So I'm wondering if this new test needs to come /before/ the existing
>>>> MAY_OWNER_OVERRIDE check here? If not, the comment you add here might
>>>> explain why it is correct to place the new logic afterwards.
>>>
>>> Why would you think this check should go before?
>>
>> Because this code is confusing.
>>
>> So, for NLM, MAY_OWNER_OVERRIDE is already set for the uid_eq check.
>> The order of the new code is not consequential. But it still catches
>> the eye.
> 
> I just re-checked the original code and the re(set)ing of acc was done
> before the MAY_OWNER_OVERRIDE check. So changing my patch as you
> suggest would be consistent with how things worked before. I will do
> that.
> 
>>> NFS_MAY_OWNER_OVERRIDE is actually already set by nlm_fopen() when it
>>> arrives in check_nfsd_access() .
>>
>> This code is /clearing/ the other flags too. That's a little subtle.
>>
>> The new comment should explain why only these two flags are needed for
>> the subsequent code.
> 
> inode_permission() only care about READ, WRITE (EXEC)? NFSD_MAY_READ
> is supposed to be the same as MAY_READ etc. Thus I believe passing
> other values is of no consequence so to be honest I don't understand
> why NFSD_MAY_OWNER_OVERRIDE is needed here. But what is of consequence
> is (not) passing a NFSD_MAY_WRITE (which is what gets passed in by
> nlm_fopen()).
> 
>> That is, explain not only why NFSD_MAY_READ is
>> getting set, but also why NFSD_MAY_NLM and NFSD_MAY_BYPASS_GSS are
>> getting cleared.
>>
>> Or, if clearing those flags was unintentional, make the code read:
>>
>>         acc |= NFSD_MAY_READ;
>>
>> I don't understand this code well enough to figure out why nlm_fopen()
>> shouldn't just set NFSD_MAY_READ. Therefore: better code comment needed.
> 
> My comment came from the comment that was removed by commit
> 4cc9b9f2bf4df. I don't have a good understanding of the code to
> provide a "better" comment.
> 
> nlm_fopen assigns the access based on the requested lock type. an
> exclusive lock i'm assuming gets translated to the "write" =
> NFSD_MAY_WRITE. But the the user might not have write access to the
> file but still be allowed to request an exclusive lock on it, right?

Agreed.


> @@ -2531,16 +2531,6 @@ nfsd_permission(struct svc_cred *cred, struct
> svc_export *exp,
>         if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
>                 return nfserr_perm;
> 
> -       if (acc & NFSD_MAY_LOCK) {
> -               /* If we cannot rely on authentication in NLM requests,
> -                * just allow locks, otherwise require read permission, or
> -                * ownership
> -                */
> -               if (exp->ex_flags & NFSEXP_NOAUTHNLM)
> -                       return 0;
> -               else
> -                       acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> -       }
>         /*
>          * The file owner always gets access permission for accesses that
>          * would normally be checked at open time. This is to make

The original comment isn't significantly more illuminating, true.

This seems clearer to me, but folks who know this code better might
feel it is a bit obvious:

	/*
	 * For the purpose of permission checking NLM requests,
	 * the locker must have READ access or own the file.
	 */


>>> Prior to the 4cc9b9f2bf4df inode_permission() would get NFSD_MAY_READ
>>> | NFSD_MAY_OWNER_OVERRIDE in access argument. After, it gets
>>> NFSD_MAY_WRITE | NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE |
>>> NFSD_MAY_BYPASS_GSS. It made inode_permission() fail the call. Isn't
>>> NLM asking for write permissions on the file for locking?
>>>
>>> My attempt was to return the code to previous functionality which
>>> worked (and was only explicitly asking for read permissions on the
>>> file).
>>
>> So the patch is reverting part of 4cc9b9f2bf4df; perhaps that should be
>> called out in the patch description (up to you). However, the proposed
>> fix doesn't make this code easier to understand, and that's probably my
>> main quibble.
>>
>>
>>> Unless you think more is needed here: I would resubmit with 3 patches
>>> for each of the chunks and corresponding problems.
>>
>> Agreed, and I don't think I have any substantial change requests for the
>> first two fixes.
>>
>>
>>>>>       /* This assumes  NFSD_MAY_{READ,WRITE,EXEC} == MAY_{READ,WRITE,EXEC} */
>>>>>       err = inode_permission(&nop_mnt_idmap, inode,
>>>>>                              acc & (MAY_READ | MAY_WRITE | MAY_EXEC));
>>>>
>>>>
>>>> --
>>>> Chuck Lever
>>>>
>>
>>
>> --
>> Chuck Lever
>>
> 


-- 
Chuck Lever

