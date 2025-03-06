Return-Path: <linux-nfs+bounces-10510-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FCDA54DCE
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 15:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FBB172FB6
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7C1146D59;
	Thu,  6 Mar 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mOJGf0ZL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e8jesxZS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1616DEB3;
	Thu,  6 Mar 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271407; cv=fail; b=Qd7zClf8aYH+21P+9PJ4oCbqQKuTGjHcjTgqQ8M9R6XFNm7KJR/8JnLU5A3c/3icVgTd45YXnhV7sMQcQGmbwgw6g8SiwpH2xkfa0m/INBq13x/2Ie0gp0xfWKh5fPygIMuxC9MNBHhk4rTC+VTbUu7uGr5eDSI9ClL2PDGpdlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271407; c=relaxed/simple;
	bh=ryamD5kMrUbtU+K9VJmodnUmrawd7exegJf+4ZA7UNk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KGK+eIMtTrVcabnD3ezbjVbgcsGwDDYyAi3F0cvYaRP1ks2Edn4ZzzuSrjpnPfyn6wwywE5W7NLnZ607nIT7sqwPeELi/78QR0A4V93sUE0lXj//3fArNfXf4OqkFDNCfaBbkD5CcoQ4C0dTPiqR6IboAYALLpcmwRfAx8wAun4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mOJGf0ZL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e8jesxZS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526AttPV009792;
	Thu, 6 Mar 2025 14:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IzyBoiPZSXjx7o25tYXGt2njMe2WWwj6hcb/O+ZtKGQ=; b=
	mOJGf0ZLJnBfGhVe3oeKoGjF+th6UNCtwnazwUFvXZ9aRC/E50Le9lskuwre9ZYg
	BPpLomJ3qF2UVYDuFkqFhQt/QOv/BL+Q4EW/2JT2Xnh0N4BUO7cfznin02xq+ckD
	Bhxi6hS3+8SiDV/PY0FPEwv1MOVVqq9UDpkcsGVubPWwDJF3V8BF0cQKk2tqRNZc
	yk3xsj/2kT/efMjBC3cwgTD9jBw0KQsWnGrshh+jlXss2FeWnTM2OJ84LrZbydTZ
	4FqFIJXJTUP4qk2tYP3j0zow1KpW162TatzQcW2D/DKQVgMiWA8BQ9p1vixzQcMI
	+3HbVy+h2ZhtFbMHsMBTRQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86t55r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 14:29:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526DV6FF040298;
	Thu, 6 Mar 2025 14:29:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpjf1js-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 14:29:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jnf4gtBYigbIip6O+9m+uOEFVsV3f34RteWBsPh8wLIp/qhfpeOn6WjyXS2nPRIw0sDyVuHhJyCriDMbzkcL9LY3aIX5eor3ATXvQIPLT7fHwnfVtrUFWrjAKNE1x6aMcqAU8Pn1FYWYgjKcH8eI2jpf+NzHy5ahEMCXg9zLQnCm03lc1EOicFMyl7F7Go6S1pJ6aPCFX4aFCi3ElYCumgzVODyH2nhGoVNw/2QxP7ixm08klVBQQIc92W7NtLU7uUbnmhe8af7p9cvFp4YRcA+no4aGpnUWRdcMS7LzyMinDmMdYX+mUkf9VUazE0jNNjnfVZ9X/12xZjo1I0NuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzyBoiPZSXjx7o25tYXGt2njMe2WWwj6hcb/O+ZtKGQ=;
 b=tk1ausTalQOLZ4udQe2lcZpWlPUIIiUqjelvgsNmzmPWfH5das7frnwJgyiDDW82Nei6j/hcN8lzZtNnwMTla0Ev3ltb7mtJwovmE36MwJbuBcAQYLXS5218C0UyRpsoNItfOVlJCPmIuA4dL2gx/jp9kZ2YeMgAwoJcr4cHHx3MtRjVd3IGgpoJVZCuWAxpNY9Umx4J1bV/THusUCPU23Fz8+/DOATZj61V7iXuvJFXWAWe3m+2KAJqd2mCJnWMhOcD/JVy44hISe2EAboT1KhYN5seT6FuBx/DwEoTadnm/zFUStlgtYjMmF8qHypzJ9G/hMaNNVryokNARUrm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzyBoiPZSXjx7o25tYXGt2njMe2WWwj6hcb/O+ZtKGQ=;
 b=e8jesxZS1oJnnCZ2REPDq+8hCjn2DUaHubiB3YNLdLNQAc90DgDHdBNKOg2zewe88GyzxIZ0Cesm3hgRDBBSd7zQbpRmekgwNfawewY1Vzrbq4uYlmHS6UR6A+0+OhwKF6lgsTv2+Pvefh7awxN+bmy73Dw2piBWSS4iGgFFweE=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DM4PR10MB6741.namprd10.prod.outlook.com (2603:10b6:8:10f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 14:29:51 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 14:29:51 +0000
Message-ID: <43efb87e-348c-4ad5-84a1-7e30479264bc@oracle.com>
Date: Thu, 6 Mar 2025 09:29:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nfsd: add some stub tracepoints around key vfs
 functions
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Sargun Dillon <sargun@meta.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org>
 <20250306-nfsd-tracepoints-v1-3-4405bf41b95f@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250306-nfsd-tracepoints-v1-3-4405bf41b95f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:610:b3::24) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|DM4PR10MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d768f70-c27b-414e-5e29-08dd5cbb5af9
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bHdjcVNJeTlzL09VUkl0UjNYQmFtNytWTFhIWU1iaExZUzhjbS9MQm0yRERG?=
 =?utf-8?B?MVFlN0l3ZitobllyLys0Q3NpSFczdi9kU0VTeWlkQjBENXM0NE5hSlhRNmVy?=
 =?utf-8?B?bnBlcE55OXo2TWVzcmJHWHNrSEw2TDlwbFFwR3FPY2JKdWFXeWtZQ0VHdVdT?=
 =?utf-8?B?UWl4eDkrV3dHZDZ6WmJ5dmZhOWkvbFMxL1JmY0x4LzB2N2Z5SmZ4MUZ4WTVL?=
 =?utf-8?B?TlpkVkxraXVYZWMzMjFpWDlPSjRWcll5dW01azNXOHkzaW5oclNtQlEyQWV1?=
 =?utf-8?B?Q2RrKzBid3RtaUxqc0dJSG93K1cyWm40cVRVZ2x2enNyUXloNmU3SlU1amlz?=
 =?utf-8?B?Mis2a0xadVJMNkxZaW9mL1dxNFduQkVFNXorVm9OdG9DUzJlSlNZOXkrU3JV?=
 =?utf-8?B?VjdZQk90S2hXU1FLb0l4bEx5ZVNHV0ZlUXViZFhqdUFvdFp2c0ZJQVBnN3lL?=
 =?utf-8?B?azhEeStSUkFtWXJqNlNRODRha0Q1a3hsUTVSdHlKUmlwZ0QyUnFrcmdablNY?=
 =?utf-8?B?VVZqRkpvVEdRZlM3c0kwdHJCREFVUGNtYjduTUhBUitNdXNMd3BMVDdaTHk5?=
 =?utf-8?B?YmxPUXR5RkRYUlhrYWd1em5nUmRidUdRNHNOZ3VodUpEZ1UwaXJqSUR4eno5?=
 =?utf-8?B?M2ZacGVQMmcyYitKTVFxQkFoNzZZNGtyd21rSkNveW9EOGVSTW5sempBZ0M1?=
 =?utf-8?B?Q0VxWjZxUStoanoxdE5ia25VeUFNM3U1UDZTbG9qRlpPcW0vTjczY2dTcHdx?=
 =?utf-8?B?VEI2Mmh6bXZYZlgxTE9wM1djVGJDblcxZW5hTGtDVGJFWkp6N0JqTjNxNWQr?=
 =?utf-8?B?UUViMU85VDR3U3A1cHUwbGJIaHdPNWRPMkdxZFNqSTZyZVFjNWNPV0ZrcHNS?=
 =?utf-8?B?N2R6VG5pZ1dLK0MzNUF4UC90dkd4S1ZtcEF5dlZ1aVMvQWZYckVLRnNIVWJS?=
 =?utf-8?B?UlN1UldhY0pBTGthN2RwWSsxa1VabjJEaFBEMXU4ZEJBaG90YTc2YWd3VmJZ?=
 =?utf-8?B?TkdwMXdXMWRxK1R1OHFVZVc4dG93QmZydjZvL1RiL01hVlJCSlIzazlRU0pV?=
 =?utf-8?B?Zk04M2FnQmt5QmVMdnp0MEJ6ZFp3Q1IrNHNaRGNOTDhaRmF6WVYxTDhMUVhk?=
 =?utf-8?B?cUo0QXJOS2V5MEdEYW5ieXNhMzNyQnVRU2FtYzdWY1U5S0trclgyR3FMT3li?=
 =?utf-8?B?eHVUeDZITk5qclpsbElBcVdzeEk3M2VHNXFpMVp5STFDZ2ZhVXQwMWRBL1py?=
 =?utf-8?B?U3hkbDBOeFptRlNTbS9CUDlMVXBGZURkM21sN3VGVzVUWlN4aWZoT0d0MWNP?=
 =?utf-8?B?REs3ZzdZeklZbjhseGhEdytyM1kwSi9jMUY2MmVody85Q0xPMUFSUzJkdklM?=
 =?utf-8?B?VHhITmF2UDRsOUxLRXJlbWVwcm01Sm9YdW1DY1hONXNnRUFOWDFPdHk0ZEU4?=
 =?utf-8?B?M292QkhRejgwc2M2KzBUYi9oWWNHVWt3Qk9PcnYxRHp2RjlrMVM5WDU1bGFT?=
 =?utf-8?B?cDAveFVUSWZrNk9VUEVOS1FmS01PK2t0ZWZ6WWtCUjV1Mm42OElyWGZ0Sjd4?=
 =?utf-8?B?OFFYTGtTVHRRc0ZLUmlhdkdhOFBxeXBxUDFRM0wvU051MnBtVnpBU2pzTCtC?=
 =?utf-8?B?MVM2dHhKNHJ3K3JJenBydGVLMk1nOXVCNjlHQVdoamhWMG4yd2RZV3Z3UHFn?=
 =?utf-8?B?Wi84YkVYcEF3cm1QWGJ6c1BtZmlHSlQwVFhwU1JSQ0NhZ1ZkVk12V21UT25l?=
 =?utf-8?B?SDRzRDFuWStzTmc0dFBZdlJFSnNJTFNtU05SZnBJZGh1anV1bVJXTXhJSmF4?=
 =?utf-8?B?QjJNenNVQ3BGcU5lcWJQSzF5bVUwYUIzV21JOGNtOUpZTC9DV2dlb1AzQjIr?=
 =?utf-8?B?b2JSc1FRcEE2Y0JQYk5kOVdQWTRZcndDZjFTN3V3UzZudkMxSkpoUEZXUGFE?=
 =?utf-8?Q?NLOWJzSeF68=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SjhCaVJZYXFQYXFvS3JuZE0waDRxa2lmU1hRQ2p5cjc0V0hRMlNLdHFlVkYz?=
 =?utf-8?B?N1ZpUGZhdkc0dkxmQkN4TSs2ZVp4STluV1puOGVCQWJGNllDc0E5Y2JlQjQz?=
 =?utf-8?B?QWozR3A1M29KQTZaSUFsR0ZXZCtSbjFleVAwbXd0VjNHZ2xmWlE0YytpNGVM?=
 =?utf-8?B?UWFSRlRjRGxPbWJycFhjWCs3L3J0bGFucUFrQ0toZE4yL2JyUUp0Ynk1NEpq?=
 =?utf-8?B?bE8yWkRXd1VDVGhzSi9EUS9VVGlXQ2tMNjFjdm0rL0dDUzdjcDRhZzJxemxO?=
 =?utf-8?B?VzBSSEdOUXV6MFphUDhxV2hjNFFBRG9iL3cyUWxmRWlCRCtDVzcwZDVzemw0?=
 =?utf-8?B?MDhTZkFxOGhqZktsQ2l6MGhNcVo3emFCQXZ2d1hENTg1U0YyRE4velVQekJY?=
 =?utf-8?B?RGdwa1BjU21nUDg0VXlmUEdTdEh6SVBEb0xCeDJFSmxsUDY5cDVVaHhCTEpE?=
 =?utf-8?B?RTBBK2pKOE1YT3kyblpvOThqWU5CdmdWWkVEZlJBYW1HS3BZS1FUTWp1UHE4?=
 =?utf-8?B?blVDdHZzdmdTM2V3VHBxZXo4WlV4NDVTWU03RlRYNGxXKzJIM25sZnZ1Tisw?=
 =?utf-8?B?TTRYL1pubyttNFNtdjRFTUVKK3IwS2g2SXdGMDhIdUxYKzVCaVBLWEpFelN5?=
 =?utf-8?B?YU51dVZETGVvaDl2ZFJpV0dNM0swSlpXdTdzZ2xnUlc1Q3RrTTBrQVBIWDU1?=
 =?utf-8?B?K1loNDhFUmlVZC9iMEdEMFY0VTVGWm9YR3loQ1RFVUNPNjZqeVlKOGNFb0dD?=
 =?utf-8?B?bkdQMkx5ZDNpeG0wdkR4Wk9UUXkwWkhIYVlHbU5lZGRudlo4VlQ0YThaSEFy?=
 =?utf-8?B?RUxtWHV6SEhtSmJsUUExWFphMHZRbTRoRTJYOFVnQ3NZa0FFWWNab2JsYmE2?=
 =?utf-8?B?SlVwYmcwVm95Zk9VNUwwVjBEbTZyanFsSEVCUG1zSHZ5dm9EOHptd0lmcEhM?=
 =?utf-8?B?K3RCbytFYmp5RnRBMUJIaFpYOUwwVlExZ2Fxa3JHb3RJSTNVYjI5azJEMWY3?=
 =?utf-8?B?VE1EVXhNcUE2Z0RGU2d4OTQwYkZqQjNmMjhGWEtheDIyN1RmQUtLMHZHNWR3?=
 =?utf-8?B?UFZ4TUozeEtxUXZyeW9FeUFtaGxzclRQUFNDdDgvd1VISkUybWkrR2FBdFBH?=
 =?utf-8?B?ZVJtZVBwMnk4ajRDbTU2Yllqc2xOZnY1OUhXVlRlR0ZJSUtEK29DMEdUaG0z?=
 =?utf-8?B?K0VtUEduZ2Y5SzdlbkNXbEQ5RVdHQjZKb1pJV1JLVTgxZjF6cXNhQzRZWHpJ?=
 =?utf-8?B?L0NJK1g4N2ZiRzJtOWxJWDJHckRxTTRLelZpTThWVDhEYTZtNEIxdTFjK1V6?=
 =?utf-8?B?bUQ0cEl6QTFkV1drMlM4VXErUHc3Tnd6a2pobkhYN2MzTEtJQ3B4SjJTOFB0?=
 =?utf-8?B?QW90dUxPNVhMczk1aFhBUmgrZGl1cC9xekk2SThTMUNxQkRpT3FkRU50alov?=
 =?utf-8?B?Q1ZUTFBJdFlkeC9hS2EzTzNJOStOaVM4cTB5Rm5tZnJGeHNnRUhiSmo2SHhv?=
 =?utf-8?B?VmJYZ0N4N0YxRCt6Ukd0NXBaOVVkYVZ5NkQxcTJoZitRQ3BTTVBiLzA0YUxu?=
 =?utf-8?B?dnVVQkRzTmNEMzhCaG5oeVlEcHZSUjlCLzZwNFVic1VNREpRdGE1T0FJZGdp?=
 =?utf-8?B?YVdUdmIxNTBUZ3JYVGp6UTg5dGVmbjcwN2NPZnRWNHE0NVBaMkdWNWJZb0c0?=
 =?utf-8?B?anVVNDhQZTZBVndpMDZIeTdmWXptdXRDZXBWblJiOTU0SFpSMGROU3UrOVdY?=
 =?utf-8?B?VnZSNEtySmh5YkRHRnY5bDdFKzM0QlAyak84SEtZL0JiR01BaTJRTytCSEdE?=
 =?utf-8?B?QzNUdDdNTVEwY2FITENQZzJWTzJZWkpVTEthWHpLUGFPQ1NTVVlvc1J4WkJt?=
 =?utf-8?B?ZERzOGtnVzcwUUloemxwcWIvWWwxU1NvSXJ4NnJ1M2RNUlBGdGU1Mi85amYx?=
 =?utf-8?B?R015ZXJpUlhudHdoNkRZaHhGVjJwd29RUmdYeU9sUHF4ek9Ka0Urc2MrTGsz?=
 =?utf-8?B?VHUrb2lPNC9qOFJ0cGdIbUNValJsZjJKb2ZDY2xRNVV3QUp3QTVlYnpqTm5Z?=
 =?utf-8?B?WjRTWm5ieXRhajdtcFRwdnFxUk91eWZYNTNVVzlGSzZUMUdLb0VrZHdMNXFZ?=
 =?utf-8?Q?9X0JKaNStqcSaNgCMTxemgaI1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QspGN0DgRIAGn9mdITJeeldxHzCsjj7s2hcJa5CK4JLQS5jW1dlB7dpz7HACSSY4bbJNEn7A3w3c0u4PZ52vq0bQ8T/yHNdusMzKSIxnelkhz4heX6u4LB2GaFHOzNHAlrfWhKsbfcFYUiy4PRHaS+Hqx/gfMXxtaJvuXD218qLr3YuV7Q0H+VOo7uE6LR43tY/DcMsDeeQ5iqcZUzAQDwiduJhG58Mny2qe39qzN5EHR8qQX5WwYYMdacj2pmTcDgPd+PLRU9kBhR5oBlfwTAsI6IzG5Vi5Z9KyxymLiStsJO8j7nFawys8knCC6DVp5ZD3U4cK30KINQUhYqRfSQW6zyv14LHByxTSCeuNqi/GikQH8LhjrsXrXKa0sVlqDUxiWzIIq+AjRKNlilaVqmMIgpyeg3EqODvZDgb6CoSdRctNK8akSTqv2oZBHRsAq5OGxVAF7IfKkBJnNWcNR06LVMb9RocY46yM2ilVebmxfud2pzPsRBeLzoPI417Cue4vJpr07m1BAR9BEG78kB3Jl3GFCobYs0TI81BoTSZjFAFLFXKbwCW9ieaV8DaDBa7sePgk4c68z1JjHwWN+vSbTA1XfnLHCp43fjZVYwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d768f70-c27b-414e-5e29-08dd5cbb5af9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 14:29:51.2749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYjGm0w0owUg3hMI+lxhZlirf5azcYAbpe0oCiQJQ5P/l3ME3L4nQIJvl/DXMJk2yiw0QfZNm2G7FnehEUjN2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060110
X-Proofpoint-ORIG-GUID: AZhSE1Ce1cJHczBT86yep48dSDe7ZuxW
X-Proofpoint-GUID: AZhSE1Ce1cJHczBT86yep48dSDe7ZuxW

On 3/6/25 7:38 AM, Jeff Layton wrote:
> Sargun set up kprobes to add some of these tracepoints. Convert them to
> simple static tracepoints. These are pretty sparse for now, but they
> could be expanded in the future as needed.

I have mixed feelings about this.

- Probably tracepoints should replace the existing dprintk call sites.
  dprintk is kind of useless for heavy traffic.

- Seems like other existing tracepoints could report most of the same
  information. fh_verify, for example, has a tracepoint that reports
  the file handle. There's an svc proc tracepoint, and an NFSv4 COMPOUND
  tracepoint that can report XID and procedure.

- If the tracepoint is passed an @rqstp, it should also record the
  nfsd namespace number.

I'd like to know more about what exactly you were hoping to extract,
and which tracepoint(s) were most helpful for you.


> Cc: Sargun Dillon <sargun@meta.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs3proc.c |  3 +++
>  fs/nfsd/nfs4proc.c |  2 ++
>  fs/nfsd/nfsproc.c  |  2 ++
>  fs/nfsd/trace.h    | 35 +++++++++++++++++++++++++++++++++++
>  fs/nfsd/vfs.c      | 26 ++++++++++++++++++++++++++
>  5 files changed, 68 insertions(+)
> 
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 372bdcf5e07a5c835da240ecebb02e3576eb2ca6..2a56cae4c78a7ca66d569637e9f0e7c0fdcfb826 100644
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
> @@ -69,6 +70,8 @@ nfsd3_proc_getattr(struct svc_rqst *rqstp)
>  	struct nfsd_fhandle *argp = rqstp->rq_argp;
>  	struct nfsd3_attrstat *resp = rqstp->rq_resp;
>  
> +	trace_nfsd_getattr(rqstp, &argp->fh);
> +
>  	dprintk("nfsd: GETATTR(3)  %s\n",
>  		SVCFH_fmt(&argp->fh));
>  
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index c20f1abcb94f131b1ec898860ba2c394b22e61e1..87d241ff91920317e0122a58bf0cf71c5b28d264 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -876,6 +876,8 @@ nfsd4_getattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct nfsd4_getattr *getattr = &u->getattr;
>  	__be32 status;
>  
> +	trace_nfsd_getattr(rqstp, &cstate->current_fh);
> +
>  	status = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_NOP);
>  	if (status)
>  		return status;
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 6dda081eb24c00b834ab0965c3a35a12115bceb7..9563372f0826b9580299144069f57664dbd2a079 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -54,6 +54,8 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
>  	struct nfsd_fhandle *argp = rqstp->rq_argp;
>  	struct nfsd_attrstat *resp = rqstp->rq_resp;
>  
> +	trace_nfsd_getattr(rqstp, &argp->fh);
> +
>  	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
>  
>  	fh_copy(&resp->fh, &argp->fh);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 117f7e1fd66a4838a048cc44bd5bf4dd8c6db958..d4a78fe1bab24b594b96cca8611c439da9ed6926 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -2337,6 +2337,41 @@ DEFINE_EVENT(nfsd_copy_async_done_class,		\
>  DEFINE_COPY_ASYNC_DONE_EVENT(done);
>  DEFINE_COPY_ASYNC_DONE_EVENT(cancel);
>  
> +DECLARE_EVENT_CLASS(nfsd_vfs_class,
> +	TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp),
> +	TP_ARGS(rqstp, fhp),
> +	TP_STRUCT__entry(
> +		__field(u32, xid)
> +		__field(u32, fh_hash)
> +	),
> +	TP_fast_assign(
> +		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> +		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
> +	),
> +	TP_printk("xid=0x%08x fh_hash=0x%08x",
> +		  __entry->xid, __entry->fh_hash)
> +);
> +
> +#define DEFINE_NFSD_VFS_EVENT(name)                                        \
> +	DEFINE_EVENT(nfsd_vfs_class, nfsd_##name,                           \
> +		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp), \
> +		     TP_ARGS(rqstp, fhp))
> +
> +DEFINE_NFSD_VFS_EVENT(lookup);
> +DEFINE_NFSD_VFS_EVENT(lookup_dentry);
> +DEFINE_NFSD_VFS_EVENT(create_locked);
> +DEFINE_NFSD_VFS_EVENT(create);
> +DEFINE_NFSD_VFS_EVENT(access);
> +DEFINE_NFSD_VFS_EVENT(create_setattr);
> +DEFINE_NFSD_VFS_EVENT(readlink);
> +DEFINE_NFSD_VFS_EVENT(symlink);
> +DEFINE_NFSD_VFS_EVENT(link);
> +DEFINE_NFSD_VFS_EVENT(rename);
> +DEFINE_NFSD_VFS_EVENT(unlink);
> +DEFINE_NFSD_VFS_EVENT(readdir);
> +DEFINE_NFSD_VFS_EVENT(statfs);
> +DEFINE_NFSD_VFS_EVENT(getattr);
> +
>  #define show_ia_valid_flags(x)					\
>  	__print_flags(x, "|",					\
>  			{ ATTR_MODE, "MODE" },			\
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index d755cc87a8670c491e55194de266d999ba1b337d..772a4d32b09a4bd217a9258ec803c06618cf13c8 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -244,6 +244,8 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	struct dentry		*dentry;
>  	int			host_err;
>  
> +	trace_nfsd_lookup(rqstp, fhp);
> +
>  	dprintk("nfsd: nfsd_lookup(fh %s, %.*s)\n", SVCFH_fmt(fhp), len,name);
>  
>  	dparent = fhp->fh_dentry;
> @@ -313,6 +315,8 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
>  	struct dentry		*dentry;
>  	__be32 err;
>  
> +	trace_nfsd_lookup(rqstp, fhp);
> +
>  	err = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
>  	if (err)
>  		return err;
> @@ -794,6 +798,8 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *suppor
>  	u32			query, result = 0, sresult = 0;
>  	__be32			error;
>  
> +	trace_nfsd_create(rqstp, fhp);
> +
>  	error = fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP);
>  	if (error)
>  		goto out;
> @@ -1401,6 +1407,8 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	struct iattr *iap = attrs->na_iattr;
>  	__be32 status;
>  
> +	trace_nfsd_create_setattr(rqstp, fhp);
> +
>  	/*
>  	 * Mode has already been set by file creation.
>  	 */
> @@ -1467,6 +1475,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	__be32		err;
>  	int		host_err;
>  
> +	trace_nfsd_create_locked(rqstp, fhp);
> +
>  	dentry = fhp->fh_dentry;
>  	dirp = d_inode(dentry);
>  
> @@ -1557,6 +1567,8 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	__be32		err;
>  	int		host_err;
>  
> +	trace_nfsd_create(rqstp, fhp);
> +
>  	if (isdotent(fname, flen))
>  		return nfserr_exist;
>  
> @@ -1609,6 +1621,8 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_fh *fhp, char *buf, int *lenp)
>  	DEFINE_DELAYED_CALL(done);
>  	int len;
>  
> +	trace_nfsd_readlink(rqstp, fhp);
> +
>  	err = fh_verify(rqstp, fhp, S_IFLNK, NFSD_MAY_NOP);
>  	if (unlikely(err))
>  		return err;
> @@ -1657,6 +1671,8 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	__be32		err, cerr;
>  	int		host_err;
>  
> +	trace_nfsd_symlink(rqstp, fhp);
> +
>  	err = nfserr_noent;
>  	if (!flen || path[0] == '\0')
>  		goto out;
> @@ -1725,6 +1741,8 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
>  	__be32		err;
>  	int		host_err;
>  
> +	trace_nfsd_link(rqstp, ffhp);
> +
>  	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_CREATE);
>  	if (err)
>  		goto out;
> @@ -1842,6 +1860,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	int		host_err;
>  	bool		close_cached = false;
>  
> +	trace_nfsd_rename(rqstp, ffhp);
> +
>  	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
>  	if (err)
>  		goto out;
> @@ -2000,6 +2020,8 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
>  	__be32		err;
>  	int		host_err;
>  
> +	trace_nfsd_unlink(rqstp, fhp);
> +
>  	err = nfserr_acces;
>  	if (!flen || isdotent(fname, flen))
>  		goto out;
> @@ -2222,6 +2244,8 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t *offsetp,
>  	loff_t		offset = *offsetp;
>  	int             may_flags = NFSD_MAY_READ;
>  
> +	trace_nfsd_readdir(rqstp, fhp);
> +
>  	err = nfsd_open(rqstp, fhp, S_IFDIR, may_flags, &file);
>  	if (err)
>  		goto out;
> @@ -2288,6 +2312,8 @@ nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat, in
>  {
>  	__be32 err;
>  
> +	trace_nfsd_statfs(rqstp, fhp);
> +
>  	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP | access);
>  	if (!err) {
>  		struct path path = {
> 


-- 
Chuck Lever

