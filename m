Return-Path: <linux-nfs+bounces-15124-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC316BCD23B
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 15:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D6E04FD8B1
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15862F998A;
	Fri, 10 Oct 2025 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pzwAshOw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="myd6IayL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C92F83DF;
	Fri, 10 Oct 2025 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102282; cv=fail; b=dBMCXDIOztPG9OEU/yh5GxJB/x/mc7K7SAXGg50Goi14W6o+vp1SNast99tHYU2PoW+joIwoxqxrrmFkE7yf8QIxc5V7TxKgfaBgBXm9HcadgDWrR/NNdyVijYYXinmRo5Alv/BjZB+E4XBY3WUsfx2V7lETMyBJol5SX3neyi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102282; c=relaxed/simple;
	bh=vyc9OiNdZCArIIftQTegH87QdOhgXzRAKb5KyltwbJA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=enaozzGK+zQG9jW8bPK3qwM+MpM1NDE5R+E0FGZbiK2kpchvqbUrbkBN82vYw8ehUG/y5oORa7Q+mExI3P1nDPMTjzJyXaWQien8EB9mbwkhMZmoNQRU9xhKmaM0/+mXov+EErYdwa0nxLxdfqcnk4vXvLh/4eBMLnLXWQGezT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pzwAshOw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=myd6IayL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A8tbvU011435;
	Fri, 10 Oct 2025 13:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Zbejnwl1WqJQXhvM5DOfP+QoznDE7pUYY5v9+u8e7Dk=; b=
	pzwAshOw278QyzyMFp+bTv6GD9gRRdKL2Lw/GlzlinqzM1V+BxpVS6Q6zc4qEi9s
	5CvFAQX0IMwzoGebYt3M/sPF+pIWNE6OW22KD1KMiCafdRRZEuJ1uOm2SNkMujAa
	PSDSMzhbgfXs6z62IwlqvrPz4JYf3KTla4Z91YAXVxopagzUX844uqBnbKhL83cR
	1xzRJH1k0igCBre3iw+XwWhQZ9v1Ljnc5I2yFemjS90feT4tkMXg8AgnanAbRV5p
	Kpw2Q3qeg8tYveTpHEis2NsJ8lM4DuF17nYztIlrxbi353s3HVP6fPB8lpxjlmt3
	B6kSxfJCSip8765G3cYn3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv69un9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 13:17:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59AC3f7F029030;
	Fri, 10 Oct 2025 13:17:37 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv697rjm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 13:17:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/3DW4aEXR/OxhSJl4v6MXjFSyV24KcTjLAB3oJlw+66gmyaVGfJWP63r4r5snxu5KVH+99U5lrebbgrYpdlcqpgYNc6bM9nwaaoMnjVqh4nULIW0Tw0KXPWZriOVb8V5z2MiEMuDV96e0MvibIPhSkAFErP9ePkmgEWT22FFxU/jVVphVQciotKIplutpcZZMcxlCqtR2KWkVGSkRlq81GDfopj/v2HFvnUzPnkfquVywduLHnzZqY72Uvf9ChZ0bUFvslrf5eEHR2Gwr5sA+HgRKa45RNZeuvhGvneKl99Ui/suVu8vn+IJA0urGuIkKxvfNHHoljVPUFM+bX7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zbejnwl1WqJQXhvM5DOfP+QoznDE7pUYY5v9+u8e7Dk=;
 b=NnLKR4+J64H/2QOqTXkhJrBsAr9ep7hYHx6F3VAKFPAUoAnqcs5LomzCKYYSsg7brIrs/lUUs4z/rmynD1gPhnTirfzNC6MVfawcwcxxV0yVPxZoYyZI2xB8rG9qqz6tv/MjlNFAuPmmdeXH4TDu+9R0mJG4ZcADXDh3as+BW/9IZ6n3m0TTY8iYZmuDVgU5cdBWfG+tDAqTpE+k9bLORul70xNUIeMl4rqmVw/WK5uXK4YHydc9ask6KJP480y4lQ31YYd7Vsm9LJGToDs6ozzwu/HFIPowZiq9fWRYuChNRywVsnJY7eTaegSBHOi8UT/QwnxbfSyNSveNVViO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbejnwl1WqJQXhvM5DOfP+QoznDE7pUYY5v9+u8e7Dk=;
 b=myd6IayLOFVwHPJoQ3MOksB+OdldAkp6lEDmlEQ9Yf/gj/EDcNwR/ZDHvEVvbDI8A3Bgq1RhAO8Wkn2+VIXI5uedolldSzEZQzHxa9pO6PeXlFUtq3f2ABMVuTFdPEAeV+z1G11RX2T8s48eggoRla5VhsvrNo3qxaVLDgvpes8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6678.namprd10.prod.outlook.com (2603:10b6:303:22c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:17:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 13:17:31 +0000
Message-ID: <c7eb3af2-9b00-49f0-9baf-9e9dbd27278b@oracle.com>
Date: Fri, 10 Oct 2025 09:17:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nfsd: remove long-standing revoked delegations by
 force
To: Li Lingfeng <lilingfeng3@huawei.com>, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com,
        zhangjian496@huawei.com, bcodding@redhat.com
References: <20251010034333.670068-1-lilingfeng3@huawei.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251010034333.670068-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0291.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdeff18-2062-4a9d-eae0-08de07ff5e36
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZGxMVnNONWJZeWV5cUkwbHJmdG1jaGpUd3l5RldlRm5qdGJOY2JiZ0hKbzJQ?=
 =?utf-8?B?bVpNTzBxSlhFSHNJMmc4d0E5UVV3UnN2TGp1VG5NbEFqY0lMb2RnTU9LOSt1?=
 =?utf-8?B?QkRybUcxTitCTm5LVlhMUXQ0anVUQUdCZnkzSWxHT0lKelpTRjJVeEZnTncx?=
 =?utf-8?B?RGFuTmRMOEZ4RUhKUnNRSDNvV0wycTZoem1odVc2c0t5UTZwOGpwK0c1Zmxm?=
 =?utf-8?B?YitKQ2E1cm8vZnFqRDBtQ1lINjB2c1ZKYkpwTHcvRHZwTlFJM2JxYW0zUkI4?=
 =?utf-8?B?MG1qRXgxRUJTZzZQQ0VmM0NGaTBOY3ZHMkZKaFBrSTUxYmxDOXV5M1hiQVp5?=
 =?utf-8?B?ZzJEMlVXUUF2eVdoSjZmaUdzTnhBVEpPZ1Bld2o0cldKNW45T2ZFZnZUYlRO?=
 =?utf-8?B?VFBlTk1mbDRIbUlJdVNLV0plbEJZSFBPL1NpdFFFQy8yNTN4SUdZd1lLbzcz?=
 =?utf-8?B?K2Iwd3pMeWlVY3E3VENYSmxGUjVROUM1aDRMT3VFc1VSRDA2ZnNkTTF3Q01x?=
 =?utf-8?B?dHVkTHMwMjI1NTh6dnBJbE5XclNYZ2UrSktIMENGRklmK3dmSHZHODc4QW03?=
 =?utf-8?B?Qk1VODdSNFIyWmFNMzdqTlN0alE4SWJ2QzhCLzN6bE52WjRKR3JhMWh0bmkr?=
 =?utf-8?B?NmxpQ1hXQ1NEMDFFL2hDdkVwK2pBN3ZkSGlweTdaaWJ3Q1Z6SmUwblhVZDUx?=
 =?utf-8?B?NTdHSDV1NERJREo1bVhCV2FkVUFTbTZtcjRHb000NG9RTDJXTTBpSGhaYWpu?=
 =?utf-8?B?bmg5Mm5zOHV0aTF6Y215OWNLaXVRbFJ5R29tTnRPVHVMTk95MEo4aDhaWk1S?=
 =?utf-8?B?Tk1OWmlhUGUrdFY3NkJpVUEwc1BIQkxkVlp1dWl1OW9DTDh3WDVZUytBelBu?=
 =?utf-8?B?NkNodnJ3WE4rUTlhZmFKZlhoSkhhU0NpNXNvNXJIN0tzcnFJTFlLc2s1Ymd1?=
 =?utf-8?B?Ni9NZ3dnbi9OZWtaVlNVNktIbTF1M0FrbUpUZXlPM2VmOGV6RDIzVlRFaVRY?=
 =?utf-8?B?VHlxNGJacWtMNzl3WFFYajFlR0tnVzhzMjMyczBLWm5nSHY2L0hmYjFtb1N4?=
 =?utf-8?B?RlJFU1VmQzJvclU0NmZ1aVNDMy92Qk1hT0dKajFRZXMrUzh6MW1tK3NxYkFt?=
 =?utf-8?B?U2RpMHZNYTVJdEZGQ2MrQ3BnSWl2MzVnMWk3bEdMK1NwTkNQWnVObE1QWXBJ?=
 =?utf-8?B?UU5yeSt5YjAzQU1kcFFlZHpKNnNUTGZnUmZSVGNFY3lZVzZqR21XWGRRelo2?=
 =?utf-8?B?L2c1REJab3BqdElLbWd2bTRmYzd3ME53cEVMUnZlNDBoYXhQdjhzSkhyRGVD?=
 =?utf-8?B?NktXRmNhZ2RxU09JbElGZ2QrYmlycmpucmVmcDVycG1Oc3Bwak9pT2VxeVp5?=
 =?utf-8?B?T1NqakgyQ2xoUFhtVWJaUmE1RHgzYmkySHQveUNQc2NoSnlQdi9QZ2hDMjRC?=
 =?utf-8?B?L0hUNTQzemxCdzRFNk1WSWxXcy9WZzFTR3Z4K3hJTTUyWEtKWUtZUktyaXpE?=
 =?utf-8?B?QjlLWGU1VXdJSGdBNllaRE80WVNGWFZIdGpvNG1XUFJETlpueUVqWUpjM2tH?=
 =?utf-8?B?bWdTaEppcGp1cEdEd1ExZUtIaTJQWEdqR3ZsVEt6YnNjMkV0bkd6OEd6TUNm?=
 =?utf-8?B?emlBWmltS1dZSDlYOFdzSS85RWt5L3FCcjNrNEpOd0VKT0xZWTFLSXppaXZL?=
 =?utf-8?B?citPMStOVHdkRTYyZ0dZY3c5ME5UWDNtUmQzekN0NExHSGlsZVhqN1dGczBO?=
 =?utf-8?B?OWZtVWphNHkwKzlFWG1RVFZXcWtKR0VPWlNlTU81ZXNlaitlN0c3RFlhUzIx?=
 =?utf-8?B?SHAwVERuVkQ0bjQxN2NSNzNiOHdzempHT09YMWx4UE53elEvUFdmR3NwY0dJ?=
 =?utf-8?B?SHZCTmdoblE2Nmt0cUtTL0VWZExDakRNTlFMMnhlSkhZdWVMekJRQXBUdE95?=
 =?utf-8?Q?5a7Be10z64Ae3oE4a+5LXs2I3iAjppZc?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WlRBYmNiRVEzcUhLYkxmWk5NWHdmbUpuczlHblUrcXBhT20xQmVKcEswaHZG?=
 =?utf-8?B?UTlNNDBQVkZ3Y085VWtnclpCY2ZQOUttcnNiRFBrUEg1NEVwQ3BiREZkakFP?=
 =?utf-8?B?U2cza1R0NkJCV2RzWkNCWG4yeFNsenE2dG05bE1YQktrWW1TSWFTQXh4Y0dX?=
 =?utf-8?B?WHhXdWFGZ0cySWpSSDJhWTlnNEdpc0srNlhZTEpXejRIbzJiNzY4czJtTEw2?=
 =?utf-8?B?QzRwY1VyV3FnQjNZSjJGcHltVVg5U2ZsZ3lSKzFOYW5VdG5DK3k2cjREcll2?=
 =?utf-8?B?dkhIT0E1dTJjWXVybkdKWDA4TUVnUUtNZlIzdXFnZXVScjR2TFo0RldMeHpT?=
 =?utf-8?B?cWlYcEZSemJzajBVMmRqSGs1ZzBXSklHM3YrTGhMMkFIcnAzN0hmQ3VCMHZK?=
 =?utf-8?B?eXhxcExBbGs1d2MzZGo3S0xiUWJhR0I1UDJyekpmTmNhRnFybU44YzBwMkps?=
 =?utf-8?B?NXI0UC9EcEhwOUQzanJXTE1PQnRUczVRWVNlb0NTZk1JT0phdGxYVDBmQ3VU?=
 =?utf-8?B?QUY3UFh0d082MFgzMEJtdDBaSmRUR2ZFclFqL2xUb0trZnZxeCtUVXM1THNH?=
 =?utf-8?B?ZDlTSTJERXBndG4zaWNuT1JjOEFVQjJsVDk0Sm9LRzQxbUNEUzNqc2U0MHBK?=
 =?utf-8?B?THRCV1VaQjc0TzNZYlVzdld6VU1mQUNCTEJxN1E0c1VRY2hXN21JQTlnZlRu?=
 =?utf-8?B?YnRrdEV0WVdsUjRQbW5Ldy9XMmdEazZjZlU0UGxnSUptWjJGK2g0OGJCUi9L?=
 =?utf-8?B?cE1tdFEva0I3K3lMek45MnkyMHlTUGtKbEE3U1BEZWJ6NmlYYk5remhBaDlC?=
 =?utf-8?B?UGY3amZ5SVBJSmZ1V2xtdE5tQXpmbEs0ajRpSTBnYlZvUHVIeFQ5SFY4T2Yx?=
 =?utf-8?B?cWRBOWdodHhRN29LNERTdGhTeG9ZTHJSd1dHdUxWcnhBSDVmQ2tGaUVjS1NY?=
 =?utf-8?B?NWU3d0hEdndWM3VMdnY0dFgzV1BPbFNrdTBremMrZ2xmZERFalJQZHVTTWdH?=
 =?utf-8?B?SUVrRk9DcVNsekxiZEhDUXA3ZTVXbnVkOWhVeFgrUkxTTlJTN3J5cmhtVlBE?=
 =?utf-8?B?TlhlTldudElnNTdxYjFidk5CdXR3QXRYcnBzaDh1UktSNzR3OU1BUDQwdENW?=
 =?utf-8?B?TksxQVprWDUraWlLYW9ZWWtUczdpNXdyVEtuVjJuVmM5MHlpNmVoTmIzMUVM?=
 =?utf-8?B?bHhEZkRsS0NKanhLTEd3cDlYeml5TVdPSkV6T1UwWERHSnZvSTR1czRKRExX?=
 =?utf-8?B?RTFhbEcxbElVMlVIMzJNd29uenFsVHBIUy9LVHdLWWNHRzFTbWJibGNJRFdQ?=
 =?utf-8?B?dmdTUE42ZTBZWXVEUHVNby94SGFHT2N3dWRWMTRBbnB5RGF6QkhzUDdwSXAv?=
 =?utf-8?B?cGtFUU9vYjdDYkEvVmdUSURnVnZnQ1RlSG9YZ2JwME5BQmsvUlNHcGhVRmY2?=
 =?utf-8?B?OUdDSkc0SzFKMnJEQnBmK1BCWVJLOUtveEtZa1FGSzMyT09Cd2ZQelFhSk5C?=
 =?utf-8?B?TklWK1J3Y3lWR2poUTZPUkNvZXFUck8xUGhzRkdSMDhVblRUTVBsQ0pZd2hF?=
 =?utf-8?B?KzNJU0U4YkUrUUJ3dHFiMFlMZEhxUWkvcndsTnZXMjlWQlczeU42Y0ZHMmRE?=
 =?utf-8?B?RkJpd3FIRFZ2VTlHSUliNUNTb1J6bm9kRTJ4eWJ1aWJXazJvYW5mWXNSUklY?=
 =?utf-8?B?U25hSmh5UDFxSkx4c1cveURibVlLdVBWSGhFektOdG85RklMa09aZGF6T2hO?=
 =?utf-8?B?SjU2OFE0Wms3cmZicnBHcnR0VDdZc0pwWlJVdkJoRnFqOWE0TDhiNmV0TGtZ?=
 =?utf-8?B?R1VRK29CbVpNWTQwOHZKOUh3QXVVNStJYXZnRVFMaFZ3MmMyTWNONTJWK21B?=
 =?utf-8?B?bm55TVNpblZBVzM3RW1NNmxIamYvaWw1a0VURWpISXpzM3A0Ulp4OGhlYXRL?=
 =?utf-8?B?VWlKbHlpNmRJbXJLRThJbnJBWDVmcWNQRTNrN3hUNnRsaFpKS2lrY3BFelU0?=
 =?utf-8?B?OVU4d2RTc1VJaTk2YWtkUU9BcWdrT3dqL3BoT3ZEay9lZjMrQnVLK3ZodEJR?=
 =?utf-8?B?U0FNQWJSYmpmYy96Mkh4cFBKTWFHQmFlSUNhcU1DRGRFeWhxNFU0eVRzSzdS?=
 =?utf-8?B?YU4rZVFyRk1QVEFyS2l1aitvNjFzSXRKZnlEUnlITWpyNUlMdjZQUkZzTDdt?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yEAOpCMZtxIEOCg90eTECcDRvXtPI1IKWMfyKGEW7axK7RJqZlgHHQfqB5IcldYMbpRYQfL4fB9qyZq0ZGvuoD9657BmFhy20y3PRYNy5A3Rix4aGRagVBr6aqhUU8oesSj415AxWVmCjakNpliWBn7UB/81dBhK8VWZm4jLUe2/ZCHItknc3PFvoxctDPAE94+F/W1SQJ3O29sALbzsWNC2B03aonxVjkZA6HI6IerAj3J6fklw32pa0rGG/dWk0qumE6I3flW9EklP2+nMmys1aeiV6LzRe/fgvv53rbWzrS31SrNwaAMdjoMgAiMnLWEJMdEX5kaiGpokAhR/saguBDRZM94gL5K2K6Amnvp2J6evJqjusw3VMu9/dTR0wBGqLtFDp4j+O2gL1GKU6L/cY8i2p/PYgWmKJTvBfFFc8Ma2ocABfUi4lvAyYW2zUkmgF4ktCOCjOJooUfeu0g94ZVaoRWQqfc2UJe99E2F9cPfbg0SfSzHGg38RmuRz9Z1Yiq0jvS0B2f1KX/Nk1LvOgsy25Q9OWccrk51AiuZyuGuYeiRoNw7AZ40tukz6n1HsM3DvmGcgL0DMdSA2isDxhwgLU/0RJ4bBeg1IUOo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdeff18-2062-4a9d-eae0-08de07ff5e36
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:31.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPZMYLIGbx/IVBiXvR2xi8gDizU1Bpp07QgwjPMMAT4/mG8JHGhHj9CwgSSzNQkv3KOud2qJjnh8oHInNvo5Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510100076
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXyGgUfvN0NsvA
 Ge1mDGvCkC9rgtt4iGTIrr0tMwbFRWq3kd1BKhvj/JNwmXDRKQuHwt9FkYVFRTA1FV32p1EkaDZ
 T8EOrXc+CWVUct8Bnr+2CwZzhBzCN0VtlEt64zGthtiQ26o1E+thawQR8F3hPaJVKIklFPFghYf
 UZo6Wv+cwnop4b6hTeSWoKFyIas41tXgIfhQwVdk920gX390/whBU+GpMGuR6+URM6wGYit/PGz
 tL+RsKbJzm2wOO6DA5kJI+RI3UOI+8DyHS5iB+CrAFSkSgfoGvz2FmuGGBh7D6Ie0Rjxl8Jb6vc
 dDYm7/9IDY7a29uqjV0keCbLbxQ4qM7qv08fAFmwjP0IIKR8nEcZ9C5wqZQb1iNNNYiTKSu0waD
 Cik0WCFnwEcl/rlk0GRhuuEbsMjbhTAbVQdZlO1y/U4zxafQwBU=
X-Authority-Analysis: v=2.4 cv=dtrWylg4 c=1 sm=1 tr=0 ts=68e90771 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=8N8TNZzilAbwBjHMU9oA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092
X-Proofpoint-GUID: mhvE3UW_fphUglRY8Fm-xPJo41d3x_CS
X-Proofpoint-ORIG-GUID: mhvE3UW_fphUglRY8Fm-xPJo41d3x_CS

On 10/9/25 11:43 PM, Li Lingfeng wrote:
> When file access conflicts occur between clients, the server recalls
> delegations. If the client holding delegation fails to return it after
> a recall, nfs4_laundromat adds the delegation to cl_revoked list.
> This causes subsequent SEQUENCE operations to set the
> SEQ4_STATUS_RECALLABLE_STATE_REVOKED flag, forcing the client to
> validate all delegations and return the revoked one.
> 
> However, if the client fails to return the delegation like this:
> nfs4_laundromat                       nfsd4_delegreturn
>  unhash_delegation_locked
>  list_add // add dp to reaplist
>           // by dl_recall_lru
>  list_del_init // delete dp from
>                // reaplist
>                                        destroy_delegation
>                                         unhash_delegation_locked
>                                          // do nothing but return false
>  revoke_delegation
>  list_add // add dp to cl_revoked
>           // by dl_recall_lru
> 
> The delegation will remain in the server's cl_revoked list while the
> client marks it revoked and won't find it upon detecting
> SEQ4_STATUS_RECALLABLE_STATE_REVOKED.
> This leads to a loop:
> the server persistently sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED, and the
> client repeatedly tests all delegations, severely impacting performance
> when numerous delegations exist.
> 
> Since abnormal delegations are removed from flc_lease via nfs4_laundromat
> --> revoke_delegation --> destroy_unhashed_deleg -->
> nfs4_unlock_deleg_lease --> kernel_setlease, and do not block new open
> requests indefinitely, retaining such a delegation on the server is
> unnecessary.
> 
> Reported-by: Zhang Jian <zhangjian496@huawei.com>
> Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
> Closes: https://lore.kernel.org/all/ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com/
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   Changes in v2:
>   1) Set SC_STATUS_CLOSED unconditionally in destroy_delegation();
>   2) Determine whether to remove the delegation based on SC_STATUS_CLOSED,
>      rather than by timeout;
>   3) Modify the commit message.
> 
>   Changes in v3:
>   1) Move variables used for traversal inside the if statement;
>   2) Add a comment to explain why we have to do this;
>   3) Move the second check of cl_revoked inside the if statement of
>      the first check.
> 
>   Changes in v4:
>   Stuff dp onto a local list under the protect of cl_lock and put all
>   the items later.
>  fs/nfsd/nfs4state.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 81fa7cc6c77b..30fed3845fa1 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1373,6 +1373,11 @@ static void destroy_delegation(struct nfs4_delegation *dp)
>  
>  	spin_lock(&state_lock);
>  	unhashed = unhash_delegation_locked(dp, SC_STATUS_CLOSED);
> +	/*
> +	 * Unconditionally set SC_STATUS_CLOSED, regardless of whether the
> +	 * delegation is hashed, to mark the current delegation as invalid.
> +	 */
> +	dp->dl_stid.sc_status |= SC_STATUS_CLOSED;
>  	spin_unlock(&state_lock);
>  	if (unhashed)
>  		destroy_unhashed_deleg(dp);
> @@ -4507,8 +4512,40 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	default:
>  		seq->status_flags = 0;
>  	}
> -	if (!list_empty(&clp->cl_revoked))
> -		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> +	if (!list_empty(&clp->cl_revoked)) {
> +		struct list_head *pos, *next, reaplist;

Declare reaplist with:

		LIST_HEAD(reaplist);

Then you don't need the INIT_LIST_HEAD(reaplist); below.


> +		struct nfs4_delegation *dp;
> +
> +		/*
> +		 * Concurrent nfs4_laundromat() and nfsd4_delegreturn()
> +		 * may add a delegation to cl_revoked even after the
> +		 * client has returned it, causing persistent
> +		 * SEQ4_STATUS_RECALLABLE_STATE_REVOKED, disrupting normal
> +		 * operations.
> +		 * Remove delegations with SC_STATUS_CLOSED from cl_revoked
> +		 * to resolve.
> +		 */
> +		INIT_LIST_HEAD(&reaplist);
> +		spin_lock(&clp->cl_lock);
> +		list_for_each_safe(pos, next, &clp->cl_revoked) {
> +			dp = list_entry(pos, struct nfs4_delegation, dl_recall_lru);
> +			if (dp->dl_stid.sc_status & SC_STATUS_CLOSED) {
> +				list_del_init(&dp->dl_recall_lru);
> +				list_add(&dp->dl_recall_lru, &reaplist);
> +			}
> +		}
> +		spin_unlock(&clp->cl_lock);

Yep, this follows the same form used elsewhere in nfs4state.c.


> +
> +		while (!list_empty(&reaplist)) {
> +			dp = list_first_entry(&reaplist, struct nfs4_delegation,
> +						dl_recall_lru);
> +			list_del_init(&dp->dl_recall_lru);
> +			nfs4_put_stid(&dp->dl_stid);
> +		}
> +
> +		if (!list_empty(&clp->cl_revoked))
> +			seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;

Is this checking if cl_revoked still has remaining revoked state? If
yes, a brief comment to that effect would be helpful.


> +	}
>  	if (atomic_read(&clp->cl_admin_revoked))
>  		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
>  	trace_nfsd_seq4_status(rqstp, seq);


-- 
Chuck Lever

