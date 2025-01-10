Return-Path: <linux-nfs+bounces-9119-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B31A09C71
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 21:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE02A188F3AB
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 20:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8890188A3A;
	Fri, 10 Jan 2025 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aDzQHBnp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sqgtHTnS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F5ECC
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736541054; cv=fail; b=JS9w8ZOViyBAUofMVkFkctsa7nmhyA7KhH4XbTicYOqDw2QtYcll7Na/Hr+uMfpOuPHrZs9AvssMEg9Oz6c/y6EUzU+0w//7yBEHOYzlJIekrgX+YYYoAMrCZPA9u7vhRblrKG7PYGhbA6ALIZi0gTV0jSeYVpjPJgLiQ3daU4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736541054; c=relaxed/simple;
	bh=ts0DyWyqwbZ7MFnhGL3qh3ROpx0+lCxhUZ0M8pd8MSo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lRUBzf32QLrgOJ+iTvn//bM+H5PiJEVzhSwsBXfKWtFowTB/UvQ1WZDeZD5U/mJPM4SQzheQ/vtUcM1EZXhKHDZl9wkv5qf/dwebjsxe5ZZmmgn0ulflzaYGLOoB614i0S+alV9RYwXcBVOfKgGLe53n01Auz8ba8SGYiJOcdto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aDzQHBnp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sqgtHTnS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AItnQD030861;
	Fri, 10 Jan 2025 20:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mOy/M0bhTQ9YQy7lkLxDC6lCRg52D/imIvTRuzcZPFI=; b=
	aDzQHBnpY/jB35DyRyvsKi6up6OJgVrhYZCRNJSb5SrLO8JIuibOAs64oIxov1D6
	7gcG4tfzbyhGXLnlV4z8Zrw4uAHzgghO0RokoVFdFqD2dtMUbJw9vZOJAir39u+r
	C3dZl7o1DgP2kDOkx+6paQRNQdccDGVK3CVKdvkhAPUb5OtVWDxa2qxt6WIyIuLM
	+VFb8lsT9Xf/7bVuRCcwNrfcOY4VCZ65+4s6SAG2pU7z44+lcV/OoLYTpygIjckh
	Ji1o1q2H34eDruWqoeUuMse64ctc38bRRXVTfxHpZ9GmsTpCMwHZ9FLOHOug4JjU
	ZXL2BxjmDmR91FZf7//fHA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442kcxa97f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 20:30:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50AJavQ7027615;
	Fri, 10 Jan 2025 20:30:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xued4drh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 20:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/5qhSZNNcrzGlVndQGytd6hx6SNRSVxjzbCR3ZnTo7YnxBmzZ/NzIRyfZRWt4/ZxCpNDzzJBxcAVZZlbYmdNpKCgZJ1io766G2zfgBAGR8V/JRboniABPhcjELcS3fxiBEsGrrC9qSS8ZeGF1fLXeglGpDSaglPEr51QGN7yFh6VtbtNEAXDMCwW5B0bafhXMiNndS97l70bbQjrLpaFjaOSLEpVshdFE4t5U1kOTn4l6wBa+9OU1TDbvGbwq4TxaBpCGipSfpKuT7sHgPLct/HJwyMn69YjYhgGClR4EDCUGsIf+SPxnxjq5udujE2CFxTSfkCihGVl/HnNyBHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOy/M0bhTQ9YQy7lkLxDC6lCRg52D/imIvTRuzcZPFI=;
 b=AK9pH1EHBvoCjrDwAD38jnQD6IAdv7KXC3oel+W305c6bHzk8SU3mdGztdFlShAyF58H3EhkJyz5q/aVEW/zA3JajQRRgAZFkpfHpScPoMzwBK1cFaeW4X0b/CiO3h848ZxE0LpdUd/5IhO8pSLAQf/eFt4qITR0EELCTPXBMGDIUP1HreRtUGv/BQfg59NBF7AvEZAbMO9tCy0wFAHD6EhTjCJOYi1Lz4s60j+9Wa+0ZJRXF09w7N/jnGXQeKNPkoU8KVwblJjWXuj7hPwzlrygh9l3k9nKL5NfEH6z1NZmLptpbBG/mQf2Xtnna4ryRwFEGnlbHqGKvEGcpfl7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOy/M0bhTQ9YQy7lkLxDC6lCRg52D/imIvTRuzcZPFI=;
 b=sqgtHTnSSa7k4tBv9moUoidr5A4i/PSoY3VmRWQiQdO/m5P+NoYs8jo2EUCMm6JCj0OJfFRGQwTzAgE51QcLhbQyF0Ja+z3t/VBQIrLZrgUbxnK9ETte5mj4P5F98VjnyNPetsCa8pdBb4CIQOixCa/qLHHAXfGrT8k4YPU604Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4583.namprd10.prod.outlook.com (2603:10b6:510:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 20:30:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 20:30:47 +0000
Message-ID: <d54d71f7-9bdb-49a4-8687-563558eca95e@oracle.com>
Date: Fri, 10 Jan 2025 15:30:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd4 laundromat_main hung tasks
To: Rik Theys <rik.theys@gmail.com>, linux-nfs@vger.kernel.org
References: <CAPwv0JnSQ=hsmUMy0VY-8k+dANBLNkJdFJ75q9EEE+Hj0XXB8A@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAPwv0JnSQ=hsmUMy0VY-8k+dANBLNkJdFJ75q9EEE+Hj0XXB8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:610:11b::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: 746b47b5-2d91-4e02-efa7-08dd31b5aa0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEhDZmt3SVVleWs2Z3pTWjdIMWRvbkNidDVJSENURDBrdjIwbFJma2U0Mmxs?=
 =?utf-8?B?OHlzYkZNZmNpT2xjaEdETUdibjdSdHI2K1VpWWd5UVlqZTU2QnNUWUh4LzRi?=
 =?utf-8?B?SUh0SHhOUFdJVkVndXE2eE0rbVBuYXFFMExyMzBqMXlzWGFBdVB1ZVpyMktt?=
 =?utf-8?B?K2RQZjNYUUlHbUpWTU1od1FvNUg3NmhZQjNTUDAyQklXMkNZY3NRT2hWaXNF?=
 =?utf-8?B?dGN2dThkam16ME1lUFpKYnBZZUZVRkxIK2xkZVowVjN2STRXWW9XNFpXdlJS?=
 =?utf-8?B?dmt6Smx5WEVha2hpc0NpbDNGMUVaMGhqT3RaVHEwWURlRFNaQU1iRlpVQnMz?=
 =?utf-8?B?c2dmN3FiVDg2Rml4aEJEOW5VZWpyU0NPTis3NzA0N2JtVVd1dCsySC9vMVZI?=
 =?utf-8?B?Ty95MlR6K2crL1JPSUVGcFhZZnFORHFsMFRGVDRxUng3d085SmM1dmlMWGJG?=
 =?utf-8?B?dS9wVW9qRTRzUHREaEFsT1B1ZFlzZnBJSGpxWmxHMEVTZm11VlJZeDNTTStx?=
 =?utf-8?B?RjczVFFlWU1SRFFqbG8wNnBGSytCdXNzS1c0WVFmV3JjdEphT0RLYnc0UVRT?=
 =?utf-8?B?enZxcldaMXlFR3UzRzJNTGJObzdqV2dZR1NoTDNscG5pYzZ5ckFvbCtnSnQv?=
 =?utf-8?B?OTFDK0FnL091S2Irak5qdElTeWpCZ3B4NGJScGNIWHYzb0EvNmNDcGljYk9x?=
 =?utf-8?B?Z3R5NXZSdklkWWxicHpubDM5dW5CY0NMUk5sQnNXTmhWSlNMcWF6ZmNDcTQz?=
 =?utf-8?B?VGdncnRxMTQrMmRmRzZXVEMzSGlRMU1MaDRFVllpWjVibWErOXVIMW9aWjNH?=
 =?utf-8?B?R0hGc1d3Q2Z0VEZ1T2xyNGpySytvcTk0ejg3MWRiS1N5NVlRNE9GVUU3NUhj?=
 =?utf-8?B?L29DOHFuSU5INVRwR1U0R1NoSEhXSXcwNTlJVjViWURxZ09UWEIyUFhTZkc1?=
 =?utf-8?B?Z1pieEZUVGsvUVdnT2MwWTZtcDJsS0dxRURoNnhqT2RUZUtLTk1RMzhlZ0or?=
 =?utf-8?B?amd1UTBMcW04NVhrRzBQZ0VvVlNlb0M4Y1doMDZndVZIcUdmSitFckpZSGdP?=
 =?utf-8?B?UDF1TWF3SGtOM3dZOGoyVHVNTXY3NWd0YUtpeVBHMWVUeEdtajdrWmNDa013?=
 =?utf-8?B?bWdIYVVPcXQ4T05yNEFDMHIza2ZUM2lHQkpZSmRtT2EzWkhSSTR3Z0kxbmtC?=
 =?utf-8?B?WTFNQ3IzOWVjUmpPQzZaaWtYQitsc1dxYmRWSTNTWUpEUVNMRkJWMWVHMDB6?=
 =?utf-8?B?b0pzZ0VYVmdUSkhuQkZxNGVzSUk4SVNsR1JlTkZnU1c3UXN1TU5qVEJyQUw4?=
 =?utf-8?B?TnJmaGhXSHhRYWgrQVFTcmowTWtKbHI5T1VmUlVYeldnQ2QzWDdNSnFSTWtE?=
 =?utf-8?B?OFJidmM3Q0FyT0lFSlFoZnEvQUx4U1drbnhDUlRVQWRBNExUV2dQSHVMcGY0?=
 =?utf-8?B?OWtRanQ3OHBRWEZiZ0V0SjVTNWtlVnVvV3U1dEMxTXFPQkpZbldNbkZDdEFW?=
 =?utf-8?B?MTFZZDZqZ3QySVA2TXdvaXZHTHZJaFcvaWFsaDZ6N2xpTTIyK2NwK3FlVWRv?=
 =?utf-8?B?ZGxINHR0THhRRnJFWkpIdkpoSTgrWTF2K3A2SG5iVnNNS1dENmg2QlQvdlFS?=
 =?utf-8?B?eVRZUFJpTk1La1hQbEQyajBlY0xTY1VkRXU0YzZJN1JNRnVnWUwzVFhxNndZ?=
 =?utf-8?B?RmszZjQza3pHMHNqaWs2V2lTamVqZE01SUNBUDEzOVBTbVdmcUxSclE2QmRX?=
 =?utf-8?B?SENWTXBsclh4Mk5oTHdZa0RKUkhGeFdpSzdZcmdFdFFYZG1kT3NpOGMrVyt4?=
 =?utf-8?B?VmhZV0pRMlowV1JOMjROdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmdBcGRVSGNielJPbEhIUlBHTUh5RGJDckx5T2lpM0ExRFBxUlAxZER6ZHB3?=
 =?utf-8?B?ZWF1YWhtekg4VnM5S1VZSkVlS00vbW5GNUlQeHQyclhiZ0lmM3R6S3ZsQWVv?=
 =?utf-8?B?YlQwYzMwd1RXRkJTWmw0YzB5Vm1GTnI5RU1XUHdnNlBRVmJFcitZc2FwVTNM?=
 =?utf-8?B?bG9KeVd6N0N4YU42QWNYWGVWRXk1V0hoZ3MwOUwxcG5na2c0OTZ2bTgzWjkz?=
 =?utf-8?B?VkhGeFFpM2lMcFR2ZHRpalVNc2d2cytyQXdsZnk0UFRrbldiR3FnSXR1SHJh?=
 =?utf-8?B?RHJMRzV1Z201MVlCWU90c2tZa3Q4UW1WYWVkb3JTZmZ5clBudVEyQWFYOGZB?=
 =?utf-8?B?TWlRMy83QmdhaUxBUGEwUjQweFlFQ2pocHlTSVg2OTlGbWtEVXgvT1Qzamxr?=
 =?utf-8?B?QVlieHhsc0NEdnlmeGdjcE44OCttQW52ZDV0ZkowRmkzODlFekJBdXZMbzJt?=
 =?utf-8?B?c2dSWTZ5YlpRakpBSE5mZGlJWWJnVndEUzJRSXV2aWlwczlETXdvcEpUYWNx?=
 =?utf-8?B?L20zSEM3Rm5JY1M2eUkyTHRPNmdzYmhvNFY5Q0QvRCttTDQwMVQ4cWd1OUxD?=
 =?utf-8?B?S0tZWEVoNmVock1iQkxDVm0vWmZoRnZ3V3djSVJkdWhzRmdvZ2ZtVDU0c3Vw?=
 =?utf-8?B?aXdTUTNIWUxxcWYycVdQTnd5bWZTbWF0dVg3d0ptS2UzL0xnMUJTVVA4RVFa?=
 =?utf-8?B?WkphVjA5emZyWUNDa1pVVVpRcEVWNjc3dzl4SDJEWHFGd3dwUEV4MUptaEZR?=
 =?utf-8?B?WjUrWk5NclVEcVI4MHIyOVRHc1BXMERMWXNaWVZzSUExc252emsyS3pWdExG?=
 =?utf-8?B?WW9JVVRBWmNPam9hR2lXZnNPUlVJR2RKOFZiVzQ3RlRUNDErVTB2SCtvQVoz?=
 =?utf-8?B?UHZZQWpBcjkrb05aUC8yVnFERHYrTHJvcDMxNFRnd1lTTGRodUpHdG5UMmlz?=
 =?utf-8?B?TWZDTHo3cU8relNjUEUyNFYyMVV0ZHFHZ2F0SmRCOUVSUHBaQTNjYmV2bnNw?=
 =?utf-8?B?bGtUdkNrY045TlJRSEJqcWdUR3dyTW1PQ2d3aTM5cHhOWndDVXR2SmNiY3VX?=
 =?utf-8?B?SXhtS2sweTNSSVBGYzAvVFZ1aU03UGcrelorVysyOG0xc3lvdWpWekdnRlgx?=
 =?utf-8?B?djlKL1NBVklVMXZhUmwzbzlQY09oSG5OQkdBZllHTGYvZDQ1YXpsQ1J2YUwr?=
 =?utf-8?B?eXZFQmRNSmZ1Uk9BM3hkUGFoNVZocXNidk92aVQzbC9BYXE4MDkyYnZTaEla?=
 =?utf-8?B?WUlWcklrN2JWS3hONmlLS0lYWUpZM0FpYkFVbHIyQ2RzQzBDN2p4ZDZ4Y1Fr?=
 =?utf-8?B?NTFvdlUyOHV0djd2cTk2eHQzclZ3UUZhT1pCLzZScDlXYm5XL2JURnM4aUlB?=
 =?utf-8?B?UTJTWlBmOFdRVDVmZWd6RGZmdWRIV2tONFNFeTRsdnpQb1MyUmtTN3VBa3Nj?=
 =?utf-8?B?UjVyY2s1Mk5KRmdZRFBheXdJb2o1N2lCTEJ3VFpOY042SkIraGpQS29yK0Z0?=
 =?utf-8?B?VjQrV1BaRGU5S3Y5NkNaY011U2U2RGpzekFYaGRXeGxLUXd5TG02Lzk3WWZx?=
 =?utf-8?B?QldzN3ZxYmJucGs3MGZRYkJ5czNDdVdDRVdJaHFLem04Qjc4cElGVUQyYldl?=
 =?utf-8?B?azhCTi9mNGhhQkNIOFVqRDBLRjRpQXZ5djFmSUc1Y1didWdaaXNQWmNXUXJm?=
 =?utf-8?B?ak5MTytvNkNQbFlXeXZhR3lqS1hMRGdGL3ZBWUZKTWkxdmswRXQwZi9Na05l?=
 =?utf-8?B?L3dJZ3JOUmIxYmVjZ0lNTjIzYXlrWm1TVHdJSVlFUkNRTWNsekdKMy8xcFRS?=
 =?utf-8?B?NDJyVk9FTllNb2N5UWQvMXRMTFJoRDVubHRhZFM5ZndpSDRTSGZNdm9QUkhm?=
 =?utf-8?B?ZG1yTFFSSi8yTE5nbGVSMkFlUm5nK0xWcWZDdTFlYkl2ZVlrbEl1SWYvSkgv?=
 =?utf-8?B?ZExzbFdDNysyNVlIUVN6U1VGTVI2dTlaQXdTcFZaR3QyOWF1bjFLcXB4MTJP?=
 =?utf-8?B?b25SS2FCZWk1YkpHQThlODE4L3Q0MEt4Q0xFcEFGcG9iMTd3SnYzNi9iRzRj?=
 =?utf-8?B?WnJkR0NZTmlQUmhNZC9LSXNvVlpDR2lrY1paWUxIZ1J5cTRrQlhzMEVGSXIv?=
 =?utf-8?B?QXhNM3JuTVd0dXY3NDNTMFphN0QxUmV1NXl3aVNJN2dKeWNnOXZCdkwxbWJj?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M+LfcHO+WAMn0BM/THyDNmI9U7AngaFte3ejE2Rw4VPUXTXY1B/r0e0i9S8jam/rRrkF4r03rLDPMGOKzmgf7S/pY+8qu6ZOCtyrlSlFJ99KAs6+lfDQN6lTsTfHvtS8qQWdOv+KgN3JtcsTa2GeI4Z2umP88f6aCDm9KCLJSmeQefPULLQL+KG1wIbbWyyYMuRpJ3LKKLnuJxM+4o/1rDYxhGMtm58c3VeBhmM8jL1epm89HonGa1L1H86zfwVJGWDLrGjD/4YEteMSkjP8P5JYgERvQKWMAAj1nKZ+djtRnZoIg7WCDShVdYSN319rA4wZDucD5CVh2XuvsSpugmCJO90YtC+SxUEbh7C6HmkOQKIJ/xafdGP3POA+Xg5Jl5cIds/lCOQSGwethmkecvCwkvPodClSy8N9pdU4IKmE9jb6sG9ceaKimH265JLbaNqM6YVxdWOvmsUxvjxGfFbmhQoIQAZfAZe9vyTFW7UGtdHa7QSUjFRxqdxPSi5gEmc61kE42qpC5gUINOW0VINsZvYDEAmOSJm9Yn4+wLTRiuzqT5dNWbXzUCW+ndelQDUG6vvj9mKIiCzQTduOprkIfjoAXxkZAz1Sc1pbJDI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746b47b5-2d91-4e02-efa7-08dd31b5aa0b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 20:30:46.9621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6C5NazzRFyvjnvWwVRcOvcfYDmpeOpuT/qSBZYdEJL6fl56gD+/Z7PRO1QCWry6B5rS3U349+doVo7+SrxUajg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_09,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100157
X-Proofpoint-ORIG-GUID: mkKeGOi99J_hTLcA9SUMwIUQ0djZrLN3
X-Proofpoint-GUID: mkKeGOi99J_hTLcA9SUMwIUQ0djZrLN3

On 1/10/25 2:49 PM, Rik Theys wrote:
> Hi,
> 
> Our Rocky 9 NFS server running the upstream 6.11.11 kernel is starting
> to log the following hung task messages:
> 
> INFO: task kworker/u194:11:1677933 blocked for more than 215285 seconds.
>        Tainted: G        W   E      6.11.11-1.el9.esat.x86_64 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u194:11 state:D stack:0     pid:1677933 tgid:1677933
> ppid:2      flags:0x00004000
> Workqueue: nfsd4 laundromat_main [nfsd]
> Call Trace:
>   <TASK>
>   __schedule+0x21c/0x5d0
>   ? preempt_count_add+0x47/0xa0
>   schedule+0x26/0xa0
>   nfsd4_shutdown_callback+0xea/0x120 [nfsd]
>   ? __pfx_var_wake_function+0x10/0x10
>   __destroy_client+0x1f0/0x290 [nfsd]
>   nfs4_process_client_reaplist+0xa1/0x110 [nfsd]
>   nfs4_laundromat+0x126/0x7a0 [nfsd]
>   ? _raw_spin_unlock_irqrestore+0x23/0x40
>   laundromat_main+0x16/0x40 [nfsd]
>   process_one_work+0x179/0x390
>   worker_thread+0x239/0x340
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xdb/0x110
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x2d/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
> If I read this correctly, it seems to be blocked on a callback
> operation during shutdown of a client connection?
> 
> Is this a known issue that may be fixed in the 6.12.x kernel? Could
> the following commit be relevant?

It is a known issue that we're just beginning to work. It's not
addressed in any kernel at the moment.


> 8dd91e8d31febf4d9cca3ae1bb4771d33ae7ee5a    nfsd: fix race between
> laundromat and free_stateid
> 
> If I increase the hung_task_warnings sysctl and wait a few minutes,
> the hung task message appears again, so the issue is still present on
> the system. How can I debug which client is causing this issue?
> 
> Is there any other information I can provide?

Yes. We badly need a simple reproducer for this issue so that we
can test and confirm that it is fixed before requesting that any
fix is merged.

An environment where we can test patches against the upstream
kernel would also be welcome.


> Could this be related to the following thread:
> https://lore.kernel.org/linux-nfs/Z2vNQ6HXfG_LqBQc@eldamar.lan/T/#u ?

Yes.


> I don't know if this is relevant but I've noticed that some clients
> have multiple entries in the /proc/fs/nfsd/clients directory, so I
> assume these clients are not cleaned up correctly?
> 
> For example:
> 
> clientid: 0x6d077c99675df2b3
> address: "10.87.29.32:864"
> status: confirmed
> seconds from last renew: 0
> name: "Linux NFSv4.2 betelgeuse.esat.kuleuven.be"
> minor version: 2
> Implementation domain: "kernel.org"
> Implementation name: "Linux 4.18.0-553.32.1.el8_10.x86_64 #1 SMP Wed
> Dec 11 16:33:48 UTC 2024 x86_64"
> Implementation time: [0, 0]
> callback state: UP
> callback address: 10.87.29.32:0
> admin-revoked states: 0
> ***
> clientid: 0x6d0596d0675df2b3
> address: "10.87.29.32:864"
> status: courtesy
> seconds from last renew: 2288446
> name: "Linux NFSv4.2 betelgeuse.esat.kuleuven.be"
> minor version: 2
> Implementation domain: "kernel.org"
> Implementation name: "Linux 4.18.0-553.32.1.el8_10.x86_64 #1 SMP Wed
> Dec 11 16:33:48 UTC 2024 x86_64"
> Implementation time: [0, 0]
> callback state: UP
> callback address: 10.87.29.32:0
> admin-revoked states: 0
> 
> The first one has status confirmed and the second one "courtesy" with
> a high "seconds from last renew". The address and port matches for
> both client entries and the callback state is both UP.
> 
> For another client, there's a different output:
> 
> clientid: 0x6d078a79675df2b3
> address: "10.33.130.34:864"
> status: unconfirmed
> seconds from last renew: 158910
> name: "Linux NFSv4.2 bujarski.esat.kuleuven.be"
> minor version: 2
> Implementation domain: "kernel.org"
> Implementation name: "Linux 5.14.0-503.19.1.el9_5.x86_64 #1 SMP
> PREEMPT_DYNAMIC Thu Dec 19 12:55:03 UTC 2024 x86_64"
> Implementation time: [0, 0]
> callback state: UNKNOWN
> callback address: (einval)
> admin-revoked states: 0
> ***
> clientid: 0x6d078a7a675df2b3
> address: "10.33.130.34:864"
> status: confirmed
> seconds from last renew: 2
> name: "Linux NFSv4.2 bujarski.esat.kuleuven.be"
> minor version: 2
> Implementation domain: "kernel.org"
> Implementation name: "Linux 5.14.0-503.19.1.el9_5.x86_64 #1 SMP
> PREEMPT_DYNAMIC Thu Dec 19 12:55:03 UTC 2024 x86_64"
> Implementation time: [0, 0]
> callback state: UP
> callback address: 10.33.130.34:0
> admin-revoked states: 0
> 
> 
> Here the first status is unconfirmed and the callback state is UNKNOWN.
> 
> The clients are Rocky 8, Rocky 9 and Fedora 41 clients.
> 
> Regards,
> 
> Rik
> 


-- 
Chuck Lever

