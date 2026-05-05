Return-Path: <linux-nfs+bounces-21389-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CcuL9PL+Wn3EAMAu9opvQ
	(envelope-from <linux-nfs+bounces-21389-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 12:52:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 618BB4CBDFB
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 12:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36B71302350E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 10:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB0B423A9B;
	Tue,  5 May 2026 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gVBNzygJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WYQhN/zg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6468D382396;
	Tue,  5 May 2026 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978216; cv=fail; b=OxVwd/ZE+4dqKbHSlplyZlnD3GjDQs3QJTSnCn9swe384k3Fif7Uo4pq0lX0Xb4nA3TgHeUxKetcdr/NbpKpD/XO3LjxJ6+zCcotbY21w/MAfcz/OTuCgwsNIEmobGw3GJkJW3vze15iRT4I+RlIHUg4NWwljPlymmnrnk7yLNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978216; c=relaxed/simple;
	bh=iCMVd4h7eGYLW7MX8Qhg1IIhYs4tMxrGYxgr66ecZ1k=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s9z3lPQo76p5M5aZa9qGOxkk96O7A+ujxNoi8KwF8mWEyXVRtjNWiuIo40Q04n5/mLgDUUPbHNUQcCIljiqf9KFl0la0qFUqxiHoCQTLzrPHkboY3KQ+WebxOlzy0enZGR96miWYPB5W2Gg9ksasz5YTXECDaTEUoWS1H9pa7KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gVBNzygJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WYQhN/zg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6458foCP854296;
	Tue, 5 May 2026 10:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LiE2JCsAVd+o0Y3CRNfhE6TaVJ7TdCMBudV5IwNAU50=; b=
	gVBNzygJvHVw4Kgpq5xe8nbGYZ4WmukLNQDnSF82FWD4RAqDFybWC/O90QdPdzEB
	124HguxuzGuVhFukSMTnCNB3YdVjGho0n8CSO8GU/dCLiKQGvsi15ObmLuM1MvVK
	O3/b8K1rYKTOrlf/Y7d0YYETZAibqbQq9UnfrR3Kwy5XgNjQExMd+bykhB19ORd/
	D76eRAx16NQ9cdx2/sLU6ObskAyv+eMCKds2+ShmaTfyVkiNQZJGPClZ2YXjJc7g
	UJO2i8SvZW3oSKX46J3YnEoqewJCqjkLy6uCXJstUT6SUHNMvyUgiA/NYlHovSa6
	QuOI9Mp95litJjLrvqxqyQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9fb4n0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 10:49:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 645AkQZJ036095;
	Tue, 5 May 2026 10:49:52 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx575gg3c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 10:49:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLy8iHJ+dg6Mnr5Cq4wGSr2HDt/NhJL4H1d7+fBvdvenSZ7OocqqErqtehVbrExaVxjgr2cdmKHf4G+xorSGzocCwAbYsEtNvSbwzynmu9LD7zmpIUanHRfGtEUan9pl61G3BRqZNTRxCwY+rNCZZoKLpXpSPq5bojJjPLnJznlcgDXexsGxg1YlLLfBSUnwLtWxRPREZFutJ0PwojFeduDtuthWBklhmXFq+TqkaBBULNKwmRjdENRZaXdyLf7THcEyIthLTPXQRVKT2NgcaZdKwYfct/YytKljpRjwPUhxGu8R3UrOPeARShfNfIadlw/KpJzbF26WSqvOg2ngEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiE2JCsAVd+o0Y3CRNfhE6TaVJ7TdCMBudV5IwNAU50=;
 b=wwBaZmPvedgcfBCG5GUAfPKvkfWcQylltuJpt4ZRhJWJEUIBOyTDKXMouxTGoQCKL9U8wZ+1oVSEDNMj0Dec3OarWiOf2lUOwZR+C+Th+xY1yjap1YTkvs8i5Fujtt29sQWFDWkdzfcaFDo9KVVyRz+8Z3HjWJnES4VbsziUeUCCh5vXXMvNPAynUP/aVr4Vkx1nWw9bp1FpBzghkRcNNnayAMAhzPXR3X9QBGnqjZjAkcZpL6GV8hINMbfBNqdRe1NAXjSYuKj0on7BFXgp3BJRp+ROJ6eKVEnQWGU3IJb956wIY8KwkCNG8w1yJpXyAHqD3Bi6uEgWPkOZr9TJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiE2JCsAVd+o0Y3CRNfhE6TaVJ7TdCMBudV5IwNAU50=;
 b=WYQhN/zgSj5BuT5YDuPPp5pmThomlWzLnXQ5DEDrCD5bRmrKYAwS4/ePH3UevvTmAc+EbogNgpieQDR2oJLEjTzfksfrhSe3c9RBh6LY/EfMEQqYRT1xFwdq3oFnyVmfQCQixgat7PNiv8EAfADPDpepS+9c2+BZf81Y6TGfpaU=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by DM3PPF8EEA8AA65.namprd10.prod.outlook.com (2603:10b6:f:fc00::c36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 10:49:48 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9%4]) with mapi id 15.20.9846.025; Tue, 5 May 2026
 10:49:48 +0000
Message-ID: <daa6461b-d8d6-42ad-adac-ac0df58c3b6e@oracle.com>
Date: Tue, 5 May 2026 11:49:44 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, alexandr.alexandrov@oracle.com
Subject: Re: [PATCH 0/6] SUNRPC: Address remaining cache_check_rcu() UAF in
 cache content files
To: Chuck Lever <cel@kernel.org>, Misbah Anjum N <misanjum@linux.ibm.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Yang Erkun <yangerkun@huawei.com>
References: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
In-Reply-To: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0464.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::19) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|DM3PPF8EEA8AA65:EE_
X-MS-Office365-Filtering-Correlation-Id: a859ff45-22c0-4d30-7c31-08deaa940711
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 LIn9vkHeZHhHKAOTCQTN7RiVXNsf1PSdC7SlPKdJHFQV3017K+oSxZvHoCAhZXVfNQ0c/YsMAWHcyQ6NOO1xiHpl/xCDcxdJSj11TsBf6symMNEp1IvjGl5RKrzIR1WMXP4VqGplD/T71lROgFnfY/JV/iSFp5ucMyDRrvdjj2UpwHsfR/l0YkF8M0c6W3RN17jqRE9TkLY3CjOO1jvV2FYQfK7ZcHoC6bCo0gB8mNlhE8PoKZ6uqnmHW0E0Mzy33GYUwa7vU/Dwfr+kE+nb9UR7yxx9/CeFuDxIyGRWb1ruLSyk3GdzkxYT3Xlqb9Hyd0MrXjfUHKjO+FY91gZ8Qj4bmnao6wIGKIPybZhN4bdy7FATJSTrYGa8jk31QmmS1JCeGYwE0/0oCD4WHtnQ65m1pfRTeXWinBsM7gLaYaFNfygKnEiurr/Bi2h8yrygTVAsCdUCbap7gk32adF7DoarGiN3ZaroMnlkIj+lTJGzNCkESfekiatgumb9ErnqwncYQNG5kqkHc5Aki0wvf7+2zQiKrFyVdiEwhAG4jHnRzkiYXIwA58Gm3XUxSClL6LH73uiZHAIMVnFFBxRftbZBGQBaWJQNhwVgJVc0ZwFfpnZyH4Tq2V3h0WkMoWPt6R2PGb5+gK18li6oD+hbWqLUxhqoQeeRc+uJNMEm5Ngm1yR4iSf4IYPfIoIsVrBEvBozlpArltVXh73nT6E3QFwSI523TcBCtPrikwtW4co=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NTlVRytYQm1yeldGcEtqYmZTYTN4aU5UdFptMHBjZjVJZkhtMEMwbUU0UDkr?=
 =?utf-8?B?RktLZDY3enV5NEg2Um15U0paMEFJeEFHb0JlZXFTc1JuTFcxa0Y5NDhVemxU?=
 =?utf-8?B?VVRObXNLY0plUWV2ZkttbFFsWjNuaW92THYxRXV0NkJlQTJDckpoWGQvV1dK?=
 =?utf-8?B?SVZnN2JwdkZqUmN0c3BEbGRFR0hLYUxMdnROV0E0UUZXSUxsTnkwTi81TlNB?=
 =?utf-8?B?MHk3eG5hKzhrdzNLTk5jdldyZFkvU1NUdGwzdk1Ua2RhK2FxM2RER1NwKzFO?=
 =?utf-8?B?RlJzQVgxaUdzRng3T1pPSWt4S0VySGNndzh0NW12UWVvUXcyL2ZSeDJRL1RE?=
 =?utf-8?B?MVA2T2RXdjh1elZXK1ZTNGhYT0VTM2cvUldZRW1aeTZaUE91SnExVmxhYS9N?=
 =?utf-8?B?SzhCUXBMaE45V0tUM2liUXJ5cDk2OGh5bkxKYno2OTcrNFhWWE5panRLc0c0?=
 =?utf-8?B?UUVyNjJod0xIZHdyM25lWUplYWQvRFM1Tmw4b293elB2Z1hTMkpzbHB3S2tW?=
 =?utf-8?B?NGZyUXNuTG1qTFNEby85elpKQURleWtVYlFpTm9qcmZFSUUvUVhJWC9sVGds?=
 =?utf-8?B?QVNvZ21rYXVUTHFPSWw0MmFlYjNHZ3BKUURWVGgzcjRaTUNkczVPMXhJL3ZL?=
 =?utf-8?B?K0QzLy9HdE4xOVJnUkRmSzJSaGwraDZoZjdqeWo0ZkE5YktrYlVjMmx6MkJW?=
 =?utf-8?B?bmZZZHVOTDdvSnB3d054VUZUbGI5eWpqY3FhY2xOWFhndlcxMUdJVWhlTHVh?=
 =?utf-8?B?bWNWTUtIZXFnb3VzaWx2b2xVMzVOVThqeWlQRnVTV2VtSCtBbGNwV2xvblJv?=
 =?utf-8?B?eGlLUkhzT05yM1laVERUZklIbUM2cFJzWW5mRlY1enRhWjFuQ1lINGZQcTgv?=
 =?utf-8?B?UUJiaWs4eDE0K3dhWlpXZU80OWIyWDVIZHFZcHlwRVdqczluNGMvdVlCNW15?=
 =?utf-8?B?MGZkbmN4c3kzSFc5VG1Ka0dQVnQ1OHh2bHhjMWJyWU5yWWxPNHZHUGtZbGxL?=
 =?utf-8?B?VWNYYyszNXhYblNISklwcG9adTM5bVpqYkZkS0xQVVlVOGdKb1o4K3NING9F?=
 =?utf-8?B?S2ZzSXkyKzExMDZKaDZvcWg5TDdDVVBuMWFTU3MzUHhiZ0tBd3JRMXBXUzAz?=
 =?utf-8?B?Y3EwaWZNMmJ5eG1ZeWVsb1VGWHB5L1BTamxrVTB2Vy96aXNLQ2Y3ZW1QTnJC?=
 =?utf-8?B?U3BvMVp0TFZlRXpIeWxIVmxsYU1hanNqenp2U2QvbXVhQk5QTW9DeFcvU2hM?=
 =?utf-8?B?c2dkQ1A2RDNOR1RhVHNLTVJLT1hLN0ZybzZLZTBjd2ZzUHhmZWtObnlXa2pE?=
 =?utf-8?B?aDNIeHVET1VpanI3MEQzWlRTQXdHeEtHak5EbFlGVk8xTCtGT1hoTTVYempm?=
 =?utf-8?B?Z3JQU0hGVWFvbU9qemd6d21sWHNjSzZtQTdiaG15cnZhYnZLVldzR2RhWXZq?=
 =?utf-8?B?Z1FRS0FRempod2lQUi9KSlhrV2FIakp3Yms4azRMOFcrY09vY1hkMTlwcWNC?=
 =?utf-8?B?cE9TdlRVWEpidkt5Yi9uU2ErOWd2dEp4L25iQXdFbktFNElBSkpPM2puVjJ0?=
 =?utf-8?B?Z0xwUk9lNGdRc0NEcnBQYTBubFhvRTllczlMWmluQi93ZHJOTDJkSXFHZW9j?=
 =?utf-8?B?L3BrT1U5VHpCYUt3a1NxdHFva29QaGN3bW9lanhzNm42Z3FueWZpZkF2RVVD?=
 =?utf-8?B?Qzg5ckVFOXZlNGJZcFVoYjRaMk81YmpNZzl3TVdlSzlUTHZEN25Xd1VXaWti?=
 =?utf-8?B?d0NYMEtYRHhlczIrSmhIUmkyQ1BDUHg0SytyS0JwL3o4RnJCYTQ0VlRkc0pM?=
 =?utf-8?B?SzhzeUY1cSs4QkRmbm51M2duUGhpaGFNeDc1TUZXL1g5aDI4QVNWSElRVHJP?=
 =?utf-8?B?UDgvVzVaZFpLam5sQWdlVnhaTUMxV2JEVy9RT283TjlkMnZ3eUFaN3hkRm5B?=
 =?utf-8?B?TktGYWE1d05tQUR3Vnh0YlJDUnE0WEFLVXprWVdtbU9FYmowME41SU80Qmpa?=
 =?utf-8?B?aEN6ZGUxaDMrY3A5SlpycSsySFBoL2ErckN2N0Y3WUV2TjNNVHM4aWUvZXNs?=
 =?utf-8?B?a2ExclRZT1JQNkVYNGFOMldWMDBNcFNEbmYycFQrYWhmdjl0ejNSTUNyanM3?=
 =?utf-8?B?MVpHcVI1ZFR0Qjl6ajVaSS8rckc4djlDVEVkSUwzSTZPN25kbHVWMEU1RmND?=
 =?utf-8?B?UHM1dTlKMzM5dWx5MjBpSElqSGtsK0xEZjVKa1FrOFhPelpYcU5aeFhtUVIy?=
 =?utf-8?B?WFk5V3JrZUg2QmhSb3pOeU5EVEUwQTBlajBzdm5aeVo3dnFKREh4a1lldjVm?=
 =?utf-8?B?eXVqOTRad0JXS0c3NUtKWGdRWUxQWCsycUk1azhlWmh3YUNWaG1FZz09?=
X-Exchange-RoutingPolicyChecked:
	vyS8gsNxYdRnBKFE6XUV25VpSWU5+UYRrIV11osoWoOXIqNI9wa6SGZD/6cfbRu5BBJ2u0r3+mi/5CvsJ/vC0m9phM98fdbXVd6l9xCGd/He82sthN/rRfHp1tyhAYOqX5oKcSd8rzb0ylgaH62zMcUx3O3DPG3svZMY1XnpRwqGAVKFcBOXZx12PJHgzfn650TJVkj2CXwcsdXNUHVKDGqAFgKQVIc70NVuDS2FArKZDfR9Pl+qaGmwdlp51Rg5g5cbonm9QNuAnYgyDxxdvYI97aP7TiTKflPz1AxDnvzSsSr4hsR30CCcQi3aFiKvph7ppM2I+3LoPkdLP/ilvw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WwDwptOMBqO2WIHJJYUlgd+CFVxQQrVjd61GBDc0HkUZdXFuCNdGvpYCYUlyAVOGU2f1VH5EstKjPbfeNb7+rtldJKcfUPP1vkQAUocd7gIzNoyk0ZAZHjfVdPsYRdOIBqo77otrEObyatczJ4O11aZiIYQwmd5aI1ioEWdlT+37tSndtlV7TMRciffTKzJxdeFGiAYjDytUCTJGkjgU62AXqxL+2NieJKyr3SOfPCnR+7rHQDESbjY02AbYuIGfDY7mExftKwFVcD1bieRuzKgQWH5Dv7BhozrXep/yj4fL6ox68/p+PBdRlAt/W//tR8uduXGeJcvqgzFh/vMQoIyH+5GdcUXkx0LeDFcyLeBj0Gilc5WJW3+1UdcPJ3brtrEYgbuQFqNDFXLRrXPqWU432WU5xFHnGZ5PdniwPtfqQdPYORsoyfh0/A+w2nXCjPmt3+duKmEM03iD3pYcs1uhue6Ax/maNVs9NQG83TMmTcAQgJJsVanwnvkHZ+kuo1bJ6BXIpuQfr1EfOEARuR8zQpIVCaBXKXaSPyUaZf6Iwcde8ydtdYZjdpk0VWke8gqgVZl9qMfZM2bFpgzy3Y9cHRhEfep30el+ZoYOMps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a859ff45-22c0-4d30-7c31-08deaa940711
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:49:48.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkfqQllp+PE6xU7D2nXnmmlQJaLiJmPvlk4Nxhhq7/tFnXMaHmXqzw4J5p0/M38oHu5hpBTrbYL4zWQ2bcP7lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF8EEA8AA65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605050101
X-Authority-Analysis: v=2.4 cv=errvCIpX c=1 sm=1 tr=0 ts=69f9cb51 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=vokaDFaCk9D8ljokpAkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2E5YtN6cDt2hnOXLM2Q0wfxVoVsT2wmv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEwMSBTYWx0ZWRfX8BRqTIgHxhKQ
 QrxJtLdVXO9gE/jDoE0CqtgLPzIXqc/dp7yU2v4TRxSoGDo/Jr+mS6UKbYAvm5v4dfxRT6JFL/8
 GK6kC58E/967Y0rmBgRV0hHbpujjC8jcxyFMfDY0EnHrhDriqIUx9w6FQrQBijEX/OGiNK6d6+H
 9+Tw7z7MGvgFoQlTyqmf0YauFuLPRrVaYMdv3KVWexWWwk0+fLkUSWHk/6XempuOu53vB4VKiRi
 X8RHrx+/O38VzhFGkrPaWuZ5chFnJj6clTifnm61HPe3Z6rzOiBCEnzvDLCceWcN3omPekzFi5t
 trYoEI9suvq/LqajR3Mig7YhSLZHS5WnZwe2xaKbUCQ9CKSQCw6nU0MwMXBVxcgVm2dsYv4d6oe
 4WCkJN6fy9avQqMxGrQ/StxjaZQXaKKV/tSMPATwF44/4ZjAEViR1tA2LQrqWjyuu9uH9Y20H/p
 SivXSm8Fu6ZZaVWN/tA==
X-Proofpoint-GUID: 2E5YtN6cDt2hnOXLM2Q0wfxVoVsT2wmv
X-Rspamd-Queue-Id: 618BB4CBDFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.15 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21389-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calum.mackay@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]

On 01/05/2026 3:51 pm, Chuck Lever wrote:
> Misbah Anjum reported a use-after-free in cache_check_rcu()
> reached through e_show() while sosreport was reading
> /proc/fs/nfsd/exports on ppc64le.  Two fixes for that report
> landed in v7.0:
> 
>    48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
>    e7fcf179b82d ("NFSD: Hold net reference for the lifetime of /proc/fs/nfs/exports fd")
> 
> The original e_show() repro is now fixed.  However, the same
> sosreport workload still reproduces a closely related fault on
> post-v7.0 mainline (Misbah, ppc64le) and on master.20260424
> (internal report, aarch64).  In both cases the fault is in
> cache_check_rcu() reached through c_show() rather than e_show(),
> and the cache_head pointer is plain garbage:
> 
>    pc : cache_check_rcu+0x40 [sunrpc]
>    lr : c_show+0x60 [sunrpc]
>    ...faulting on h->flags off h = 0x0000000200000000
> 
> c_show() is the generic show callback used by
> /proc/net/rpc/<cd>/content for every per-net cache_detail
> (auth.unix.ip, auth.unix.gid, nfsd.fh, nfsd.export).  Two
> bugs combine in that path:
> 
> 1. cache_unregister_net() / cache_destroy_net() free cd and
>     cd->hash_table synchronously when the namespace exits.  The
>     /proc/net/rpc/.../content open path takes only a module
>     reference, so a fd kept open across a netns exit walks a
>     freed hash_table and returns garbage cache_head pointers.
>     This is the same hazard that e7fcf179b82d closed for the
>     /proc/fs/nfs/exports file alone.
> 
> 2. ip_map_put() drops auth_domain_put() before kfree_rcu(), so
>     sub-objects can be freed before the RCU grace period -- the
>     same hazard that 48db892356d6 fixed for svc_export_put() and
>     expkey_put().  unix_gid_put() does not have this bug
>     structurally (its put_group_info() runs inside the call_rcu()
>     callback) but it uses a separate idiom from the other three
>     caches.
> 
> This series replaces the v1 narrow fixes with shared
> infrastructure that covers all four cache_detail .put paths
> and all three per-cache file types:
> 
> Patch 1 hoists nfsd_export_wq up to the sunrpc layer as
> sunrpc_cache_wq, exposed through sunrpc_cache_queue_release()
> and sunrpc_cache_drain() so all four put callbacks share one
> workqueue and one drain primitive.
> 
> Patch 2 converts ip_map_put() to the queue_rcu_work() pattern,
> moving auth_domain_put() into a deferred ip_map_release() that
> runs after the RCU grace period.
> 
> Patch 3 unifies unix_gid_put() onto the same pattern for
> consistency (not a bug fix on its own).
> 
> Patch 4 takes a get_net(cd->net) in content_open(), cache_open(),
> and open_flush() and drops it in the matching release helpers,
> so cache_destroy_net() cannot run while a sunrpc cache fd is
> open.
> 
> Series has been compile-tested only.
> 
> ---
> Chuck Lever (6):
>        SUNRPC: Move cache_initialize() declaration to sunrpc-private header
>        SUNRPC: Provide a shared workqueue for cache release callbacks
>        SUNRPC: Defer ip_map sub-object cleanup past RCU grace period
>        SUNRPC: Use shared release pattern for the unix_gid cache
>        SUNRPC: Hold cd->net for the lifetime of cache files
>        NFSD: Convert nfsd_export_shutdown() to sunrpc_cache_destroy_net()
> 
>   fs/nfsd/export.c             | 45 ++--------------------
>   fs/nfsd/export.h             |  2 -
>   fs/nfsd/nfsctl.c             |  8 +---
>   include/linux/sunrpc/cache.h |  3 +-
>   net/sunrpc/cache.c           | 90 ++++++++++++++++++++++++++++++++++++++++++--
>   net/sunrpc/sunrpc.h          |  2 +
>   net/sunrpc/sunrpc_syms.c     | 23 ++++++-----
>   net/sunrpc/svcauth_unix.c    | 46 ++++++++++++----------
>   8 files changed, 135 insertions(+), 84 deletions(-)
> ---
> base-commit: f3a313ecd1fdab1f5da119db355363b13af6fcac
> change-id: 20260430-cache-uaf-fix-a13000f67c37
> 
> Best regards,
> --
> Chuck Lever
> 
> 

Looks good Chuck, thanks very much.

With these patches, testing shows no crashes, sosreport no longer hangs, 
no seq_file errors.

Tested-by: Alexandr Alexandrov <alexandr.alexandrov@oracle.com>

cheers,
c.


