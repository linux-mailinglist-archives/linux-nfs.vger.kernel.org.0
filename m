Return-Path: <linux-nfs+bounces-16578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D68C70CDA
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 20:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id AB1EC2A9DF
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 19:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3275D35A92F;
	Wed, 19 Nov 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HByy2ET1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JTRbEy85"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E31243376
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580466; cv=fail; b=uLZmaDdfNZ1RG/iJK94E4w8lAesRg7KhC17eRdcxsSSACGrQT5AQnC7qV59rWMYaWgncSj/seU6dG/47Mg2HW8g0oNTdC2gjhLzEx4Lp/WzTogeLI1u4sVsKQzn85IQIb05jhXwwScSUHR27njBeH+bRaWk5SXomNy7izle3SrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580466; c=relaxed/simple;
	bh=wZK7k4RJHfE8wrgepFUtM3o0hCUaL9VVQBAKBZA5m8M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lXJuJBQtajTJ8gvgZdBoxmFG5KbbG+4Lbe4c/MxI7wcVf8m0uzkGCyFtcZBZ6vExx6nva3JOmioZuwqV5FfJ+r8QK6mhASI9PwmaMf1KjioU59Of6c1dQSYdWjtlIy60u+u1ywfSpw2F9AIYw1RLzoe1b6oQZ19wrw/oow7fvEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HByy2ET1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JTRbEy85; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJJCC7b007645;
	Wed, 19 Nov 2025 19:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1n+Pr2mcYMykyaSK3HRSLNc1GbJqzlWD0gpHNLusM1s=; b=
	HByy2ET1IGuGyjWPv+x7Rxe+YwhY0bZtMq5c/lKipLSD+4C4lun2ssZlgrp2R3yw
	pzI+CmzuOwxgSZCZcltqu8mAJyV7hH/QCHUvjaQu5BLA+oMvwJNhCbdEGM+EdIxz
	PU1p/u5H0Vi7fKaTPmROpU0XV+kvTUmyURvAEc2tPc5Nk+kvs0CFs+MIT+fZHf52
	xI1xyllXnrBvAlWFfAgkMiGDUXHoePKd1VWyGllhNFgV/ZBp22K2KFWBDHhCoZh+
	gb4o0w1o9quEUwWYU2CiaxpmoXMM4c6T9CpK4MwKwmkJI8YS1QkYW4oQycoTlwru
	OnIvc+Iygg/STr9F1ayysw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej907u9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 19:27:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJHsdNr002704;
	Wed, 19 Nov 2025 19:27:32 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyb24cn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 19:27:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZB3qVi4uZztZRCDzBiub4Loq+mEWXwnrR5jg7iM0VtrnBmwsZyrmFmxLkRuLRVuabDc+j5HFNUR6rVnRpHc+s05C4RTRCtJ5tlZCN1G0X4x7oMApj+xIihkcp8Q3dBsLQJOX/ryMxu1hos52mhpZes+sXHwlTNbdsUCYGTTzj8nl91H81J4hGR/kvyNCxRunzLNyMWGdqOt5hk1OVmTtnRHfr5XUeD2xbkvvleH7S/TyfaNoQpMcSBcy5YhdUWFz1R0KShJtjcXee4ouQSFTxLWdaoQySM5V4UkMGAms6FDpJWe5WQWStABnxkgziTj7iHZ9nd0o2Rp4iGt/KuI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n+Pr2mcYMykyaSK3HRSLNc1GbJqzlWD0gpHNLusM1s=;
 b=b3Yl/pJPbmlaemRjulGtHto9qb26Eriyjn6Ot7aSvo95Uv0eCBm11xQUi7GUTCYaP+KMNCNMuHDE6nG2Rm375+Pbl4p+luraco7goNmWFVxawR1g4PlqwGyoo7KtmxxtuhNb0YU2qrhWkobC8hGjH0cQUvqZ07QB2u1F4LPwsfMGEVtucU6XsEs53eLd6eNsqInmjbyy5lFjcmJ5vwtZwK+ebgM7OlaspjINflUJ1vOfBKExrSuwGcOcStSHPL6/EpaGGn2gbLWxZEBiBH9VBf417lCvHezwgnE1j8qrQsCveocrD21UgzWvFVNK4jOd5v8NP/YWA31bqA8OGIIusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n+Pr2mcYMykyaSK3HRSLNc1GbJqzlWD0gpHNLusM1s=;
 b=JTRbEy854neOTctXJHhVEixMzLGG3z6r0adtz59Xz0rD6rVQTpl4tffC9yJ8LB9W5bj9/YncTHCh4/k2JdH6BnfqDGtj/rF3Y0+I7KVivby3oMwJf7jSMTgqVgmYqF5OBhSpffaedmdhte9vD9dnVchiT9xoYdb+2tDvttI7KHU=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:27:26 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 19:27:26 +0000
Message-ID: <803d3e56-ed6c-450f-b609-6dbfdd1e4d14@oracle.com>
Date: Wed, 19 Nov 2025 14:27:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] nfsd: revise names of special stateid, and
 predicate functions.
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251119033204.360415-1-neilb@ownmail.net>
 <20251119033204.360415-7-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251119033204.360415-7-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:610:cd::12) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c84fcea-39c5-41e9-340a-08de27a1abc3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?STdVdGZWMnRiYjQwV0tOWHozcWo1NlB0eEp4cmE3Y0poVmkyK1J5aGlGS2pH?=
 =?utf-8?B?b21Fa3pnN1J4Y3Y4b3BLYnhobmsxL2pGZ0hiNGlUazIzTnROU3hpSmM2eTBJ?=
 =?utf-8?B?Ym9IT1BMNHoxREZBS01Md3R2ZTJmSEs2dHVveVYraTNleDBRNElybUpNVGMv?=
 =?utf-8?B?cFdvVzJURUFFLzhkYmdvNi9tMXJnT3AvYy9WNkpUT0IrOFhxQkR2K3JtQ0VO?=
 =?utf-8?B?YnFnVUJEZzBjZzR5VzVURmZ4L216T1NkQ2pLQzRVTzhIbjY5N3FzZjJUYitY?=
 =?utf-8?B?UEo0S1phZTRkTFFUazRtMTRxOUlSaUtDMUd2TmJSTGZiUDRnMG9XUFdXRmla?=
 =?utf-8?B?aUU1M25xRiswWVJQNkNJdEhGd3A0ZFk4NndGZTlSSTFNOCtBQWRNZmNYbTFj?=
 =?utf-8?B?cTc5TmRYc1hYRWM2amx5Ym9jRWpFeGhUZEtkY005Tk9nTTNuMTh0Q0UyL3JX?=
 =?utf-8?B?Y0F3QTI5aktubUMzYnp3a2dqQ290WERibm13T21vL2N1bDl3aWhSUzAzdm1n?=
 =?utf-8?B?ajF6VWdBdHQwY3dVZXFEQmRQa0d3NktQTmo5RGF6cjU0c0pveGNUaTdMSGt0?=
 =?utf-8?B?b3NKbzhvWkxMN2dScm1TTk1yOGtMeFB1eXVpaUt1TndaaEZhcHhDT3JnbjBx?=
 =?utf-8?B?S1Nzc2dMZkdHVVVUdjJCSlFWV1g2VmxHRW9sZ2ZDcDNxREhENGZpYTdkSmNZ?=
 =?utf-8?B?MHRlb3ZoTVZKZ1pXQUh3amM2SWZ2ZWM0bFc1TVFPRXB1bXdwNGtqV1dlWE1W?=
 =?utf-8?B?YTczVmVNUXJiV2x6K2hBZGhlckp1T1Vwak9OQVJydUpNNnhSLzVxaG80UUxi?=
 =?utf-8?B?NmxhS0VNMCs4czRjS1RrdzV3eHRFMHNOWEZSSGhvb1pEclM3WHdVN2hPMTdx?=
 =?utf-8?B?THk1RVhpZzIwZGNubmkvNGlqckc1bElLTVJKUk5XYVFJR2VDakFlYXhQanZH?=
 =?utf-8?B?UVRIQUpQcXY3dW9lVVZsWEpVZktCUHI5K3pqSm5TMXVpNUJKbVhCWGg3NStQ?=
 =?utf-8?B?ODVuMVFwYXpXVWNRTkk3Sm5pbWwyS2oyNlhuM3orb0ZvNDZsR3JWTU5VSHlq?=
 =?utf-8?B?U1RnZy8zZkFBZEhIQUwzQWpYbUFhQVUrckNDWmxXZUFQbEwra2Fad1hUbUUz?=
 =?utf-8?B?RG9UcUpxWU1RMkNpZFhTTW1JQXExK2VuYUYvWEoyYml3aU91QWU5KzF1SE0x?=
 =?utf-8?B?UnJ2bTM5ZzFITHhNRlFYYjVhakQxWnlzOUZWZ2V6NTZXS0JocHh1WEN5RHpj?=
 =?utf-8?B?Z1ZLRFVhZTlFRGZUN0dOZDYwV1NkeTRtN25ZcDVNZHVSeVgrWFVmd1NWZURv?=
 =?utf-8?B?c0VEbkhYQ1BpeXhMeE1ZQVNSQXlYbXliWXYwaXl0Rm5UZ0dSbGZNa0Q2WkhO?=
 =?utf-8?B?WlJFblBmWDcvOU81T2FWbUxvZEtnMGVTQ1dqSlNGVWpQQzlac25KVUYxTnBv?=
 =?utf-8?B?Um1UanhwdUthUVpwVHhBUHM3L0FrcjlyU3NzeDhldDRKTDNNWm1zQnJ0T1R5?=
 =?utf-8?B?Z3pRaHdzdDI3TjlMa1kvTUtoaW0rMlVpbWZmc2N2RTIvWmcxd3kwOUsyZmli?=
 =?utf-8?B?UDFLMzdVbE03SVMwcXV4M1pTK0hMWjRwVXpSRWpkOVl2VCtuUEJkOGN0YTM1?=
 =?utf-8?B?QTFaNzhRNDhrR1l0Nm1wNUlYOFNnQjI5b3Y5emZYY1JZTG9FaXZIa3NuNnk0?=
 =?utf-8?B?S0dDcUZBVzAwMHN4RVFwN2RLTFZQVUo2ditZbVlOWVdMQ1djVGREQmcyZjVF?=
 =?utf-8?B?cHl4QklPSXlTQkd6Q0RFZkttTVFBaFlYT045UE0rbG9pR0wvWnF3dzNIVTl3?=
 =?utf-8?B?VDFhdEt0Wmx6T3doTTlxSkF5elBCZUlSTTA0YWNsWlZNNS9pdC9VQ3YwUCsy?=
 =?utf-8?B?dFdNREwybDRSYllXQW1qOWJmNlFRZGJDVTNTZFIvMmVMWW8rVHE1NG04ZlZv?=
 =?utf-8?Q?SuZEFefcGi/9x0wtrFhLmfZ5VWZZNu5+?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WDUyYWo0VHAwa0h1b2hzQWFOMmIzY1RITC9pRkxOZ3V3VzB5QUpESVlFQUVm?=
 =?utf-8?B?TUQ4R0g5VjBoamZmN3QwUjFxZ0h3VENieWloZU9DNXJuMWpvWlM5UkNBTGla?=
 =?utf-8?B?cFlVdFBWMnNjMER0MmhkUzZ0dm9xdlNFbGVSZElHVFptWEV0Rnp3Sm9BS2xy?=
 =?utf-8?B?VUE1dEc5U0VVdTJsZzZ3NkpKR1UwNmw3WGhWMmtKOUp4b25JbmNybmpwaTBX?=
 =?utf-8?B?bGVYa2p5ZmVhWVRRSGZBcGVBSnoweHlUeDBoRU9ZeTQ3Qk80SDdSVFdHZUwx?=
 =?utf-8?B?QThTbXg1VjY0QXdESzA1eUcvTUxIaDkzMk12eTNFbEZTdG5VOEZVa0NCNEJl?=
 =?utf-8?B?OVhENzVOZ3NtVE5FcGhPNzAxVWFiNGRkT3VHK3A2VEFqQzlHelROU2dwc1Rk?=
 =?utf-8?B?SXQzNVlvak9rT0lSTVpqNE5BeE93R0M4ZTBHUnlEUmJ0UVFzcmMyaUtRUlZl?=
 =?utf-8?B?c1J1YkdtdVFxMkRnZHBrNmNDOUM0bnFwRGtyUDArZ2phSXZYc1kyeUJoUS90?=
 =?utf-8?B?Yi9pYzNVYXlHbW1za0R1N29YeVdCYnBia1JNRzFibGJXTlZCVFZOSFc3bCtF?=
 =?utf-8?B?dEQ4b1YrL3VNTTFaaUtyTmEraitFT3B1cloxdXMwalBvVVVCcWk5OWpQNUd6?=
 =?utf-8?B?d3hMbm1pVUhMcVBBcHkrbFk0WVFmKzdlNVhJVTE5TFBNaHdtZTZRZW5tUkpo?=
 =?utf-8?B?cGFrWG9raTFONHQwbCtkQTUxTG5lalF2RFdCMUxDMmtET0wzVzR6OU9KYnNM?=
 =?utf-8?B?YjBZZ3poRDB2bUxlenBORm8wUXNRWW1GenRHYnF5dytGRmg1VFZWdmczc2kw?=
 =?utf-8?B?UFFHRzd5SUZjc2hXVWlFSG82TXc3b0sxeWUxTW5uWCtQUnFteVBaaDkycVhw?=
 =?utf-8?B?eEFrODdDS0MzcHpWMDY1MThHam01ZXI4QldSR0xrVjRGMkRPZVU3aFN6ZHA2?=
 =?utf-8?B?RStzK3NOR3NibDZPRnR5Qm9BMDFZY2ZlVHBRakR1WWYwQlBIMDJHcTRKNFdP?=
 =?utf-8?B?aDdZWkdRUVlYOGhmbkpRRHNzMW5hdHlFMFJZZHVqR0VtR0hwcmFQLzVCQTlE?=
 =?utf-8?B?MlNqakNoUjVjYjYxUjV6Y3dvbFROMysvRVRMdnU1dUpvcjl5NGdaMitoaVRQ?=
 =?utf-8?B?MGR1QThRazUvM1VTMTlJRmpYMmJPWTlreEIrMFA3VFVSNWx0OUpHUW1YeTVi?=
 =?utf-8?B?akFnSE1wanNQazRPS21rZlBjbytOdSt0R1V3YWwybTJWcURZaTdIc1FmVXhj?=
 =?utf-8?B?azlha1BUUlpOcUFlS2JiSExBZnN6SHo3djBEWUFDQ0I2T2FCVjZNb1pHZnBi?=
 =?utf-8?B?K1JsaHV1SjU2dHllamZWdlpqNkhia3dWTjI1dUlsVVdEWkpnVzE3ZDE4Vk9x?=
 =?utf-8?B?ZzdpN0hpT3J1Y0puTlg3RnRPS0VoSUEyUzdwc3ZjL3NBc29nc0E0RUdGQW9U?=
 =?utf-8?B?NXEwV0QvTFBrV2lHbGhoOVkzZ3N5TUZKb1hXcXl3MVdsdFBtdVVJTmhxcnph?=
 =?utf-8?B?RERNUXUrNTgxNStTZkpzSTRkYXdsL25WVExsdTlDZFhwdCtuWXNMMEhLWEI0?=
 =?utf-8?B?eVdZeWhTY2JEVmMzeGJFRkJJTjZYWm5QNmRMVDAvVmRKWWNGcHM0bGU5YWxV?=
 =?utf-8?B?eG5JNkI4RjBEaW50Njl5Rm1LUjNuZkZrWnZ1dUFYY09qZTNjQ1FOZHdjcUhH?=
 =?utf-8?B?TSs4a1R3a2FsNHFVUmNkMFVZMk9ObmE1WlQydjlZTlFDNlNnMlRnWlJmcFhH?=
 =?utf-8?B?Mk5EdktXYnpzV3NrN3RuY1UrUWo2MERNakVPRzJaUG56Qml2akVMc2VXZWlo?=
 =?utf-8?B?M2NqK2EzWVpONFVPUFFmcW5RNjI5MjFXVVdmQlYvSEx2dmY2bFRSVU9VcDdh?=
 =?utf-8?B?VzdUZWRtdFdIYVJsSHF4QkgrWitpYzNMWks3YnlWaklNMDY2WDhWZjhIbVNx?=
 =?utf-8?B?VjFyTjJsN3pTanNhVWhvekNwYlc2TlZ3R0lsMzFUb1VIYnptNnE1dWxLd2pu?=
 =?utf-8?B?UlZvajdNRjJKQUlTOFY1d1lqWE9yMzhEZ05tTzlHc3RxeWVoNDVaRzM0Nkh3?=
 =?utf-8?B?SE5qRjVsSGZKUmV6alFoSVN5bytBOUo3ajRKS3U3QnhDVzVsMWtaQ01WdEdt?=
 =?utf-8?B?Z0JtTExXVFFUckdWNjFMODNPK3ZacXVnVWlROHpRTlBlK25COStURGdqQ1VW?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IwRn3eG3NkI4tj3LujX0gVlmzUj+BfhQCN+nBTl3Bgxg5PPttW3PIorA2J5g3UxDII1oiksZFlLy5soKl/AvRyk1MFaVZ3SOQESJG4nK0Fvsqp3BKux62PyF7bPcB/AaOrGkIHG8XBL/CgXwvq84/+m5NchX8TLztrVv0uVFvb6T5eZQIqlNPmavLr3xh4KLBHt6Oogh9VmjP21dy4tKlTWbbeIBcLryFFMCJi0JNSy9nQ2XP8qx3HPUU0bfXcvkpzC/+cf6DSUcrtOwEchDAMknZEYJzvzleay7P0zLv+6z/rJIeBGYVe0a1JFs+2xwzelOretfzoDmhVPsY76fciTnd0gCKrxtgQTAnizQMm7Fel30TQtxYt2vGqZ98a+25zdX4f8aRXKfoTSrUQHs4r4A50O42fo7fZUfWgBU0OBz+iCML+IHszEVASD8A2lOPDrMRwj6MS2dXYnIP5OsZe7mk8epDr111jzyNJRPo5FXsVRekICNCosu+LTGOe7Wd7FfE46oYqmRu3TUaBOC3Vy9iIkB1eVr0vIXTO5x+MWNJ3SrTcusa4lexqtJW6INxMrx8WC19y/fShEcvOk57c5coXv52hz77fd6KY5nfLI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c84fcea-39c5-41e9-340a-08de27a1abc3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:27:26.1341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTHcXfLjiOL5L+c74e4yOyLxla8PoOcq0IEK72SMIJz31TC3NE50bXl3JoDMctM+SJCvobW9rOVIs2cqYEwvJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511190152
X-Authority-Analysis: v=2.4 cv=OMAqHCaB c=1 sm=1 tr=0 ts=691e1a25 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=H2BUxC0YDGfdVTMlhkQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EHRTfTeBzKYc4CO5XBw5enQqClWf0gul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX2GBlrArlKOXz
 MEUGZlN0K1BY6sDwHVa+JTlQkSnFMaTr8YK2IC9mlHRYft6KQ0M+RupJKSPnjSbt27beQhDWUlR
 sbAawU3pIwy7pcsjdDJEcq1+bjRv6fg/Cwd2GDqxVzIbJSc305aTOmdP+QC8wFGFiHXKOWQ+QrI
 azBhEUnNWJajvCpaVZQ4FOqjtOwG31kgoi7CNzLoHPew+tAz/KDUUxTAEuIQ7RcdkuKBEtYhMAS
 exa6vdLcmgG2B1oqUk3UXb5V9VhCdZG18NrxDaJiAEYjEkNMvdGIz3qG0vA22mV/Lzn5X4V/1TP
 X9kI1Ty0YaJzfAO2JD/T9MRQeLD5c5XBBz7aKELIGOxHZ2hlxK9ewC98aR8uK6FwKMM02KldpDF
 ffj0KoYkIfX1r77QWdkJ6MaExCac9g==
X-Proofpoint-GUID: EHRTfTeBzKYc4CO5XBw5enQqClWf0gul

On 11/18/25 10:28 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> When I see "CURRENT_STATEID(foo)" in the code it is not clear that this
> is testing the stateid to see if it is a special stateid.  I find that
> IS_CURRENT_STATEID(foo) is clearer.  But an inline function is even
> better, so is_current_stateid().
> 
> There are other special stateids which are described in RFC 8881 Section
> 8.2.3 as "anonymous", "READ bypass", and "invalid".  The nfsd code
> currently names them "zero", "one" and "close" which doesn't help with
> comparing the code to the RFC.
> 
> So this patch changes the names of those special stateids and adds
> "is_" to the front of the predicates.
> 
> As CLOSE_STATEID() was not needed, it is discarded rather than replacing
> with is_invalid_stateid().
> 
> I felt that is_read_bypass_stateid() was a little too verbose, so I made
> it is_bypass_stateid().
> 
> For consistency, invalid_stateid is changed to use ~0 rather than
> 0xffffffffU for the generation number.  (RFC 8881 say to use
> "NFS4_UINT32_MAX" for the generation number here, and "all ones" for the
> generation and opaque of anon_stateid).
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ea931e606f40..f92b01bdb4dd 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -60,18 +60,18 @@
>  #define NFSDDBG_FACILITY                NFSDDBG_PROC
>  
>  #define all_ones {{ ~0, ~0}, ~0}
> -static const stateid_t one_stateid = {
> +static const stateid_t read_bypass_stateid = {
>  	.si_generation = ~0,
>  	.si_opaque = all_ones,
>  };
> -static const stateid_t zero_stateid = {
> +static const stateid_t anon_stateid = {
>  	/* all fields zero */
>  };
> -static const stateid_t currentstateid = {
> +static const stateid_t current_stateid = {
>  	.si_generation = 1,
>  };
> -static const stateid_t close_stateid = {
> -	.si_generation = 0xffffffffU,
> +static const stateid_t invalid_stateid = {
> +	.si_generation = ~0,
>  };
>  
>  /*
> @@ -93,10 +93,16 @@ static inline bool stateid_well_formed(stateid_t *stid)
>  
>  static u64 current_sessionid = 1;
>  
> -#define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
> -#define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
> -#define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
> -#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, sizeof(stateid_t)))
> +/* These special stateid are defined in RFC 8881 Section 8.2.3 */
> +static inline bool is_anon_stateid(stateid_t *stateid) {
> +	return memcmp(stateid, &anon_stateid, sizeof(stateid_t));
> +}
> +static inline bool is_bypass_stateid(stateid_t *stateid) {
> +	return memcmp(stateid, &read_bypass_stateid, sizeof(stateid_t));
> +}
> +static inline bool is_current_stateid(stateid_t *stateid) {
> +	return memcmp(stateid, &current_stateid, sizeof(stateid_t));
> +}

The new static inline functions appear to invert the logic -- the macros
use "!memcmp" but the new functions omit the "!". memcmp() returns an
int, so there is an implicit type conversion here as well. So maybe you
want "memcmp(stateid, ... ) == 0" ?

And now we can use "sizeof(*stateid)" here which is slightly less
brittle.


>  /* forward declarations */
>  static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
> @@ -388,7 +394,7 @@ nfsd4_cb_notify_lock_prepare(struct nfsd4_callback *cb)
>  static int
>  nfsd4_cb_notify_lock_done(struct nfsd4_callback *cb, struct rpc_task *task)
>  {
> -	trace_nfsd_cb_notify_lock_done(&zero_stateid, task);
> +	trace_nfsd_cb_notify_lock_done(&anon_stateid, task);
>  
>  	/*
>  	 * Since this is just an optimization, we don't try very hard if it
> @@ -6512,7 +6518,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>  	 * open stateid would have to be created.
>  	 */
>  	if (new_stp && open_xor_delegation(open)) {
> -		memcpy(&open->op_stateid, &zero_stateid, sizeof(open->op_stateid));
> +		memcpy(&open->op_stateid, &anon_stateid, sizeof(open->op_stateid));
>  		open->op_rflags |= OPEN4_RESULT_NO_OPEN_STATEID;
>  		release_open_stateid(stp);
>  	}
> @@ -7076,7 +7082,7 @@ __be32 nfs4_check_openmode(struct nfs4_ol_stateid *stp, int flags)
>  static inline __be32
>  check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *stateid, int flags)
>  {
> -	if (ONE_STATEID(stateid) && (flags & RD_STATE))
> +	if (is_bypass_stateid(stateid) && (flags & RD_STATE))
>  		return nfs_ok;
>  	else if (opens_in_grace(net)) {
>  		/* Answer in remaining cases depends on existence of
> @@ -7085,7 +7091,7 @@ check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *stateid,
>  	} else if (flags & WR_STATE)
>  		return nfs4_share_conflict(current_fh,
>  				NFS4_SHARE_DENY_WRITE);
> -	else /* (flags & RD_STATE) && ZERO_STATEID(stateid) */
> +	else /* (flags & RD_STATE) && is_anon_stateid(stateid) */
>  		return nfs4_share_conflict(current_fh,
>  				NFS4_SHARE_DENY_READ);
>  }
> @@ -7401,7 +7407,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  	if (nfp)
>  		*nfp = NULL;
>  
> -	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
> +	if (is_anon_stateid(stateid) || is_bypass_stateid(stateid)) {
>  		status = check_special_stateids(net, fhp, stateid, flags);
>  		goto done;
>  	}
> @@ -7823,12 +7829,12 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  
>  	/* v4.1+ suggests that we send a special stateid in here, since the
>  	 * clients should just ignore this anyway. Since this is not useful
> -	 * for v4.0 clients either, we set it to the special close_stateid
> +	 * for v4.0 clients either, we set it to the special invalid_stateid
>  	 * universally.
>  	 *
>  	 * See RFC5661 section 18.2.4, and RFC7530 section 16.2.5
>  	 */
> -	memcpy(&close->cl_stateid, &close_stateid, sizeof(close->cl_stateid));
> +	memcpy(&close->cl_stateid, &invalid_stateid, sizeof(close->cl_stateid));
>  
>  	/* put reference from nfs4_preprocess_seqid_op */
>  	nfs4_put_stid(&stp->st_stid);
> @@ -9101,7 +9107,7 @@ static void
>  get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>  {
>  	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
> -	    CURRENT_STATEID(stateid))
> +	    is_current_stateid(stateid))
>  		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
>  }
>  


-- 
Chuck Lever

