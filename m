Return-Path: <linux-nfs+bounces-21474-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMGECKYvAmq/ogEAu9opvQ
	(envelope-from <linux-nfs+bounces-21474-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 21:36:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA745152A0
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 21:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 282DD30433E6
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CD5383C60;
	Mon, 11 May 2026 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YT+BLlIp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hcSQhCVD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29E40F8C5;
	Mon, 11 May 2026 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528138; cv=fail; b=gdkRype5V5XAPEJD8G7IylCjlbCZTK/xHq0ufSdPNSBa+yjmhpECuHMfHRmO2MuMi136Tnui7l7Cg0mawzj6j1M0qNKUixHnNw7S5AQhKO6ec+X7RA/8D5DiXpeL4JFUTicPW5LdWJg+Bf1hEYCi/Lv53p4jU4bxzipz76dZ850=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528138; c=relaxed/simple;
	bh=iUV75A4VdkhJHWodnDBGr2xWFnVxn7L4AOlfhh+Nv6s=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=EZw/Spw4h5YuIFWBj3Bog7TLgXwzF89U7z9PWnL/yIEoyJAvlTk+zgHfWFDl6U6sKIh+veFdU5gd1xlSlhDLOHiLUQXaXrnyEjXRFnf4uusuvIxy/1Flga7/YAsj0GuAfByg2QXnzmXJhQGJQGq3H1/Jp1V1eyM0Z6wAyRdVeG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YT+BLlIp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hcSQhCVD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BFtaxg3375440;
	Mon, 11 May 2026 19:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=IEBaL+L2nR1X9Gl2
	AskJku8MLRHtM8UDugNVltmZ03w=; b=YT+BLlIpOWykzixCJq94f2EYqCu63ptu
	0o+/2XFOUyOuRCSAkNxVu4NzD9vkUn58N7UVlFT93wDRPQuoAPh2aWppPNFfFnkH
	sZ8M5LezikjAC2FB64MOcVeMEMa9Jy7jDX6jlt1d1Bx6WBaO39Tvd6zPWjVax2eD
	k5EUBSBZjLNACB+qwon9Sm5yeeNWKGT2qF1aIbUAyVrE0AZLDbjCUUDS2MlbdOkH
	GF8QC6elDkxfpAI9LcUIS9WS4x4JRBuH+mUD3Cjps7YdyukLBtFQHY2GnZ50ykgT
	kR3mWffn8J9rsmtkwUtlF8rqjfQscYDtEt3ScGSnaqIOF4vyjKCohw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e1ubbb7sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 19:35:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64BJLI8X038546;
	Mon, 11 May 2026 19:35:31 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e1uc9ng69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 19:35:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cB6o6PExXEsrsxtLz3Phd6ieiQaBS5Zc4JuxrJJ1iganMlHUGk/mRvvtccRN/tPYg/4w0x1le8lgEaRgxIVKxYTJu+UlmCYIgLsOe9majE9uKhaX5z1v+CDLeLhH9I9M3g1d3l7Rs9rDejynXrMNPbukA/3mbUz2BE2VUljlc9YVysSlCsaF5hzlp5EMFJTANK0VmUPxGeVIW1hpK3+/gth0yrdFGMB6f7fGz1d2W7nlcUC7aq+VfYaXv1/GkptxpzLDt21wDyVklIwo2BSq5CvGRdMOxhjD8i01etPUP+QkiFXjANqVLqAQz7oWghKHV2Ri3ESWcR8/dte6Lb2SXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEBaL+L2nR1X9Gl2AskJku8MLRHtM8UDugNVltmZ03w=;
 b=Ir0msXzAaPrFaNoad0UaA35eNo8DwoiQKZzw6hznM4qD5pqHkef9HZzw4rcLlTg5lcQxrGQ8bxB27R7nQhZNZnot+qFiQPSyWRT4f2HNq3lgFYxuvI9PUssXfgcaiAfTj/LhBXdMwPhlbS9+RmxXDpSWvbh52oYs6PgnnWHt5v4M9c/cVMWKtEjRvS/YbUSEv87PcSw7mX1egloSsD74InuZ6mn0iKl/x/G1whjcjZvOqn/nBnQD2rRZOfQXwpwKo5nK0RJ7Nz6fQmNWp05solRHugDIG+QB3nKhkVIQlIn5OLa5qmnS41dChAAdgzcYui2oBEba5SsjMeKC4mX21w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEBaL+L2nR1X9Gl2AskJku8MLRHtM8UDugNVltmZ03w=;
 b=hcSQhCVDAJugGnCmuYk12SzQpi2rv15dzUVVMWsto2nzqBMnycrwBpdlKd+zeukkle9T+DK8VKAcabV9WMfQ3I05KNl7heVTDbPKG1/lpRARl0wMba6a6O23C23QR07Z4oBJidMmfrW3WiFPBfHFSqzAEGn4G/hoCnrBFP8Iuw4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8195.namprd10.prod.outlook.com (2603:10b6:610:243::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 19:35:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 19:35:26 +0000
Message-ID: <f71ec2ee-6d28-4757-afc5-d99472194641@oracle.com>
Date: Mon, 11 May 2026 15:35:25 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
To: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: [ANNOUNCE] ktls-utils 1.3.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:610:e6::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: c2598abf-3dd8-49db-7f8f-08deaf9473dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Q6Sx9AeDs3SrtKxTQT0llh3xVmv9dGCjKkNr90Z9DzTUSOcECt2P+8Xoc/P2Gu7l/navI5vDJT10AkiGsnPyAiMXFdspO7Gn36BRJDVQG6r5q2nhBFK/SGv7fcU28WF6OQmhHdb3q+oLWsiPnAGVV0KWNKWCGWAq4kuoZ29Xc3TRO0cuwcbif7kT6A6dZlXXoVTddOei+qOnGufMCQWeTDII92EE1ZrF8VNctihNp/5Gx+nALxk4eRI7tEXU7hcqCvEtyDMdBCNhJOn0o+SGyzrLOepDMODcsLfoaUuKWribnws/PxN/z2NMCYO7qoYYlFdNUACtDl/oxIeyaaXkZZXvPMvlf95KlCW6zBOTwWs9s4BKd8wH6oniapBRw5gCI0o6OLRVNnf3hr+S+bC33UaYprdOpPQ6atvvKLkOVY1mkkDnXMWFdkoQB1qKfhAG9Z26O3v3Cvl5Hr8R/8sn3sBmMvwAl1rHLkxpMQKdaR5RPxhnTg32rG5OTq7c9N3BoC1lo3V6wyVk7ZKvsottg+sfvEjL0YVCRe/gVawmxd/czlY8aJLAXXze+uJ5tANXc1tJNAWepdXJSheZi1vk9a4+BnYvnUBSim8yiS4TnK6F9PgUhLR+TGAnk8Dm5N4zkRiR+f4mVbUsL9HMU+ZZlw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWNVQ25GMExKckNlVEJMVStKOTA1ckZIdjFLRktlNzVlbEQwblorb1RWaC80?=
 =?utf-8?B?VlJFV2UzRDNqZGZ4VHpBUkRsWUZXK1JsYjM2ZndhOEFiQzNXaGZUWnB0bGtV?=
 =?utf-8?B?QjY4bDFZUkM5ek5RQnpSUUFIV3dnREptWFBoWFNWRmFZQ3draUh4Mk9WdWY2?=
 =?utf-8?B?MkNvUk5OUWc0SHRpeVBDNFZuaHVtbmNYU1lIb3pheFNEZ2Zya3NNVVlmODJu?=
 =?utf-8?B?MTVFOVJ3NVRQSzg1TjR6NnczZDBTSFNic0l3WlRqQlJUQ0lGcG9PSElReCtC?=
 =?utf-8?B?eHZNNFJ0RXpERlYwclBVWTFpN2JrSERGTVJjWW1iOXl2bERVVjF0VW5xeUI0?=
 =?utf-8?B?ODRhajN3RG5OUksxWVJmSGFKY0JBTzlHR2l2SXh2M3hBSzYzMkNpUDQ1N1JC?=
 =?utf-8?B?Ymh1dktEcDhEVFp5ZjVjMkZZOVQ3VEc5QStvQVZYU2xUaHFSR3F4SDJsRjFY?=
 =?utf-8?B?M0c4cXFPR3U3dG9JNVcvN1RPNUdZOVhuN0JBQmhTMFA3YkJkdkwweWp4c3lM?=
 =?utf-8?B?S29oN0E4eThySFhEUFVLZnl4UEZscitUT0lqSHNqcVJKb3hNcmViVyt0ak1q?=
 =?utf-8?B?akh0VHlYdCtCbHd5SkJyMmNlOUxZNjd6RGJXQUJGcDl2aEVPSHByUlROREwx?=
 =?utf-8?B?U2p2SkR6TENHNGRJYm1xdHBCUTZSTnBEU244aldsQmpHYjVZL0dTTVhiUFpz?=
 =?utf-8?B?K3h2L1gycEJOZGdCZ1M1d2JWajNGL1k4dWwwMkRMd0VXdWw5OXAxSEtTcnJw?=
 =?utf-8?B?ckJHbkpoalN3dVkxVHU4NDFXOTRWdnIrczUzbklwcUF5MzZjbjdPTndBd3kw?=
 =?utf-8?B?QjNmU0Fxa1BMUnZ2L0dZenR1VDRwUjVjdEdmS1cvamNwdXNPZjJHLytvUjJv?=
 =?utf-8?B?d2ZzOFBtblFrZ3BwUkhrL2pTUzZZeUIzRk5Ha2lQcWlBb3UvUkVuU25meXc4?=
 =?utf-8?B?R216RVpvRHVrUFFtYUlYNW1TbTBiM1Z6MkxwZGZLMWRBL0k4T3lnYi9GNVZk?=
 =?utf-8?B?UGVMT0NGQW1aTHJQME9WWm83ajJDV0dzaytqcE9vNUdUMjZnQ3Faby92d20r?=
 =?utf-8?B?azFIanNoNnlvamhBbkdlZEJWSGVEVzgrekkvTm1MOTd6YVd2cDY0K1FHbjd6?=
 =?utf-8?B?czVDbWZ4RFNIVjJsckRUd29aejNtM1huOGhzeDNER1RmYWpXcFM3bGwxOWkw?=
 =?utf-8?B?dHZsTVpoZ0tkaHMwRGhnMmg2Sk9waFNJeExlaWJRWE01VWNvY3B5c3B6MlVp?=
 =?utf-8?B?UWFVL3NtQ2kwS1hXTXl2Zzd0bHZQbzIvTUhHM09JNWRLQzBHU2VEYytiRlJK?=
 =?utf-8?B?M2ExRlBjMGJ1NDFEMmppa1EwYS9RUWtUMFlCSHVzbnFxK0FZS24vamxueXlE?=
 =?utf-8?B?YkJCcHh2ZzRkMHB2V3BSc1NjT0JSWHVWUU55TEVwNXE5eUlMbEVwVG9GWjFN?=
 =?utf-8?B?dG5sVmRINTBwaWx3Zmo3ZFJzV1c3dXIyZWVqSHJBQmI1VXNUenYwYjFMR0dj?=
 =?utf-8?B?d0VSVjVycXFrR2UxQVp1RmR1eXhVWGJUbEkzZzIrTlQ3WHFDTVp3UUxnMEY1?=
 =?utf-8?B?a1VSVTV3Qmt4Q2tjK2s3WGFKSEI1R1VSQnQ5RTFuQ3pUbDZwT3pCdjF0dytv?=
 =?utf-8?B?SHJMRmIzRnBLYTRRUkVoZG82YVhiQTZtbDMwMVdzbytxaUJHK1l2Tm96ejNB?=
 =?utf-8?B?ODJKR01xWitDSEp5MitFRTZ6NlpuVGIrZ0hFd0Q4N3VFeUEvNGhmZTQvOXBJ?=
 =?utf-8?B?OFlxaTNIa3BDcHlWZmdZaEVwVEEvNlc3S3VXNUZhdGQrUlNpOVZEdGtWcGtl?=
 =?utf-8?B?YXdzYWo1TVZhSmttZVgraHRMWTFOUnJKb3NWOCtEUlMzL3YrZEZmaGdMbkUz?=
 =?utf-8?B?bjRRcUNwQkkyYnRuV3NtQTNYdVBWenV2TG5JbzMyWU5LeXl5TlFablkwSVow?=
 =?utf-8?B?c2h2SUlsUE02V2J5TUVmb2k5OUJ2NncwUTE0RDI2SnlIb2pLZUJ6NGNDbkZY?=
 =?utf-8?B?UW93by9zZ3ljVTJGbGZDa242Q01UdE9yeEE0UlVRTDh3T2hLOXVHWFN2b2RT?=
 =?utf-8?B?bjFqeHVjK3FQK2VuZGVXaVd3eVViRnVlNXRBQ2UvVXZXbkRadUFEWVQ5UDNn?=
 =?utf-8?B?R214Sk56cGNOb1U0bkRobkI3WTBkZDArckk0ekFRaXloMnRCTExqTVR4SnNx?=
 =?utf-8?B?MmlGaVJ6VE4wcnYvcnp5TUs4OUp4VFUrbHkwbU9hWmFrS2F2M05LMHVJZGNx?=
 =?utf-8?B?ck9LT3hNQlB3MTVKYzlKWGp3K211MTJVUlNIdTVQeUdSZ3NuNCttTFlscmFw?=
 =?utf-8?B?d256c09VYzZOd2hydTVDbDAvOGM4VVFtS3VSUDNtQmRiRXlGbFFtZz09?=
X-Exchange-RoutingPolicyChecked:
	lQF6L3LZyRX9RDOccIfYlbbmzxpgC1P81JXcEMuMINhR5vJ+atlDN/JxKMl8+pjy6GJMVfYgssScgLKFvCHdRyeBABBhCmfiQwcwrBfgG5A2KdBKh/2OwWhoVAmQPZH9aLO5deaq574KW4OpgAgdyEwaW3nheJkAk3Y8Et/lkVbKm38Ena+kzlbZrOrfGem/UQ5GP0VBpqC3jLEUV7qlDSejJxbyefiVU1HxETNqxmmhqtLpMmAQVgirzyvlJ3ryfIUwPYC8kezw6FqDHp++HDlE9ymNcDm9NraD6/psvc8auEaKwELzfgvbGjllg/hDcR0Sq0ZSq51DbUfRu4p7og==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ixeca3F5AbOK480nX62g47ytjITEqICV2SR/ci0rSW1ceSe8FG1lNrSS2PmCg3MjbhpXocNqLcXHRdynTMLmBpUf8RciV33pEr8RPoaUgx5HCgjNkAsKT2n+gyBVuFFX2uXoMUnfgQcbgMhU1AGW5fOrNhOMSgEbmJVS8uzdxMmsGgFgUgky8xrcmQKP2b+i0Tgmbv9YeiIWmK5+I+K5zfVawoozIiYzB4BuSM6Z+1cW39SK9dGdcg1oJETRRGKNRCKxUOelWg2YIpXkPVn/ZJuA/FkNFx5GaeTJJXEisifXE9idGiQou6wWStoxVB3tfwPtXeNdgalvlvzFintxE/opN9r2wixbjNBmSdj8doYpjugQjHJn2wOWT9vvefeMNEqpHTHw4/lQucWBwFbbtmngwxqnNiQAyqbDQmQNXuYt1T8+4BwvvRASgmPRTtHhB0l4wRXEuHr/3PVXoqh+2EiPnlaMWtsc6+YQaJRRGXVW7CdMFIUl/f8tUOMrA1daxMJRyboe9HmthDrUEPU0Ppt2FY1bAS9jK2tErdCoihsPjQaDxEnU2ImDIvoHin2dVYSESnxVKbFiHCkIsuyMm0us0H6A2ToQ8fB3goUpgPY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2598abf-3dd8-49db-7f8f-08deaf9473dd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 19:35:26.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7noIjF1hFcRCVv0sQ5+okGFT9oQrH98ZPFfEkHSqn4UMdgATxnOztbLDpR1ughyv3gtw2kjvhrTrMSiPhpgPSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605110206
X-Proofpoint-ORIG-GUID: 7xTPPQsbY8oBkpVwCmBqWG--bncmNo_z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIwNyBTYWx0ZWRfX8fSMRHH4U42N
 xefGCUE1ieaW8MvcHfhqsGHywvXljYFh3Kdf+VkRTA00yjeu6KiKl5Izv+38NJ3vZ7MPRhjhPQo
 uXQx96ud0dSa323Jq6nxHRg25ewtYWdvjSO7WW0+qpPEJgsjFjhOYChA3zbkbC6n+awTDLOJaT9
 TsmMSFcpdNaHxGfrrtUiHN8gQmqGmz0adwg1WDGUyP57pZfA+MYlk9nb8p6CAQwl0L5zgOh3YWk
 OiRXgODxQCqRmjFMTNEaaDGWiBSrhvHdztIOLfHQnOTgNveF5QZH5ob1t4VshsCgifTnVkBLa6P
 d96/VuqzZAA24lnMIWuYD62fxZ5wgJnQHPDxFfeQNniqimSn0y9Kf4lFZZYAHkXR3qIxwDrExPH
 mJ1lj5t2gRn+6hfRmX039dINJFd/pO8CBaL0CvoUCYD3GR3PKm2ytPqVIsmslr27Z1bOM7oKuVK
 DxqLx5BpT1V+aTEr3kA==
X-Authority-Analysis: v=2.4 cv=FpA1OWrq c=1 sm=1 tr=0 ts=6a022f84 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=NEAV23lmAAAA:8
 a=cMSsWa0dAAAA:20 a=INSfb2NpcGS0rHYRgigA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 7xTPPQsbY8oBkpVwCmBqWG--bncmNo_z
X-Rspamd-Queue-Id: 8BA745152A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21474-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

This email announces the official release of ktls-utils 1.3.1. This
release is a FIXES release based on ktls-utils 1.3.0, which was released
in October of 2025. The fixes include:

 - Fix dual-certificate regression in keyring-based cert retrieval
 - Restore QUIC session ticket handling with current GnuTLS releases
 - Send fatal alert when server x.509 handshake configuration is invalid
 - Detect missing ML-DSA support in GnuTLS at runtime
 - Plug session leak on x.509 server handshake error paths
 - Fix systemd unit installation for out-of-tree builds


Official source code repo:

https://github.com/oracle/ktls-utils/


Release tag:

ktls-utils-1.3.1


Release artifacts:

A source tarball created automatically by GitHub:

https://github.com/oracle/ktls-utils/archive/refs/tags/ktls-utils-1.3.1.tar.gz

A source tarball created with "make dist":

https://github.com/oracle/ktls-utils/releases/download/ktls-utils-1.3.1/ktls-utils-1.3.1.tar.gz


Issues and requests for enhancement:

https://github.com/oracle/ktls-utils/issues

-- 
Chuck Lever


