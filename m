Return-Path: <linux-nfs+bounces-12182-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4956DAD1323
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jun 2025 17:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061B41691F2
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jun 2025 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AC8186284;
	Sun,  8 Jun 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HJFE3mtm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nGIXVcRT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC8188006
	for <linux-nfs@vger.kernel.org>; Sun,  8 Jun 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749398275; cv=fail; b=YOwEIQBWOixdbv7Ci82vXhcNsPQDtwEHMZTehBEk4EGn845X2u0LOeyl+COJrOwkBOEBpZEM3dbETQz8fvcyWgseUdU/arekrt2qEjpyA5yFOOEoT0HVOwuqrtDl/4Pyobik1xHtiyfhVmKg7oSMsXEumiN8NVEdhZ5rfXr8QME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749398275; c=relaxed/simple;
	bh=68BozyP4+nhu8hYLhuFy88NcuSk55CInSDOwempYdFI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZI+TmhXUITDhvfp2yYx8J+6aAojQKaqGwsJuZ8wUE3+2fKX4Yk9t7pT1g3YulzxEYlWQIr8hlR+aqccMEb1KwFVNzWdvrgcN3WxRSuDpA0tL11YL/usc2sfqJdZpUzHlU7AtuMTa6dovQwWurWENyhP7gniBqg32QbekaE1Epu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HJFE3mtm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nGIXVcRT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558FG5Nu012928;
	Sun, 8 Jun 2025 15:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Jz/Wa9dqFWgUm0U6+a33fcCWVW7du0VwoQ7LaLRBZJE=; b=
	HJFE3mtm8mxMW8FTxv/rXkZYU8hLiDY5IBdrqFJ96ZzrBQM6wBRnHEaa4XNo0N0N
	ApxJmoKuPLvR31+yqNtjVoxseXawN9Fm62zakJz1oKPtFWF13I3DPsMDTo54nqoz
	lFvqXYlSyWD8fkzwTGKC1KoF4LDMTCiOaUo6LDYGvOBrLlfdMCZuozDVtWynAGH8
	ZXU+1S+B8fVGb2kESnMwqdOvnswIJPgHSaRTY1KrNoYPSpD2Pc9X1QDofx1lcCsY
	hL1JAqTPmFVHsQ78PQXfZbaabT6QABLMID9O8xGToV167Izrn3YV99Hm3OO/sJA1
	pDpNLM5aYSs42lXCn/28QA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14936q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Jun 2025 15:57:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 558ATSmH020717;
	Sun, 8 Jun 2025 15:57:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7dydw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Jun 2025 15:57:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFLwal2HjCv1n/yzb39T2VPPIWVjC0qNVkDYpd8Jyo0BilIJdAJGa3Z3J16QD/4cPiWigACfXTL66VPC+K70ak3gjfKZPLQGLWm1i1/Cd0UUvR0nz/CfuXBhlkvwsm7j1w8jk0ndVIwVai6aP41JJZJtbGcPS7tbhYsa52Lepr/7kei22Q13N9RGIKHrk7P4ivlUonOmFYNtX/+DSzWj1e3S3qZ3rme1QLWt95uTQHt6cX/NZdEwJS5cMICtLQ1ixdOZD0c6Oliwwy4Cjs0nPGt6rB0C2x7Sb9F7mWoavhvWFilOJISKWLdiCmqN9Terg61a4N4Zy8b6kQEzAc8cnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jz/Wa9dqFWgUm0U6+a33fcCWVW7du0VwoQ7LaLRBZJE=;
 b=OafZAkIuNrl/K7YN0ECMKxQojFI1G+wCI4uJLJZw3LCCUSoJM0GhqUqs8SRwE3H/OmbCK4K5LuFnPEDD2u8aW51XTdORBHjNv9gy0SuxwaTNDbpDyfKkkvx8Bd+bpQDm0uuyP+K5qQCp/USEm5BSH/0Utqw80UAXvrUR64ZX8vU6LqZFYcbl3OPRjGQxKrLvMwRmcsetlYqTnF/qKnmIfVJYx82nYtyCHrlKHxDeX2OgnBbRPsYtxlhvFppoOQp+kzP13lilxBa/ml1ILiaEP7cMlA5sMLCQv6W4y8ujUnZCoOQEKuOKW2C8RApVgK0fZeYo2QbML+Bgl4HT8O50bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz/Wa9dqFWgUm0U6+a33fcCWVW7du0VwoQ7LaLRBZJE=;
 b=nGIXVcRTxhBvDeKNr4Jzw9nWF4dpKtPcZHQSnpzUGu5GGd9rujPMFYv+wXP7YtHEu6sLStiDYDWNuJaTQzhZr/4K5o68wi84SzlDunaa+Q/+qi4qwB5e7pz4us8QK7VzOleyqOZpkORc3ogioy8fHHmmmq28BWsaxRytvMEyFSk=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Sun, 8 Jun
 2025 15:57:41 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%7]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 15:57:41 +0000
Message-ID: <c8cee52d-84ae-46a9-a10f-472346f748f8@oracle.com>
Date: Sun, 8 Jun 2025 11:57:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Questions Regarding Delegation Claim Behavior
To: Petro Pavlov <petro.pavlov@vastdata.com>
Cc: Roi Azarzar <roi.azarzar@vastdata.com>, linux-nfs@vger.kernel.org
References: <CAN5pLa6EU6nKe=qt+QijK1OMyt8JjHBC2VCk=NMMSA4SJmS4rg@mail.gmail.com>
 <2529724b-ad96-4b02-9d8e-647ef21eab03@oracle.com>
 <CAN5pLa4z-v9MSwZCxbW6oMy1Fa=b9GFEwmVxdDTnguO6_9-f_g@mail.gmail.com>
 <8b83e1ef-867b-4b4f-95b6-9dc03d6d591c@oracle.com>
 <a464374b-40a8-48d6-986c-ed83d1d81394@oracle.com>
 <CAN5pLa66Fg0kWcwreggDP1btu=guC7ZgZrKX74sKSuej3mXwfQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN5pLa66Fg0kWcwreggDP1btu=guC7ZgZrKX74sKSuej3mXwfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:610:52::14) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 487ce454-4c5c-4b6f-18b1-08dda6a532f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHR6QVNRdEV2ZDQvL2Y4L0gxRUlKdTh2RnRZQkNVQ1ZuWmpZdzdwRjRCdDJK?=
 =?utf-8?B?STJYWVg5NGpzZjl2SHpueUFJazU1NG5pZGFYVEZHTTg2Smkwa0JtQmxhZ2py?=
 =?utf-8?B?NzJqQVc2a05uZSt2WFd5cnk2QkdwYnNRY2pvU0RBRWowMGw5MWZyNTNyRXRV?=
 =?utf-8?B?R2xTd2NxNHlBd09QVTVKKzA3R05meHgzVlU5NXljQWxYN1NxeHZ1dEZJbC9S?=
 =?utf-8?B?bFNwWDg1RXRiZStrQnYrZTNmVzRvTW5kaFJsc3hTUjNBKzBTbnpOWUx3Y282?=
 =?utf-8?B?anNweGFLeFBpbWtaUVROYWdnaWtzOXhGNFZMU3FQakxhYitPQldOb1BOK2ZH?=
 =?utf-8?B?M0hhbjFyNVB4Zyt2WWJLWVJqeWF5RjdIUHhLeWdZVFJuaGt6SDFYc0ZBNUR5?=
 =?utf-8?B?TWhJUVZRQTZ0MGZhTW1HMjNxVHdvNmNKU3VFMjN3YkpoSXJSMDh0dXZacERw?=
 =?utf-8?B?OTBJdzdPT1FXVVFDNjE1d3lOajRsY01TRlBjK2tLZXlXd2EvSlVhZXBQRDlZ?=
 =?utf-8?B?NExIb2t6MEtsUGlJT211VW1neDFVS3NyaHp3NXJzbzJkS01sbXZzUkU0dTdu?=
 =?utf-8?B?UFFmTjhvR3l3KzBNbHlFZ0ZWb3dpU2QvU2d6QXZvTExqaktYcExGY3loajRi?=
 =?utf-8?B?WFhybFUwZnN6d1F0TnM4eitzQUVpcndIMEZnbkx5cXhLYzBieHFXUi9aWkx0?=
 =?utf-8?B?QUtlSHpBeHl1czd6d2VOYVlTZFVOZEZHbW05Z1JNa2crdVYvdjVxK3NpUXdj?=
 =?utf-8?B?dzJmZWVEeFdXaXZITDl1UVY3NlYzcWZpSE1scXFiaHlNL0ZhTy83NEtrVE5s?=
 =?utf-8?B?ZG5odDVHaTVlR1BIU3FESzVsdkNTRld0Mzk5d3VhL0F3dGRGMVhmUnR3MDJ2?=
 =?utf-8?B?RFpHS2N5R04wMmU4emVUMGRtSkdrR0lWU0F1RFg1NlY1SlRMeWRtZU9nWSts?=
 =?utf-8?B?TGdQYXdYRXlVM3BvT3F1QWhjbjBMTFpKd1pHT2I4QWEwcWRrUUpxVngraWZn?=
 =?utf-8?B?Nno5bXBNK1BWUm8xTytQZ2hJVjgvKzNDOXZSRGFyaTU3dkZSd0xjcThyOWtJ?=
 =?utf-8?B?Nk40eXdsajZoVmR2YnNjYkF4MlZoZW1kMHp2SFBsOEVHdHdkNGdEMXBjdk4w?=
 =?utf-8?B?ZUdMcWV1Q21OWDkyMjRQUXdMeXJHbDg0ek9BdHBjSUNVTDlla1JkN0xXMEFL?=
 =?utf-8?B?aVhVa1pWMW9POXhlZExyREs5NUtuRElqYno2ZmFXb2ZzVmtDT0ZlRDVwa1NB?=
 =?utf-8?B?REprdmpHeWIzR0lFVC9QSlN6SDVodnlJSEJLSEswMWxjMDNuNlVpZ2orTjJK?=
 =?utf-8?B?YzI1QUNYYkV1cWNXMklvbWdYMUNGajlTUjdkWWZWbWZ0bTZnL3NpWHNzRXN1?=
 =?utf-8?B?aDh4YUo5RFpOMDBzMWxpaTJaNVBsNkJzTkM1ejY4ZHJ2bzUvUTlXR1czNFFY?=
 =?utf-8?B?N3FxZmsyZnlLRWw3bVJITm9RZldqekxWMG1Ka3I2ZEJDVXNEa1dtMkhYUGd2?=
 =?utf-8?B?TjMremtkNERpQnBjQ0U4NDlXWFljS000ZTA3bXlhbFhWNWNuL3dacGFVTkhC?=
 =?utf-8?B?RmVkOWpETkRmOXFuT29YdStkaUtIaGhjRzVaYnRVOENCc1dUVUpvcVdrVUlm?=
 =?utf-8?B?R0JNRmFSdlQzNldWMVArblJRMXYycjF2d3FtRFljRDg4Z2pRSmtIdWRLbXFl?=
 =?utf-8?B?UFcrZFNFZVNCaUMvWnRTV2F1dVZCb3lIY1lZeFJPTjZybmJ2VEs3UFFQMXo4?=
 =?utf-8?B?bzFJRFFKSGNpWWZJeGxKSktIbTNCWFUvMUFkNEE3Z0FIZ0xySEpFWkowZkJu?=
 =?utf-8?B?akdVUVY4MjhUTDlLTTYrZEx1SUFrUU50Nnc0dzZLaDhkdXZrWFBjd1RqRDJW?=
 =?utf-8?B?dmRjdWRIS2lPdkc3cm1UZEZFODArWm1ZUVdtSUdqNEJ6VnA1aGY3TXMrMzhv?=
 =?utf-8?Q?P7aPMa7iVZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGJnYTNkZzZGS253UnVwQXBkMkZWSFhhdDV2U0lCWUZlQ3BIdEdKRm12MUV4?=
 =?utf-8?B?V2xncWFrSVBsV2xCMG5Nb1ltRjFYWFRSQkZsNk5iaWo1WGpkbmNRUFloRmY3?=
 =?utf-8?B?YnFsb2ppc0c1elNxYndDeGF3c05MSy9WcnBsMTg5SzlUVVo0cytFUFNBTko1?=
 =?utf-8?B?NmxnMHIxSHZaOGVxTGcyMnZCN0NHQWZuSEoyUjRrR0NMdkRVZGdwN2Z3d1NR?=
 =?utf-8?B?YUdSeEE5b1Vna0RtdTNRSjhzYkV6cDRFNW4vQ0tuV3dKZkNWVE14QW91SzM5?=
 =?utf-8?B?eDMxcm9pOW1CYU1DTCtGb3RhNUc2a2RneFFIM1hpanJtUCtYTVRFUCtuUjBC?=
 =?utf-8?B?UE92cTVUbS9Ud25hNmViSGVYNS9EQ2dzWUd5c0ZSdmdiZ1htL203bVFTT2Vr?=
 =?utf-8?B?LzBHbFdwZWlqWEdRTHFuaUZvaE5zWEpoblk5bjBYellBUW5kYUc1aUd3UFVm?=
 =?utf-8?B?aVFxY21UTGkzenpHZ2VXYUtMOFQ5REFJdGVmSUdVdFdLSXBRaEtiWGdaVWtr?=
 =?utf-8?B?VlNiYU8zcERlNnVpdDRVayswMWZhSnFaSXM2SlM0NEJmaytRZUdjLzZrQ004?=
 =?utf-8?B?U1ZsaGNRWkEyenI3WUx1Ujl1VjlnenpBY2xHZlg4ckZKQjYvUTl1Qm1ZTmRQ?=
 =?utf-8?B?N1crbXNGZkc5NHNRSGFmRndKYWpOZXhhOUtVSVpDTnJkMWM1b1N1TDdrTmRI?=
 =?utf-8?B?eTZCZGkvR1VtRFBjYjhFTzBDSVYyRmFMRnhERmY2VngyYXhtbzRKeDR3Z2R3?=
 =?utf-8?B?RFZ2Z0JrcUpUVjZiSlhIcTdlVkVJOG44RWh2RDdkbkR5VnRaZVNkZXdZaHNp?=
 =?utf-8?B?czVYbWZSQllOcUlSZ2xtY0NvZVVKN2MydlBKNnM3akxGLzNVMVNiYndQblFs?=
 =?utf-8?B?RWhZNDl5Wk5BVmlVeWVOM01oWjVvQXFXcC93blJnT2NKeGRKYWd5V29OWjJp?=
 =?utf-8?B?eUwweXlRdzRTRU5ycGw1TkM3ZlRLK2dGb0laQml5SlVJZW5WOU45YjFxcTJC?=
 =?utf-8?B?MlFEQ3I0TDdSeC9iZm5NNU52b2FBRms2ekg5K1pIa2ZqTUR2UFNnVUdkekdU?=
 =?utf-8?B?eWptaVRhbWY2V0pZS20rVjZVZ1BkVWVzcWV4TmpUOTdoMGRtdFhFUDZBZWV3?=
 =?utf-8?B?VjR1eEJBRWtTZHV1VGl3WjdWWkVNd01CMzFJLzV3Q3B4MVpGOGowZTNiQjJP?=
 =?utf-8?B?bC9lQk1hcC9XQnFmWEVBTWdUUjFxbGgraFZ1dnB1akcvTU55OW4wVGZzT1V4?=
 =?utf-8?B?bTRSOTNGVXpRSjZmaG9SVUxwZWdKbkx5bVFzbDNFc0ZUTnNPV0dxV0VPQ2R5?=
 =?utf-8?B?akdZU2hNblVzTWEwSzNrL3FkVzhNR2ZPMDM2dVBLRCs2bXZDa05NWndoN3dI?=
 =?utf-8?B?eXBINHZwQnlhcTYxbHlKSldjaGFnWUxLdlVZNXpnNnBGdlpmQkxya2E1ZHds?=
 =?utf-8?B?NVRIclduR3FlaVRvNjFUWWJDbENlSHpkSUJzUUUvb3BRNTVYMGMxRTV1S3ZF?=
 =?utf-8?B?M25wSWZKbUFWTjY1WHJpRnVOMkwxQmNUcjNkSTRhWWpGNXBmL05NdHJYT0Qz?=
 =?utf-8?B?R1VBTW1YV2wrQW1zK1YyakxZR2c1SXpBQWRQZ2lESTYrVDUzQUJFSlMrOUFS?=
 =?utf-8?B?Q1NJYW5ESHB4Mzg2Tm5Dc2xqYmdwc3YvekJDc0l3VkVUQlkxcWZ5RFBIbUFt?=
 =?utf-8?B?WDg4dEgwam9DR0tIUUp2OHpmYVErcGM4ak56RGpJamNHdVVUTnZad212RHF0?=
 =?utf-8?B?YTdCNGU1TmhKWFdTeG9LeUMyUjVxSlVoRlZ2Z0F6WCtVd0FoM2VIWURSV2dD?=
 =?utf-8?B?cnFIQlNkWSszQ0dqNHZtNjZucXdoTFJWYTd5dXlLRHU2Qk93aVcyazJnckF6?=
 =?utf-8?B?a1JGUGtqZGtjNEYwUUVOcFk0ZURHc2ZFUUNtcExacmpoV1RGYVhaRnc1dGc2?=
 =?utf-8?B?UkRvMXRvQWpINitDYWswejBVaTNQeGdMNVhVTWZYV0FiWExOL2g2T0daUW9k?=
 =?utf-8?B?cmJwalBjN3NEWXNsNlJZS2duU1VRZEhabXNGbVlsOTdzYytWWFB2dno2WXli?=
 =?utf-8?B?d1g2S2lmMkx5TDV5R1NsYjB3SFJTSFU2d08ramtvNDFrdjdIZXpScjNFWDNC?=
 =?utf-8?Q?3EAvBZ9L7ksgTw9yQCD69G/3Y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+Gvhvxu1GajXB79YXjgsBA0oNslL3xJe1s//xtTmgUZQBz+IatIa2X3bEd1yik+Ykpn4JgtFbGRcuMJRwiSpI9mmTxR8+Mh9dCP5vZ9ZhjWkgZDXoco1UN+d6cQoWDke4kVRGbPnXpEXsz3i7O8BfYzjq2PZLqfaKjAHFdKIv/6Om7s3NQzcI5F1maTi/45CT7wgNqXiTosuO0gCsR8KcIRSmcZq2ay5iAadB6tLBJb/vJZxQyENF8gSulWecWYly101eivXNT633136DDlKEe2rT4FCQGCbCQv+rqrGkwWU2W7GdjliNOIjkJB/LBMfhHiM16IXSYAI/vi2KgkpxX/mAs80x8kIhzBb1VrL1/h5R+h8azxg1Uz8HRo7zbZDch3SyVfX5DnWm2O8PoVeQ79nnheRXghrUTlddeolr7w0zbsLwuOzar/6/qBVKMGK81SIWwDCwnIadm+qXMe9lIeo/IPPqtqM7p+tKKx98/wItbJknTj8nuX0/HdyF5Akebzwu64CV9zKpSxXr6090QwMSSaa/Ly++aVUfyvDj+xLjAJu+eEvFr/glskj+thmDQylsAzumcd8HTFmAuMPSbs/XA0hy+FuRvv4XlAuX+M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487ce454-4c5c-4b6f-18b1-08dda6a532f5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 15:57:41.2868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4kzAf7s/sQQnbUWjA1EFK7111FLi5HFjpSu1gtyKw2J4fwjRapc00SmG8A5SzjsUlBnk1ylEEA/0YB1jZfCLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506080127
X-Proofpoint-GUID: umY90tzqfwIQYpAB_ihiWSp4qcD9zAh7
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=6845b2fa b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=67QsEgYgIO4cIHhMYDkA:9 a=QEXdDO2ut3YA:10 a=qefyDnxNsbcA:10 cc=ntf awl=host:13206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA4MDEyNyBTYWx0ZWRfX8ZaWdmAhpgyv C4evPl/VoOPimqgGAezgEzxMmnAodO9LrfkVT3MAoV3WClrhbyS/J5GIhxhOpZhe2IxsTk3oux4 9RDEA1i9xJ7Bd0HTy9JXPA3XLAExBOgJde+a4b3vmhij8/63LwJC+GLpsUjGvzmpBVhilVGIbak
 HcWx1rCGKkRRKCdOE2cfbdwGYdmU6X5cHJ0SRHkjImsf5fvbobn/N7g0zxSwtHkAUaZDmFSHe2w rxb8RP1KUJZgiEUFVfrR78R0LoxzQtAqN+wp43JyIJCJsFRphUXlBArlOWDOqMw0G/yoenaobdw SQzyEjExbl1ebSsMcgnZp8mk2ebvIydIyPqwptBP4edJsvd/ahj0FT795mvdtWopfuzG3YTCFym
 SBpPnVSfQEegtOYGCgPq2WlhD7QsXb53XitCiA9UYKsxxYWdHiKSAITMBJvD/IjiMHyAOO99
X-Proofpoint-ORIG-GUID: umY90tzqfwIQYpAB_ihiWSp4qcD9zAh7

On 6/8/25 9:17 AM, Petro Pavlov wrote:
> Hi,
> 
> Yes, I can share the pynfs test. How can I do that?

The pynfs maintainer is Calum Mackay <calum.mackay@oracle.com>.

Post pynfs patches To: Calum, Cc: linux-nfs@


-- 
Chuck Lever

