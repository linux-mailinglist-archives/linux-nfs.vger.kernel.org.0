Return-Path: <linux-nfs+bounces-5092-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BE493E040
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 19:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D84281A9E
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 17:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05EF1DA3D;
	Sat, 27 Jul 2024 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i8Cr2Q4Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CU677MoF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0D538A
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722099652; cv=fail; b=neERc0fQKG5+yYTbpn5Al0Y8JKIM326PsjLhbSkdk/MuG/NfFjJPfvTnJ8eU8LS/gXBQshvCLTngTWuPQsa/GKtyoBZfMXg+4pcrX/9ggdFSlzD+qQhHM3K1BQzBUmhlBWi3LFp5ybGjCMow/I2HIDbdk2nkCPBL+1mxhNBpH2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722099652; c=relaxed/simple;
	bh=/LqrsMwJo8fv40M7Hg5mpZxg28k+YxWyS1M0o9yi8UA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gIR9XVetUOrXtKUSox752iPK4GzfClnY3RmL7oPCYRlWXXkCfbbhbihtoIj2hikW2/7tDbEbr/QvWjkPAjPTpQMIhGBgRuVaerb7NhAAojLsbdnTGjAVG5CC4x77J8gjegvlojcscdIpUu4pYdYFbZjEjUNqwoG63iF8sdvoRxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i8Cr2Q4Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CU677MoF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46R6lNGx006183;
	Sat, 27 Jul 2024 17:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=7CMC7CyYjHUiE2ipK5/nsW6Ao1RrAGgPpZO1a61tB5U=; b=
	i8Cr2Q4YoeZEkqaXiabJnYnLfD29TvB+vWkCl+pTug+kBeaav81Y0BYzvHSXk5Dz
	xV11AVAxZQvXgz61vMslnsV28F+tG+SHFDAxBqXqMDnFEAK8Q4pTKkuFxQW0C+qc
	MjoipAQ4GPjWG4jPifhQTYnU4lmQ5wX0Ec82z+Lp55+9PNdOD1SXCkJoxaXOrstt
	vigm0zuD6t2yrfjFOFEV7fdXegJaoPPhqZgTkzewuwynMnIXj/b2+6Zq/lFzO0v6
	vUWwqDOUZq+X2s8RXLSfEmwfHK3LrSn4V8Pwu5qE1jCwREx00bj2eve0EadYGzdu
	muQ4lzA9xXMNIKCiuVaSVw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8gehg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 17:00:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RGJCAh021152;
	Sat, 27 Jul 2024 17:00:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40mqb6wfcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 17:00:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRJvD7j1KnHYciogRXOJKPbAkQtNFPKSCjLITBJ5grCnhf6F9UNyOA7zlpFY/5VfSTaJDGpVSUTRICmZ8mnPo05DV0Ei+7EiNDPWVL+zBWxQk+dG4vpdLn9HBcuSFH8lVg4vB1Tx0Rd1PH23IXolDZZbFoXqQX2+M1+pAv6OM3nd6O+BQmyLFsbLtoh1CMfcQWQWM6rtnDIsym+T0KebFL9K8beN+YWgEAnLoTQTA8Y0EfAHSiAQ/Ikl/Yy1ts5Sv+PORjFmO4toO66s7nNepEh08gJjj/omwWVWr+iZqa6vIyrx7zMDUbQj5Vqk7tSVYC7x5v5FZcHIQwPBZ29yPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CMC7CyYjHUiE2ipK5/nsW6Ao1RrAGgPpZO1a61tB5U=;
 b=Bco5Z13I3JhyAOZSY7Q25XjODj75v5e2IvUzJMHYIhb2vgHrdWbmJ+sS69EecDMBZjbI+RW8Iouaz1usaT4k2kR10ZX01GgY8IcJsKbW/HUI4K+FXTX3fXWrkSEWEpMZabqTWhadLmHv4FvI8ChGiyh/rQ9Vapz53I+QlnnBvDgFSwmmQEDZgrTjwR0eJyKYsY6Mm+NwHaLTw6ejKNUjWHnVAeDsd/ANVC3vBf1aaAPIdphFaGMAe2OOW0TTEAddn8jbDIhx3O4+CaU/iecJEcBZ+buGKRHXsZhuQYuTiSa+7BWzy5Dfpf6zzVy88N9n9G5slHwqkQKJt1xNcrPTnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CMC7CyYjHUiE2ipK5/nsW6Ao1RrAGgPpZO1a61tB5U=;
 b=CU677MoFrXeWQJoXVTA3xMpWy9pelq/GNYjuS+GbCJKCvyQ0Ebf2cSxCKHCoD5MCRwVW7ZfGJ1ZwkG0Ft4LOdN5jf8xDdCTivTVm3sb9SS/WPw+V7VAk3qJkkZee8h1yyrC3wQsNajdsjLLYD3su+CbpTAATT2dPs4eXOuE4Goc=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH8PR10MB6454.namprd10.prod.outlook.com (2603:10b6:510:22e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Sat, 27 Jul
 2024 17:00:34 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.7784.029; Sat, 27 Jul 2024
 17:00:34 +0000
Message-ID: <cc923db4-7ccf-47eb-af10-c77d7f50e5fd@oracle.com>
Date: Sat, 27 Jul 2024 10:00:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
To: Chuck Lever <chuck.lever@oracle.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <20240724170138.1942307-2-sagi@grimberg.me>
 <ZqOtYYV2rQ7ROqXs@tissot.1015granger.net>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ZqOtYYV2rQ7ROqXs@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0122.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::15) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH8PR10MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: e921342e-ca30-4b71-39ba-08dcae5da156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVltZ0hCOUkxSkdyMk5POE5EUEFmTlpEaDZ0MVBQVWhqMkVnSzk3NlQwY290?=
 =?utf-8?B?MlNjUlZRTE4xNFVkbVdqc3ZPY1had3RVazM3Q3hWVjF0N1g1aUozQ3pZK1Rv?=
 =?utf-8?B?amhQRWVtSTJ0QjhYcVVmUzNlUU1pM3lhbW1ZWkkrMlZWdzVraHl3dXlVWmxk?=
 =?utf-8?B?dzloMkRzSGJldlMyMU1JNW8zVmx4OStQenNVbUV0ZHI0aUR6MDA3MThZREo4?=
 =?utf-8?B?WUZCOGplc3FyQ3ZDTUpBbWRBVFVYNFhZenV1Zmp3SUdnMFZwNm9iZmZ6c0V3?=
 =?utf-8?B?N2ZJVGZZcWFqZWl4aW5CTit3bG5reGNSVzdCQjdTanF4WDVIazE1ZzlqSFhR?=
 =?utf-8?B?dmlFdTl6SGloOTJDTVhaWGNqczdZQ3F2bzdkNHZOVWJMUUFqVG1zZXduYUU4?=
 =?utf-8?B?WW9RUDhEVGNnaFRlcmlIWkRIaU5VQ3hOV3RWUW1jQ0RZSSsvOHJuamVTa2JP?=
 =?utf-8?B?NTFkSmlQOCtTTEJhc2NPZHZROEFZTzc4Mi9UOCtvZkRQcU56b2lkRTN6TjNJ?=
 =?utf-8?B?WnNLZERQellESWg4dmRwQUlXbS9Ia1pTWU5mSy9JbkFzUUowbWdMYTVKOGdw?=
 =?utf-8?B?b0ZZckdmNkw2MysrLzFzUzl2bnI3VjIwSkpya3FUTXppOFRCdVFxZTRweFha?=
 =?utf-8?B?MUV3ckRKRWpFQkMxVlBpYjF0SVZBeTRtUFcxL0RrRVYvdUs2RlZ5TVRnUFIy?=
 =?utf-8?B?RkpmOEFPWkY4UXA2TUk2YisxL3ZBakxOejIwYmZEcUhnTjQ0ektNR2YxdERV?=
 =?utf-8?B?c2w2VExYZGx2T042WXdYVEVKMWw2ZG5XYi9BUXNkNGtzOC8yZjg5RFhWME45?=
 =?utf-8?B?cDlFU2lZWXllWGdKSmE1cHFPM00vM3ZzV1FRNUh1ZDVHQVY5eFo0aEFCbFMz?=
 =?utf-8?B?TUtoRGtra0FRNjRnOUZUS1NjR0t1R2lSbnFXWm4yaEJ2SStZaE1ueExXbWt5?=
 =?utf-8?B?VkIyOTlLTjlzKzRQQTY5ZFVmZGp3VDVSN28vUDhtMGJJbmFkN3dlZFN0Z3Mw?=
 =?utf-8?B?eXR2Z21CT0k5Vm1LWXg4cXhjSCtIbk1LR3cvQmlYNEg1bHhLWDFCckVZeEYy?=
 =?utf-8?B?RkVTU2ROYXh2cTdkNmhpbUtKU0NjdkhTaXdrN25KY3l1TG9sWTBQTEtrbmdE?=
 =?utf-8?B?V1k3UURtaHZrRFd6aDVDSnY2c2Qza25hQkZxbHB4SnJ4WUZrZVFtQm52cE1L?=
 =?utf-8?B?eTUxWFZUclVDOEJBQzJGekQ5OXNVTnQxYmo5LytXWGttYm5uY05uSXNlajk2?=
 =?utf-8?B?N3J3dmFLT0UwNWxqOGF5eEpHb2VxVnUvRi8zUEZsclQzOXNpMlRHaDNWMGRY?=
 =?utf-8?B?TEZmVklOTVBGbDlaa2VnUitidDFrT1VhRW9kRzhKQU5LdEhDRmhIWEJIbW45?=
 =?utf-8?B?TGZ1Nys2c20rZi9sSjltK1hjN0FmdFMwZWM3b21LK1gySVIxemgveU9XS0NT?=
 =?utf-8?B?U1Z3MEFIMGw5SWRNWmsxWm41K2dYMlpEbnlJRFVESGx5SnZYcG5ubEFiWWlS?=
 =?utf-8?B?dE5GZ3UzN2lVVnFKMnd6c2xWUi9WM1ZiLzFUWU9aRkFSYlpzRHdBbGk5ekdI?=
 =?utf-8?B?RFVBdGhjT2Nrd29QdkxxMmlTNVJjeHYwZ0luRzVSTlBuZmNvVmNxUlR4UGZ6?=
 =?utf-8?B?emJPYmR1bnhOZVp4U2NqNEExc1FGN3RRb1l3V2p4aGRpeU1RSEVFRU14MkRV?=
 =?utf-8?B?NndjdWM0VFdISTFhYlJHWUpOQ3VuWG5uSXl5eE4zNW9sWThNQkJZNGF0R2lh?=
 =?utf-8?B?eDRRWE53ajllWmtMd3p3NU5ieVlxVTEzNVpuR0dFV0RIT1dwVnBUencweThH?=
 =?utf-8?B?b05ldkZWUE1qQW5Veis3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWVrdVZMTkJaUWlMN3dEOWF5TUtBMC9wdmtGVU9EQnM1eVFRWURsUmdoaGwx?=
 =?utf-8?B?K2FaSjJzVnI2WWg0V3dPL3dKS2RTeXJlTFdNOC9jSTNnbHBaZGVneC9RS0dy?=
 =?utf-8?B?ZkNpekZGVnFHTkd5eitFN0RML2pnaG10aTgyYkRubG1nMS9lbjFvTGFiZXNT?=
 =?utf-8?B?ZTN2dEF4UFFqUXVhSWZxb2tOdnVWWkMxVEpzdGsxMER6TmpLbWRWdXN1VFVm?=
 =?utf-8?B?NXl2Qnd2RjcvMWpMd0QxelZCd1pOR3djZ1NWaEdyM2ZhM0RTb1U4Vk1YRGQ3?=
 =?utf-8?B?bWo0NTZ1NUMvTGFIVys4U1JVak80amxOV1BweXFTVy9peGFqMnZtQ0crZ3FE?=
 =?utf-8?B?d2o1UXVCem5FOGVNMmJEU28yakZOV3Fkc0dYWk9IdC94QXgwMTdBczlGRUg5?=
 =?utf-8?B?Mi80NjV3bDY0SnZrRi9TcUtKbEk4T3JkRW5rdEhDd25jNVYwOWNMQ0JiUVRO?=
 =?utf-8?B?SkYrTHhDZjU1UVdKU2VLYmZXVDRNYnI1VFBtMkcrandXcFNiREwvZTZvcmFo?=
 =?utf-8?B?RFZBdU4rR1pYZk5BSlU4ZS8rNzFCYnJaeUR4UkZvN2JZOWhncFNaclVURitD?=
 =?utf-8?B?ZVlNTitCeVorRkVSK3pCbVVqYUFiYTN5ZFplQ1VrMEYwVUF6eUJPQTRya0Rx?=
 =?utf-8?B?T3oyRUVQTFlDY0M5SkQzaldObjl3SG90NG5ZOHkzTDU3NEJTMmpNb05YWFFQ?=
 =?utf-8?B?dUNCMkx4MVlxeVdkZWtCZkxEL0dEWTY4enlQb3h4WE93M0lUL1Y5aWlPZE01?=
 =?utf-8?B?M1k4L09aWTFob25HYmMzcXFQZFNGV2U3SWhWMkRHU2FLNjZYaDd2TDZKSTBo?=
 =?utf-8?B?K0M5UHFrTzgwZkZ1aExCeFBEZkVPcmV3SjhpRlUvTEFUS216R1JOd2lxOXU3?=
 =?utf-8?B?U0ZuN2NUSTJJYzZDQkFHRVhvMFF6MnBEV1I4eWphOHdBTWpjVlVjQzlrVWp6?=
 =?utf-8?B?TFdHV05ydzdlT0xaUFFibUpoZDEwRHNNa0NpeCtBMEZqMG9tbkVRODhHSXVL?=
 =?utf-8?B?YW9aNkhGQm91VFJrQzVpaTZqYTNGNWk3cEIvMUhNYVl4TVdOMVN5Zm5FcmVF?=
 =?utf-8?B?eXJzNXlLMWhkMEtEK3JsS2JQQ0hZWHFoaEVnSktxZ0VUM3BubFBDUTBNTC9U?=
 =?utf-8?B?UGNHSXltZVpQa0NwNjVjNDMrRkdHQURuVTRQUW5Ja240Y2htMWVXRVgvcGVV?=
 =?utf-8?B?a3VwWmhwd1dyMy9IT1lBOGVGdk1kUHpwdi9JbXlQdVlTN1doT0JLdkFtY1BM?=
 =?utf-8?B?OHdZdHJiWkdxMGNUYVdEemltNUJkL1FuS015MW9QSjdRTjFLMnRjc1FVc1BW?=
 =?utf-8?B?RFJhQ0tqTjRaYXhsL2VpSlozazRBNmdZWnMrNTZwbzQ0MjNkUVRlWTJWM09L?=
 =?utf-8?B?dHFmeFN5L1J0aktqMURFVHVqdXNEYmk3QkNaemtYTDVpWUIvUHNQdnFYbE9N?=
 =?utf-8?B?eUd2eUptT1dWRkFrVXdFVE5VZnd5TFFSdXNabkRrK1lteEd6cnorU1ZVVXFj?=
 =?utf-8?B?TWRybGUrZWl1dzdYNWhaOE14VUUyaUI2Z3dlNzVIMCtXS1RYT3o3NGc4L2Ri?=
 =?utf-8?B?S1d6dkNYZjFPRVhTU3VXam9lYStwcDIxVnZhL3RKSUQ4cFkzajQxWG1EL3Vt?=
 =?utf-8?B?bkxSVndCK3lBYVZlVFVEMXJSTkowQzhxcDFsZW42cDJLSzRWRitKUjVpa3I1?=
 =?utf-8?B?bmJ2UUNwL0swdXlSdStteFVQVWRNaVBINkR0ZTRSV3JBcTFHOEJzRlMrekM0?=
 =?utf-8?B?Wk9pR3hSVmFmd0t6K0IyYk9tcDVkcVN5L09kZnU1QVErcHVBS3BZTWZ1Yjdq?=
 =?utf-8?B?NDkzOEdDTVBhY2FmTi8yZnlmUEFEVk45MDRtSHVqWWNwVW13TEFwd2JZZlo2?=
 =?utf-8?B?N3pHQU1yRGtuY3FqeUN0RURGeDQva2JRN1g1QVY3WW0yeXdidlIyQSsyU3Bx?=
 =?utf-8?B?NXJLNDJRbmhtUEFPTXRKcGtKMU94eFVhWXZWQU1BdmwzYVZ6RitqTzQyT2xz?=
 =?utf-8?B?dHVaUldReHlYZDRXbWZqU0QxLzNmTkM1MUcvYW5CMHl4eXVzOG96QysvZVQ4?=
 =?utf-8?B?eWxleTFCbEVaYUFLc25GclByMk9ibDVZVngwcklPbk50cERoMkpmODcvdkYr?=
 =?utf-8?B?ZlRBaERNVkoxQnZ4UEdPbU5mdjNyd1dLVnRoZHFTeXlDNHd1UzBEbmZyeFlz?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pjxonj7GJFLwBezo934KAxgtsHwgG++2uQ/2ZT5QA0qFnDDeYpPOTQSEnE8/gHGklZuD+lerwmu/6fCOeui48jrY1JP+h6d82RMYT5bgBsGzfs/Adx10tsXfbvOk6w8mU/M+6He5Llx2uYbe2tyl7i29lcH3gqWdXnvAa/lX1NEIhxEfaTfDI8WxW91UXlCdCEhd3o/CkK+CZQuA3MoK3/6ZqRIEkYvist7aMRibnm2OXMnOEvXUYygO5RPeDd/tc3FzfNu5K93yAVlbykSB/rgaCnLkZRgXvJZClqurcTmjrrOZaLDcLPSH37FcVKg+DjQRRUW4Db/xeg/4Rzclyb/A90ntGha8ZfSVKEZDLTK69MQGD0bkCZIWs2VqpD++4RsJRJB0Nm1T93s+ncqc+mtkKVJIYolUcPVwRNUzZRZ3beN7SZXbJdc8o7PtvX8FZZCSKFTeu/ppQopvXuxB5yBS1B4riL5t5vGmNXkBx0trSwKJQ/cV9xlqIz7eWHWavUV5RwWbkEyNWVWSHOQwKKT+LhTDpdTpnxrgSIqVJgjGzJ/Pi6jVTNNTKwC6skT5Q6tRsGrCaWXLoIqaax/BKvsP6bbvekKi+RepFCDcr2A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e921342e-ca30-4b71-39ba-08dcae5da156
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 17:00:34.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsy+UuvSH6Sfd5YYzIoYSKxeZfX6BGb15eFRjYiMYR3A37YLo1CRpNs4cnDRik1gJBiXZOzuV6zwPeUGRDgFGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407270116
X-Proofpoint-GUID: aEsHKUEOukZ0cAYLfobWUQ44U2k7Ul4h
X-Proofpoint-ORIG-GUID: aEsHKUEOukZ0cAYLfobWUQ44U2k7Ul4h


On 7/26/24 7:06 AM, Chuck Lever wrote:
> On Wed, Jul 24, 2024 at 10:01:38AM -0700, Sagi Grimberg wrote:
>> Based on a patch fom Dai Ngo, allow NFSv4 client to use write delegation
>> stateid for READ operation. Per RFC 8881 section 9.1.2. Use of the
>> Stateid and Locking.
>>
>> In addition, for anonymous stateids, check for pending delegations by
>> the filehandle and client_id, and if a conflict found, recall the delegation
>> before allowing the read to take place.
>>
>> Suggested-by: Dai Ngo <dai.ngo@oracle.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   fs/nfsd/nfs4proc.c  | 22 +++++++++++++++++++--
>>   fs/nfsd/nfs4state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/nfs4xdr.c   |  9 +++++++++
>>   fs/nfsd/state.h     |  2 ++
>>   fs/nfsd/xdr4.h      |  2 ++
>>   5 files changed, 80 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 7b70309ad8fb..324984ec70c6 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -979,8 +979,24 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	/* check stateid */
>>   	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
>>   					&read->rd_stateid, RD_STATE,
>> -					&read->rd_nf, NULL);
>> -
>> +					&read->rd_nf, &read->rd_wd_stid);
>> +	/*
>> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
>> +	 * delegation stateid used for read. Its refcount is decremented
>> +	 * by nfsd4_read_release when read is done.
>> +	 */
>> +	if (!status) {
>> +		if (!read->rd_wd_stid) {
>> +			/* special stateid? */
>> +			status = nfsd4_deleg_read_conflict(rqstp, cstate->clp,
>> +				&cstate->current_fh);
>> +		} else if (read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
>> +			   delegstateid(read->rd_wd_stid)->dl_type !=
>> +						NFS4_OPEN_DELEGATE_WRITE) {
>> +			nfs4_put_stid(read->rd_wd_stid);
>> +			read->rd_wd_stid = NULL;
>> +		}
>> +	}
>>   	read->rd_rqstp = rqstp;
>>   	read->rd_fhp = &cstate->current_fh;
>>   	return status;
>> @@ -990,6 +1006,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   static void
>>   nfsd4_read_release(union nfsd4_op_u *u)
>>   {
>> +	if (u->read.rd_wd_stid)
>> +		nfs4_put_stid(u->read.rd_wd_stid);
>>   	if (u->read.rd_nf)
>>   		nfsd_file_put(u->read.rd_nf);
>>   	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index dc61a8adfcd4..7e6b9fb31a4c 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -8805,6 +8805,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>   	get_stateid(cstate, &u->write.wr_stateid);
>>   }
>>   
>> +/**
>> + * nfsd4_deleg_read_conflict - Recall if read causes conflict
>> + * @rqstp: RPC transaction context
>> + * @clp: nfs client
>> + * @fhp: nfs file handle
>> + * @inode: file to be checked for a conflict
>> + * @modified: return true if file was modified
>> + * @size: new size of file if modified is true
>> + *
>> + * This function is called when there is a conflict between a write
>> + * delegation and a read that is using a special stateid where the
>> + * we cannot derive the client stateid exsistence. The server
>> + * must recall a conflicting delegation before allowing the read
>> + * to continue.
>> + *
>> + * Returns 0 if there is no conflict; otherwise an nfs_stat
>> + * code is returned.
>> + */
>> +__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
>> +		struct nfs4_client *clp, struct svc_fh *fhp)
>> +{
>> +	struct nfs4_file *fp;
>> +	__be32 status = 0;
>> +
>> +	fp = nfsd4_file_hash_lookup(fhp);
>> +	if (!fp)
>> +		return nfs_ok;
>> +
>> +	spin_lock(&state_lock);
>> +	spin_lock(&fp->fi_lock);
>> +	if (!list_empty(&fp->fi_delegations) &&
>> +	    !nfs4_delegation_exists(clp, fp)) {
>> +		/* conflict, recall deleg */
>> +		status = nfserrno(nfsd_open_break_lease(fp->fi_inode,
>> +					NFSD_MAY_READ));
>> +		if (status)
>> +			goto out;
>> +		if (!nfsd_wait_for_delegreturn(rqstp, fp->fi_inode))
>> +			status = nfserr_jukebox;
>> +	}
>> +out:
>> +	spin_unlock(&fp->fi_lock);
>> +	spin_unlock(&state_lock);
>> +	return status;
>> +}
>> +
>> +
>>   /**
>>    * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
>>    * @rqstp: RPC transaction context
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index c7bfd2180e3f..f0fe526fac3c 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -4418,6 +4418,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>   	unsigned long maxcount;
>>   	struct file *file;
>>   	__be32 *p;
>> +	fmode_t o_fmode = 0;
>>   
>>   	if (nfserr)
>>   		return nfserr;
>> @@ -4437,10 +4438,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>   	maxcount = min_t(unsigned long, read->rd_length,
>>   			 (xdr->buf->buflen - xdr->buf->len));
>>   
>> +	if (read->rd_wd_stid) {
>> +		/* allow READ using write delegation stateid */
>> +		o_fmode = file->f_mode;
>> +		file->f_mode |= FMODE_READ;
>> +	}
> nfsd4_encode_read_plus() needs to handle write delegation stateids
> as well.
>
> I'm not too sure about modifying the f_mode on an nfsd_file you
> just got from a cache of shared nfsd_files.
>
> I think I'd prefer if preprocess_stateid returned an nfsd_file that
> was already open for read.

There would not be any nfsd_file that was already open for read since
the file still has a write delegation on it, unless the open for read
was from the same client.

I'm also not sure if a client would send an open for read to the server
when it already owned the write delegation of the file.

-Dai


>   IIUC that would mean that no changes
> would be needed here or in nfsd4_encode_read_plus().
>
> Would that be difficult?
>
>
>>   	if (file->f_op->splice_read && splice_ok)
>>   		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
>>   	else
>>   		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
>> +	if (o_fmode)
>> +		file->f_mode = o_fmode;
>> +
>>   	if (nfserr) {
>>   		xdr_truncate_encode(xdr, starting_len);
>>   		return nfserr;
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index ffc217099d19..c1f13b5877c6 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -780,6 +780,8 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>>   	return clp->cl_state == NFSD4_EXPIRABLE;
>>   }
>>   
>> +extern __be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
>> +		struct nfs4_client *clp, struct svc_fh *fhp);
>>   extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>>   		struct inode *inode, bool *file_modified, u64 *size);
>>   #endif   /* NFSD4_STATE_H */
>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>> index fbdd42cde1fa..434973a6a8b1 100644
>> --- a/fs/nfsd/xdr4.h
>> +++ b/fs/nfsd/xdr4.h
>> @@ -426,6 +426,8 @@ struct nfsd4_read {
>>   	struct svc_rqst		*rd_rqstp;          /* response */
>>   	struct svc_fh		*rd_fhp;            /* response */
>>   	u32			rd_eof;             /* response */
>> +
>> +	struct nfs4_stid	*rd_wd_stid;		/* internal */
>>   };
>>   
>>   struct nfsd4_readdir {
>> -- 
>> 2.43.0
>>

