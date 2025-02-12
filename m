Return-Path: <linux-nfs+bounces-10066-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746C9A33199
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 22:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8D4167897
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 21:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A96202C5B;
	Wed, 12 Feb 2025 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E9T+Vt9G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NRa86Qo8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069FD202C5D
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396117; cv=fail; b=JJC+GsA06i0V1hteJky+SuLYcOZj5Tmwxe+AWFBr4hNURUj5OwYTAmdQVvradyVuhi87VFh34qejFusb9LPOI4SySu7VoAjcnpdrK1rxOX+e+NPqMsymXu+6J5vU/8NG+2WR8wgrHtdrzGl9iHAyWrqgyZS98KjzzM5TE6hwC6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396117; c=relaxed/simple;
	bh=OWmkauYk4+vsuUdCm3oi3n03QtzwX+9OH++vlDfP6/c=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sdItkKFTZyVUfUehqavAETe7DN7sTVM3XKOJWEuzY8noA3bWeivvZ5At2Bg4aef0MQU6uPbQL8XusTA6TuMjFzNnYox+UEPy4741mOb88ydrLDU2z8KYtD8SC9XH9pKDCeNNmOtADAu1c8zbD/s5YhkrBAkVJbuE1wlbZuXoqz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E9T+Vt9G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NRa86Qo8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CEtY3g006318;
	Wed, 12 Feb 2025 21:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=erSbZ1p8Dd4w/CTwIfuJ0T2wvrYwYi2LYURceU8ODZ4=; b=
	E9T+Vt9GWzXdeS0+tzhCNGa1qzBLH5Xr0ls7xlpqm8O+pKywvsHzq8hZgdc1BJO3
	m7a914rO6TDJcGtWFO8pxtrXgQoXcD6KUnOde21uv2miPl4f8cQ/np7R/gJhn6gP
	UwOcJI8mRFk/A0F7gr5E3jycVl4nMz8GFYfEJ9Vu6khpLqFan16OQ8tLTI6O8PeW
	U6rXOKemTOilQf5Yfbpobe7aONqyqE+v0Wie6SYlMTd8Wfr6W+AdDKERhC7VHp8v
	1j7OLI2SLgkMtVgLYNDiZF/z1njaESWeyXb2Q/2s4WmNzr8W1d766Rip5hzsRGOO
	u5PqtGkN2qQwpNRSLtLrjg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tg8fug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 21:35:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51CLFgPG026995;
	Wed, 12 Feb 2025 21:35:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqauynd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 21:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S45aFLjX+KHG+WIEpv6OTIJ3X98zEKOoHjsRmovSPkVZ8meaBWbeq1SSxHDmt5lhxjP7peRgZbr/KKJMC6R1Li/DzOu7Ma5R8Gv30UXhsvYrfjDm9qvzgxbuMtLKtrnU77OZz2rvjVwGC8nIxxoKqZYd26ibwYkMaN5+4yOkCFpqOlsTub1C5PQtRJiMd0y2CSAUpghWyTa/o097AdT2JCxeBblv/bDiPziZ1fmqxykdXN2onUD3aHzXAeqdmk8xm+SQuOj1wpyZ10pZ+98UEco2SAnsfUkcYEEXvhpGpIVfIXVWr1eRsl/umTZVQEVXLemywcDX10x41UbKY22WWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erSbZ1p8Dd4w/CTwIfuJ0T2wvrYwYi2LYURceU8ODZ4=;
 b=S92dyQDTijAXNltK17zZM5DB5OFbA0AE37ihPxvWBOC4Pxt5pqRJ66vLOZNiwq5juP21DC6b9DZ0XFoA71ZqnvX22OBXnnOqc2HAmWqjzBce4tBkoo7mybr5mHKHPNKxuOlYw2jkZRU6YqLF9FOYTBs5zx9Ot4jNEtPliJ4vlgNbwXdO8mahJh4l5NuvTu+Du7dKr7vN+tiuDMO8rt3KIhmUnkL+xwa5Hufzv7tYPLYmldRd4Hz/nAbtt/kGAPaS9SWJddfJIX0gW7J4JFt2MsceEKz87sjPXbfLdmWwmgJ0z+/FKXwFa2LnPoubAr+T6IYeum/NwJIboasBrKVLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erSbZ1p8Dd4w/CTwIfuJ0T2wvrYwYi2LYURceU8ODZ4=;
 b=NRa86Qo81Y+b5inN6hLYLpT3mkKcdLrr80FFHL9oNfX0ZBzOTaNjnGCBa7P0SDpfTWdzAiEsUeCg8jfptWcQf9szC64Hcp15KivoUkI/RURNGmjYGIXbdFecvfR6ZpS+nwXz9LdzwuiYXiyBONhLUkV9AqAEJfxibYTAdrZs0zI=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by MW4PR10MB6680.namprd10.prod.outlook.com (2603:10b6:303:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 21:35:04 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%5]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 21:35:04 +0000
Message-ID: <7efde156-c39e-452e-bd3b-6c6d1964b692@oracle.com>
Date: Wed, 12 Feb 2025 21:35:02 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: [PATCH pynfs] build: convert from deprecated distutils to
 setuptools
To: Thomas Bertschinger <tahbertschinger@gmail.com>, linux-nfs@vger.kernel.org
References: <20250211202432.20356-1-tahbertschinger@gmail.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20250211202432.20356-1-tahbertschinger@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0653.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::23) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|MW4PR10MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: f363d7bd-fdc2-4aff-d805-08dd4bad1d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wkw3bEdGTjg2UUhsN2JSaHlPaVRUWUlkRlY3VEFlcGMxMWo1N2h6TzFPdmFt?=
 =?utf-8?B?WXdnSjRCWWpwdWNvZkp6Z0t4S2J2R3ppcW1mbHQvTHBmMXI4VUVkWGNNaFY2?=
 =?utf-8?B?L2pTNnR0Y09Bcnd4K1UxaEpZbjhNNnlFV0ZPOHZiN0VjZGl2Z2Z5UDFFZDNM?=
 =?utf-8?B?WVdLWThsQVV5T3hwMVJMWW0wWnFtQ0Z0RURRMnUrWlJMS3RHaDZHVjdEaGkv?=
 =?utf-8?B?aHdBWWFWUnQ5YXdSOGRsUTAzMDlzc01HaVpIelIrd1VVREpuaWhJTUh2WmJM?=
 =?utf-8?B?eWF1cmk1UXhjK01aZDlmOE5xcVV1UTZHVUxnU2psQ1dMaUppdWdaOGdtS3ZI?=
 =?utf-8?B?VWJQdmtGWll1NGIzT1prMmpzZGsxa1lkeE05K1dwYUFoYnlBS1lRR1hHSjh6?=
 =?utf-8?B?SWwvTDlVclZJbHZRRkhXcHhlczlKUG02MENJem5LTmsybExLdm5YRXA0OGVZ?=
 =?utf-8?B?QVRDRktyRllxNDJLSWFZdUwybDJoUjhPUisvREhKRnFuNlNzL254K1prakpu?=
 =?utf-8?B?V2YzUTlRZGJ5Z2pRZHhvNHl1Rjc4TEJMM2NMaTE2S0FNN25jdEtpTWZna2ZF?=
 =?utf-8?B?eTl5T3R0OTFhcWF6cUMzRHc4Q3U3K2Y2TzhkOWIrWGxBOHRpWWtyeU9xWDBR?=
 =?utf-8?B?Mm15blViWHhrcVJocFZ3OCtlU0hiSEtDN3RWNWlFNGtma25pS1BrT3Y3QlhI?=
 =?utf-8?B?V1dPcDBWMGk5ZjB4QTk2ODJETVVwZ1M5WHBWVjNXRVpndnMxSmM2SEdyM1Rh?=
 =?utf-8?B?V21obGNjWUZkbk1pdGtacGVRNVJ5US9LTTRVdXVsVFVudFFvZDB0WUd5WUZx?=
 =?utf-8?B?bHRVMlN0MDJPQlM1dklSdzA0cjRUa3VjQXlIUlF2L0Y4MEhqWlNOZzR4S0hp?=
 =?utf-8?B?NjE4cFdhOWVMSTEzTzFNaEJEaTBUTzJuOXVNaUZjRjh0WHNNR1Y3QnY3U0p2?=
 =?utf-8?B?TklON3oyT0tHSGd1ejJrODRiNWErdXdKb01JdThtdFVZejZHVm1BVGxGYmxk?=
 =?utf-8?B?dHJqTi82aWVLNDljWkZTSUZOY2xaODFITmFQalJrdVM0UkgyWlZycDFWK0d5?=
 =?utf-8?B?WXhuUnhmVFNiWjBLcnJKK1ZaVWI2MkgweTIyeEMwYVpoclVLRzlHbE1vdEpJ?=
 =?utf-8?B?TXFGbitsQ3BIbUVLUDdPeEZ4TktBK2VMU2dmR3JWUmplc0JyTkp0TUNVb0NK?=
 =?utf-8?B?L2hNL1RmaWhrRnM5bEVuQTM4cU1BeHBndVJWdDArcWM4SGc1aXppMy84UWln?=
 =?utf-8?B?eDhHRUtRM0VaUHJYKzRnUjYrK2I4QncyeEtXN1pHV2ZtT2JZR0tUeEpmMDY5?=
 =?utf-8?B?SU9BdWJxbVRxdzU0UzkrUDhLaGY1eExIV2dsTmFKVVpzSzA1NGhaR2ZxN1FB?=
 =?utf-8?B?RFJubVBHcFdvU2FOaFJHaHFQMHZxelcxSkg0Nk84cVJ5ZGl6UkFUL0gyVk9Q?=
 =?utf-8?B?NFlMZjViMzFFbEJlSWlXbWRwZFdiM0hPNGFPbGc5UWRPWjlCek9FeWdya29J?=
 =?utf-8?B?dWxpZ3cyZjhqbCt3aWoyd1JiZmNFdSt3R21CMjJ2TWxkVzNJeHg1dEYxRnl2?=
 =?utf-8?B?RjI4eERnNkJXYWd1R1NGanZLWmVkYkEzclBHWER1MWZLMmhPMFlOUnRHTFN5?=
 =?utf-8?B?Y09yU01XZjRwN1RnUkpNUWxCUEdIT2kvU1B6OFZ4QStCUXdSWWt2TzVnSVBM?=
 =?utf-8?B?OG9sZy80aThLVitGMm1GZzM2MzI1RDlaYTRZUGh2cldjM1hDSXV0TlJsbDRV?=
 =?utf-8?B?ODRJR2RPV1dGYWJycDhRM2xoell0VS9ERDVRZjY3VUtnZWpneWQ0YWpoUVBo?=
 =?utf-8?B?U1QydDdTWFZ3NzJZWXZnZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1dRZ3VCcEROQ2dETisyRmJJdVpMK1lOazBaakdMNzc4RUtDRnZWYTFmTUVp?=
 =?utf-8?B?YnRicFZvQ1Yvdk1PdXZUbkxHRWhBekFhNUZsU05GK0JjUTZmcFlzNGNJRVl6?=
 =?utf-8?B?d0tDL2lQK2IrMWNHdW5TQjlzUHlSTXNWL1gzZjVMakNhVTB1Z3RtNzRPRDR1?=
 =?utf-8?B?ZXUwd1FqZmZzYlc1ZDhMclFibi8rRExJcXR3K2JCRVZYMXpiaEVtYVAxTUxp?=
 =?utf-8?B?Q1RJdGNNUFlxMFhwWEJ1c3VCb1RKQnduWTVqNW5xL0V0QitoNm9pb1YyN0Mw?=
 =?utf-8?B?ZGRRalNLaXVvUzRVcWxLK0dqZWtYQXlMdjhya1o2ODl3ajZQdEdKblhOckpx?=
 =?utf-8?B?RkNyWW9tUGFCb2tBaGozcUJDelJ1Ymw4dGE3b1VuajFHWnFiZWNMZU9CT2Vx?=
 =?utf-8?B?cEpjU2xkdlNCMHdJNEYwNGhibWluOThSczVwS1d6R3JveTFISElGUHlHY3o0?=
 =?utf-8?B?cWxPSm12aXhPWWhZZHFzdTVoUWxyZWpHMnF4SzdVeG1RNGtsSGUwdEhwMGdW?=
 =?utf-8?B?WmtwWXB3UUNwSkNiWmp4b2NVaHp5N0hlUW11QVVrcklGS3llY2dBMEpHMTRi?=
 =?utf-8?B?VGwxcUNDL2NUL0FQRTY4azl4WkpiclA2azF4TjdlZVVwcm1URFJkYWhNcE5X?=
 =?utf-8?B?Q1c5cGIyU0s4RExqdE81M1hOUDdKM2VKdHdGTXBIdklYSDFpOXl6K3NNakJt?=
 =?utf-8?B?Um5Xd08rUHk2RTFIR0Vqdnd1L3U4anBKZmVueXFpc1JHQUErOTNCc2JXVyth?=
 =?utf-8?B?amRsS0FERU8vQ1pZV0dWc09XVzYrTFhZdnV3QURDZGI5VXE0dk52MVBnMHdW?=
 =?utf-8?B?U3dwNXoyWTREVlZlcTR1ZHl4SEhsQ1RTOXRaSkN1aUVGajAzM2lvcFFQUThq?=
 =?utf-8?B?eGllUTN5SHkxdE9RalRqVis0R1daeVFuZGxuV0xuTEJ3UWNQdWtuWlRqaERC?=
 =?utf-8?B?Rmx2RUJaZTlmVDkvL1A3eVh2T1NWMk9KRnZDT1RJSkRaRkRZQVJ6anNBS3Mv?=
 =?utf-8?B?M21xOWxMamJIT0ErU0srOFZXdVZWVkRSZVpOWWl4Z1AxR21EandVcEJOamFh?=
 =?utf-8?B?aDJWNTlPUEIvZXhtcmVLcks0TmpremN4OUZOcFlxUzFncU9iNExIT3VLaGl6?=
 =?utf-8?B?UEVKNDRnSFZ4Q3ZzcWhiR3l2UVoxY2xFYWR2WW5FQjdrREFpWHhoWUt0K0dH?=
 =?utf-8?B?NG8vN0ZHcUdjRVNOY2t6TFRyM3JERzZOQlNSQlJVRHpYMnVDeklYMGJZMzNv?=
 =?utf-8?B?eVhPN0NGU0ZwYVByRzNBS3V4YXdwTjNKYll2elFyN1hWVzJ3WkYzN09uQitz?=
 =?utf-8?B?MkNBTnNOL2MwU3dubmM4VkVzV1hKd0RKMFd1YWovUnlrTWVZSnNEZXZnQ0dh?=
 =?utf-8?B?czY5MU5uUy9uRGxqeGtYWE5ubFo5SE9wa3VjUTQxMm1Sakk0aTJCOTdkem5m?=
 =?utf-8?B?L1VGbngzMmRoVVlkVnFvOTR3QTN3eHQ0RWVETG1zSm1QWUQxOVVSalRxZ2tX?=
 =?utf-8?B?RDV4QWNWWUxkN1BVcGJuRFlDR2NwNzFid1BjcUVvb3NpcHFaaEkyTTlkd21a?=
 =?utf-8?B?RnJqdzZTaEVSYXZ4RFl4bHJCNlRoc2xhWENhRk50NFFqempqOW5Ddk81QmdX?=
 =?utf-8?B?dVQrYjlMTExIcHQxN0lCWndxVWlzQy83VGNQdWExZk95OC9KU3hDT0plajVH?=
 =?utf-8?B?bkJVVW45VVdCMTRQb1Jmc2FlRUcvTTJHaFpRalpUd2gydlAzWGxEUXFHQjg5?=
 =?utf-8?B?MGdYZHRsek1xdkZxMmVnMG54bmRLbHNmZ25XalcyN01GUzNqVVFWa1hIL1Bw?=
 =?utf-8?B?QzJ1TmNqOXQxNXVTZWloZEVmSnlMMGhHbXJUK1ppenk1WGdsNnF5cGtiQnBz?=
 =?utf-8?B?eTVWS2V0Z3VyTk43U1YyU3BhNTJWRE5wdGhyZlpTQTd4YktIalRxcWh2YUFU?=
 =?utf-8?B?TStIeUVlbjBWZWlpdytQdTF1bjdrcWJKVmNPME5aL3Q4ZTlnc1lxN09JOVcz?=
 =?utf-8?B?bHpJbXdNbFd1eDczTTZsMEppbUJMZTRwdlFxbW1Ba1RkTm9iWnkyMHNCTFUz?=
 =?utf-8?B?aUs2b3dlcnBYMUkvZTVWUEdFbHhCK053QVpFQi9Pb3o1YkxNRVhYUHh1eWtP?=
 =?utf-8?B?dVFVc2hXWldTdWVvNkFoTHp4RFFaSHh3QTN2WGp5cWxwR0krNm0rS0V0VkNV?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o+GXUpxzEgHVSrARZGDP3PX6POWtay0qcJjKmYRJPkeMTsInXkHc7yzVfUvHYiCouq7wHfBXSgaimsIE3FxCsG9scaFLYYFChRYaHHZ6ht8GEhUpjEEKKXCAqKRk3Cp5iJ4RKbNAvso7+qH5OrIDwt5nnt2pC5fVnFq3bGIKXgUXMZM3YFR247wAKRF7K7k4lxRLS9lF0T4klAwYKuDRwjFkw7Dy7Y55i/OYdXxqceUAo34f/MbPRDcacAsVE45vvZrvBwfRBkzC83hjTlhH5sN1Q44pw18zcfN1rBk6JEPnTIvpiCxkfl5D3kjz5hPipqchFuC8IsTAj3t4jOtwmy3iJ9ERSH3ubnH+ZwmF25PTWT07J/LrsFmGOa07DsYkVQRyKaH5ZAAp1WG+q9cQGD8oM2Xc1lm4k7Q36/FQVvEV+2MbgEbhKDki/EXYSLJiAdVLmxf5JW20dUUO/LvlAKHalza0AZt50xSwV/5S5kE2IUVNnmhpwWgn/2Meh4mo7RQPnOSShOXLRD5CV9nMXaIPmfW0wiqqs717YCCowZp5DWyNM/1csNy4G/jMUVSQ0CrjFYGuW2UJmKGV6pCC0ozt8yN7fZfOBlmEiDlWeaQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f363d7bd-fdc2-4aff-d805-08dd4bad1d0e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 21:35:04.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOgHsmP/LwgLOLIWTjB7+uxF29wA7S0dgzXT+MN6bgJNDjoEOYTvWp759Bdn5jHHyYXW661cmF+WJMKqANj2+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120153
X-Proofpoint-GUID: bmsf0_AnRfpFYYPr5ofTzbieRHlyH75q
X-Proofpoint-ORIG-GUID: bmsf0_AnRfpFYYPr5ofTzbieRHlyH75q

On 11/02/2025 8:24 pm, Thomas Bertschinger wrote:
> According to PEP 632 [1], distutils is obsolete and removed after Python
> v3.12. Setuptools is the replacement.
> 
> There is a migration guide at [2] that suggests the following
> replacements:
> 
>      {distutils.core => setuptools}.setup
>      {distutils => setuptools}.command
>      distutils.dep_util => setuptools.modified
> 
> Prior to setuptools v69.0.0 [3], `newer_group` was exposed through
> the now-deprecated `setuptools.dep_util` instead of
> `setuptools.modified`.
> 
> Rather than updating distutils.core.Extension, I remove it as it does
> not appear to be used.
> 
> Link: https://peps.python.org/pep-0632/ [1]
> Link: https://setuptools.pypa.io/en/latest/deprecated/distutils-legacy.html [2]
> Link: https://setuptools.pypa.io/en/latest/history.html#v69-0-0 [3]
> Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
> ---
> I'm not deeply familiar with the Python ecosystem, so it'd be good to
> have this patch reviewed by someone who is.
> 
> I needed these changes to get pynfs to build on an Arch linux system
> with Python version 3.13.1.
> 
> I also tested on an AlmaLinux 8.10 system with Python version 3.6.8 and
> setuptools version 59.6.0, and it built succesfully for me there.

Applied.


I asked a colleague with greater Python expertise than me to review it:

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>


thanks very much for this, Thomas.

cheers,
c.


> ---
>   nfs4.0/setup.py | 8 ++++++--
>   nfs4.1/setup.py | 4 ++--
>   rpc/setup.py    | 4 ++--
>   setup.py        | 2 +-
>   xdr/setup.py    | 2 +-
>   5 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/nfs4.0/setup.py b/nfs4.0/setup.py
> index 58349d9..0f8380e 100755
> --- a/nfs4.0/setup.py
> +++ b/nfs4.0/setup.py
> @@ -3,8 +3,12 @@
>   from __future__ import print_function
>   from __future__ import absolute_import
>   import sys
> -from distutils.core import setup, Extension
> -from distutils.dep_util import newer_group
> +from setuptools import setup
> +try:
> +    from setuptools.modified import newer_group
> +except ImportError:
> +    # for older (before v69.0.0) versions of setuptools:
> +    from setuptools.dep_util import newer_group
>   import os
>   import glob
>   try:
> diff --git a/nfs4.1/setup.py b/nfs4.1/setup.py
> index e13170e..bfadea1 100644
> --- a/nfs4.1/setup.py
> +++ b/nfs4.1/setup.py
> @@ -1,5 +1,5 @@
>   
> -from distutils.core import setup
> +from setuptools import setup
>   
>   DESCRIPTION = """
>   nfs4
> @@ -8,7 +8,7 @@ nfs4
>   Add stuff here.
>   """
>   
> -from distutils.command.build_py import build_py as _build_py
> +from setuptools.command.build_py import build_py as _build_py
>   import os
>   from glob import glob
>   try:
> diff --git a/rpc/setup.py b/rpc/setup.py
> index 99dad5a..922838f 100644
> --- a/rpc/setup.py
> +++ b/rpc/setup.py
> @@ -1,5 +1,5 @@
>   
> -from distutils.core import setup
> +from setuptools import setup
>   
>   DESCRIPTION = """
>   rpc
> @@ -8,7 +8,7 @@ rpc
>   Add stuff here.
>   """
>   
> -from distutils.command.build_py import build_py as _build_py
> +from setuptools.command.build_py import build_py as _build_py
>   import os
>   from glob import glob
>   try:
> diff --git a/setup.py b/setup.py
> index 83dc6b5..203514d 100755
> --- a/setup.py
> +++ b/setup.py
> @@ -2,7 +2,7 @@
>   
>   from __future__ import print_function
>   
> -from distutils.core import setup
> +from setuptools import setup
>   
>   import sys
>   import os
> diff --git a/xdr/setup.py b/xdr/setup.py
> index 3acb8a2..3778abb 100644
> --- a/xdr/setup.py
> +++ b/xdr/setup.py
> @@ -1,6 +1,6 @@
>   #!/usr/bin/env python3
>   
> -from distutils.core import setup
> +from setuptools import setup
>   
>   DESCRIPTION = """
>   xdrgen



