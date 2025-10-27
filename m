Return-Path: <linux-nfs+bounces-15711-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7994EC0FE09
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 19:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A01919A7624
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A43230D35;
	Mon, 27 Oct 2025 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ezwLDxNF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u4CO3N1z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5E19D07A
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589025; cv=fail; b=NnJrEP7ZnzbsbineMc/x+1gO9vv4NIdJYpoFVUrY8lk0uhjhcvVQwsbFfpu6KczFVNq29vS79L7mXMrxfoBBXq2lx97Pe7NCQCye+1dUcNrV/Ey4pRIuESFq+oUJXUKGjobJSX3WJQNyxGQI2rAJjk2+3jy87P6LL5guoblqFc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589025; c=relaxed/simple;
	bh=M43WUrwQIcfoxPkBQYSMgjxo0m7duY53ipdsV5A2Jyk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GQHP9lSkk6s7WoOuWe0PmnfAtr7W0rsN6+cp6IJEl4BlWeVlOYQsol6r5AzfshUutmb62jbJskfo03zMLIs2ThpAdDAQLIih7R6y19eNNfKm4hOi7FT+cUBEticJ92Wys4CPr0yABC+1JhpbfjOWcRGOJ9Zk2qxD41TDghUzvhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ezwLDxNF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u4CO3N1z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDYDPI012294;
	Mon, 27 Oct 2025 18:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PFxMTslmZTTrgmVchw1Hb5cwp+A72slPD2SvkIHaEtw=; b=
	ezwLDxNFBle5SMX9uHxv5kFuiojwbwqnXaoORXz5P2Gk+KpFDqjNFjWyCd9CJPTw
	IsqfGkbGVPffecr3KfmUE15/2KO9Eyi/g1LJIyaUMFdy/w/+APi8JgBQS6nFOWFs
	WWUx++k281vHpyqIz4FAbd2AseHjQvKy2vRpGcUJHPQK1fkFIN4q3JjWIBfnaloO
	2s7UmpL3PX/NWYCfEoecpYILVCwfWOPghSYxA+ZaTroarkttUjr6xZm8RMMLcvXm
	8rYg5/+BD+ZyzTS/R0DD208UyXU2wsd4WvrUJzsVH4IaHc4mcCi+tSPlYY5wOc+X
	4hUar4buid0TmrxXK2SGNw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a232usnjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 18:16:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RHqjcE035045;
	Mon, 27 Oct 2025 18:16:53 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a19pehukf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 18:16:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZK3PGV0daqCkAZwq2EDR81SkYvdtAIiIVnbzP3SOzEstpSPlmsmif8WvbE7282kJXJZ+P3LDTY+lRFkKwU6OPr8b47Tb9WrtUDNxDIRmx7hmwBMQDZoV6N5VIzRuec7EVNrf0rkwhgSQx31nS17kR4UXzW3nfHhR8kmKes1DPffXMA05DH49ZADiry9/c7PZ4PWt0AIxn8kLwDk+qGOg3GtjvDOEjDEk5rRDuYEJf125Ir37VbsmfHjW6AtR09RYeJZH+nEoPgT00/ttr+DP0h4sGzhgTEZSDjCqbMIEsRMWSHVmJ8d8MHDFg2TRssKsZ+2UtXHhT5q0z9rrWM4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFxMTslmZTTrgmVchw1Hb5cwp+A72slPD2SvkIHaEtw=;
 b=HXGYt2B9LU9aZM4h43CpmIgMb2vRz6ihPgoQCMvcofd71rgPigEC9Y3GvfUNLSiaUUHewheJao3zXDGDtxcQo+DBbthgm8OYursyVQpXQx739s9bcnCwbGwQuAs2NwjiFaPHHTGcsXTP71/FBGImGO499FqduXowIaGm6Pm9qKcQJOuAIy7B1g3N6zUJl6X5k6swfSR+oMGEwgNlre85K2AKzImyjhAwr/L9cyEb4hWRmoStgnU79QJaXgEOtI6z6dDLO1E7YLn9FVWV9k54Fx8yC6xly77CUhwfP0Wm0O3Is/i90Y6W5YVgUZBX0HuAIJwb6XgKkLRBSjRqw5o4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFxMTslmZTTrgmVchw1Hb5cwp+A72slPD2SvkIHaEtw=;
 b=u4CO3N1zFccomgTDIEmfQoXMvu9g3HA6fdu8t4FwwrogzdAp63fq338Q4zun3v1eY9g2rJ1WuSE21E9CNe5pXPqlQLYNbBGUWdKj74Z0Ye/v2kuuYoXhojXuyyU2el1U/S2aHu/9FpvNLhUqcFeEkV3K8yPshShYF1eApng9UjM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5767.namprd10.prod.outlook.com (2603:10b6:a03:3ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 18:16:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 18:16:49 +0000
Message-ID: <02ca15f7-bd34-4691-9976-70aa9336212a@oracle.com>
Date: Mon, 27 Oct 2025 14:16:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] nfsd: revise names of special stateid, and
 predicate functions.
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251026222655.3617028-1-neilb@ownmail.net>
 <20251026222655.3617028-4-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251026222655.3617028-4-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:610:59::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 4456dc85-2fa9-4cb0-9bb5-08de1584fef3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SEFmaGMzWlZZS2VKZ2pGWTF2bnd0QU5ubzdadEtRbHJ3KzlJVHl6T0tON3dU?=
 =?utf-8?B?T05yRytjZUFFazdSY2tVZG1QckU1RzVvYk9xWkVFQ3NQTk9JSkFWcllrTWpG?=
 =?utf-8?B?UW8vV2pTMUlLS1hLUERPN0NESWFzaTJiZlhlcVEvMEYwdU5iUmtkbU5mUFRL?=
 =?utf-8?B?YmdoNXhKU0VOUWpqbHZlWGtBUmFKTlc5aHlMa3FoRTFNdys4ZjlsY1hIelBx?=
 =?utf-8?B?ZkwwTFdScVRMa0pNMGVNYXgvZWg2NVZncE9GRlpYbUg2WWhsdE5vcmEvek5u?=
 =?utf-8?B?VGIxSnJJbHNkbE5maFV2NGQ5VFoyb0MvL2t3YzZJcU5vaU1QdTdtUTZXdnhD?=
 =?utf-8?B?b0RLdlN6Q1ZnTW5nbWNDYzFCd3lDUldESFFTenl2eHN2ZC9sRzR6N0t2QTcv?=
 =?utf-8?B?dkRNL2RvbHlDYmx2T0RObkMvRmJ3cENPdjY3Zk56R2xnWWpIbW9KbUtxZHBt?=
 =?utf-8?B?TTJxb3Q4Q1VOMHR1Qm5oSGdZVjRCcFBEQ3VPaVdGcExMQi9tb013eWlBVmJS?=
 =?utf-8?B?RUQwY0VwYWNtdjlTTGRVKzE2QUNoaVdHbWZRTjBEU3pCUkJwRmNTWnRPTHVq?=
 =?utf-8?B?N1dEVDQwS0xQNXo0YnhLM05IVmZWQnJ6Yk11NkwySjlwQURkRGFQNjYzRmlL?=
 =?utf-8?B?RktacEw1d1grMzhHYWY1Zk1GSm9sK3FockFKWmJabUJHb2ZINitlU2xtQlFR?=
 =?utf-8?B?T1hnalBGM3YwYkpSYjh4cmpHNGtZRkFNLzUrSzR3dER1clQrWUJTWjRSdnM1?=
 =?utf-8?B?ZkRHaUozWVo0MkRuU1g3UUZ6b0NvMTFSaENqN1ZBSW9od0NGRGc5bWlxcVR3?=
 =?utf-8?B?NDlFMHpPVjRjNDV5alBLVnlieVFla25rWUoxZ2p2SmVpL0V5Y2E1dWVUY3ZG?=
 =?utf-8?B?R0dvbVpOaXdUM3FGTVl1OUFQeTlWS0NKdG5WRUZjcWhTRE1MQlV5amlzaFdR?=
 =?utf-8?B?T1FHTENSdklZT1JnSXNvV0N2VHBaTUU1bnRoZ0xucTk5Zk0zV3JCZWhKQzBx?=
 =?utf-8?B?VTNaZ1BYT2ZkTlpTbGlKcnAwWkFOS2hhelZBVnMxeHZnbDZXemZJSnliMTVh?=
 =?utf-8?B?aHNBNmY2S1dNbFdELzJOYmd4TTJobjNqMjZyVWJBWkRoZkQxYUVBdU5aK1hH?=
 =?utf-8?B?eHdpOGR4WkdObysyNFVsUFdXQnVGK1M2eWg2aElycU9zQUdETWpTd0lxTFBv?=
 =?utf-8?B?TkNUa0FoY0VMNkRZc3NaUC8yS2ZubjdiZ2srZ3dXYk1yS3IzckxKYWZGZGox?=
 =?utf-8?B?akVtb3ZYRjNSNE8zVjlZTTZ5bnRjUGI1L0w0a3lqOVgvQ3pmeHBmbFhSTlpl?=
 =?utf-8?B?c2ozWXNtSzUxNXhJRmpoV3ZPRnNLcFRqRVFmeHVaQ1pmNko3b2hLbFZwRkI3?=
 =?utf-8?B?SjhyREZBM3VKN2JyS1lGVm50NUJVbmpkbjgxc2JhTGdPOVNtbFdKcThnclNv?=
 =?utf-8?B?R1R4K2xUYjRMU3AzQm56VWRnS2pqSzh2eC9lM25ycUc3aDRydEpGZmg5dWV0?=
 =?utf-8?B?RStFOUFqUGMvRkllRW5YUFVva2NyMmViMmM1by91azd2V1h3cXVtSWRkbHRP?=
 =?utf-8?B?OFF5OXE4WHdCY1JoVmpIcjFvMzBBTFFIV1l0SThreFNaYW9IbVNGYmJWRGd1?=
 =?utf-8?B?cGF1UU1pVExNV3U1VmE5c3FZQkU3QlljVGJNTkFJZCt3Zm5rdVZDU1l5NnZY?=
 =?utf-8?B?b2FnMW5vTVJDdno1bUhjQWpqSjIxeXBiNVhYazRZNzJKWXV1Qk5wc3RyeHdK?=
 =?utf-8?B?YlZZeHI5YVZidmtOMmlZT2pKNkFod0N4STlRd0toUkpaa3VQQS8zMkZNUGxQ?=
 =?utf-8?B?N1BraUlwdWQrSTFtZ3VQQWpLaFMrMnNjbWtJS3lwekkyN1hXNVV4c3F4aUpW?=
 =?utf-8?B?bkExZ1V0dTRNVzFXKysvZ1dxQUpBaHM5K3VVVHJoaVJLUHFjdjhYQ0JsWmpK?=
 =?utf-8?Q?ramavOskP1rb7g9pJJVT+eyQ4y9qeaXp?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eHRRcnpqdUFnT3dHeWVnbnQzWUNvWG5HQkJVZzVoYUVKMXc3UnAxWDFwTHE4?=
 =?utf-8?B?UmpxZ2IyNnRzY2g4Qk41TmlFUyt1ZlUwV3dIZmJMR3N3bGwxMEJGUzBzWnNO?=
 =?utf-8?B?cHZadU0rZG00WEphNXdmT0VIUnBKa3pvd1ZmNXl6Nkkyekkvc2pFbk5jeE9O?=
 =?utf-8?B?SnhiVU9YKyswQU1zQTJhVjh2TzB0alhNZnRRRmUxOXBkc2phRnMzajA4U3I5?=
 =?utf-8?B?T0p0RmFJYnB5emhsaTlzZWdVKzZ4SWdGZFlXdnNaV0QvdkZmNEZKZlVuN2FI?=
 =?utf-8?B?aGdqdm9KelZCUGgvUW1PdmxMc084UWJjUDI4RzNOb3hwcDFqbFlKbEQ3WURK?=
 =?utf-8?B?dFZyTEZpVEdBUWg1QmxLVG5CUGp2WHp1bmxxYmNONjh6ZFV2dy9pQWdZR1Z3?=
 =?utf-8?B?Vnh2dVg1QVlKSWdHMC94TXVVWEl0WThodjcvODVLdEpPWERIL1ZBSkRVMFdB?=
 =?utf-8?B?ZzBTWVNHam5PREhEK2pJSzkzUlR2RnRmQ3A0M1dmcFY5RlRVZzIxdEZEbHRp?=
 =?utf-8?B?OTAra2dnOU5aaitKYnU2MktIcWxoQndaREx6Q28rcnFLdnhoTmQrWFFlVS96?=
 =?utf-8?B?ZWlFWlFuY0hkVmc1NVM5a3l1NFlUWVRXaU1ETzArbjNyaUtldkVPY01DMEdj?=
 =?utf-8?B?VkFweVFWa0UrekFnM2xDaU5YWGwrSzl2SlJDZDBEeUEya1B1VkU4cGFLNzFr?=
 =?utf-8?B?dHRZU2hBZS90NHFXVU5JRE1DcmlPOERGbzIrcGxRdUZPc1c3TjhBS0JXQzhD?=
 =?utf-8?B?WllBYnIrNkRENTZNanNBUHN0dUFGdUV2ODBSc1h5bm5YdXJEdFJhOW9zY3I2?=
 =?utf-8?B?d0ZlaEg5NDcySnpEY2Q0NUZCWmVxNnpBWStSaTRNbGFMajFGTUN0cDFzSHRq?=
 =?utf-8?B?N3dJbWZZc0lqbU5FREFjY1ZwNldVUWJQT3d1bERUOVdFak1wRk5teS9ZcmdF?=
 =?utf-8?B?RERQZ1BFdVR4NXl2eDdUZXVYTDhyUitjWnFld2NMN0lqZ3VkSUtKdy94THdG?=
 =?utf-8?B?R2pNdTMxRS9PTGg4RXgxYUk0SzdpUTU2VUZmMXRyeWVkVUN2YlRrZWlIMElO?=
 =?utf-8?B?aXQrSlBsclZKUU1SOElydWhEeUtJZ0dMajRJcWVlOUs4ZXVqYlBDSldQTHJ6?=
 =?utf-8?B?MGY2ZUR4dlhMc3hlL0J3U2FiTWFkcXV5N1YxQ294MXFlNjFwMDFpYXVrSzJw?=
 =?utf-8?B?SUlrZjdGYU16TGhTUnptMGptUWZHeG01Tm1EaVJVYmNPTGZiOGM0eXRCdFcw?=
 =?utf-8?B?b09Tb0ZhOWNnNFNjcUtySnh5ZzFIK01LR2lYeTByOVM3aGlWaHNaUHJBUTVw?=
 =?utf-8?B?a2VzZE5lb1JoRUNpQVJaOWZuam1pTVV1THlhSDZDL1dSVTl3RHNSZlVtWUNB?=
 =?utf-8?B?NE10RWNtYVJmT2FJN1Rid0pBL2dTeDhaSVBKQUVMQjNUTzBvSkhIb1U2TDZL?=
 =?utf-8?B?Sm1lQ09UY05hQkRpWkZiRi91a1VDK3d1VkNmSXFGblpjR1ZxVzdsYXg4NktK?=
 =?utf-8?B?Umw5b2NHU0dsWCt3aWRVS3JHOXFkMVZuajU0OXljNitRcWlVdkNpVXdKakhq?=
 =?utf-8?B?aTU5eGRsb2lzQ2hINFExSDYvME4xWHV2aE5teldPRVN0VFhxYUFWcGl6dXps?=
 =?utf-8?B?QzFOaldmVUc1UVR0SVJwUlNFRUw2UlMyTEJ3RjMvanozYUEzdE40QnEyR1Rr?=
 =?utf-8?B?WDR0dzE4OEdzSnozQVY3NEhQNFVKK0pwV255OWFoY2lvNSttNWNaYmkxZSs0?=
 =?utf-8?B?eGRUU0tEaG5LMllteXU4MVVFelBLMHB3ZCtCUzNMTTNBUGVOSkh0UjZueUYv?=
 =?utf-8?B?eFloZllUQnJBZHBRUmFPK0lSSzhzalUwL09CdWRxS1Y5YldTQVdjaDRwdklK?=
 =?utf-8?B?eGcxU29ybHZIR3d0ZkU3NDNIOERhZm1VOVFYZktUN1gzRVdTK3BmY29GNDJL?=
 =?utf-8?B?RURQb3ZRRkZKTmp3aEVoQWcvclVrNktjRGlDTUs3cGF2QjZoekFWRzdNNktj?=
 =?utf-8?B?N2lFRnBRMnplaDZUR0RUZGlFVWxzRWYrc1F0cFBscjhpWGVscXlWMUR5S0Zi?=
 =?utf-8?B?RGlXMkVVaHAxeXVaMXpITERUMnlCMEUwSmVZTTZINHdpMXBJSlNnMVNEVXBS?=
 =?utf-8?B?aWlVWGduemhoRklZQU5IK0xmZlFJT2RmUEg0YkIvQTVtU2xmbXMxeHlwWk84?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3wmdJ3Ge2Mq9vPRIgqHENNIeNqyBiZN3VvcJwfpSdPJVgPYbRrhsQfebh7+9zYuoc2NvSMZqSPFJnyLYaKG2I5b8x7Aiy2tEoxgpKfDOTPAanOS6Au/xviXepfOtuswd89ehLpFRSwijtjPFkV7ILYhBIAp6lcZbnEuZDTO02JnZOK1it1nqnIIGAVgHBza+uuRC8yPU8bYOM5W2v/ZrYXUy/QtnDRrNmCMRK9ZkyLszLiA4rq258d8Z/LlXEow1im1XWq8yH24645j7yV+fUdU8TjfMGaGKVQSoejpl9ccK1z4dTOmHt57t3aZLW9w2V7QOJpA5uM5BAElOHxl3J0W19JjfXfRU60LPcw+DPU2aAcAiNzDIBouwIJLEbbT93RmEUkmAIccTk9Bu07tpUFtq9oEM1LOU5fLkrEqwODb9O+gqiUl20bwnzgETtnHqUHYA+SKZjMt4TSUg/Hu1UHeE/FuF7pje3qsT6wVV/Mrm3XfFs87X+7vWTuWAl+yBiq/bcqXT8qdALSJ1aYGynSrYO/wys/K/iL9m47JckvuOYKVAXxJJarCpaSlHzYYwN97eMVX67aKVmToJa5nEueOoIXcO589HMPo8v/11HnU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4456dc85-2fa9-4cb0-9bb5-08de1584fef3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:16:49.3976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zwua7SW/rxB1L8oD9QtmHb0D2szb2qcePVf1RQ/dZZiixCErUoCsEbmF/l8R1IUBJdmLlkjK4HHp+xbIK/+sWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270169
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MiBTYWx0ZWRfX7P+rCOz2IY+X
 E6zChFmxz5GpYqK3y9qAL6H+vDLf1IBp+81xw0+R8M+kRZ41SBWOXPA6YdDfTTKo1bHBDir5I4d
 KXb/gDL3hJWrmjNKEMVtxF24PeFEGttm49uys1kAUaG8AIOOAt2PU/v9+HOeQX6qmQvkwdfhui9
 weF1vVzbuaoAnHTM/7plhxQSqLjKOuzdzcdiPywzfJnZVl3zzhgmPZMwW7lubfZLF3YEE+6rPtO
 Q/N7ucPToUrHv+aZRl4rpjaT3FLUlW7KCYhPWoQn2R3/tBhFprkZ+URCrguL1PV8iT3zufwK76F
 zX8iITcbtAAq7KNHrPy67S0JI9+T0gBXncXqEy8WbEF5+KkPcl/XATW42Xqw5HDJQypEmMynPv+
 tUxhym3m0u3oJwqxuhCk8qWN4CHDXzclvcEwrbVvkWfkhcUxL/U=
X-Proofpoint-GUID: h6sLVibamnIqsW4k978AokImX5kiItVq
X-Proofpoint-ORIG-GUID: h6sLVibamnIqsW4k978AokImX5kiItVq
X-Authority-Analysis: v=2.4 cv=abVsXBot c=1 sm=1 tr=0 ts=68ffb716 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=25UBgZd_rjypYqMiKTkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092

On 10/26/25 6:23 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> When I see "CURRENT_STATEID(foo)" in the code it is not clear that this
> is testing the stateid to see if it is a special stateid.  I find that
> IS_CURRENT_STATEID(foo) is clearer.
> 
> There are other special stateid which are described in RFC 8881 Section
> 8.2.3 as "anonymous", "READ bypass", and "invalid".  The nfsd code
> currently names them "zero", "one" and "close" which doesn't help with
> comparing the code to the RFC.
> 
> So this patch changes the names of those special stateids and adds
> "IS_" to the front of the predicates.
> 
> As CLOSE_STATEID() was not needed, it is discarded rather than replacing
> with IS_INVALID_STATEID().
> 
> I felt that IS_READ_BYPASS_STATEID() was a little too verbose, so I made
> it IS_BYPASS_STATEID().
> 
> For consistency, invalid_stateid is changed to use ~0 rather than
> 0xffffffffU for the generation number.  (RFC 8881 say to use
> "NFS4_UINT32_MAX" for the generation number here, and "all ones" for the
> generation and opaque of anon_stateid).
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 594632998a12..cd8214a53145 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -60,26 +60,32 @@
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
>  static u64 current_sessionid = 1;
>  
> -#define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
> -#define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
> -#define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
> -#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, sizeof(stateid_t)))
> +/* These special stateid are defined in RFC 8881 Section 8.2.3 */
> +static inline bool IS_ANON_STATEID(stateid_t *stateid) {
> +	return memcmp(stateid, &anon_stateid, sizeof(stateid_t));
> +}
> +static inline bool IS_BYPASS_STATEID(stateid_t *stateid) {
> +	return memcmp(stateid, &read_bypass_stateid, sizeof(stateid_t));
> +}
> +static inline bool IS_CURRENT_STATEID(stateid_t *stateid) {
> +	return memcmp(stateid, &current_stateid, sizeof(stateid_t));
> +}

I'm still thinking that static inline functions with all-caps names is
a little unconventional.


>  /* forward declarations */
>  static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
> @@ -371,7 +377,7 @@ nfsd4_cb_notify_lock_prepare(struct nfsd4_callback *cb)
>  static int
>  nfsd4_cb_notify_lock_done(struct nfsd4_callback *cb, struct rpc_task *task)
>  {
> -	trace_nfsd_cb_notify_lock_done(&zero_stateid, task);
> +	trace_nfsd_cb_notify_lock_done(&anon_stateid, task);
>  
>  	/*
>  	 * Since this is just an optimization, we don't try very hard if it
> @@ -6495,7 +6501,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>  	 * open stateid would have to be created.
>  	 */
>  	if (new_stp && open_xor_delegation(open)) {
> -		memcpy(&open->op_stateid, &zero_stateid, sizeof(open->op_stateid));
> +		memcpy(&open->op_stateid, &anon_stateid, sizeof(open->op_stateid));
>  		open->op_rflags |= OPEN4_RESULT_NO_OPEN_STATEID;
>  		release_open_stateid(stp);
>  	}
> @@ -7059,7 +7065,7 @@ __be32 nfs4_check_openmode(struct nfs4_ol_stateid *stp, int flags)
>  static inline __be32
>  check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *stateid, int flags)
>  {
> -	if (ONE_STATEID(stateid) && (flags & RD_STATE))
> +	if (IS_BYPASS_STATEID(stateid) && (flags & RD_STATE))
>  		return nfs_ok;
>  	else if (opens_in_grace(net)) {
>  		/* Answer in remaining cases depends on existence of
> @@ -7068,7 +7074,7 @@ check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *stateid,
>  	} else if (flags & WR_STATE)
>  		return nfs4_share_conflict(current_fh,
>  				NFS4_SHARE_DENY_WRITE);
> -	else /* (flags & RD_STATE) && ZERO_STATEID(stateid) */
> +	else /* (flags & RD_STATE) && IS_ANON_STATEID(stateid) */
>  		return nfs4_share_conflict(current_fh,
>  				NFS4_SHARE_DENY_READ);
>  }
> @@ -7381,7 +7387,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  	if (nfp)
>  		*nfp = NULL;
>  
> -	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
> +	if (IS_ANON_STATEID(stateid) || IS_BYPASS_STATEID(stateid)) {
>  		status = check_special_stateids(net, fhp, stateid, flags);
>  		goto done;
>  	}
> @@ -7803,12 +7809,12 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
> @@ -9081,7 +9087,7 @@ static void
>  get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>  {
>  	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
> -	    CURRENT_STATEID(stateid))
> +	    IS_CURRENT_STATEID(stateid))
>  		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
>  }
>  
> @@ -9097,7 +9103,7 @@ put_stateid(struct nfsd4_compound_state *cstate, const stateid_t *stateid)
>  void
>  clear_current_stateid(struct nfsd4_compound_state *cstate)
>  {
> -	put_stateid(cstate, &zero_stateid);
> +	put_stateid(cstate, &anon_stateid);
>  }
>  
>  /*


-- 
Chuck Lever

