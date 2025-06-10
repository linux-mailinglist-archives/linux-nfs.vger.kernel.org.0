Return-Path: <linux-nfs+bounces-12254-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C585AD399C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2901F3B7D27
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C9912CDAE;
	Tue, 10 Jun 2025 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ThlVaJ4k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xBX1BZgP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169625B30D
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562693; cv=fail; b=Tm9I6GJ4SWweorqWrhFzqRMWCmaN1bP11Nh649YuUVxE5y9UpyrK180zv7vPiZie6nH3+4INl9AXsRk19dvMZ5biiJVNZZsz3gL/6pNGQZUXxd9NyHUoqHCSpyHkJFaZVQnKtxO+gwBst7idFxPUNwhyR7h89/YJDhUgRrRnqB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562693; c=relaxed/simple;
	bh=JAlxqAONQCRNmNwwPujQMjw89YjHn0qvGX6WYIIPFwY=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VDCXegqkRGj3w0NBBJXHFVLlVq1SBfcvMRnmDCwr/2/V8CZdaYRbUgOuSNad8spKcSBm2Gd/CQzEsuupm4qtg9KB0nDpXFk0q+hdL8UN1us8dORxdHahpJgmZ1+T1YHzcfUEj1rrCB0UB6fxP2eIsAEzL9Mbqr6TfxouISGjy6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ThlVaJ4k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xBX1BZgP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADBgxn008614;
	Tue, 10 Jun 2025 13:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NhpESTPZ6oK79Lk7/f6HkjyW18B3k5/mHeFBa1iWFsw=; b=
	ThlVaJ4kx7Vxu6P4S4SY5lpjwogf5Z753Kxr9wn/qOX7bzejdMlOYRiuIHu9zBMw
	I6jtsrZO9h+fiyLCmeam9MYa/Sk2XCgOWwC9mP6lFfQPKvIYv5u7XR5g1kOsof5J
	i0Yd1lsX08mOrW1i6GJ4E/46In6Gz/iObxjvXngjJEVy8o7YNn2RmVSBomTYqFrD
	l/sInQ3aSf3UwEI8RdRv5y7WitXI3PVcGFUDFvf2XrS/0NlWdFnypa7EwzuNVTyK
	iO3rVBKxRwMY4z4MNkE4xTTvL//5bEPKsBhmYDPAS0hDRmsRmB3AoXm7hH19Vn7R
	OjyN0VYfdo271n4XSYzinA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf49fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 13:38:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ABvbeN007524;
	Tue, 10 Jun 2025 13:38:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv8gdrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 13:38:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GguAbKvz6RsTzjGJc5bxqXrzah3l/b/mwbZcBvGdaMCeAp1pYHRuyURxc5BSYoX/SAWqwREdXnBoOrIM1hESoDHiYYmQMFCL7x4/EBsU6hD8jTlYGK+HRiQfyD7a1e5ey3frJvFO55VrSj/E/Aety6jArYhZzAOwRLDH1+HimfPAZ3kJWXVnHsfWLUTJNep8sGMvR6xZuVvYtBqVTRjZL02aua2cxuetJV6XG5uFuRNcTZdqNGYb08/AXIdG593XBsJQaNxhxP35icZ9+H+Mqq1zJx4Kff+DSfDL2S6/A3pDw+AtO6XVKXafSAWZ3ZzKlPl5HJhhzK8rmr8pOPYNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhpESTPZ6oK79Lk7/f6HkjyW18B3k5/mHeFBa1iWFsw=;
 b=G3IwmOl9JHqHH/n5DC3NSVsdCr3cV00bmr6UMwTupcqs5JeTZYwN7MLmeRRdMzQXN1HRcdR79fxTFQEqbr43W14R2Cpfi/qrrSkb92ciWuwbbxoJSV9v4DglWld8jcoa8vSZRhJfOT7cKnZ6uMqqJSR/b9meBOftjb9yhKfOJNlg3NsXr6wZYNWXGtCV7PY7pdNLtf1/HQQ1DEZqRkJMB31Px1qUiVY2m9d3xECRafTO9FWfBIPFVTbIp5ffxFDu1eprf0h6traiYDP5GF3IoTJ79lwyk+W+iuqnORUl7642cErrpwFW/C9n/6kq2lVxJYzrb7fkarWK6WR59QLOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhpESTPZ6oK79Lk7/f6HkjyW18B3k5/mHeFBa1iWFsw=;
 b=xBX1BZgPcbTwBVui8QzipX33wkbd1Fq8aDHR31Dcci+xSvWi2leVykxkXWbLS/Z+qCChgQMO2o/WRZRxGUYQgUEda8OzZb0LtgCMSoGdwU43G5DVH99hwFFkXbgmaMPDoMXzyj5keDB/ryb2H7Fzv++sxVIjZd1liBPaOlMyGv0=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH0PR10MB5871.namprd10.prod.outlook.com (2603:10b6:510:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.33; Tue, 10 Jun
 2025 13:38:02 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 13:38:02 +0000
Message-ID: <03d846e0-cbf5-4393-b1d7-6117964aebc3@oracle.com>
Date: Tue, 10 Jun 2025 06:38:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [nfsv4] Re: simple NFSv4.1/4.2 test of remove while holding a
 delegation
To: Dai Ngo <dai.ngo=40oracle.com@dmarc.ietf.org>
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com>
 <CAM5tNy5rBMrqfQ7S6fZNciWovkf8K9tc+cuV7q0MALocyzYV7A@mail.gmail.com>
 <3c60168c-630e-4253-a9c2-e88a3ed21696@oracle.com>
 <CAM5tNy5wssyrntPHQNreU3Au0aYUBRMUuTR0ixtcng5YmFq3iA@mail.gmail.com>
 <42531e1a-850c-4d6a-aa8c-95910fde3190@oracle.com>
Content-Language: en-US
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, NFSv4 <nfsv4@ietf.org>
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <42531e1a-850c-4d6a-aa8c-95910fde3190@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:a03:114::16) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH0PR10MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: b9343609-49cc-40b2-45ec-08dda82405a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXdzMmZZODZVYnRRTndLYlA4bUxwRjNibkVsWTBxRmd2bDlJMUxiaWV1cmxn?=
 =?utf-8?B?WHp6TWlReE1FczJMdW5aVFY5a1VrNFBWaWZ4bzVnNnRheTNnNXVJR1U0dFF0?=
 =?utf-8?B?bkNmK1lhb0MxZDBsMlVmeFFtRGVGdTdyWXVtSDROc0ZnQXVQT3VTYUxQckFt?=
 =?utf-8?B?VnAvU1d4QjdYa3NaTFJMblR0WGpmc3VuYjlSUWNQNnovelMxNzFPUTdxLzM2?=
 =?utf-8?B?Zm96ODdRME9Sdi9yOU1QMTNvd0hEMkJmL3RiYmlZZlRiaER6OVdEanZSR29z?=
 =?utf-8?B?eVpqLzE2b1pSZnA1em1jamdVaWZJR0lFalZJaXJOM0YwSEF6NVViVHh1MGxv?=
 =?utf-8?B?RUpPNHUwQVpjSEtJMVpKUG9rN0grWmJyZXZEb0FIaHRISVE4UnQ4Vjl3RU9l?=
 =?utf-8?B?YjdmOVNWMCtZUkdCTERwZjBib0ZXZm4xMzVhYnoxaWVYYkZWT0xmeGQrR0VV?=
 =?utf-8?B?ckhCcHFGa0R0aUVLbUxxZE45OVhVY1hkelhLMDY5UXh3YWJMd1YxT1oyeThQ?=
 =?utf-8?B?VFRFK05yRnAzaStUVUl5NUNrTWFFTlkrWWxVUy91cmdXVDFiTWl6aXdtRWVM?=
 =?utf-8?B?NGJkaCtCRExJZU5yNngyVlNGUkh5Wk00VWJIK2lQLzN1ZC9pTmdXZExIUjBl?=
 =?utf-8?B?Kzd1NlBtWXdIRWwvM2RQUGE1STJEYjR1bUJqL09QNXNYcjY4OUI5N3dqZDl3?=
 =?utf-8?B?bmtrMXpNMXZDOFdtZWtjRkpZWGRnZXlvYU1tN1JVTnlWTk9HK0d4c0ZOYTJJ?=
 =?utf-8?B?OXFKQ3BYZlJMK1FHMmVvb1BTZTR5SDMrUllROTZJdnhFc3ZERy9QMVpIMlJC?=
 =?utf-8?B?OVJ6YkkxVDFNcXlUU3BZdW1BZkdqVmt2MGhhRzdmS0FtWDZYYXlna09Ramg4?=
 =?utf-8?B?L0R5MDkrZ3dnQ2FEWkxKVVhjdDFrZWkwN2pScHRad0NvTkpsMmxRYk1vbVFP?=
 =?utf-8?B?SEM1Qko3SzdibFdiMDczYnRkNVBicm54MUk5bVJ2WTVwMUVUZ2kzTGpxa3N1?=
 =?utf-8?B?enlYb0owbUxUcDNSQmpZbkdScjdKR2VBb09pbFIvcUhDbnBDTjR4NDNKR1JM?=
 =?utf-8?B?K2JvbmV3Ujk3UjA5L3NjQWFiMFdSczRBTWUyS2FJQTlld1ZRYWZyK2QxWThC?=
 =?utf-8?B?TjhrcE84OVUrTHRkU2RST2dCME9lL3NGNkdiZ2dQaEhKNFFUZ1U0cXBVbTBh?=
 =?utf-8?B?RDQzSFBYcktYMnFoWkV6UTBNQ3E1K3VoZnRyalZmeGVyOTVCUU56dU81MEhJ?=
 =?utf-8?B?c1F5djFwTkVSMUdWc1RyN3p6UXdkWXFlRUpja2lOZWFBZGNZMGxEbFlJZnpv?=
 =?utf-8?B?cFZ2UXpmLytIdUp2bnJlUmZGMVFYZUs1K2UvdUJXVG5tZVFGM01LRnQxT1NK?=
 =?utf-8?B?eFNxRURncnNpcCtpMXY0YWlOZ1BKa3F3TDJueENlWGp6Szc3ZVNhYjhwc2Ex?=
 =?utf-8?B?U3J5Z1pMci9Va0FVMlNoNms5TS9ISzEvSEsveWZYd3BuZFhKcDBPRDlsQ3or?=
 =?utf-8?B?eVdkbUhNYXBEWjdiODRtT1A0OWF6YUpRemVvQ2pKM2s4Vkd3VjNrUi9OS2pU?=
 =?utf-8?B?V09vOEcvaWQ1YUFHMDhWd2JtZlNTTlRFa3VWRDZabkg2MTJQMmNtbVBkaSt0?=
 =?utf-8?B?OEtxNHcveEtBQmF0dEZhQmRSMHFVMTJIbjZiNkQvYWQzQTJzblpab05STFVI?=
 =?utf-8?B?MXBrQis5ZEFUL05XRkRTZTJ6bmE0RTVTaW9OZk42STQveUxJTG5qWjdYUVN4?=
 =?utf-8?B?QitZVHk3T1o5SVNmTm9Lek5FdTdCck1VZjE4K3Nmdnl5Q0tNN25TdHFiVDJQ?=
 =?utf-8?Q?p5CLyLgYkaO6bIoslRk/HNIk9IdcSoQZ4P8UA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3FPQy9zTWNqOUJYTVdzRGNSSjhDczZNZDlJV0pPdFNJWk5RcXdRb3d6MjFy?=
 =?utf-8?B?YUtBZnZqbjg1Z0dmS1lmb0VIUzc1S2lkRFZFUmI2MmVvQjdxOXk5VGZDQmZr?=
 =?utf-8?B?enoyY0RaeVVZL3BIKytNcUFUYzB4eEVMQzFhL1VjOWxINFMyTVlxdUhOeDgw?=
 =?utf-8?B?NjU3eDJpOHFSZ094bUJJd21EaGdaejVTZzlnZTVaVi9xQkQxVnJtTWFraVRD?=
 =?utf-8?B?QTZ6d2tXZEE1VFFXcExrSXl6QWsxUGlydi94Y1NndFBhRHMvZENwRkJQZmlP?=
 =?utf-8?B?S2hzdW9uNmJ0T21MTXMxaGtrd1R0c0s5NnVwcGFRbWlEZk5SVTNDM3JXME5j?=
 =?utf-8?B?Vk96eGljRkdMYVUyZVBEekdvUWRMKzk4VUxrSWtXanAxVzNQdDRkUFdKeFp0?=
 =?utf-8?B?KzdpcHpjMWRpRnBtL1AyK21aQ0U2MERkNmlWQ2RYUmhycjRGSHVGT0dVVzEv?=
 =?utf-8?B?cHU5eXNIbE9mUlVxc0pmTHVNdzZyeGp4cU9pSStxTTd0b01aREJiaUljbmp5?=
 =?utf-8?B?cWZ0WHRZN3ZlZXRybjZUZEttRk1vdTVsS1c3cHpKak1QVjhoZ3hjNUJtcnl0?=
 =?utf-8?B?bHVXRWYvdHplWkwyN05pUUZ6bUhsaEVRVEkzZUFsWHZwb24rS0taWkVLQldz?=
 =?utf-8?B?TDZWVXUyUnl4RlMrSzJGaU8rVitmUXNZU1ZLRG1aUnNqaDhTcWZRcUc0MXRt?=
 =?utf-8?B?eWdXall2Y0x5UGJqVHZBQUU4anhpK0tOMnFHUVFCY2NnK3pNdGZUcXFMb3N1?=
 =?utf-8?B?M3Y2K1JVMXZjVXo2RlV5WDljejFUVTVIeHB2bDAxSTBsV3ZGWE1lQi8yT1Fp?=
 =?utf-8?B?VnpDYjQ4cnQvS1ptZnZ3emozMEJURzRKN3U2UGs3QkVDVnFFOUhBUEFRcVMr?=
 =?utf-8?B?R05wcGM4K2YyVjlSWjZ3cDhlWDRCd3pRVENzeWdVR3dYM2JmLy95U0hiM0JX?=
 =?utf-8?B?eERjcjdRbGE1Q05UNDRLQnBwK090MFlsRFVnelFrQ1Q2bGxFNnZqZDhtUnZx?=
 =?utf-8?B?YXJjb2JXMVRKeHpKOUthdGlVSUN2QWgvSlJ5L01HUjFHZkxpQWcvSkdKSWdP?=
 =?utf-8?B?dDNOVGEweUhYaUhiZFBMTlBpMXpvUVYvaXFuaGJselZGWEpJTk4yKzZKYjVK?=
 =?utf-8?B?cmhEd0hDNSsyQlVuVVVoR0tRdzJHcHNhbUt2bldGUnhkMzFtT1h0bCtrVG96?=
 =?utf-8?B?UzdXeXhaaHR5ZUpPOFp2RnRKQTNJdmRnNjlMYmJZRE94Sjc5NjNBQU93cnIw?=
 =?utf-8?B?Nm0wRGNpNEk4cGpHY09lNWg1eDE2WWQ1bS9WRnN5N004MTVPMlc2VHVJVlR5?=
 =?utf-8?B?dlQxaFNhOWZIVlpVbExMdjFET3pkODl5aXNsOVVaV2gwa01aWTM5dVRkYW1F?=
 =?utf-8?B?ajU3RGlaVWlhU0NJN2lOUFd5cmx4RTVScDVOK3g5MzRobjdYOXIrMnI1ancw?=
 =?utf-8?B?YlMydis4SFd0RXd5RG5EcVhRN3E0MHlOMEVVeklhK2crWGRObE0wRnNYWUlD?=
 =?utf-8?B?NkI0SGFCSmxTL0l3VExwZ29PaXJOVk12QlhRdk1BWjVBZHBPTHdnMkg2MkpL?=
 =?utf-8?B?UCtNTmxwUXRMREtzNXF4aFhlbmxjZGkwc1BKR3RVMW1BRDYzTFdBY1pUYkth?=
 =?utf-8?B?cWxpWnh0bWlsZmNqSnNjc3BGb1ZhelhRRGV1eFVsUnc3MWgvbklkaG9xOVVq?=
 =?utf-8?B?NDNXWldrNURKVmVURXpIYVA3QjV3VFZQc2h2YnoyYlg5a1QycWZwdGFQbEVj?=
 =?utf-8?B?OS82MmJEUUFvZ2pUaktQbkdiTElhWTZHQ2tpK29FeGl0NEMwQXRUZVA2SVQ3?=
 =?utf-8?B?OGRDQlkyZW14VEdaRmRUK2NMZTh6ZENsM1JxWG9JYzhVa3lIODBRaGQ0Z3Jo?=
 =?utf-8?B?amRVcnk0My9VMUZlR1QvN2M1b1gyd0g5UEJBZTdqb1UvRkFQM1c0TGlDVExr?=
 =?utf-8?B?b0hoQkNnYmJQemhmc0VWV2ZFOU5UNW4zbVE4NkM2V0NFaW5OWXNZTmZ3bU1j?=
 =?utf-8?B?YWk4MTI0bGV5VWQwVnh5TDRvNW1YdTQ0VFpaYndDRTJmTFJNb2ZkVHp1dG5h?=
 =?utf-8?B?TCtwanJjZ0xiK1ExRjNralFKSFI5K3p6SVlTckp4RHpoV0s5MDEwMDdiOHV0?=
 =?utf-8?Q?I8WCpxXjpxc8cZFX4i7PFH2jf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kRVOtjlk4IQcQPsZZFG19Tp/NKFzVrh5zV8nwFeS/+gmM1xPB/uSSD2CuJ+VoSXZcOJH2ckwe8qpojR5BMe5n2FlSBg8d+drZnzyH39ys9dsg2nhqS/JSD0gqMSB//wRoAzQo0Dr9T7gvZVbxQzXWBVjfa2/uJg3mdiIfuQONif8eeqc1AtgHmauP+pEfyWHfxPGPJ0FQtm/BgEK5yZVflN4aYfChv79L/ahmSy65j+vgyQ0BcYY1sRvkbJImmgZ/1Ec2jtmpXeWF+6SAnAJqff3r9WgQRFoTUbPWbmO1pAvb8ovEAeOSzVfnNv/9S5sN2uIxdGvScZRlt+VS+q0w2FDyApB1hfCdzgl/cY2h0MADMJDz70zSvbfJPMB0Q2xy/HFKLVw6Bnri0z+RRLeWtdkenAoWB90/fByliNNvkyOZNkpC1XnT8LgWL2n7nur9rxTW66sC9ZFnHi9h3LDK7isk2zK57G55cATB3jZGRnKNXp1WWPKq4ayavyGfpQ7wExi4ygp10SS4Bmu33sUupysv63pjqBloBUN+x7uurJf9Tjhbg5iXgCM1IsS96uV4XLAHaIHcN+m68lktcTTnf+t6Xq1CPtXwenFiUUsMYY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9343609-49cc-40b2-45ec-08dda82405a0
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:38:02.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llmldBjA3ke5HrTAcpnKgd9yNkszpwyavbMgM5xf62z6mfbyMIANrR2eJ09ENj59xsLEMgFhgv53PXNeIJltbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506100107
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=6848353e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=6I5d2MoRAAAA:8 a=yPCof4ZbAAAA:8 a=48vgC7mUAAAA:8 a=ONcd6ZxjnefOE5jKBW4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WSWrzNNzM5_GFpJnBJ_GN8mbLzGhmBck
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEwNyBTYWx0ZWRfXwzTnW4gKFjiF kVq2Kc9Mav7rtse+3HTb7hUR0lTjCaENXjO+SkuocR65e3IdOTue5JMUz1a5p8n7o7v1NI40PeU 1ehUXQYKNnyefQD2Lmat5KFBtBWJowYwcPw12rzVrb0MInQjhbuWYjkQkbihvj8IlUxt6WxEONq
 G4otA6C3eZG5/gMpfrij7vac9LxOI4iI9884jzjh/lm8TcIvUPwvM3NDNMBsfAeQlATP5PnkRzi qNhvsiMU/ym/+FC5nXbVfa1Hh32uOxKlyEHEvc7Lc6fawXph58xArk9IRUE4aiC88tfokAJhDkK S5K8PSgdwbbnKIz5k2VcCSK5baUcwnPToPjeCSEjR+fu/XMnsKIgJzC1SlAqI+jv7cdsSYLYxb1
 a5AbUH4uBO1q1UGVv8BkLd3Ilk4G9Fuy0ztZcrx94/QQqzStjjkUTAaL7BwirUuemaYFo/ql
X-Proofpoint-ORIG-GUID: WSWrzNNzM5_GFpJnBJ_GN8mbLzGhmBck


On 6/10/25 6:28 AM, Dai Ngo wrote:
>
>
> On 6/10/25 6:16 AM, Rick Macklem wrote:
>> On Tue, Jun 10, 2025 at 4:58 AM Dai Ngo<dai.ngo@oracle.com> wrote:
>>> On 6/9/25 6:06 PM, Rick Macklem wrote:
>>>> On Mon, Jun 9, 2025 at 5:17 PM Dai Ngo<dai.ngo@oracle.com> wrote:
>>>>> On 6/9/25 4:35 PM, Rick Macklem wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I hope you don't mind a cross-post, but I thought both groups
>>>>>> might find this interesting...
>>>>>>
>>>>>> I have been creating a compound RPC that does REMOVE and
>>>>>> then tries to determine if the file object has been removed and
>>>>>> I was surprised to see quite different results from the Linux knfsd
>>>>>> and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
>>>>>> provide FH4_PERSISTENT file handles, although I suppose I
>>>>>> should check that?
>>>>>>
>>>>>> First, the test OPEN/CREATEs a regular file called "foo" (only one
>>>>>> hard link) and acquires a write delegation for it.
>>>>>> Then a compound does the following:
>>>>>> ...
>>>>>> REMOVE foo
>>>>>> PUTFH fh for foo
>>>>>> GETATTR
>>>>>>
>>>>>> For the Solaris 11.4 server, the server CB_RECALLs the
>>>>>> delegation and then replies NFS4ERR_STALE for the PUTFH above.
>>>>>> (The FreeBSD server currently does the same.)
>>>>>>
>>>>>> For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
>>>>>> with nlinks == 0 in the GETATTR reply.
>>>>>>
>>>>>> Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
>>>>>> probably missed something) and I cannot find anything that states
>>>>>> either of the above behaviours is incorrect.
>>>>>> (NFS4ERR_STALE is listed as an error code for PUTFH, but the
>>>>>> description of PUTFH only says that it sets the CFH to the fh arg.
>>>>>> It does not say anything w.r.t. the fh arg. needing to be for a file
>>>>>> that still exists.) Neither of these servers sets
>>>>>> OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
>>>>>>
>>>>>> So, it looks like "file object no longer exists" is indicated either
>>>>>> by a NFS4ERR_STALE reply to either PUTFH or GETATTR
>>>>>> OR
>>>>>> by a successful reply, but with nlinks == 0 for the GETATTR reply.
>>>>>>
>>>>>> To be honest, I kinda like the Linux knfsd version, but I am wondering
>>>>>> if others think that both of these replies is correct?
>>>>>>
>>>>>> Also, is the CB_RECALL needed when the delegation is held by
>>>>>> the same client as the one doing the REMOVE?
>>>>> The Linux NFSD detects the delegation belongs to the same client that
>>>>> causes the conflict (due to REMOVE) and skips the CB_RECALL. This is
>>>>> an optimization based on the assumption that the client would handle
>>>>> the conflict locally.
>>>> And then what does the server do with the delegation?
>>>> - Does it just discard it, since the file object has been deleted?
>>>> OR
>>>> - Does it guarantee that a DELEGRETURN done after the REMOVE will
>>>>     still work (which seems to be the case for the 6.12 server I am using for
>>>>     testing).
>>> The delegation remains valid but the file was removed from the namespace.
>>> This is why the PUTFH and GETATTR in your test did not fail. However, any
>>> lookup of the file will fail.
>>>
>>>>> If the REMOVE was done by another client, the REMOVE will not complete
>>>>> until the delegation is returned. If the PUTFH comes after the REMOVE
>>>>> was completed, it'll  fail with NFS4ERR_STALE since the file, specified
>>>>> by the file handle, no longer exists.
>>>> Assuming the statement w.r.t. "fail with NFS4ERR_STALE" only applies to
>>>> "REMOVE done by another client" then that sounds fine.
>>> Correction: even if the REMOVE was done by the another client and the
>>> delegation was recalled from the 1st client, the open stateid of the file
>>> remains valid until the client sends the CLOSE. So the PUTFH won't fail
>>> regardless which client sends the REMOVE.
>> So, should your server be setting OPEN4_RESULT_PRESERVE_UNLINKED
>> in OPEN replies, given this semantic?
>> --> If the FH remains valid after REMOVE drops nlink to 0 semantic
>> were indicated by
>>       the OPEN4_RESULT_PRESERVE_UNLINKED flag, a client could check for
>>       this flag and handle in appropriately.
> I believe the Linux NFSD currently does not support OPEN4_RESULT_PRESERVE_UNLINKED.

The Linux NFSD does not guarantee that opened-but-deleted files were
kept over reboots.

-Dai

>
> -Dai
>> rick
>>
>>>> However if the "fail with NFS4ERR_STALE is supposed for happen after
>>>> REMOVE for same client" then that is not what I am seeing.
>>>> If you are curious, the packet trace is here. (Look at packet#58).
>>>> https://urldefense.com/v3/__https://people.freebsd.org/*rmacklem/linux-remove.pcap__;fg!!ACWV5N9M2RV99hQ!IEcffaAAeLhuzaJUO5rQOv0jUUk4ltuMpfqT83lLFkRL9cqOZEvZ-8GGjvoqlVAQKi_FAAhsKEl5NjvS0OLJ$
>>>>
>>>> Btw, in case you are curious why I am doing this testing, I am trying
>>>> to figure out a good way for the FreeBSD client to handle temporary
>>>> files. Typically on POSIX they are done via the syscalls:
>>>>
>>>> fd = open("foo", O_CREATE ...);
>>>> unlink("foo");
>>>> write(fd,..), write(fd,..)...
>>>> read(fd,...), read(fd,...)...
>>>> close(fd);
>>>>
>>>> If this happens quickly and is not too much writing, the writes
>>>> copy data into buffers/pages, the reads read the data out of
>>>> the pages and then it all gets deleted.
>>>>
>>>> Unfortunately, the CB_RECALL forces the NFSv4.n client
>>>> to do WRITE, WRITE,..COMMIT and then DELEGRETURN.
>>>> Then the REMOVE throws all the data away on the NFSv4.n
>>>> server.
>>>> --> As such, I really like not doing the CB_RECALL for "same client".
>>>> My concern is "what happens to the delegation after the file object ("foo")
>>>> gets deleted?
>>>> It either needs to be thrown away by the NFSv4.n server or the
>>>> PUTFH, DELEGRETURN needs to work after the REMOVE.
>>> The PUTFH and DELEGRETURN continue to work after the REMOVE. The open
>>> stateid and delegation stateid on the server are destroyed only after
>>> the client sends the DELEGRETURN and CLOSE.
>>>
>>>> Otherwise, the NFSv4.n server may get constipated by the delegations,
>>>> which might be called stale, since the file object has been deleted.
>>>>
>>>> --> I can do PUTFH, GETATTR after REMOVE in the same compound,
>>>>        to find out if the file object has been deleted. But then, if a
>>>>        PUTFH, DELEGRETURN fails with NFS4ERR_STALE, can I get
>>>>        away with saying "the server should just discard the delegation as
>>>>        the client already has done so??.
>>> You can try your test but I believe the PUTFH and GETATTR won't fail
>>> after the REMOVE.
>>>
>>> -Dai
>>>
>>>> Thanks for your comments, rick
>>>>
>>>>> -Dai
>>>>>
>>>>>> (I don't think it is, but there is a discussion in 18.25.4 which says
>>>>>> "When the determination above cannot be made definitively because
>>>>>> delegations are being held, they MUST be recalled.." but everything
>>>>>> above that is a may/MAY, so it is not obvious to me if a server really
>>>>>> needs to case?)
>>>>>>
>>>>>> Any comments? Thanks, rick
>>>>>> ps: I am amazed when I learn these things about NFSv4.n after all
>>>>>>          these years.
>>>>>>
>
> _______________________________________________
> nfsv4 mailing list -- nfsv4@ietf.org
> To unsubscribe send an email to nfsv4-leave@ietf.org

