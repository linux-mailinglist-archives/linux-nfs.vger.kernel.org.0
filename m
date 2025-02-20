Return-Path: <linux-nfs+bounces-10225-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74271A3E3B5
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 19:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7527042170F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028C8213E87;
	Thu, 20 Feb 2025 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z8odIuCo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZQg3x4yF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7E211A11
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075751; cv=fail; b=kVjw8lnkIW6NnzOPUZV9HOqd+3Jv94ShFjDlRJRcjqWS+Fsa941mmdKuUkmi2GJMB9bYMn5pdoLqAK3Tp2BT6djc+uZt9oyz1Fcm27WvHwSRTrL69zScUBCrJMUa1tE1TXTkhv0oL5UvH4D5XI9eBENLQGB44ZqpdSlq5uiPkHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075751; c=relaxed/simple;
	bh=rk+/Muun6mxXM+ewTyTGtBC7fo9uecU3cRGPJkf2hR4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aHNOHpgCSt4YR+dE+glZqWdSu0Gm7v38es0k0lAtTcMoQuX/z6hRomioP4wAV241Z6HMy0f7Vok75HUVmNVkzo/6qJ2wtGKzL4JyiqVMcEktl6M25G/TGkI3A6O5MFAVW5l7B53TgTCxZIA3nDGwrbGRzrmHmr7rLYyvwxtSarU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z8odIuCo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZQg3x4yF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFN2JL014890;
	Thu, 20 Feb 2025 18:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gjghEKYS8Iot2bf8BN8F4RSZTlIVkgD1w0u+4JKYJIk=; b=
	Z8odIuCofBKhg/WM5B51sVRSepChts8wEuYzDAB4gc/p1qjiuNpZdfpfdwBkjE5k
	m4+l5iumvYhP00o1hvMnXYQPl7qd2A/XY0NYs1VWOa+m/7BBU97XB0QF4N80yxtl
	VNhe/wr4OI4+46WWagywphm9dC76ygxTR9EFOlI9MpGUsTMrPLXUFl6VNhtfBQcd
	QllBtbob8UPEkwx8zw1QuYgd/9eRakwOLzq3ZhejdQPvSjYbJtrdHE3f8nILlAib
	uh47qxTuhk5unzaN91S5eIv4JlFNuwMOqLnYIkGNkOlobHbIyBPLjXNmnStNjN5b
	9tkgzppmCJT4znp9sOhfEw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00kmt5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:22:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KHFhdQ010613;
	Thu, 20 Feb 2025 18:22:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07fbf7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWQQVHa/wV6+bU6TGLstnnEL5L23yu71pS2QPJMUDESTittltg4ziDA5Rr1w+MIrtiDPSzf6xQASed5egYD0KEtsb+Ql9nsgI9CvRRbjndUzzE2nXMi/tGJmUhod/zXUozE5aYFhE2R2UT25MWANjcvG9iZIdGE+3DtkQTZwZrZO+5/b4h4M6h9BEIeNIUxLPM3Y0zMwQYasUIOcOESuz6bllI8ekBn1iBigrviWMu1d/DF9dyWto3+dBbLLBV/w3P+gQ32FKM8KeGNgt3QgtrfExS/q469N8G5WqWKQiIv95RBauVR8PjtpzXkZMr+63hl6yIH5Yfu5lSgRzYD3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjghEKYS8Iot2bf8BN8F4RSZTlIVkgD1w0u+4JKYJIk=;
 b=Vxhu+EP/SPkzcw5NZdhZ9vBRmUVyGZWeuPj7asHE6V1DIndfNHzrjuMQxKY2gFS48bsvQzEGdVbd9ejfcLbn99ARXCHTsN8Blf7u+goKfpMDRv/p2JIFykNa4ycpd7fpokT9CHSltvP1V1jm5OJPbRmnq83NDPjjX44dXQ+pWJrIr2ARVmk+RDvbTxrglF8CDD9c66qsZe5gBrLikEgwzR+lmC+OhDPjlT/HLE1AHdV8FbbOhy3rcP2oue2uFynUoWgJ3//aN/cK+gMGbXTUVoorLsnBTwIGZUAxHsvA5eP4pd0yZOD6yzK9jM7p/I/sVrjNlortCAPb8mv2p+wuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjghEKYS8Iot2bf8BN8F4RSZTlIVkgD1w0u+4JKYJIk=;
 b=ZQg3x4yFPW6390KC1l12w4970UlcMVUEb0hnnevNz84FF9YjGF5SbGHXXxJq4XM+eOrdnfPitZPHpb/rOxPIZPvkG7X3mkkaJWOrnWYBFOf7I4MpPSDYVH3ZZ/5NmTtvjLeGOoAPBLF0cb7fyT1Zw+jez1DmwssXQ0UA3ReXq/E=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CH3PR10MB7562.namprd10.prod.outlook.com (2603:10b6:610:167::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 18:22:18 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 18:22:18 +0000
Message-ID: <80ca64b4-d39b-4bf6-8c9d-f15a43755b0e@oracle.com>
Date: Thu, 20 Feb 2025 13:22:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] nfsd: filecache: various fixes
To: cel@kernel.org, Neil Brown <neilb@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>
References: <20250218153937.6125-1-cel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250218153937.6125-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0279.namprd03.prod.outlook.com
 (2603:10b6:610:e6::14) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CH3PR10MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cd0be2-e4f0-4c6c-7783-08dd51db8235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFY0M2t6WnF6R1VYcjBOTDZDOGhXTEJ6SVpnenhiMkJUS3BKS1VFSzFDWkVQ?=
 =?utf-8?B?VEVUaEpMRjVzWUpJQkY0ODhqNFduTjJGcWltR3pRcnZpN1NUQ0xxUEtYQm5s?=
 =?utf-8?B?ejk2aHNvYWZhaTdZNmJLRFdSdnk0WDU3N0Fuc0ttMXgzVGhXWEdha0REemhG?=
 =?utf-8?B?ZjhldnhsTzFKMnFrb1ZZOUNsRklnN1EyZFRtQjJoQmMwc2JOMHhwMllxV1J2?=
 =?utf-8?B?SVl3RkltR0NYZmNvazRLVFBjd2pLdWxKRnVRQUZVNUtaK0poNUpsQVZ0UURX?=
 =?utf-8?B?OU1YYUVnYXFoelM3U0F5M0NhWjNXTTVya0NRR2NkN0pZMnE4bnYxNGdMSjBm?=
 =?utf-8?B?bFhLSmdtMlpkVUtjUWh0MW1zTmxrRE9PdkxQYjlWM01DRzBTdDVLZFhXNTM4?=
 =?utf-8?B?czlNL1R6ci9ybE8yaUhJK3hyNHV5bzFFZjZpdGw1TzVhdFVyT094bGV1bkY1?=
 =?utf-8?B?V2orZ0Y5L2lxVEkrd3FpbWdZVjNTU1hGWGdLdUdyejBDaHNrcFErYWdkR3Q5?=
 =?utf-8?B?ZTU0T2dxTUxqNCtlejVBakovTlZxcGRleWdIRU9ackc2cWZQaVpFbTlOR2VV?=
 =?utf-8?B?WWpHY3RYUXh5enY3SmRRNFRCT0tUUWs0TmwvYjM5S1laVjBHNmFValhkV0tX?=
 =?utf-8?B?eDVJdnNSNDhkNXhTWGlhN0QyK2N1QlFZQmlJdlc1ZkluQ1Z4WFAzRlVOam9w?=
 =?utf-8?B?UFVUWkswNDVGYlJxQmJzV3E5NVNlOEZpZjdCaTNwMzJUNkY5QjE4czdzNi9F?=
 =?utf-8?B?Qm02cSt4WlpuNVBQQmh4OFM4ZXZSOGNzVjUybWF5ZFNGSjcvMklSdzF1QTlQ?=
 =?utf-8?B?TVVjc2kvenFyeHRlL3lBYy9aZk5Qcko2UFlaUmhnZmpLYmdqYXBDRjh5OE1y?=
 =?utf-8?B?bGZQUUlFSWFjVnVLMUFFUXZKS0FYR3JqOWxBOWN2akJYR0plWVh5RWVJQVNB?=
 =?utf-8?B?bkZtZXJweHRBWGh4dG83YjRac0MvV0kvNWNCN3BaY0RzaWo0VWxHQVYrTFRQ?=
 =?utf-8?B?M0VtZHU0QWtBVTNxNndKTUFaWFcrS2tEdVJSMm1sdHVoenpHWlZQdlRJRmNJ?=
 =?utf-8?B?RGZNbm8zVjZ0YVY1b3FWRHpEMUcxM29vMi9iTllpQUtwanZmOWNPaXBYbTg1?=
 =?utf-8?B?dVR0S1RZeXRxZVhJRGN5K0Q3QmxZVXZFVUVIM2ZQcEREUWw2TGF6SmdyRUpv?=
 =?utf-8?B?TWJ1VzRpeWdsMHNqQUhvV0E3OUtuMEhDdVNPVHJMQmxRa2dWYU43Q2JKakt4?=
 =?utf-8?B?MVhTWHFjay9TeW1nY3ZxbEZpSzgwSFM0RmRYcUh4VHY5NmkyaWE2aVRJVzRT?=
 =?utf-8?B?SUZJT003ZTN2QktlQ0MrTU9RenNYVnVUNkdKTUxPSkxZMW5wNm1rUGtNcDZB?=
 =?utf-8?B?NCtIUFcxSVFxRnJlOEwyakpGaCtmU0t4QkI4MmpHZ2VhVFIwamlDeDFZV1hP?=
 =?utf-8?B?a3pzOWRZZjJVZ2krQmlOYlFZTDcvcTBTcGFocTFOOXkwQWNyZUkvQ2J6eG9W?=
 =?utf-8?B?Q1FycnBnRHdrL2o5d1IvTjAzcWpyVkpERGhzQUt3UURiN0E0NDVPNU13WXJH?=
 =?utf-8?B?SEVXN2hmZFUxMU9VZzQxWnRVbFF1dHpTT3lTcHZMeGd2dVYvNkFsamErMWRM?=
 =?utf-8?B?VU9Gd2Exc2lCTmZQdFVJdXcxR2tRcDdkRDRmcmNEWjVwR2hFQ3hjSnVrUXVF?=
 =?utf-8?B?Ulhickd4Ni9EbkRxbjZ1V0o3ZlJRLzQ1cXdXMERhR2ZTMGhJbmJ1NVIwZmF3?=
 =?utf-8?B?WjJFUVRobzhKSEx6eENsVGlzR1ErME5yU1gzNFZsS21tS2FuVm8xVk96OVNI?=
 =?utf-8?B?WGZ3NzRFSlVidXJENnNiNE43VHhDUTNhTUVEeTNvR09sN1FRaTJ5ZG1NWTNU?=
 =?utf-8?Q?sumo5N5GlM44W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmcvRkNlUFdZcXJDYzdwNzZrWTNJelhDaGhXVndKM2hzZU1MK2NLQUpQdE8y?=
 =?utf-8?B?ZXZ2RE1yVWlwaVY5c0xlbkV5RW5aWXUvdlg5b3pTVWxaeXJvRk5adFpRT2Jq?=
 =?utf-8?B?WDRNa3FxNGhkdEp2Sk0rTDF6dlVRaklwMUMwUG1ka1hzbm9mNmxBbnNqcklX?=
 =?utf-8?B?aE1nSjR4L3I2M3c5WjRwbFpHUUkxVWpkS0tPY0ZtUlgwS1FOTmF2a0FPMUow?=
 =?utf-8?B?aTNjbVR0Qk0ydjRXUm1GVkpxTEVRcUhMWFRXWlNEZmRJK1JVSE9CNHUydXJZ?=
 =?utf-8?B?dFAzdnFsSmFnRUQramViM1k1YkFmTFFaY2NSZjlqWnh0bThrbzNZN2dyTHBY?=
 =?utf-8?B?SmRaL3N0UXZXaEZBemRqQnFqS3ZCaGFndjh1SEJqOWlRVTkrMUhxbVAwSHVn?=
 =?utf-8?B?RjJxUU5rU1BnU0YzZ05xL0IxTitVWVJvMTZ6ZWhEMEpwSDJBK0JsVjhpR2hM?=
 =?utf-8?B?WnUweWo1bWxoUExVakx0VzRWL1N3dVdQZkYxaCt3eGZzWGNBUEF4bGhwc1pH?=
 =?utf-8?B?OE5UZ2pHaEhYRXU0UVBjRmNhWktNbkU1eFJvTkNhRnlZUkxldE9jZysrOTE3?=
 =?utf-8?B?MmlVUXQwTGZ3bjNIS1U0SllGenZDUS9HSmFXTnFJalE4c2FxbnJxTnd3TzVz?=
 =?utf-8?B?Y05Md0pSZWVmN2VWYm5KVXZ5d2VRRStidm9HL3RSWWNsVkp3NUZBcjVYMU5v?=
 =?utf-8?B?MXh6bThvNVNkdmU5TlE0YjFIdEd3ZzEwYWRpeHFaYVN6VGFqbzhUZk5FNHRE?=
 =?utf-8?B?TW5rWWVINDB5NVFUSHRKSGV5SzNwUXNSY0RHaEhSbk82K2dhYk1SZTh4Y0pX?=
 =?utf-8?B?YWxvVEhJSC9OcXJsY3p0ZExPR2V2bnQrODBOeG5OOXM0Uk12K1RoQjh5SHZQ?=
 =?utf-8?B?cGdGcE9wVjRmdSttKzNsS3hCTzJ6NlVMaWsvTElxSjJkZ3FURUtGcVhQUkNW?=
 =?utf-8?B?ZnEvNndtelc5Q1A4a0ZPNlFjMnJjTGgxMmJSOGdhampFd01qVXRmSzQvaE5v?=
 =?utf-8?B?S0Q2c0hXVnlVNnRoajI3WXFoWTJtbHJ0ZUpHSWxTTnRCYzVramJlb01oWCtS?=
 =?utf-8?B?U21tWk9BUUhneXJUR1ZyU1ZlcmNVaE9pK0JkTjBWdGJnVDQ5U0lVSURYTjY5?=
 =?utf-8?B?Q0JuN2M3eTBiNHdwTFkzaUdTU0dTK1pJRmY4M0YzZmlLOWpmeVBuSkRQYVBN?=
 =?utf-8?B?aVZ3U1RXdXpVU213T2dHT2xUUVFoNkhKNUZpdS9UV2Y5N3FUV0h1TjBMOWJn?=
 =?utf-8?B?WWNCdWVQbW1qSWVRd29qUFNuZmxuSzBYWWM5VjNGWHYyY3lYSFkvRjFXSkRG?=
 =?utf-8?B?OGJIRGFBNzYwTE9PZ1NET0UvUjJKeW13RlhFVGdCZGR4TkRKZnhiSDk5UWdo?=
 =?utf-8?B?Ri9rWGpSaFlpNU9SbkZIdlVBU1lXRmx3L0FyUDZBdkliMVBxWnJZU3YwOXhZ?=
 =?utf-8?B?OTFYYmFLaGZaM1JDMmcwWnVtU0ZiWHhkZHp4eXhSd1RuWDREcEhYSWZFdlNv?=
 =?utf-8?B?R3RUanI4c0hESUVJa2xiWFR0M09hbmtvVzBrOVluMFMwcFF6WlhZOWg1OXhI?=
 =?utf-8?B?WkppR2lMRXhucjhkbWdZSHJjd3JZa1VZWDZneGsxcWlIKzVqSXlTT0FHL09B?=
 =?utf-8?B?L3Q4c2krcThGay9ITTJiWFFWMVBKMWV2ZTJZenhib3RQMVl4L3FBN0VkNm00?=
 =?utf-8?B?REQ4YjgzZmhBOW0ySlBjUmxlRkpJSWRpSUdNRWhFQWlrMnJoWTRaZG11V0VB?=
 =?utf-8?B?ZVVCZFZBZEFpNlU0U0FvSVNOZlA0TVhjQmJjWmh3WGNaOTR0VjlNWXdYaUNn?=
 =?utf-8?B?MGhqdy9ja1lqZ2gvbGJLZUdhU1h0Nk1KZzZhRUFXVXFDK2w3eER5cEpxSzJE?=
 =?utf-8?B?ZzF2dGJnRjZ5RVdickozSDc2MmVBVmZJMThJOW8xSmRwRmFJRWtzaUN4UWwv?=
 =?utf-8?B?NW5IcE96Y1lOVktJbGtUVnEweGFyYXMwTUFMM1NocjI3NTdJZ0V3ZHR0T1lM?=
 =?utf-8?B?TWRGR0lCeW1TN2tUWDZmU1N4bUpZSDI1YUVNQlR2b0cvV0hzQ2ZCbTZFb2FM?=
 =?utf-8?B?RjBhMkdhdmtHMDEwQWlCQXJNUStTQm51bFZlbkt2YytETHdmSkhrUzhkTHpw?=
 =?utf-8?B?WC9NNHVwMmdjYUtrYS85blp5U2V4dExNeVBLT3FkMDhxN3lrT25KVFk1QnNw?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oYhEzRv1g+RSZr9dmr6MbBWRbW0+r6lNzwQqlnHd/KuYr+fgICuWh9AkQHTwaeLn2/oXpjwTpAfwpeV3ooVOQWNGy82pofVkDOS1NrYxwFwoktiGtHGvzAh/aP2eHot398bVETt3AeggeyqkTnoO98oyY0dFqn04Q15hvhG1eJ4ELjR/q3WZm/YbI4aCVpCejvIODMX89DUNvqVPNc73UJiGqs0lJ4miW21UdtUL4Mu1ApkgrtJxIPpqJ1erwbp5Ad8i2nnJM9EKFf2Ea6jBfuqN2yERRn8hJvCQQySzhKRoyjd+oOi1kistleQalOcvcIT6LgRpp77BfmvAM+UWGWC3AAUS3ncfQWg+lRjdh9tFyxA8+wNPl3SxCR9Ix/m0GRF0LbZkVzbmCdEeCy0SylFLvHhHqwgY+NHVzesd0XTTHVUFKoDQI1i9CqEg9AwpVkGRnr9RoC4tMiBmQWuVhiNTGWJNN6/i/7tPmrQOKXKvHYtmhrreS7DgyKSMQuWP2ER3GV7GRKqm+IxiLBXtt6p5/uTpWE/s4eDKaYt0I4SwZo7dubm4Ei24BNVtuP9tGoRdxA2RU7ESg4Uwqv3Swls5UBA76mpqAyloq5QkQyU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cd0be2-e4f0-4c6c-7783-08dd51db8235
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:22:18.2006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QV9v/KIrseFUWk2VdxcP3wK63ZhZUiXzq3bOt9jOk1k/bZTiObsNZ+eQ+pPuOe88M7xkCHcT27JSMEp+zwJROQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200127
X-Proofpoint-ORIG-GUID: mzohA_OuZkYoGqM42FoJh5zBOzfC0WGY
X-Proofpoint-GUID: mzohA_OuZkYoGqM42FoJh5zBOzfC0WGY

On 2/18/25 10:39 AM, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Redriving to continue review dialogue:
> 
>> following is my attempt to fix up shrinking and gc of the NFSv3 filecache entries.
>> There series is against nfsd-next.
> 
> https://lore.kernel.org/linux-nfs/20250207051701.3467505-1-neilb@suse.de/

I've pulled this series (with suggested updates) into nfsd-testing to
gain a little more test exposure.


> Changes since original posting:
> - I've assumed the role of shepherd for this series
> - Rebase on the public nfsd-testing branch
> - Remove nfsd_file_laundrette() call from nfsd_file_put() earlier in
>   the series
> - Rework nfsd_file_gc_worker()
> - Clarify one or two commit messages
> 
> Chuck Lever (1):
>   NFSD: Re-organize nfsd_file_gc_worker()
> 
> NeilBrown (6):
>   nfsd: filecache: remove race handling.
>   nfsd: filecache: use nfsd_file_dispose_list() in
>     nfsd_file_close_inode_sync()
>   nfsd: filecache: use list_lru_walk_node() in nfsd_file_gc()
>   nfsd: filecache: introduce NFSD_FILE_RECENT
>   nfsd: filecache: don't repeatedly add/remove files on the lru list
>   nfsd: filecache: drop the list_lru lock during lock gc scans
> 
>  fs/nfsd/filecache.c | 122 ++++++++++++++++++++++++--------------------
>  fs/nfsd/filecache.h |   7 +++
>  fs/nfsd/trace.h     |   3 ++
>  3 files changed, 77 insertions(+), 55 deletions(-)
> 


-- 
Chuck Lever

