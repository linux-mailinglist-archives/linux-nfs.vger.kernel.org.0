Return-Path: <linux-nfs+bounces-14959-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F793BB7202
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 16:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EFA77346329
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD91A1FDE01;
	Fri,  3 Oct 2025 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gc9mcHy3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NA9ro8Y3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D6200110
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500693; cv=fail; b=RlVR924IMVKyoJbhxxJHvT2GdHhuRIkcD3WnCdyC/Ftc9TGc2Twr2KVJzGKaMINanELU0YQfoojWyYus5wAflP9gy4A4wEpeOJhlXj6Xc4bemg8kJPP2RZZ1OFxKcRBps262QBKgSSnyEififVuNrKbt5acQDkl6kQ7Y/WkyrHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500693; c=relaxed/simple;
	bh=3sekRATgX6XwyDS0OQGujJeCP4zdX3qO4OZpduILqHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oWZ43gr43ToCX7bmh3s1OUoziYHOolhp/75lnfqh4mnDJHXYXAruL+Wzs4HjA2fVEtgeoM0zx34XeOGcHMzMW399Mjeu9jXJIyBTHaNWU4i384V5Tt38A51ATnNefnjAAmq1kVtBqfmN1DM6e9mwr3O2DXcJcFhfTNaYSf2WaeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gc9mcHy3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NA9ro8Y3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593E6McP030071;
	Fri, 3 Oct 2025 14:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=shTZD4Rv+3NRKndp7ZqYXZvN23ettaJIUPPq9shsaDE=; b=
	Gc9mcHy3OpmiGsPI5f3IW+p1dvyucTgmpu0zaMzIMBSGj3N5ZF61M7NE2LiTfBL+
	8mh0V23b+MA8j+w9NSmqYYz+v5XX4rXnOOpGxVwEVp54ps0iWollhnXI6HW7e8Bc
	or7LLME5fP7UAKoPIKtQYtinF7nZiX4TtjxmjcZZp7Kxh2OS8AhtnB5Hu87rKp6l
	SqT6FdTCIALT3zJSmpNTSgrFCKeh6m8b91DEOaG/w4yZehgAvHYoKMtLufKVgAtJ
	ugl6zRZfke360YCw52oQV9NDEWonEx0MuvjpRCBYD9WZ2v3iKDiZghpfsaNKA8Zc
	3r8FgeOPFPf8fcPnZXO8zQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49jfy2g0ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 14:11:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 593CokZH021655;
	Fri, 3 Oct 2025 14:11:22 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49hw10anrh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 14:11:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNegHSPFkWK39uMmMXr90bNLycho9+nPLQfQXp6l2LrFh6mPedCsCM7e/6rXNAHwLt5+m/PLAFGPa84EzWNUJ5URYPpV2XS/lrT1RJw8pEF2GK/DbZpUcEMsN039kjfb3dQN752o4nmKaXjZu1ITC2Hwapk1DoCDs4J8zkugoJhlm4/1jT/par9otSSns2bG6+842sNSn8jFguIKvyTHIoyobe6iLBiCNbtCUAzjtbpE0JHrMb5B8rPHQ9Tr6AEoJOhAhR4HLHzAIcwDMc/pWJHxUCY3SAWzBUIa9SNuiFLlb7ZIj4w7B/O9ZfuUoW31/cznRglGlfLInp3OotHIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shTZD4Rv+3NRKndp7ZqYXZvN23ettaJIUPPq9shsaDE=;
 b=EKX9x6oJ0doGvalLtD38TQFHGyisPuveufSuCcDckxQm895yRV27A12bwQONdxwg9Yb2rKgZYEiMHfUXQmIuA+wimdNECdzv2yS+aFeSAoQVCQ/CZpAc1V4jLCYtrNfMnLp/tGk451QuVhXYTu9gMp4wgfg/9zkUU37AovXRlgVUZZXZj2Gba7OwFjVz/HiPeMRMhGAJOyFnDt14YAwBmlq24roFCOH0eKXfgWfd0fhomUrY+p4R2GKY3cc6ADp6YFeedMHJ/iA7eNilXInto9HNmRQIlz7o5lCK2qUY992p9xhXLLkZ7aq5kNl4i5ATzBm7iJJnekfKzTTYuJqLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shTZD4Rv+3NRKndp7ZqYXZvN23ettaJIUPPq9shsaDE=;
 b=NA9ro8Y3x04HV8HNyBX8HDZhAztkUJApIAU6fX5jafdAmz5TM+Jb9GI12ge5s/490XadUY31CNFz88DYS0kJiAxC+EmDT6m6O/kvT4Wkaf9VlC8sRW2wm0ONkppmxTXovx3LhSZ18+ICHh+IlbR/w3USix8D0KhncIbdIiNKkbM=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DM4PR10MB7508.namprd10.prod.outlook.com (2603:10b6:8:17d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 14:11:19 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 14:11:18 +0000
Message-ID: <3137a3d5-1377-49e3-a86e-e41c1afc9666@oracle.com>
Date: Fri, 3 Oct 2025 10:11:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] NFSD/blocklayout: Fix minlength check in
 proc_layoutget
To: Christoph Hellwig <hch@infradead.org>
Cc: Dai Ngo <Dai.Ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251002203121.182395-1-sergeybashirov@gmail.com>
 <20251002203121.182395-2-sergeybashirov@gmail.com>
 <aN9zNZ7n4KwhIZrJ@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aN9zNZ7n4KwhIZrJ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:610:b3::25) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|DM4PR10MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d84ba9-96c5-48c3-9eb3-08de0286b7bf
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cXJLYjI5cW05RXcvUUR1YVdqWjlEVE1TL1BJRFgzZXJCTmxJRFBwbmdNRnNQ?=
 =?utf-8?B?bjA5WEtYM0tRSzliZ3pyTThBa3MraXJSWE93V21VaEhNRC9tZzkrbUI0cmpW?=
 =?utf-8?B?b1pEOTB4Tm4yVnAwaFNNY2JLdDdjc2V2WWRpUnVaK3pKSFJzYzM3MUh2endv?=
 =?utf-8?B?Q1hsVTM0UEo4cTVTOWtKa1dBdTl2Y2VuL3plZlpuUUIxTlNzVDQyQ1orTmJK?=
 =?utf-8?B?eUFHTlNiVElKQW0yV1JoSllQQUN5djJkNktMYVhaOHBwYzY1V0hlenZRalVx?=
 =?utf-8?B?Y1pKOGQrZFlmb3U0a1kxYU0vT2xPcWx2U2R1Vk1MeGNIMitMNkVyQWRnbFVG?=
 =?utf-8?B?Znl2UTc3TGJnOWhQcjVZMGhtWTdDaWJyeEtSTUxlTlMrRHBGMnF2Kzg1OFhj?=
 =?utf-8?B?QjRDSkJNZXAzUTJ3OU96aHBKRVRVOERrbDVsMk1aNWRoU1lNaVJ2V2FnajdR?=
 =?utf-8?B?alpyNlFPUmJ4WHpPeXNCOXBRa2lPSFE0SXBkV1Q0dU05MVRMcXNvY0hBRTMv?=
 =?utf-8?B?ME5XZkhTaUx0bURQRnRoZTdGTjRnL1RxRGNMSDUxWWYrYkkvMmpVVzJzWDVM?=
 =?utf-8?B?YzZYYjErZHErOGVZSmtTMWowbXFzbHJRRGlybkUzVXpQL3FyRjBVcFYxeE82?=
 =?utf-8?B?MXh5dG9FMjgyUk9SQTFKKzJLT1BmMWtiVkhhSS9qcEplb0pOcEUweWlNRnh5?=
 =?utf-8?B?RkhTYXVvYmVhRGJKeTBhUGJKZ0Y3VUN5bnQzSkRROU1ROGR0Mm9xeXdZeDRX?=
 =?utf-8?B?V1dOWWsxUTZpOGpvWGJPRnNYVldCdlNrbmJJaGFJUnFqUnB4R0t2YlFwT0p0?=
 =?utf-8?B?bXNzRms5UmJGU1hOME16MGtnck1USmNib0xmcThwS0hhbmdOb0hwUUwrUUZa?=
 =?utf-8?B?cUJMQlZXQjNkR2VQQitSdmN3THVFMHE2K050d053OVBpRG9YeGt6dThPaFNL?=
 =?utf-8?B?ZjJ4THk4c1ZyVGhidmZXaExHN3lNcG1yVjVlNEpsR0R2NWtuWmczb1Rqb0Qy?=
 =?utf-8?B?QnRSclhETDNpR2srUEdqcnd2cWlFbGk2WnVsSFNLQzJ1cjNPeU5NM1AvWU93?=
 =?utf-8?B?TDlrY3NjZ0lObG04NTlEalI5bWVRZjlSTnBHWXI0TWtLaWhUd1Q2dWNEQ1Nw?=
 =?utf-8?B?VmRDV3h1ZzUzWERZMDJ0b0QySHM4VmphUWplc1Z0WVROMDkzRXZqQ2ZUc2Fa?=
 =?utf-8?B?MkxXUGpMOTRxb2R0dDFQMXBEVi9oZHVKdUVDUmF3OG00L3FMU0JBM1M3MEY5?=
 =?utf-8?B?K0huOWpDUDZkeHNjNHFjLzFqZ2ZXMmxKR0lwV29jV1NQMDVmdldPWjM2Q3Ju?=
 =?utf-8?B?MlF3ME5zV0ZhZjIwTG5IZzUzbCs2b1ArSktIMHNCWkhxVXdENUh1eFhiSHNj?=
 =?utf-8?B?RGI2T0ZMMjN5QSsxbUUzUkhYSk42SnBMalhxeHlXbU5pZFMrUnRrakhVTyt6?=
 =?utf-8?B?RU5ySUVNU1d6eXZIY0pVUVQzbHI4QlVnb3RPbldJejBxVjg1SlFjRmdyWjRh?=
 =?utf-8?B?T2NRZFNmdmdINnZFVVZ1MjJJb21aWnUwNTYycEJ5aEMvM1lrRDlOMDJqbHVL?=
 =?utf-8?B?bVpTaHdRb0xqRjRlbkswSkp1cTd5WVh1bmNBMCtwV1k3MnZGQU5TMk5zaVRE?=
 =?utf-8?B?ZDlQdkQvT3FZR3Q3V1NqaDJyalBnak8rSEdLdWgybmVUNGtnSXRsc0N5Uml6?=
 =?utf-8?B?Q0o3dzNkMXorcHJBQ3RWNjJHVDhxN01WQnQyb1NBVWUzeWMzK0VXNjR3d1lj?=
 =?utf-8?B?bzllQ0ZTTk1CNFp0M2RPVmRVSzE1WEswbFB2QitWYmo5S0hBVjNOYWYrY21F?=
 =?utf-8?B?eWJyM0UwdjBUTjhZUiszMi9pT08wM1NHN1cydmxpekhGR210Tk5OMXh6WGY5?=
 =?utf-8?B?ZDdpcVpYOHY2ZkVVR1hta3I0Q2xzVjZoZkNHOFQwM3AwQ3BzTElOZ1FRQlIy?=
 =?utf-8?Q?8ezhk7cAxBKtRLCp8yVonYSBcJqD8j6O?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RXFKQUUreTk3dnlSbHM5cWVMR0JIdm1uQmpOTWcyZVpKRWhhK0dFRDJnbitJ?=
 =?utf-8?B?bXFreGlBODhJSWlWYXhXQzl3eDdmbUw3RTcySHZhNGxURlJvcURyZFFzRjZF?=
 =?utf-8?B?YlNEWElIM1drZ3BMWWc5aEo2NjduaHFkRmVxM3R5b0RRNC9Ca3phdEQyNkxz?=
 =?utf-8?B?RkRrWXRRRTlxbjRPek1wZllDeU5nS3hqdXFBdUZ4RWxmUTdjWlJzMnpwWHMz?=
 =?utf-8?B?L2kwUTJFNlRMTkJscmg4UzBJTnhCeW5vZlFFTFJPQXkzcEFaTHpKUHJobTlp?=
 =?utf-8?B?SkhkVXdzU1B4SVdPaTZxVzFPWWdsUVhuV1B6ajd1WGdwQXlTSVNHdFdXV1Nv?=
 =?utf-8?B?L2p1ZFFMNEFSSjVRb0tEdndNNUZ4dERWU3EyTXYwSU02V1ZrSi9uaDVZWUdS?=
 =?utf-8?B?ZnM2K2RCZG9FTjg5Z1VDNXdsOE9neG5HZ3pPbHIyRG11SytqS0U4eXJTVWpz?=
 =?utf-8?B?QUFFOXplUTkxSkVIck1DaFZBd29lSHpDVXJKNzJvT3Y4Y2U0Q0tvd2tWbzdO?=
 =?utf-8?B?Z081YVJJcnZ1NzZzMVo5c2xPQzJOcjNqV3ZyOVplOERNdmt4M0V2bzM2MVFz?=
 =?utf-8?B?SzVBTGRoTkduYVh6TmVYZzBjMzg1T3AzT2NOUFZMRlVQMzRicXMyU3BQaG8w?=
 =?utf-8?B?ZVBVbFU0QnlEY09KSzFsNk94a1RNUGxFdzN3UXJpQ1VZLy8zS25BWE5LenNY?=
 =?utf-8?B?NGxSeHRQZ3RSNGl1RFUzSGxGd29COHB3aHh3SWpmZXB5YkFNUG1Ea3R2cnEy?=
 =?utf-8?B?NTNzUnVka0x4UWcrbnRTY1ZoQWlGU3dwTmxOUUszU0lwR1VhS0JnSDJYdldR?=
 =?utf-8?B?dm8xOTh1eTFRaU1NNlZGTDZodkZTWG5rKzZzTm1aK2I4VW5oZE9hS3dIeXhw?=
 =?utf-8?B?bGx4TTF1ZlVMSDFVMXNZUUpCWmxGRVpTTzZiOUo4WEplLzNDZ0Qrb2NzTG9a?=
 =?utf-8?B?eExBSk1MZDhCVGxSeTJxWnQ4RUpqT0c2bGlkRmhmRzBoZXdvMlFhWGpIMUdk?=
 =?utf-8?B?NFptMHBITkt6eDlaVG1DUUxoeEJ6Rms2RmozamhqTHRUVEphWk9nbFFMRG9p?=
 =?utf-8?B?dWVPQ05zWDZSL1pldnlCT0tTTUZsd0FMRWZyTGltUEVRdVU2WkpCbExxVldH?=
 =?utf-8?B?ZFlRVmsrdUdVM1A0TkxUelZ5aVNiQ0o2N2FPbDcvMVNZTUVFcE9uVThpSUdG?=
 =?utf-8?B?QXZQS3ZsRXR1WW1aNWcyWnk3Mk1RK1lrTTVWa3EyQ2dMNWp1dGsxZTdBdDVs?=
 =?utf-8?B?RWRhcEkxRTNqL0dmdCtVRUJxTnBzTlIyNkdDL2J4RTZvNGZwRVBJVWdncW5t?=
 =?utf-8?B?MmlVUVFhdFRyMFQrVURNNEpmdE5kL2Q2VmdSNmpSREp4WldwU09DcFp3REs4?=
 =?utf-8?B?bUZLRUFaME9PbGVnQ0RpMmpUVkJITmNjUHI3Ym1sMVVOWnpvc2xQRHNVb0JE?=
 =?utf-8?B?YXMzUFd6U1p1UTU0ZnpLYWhaOVZuL3FkczVkUU1WSWRTdnQ3NGtrMnFGS2Yv?=
 =?utf-8?B?N1p5WlFya1pLa2F3ZDRtNnNaeVJDRnJOY3d4M2l2Mlo0cGNlTE8wbFd2K1BR?=
 =?utf-8?B?dGNQZXZlbXd5SDJmZTVKTmI4UHZJYUZkYWppL1Z2cjdSb2Z1aE95b21KRkFh?=
 =?utf-8?B?L1JUUVJWY2ppNVorQnpuRHZ2RmtVYkMwMnNjSmZyUEFuMGsxOWk2S1RHakNy?=
 =?utf-8?B?Y0RzVmdBRHpsNDBXZnMzSHZrZm1OZ0JRNDB4UFlhbDNRZHJPNTFJYWx2WThD?=
 =?utf-8?B?NVVzL3p1eFJnaDhjdHZEanZEYkcxZW42T0dxQmRsQ1JLQlYzQjJVTXd5OE9m?=
 =?utf-8?B?OTh0VUZ1eEFVbTJOcHVWbDh5RzFnMDNLMUdGSHFMV0ZSUG03amNVMnFKVU1R?=
 =?utf-8?B?eklDL09RRG1HUlNUTUJ2Vmp5KzdTOHFFSm96VVFYNWRRZ3duT3ZGNWROanRy?=
 =?utf-8?B?elgxRGZHSzRNcEZYcmpPc3JTQ05RaWNRRTRVNkExMVNjcTkwanE4U0xXZFI4?=
 =?utf-8?B?QTdWUzYrSUxoRVN4cGZoaDJQSEEvenBvbEQweU1TcVVGemVxRVFkN1NRSVhw?=
 =?utf-8?B?WWtaOEJRbnl1ejNlWTlTUW15bEtFUjAxQjM3YW9JYW1aMmJoN1F1Q1A5amxD?=
 =?utf-8?Q?D4SsoRKJSD34DK8ytc6vLl6TB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rJCBjBf4FYY85Gq3A82uKjGkIktNVJWflgX2oDbZbMTTTZZNTjZAlIq7lICejX7l7LJ4VbyI+kdp7Uc8ppCpVpnDGb3pM/kOKDi6exxcF6KHZ0xkNWiIspRHUHNI8q7Wtq+Df34j+ns5WH7LInFrGlh2u0mBfs8zKuHtREGV2SfUIQq/jpJtf7o1ivRswZWdNZA1GE3wB0IvbM/cdKiK0bN64WeNxou/rPRnKhepz5Gym+37ail3L32L8AJAahULojWyj2hynQk01EC2g7UQUg4K2ZO2BCIxmicDx8pl3yPwfmsyDb9FaqY3AshZ4NFhS+SVIHKUzRL88ODk3JMbE872ckuTTz4M5U7TIYTCikWJGlJaYr/8Dxm93vDhFpNIaF4mr0LJGF7NCm6vFqY2sPicM0GBYMdDsGCis2vVaiVNeIsE6Uf+/Hww3CPRLRVZigPBsf6hYlqw/p0/xghnx2yFsUSy71xGRTBTf0GGI8VWlUVqcne9TJLK5KgShwzt9Ic5nLZNypr4tEDaWMiUuOjghBJfMm6iiKXilwW4HoDR55ASZFG1A2UIgwep4IDjH/eikGjXiT29VvvxnLONtf4yvvumW72F3qmxMINg0KQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d84ba9-96c5-48c3-9eb3-08de0286b7bf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 14:11:17.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ByiGRNowLMQIwf7X9wKI4tABysbRb6eZm87b1+P4YYvwK9MKtkUgXrurLxAVq1xRHgg13jcfx7YWDFiPz3+bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=917 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510030115
X-Authority-Analysis: v=2.4 cv=P4k3RyAu c=1 sm=1 tr=0 ts=68dfd98b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=AZGmEvpuRkPJR9-iPSgA:9
 a=QEXdDO2ut3YA:10 a=D3diw1zRTmQA:10 a=ZXulRonScM0A:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: bTy44MR4v_iPJfdmcS_RhP9i8aN0DUmx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDExNSBTYWx0ZWRfX7OBsbaaBg3YB
 KNMhO15NbTr61G3e7h0WGlfza/s6Urljk5xQ0snmMnMHILby0y997iYuYwy78PuIgGZZPniGBTn
 3xA1dd6WVtT43l/JI7xUxRZLKlEhxqqLwlUicXn3R439RDRzVSdCJlGBrF1uCdU3f3lfdeXO8PY
 UJs0DkL5vrpLnOHP4jqad7Aj3UIIzYlULouW6WW3d9MHRHlVVXzOiNICG0vju9dyvXIjtXgUbb7
 hkOa4/sPH/v76Em5WkN/+yAq3/XgESJyFtK+66nu/XZdZ+FkUpjT5qIF4IjtJtGzvZGm+gGwPaU
 Brr675PbnFd/oAzKeypdoFLX5KCtV6bXf7A09iw1BbyPkrIWo3g5vEDgrq0xV5pYBauSF0b+cHu
 FeCBkkMkaHpv6c84iDwydi5cqtRMCQ==
X-Proofpoint-ORIG-GUID: bTy44MR4v_iPJfdmcS_RhP9i8aN0DUmx

On 10/3/25 2:54 AM, Christoph Hellwig wrote:
> On Thu, Oct 02, 2025 at 11:31:11PM +0300, Sergey Bashirov wrote:
>> Minor fix as part of the functional changes. The extent returned by
> 
> I'd drop the first sentence here.
> 
>> the file system may have a smaller offset than the segment offset
>> requested by the client. In this case, the minimum segment length
>> must be checked against the requested range. Otherwise, the client
>> may not be able to continue the read/write operation.
>>
>> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> 
> Can you add a Fixes: tag here?
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Hi Christoph,

As author of the pNFS block layout code and the related specifications,
and a frequent reviewer, would you be interested in being added as an
official NFSD subsystem reviewer? If so, please post a patch that
updates MAINTAINERS as you would like it to appear.

-- 
Chuck Lever

