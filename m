Return-Path: <linux-nfs+bounces-11064-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1DAA8299A
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 17:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA79F173A4B
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F44025DD18;
	Wed,  9 Apr 2025 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T0xzhyfW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZmeSbKVl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD041E489;
	Wed,  9 Apr 2025 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210856; cv=fail; b=PAGwq0a7j8du24agtIx1UzcZdoqN1XrzekuB2bwRWN9MMSt77daZ+ES4UD+heE93BhLg4dLDOxsSOXoFp8O0b+4NVTfSwTQkPd02uWZWVhBOt1akthdDctIQJWZFkF8nNs6+pa0P6PFGeW00lcOVxWifVLRyCs2iH45g5fky+Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210856; c=relaxed/simple;
	bh=A0uUrPFWCLR/gDVD2s9/cmOwLOcck1E6MiVMlpT0IrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lELhzffiR1x0Ra7xjdO5Jzo1NtocRM8YPakVoo4Kq62Re8m+awtzfbqWgXUBBYWZTUmb4nyYWsfCEodtp8r8BXy0GCu1ysqZaBE2nm41LmvmmgocPG815VyoHk43W53ydSDNvsboketzSphlHnBB1ub3rZje3y1cctYp+q2xryE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T0xzhyfW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZmeSbKVl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539Em6MS013732;
	Wed, 9 Apr 2025 15:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eaGDhg5+OooQ3fgjdW5HVrMP4RK0Wel/HEJ5hWDckSg=; b=
	T0xzhyfWeP4pDMkeP/GvSNrdxZcKRHG6sCvD7/x7Pi2mwYua90uwpi0aH6j4uVPV
	dVWuJAQrs/y4D+q8Je7pLVoChgq0mDmLBUkA+UVWVaIz6i4rgtEDslJv6o0Nt5eq
	rnW7qQtEsu3cPOkQQPO74f8KkoZc0FISorzN8tjzhoXiIa7t450Rqt6f0M0bB6mD
	WPNuldlVHwegLtwE/tDnVW9tznkKyBzkDKVRkkuIJBKXfTmIru9/pvXOJgjDfKH6
	VMRJ12V/cbvu+Jq9lQFciWdGo6ZlXwqhlKTBwDqmiUcZVUrE2tl90AwpubcKWXtu
	/RYyAySEQm1ZSVs9iJWQ8g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tua2yd7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:00:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539DtEK8001375;
	Wed, 9 Apr 2025 15:00:26 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011029.outbound.protection.outlook.com [40.93.12.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyawq4q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:00:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIjxyfX3dJKpU4Eq+b1ByaYY+xQQeykEUABL2gLxftLk/ZWf3EtsVyD5ihfVVwmzByfuyQpCM/lWVMX5FXCsVEYRHG/S+2zxdBW819XbHMM4w/6xPB8oIna2Mjx8sU0G1brg2VVUCHM6m683N0lW0nbWCxcdEbYIg6bwX4o9t1XoJ3f+8XO7kr5VbWOShEv3HGdW2uvsQqV1bSz6QYIIwJcIvooagZHfdTi8c7Dt5PwW8BLRvu3UDDa8C3Fez32cdQIFTTb4E8e8iHlVqkjQ+xibiX34pCZe3IrDmxoKqVMnzm1X56Tj3kcEny4cC6mOr6kckC9V/43zvrD+sUu18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaGDhg5+OooQ3fgjdW5HVrMP4RK0Wel/HEJ5hWDckSg=;
 b=MwD6sc4YfSln0FMpnJqhSgkmHSaWWIOejiVlNZdTdxlIHowwJjF30tdfoPcOnF1yU0wrOve6GCR3WV1FMuRXA5HKYuqnS7FZAUbBAlxtHIBUA4Wed5XmhP6D76ngiJDH7sgiyotn1ozCVIDqomtJVoSOod7sz5JsZhZPn553kL71EDYrULorgAC6fr1hgg9il+EOH80l85A3VWCdiVKuvSbXuavS9wSCQm8jJGcR/CB18zPmYgC3pqLAW7yMSGu4P+F2qRBc1E2gAbIxVrxjYDJHgxWuCdyzwfoEaSxjly598waeIUB4dg4/cUjgUsSUhX5fGNKSPwKmTGKIOhIfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaGDhg5+OooQ3fgjdW5HVrMP4RK0Wel/HEJ5hWDckSg=;
 b=ZmeSbKVlR5cyinyBoen4rG9V9qlLrL5WX6grHPOSNe+1BF6IUuilUFTg5Q6tWWCYyu3F0ZlJzah3rGW5K2I6EuQ/GSu3uE6seGVUEAae1f0WeTrDXtwqzKFLuvw3+Ul5bH07ufPd3UGc5rxifVymQ6O7R5ZVAE07QZDRq5g30v4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4869.namprd10.prod.outlook.com (2603:10b6:408:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 15:00:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 15:00:20 +0000
Message-ID: <d18a4caf-45c4-46a8-81af-400d94f51606@oracle.com>
Date: Wed, 9 Apr 2025 11:00:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] sunrpc: add info about xprt queue times to
 svc_xprt_dequeue tracepoint
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
 <20250409-nfsd-tracepoints-v2-2-cf4e084fdd9c@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250409-nfsd-tracepoints-v2-2-cf4e084fdd9c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f36b09-1693-4d57-1187-08dd77773f61
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?U0ZQc1NUbzgwMUV1STIvYVU2WG5NbTNXQ01QQXhib1ozbkpab2t3QlBoNTZK?=
 =?utf-8?B?OXVkeWl0eDZobXBTOElsU2U3bDRLYjBCWTlXeE1ReDd2SG84R3BZL1cxK01O?=
 =?utf-8?B?a0pGdEZ1Y2g4ZzRpTDBOSXliOGFaWGg5YjdYcnppdDBPRWw1TjYzRThkOFhT?=
 =?utf-8?B?MmwzN3ljVjQxem9xbjQwcEdOc2JkWThoazJxOHVYelRnWW5XS0JnaUE2Qm0y?=
 =?utf-8?B?dmRJTFZ3eTgyMnJyMDluSFZKVlZhd3FoNGkzS1NvQ2pOT0htWEEyV1NUbjhY?=
 =?utf-8?B?bDBxa3RLUVY0YkZSR3MxVm1EQTdycDhiQ0JMUUYyVlFRTTU0eFVWQlJFcEtL?=
 =?utf-8?B?eFl6K1ovc0poWjNhVVlncThLbG9rbWRHVzU2VmxRSVJ5dktQRFhCRERQYlkx?=
 =?utf-8?B?b2ZtUXphNXVNTUZUWFFITldFMmVRV2ExcUhyYm01Z3poN0o5bG5pa1ViV3Vo?=
 =?utf-8?B?T0w2dVhyb2dHQm5qT2taNTk4am9yRk8ySE1PRGJpeHFvNUdsSVdSajZPVnJk?=
 =?utf-8?B?QjZvNUQ3eldVbUk0d3BkM0pvZ29HMTBBYkswN0NobGdaVStXazBqVy90dFRJ?=
 =?utf-8?B?US81VVdzNEc1V0pQR004TW9SSkREUDJnZW1FQlVJbmZKa3cwUlVrMFgyQ2ZC?=
 =?utf-8?B?N1ZTaEZzZWQyOGhXcjR1L042cUQwdW1aaFI0eGVwY3ZlaStVY290c3pxVUtC?=
 =?utf-8?B?L3NzQ2lqWDA1RFY2L2RjY010cERlMDBXR3V5azBHc3RaNjJKck1aektnZFVR?=
 =?utf-8?B?OGd6SXRaUUZPYXdkcTBiWjd5MnVja21CNFRNUXFoMTB6Z2pOTFpRbnh6Wmxl?=
 =?utf-8?B?Z2NTZkxXeVZheG8rQkVLaUV5d3JGQTE2S0YyUVUxWUI4QzFCdmVsU1JLZ3gr?=
 =?utf-8?B?SW4vR2pOTnd3QnpwR2g1Vmc5bzVZQjByUlo2MnhaUjVlNnJUNFdpeVR6SG9p?=
 =?utf-8?B?TEVKYTFVRzZtRlE2dDBPTk1NOGdweVpMbk9JL1VtSWlDN0xZd0pxWkplalBE?=
 =?utf-8?B?UWljV0xHOERSd1kyUHliTFVqOVR2N2xRZG9PU1dtUmViVXd4VkFML1cwcFFo?=
 =?utf-8?B?aXRMemlheHUrUzJuRmg0ZG9oS0dIWmNPSkw5a3VVZ0tCY25vQW1FWS9xU3VD?=
 =?utf-8?B?U1lGRjNCQ0pJWDNYQ3ZFYVJwelJLQnBzcjVGSld5Y29SNzZuYXJKbWNqTFlS?=
 =?utf-8?B?ZTQxdkM2OTRMeXRKVlhFWmJublpRN1dkaHlQR2E2RUNNcmQyVTlqejVTaFpD?=
 =?utf-8?B?N1ZJczNVaHdSaW1QRE9XV1k5bTVubkdrV2FQMHVOYnd4MUp3dVV3ei9EOUxW?=
 =?utf-8?B?Ky9PQkgvNjdaUlpuM0VmTEtDZzhrSmNSMzdCbUVuanErSHhoMGdTcDJqbTZu?=
 =?utf-8?B?QXU1a0pMREhjS2EvL3FPd0JlclBaaGZMVndqcVVQQVdkcVNZQmxkOUJQRmFU?=
 =?utf-8?B?VkI1c0tndWhBdFpGbzhwVzJ2Q2JlYVJsV0JMZ254R2MyY2VpQ3NWL1JOWk9h?=
 =?utf-8?B?OWduUUhxSjJFbm90cDJUM2k3Z3l3Rk1oV0VnUnBZaXFaSnRtNVU5RlAyTFpk?=
 =?utf-8?B?dW5HNEpoNjQvMDh0VmZSdWpCTUFUb01YQ2VwSXpabmh6TUJkSjlrQmtYMDVI?=
 =?utf-8?B?WDRMUHNGRHpLeFlZSmpVNnRRblVxOTV6aTNNMm1yZGFTeVJMVlR2MFZ3UUY1?=
 =?utf-8?B?S3dnQUtwcUs2Vy9KN1YrbjlEYzhCajBpdWNLdFc5ckltZngwdzZaQ28wK0pE?=
 =?utf-8?B?S2svWno2TmMySGJlZjJneUxyR1M5N25oQzNBa0ZrSUM5SnNxaC82UzNhYzJv?=
 =?utf-8?B?MWtUc0NhNDlNY2FxVzRaU2hpU1pDSkFlSUwySHFSbko4amlZTmJwalhLTURI?=
 =?utf-8?Q?pvqJ8PiDkAf+W?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OHdjK3pHNEN0dlM0Rmw0bmZnNnc5Uzgvc0ErQ0RzQ256bTBIZkVhWTZnUzV0?=
 =?utf-8?B?dnNLb29QTzUyY0VDL0FXSHAzc0JYUXBzNU8xaGNaT0lMM29RVHB0VEMyYXpT?=
 =?utf-8?B?akdhRUNqdFRrMmZ3RmlBZFI1L1k0emZVWEFhRFBlQ0dROURubUcrM0dweDNE?=
 =?utf-8?B?V0ErVkFEZmZmL2N4bGQwU0EwYUZFdDRyOG1Lc1RJTGZwQVliT05hNi9xdUFL?=
 =?utf-8?B?Z2NNcGVMVnBSaHVBeDZEaTJGNW5LcVZldURuTU9uU3FhT05ZaHJXZ2NEWkl4?=
 =?utf-8?B?aFBGcjVRdG44NEZ0U21NcncvQVFzNnUrV1NuS2MvUk05RjlqVGthN01kWjJj?=
 =?utf-8?B?RElUaVB6bjZJZ2JJdXlvYkNKOHZtTkRZdk12WlJpVlRlT3dsV3k0TkZmRmFF?=
 =?utf-8?B?eGloa0liK2lSanFIK3RwTHpyTXo3amsra0VmTDI4Zk5mSlY4REJQL1Y0NldE?=
 =?utf-8?B?Z1k4Nlh5OUJKQkc0WUtIOTNwaFFsYzlUK1RVSHRwd2lrc0tLMml5N2owZmEx?=
 =?utf-8?B?am9RaWt6bjJBWWl4bVllblRZUm1YRmF2QWREMWVLR3JmaHdPenFkVlhqTjc1?=
 =?utf-8?B?U2NoTDRJMnBTN09XTmlPUVZGMGNnZjlXN3RpK0JFellpNi85ZlJxcHdKamow?=
 =?utf-8?B?MUhia1JoL1o2UzRINXd1ZDUwb1Jwb3VTa1hzMm83enJNQ3lGanN2aXJJdThY?=
 =?utf-8?B?K3FyS1IybTU3aHF3aW9pRiswdDUrMkh5SURlcGl2YlNWV3hVVkFOYjN2Skp0?=
 =?utf-8?B?VFA2bGNmS0J6aXUyMHNic0RjYk1Oa0w0eW1OYVZpNEJXaStIV0o4djhVd05E?=
 =?utf-8?B?VERRaEY4aG5jaHFDbmJXQXJpTHdxTk41dkpuU0gzOC9vS1k2b1BiY0wwNEtN?=
 =?utf-8?B?UWlpR2dseVJyTHp5ZzVPTjJROFBQUlRsZHJIZjNUdU1NaHI4YXIweEVPQTVT?=
 =?utf-8?B?dkVTUDl6TFM0Q2ZUbFpnRS84QU16dWU4WitPT25ZalNyZUFKalZoMmRvcGV5?=
 =?utf-8?B?YXNpenI2MjdhVytadHFiVGgxOStrTXlteG13Wk9GNUF5R0tvdGRzVGw3Nm10?=
 =?utf-8?B?MWMwZE16RXR6ZTJSR2VtejhpU1pBM2txVHlwdWt2U1NuY3loTnF4eFNaRUpu?=
 =?utf-8?B?dnZpVVNMR0l6dFpyRFpyOWQxajhJTThkM2lRcmRUaWZkZDdLM0xJS0g0Q3pz?=
 =?utf-8?B?RVlyV0RBUnFwSHBkZ1lyRXR3MDJ4NThlT00rbGZvSk1pNG5aaC9iMFVGSE9l?=
 =?utf-8?B?MkFtMFo0NHNmejg5amZPQ040VkdPVmRWMkwydDRaVXRqelhONWRodTBjQVBO?=
 =?utf-8?B?R2tSREp0TTdFR1Nib1hSaDM3aU9JN2NDNjl1ck1mU1N6NWNlS2h4L1VjYmdw?=
 =?utf-8?B?MXlPMDVQSUgvRXFJa2hiSGYwaUZ3L3ZSSzZNYzVGdGtNRmdCVzBNbDRnZ01R?=
 =?utf-8?B?YXpya2lTd3doeE9MQVFYVUxaazZNSHpzZ25sYVF2QlAvOTdFeUdXSmdjN2hV?=
 =?utf-8?B?bGtmT2xXMnN1SWlKQmpNUDVxTmtyNm1MRndrZTkwU0JMcVZ1WmFKcTFuL3Ur?=
 =?utf-8?B?RXhzSUYxeTBpT3RBZ1d4eGJzcHdHbUlNSjlMZDc2R3pEUGpOdnNGdFMxczkx?=
 =?utf-8?B?MlVSbVB2b1N4TU8zK0VqUUlReEJFWU1rajlIdXEyOGVJVFFZM3o2R2lrWXZH?=
 =?utf-8?B?QWREZ08yejNTVG5OWXN6L083MFNzRE1uVWNhVGRYNTFIUjZXaG15eHlqTDBK?=
 =?utf-8?B?K0UwcitRYkF0ZU00Y2luN2VKNm90Ni90L0FTd2xSMUl0MVdqV05YSjFjNEdO?=
 =?utf-8?B?SXZicXB2aGJ6VzhtQUE0STk3NWFIUHJEcnNvekNta2xQKzB6ZEhYRjREeXo3?=
 =?utf-8?B?YzRrRnBtT1MrbnhVemdLRTJHd3JHN0Iyc0ZhemovWGtpSU9LTVZaUEJXVzNE?=
 =?utf-8?B?QTJjVmR2bjB3SklhTmppL1hCL05RRWZBeU1NS2JzbkRmT1dqMjZEcHVQREVy?=
 =?utf-8?B?d3FqOTJOWlFhYzhvSUZWRUVqTTBZOUNQanczeDB3TEdpWTRCbUhnT0FLdUhI?=
 =?utf-8?B?ayszUkU0YTRlbGttS1BNbWhHZUZubUMxL2J1eFJOSnVRR2lxUUpIV1E0cER1?=
 =?utf-8?B?QU5ZUys5dkR5azlaTzUvTnlJWnNWcTBjZmdrYUtGS1NtQ0Y2bU9ZbHZMcUpB?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hosVUypMlO/BSBpGC8jR16TnmSivY/O5ux+KGJZlp5TfiR6IY10VRGvrjDlcElu/UOr2MlvEnA/cPtV6W2DzWt79paiCdcqBzg0dCZCGpRYOnaEsUSxtm5TTtkfKGAq7AT0LhsrW8/Kf9m1BfYNpXzIvnVAR9PLgkMiy9LiAwm08rqcziLvEqrWtyyiTgqsX8fzQ4xubcjxl+Dkfo18IaBd03+LpGi3fJ0Hp/aaoCyRNZXZlj5M6HdbVbDUotsHGRhVMLpo36C3jD2N2bn0ix8KrOFgoZfvGw+KE6uC3RrODPBuA60LfF3t8KS5KxikAKL6KO2Vnf1FD3fnDvpxnY0Gbs2EyijPTlG3iuGi51uCt9VQDmjVPHjPl8HrDJ+pXRGA851y2dxPkEixQhuwaSdfdKnMxrAF0rrCNYB/fJU25PK0onaRLt3Av0YLYtkrZdT528GuH9VCmywS6/5W13mkK3wjU0+FPDnvmlwBimsCRsktA/CwHMTu1O0b9z6qOteTeWDgqsoWbEBIldGP9Fx2zRyxVvpRq24sNfCL7osg/9BgfqgGtpAQPIEFznXOHo13WMcx4BVzEDhnf/TXYfMJ9g/gv/Oic7PztmGFzBPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f36b09-1693-4d57-1187-08dd77773f61
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:00:20.5922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wr8AK14lcLCSYoq0GqmuTAZDCvlmp4KlA92u61V89D1fZ8+rRq7vNZUhradLLLJ5kXNKNza+7ACvAaPozsZ/jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4869
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090094
X-Proofpoint-GUID: uhzXrD9i07RC0WBhzG-sH4cSaNsJIMYn
X-Proofpoint-ORIG-GUID: uhzXrD9i07RC0WBhzG-sH4cSaNsJIMYn

On 4/9/25 10:32 AM, Jeff Layton wrote:
> Currently, this tracepoint displays "wakeup-us", which is the time that
> the woken thread spent sleeping, before dequeueing the next xprt. Add a
> new statistic that shows how long the xprt sat on the queue before being
> serviced.

I don't understand the difference between "waiting on queue" and
"sleeping". When are those two latency measurements not the same?


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/sunrpc/svc_xprt.h |  1 +
>  include/trace/events/sunrpc.h   | 13 +++++++------
>  net/sunrpc/svc_xprt.c           |  1 +
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
> index 72be609525796792274d5b8cb5ff37f73723fc23..369a89aea18618748607ee943247c327bf62c8d5 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -53,6 +53,7 @@ struct svc_xprt {
>  	struct svc_xprt_class	*xpt_class;
>  	const struct svc_xprt_ops *xpt_ops;
>  	struct kref		xpt_ref;
> +	ktime_t			xpt_qtime;
>  	struct list_head	xpt_list;
>  	struct lwq_node		xpt_ready;
>  	unsigned long		xpt_flags;
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> index 5d331383047b79b9f6dcd699c87287453c1a5f49..b5a0f0bc1a3b7cfd90ce0181a8a419db810988bb 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -2040,19 +2040,20 @@ TRACE_EVENT(svc_xprt_dequeue,
>  
>  	TP_STRUCT__entry(
>  		SVC_XPRT_ENDPOINT_FIELDS(rqst->rq_xprt)
> -
>  		__field(unsigned long, wakeup)
> +		__field(unsigned long, qtime)
>  	),
>  
>  	TP_fast_assign(
> -		SVC_XPRT_ENDPOINT_ASSIGNMENTS(rqst->rq_xprt);
> +		ktime_t ktime = ktime_get();
>  
> -		__entry->wakeup = ktime_to_us(ktime_sub(ktime_get(),
> -							rqst->rq_qtime));
> +		SVC_XPRT_ENDPOINT_ASSIGNMENTS(rqst->rq_xprt);
> +		__entry->wakeup = ktime_to_us(ktime_sub(ktime, rqst->rq_qtime));
> +		__entry->qtime = ktime_to_us(ktime_sub(ktime, rqst->rq_xprt->xpt_qtime));
>  	),
>  
> -	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " wakeup-us=%lu",
> -		SVC_XPRT_ENDPOINT_VARARGS, __entry->wakeup)
> +	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " wakeup-us=%lu qtime=%lu",
> +		SVC_XPRT_ENDPOINT_VARARGS, __entry->wakeup, __entry->qtime)
>  );
>  
>  DECLARE_EVENT_CLASS(svc_xprt_event,
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index ae25405d8bd22672a361d1fd3adfdcebb403f90f..32018557797b1f683d8b7259f5fccd029aebcd71 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -488,6 +488,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
>  	pool = svc_pool_for_cpu(xprt->xpt_server);
>  
>  	percpu_counter_inc(&pool->sp_sockets_queued);
> +	xprt->xpt_qtime = ktime_get();
>  	lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
>  
>  	svc_pool_wake_idle_thread(pool);
> 


-- 
Chuck Lever

