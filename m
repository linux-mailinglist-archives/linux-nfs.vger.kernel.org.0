Return-Path: <linux-nfs+bounces-11688-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB56AB56E0
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 16:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E92189EA86
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 14:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A09D70814;
	Tue, 13 May 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dld7DKAq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="STwcP2EX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362782A1AA
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747145879; cv=fail; b=ZuY9LqeIxLshNNcV6UfIe1RVcfTqmCsK3MCY7CHEMucFMAPNgMZnec+rHtEQUbZdyPL6TcRj/9X+7C/wpYByjrkxDeHzLDX1PI059SaqGu0d9YlAu9NEqLZXPB475F60whqrMgbFX4dFKoi9MHuRTSlCx8XfxoLQT+Ck8FBrqGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747145879; c=relaxed/simple;
	bh=DdHHt+ZcbusTx5hLNkACANCtiDQO1P+p9suMniyjsBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cDSX+lmux4mSpL4cvzshU8zQgn1OKF48SRBnDyZXyYY7rJlzOtv+GJkzTcyJYu/7oHwjCsPLtpnQh2EINB/B6EfbEdkTIy6KYuvB6zo+GKiEKctEEbPXxISjgVr5JYFD1F03814zhmX8kaBHNslsQGQDFvJMZeWIzJWJWXBQb0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dld7DKAq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=STwcP2EX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DCHKUE031883;
	Tue, 13 May 2025 14:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ddgWIc3DsZQfnB6MkwWa0qgfgB6jGm60kH+7DV/C8KI=; b=
	Dld7DKAq686DC40Kx86iNYmEoy31oWWq3nvqvIolqjFvfU/dk5rO9vWvyQDBwDIW
	+xPVOitGBp5w3bJ3d4n8OjUr65/W78PsQBU096oVgREI21rDyw1y2YRPK6rrSRks
	0RYQH1cABFT71b7QQYCGliBK91FNgJheqd29g5aSN6xBZox8bbY2Ft35b1nufJ4e
	GqoXZ85Uq6REwEAi68KhGosIHKa44mdYK4SxjroRTyn2BYuqkakAs3lsWFzhJbih
	SlD6TtT8EEQqJWCMoXWUZnk0Dm6EuhI4mXQvmmG1EUGqg32QlRNNMTn8ZjdCdY2x
	TmcDMtMrGVMLGIVf69K23Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1jnmxqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 14:17:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DEDpgb002521;
	Tue, 13 May 2025 14:17:54 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010003.outbound.protection.outlook.com [40.93.13.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46jwx4cq2e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 14:17:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8oWkdX0ytx1aayRXO+Iho6S/rHuXPG95pXdHdGV8JkoKEzrhprWmR5Rc0TVg9JiCVLMyszTIgE4FC0yXQkcy0qZ2r27RxL1QF9tjFt1EwgXSp1RPTwetvEL5m5NQtxl617LhID/Z2+GrfKq3VcWYIxI0TAeptz/CZsH6cKMEujRtC7IaDiNnIjRrWJe/CpY8ckF+QBo5IBS08+Dbgwiu4bq4oEtYxQb2VePIWFM60faNBhESAoH/FOXcRLN/+flpo2bkltJIAfSO0JxG3f9Wf64KKyVULod6Heh4uXU5KnLVMzHbxgmeHbkT6CHRs0ysa0/n8eqIjeswOMCDlEOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddgWIc3DsZQfnB6MkwWa0qgfgB6jGm60kH+7DV/C8KI=;
 b=FPue8PMqczMvyq9LZxsMDnx8MpUbShhB3oA8DBuHYE40di+ENKm8oGxTCZS/3+FTCdMZQt0v1YoN5/DxsJ8Ls97xUbUvFn4hulKOL8GynhyInsV2fGCV/4bQxHBQ7mLz93nil/1pJb+HBb2Jatnv+DP8FqdMuVBbEpIjZN0Wc82KwdO47zSf4RWC6f9tDNB4OLuLLHhrgh1O+vrG6H88NPBRF1tzdPQvA/9X9zHbDewiGkSLEJKDl2Pzgxvq1PRe85Z16YtDjK4v+KO6WogY8SM/ZytJyEszYq2/vrsIJRsu3LqghVyurXBMDtgA0sEUngeaBVepexN5WfxSuyMgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddgWIc3DsZQfnB6MkwWa0qgfgB6jGm60kH+7DV/C8KI=;
 b=STwcP2EXDGpgXcrtbS3ScEtXGVZfOPlcvtXOGStBZPWwfDRGkPaD9a1QWjP9hyVSnc0Z6ZMfO9Ldrv+8+aF2gv1118ojjwWND/TmgPE20yoQhylgRHAREEUTuPJQEoSbU3KCap+icwXt/lbVBJBJuSpNR5A7hSA0sc5K8Xv2HVg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7252.namprd10.prod.outlook.com (2603:10b6:8:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Tue, 13 May
 2025 14:17:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Tue, 13 May 2025
 14:17:48 +0000
Message-ID: <2afad899-e2d1-4f9f-9476-36f3dfee8ada@oracle.com>
Date: Tue, 13 May 2025 10:17:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>
Cc: Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
References: <20250513-master-v1-1-e845fe412715@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250513-master-v1-1-e845fe412715@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR12CA0062.namprd12.prod.outlook.com
 (2603:10b6:930:4c::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: d04ec9f2-f218-47d7-dbab-08dd9228f074
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?STE0MXFIdmtWZmExazB4TTU3MjQ3YjN0S3pTYTFZempSV0JSUEJtR1pHRDly?=
 =?utf-8?B?VDFiOHgwcDRsU2xCamVrMDBmb28vV1hLenFPakJwQms2dkFmOXhadytDM1p4?=
 =?utf-8?B?dDRUVlBqd0NuSXVVK3VkanZqRGVudFc4K0N2emFKNDMrNHdRWHZ6SDN4WWll?=
 =?utf-8?B?ZDZRSjcvT21OdWhtWld2ZmhXbG5RREpWQTd1UmU1NWFCR2thOUp3a3daWlNP?=
 =?utf-8?B?NUZvR3d3S1VCV01lVHNSNHN4WFJlRFYxMWtxWDg4RnVYaHJrbDdhaEMvV1F1?=
 =?utf-8?B?RkJFcWxTWjdBcHlIVXFMT1FoWThyczVkTjZxNTU2V0JnYlhBdXdZTGNWMjk1?=
 =?utf-8?B?T3VISXpXRTREYW0vbWVGNHozSmV2b3dLYnVsL3BablJhZE9sZWhndlZnM1JL?=
 =?utf-8?B?cDJ6ZUFHQ2RuTW1YZk9NL01VaDhBMUZkNkNoaUVlT1lxdHl3eFJCbG56dTc2?=
 =?utf-8?B?a0xCa2cwTmY5ZnpoTGU2SmNUTktjM2Q0NGwvcFBTOU82Q3EvN1lLdmd1bXcy?=
 =?utf-8?B?OFlDZjQ5aUNKZVNQR1RCd29HR2VURzd1OU5xR1hGU3N4S2pQQVhaaUdvTnY4?=
 =?utf-8?B?QWhNOS9tV2ttNVBWbldCRi9ONjg0aTduY2tWNjNlYjZ3NDhkcE9MRS9ZSnQ0?=
 =?utf-8?B?enlYclFEWmQ5ak44MTdWRk5DeGJPVWZnd01OdW1zMkxhbmlZcE50dFNnOEJJ?=
 =?utf-8?B?eUFjakJxWkFzNDZ1cVVJaGJzRXlMN0w0ejRIMWs4bFJ6YkJYeGtDQnNLVnVL?=
 =?utf-8?B?OU8xL3hKQzdSWC9Xa2Z3MGd3WkFwcnRRWWtCWEJ2L3ZURVNsVDVicjFwNXVP?=
 =?utf-8?B?YnFvZ3pWQ01KaWxBMHhxQmc4QmhUVWpUbXVUWk9pa0xMM0t3V2taWmtIRm1N?=
 =?utf-8?B?REJLLy9vT0lDY1VHblRTYWJ0clFjVzJuZzJJYkVCNUtmMm4yL2QzdzcyWXha?=
 =?utf-8?B?Z2k0WG1xd2hHL1FYM2UzUFdTK2srWUtSS3Y2ZGZvdVVIbncySWNUcHVISGc2?=
 =?utf-8?B?aXB3QzhNdGZMUUVyVU9zRnpLRHptU2NmMU9XdFVXZ3lLYlJkRnV4cUpIaHE5?=
 =?utf-8?B?aFdKV281RFR1cTh1QXdFNU5yUVZWb1dqS0NJcTk5WHNOc05KcXpvK1ZDdmpK?=
 =?utf-8?B?UkIwVDAwcXhkbEp4VXg5b0V5YXp3WWxTVWZ0TjlrRGdYK2ZFYUZSVjliL1dj?=
 =?utf-8?B?bU9HcXpSWlhhTm1ZbHliUktZZW9zRjFMbXNWQis0d0hnWnEwS1F6OFR0eHVD?=
 =?utf-8?B?WE9ldTJCU09sN0JBd3JzTFlNSFg4SGQ4aHdsdllWVnkrK2NrSHNLYmZQNVlB?=
 =?utf-8?B?V2JKWFBJVzl1SW1SZndOeGRaZTcyK0R0Wm10ekFWNkxNd1pJeE5BbUxZb29h?=
 =?utf-8?B?MzFsaEd0ZVpYaEoxT3BRYUVBZjlXdkFiZ1c2ZFRDeVRSbDluOEFWeXJ6N3gr?=
 =?utf-8?B?aHpzdkUxOFNtM2JEbFg1QVhEYUVzMjZrMkQvVi9Wck43UURHVGlIN2VzM2Qz?=
 =?utf-8?B?T0V2SVhWWDNBOTlIS0RReERWWXVRaWNhajJ2dU5hbkZtZ0tTUTVjSE5NQUYv?=
 =?utf-8?B?dmVMOEZoOXpxU05oN1FRbW1ObUhyNWFGNVJXL1lIb3ZPM1VUNWMrenBUR2Fm?=
 =?utf-8?B?bUd4MWF4MWlWemJoTFF6RjBDQTFxRncvZjF3K1BMUTZ1YkUzaWZDMGtJZlBp?=
 =?utf-8?B?YjFPdDgzczU4L0JYeVdKSHdGalY4VjVscXZmdFZqSzlpdSsvdWpWcUN2Q1Bi?=
 =?utf-8?B?OEFLYm5ESWsweXBDSWtyWDgyakF3T2d6QVBzRUFRTTVSdThlR0JmL0I5UjZC?=
 =?utf-8?B?ODRNMWhxRWtDMUlLVTRLdFgrV1NVd2lzVExJYnhhZXIwL0dwQ1pHSHJleGZX?=
 =?utf-8?B?YkRyMGY5OGVucW1wdFZzdURwWnlyakN4ZGxhUnlQZ0VKMXc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YTIvNVo3ZTdWWVNkclRvdnlGOS9CT0JlM0tQWkU5WXhpeThVMUVuUllRRXRI?=
 =?utf-8?B?RHFsRy93QlZLakRvRlU2OEpkS01ISGZRYThVU1VJdDJ1UGM2RzY1ck13NW5Z?=
 =?utf-8?B?QmFBWkVpc1Z5UXFUYWRMYWNkMzloZE1JcmMzTHZIdWU1VmV5cS9HMWdnSlRl?=
 =?utf-8?B?alhJb1YxTjJJMDNKQ2g4LzJESXFzNmZIa1JETjJDTmVKK0pMa2tNMTFZQzA4?=
 =?utf-8?B?K2JzdTk1ZFZMR0d3Rk8vRjJvRjRzQ0F5KzhrSXhMRFpjcFYwa2RFTDREb3lU?=
 =?utf-8?B?V1hCa0ZOZ0x4QkkxWXlYM2dWbjlod2hCN2dCZThwYkRCcjdUQzhrNXBCZGhB?=
 =?utf-8?B?VU13K1RtYnpmS0VhV1V1eG85L2tuRGhsL1dBak1ybC9UcEdENk5Yem1qZUdy?=
 =?utf-8?B?S3BDazh0elNwUS93RGdxTkVDbG1tREFrZTlSK0tFVjhMazZGTHRFRHUwZHNF?=
 =?utf-8?B?WERtcUxpcTV5TkwvdWdsc2phcjVjZ2xZYXlnSGlkZTFtY2Z6bVJ1OWtzeFdE?=
 =?utf-8?B?bnE3K0xST2prRjBlNCt4d3BQQzRMSDhEV0g3TDVnK21MY0xyVDExZ2pqTmIr?=
 =?utf-8?B?ekxFNTRtZVZhdUs2TXR0QW8yYXc5QytTU3FzTUdtU2FsU2JTd3EwRWVrRCtM?=
 =?utf-8?B?clNZbmhPVGUvL1FSbDdvMmFGa3Y2cVhOcE5ZMldlaGtOQ21qd3VHQmNXZ3R2?=
 =?utf-8?B?VEZFRUFNWnhNMnc3WHVjZlJjMHVhaVhPZFVxQnlPYUVNdURJOVp6b2pFSHVx?=
 =?utf-8?B?a2tkdGV2bSt1MDBhOXlWMnNzYUxIWUtSU3pqNG5yRHQ5UHdFTjRiaC9YSU1T?=
 =?utf-8?B?U1RXSjlTcVB3cTlld3NUUmdtbDgraGlVSXJvR2dKYVhoQkNLT2txTGF4VER6?=
 =?utf-8?B?WDkyYzJySVZJNUozOERUVjJ3TUYzdXBNY3drWGgxNGEvZ0s5d0hFUFRMT21y?=
 =?utf-8?B?eDYxcjhwc3c5eWx4eUw1MXo5aUp4MTljYWd3K1BQK3ljYlZvVGVLTld5aEo0?=
 =?utf-8?B?d3RBREpQcDVEbFpmdEFlNERLYnQwdEtxN0ljV1RTWlVoZHR5U1VRZGFmWVlY?=
 =?utf-8?B?Y1A0bGNDVkhLVkpuVHRPUFYwekdJOUMwNi9COW9yV3RqSENSaXlwSXpDZlhY?=
 =?utf-8?B?eXI0K1MrOHl5WndFR0E2QmN6V0pGZll5M3ZISjJpUFI5V3hoZjBLQWh0SjJi?=
 =?utf-8?B?cG9yd3kvaGhsZGxuWFo1UDhLeG1BNjNsdytNTkh4RmpBZFNnbHQvY1c0QXNy?=
 =?utf-8?B?ZSt0bFdEd1cyRG5DNG92d2htOENMNDhqZlBmdmxLQXo3YXdlNlpiT1cyYjh5?=
 =?utf-8?B?ejJLWEpLN3hRTGFoUm5PdmFoQnN1VUtCWnNNamNYUDBFVHJHTnFYU3JsNS9O?=
 =?utf-8?B?L3IwemtMbWg4MlpqSDBpT1VKUTI1K3BTZFgwUmIzdUNhOUd0bEl1ZmxRZEYy?=
 =?utf-8?B?dWtmaXlZMWhBbU9tQnNHV010QVBldjQrUEV3OXFhcXVOUDR5aVc5WjRQaEl6?=
 =?utf-8?B?SFI0UmVsUk1xOTRmakxSTlRjeExDZkpYemhXM1NCYlpUM2RndVlRTDVxMmgz?=
 =?utf-8?B?bTdxK1JscDQ2NUJITllla2Rsa1BvVGwxcGxrdytMdmNUeGJkRzF1Z1BjaUk5?=
 =?utf-8?B?RW1kMTBnZExkSzEranlpYWxUdmxEcG10QUF6T05wNXlYL2wyMHJJQmJ0bUYx?=
 =?utf-8?B?K256Wk5jY1FwN2R6RlZKNUxsUzVGdW5DczhSbWNtODBYelpGaHNBaFFWS1VS?=
 =?utf-8?B?WWxRR2VJUnBHOGkyeHhNSjh0RmZDUVZHUktQYWtOelpIZlBsVVNreEswUDFq?=
 =?utf-8?B?S1NrdmprY0xRdFRDS3o5eWNpdTFWRlJjR0gyMHZLMU9OZ0xBeXRLYm9JQjR4?=
 =?utf-8?B?L3h4Y1kzQnl5aVRidW5YU1o4RFF4V1NzWnpiWTQwVndDOEhpV3F5NFgzOEVK?=
 =?utf-8?B?SlVWMThHSWRVVitzVzdYbHFsT1hDVXR4Z0ZISE9rMlNGSnkyQXFORXhJWUdo?=
 =?utf-8?B?TEJDeUxxa015SU9GWWdMb0FOQ0p6L2h2RC9FSExoakNNY3dlVWhRd043ajln?=
 =?utf-8?B?L3JzMmRDT2swT2Z4TitjNHUwTFZJQklabDdvTXR4bG15YUNrOEg3QmxyTXM4?=
 =?utf-8?B?MVdYanpRZW0yckw1US9tcnJXcjJxVGt3QWtXN1ZYd2grL0lScjdYS3ViK2NL?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G05ZgOQ0INnROcpLX/gVxUw3tphmKOdfOUo+f6O1yHvB+TSvID6t7vN3FO6pYUVtP8RqV78I+IxMU0PyytDL3dhH+f0LnMYq8iaA7ZPXzm8oyW9g2geG2nT3UnvVZZV6RVrJWjYRqM55CCNM9tZ/6BanLbIapjpRItxcel8nCsHbdZ2ej6rsqaUPdwFNuU1jvFvOXC6Hpft4+tSTKjcaWY7887aCW4s4bGJfYSFYUNYrl9dznu24p1HJ2hoY/x62X1D50Q2joCtSckUKdfTlM+HcaqW0HNSQGYcTlkdZixxgTItGRX7OMewXLvfkz5mcX4CNiL5FAaNrYzecvmjZ3KfYxaJJ3sZ9hEPSojpih1zg3OYrnqPxQy6j1tTKWOv/iXlkN8h2urDZZLoMq+NA69qn079e6GBKxeLPKGODd7M/r6ANAtmOX5f/JIwIjS8p9+0wpgdm6H50S6vZYGvE23Glmh5azlyReoFlbBlmGzXdyfTJ6lGom03hJi0LeP21VZZRwlTClhvI01aYVMDmNanwTtgvWoCuEJkEfFuEZbsvJ/bB16rg4V2lCtjS/19t9D59CPmkXTwosyl1Ulm0FzMbuCp+s6FA7Cf8qEIILis=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04ec9f2-f218-47d7-dbab-08dd9228f074
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 14:17:48.8870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8H7uvO8ZL4wjJS+upnsTP3WAGPi1l0evt91REYxp/O15QbQbRHIwOYb2iF+zWbs6u01SbXlFq5YX3CG1nfabtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505130135
X-Proofpoint-GUID: 6GD30e9--XwrEyvmhMREBhZv2QGFUB2V
X-Authority-Analysis: v=2.4 cv=PeH/hjhd c=1 sm=1 tr=0 ts=68235493 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=6qw1eSuRmzfE5eMI9EIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEzNiBTYWx0ZWRfXzsbZroGiLj7Z VjLIqp8qmAfSEXPmLdcPJlBVdVHrIF/00TSVUOUe/GckLyn6TvQrd4a54u6JFIVAwTKduFMmnkW /G1da4ZfK58F9kywgFmwumnFFRV4N5WJOdcD0CF7CYpsL3P5CnSK9d73VMQA7PWoxRFBe58ShX1
 vs+tX7nePSVyUdrUXnr2zhqkBqXRpPyEwOuIub9knK3I1xreYPmvnD3RNcyq5WtfivjHfsbJdNw EqwHGemuoLl5uUud++Ee0FFp9BbSYAOvV1zm/lUt3AW5hxgSRHX7Wtw9wK5l5N1hOHJOF3duE/H /Ut2t2ZhW30gLEAkYXJ6WxFTvWEGBIZBu57wlYjz8UK9fmCvvTHl/WBEDURFRkGn0pkfiRYpAKN
 Ufz6lu0pG9QFmo9toZLv4QoOVvWx1RdYERQvZyW25q4GNbLlULlKrsb+Ia/B7vEVPyjCmY7p
X-Proofpoint-ORIG-GUID: 6GD30e9--XwrEyvmhMREBhZv2QGFUB2V

On 5/13/25 9:50 AM, Jeff Layton wrote:
> Back in the 80's someone thought it was a good idea to carve out a set
> of ports that only privileged users could use. When NFS was originally
> conceived, Sun made its server require that clients use low ports.
> Since Linux was following suit with Sun in those days, exportfs has
> always defaulted to requiring connections from low ports.
> 
> These days, anyone can be root on their laptop, so limiting connections
> to low source ports is of little value.
> 
> Make the default be "insecure" when creating exports.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> In discussion at the Bake-a-thon, we decided to just go for making
> "insecure" the default for all exports.
> ---
>  support/nfs/exports.c      | 7 +++++--
>  utils/exportfs/exports.man | 4 ++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef287ca0685af3e70ed0b 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -34,8 +34,11 @@
>  #include "reexport.h"
>  #include "nfsd_path.h"
>  
> -#define EXPORT_DEFAULT_FLAGS	\
> -  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
> +#define EXPORT_DEFAULT_FLAGS	(NFSEXP_READONLY |	\
> +				 NFSEXP_ROOTSQUASH |	\
> +				 NFSEXP_GATHERED_WRITES |\
> +				 NFSEXP_NOSUBTREECHECK | \
> +				 NFSEXP_INSECURE_PORT)
>  
>  struct flav_info flav_map[] = {
>  	{ "krb5",	RPC_AUTH_GSS_KRB5,	1},
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7eb84301c4ec97b14d003 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -180,8 +180,8 @@ understands the following export options:
>  .TP
>  .IR secure
>  This option requires that requests not using gss originate on an
> -Internet port less than IPPORT_RESERVED (1024). This option is on by default.
> -To turn it off, specify
> +Internet port less than IPPORT_RESERVED (1024). This option is off by default
> +but can be explicitly disabled by specifying
>  .IR insecure .
>  (NOTE: older kernels (before upstream kernel version 4.17) enforced this
>  requirement on gss requests as well.)
> 
> ---
> base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
> change-id: 20250513-master-89974087bb04
> 
> Best regards,


-- 
Chuck Lever

