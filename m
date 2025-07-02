Return-Path: <linux-nfs+bounces-12856-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7766AF5A4C
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 15:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D551C164836
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F67A277807;
	Wed,  2 Jul 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IzMdMCkh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NmTyhm5F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58807275846
	for <linux-nfs@vger.kernel.org>; Wed,  2 Jul 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464598; cv=fail; b=nn76B5MFKreiKSFdZZbRNmZtBlnRf70E4hw4HOlhxut/aj8G8nWrm575u6Me6kVXse0MKWmw79HaFcCyWd6Cma5GsZ9tAHrNjZ5R3LopjnxUrugTNxBUXGgfEP5kpbF4cPrfvZoH/snhYw89g9uJlQ9jnGWSmDnZbjixESW3ZjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464598; c=relaxed/simple;
	bh=j45VVS1tBvFcSbYeHI+yBpgf+WA7Oxy6Xq1WbmYyL5E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PDEf95UaJPWXOwF1ISLvQ57lN8QuZ6Cw25JHCLplsH47ZR286g3ZEmdFZ/cESGYWEBjgP1Wf5RmbOO0V2j8HqQ8QZwRa2M8Qvj3FnykQZVuWeWp9UWZPJdho3opjrGeWzxdrlv3qprpMOmboe8x78bHz/U7FoNa65xeHPCLxh+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IzMdMCkh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NmTyhm5F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BiwFx020929;
	Wed, 2 Jul 2025 13:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tqdLddBdTPMQt7aM0gldjNCk48rrAWZDb8/Xm+u0GdY=; b=
	IzMdMCkhzsmq7KJdrEjJhEyT7K6uQ9/YbumvF2oCjRaYwmPbHrnuVLR6sC/bkDjl
	9GRbP5NSDVsYNWXWhvmSA6hiOj6lJSWC5Z6cP7hp2mjx+kfvi2uqPtC+nCkTKtc2
	QpEFNJub1nu8WMs3XiiuN6lAIkRp22RE8+/YWhPTh0UU6bNAEQ3eoFikgJnYHvU8
	X6mlpQfITI0oDeRzuTbxEwolnSqsI8PTx/28f7u7thuN7ZNQ241jBmsbm5I1JlhI
	GdpgJo74xgwMHK+7j69SU4EzF7WCX6yOyQL92grt4LG7AgIX5RrlxVvMbG4/BcR5
	9S/iRP6yCWySWBBBpO3n5w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7x8s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:56:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562CJQEn025018;
	Wed, 2 Jul 2025 13:56:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ujghdp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:56:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqD44kyPFX7QFD5YUXAocxcH19wd2W8UVfOArj25WmNv8vSCm25MmtsE/sZVpVIjf0UEWT5hfxwZwYbxEfg6h/kPB1r+/Mj4SZRfOab00Jdeq2IhTJAhZztrfpXUoCCNlCM3avOs5eLHFkNrFhXLWFNksQlTdKDMlQ/Oy9grJB1N6XV72kzfqn3bF5aGY5Gh6D7t3ZV1/THkFuACEpcNb2OcLY2fBvU7NC6QSpM44XU46IW/gsPl7729Gc5RpfmYFGZrGpsJFeuH9OQHNvoSEvKpXJL1p/PfwNlqQSqFsERYMau2C9GyAWVl3mUY3RheSf7lNQNEdf7AosUSRVc3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqdLddBdTPMQt7aM0gldjNCk48rrAWZDb8/Xm+u0GdY=;
 b=i8eLOduN4sdPCZbb5xh+sHUAluCL03WsySP+4PAgb8z1N+bFACrWbAtR/tpyDE15GcmgJ+SQ7cRHox7xwlwPf84aJ8E4IRJZAnKAWYYXKFyNARX9Dgh32JFVmJW1HaUt6lSiEuQWK1WsaEsEvVKNwZY8VaBciG+miZYJIM0YCBQrDmGl1M2cB7xLsEacxCavRy3mjptuwXVmiwf80g6xvGuwCg7zc5hdVfrQXllrTzRGqhli2n7p9PVjxRMiK3c61Vsnf0Wzn+WEtB+5t55f3oX8iqgbm39eKz8MfptZIjE5tXSbT961Zp12S7+fhbvK6n73trPQBizM5fAkcbbjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqdLddBdTPMQt7aM0gldjNCk48rrAWZDb8/Xm+u0GdY=;
 b=NmTyhm5FiC1BALT2nJe9lQcksgtHnVsvmyEJu+wv1uwfGJbUY2XKg5Ode1iaEQ6eGv22DDFDRPHoxux1EtZcArsTEYBu62l+VAE/yhk+ILbxsTvXpW6N8L1Ztir85Pruuv7yRtLZvc1eEPU6ZbBe11Snj025bqN3MGsnwOQi9z8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA4PR10MB8610.namprd10.prod.outlook.com (2603:10b6:208:55f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Wed, 2 Jul
 2025 13:56:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 13:56:18 +0000
Message-ID: <2ed77c1d-787c-4abf-96c2-72821e73d565@oracle.com>
Date: Wed, 2 Jul 2025 09:56:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v2] nfsd: provide locking for v4_end_grace
To: NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jeff Layton <jlayton@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>
References: <175136659151.565058.6474755472267609432@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <175136659151.565058.6474755472267609432@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:610:119::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA4PR10MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa20369-437a-4d98-d641-08ddb9703690
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OHhmRTk0ZDIzQUJPTlo2WTFyWnI1cXhhb2tZY1JhRTBBR0pqT2R5blR5Z1px?=
 =?utf-8?B?aDdjU0VWTUE1RUZuVU9IOW1remc2OEJrTzJTbXJqZGMrcTBHcUxIYzdDanBS?=
 =?utf-8?B?UFFTcVk2UEpLTFFaYnp1STQyamRkWTMyRnVOeXRLTUg0U2hqU0dsUk5LcWwr?=
 =?utf-8?B?OGtPZGg1N1pqV0ZYT2k2WE5QYW1nd3JEZElsZGFGRkY4cnJJQnhhZjlFRHBs?=
 =?utf-8?B?R3ZPUjY0UmJxbG4zM1BOR0lhZituTE9WbzI3N2hXMmNWb1lHWS9KSStLSkxW?=
 =?utf-8?B?MjJsamJlcGpGZHNkdm9MK1p0N3BHQTEyZVBCM3dxNzlEMUVYUWtDVlVYaWNr?=
 =?utf-8?B?T3hLOTREbHpHWEFHbDFVaGhBMm9uSytrVHJBeisrOUs4dk5oMmRZNGFUd2Yr?=
 =?utf-8?B?b3ZibWVoWktlSFJJbkQxYmc3Y2JSNDZZbjY0K0paZWg2cUJ6VWVnc3NJbGJt?=
 =?utf-8?B?UStsN2F3TllzUE1qWWs1NmthZmhadlk5U0NqYXZBM1FTcXFLZHhzKzllVjhB?=
 =?utf-8?B?MkpEZ2RreHRrckt1cEI1aGYxNGJjTGIzREt3RlJCT0F6OXV1SHRoSGN5UGVx?=
 =?utf-8?B?UGJqWFZZMm1HWDVFTG5QTEFqUGxZdTRyV3lUdGs4S3lCWVlicGdXTFJ3TUIz?=
 =?utf-8?B?RmtGTUZoR29pSUxSTnlkQkUzeEp3Y3RBUUJkUmtXVVdMOUdENzM5Wkpvdmgz?=
 =?utf-8?B?RHVEUUR3aDBaTlZBM1pmNnBjTXdUTVNzZ1BUN2p6aE5rd05IdTV4a2NEN0xJ?=
 =?utf-8?B?MjZ3SStFUXJYR015NlkvMVV6NFJvUFM2dndvbHkxRjBlR1o1UGkwbTliMEl5?=
 =?utf-8?B?Nk5vSENhaS9LSkFnbFZyUElwK2ZVb2NlWmplSnhPdWNMMGVhM052cjBYOC9T?=
 =?utf-8?B?eWJvTXJHaUlpU0lFOUthUGRFREFHcXZnQzlBaURHRjBPcWlGYW14aWlDbnZL?=
 =?utf-8?B?ZmozODliRmRlbmh6bGVRR3dWaXgzMUJOUzRjOUpCODNlNk5YOEkyb3FIbW5R?=
 =?utf-8?B?Ny9LdXkwbW90OHRnbSsweG4yNkR6OFJKUDdndUNzYzBLaUR6UGU3OHk2VW1x?=
 =?utf-8?B?eHUzVENvSWhLUlZsNE5OY3V2L3NQdXVTanpaeXZIVStqSTZCU3JSZEltaUJk?=
 =?utf-8?B?Z1JRWTZXaWEzeDd1QzdFQ1VsMUVsMjlMUG0yMlY3MHdYTWQwQlZqemQ5Y0Np?=
 =?utf-8?B?RFRPL2MyL1d4Q2VwWWtaU1RUaDdXZUtHc0ZrYTJ1cmk4Ym9yT2RmblRjaTFo?=
 =?utf-8?B?ZlVkWGovSjBseUhicnllWGVwbE5XNjMvNWd1dEFaUTFJY1l6cVBtSDdQTEZs?=
 =?utf-8?B?aVhRSEh2dHNSZzAwVDQyeExwVkxMUlVQenM4eGJrcGt4VlZ0T2xueEMzL3VK?=
 =?utf-8?B?RWtWZVJaUEVDYjM5ZXR3cEJtVmJUS2MrWnVKaGZHNER6a1BWaUlaYWVyaG9Q?=
 =?utf-8?B?U3B5d0V4U2Rqdkg3Qm5TZTRxMzhDVUdvNnFIcDdzeFdBUUNmV1ZyR0xhbzds?=
 =?utf-8?B?Y3kvbzE5U1ZucUhDUzQydmtkcXI0MndnMFJteEpRMFk4VTlUZ3pmdFd3cFpI?=
 =?utf-8?B?bEUwc0h5RytIdytKdktpamZMOEZPZ3NBOVVmeVNZTk1uWmdJZ0dPT3hEcXFG?=
 =?utf-8?B?UGErY2UrSStXekZGN1NOb1BWckpZT1ZNZjZDaGRLZXNTMU1jY3ExdFFZaVdG?=
 =?utf-8?B?dmhNbklESXUxRTJETHpOemc0Q0N2bThrdXFEU0V1L2hVZTcxN25lTjlxU0RU?=
 =?utf-8?B?UDR4dSthWE1ZcERiQVJVZ2V6MEptTWFaM2VpamRoWklVSC9VOWkxNWhRbStZ?=
 =?utf-8?Q?AKET4JwzadT7jpicjah2TXr0RNIsyu0gvroLg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aXFXbUxTeWNSd096N1lJS0tWdVBabzVjQzdIYTRDaU1Fdi9MbkExU3NsTzlF?=
 =?utf-8?B?T1FONzh0cE1Sakg1TFFXK1laQmNSRGkyaWxwdHl0MHJSeXRTNHZERGI2WWZv?=
 =?utf-8?B?ZUpGUW13SkFSRGEwbXU1NkNpaDFlREVBbVpSQ2dmaS9mZThJM2tvQndqbExt?=
 =?utf-8?B?djRJdTNPZHF2U08vUVRJdlFjaFUza2twL2FvK3hjZDdib1ZEeDJkWkxlTXlr?=
 =?utf-8?B?WmRsbFIzcVpWSzREOVZHM0lZeGllZldZbG9GQnlyQkdMdWtvNE02QjBJd2Fi?=
 =?utf-8?B?WCtQZ29nZm5qVmZjU05QMUpZcElqaHkxdTZ0VHRESDFtREJNT3p3SXZTUWpT?=
 =?utf-8?B?TGNUTTB0T21NTjllMkpiRTdDU0dXQ3IzZzkxN0R2eExaMm5Wd3k4Wnl1aHd4?=
 =?utf-8?B?M2RTVmQ5VXJDR0JueUdudmxHQ0NIby9lbjdzWUxCVE91djlJdlJIbGJhak5t?=
 =?utf-8?B?cTFsME1UWHNmWVQ4MkRlanAzalY3R1U5YjIwK2d4a2lYamNrWUFodUo0UDIr?=
 =?utf-8?B?QmNta2JmdkpzRWYybFRvbFdJRzRLK2tuaE94WVBZaElvMmM5UnZkQ3FiQnZu?=
 =?utf-8?B?cUMyaXJkVjFCV296SFRVZjhJaDd1OVFPNUlBVDVaNk5OWTNLenJodDJSaHBM?=
 =?utf-8?B?SzlVbjc1TmkrMUpxRk0yTWovS1dabDlrcXkyWVFYaUtuWG1VcVVXSVVDejRx?=
 =?utf-8?B?dUVvSGtYZVQ1RHRhMlZGZlVOTThCSkVLRWlPcVJvS0ZwUmhmcXY3SzhVRVBE?=
 =?utf-8?B?YUNKSnZWM0FmbU1TamlKN0Z0VUs4Y0RBYnNZWlZ4S3cvd2VRQlY4QytYSVpE?=
 =?utf-8?B?dnkrT2h2MFRZZERtYTZkVTNzRG4rTXBnVzZ5Vy9XcEdoeGxRb0RJcDhUaHY5?=
 =?utf-8?B?TjJnQURhUFpsejNzeklHU1NPRW55bTVjNlN4MVFlMEw0dEZoRWx4SGNUbDls?=
 =?utf-8?B?T0pBT3lUOTNyRm8rUXJWTGNTUmZURFNER0hyTzY4dXJSeFJGNHdGeDFHek5v?=
 =?utf-8?B?T1FwWmczMWRxbzF0ZVMyZTY3d2pJSzBhTlJ6WDR5NGtVblFLMGk3SWh3WGJv?=
 =?utf-8?B?L3o3TmM3RFN1NlNIcE0xMHpmeVZKbFNzQnV1L1c2aHVEbi8raXUrTm9UeFZ1?=
 =?utf-8?B?Y2ZudnBnVVZnakJ2dGFvSUNydXFGSTZreVNvbnAyczgyUWltOGxIb2JGTE9X?=
 =?utf-8?B?UmVaeEZyK0psWFJxS3kyRjZ6T3FGV1NYbmtsa2FmVXdDOVZ1NllMWlA1cE5X?=
 =?utf-8?B?V3ZJbUNkSzlHZWEwbVdHZVByZHpBWHBNdkIzZDg3bFVEcDREL281ejJRN2ZP?=
 =?utf-8?B?S1FDeml5ZlBSUjJRTTFOa2lXSHpTNHRUQngwY3YrbXROVERPYy9POFN0ZGdT?=
 =?utf-8?B?VlVkaGVUcWxsNzJicHBaL0xHQzBTakt2dHorbG1mLytaTVd4YmhlNnF5VXdi?=
 =?utf-8?B?WDJxajV6QkZCYUFGMHk0dFNIT3BERjIrdm96SVF2RFJpRkFmU3JzT3kwMnVY?=
 =?utf-8?B?YmdwdThZVlo5czNHM2FhL0pDKzFhYmkwTEdqN2ZobXJtVlcvd09VUUZ6b09P?=
 =?utf-8?B?WE9PVG1NS3dWWmI5MjUwanZ1T29nZUJMK3ZtMU9uMXpSRDVoZ1d2ZFVRaHBX?=
 =?utf-8?B?VjBzU2sxMjl0Vm1jV0hmY2Q0dXhnWjI1UkNIQmNCVGhZQ3k5QTlCdlN4MzY5?=
 =?utf-8?B?TnhLVVRvcVZWaVdrWGxDOHBPb0hKQ1p5Zk03N0FXVUtXZUs2RS8vM1Q1Z0dK?=
 =?utf-8?B?RXhaZGNwOGhJb2dOalJrSWZSS1pZalZsUksrV0ZIZzlDMW02dEVUSGE4dmIv?=
 =?utf-8?B?V0ZFeEo5K1VmTVdITWU0NmYzUnJHLzg5dHZZU2VBdkZMTUF1ZkdTSmIrOXhv?=
 =?utf-8?B?TXFrTm81ZnhsNkloUTlza2UyTG5vWlNBQzBPTGx5QldwN04zZHdJajV5OGRB?=
 =?utf-8?B?aWRsS3lZR2JOZlRPQ1JMSE9vZy9ubFlwVFErNVlvMDFHRW9hTXpYa0Y3MjVu?=
 =?utf-8?B?UGtXNUVFY0ZWQ0syQlpBREM3Nk1FYnAySzE1LzM3MndpUXNwY1IxY2pGcVpt?=
 =?utf-8?B?cnZiU0dOelhmK2pOL1JrNWxRRVgxSGVHdXVHNXR2bUI5bkRaT3FWZzZDT2Yy?=
 =?utf-8?Q?WXg7IZm3XxAo24h6SiD/bjTvQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4MLvkbx79QIxTAOBLdMOUGZSS+MslH4K+Lv6SchOZGehtG3nL0qIzIlshKleF6fybcFxg/lgBpakCdzinGRV+XvyfbVIRvrCNTroHNDmPbXb/7gLDqNYMCgLOZhv4GH7NhmO4BHr7LjGYSO9xxB2ik/MJD9qYelP/nu88wpBUEjBa61gGiyfm6iSfKy/wupvhnosBUvVCbPJNJEYLU4A2sJJm0xvHc5wV7whkfbX2rsI5CCCCx2DhwoRTX/mfS0+U5mu+icGul6gjvTkEqP1c6m3bGCNej3xZ8Pd7r8Gbf3YyXcrIFXLWpv5fxgMhkk8DVAws/SYi8gNekSrFYFr8zVw6iVcaGBZJuGUTyFqI0tMI1mjt4YUQ7DEEvaYiYfX+cpKv9h8g1qOK8AcU/KBUP4N9gOjD3DwXAJELl4O74bJZEpJMR+2GpdZ9OVsjlA+sSDkn6V8zkvfV6yNGinTBuX4e8PttgkVpA892aQsSpmM6yqT6A41e+d1FF1dc21FLR9WYbHw/5gfqID2HpzKN1Srgp8ClZxyelidrTjFwoVEysrzLC3tJaTD8bK1bLz0SGwp9pi4qDaRScp/hZA8avXRHdrMIyCZPKUk4k1cifI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa20369-437a-4d98-d641-08ddb9703690
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 13:56:18.7451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hptcGtf9sY4tB65dUp8x/1mDMzeGitp0egV6cyzk50Daqm0aWJzAXhMM2ZbS4NeqQyZMP2L+FpTLutnc4V/Low==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDExNCBTYWx0ZWRfX9zNV0twWAQMv tOP2KlFCkV+9FvmWPTOAs35PM43iZy0gynjXvQdM+UbjTTRzTcflfxLzBWFR8KpQUuZlM1STm/v +dwDbgoZMVvNWNKGcbV2IOuaqOPYz2KZ7pkhhd02ZmkSWU1wBhIHpIQnUM6+Zgsm3GT4EJkbwvx
 06rox2nn6LZrT53vWMy0JkZN32HgJe9eQ4mSCQ3DKm+H/AiwCCVf9WN4V7nmc6FWIDCwxNOwzqB x2RuQthCnmN1cxpb5ifbstP4XnnNmAe0TNkJ9VHTHUisS9c2wfZ371X8gTcRTsF4GIBjcdT/Uaq x6uP41lKQQa29H2hQekEPOq/IrOIGFeqQghhvFv7YOgGMpUTXVwAmbCHOU0FwU76qYTHzHdEr7/
 /E8wSYB7t8wsQEu3gTTaLLq1+P/7j8soqSNhyZ5ffhSZS7RmOL0EyzzjaqdWj/n7X2u8wRT2
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=68653a87 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=Iz8s3-kxOk5f8YTFWJQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13215
X-Proofpoint-ORIG-GUID: x7dJToQrktMSVx6K3kEl3GT3DB4ZH44M
X-Proofpoint-GUID: x7dJToQrktMSVx6K3kEl3GT3DB4ZH44M

Hi Neil, handful of nits below.


On 7/1/25 6:43 AM, NeilBrown wrote:
> 
> Writing to v4_end_grace can race with server shutdown and result in
> memory being accessed after it was freed - reclaim_str_hashtbl in
> particularly.
> 
> We cannot hold nfsd_mutex across the nfsd4_end_grace() call as that is
> held while client_tracking_ops->init() is called and that can wait for
> an upcall to nfsdcltrack which can write to v4_end_grace, resulting in a
> deadlock.
> 
> nfsd4_end_grace() is also called by the landromat work queue and this
> doesn't require locking as server shutdown will stop the work and wait
> for it before freeing anything that nfsd4_end_grace() might access.
> 
> However, we must be sure that writing to v4_end_grace doesn't restart
> the work item before init has completed or after shutdown has already
> waited for it.  For this we can use disable_delayed_work() after
> INIT_DELAYED_WORK(), and disable_delayed_work_sync() instead of
> cancel_delayed_work_sync().
> 
> So this patch adds a nfsd_net field "grace_end_forced", sets that when
> v4_end_grace is written, and schedules the laundromat (providing it
> hasn't been disabled).  This field bypasses other checks for whether the
> grace period has finished.  The delayed work is disabled while
> nfsd4_client_tracking_init() is running and before
> nfsd4_client_tracking_exit() is call to shutdown client tracking.
> 
> This resolves a race which can result in use-after-free.
> 
> Note that disable_delayed_work_sync() was added in v6.10.  To backport
> to an earlier kernel without that interface the exclusion could be
> provided by a spinlock and a flag in nn. The flag would be set when
> the delayed_work is enabled and cleared when it is disabled.  The
> spinlock would be used to ensure nfsd4_force_end_grace() only queues the
> work while the flag is set.
> 
> [[ 
>  v2 - disable laundromat_work while _init is running as well as while
>  _exit is running.  Don't depend on ->nfsd_serv, test
>  ->client_tracking_ops instead.
> ]]

Do you want the patch change history to appear in the commit log?
Asking because that is not usual practice.


> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>

Closes:
https://lore.kernel.org/linux-nfs/20250623030015.2353515-1-neil@brown.name/T/#t

Fixes: 7f5ef2e900d9 ("nfsd: add a v4_end_grace file to /proc/fs/nfsd")


> Cc: stable@vger.kernel.org
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/netns.h     |  1 +
>  fs/nfsd/nfs4state.c | 27 ++++++++++++++++++++++++---
>  fs/nfsd/nfsctl.c    |  6 +++---
>  fs/nfsd/state.h     |  2 +-
>  4 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 3e2d0fde80a7..d83c68872c4c 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -66,6 +66,7 @@ struct nfsd_net {
>  
>  	struct lock_manager nfsd4_manager;
>  	bool grace_ended;
> +	bool grace_end_forced;
>  	time64_t boot_time;
>  
>  	struct dentry *nfsd_client_dir;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d5694987f86f..857606035f94 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -84,7 +84,7 @@ static u64 current_sessionid = 1;
>  /* forward declarations */
>  static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
>  static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
> -void nfsd4_end_grace(struct nfsd_net *nn);
> +static void nfsd4_end_grace(struct nfsd_net *nn);
>  static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
>  static void nfsd4_file_hash_remove(struct nfs4_file *fi);
>  static void deleg_reaper(struct nfsd_net *nn);
> @@ -6458,7 +6458,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	return nfs_ok;
>  }
>  
> -void
> +static void
>  nfsd4_end_grace(struct nfsd_net *nn)
>  {
>  	/* do nothing if grace period already ended */
> @@ -6491,6 +6491,20 @@ nfsd4_end_grace(struct nfsd_net *nn)
>  	 */
>  }

Can you add a kdoc comment for nfsd4_force_end_grace() ?


> +bool
> +nfsd4_force_end_grace(struct nfsd_net *nn)
> +{
> +	if (!nn->client_tracking_ops)
> +		return false;
> +	/* laundromat_work must be initialised now, though it might be disabled */
> +	nn->grace_end_forced = true;
> +	/* This is a no-op after nfs4_state_shutdown_net() has called
> +	 * disable_delayed_work_sync()
> +	 */
> +	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +	return true;
> +}
> +
>  /*
>   * If we've waited a lease period but there are still clients trying to
>   * reclaim, wait a little longer to give them a chance to finish.
> @@ -6500,6 +6514,8 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
>  	time64_t double_grace_period_end = nn->boot_time +
>  					   2 * nn->nfsd4_lease;
>  
> +	if (nn->grace_end_forced)
> +		return false;
>  	if (nn->track_reclaim_completes &&
>  			atomic_read(&nn->nr_reclaim_complete) ==
>  			nn->reclaim_str_hashtbl_size)
> @@ -8807,6 +8823,7 @@ static int nfs4_state_create_net(struct net *net)
>  	nn->unconf_name_tree = RB_ROOT;
>  	nn->boot_time = ktime_get_real_seconds();
>  	nn->grace_ended = false;
> +	nn->grace_end_forced = false;
>  	nn->nfsd4_manager.block_opens = true;
>  	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
>  	INIT_LIST_HEAD(&nn->client_lru);
> @@ -8821,6 +8838,8 @@ static int nfs4_state_create_net(struct net *net)
>  	INIT_LIST_HEAD(&nn->blocked_locks_lru);
>  
>  	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
> +	/* Make sure his cannot run until client tracking is initialised */
> +	disable_delayed_work(&nn->laundromat_work);
>  	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
>  	get_net(net);
>  
> @@ -8887,6 +8906,8 @@ nfs4_state_start_net(struct net *net)
>  		return ret;
>  	locks_start_grace(net, &nn->nfsd4_manager);
>  	nfsd4_client_tracking_init(net);
> +	/* safe for laundromat to run now */
> +	enable_delayed_work(&nn->laundromat_work);
>  	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
>  		goto skip_grace;
>  	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
> @@ -8935,7 +8956,7 @@ nfs4_state_shutdown_net(struct net *net)
>  
>  	shrinker_free(nn->nfsd_client_shrinker);
>  	cancel_work_sync(&nn->nfsd_shrinker_work);
> -	cancel_delayed_work_sync(&nn->laundromat_work);
> +	disable_delayed_work_sync(&nn->laundromat_work);
>  	locks_end_grace(&nn->nfsd4_manager);
>  
>  	INIT_LIST_HEAD(&reaplist);
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 3f3e9f6c4250..658f3f86a59f 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1082,10 +1082,10 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
>  		case 'Y':
>  		case 'y':
>  		case '1':
> -			if (!nn->nfsd_serv)
> -				return -EBUSY;
>  			trace_nfsd_end_grace(netns(file));
> -			nfsd4_end_grace(nn);
> +			if (!nfsd4_force_end_grace(nn))
> +				return -EBUSY;
> +
>  			break;
>  		default:
>  			return -EINVAL;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 1995bca158b8..05eabc69de40 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -836,7 +836,7 @@ static inline void nfsd4_revoke_states(struct net *net, struct super_block *sb)
>  #endif
>  
>  /* grace period management */
> -void nfsd4_end_grace(struct nfsd_net *nn);
> +bool nfsd4_force_end_grace(struct nfsd_net *nn);
>  
>  /* nfs4recover operations */
>  extern int nfsd4_client_tracking_init(struct net *net);


-- 
Chuck Lever

