Return-Path: <linux-nfs+bounces-8880-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08499FFCB6
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 18:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF1118811E5
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C82AD51;
	Thu,  2 Jan 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MqCtTMM0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tUKQLLfP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241F17C98
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735838770; cv=fail; b=VRymGaYle3dbqvxccHBMVRoHMrQSahOmZ3SwsT3l0gmQvgBR/gso9oQU1l+NAdmxUZVWyxb7gwH07Zpu0YTZser4kUomAThtYgVu9gbbUnSidsHbi19gdoBdEBegNT+oVydoM9WuYTk88Dy6p4cQMpEbHK+4O1rymoE/IVnEkqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735838770; c=relaxed/simple;
	bh=PKFG2pfy7R9hU1jjC1HRTlFvPs+r7yfVtGIQE8a0vSM=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lpZ62XEUBRtdm6EpyhU+x8seTPjxk8FJAdM6+4mwaLvQvbu1Aivbz+fL1ufGIAcNwMi097tpL0KFF1IhgYhFMCqNCzNFuK0eetLJ4hxiA28YebWN3P4Bku7eDXMkQ3ZW1DXDbRDMREzJyo/mfqwhvfM+8eGF2jOJFFVmqbUN6j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MqCtTMM0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tUKQLLfP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502FuTkj018128;
	Thu, 2 Jan 2025 17:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mCJ4PgP06Sm6nmf9CD9TZiRIMn+waaoJOd1jw30iXvE=; b=
	MqCtTMM0VyUY3JCdOP7wBXf1y4yL3HDqJ/EcxceEOyHa+LOFuX0FANyR7OC2g4W0
	tKTKarhrcyafmVat/RbAL4wAhhkvVHZz2qDEI/v7TnWZZqhtZvi4aCh3Ra00Ae+M
	7IQLx697qt8sqqoEEbrb4rLB27pVOGTVlDgOWwTlHr4ZYBk3twYI9Kt2LsdRNSi1
	pF4114M6LKkJoZv9yvnZwXB+mmLBadsTEuvdpsfC53z42oVz/gBHwd1HYb/nRbq2
	pDgYhbvxFnca9hA3OrUIcgL4uprq1fuR2iFzEN3Cgo5wpYH63lPACYXV/6nXaWSi
	1UnYEORMofBv5kJ9AjyEkg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9vt5xey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 17:25:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502GTV9w008801;
	Thu, 2 Jan 2025 17:25:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8srkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 17:25:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqJ33BH1McRfRQUKa5f+9c93rQBzTzrEMR3M0rOpjPBLMXocUPn4ZhaKClg0AzgUToR0YEzJUR/wjlMsVnEraSsH5hiNnUb086y1+0ndHSCIyzH0d4BQBqbawE4nZODXYBrEMcShQXnp8ZTJYhENEmT5ByZzvAgzCuSAVSYZxwz+m+NrjZcV9oRdrYx0oST3ehynIPN2p2KtnhC8TkgzDTVWnZZyu3VsR3+dc+3LikoE8N8LA8DUuSEF3mjJknPoePNi/FwXp3Ct4ZJ6jMiMAdvZAB6oTNCmmzcRAew20OdgmNUNG+ts+tuu/YWQA5WSHy//S5qL94gh8Xt8PqDiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCJ4PgP06Sm6nmf9CD9TZiRIMn+waaoJOd1jw30iXvE=;
 b=YqlU0fB1xiDmXYMVHQ+jiZfRJDgBbKePItA9J0UpfxHWKHpkiEZhc0uIA+HqR/l/NhBFDnUF/CcwR4SacpAJs7g6H5isOILRYLgY4Jp0e/726Ef1B3v2TrrOCf1XsncTeiefsWG1aMsZEzAGuiigWaIQFUM+Dugd4ca/WKDb8XwhH9tYg5SudEAufvnhqwLqUcCik2+kcYjkVrSjP64gKKFabv7TTs8z+oT8BFaGpCV9d2okp+vtkE4VLVW8qX3DZyN9evAnxtOAHRx+Y5Nkq7BN8sUcjxSSBZFG61HydsTbMRFstj9pHFEUPewaaTQqT8egeQkF0gwnHcPp09zGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCJ4PgP06Sm6nmf9CD9TZiRIMn+waaoJOd1jw30iXvE=;
 b=tUKQLLfPhNIKWpRYMbcg1QbX1J6ZeIsxiSlnwh9R/ioLo9IOsc3wzTdgqjtkjtwSJDGAd0ZOgK/nylDtsUpIjuEIzlR+PchYJpJzDXboWeRAtSKgdIRb5FS2zHrtSBy9UdVd68cvG0hrurCSyhpNjeXRvEtcr70JdDLoPVZhhHw=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by PH7PR10MB6460.namprd10.prod.outlook.com (2603:10b6:510:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 17:25:52 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%7]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 17:25:52 +0000
Message-ID: <8bddf0d1-c356-4ff3-bb14-b2b53d4e3bc4@oracle.com>
Date: Thu, 2 Jan 2025 17:25:49 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Ajey.Godbole@dell.com" <Ajey.Godbole@dell.com>
Subject: Re: Clarification on PyNFS Test Case Behavior for st_lookupp.testLink
 in Versions 4.0 and 4.1
To: Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "Shubham.Gaikwad1@dell.com" <Shubham.Gaikwad1@dell.com>
References: <MW4PR19MB7103BADC7FC3CBC1B2B8FAA5C40B2@MW4PR19MB7103.namprd19.prod.outlook.com>
 <93be7e1a0cc5172d964f3ac65681d88b980ec3e1.camel@hammerspace.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <93be7e1a0cc5172d964f3ac65681d88b980ec3e1.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::34) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|PH7PR10MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bd1e31-e1a0-44c1-4b30-08dd2b5281c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlZkUkNzbE1CS0NjSlFZMXp6YjEyck5nU1F6ZCtBRzdNSTc1NVpUMU5CODBK?=
 =?utf-8?B?ZGhoNjc0QUxkV1dCa2Z3UVJTR1NJa3lSVW0xeGdSLzk5cVNWbzZWbFpFK2Ni?=
 =?utf-8?B?WHZLWW4zaU9IWkFwTVNZSkh0OGc3R3NsQlR4UlhneFAvSkcvTThobFlSTlFG?=
 =?utf-8?B?WXFZWDNXU1lEK3o1K2d3aWdCemc4Qm84NHRWcms3VEJhWU5nT2FvaEgzd3J6?=
 =?utf-8?B?TFh3V1JBRFZ6aVg3VWdleFpkTy9oMVozcHFvZUxrL25QaUN3dXlGNmtqUXQx?=
 =?utf-8?B?bVpSQk1FQlJRMlg0b1dRZXZpSTMwMC84U3hwR0g2Y09uWHF5MjFxVm1OWCtq?=
 =?utf-8?B?WjJ1eTFwMUthMXlvNjk4Y0t0UUg4Q2V3MjdWbUlHL2wrMjlaWnZoblpVRm0v?=
 =?utf-8?B?UFhwZGs0OSt0UzJJeWYxaWk1cXFkYzlxS2dxbWFmS0c0VEZmRUJhSDNNN09l?=
 =?utf-8?B?ZkJPaTRpTXp3dU1LWnlQb1IvN2I2Y2QzM2R1VUFqdXg3Slk4Y0ZidW9uT1lS?=
 =?utf-8?B?V0RXbFpSK2haN3JoWkwrUHZaZ3NENzlnajQ4YXV1Q0hsSTlYdnowbEkyUWo4?=
 =?utf-8?B?T280R010d3AyOWdrQkw5eUl2ODYweW5aVFBKTE9LTU41am5YYlRUTEd0REpq?=
 =?utf-8?B?aFNRRFZqMVgzWFd4aVQvaEx3TjJaTnkycUY4bU9BUEJzQVpPTmFGQ043T0Jo?=
 =?utf-8?B?dytHK1IxRG5CN3gwT0lTYXFNV3NHMzNTcU5abWJXdDJzeC9ZczU3WGJXZXhp?=
 =?utf-8?B?bXFKVGl5dzJHbUVUK3dyVnY0VlU5UVBJem1PaUVYTkRHdE0vUUZKUHcwVDJq?=
 =?utf-8?B?TTVjMGhNK2pUZk0rT1p5STQrSGpDTEcwdmJjcktqQTBqSnRFU2VJTGRRQnk0?=
 =?utf-8?B?YVEyc1VJZ3d4UXpLRldpUzNHVGdHZTJZUWVqL08zNjRycStGTFRjSXJiZlpK?=
 =?utf-8?B?aE5DMU5rbUl4UzlIT2pHTVdxeCtnU0pQNFZFVkp4ZW5UTDJpNDJZS1ZwTjBQ?=
 =?utf-8?B?bnRGTnY4b3hUR2k3MUt2YjRhOFlsMHZSV2owSENxb05KUGJtelV4aE5oYlNy?=
 =?utf-8?B?SnRoTW9XVDNoZzRmUmo3eE1LcjVKRnBQVkh4bUd0VFMrSXhjbC9TUk83QUlh?=
 =?utf-8?B?bDFHODBHR2REaFBOdERvMER4NjduRUVneVhqbTR2SWhjZTB6SDE1VmtjbDRj?=
 =?utf-8?B?WGJSaDFnOXlkUlVjSzdXcUhUdFdPbW1aNTZ1R0ZNVTE1MFdOUnh5MUdXWjdl?=
 =?utf-8?B?K1hiTEZncWhud3BWUmpWZFRnRUpsR0RXcFZ5VEcxejFLMjF0cWlsQTBTMlY5?=
 =?utf-8?B?MU1ZZFRhc3lUbnF1b2Fvd3QvNTFmS1lxOTdvRkZKaWE0VFFRWmRZM0dvWTdi?=
 =?utf-8?B?ZkZSR3lHekFvdnF6NVVGcTJVK3hEOXBTbDB0Z3FJYUV4SmRuTFBUVURaT0dF?=
 =?utf-8?B?aFdINzNRZG9hVEVPNjBtSjRiV0VjcFpraUdaNUlVMFhmb0JlcGUyTE1xVDZh?=
 =?utf-8?B?VjBnYWxURFBYT0gxczIxNXZyNEZRSGFubXNVVUJ0alJuUlJCbDZGZlRnNU9R?=
 =?utf-8?B?NVVSRUVzRkpMczBsZFJYZi9vd0o4SGJPNE5CWDIzenkyWXZVVmZZdmxFRTFi?=
 =?utf-8?B?YVB0dWhRbi9BUG1la3JLQ0FMNGZQQ2psUXFiVVh5eUlTTElqcm1DbC9qdkcy?=
 =?utf-8?B?NTgyOWdmTnp1Yytud3EwSUhYb09NV044VDdVd0diMFhqcnY4MlVNL2dKODZG?=
 =?utf-8?B?TkxhYjlaVFFabVFrVFdRRmQwVmJYTmNjOUlnMXgrZ21zNUoyUDdOSnBSNHNl?=
 =?utf-8?B?d050NjU1cUs1dTgzcXJvUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2ttN1hhUUl3TDBUQk0xQzAvNmk2WkZLU1Z4WGY2K0J3NjA5TE5NMG50UTlq?=
 =?utf-8?B?cjJrUjRxTDBERE9KTW5tU0E5OW9CbXZxSHVGWjhzSU1sM0VWbGpabzZuK2Zl?=
 =?utf-8?B?UU45UCs0NENBeWhMaXJJN0c4aUZ6MXJpVlpJeXYyVTJrTjNLQzNyMzV3T1ZY?=
 =?utf-8?B?NEpNSnBzRzRSa1dTblR6cVNzdWUrU2orZnFUSlFqTVNkQWg3cU5lQ0o5azBQ?=
 =?utf-8?B?WGxQdEoxSFJuejFpN3pWdVhmcitweE9IZk1SSU5tdGZ1ZS9ZSDJaWUxicElN?=
 =?utf-8?B?d0pVOXFoeFZ4cGoxQktyeXE2Q3BHRFBYWUN5R0hwSmVuV3FyVGMyZFQ3bXNC?=
 =?utf-8?B?WDdQUjAranI5NVM3Sm9xUk5VNWtHeWkzd3MvWEZPSk8zOWo3VW14bmxIc3pN?=
 =?utf-8?B?WWZiWkVFUDJkNkhTQy9zWlZFQ2hJNk1RQ25xVFFqWEljWkJSMVZnb0dBVWZS?=
 =?utf-8?B?dUtiNU5TbE9RbFVZckdueWNoNGxyY1F1T1lkUHY2bUZTY3J6M0VLYzlWTTFP?=
 =?utf-8?B?clRocmczdDdZanppbUErcGNKMDdIQ0JvRWxsR2tPbUN4TjVMQXpNYWM1QjBi?=
 =?utf-8?B?c0dQTXdZZnEvTnBXakllaE1UV29qM0cxUS9NbGFzemluejRCUEYrZ1ZFNk9U?=
 =?utf-8?B?eVlLWU8wZHRKeSt6bEtLUnRoKzdDall3UFZ1cTRmSE5TTzRVNmJ4eGVWTzlr?=
 =?utf-8?B?eStXUktrVWN6WnhQNDZpeDg1ZjdHaVd6ZndvRG14elR1N0hoMlJDSGVYbEJN?=
 =?utf-8?B?NVU5MVlvUFU4ZGFrSlNWWVE0QkJzSFBhMGEwUUN3azBac1RTaEM5MzJFQ1NQ?=
 =?utf-8?B?VE9hQUxvUVhnSXlPVG81QTlZTENJR1llMEVGKzJkeDFEVVVPNGhWS2lISWFO?=
 =?utf-8?B?aWxqL205NGoxNi94eGZ0cXdhY0N1REFqQmJlZHYwRDFZems2Q2JVcU1jNE1r?=
 =?utf-8?B?NUJtKytvdXppZXp6dU9lOElEUGlCOEhvSW80SG94UTRtV3k3VzZmR0RyR08y?=
 =?utf-8?B?bjlRVnZBaUNNc1JTbmZiUnJGeTdpc2lvdHlFKys0c2pZNWozcHVEay9kckdm?=
 =?utf-8?B?WDlYc0VkSDZpOEFCRFlDMkE5ZFplaE5ybWVnZFhwYytrR2diVUx4eWVPcTI0?=
 =?utf-8?B?NndTdXNTeFY2SGVmQU9MRTFxMmtyaGFyamZibEExRldXck56RWFkUmppODF6?=
 =?utf-8?B?VnBnSTFsS3JTRXk4djVxMFdnUE1UNEptRzFKc215TVBjT3RrNVU3N0ZYODFB?=
 =?utf-8?B?UEpTR3BkOVBJSzZBVnRkb2hUWmJ3eTRqZXJEMXFQR0JpOStpVFRWSlI1M1NE?=
 =?utf-8?B?V2llNFJucnRsOWVaREQycjVPWDBGT0NXaTVpNnJyelpZN0JoaWMvbExXWFNs?=
 =?utf-8?B?bzZ5M0UxTG84QkpWMlBtYVlEdVZwQy9WT2JOanlJY25hdWMyYTMyeG1qUkdO?=
 =?utf-8?B?MU1sVVFlYjVSVW13S1dtL2tFTERiS2RIVmZ6OEkzMGc5blNkclJQOTBrVVd0?=
 =?utf-8?B?R3h2bFpOa1paNFd1KzRlWWFlTm5RL2hkNCtQWWo0MHVBWWlJaG9uVDFNVThL?=
 =?utf-8?B?ekd3MXgyTXI3ZE9pcHBwZVdMbVkyb2dVVG5WZ2RNaG12UnZUdjZOUHJwY3g4?=
 =?utf-8?B?bUtrRnlRMnhjQnI3TzkveVRYODVvemtxL3FPQ21IVElIZ3Rxa25EdU9ERG1G?=
 =?utf-8?B?V01YSldIc2NHTldPYWRQRVBXTUYvbXFycjlmTDlwVG9qYU05V3dITVdlWVRV?=
 =?utf-8?B?MnFSSC9yeC9OUnR6SmY5WGlscWRXS3gwbkJ3L2QyQkxSc1ZMK2xaYSsyVDlL?=
 =?utf-8?B?c3NrUk1qaEJzZ3JSVDNXWjVzM2JZSGUvRWgyNHpEc1pPQmpieFp5RDVHSUFL?=
 =?utf-8?B?OWlNZmNwWGtsUkZNeE9Qd1B1ejhaSnU1dWxvTmprTGV0VERzL0xiQmRETUQr?=
 =?utf-8?B?R2FETTNTRklMSXFCYmd5Q0VReS9URjE4VTV2R2dNZzdvRGVLck50SnFIYmww?=
 =?utf-8?B?Tmdqaml1TlZHbHlrbXhqNmVJUTFtMFNVYVA4N004N0FWbFhtTWt1SHgzUUJH?=
 =?utf-8?B?WXdpcFJZSG13ODFvZ2l3N0VNNDJISmIwcE9MZkllTTdyTGR5VUlhSWZVUVl5?=
 =?utf-8?B?R0FvdDZwSHdYcjhZU3VvZFRKUHJaVURUV0hRQXlsbzEyeHRzV0VuUUhtbGp2?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aW1iNoso5XngDswTOQdTAaUAcbH2sdPVirQkWjbMMpz9zOjrueR9oyurtHHQ0dwrU49xpwxWi155DLc0kuRevGOSSH3pY9cE1oR9ngyTXQhNmifWXCZm/W4w2+KS7ue92Yi0NFmwXTHpAJ0fsHguefO57TSFm687P/iYnuVpCH9Ct35R1Gp3TtLR6gilHItSYWhFmHvotpVfK2Fhy4pMm3HvKJSuTekyqHVs6M6Ce73QB2fYlrwQYfXGruwbnXR+CZCboFthGbb/2d3EBq9eyGEW6kbWEz+SnlwI3pDTC1LIc25sMY5bpWr4j7JGCgvfSWme6P4FRxgNrRgo0Uw5yfh/QvvxwiAiTg62/URg0QS+kxUz+eRT5y52CSivaffy0yEgMDmscH+oab9vO46m7L2poM1rAcRsKoZH6tAMjMuiKI4udblRMfF+QoAP8Ui9bi29lZ8mgtMsb5rWekV2rKS3nRqaDZf0PS5kHw6IlwALjDSQzkbOhm0XSK+AZPKDE5L6BmOW3Zw5lRXNyYuKG9ICDa6gQ/yvUNoUUnhfd3UuXtcJwkNg8OfT6tRlpX2zxx8vX41umiaQyXWcJ0dMQTdk7SenZ72lzPkLGlKTTpk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bd1e31-e1a0-44c1-4b30-08dd2b5281c2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 17:25:52.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNpyyuZamr5i900z9ejFe4yyG9JH5B7h4sriRZ9Y/CJ9QMfL4usUDL9dfpQxOCpL1iYSrlXZNG5y7NIeXjqlQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020153
X-Proofpoint-GUID: T7Zm9tLR8MDl1fzhheoaqT1-mPbW7N8g
X-Proofpoint-ORIG-GUID: T7Zm9tLR8MDl1fzhheoaqT1-mPbW7N8g

On 02/01/2025 2:18 am, Trond Myklebust wrote:
> On Wed, 2025-01-01 at 06:28 +0000, Gaikwad, Shubham wrote:
>> Hi Bruce/PyNFS team,
>> I hope this email finds you well.
>>
>> I am reaching out to seek clarification regarding the PyNFS test case
>> 'st_lookupp.testLink' (flag: lookupp, code: LOOKP2a/LKPP1a) included
>> in the PyNFS test suite for v4.0 and v4.1. Specifically, I would like
>> to understand the expected behavior relating to the error codes for
>> this test case.
>>
>> In the PyNFS test suite for v4.0, the test case LOOKP2a (located at
>> nfs4.0/servertests/st_lookupp.py::testLink) initially checked for the
>> error code NFS4ERR_NOTDIR. Subsequently, an update was made to this
>> test case to also expect NFS4ERR_SYMLINK in addition to
>> NFS4ERR_NOTDIR [reference: git.linux-nfs.org Git -
>> bfields/pynfs.git/commitdiff]. However, in the PyNFS test suite for
>> v4.1, the corresponding test case LKPP1a (located at
>> nfs4.1/server41tests/st_lookupp.py::testLink) continues to check only
>> for NFS4ERR_SYMLINK as the expected error code.
>>
>> Given the discrepancy, should the test case for v4.1 (LKPP1a) be
>> updated to also check for NFS4ERR_NOTDIR, similar to the modification
>> made for the v4.0 test case (LOOKP2a)? Additionally, while the RFC
>> 8881 section on the lookupp operation [reference: Section 18.14:
>> Operation 16: LOOKUPP - Lookup Parent Directory] does not explicitly
>> mention the error code NFS4ERR_SYMLINK, it is noted in Sections 15.2
>> [reference: Operations and Their Valid Errors] and section 15.4
>> [reference: Errors and the Operations That Use Them]. Therefore,
>> would it be reasonable to update the test case LKPP1a to allow both
>> NFS4ERR_SYMLINK and NFS4ERR_NOTDIR as valid error codes, ensuring the
>> test case passes if either error code is received from the server?
>>
>> Your insight on this matter would be greatly appreciated.
>>
>> References:
>> 1. git.linux-nfs.org Git - bfields/pynfs.git/commitdiff --
>> https://git.linux-nfs.org/?p=bfields/pynfs.git;a=commitdiff;h=6044afcc8ab7deea1beb77be53956fc36713a5b3;hp=19e4c878f8538881af2b6e83672fb94d785aea33
>> 2. Section 18.14: Operation 16: LOOKUPP - Lookup Parent Directory --
>> https://www.rfc-editor.org/rfc/rfc8881.html#name-operation-16-lookupp-lookup
>> 3. Operations and Their Valid Errors --
>> https://www.rfc-editor.org/rfc/rfc8881.html#name-operations-and-their-valid
>> -
>> 4. Errors and the Operations That Use Them --
>> https://www.rfc-editor.org/rfc/rfc8881.html#name-errors-and-the-operations-t
>>
>> Best regards,
>> Shubham Gaikwad
>>
>>
> 
> Both RFC7530 Section 16.14.5 and RFC8881 Section 18.14.3 are adamant
> that:
> 
>     If the current filehandle is not a directory or named attribute
>     directory, the error NFS4ERR_NOTDIR is returned.
> 
> While that doesn't say MUST return NFS4ERR_NOTDIR, it is pretty clear
> that conforming servers need to have a good reason for why they would
> prefer to return NFS4ERR_SYMLINK. It's not as if the client can handle
> things differently in the case where it knows it has a symlink as
> opposed to a regular file.
> 
> As for LOOKUP, there again, the spec is clear but fails to use
> normative language:
> RFC7530 Section 16.13.5 and RFC8881 Section 18.13.4 both state that
> 
>     If the current filehandle supplied is not a directory but a symbolic
>     link, the error NFS4ERR_SYMLINK is returned as the error.  For all
>     other non-directory file types, the error NFS4ERR_NOTDIR is
> returned.
> 
> Here, there is a very good reason to want to return NFS4ERR_SYMLINK
> rather than NFS4ERR_NOTDIR: the client will need to resolve the symlink
> using READLINK in order to resolve the path (i.e. it handles the
> NFS4ERR_SYMLINK error differently than it would resolve
> NFS4ERR_NOTDIR).
> Note that OPEN has the exact same requirements as LOOKUP and for the
> same reason.
> 
> 
> So ideally, pynfs should reflect both these requirements:
> 
> Yes, it is true that NFS4ERR_SYMLINK is an allowed error for LOOKUPP,
> but it makes no sense to return it, so pynfs should at least warn that
> the server is doing something stupid.
> 
> As for the return value from LOOKUP, it should probably disallow
> altogether returning NFS4ERR_NOTDIR in the case where the filehandle
> represents a symlink, for the above mentioned very good reason.

Thanks Trond; I'll adjust pynfs as required.

Thanks Shubham for raising this.


Happy new year, all; bliadhna mhath ùr

best wishes,
calum.


