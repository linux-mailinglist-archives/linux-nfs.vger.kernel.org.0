Return-Path: <linux-nfs+bounces-13861-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F23BB30813
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 23:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B076400CB
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 21:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48B42F362A;
	Thu, 21 Aug 2025 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XQn0u+9N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iK6S/2mv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6A2F3626
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810085; cv=fail; b=aUR7OgqZasj7/8rDScG+N6qHuOMvlAqhSoHOfpep/VaGrAgODtRoy/OUbyMOoVNARt+YAcE/ENRuarRt33UlX2SU4NwqsUgYtGGh2oMbws5ossfQpNIBXdnNCul+olzZPQoGOpMRZLkYFf7MXDwykoeooMZlmdCizGI/5kBvqxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810085; c=relaxed/simple;
	bh=tnLd6X8sLN3QNOS3c0WZI3W1Dpm3os/c3g7pyNjDUwM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JWvDX4fNApg1TE9BqGsho24cgvi+j5jZ0F75D5rpAV8+0n1d2Aotg/VV3M9ANAvqkFkxtKf2oxBJXFXx9k8psX3oWqBA8jcBSKguCG0bowAMna2W702HfMWPptJ+155ImtktxEHvAmi0tF1XsGB9oW9gxCv1hemeYnPYuU3L/Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XQn0u+9N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iK6S/2mv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LL0t3Y003505;
	Thu, 21 Aug 2025 21:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4jt/xAVEZppDPjgwOzID3DTvKThP63Jfba6H+5bP5WM=; b=
	XQn0u+9N5DZio2yi0TaXMzFldNitmxsrkLmB3+okUwNpYXkOPCAJXZOSlRGVR4oL
	ksFLzoGSz/1V7ZbDywVHIIemOnIIXOJ8iPsl/uH4TMPiVgzuoDffRPPyRA2gvgSm
	1zWXYOCuSlGQrIs5Bu0A13a35wBLzmD5aMmqvStB6hw2Q8DynEfTsHsuqQIdxl4Y
	uGTZ4a7SzKKawh25MuiVvmc3pwQLoFYXVrwbluYKcPb9XR5i4SBSDXiUvEK244f+
	Ngz7cjTt+JGtGvzLuT1hi6rtGqHKne8UEfsfpWhfxFLjjcioqZr//cJx4CcofikK
	MqGhGO2L+PAQEA1jkyD1eQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tscegj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 21:01:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LKSTtU030267;
	Thu, 21 Aug 2025 21:01:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3vw6ue-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 21:01:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAkD7quOXCqIpCLU8FQBr4tPnaQ2CzpW6OeGfdnYZ3cF6LdAoB8HE5vRzLVFJyrTlhxefZvr0lNjcL+83LgQhG5l8K64Q09tjQoBC+i400Wk7sYP6ajb4TdB1Zdvt6sxeE0DWGj0JUmbpuFJ9yIkyrJGziC+RDoP0SnIhDdROlDFrCmQ0HM5XlRIDcKsBnnvlYrXAOPx35TjJ3/Ri6gQLXz5Kts3D7vPKaF8tbcZvyWSLb/dfW8Z22QQhMYSECv6hluqQlnqKV/2koL0MoaviNGfzLIh45ssMQorAHojwWs9Nh4+X/xlYNhWm4oYKZcmaLrbJjs3+0NPglV9wBONqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jt/xAVEZppDPjgwOzID3DTvKThP63Jfba6H+5bP5WM=;
 b=QrUIeUXrPwx53LqODULPc7cgWKkhi9nOiZ4PGgtvG35lcc7t4lzXmL6OOWxnYdm6I7es0xMdJltKZqOUBQ3En7L38R49IjIT1K1KB3g8klnEacEFXxl1m/rxTc4Es+7Rpacs7VQcyXpgnRC7OOeMGGmO1j9UG8NmwSlsEhQHoQRdM9EZAjYV5TyIzF6hOkvVW6qFNqaFrl9Pm3RB1dfvVKDcHwsldONvu5J92Cx9sf63eLcdvrVRAaPAc3gDoWMIQ/gpI27184P22/i/eTiXAHG+eIm5yO4Q398ulrPWx58P72PiqfBktwbMdS+G4bCpwVZg51C2Vt8WOz9A9b+rDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jt/xAVEZppDPjgwOzID3DTvKThP63Jfba6H+5bP5WM=;
 b=iK6S/2mvat0HBici+gI+U9H5a3+83r/BcPtrHjxHzyUUh8HGQlgpABTUZlqW42faTlKpYvJEfpA2ZdUdk7j99jYg6FMyGt4c1FQg1v1qmhxegCM+okCfOzD8b+/nJBDRiB0tRWv1FveKliqMEPt3BIWVj24paQqVxgeiAj3VhBo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7241.namprd10.prod.outlook.com (2603:10b6:930:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 21:01:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 21:01:13 +0000
Message-ID: <ab55513a-fff0-4907-98f7-716df23a1bb9@oracle.com>
Date: Thu, 21 Aug 2025 17:01:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] nfsd: delay re-registering of listeners after
 listener removal
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, neil@brown.name, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <20250821204328.89218-1-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250821204328.89218-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:610:4e::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 92caeee4-e07d-4c25-586d-08dde0f5dc90
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?T3dYd1FBQ0s4Q0xuUzVHdC8yTXpsQXYyWXAyWmtSUERGUVYxSFNDMlhTSVJD?=
 =?utf-8?B?NGcrZ3FSTm92dFlRM01IampoS3ozOTZXOHVma0Vhd0x4OHRPbkdhUk4yRk8x?=
 =?utf-8?B?L05oWXFQSDBOZmlZWDkzTkpZQ1Jjem9UU3F0MlFlUnFtSnRkTlNzYkdxMFMy?=
 =?utf-8?B?Q01MdnVsaFBnZFZJbC8vSVE2R0g2azdnaG8yc1BWeWpRQ1ovOHljT2N3S0ZD?=
 =?utf-8?B?MzlWUEdha0ZnNXZDdWQ0Ukhwd1RlUzdDMnhhWVZMc0ROVnRHblFsQUUzajFj?=
 =?utf-8?B?ZHR4aU1uYUxOUTIwbCtmRklvTWJEYXhzczZibUhTTzNqTUlUYmVDQTlmWEwz?=
 =?utf-8?B?NldnUTZFd2QraENzM2RhZW05QnNhODUwR2YyVy9Wc3RKM3Q5cWNNMEU1MUZZ?=
 =?utf-8?B?bzlmaVhPckxHTWNzUXFQZ0FzSWJnWk9sekRtOW00cjdYL1B6MUJraEQzcVZp?=
 =?utf-8?B?dkREc2JVdE9kVzhGSFArWFcyTnN2aU45Y3JHVnFpQ1V4amx1c1FMY1BkZlpm?=
 =?utf-8?B?Y0hSc0FqdHFHaC8yVlpSQy8veWowV3IwR0RKWnhaOHJGNmIvdnBGdGRyQ2VD?=
 =?utf-8?B?SjY3bll0N2VsMGxtQzdKWHpXWHU1Rm44L2JIT1cyaUh6RjRWRDFXUWVuMGZw?=
 =?utf-8?B?ZVU0MWFUb3A4d0k1Yzlub0Mwb0laaXdQRU9PRlQzZVgxaHlGU2FFMm1pN283?=
 =?utf-8?B?UGlkbVhXazNxYWdza0p2WHNtQUg4UlRjbTd2RWM4K0hndEw1cmJxbFYzSWFE?=
 =?utf-8?B?a2M4M2xwc294aGl3blVFRUxpTmRIcndXTkNmNTErRkt3dXZrKzByUWtCQ0Mx?=
 =?utf-8?B?MlZoV0gxVjQzWDRGWkZqaG5pd2NZS0d2MEtoZmRLSlVWZXdIbWMzTEwzQUxy?=
 =?utf-8?B?amNWK0xuK0FIcFpIR3FHVXN3V294RkpocHlZaVJRZ0lpSjd0OUdjRG02SkVV?=
 =?utf-8?B?NEhWTStwL2g3eW9Zamhmb25nRkVMbWtMcEhQYjdlZk1qQStHV0hGUnY2bFM2?=
 =?utf-8?B?WkM2R0xpT1V3cUZvZmQ2SzVGWWpWNTRrWUdyL2hGcUpRcGVMUW5BTnkzZDVI?=
 =?utf-8?B?R01EY0REQkJDZStFRlEzRFpydEF5Vm5UcXhRWkY5U2U2dXJVSTEyL0NLZ0dL?=
 =?utf-8?B?TDRkaldPeE5QZVZaMUx3VUJUOGpFQTBvejBBZHdCK2d0YXhiTzZSREdrVGw2?=
 =?utf-8?B?S1d6UkhyNUEycUIzY1grUWswbzZtUEVnNGZjdGxEbjBOVC85MU9sallFTzFw?=
 =?utf-8?B?bkROUkt0Y0F5Y3VBMmtKYkxwTDNWRTZDaUM5aUxtWEROclNWQk04RWo2NU9i?=
 =?utf-8?B?ZURlbmVFMXZSQ0lCRjBoRlhCUUhKZFd1MWtPcGoxY05IOW1MRDBxaDlseTJG?=
 =?utf-8?B?U21TNFFuQXYrZHNkSFh3R2J1ZUM4d0dxMk1Lck85eG5sdzJEOHRucWFwdUVw?=
 =?utf-8?B?RW9RdVpmWmMrdUl5VEZlay9FN1pkelR6cjZVRU9Xa2tvd3JQZlNnaDBRNTNX?=
 =?utf-8?B?cldxUy9sdTNPS2pKWnhCZWNzYTdxbWpKYXBvUllMaGNOVTllTTJVSHU5OHF4?=
 =?utf-8?B?WVNxaHU3azY3MTNraVdqS211V3hFRnBnbkMrWTJhZkNCSERvTGhCT0dISkxF?=
 =?utf-8?B?T0VtNi83Y3J5WklPSkRPSVBRazk5SU9RZWRkTlE1cklXcmZrQXkvY3c0WHJ4?=
 =?utf-8?B?UUVvNWM5UHdSMWt4UGY1b25aOGZhcmdka01UbkQ3RndocVpyRkJQRkZ2RSts?=
 =?utf-8?B?MWtvN1ozUkZ0WVlpMk9EQjdFdjhZV2E1aEJDbnJyenNmdlNEc2s4VUJVMG5l?=
 =?utf-8?B?TythS0NsWjR1MHE4d2t1WnNqNWJXWkMwdkNaa2NadTJUQlBob2tvcGczTE1N?=
 =?utf-8?B?ZmlkbkZwSzNJL05DMFk5eEJCNm4xWVIwS2M4Y0NMclgyR2U2Vk14VnNheTlz?=
 =?utf-8?Q?3w/0HILypQE=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OUJhUDVnVHBYcUZEbG4vSnYxUTE0UlNhN1ZmWmxia0V1dkJuWWZKMWhKODZ2?=
 =?utf-8?B?UTVGOTErcW1jL01wcEdZaUFnVEZaMTJLTWxmTm1xWXgwRDJvbENQNnE3aUEz?=
 =?utf-8?B?ZEpoQm4wNTRWTkI4azM4M3Nia1Uvak1LUzhlaFlLazFEdVF3K0U0aUlTWi9W?=
 =?utf-8?B?REJ2Vzd4cnVzakVLSjVJSU91M01ZVWlaNDgxc0JZbm9GeUtoRDFDdzFKbWo0?=
 =?utf-8?B?R0d6cWI2Qkl2ai9adVJSUzdwbmlqalhndEE3VjRiSjdJQzJHSm1va2RlSXdn?=
 =?utf-8?B?VFIwMGZBWTdNbm9IVVNVSXVMNWhPWjduTGlRMjJpQ2xjRkhyR3ZRYU5uNE1U?=
 =?utf-8?B?V1pxS3JUaGRzcnhNTk1yRzE5YzNBOFV3SUcva2FrMktJQjdjVU0xYWpJY051?=
 =?utf-8?B?YVlNL084SUllWjYwUHZlU2VvOGN0TkU0TE41dDVGM0tuZ2xNbkV5Ympqd1Vr?=
 =?utf-8?B?ME1jSnM3a21yUkZHWXlIWnFLaVQvY3RmajNUbDlsemorZTd6TnFzaWJXSzlI?=
 =?utf-8?B?VzdvUmdEb3J3R2Uxc0xLK3pJMk1yemlldDlMVmoxaTdoOTN6SDdGL1c4SlZm?=
 =?utf-8?B?WDY5eFB3akJjZit5TEZlZDVxc3hmWWpMTi9zaHE5UHVoODR0ZmtyK1h2UG95?=
 =?utf-8?B?cTRIbjdPWVZ1ZU8vakdFcEpZQ0VSeVZibm5SRjhpLzdaejFWQWg5YnNybWFU?=
 =?utf-8?B?OFc4dDBJRkxnV2dMcXQ2ZFJic2pUY29CWC9UWDc0dEkxVEU1M3VZM1IzaThK?=
 =?utf-8?B?UHlmTVU4eG9RaU5JU0dMY1kxdUo2TkIvejhRTVdJblp1K0JqV1VVOEJWK0pC?=
 =?utf-8?B?NjVXS013UE5vV0pubC9ZdXY0aDdWWjlrY1J3OVUva2xDODRFQWMxNkpqWVQy?=
 =?utf-8?B?eFR5ZUsreCtBNXUvZitURXNrRXJQeWJDMzlBYlFUekNvbW4rYnREMUZ6Kzdz?=
 =?utf-8?B?bE1aZ0VxTUMxM3gzU2xxUFNvekE5dDdjVnRmVCtVZFVoMnprTkJzYWtNL25C?=
 =?utf-8?B?TERHNUxGMkpzaUNHSmdiTDI1a05jODVvSFNUN0g3UmJ2T3RiazlFU2diWTdt?=
 =?utf-8?B?akJTU1QxOHAva3B6YXBweTdONWFReFVQSlVyY1JyTXZrTXJ1OWkxZlNTODF6?=
 =?utf-8?B?WndWRnpaVEswZERNUXFWWVk5RXdOSFAvZVh6NURvMDVJSGMzZ3lwVVUyV2VU?=
 =?utf-8?B?YzZGem5rOVBoLzZaTHNUYjlka1RydzRSbys4Z1ZGR1ZORC81bWJ2bWF6aEFY?=
 =?utf-8?B?VTU5MHFwM21hVUxpZjcvcG9tbVR2NmZOamd3bVlBTzloaWgvK2pvdnVUWmxr?=
 =?utf-8?B?UXVBQ01yU0lGMUg0Y0hTLytoQUNDU2ltMmp2clRHSXFtbmZoNGpETG5iTW5w?=
 =?utf-8?B?THB0TmswUUVVVkFtZjkyL290cDZDZWp3K0lpeUp1QnFRU1BoSlhScU5qQk1x?=
 =?utf-8?B?eW8yNk83RE1rSklLSnZFNStGRGxJMzRLY1dhQTVHN3p3RzFvL0F6ZG1Bem1I?=
 =?utf-8?B?eGdmY1VhYjNTWnpJVGhTSjhvaEg3aHdhbWV6VThyUVh3cjdMc0dhY1hFeVd4?=
 =?utf-8?B?UGdCcURlUFFNVkNJME1vTktSRFJHbTdJYkZYdGJMK1VjTEw2MXgvWmNpRGlo?=
 =?utf-8?B?UzNlRGprQklOUEpZdkVWKzJlcWxNK1hTUkkyMzhBenIyK083RERSNGpnYXRF?=
 =?utf-8?B?QXU3TXMxZ3RBa0ttMlBSZ0pwck13SER1MnhyQWpMM0xyRHN4Q01icFFKUkVQ?=
 =?utf-8?B?NW9ub3F2V0FBQjAwUHIrdUNxUFZ4SkZQWHI2azVvdVVNL0ZiaDg4YmZ5djNw?=
 =?utf-8?B?dFozbU02UlJid3lMY2dTZVE2bXVrRTV3N08rTDdabmpYTEZnWTBxTXJBM1Zr?=
 =?utf-8?B?WWo3NTZPU0I5R2F6RmRyZ3JkQVRwaCtmaGIvZ3J4bEJIclJHSEdQYUF2MFZs?=
 =?utf-8?B?NHB1b1k1VUk4ektvTzBxaU00WGZVQnlzWURoVXpJZEZtMUl4UFgzZjgzdnJm?=
 =?utf-8?B?Y3I4eXU0bjRBckNtS2ZUWHBCM1VkNDhCcFVCMm5DRG1NZzFCcXczdVloNzZv?=
 =?utf-8?B?L1k1aFQ3NklVM3FBazVGd09JTUlIS3VWK1pwWjF4cE9Qb0JlUG5BKzVBb05n?=
 =?utf-8?Q?yv9/Q/QdDyB8Ceoc7g08NK3hu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4uFZVZ6GMST0CJBFR4kzWr0JS46eo6zlFVcSnJgXoJMKErxgEwKtMcGEJ6CBA1H2mwPiImJ/qQqAaQ5uuT3Vlt9JB8lXPp8asp+Jtj9L5eXx35kS8SyU9RVwW6J+L2wEnuDrVbBjRKSUuH3jIGvx0+iFThpbJfgCydyzGu8tbmHVzy5TTsyGqAk13a8+La3ZqsxsknJwDTbTcnBhL7zYPcFKuH7cbogub+zlySnNArWK75tTjTYwKa7BjTL2q2hGSddtOaO+QVPpnaXjpTvLTozPVMVam1ggV9X6MUKJxGb+yH/UCxII4E0tIDNAd/52scZiQhCMbzf6MubDNWTzWEZDjSeXSdNlb/0gYk+KIbVT91N0QbSC1tLbSPKvTdGU+h39PoVe3BnEzQ8ez1jN8aM/1j9uxHekobtiJH6g+DtQYs8LT3n1qtqPvdbFMBVD/v0cF0lYQzIrM9Pu6E8kqlI7wxOYavT/dwHSTQHUNXCfr/yyJW5JX/7P9R77sjYXiUQTq5eceNh/pw640euycmo9HEmfBwrgYjrjf32kJH4r7R8FLX/ffS+7JipYwl1etfCWhMpe3ysUfwZ08h+x6lzyJdX/GTvwaNkD+OzEFqQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92caeee4-e07d-4c25-586d-08dde0f5dc90
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 21:01:13.0388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/xwpytGY1+4sUWDnM4shlEiIbK4by/jOP8SkrCFrsy0v0i7azW0IT5QgF+cNB09jhe440GjqEVh9B8Ai0qwaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508210179
X-Proofpoint-GUID: -_i9RG3VStTm8tP3xqZ1dsU6lrFnNwfN
X-Proofpoint-ORIG-GUID: -_i9RG3VStTm8tP3xqZ1dsU6lrFnNwfN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX4CYPun9mV9tR
 111faXxQDeClphEtZJHv3YMvfPttAdu6SdmHePIAPAfJU5G+Vwzwk+4U+MuynH73P45QhvmVSB+
 arC/eV0cGQpeTBCqxdBKGYclkCP3Gja+aAQYo0yO6hdXMUaSHu+6AqU4mBz4OnZ5B8US9gWBDIF
 xmjFOzgFM1PCr9oQxm9k4FFJYetQzyXd/mDWMod9vhj7vglMog3vumHqtZEIxqxvRcluXg+bVWR
 hYwAy8/Yxpile1VHFa0Md/mEF9FIt3L+wzJFYNuCfuhRpSsKZHPOmqiF479bYkWxYhCW6syWYpg
 az+PqSt3EIE/lAn+eHgobR2ylb5CBAUSUU1jv7bCJim9Fsf3gb9nOaVFYQZEsUGjBu8mPmoaBsB
 rFQGej7/plexiC6kUPcLCjnASDwG8e9lHlFEfla4+Emqx2KmjHg=
X-Authority-Analysis: v=2.4 cv=HKOa1otv c=1 sm=1 tr=0 ts=68a7891d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=8YWVUPHAKpth9Lzhs34A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600

On 8/21/25 4:43 PM, Olga Kornievskaia wrote:
> This patch tries to address the following failure:
> nfsdctl threads 0
> nfsdctl listener +rdma::20049
> nfsdctl listener +tcp::2049
> nfsdctl listener -tcp::2049
> nfsdctl: Error: Cannot assign requested address
> 
> The reason for the failure is due to the fact that socket cleanup only
> happens in __svc_rdma_free() which is a deferred work triggers when an
> rdma transport is destroyed. To remove a listener nfsdctl is forced to
> first remove all transports via svc_xprt_destroy_all() and then re-add
> the ones that are left. Due to the fact that there isn't a way to
> delete a particular entry from a list where permanent sockets are
> stored.

The issue is specifically with llist, which does not permit the
deletion of any entry other than the first on the list.


> Going back to the deferred work done in __svc_rdma_free(), the
> work might not get to run before nfsd_nl_listener_set_doit() creates
> the new transports. As a result, it finds that something is still
> listening of the rdma port and rdma_bind_addr() fails.
> 
> Proposed solution is to add a delay after svc_xprt_destroy_all() to
> allow for the deferred work to run.
> 
> --- Is the chosen value of 1s enough to ensure socket goes away?
> I can't guarantee that.

Adding a sleep and hoping it works is ... not a proper fix. The
msleep() in svc_xprt_destroy_all() is part of a polling loop,
and it is only waiting for the xprt lists to become empty. You're
not polling here (ie, checking for completion before sleeping).


> --- Alternatives that i can think of:
> (1) to go back to listener removal approach that added removal of
> entry to the llist api. That would not require a removal of all
> transport causing this problem to occur. Earlier it was preferred
> not to change llist api.
> (2) some method of checking that all deferred work occuring in
> svc_xprt_destroy_all() completed.

Jeff (and perhaps Lorenzo) need to go back to the original reasons why
this was done and rework it. I think we were avoiding holding the
nfsd mutex in here?

Complete shutdown of a transport always involve some deferred
activity, and there's a reference count involved as well. I can't
see how the current destroy/re-insert mechanism can be made reliable.


> Fixes: d093c90892607 ("nfsd: fix management of listener transports")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfsctl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index dd3267b4c203..f9f5670abcc3 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1998,8 +1998,10 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>  	 * Since we can't delete an arbitrary llist entry, destroy the
>  	 * remaining listeners and recreate the list.
>  	 */
> -	if (delete)
> +	if (delete) {
>  		svc_xprt_destroy_all(serv, net, false);
> +		ssleep(1);
> +	}
>  
>  	/* walk list of addrs again, open any that still don't exist */
>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {


-- 
Chuck Lever

