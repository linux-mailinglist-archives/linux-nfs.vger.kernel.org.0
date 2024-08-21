Return-Path: <linux-nfs+bounces-5546-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A149895A4F9
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 21:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D561F221EE
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 19:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB73614D2B5;
	Wed, 21 Aug 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NFAeB9r+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xWlge6Ie"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B5114C596
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267028; cv=fail; b=WJbb4mdpsu7Wz0cZ7SpHlBrQQvXzMS2cYF8euTgd6KVka6WdCfKjB8Q7l2J9tD1wwNRla6jNgb+yVOSl8SscOp0z16Kqx/oI2a1yhsc1KsfBiflyYXW7p2MdjgzKMJk1pKrMsF4OAZVv7gBR6+7AJpy0FXM+4T9LnbbZnj8Sb94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267028; c=relaxed/simple;
	bh=g2adQ7mHLk8Vjk/m+gjZ7WO6m8pWwndHa8Eu7E9jNk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bm/L4EPn7MDM5Ok3sNAyyGLl4UHPAEwl5aG3sDBD8MEAEJ2YPLyUiFKJNG1TAucUlDDz5/u7JSYe3ENkqaEAqn4hOeOdD83shoDHZjUMs4NCVLvYqLVmGyApEUKlRVanLyxI26Zdc+5pYAQvJpAdG8JBURzJidSz1Hj0z2uXvIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NFAeB9r+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xWlge6Ie; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIUMG031721;
	Wed, 21 Aug 2024 19:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=7PTSOcUWIHgKd6tqfhRCGs2i78BBSBDJiW3IPfmmi78=; b=
	NFAeB9r+mDHLEFhUV2dsVm/pDo/Wrjmv1QuVNtfvNle6p3c8Dsb+4cbK5zWd2VZ2
	eRkuD7XSNXJWAgBETRUA+Xa44o/FV1jCl4bilUThmvNOxk6GqOOfRrTHkJoKvIyC
	VvcDZ0MDGm+PawfgHsFwnXyzT9ozD2JKT5o3/IYOSJouCCMqV2hoVHDlJcAMbMNU
	n9XxUoRjYsadllyOZBh0x87UWiFlOmMPxMK76lOmbHNBlKnQJYVWVtr38/Qmzj8H
	4oVjlnEVcXnrltvUdQi01cb50wsie1YOlw3W9AJY9eqHXFv8Sovt/wCG2lGHPLFQ
	/ssppRdfIyhgtkHYO73c5g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3drjg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 19:03:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LIK7Sc009106;
	Wed, 21 Aug 2024 19:03:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415ne49sg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 19:03:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXDPVQt68ClB1VbM1rnTkBdlYWdWT30t/1XQPf08Cffx9AeHQhLlN507iKT9D4IbeG8NJiEzFYXRbcr092U4B77/al0K7iqSvrQitEw+PxQCJ0Zry6U7zRn567gbLfrbT3QOamWsOWSsAVIhwHC4NlidF4uS8muAULGWhJMNjx3JcyMTimO1D4rv16LxrzMJAKN48jCdKhSABvzrQK2D47e88+SP3IHjS32KBb/YWy1MlQXp2/+vkFZArlhodVI+zpmVOsya8Z1tV/lyodWotUlXyoIV4IlyrlF4hpqIrSDRo+SrnBysLpdknq2V8lekLitxspyq3yp/OcbN/wqiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PTSOcUWIHgKd6tqfhRCGs2i78BBSBDJiW3IPfmmi78=;
 b=zEBrxpxxhwJsCazbzE/7ZhDQNC5vMYsqvYzql3UeWqXDmRARGUPb8Jmq7kzkQWBTcntXC4emK+9YAfUQm1WB2CJLw+kOuaBBhyEYYp8o+6cDeAXIl0vhJNT1ctH/YduSUF2EsD+cOMArLTiSPmUHW+VbYCfY2IR1Im7fT0jHSixBUiLjQhPAVqMr98+DAtAFdOhWy1FuOYYQ19n3b64jVPinovWvoQ8ePYt70aJh0bMyOFFxIKSEnI3GEXgIMPbGT11knampzC4xJ4pQCFOxtCKdcZQikb1mL51bq6Yn43LwrafLSYtQA4IMKqrgaFyY7Vhy7KKPsKko8Gp4Vz+obw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PTSOcUWIHgKd6tqfhRCGs2i78BBSBDJiW3IPfmmi78=;
 b=xWlge6IerDIQhM2+huFR2frzCZEOBcrpohW80Rlj/wJASZxQf7s+Ut3qsVxEqGVDUFBpgbLi2Rm5Meal+NcAkhsNPimp8gEEjci2VQuZkzMmdZJUlQ7HYTn76dzPY4VtP0bY9elkDjz+wsCcB4fLVBdV2t34pHQZ5RkXLzHy4TU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6836.namprd10.prod.outlook.com (2603:10b6:610:14f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Wed, 21 Aug
 2024 19:03:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 19:03:36 +0000
Date: Wed, 21 Aug 2024 15:03:33 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] NFSD: Create an initial nfs4_1.x file
Message-ID: <ZsY6BeHYcJiFOrHc@tissot.1015granger.net>
References: <20240820144600.189744-1-cel@kernel.org>
 <20240820144600.189744-3-cel@kernel.org>
 <6a3d9288fdeb6409dca7c2ceedf249d3b40a7d97.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a3d9288fdeb6409dca7c2ceedf249d3b40a7d97.camel@kernel.org>
X-ClientProxiedBy: CH0P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9327c6-8286-4c1e-1302-08dcc213f5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTBtbG0rVVNRSXVjTkhCNzdKQmUrYkwxWTc4Q2lGY0dYb0lOVFBQY0pQWGM3?=
 =?utf-8?B?RDJkSEYyd0lYK0R4QzFPeTVTU1dBM01yY3hjeDJvMkUxL0FabGZ1dE9TZUh6?=
 =?utf-8?B?aGRiTDRjUExndFZhVmdLc1puWTFTd1lQQUp0ekJtcVNnajA5eUdWOXZLU3Zv?=
 =?utf-8?B?TVUvNVJUVVpCZnljbXRublhYNnNQWHlQb3g3QkJqSDd6OVFTTWYxNzBrNDUv?=
 =?utf-8?B?MCtVcGtrcnlWRTVBQkZ4M0RmK2d2Skc1ZVphdGdRUGZXQ1pLenFVektqTWps?=
 =?utf-8?B?SjQwckRzdHc2YUh0ZkprNFVVTUNEakloY2FFSlNlb3ZrUjIrMGRheDd6bzAz?=
 =?utf-8?B?N3pETExWY2xwOGxSOTlvVzNxdDF2b3FQNXNpUGRPc1B3bWtReHM0ajJ3TEth?=
 =?utf-8?B?L0VkN0djb2VXQlJWZHpsWFc3OFRxZmRXY0pFdFI1Ui9vVGhpa2htQzhzRll1?=
 =?utf-8?B?cHdRakZGSWp6Tyt6TGRhL1RPeHVYMGlLcXZWVTgxS21VaDB5d2U3QWg5L2xY?=
 =?utf-8?B?bGNSNk1JRzJhRXJydlU3Y3dITXVPMEROSGFORHdvMnRuOFFubXNIY1kycHZB?=
 =?utf-8?B?NkdScWVITEc5UHRzb0lIUnFwdlkxZTdub0pFMHR2WXJFUzdCYWFZVXR6SkRm?=
 =?utf-8?B?TWJVUmN1SXJHeGdYbURZaEQwMkQ4RnFjVHc5Y0pGQmRZdmF0ZUpwZ1dMVisy?=
 =?utf-8?B?cGRSTUYwOGFjdE1UNDM4SStWcGNmamZtajViZ3pWUHU3NUtVQkZHdUZWTVhB?=
 =?utf-8?B?ankrS0lGYklRY01UNlZIekhWMVVYb2NsUitvOGRoRjlhNnhYdUliZHBDRGFr?=
 =?utf-8?B?UW9kR2YrZWduTXQ0bENUb3BaMnFQZmNITXNuVWM5d2Nuc0V3UFArR0IrckRL?=
 =?utf-8?B?VUpubWFqOXBtQlNPK1hHamRWVVNJWDVYU1l6ZGMwN3o0ZUdRditGWmQvS3NF?=
 =?utf-8?B?VGpJVVAyUTFFRUorRkFJdW5qZThMNUkwdzFabjgrWTN5a2Zhd1dVK0hKRGJs?=
 =?utf-8?B?aGNYS0luU05xQWdHcjJqa2J4bktIQlJLV3FnbVBOZW0yeGdBbmo5Q2lJdVY3?=
 =?utf-8?B?RU5Ea3V0MHZmN1Z6M3hDcnUwTEUrTkFnSEJNUnIybnBJWmpLWmJkUHdwZnlT?=
 =?utf-8?B?WnNUZTQzTGVPS2p4V09jS1pvb0xIK0Q1bkVLSjNtOFo1RXVkSm9obTFWVmds?=
 =?utf-8?B?MFB1Slc2djBDMG9sNGQ5ZGY2RGROMmFLVUxCT241NkZSNFA4V3Y1RFJWMGc1?=
 =?utf-8?B?eGJ1SngzRDJPMVhRN2RIRWlPTVNHdTdwc1Z4SkNLekdTMHVpNStmcUVhVFRt?=
 =?utf-8?B?UjJqZnBHTGcySDhvWnJpalByeThodVBZSHpKNE9iU3lFdDdtaG1HVHdlajM2?=
 =?utf-8?B?NiswRm9JZTRLdVAvaDF1YTczNWhMWjQyaHNqNjhyaFB3R05yNjRCd2hQczFC?=
 =?utf-8?B?eElWYVJYSktQZlMzeDY4UFR5aVBtcGp3TFJWenlGdVcxQkZGTkhzTHJ0UmtV?=
 =?utf-8?B?Z2pzR2FlS1k3MGxUU3NWV0ZpVDZUSkV0OVZwSGJpMTU3cXArZVhhTTFncC9C?=
 =?utf-8?B?VmFlOXpFZFlEZ3l5R0p4SDc0TUh3UVBsUkdqS21IU0Fsdm1XclZXSjlwb21h?=
 =?utf-8?B?dkx1ODBJL3llOHZ5YnVqcVRoZWp2TWtnY3dPSi9peTQrWXJoejI4dlZKWGFP?=
 =?utf-8?B?aEF4K09hU0huZ0ZJS2cyeU1obTJaazF5dHpUZHg2bmRJeGNnWitveUltczJi?=
 =?utf-8?B?UGx2U01xR1RqVkJPZXloQUpmNGVhenViV0JsS21ERE1xWG1hV2hTQW92cGVH?=
 =?utf-8?B?bEY4azNVdytMdnI0dDMvUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzZoZUs2dlZwK3RkdTdMYTkvYUJLRmpUTGpsTS95RlJvTkllZGt4eGZLVnRU?=
 =?utf-8?B?OVpqV0hkM3hzdE5Ic09yRk9XL1d4K1p2eE9ZczNCMFgzVEZ2VnUxektGTi9E?=
 =?utf-8?B?YlhSblZ2QWhwY2UyK0pOdkpVU0ZNTjRFNkNvdUJlMUozQ1p0S1V5dDlKbUdU?=
 =?utf-8?B?bjZ4R3FrdmdpUE9Fa1RhNUM1WUFveTFyZkordmxqcWJBaE5wNDhrU2IvOUVq?=
 =?utf-8?B?Zms4WjRvUlBpYUJFZU9DTmcvQTJCK24raVVNVE00dzVXUUZ2cFdTVDNOYVF2?=
 =?utf-8?B?enBKK25CK1pSUlhneG1WNCtCR05iNVZVU3U1UExndUo5bW5YTzF3OTB3QjJY?=
 =?utf-8?B?bVRqWlNWUnR5Rm1saTFJaldCN25haHplbGFjanFjektPVGZ3QjBYY21KTWhB?=
 =?utf-8?B?d09memNaRHFGVVlnZUFuWWkvaDBYd2laOGt4U3k4ZzIrd21kQTJYUkp6MnN0?=
 =?utf-8?B?RFdpZlpMTG9ZZEhvSWo4KzhpZmdCRDZoemRFL040VGlWOFdhSFVrVEswd3Qx?=
 =?utf-8?B?RkRKRWo0Snd3ZWxNV25OMzBTQWJlZ3dRYldXTUpaTUNsMlVyVWg2VGRPRVRN?=
 =?utf-8?B?YXk4NkozUU0yQUdjWVdFTVNMQ3FubDFOc2tzS1pqeXRkZ1BxMDJsSFAwSmJR?=
 =?utf-8?B?S29yVE1ueHZHUXJoOVVGbW12ckF4R3RUY21PY3JNOEduV3duZHRDWDdMTTFI?=
 =?utf-8?B?R3JVaHQ3QjVlZ2lYSEliWVBLSVNwcGs4U1hxWWZRajJDeVc5TEFsMjgyRDJH?=
 =?utf-8?B?cTJ2c2ovVFlXNDBSYUM1YTZUWUQvVTByK0t4RjFoeXlmMXRPdm1ydTRUM3c5?=
 =?utf-8?B?ZnNqT3FHdnpDT0U4eE0vQTkwUjF5Yk51bHVrTG5rZFRPTFk2QVdvTTlpT29u?=
 =?utf-8?B?aEYveGdtSXBpTGxiZ0dvRXliWHNsWUFUcml3OFVXR1JTMnhidm1JWU1XSWc0?=
 =?utf-8?B?aE02TmtSSmNkQmFDMFBaQ0k4bDRnWjR1Y0NKNjZYWGFuVlMrVUNwcWZOb29H?=
 =?utf-8?B?N3hyNkp6ZER3VCthc3JOK0J5RCtCa1gyUWk4N1lVTEhndVFjTUhNd0ZvaWNz?=
 =?utf-8?B?dkp6T3d6Rzl3bkFpUXlXaWNZMmFBVmZQL2NSV3ZGclJXam93cUY4WFhTa1h5?=
 =?utf-8?B?aC85a3NZOFF0cEE5UVQvaFJDUTY1dDNSSXlQRThEZDZpT1lacW9rYzlIb0Ez?=
 =?utf-8?B?dG9qcm1vVXhkcXl2ckwvajlqcUNEWXRwWjlNVXN6WHVaZmVnVS9zOExMdkRk?=
 =?utf-8?B?bjZ5eWJLWWJRZW1xK01PK0JueitMUkxiRUF1YU9rWUl3VUMxNWFmK0hlUWJK?=
 =?utf-8?B?L0JBV1oyYWs1M3R3YUlkL2M0a3ZQZUFtYllMTFpoaVhEZHN3ODZvQVZsK2dV?=
 =?utf-8?B?TjVTdUpwZGdrRmJsSGFPdXRsS09VT2Nvb3FWKzBVSzdwREJZc3R3V0lKUTQ3?=
 =?utf-8?B?UFUyN1I3aE4ycVZsNmwxOG5TdnlTdUFQR3NwV1dCVVV0Yjg4dmUwNGtkdGxH?=
 =?utf-8?B?UzNYejBxZEEwS0tsRE9JNmRBemtMbVFCM3hDY2xVNnY5RHFnYlJMdWpWa0Ji?=
 =?utf-8?B?Q29OMnN2dm13ekV3aitUWUVwbnpaYWl3WUNRanZmbVhSVXVYekMwc0tWT1Rj?=
 =?utf-8?B?bXZJUkxyTktEYnRRb1g4Y2t4czRCNFE1V01lOWo2WVVmWXJLUVljY1BFc0tW?=
 =?utf-8?B?TzBLMzR2UEhPaW9Fa3ZUZHZNUmZRaEYrWVdhcG5DSEJSa0cvTFBoRGpNRG9T?=
 =?utf-8?B?WDJINzJnOVFxWERTZW5aZ2xYaUdTR25CV2R1YUNqMTVOVi94cWd3c3FxZzNl?=
 =?utf-8?B?UUcvdWExV1Nid0hrRkZYLzhBT081ZmpIazB3NXNxWDBCV0NNMWk1dUxIT1hM?=
 =?utf-8?B?Sk41M3lhTThZenVmQWNKRWVUVE9DeXpGaWFRa2MvdXJTY1YvaTBjSi9xNEkx?=
 =?utf-8?B?U202QmtwOHhhR0tncnR6bVlQVHZnQUh2YlhTZzNSZ0dkMHhOTmt0UUtpSHpu?=
 =?utf-8?B?ZkwzWHFlY2RyTTUvbW1lRmRwcnI5S1VQQ0IvNUJzSktCN1ZlajA5ZUFSMUZo?=
 =?utf-8?B?Y0dNLzZ4Ry9yckdESlZNdHFVRDlOSjNOaXlqSzk1RHpQcDdPSXBtMmhvSzAz?=
 =?utf-8?B?RENqRUZ1MXZHWmZ1a0o5WDlKTm81R2dTMHIzbjJUNmhXcU9SRDJ5Q1I4N0dx?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JI0uzXQBdH/6yPqaM+i3Emz2V3Xbmu3KJ6rxGO4EZxUnExaS+TV1FVobdJBTPPCpWsxRWEJvdzoGaSFAKsWFU1OZuUuNzROVmFqb1D02cetxkOCuGHeAShsYcmRkgbPFVnyMDtN2vPZh/wBPiMxoTNgVzsdNsXPkfGdmY9Mzi1Yu9qPFGRIiE+164Q5p3hz5H6KDlbHCyZ9u2SSVap7WG0jobiL9VH/TAQabf0X233ES9C8LS6zicPXAvFw/2w3TOyK9/BKAbX2jFU4wAFY3Hk1/SPHx5gEo1PVAh9l6jhX8VCBh1HeQxOCqHs4whL/NsnXYXNdd/jh2ccxMt8bJRFuJkYREPGwtB4TKzlI8dcW2mHvEep5Dga+r2pWLBnaumulK/LKY/asYzT73yHAaIh0PRDQrWvPWsI9VDl00M0DNhr1YZNqL4mo3rXdXafzlJs5nNhlEnmfi3eBBdqcdTudiGYyqQDyzZ2FIVFoT93E3Lvn4e2OHOUz3BHBNC372d7VAcyDwGlC50QBpOAQRt27huPs6RFmArhy6WPOq29L/HM0HLbDcHfVReXHICSouWU8EPUEV3FjBIkFTIY8jHgMify6oQNnXDQsDgiW5gSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9327c6-8286-4c1e-1302-08dcc213f5a4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 19:03:36.3146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j89nfh7/vtDJo4DmF41mPelcW/PJdgEhRQm+KcFa5aE75dS34FOEkMp5fCdSF3wOLp1muj72+W84k0NWiVaSRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_12,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=667 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408210139
X-Proofpoint-ORIG-GUID: dU4IqykhiIgljlUQZaG882KWiS1YdD6H
X-Proofpoint-GUID: dU4IqykhiIgljlUQZaG882KWiS1YdD6H

On Wed, Aug 21, 2024 at 10:22:15AM -0400, Jeff Layton wrote:
> Also, as a side note:
> 
> fs/nfsd/nfs4xdr.c: In function ‘nfsd4_encode_fattr4_open_arguments’:
> fs/nfsd/nfs4xdr.c:3446:55: error: incompatible type for argument 2 of ‘xdrgen_encode_fattr4_open_arguments’
>  3446 |         if (!xdrgen_encode_fattr4_open_arguments(xdr, &nfsd_open_arguments))
> 
> 
> OPEN_ARGUMENTS4 is a large structure with 5 different bitmaps in it. We
> probably don't want to pass that by value. When the tool is dealing
> with a struct, we should have it generate functions that take a pointer
> instead (IMO).

Meh. xdrgen already generates pass-by-reference encoders for
structs. The problem is actually this bit of nfs4_1.x:

   typedef open_arguments4 fattr4_open_arguments;

which generates:

bool
xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const fattr4_open_arguments value)
{
        return xdrgen_encode_open_arguments4(xdr, &value);
};

So, it's a bug in the way that xdrgen handles /typedefs/ of structs,
not in the way that it handles the structs themselves.

-- 
Chuck Lever

