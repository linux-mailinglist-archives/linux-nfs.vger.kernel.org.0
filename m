Return-Path: <linux-nfs+bounces-13831-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7FDB2FBE1
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4777A58700F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B040021D5AF;
	Thu, 21 Aug 2025 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EkiLRBQm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UqW2mhaw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFFC2DF709
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784899; cv=fail; b=D+DntMypOYCeRiR/l2KddLfR9vn1oUeQBK4yKzLHXrHBQp0WlHrtgFAZ3h30LZSnqJsd7GiJmRpx97bi1BxL+FzLzJMUgfBVDvO6xSL/diRPSthuyK2ti3HNHkWbTtVZxuFABGvZ5UhsQ/v+iH/atqgakA2EVW69B2QohlwFvW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784899; c=relaxed/simple;
	bh=aWecrMb58zFdx/EZjNmpMlE317yypcetUJy67TU6X/Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TrKACjlCG5ZZI1/fDNTfhQJlDOcQl9PKYhqA2gErEy7PcU9RUw1uDmvXTvxCKTY63bjiLDEq8kCceas7b1RX4FjHa2psgu26tbKHPOa/3AZV2o6lwLmdG/xpRVEkUitJ5/4ZSNSbV+vIW6OElpJj/KjgmE9gfD4IIquti9aFn1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EkiLRBQm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UqW2mhaw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LDf5ie011558;
	Thu, 21 Aug 2025 14:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xDb+tam6htsTIphkN1rzAV3cQY2tgiuzH91jL+FDVWM=; b=
	EkiLRBQmFqlnx9g1fQiiolGObyMwThoyMGlIVmPURJdmwCXf0WHh21TkSTdkgX3g
	FrLndjYhHV1CGSWVqmaFPNQaa4Kq446aBRKMwZPV006mKd7+Ni82pHSGOpcnt1kw
	Y8HrFaEUR3ZA57ZHBdnDCWEAsV1DUkyIPdvPxAdZxTrAqh1z9KZjITES7Izt1f/v
	44A5fcw/cr2cxOE9ni+hNWzpkKD/s0bHdSa2+jmwNG8vDDV5IW3/0+UxgGa6B8Sb
	/BdoKPpEow9JgtgBSLJf/s/EscdcChsguImiv3wQSaJ7X+WEfYV7n5RgBSLZ68hJ
	IvxyUbNN7MP5OQQdC22k5A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0w2bjkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 14:01:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LDVSVV020525;
	Thu, 21 Aug 2025 14:01:24 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48nj6g3pqh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 14:01:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qW3OyBjWiv3Czjs4iKSTogtfsGgzfyDKXOU9p/B5j5gIgVIWhHnJlHo+c4Gm822y37Gh0CPNAwZmIXshUTnn6cqM7an6gLp+xyf0i5w+JlZobl2GCMTRDqmGCWb/S7WPQxnODfXKUbGx29gTRRbnxU59R7TaXXGBzNTGukcwDKr2pn6ZRGvc3Cv9NmgnoT5fBBdgzx/oMwPZvVnF0kjNUFgCOFGSj9hDhY5/TnftmOiS5EtcbYTecVRxmc2aiHjRskFHQlIAtcVP8I60UTYDMLZwTCN6he4cEmOWYtvzc+1Q9NClAxtUdg0HNS+uwAjMs3+eQiAvLZ7/pOpHyhoZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDb+tam6htsTIphkN1rzAV3cQY2tgiuzH91jL+FDVWM=;
 b=vNc1YOkzavLQQPnOnH6OyquBLUi4jEPxJk/uqXz1AuvRpjGQQWAIfjyoyeo77bRtqgpbLwegmyRHNVNg0qC/OB/pr4Z1JWNcHKaZ7srU7vIWLdDYPE75kiXNWJegxpo6dNhx/xIv0s0hIHs0b2PAsYcxX9PweyrAqDuC90rbsEvS5Tp9UP8Hby7CQv2iD7UT0uQg7vD1b7Tz8J1VBJGGUsH4xZKIf7tP6dC9IGyaTwx5BHMjbQpU1vq7MWKi9zAd/qC9jRi4PBxmXgcmoh0W+Hv/xUrhx7vg2iiRBE47XZkTmwDOXcizB8Wl+BCX/zUyjkZWoYFMhgnuU3FU8DIHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDb+tam6htsTIphkN1rzAV3cQY2tgiuzH91jL+FDVWM=;
 b=UqW2mhaw2EYZgeNL7t/2+gNHlJZrvZqEMczQSIeZnREB1HA8Do8+CHbd9SPyMYUxVdwo5Jsc4Y0oHGaYG6DfAFphaU+XmnYBsrPz26iC45XGUcy/FUQfoZ+R96j52mRA2vv0gq/wKLBoejC6rdpiLvI2C/Vhi8eDbrLH+stPzEA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PPF51A640DE3.namprd10.prod.outlook.com (2603:10b6:f:fc00::c26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 14:01:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 14:01:14 +0000
Message-ID: <ab338231-a508-46af-818f-fa8cb83960ac@oracle.com>
Date: Thu, 21 Aug 2025 10:01:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] lockd: while grace prefer to fail with
 nlm_lck_denied_grace_period
To: Olga Kornievskaia <aglo@umich.edu>, NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
References: <CAN-5tyEammkfv3QGwe5Z38q1nFAxYV=REFDN++3XrX7Lni+H0A@mail.gmail.com>
 <175573171079.2234665.16260718612520667514@noble.neil.brown.name>
 <CAN-5tyGXxzmMipt8fcdMkpSiPq8cxF5++OJcZriQbcjk9JK3GA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyGXxzmMipt8fcdMkpSiPq8cxF5++OJcZriQbcjk9JK3GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:610:e4::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PPF51A640DE3:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb6e0e9-c502-4077-dc3e-08dde0bb30d6
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SUorMS84MTNzT2l5dnZ5NklPUzY4bGFhUGdqRWRyT1d0QTNSUUFjeGZBRG8x?=
 =?utf-8?B?UTlDYTlOcGlRQy8yaTd4Yjk3TXFaR1JDcEpONTc0K3BLbXFvbkRXMVVlbktz?=
 =?utf-8?B?WVNZYzEwK2h4RXNxYjRUd09KSHBnZCtlMkVSYlRlVlVDMnhEc3RxUGErZ2Zx?=
 =?utf-8?B?RVkxdkZjNisxSVhtWDFlM1pLOC9oTjkvbVlxZmdOcjN4bDNmY0ZjNXltOTVs?=
 =?utf-8?B?MVNEdDg1TTczN3hLZVRXR1Z0VlhoL2FPYWR1bmhFTnJIUTVSVGo3OHFLdmhS?=
 =?utf-8?B?U1EyMG1aYzZwR0JTc2dsMTBGNnZOSTFkM2dEbHh6MWlIdGVLaGJmZXZ5QkZO?=
 =?utf-8?B?ZmVWMUtiek1hKzFlaXV2NTd1RGFVc0UyMHdXclh2VnBrQ3hPWkwxOHlXNTN5?=
 =?utf-8?B?ZWxqaUpEOUJwWFgxWWJZMUdHcHZXOFIwWWZCYUd5WllNcXVVWW91QVB3aW8y?=
 =?utf-8?B?T2NqUTJ1eWdWcEFWWXVaZDdhSndjekhWa3FuU21PbUl0aWc1QWM0TE41SVR6?=
 =?utf-8?B?elhVSzgvSVNFaWk2TlFvU3lraTlhMHY4MVYvSnhMTnF5OEp4b0VFQUtJL2F6?=
 =?utf-8?B?TEphMmVyNnY5enF6cW50eUE0VnE1bnYyanNzTWpNL21MR2hPMmFPajNRL2tX?=
 =?utf-8?B?bmVyT1BicE1pMTF1Z1ZnNXRPLzNuMkUydDBQT2Q3ak5wM3hKREgzcmRtRTJv?=
 =?utf-8?B?c2ZNSzVMRGw2dUxFVDZQSE5rVzZzRmVnR1ZhbEUxVkRITytBNFVzOGl1QmtK?=
 =?utf-8?B?Z2xreTc4RWVhbWpteFo3MmdmVEhnSmxHS1FNU3EzYnBzaVcwU2VVZ3Rna3ly?=
 =?utf-8?B?QTFBZXlKbVVJYWk0ZGlHUUt0dys2TCs5c25hTENhamF1bUVYRXc3Tkgvdm92?=
 =?utf-8?B?RW03bGJhZStWRER6Z0lZc21kRXFVYUFnYVUxNitMaVo3a3dPSVZqcEZMckVR?=
 =?utf-8?B?STBCQk51OE4yNFBYTzN0bXJHL2tmWWJud2NVTGhPK2ZzMEtQci9mRHp0VkV6?=
 =?utf-8?B?ejhOa3ExL0Q0emtoUEZ1b2hucGFPbEUyK1dxUWJ5Zy96ZStVbXYvT041STdl?=
 =?utf-8?B?TnE3R3NCRG9GY3ZLUEFsYzh6MDRuUkV6bld6T1VDU01GUGthQ3pDdU82d29Q?=
 =?utf-8?B?MWw0UGdEM1ZRUFpnRnRVbTZIR1N1RlZ2Q3NvR0dBbFltK0FUZVpVU3JrRjlm?=
 =?utf-8?B?R0ZrSEpmZCtsemEybWtpOWNvTGFCNGhjK2ZYZXdMa2E2cVJGVEEzOWtBdWdE?=
 =?utf-8?B?aFNHR0lOUHZwZWZzNXhIb1Q1bU1Fbm4vYzZ1OEtkUXhBTDRQUkltY0lWL01t?=
 =?utf-8?B?SGZORnZMOUp1bFdBMkJTQ0xpZVRHRnlOdGhQT2lRSFFWemRWSkhpMlljSkxO?=
 =?utf-8?B?SFRlRGdiMi83Qm9SbEI1VHZXaWh3WWJabis2aEZFSkpDdkV4WnZXMVoxVE1p?=
 =?utf-8?B?REQ3enlXS1Jlc0ZmWUhyalJtSzdCUms2eFhtSGNDeThQQ2d5dFBOdGFaUXl3?=
 =?utf-8?B?L2E3VW90bzArRnFYWkhEcUJtVzQveDk2RlVoTTJ2ejJJOTlDZzZyanFrYy9i?=
 =?utf-8?B?RlJzV0JQWmV6YUxtNURRQWZ5QXVQdHVTMFEvQkVlTVhJaHJVcVR5Y2U4eTFU?=
 =?utf-8?B?bm53MzREcUY0bUxvZU8wZEdjbWE1UldCU0ZTWUFsaEJybGlrRXIzc1lhMXRJ?=
 =?utf-8?B?MVBFRXVFQ1FRUkcwbU9FYTNNK2hLdlBCVGZVaGlEN0V4cnpLbm14V3k2cU1J?=
 =?utf-8?B?ZnpINXNIT2VsblJEMkhHVVBOTnhnc3IxWXZFdEZSOGdwN2I0WE5mOFJEMWRB?=
 =?utf-8?B?VWN6MTRPSHIwSkRTSlZ4djhLbEVuL3dldDljUXVJbnpYK2NhWTdZSHNWcEF1?=
 =?utf-8?B?bVBvWmhZQXhQTldiejMwQ29mUFBVN1ZOM21tL2RHc1IzQ2VFOVlDb0RYMGZQ?=
 =?utf-8?Q?OGDy315aZBU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?S3k2dDY4c3JVazhidGNpSGdMclMzRStxaHNJc2hCTTRUQ0xub0hnVVZjVHBJ?=
 =?utf-8?B?UE5VaWRxdUI0ZXV5S1BrbC8wSG4rNERnNDZLSXBhQ3A2bEJkV0pMTDhoeHh6?=
 =?utf-8?B?ZHRhSVJ3ZmM1WFJPZzN5Wmh3aUFPcVRBZXpFSzdWMnVxcFhSZzl2bG9Ia2Vi?=
 =?utf-8?B?U0dRcldlM2VXeUhMU0JDYXRDcGNCSjY3QkE5RWl2VDllaUJCZWQ1Z3VHYURI?=
 =?utf-8?B?VkRoUDcyMzJUTDF4VXRtQ2tOdmJnSmlCMTV2RHFXOERMYUVFWHNSeHFrVTZh?=
 =?utf-8?B?d0FjMzViTThMcmo3ZUllSW9HOTBrMjdqMkNDV2hoZXVsRjVlRDZGTFVMVXls?=
 =?utf-8?B?TVYwblMyMTEveDVETXBEb1FzekJBcmMxL043cEMzSUZKaEdVbnVMejBMTEMr?=
 =?utf-8?B?anVtYkdQQlpkSG1OV0s0MFJLQyt1d0RRdEl2emlESHJyV0RYcmphcnpSWVkz?=
 =?utf-8?B?cDlQc3ZmWjdTeUVxbDE4czFjOGFQeEpSUXBHM2NIRHpvNDFUVDdVUWJGMHA5?=
 =?utf-8?B?aXlWWWtyRjQvVDBzOWdMMm5zLytGRE1udmt1aE5VK1lVTUNEZ1JlTjBHUEtp?=
 =?utf-8?B?TVpWaUtRcy91K2tITW9EVEUwSXozZnBIMms3bzZVTy9HSUw0Y29DQnZrbjZy?=
 =?utf-8?B?bEFQbVMwNTBPajFXbHVHcVZWcW1QUGYxQXBDWDRoekFEUmRDRW9scDJ1Z2VB?=
 =?utf-8?B?ejFKOXBIcUowLzF5WS9oSExjUEt1R1FoUzBpd0xLYVVkaUNiYTUrcEhLeXBl?=
 =?utf-8?B?NXFJcmEyamhERndOaGE1WTZIVU9meGZXKzdhYW1ycm1mbGtGV1d0RUMrVjhh?=
 =?utf-8?B?eEZPZ1l0SkQ4ZVhsSXV2cUd6a0cvc3krdnhxcEhGSFlNRjZlSHBVYXdVcXQ2?=
 =?utf-8?B?TFRiWmFCSVd0ajJWR0hzRm5tL0tyb2VjV011QzJ4M1FIY2I0am5aNFVVWmQ4?=
 =?utf-8?B?a0lHTGhuS1prY3BpRFpTdjNLeUo1QXVxQUlRNGZZNjJBRWxVMG04bmlqc0ZJ?=
 =?utf-8?B?OEpBMEFNcTNPVllqdXpxRWhlNUhPUTV6a1lxdUEraWJLWXNqcE8rRXpXdlFO?=
 =?utf-8?B?QkIzL2pTRXZ6TkNxYUlTTXNVMXVUa0Vxa05ORXpBZXpiQzVkSFhDcytqaWRz?=
 =?utf-8?B?aTY1TVBncTJQbythZ0JsbStTWjN4dUZUMHdnQWpwUXp4RHN2YStWdnhnUC9P?=
 =?utf-8?B?UzFEY0tUQ2ZDLzNMZ1ZqWEVkNnBUTFJWcE5hTEVNZjRmRUJGbFZ5MmhDSG1l?=
 =?utf-8?B?eStBYktISU9KTkc2OGMzK1d5UHF1b1ZtMWI1YW1YMU9QempmM0RwUjI4YXZr?=
 =?utf-8?B?Y05Wczlpd21OV0tVYmthTG1zZHcvMU12VEFxSDdhZ25wV3dDNGliU1JKaUlv?=
 =?utf-8?B?VWNUdnMwbVI5bWYvZExocHgwTDFLbE1wQXpxZjBOR2R2Wm8vYVJ3QVltZFNE?=
 =?utf-8?B?NVFTN0xqYjlPTGJiTW1aR084Yjc1NXNXSmZVY1BkcDlXWU9US0FNOVpzR0RI?=
 =?utf-8?B?TGE4SHVHLzBXU1lpbHA0N09MTi9PRmRISkdXeWhjWm1aK0h0V29HMWVxSnV2?=
 =?utf-8?B?K1BWby9jRDA0RzNIRHlacExNczBLU3hLSERVeW00Qlk2SitFOHZXWTlhYVlC?=
 =?utf-8?B?Z2FhVWxaMDAzMEp1c3FpUE9JWWszSkxNVzJ2TXNHTTZmc0s1TlhkeWw5Q3hS?=
 =?utf-8?B?TWE4amNCdllzYUlSRlpXdjRkdHRwdjhyTHcwcDNScllGazFkV25UNU5yaGZ1?=
 =?utf-8?B?UjIzSU9tREt1SkNSZncwUzVKblBhM2lRYmdIRVlOSnRxTEYweUF4bHh6ZUJT?=
 =?utf-8?B?dWhPWm1YVzlYOXlwc3ptb282cDdIVnpVRmFTSEx3eStxSVFuSFdabStKb1N2?=
 =?utf-8?B?L1V5SjFHTEpqNU05Y3l2Znh5dHhxcjhPdE5WeXZ6akFkYlp5N2VSR3psVmY4?=
 =?utf-8?B?Z3ExUzM5Q3FwcE8rR2RKbk01TVY0a1NPVDBkTXdML1g2Z2lhL3NwZTc3THZS?=
 =?utf-8?B?Y1Jvd2QrY1pwUEE1c3FKeFpYSG1pYWs3NVJFRlJNN3orWXZLSjlJTitpRlNX?=
 =?utf-8?B?RHV3TzBwOS9IS3BKTll1ckwrZXkrRCtaU2ZWa1FJc2ZYNXE1MVVHR1FwUFZi?=
 =?utf-8?B?YnpaTmFwRDZWMFNLaHZ2NDVFM3dtS1Z2THJUR2ozYVB0OFFSWEVGM1dpU081?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AjbQdFcgt8oA6RYfcI7ch5XU1o75hUfM8CkxPSQ8p0SrG1d2XBonRjK+9Y4L53rEvnSBmG/JUYR3waGo6WOyFt1ZKoGhuMdb1PbUlKoFJ2YP/rH28Va9XIrY/Ap+c+m+lQudcmgMxaKuiPWyT41W6TXhSGriMGMiV067v/e8NRlcHhijYZxOD0UinQvXsIMRbf1yT8DMuyW9xdsZTD2s1Gm2WvhTRKZLni7n85ylqLIpqJ2VjpSJR6A54l3Q4UFtODHqZrfPxo59NsVR5kY8A1ar6CPT6j0i2qSanSht8GyncGa3Kc0REPcYFvJUovwbyn2j8YYU7t9B5WGH4ulOtPmatk55g6Fs//5P4VRc6h8Pj0dQDbRUi7ubJRJuVbDT/a0qzOuKh1yxl49dBzJDiv0vRLKIZHZeRgnfFUmRb9LNse5xMzvpy9bHSRqgcaJK45JWrbFIRFp/J5m6DkOlRccs1LzLr1yNXQ8KFGBXe98rtV3gpj1F/tCcVrAfoeobzf9LbZiZFx/0D1qdfs8HHHzVrkpdhHFSlMrsfYKWNtyBsgNApEVvUq1/EbDi8x1iJdPyWHoYdBvZVI54mnD5Ll3i+xqP4va/eN/uDDRrAZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb6e0e9-c502-4077-dc3e-08dde0bb30d6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:01:14.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: so3rk9ZTi5uDMcMqK+juIyop9ixTrjCwj+HPnj6lTCXDquTpn+nEQI4R6Hzru6bgiJWa+6cA+LCBEWrAPlP/9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF51A640DE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXyGN/dx9I6x32
 nNYkiITEv89HH/u40WbNBnfdoIANAMOwdlGLWEJ2261kF3ytR70fi5txGPDTkk7byOkdCbJz8Xd
 pbvA1DVvIYHSDvYNcEANf2puXXKUja9upjEyS14EJOtIxM0c720nPvEdBJpKIPD7d32+IiglMge
 QkK5aWZYBACWzORioI0kJuO3fFOPJjYu81vCrPcwGMu3/lOQKcAUskVhpb7deo5N6Dr06DaNXVE
 Km4HSgtfP7eiviyj0M9fskA3fZNfNsbRbbpkULU+HNJY7LuU9WQTns+aeJEcgD9sNF5vr3ClT+g
 53Vbsx9PFkgAMmvBLnQANZ8LuGsUeMguZcPgFTJF+0ZJN2cwedDm3hEFuO7iPfjt65bwK/MEmr7
 G4UT6tcg+jFaPdyKA0cQfRbu60ocVgiRKuGpIomKbWAWRyEmtT8=
X-Proofpoint-ORIG-GUID: m9HIi-vcFn6AfkE6unZBP0fbIkMkUv6x
X-Proofpoint-GUID: m9HIi-vcFn6AfkE6unZBP0fbIkMkUv6x
X-Authority-Analysis: v=2.4 cv=GoIbOk1C c=1 sm=1 tr=0 ts=68a726b5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=mJjC6ScEAAAA:8
 a=HHIqi4Iterr6EpXi5dkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ijnPKfduoCotzip5AuI1:22 cc=ntf awl=host:12069

On 8/21/25 9:56 AM, Olga Kornievskaia wrote:
> On Wed, Aug 20, 2025 at 7:15 PM NeilBrown <neil@brown.name> wrote:
>>
>> On Thu, 14 Aug 2025, Olga Kornievskaia wrote:
>>> On Tue, Aug 12, 2025 at 8:05 PM NeilBrown <neil@brown.name> wrote:
>>>>
>>>> On Wed, 13 Aug 2025, Olga Kornievskaia wrote:
>>>>> When nfsd is in grace and receives an NLM LOCK request which turns
>>>>> out to have a conflicting delegation, return that the server is in
>>>>> grace.
>>>>>
>>>>> Reviewed-by: Jeff Layton <jlayton@redhat.com>
>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>> ---
>>>>>  fs/lockd/svc4proc.c | 15 +++++++++++++--
>>>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
>>>>> index 109e5caae8c7..7ac4af5c9875 100644
>>>>> --- a/fs/lockd/svc4proc.c
>>>>> +++ b/fs/lockd/svc4proc.c
>>>>> @@ -141,8 +141,19 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
>>>>>       resp->cookie = argp->cookie;
>>>>>
>>>>>       /* Obtain client and file */
>>>>> -     if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
>>>>> -             return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
>>>>> +     resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file);
>>>>> +     switch (resp->status) {
>>>>> +     case 0:
>>>>> +             break;
>>>>> +     case nlm_drop_reply:
>>>>> +             if (locks_in_grace(SVC_NET(rqstp))) {
>>>>> +                     resp->status = nlm_lck_denied_grace_period;
>>>>
>>>> I think this is wrong.  If the lock request has the "reclaim" flag set,
>>>> then nlm_lck_denied_grace_period is not a meaningful error.
>>>> nlm4svc_retrieve_args() returns nlm_drop_reply when there is a delay
>>>> getting a response to an upcall to mountd.  For NLM the request really
>>>> must be dropped.
>>>
>>> Thank you for pointing out this case so we are suggesting to.
>>>
>>> if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim)
>>>
>>> However, I've been looking and looking but I cannot figure out how
>>> nlm4svc_retrieve_args() would ever get nlm_drop_reply. You say it can
>>> happen during the upcall to mountd. So that happens within nfsd_open()
>>> call and a part of fh_verify().
>>> To return nlm_drop_reply, nlm_fopen() must have gotten nfserr_dropit
>>> from the nfsd_open().  I have searched and searched but I don't see
>>> anything that ever sets nfserr_dropit (NFSERR_DROPIT).
>>>
>>> I searched the logs and nfserr_dropit was an error that was EAGAIN
>>> translated into but then removed by the following patch.
>>
>> Oh.  I didn't know that.
>> We now use RQ_DROPME instead.
>> I guess we should remove NFSERR_DROPIT completely as it not used at all
>> any more.
>>
>> Though returning nfserr_jukebox to an v2 client isn't a good idea....
> 
> I'll take your word for you.

NFSv2 doesn't have a JUKEBOX or DELAY status code, so NFSD can't return
that kind of error to NFSv2 clients.


>> So I guess my main complaint isn't valid, but I still don't like this
>> patch.  It seems an untidy place to put the locks_in_grace test.
>> Other callers of nlm4svc_retrieve_args() check locks_in_grace() before
>> making that call.  __nlm4svc_proc_lock probably should too.  Or is there
>> a reason that it is delayed until the middle of nlmsvc_lock()..
> 
> I thought the same about why not adding the in_grace check and decided
> that it was probably because you dont want to deny a lock if there are
> no conflicts. If we add it, somebody might notice and will complain
> that they can't get their lock when there are no conflicts.
> 
>> The patch is not needed and isn't clearly an improvement, so I would
>> rather it were dropped.
> 
> I'm not against dropping this patch if the conclusion is that dropping
> the packet is no worse than returning in_grace error.
> 
> 
>>
>> Thanks,
>> NeilBrown
>>
>>
>>>
>>> commit 062304a815fe10068c478a4a3f28cf091c55cb82
>>> Author: J. Bruce Fields <bfields@fieldses.org>
>>> Date:   Sun Jan 2 22:05:33 2011 -0500
>>>
>>>     nfsd: stop translating EAGAIN to nfserr_dropit
>>>
>>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>>> index dc9c2e3fd1b8..fd608a27a8d5 100644
>>> --- a/fs/nfsd/nfsproc.c
>>> +++ b/fs/nfsd/nfsproc.c
>>> @@ -735,7 +735,8 @@ nfserrno (int errno)
>>>                 { nfserr_stale, -ESTALE },
>>>                 { nfserr_jukebox, -ETIMEDOUT },
>>>                 { nfserr_jukebox, -ERESTARTSYS },
>>> -               { nfserr_dropit, -EAGAIN },
>>> +               { nfserr_jukebox, -EAGAIN },
>>> +               { nfserr_jukebox, -EWOULDBLOCK },
>>>                 { nfserr_jukebox, -ENOMEM },
>>>                 { nfserr_badname, -ESRCH },
>>>                 { nfserr_io, -ETXTBSY },
>>>
>>> so if fh_verify is failing whatever it is returning, it is not
>>> nfserr_dropit nor is it nfserr_jukebox which means nlm_fopen() would
>>> translate it to nlm_failed which with my patch would not trigger
>>> nlm_lck_denied_grace_period error but resp->status would be set to
>>> nlm_failed.
>>>
>>> So I circle back to I hope that convinces you that we don't need a
>>> check for the reclaim lock.
>>>
>>> I believe nlm_drop_reply is nfsd_open's jukebox error, one of which is
>>> delegation recall. it can be a memory failure. But I'm sure when
>>> EWOULDBLOCK occurs.
>>>
>>>> At the very least we need to guard against the reclaim flag being set in
>>>> the above test.  But I would much rather a more clear distinction were
>>>> made between "drop because of a conflicting delegation" and "drop
>>>> because of a delay getting upcall response".
>>>> Maybe a new "nlm_conflicting_delegtion" return from ->fopen which nlm4
>>>> (and ideally nlm2) handles appropriately.
>>>
>>>
>>>> NeilBrown
>>>>
>>>>
>>>>> +                     return rpc_success;
>>>>> +             }
>>>>> +             return nlm_drop_reply;
>>>>> +     default:
>>>>> +             return rpc_success;
>>>>> +     }
>>>>>
>>>>>       /* Now try to lock the file */
>>>>>       resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
>>>>> --
>>>>> 2.47.1
>>>>>
>>>>>
>>>>
>>>>
>>>
>>


-- 
Chuck Lever

