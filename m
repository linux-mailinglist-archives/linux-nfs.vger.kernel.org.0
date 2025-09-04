Return-Path: <linux-nfs+bounces-14041-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFFCB44254
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 18:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451171C83F83
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1A92EBB92;
	Thu,  4 Sep 2025 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jx+H6EW+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r1F2eylc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBCE2F532D
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002211; cv=fail; b=scbJXWhxQI2gbll4Tzkv+GuHB1GF2XOOExhzbBYPutEMBTpOHuqswgpAfP7UgZhWnPp9Q90ITmYIAIHDSUp7X8YQ0gkrAYol1m15kE+AKm0a7xcxxqAvK+aA5Ph2LjlLccBuTivvZDg4wgMhBaf+HEIwxCHZsemjQYItDFU4V0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002211; c=relaxed/simple;
	bh=lX/Mc6ZqzG/doi5LkxOm1ICRpYvOoSaYKARhHPLTvsQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KIO9MA0yR7HZWk3RpG9m3shVEqz7noqEiTT4yoNikj0aCK7HXSTdAJSpIjA7lSWc4yEqKMX1mnibdwZlyzD/4Q85KOo0xOUDhGbA9vHO1m0CVvppQcCz0ucpKGNuf7X4MZuaCvDVl78qpanyM1pZCEPczfPytkQa5BNk6kbSUtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jx+H6EW+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r1F2eylc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584G78Ap002048;
	Thu, 4 Sep 2025 16:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0Cx2MLcNO6ybuQ/6fMfWQYkGlVcP+0eDFV3+0FBOXjA=; b=
	Jx+H6EW+Kn82Vu+5jRLgJdOQwEVJBqUk/3TY2+KMf+rcx/5NxdVQDP3qP6Ll5G0O
	L7YkVjHk7oW9jrurAMq4gVx4u9OMdGUTgOotJDIR4WlLrgKU86+B9rg1ab17DEm/
	0YMtmz4OaqQpTrMIXFDT99x6bnmbHPK4Leuev+4y2RgjlqMUj07da6mG8uvV/UJa
	NEqeQ3s8uww+MVr70P3zfKE+WjIksVrHlqNH3crUE/LDkAuZ64FrpHl+bpUmFevB
	MUDfKEbM76Hu3yLi8vMQX3PXI6ERNPmyETdGmsJ+lN3747J3HpaiDtF3n7FFLI+F
	mR4zSTNbHFyoWkVMtvaq3Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ybmh0d4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 16:10:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584EqJfC040850;
	Thu, 4 Sep 2025 16:10:06 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrbg0ka-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 16:10:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyO4/3oXMCZ9KTfQdS/NmycGAgQHYBV6mtxRUP6uTEao4IWHtQxwdLimFT8M5qaRcuE4uvokzInZ7wL9Viz/21wYOOQc2BXvoqXSdRgGV8zOLyziZ6X5tGuPuR17CwxOsqxTXLfnVnpKT5uZ8h/Kk7dwPBKBo53QPOn0yw5yquAts9pTJIe+7lJEMMUJo/8STybzR2lgdTXKgnfXr5oPqZJzoHR9609tSpGfZRzL1YNK9zHTQMJNHEmcrcQ4VwoPZmjZAKahluanf+9GIG2wDfTw3I071Hd5Ol87d+PnIxxgU4NBfsejIx0Ub86xYwo0Q99ZppLzbjRTO6JkC9ENCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Cx2MLcNO6ybuQ/6fMfWQYkGlVcP+0eDFV3+0FBOXjA=;
 b=FHozYNmXBSkBdFVQ1A30i2WV/5BDCNWVNj8mdG0bjhCQqGfdlBwnHdqL+1pC4J06SdYNo//5Mett5lmvV7HF5x9MSxCR21O3nH7VZEjQBAImu06EDGwJ44l5KjULw02jPWX1mshtIp5U7tQZ+3Nm77ijN12Yxp+WftXq/66imTrSaicN76kC5E6er1+C9WejrAejrnDCwFcNvYw92VMk7q5+TxZIEBiAoBs/2+IvgWVChWcjearUPtTo/zoeSwwbUjzoRGI35oJulu24qTIZPpxmjho+63LBBR7nZgX6TxgoBSZrpQqxhsJvVujL8WErD3UmtPiShJRrpNOoW+SS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Cx2MLcNO6ybuQ/6fMfWQYkGlVcP+0eDFV3+0FBOXjA=;
 b=r1F2eylcJ/cNwcmt0COkZC615Nw0fNL/4FZa5yIKrEj5ijlrvU3RQ7/3NbVwTr0Ss0ySJa1X8vE3BFTHnnco+z8cwctH4xsXIaz52WOC8Tmse6WYpUXcNzz88f+Bu4m+i19ONw2VIFMjfHYUCL0oXfqofxvMVcOeBP6LpyFbgfQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB5989.namprd10.prod.outlook.com (2603:10b6:8:b3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.29; Thu, 4 Sep 2025 16:10:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 16:10:02 +0000
Message-ID: <3e877306-6e1b-4428-8a1c-e0bf4e768367@oracle.com>
Date: Thu, 4 Sep 2025 12:10:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] NFSD: fix misaligned DIO READ to not use a
 start_extra_page, exposes rpcrdma bug?
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
 <20250830173852.26953-2-snitzer@kernel.org>
 <2559f795-bdc9-4d39-aa03-e6a6d89e9f84@oracle.com>
 <92908105-9261-42f9-a0fd-ebfaf3e2f564@oracle.com>
 <aLdcbnELMGHB-B_E@kernel.org>
 <18b20826-3c9f-4763-b0ac-c7f1dc2be4d4@oracle.com>
 <aLdhL7xFxR-r7H_m@kernel.org> <aLmlY-xdYh73UaAf@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aLmlY-xdYh73UaAf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:610:58::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d9f193-2895-4ab6-9bef-08ddebcd811a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SFZNY3dIYTJrUDlmb095T1g2R1J3UjY1R0NNZEN2NGxjQ3Q1Z2N3M2VrMk4x?=
 =?utf-8?B?OEM1d0ZEdFhCU3hoQUVmQXBjT3Byb0xIUVdnR3pkRFp2dXdzNVVPOXJjdEJH?=
 =?utf-8?B?c0VOcVJoSzJQNmpoR1N1TWx5ckx1SnUvVENNVzZScGc5UEhadnZBaHZvcFcx?=
 =?utf-8?B?RzFJVyt6VnJUWmFHQStrakYzTGI3R29GT0ExTWs2ZVViV0RLV3FYVTl4WXVE?=
 =?utf-8?B?OXZPN0ZWTVRTa0g3VG5KU0Q3aG1pRFozVXNSaDZmbGFqcVhhdVdpdTlMeW5Z?=
 =?utf-8?B?NzdlRlBtU3l0eFV3L1daR3VScTF6MVhHL3BmbEdSQ2xLT2lxZGJML09yS0pY?=
 =?utf-8?B?ZGd2YkRSUnF5QmFMbENYUFo2L1JuNm9teVlKK295ZXJlTmc4WlV4TVVadUNT?=
 =?utf-8?B?Ky8xWUVSeDJRVVZGWTRNemowZUhmREx4Wnl5V1VnbHVuc2d5VDZoZDJkRzFq?=
 =?utf-8?B?WXJaZWhqMm8vME81MHhGYkhOSlJYNFQvWkZOTWdQQ3M1VXpCb1lQWStER0dm?=
 =?utf-8?B?U1VieDdrbGZBUW9OS0FyajRnSEZaejVUbC9XNGdVT2VPTHkrWDZlRFgxSWp5?=
 =?utf-8?B?WGZ4aGZoeFlyeTN6THl5aHl0bXhiVzhxbld3cGNybGZhMENNVS9HazV3N2JO?=
 =?utf-8?B?UGNXWUg2ODhwcWNTR0lVdCs1SHpvTUphbVovbnpVdmxQR0tXWjN0ODZsaDJN?=
 =?utf-8?B?Qk9tQlRESFozTFMvOEhKOUh0dWVMTGIvMGMxY29oTDZlZXQwUWZub0NOWmh6?=
 =?utf-8?B?NUhwZU45VHM3Zk16WXpGZDJHSXlFYk5lY25WV3o1QS96QWoxc2dMVUpZZVZj?=
 =?utf-8?B?NnlRY3hJMitNMHZndXhlMllUYWk3MEJvUTFjWHArL1BiVWthbDRobExBc3U0?=
 =?utf-8?B?T2REWUs2Y3I5bmZLWDVteXlFUVFGVjBaVHExK0RSSDc3aHl5VUNHZHZ4Yzdv?=
 =?utf-8?B?Vytkejl5NHRnWW14VSsxZ1M4NkJGRFp5TDFPUE5yemNYczdHVGhDQlBGL2c1?=
 =?utf-8?B?ZG1VM1pqeXlQcHgrSkZwRTkraVZSdk5CczIrRnFxT09Ya1NkMm1RR2R2TDhz?=
 =?utf-8?B?VXFtL2JGeXRlWE54cmxHakhKMnJsR05LVW45T2tDeUhqYkpnYnB5RTN4RnQr?=
 =?utf-8?B?QmN2emwzSUlKWTBVZ3RwQzd5Sm9ZNFBOc1Y2YUgzMEhIUUhTd09jS2cvRUZi?=
 =?utf-8?B?ZnlkYlVyWXZGenovMENhdkNHQSsrWUpleVdoZ1NocTdOREFQV1QwQS9yelhS?=
 =?utf-8?B?SFZQQWlXNkUvWWZYSFZBWlJkMXk4RUlSYytxMjZzU283TUFqSk1OZ0lES0ZU?=
 =?utf-8?B?Z25zTmtGcHZLc09IdnZxbGhjYWp0Wkpnbk91bjNHdm9uSzJpRGZyRytFdkk1?=
 =?utf-8?B?RUIwa3ZoY3VpTlN5MS9RSVZPQ3A1OG1DUHN2UThXSTdGRFNnYXpLMmh1Qy9y?=
 =?utf-8?B?MzNXcnk4SzNJbWFMTWhjNWx3MU53QXErWFNGVmZUU0pQWDg2NlkvcHIzbmU3?=
 =?utf-8?B?a28wYkZoQnBKeEdYWDhlbnZUY05HSXludkk5Rmd0aldOUXVNQy9rR3htUkRT?=
 =?utf-8?B?eTNITXJmYjN6c1VBVWVtS0IrNWh0eWhGakl3NDBmVGxrMWlPMElFZk01ZnFI?=
 =?utf-8?B?MFJETHdLVjRKc3RDNWd2SUJaRUIwcnVkcmhYMDVpSUh2d0ZZQk5nRjFtUzVt?=
 =?utf-8?B?OFBJMk0yNzYvMzB4VUdEaEF2VS8vY3I1Q0crbDQ5aFlYTHBiVlNGcHlqaEp3?=
 =?utf-8?B?aER2VGxzSFpIR1pEWDlSbWdieVJRZ3NzUkYwUGtzS2kvUlNkMGp0YkNiOXhT?=
 =?utf-8?B?aGpQN01oTWRDUG5OTU92cnhRUzAvNFFqcTZNajJ5d2l6VS95UDFCMWJyWkpn?=
 =?utf-8?B?SEJNSlVJYWtnT3JydkhKcVJFNkM4TVEvdHhmb2wwOU1GUEp6RGZXUWJKRk1J?=
 =?utf-8?Q?XL0gSr2IrPo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cVdoOXNnWTJ4dkxwWkNnSTZPVmYrVHE3TzZvdGFFSy92NnRmKzhybGhkNGda?=
 =?utf-8?B?TFhEQU5TSnprS3JFYVhIN2FPdXJRdy9BNFZEeXpucWlBYXhxNE5XSm96YkFk?=
 =?utf-8?B?ZWZ2clRwOVdUNWhMY1lzY1htdDBldjNpNk1KMjBWQzFkdmswN2tLNTNBMTVO?=
 =?utf-8?B?Vm1nUVZQUXlnQnE1Y0R1QlgwYjdmYzM0cXhLZjFmK2FuYzJUQ3pqL3R5NFZ3?=
 =?utf-8?B?cmh0cUtjT0RTT0NzM0kxSC90T25NRGorOUZxUFZKa3lxTWRnU2ZGL1BPUHdo?=
 =?utf-8?B?dXhnZUVRN2p1bC9Fb3pqM3BzTDZ3cGdSRTVPNjd0Q3pnRGEydzRpeHcwQ2Rk?=
 =?utf-8?B?dFBLemsyZVdGWXRocWRwZlVTTWJGOFZwMTV3TnQ0WFdGQlUyT2ZidWNPbk1P?=
 =?utf-8?B?K0tKSExKSFhTTTdlY01xZWlaVi9Rdi84KzA3TzkvdXgvUjgxQm82RittQ0Fq?=
 =?utf-8?B?bk1VYXMyT09Ic3FBeVQ4TzhIdjlJdFE1cWhsMnlCRXhtUDVVeGJ0eDRtc3hk?=
 =?utf-8?B?bjhUeWsrZVpSK21xWWtWOTZkNEpTZ2cwZGpjOWtYK3dVcVNrYklRamc3WGFz?=
 =?utf-8?B?YUl4eXV5RnhBYktoM2ZNbFRpUnc0RjdWNlIveWpPRGh5MVdEZ3YvdDAzTnIy?=
 =?utf-8?B?OU5vYjQyRHJ3cFI3cFQzMzlNNmZ3ZDFFak52ZHBQUERDTGU3UlQ3TUhuK0Rw?=
 =?utf-8?B?b2VlaTNSM1hSc3RmL1VmUEs4OHdFQWxVWEltalVZQnJRVWI1M3R0cW9rVUZp?=
 =?utf-8?B?bmIxbXdiWXdrVUVKbFhsR0dMd2pJOUhTNUcyZit0QWtEU1N3SVZyRHpJc2sw?=
 =?utf-8?B?NkdsZ20yS2pKV2dxbUlDZmlmT3ovMGJhbkxZVjVxL3BVbHRybGZwM2MxRkc1?=
 =?utf-8?B?a212cXZDd1l5TmNHME1WaUJzVlQ4MGV0Q3RlQXFqNUlUV05TS0FqU203d0tI?=
 =?utf-8?B?MzlWZnEyUmdleEQrQ2VOMGJDcmQwc1hmSFMvb0M3czQ1SUkyR3o0cU1CK2xY?=
 =?utf-8?B?bklEVEFyMHAyNWxkYTRGUUNPRG1PVGZuaE9PcnBHM3lIdGdoelBYd2lWbHhu?=
 =?utf-8?B?NGt0ZWtwQ2ZGakhaUUl1TUpmeHc0NGQ0TkdMdkN3WmpxaUwza2Q0RERqa0pN?=
 =?utf-8?B?ekVHd0tKS0QzbzZWTWV6RHFsTTFQeG41OTY1bk5UZk5WNXpudFJlazhLa0lQ?=
 =?utf-8?B?QXhhWjBLYUlIOXRVZFJhSGF4Q1dQbTgzK3ZNMFJJbElDcUZ6bTFVSWNmRDVt?=
 =?utf-8?B?Q2szSW81MUNQSWR4VXdWSFRtU0htSXJJdWtuYVZ0TnZzY28yR2plTmxEdjNP?=
 =?utf-8?B?VEVHWXRZT1NLNkRhODBkdzYvSHBGazFNNlZWWkFCajVHZmkrMEI2UGQzamlX?=
 =?utf-8?B?eWVZZ1pwU0xZTFhGOUcvQkJGR3NoOTFCdEZUUnZMQ2FQSktKaFA2Z29YKzB6?=
 =?utf-8?B?ZGpJZjA0WkdZeEx0TGNpaXV5TkxSelVoR1FrbEJhaytmbkRheVZUTmJlaVM3?=
 =?utf-8?B?bnB0YmwxNjB4ZGFyOTBkWFdZZFBQMDVrMkZhTWFzbFAza3d6SWtXK3JSOE0r?=
 =?utf-8?B?aXBmUVo3ZjdNd0V1dGdSa3FuWlhFS29KREpndVRIalI2bHVqaTZjaUJFblM3?=
 =?utf-8?B?NmNSZ3NEQzNwZ2RoQVg2YmoxbXhrU1FlYUVmbmY3VVd1S1dLSFJ4QkVQWE4w?=
 =?utf-8?B?TElTMHZyU3V0VG9zQUxJUHNxQ014aG5wY2p4cFRhK3FvNzdJK2hVeVI3NG1W?=
 =?utf-8?B?SDkxU3V5Y1poQktON3k5c0JXaThLQ2gzQVVSSkFweVRFZHltU2tBN3lJaXhv?=
 =?utf-8?B?ZjNzQjdBWmlSejFJcXFFQ2RWYlUzck1SMStoU3VrUmRZN25wZGYvd09ZclhG?=
 =?utf-8?B?c1g4cEorUkx2Qk1DY1NQUXdtbVg2Zi9zcElPa0hZTm1ZLzhyVERrYlpERXZ1?=
 =?utf-8?B?ZGh4QU1WdXZwTFlydUwraGNEdUExd080Y05mUXJTZkhjS3laak5oYjlvQ0tn?=
 =?utf-8?B?aTR1dDk5b2FxcE9WcnpxWmp0UEZDSkEvRDVEZURTOW5IL2UxMDdzRjRVYWxH?=
 =?utf-8?B?eVpManZibHMrUkkwYmVWMTl3dVlvcnZYNCtBVlJUSWhuVll4Q3dVR1hrUUd5?=
 =?utf-8?Q?fppMmwTqFto3HYvJH9heLfOQ4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jtGTKr3ZsamSFgA4DpOm8Ks+wJMAUR4/GPAA+qS3FWFlvHWsr77Op7CfI+owMJRnA3fq46YoISQRv/Uytq30NenhkfTmh8Kh+ZROtAMkByOOUebZe1OZa/vXvSCnMr0ag0NyXZmk4Vecn1FV6F4szrokRCD/NtveFPzWPL4kmO2e9pgyNJ/mNYKlW+lm9Y8VqBGXVmjQkWzP0LWIe2y1TIAdTwBi+peQD4UmcP3lWj8RvgY7areWYtRrgArKGkmHvhKJUZeAVLInNkdrQ9OR44TukKsSGwNRyY+408Z4LdNQcpwHTH/ByDLQZdE7wNmahnxkn82fTt9HV9o6uts92VZlp1m03InQBn+5nMR+Tafqaa6gVs0OLgQX2xjOnGx40WnmkH7lDnP0buYe5T6fAcfpznuJ1B39cVtYGc9NdMI+WPn6PhItC1enn//gdw8peLhkAyIfw9OPuSFNRjv3n8vhWthz5PRVLfVsfE1jFgLQzysreeDdBComYhlufGwbH8R2ViSA2ebPHHW72Q12U6nVRbkh8bMyqmUmYm8X8eghHFrfomNqy0zSzdM7de3/vF0UtLGygNMx2xGenQZVqKJC/91yaqaj6/+qdVlvL/g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d9f193-2895-4ab6-9bef-08ddebcd811a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 16:10:02.4436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1UI6XKqPnIsqHNckyi0+G+m0OsDs3hwffxoKajIhG/q9UkxmlwR4/U/kl0s75+eboe7aykAxOYJfJo2E4YJmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509040159
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDEzMiBTYWx0ZWRfX2tJaTcI8MMSv
 Yo46TUx1sBgDIJDy1lpFrur07KVfuqLNyDRFJKKrVEyzGcm1UUZzAyc/LtAXgfF6J0fDK494Ohk
 q5KlS1xTUxy2WbbZU6wwQAH8CvybzcdJmviMvZ5CgTE3E9MmYzr7/HY6yXHln0L252Ur4WxVz+i
 5bB43vibA/lyNgv+kpoo84yaKDpKHsIxyd4DvmranDTDkR48B9B7e6ffdmisIwURywelLCeSrdt
 +24+VNMlIfJd1U3wreJoZdspvI/+/wOG/cKfxYSMoFWEszlOttmKG697uApi6lrsj/z+6b3NsaA
 9B496kpi4JoCICgSDCJ73xDciDmu4NAsQjLqxxGwCQw+26/H2hHQAUkqoFAMG6AZT5dRtxX/gZw
 SkdfE68I
X-Authority-Analysis: v=2.4 cv=Z8PsHGRA c=1 sm=1 tr=0 ts=68b9b9df cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=2Fn3BYwbAkwhattqnTcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: w-NYDrQ1nEN-I6kIlrW5Dwy6CTX1f0Ta
X-Proofpoint-ORIG-GUID: w-NYDrQ1nEN-I6kIlrW5Dwy6CTX1f0Ta

On 9/4/25 10:42 AM, Mike Snitzer wrote:
> On Tue, Sep 02, 2025 at 05:27:11PM -0400, Mike Snitzer wrote:
>> On Tue, Sep 02, 2025 at 05:16:10PM -0400, Chuck Lever wrote:
>>>
>>> I am testing with a physically separate client and server, so I believe
>>> that LOCALIO is not in play. I do see WRITEs. And other workloads (in
>>> particular "fsx -Z <fname>") show READ traffic and I'm getting the
>>> new trace point to fire quite a bit, and it is showing misaligned
>>> READ requests. So it has something to do with dt.
>>
>> OK, yeah I figured you weren't doing loopback mount, only thing that
>> came to mind for you not seeing READ like expected.  I haven't had any
>> problems with dt not driving READs to NFSD...
>>
>> You'll certainly need to see READs in order for NFSD's new misaligned
>> DIO READ handling to get tested.
> 
> I was doing some additional testing of the v9 changes last night and
> realized why you weren't seeing any READs come through to NFSD:
> "flags=direct" must be added to the dt commandline. Otherwise it'll
> use buffered IO at the client and the READ will be serviced by the
> client's page cache.
> 
> But like I said in another reply: when I just use v3 and RDMA (without
> the intermediary of flexfiles at the client) I'm not able to see the
> data mismatch with dt...
> 
> So while its unlikely: does adding "flags=direct" cause dt to fail
> when NFSD handles the misaligned DIO READ?
Applied v9.

Multiple successful runs, no failures after adding "flags=direct".
Some excerpts from the last run show the server is seeing NFS
READs now:

Filesystem options:
  rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,
  fatal_neterrors=none,proto=rdma,port=20049,timeo=600,retrans=2,
  sec=sys,mountaddr=192.168.2.55,mountvers=3,mountproto=tcp,
  local_lock=none,addr=192.168.2.55

nfsd-1342  [004]   463.832928: nfsd_analyze_read_dio: xid=0x89784d89
fh_hash=0x024204eb offset=0 len=47008 start=0+0 middle=0+47008 end=47008+96
nfsd-1342  [004]   463.833105: nfsd_analyze_read_dio: xid=0x8a784d89
fh_hash=0x024204eb offset=47008 len=47008 start=46592+416
middle=47008+47008 end=94016+192
nfsd-1342  [004]   463.833185: nfsd_analyze_read_dio: xid=0x8b784d89
fh_hash=0x024204eb offset=94016 len=47008 start=93696+320
middle=94016+47008 end=141024+288


-- 
Chuck Lever

