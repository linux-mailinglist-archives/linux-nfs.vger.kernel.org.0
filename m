Return-Path: <linux-nfs+bounces-11697-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF634AB5970
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 18:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9BA4A26D4
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447762BE7CB;
	Tue, 13 May 2025 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WJSqaHsF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kbbQiQyN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8333E2BE7CA
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152723; cv=fail; b=fwYPUsGHJMtidxl83kzShb15OVnHQXGSMSKvP712HoSLpYxMjGqXjBExMRMKt9XD8VtT3NZYkBtpr+Uw4R+64BK8pFJqZ7KnCK5Sq/YpYTyHn7pfNkBYQuSiV6pAFIODBMmft2203vmKC8zsPA8mNpofCCZEMMv+UEC5NJ40os4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152723; c=relaxed/simple;
	bh=PEVlel4pdFG4ZEmBhgxvbIFaRyzqOF4WXStX3i1dSu4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T/KrcWFryWBaRDx5KxCBQp9sejpzJaZO1aC+pYb4fom/d+YphYiH3g1AGsVf/gMNV1NKuuVqTJnOZsFhOMuOAo00nyGC25G3dUHSKQrKkzltxoeeY9VJDL8rX+5mRjuozId3IHqMmVUQnopc4OEl8bQTFzlOshSa399xxyc4XFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WJSqaHsF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kbbQiQyN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DCHM4g026625;
	Tue, 13 May 2025 16:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8qonIj9gtsJEfcVgunwwwfsoF96+O3jPnbkN2knpLt0=; b=
	WJSqaHsFSxXSTp6cMCAnOhxKOn9GJ4Atj3djh66dGd2Y8dqU++m+RuabpQQACNVP
	Loor751icIp3aa3xFxN4sHvPRQtmKqArESF24INd5aChWDS4yvJduUE3tUonlhDj
	x64qv0Imn4KOKLIkykejxc2FcFGjaR0LoZJwety4GGa2MtbvOizu2B/XER+6JIsd
	QEl+hRvW2hLEkQ85DLk1I3RBaCMGHzrAdQlOxLgu+CBpAi4AtIWrMw/560GjIPyy
	dZ4cUu9+UoNBOLfs1aQ9OOetOcxcz7YG0TYXGtrikiTG3hQVL+g5OwZG8NDq+YPx
	jJPw78tUjL71rZRAfu6Jsg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j166596s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 16:11:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DEwgDG004813;
	Tue, 13 May 2025 16:11:58 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011028.outbound.protection.outlook.com [40.93.13.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46m8an3hv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 16:11:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOSiUXnJqnu8o4UWsPbYycJ7sncVe6F4ZHgBfGob1T2MIULmGwwIzzmz+BfLnKlVbh6VbQCJFgHKHPuCN/BxL8FRAwiCPCRoNPRnwkSv9Oapfiw3pfSehmobN8MSRdfv3/vM+sk8T3U7vLnuKixhYkko8SO0Z/2jCdidFAkGejswbKlULEhOFEJZlHkSAE2VDmL2k/lh1trShlWbIDIUwJ+SNlkunZBsl1dNy+elZcjXeXJWdZQ9r99QtEMg15e6vNFNryoUkIgeMpjMHGNvk/L8NjXlcPZZTbqCCKplqCOSertqbsE/X3bkyKvQnKryN/fSOfnynl+MQVKp9Bk3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qonIj9gtsJEfcVgunwwwfsoF96+O3jPnbkN2knpLt0=;
 b=GSKYmNI4wK4cvwShc98niiJsgyYjNQWivJxIUM+eaGYvqJecfLF7fmzn73etz1ZVe825F/5JoHVIYJQ/06czrJ8iS7J60unnqjd23rN48S6FWNul1tDMZPfu033ZiWxYl3xUx2Z3MN/SzOfD7jeudv9nHBIp+9XO0ijxPkkzykkq3upfDFdHnauAxPzeIifD21Qm+l7ZaUN0agCfuM95YU/DzfxxieSUi19U/gK5ltOYF+kaZKo/PU9go8BgBtwSAJrtdrYewO5CkifWIgo/BnsN7/Out4/Ov4+K7S6pV13hzGWd9Za33N4TFjyqJ2NVMQs8G2CGGJYGkwlhoRAelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qonIj9gtsJEfcVgunwwwfsoF96+O3jPnbkN2knpLt0=;
 b=kbbQiQyNxqjr+rmrCvX0YoBmAiUOt5IOm1JxQFX7woYuqD0g7tQVNvoq0tk4V9cCFPcLLQgwQ5fwDf8FUhwo1cTiFJlhTPj5QPf9AsxVGbteTKTeiKEGPf0nsGC+dmvImg4Afdzxn/xhZb6W0OYZPjxe9siH/gwL/DnurFDBoTQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5774.namprd10.prod.outlook.com (2603:10b6:303:18e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 16:11:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Tue, 13 May 2025
 16:11:53 +0000
Message-ID: <de3fb73c-04f0-4466-a776-c90794f214a0@oracle.com>
Date: Tue, 13 May 2025 12:11:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Lionel Cons <lionelcons1972@gmail.com>, linux-nfs@vger.kernel.org
References: <20250513-master-v1-1-e845fe412715@kernel.org>
 <CAPJSo4W8cN6ZGuFDs4Dda6KDs29ggCrBOq4CJC5FGrXh+bYGGQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAPJSo4W8cN6ZGuFDs4Dda6KDs29ggCrBOq4CJC5FGrXh+bYGGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:610:76::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 213ba518-fccf-4d2c-a186-08dd9238e046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2gzeHdDTDZtb0QxRDZXRVZBOGZ6Z0VGK2wxRlExUFNxUmxJZ2VISHdKeEU2?=
 =?utf-8?B?dzJaOHhSd0ZrZkpDd0pCNitEM0dRWW41eWhiM3Vrb0RGRFc4WmVaUXJGV2dC?=
 =?utf-8?B?QTRlb2VkZmFsWHZ2MWk4WGRYOTkyN3lZY01vLzRoV0NQL24xeTZpdVZhbHVa?=
 =?utf-8?B?OVlnU1hRQi9rZmRCdTJabUlLWGNySmdnalpqYUZhaTgzUENoWVR2SjUxT0lz?=
 =?utf-8?B?YkdhUktWR05ncHM1L2pjMlo1UTlpbWcyTlhsMnhHamlmUm1HMXFzUk5iTHBo?=
 =?utf-8?B?QnBqZkxQSGZJRllUWGNUVGRzdHh0YnFjNGVoVDNKVjRRTU12NWNpN2V6THAx?=
 =?utf-8?B?Znc3aCtWZ2VrSmt4SEF6TVpUejRweGlpb0tMVGhyQUFIdVlPaDNqTHVWSnR0?=
 =?utf-8?B?VC9EdFNZNTZVZm82eEdaUDl1bk5Ld3VFMFlsOEZHa0lhTERyRTdwa0hGS0ts?=
 =?utf-8?B?TkN1dlVxaWs5cyt3U3RVektJOGxZenZsQkFJMWU5VlY3RkkvNG54d1lPenhm?=
 =?utf-8?B?ZnNkbjVkNWppdVE3cTBzK2ZvcDNsU01td2dqWG9UNzFsVXBNOVFYczd5Vk8x?=
 =?utf-8?B?VTdDYlVEdE9wVklhV1grTlpUaDBvUWs2QUdCTHlRcC94aC9MUG81bklPbEl4?=
 =?utf-8?B?QmZZeEdVV2ZsdU5mbGh0YkIxOU1lbEYyVGkxZmZkRUV1UFU4NlpJaDBscFNy?=
 =?utf-8?B?UWlGTVRSWFVOREc0Skc2cEV3Ti82b0JEVHNTQzEwcjdLZDJUcHhUSXJrK3ZR?=
 =?utf-8?B?WDdGTnlsN1FDWEE4TU9DaTV4d0duZ21HNEN2dGRZWjBiWGRjTEJUb2k0VHdV?=
 =?utf-8?B?cThKNUhpNkp4c0N1VVdxWU1GL083cmNROHFTS2lMdCs3QllGOGpVRWRjcVUx?=
 =?utf-8?B?UXNsY2tVejNTei9VRURTUlNpWFphVUFxVjhNcmJXNWJjMjU1UzBrRllDYkdq?=
 =?utf-8?B?cTlBY3NrTTJ6T0RQdjgxSGJFWGpFRkd4L2lqdHl5ZU04aHl6YU1qbjJrV1ZB?=
 =?utf-8?B?cXdSMHR4eFlDT0N4RUhZUC9BQ1pNUmZkVHBDdUI2b25yaXc3RlBvanEvS0RZ?=
 =?utf-8?B?SmczUDZPZWNyb1RuNlV2Q3c5N0lLU0xWVGZsUVJtbDFwZnJKcVdJZUY2Z0Fh?=
 =?utf-8?B?Wk92N3AxaG5ZRGdTdnVNNzFqU1RvKzRTSzZoWWw2Ni9OR0lXZXF1Z2h6Z2pN?=
 =?utf-8?B?aFl3ZkEwR2tHemR0Y1JZdFl5OE1DTCs3Z2lBYUVxVWFjbG1HWVJaeEJhRkVa?=
 =?utf-8?B?dTRtTThRWFppemNiS0ZtRkdMRlpKangwMFVSUHY0aThRSDZ5UWhkbWtUdjFu?=
 =?utf-8?B?NHNLYythN0VoVXpzS2ZzQm4vaUJja3U2c2pZc0haWHVncnVtbGFobytXcUd1?=
 =?utf-8?B?dCtoaHNTWVZwb3FQbWZidktSRWd6TGg5Y0VPaXJpYUtTK1dzMkFiOVdsUzI3?=
 =?utf-8?B?bmV4SWZrVTlIUUNKbUh2TkFpTzFXb2ZkT21CZURRbUxra0pmMHI1elZEK1hq?=
 =?utf-8?B?MjVjcXFVMFVtUEFSdUpXMm5zVGtrMStURUl2RVRuSlp6TWFMSFdDZ1poS3Vt?=
 =?utf-8?B?bHA0NkhWdUdrSXBJb1ZzMkZuT0tYempqZyt4eVdiUS8zMXpqSlNjUTlmN0ZL?=
 =?utf-8?B?SGs0bERDM2FqU1JzT1FnbGxzUG8xMEtDL0ROd29wNGhTY1RCWWwyQ3dTQTJq?=
 =?utf-8?B?NDBNQmlsVFQrL05Nclk0bzV6UVJEak1OTTUyQmFnOGhJeS9JRHBCYk1qZGxh?=
 =?utf-8?B?UjM5amNpS0V4dExMclkwMFRyRHVEN2orSHBuK3RCK2d0MGVhNVc5blI2clZV?=
 =?utf-8?B?eUtaSzhPd2hnS3JLVWpTQVU2Z2lrNnlZWWJnNnFIbWJCTWYrdUdVbVB1Z0h6?=
 =?utf-8?B?SmtRRElFRW1tdWZmNVZRNW8zSzUvMXNKVitVOXl3R3NrVWRMUGlLZER6VDZa?=
 =?utf-8?Q?1CETm4dJtTY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTBTQmgwTmVwbWMyblBrb1VGWGRYL1BKSkM4SktNVDkyc3dXeXNadEM0UnY3?=
 =?utf-8?B?L05HYWlYREdYQit3K2t0OVNrS3cveGQwWUNkaEc5WU4vN3VIV2tDWW1rQ3Bi?=
 =?utf-8?B?U2swQnpacThaRGgwMjkxYTVwNXMvYi9GVWxzVXJTZE0vY1hHOU1WUzJOTXZE?=
 =?utf-8?B?OWZFZmtWelNuT2RBdmxGN2I2OW5FbHcvMnBQeVRyK2swSUkyYTFaa1U1MERX?=
 =?utf-8?B?N3NFbkJ3RzNWVWRaY2loZXoyWVFCZnhqZ3hKS01ES2xOYXkzT0h4bDY5aFMy?=
 =?utf-8?B?aSsrVjY5WGJ5WWcyYkVES3o1c0RhdkZPR0gweFRtTk5Lb1pqa2p3Znp0aWhl?=
 =?utf-8?B?aU9TOG9Hd24xQ3hVaGZiTjJMamMzbVc2WmNndzRVRnovL0dxenA4N1hxU2l2?=
 =?utf-8?B?N05reXMrUitjMEV6UHJIbWo5NFUxVUVscDFobDYydmpzbmxhMk5RVm9HOFdC?=
 =?utf-8?B?aS9Xb3paRVcvVGo2ZFB4Yk05TGtaLzlXNCtlVStRcE5VSk9RcGMwZHpiMlhv?=
 =?utf-8?B?Ty9Ea2NKZkJldXNDUk9VUmJnV3RvZGEvWGxRZ0N6UVQzbmRvWXhwS3Q3OUR1?=
 =?utf-8?B?MC9Rcnl2N2E2aVp1eUYyOGVreTloclN6ZkROVE1mNVZRNHA0eGZFWDdsWGdi?=
 =?utf-8?B?V1BmYWZPZEFuc0lySVl0ek1JY0UwdzkrTHh4aTZOdjVZQ3dNVEZDN0Yxa1BV?=
 =?utf-8?B?YlNnNkdIZ3NSNzVpUVVYZmFYTVBVUjJiSUFRWVZiZlQ4cnZ1a1Zpdm5aa3R6?=
 =?utf-8?B?c0EzVkg1WGdpdGtrMTRGWmJBdVdQNlZrRmFLNkw0VTJZbHBQVjJVQ0g4bXBs?=
 =?utf-8?B?R3FSYVhHVVdOYjA3ZitjRnZ0OWRta1laa1dHTWJzTDgxcUVaQmpXUVJwdlBN?=
 =?utf-8?B?b1NSNURKL2ZUT2gwS3VFakRhakc4NEJXb2d6amVNRndwZGpPNk5oSUhEYjgw?=
 =?utf-8?B?OStTMzYrTU9ZN1R2MkVFWlV1eGliRUZ0Zkgrd2RZSVBiQmw5ZnQwM05wL2Ju?=
 =?utf-8?B?QzFBUWV5QTlyYXBmOHJiUlRINHNIY0hzOUJpOVMrRFhkQlNzSVNIQUErRUY0?=
 =?utf-8?B?OVJXUFpNRjlDYzZEZ3Y0Lyt6YVhCT2Z4S3BEZkkyb0wxN21JcjF6Q0NIR281?=
 =?utf-8?B?T3h4VTFpSHpwUU9UTXliV1ZBUzQ0RnN3RUZxZjEvbTFnMUVJaVdtZVlXck5Z?=
 =?utf-8?B?Zkdvelc5aTcza01nbWNaMFY5ZDlWOEM1OWUrT0ZSdlM0dmQ1ay9vOWFpbWJ5?=
 =?utf-8?B?dCtuQ1VDQnVFTnFmdjNVQXljWGNpQUgxMHZad3FCbEhKa2M1emVjcHBCQllC?=
 =?utf-8?B?TUdmbHE1NGpTcC9JL1d0a1QyT0lXRzJ2OHhTS1VQZkZOcTVtTWhtZUhDbm5q?=
 =?utf-8?B?OVo5T3UvTkhoR01NTGlqTmJsL1NueVBTUWpXZlQ2Y1hKdkhCcVo5TExkUUlH?=
 =?utf-8?B?dmtYU2pQd05ORHdueld0TFhLWE5wSVlTWmtnbk5JMWJxSUJmWVJUZ1VROEo5?=
 =?utf-8?B?VEUyYmNtR2tuSEZ3OUZYaHVqMDJPb29udE9Hd0VuWE9VeU45Q0Q2YS9GUnlz?=
 =?utf-8?B?QWNDcndub2RkUGw5Nlg3WFdhSmRLelBvdS9ITGFjR2k1MUoxWDZIaGZhQ0JD?=
 =?utf-8?B?THBIcEpQeWRpRnpUWHNHOTd5Yjh4R0NwTS94QUhrUmx3Y3plNnc5eGhwaXRR?=
 =?utf-8?B?UUFOMHF4dTZmTkJ3M1hIYXJ0MzJpK2cvUUZiY0RhQXFtMkdWbktKaC9tQlVq?=
 =?utf-8?B?REoxYTZJa2V5WlM0WVFmdFdia0grVXpiNHlVWitBTUppWm5Cb0hRK3k0N0NK?=
 =?utf-8?B?YVFWem40MURiSnFUQXNyQllDRVlCVHpuZmtnek05WlpnbzJHZHNwc0xBWjBh?=
 =?utf-8?B?Z1k0cmNqZlg4cWtvRUhadll4aFlpN0tRTDliNlNlcHNUd3Z1eVdkbExVNENt?=
 =?utf-8?B?WUEyY2FuWVE5c1UzOWZXNmdMNSthWWVzUXJOdzQzcU1JYytqMDhBYmVSdi9i?=
 =?utf-8?B?NnFXNXJmNTRNc0Myb2ppY3RtNGo4S2ZQc3Jzd0g0ZzQzVEd4akRvZE43V2ZE?=
 =?utf-8?B?TE91Ykh3MG94OTgxamNoRHlVSlgwL0svNjJXODg1YVFSMWZMd0lvWFc1S3lF?=
 =?utf-8?B?UEFZNHo2UTR2cFNULzZCWElncDJlQlN4NnJDcWh4d3NPbEsrN1ZDNzMyRUZh?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FTUEMWih6KK3RAXBpvAWhfcP4SuLmYGs/cq21jSvcg+ay0efpG7BV/zHeRppJTw1qwXkvIaHnyWROGtc0wgRY1mON22P5MwmlRwKsj9qBn0yAxzEZW8GaJTaizFU1H+2H6cQ05GtQxFlJZrumo+YmQJyfanQ8gRSZbb33NWkH0P9Ep4IzyI8KT8wPenSgI7dQC1c8PgVRTYc/5sYcWqcLLwwEWSt9tJgb9ekEN5qCzbGWxN/sErNau5PdunL0pgSImop/E/Hf5YzLVFGx9ydsL/ajIYgLUIRdByidSK4CnkvKnX++A7g7aCGtoQlGLUFDPVq7sdb31KOO5WhYsq95w69vQcRpdLbwYbGySfwaAC4FsjFl5JIGzB0a2bPwDTFkusG8i7+IAAm2oNR+w1pXZzJrvS722v9v814D4qZMnBMyWOKNMPwSROefezb2SLqj9REfKj1MnfEbYTHlw3tlb2dme6R2oC/YBi6e58C4M1XI+/4Xle9Bo1LrH5hF6OVWh+LvleCfTJW9MbKRV1Ygjb4PXi6SvAOwydxYUuWgUKuxNQx7VL4Pm5fRhtN8X2eqPUalC3t9YSpmvzCOQzstHw+aMc2FadqsfDvzflOKkA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213ba518-fccf-4d2c-a186-08dd9238e046
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 16:11:53.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khwzKK1UyN5eesHMLIMvgCJ+oYJcGYo+G3S08B9zEZKwVx8SWgEGxEH4N+faoWt0eknjQTpgucMkI7WPcmfMrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505130153
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE1NCBTYWx0ZWRfX2OqwJzoXM9i2 zIuFpbyU43YRcC/JXJkPRXXxXOm+KzfwWll9/e0YNpQo8+E9ET1sWaUQXCE+1bBX2XzA6DhwPJZ rOP1tOQi3Zg/FBNrY3sqZQrAlk+zJjrToqJy+W9rfkh/XaBokwSTvvWacO/1UY8AYvLYIMWQIqS
 GM/XqI5ZJg7Lhpcx8VG2V6Gd1dFDXD0Ju+6YCaNLAOSZPDD58EfQyaqonFcC4GDa74v9Krpe3nP ap02U2g82t/wgcM51UyfUAPHu6yr8I0ig5XRoYod/MWAWbEe926EN6+RPaJ35MWPLE9x4q9vPd3 geRSaId1IUIp66fjaiSgnXr6LkLoiUZx8fn3gqy9fWiC06AFQ5pYas2o4sX1K5RsccvXMBxyUk3
 mKAyz5A5NHY3blH/NSs2QPBYdba+4uQL+Vng++pB9iJxj+uoXeq9j2OXq2a/+ktCNCjDz8Dv
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=68236f4f b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=y--QDMLOsVaEhvxR-IUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-ORIG-GUID: XxFqH8blcp_9OG3E8L3MOXLEIv-hBQZf
X-Proofpoint-GUID: XxFqH8blcp_9OG3E8L3MOXLEIv-hBQZf

On 5/13/25 11:14 AM, Lionel Cons wrote:
> On Tue, 13 May 2025 at 15:50, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> Back in the 80's someone thought it was a good idea to carve out a set
>> of ports that only privileged users could use. When NFS was originally
>> conceived, Sun made its server require that clients use low ports.
>> Since Linux was following suit with Sun in those days, exportfs has
>> always defaulted to requiring connections from low ports.
>>
>> These days, anyone can be root on their laptop, so limiting connections
>> to low source ports is of little value.
>>
>> Make the default be "insecure" when creating exports.
>>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> In discussion at the Bake-a-thon, we decided to just go for making
>> "insecure" the default for all exports.
> 
> This patch is one of the WORST ideas in recent times.
> 
> While your assessment might be half-true for the average home office,
> sites like universities, scientific labs and enterprise networks
> consider RPC traffic being restricted to a port below 1024 as a layer
> of security.
> 
> The original idea was that only trusted people have "root" access, and
> only uid=0/root can allocate TCP ports below 1024.
> That is STILL TRUE for universities and other sides, and I think most
> admins there will absolutely NOT appreciate that you disable a layer
> of security just to please script kiddles and wanna-be hackers.
> 
> I am going to fight this patch, to the BITTER end, with blood and biting.

Lionel, your combative attitude is not helpful. You clearly did not read
Jeff's patch, nor do you understand how network security is implemented.
Checking the source port was long ago deemed completely useless, no more
secure than ROT13. Solaris NFS servers have not checked the client's
source port for many many years, for example.

Most of the contributors and maintainers here were first employed by
universities. We're well aware of the security requirements in those
environments and how university IT departments meet those requirements.
Any environment that requires security uses a solution based on
cryptography, such as Kerberos or TLS.

Jeff can, of course, ably defend his work. The reason I'm responding in
this email thread is to make this general comment to the list:

This mailing list is not a help desk, nor is it a users group, nor is it
a place where you can come and ask for new features without providing a
single use case. This is a discussion list for contributors to the Linux
in-kernel NFS implementation. The active word in that last sentence is
"contributor".

If you can't follow along or do not understand a posting, please do not
respond to it. Or if you must respond, first ask for clarification -- if
something seems outrageous to you, it is highly likely that you do not
understand what you read.

Think carefully before you post on a public mailing list, and please
respect your readers' time and attention.


-- 
Chuck Lever

