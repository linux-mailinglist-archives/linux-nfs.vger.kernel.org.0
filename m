Return-Path: <linux-nfs+bounces-12442-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFF7AD9197
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 17:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BE5174EB2
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 15:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A271F4E39;
	Fri, 13 Jun 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nwzle5JT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xSlNwByg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74F81F4621;
	Fri, 13 Jun 2025 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829150; cv=fail; b=g+cfMGL3oGUIdibDApCONmiWch6CL3LJcTA8NglcbnO16eXcW5djiFPJgs7E7lNnyGvkImlMoszTINDLzP1SLRAFsiIMC3+dy1p1x1XmGjFRlGCtNuo9VzI6XjVGsVOVh0as+WGsiITozxxfC0rtCP5p7+K1Rh85h08V5j441Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829150; c=relaxed/simple;
	bh=XnioQmcFXYTHj0Iy4U917Jc6h5ywYug4D2C0QPeNM4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rlCrnI0rKz9UmLoQKkROZaOF1p1fZMN3DITRuA0DZyT4eIZ79iwr6Q58bUrpNTMTxsCZfZ/RhWpZq1yWtEuz1geftoCtvFaP569m30WzIX1CbXsz3UcvmmZI5Oz9w7GPjj66X1Pm2cPzWp89LKC3s0TTsbSPyxPyY1YSb/HamGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nwzle5JT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xSlNwByg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCtcek032668;
	Fri, 13 Jun 2025 15:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aX5ufooFrUEFxSAfXkLbbdMZMgBRr8KWmczbujrTA10=; b=
	nwzle5JTJvTzcE5hwcNcV7qrS0bC6nTTbvqk9YQzSiLqUUKGqTfmnPVM0Gvxzr/3
	ssmLb+ChIV0GQIelbk+jf4J7+3HWmc3U9boAN7rUtENURT4zfjcv5Zk6LgzQctDm
	/tVq9h66jcT1aU3p3oiZzgCwM426VZzptNK4ynvyJ4Vd+1uVr3M9OXQLLqiynreL
	CPnMQGZjy79/q6bB1B2jOEkNgN7b/UogI+yL4aYmHaV89byCq/eMCZ9VBOBJ1fbr
	jfWIEC0K2cSpqRo0gGjx0SV4AqdvCu9KHs3MB4HCPtfbdVoIR8XeqmkApTGmhY9T
	wKRsME0VqlUxJwg6pP3Jrw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1vbufj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 15:38:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55DEnKkt040810;
	Fri, 13 Jun 2025 15:38:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bve1wan-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 15:38:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQnI35nc5vASEfgii7yIO/d6d6EDSlleCLZlcpVZnFksLgoTbONHJmAv17+t2USCnuvZ6//Xz3OpIzo0+4KrBokiCYD2/D3qBAX8RsLEQr97YBQ2h/41Wv9SeNyQ+wPBcmMHF1yfSolNffpQLGxdC3NcBiZy5raSZRILeFJVSuq+qexBXiSmrYLpfiBEB7QCLHrU3Oj0VYNw9VxSw5OJbRgfiH+V51PZBW4GgJ8JgKMhHfIeFy855s/uSlV/eNCoJBwVRr7ao2w0PAvLWtT4fJcCsnaGzJbFBOX+KVcqLf+76Vuk6rV66pVBrToDGnX9fKuGqvZNC0OlmguRgJs5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX5ufooFrUEFxSAfXkLbbdMZMgBRr8KWmczbujrTA10=;
 b=rqC12L0CYdrwVQZn2OBSDAb2o2PF6MsMMc3A6c3dZ51xl/rypsfo6DyS+fHWGBhATd+RR6+4x6LG4hqkZFBPLLMU800kRCupewjSHcK81+FtGNf2m4wjdggMSKN7gOlobGegKhv+ZLdxe9EX4Jzh708wwF2DnB4VKGDV6gFZqxiNdHvey/HZcnH0GGJR8jMuJxmec88ZXmio7aU+r92h8on7EB/1eS/BbHO3bM7uUIoG3zKgFsRVcizHPcpDBYpHNw5R1drFNuYiW92TJYejoRfaBfyNywnjG05a+6d/2kKqcEWgNawOhtKqSyrZuumJx5EDbk6wxvWM7dUxvKEYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX5ufooFrUEFxSAfXkLbbdMZMgBRr8KWmczbujrTA10=;
 b=xSlNwBygwEp7mz/PCTeNtPnugyc4UOpmOOUK+lxXn6+oJmFStHGIRa2U+sXVTBmrmZIq0bX/0sgYSTINye+hvezego2vV73K7Clto3A0UK28FJ35G0ySlq7j1w5NAUMhP0xCi/A+ZSkWWPlR3/2fulQEZPWwObt0aXO8286CqE0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6322.namprd10.prod.outlook.com (2603:10b6:303:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 15:38:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 15:38:47 +0000
Message-ID: <64c216db-57c8-4486-bd40-1d6135478487@oracle.com>
Date: Fri, 13 Jun 2025 11:38:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nfsd: use threads array as-is in netlink interface
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
 <20250527-rpc-numa-v1-1-fa1d98e9a900@kernel.org>
 <a8d4c4cffe1a35ea831110ce1c7beea649352238.camel@kernel.org>
 <ae18305b-167d-4f27-bc3b-3d2d5f216d85@oracle.com>
 <1cd4d07f7afbd7322a1330a49a2cc24e8ff801cd.camel@kernel.org>
 <38f1974c-f487-49b0-9447-74ed2db6ca7e@oracle.com>
 <7DCDEBE1-1416-4A93-B994-49A6D21DC065@redhat.com>
 <df0a6fc5-6ef9-44b6-b6c2-e3cb4a2d1512@oracle.com>
 <6D3B09C4-0E35-4A98-8C29-C2EDDBD17163@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <6D3B09C4-0E35-4A98-8C29-C2EDDBD17163@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:610:b2::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd15c72-8c25-42c2-975d-08ddaa9062b9
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SGZsa25pR3h1OEpMU3cydCt1V0Ftak9VNVFZNHVWL3JZYUw1NnE3YmR0WHdp?=
 =?utf-8?B?M0pXUkJ6czV3aTY4TGZZREJJSEtKemd3L3VURmc5YzVMaVgrK0tNU2RTNVhN?=
 =?utf-8?B?M1VTZTUyRU80cVZCd29laVhaRmVpOHc1TzZabGNMNS83OG81dXF4QTlsSmwv?=
 =?utf-8?B?Z01TVU1nUTJVY2xWdUJlc0lFRnZOb3kyZjVqa1VVNXFkcTdoZVlwbk1panpY?=
 =?utf-8?B?Nm1iVEJWeWpFN0h6TkpScDdUekhGZ3d1VkRsZ2Q4dU16L1ZCcm82QlBEZGxT?=
 =?utf-8?B?YTVRSjlIYXZtYW45ckIrWDVocjlwZmlFVGVod0NNVHMwN1ZJR2ttVmhoMDJz?=
 =?utf-8?B?UDFqbjlpQlcyZjloR2JIV2pyUGdpUWs0aHlJbHQybE9UbGVZTG1nL3Branl6?=
 =?utf-8?B?S0x4cXVlVm92Sm5LWEVON1BEYXlaa1dOSjI0VVJlSU4xZDZxZTVKbElUOStS?=
 =?utf-8?B?ZmpkNXJpMzcwK1FHQ1I2TTlRbEhLUEFsemN3TVV0TDgzemhwS2RUR0VRWEcr?=
 =?utf-8?B?MnROR0dQcHByTk5ZTGZHVmFLMENYSVlVMDEreVBaaFVMV1dPWWpLS3E3eGt5?=
 =?utf-8?B?blZKeXllUkRFanVtbVlYZDlzaFRFZ3NKV2JLQUZxb293RUhXRFhWb0ZXendE?=
 =?utf-8?B?SHk0UzYxdExGVjg1TWIvT0pFUExZbkpxcFduc3BzdkVMbnd3cU5jdjFwZFov?=
 =?utf-8?B?Q2VaV2ljNno3MVI3M1FqMlZJVTJUZFRNVTRRbC9IRHFETWZSalBneFIrdy8v?=
 =?utf-8?B?My9pUmZHTElFTmltQ2ZNR0JMVW9LcnBUZ2R1aUVmZ2JyVFFqSUcyWTloQzJD?=
 =?utf-8?B?NUxCb0NvUmd1UklFMmoxdDRLNFZ1TkQyZzRGaGxNb0dUQ1U2YkUyNWYzT0Ex?=
 =?utf-8?B?QXFpRkViWXRLZVpqQ3BxRHVHSHBOVWNpUTM3WnlrZzBoVDlGaTJld1NSejRJ?=
 =?utf-8?B?VnNZWno5NnY2VzZNS1M0VTZlNDJBUlNJZ1EyampyVEhscGZUNTcwV0dTM3ZD?=
 =?utf-8?B?WWE4Z2hybUJYZHFXZkFiamxDOEluT0E3Um5EbE1qYTBEaWFuMFV1M0ZCNHNL?=
 =?utf-8?B?aFo5YWU0a0kxL1dGeWY0V0FYNlk4MGpDWEQ5QlFrWmpGQnoyMWtBNzZnRVBP?=
 =?utf-8?B?NE5NckFyY2k1QzAyTGdCcHdITHluVXF0S3BhT0gzZG9mdzlxQXVHQUc2bWpu?=
 =?utf-8?B?N1lrN3MyKzV6UmdqYlAxTUN3V1hPUWk2ZUsxMHQyOGg0aGNkbDNaVUVuNk9K?=
 =?utf-8?B?bHJlc0t5bUlXY2FZclp1S2wwdDZFd3RLd1Jmak5vOUJFOUo4dTRtcWRXYjR0?=
 =?utf-8?B?SWhzbXNaMGhhKzJkbFc5aUx5RmJDMGxrcGZLZ1ZBUVNUZE0zWWxyNXdONXdU?=
 =?utf-8?B?My9Qd0FHSStoVm5nQ1F5ajc1L0dIRDFwRlIzK00wYnR2Uk52bS9OQ0grWlpH?=
 =?utf-8?B?YmNaZndaL0pSL2c4SG1ZeXlha1FDN2pvRXM3cng0ZWo3d3JZWnVkZmkxWVlB?=
 =?utf-8?B?Q2Q1V3Q0MTR1eHdZSFZqUDRaN2VNTm1nNGd4WW0rUHZiYUFjMEdZOGk4M2Uz?=
 =?utf-8?B?dEdlS0Yvd21UbWhiRmFBK0h5RTh4REs1UXlrYU9GZmF3MjA2YUtOVklxbytU?=
 =?utf-8?B?cHNCaXFqSm1HSVh3V3BuZWdFU2hEZVErMTJBUG90cXQzTzVRMW1KTTZ4Y2NX?=
 =?utf-8?B?VHFhZ0lDYzl6L2U2RW11NTl0K0pFb0lRUllSVEczeUpKMExaOGE2RHNETXFh?=
 =?utf-8?B?eU9WMG9lWCsvb0RjbWsrM0xTZVkvVkxLNmJMajBRN3lSVUN3K3dsVHZBWGJX?=
 =?utf-8?B?U1FxUW9zVmVjb3o0K1ZFemxCZ2EvQ0grVlVrTkc5S1BUSHdZdSsweTFUNTdv?=
 =?utf-8?B?TlRQVU0raWc2eXFxRFk4MXF1cUJHWlc0dDNYUnlNdmZYa0ZjZGdsQldYdSt0?=
 =?utf-8?Q?l0OPDLTtOME=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NEtZeWZSMW5Fbk5RTlZCSFd5T0lHN0FpV05mL2dKNHhtUS96elRDbGtGWXpa?=
 =?utf-8?B?NEpocDhMUSs5Q2ZSRXYrTWl4ZWpmbnhxM1g5OGt2WVBYTzAwMGg3UFVJYnR3?=
 =?utf-8?B?QVBnUHZBL2lmaHBZQzhOMW45TmJBVXhzYkxUbk1XaDU0djlrQmVjQmV6L1A0?=
 =?utf-8?B?RUNIUzRsSTBUdSt3L2REalFvTjR4bDZDb0h4OE9laExWeXVrOCswNm04dTdl?=
 =?utf-8?B?YWt1U0Ird3czYUd5eU5GZk84cG54MVBLZnlIeXptVmplSmZqSGdDWDZwRmwy?=
 =?utf-8?B?T3o0Y1RETXBEOFc2YjFmcGtYOHFlWlNlRXNCUWZ1TjdpTlNONUJ3ekFjSmxV?=
 =?utf-8?B?ZXRsenFLZVoyOVlxb2JCTWV5R09sUXRSTEszTjMvYUdZc0d0KzVkeG5WaVFn?=
 =?utf-8?B?eVJYR1hvRG1HbDdvNTMrdW1lWFFTZTlnNS93UWxMNVdZWDNHSmtYT2RuYU51?=
 =?utf-8?B?WTZuZWxGbEhQMUVSTGpDdW16K2NIWm8zQ1hoNCtCY0Z1QndKWml4TDRWNXZv?=
 =?utf-8?B?TkovMENYSzVUY1hCWWpGdUNyUlNaZllSWW84Q2hCRGxCS3FlbUxMZTRnUVdz?=
 =?utf-8?B?MDdsbllOQndHLzZUcTVUbGNlaGpyTmJhZE0xNWwvcDlER1ZCQTc3RVVEMWFK?=
 =?utf-8?B?OFcvSHFTWWVmODlYUmtJNHRxZThuNnRsZTBUVGYrREo2WFhaLzJ0SXRTVTM2?=
 =?utf-8?B?QU9Hc3BnMkZFcXA4Y0JScnhGeTBTb3laUXViZFg3T0VWZVo5cDdlNHJlQUtG?=
 =?utf-8?B?aEFOWHVBZldia2pPVmJNcjRVbWlYSGFna3NKNHJwL0tmdFZ4Q1dwUDNvN0FF?=
 =?utf-8?B?bnROWTBxMUxscW5ibTVXdTNTT3VFUjUzSklsOUlYSld1blgxa3JLY0s2d2cw?=
 =?utf-8?B?a0IyMWlWWkVuU2NhWC82dUpKZ0xsVHYzSEdwY0oyeE5XRG9qVkFGdVBXdTdD?=
 =?utf-8?B?dDFZY0d0dGtsUjNvdmhReDdXT004YkZOTm8rZXpRa3hNanFrV2JIVlFQTTR6?=
 =?utf-8?B?U1l1K0VCMUxnZi9IZ1ZrMEJ6S0lHd2x0bmg1SkJUS0pOY1FGWFVnYU96a0Vi?=
 =?utf-8?B?N2hUTEh4N0JKRzhqWDVHMTlYV0VLLzJ6TGdNaFNia1RQRWp4SHZlNk5kTVBo?=
 =?utf-8?B?M1Zta0dBOTRzUDEyTHB0emhBY1AwczMyNW5CVC9kQUovUWpMb05yVFl0bm5I?=
 =?utf-8?B?M3Y1Y0lrNEQvaDhYa3RlSUlnZGpTMmZzVHVoenljc0JtNVlRRXZReENxZG9Q?=
 =?utf-8?B?WklGYjRKV0NsRHA4alFQbjM1QkFJMEY3MG5wc3dGNkFrYXY0NjNOSEU2VEp4?=
 =?utf-8?B?R0pmM2FrZytCUjhoNkNPcXovRzlDZVZDOUV1dENUcmVpYlVsWm1vSlcyQUto?=
 =?utf-8?B?aUllL0VvUGVyTmFiZ0szVTNmRzFhekVrRjN5RVV4NDN0azdVeGt4RE5XS0VH?=
 =?utf-8?B?UTg4MjdqbjJOcmllWTRhRzFxcUdBajUvdzI3RzhZZkQ0aFl0dVkrMUhnak1o?=
 =?utf-8?B?RStJMWgyQzhBbmpvMmdJcjc3V2QrcUZvZTRhNlBvaTZaNjZITmNLbW5UYm1r?=
 =?utf-8?B?MHZpN3duVjA5Nk40K1dueXlTeEdNQU4ybnRmRVkrTE9qenFzOURQVlhZb2tl?=
 =?utf-8?B?a1ZBd3d0dzFhZ3dNYmxTOG5jSVZRMkxuOXYybFU4L3RWRmJhVjFMODNFTHo1?=
 =?utf-8?B?eWlyNHZkbm9BYkI0K0tFUVV6RHNOOGVsUGlkZktQQVRFekZHRm5UemZuZUZi?=
 =?utf-8?B?NFhXNW9kaDRPZDFRK3N6ZDhsejQvWjlhZGQ5SGZPY0YwSkVZZUVYclZBUTFE?=
 =?utf-8?B?bXczN0hsRDhWS2FJN0ozUnlZQWZBZjg4WWVwdjBTKzgzUEozQlN6S2R6N3ho?=
 =?utf-8?B?Rkx3NkpycHNrbEpKUVRPUXJqQ0puTzlHeG94N3ROUjMrTDloSk5BQnZPdWtK?=
 =?utf-8?B?Zk95V0JVSU1zdXZaUnNKcWV0K1I4OGtRMy9KVHptdnkrS2cyV0thOE9wL0J2?=
 =?utf-8?B?WEhscXhVUjhEcENoYnVIMHJSSE5KcUxhUWRUSTJxTEpmRnJCMmgzekRtVzRB?=
 =?utf-8?B?aEZwZ0dQSFRHK2VOODQwQmxKaDdVMXB1dnp3Q0RSWUpuWStJWWtmRFhXQk1R?=
 =?utf-8?Q?YUBIp1zRCBol7KTcXQSEVCtC7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4r7yRGDyUQRQeuqQrj9VM+2+MZ5GnVIjGupxe7yvxIFSZFKBppo1CgDoQGeNr1Kkxs1ZW/aEXrDo4n4zBQ1of55h91FT5sGpHn5u+o2WfOU/N3Id9zWjrsii0Oqox3mbSC/HIwn/L+w8Tmn4d8QyQvFr3WHFIPcBEXnjRXcFntiQrGD4IY0YzWbZBetGWszk51VAReIyd8KfDyJgq7wVzGnxCezmEHsOtzCxDwnF3O1/Fdr09AFcEzd6qrdwwJ2GRcPZkbIJmhxW4R7STiqtv8umauh0Z0blSsJz3uJvfweA6dvRr4nroPYbIY/ZdLesHu8tg8ZqXjJeUZqq5ApufBTEOOQWABxjNve6PsM9qASFpdaoO8N/SZyYXLQBMu/2sdmFjfP4CvenmD4BDSWcA9u7K+GVk6NrAVIk7Oyix2Od0SRCNFIKw1sKFHxuGem1KgtVine4keqZU9LCW0dc6o2DMNxlLZ/tOC6nazKHTU1+Vw4dZPKtd0QxRWPtUwwZ6Z/RWXGWQd/T9APvVLoqiIZqGWHymZ02e0CEcxBjZW+zA9xfjOTClyvnKgJxk8/TotA86VrT8FmYp2cVsc8tksost374DMfi+ppVLm9Y0ZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd15c72-8c25-42c2-975d-08ddaa9062b9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 15:38:46.7655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOtLmeYSFPm0i5gqxtN6cwnkitVTy2rOvrf0pShm0dR/keKwEyen/8tLiiNH2Wv0MgaZUWmAV16AuuXAxyqO7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130113
X-Proofpoint-GUID: fMdOQwiw0605z0pJ8uOl7wOEmEX1u6eC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDExNCBTYWx0ZWRfX4nF8YEM3GU3g CCzviQVBrcc+irx2q7BUjFVZbgncPFYTTGowHHK63c8Due1Rnt624fP+odDNyyIYHHVgQ5rb1oq bQBQz2Q7Idde00LhaiO2SBKq4YCrriQYPU58ju+tA2yDu/UA9afZwtImZk61+LD7vixQyngvCTY
 Zsz0IqA5eyLYwQCy7474ZdenmEK4qB0Yuc/BF4q84wuN+lC8p1ekCy6o11dokBzLDymb90KlHu9 DynlC5Fgfji5y4KAMzT83APMfTgmQlk4fyrSu0c2ogE8deZg+x6OE0abH61wKMJIvqNE9llfA1c PrM0wRA6m2zHqu0kF3BLVI5PXhClDyQpLOEpEHPGVAD+HoxSl1yx8JFbky0ufnjC+5izcgf0WSJ
 mo2iLGPc9ZcrGT/otnbt8HHGvv0u2HcZxE5Ogs8WVxAjAboKK2UAecNyoU/FnkudmmgxVtCd
X-Proofpoint-ORIG-GUID: fMdOQwiw0605z0pJ8uOl7wOEmEX1u6eC
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=684c460c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=adif-WJBl7Lf3Sc4B1EA:9 a=QEXdDO2ut3YA:10

On 6/13/25 11:23 AM, Benjamin Coddington wrote:
> On 13 Jun 2025, at 10:56, Chuck Lever wrote:
> 
>> On 6/13/25 7:33 AM, Benjamin Coddington wrote:
>>> We don't consider it acceptable to allow known defects to persist in our
>>> products just because they are bleeding edge.
>>
>> I'm not letting this issue persist. Proper testing takes time.
>>
>> The patch description and discussion around this change did not include
>> any information about its pervasiveness and only a little about its
>> severity. I used my best judgement and followed my usual rules, which
>> are:
>>
>> 1. Crashers, data corrupters, and security bugs with public bug reports
>>    and confirmed fix effectiveness go in as quickly as we can test.
>>    Note well that we have to balance the risk of introducing regressions
>>    in this case, since going in quickly means the fix lacks significant
>>    test experience.
>>
>> 1a. Rashes and bug bites require application of topical hydrocortisone.
> 
> :) no rash here, this response is very soothing.
> 
>> 2. Patches sit in nfsd-testing for at least two weeks; better if they
>>    are there for four. I have CI running daily on that branch, and
>>    sometimes it takes a while for a problem to surface and be noticed.
>>
>> 3. Patches should sit in nfsd-next or nfsd-fixes for at least as long
>>    as it takes for them to matriculate into linux-next and fs-next.
>>
>> 4. If the patch fixes an issue that was introduced in the most recent
>>    merge window, it goes in -fixes .
>>
>> 5. If the patch fixes an issue that is already in released kernels
>>    (and we are at rule 5 because the patch does not fix an immediate
>>    issue) then it goes in -next .
>>
>> These evidence-oriented guidelines are in place to ensure that we don't
>> panic and rush commits into the kernel without careful review and
>> testing. There have been plenty of times when a fix that was pushed
>> urgently was not complete or even made things worse. It's a long
>> pipeline on purpose.
> 
> I totally understand, thanks very much for having a set of rules and
> guidelines and even more for taking the time to spell them out here.

Apologies for the length. I wanted to get these out in the open just
so you and others can slap me with a clue bat if I'm doing something
vastly strange or inappropriate.


> I wanted to express that Red Hat does consider all of its releases to be
> important to fix and maintain. I'd like to speak against arguments about fix
> urgency based on distro versions.  I think in this case we innocently crept
> into these arguments as Jeff presented evidence that the problem exists in
> the wild.

I was estimating pervasiveness based on the position of the RHEL 10
distro in its life cycle, nothing more.


>> The issues with this patch were:
>>
>> - It was posted very late in the dev cycle for v6.16. (Jeff's urgent
>>   fixes always seem to happen during -rc7 ;-)
>>
>> - The Fixes: tag refers to a commit that was several releases ago, and
>>   I am not aware of specific reports of anyone hitting a similar issue.
>>
>> - IME, the adoption of enterprise distributions is slow. RHEL 10 is
>>   still only on its GA release. Therefore my estimation is that the
>>   number of potentially impacted customers will be small for some time,
>>   enough time for us to test Jeff's fix appropriately.
> 
> While this is true, I hope we can still treat every release version equally
> /if/ we make any arguments about urgency based on what's currently released
> in a particular distro.  Your point is a good counter-arguement to Jeff's
> assertion that the problem has been widely distributed - but it does start
> to creep into a space which feels like we're treating certain early versions
> of a specific distro differently and didn't sit well for me.  I'd rather not
> have our upstream work or decisions appear to favor a particular distro.

Understood. I hope I convinced you that I was merely making an evidence-
based estimation about the pervasiveness of any problem this patch might
have been attempting to address.

The shorthand term "bleeding edge" was not intended to be disrespectful,
only descriptive.


-- 
Chuck Lever

