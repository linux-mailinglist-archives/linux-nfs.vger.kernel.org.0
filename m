Return-Path: <linux-nfs+bounces-11919-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0968DAC4FB7
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 15:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906291BA0D20
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61954139E;
	Tue, 27 May 2025 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H4Q4YZA7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gt8M4sYA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671926563B
	for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352519; cv=fail; b=gLVP9bWEWgFslJmelhQI9DMhAypmW+kMqYHfPHG8SoYZLY/b39WbMr9DtzGxi8zPwL/BFc7vpqa9tk3b7MMSK2gKG+yK9oZHBnNtDa0Ed3PMJIuyCJn+EuExcm3fyJ2PxrzLddz15J/NXJOfJif4G0+HLt8L/alXY0bL8D/poOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352519; c=relaxed/simple;
	bh=5cfHeqZm/+oqycCTehZfknCT7cpEb5w5UmA0kEgxl2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KpOR3NfMsf69cT5T0eaOVW96pv5m1Neg+k6Uy0Q1NFsXXBD3k3P2HpiV6JJty0myhiX8ED1dXm4TZ6JP/0A5jnZ83nPqoF92A11FI2wVh3edfccXQlimWrACisxIKaXWiDHIkGPlEOfk2xsuRPdWLssBKt8IOduF3zPqrVBP2hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H4Q4YZA7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gt8M4sYA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCjewp011693;
	Tue, 27 May 2025 13:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Z4wUxI12pZDbysZcOTeArnjRAqy+7ynhAa7nwBG9cic=; b=
	H4Q4YZA7SdF+Pdxm9tAnLFZLbjQQiLCyfGM06Vw6GI9SyAqTQ8slMgfJaK0IrdBE
	IiLUcD94/MvaqIbA6eP4M6Z12MdOeT/rgefnJBgxUP7SbNMgjvTxEo93larmxckp
	v/du3K0163tp6axu/Jzvs1qa5Jhoohwfy6n0TffzItXzjgBfUjIXZQ7275+BPdl9
	lbWJVKXYVlzL5kCoxKzbd42PZ+0wyN0ksz549+2HwVXY+Ex6IRmpYjXbUcC8+n8o
	vle18/Mpgi1fxKev65Be1022VU+m8AW96JTWm4V+ODJyM6n+oX/2JXf8W07FPPMH
	c/ohq+bju6xOFGtoRKzKTQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2peu3gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 13:28:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54RDIi6j023220;
	Tue, 27 May 2025 13:28:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j8ux3s-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 13:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHDfKrgLl0di0sj6rZmi/0g5TyW5I9j8L8jqBFY+EnXcSx02F5up5mS+ycyYqMirM0/iGNKvdVQ1r9Kcxx2Wmderw0XUaW7vQYyHYdvmh2P+/1Vb5FcNmaYd4av8jsTYBQpfzKZsRgXk6GNNfIxdbkAEMDtnyXyFKqc6pIg1r+7eS5K5wvXU/B3jsbCxNYpxM/TjBKmG7zZ8Yp/BbrUm7qAyV6lO7rcL6bC/yI09y43eH7RoVxp9yRcUMHnjwo736J0pq/riNpP7+adOcOWYorO+3CAN8Fw5trECl96tuET4yz0o6Q1uJ9h7yGHO4vy6TINKCj5rx0RAS7gu77553A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4wUxI12pZDbysZcOTeArnjRAqy+7ynhAa7nwBG9cic=;
 b=enbSzTumjR6KoNE1uz5qveqrMvIIqhJQTDeMtdyCLVWdlt2ICgzsQ9vrx9iOt1dVjgSGd48mX48g7Pl/d5TA88CZitgQaytI21qjJ2ZYoaap50P8/ixh3+fQsFGsLaViFaP6jNObRAZJ6dyiGUbu+twRxiiQXEZInnATifbfyC9oguWaVfiHAP6aJ0dgP5oZIiGxla2sABH5jxsIAOVNj9MY5x7WkfOrkm3b/AocHPQKaXtuRLzmvPO7zG4mOOCozdzJTsp3GRJfLGdJyDorr8XKf4Kwuq3+ZZC7eKR8RaIaGLasg7+yW75FVDwo6AbpTMzWGxqFnUlmSCh/nEFuuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4wUxI12pZDbysZcOTeArnjRAqy+7ynhAa7nwBG9cic=;
 b=gt8M4sYAK6IvVxxC6BjHTS5Lbedzp1cJ0t/UK8PAsrEHLFLHpcyH5A7sqC46Tg33YHYKo8gmWSNZZkwC5UKLz84tihada8SUgPIjqERkS+K5G08reCZRWz66/ItjqWMmxrZFCWmBN/qDJGm//ejF5Cntq8NKeYSsWLnvQOoCTNg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5817.namprd10.prod.outlook.com (2603:10b6:510:12a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 27 May
 2025 13:28:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 13:28:11 +0000
Message-ID: <32d35633-ed90-489c-96f0-b19bd94ecd1c@oracle.com>
Date: Tue, 27 May 2025 09:28:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Rick Macklem <rick.macklem@gmail.com>, NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
        Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
References: <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com>
 <174821817646.608730.16435329287198176319@noble.neil.brown.name>
 <CAM5tNy6ZJwSV9tmsyPHDjp3rLVFw6=dhs3ojxORqLNNnurGtFQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAM5tNy6ZJwSV9tmsyPHDjp3rLVFw6=dhs3ojxORqLNNnurGtFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:610:77::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: dda1d773-09b7-4c4d-bbc2-08dd9d225392
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?d01DOVJ0dnJiNW9jVG93MjNnT05YbmpRc0dhSUYzWDZWc0V1TmowUHFib1Za?=
 =?utf-8?B?dTRwUDhrVit0c1A5c0FSQXpVMVBpRG9TeFNGWEFpemVweTNCU0RvaXhnQXZL?=
 =?utf-8?B?YVozUCt2YmlWdFByNEZjR3hNb0Z1K3RxTnVGSW9lVHdZblVZalEzNE82NGxV?=
 =?utf-8?B?dDdPZDdNQ1Z3MW5qdHhoU3A4ZGJDQ3JYeHJSM1NzcDlnVFpCZ0U4N2E4L0FP?=
 =?utf-8?B?T3Uzd05xU1dDN2pPcEVROUpOMjBLL0x5ZjVBSWd2UzZ5NW5LRHJuMjQ3V3JD?=
 =?utf-8?B?YVZrN1FiV0lwNS9UVHVXN2s3VU9QdSt5VWgyMVVld0dZRlpibnEzMjU4YTZh?=
 =?utf-8?B?V3RudzcvcDY3L1lOWUdPMGZ2Kzc3eG1BejltSFdRTldaa1F5YUUxaXloSUhk?=
 =?utf-8?B?Q0JLWDVNVVNEdEQvQ0hKby90V2xNb3hNL1JmclFkSzNOZmZsemNGR1FKZUlH?=
 =?utf-8?B?TlR1bHYxd1RTbGNWK01oSThWU2RFckJIb3FTQ0E5SE1CcTU5dU4raVJqWmlk?=
 =?utf-8?B?dHhwWlN5T3gyS2NpRW10c01pd1hOTzIwRTNudmpHbTZXR1FxaEFLcUpCWVRs?=
 =?utf-8?B?dXRDNDR2bVVLK3VJQUUzTkVFbWNzLzBSZElDNkFQWGVSNEFTckU4Zk1ROEdy?=
 =?utf-8?B?Tk9wYWpRVi83Mmo5MG5Kdi9OM3BlWklCbTN6M3VIc2crZGdLbkZva3dUbFM3?=
 =?utf-8?B?ZVVwYm4yRUNHRVJjRXJlWHJOaVpYbStEUG9PMDA4dmFxQnNCZDNrYXVub0l6?=
 =?utf-8?B?aHUrK0dpTmU1RlkzMmkyUnhacktybWhlR2xZS1p1Nkk3U2dKNEhOL1B2MXdq?=
 =?utf-8?B?ZlFYUXZZeTZ2WFpEQm9pZ1N3bUhKZnV6TFNKSUZxOERqZ1dGWVFEU1Vpa2F6?=
 =?utf-8?B?SktnYzFEQS9YYWRMQkxFTGEvU2Y4M1ZLQ01iS1NFR1AzVkI5SjlwUWdZMUhW?=
 =?utf-8?B?aUxkVmptLytHTVQ1RGdsVHpveWh1bXNQSlVNWlJoN0hQUWVBTUtVSEoyN1lj?=
 =?utf-8?B?Sk0xV2lYMEtUekRidUtpRTVtYVFPL1lYVnM1d3NpOTBhMlNHQk56NExleFpI?=
 =?utf-8?B?ZHV4bE5jOEtaNmlBb0lFbFNXcXpvZ1EyTklKSGNhVy8wY0VGTVlnUVVDd0hu?=
 =?utf-8?B?TS9ZS3hUMFRLY2d1NFlOSTdzY0w4TU1Sbk5IK1NabThGeG12ZjQxWGQ3eGJ6?=
 =?utf-8?B?TldiN2IzcE9nb3d6MktXcVZvalAzbWUxTUVES0NUN1k0dTBZZGZLeFJjcWRN?=
 =?utf-8?B?TXVjS0VmcUM1REVrMVcybXVxUEZvaFh4eE1OOEc3OVlzSkdYRlVqK0NxWXVv?=
 =?utf-8?B?dE5iWFV5NzZuRW1RWHpRQldidDR0TENHTGd4dEwydEZpeExlaU9YcnY0UFlP?=
 =?utf-8?B?WGlHOVBzOVlQWmw4U2dRQUc4VXJTYitmU21xOEpjcTRwajFTZ1BKMDdHRDJX?=
 =?utf-8?B?UVpHSXRtQTRlNGdqQUxTSEw5ZzlmbTdzRmtSUXQzUnVQTndSZDZoMnhRZHVy?=
 =?utf-8?B?WjBqK0ZYUlJHVFFDWGRKcHRGRTA0SUkxeVdKNTlDYjkyczZPRTlvN3BzSTZK?=
 =?utf-8?B?OHBQODJhdjNEaUFVR1FLaXJjU3J0c3FlOXhxdWxxOTlkZmxyQ2dCbzdycW9Q?=
 =?utf-8?B?a1EwUkdHend3R1lOMC9PMVZ3K1haOXRRRmF5T25LcGJ0TGJiMy9sZzdXTkFa?=
 =?utf-8?B?bzdHUXVUTHBqcXQ4RStodU0zQXFrald1VUc3NTRFcUFVZVkwYW95TWt4VGs2?=
 =?utf-8?B?RWpCS3J0a0ljWm9leDBoc3NaS2VLUm80K2tFdWtWTlErdmlDMmY0UUF5UDI4?=
 =?utf-8?B?VnNJaE12L3NOSHYzVkdLS2JJUXVuQXNJbGNEdVc3N05sY0tSY3VWU2FKK2R3?=
 =?utf-8?B?NVlsMnIrSTFTd3NOS05Rdnd4dVJKNk1LRkd5MmJjYlF2TWdSRjF6dUtmYkVo?=
 =?utf-8?Q?5ZtRPP79bJA=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?M0FtUi9weXJWS0UwbHJ1bEZDR3d3OWw1TzR4T09BUGhOa3QyeS91NGsrUWcz?=
 =?utf-8?B?N0hqdFdHR1NQZU9PTUNlUWJId0ZQd3F3ZGx4bzNvelFNYnI2SGtsVGk2NUVv?=
 =?utf-8?B?bWxGUlM5bXRUMnV3eDFNdjFaL1JCd0RMbHJCVFlPeGlnZU1FelVHdis2cVQ3?=
 =?utf-8?B?Rit4WnNEOVRWMExnZk9ZeElla3MyV1lpcXZiL2lOVk1iZjYvSkZlZSttdi8v?=
 =?utf-8?B?aDQ3OUxQZVI1VlBvUGMzK2Z2UGhVcjBOenN3cUF1YnRmNmlPdk1VQVVZWmQv?=
 =?utf-8?B?K1kwK25vRnMxaFdoeUJjTHROMjIrd3RVYy9qWGl1Z1UrVmdpNzY0TkpTZkNk?=
 =?utf-8?B?TkxZeEFyMFp0U2MvUXBBUVJLUU5IaHhoVmhvYVlUdVBEczRZek01U2RwQjZB?=
 =?utf-8?B?bXpsQzdOVTdiYlUycXFqWURkL1ZramhScUF3OWs0cXZXMTJNZGFxY0wyemx3?=
 =?utf-8?B?TWMvWXlIN1lHRFFxQUtXR2dyN09kcTVYU09vcnoxNjdBWVkzb3l0QlFrWU9p?=
 =?utf-8?B?TmJUdkcxUmozeGNvR1d2dzJSTElzZlVoRk9VaVNxL0hjbnNqdndCdzhJa1Y3?=
 =?utf-8?B?Tzc4Q2xoRUxKOFF0NEZLZGlyZEptTDlBS3hWd25RbTUvck5PMjNPSVgyNjhM?=
 =?utf-8?B?NHMxN3JReHpZSGZrSUZISjRaK0owMzl1M2VjMGIyaWwxR1F0Tm9VbkZjaW92?=
 =?utf-8?B?aGhIQjg4d0U2emJlUDN2MzRqOEh6dDBiTjhWSFRoREY3VlIrVTBhbmtMQ2o5?=
 =?utf-8?B?VktxMFhjSWJFcUs5U2t6YlJmL2xCM2Q5MEJjcnlZT0lpTlhxcnNnUkl6eVVP?=
 =?utf-8?B?cGsxeFNjYllORkdKSC9jRkRPdFJPTkJGdjR0OGtMSzZKdE9qbkpzb3QwVnVD?=
 =?utf-8?B?b3RpRUx0Q3NGTWdSTkpncUEwT2VKdWJNa1hkamRUUWxHR1VJa1l5eldNdnZV?=
 =?utf-8?B?RjlxTno1VWZCY21XQ1VuL0JULytDMUt2VmwxUHJVYSt5SXlFaTNjRkRmaG5P?=
 =?utf-8?B?UTNaKzhpV2xyRXJHYUZQOGQwZEVPSkVDRjhBMFlXSHQraDdLQmFBbGlyWCs0?=
 =?utf-8?B?Wm9WSzhVS0VhTWx4a2dtczcwYjR1NFEzTEEwMWRJc1F1UGpERFBlZVZNV0Jp?=
 =?utf-8?B?UUc0bTFrbVc2RDJhVFpYcnFVQlJJanRQVEdxV3dIQUpEZ2c2UzNyUUFvaU9T?=
 =?utf-8?B?bDRUNnFlaFBwSklHTTVJZ2JXaGlUU05iY2lNL3VkQnBFQ2xQaDU0bG9QMkht?=
 =?utf-8?B?Q1F6cDRyRDNLWTd6aHNYZ2hxRDRNU1A0NWhxdnZhRUtzcEE2cDdmV0xPV2dn?=
 =?utf-8?B?MHlFTUpJRzdwNHEyVjBlSHhQRTNNOG5GRXhEREdUSEVPME4zeU9jK2hwQlNa?=
 =?utf-8?B?K25ucE5BNlBKL0RySE5GeFNxTHg1eFlqN0dYQXBET2EvRVU4SmJiY09hNFpT?=
 =?utf-8?B?TC9OYnRYT1hUTE9wUkFxcG1HSGE1dUtpUHlWS1ZlSzUyYVNVdUQwckhhVWRI?=
 =?utf-8?B?UHlsbmdqcG1zalptaVl1N1dTZDZGVGpDeENJL29rN25VSy9IMEhORTlCeVkv?=
 =?utf-8?B?d25ReTFIcHo0ZGZRclRxbWt0SGZMVDg0K2Z1MFlPa2dmemN6NEF2ZXhoQ0dL?=
 =?utf-8?B?ckV4M3AwTnVaeVhvZ2tlWndMNWE1aDhxZFRoNzY5SGV6N2Q1MGtwQTdLc29S?=
 =?utf-8?B?ODhITjRtM04zMlNTVVhwQm80ejlYT1NGR1YySTlaeG4rVWpiaEJnMkdSLzJB?=
 =?utf-8?B?NElUbXk5UmFOYXVNNTZyNjgrV2IrcXFBYTRreStndFdJdkxkZVZHZTVXdzlC?=
 =?utf-8?B?WXFEZG9zRVBobFNPN2VUUkJtOXNhRDRiL2xZWStrQzlQbUpFYldRVzdMNk9p?=
 =?utf-8?B?QkwxRnZldFVxTW5oNmJzbW1ybllVQmRvMytvMzVlNFBXUEhjVHh0NjRHeG9a?=
 =?utf-8?B?UVpiczVSMWJMQ2R0YUl4UkxNeEUxWlpuMGRpK1FSSzdwWExLc011bm9aQXBY?=
 =?utf-8?B?Nyt3SWc3T21qVVBkNFZON0wzVlRmK0N5YldKT3VOZHByTzdzQnRTQ2Q5aVVX?=
 =?utf-8?B?Zjl0Wjg5TWpxUkEyU3JwR1pOWHhXMlFJc0FNeFdkN0t4Z2ZORnpBRFhYeUVp?=
 =?utf-8?Q?XSKxSOSOKGN/+ehxbcuB/AFRw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nf7uHDPh4YY3PpZ2bla6nHpUaIjilLmYRTWbqd6dxRsnPzjP60oLH1sRXjb+KKP+ZVmEZX6DxMrONkV8r5aEPVy2MarJz86ZzELTHuA8ABSAKivl2crNUU5QyFofBBPFRfEVytqr/LtafooLflTOrwzQ41kMIFEKMe2lEHMMRZ9uOsnB5LMK5j3EPLvrYcwACb5pXgYxdrIum+y0GaYt72WOtGpqhqkvR8cXmKJb6Q7MHVZNLFffIo9TOj1h+akMN6NqgTVpaylUVM6IdKcS5sQYPHCf7ErUl5k0B5EU8NGJ+RXtZwbIw2NafVPErMvpYWFrPnTMzMelqZWgTV/OndXWCtXFvxzGLgKVZFuLy5pzu9NfbA0r4SxxHo+zzWD3jAh4NoYAY7Me3HBXWpWZG/pIF2aa1ogYNDethnAd8FKntEGl33dXF0jzHWuzzhfkswyNCmmIBE0Jc1J1mFZfKGTdF7pJ+cb3EUU/pOOagAsO+7ZtWiSlteRVPRJ35+bCDdJ+lhQ3q/TVT4xONdbnp5yovaRdOI+NCePIwt9uIqzqXo0dc3Fu2kz7jHUD7EDreNSeyhyve/CqAgd0w7HePQqhtbNiM332+/G7C1yeKFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda1d773-09b7-4c4d-bbc2-08dd9d225392
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:28:11.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQOJ0NOdUs71nxBc4KNYVhrRTyS0IoJBLaN2J2bcUZvJK2hJ3kVvoa/JUN/53dncKpDNCb+O+ZpNFZHWXOR+/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270110
X-Proofpoint-ORIG-GUID: YxaU3M3r5cla8ToZgm2XdZ8xGowsO1D4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDExMCBTYWx0ZWRfX+ZGcI4eLHvgc q3UhdAsXNOgZ9a6+EG2ISskjNUX5uKRxwz5jJj7cLUIvZIHnHUf/e24yutaFr1zhfZ3GO08t/MJ 6eq8JeQrntfTZZc377fC8gMpEBXXeDcdC94a6sWYc6f46S+KQsc3msZkDTiKirjeaYGVLlnWIfo
 Z6VbCNOaNFbzZDKw1jETYdjWSL967qKUGXX7FL/bfhGlmXIISBQdrn3tIeJGMxUHgTfmmQiXTC4 8zsnekMwv/p93qaxVEJaP74LagGqg7xIYbK/QYOGisyxVb8djYl6yyT/CzWfnuvdFO39OAjYgIx FRNEj+NxxuvUU2J8HhHqCi5lFVCiHtMfMMGo8n7g+DT6CHMIrxRKrbbzGMQqrE7Izba3oTiikpm
 alVgEMPr9hPsX0d7NOHk0p+ijC9cfaNoNmevNz7N8DTnkmnopZLp5ktawlRGCXA6Jvah3+8n
X-Proofpoint-GUID: YxaU3M3r5cla8ToZgm2XdZ8xGowsO1D4
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=6835bdff b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=A1X0JdhQAAAA:8 a=0qbNhFydd_yygGaPRMEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714

On 5/25/25 9:47 PM, Rick Macklem wrote:
> On Sun, May 25, 2025 at 5:09 PM NeilBrown <neil@brown.name> wrote:
>>
>> On Mon, 26 May 2025, Chuck Lever wrote:
>>> On 5/20/25 9:20 AM, Chuck Lever wrote:
>>>> Hiya Rick -
>>>>
>>>> On 5/19/25 9:44 PM, Rick Macklem wrote:
>>>>
>>>>> Do you also have some configurable settings for if/how the DNS
>>>>> field in the client's X.509 cert is checked?
>>>>> The range is, imho:
>>>>> - Don't check it at all, so the client can have any IP/DNS name (a mobile
>>>>>   device). The least secure, but still pretty good, since the ert. verified.
>>>>> - DNS matches a wildcard like *.umich.edu for the reverse DNS name for
>>>>>    the client's IP host address.
>>>>> - DNS matches exactly what reverse DNS gets for the client's IP host address.
>>>>
>>>> I've been told repeatedly that certificate verification must not depend
>>>> on DNS because DNS can be easily spoofed. To date, the Linux
>>>> implementation of RPC-with-TLS depends on having the peer's IP address
>>>> in the certificate's SAN.
>>>>
>>>> I recognize that tlshd will need to bend a little for clients that use
>>>> a dynamically allocated IP address, but I haven't looked into it yet.
>>>> Perhaps client certificates do not need to contain their peer IP
>>>> address, but server certificates do, in order to enable mounting by IP
>>>> instead of by hostname.
>>>>
>>>>
>>>>> Wildcards are discouraged by some RFC, but are still supported by OpenSSL.
>>>>
>>>> I would prefer that we follow the guidance of RFCs where possible,
>>>> rather than a particular implementation that might have historical
>>>> reasons to permit a lack of security.
>>>
>>> Let me follow up on this.
>>>
>>> We have an open issue against tlshd that has suggested that, rather
>>> than looking at DNS query results, the NFS server should authorize
>>> access by looking at the client certificate's CN. The server's
>>> administrator should be able to specify a list of one or more CN
>>> wildcards that can be used to authorize access, much in the same way
>>> that NFSD currently uses netgroups and hostnames per export.
>>>
>>> So, after validating the client's CA trust chain, an NFS server can
>>> match the client certificate's CN against its list of authorized CNs,
>>> and if the client's CN fails to match, fail the handshake (or whatever
>>> we need to do).
>>>
>>> I favor this approach over using DNS labels, which are often
>>> untrustworthy, and IP addresses, which can be dynamically reassigned.
>>>
>>> What do you think?
>>
>> I completely agree with this.  IP address and DNS identity of the client
>> is irrelevant when mTLS is used.  What matters is whether the client has
>> authority to act as one of the the names given when the filesystem was
>> exported (e.g. in /etc/exports).  His is exacly what you said.
> Well, what happens when someone naughty copies the cert. to a different
> system?

When that copy is discovered, the server can use a CRL to fence the use
of the copied certificate (and as Rik T. pointed out, NFSD does not yet
support that kind of mechanism).


> --> It is true that verification will show that the cert. is valid, but is it
>       valid for that client system?
>      (Not checking the reverse DNS name makes the check somewhat weaker,
>        imho. Now, is having the IP address in the cert. and checking
> that stronger.
>        Well, maybe. The hassle is that the certs. all have to be replaced when
>        some network type decides to reconfigure the LANs or move the system
>        onto a different subnet for some reason.)

None of that works for NFS clients whose name and address are
dynamically assigned.


> Another way a cert. can be protected from being moved to a different client
> by someone naughty is adding a passphrase to it (the -aes256 option on
> the openssl command line when creating the CSR). The hassle is that
> someone has to type the passphrase in when the system is started/rebooted.
> 
> There is no perfect solution (or security is not a binary value, if
> you prefer), so
> I chose to provide as many options as I could, so that sysadmins could choose
> what works for them. (Of course, they need to understand what is going on and
> documenting that can be a challenge.)

Fair. Our implementations might differ in this regard.


> rick
> 
>>
>> Ideally it would be more than just the CN.  We want to know both the
>> domain in which the peer has authority (e.g.  example.com) and the type
>> of authority (e.g.  serve-web-pages or proxy-file-access or
>> act-as-neilb).
>> I don't know internal details of certificates so I don't know if there
>> is some other field that can say "This peer is authorised to proxy file
>> access requests for all users in the given domain" or if we need a hack
>> like exporting to nfs-client.example.com.
>>
>> But if the admin has full control of what names to export to, it is
>> possible that the distinction doesn't matter.  I wouldn't want the
>> certificate used to authenticate my web server to have authority to
>> access all files on my NFS server just because the same domain name
>> applies to both.
>>
>> Thanks,
>> NeilBrown


-- 
Chuck Lever

