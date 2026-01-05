Return-Path: <linux-nfs+bounces-17460-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D52CF5C24
	for <lists+linux-nfs@lfdr.de>; Mon, 05 Jan 2026 23:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 416E3300B9D4
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 22:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6E12EC08C;
	Mon,  5 Jan 2026 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jr2AN9sS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZdKqthMp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798511C695
	for <linux-nfs@vger.kernel.org>; Mon,  5 Jan 2026 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650535; cv=fail; b=q9AymIjxpIfhcNvPNG1u1eJwUuOmhO0L2W9zRczmSPSduHCCNPP6/J7Ww/BrWqJ61+a65A5F/qeoIWT9lYWlvYKcdN62Gt/wR100/DIROwiQFVv43Mu+4ZJrMpmseTUqUAsB84o/QJOHbPBgqwJP6TGCv4quIl0OlRoxS8VLlq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650535; c=relaxed/simple;
	bh=2eSoKQ3zjaD5AfqBjhpAwBCTEcjccmr4bsp5cyCTxP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T5oarv0VEyxOYdcxMW3gruGVeygngfPMDoL3OwImR7buW7q5XUg6GqDA4N2hIJCgVDKQkrS+mdKORE0z8UiQZl5ZCk8y1Hp0u9AMKSv/jRlSYbgeGUCMIQCXEuwXpNjm/85hz0ruiFl/98ObTKRhRDQfqW9Xx1H/5ftbom7jsi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jr2AN9sS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZdKqthMp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605KKRTR2716357;
	Mon, 5 Jan 2026 22:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=M7RsZC7mImG5kMTC0HTtfhEdLBeP5tw2rFRVugzay+I=; b=
	jr2AN9sSO87qEB33vzcUYcNehy+RcHf0CFw/C7eKUOWWh5lv9WgXhlSFMfssAfmk
	bb47iAprWoiXr7tPphwhe+uZHdVIE0WEcJ7eAmTBSbsPkyIb6jDtvUmxrXYXwNIO
	GU/Fxs+lILPta/uotowCMrJ+oh2ewCUBp9I9u5ZeslpQ0rBW+tFRRBIU8STtl1Rn
	yDNhqwTFeeQPZk9ryuvJecsc+arI2pAUH2FpEvHX47g+MawjFdEeo1423iMP9UaU
	b3V3fvuLPyaDS+42hwz9NGS/2hnNdiiJSJiZ2RbJ9EMKSaoHDmRNjf0nNV4uOK+X
	uwqdjicIOgDiBuf9ZmVrhw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bgm8fg46m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 22:02:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 605LP5jW037105;
	Mon, 5 Jan 2026 22:02:10 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjhvs87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 22:02:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMS0MBjoGYWKOyCAkdEW5AjIaLbXYNCgPA70gMm6j4Su8PCxxfdZdF4wFCNzWCPEzAMwTIuYcUo3PxiO1ehrrzhxxZ/ssHTmIz7BGONEv2F9P8NpwWGUA3oMuvTpZxHlG76OdtCFiyWprfQ90PD8Z8sBYlneIfJ9x0DVM55kJDRz1zYtvfbtTJ0A8FCE+FZ325dghpmObie38DQnZxM7pANaM4vfn+lInkgj4evU/S5jrxGzHwv5MpfaID5E0CzWn90AJLG6XTY8PEHgotk42gDmNxI/nMqnVIdFmwA83Ln/a5eEd92MDEFlsBVIgWNjQN2oP7XF8DNk3z0bBtu5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7RsZC7mImG5kMTC0HTtfhEdLBeP5tw2rFRVugzay+I=;
 b=vsTRuxlC1l3QQ/fZ1kFubFOhREHVtx9Ttrl+AVZVPvMORfb6q0j5CcZ5IOPJO1ikapdksDtNI9yREqQns3tAfsp/BfNaLyy2tolu4/DDWUpcFSDKjRn7kFictbFsXyHtkm09YCC+3BJyhwVdAmqNDY1d4OTF5C1e2AB8iRSfEM6fOTu0frDNsZmEpzkmA+/6pU/X/RY8oWpSlYxzQ0uB+WCEPr5TD7Gcd9zTBBK7okVj4H46+ta6wiP4C4SEEIXNlLHE3qCQuWWXEL9msilcKk7OLuwrhnre/gXIGPhN6g6jyjNdXfxPTpl5cSSLhK6a2+yDogAyEWKhYtIK5PwBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7RsZC7mImG5kMTC0HTtfhEdLBeP5tw2rFRVugzay+I=;
 b=ZdKqthMpGe85LWn4hf8/0zsMsJyZyLRTYYpn2mJAJuw9fILVmH2L4eXAxePlQo+6JGMWs2oA+s5A/Vo2uEgHuIinTM5epK/2DOPzR7Z2/Ygcbv4sUkAFKEryWxudgTO+QRDiMXyHSiB4Sc5Ql3PU+5H1pkFtjUDhKc85g4M9lM0=
Received: from DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) by
 PH0PR10MB5580.namprd10.prod.outlook.com (2603:10b6:510:ff::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Mon, 5 Jan 2026 22:02:05 +0000
Received: from DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::f8b0:7eee:d29e:35ed]) by DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::f8b0:7eee:d29e:35ed%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 22:02:05 +0000
Message-ID: <a4b591f9-5240-4aaa-9022-bfa4b8dc37ac@oracle.com>
Date: Mon, 5 Jan 2026 17:00:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] Set SB_POSIXACL if the server supports the
 extension
To: rick.macklem@gmail.com, linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
References: <20260103234033.1256-1-rick.macklem@gmail.com>
 <20260103234033.1256-8-rick.macklem@gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260103234033.1256-8-rick.macklem@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:610:20::32) To DS7PR10MB4847.namprd10.prod.outlook.com
 (2603:10b6:5:3aa::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4847:EE_|PH0PR10MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: 0155af10-657e-4cb9-9a38-08de4ca61011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFhUbEZCRXljU01JaTFkTEtRRCtiRnVuaCtrQzB3L0tSVXZ6THEvbFNuRHdX?=
 =?utf-8?B?Snl5TnRKQWl6eUF1Qmg1Sm1SYkVaTVpjem1GZllJaGhYRnFLV054M0kvbklx?=
 =?utf-8?B?THdHMFhiQ1JiZ1lXcWVLUW5qRTNKNWkxblpLSUdjMVJuN0NwUFg0cUI2VU5p?=
 =?utf-8?B?cGs2dXJPd2ZzR0hSSDI4UFFGaGU1c0EwQThFWnNieTNUWWFzNURkWFBBOWhJ?=
 =?utf-8?B?SG1sNXFwWVR6OFhVWTdrZU12SjhWbXdZMFk0RmdYVDQ5YWNJSVFYeGRSZHNl?=
 =?utf-8?B?ZCtnbEQ2T0l3U1ppWTJkZlloSXRaejJpelhDZENJRG84VkdCZ25xalBzZzNh?=
 =?utf-8?B?TitWTjBjNkRURkY2NGNVSzRwdDR6b1AwZEp3Si9tUGpxVWxNSDVaTDlYaENT?=
 =?utf-8?B?MldBb3hnTkFmMXV4NHI5V0E0ZU9vclZrNGU3UjJOaFFqMHkrditNMzQvWS9Y?=
 =?utf-8?B?cGV1L04zS3VqK0YrNld5TFdZUmlDS3B2Z3ZTSXdlZ2lvbzRjUjE5M0dDdVB4?=
 =?utf-8?B?alZ2dCtHdStNNzl4VTlYRGxjejkzV3pVWVFHNTIvZjBuUXZ3M3h2dG1jaGE5?=
 =?utf-8?B?dVlmejA0NW14M3A3UUtLbm9zVThIN3hRdXFBUXBiTXA3OG5adDdEWjA5U29Z?=
 =?utf-8?B?NGhkMEFZK3B5RUZOeERzWjlYZ1dVZFdodE5zMXdSM0xMellrWXFFRy8xTlNQ?=
 =?utf-8?B?cmY4RkFVYnRaUWNXUmgxK2dzYWFpWGVaViszQlRsUm5JSGlNcWpDeXN4b3Ir?=
 =?utf-8?B?WU54alJ0N1NqUzNoSEZraUNDNnFJL0FoNnEyc0ZGRmZNNVZwVStPbTFXV2ZW?=
 =?utf-8?B?enJHV0dEZ1M4NHA0Mm1EM3ZHV2NCQUgwTGZCRFNGMnptSWlNMVE1SXFRWjRH?=
 =?utf-8?B?ZXJQTFkrNFM3bkdFSlJTbG1PQVdMblJUNk56RjdRUlZzQnVPWU5jT0c4MHRN?=
 =?utf-8?B?Q2YwQ3hmejZvY3B1K1NYUndFd1JWTUFsUEhDTHZ5L3hVNDVxUDlnUnRsOG5B?=
 =?utf-8?B?d2JJdDEwRXpNM1pnRmNGNFlYSkVKNm8wNVJZTlVuVEdjbzNjcEZkcjE5cSt2?=
 =?utf-8?B?SldWbm1HNGdwMjV3Q2JaU2I4QmMxUUpTanU3b0JhUXNSUUFUbnRoNC9FRy9y?=
 =?utf-8?B?bTFrYW1ZV1NxRFhwT3Vray9NZ0d6YllNa1lLYTMrc1JRYjRGWHdlNnJ5Tmww?=
 =?utf-8?B?Rk41QnhVZVBKODlxem1hckE3Z0pnMlVtaUN4bmgwV0NMaTlzMGx6eWtkQU5L?=
 =?utf-8?B?OVEwVzFlYW51emNlb0laZ2F4Z1B1T3FJS2tsZlZ5R1RGSUtHL1JPTGJIMytO?=
 =?utf-8?B?UnhRNjJ1WnlJRTEraFFhUzlUTUtuZ2FQdmNycVB2REdLM1IraXhCWnVpS1B2?=
 =?utf-8?B?YkJ3Rk9nVVhjQ3BMUDZtbFRTTjR6aDhYRUFldWJ6ZDJ3a0dNWnRyY1o2MDFl?=
 =?utf-8?B?T1BMUmNoMG5WckpSYmFtd1V1VHB5ekZyWlBnQmt0TzlJUkhKTXoxRzZJMFZL?=
 =?utf-8?B?Ky9JTjlnYjlSdHNETGtPMmRNZFZJU3pDdHR3WWZkSkE2ZjBZUUVMTThVU1Fp?=
 =?utf-8?B?ZzkzWWhmLzJqYnNIZVVYL3o4RWM2SjZBV0ovS25tYk56UmdrVzZ2MjFOUHZ1?=
 =?utf-8?B?ckcvWWtEZUpoUDhUaVc1NElEcENkS21PQ09LSlAzSVNTOU16T2VXUDN2STlt?=
 =?utf-8?B?TGNkK3NUbkJaRGhXbVVucHV2dHZXQ1o1ZlQwOEd3NEN1V3N4VkxldVo1c0Qx?=
 =?utf-8?B?TElBbmFkeU9yYVZjR2dCNnBDdDBOZDdPSUtEODdMWUJtK2U0cEcwZm0zUElm?=
 =?utf-8?B?VUszR21NMk00Ukx3aHh6dHVZaEFJNXhoR3NSa0JReHZvVWlHbjdvZzRqNDM4?=
 =?utf-8?B?V3RNcTkwRjJ4RllyYWg1YVNTS2JhNlZDQkFjTk9QSmMwelczWXNMWDBjNlpB?=
 =?utf-8?Q?voRsvXXwUfVFLFbvsUNcQqFmhpQ/DzzB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4847.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?endSSHFuVlNpeW1PTlEvWjBmVnMxbXU3Q0kwMDNSNXRXNUo1UjVodC96cTk5?=
 =?utf-8?B?WXdTS0wxSjNuYkZ2ZTZDMC9aVWtmbkpFNVovUU1FbDFqS2NUTEtLOEtVK3RC?=
 =?utf-8?B?cWxydkNrRm9vbThUaklMaWV6aVI3Q3lGSzZnN3JDYkZzb3hSOXg4SEdOUHQ0?=
 =?utf-8?B?TzJFd0k5MVRoYWtJL2RHZk9BZURjL1BCVmlIK1hRK0kwS2xCODJLSDY3UmYv?=
 =?utf-8?B?enp2Rmd0RW9JSUhBUk9ZZzZxMXZwa1dCYVgrYlZHMnkzYllyb0w3RzlHbklv?=
 =?utf-8?B?TVNvRzluM3FhbXNGZVp2VThoODZ1dW1MNFZaaFBQVEFpQ0JYT21qcVhOU3Ro?=
 =?utf-8?B?NXBYYkJ6OHF5bXBjY3MvTGViM1dKdmhYUGpYVUl5L1Jqb09pRWFFZWlJTFkx?=
 =?utf-8?B?TjRldXpQb3d5ZUd0QTRPSlZTSk9wWHFGVmtFdWg0Tm1mZzVQWmtnQWNvTXVH?=
 =?utf-8?B?WlZYQnVTc1UxOHBqT1hMTlY3VERPbGZHN0hPN0dLVytGay80MTI1SlFkOHRX?=
 =?utf-8?B?dzBaK2NSV2czNHBrUHduZHA4QTBmckhUVWJ3N2lweVZmNkttVmRyYzNNSFFH?=
 =?utf-8?B?THg5MGJIR0MyZ1RjSDBBa0tUT1VyUEdVSm9rWHN6MjZiRjBvZ1ZRa3lEd1ov?=
 =?utf-8?B?elRXLzVvT1M4QTNRQ251VnlJVUtGNnhKOWlMSHdlbXVXZzNEUFNYRFJjOW55?=
 =?utf-8?B?bjltR01KLy9Jc21LSzJGV0ZablF5WkFic1BNQjdmczNPd2g3enZwNElRK3BQ?=
 =?utf-8?B?ek1ZZlIzSDlxM1ZBSldNdC92NDNLUzU3MGM1TmN3S2YwNU96UFd1dlZXc0Rn?=
 =?utf-8?B?ZzFHa1pndXFJcCt2SVJZWTllNVoydFoycCtDTjBYU0kxMk9tYjR2SWJiRDhF?=
 =?utf-8?B?d2VWalFpZmg0U3dmOGdtUmY3UDBzMDZ5YURYWWlldGZzSUgwNHAvaTA1cGE1?=
 =?utf-8?B?Sm1aY3FmczlGNjk1cXBMdHlzZ3lPakhJUFN0SFpEZG1BeE5Nd2VYMHFHcXRa?=
 =?utf-8?B?ckdBamtuUHpNbjNMbWtidUV3S3lXWnkxNjMxUDRxTEZqZ0wwVlI2MytwdVZh?=
 =?utf-8?B?MmVlbkdqSllZMm9WVTFIQk9EVFg5TTljVWhkcEVXa3ZTczBYMjRmdXJHZjc2?=
 =?utf-8?B?azl4cldzSXYrTXlDczZRY2RKcU9mTkhKRFZXWGNRYTFVamJFMUduUHdxRGFu?=
 =?utf-8?B?OUJNNldUQjcwZXhwdTZEaEVUR20rc2UxT0JXSERQTnF6NXlyZnZzUk0xM3lw?=
 =?utf-8?B?dTRHczhkYmgzcDBxemNBaU0yR1R0OGJzSVRDVFJxd1VTVmU3NWVKZXJZeGhZ?=
 =?utf-8?B?TjJzMkszOVNnTURyTnpneElDY0VBbDkzZDhmTkdpRGdYanVhUFdNYys1RDhY?=
 =?utf-8?B?UVI5Y2hrU2lTcThUWEE0VXZiUTRPalBndXVOcjMyUjZVMk84Zk15V2ZPVmVk?=
 =?utf-8?B?UGtGUkl6WCtha3R2WXRnd1JXdmFzemRJSTIxbitwY1dCRkNyYkczc0ltUWtS?=
 =?utf-8?B?WDgzZCtxYS9sNUUzbEpZQzlEeCsvZ1ppOVl5eXE5Z3NDZmErdmhpU3FIWDlO?=
 =?utf-8?B?VmFpNE1OQnJTWmNtMGp6SHJwak9wS2RYbmFQRG1YdHdqQ1ppajBCTk9tcnJD?=
 =?utf-8?B?OHJIdEVMUUtJUkxjZit4aVplcnFBNjVjUWdOKzRzakVHbUdiSnBhNnRsSHNJ?=
 =?utf-8?B?TDF4aTdSUzRuNnh0dkFuVEpabTdveWpGd2t5QzBEZkdCMFIybmx3VWIxZUZl?=
 =?utf-8?B?QzVReVM2bklBeU1MT2IvUFZ5OE00ZmI0cnpVYkNmYzhkdVFGTDdLazVXRUtY?=
 =?utf-8?B?Mk1ZdXVkZEV4VG1pUjV6U1E3OWZFN0tGOXFORHIzYW1JNklnTUNKRVJoRVVF?=
 =?utf-8?B?d3hLSzRYVjVvRzJyRGUxVDVPNklrQVg5dDczTjJwbGxOT3B4RnJ2K1NqOEY1?=
 =?utf-8?B?VTdhNFRpQTB2d0wrOGlJblhxSE04OVk3VFRkTWdqak1rRVZoTkdEQVdFbVdQ?=
 =?utf-8?B?WXJIL2wxMXBxeFBZdjg3dHcyNHdSMGhraURjYzN3V05YVXA3Zkw0aVBGdHVL?=
 =?utf-8?B?YkZHY2JwMXBaTjZHbndBaFdVbS9HQ3pwaUNKWUxJWlp5aXlRRmtmeVduVEYz?=
 =?utf-8?B?MGlET2NtQUxGQ2VudEZtTm81dEhKT0pTRnJFTEtRcUNBZFV6R3NSZzhqRzAy?=
 =?utf-8?B?RXgvNFlJV3M4Zm8vS1dzbUFEMUFlb0dDOEpPQVFTYUhSbDk4K2UyNU1pWDlz?=
 =?utf-8?B?d3FmVEtNamI1ZExyQzdQNk1EU29pY3hURUIrbjZUUUZDSkt2UUhmRTNXS0lX?=
 =?utf-8?B?dkxEa09SMkRUN3hzU3JrMHBJdHl0U0xNU0pONHFaTDNobzl6SnVVU1h3VnVQ?=
 =?utf-8?Q?cA+bYLcN1pebI3jg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m2jOKH1+8adbfVuxNG6WS8CUHJPqm20AbAoDzjB1bVTRLY2INbN+syWfkxe9Mp76QdO+aPJmEcjLngocWMeEci+3byDLlh+GYEUY2HgnpB9hOuvXjgsJMooTsqm2jHdpkO/GPA88k+ZnSGnJn/Ega2VDICb9muFivxwG4tYF6dus345rj4MeinpX+FkEJEDa1DkhgGZK6i5QdVS823rLmYVo1kpnSaXQuIEYgEZfvkT2GfJ3A0cejCWldBhLmgheLfz9fmE2cEcNc3w2cOE0MIedSCCUporubWAibZnKpkKXDxaNCcfr+Hs8NeFeE02E1tkJBRcqxQ0+d44hY0PZ1Qu3SFZIj6tOa2ylXCnMgeCPu8sk61GTCfRg5hbzVr5oCWmpO1HhVV7Lw9RplpiUCLt+d1TJq1IFZoINsiitBFWD8M0xuG4Y6ariZ9QdKU7qUs3P9qaRHqJVCGF4P47/nNNb+VYUDrZuitXzPSH48hO/3ZtHZi/Zh1Lzz9wfmcmA9Q9Xz0oJ0lx/0M9NPMNFZxGzDXSoXARQPEUgjXeZhioNFlErFE6NY7ekPZrdc/AwMAI96EmYG4hEKj819Ux7UlkMv8bZhxQ5aBuD5sHCwAQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0155af10-657e-4cb9-9a38-08de4ca61011
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4847.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 22:02:05.3591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCv9S2q6GKTbznmLj/M3FYngUJuvmBIoFg0qs2/wDk8p1foMDGtjumCuX9jqJlJGW7DHBfeVK5K4PtOrtElg5EpUEJmpHZkKx5+O9Y/8m8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601050191
X-Proofpoint-GUID: CBsrP9axTMUOz7sDxZo--n3QO8VVT9Ck
X-Proofpoint-ORIG-GUID: CBsrP9axTMUOz7sDxZo--n3QO8VVT9Ck
X-Authority-Analysis: v=2.4 cv=eIMeTXp1 c=1 sm=1 tr=0 ts=695c34e2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=hF2rLc1pAAAA:8 a=vYbG9GT1IT8tWBHcfdQA:9 a=QEXdDO2ut3YA:10
 a=O9OM7dhJW_8Hj9EqqvKN:22 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE5MiBTYWx0ZWRfX0aSuV8VjLTa5
 NY+gYMIgOOB2n6DxCjodbc+CL8WZX19Q0MHfqZSlkYhwxJDePrQj3n1Z06VVDE96be7TwFYJh0f
 NnAbkiEGa1NPnzjAKiJYG4UySCaJoVKDs2GAYelaKGqPUWdqTrFC1oV8znGogZxAd5SCR2dR01Z
 PHJmgNO835nC1OFFM529pdiMB24eCJ4IReZ+FjkfO+uonozvwrNNR7uFI6x0j+o/f2j/fgfdaPf
 sXl5LhormPTGCrQH0ACz52KdO71nouUjxOHIFl+LQOfy2LnOJQmdAcM/nvuShDAUEHOComLYkbT
 3irHwLYzCFX4d65K3o8wp0YfRSiZSCsQXuKakXbh3iN59qMmt3bqa5N1SKXSUUgK+9IYRq6Cq0G
 saGjxqTAaMsquqqsT6N8OMEbKO/nXEGgQKeaK70xd5Gjmvga0oqE0Lgs0PuhevOkOWPG6HaYNZC
 ONh37iN/0Ked7XVy4C/nbYPxMLH7WVwx7kxm8FYk=

Hi Rick,

On 1/3/26 6:40 PM, rick.macklem@gmail.com wrote:
> From: Rick Macklem <rmacklem@uoguelph.ca>
> 
> Check to see if both the POSIX draft default ACL and
> POSIX draft access ACL are supported by the server.
> If so, set SB_POSIXACL.
> 
> Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
> ---
>  fs/nfs/super.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 57d372db03b9..aa0f53c3d01d 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1352,6 +1352,11 @@ int nfs_get_tree_common(struct fs_context *fc)
>  		goto error_splat_super;
>  	}
>  
> +	/* Set SB_POSIXACL if the server supports the NFSv4.2 extension. */
> +	if ((server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL) &&
> +	    (server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL))
> +		s->s_flags |= SB_POSIXACL;

Just a heads up that server->attr_bitmask only exists if the kernel is configured
with CONFIG_NFS_V4=y, so the compiler will complain about this:

fs/nfs/super.c:1348:15: error: no member named 'attr_bitmask' in 'struct nfs_server'
 1348 |         if ((server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL) &&
      |              ~~~~~~  ^
fs/nfs/super.c:1349:15: error: no member named 'attr_bitmask' in 'struct nfs_server'
 1349 |             (server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL))
      |              ~~~~~~  ^
2 errors generated.

You'll probably need to either move it into NFS v4 specific code or hide it behind
and #ifdef.

Thanks,
Anna

> +
>  	s->s_flags |= SB_ACTIVE;
>  	error = 0;
>  


