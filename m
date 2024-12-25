Return-Path: <linux-nfs+bounces-8778-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA569FC5F8
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 16:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97EE91882AB6
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92F253363;
	Wed, 25 Dec 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RZv8AO4d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fiqGqEuG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9C2E822
	for <linux-nfs@vger.kernel.org>; Wed, 25 Dec 2024 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735142071; cv=fail; b=C40IcV02zH1zhP/EzntVVQd7p+xXEc+vROpyxrxDqv/r3vuW/NVlQxsCc2psTJcHmOS4dkB9yb1rIYic2Lbljw5TWULT9781vLBtlxiprVXIGbAE/nrvEXERWTlL6Ud4Oz4hJKqRrCcT0Bkk1lRuRo69DzFwATBxlZpblTwtzFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735142071; c=relaxed/simple;
	bh=6f8zeF0M71fhb0f//ZvC9aoY6AFUCRSJH69V0H+F53I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OVAaNDDWpqTEIW8ntEPwjk4joCfgQmNr2yRIF8s4cTpV9n9QPwL34eyi/k/SwlgOt0qrE4Kmd16RrYl72GTmC6sZxdrBo1BsE6QFBCIhuqVSZcP2APTpsr9hl7KsBkYgtmkans369cZM8SOvqeJwVZtz6Fk1VGmJKp1wmGvCh68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RZv8AO4d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fiqGqEuG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BPDNHp3023824;
	Wed, 25 Dec 2024 15:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eMfFXy2f3Lw3vm3RyktrouDV6xiSrovpk2DcgfAZbpU=; b=
	RZv8AO4dsRWBjcv+hnz7VoCPunlPeTPxgv2OcDModpzvNmnek7jFH89m+54oShoW
	7RLDO24/WYh1bw1k9xlJReiT6921GvQv2mEkM8tzYn6oWMDPDEenc+15+uKsjtNA
	ZFlkCNVS0G8txRMXvO+fAnLhTag9IkfOVu6uGhXqwzf0mE99hFXHih+MD6JXwNH8
	QVvzuefuNjacC12D42KFlg6ZCG0YF5JCFPp9cEjw2b0cOuQnG2+TJEktxeaUrJ2k
	5Sp0m++t2HKxNJ5C6OL0/5S6yZt6sUN5GYosgg2v8E3HIbMyrmF+fbtcLzIakVLP
	4miIiSTqizmEHOo+xp+y4w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq74dfsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 15:54:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BPE5BY0004497;
	Wed, 25 Dec 2024 15:54:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43nsdhkudj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 15:54:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6bByAFg/29OLWtRz1hnihUI2Wk9a3KMvYLgCmzXhIWuzrW1+sHHonJ1jlYpTpOXmC7pKUzOCSzq/6JeLnPOpcBBlWinTPv8lyaHvczdca3EF0QY9CvymFTgIlinkMZ0YqS3YqF29rdkIf9WG/jW9EErC22HQTonrUzTVH6/PzvzUkcPVYMKizn/6+TtDWIBzFOHA1zky5b3X4t505sRTim/+HsR7YFpctNTMA4JXqAYxNu/DJucXs7fFe6lrRZl4xqxyfAq/6yfXpSvjwNsAiszsrMW5NlhvFpUD/L/LgNF2kndxUODXSTj8d0qhaLUb5rXdvXAUaerXCW39z/y3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMfFXy2f3Lw3vm3RyktrouDV6xiSrovpk2DcgfAZbpU=;
 b=trRQxGXhRbTky4ewFCA+pszQKBayhMp+MZ2yoi2hdvy95KeNYmULRlvtodughvzwL0doCxMTUeSluGByumfynyreXy5/KPN4BFKD83fm0oqgjnAoKe4EM0US7qGydpyKqpEEWboKBs11Y+9hkBQIznlw2FJHye6arwmCDTGRapSeasicbEDaULv2L1bv1NBryq2KQcKm0e2EwgtKDv4o5I0x/f9pOQwA2Hzu9+7v9Ykg/YrGGDMNwS4TEStEDkPGTiJ1K5M+5WY1QY3iwtAQWQcx+6D4a9s84w10mwJc9v+v5XjXVdsA4QYt1NmW1HBDPIsZLXrDiNqqv0pECljedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMfFXy2f3Lw3vm3RyktrouDV6xiSrovpk2DcgfAZbpU=;
 b=fiqGqEuGWklfwKs8FXwHrc8SRxelwFTCLtxfuEZSv+q7h2WvGAI7/BQhPXreEB4SOyQz32LbjeE0TCCEMCrScaLt6OZ5RxB75NSwbOd4IY3uW/fxyIQiaEWXxXA85pln3fPGYGjzM/4UL/byUifd8U548IxqiADPQVw4vzF+FZ0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4490.namprd10.prod.outlook.com (2603:10b6:806:f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Wed, 25 Dec
 2024 15:53:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Wed, 25 Dec 2024
 15:53:59 +0000
Message-ID: <6947d3b6-ac19-458a-9805-f4cc8a649433@oracle.com>
Date: Wed, 25 Dec 2024 10:53:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] NFSD: Encode COMPOUND operation status on page
 boundaries
To: NeilBrown <neilb@suse.de>, cel@kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, Rick Macklem <rick.macklem@gmail.com>,
        J David <j.david.lists@gmail.com>
References: <20241223180724.1804-4-cel@kernel.org>
 <20241223180724.1804-5-cel@kernel.org>
 <173508234339.11072.6073436862662738502@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173508234339.11072.6073436862662738502@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:610:38::45) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: 897d5c5c-f21a-4342-31bd-08dd24fc5876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UU11b1g2VWRFYlJDdFptTmFuVmZKVVVqUW9HbThUUGZXT0NDdVRhZmZMdC83?=
 =?utf-8?B?d3paeDN5RDhkN3VWUjU5a3pZRzVDSjhiSnhZWUNDZ1YvUHJiU2lVdm9ibEhr?=
 =?utf-8?B?YStWMVZYUllWZi9sdlpJdFFzTHpQMSs5UFBON3QxRVc5WWpBV2FWdE93L0VJ?=
 =?utf-8?B?akMvVzF0NlVqSnJScGJ6b3lMbm5JV0N5bVNIUlgxbU9PeUxqUDUydU5aSVN6?=
 =?utf-8?B?MjlVeDBVUVJQYW1rZm9aZlExMUp1ZlQzU2hWaDBaQkVWMlBIT2E5eWVnenhT?=
 =?utf-8?B?WHAwU0R5RE9uRVdraWcvNjU2TjRzdUxxTERveFQvQWErV2VwS2IzRGthcGdU?=
 =?utf-8?B?a1JuS2UrNjRUR3Rob29OY0MzelhSTmNSM3R2RkVhNG50Q1MzMUl2Zlk4THZq?=
 =?utf-8?B?NGdxVzJlc3F4V0s1VHhIUlpHaGlINXlJcHFySE1ORmtlTkNjb0ZqbFVIdkgx?=
 =?utf-8?B?RlBGdlB0OEY1dzQyYzdoYnlSQmFsK1pFL05wMUVQK0hZY0UvNzZJSjNpUi9r?=
 =?utf-8?B?bnVsWW1kVDA5UzhBalY3Q2s2VkhhM0l2L2UrTVNZZEwzajJSQVR3Q3FEVGdx?=
 =?utf-8?B?cTUxZjVoRFVUc2UzV0g3eTIvckRHZGJRMjVQNnV6OUtOcU5XbGpSS296aGJV?=
 =?utf-8?B?b2cwNGZRWWlkYlBQQ3JobEhjbEJoOERUa0hFQkRaRzZKY2tlWGIreHd2ejZE?=
 =?utf-8?B?UXFNVzRKeFJMTDZJbkYrc3dITEt3SHQySmdzd3lsNG5GbC9sNmNvQ3R3cHJX?=
 =?utf-8?B?MEZNRGsySWhhSU5zd09vaFlHT3F4d3pHNGtIdU5FTnptV3QwY3ROZzA5TXMr?=
 =?utf-8?B?VERVV2h0aE1QbnJYN1YveGU3aHJrMUpwUlUxZnQxaHU5bG5JY012c04vMEpk?=
 =?utf-8?B?RkI3ZnJCd0U1eXhJbFVvYi9rd0NYdmtiNmVlSEdRcVVZQngrZGZMU1FWaEJT?=
 =?utf-8?B?RXB3aU9JY1YybGVSNTA4dHB0VUs5dmRQWDViQU9lZmpyWnUvTWJaS1A2K29Q?=
 =?utf-8?B?RENuNzUrNE84UHBmSFpNSC9XeHpDVnJwbWI2dkE2Yk55eWFGZGJpZEpRTkNj?=
 =?utf-8?B?cHFSVVpyV05OMUEzOURUR1VzS2NJdEtUNXRDTW9IcEJaVzEyaUJISHIxT3Nq?=
 =?utf-8?B?U1RBbWxTOHovKzZoQ3VhQWNyYjlRNXg2MGszZ3NQNlo1Zkdvdmp0YVdwajV0?=
 =?utf-8?B?ZmFtNHFNdFEvY3hDeFlZcDNIdngrMW5SOEVZRTRnRUd4dnNiWVptV2o5bmFI?=
 =?utf-8?B?c296TjN4NTVjeWlzUjNldU5CU01TeU9vNURHaW00eUdSaXQvVlBjb2dtM1JV?=
 =?utf-8?B?U0NTdW01b0s1VENGTm55NDhPOVVqS0p5RjBGM1JrUS9ZY1NuZVphMGpaOUhh?=
 =?utf-8?B?RUg5cHViZnBuVVFBVDNLSjVZbDRCS0toMHMwekZtVlJIbmd1Tlc0bFlsTWJ4?=
 =?utf-8?B?SlNOREtlOFIzN2l3RnhPRlI1TEk4SFl6ZEJ1dFptSk91TlRtcUdNVHdpcTJB?=
 =?utf-8?B?ZGdaQnlibm1GSUhaRmQvaDZsamFCTnVGZDdvejhHekRRbjNIbk8wc0RhWG9v?=
 =?utf-8?B?bEEzdzE0UW9ZclF2MDVTT0ttSWRvdU4rWDFCa3F6TGVBUXdoZmJQOUswTjRL?=
 =?utf-8?B?Tm4waDZFcEd5ZUxUVVEvSHhjMnpUKzZyYXdxQXBZSHQ4aG9va3pCQjhtd25H?=
 =?utf-8?B?V29oVUkrNUFXTEVlbzcxNEJOWnJsdmVCclN2YkJScmMzeDhMNE9DVnpzbEk3?=
 =?utf-8?B?TmhCR09tNUJkcEozZzNHSkZwUlZaakdETW50TitrOWtUM0NWL3NEODBRTFJi?=
 =?utf-8?B?R04vMFBHS2dydkI4aENnQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXRPdWJYdWVqM1d0dE8ycnRtNGs3NzVYRGZXWkNuM1laUjdEek9nUmNHZytt?=
 =?utf-8?B?SCs1dSs3NThabm5MaGZsYmN1ay9TRHgvOVlDZnVxTVd2OS8ycjlLNUNVRlNi?=
 =?utf-8?B?N0F0NGR0SExWYm9KV09FYWd0Nm40UVh4akNkTFo5M3B4YzZsRjRqMUtpS0dw?=
 =?utf-8?B?ei8wbnFZZy93cHhyS1hiQzZaeGREeGtIVVkxY1VYT1Rnb0RCZ3M1aVpuM1Z4?=
 =?utf-8?B?b2hVOGRJaXVnQnpOVElkTXNaOWdSaTM5dDh3K1lZVjd3UXpZZnp0eEx3VkNS?=
 =?utf-8?B?RVZOMTdZUDZFZVE0S29XT1k1RjFvZnBJR3RCWGY3TWorWWEycUdzeGZmOGpF?=
 =?utf-8?B?Vi9KTmVUU0Y0ZmV5UTBLSU84VVF1WEhFZFVyL1EyNFJTcFgzcnJPcm9GY0RD?=
 =?utf-8?B?cjFBZW4rdndqdkJVT2ZWNU12MHE1OUE4bm5ZQkRGNjRSZGY0QzM5N3RocUpB?=
 =?utf-8?B?ODBkNnZLdjJpekJKVzQ3dlJoVXpjbkxvc3JrRy9YWlA5UE5lRFBJdTFDaTZG?=
 =?utf-8?B?bnVnemUrdGNONlJ4dmR2Mk1td1hXRGEzbUppbmVMamlTMkE0V3NSN2NTd001?=
 =?utf-8?B?VGxwQStJcmNRb0t1VVk1NEVsRDBwd0YwRXVOSkVOckJybVBySEk1SmptdzRz?=
 =?utf-8?B?cVhiU2szM3phbDNhbytYckxqOXdOMEtTY0dzMEhMY0xyU0VvNGhDU2pkVllU?=
 =?utf-8?B?dnhjaDAzOGxWWkhEcjNKTFlqd3JGRnRHdTZjMWUrZTdwdEdGeHVOVlRCMWlK?=
 =?utf-8?B?R3dUV2tTRmVsYUJFOFRCUzdsMGZkY2dXSXRjbmxnM0RKR1FZdTUydjZaM3FV?=
 =?utf-8?B?NzdYaUFzclVHQWs2dHBzenhkME9KQ0NsamNEOWp3eHExNnlRbXlFazlkbGF2?=
 =?utf-8?B?MGFJVVR1cmI1bmpITzNFeDFlZHQwN0wxUzVNSlJlcitlL24xelVya2RHeU9M?=
 =?utf-8?B?Wnh6QUtzeXQ5dDc4dllRUlpPdlJuQ2RSTXNxN0pwVDVGQVkxYjVZeW9WNUtN?=
 =?utf-8?B?QU83eEFxM3VBeVdodVNQU25DOHcrTDd2Q2xYbkoremh3QTlmMUdsejRHZnVP?=
 =?utf-8?B?ZkRqaS9IQ3plMm1RZzFCMkoySzVlMHJVWC9CSDNrYnNNcm5YT2NLSDBxbzVJ?=
 =?utf-8?B?bUh2TkwvL0QrdDVacUtIbXUreDRGTFVrSCsvWm92R09wS0JGS2xZUVVPWENl?=
 =?utf-8?B?cUJ0SmIxMVoreW5vRklBYjR0NWtqd2htdG9OaXZwam83L1NYUUlrY1hlYmJ5?=
 =?utf-8?B?WmtYekZVbGdmckZLZHA4SnE0blk2VUdKSDltVlFkQ3BxUTh1Mk1aZFE4Zlo4?=
 =?utf-8?B?TkUzQ29VdysxdWhmeE9RUm9CbisyNmhNYVVtTDBhN2did251RFJwbGFJV1Zt?=
 =?utf-8?B?UXpYeDNxci9aSHlOK2xwbmUwN1FKU2dYOEpzUGhSeXV2MVVxbzB6a2FpS0FT?=
 =?utf-8?B?NWJwM01GY01WVGJpczEycHlNdk53UGxjeGRDZVpheE5HVjZkZHJIc2tROVd6?=
 =?utf-8?B?RmdQWTdaa09mS3Fla2dvNCtMVVdBTlZGeDdjU05NM1pTYllXbjhmeENpMDJ1?=
 =?utf-8?B?NGhBemhrS2gvTHRFQ0JMRmRBUjRoWEhTbjk1YWtEa1hJeUpMSyt2aTdoVDJP?=
 =?utf-8?B?UHpncVF6eUdXRndnTXdzU3phT3ZhejRVTzZId0FEQ3RhNFJLa1RYOGo4Skx0?=
 =?utf-8?B?UVowNnVHbmpGQjAwd0hQN0FGaktxVUIyNFh6bzRVdnhRK2dKUFJ6a0NGdm50?=
 =?utf-8?B?dHZYa0lPWmJZSkJ3TDJJT2twbUxZRmJPTUk1SkpTeTdTWjVsZ3oyTjBuL1Y1?=
 =?utf-8?B?aWNmcHVBeFIvLzdNeHNnNitrWFR2NG5pVlRZSk5JSGF0T2JHRXJYSU1YcG5m?=
 =?utf-8?B?T0ZobFN3OENBa0F3Z1FQUmEwMXJPT1dyZ044N1hMcHBNdDZhVTlIRjkrMXhi?=
 =?utf-8?B?Y1JpZ3NoVGJVOE1rSXU5c3FnNmxNODRDSGxaUTdzYVdXRE9FNm12SzZRTXho?=
 =?utf-8?B?Mm9IbFZIVVFQbm5KajdFZGx1R1JlSHVNYzBLblM3T2x1ZGZ6RDh6WjZkWEhB?=
 =?utf-8?B?b0x6Tjdpb01OZnlKMzVXTmJDNnlXSUlwZWRSKzA0dmJVZ2JWNjNvZWthOVJ4?=
 =?utf-8?Q?WCmEl6t+f0EJOPHBm3FqaCSxa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bc5XPlv6NHhC2QIsDRPsTGMJ6T+w5DfJ2VR2uWJ7Ahni3rUJt+0/EXWG0vkFMjLgePMiE2lQpCHDwDZ26CoFLHSy5sabcx5UrDdrLOa/wiMTEX2KRqox8K4CeyPKBKgmWOKla996LvhMRnhDBkrdfLoKMU9LxvTvG09VKrkMhj9QcmT43esIU8M7EzE2loFznEqDUA61GNlGMVDbR/trlX+KHWEc3Aa5hS+gL1HQAQ5LV6JFa6wWIlL5+qgL+mMNoMM6+/yAUEYPezjh1+buu1+qbL+Tx7u7LUvwbUfY4G4lRx8L1CiIT24rv2fcCrQrskaTybIVsx+DY50cijAqTmjxgYxL/yOTKgrfDGosQVC/Ifz3DZq24jxV4x+n1ai38cocjBdhG+3INJna6ghj2TfF3Wp5Y2J0L/SHBKXA/VKMGcPw0lE8Z8y2FyCEGKff6UpxiBgtpJWobhMT3qp1Wp0HSEsB2KwCDLwPKbsB6fkprmhlp+OrjcXkKPd/9MW+rEllR4vkUk/uCGqGAOhBHPH+KxVTprMvh8tNLLdHK4Kl5AYkhw/e3hh8HFqF7GbEa8Xj89cb9iV+wDLkBBJc9n4FN/eoeYVP3zA+6be6LUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897d5c5c-f21a-4342-31bd-08dd24fc5876
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2024 15:53:59.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/wnHZ0gZb0C3InbLav8p3igU/5eKGIUSa2aKcOT8iUJS+URManyYONxaAF6q6+4SmLpA2Jg364y2kMH8GESuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-25_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412250141
X-Proofpoint-ORIG-GUID: 3i7NAycxyuwpXvam6hPg4_-GzkAzFQzF
X-Proofpoint-GUID: 3i7NAycxyuwpXvam6hPg4_-GzkAzFQzF

On 12/24/24 6:19 PM, NeilBrown wrote:
> On Tue, 24 Dec 2024, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> J. David reports an odd corruption of a READDIR reply sent to a
>> FreeBSD client.
>>
>> xdr_reserve_space() has to do a special trick when the @nbytes value
>> requests more space than there is in the current page of the XDR
>> buffer.
>>
>> In that case, xdr_reserve_space() returns a pointer to the start of
>> the next page, and then the next call to xdr_reserve_space() invokes
>> __xdr_commit_encode() to copy enough of the data item back into the
>> previous page to make that data item contiguous across the page
>> boundary.
>>
>> But we need to be careful in the case where buffer space is reserved
>> early for a data item that will be inserted into the buffer later.
>>
>> One such caller, nfsd4_encode_operation(), reserves 8 bytes in the
>> encoding buffer for each COMPOUND operation. However, a READDIR
>> result can sometimes encode file names so that there are only 4
>> bytes left at the end of the current XDR buffer page (though plenty
>> of pages are left to handle the remaining encoding tasks).
>>
>> If a COMPOUND operation follows the READDIR result (say, a GETATTR),
>> then nfsd4_encode_operation() will reserve 8 bytes for the op number
>> (9) and the op status (usually NFS4_OK). In this weird case,
>> xdr_reserve_space() returns a pointer to byte zero of the next buffer
>> page, as it assumes the data item will be copied back into place (in
>> the previous page) on the next call to xdr_reserve_space().
>>
>> nfsd4_encode_operation() writes the op num into the buffer, then
>> saves the next 4-byte location for the op's status code. The next
>> xdr_reserve_space() call is part of GETATTR encoding, so the op num
>> gets copied back into the previous page, but the saved location for
>> the op status continues to point to the wrong spot in the current
>> XDR buffer page because __xdr_commit_encode() moved that data item.
>>
>> After GETATTR encoding is complete, nfsd4_encode_operation() writes
>> the op status over the first XDR data item in the GETATTR result.
>> The NFS4_OK status code (0) makes it look like there are zero items
>> in the GETATTR's attribute bitmask.
>>
>> The patch description of commit 2825a7f90753 ("nfsd4: allow encoding
>> across page boundaries") [2014] remarks that NFSD "can't handle a
>> new operation starting close to the end of a page." This bug appears
>> to be one reason for that remark.
>>
>> Reported-by: J David <j.david.lists@gmail.com>
>> Closes: https://lore.kernel.org/linux-nfs/3998d739-c042-46b4-8166-dbd6c5f0e804@oracle.com/T/#t
>> X-Cc: stable@vger.kernel.org
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   fs/nfsd/nfs4xdr.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 53fac037611c..15cd716e9d91 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -5760,15 +5760,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
>>   	struct nfs4_stateowner *so = resp->cstate.replay_owner;
>>   	struct svc_rqst *rqstp = resp->rqstp;
>>   	const struct nfsd4_operation *opdesc = op->opdesc;
>> -	int post_err_offset;
>> +	unsigned int op_status_offset;
> 
> As most uses of "op_status_offset" add XDR_UNIT I'd be incline to keep
> the "post" offset.
> 
>     unsigned int op_status_offset, post_status_offset;

My thinking is that the "op_status_offset" value will be used on every
call of this function, but the "post_status_offset" cases are actually
exceedingly rare. There's no good reason to maintain that value
separately during every call.


>>   	nfsd4_enc encoder;
>> -	__be32 *p;
>>   
>> -	p = xdr_reserve_space(xdr, 8);
>> -	if (!p)
>> +	if (xdr_stream_encode_u32(xdr, op->opnum) != XDR_UNIT)
>> +		goto release;
>> +	op_status_offset = xdr_stream_pos(xdr);
>> +	if (!xdr_reserve_space(xdr, 4))
> 
> The underlying message of this bug seems to be that xdr_reserve_space()
> is a low-level interface that probably shouldn't be used outside of xdr
> code.
> So I wonder if we could use
>      op_status_offset = xdr_stream_pos(xdr);
>      if (xdr_stream_encode_u32(xdr, NFS4ERR_SERVERFAULT) < 0) //will be over-written
>             goto release;
>      post_status_offset = xdr_stream_pos(xdr);
> 
> instead??
> 
> But these are minor thoughts - only use them if you like them.
> Generally this is a definite improvement.
> 
> Reviewed-by: NeilBrown <neilb@suse.de>

Thanks!


-- 
Chuck Lever

