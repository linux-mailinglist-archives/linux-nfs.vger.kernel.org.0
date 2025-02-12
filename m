Return-Path: <linux-nfs+bounces-10065-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BB3A3317E
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 22:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B353A8033
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5AB1FF5EB;
	Wed, 12 Feb 2025 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FQJlFqYv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R4x3t8iS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3273B1FBC81
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739395979; cv=fail; b=lhYGu0aqnsFd7DOyw6zek8EmQWddM7++DEnhsqSrpdykibhDRh0wJjW4rqByiUDsgPfAvjIabHiD4VrzfyHW6D6Bvmxo122iXlfHET7UNRdD55qviJXMSAKAXODwVRRD6ZsEmXbwwfMAEbEwjtTxocwT3QoXVEjuj1MjqmPLw7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739395979; c=relaxed/simple;
	bh=GaKaVjjwMdg459RzHQuTKNHAluQNYYCP8NDfoB+qM+g=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tuUgtVRPXSRsxWogyIHXqxIroKMfWa5tgoEVKCwu3eY8o2O0C1zr2ujI4MPozukEGBMCEsHwY9x78mkUq9KbgeZSfOC2f0oaH9T4XY4zIOW/Ln47hLKARLAzkFUJ89OZAx2H0m35jDVBBpSn4Z8tsZbrpmcmNwukoWXj8v1wcYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FQJlFqYv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R4x3t8iS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CEtl3S008993;
	Wed, 12 Feb 2025 21:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4mvkymS7dEk2GDhrPDr3U41FXzVcbjNQS/HlTqD1BFA=; b=
	FQJlFqYvLhzAxdBkZP36MBGuvfE1Z3fWWnXjFCczt48QhAYX9/UftEGnuTNdK2JP
	nCwJ0m+xSIBkxjAeeHYynzEQgo1z/zkE+JGf0LaANppBOBtULm3p6aLO3WsTSCnJ
	Ns6x/wf0eMy95OdEgSF0chappr8NMVLQ9aaec4RbYTB+M/WbJD2lopXQ9xF873dx
	DKb2qPz2nOowFiANnDDdhoN8B6DL1d72MlR5vpZh7ogjbmrQAC65pkTcIvObjgii
	Hpcl+1aU66QDjs872u2mCxlzEOH+t+i/DhZkeuVkJNM7IVtyiLqqrqkTo7+c7ngZ
	Sn0k8IYtmMZ+Zl4QP/7nzQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qagbeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 21:32:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51CJttVp012700;
	Wed, 12 Feb 2025 21:32:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqav080-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 21:32:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rD6n9ozy3vNoH9J3hv2Jr7QlSJscn8B+q6XfViP64q8hf3XSw7aZTOk36zUyiFM59kFyk88llwbdSAv9PK5X3u84Ftw4YQAnOcdDt5Hh697Amy8F3qWxhB5xtUvi1SDoO1iJJ/NrdbrvnW9w/6o3bEx25+bzsNhS0FD6MNijvDoaEa4YlKdUuy5n/T5H17cbdibjmMnJ6Ofxd87awKZX6Fji4PiFRgdR9DVdSuGUdM0qRw+oBUbup2vn1rR5eLAsmTmYWg3suHqv5wU+ZZUlNd8K8cX/Wz7wQTRqFCoZ8NWRy/Susp4f6pfBlAUx+4g9MLrBSf7KtY1P3fesIUSIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mvkymS7dEk2GDhrPDr3U41FXzVcbjNQS/HlTqD1BFA=;
 b=hhR1Cdvw/RaxPE07sHzOdEfH6segse4WzwaHko4z3IcB22GNAURDPKdzhpyoVAwg4dvllP9H2QXchU6KiC8XjrT8C6bv08K/ObwrOYMa8Uchh6CSNHA0OSiuTSXZKgDlaLu2qdqkZKKZGtF+wdqDeKL4s5v1y60I6RjCZgq5HrP7Wu8VRHosuSs3Sh6Qcz7vB89z3/k6+A8/d7gFwReciAXvuboQZG+X7DuWVWq4wIYQw/NzIPkieWPDQ1CbzeGOD2wutUQqYMYO5QH22spFicakbN9IM7l+BIxOUaDEqAAWGK3u1bPDSxiUqmitTFbXVb0HyKJN7zs4W5C6JMLivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mvkymS7dEk2GDhrPDr3U41FXzVcbjNQS/HlTqD1BFA=;
 b=R4x3t8iS4y/GXVh2ivK+qktG4W/w/si29YsUheTBImzJ3B7y9xtoDnzGgxeb36nT9jhGSKNPZZsXSbr/svY8m1IDoOIDOzl1d+pwJ1TeS+4YKqQsCt6s1xteunN0Vg9bI7IkGIMc8N4ewN+hB/Cu+GP6/1wRA/0C7xwuztTm5D0=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by DS0PR10MB6750.namprd10.prod.outlook.com (2603:10b6:8:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 21:32:45 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%5]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 21:32:45 +0000
Message-ID: <35de0448-befe-4bc8-b6d2-7063e7a2d08d@oracle.com>
Date: Wed, 12 Feb 2025 21:32:42 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, Michael Moese <mmoese@suse.com>
Subject: Re: [PATCH 1/1] Allow to fallback to xdrlib if xdrlib3 not available
To: Petr Vorel <pvorel@suse.cz>
References: <20250212132346.2043091-1-pvorel@suse.cz>
 <0b73e27f-9b1f-4840-af10-b687c90759ad@oracle.com>
 <20250212210135.GA2141194@pevik>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20250212210135.GA2141194@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0164.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::7) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|DS0PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf21185-f655-47da-8c32-08dd4bacc9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnV0TktZZmNaRDFkVk16dEhhSDhtb2pCVVhqdjB5UExiY0tCcGFOTnpHWTk3?=
 =?utf-8?B?amdZVVgyWEFWZ1lsQUlRUzFsUWdmdkpMcEFsdGZnKzkxOUxPZjVkOHExVFZE?=
 =?utf-8?B?eklDWDNFTDNkNTJwR3JlMUNic0JPd1R1VGtMZ3kxb3pOR2ErUkJkVUNrOUZO?=
 =?utf-8?B?LzZRTlZUclJ1WkRPNnVCcVZhNnpEcUNKRFJmc3ByN2lBY2RKeXl5RFJRK2lC?=
 =?utf-8?B?N3MrcEpZeWVaTml5c1dEVjhDSS8zVldCbTdtamc2aUdDYkw4QlBUbGVUU2pp?=
 =?utf-8?B?ZUpDTzFtdC9UM1F4c1hzemNmeEoyRE5kSHlodHdLQjVaMWlWN0R1UStBM3dw?=
 =?utf-8?B?TjA2Q1dEUVp5QkFtWnJNY0VKVnY1Tys1OHBHeEpjbS9uZnluZ21HMWQ2QW01?=
 =?utf-8?B?QXA3NU0wbG9QQ3ppeVJqTDNwcmZwS2tPTk9CZUhHV1BxRVpCM1lTbmJYT1JJ?=
 =?utf-8?B?aXlYc0szWm5CWU0vaVRYRjRGcW9OU3RyYkZqK1dqUE1GUVBldTNJN3dUTElu?=
 =?utf-8?B?T3ptdU1naEZHUlFkbENpR2llMmQ4MWtWWWJFS3JXWVJKU2JFbU1ZRlhvSGJT?=
 =?utf-8?B?aEhMa0krd3B4Z00vbERMMUwvQnBCMUQ4cjVxSktyUGljYXFXSjJQK051ekRX?=
 =?utf-8?B?VE5YL2svQS9sN25oUlZFZHNqNDNnZ05qRmlwclcrRWNtUGF0SnJqZ3ZSdm4v?=
 =?utf-8?B?dWRZUmx0VXczNXhoNW5nQXlPaE9laXlyMVhwc21RL05Ya1dHQ1NUeHVvTzBV?=
 =?utf-8?B?dFphQi9WUGt6elhRRTJjR2NUOFJac3BGRjhpczQySk9IM0pla2JQYWNOaS9Z?=
 =?utf-8?B?djdjeG5VaWxQdTA1a2FVd2pDdmVkdCtkVEZNcmYrVlhTMk1xZEJGNEdIR055?=
 =?utf-8?B?My9Sb0VNeDdtb1cxcjhJS3kyZzNkQXNiUDJwMmxuTVFKWUJyeWpEdmRtOU5o?=
 =?utf-8?B?aWNvQ3phR0dmZkMwNEdiSi80UUNMemM3ZmRuazQvTEtZR25sME9VSEN6UnlJ?=
 =?utf-8?B?ZmZWMVBZWDgxRkZSa3ExU01ScURFbGdURUNhL3M1cnI2UU1EbDgrTmFFVG9Z?=
 =?utf-8?B?cndReGV3MEQyeGhZUXlyaGZaYU9WZjQrT2ZmeDJBa0R5Ty9UcDdVbzRCWnpC?=
 =?utf-8?B?dE83cUVrcGl5RWZDRktnM3MyM052MFJtR2NRcjhNZ0lUcWM5OWlhaFRWTTdl?=
 =?utf-8?B?a0ZVUWEvenJTcmJzVmlaSW5kQVM3QUJEV3J4My9icWxuY1BwSHgvS3hzUFpq?=
 =?utf-8?B?a0VNZmhNbmdUQlloRkQ4MjBUYmcxcUZmalZDaHE5aXhTcTJlUkpsNmVTeEV2?=
 =?utf-8?B?WGs3c1dkKzlhUHFQbExmc2JPczRXc1VvTFF4d1E1Zm43bjAvM0xWaUlyd1E4?=
 =?utf-8?B?OFAxTlBMeWhGUG9DTzBDbzhKNG43ZTg2clJjMndKL2Jlc2xGN0tIZ0x2cXE0?=
 =?utf-8?B?aWk2enRCbi9TT04yOCtORExNTGZCZ2RzT3ErcHJ3M01jbmt6NER0Si9HdHU5?=
 =?utf-8?B?Rm5idkFXQmJFVXBscmhHTW9idWNxeDBQcnMzMDFKRnZqUFUrN0IrU1dCZFo1?=
 =?utf-8?B?TFNPcFRnOTVUSDI0N0ZDM2dzN05pLzVHS0FMY3pHd2tjajNMRHVnSFpCK01r?=
 =?utf-8?B?SDRHc1plMElhdXc4UmpHVTc4Nlo2NER3MklDQ2F6WjROSDVlcWlZN1VQLzE2?=
 =?utf-8?B?MG8xR1dKdEN5UVhGclpaejQvZjJ4LzdsQWM2V3I1alZ4UzhZV1lsUjVQSDQ5?=
 =?utf-8?B?Q29PZUVhcjBzL1RyUThxQUxHNTBqWFFwSWFlYmtEajdJTHlqSVhLYlVKN2lw?=
 =?utf-8?B?NDlPUzZ5SmRKSWNrY3daSXo0bmNLWElyTDFydzBCNW8wY2pYVENpZXh3dzF3?=
 =?utf-8?Q?n1d9j+P+xefb1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVVQR0hGVWpBajdVeXg3SjJjUVNGcDBqd0IrenZvVkNuN2FmZ0xwVXo3U1Rs?=
 =?utf-8?B?NERWaXZLcDVRb3JJVHVhNkg3T3J1Mm9JbFR1blJqWlNRR2w3WnBMeFNYckQ2?=
 =?utf-8?B?TEdjaFEwYTVuc2hXN2dHdTN0MTFvbmExWlVFdEhXVHdleko3VHNNcEhqeHZi?=
 =?utf-8?B?bzNucFFidWtGbHVxMlRIbHdvRHpVb3RqUVl5Wm1HU1dEU0d5bmE4WndhRCtJ?=
 =?utf-8?B?eDRGUW15ZW9zQWxpejU0Z0p3eE1hYXlGdHkwRnFsMlNaZllnM1g4c1AzOVE3?=
 =?utf-8?B?YitSZDNDbUJBNHpxYm43ZVVYK01tMHpjNHI4TTZ4dFo0MFBUUTRKaTB1a0p3?=
 =?utf-8?B?UC92L0FOamhqVGtuTDQ2Y1hWM2swWXdEZkVIcUZkRm1PMGhNNWxCbmxmUTlw?=
 =?utf-8?B?L0xvLzNnbXMxbjZMY2xFQklsNllEVkRiTmVqZFd5THY1RFh4RWFBTVhWSWdq?=
 =?utf-8?B?Unp3ZDkvOXlVc0R2dzQ4L1ZnR0hWekZYL3R5b0xkVVFHTm9BaUYvWjhaYWhj?=
 =?utf-8?B?UysyK1c3L0lFZUIxenhhWk5DeWRGdnRVQ1BQalh1a3JTQlUvQmVkb3BNTEo2?=
 =?utf-8?B?WlZUQmhEakg5OHI2N0oySXZkcU5NRnp2RFNlbGkxWGRvUlRsZmwrWVUwbnFO?=
 =?utf-8?B?b3JKWm5YS0hCM3VRSWJxY2Q0aGhaNjgxaVhTUjZVZTdHZ0tnRnBHeEc0Q3FZ?=
 =?utf-8?B?Umx3eVZSY3FEN2V3bS93OXV5NmE4TWw0QnR4dklqSmpHSmF3M3ZSUmd2aU1r?=
 =?utf-8?B?aGMrNzFtODc3WHRqa0tqd3NDNGpNZ2MyK3k5RnZXTHdhUXBhTHQ4L2IyMTV5?=
 =?utf-8?B?V3g0L2s3SlBGczRKOUV3UHJ6dzk3QU1vbU1wbkFUT054dXc4K0ZQeHFrbDBI?=
 =?utf-8?B?RnM1RjNLTUQwOGNvZDZQdlJ1V0NYRmV4a2t1UVBDWjNMeFBrY3ZUWVpRVGIy?=
 =?utf-8?B?eVZianI4RGJsaXpIbDcrOXNFakR3eFQ2a3JRTTZ6RHE0dzRzREpWMW02R3hk?=
 =?utf-8?B?QXJIRE85aEVLemc1V2djblZWM2tRcXlNVFZsRTRsTXhCK1BRb2czb0Y4UVdB?=
 =?utf-8?B?dnVHNUphTFdSNmdMWmZ1SEk5MGdqcjN4ODhiRHNGU2hUMFJmVWkyZE5FOTcz?=
 =?utf-8?B?ZWNVS0ZjdjI2Zk1mN3ZCMHJ5cE1Cem9pTUNXb3ZyNW0rRE1tVnJkcGJvWDJI?=
 =?utf-8?B?QkVBMzhPNWxjbHBHUm9yUllFdFlsd1hON1VTZFFUNjdIaVhQWUZNTEZ1eDlS?=
 =?utf-8?B?U0trUFlEK1pDRytObzBNLy84UW5lRWlTQ3AwckNWRUhQR1NieVFFQWxqTzk1?=
 =?utf-8?B?ZkVheVR4Y1ExRzR2Qk1VZDJySnVJK3dqUjZ4Z1JvQU1oT2ZvTXZQQ0RrWDRu?=
 =?utf-8?B?R0VneDFGNWtwU1RBRHVQVVJaeFNHUTN5Y3V0bUVxbW5NMFRsVzFmeFlERXpL?=
 =?utf-8?B?Z1dxY3VoV1gzaVdsdkRvYmM2QXhJVjYwdk4wQlY4UnlidllrUWRESUNUSE1t?=
 =?utf-8?B?Y3EzZy9Kd2tpZHY1RUk1a2JxUzh0dzRIbUlqOW1zcEJjaXM3TjFrQXJsclNJ?=
 =?utf-8?B?R0UyWjhDOWFwaWMzR0pFbGtOK3ZHKzM5QnZrUHozTXkrNVFoekdSWitVT0xq?=
 =?utf-8?B?eXB6cG1UaXNsTHRIMjJRYVVtZTU2Q0dSczRZYTVBOGFVcmFEa0xmMVIxUDNh?=
 =?utf-8?B?RVZhVUQ3VzdETzdGcVI5M1BEanRoVkZZMWdQSktyVTZWY21UMllCOUhTelow?=
 =?utf-8?B?Z3pGc1RWWEZOR3A0ZUlIZDVRQ1c1RXJSN1g4WWd2bVA0c0ZIRkc5QlFBMHlX?=
 =?utf-8?B?czN3UUJhWjJScW1ZcDViWlhaTkZGWXJqQUc0a0xkMWhqSDhWYlVqOHpIQ0xa?=
 =?utf-8?B?dWZaTXRZNTRFTlMvNlJOZXJ2aEMrOW1VNlRSdno4RXpZSTh6SGpsZlA5QWNw?=
 =?utf-8?B?OStJMVhvN2RTTjNpV01mK0ViWXpaR2dZUjg5UUlObDc0Q0dnV0tFYWtERjlh?=
 =?utf-8?B?RyszM09zYnYwUVhpeVhjb0hwRVZoOVV5RG1oWFpYaXR3V0V6R2VvREh4cVNw?=
 =?utf-8?B?KzM4b3VzNVFGWUozU29jSUNnaThyRWJ2ZWphMkNtN05pQzFKSjhuMi9KRFlN?=
 =?utf-8?B?VTRrWGRpUHJBZUJNRmhBb0ZPMHNlT3pScHhucDVMdWgxQWhWZElBQ1poa0Ja?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vM4tcjrqfr6R5LPNfiLC6DMXRvIcCpUkElfx0aRSLmojbvFQ2lZRvutIEIjeUL5D8s66u0z1FYifIYtJJAq+0FqrQZrB7HqY4TBbsmr23O9p5Yj+JvzdLGhSdCG83SsekHQmVkSI9hka4yE1Wc0ncrbs16nGs7O92F5+O4p/ZgrKNwsd8jO1CkzuNDnTOZAxAbqm+vN5LGLu37eNqSdPAReBdVinkJTVelPPpKNYkNDBxBnEJq48ilkfLOugFcOk9+vTeUtP7L5cog+vA/oTni8WOwNfsmIZ4NuiUnHAbv1Pj2pMZqoQia+ihmhGLn4OH5N2Iam6gX8AnSv3kOs3r28on9g0yLNsU9RRduohsgfDuUfuCp9lyvJhXD3nstme7oM7BH9VWvDgU4HyYX8P/hvCRNnis3EtkhhWTJnVyfRo4h4NvZ7kLo/H5t7NtVmCCHSU4wuxktQXQoqhQwgBa5heIvmJNrNQKHLFRowym4jFEuVTu8rPa1d5xLdXq8fqk12z4JqTNLqRDJOAosT+enpfSbEjch1VB19Q7LHBTkSFqp4Bv/XV7bFEqoooRmOCuiq0E/mRimUHrW31CC8vEpTgE8wIamMHgT7jH0cJrUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf21185-f655-47da-8c32-08dd4bacc9d3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 21:32:45.1342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyfXvrdlZlPuUjuISZ9forqAzP6aMcglrzLifXfMjAjyr8ChrB3UoQrSBeeIoXua1qwkU0oQ4Yh+q5B5GSdVOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120152
X-Proofpoint-GUID: czkGLWM34o0oWIJ2PcYOCrVXVz0KwjUx
X-Proofpoint-ORIG-GUID: czkGLWM34o0oWIJ2PcYOCrVXVz0KwjUx

On 12/02/2025 9:01 pm, Petr Vorel wrote:
>> On 12/02/2025 1:23 pm, Petr Vorel wrote:
>>> On certain environments it might be difficult to install xdrlib3 via pip
>>> (e.g. python 3.11, which is a default on current Tumbleweed).
> 
>>> Fixes: dfb0b07 ("Move to xdrlib3")
>>> Suggested-by: Michael Moese <mmoese@suse.com>
>>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>>> ---
>>> Hi,
> 
>>> I admit it would be safer to check if python is really < 3.13.
> 
>>> Kind regards,
>>> Petr
> 
>>>    README                                | 2 ++
>>>    nfs4.0/lib/rpc/rpc.py                 | 6 +++++-
>>>    nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py | 7 ++++++-
>>>    nfs4.0/nfs4lib.py                     | 6 +++++-
>>>    nfs4.0/nfs4server.py                  | 6 +++++-
>>>    rpc/security.py                       | 6 +++++-
>>>    xdr/xdrgen.py                         | 9 +++++++--
>>>    7 files changed, 35 insertions(+), 7 deletions(-)
> 
>>> diff --git a/README b/README
>>> index 8c3ac27..d5214b4 100644
>>> --- a/README
>>> +++ b/README
>>> @@ -19,6 +19,8 @@ python3-standard-xdrlib) or you may install it via pip:
>>>    	pip install xdrlib3
>>> +If xdrlib3 is not available fallback to old xdrlib (useful for python < 3.13).
> 
>> It sounds a little like the above is an instruction for the user; if you
>> don't mind I'll fix this up, adding "the code will fallback…", just to make
>> it obvious?
> 
> Yes, please, fix it.
> 
>> Thanks for the fix Petr, I'll get this in today.
> 
> Thanks a lot for accepting this. FYI we test with pynfs also various SLES kernels
> (including very old ones), which obviously have older python3. Probably on all
> would xdrlib3 installation via pip+virtualenv worked, but safest way is to avoid
> it and use python stock xdrlib.

Applied.

thanks again, Petr.

cheers,
c.

> 
> Kind regards,
> Petr
> 
>> cheers,
>> c.
> 
> 
> 
>>> +
>>>    You can prepare both versions for use with
>>>    	./setup.py build
>>> diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
>>> index 4751790..7a80241 100644
>>> --- a/nfs4.0/lib/rpc/rpc.py
>>> +++ b/nfs4.0/lib/rpc/rpc.py
>>> @@ -9,12 +9,16 @@
>>>    from __future__ import absolute_import
>>>    import struct
>>> -import xdrlib3 as xdrlib
>>>    import socket
>>>    import select
>>>    import threading
>>>    import errno
>>> +try:
>>> +    import xdrlib3 as xdrlib
>>> +except:
>>> +    import xdrlib
>>> +
>>>    from rpc.rpc_const import *
>>>    from rpc.rpc_type import *
>>>    import rpc.rpc_pack as rpc_pack
>>> diff --git a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
>>> index 2581a1e..41c6d54 100644
>>> --- a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
>>> +++ b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
>>> @@ -1,7 +1,12 @@
>>>    from .base import SecFlavor, SecError
>>>    from rpc.rpc_const import AUTH_SYS
>>>    from rpc.rpc_type import opaque_auth
>>> -from xdrlib3 import Packer, Error
>>> +import struct
>>> +
>>> +try:
>>> +    from xdrlib3 import Packer, Error
>>> +except:
>>> +    from xdrlib import Packer, Error
>>>    class SecAuthSys(SecFlavor):
>>>        # XXX need better defaults
>>> diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
>>> index 2337d8c..92b3c11 100644
>>> --- a/nfs4.0/nfs4lib.py
>>> +++ b/nfs4.0/nfs4lib.py
>>> @@ -41,9 +41,13 @@ import xdrdef.nfs4_const as nfs4_const
>>>    from  xdrdef.nfs4_const import *
>>>    import xdrdef.nfs4_type as nfs4_type
>>>    from xdrdef.nfs4_type import *
>>> -from xdrlib3 import Error as XDRError
>>>    import xdrdef.nfs4_pack as nfs4_pack
>>> +try:
>>> +    from xdrlib3 import Error as XDRError
>>> +except:
>>> +    from xdrlib import Error as XDRError
>>> +
>>>    import nfs_ops
>>>    op4 = nfs_ops.NFS4ops()
>>> diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
>>> index 10bf28e..e26cecd 100755
>>> --- a/nfs4.0/nfs4server.py
>>> +++ b/nfs4.0/nfs4server.py
>>> @@ -34,7 +34,11 @@ import time, StringIO, random, traceback, codecs
>>>    import StringIO
>>>    import nfs4state
>>>    from nfs4state import NFS4Error, printverf
>>> -from xdrlib3 import Error as XDRError
>>> +
>>> +try:
>>> +    from xdrlib3 import Error as XDRError
>>> +except:
>>> +    from xdrlib import Error as XDRError
>>>    unacceptable_names = [ "", ".", ".." ]
>>>    unacceptable_characters = [ "/", "~", "#", ]
>>> diff --git a/rpc/security.py b/rpc/security.py
>>> index 789280c..79e746b 100644
>>> --- a/rpc/security.py
>>> +++ b/rpc/security.py
>>> @@ -3,7 +3,6 @@ from .rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GSS, SUCCESS, CALL, \
>>>    from .rpc_type import opaque_auth, authsys_parms
>>>    from .rpc_pack import RPCPacker, RPCUnpacker
>>>    from .gss_pack import GSSPacker, GSSUnpacker
>>> -from xdrlib3 import Packer, Unpacker
>>>    from . import rpclib
>>>    from .gss_const import *
>>>    from . import gss_type
>>> @@ -17,6 +16,11 @@ except ImportError:
>>>    import threading
>>>    import logging
>>> +try:
>>> +    from xdrlib3 import Packer, Unpacker
>>> +except:
>>> +    from xdrlib import Packer, Unpacker
>>> +
>>>    log_gss = logging.getLogger("rpc.sec.gss")
>>>    log_gss.setLevel(logging.INFO)
>>> diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
>>> index f802ba8..970ae9d 100755
>>> --- a/xdr/xdrgen.py
>>> +++ b/xdr/xdrgen.py
>>> @@ -1357,8 +1357,13 @@ pack_header = """\
>>>    import sys,os
>>>    from . import %s as const
>>>    from . import %s as types
>>> -import xdrlib3 as xdrlib
>>> -from xdrlib3 import Error as XDRError
>>> +
>>> +try:
>>> +    import xdrlib3 as xdrlib
>>> +    from xdrlib3 import Error as XDRError
>>> +except:
>>> +    import xdrlib as xdrlib
>>> +    from xdrlib import Error as XDRError
>>>    class nullclass(object):
>>>        pass
> 
> 



