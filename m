Return-Path: <linux-nfs+bounces-10095-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864D8A34B6B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 18:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D2C3A664C
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065F61FC7DD;
	Thu, 13 Feb 2025 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YOvOPbOv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z02ERVXt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2BE1FF7B0
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466384; cv=fail; b=nXhaWnn4fc7Cyo/pdIDWaf9B6mQHiQpvOr5b4vBPdb6EHsNBytAkp2miFMD04aLe/zF1/u3c4oINjrGHtYXpxDFRAtNnd2Pb0MWX15DGHJ7C6lai0VFdodbf/jb0KATT+bbUH6bwrxa8n5ul27l8alZh+lUYxawU5KFVwhqJHlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466384; c=relaxed/simple;
	bh=4kq1H4Hcz8oO7tjNjYxzxUJFdKfLoeruVHdsxJFiPcs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jl5D6gbr9PedW4tSP0vOY2HfzjQmWcG69MmYmNOEqTtwT/u5xMygOh+OBqu5+U2XozocxuaZVbLp9vyCSAOBAF1K3kchCDUdB3L8VOX1KsvY74BcJrGGYRADRpBjxgNlp8YNK6v4C0ZNUEZWwYiq7k+C3ifwzoT2o66dAJNrduQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YOvOPbOv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z02ERVXt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfd7i008316;
	Thu, 13 Feb 2025 17:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7lP3ZoCd8zRVD0NXl60jVZMYs89e+847WMnqU+/Xs80=; b=
	YOvOPbOviwuJUnKhML2EaHa8LeJxfyLv6+i9MnklsCHehZ6tlaAut+BhDUKACsXY
	+SfIdYd1YtTm4EPu/paEO/RR9iYgh8pqMbfPvTe+F2cWGHmQ2rZ8/h9928J61B97
	A4XYZK3S3QIy56CsH2yGvK+Pv0ap/DTdVxPUkXrxw4liQ/S7gZeN7OUQm3HhiLLw
	qArWYZsLjRwAQWprKw4r8KAakpqusgiJ5lhpvTuqgSlufXg7lrBc6dnpLHOUh+DA
	bHmLPHZYwA62bJNX97O3onYETBs6bm2ko4rlV9KM4DIZpc0QnjVXenksr/r8Z10I
	4qvxsmb8+U2ldvSvHtDf0A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn9ypp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 17:06:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DFvxph012627;
	Thu, 13 Feb 2025 17:06:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbymjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 17:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGvaxEChDKOLczU2BRqAyxZ12fkeugNYmC9Xcevd/sLgBOQJ17fPdB/aqW/9Nf/sPjqZjDUqE1H53hHF0+YtlQlTIuv54FPllQYtoK3SyA6ekdMvl/tp9kG9merAowJ3s4X9oRBpnEBohvxbGcwRMAc6uMqcnyQGw92wBVHvk55PyMsVCkiGkUGoU/+I6LVMyevjUwHQhBV1o02d7qQ+pkbrnbGoKqtovhzsnHHlRzxxBrSrNmJdLdGLWf+tNTkdvjPrvt9QnWzUziwbb9xQAk5tYL6Dt7XxmLGC89UBrGENr5yrL4OwN/EL8XcH0EgYh4vnnK3b5O9JOtYZmZmHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lP3ZoCd8zRVD0NXl60jVZMYs89e+847WMnqU+/Xs80=;
 b=yRDXY3Cyr3VpL/K735AdEDmZcYrgjGVGxbBuI8001ajRl6zFo6Egi4jh4QESNWvxoGqNOpWHE9R28W+m/Hxb3gVCELmt6twRtDf0n2OBfQOIhnrND2XpnjzbFhg/Xn94XjBhDbWU9saH7JdgIkpApyLd/lGXBpSbsIbrCSsQeo8nMumLJ31l+X4EGtMXxs/SSsK3LMt+7njw53V7KQBZH1R9nQR7z8AkqQuZ+3pC15xiAgung7AINNaQTjAjLkzhPP8Tni5jG+A8uRbyWJT/utJIFxRoBf5RHvkGvLhVKHlPXm+43bT/O3jsAFdVaC8eMBgmNLsUoF7+ugl0iSYdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lP3ZoCd8zRVD0NXl60jVZMYs89e+847WMnqU+/Xs80=;
 b=z02ERVXtfH+TGm6bfm8k0Sx9kclv7Gfjxkrcbe90aFRpMgKq8put8bC4XUbIZIixZceBIr+QoH2sb/Ey+IoC0KcPD2I7DpDA0CTZE8r0mJVqI7fTiFPDgvqB9W8yBW6UgXsTFDkRDvXR9dqddN7rfxE/E1uqqSJcztpGOZ848fQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5810.namprd10.prod.outlook.com (2603:10b6:303:186::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 17:06:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 17:06:10 +0000
Message-ID: <a203bead-b24e-4a58-87b6-17ea2c90bf24@oracle.com>
Date: Thu, 13 Feb 2025 12:06:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
To: Trond Myklebust <trondmy@hammerspace.com>,
        "okorniev@redhat.com" <okorniev@redhat.com>,
        "cel@kernel.org"
 <cel@kernel.org>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
References: <20250213161555.4914-1-cel@kernel.org>
 <df999d533683548ba91b69b017bf2b4acc0add52.camel@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <df999d533683548ba91b69b017bf2b4acc0add52.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:610:b2::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5c37f0-d812-44b4-56da-08dd4c50b6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTRpVW5xVkpiYlF3djVhMlNuWmJiK28zeHg4MXVpUE9xNmM5VlUrbXl6eThN?=
 =?utf-8?B?N2lwWWs3MTVZLzl6K0VUTExLZGVISk5lMllEajVLdXJEemcxdmhiVnU4RmdY?=
 =?utf-8?B?dTJDUUJORFRjS1duMGg4NjdQdElydEcxbnoza3JDYUtTbnBvb2RTU3FZMkNR?=
 =?utf-8?B?OVg3Qks3TFNPaWhSOUI5eWc1YjlVMHpSWSs3dFhCUVFPbkJyd3EwemU1OEVo?=
 =?utf-8?B?ckc5R2VsZGdaR29Wc1l5OTNITHhjS0FpTUVlSGZ4V2kyamFxVlZ4S0w4dzZD?=
 =?utf-8?B?NlJGbUtTRkUzUm9vVWxPb0h0Vkw0MUNaNVY4Z21YVmlQaEV1bEFMZmV2a0hL?=
 =?utf-8?B?WW4wUUFMYlNKVWE2cVpGWWV1N0dKUERkM3RDUUVLQzFZSEJ3dkZwaFpJY04r?=
 =?utf-8?B?WW5RNURRbVFkck5xckNxRHlObmNjSTRQL0pIMXRyNVVhUjdjckNQNkFWNmkx?=
 =?utf-8?B?NTN1YVVDanBwdnBmMVBpc1ZoekEya0M3WkpaK1FDRVl4dC9YMTE0WnpucHo0?=
 =?utf-8?B?aHNqaUtlQTJYOWVzZ1pkYW1NeGdmSzM0dWNJclc5blk2T1BiNzJVekFxVDZz?=
 =?utf-8?B?ZlZKeFQ3RXRPTHRlcGdWbHFSRUM5TkZScWloQ0VEaE5LNGtJeGN5dU5HR0g0?=
 =?utf-8?B?MVlUSm1OOFN5WXJKRHJJeHJFSGMvTTU5THBUVVBLeERhbWZPQzJ2VWFMRnRZ?=
 =?utf-8?B?bHhNbEFuL0VqVHJuQ3VVcUwxdHZFMEdKbktUYTBLTWJCcWdUSThFUU5yMTVk?=
 =?utf-8?B?TEQ0UVlNNFhCNjZHWk9jVk1Ja1ZBU01LODhwMHNsWlpOcjAwSVZ0MFlxRGtK?=
 =?utf-8?B?amkwZVVOUmU4UE5yWUh0WVViZ3dKcUprYmFYUDN0QXp5N1JsNElURy9handn?=
 =?utf-8?B?NTdCWVp3TTY5WS9CTDBkakE2eGxtbFluZXNyNENzMVRBWU5ZcmtHc1dRaEtZ?=
 =?utf-8?B?KzdDSWVqQUF1emx4NkJUcEllSHJpOXp3anlQTkhRNUx0L2JTNkREa0JSbUlx?=
 =?utf-8?B?VUtoWmcwbDJTZTlFa05BemNOUDhJcVEwOWpDL0thMVJSMzlESFlJRExIV0tM?=
 =?utf-8?B?NWJHYnQ0UXViOHhrWHRpVHYzK25BdkxoWnZqeHFjR1VwSHJOZXVoZGtIcDVz?=
 =?utf-8?B?QmIxUEdnZEdNd1hmRlNwVitETVNiSStFeERrSDNLVjU3djBSWFQySkh6djVw?=
 =?utf-8?B?cStXb0N4VUtjL0R4OE1YcnVrRUFwSXhLUnFBYXdUN01pZ1NUZDIxSnZVN0ZI?=
 =?utf-8?B?dUtHNnBGdkthd1Q2QWd5OHRXNXdPZDF5eUgrSk1xaUFKOVJhOUprTDlnUkNX?=
 =?utf-8?B?QnR0bEczNi85WGV1V0RvQzRNUTFKdTNqN0o1d0ZkeEcrblZPMlpTZHBnT2VL?=
 =?utf-8?B?SXl1NHlPQ3Q4T2hHV2ZLVTl2TzRSNUluYndqWU1QK0ZPYUlINllHWDFaVkNu?=
 =?utf-8?B?TGZvREpYMWE2cktTR21WVUdKZlhOMXVlR2hkNHJXZlMwbmF5b0JOa3RJYVBR?=
 =?utf-8?B?TXNCaEcvVVA4RTRIVXVnVDlrQmdXT2s5c0lraWVtbmxkcmxMcndYRTF1U2lR?=
 =?utf-8?B?aWdESjVvRk9jQzFZWDJiWDJUQ003aUFvQ2RJSk53ZVhqd0JYcm9XMDVuay9C?=
 =?utf-8?B?MWg3eTlISlhKM21rWGVReEQzWTdjaVNEcFdqMXlJWkRTZDVEK1k5WTVHa2RH?=
 =?utf-8?B?YUJyUDRNdWVidHRXNzVUekQ5OEd3cVhIRkNkd20yRzZKZUhkdlhNK1Z1OVAx?=
 =?utf-8?B?VXA1aU5haDZnM3BtWHl5QWtybnBybk83NXlHUWkzUlBCU04xOSs2K0NWeGN2?=
 =?utf-8?B?d1Rwc0FjTzdhMWJzYVk0Z3ZtWmdMcjBwMlk2Uk5oWldhZUpsdk9wd0pQUVVG?=
 =?utf-8?Q?Kc5W6z/FcKX9l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDhjSDhIbXI2aDlJU2NONlhGZnRCMjJhREdOYld2SzFlL1V1ZmliUmdpUUNw?=
 =?utf-8?B?OVlBT1NZTlI4aXdpbDR1ZmZtWjBpTFNjdDNXeXdCSmwrQ1NSNWl3UlhxUXNo?=
 =?utf-8?B?SnBGL0xNb2ZYbDlGS3hpb2VlTEZuSmxaK2poMUorYmNpbFEyRllyUmdQem9W?=
 =?utf-8?B?dDRHYmdMOGRadENvazZhRG5Scm9LeDBIUTExaDN0aWRaamFyR1hObi84clZS?=
 =?utf-8?B?NEd2N1piU0xUVzdxWFB2K3o4cmJJMFBiMDVnMzRLL2EwSDRLWnNreGNwRnpz?=
 =?utf-8?B?YVlLWUJPeTJWS284ZFYvLzNodW14NlhTWUtEMzJrZk5tQUs3ejFqcVlsSVFF?=
 =?utf-8?B?NU1YVUZ5WDVwdjdmVUhCQ0VSNDUvM0VSaEFNd2lJL1c2SzRKTkVtUWZINFhJ?=
 =?utf-8?B?UGJPd0kyUnUrYVZjVi9ESHFGU1hxWFVMb3Voc3ovbkRCVHNYbGRFRDYyWHpB?=
 =?utf-8?B?RXh5QjRQOE8vankwMjQrN1NDUlV5QjJ3K0FmMFBVUkRlMmRLNmoycFpIUnBT?=
 =?utf-8?B?cm1pZXNWZExLQ3p4Um5LWFAzcmhYdUwySnR3dTlyY0c2dGVKT2JoYTYrSzI5?=
 =?utf-8?B?d2lsSVZxcDdKY1IvWGNsTUNidW1SYVdmUlVkWVVjY2RKSTdvb3JnakM3OVFi?=
 =?utf-8?B?N3k4SWVSd1kxSzhOSyttSDR0TXVCZGYzUGlaNnRMZzd0L2ZXUFlvUU5QZVBU?=
 =?utf-8?B?cVpjRldPdG83Lzg4UHFMcUdhUTBXQkR5SEZVQS9ETjI5VSsyVzR2ZHJkZTEw?=
 =?utf-8?B?NjB3RTZMTEVBQVA0dUlzQXR4VFdDMlVLTkV0L1RPN2Q0Vk9URFpZTlNTdTZj?=
 =?utf-8?B?TXNoTzAxV25OTnBac2d2RlFZbk1kdWtiQU96RERhOW5nUFQzcFQ2Y2wxNnoy?=
 =?utf-8?B?Z0pKZXYvWG5xbTg2RHIvaGNmWG4reXYrVkNuV3EvRFVCdEFESytSR3FEaVVE?=
 =?utf-8?B?d1JIa2RkZVptYmNDQ1N0a0UyZnlscHV2M3IyTTBhSXJEL1BmNDNqcWg2dFky?=
 =?utf-8?B?SkJhNlFlajZPLytVNWhjNCs2Mk1pRmZDckdSdS91UVVMQjB4VTZ1a2dmTC9k?=
 =?utf-8?B?RlZWV2cxc2hJb0FoY29rQVRwaTNyYUFQUDdqQ1RaZmpLeE1xT1MvTnJnWTJ3?=
 =?utf-8?B?ZWlmL0wyYXFIQkhoTVZGakJINjFHcURUNTFtNnBsdml4bjFaRjFPYm1nVThI?=
 =?utf-8?B?QllUalRNV1F2ZlN2NGljSjFDdUh2ZFE5NWxLckRjMWh2UVltUUc1Z3BwTml4?=
 =?utf-8?B?Qk9ra0ZFempURlJlMGUyUEpyVWtxQzNyZEZyMVdiVmlBNitoUzFPcWJKVkdX?=
 =?utf-8?B?WE9wUFBYK09wZXpGMHE3WEpXVWp6WEhCOUpPQUtCMjNsY09YMDVFZFlpN01U?=
 =?utf-8?B?NkpxWHRKSGNqOEFWVXZLQUprTHR3YWphZXltbWRhUXVoM09PdjJwbU53WUNm?=
 =?utf-8?B?K3ZtS09WUDd2NWpwTnFlOTZHMXpJb1A4VGVra3UrN3l0ZmVBT0Z3cGpwZm1B?=
 =?utf-8?B?RGdoUERKa3pMNXFMR3QxdjBBc0N0R0pVc0V1ZUF4RkVtWUpFalVzRDArTlBR?=
 =?utf-8?B?cEtvUjVwVDlGeEphdkFBZnVONnp2R250Q000b2RNMDNNci91WW1xSXBKQmEv?=
 =?utf-8?B?ZjEvWGZaOWl1TitKT2N4SitKM0hCMU9XTnhYUmovbGkxdXc5aEhndllDU3hM?=
 =?utf-8?B?R3Ryc3kxMmJ3MmJTMUtXOHRsc3hqcUZmM0Z6VmFFY2o4WEtZV2U0Z0NGVmt5?=
 =?utf-8?B?U2dUb3JqTVlwU2ZxVlI5VEsyOURoNTY2RFRCT1pRRmJhaVUxMzRGQjlIUzJ6?=
 =?utf-8?B?d0g0T0IrejNpY1lSbEU0WmFnZnlXVTZiQmpBTW1tcTlVd3RHdGNDTzhGdDhk?=
 =?utf-8?B?MWxaUHB2NEJBMkpIRWlCWHhBMjRqZk5JNjhRK3cyUE02OTJ0TkhoekpFV0Vz?=
 =?utf-8?B?YmhaNFJKN2tMZ3hXNkIzak82ZkQySnlub2htWXBsOTM4VnBVTzJxeHpmdHhp?=
 =?utf-8?B?NlZoY2QreDBPYURtbk1FT0RMa2tGZXBFUFduZnRlMnU5ekhhSFlDSFhXTWVE?=
 =?utf-8?B?MlNPOFNBb3NUbjN5T0dEWlpacVBVRStaRTFlb2NaR2tLN0NzL2lSUVV2TFFw?=
 =?utf-8?Q?0w+RnX3iF0GWoZXNZPJKjidec?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0+vhpg80QpcoJe1uoz1Wcm+4N9vJ7zdylQWCgLm/3lMMIfLMpLXc2e5dThCficSuGWPBWGn6S/aDeCTCbQITrkIZhhUMdGmH7mBgvStiNSuIEcCRaA2O+MLYvbhd5bT8eaDRkkJo7xFPshfL//quKOz2deY7PxefoSRqV0EBbQTlUSZQZ1ZtlI0hx95AHYHH46Zjc1CiG771kGLDxMhjAWBiag6s5rov0dvkZIMRlLVcTBMMY7r0RMwAjePQAAxVkMmajv7TsoGaM7xUmOmAgnhZboa9vaqQMS24Rf06JKEHrUd08nBGO4XfKqEVBv35n3AoQYRVI1U1c+PAZzuWcdXKCHJrLC52+txARa6QqyGObHs3M4LbGtpf+ImUb6XXhHPID1MiWckgEKCPqHLoAPvPq8an1CWZSWH79azUHpPSCFwvrxzgshrRq0UqS9q84lNbE8vbJaekcz/oJjv5Q7cUth1Ek20YTGyBFcbuJ7skNErOvV64SbtDB44IFxn8OzTPixdd0ONaaVppgRwL5R8JLyB3zbDAuwVxqRNCMnr3Y/J5Jk5U8DMo30+XfT3RIpx1cBSuZPzvpvBgYYDaXVxMJ9RQsMx2BMtcoDycNr8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5c37f0-d812-44b4-56da-08dd4c50b6a0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 17:06:10.2871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTcektIws2bKR1UQahbc7COHn7xeDBCc+zsHKVod/t9Tz/Pg72bAGSTUybskB1Dtt3xLoTBhuY+EbZeDwPskWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130122
X-Proofpoint-GUID: brotgOGrjZYGF_wAHXGDphDo8GsCtTVF
X-Proofpoint-ORIG-GUID: brotgOGrjZYGF_wAHXGDphDo8GsCtTVF

On 2/13/25 11:54 AM, Trond Myklebust wrote:
> On Thu, 2025-02-13 at 11:15 -0500, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> The NFSv4.2 protocol requires that a client match a CB_OFFLOAD
>> callback to a COPY reply containing the same copy state ID. However,
>> it's possible that the order of the callback and reply processing on
>> the client can cause the CB_OFFLOAD to be received and processed
>> /before/ the client has dealt with the COPY reply.
>>
>> Currently, in this case, the Linux NFS client will queue a fresh
>> struct nfs4_copy_state in the CB_OFFLOAD handler.
>> handle_async_copy() then checks for a matching nfs4_copy_state
>> before settling down to wait for a CB_OFFLOAD reply.
>>
>> But it would be simpler for the client's callback service to respond
>> to such a CB_OFFLOAD with "I'm not ready yet" and have the server
>> send the CB_OFFLOAD again later. This avoids the need for the
>> client's CB_OFFLOAD processing to allocate an extra struct
>> nfs4_copy_state -- in most cases that allocation will be tossed
>> immediately, and it's one less memory allocation that we have to
>> worry about accidentally leaking or accumulating over time.
> 
> Why can't the server just fill an appropriate entry for
> csa_referring_call_lists<> in the CB_SEQUENCE operation for the
> CB_OFFLOAD callback? That's the mechanism that is intended to be used
> to avoid the above kind of race.

Intriguing suggestion.

It would be helpful if that were called out in RFC 7862. Should support
for referring call lists be a requirement, then, for async COPY offload?
I don't see a normative mandatory-to-implement statement for rcl's in
RFC 8881, if that matters.

Practically speaking, though, NFSD callback does not (yet) support
referring call lists. It's been left as an exercise for some time. We
simply haven't had a strong driver for it. Maybe we do now.


-- 
Chuck Lever

