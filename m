Return-Path: <linux-nfs+bounces-12063-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D74ACBA88
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 19:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CC33BD46E
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 17:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019321E9915;
	Mon,  2 Jun 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZIkOeZ8U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iqpjuEPz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5858217B421
	for <linux-nfs@vger.kernel.org>; Mon,  2 Jun 2025 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748886981; cv=fail; b=k3Nub0L+ZGGzATEXT1eSh+H2qwvdLYpAbt9wYosKzlJ/2/n4LmmCMJ8U+AXxlf7xXkzQEGKQuqi0G+R4xSLibo3U9yodFn+60SbY6G0cWcuP2RsIhZVV3KTDlsa6hap30DXTop+A8ddv5nG5rYlAwzYtGwPj2IMtnFgjExSZr1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748886981; c=relaxed/simple;
	bh=sLrF+6mgqVpmzuQT+jWnuWXCFGHXmFyZSxiMMwGdTSY=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=JjIMWs8zFKIVIh8rM32vB/CUTIJan7wPM2iO4hS/+Stu21/KoCO8SkO0kzSm6l8JDmmVUgRRqrUrveyPxT3Vc7NmBWB0swjrFTgA0TDfugFqnfA2Kh7hv/VcTKKtqvKq4r38V6pz+33xxogCLkStUJUrOjbTvw9PCIEKQi+VBGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZIkOeZ8U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iqpjuEPz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HJO4e024597;
	Mon, 2 Jun 2025 17:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=CHK+fxewbCVopwti
	zd7Q86nAu4oHsKr3hjzyOvxVadA=; b=ZIkOeZ8UdENMtMGjOWe/ouuoZod5tpR5
	siReLxGJuQH6qCY3C3lZzWLNNDLEri5Voevdea6kciSmoOcHPcxTB3V2cVFnnPp8
	l2WuoaYYnNE4x86TjTj6j3ocZGl0t3bb8+b/hw/O0WsP9yPcqyjxqO6dZ6t2XfRl
	bQ5cStm6G+mfv2FtbNDmEHlN2+vK0Zv6yVhwpBWho/TsqLAJkTaqSvO83x8QJe/C
	IIf2Wh3MwzN25kgKdsOqLjWv0itba3DYGTztHYvm5pJGG/wG2WCg1ZHXkd+TV3/t
	A2NQfU6VDNTrIrqRxJVyD9tq7sc3Xttc/qEPFchTLy+KMR0cRJ8zWA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8bg29q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 17:56:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 552HCpnV030694;
	Mon, 2 Jun 2025 17:56:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr78a2qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 17:56:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM1ndBozykc7tTygo6n+mOxeDDRC1wV7PF/FuCsV0sC5tO6BJnnFe3HN4UZ7pZYugbTA8RFdm4ULzlAsLsScnNDUUnAG0rmHzks0YpKi8+gRrdgifdABjUf+kN7UWwEPztEfKY0TXcKJC2Ac/0K8+GJHp249jF5FIBtZNL5eERpdihV5sMVdR7ltRtEWjuj9bHmLu0VNNdfRSnUg8yCOhl4ZqStCnyg28RLGJ1XsWrF+UtcmrpA5pS7U9RxprCAJYzYnPQ3hy+ofz8YDvO4F9oPXeXzsQBMwaTtHZn1HiP3UDuxhWTtpHeGc91uIpVhP/By+CXWBSHUPB0doQTqIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHK+fxewbCVopwtizd7Q86nAu4oHsKr3hjzyOvxVadA=;
 b=Dd9I5SIo6x/anFZ6kEqPuwwx0K/k2juDAYQUjoZLPjMXvGwUONo7iOzYLWSlGqFWIBfcZz3d6RquN2AaoeCdKCtIaaHdP6BPwYxkJWm8dJBWsvGFYpjpGMd65LdT6g3f+CAgrbWqzSJsskpHo+W3ViSNFj2oq85V3z3KW660VGvS8dItbHeiBmGeqs1rckjCJhHHjOm5z+E0ig7yqbERmq0t5Bo1ytXcu7ODRXrRtNF0nKCcUzfWkPnlluQF8QbHRHuhVQoGU6aK5lN5d71obR0mjT/VDcFxtXnGbtSy6q42XP7vMMym8AH3L/y3s0zBgy+yr6AD9VHEPkp36QIjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHK+fxewbCVopwtizd7Q86nAu4oHsKr3hjzyOvxVadA=;
 b=iqpjuEPzuVkdihKTi5KJ3w9txovaRFQ540n5JjYxp8ysFR0UeQ70x9D/+n0I4UaLtI0FWoIV0YrJ5pE1fzbMZ5FtBlsEzqPa6LlPXtmORmC+Qn5xEniJMXJPfM/3fkficz9PyQ330SA71VtbQHzN7Ti05VqKXdZjvAZCGkhAVAA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4549.namprd10.prod.outlook.com (2603:10b6:510:37::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Mon, 2 Jun
 2025 17:55:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.035; Mon, 2 Jun 2025
 17:55:57 +0000
Message-ID: <0c1653b6-2de9-4d88-b242-1da16f8c858c@oracle.com>
Date: Mon, 2 Jun 2025 13:55:55 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, benh@debian.org,
        Steve Dickson <SteveD@redhat.com>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: [ANNOUNCE] ktls-utils 1.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0054.namprd14.prod.outlook.com
 (2603:10b6:610:56::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb95fa5-789e-4b3f-b59b-08dda1feba1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmcvZkIrNGMzY0lNamtPNEZRMzVYaDdXZVdwR3NJL0tub0RSbUxoNmtKQndB?=
 =?utf-8?B?N1RmeE9oOTVJRXR4Nlo2elBEMXpoWkNocXpKTk1MT2lDVkpxaTdoNEtvNW9D?=
 =?utf-8?B?Q0FVOHFycldhU00wKzBTOUR0STRaNTZFcHVvNnRHVlBqRUtGMVhkWkZmSUVt?=
 =?utf-8?B?SmN0V04vTU5maDM2bnFQZDF0aWc0VFBIRVpVZjF0N0c2SWpnb01ueGxmTmVJ?=
 =?utf-8?B?M3JlV2NNbThHcDFkRXlrSmg5S2JBejNrbFNOVHArQXEyU1RSd1MyNXZkT2dj?=
 =?utf-8?B?QU9FcG04ZFZIZERYdncwejRraktoYjdYV0t6aDRTQ29mMFBId0IyNlpqVUto?=
 =?utf-8?B?TVA0TlRLTGNOL1pQK0JlSEYwRG4wcGpEOGFzMXRvc3JHUkR5WFFPeVg4K1Nj?=
 =?utf-8?B?eG9ET0dYQS9uNDdMaVZkWnRIZkt5bTNEcStoejNHdU9MMG9rMmV2OTJML1hn?=
 =?utf-8?B?SVYzclFOUmJhY1VzUzFlN1UwQjBUbHJXNmVOcm9GU1JuaDl3aC9SNTIrVm1w?=
 =?utf-8?B?MVNXdUZqVUY3bU9VQ0tZNUNvK3o3YkZLUnBHcCtYZFV6ZkliL2VlL3FLQ0Qx?=
 =?utf-8?B?UFdmYVJsYU1UR1FMNFNMbkZGTVhOTFlURHlOMzlKN2k5WjArbVBja1preXhs?=
 =?utf-8?B?a3lmZUg2cVdRbjc4dVloZHUrS05mbzZoSVBSWDQ1WGxsTFNxaFMrMXoyOWl2?=
 =?utf-8?B?T3VyK3JTTVBmZjExaitjY2x2RTZDU25NajRZSXA2Q2hWMmZVUzg4RGtiMUo1?=
 =?utf-8?B?Vi9BeElCUHRyOTlWamFIS1A2dExPK2lWZFhrbENqY25LWlZoUk1aRmJTUnFZ?=
 =?utf-8?B?bkJ6aWNBSUFDbDF1OHdJR0hRcHdJUWJ4dWlTWEVyZGlNVEtJeXdJaHdHYzJC?=
 =?utf-8?B?RS9EcEkrUmtNMHVVOFFFRlVQL2swdGIrelNseGhpRVdyLzUrRktHQy9TM1Bo?=
 =?utf-8?B?L0k2TGhJczM0L2ROYnBGNFlndVVuTmJweGVyQllNYUU3cThJSE9maXhPd0ow?=
 =?utf-8?B?ZEtsOGJqeStrMzhkNU5ZZlFKNjFzaXAyMWdhaFFXL2FJZUxUQXlCbTJKS0lH?=
 =?utf-8?B?NXNRN2pqdjVOWnFKTWcyRUwvQUFWdm9udmxTdDBsTU5xRURselBMZHN3eVcx?=
 =?utf-8?B?YmVNQkRQYklBOENKZnA0M2Y0VWtkZkF1Mld6OE9hSUlMTVVkd2ZZQ1Nla3NZ?=
 =?utf-8?B?S1V4V0NBbkRNUUFqdWIzZC9uUmVQVm43NlllS1huVCsxN0YwZVhxQnZXNkFR?=
 =?utf-8?B?R1g2TW1lZXpUMXY4dXpPVHFST3g4M3JwL3JQV0RmUUsrZlJFb2JQdFNZM2hB?=
 =?utf-8?B?Z3FlZG5iSlVaRlJxelpPR2NpbmNqejhkcmJSR1gxYVdHYVRCMExVa0RkOG5Y?=
 =?utf-8?B?SjJmcnd2eE5KOS9oZnBid3BodXQzdkhWdTJFYjdkUGd2NVUvQ3NBWnFBZExC?=
 =?utf-8?B?RmcvaEtwM0JRcm54T2VZWkg4WWtBUWpWSDNaL3c5THBTUFNNbDhaR01jT0Fn?=
 =?utf-8?B?cGxibU01QkZvOHdQbDZMdXB3VjBPVjlPNmsxUGRpTkg4ZkU0UFQvSGtrSVlU?=
 =?utf-8?B?bVNDTXZwejRacjh6SDdNeW9tRjM4di84S0psWVczUERHTTJwa25zZFJWOFZv?=
 =?utf-8?B?eG9oT0g1SWFRcmdpcDc2UUVEaEwvbEliWEttcnZhTzVMM1lseldxc1JDY1N1?=
 =?utf-8?B?RzlENUMyMUFqem5tUC9yLzdRYjBwZ01sY2hXZk9OeUZDa3loQ2MyRjArbnlW?=
 =?utf-8?B?WTJHdXVKT2VuZ0tURFUyYndlbm5ZekYrWHdpcHNidjl6SE9SQzFjZDJ3eGpl?=
 =?utf-8?B?b2g3dHlRckd0YkUydkJraUQ2b3NFRFArTTltUGNxWVlqZWxZaEd6TllQb3pQ?=
 =?utf-8?Q?0e247cuibOUhm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YS95Y0ZnK0VmN0hpSGh4ZHlMZTRBZy9OZ3c3QmM4MDFURXNTd2xuNnNVc1FS?=
 =?utf-8?B?NW9wQzVLQ3U1UFZLZUF3dCtlQ2J3VHdPbWdXYnArbjRXT2lLUU5ZRTlvTStV?=
 =?utf-8?B?R1pKZEtXc0dwNEdObkFSM2c3M1NMOUd2VmR1eFlzSy9uK3JyQk1uYjUwbmhG?=
 =?utf-8?B?TnE2WHhhZHk3T1JYd2dOMUhhdUxrRnZJUUdOekxXaG5VcE9HSnlycEJKRjdp?=
 =?utf-8?B?bmxpRFJLcEVsdFZtd0VHNkQ0d242YnFVU0oyM3BYNkZ3RzZybWwxUU9KMnR2?=
 =?utf-8?B?V2tlT0VLSllEUXZyeFJiWHBmRGJETWxaeWtlbU9QZGR5N0FGcGp5RXFDMmJi?=
 =?utf-8?B?TEMxQWRQUjVRWVVvcGJDdk1QazBuenN6SWNaS0NIQmhoVXQ0ZHJlOEZFZ0FE?=
 =?utf-8?B?RDdIcGpCWWpBUThJSEt3eXBDVDRCVHJmcnRjSUdLUHVTbVpmUUhnWHYrSXFs?=
 =?utf-8?B?U1ZhTjR2SFh1czBFcW9KanVkd3VSQ2lxd0ZmbFpYUXFTWk0yR2VpTUg2SnBB?=
 =?utf-8?B?b21sRnBocFl1d0NhT0FhK3dVVzJlcHhyL2pONVk5N0RJQ2RTSmZDaXVHL3Vl?=
 =?utf-8?B?eThUSUxOVDN3b2k5aXdWNmIxU1VhRkttb0t6Vldva2EzVmtSYmFuVWZxeDNv?=
 =?utf-8?B?VHJXcnM1SVRQYzNDaVRiWHAzQ0J2WFEzZEIraVV5Y3hlYU9RVVlOWXBRY2Ew?=
 =?utf-8?B?TlFCQUlhNmRKWGZYVUJoM3pUYzlJeXVQdXhaekk4bFA0bEZSdldnbzdoOUp2?=
 =?utf-8?B?elF0SGxzdFBYRjRXOG1yRnhIZWFtYVFuMlN4blY3UEJTVXZRSnp6b2lwekNP?=
 =?utf-8?B?Q0xsZTUyTUJ3YWdaaGpXTitMa1lDV0Q4a2Z0TFNEYlJ4LzU5M1l2ZkxlRFh0?=
 =?utf-8?B?dG1hT1ZyZHF5Lzc1Y25UV0d5YWVjNmc3ZWs2U2dKZ0lOeVgrMm8zMURFa0sy?=
 =?utf-8?B?MEtFcWhpY2xFRmRkS2JRR2o4dHM5TmdoV1k4SmRncUw0eEhxTVJRYm9Gc0po?=
 =?utf-8?B?UHF0WUFxQkRjK3pEd0xmcGJwUHhBNTFyTm9rdDZzcS96QWN1SEw3dDg1K0Zt?=
 =?utf-8?B?WmhKaHMwQWVGbm9FRi9mbXE2aGJSa2Q2OFNYQUFJY09aS2lZMnFBUzFQUGlP?=
 =?utf-8?B?ZmdqUkIzUERtemlQVzhtb1NoRW1sVkNOQWJGNHRzWVp4YUZ6L0hKbUw1eE9v?=
 =?utf-8?B?MXRaOGdZUjZQSDVPalY3QU81UktyRkJKY0hneTV2TTVhdnQ4aUJ3ZllMekpC?=
 =?utf-8?B?UG8wL3poZG1zdThzSzB0VFhmbFBKcnNnSHh5YmdXNjlwakc3Vzlnd1luRGhp?=
 =?utf-8?B?L0RKUXMvaUxIWUdObk9tZ2ZRZHhQM0V2N3JLWDhwcWt2cU9zWk1vV05jSVNq?=
 =?utf-8?B?RUR0MjBKYnJ5TmV4NXJCNjhLVjA3bEptVk9odHlxM0l6TEdDRWRGTHN6bFFC?=
 =?utf-8?B?YlZrR3JZNHFleVhxQWphclNBOXB6WTh4T3ljZ3BjcTlDQWxoZ282YzFReDJS?=
 =?utf-8?B?MGVaL0RjSVFBZnJUaDhrdjNVbDA2OWR2bzJ1ZVdPZUtmcG9qa3NmL2NsV0E0?=
 =?utf-8?B?ZUV0UFhDcncrRmlDcjJCSnRtdDAraUFGVVp1c0UxVHV0WElaQWZFay95cG41?=
 =?utf-8?B?Yms2VVU0S3ZqUEFjdmR6cGpCdXdkZXl3M01Ka3Z4RzdINERMOG9vU0NCdGc5?=
 =?utf-8?B?NnNNRzdQY2t6UGhJa2hpL0t1N1BqTnF0NzQ5OXpxY2dJdTB3OHBJY0dta3BO?=
 =?utf-8?B?cDY5bHVENFZDZk1RUi81Qk9RQlMxWGxhanIzZ3BURExnMjdTemRLNlpRYkcv?=
 =?utf-8?B?NUY0YjhSa1luQmxjTVhBREtRQTBkeUg1Z3kyY2x6eStFdENvdXM2NHJuWFdY?=
 =?utf-8?B?NWhJb2tnUGpKbDM3bStvV3lWSHdXTnowZkxjVlhibzR1U3hwQTZYTmFPampq?=
 =?utf-8?B?Nm9FZnA4OGtXdUMvcmRLaVFsWksvV09IUzVNcjhGZ2ZoRlZ3c3dtQU52K0NZ?=
 =?utf-8?B?VkxjRnBvakl3VHR0eEw5UGNaTUVvemJkcnBTV1Zlemd1YUZnNHI4V0FmbUJH?=
 =?utf-8?B?aE5xUFp3QWRuM1FCNTJKL1R5aGxUSVBrVFhWQzVjVVBXeUhHQzB4RWtPeU13?=
 =?utf-8?Q?KO+3EtkEFaYbJhDSTzlDsoJDt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VU1ktpJJ+lbsnp4k8s8VDH5jEDmhsAA66MQfJ9yfWhvghfbROFm18Kbon4JkMr5oHbilOshJdGsCxQ2MiU8F3EhAH34fWWKpxU3MkGndXhVWZ+8dGbuMG3LKTzNiDg6x0i6TUimeD7A7zpWUkLsra0YwYd5VuLYPvB1JNzoARu3BCszVP3exRO/Td0DDvXTMUNuAGNwQx3q1B78Ib8RyQ/GdDjLIFMaL4oY2UQkvGdBm1uhuwsSyCUq7wDQwfErdCOXGf44MBnutpZnT8Wn2Z3H67+t2l8GO7PIzOQZMynEZorZuAhSUv6pIgY5qxWMCyvfB9e87hNvejhotMRvbj3YHHeC2MebHTaifZvKAc303LhBhBClYLEKXFSzLj+Apa1DdM6pnKnUQ28e8Eavd1aSza79AfTiYJICS1ra4eZjlmVATIOAPPInwHOs+rCZwwfp0cURdlMkgKi5nkSNGnsA2uHtm6f0oAPEQeFzIekFivIey/wNKEJBUkgRxu6Tel4TleZtxBH5/EahuVR9EnAI2ab4pwNeoCnjoXCDoUv6NtD6ccJfOy1RlOtwdIvCPc5L++k8IiZFAR5tyaGIVAse5qst6oIPDrnLcjjaLNug=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb95fa5-789e-4b3f-b59b-08dda1feba1e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 17:55:57.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQb4LSFVxVhaV1kvrFJVn2qM3ffsw8Cn5ta0p4YXyJoR3pmh/LPdEsMRKc3FzWwjB3S/4oBsK853GElg9b3i7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_07,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506020146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDE0NiBTYWx0ZWRfX1+ZnHwgrAp17 mWNB/fw/OGd+NOmQvjdMKIm4fXkccKkWsEuL63M+CUyenTTk/6I5hpXsB45quRchFKfuhcXhDrQ gTTLRMG83Opva/oo8ALlj+9Mp1/X6UGs7PopPji7Tdlx/q+ZP/77gxQM+pnb93Fn1SUzG1tZr9Z
 IdrxUBPfOvWL37AnQwIkO8n9SZ224NOdTauwfs7AWR49F5tb91LY6sJ1QExDTytGZ30aSUtPUQS /BbFKR1Z04SB200AQMUbMzO/Wv+GQxV7KliAD52dKRJ7Aq/JPdmdGcPvlXRbB/5ov7u/8ZZrrWl Su+eNbJMLs7rgxWv7U/gyYR7pNzHfbENFrpsgZ0x4cUvO9iop2nHD94p7+pqC6iDWDG3q6cbUQg
 BPSYZeZD7ZBDIGrgSr2sT0f5luPllNypCJGsdjRUdNLX2UdMl6PX0SdI41by/Lb9wlHmnm95
X-Proofpoint-GUID: hSTQ4tRGGlBPY8K3u0PcN7Wt5ucGR4n5
X-Proofpoint-ORIG-GUID: hSTQ4tRGGlBPY8K3u0PcN7Wt5ucGR4n5
X-Authority-Analysis: v=2.4 cv=H+Dbw/Yi c=1 sm=1 tr=0 ts=683de5b3 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=YYtLyKhL1udZNufJ34sA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:14714

This is the official release of ktls-utils 1.1.0

Due to problems with the new release process, I've reverted back to the
old by-hand process to generate a signed tag and release artifacts as we
had for previous releases. A fresh release has been created to avoid
further confusion.

This release also contains a few bug fixes and a change in the
contribution process, as previously discussed on this mailing list.


Official source code repo:

https://github.com/oracle/ktls-utils/


Release tag:

ktls-utils-1.1.0


Artifacts:

A tarball created with "make dist":

https://github.com/oracle/ktls-utils/releases/download/ktls-utils-1.1.0/ktls-utils-1.1.0.tar.gz

A tarball created automatically by GitHub:

https://github.com/oracle/ktls-utils/archive/refs/tags/ktls-utils-1.1.0.tar.gz

-- 
Chuck Lever


