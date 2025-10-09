Return-Path: <linux-nfs+bounces-15096-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6DFBCA592
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 19:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F38C1A6351C
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 17:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6737C70830;
	Thu,  9 Oct 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YZx4Ld6R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QgjJa/LS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6623A9AC
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030034; cv=fail; b=SssDd5wYof10lYBghe6vrCsbgE1k2cYy0+yxYsF++QkdmVMga2XgTL8A7pGcaGAFqhd/PBzOZjixQ/Ld/B3d3UDuyeRXWtW6QRAKwzpbVCYGb0iMRGP1kMllzkTTHB5iFDkz2S1pVmABpn12tbfGr+8doot/GwmZheC+csnqFu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030034; c=relaxed/simple;
	bh=dx+k2IJmQ2jV0qJ1a5+nPlDwfusKjuWVIpXNOJ2cht0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=moKIGhQvGBl790o5iXPmNRP2ROcsOZ+b1Oj0YqThBFbnvz+88x5niY1rXFzYOZZsq026xmbyJI9Tv0g2VSVJZQmoRRBDHkW4dNzyzXivTDhUhLonATL452z+xtA6yEgZfqTL/QlocQMy5pTBB6r12UXspfBkSpr+sFw4+mSW/c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YZx4Ld6R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QgjJa/LS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599GC7D7010347;
	Thu, 9 Oct 2025 17:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Vqtt+51UXLCcEy7cNIfUqQaJogd3zik+XHZmZaAK1Hk=; b=
	YZx4Ld6RNwBTdwLRuGns1J2x6vAf+BD3F5VeHwXEXWtS5y/1f0jOheVtHAUVEJ+m
	wsI9c7YrejSLqOkUXMsm9RRY8kgJz0i5yb3wbjLXV7s0rbCWjlLp4jVYxhI+5vRs
	Zif7K5O4mpyNxVDVj6jekUeS+yJBHuBsPAFrI60pjnG9A8M9Sd1C22ixIFmKtJwA
	o6fqemwAQAjVq4hGAxCEoyTSMWKgdX7rWtJ84RkHU4iLGRG/yj9lYjS1Yw2rgK/J
	kifiv0nnWSTLuOvtW+f+uFQQ/x6vPrsdaxaoz7M0A4S7unyk0B32AJYM7y/Mdaeg
	4epFnhQcX19WqmrtzbhGGw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv8pj372-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 17:13:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 599FJTXD037129;
	Thu, 9 Oct 2025 17:13:43 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv6478xk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 17:13:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iwe42pkq65bPlxS92j5aWJ2MQg2zHLo1q65d80s46PhtBlhqFZF3LWr3hFn4hZ6BjRlR1+D0132kcBd8x9CWQTSpYu9qiGwQ5t49i85JfTRDe3dVoXX4Yl0Eu2hQ6/ij+WV7PpFrqziLrbzhfynLwbPhgwVSEey4LrEWnBVLxJeEnZhlryBZSi/yDM/k8lHHp610/XX5CAIstxJG6hV8viEmynj9LRwM+XxR2PXuTx2H+ojIM3pP/B+7DGDj/h2b7AxbGDgXMrYgoX5VRfGgnYb4UdKMJgTYwEcUl8/2ss1In0pa8sd504cxhl5vxH1Pi3grhF9qKVpPX3lugoyamg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vqtt+51UXLCcEy7cNIfUqQaJogd3zik+XHZmZaAK1Hk=;
 b=GcVfVGHAhl/ymiKr8edj+Uoi/FSHd+SqKFyz1AuShgb2A2nrgh6qQHfjLLE/QvVb3uKklb3CQg4hZVdUJXBaZxG07VkhoPzdOdSShbxkmhuCxjRx5k0K51V5FpijXzWvnydMZ9tfoLWK89Df/MqafORUlaG7dNfdzW/8MGaYkJ+xVOxHQeX++RvdAEZ7QYZkz9zcAfKto1xiBWYKG/XIWPNsRJmvz1r7029672Nzk3WPeLGsLIlpPfSuW9rqRGUMVd8Oa20HLAojb4Ig8o09X00KSjs9Om/XznvW6YWQVERrkSClDjcrB0W6cMck6bJBpMaedR/gJxM5AzQdfxZjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vqtt+51UXLCcEy7cNIfUqQaJogd3zik+XHZmZaAK1Hk=;
 b=QgjJa/LSh1QFGwwxWhduXlUpZmuPePWDp9xW/4SnQLTtCUbqrBSvw55gVh1GrCX2wvAF+Ffno72vHrIdu4JccKQGn/LdLe4H9+9ZlYDXrTW+EEMejdtDTNkA/8ylFuMB9Sq5bgn6/BjKkSHGKFXBZgbBNt1tMnnDSCAGOFvgC8o=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CO6PR10MB5570.namprd10.prod.outlook.com (2603:10b6:303:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 17:13:39 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 17:13:39 +0000
Message-ID: <8c4c1602-c180-44cb-b1e6-782f0fe3f8b0@oracle.com>
Date: Thu, 9 Oct 2025 13:13:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from
 supported attributes
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, neilb@suse.de, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <20251009160653.81261-1-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251009160653.81261-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0699.namprd03.prod.outlook.com
 (2603:10b6:408:ef::14) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CO6PR10MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 188e5a8f-bb4b-4b90-1c32-08de075730b5
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SXRYcDhMY2s5elBwTFAwc1EzUG01N01zZjBpOE9DdzdLMzZqMEU5ejZ6TmhF?=
 =?utf-8?B?WVR0K1oyZVNmY3hpQlJLRFJ0a0lSdWovUFJGeGhMTHlFczRyRWVYRnNxMWtz?=
 =?utf-8?B?QURiQUhrenFIV3JnUnNTSlh0N1dkdm5ETjdoelVHMjY3MVVXQ1NKbUowZFpo?=
 =?utf-8?B?ZG80VnVFTk1KamN4Tlc2YlFrK1lBU2ZsRWpFMXFJdXJ0R1N6b21TYVF1ZmNN?=
 =?utf-8?B?L3RYazJMRHVtNmNpNFc2S3haUDRYWE5rNUwzaExIR3NZWU9lRkRkajM1Vk1p?=
 =?utf-8?B?MkIrUFcxL2RiVnBrZVl1Y04rZSt1QlhURGJaRS9vNTNFRUxvMVIyK3EweHpW?=
 =?utf-8?B?bE5nT0oyemVEQ2ZvUmFBcUxUMkdnbFhnL3YvbFFOODRyWDdreGNIRnRIamZs?=
 =?utf-8?B?T2FLMlBGWTBuTkhJSDA3SEE2QXZOcXJQelJjVE1uZ2J4cHc2SmZLcjFHQkwx?=
 =?utf-8?B?N25EbG9QOU5oa0ZwbjZYTFJlS1ZVTVBJQldtM2FqOGttbE1JcDB0U0hSTHYy?=
 =?utf-8?B?dy9JTi84VkZDMk5wR2RPR2tFTVFUdVNRUlZja2dqaGEzWmcwTmpoc0JkMTFR?=
 =?utf-8?B?YnB5SEEvS2xYSG12cVp1aDM5QlVlUEtDY1dGTy9Mc0dlakJSTjZoSDFrYnYv?=
 =?utf-8?B?WDVIOFR5azFEeTBmQnJTTEk1UzF0RGpXZDhEc3ZIWVZWK3FkUkJ0TkliY2Z1?=
 =?utf-8?B?WW00YldCcENPa1l5QW11eGE5emFDZXNKMXZZeXE1RXAvSnFSTmh5VGJreW5X?=
 =?utf-8?B?T2NSODRTNWlZdTdSY3JBYlNFaVpIMktIQWswTGpKZitIbDFpTkVGRkVJMUlC?=
 =?utf-8?B?N085MHE2VHlNVlNobkZnQTZydHplZWtibU9NZE5vQ055dXZOQ0R4eEcrL3JC?=
 =?utf-8?B?UmZkTGRsU2VhUzAyejdIY0xhdjByai9abGo4ajZRUXlIQUN3M25UYVZQeEVR?=
 =?utf-8?B?RFRxTEd3SEdqVndRYnJLc3ZlYk1zTU1jODdRNXdVQ3BQNW9xaW55dUEzODhN?=
 =?utf-8?B?NnVYTTRxSTF2cUwzNHE4VmdwaXVaQUErc0JYRkY4dDZZZnphTEVoVUViTE5T?=
 =?utf-8?B?STZlUHJzZlZjMmtBR2NNUThQdFhUdWFvN2pBeVAwNHNXWHI5Qm1WOS9OU1Zp?=
 =?utf-8?B?Q0JXaTJRSVpqaUxFbGxvZzJtY1pzRmJRK3BGd3ZHai93YlFRdzg1ZWxkNU5F?=
 =?utf-8?B?ZWI2Q2svdmZETiszbWVxb1hTV2g1UElhQkx0VXh4TGdNNFFHREp3QmZCMWt3?=
 =?utf-8?B?WnA1anprd1Y4VnhWRXUwTk1ZMGFSeWhlYkxHTDIwNFN1eE1vWlZLbllGNWJK?=
 =?utf-8?B?bXFHc3AyS2ttV0xJMFh6TE1VUWR1TG4zUkFzVVpqcmdVTEM0WHRVYXc3bTEr?=
 =?utf-8?B?SS9tRGxMdGdxZC9wWUhxS1drSEZYd0xObjZ4MmJwdEd0VGVFTkQvc0oycWVP?=
 =?utf-8?B?NHJ6bmVGYW9TUENKRlFzSUs1Y0h1YzJOTDhQdjdqYWdEMll6RmlSTHFjU1No?=
 =?utf-8?B?NUZMTFoweDdYNmpTeVJNMWE3b1dJdVFwbWlKb0h2T1FzeTBFOURxVEh0bFdM?=
 =?utf-8?B?TStVenhKWDlBQUFoZUpNcVVGZm5OQnpLcytvbjlWclM0ZHFadkZhMWNoVTBQ?=
 =?utf-8?B?S0FMS3F2RlJROTZxWHlwY1pvemFpVTMxYk1JOHRMRDUwR3NueWdwV3FpRit1?=
 =?utf-8?B?bFdxNnlob25icGpWTXBXSm8yM2xXd0lVVUNjUDZoaWVxR0JSY1V6dzczaDdt?=
 =?utf-8?B?Rk1lMzU4Zk5sOFFQNVJxdVRqN3p0L3lEQjErTG9RaEJ0NHpScjErdHk2cVhz?=
 =?utf-8?B?MjMweWZCb0pvN3ZxU2tpUlVNdEFRMVNYSUFkT1FwQm9zN0JURFhwci9VcFJ0?=
 =?utf-8?B?dVlsdFhsYXlvRDB5aEFiWFpOMjhwOGsvYXdRcE55TXJBMWMrMUFQZk5oZlB4?=
 =?utf-8?Q?kmnwdLaNb0lhmwqxEMJ2xyu5dTMp5lBO?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZXFQa29YNGo5dzg2d0w1QVBnVnJpVnpPT01Ebnk1M0lpL2JQckNDamU5eFJ1?=
 =?utf-8?B?a1V5T3VlVlpQSVFQSWRvRnBxS3ZrUlBvZHovczNEK1pZdEdpaVduVXphcXpQ?=
 =?utf-8?B?Z24rZWJQZ2RUOHVvWTAwUXU2cmZmS2JVZzFqMURJRUZ4aXJPWWFvMlphOHlv?=
 =?utf-8?B?Z041YWx5V2FJZWZhclBTMzNZeHBpODVCVjNwSDh5MUFDSDBwMmIzQWpsZVNv?=
 =?utf-8?B?dFEyWVI4M2QvQ0Y2eEZGZndRR0ZOMmdTcENNSUVRRFhxa1o1SHRBbFgwdlJ6?=
 =?utf-8?B?MVN3L3ovNUs0Mk5WWXRURXI5M1pDRWd4N0d4SWdXbnVYeUlqU3lDb1dpTzJM?=
 =?utf-8?B?K3FhS3M2Ung3cDVtcnBFZ0FWckNkWTZiTXBJSVhhcTJQbnVaZ0R4cVFLelNi?=
 =?utf-8?B?T29kM2o2ZFhMYlhpcE1OR3JrWmVpcThoaDFqZVdOcU9lRjRPZE9SazRsYU1q?=
 =?utf-8?B?N3hWRGkvRHJ0czNOT2RBQm1iZHZML3lSY203TFQvbm05NnMyazBnZzR4aWd4?=
 =?utf-8?B?V3IrQnV1QTNjdEZFaXZUa3NsdUNsUS8xWk9FVlRPMDIyQkkwb2xneXlHeHBx?=
 =?utf-8?B?Y0pua1JMQmkxbnU5WVFqTWM3dVMwSjJMd2wwZlJJTTJWWVo1ZDFCY2FpSHBQ?=
 =?utf-8?B?azZ0M25pZk9qdXBoNHVBSzkrdURnalhPa2huV2p5MVN0Z0MyZ3B4cld3WW14?=
 =?utf-8?B?ZUpkalA0WXBzZnkzVUR3OVR1bmpHcWFwSkxjWGx3aWhOZ3BER3UwbnA4YjJL?=
 =?utf-8?B?emJYTDZBL3JQYmtRZjNnVzdmWjFLNWJvYXVjREZPc0V0bnZJZVk4OU53QVpI?=
 =?utf-8?B?ZFVPTWdwY3FzUEtRcXQrdjc4OW1FU0h1OEtOS095N0VWUlJuQzNSdFFTaVdX?=
 =?utf-8?B?aHZzN2xqbVcvOUVLRHRObjhkR2M0OWM5L0sreWprWTR4NjdRUWRhV3gvNEdm?=
 =?utf-8?B?YzdVNjBWREpYRloxUEJSWkg1UXZZVlBvaGpLcjYzZXBLbFVPZHJQT1prRGw0?=
 =?utf-8?B?dnJQZSs0c2t0WGJtMjRhdG80bUxYZXpXNlpJeWFhODIrVTV3Z0NWR3JBbHpt?=
 =?utf-8?B?SUVsSzlBV0g5RzJSVXJITjlNa0drd2JhRGhwb2ZYZmFVTnpBcU5aNE1sbkdv?=
 =?utf-8?B?UkJLZ0xVWStRYlQ5a3liSEp4TktyODNXdzdkSmJpOWFueGNFTzlUeUZKUGY4?=
 =?utf-8?B?MlpJWCtlQzZaV1R2WEI2b0FUbWZTa01OeERjbWt1emROOHN6NW96UDk0cFhW?=
 =?utf-8?B?VlhadnNjMC9uSHNRMjlSWWFVTVQvakFhQm81OVZVV3pFRkJJTXpmc2lscTMx?=
 =?utf-8?B?TExWQ0hYK1Y4WllBNDYxR01xOWQ0RUpwb3dYYWhYM2xKVEttYWt3c0VralJG?=
 =?utf-8?B?bENOUC9EK1RBcENDWTB0M3VncXhlVm9WZTNjcnpXKzU1TUdjemllWkh5cWQ5?=
 =?utf-8?B?Y2NQTnp2RE5PaGlqcGlkSHNMd1hWUzlEbzRwQ3BraENYaXI4bkx6QzVHb1Av?=
 =?utf-8?B?UzBOMUwrMmVYQjcxbVZGTzJpR0hpb0psL284YU9DZ2tGVGxzR1lMeTRIVU5w?=
 =?utf-8?B?RWl1WUxibktqbHV4cGFEd3cxL2JXaWdvTk4xTU96Mm8veHVqS1dENE01NnpC?=
 =?utf-8?B?VUVpdmQ4bnBkUHErTHNSa1F2RzhSRm1FVUdtUDVEeEhwTGNSOTRXeVQ5eVZj?=
 =?utf-8?B?cDdjdWFld1MrMXFyMzErM3RFWWd2QUlyQmVwMTkrbWtQMWJPeHVzOE1LSkdH?=
 =?utf-8?B?RnZJZWRoNmRMdW4vdi9UTzJpd3hnZUNNUDlPK0JnbzdWdWpER1MvS2JEOFJv?=
 =?utf-8?B?eWRnNkFmMHhPZHZYeHlFNWVMbGlldTMvUWNrM21yMzNUc3dXUElLODFCelFz?=
 =?utf-8?B?eHhPUVVlZVY1TUE1TWY0eUxQNHRaR2RzSDl6OTN0OWtaMjdtaHpyUHVacm94?=
 =?utf-8?B?Yy9USk0zMmVlVFFkL2ZobDIwUktLMStrbEdLS2NoSjhocEkxdUNHbkNLUW5w?=
 =?utf-8?B?Vld1empuSTFucGg3SGxrblVKV1FaNWtxZEFISkQvNlBWWGQxNjZvL2g5TTFR?=
 =?utf-8?B?VVhaMXY2VldrVXg4MVdVVlBXZUl2cVY2TkovK1oxOW5INXREWmx6bk5QSmpV?=
 =?utf-8?Q?VadzQey+bqD/VaRskhrxHiRbQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uHPFVgPVzX/M1rfQAfTv6702mAmvkfQlEPi+qTIUxG+l/gIm6Q1QmV9eczkwcPteL3JDEka7mlJ7R9kOtTzNuGOmrDiAHQ2sfK2doG+g5X3ZkHf6gsrV6T5yBwbYJJzmCH/nZx89CbXYlfVcpjRb2ROFy7mRd1GgipqiWoVhytan2YtgvoXWzf6ZR1USHC2vlXhORzwufYCKLIN1Eunm92jDdPf9qr8dKzQVJYcN8Y7+PMMsfAequrpPc2qBxpWOKTAOpD7Mo7YPxdKNuCOiszTNkh7jHJ742jmR+oYYl5d1kcVDZO5e7OJXeUdw1C9K2FEJh+jSbXqI+AsN2YaUcO0TELUfEWsFOAH8mkvMRjFhvLqMt7HO1Zq2meA8eRxmWuwbECCTxPJltuYJNO9BKKguvBZi7UqSl0LFkTqATD6lr343zIAIXEHezdDXOSbtadfjg1ziDBMt6zTtdTca2byswUpvBB8PaleLGbq3d+cuUOukX8EanVhSKymQ4UDcEml2IGCzMJd8Bz9d/h1xZbst3BbbQus0odrfoFB/cnmt8WpA0AaDuXiVCLPVqvXRGIsmOi0q+cxaB2ahIIU8kw3RLpiOH7fiyrvoGsHkDqQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188e5a8f-bb4b-4b90-1c32-08de075730b5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 17:13:39.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYpxk1dVMIE0qdvXQ0NL2G0dUsxq5uOvVlWZc5F4W5WV5bwcPxLKd2M1UktAeyRydY20vez6Kdi0PCxwEolwWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510090105
X-Proofpoint-GUID: 28BkoGLpaSIFwsARa2Q9uYC5y80T9XUl
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e7ed48 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=9duVTFIJ6uU-IPJAMZIA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: 28BkoGLpaSIFwsARa2Q9uYC5y80T9XUl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX1ZgmKqlakhqn
 CmrXhCg6lmrTOMCEFs3+SVDS0l7Hccmiky9dWzVvK9daTVpa+5Kr0PJvTIP1lUDSrZcV+S2wmkc
 fyA+wA1DPAREKMDio4fpOi46TVIskn5I1lozpVtFv9ecWzCUSx/O9hMN/Wkb9d1tp40Bnc92PQ8
 exQi6ipY4NDe89fHRBlGFZyaMzFrTAjOg9T8ySvcd82XR22MikaacbEu2qWTw7uLydudf9EPvPg
 p6xJqvILOBRFTxFu1iRGBzSfd7tDLwTH2fWXGHAplTx99i1w9GTxYeKc6wKe/ccPmULZ4HVALfj
 OYXgC9JQDhB9oVyJZUg72SIZaF6cIS84Wc4Mqkmr5ujIN0X4URDwy90BAvZsRIlWOTtUdQCTNNe
 aFeMazsTKMQKb65qiE3t+ZY5xfH3rcft2vk+aOoDCtvqCqLjpLI=

On 10/9/25 12:06 PM, Olga Kornievskaia wrote:
> RFC 7862 says that if the server supports CLONE it must support

MUST   << BCP14


> clone_blksize attribute.

Fixes: d6ca7d2643ee ("NFSD: Implement FATTR4_CLONE_BLKSIZE attribute")


> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfsd.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index ea87b42894dd..8cda8cd0f723 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -459,7 +459,8 @@ enum {
>  	FATTR4_WORD2_XATTR_SUPPORT | \
>  	FATTR4_WORD2_TIME_DELEG_ACCESS | \
>  	FATTR4_WORD2_TIME_DELEG_MODIFY | \
> -	FATTR4_WORD2_OPEN_ARGUMENTS)
> +	FATTR4_WORD2_OPEN_ARGUMENTS | \
> +	FATTR4_WORD2_CLONE_BLKSIZE)
>  
>  extern const u32 nfsd_suppattrs[3][3];
>  


-- 
Chuck Lever

