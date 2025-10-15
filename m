Return-Path: <linux-nfs+bounces-15275-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9702CBE027F
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 20:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 703FD5044AF
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 18:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6560B2417C2;
	Wed, 15 Oct 2025 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hAm1/qHi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lL1WjrjI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D372238178
	for <linux-nfs@vger.kernel.org>; Wed, 15 Oct 2025 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552218; cv=fail; b=vDJBvf0PHxoAk24K4rNJYX4Lf79XRYLfSKCSOCI+zjaRaOPVUYLHNwNFl9tEn1CGRlgMmIRGRrG1xeF8yp/w0fOZL2H2hJFNg+bd5QP5yu+h54qK+H1oustKZQFiFSq9H63cuktXyVsS1nZRi88YlERTP7STdlhNTdEylUwgsOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552218; c=relaxed/simple;
	bh=+SIJj2s7+beEVHtc2Osn+o9alpOaxwRBmlL3QXBUrck=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KLOPzMUY+txSE+YFaKBffx6aJZNS+jeH15eBAkIeEX6Dl7C5UrHfkDKK8RqE9W0r7k0y+2VgJAxzX5bdJOIUfisrVkr8+Db5TCCHYXhjGZGO1LSK+psXEPIhi81N9P3l+Z5O7M6c+dLQUcT/fDNDJLIQ/aMhr5p2aOcFYCdDy2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hAm1/qHi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lL1WjrjI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FGC9Ze014662;
	Wed, 15 Oct 2025 18:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5oMl7uZs8zwJRo7lf2TAoO2aMmGYXGuxwMzokMKZLps=; b=
	hAm1/qHib/6/x3tSaSuJ0SI4yWfDwIuGCA638eqbSZHLH25yTwnE14Vzam4XYov8
	ZgLSySmzToAq1qq/Aao0/McMe3k0MAFWEIzxIIDB2SrXH1v9Sa3I5mq/esuZ5DOa
	wZ4A3pVN3vkc/AxZ4t9ITq0jHUhGSLcC8rOPrlcNOSqUaPmNOA2r1DSI3a1P6UZm
	OXKgd11C41uhM4eIApmm/GTI3I0IorNHWFChsQ0cmteUq6SBFlL8pl17cn4umjGv
	6tzpyqtIHOxcTNs5OLN+H1oRmTsiubgFPmXGCaCPZBkvx81xFWl5rj5Ut8fDtrt0
	4WudTA7XeCL020toMPCwwQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfsry6vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 18:16:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59FGo0JN037106;
	Wed, 15 Oct 2025 18:16:47 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpaprjf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 18:16:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPwXdf3sdy/Q2Kxm4Cs8oazA5h/wZk6hUE1QmBgSk56Y0lIOouQCOykajQoECs0Lnr6j51UqNKIrPQbQ3rsbH9vgoUlS5kxIHzRSYnpLhrIEFYq8IV/8nyeK6okdMygLpfZU4++K6nRKmTFZWsNrgNvUdBsrGlyriDvUqeAndFlKybrytJpUiKR7CcPaAE3OaRBkLEbv3X+cA0TXsCS5Oa+plFiG+ZYAfS82BaqTDFWcnr5VSgag99Aa1JV2PwX815EgndnMJ5cjgPlDBA/uT3e5PU2IVPOrqInGDhU25YXD2Pm0RRdnoD0Hq3cTKwNwA1Yj+h6uswz29D38JJ2Lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oMl7uZs8zwJRo7lf2TAoO2aMmGYXGuxwMzokMKZLps=;
 b=Whq0GLawf9Kpjak3wYujMFaYZeEoZWfsgLZ9Srdg/4XrBBkABJNJB1VCLrvuOzqhvwSO16A67HBHixfn/47RRkd0JiIuOQ9SXgw6Qpu9EoCBZfSl434WN/BincJ9qEjZ9Wm/xkZ9bNvZMUkVUJBoEB23fRJlTAnerLikbGyPcXZFAvBAJ1HjEB7YtYqoM+MaRp0yq+7XE8CwI4uDeaLDLJi3afGgNkr74L1/n5NTD3hyZ/tR6G325QDUobxd0LxA5UwOrxczyBeuLwe6DF19HDEQ12Ay8mlNYI+SPYpz8UYk1/wmtc/HicuBhJ6EqbkIY3EFQz4Udf49c28oRXQw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oMl7uZs8zwJRo7lf2TAoO2aMmGYXGuxwMzokMKZLps=;
 b=lL1WjrjIYI0blYKAyi+wVAgk+FG+bXsW32ThlZeEHl/AAXuUEzMtgRlAzfph5ihbHuppMfRB23ddkkXPq8lVWGTt24xp66fISmXIkH+zPB4x250+q1GEI9tCwp3amDpYd6/DBIvIVG53IQaIN0KmP9uIo/zGj0cCIs4KUQYRiVo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS4PPF18D5A7206.namprd10.prod.outlook.com (2603:10b6:f:fc00::d0d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 18:16:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 18:16:43 +0000
Message-ID: <d2cbe615-7c01-448a-9c93-f104084540c2@oracle.com>
Date: Wed, 15 Oct 2025 14:16:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS
 clients
To: Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20251013190113.252097-1-cel@kernel.org>
 <aO_RmCNR8rg9EtlP@kernel.org>
 <c95b46b6-5db4-4588-ac79-4f6d38df0ae2@kernel.org>
 <138caf9b98325952919d37119c1d2938a8f4f950.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <138caf9b98325952919d37119c1d2938a8f4f950.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0037.namprd18.prod.outlook.com
 (2603:10b6:610:55::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS4PPF18D5A7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 33290919-de78-4257-4ebb-08de0c16fec4
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?LzZ6VEhzdFdLQXJhbWtNUXhUOGF5cTE0NHBGZ3QxdFFCbHBabGxIaXdPVlJU?=
 =?utf-8?B?ZmNVTFdhU2c4bElwYUJManhQb2o4MC9TRTJTNy9vcFBPR3JlTk9UR2d3d0lD?=
 =?utf-8?B?Rm5Ta2NBWEhWak80WjkrallyUE53VUsrS0FBVzhVelVvRzdIcTJpUVJyaFFL?=
 =?utf-8?B?Rm0wcFJqNUxIVlpIdHJqbUY1Mjg3Z3FSY3pXZ2JKOTFpZnhaTEsyUDZSTjBV?=
 =?utf-8?B?bGN1MjJGb0FzK2ZEOFFobktvT2lTYkFzejlXeWNUZ0NRK1JwS2FQSndaU0Fy?=
 =?utf-8?B?dVc2dktWSmcwNytOR3dBeU1VVG1hVGhLaHdlYi9pNWxnckRLWXpkYmE5RFZp?=
 =?utf-8?B?THFEQ2JvWFppTTl0Zi9sOU11RVRKNzByL3lzRTVaZTBjTGRZdFVOUXZ1Qk1O?=
 =?utf-8?B?MHRLYm45N0FRT00vakpIYW8rMWJLWWxzRm9xbGc1OThZRktQd3pKakwzS0hI?=
 =?utf-8?B?Umt6VnpvSnNmOENoeGtMQkpjYWN1aHhWc1lUWmhDQlVhS3hOTmRJaHAvNUp5?=
 =?utf-8?B?TWdaekRacURpb0dBbkZjUTZTM3VDd2oyVDl1SzRjQWxIWG9ibjNyMGt6bmFS?=
 =?utf-8?B?MVVET1dlcGNIRzk0ME5SUlV0M0tIcTNJMXh5dDhTRDF1QTAyV2Nmb1NJVVk2?=
 =?utf-8?B?bndyRFNVTmJqNWFxcHRjd0FFYVNqZTYzTUhoc1d2d3h5cnZPcTA5V0M1QlJC?=
 =?utf-8?B?N0lOaFdJZVMvekdGZnFYYjZYUlRudVRVa0lSc1FPRU9OaGo3M2hMQzV5Qmtr?=
 =?utf-8?B?Q2ZiRFE2bEQ0OVZHbmFIcWM5WmUrWXZxNjZtbzV2NmFCa3FrbzVvUFlVMU5s?=
 =?utf-8?B?TzFmT1lyM1dNM0JhZGhOWHFCTUtNSFg5ZFMzV0M1Zlc4UnAzWHpacG0xOFFq?=
 =?utf-8?B?RmhKb1NHMTQwTlpJR1VGUjdkZXZzTXZ6eXBMYnZuckQ4eWhnaGUvODBSMzdE?=
 =?utf-8?B?TmY2Z2tCcjBmQXk1UlNyZ2FHMDA0ME5kdDVnaVZpd2FsUnhEd2toUVFWUENK?=
 =?utf-8?B?a0xVVU82RDI5UG1PcjcrTHFUWkd5eEkweFdKSTFFd2ZaQUNTY1hsYU40eWgv?=
 =?utf-8?B?QXJBK0ZuZndnN1ZLWG1qTXptZ3ZjS3h1OHZBMFgyaEVmbmRSbldwbWdUdG9L?=
 =?utf-8?B?Y3hhbkxBMW1WZHQ0NGUxQnE5a2xyYjBiMkppUzk1aEY5M3FydmpxaVpsRGtu?=
 =?utf-8?B?WW5ad1lWVVVqSWUxdjJ2SGRzNUVUSmFYdkZFNktiSTltaFkyU1IzR3AxSXY1?=
 =?utf-8?B?UWhKb2hJRTBqbjRBendITzhJMmdNNHJWVXg3c3kzKzlyUllDZE5lWVhJNEhB?=
 =?utf-8?B?ZnduS0RhZEQzekJtWjNOU0pGMWQyUHRFTFZUWEJjdzJ0c3MvOXpPbFpjb3dw?=
 =?utf-8?B?a2hDcjkzcngzVHBudXpZZWpGa0xJdHhSRzJ3Q3FleWZ4cG9pVEVYMUViZThh?=
 =?utf-8?B?aVJ2bEdpdEtrSUNBZFJYK3JjM1Y1dUpEYVBWODY5VGN2OWxyQ0VPZEphNmFK?=
 =?utf-8?B?M1ppUzVWTmdweWc3QXRxaEVLaStLZ2s4dTZ2NWhPZWpQVmppbHNCUks2aWxa?=
 =?utf-8?B?NVcwV1BFMVV1Rmh5QlhqQ1lXOHpYa3o0S2h5bEtGZ212ajdJRGpEMW5yaS9X?=
 =?utf-8?B?aDlNWjB4amNtZUN3bzRFa1FOY2ZxNFRIcDFEY3J5ck91VmFjTGU2RG55d043?=
 =?utf-8?B?U0lJYmZ3WkU1NmZ2dit4ZG1hbU5NTFhPVnNBV2VZWUQwN0FiQWQ3bEI2NHoz?=
 =?utf-8?B?ZDFwQ0RUaWRJRTJQbmhaUlhod2RIT2dUYUw1VDd1dE9iMkQ3cDNDY08xdGR4?=
 =?utf-8?B?NmxXdnVDQ0RSdUZCUzFianp5a2FoQkw3L3ZyYXk0MnVSOHNGNkVKVzFmREZ0?=
 =?utf-8?B?eXdRTHdoSTVFR29qcm8zWFlCUlZqNmxxekZxQkpNdW1YZVVMR3FVTW5SNVdC?=
 =?utf-8?Q?OitT99cxH7oP1dX63/3uMpCOzpa7hDdW?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q2VnYi9HK2RyV0xBS1dtWURJR0g2Z1dOdVViWTBqVUlEdUw2cHhXM1FhWFpv?=
 =?utf-8?B?NmpxVHV0TkxPd2trTHJPZ0lYSmlLa0pSeHd4cTVkaHN4NjBpRERxUldCbWhW?=
 =?utf-8?B?MHZHMVhGZndsQ0RWTkxSWllQWVM4UE9BTUNRd2RiRXZTTzZUbzdGSnpuWEJ1?=
 =?utf-8?B?em5BaU1abENOUlpuVDlkK3lyT1JYMHljNzVIQ3YvVnU5SHNYMFpkL2liSVZF?=
 =?utf-8?B?bldiczcyZWRZVWc5WlpOck16WUd3S3dwSU9UWDVONVRYQ2gxYmxiSFZmS0pr?=
 =?utf-8?B?UVlwa2dvZlhIcSt2WDFPYkgrZGUvejFnbDJzZk0xRUJ6cmc3RFFRWFF5T25q?=
 =?utf-8?B?T0tWT2pOWU93ZXZhNk1ZMVk1ZlhsS1I1V0l1Nlh5V3JVeEVTUkFxMkhuZ3Nt?=
 =?utf-8?B?ZEY3SDEvVUsweVVWTWZRUlJvQi9lV2dFRHdzRHcxUmRMN3pnYXpOeE02b3Y2?=
 =?utf-8?B?aUJ3ZTZBa2ZyNmRBNk1xSTFFdTBDOXVtWHYwdVJGa041TXZEM1FBUWpWTUI4?=
 =?utf-8?B?S2FaOGJjcjZFQ281K1dkMm1LUEtTRlVrTk8rSmNMSEdZOU5ZV2NobDJtWjQ2?=
 =?utf-8?B?RHdyRVM0Z0xKdkd3c2N2akdBaG9Oc09YbEswS1Q0RzcraXpCWnJMemxLOUMr?=
 =?utf-8?B?SFB6cEZ3UTQ4TFU3K3h3d3Y1SDZrTFVKeG0zV0RVbWh4b2hNbDI2eXRJelJr?=
 =?utf-8?B?K1lFME8yZ205NlZrc3Q1VkZiWnBMaHdPQkcwcTlSTzhEWWFFMzA0NGczY0pS?=
 =?utf-8?B?bnY3clFWTDNoem1Xem9lRzVjV0ZhTVJKa2lFWmVCdlZObUpZRG1tTEJqWXpS?=
 =?utf-8?B?WkRYTFBFbHk3TTNPN2dMOE45NmFIRjFhZnZhbnB6SnVUa3ljUTdFNEk5SmhE?=
 =?utf-8?B?QjY2QkVsZkMwWms3cWFNQmdyaTZsNko4c3FFdG5LTjNhajVmRnp1R3l0L01P?=
 =?utf-8?B?UTBuNUxjeTlxeVprbjk2NnFxNWk2eVdlRU1USjlmWVgzVnluZmN1ellQMkJY?=
 =?utf-8?B?VUxEeTlQLzdiWk4xSUlFeTdCMHUrTGRaalZlTVNMR2NsaDZxdTByK0lGTitP?=
 =?utf-8?B?clgyRlpYMlVPNWtXSnlIV2F5VjBvK0NaZEQvRjRhRjVaM2xjZW5DN2FwUmpD?=
 =?utf-8?B?TlJwZThWbEkvWlo4OCszZEFXMy9tcEFqRlYxZTdlUU9EL05Na1Z3alM5bTRV?=
 =?utf-8?B?VVgzWTRVemF2WW5VTzZSQWVaMzFKbXRKMDhSMmpKdzBCbmpBRGlNWGNyUjkr?=
 =?utf-8?B?Qk4yalBROGlxT1BMK1BtbE1rUC91dnNPL1FWYzRVRzdrK203TUtuMXNVb2Ra?=
 =?utf-8?B?TXE2bDF1UlptVkxwZXVIVTdPbGdYeGk3UU1OdmNXSnZNcXd0SWpjbmQwUXk2?=
 =?utf-8?B?M1I4bnk1TWxIUld0U0ZNZU5uU09uVlRtSnpWUW1pUXVvOGtYQ1ViY3RmRm5s?=
 =?utf-8?B?c1BFS0EwRUtqUk5jVVdWdC9aYm9QSm5FVmhjY2graW52Sjl2OTM2TkoxaEp4?=
 =?utf-8?B?aTQydkpNWERHdEE1RktvU0VhRXV1UFhHd09XZWRWa1BLYzEybWJhMVpIT3Y3?=
 =?utf-8?B?N0NQMm1TQmZVTzFPM0M5UW9vd1VDMG1tQkpwaklSVVV3bVhvTGx2QjNEYlJw?=
 =?utf-8?B?NzIzRDcxK0pzTDlnTUZXaXJpOWVrNkJ1aGN3OEZvMlE1b3RLS1lPWHJqZ09L?=
 =?utf-8?B?VEpSQSsxdDYySTBGSkw2K2VibnJQcUM0UTBCcmFJSWtMUlQwdmZtU1h5cXJ3?=
 =?utf-8?B?UUZQSC96TitUR2JrZWN3UER5ZXViTVhna3k0Zmg4NkZXd2JId04yWFRhR09F?=
 =?utf-8?B?VnhiUlh2RndZbkRwTVdWSFNxeFdJRnlza05aU3psMzZlSzJlVDhaRU4xV2ph?=
 =?utf-8?B?dkpOTDI1MDdlWVlKY3JPMnZEM1VxSnlJOFZwVlE2R2FlNTIrZTAxbjdjS1Ft?=
 =?utf-8?B?U0NjcHdGRGx0Y0JVM21QNXdsT29NbWlHajFiMUk4Yk5SWit1dENyNS9LUElH?=
 =?utf-8?B?MkxZOVJobUtSVE5vYjFtQTlmaDIzTmIxZFFHRnJxYWFuTFNEMEd0MnhSNmky?=
 =?utf-8?B?ay8yNFR3OUg3ZnA5RTdTYURSS3BiUXc4M1pJbjlvc3JjTkZKYkhWSG1ETEQ3?=
 =?utf-8?Q?cS9Z4xn72iZqQRNyP/+cJVtIm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AxaerVJj5H2J/+0tKJOtiq4pR+Bu+oczK/GMrbLg75Y1ub4S+K15ZpysYZ+26AlhUqm1TYUjoKAjX7h2GSyRwIfQCNY/pmxmrV1cUINgz8IJl8U+jCQIUj/wAB1lrxTM/WzMHtreMbov4jKxx7UpG0CWtAPGF6jwNuuMA6376XQmswNh7AjhaKiN1AoIZP86ZlhvoimtGVrNlM7lj4QpNRR6tXmvKOOnuQnlkAFe6pColpYoJ0XvvVqQjR5JGLLD8bObFRb8AVzNWMCIys3Xx+2sFMoG7zd5EC5/ybI1XeXaiekmJEoWfcUAzxfn2CCxgccu1f/X9+BkYs+V3ddlfTytVRfxKFKFN8ar+O2ML7g0ZVrW1VYE9onu/gNBWGYJnd/n2UADXSAEmM9BYjsNTZt2VJPL4gxjoWA7dVd9BU0oO1T0Sp63R+UEN5qf29z8BZiJgN5WVZhQZXM4FvfBd97DwL8UQDFbmH8nAeHlN2EL2I03yuARm6aMhe1Ga2mNC+5rmjCMGwas5/H849mqgGfAvBjmQdzaCwgpe207OsN22tbywIVcwfwxJlgNHsSPM+ubJnaLXrIoUH38Ljcs+kii+/1rDTss4HaPkc1aJHQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33290919-de78-4257-4ebb-08de0c16fec4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 18:16:43.8455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsLIyphmf2tzaQyADDKKJSpvmdBarud2Z7dvniDUSbD3nIWxp5/8iYUH9eXNCucA5/dhedZruWLlA02EPTSogQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF18D5A7206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510150134
X-Proofpoint-GUID: kEnOdWF9o3P63BjIsPNdHu6DXWFS30aU
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68efe510 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Cy5bhgkXkuD0PYqwbt8A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfXyve8XzKM1PzL
 eRg2UosDrthUgRHaT1lYkeUnb0XLAVBkDMqwkuNd2CoFbENvazOEL8JnAZX996vGAbQ6Fh23mRA
 nzniRrEJcFNWgJbQeLTDzJdLauTUDuA1w7a8ReduGXcJgtzltFqITZNxtG8YhByqkuVjGHoDJbJ
 BW5lmlj+HfiD73mueL3sd7ncjEixeCPzCZTinuEnoiwMtNMswzH/QN18KnL5epmm20bvk0kmLdy
 b00hs1fysNJQcBSRjm+JjcE6kfJQBX4MNd9/Zfhp8jIjCBa+gDizI5dCMaZvUEHl7Osj8ptxou8
 PnlWxsvU1LLOhSSHD3vABzhtgGP4Of391JzxocBiL9Uj46iB3fbBAn++aFUy6xSHgBQsPN1iavC
 wHohGVc4V737YGCzpgQFLjzReMueuA==
X-Proofpoint-ORIG-GUID: kEnOdWF9o3P63BjIsPNdHu6DXWFS30aU

On 10/15/25 2:11 PM, Jeff Layton wrote:
> On Wed, 2025-10-15 at 14:00 -0400, Chuck Lever wrote:
>> On 10/15/25 12:53 PM, Mike Snitzer wrote:
>>> On Mon, Oct 13, 2025 at 03:01:13PM -0400, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> In a subsequent patch, nfsd_vfs_write() will promote an UNSTABLE
>>>> WRITE to be a FILE_SYNC WRITE. This indicates that the client does
>>>> not need a subsequent COMMIT operation, saving a round trip and
>>>> allowing the client to dispense with cached dirty data as soon as
>>>> it receives the server's WRITE response.
>>>>
>>>> This patch refactors nfsd_vfs_write() to return a possibly modified
>>>> stable_how value to its callers. No behavior change is expected.
>>>>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>  fs/nfsd/nfs3proc.c |  2 +-
>>>>  fs/nfsd/nfs4proc.c |  2 +-
>>>>  fs/nfsd/nfsproc.c  |  3 ++-
>>>>  fs/nfsd/vfs.c      | 11 ++++++-----
>>>>  fs/nfsd/vfs.h      |  6 ++++--
>>>>  fs/nfsd/xdr3.h     |  2 +-
>>>>  6 files changed, 15 insertions(+), 11 deletions(-)
>>>>
>>>> Here's what I had in mind, based on a patch I did a year ago but
>>>> never posted.
>>>>
>>>> If nfsd_vfs_write() promotes an NFS_UNSTABLE write to NFS_FILE_SYNC,
>>>> it can now set *stable_how and the WRITE encoders will return the
>>>> updated value to the client.
>>>>
>>>>
>>>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>>>> index b6d03e1ef5f7..ad14b34583bb 100644
>>>> --- a/fs/nfsd/nfs3proc.c
>>>> +++ b/fs/nfsd/nfs3proc.c
>>>> @@ -236,7 +236,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
>>>>  	resp->committed = argp->stable;
>>>>  	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
>>>>  				  &argp->payload, &cnt,
>>>> -				  resp->committed, resp->verf);
>>>> +				  &resp->committed, resp->verf);
>>>>  	resp->count = cnt;
>>>>  	resp->status = nfsd3_map_status(resp->status);
>>>>  	return rpc_success;
>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>> index 7f7e6bb23a90..2222bb283baf 100644
>>>> --- a/fs/nfsd/nfs4proc.c
>>>> +++ b/fs/nfsd/nfs4proc.c
>>>> @@ -1285,7 +1285,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>  	write->wr_how_written = write->wr_stable_how;
>>>>  	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
>>>>  				write->wr_offset, &write->wr_payload,
>>>> -				&cnt, write->wr_how_written,
>>>> +				&cnt, &write->wr_how_written,
>>>>  				(__be32 *)write->wr_verifier.data);
>>>>  	nfsd_file_put(nf);
>>>>  
>>>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>>>> index 8f71f5748c75..706401ed6f8d 100644
>>>> --- a/fs/nfsd/nfsproc.c
>>>> +++ b/fs/nfsd/nfsproc.c
>>>> @@ -251,6 +251,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>>>>  	struct nfsd_writeargs *argp = rqstp->rq_argp;
>>>>  	struct nfsd_attrstat *resp = rqstp->rq_resp;
>>>>  	unsigned long cnt = argp->len;
>>>> +	u32 committed = NFS_DATA_SYNC;
>>>>  
>>>>  	dprintk("nfsd: WRITE    %s %u bytes at %d\n",
>>>>  		SVCFH_fmt(&argp->fh),
>>>> @@ -258,7 +259,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>>>>  
>>>>  	fh_copy(&resp->fh, &argp->fh);
>>>>  	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
>>>> -				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL);
>>>> +				  &argp->payload, &cnt, &committed, NULL);
>>>>  	if (resp->status == nfs_ok)
>>>>  		resp->status = fh_getattr(&resp->fh, &resp->stat);
>>>>  	else if (resp->status == nfserr_jukebox)
>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>> index f537a7b4ee01..8b2dc7a88aab 100644
>>>> --- a/fs/nfsd/vfs.c
>>>> +++ b/fs/nfsd/vfs.c
>>>> @@ -1262,7 +1262,7 @@ static int wait_for_concurrent_writes(struct file *file)
>>>>   * @offset: Byte offset of start
>>>>   * @payload: xdr_buf containing the write payload
>>>>   * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
>>>> - * @stable: An NFS stable_how value
>>>> + * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_how
>>>>   * @verf: NFS WRITE verifier
>>>>   *
>>>>   * Upon return, caller must invoke fh_put on @fhp.
>>>> @@ -1274,11 +1274,12 @@ __be32
>>>>  nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>  	       struct nfsd_file *nf, loff_t offset,
>>>>  	       const struct xdr_buf *payload, unsigned long *cnt,
>>>> -	       int stable, __be32 *verf)
>>>> +	       u32 *stable_how, __be32 *verf)
>>>>  {
>>>>  	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>>>>  	struct file		*file = nf->nf_file;
>>>>  	struct super_block	*sb = file_inode(file)->i_sb;
>>>> +	u32			stable = *stable_how;
>>>>  	struct kiocb		kiocb;
>>>>  	struct svc_export	*exp;
>>>>  	struct iov_iter		iter;
>>>
>>> Seems we need this instead here?
>>>
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index 5e5e5187d2e5..d0c89f8fdb57 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -1479,7 +1479,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>  	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>>>  	struct file		*file = nf->nf_file;
>>>  	struct super_block	*sb = file_inode(file)->i_sb;
>>> -	u32			stable = *stable_how;
>>> +	u32			stable;
>>>  	struct kiocb		kiocb;
>>>  	struct svc_export	*exp;
>>>  	errseq_t		since;
>>> @@ -1511,7 +1511,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>  	exp = fhp->fh_export;
>>>  
>>>  	if (!EX_ISSYNC(exp))
>>> -		stable = NFS_UNSTABLE;
>>> +		*stable_how = NFS_UNSTABLE;
>>> +	stable = *stable_how;
>>>  	init_sync_kiocb(&kiocb, file);
>>>  	kiocb.ki_pos = offset;
>>>  	if (stable && !fhp->fh_use_wgather)
>>>
>>> Otherwise, isn't there potential for nfsd_vfs_write's NFS_UNSTABLE
>>> override to cause a client set stable_how, that was set to something
>>> other than NFS_UNSTABLE, to silently _not_ be respected by NFSD? But
>>> client could assume COMMIT not needed? And does this then elevate this
>>> patch to be a stable@ fix? (no pun intended).
>>>
>>> If not, please help me understand why.
>>
>> The protocol permits an NFS server to change the stable_how field in a
>> WRITE response as follows:
>>
>> UNSTABLE  -> DATA_SYNC
>> UNSTABLE  -> FILE_SYNC
>> DATA_SYNC -> FILE_SYNC
>>
>> It forbids the reverse direction. A client that asks for a FILE_SYNC
>> WRITE MUST get a FILE_SYNC reply.
>>
>> What the EX_ISSYNC test is doing is looking for the "async" export
>> option. When that option is specified, internally NFSD converts all
>> WRITEs, including FILE_SYNC WRITEs, to UNSTABLE. It then complies with
>> the protocol by not telling the client about this invalid change and
>> defies the protocol by not ensuring FILE_SYNC WRITEs are persisted
>> before replying. See exports(5).
>>
>> In these cases, each WRITE response still reflects what the client
>> requested, but it does not reflect what the server actually did.
>>
>> We tell anyone who will listen (and even those who won't) never to use
>> the "async" export option because of the silent data corruption risk it
>> introduces. But it goes faster than using the fully protocol-compliant
>> "sync" export option, so people use it anyway.
>>
>>
> 
> Somewhat related question:
> 
> Since we're on track to deprecate NFSv2 support soon, should we be
> looking at deprecating the "async" export option too? v2 was the main
> reason for it in the first place, after all.

Based on my experience with a few folks who have productized NFSD, I
expect there would be howls of protest. "async" helps even the two-
phase WRITE in newer NFS versions perform faster.

I've made the point that modern persistent storage is so fast that
"async" is pretty meaningless. Some folks still have slow storage
that they need to share via NFS, however.


>>> Thanks!
>>>
>>>> @@ -1434,7 +1435,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>   * @offset: Byte offset of start
>>>>   * @payload: xdr_buf containing the write payload
>>>>   * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
>>>> - * @stable: An NFS stable_how value
>>>> + * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_how
>>>>   * @verf: NFS WRITE verifier
>>>>   *
>>>>   * Upon return, caller must invoke fh_put on @fhp.
>>>> @@ -1444,7 +1445,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>   */
>>>>  __be32
>>>>  nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
>>>> -	   const struct xdr_buf *payload, unsigned long *cnt, int stable,
>>>> +	   const struct xdr_buf *payload, unsigned long *cnt, u32 *stable_how,
>>>>  	   __be32 *verf)
>>>>  {
>>>>  	struct nfsd_file *nf;
>>>> @@ -1457,7 +1458,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
>>>>  		goto out;
>>>>  
>>>>  	err = nfsd_vfs_write(rqstp, fhp, nf, offset, payload, cnt,
>>>> -			     stable, verf);
>>>> +			     stable_how, verf);
>>>>  	nfsd_file_put(nf);
>>>>  out:
>>>>  	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
>>>> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
>>>> index fa46f8b5f132..c713ed0b04e0 100644
>>>> --- a/fs/nfsd/vfs.h
>>>> +++ b/fs/nfsd/vfs.h
>>>> @@ -130,11 +130,13 @@ __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>  				u32 *eof);
>>>>  __be32		nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>  				loff_t offset, const struct xdr_buf *payload,
>>>> -				unsigned long *cnt, int stable, __be32 *verf);
>>>> +				unsigned long *cnt, u32 *stable_how,
>>>> +				__be32 *verf);
>>>>  __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>  				struct nfsd_file *nf, loff_t offset,
>>>>  				const struct xdr_buf *payload,
>>>> -				unsigned long *cnt, int stable, __be32 *verf);
>>>> +				unsigned long *cnt, u32 *stable_how,
>>>> +				__be32 *verf);
>>>>  __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
>>>>  				char *, int *);
>>>>  __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
>>>> diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
>>>> index 522067b7fd75..c0e443ef3a6b 100644
>>>> --- a/fs/nfsd/xdr3.h
>>>> +++ b/fs/nfsd/xdr3.h
>>>> @@ -152,7 +152,7 @@ struct nfsd3_writeres {
>>>>  	__be32			status;
>>>>  	struct svc_fh		fh;
>>>>  	unsigned long		count;
>>>> -	int			committed;
>>>> +	u32			committed;
>>>>  	__be32			verf[2];
>>>>  };
>>>>  
>>>> -- 
>>>> 2.51.0
>>>>
>>
> 

-- 
Chuck Lever


