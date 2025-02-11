Return-Path: <linux-nfs+bounces-10040-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8ADA30D84
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 15:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF28D18881EE
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 14:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5E6206F02;
	Tue, 11 Feb 2025 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CVYe7eb+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="itHVLw0U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F191E1A32
	for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739282446; cv=fail; b=C5eRIxbVwBYW/VN7Ywd5GgDfxnGSrMKH0DLo+3kXGelOo3EII37mY1eybQYEUgp/J38/abTIItjgP64d6BpMy82EaGmkkKbwNCzmmJy/HfXwRioNAdr+9VyEstL1XrFdfD8IzilRFfNQ1L8J30yDfvT4g0g6D8RCN2RtLeUSYrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739282446; c=relaxed/simple;
	bh=Eg0zfJD/q9zYGZHc7d9c5S8P4U7Lj6tMYIduvt6Q5AE=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GA+zN7MWGKkDA54JNbAtlGhPkXG2Uk3I47i0Ac8ZuUMiPQ3HL4ClLxLmM4GBGAeGExGFncNxcKh8egHF70bxR/HTkDqICTR3ICQkpQlxBMknvmjgwa7Q2Lggh6tAQFCThUKdGQun1N/HZk2rwxW8AFIcWO4mHNv7tEp1j0ODRHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CVYe7eb+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=itHVLw0U; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BDtSHX014749;
	Tue, 11 Feb 2025 14:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=x/RhSdIpanza6s0EJBUfHwq1ghvR3cCWvxKYacYM0b4=; b=
	CVYe7eb+iMiLNhBOyw0sjnIwMsQpoKE6uQQeI3A66NkH410Hs2QRKRzKbz9ClPzr
	gUykfXB3WJklHrVvrOd8apbt2Ec8z+NxqTBnlbpQV/YqsfGhEXNfcI0TJw4lp5od
	XaioyT7K3gx+a0p4O06saSBOI9Z5fqFWZp/4IvnDiaDvxIcx1df4wCjAviJEb5n7
	2SWC1q6H4wofonkYkhnjYMx19/8couhKM619lKNNM4S2r9Gao0oq/6Ne5COI8et8
	oy/Ab/QH8eRlYLoPWk2qq5242JDy2Fg6Hr0PLSqQmrQkKzXf64XLiJXURjG+rNmb
	a2NWRNBOcqCauM3BtvIGPQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qyn7cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 14:00:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51BD2AK1002331;
	Tue, 11 Feb 2025 14:00:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqfagbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 14:00:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSpt2MuZPPy3Josf1GjdTj0bUZeeVpxBJtLuYJaq4FDBoyqN95ZH9jqeTBotqFTFc6V28nPi7mL3z1gSyN2AkQy1dSeTJKtTEW9PZlC9sUoQv8XOxWye+5I7W8xhdUkvE1e5LaX8Pay8vENlDdLJkh1BBxD8GDXp9enwiWXGa/+l8MMjk7hRnKXuvUQAk6lqbqBrdJ+bAfty2fNhz/KY9x4O9vnr7i62Ga6peFjcwxinmWAze4Rli69hNo6lWbGjsEWNkZpXTuFdih3zr+SkeWVCxE6YfgIzlzKSDxW+OAr1sm04f2SdTuTSLT9FFileLbIDq3PCa6uduTn0dE7W/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/RhSdIpanza6s0EJBUfHwq1ghvR3cCWvxKYacYM0b4=;
 b=Hb9+SeOYpIVMJHoEekpeTBde7YckD2iyOE6ei25awAXG9TIGicCCQUJr9yGqims6wVB4uISTm8F74Ee5RZDhgvFjGY83csPJe8QBPmLAs82hbmlbfl1W4heUDA4J9wGsCacjzPAPyMHwoV0UssYKSvi2a8yoYvaBvR/iaMC4llWVEyI2Oxl7QXgzt9V61WcXNhuOnaZB5K9V6YpcqGSmuO5/g/CBAndN44vUlmOESAAlMooBedYUkS3cTsPWYkr591GCS6HrAWBSDTAfL0OANmrJd2GSHQ2t9ZAvbApkxysINN0Q12ziEfCT1yAIoiYyldUE4yI1zsR4gPzq2mL5xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/RhSdIpanza6s0EJBUfHwq1ghvR3cCWvxKYacYM0b4=;
 b=itHVLw0UePknd1tKBTWLTIOGslbCv6UekNasgNdszyK7ztX8THcKSn8EB7d1FrdkeSk5yTMPJCi1SDMAe+kLqpw4eHIZj/efsIcP2HmpqnIA2y24tgtEgA36xvmPPiydO7c4b/LZhIlcOjawTFur+grgh5OS2h1CO8Z0ABg3epQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 14:00:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 14:00:39 +0000
Message-ID: <e0930049-e97c-4cda-8cbc-8ad02cd5438a@oracle.com>
Date: Tue, 11 Feb 2025 09:00:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: The (sorry?) state of pNFS documentation?! Abandonware?
To: Martin Wege <martin.l.wege@gmail.com>
References: <CANH4o6P5mXTR6dpKCKHHrF4jcAL=wWoy3AWK6vateUHphSPvqg@mail.gmail.com>
Content-Language: en-US
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CANH4o6P5mXTR6dpKCKHHrF4jcAL=wWoy3AWK6vateUHphSPvqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 71dc2698-90fd-4cea-4bd0-08dd4aa47709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ym8ySjE1K0JKSlBqWE5MOUF0Z1llYnlPa3ZzTStXSmJYeGY0Uld6eU9Tczdp?=
 =?utf-8?B?RnBJeFNtbHkxWi9GWGMvYW5DTlhOcVhhaFhiclhrY0FRK1FERDZ0ako3ZEor?=
 =?utf-8?B?eHVQRzdlSkhwWUdWQ0dTeHZhaHhyZlVZVUczSGNLWmpGUUtrNVpOQnFXSFhK?=
 =?utf-8?B?bHVuMDR3c1RmWEJTblhQampIcER2YjZHWmpPV0NhYnFpTEhOejFFU1k5eXVV?=
 =?utf-8?B?b1l6NVYxNCtRRUJwdjBSVERkQW0wZmwyS05yeHRWUHZFTko1QkVpZ3duZVJM?=
 =?utf-8?B?MHpvWDBlQ1gwWU5TQWtOV3VzM29HWE1OVkxpYzVucTNPSTN1c1h0UG51Q1dD?=
 =?utf-8?B?Vy84NVFKQ0pWR3lNRXFNYTNiWk9qQW5GSzhHYU1sM2FEWGJaaHhZZ0xVOVVV?=
 =?utf-8?B?N0k0ZGFlWjl1b0FHUjFIbVZ0SitKc1ZBNFRGeVRTR21wQlNOVlpucDQ2aDFG?=
 =?utf-8?B?Z2J3K0JlaW94d29BZVExNGZRUlJpdEt2aThZeFE0NG1nTUY4Qy9NZGl2MmlW?=
 =?utf-8?B?OGpvVkVydDcrR01WOWxhMERKOTRnVkE0ZHVOZWs4Nk9ldkpOelBhcElWYm5n?=
 =?utf-8?B?RjRDRWNPbUg1dzV5dVh4MVhVZ0FYUURIa094d056em44NUdzcHVqQmdJZU0r?=
 =?utf-8?B?eGVKREkzKzIzUmQwREw3RW4xMmJValBhZFRnRXYrY3NFTi96dmJ1ZDlqaXNN?=
 =?utf-8?B?U04wZ2Q4M1JvTkVvRzJVaHhQMkt6RlFSa0JZYWdIQVBhM3BMRk5QaXNXR3lw?=
 =?utf-8?B?ZXRnZjB1bmZWamZGZjcxZnhkUER4K3dWd2lkT0hOQUxudjc0MEFlL1p5UVI0?=
 =?utf-8?B?OTFvZWhpKzdvSVlwZk81bms0dHRzS1VkUkFDOHB4ellSQ3VsajAyTTgrSkVN?=
 =?utf-8?B?WWlJeVREWEtua0xiTG1XeDFLNEFxQ1BRRjJQQlN5ZTJKZ2hKL1IzZjBmcDdT?=
 =?utf-8?B?OWxOR3YxOVAxcXZoektzUm41Z1E5bS85YnppcFhTL0lRdGlOSzZsZW9YdHVs?=
 =?utf-8?B?LzJDa0p5WDJmMVZKTXVNamowYXpPRkQzVnFhaUEzWVJIWTE0d1VCMS9GZ2cr?=
 =?utf-8?B?RDlVaEkyS3BVbUhUaVY2NzMvZExYSEJ5N3lzeUlwMllsNkYreWZhRTZmNWJq?=
 =?utf-8?B?T09Va2l5MWRpWnJGeVVmNzRXcVZsV29STzI2NlNHUGQvcnpMQlF6TzBkNDk3?=
 =?utf-8?B?dTl4K2c3WkFhSGdUdldSbWErOFZUMjdEZjJKTXhvcDNvZWFuWE54amI5czJB?=
 =?utf-8?B?OXV2ZWNGVUdNdE5pUFRNV0l2anF6b0Y3eXFhMkxpK3BVQmhrcUNIUzRSczBV?=
 =?utf-8?B?cHZQdmVRNTI3UTVHWWJxUVFOUnlrU2NiWFNuRmJuUDVmaVlkekJXNmZKMVlQ?=
 =?utf-8?B?WXdqdEF6NW1kWUZudkJIL3FCMUc0QnVwSytuTEFwZkRrMzZqRWVBS0lweDZL?=
 =?utf-8?B?RlBOUUxFaVB5Q1lFZ2VPY0VmcHNHRERuczhudzJUMWJSRFhnaWdHMDdtQWho?=
 =?utf-8?B?MklMMzlZTlNQSkNTRFQwM0dtQnVpS0NtQlkzdjFzYTMybXlhWmhycFNmS0RX?=
 =?utf-8?B?K3NhQ0RsWExkcTNrMDhHdmtlL1oxZGxHWmJUclFUc1VESlJnMDFCa3ljamhG?=
 =?utf-8?B?a3FjcFhFMmgrNjJxNmJrcDg5eHJMMk9XL0NhWVAvaldnVEVwRjlMT0t1bmt2?=
 =?utf-8?B?dzV0Njl2eHVYVnNQVWNwOXh1UHZVWHdZeEtSY3d6LzZzS3lrRE52cmEyaWF0?=
 =?utf-8?B?eVBxbGo4UU1WU3BvdlVVV1ZpMC9LaVZKNFZiWWhKaUNHVk1LTDQwVXhRWGsx?=
 =?utf-8?B?OERobGl3S2JsYVBDV1MxdE1wWVlOSzJpQkVpUDJkRjlxdHJiNG5rRHJ6UGpL?=
 =?utf-8?Q?LyIwEHqoDgVa0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDJZem4wa2JYY1hvamtlcXZGa1dqdjlqZFFjcHZJYWxlckdPcHEvSzd2SUFM?=
 =?utf-8?B?UDZOZWxVNElMSi9ubEdZZHpobCtwcTV5UGNPUCtOdEdxNlpxK3JQN0krdE0w?=
 =?utf-8?B?aUswYUxTYlNqaVhzaEFWcGNoaTRUa2FuUEpUbVFxMlFvMkVMZkhkSm1INTZM?=
 =?utf-8?B?bHhRZWdtbVFyZ29XZ1Y4OG50UkNYVE5WOEpKRGw2Z3FwWElWZmhYOVkzZUN3?=
 =?utf-8?B?VnViVVRMK21CYTJrZmRzUUtST2g3TjY0bE1IL2haM0VhR3QyTllKTy96WGxv?=
 =?utf-8?B?YVN3Q1oyQW5VcFJGQm5BRlJxbDM2VmhIS21kR2JBbXN4K0FkOFBuNVFDRXhJ?=
 =?utf-8?B?YTNTQ0JpTlE5Zmp3SGNyMUhsenY3c1JpdGJkRlFvS3VBQVhhL1NkNVFYLzJK?=
 =?utf-8?B?YW5QbXRDT2lLYXNCYkpTdWNGVlhTSmZpZFlvcGZqaklsaUFRRTNsbDZJTUhO?=
 =?utf-8?B?UXdxakIyN0twZ1FmUnlGWm5md0RWN1VxUEt6aktzeXhnY2liNUVCNm53cnc2?=
 =?utf-8?B?YjlxRGVGNVlENzhFOTZhU1kxbXh2eWZHVUpadTVpQi9jQkdCNHlHcmdEOXFU?=
 =?utf-8?B?bXFCbXlzbDQ3aFpuNzM5NXdIV3crclAyNno5WU56VjJQV1hBSGZldTdHRXhx?=
 =?utf-8?B?bkJKYzEvNFBzTVhCMDVWT0sxYnJZUnBPQmtmV2hTZENDSXRVN0I4T1VpY3ZR?=
 =?utf-8?B?L1FRUWdLMW03dlZwWlY5aUJ4czU3cWdpaG4xUC9lb1JvQTVCYlRtRmVSd2p1?=
 =?utf-8?B?ZnJqUXUrWndWWFBPcnBsbnNQbG0weWs0Rm82eWFNNUs3bGJQaWdQc3VkRnFk?=
 =?utf-8?B?N0VvazQrQWNvNzVLTUsxNGtJQnlFUnc2TjBvTXRNaC9uMHhtNGIyQWlvL2dK?=
 =?utf-8?B?eWcvNnMybWhDekdmbXFwWHBGZkRhQWFSOUMxWWVZTFpJbWswOU85cTQ5bk9G?=
 =?utf-8?B?OFFEWnJVamhSNHhHYTRQbFBKazJlSjVOSlpaWk5UaFRwOVpJUXdCM0hJZXN0?=
 =?utf-8?B?anNZejRXdWpKa2hkaTJGSFNlRFUvV3hFUzhiTUlqZE02anFOMllPU1hCRUZk?=
 =?utf-8?B?NE1rSVJ6c2ErQXVoTXBiaUwwTlhvcW53QmZLdjZFZ2wyYXk0d05scldOYmtY?=
 =?utf-8?B?TUt5UmdkNW82WWdreU50MUhiVFJLQmZkZGhNNGt0cTVMVndTbkphRUpSUlRE?=
 =?utf-8?B?dVViMVk5Y2hJVmFiR254dlBsYXRVd2lLd2hsN2RBWjkrdGdKTllwZGZ2bm5x?=
 =?utf-8?B?OGpXakIyNU1naWd1VDBJYTNUb1ozUDdZbkVoNjFXTmFZNVIxM0FHeGU1eHJ3?=
 =?utf-8?B?Q1pYVVBRcWVvR0lZaURZalZ4NE9oNXZiSDNpRXllYkFZRis1VC9VT0YvR0kv?=
 =?utf-8?B?NlpzY09FSkhNSHdmdnhmN0xtcTcyVGJQZG1uMVVYSUZaVGZKYzQ0eUc2TW1C?=
 =?utf-8?B?N2ZMR2xNQzYxMC8rRFNFZ0h6M0t6MHhTeGFXUFhOQTZ3M1hyakpkTW9vamJz?=
 =?utf-8?B?eUc4RTlhVlIvSC9uQUd4TGdGNVBnZlVXdGoxMVJ6MWRNNzRJTzdBRlVOT1dI?=
 =?utf-8?B?NlZHOWdzMVhUTzJQbUVJVHJMd0U1OUhqM0ZLRlpIbzN2SUM3RGZlSnpWUUJz?=
 =?utf-8?B?Q2ZoZ0NOR0l1MkJ2Z1piWGNwelR1eVp2S0xudERqRWtnZnFvWnk3a29RZXZq?=
 =?utf-8?B?Qm9qV3VTQWZjRkJ1R04wUkpPa3JtcHNlaUNVNkoxaHc4bDltYWJ2K2FUL2lu?=
 =?utf-8?B?WXpuaXhQVWFhSmdzV09Udkx4TWVoVWlCWERJWkRtemJ5c21BTGdLdHdTL1M1?=
 =?utf-8?B?dUxiL2dUMjNKd0NYbjJ1VkRmRDUvRitFSVdwWjNrUWVpTlNwd01hNEhFUXVZ?=
 =?utf-8?B?U0NIQVcxNzFPZ011Z2NYT2gyb0l2ay9ZdTBBcmdxbkVQbzFSdUVheE5FZ01Z?=
 =?utf-8?B?aDRMMldwL2toY1gyTnZ5QXpIWVB6YW9rY0c0eGN5TkY1bXowRU9vdVgveXRh?=
 =?utf-8?B?dit1dGtNVDdDYmFEYzFxcjVkZmcyczlZNWtsa2dhR2pNcEcyWW1xQmd5UHZK?=
 =?utf-8?B?OUt5VzdoM3R2Z1Q4QTJWb1dPMHM3Z1ZRNXptd2VmaXhZMkwrWncvTlFOSzRH?=
 =?utf-8?Q?1Fo7qomiJAvJqVk46T9MotG5c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eR7IC1sCb+EOL+NiDjdlH5dS5DkHxDruis3MYKR3YMxRqwgmUCMieftOy2Xvv5Kl4ik1pMn6qmXY9ksiJ7hccXdQGQlIO1hkhAn5qYk1+i1S4V6xkcQ3aeq++EGKosc+AGh+ErWWgUOVyDy09R2auZKF1kqHdc8LmiSHp6aQ7xxf6PER0Ms34Ql2JeJWpHbuXNdMDPckQ7XK/oIFc+vfMk/4NPQlyi8E4qWKs4wkt+yklGKeIH0kxYgt9PxLPLWe9BvZP2nBXZo0PnJ2zYFsUJGlSu5IKl6Px484VMG7nfDUx4QyayQTwe65f9hwutm4jNSNilAlk1uhdFHIrNk+rU4pUYx8Omk1kTEOT77/wchRXOB1dUxHr5Ej1EI38TpdpVQG2Tlb2nfAFDz+6jFa8cM/HA4dpJjNnWOv6DCNXCmIjRm8e/Uz2ZXjMGfhl91L/WZMpC5xkM78BQ4fPl+LoLUthiYVFc3KFbvV0+Lt4mRRex/7YWpSlM7iENJMVLQ39e1kkhC1xaNW+u/YgC3qo7rt8GmAl97G8UMdya4fDPry9js7i9+yIHMQ6W4nHlOv+EnHzofyfDYf1Agi2IXkWBnfxcUXFRm1h0zjupM7ZzE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71dc2698-90fd-4cea-4bd0-08dd4aa47709
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 14:00:39.0756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kksT40S4eXeZ/vW80PPF/r4vgVMMpuBYffSOOkQb+LB/SxbY/viDKm45VbwPdlr6wt4xyi7UQo+KRxiw5fZoSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=946
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502110093
X-Proofpoint-ORIG-GUID: copj5KhXcU1JaznXaqYHLhGqaNZlMciH
X-Proofpoint-GUID: copj5KhXcU1JaznXaqYHLhGqaNZlMciH

On 2/11/25 7:54 AM, Martin Wege wrote:
> Is there any up to date documentation for pNFS server support in the
> Linux 6.6 kernel?

There isn't up-to-date documentation for NFSD's pNFS support. There are
various efforts going on to improve it, but as we are swamped with other
more pressing issues, there hasn't been good progress.

pNFS block is supported, but it's not straightforward to set up.

pNFS flexfiles is supported, but the implementation supports only the
case where the DS and MDS are the same server.

NFSD does not implement the other layout types.


-- 
Chuck Lever

