Return-Path: <linux-nfs+bounces-5047-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11C093B9B0
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jul 2024 01:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318961F237EB
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 23:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F49113A26F;
	Wed, 24 Jul 2024 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JVEiYsw6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zI/062IF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EACC139D05
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721865570; cv=fail; b=aCF+QeFeoGyoLVVMLBcIl5OABT8xI9hp1i6GNuKzwgMyZyl2WJ3dhncxUGbUreZmjsXs9V1ZyvktLHCi8myCaZMJ2X4pUVrcbHBbgeATLgMUJLpk2PDdulX0I47qNioW4CmxKIfiKZf1r7CUFwWrPlNXVlUdNy1jV1we74eBvLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721865570; c=relaxed/simple;
	bh=qYllQStY6n3uk+0YNbLAsZMeNfcj1osT/lrIvy4/gv8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=grP9nr9P0w+1uR9Q3myoqNsqMG7AWVwloaPvC7Xr52kZbhSMABbqV6Ev1xchWuZvCafHndHUpGi59xUIPIqk6FZr10gWz53Eit++p28jikapC+fWGZQAtJTAMXUcI3X1h+2Cj4mq2q50kTo8jgqOXfMkCD2upKRHpbO7jTfymS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JVEiYsw6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zI/062IF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OJe4FI024709;
	Wed, 24 Jul 2024 23:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:cc:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=JMEL3/fknWV2i+wzZgWWJcfWxzL0yUiZfnQa35xuKRE=; b=
	JVEiYsw6LaMfKv7B/y5EsksiZ1oUZLuvk2l5yVQuM9TOEsnf6ZEzEUu3v6gFl2u2
	EfdQoQiNAMp052mJoa/oWJnqzNb3HfMLUsPMAv3P0shW0oQ4RTdhU3gjZQV5wXb4
	0gmcSNjKIWB+bksIaykmwPSRPClCGmLGu+D7Q0KMb252OXwhPc9/hutPYtszzfIJ
	onZMen44xIgpk7srnTVrag/ER/TdJ+78G0hEPl8WZkJtlzJcA4ZO2fKodeE+2bAM
	F63kzCVj4kw1jFcOSGf/f72JajIl75KRpjTjnKZ7xDX0KYmoYuZk6zHe292jI4g1
	UMJFpGksheSkMI+8h32WNQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkr2138-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 23:59:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46OLsgqB010985;
	Wed, 24 Jul 2024 23:59:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29tbjct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 23:59:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fI4FWEAhG0EwG5kiDmhF3MeEwB3z85fcwUVIU0vveRO8T4iJ82PoxUhui447D2hvFy+wzK885KfSZLzlfaQ/qYf8bT3pRoL4Gaj1AM97G5wrEejAwFl+gDFwS1s5ps78kBT81GHjmmUm7vSHU9e0X0jqNICumEKa1VwSX9/eHhQArLrSBpJ85bAFTJM5F6PoBXkczppW6PoXEeoxZwKwrmtthBAr00pWsWDFsISIAHYKlaCtA48Xp08zlKs3GqzQQ4dqliLb3aBiv9Q7tHyIe3hw3m0LOFku9w4K9rnKRrUGrl/+7BU9F4AnMS/w2MQisebTCk5TImQm41CIDs4BbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMEL3/fknWV2i+wzZgWWJcfWxzL0yUiZfnQa35xuKRE=;
 b=iG5XsccwtVZ1RIv/0p3SedzGeICniuwlOShwCPi1QJKNACVgf+61pk7iib5uVjpIyzLOnWKX66RW2RQMYmBlQ0U+zQACFvb7OnDGDIQau9ymA23jZxdWFMx8LZEWdU07HZNh8XOQIHfhlmftQm3KLXh6YGPWrXYOBZoKSqN8hiMYqgCY0h/Xrrngj5UPsi7kPcBPTg9YyqQysSgP7ini+EfxdwyXjjGQag7TzbCbnFIDzxo3vsWHDvxSWX7RBAc7sgFtUJQ5d8FbAFEcmoPe07XdMl1i9mwDpVZ6WHOeAljzOTPQZhYQUEDZvxpWNfEo/xjL3wXaQZ369oTM7S5sBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMEL3/fknWV2i+wzZgWWJcfWxzL0yUiZfnQa35xuKRE=;
 b=zI/062IF1ymswAmCTOVg3Qy14Wcpz7/0JRzaBSUix0LAkBmL7t/hWm9CVsar48kE9/mEENDrGSxqk1+frd6x4/WVvw1Y1vKo4APBViOHSKsH5Za8omBhIvNQMLmKAR2AKt2v/0Q0mhpYckOSZZy5H1DFQAxNKRejb00qyzu0lhY=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SJ0PR10MB4608.namprd10.prod.outlook.com (2603:10b6:a03:2d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Wed, 24 Jul
 2024 23:59:16 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 23:59:15 +0000
Message-ID: <edbee688-d4b2-42c7-9a81-ebdf5a017fa7@oracle.com>
Date: Thu, 25 Jul 2024 00:59:10 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>
Subject: Re: recipe/example | nftables for Internet nfs4? << iif enp1s0 tcp
 dport 2049 counter accept comment "allow nfs"
To: linux-nfs@trodman.com, linux-nfs@vger.kernel.org
References: <202407231953.46NJrpWr3811115@epjdn.zq3q.org>
 <9a8043e5-9f97-45c0-a26f-a882acd1e320@oracle.com>
 <202407241617.46OGHVKY064027@epjdn.zq3q.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <202407241617.46OGHVKY064027@epjdn.zq3q.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::34) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SJ0PR10MB4608:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9c7a12-0a21-42e9-1e9e-08dcac3c9f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWJBeGxmU2JIenUxNGNuT3Raa2NRRzlLeDNNNDVPa1cweFhZcmVDcHlqQStU?=
 =?utf-8?B?bTFySUM4OWpUYkQ3c0loSUUrQkZDaGRXZk1ZM0lrRXN2dFAyUENCMG92LzdX?=
 =?utf-8?B?TjFkYmR4SlN1NXNhRTBXbDR5UnhhRmkrYmNIOWRqZjFVUzRBYnBEWm9rUXZS?=
 =?utf-8?B?YTNGV1NWV284Mlhyc3NIVFdlQThaUksxU1dsa2hCVXpHcUNqQ2NoT1REeCs0?=
 =?utf-8?B?RW10WmxxUjBVRmc4UmZDU1JmQ3Y4VUZBVEVmWlliOGkzZFZRYW9pL0ZmT3J0?=
 =?utf-8?B?RCszTURsNDhGbE1lNE0wNUpiZG1LZ3ZERCtZRHpiU1dIT05mK250YVJHV2Nm?=
 =?utf-8?B?aE0wT3g2eEozK1c4anZwaXcxN0ZsL1o2TE9sakVVbDJWSHRxdERMdjlRT2k0?=
 =?utf-8?B?Qk1TaWFaOHJLUUd0SnFMV3lNOUNvZ0NkVXIrWDNkMDVmTW41Y0loZURFRUdN?=
 =?utf-8?B?a3d3ZUwzRW9HNU8ycGVqMnJGNzhBQ0M0bzJoM1c5dW9IbTFlZnViWXZGQVo4?=
 =?utf-8?B?dDREVHVlTTNRK2pReXJzLzQvRkxjOERRa2ZKNGdPK1JxUXRicGhubTlkWGMy?=
 =?utf-8?B?SkpucVF0Y2RQZnJkKzBuRnRSd09jdkk4SGpmRGJ0QjRTN3hQVm5MaXkvWFFE?=
 =?utf-8?B?YncyRGR2UzN4N25NWlQ2MGtSa3M1K0gxT0xMU0wxcVZJQzg3K3lycmF5ZWx1?=
 =?utf-8?B?L3JOY0NYSkVZNHBNWlNTYk04R3BwTURlbnplanFRcHFlcEIrbVdqb0srYTJz?=
 =?utf-8?B?S1BWaFF6Vmw4Wmh1bTBqT0ZJTnlyQXowRWFhTFAxNzBubmlVWHFxelZielFh?=
 =?utf-8?B?cmduSXBHMFc1WloxT0tETmI3M1VXRUVHNm5qOXIySTYrWEU1OVhGT3FtNkFs?=
 =?utf-8?B?cklVZU1nbzdTNVBtTmVIb2J6NFdzeUkwcUpmYnZuQS91cTVuVHQ1dHhzL3Jo?=
 =?utf-8?B?MjZPUHdWUzRiL2hqdFZzT3JKa2VWeVc2QXBPbzAxcTJpQ1h3YklFUzdNZ3JF?=
 =?utf-8?B?RENNeC9SNVBHUHplcUVjREJHSi9WZEI5M1lJMW5tRE5jR0pPTG1xRjdOdmhR?=
 =?utf-8?B?TEJDUnAxc2VXdHYvNkRIb1RSNTBoaGU2ZFRhTW1mLzQ0blJCenVVU2lNRHNz?=
 =?utf-8?B?Mmt4aUZZUUw4Q2lyVXBlczJvUnlYNXUrV1g1UmtnVmZvRm1NNFhHVWVoVVZj?=
 =?utf-8?B?UXVSMTBuM3d4Z3dtTXh5c1NXbXR1TmVZeEFFSDVwR0RMM3MxL0t5VmliNGZs?=
 =?utf-8?B?YjBneW83R2x1eGpqWmFZRlJHaVozQXU4M2FQMXEwUjIralJQbC9ra1VSZ0Fz?=
 =?utf-8?B?U2lsdFFoRUtRMHJ3RDNzZ1pqbU5FeVFwMDBQZVR1L2dCL2FpeUlpVTZjcUhB?=
 =?utf-8?B?WjVQY1oyd0U1a2pzbnlweU5pa2JJUUJ2RWROK3BzMXk5a0U0c3JSVVBCemdj?=
 =?utf-8?B?SFluV2dtcHF4SktpOTBOOWtEbGZXc3hDVTRKc1ZESW1hRFkvbG9IVWpaejlU?=
 =?utf-8?B?VVBaejdrSGVuNDV3Rk5kS0kzV3Jwd01HN1dpZnlnc0oycHcvRy9US2xTOFVa?=
 =?utf-8?B?VnQyY0tNUjU4cm1JS1NTUUYzVHZIU1ZIa0tqRDdDOXc2Sk5jZHNvdUx1RHl0?=
 =?utf-8?B?UCtPeHFQV0ZQeG1wU3pQL1k5bFF0NCtQYnhzTjUvbU5iTXVWeXZwWEtqVFYy?=
 =?utf-8?B?blpMcXV6R3hsOS9EZ2RYaGZ4Ui9taGVIL0N6L09RYUF0WVlrekc5S1JKMDdu?=
 =?utf-8?B?a0VZWlBLY3lHV1Z6ayt4bkQrTTNaYThjeFUzYnVkL3k1bWEvRkRoZHJJS2lq?=
 =?utf-8?B?Vnc0OEVHemFHMU81WVpTZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm5wM0pIY1VLdXJ1b3J0ZkpnT2ZZZ0M5aTFhUW4xK0hGR1g5aDQ0MC8wNVNM?=
 =?utf-8?B?R2VNZjVoa0Y1VFFSM1BqdzJpS3VESDlheUJEZzdYNnVqUzcvNktkd1NPbXJT?=
 =?utf-8?B?V3kwaUtVYTIwQ01CTGFEWW9ZMTNNK0FkMWVtcStRMHVaWDBGK0FSbTJzczlQ?=
 =?utf-8?B?VUtyWXZyT3ErMUhVZUpNa09FeG1GVEZ5TVFYYVNCYlBjOGNTMGJsTGxSd2xM?=
 =?utf-8?B?ZGg4Z3M1NVlyTE1rTlRCTWluZmtnZ05rVjFvd0FwV09CMnZIc0NxN21FYm1K?=
 =?utf-8?B?OGdzZ3FDMmwwS0wyd3M0NjNGNzZDNG9lNXlXaU5LcU5wUFZkR1lGNm43OU82?=
 =?utf-8?B?bkN0NEU2YS9QcGhNYnVQTUdxeHdnWXEyN1dIcERDV3haY1RLUTIzWDNEVktk?=
 =?utf-8?B?TVBlcncybEpETExSOUd0WVdOZlYrZlkyT0N0ZHgzZEZLTCt3ZDJSVVdLd2ty?=
 =?utf-8?B?T2VDNlpDR3dxd1RuSkd5YUtLSU5aQjhPUzJTUEJRSWxReDNNZC8yamVtV2dX?=
 =?utf-8?B?cGpubHBxMjh3YzVvRlUyczZ1SHFoZjdBWjY2WUZLU2oyZEhEOGxlbjFHRVM2?=
 =?utf-8?B?MmV6Z09WdHpxS0U4NTFzb3ZtbVp1eFZSb2pYV0N1ekRYTWQ5VWdDTkFCNlpK?=
 =?utf-8?B?M1B1a0gyeURXUTlVeEhCS0FBaGhuQXc1ei9GSksrSmcxZW9JWlpXaEhoUExZ?=
 =?utf-8?B?WXIzdCtSL1Y3UTFMMEZWRW5Qd1BJNWJpeEd2NlF0RVVydENydGxiODU3b2pq?=
 =?utf-8?B?UGxaOW5BdGtBMEJiUndIRCtlQzZsMnVSN3pFVmNzai92Ris0dElnM0VhWk5Y?=
 =?utf-8?B?YUppeW80eVhTNXhUMnVHSzA0NU9peGVwQk5zYlR6R0JVQTNybE1LazlmWUhY?=
 =?utf-8?B?eVlQZGV0Yy95STdxck04R0FLU0s2RDIxWWtMUUtBWDZzQ0tkNEQ3c1lla1FN?=
 =?utf-8?B?dCtiRzNRSkVPT1hIV1preTViQVBDSlZRbU1WRHM3MEoyN3NpalpFMGh0T0hE?=
 =?utf-8?B?cGF2UG5JSFoxNVBzWUZDQm9YL0JIeEJEL05SR3NGV2FRYmxUcEdaZ0NlbGd1?=
 =?utf-8?B?aHU5cWRFUjJBWmVCbGszeEM3ZVZQaHk1QUV4RStTL1NhNkpucysrRWJLMDlz?=
 =?utf-8?B?a29UR2lyVmhNUW0yR0c3Vy9LTFdlWjlsUVY3RnJPR0x1RHUwVkdJRmNJTzF5?=
 =?utf-8?B?eHJ5ZkJOUUVpU1JqeEluL1lPOU9uK1htSGgzMWlHZjh5djNDU2Rvck1zSFRL?=
 =?utf-8?B?R1RQenhIODlrZGN6YVZmWkQ3WFlzQmhkSUxQZy9pelg5UDhEQ0k5WG1uTXV4?=
 =?utf-8?B?a0FjVmViWVJPK1BVN1N1TjZJTUtPeDE0akl0YnUzbkVRZnhFQlRlalNwdklr?=
 =?utf-8?B?eStGZEZTUlU0SUVlNDBaT0xJQVIyUDdDMmcyNVJ5ekpTS0grbnluVnBHRjBp?=
 =?utf-8?B?TC9OYU9XM2JhL3h0ZVl4UTNNOTJ1dkUvdDdYU3dRNi9rWFk5bExSazNVNWsz?=
 =?utf-8?B?ZjB6dm5CZ1d5MGRPSEZVN1B4UEZMd09KMlR4cnA3U1dSM2E5UXl4MUhoU2FW?=
 =?utf-8?B?NWZha1hIMnlLdk9nVjRUV00yM1hrNmg1SjlqdDhkbUo0dUpKanJSRTJLMnhF?=
 =?utf-8?B?ODZKdVFHVVY1VGxqRGNLZmNVUDBZU2UwR25ISmp6MWNpdTYzMlhlV0NNQmhF?=
 =?utf-8?B?SzBMNjkyMno3RC9FeDU4a1c2MFFDOWkyRzJRV2lJWjlnWENYVy9KNFErdkNP?=
 =?utf-8?B?NTNxM2JiNEJyeWpFMUFQUEVaakQ0T0cxSlhpQmFqRHNFWk5abUZwNm9kVVRR?=
 =?utf-8?B?aEpLbFpwMGxHZGhzMEU0YjJmRDZYNmlOeUNlOXRUckE3YWo5YWFuSjhRMmxU?=
 =?utf-8?B?Vkt3M0h6N2xNeld5OVNid3FXTXZUSFc4cUE1eTI4c091bFVJcy91aVJBZ0NH?=
 =?utf-8?B?TGZxVjB6SVRyRW92bzFsN3lmUGc4S0FRdWRqWFhSSmhqZzNMOE1nck9Rc1VI?=
 =?utf-8?B?MUpzbkIxZXpJZjV0WFczVGUzai9WdVU4MUNEQnN4NWsvT2U1aXVFSjQ0N0h5?=
 =?utf-8?B?SDRCMmh5Zy93YUdVSXllUzhVRVFqWUtiZUVseERFekVxWk16dmEyMVV2cFhM?=
 =?utf-8?Q?3/i4j4gnH3qIZsOkLvG04RTHq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F09a3yPlzHmm1mWt+X3c2hcvMIzQ7NQDtCtcEeaoNbjg3m1QmP4tkbK91J1gbbOT70UYjw3GO3nC0higg09BakhtAb9YFZamohZ89W8gBTItGQS3cF/ULQXAnU/7B0lJHLCdgsWU+o4WnQCcT1p0ymI5SVG4/swUzZZ9ps0PXgsqtiepohhM6IGCIVQm7JgJonMpNw7bkxtYHP+k3ovUvZkqLAhZWky5G24Bmbt47ksluqt5Ew0IZAdYdwfom2HCSatJ4I0v5y3Pa0et9yVfOx+Hq3GmDB+oVO4rMraRBAI5Jiuyp7JGLEUhcjQpYMF65e3LlJAkhiTlBnpdFoVYNpUxeDNJzTmklQPXradu8s9p+j8WOxB5zclxdim3FktbikJdOwB9W0TNtJJKHXLQo10kLIYsq87htI8gznWpk5tGj0FjCOBEX/pPQLfRwLxLn/8AFGmbBoN/GmCWlUD9Gl9lTiTNtlArLXPKDgdr9nUDx4bpnjHPBfHC1oULdvNDpm8KE1aLtXatU0ZwtTEZ4xyX/j2PiG5eA5tv4gdmeldHZ7JNwMpEcNtyS5Z3/M3sm33HkdBbNrTiWd1yN9raXxkXxjfOm9PtqXmdXx1Gbs0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9c7a12-0a21-42e9-1e9e-08dcac3c9f3d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 23:59:15.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OF5Ht6aWFXEVWtPnnVNi9wkr8hwHFiaxReKYISyMzJ9/tDaPOK8gONqeZjXkWSq4sD5c0cVtCRETcgh0Z3x9Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_26,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240170
X-Proofpoint-ORIG-GUID: KKGzO-mr83B-JpJ9vLmoEopGiN6oS6KZ
X-Proofpoint-GUID: KKGzO-mr83B-JpJ9vLmoEopGiN6oS6KZ



On 24/07/2024 5:17 pm, linux-nfs@trodman.com wrote:
> On Tue 7/23/24 22:28 +0100 Calum Mackay wrote:
>> On 23/07/2024 8:53 pm, linux-nfs@trodman.com wrote:
>>> I have a fedora server on Internet sharing out NFS; working ok for 3+years w/firewalld.  I'm going w/pure nftables on a new server. Does anyone have a recipe/example for setting up an NFS server using nftables?
>>
>> I'm still stuck on iptables, but I imagine it ought to be something
>> simple like adding this to your NFSv4 server's inbound chain:
>>
>> 	tcp dport 2049 accept
>>
>> assuming you have a default accept policy on your outbound chain.
>>
>> That's just for NFSv4 over TCP, of course. And you might want to add ct
>> connection tracking state, etc.
> 
> Thank you Calum.
> 
> As you suggested, I added:
> 
> iif enp1s0 tcp dport 2049               counter accept comment "allow nfs"
> 
> I then tried mount -v ... and it got farther but failed
> 
>      mount.nfs4: mount(2): Permission denied
> 
> Then I restarted nftables.service, It worked!

That's great, Tom; thanks for letting me know, and for the detail below.

One point: you should be able to change the numeric port "2049" to the 
service "{nfs}", to make it more in line with your other services, if 
you prefer.

best wishes,
calum.

> 
> --
> thanks!
> Tom
> 
> --8<---------------cut here---------------start------------->8---
> # cat /etc/sysconfig/nftables.conf |_rmcm ## comments stripped. enp1s0 faces Internet
> flush ruleset
> table inet filter {
>      chain input {
>          type filter hook input priority 0;
>          iif enp1s0 tcp dport {ssh}              counter accept comment "allow ssh"
>          iif enp1s0 tcp dport {http, https}      counter accept comment "allow http, https"
>          iif enp1s0 tcp dport 2049               counter accept comment "allow nfs"
>          iif enp1s0 tcp dport {smtp}             counter accept comment "smtp"
>          iif enp1s0 ct state {established, related} counter accept comment "allow established Internet packets"
>          iif enp1s0 counter drop comment "dropped Internet packets"
>          iif enp2s0 accept comment "allow local packets"
>      }
>      chain forward {
>          type filter hook forward priority 0;
>          iif enp1s0 oif enp2s0 ct state {established, related} counter accept comment "allow Internet est/relat"
>          iif enp2s0 oif enp1s0 counter accept comment "allow lan to Internet"
>          iif enp1s0 drop
>      }
>      chain output {
>          type filter hook output priority 0;
>      }
> }
> table nat {
>      chain output {
>          type nat hook output priority -100;
>      }
>      chain prerouting {
>          type nat hook prerouting priority -100;
>      }
>      chain postrouting {
>          type nat hook postrouting priority 100;
>          ip saddr 10.164.123.0/24  oif enp1s0 counter snat MY_SERVERS_INTERNET_IP comment "snat/static ip"
>      }
> }
> 

-- 
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation


