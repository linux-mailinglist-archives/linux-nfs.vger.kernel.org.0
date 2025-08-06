Return-Path: <linux-nfs+bounces-13463-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E58B1C710
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 15:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126C51891D06
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09928C844;
	Wed,  6 Aug 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fUdtvHn0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SDzA90yL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879DD28C5CC
	for <linux-nfs@vger.kernel.org>; Wed,  6 Aug 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488412; cv=fail; b=iCNuRDDHhfR/YLDyp0vtN9jld/RJ/7v+Ip8JBC3wp8r2uYpWZ8+RbDda3Im4vLxNzy+0JGqTDYHOzommp91TzvrH1PdMGT8A1iUy9549CUBtYvm62N58HbmBsY0YXmaCJe4mJZmjQo9Lbo0JatXGdjTz/YNN42vp76bu2gdHa44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488412; c=relaxed/simple;
	bh=bczMPnGpGlzJ8ezCnOuZk8r1z5HUg4u6mi/M5PztzmY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnvhpikH6Udykf2unGxUd57MoTo9x1FO0rfJd/9eAlK+axRL5QdRXwXMdkl+BUuhIixDOWqTotVHeWr3UBf0HbjrDjDiSK9WWWJFqfdeg2mIJyT5uf/+1Z7i8kScHESlQdx/9xeP6yMIJCF1QXl4hNxGq3GmNxGTMMKkr5Tjl3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fUdtvHn0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SDzA90yL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576CRZJ8000787;
	Wed, 6 Aug 2025 13:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JE6vNA4VH7cltHJQrlEMGmVDeFlhInNKtsElcccHzps=; b=
	fUdtvHn0HtSDe6IOk9xJhiBuzfFz5mZBqpeBUMiA9Q2GRRpKXOr1+3MzZXmmd23H
	dXlRn7poKQTxcZVP/fWycfev1GJ8LgtdtKrQnybl8rM+wEFkLdrKKDENCVjePBnC
	tIy6QBHXyeeNuq2fZZIhsdAq7QMMzgLeJ9vNvlc2kDi09MwyWpLytHT9q0WhQQjL
	c5cF8ihGe6yADn7PhkxdAIkaBIynNNVXob+q1N2wyM0izqDoA+Wh+Z9hejIYkLeW
	XO3BJpU2VPn1nlBTy3Hl4MibiVKivJ4uiTgbSHQdm6c+GuZzEzMcxjeydIwtRN43
	LrLZS25YY7Dx5CNQW52IFQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvgspqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 13:53:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 576CfWI8005801;
	Wed, 6 Aug 2025 13:53:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwx2pfu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 13:53:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciO36NRqUpeXoGlhQN0ajxJqgRelwNZnICExRExlTi2U3ndZVErAF2iaDd6jsmlrygU+NVJSaBSEQylEl10GVcWz4Q2eV8WiP68LO/n2WPA9EFu0FqmzijdAcqM6UDSUiSGGjx97OvRxuWdmhfXv8K9hrA3UsxCTy50HOykF+U17Mgd0PmJ9soVZuzErvsP/vDeM9toSCFhpQhQGN+ZbtxD9nPFES6rThkNW7Yh6R65+IHu4Gtvy6085Rqk2N5GXpkrESexSFbydKEABrFNBb1FmKdFQ0F2y7af7E0hHiZVWSel1sB5hXxX4NbNuHuyy3+Bvt0AAXClg6ryuE7tNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JE6vNA4VH7cltHJQrlEMGmVDeFlhInNKtsElcccHzps=;
 b=vfJDsL8aDPbYcmAp5aE5iz/v31Xnz136PFiWZMhiJFWg7aW6kckFnyU3NbwphbegW4jFhw0FwVI1N6CHfPgin1mnpM1vE6B5eDjZSAAEbXr2QVp1czcr69yMGOhsKFhl5vKiTIF3eeoKZBq8lk5tLuHU2jHKeM/zA1+bKbkpi+qvsfSLMmU+rSHCNjGLD+HQ5QD5psGQiCMUjU1ipTuTEOQAx0jM9UvyFGhEEBFvLHLCNGu+JbObjqrsuIsFgy8O+OPFZTHYrr4RQ0+61fiQ2O8RHYetTcB1iRFJGJFBADjHnJXsNrg4MReJGOIuMuMyS6zi/Xn256LXgompZicEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE6vNA4VH7cltHJQrlEMGmVDeFlhInNKtsElcccHzps=;
 b=SDzA90yLAc3ryeBq52mzuC0SL4sqEK9kHz8YCWscaq1dbUcTaBZbEQRFbJCO2y8YMq1fKtZ7dRm81XcaGI6rYBVjhigHuzJnE1Fs5+fspBQBgumXCQCeJg2unmX4awZiMaiK0geo8LmafaRGYl+SAHwlgaXAs2dOW5GIrKSi9wg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6835.namprd10.prod.outlook.com (2603:10b6:610:152::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 13:53:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8989.017; Wed, 6 Aug 2025
 13:53:11 +0000
Message-ID: <6d862893-ac75-4727-a5a2-abfff55b9836@oracle.com>
Date: Wed, 6 Aug 2025 09:53:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] NFSD: issue WRITEs using O_DIRECT even if IO is
 misaligned
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20250805184428.5848-1-snitzer@kernel.org>
 <20250805184428.5848-5-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250805184428.5848-5-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: b633ce91-9ca4-47e5-00a7-08ddd4f09506
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Nk9IaDQzQnBtaXRlQ3laK0R4NCtsT2Ztc1lBcy9UMVNlT3dFTHprSkRjUGJi?=
 =?utf-8?B?bHh4dU56clh6SUtka2xYTHVucDRDTzd4ZjBvM1E5eTZybkRPSnd2NWVoZGNK?=
 =?utf-8?B?UUkxTzlqZTFNNDVXbnlZTmlJL2s4aUlxVWFLdUNoejM4R1I0MWNBQ0ltNWJI?=
 =?utf-8?B?S2dHQkRMVmhoVnBPWDNPT0lLQmpmejZOY3lLQ0VESi95NTRBcTA1TVdmUGRJ?=
 =?utf-8?B?Rkk5cUcyaGhxZzVjbGdKdEJEOVUrQUlMWGk2NU5VRFdGakg1RXE5YVJTajFF?=
 =?utf-8?B?aEZHTENtM0hxN0VyaTc5U3BHUkRNR2kwRjRaK2w3V1lPdjYwbDBSbDVJVUZm?=
 =?utf-8?B?cytHWmd5bm01MEtDS3BUeCt5cGE1dGFlc0tRRS9yMnZJK3grb29mc2JmbWxp?=
 =?utf-8?B?OTBQR3M2dnBIVFRhS28wWHR5aGJMYUZJTTVEblRGaXNaMnkvVVhFdncyNDk3?=
 =?utf-8?B?bzA2TVFiMGZ4YTZPWUFiYzNtVVFCb1Zmb05vNVE2RUlvL3FrSVAza3dwWTR3?=
 =?utf-8?B?M1hXQWtnYm50NW9qcWIyRjJubXRZdjZSSThhQ0JLS01RSTI4ZnF1dk93NzBh?=
 =?utf-8?B?eFdDY1RYMkdOYmNTWG1VcmJnVTRzRGZvc1N2Tyt5VlduZ0o4SlBGSjBvSTFF?=
 =?utf-8?B?eXJudkV6cTU3ZlVYUnppbThZTUtLTC9DWm9KZUxpOGJCMTdUNjA3YkVyelQ3?=
 =?utf-8?B?eTR3UTU0bUZIOENPY0NQd1owNm90eEtLNlVCOXNFaEFNQVJsa1RIdHJtU3hO?=
 =?utf-8?B?S2ZqR2Z5d1FFemdOUUVwUzZocWx2VG5XUmtXV1RPRnMwb1c2ZHF1WnF2M3NG?=
 =?utf-8?B?a2o3K2drdlRXeTlXTVNONjZhQnhGWlNNZ0ZKWE1JcEgydGRRZURkSU5xaE1L?=
 =?utf-8?B?OHREU2Nha3lBczRKakt6NkNCOU1UNU5lbVF6azFzUTdVMURFVlhvellOTU5B?=
 =?utf-8?B?M2tjUThYSlB4RXEvRHZidkhSa1BXK3pTQ01oa0FvNUthTmM0YWNXSmNxb0o1?=
 =?utf-8?B?cVZidmtsRFBZRHIwempYRFp1ZXVidlpzUjk1YnlRTXdleE84aTQrcmhuV1k1?=
 =?utf-8?B?S2JRL3V6K1RvZURiR1cxU1g2NURRbkhUR3BCSU5BbjJLNys4cTY4dTN6Sjls?=
 =?utf-8?B?OE83dDM0bkx1cmg5OWUyTUYvUFFYemVoLzZVd3BOMlVHV2lQWGNzeFd4ZTcr?=
 =?utf-8?B?dE0rRW82ZTN1VFdqMTg2cWNmbDE3ZHhwSzlPNW82UUYyalRnNHJ5MmZEY0M0?=
 =?utf-8?B?K2N0MlQ0N1cyeklvTWF4ZWhnTG52TGRDVlBkMVpBRHZTWFlvV3R3ME9zOEM5?=
 =?utf-8?B?VzYwb21ka3h5empyU1hSb1Bta0pBSm9McmFqaUZEUzExallGVHVxSENoY1ZJ?=
 =?utf-8?B?azQ5a3dGTzl1UHZhWXpMbmFnZVZrc3FnMUsybW5jVmlVQUJZWnhlT04yc2pG?=
 =?utf-8?B?cHVYQmdleDNFVjRWQm5YVVFWVXlZNmlycnJkN3ljcld5c1dDSnIreHFCUjV2?=
 =?utf-8?B?aWgxUVZQWXh3MUpwcElubDdnTG9yekVrRXhiNnFyNXZnbE56ZmNEZWpRQXVh?=
 =?utf-8?B?aldRSVlrY3NBY3VTaktlY1VpSGtQU1ZIc1dSNzdWY1BVaGJVRkNVeDVmZGJC?=
 =?utf-8?B?VlYxaW11Q3ZSVmZ1OTNmMlF4T1paRVVWUnBjU0g3WHEvRU52U0l1Tm9JMVU5?=
 =?utf-8?B?SDk0Wld5TWpiMzNoL3VLR3NPNzlucVJDcFRnN0ZhWGZhamx0N29hWU8wME5Y?=
 =?utf-8?B?am5yc0ZaYlZ2cXFTZ1c2dmdQRmMwU1JPSk4rTzluOHdFRmRDbXFkUmNodXBz?=
 =?utf-8?B?a3FtTDRJQ3lGRWl2cUY0NGRhWjZESXo3am5TQnJGWHkwV0xaMGl0aHgyR2s0?=
 =?utf-8?B?VVRxdGlTWmVod0RMaTcrZDJHeUg3cm9wa0ZpdkFyU2lOaWVTSlUyZkZMR05W?=
 =?utf-8?Q?Vz95T7kdZ6c=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NGx4UXdxZDBWeWJMNmQzcDhrakZsNSsrRXRTTC9sL1VjbS9XL0U0Y3dRMDk5?=
 =?utf-8?B?ZHlabHplNU5oL2I3WHduZVh4Ym4yK0Q1azRPMnJqTjdmMWVTMWhkaU8yaGYr?=
 =?utf-8?B?RUcvMDN1MlRlNkJ0NHJGVDg3a0tZTEtvd2p3eHR0WTFsckxxSjB3akVOZk5E?=
 =?utf-8?B?a0xHaGJ1OHFsKzZ5aE9pM3ZyeXJmMjVreXlJTGlDQjhSUml6UjZoajY0S201?=
 =?utf-8?B?ejdWRmRJci9PcmtiazZrdk5tckE4Z2dZYVVsL2FwMWk5bG9zZmZ6T0lQZTJ4?=
 =?utf-8?B?b0dlRGlGK21yK3MwUEZkTHBmV2NkTmJkd2g4QnBKZGtkK3k1RVZWMm5hc0Ux?=
 =?utf-8?B?MDU5ZWlwQ2t4UFpoK2VpZVowcWVzYjZuN2FHekNGMzMyQTB1ejBkSHZXRjhv?=
 =?utf-8?B?MlRjZW9YZ3NRZ0kxZ2xubmRPWWlkWWp2V2duL2c0eTJaU1BINzNFeUY1TDB0?=
 =?utf-8?B?ODY0bTZHdGVJdTRWMU1TRU54bUo1Z1hQa2h6YlA5UDYrcVk3M1lGbGE1TFBR?=
 =?utf-8?B?aW5GeFFqSnVXV1V5cmprWEtRVSs0QzZ5MGNBU2o1QVhFYTdHZ3R5NVJxTCtN?=
 =?utf-8?B?anhDKy8xUmNlQ2x3RFd4ZlNObWUyclI2clJFYzAvbjlFZ2g5MzVxa29iR0ZZ?=
 =?utf-8?B?U1JzWE9pK2xtYUtRaHVQTGdnd0g0NllEV0gzVmt2bjdjeTRQSldoYm1MeEkz?=
 =?utf-8?B?WmxlL0J3TlZFSFI3ekZFTkpJUXp6YU1xaGxHd0dkY0JnbHMwZ1I4NkFFSkNz?=
 =?utf-8?B?d0w5TllmaWprNmlOWmZlM3Q3K0ZobkdlMU9Yc3BkSVNLR2V0TlAxNkRydWt4?=
 =?utf-8?B?R3pqdlpxMHFGSDh4S0FBY2JMaUhpZU8vcjRsTXZacjlKeVlNYm16QUEvSVc0?=
 =?utf-8?B?NDA0Sks2YzNmaVRZTTV5OERHaUk2MjMrTFdNSllFWTlDeHF4ZitxaTk0Ym9K?=
 =?utf-8?B?NmlVWHNvS2tDUDhST3JycmZodTBFLzEyK0wreHpseVhGL0ptMU1hUldaRDQr?=
 =?utf-8?B?Mm5ZMFpFOHZrZkZuSEtEZE52SWhnS2c5VndraFh5d3RZNGJhdWhVZUNMMnJ2?=
 =?utf-8?B?Vk5MMEI0bHRHaGpYSy9NUWdveFl3bnFFRHRwRWlnWWgrdktsM2tFYmVlbUpT?=
 =?utf-8?B?WmQxWTkzVWl3ZDhwbk5tU0c4ZFBlR0o3dXphUGRTQ1dla1JRTC9XcGNvb29k?=
 =?utf-8?B?VDhhNDdPekxiZ0F0RkM4dVl2YUVyNDBHNjU1Q3MxOUdRRWEyYkVWaUhxNS9X?=
 =?utf-8?B?T3JnaktRMGRLcndIcmt2eERkZ3dmMWE1T3VkYjFZdVVLcmN4TXVpaDhpalFU?=
 =?utf-8?B?S1hzdThnRzN4Z0JnTnFUZmhwSUExeDFna0FvNlNWaHZpb2MwOVh3Z29FRXJr?=
 =?utf-8?B?cXR1RWtXVmVES3Y2ZEc2TzE2U0NtM3B6RFNXcU1EVFFQN0JhYnVlc1RUMzRu?=
 =?utf-8?B?L3JDcGR1RlExbTh3RnpuOWVOTFRMWURlL0dDMGR4ejhVZUZrU2NRT2R0eWgv?=
 =?utf-8?B?bVZobnp1Q3JPcVlPNHZPQTVFWUxsY1BLWXBPdFhwaFRuU1NOSExlamNodEI0?=
 =?utf-8?B?Zndnc0szODJDd24wakN2dzR3RW5sMGN2bHRILzN0WVpxTTNrUkpqMFN5THIv?=
 =?utf-8?B?TGovQWNnT0JEc2pjUUYzb2k2aEhiNUc3MEhYOVdhRUxSUU5HbVRHeHd3emYw?=
 =?utf-8?B?VTlxNWNuc1Q5QnFhTG9RMVVRRGViVnBVVEtQcFNPREI1MEgxMTVabHQxOS83?=
 =?utf-8?B?cDB1djZPSEFSdXVJMWpEbFRFdkg1THpxeU9lcmRrYnJzWVhBUHVYOHRoMmxW?=
 =?utf-8?B?MktMWi9yb0NnOVJKSXhkQTZNVncvSXZhc0g5dThsMG1rWmoyd2tGOEl1NXMz?=
 =?utf-8?B?V1VYZ1ZMb2VXL0NZTlJOdXNsaEZ3NnJoOHVvSHdaYVFzZm9DSUZPSmRRbW5o?=
 =?utf-8?B?ZWx6cWMxOXhyVXBCc015SUwyNXprSHJSeXZjM0VjTTlSdWZYZ3duOFQ5blhv?=
 =?utf-8?B?S2FHMWVBNG5nekNuamFKOStPZHVpVVZuWFlSZGVibThFU1NGZnViRU4zN3l2?=
 =?utf-8?B?L3Nyb0VkYWpXSFd5TTBSMjVLdnYzNzI3ZE5MT3lSYWZOMmV3ZUR4Rkh3eGpI?=
 =?utf-8?Q?ylOhY6hH1/Q5vrjmz3NmibpMc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wt6kqv8UZmCmxRtxyNJIHi3cS1VB38eWn5LURtqPCf3srFb9uM/WnEYq8j9uPHpOMp3IO6LDHfaqr26G/aqWvJgGeLPeIayI/3EVGQluT7vxl3Q8PWzfIj/AQhy0GZVX+3ngB1yN76WPiknmhbMNnmWkTc3Qr5AiuVvbC8gpzc9ed0FakxV4jds7f8jnU70pcaG/8CuuSrtDil2MX/QaYJ0xdY6T4AOPQC8u3w3O3E1KGd40ML2IgMVSB6WkCU45E9rZx6/MmiNrTvDwdp/ksb24eVSg4G2VK3XXVoKi9yTOHX06tn8SsRxAj10VhOCXJRvz+qbvhICd2lOFYCmOUuPha/oCdBlc1lfUfsvugk8CysC4Lx9fVcr4LLV9IX71scDAEtXP3ElJwcbU2XQNLIPHlfQlnoYHNGAddPNHd9q6PPWyFuNX44UIwnwMZHIFAQluUop67ttYWMmommcgJraQ7Q8WlnX1PMd9xBvbfKoo2pnQfqmUb90LWLUkQvEiWTGpc/QlKooK/vVOX+JxqHN5O7P8bsg7Y/Mfo9lHbTi8WT0K07dvIeRnczadvWyuarz/RlKSf/IV+mmveDrbOTEI8+U7NTuOOOzWpdqtMdI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b633ce91-9ca4-47e5-00a7-08ddd4f09506
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 13:53:11.5285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAmMi0mX2JUJIKor23MzqptTPkr5xba7LSH63fwCj009KfrAgBVLug2Rr7UWeu5YkFQCgx+M8zXzzC5yxECF4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508060087
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=68935e4b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=D7HMJwXG3PX6fdmbhiEA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12065
X-Proofpoint-GUID: k8g9k05GZEHhHOYtVyJ2lCo70V17hDbu
X-Proofpoint-ORIG-GUID: k8g9k05GZEHhHOYtVyJ2lCo70V17hDbu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA4NyBTYWx0ZWRfX90mf11lOkmlt
 z0DchzJ6HV0vMO1WrPVwehJrIyPZ3Ro+lZYURA2nGR2KbtKU5rj35P0iiaeLCsaCfuVRm9yBBU6
 i09pY5fY5PVdLMT9LzpgGZNO1b0kidM4/His5WRErZU5Er5UoZ4x0oJVMuYw3hlaZpa6rKs66/v
 AxG1OrBAMp/v0EKUAlqe65E5kfbhrShFef1weVRFqZhLq9QEIJBHfrynndM0tgcnIZAWfy9hmg4
 BuP6SqwVD7GgMR6bhnMai+kdwYVtASpLMSwQ8YnMycFD3R8bAOYxubyC6c/FaBwlgdHTBuIZxgj
 K9+TkL/Ye71RMWRT6+wCcU10Hlu91TxNu0dfHIaokY83MXkM+vQA49m2pwabCrUt2YrJ9Ch3pR1
 GbTrmLxM0CHUJ/+0/713957dwz9zUDA8lsUsIuGlxTQZL5V6nVbns0WXMBDeytnDKKQjbLYU

On 8/5/25 2:44 PM, Mike Snitzer wrote:
> If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> middle and end as needed. The large middle extent is DIO-aligned and
> the start and/or end are misaligned. Buffered IO is used for the
> misaligned extents and O_DIRECT is used for the middle DIO-aligned
> extent.
> 
> The nfsd_analyze_write_dio trace event shows how NFSD splits a given
> misaligned WRITE into a mix of misaligned extent(s) and a DIO-aligned
> extent.
> 
> This combination of trace events is useful:
> 
>   echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
>   echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_write_dio/enable
>   echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
>   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
> 
> Which for this dd command:
> 
>   dd if=/dev/zero of=/mnt/share1/test bs=47008 count=2 oflag=direct
> 
> Results in:
> 
>   nfsd-55714   [043] ..... 79976.260851: nfsd_write_opened: xid=0x966c5d2d fh_hash=0x4d34e6c1 offset=0 len=47008
>   nfsd-55714   [043] ..... 79976.260852: nfsd_analyze_write_dio: xid=0x966c5d2d fh_hash=0x4d34e6c1 offset=0 len=47008 start=0+0 middle=0+45056 end=45056+1952
>   nfsd-55714   [043] ..... 79976.260857: xfs_file_direct_write: dev 259:12 ino 0x3e00008f disize 0x0 pos 0x0 bytecount 0xb000
>   nfsd-55714   [043] ..... 79976.260965: nfsd_write_io_done: xid=0x966c5d2d fh_hash=0x4d34e6c1 offset=0 len=47008
> 
>   nfsd-55714   [043] ..... 79976.307762: nfsd_write_opened: xid=0x67e5ce6f fh_hash=0x4d34e6c1 offset=47008 len=47008
>   nfsd-55714   [043] ..... 79976.307762: nfsd_analyze_write_dio: xid=0x67e5ce6f fh_hash=0x4d34e6c1 offset=47008 len=47008 start=47008+2144 middle=49152+40960 end=90112+3904
>   nfsd-55714   [043] ..... 79976.307797: xfs_file_direct_write: dev 259:12 ino 0x3e00008f disize 0xc000 pos 0xc000 bytecount 0xa000
>   nfsd-55714   [043] ..... 79976.307866: nfsd_write_io_done: xid=0x67e5ce6f fh_hash=0x4d34e6c1 offset=47008 len=47008
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/vfs.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 131 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 0d4f9f452d466..4980800fab66e 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1315,6 +1315,121 @@ static int wait_for_concurrent_writes(struct file *file)
>  	return err;
>  }
>  
> +struct nfsd_write_dio
> +{

struct nfsd_write_dio {


> +	loff_t middle_offset;	/* Offset for start of DIO-aligned middle */
> +	loff_t end_offset;	/* Offset for start of DIO-aligned end */
> +	ssize_t	start_len;	/* Length for misaligned first extent */
> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> +	ssize_t	end_len;	/* Length for misaligned last extent */
> +};
> +
> +static void init_nfsd_write_dio(struct nfsd_write_dio *write_dio)
> +{
> +	memset(write_dio, 0, sizeof(*write_dio));
> +}
> +
> +static bool nfsd_analyze_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +				   struct nfsd_file *nf, loff_t offset,
> +				   unsigned long len, struct nfsd_write_dio *write_dio)
> +{
> +	const u32 dio_blocksize = nf->nf_dio_offset_align;
> +	loff_t orig_end, middle_end, start_end, start_offset = offset;
> +	ssize_t start_len = len;
> +	bool aligned = true;
> +
> +	if (WARN_ONCE(!nf->nf_dio_mem_align || !dio_blocksize,
> +		      "%s: underlying filesystem has not provided DIO alignment info\n",
> +		      __func__))
> +		return false;
> +
> +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
> +		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
> +		      __func__, dio_blocksize, PAGE_SIZE))
> +		return false;
> +
> +	if (unlikely(len < dio_blocksize)) {
> +		aligned = false;
> +		goto out;
> +	}
> +
> +	if (((offset | len) & (dio_blocksize-1)) == 0) {
> +		/* already DIO-aligned, no misaligned head or tail */
> +		write_dio->middle_offset = offset;
> +		write_dio->middle_len = len;
> +		/* clear these for the benefit of trace_nfsd_analyze_write_dio */
> +		start_offset = 0;
> +		start_len = 0;
> +		goto out;
> +	}
> +
> +	start_end = round_up(offset, dio_blocksize);
> +	start_len = start_end - offset;
> +	orig_end = offset + len;
> +	middle_end = round_down(orig_end, dio_blocksize);
> +
> +	write_dio->start_len = start_len;
> +	write_dio->middle_offset = start_end;
> +	write_dio->middle_len = middle_end - start_end;
> +	write_dio->end_offset = middle_end;
> +	write_dio->end_len = orig_end - middle_end;
> +out:
> +	trace_nfsd_analyze_write_dio(rqstp, fhp, offset, len, start_offset, start_len,
> +				     write_dio->middle_offset, write_dio->middle_len,
> +				     write_dio->end_offset, write_dio->end_len);
> +	return aligned;
> +}
> +
> +/*
> + * Setup as many as 3 iov_iter based on extents possibly described by @write_dio.
> + * @iterp: pointer to pointer to onstack array of 3 iov_iter structs from caller.
> + * @iter_is_dio_aligned: pointer to onstack array of 3 bools from caller.
> + * @dio_aligned: bool that reflects nfsd_analyze_write_dio()'s return
> + * @rq_bvec: backing bio_vec used to setup all 3 iov_iter permutations.
> + * @nvecs: number of segments in @rq_bvec
> + * @cnt: size of the request in bytes
> + * @write_dio: nfsd_write_dio struct that describes start, middle and end extents.
> + *
> + * Returns the number of iov_iter that were setup.
> + */
> +static int nfsd_setup_write_iters(struct iov_iter **iterp, bool *iter_is_dio_aligned,
> +				  bool dio_aligned, struct bio_vec *rq_bvec,
> +				  unsigned int nvecs, unsigned long cnt,
> +				  struct nfsd_write_dio *write_dio)
> +{
> +	int n_iters = 0;
> +	struct iov_iter *iters = *iterp;
> +
> +	/* Setup misaligned start? */
> +	if (write_dio->start_len) {
> +		iter_is_dio_aligned[n_iters] = false;
> +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> +		iters[n_iters].count = write_dio->start_len;
> +		n_iters++;
> +	}
> +
> +	/* Setup possibly DIO-aligned middle */
> +	iter_is_dio_aligned[n_iters] = dio_aligned;
> +	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> +	if (dio_aligned) {
> +		if (write_dio->start_len)
> +			iov_iter_advance(&iters[n_iters], write_dio->start_len);
> +		iters[n_iters].count -= write_dio->end_len;
> +	}
> +	n_iters++;
> +
> +	/* Setup misaligned end? */
> +	if (write_dio->end_len) {
> +		iter_is_dio_aligned[n_iters] = false;
> +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> +		iov_iter_advance(&iters[n_iters],
> +				 write_dio->start_len + write_dio->middle_len);
> +		n_iters++;
> +	}
> +
> +	return n_iters;
> +}
> +
>  /**
>   * nfsd_vfs_write - write data to an already-open file
>   * @rqstp: RPC execution context
> @@ -1349,9 +1464,12 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	unsigned int		pflags = current->flags;
>  	bool			restore_flags = false;
>  	unsigned int		nvecs;
> -	struct iov_iter		iter_stack[1];
> +	struct iov_iter		iter_stack[3];

struct iov_iter isn't that small. This is going to grow the stack frame
substantially but is used for only the direct I/O case.


>  	struct iov_iter		*iter = iter_stack;
>  	unsigned int		n_iters = 0;
> +	bool			iov_iter_is_dio_aligned[3];
> +	bool			dio_aligned = false;
> +	struct nfsd_write_dio	write_dio;
>  
>  	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
>  
> @@ -1380,18 +1498,12 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	if (stable && !fhp->fh_use_wgather)
>  		kiocb.ki_flags |= IOCB_DSYNC;
>  
> -	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> -	iov_iter_bvec(&iter[0], ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> -	n_iters++;
> -
> +	init_nfsd_write_dio(&write_dio);

I assume init_nfsd_write_dio() is going to be called only once.
Is there a plan to make it more than a memset() ? Can it be called
in only direct I/O mode?


>  	switch (nfsd_io_cache_write) {
>  	case NFSD_IO_DIRECT:
> -		/* direct I/O must be aligned to device logical sector size */
> -		if (nf->nf_dio_mem_align && nf->nf_dio_offset_align &&
> -		    (((offset | *cnt) & (nf->nf_dio_offset_align-1)) == 0) &&
> -		    iov_iter_is_aligned(&iter[0], nf->nf_dio_mem_align - 1,
> -					nf->nf_dio_offset_align - 1))
> -			kiocb.ki_flags = IOCB_DIRECT;
> +		if (nfsd_analyze_write_dio(rqstp, fhp, nf, offset,
> +					   *cnt, &write_dio))
> +			dio_aligned = true;

How about

		dio_aligned = nfsd_analyze_write_dio(rqstp, fhp, nf,
						     offset, *cnt,
						     &write_dio);

Let's make nfsd_analyze_write_dio a "noinline" so that the compiler
removes it from the hot path in page cache I/O mode.


>  		break;
>  	case NFSD_IO_DONTCACHE:
>  		kiocb.ki_flags = IOCB_DONTCACHE;
> @@ -1400,11 +1512,19 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		break;
>  	}
>  
> +	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> +	n_iters = nfsd_setup_write_iters(&iter, iov_iter_is_dio_aligned, dio_aligned,
> +					 rqstp->rq_bvec, nvecs, *cnt, &write_dio);

Is there a plan to use buffer re-alignment for the other two I/O modes?

I ask because there are many more conditional branches now, and they
seem to be useful only if there are multiple iters. And it looks like
there are multiple iters only in the direct I/O case.

Generally what we do in situations like this is create utility functions
that contain code common to all paths, and have the separate paths use
those helpers in the combination that they need. Not only is the
instruction path length shorter for each individual path, but the
resulting source code is much more legible.


> +
>  	since = READ_ONCE(file->f_wb_err);
>  	if (verf)
>  		nfsd_copy_write_verifier(verf, nn);
>  	*cnt = 0;
>  	for (int i = 0; i < n_iters; i++) {
> +		if (iov_iter_is_dio_aligned[i])
> +			kiocb.ki_flags |= IOCB_DIRECT;
> +		else
> +			kiocb.ki_flags &= ~IOCB_DIRECT;
>  		host_err = vfs_iocb_iter_write(file, &kiocb, &iter[i]);
>  		if (host_err < 0) {
>  			commit_reset_write_verifier(nn, rqstp, host_err);


-- 
Chuck Lever

