Return-Path: <linux-nfs+bounces-13206-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7FFB0F575
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B021CC2FEE
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 14:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEABF2877F1;
	Wed, 23 Jul 2025 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S1haQu5D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g9pQOMLU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02023BD1F;
	Wed, 23 Jul 2025 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281347; cv=fail; b=jW2Z1UMk4I9y05Zhjxz78R+Z9SQfnyHKJ5+kN3JL0aSsx9VGiNEQXz0uWQt4w5U2NbV4QOY3IQHfn0RskZstLIjtcHuFQWoDCxc/apLG3njOgIE/LbvrGxD1agzydyxP0V3Y1qcOgUjFBwA4RQtqn6PEVpmRdEd2llUDfEV7Q2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281347; c=relaxed/simple;
	bh=up75b+hnhR7gSz4974BH/TZvnrHx53KPy6qiNEw2cxY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qnY8vr3k50LycbP3Sj4aCAMDHa0uhPLDO2HuaW3Ru8Id6ypnEM/+ZVSF9gJFEVEo1EwPPMBicQPP4z9qi1Z4BtABR1P16c6uoCgF7K8m05um6SFaVlfMTJ0fvNk44DLYEmT5OULlYbbS31alsAxntH9Kjk03N2C/YBTfb35JIOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S1haQu5D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g9pQOMLU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8Mq7W021772;
	Wed, 23 Jul 2025 14:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HBuamxfayw+qjSDgYhWYOVdMXKUQi2jx48Zj2XoqxHA=; b=
	S1haQu5DaC09S7gjRkCD7h0GbL+gsoksoy2Tk43l9IAL43atGgABvHhoJGi3v83j
	11a1RmIOto303HoqnB8gaEMxYELRETLKc90ElbOcgdFSn2jRpwWzfGu7CP8U0QX/
	ukzpDD2YcnVgQmLA/EuVvI8sUXEleUvJxfn/LXu7cQlQApRirgFnmkHmL//wNj8p
	mLycRTbzpsidD/U0zPulPwGuYHCTX/N599CKGnzIhEB+WdDJCaBpgco46/pk1PP0
	Xixz9+fe1eA8zVEyowgWlQLg73G9ekMatKAOqnRhFvljsOm/ZZ/Xb4Il5xYE0imt
	oxdqnjETnGdib32N8HaKRg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hpfrfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 14:35:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NDeP7C011419;
	Wed, 23 Jul 2025 14:35:35 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tanetu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 14:35:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyvgtSYpbSGcVtnq+m5E3ivcYhDBOF+ZST8VsIogvEFFcA9rrAHm9ykkViWsm5pGYPAZiqz1iK4vVYX2xkCvrRd3guOmVm7An1Q4m9AeIbUvkT0ywnB2ppYw1dGBIRGerHaIYWgtP35OP6uxXFAI1RgMOXaXP093QchtHYK4/IaT0FZYGjkAey8W7Qq2AaLQGViBSyYfQbROQn8xrP0MCq/83DVRQsq3lsnx1JbJUFHRyFCtghRmI8jMgsMqtfdIrIwuqLFhcQi6fY/Whgg+e3swUFiSdJKLTurKZbtlgO61BmB391rl8VL0cqs8SmZ/LGqg8ZXIb6sYwr6Stj4KJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBuamxfayw+qjSDgYhWYOVdMXKUQi2jx48Zj2XoqxHA=;
 b=mF8ZGjPEcSR5S/LHlAz7ol29PGrrZbANMhcNSrDxvwX5Q3YDEHYuGov1CeZKe8k0LDuU48e3cSAGl6rSbBDK62Xisg2arD5B8c14ZLYGG1QKrjHLdIQfMrQ61Uw1AGCokB4Q9rxg4T2P0TO5jtNqUbh4oAdKLhtRZYkvp6bDtT6HRo+DEsFTCxoc0GF/qVljm1s+VRMP9zhmtCOMs/1S+mSjZwjYto1g5lmoxSY3WeK+AGEtGPHMXHxGetsuS5H5so5Uddd5Pm0Idy76BKveyNWrNPlIub4NhkMXdCkhM3IdY/NddglvMIGd8+o7HKkW+Jv9VBdawg0GLT/xxl1xSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBuamxfayw+qjSDgYhWYOVdMXKUQi2jx48Zj2XoqxHA=;
 b=g9pQOMLUl/paEOCYyNDjSiPCgnu/coxdnoCkDCfOCw5gzm/oBOxNtKUGbCt25EgE7PXdONCOnTd9F0oOThip0nRaZ/NNVDReCy6J/BM+H0acldPF7Bwjrq3zx+vUQoYfGFnfNoy9q/Tqib2KUpBvjGAc370/rHAw5aTSOI7koAQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7953.namprd10.prod.outlook.com (2603:10b6:8:1a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 14:35:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 14:35:31 +0000
Message-ID: <81f534a7-8763-492d-bbcc-bc49b22d07e8@oracle.com>
Date: Wed, 23 Jul 2025 10:35:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] NFSD: Rework encoding and decoding of nfsd4_deviceid
To: NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@infradead.org>,
        Sergey Bashirov <sergeybashirov@gmail.com>,
        Jeff Layton
 <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <> <05e851b2-a569-4311-b95b-e1ac94d4db5c@oracle.com>
 <175323408768.2234665.8262591875626168370@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <175323408768.2234665.8262591875626168370@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0035.namprd07.prod.outlook.com
 (2603:10b6:610:20::48) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 28acc06a-0ad8-4073-0239-08ddc9f62d50
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VVVYNEFTdFJOMVFVQ2g3WUxYM1dIL0Q1OTNVS2RaczdtT3NBQTVzcEZaQXY3?=
 =?utf-8?B?MWYrVWxrVEJVT0M1MXhiSlQ5YXF0RU1XaHY3K3NndHdPYkk4WTM4d2swTjFI?=
 =?utf-8?B?SEM1alJwOVlvem5LZUEvYms4M3BoRC95M0F5Zk9ibEJHTnVDY05aY24zbGp5?=
 =?utf-8?B?Slo1RFRGd1RBSG9NS2h4L1I2YWRsMzl1UmZSY2gwdHV3Sk1LWEJkeG9tR3JQ?=
 =?utf-8?B?VWRlVC9STnJHRVRPcFdsOVozMy95S25Zb25reDByUVBvVHp1WmJRQ0x2UThs?=
 =?utf-8?B?dVBLOXRkNDAvYXIzWUVzaC9KRUJYVHQvQzF1L1MyMXovUmZnTCtCbURTM2dR?=
 =?utf-8?B?UzdBLzZuZWRGeHZlMVh3UWp2RkpOTzdvb1VicDAxYjZxUGxpL2ZVWk5kcDU0?=
 =?utf-8?B?ZFlTVHBKNEtFaDdYVmdVaGNvbGFaQzM4TkhKTEFiM21aYkV5S09KWEU0SXZT?=
 =?utf-8?B?T2g4VVpNd3JuUzU0ZHpaYnlUYkE3RE4xbnA4dE5OYkVmMGlqUXd6S3pPQXFl?=
 =?utf-8?B?KytNQ0k2OUcybWUySE5HMVJoeStuckJtWm9XOHlGNDY4cmQyR0paTkk5TkZF?=
 =?utf-8?B?NDZVQnhKU1NVdzVhbjFXZ0N5SVIyL3B2Q2FnUk83cWp4R0I5ODlnNHdqYkRq?=
 =?utf-8?B?cTNDeW84S2NCVEhSU3BSNkRLZWJwTlB5NkhqRjJxb1N2UXJaWmhyLy9Fd0tQ?=
 =?utf-8?B?WjM4d0xNa1lyQ3dFclBRdHZkUkI1eWtrbkYvZ2pOUVpiQlJvTFhzTnBZcm1y?=
 =?utf-8?B?M3VwT3R5WHhHdlF4RHlHbTdQQ3Q3blhnMXhyazJENnBpN1VRYzZ3VzhUNko4?=
 =?utf-8?B?SVBSRVdRTU1pc3VneG1yZTZuaUlCOTMreDhURFk4czVHSDBtR0duL1FnTFRm?=
 =?utf-8?B?REdzYjVLY244UHNQY0ExRFZ0R1RTdnFpTkxMOXVDdzkrZyt3d09TYmNid1F1?=
 =?utf-8?B?U0lza1pKNkxFZmk4UnRXZk1NNi9rdDV6WXpRMFdlYXBIYzZzcG0zdjMzUGZS?=
 =?utf-8?B?QlZVTmFXQy9SSFdsKzJBclp2YzdIbHNvNGUzZzRkd3A1dWp1ZUhSeEUyOE8v?=
 =?utf-8?B?ZkVFanJiZzlZK0lDaEhtMldmejVvKytiMEU3enBQVDdwdXh6Z2ZsSGgzTUxl?=
 =?utf-8?B?SmVlR01STnFkMENyVUtKbkNiUlVITml5dEJxWVUvM2RITGxPZU5uMDNuWFJi?=
 =?utf-8?B?NjBZVjJaYzk5RTJWNC9GOEVPWFNSOEwwZU0xc093MWlPaVR1Mis4bnVyVE5q?=
 =?utf-8?B?ZUpKaVZkQ0lyOENyNVpyeWxRSjF2dWtuajFjbFkwa29ubmlLK3dOVmJXWEdO?=
 =?utf-8?B?T1E2OTJpQWY1N0NKUmtXd3RpRHZUS0tzUlo5RWlndE94RTZaUFFmWFptRWJH?=
 =?utf-8?B?M0hnNWZzSDBaOXpNZWFKL0hybDJYV1NOUk9YS1pnNFVqcElVYXZLcDVpS3M4?=
 =?utf-8?B?cW1yUitWQkhEWWN5WG5PQW1TS2lWeVdJT2FpMGJTeFJhR1hrT1FlMkhkenRp?=
 =?utf-8?B?TkpvSUdPRmJ4TjRTejlGWTVkdU5vMmJYTnJnWFVSZGhiTEc2MERRWmF5Qm0z?=
 =?utf-8?B?Mmd6TGswNCsvbitxUFlVS1EraGtXTzRybGxiaThGSm5hN2RaNkRhYmZIRWNJ?=
 =?utf-8?B?T1U0T0NOUnlIU2tod0xrRU9MdTNTUnRmMU9KN2tBRDJhbDBFeWJqdXF2eDJh?=
 =?utf-8?B?cmcraGZZMDY5WkRMSnZPZDdHWVlyNDM0MmJaZGUzb3NRM0l1a2V0V0dkWWdq?=
 =?utf-8?B?cFRBQzkxQ0FtL0tvS21KNnZJSTltcnAzK2F2VFpjZjAxREhkVmVMVDhKU0JZ?=
 =?utf-8?B?dWFScjlHMEo3OWtUKzlnU1ViUTFkL3NxUjF4L1ltUnVTaHZXY2dteXc1aXd2?=
 =?utf-8?B?WmF0ckQvRnRMS2dDdjNnZVc5S3k5VzhMK2hqZGhyeGE2WUxZcTFyOCtaQVQv?=
 =?utf-8?Q?N0a71nKdM/0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?amhNYUtzS1NCalZ0bExPNlNTQ0l4M0tXT2dPWkFWTGppNUN5UVgxQysyaEVz?=
 =?utf-8?B?UElFWkFCRWFRWGdCSC8rUUFFNVhNYUJoKzBMTU1RYTVaa3VmRTJlMEcxS3g4?=
 =?utf-8?B?N21pREpwZXlQTEIxVW1vN0Y5bi9Qb3VrQ0dmQmtBUlluczU3bHF6anJMd042?=
 =?utf-8?B?WkNxaXRjWWp3aWxrVHZqRHJWUFB4d2NzODNab2l4TEVSRDRDQUN3MkgxNGY3?=
 =?utf-8?B?WWFkZkVnS2J6UDJDZU8reTJqanJQL2tOMmVONW8vQ1Nld3dxeGZTTXp6Vkcw?=
 =?utf-8?B?allBUUhtSE9jRW4zMEEwMy9sd2pqZDVaSXIvVWlpTWJJMlZ5cVdDem5sL0lV?=
 =?utf-8?B?WTVnWmcyUTRXeitiZmZyWWIxM2NFZk9zWDlUNzQ2b1I1cTgzZmRPeS9XRTAv?=
 =?utf-8?B?cEh6YUpJT2VFK0RIRjNIanoxWmRFS2dMR1doNU0yVWVuNUJyYUlDSEZCZC9D?=
 =?utf-8?B?UnJXb0VKMHFGUzVNa296MjhoMHhBdWh1WG1Db281dDdhR1dITXpGcnh3akRS?=
 =?utf-8?B?WXFzU1p5bkJHSXBpNnVDdHZzZjBEYjI3MndmN050LzFuVHV1WThSdzJ4cHY2?=
 =?utf-8?B?U1VhZ1kra2JQZVRoc2xGbGl3Vks3TnI4M2lmYktTUGROZmt2cE9jaFBRSmxj?=
 =?utf-8?B?ZTZjYjR0aVhZZys2c2VuWWVsWVIvS1RJa3Z3REV4cWdCbzVxN2EwblNEUU43?=
 =?utf-8?B?VXppZ3VlMlRJbm9sYmxVRFNyZytQZkpoTkcyMVRsbFBjZXVlZS9GMXdNaDFz?=
 =?utf-8?B?UmNwTFFOQjJiWWtjOTAxWU85ZzExWnpFRmpBeWZlYTA1QUZMN2pkWjQxd1M3?=
 =?utf-8?B?bkFSVWJEZ013WllHb1lQQjhqVnVJOCtnbWM4c2c2Z2FrK0NoYkI5Y3g5SGtq?=
 =?utf-8?B?dzMxZnU5SitWNFpKLzYzN00wWkFrb2xOS3FWTEJjVk5hOHhxdCtuQjJ6UEZx?=
 =?utf-8?B?S0d6VXhCUFlQTGpHWEFPcjRNdVdlR09PaGxqZWRMS2hJRlRZS2o1dE5acDVN?=
 =?utf-8?B?VGtFOUlFLzNZamNCa3hSd1doSFg0QXliSmtadXNiZnRwam15TXFnY1hWdURu?=
 =?utf-8?B?eFFtTXI0OFdJRmtlS2E3UllTeFo4cW53VTZSZE5CVHpZM1dPdWRVb2pKZit3?=
 =?utf-8?B?MXFUVUVlblVkS0lqczQwUjB1K0FWREZEcDBmdUJ2RFV0MnFKZmp6Tll3S1A5?=
 =?utf-8?B?UUxPaEsxS2k3aGNFVmtkdnVKTGI4NHc3RVRmREgzaVErakFJV3J0WDB5T00r?=
 =?utf-8?B?VVBNNGZKM0w5V0MwMnBTbFpOd1djM1VKMXA5YjlQWlcrN2xLYlBZVENvYlQ4?=
 =?utf-8?B?NWdMckg0T2UreHVOUVhIOE5Ob2NqVThLcWhGaWtGbERXNzJkc1ZOV3ZtNmxn?=
 =?utf-8?B?aFR0MldzK2hJWXZiVnJGb2QzaElIakwzbk1zWXRYeVd1WXU0V0RBajRsSFVV?=
 =?utf-8?B?czd0VDZMTUVUQ3lkMWJOV0lWdnlnbS9KNzVWNkFHRC9MbUk1dGlFTUpxaW1s?=
 =?utf-8?B?TzBXbkJKUGlBYUk4am12LzdxTkhYV0tmN292UCtLTmlmWmEwM3gvZmV0dTFK?=
 =?utf-8?B?dndmdDVyYjYvWjEzN3lIM1gvWVREUlltRHl5VjFiMXNYZm85L1A1bkRqMnpV?=
 =?utf-8?B?R093bWdFODlVNEJaT3VCV2hxbUphYk1QenJLYXJZaFgrVytFcjYyNE5LYU5t?=
 =?utf-8?B?bGg3ZlB3WVFuRGptRFB5a29PdTVKakpVRVU4MG5mZU5nSGxvdFdKN0dWYWpq?=
 =?utf-8?B?bW15dU8wa2RUVjcrVi8wOHM1b1AyNXZ3TXNORDd1alp5dkwvNjArMG4xUEE3?=
 =?utf-8?B?SmN6ZzdsYUNWZis5VVNaOU0wWGN5SkN5U05hSDZYTW1jVGt1c1FNREFnbWY1?=
 =?utf-8?B?REFaMkNDVDlTR3FIZkIrMTM1VGFzUXJadENsbHNGdEF4QVBJc2FaYm9xRnox?=
 =?utf-8?B?V0R4eVhmRzdrYmM1SHVtbGpoSWZVSHVnUXl5TFUybzFSdmlaZlh2cHBuUDQ0?=
 =?utf-8?B?ZDFwa2FNTi9YWE1ESmJmamVHRlVxYkpJWXpEdEJsSFl4RVNvS0N3ZmM4Zk1Z?=
 =?utf-8?B?QmVNWEdHZzdBcTRkVzcwTkNXZ04wbXZueXViUkZ4YVo5dXFBaTFjQlk4Y1J4?=
 =?utf-8?B?eGUyYUwyRGh0VDM3TU8xSHVtTlZseDVWZ0dKNFJlSmRCdytLU3FCY04vL0Qy?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZkFw+BVjXxrCJI6pgE22d3M80yiAd1n1HUDH70BhAk7yCE8gzIeYG5i0utK5/eQGa7lUPUzwh7yCjQvTHn5TxgMQmXXlC5tjwtIWuBo6yLk56ipYLd+amghEqYgfB/K56k+zvMlQqXbvQ0KDKSMt8DYFuH4i0JPKn5uXm5qzC+8Q0NQujbWN3vR0j/iB9ml5MvOTH1IBkoK1BfQnEZNelU+7oHngKH1js6gSQLSpdbJwjLzt9yZNhW5Uy38ZGmwltjl0UAPNqRLz5SlPdnhvcGHYvom+UmZXk9lhMvOGZJv43HMV1hvSrQ8PUT1AblgWoN85DVAn0hIuaEBo9knCvrFjKqVj3b08sombJ34RkH88WsbCMu3r+017SlvcWOEwApCQaFqJID0wn2wRMHwygIyENKvO2CJ06CQk6S/8Rx2rMUaX/b8XbW7SqyIVc1vOcJ7RilRgOjaMVqyXfMZfCpp/Rcs/S/MJL23Qzm3GymFI2mdCHABuaLyL7p1nlOLcupo9K3+cVtsPXaMfd6pAAx1pKIoS9RMH8eB4xaS4LZMaBNJPSGJVaKl4fMqKZ7O3wWSNfmNVCoPz0EJeapjko/11lzRAt3mv0Ucwx+5NQhI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28acc06a-0ad8-4073-0239-08ddc9f62d50
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 14:35:31.8909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJdHoAiZZEQsAeoexft/hwOOAsFXyoS/XLmh4SH5mUbyFBgz6sgHFtwCbGIEYRsmObM2cKxAPtBpF7SoLCYyJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=506 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507230125
X-Proofpoint-ORIG-GUID: thyfOTUxfhtXwLCGw1ZYCipcOU86vrS9
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=6880f338 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=cGxS198072jwnXqF9q4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: thyfOTUxfhtXwLCGw1ZYCipcOU86vrS9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDEyNiBTYWx0ZWRfXxWwQU2aCu7v6
 aoxAwDvbu0bg9l/UJyadcZqd3jOa+MeehNCI7B0MDRink3KoGIY2VT89Yu1OS8ODmV37qN+rrb2
 7cYbPNUP6rOlBuRCignLIubKCBkuyJryXXyCoNJhU0EIVVIZzTzErWa1zDdU5KNAQgAhg4JtoQw
 udcfM4JapKLEqCHomWrTEeoVUrkF48qBNyglrfC+OI/nxpMqdCoY6zl47J2V8Bc+iOn+nwVMPet
 lYE5GrMkKWLnSeJ4ZcLX+kGBUu7KE72ClJGqUYkyveETPLJvdLp/2rL/DdPXNDxpE256W/tWTq6
 UMjRlspntRgLFMwZSjCn72KZCMm2p4vBZiNtJPsRtrN6xSPhXMykqffApjdUlC/8edaW4JJOsoo
 AeFKRffZg/91vx1qk//dfv5dTgnmj+PnE2UfA78zctScGbaMh7GZrOSA9jQhZOreJGtWJuFx

On 7/22/25 9:28 PM, NeilBrown wrote:
> On Wed, 23 Jul 2025, Chuck Lever wrote:
>> On 7/22/25 1:36 AM, Christoph Hellwig wrote:
>>> On Mon, Jul 21, 2025 at 05:48:55PM +0300, Sergey Bashirov wrote:
>>>> Compilers may optimize the layout of C structures,
>>>
>>> By interpreting the standard in the most hostile way: yes.
>>> In practice: no.
>>
>> Earnest question: Is NFSD/XDR properly insulated against the "randomize
>> structure layout" option?
>>
>>
>>> Just about every file system on-disk format and every network wire
>>> protocol depends on the compiler not "optimizing" properly padded
>>> C structures.
>> It's an intrinsic assumption that is not documented in the code or
>> anywhere else. IMO that is a latent banana peel.
> 
> We could document it in the code with __no_randomize_layout after the
> structure definition.

We might also want __attribute__((packed)) or even
__attribute__((packed, aligned(4))).

That still leaves undocumented the fact that the fields in the structure
are treated as both endian types. In most other XDR functions we have
been careful to write source code that shows where endianness changes
or, conversely, where endianness is not consequential.


> But currently the only structures that are randomized in Linux are those
> which are entirely function pointers, and those marked
> __randomize_layout.
> 
> (See documentation for "RANDSTRUCT_FULL")
> 
>>
>> While not urgent, this is a defensive change and it improves code
>> portability amongst compilers and languages (eg, Rust).
>>
> 
> I'm neither for nor against the change.  I would be interested to know
> how much it changes the code side (if at all).
> 
> NeilBrown
> 


-- 
Chuck Lever

