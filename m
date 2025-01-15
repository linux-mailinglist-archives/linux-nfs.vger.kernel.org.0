Return-Path: <linux-nfs+bounces-9244-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9D2A12BF9
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B5A3A6C21
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FE31CF28B;
	Wed, 15 Jan 2025 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X1G+i5IL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qUZwuFXK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7E24A7C1;
	Wed, 15 Jan 2025 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970521; cv=fail; b=C1l0GuLjADP9yf7VnyNGcC9mc5QCKEFRaAwOZYF0qFMnf73ckOkzl+LISjvCF2fl2B4copCJKWA3e0k9mw8eMKQQmHNHaSQODOGhJw4BpeFfOv9FONxV3kcUWbYwgDzHxkapcDjJ8Vea54GLK8pJMiq0sD6sHRmZ6wDWP23Xv5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970521; c=relaxed/simple;
	bh=6TTyj0Xp7Lbmcez2HtndtROweMTqW127c/mDqr4rTo4=;
	h=Message-ID:Date:Subject:References:To:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GXgX/WpUhfrskxObgkuCRCkhvgo0JQjdZpR7eu/Odn8ryesO7C1eKMNsn14htL/5/iz2E20soRECmSIRElgFjgH4HdKfA6x7srLYQDNdxvUsE+8Mrik5BGvXxBKjJd3NlMFblrcXxXaMRCdHLaa+rmayMqox6PCsInjs1jEr964=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X1G+i5IL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qUZwuFXK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHtkmG029056;
	Wed, 15 Jan 2025 19:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wP41gBUDHCAHnDcGbpO+dpjzGznH2Bz32bp4lJca/ww=; b=
	X1G+i5ILW1WsKzeTs95TDy184t0mX1kG/in/kvOvzXJLI//+klchUeq++9rhVSGs
	hZArrqGuN0kzROnLr67nlxMtQRzsCWLM6g85RkVPrjQ/ZQAXgItEjaYbgiMTH3+3
	sTxOoxvkGy470JVtuEqKDUeQyjx5SiAREfn0ECnbYJsogQE9Ex3zbQQLaBfNSyCM
	Ou8sqP0rkyhcZVKiJV52U+K0DCLJhTmX9DPjhpEULLQfFPXUKWoUnHIVrXcmk8C/
	4B8/lii743pOqlpqW6ev+nNYzDYjIBFJW0YnlCGfozqn48WA7wEcz9athzHygI7q
	nwkL2O3zQ6dDsI4tTlfuxg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fe2gwx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 19:48:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50FJcdV9020364;
	Wed, 15 Jan 2025 19:48:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3g7qf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 19:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7+lGkXs9g0+LCmSFep9pFDgvGzzbNbs/hoktBiyHBwludo6pjZK15vNASN/qmOBuQ5n378tXzhcZJxkFMS3EaxSr2UvCLO7AVHppT2SQkapv4Mma2QXIa6uQfOPo9IPgfpQKiLIkygMLqmkBL+gjhppc4E/oa5Gp0FjPI6ThmHJOhByru2dsBGNf6xuxA15YeXCVbma6a83ORZyWS8pxUDyW3EI5lnqw05ujOQDB/BCk4GTTf4GuAWgU8SrYX41tX4b7AmlF7zYjz/LNmSF+x7a5FjByy7+p9zMfxM3YfyFy0jW5GgDtCbTlzZlz7t71j6DR7GJeIZuwvHF7VdPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP41gBUDHCAHnDcGbpO+dpjzGznH2Bz32bp4lJca/ww=;
 b=ioJPbzzTtoHnlZdu/VtPqHgD+UwE23ZkeWHaD8KpfM0U0ZstXeqWRn/AsoB2Frqufx4fM3EK7Fr6yyXKmWnSkojPOUwPEBYMX/Zq+oKXryyXgZY+l9AQ0iOGyCmCUY9C/kZGX+qekkPWPaROsN/ZTTRYKMv3Jd6kXfZriDAHp0KlBJyuclJzxLZaW6MAsrlWv5Y5RBVIwy8Wtz2sCkVZq+LRSCyqnK0RNQouKk0NIJLRIwqbI7BWKYT6Gw64RNFDzzBLgVX8cqzok271VsUrzZ6U+KGafvxzrCSr7x8jQ+WXBWwO4ZSlqNvTcy8oBsxmy6zgiKaoBy87Witv4Hl9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP41gBUDHCAHnDcGbpO+dpjzGznH2Bz32bp4lJca/ww=;
 b=qUZwuFXK60VvKvhr2a3RTsIaLJa4dJSnofvtdlFLMrdlg2K8Dlj/411qkjkuh88bgZeyNiQ66KwS5k8wqaaHcPlPgzKpaVgkFRkIQs1MPetptGO33aLEDbbjev+2PB+j9rrq+LuWAxOh/5aFmjEeMlZY+u5lm5JYMl44PGohyvg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 19:48:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 19:48:19 +0000
Message-ID: <26e833aa-a4f5-4ce6-80d2-0081458b5e9d@oracle.com>
Date: Wed, 15 Jan 2025 14:48:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Fwd: [PATCH] nfsd: add list_head nf_gc to struct nfsd_file
References: <20240710144122.61685-1-youzhong@gmail.com>
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Youzhong Yang <youzhong@gmail.com>, Jeff Layton <jlayton@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20240710144122.61685-1-youzhong@gmail.com>
X-Forwarded-Message-Id: <20240710144122.61685-1-youzhong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 49abf789-799c-48ff-93b4-08dd359d8fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVRmNWErbXpGOXgwSkRlZStyZVFhZXZDTjl5WUVhb1BybEEyV0JoMzNLdUoz?=
 =?utf-8?B?d2oxQXgrMEpPamtpQU9tdkpGamRKbjJlbzg1NFlid3hhWXZpOGY1WS9vajND?=
 =?utf-8?B?OVRmVWdSbzZqaWhDU1R1R3FIaEwyUDBsT2J3aGt6S2d3UEx6OFduSndYREh3?=
 =?utf-8?B?aVd3eThLTFU3WlJtYWNBekw4MjAyVzJYOE9QT0t0UVhCZ3Q5Q29uUjFxNU5N?=
 =?utf-8?B?T2VLV2laai91a1Z6NXdIYzdnaGtNVDRsNWRkeXR0ZXRqZ01sbVVoazYvM0Rj?=
 =?utf-8?B?NE9UWlJBSittaTZPM2phMnVBZ2UyeGVaK1ovdGdnNGhtV0NkUThjVlM2UnJv?=
 =?utf-8?B?cDRoTzVvN3ZVK0p5ckJxNndNSU1VZ1dHVWNsMEFndlRyRXBCYTdlSmlrT2Rl?=
 =?utf-8?B?OGxGeGlxT25RWG02MUJJTUJhMGlJVlNEbHFmNFJCbCtZZDFpZzEwUmc2TkZL?=
 =?utf-8?B?cThrV3JBMy96TEI2Uk5KQUFrcmZyck9RWC9kN0k4ajBhcVNpcjZ2SjJBdW5M?=
 =?utf-8?B?OE9DUm5yY0RVTkR3TCsyYmVacURFWW4reCtWMzhQSkNzbExSTUFBTzEwUWU3?=
 =?utf-8?B?dWZuQVZIK0RDM0VHOUVCM0hXbkhoRzdpSkNyRCs4SzNVT1pDeFRxMlhYRFhP?=
 =?utf-8?B?bkxuamMyOTJZVGViMFhHK0RqV0NXSTBXalhFUW9nVnU1bFlnenNueTJzL3FP?=
 =?utf-8?B?a1VnaW5YYW15dWd5OVRuMEtUUXRrTDNVSFNFVzVmNjEwRkZhSDJBc29vVmdj?=
 =?utf-8?B?NFE3RERpcFZ2dW5JY213bzQ5U3hISjJqbVdiamg5SUNmVnZsQlM3TGtBN0tO?=
 =?utf-8?B?VnM3RzZNMi9LNFJuOWdSanVkUG92NTlkakhZUEEvZFlHellkY0g5UEZmU083?=
 =?utf-8?B?amxkQ0Y5elhoNDRVaENCdWFPTEkvVWg4SjZ3aC9Ebno4Lzh5dEtMSFJLZHBU?=
 =?utf-8?B?R25laWFUcW8rQkVoWnR0VmhYdzdhMFdPR2YrMmpXaFExd3djOGN3NC8xSzRU?=
 =?utf-8?B?Q1NXeENVcFZCV1JZV01OK1hZMEFWZWd4WTBVS2htYlRCN205VE1RZUw5V1RY?=
 =?utf-8?B?Q0k2K3pzNkhNYkcyUURTbkRuLzlaOVJtZDdQS0ZSM3IvR1J3Y2ZCUXhzcUF3?=
 =?utf-8?B?djZ5WUtDdXBUM3VVcEROb1pHYW9oQnN3cXh1dExwQW9WejFGZWZ6RlZTTUtZ?=
 =?utf-8?B?U2NtVGtIKzd4aGRVcWlYVFY3UXA4blE5VnVsZmFlcmZMbnBDVFJlcG4rK2NZ?=
 =?utf-8?B?ellBQktkZUdGZlRVRjVvNGpDNHpUYnFxUnhQN0JtWk1aU0h2aWU4Y0ZlbVQz?=
 =?utf-8?B?VU5GalNvMDlRaWdUVnlTMlpoQS9SZ1l1K3BvTU5IMEhkSWRLdFlRUzY5UzRi?=
 =?utf-8?B?Ny9QUC9lSU1iNzZBbWFId2daV2pwZEp3c0lpaCtZQ0J1Rnc3SlBxaURMRjF2?=
 =?utf-8?B?V0EvZWZ2dFpJbkNUOG9LTTgxYWFtOTM1WEdQclJFUWZQRjdCY0t6a25ZT1Y4?=
 =?utf-8?B?dVZMbkFCNmkzNkoyTDhpcTZ5K25OODB3RDRDckZwMFdBanBGdGhINVl3eEM4?=
 =?utf-8?B?UHpJb1B2blFEZEhYSVNxZlhYV3Z1WnZkc3VWbjBNbGl3eVE0S2V4bGdGblRC?=
 =?utf-8?B?a3h3TTBWMmJiU1hGbWJBTE10MDVQRmw4UE42Z3h4UW1jcnBvQkw2TVJNVkhB?=
 =?utf-8?B?eSs5TnFhQ001dzY5aEZ3SGlBdXEva2hYTHpPaU8yREhGYnVBY29ZSlFpWGYr?=
 =?utf-8?B?Ym5ncEQ3QzVPdUhMOTdvb3hEYUw3S1Bvek1TVW1yOGZEL1NZVERmWkVRZjNJ?=
 =?utf-8?B?c2srQit4aUdtZnRSSUNLc29TMGoxc1AvcVZVZkV2S2VYSmJROUFpRXhMQklw?=
 =?utf-8?Q?KAWZRMP7J8/nr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkFGOTZvVTZIRVRWeHd0cytiNDdoUDhGWmZtM0FVZ2dPVU4yOGlyOTVrSzlQ?=
 =?utf-8?B?dHhCcEJqdFlmelFMRWRtYzJ2T2ZZa29SM3V4cVZiQlhKVWkyWDRiUkV4OHRi?=
 =?utf-8?B?dll2Qnowb0FHY21sdjh5ZHZ2S09LVXVOUFRnYjBpVlVJOUJRYmgwSlFhVFp5?=
 =?utf-8?B?MUN0YVl4Vk1JS1V3c1NiMVNZMFI5Z3d1aDlYd1hEa3l1UlplNEhYY1kwM2Ny?=
 =?utf-8?B?QS9VTmd1NXR6QW55emtFa2ZQNHVEc3JHQjdOa2hvTVpRRHgwbzlybUhGMkhJ?=
 =?utf-8?B?UXRUcDhTbWFwaGJzRmJuVVMzS1VEZ1VPZCtnc3Mwd0FIaCtudW5zUTh4Sksz?=
 =?utf-8?B?OWk1N3BDV2JYNXhjN09hWFU2L2RTM0V1TTJGaTFQZHk3djhIWHVrWk5rZ21D?=
 =?utf-8?B?MWx5VnpXRkhUT0xKQm9QMGZmSjg3eG5lV1lGZWFxOWVWUVRMdmNheHFBdWRt?=
 =?utf-8?B?T3ZRRWpSVjJvNll1WGpQTnVKN3lybDQvemhxVFlYd0ptVkpxZXdsZHJwRU9V?=
 =?utf-8?B?RVVOTW01RzhGRThkc3U2WXhGa0Y1dHYyMG1JM1ltV3I0azNpeVltSmpjTUEz?=
 =?utf-8?B?QXFzdjJaTUFZY2RrZGI1U0ozNWU5eldUaTNoc1MwZFJMU2Q5bTBqN3VQbGxQ?=
 =?utf-8?B?RVpXZjEwTlZRYVlTblR1ZHRmYUpaaG9ic0t1M1NBcWdVaWppcFlubHl1VmNs?=
 =?utf-8?B?RTFEY1AxTmNTMUpVREI1eU9aQVFpYzEvTUFZaHZQazQxREhJTGdMK0RyMHFN?=
 =?utf-8?B?ckFwc2ZUS0huYXdtc2ZUOVh3VFQrb0U1TUJObzRWSHU4b2Fhbk1uK2tTa3Fp?=
 =?utf-8?B?OThtWGd5NUhvakR2cFB6SHoxaXVoUDh5c0pZNGR4NFZYZy8yY3JFZVlhWHE4?=
 =?utf-8?B?NFY4L0VDUWUvQUpmdzJ6SXJZZXBXbElIOWp0Z3BwalFYRWlOanVIaTd5UXFV?=
 =?utf-8?B?c05rOHZHOTU4R2xNQWNLbUFyeWVHN0N5eitaWDVQd3N4aStFQjZSR2dTcjQw?=
 =?utf-8?B?TzFoUSt4QjBtdTRacnpaODNiTnUvRkVsclc1bzdBUDQ1Q0RibnFEc01lWW5R?=
 =?utf-8?B?M3k3QnEwcXVKREkxSDZJSHRTbS9ITWJVWmdUMmxRUTllZm9JencvSnFXTVlK?=
 =?utf-8?B?aG1RaVdMWVZPM2Q2S0VSbFMrVW9KN1hiWnZ3V1BnVkhKYU9hVE8wS1VSMWd1?=
 =?utf-8?B?QndWTHJlOHFsdmxEcHdoT3RJZlRhWEx6Z3lkbHBYRmNUcVJmRnQ0Zm1NNThU?=
 =?utf-8?B?MTdOdkJxbC91SkUveHkvYisrZExzVkFWUU1iQ0ZrNm9OZG12b2VhMU5DV0lV?=
 =?utf-8?B?L0lOelFIK1JqMk1SQXJCekVaK2RaVXBpa1kzVndKWDNYdXkrSndyZjJNQThp?=
 =?utf-8?B?MjFudjRSYzY1bU9hbzB0bGVmaVU4QXcyWXJuVG9JRnZ2TWRxbURCRkluc2VS?=
 =?utf-8?B?Q0REU0tKSVNFK25Dc3lvSVAwSjV6aTUreDR5M1dLc3FPL1BLZEk5cm02QzQ5?=
 =?utf-8?B?VCtNZW9kUy82YnBQb0k1NTl0TjBaM0ZKVVk0Q0JmYXRnUkdIQ1JxOElValpu?=
 =?utf-8?B?M05XSWI1Y1lacmhLbm5jRmlpdDlLM1VDVUpsNUJJMTNwbVVQdG5zcEZ2M3JK?=
 =?utf-8?B?eVNaTW1FeTlFSVRkN1c4SmpxRmxvTjN6VzVQTWpJT2tPWUJrdzhFRnlzMEds?=
 =?utf-8?B?VTZuQVhOVCtKRVhCLzJDeVhDblFIU05LcFRoS1k2eXl5RGN2ajRscDhhZ2Zu?=
 =?utf-8?B?TXlRMlAvU1ZGZnpuMGpKMFk1TWcvWnlxdjZTeVpQcFcrbUFJOWoyTVl3eFAv?=
 =?utf-8?B?b1J1ejdwRTZLSDFMT3NId0NqWmxqTDk5bWxSMmJieHVkNThQMHVrYnEvekNt?=
 =?utf-8?B?L3lNNFVvY0ZOZG1RU2cvemErOXEyaXN5TVNyZXVoSlk5MDVGWkw4WjhaUEZz?=
 =?utf-8?B?TndRSEZJRVJ3RENQeFRPTVpLaTVDamwxbGxkMENtYi9WN0U3ZHRSZSsxTGhK?=
 =?utf-8?B?UnI4eGpMaWF2c1RVcmYzZ2FhSmY1alVxc29HNTdjeGNFSjhTQm1iZ2hKUWR3?=
 =?utf-8?B?cWg5U25nbFdZazgvRjY5SDVlc2ZDMkJwa2pOUWFSZXJQcFhjYzd5K2I1SmVj?=
 =?utf-8?B?TE42a0RzT1FxVDRDUy9MUmxKOEJPS3VkYndRRFpsTnVCNTNyaHYyUDAwUnhk?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BTpYyLmZpYBaAVcnkRgu2yfRGgCH9Xd3iaUbjkAfTxQBybIyllz2hLzPymMQN/VeUVcUsSJZXL5TgJ93t+Ud5p8IPNJqVRzmE/p8LLwqvMFeaXx3CWaduOkHctt0UubdsR9JM3jOQ/C7Gaj+wt7pYupTSQhnDQdyqe50UAZzprNF5xRlhpQNI5eFHshQx/4jJgsmFaKQRQ0Md6DRaXaNbwnq66IVRtFtwVj5ADs/VLXNkc9bBAjiCWDaA4wJhjelQrDMQu8+Dn0M065aiq8hj8i2cmQrgjBt6VL9gXvDOy/zootEqNf7YNV47E/RQKwBnSp5Z0NuCsa3O5Zdg0k+tNCZiGnJccqrv2T64Rj7BPdYm1n+3ihJEciEtzu4ZuZZHUlql+Rgd41jJa90Og2KFymCKgkpE7uGvT+Fokh/LmwzZy2xJ4AN8FqKkRDcbM927MjdlX/YemUfNjRm+7pCKip2QLFUjZ2Fgyxo0GEK1xAx08zijvV9O78e0Xd23aPTeCZabdboCSfewavkItj+ti2Fb681PJtY02kBmhXs6nrR/Y9p+GnGSFgZMZ5jYQnY2RCVVNnocSr3EQcB8B6bLKntxgXXd1a8AJWFeRhJCoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49abf789-799c-48ff-93b4-08dd359d8fd1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 19:48:19.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDt9OrgORopSb+zt7wYvAZ8EjSfKsx3Fu60XmgR4GjT174P7yAQ3wF3u7snuGCiflObBzTyyOP32tvd83fsWRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150144
X-Proofpoint-ORIG-GUID: oW3MMok-qq3WxIYVzbWlimFFuaozLUp9
X-Proofpoint-GUID: oW3MMok-qq3WxIYVzbWlimFFuaozLUp9

Hi Sasha, Greg -

This is upstream commit 8e6e2ffa6569a205f1805cbaeca143b556581da6. I've
received a request for it to be applied specifically to v5.15.y. Can you
apply it to all LTS kernels back to v5.10 ?


-------- Forwarded Message --------
Subject: [PATCH] nfsd: add list_head nf_gc to struct nfsd_file
Date: Wed, 10 Jul 2024 10:40:35 -0400
From: Youzhong Yang <youzhong@gmail.com>
To: jlayton@kernel.org, chuck.lever@oracle.com, 
linux-nfs@vger.kernel.org, youzhong@gmail.com

nfsd_file_put() in one thread can race with another thread doing
garbage collection (running nfsd_file_gc() -> list_lru_walk() ->
nfsd_file_lru_cb()):

   * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do 
nfsd_file_lru_add().
   * nfsd_file_lru_add() returns true (with NFSD_FILE_REFERENCED bit set)
   * garbage collector kicks in, nfsd_file_lru_cb() clears REFERENCED 
bit and
     returns LRU_ROTATE.
   * garbage collector kicks in again, nfsd_file_lru_cb() now decrements 
nf->nf_ref
     to 0, runs nfsd_file_unhash(), removes it from the LRU and adds to 
the dispose
     list [list_lru_isolate_move(lru, &nf->nf_lru, head)]
   * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so it 
tries to remove
     the 'nf' from the LRU [if (!nfsd_file_lru_remove(nf))]. The 'nf' 
has been added
     to the 'dispose' list by nfsd_file_lru_cb(), so 
nfsd_file_lru_remove(nf) simply
     treats it as part of the LRU and removes it, which leads to its 
removal from
     the 'dispose' list.
   * At this moment, 'nf' is unhashed with its nf_ref being 0, and not 
on the LRU.
     nfsd_file_put() continues its execution [if 
(refcount_dec_and_test(&nf->nf_ref))],
     as nf->nf_ref is already 0, nf->nf_ref is set to 
REFCOUNT_SATURATED, and the 'nf'
     gets no chance of being freed.

nfsd_file_put() can also race with nfsd_file_cond_queue():
   * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do 
nfsd_file_lru_add().
   * nfsd_file_lru_add() sets REFERENCED bit and returns true.
   * Some userland application runs 'exportfs -f' or something like 
that, which triggers
     __nfsd_file_cache_purge() -> nfsd_file_cond_queue().
   * In nfsd_file_cond_queue(), it runs [if (!nfsd_file_unhash(nf))], 
unhash is done
     successfully.
   * nfsd_file_cond_queue() runs [if (!nfsd_file_get(nf))], now 
nf->nf_ref goes to 2.
   * nfsd_file_cond_queue() runs [if (nfsd_file_lru_remove(nf))], it 
succeeds.
   * nfsd_file_cond_queue() runs [if (refcount_sub_and_test(decrement, 
&nf->nf_ref))]
     (with "decrement" being 2), so the nf->nf_ref goes to 0, the 'nf' 
is added to the
     dispose list [list_add(&nf->nf_lru, dispose)]
   * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so it 
tries to remove
     the 'nf' from the LRU [if (!nfsd_file_lru_remove(nf))], although 
the 'nf' is not
     in the LRU, but it is linked in the 'dispose' list, 
nfsd_file_lru_remove() simply
     treats it as part of the LRU and removes it. This leads to its 
removal from
     the 'dispose' list!
   * Now nf->ref is 0, unhashed. nfsd_file_put() continues its execution 
and set
     nf->nf_ref to REFCOUNT_SATURATED.

As shown in the above analysis, using nf_lru for both the LRU list and 
dispose list
can cause the leaks. This patch adds a new list_head nf_gc in struct 
nfsd_file, and uses
it for the dispose list. This does not fix the nfsd_file leaking issue 
completely.

Signed-off-by: Youzhong Yang <youzhong@gmail.com>
---
  fs/nfsd/filecache.c | 18 ++++++++++--------
  fs/nfsd/filecache.h |  1 +
  2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ad9083ca144b..22ebd7fb8639 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -216,6 +216,7 @@ nfsd_file_alloc(struct net *net, struct inode 
*inode, unsigned char need,
  		return NULL;
   	INIT_LIST_HEAD(&nf->nf_lru);
+	INIT_LIST_HEAD(&nf->nf_gc);
  	nf->nf_birthtime = ktime_get();
  	nf->nf_file = NULL;
  	nf->nf_cred = get_current_cred();
@@ -393,8 +394,8 @@ nfsd_file_dispose_list(struct list_head *dispose)
  	struct nfsd_file *nf;
   	while (!list_empty(dispose)) {
-		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
+		nf = list_first_entry(dispose, struct nfsd_file, nf_gc);
+		list_del_init(&nf->nf_gc);
  		nfsd_file_free(nf);
  	}
  }
@@ -411,12 +412,12 @@ nfsd_file_dispose_list_delayed(struct list_head 
*dispose)
  {
  	while(!list_empty(dispose)) {
  		struct nfsd_file *nf = list_first_entry(dispose,
-						struct nfsd_file, nf_lru);
+						struct nfsd_file, nf_gc);
  		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
  		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
   		spin_lock(&l->lock);
-		list_move_tail(&nf->nf_lru, &l->freeme);
+		list_move_tail(&nf->nf_gc, &l->freeme);
  		spin_unlock(&l->lock);
  		svc_wake_up(nn->nfsd_serv);
  	}
@@ -503,7 +504,8 @@ nfsd_file_lru_cb(struct list_head *item, struct 
list_lru_one *lru,
   	/* Refcount went to zero. Unhash it and queue it to the dispose list */
  	nfsd_file_unhash(nf);
-	list_lru_isolate_move(lru, &nf->nf_lru, head);
+	list_lru_isolate(lru, &nf->nf_lru);
+	list_add(&nf->nf_gc, head);
  	this_cpu_inc(nfsd_file_evictions);
  	trace_nfsd_file_gc_disposed(nf);
  	return LRU_REMOVED;
@@ -578,7 +580,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct 
list_head *dispose)
   	/* If refcount goes to 0, then put on the dispose list */
  	if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
-		list_add(&nf->nf_lru, dispose);
+		list_add(&nf->nf_gc, dispose);
  		trace_nfsd_file_closing(nf);
  	}
  }
@@ -654,8 +656,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
   	nfsd_file_queue_for_close(inode, &dispose);
  	while (!list_empty(&dispose)) {
-		nf = list_first_entry(&dispose, struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
+		nf = list_first_entry(&dispose, struct nfsd_file, nf_gc);
+		list_del_init(&nf->nf_gc);
  		nfsd_file_free(nf);
  	}
  }
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index c61884def906..3fbec24eea6c 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -44,6 +44,7 @@ struct nfsd_file {
   	struct nfsd_file_mark	*nf_mark;
  	struct list_head	nf_lru;
+	struct list_head	nf_gc;
  	struct rcu_head		nf_rcu;
  	ktime_t			nf_birthtime;
  };




-- 
2.45.2


