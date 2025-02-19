Return-Path: <linux-nfs+bounces-10193-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D4AA3C13E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 15:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712501886522
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 14:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C3D45C14;
	Wed, 19 Feb 2025 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vo++Qq/D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nS4J4SzY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAEE1EA7EC
	for <linux-nfs@vger.kernel.org>; Wed, 19 Feb 2025 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973754; cv=fail; b=mN3kkfDnrVuqoN+vVbv2jpYYS7JJlyYvICglOfcpXwfZPbRh+9mUrggXHt47cpv81TgO80Eor5BGGAYgl9FUGEhtSs+QPnj7R37dgbrZNefkMZm6QvdWU2WaPwKgKrURSAtNRTCdYqLNZ48BS+QaLn3SR23bCHLtqB68vYLBqSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973754; c=relaxed/simple;
	bh=1q+Zsr9R/yq2YVo3lRFfquNMap3JSQhSgopOAy5OSmU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SYe+BfLZMxqGrVpg+sTqO+74A9/Ef6gpglKBwJgc5WP6YijkONxU6ZJ1mAQ3QHkNf4/K9IJXFZPt8YcIO0H61A3s8P3lcUxiCo/r0rldtuRQDZMkfCS0+mZnAUqEd0cpBhWEiu1wQ6StKsro6NkJxTLwWMQSvlqLzRI/Bgo8G3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vo++Qq/D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nS4J4SzY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JE234G030899;
	Wed, 19 Feb 2025 14:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NNYAg2rVwY7ni8/50wF1WJ0//d6MLpXY9NUloRQxrJ0=; b=
	Vo++Qq/D820eIMK6ipPe5MbA+v7sTloNpUQdl3//HlNsI0KduMmLvGx676xCQN0/
	v7IxOj9tzeLOUU8/DeWICKU/5FejQakHmZSgbFBdSHGyiK1p90IJs1AGPjVswVHp
	ye2PqqzhqHp5gzngxgVXVB7MeFl4/wfUB3oYXeydxBbrkqa6VWFYe3rdIcGbRoI1
	9N2w3mSbadk5XRUlhBVfiAupinX6b5XdZ0gNq3LK3G6YivSUch7Rd18MmekCvyrJ
	O3uTMHx58lACFx3xxZlW42f2sfeSnpk/hxMqbuNOtnF5OMh7TJouOvj/qv723Ntn
	ti+Yb5k4ssW6cQpVAajp4g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00psnx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 14:02:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JCEa93026291;
	Wed, 19 Feb 2025 14:02:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0sp07qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 14:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvAK++MoR/T6Qrg1nxsplNDB2+I3xY4/JzOEdPuvqx5sx7FFSNeK8tMIQPjjZipRDuDsai7lVXJTjcs+7M9Zh0TFMG0xiRB4CZZmJS8bj+aeNUx57oUNvpPt8xqpD9MfUg/NVbxMldLyVR+NLXOhUKzzJN76Oz1/9S5Ypn8Tt2YYCMjlAcjzt0zZm4J697HyjN3TWAnilWm0chj9lQjT4U4J+TtRIUGap4iTlhoDnlWopaFAIj4V/zBOjmEv95uFFkF8kKNUDIfPNgBM0PeywRKb3m0SbSVQdxp3uwiRdBOS2EzgyrTtPcqS1LlonkH1kzCRxv4HXQJrT1kLB0nEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNYAg2rVwY7ni8/50wF1WJ0//d6MLpXY9NUloRQxrJ0=;
 b=w13W+FviyJuZKm/sBlrVpDki3cI/56FCvRVhGipZCEa/XGGli1ytWxU/2QkCseBiJJIP2+BrY8RC8rXttkHCOGAO/25p/kNPah7V9SEJn1WTJ87vQ4tkVH/Mu59VlXxWmvByFKwEW+ahY0D1IkeXHybBa9nWH8MDHameYNmbYg3Jw1XB9+PNOsDhZRnrIdqz/n7ibV7PAa9N002mq9+92COZR8pSAs9f48redLZ9GgxiMKYUZ3S97vC3Pv3DxKAADck9Tym5wS3F1TMIW84KbJvIT0Y5HV4zMbcnb3AHswNCQtuOyCIy76AgRe0XEAZYBN041rvTX7u5tHXmR0uQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNYAg2rVwY7ni8/50wF1WJ0//d6MLpXY9NUloRQxrJ0=;
 b=nS4J4SzYWsIPwT2iaPXcvq5VplDFg0hKwvwJN29efvsQ52uzjOdQFhwu+7WQF8oFYYQKt7rxMwWcZ0JUm7XZKPjQgD1s9n4q5fqYTKsf8K6PZ7xqOtgtqqTApymBiQQf2v05bu2qqU6X7Ru89wYsFzcO+/DzF+743N5SqOFPLNA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7817.namprd10.prod.outlook.com (2603:10b6:408:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:01:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 14:01:57 +0000
Message-ID: <bae75806-bd98-4db2-bb9f-60983940a2cb@oracle.com>
Date: Wed, 19 Feb 2025 09:01:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] NFSD: Re-organize nfsd_file_gc_worker()
To: Dave Chinner <david@fromorbit.com>, cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20250218153937.6125-1-cel@kernel.org>
 <20250218153937.6125-3-cel@kernel.org> <Z7Um6Ujm3DwC73gw@dread.disaster.area>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z7Um6Ujm3DwC73gw@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:610:11a::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: d195f923-819d-478e-c656-08dd50edf914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFlOb3hQUFJEc1dNSWdyUDBQN3pPNnVranp2UzNYR3g0WGJpNGdZK0pwdTVv?=
 =?utf-8?B?TDVGVUV0ZTlTbVBrVkpUeEtOUmxndXZkMmcvUlZRR2pRUmtZcG1KSlNTS0NK?=
 =?utf-8?B?eUY5SVF0TzFtT1NzYmM4bmJncURucUxQV0FYRUsvNlZOcXRQbE9rUFBXc0Rw?=
 =?utf-8?B?T0ZiSkUwNzYwZXl3ZU5aeTZsR3E4OVhKa2l3MWNESkhFQVRnQVBaZTNPQ2Jp?=
 =?utf-8?B?OTkzNUx0QmdGU1JObWNGWGg4THJXWEgwUU1DWVVpK0VxTVkwdFBLbjZyaFR2?=
 =?utf-8?B?TXAvQlJaT09QVkhoWFc1Rm9VN0VaTENyaEkzVnZERlRNY0w3MVJJeXU0aU00?=
 =?utf-8?B?M3FzcWhPWUxxbndtejBCbGwzWlF1VTBOV3VmWjZOZlJUNUdxaTZhRDg1UnA0?=
 =?utf-8?B?WnhEN0k3aWRsQzBGSDIvdTlrblM0bFFHcFQ1R0NhK1QzR2JnUVUwd3VWTkdl?=
 =?utf-8?B?ejVnQ3JjN3hOdGlGRWJNa3RaUUhkWWRHVkVaN0toZy9PdFdZbC9kbG13ZUNT?=
 =?utf-8?B?UXhHcnpZcW9LVGFjSUpkSzNuMFFNSlpIUzgvQkg1bzdRMVBscmZiVE1HVHZq?=
 =?utf-8?B?QnNvRXZ4UkltWkh5SGk5VE5RMzBzMUNMYTViQ3JsR3NHOFJlSUJnbklPbHlB?=
 =?utf-8?B?OEFnalB2Q1oxQ21PeXhobUd2ZW9lUVJtYkpYY0w2dFltSUp1ZUY0L2g5VGds?=
 =?utf-8?B?TGpoOUh1NHZkbDI0eW5GczBzMDJQbm5aSWtXQWJ2TmJnd2FuWnlvbThwWVEz?=
 =?utf-8?B?OGJoNm1ocnVyTDZhMXliWjhtcWxIRVc5MWU5THdweFpVekMxb3U5VUxIQ0tx?=
 =?utf-8?B?RDJPSTVKM3llTUY3emRVSjBTeGdBZytPN1kxWVc2bXZHcUFKK1YzT0FIcWNo?=
 =?utf-8?B?WGQvdjN0NXNFU3pGbGhINHI4aUtXNUQ5V29wMTZHSXA5RG9GRXMzY25STmlh?=
 =?utf-8?B?bW5JamYzM0pVTEU2VXN2MmVUMUhKWWx0bXpybW94aGZIbExYY0dTUkhKOE0r?=
 =?utf-8?B?WE9RQ1EwSWx6b1lwZkg3RDRnTjhvQzRjWVNKdWMxS1dpVVNSVEthazRnQkZF?=
 =?utf-8?B?NWhQSmJ5Kys5VjVVTFJBbE1RMjAzZzEvSTJGUlNCRTIwTTYzT05FSEtQb054?=
 =?utf-8?B?SGNNMHNQRXVISlFnendnb2Z1MlVQaU1RbnRHTnovVzFFS3lmV0FXNXEyekU1?=
 =?utf-8?B?cWF2Qjc2WWZGeVJvN3pmN1UyaDhTVDl5ejBCSE4xbEE0eENRN3B5VVVJUE9I?=
 =?utf-8?B?cGxMZVo5YlQ5S3NCN0VGMEw1bDQ3aUlobVczSllhOWtLeDZ4TWw2MWNJTXNY?=
 =?utf-8?B?N3dlejR3a0JqSFhKS1k0Y1psZmY5V3JUZ0d6Tm5MVEUxRlhKUUp0UEtFN1dP?=
 =?utf-8?B?SVk0SU5VeURRaWZYdmZVclkvM3l2RHF2aFg3LzN1bW52Y252R3REaGZCWkRX?=
 =?utf-8?B?ME1rSVN3Q0Rva3hDNUZKSk1jS2J5Z1duVmhhK1VtR3dlNHlwSTdPczFRN0Mx?=
 =?utf-8?B?TkRrS3ZOb08wTXNKTTBaRlFyVmRQYmVFS3cvSy9VV2lpTm10Q1J5SmU1U2tm?=
 =?utf-8?B?amFqNVF0TFNvSUd3cjgyMzhnTTB1UlUvZG9jNnZlZjJLdEpPc2dLM2ZaSUtx?=
 =?utf-8?B?NGFZbG9xdkpPMG5rUWZqUDJNbFpnRVF3NGFwSkNVZ0liaHVXYVZHeG45YXFj?=
 =?utf-8?B?RGJSYVpTZjhmYzFoWlEvZXBKY2Yyenh2Yi9lVlBDZ0FZdGVaN2dyWURhZm53?=
 =?utf-8?B?bk5kYVo3V2ZBVFRPTzZhRXl1ZmRHcXdkcXd5M055c2JaNlVSS2dTallmZ2tr?=
 =?utf-8?B?b2dBN01kSEovVSsyLzV6NFByUGJvWjU1NlVEVEJnU2VBaFVKRkkzQnRpTjRp?=
 =?utf-8?Q?lFQDmsYAAm7GL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGR2cHJmbU5maURUVTNlbDR5NXlUSnZZTUdoTTFMQmJ4b2J3c1llOWJ5Wk1r?=
 =?utf-8?B?K0JCRVRJMUdib2g4Zjh0Z1JKZ3FpK2lYYnJIK1hyWmlMOW95OEpadktiUmNl?=
 =?utf-8?B?SXVkN0lKNUQyVmxGQnNudi8rUi9iS2xzQ0FWRDFabXpZYS8rYXlDaUZMV2RJ?=
 =?utf-8?B?SEVGWmphTTRLcVRvcTdWc1FZUVFKcitFRFJ5bDhRTjh2MWw4OVhnSHQxb3RR?=
 =?utf-8?B?c3cyOWNmSDhtRXZMZFRJTC9iVmNkMkRqR2lFUnRJbGw2TkxKR0pMV0xSUERN?=
 =?utf-8?B?MHNNd3F6YVE1dzQrbmlUT2dKMHJpUXhiU3RjMlloclV6NzJXdDN1dUVBMmNO?=
 =?utf-8?B?OS9rN3VSYnJObEQxbW5BVlZ1SjBicHhHMnhwb0JJbVVjL01hUkpxYjNOU2lB?=
 =?utf-8?B?TmNhRDFrbk9KWWRCUi8xcXNCWlJEVUh6MU9wNERxSmduQVFaS1ZQN2lTU1lH?=
 =?utf-8?B?Mjc5ZEJrenFCN1pHM3d3WmVnT2FpYzR4SVY4S1J5NXNPTjBENVBtQ21VMzRt?=
 =?utf-8?B?TUdscXJlSHVZbWl4dXZ2MXZpeWYvbit6bndrbXUrY1g2eDJwRmY2ajM5MXNX?=
 =?utf-8?B?U1I1bFpGWTdHblVDU1R4SXZqU1RmeDlMb2tha3ZUMEsxUzI1Q091T1pwcmZD?=
 =?utf-8?B?Q3RCSGxFVHZaeEs0VmdybnlsWktVQ2ZpRTV5OGVSVHF3M2J4VVAxY2dWVVVz?=
 =?utf-8?B?RHpuNFNLbnJ5cnBsT0VRRURKeDQ4ZUpKUVlackpWSFRYaHVJRUp3Y2xtZ2F6?=
 =?utf-8?B?NlBRRW5ZMUg0dXlOejNrcEltUzdXc1VwUnNYV2M5RVhTV044MUVHN3NuSHBZ?=
 =?utf-8?B?MkRyQTVFK2gva1ZXTVdKeUZNVHYwbGR3QjQzQ2h5dlhHcUkyditKTDUrZldK?=
 =?utf-8?B?Sm5CdU9obDlxNWNCODc2Qm5HbUZST3ZmUEovN2ppTThXWUdkQVR0L1dudEM1?=
 =?utf-8?B?dFQwbmJqazcvZTdhMHlybjNISEMzVVUyMTFFeUV3UlFKYStzbGVFQ1U2UFZ1?=
 =?utf-8?B?aGtCT1h2amQ3UWxEZDJLM2VqSUUzVWlEUnF6cWxaNjJLNFRIVTFuYlNOdktv?=
 =?utf-8?B?UkRtZ0UvbEFGMVh5ZzZpbFE1MzBZNzRRak1KeFJ0VWpENTg1dTBOT2FJSm4w?=
 =?utf-8?B?aWpCaU1Kem81VmNtUjZKOUllSmo3UU9NTEEwY3I3Ni9sMzlweGxvM045SXN4?=
 =?utf-8?B?VUVOQ0dMMTVIQ1pwSmxDNXdjdkxjYzI4Q2JaYUQxWFBjSmNDcTZKUW1mWUsy?=
 =?utf-8?B?dDNubWVyUmNnMGpMOVBTWkV0TTBDcDkrTWRxNUVjdWwrTjNEUklzRWxramZl?=
 =?utf-8?B?aFpWcVZNVVRSRjN1N2kweUFsRWJWbDRPd2tLR3hQc0docVRHTURwSzJ0Y1ky?=
 =?utf-8?B?NGo4VGJBaEZxT1VNZkptV25YWlA3L1JsVTNFMnBtcFNCRnAyTVFpc3pKcUo3?=
 =?utf-8?B?UTZCa0RXcGtEbmZSV3ZnaHZvSzUrbkZXL0JuT1daZFlUOXNQWEpld2xXQlM1?=
 =?utf-8?B?WS9BV2Rkd1pUMUtQZE93YUlveHVNUTZkdisxeDF2WURNVTNsdWhZZlQrajEz?=
 =?utf-8?B?QXp3V3RQdG9BL0VVNGRDNk1EOUZIcWRvZ29qOFpKeGVtU2xrY0E2emRQN0Ur?=
 =?utf-8?B?QnliZnlqZXh3WSsxanlabTBVVzZLSzJZVUZZb1lQeTN1T2htZ081Qm10NkF2?=
 =?utf-8?B?aDQ4MUthTHB4QkxXblUvVytnRzBSNzJlVSthNkVzdzZHUTRYUERFQVdQR1ZG?=
 =?utf-8?B?OExYUWRURncwZkljekp0YjFwK0tXQjQ5RkoyaitMa05CcjAzUmt3VjIzWHZz?=
 =?utf-8?B?VE1WZGJaV1NUMkZGek1zOEUyTG5xWDhQcG1ZczY3Y0lkeDRmdjNHdjg0a1pl?=
 =?utf-8?B?MG9RYllld2hXaUUzUHpBcmtZZCt5MkhEeEM0SUhqcmk0a1JRa0t3TkxYcTlu?=
 =?utf-8?B?UVE2eWxmeFFTbmNMbytpZDhCM0tKRytORkcraHpWN2YwYTZ4YmRsdzJXUTlo?=
 =?utf-8?B?T3dMbWN0cEkxaHllS1RWNTVaUHpKWGIreUg1OTE1bDk1YzJwbnZ1d0k0Zkdt?=
 =?utf-8?B?OHRycEU0MG5uOHQ2Qks3TDdTcW56OFgzaHE1V3VPWUpDUzkrellyY2V6aEQ0?=
 =?utf-8?Q?9lIi0UnlcD2Yr1h7J5ItmRS6U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/oGD5OFO9LWS27IqSR5URIEdgvm9YSijpG0GxutFpstFeAameH6NQRZ3k01SNnosve/hWeankcbVQuDbATN0HyPwm7RMkG6oAqwLQ/fFIFAGiuspG4roECb1/FsV9Uq/z2JplRwQssh6BrnMM1Uv9HSbOlhxQS+PbR29hAkaHPAAjeblWMIe45j9Q2cUxfWfhOto2CxW4pDc6c89Hi7g5LzDNBQF1PUmjVyLPHsEupe2sKuKvNrUbLCZL9R9uzEFOu9PBbN+VHrg7t0f34h+9/SUW8f0VnrmeETU+dshy6FpQ9lgzkZXOxqX9ASINsqoyaEI/6z3VUZfervgRldKZwhqG7lclrl7y/HsA/xXQwvNNnRFWCVaU8EiKuTBC8OIT+4ZyZbmj/UzVfw1vVBEqwkQn+uVpV4OjVCkplxVA46RSHNFCzXtVXE9+MSZMUwckz9c3pj6bvQFSnya/Kmn4PX8w5D/ccC9ZXZiaON9+yXlQMGdARfMAXbY3ZtrSHPKb75c0r+PCj6Bxfk6VL441jHlXvkIcKDL7v/t3LE5MfxLmglCZrokHXcNDpfG9HSr8FbLf2eoWfoABvfKV6FZiyPrmGgT/k4Kku7G9+HaI8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d195f923-819d-478e-c656-08dd50edf914
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:01:57.6022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqlhEH6OvxGp9OhUsuyKNjmSo4v3AENhkV74fRi75tjY+n5vbX1qbyRCP3R2EMWnQKKU3iF+LqAvKIbZWhYpiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502190113
X-Proofpoint-ORIG-GUID: bZUqp87EDeAkq85Jzv79QhTGlSuyy63Y
X-Proofpoint-GUID: bZUqp87EDeAkq85Jzv79QhTGlSuyy63Y

On 2/18/25 7:33 PM, Dave Chinner wrote:
> On Tue, Feb 18, 2025 at 10:39:32AM -0500, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Dave opines:
>>
>> IMO, there is no need to do this unnecessary work on every object
>> that is added to the LRU.  Changing the gc worker to always run
>> every 2s and check if it has work to do like so:
>>
>>  static void
>>  nfsd_file_gc_worker(struct work_struct *work)
>>  {
>> -	nfsd_file_gc();
>> -	if (list_lru_count(&nfsd_file_lru))
>> -		nfsd_file_schedule_laundrette();
>> +	if (list_lru_count(&nfsd_file_lru))
>> +		nfsd_file_gc();
>> +	nfsd_file_schedule_laundrette();
>>  }
>>
>> means that nfsd_file_gc() will be run the same way and have the same
>> behaviour as the current code. When the system it idle, it does a
>> list_lru_count() check every 2 seconds and goes back to sleep.
>> That's going to be pretty much unnoticable on most machines that run
>> NFS servers.
>>
>> Suggested-by: Dave Chinner <david@fromorbit.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/filecache.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index 909b5bc72bd3..2933cba1e5f4 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -549,9 +549,9 @@ nfsd_file_gc(void)
>>  static void
>>  nfsd_file_gc_worker(struct work_struct *work)
>>  {
>> -	nfsd_file_gc();
>> +	nfsd_file_schedule_laundrette();
>>  	if (list_lru_count(&nfsd_file_lru))
>> -		nfsd_file_schedule_laundrette();
>> +		nfsd_file_gc();
>>  }
> 
> IMO, the scheduling of new work is the wrong way around. It should
> be done on completion of gc work, not before gc work is started.
> 
> i.e. If nfsd_file_gc() is overly delayed (because load, rt preempt,
> etc), then a new gc worker will be started in 2s regardless of
> whether the currently running gc worker has completed or not.
> 
> Worse case, there's a spinlock hang bug in nfsd_file_gc(). This code
> will end up with N worker threads all spinning up in nfsd_file_gc()
> chewing up all the CPU in the system, not making any progress....
> If we schedule new work after completion of this work, then gc might
> hang but it won't slowly drag the entire system down with it.

My bad. I miscopied your suggestion. Will fix in my tree.


-- 
Chuck Lever

