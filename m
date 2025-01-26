Return-Path: <linux-nfs+bounces-9632-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85387A1CD57
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 18:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76FF165A6A
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01851547E3;
	Sun, 26 Jan 2025 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l5YWI+FQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="POQSWrgt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E11362;
	Sun, 26 Jan 2025 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737912502; cv=fail; b=dhPS9xaSYLQyi4Z9Kr3WpqHfUwWLSAL/K5tPFd3l9HBZUU53UkWHs7sav9FOiXWpLrowJQs2Z/AoYpcWTOp+wX+Vjkj78QObznTQI98WWea2g8J4wzwzdJ5Eb36o3w8+IYpyWshkC+6A6hv+2Sca1bH0pp/s8OVZZduQNOP+rEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737912502; c=relaxed/simple;
	bh=pSMkjm1bbqywf3WFlySMXJoCwt3o3QsqI+VP+MO/FEM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Iv2LfxXlP4Q/R9rVHPE4Arz50muWUHRfMBLSqiQN1y647wOG7j6TetMuo9fwJoaCXzASHzXyjTkU7qfXYavoy9GlD/Ed4ZqZsfEwBpAIxPgGweXCXA7pKr1vELLs5KaaTx7bDkS4QE1Vg5izDJltgZqb2TDZsgmEHiL8rSccCO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l5YWI+FQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=POQSWrgt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QChje0027554;
	Sun, 26 Jan 2025 17:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zWZqbUSqavtfZBt1NN8/3UEE+qU2WXTgTaN/YfYoLnE=; b=
	l5YWI+FQaUfJLouKOv/e/95YOsiM5dKMHGaqmo0QpHZMR+4wRmj4WLrNaEBbRrSe
	oa2dNkNxk8siSKpCZdYqK0RDKg4ljEdY26eotlfrlJlwon9sCtj2vn59gCYxzueC
	8O0Gp5e0QwcRycYw06/1xvFEFcWueSDNtVlcLasHoeu2YQ88sV9jIpcVFzZdU7UO
	2tj8eNKEwDA/1MCp5m5QTBISHOHpnOrCJb5xonhc84lguKTHycgqPuc/KA6+Vlo6
	D4Yf2vegIFKNoFBWLWkQjYPifUHozFXwE1ZKiU3K1CzN2mHlILY4FThSEAxf4gqQ
	zV+MzffD6ZgMR0Og12+2Fg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44cqjshdkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jan 2025 17:27:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50QG6abj024087;
	Sun, 26 Jan 2025 17:27:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd6757g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jan 2025 17:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRJXx5a732MtRCp5MBMNuHEunWJ3w19Lyuvvidcmi0V5eZImkzMk24V285pqiipaoO7kelWDdGRiQmml/g8tqCh3Ebs3EdpeDL0l1FPenq7i81t3Pcik0cxJdX7CbCzoASutX0vY9tN+KBinNhOaTHCjQzvTrqc0er0x6puAcZ6ZIcFrnt03Zl5bFWouoGDnsm4aIBrAjB06CGdstDq48wujUlAvC6zM3TI7PxBT0o0AboJxW5XbjzTsRbP3XqCPuzuhlA1u18fksYS+4USv9Lb3FPtFAopxZ0LybCe9oVNN0LjUyvu9OnZL1sqwuLx0CQDlTXMjDXKvfwMXPZFFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWZqbUSqavtfZBt1NN8/3UEE+qU2WXTgTaN/YfYoLnE=;
 b=y0xmSmukZ+b3iRS7zL6xzXexQGfcViK3Xb86S+ZrXyEaOjoTltCPL5mt4aFQdLpKrvpY6qU+TnfXGpzJav7AcocREOaWXYCQbA5nrGdBTdsGSVdCmRDAIpfemaMc3fQ53urNYy65j4on462YP7zDbeLDKnwsUmR4fyARKzHn5gOYp2atJ4vnDSuLTEpoURtnqH2s5QbG74342oK5ia/uVqwRtPbwfh12lwHbWtSc23Lj5GXc1Gw3wn5h7z2hNqrraBHzB74eVeF+3SMEf56ukagTmWYtXRiMQJxB4V21V+jtHiLkbeIDqmJpRLkEYIUQ1QBGAXEQFs+3Y9POSVcBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWZqbUSqavtfZBt1NN8/3UEE+qU2WXTgTaN/YfYoLnE=;
 b=POQSWrgtHOGtJ8hdT66bJDSLthoQxucxIFQLlMGmmxXK/8qsNtm/ohe3ObxJFhAWA7W0hPvhZJ/SzR7BHNOlf8OcWzm3Y1SWosQ3J0mZIMAEJxLZ7Ct14gYtxeWW885FhH6i+b5wXWTKfjkE5YKsj3PrWhEeNz5mduoS79AeHcw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4388.namprd10.prod.outlook.com (2603:10b6:a03:212::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Sun, 26 Jan
 2025 17:27:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Sun, 26 Jan 2025
 17:27:27 +0000
Message-ID: <e9a10562-5c8e-4bc1-a767-20ee1b07e4b6@oracle.com>
Date: Sun, 26 Jan 2025 12:27:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nfsd: map the ELOOP to nfserr_symlink to avoid
 warning
To: Li Lingfeng <lilingfeng3@huawei.com>, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, trondmy@hammerspace.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com
References: <20250126095045.738902-1-lilingfeng3@huawei.com>
 <20250126095045.738902-2-lilingfeng3@huawei.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250126095045.738902-2-lilingfeng3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d216da1-1ae8-4d43-434f-08dd3e2eb41e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0xuMTJHeXdZbm9XY015c0NpTWRCQTZNdFZ3WVVZbXZwUXlwVm9tYzltU1NX?=
 =?utf-8?B?NW1Xb3lmVnVFd1dBczdCTEJpNzl2Zk5iTzNwM0ZrWFE2aFViY2Y3cythSzAy?=
 =?utf-8?B?Y1JIR25PMmxJdGhRb3ZFamhIMmRlZWNNSEF4aWpvWERuWnhMTCtoeENOODNG?=
 =?utf-8?B?cEpaS3hjOWRUUG9KdE5ab0hFMk5pclhCcmk2R1BNOTRUVXZkaFg5RXdIbmNw?=
 =?utf-8?B?SDMzSXJOd05reDhSQUNla0taR2NrVDZNcHZLTUo3aFhKdWpTeW5CMnhsV1ph?=
 =?utf-8?B?QW9RanVFNEVJRHJQNWZwRGRld0xIWFE0ZHozODZnWW1BNXdvbXRlNjhCcExQ?=
 =?utf-8?B?ckZKVEtZNnBzZFRQemFTdENxd2xIZW0xZEpLYUhGdnRNTkxjTlZ6U0sraWFV?=
 =?utf-8?B?SmdkRllHWmZuZGFGVlFtTVpWU1lpbnBlbVVpSTRmZGVEVXhLTTRtaTlZWVc3?=
 =?utf-8?B?SXkyRWx4bXR3d2ROeXZuUitMVXZnYktyTVczTzRPYUdNYTBObVA5ZDVqaEJ4?=
 =?utf-8?B?TjBBNCt4YW1rRld5RFovQS8xMERuUHlieDg1WGRUcExrWFhBTCtuUStwTG0v?=
 =?utf-8?B?RTUveGFoTzQwaUxlOTNmTGhBOG4wTmNJTWNyV3E2bXFnQ0NTR0RZNDNCYUJj?=
 =?utf-8?B?dVVOSThkSDN1Z2NDR2FRU1UxLzRHRTE1bEpDa3NVYnp1blM2TDFIRjZOZXRh?=
 =?utf-8?B?Wkh1aFhFbG81bWVHaDB1aElBZGhRajluTDMvUFROVWgvOGJOSUpHZnYwWnY3?=
 =?utf-8?B?eE4zZ1Uwd2x2S3BFNnR1NXlxTUhJUC84VHJSMDRGVXVXRTMvWFhFMUZwTjNN?=
 =?utf-8?B?YzE3VmZyRXNQQmMrOTZCaWovQXNrbWtQTUJCazVxbmltOG1yVXk5Y3dOSTFi?=
 =?utf-8?B?L1BSNDNBYkNNTmYra25mYlRmODRWMGprYkt4V0hFUmkyL3hWMW1HMVpYSFZu?=
 =?utf-8?B?U0x3UGFiSnlZRmIwZXRIb3RjaE5LdlJyK01kTHJocE16ZXgzTHlsR01NY25k?=
 =?utf-8?B?S0VUYWl5V292cVlvZzVwNGNnTm10SUlGcWdGTnlvb25GM3dvYzN4cUJQK0Zi?=
 =?utf-8?B?MXVqeDVKU2w5b0FUekJYS1ZIVUFSSnpBekpiTFIzSUM4SFRaMFZpcDlMSVpT?=
 =?utf-8?B?MUhNUVFGVHoxQ2xFNVdUUDh0bGVoalpLdFIvSGl0L2ZnWmRuUnZIaFAwT3hp?=
 =?utf-8?B?NHl6QlkzeGZpcjFsRGdNc29STjF1N3pXWWk3eld4NjJQNVhpNFJ3bzQxMXYx?=
 =?utf-8?B?NlZXQUpaVXM2ZmkzTlBnTWpKZzNkNTNsWWhyUE95TEZuMzAyRkpYWFpJdzRl?=
 =?utf-8?B?M3ZWdjRKNXdrRkh2c0IxNzlGZlhVdStUUk9WVzZxc0NwWm94a1VQdWZMTlpr?=
 =?utf-8?B?VFdXMVVaL2NQVXRKY2lmaGt4b0lQL2JzMUhQTnlxUXdaZlFxTm1HcFlENUJy?=
 =?utf-8?B?ZmUyMTRDc2luR2lCZ05NazN4SXZ5ZDlpdHR0dmZSZm9EZm5DT1RKaTlHd0hN?=
 =?utf-8?B?ZVppeXBpM1ZLNjVlV0Vicmx6cGNwSjd2eTRlY3ZFUVBIT0xJR3Z1WEpLZXl3?=
 =?utf-8?B?N3NSUjhMenFmWGJkRTF1REZ0d3FPbXlGM2ZHTWFqMmV4QUJ3QXh4NWtqNkFD?=
 =?utf-8?B?UkVDbGNONnhMdUFRSXVSbEE4cDM5andBT3BvTmgwcjh4ZGdNclVwYUErdlRi?=
 =?utf-8?B?SXNsemNIbHVlRitDamlBQjlQTnFjRWNZY2NPbzFoWjNndkFDODVWUXljbXZh?=
 =?utf-8?B?OWxlQzcybUtnSEdORFV3eXN2dUUzQWc5Y0plMlpPRnFZRVBsbjRYLzdEdm1K?=
 =?utf-8?B?aHErRjRQVTVJbzZBWEl3Q3FVeFVsUUx4NW52SStvbGorOGYvRHBQckhFRWNs?=
 =?utf-8?B?Vk5aQ00yQWhRNkR3N2czYTJkR3RqakIzaEN3cC9BQy9OWktGUFJQZzQ0K2c0?=
 =?utf-8?Q?iASxWucZVqk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlROck1HT3gvTEVjdmtWWTY1WWxEZ3l2VHNycGdybGdEN2Z1M2hnekxGcjRW?=
 =?utf-8?B?cVA5ajdGQjhtOHNDdW1GU1BzRWtOY0RqaWwvRDlZU0pNTFR1U3dHbm40YlpI?=
 =?utf-8?B?MXF4Q0FwYXZxM3lFamVzNWRJOUhibUliSlZNZlZjZFRmczdVUXhpUldUSXZH?=
 =?utf-8?B?TXFTZ3BXYWZUV09ick85WjcyZ085WXBrS29HUHYya1RPUGhNNmM4aEtlZzBD?=
 =?utf-8?B?Y21SVHhQNzZES09FaU85dnhIQnVLU2JRNVZ3WHFCTGw5US94OHM2RTVNa3Fk?=
 =?utf-8?B?U0FPMzU2MC9rL1h4YVIyd1I5TnJkMzFVUTlJV2JndTc5SVBXdk83N01GM0dM?=
 =?utf-8?B?TE5ZeGEyNzV4YURmWGdySTJ5MTJ4Q2crV1czdG01M3dDOERjMm45dzd0L0dC?=
 =?utf-8?B?VSsrT3ErWTFKV1BrZi9aNzhNMmFPb2hDNTRUK1dvTGpnY05ja2t1MWVEamV3?=
 =?utf-8?B?aWlNaFdYUFRPdzF2bFVSQTlvNnFLdjI1U3VpNGRuYUYvTzhBUUU4TzRtSmlW?=
 =?utf-8?B?M2diZzB6dFhPQ0Z3cXRvajNIMmxpbE9yQVV1VFRrVTJKNzhKdjNvTkpxRjNq?=
 =?utf-8?B?RGdOaXVKYjM0UVJ5SzhRdngyQlJDODgwL0lwd3QyZXZ6QU05WFIybExQRmdO?=
 =?utf-8?B?K3lEWDUzdmlFMnRYQTkyTkZha1ZqVEVOTkxIWlh1Y3QrK242M2dlZlBhdzVU?=
 =?utf-8?B?WGhpbGJtMW1RTC81a0xOdzhwRHpHcnZISDhDeXlyakpUK3NVMWo0MytDK3I5?=
 =?utf-8?B?OWpXdWM5S2F2TUFvd3VEM2ZZdDJqd3FhSmpaWnVmRm13dUZtYkNzbmFVZmZD?=
 =?utf-8?B?bEo0OW4xcFNGMCs3VHBjUWZYeThlYXZYWVFUc1RUOUN1RlBHRUc5VmN3b2dN?=
 =?utf-8?B?YWR0ZGZ1N0F5MHltZzZNMmlKZC9CNVFxMzFNRUxVa25ESDJ5VzQ5Q1JsMnlm?=
 =?utf-8?B?Tk9xeE1CdDQ4YlRHL2w5bFJ3MDJKaGtvNURuS1BCZHJZbTlqUWlHOWJ2T2lx?=
 =?utf-8?B?dlg3am9OdUx1ZElJTWJkY3BVdTdsdUlSZVFkcHRlWHJ4ME9MODZtR0U2M3Vz?=
 =?utf-8?B?OE1SWFBoclFnL2dMYUZPazU5Y2xXWHNwT1JVeGkyQ3lzV3lNaVNYQWZqZXAx?=
 =?utf-8?B?Q05SQXZDam1wc29HL2g2bGlSaWJwNmlGS3RKVWhYZDQwMEVRWG8weTNHUGhR?=
 =?utf-8?B?eHlmeG1pVlF1VkZxcTU3cXBzdXhtSlpHNU0ybitTN0JnR0lhbkFvVDliZGpQ?=
 =?utf-8?B?T2gxRFBuYmMzcjl3UGdNUm9jMy9uQXNVeGRZZHlkMlozK1U1QmJKUnU3dExw?=
 =?utf-8?B?QzQ4YjFMVnJrQVppcS9VcTlLcGQxYWxhVUNLV3laQStFMUVTa01Fc3FRWUFx?=
 =?utf-8?B?Ly9pVnUxMy9sWW05QmhYaVhkZFh1S3hXOUxsMkcyUGYzTGxFUG52L0szbVJR?=
 =?utf-8?B?dDc2Y3dsQ3dmRzZIL3VFWTd6cXNQNGhlbWttOEppNHBOTHJTT2RWeUEzdHdB?=
 =?utf-8?B?aGQzMVU5eDY4OTExRGZBanBlUFNMK2ppb1BKTHVTTWJHWEM2T3VkWVJIb0s4?=
 =?utf-8?B?WjMyQTlUME5HYTU4YWNVdjhxUkZrMGhjaWxlcW1kbzA4cUtEUUdMOGZkRTFQ?=
 =?utf-8?B?ZDIvUTduZkdRNkh4VVJacHhlZTlYUjVjekMvaWhyazN1QmpkY1A0eWNHWm9T?=
 =?utf-8?B?Mk1KUGlpRnZuNmRycklGdVJPSERvOGhSdFcyV2xzaEkrNmpWNmthbkNsNEFO?=
 =?utf-8?B?aEJoNGovY3RsQ0VtOGwxUFkyMGl5QVd5MHRIR2NzU0JUcy9PcVdvOHFiZ0VP?=
 =?utf-8?B?MnBwRXRzUjR2WjhxbTl2VE1xU2NwWExZS1M2Z2tpbVhzQzcrNVhNYlJXcldP?=
 =?utf-8?B?UUxHalVVeFp2bUZEeE83V1dFclFHMVNTdGJNWkRibnpDdnJ3N0R1Um1sK3B6?=
 =?utf-8?B?RkI1VnlUQ0ZCYmUwVWtNZFlGME1CVVJzdHhXMHUyZlZtdG10Vit1dmtSaUdG?=
 =?utf-8?B?WnNsemszN1h4cWdJSTF0Zm9xbVV0Q20vdUFvYTRCV216ejNrbDBBeStUMEJ5?=
 =?utf-8?B?aU1tUk8zTTFKY3VRRHJpVnF3dHdJelpWbEFZZGlSS21rRmdtZ2NINEFzL1la?=
 =?utf-8?B?dG9JUFNzeEU4dnV3bzYxcnJqbjFleEVyNFVpNHptWEM2WVZTeWZ0UndIb2lF?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tC0AxHxwsbhvRkLgLoJZ07nZyulj+1TjFz9X2//TKyV259CCDuBrH9KLluS3qy/cejbWgj/vntPGynRePrIj9+uROd9ave1oojy2b+TrgVAoPOHdmvX6u6rv1PBCAZfCBczunCR32IxK5TOfQE4jLFxFWMrQVpD0IFZxNtCko4X71dNOeIDvLudn98ZJmFFpJBs0Q93nQQ4Z85Nwi42ot24s4WvtZfhTvBFzIaeOKS6oj2yFQeRG9sNpwaKx3baAsfk116gw1W6+t/ZKE4RZpf5mboGSG99BTvO/AVNlvvJGLWy5kdy9wSOVRATH4hSrJloZKcPBGmvM4w0/pg9sKI3t6Gut6E5R1xguJrMzae7Llrh/B/me5A4k9mhK/cv6Fj9G42Tf4TVWb+EMTLT2xQ37+GGTbmV7yRhnTt9BeHpQKa2BVaY7EpAE7kpvapAihTRmITFmClmCcdgjDOCTPfJ0o0tprB41jShOSGpC3SdHWYrw8P8L2W4/LmJRcRXVVvIjq3tCFbspUfzDQNQhKK2X6t38WVmptwaXaXuDyYLfu2FtG8xnLWtddts279jGLDev9ZNQ+cxTl3XX3vm+2bBdvsQpWUfmCm+/BAoHqkU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d216da1-1ae8-4d43-434f-08dd3e2eb41e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 17:27:27.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkmHkHjkvIFF1tTNGHqrwuAb58dLOjMhuSj4AbFAgwQ3p/Zsw73Q+LZJa4h7AwhXKsiHZKkk7wWO9r77QfC05A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=973 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501260141
X-Proofpoint-GUID: b83MMJCrfU3aFGy4WIZoNOCtk8kXFPa_
X-Proofpoint-ORIG-GUID: b83MMJCrfU3aFGy4WIZoNOCtk8kXFPa_

On 1/26/25 4:50 AM, Li Lingfeng wrote:
> We got -ELOOP from ext4, resulting in the following WARNING:
> 
> VFS: Lookup of 'dc' in ext4 sdd would have caused loop
> ------------[ cut here ]------------
> nfsd: non-standard errno: -40
> WARNING: CPU: 1 PID: 297024 at fs/nfsd/vfs.c:113 nfserrno+0xc8/0x128
> Modules linked in:
> CPU: 1 PID: 297024 Comm: nfsd Not tainted 6.6.0-gfa4c2159cd0d-dirty #21
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : nfserrno+0xc8/0x128
> lr : nfserrno+0xc8/0x128
> sp : ffff8000846475a0
> x29: ffff8000846475a0 x28: 0000000000000130 x27: ffff0000d65a24e8
> x26: ffff0000c7319134 x25: ffff0000d6de4240 x24: 0000000000000002
> x23: ffffcda9eaac3080 x22: 00000000ffffffd8 x21: 0000000000000026
> x20: ffffcda9ee055000 x19: 0000000000000000 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000001 x12: ffff60001b5ca39b
> x11: 1fffe0001b5ca39a x10: ffff60001b5ca39a x9 : dfff800000000000
> x8 : 00009fffe4a35c66 x7 : ffff0000dae51cd3 x6 : 0000000000000001
> x5 : ffff0000dae51cd0 x4 : ffff60001b5ca39b x3 : dfff800000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000ca5d8040
> Call trace:
>   nfserrno+0xc8/0x128
>   nfsd4_encode_dirent_fattr+0x358/0x380
>   nfsd4_encode_dirent+0x164/0x3a8
>   nfsd_buffered_readdir+0x1a8/0x3a0
>   nfsd_readdir+0x14c/0x188
>   nfsd4_encode_readdir+0x1d4/0x370
>   nfsd4_encode_operation+0x130/0x518
>   nfsd4_proc_compound+0x394/0xec0
>   nfsd_dispatch+0x264/0x418
>   svc_process_common+0x584/0xc78
>   svc_process+0x1e8/0x2c0
>   svc_recv+0x194/0x2d0
>   nfsd+0x198/0x378
>   kthread+0x1d8/0x1f0
>   ret_from_fork+0x10/0x20
> Kernel panic - not syncing: kernel: panic_on_warn set ...
> 
> The ELOOP error in Linux indicates that too many symbolic links were
> encountered in resolving a path name. Mapping it to nfserr_symlink may be
> fine.
> 
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   fs/nfsd/vfs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 29cb7b812d71..0f727010b8cb 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -100,6 +100,7 @@ nfserrno (int errno)
>   		{ nfserr_perm, -ENOKEY },
>   		{ nfserr_no_grace, -ENOGRACE},
>   		{ nfserr_io, -EBADMSG },
> +		{ nfserr_symlink, -ELOOP },
>   	};
>   	int	i;
>   

Adding ELOOP -> SYMLINK as a generic mapping could be a problem.

RFC 8881 Section 15.2 does not list NFS4ERR_SYMLINK as a permissible
status code for NFSv4 READDIR. Further, Section 15.4 lists only the
following operations for NFS4ERR_SYMLINK:

COMMIT, LAYOUTCOMMIT, LINK, LOCK, LOCKT, LOOKUP, LOOKUPP, OPEN, READ, WRITE


Which of lookup_positive_unlocked() or nfsd_cross_mnt() returned
ELOOP, and why? What were the export options? What was in the file
system that caused this? Can this scenario be reproduced on v6.13?


-- 
Chuck Lever

