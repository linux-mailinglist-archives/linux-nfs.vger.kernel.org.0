Return-Path: <linux-nfs+bounces-11066-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92706A829CA
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 17:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEF34E5C50
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B36266B60;
	Wed,  9 Apr 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HQylQLfX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M5/etR/A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA43266F00;
	Wed,  9 Apr 2025 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211389; cv=fail; b=btcGt7DxZszhmc30+hZgnEDtd/WMme3poSfJeyGEkJNiO0xbVXzEieNys+9/I4V9r94DwIsQvqB2CUeMvmfqlFzDBxQ+TPSruvV/cU7AQ4ptrSm+Hjdb5EETF+dO3iah+i9NyeD0dUJF6Sys2Dx+hkEoOyHQQMA5atsUuI83mXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211389; c=relaxed/simple;
	bh=6iUFOEL0amqZ4DkvIlXmlM8wDkgkvLVeu/VVyu8AF7M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=COZRULn6zfIiw3PQIOIB45tzdts0HN0nV6YuX6I7WL/toZqqRTnGLZxuvgYhI61MCuTNnJikErExNYWCLkdRKk+cAWE5ggMaf+iqLbtqaDRz1YRPtw82887P3+byCDfNZLHRz50QHjj87UjnZIyKdlOjjGMx26cS2MNhfd8rcfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HQylQLfX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M5/etR/A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539EpSZ3000470;
	Wed, 9 Apr 2025 15:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ifv3YnZ8ti6PlhC+Vy1mMInsBZpbtTzsbg0MvJkfXho=; b=
	HQylQLfXa4WxCRBqn8l3pplY6+lA0F0Q2Iw1bpB62MQDPPthrttJtj2P02ZITPzY
	YTtyBdKVBNit17QYcPdUP9vXFIOgwvixFn7q8ZOza1Bjnj6C3JkE/kpvhHv7AKPx
	sl0M94Vw1vvB/6BMOmEY9pVZtM/0wfQN3jCdEkkIeXXNw+bYIQqVoERrd0tR+HAF
	Z90WK+2OlJ8/hLbve6wsbSsBO4FEImD28WpF7UXIHJ7dFYz4XWRrS/jW7z3smin/
	EfiBrM6e7sA4midsyPocv2x2fL46QIEbFLP+ztuWqMzGpLFrjXdWbDAGGRsgo/4K
	FhbDPHNxo8OZZPvcYcG1wg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvd9yaqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:09:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539EikxF020955;
	Wed, 9 Apr 2025 15:09:36 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010001.outbound.protection.outlook.com [40.93.6.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyh8m5b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FujGmGVOLqGCY4RSg+KJxsVBgL58vHZzFDGh64ySetGDc0GZPbCD3y3mK5Vo2/buCTAut3sxZWdOTfK/AQ7VdRYRcAf14gwCOCrTiH65W1qhHZB5ynB4OR/LCwQKz6ao3iP7aQwsuOgoQFRVUlPpYQ6mJk06Oezk+Nizul3rDnq+iwYhMBZPPGg9NrqVhiEjkqLXDexFVMVGO4ZgVN+/4bhtYEgqq39rE09ZVA+1++P8piKaw9c2A3zTTwPHc9ktiRHZvKcUSHkrqLqAF6UXIykTho1UEVVJtIzz9uNLOoWrolaaEoLBq9rMUBH2xWlQvFpfjdaBho5qQN0LUD1BDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifv3YnZ8ti6PlhC+Vy1mMInsBZpbtTzsbg0MvJkfXho=;
 b=cM9h7o7Uv0ClyWedgCDSSqit2aXb8FbbNM8t/To2dmXBz8v0Avq16d3d+HvtjK3mt2473mDI+arMYLGsknzc/avRIWGMFUwTcM/EnMT6R4GiyiXAo/bj4t8zi/FRR5556yjqc9jRDemif9knYOvZUaRa9c3US3nYrkePbMbAO/8wXxmFKZwPjYI6WIQcsCgb8sUwKIsgB1cobGz89GiKE0kkwqwq/ame46i6mzhQgM7XJB438mgHpY0V7PX1G9YIzRsmxqMq/NesVamD9vuetgXdrlYD0DGfmIu3j+QJkYsO+PUSgNBro5zkuun3E7wUiktXc2et9MOCZclo+2chqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifv3YnZ8ti6PlhC+Vy1mMInsBZpbtTzsbg0MvJkfXho=;
 b=M5/etR/AAB7GqAxs19MTnu82TiKKc10FXWDmFoS6cZDHXctSoQxErP9zsWcfQW0s1ZSMQ02lQKa5XT4XVzt9oH8NylVe8NPT3ngLjrG9mE6OfegTf6SOVvM5piXWcrGN0poJQQC//zDhg/29GfecfW4BfCzk1PcEbgAsFXmWmTE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6726.namprd10.prod.outlook.com (2603:10b6:8:139::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 15:09:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 15:09:32 +0000
Message-ID: <078a639b-1f19-48e2-a0cc-f861b67f34c9@oracle.com>
Date: Wed, 9 Apr 2025 11:09:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] nfsd: add tracepoints around nfsd_create events
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
 <20250409-nfsd-tracepoints-v2-6-cf4e084fdd9c@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250409-nfsd-tracepoints-v2-6-cf4e084fdd9c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bf88a5-e462-4c73-e8b9-08dd7778880e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eEp4VGNSNEhiL0FraHEyMkJhRnlkN0pVYnExSnZEemxtNytOQmZHSzJiM0FO?=
 =?utf-8?B?bU1IbDlQanJHSlNGSTRFd01iWGNRT21EYytiWVJsTGplWVZSZWFmeC9IbEJB?=
 =?utf-8?B?Y2lBcmJhbndoZ3BLRklQZDdLNVZBTDdISnNFam9EcmlkSDJOL2J0RXJWY2VZ?=
 =?utf-8?B?eXpZWG5xb082dDlLcEVHUkhUaU1XVVJOZG5BalJwckRZd1Q1empyVU90eFRa?=
 =?utf-8?B?b0c5Y3dVZkc3TWdUV0c5ZzB5NlQzL2p0RkdrV20yTVBSSlVQdSs4QXorMHFM?=
 =?utf-8?B?bFIrM0xGbWZ3OGF4UUNKVGZZTmhEZ2FzbXA0bUlpbzdRSXpFN245aFhIbFFC?=
 =?utf-8?B?UmExa3p0VzRXWDFtV0g3NWVjL0piaFZPYmVXajVGTTFreUJoNjR6aWhyNE9r?=
 =?utf-8?B?cGs1Um1OTXdyUUpJYVJTVElyRExEQklyZDNCMGk1RTdHTkFZZ3RhMlNXTk5m?=
 =?utf-8?B?b09rSlAzMmozQ283MktNa0ZjWGQ3MGZ0MjRYZ0g2bjJVVUIrcU1HTmV4MnZP?=
 =?utf-8?B?SzUyTjFRc2RBQWl5NlNjcnZMUzZjc2QzVVlzUm9iR2s2T3ZEWnlNV044VEcr?=
 =?utf-8?B?ZVM2VXNodmwraW90MklLWXVaQ1ZnWTJmZ1F2U3RUazBTTGRjVTh2SDcrdFda?=
 =?utf-8?B?YVVtTkZhUXNYYkNRczZvN2pUaEhMbkdTQm9XUUFlakQ4eXV5MmNwNFhseDRa?=
 =?utf-8?B?cGM0anpVWU91RWJiNGFJdWVyaStrYXJyVktjRmpRQ1NHUXdyVllMbUJkQzQw?=
 =?utf-8?B?UlY0K0xyUjcvQXQ5WDJKYnRVQzhoR1pYWGlPaURFRSt2OU9nd3RFZG5zamhO?=
 =?utf-8?B?L003SkgwU2NONFNiaFJMNTZabzlRanlXbFdYVlVvdS9Rek44eFRVQXNybURt?=
 =?utf-8?B?Q0F0bmNTZng4L0N0a201MXAxanpkZEpUMjdTT3p2azhFeEl3cHlWU0xhRFl2?=
 =?utf-8?B?cm5vWnVPNEF4L29SckhIazcyTFFTRmhkeTZ0RW1YbVhlV3lTM3RjRzFGVlBm?=
 =?utf-8?B?V0FyZWdsdFRHcFhVd0Nabk8zRFhWUVNZOWpaMjhyOThTU3dhN0pVeTFQRlpG?=
 =?utf-8?B?RmVLQlZQN081enBQSmlxSTVpRW8xZlVaVXgyNU9mWTFBQTVpeS9kdWZra3VB?=
 =?utf-8?B?TlM3NUcrM0ppaFpzRTArVzV6eG5ramV5a2l2SUliQW5mMG9iMEwyV1lTMGky?=
 =?utf-8?B?SVQxbXJMektOMHIzQzlJTndmWDlKeklIRWpPaUQ0K3FidzUwYS81U1NZNkhW?=
 =?utf-8?B?NkVxM2w0bElDYkRUWE9XYjVaTG9xR0dvN2E2aUhUbVNvYzlsU2o3REJxSVZF?=
 =?utf-8?B?bktoV1FhZUJhM3RlQkd4YWVTL2VMQ1FPMTY5VjNRQXZEUnMvVjR3RTdDSjhL?=
 =?utf-8?B?Q1R4L014a1ZKU3VOTUxER0VtYnU5dHAzNGw4M0lNQUFSZFZLMDNSRllxWURv?=
 =?utf-8?B?eW9wWGFJYVVOWUFaL0ZsY3RjSW0zcHI3L0NsYlMrRjJROUZGSHFQMVRjZGtH?=
 =?utf-8?B?cjNCTUJZQmthbnBTcUZVOG9qdDg5TmZQeFB5NzM0YVBzUWNRNURkdzZrUUZP?=
 =?utf-8?B?WDlLcnNDRVM2U0NzT204U2VzWkw1K09QM0lHdGFLUmlvUXRvUDgyRjloQmdr?=
 =?utf-8?B?RGlTZUhoSTBHaU5Lb2pnTWRRdXNpaUs0MTRXWW5EeUJFT05DdE4vRzFVb2hS?=
 =?utf-8?B?K1luTGtQN0w1V2NvWU5SeUZMZWFlYW42Snp6bTFwSS9NWEhJUXpMWVhMVE1V?=
 =?utf-8?B?R3c0dktjbUUzR3FUSEppYldsVTlmdjhOQWhBTHlrSkl3WU9SLzlFbmIxY0tF?=
 =?utf-8?B?ZmorTGtUQ2xqdU1zeWRoMTNSWEh2TWRPZFdNR0pQNFoxbkxHWFpSdk5pVEtD?=
 =?utf-8?Q?SjZtCVEZ5loP/?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Ym1KNnRwNWRES0dERjYwY2I2WHNTSFZZOWE4VlNidVJUSUlzbUhtd1JTbzRU?=
 =?utf-8?B?b3R1V2hWWVdUOElZQ05Ob1NJeWV1bFE0di83Q2w0bTVEQ1YxbVMrZG9LR1d5?=
 =?utf-8?B?ckx3RVhTdUxHVXBEMnVhUkRYM2liUHVSMEpPWFp3czJwMVNac0FDQStscEhJ?=
 =?utf-8?B?RENGUE1lL0FyVTVFUmRkOFdlYzd4NWpQUWdyR0NGdXNVWld4NVBEWUplZ21v?=
 =?utf-8?B?WmZYNlMvQzI3YTd5NXJMdTVvZkNtVHQ4S2FldXVrN3QwVUlmcERZWVJzRU5J?=
 =?utf-8?B?K01tYy96ZnU2QkZzM2VZYnBnMUtvd0JwN2dHak5yVHFMZWwvWHlLZTRYMU9W?=
 =?utf-8?B?WUNlTGFNbUdGMnlZTmRWbC8wZGpwQldTVkVlYUloUTVZcjNsWjRpM0tOY2lC?=
 =?utf-8?B?dHUwT291Slk4RERBQnZRUkhiRkY4eVYyMGJJSEZiaUhhbDRLa1Y2WEF6R0JW?=
 =?utf-8?B?dmJjZEprRXY2WnA0V2xYazlITVFPcHUxYWxBN2RHM0xMZFhRcFF4czAzZnlT?=
 =?utf-8?B?QTFIclJNVGpPbnNNaWNvRlVZN1cvTTJnS0dUelJvWW01bjR4UHFPZGx0c3d3?=
 =?utf-8?B?NzA5a0lUbzdPaWtIRkJRREYxdFFlQTdYYWpCclhtSEk3S2huS1Z3cnBxSm1E?=
 =?utf-8?B?Vk1yVHRNdnJZbXRVNjV3Y1FkQTBtaDJCWTh0VVk3bzNQa0FRQUl1V0ZveWVB?=
 =?utf-8?B?eTNxdU9Za0FHMmd6YmFiT2VMSkN2b24rbEE1YzBzL3VUSlF6TEkvTHlzQjBa?=
 =?utf-8?B?VUU4SlFrcjhmQ3RZcld5VU8zSDhCdUFQbzM0eXZSV0crSkVkNzN6Y1lFRVdK?=
 =?utf-8?B?WS9iVWVtaDByRHlHWjk0R1lPODhoYXF5b3liL2N4WVBHM29kRkNLa0dDSThD?=
 =?utf-8?B?VldOVFBnZUc4MzJxUXQ2dk8rQnYyaGphamludEt4TE1Rc2lWZXdldEhsbFlH?=
 =?utf-8?B?REZlZ1h2TFY3Q01QWWhtb0REeHZMcnBCMmgvYzZqRDBnY3NlTzV6dytQdGlh?=
 =?utf-8?B?NFdXeEZ2dkZBMmdpSWVhNHI4am0zWTFCV1pJQzFvd1ZxRlI0c1p2b0grdUV2?=
 =?utf-8?B?QmFkMUNRN3RhSHB0cVkxZlpCMi9qOFlGTE1JYW4yRUF6MU9GcFQ1MkpMSjFE?=
 =?utf-8?B?NEhyV09VcW1sRG1KZTlvMWlRdkJCdURicG50b0wzODQvYXpXZjRsRk5kYk93?=
 =?utf-8?B?blBEYTFTbnRPejdyMzMxbFhNVmJ2QTc3cnhrTVJnekNNSHRzZGppQWdvdVRl?=
 =?utf-8?B?dkRabVZCbFVUelp4VW5ZbXFuNWJlSHJGMFpObEZSbXg1MjlqR1IzQktldlJW?=
 =?utf-8?B?QTBRdGlRZDJkOUVmQkl4dkRjY3dxbWVOZFB4TndKZzhxVDVING9haXVpS1Rp?=
 =?utf-8?B?dmZralhKOGJNQlRrV2pySDMvcmYzQmtHdUs0ZE96Y3paQ0xzRktCYlk0aVY4?=
 =?utf-8?B?UGxweVFhQkJyTHIxSU5PNXdnSU9hdUhPdFE2Y2ZMOS9sUjA0bDRUUG1GN203?=
 =?utf-8?B?bUJtbVpiSlBXdjJrQm1MbVhyY28vYzFqTksvaG4yblFPVS9vNlFxWXZlS0NH?=
 =?utf-8?B?SmZtN2xTajZNWkY1YXQxaDlrSlZsYWJGZlgrbjZTUVJtdk0veTJCUEd6OW5T?=
 =?utf-8?B?VkdvUTVYNERoOWpZZ3RMN012UE0wMGVUUVpBMkN4eFZ1VTlERkhvU2ZJU1N4?=
 =?utf-8?B?bDA4Y2l2SmJrUEJYNzQ0NGthZ2xuNW51K3pUNFhwYy9JYXJZa3Raa2JsZUMr?=
 =?utf-8?B?RkY1dkxlVklVRzRualpYdW5xdVdzdVh5N3Z5QVRMaVRVdEJLc2dvczlkcFlE?=
 =?utf-8?B?RWJqenFQV0R2VUZQQWphZHNYL0ZnUHNXYlZhUnVIYytQTTlQUWZaSk1vWjRW?=
 =?utf-8?B?R0w4bFZyd2kxL3ZvQ0NFSHNPN1dXaVdnN1d2amJRbTFJN3J4VTh2OWxjcDdP?=
 =?utf-8?B?VUlQVlRjRnZoMmJZcjBLYysxMGx5MDlkVnVaYlBSWlkxOXdTOUxUaHdlb0hT?=
 =?utf-8?B?WS9GTGhNa01EME83NkdxS01aa0pvUVMzL3RQd3dhSFRDWVlvdXlrd3Y5aUJk?=
 =?utf-8?B?L1ZWaTlCOUtac3hSSVFJbko1aE0yeDhieFMxN0oyL0JiK2xrN3NJSnJNNGFW?=
 =?utf-8?B?UzFsOTBWb2JtOWFCUlovM3J2eHZNRGpDUGJ5VXVwSEU1bVNLV2psazR5alZY?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	51MzSJiZvddq8+q0muM7vFIMrI7DfOpJMv3RyWgxMibDi+PmYnxvMXcK63Vzxa0mdFAhazqQWxPtpXSV8v08lpH5lZngs/wqzmYWM+A/KXV6SRZWsmGjEY6Qdx18E4HdKEyUOXBwY4dpaH0vXuIHnhv8W1+AM6JJ8z/bkC3TuQXmw+SXsTVZXhqjUYz48J8+sRiStRHHScjw+FiTOEsnwE3Y29nHUQ0p1FqmOBSev+Rr5+e5uFG+oie2vmplBVKlqv0hjFjZhCp24kWnp1/lb1092t96OcxDG1Kyyo/Wagnsfv1wXl2wMjqF2Uw6jPtDNj4ZkKUJ04fnZc+5IykeNUIFHy0otOvNDK1g66XKmbZj23QH0W9FbDuEJK3EMLZeeV3m2b3y/0mDn8ZS9NPjeyyQDDappIQZiO9UZWGw/eUrJYeqKRUW2PYmvfRfbsAagryWIe01VPpD5tvR1uCqL2Ax77p0VyeG0CM0u/8yw41tqsNlTTxnhR1aC4prWqHkW3iQIDj3Voz0LfghPmcdTREr509u4pbor38mSsVxMOkAiq0pVOd9TVOFQhrpFrY96AM6nYGwGGghfRr1hAw+twxr7zlerVVyqhBItp90Peo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bf88a5-e462-4c73-e8b9-08dd7778880e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:09:32.1354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTzl3+nP1U5MwNG71xQJY7ZrX8rhOtu57xSP4NMJEWrkvetHtBEaKbux7J0aFT3/8WEreiCMy+taq67unco4kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090096
X-Proofpoint-ORIG-GUID: Q51UXvqcBCjTBJ7_RohGh_48BJJmqIBy
X-Proofpoint-GUID: Q51UXvqcBCjTBJ7_RohGh_48BJJmqIBy

On 4/9/25 10:32 AM, Jeff Layton wrote:
> ...and remove the legacy dprintks.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs3proc.c | 18 +++++-------------
>  fs/nfsd/nfs4proc.c | 29 +++++++++++++++++++++++++++++
>  fs/nfsd/nfsproc.c  |  6 +++---
>  fs/nfsd/trace.h    | 39 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 76 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 372bdcf5e07a5c835da240ecebb02e3576eb2ca6..ea1280970ea11b2a82f0de88ad0422eef7063d6d 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -14,6 +14,7 @@
>  #include "xdr3.h"
>  #include "vfs.h"
>  #include "filecache.h"
> +#include "trace.h"
>  
>  #define NFSDDBG_FACILITY		NFSDDBG_PROC
>  
> @@ -380,10 +381,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
>  	struct nfsd3_diropres *resp = rqstp->rq_resp;
>  	svc_fh *dirfhp, *newfhp;
>  
> -	dprintk("nfsd: CREATE(3)   %s %.*s\n",
> -				SVCFH_fmt(&argp->fh),
> -				argp->len,
> -				argp->name);
> +	trace_nfsd3_proc_create(rqstp, &argp->fh, S_IFREG, argp->name, argp->len);
>  
>  	dirfhp = fh_copy(&resp->dirfh, &argp->fh);
>  	newfhp = fh_init(&resp->fh, NFS3_FHSIZE);
> @@ -405,10 +403,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
>  		.na_iattr	= &argp->attrs,
>  	};
>  
> -	dprintk("nfsd: MKDIR(3)    %s %.*s\n",
> -				SVCFH_fmt(&argp->fh),
> -				argp->len,
> -				argp->name);
> +	trace_nfsd3_proc_mkdir(rqstp, &argp->fh, S_IFDIR, argp->name, argp->len);
>  
>  	argp->attrs.ia_valid &= ~ATTR_SIZE;
>  	fh_copy(&resp->dirfh, &argp->fh);
> @@ -471,13 +466,10 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
>  	struct nfsd_attrs attrs = {
>  		.na_iattr	= &argp->attrs,
>  	};
> -	int type;
> +	int type = nfs3_ftypes[argp->ftype];
>  	dev_t	rdev = 0;
>  
> -	dprintk("nfsd: MKNOD(3)    %s %.*s\n",
> -				SVCFH_fmt(&argp->fh),
> -				argp->len,
> -				argp->name);
> +	trace_nfsd3_proc_mknod(rqstp, &argp->fh, type, argp->name, argp->len);
>  
>  	fh_copy(&resp->dirfh, &argp->fh);
>  	fh_init(&resp->fh, NFS3_FHSIZE);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 6e23d6103010197c0316b07c189fe12ec3033812..2c795103deaa4044596bd07d90db788169a32a0c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -250,6 +250,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	__be32 status;
>  	int host_err;
>  
> +	trace_nfsd4_create_file(rqstp, fhp, S_IFREG, open->op_fname, open->op_fnamelen);
> +
>  	if (isdotent(open->op_fname, open->op_fnamelen))
>  		return nfserr_exist;
>  	if (!(iap->ia_valid & ATTR_MODE))
> @@ -807,6 +809,29 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	return status;
>  }
>  
> +static umode_t nfs_type_to_vfs_type(enum nfs_ftype4 nfstype)
> +{
> +	switch (nfstype) {
> +	case NF4REG:
> +		return S_IFREG;
> +	case NF4DIR:
> +		return S_IFDIR;
> +	case NF4BLK:
> +		return S_IFBLK;
> +	case NF4CHR:
> +		return S_IFCHR;
> +	case NF4LNK:
> +		return S_IFLNK;
> +	case NF4SOCK:
> +		return S_IFSOCK;
> +	case NF4FIFO:
> +		return S_IFIFO;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +

Wondering what happens when trace points are disabled in the kernel
build. Maybe this helper belongs in fs/nfsd/trace.h instead as a
macro wrapper for __print_symbolic(). But see below.


>  static __be32
>  nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	     union nfsd4_op_u *u)
> @@ -822,6 +847,10 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	__be32 status;
>  	dev_t rdev;
>  
> +	trace_nfsd4_create(rqstp, &cstate->current_fh,
> +			   nfs_type_to_vfs_type(create->cr_type),
> +			   create->cr_name, create->cr_namelen);
> +
>  	fh_init(&resfh, NFS4_FHSIZE);
>  
>  	status = fh_verify(rqstp, &cstate->current_fh, S_IFDIR, NFSD_MAY_NOP);
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 6dda081eb24c00b834ab0965c3a35a12115bceb7..33d8cbf8785588d38d4ec5efd769c1d1d06c6a91 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -10,6 +10,7 @@
>  #include "cache.h"
>  #include "xdr.h"
>  #include "vfs.h"
> +#include "trace.h"
>  
>  #define NFSDDBG_FACILITY		NFSDDBG_PROC
>  
> @@ -292,8 +293,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  	int		hosterr;
>  	dev_t		rdev = 0, wanted = new_decode_dev(attr->ia_size);
>  
> -	dprintk("nfsd: CREATE   %s %.*s\n",
> -		SVCFH_fmt(dirfhp), argp->len, argp->name);
> +	trace_nfsd_proc_create(rqstp, dirfhp, S_IFREG, argp->name, argp->len);
>  
>  	/* First verify the parent file handle */
>  	resp->status = fh_verify(rqstp, dirfhp, S_IFDIR, NFSD_MAY_EXEC);
> @@ -548,7 +548,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
>  		.na_iattr	= &argp->attrs,
>  	};
>  
> -	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
> +	trace_nfsd_proc_mkdir(rqstp, &argp->fh, S_IFDIR, argp->name, argp->len);
>  
>  	if (resp->fh.fh_dentry) {
>  		printk(KERN_WARNING
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 382849d7c321d6ded8213890c2e7075770aa716c..c6aff23a845f06c87e701d57ec577c2c5c5a743c 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -2391,6 +2391,45 @@ TRACE_EVENT(nfsd_lookup_dentry,
>  	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s",
>  		  __entry->xid, __entry->fh_hash, __get_str(name))
>  );
> +
> +DECLARE_EVENT_CLASS(nfsd_vfs_create_class,
> +	TP_PROTO(struct svc_rqst *rqstp,
> +		 struct svc_fh *fhp,
> +		 umode_t type,
> +		 const char *name,
> +		 unsigned int len),
> +	TP_ARGS(rqstp, fhp, type, name, len),
> +	TP_STRUCT__entry(
> +		SVC_RQST_ENDPOINT_FIELDS(rqstp)
> +		__field(u32, fh_hash)
> +		__field(umode_t, type)
> +		__string_len(name, name, len)
> +	),
> +	TP_fast_assign(
> +		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
> +		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
> +		__entry->type = type;
> +		__assign_str(name);
> +	),
> +	TP_printk("xid=0x%08x fh_hash=0x%08x type=%s name=%s",
> +		  __entry->xid, __entry->fh_hash,
> +		  show_fs_file_type(__entry->type), __get_str(name))
> +);
> +
> +#define DEFINE_NFSD_VFS_CREATE_EVENT(__name)						\
> +	DEFINE_EVENT(nfsd_vfs_create_class, __name,					\
> +		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp,		\
> +			      umode_t type, const char *name, unsigned int len),	\
> +		     TP_ARGS(rqstp, fhp, type, name, len))
> +
> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd_proc_create);
> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd_proc_mkdir);
> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_create);
> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mkdir);
> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mknod);
> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create);
> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create_file);

I think we would be better off with one or two new trace points in
nfsd_create() and nfsd_create_setattr() instead of all of these...

Unless I've missed what you are trying to observe...?


> +
>  #endif /* _NFSD_TRACE_H */
>  
>  #undef TRACE_INCLUDE_PATH
> 


-- 
Chuck Lever

