Return-Path: <linux-nfs+bounces-10130-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56658A365AF
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 19:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BEE18949DB
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 18:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F2414D28C;
	Fri, 14 Feb 2025 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IEA9tH6G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oB81PpA5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A248266598
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557506; cv=fail; b=Aw1vm3/PIZQgJKLYbC9voNXKDE4CKLoy/VRHN2S+aW97G8VODMRLnVQbEl+/qHGkn4M11nSHpvO1q0etZAfQEBXTyj+O5qy6aHQMS/ljOgiKd4xz0qXPq90/tq6x8VOc3BrQGKVxw7f6FmBzmGyRw3Bk8BVlur/qtzDY+sd9yU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557506; c=relaxed/simple;
	bh=MtJoH7y+K4ZuCv7Skiu6WdQ7qlDqdF1EUIYG4K+Ddjs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GMXosZwLiCFPN5Np4Pv7GsmJHIOfXY5fIrG4mlnnCx4eBqhpRwW7+VRDRqYsBqBSgEf2wtdYvdBy48b/buHTywIdQfSc5zEqa3iswTVWfZB7gD89fpLudC9ABDiAtyzWoDzt/zrQesViC3GtN19gVgW18vl6QUWJpAJkrkDSKa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IEA9tH6G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oB81PpA5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EGBZfK007543;
	Fri, 14 Feb 2025 18:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=onk1yUNdHuuYoUqB8D5Ux8DQOFK4rE6zZw81CJ6XKsE=; b=
	IEA9tH6GooBBy/o79JYlX50thOKbH3TMJENUj7LzEtnp18/6wwhD9/pM4h85MNeB
	Ksgfys7/RKxQqCL7CKdiBOppjP3yg8bYKmvcNepkkS9kaewRKlC55t0rUDisy/xX
	R6CWtTnfk3DkcLqhIxu/KarQ+UOgmxoaXABvlxOoY6/cCxPSCn6z/EndhjcM7lgd
	2aHGHV7DaliqIaPIkdqDRokfKikNCxOL9mT8D3+Ua+lJEGmUDoVStafJRIdtCeVe
	Ozrk2dhy2+Aia77ru+r97qJT5dRpGoEAv0eWYChBr63QGRCuMOtpuFOnTYsrX/Rq
	R+hJACvyRu4wWLfZ0oZKuA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t4c57m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 18:24:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51EHQv6u014071;
	Fri, 14 Feb 2025 18:24:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqm316w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 18:24:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LU4XB6/3z1SurD/ZwpOxsQOmfdL0DOMrOvXr0lkR1cKPKY8sirdAKeEE3+0PJGN0xngmf0TiYDN0607dPudhoqr2asVfIYos0hNs5RFy2Z87xPupPrL3ALYt/vOqrW1ySyH9DAoJBSPHIyHasvS7AaFuT73deCYfGMpBzijhUYbJ/7toqb+WQ0gugNZYLaUznXM58TAGXmZAxT0frzqMbCv0FvYFz2eJJ0rxHVDMCwH9TJf69hSN9Gjwk/y6DAywN16H+/2ZtCgZpL+Fi5ulgGmGGNRreRpmbei6UTmuKcVDB4OQVGsLO01pXJ1pvAjSqkMX7krq60fYe65xSHFtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onk1yUNdHuuYoUqB8D5Ux8DQOFK4rE6zZw81CJ6XKsE=;
 b=XlijcsBsfbfhU8OCHbXyMetvrTW9Ffku5cigFasAuTOjjDnu1BRlSh+wId8gpZk1YJoVOfBgBDSgOg91iaDv9Zd3rZ03pADvdvnSYDdoGwrBYHaHEIYMCw8hmeqy54Mx0Bmikvus+6OrLiYkChXzU546c1o5RmPl3+zYUhF8DsgBmY4GW6iCbvn3UxyOHGX/rfLs13S2HruXFO1a+Dj0+wR/g+qOtK53l0X3cpifPfMq+cxQxl2DO19dtEz0EJ2EI/H1XUUXiourlxth87dnOzY9ZnramScCyXuMWXiHrJ6qrkRId/8V2H6Wu8/2Gf6xUl2BkcIXnQ75KkJk6klR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onk1yUNdHuuYoUqB8D5Ux8DQOFK4rE6zZw81CJ6XKsE=;
 b=oB81PpA5FyGRJN4bRrnCdkwbPjnws1JlgvLS3e5RmPnRdDOptGwUEXwg6heYdfP66wpv6DkdW47+PCXzE4s3hrbsnVeEdIsVOopJj7YgnWXN4HBsKnBzPr1x1Be36JoOoZFhdcU0Sk7k2llZhsTiNrBkt8ssoW9kSfl1n/r7i8w=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CO1PR10MB4465.namprd10.prod.outlook.com (2603:10b6:303:6d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 18:24:37 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 18:24:37 +0000
Message-ID: <7a59cfaa-b984-45b3-9c0d-e7ab6cbb65f4@oracle.com>
Date: Fri, 14 Feb 2025 10:24:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] NFSD: allow client to use write delegation stateid
 for READ
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1739475438-5640-1-git-send-email-dai.ngo@oracle.com>
 <1739475438-5640-3-git-send-email-dai.ngo@oracle.com>
 <5eeb042a0a6c69bba89e1334d6ceac872eda03e3.camel@kernel.org>
 <41f344362f8d1c7a3a3f72dbc8a904ffbccec189.camel@kernel.org>
 <1380007b-6cd7-4be9-952e-2a834d1a4e01@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <1380007b-6cd7-4be9-952e-2a834d1a4e01@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:52c::29) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CO1PR10MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 913d4dfb-2877-435c-1a89-08dd4d24d68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1plbU1PVjhmckJwVzVVNkRoWURsTkFoTjZ0WkhNbnhMc1RwQ2RrZ0FTYnFL?=
 =?utf-8?B?MllsSEFmcENnTVZNNnd5d3B0LzFpSG05WHhaSkZNZUhEQzVVTDVHOERWdE16?=
 =?utf-8?B?VkRHTFlkdTF2UlRqNDczKytpSS93N29ZdC9UcE1hcTEza2N4cHZKZy9IeU80?=
 =?utf-8?B?SEVzSjdJZkpEcXJ0NmJsajBVOGJpVjNZdUtibTVZSUtSbCt2QjVEbXcrZWh4?=
 =?utf-8?B?V2JVL0ZtTCsxYllFd3RwVVhzVHVsRU1RdThsZGRLQnU0ai9UT05jMnZablRZ?=
 =?utf-8?B?blhvK0ZWMjl3aEdnaDZobGtiaGN3V3NiYmRkKzUxaWtoNXMzWTlSSnRkdVE4?=
 =?utf-8?B?QzR4Sk5TMHhMUHB4OEdNL21DT0tqN1AyaC9ZRDhKRUtNNC8xQkV0a2daVE9E?=
 =?utf-8?B?aHhMM2VoRTlubTUzcnpsTyttWUZDeG5MRVgvc2k3alBwN05wTmQvOVNjTGI5?=
 =?utf-8?B?dzkwM1FVM0RBMG9GU1psdVhBRW9hRDJvc3pFOG5nNkZEdjRlZU9GcTFiUVZZ?=
 =?utf-8?B?TEtIOFlhTFoyOTNwZzhxRldIdkF6bVVLOGpWZ3kxS2ZhUWVBZHNZazQzbDdp?=
 =?utf-8?B?dm5BTktVSmtvaXA1cVZ3RE1obHZ1OHYxbiszK1BIMER0dlRvRmRBMi9FMjhk?=
 =?utf-8?B?MlhUR0Nsd1FpcTZGQ0wxMjVhM1ppYWNSZ2pMOGRJUS84dXN1L2RHakZGUERP?=
 =?utf-8?B?VEN0YTlPYUJCSmwvSUt5RVdwUDJydDQ3dk9KYW9SYkIxdWFiSmx5Z3JpZFlm?=
 =?utf-8?B?dE1SNmRaVmlKaURJK1g2NnhMbG0rdGdMZlU5QkptMWFscnltMER2bG4vZkZY?=
 =?utf-8?B?Nm1GWFpQcWJHZ3ZXdVdzYVByd2Y3cDRzK2JTNmg1QXVRMXZBaVNmczNBYlEy?=
 =?utf-8?B?YjlxdWtGV3M0bnIzek5vMDY2VEEvTTRXWjlDNHMySHNDdlprSUtQNnFEenB0?=
 =?utf-8?B?SDl0Rk9FeFp6cStnOHNsU3Z2ckJlQUFIWGp0WFVWbHk5ejVIMHJmMC9xVXR2?=
 =?utf-8?B?WnE5Q2hrNnA1K3RlMHhmbCsvMUxCOEhWb0tONDdHVlpFVERSOWJDV0dMSC9t?=
 =?utf-8?B?UnZEMXZrRnZXbVBlcVptTGZmOWxjTG1hOXpHMDd4bC9OUUhyV0xwWkc3NnFi?=
 =?utf-8?B?aWo2emR0M0hpVGtndG90Y0hveHdrZ1ZoZk1iZS9STjM4SFZCdVhRNytVdS9Y?=
 =?utf-8?B?N2hZY1V0Uk4rcGpBcks1Mjc2QjZsRVVXdVBFTE9TZHh1K0twbkVXVVpscTRE?=
 =?utf-8?B?emxHTVdqU2JXcXlzd0tLTzlhRmZuQU52K3U2aVUvRjBSOGF5RVIySDBhTGJK?=
 =?utf-8?B?T0hON1psZ2ozNzVBK2JxTjdxSi92WG1rSDl0VHFUMXc3ZTlWUU9RQWJUVnJB?=
 =?utf-8?B?VVlEMkZSdjFySnlHRzdoOHBUTWQreDhzVXFGdll0aUxQc1N5emswZ1hhcjlr?=
 =?utf-8?B?QVNMVW9uM0ZyUTlFUUlnQ0VCK2JjMWF2YnB5aktUZEFWaFRLZW5idTJlRERP?=
 =?utf-8?B?d21BZmtGRWdDQkpoK0piSUhLMXJJM1hKZEIvNzJSVVltMVNUU3hpbkZVYzV5?=
 =?utf-8?B?Y1QrV2hEdUxobmhqMXVlQmpVSFFKUjJjWDRxdDBsVWFLYXBmTjF6WFNjSUpt?=
 =?utf-8?B?WFVNWlorek1HZXYrYnAxMEVBNms4amc5NDdPVFk3OFZzeVorVHdud3lvNFpm?=
 =?utf-8?B?U2RtNHNrZGJMTUNGTml1MDVyVnlOUUllMkNObVRYajBydUlCbkZxcjN5MHFY?=
 =?utf-8?B?T3BvM2ZuLzBoMVk3dFVXSnoyNFlOeGhMb2t3SkxlQmJYSjFkYkJheDZtUGgv?=
 =?utf-8?B?TzFDQSsyWTluUHhQMi9Tai9Kd2ZSNWRhM2hUMmcyVWNpYmNhQW56OEFhNzhr?=
 =?utf-8?Q?RepzgIrGqjvho?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1N1b3BITHNFamNGamlWVzlRQWIxZTc3bmoxaElZaTBPMEJjTXZqamoxWUxn?=
 =?utf-8?B?em9BZ0V5ekFtY0xLWlNtbXhOeVZvTUVwNU10L2tXcy9PU3FmVERBWnBScjl2?=
 =?utf-8?B?bnJTQmF1TDRySkZWd084SDJDaEhaR1dtcG1VbWp2T1Y4Z3pJS1BkWDlVajJW?=
 =?utf-8?B?VnlKUFJWcEJzYlZzajRqcEtCQ0d2OStwdHNaaDgrbXp4MHJrcHl6blQ5QVQ4?=
 =?utf-8?B?WDlRUjg5NlVMTHpNOFFwVVcvZkN0a2JXQVhrSDRwcloyRGg1WXFzT1BFcU1h?=
 =?utf-8?B?dzVQblN4OGhPdnhxWHFPdm42V0d1RmpXdXFzcTk1dlM4MFZzT3lwRDdKOVBo?=
 =?utf-8?B?YWVyTjN3citSNFRIMlhQVlhIRVFDV2V5YUh0TklHTTh1VzFMK3lwcmN3c1J3?=
 =?utf-8?B?YmkvYko2bDgyc2pHSmZKRXkyRVFNVUtiVUduYUgzcjVjanBHT05lc01CY3Jp?=
 =?utf-8?B?OXVKOVlKMTUwdVBPcU1XOGZ1cXJNeXk4QS8rZkcreFpzOEMzaHE1TFd2eFdx?=
 =?utf-8?B?ZFhIczlVODlrT25JT3pNa3dyTXdFVFJKdmRTbGdEVVJpQjNCRmNZWG05RFMv?=
 =?utf-8?B?WmVKWFNJQTAvdTVadEExSk1mbzFnY2xSRS9ISTNoSmkxaU5uOUtmU0JCV2lp?=
 =?utf-8?B?VW4yT0VFaHZCT2YvZ2IvR0JrSEY2OTFJd1BNYXNyRndXWkNZYmJwdVdMOUxh?=
 =?utf-8?B?eFdqQWpqdkVOSTVyUXUrV0N4L1pzT1NVbXZRQTdNenpQUE5peW9oRVRlaFdp?=
 =?utf-8?B?NzdkREZnSlppOFo2dlNrQU9INU84bXBuZDdsQzY1amI1UERIdWQ3OTBHV0tS?=
 =?utf-8?B?dnVxWFJ1RWNuaVptdWhoVURTWHZaVHVmckxCclBSbkJwV3ZBSTdQWGtrVzV4?=
 =?utf-8?B?UWRraXlsTlZjaVlKMjN5S0VKOGxrVTEwMnBxUytsWVU1SEhsR3U0MEc5QmJm?=
 =?utf-8?B?azkzaXBsTUhVM0ZDWWZJeG1QaE93TUhtckd1djAva0tXSkZiOGcvd0JJcUdO?=
 =?utf-8?B?bjMzWXYzT3didzFBVWtHeXI0VXBhMXJkUktZTHdYd09PZWRBK0VPUjcwN1d0?=
 =?utf-8?B?R1VEVVhtUHZUQXcyQ0U1TVBtVzRoQTdXQ0ZpQklJalQrWDE1S2NEUkIrbFM2?=
 =?utf-8?B?RElKSjdVSGxBTGhjRlY4RFhVZHM1MkhVaUl1bVNEOXowOW5LdkcyWUNSRjNt?=
 =?utf-8?B?Y0NEQ1BzMzBjUzFNQWVjSnFBTVM0VEpqV3VMZEdpTXh1RlkzNTRueng0T0t3?=
 =?utf-8?B?Wm1Oai9OU0EzK3NKazJnc3I2MVRBRytiZU03QnNMblZhOVZnWGN2bmszVHFU?=
 =?utf-8?B?Z2g0M1RGNVQ0Wmd1NUQ0VUlpMHVrQVA3V2FUT2sydjIraTRtNGNTaWdjd0Jh?=
 =?utf-8?B?c2ZKWU5sQi9UbjRKeDV3Q3IzVW5wK3BYaXhEL3NNQlFlMjg5TG5GMFVFdlpR?=
 =?utf-8?B?YzdLZkFHK3NzRStrMTBzNGVPcmVSbmx2N3FFV0dHZ2UyMVhvU1FHaGNtUjc0?=
 =?utf-8?B?ZGR0NUlRRlF2a0tSMXBkZ05tRTNHc05pcHdYTmxVUHFkMlVmckpNcHlRa2pH?=
 =?utf-8?B?dW82b0tXL253M2ZJekZacENaM2RkNnNSSkN6V0k5bzFRT0RPNXpkK2M5bW81?=
 =?utf-8?B?akFkUDdWQVY5ZGcxajFYd0VhSVJHamlYaExodk1YckRIVks4dzRJd2NaMnJr?=
 =?utf-8?B?Uk5pV0ZieDIxdFpCMEhnMmNMZGFFbVFRRmRBeEdQQWV3NE0xblR2enRJeTRa?=
 =?utf-8?B?U3lQVEdaZWJ5L3gxa0VRNDdGN0V4aGJrNUFYblQzYk92bWlFeTFyT0ltVCtx?=
 =?utf-8?B?N2NObE1Zb2JUenI4N0QvWHBERDBmbTdYNTNHZ2t2U1h4QlN5a2FLeGpONUxZ?=
 =?utf-8?B?eWNGQ29nbkhLVzdMUUVRbiswbkx1REp5RTl4c0JxKy9aY1haOUxicjN0UG9m?=
 =?utf-8?B?Z2JjUU0wM0hCUWpmMkRTditUWnhYVVViVjk5VktkSnhaVVJBQUVpTDhsSzNU?=
 =?utf-8?B?N0JiM1drbEM3QlZRM0RMaEFlaFF0QkNETFptUmdiTHJ3VlNJdG45TElvTEY4?=
 =?utf-8?B?SEtnM256ak0rZnM0OHFTRzJ6Q1U3a0NaL0pRWS9ReVNMTEZUbmNyZmx5N252?=
 =?utf-8?Q?Qhvn9aUeUk1MWTWlcsb59Yfx8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NisVKjKA2YxJbW/rLlZN8FWbSlB4R5gGS3AGT1PZ5H6lYhFAta6yALEw+NrkCmp2yubmC2taztUz3SViRALi6SVTge8FOrRyNlHLOUcGiztftYs6AEuMlJjIbQV9n+HKw/lM3U3McBwOJbJMcxEH3G3m6U2arDSxqKb7Bz9enj2zGzcTfO+hY10wTs5GN0W3DxaCeUNeCy+guTvhNzO1lyQyhOdaVq8eHrYCYr7ILDOPBE5YO9fBjv4ccAKJ94jP67c3UzeLJjApK5PkJJ1knkfaXTGzerDci90wpDIhZCidihQ7yKINDHd40cyfBVOpiCcK9WVkrj3AWONFYifciYymoYDFFc3jTpjBMGHL9KegC/K5F99Wn5s8YK9xEuJBZzVK0weydqefbmXkUVDkv55GLs/2xnE2z/+UQJRnE7uBaN/eQiclfIC9tpJgZPqIZzsK9Q/Dis+T7WsyWMCBltN2j2vo2nPkI1K9XhSHpJ/vdbGHTfep2qiJiYaBC5wiByU97o/CzdBEZpQLsbckn4TbKxLmatsHZ+Ab7P5lqgTCbgcvm0AS8gG84VpldhBWSLumgIgVUV6jyH7F9/lhT4S9lFSJLxzqw06lx1LX5YM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913d4dfb-2877-435c-1a89-08dd4d24d68f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 18:24:37.2927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJAoeNq6zd73cXEtRXnv7L1dPxO75O7yGK3uzJMYoFWda1xDYP75AZfmGiVmx0747KxzrsgJKUy+zQ1jB0W/uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140127
X-Proofpoint-ORIG-GUID: BK-7GjF6lwCy7KN_V6iTjc52Jzb_omuv
X-Proofpoint-GUID: BK-7GjF6lwCy7KN_V6iTjc52Jzb_omuv


On 2/14/25 6:26 AM, Chuck Lever wrote:
> On 2/13/25 6:29 PM, Jeff Layton wrote:
>> On Thu, 2025-02-13 at 16:07 -0500, Jeff Layton wrote:
>>> On Thu, 2025-02-13 at 11:37 -0800, Dai Ngo wrote:
>>>> Allow read using write delegation stateid granted on OPENs with
>>>> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>>>> implementation may unavoidably do (e.g., due to buffer cache
>>>> constraints).
>>>>
>>>> When this condition is detected in nfsd4_encode_read the access
>>>> mode FMODE_READ is temporarily added to the file's f_mode and is
>>>> removed when the read is done.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>   fs/nfsd/nfs4proc.c | 15 ++++++++++++++-
>>>>   fs/nfsd/nfs4xdr.c  |  8 ++++++++
>>>>   fs/nfsd/xdr4.h     |  1 +
>>>>   3 files changed, 23 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>> index f6e06c779d09..be43627bbf78 100644
>>>> --- a/fs/nfsd/nfs4proc.c
>>>> +++ b/fs/nfsd/nfs4proc.c
>>>> @@ -973,7 +973,18 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>   	/* check stateid */
>>>>   	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
>>>>   					&read->rd_stateid, RD_STATE,
>>>> -					&read->rd_nf, NULL);
>>>> +					&read->rd_nf, &read->rd_wd_stid);
>>>> +	/*
>>>> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
>>>> +	 * delegation stateid used for read. Its refcount is decremented
>>>> +	 * by nfsd4_read_release when read is done.
>>>> +	 */
>>>> +	if (!status && read->rd_wd_stid &&
>>>> +		(read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
>>>> +		delegstateid(read->rd_wd_stid)->dl_type != NFS4_OPEN_DELEGATE_WRITE)) {
>>>> +		nfs4_put_stid(read->rd_wd_stid);
>>>> +		read->rd_wd_stid = NULL;
>>>> +	}
>>>>   
>>>>   	read->rd_rqstp = rqstp;
>>>>   	read->rd_fhp = &cstate->current_fh;
>>>> @@ -984,6 +995,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>   static void
>>>>   nfsd4_read_release(union nfsd4_op_u *u)
>>>>   {
>>>> +	if (u->read.rd_wd_stid)
>>>> +		nfs4_put_stid(u->read.rd_wd_stid);
>>>>   	if (u->read.rd_nf)
>>>>   		nfsd_file_put(u->read.rd_nf);
>>>>   	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
>>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>>> index e67420729ecd..3996678bab3f 100644
>>>> --- a/fs/nfsd/nfs4xdr.c
>>>> +++ b/fs/nfsd/nfs4xdr.c
>>>> @@ -4498,6 +4498,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>>>   	unsigned long maxcount;
>>>>   	__be32 wire_data[2];
>>>>   	struct file *file;
>>>> +	bool wronly = false;
>>>>   
>>>>   	if (nfserr)
>>>>   		return nfserr;
>>>> @@ -4515,10 +4516,17 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>>>   	maxcount = min_t(unsigned long, read->rd_length,
>>>>   			 (xdr->buf->buflen - xdr->buf->len));
>>>>   
>>>> +	if (!(file->f_mode & FMODE_READ) && read->rd_wd_stid) {
>>>> +		/* allow READ using write delegation stateid */
>>>> +		wronly = true;
>>>> +		file->f_mode |= FMODE_READ;
>>>> +	}
>>> Is that really OK? Can we just upgrade the f_mode like that?

It seems too simple but it works. I tested with pynfs, nfstest and
git test, also with reexported NFS share.

>>>
>>> Also, what happens with more exotic exported filesystems like NFS?
>>>
>>> For example, if I'm reexporting NFS, the backend NFS server may not
>>> allow you to do a READ operation using a OPEN4_SHARE_ACCESS_WRITE only
>>> stateid. Won't this break in that case?
>>>
>> Hmm...bad example since we don't allow delegations on reexported NFS
>> these days.

As of 6.14-rc1 the NFSD grants delegations on reexported NFS shares as
long as the server where the shares reside grants delegations. And this
seems to work properly; delegations are recalled when expected.

>>   Reexporting Ceph or SMB might be a better example. They'll
>> likely both have problems if you try to issue a read on the result from
>> a O_WRONLY open. I think you will probably need to rework the way
>> nfs4_file's track their struct files.
>>
>> IOW, when the client does a OPEN4_SHARE_ACCESS_WRITE-only open, you
>> need to get a struct file that is FMODE_READ|FMODE_WRITE to hang off
>> the delegation.

There won't be any existing struct file with FMODE_READ|FMODE_WRITE when
nfs4_set_delegation is called if the client opens the file with access
mode OPEN4_SHARE_ACCESS_WRITE. Unless we create a new one which means now
we have 2 struct file's for the same nfs4_file, it seems like problematic.

>>   But, you'll also need to fix up the accounting for the
>> share/deny mode locking to ignore that you _actually_ have it open for
>> read too in that case.

If I understand you correctly, you suggest that we upgrade the file access
mode to FMODE_READ|FMODE_WRITE permanently if the client opens the file with
OPEN4_SHARE_ACCESS_WRITE only. That works too but we have to remove the
FMODE_READ from the struct file if the delegation is recalled.

-Dai

> For the record, I agree with Jeff's suggested approach.
>
>
>> Smoke and mirrors...
>>
>>>>   	if (file->f_op->splice_read && splice_ok)
>>>>   		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
>>>>   	else
>>>>   		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
>>>> +	if (wronly)
>>>> +		file->f_mode &= ~FMODE_READ;
>>>>   	if (nfserr) {
>>>>   		xdr_truncate_encode(xdr, eof_offset);
>>>>   		return nfserr;
>>>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>>>> index c26ba86dbdfd..2f053beed899 100644
>>>> --- a/fs/nfsd/xdr4.h
>>>> +++ b/fs/nfsd/xdr4.h
>>>> @@ -426,6 +426,7 @@ struct nfsd4_read {
>>>>   	struct svc_rqst		*rd_rqstp;          /* response */
>>>>   	struct svc_fh		*rd_fhp;            /* response */
>>>>   	u32			rd_eof;             /* response */
>>>> +	struct nfs4_stid	*rd_wd_stid;        /* internal */
>>>>   };
>>>>   
>>>>   struct nfsd4_readdir {
>

