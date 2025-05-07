Return-Path: <linux-nfs+bounces-11584-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E6AAE3BA
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 17:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF804E7DFE
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD2C20CCC9;
	Wed,  7 May 2025 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cZITtlIE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tfwVGzNW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C52433D9;
	Wed,  7 May 2025 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630123; cv=fail; b=Tmgk60rkXXE5sjpoPBh0Knec0FU6dJslMRQ3950YNo0FEi4NI++a6ZdjZQ1bAMIS6+HpBx90IGtmlHzD6CoENftPG7gaWlp+8w/M3kb8jLTmVE7RUt+ErC9vaHU3I8d5iGsUjNzSHTrPWJDqwWxazkFxPWj+FPTG1j05u6X7BDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630123; c=relaxed/simple;
	bh=2sPYQ8p5PyHPFxILDwqaf8PWXOtbr8HnWLegm+BZ+xE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p+F7coUl4ln4OwtfktnKoG/rDh1FcM/LFmrMQuWVG1jZXkRazBTu7kHpoFvhjx/ZC2HAee3/DUX5AfY2ICW/ewNG2IWUVxXEU+Rm5dJl4SV9ixNMoAmVZ0UjTRRRpZv4XShZOlKS7N1OPQtSVIzVZ7D5QsLWI5nggQQXdya++8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cZITtlIE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tfwVGzNW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547F0YMg022918;
	Wed, 7 May 2025 15:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tNwcHS8bL3qzW3nGpctidWgYM0TkhgaO/dDTi74On5A=; b=
	cZITtlIELD50RQWtE2FGrY56rRDRgcqdI0FbeTED5KGPRfY+dAIlEV/RY9vjOuUK
	vasZlNPQY8mMwpTJK8zhMubwpPUxiadJdzWT6zKJLRmLXYxCSuGs/XE/5N03sEAm
	/XeQ+K4LWXkACu+17I5n2nW4lRfuh8wTXTk0OsY+FaMRUVpAvUAJgCObI6H9lt7k
	4uYwAvIjdfKhHRIojXhJ1tznxDjmEPNfx5jfadrZ7AsIHdBCWQkRHc6yUMezS8Vc
	5Xr0CxoYLPKgUDv+lskgSfWbUzU49WJlSqkMana0WsUYCbU99s6ZI0hWdTmlNc+j
	mY9RJJra+Fbx3zLB3r0fmw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46g9scr082-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 15:01:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547EOCIa035402;
	Wed, 7 May 2025 15:01:40 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012032.outbound.protection.outlook.com [40.93.1.32])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kahkqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 15:01:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJEFP0S20nY4f8F3pbsrc96ICdpNHojK1l3w4SaDivEFSt8O/7dbggk2Im/SNajMNLENmSpICAuUp6DaIHMQoTl/mRI3ZNcKMja1fHiLiAO1UZimI61mDKitAw28KIIl0q3OVlZF00L+0MZEf7iSxCEUOAvs8k6PSS1ZAWc45BFdiMRrCoGMjdKvbLfBvoT0q37ATx2cpO8RkdzB1p+DArw/E+2umi1bqc63t44iAvR7rA2itQdYTeZ9BUFEFVYigl6qWRjTb1g0xazCLjl7VYq+v/BhOujaSWRAjkbI/xoRqSwFkarw88kW74ngZJnW4evD/NxRtaMo93ob/nJYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNwcHS8bL3qzW3nGpctidWgYM0TkhgaO/dDTi74On5A=;
 b=NdltpWc5s2YcUx95cZ8euU/llj3IoQ2WTY0wT0Lh5l+bRPnaMmOyr+XX81sR1Y6Eks+LUUO/a+MUPWlX/LDhafIQm3kmeMEgEMHNb+s41f6raBHSilI9utsuP3f9yUC4Dds4CqQVkPyPtyxYW2tGmtC3MHfWhSPBHL+aAqLOWx7e0ylYL+ts+Ib7r4arCPzmv4l/pdb3P/bD8DGUgnZDvzAVNnhC95T80tn38M/XcolZLPRh6hRFAGSvrShqAg1f8s48yvGcG1txyZ+aYiUuvIgS82aWn8v9TP9diXMmbJEUupFeYTZraJ2h8z6JFBsoEPqLq7hLHaL8klK31umiuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNwcHS8bL3qzW3nGpctidWgYM0TkhgaO/dDTi74On5A=;
 b=tfwVGzNWy2KXphfLdEqE/HFTQEyH+8tgvN/m5Ese+py22howh4lLBPxeKSe7noGVOOA+rNfc/HlOvVmG0+RKNPWSsi8Uw8mS6xiW/md4xkyx6RzBwhi2k7B3cgiJSz6X0ijVTFJSTY2wtb9Jgr5Y0rfpcviYJ4kKADTlQk3PCCg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6613.namprd10.prod.outlook.com (2603:10b6:806:2be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 15:01:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 15:01:34 +0000
Message-ID: <63282173-b773-4cfb-8039-53d5af9c8ff9@oracle.com>
Date: Wed, 7 May 2025 11:01:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] NFS: support the kernel keyring for TLS
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
        keyrings@vger.kernel.org
References: <20250507080944.3947782-1-hch@lst.de>
 <20250507080944.3947782-2-hch@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250507080944.3947782-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 511e8e61-caf4-4f81-277a-08dd8d780f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUE3bGhkUnlPMGJvWkg1cm9Cdi84ZkY1bDBvdWNjUWRuMGpQR0tkREFpY3NY?=
 =?utf-8?B?T1FyVmhXaURZcXlzTDBTNVlBblBXNGxDME1pNytGWExMY2dyalRGUndJVTkz?=
 =?utf-8?B?NVFyTWp1Y3hjVk1vUmRFK3Jlemc3SGRrYjg1dHlqODgzUW5NMkE3ZXU1VGkx?=
 =?utf-8?B?aDN0c0lBQStnRHBESytESThoQi9kNFI1S0VDVW96Rm9URUJQbGV0bTFjS0RO?=
 =?utf-8?B?ckFaU3NOeW11dHV5TW9HZDgwbGFWOWo3TjNnYUpoajhNUDBlZ1U2MER5RDNU?=
 =?utf-8?B?Z3E3bVBDQXhuM3FUd0Z5WUprNFJKVHVaZnc1bW9HZlBuT2FMSXRvYUZhVzQr?=
 =?utf-8?B?aHFjVUJlOWpld1pIL1FLYjFLdDU1enhudFlRVVB6ak8yd1V5Y2F0MHBlQ3pk?=
 =?utf-8?B?NFZOODc2VVVtU0R4WkZJWTB2UVdnME5peVdDK1FnNGxEc0dtOThrZW9DVVZR?=
 =?utf-8?B?RWcrTW12NlhsUlkvcnBpZlJUNkxOTTlLYnBURzlJNURjOGFFd1ljc1RGbGxN?=
 =?utf-8?B?d1NzSGxSdWZmZ0dWQzF3T2xialVBaUZYT1FESHBGdlJRL3IyQ0ZadTlUNjNM?=
 =?utf-8?B?Ylpvc0hiK3ZBRHlVcVY1SXZFenpqM0JHUDhLQ0ZnZ1pTK0xqYTJTbTZkbW9Q?=
 =?utf-8?B?aUNQekUxemZSRVBsbnR5VlczV213bWdkR24vaG5ua3FUa0plbnhyNUorb2JB?=
 =?utf-8?B?aHN0ZlZOZDlJN28vdTdkd3BteGJjaHFvVlFRTXUyT2ZQUVZveFdiRlU0VEp3?=
 =?utf-8?B?c2I1eXpvaHNiYzVqS2RlU0VHazdyMGxMdHJQRXUzdzc3ZVk5aVRjdzRlRTAy?=
 =?utf-8?B?Snk5c1p5RE9PYlN4L0ZkNXJtV3FJRGp1OFJJMmppRUdMalN1ODNFSEdWM3VE?=
 =?utf-8?B?QUtjVzIxRnRib2FNcVUyQTJDY0pCTlkyU0psN3ZuY1R1dlZITU5jVVNNZjRw?=
 =?utf-8?B?UlhTSHcrZGJqMUlzcHF3UGM5YXl0Z2kvcmlNbkkwWUROdzRTaXFWdExZWUJP?=
 =?utf-8?B?eHh5eUNYcllBSkNPUzhhRE1MMTgyZ3dESHRwSjVNelYvMUVvUjdsL0VtNEQ1?=
 =?utf-8?B?bElPckNDQ1BJWm9VK0tQSU1YWFY4cVVqZmJkNVp5aFE5cjdPbnY1VzJmbG5q?=
 =?utf-8?B?MGtFQ0cxdVE4VmM3MUlhMXV1MURXT2NWdTdabE5JTVZ1ZWdKRkNZdGxDaklG?=
 =?utf-8?B?OUc2a3BiNkt4T0hmcE1lNU9zYzQ3L3JLcTd2YzhTOFVZcFJCR25rZUcvMmxy?=
 =?utf-8?B?QmhJazJ2ZzVQay82VFdIemRGNU5jWGRNMmNEWW56UC91WGwyMW8rZ0dnMG9a?=
 =?utf-8?B?QlMrMXZTa1B3NHcvOVdocVgwc3BtSFNKdWpzcVdwcmdVZlR4eTRmR2UwTVlY?=
 =?utf-8?B?NkdmcElDTURiTWNRZ3diQlh5S2lmdXZyYUsxOWpUQUlnb29PVHN5MjVCQlFB?=
 =?utf-8?B?MHZLcExKWVJtbWhocWZvUGFXMDNqL01nS2ZRTEYwUE0yMkx4VWt0SktMd0Vu?=
 =?utf-8?B?ZDdoOWdGV2U1UEYzS1U0RDhVSklnQjB6Rk56WXJxUjB1SG0vMTdnYVI0ZWc4?=
 =?utf-8?B?R0pQOUVUOFYzeDc1aCt6dC9WTFFMdCtqazFpRDNGYlo0bS9lQ1IrYVpXTVp4?=
 =?utf-8?B?TUtsbzZkS0hHYjBDTFMvRUoyTUdGTDN1MWF5bkYvODdtdDNMUW1LUW9kUWJX?=
 =?utf-8?B?WU5xWDdzVHhiWXBtUnI3RU9UTDg2ekF0dTZTVWo4VW9lL2dYUFNZUUw3dXQ2?=
 =?utf-8?B?TFp1bmVENTZnVUY5MG9kVDRsSGp3cjNlUnFDQmtZKy9PdHQ1TVlaYmNLTzlX?=
 =?utf-8?B?bnFCRzNuZTBoUUIreFhKT1FrVHhVaC96RVR1cXdWRGxQS2dydUQyNFdwTU82?=
 =?utf-8?B?WWRjWmJBZUI1MHRPNUcyRkEvcjlWWmt3TjEwSlFwVFNSbjFPOXZpR1VmamVJ?=
 =?utf-8?Q?DVyaM+/QSXY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm9kSEJ1WTh1dU0rZzZUWDZkTFU3d2NUV0xxNnpSSW9OWklveGVZS2NYSzBm?=
 =?utf-8?B?aWV6RU8wcGpvV0tGRTlTOGROUlUvVHl4SktNdUo5dm1ORFFtRzdNczF2S043?=
 =?utf-8?B?YkthWVh3dk9jdWtBZUF0VjB3bVVqYm11UzRpcWV1TVlMLzB3Rm5KR3F1UnNt?=
 =?utf-8?B?T242dXplWmljVEVLT1VZUzhYNUR0RS9YeW1CczVrS2pERVUwZ0pwSmwyeGJm?=
 =?utf-8?B?NkdHcUJUSmIzaDBhbzFCT1ByRGNnSExaN2Iwd0dBUWZKdnFUZTNFbDBQVGdF?=
 =?utf-8?B?QklnK095RmlWbXdEbXE5MUdTeVg3SEhSNkUwZWdrdjNJc1R6azgwNEl0V2Zt?=
 =?utf-8?B?OWR2VHk5S2dlaGd3RFEvcWR2ck9mQWRiUGhWQWFXTnpEa2I0QisrYmVmL1dM?=
 =?utf-8?B?NGF4QnhRQnpsTzRFV2dSU01pMG91ajd1VUhqd3lNc0drWXdtQ0laZS80SGx2?=
 =?utf-8?B?L0tzc24xK2Y4VUgyQ2RqU2p4Sm94YTdhUDhwbEhTSEZTSnVRY0xKVHp6eHdk?=
 =?utf-8?B?RzJ4VkJiOE9XK2cwcTByMlJhS2NaTkdHNFlXUHhYMThJQjFrRFJ2N2wrV3ow?=
 =?utf-8?B?REZUYnlSSUYxYWk0eTdVVktLQ3RzM3JFeVNWb1RMYndVVnozM2Izd2JvdHRL?=
 =?utf-8?B?SkdxS0ZPRmJOOWpQbzNYVitzL3dhVnZiblRSNENiS0JNUGl4Qnl4dldvenJN?=
 =?utf-8?B?eVo1S1oxQUpRK09ITHdlZVZ6N28vUDB6Tk5ZcTdJa2lnSGhYWTVDbk9PL0FN?=
 =?utf-8?B?VVB5bVplcWdUL2FqRDZnem5RWDVHclYvUGlEN2gxb3lVVEhJMjN3S29ESjEr?=
 =?utf-8?B?Y1Y0THVGUWd4TnBYa1BIMmk1TDQ3MmpzdHdCaERnOFRzUGg0Tk9aUUFqODFB?=
 =?utf-8?B?V1U4UkRoZHVuOGZhSjVCT0g4UlE5M2VGbGs1ZXZ6OEFRb2V1Z2hXbmpQSmNH?=
 =?utf-8?B?YWdJY2ZOUHR6UkNvQ3BybzVVRGE5OHlHMW15QlNLamd0cDNkOTJzZlNyMk9B?=
 =?utf-8?B?VjBBQk0wMWxNVStMT2dldkVCUzFaZWc2a1dOeEZkS04vOEN1MGtvV1p2Z2ZR?=
 =?utf-8?B?KzZpdjdOVVNSYXcvMWxrdUJ1RnVwTjc5Z1h1alg3d2xJNzByandrbE1TVUFJ?=
 =?utf-8?B?MVJwYmRmU2RqUnhOd0NydzU4U3pvajdPb0crTXVIYk1xWUlZSXdKMG9NamRV?=
 =?utf-8?B?Z3JKd2ZOb1JWUnRrMGVpMVI0ck1SeC9PS1B1ZnBBT24yb2lRaGdJVlRLTS9Q?=
 =?utf-8?B?dS9JTUFrRVhZcWN3K2FTdkdLVDRIRXA5Rnl5YVZ4OVg2TXJId3NURlVDQWNp?=
 =?utf-8?B?WkJ5WmR6UXl3YWF6a0hEWWY0SFg4TmFiUWxCTlYvamRObVl0VGRvQjBtMlR3?=
 =?utf-8?B?ZGpLMGV3RzgwK0VKaTE2R2JvNTBqbHhnTWNwSUhQQmpyTFpES2paY0g2bG9j?=
 =?utf-8?B?K0l6VnVoemZsNEJCeUlGQ3lkRkt0M0dsQ3BQRUNRbjByZEFJaTUySTVCTUow?=
 =?utf-8?B?Rm5MMWNsSHB2SndNc1lER3lVT2xuVnpKK2xuZmJocHNMK0lqS2c1UjFKYTBl?=
 =?utf-8?B?UnBPVHZCZEFDYm5FeGVsekh5WkJ2QVJIdTd0b3VoOGRuS0crT1RmNUhtalBx?=
 =?utf-8?B?QjlLM3cyNGVZWC9wR2N4OEprTXBiWjhYUFJaQjVsNlhtSlNoei93RW4vRVFL?=
 =?utf-8?B?aUxzeW9XTksrZGp2OGg3QjlEckk4S0JjN1Nycno1TFd2ZW13MDJzcWR6Ri9t?=
 =?utf-8?B?bXdqTlladWtxczlkNVZmSDV4Unc2aTZDUUJDUDlSRnF1dVhHNGtWcGUrZzdl?=
 =?utf-8?B?OS9yLzFWbHZPcGtzVjVvYVQ3UlRHZ2ZrZEJOL3pjcFdpV2FsOUwvV1hGb01l?=
 =?utf-8?B?Qi9QTlQzSlNOaUNDZCtVUHFlNWlCWHI5dDBYM3dLQ1FhU3ZuSnJrOEllWURM?=
 =?utf-8?B?enpLcUFBdUxibkxSNGMzeTIyNzVEb29JdWdXWEZHMStjamZ5Yzh2ZThvdnJs?=
 =?utf-8?B?Ym1EaFFBM052MU1NVlFQNHNnSXpVR3pLR1VmNUs1bzc3NDZaTzNrTTFhSGFQ?=
 =?utf-8?B?R0YzR3lLby9tUVl1WjVyUW1sOWN2cVVEV1VyU3pPQVlYeEJMSE1ad2c1MHhL?=
 =?utf-8?B?YTdzREV6SXRCUHUvUk50NG9aVGtzd3hqTzNDTHN0bi9OMkcxTk4zMXhqT0Jl?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PvSiXuA+N0AeQ5VmehimSRBXzXY5jCJRzjk3mV0IvSUKP060fO67MA7C/CMnAgwWI/SIcwl3yMcsbdyokK9l0nX8Z0N/flgrhbm5JV80dlmjBkA4MR//Az00DmENwhWBe3KZM1xnamaIP9ExU9BY1l/0zh/NMBkOT9J5JAW0vhxEYzj5tWM64iXZn8XUbr4A1ytoUaNcMjEh5qoW5O5ETRoMO9+rGEvJiTshC+mtD/ETeOPVIcGlvNxg6KBWDrvaqfaZYaCdMltvVXKumnzEVLR3medaWStm2wfXjqKSWqRxOD87hNF+mro6XUnTBZ9ZkmusAEmQsbtF0AkiJCk/93LPtWdIPSIGaqBTx6m6VPpXbz0vOLbQmuyDakKkl0np6u3oVdH/T1/kLJ+YvT59qFNEnQhtTBCTqzEeANLAcStdrf+NnPXo83Zb9bSwzyR0Ubt/6wbvnfr33U9NtpC+3Vh1vnlXCv4uG00OiIio1+dv4b7d93OM27QO3DZ4HlPipF++6iZEzaPlQBRcR+Rkb8cn3a1hhod7qwYoXkWlsjyHLFutXrwOgh/87oA3HP9q8WT6EXaWtTJo0Pho5Orr0xfAO/8sPyVgxTYcuiN6F4Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511e8e61-caf4-4f81-277a-08dd8d780f01
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:01:34.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIaU6PUR5X9h4WRgmwVPr1TwqDJ/zNvx1cuUvC6aLfMsaf3+BwRCnFjLyOFJTyjCsXatIBPQIoU0WQhbCvg1WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_04,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505070141
X-Authority-Analysis: v=2.4 cv=Hst2G1TS c=1 sm=1 tr=0 ts=681b75df b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=tLzMw1H73PKBBdXHZP0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qGEaIeQCSbCDlD7thCoUNS3nAsQsAjsF
X-Proofpoint-GUID: qGEaIeQCSbCDlD7thCoUNS3nAsQsAjsF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0MSBTYWx0ZWRfXyP2h62BQMwaD 9yvanwFjjzOE10k3g3J88bXt5O+pgKd+hRsF/O8yyldG13kEzbAT7U/7uClFm3aKHdKstISLk8Q BQnrY6+JDpWUoPiK+/OFoAj0uKkH+jw9HoWAh6W7bYiPftTeoNOcO+/PVzU7IlrUsyY+0ngfpYt
 iX1I5MGfeWFleaMMdvIoq+QYv+eXXclrT5Ber9/8VPz3I/+FnOkgLuIrYe8PkiXP2l28WbIFpoz lHmaxymuQiUlVwboJUt5rRsK4ALFu/ZMW7YV0kLGi4rXMX4JRJPkLeupE3Gajmzm/HOYQiFsAGT sO3rjVrRpG+6lVJLSPBY44wVwH/Aw0rg0fEf3w7YmctENpCAqYUPDWq7s8W2HVV1BSLcRRGlnFu
 VXsGYoI1W8sTc/AqJKo/n9FH5hGNt/JS7DUCYdsGM+d+Y9yMnGsUNs57XwmiTLNuOVjQIsFH

On 5/7/25 4:09 AM, Christoph Hellwig wrote:
> Allow tlshd to use a per-mount key from the kernel keyring similar
> to NVMe over TCP.
> 
> Note that tlshd expects keys and certificates stored in the kernel
> keyring to be in DER format, not the PEM format used for file based keys
> and certificates, so they need to be converted before they are added
> to the keyring, which is a bit unexpected.

I proposed adding support to the kernel's x.509 implementation for PEM
format keys, and it was rejected. So DER it is.


> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nfs/fs_context.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 13f71ca8c974..58845c414893 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -96,6 +96,8 @@ enum nfs_param {
>  	Opt_wsize,
>  	Opt_write,
>  	Opt_xprtsec,
> +	Opt_cert_serial,
> +	Opt_privkey_serial,
>  };
>  
>  enum {
> @@ -221,6 +223,8 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
>  	fsparam_enum  ("write",		Opt_write, nfs_param_enums_write),
>  	fsparam_u32   ("wsize",		Opt_wsize),
>  	fsparam_string("xprtsec",	Opt_xprtsec),
> +	fsparam_s32("cert_serial",	Opt_cert_serial),
> +	fsparam_s32("privkey_serial",	Opt_privkey_serial),
>  	{}
>  };
>  
> @@ -551,6 +555,25 @@ static int nfs_parse_version_string(struct fs_context *fc,
>  	return 0;
>  }
>  
> +static int nfs_tls_key_verify(key_serial_t key_id)
> +{
> +	struct key *key = key_lookup(key_id);
> +	int error = 0;
> +
> +	if (IS_ERR(key)) {
> +		pr_err("key id %08x not found\n", key_id);
> +		return PTR_ERR(key);
> +	}
> +	if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
> +	    test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
> +		pr_err("key id %08x revoked\n", key_id);
> +		error = -EKEYREVOKED;
> +	}
> +
> +	key_put(key);
> +	return error;
> +}
> +
>  /*
>   * Parse a single mount parameter.
>   */
> @@ -807,6 +830,18 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
>  		if (ret < 0)
>  			return ret;
>  		break;
> +	case Opt_cert_serial:
> +		ret = nfs_tls_key_verify(result.int_32);
> +		if (ret < 0)
> +			return ret;
> +		ctx->xprtsec.cert_serial = result.int_32;
> +		break;
> +	case Opt_privkey_serial:
> +		ret = nfs_tls_key_verify(result.int_32);
> +		if (ret < 0)
> +			return ret;
> +		ctx->xprtsec.privkey_serial = result.int_32;
> +		break;
>  
>  	case Opt_proto:
>  		if (!param->string)


-- 
Chuck Lever

