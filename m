Return-Path: <linux-nfs+bounces-13323-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B62FFB167EC
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 22:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D960E5463C5
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 20:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1225A21E0BB;
	Wed, 30 Jul 2025 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eLefAVYP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v3ng+aXV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A1923741;
	Wed, 30 Jul 2025 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753909143; cv=fail; b=OUnq7d2faGjHDeopQP5V3rBnaiLHbVsBPW3rFHvIIz4Iyaswp3J4qJ2G2wXduxc3RMK2J1kuYVmpMJevo1vU5UQNx8YS+Tayrw8hacDmJyyeYft1d/trFbaZoiLnpa6GfwTjrcvxKtqPUdfBfDW2w0TCtxhn2k9/YFQhhUqhKmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753909143; c=relaxed/simple;
	bh=0J4XbOkb1RAMzUyZ11d59iFTR2rwot9rwDy9Y6DCCbQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eryOkrhHrKtGGS0YRpshqd9lh5G9qSMGmciPJhL9dIkGB5T06MvVrqASiTZ5w5m4n46RzOp1B9mrrx2ap3beULZeJyBeHw3Y1q8FdMFbIok8bCqxzdpuZXVcgzUXQQnEpArLuoD1VhFmqnc/HkZDwp6af1btZLfy3I0M649X+qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eLefAVYP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v3ng+aXV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UJC3cc009469;
	Wed, 30 Jul 2025 20:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0zYdqqfxhE45lr+noUdjI9K642jFv6WumbQMEoDo+CQ=; b=
	eLefAVYPYoO1luQHM/Qk0v3Eo9NS2eaU3jYS1fKl/2KH8LrKwRsPN4WM/FrB2XWP
	WyBTCiskenGk4r2+vKXHMFqIEFL8DiWhVGNUUstfg1HSU2I6Tq/NcNFkOescydSh
	6nDhYHfbJ0LWj4BNMB3pzbza71LqxXt3sphqOVvbPAsxaXQ2iHsrmErgL/fSLT29
	FunF/W4JQUTolhIyrV5g0VaaOS+xHLxv2Jj7UuvYTO5GjaNTEptbS5X6NYTXm5b1
	fqPHaHHRN3qIQnrsW7XPCcDOjXH/Qh+pB2kWKq9lzWUgfu8J68drzqhmQF+1/8kM
	GiESIU6Qa2hJL4vjCyIq/Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q732up1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 20:58:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UJLes3016708;
	Wed, 30 Jul 2025 20:58:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfj0kgk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 20:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBRAVNtFRpkR2hL6hprGy/REmh1svxrDNL4hCN35pnzN7hSQR3+x+lg5XDOCtBIOuAr7o24Vl0U5GMnneX1ulwIdcnQ1kcQTR28PN03msYDVktVlYPMzMUTqtTEiTzUPHFDk5U9uLHNgaDTvUYRupz256nfhXJDSrXx5CMCblb2PpPYZZIRYWgkEg+7UQZJ47/wJf1DCSMuc9nI+fRRr2dHsASuskeXesMUUEdaA054cxnmJLuqARUwWhVVBDsXiEX/+58gLGCu7K0Ik+InkLKLDR7wyRttzdzb0gz1TLYcnn0YIHa7KOwtpQLKUXmOS08vqD0rYoZRG/Khx68LhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zYdqqfxhE45lr+noUdjI9K642jFv6WumbQMEoDo+CQ=;
 b=kBVCz+ntf0q+UhyG3cJxm26noTHTeYy2hRUM3j7vCu3QacogEFXmxuLGaH6l9NVQn6BBX61GmcRtdQe66HU7ExM9AbXZV4TcInn2SXeKV6G9pxskjFCb+gnBWjl7PcDpbNLtkqOj8tr33WK+vTipntquSMzarHgu3WqTI/hk/k9f69LkuKql+T2/aOO31DlUz9E2CFy2dB9JKLI1OXAk2n17687+m1gpzQjXGuZ0W51X3MRTTmJX3AyS+E4urrMO9IK+hHUWjIF/PALPXM0yMx2LO4zm0H4xshxKNJ+7gZUWI2vEL3pE+q/cF63DuNnngRDmP2Ls/5kNB/hlb4c41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zYdqqfxhE45lr+noUdjI9K642jFv6WumbQMEoDo+CQ=;
 b=v3ng+aXVI73FZdhJ2Z8xdbihBe6JE/HmzdL98KOl0itvk77m6bXJSlAvxHmE7uu6q78fkYrBJuQDaQm0FxdekCKNr2XhqrWoUmQYNCcPvsqQImc92WB0+OzYgFB6niUtUq0SGmQ0l2dUdz5Q0xgl6PcINgbx12AxaVVn6EBL1nE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7733.namprd10.prod.outlook.com (2603:10b6:a03:57b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 20:58:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 20:58:19 +0000
Message-ID: <8753ffaf-0146-45c6-9189-bd8ea3e74e71@oracle.com>
Date: Wed, 30 Jul 2025 16:58:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sunrpc: fix handling of server side tls alerts
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org,
        trondmy@hammerspace.com, anna.schumaker@oracle.com, hch@lst.de,
        sagi@grimberg.me, kch@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
        netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
        neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com, hare@suse.de,
        horms@kernel.org, kbusch@kernel.org
References: <20250730200835.80605-1-okorniev@redhat.com>
 <20250730200835.80605-2-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250730200835.80605-2-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:610:75::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c3e023-477b-4348-d431-08ddcfabcff0
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M2JaNWtadFJaTXB6aVdxcEhBZ3d4b3l2Y0g4R2dnWWhHRkpscElIZ1o1RDRJ?=
 =?utf-8?B?UHUwSURPK3cyNlkrYTk0OFZmamczMUtnRjhwa2lHTFhkSDRBS2VYZktTbmtC?=
 =?utf-8?B?UnZXanJSRGdMUnB4eG5mdEhXQlk3blpIa2k1OUZuZTkrRmIvUGtWa25JQ29T?=
 =?utf-8?B?MXNoTTBZYmEzYUtIUkRXQXpPOXozbHN0dWVjQ0VDOUxYMW1iSmZ6dTNGdmhv?=
 =?utf-8?B?TWNFTkd5VmpVZk9QeURhaVF2NUo4MXdmT2lMQ0NiUUpicWxBeHp5M3pqTkRE?=
 =?utf-8?B?bEZrM0toaXduL2ZYYUFFL2lnNklZOGhFUWF4MFZ1TGtSd0k1UjZ2QjFxNXhW?=
 =?utf-8?B?WFVBditPUnN3WDl4aHRuOVFVYS9BcnJiNm0wcjdqeWFrU0p0OVhvcUhZSzBh?=
 =?utf-8?B?ckpSYnFiejhLMVpkTmJGOTJZaFJNVStlNHdXSmd4Y01ST0h1TzJvY2RSd3B4?=
 =?utf-8?B?OExlaEZvVnJ6TlE3Q1NJSmtheUs1RlFFWVNIOEk2SDBhVlZEUFZ0aTM0RnZL?=
 =?utf-8?B?RXpnR0JyR2lWZ1craTZxcEQrdUloWXI4OUVOdlpQMU4zdUcrVjBxR0ZZNmFj?=
 =?utf-8?B?WHZGM1V6clYwU3Exa2dXY3pFNHJ3UnJXbUY4WUU3MGdNTTEvU3k4d1NHV1Ir?=
 =?utf-8?B?c01DbDFtSXd1UXh4NmVIUTU1amRMZ2Zvc1VlNHFWRWhCYm1tUGdEMlYwNVJM?=
 =?utf-8?B?RzRqcVB6NjRFNzIvTHFIM3BlQmthbjgzQ1pHdHhaZ0xHaS9qaW5FSlpVSE5x?=
 =?utf-8?B?alZJbW43M2lzMUlUTlpoMVRHbG1vSWxQTzQrNmhSQzRMV2YrU2NCYUZvYmZx?=
 =?utf-8?B?MVJLcFhmQSt2dUdsck4vc3RkTVRWTWczaTR4ZjN0YUZQbnIybXM0S3FkSDNC?=
 =?utf-8?B?UVo1bkE5RkwzQUR5K3NLbmpzQWlmZE5WKzFJYVBReHBPaXVGdkxBWG1tZFdw?=
 =?utf-8?B?dlAwYTB4bUdlUHJvMnorWVovZ2t3dFRGakNMVlZOT05mLzh5T2VKU2JtUERs?=
 =?utf-8?B?Q0ZWYjEwRWdDMXdOMXBVSGk5M0xqZHdrS1dHVkNpWGNKR0ZJNEg0ZGNHWVIy?=
 =?utf-8?B?NzN4bWhLMXlmbGZFOXZ3ZDFWYnBJZzZLK3Z2eTIrSTB4RVBYNzhNbzFoVW1J?=
 =?utf-8?B?YmxjM0hnM3VXME52ejhXR0VRQVZESUdVL2ZTNThnOVA3MW9UdE1qNDBlbmdu?=
 =?utf-8?B?ODI0NVpuWTkzeDFTRlpMb1dQWG1rc0FkbnU4QVFQc0xuZWF6cVl1TXMreldu?=
 =?utf-8?B?R2JyY0JHd1dKb1JFUm5WVVFzTFRQQ3dCNG5wQ1VyUXVRYWxCcWQ5a3o4RGxI?=
 =?utf-8?B?SzVPa2JsaHQwSHZoQ3ZWM1IvVWd1RUd6UlFseVlGejA2aXY3NS96UjJnREZU?=
 =?utf-8?B?c0lsOGhrVDVlcjlHb0dpQTN2SnNUcERQRlh5OHQyKzI0RjRCTkV3RW1DU0t0?=
 =?utf-8?B?Z3VQOGFIaDhSeXppazRPNWh1VHVrQXpUZFk2cUNnRnRXMHltSWpPYWlGdkV5?=
 =?utf-8?B?Mm9OQ0ZDL3U4UkZ4VFJ2alVxUnJlTzEzQWZOMUdKOElwaW80WFdlMG9neTFh?=
 =?utf-8?B?Mnk2R2tDM3lJb0VnUHg5dkl5R0hGbXJaL1c5WFdIQWk0L2lmTjhPMDU1OUdy?=
 =?utf-8?B?RkNhYW5HK2ROZnczMTFxNGdkNDkrTXZXWVdPYlhYWXFDclVWY1pwQkZnc25I?=
 =?utf-8?B?d3hHNCt6SGVuSHB3Z0xoblo3Wmx5blJxRmY4UzVFeDVkWld3ZkJhUTVYdkZu?=
 =?utf-8?B?NFh4MzRQbWdyTFF5a2FaUEtwejhYYUNQbUozL1FBWmhvenNnRGt2Qkl2T0J3?=
 =?utf-8?B?RlFLNXJFUCszU01kMXcvSTNCbWZhZExlMnpFSGUxRjdlcjM1WkJHUXYxczFX?=
 =?utf-8?B?bk9yVzdGN0l3UzBsVU1QM0xyQmFhcElLdERPZGFnQ2hMaUlTcVVEdFRVV050?=
 =?utf-8?B?SHRmRVB1MmpQOGR1amdKY29oQlZBb1A0RVF4bk5VNFN0b1NHL0tObGppcW1L?=
 =?utf-8?B?dkJyMmlBZHRRPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UjBmZTkxSkxTeDE1K3QwQ2o2U1l4ZzM1T3RIOExHTFk5bWl6M2tsTmp4WGtE?=
 =?utf-8?B?MjEwQmhhNDVRMmVlTUxXeksyNDh5NzU0cjVTRDA0WE5Sc2x6Y0hYZ2lRMk9I?=
 =?utf-8?B?WUc5T3ZKWWp3bXU0eHdURUdROHlHZlVnVlZocXZqR3NvUG1oSERNWTRjUWxX?=
 =?utf-8?B?RzZQakZ0U09MZ1VvZ0dXdDhpbXptc3RSbGlOSkpYMFRHbXJOS1dWSm5BVFZj?=
 =?utf-8?B?dkl6WlE1K1pzWEVLTEZtd084QWtvNk16cVV0OURhVGFuaTJnckJ3TTVXUVFv?=
 =?utf-8?B?YXZaMHV5WTJoTWt6Y0lTK3FaRStHelY1R1hveVZQZW9HY0FRazZSTWJuU2My?=
 =?utf-8?B?UDgvZkxKU2hGcjA1dW1mZ0NtS2twcWpmNXlFUVVBSGRHalc2UE55V1FRdDh3?=
 =?utf-8?B?bDNzcGxlTEtPcmx5MlBLTDNYQXkzQ3M3Y0JlUEpRQUR0R21BWjRTMzR5SVI1?=
 =?utf-8?B?LzVQOGljaytCSjRBdmhmdWNpUEZzeTNFSTI5UWNSalVESi9TSWJGTk51WXdC?=
 =?utf-8?B?UE1EakNkbGVWZm54OGc3emNYbC9kdjhwakZHU2V2cnRuY3pVYW4ydDZSenJX?=
 =?utf-8?B?eDl4TGJjZ0Zab1FMb2RFSm9rbVpuQlptZktwYXRCQzBhcUFyQ3EwbC9Jc1pQ?=
 =?utf-8?B?d0NnOTJVdEI0V2hYTEJ5d3RacWhVdWZtV2Eyazh6MnFlU0FRczFGMC9QcFJ5?=
 =?utf-8?B?Z2c3dVNycGJmMzh0NjRRQmx3MVVQWEtJNkhDYkdPcWo4eFViWFZ5MW9Pbjh5?=
 =?utf-8?B?NnMwZ245SVo1MUlUdmFwVDBBMFV0QXdHTDV0ZnVRMngrWUVIQXlaa3JWVm82?=
 =?utf-8?B?cEtMdlpEdnBnVkVMY0ZONHRtTnZ5L1VaQk9QSDcrZ1I2Y3dnR2VmM0NYRXgz?=
 =?utf-8?B?UGxkMVduYklqZG5HcDFsQjgvQ2tFMkZhSEFkMEh0MjRFaEtPOFMvZW9VS1Fm?=
 =?utf-8?B?QjR3WlZXTk44NVJGU3VKZG0rV2R2Z2E1M29FSUMvNTU5UVJsYTVMVE9YRXZP?=
 =?utf-8?B?a0dsaEhKdm81dTFOTzVsZGY1WmljdEc0WGVVdi9oaHEvL3ZoQm10dkh1b1R4?=
 =?utf-8?B?L0lrQWxIdUc3NEJLbThrRDh1bXdib3VETWVmYnJKdlhJMnVHN25CdmZSc3Jl?=
 =?utf-8?B?SkZudzNzaE5iVkNMS1VlaGl5ZUJ1aDNoaU9tbTR3dnhoNXl4V3p3VExPdS9l?=
 =?utf-8?B?bFVGZ0dNR2lmT2Q0SndSTVdHdlVvU00xZjZmRE56ekxDb2pXM1NydXFObVlQ?=
 =?utf-8?B?dzE1RGIwRjd2bjJGc1dFWnBLeng1UWRuMU5UaGtCajhRU0pTOUloS0ZhUEZO?=
 =?utf-8?B?RTRsUnVrT3hTVllnWk94M0ZTT1ZmekxYVVplL0R2L0hGVE10QllUY2tPajZ3?=
 =?utf-8?B?ZnFSYWs5OVluSGkrNUlwaEFyYmtqMERNYWNaZS9VMUJvOFpScmNFeTM4QU9x?=
 =?utf-8?B?L3VnTjA4TVY4dVp1VWUxQjRkcEhGbU51L0h3UWF3YmdKVGV0cU1qNUJSZ0cv?=
 =?utf-8?B?SzEvOG1uVzZEZnBlS0o5ejZTWFQyRXpibnRBako1MjN4WTZESGZOQU81akkx?=
 =?utf-8?B?akFjRTJ3N1c3blAwbWpWM3gwcFpBSnVnaVlvTnI2bmovamc4b08vcjJvODBn?=
 =?utf-8?B?MmdSMmc3c0dlWklialkrRVpadHFqWVhBQ3lVcmU3TXRHK3JwYWxWQ09WRzBQ?=
 =?utf-8?B?T3RPYnEySVlpNVJrOHZTeU5DNi9GUVdIdnhqRDB6NkY4eGhzOVBuRmJaaFNy?=
 =?utf-8?B?eU5BZDBuUVRmQTdRdFYvbHpGMjRTejRhOWZ4bklmTUR4dE01SEUrQWpicW1Q?=
 =?utf-8?B?UUZtY2IxcXM0aXEzdXpwdUFPRWRwcTNpWkoyNFk4NEw1elNaTVFWOExUdUZR?=
 =?utf-8?B?Q0xSRm41NHJuaG05RkwwTHZLZGh3UGU0QXMxb1ZzbGJUTmZQWmJORUVXdGw0?=
 =?utf-8?B?dTYxb0RLN080SHQ2MkNMUmsySDFXdWxQaWxqSERTSFdzT2dpM2QxZlV2SEMz?=
 =?utf-8?B?VGRzckpNbHNSYXlMTURxdUxIamdzWHgzeTRDYkVwanBoZjNEZjFLTEhLam1K?=
 =?utf-8?B?cWdONVQwTE5WZmZya0VFUkkxMzJSRnBTdk5hV0tuNW55ZnZsM0x3ajRRRkpW?=
 =?utf-8?Q?aDUVq4DHNuQtK+Ecexxu1UVpS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZLNJKio9F1mO88edw9T6vMC5/b4BEm3GhDuU4mL9gC5ao2efaGpyOcWKCBKZXwJsX4dUuhXFe5pe2EgrD8Zi4sLZ+QakIxV94SRqlrAliMJVDrL2eb0pfGETUc7/kxIqv6POqwiI5VQsJn6bU7Xigp3cEJhJ8Gojl8ybulnq5axS2LAMNnra0z6taSExxQhhPkxqbxq8gmqG6oPVPBIcP+0FLPPSIy2cekST9CIgiZSzv1+FStMrMVdgK4JU7/f5X6eAiTmYD1YuShHFP0zszE913Qqf/bKnuXFK+m6oWwgPqSE8stOHOM0j7iNvdK6zcWdWu3+d5XOQWutkSEZYxVks5PSFG+aBYuM5R1lZBxpVb24FIIpzaxQjj8QYZEZ5WBjnUXUgkL7+K1nzpvs+L5P9nWcDvCyg35rSiwTbx5G9TU5DLfaKT7gJQjMQ5DoWByFOMwU090B7tmfS6YqRbINEt+QVBj7xv7TvMGD7/EOh8UGhjQzDz72y7O8k+xnYHTXbBrsetG0uEK0yn4j1l4p1HOoTMnIikWR0QWtYONpY1Zbkrln1HhBlsNiG/my7OsqhoTWQGut0ZYzbQUcUEtd3GfnVxmOTKN29fT7gKh0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c3e023-477b-4348-d431-08ddcfabcff0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:58:19.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsjoUiXbRIZPTHf/ZlgRJHfqTdoklUTpsjlwCGN5sRxhz4BRif7soOtztSRGYC/iBMIIwzohLrTjZjHykvDaOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_06,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507300154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE1NCBTYWx0ZWRfX3TsN6cVxySyM
 uDQcRNY1sVtGtGoARL3F9p7E7lhMMlfQNaSx51Yz9cnlFjul8h7KkIxtA8VDfq5x8D6DB48bVvG
 ba+ddSaSs2G1UgJBCPhcA8n3uUXqkx/Ky/qQKMnoMTvbG66w/CplMn8MiVlLWf1aQzxnKo+v4/h
 wAL6BTMh4IRC3xUJBKOMdZpBXThEPsxwYfFBND9NrcQ2w79jF0Cp9qyVmV2+a+tbT7AFINSLNjo
 FrwCvPMeUo1toFAYUuDiKh7ztqK3YBvrv1/+kFc96vV1b8edxVO0isef+04MnNENyPvCvP2YUjn
 MKNPckMmg2I47k2VpNnCgkVJyxKqMktBL9DgS3wZSf6jOyRUymX1Ghj9G0WGTnNhVwKMAvWwXqj
 ZBq3XeGo5W1FpVDwuNcs8iMP5ejymnPgss7MeZRgKUSfpzoTZAdUoen5dphhfRCvtOzVf8UR
X-Authority-Analysis: v=2.4 cv=ZO3XmW7b c=1 sm=1 tr=0 ts=688a8770 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=SEtKQCMJAAAA:8
 a=SUf_EqxKJVXSl-XH6VAA:9 a=QEXdDO2ut3YA:10 a=kyTSok1ft720jgMXX5-3:22 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: Zb7APkcHMOvNCpiQD74V07VvmLTbjHsA
X-Proofpoint-ORIG-GUID: Zb7APkcHMOvNCpiQD74V07VvmLTbjHsA

On 7/30/25 4:08 PM, Olga Kornievskaia wrote:
> Scott Mayhew discovered a security exploit in NFS over TLS in
> tls_alert_recv() due to its assumption it can read data from
> the msg iterator's kvec..
> 
> kTLS implementation splits TLS non-data record payload between
> the control message buffer (which includes the type such as TLS
> aler or TLS cipher change) and the rest of the payload (say TLS
> alert's level/description) which goes into the msg payload buffer.
> 
> This patch proposes to rework how control messages are setup and
> used by sock_recvmsg().
> 
> If no control message structure is setup, kTLS layer will read and
> process TLS data record types. As soon as it encounters a TLS control
> message, it would return an error. At that point, NFS can setup a
> kvec backed msg buffer and read in the control message such as a
> TLS alert. Scott found that msg iterator can advance the kvec
> pointer as a part of the copy process thus we need to revert the
> iterator before calling into the tls_alert_recv.
> 
> Reported-by: Scott Mayhew <smayhew@redhat.com>
> Fixes: 5e052dda121e ("SUNRPC: Recognize control messages in server-side TCP socket code")
> Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
> Suggested-by: Scott Mayhew <smayhew@redhat.com>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  net/sunrpc/svcsock.c | 43 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 46c156b121db..e2c5e0e626f9 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -257,20 +257,47 @@ svc_tcp_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
>  }
>  
>  static int
> -svc_tcp_sock_recv_cmsg(struct svc_sock *svsk, struct msghdr *msg)
> +svc_tcp_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags)
>  {
>  	union {
>  		struct cmsghdr	cmsg;
>  		u8		buf[CMSG_SPACE(sizeof(u8))];
>  	} u;
> -	struct socket *sock = svsk->sk_sock;
> +	u8 alert[2];
> +	struct kvec alert_kvec = {
> +		.iov_base = alert,
> +		.iov_len = sizeof(alert),
> +	};
> +	struct msghdr msg = {
> +		.msg_flags = *msg_flags,
> +		.msg_control = &u,
> +		.msg_controllen = sizeof(u),
> +	};
> +	int ret;
> +
> +	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
> +		      alert_kvec.iov_len);
> +	ret = sock_recvmsg(sock, &msg, MSG_DONTWAIT);
> +	if (ret > 0 &&
> +	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
> +		iov_iter_revert(&msg.msg_iter, ret);
> +		ret = svc_tcp_sock_process_cmsg(sock, &msg, &u.cmsg, -EAGAIN);
> +	}
> +	return ret;
> +}
> +
> +static int
> +svc_tcp_sock_recvmsg(struct svc_sock *svsk, struct msghdr *msg)
> +{
>  	int ret;
> +	struct socket *sock = svsk->sk_sock;
>  
> -	msg->msg_control = &u;
> -	msg->msg_controllen = sizeof(u);
>  	ret = sock_recvmsg(sock, msg, MSG_DONTWAIT);
> -	if (unlikely(msg->msg_controllen != sizeof(u)))
> -		ret = svc_tcp_sock_process_cmsg(sock, msg, &u.cmsg, ret);
> +	if (msg->msg_flags & MSG_CTRUNC) {
> +		msg->msg_flags &= ~(MSG_CTRUNC | MSG_EOR);
> +		if (ret == 0 || ret == -EIO)
> +			ret = svc_tcp_sock_recv_cmsg(sock, &msg->msg_flags);
> +	}
>  	return ret;
>  }
>  
> @@ -321,7 +348,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
>  		iov_iter_advance(&msg.msg_iter, seek);
>  		buflen -= seek;
>  	}
> -	len = svc_tcp_sock_recv_cmsg(svsk, &msg);
> +	len = svc_tcp_sock_recvmsg(svsk, &msg);
>  	if (len > 0)
>  		svc_flush_bvec(bvec, len, seek);
>  
> @@ -1018,7 +1045,7 @@ static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
>  		iov.iov_base = ((char *)&svsk->sk_marker) + svsk->sk_tcplen;
>  		iov.iov_len  = want;
>  		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, want);
> -		len = svc_tcp_sock_recv_cmsg(svsk, &msg);
> +		len = svc_tcp_sock_recvmsg(svsk, &msg);
>  		if (len < 0)
>  			return len;
>  		svsk->sk_tcplen += len;

Fwiw, I've already pulled 1/4 into nfsd-testing. But 4/4 might not apply
until the others are in the tree. We might want these to go through a
single tree.

Or, can we delay 4/4 until 6.18 ?


-- 
Chuck Lever

