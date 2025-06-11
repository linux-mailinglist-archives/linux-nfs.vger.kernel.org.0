Return-Path: <linux-nfs+bounces-12291-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF26AD477F
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 02:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E16E3A8918
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 00:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3514F70;
	Wed, 11 Jun 2025 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H862CxKX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sn0DWvh2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B6286A9
	for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 00:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749602129; cv=fail; b=lF85fyPXQWmIXMxs/KnJPXwzgVa+69S0UGuahlZeLCIEFCZyuMT9bXGFwrxA6gOVUYu9iFHN2snz3sbtaFYIkJ04wIIGKWgY/hzXxPZChg/BhgXaglx+mCO4t2ltjo6BgxbHgCZ8tGET/EUrB5AxWqW/v+YvlkP3vh8kU517T8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749602129; c=relaxed/simple;
	bh=MKcqtlF40x2KQvrqHPIdS2FSHCOa5lHkpfUgWwoGeaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4vrTfB5waZ3GiGYxBxQzO1mCzyXhHSscfeL6DUQVJAYZzNm5eaYErT6It422f+6EreoEy1mLnRbxgeKyXS91sgTWVZJEis0tEgHy1YK4c2vltSBvX9DUEtIHTtNTMigscqLvX4WCXTnrhS695n7L7e9SkofiWtFw+AzVh2L7fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H862CxKX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sn0DWvh2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ALtg4t024629;
	Wed, 11 Jun 2025 00:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7gt72i62Y5umg65PHMWhuIF/2FTM+Kq/8mw/Sra7z5k=; b=
	H862CxKXh9J3XCk7I6/M9vT/7hf/CmL1f2MtrlmL0veF4J0nGkpazdf5reVTytAx
	wBwD0lXwCOrXHg5hKqSXZPCR7V9m2wl0h2dlm72f/f27Uk5Q4o+9AC+kwvsC/sB4
	KnOc6HDWRxykm953UYBbsLR4YgBsZKPnzniCFlA/U233qybwBbkw4bI2ac0VVnZW
	gUGQLMZB7iH6iKGVMKNdXEaoUZ9HGDyOu/jZu2VuWL4rn6U29lCuIc38HbJL3lMX
	w4xQbc52FIffLtAOOWtrcSBNCqm3Vk1woovqB7SaIdsTXCUiRG7WT4a6IgIBcuyr
	qpT8UhokVjAZJr125ppNPQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dad5815-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 00:35:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AMibV3032028;
	Wed, 11 Jun 2025 00:35:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9emhg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 00:35:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNchvvpb95yu7F6X0nOsKa6CuP2LrtTSSMp4KkGcsabT7UC2/vpZx7aj0OLz0F2FJMPUyaGLhSd6IlwkMcMWsiXZY1Pdmp4nQiK/PmGtQl4+HfxXYJ7r/V17R0fa9Yw8Ag4d0eR8RwUkqRo7MSWZybUbaUncp3yT7oy4nrQS1M2l0UHu3Dt9v5t0JYUb+YJt2bSkscK3pHfKjA+PC3BEeFCrjJjTI1x1jxqvOTH3nyB7m/L5yv+MW9QBTmhYQ+nOuX8+K/fAsl4hT+j8+bYahxW2yYn053IGjt0Aha5T+/pXhZQjCzPNncNDl0Jw1rwfx2cmElUt+YDD7dh2eL74lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gt72i62Y5umg65PHMWhuIF/2FTM+Kq/8mw/Sra7z5k=;
 b=qnUpHwHcX8lk/cFUQ10FlZDrTZyuiRSA9IvQvZgpYiMs/WoT/uP4ujgN6kWOAvVKmGteorCIMWn8XEXzBN7Vf4OYVZbPBR7dThAH7URTeEZl78sfYeNbqhFaTV5Srv0L5mANLuMCqduUE75EgnagrDLo09tJV5nGpodjN8tz35T40nJXwfZToTJdlkgtaQGhDE6FCQ69xQpyHT7cqV+zJ3J1qiJtCcEMjNBf+RnL//biDV3cNk46qoY41R9Pn9Uk8bhdd7bP4LM6rUJvTTandH48/XH3GivMbyiEkIOKVF17ACQjAvwWVm6/aq/2SMCnrVeqlNzpOcUL5jtpV3Tmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gt72i62Y5umg65PHMWhuIF/2FTM+Kq/8mw/Sra7z5k=;
 b=sn0DWvh2OIOvsX0k9Wnc6g1bOTeZN0O731z3vgs+IHou6zS3EPb7QAqaFuPng6JFRXxRayetp1+OgG8hzXIZKqmPlwDCE3tYiNgFFEoUm5FoSUghCr3+wd8W4kyEQMIJZvgfCiv1iHEPv8nhQ8HoHc5BdXa12jUMzmjg1oqBSGg=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA3PR10MB8347.namprd10.prod.outlook.com (2603:10b6:208:57d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 11 Jun
 2025 00:35:13 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 00:35:13 +0000
Message-ID: <8b766d2c-f2c2-4ae5-b727-61c2ad41c65d@oracle.com>
Date: Tue, 10 Jun 2025 17:35:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: detect mismatch of file handle and delegation
 stateid in OPEN op
To: Calum Mackay <calum.mackay@oracle.com>,
        Frank Filz <ffilzlnx@mindspring.com>,
        'Chuck Lever'
 <chuck.lever@oracle.com>,
        'Jeff Layton' <jlayton@kernel.org>, neilb@suse.de, okorniev@redhat.com,
        tom@talpey.com
Cc: linux-nfs@vger.kernel.org
References: <1749562875-28701-1-git-send-email-dai.ngo@oracle.com>
 <f580a2f30274ca61f44d4b8d4b5e9779acd84791.camel@kernel.org>
 <6bc66030-adba-48c0-a992-82f7bbb153f3@oracle.com>
 <7993b2bf9c38041f8963e9161aaa25984b50d3f1.camel@kernel.org>
 <c187763c-09a3-4027-9833-a78244a4329b@oracle.com>
 <34500150-e2b9-4b88-acae-aebeb1694916@oracle.com>
 <11364da2-761a-4f67-9bb6-908e9d718f5b@oracle.com>
 <09eb01dbda17$6e4f8610$4aee9230$@mindspring.com>
 <03241ae7-7f58-48cc-b163-767cb348ddaa@oracle.com>
 <97a02804-ae0a-4402-a615-1fd3c2e276f2@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <97a02804-ae0a-4402-a615-1fd3c2e276f2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0789.namprd03.prod.outlook.com
 (2603:10b6:408:13f::14) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA3PR10MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8c7bc8-1a87-4be2-6d69-08dda87fd3f9
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UThuYm92VzVzeEVxTEtnNno2cCtOejhQQ0pUTTVoeVo2b2ZDZHg0V29ZZVNy?=
 =?utf-8?B?a0RNSysyeHJPYVdZcGs4MVM3YWtNL1RGdlFWbmtubU9obWtUZHBxU00yWURE?=
 =?utf-8?B?VG5aVGx6OVoxUDVLNksxWG9yeElnTXJCU0pCRkhMM0o2c1NoQm56U0JPTDJG?=
 =?utf-8?B?ZVZCdFRKekxwWDJoOUdTQ3NUaUxWcjk4K2poQkFkYzZOK3I2eTNKRk9RVk1n?=
 =?utf-8?B?Zmw5c0FqcTAvVGh2RkszQXQvMG05R1lCY2V1c3VJTkhvU0VsSG5uaGV4emFJ?=
 =?utf-8?B?OTh2UnpQTXBPaDBLQ2FpOEJmNEhDaFdNbFllTm42UWdjb2dOaU5KZ1ZzOUNB?=
 =?utf-8?B?UmZGSmFzMEJVSGlrWjNoYjZMM0pqUWhEWm54dVNTeEt4bEpNTTk1UzFkQUNN?=
 =?utf-8?B?YzArTlBLOVZzM3E4OUt4Y3lwN2VGYzFNM0NtTCsyT3hlQ1NHeFN5dVhBWkc5?=
 =?utf-8?B?VGVkS1RsM3BIRkhGdHk5ODl5ckJQK2ErZGtseXllR21SQit4Y3J3amsrQU1t?=
 =?utf-8?B?bFpBUEd4QWRoMWVMTlFqSGJZb2Nxc3JFMWo3cjgxV2NNek9NdHJaZ1pKUVBS?=
 =?utf-8?B?S0JUb0FWVnFUaG1OclV6TC8xWVRxSVpCK1Nucm8zVzhwZ0hYZ1hwYjUwRnJz?=
 =?utf-8?B?RjVGdk5PbERwMnZzQlFOV2hkY2N6MDZ2U0EybHBRY2haZnZQR0xJSTNYT1Vj?=
 =?utf-8?B?RWRGZXlsaU12ZXFPK3BNZnQ3UmdOZGpvUzBSMGduOWphTWZoTnV5RHFQaFpE?=
 =?utf-8?B?WXp3UVB5TnF0cDRSalhyYUZJckN2SlQ1UTdyNTR0d0txdTc4RUNWbHgyRVov?=
 =?utf-8?B?NUYzMmU1ZEhlVzV3V1hMZjJPcTJUN3BzR0c4Sk1nL3VYM2JYMTAvLzI3ekh3?=
 =?utf-8?B?VVdhbG1xZWZwTmVna0g3WHhBNFJ0MGlJOXJYZUdVdWdDK0w4WUVjWVVMaGZH?=
 =?utf-8?B?OUV2ditTeHZmbUxPWG1jd0ZmR2VNVDNIRkxZa3pNdTArSnlQWDZEdVdTRC9a?=
 =?utf-8?B?RTYyOGQ3VS9wMlZoK210RzREamgvNFAvTmpGdjAyTFNhL2RNYWlKQUFQdEpU?=
 =?utf-8?B?WVlBQTQ0M2g2SWhXQ1lkTkNuMHd2RHByRnlNT1pkT2xhMHh2eGRhSUx0OHd1?=
 =?utf-8?B?bkVBb2huRk5qbHhuQlQzZkJIdTRVdzN3eUZUSHlUWlgvUmRXUEpiYzF2LzlC?=
 =?utf-8?B?SGQvMkN4R3l6ZGhjSzBNR3BQbGs1T0hkdDNWOWdNM1dMbjAvcVhsUmVCWUJi?=
 =?utf-8?B?L0N1UTZkOGVvNXY5c1lVRC8rM3NsamFRQ1NIRU9Lc1ZSWk5qVzNzV3h1ZzRj?=
 =?utf-8?B?Q2EwNFJPSkFRMEoyR3ZwTjdVcWxXTnpsdDQ3MmlubzZqdm9VemNPWmcxeVoy?=
 =?utf-8?B?eVU5a0ZrdEhEeUpQOTB6RUhqcnQzUDYvUzc1RWcybU9jZXNKNzNScXpjNnBv?=
 =?utf-8?B?NkRDd2J2Nmkyc3g5QlJGekIxdldldXlMbU1IUUhHbHU4MDlLTEJQaEtCMWRq?=
 =?utf-8?B?aTZQRzhOYmUwdUxIb2ZPMmtwTnZ4WVh1Zk9NckVLRkJHR1k5Z2NSNkY0WU1o?=
 =?utf-8?B?ZHliRHp5Ny9xSWs3a0FKeVpmOFMxZTRrRlNraXM4YzdkVTBSNGJ4RHk0ZlNT?=
 =?utf-8?B?M3NKbjJNTmtpUFZIQ1Z2eWNpaXNPUVoyUENiWEZQUzdyYTdJRGtDTEkrMmtL?=
 =?utf-8?B?bkU0T3AxV3BNb1ZMcFFKOCtoN2YxMEF3V3pnS1VVbnBEYUt2VVRKSG94RHZY?=
 =?utf-8?B?UUVlUllZRm1BSlNTeGpKd1BjZTFzV3dWbVVaRHJXa2pxSGhrQ2xraHF6WlRO?=
 =?utf-8?B?L3NNYXNMdUc2NE5pWTg4V0RPQkdKbklsTmpuS0dHSVFHeGozcGVBaDNVREFZ?=
 =?utf-8?B?ZytLRVBoR1NkZldQTmhONEhtVG5CWGhMWGVIMytOTlpoTWVVUm5jenVIeFJC?=
 =?utf-8?Q?H/E3qi7fLUM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YUNVbGQrcDRsWFJ3bmdJbmk4aERZamtkYXVDQjFkS1BlbGNDcG1DcTlZRDRU?=
 =?utf-8?B?N0RJYUZVdVByKzlpMXBxTi9tMVBaeGpoL1cvNHBVTWJQWStUU1JFektBdWJq?=
 =?utf-8?B?R095aEF6aTNZanlWV05QMEF2QUgrZWRHQmd0dWg5WkJkR0FKU0JYdS9kcUg0?=
 =?utf-8?B?eDI1Wmx3ZU9WYTA3QWZRT0VhMGh1L1ZPdGVQa0lKRTUwQU9lNW9pTTdKejJO?=
 =?utf-8?B?ZjJYbUV3M1B2TzRhMWNGOG5ZWW9DMXB4bHZCY1JBaWs5NTUxNVdLTi9IZk1N?=
 =?utf-8?B?ekFJUXZpejlWd2ZnUFlOWUdtcGh6SkJiK1o1eXVjUG5JT2RYR254c1pQZWpU?=
 =?utf-8?B?SHo3eUV4ek9UNktjajMyOXpmQWVacHBNdFZ3RCtxeTQzZHZGNDUzZ3JoRURz?=
 =?utf-8?B?TndMQkc3SWdCQ20zalBlOXFWZFNRaDdZbEpacUdXQTkzOGNGelFpZDAyeWtI?=
 =?utf-8?B?SFRCcjJHREVrcnROMmZIOWZydTBYMXZyT0QzcXVEbGgwdXFTR1dFOVE2YVBm?=
 =?utf-8?B?cGFOSFVERzJ2OHd0L01rUXhDK0xHQnJNblRnSno4Z2xmNXhwZlZ3Y1pNQUc5?=
 =?utf-8?B?bGN2eFlGUXJJQ1dWYnNON25DTGtwTXZ3VkhFMGlXd2o0VFlzdWdxMGRNOFR0?=
 =?utf-8?B?T1R6NndjREFUbmhRWUIzOUlxcVlmMzlUZC9uR3pNNkVpZG9iZEF4RDE2MjVr?=
 =?utf-8?B?MFJnU3R1SzdweXJteUZ5dXdLVGx1cG11TzB6dmROWXpnTGx0eEsvSlRwa3g5?=
 =?utf-8?B?Z2ZaY2tONXMxdWlmbFJaWXI2NXlyOWd0b0hsNjV1MGQxNW45cEdDVXVJY2tJ?=
 =?utf-8?B?dHFLeENGY1BsOVZIQ3ZkY2xLZC80eGloTldqc056ZzFIUEtmUnJnYjJHbzNz?=
 =?utf-8?B?Y2J6TTE4em5EVHhaejVxMERMYXNSMU1WMVA4cnVNcENWc2dER0xFQTl4Wjlr?=
 =?utf-8?B?enVkUGphSDZMUzJHd3Q2R1VUZXAvT2JKYUtlbUxzMy9GTDhlR1UvOE5TWkFU?=
 =?utf-8?B?YjZPbU8yWFA0TkVpZWRPa0tySGhrWmdCL1RkNURGQmhacGJobkowclFiQ2lF?=
 =?utf-8?B?Qnh5N0dyTzNiUUd2bkszNlU0a25Sdld5UGEweGhVRnRybDg4aTJwWXEra3Jx?=
 =?utf-8?B?ckFScjAzRnpteFpkZGI1SzdsTWovUkRIU2FKcC9WWnpnRkpZRXVVQVcrZ2R5?=
 =?utf-8?B?clYzMGFqcSsyY3pFVVV6RnJzeWxRWnJWeWxQN2Q5eE5NM1E5UjhIS1dUd2Jx?=
 =?utf-8?B?K2hsWkVqVGxpVHNVRmgxckE3bDUrMWk2NGZhQzdnbkxDZzlkNytvT00zMW5F?=
 =?utf-8?B?dXBBZGZlTTZVMm11ZWowVzhsYlhaZHA0dlZjZWJFemF1L2haUkFCMDMwV3B3?=
 =?utf-8?B?cGVzVDZhVmROb1pUZUVUZzNlUnZRVHJvejhKU1JiOHVsYTBBOWZZZWVEMGVh?=
 =?utf-8?B?YWZYcmNmbFVUWFUyVXM5c0JRY3NMTnBzaTc4THhWWnlMdFZxTmVaa0dGY0lE?=
 =?utf-8?B?SW1jdU1qNmpFYmxUSnZodmhGR3J4R1Qra0Z2ZTdzcnZLcDZTNE1mb2xwSHdZ?=
 =?utf-8?B?OWhHSm9SOThFMTRzSUFMMWhUVEd3TCt0SmZ2VFN3elVOSExPZzd4N3Rtbml5?=
 =?utf-8?B?M0ZvTE83YlB6ZldIYWczcE5ZS0R1OThYWFhlSzk4THNwK04wcWJaSEVvdmxk?=
 =?utf-8?B?Lys2VFpXeW9mWHdFRmVoaGpFVDJSa3lhZE1KamVRUkcxK0pjaVh1MW01eU9u?=
 =?utf-8?B?dUlSOGwvSUowL2srSWZ5Q0EvRzkrakRXRTJQRmpZbmpQQjFjYUovSDN0d3Ny?=
 =?utf-8?B?dmduZlRXQ2hLeEwvSE5kSFdWMXNlMjBmUUNmbGZDZzUxWTdaVEo1OHA0QUov?=
 =?utf-8?B?YWxKd1dEd3J3YVZCMmtzeFBwQi9kZHZWNGtiWWtidGZFZUlyajFmdmtjcVJF?=
 =?utf-8?B?SlM1VjRUWXloWlQweFcvVWJIb2dXdFB5RHUwS3RxWDg2eWprWmV5cHRrQWJT?=
 =?utf-8?B?L2dZSlF1YTlzZXFjVHVGQUFOUFFXdWVoL3YzM092bGZGZVhzbWVmQ0hYUmVw?=
 =?utf-8?B?MUJQQnRDVWloOU1vYktHSjNDYkcvL2tSczBlUXlSMGxQUjdyZmR0YUFGbFJm?=
 =?utf-8?Q?XkailOtysZaI6Au1Uw/Zn3iyC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	62ZoF/yZrksyAI4nT9unZdOOoOcHdZLvSNmqGu7NfSApqpT7bHKFhDmELqskyaH6ZurmFNhCvZO3FYxZq+0YsGHgweIAsBSaLHku42zEMOwzQMCV5FxFIlAVJlGrSMgBlSsj+KVAvX3jUKWStr1LP6x0dqiGOW/6tNFDYIsFN57Dd48tjSGYFSHd1N5oi6xeduFaZsJflsqW/zZVGEm5MWRLGHdLe5zujxXu4NzJFHMmGKU0VfY4H9jVOHx/CPJ6FanJ6FDN4LkbnYOiFosDexkLKmnRUYSPzrEvr4eXRbhJFoyF4krCTyPucHOaVj25fBbnPFOAvL7TPcHuc8DTN2sBhg6DmTdLNauNjmsDjVt+36OCRdbGrBKV/soUwnUvWGCIyxwEHoxNNhqeThMoXPqtja+EzJVa3sg/uAqdR0Eg1TP47YzrR5fo47omlGMXyuQfVo2WgAk+Yc7zXswnXLNbzdozgmcIG9xQYsGTpaybFUj3SVWVlwRxouQqLk4oAo7BYK030jqVUEE5XRdsZemlxzPjH8HpjQjGgZcH1JwrCEaEMagcC3fIivlMJ0dYgJxZgmJHTBjSTrkxoOPJR0rQ+LPHidV5jsUG7SS7uSU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8c7bc8-1a87-4be2-6d69-08dda87fd3f9
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 00:35:12.9998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRx0GQBLCzzhOymo2DZUIUHtGAai6T6K5BWD33+1DNZNqVsjomoNp+UFowYVtMHwnH/XkPJFpsQlzpOE+d+Ibg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_11,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110003
X-Proofpoint-ORIG-GUID: ZU9tm6xXYa8UFLjZDJwYgOy2tfa8WJeF
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=6848cf44 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=PZO_f5dVD-pFROSgQI0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDAwMyBTYWx0ZWRfX4Wzl35KpZXXq YqI83hIgCqyGekqc5Yn8sLo07XzlPuggzV5BjLUfRZLSRwLmhRCT3wPjZasahOKntQASz1afrhm z8nZgL1QqnaFh0iXEqaoz2+BdAhzzcYZwPmuuyQhoHLK+1xN9BiCSafWSPs4rX/kTcBeiR4Tl2C
 60cw3halEo5GaBD9tEHt7/inKkrHdoY0mFYdLyvXNT1atW1hxAlXt0s6BFbqstDH8Pahzw6Z+je YCYaP/3gA6ddFUNtqJA5KNO3yiKjmfedy25hxPas+clmwNBVaQBze6KfT1nNYmqhiAxJert6x/F pLkdHEF7KBFkEaXkGYtIjyb0ZV3m5kuZWEL8PsJayDgu7ElMzdOVtHA5EsWMS3ZlL20FEpeQCn/
 bo68kKNFy9TLswt7KpF7auaMFlkF9T8RKxmN5BJJJdE91VyFUNtX4fpQnI8D/q2XbFp7hLJS
X-Proofpoint-GUID: ZU9tm6xXYa8UFLjZDJwYgOy2tfa8WJeF


On 6/10/25 3:03 PM, Calum Mackay wrote:
> On 10/06/2025 4:05 pm, Dai Ngo wrote:
>>
>> On 6/10/25 7:53 AM, Frank Filz wrote:
>>> From: Chuck Lever [mailto:chuck.lever@oracle.com]
>>>> On 6/10/25 10:12 AM, Dai Ngo wrote:
>>>>> On 6/10/25 7:01 AM, Chuck Lever wrote:
>>>>>> On 6/10/25 9:59 AM, Jeff Layton wrote:
>>>>>>> On Tue, 2025-06-10 at 09:52 -0400, Chuck Lever wrote:
>>>>>>>> On 6/10/25 9:50 AM, Jeff Layton wrote:
>>>>>>>>> On Tue, 2025-06-10 at 06:41 -0700, Dai Ngo wrote:
>>>>>>>>>> When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH
>>>>>>>>>> or CLAIM_DELEGATION_CUR, the delegation stateid and the file
>>>>>>>>>> handle must belongs to the same file, otherwise return
>>>> NFS4ERR_BAD_STATEID.
>>>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>>>> ---
>>>>>>>>>>    fs/nfsd/nfs4state.c | 5 +++++
>>>>>>>>>>    1 file changed, 5 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c index
>>>>>>>>>> 59a693f22452..be2ee641a22d 100644
>>>>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>>>>> @@ -6318,6 +6318,11 @@ nfsd4_process_open2(struct svc_rqst
>>>>>>>>>> *rqstp, struct svc_fh *current_fh, struct nf
>>>>>>>>>>            status = nfs4_check_deleg(cl, open, &dp);
>>>>>>>>>>            if (status)
>>>>>>>>>>                goto out;
>>>>>>>>>> +        if (dp && nfsd4_is_deleg_cur(open) &&
>>>>>>>>>> +                (dp->dl_stid.sc_file != fp)) {
>>>>>>>>>> +            status = nfserr_bad_stateid;
>>>>>>>>>> +            goto out;
>>>>>>>>>> +        }
>>>>>>>>>>            stp = nfsd4_find_and_lock_existing_open(fp, open);
>>>>>>>>>>        } else {
>>>>>>>>>>            open->op_file = NULL;
>>>>>>>>> This seems like a good idea. I wonder if BAD_STATEID is the right
>>>>>>>>> error here. It is a valid stateid, after all, it just doesn't
>>>>>>>>> match the current_fh. Maybe this should be nfserr_inval ?
>>>>>>>> I agree, NFS4ERR_BAD_STATEID /might/ cause a loop, so that 
>>>>>>>> needs to
>>>>>>>> be tested. BAD_STATEID is mandated by the spec, so if we choose to
>>>>>>>> return a different status code here, it needs a comment 
>>>>>>>> explaining why.
>>>>>>>>
>>>>>>> Oh, I didn't realize that error was mandated, but you're right.
>>>>>>> RFC8881, section 8.2.4:
>>>>>>>
>>>>>>> - If the selected table entry does not match the current 
>>>>>>> filehandle,
>>>>>>> return NFS4ERR_BAD_STATEID.
>>>>>>>
>>>>>>> I guess we're stuck with reporting that unless we want to amend the
>>>>>>> spec.
>>>>>> It is spec-mandated behavior, but we are always free to ignore the
>>>>>> spec. I'm OK with NFS4ERR_INVAL if it results in better behavior (as
>>>>>> long as there is a comment explaining why we deviate from the
>>>>>> mandate).
>>>>> Since the Linux client does not behave this way I can not test if 
>>>>> this
>>>>> error get us into a loop.
>>>> Good point!
>>>>
>>>>
>>>>> I used pynfs to force this behavior.
>>>>>
>>>>> However, here is the comment in nfs4_do_open:
>>>>>
>>>>>                  /*
>>>>>                   * BAD_STATEID on OPEN means that the server 
>>>>> cancelled
>>>>> our
>>>>>                   * state before it received the OPEN_CONFIRM.
>>>>>                   * Recover by retrying the request as per the
>>>>> discussion
>>>>>                   * on Page 181 of RFC3530.
>>>>>                   */
>>>>>
>>>>> So it guess BAD_STATEID will  get the client and server into a loop.
>>>>> I'll change error to NFS4ERR_INVAL and add a comment in the code.
>>>> Thanks, we'll start there. If that's problematic, it can always be 
>>>> changed later.
>>>>
>>>> Maybe someone should file an errata against RFC 8881. <whistles
>>>> tunelessly>
>>> An interesting case. Ganesha doesn't handle this. It would 
>>> definitely be good to see an errata for it. Also a pynfs test case.
>>
>> Here is the pynfs test I used to test CLAIM_DELEG_CUR_FH:
>
> Thanks Dai; would you like to submit that as a pynfs patch, please?

Yes, I will change the expected error code to NFS4ERR_INVAL, as we 
discussed, and submit the patch.

-Dai

>
> ta,
> c.
>
>
>>
>> def testClaimDeleg_CurFh(t, env):
>>      """Test OPEN with CLAIM_DELEG_CUR_FH with mismatch file file handle
>>         and delegation stateid.
>>
>>      FLAGS: writedelegations deleg
>>      CODE: DELEG32
>>      """
>>
>>      sess = env.c1.new_client_session(env.testname(t))
>>
>>      # create file-1 with read-only access (0444) no delegatation 
>> wanted,
>>      # and leave the file opened
>>      filename1 = b"file-1"
>>      res = open_create_file(sess, filename1, open_create = 
>> OPEN4_CREATE, attrs={FATTR4_MODE: 0o444},
>>              access = OPEN4_SHARE_ACCESS_BOTH, want_deleg = False)
>>      check(res)
>>      deleg = res.resarray[-2].delegation
>>      if (_got_deleg(deleg)):
>>         fail("Not expect to get delegation")
>>      fh = res.resarray[-1].object
>>      stateid = res.resarray[-2].stateid
>>      print("----- CREATED ", filename1)
>>
>>      # create file-2 with access RW and delegation wanted
>>      filename2 = b"file-2"
>>      res = open_create_file(sess, filename2, open_create = OPEN4_CREATE,
>>              access = OPEN4_SHARE_ACCESS_BOTH, want_deleg = True)
>>      check(res)
>>      print("----- CREATED ", filename2)
>>
>>      wfh = res.resarray[-1].object
>>      wdeleg = res.resarray[-2].delegation
>>      if (not _got_deleg(wdeleg)):
>>         fail("Could not get WRITE delegation")
>>      wdelegstateid = wdeleg.write.stateid
>>
>>      # OPEN for WRITE with CLAIM_DELEG_CUR_FH using the file handle
>>      # of filename1 and the delegation stateid granted for filename2.
>>      # Since the file handle and the delegation stateid do not belong
>>      # to the same file, expect server to return NFS4ERR_BAD_STATEID.
>>
>>      claim = open_claim4(CLAIM_DELEG_CUR_FH, 
>> oc_delegate_stateid=wdelegstateid)
>>      owner = open_owner4(0, b"My Open Owner 2")
>>      how = openflag4(OPEN4_NOCREATE)
>>      open_op = op.open(0, OPEN4_SHARE_ACCESS_WRITE, 
>> OPEN4_SHARE_DENY_NONE,
>>                          owner, how, claim)
>>      res = sess.compound([op.putfh(fh), open_op])
>>      check(res, NFS4ERR_BAD_STATEID)
>>
>>      # close file-1
>>      res = close_file(sess, fh, stateid)
>>      check(res)
>>
>>      # return the write delegation
>>      res = sess.compound([op.putfh(wfh), op.delegreturn(wdelegstateid)])
>>      check(res)
>>
>>>
>>> Thanks
>>>
>>> Frank
>>>
>>
>

