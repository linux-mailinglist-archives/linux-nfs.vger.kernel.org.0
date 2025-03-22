Return-Path: <linux-nfs+bounces-10765-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE84A6CBB6
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 18:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB37189CDED
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCED14A095;
	Sat, 22 Mar 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FbX15mY5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dice8+9m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9278F4A
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742664805; cv=fail; b=UL1pgL6APJ9HUT8qg/q6YQ6y8QZ/lnyT6BKfHOh7wyrMQKa8Ti+81W9mOZc6W2yzSp/gxzyoTNMmbAa/7GcERleN6sbNEQsc7SjgvYf0k6NovH6Vid53I+jxvrnAP2HD4DcpZCFn6r0eKH+8Bhs2RL7d5gI93u9OVa+kHSpF1KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742664805; c=relaxed/simple;
	bh=CZQ1OZ6iUP130Ct5rj3/83aIXvaXJ27ctPRLEgBSllE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J1Z067tmixUlNZVYWWZt7j6+ty3AfuePh6ZJMIJMB/A5LhzVGG6j7sEc5Dy65lRg7l/ZL+TqW8tRXqV+Cip4vzotjvh+vm19kMRaZWFHQey23OXwPrx7LeqgPXL7J5uIkZ2xhjSELwcMPLgifUIkVEi8zBGTxVl3Kc44cXfFvGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FbX15mY5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dice8+9m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M9D3mm009186;
	Sat, 22 Mar 2025 17:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oFYHZuSUmOlva6Xgh32pHO56zaW8JKm+x6i8dwPlgJA=; b=
	FbX15mY5qTKut6NF2r8wLifvI+CeiiCB3AZi+xB2bgEYaVNDq7AKSAsSZfPuBMA3
	Z2Kn/w1rNGEOH57DraEwwps/5msadzehYbN2wlosugeKWYNzikObVfHcE0uLCixC
	1oyXrRNA9PYGrpL8UNypOLw4zNtIjmanaqwFbhaFqxOIij5XfWKZ55k31pHU6t/e
	Iy3b2tiM09Bs8NSElNQLXiaJxxaLdn47viC2ZpMIyBumMAFgDCHPUiYiBXV2/KcE
	evHZ7iqEiUCHm4CDOm1RkNjz0pG9wVjDIFAokWKcIGB4+knW9zGF5YRQM6NM93Oa
	/NQZv1NOjHg5orJtdhv2AQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn5m0y3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 17:33:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52MFRuZt007275;
	Sat, 22 Mar 2025 17:33:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45hkn6eqcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 17:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4z38HOQhC1/pTFT0bY3pLO4mhk2+rj51jX4kvWZxFa8d2rLmr/cvuo6f8p2ciLtOmcAn+vGlv1ol7LmtZZwcNFAE7l3sXuus/Jg82YXBYpwspM+8iApfmYwJADWnt4wKqirBK0tRUf1emtGbNJJmB/03j8DE6RpN6Qk7hjKey18O5FSKODgISlVO6Cdvd+72txlTM9FYBKlViMt5j2KTY8JQEnQnHvZPrjvYpaJx+2YvLOHFpVvzmrFf6UpwAP6bH52eKWhka6jk3l6lpxFieEd4jnHouHjXXbq/Y5YJcM30nycF5rTokhvWhRqls/1mUd3GCpyex4tb9/stJZMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFYHZuSUmOlva6Xgh32pHO56zaW8JKm+x6i8dwPlgJA=;
 b=Erj5rEbkmu+XkZRRlB4x57UsODfk8qlWXiQvMWvgOJ4uXfY2ytD6+CuWkDQZyh+0yJRmoj+iYZXj//Kx7/M2mELza7oIexey0Aw0ZFYMqPOgneCV9HaC/ZmXJjtpTjl0UwzeBYPEcNALiEkHhLxdR3k03G8MwcAxZbEwDhnm7AlqGLzdcdh/iUqUQb+9+kKNZJ4dH049X0onx1zX3C2DHMtl51njbJ0p0ZJVvCTbWkBz5TYdpXpazjURLi9p6+f71tv5tCLgSD7VsPtDgzxh3qpV6yqacLhsN9A9AThamsKwhGYywaDQq7F5iZHcZWRjP3VXNuNF5xskeyqozz38tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFYHZuSUmOlva6Xgh32pHO56zaW8JKm+x6i8dwPlgJA=;
 b=Dice8+9mfYQ2renhGijGbuB+5g1de4canDM4XUXprEFMfZY7TtSMBHBE83wRBxVzr/nhwrI/+BdBc8FmTfJQ5Z2vsTqAQUdhBkt/mB79dUgPZ/Ia42pbqPSeqT18nxk+oYD7vIM7vXcg5wHu1bkTC/qkbU0Gbth0cTjv7HMahqU=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by BN0PR10MB4951.namprd10.prod.outlook.com (2603:10b6:408:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Sat, 22 Mar
 2025 17:33:03 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 17:33:03 +0000
Message-ID: <9e7a546c-a192-4e8b-bbd6-a3aaedb5e013@oracle.com>
Date: Sat, 22 Mar 2025 13:33:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: kernel panic when starting nfsd on OpenWrt with kernel 6.12.19
To: John <therealgraysky@proton.me>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <xD3JWWvIeTEG7_-UtXFNOaGpYHZL9Dr4beYme8ebQZiBvaBcTu3u7Q9GxE7cJrGRYsfTjC2BPxBTuyl1TijqjUP8_nC4tpcfekVKuBtDp68=@proton.me>
 <0cd73138-baa7-4cd7-a6ed-7c5eefed495f@oracle.com>
 <yW5ewBN3-dAMHSq9KmbFRPRt_fK0FTmuqclUbu4K1kZPcfB6DmXRPOVC_OAwh1waQz2Of0qUDqxQ3YL-NBULF9H6-HMdVjixFAad20f5sUY=@proton.me>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <yW5ewBN3-dAMHSq9KmbFRPRt_fK0FTmuqclUbu4K1kZPcfB6DmXRPOVC_OAwh1waQz2Of0qUDqxQ3YL-NBULF9H6-HMdVjixFAad20f5sUY=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:610:e7::31) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|BN0PR10MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2a5079-44cc-4d99-5bf2-08dd6967995d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFlmaHM3VkhKd3pSa0srU2xQbUNiQ3V4WXpoN1ZQL243cGc4RlpwZzlTMmcz?=
 =?utf-8?B?ZXBKazBRODRyVE5FclprNmtWbFVKUzd5cnRBRTFsZnMwMEZHM1lLdTNlUmF5?=
 =?utf-8?B?UTdsbzc3cFh1dVp5MmFvdFF2VE1CY3l6RDNVTGNzOGFEcEpmbnRvNEZnZjl4?=
 =?utf-8?B?NjRWSEFIdkZMbmExOEZOcUZxQjNybUJqQUppVXNqZWZ4WEMzUXVabk50MXBB?=
 =?utf-8?B?SVEyYThCMXFaZUhDZUhZZ2NtRjRtQ0R3WVlDb254SHZEOUpUbmpLeEFrV0RR?=
 =?utf-8?B?bzhyTE0zN0lvZk9DeTA1czNSSy9IVGs3aWpCWDd3YW81Nk5lYmljYlE2dWpi?=
 =?utf-8?B?VlRCUjdDL3Jia0JrSmE2ZGZzdzVGZWRwQjVZbzZXdy84eUphTmY2eDFBQU9B?=
 =?utf-8?B?bFpKVTcveDNBZTNTYXpDdi9sdlNoRWNnWUFJd09tTVRYQy9YeHNzaGtPbnBZ?=
 =?utf-8?B?dDJhc3NFMnB4Zko1endvOWg3aG9LQUpDMlpDNDlldkgzTHc3K3hyc1VmTzBF?=
 =?utf-8?B?T3h0Sjc1TERqNm1odUFBSjVSTnhTWmkrejBGaW85NDdYWnpITjJUT3Mwa2dD?=
 =?utf-8?B?TW9zOTFZcElVS29yb3JIU2hsaTN4bHRzcDZiajdFUjJ5S0RsUU03Wk8wN0px?=
 =?utf-8?B?dWduZ2hvTzV5RWs3OXljN3BaejZGcFNyMmpUSDUrUXdGWkMyOFlyZG1Vcnln?=
 =?utf-8?B?Szc3ZTBCYTRPQ2tiS0xZR1FoNkR1M01KOVZtSDFaVjlpbE9FTTJhZmtURDRv?=
 =?utf-8?B?S1JPall1OE1oRDdKTy9BNmJKeDh4SDVZNzlFekVJTHlzc2FBUkxyazNydHF2?=
 =?utf-8?B?bFZndk5xQTBEZEZIaFFvMmJKOUNhZ3JmYktzRHJxZTUzYzRkTlZkdTVLeXhj?=
 =?utf-8?B?Z1JGZDFiOUlVdkk3dlZvZzc0b01vQThXWEpZU1N3b0VsbEh4eEJpLzIxeTNv?=
 =?utf-8?B?VXZFOCtSNXFxaGcwTXNZcmt0My9rZHFwQklhMTNDeFU4K1RJall4K2NlRlha?=
 =?utf-8?B?aEgrNWhvM0pXQWR3eWQrdFdtRXRLZFVScVA5NHVBMEhqd3NRZzhWTTJ2Wk1w?=
 =?utf-8?B?WlNRT2Rta21WaXFXVExMMnJCb20rbHQ1VG5HaWR4ajlMN3ZyOVBnYUpyNEs2?=
 =?utf-8?B?dE9PL0hJb3Q4VFZlcGlFaDRxdUVQUmlmbTFlOG5GVDBBeXJUVTRRQ2t1MzNZ?=
 =?utf-8?B?QVFXZmxPZTlxOUZYUHBCclNoRnEzMy9NTEEvdXBMUVAxSVBPNmtDengrNmVl?=
 =?utf-8?B?NGtrSm1pT2RHeEhwc3NLZVVDL3hicE1maDBZblR6MEh0ZXl3VHB1QUdTbDhj?=
 =?utf-8?B?MXQxYTJVbVVhS2MrSzBWQ3MxcFVNQXB0a3VvVWJvQ2M4OXR3emI1RDM2Y0lh?=
 =?utf-8?B?NDFqZjIwWUNTakp3RXBGWFdyYUxCbC9ZZ2RWY2E3VVUvOUdNNUg5T3FJbThL?=
 =?utf-8?B?aTk0UGc1WGppZHYwOGI2TkJieEdjQzdVTHYyUGNodkN5MmlmaVNRRGdXKytN?=
 =?utf-8?B?Mkk5bG9DUi92amxicHlBTFNPd0VkZnJIZjh4aTJTKzZhd04xVEhuUmVMc2dz?=
 =?utf-8?B?OHhmcGthOXBuekpVQUMrNXZWSzFyRWR6UzRHcHhnVkUzL1pYSDh6cEU0TUxl?=
 =?utf-8?B?S090WFFxZGJPWWxzTzZwTGZyVExUUFY3eVVGVmdMNTRYOVFqd2J5L3dCTTZE?=
 =?utf-8?B?aTh4bjB4NzhMWDFLZnl2VUVTd09RMm1CRXFVM0tkcXRENFZjemJhc2JvOFph?=
 =?utf-8?B?SU5WU1lmNDZYWE5KMk93UzdtbXh3M1VUdjY1QW94YUpjdTg3amZYME9KYUhN?=
 =?utf-8?B?bzdFSWs1M0IyNzlseGJmSnVXaTdMblBLQ3RLSDFJZUt2UU03dDA0YStLUzI2?=
 =?utf-8?Q?0LEsaO7vCNKGt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzBCZjZHdkVuQjJIWmk0clduU3dzV1lSbThNcDZJNVBBR0ZFNWNDQmZ6dStK?=
 =?utf-8?B?YTVJTTliTDZoNDRjZGJoZlBqcm9ZWkZNWWtxRlJDZmQwci9OUzFmQ3IwRWln?=
 =?utf-8?B?WlFZYktQUU1kUmJveU1XM1cralhTNFY4TWZaZjczT2NkV21MRHNISXNRdjVC?=
 =?utf-8?B?di9vRjQ1WmE4Ykh2akg5M1V2N0VtcCtOUTVGOEMrbURMMFhqenZCUGlXeU9V?=
 =?utf-8?B?TFpPTytFUzl0TU9pNVB3dXdvb04zL3FkSnJ0V3NaaHlZdTI3UE05bHI5ejR1?=
 =?utf-8?B?QnNaMXBaaFllMmFyK3FVN3NaMDVRRlYvQzdDY0VxUEVaUkNOK1JGZFlMV2dw?=
 =?utf-8?B?Qk9JeXF5OXREME9sbmNzNDN4cGVDRitpdEJDbXhkNFlrVnFkTHBWZW5PMU92?=
 =?utf-8?B?a05YajBSYXBmSGNkbFRDcW1ETFlYY0tRd3VzcDRHc3Brb1cwVTA1Vm45NDhC?=
 =?utf-8?B?VVQrSDVKQlBlZ0FuN2lKblVWd3VUc2N1WEh3UERFN3RGTkREZVFKREUzTXJL?=
 =?utf-8?B?dlVjRWdnVURxN3BoTFNXeUhXaVhKc3RhdGl1UGw2ZStKKythMGlBb3kwNkVU?=
 =?utf-8?B?Y2MzS3FJa3JSZk9SdTdmanR3OFVvMEZmMnhLakhJc043YTBzemZmKzJUbzJC?=
 =?utf-8?B?QjRNdVdZdmxPaUdXQjhySDc0UElleS9uZTlxNEluYm00eEkxeEpGTmo5YTIx?=
 =?utf-8?B?UUFCYW1vc2N6bkl0KzlrdHJCNmF5cStISkIraFpxdzM0RGxFUW1ZamlEV1JK?=
 =?utf-8?B?OVBBZWwxNzc0QmJSOGR0TFBuekV4MDB4b0ZNb1I4OUVoYUF3RE9JZDRvK2lj?=
 =?utf-8?B?L0dvK29iaEZ1QVJFdURDeDFuTFdjVThpS0VtTjFLY1BLbFlHekhxd0tNNzdV?=
 =?utf-8?B?cVYzeWxZOG1TdDRFWk5UZ3NlZzRpRlcyVE5oK3RlQ2dZTmdTNndrRkdHMVRZ?=
 =?utf-8?B?YnJpR1BKUDBCNVM1MGl2d1RoNVpVYXNIOGVaL1NRWXVQQ3NGcTQ1TmpyM0dF?=
 =?utf-8?B?MmgwaFBaRnNDaTI1a3VsMUpVKzZnenMwRWR3T3Y3ek0rTS9KaC83VUJXNHN3?=
 =?utf-8?B?MWlJaUdpQm5lRFNpdEtzNXFTSHc1Q1BPRUhja0I0LzRZK3BkOGlXYkpPMzVi?=
 =?utf-8?B?VmVCaU51cUV3NW9QdVhHSEtyd2JpY3k2cSsrSGVVbEtvVFRyK2NDZ3VINnVR?=
 =?utf-8?B?bGlERUlxRVlGNG5GZjJ3MEI2N3dGbzZTdzN2Nnp6V0FYaStTTlRaRjI2OFNl?=
 =?utf-8?B?dWpPejFuL3VlK2hjSTBuQVg3ZW1kWVJwaUlSY0FLRW1OR0RhSTN6NGQ3V2Mv?=
 =?utf-8?B?Z0lrMEFONjJQWkNlbkk3QlU5UFR4RHcvbDBYdnQ1aWhqeDY5cHJGaTZ6aTE5?=
 =?utf-8?B?bXNDTm0yRVRSRkdZenRpejNTUXBYNDBDWnFIMGtodmc0N0JPNy91ZTg5Z2d3?=
 =?utf-8?B?bi83VmxuVUFUUnNSclRJRllEK1pidTV2aE1KanMxTnE0TmRSckV0NUxWWFFO?=
 =?utf-8?B?eHRVUXpqTHhhWmNRdFc3RS9kL2YxSTRzYW43aTMwZjRSZGR3a3R2Rzg4N1Nr?=
 =?utf-8?B?ZkozaFdXSmVuL1Uxbnh3VjBFeElBZUxFOTBtLzJMQlBwUFlWQ1hXekRsMHQz?=
 =?utf-8?B?WFJvaGJGODJoblVSQzA4ODJaVVhBbzBlYVQvWHV6MndBOGJnSUkxYjQzMEU4?=
 =?utf-8?B?eEQ0RzY5a011OUN2MEJJbzhjTUFtVmxIL1FWYUxRenVIQXRrMHhlcTMzc0Vx?=
 =?utf-8?B?WU5CdVVieU5qMVFYenhFOEJSWDhYbVdCdFI2T2xacC9JakJKcHVLV1liZCtC?=
 =?utf-8?B?S0d2dit6aGZ2ajJ6Q0xtTERKTVBoY1dxQlRLL215UzVuOWNwc3dGbUxIcHcx?=
 =?utf-8?B?Rk92VWNYYm4vRGRDYnZhWUViQUJ2b1BrS0NYSkhQbS96YmFCdVVjQU9hTFF0?=
 =?utf-8?B?c3MyT2FOMVN6YTRPZmJsdWxNNDFxRmJZMDc0ZG1jNmd3Wnp0WDRTWEJEUFVU?=
 =?utf-8?B?cGpEUENsMHRsUmNrK2k5NDZDZVRCbXpsdTNCdHpoRnZZNGdScjBMcVk0VDRB?=
 =?utf-8?B?cFdHaWJrTkErbGE2UUJHdVppTmQwMjUyQWJjYWIxbTZYT281akErQXRxUER1?=
 =?utf-8?B?dk5Db2MwaXV1VUYwUm5vK09rOEpvbHNvVk1nc0pzZVA0cERIM2F2WUgzVFZU?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t2dXZjHHGZwyA8F7OI3UTwV/G7AVwxx+bbJv/9TgfEUDvbzFP3hXtikoBRgswqT86q6FbUwDK/gowpG2nQou6fT83zfqxuh4a95QopcZWWRdML1HpJO0qlmdesHDjmXmgFr7pX6+iGHAUp+CAmMsJwSV5nUgvNVzVoviplvQ+9CCPXpiUWuT51wMqKAtjGMz31qTunMA0IASrkZ/JJbd2bwmuqjclrSMn3bKhdicOJjbPZsinHsIROurz6H1bjwvagxVAWvNAeoxVLPyKsOktVGT5fvZHg+zgfaC0AYgvUyAI3PH3KTcWnH15Ka8SmApy2hRrWI2WUbrz+2IN2mAqZMNx2/jO3Ub77hN2DZXfAcw1C1J4gSoNnWi2cGAFD6snkea2oDMyeEG7spvaF3o1nc73Hq7VqnE4maS1yy6dYCpDhPo/t9fzQ2EgFZxYYHAxrgZTZOg/e0Vr1OIx3WaxMdJ3RuNamjzfetYbTYbJ/pKLIf2jVjZJMubaqvs2zHpdy5xYrO26Go3CzDhxdIp0SxDC1zdaOojGNpxCXTCY4GgFZP76jlVBzhzB3xo52//ib1oKoAkbDQfcw0g5PZf5LydQSvTGv69+OuFg6nO3aI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2a5079-44cc-4d99-5bf2-08dd6967995d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 17:33:03.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+VQZDdYyCOWqKE93RDKpveoBOLx+h2ezrd5WpeWwjoaGY7SyXUNR5Kp5cton492m1u7ub/HJzkjFf1ZoLEjTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503220131
X-Proofpoint-GUID: 5aZaO4LxcTU_LEKBiNe-xUgeJ44rVQkL
X-Proofpoint-ORIG-GUID: 5aZaO4LxcTU_LEKBiNe-xUgeJ44rVQkL

On 3/22/25 1:20 PM, John wrote:
> 
> 
> On Saturday, March 22nd, 2025 at 10:49 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> I recommend bisecting between 6.6 and 6.12.19 to locate the culprit.
>>
>> When you have that information, open a bug on bugzilla.kernel.org under
>> Filesystems/NFSD and attach your information there.
> 
> Wish I could, but the way OpenWrt is designed, moving from one kernel branch to another is major undertaking often requiring months of tweaks 1,000s of patches, Makefiles, config files, etc.
> 
> I have been reading up on NFSv4 and am wondering if there is a way to simply disable the callback function. Could that work-around this crash?
> 
> Unfortunately, OpenWrt's nfs-kernel-server package does not ship nor use something like /etc/nfs.conf. At the link below you can see their init script to start nfsd. Many thank for any ideas.
> 
> https://github.com/openwrt/packages/blob/master/net/nfs-kernel-server/files/nfsd.init

Open a bug anyway, please. I have a nightly CI for NFSD that has not
crashed on v6.12 LTS, so this is a new and unseen issue.

Thanks for the report!


-- 
Chuck Lever

