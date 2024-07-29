Return-Path: <linux-nfs+bounces-5152-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C152493FA5A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 18:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A611C217F9
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296B1158D6A;
	Mon, 29 Jul 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MAOqVOsm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WEalJ+HF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0555886
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269559; cv=fail; b=PNiJiq6/i9ivV8OICwlVfN9KNrN/tFFHsmEf3MhrO7pUyi8W7ODOr7KEnYPbL6GBBXMuYHb6DUwUbtZA9OfyfGABZxrMH6LcW2zC6WGT3CtzkDBVhVi1DKO60EpCTLoLjvL9c/XP7VEu39CLjmQ1hVPY3+RVw7iCKCYZQ/Il0Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269559; c=relaxed/simple;
	bh=6GKJdA/07RcaJPTqUC+UObRqxwx6J/EY6GQAJR7kv/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ISpK42a3yuOMzc5rZnNNzLGXGYcYzXMnIlYMGKjq8pSlmOF4dvfLdkvyDe5ZBrADmZNT/xXFafUxYhj/iGMmpLToomBxufChqul8JYBpuya+mQC0tIn/Q0uehs8PIvUyjF27ZvGuRAr3O48fPd3vBQGFlLvT+LNHtsOhKZPdSmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MAOqVOsm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WEalJ+HF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TFMZIK017252;
	Mon, 29 Jul 2024 16:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=1klJBxSMjkNOGoL71BXslyoi3E8ztwg0WWQ3+Wb+ROA=; b=
	MAOqVOsm3r2xorQLpbVv9iOTd2cKviVr5tRkN6upyvrj78OArfOL1BtV2mEptwat
	+c6A+cDEsu7I8vZZ79MXXmVGP/v9IyKfFH5jdFPP9cAVb6oXe9xbJf76TccsCPNA
	QIXLbwf/r5aRkrJTos75GaKjgwmqlRKO77CgpJBNDdNKozeYojqAj2qiPEjmnEnO
	ALPMJdwlkhsMBUb/hkNvhtyeEajrmRsxVWfGqHT8uwrKk4RiQqSsGVYqK6O3pIkY
	Br5TeaU4DWrUBGiLem01A6VnajGlrArVlvy4sCgTJHMNPsLtSrCL8QnwrhomwKfV
	7giQfK3Gt2bHfCDJwk+EbQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqtak1qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 16:12:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TFAJbx030853;
	Mon, 29 Jul 2024 16:12:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nehru0d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 16:12:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haxHDK0+qj67mUXz82HcoUrKhMZFE7yyJaRpzBtgbelHKV4+RZwA70v3uAha5QGdivzGm7Flwz7zo0EdsAJBFp4K79Kgch6d2vOKSgnw4EoWw2oPj2yGMQq3APHwUAThlSOOQrovMaw7rD6uE47qi0MA4XehFONjXOCU8M9/zGZcIdUjAJ1npORH+WE4JDNyWrXgyCQvwjwHNoVyCxo9YMUXRJsFLL1JJEGsw0V8HM+YgjiS2c1g4MubgzD404d5+ILpgWHRVqk2/TBUa7HhdQ23SWonvsPwS1W68OfJCg3BLvQZeMMWl9vWTIHOGbB7s9/8LO70f0EP8Yn+aVyhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1klJBxSMjkNOGoL71BXslyoi3E8ztwg0WWQ3+Wb+ROA=;
 b=FDUM/MsRFaXteVGES0bPaKWoJ67TTGmyGvaUJTpWMxYD8Xsm5f2B52J69tuFyExnHvEu/FP6X2YWy/BjgQ28u1Daw236Y/EE0/SQw/4cdzxyL7GsU36RW4ze8T9ClNAMOvWGbuHhLlnag4S/2JeDxJGCP6WQZ2oy8KF4YrNqARuIlZLp2ci8QK6SXDhD6K7SNs7ZrsVBq0shA/MB3lYtElpo3fv8/XW4xKDptSWgKtYVlLbGSyG/TDQ/OuXe1SrmMYY/EEL1oKupWftd2gUhcg3PJoy3qvgXiAmNn3R0frOQzh37XNdGaUKYujICcCdQN1HAsxm860gSbT4MtUY5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1klJBxSMjkNOGoL71BXslyoi3E8ztwg0WWQ3+Wb+ROA=;
 b=WEalJ+HFWXOQXnxEb6iTnCwZ84cTU+iSw2oeVK93sr4pRfapYzAdb4iiLA/3Dy5dkY+gswF2bUyafqPhEyGoS4MA9caHKFT4ENtC7bj81vnZyLk3Fls9MSt0sHjVxAHQsQoo9oolKXccLd8XszT9C/7FMeaMArmdBJxqkU3RbrU=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:231::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Mon, 29 Jul
 2024 16:12:14 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 16:12:14 +0000
Message-ID: <3db24a4e-c43f-4874-bb37-5dc088b887da@oracle.com>
Date: Mon, 29 Jul 2024 09:12:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nfsd: Offer write delegations for o_wronly opens
To: Jeff Layton <jlayton@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
References: <20240728204104.519041-1-sagi@grimberg.me>
 <20240728204104.519041-3-sagi@grimberg.me>
 <81765320f56c349298be08457ef2211a581c29f9.camel@kernel.org>
 <6a78bd6b-b5c4-489c-a7dd-bd688fed8d94@grimberg.me>
 <cb6cf6834ca3383804b7bd994eeaf310cfbf8c78.camel@kernel.org>
 <0fc73dce-1ab1-4229-a81e-3c058e2bcee3@grimberg.me>
 <8c17942a9ed617c90f3e99b8ef2fe69969c9c6b1.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <8c17942a9ed617c90f3e99b8ef2fe69969c9c6b1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:208:32d::10) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 42fdf315-da1b-4ce8-9050-08dcafe935c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rk1WeWhJWVNzT1ZqUmQxSjZJK0dFRkRYZi9oQi9jZVV3R2docDdXSDZsSC9G?=
 =?utf-8?B?TEdDcEZtU2pRQkl6K3dub0ZJUlhYcjFuQjd2dGVQT0p6OTlvU1o0NmJESG0z?=
 =?utf-8?B?dXB5TXpYVEN4b0psWUdqRCszZUMxYXJsV0dzTmRPaGhQeHBTQzgyZjZEZGg4?=
 =?utf-8?B?Umh0elcrQVAzL2ZleVF4MDN0STVVTjNxZjU0c3VBQkVnY0c3YjB5TnBMZzRH?=
 =?utf-8?B?K0swT3FQTGlmZmNWaW1aRnBaYzZrclMvUmlQV3RnWWJ2TEZacmd3eUdXcjJC?=
 =?utf-8?B?akVvUm1jSEpOcHc5L3ZIZkxOQm4wNnhCWmpkSG1icEdYWUliMG5HM3Q0bzlU?=
 =?utf-8?B?cGk5N3pORG1wR04vcnV3TEZwaEZRRUhvL2d6ZDRIYzk3dW9pT2dRbDdLbUln?=
 =?utf-8?B?QWFJU1Y4TjhGeFphYnlJSUtxcnpwVEViWmFucTN0U0Z1UTFpam5QbnF0bGFC?=
 =?utf-8?B?K01KbDdDNzRXaVJXeTJqb1RyclFwdndRdzJOMGRQUm1xdS9wMmp5a1BMOGky?=
 =?utf-8?B?YTJKWjFnU1FYREEwQjYyb3hZa1dXRlB5TlZ0WThINmdqbTZibWpoQjgxNTRW?=
 =?utf-8?B?clo3clVLZzQvRk8yWTFoSml1VzJyc3ZBUHlxOElwZWM1YytFakJZUDFMVzhO?=
 =?utf-8?B?eHNNZ1ZEZStxTU9tQVNZaG55ejA4RUs0SGFmdTBEeVhWL0tscWw5N3A1UHhN?=
 =?utf-8?B?WjRpMXo3M0d2bGdycmRtYm4vcWNUVFZxamJlVnhPQ2pFRTVoWU53UXYyWUZy?=
 =?utf-8?B?ODY2Z0xrZ2ozTFhaZWZOVm1nMUQyK2tvSEFYVjEwcEVOSTZsNGJmQWx0UEpt?=
 =?utf-8?B?TzY3OWR0MnVpUzlLK0ZDVUhmRU9ybjJhNnNIejhWM0dCS2dBVXE5NktHd1Qz?=
 =?utf-8?B?V0xSZGxSK2NjTGZqTHc1NXU4YUlIWGJuNEMreDdLa3RMZHB1c09WZmhEMGNr?=
 =?utf-8?B?K3pRUmdpcFF5ODBHVko3eVl0WXlIYTlDTFIzL2dOZWJWek53blFlOVJ5Z2lS?=
 =?utf-8?B?YzYrRVhDditoblI1Wm55NjlFVlJQNFNLSmZVNFFQKzM4VmU0b2w0bWRSQWI3?=
 =?utf-8?B?c3Jwd3ZQb2RwNUhKRnppOW5ha1FHb3NJaDBoSEVVTXJPcmd0Y0pBeEx6aUlH?=
 =?utf-8?B?Q3BCUTBBWEE3SEhWZ1B0VDc5M2R0RlZiNDJBclMxcmJ5aVVwMGg3ZUhXSnVu?=
 =?utf-8?B?UHZnMUxXQW5zQ2hkOEYxNXVLT3pUMWxWUjMxNnI1cmFZV1QydEdaclhLNDJo?=
 =?utf-8?B?Ums0SnB5WEdlWGxYTnBKSndwUHk3YmhHN1ZPRDkxL2lINGdIM1AzeUd6czNk?=
 =?utf-8?B?MDNhTmcrclp3WXFxOHpmSitacFdKT3Q1YTQ2NWFPS3BtZ2ZRb1lIYlRzOEgy?=
 =?utf-8?B?R3FXVW5LZEx3M1BwYVNwaG9UQUJyZDZhRWhselZBeW1tU1p2REdrdW1pS2FO?=
 =?utf-8?B?YXF4ZGU1RitwR2RBemNiTXk5a25UTDdobVdWa25qdjlaaXdYRElGcUYvenkz?=
 =?utf-8?B?Wmp5NG9Yckl0dGNvN2ZKVm9hYUM0V083aGxudjFIRkdXaDJWdUZXemhqVHJN?=
 =?utf-8?B?RytzZ2FYNmNhc2g4aWtIamJwZHVHeHFTWVRNOVhLVmdaOVJvUENnR3UrRHhH?=
 =?utf-8?B?czRrYk5DUEpvNW1FUWk0MWVFMUFJN0dCT3NUbXpPczJLYzJudFQzOFU0aUR2?=
 =?utf-8?B?VGR0MTBoeDlIYnpmQUJkODFWdTFSRTE0cGVOS2xETVREcVIzWGZxcld0UFlG?=
 =?utf-8?B?TFB3cFRKMktRVXU4UVAxYTFKa0MrRmt0WHhlRVFWK1IybFBtMGRqM3JBdUJq?=
 =?utf-8?B?cFZ2alFiZk1HellYRE9sdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHRpVE1KN0RGLzBoMDNTTnhmb3hkWnpEa0cyQTFjcE1mSXlpc3ZoRkU5a2Rm?=
 =?utf-8?B?SWozdTRTOEpwTDNKaUFuQlpvc0lTMVpnQlVOUzlraldob2dYQmlrTjAxWk5u?=
 =?utf-8?B?OFNqSW5BVERTZzNMd2pHdDRRaDk5bHdXMXZIK0Y3THNDZXVMVklQcDYvRnNl?=
 =?utf-8?B?bnVjYWMrRnh0UmpaakdJcXZiN2FQRUhvRUhGVHZNNmFRaUhwdkxNTEJFdEVT?=
 =?utf-8?B?cW51K3YvVVZYU2syREMycjRHTTNnVkIrMkNDUjg1aW0vakFIL3RFeXJ3Rmox?=
 =?utf-8?B?M2pQUFJlbS9LRE1xTmtpM29HUHliWlIwUnhvYU1jZklMbWxtblBXdTI2YmxO?=
 =?utf-8?B?ZUhGQThDeGN3TFMvaU9vc3kwZzNORHlSdEROajBtQUgvU2JoY0RiM05rSXU1?=
 =?utf-8?B?WWhTWDRjbXFNamM1Q2JaVzdOdlBKWnBVVHpsN1hUYU9XaTB5d1FxV2VlcXNE?=
 =?utf-8?B?QVgrelhhVytFWTZmUldLQi9ySi9YdEFPcTB0SDdKNG9FVkVkZzJ2ODFUYldo?=
 =?utf-8?B?Y1ZxaC9WS3hCbkNiQjJiZ3ZSRW1KS1M2Tm9YOTBQK01wYjFaL05mNVlWZHZO?=
 =?utf-8?B?VzBmZWpQRmZITUtMUkF6NFVydDBRdUM5QjhNcHJTWXRwZWt3R2VnNzdPZTJt?=
 =?utf-8?B?M2V5M2RFVWxWUWI1L2tNT0tqNXRPcGEyNDByTU1NeWtxZUY1b3ViNGF1NzVI?=
 =?utf-8?B?anJGRWlBMTdRMkJZSmNtVHdtVGJsbjFhbUVyeUZsb0ZGa0hFOW92REpQWGYw?=
 =?utf-8?B?TDlpVVhWTTQ2UU9CbjB0bUpST1FYWDhXY0NvejcrOGlrNHZ6azJHNmViVUV2?=
 =?utf-8?B?OG9FTCtFYzE5QTFpOHVJdFRJZ3RzZmxqSHRXcDBOSTB4blc4L2h1dnFWNGI5?=
 =?utf-8?B?RGlMdWYyWEZBVnNiS3dHdWU5UmpTWUFpbnpLRkhSTmtmeDNocnJmditHU3F6?=
 =?utf-8?B?d2xZcUozVmM5VkllTTRVdGxVM1N6Q09RZ0RTYjBNQW5PdS9rWExWSjg5OFNw?=
 =?utf-8?B?NGt2bnp0U2xpSFhXbHo3TG1rUVp6VnJqVWxQUE1tVzk4QW5ZUEY0MndXWXJR?=
 =?utf-8?B?VkdkV2JrZ2hVYlQ5Y21IbUNmeXJabUxxNHpkS0puSG9Bb0d5SVlCdlpXUDVo?=
 =?utf-8?B?QmU4TTNwTm1IU1pZZm9qdUVyTVFIUW1jZ0EzVkJWU2Y1NEtLSlVtdnZzYWtF?=
 =?utf-8?B?aXBZSlAranBLL2lwR2NtYk5pREszWUtBY2JwZjlnbnQ2MWI0bVFHbWZIUWF6?=
 =?utf-8?B?RlJvcHhHVXdnb2ZxVU5iQ3dFTDlWRld5M3M0RG1PMEdTNHBZVVZ1TTVOQVZa?=
 =?utf-8?B?dHdGckFucTlUVFpQeTNJTitxWlRaYXBnMmplcExpbzdnR0lRR01ENmptNmZS?=
 =?utf-8?B?SGZGYVMxSDJoQnZFNHcrWjg0U0JZc29SN1kvMFd3aE9IRTVZcStqQ1BaSkRH?=
 =?utf-8?B?cXBSamt0czUxbjk4RVVhd1E3MEUxcXhoOW96ck95bWhVd251VGtrY3dlWW9r?=
 =?utf-8?B?cTdzSUVhd3kvVUJ5S2tGTmpmWisrak02elRvUlo2V3NXS29WOG9ML0ZUblVx?=
 =?utf-8?B?Z0xnUTdmTUZyZkIrTkY1MDVoSDNiWGdKemVJZWdBNFMrbkk4YmpYcm9XbUNV?=
 =?utf-8?B?Q1dBdFptZ2QvbGU0b1o1azdNTGVta1YxZWdSM0tiTTkyWjNTMlJXK2wrZnpI?=
 =?utf-8?B?a0NGT0t6ckhsdmJyL0d0RlhROGZZZlowS1dRM2ljOW1YYUdOQVc1cXVTSXpj?=
 =?utf-8?B?VTFYblFOUDFyZGp5UXYrbitvSk51S0JMMlIyZVY5d3Rpb2FhQW9tTGxxRFFV?=
 =?utf-8?B?UXArSWxXMzhnTXF0WTU4QmJzMUFZMWNnRjZDbkJBdEVRWkhUL2hrQ0J4aGx2?=
 =?utf-8?B?L3hKdG5HTUEvOVJhejkzbjBDaGw2ZmZ1bGk4UC8zTHFDTWx4a28rSTMzUWQr?=
 =?utf-8?B?M0JGRndXVHBGNGFSRTRDc0oyZFh5amIyMHVGbW1IbDBRTXNWSzBoa1hRcU01?=
 =?utf-8?B?Rno1MU4vT3hFVDBQWC9pNUpFSWRNSTFkQTM5azNadWNiZmtiUHd0SXVtVnRv?=
 =?utf-8?B?akdwdUd5bzN1bVNjY1Zwa0V4b3NQUHpVdzg3ZTE1bUlqMStEVjFDbE1LOGRw?=
 =?utf-8?B?UzA0WTB0bmR2bHErWDdnK3VOM1VZNUpRUnV1VVRwd3NBMVVKSHp5QTRJOXpt?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9RPlSbes3OsGlOTPdG8SFgkLOqM7MVBIbok3KQxXLnVI6DFH8ItQMTJMciZFpSvvmaDhjPakvUVQ2pk12N6rgLdMjVbkqGm/sKynOM1lJemfJQjLLK4xls3NU/VcTMJ3EHtbpxjTuoKexapVHHgAwEPmwjTJ+duGeh2JfI7pCGC/q3CvpPPRrC9pPfdnMSVbOFqjbhxkP+jnXXd8dlyYkS6L+SNkAxooA3cI1KxylzffTF6VnMW5I5U2wWejYEwbeHubN8rQ2BtjHD2bYkHq4LkjWs7lSwvQChZ1zdIG0EeJ+72NrDUc+/TfLO7zz48uGqTRGQ/IzakDhZb+tqJGhVXK7bxFmn1NV21bwtmD/4v/VLyHFFXMXxD7gNlc2gN/LOZXBHo2Y+V5bO67r2WVgNynW4tfkesa7rRQGTH/kP4aA6tGPhEV5A7eOd7R+Yk3Q9KyO01s7clclK5+fB5zElJRqphtsakRy2NlilNc1FBdEpuiWTDjSMU2XoQ0/pRP2mAltyDX+/p/syerMNXOoL9FDZLSlZHas5djOfBoUI+Uq96keRephaMTInpX5vTNiy1YZ+Z4Vhz91U4JVGr/Y/YRRZq8uz1W2jGqrsmYQys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fdf315-da1b-4ce8-9050-08dcafe935c5
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 16:12:14.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8DRFGHLMVoZviaVcM2S79gZUhJXGzLZr1B+njxrZlAXdS5nR7RFewb4/8K0Pv7JLJEPUWllR/RQ0JaU/de6SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_14,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407290108
X-Proofpoint-GUID: uEyX6dT45kK5vnRThoJ7jdfCKkpCUhTx
X-Proofpoint-ORIG-GUID: uEyX6dT45kK5vnRThoJ7jdfCKkpCUhTx


On 7/29/24 7:12 AM, Jeff Layton wrote:
> On Mon, 2024-07-29 at 16:39 +0300, Sagi Grimberg wrote:
>>
>>
>> On 29/07/2024 16:10, Jeff Layton wrote:
>>> On Mon, 2024-07-29 at 15:58 +0300, Sagi Grimberg wrote:
>>>>
>>>> On 29/07/2024 15:10, Jeff Layton wrote:
>>>>> On Sun, 2024-07-28 at 23:41 +0300, Sagi Grimberg wrote:
>>>>>> In order to support write delegations with O_WRONLY opens, we
>>>>>> need to
>>>>>> allow the clients to read using the write delegation stateid
>>>>>> (Per
>>>>>> RFC
>>>>>> 8881 section 9.1.2. Use of the Stateid and Locking).
>>>>>>
>>>>>> Hence, we check for NFS4_SHARE_ACCESS_WRITE set in open
>>>>>> request,
>>>>>> and
>>>>>> in case the share access flag does not set
>>>>>> NFS4_SHARE_ACCESS_READ
>>>>>> as
>>>>>> well, we'll open the file locally with O_RDWR in order to
>>>>>> allow
>>>>>> the
>>>>>> client to use the write delegation stateid when issuing a
>>>>>> read in
>>>>>> case
>>>>>> it may choose to.
>>>>>>
>>>>>> Plus, find_rw_file singular call-site is now removed, remove
>>>>>> it
>>>>>> altogether.
>>>>>>
>>>>>> Note: reads using special stateids that conflict with pending
>>>>>> write
>>>>>> delegations are undetected, and will be covered in a follow
>>>>>> on
>>>>>> patch.
>>>>>>
>>>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>>>> ---
>>>>>>     fs/nfsd/nfs4proc.c  | 18 +++++++++++++++++-
>>>>>>     fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++-------------
>>>>>> -----
>>>>>> ----
>>>>>>     fs/nfsd/xdr4.h      |  2 ++
>>>>>>     3 files changed, 39 insertions(+), 23 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>> index 7b70309ad8fb..041bcc3ab5d7 100644
>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>> @@ -979,8 +979,22 @@ nfsd4_read(struct svc_rqst *rqstp,
>>>>>> struct
>>>>>> nfsd4_compound_state *cstate,
>>>>>>     	/* check stateid */
>>>>>>     	status = nfs4_preprocess_stateid_op(rqstp, cstate,
>>>>>> &cstate-
>>>>>>> current_fh,
>>>>>>     					&read->rd_stateid,
>>>>>> RD_STATE,
>>>>>> -					&read->rd_nf, NULL);
>>>>>> +					&read->rd_nf, &read-
>>>>>>> rd_wd_stid);
>>>>>>     
>>>>>> +	/*
>>>>>> +	 * rd_wd_stid is needed for nfsd4_encode_read to
>>>>>> allow
>>>>>> write
>>>>>> +	 * delegation stateid used for read. Its refcount is
>>>>>> decremented
>>>>>> +	 * by nfsd4_read_release when read is done.
>>>>>> +	 */
>>>>>> +	if (!status) {
>>>>>> +		if (read->rd_wd_stid &&
>>>>>> +		    (read->rd_wd_stid->sc_type !=
>>>>>> SC_TYPE_DELEG
>>>>>> +		     delegstateid(read->rd_wd_stid)->dl_type
>>>>>> !=
>>>>>> +					NFS4_OPEN_DELEGATE_W
>>>>>> RITE
>>>>>> )) {
>>>>>> +			nfs4_put_stid(read->rd_wd_stid);
>>>>>> +			read->rd_wd_stid = NULL;
>>>>>> +		}
>>>>>> +	}
>>>>>>     	read->rd_rqstp = rqstp;
>>>>>>     	read->rd_fhp = &cstate->current_fh;
>>>>>>     	return status;
>>>>>> @@ -990,6 +1004,8 @@ nfsd4_read(struct svc_rqst *rqstp,
>>>>>> struct
>>>>>> nfsd4_compound_state *cstate,
>>>>>>     static void
>>>>>>     nfsd4_read_release(union nfsd4_op_u *u)
>>>>>>     {
>>>>>> +	if (u->read.rd_wd_stid)
>>>>>> +		nfs4_put_stid(u->read.rd_wd_stid);
>>>>>>     	if (u->read.rd_nf)
>>>>>>     		nfsd_file_put(u->read.rd_nf);
>>>>>>     	trace_nfsd_read_done(u->read.rd_rqstp, u-
>>>>>>> read.rd_fhp,
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index 0645fccbf122..538b6e1127a2 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -639,18 +639,6 @@ find_readable_file(struct nfs4_file *f)
>>>>>>     	return ret;
>>>>>>     }
>>>>>>     
>>>>>> -static struct nfsd_file *
>>>>>> -find_rw_file(struct nfs4_file *f)
>>>>>> -{
>>>>>> -	struct nfsd_file *ret;
>>>>>> -
>>>>>> -	spin_lock(&f->fi_lock);
>>>>>> -	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
>>>>>> -	spin_unlock(&f->fi_lock);
>>>>>> -
>>>>>> -	return ret;
>>>>>> -}
>>>>>> -
>>>>>>     struct nfsd_file *
>>>>>>     find_any_file(struct nfs4_file *f)
>>>>>>     {
>>>>>> @@ -5784,15 +5772,11 @@ nfs4_set_delegation(struct nfsd4_open
>>>>>> *open,
>>>>>> struct nfs4_ol_stateid *stp,
>>>>>>     	 *  "An OPEN_DELEGATE_WRITE delegation allows the
>>>>>> client
>>>>>> to
>>>>>> handle,
>>>>>>     	 *   on its own, all opens."
>>>>>>     	 *
>>>>>> -	 * Furthermore the client can use a write delegation
>>>>>> for
>>>>>> most READ
>>>>>> -	 * operations as well, so we require a O_RDWR file
>>>>>> here.
>>>>>> -	 *
>>>>>> -	 * Offer a write delegation in the case of a BOTH
>>>>>> open,
>>>>>> and
>>>>>> ensure
>>>>>> -	 * we get the O_RDWR descriptor.
>>>>>> +	 * Offer a write delegation for WRITE or BOTH access
>>>>>>     	 */
>>>>>> -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH)
>>>>>> ==
>>>>>> NFS4_SHARE_ACCESS_BOTH) {
>>>>>> -		nf = find_rw_file(fp);
>>>>>> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE)
>>>>>> {
>>>>>>     		dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>>>> +		nf = find_writeable_file(fp);
>>>>>>     	}
>>>>>>     
>>>>>>     	/*
>>>>>> @@ -5934,8 +5918,8 @@ static void
>>>>>> nfsd4_open_deleg_none_ext(struct
>>>>>> nfsd4_open *open, int status)
>>>>>>      * open or lock state.
>>>>>>      */
>>>>>>     static void
>>>>>> -nfs4_open_delegation(struct nfsd4_open *open, struct
>>>>>> nfs4_ol_stateid
>>>>>> *stp,
>>>>>> -		     struct svc_fh *currentfh)
>>>>>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct
>>>>>> nfsd4_open
>>>>>> *open,
>>>>>> +		struct nfs4_ol_stateid *stp, struct svc_fh
>>>>>> *currentfh)
>>>>>>     {
>>>>>>     	struct nfs4_delegation *dp;
>>>>>>     	struct nfs4_openowner *oo = openowner(stp-
>>>>>>> st_stateowner);
>>>>>> @@ -5994,6 +5978,20 @@ nfs4_open_delegation(struct nfsd4_open
>>>>>> *open,
>>>>>> struct nfs4_ol_stateid *stp,
>>>>>>     		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>>>>>>     		dp->dl_cb_fattr.ncf_initial_cinfo =
>>>>>>     			nfsd4_change_attribute(&stat,
>>>>>> d_inode(currentfh->fh_dentry));
>>>>>> +		if ((open->op_share_access &
>>>>>> NFS4_SHARE_ACCESS_BOTH)
>>>>>> != NFS4_SHARE_ACCESS_BOTH) {
>>>>>> +			struct nfsd_file *nf = NULL;
>>>>>> +
>>>>>> +			/* make sure the file is opened
>>>>>> locally
>>>>>> for
>>>>>> O_RDWR */
>>>>>> +			status =
>>>>>> nfsd_file_acquire_opened(rqstp,
>>>>>> currentfh,
>>>>>> +				nfs4_access_to_access(NFS4_S
>>>>>> HARE
>>>>>> _ACC
>>>>>> ESS_BOTH),
>>>>>> +				open->op_filp, &nf);
>>>>>> +			if (status) {
>>>>>> +				nfs4_put_stid(&dp->dl_stid);
>>>>>> +				destroy_delegation(dp);
>>>>>> +				goto out_no_deleg;
>>>>>> +			}
>>>>>> +			stp->st_stid.sc_file->fi_fds[O_RDWR]
>>>>>> =
>>>>>> nf;
>>>>> I have a bit of a concern here. When we go to put access
>>>>> references
>>>>> to
>>>>> the fi_fds, that's done according to the st_access_bmap. Here
>>>>> though,
>>>>> you're adding an extra reference for the O_RDWR fd, but I don't
>>>>> see
>>>>> where you're calling set_access for that on the delegation
>>>>> stateid?
>>>>> Am
>>>>> I missing where that happens? Not doing that may lead to fd
>>>>> leaks
>>>>> if it
>>>>> was missed.
>>>> Ah, this is something that I did not fully understand...
>>>> However it looks like st_access_bmap is not something that is
>>>> accounted on the delegation stateid...
>>>>
>>>> Can I simply set it on the open stateid (stp)?
>>> That would likely fix the leak, but I'm not sure that's the best
>>> approach. You have an NFS4_SHARE_ACCESS_WRITE-only stateid here,
>>> and
>>> that would turn it a NFS4_SHARE_ACCESS_BOTH one, wouldn't it?
>>>
>>> It wouldn't surprise me if that might break a testcase or two.
>> Well, if the server handed out a write delegation, isn't it
>> effectively
>> equivalent to
>> NFS4_SHARE_ACCESS_BOTH open?
> For the delegation, yes, but you're proposing to change an open stateid
> that was explicitly requested to be ACCESS_WRITE into ACCESS_BOTH.
>
> Given that you're doing this for a write delegation, that sort of
> implies that no other client has it open. Maybe it's OK in that case,
> but I think that if you do that then you'd need to convert the open
> stateid back into being ACCESS_WRITE when the delegation goes away.

Yes, this is my concern too, delegation can be recalled.

-Dai

>
> Otherwise you wouldn't (for instance) be able to set a DENY_READ on the
> file after doing an O_WRONLY open on it.
>
> Thinking about this a bit more though, I wonder if we ought to consider
> reworking the nfs4_file access altogether, especially in light of the
> recent delstid draft. Today, the open stateids hold all of the access
> refs, so if those go away while there is still an outstanding
> delegation, there's no guarantee we'll consider the file open at all
> anymore (AFAICS).
>
> Eventually we want to implement delstid support, in which case we'll
> need to support the situation where we may give out a delegation with
> no open stateid. It might be better to rework things along those lines
> instead.

