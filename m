Return-Path: <linux-nfs+bounces-4921-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1AA931641
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 16:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D340E1F222A9
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC43118EA67;
	Mon, 15 Jul 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a+MixAlZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TC314tyP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE618E76D;
	Mon, 15 Jul 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051997; cv=fail; b=gyw7IAa69ERGgKxU2lWyknjbzB+eaFdemOWnXhmXSBo1oQwbVKV9OOjGZ7NwBjaqpxfG/CLqwZSgUqXTAvSaSpZ3NdEY3adaP3pjwshZX04t26UlCkN+NwAoKZs+bQdmTwSHqMW8vV9YWbCcc3wurOPR1jb2qskAfeVHav8kl+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051997; c=relaxed/simple;
	bh=PEwp5EcVeUVhPCwkYfR8BJkjSg/BAkGzoWZfUnt6ZYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rClx/cfk2xySODAinwK3xkCcNyc7DnAkwRSgcGYUBfAdQGgnGa89EXTsC/uZBnQkVogYgQiccervjYmFAe7Cizk4Z2DmGmbw7Xp3v/mu4fD16wVHS9oSrUAorRURvN16JVFZDrDvUaXbWOc87fWccy8kQcrxt0kgLpVzgnIjrAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a+MixAlZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TC314tyP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FCtXc6006415;
	Mon, 15 Jul 2024 13:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=Cu4Rij6zL11Cx+vkMeqV1OoK+ptb88ma2+a2eCXQXUA=; b=
	a+MixAlZJt+DOyZ9r6phm8YNjH1e1Vkd+GCu8359a4uLUcAUWy8PQVf1Hqwocen5
	Y/JadoajfPBW3a7lX0HJ9RmAIeHVoyoSRP1tTplH8istQx4TteceSxt3gbHeECj9
	Ojbs3cqCqxvZSqu+T4WxdpPNf6kkwDwwpuPC+fA1tKn88ULNLOU3KqgkLzk1Ao7S
	2x8AAuA6xV98xb2qN8LQEuI610O6VebqmNmDDYf5CApbaxQIC4eHnalVhF5p7e5/
	L2L8kFnvrkkC6bJraLMq8JIjV1Mjg8pT4ChUKQyOwgQeR2RouNbb8UkydrAdspPy
	cY/mHlJ1W6R49oeu+KH+Vg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bg0ckgjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 13:59:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46FDA2EB040577;
	Mon, 15 Jul 2024 13:59:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40bg17dkr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 13:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPVJvCy3jQX4oqsxrYCrcc6lgAcQ2E08CSxX75xglnb/FTTOEMKg1VWlX1fQQzv3G8pxEPzbsntP7I7usg6rbNMFduytZCwpFUjQ7ntDQbBhA+7r3bCEGZK6dOq9g8kFaxKS/W8ULqCfLYokCOoFdtk1G48kYE0/EvgSKETBLRg6YmK1SFBdeWKKIGX2PCjYR3hDXTkcA5rAqKdBXxRvlCDlbnLfa2F+m8NYCR49nZxxuPDqwvt/JfDRq+dbyckMx9G5PSUUTvNmnHajVgxBjNqeP5B5uiBDOeVn0XODTeV6HlZW/QzjEdXK7h2WJL3EJriJMAeJRjlryYMdJnYCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu4Rij6zL11Cx+vkMeqV1OoK+ptb88ma2+a2eCXQXUA=;
 b=yhEEyIQOb2+Xsx15xN2Wmuz8HZ0xv/ug+cJ6YVprpoEu/5Ll3tW+AbkVGpbeGyF9Vnu5oukVcas/o62i8Vl1SFiw3hX/NIPmOlmTc3R3p5OdUshFRR0Ki8LEVvXK9WiAUJHE4c4Bn0xp1NDK6HQ71S8zTfBDyub2cuqFX3QYZgIaQQLGZMnY2tp9wxFoqxkr8VLvD9Byq8ifzGcswfWDGXY9gkFalhZq27pR31u/D91CkJrd9yOX9WpcLxCHtDYPk+AfNx3csYt6VKB2gfZNnLbBPzIBfHmohgtqs0ygwjnjRTCgprB195H/TievHIFxTHpgwaeGKHoLLmGalb6clg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu4Rij6zL11Cx+vkMeqV1OoK+ptb88ma2+a2eCXQXUA=;
 b=TC314tyP89GldhICiMEDNjhnup0gb+vwg1ZB+HpYUtceuAf2pwF3dvON8evmYFgaMqBtothumVGHdbn2qWIWDnYntKkT7327T+h/Q1gp3uf9ijWmgVeZhUR55746E3Ddxd2xYJLb3zKzw9p8g/qBiVC0B4CREltiBcRZpfjzkHY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYXPR10MB7974.namprd10.prod.outlook.com (2603:10b6:930:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 13:59:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 13:59:29 +0000
Date: Mon, 15 Jul 2024 09:59:24 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: cuigaosheng <cuigaosheng1@huawei.com>
Cc: Neil Brown <neilb@suse.de>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH -next,v2] gss_krb5: refactor code to return correct
 PTR_ERR in krb5_DK
Message-ID: <ZpUrPJ0hxqc7LaAt@tissot.1015granger.net>
References: <ZpE9luTCrUnh8RBH@tissot.1015granger.net>
 <172093150291.15471.15426043640692195014@noble.neil.brown.name>
 <8A935EDD-1959-474E-BB5B-92E0F8C2CF2A@oracle.com>
 <9c21336d-17c7-9e2b-2661-aa1d2b53ac11@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c21336d-17c7-9e2b-2661-aa1d2b53ac11@huawei.com>
X-ClientProxiedBy: CH0PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:610:b3::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYXPR10MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b743bd-b857-4998-70b7-08dca4d657dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L1ZxdUtrakhuWk1UdnczdWFPVmhEaTYzS2FBVFYrYWxMMU8raStoclNmODBV?=
 =?utf-8?B?dXl3SXd0dms1SjA5U3plVmNWQ2JKMmRoeC9TZmZ5VHJ2SDRsTXFDa3lJd25Y?=
 =?utf-8?B?RllEQnJoUzdQQkFXVlpUcXBCaXIyak1MUXNMYkNvc2FCbUlsNFZYbGdueTVH?=
 =?utf-8?B?OUNObHpTeU9pcnFGaGdaU3A1S0krcFRBajRWUHFVYWFvWFA0Rnlrb3pibTFk?=
 =?utf-8?B?ODR3TllxTFIrclcwUFcra1I3QmRZM3RsdDBxTTYyNHZTU2RYLzdsOWROQmRU?=
 =?utf-8?B?YjJrWEZCcGJsbXU1b2E4VE52T0NiK2VYSFZFTEl1U1pTTE1FQkJkQWtIUm5W?=
 =?utf-8?B?Q3lVQ1lCNGlEL1orQzgxSUdVR2tPZjhGc3BJaHBVWW1NNDNOeU5WZzlGNVA2?=
 =?utf-8?B?dUxTdmxHK1ZLMEE0eWluVm5BZS9TdVVSTWxLenlhMStGVi9kNlBONHJwM05w?=
 =?utf-8?B?WlNuR2s2QzRHYngwSFFqM0FaQ1BTOHZObmMwazlpbUdJM001K0Q1aENxL0hk?=
 =?utf-8?B?aTBCeSttMmRieFJxTlp0eG1EVTFrMStDbFlnQmV6dElTTjc1RU9uVUIyQkdP?=
 =?utf-8?B?MkoweUJWSEVZTTltSHEvSGFVdk5DdnZkdkVwM2JnT0t2OW1ZbVFWUzFUUHJJ?=
 =?utf-8?B?UnRzM0dWZG9qWUpHNEdrQkZ6ZW40OGdqYVdLV0RuV1hFMkxlM3A2TFBHWmtn?=
 =?utf-8?B?VjRPS0ZWblQ3Rzg1SkZJU0ZTbEF0eUg5RFlDNm92OEtVRmpwU0RtL0ZZN0x2?=
 =?utf-8?B?d2hoWnZJSmoweEk2Um9LVUp3L3RIMzNEMzNybDNINXhUNDJPMmdUdUJuUE1X?=
 =?utf-8?B?Q0RCNTE2NXdYVnFESVQ1TmFKL1JKcmZ3UjlrNXN4N0oxZkNXdlJMNVcwZHB4?=
 =?utf-8?B?REhPSlArTEdsc1hBcDFGY1Q2TWtZYWRrb3ZMaUsrR1FmeC9rNmZBamxVcFRj?=
 =?utf-8?B?cWR5NzVoWlpreFJMQ1RUKzlhWEw1eU5KYXRvNmFBM1lyc09kQW9oREVQbGlR?=
 =?utf-8?B?VEhwVGM5N2JodHQrSzF3Y3JXVGNneFRSV1dpM2dWdENndUdXaGxZdFpMZkRN?=
 =?utf-8?B?dmN4UFF1U20xdTJvYTRuZU4wZmFndm9selQzMUwzT3lWMXltQ2pWTEtaaEtm?=
 =?utf-8?B?RWptSE1aR1BteXg3NlhldUtoTm43ZnRYdHNYdTlwVThCbmNDNjZpc3g1KzhH?=
 =?utf-8?B?L0tjKzNEOXlveDRJNml1YjNIWlczUDl1eVhoMTBRczFMdlJXTGY4S2tCMUcw?=
 =?utf-8?B?amVPYVJxaGRRYlkyNkQxTERwV1V5eE1yaEx3cG5DTHhwbVdQVTljck53SnNX?=
 =?utf-8?B?dFluekNSN1Q5OUdnZXZjVEF0ZUJyVTdMNXBQbmp0dXdlNVF4VXlxN2NjcC9r?=
 =?utf-8?B?aWMrNk9MekNtdmxFZ1dDZHZmTHA0UXhGaFVzR0RnZnZiL0lrOWVmNlRnTjc2?=
 =?utf-8?B?K3J0SkNScWE2ZzVCN0lrSTdqZytiV3BnRS8wMVBDYmRrYkZsYjdrdGhLTUha?=
 =?utf-8?B?d1RkbzlSdWRYUExXdFptUG9iNUh2b3R2N1pCWU0zZ0JoUVh5blpHdmtCMEU5?=
 =?utf-8?B?QWU4Z3NyUWd6d2drd0dNb0F6emJFWGRHWG5RMnpyRjFpWk8yZ1JtRUFBSnRY?=
 =?utf-8?B?ejJ0c2hsUlpOd1cyS3FnblN1R1dma0FWMDZjK1pIalRLSmtEbXFOLy9adkY5?=
 =?utf-8?B?NFVDV3Z6dTBSNVdERTB1NSt3Tld6OFFOb3dCcmVUa0tSeThTVWFpU0lmS09o?=
 =?utf-8?B?TW50Y0h3OVpuUHk0aVZ2ZlJoNWczQXo1VVZRSE02Q2tWcytieDgyRk80N2Q4?=
 =?utf-8?B?c01vZkNXZEJQNng4Uk5rdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VEhmQnM0R2M3MGwwTmx4QXNZbTZZUHREazI3MlU4TFRybi94enJ5dW1lNDJQ?=
 =?utf-8?B?K3ZvbmI3MFV4QXluQ3FUY3gybXBwa1k1MWszWlhHTlRGcnphclN5L3hkRENT?=
 =?utf-8?B?SmhzM3E0UFVvcXlVK1R6cU9UYmpJcGdJbGYxdVhwS2UwL1RlZHNnSnBPSEZ0?=
 =?utf-8?B?cjdrNkh6UGJCcTNKeXFpdm1BUHRxMElHbDVMS0RoTEFqbDJvZ21XL1pLTHF4?=
 =?utf-8?B?c0d1UkVXRzdYVlFzNWUyd05KYWxzVW4rZEVUaHNWbjNFWUUveEg2WFdZNlMv?=
 =?utf-8?B?Y09rSFRleWxidXpFenpzeEJyaUlPMVYwSk0waENnVnJ1b0p3d2Z5aEVJUmJX?=
 =?utf-8?B?QUcxTGEzZHVrL2JRNUxOZHhZVTZzMEZDVjI0azlxcFFZTUF0dk02YTBsYVRI?=
 =?utf-8?B?c0l1K0NyQ0VhenV2KzE4c2VWZG5aM1JYSGhMcERCZUdLK0Z5anVROEwwaTVI?=
 =?utf-8?B?TXJDTjJCZERtVXh1Njc4SmlVVkJkWXp4UjBXaW5RSVB3TlVBY1JPaGprWlcw?=
 =?utf-8?B?L1ArckhhQjJ4N1lkdU9jbHJ0VUFZNGJPSllZSkllU3FXVW9CWTVBSXlpbGhP?=
 =?utf-8?B?MXE2ZTlVblN1VWVBUWxlSWJTSjFnTUpnTkcxTVNZTmFPb05zdExINUI4azNz?=
 =?utf-8?B?eXVycllUaE4xNXdjdEdHNnhRQjBQcmdxL05jdXFQb3pYV21QN2xYV1BrMSti?=
 =?utf-8?B?UCtOa0hueVd3Q1FYVDdSamZITlJPK1hkL1R2Yk5DUzZMQTFNYWowSlBwV2Jx?=
 =?utf-8?B?cnZvcnVMUUl3ZWZjeU1hQXl1ZXcxVU5HR0kzZ3JqUk5VbFNRQzRoMi92Q3Yz?=
 =?utf-8?B?YkxOb242NWxLeE15K2F1ME1SL1RNT0ZpTzY0TkNGOHF4N2hPbkpQQmc5Nmto?=
 =?utf-8?B?cWxreWdxVjBqYmhYOHZ0dDZtdnltdE1OVHR1dzByOXpZeUNETUJmd201bVA2?=
 =?utf-8?B?SytkV3piSmtMZGFuMjE1d3FXMFFmZDFxSFpCZTJsbyt5dzFLUWJ5cGZQWXBl?=
 =?utf-8?B?THNEN3ExUis5SlRSaldoRW5QZHJwdGk2Q0I5akdkNGF1Q29hSm81UEhhSUwy?=
 =?utf-8?B?bThzUEkzS1A0UC9hL2pJTzdVVUl5eEcvTEVmekkrSDJtbThGRHVFYW5tSzJY?=
 =?utf-8?B?aGgycjlaTElPMlBJMnJJSzFoQVlIOGJZZUljVitETW91cXdYaXR6RmlSbnFJ?=
 =?utf-8?B?T3Nxa1dJU2N0VkxrTE9MQTlvbGVybDY1STBKczJ6YXZSRXBiekhjNHFneUpk?=
 =?utf-8?B?eGwxSC8yM3JyZkdkc215YmFCdjlzQnpkUFRhbnJaT2FINFlaajFEeCtpZ2xp?=
 =?utf-8?B?bm4vWW9PWlRhckw4a1VKeVhCV3V4TkhqeVRsdlZhcEtJVnpHdUg4eGV0S3VI?=
 =?utf-8?B?NWlrb29zTlUwTU9nRjdGS2xWYk1DOEczcU1KOUhMVXBPVHVjMGZRYVduWG9y?=
 =?utf-8?B?YU9Kc2NzSzBianhVWW4ybEFiMy9QaDVFcVJFSEt0R05ZNDhyLzM4STUzdm1q?=
 =?utf-8?B?VkNVSVF6bUFhU0g5V3ozWjhCTzlGRDFoK2NoNTVKbnk5Z1N0cWJZRG9yRnEx?=
 =?utf-8?B?U1hjbDV3a0FxTldDcjZXM2tiNHRXemM5eWtjOUZ6QUl5Q2RrUE5kRXFJV1l6?=
 =?utf-8?B?T1ZDT3NVVy9hZWMwTHNDSXFJdVRRcmNSVjhBTjBOdEFHeE9MNjVsS2NuS1RY?=
 =?utf-8?B?NGd0OGFnWFFyc0RnUUY3bGlKTXlmSUlNM2p2Z1RIN2dEeFhnRkJnZXNOaEZi?=
 =?utf-8?B?N0tZeHRGclZzWkhKRVRPQlc3anI5by9nNk4rUlNDNURoMDJ4bldrYVZ6UnNH?=
 =?utf-8?B?QnBVTUpXM09OTFQ1OE1CbjZ0Y1VjWUJ4aG9XK1JHS0tJOUtuWE5yeU5LaFAr?=
 =?utf-8?B?WmI1RncvWUtjcmttS0cvRjR3dHlmQkpNZjJWMXdoRERqczI1TWRwRXNsUXVP?=
 =?utf-8?B?YXJyYjB4YlFMQ0gxdnUvcy96bVBYeGxWaHFRdTJhNFgvdi9sYWR5R3dZL0ps?=
 =?utf-8?B?SkRSQUxrYVk5SjFHNWdaMDNvSUxTZTJYZSs2NlFxbUdFcVlNQk1iUFBTaDBp?=
 =?utf-8?B?M1ZhTEYvQnZCMjN1M3o3SC9PNG9pNXQwZUx0bjMwNGZGNmFVc2dMSlpJSHhH?=
 =?utf-8?Q?7uXUgq+CNwM1KVdF5igYcrbOP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XxfseMLMSUFJYy1oYyyLC/uQfGv/oFURuaRFbvd5k4wAIvsPyV0slXUKd5B7bdoW2vs7g/f857oyGtp7PVdwnMGJJiPzkfKS3gSV9uTMV25kSub99iql6o1MdNJvzqEWZ9OtIXsHUbmIreW4o5Fbdf/r8a7Rn5JQGQpmh2QcDYRCQXrUkyBifrSDqtdY2sB6PcOsp6POG/t4E/2/RX0tImqOtVjJ28fseUxNkaPklmlKUIsRBVXup4WzbypgXQwr2SzVZ5GsRbUE4aA2dHULHsqpDbBpKf8oCanDiwN7ZcP0O7kBP9bdRzwt9HlYUhBC/ZpWz+pEXjrTgoRPUHCROARLFJ76XnxASDSr43EhJU/b3FOI/+1RAASNafX2c9yNQCYJpnnNlfl7GWDxpg9Hlsjt3tcS3eK22PCNWtjwr70MUo6WgMhrDNZlLS80Vfog5HAYgTfEO+fjcQxrW07Zz9+rR9+j6/3nxry++cMbch6EeofR4BK/yQb4CNad83hPYFVFnSrjkRVErFhfs+qDSOI1yFAisZ5BhYzsH4MEbnybPhZZ3KVTtUHM/StLtY6XcEWrCA6zNIceB+nrhT+0joDEmWJvrUgJljYf81ChIE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b743bd-b857-4998-70b7-08dca4d657dc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 13:59:29.3894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+5nUBmPDW9vNv51iiOz8GtUYRd5iOB7nj2f/Pzv3cbNOr4DHjpzml06cVVzP9pYtJDdMuI5moryTABX3VkkdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407150110
X-Proofpoint-GUID: nU8kJ-4uNhSgofpU-ARt8R59mtmDbViY
X-Proofpoint-ORIG-GUID: nU8kJ-4uNhSgofpU-ARt8R59mtmDbViY

On Mon, Jul 15, 2024 at 09:44:30AM +0800, cuigaosheng wrote:
> But crypto_sync_skcipher_setkey maybe return -ENOMEM, Should this be
> modified?

Auditing this path is a bit challenging. The obvious memory failure
case is skcipher_setkey_unaligned(), but that is called only if
the cipher does not provide its own ->setkey method. (Did you see a
failure case that I missed?)

So you'll have to generate a list of ciphers that krb5_DK() uses
(which is only a few) and then check the ->setkey method of each
of those ciphers.

My guess is the skcipher_setkey fallback isn't used for any of the
ciphers that SunRPC GSS currently cares about.


> On 2024/7/15 0:18, Chuck Lever III wrote:
> > 
> > > On Jul 14, 2024, at 12:31 AM, NeilBrown <neilb@suse.de> wrote:
> > > 
> > > On Sat, 13 Jul 2024, Chuck Lever wrote:
> > > > On Fri, Jul 12, 2024 at 09:39:08AM -0400, Chuck Lever wrote:
> > > > > On Fri, Jul 12, 2024 at 03:24:23PM +0800, Gaosheng Cui wrote:
> > > > > > Refactor the code in krb5_DK to return PTR_ERR when an error occurs.
> > > > > My understanding of the current code is that if either
> > > > > crypto_alloc_sync_skcipher() or crypto_sync_skcipher_blocksize()
> > > > > fails, then krb5_DK() returns -EINVAL. At the only call site for
> > > > > krb5_DK(), that return code is unconditionally discarded. Thus I
> > > > > don't see that the proposed change is necessary or improves
> > > > > anything.
> > > > My understanding is wrong  ;-)
> > > True, but I think your conclusion was correct.
> > > 
> > > krb5_DK() returns zero or -EINVAL.
> > > It is only used by krb5_derive_key_v2(), which returns zero or -EINVAL,
> > > or -ENOMEM.
> > These are really the only three interesting return codes.
> > Leaking other error codes to callers is not desirable, IMO.
> > 
> > But looking at the current implementation of
> > crypto_alloc_sync_skcipher(), it returns either
> > ERR_PTR(-EINVAL) or a valid pointer; it doesn't return any
> > other error value. Since it never returns -ENOMEM, there
> > still doesn't seem to be a technical reason for modifying
> > krb5_DK() to pass errors through.
> > 
> > 
> > > krb4_derive_key_v2() is only used as a ->derive_key() method.
> > > This is called from krb5_derive_key(), and various unit tests in
> > > gss_krb5_tests.c
> > > 
> > > krb5_derive_key() is only called in gss_krb5_mech.c, and each call site
> > > is of the form:
> > >   if (krb5_derive_key(...)) goto out;
> > > so it doesn't matter what error is returned.
> > > 
> > > The unit test calls are all followed by
> > > KUNIT_ASSERT_EQ(test, err, 0);
> > > so the only place the err is used is (presumably) in failure reports
> > > from the unit tests.
> > > 
> > > So the proposed change seems unnecessary from a practical perspective.
> > > 
> > > Maybe it is justified from an aesthetic perspective, but I think that
> > > should be clearly stated in the commit message.  e.g.
> > > 
> > >   This change has no practical effect as all non-zero error statuses
> > >   are treated equally, however the distinction between EINVAL and ENOMEM
> > >   may be relevant at some future time and it seems cleaner to maintain
> > >   the distinction.
> > > 
> > > NeilBrown
> > > 
> > > 
> > > > The return code isn't discarded. A non-zero return code from
> > > > krb5_DK() is carried back up the call stack. The logic in
> > > > krb5_derive_key_v2() does not use the kernel's usual error flow
> > > > form, so I missed this.
> > > > 
> > > > However, it still isn't clear to me why the error behavior here
> > > > needs to change. It's possible, for example, that -EINVAL is
> > > > perfectly adequate to indicate when sync_skcipher() can't find the
> > > > specified encryption algorithm (gk5e->encrypt_name).
> > > > 
> > > > Specifying the wrong encryption type: -EINVAL. That makes sense.
> > > > 
> > > > 
> > > > > > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> > > > > > ---
> > > > > > v2: Update IS_ERR to PTR_ERR, thanks very much!
> > > > > > net/sunrpc/auth_gss/gss_krb5_keys.c | 8 ++++++--
> > > > > > 1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
> > > > > > index 4eb19c3a54c7..5ac8d06ab2c0 100644
> > > > > > --- a/net/sunrpc/auth_gss/gss_krb5_keys.c
> > > > > > +++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
> > > > > > @@ -164,10 +164,14 @@ static int krb5_DK(const struct gss_krb5_enctype *gk5e,
> > > > > > goto err_return;
> > > > > > 
> > > > > > cipher = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
> > > > > > - if (IS_ERR(cipher))
> > > > > > + if (IS_ERR(cipher)) {
> > > > > > + ret = PTR_ERR(cipher);
> > > > > > goto err_return;
> > > > > > + }
> > > > > > +
> > > > > > blocksize = crypto_sync_skcipher_blocksize(cipher);
> > > > > > - if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
> > > > > > + ret = crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len);
> > > > > > + if (ret)
> > > > > > goto err_free_cipher;
> > > > > > 
> > > > > > ret = -ENOMEM;
> > > > > > -- 
> > > > > > 2.25.1
> > > > > > 
> > > > > -- 
> > > > > Chuck Lever
> > > > > 
> > > > -- 
> > > > Chuck Lever
> > > > 
> > --
> > Chuck Lever
> > 
> > 

-- 
Chuck Lever

