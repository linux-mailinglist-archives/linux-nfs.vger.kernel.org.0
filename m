Return-Path: <linux-nfs+bounces-19145-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKpxJKSynGmxJwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19145-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 21:03:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A8617CAEA
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 21:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 395C53010B9A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF8A376460;
	Mon, 23 Feb 2026 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jWZonSLM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ElLL5F6V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFCF165F16;
	Mon, 23 Feb 2026 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876723; cv=fail; b=KvLd4sLa9s+dKwfDzlCvzKCcCddHx3Xhb1bF8jjcAqVZUZlFrd2F4edD7hmLQK12YUFzGIao/Rix4Cf+Ith9eF76wA9FddIrszgrN93DwvhU5fJSfjMNzEnIdLrFJeDON4DpA/grjfFBdtO01mwDX82mL8N04TC5pOoKuSbS3OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876723; c=relaxed/simple;
	bh=gvLzFaQFEJJeFX0LDUOE+FsiKS4X3zDYdHlcGylWNXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VVntN0n5In5bYsJikCF3q0481SXCRS4wpVBde8oYk3vxW682w5HH/xabuR4rR0HA3jMHv/s1WNdXVLfcR2D/CB3CDGNx24PgB66O7pk9nB9alTr1Iv3//5dgtx0GPnrIF84gmRmTc9G4n1x3S9MHPr9h50XwctTHPUc9REbbcoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jWZonSLM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ElLL5F6V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NEv3Zd1766922;
	Mon, 23 Feb 2026 19:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lm+9B62EMK5N39eaoSpNNkalg7RLERh7rWYAh8r6cAs=; b=
	jWZonSLMQxD4meCL/oUurUhrqf4XbMNfqKiyKiuD9/5ic9WsR+aliLC36TmLh1Yi
	ow1VokFMKOrSTyPQJVDSI1gszRUiiP0LceoBPyChDGOjtoY0nI3UqaG4V5XeAjhN
	ALoShslRZofvENin/EnTfh290MlLlNkQGUNiE/ETHcp0Md5pcswgyTO2l+822QJl
	0YXfSTIUB8+FS/Wd6uFO7mnu+vJ+j0SsUiT67+tDJhl7HhHe2pTjdbJbcCa9rc+k
	gdTrXlhScQ73095CkHXqn7Lzrq9ojixN39N1hIxgPp0wuKpwkVagH+ZyAcQmD+y7
	rG7xAVUNTwcQMLUT+E0rpQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m7u12p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 19:58:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61NJ2jdw015610;
	Mon, 23 Feb 2026 19:58:30 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf3592kjb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 19:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bw/oygeujN59dYwfRElFsT+3vMHfpBu6+iiw5eguI/XuQRogjzhxqYPFHpFxwBCoAX5qavGBPdSZpCVa3v8x1cxOKGSO/RayY7Z3VcVjDKCC+ogaY0IsYBPD/BX8sCmdL3ecrC8foWBY+NjXToEfHwd0Zw2M9qzfEQHeHKGVnesraLumPRS+3Emrk2ukWK5z+++iQC/oREUlkZ90Vhn+vYd5KOaC9/PaEvyxRz1joq0eE+3R5HeINSsFEr1lZxA6GNNkXDL2iVswWcbrtCefR3kbKman340TftXg2h2uo/pO0oAeATRJIj8E7o39T3Cg8peEswhkrd3fsxAJydkbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm+9B62EMK5N39eaoSpNNkalg7RLERh7rWYAh8r6cAs=;
 b=AAVf/1Hg6Jr8e8OJjTud0sHsUhGLELYBxI4QYsHT6kREM1i2OEXCxMcvTelJHH4JuzVP/9nmlvnNHp6usy483wkQ4nQgcEEO8VgmNrhOoV/z0YHKwT3YGUFbWlIYKDCO4JdMiGXm/jDn+C2+91vca7jdukJqUSojs57o8ABSky7XXDMt7Tbl2UC/JY0mgBSLUtrPY5UbCfwQtt8cT+SF+CtM9G4ZRL7GeSU4ZGA5nBEoHyeQ2WVlyw/LvckfHSuCUH20oFPkSTdGmUMUFxGmjnhTGq0XuGbsQ1gN+TDiZwlQrQDmasf7U8dD4VMhwoOSnjm6vXKtMCW4Chy82pRw8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm+9B62EMK5N39eaoSpNNkalg7RLERh7rWYAh8r6cAs=;
 b=ElLL5F6VbTRvYd2oaytwDbktl5BgxY7Ll5Y9TG2MFR97k7Xvm3/nSGBRqUtzyxXYy2Xca3m0O5YbVHRrvRF2k02CdvdO9W9z/Babc6+YNh68LJrTkhACotZ5Ep8Tk9vKlgeZPcwHaZ7EYRgrUlwqi2IflMvYzsCedvWDA80FaHI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7247.namprd10.prod.outlook.com (2603:10b6:8:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 23 Feb
 2026 19:58:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 19:58:27 +0000
Message-ID: <6a05d2f9-78fc-4a10-ba0b-99370639bc4d@oracle.com>
Date: Mon, 23 Feb 2026 14:58:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xprtrdma: Decrement re_receiving on the early exit paths
To: Eric Badger <ebadger@purestorage.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        "open list:NFS, SUNRPC, AND LOCKD CLIENTS" <linux-nfs@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20260223182858.1158739-1-ebadger@purestorage.com>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260223182858.1158739-1-ebadger@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:610:e4::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: c6456896-7996-49cc-d12f-08de7315e8bc
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z3RNUElJVitGYng5SG9Bb3B1Q04xVnpjQmFFTGFsbTBnMzBVS3lZMjE1OFJF?=
 =?utf-8?B?clpTRmJFcGVqY2NLMTg1SkhrYWYyZnd5aThCT1BDRlozbWErZEVlRVozQ1ZP?=
 =?utf-8?B?TkczYXVkdkdsZ1JNMk1tS1ljdmdsZG9SZEpMaDB6YWNwK2lzRFhjL0lYMjU4?=
 =?utf-8?B?UEpZSmdDd2daSGNibVFWcUxjU0d5SXZ0ellZRGlsMVlmcXNHQ3NiWkdTeHh0?=
 =?utf-8?B?TkU5bngyZ3ZibjdsNG1KenJUaHNiWngzN3pBV2JDcTZWazJIenQvTHRlRnR3?=
 =?utf-8?B?eXp0S09STzRBRG9JODZoL08ySGpxc1FIbi9TUWZYQnJyc0EwTUlYbnBUQjFx?=
 =?utf-8?B?Mk1SaUxQdlM1RUZ2clUzVGxYYk5mKzVDb0R6NUlZa0xjT0thT1lwdXBaWDg1?=
 =?utf-8?B?WENEdjN1WmhZZElld1hmQldYbVE4K0VoT0xkZHNVOFpUcjE1T05CckV3MEZF?=
 =?utf-8?B?S1o4cHMxVk9oaDgzTnljdGNxSERCQ3dNbFVpR2ZtR0RjeFZWQXBXUWF2bHNX?=
 =?utf-8?B?b1p1VmgxUC9ocm5MQmw3UThuVm9teElHbkxjdlU5NHhqZWlWQUMwWnpkeStz?=
 =?utf-8?B?Z29yZnVVa3AxdVZMVklJdFhTUHFlaHpScmRiYzBUdVZjbWhDZnEvTytVMTJB?=
 =?utf-8?B?WUgwdEdlbW5MVTJnVEE1blJjSnRsYzNDR1k3d2hjUVlLemlTNUdTT0wvSUNV?=
 =?utf-8?B?cytaZ05nYklNd3V0bFA4L0ZEZGt2SzF5SDBGNWQvZUNyNlFEQTR2UzRDT2or?=
 =?utf-8?B?TDQxZHJUUGUxMGJEdUphbC9Xd0tPNFBPYkVBR1NiQy92Ri9UVXowN3I0ci9h?=
 =?utf-8?B?aWRqT3A0Q2FEdkE4b1lZYmxGZy9INEhpaWZINnA4Q1RQcHh4RUhEbGtWbmpr?=
 =?utf-8?B?UkJGNEVYOGNCMThsaHY3RHVGc0ZLSzZrNUNXSElSWnVMM0F1QUNqRG10RmUy?=
 =?utf-8?B?ZkZBL1lOWE5HdTBISHBsWVBZbkhIYVRqMXc2NFI2dU1PWW5mSy9jUXhOcHlF?=
 =?utf-8?B?b25lVWloU2I2dGdMbWRpbCtQUU1STmRaVXhuaTIwclhSY0MvQjYrV21Wc1g5?=
 =?utf-8?B?K0dpV1JRVm1jZWxXV1hUemdxVGl1bjBGTHh0QzdNV2picmFEL2pGODQ0aXpo?=
 =?utf-8?B?dGZ0SlVlWW0zK0lTZGtUNEdWYlUydjVpWE9uUGNpYkdjbXZiTDFqcEs5RjhF?=
 =?utf-8?B?bXdac0RuRmFrNmZMVENkSCs3ZnEyZ0VuNGROVGZHbU1jc3RGOUxoSEhMV2h3?=
 =?utf-8?B?T1dtbXRWeWxOUTZERmZEUFUvYllTdm0ySE5HcHM3UWlUbzF3S1I2cU1YMjVl?=
 =?utf-8?B?MjU4VlRRR05sN2ZwU2s2MXhPRWtmaFhMQ3VnbEdPbkh6UUlnbGdUUmpTZjhw?=
 =?utf-8?B?ZEhoUTlJcDI4SmVrN2g1dFJ6ek9GQ1dadHBwNWplYjFZcHYyS2FES1VvWFZr?=
 =?utf-8?B?djlCQUVWb0FxTjNSbUdQRE1OYTQzWmt5eldqbTcrN3lONUZEWGIrOUVBWWxN?=
 =?utf-8?B?d1JDZ21RejRDQ04vN0pIanV3Mi9ndkh0TzltRm1qS3hkRFNlYUJVViswNDN2?=
 =?utf-8?B?MkxwbnZtYTk5cWE4VVFIdi9DYzR2dkhwSjZyUHhvVnBnaGJuNHNLRS9sdXhX?=
 =?utf-8?B?OFFDYkZyUDZRSERmclVLek1NUTBVZzB2T1pkd3R3aHlzUzJkQTBGYVF0em8v?=
 =?utf-8?B?Z1VXNFgyRlFCOE82ZUx4aVZJU3RQdXk4UEgwR0dsTlBCbDN3N29WMVZEczJa?=
 =?utf-8?B?ck40UFdwVFAybEg4ODZFYWE0TTdCQVlFM1F0ejZjNUs0c1FyQmcrc08rcG9H?=
 =?utf-8?B?dUR6RE9xOGMrWHl4ZXF3YnI1aWh1TE1scHNUZFZvL05ybERwWW02cnVwaHRZ?=
 =?utf-8?B?TzhVV3drQW4zRDZ2VUtHUkMwdGZIaWNUVWR6M2JuY2ZYRFY5RVNBb3dZVEdR?=
 =?utf-8?B?Rno3NVB1U2w1SFFYNEF4a2ErSDIrZVQ3NzdoVWZuT3c2eTZlT2lUKzZIbldT?=
 =?utf-8?B?TW1ZZ3VjK3BkV09CVnJFQjlKNFIvOFNiczhVbU1yRnB3R3FQa2tWeFNkN3BG?=
 =?utf-8?B?VzhRb04yMTNjdmVjbDZieVlaUWNNaVZrSjZnWWM3NG9uUFJzTWp3dVNITTlI?=
 =?utf-8?Q?OBa8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YiszWW80NE1OYnVnT3VMdmV3aXFrVVQrZnNENmtFKy9HOFdSVGdsVEo4OUpZ?=
 =?utf-8?B?S1FlZ0crdm54ZDlycDJUZGNQRFV0OXVva1JIblZyWjQ0dk1UWUtlUzNiUXpK?=
 =?utf-8?B?VXVRSTNIQ0hkZHN0NEFlVUpDdUR5SUlwUEdoK1pOT1BoajRycStYQ3NjU0sr?=
 =?utf-8?B?aTU3NUswZG1kaFowdzNDLy9RYWlFckFTWkZvWG00Q3BvN0NBd1NIVk5paktv?=
 =?utf-8?B?MC90OHQ4TVBMcVlMbENrbVFaajdXTU94bnp6UWNIZXZicGV3M1Nkak10Ykp0?=
 =?utf-8?B?TVA4N280dlgxcDZaQnowbXg3V0RPVVliSUFZaVNMSnlUYnpBcVEyL3hycW9k?=
 =?utf-8?B?RjZJV29Hb254ZEttQjMzbkp4T3QzTmpURVhDSWl2VXlzTFFlQ0FOVHExeENx?=
 =?utf-8?B?TENrQXRnMitVWjBlWVFoSmpYakN2MWdWWFhQRmpEZzZFeSs5eHY3cWpvWEFS?=
 =?utf-8?B?YnZvZllaK0hYaytUcFc1SjNZa2tLN1NtTVJFcE1WNjdpd0IvOGloblFOSU8w?=
 =?utf-8?B?RzRLa25VNDBKL2t1ZEcxeW9zRlBpK3FjanBUTk9YTTlCRDJNTkN4dEVHU0tO?=
 =?utf-8?B?ZnRPVTNGYnBGMXdERVFvVmFhc0dNa3ZyQlhZZ1h6YmpqeWNhSFJrR3BvdFhS?=
 =?utf-8?B?dHNTMjBUc3NLMXcvSll6MVZBeGFWR2lQYlJoWWFrWDdyZTVCQVZPditQR2ts?=
 =?utf-8?B?aURCMDUvTlJBcGkvZFdqUWdMb1cvSHlZaWI2T3BENFdrbUhVNW53ZVJhUnNX?=
 =?utf-8?B?NEFKT1RsV0RKNEN5MytHRTdtYXV4QkhNZ3ZBMGlYaXFEenJKQjM2dDlTRVhn?=
 =?utf-8?B?bnArb054YVV1dGRkTVgxWlRqZ1ZSaFBCMXNzTmN0RFY1dDNhdHZWQXVUdTVL?=
 =?utf-8?B?YnRmTzFZOHcySHVIZmE3OS85UFZEL0xQaWtUYm83ZFlLWTlCWUV1V2R4UlFr?=
 =?utf-8?B?UXJ0WWUxZ1h0aDdJNDd2bFVwWHlkYUY1eitkVXd2elBabCtMamNYbUtMck54?=
 =?utf-8?B?a2E5dk44a1lOV2puQm9mbFBuNkRiMmN6cXpGMWJ5TEhrS0Y2RllsNUVPbUZ5?=
 =?utf-8?B?cDIwaWxDczR4dS9ZUTdGYUJpbW1OZUs1d0dmS21FSHM1S0E2VnZMSzlJOEJQ?=
 =?utf-8?B?WkkzWDBGc2pBRk1rUzFBcEZpdUNSaUI0RWlwRmdsRlRnaE9aZ1hyaytqRTBt?=
 =?utf-8?B?V2NxcnEweXpxTHJiKzBqWDRMN3BmZnNyRnloUEZRbE04N2pMTVdIRktJZlBE?=
 =?utf-8?B?bTZSRUk1MWJEMU1ZQ2RvS2tKZ2VJZ3BjNm9lL2kwK2U5dkdDN2xnUHpnK0RF?=
 =?utf-8?B?NHI2QjBQdkpRMW9XalRGT0h5UjRoak02eHFDYm5rNlg3UlVkV2JiT1gvTGF5?=
 =?utf-8?B?aU5OektUUlZYNmFHYW1TcHpaWlpSNVBiRHA2SitXOXRLb1RTeEN4dDFKV21l?=
 =?utf-8?B?Y0hDaUpFamlKdFNCN2lKY0hOUHYyeGllbHpQd2dhR1dnYTFKTTBWNENrYjJx?=
 =?utf-8?B?YmRyUklSN1MwamlhQ3dVMDVtNS8yZG42bUd0V05kVGt6Z3N6VzFTZTJaN3lX?=
 =?utf-8?B?TzExVWpKeFdvVEZvbXFhdVJKb0xOeG05b0VnVTVVaGYzVFAzWkhTL0hBVG9w?=
 =?utf-8?B?NFFoMFo1STNndDlyelVsWEJUa2s5UWlueGlyeUVzRzBWTW14MmtXenVpTUhv?=
 =?utf-8?B?d3V6VUNIZ0VqSnRkbWFhRWlQbGV2TGtiQzIyU3dZeW5TSFZUWjZBYnhEYndz?=
 =?utf-8?B?cFI3ZXVkY3V4UVU5R09nanpaSzIvL2FRTGRXUkJUV2xIVFB4TEozNVE3cnRD?=
 =?utf-8?B?cmZ0MzFXZzRJczlXVkVZYjZ3dmFwdWNPKy9QbExhR3QyNFBnVzBkRnVEakt1?=
 =?utf-8?B?U0RnZ3FzSGY5NXUxaE5aNTNkWkpubGNYb3lXaGVyUmx6SXg3S2xWajc1OHNt?=
 =?utf-8?B?ZGdWc08wMy81d0RXMzg3bE9YbkRGaXl4NWhmcWIrb1NxY2k5OW9tK3lvZmlB?=
 =?utf-8?B?YllOblJHZGNSV0oyVmxnNnRHNWo4TkJBVzI0bVE3V3I3R0hDNlljQ0pldjdG?=
 =?utf-8?B?VThLdDJsNmQzbWFaRXkrYUgxNzQvbEVsNUs3OXloK1JxUlhUc25iL2VPNW9R?=
 =?utf-8?B?ZkpGK3RHVGZTRE16Z1ZBSXR4dzdNclIwWUNTNWkySVg2WEJQR3V4Y09IOU4x?=
 =?utf-8?B?WjhVUm83RTE0VUVLVzdVU0dyTjdxTEdkOW1LVy91WHpOMjN4NTJBVVQ2Nlky?=
 =?utf-8?B?Sy9JUUVsNGdEWXYwNnBvUDNSUXNWSW5xL1E2QjlEcUtlMzVkYXprNXgxajZ6?=
 =?utf-8?B?Y2Q0VWpjNnlyazgraTRFeTUvWG1jTUVZVERtbVppektUWThBby8rQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sQbaWk0K2XPEhZwiVbpwxB42SsH0nXdZJ0QL0OtkkgNFK0wjBaKSVBv2XwQZeMjnZKitutf0afXeI556AE4r7sgOeuhiy+y2JAG9Nfsp7VlSbX+znPrsd2EUVa9kBKW6PFG7WysnbrBGU/IvQbWrtJbMd7OQIoLrogJpV95tXPSO7FGa5JHo9/GmGzxpXwR+wmu0tG5flVl1vNKB4xnlv7cG3JW7c5iWAYcnVVHd0qy9hnwU6IoHEMp2eGIJLBznr94w012mpdnamx9sq6hMcd4hFvBUyqW+EyB35EM1v2DZbhCnvdH7jFEDROzLeAHBXmhvcfEBF2jkT7FH4ciiBBGd5LBr2kB8Kq2B70aqzJnMbWp8ujy761HeWx98bgonNyLRXfPS3CwtqwsuOyz8OUenIJ9FE0TiTfX2/bVGiNFC2m83uP6mcAGWlh35SsA/uLya18z+aeIgh4KmQKNYcfqNSMMP3FwyNkpQZ9mfxyjv3kPuLHktQLWMPklWwW3idomtmCedGUxu67k8M43wc/+Ufq+wpQoh23IRkEGlS4q961m1NEb7pchUiqI1hcZPR7VoDBbMu6+BPbx/gbL2lNE2H7UdqCUYxlylsPi9ewU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6456896-7996-49cc-d12f-08de7315e8bc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 19:58:27.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5zBjq2we5Sthj1rtd6QvbCOX45Ysvtl9Hvv8hK9DcS9hrLO/HUnFJ/x/qexhADT/wfmUG4zzThKZhsKJ99mAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602230173
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=699cb167 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=WTJdmG3rAAAA:8
 a=yPCof4ZbAAAA:8 a=x7jSqGFpd6RWapJ0HyEA:9 a=QEXdDO2ut3YA:10
 a=q3NGepEMMmKWaCv8Sx90:22
X-Proofpoint-GUID: f75qKqvzP05msuF6b8Z8hU7wOJmbfTsZ
X-Proofpoint-ORIG-GUID: f75qKqvzP05msuF6b8Z8hU7wOJmbfTsZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE3MyBTYWx0ZWRfX6eDBaZWV6vhC
 rk55Yam0aYTL5lPKZN8rcd5hZp/h4Ui3VIYmy2TyS4Dh9aVzU0R6xyniIYzFgPcRQkwXuqMW7y6
 8yu/YFuudh+1mvCdIYo6RKivt+1+a1I8XlDqGTz6t0Y2DPxjWwzTGhFbJU5UDWHEMIOQFakx5pN
 XnHBfJ6g5YyPG1ZiGxbrChviGlBJt0rUKfDXVLntahVWe2bRGXgaXnDGQmVTdFgmWNlZWoKtIKB
 NOe5N3/ZVTHD0w+Avufaul0v4bW1ufeVn/bYreCHw9ih9zklddHpaG6VTDO83s4pOzELr6EnqAJ
 1YzOfcVSQeqT4YyPkr00/5PcbTP9WYOvDuskx+HpCg2Ong+rwMYRlqhB5vA+7IRDIApPbbyXgah
 8EodY7aQfNEo97wE7DPR6LtTg7walxZqD40OyB6qvwe/+28c2sLzIGwlpF4wtgMj33PUOiyIoRQ
 k/hdGGO5HXgFfBjbxQg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19145-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,oracle.onmicrosoft.com:dkim,purestorage.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E9A8617CAEA
X-Rspamd-Action: no action

On 2/23/26 1:28 PM, Eric Badger wrote:
> In the event that rpcrdma_post_recvs() fails to create a work request
> (due to memory allocation failure, say) or otherwise exits early, we
> should decrement ep->re_receiving before returning. Otherwise we will
> hang in rpcrdma_xprt_drain() as re_receiving will never reach zero and
> the completion will never be triggered.
> 
> On a system with high memory pressure, this can appear as the following
> hung task:
> 
>     INFO: task kworker/u385:17:8393 blocked for more than 122 seconds.
>           Tainted: G S          E       6.19.0 #3
>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>     task:kworker/u385:17 state:D stack:0     pid:8393  tgid:8393  ppid:2      task_flags:0x4248060 flags:0x00080000
>     Workqueue: xprtiod xprt_autoclose [sunrpc]
>     Call Trace:
>      <TASK>
>      __schedule+0x48b/0x18b0
>      ? ib_post_send_mad+0x247/0xae0 [ib_core]
>      schedule+0x27/0xf0
>      schedule_timeout+0x104/0x110
>      __wait_for_common+0x98/0x180
>      ? __pfx_schedule_timeout+0x10/0x10
>      wait_for_completion+0x24/0x40
>      rpcrdma_xprt_disconnect+0x444/0x460 [rpcrdma]
>      xprt_rdma_close+0x12/0x40 [rpcrdma]
>      xprt_autoclose+0x5f/0x120 [sunrpc]
>      process_one_work+0x191/0x3e0
>      worker_thread+0x2e3/0x420
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0x10d/0x230
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x273/0x2b0
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
> 
> Fixes: 15788d1d1077 ("xprtrdma: Do not refresh Receive Queue while it is draining")
> Signed-off-by: Eric Badger <ebadger@purestorage.com>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

