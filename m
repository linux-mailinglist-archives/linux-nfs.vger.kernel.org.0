Return-Path: <linux-nfs+bounces-10514-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3286A5533B
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 18:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62EB3AA6B5
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 17:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14B825B66A;
	Thu,  6 Mar 2025 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TWAJAcNN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tsxIQFku"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB273255252;
	Thu,  6 Mar 2025 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282886; cv=fail; b=Bs0MtiBV4NLq5FnBK/B95qlcqzyMfI0IaXOzGv5BhlmjMRB4m3sagHYC9qD6dfGtOuKdbY4IB3yleNoSbgeKQ/Wwrs1l38BP4hHNMu5wESWrH8Y1D2l9AdyAn3077iF4bRyqNIFw+G8OPBJs1vY9QZtnJMr7Ab9tuxJ2ciH5XUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282886; c=relaxed/simple;
	bh=nvz4FuDhjuOyK/CnLBkkH1or7XfV1W9EewtTm3ttl3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=diHVf2IpIb0xA7Hqd118R2uppx7TUaiHpSvX+NdLorJmUXfgKLaJvZsGLHHpptWqClw1xcKZmYq3RiSDVkHyhFv2K9itBdoAOoGjv7e5+CDkbpBdbWAhxv2QspCZnG6RYlzyk6imPD+CQhtzUQZHOk4IS1ILAKArOW3VUxt6ZH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TWAJAcNN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tsxIQFku; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526Fi6Fa028790;
	Thu, 6 Mar 2025 17:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=iChe9b4e7hP3GIWPb84pjyvbxMgxPvBqY5FaQ04PjgQ=; b=
	TWAJAcNNQy0DvR2hgK5YtJju/m1C1ggRHS68v9uP8IHW3yXZhY9FhBJKW0Q6HGRN
	DO+fSFYJdy3ynNbfFB39slXXoZ1y8dGDmbXH8T2tYK2hYczCZUBnjAvTiMpUCrlh
	Jct1XY/RxczNbq+b52oEvmqBxjzYafIO7Vz8UR2iqUqRnkfXUielI4YMsiGInkXj
	nI0USNFo1t520p3g7q0LRsBVCvc2dKlQKhlYU0UGNneCbjCb9uEBBGa2MyQggiTb
	ZOF1nEPTTr0NJzuQcu8Brn9PX4HTdCHk5iV4TklBXSjzQTFRGGayppNaL82aBBpG
	dqdSoARgX4yAe4rTMEAU9w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qjsd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 17:40:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526GLJ4i022645;
	Thu, 6 Mar 2025 17:40:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwydx2p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 17:40:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ii1DakUAnZh7r0NlJ9Jm3PUHxUJriBbk+Kqvalq7XA9g2ZbME1qjvtYQYvnnOydQiXKiHSYqn1WYswiq4Bnkoz5Iyn3Eay2hUIHBPAdYl/Uih6EAloaWIhDLm1yVCxyRb4URaym2lyvVMIaZTed6xfXPQSJze1Rbkluij5zqUJewQ2a1ADTdg/6WyurR8Q5gAtFvElQd0QG4WHUZuZesCh5jxXBNpZ2lvrC9EoyNQHYc3ILplRsvsRAWtT4uCb1yUqC7cYge8vONC5DYjTuUZeIGovZetgRrKsl1DEJeWp8VY/19P+j0NVUwCtUVAE1VcTTC2qOPWB6H8Kcx36uE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iChe9b4e7hP3GIWPb84pjyvbxMgxPvBqY5FaQ04PjgQ=;
 b=EqcNKTjHuOP9v/pX5SHTC9IC+TBo1g9OfvKDSaHCt8QMMl1jkcyBV2FRldWYdDEGz64pPYo+B9HbnM+tz0S5gP5k7etQ7RkU8+RkuuU1VaLvC2mN8nqKY2PhXqAERsFz2hDHtMuQx7i2Y7noEE7pfK/9d6qt5nJ/nldAvJgXZfRkofUgAxLxBSob+yPsEmOeWPBLOXuVIsiCy4zmzSd88L7DgCSeCDTAbawSWz9U6UQjH2lxOR4h6USX74wztOuEqj4QMSkp1R8Gqd+Ej2Vtkimbf+w3wdYYxJmSTSR+HJdhU7pcS7D4jg9CM4tpj6vUGQLqeCS4nmn8fnhDcX1uzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iChe9b4e7hP3GIWPb84pjyvbxMgxPvBqY5FaQ04PjgQ=;
 b=tsxIQFkuOncYkqMeprz6YAgFXfT5toMgmBK3Unhf1A8TvVnVtnAyLhk4Ympa2x/8zjam97v1iRWpFQT8FZFP7pCHbT6dOADAfM5FgKvvUJfoCAV9EruV77Ki75MDwTLA4sfGhgafPI2SVcMjXNJ9ysRrGR37VQR5UKSmSkEfUpE=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH7PR10MB6484.namprd10.prod.outlook.com (2603:10b6:510:1ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 17:40:52 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:40:52 +0000
Message-ID: <31ce6d1c-b036-4a7d-a888-47a62a195dba@oracle.com>
Date: Thu, 6 Mar 2025 12:40:50 -0500
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
 <43efb87e-348c-4ad5-84a1-7e30479264bc@oracle.com>
 <e3155f911895be8384b8d522738d8a8e95c8ced5.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e3155f911895be8384b8d522738d8a8e95c8ced5.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::11) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|PH7PR10MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: db68d332-8667-4893-79dd-08dd5cd60a39
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MlVxSTNqTHFKUmtYRm9uTXdRQ3k3aVN2M2RYQkEwT2k5RDlRWjBUSjRrcGE3?=
 =?utf-8?B?SGFDa3BMYWlEU3oybWFrK3lvNFVjTGE0QTNyZnBzdXIxaW83TUlpbUtMcEVM?=
 =?utf-8?B?azhyWkhMTENWcU05TUlJZzN2Qk1IbDMyUTJpWVQyRndQU0Q2VzRtQ21ZeU1a?=
 =?utf-8?B?aGdtUGUzWkFuQU8yZE9uS2U5UWU4UXJLRFNud2VqSTdpMU5HNzhMR1NqMG1y?=
 =?utf-8?B?TnpuZXl5QUdWSDdzMmJwSHQrZHg0V0Z0a1RmTmxncWkrOFBTQUZhS2pxL2di?=
 =?utf-8?B?Q0JYZEZSUTNoMkx0d2xlQWMwOHFqTTZESWZLTUlOclFvOGZtOVdOVzZReHo3?=
 =?utf-8?B?SjRRMHB3czZOc0RHWDNDZmVUdW5penh3dzlOODZmWGorY09TMno0QTBqelN1?=
 =?utf-8?B?Zi9qZnRsZVd1dkhTclBLTmpQY1FJZFQwb3d1UFNpY2pYUHRRQXQyVXpNQU9o?=
 =?utf-8?B?aHdJNjB2YzlpRUhMZW16Tlk1UTlUanVWVHpHSERuK2I2Ylo4VjJZVEcwV3FH?=
 =?utf-8?B?b2NkYjRVRnFBM2Z2cVZMS1MxMUpQRUU3am80MlBxWThKcXhNTWppcDNETWxl?=
 =?utf-8?B?KzZuQUNQdDRlN2VZa1hIWDJJdWp6a25NV0RlK3FuQ2dlOTV5bFZaZUhacFRq?=
 =?utf-8?B?dlRlcmIvb3lrSUdrVlh0NlhENEVyWXpuRmVPUnJiZHhmZWlydG50UDZ3OW1K?=
 =?utf-8?B?aUZoT00wb2hhcDJPZXdvVmljYlZIWUdIZUxvemVFSDN6WVZLNFJLYVpIRGo5?=
 =?utf-8?B?a2ZmUkJlNEkwbW11UmFsc3RwdEgxY09BNStVZ25yRVVBT0lJNCszQU02Q1Vw?=
 =?utf-8?B?M015dkJ1aU0xL05XbnlXM0x6eERvVmRiVTVTd0FhZ1JxWHREQkpKL1JHcE9P?=
 =?utf-8?B?ZHA1M1lDOHlaRTJZVzAyZ2xHb25LNG5sQ01uTUxsTFlNRjg1eWd3QUlSckFN?=
 =?utf-8?B?ZTBCb2FnUng3dGxIOTRlZnFoSWNvSjM4a09QNHM3T29Kd2tzNWxZN0lTOHpY?=
 =?utf-8?B?MWptcTM3c20rbC9TYitlV2wwSGg1cTJ5akhpNUpsMU5pZ1Jhd250TnVqY2pB?=
 =?utf-8?B?QmdKRms5YUxtQmlNUnNQRFpuZmE5UGc4djhVSHFaVWtueDlFR2pGNk9SSXpt?=
 =?utf-8?B?UWU1Myt0NWdFdmNYaEI5YUxQeTVvUU4zYXdxUHBDNENIWitZOGJkT1NFU2Vh?=
 =?utf-8?B?ZE52cGt3NUlkcUNSZWNUMjBRbXNSV2FHY3BQdkx0RVpoM2s0R1RxdkxMZlZs?=
 =?utf-8?B?NmQveGVxT2FCQ1FvNzZyeEQ3L2FIclgrcVJTdG5iRW05aXF0SFNYMkhQN29r?=
 =?utf-8?B?cFB3ZFA0N0t6QjhBMUtROGwwbTZYUG9hQnA0VWNtTDk3bGRMRFRXMHA3MXBF?=
 =?utf-8?B?NE5OMlhQcm15SDRUSVdKYmRwbTlKQWhWeHJMcUZpM09ra1ptU2FNeUdqQXd6?=
 =?utf-8?B?RTMvSUJJM2cxN0cwY0JBZDh0cEhnbmVnZlpvL2xVYktqNmNWY3VjWFhheFZ2?=
 =?utf-8?B?RXRmOFAydE1yNFFZOVFIT0I1anVIT0tlNUloaEFZekhwL3BVUVJRYWZINC9Z?=
 =?utf-8?B?Q0d5K0tsM0F3M055U0l3SXQ5Vk1rc1lnS1dmSjVDYk5VSUFJcko3MFZ1OFlx?=
 =?utf-8?B?QWxUV0Nudml1akFWbUNtUWwyMVFaRElLMjBCeGxGdzdobURHSVovODZobkxM?=
 =?utf-8?B?QlRBd1UvdTRLQjBkbmdaWDF6ZTlpcEpLRVJrMnBSYVRlaG12TWpFMW5PclBX?=
 =?utf-8?B?TDVvZXJQWXJYcWxYeHlxajhyVm1mL1gwVjdLWTZwcEpvOCtkVFlGNEtXaUlt?=
 =?utf-8?B?eENFdnUrTU1udlFLMXVBcVBXcFltck1vVEU4Vjl2YjE2NnBaekxlN09QSmN0?=
 =?utf-8?Q?vRjYfc7TlUMQM?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U3d6TUlBeWtkaUU1SnFVSTRYYWtxNmNjV3IvSm96ZHVjTVpseDdMSUtEdmpk?=
 =?utf-8?B?T1hNakQ5YVdPNUN6bHorVHZYd3N2bjBVRkwyT2NNbi9uL2t4bTJBeTY5K2Jo?=
 =?utf-8?B?YUZ0bjF1ZzlWNXRnN1hTdlNvRWx2QjZaaXBYK1d1Q09ibWI2MUlMSllTb1Rw?=
 =?utf-8?B?ZU1rVFlwbHE1eTdta3pPZWRIMytrRVBQTXdETXRDdTltekRCODA0ZmFQdFp1?=
 =?utf-8?B?VjZEcVlHditsNGp2YzgrbzdBTnRndGJqVGc3OFB2YkpPWS9QeEhpS3JLZi8x?=
 =?utf-8?B?MC8xaDdMc0pjMERFUzFZeFhmM09LRURTaGRnMm9NOGRrOEQ3b08vZmNROVI1?=
 =?utf-8?B?NktrMXdDc1Fod1daRGQ2cld5SUh5Umw0WkxYNjJsU1NPWTM0dVZYNUJsd1lx?=
 =?utf-8?B?S04rQktzdlp2S2lETE1vODFxNE1HK3FFaHB5UkhiSmpSc0FVQzRJYXRDTDJK?=
 =?utf-8?B?MnByRi8vTGM3RnZJc0UyNm43OUk1QU53QzU2R0ppWGJCSnRxektsRjJwaktP?=
 =?utf-8?B?QzRqdVNGbWd6M0Z3TlFYYTN1S3FIM0lSUFloT0VuR0RjSUJDNm8vZXEwSDho?=
 =?utf-8?B?ZUhzSW81K2pMUko3YXhSQWpXYm9DaVo0MVg0WGVSNFIxU0tmUzFGOUFIbmgz?=
 =?utf-8?B?MFRITlBEcjhhTUZqTEdQanBVdGY4ai9WbXlrQmljVU1NakFPUzZiUDFzQUZn?=
 =?utf-8?B?V2x2K0FJTTRCS1RrRVlHYXh4aVhmQ21aUEcwNllYeWRsSGdTM2Rpclh4eDNn?=
 =?utf-8?B?Q0RUdEdlS2Y5ZGlGSzMrM1dHLy9rcEl5eGVGK2ZyQ08rMmwwaW9ZelBpbzFI?=
 =?utf-8?B?TTVkSE1qTWtyL3AwSzBMeW9jL2pwemY3NWEvYkZjSlJFTkIxOHQ2ekNkcEZR?=
 =?utf-8?B?L1hQUFErZnFLR1dTYnpoLzI5eHV4dStHdzc3QjJLc1F6RUhFYTJwWVBNZXlP?=
 =?utf-8?B?NjluaFNCa1lXZ1ZDWkYwaW1yZTZUeHBzWEYvamNnU2hyV1ZqZ0xqc2I0R2Fq?=
 =?utf-8?B?WGMzOUFSRU44SHo0M1g5WjI4WkVZMGZKek5BRm9raXg1blNydVRMSDFqajdI?=
 =?utf-8?B?emhEQ1dpVkd5UHFYNFBVRmpGRjFQLzJWQThWU2ZMUVRjZFdMZ2Fia3NJSms2?=
 =?utf-8?B?bFNBQmwyTUlKV2FsOUw1R3dORDc0M0pjNkFORHN0VC90bnFCcHBMLzNZRzlj?=
 =?utf-8?B?amtVUFovQTdqbEQrazlDWERkVWtua0FKRnVtZ3d0Q25RSE94TzU5MmQxMFI5?=
 =?utf-8?B?Q2tNc2FZaVNCc0RjYTVhRUl5ZW9HSG1DanpYK3ZiNTVYazFIQ2hTVmFXNm9L?=
 =?utf-8?B?Y0NMdlFsL1BDcEhVUHQzZ3E5K2pkelRDYjVKeno5NEt3QWJhSEphKzM2RGdY?=
 =?utf-8?B?aGl4K05UU3pYS1diclFVV0c3bjVxd2dPQWNuTWMwRHZCR25wUmRkbzJjYXRl?=
 =?utf-8?B?NXNiQkNpS3VjekI1aVo0cndLcTlReEtZeDNNUUxqZ0k5MjFzR1RlWWxWSTRO?=
 =?utf-8?B?d0kxam5zakhEOVBSWk5aaml1WFFnbXZFbFQwWXV1VmZlQmduNzJSSkNZdU96?=
 =?utf-8?B?OHFzOWpFc3BJRFJNNzRKTHBYMjN4ZVhSOWlHdzVxMlExdll3aEt4UytzaUhM?=
 =?utf-8?B?STNyZFBMZVFMM05ncysxV0k2RFRTbHpGbWxnYmtFaFNueE9BMFppM2NHODNz?=
 =?utf-8?B?b2VFaGtlcHptZlVaVE5HTmVVbll2eks2ZFcvREc4V2NSYnlkUERwZEpJMTM0?=
 =?utf-8?B?b1F6TTdZRDY2NXlRVWxrM042Q3Joa1hKeTZmUk85UFpoU1VxTk0yU3hwK2RC?=
 =?utf-8?B?T0Y2TEQ3d0xhcHdnbm81enpTTjdRQisyM2tPNXZUSnZjcFYrZllZN0c2bjIz?=
 =?utf-8?B?VVhiU29iL0MzRTY3VUlpQ210eEtrREtBbjBqZWJPam1SRVZ0TlpjSFNOcERa?=
 =?utf-8?B?WE5hSjI2cnFMRWYwd3JmY2txbHdPbUcwZDBGNGlEai8xRXVnSWF2d2VqNGVy?=
 =?utf-8?B?T2tndkswVFdwdDFrcitwOC9Jc2J2V0RKb2pDb0VESG1haEhOTVVJZ2hBdk1j?=
 =?utf-8?B?RFNrOVVNQ2c0MitRVzk5V3dlcFVOS3poM0lwNnRtYlJQUG9OaDhPdS9HNVBo?=
 =?utf-8?Q?9wHgApdMxXrdMoycaivnl2XYc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rHSvyC8BhMwCJmqyJQ4zZTeEqGtpxROKpTpWx/b9wOfbbyduh2btE4V54Z9pUUwOZshlpENnOJ5Ce0Tmerd0SnL5SEUjETJPsdAu5ZIfxgWmLjN8OmwFlg4NEY5qoBBw0QfhjtddjjPWrcyI/kk0rVeY8FqBvduHb7NLhE88wJdSkBzOyq0OtAJ3nnXhufsV45Wl0v6+/3EJfeVOsQAZYoWysn9Z0dCqz7sLbTrVtY9vUuIsgK3rDrHTvLi43zXJpakAhhkwCdEcQPKYmuwf9i80LnyfFyiGbpVaUrUdqcwqR4HaZ+uANSM01/kFr5wCaXgGkE5gwwkHHuhQ0c2t6Ub66HPXsOohzD/ydeM4F3SHIERwoSNS/huAs8zfpyJV7v3bnzsk7zhI0IWtnwtg+stzB8HsrRJQLncVtjsQMVrTmOZwAfo2I5Ebv8OnHId/s+prjnSBd7q/yyz6jmV/9ACwDg6LQyl+ywzLGHD9ND8a/Qdkgx1Nh77xnYJ7voEAZI4zpgCFyuhbJaJuEl0FdSCfTJnHlG30Yf/IgAXCSRJefWfKs0rSw4pEL2BxRgDqBgb5Ane5QtKh0L9AZnDDMwL+jHDXL0QnVwYBWWeGyx8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db68d332-8667-4893-79dd-08dd5cd60a39
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:40:52.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CC9xnUBdwLsGYwKDyX5usFwAh7sZaiZn4msHFqZtO13Ig1TjhVV8p/PrIzbdRL0Yd2ckwJRwbgQWwCBzLZAWjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_06,2025-03-06_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503060134
X-Proofpoint-ORIG-GUID: RiMQD7FCNLRxqJUMbgkFfLx1H0nK5C0C
X-Proofpoint-GUID: RiMQD7FCNLRxqJUMbgkFfLx1H0nK5C0C

On 3/6/25 11:28 AM, Jeff Layton wrote:
> On Thu, 2025-03-06 at 09:29 -0500, Chuck Lever wrote:
>> On 3/6/25 7:38 AM, Jeff Layton wrote:
>>> Sargun set up kprobes to add some of these tracepoints. Convert them to
>>> simple static tracepoints. These are pretty sparse for now, but they
>>> could be expanded in the future as needed.
>>
>> I have mixed feelings about this.

To be very clear: I'm always up for better observability! The details of
this patch are where I start to have some hesitation.


>> - Probably tracepoints should replace the existing dprintk call sites.
>>   dprintk is kind of useless for heavy traffic.
>>
> 
> I'm fine with removing dprintks as we go.

Removing them was controversial a few years ago when I first brought
this up... I would very much like to see these call sites gone, even if
we don't have immediate replacements in the form of trace points.


>> - Seems like other existing tracepoints could report most of the same
>>   information. fh_verify, for example, has a tracepoint that reports
>>   the file handle. There's an svc proc tracepoint, and an NFSv4 COMPOUND
>>   tracepoint that can report XID and procedure.
>>
> 
> The problem there is the lack of context. Yes, I can see that
> fh_verify() got called, but on a busy server it can be hard to tell why
> it got called. I see things like the fh_verify() tracepoint working in
> conjunction with these new tracepoints. IOW, you could match up the
> xids and see which fh_verify() was called for which operation.

If we're talking about NFSv3 only, sunrpc:svc_process records the XID,
nfsd thread, NFSv3 procedure name, and NFSD namespace of each incoming
RPC call. You also get the NFS client's IP address.

You can also enable nfsd:nfsd_fh_verify to capture several of those
items, plus the NFS file handle.

The kernel process information will be identical for both the svc_proc
and nfsd_fh_verify trace points -- that will tie the two records
together so you can match an XID to an NFS procedure and its file handle
argument.

If you want to see a little more you can enable the function_graph
plug-in for nfsd_dispatch().

Another approach is adding trace points in the XDR layer to capture
all of the arguments of incoming RPC calls:

https://web.git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=topic-xdr-tracepoints


-- 
Chuck Lever

