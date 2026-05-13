Return-Path: <linux-nfs+bounces-21606-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPMsHHW5BGplNQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21606-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 19:48:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCB15384AE
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 19:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0829330AB500
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 17:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFCD38E11A;
	Wed, 13 May 2026 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y9i1Johw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sAIb1paB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A23FFAB7;
	Wed, 13 May 2026 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693329; cv=fail; b=rv3eA6idd4tGCBeeCewNlTTDg4R44L4ibI799ZxMh9asMoKJgTEPZnVY5qZ8ZSKVlLNdKa0OwGPkgqJTmq6CrQ0KM5Fm09HYZRRj02UOzjlHUiYcdRzfLiawEILz4xWYf1qlGCRztj7LMiwcxMCfF8Pb9XSOgZTmb5vZVilz1wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693329; c=relaxed/simple;
	bh=r0lDv8AlMOv3dk3L55mLe9rPu7wrQMidnb9NRMhEcoQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GakI0KNtZTGoEcy3HKxRyV3TjxHAVvwR/DLa3iRQ8z0MoIW7vO7UfRnoU7ZVMhchLyhG6KB4zkn9A/RnqFV0zmHBv7LLyaZc2gD6GfshzgIuq7/byT0RrrG785pqtKErfhI066aSVvCibfnMgOw+aSw4ll0bUmjtErCmEWIUxGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y9i1Johw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sAIb1paB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DG5cKO2476768;
	Wed, 13 May 2026 17:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qTMA7WB4qYBBotOa3kPlx0n6lSy+iZ+WFrsiolVVPmw=; b=
	Y9i1Johwob9TsCl6YxJZxlpxCJGMcKW0WzpQlRkWZVcJ5qWyZe+SdbZAYpcwyHb+
	yPt6c71NGOhasLu6fh6B++rNE8iE/NRjpZxrJCvEm+e4ZfC/vkQCsaLPqhg1rTD5
	qEZdrsZ4ms7nB3Rar0fHuOJ+65EAdVsEEMH0W0TBXDH7l32U5ZsqoiCpT8GHUOYV
	9QC5VFfNNWkOzms9dEWJQScK7trwkNo0SOow6JCtH0Vbzpv4+fhqUH91GSWf5QG1
	k9HXnU72RB37XAC0oeXY7k9li/zO3iYCwPT8qxjrJBin2dQf6z0EXtT86SCZjrko
	K5pBet27dxvrnL/7msJwUQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e4c97sr3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 17:28:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64DHOs3H040436;
	Wed, 13 May 2026 17:28:38 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e3nec08q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 17:28:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNyDtlIyZE8U/dLTYiziLSwM08gN1cyzFidMOg28EYTmPqcKvS2hUEzffJlM5LZZc8NlT/oVRs+QFMJktx9qS0uQIVd4roblD9O84YCqJETH56VOUzVT/qlR9r5tNCylkBVDWr1hi7l7y39mz8zqacg3h5NsgTvmccgA47ptWZXAD8x6DwDUPVDOG2cpF8MTCBXFDFtokTipXx7noCdgirNHMzUCdvOWKyzq2VSa3KeKJm63I6TiMdwyH1sQmEdv1xYyfZnHsudrcFs7FQ4h2kaWC1MaPlVr8nGL35IzNYPGcDFexFHHvxWf+eXFJvPv4/gPnsEA0vCd2P8baiqJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTMA7WB4qYBBotOa3kPlx0n6lSy+iZ+WFrsiolVVPmw=;
 b=GDrKRDiEQEvrtmL98TFMa50hE1ChTwlw09cgDMV8sYjcK5+2cYQ56yU5UoCL8TGKNzWIkFImXKiWfkmSS+kGdhi9miITGu0mQ5KijewnkGEnnprvthtz/sVM3QppIXr7DO/8fAY5X8i5h5d1ooHJmIAQx9Dw7mT/xsDNN+fl/6wQ3EdSYIJD1sVCytcErWh9kT7RFq6CB32oDrAzg4hiKrKHJs/32jn30ql+PVZT0ckF4juyN7YwLJCk897ITbI3hu7nsAnTb2haV5KwDIe0C3HgW//fHKzN05oWxb+yIvullOcexPM9KWM++20q+tRhs00WpS2lqvp+bTKJ6TUU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTMA7WB4qYBBotOa3kPlx0n6lSy+iZ+WFrsiolVVPmw=;
 b=sAIb1paBKaHT+PvAb2MUNvUcCfJylXIZfXzxAniqPaYcGFEjZYxAHx4yEM0xauZytGXzQPLe3yYamhXRHzYIqOxOvhASnZB562/Ox5b8PgQ/wKw9HVqv8FWmJylP/xeAU7OGNhCGRMPUqVFjKSl98TP7cUtJf7ErCjHtfAe5zT0=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SJ2PR10MB7560.namprd10.prod.outlook.com (2603:10b6:a03:537::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 17:28:33 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 17:28:33 +0000
Message-ID: <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
Date: Wed, 13 May 2026 10:28:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
From: Dai Ngo <dai.ngo@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <agQhzg-0aeISwOGW@infradead.org>
 <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
Content-Language: en-US
In-Reply-To: <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH1PEPF00013311.namprd07.prod.outlook.com
 (2603:10b6:518:1::c) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SJ2PR10MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 9396af9c-c807-44a0-1e11-08deb1150ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|4143699003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	qLHC1Fmn59DnazTFGHmFDmcLUANtoCJOoRKXQMuWGCvFVN3LEf44nA6UpIUp3jxI4JnZ7PcPZ9qquP9UBRCUTEYObuyUWeYrjqrUVifEWBB0+6rBS0WV1kmnqFA3ve8mFxIIjQg1bO0clG7ZMZKh5BAXgjz2YB5zbBKxYlmiKs+e6VFHQ53g4kAVtxduRacYPLFjSziEIqPG8Fn3iWgMxzM3ciGV/G175xN9nACQ4beTsa5rxrfi1YWqZcyANj8uBdu3XFQDIgTLKR01eP4uP0jyjuTS+MUsyWdXPjsUvB4kxsxinXwyaFNn08ekeQpDePnkaT2EYoD3h4cwkIdShN9FWWJX5CrAS0bsoI34l09V18OKpsEl1LtQkk52z8YSzdidD0LnDdbGNgVA8oIp6KgQ968Chr3RX6EHzOWYcZ4rm+SsZ0Y/BV7ntcGAa/VX2T/0qwn1uBiEw8kElwhtdICB0SG/VRvSimdmYIS0z6QNxjAkQRAtt83mKDY5Wv+nHJfePUgpbIitaze8DRn0MdIFxmuoCAQThYZ21hWwxN3t/djbVAWLg2ezH+UUaGA+YnsO9MFT31CpjVOXZmDndq9pjG1cKzdIe5XqiE7zGZRSC5k5LllP2Fv1LKD+q+OcJzI8zLGVnEPTS2MryrE8HbFVXYhIwmtADLGQjQXkecd3sOJXIbcxkD4ay0lC5ulH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(4143699003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUZjVU9BdGFCRW52b1hBMXJSMFpvQmdkQzZwNUsyS2o4bUZWUjFWczAvWlRL?=
 =?utf-8?B?cmR0OFN0czlqMWM2TGhSck5xc05Hc2RmVGt0V01SVlRvYTMzbUIrWE93S2NK?=
 =?utf-8?B?M1hvSTg5eit3Rzhxbi9RSWlFU20xMHdQRm9zK2tsUzNGRXd5TVV4aTdzbStG?=
 =?utf-8?B?SUhEQTFGUmQrdFQ0V3o1aDdWVDlXdnRGa2VnZzVXckp3VXVFbXpRaDlqeHhL?=
 =?utf-8?B?RlplWGlLWHEzZklDRjhFOXc0TGxGNjNwNytRaVpKeUZod1p4dGlLTlMxZ1R3?=
 =?utf-8?B?MzJHT2laL3U2UkhOaHgxZmpvQk5OclYyS3BsRWtWRjRaMlNPWDc1UEdMT2pv?=
 =?utf-8?B?WURyYWwxOWloL3FucTRRUzFnZUdBQXQxektJK1Ntd0RVYXJJRlVoSUVwejY3?=
 =?utf-8?B?U1FQRjM3MzFDSFZOZjlPTlNJc2VvQkdiZlZhWHh4VkRqK2dJOTRtVU93ZVZB?=
 =?utf-8?B?NGFZWHQ1ZXJZQnZFWml1NGFkazVTMEMzZFh2Y0gxQ1kxcnEvZG1FZ3VKMkw1?=
 =?utf-8?B?ejBwU0xCdFF1VTVNUW9SMit4eXc3WktOQmE2L0xVT3F3eXo1KzNNSmpCd2VK?=
 =?utf-8?B?TDc4NSs5ckV4TkRRQUoyaC9UUkxQNkxObDFqU3N4c2VJUFBwRXJEUHdEVTFp?=
 =?utf-8?B?QXJSSE9uaWxvK3RPQnE1VitDNitGa0Qvem9xbDRudXNkMkVhdjhXaWczN3pS?=
 =?utf-8?B?UzBjSWFqcDV3L3pUSjFaVFdTbFZESml5ODBuUURtdGNIZVgwajliK29panNq?=
 =?utf-8?B?eHVMaFNIZWlURDJLRjJXa3dMTndTVHVjUTZUYVJ6ajF3azk1LzVTU0FaUWx3?=
 =?utf-8?B?alRoUnFYRjV5akZwYjRLT2ZMN1JMZmcrOEpaT3RyRFZ4N3ExYXpFTDNzaS96?=
 =?utf-8?B?MkJNWUFGcjljNk9uZXRHNnpHUVk5UHQzQ3N6WVRNMTZYNW5uTkNnT1g2dEJX?=
 =?utf-8?B?YlZXdDJIZzRrRVpzY3c1cFA2c1JscVhQN0JJWjdEdGtRcjBaWm80NGNTUnVr?=
 =?utf-8?B?ZmdySEdyRVQ3Slc1YmdxeWRNaDlCSS9tYWV0SnJBRStCY3ErWDg5aU1NT01U?=
 =?utf-8?B?ZG10akpWOU9zM2hEN3R6WThoYzFLYXY0Vk9nV1hNV3RBaE9heDF3YllHVktF?=
 =?utf-8?B?VXA4M0l5dEZxTUEwUEU5K3lNbzQ1andnVFZpTTlsRmlkZitnUnQyQVJZdGx2?=
 =?utf-8?B?ZTNWYWd3WG1Qb2o4ZCtiVnVFQXJhbkltb3F6Qk5sQm54bGIra2JzUXFiT2E0?=
 =?utf-8?B?WGg1bUkwUCtheklYc0hwK3F5YzhOVXlPeGpqOW5hM0lRQlNwbXlqMm9GVWlU?=
 =?utf-8?B?T0R2WW4zem1idFREamlnMWQwMXhQUXdMWEloNG84b1NveUJKYlNHb0JLZU1j?=
 =?utf-8?B?dzRCM3hYaDRqdkx3d1ZVNHlwdnU2MHFiNm1haVk5eWFSbklERXN3OHo3MUhL?=
 =?utf-8?B?czNQeGxyT1pha2VPQnhZOEdOdDVvcThIa3JVd09LS3dPZkNzaWJncSs5VW0r?=
 =?utf-8?B?Q1ZVVjEyN29lWWd1dzhSYjk3SnpmbmgrbVhEK2p6RXdQK0dQZzh1NEZzci9E?=
 =?utf-8?B?enZ3TGNVOXlkbXZjaFJBQWJmQ3JzWjhmb2dpQnpVVnY1SEsyOG5KZVB2dzhl?=
 =?utf-8?B?Vm5GVnpJcnVqckJ4enRKd2dIR21OSEFCM040SXdpSG1lYjdjcFBhbkFKVm1T?=
 =?utf-8?B?MkVjMGFJTGg3djJYSzM5cDM1aXFXWWlJZ0hNMWZ4RTNqNGp5UW93N01FTHcr?=
 =?utf-8?B?cXluc3BHR3UzcUlTRmhHVnZOUDJDUDZoS1p0OHd0UEw5dmlwNnE4elZVaVk2?=
 =?utf-8?B?YWplS0h5eDM5QnVHaDlJNTFwWDV0bkRvTzI0aUtsMGVlMDNkRnRJT2tHcEV6?=
 =?utf-8?B?OFp4eXJ6Wk5rQUpwLzRxOG9UL2NkN2ZON3VXaXFHMmJ5cERKa1NLMERIZ1JE?=
 =?utf-8?B?Q2wvYWtmUXNzNHlhcFZhTWI0Wkszd0FuL0h6M25yTUxxMVRLdUw4eWd2dEo2?=
 =?utf-8?B?OWxwVVR3enFmSTdudlNVT3Q1TnZ1RnA0VmJsemZ2dzZ4TFZ3cEZlMTJWbDE1?=
 =?utf-8?B?b1BTTkdpOFd1eVZTbkNhVkozNUtaTHAvS2VtaXEyMVhCR1N4ZUd6bVlveU5R?=
 =?utf-8?B?Z1RVRVlvMkJyRGg0TWpEcU5SSVdBb2Z1dHY2ZXN3Z1pZZ1dMQ3ZtMmN0VXlE?=
 =?utf-8?B?ZEhRUHlOcVlGYUdocnVXQzYxSkVBUXVQUmROWHlpSFhoWlluUlhyRnNJQTBR?=
 =?utf-8?B?TkoxZjIzdzFDUXpDSkhna0VjUmNnOThLVjRNTUdBaytENGxtemhSeGZqSkJa?=
 =?utf-8?B?WnVRRDg2MzRMNFpjRjM0clRmall6cFR1WExYUWhwNjVJS3NuWEcxQT09?=
X-Exchange-RoutingPolicyChecked:
	sufevR0CnVanVoCn2/pkEsZIelZf5zNbufAkH56tCHbbGSUCuSQUDIYLbX7tBqyhva9EFlYoPazSEpOU6NFCLff9G4YEUg/plxbeCvMzj2wBFT9ktrcZQkzLNwMD+aFzrDKSnMnjdnXuDtRsb/XAAxLfPtRCAL+5qo7GXLl6N3yYErjFFnI+ByPATazdbQKu54JgN64VSUBw1iehLECVuTeuXvaBuJENM8cZpOemduPHnrHc2FdouBKcALt+Y1DSX1RPouS8wrV9Kv8Y7QhxzjpTDYayYoI5MlGOs1Okfn9lyB74Ii/9JiCx8AsIfrDz7dxjUEDhGkXz3aGxbP0QiQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jJPwkyxPl4WJ2chy2wDyHM/W/z5ckjqT7P6gaY46i6vWjo5pXGqwGEY91m5EIpi3T5sF51XJkAe4rZZDJkeMkJh3ccBZrY+FUFJyhQSlZ6KKnU/u0HZ7iRIIRkrw72f+sc/Z+5SnnXSnE4FnPjlL61q0ozm4LXH44LaYqpfa5b6g/1uNtDDEkCx/41j+Lfyn98VYZnO1NopCe/z4bNyxgZUhbU3VPFsgf6cFPBAkPZuYM/a1MIkYoCFYE+1mqnHeaZsaZHAB+GH6bw9gDopJ6Evu1jFlycoLGbbEv80TfV/sSQZDtJ15iOb4SvB3syr0BtmlR04gLbk96ksFgR8zdsKHrLPfZd2kP3SryWRY1k8GVh5VC4eDrUOxoF2w9y60PadZeKfnKGLgO/NNr6AP9biBrzbnIXKwZY3GZPB0ndvUkbzuf8JFSqqMQIRsmb0zwycDNlOc5SsSe5an5AnzrErfJEmeG4pSdM3EoSrGP2v+1uZawyIsGIkkudC5rPKETw/+KsavuzUQKGB7D+4besjxLruJ2Qijh912Mv9hzbchXKbP4rw0dysEt56qUArOP9+J/DW7pwDOpG2XpjBZ45xa4NL+rsuXx/zoBoAq63w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9396af9c-c807-44a0-1e11-08deb1150ec6
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 17:28:33.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJbRj8JYBoLtoZsxAU4jVUo5edne3JM0dp7gVDeuQI5uB/mzWRy3va5i5PLjbGCAq6iK+C+UG4+RJvXsPYBwyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605130175
X-Proofpoint-GUID: o5-ZBcR_idUkZot2t4Qmzc074DoOvCDY
X-Proofpoint-ORIG-GUID: o5-ZBcR_idUkZot2t4Qmzc074DoOvCDY
X-Authority-Analysis: v=2.4 cv=Yt0/gYYX c=1 sm=1 tr=0 ts=6a04b4c6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8
 a=VsGsKowH_CzkNRV75sQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3NSBTYWx0ZWRfX9pVwcNghJAIo
 Bc+LVzPhhsbFe6LbUVflWHlz+w+PeMHXqAb7WzIjlyPosqIEbNheHR5riAeEmN/dqAeBHj66MvB
 tQ0gvYX5ebLJzfBDZdKYRCwvXs5wi/5N6ka2r9nUzH8bPxHcRHwit+RHiBl7FuxLHVEoFVt824y
 /EM+pmxQUYZUr3dX5c01Xl7y+hGySoq9OKkiQf8f2lKS/iw6PhxuJFISOhG8TlyF8AowbO3r7ae
 YXngopxBaTh/3tshRpZApvwJ6lybg45QZ8QuulaHGSfyNWD1wzpOy2gSaOafrT8Gdi6FLGzTQR4
 1qcY+JpMU1v6IRxGaLttqOq6ZsHDMIHSdHQOqeH7pEXiXOnO/pePbGyyhuJYamCA8fLSqc2GSq5
 aHyAdU0WTvU0Hj3LE16H76bi7//0ZyKdlCSuFuaeNKCsTgvIOr4q3X7hyIZwsA3hwyA6LHFno0z
 J+JFCFi1tvqhAA+0w4w==
X-Rspamd-Queue-Id: ADCB15384AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21606-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi Christoph,

On 5/13/26 8:50 AM, Dai Ngo wrote:
>
> On 5/13/26 12:01 AM, Christoph Hellwig wrote:
>> On Tue, May 12, 2026 at 10:21:53AM -0700, Dai Ngo wrote:
>>> A single LAYOUTGET request from the client can cause the server to
>>> issue multiple calls to xfs_fs_map_blocks() for different offsets
>>> within the same extent. Because the use of XFS_BMAPI_ENTIRE flag,
>>> these calls can produce overlapping mappings.
>>>
>>> As a result, the LAYOUTGET reply sent to the NFS client may contain
>>> overlapping extents. This creates ambiguity in extent selection for a
>>> given file range, which can lead to incorrect device selection,
>>> inconsistent handling of datastate, and ultimately data corruption or
>>> protocol violations on the client side.
>> Please also add a check to the client that catches this and doesn't
>> use the layout that has extents outside the requested range. And maybe
>> warn about it as well.
>
> The returned extents cover exactly the range requested in the LAYOUTGET
> op. However these extents are overlapping. For example, here is the
> on-the-wire capture of the LAYOUTGET operation and reply showing the
> overlapping extents:
>
>     Network File System, Ops(3): SEQUENCE, PUTFH, LAYOUTGET
>         [Program Version: 4]
>         [V4 Procedure: COMPOUND (1)]
>         Tag: <EMPTY>
>         minorversion: 2
>         Operations (count: 3): SEQUENCE, PUTFH, LAYOUTGET
>             Opcode: SEQUENCE (53)
>             Opcode: PUTFH (22)
>             Opcode: LAYOUTGET (50)
>                 layout available?: No
>                 layout type: LAYOUT4_SCSI (5)
>                 IO mode: IOMODE_RW (2)
>                 offset: 122880
>                 length: 65536
>                 min length: 4096
>                 StateID
>                 maxcount: 4096
>         [Main Opcode: LAYOUTGET (50)]
>         Network File System, Ops(3): SEQUENCE PUTFH LAYOUTGET
>         [Program Version: 4]
>         [V4 Procedure: COMPOUND (1)]
>         Status: NFS4_OK (0)
>         Tag: <EMPTY>
>         Operations (count: 3)
>             Opcode: SEQUENCE (53)
>             Opcode: PUTFH (22)
>             Opcode: LAYOUTGET (50)
>                 Status: NFS4_OK (0)
>                 return on close?: Yes
>                 StateID
>                 Layout Segment (count: 1)
>                     offset: 122880
>                     length: 77824
>                     IO mode: IOMODE_RW (2)
>                     layout type: LAYOUT4_SCSI (5)
>                     SCSI Extents (count: 2)
>                         extent 0
>                             device ID: 01000000000000000000000000000000
>                             file offset: 122880
>                             length: 53248
>                             volume offset: 339460096
>                             extent state: INVALID_DATA (2)
>                         extent 1
>                             device ID: 01000000000000000000000000000000
>                             file offset: 122880
>                             length: 77824
>                             volume offset: 339460096
>                             extent state: INVALID_DATA (2)
>         [Main Opcode: LAYOUTGET (50)]

After reviewing ext_tree_insert(), with assist from Codex, I think this
function handles overlapping extents properly. The only issue I see in
ext_tree_insert() is the accuracy of the return error code, EINVAL instead
of ENOMEM, when kmemdup() fails.

Since ext_tree_insert seems to handle overlapping extents fine, do you
think it's worth it to fix xfs_fs_map_blocks() to avoid returning overlap
extents?

IMHO, I think we still should fix xfs_fs_map_blocks() to avoid any overhead
and complication in ext_tree_insert having to handle overlapping extents.

-Dai

>
> -Dai
>
>>
>>> Also drop the check for (!error) since it was checked after call to
>>> xfs_bmapi_read().
>>>
>>> Fixes: cc6c40e09d7b1 ("NFSD/blocklayout: Support multiple extents 
>>> per LAYOUTGET").
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>   fs/xfs/xfs_pnfs.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> - This patch is based on top of the patch:
>>>    xfs: fix use of uninitialized imap in xfs_fs_map_blocks error path
>> The error changes should go into that patch, so please resend it with
>> that fixes.  Maybe as a series together with this patch to keep them
>> together.
>>
>>> @@ -172,6 +172,7 @@ xfs_fs_map_blocks(
>>>       offset_fsb = XFS_B_TO_FSBT(mp, offset);
>>>         lock_flags = xfs_ilock_data_map_shared(ip);
>>> +    bmapi_flags = 0;    /* return map for requested range only */
>> Just remove the variable and hard code the 0 in the xfs_bmapi_read call.
>>
>

