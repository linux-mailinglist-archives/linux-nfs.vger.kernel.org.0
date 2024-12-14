Return-Path: <linux-nfs+bounces-8563-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3386E9F1FFB
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Dec 2024 18:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBF2165B98
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Dec 2024 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E631282F4;
	Sat, 14 Dec 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dfgXPxEC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FGjWGa0T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F252C95;
	Sat, 14 Dec 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734195791; cv=fail; b=hqDQsSA2koEPmtPOIIjfIPNuwSK8fKtEFupQOW95DfKalnoMfIgR+tW/hlpSBbMvp4bhJ5qgdTzMrhQOpuCOkcglTC4pGkGV+nmazfC9KsHKGUErH2hUzc9JrepGCsTpnB+qhzH7NkbMZOxBTqdJ6pqnXTkJstiDdw/83sHd0YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734195791; c=relaxed/simple;
	bh=uKBq46iS7WnlbT5aaf9GYY3RYVZm5fYMFnAI4GYOYb8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fD9rr6jXKxOWJTC/BBkwmE10v42Aw+qh5G48gFD4IVIjLvneqDFje9TXfU1WcSygT20NAbC33uG1J/JfS5wZXyiRKhPaHPSK43J5eIm5rJ0Hwh3llNa+zwrXzc7x8mnXcimoCWqDiq4hA+oP0jugrqxdKDulzqxJtkfRtm8KoPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dfgXPxEC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FGjWGa0T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEEjneG013307;
	Sat, 14 Dec 2024 17:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=A943OmcjZtA9jdSUWE0SkSCIw84FIBeN0RU1HDnFiCA=; b=
	dfgXPxEC1tTP/hrX3Zb6dMZrp9rkmme+D5dDBshLxRoGF9qJ5VstSvhtkn2A/f6h
	WE8CZGhyF6xT/wQgZM+H0BsL/bbV4QF8mfGFmZh6Ajxr7zE1O2NIBDTqV5XeP7Vj
	eNLsEEyJ6BJIy6E4gZjIbdS9rec/I3Oh6lGgRhFbZqjmZ3XjXgRkGcHwyZlTfBhA
	DwkYQQa+U4kKWYwYB6upyiZQ+f7ju+1uQDXmUaRD2NLNUQr1qgCW88PrYEzuAL6i
	jviEGWER8zN/OZiJLqRsewHM6lyEUH/DNi0t71f8eWAQk0Oq8YhpvywaHj9Ka5dy
	HNfY5tRlHX5m65ex15EJ+g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22cghq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 17:02:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEFWKOq006390;
	Sat, 14 Dec 2024 17:02:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f6nd18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 17:02:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C915ZNmN/sFcnxXKhNRgWvkWg/M2XVkmwcbf+RcR5WpGOAGHCLU9sXLZUQjtw8N9IhJdjCkUorJhDnt1Dw3fRDZkv6IslLj/yDSvokcUrnKAPW58zU0pJvEnUQvo/87M8ch1Q0cIi0PEHW0+wShn+WafPIvM+UChaUgOvZWJJq7qArH90efU+d3/fLX1oSCJiIRdm9ozrGb2BzF2wLjOurPfZUHlAIf8MwSqLBn2jdnCdn3ZbN2liMlBv/F37eph8ZLBPtVau26LDHv8GpjMgqLMb2wFytAnSWdE8G93gyZulRum7NyEWrEx1KY0VssAYZ+nlpN2Yxd1UmohMe+7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A943OmcjZtA9jdSUWE0SkSCIw84FIBeN0RU1HDnFiCA=;
 b=t2R7WE3rHQqw02N3tr5ifW2RQ5STFPc3ZR0hCMFNL5Lh45Dj8lyTKJ4CJ9Wk4/mtszRpau481Jg/B20YyzqjyUV6rBMgNZFlovRQRPWaBZ08A3tryfOo7EUMDb1cK6V6IOKe6hMySELBxtZEkTK5EDkgBgSzRZ6wKMJH+OSN2/t/fxEwnVzU4DbPqt/6KaxooILS/6iS5pBK35pu7pVZp9NeMmJbvVO4Hk3YPGwI5mkCZ8DYYDjmEE0GK9wmac0ts8JXFY+zGCNljU0v9evBO1XHU233VGBKQoUonUULCyoFz6NRkBHO0QRW1hpXs8hH4U2em+V2lPzWj5iTsoRDdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A943OmcjZtA9jdSUWE0SkSCIw84FIBeN0RU1HDnFiCA=;
 b=FGjWGa0TcT7KHAIlNO5SbELbXeFIRAJ39k6txwaAl035pXeg/u+ifHQoyQ/kfkZ4xVEmjxpP29+M7X+CqnnLxwFdP4N9BWQ6RYO2kby/8f4yJpLnlVd0EFq75mVcWRFsdtBr1QaNsutg3TmT7WujvpNyIm4GEjolS5MWW4LJbPo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB7005.namprd10.prod.outlook.com (2603:10b6:510:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Sat, 14 Dec
 2024 17:02:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8251.008; Sat, 14 Dec 2024
 17:02:52 +0000
Message-ID: <09a8f219-c639-4fef-b3e5-44e030a76c24@oracle.com>
Date: Sat, 14 Dec 2024 12:02:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] nfsd: handle delegated timestamps in SETATTR
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
 <20241209-delstid-v5-9-42308228f692@kernel.org>
 <2a3c0a1f-0213-4915-a4c0-a2ba31ae1bbc@oracle.com>
 <f697868bfa7f219d51ba8251db32b22ad942ecd7.camel@kernel.org>
 <c4835f2b-0edd-49a2-9f61-5bd7090382dc@oracle.com>
 <f2284ade0fcda383c29a4be58a3d0eb012bf5ec5.camel@kernel.org>
 <b45404d4-cbf1-4f42-ab74-5868ef7fe895@oracle.com>
Content-Language: en-US
In-Reply-To: <b45404d4-cbf1-4f42-ab74-5868ef7fe895@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:610:55::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 20496f22-81e5-4b78-3f65-08dd1c61254e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWF3WGhpazZBS3VuWmVKYzFJNGV1RWloUWtLMkU0SjJGRVRKSm9Rd2NNcGdG?=
 =?utf-8?B?M2lSaSt2eW9GdXdwY01QenZMcCt0NDlwQWEvRWpIa25RcU5DRkZlSm40eHVu?=
 =?utf-8?B?MTViYTZxejYrckNsd29JYkJqZkZqY0FiemZUYnlLaEc4VVZEUGZDTHRUM2FN?=
 =?utf-8?B?R01NaGpvSnRjZkFxc1I0NFpIOVlUQTQzUi9zclNjRDNCTHFPdU8zWFJNVVRh?=
 =?utf-8?B?NEdzYXh2QTlsQTNLeHBNSnJBdGZtVzNGSTh1aXZLMkVNSUpkL29lMGlIbWh6?=
 =?utf-8?B?eE9paGNMNzdnVzcxdEFCTEg3bnIxMGNJanhVK2J1SkdzNzNXRzJ0SzNqUWFI?=
 =?utf-8?B?RStkTElnOVdkSmREOHlNMzFxQUszZHB1ZC9VNmV4QWhuL1llUlUzTVhDd1c4?=
 =?utf-8?B?T0tKZEZpeDV4TXUyaDdjaFFqRVdHUXJlenpKckZLQlFHb0RSd1RUY25BSmdT?=
 =?utf-8?B?K1FUQXUyR0N5Qit6dnlJUmlBajNjU0V0MjlYTU4wWjRxenlTTUI4Y0FveVRj?=
 =?utf-8?B?cktHakR4Tmw4ZHRpY0tUY04wTkhmTDg4cTEzOUx4UllrQ3BJeThpTDVVUUV6?=
 =?utf-8?B?aDJYd1FrVzRLZDR3V0QvMHZCNjBCV2dhZzhtWVU5eE1FMVJLdXNXQzdlTXJp?=
 =?utf-8?B?Qm0wNW80VURYY1FoUW96Qi8xK3pqVlk3OVgzeTU0dmlmUGV4NFNaZ25LSzdp?=
 =?utf-8?B?dkZSM1NTa0N5VFh5M2JvY1A2ZTRFM2poWmJJZUFJakZ3WkNxQ0dOZ21uN1JF?=
 =?utf-8?B?TDlFczU1YksxajlYSzQ5bk1iL1BQUzcxRDJVb0VrUmp5Qm1VUGl3OUlibEgr?=
 =?utf-8?B?SzJ4bDJPZnZLWnBRbWZtUDVkRTNQeDR5WlVXdys0eXlNS1Y2Yk9SYjMvdWVE?=
 =?utf-8?B?Tzh0bGUrVStEZTF1UXlRV2VvODZUU01LVjN6M1pDNEsrZmRyOURQM1FTRXp3?=
 =?utf-8?B?ZFdCMG1JUDdBdlRyejdSSTlHcDI4MHp0azRic2JwMmM0MmZEdkd3bnBzU1Rh?=
 =?utf-8?B?WTQ0R2cyTjQrN3l5K0xpc0tSWTdEeDB5ckhTS2Y4amdsZXplSkM0aThFVWFU?=
 =?utf-8?B?L0dCQ0tUREJpaklFOE5iOGtsMkxhZ3FWcnJZZEpjVHJLTGZ4WTM3Y0N2Skpv?=
 =?utf-8?B?Y3h3TklmNGhHWC9Bc0szN0dUVFhmS1pBaHJWc0tyenQrTE5kYUdDd3JEaGJh?=
 =?utf-8?B?dEdmUGVFL0pYTmUwK2M4ZGV5NFRwUENyS3RkeDdpZDdjc3VJM0NxbVo5aVNV?=
 =?utf-8?B?R1NDMU53eHlWQ0JWZ1hWZ2M4dXdQQWJxajViSGN1U2NhejZVVlhPRHJZNEkx?=
 =?utf-8?B?K05ldHVjY05VVC9KN2xrckp6cUdEcWdlM0diVldvV05Vam5IWEo5QmpqTUJQ?=
 =?utf-8?B?QTlZc3BFMUkwVXI5NTF6bUpGM3lmZmFvUUlYY0VyOEcyYU5tVHF3SDUyZHp1?=
 =?utf-8?B?T3pUVU9CeDNvcGZxbFZoV2ZXVUc2SmhsZW5EeCsvS1VXNHZqdGV6RitkUHZ2?=
 =?utf-8?B?TDJ5N0FPSUg0Y0VFanpSSHBuZDJ6elhpbE9adGFYcEpMVm5IWWljMWNvQW5i?=
 =?utf-8?B?d1FQZTF2NXNCcWJvOU9DNE5QQTlJTTBZNVZFa3Bza05UUVJnNnZYY1VLbEtY?=
 =?utf-8?B?OFJWV2UyVjE1Nk82MVJsUHBxQjFBbHY2MmtGMkhWK3ZRM2xBMVMxTVBIRlhW?=
 =?utf-8?B?M3pKandzeHhrSGNYazRhY0pGUmcrUmtvMnQ2T3hFdlB6OHpwVTVYVFVLcklS?=
 =?utf-8?B?akxSV1J0SlBHdUFXU0pkUFI5T0hIYlJKK2JFTGYrdkZXb2k1b3ZNMHlFSFFS?=
 =?utf-8?B?R2RYMU5RRW1XYmlaT1lBcVMwNUVGV3BkWkNGcDhlOHhkaUdiY3UxeVpaaHFh?=
 =?utf-8?Q?J8GGGWtvi6f7P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkhEY2lUcWtwUDR3NVdPcTh6eWJxaDA4RXozdFRjc0UwR3pTUHFuZ1RlRW9H?=
 =?utf-8?B?eERPNGJ6d2VVSXR3SENKYU1oZGZqaGc0aEw2TGJOMVIyNUd2VVo1WUJsS2NF?=
 =?utf-8?B?Ry9nWmpiMWhycnZLb3JEY3VZTzVzWlBQc2xFQnBwLzQ4TFg5YmRYOTQvUGtt?=
 =?utf-8?B?RlVPazJMaFRESHdJS0pmdFNDNlREOXNhQUM0TWcvbzRPT2hNbC8yaGdGV09X?=
 =?utf-8?B?d2hQbzU1YnpZRHVmaUZEcWJaMVJzbXZiK3pMajAwc2Q5REFBaHlkNDdEZHpS?=
 =?utf-8?B?Ky8xcmkxaW1wcUNaQ2h3RWNyR0JuUzdrZytTZkI4a2lkQTVHY3pheEJiTG92?=
 =?utf-8?B?NFl1SXRSb1FiSVRQS3pRSTl4NEc3bnZUK0NodzM2b0pVaUV6UEh1Qis3S0RJ?=
 =?utf-8?B?cDQzZmNsaFhrcmpaZ0NEcWF2ZGtZUlFaeW9RaVJuY2hJUXNjc1lCSGtETFkx?=
 =?utf-8?B?ZzR0bmMxNTJ5aVFKTzZ6YWpNMjRQSE5jdHJYMk9xbTFmaTR5YlU1RjBwbEg5?=
 =?utf-8?B?d0tOeGl2NFVkWnh2R1lGaVF3cjA4c2twODJtYW1IVmVFT0VrbWZoNU16Smxo?=
 =?utf-8?B?N0ladTcrK2JabHZySysrbU1SQUJ3bzNxdmFoNlpVVFdEaXFLaWF2MWRpTEov?=
 =?utf-8?B?MHl1dkMrSmFFcUV3dlJkZXArcUM1a0t5Q0RyTU90Mzl5S1BOOHpLeGJYMFRB?=
 =?utf-8?B?MEdGaUNLN3ZoT0ZKUUlQR0thZENJbXozbUxQLzJGcW91SUNpQk9EMkNOZk1U?=
 =?utf-8?B?VTh0V0taa1hBcGFRVnlGYnVmbG1icUtSakt3WHJrc2k3RzZpMkRtdm1COWFT?=
 =?utf-8?B?ZWorcGxwdk9ITWFPNU4xQUREUHkrYUJPYU1tTG8rUEt4ZnpVTzZLbUJaUXJ2?=
 =?utf-8?B?T05LZlJodGFPdDNqVXRRSU1aSGljZnJXMWRyV3I2aHFXdmljQWpvSm1MMElP?=
 =?utf-8?B?RWV2cVAvQmZ1Uk5tTU81cDVzWEVNRlJMT0REcFJnVGFCRGZ4Wnc2V0l0RWxx?=
 =?utf-8?B?M01lbzFsc3ZVaFBnL0FFeEd0TGhWVlp4N0ZaY0pCQ3NqQlcxYklDOXVGeUg0?=
 =?utf-8?B?WHdGNXdMS3lWNVlOQS9qMVVvek9qdFVnMTlVNDd2VzhZSmM4dWswWlVIZDZt?=
 =?utf-8?B?SUNZc3U5RFdvdk4zV3hWak85N25sZHJNYXNzcVRqTFhGT04zS0RmTFpqK1dD?=
 =?utf-8?B?bTFGOHIvdTlQWWZoVE82aVJsTk5GdW5QMUNkRHRFek8vVEEwWUpwMFdhMXZs?=
 =?utf-8?B?Ylppa24wWlc5Y0Q4SFprZVdOUmYrcjErVDM1Q1pjNjdGSzQ5OExBUGZqQmNn?=
 =?utf-8?B?bUVLamtWVVIyRDE5c2J3alNwZjVuZmhKNmErOVFObUV2UWZkcFhwT2tCVlZN?=
 =?utf-8?B?cUpUd1BNRUFMVHhiRzl6VTd0THJQQ3pXUHpQOE9FNUtUNjdOaUlaYmNYbHl4?=
 =?utf-8?B?d3czMkdVQXJ1WElQanpYdkQwbnVHWmN3YkF1aHV6SHNMSnVlMWpveTRMWVR4?=
 =?utf-8?B?dTNpVzRuRU1pb3FlVHZLTmlDMFVWc1pWKzRPUG5jMXk2WHp0TlVWMGZFaVBh?=
 =?utf-8?B?N2IzdWxsWDQvUXNIT0YxMGU0ZTdRWHUxM0ZqcW1RTXc3UEdZbnlHZjlUMHd5?=
 =?utf-8?B?emhvb2oxeVhMQUFlcmNENVBESnBDMFRYSStTWkpLVzlETk9sYmVEVWQ3aXJ4?=
 =?utf-8?B?NGRMV2RaTWZQbDlqeVRCb3N3dytOYWVEaGc4dWlvWFJZN3MrWk4xN1lEemIw?=
 =?utf-8?B?MU50MVNKZHhzanNKbU83VVBUR3Y5bVhNUnV0WFVIOXNPZSs4aDQrWStRTzNh?=
 =?utf-8?B?MVJNUUVJMnovMEZvalJ5N004SGFXRlF5UFV0b2U1cmF6Z203dkgzbFZGK09L?=
 =?utf-8?B?dWNxeEN0aDMvaDlsWnMvU1NieUtIVTNrUHIwSFpJWlVKcEZaMkNzM2xsZWQ3?=
 =?utf-8?B?emdNeWZTYVVncTc5aW9tczJrUThIU0w2RHFyTjRlTjJDNkJqYVlvWG9iYVlV?=
 =?utf-8?B?RFUwbFNGdnJBR3RCQmxVcUF4TWtCS0tsMmNWUWg5MUt1STdLZHBEcWdQOFp2?=
 =?utf-8?B?bGxkQ0FveCtKd2JzTUNWQ0JydzZFNzQrRGFETXNmNmJPNTRvSXdSUFAwNm9P?=
 =?utf-8?B?OURQd1NrZlhpV090TjhXejFVYjQrUVV3c0xXZ2ZxSVl1aysyd1E4bjZRaXJt?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FQBOOSR0MeVs2bSGri/WdyKj/WN+VHZOlrOLyNnwhDy4bez2rBHEbsf+/lWCF5VEErpFw/Xv0TefDdvU/wOLu1TwaqO2lCtgAMVyzUyqi/xPoItuOnKwhWaz4a2BhS4xhA1dJfB0Qfgb9TCcc+SUzaDVMiR4QwTkHhwlEDvqoI/kUo2RvnmUoClUTC145gBDBarJ33VHhdLAM7yPxjAsUF841IvSTnG5Vz8gAw8h/FmW5dIKEzTRCZDXxP8ZHJwfAU+Zek7av/Dr48xh2LZpeCgFMIwEmECf04S6NnhoZSkPe+1xJ2qYhKuF26qCzMZm2E0uk0bphUM3Tm1b25w+jRxMCmAX6RFVEL56an3WaCgIseubcUU2Qh1+cro5GXnx+IlqAIx2GqabESHzbxyWqhhBUsu7YpAaUNlOfAgh6/FrRnZS2DDczziWdhzu8rJOIoDcVCj3weTK2WElQhEJ2ekCf8z7eAWyTQPqlNQ5/Z1sPCMDJlp2/Y7aTQX0jArwF4igD0jq2bRpAfvo8J/E5wKbkL5gwffCi47CM9Vi/7/Gae6WnbGyrhyzRjgUt/Fk2osl9DCytXa9nk4VGs5OaCA+CAxKXg9DnS+eGiV2QHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20496f22-81e5-4b78-3f65-08dd1c61254e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 17:02:52.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPSzwQbPzY94OEMjLy0E0fWsJ1s409G+cz/7ehpN0wr/+QD195gPKoaEifFx+fa83cesEZKw8tS2prfQdjdy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-14_07,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412140140
X-Proofpoint-GUID: U6JqQBHVdEj0g0AZwvtuavC_PKv4jGTW
X-Proofpoint-ORIG-GUID: U6JqQBHVdEj0g0AZwvtuavC_PKv4jGTW

On 12/14/24 11:34 AM, Chuck Lever wrote:
> On 12/14/24 9:55 AM, Jeff Layton wrote:
>> On Fri, 2024-12-13 at 09:18 -0500, Chuck Lever wrote:
>>> On 12/13/24 9:14 AM, Jeff Layton wrote:
>>>> On Thu, 2024-12-12 at 16:06 -0500, Chuck Lever wrote:
>>>>> On 12/9/24 4:14 PM, Jeff Layton wrote:
>>>>>> Allow SETATTR to handle delegated timestamps. This patch assumes that
>>>>>> only the delegation holder has the ability to set the timestamps 
>>>>>> in this
>>>>>> way, so we allow this only if the SETATTR stateid refers to a
>>>>>> *_ATTRS_DELEG delegation.
>>>>>>
>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>> ---
>>>>>>     fs/nfsd/nfs4proc.c  | 31 ++++++++++++++++++++++++++++---
>>>>>>     fs/nfsd/nfs4state.c |  2 +-
>>>>>>     fs/nfsd/nfs4xdr.c   | 20 ++++++++++++++++++++
>>>>>>     fs/nfsd/nfsd.h      |  5 ++++-
>>>>>>     4 files changed, 53 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>> index 
>>>>>> f8a10f90bc7a4b288c20d2733c85f331cc0a8dba..fea171ffed623818c61886b786339b0b73f1053d 100644
>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>> @@ -1135,18 +1135,43 @@ nfsd4_setattr(struct svc_rqst *rqstp, 
>>>>>> struct nfsd4_compound_state *cstate,
>>>>>>             .na_iattr    = &setattr->sa_iattr,
>>>>>>             .na_seclabel    = &setattr->sa_label,
>>>>>>         };
>>>>>> +    bool save_no_wcc, deleg_attrs;
>>>>>> +    struct nfs4_stid *st = NULL;
>>>>>>         struct inode *inode;
>>>>>>         __be32 status = nfs_ok;
>>>>>> -    bool save_no_wcc;
>>>>>>         int err;
>>>>>> -    if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
>>>>>> +    deleg_attrs = setattr->sa_bmval[2] & 
>>>>>> (FATTR4_WORD2_TIME_DELEG_ACCESS |
>>>>>> +                          FATTR4_WORD2_TIME_DELEG_MODIFY);
>>>>>> +
>>>>>> +    if (deleg_attrs || (setattr->sa_iattr.ia_valid & ATTR_SIZE)) {
>>>>>> +        int flags = WR_STATE;
>>>>>> +
>>>>>> +        if (setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS)
>>>>>> +            flags |= RD_STATE;
>>>>>> +
>>>>>>             status = nfs4_preprocess_stateid_op(rqstp, cstate,
>>>>>>                     &cstate->current_fh, &setattr->sa_stateid,
>>>>>> -                WR_STATE, NULL, NULL);
>>>>>> +                flags, NULL, &st);
>>>>>>             if (status)
>>>>>>                 return status;
>>>>>>         }
>>>>>> +
>>>>>> +    if (deleg_attrs) {
>>>>>> +        status = nfserr_bad_stateid;
>>>>>> +        if (st->sc_type & SC_TYPE_DELEG) {
>>>>>> +            struct nfs4_delegation *dp = delegstateid(st);
>>>>>> +
>>>>>> +            /* Only for *_ATTRS_DELEG flavors */
>>>>>> +            if (deleg_attrs_deleg(dp->dl_type))
>>>>>> +                status = nfs_ok;
>>>>>> +        }
>>>>>> +    }
>>>>>> +    if (st)
>>>>>> +        nfs4_put_stid(st);
>>>>>> +    if (status)
>>>>>> +        return status;
>>>>>> +
>>>>>>         err = fh_want_write(&cstate->current_fh);
>>>>>>         if (err)
>>>>>>             return nfserrno(err);
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index 
>>>>>> c882eeba7830b0249ccd74654f81e63b12a30f14..a76e35f86021c5657e31e4fddf08cb5781f01e32 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -5486,7 +5486,7 @@ nfsd4_process_open1(struct 
>>>>>> nfsd4_compound_state *cstate,
>>>>>>     static inline __be32
>>>>>>     nfs4_check_delegmode(struct nfs4_delegation *dp, int flags)
>>>>>>     {
>>>>>> -    if ((flags & WR_STATE) && deleg_is_read(dp->dl_type))
>>>>>> +    if (!(flags & RD_STATE) && deleg_is_read(dp->dl_type))
>>>>>>             return nfserr_openmode;
>>>>>>         else
>>>>>>             return nfs_ok;
>>>>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>>>>> index 
>>>>>> 0561c99b5def2eccf679bf3ea0e5b1a57d5d8374..ce93a31ac5cec75b0f944d288e796e7a73641572 100644
>>>>>> --- a/fs/nfsd/nfs4xdr.c
>>>>>> +++ b/fs/nfsd/nfs4xdr.c
>>>>>> @@ -521,6 +521,26 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs 
>>>>>> *argp, u32 *bmval, u32 bmlen,
>>>>>>             *umask = mask & S_IRWXUGO;
>>>>>>             iattr->ia_valid |= ATTR_MODE;
>>>>>>         }
>>>>>> +    if (bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
>>>>>> +        fattr4_time_deleg_access access;
>>>>>> +
>>>>>> +        if (!xdrgen_decode_fattr4_time_deleg_access(argp->xdr, 
>>>>>> &access))
>>>>>> +            return nfserr_bad_xdr;
>>>>>> +        iattr->ia_atime.tv_sec = access.seconds;
>>>>>> +        iattr->ia_atime.tv_nsec = access.nseconds;
>>>>>> +        iattr->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET | ATTR_DELEG;
>>>>>> +    }
>>>>>> +    if (bmval[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
>>>>>> +        fattr4_time_deleg_modify modify;
>>>>>> +
>>>>>> +        if (!xdrgen_decode_fattr4_time_deleg_modify(argp->xdr, 
>>>>>> &modify))
>>>>>> +            return nfserr_bad_xdr;
>>>>>> +        iattr->ia_mtime.tv_sec = modify.seconds;
>>>>>> +        iattr->ia_mtime.tv_nsec = modify.nseconds;
>>>>>> +        iattr->ia_ctime.tv_sec = modify.seconds;
>>>>>> +        iattr->ia_ctime.tv_nsec = modify.seconds;
>>>>>> +        iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | 
>>>>>> ATTR_MTIME_SET | ATTR_DELEG;
>>>>>> +    }
>>>>>>         /* request sanity: did attrlist4 contain the expected 
>>>>>> number of words? */
>>>>>>         if (attrlist4_count != xdr_stream_pos(argp->xdr) - 
>>>>>> starting_pos)
>>>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>>>> index 
>>>>>> 004415651295891b3440f52a4c986e3a668a48cb..f007699aa397fe39042d80ccd568db4654d19dd5 100644
>>>>>> --- a/fs/nfsd/nfsd.h
>>>>>> +++ b/fs/nfsd/nfsd.h
>>>>>> @@ -531,7 +531,10 @@ static inline bool nfsd_attrs_supported(u32 
>>>>>> minorversion, const u32 *bmval)
>>>>>>     #endif
>>>>>>     #define NFSD_WRITEABLE_ATTRS_WORD2 \
>>>>>>         (FATTR4_WORD2_MODE_UMASK \
>>>>>> -    | MAYBE_FATTR4_WORD2_SECURITY_LABEL)
>>>>>> +    | MAYBE_FATTR4_WORD2_SECURITY_LABEL \
>>>>>> +    | FATTR4_WORD2_TIME_DELEG_ACCESS \
>>>>>> +    | FATTR4_WORD2_TIME_DELEG_MODIFY \
>>>>>> +    )
>>>>>>     #define NFSD_SUPPATTR_EXCLCREAT_WORD0 \
>>>>>>         NFSD_WRITEABLE_ATTRS_WORD0
>>>>>>
>>>>>
>>>>> Hi Jeff-
>>>>>
>>>>> After this patch is applied, I see failures of the git regression 
>>>>> suite
>>>>> on NFSv4.2 mounts.
>>>>>
>>>>> Test Summary Report
>>>>> -------------------
>>>>> ./t3412-rebase-root.sh                             (Wstat: 256 (exited
>>>>> 1) Tests: 25 Failed: 5)
>>>>>      Failed tests:  6, 19, 21-22, 24
>>>>>      Non-zero exit status: 1
>>>>> ./t3400-rebase.sh                                  (Wstat: 256 (exited
>>>>> 1) Tests: 38 Failed: 1)
>>>>>      Failed test:  31
>>>>>      Non-zero exit status: 1
>>>>> ./t3406-rebase-message.sh                          (Wstat: 256 (exited
>>>>> 1) Tests: 32 Failed: 2)
>>>>>      Failed tests:  15, 20
>>>>>      Non-zero exit status: 1
>>>>> ./t3428-rebase-signoff.sh                          (Wstat: 256 (exited
>>>>> 1) Tests: 7 Failed: 2)
>>>>>      Failed tests:  6-7
>>>>>      Non-zero exit status: 1
>>>>> ./t3418-rebase-continue.sh                         (Wstat: 256 (exited
>>>>> 1) Tests: 29 Failed: 1)
>>>>>      Failed test:  7
>>>>>      Non-zero exit status: 1
>>>>> ./t3415-rebase-autosquash.sh                       (Wstat: 256 (exited
>>>>> 1) Tests: 27 Failed: 2)
>>>>>      Failed tests:  3-4
>>>>>      Non-zero exit status: 1
>>>>> ./t3404-rebase-interactive.sh                      (Wstat: 256 (exited
>>>>> 1) Tests: 131 Failed: 15)
>>>>>      Failed tests:  32, 34-43, 45, 121-123
>>>>>      Non-zero exit status: 1
>>>>> ./t1013-read-tree-submodule.sh                     (Wstat: 256 (exited
>>>>> 1) Tests: 68 Failed: 1)
>>>>>      Failed test:  34
>>>>>      Non-zero exit status: 1
>>>>> ./t2013-checkout-submodule.sh                      (Wstat: 256 (exited
>>>>> 1) Tests: 74 Failed: 4)
>>>>>      Failed tests:  26-27, 30-31
>>>>>      Non-zero exit status: 1
>>>>> ./t5500-fetch-pack.sh                              (Wstat: 256 (exited
>>>>> 1) Tests: 375 Failed: 1)
>>>>>      Failed test:  28
>>>>>      Non-zero exit status: 1
>>>>> ./t5572-pull-submodule.sh                          (Wstat: 256 (exited
>>>>> 1) Tests: 67 Failed: 2)
>>>>>      Failed tests:  5, 7
>>>>>      Non-zero exit status: 1
>>>>> Files=1007, Tests=30810, 1417 wallclock secs (11.18 usr 10.17 sys +
>>>>> 1037.05 cusr 6529.12 csys = 7587.52 CPU)
>>>>> Result: FAIL
>>>>>
>>>>> The NFS client and NFS server under test are running the same 
>>>>> v6.13-rc2
>>>>> kernel from my git.kernel.org nfsd-testing branch.
>>>>>
>>>>>
>>>>
>>>> I'm not seeing these failures. I ran the gitr suite under kdevops with
>>>> your nfsd-testing branch (6.13.0-rc2-ge9a809c5714e):
>>>>
>>>> All tests successful.
>>>> Files=1007, Tests=30695, 10767 wallclock secs (13.87 usr 16.86 sys + 
>>>> 1160.76 cusr 17870.80 csys = 19062.29 CPU)
>>>> Result: PASS
>>>>
>>>> ...and looking at the results of those specific tests, they did run and
>>>> they did pass.
>>>>
>>>> I'm rerunning the tests now. It's possible the underlying fs matters.
>>>> Mine is exporting xfs. Yours?
>>>
>>> Mine is btrfs, and the NFS version is v4.2 on TCP.
>>>
>>>
>>
>> Nope, I still can't reproduce this with btrfs either. I'm also using
>> v4.2 on TCP. I assume you're running this under kdevops, so we should
>> have a relatively similar environment.
> 
> I'm running the "stress" setting, which starts twice as many threads
> as there are CPUs (so, 16, I think?). 32 nfsd threads.

Also, I'm testing 2.47.0 of git. The default version that kdevops uses
might be older.


>> Are you also testing the same commit?
> 
> The first failing test run is on 6.13.0-rc2-00016-gb45eda1daa7d
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/? 
> h=nfsd-testing&id=b45eda1daa7d79a2bf0426d27d4b359b8bb71d33
> 
> I'll take a closer look.
> 
> 


-- 
Chuck Lever

