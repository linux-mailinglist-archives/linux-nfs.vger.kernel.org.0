Return-Path: <linux-nfs+bounces-16342-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD85FC57D31
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 15:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90FF634FA6E
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 13:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1D123D7F0;
	Thu, 13 Nov 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cTvSY6vE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CJUv2g8h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B0B23D7C4
	for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042276; cv=fail; b=HSwPn4pPac1+k+UCKoqv+q0a9eli5NUa2CtvtIIN8IFpmKIUqdFjWTWbFjVuVKtjp21b3KUniL1LGw1ngvIg83SI+HLUufQ2WeoMYLevdmAzDxIhrDlgr6TFg0PmUNcICfxD5SD1o0u07nJHZPafhCLYYUNlpQKwFteLY2c86Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042276; c=relaxed/simple;
	bh=Q62P49fT0vv/IRqwQqtT5WGgAFEvLmK5VSWLCTLieD0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sDE3r1Wo86TNCPN3j+8WySBJsG0U17BSt4hjqpnTsy4Fy/ZPl1N0KbDiiDfHPARg9TIEYhFhsjx7hjtHkNM2WeXVjJs5V1OTTLR49tIc40yMAbcIwD7DvCeOhcYCCXyiVciQwVTzAxaLgXDWBBRK+6lOPzE4eW09CgAFpgz47s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cTvSY6vE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CJUv2g8h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADB69tL023114;
	Thu, 13 Nov 2025 13:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zX4GRSRMLL2zlWcA3jDrYXMM5BDCdN9HQy9v74aRhVQ=; b=
	cTvSY6vEtAoOJYfT1WFDBVPeL17H0YP5L0sUSyuFqwAoCLXvzOtiDcCyfzZ0W3ci
	EaYVifR1gA5HIvEMMLALiv6iSF1fq0Dgodmt5wVf+Jwg4K1d5WBARg1xaB6YwXxH
	rRAXrhKpT1e/KF4sI1MW0aM7KEfuI+UIKZNv8n2Eo+/nlhBr8YvsSBOAf3+ps9+q
	vey4M1ejALkeWokPZtsVk+TQJG1WvLS1sDTFNGBgo0/wkd5IZEV69Te/rMIdHK76
	Lak7P8WB2FDIp/8iWgQ+ora8ddIsGUUq0gFM2nYvtFUojEQV0o+KckVb/Br4AjA9
	PTLDmwpT0XuQLbxJdf3C6w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acybqsu1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 13:57:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADBqYd2003110;
	Thu, 13 Nov 2025 13:57:50 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacp1q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 13:57:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKRbv7DxvFgzRpmeKB0ztSH725TOsYzp/Izp9nJCG5r1SeNFVHbozRngLMoFj4t8igLVrLwEnlZmNPNaNiQuytMKT/ZP4kGeH8TYR93+WvLIfJAO4W+rjnBEx54umoPS7SxyFd5Dk6d+msX/dOQucNy0jOXQD912l1l9vnLVGbB21SiL4eWoWh+ckf75GmqknMCAc/+5G6X4Yh/LEx2j0ckGxl1ixmJS7Ne9cT+cf4zH6bnIdvMD+SDsWCWOIrRqUd9DXCfYQyMe8Z1Gj5K6OW+lWfXp9NGu/GFXGkGXhDKCTE+I1ncx3LENuAPeDn6y0VX+hDYsc7adq2vLmiqxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX4GRSRMLL2zlWcA3jDrYXMM5BDCdN9HQy9v74aRhVQ=;
 b=UK/5AzTPKCJ+MWisOnZPYYd2ch0M1y1a8CyN0y9b4R+4SbWrpIcXawQJdrGStoGyoIOsJEhGPa7BIai/ZrfBv5heG0YOEpTDZcPXbSSnguwdILeAJVF5WbdkJJRlf7D3iHDigj5zvFbuSH6+9f5+5f6KEeFPOxo/k30wvl7BDPgWlRLHWiuCmzsvN7rcVvF86UiKnx0XO5YpL4Zh6SSBkg9Xe0ez/zNQ1C9zlGLC8Av/br1oZ6saUdSctVqpQO7JEnoYrq81nLLNUSmhxXFCKLxiU2QADahvEo0dO1ntPrW7s0lboeqor8H3Hfc8khZCcqc/JVaxu4mRN1T4/In5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX4GRSRMLL2zlWcA3jDrYXMM5BDCdN9HQy9v74aRhVQ=;
 b=CJUv2g8hawV822Qy/MFEpxOfyJoNHuR9VmZIYhDKFM8uSL0nR15amNaUHkBNHe2fmmuEuD/FKcBu8pYuZ8FaikUuEEiuR/v7GPJn36OMgZAyyLua9Bwj5ypm1kzUAPAOhW0qdlj4wAMNqTcF0Gsikzgop6d+ZWYl/0yZP+kVXn0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6623.namprd10.prod.outlook.com (2603:10b6:510:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 13:57:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 13:57:46 +0000
Message-ID: <11ae7fc3-6565-475c-911e-4d93c3fd86c6@oracle.com>
Date: Thu, 13 Nov 2025 08:57:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make RPCRDMA_MAX_RECV_BATCH configurable.
To: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>, talpey@netapp.com
Cc: linux-nfs@vger.kernel.org
References: <20251113093720.20428-1-gaurav.gangalwar@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251113093720.20428-1-gaurav.gangalwar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: b2abce80-4bd7-417f-18e5-08de22bc9fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDdnNmRtTTFJMldpdUYrRExmSUVHM2lTdDVCL3VPVTRPQnZpbzljZkJBengy?=
 =?utf-8?B?ZzZMSnFpREtURTZDSEV0eXlaWVNNOGI2eGU0TlYwVHljajBhS2R4eE5Va1pm?=
 =?utf-8?B?QjNUc0E1OE1SUlpvMEZsdU1VV1k5RS9DOGtNTk5zaDcvZ2c2MldhNk1UOE4w?=
 =?utf-8?B?WkpDYWVJeEQrWWlwYnhjcHNGSXZIbWRaaEZOMUVkN1daelNaaFhpK3pCVnA4?=
 =?utf-8?B?YXkxQmtKYTdxMkJnKzlhYVZBd2k2UnFRK25LRGFJZVhHTFZQVkt1UnZzZ2Mx?=
 =?utf-8?B?Z0RFd3VBM3JxS04wTUMvY0NKcmRiUmtzOVZaWHdZMHhGWU9iaU9SS040aDRS?=
 =?utf-8?B?UXhKTVIrdTIrdEZYa0VxdURMYjFGOXFWWTRKa0UvNFk1amZicHRWelZDRVVZ?=
 =?utf-8?B?Smt1VUZ1ZDVteUtUeG1uazJDRlZyNnkzc1BabitmbkRtZUFoczh0Mkxvc0JX?=
 =?utf-8?B?UVQ5WkZmazVBL1NWWTkxYjlOYko5Vyt2VVpBNENLOUkrRHJMU1Y4Qk9WaVVV?=
 =?utf-8?B?Q0FRTFhxdlByNWVyOHdiYnNVZ1I0VWltekdGelBrKytEbk5vejBidWRUWVl1?=
 =?utf-8?B?SmRHWXpQbER3YlEzQlY3NGUrUWxTa2g3MklBV21Ndy9rTUZFR1B3aGtsT0ky?=
 =?utf-8?B?Q084VWsycmJrenQ3cGs5MW4xdFJzTjBHTmphd1BkMzdLNm51S2RhdjZWem5W?=
 =?utf-8?B?SkxncVRxdkI0Z3VqSUdqUU5NUVBObWhDOXFUejBtU1BJRW5hbGJremsxSW42?=
 =?utf-8?B?R2JPMGJNUTJsMnI4TEJlSVFCVjdKdndCdEtMN2JYM3NsK0ZQU3p4WmpoWW0v?=
 =?utf-8?B?aDROQjhUSHh1RnZUQVUvd0hjSm95UUMrWENjUTlsUENQN1djYUx1Y0hvQUx0?=
 =?utf-8?B?Z1o0WGlrUytMVkRJSDB0TUQxaFdTcVNTbDFtc2tpU1p3SEJZMVpmY3NCblFU?=
 =?utf-8?B?MmxyZldBTjcwVFJlZUFaRTlTRFRRQkhsSkdRWjlsWWl0Qkx5REZmS2JZa1lJ?=
 =?utf-8?B?cnFBN2R5QlZYMnRWQ2VMaW81K29FK09weFEwcUZ3OE45djU5OG1RbVVGUThi?=
 =?utf-8?B?RklKajRrdzlneWFHWDRkaHFyU1kxNjZkQXFJZStEUnVsSE9NdzRjYzk4c1Fa?=
 =?utf-8?B?WTZCVjVveDVRRVFQYVpFQms3bVUxN25kUXFrdUppQjN3OVdCUkVsaTNna0pz?=
 =?utf-8?B?SE1nMlFsMEh4OGllaXkrS1pSV3hIUnJyM214aVdIUXd2dzhWZldaSEhYWkhh?=
 =?utf-8?B?MDF0YUJBWE42c2hPVkw3Ukl6S1k0RzUyMUN1cmo3QXZVenBqeGNlU1JoVTlL?=
 =?utf-8?B?VlordStUNlNrZHgwZXFKWFVMQ1IyVElZblM0VlZPM1A4YTdkS1dpUjRhaGRO?=
 =?utf-8?B?SEVMbTF3OEFjdDROT2ltMStaSTYwdGRWVWpYeS84bkF6WEZoUHVURHRLM0dm?=
 =?utf-8?B?YkFBWjdNTXZyZTBPMmkwWUxDdHROZm54NW5SaGJMKzBYVlRTajRmN0d1U2NK?=
 =?utf-8?B?M1ArSHdpMmluZ3laZkQzQlpzVFU4M1ZoYXpXelJBTmZmZ1NETjBncStYOGpu?=
 =?utf-8?B?SVpsRGY3ZFNmeURyNnQxRUN1SlVUY1JRMmVNbFVjMDBkNm9yUk1HVGs0SWlO?=
 =?utf-8?B?emMyY01BVjA4eVNucnNrSERlalR2cm14RVRIcGVKMU9iS1d2bXBZNDRxTCtB?=
 =?utf-8?B?QjJvZEJEaGlYcjd3bXIzNzg2N1VPaG1zOTZCYjcrSEtNVjFCNlpVd2RKcGtE?=
 =?utf-8?B?ODRydElrcTBUWUdkWkNvRFVKb0QzMklubTlLWlRiSkRrcE5kWnJUK0pOSmFV?=
 =?utf-8?B?ZHZtZm1KUVhIK3RrSjJ2dXQybHJ1b1JKeURrYjI4N1hZQ0U3aXR3VytrQXU1?=
 =?utf-8?B?WXlCTE9tejkzVGU0d2h2b3VNK0JiRnB3c3FYZjMzT2dseGdwUTQ2T3J1SjhD?=
 =?utf-8?Q?NIqSHfawheXOHixcbW5/mIRNdTfWyc6f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGJDUmlLbVp2cU5lWHptTVUzc1M5NVJjUEdiQXY0QllSNlFIR0xGV1RuUUZz?=
 =?utf-8?B?WWZZZXQ1UTl4Ry84czMxSk9UMXBPcUZSUnNFbGVZUVhMenFSTVdpT0FocXBL?=
 =?utf-8?B?cTZpNGFLZC9Rd2IrTXlnSk00WmhncVZpRzBFRzRhUXBaTFhTYU12c2dzNGdU?=
 =?utf-8?B?VFdrODRjNCtyVldCS2lNN1d2TXhvYUtUV2R1Rm14ZVFkaW1PdlJRSDNQVnlh?=
 =?utf-8?B?c09YdWtVNk1wZE1VNGhmTEJYNWhLaSsvcGVLUmN1aGZERE1OaHU0MXNPNXJi?=
 =?utf-8?B?ZG1vSnpwMHU1VWFEU1h1SzVVbVBCRlM4R2FtUS9rang5clBycW1EcDJYMXpT?=
 =?utf-8?B?bkp5VmIrNDE2cGNycGt2R3hhZDM3QTIxTWw2VmZHQ1Jzb2swcGs2eGdsanJT?=
 =?utf-8?B?U3VlNDFzbTl1UDBlcG4wRGlOWW5DME5iUlVEelNQK2pIcUt0S0hFdGhKNWRQ?=
 =?utf-8?B?L1JaY0srUUlIOVlpY2U5bFBIWk1xYkw0MjlSbUNXNUxXeUF6UVUxb3J6Sjg1?=
 =?utf-8?B?NDNBL1ZUcHpsVGtaNXVERU5TdUpkNTRJZ1lWNytOa29mT1h3Sit0Z0tVUHBT?=
 =?utf-8?B?N0ZJMm93ZW02aTFrZVY3MUYwOG12NU5iYjU5enNJYjBWYlp2TGZyUzhUeVY3?=
 =?utf-8?B?cnNvZmN0Y3FTNDd6VDhOQVU0cnovOFlUdyt0QkxqV3UyMENRYzEzQkJNNHBq?=
 =?utf-8?B?aTVCWW5QbWNUSEN3Y3p3VStTRTlwYktFd0NJZk14ZTkweEpQdkExYVVQZnBD?=
 =?utf-8?B?NFlFVW5OdVFZQzFmbVhpbWR6My91dDcrUVJwcHJabS94K0FPY21GaTZmb0da?=
 =?utf-8?B?K0s0b0VaWDJiZlB0d3hIWG4yZTIzQ2xiT3EzQkZ2TFBMSnJCck9ROHVFcUV6?=
 =?utf-8?B?ZEIvM25CNGhNWlowa0lOdG5KMHAzdUoxTmdCY3B3SXB5anJ3NFk2Y1ovekt6?=
 =?utf-8?B?Q1lOZTRXRHp4c0wxUWFPNW1LM0dMd1BVVzVKTU90dkJ0K1RPTXlsbU1yaEVP?=
 =?utf-8?B?Y0xRVmM2QzU1SVVhc3A3UDNuYjEyUVh4Z1hub2NsMHJ3WE96Nitqc09hd1or?=
 =?utf-8?B?OHovaW1qbTVOK1kxMWRxRmNOZG5DK0E0dGFIMmxQTnBqR211NWhQSzZZUXc3?=
 =?utf-8?B?U1h6TDQ3WFVkVWgxcXZ3L0lscnkyNDc4NkE0Y0tRSWVLaWhjVDNyMk1JdGZD?=
 =?utf-8?B?UnRJYW5KMCtSSjZ3cXlKb2R3aTFOaFJlZmVsRjY0M0Q3ak4xSithVkxXd3ZI?=
 =?utf-8?B?VFcra1lZUW56TWZUOXQzUjVZc25pUXo2aTZVclVPT3IzeTNXNUtsMEdrNHlk?=
 =?utf-8?B?WDVISlByQ3hMV3ZobzRwRjI5NVJFOFNyaFlRcTEvVmd1cEtVRW9XTW01L21L?=
 =?utf-8?B?MzZiMUdLbGtyVXl3QTR4M1dBR3M1aWJwS3piWXMraVBlcnlnM2VWWlpDK3JB?=
 =?utf-8?B?OWtFRmNYZnBQSWhnQlMwOEsyajdSYXhMSlBlNFFNTkRHTzJTNEZnUWJiRWdx?=
 =?utf-8?B?SVQ2L0w2RE80MVYydjdTMGtsR0ZrL01IT29UM2lEbTRxUlRqemcxaTNOSG1B?=
 =?utf-8?B?YlBZSnEwMTNJNWtvS0pBZ1h0TFMzU1lFOE5rZ2xyZXZDL3hNWkJTYnVUamlL?=
 =?utf-8?B?d2N3VW80T1pMeXdiaXRVNUdpR2U5U3d2Uk54UThaSXN0eXRrNjJPT2hFOGVK?=
 =?utf-8?B?MFJUeWhFa1gxVGlST2NBRFJuUDVRZzJVSThsNTJrVmFwN1J2U0tZYVA2VXJQ?=
 =?utf-8?B?V1J0b04ybGtkTGs1Q0JXVXN6aEJWbWZSUlpIS0xGUEFBNytkUDRYeUl3MDEz?=
 =?utf-8?B?ZTJhU1NOQlkySTNvT3ZabGQ1Y3MxL1ZTYVNiaVFjVG1Yc3EwT1lxSFdac1dm?=
 =?utf-8?B?d2YvWE1JVkRsNnJJRmNidFNHNmhaWUVobkdqSGNjWjlrb2h6QzRlMXl4U2d1?=
 =?utf-8?B?aVVLN0d2NWc4VldmYkptYXM1dHRhK1RIVzBhdlAzNlVFczBsSkJNdDJSZmZw?=
 =?utf-8?B?eG0vZGx1c1B2VSt6TVlSUnF5WFgvUHJOcmN6MjRLQ29lTXE4Q053S1dHWEZO?=
 =?utf-8?B?ZGExV0phTmJYSnZwTTdnNXdIaVpqK2Fld1hYbm9WTGtDaFhnbEVjOENnT2ZK?=
 =?utf-8?B?bW41MFJnRFhGdzJxR1VQYWhsTHIvVmZRZHh3MElValBwZ1g2Y0xoejBkUndN?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BDXQDDVoz3JziCFkPLjtNXAgkGEpX3P+gUUQmHEhmnqQcmfJLYQgp/Jiltd5F033YSWujLS1CyQYAiTC4hCBR/2Wp0AwoiFGVCFOPCF+bIbB1BmVleWLiQXoOPtjmtt5kgW7Nm4rGySfgwsdUpck684DkYZyRuYBPifTi9Sfmt475n0BwhGhXZ9rSRG8hXt+YQoDfRvsi6CcIpnNQqWbxc4qcpzuNSrxwDLeplsvfVCIqbkavB0iqSG+xfiXaIkHyRLajFsbEkCKbYGopVgaiUPD2sykGnhHZ54PFHcn94W/9dJeagRfSuqsSzsFylZBqIG0HjmMrBlaAj9YVOW7O2CBhJmfOR0725/sO419y/wyl2Zp9RjVnv4zqf+uIvcnsoF6SnV+okvY29LrsL5nnzQ7P5xwAzqzsG0FFrAmFpJjv2qKWzMV1nZiEbArap59/18bAMhtQhwUuBZ5LNuPHrrA2JqQYXDpJ1dLdPl7t47DZ/7Ii4i7qIOQcXZjTgJdaupGpF8/qenJQ7l3NQpBjnCLDHtp3f6FfFdz1+4IBYNV8+fE7uw9E8hr+xp1HIXKl7ABvx+ew+5ICjWx+CwB8JOOul1vRgIxtd5yaxQqUhk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2abce80-4bd7-417f-18e5-08de22bc9fb1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 13:57:46.2551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Effc8pN7tNCrNqw39NyxsSpIgoU7qVNeTq8v2O78AGkeuB3RHxopZ4TVpNfuT74CXH2UYD+F8I8AMZuPrsG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130106
X-Proofpoint-GUID: EebvqPvuEzqQsQ8D0-BnSl4PqDpgvc3j
X-Proofpoint-ORIG-GUID: EebvqPvuEzqQsQ8D0-BnSl4PqDpgvc3j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0NyBTYWx0ZWRfX0UdDbifvLaif
 dAem3vwdm4ZxfeXZffZtPMpHNuVcOj/6VLUTgup57eVjekIZGyWEq8hx816Oiy5J4i7WFCOcnQR
 WSX+BS+r/CUjX+JIRNPcCL8yVfnV//kVt2P0YoynTjH0ZRo1Si/U2u6vAgGWQKAfCLzIRlAyo1a
 Aa/woYCVPChFYCM9JZiplBcYwej7n34jB4IAHLOuRSDsTqXB35X1R4e80x9exO+zv49NLFNxYdJ
 wwtzKsjRhJUBNIEfJXGfBpbXHl9QwNjd6E8FJ5KC8n1GEsrf4Rt9mOzWQuZEfUHe0zelciB+EDf
 GkIRf+SLIegVn7ePX12VJpnXJ5aZN0Ano9YYqeyxwOohITUc4UQc5BATOwD5VQsIz2UfE7dVFBH
 P6Zpiq8bWe55VK+i6WdrkWKV26NAnw==
X-Authority-Analysis: v=2.4 cv=X7hf6WTe c=1 sm=1 tr=0 ts=6915e3df cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=E5RKnd8S-lp2Z5d71a0A:9 a=QEXdDO2ut3YA:10

On 11/13/25 4:37 AM, Gaurav Gangalwar wrote:
> Bumped up rpcrdma_max_recv_batch to 64.
> Added param to change to it, it becomes handy to use higher value
> to avoid hung.

Hi Gaurav -

Adding an administrative setting is generally a last resort. First,
we want a full root-cause analysis to understand the symptoms you
are trying to address.


> Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
> ---
>  net/sunrpc/xprtrdma/frwr_ops.c           | 2 +-
>  net/sunrpc/xprtrdma/module.c             | 6 ++++++
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 2 +-
>  net/sunrpc/xprtrdma/verbs.c              | 2 +-
>  net/sunrpc/xprtrdma/xprt_rdma.h          | 4 +---
>  5 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
> index 31434aeb8e29..863a0c567915 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -246,7 +246,7 @@ int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
>  	ep->re_attr.cap.max_send_wr += 1; /* for ib_drain_sq */
>  	ep->re_attr.cap.max_recv_wr = ep->re_max_requests;
>  	ep->re_attr.cap.max_recv_wr += RPCRDMA_BACKWARD_WRS;
> -	ep->re_attr.cap.max_recv_wr += RPCRDMA_MAX_RECV_BATCH;
> +	ep->re_attr.cap.max_recv_wr += rpcrdma_max_recv_batch;
>  	ep->re_attr.cap.max_recv_wr += 1; /* for ib_drain_rq */
>  
>  	ep->re_max_rdma_segs =
> diff --git a/net/sunrpc/xprtrdma/module.c b/net/sunrpc/xprtrdma/module.c
> index 697f571d4c01..afeec5a68151 100644
> --- a/net/sunrpc/xprtrdma/module.c
> +++ b/net/sunrpc/xprtrdma/module.c
> @@ -27,6 +27,12 @@ MODULE_ALIAS("svcrdma");
>  MODULE_ALIAS("xprtrdma");
>  MODULE_ALIAS("rpcrdma6");
>  
> +unsigned int rpcrdma_max_recv_batch = 64;
> +module_param_named(max_recv_batch, rpcrdma_max_recv_batch, uint, 0644);
> +MODULE_PARM_DESC(max_recv_batch,
> +		 "Maximum number of Receive WRs to post in a batch "
> +		 "(default: 64, set to 0 to disable batching)");
> +
>  static void __exit rpc_rdma_cleanup(void)
>  {
>  	xprt_rdma_cleanup();
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 3d7f1413df02..32a9ceb18389 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -440,7 +440,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>  	newxprt->sc_max_req_size = svcrdma_max_req_size;
>  	newxprt->sc_max_requests = svcrdma_max_requests;
>  	newxprt->sc_max_bc_requests = svcrdma_max_bc_requests;
> -	newxprt->sc_recv_batch = RPCRDMA_MAX_RECV_BATCH;
> +	newxprt->sc_recv_batch = rpcrdma_max_recv_batch;
>  	newxprt->sc_fc_credits = cpu_to_be32(newxprt->sc_max_requests);
>  
>  	/* Qualify the transport's resource defaults with the
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 63262ef0c2e3..7cd0a2c152e6 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -1359,7 +1359,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
>  	if (likely(ep->re_receive_count > needed))
>  		goto out;
>  	needed -= ep->re_receive_count;
> -	needed += RPCRDMA_MAX_RECV_BATCH;
> +	needed += rpcrdma_max_recv_batch;
>  
>  	if (atomic_inc_return(&ep->re_receiving) > 1)
>  		goto out;
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> index 8147d2b41494..1051aa612f36 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -216,9 +216,7 @@ struct rpcrdma_rep {
>   *
>   * Setting this to zero disables Receive post batching.
>   */
> -enum {
> -	RPCRDMA_MAX_RECV_BATCH = 7,
> -};
> +extern unsigned int rpcrdma_max_recv_batch;
>  
>  /* struct rpcrdma_sendctx - DMA mapped SGEs to unmap after Send completes
>   */


-- 
Chuck Lever

