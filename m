Return-Path: <linux-nfs+bounces-20291-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePp3OK1avWkA9QIAu9opvQ
	(envelope-from <linux-nfs+bounces-20291-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 15:33:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E87762DBD90
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 15:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B1713024BF3
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D9427AC57;
	Fri, 20 Mar 2026 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GeWbnmnj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F5exIIpB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9EF30F812;
	Fri, 20 Mar 2026 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017147; cv=fail; b=Zxi1TI0rmNe6EgVjfLSfYbgTC/EW5bLlYsKUB/nLkPboQBquEW0FPa9//Zz/+Eja9zAQVBtc+8o09lnVI77sjhupZ6LHenq/EU76Gcnhwktirzh9WbI6ypFXJ8ac2l8IlTQuGID26ZCEaxgzX7ncazLYVMcU5smzZKGmTwS2Rmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017147; c=relaxed/simple;
	bh=5XO4wXLGe3gkz3qK4XEHMovvFvv9NGzb8gIkj7MI9rY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NIhfFLw6tskNgAwlSbJUACjcIeRaBOyCYKqpvs48eXzjjSv+IlY3TIytLxX83Nv9qADWSjWhTjLg6hvyELfrYpAy4X1SW7bmQDtc34jbmq+VxkzMCBw977loH5iHvICimZ+jJsyPExe0BJT9akPv4tv5B+1mqCazxRAW34BPylI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GeWbnmnj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F5exIIpB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8YBr53950362;
	Fri, 20 Mar 2026 14:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lp8DUrRcKXmudjbiU3POUsghoQiBCN8pbtl1kv0Ghoc=; b=
	GeWbnmnj/JXk/Kq9Gr6LZ1z5FRYCd9K5MeiXEeNT0jYoMFO3wnpzVDWtXIpweJ9i
	XhoYoxe4qRsH8JexNmi1ScEnjQyxMj4q4So+NCSSsp+5pOhGkeqk0d9/llMKqWfX
	2kE1VOoK661Um1A5Z4mR5WarCpCjKppUREMbWdW5IQD88YGTBslK7CM/0/5p0kuB
	L4BB9HIWIDRCjeTM7fPeHycosWwAmr9u+jwE6ELfF1HsWofTEdp8SntMqdB14fqs
	XhmsHUN/vkQre4ISNB5WcaOFVs7AL3DNwEDeolSHJy2d6vM4ApuDUbD8DGTjTUxX
	5DTYsetnFBs/dckPrp+HBw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvy9s1m73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 14:32:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62KD3Qb8014101;
	Fri, 20 Mar 2026 14:32:15 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4e9p86-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 14:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxqQQadqXSd+/ZZ7ANAn5/gqLkJLhxVi+DAfDYMrIlQt6ycp+7Ck4kCgJnLdMtNcToaM/ygBhgSUN95UqCOb3A94G4m900gij+c1LzILV1vmy8MfPYy0lyAUUUj4a5ep82cafrmHR811bkm04UFRDAkg+e1dlOy9yLGwwCxfkQGUSsS0iQo3XPvQlZiZLdFaUqS6J6C3CLBEG8gqjmPXlzpC8mQpTP6yS7NmYcXjr1qOaPbttq+xyS31Neou4GuhwlHV/ZKnEU3wKIijP1A0ur1LJfHFB6CwRe7fiNOMiZ5HZ2LsPuEFFG4tVtvjJchBksyoJg6Ppi93jbeCvTXVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp8DUrRcKXmudjbiU3POUsghoQiBCN8pbtl1kv0Ghoc=;
 b=n/+rJ2yij9/fyPQOxKNtb/0TYMd6dIjrod8IQXrWHbwsx6tJfHAziinVKrbGHVyK+O86n2c/rJgaybXoRpEYpAUx74Olo7gQqR1uhH0MaTcZXniEzs1LAFQtcSAlc+6vYMwUFBzxss2P0xZzsmh8l/dDeKvX2tsx7QY7Raa/P8Aml/PcLZ5OFpfBqo1W7Ye5Doa278tFiS/kYa1j/1OTle8kCgl0EsVU+y1bKL/K3X2t1Y/XGGlxkX1ASZiyVCRD6cBeDF4UM76Tl7ud/QKDEIYCad+7wCKcEplit97KJTqpGEuH/F3WLFsmpUETF4HTphUHeknlviSPfFUzFmRNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp8DUrRcKXmudjbiU3POUsghoQiBCN8pbtl1kv0Ghoc=;
 b=F5exIIpB29gQHrEGydKZ5cxYbt8EVogJI6zG+B6NGJBC52rgjVWgcQZJQPIR9hTR9IV8wiYo6X1LG5j8sGVck72Jl3JLIIGj4aVmqPiF6A5HYxQcfOX07ye83qJlZDR50Ri4hHVp0wHphsqfSQtR5Ea++NlOwm6ZmLyKnY6e50E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ5PPF5467E3597.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 14:32:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 14:32:10 +0000
Message-ID: <47cd2355-04b1-4719-8d91-421d2a9fbcd3@oracle.com>
Date: Fri, 20 Mar 2026 10:32:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] sunrpc: add netlink upcall for the auth.unix.gid
 cache
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
 <20260316-exportd-netlink-v1-9-6125dc62b955@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260316-exportd-netlink-v1-9-6125dc62b955@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0056.namprd18.prod.outlook.com
 (2603:10b6:610:55::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ5PPF5467E3597:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c47665-1d03-442f-0423-08de868d7836
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 wvX07XkR9+rzlrApASUTW4USvgc6kety0sEAsZ0rywYZo6eU0vY7q0i44NoZf6ysPklnohXflNbjmsrkOLJlbU8MyBiIwtBLQTzquNxd+PpHMW2yGCz+gxyAQuMk4XOdl9PHy8vG6DSXyTpdIv8YNrDpMlgGHnPZZMvLqip7zOdnfdYsZA89VKHK+r5BzHulmkoeVRfRqOjUGVf1ZtDWAwjYOo+C9XwwVSwch/5LS+Oa2qjZrwvzzIlGF3DoY0kj0MwkOgh4cUDzA8oJWpAZiGflZBy/8IA4eozskjQg8Ul8A3TucuSrUIZqQcGWNKLO8STZumga1vWY3eYKck3wphaf9ie3xaFuyMwUAK13GR4s4CgjlPqy0iUeXe1wk4cHJY7Lb6zW65+QoV83l+S6baVVrJHtPZ2eeqz0yo2wOtD4m/TaUE2K2PaI6U7A0nhgv7rLLNaPtjQjEGmU9VswEJ9z0GUS1wt2WMeWN/kTy39bMbH/e8IPYMI8O0fg51B21MmxWJewMpBuJovEB2dPxl6xgMGV/jldekWTsyxk6atAd7szSRSJ+62FH2IHSnJ964QYSWBSr5Gqw8QCcg3ktgF2ZOW+2G/G8+S6ofpKWxCM4z1tIMCLjh8iNAKdRzBrhCVw7I1u+1W4ED1XIQAsyjb5xfKop+EtVUSKuSRqqsv+UELvDkzce9TU+aP7nsv+c0hTTC1Zie91Cw4C4Zt/atry0mKeVe619Jf15kn+T2I=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VC9PVWpGQ0JVcm5YemlXdU84OXdjelN4RlF6UUU5Q2hmR1lzc3NreC9wQUJw?=
 =?utf-8?B?ZWVCcTY2c2tqNzBQcGxEeVpwTHd4aktaQVVlNnhVNWlidnFmWkNqMG9FWWpC?=
 =?utf-8?B?VjRtSUg4d01wVm5DQVlpVXp6WXJ3MzhiTUZLZmpOZDNDZnNBRk1ZUWlKUUQ3?=
 =?utf-8?B?cndjb3MwR1MzUlFMSHZ3SjF6WGZidmUxWlBGZ3VpWHVwc2NzZ2VHMldBQ2dG?=
 =?utf-8?B?OUZPVE1QcXFLeUFacnFNOVcrVHJtNVh4RkhnSnJMbis4bmNMYmR6dXI2ekdw?=
 =?utf-8?B?bXV2RWlQYVE2cFFJRHZwZUFPRElMdCtEK3dIUjN4MnZiTElpY0hyYmRsMERN?=
 =?utf-8?B?eGhXK01pMUhWdEVwTzdWN1J4RGxnclhiQ3lqNlVYMCswalU4MlpVUWw4MXVv?=
 =?utf-8?B?cHFYS3JtMFgwSVc1cEFnRGd3b2NJUDQrNld4VElQSGJIWWN3RVNDcU9RUTdJ?=
 =?utf-8?B?dysrMGIvT2pLVXFoR04ydkFJZjRJandab3VlOC9EeVlpRENrd1Y4elhWOUh2?=
 =?utf-8?B?R09vNVh3bE5TNklKT0Y3LzRiVWRRYndrUWxWS1l0cFZXb05OQVNXZ1JlLzZl?=
 =?utf-8?B?c2UycktaVHZRRTlTMFQ3UFdpTEV1cVg4SURNdG5Bbyt3UThRYWNoQzFQaTRM?=
 =?utf-8?B?RnpodGlwWVcrVGM0d1FaTjF3dXYxRFNXUlkzZFRqM3c0YVhGeGN2K0hVUmx4?=
 =?utf-8?B?MDZZdEYvZzRLVmpHQ0s0dXVBWlZNUjU1Si96QnpFUUtyc2FqR3Y2akJjajJG?=
 =?utf-8?B?bGR5MklpdUsyRkE2ZUZ6TzRWY1l5VFJWQWZjRTA4YnRYcnVFVG5UTm5Gc0ZO?=
 =?utf-8?B?Z3JWTFBFRFJON2NkVGNZU0s2MC9sWnVNOG41NlNSQ3dUM3hMa2NJejdJZDdq?=
 =?utf-8?B?OHFlZE9jQXVtTHFZWWpDSnBUK2RPQllMQnVIcUs2bmdtaC8zMEV3QmdwWkJj?=
 =?utf-8?B?Sk1uQXIwWE9XYlNHNmR6eTc4V2UwaC84ekwxR1VLYmdmeGM1akREYyt5TTM1?=
 =?utf-8?B?T1ZxdHBobDJnQUI2Y1VEVFkrT2pRT3lCUHNPcXk5NjlJVEFLdzVEbkNucnQ5?=
 =?utf-8?B?a0N5ejFxTG1aWEFkQkRhMWRhbThNdU9nYUNRVnN2SU1jMUs0NW1pRlN3UDZ5?=
 =?utf-8?B?aUI2QmYyNDFlSlJZY292M1N5NWRxNnZVM2cwei9vb3pBWFpRR2FvRThBMkRl?=
 =?utf-8?B?ck9mRG1OK0k3aDZNd0kyMWp4ZFRzclJIdDIyc3VpVUFyOW9BMnl2T3VNMFYx?=
 =?utf-8?B?dzQ4anFCSEVxbm9JZkwyRW1QTXd5RldZZVEvUE45WG5uUGxKSEZEYXVFSkpu?=
 =?utf-8?B?Z2FYT2pqRm1WajI5cTRtRTl5QW1oTnN3cUlPTmNvTU1vbmVidFpLbkxyQU1M?=
 =?utf-8?B?T2VEaGRmaFNIMDBMY29ySkR0SHpyRTJva3ZRMHE3YTVqWThjZGg1UG12MjNF?=
 =?utf-8?B?d2JHRjdJMXd6Y1dlRkg3R0lzZi92aG85TGUvL2ZiS25nQVNDQlM1bS8xTytK?=
 =?utf-8?B?QTg2QjEwT01FU1czVG5VUDJRWEdLRlU0L1c2YjZmb1lHSDdjUVlrcXVqTUpE?=
 =?utf-8?B?NEtOMHMrTGIwSWoxZ0R6c1MzWG56VWRXeW5sVHN6UzVvQjFZT2RrZ2FlZHYv?=
 =?utf-8?B?NlBIdDVoSW5HZlNiQm85N0pHTWIwWE1uRFg5WkgzR3NIMzRCWjY5VnRLZ3Ro?=
 =?utf-8?B?THhRdFNNRG5qV1RnZmJNaGRkTDhJeXFrT1ZWYnRKdkZOSGZITVk3cjN3aWZJ?=
 =?utf-8?B?Z0g3UVF1akxJT0VHQUpJb2thUjBIVUNZU2NaaGwxUHMwaWpnNjRtRFNhUUJq?=
 =?utf-8?B?Q1RoanpPbFdNY1Z3bVdHYjVRYjJsOTZ0d0Vnc2N4MVNVUFpKTElyUysxNnNm?=
 =?utf-8?B?YVoxL3VtMVYyUU9KNjV5TjRZOTh6Tkw3akZ4L0dhSlJiV0x3MnIxOHFqTlhD?=
 =?utf-8?B?a2VFZG4xckIvT0czNmJzVy95OUxJOUpTakg0STRIWXVweVFQck82NUdVSXY4?=
 =?utf-8?B?U2prdmh2R1NnQUVEQlhObGJINy9yekdxd0psZDdaNVhrZnNQVnNqMTFHS01Y?=
 =?utf-8?B?UlhIeEZHZlQxLzlkVi82bCtVMUJYQ2F0a1l1SlZyKytmOXFWVnBLcnltN0U4?=
 =?utf-8?B?ZVRGTkdEaG9JZFVIVCtrRlM5akhwa2F3U2pYQ296QnFxZkFJN2p3aWtubEpo?=
 =?utf-8?B?M1Y2aS9id3NCMG05LzZnQVJDZTN4TWRQZUlZTEV5RTFXMlhSZStibmcrcEZ0?=
 =?utf-8?B?dGtZYkFzNnFTN3lvdEY2UURpYmY5RjZycjRSR2ROaSsyWW55OEs1bC91MzJ3?=
 =?utf-8?B?S0ZSeEM4bGRlQnZud09Gb1pGSDFnZXVJSlNFRVhOZmJVMFdyZFE3QT09?=
X-Exchange-RoutingPolicyChecked:
	MTngn6Msxn77NYB2x/770Ihh1ZpnPlVG2PWA1+pY3tOdYDWqXyHMR4rSHNno5fCVfF0xegTSFYrIUkVl2RBbf8PZfIs7d4lMGfT4Hh1gWfccMYRX/FL1aajoAnFlP4tY9Y053Trtd2jTHzO4azoM1+c3ef81x9/cGK/F9nri1iZmoDzuQG6NNf/T52UCO/RRBLmqjYzpXWP7UloKw10/mfOWtQ30Kq+1NP5uUh69P/f1vgaT/e0Ew3o1ZJUvDCjjGBb+BaKavx4ghjVECx5igvdVlxoha0gueEI+SPAOgo5Rvp7VLkiWvlCLnRhnGp5QoLgwgeBKw9ipgfWmvoRkWA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PZhTiev/bWj/L/sNx0vVkHyWdwkOolSUmwu2/ksXHTvQne7C0+tOcecEPI9L738Y+C8EjfcZgAEBK8LnOE4996V5Gnz9wIHAFv6x+wQlSHeIAqaUDFgB/saNC6PgMXKJC25zmzU2acC+Pqb7sYpJRN2AFs1T/ifv/KSXlujGam2bth3Gz3h8u0QePN6xXhLXzZ/5723BCMNTIlHh6bB1VB9mG+aB4jyYR9rJKTZ+eL4hwlzB0XgjEOpR8087Lik/mXoxIl5qdtprYQzR51cOUWYWyBJyEo6dhxKiG1Qk4n1zgpHJEGeX4yXBiwk4tYO4oSCBfP1yqLol/ZasHSos+f4RyzrY0HggjiUlyebgO7s1ERse4i8vxUXt2riw00yrQi7AbuhMGJom8aG9Njolkv6PWH15UAERTkSt6P1Z3XrJ/qoSuEAr5kw06Ln3/tZOWgWP82coA9S0u3WYiVAZdrwyzELGQHWoWzv1sY3xXoJjg4RhN6uKibXAjt8TlgGHHzmZ6olylTBxwdDxiHgECZvSfJSRhRDpz9zjW2/jEfH4MS+dB6cU3bi1noPy524uETl/nGH1270Sas2tXtgdCGzLYLKpmhoFBelpn7gkolc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c47665-1d03-442f-0423-08de868d7836
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:32:10.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M13APqT+y/cWFRPCgRnoWuBxFGtKJfb6m06gNxY4wKRtpVVqcWLplGv0IwZfPj6KhbllOWi6Yl5PtEsNX0/2Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5467E3597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200115
X-Authority-Analysis: v=2.4 cv=X5Vf6WTe c=1 sm=1 tr=0 ts=69bd5a70 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=eSz-jSUzwAYe993A-XwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNiBTYWx0ZWRfX/NkyUSnt7rgR
 eBA6/c8Q1ePvpFT6FYlFYVwxxgmpMuBBZ1D9Z1I5tSrRI64d8zGhG9AGyeiLAmq36qmRJWertCn
 VPKIgQ6kx07YDZ8pMz0uZoxc8qQkr2792Yq1h73nQ7w+T9gWknSMcLMB0qmr/BaYopeSM/l1t6b
 gW2SmQqGRWz27YdKQ8vJ6ObojNWCAYMNQFqeBLvTZbDBLdYk8c4esFFnkRw6fI5blHNC7AiJzUk
 I/gfjG0Hydsy4I/lm46fF4I3qFAWNCaKPT2Nqz+9ehrUQ1VLbYaMRky7ChssVM+NRR9cY9JTnWf
 PvXvsDgehuyAJVC63JUBxRN9TtaQAxpxhtNYKro8gDmGgYSFngbLfQPj6xYbnFHHahysAv5HraQ
 ZgPBWS8Hqi/0Aq2mSGF43NESqv3pHYDnVQN0DJprrMUj8VIMqcOTACMD/zzmuKBcgnveJCeitfa
 mwNBo2V8h3lcMrW3IlQ==
X-Proofpoint-GUID: lgdJF-Scopg2OMp1IGxKdK7bE-jHAQsP
X-Proofpoint-ORIG-GUID: lgdJF-Scopg2OMp1IGxKdK7bE-jHAQsP
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20291-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E87762DBD90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:14 AM, Jeff Layton wrote:

> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
> index e4b196742877bd3abf199f2bf815b90615a2be04..b84511ff726c1836f777c802943f6d8e112a0998 100644
> --- a/net/sunrpc/svcauth_unix.c
> +++ b/net/sunrpc/svcauth_unix.c
> @@ -585,12 +585,241 @@ static int unix_gid_show(struct seq_file *m,
>  	return 0;
>  }
>  
> +static int unix_gid_notify(struct cache_detail *cd, struct cache_head *h)
> +{
> +	return sunrpc_cache_notify(cd, h, SUNRPC_CACHE_TYPE_UNIX_GID);
> +}
> +
> +/**
> + * sunrpc_nl_unix_gid_get_reqs_dumpit - dump pending unix_gid requests
> + * @skb: reply buffer
> + * @cb: netlink metadata and command arguments
> + *
> + * Walk the unix_gid cache's pending request list and create a netlink
> + * message with a nested entry for each cache_request, containing the
> + * seqno and uid.
> + *
> + * Returns the size of the reply or a negative errno.
> + */
> +int sunrpc_nl_unix_gid_get_reqs_dumpit(struct sk_buff *skb,
> +					struct netlink_callback *cb)
> +{
> +	struct sunrpc_net *sn;
> +	struct cache_detail *cd;
> +	struct cache_head **items;
> +	u64 *seqnos;
> +	int cnt, i;
> +	void *hdr;
> +	int ret;
> +
> +	sn = net_generic(sock_net(skb->sk), sunrpc_net_id);
> +
> +	cd = sn->unix_gid_cache;
> +	if (!cd)
> +		return -ENODEV;
> +
> +	/* Second call means we've already dumped everything */
> +	if (cb->args[0])
> +		return 0;
> +
> +	cnt = sunrpc_cache_requests_count(cd);
> +	if (!cnt)
> +		return 0;
> +
> +	items = kcalloc(cnt, sizeof(*items), GFP_KERNEL);
> +	seqnos = kcalloc(cnt, sizeof(*seqnos), GFP_KERNEL);
> +	if (!items || !seqnos) {
> +		ret = -ENOMEM;
> +		goto out_alloc;
> +	}
> +
> +	cnt = sunrpc_cache_requests_snapshot(cd, items, seqnos, cnt);
> +
> +	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> +			  cb->nlh->nlmsg_seq, &sunrpc_nl_family,
> +			  NLM_F_MULTI, SUNRPC_CMD_UNIX_GID_GET_REQS);
> +	if (!hdr) {
> +		ret = -ENOBUFS;
> +		goto out_put;
> +	}
> +
> +	for (i = 0; i < cnt; i++) {
> +		struct unix_gid *ug;
> +		struct nlattr *nest;
> +
> +		ug = container_of(items[i], struct unix_gid, h);
> +
> +		nest = nla_nest_start(skb,
> +				      SUNRPC_A_UNIX_GID_REQS_REQUESTS);
> +		if (!nest) {
> +			ret = -ENOBUFS;
> +			goto out_cancel;
> +		}
> +
> +		if (nla_put_u64_64bit(skb, SUNRPC_A_UNIX_GID_SEQNO,
> +				      seqnos[i], 0) ||
> +		    nla_put_u32(skb, SUNRPC_A_UNIX_GID_UID,
> +				from_kuid(&init_user_ns, ug->uid))) {
> +			nla_nest_cancel(skb, nest);
> +			ret = -ENOBUFS;
> +			goto out_cancel;
> +		}
> +
> +		nla_nest_end(skb, nest);
> +	}
> +
> +	genlmsg_end(skb, hdr);
> +	cb->args[0] = 1;
> +	ret = skb->len;
> +	goto out_put;
> +
> +out_cancel:
> +	genlmsg_cancel(skb, hdr);
> +out_put:
> +	for (i = 0; i < cnt; i++)
> +		cache_put(items[i], cd);
> +out_alloc:
> +	kfree(seqnos);
> +	kfree(items);
> +	return ret;
> +}
sunrpc_nl_unix_gid_get_reqs_dumpit() packs its reply entries into a
single netlink message. The default SKB size is ~8 KiB, and each entry
encodes to ~24 bytes, so the buffer fills at roughly 340 entries. When
nla_put fails, the function returns -ENOBUFS but never sets

  cb->args[0] = 1;

causing the netlink subsystem to retry indefinitely. A big NFS server
can easily exceed 340 pending GID cache entries.

Should we implement proper netlink dump continuation: snapshot once
then emit entries across multiple dumpit calls using a cursor in
cb->args?

-- 
Chuck Lever

