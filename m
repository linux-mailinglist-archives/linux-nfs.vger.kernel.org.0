Return-Path: <linux-nfs+bounces-21064-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKelDStj6mmrygIAu9opvQ
	(envelope-from <linux-nfs+bounces-21064-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:21:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B5E45608D
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E30C4306A1EE
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEAB25A359;
	Thu, 23 Apr 2026 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fay3dc9L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CaIWXTad"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E331A567
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968201; cv=fail; b=T9Ix9d1+tnCUAGW5ZJSN4I+mxWWomHuYn99KsnUBlAqL4NyYcBb/mH7Ja//qzh/udyeineREbAhcwj6vEEYWka2vxvZHQQugD2UyiTD825lAxL4S4En4sreeZRXh3wm5lH50Rsxonb8YAvmWr2ZjGEDToO1KBvE1oFxkoUlkxH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968201; c=relaxed/simple;
	bh=5zPml/6TvL7QTPM+628su3SX8ajkXux9kUVCAP8Rc7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sifL0S/VCIjESYQKkSC6aZfZv+JvBg3f0JG4zo7ekOcSDYIvxnWCXvZhYTfwZAnDRJGMLIvXCIKCjgQRAcy3H1cYAY5PoWXf91YfEdS3vARzo14xDndDiGAWdbp8yWVYKwxapKbVKWvR2XWybMlLFwItDZvpi6wmbKMk4W/y9hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fay3dc9L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CaIWXTad; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NGWeN74136594;
	Thu, 23 Apr 2026 18:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ALMtOsHjZiluGv2AP1qKUagnUGDx069gnohwU7IkDC0=; b=
	fay3dc9LgjiyWy5iIjJqcIr2T+apKkBcofa64Qapg1KFNQOiUq6S1fmutYen79EY
	VQwZI3fO6nJF61D/F5jXFDj3VLGUCAxjSIL8uS76MDuzaKqiW/h2NDwfsEBvC5G5
	TSWv4gJZzh39Jwo+cv2Z22qgOrEd3PIykidqatEJ+15I9Ruup6Vdt2VPWhwuLXmt
	MARf4+9+xOk3C361k29ZR541XNcbJbV2Pa9Snj39n/8zmHyxUrfz7MqDderwObC+
	qvJxELb+vhAikjXl9+SgGCYcYeP6riOiSgok3A08VgsY7tEO8RHh2S6bu0jBmKVD
	23pFdCCJnQGIh1sDl5l2bg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dpenmkyuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 18:16:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63NIBEHY009418;
	Thu, 23 Apr 2026 18:16:28 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dpjjg838v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 18:16:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzK7bZQDj9aK75o2QZkK1FQU31roFchWs/x7jgTokAu2dJ1viUXaC+DrEFKxSUvHfv7Ckx2SXzWUcRhSribQCQGqpNhHHMKvAK/1MebWCVwzblTCckX+M9tc1Vtnzeg2Zk5Pp3qSUdxAoGlsQPYwlnOOcTcvQEjYp1wF9VD1S1//I3Z6kMEy9hkI7ow3jmV9VJRL2l+UNetmu9mts++Kl9DZnOv1SSwnyPbiOtrrRH8g3SrBgl+01XzH7vXv5KhvcQAXlwXRdggCcNp99RBu2rIdLc5d8HoJ4dYIc16ET2xyGBB5446hwqHj8UMQg40BRuThGo0hXAoMW8xqF1ShuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALMtOsHjZiluGv2AP1qKUagnUGDx069gnohwU7IkDC0=;
 b=fwyXxmxXAdsL/UPQ2Jvwcdv66JClfu3ekFq+4apqe483aswALksMAZ6VdjfJ7YvC8o0YED/y06Ew/E0Nd1oePaZY2ng6bnbJcjHA3QMQAHNoJKGxjfZ/r+NOjPJKg5TPiqzyA1Efq3R7VHv6ZiBlkpFPn90r+wWxus2ghcaJsjOzRGAzFTa5hGG5LDoGeH7CQ5Ih+sHU7qhB9yBhF8GfxMiaAAcVZsdnNldBxz0Y8F/AEVRYOxBiE7r6cdkqtYUMjsZarqNTW+9S7sdKZbcRxpo5o+kiysyVN6mxaD36TlzrQQ9aDEmT9h66YhIOFg/147devCyqlNuOQbtm4vjInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALMtOsHjZiluGv2AP1qKUagnUGDx069gnohwU7IkDC0=;
 b=CaIWXTad2oyDuJ+NKz9q+Gj2NsGPHdP13il3sj7zjCuq8kClWIzSn83Ms42BF5fewUO9zSQ08PXS204vacZsHaTYd/eIKNiXKFoHe43IMC6IcHy4UBsn2FFPBYtBoXSFpr84n7kjNViiJH1W7w6NACTG2M9bQJ2now6+FLMHRNA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4717.namprd10.prod.outlook.com (2603:10b6:a03:2ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 18:16:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 18:16:23 +0000
Message-ID: <e0bb538e-69a8-4198-911b-2464ccf9fde3@oracle.com>
Date: Thu, 23 Apr 2026 14:16:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Put cache get-reqs dump attrs under reply
To: Chuck Lever <cel@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>
References: <20260423181505.742554-1-cel@kernel.org>
 <20260423181505.742554-3-cel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20260423181505.742554-3-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:610:52::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4717:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dec91e0-58a9-4cb5-8bbc-08dea1646cf4
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 dWk7sC17nSo0WLZHcohPxGMN1h2HHw51QQfqhhS+3ucuywL6csvyoEQ0wWPM7vRSRJ3o2S/44OCPPL1InP7I07mgLdqq8HuRypT3x64GV1YZnu1P8eO9pkm3hnnTNgROiPtG3vuZCdxjIgkU8FSUDHdmRjDLUgHIRe/EsaTwh+AV0n2T36cfc1mJsPqFBbK0n5n+68gCYqyzmjf8IuUwWMsKtNdtMcB9W73v6DklEA08uH+c4zH7uOxMYE1EAZud/exr+JuLs2RD5Cxu/7V6Et03wh7Z4OHUwNkfH2L3Xtt+4SoLCUCW6iRpD0PZ9J/GwxRXLHqmuBvJJ8xdRg8mpCyN3F0YmP4u6Zt1fPOwpXukUsKekxudtIsDODPFbaFn4tbBopjkL2PsY8tv8gkZew9XKt5W8xBeav70m03EQenFYVwHkvirnF4sG9z2MUd177v52Mmk0N5dXxUBoAiLuTqmKD5w9AIdESW/oWh0Yt4+aU4uk/fbpcd12adGt6I7XbpwsqZ+E6iJA/M+lWqCS+Jp00LBvIq3NznxNv+l8YqzlFPwbg4cQj3eP+30IseuZoLhW94HTsxlOZ6PMCdUL7vFJ2S/+6mxM17VLRuVWAW3bBp0Qpa5KmgfhNcUuStwv5CcLmnQRRZVo6fIHEbRybmJSfpyadFiRUXs3MG2wf+5m+Nfj2JP0065DoXq1AoI3BEOZqUhLyHihKFI7+yMMaGQQdDKBYZkCVmYgDsdiCs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NEVDMWk4eWFIOUs4K3JzUC9YQ2hrOVdHcmRLYzA3bGRQMGthSEI3ZEpPWThV?=
 =?utf-8?B?M0QrcnJVMklySXZrcU93b3FyMWZCd21RQVdLa212YjJtMzJXdWlUTGpNSDJV?=
 =?utf-8?B?WXBVM1pYdEdocUM0bWVidENMbjN4N2E3eEp6bWlBMVN4Q1JNa0xzM0xpR3hu?=
 =?utf-8?B?b3VZRllhNlVveDFodXhlQUNmK0ZCUjkzK1VaNFQ0RlVqQVFMVVVLeE9nVHdo?=
 =?utf-8?B?RG43aGl5RGIxS0VKWnF1WW56SWJ3RlVDKzM2K3RFeGZlWXVJS0FEZ055V0Jw?=
 =?utf-8?B?TGIvZDlKN0JtM0JzR2FLNXovcm8yb1QyY2FTY01ZclFJODFERmVjSG55TVR3?=
 =?utf-8?B?L0RUaDRXaGQwR1F0VE9tS1BjZkdPem45WGlQOWxFVU1YeUM5L3ZNMzFpTkl3?=
 =?utf-8?B?NVhRdFZZeGJOaGxDTHFxZUd0aVFRVFVlaFp1bld2Ny80Z2N5dDB6ZlVHVDFT?=
 =?utf-8?B?SkZWcmNRZXA2R1ZCRTNBUEVEdER6VWlrczllM214SVdEMy8wUTVlaXV5MGpu?=
 =?utf-8?B?SmtSVUdVMHY0bmRGS2t4S3RsVFpWNkZyc0hyNTZqS09jd0dTQlRBOU1qOTZr?=
 =?utf-8?B?ZVl2NEhtd0R5ZFFualgzc3ZZZUN1aG1qOVBXSW1KUElLODVrVzk3SmJZTlVw?=
 =?utf-8?B?dFJQcmhUKzR2cmFRMCtkek5pTE1QamdQUFU0N0o2N1U0MnA5SWhGd0tsU3JG?=
 =?utf-8?B?Z1duUVcwdmF6TVErVExVTjZQczhrTlB4ZC9OM3puMVJkSVRoSTRhSW9Qa1Y5?=
 =?utf-8?B?d25raTFQb0dUSktYRHRPWC82OHJzWE51aFdIcVdhUUlTYVhhQ2MxOEp0ZGZn?=
 =?utf-8?B?TW1PYzEzUTRnMncySFVlUVZTdWs5Unkvd1dwTzVaV2E5R0R2WEZyb1N3ckw4?=
 =?utf-8?B?UjJ0U3lEYWNqZ1ovcmI5NkNyQ090UmYrM0VrNmhhbzdTcmJFVXVNc2pEcHRF?=
 =?utf-8?B?d3pGZlZqRTdXR0Rmb25RQWlndCs0eW03dElyQzhoNldBL2k4VEtyaU1wVFVQ?=
 =?utf-8?B?ZzNrUC9VRm54S2liaWhVNnhObnlUSVVzU1pyY1lBOUU2M3A4MkRKZ2k4UytY?=
 =?utf-8?B?eWlicWtaTDRuOXRaSjd3eWcyVVdSK2E5ZkFzSWIzUS9mVXBlKzZteEErSjE5?=
 =?utf-8?B?bTUwdUJxSkt4S09XQVFwV2hJb3o0UWtQUVEyWXJySXMveitNMHI0UE1lLzdy?=
 =?utf-8?B?UHh1VnoyQlVteDlnYzZtY2JFTjFIRlI0WlZ6WDlicTZTb2lwb1ZvekZXaFR5?=
 =?utf-8?B?QVRBa0ttbHVIeWJQTTk3Q3F5OG5KOXpqdVl5RGMvUWloeWdzOWtBVFd3Qzhj?=
 =?utf-8?B?ZE1za2hIVjYyaUJNUUVHVTYzVTJkK1dCZndON0taU0hkbjUzSmJJOWVLZmNt?=
 =?utf-8?B?Z3RCN0xGdThXZnBORDRRaWFFTGFSWHdCaEtZZnBzd0lUK1hVeG9UYUdCNmFs?=
 =?utf-8?B?VEx3Y20zT1BPc0gzbDZnUUhMelZjT1VPcDgyOTRDbUVKejBwOXRMc1p3cFB0?=
 =?utf-8?B?OXdyZ2NLZkh5b2hSbS9PRlRsZWl5OTZFbXBndVN6WEE4UUhwV3FNMWJ6MEF2?=
 =?utf-8?B?NFllRHZXek9kUHg0V05LaVo1Q0ZuZ1RURERKUHltUXhTeHdGV1I5V1A5Y2tU?=
 =?utf-8?B?UTF4OGlyV3NmOVdocUMvTnEwc050aFRqRWZuRzhvYWMrQUoxeUU0eU1YWW16?=
 =?utf-8?B?bmRMUVNaTmxGYUo1S01HdjEwdEFQUDVMdndlVlVLTENhOUttdCtYWEQ0djgx?=
 =?utf-8?B?ODByTnFITm5mY1VFeTJzY0NPWjZna052UW5MT3JNV3J2K3VBbjRyZ3BQYmRI?=
 =?utf-8?B?ZVczR2VkcGplMzl4VUZ1REY2c2dlZmRvUXJPT05nNTMzejRkRHczMCtqQkgz?=
 =?utf-8?B?ZFFRSEJRUHNqL0ZIMzd1UzU0MlJIM1FkOC9CMnprYzBsR2p4alZ6cGF4QXhE?=
 =?utf-8?B?NitkdUthZmdjRXJtZXRFU1kzZ2NSTU4rdndqZGcyamJsTU9mMXhJd21IQldV?=
 =?utf-8?B?S3N6ZjNqRUZ2R1c2SjR1bGczY3MxRXU2a1g3QW05UzZYYytCSUUyTDY1L3pT?=
 =?utf-8?B?T1lZN1ZFcHNJTHhyU2xKWmRnODBNT3Zyb0FnS01CQmt3eTB2RnZjYlhvbDNn?=
 =?utf-8?B?b2paN2Y3Y3ZoeGo1Tm9oSGxKc2FBV2xIRC8zV3JZZzdVS0ZWaTFBa1ZsWVZT?=
 =?utf-8?B?ZlRPN0k1MmJZVjFtWVNzNWdEeHpydWtHNTJwV1VjMVAzYjV4clVGbWtacFpp?=
 =?utf-8?B?aXZ4Z3czVHVzUjVlbkNBQ0hrVWVScng3cU5GNFQycXI3SzZTZWxLSlp5RGtV?=
 =?utf-8?B?LzRsVEtvTjZyRTdYaFVuNU00L1ByV1BHelpjNG1ic0kvNHJPUFpaQT09?=
X-Exchange-RoutingPolicyChecked:
	g2HAlceRFT7S/MhR/uzLwVS0Gg7/b6yo+k+1RC1peWXkagmeUUKtJ5pLUJv18F90y59Pu1OtsmLpccIb4KnswhT3JwwbUoFyKGMtBlhdmqUB4Zkh8i8hh5XmVpocoMnEf3PEErnw5O3DJcW3AVz8t7/5uiNCMIwOxKOOchFCdd2aJxJAIe6mPydcLU0Ha8JJNhvM1gVaXzwnbsuzN5zTpiM8GUFy53KCQZxAE5gGPYIXfSl0tqSdQJExr/mQ38iKaL0Agat6yLFSUcNOT2EuinPcY+1lW58agkW9+U9yG5ziyczIMeYBFR/AmjubShYC4yz5ddZju2YuaocJUX5bRA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1m8ZziF7F5z5iLyzUJfVZ78MMOHMhMHYbO0AXrf24n4XQ1k44TIo0jC1/mPbD3q4HeaSAcNBU7QFEXVqbz3pkl+Dc3bzfIpfnGUVGaT0JHmsKVz5DHXpZpPMGVlK8ExImpGrrVRj/maHvHvSsf7rhtgLaOcC8GoSsIjajIZx3i2Hu5hMxdqX5vXzwF7Nh+EbulHy/v1+XmEYr4ZH2TV1yq1n34CHyY+Y65+NY2CohkGtISeFBkp1KfbSRZc53J7D3X6J0LRAFJJWU+KmA1qIdjPWHJHtpKTWq8SXf6tOyMIo+/buw+JimpSGNDUPQK5er1pa04ZXrl2KAUcka8sYOXC6fe7deDVBR8CN9RXZpMUuMQ4hXbj6G1dxEYpVYast+a5G4jMcY1u+90HKbLXYPly1K57xKnrGWkIDICIRLpG4YPJRaOB2urGq6EMb6DXvD47bifCTsdaBNbDOigzJIf/rwXP4wYu1taq3IPTIro5XxiJ7kAKBNovlBxNzsvj4piJMU0Z2v9geQYRYSOBcf95ezc5ALNvIK33Bz4oedzY3v07kanHEc8t+M0wLp0LVvcniA6QP7qH1GuhY7Tx2rIVzNKBFW7GK6wDaTd9XF2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dec91e0-58a9-4cb5-8bbc-08dea1646cf4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 18:16:23.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZXI1MTwwJqfANB3xkgbVjdGQwZdeolzFna2foa6S+w6SmAecSEUDwoj8ZcyM/tDaCyEIaY1K/xROi1m7sIYgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=842 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604230177
X-Authority-Analysis: v=2.4 cv=PsSjqQM3 c=1 sm=1 tr=0 ts=69ea61fc cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8
 a=XHUgM5TU6wcHjNRqc-4A:9 a=QEXdDO2ut3YA:10 a=7vddhivJGPsA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3NyBTYWx0ZWRfX2YbgvKY4EAdv
 bkRZs1LmtI9frZjn+GbGro4Z3F8+BzsF08b3sIkirqWxLwyWPYOnmI/zhjtQkFQg9by0cx4N5e2
 xIz9DDIc384BK0i8JFGcxFB/rjB9FDtYx6ofhB1RYnNsgTx3Ie8O0D/f0cgkZw0MM8x526gNKpi
 DyDMANMStHzLFiqeGoRoRacYQ5Ts8MsaQGpPdC0pcXvs6zIrA+zqakS0AeR34p/PZaCkbQPHvJX
 E7JYzFOoND13KCiW7eNAvdYF2cvphWhMpN51Ai9FxBrxp/wS0uPdnNzsXgk9ahiJxLcGMPrqRqY
 ErLBy/S/1fYbo5FT5AiQs1Xhs9ik9+hVEtjX6ZF1V4rkmidDSyJW+KB22jIM4XFxhNkTv/i0ryb
 yWzHslxVXKXahtNeJxYCKms9nTpsJHI8TKD5RCqg2hMr8m+gawvhQ2SVE0T2MkFtOcfmVMVYaLr
 Gl5s7xAq/WiKw8HsvQg==
X-Proofpoint-GUID: GzOgd5gu4AoZnxl0hxgDB4yDvsMsw7M2
X-Proofpoint-ORIG-GUID: GzOgd5gu4AoZnxl0hxgDB4yDvsMsw7M2
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org,leemhuis.info];
	TAGGED_FROM(0.00)[bounces-21064-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 88B5E45608D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/23/26 11:15 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>

Damn it. Ignore this, I will try again.

-- 
Chuck Lever

