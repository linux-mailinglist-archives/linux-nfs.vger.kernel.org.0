Return-Path: <linux-nfs+bounces-10067-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C1DA331B3
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 22:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066401883D9A
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 21:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849CD202F99;
	Wed, 12 Feb 2025 21:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nEZjPtVc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZxGP8NDI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD281D5143;
	Wed, 12 Feb 2025 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396529; cv=fail; b=SSCW327Kt9cdpygAhFbeEq6lNYjzCz5vso4WGFPYqNkDgTG0QvzJrTcRYYgdJ852fZeMr4pOUDAVzCSOPwsWEcjgVbSbbXz+bQOEztytsSS38FMyN9shwK3Uw0f3QhLucDc7QV/cT0+dQvcWDi1BnoeisWVyaWXI5QLY6zh8Iz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396529; c=relaxed/simple;
	bh=hbIKQZaif/8DKIq2WB8WpwON+EzvqlUuGeP/YP/29IU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DhlC6edddA5gXh+RYlaI6n7DLtkYONzMx3cT6vnFd0Cx5I+24rNh3is/6UYB8jArZjy9yZhVTQxQ+WaAY7fOcXHX6W6JTDX0GjIWFoVRZPijtv3dKMMgZICtmbn3ZJPfsCs480UfogP2qs1SwN0cPuOuThoKN8jwcZ4TfmgOs3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nEZjPtVc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZxGP8NDI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CEtq9N008892;
	Wed, 12 Feb 2025 21:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=srIAz4vmOnx1OXsnMSgvil2hxpDQqwppYhczqEdK83k=; b=
	nEZjPtVcsDOjHJPIxqmSTxiuNwUB34TaQES6Id1hNSBEbEUhOF4K0VdnoMLBhcfA
	yiFAhjrs1G/nxoPC8TSPZpWD5irHMzlkNBZJ+UAPmiNh0vRIEic312UirdQIipTZ
	Yox3oK0h3KwrWD+Pk0PlR+ZYW6nXjgodq2DJTn+bo+aJbL8T9CBZ5oroKOHo645G
	aNNGbE8fBF7ljTloHqjZeY0Ln/cbZwAOeLVV5LYIwY+HliPAzmErsT/VN2ZI8E4j
	H2VHX1pWxyfk8BvNtDUwwcNkOxTv/tlK1ryoeAGugFNMRQ5pGAyKEkwAx0XHUZnl
	AufxS2tEkkB8YglE7RDBJw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qyreg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 21:41:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51CKAq7f030525;
	Wed, 12 Feb 2025 21:41:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p631ap4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 21:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siT9T4vdY4Jr6RhlpJVGnOt8VApCYKDCL8vzyzAtQb0XTUFLb8w5ESgzv2a9xCkraE0+AuG3z/7cgFvI5uJtFSl7RWshF34u2cOfgCnYlk/RbqTSV/giLLsfDhMAN73jEbGHiOXWge3ReoCkXSTneeNBEAvPjBvM0MIH7dS46yfbzDXx0UQxuvgnBHcnvXMICSkh/gvKquGGt7zEQ/0Hsv8AfbVmVBwp0tg8dG7szpPt//EAnm0IZtgu1etADLkQSHkT+jtDnP60ne+CkXox1tsxVCINqSBWsoiSnzOy7/bBT6RDvGe7vMgbfIKsFZw95hi7EE6p6hswIjUdet0bMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srIAz4vmOnx1OXsnMSgvil2hxpDQqwppYhczqEdK83k=;
 b=diFSlvfOdTdAgwdMOAc+BrLU+GuKX9GjOW4X4iVnd1IOD0S8eLipAK3mYaDDWIPFXA6Z7RKAkeC8MXbwqCIhhLtrJjCcehFA3a9V2G49eb+hswDPnrDVmZH+CFLVgOY2GGMnZWAtY9MutZLbEEKotexgenf9J1hjkKH5QAv7H+2Y+Xe0mIVp6CmTj6gWhrahjd9DWcuoIocJU5gucvrkEhjd62fqXb2+h+mvhNlTZ4fYXbrIFa/XQRp9sAtjMYbOku5zfmayrNJffp80oIhSCVL8gbFFZQvLIkwL0h1+TvN7ERiJoTNqlRGBoTcIXGfOjci+S/qLpOurBo44MShVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srIAz4vmOnx1OXsnMSgvil2hxpDQqwppYhczqEdK83k=;
 b=ZxGP8NDINl4zDGp23eiIoIGBkEgl5LLP7AbrA1YLqYgUuWIJU3nt/SGP6rXa/40H7nhphtjuwmb75fRQ4Bzbbkt6cj3zX1E+cYbJ0OXRGAjFUzu52u9WlHO9DQWZeTMPT2mN/eo8awKC2c5Ak4Q77WGK4J5CVFBcyNA7dFI0dCM=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 12 Feb
 2025 21:41:53 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8422.010; Wed, 12 Feb 2025
 21:41:53 +0000
Message-ID: <41f5a8cc-8a8e-4a67-b889-7dc7fa39fb19@oracle.com>
Date: Wed, 12 Feb 2025 13:41:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: allow SC_STATUS_FREEABLE when searching via
 nfs4_lookup_stateid()
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250212-nfsd-fixes-v1-1-935e3a4919fc@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20250212-nfsd-fixes-v1-1-935e3a4919fc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0009.prod.exchangelabs.com (2603:10b6:a02:80::22)
 To MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: ea75afa4-3995-469f-953a-08dd4bae10a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejFxYUFtNUtjQTJwRThTOU1HWi8va3pkdzdiam8xUEZCempDOXFXUDh1WDZp?=
 =?utf-8?B?TjlvdDZBSlFMaFJxWi9iTlFYemJvTXhURGtMMC82My9LNG1UTFZPUGE3b1Bq?=
 =?utf-8?B?eUhzczh4bW0rVkhhaDFpYXBLTXhwUmh4SlJGd1JudzVmQzNtSnBUamVPcHhq?=
 =?utf-8?B?RFFxZVp5ZWFFODNMbjY2Z0ZoblI0aVZ0TmhvOUdMMWNoWVhCQ29HMFpZOFM2?=
 =?utf-8?B?d3VSSythaDdKYU5mdkE4Uzl4MVl5Z3RFaVZyV0praU1HcHhkbCtVbEphb0FH?=
 =?utf-8?B?cFRhMW5JUnhTZjhYUjhXWGhwYWFQU1Fhcm5DY2ZXdWpmcXlZN2c4TE1TRDFO?=
 =?utf-8?B?S3dMeWgxSjV1NXFqVkp6TkZGVmJ4MnR4YmdRQnJiQy9jdWpSZURTa3NrSkZx?=
 =?utf-8?B?b1lBbmdZV1NuclJRZVJPOUo1WG5MVGVKR1dKWHljb1pjektic0Y0bkkvVXdW?=
 =?utf-8?B?K09EcFU2ZkhsMW9RY3I3ZHZCR3ZHdi9HNlVvYWRpM1FubXR5TUtyT0E0RWR3?=
 =?utf-8?B?SERCbDN4Smw1elFnTmhnYkJFZHcxTDczZzdrNSsrNHBnckdRZ1dVQWh6Uk93?=
 =?utf-8?B?RDJlN3ROcldycjVkdXZ3VUxTTVE5MlFiVWUycTg0Y0xYZEtqc1E4T3JZZmVi?=
 =?utf-8?B?ZUt3QURQbWl4OGZrNE5pNGE3V3d1RkVWdStnK2JMWGNjUzdBT1Nrc2RYNXBK?=
 =?utf-8?B?TEVsNmRoeW44UzUxY0hXWTdSQXpoa0pCODR2T25zVHRlYVhsdlZFSzdZcmJy?=
 =?utf-8?B?L3hxOVB2T1A0cERFbjRydmw1TWFHcnBtTThFRHhHOGJnWHZEdUNoSmJmbFRx?=
 =?utf-8?B?YXlReHFuRzFtVGxlR1JkMlhFU3dnOEJOU2FKTjFoVFZNejVEampCVjFmRGUx?=
 =?utf-8?B?SGVkMm54UmY4NzJLK21naGdXNlRPaVhSdm8ydFFOQ1I0MUZlVURnZC9KSlNh?=
 =?utf-8?B?Y1VadmRvUnc4eTRHSGZxTm43VGdURzZCQkZBbHBJNi9sZ2ZWckpDcllWcXBF?=
 =?utf-8?B?NnpmRzMya0M4dkpsQm0zR2dUWEw4RnF3aUJWL0NpUzF6eTN0S0VHRDVTa0th?=
 =?utf-8?B?L3MxYlFVQUI3RGhKOGtPa1RITWd0ZVVhM2czQUlEbnNWcWpMVm1LaSswSi9m?=
 =?utf-8?B?NDlGUkRkaVR1QVMreEIrdVNoOUJ5d0VzNlk0MFZEdFZvSno0NG54TXJleTZm?=
 =?utf-8?B?VFRLZEo3L0RWd3o0N2cxbVhkcS8zUU9tRCtoTTBieXp2WEk0TzdQZ1VyRDJs?=
 =?utf-8?B?SmhpTjcxdWZLaXVra1pJQjhLMURPbVM0WmVPMTU1SXFleFFmODArbDZ1VXRK?=
 =?utf-8?B?R25BazdETzljZEZ3R0JjZndZcUxFY1ZmZmN2aEZkK2xhU0I2bmZhckN5VGMw?=
 =?utf-8?B?SmlWYk9aVDNUN1FEL0JIQzh4RXpsSlZ6ZE9kdHlLK2FCeGlFZWI1UjBRUUlX?=
 =?utf-8?B?Um1wMTdXZVBDd0RwUUh2K1FtdG9VZ0NZLzhKQzlraVN1bFFoSmhydXJKaGlD?=
 =?utf-8?B?Z0p0eERQV3piZlBIdGM2ZWNRTG84TG13bjlUbGVFM1dJQ1Ruanh4QTJLZWs0?=
 =?utf-8?B?YkpyalA5VlJKVWo0cHRvSzNUU2ZwNXlvZEk3dzlKZEFTNzdsRVhZRkVvNWxw?=
 =?utf-8?B?WmhZSzZDbm5xamVYQmFXYUxEYlY4RkJ0Z2F5Umc0RVRMVTV1UEdXU1hTNWhO?=
 =?utf-8?B?TmwwSVluYUsvUExJM0E3dmt5N3MydThsd2ppTDlsWlpOQ3laTi9RWFBFWVNB?=
 =?utf-8?B?bkRVZCsrcXJncGpDbDdETHFsYXdkZlVZdlNlM0VCcm4zS1pHM2hOMHpFRDBW?=
 =?utf-8?B?MFFmRm9ER0JFaHlmSVErR0JadXgvRjl0Q1VPYk5RWFlsbUZTMHorWGwydytj?=
 =?utf-8?Q?/0FHg/e0s607P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sng0ZE9wMzBmZmFrZTNjMTZCc0dBOVJWb1BmTTZ1b3F6d1dYYkJGR2taUWxh?=
 =?utf-8?B?N1BXYnU3ZTRNK2xwdTJJLzhCQUkwVkQxODdUSmg1b25PL0xkRVo0N2VTLzRL?=
 =?utf-8?B?Y29neHV2N3NMMXNNU0I4aGFqbmpyL0FoL3dGYWJzTzdOZldBcFR5L3VraVFL?=
 =?utf-8?B?a084VTNKeGtkNThSa1pMc3p3eklBd2puakYxM2t4SWJqT3grWWpzSTlvYUpB?=
 =?utf-8?B?eGlVK2ZmSmdmWWJWemZnTC9qVUNYWklvWWlUTDFZUE8vMnRGdDJNNHRBZENx?=
 =?utf-8?B?Z2ZMUlNPb050bGhWTElicm83NHBiZ1BtMUFQWkhRcGVuSXlkeEtsRG96ZmNw?=
 =?utf-8?B?SW9FR1B5QjRMb3FMRXdDSUQ5YkdadzJ1MEFLSVBBQytIUGxvU2libU5kU1BP?=
 =?utf-8?B?VXN0UHJremdJNS9HRjBRQ09SajN3UzlCNFVmVjJ6eWcyemYxa3UrYm1zUWJO?=
 =?utf-8?B?Um9FZVJEM2hSUGo0UTVDTUgrWkJWcEw0SVJDMGJGQ3ZZMlJxRlpkZzhTdkVK?=
 =?utf-8?B?eDZkYzBaeU9GUXBxNnBIS2R5TUdvMUgwaE9ENEVabmJzVjdRbGVycFBqODlu?=
 =?utf-8?B?L2ZLRUpJdU5qZW1xZ3pvTDM3YXJEVDVyWjliYm5JUGdjeWZIb1hyYmNRTDdl?=
 =?utf-8?B?SnJpVXR4dTFOeVEvb2ZNWSswMnEySnR1WERmV3BXelEwaE1RODdoanFhbGc2?=
 =?utf-8?B?TmtIQlpTbEt1Q0JWV2Vkd3J4c0tXNUpzSytGdVpMTy9aWktHNk40MC83djhL?=
 =?utf-8?B?YXpkbklaK21BWXRhTmlnZVJMYUl2SFphT0wwcGdtd0pBZXNqRmFiLzJpOGhv?=
 =?utf-8?B?QWJKR1FQeGtMQUo3Z2ZOKzFoaGpQSisvZkV6VVhBNUlKOTFVekE4bXNKUnJn?=
 =?utf-8?B?djVVODJuYWMyVll0OTNkZTl1c3Vkeis4TXRBd0llVjNpcGxxQ2ljSVhaeHVS?=
 =?utf-8?B?eFdJS3VIMDdncndPVDhuYjN1MHdpQmRBeDQ1TlBZRG5XditadmJYeGgvZmJG?=
 =?utf-8?B?LzE5ZDN6R1FWWWxxcFlrQXV3VElvTDZ0Sm4xVmhYTVFUL0ozMVFIYjNxaVJP?=
 =?utf-8?B?SU5BUFBmQkdxTjV6cHZxTzR2aGpublZYUURXLzVscFhhY0cvZWY3WEJmSE5T?=
 =?utf-8?B?TG9oRE1MNktmalZEcmNHdnYvdUovbnJ5aEJkbFZlL09FNVJYSFdlRHdoU0Qx?=
 =?utf-8?B?OGlkdGJ2enBVN3dDVzRXYlUzMzBsSm9hZW1ZV2o1Sm5wNXNLWnFFUHBRMTNs?=
 =?utf-8?B?TXd2ZngwMmZlb1dxSXZwN29abUFjY3BCUitnRnB6ZWZyMTllNGt2cjBpeVk3?=
 =?utf-8?B?aDNyc3RDMzBOdHo5WTE2OHVQNkN2aC9yZ0gwd1NmQnV4cWRIcVhweDQvcEJU?=
 =?utf-8?B?d1BXSnNSb1BLd3V4VTNDNENKM3RGSVpreTYzZ0FWZjFiU2NnUHFybU95aDBJ?=
 =?utf-8?B?alRKWkVtU3dRdnhlWmdkaVRKV3pTYkZlcWZnMzRrc1p5bzVhbDVuWS9DMUN3?=
 =?utf-8?B?RW5lTi9sQkdGc1ZGSlRXbTBGeDJyL2dlMFlSeEFTZElLMFVpbzVQT1R6R0J6?=
 =?utf-8?B?Y0hJK012L3cyQ2M2NHBhVUhnYnFMaElqSmw2SEtMeGJpSGxKWXZBWVdnVXBr?=
 =?utf-8?B?WWlQT0JZc1FUdjJ3SWN3Qm8rZU91UVZnb0pKRFNvMEtibFgrOUNyRXIyd3cy?=
 =?utf-8?B?alJqZWFndU9JUW9zZUorM3dnMHJwRnVraG0wSzI5R2RHL05lMXBYTGw1QmxJ?=
 =?utf-8?B?YkcvUEtFQUZCZHdOZHhMUFIwL2NGZjZYNU1RbWhMdCs1WXR5ZldTRlZNcGNu?=
 =?utf-8?B?NmRCdURaWTZib3MvdDJESDNQcUREdnVock8rLzhLcDNVSVU3ei9FY2dSdXkw?=
 =?utf-8?B?K0svKzBueElPS3QzTWlrR2g4QmEydGpnYWg0cjJXSFR2V0NnbXBHZ3RIQWFU?=
 =?utf-8?B?NitNdm5OeXR2eGphR0FGSlM5ZlBGSFZVU053ZWxhbDY5cnE3aHAyZHNvWk5n?=
 =?utf-8?B?c0piNkZwSzNyd3czZFBQZGJxc252UGd0NkVHZlIxSUp5NjNwd0tIY0ZSbElp?=
 =?utf-8?B?VlFWYmJOZWJEUkVsUUhwbks5QmYzbGI1U1YxK1JCUXU1Q0Fzc0FOQi9xaVZC?=
 =?utf-8?Q?ie6nJe0eWvw0aJ39qpOy/TnfX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c7pSPEaWYChNvwRqjmMDh1nS2GTeWV1NI4NUqhKgxSR/EfKcAGG02kHZ/1Ikot3PMpJYYgE0aIc3cNFyYjprzXpbbw7JtNZk6zKGa3c6XsmPEzd43OoOQhmE2LItStz/djck7ou6B2DHw8Mo4tJZgJmZOCikLygF4LuBThLBLfumxKR2rsG5mO71k+6CB6jEsEqF+FhMhn28CQg0nHeRpiHONjdZJdTURm4uLqiXiBXg/hkLL3CzBnNOv0owiRqy9BN8EoFC6/LDY4Ap8T0hbacvVqzUG6q9yB/mbVTiWocEwnHvcqZb61R5CDUP3gnmDAKgXMv3mYSrDqIsLgA9pd2+fzQzJ7NnzQI9Pb0As6rkyqYPF2UMOU7i2y54XJdTRYZwruYyun/F00gCK1QjR2HvQkm08FnlKsDl2GEhjAbs0aRVx1NErVc5psb2Nt1Ozp1sN/4TbVohmfcA6fe9Mro5E/OUfEUgNVIFfOHUGCVxYkykAMtmvcZ/g9tEhMl/cCnXV+bIawbIzujpI4swRFZ/6onN7WY8DWIOg3ztP8nyCuvWi2pHwOh0pWMJqYiJ0DG/CJDgnPa/KI211bw9Sfe0vWqogbcqjwwObH0nnRA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea75afa4-3995-469f-953a-08dd4bae10a2
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 21:41:53.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tfP74SnFNVGQfKeLBAKSDVR5dYtkXLlDm6ihE6ALYxLCcvGTMP8+oAz/gT1oRfNyE/SFXFoFWV1htFgddfxKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=851 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120153
X-Proofpoint-ORIG-GUID: wM8q-R8IsIoGtRyk2rZwOeVwrVsU-ayC
X-Proofpoint-GUID: wM8q-R8IsIoGtRyk2rZwOeVwrVsU-ayC


On 2/12/25 8:29 AM, Jeff Layton wrote:
> When a delegation is revoked, it's initially marked with
> SC_STATUS_REVOKED, or SC_STATUS_ADMIN_REVOKED and later, it's marked
> with the SC_STATUS_FREEABLE flag, which denotes that it is waiting for
> s FREE_STATEID call.
>
> nfs4_lookup_stateid() accepts a statusmask that includes the status
> flags that a found stateid is allowed to have. Currently, that mask
> never includes SC_STATUS_FREEABLE, which means that revoked delegations
> are (almost) never found.
>
> Add SC_STATUS_FREEABLE to the always-allowed status flags.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This fixes the pynfs DELEG8 test.
> ---
>   fs/nfsd/nfs4state.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 153eeea2c7c999d003cd1f36cecb0dd4f6e049b8..56bf07d623d085589823f3fba18afa62c0b3dbd2 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7051,7 +7051,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>   		 */
>   		statusmask |= SC_STATUS_REVOKED;
>   
> -	statusmask |= SC_STATUS_ADMIN_REVOKED;
> +	statusmask |= SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;

I think it's safer to add the SC_STATUS_FREEABLE inside the if statement
that checks for SC_TYPE_DELEG above.

Also, don't we also need to mark the delegation with SC_STATUS_REVOKED in
revoke_delegation()?

-Dai

>   
>   	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>   		CLOSE_STATEID(stateid))
>
> ---
> base-commit: 4990d098433db18c854e75fb0f90d941eb7d479e
> change-id: 20250212-nfsd-fixes-fa8047082335
>
> Best regards,

