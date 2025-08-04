Return-Path: <linux-nfs+bounces-13412-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE22CB1A949
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 20:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5704518A039A
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 18:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189161B4F2C;
	Mon,  4 Aug 2025 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C53Kd455";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cLPKqfcP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44B22FF22
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754333366; cv=fail; b=tAtMVxBAquBmsOVs1d7VbZLpCInuJ6bhyQqCwRfY5SjE9hSX3Aro3Z6BkbN/6Rw0g8Dz9Cls+1WObKSGDPLy15uZvXapmaOtXQCqpSDo0u7Hnbxp/miL4CuJX3Zjbh3CSA8EC3IZ6m98g/RAASFX035XpvImJ8ZZIHZGG1vzEXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754333366; c=relaxed/simple;
	bh=gN/gxmNpEMLD7DH/wMjUqH/Dk3pH8EJYETYbeW/Rh8I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JHRCrq8eKVoX0cvgqUMFaBKaUiwP+1KOw78ftinA+wstSpQEziCwBtG5pJbZfkGoIabLYlmxjAQ+hTTTn68UbnQFPZ7IFvf9falcvXKIVwR9q1Ni5L2uIZcR32M2btvUa50rZp9p+e3SgJpQ7y+qu9J0XxrfnxmBy6WJQEDwqXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C53Kd455; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cLPKqfcP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D7CxP009731;
	Mon, 4 Aug 2025 18:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=712mX8G7fAoRwCi9TjMUOegTXGRvNTvfUfSQxC6o7xU=; b=
	C53Kd455Ab3DAdLn/JfSvl2h/y9+vipBRKKbL+BDcbG1doGeQiryYP4D0uX0jwbU
	dDFJqVN1IYHO/cwe18DDV2RFsWDtY7pAAt/uJ50AQTbPCDi1+3lnF68VvYuH2Ck3
	XHjQts1tXaOKqcGzdhHJvTUrFNX66/ZukCRqwegY+i3WRNc+NKejH9kpNSS/NqQm
	lHvqpWvfSx5mUaEmNeKP5xuvWc6T8IT91FkvtcVfKrQ9HnHN74miBY/zihD1cJ3U
	DKgqPPRGE7IY5dZjLAjXQeh6gfGWsnbmP1AowSagAYS7p1fn3UHTGBMFTZo+nYQr
	pHnICo9NlMb0CBtGDEufyQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489b7xk8aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 18:49:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 574IQqMM014833;
	Mon, 4 Aug 2025 18:49:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7q11u23-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 18:49:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLBeqeJSu3Lnnu+xtW++EiQKW5yU6Ln8OmevxEJnE6bL4O0Adm5s9P12n0KIZ/laRpsmqWbaBpStc8N55r25HLEk61bVZgTyLzynbDQ9z4GSF/HfgnGuew6EQvrXU2IV9yNFrh+BoFcUP8O5z+aoY511qIjPhzJIwIQefy5ZtFJR5+dqUa6VJ8oQcBZ2Nvw0ptJ/d/ukLQCT+bIQm2kU+fTpsggzTZABaFcdPRfuU9jAGXD/i1V+dUCBBruTNTL14t68VOo1bif/VY+nKTTZSjiC0BiPYQhlV4UZd+WWCw5sOuFkZqoM9VwUun1+0sdDfQOAh0Aim2+2L7iyQ/B/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=712mX8G7fAoRwCi9TjMUOegTXGRvNTvfUfSQxC6o7xU=;
 b=mUghFhxvIgnnhuzVitLpK2A1sCgmqXSseOt33uosklX3xs2p3UTDtZdJtT7i7Enuo9cfvTKE3onsY29kpfgx/WdwbJsG2OLpsj/6os/WEsRhzvgh0HFxF2s7rGLIcS2F9sVCRkLSSTwEtz5yQqG44Hlqz/1yvLQrBG5coLAdphqDCnHfIKm1FKWdisGLVIFo56s86pS0P8a5ljeNQ4edlwZsZ+OtyrFtrhh4eZxdO8zRyfULZ8JL0G6a6H3C4657khKWpcwxLRBrx57K9mwfLikCSlDsW3z6QVf+/7lh4+bXeare9FW3u0+24iVL9hztKIIwdaziWpIz4gR+3dxFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=712mX8G7fAoRwCi9TjMUOegTXGRvNTvfUfSQxC6o7xU=;
 b=cLPKqfcP7gfsxnntCjGwy8MGKQ2QTOt7Zt67yhfYsQh3aPxXv5ErpYsPWDq1rAdoYFwTIikIvPZzRxQP3nJy4B7c2m9A0oEyutOXoePW9PWlx0ovE0HOx0SXKQFVQBr5CiRuUqKtheWSUmmGx6hjlIKYjjlkw3hR9q0DVbYdn4A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5083.namprd10.prod.outlook.com (2603:10b6:610:dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 18:49:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 18:49:12 +0000
Message-ID: <8c5fe5db-4f93-4d48-afda-8ee3996234d3@oracle.com>
Date: Mon, 4 Aug 2025 14:49:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] SUNRPC: call_connect_status needs to destroy
 transport on ETIMEDOUT before retry
To: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
References: <1754333198-62658-1-git-send-email-dai.ngo@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1754333198-62658-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ba6c64-b03f-477c-8cbd-08ddd3879a88
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SzdScVk4U0VTeS92Rk9Ka1BveHJiYzRUUjRrTjBLNVV4ODdRdkFIeGVnbEM3?=
 =?utf-8?B?TUV6dW4zd3pRL01xWmlBd0s5eEN2b2E5MU1JTXhGcVNFMjVHRi9nSlg3UzYv?=
 =?utf-8?B?WVJ5NlRHWHg3R3N1UllDeWpkLzZ2eUVUdmRDY3dySnc2QnQxR1QwMTgwNE1Q?=
 =?utf-8?B?aHZSdEE5Ni9jK3dneFFSeGNvejU4S0lHVkgyMGVaRGNJcCt3eFAzRVdjVFBZ?=
 =?utf-8?B?TFowZVZhdXVQSnVwVjNCRXRkcGtQMGJoZjM2b2lFQTk5VkVHSjFOd081OWxO?=
 =?utf-8?B?UHEvSzV3OURHZjRaRXFvNE01ZHhtVXQ1aHFSU2F6bjcrT0pLZVpFaEpRaTlT?=
 =?utf-8?B?eFZ4QkU3MEJCUE1kbDFZblVqUVhaamFGSEFpUjFlWFJDV1oxd3Evd1k2S3BC?=
 =?utf-8?B?bDJXZk9QWEExM1VnQ083cHc0RXlhWFJKeVlNVTJTMlJ4eThNaHhFR0JzZisw?=
 =?utf-8?B?cjEwMTRKdVNkdzk0Sjc5NEhrU2tmc0NjYysrTzdKVnpTMU00QmVNMi9SMDNn?=
 =?utf-8?B?TEFRSm12NnhaaTlad05ZRFN2K0FWVmhDMENPejVWL1M5eU9CZGdoZEtxK0wx?=
 =?utf-8?B?ai9zV2VDRW1nZXNvaVFYckdDc0p3TkN6RTg5ZllJQW84YmN4R0VSWnpWK3VO?=
 =?utf-8?B?VGRhcmxlYmVxWExFMGlENVJpQnFwZHV1K3lpanN1M2U4R3lWNmN6RXZEbjYz?=
 =?utf-8?B?cktpUGZvaWhiL1F2a3Z2SGllT2ZUbDk5NG1WUGE4Y1J1dENDdkh1VmZIN0tC?=
 =?utf-8?B?eHRUSDkrRjlDMDQyZ0dOTmh0bHVDRENmR2RGWkJjZGo5QzUrR0htZGh2SnFa?=
 =?utf-8?B?YVRSYU1YUjROTkIwZmlhSklmWFNXeE1vQ1A0bkpERTd2UGRVREhtb3B6MzA3?=
 =?utf-8?B?WVNjZ0JXWk0yTWJXdTVJME01RU02SlFSWXRPeDl5NzFCYXowVnV4Nk9BZmdG?=
 =?utf-8?B?YTArMXNQYlgzN2RwamJNT3h1d2VzZUJuYlpIb0hmbWhFd0xnYkpTQjBiOGI4?=
 =?utf-8?B?OW05c0JZWGZVWTRpY0dteXYvRVlCYWcrdWpyb1pBZ1NiTEF6Tm9uOXZoVklL?=
 =?utf-8?B?dUtBMWU2NldDYy9xVGprM1lvbzJ0enRZMkFHUzZ4ZnFoeUtDVHZxak1adG5u?=
 =?utf-8?B?R2YrODV0THZVOEg1NXNPb0VKdHlRZmptd1l3NHlSdkR6ZjVGblF0aVRjK2l1?=
 =?utf-8?B?T05ORWN0RWJxZyswZTRZMHlWUE05ZTBGbFYyUnIyeTRiTnZWSFg1alRpNTRy?=
 =?utf-8?B?eFVtdnk1TnhSN2tuSUJwazEwNXdqd3hYNENhYlNpZHVKWlp4MDlhTDE0ZFps?=
 =?utf-8?B?a2ZkYjdSTzROd3BEYjdzR2tpcVlYVkY4c1BwT2o5Ujd0c1VUUWR1NDcvcS9H?=
 =?utf-8?B?WFlReWp1RzZYQjZQbkE5UU5laENQTTdRQ3Q5dDVPcFZNdzlOL2M0L1hpa2dp?=
 =?utf-8?B?LzA4c3pGejgvbVIwUUthajR1eEhGbkRVUVJUTGVUR3VhTTU1OEZWZGFKSEZL?=
 =?utf-8?B?MDBhVGlkMktCeGxIeDlnYjhJUmpPUWhqbFRqalEyK0l0cXNVTFk3MFBBajFr?=
 =?utf-8?B?VGJ4enV5VUszS1BUNmh5YVk0UXBXMlJxa2p4elQwZ3MzNktKOHgxK3FQTmhm?=
 =?utf-8?B?TVgzSS9nWkdFSTkwTDJ0ejAzT2xhL1ZUZW9iTnR5Rlc3LzFZdnhOS1BldW1R?=
 =?utf-8?B?dGczM1ZDblJSMjRlRDBmenRQOWdDSXNmd21tcXBLMjV3MG8wUUJJSTF6T1o2?=
 =?utf-8?B?cmtZaEZzRnAzRUpwUDh2TFBERVZFcEVaTWdDYUVCSHpuRmRpNmJ6RVJWc0xN?=
 =?utf-8?B?aVFxRW8zS3FmS3BxQjNYZGNheldUUzJpK2dKQ1gwZ2RpQVp5NUZWM2VuVFRR?=
 =?utf-8?B?MjhwNDhOUU1qRlhraG10V0xFTnV2Z1dwU1ZFbmViZVcwOEhVYXdMdHRpZzlr?=
 =?utf-8?Q?bd+TBoIH8Ww=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UFE3VWVQaTRYRW4xQVhzUXdwSU1yYjdCOC83QUJhSnVBYUt2dVpYYk0xK3ho?=
 =?utf-8?B?bVFLSjR1ZHBvaE1rOVpReTd6UGw5RUZEelVJU3N0VFpuTjRYWnpNV1dNUkZZ?=
 =?utf-8?B?YXZhYTFFQzM5UWxQbjIzSHlCRWRuQ2krRHJab0pPTmtuUTBzTlpCMm5aYkE4?=
 =?utf-8?B?alpkNWs4dENTVVhBWXRKdDZ5dHFWb1htMng4bEQ5R1FMUXRkN1lja240QXg4?=
 =?utf-8?B?a0tQRjMxV1UyNnZMMHF1dEpMZEtXR2QzYXhLN2M1aUk2OHNoeGdvUXNJWW1o?=
 =?utf-8?B?WjNpMHZLcC9ERlFySFhkUWdqYk16SjFxR1FFaWs3QVVVMVNGVWxoMTROWTd0?=
 =?utf-8?B?UTVPUHdVL29uL1NzWWlFUGRWZVpLQkkxK0dSdkhZQXBjWlNSSzFsaHMxdjZL?=
 =?utf-8?B?MmtWOGF1K09ONDhSa0c5OTZIcWtxQ2htaWs5T0p0dkZoMlcvc25jV2pEVEt3?=
 =?utf-8?B?WDlpbGFMaEgvc0pMdzdVL3Q3eVVwVXh6ZHJHNnNGU2JyV3cvZ0d6N0FpcCtX?=
 =?utf-8?B?dlI3L0FpWUt5TGxLK01sWnlhWW1KOU40Ly90YkxNLzZLR253U3E2dS9UZmJ6?=
 =?utf-8?B?TlloQnpQSFhjR3lJY2gzcmNMRUxxczFRdXV0bUtEdlY0QmtRV0NEZGJUMVR2?=
 =?utf-8?B?WG9wQlRTR1BNcC81M3JqNVc3MWl4aldScXk3TFZzaks3WXVkUDR5dDgwYTAx?=
 =?utf-8?B?WEkwVHJuZFc3WnhGZTJyZk9OMHZKWlpuVlI5bTQzNkZmeUkwLzkyMHIxZ2kz?=
 =?utf-8?B?Q09NU09wamZRUVFPeDZ2clJMbnlyZWdJOXVwWnBTZGNqRmsydCtaeHhpekQy?=
 =?utf-8?B?RDFJVFM1K216eE9iaERaSzJiZ2xsZDNhV09jRjZMY1plMFByb0JMam13OFJN?=
 =?utf-8?B?cWZ5empNdHZuaVMrdGI0VWhQbzdTRnFTaGxUKzI5aXh1MzArYVNSM3RFVnRR?=
 =?utf-8?B?T2V3M1B4bzNPak1SYVpZanIvcFRkVTVuTEY0VmQ4YUxnOXJxUU1Ud1o5ajl6?=
 =?utf-8?B?NlBMbkVZM1NIYWZIc25nenM2OTNmMzhzU2ZvSmgvNWszV3dqd25ZbEo4eDYw?=
 =?utf-8?B?M2k4ZUEvN0tYNDZQSUVWVSsyQVhkK0lhZ0tLc2ZqNDE2NmtwMzh0WWlCVnQ0?=
 =?utf-8?B?MnZlUjVQUWFzbXNRdGh0aXE3WUJTV3MvZU1jMXY5L2N2enViWGMxbW5NOHZ2?=
 =?utf-8?B?UWFmZ3M0emt3YzhOQUUwWTN4dXBmYVp2anl2M2RsallMcmNqdldHSWdBaUg1?=
 =?utf-8?B?Sk81V1pEY0IxSFh1R2pWUjBxckk0VUVPQXJQS0hMMGNjVWZXOE5TS2RkdVAw?=
 =?utf-8?B?YjgyaGlSMWQ1RmxNMEJkcUt1aFRwd0o4eWM4M0VVWEZRcjBZUE9RY1JRMHd1?=
 =?utf-8?B?NTRzZ1kwek9FWGlXekZUMzhyQ1RIdlpuTU1adjFYQVVJc2lBeDZtL2hnbzNC?=
 =?utf-8?B?Ty8vVmpXbktsWVZ6Sy9RelBCcXN1aXA2aExKSUptMjdZN2VRMExZOFplcDFo?=
 =?utf-8?B?Yk8yUitnRkNZYVBMUjJBV2VGZWh4QUtVUFhHTkJFRjZrV1BkRFFnWFZ4L0tz?=
 =?utf-8?B?S3pJVUJzR1BObFcxMmdwbS9NOWVyL3lRN0h1dFN0SmNUK0l0aGh5MEtmbkhj?=
 =?utf-8?B?a3h5Yld3aGJkT2RxeW9zOHdwdUY1NW5nT0R0NU0rTmY5OERlMDNOS3o4Q2Jz?=
 =?utf-8?B?RE1SY3N5WUc0SjVNTU8xQmozMk9seVZCcFVMK1NRdFB6QmoyWlN5YVl4YWpX?=
 =?utf-8?B?cTJGYndHa05wcmdiQi9oTHdyUW95ejU1aHFIeE9RSSsvZXlhRzhqbVMzbjY3?=
 =?utf-8?B?SWFhd1FiUHcwZGFscGJWQm1LaUZpRjBocUJUMHBpV3B2aE4vRlZLVmpCVXgy?=
 =?utf-8?B?OGZaYWN5cnlrUFNIMklKTTMxN1NsZEFhSUxBOC90Qmw2MjVObDQ4dEZUczRW?=
 =?utf-8?B?alpXcUZhZS96QXhpTGtRNHBVZXZuTk1iYXNUV1ZrT2RoRlhhQ3JUT09YeXN6?=
 =?utf-8?B?KzlqSlVZNURYSzd1UEtHQityQTc4QURlRytzcngzWjNmeFQ2anpXUHRkVWpV?=
 =?utf-8?B?dk01VWtuTHZEOG4yaUdGeGgxanpNd1hic2NtM3lEUEU4ZlVxN3orMnlUaENY?=
 =?utf-8?Q?YSVHhQHBlbHQwbzwdnIjvGEG7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9o8GhFPG1hIZdVuKPLvc3k9Rsi8k02mtS1PxTyzL/hYyeadJatQfkPixqC+q1VWk3Zzo1u3Yu/nXdiIB0yeqm6P8ir1yBG37SA9WU/Qmapd/VN7osMVgUv0SaCgsPnHlB0/WLKtD+kCrkhmFBkIROA7VvWd+HYK67XsTY1zSJsC8E05nvZxfGLqv2X1t6k0p6U9ELSGVrhT/fnamLzZbXUST5p/EcfE2u2k0uIfoOjor7hxbmhlfcK4xKVsHLpfHDF9X/8IbcxY5trgsm3Kihle7Jk43Mu+BIYSlAoC7EUUo1l+I7ca0BM19/LNuEUmfE014SRYO02TEpXkQbpfWHtNjXZav9O5m/IjRIp81jbNJzDzpPdEH8t+d0FNW1ffeXHmOCA0hUlHrgod8rvKHkIFFRCm6UEowrSkCUMhYI80xJkBZoKke0obNCtpVDt4lnRPfkonOkQMDffrBYiE2ix9JnFdesXaj6AdtiX3ZaSkyj7wcFjA/EZJE4K4rT7bKNNisa2wT+z8aEETqFcBgrKsZVkdN9zgVebMRE8fdIiBnyAVvU+1wNNRuJ3cIawHArSahzogukbdxbuZg4lyMSUf5pVVtAy31bLm7ybkho3k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ba6c64-b03f-477c-8cbd-08ddd3879a88
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 18:49:12.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldIQg3tQRi7OU2vPZ2o0tOUA9PqQA4LJx4L4w4rW/gVlXhrEW2gSCDyl5zNgrdvpeep2fXRJnPmJkD3BzYjqYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5083
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_08,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508040109
X-Authority-Analysis: v=2.4 cv=MdNsu4/f c=1 sm=1 tr=0 ts=689100ae b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=bylS9ysnLcxMcB87_Y0A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12066
X-Proofpoint-ORIG-GUID: OowaEcLdjKxFHy91ztSxepG42Nnw8qyq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEwOSBTYWx0ZWRfX907uUJuxrtCX
 a1snR4BokZKi4SXbZpcsN3wkTCvjJOr7sUv563LED4jW3mHXRvI9HaSUP/ld0qjGSwRExvpLIJB
 iweeX/1cQaDV4vVxx4JPFkj3pDssTRtR9/znyU0fZKl5ci+8kEvWamDhRkwMbyRtmnokq+J1F6g
 b1y8DGRBJstkr14di58Q23bzD6cjDHpdxn2rsd8PG7F98u4HRxdNlQZDfiuwdwSPHo/4O5OJ2pu
 GBhxM/Nbhd3+SpmGZRhQpxDDnBUevZGe5dnBvnA0gFxvXckerG2alrWtjCeaPraPiYbLk85Tdre
 r0QzE0LlxlKjW1u6YRfKPd4yRAtUK9m+OF79ou4PyEtgLKXoCUBSVga6GtWELDzDW6GdYAe9PZY
 JSQNAxoul9vffxaoQ89cOP077xnQh+p1GH52MJH9fqRpIzfpsItbJ2mMQu1xHxzgPBVNbuFi
X-Proofpoint-GUID: OowaEcLdjKxFHy91ztSxepG42Nnw8qyq

On 8/4/25 2:46 PM, Dai Ngo wrote:
> Currently, when an RPC connection times out during the connect phase,
> the task is retried by placing it back on the pending queue and waiting
> again. In some cases, the timeout occurs because TCP is unable to send
> the SYN packet. This situation most often arises on bare metal systems
> at boot time, when the NFS mount is attempted while the network link
> appears to be up but is not yet stable.
> 
> This patch addresses the issue by updating call_connect_status to destroy
> the transport on ETIMEDOUT error before retrying the connection. This
> ensures that subsequent connection attempts use a fresh transport,
> reducing the likelihood of repeated failures due to lingering network
> issues.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  net/sunrpc/clnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 21426c3049d3..701b742750c5 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2215,6 +2215,7 @@ call_connect_status(struct rpc_task *task)
>  	case -EHOSTUNREACH:
>  	case -EPIPE:
>  	case -EPROTO:
> +	case -ETIMEDOUT:
>  		xprt_conditional_disconnect(task->tk_rqstp->rq_xprt,
>  					    task->tk_rqstp->rq_connect_cookie);
>  		if (RPC_IS_SOFTCONN(task))
> @@ -2225,7 +2226,6 @@ call_connect_status(struct rpc_task *task)
>  	case -EADDRINUSE:
>  	case -ENOTCONN:
>  	case -EAGAIN:
> -	case -ETIMEDOUT:
>  		if (!(task->tk_flags & RPC_TASK_NO_ROUND_ROBIN) &&
>  		    (task->tk_flags & RPC_TASK_MOVEABLE) &&
>  		    test_bit(XPRT_REMOVE, &xprt->state)) {

Hello Dai, net/sunrpc/clnt.c is client-side. Can you resend to Trond and
Anna, please?


-- 
Chuck Lever

