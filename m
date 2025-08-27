Return-Path: <linux-nfs+bounces-13913-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C6BB3854B
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 16:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82860464AEC
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94D1212546;
	Wed, 27 Aug 2025 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ldqdESlg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zX2RfTd/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4320459A;
	Wed, 27 Aug 2025 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305850; cv=fail; b=CvoDHzBbY6Xu8MQ2V6fTp9CrVuSgf4o/wo46nltk3W78N/jl9weNec2j1Hrz3LjveDsivEm0aOwjvYeVhAwWXpBlBewetSIE27OEfsVLKl+veDptJNWwgqIwVj2AOROFXRofl/Pyo8vGeqXhPGsG/sxA2E2MSIlnJQLb6RjlbVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305850; c=relaxed/simple;
	bh=KCE7lmPrAd9MgJZZsbKYy0+DL9UC54fsWnh+GQCm+Dg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yl7Qctu1pzKz8Qt34ph6aCutVJn8g5T32N5yKdMLtNKwxhu3dY4nGpjCxJ32v5gH53rHm7Smi2CjI/QEEOfRJlCgr9fVIapXBEsO79BX85CF+0Aa79NRp3HnJmE3h39lFHTZV3jkFEnvrCHYD8GehIVYiKwQejhsITN1UqSoR8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ldqdESlg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zX2RfTd/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7u7Ev004536;
	Wed, 27 Aug 2025 14:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hQGCpTiMi/nSasq3s1KU6qQRck9HTf6U+Se7mJ/qB+k=; b=
	ldqdESlg2PeBWXHy5z32qaTcx1XqGozDLnh1cEiwOg70D17b0DyE/4HbpKw6jlXQ
	xfASMkFspWz/ViLGo7neIoabllWRNeBoc1AeRx3yXC+ddY5CcQvZVKadQ7bt1NuV
	1TCpO/QhtDIh6WSIRg+NUF8Uttr9TjdkN+rYq3mG2HevZLePBjCXK+RTa/EvZlTU
	yh5UDKJVUVTXRHJlTs4SD4ktFovojeA4c0MTXJGd3S2JCo5Drsl05X/4HRqJWhn0
	boTV8bBvr4eutBx0p6h1d/CKr0CshxF88NfKdM11oKAxTLxWDRjSNAevc/gjbumS
	W0N0vBbQRLCBHibtJu9ncg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48eppe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 14:44:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RD6LVl018931;
	Wed, 27 Aug 2025 14:43:59 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43attex-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 14:43:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=io2z3nm30HwsIwn49gd/pTCFwXFaa5tI/2wLSugRcnNs/ZqFxRWoCXG6ugBl39nGjmegDpDxha4xoVyQi+Oj7euc4ggriMadRKoSI/DA4bLSgMPyu+3wtwQzNTl3cEPeIG9zE53qiyPH1U0JTeR+TY6lhqa9IOn69h3sMdGYfM39osQqAEyiXWraB0rzRTf77stAs8g/F0ZNPYnB12jHxzcB15APfFUkl09aoUm48KeXJeKwmnjhRQZY7kSAFwJBSAFpd/qhb7nhIcFEytqR7moDwQCEbU5FXFK6CNgASF7iYeGyq+35+NVUL0sAPJjnV+AjpiXDhhohXVDrtyP/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQGCpTiMi/nSasq3s1KU6qQRck9HTf6U+Se7mJ/qB+k=;
 b=yrFzNQhiq5pOK5N7cUl91DJRMF56k1un/hBoG2CGwBkMek1/IhOJfD+H9xKl6qCC8DnWLWXy93NokUV/pRqpoKtNG6Ge681S9k396/6XX9+lp8pX9E0DmyYChs9Yv9xeqHhxDCnJLQOMJvNUiXFeXjganLPB+yvgT2aJoCRet9Rb6NEtccJUFR9x1REUxbIbkLuC1P5Z1n2tN33wdbT/qIXNjX618FcicEYAidTanRIDD24ooSpbAQtdEStaibzXz5QPCnc8rMUfniTVqSg3CBPjZ98h0BfEqRRfiD10R6VeTBWJ1mr4SBKcPU5AvON1plztJ2seg8BkdOIAqBNqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQGCpTiMi/nSasq3s1KU6qQRck9HTf6U+Se7mJ/qB+k=;
 b=zX2RfTd//e9seXZy88OLCggWW4Y9D+OCsUJRCEUsOSrsSP99U/xd3krFTiJ+LmEfOe7AiuriXcQinv+tkb5uCJFS0UviKHdDWzValYUyXjLIlCaFPOBMgtWebjli7vs01YA3O7iAiooAQ6e1X7lCtqJGehM2n6StJEvEy7mksvk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6147.namprd10.prod.outlook.com (2603:10b6:208:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 27 Aug
 2025 14:43:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 14:43:56 +0000
Message-ID: <19c94d41-bf0f-47b2-8bbc-36911f5de656@oracle.com>
Date: Wed, 27 Aug 2025 10:43:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] sunrpc: add a Kconfig option to redirect
 dfprintk() output to trace buffer
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250822-nfs-testing-v2-0-5f6034b16e46@kernel.org>
 <20250822-nfs-testing-v2-2-5f6034b16e46@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250822-nfs-testing-v2-2-5f6034b16e46@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:610:118::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec4ba20-c3f6-476a-6160-08dde5782655
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QXFXWU0yQ1puUnB2WjVJV01EVjUzUkhlUDRxZEN4L2xkSFZDMG1uSmtVNUF0?=
 =?utf-8?B?Rks3UWo5U04vWjJ4RUpHRDI2TjUxZXJ1UXlVMFdOamhZMHZvUUUycWhsY2lD?=
 =?utf-8?B?bGk3VDVQSUdLcUtIOXlBQlBqaWh3R2FhL0ZFRExxU2FMb0JKd1pVanlBK3VP?=
 =?utf-8?B?VGZ6a0t0aS8vWE8zU2l1T2dhWGxSZGVBRjR4a1VqMEczSy9ITDZoMGVPWDg2?=
 =?utf-8?B?eXNCVGQ1MzVvRXZPenNma05QSTYrWXMzTUpZL2w5WTZFeFI3STAxT1ppdlBE?=
 =?utf-8?B?RFBiWURRNithMWhIck9NOGlFdm5QYmMzYkcxZ2dFNVFHak9VZ2hBVTJUeU9Z?=
 =?utf-8?B?d3lNM21NMkxFbW1xa3F5M1hCUTJOT3dYcGFYQWJlNFl3ZVlqdFJOL2lrb2s0?=
 =?utf-8?B?c0NlZUlzQXpUemtWWG00VGlKQlh5M3dsM2c4RE1RNjVSZjRUb3FSU3pHNFUz?=
 =?utf-8?B?RFVuQ3l1ZlJKZUNVSDdxbENMNFVMdWhuVFhQWmxDZnNacDNuRkhORTRvMDRp?=
 =?utf-8?B?ekp2NkdMVEJpZkJYbjhkS0UxU1NlNUZLZW16UmdIOUtKT3BDZFlHdURIakJ1?=
 =?utf-8?B?S3dMN3c5aDN6SkRzaGowY3Z6SnhaSUdGZ2RoeWJLZElDdXU1d0p6ZHdpYTNK?=
 =?utf-8?B?ZVlSWjB0ZjIxcHJxZFNVS3dhVG1mejkxQVIrenVoMmhEUTZqcjRtNzNqUUdC?=
 =?utf-8?B?MXJyYWZTMDRNWnR3MW5HS2l1OEtHQTdPeU1yUE4xN2o3UGx2cktBYU5SVDJl?=
 =?utf-8?B?bWNxNFpEcEhNYnJ0WWVMM2FoM3h3ZElYYkUweGxnN2NoMEN6MzRMTGlmVjVI?=
 =?utf-8?B?OHZib08zbEVoUS9OTVVjYnk4QXlwcWF6cXg4b3BKS3FpU2J4REdJUzlMTnZ2?=
 =?utf-8?B?TzJZNnZ6RStvR2xxeVdUdVNWUkh5aldab1JxQVFzMzMrSnZwODgrdnhtTTZx?=
 =?utf-8?B?bDRVVjNuZHlZeVBiT0ptdFcyUDFHUitkcHhjdEN3TWNVdE1UZk1tVVZtOTRL?=
 =?utf-8?B?Rk1UanFxRDFDS3d3TGIvdDBHb28rQVFwU0FnYkhBODI1VHZQUzZYZ3JDYndR?=
 =?utf-8?B?YjVqWXNDWHcveURpclJ4TmduUGVsSFlQdkd6MTg3S0NKS2FPS1k1WE12TzFS?=
 =?utf-8?B?TmRsLzVmdGJuM2ZXUmlLMFlGVzFCcnZNQUxiQTFhbGtOaHFGVXlBN2hWV25w?=
 =?utf-8?B?TEYyNHNCSi9kSVZHTWRZSFBmTmVqb0ZTaGxHUDRQdVkzUkFLMHVxNmxVd2Vk?=
 =?utf-8?B?T0Y3Zk5RenFheUtmV2t3MGxZcisxWWNLZWoweExTQUtyeG4rV0Nid2t2aE94?=
 =?utf-8?B?cHRjekFaUFd3RStkb0trS08xb2ZJVjlxbVJFRUJKNDk3RTdrQ01sY1VwOE1M?=
 =?utf-8?B?UTZ2aDBENUFYSkZ6Zk0veURRU0dUeTBKY2dXZ0JPVHZGSGlJeG5XT0RQc042?=
 =?utf-8?B?dnRhVWQwWWNDM2pZc0NXaUc3RCtUdXRmSlJ5a3ZhVjZnOUdzbG9pTUp2Q1VR?=
 =?utf-8?B?YlJlU0IwUWhPUHBrY3hIelh6dnc5M1dhQWlITXUvT0EvMXhSSnNzZGNTOFdW?=
 =?utf-8?B?Z0ZzbWFNelhDcFFxd3R4R1o0TUlaV2s3ZzJaWDRqS0lqbmYrRThuRTc3c25T?=
 =?utf-8?B?VVlKTGFwYW9MY2Ryc1dQSFFtRHRBemh5T1owbGlxOGJLdFpCakRsSWcwSyta?=
 =?utf-8?B?MlhrcXI3cDhqTU5lbWw5ZVlLY1Y3QklTNDFJVHhZdTc0S2w3SzBJYzdVU01Y?=
 =?utf-8?B?azBVUktCaUg0WVMzSkFCbHFsT1RoSEFramhLSGV0Mjk5aEtNdkVaeW5ELyty?=
 =?utf-8?B?Rng5blVBT3ppMTZRcTBnL3NnNnpxdzBZSVErdjdpSFdVQnQ3ZkNYYk5KMjF0?=
 =?utf-8?B?QmFhYUNTeTBmOWRZOVM2NFJVZ0tyc1JCNjJIL3FsSHJMaDBXTTFZeTlwaDIx?=
 =?utf-8?B?UGpoSmRNYjN1TE1wU2orRExmZmRVTHVqTDF0NUtSc1NjZ1BFZnRBWW5KckRY?=
 =?utf-8?B?UCtwRUtKajhRPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Mm1CWHVGUHdWdXdiSTIrOFlycFo4OGN0TW1pZ1NSTm5NbHVGVE1KRkJGZ0FR?=
 =?utf-8?B?VFhmdGVNbk9sNWpsRU94VitiaFU3Nmp0ZkpTZkJFTTNDQTJsQWdWemhiaDg1?=
 =?utf-8?B?MFJ1SXpvVnY0SW00STNoZEphVGowMGk2anF0Y1NoSmZrelZNY2ZYbHd5SlVq?=
 =?utf-8?B?ZEl5VjFSY1hVNTNxRW43R1czYXpvT1Y2MXhrRThFYXNWTlQzalVqSGQzOGtY?=
 =?utf-8?B?ZzlyOFZMekZrTzR6dEI0a2U2cGpGWkVxRlBUaEQ4VTJYWi92cTViRElGMU4w?=
 =?utf-8?B?ak1WTlNsVEwzc2NjUVA1UDNMRDFnUy9sOUp2emlRRlkwMElKQ0dEYzJHbjAr?=
 =?utf-8?B?bmNqbEFUV3IyeG5OZms0cDk0YUs3blNkSnVBbFd5WmlqL1U3NUgyd09CeUlE?=
 =?utf-8?B?VHFoVjY2T2N2Y2tUaTlUM0NBVGY3VWx1aTE4V2JqNytTRW1GYUZoOGlSVjBu?=
 =?utf-8?B?MVZ5SDlzWkJSeXMwZVppS3FFaXNEaWxXWkh4elJIYVRDemNkZlpsSVE5ZnQr?=
 =?utf-8?B?T0F1RnlLNHkwb0FqVDh6cmQwT2xDaE1iRWpMTlh1Tm9GQmwzcDlnbzYzMDRD?=
 =?utf-8?B?aEpBbTRiamc3cVVqa0hyMlhybzUvVnplVXVnWXZMcU5ubHUwR2hGL1NESkFs?=
 =?utf-8?B?ckdjV01hZk1haVlrYTFTVmxLVTZrdGNyZGROTEhxbFhZL2FEaUR1dFl3QVNR?=
 =?utf-8?B?RGF6MlJTWDZPVERLRzBLSXpVMC9UUmo5QkJLTnBJSUZ2a281aXF0dVhrZ256?=
 =?utf-8?B?T1M3N2lJaE5iMlQyYUZXeW8reHNVR2g4Y1N5K0JORldUMC8xNTZubGNWNGJE?=
 =?utf-8?B?ZURBQWFDU2lwTGUzRGd4UFFpU2llamcwQUg4RlJBV005ekg0c3ZrNDZzSWor?=
 =?utf-8?B?Mi8yVzM1bDdxYVU4aGFJanhMaEVza0krWUZqRHR1dU9pRGZmR2ViVm9aZi80?=
 =?utf-8?B?eFpsTkxRaGwwNWI4RWxMclJJS280ZWs0MFBraEE4SGRCZGpWdVV3eC9rTmxZ?=
 =?utf-8?B?SlpkUEczdDFON3RmdzMvZEt3ZG54dklXQWNKZ1FGaG5Ha0ZtMFkvVmJ6K1pC?=
 =?utf-8?B?UE4rbjVHeGV5azZXZk0xZHc3blZLbGdndHpueFZrYW94VitQczVKaHR2QWRK?=
 =?utf-8?B?djk4WlY2Qmlhc0pzWXpGYzYydUpQQjFhTG1HUUE2c2JERkdLelkyQ3lOZlZU?=
 =?utf-8?B?Kzh2WElkVHBCREN0Y1RERUhGbi9KSXdobHBldEpySG4wSjVqR2R0SGVQakZR?=
 =?utf-8?B?aExLdlU0NDMrSHFKVVFGOXN5NW02ZEYzV2taUGNGam1vcFdiUDgxcm10c0xq?=
 =?utf-8?B?WTJDV3dzdFB0RDZvbUczUGgrZFBnaVF6ZHlNak9zd2Zya2hSL3QvOWMyVDA3?=
 =?utf-8?B?bURVWjJWc2RyZHhMbVZmVXFzMzVZLzh6bEJTZHdpWkxMbnNSbHZlY1NDQzQ4?=
 =?utf-8?B?bDFvQWE2Z1pXV3grWTVvSnozOVQ2MDNkZVRGSVlqUTBGMGtvZVYxUzBYSnMz?=
 =?utf-8?B?Qlg2Z1RibndPZmRlUzhRT1BiMTBxb1NTOVdwYWdQVnVIRHBaM3IrdGUxVFN2?=
 =?utf-8?B?M0NkWk1rYTYvSHIzanNLZHZEY29VYWpRZlYvMWFoWlljRTR5eVlaWjd1WWl4?=
 =?utf-8?B?cHd4QkpqdDd2dkxkSHRqNUs5QUdYZitBRmpnMUlYWW5zQkRiNkh1SVJDVVBK?=
 =?utf-8?B?M2lmTEI4Z2hnZTZ0VVY3ZHc0UlY4bERzd2Y4RGZPanc3bHlseVd2VWN6UGxT?=
 =?utf-8?B?KythN0FDVGwwckdZUDZ5cEpqdzZzRlNyYUZTVEpvalZjMUgxRWNRODg1eENC?=
 =?utf-8?B?NWhDdFpqRG94TnR1eUVtR21SMmlwUmMxeWVwUTk3VEJnV0Fhd1Y2eTM1a3pH?=
 =?utf-8?B?LzhTdVAyS3pxTm0zZGRhQlFzR3BuUnR5bzhQNmhmdXoreEVEY0MzaGNQVE1s?=
 =?utf-8?B?UjBVTit6THV2N0Nqei9yOFNUQm5Wd1ppUDd5NVZMNzZZQUl5cHp5aTdrV25O?=
 =?utf-8?B?RFVRNzhEME9iQWs1Mnh2UjRKWjY4QWJZSXRIaUlYem85OGNZcGdWVXlmaEZS?=
 =?utf-8?B?ZFBBL09PNnJ3YW1rUDhpRzNxMlhZT29KVXNLTjZvRU1NSnNRbUdTazRiVVJU?=
 =?utf-8?Q?UD+KueYN8Nb/ySQGQaQCSp//0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CH7J0HjCf4BsDnDENpyNQkkxJMPGQIxikIEy7rjnc//8OyinqWnnTbKBCJ1oghdmE+hi5oT5g+1W2T31BOw8VIDrCo6MYZHh+nEFE9BS8EoIhY3uwl9WyQATCn1CpCXIEzZ0uRSy7Ec/9J3d+fFJuBYK7Sk8maF71WmdltT7V0mb+Mb1LWfYwDw9p0G8VKseUeGjw657PZmzL8t3sxKqwyQWUMCayw4GhZcmrJlkQS5OmDdpKLhhAS70n+nWhw00v1K99MGwcWkwbUNgvmZAWtWOloC2g34HwGkyqkFpE2JD9qpEhAWeAG4b92tS5LeJMSP8PN891xPu1fmGVMyQ/wstOiLlmBGiT8BBscQ3Nr+eY+gBvUceA5ywWS4H1VnngqWpQ3ft0gMFGwa/p9nMi5/fPLhpGK6JHnj1oKVn8l0Obf9ZylGHM9uXZewJBK4n+wx5mwoIglYSL3p6EbxaXZqtx/TEvWKveMo7oNBG/Uu5k/uyCM5kOIav7fmJS5+sWIoBaw7D94QkvT19tPq8tCsD36JCV4SHetgB1dyEG0tDWO9UqX3MWlM2SDwmx2tAw7WRsLltEb0VN+2I5fzZi2cwy/zc5yblhjFG4vzFhOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec4ba20-c3f6-476a-6160-08dde5782655
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:43:55.9558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRq7iKADvWMd/ZOk5aw74ByNFEilG/j2vVDBOd3npdi7vm8K+sAmV+862gcLKcLU8ruW8T2pC9JAp0LyILI7dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270126
X-Proofpoint-GUID: J5b2sXmFK3egxQFSR2F0uiQUAap1roh8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfXwEKq4eo8pBsw
 tznArdbDiq6RBxh8AtLEKQQfAqtafMzdPi7LBZvKD6OyuNwTJrBXpwt15L42dEb1Y8amVXxWSlT
 UbHAjltB4xnL1W5LUeASpoxcbkT7aPMB0YQCerGzPXiDnET3Isl2+pIQTH3SUeJHknPpd1ekjNS
 bDb8gBuQNPSM8Bd89HcFqEZuzFKMxlsEeZ+OXbsTmTfo7Ke5nCHm7S1abKm0zXBbfXSDnga9pC4
 eBj/NIDjdCyTDYU6HPMg7et99xO/511ocsEmTO8XO0TzD9X2QGLEDaBW/R3oduKQjg9fXqDvhA+
 SQ1e+RCHR8uXkUIosyDfgW+T+lERjOJgfUb9ovRZupmEvp3lfMDBxLTo/NoR1vOA1Zq999zP626
 wyovAz9t
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68af19b0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=kGgM0TLV_l6M7YMG-HoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: J5b2sXmFK3egxQFSR2F0uiQUAap1roh8

On 8/22/25 9:19 AM, Jeff Layton wrote:
> We have a lot of old dprintk() call sites that aren't going anywhere
> anytime soon. At the same time, turning them up is a serious burden on
> the host due to the console locking overhead.
> 
> Add a new Kconfig option that redirects dfprintk() output to the trace
> buffer. This is more efficient than logging to the console and allows
> for proper interleaving of dprintk and static tracepoint events.
> 
> Since using trace_printk() causes scary warnings to pop at boot time,
> this new option defaults to "n".
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/sunrpc/debug.h | 10 ++++++++--
>  net/sunrpc/Kconfig           | 14 ++++++++++++++
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
> index 99a6fa4a1d6af0b275546a53957f07c9a509f2ac..891f6173c951a6644018237017c845d81b42aa76 100644
> --- a/include/linux/sunrpc/debug.h
> +++ b/include/linux/sunrpc/debug.h
> @@ -30,17 +30,23 @@ extern unsigned int		nlm_debug;
>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  # define ifdebug(fac)		if (unlikely(rpc_debug & RPCDBG_##fac))
>  
> +# if IS_ENABLED(CONFIG_SUNRPC_DEBUG_TRACE)
> +#  define __sunrpc_printk(fmt, ...)	trace_printk(fmt, ##__VA_ARGS__)
> +# else
> +#  define __sunrpc_printk(fmt, ...)	printk(KERN_DEFAULT fmt, ##__VA_ARGS__)
> +# endif
> +
>  # define dfprintk(fac, fmt, ...)					\
>  do {									\
>  	ifdebug(fac)							\
> -		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);				\
> +		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
>  } while (0)
>  
>  # define dfprintk_rcu(fac, fmt, ...)					\
>  do {									\
>  	ifdebug(fac) {							\
>  		rcu_read_lock();					\
> -		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);				\
> +		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
>  		rcu_read_unlock();					\
>  	}								\
>  } while (0)
> diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
> index 2d8b67dac7b5b58a8a86c3022dd573746fb22547..a570e7adf270fb8976f751266bbffe39ef696c6a 100644
> --- a/net/sunrpc/Kconfig
> +++ b/net/sunrpc/Kconfig
> @@ -101,6 +101,20 @@ config SUNRPC_DEBUG
>  
>  	  If unsure, say Y.
>  
> +config SUNRPC_DEBUG_TRACE
> +	bool "RPC: Send dfprintk() output to the trace buffer"
> +	depends on SUNRPC_DEBUG && TRACING
> +	default n
> +	help
> +          dprintk() output can be voluminous, which can overwhelm the
> +          kernel's logging facility as it must be sent to the console.
> +          This option causes dprintk() output to go to the trace buffer
> +          instead of the kernel log.
> +
> +          This will cause warnings about trace_printk() being used to be
> +          logged at boot time, so say N unless you are debugging a problem
> +          with sunrpc-based clients or services.
> +
>  config SUNRPC_XPRT_RDMA
>  	tristate "RPC-over-RDMA transport"
>  	depends on SUNRPC && INFINIBAND && INFINIBAND_ADDR_TRANS
> 

Nice and surgical. But I'm on the fence about whether this is a
good long-term strategy. No real objections, though.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

