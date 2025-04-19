Return-Path: <linux-nfs+bounces-11192-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69327A944EB
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848763BB246
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF551D6DB9;
	Sat, 19 Apr 2025 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WpKIOjhw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iRVuxuaj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E01647
	for <linux-nfs@vger.kernel.org>; Sat, 19 Apr 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745085305; cv=fail; b=CVvCHaRrQA0sxj1CfHnk7+ZtZssZEhnlD8HkM9kUuQYQwpGHwg8Z7/sjMts5O1ljj6eaFQB+P/pXH3tlVfpJosDpYHrMuIHerAkRrUbvxTI3Swq/ycjq8p8E7QDAd4PJoV0voyKbnxMRn1GA8H5tiiegb6Lp7UMiFa2R7QLQlEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745085305; c=relaxed/simple;
	bh=FfaAn8wp+swoODHmzL6lVI4Ox58JwEonyAdPpeO6JCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uVmZdaoA9EsjJFJiTImapoYuqGLlrsKXLprp1GK1neWgo3iFmjCapzdT96bRLL1iDAzYM4V7txj6UL6MnJy/fyUcoQYWCSjTkgSfvvIQC5QS1cQCnlyOmqrhC6cjY/AFDltzQehFg7F5g+lEwuOaDI3j8UbU9/xTtXpjZ5l1sbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WpKIOjhw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iRVuxuaj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J9CV7p028558;
	Sat, 19 Apr 2025 17:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cIaLWH2JbFdz52Yl5gjnXNfg2YjHTY6TkXdKMCg7vmE=; b=
	WpKIOjhwLPlbVee5xZdEb8+vLwtfxmpen4TLoMUnulYn+BfUTDTT31v4bjn7pFqq
	DRuiYB4wQky03gL4roZejeA05Y8rUypB1snji/Xh6cAOe53eREAsqEqyZ6scrEX4
	ARe7k3mFJ3hMbcV6SYKY4ogSN3eYeSU4eI9XnuFsj+a99IwFKDA7lbPYmY3yt4tJ
	2kmHc2n387Duq/yaeVn+RV+6XgTY1c1TDx349QhifbCeJQTZGOr/xyvbmaEwVZHa
	o/yRxJE3QfHrVJt5gLwo5fyi0IMNopHkGVlzhX0zWCl+pdU6+iEtv9MZNoJbkS1/
	ALRL9rYUl2BnsPttBQVTAw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4643q8rewc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 17:54:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53JGCV9E021144;
	Sat, 19 Apr 2025 17:54:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46429d5x72-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 17:54:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPpShTki9P60hif2ElPulmOHKHZW3wCa+4GyYnydb+c/OEOFtZVszrSL4nmbEev/hByoK9677aGIkjAGx9hlE2PcZVx5LfxsugD02WifRWT7PHqz+XzJNn8ZjpUX6labHbzy65OcYLFkjZvCLMRjSBFzdAUoOCZg+tXO9HMx4AVrFv/BAK9kVc8EqYpxiFlUycNDddGJ7V6fLKKp5CVEfVYph0olt3WGZXueG2PyDPaBXmfbteOtCmVqk0+t2Ix6AXSeyF1IaP3ZxAL41eXtsPhyNlle9RK9LGpSSYQ/UnSZJtemDUxTs/MEWDIM6hFMRadWYT2OIhiIXZhW4Fr4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIaLWH2JbFdz52Yl5gjnXNfg2YjHTY6TkXdKMCg7vmE=;
 b=gY7FW7vDZuJEBGEKOlgpkZOGqFv51/3BlvHUzbfkj+BB7QYP4JZNzOSBDvcDwbv+nqdOE0zDiGnE81micdGUDw+0Wifz8lblHG6xgs5YRDGGakhIi582vaWj8CpNWCMgqlC0lllI/EM2zNh7vGf1zGpKXZZJiexQDdR+eqXi4XvQYMMJMbKTPPRo8x+iMSW6jkULX4bZHcjBLqtrFePGzV2LA1VnuBgR4uc8P0aZNV0z0ZcEyUWO0PZpyUWLxA+4EGHZifPomRvSraldXAwgUBXE9yXwD86+K3lQrxlZASHVcjFV2LwzGeIEAPZKbNaRpt8dsRsm9x11iWtuNcIXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIaLWH2JbFdz52Yl5gjnXNfg2YjHTY6TkXdKMCg7vmE=;
 b=iRVuxuajqsrOPAtstzCX7DYy+FZw3w3lA7nz+qUX3OiWHY5AGPqsXipvdvDFEZ7VP7E2bDwxajSy33RKYV/xlQe/HvQUPIY8Ab//z04X7P8u/0gN4vzUCWjuxM6kku1JoghEM7/7ZisKX5y413zJ0suv8avd2oetadRiCQALbfY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8162.namprd10.prod.outlook.com (2603:10b6:208:513::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.32; Sat, 19 Apr
 2025 17:54:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8655.025; Sat, 19 Apr 2025
 17:54:26 +0000
Message-ID: <7e78f840-bd34-4353-9a3c-b69b35f56ab9@oracle.com>
Date: Sat, 19 Apr 2025 13:54:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Allocate payload arrays dynamically
To: cel@kernel.org, NeilBrown <neil@brown.name>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
References: <20250419172818.6945-1-cel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250419172818.6945-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:610:52::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 257bdc40-b2a7-44cf-f64a-08dd7f6b39a7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dGsvK3dEY2ZtT1ptS3ZoWkYyWFdLTzNlZ1R6TWlQSm5JZW9qUnR1VW1Uamp1?=
 =?utf-8?B?UnhzLzZMV1Eyak5SZUU1K2phRDZBV21udVgxZElScEVKcUx4UWJJMExTYXhZ?=
 =?utf-8?B?alAxdEM1ZWpSdmJjOFlxdk9xY1p5ZHNYZERKYm5kWWpNMGdURVVWZloyRFZa?=
 =?utf-8?B?alpQUGNxNlVPTFlZeXZtR3NSZGlCejJNdHpHeTZoUFdyNEU0ci9QVlhjK1pI?=
 =?utf-8?B?YmdCRXM2S2JFSzgza3lRU3haeSs3MVFLLy9lSHZxSUlwdU1uR1BWVUhQcVYx?=
 =?utf-8?B?aitXZW1VeWlQLzBESkpVK2g5VHVIT2oyQUpPSXpLZUFhdHpGMlhUaTA3UTVU?=
 =?utf-8?B?UkhtQm1CdDhZSzNxclpHQ2YreTRBcEVHbkhPKzBXdGh1Q2g2TzA4UVAxSVoy?=
 =?utf-8?B?S1dqRFlXWkVybCtNa3RCL2FvYVozSTF3T3BkWFFvL3FuRHlzM2RLN0pkM0hD?=
 =?utf-8?B?dEF1M1JLNkNoMWtLR3RralFuUVJMK1ZwMnBzVEs5cFpGK0dVd2o5VW5jZ2Jv?=
 =?utf-8?B?QlE2V0ZuSHN3ZFdGRERGK2lRWHJzRTdYdDE5cjRuRUROem1CVzROSDl2Z1kw?=
 =?utf-8?B?OEcrWEJSVU5BNHZMSHk2TTNGZTV5YTdiRGxiZXdpeENkbFRjMHpuTklIN1JQ?=
 =?utf-8?B?eURyOHRHNjF1UkMrL0lQZDlwaWV4Mkh4Z09rYW9qeEZVclJYcGJuRFAyYmlC?=
 =?utf-8?B?a1Y1aEdrT052d05HRjA0LzBMTFRyd2pqcFEvY1dCV0poYkVySTFsMUhoZnll?=
 =?utf-8?B?L3IvU2ZSbTYrb1VRc2JsSG1VMC81RlVaWElFejFwRXd1UVowWjRmUE5pZEJD?=
 =?utf-8?B?dXBOc3hDU3F4RUFqS1NIQ3dkR1VmRHlRRGVXWFhRZ0U3R0xxVFRYVmJDc1JO?=
 =?utf-8?B?QnM5ZHJ3Wmhwa3FqaWF3cStzcUV2MUIrWmJBYVprZ2NNS2dqWm1TWEFIMlJx?=
 =?utf-8?B?UEhNYlA1TmZTQWFka1JUK0NsSHlnSjNXQmwxU1RrWUlocG45NndZNTFDU25r?=
 =?utf-8?B?YTErdUJjcXlRQ3NxQitCaTZ5TXk4ZlZodlN5c2hkQnVTSk5XWFFBUTFYN3d5?=
 =?utf-8?B?ZXNzeWpFZnhNYmZZNFFsT29seDYvNUpiWHNldVVOY0NoMjBtclZiblluRHNR?=
 =?utf-8?B?REpoV3dFbCtXRW51ekdnRk9MMUExTlo0dUpTY0hpM29PTERaSEx3dHlmdUEx?=
 =?utf-8?B?ZTBKbWJ3V0JPeTRkbURRSXc5VWNFWHF3TEZJZ2owTlpQd0RhUEJoeCtaR0sw?=
 =?utf-8?B?cG1xVERMOExFZi9RcHB1N1dXVXNNWUttbGg2RWpLZmJPZ1h1QWV5ZUJnc1Mv?=
 =?utf-8?B?QW9mMDhrY05KT1FYSnR0RnRZY2FjWE5PWUFsSzIrTDlFVWNwb2lhQzZaY0pw?=
 =?utf-8?B?NGJROHlWSGFmMnhqOE9CZG4rbUtwcmQ4U3FNNUl6RVVJTUdXOWNGaUNEbHlQ?=
 =?utf-8?B?TjJxRmpSZDlwV25rK2RrbXZZMkNSei82c3hqdzg5TmNuS1NlUTlFUEJMdmd3?=
 =?utf-8?B?Q1RrMjY5anJwOGFVQzJyZ0hzVmlOZVZyd0lhSWpCRkFQZ1RpOG9TMzNUaDZk?=
 =?utf-8?B?UUpFc3R0ZjZpdndRNTFieFp5MlFVdWUwU3VoZkRSQklyTkpiK3JqK0kwejVU?=
 =?utf-8?B?Ry9xYzJ3WWdPMU05Mm1qN0NwYXd3aVFiN1dIU216aXI0VkoxVjlWTVhpQW1G?=
 =?utf-8?B?RGlEUVAvWGhOVWJuTTViZGV4SGVxUVFxUGdHVWxkaFlJRFRLWnh0SkIwRFBa?=
 =?utf-8?B?WGhHa2FLckJNSWx2UHFQV1V5Uld5bUVTOGRaUEZ4eFJaWU1ucUcxUTQ4c3JY?=
 =?utf-8?B?bUdjUTJkeDJvem5jNjA2Y0Urd1VzR2V1VHRKTDRPRGpOcVlBQUJSMWE0ak9r?=
 =?utf-8?B?ZFpZdEJNQnZDWjI3SXc5dGU4WEZzd0k3MGVrYTljOWdHR1ptRGFFcFRWbVJW?=
 =?utf-8?Q?PT/3VPrqXG0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?clF3MGlFbmpNeXBQM1R5ZVRrSU0rWS9DZGd2a2dqQzkvalpKV0x6S2M2bXpU?=
 =?utf-8?B?MlQxQkhnVEZjeVd6aG5rUjRFaTdDQUdBVS9UWFprY1RvSmpmZzdZKy94Ulg3?=
 =?utf-8?B?a1dFQXp1UjZsUHhQRkhaUCt6VFF3bzVFaGQycFMrOEZpYmxaRUJyZldBSjdD?=
 =?utf-8?B?RjJKMU81eitiSU94ZTdYYzVNaVNGdTJNU1RWZXdqOXVGSGx0VzJBbEFPL29Z?=
 =?utf-8?B?TGhFWkJmekhxV1huN05qNzZ2dHIwRlB2NjkvdVZSenNab2ErejNrZHJHZ2ZI?=
 =?utf-8?B?c1FRTkdldEt0Wm5kUCtMakZPbmZhZUFIQmR5eVZIditXeTlxQ3MxbjJWL1d1?=
 =?utf-8?B?VUlLREJmcEcyMEgwZDQ4MGtuUXlyQ3QzV2lQbXhmTGx1V0ppb2VRSHZVc1pv?=
 =?utf-8?B?SVR3alpscUp1WHBnemNMM2xTMTJUdmR0TnkzNVViTDBNbFo2elM4ZW5FKzMy?=
 =?utf-8?B?a0ZzM1dCOXNkOXNEN0hyNE13dzQzakFSWEQvRXd1aDgzc2Jzb0tRd3JWdFN2?=
 =?utf-8?B?WXl0WXpRZTVmZGN5U21QYWxSeEdnNHlsTFRsRDEzRGQ5bmE0NDhoRWFoOXhz?=
 =?utf-8?B?SE5nL3ZGV0JGMk1yQmJKbGhZcXdiTTVZMVlqOE5RTFpQQ0NUcG5LQk9tMDNu?=
 =?utf-8?B?NjhhOXZmbGdWTU85ZlpyZW4xOVJKRUR4ZmY5Y1hWc05oRVQwTTdtOElrTW0w?=
 =?utf-8?B?RFlicDFZdkU5cWhOSkxFZ2tSZk5GM1FxTG45Vng1TW42TWRORjRUZHZZRWN0?=
 =?utf-8?B?VWJqQWdlWlJBcFRRZnp6cUVmbW1RbVR0ek94Tjk5eHJlWlB0ZUVZT1hacW1Y?=
 =?utf-8?B?UVhPRUQyekwxWlA1RVh0djZrNlBvWTMvSlRMNEdJaHo1QzJtakdWamRiQXcz?=
 =?utf-8?B?NnNzUVkrMVZtUTEzWmFFMjdrWGdCZHAzZmNaNnNBcUtwUmZoTEtwUkpUMXVz?=
 =?utf-8?B?UTR3K0hnaXhMeFhmby9PVGF6WjBac0haQWllbTlyRXlUNExvZWo1ajgxWnB3?=
 =?utf-8?B?UFh3dFV5YWd2N240MmU1WVZrejFnME1qeGpRZnN0cnZESkUzamFERnFld3dZ?=
 =?utf-8?B?RURUZEVMcmxsR3M2MDFUTlhObUZ5b09mT281Ymc1aXFxdm9YTXd3NEtSbGZp?=
 =?utf-8?B?WmZtSktTY0RqZ2FobEx3ZG5VZ2svRXY2V2hGUklTcG5seEFDd0Y1TFVMd3VD?=
 =?utf-8?B?SXpVOGh6N3BxaUh4N2hhcExnRUpYeDkwMXlrcCs4YlVNZWtUbGlIRktubmJE?=
 =?utf-8?B?OXMxNUhHSW1RcHduZVF2RVZYbmllZzB0QlVrWGFxWVNFNjlPeUNod2NYdk8w?=
 =?utf-8?B?L1RpSVNrelBxcU5tQU5BbWwwSWpxckMrb0JwMkkyTlc1S2lNVU1EeTNIUTFo?=
 =?utf-8?B?MFcrU2FtZHk1RUhMK1NybVp2TXZwQk5NNUFHMEp0RzFtMzV2M0JtOW0xdWlp?=
 =?utf-8?B?TTRheWhMaFhUbnZNZkVaZ2F3UEZ6UXpqWG9acFRoZU9vTi9rSUtKcDdqdFdm?=
 =?utf-8?B?d0pKYnJsSG5ldkVuSzZTU1J4a201a3JGN3RhTGdGblhWVGhJdWRtNGNtZE96?=
 =?utf-8?B?OGdzQWNxU1pLblpoV2VVK3RtWG9scXdvQVdLcnhzeFNsRzVLZEVwQXhUS0Jp?=
 =?utf-8?B?RERmaVNmaGVTcm5yR29VejBEVWthT2RkSDF4aXcrRUwva1FjdWRXVU5TNGhl?=
 =?utf-8?B?VHlJWHR6a3p2dzRjRUJVWjN1Zk40RFAyS3dINXVTRVdFOEZDSDBxVlpMcm5H?=
 =?utf-8?B?MDRtNVFuSGcyTk8ybmxuUnRSbU9HZjFJcmNaZXRZU3gvb2VzTGN2L0k2N0dT?=
 =?utf-8?B?R1AxT0krYW03cTBpa3VaTVFrbEJFVUFLSzB5NEgwbUpTOGlVZlpYcm5iNHJ3?=
 =?utf-8?B?YVBRQmhxUEl2VlErRiszMEkzQkNGdGo2aHpxUVBjRHNTaWEyeWxwZnFkLzJ3?=
 =?utf-8?B?U3g1d3FxUk0vWk1xb2ZOZG5FVVhOK2w0UzhISDN4L2NjWUlFM0pZSjIrK0xu?=
 =?utf-8?B?TlY5eXU0Y1hyNjFoajQ5emxPTkRPelY4cWs1U01EUGZ2VkJVMGhTYldqY3FC?=
 =?utf-8?B?ZlFnMnR3akljVmtoeTdDOGNKNzRNQkVja2t0VUg0Wm9PVmhDbEdvYmsvU1Ev?=
 =?utf-8?B?WXloNEE0b1RXL2Z1ODZZSjNsK1l4NS9KMWVnM0xqL2poa3lySERTd1F2MW1q?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c5vDmhPcxA1J6LhBdhueBI2a8/9LbGyy4iMZZv0npyxY7LyRVRKbUgJ5NQgUGrvctaWuO6uYkMGIblxzg25HhfLA9Nc5XOrxdK353R9GPA06lBjf7Yzg9WiekQhM1S9TnE1uEhAidG7bsOR6Yj1eMO44Ozsj4Yfboj5wglw/5Ca4lMYRRwEEIpuB1ZhHl3F1RoK9nSrZn8KS1skkEwD39yARFwE1fVtF+m/3nV8BlwUdv22l3GuUYmsKw1yWoreTiB2GJA9VkiA9k2wHH+QmFBfgdWuj1Cx4Sz5H5jOUf/aVv77J6jusyzCeGnvdKYdUywCLdbL9gK8nbsgIgOHBzltn7oTP3UjYnwwFFsaubz8eom+wBDue4FkZru2gdFd6yDZS2sOdYE1NsF9BUL78zLCcgSfvH0ipREf/cm/Bu52sJf6Zk8eLxxQI5ri7zc4/H3/q56LnnvR7SHFhNuh1theYfuk9qrfIRe+jk+JbG+wIShJHKuOydQEdo6OYIhNWNkDrLa38emIX4sAs6LSA87vUzNpZVwbwE529AyVsMHZA79HbkwVjoyJQTGslO+7iHDxnorAWZoUGDnjUml6Hmn+dNvttwwi1RwxAuD1lLIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257bdc40-b2a7-44cf-f64a-08dd7f6b39a7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2025 17:54:26.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkhgTuoqcGPMMQ1u2d7R95iUwNYkVgELA8/wS5iSzcHYY1A3ctnEYZ0haiHWXi92qeIV1+lqY3CDz90m67TFXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504190149
X-Proofpoint-GUID: 3wwNKoA-_S2PzGM6FhR-q3fYxx3xlwuW
X-Proofpoint-ORIG-GUID: 3wwNKoA-_S2PzGM6FhR-q3fYxx3xlwuW

On 4/19/25 1:28 PM, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> In order to make RPCSVC_MAXPAYLOAD larger (or variable in size), we
> need to do something clever with the payload arrays embedded in
> struct svc_rqst and elsewhere.
> 
> My preference is to keep these arrays allocated all the time because
> allocating them on demand increases the risk of a memory allocation
> failure during a large I/O. This is a quick-and-dirty approach that
> might be replaced once NFSD is converted to use large folios.
> 
> The downside of this design choice is that it pins a few pages per
> NFSD thread (and that's the current situation already). But note
> that because RPCSVC_MAXPAGES is 259, each array is just over a page
> in size, making the allocation waste quite a bit of memory beyond
> the end of the array due to power-of-2 allocator round up. This gets
> worse as the MAXPAGES value is doubled or quadrupled.
> 
> This series also addresses similar issues in the socket and RDMA
> transports.

I forgot to note that this series has other benefits besides making
these arrays flexible in size. The reduction in size of struct
svc_rqst to under half a page is kind of a big deal.


> Chuck Lever (9):
>   sunrpc: Remove backchannel check in svc_init_buffer()
>   sunrpc: Add a helper to derive maxpages from sv_max_mesg
>   sunrpc: Replace the rq_pages array with dynamically-allocated memory
>   sunrpc: Replace the rq_vec array with dynamically-allocated memory
>   sunrpc: Replace the rq_bvec array with dynamically-allocated memory
>   sunrpc: Adjust size of socket's receive page array dynamically
>   svcrdma: Adjust the number of RDMA contexts per transport
>   svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
>   svcrdma: Adjust the number of entries in svc_rdma_send_ctxt::sc_pages
> 
>  fs/nfsd/nfs4proc.c                       |  1 -
>  fs/nfsd/vfs.c                            |  2 +-
>  include/linux/sunrpc/svc.h               | 19 +++++++--
>  include/linux/sunrpc/svc_rdma.h          |  6 ++-
>  include/linux/sunrpc/svcsock.h           |  4 +-
>  net/sunrpc/svc.c                         | 51 +++++++++++++++---------
>  net/sunrpc/svc_xprt.c                    | 10 +----
>  net/sunrpc/svcsock.c                     | 15 ++++---
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  8 +++-
>  net/sunrpc/xprtrdma/svc_rdma_rw.c        |  2 +-
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 16 ++++++--
>  net/sunrpc/xprtrdma/svc_rdma_transport.c |  2 +-
>  12 files changed, 88 insertions(+), 48 deletions(-)
> 


-- 
Chuck Lever

