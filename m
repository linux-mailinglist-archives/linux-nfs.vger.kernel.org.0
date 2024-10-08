Return-Path: <linux-nfs+bounces-6955-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27499995761
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 21:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66AC1F24689
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 19:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1340C1E04A0;
	Tue,  8 Oct 2024 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oYikqM4R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LDotFZzL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC181F4FA9
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414347; cv=fail; b=HJwVqGw+7ca5nBrghBne9kTClrB9MBXZXUNO52BGJyAbvbkzwy+3Rv4dT9dNHg5rlC75c3JAUB/Kx0GIbPSUA/kiYJYFLyh4wUhlvjJO1zxBes3LZBqARrEa8DOcwkEnEJ19I9TmY3ef0LXWwf92WCWdEWuqBAcKQzv48Ta5HXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414347; c=relaxed/simple;
	bh=HEVqbO+ymVBLe1Po8UvJOeifIX66JNZS2m1SxOgX5kI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eE247eBbdnJTEOMC868dQ/3JVRiVQhacNURiU+Nj3Dbp0M3zBnIXDOuB/d9afPi/7LdWxRgsrnTixJha6z/hY+k8Y1s1ZwZgLJEiMKJks47jHB//6hUs+Ce33140z78LCUQg3cW39Qo5vRivTrZXDrlGqCZbuP7j8ezS01c7Iuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oYikqM4R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LDotFZzL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498IXc6l022789;
	Tue, 8 Oct 2024 19:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=T1/qnkuq1GSEYbEV0O81VYYIZnAn8z4/in9GF2NWxII=; b=
	oYikqM4RAqFT+wkARSajqVd0roVCoeWLjuhziP6df8Qr63jylw5hs5hOqihu2Bal
	9mkrXKPWQumFT6435tCBiepf/4LHaYFNVHwooDuwLdY/aDvmsfb7cylT+h0AnV87
	W/tSM0enFN3sy14ZYjVtCKi8vK4WWZWv0evIv5F/QOO9KSQRo0lR+JDT02p45pvE
	x0jbmY5LYj5HxxCnuBGMktXA/mr9XTVpULsUnKkZ/dxxhlmpmsVMnP4/8HIE+/vj
	tpDujP0WEqJzkBCzWUWE1JtNB9Jt/pMrr9OWP2cDsvPnW6GcHlhZEVPwcwXlLDez
	7wxyQZvYygXbpI1N62GV2A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pegm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 19:05:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498J0hDb022849;
	Tue, 8 Oct 2024 19:05:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw7kme8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 19:05:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNJzGC2oWF2zmnDbRn9iuw4UWfh8y5iLjJRtmgrCehvIWQ3gWcu3RfYXFC3hU6hiYsgcoJVeBuruA79oJvC2c+81ify80BJD9o3VdVt6ltYx50jAYURIIkmV0NbjnsQQXTwlp4F8Tswcsc52CKPBeh9z6El68fyKi9Y+SjCAsY2zwSKzrcrZfhHPesFqCLN7t81WMFERH57doaVprvedsJ4BS6qeHzyP1zg4dhouaGE0CIzDCmLi+319r0pDTXbCreb2YM/TEMX5xDecon6mIVOdsP4hAvGcwters/jC/Lympvdp7B1PWjU6Ev+Oz009Jz0+6S1uxpt1+OIoKhnv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1/qnkuq1GSEYbEV0O81VYYIZnAn8z4/in9GF2NWxII=;
 b=al67A4G9SfI25Ma8nxAaO2KyN/MIOxmrK69oGRb78sVwtTnEzlCFMgBQvjdiQodDejmAoP8Iei32D/l1HYSsNuaeivp8xFzKORGoOgR7wZ9ZYkFoYjQ/APCV/8nBPMJyToOKqg1BLSdiTKy3F7ZV0R0GlkqToTqWPONxuBBR8obniwuJ8/mm9gMld3vxMqpdalNQ0pChZ/DgL7i7YDrcag5HdtZdTeTly1BxC6F2U7qazzv+KJ8HTNrUfO8u5ZZBP88MLl1YeBO2a2AvUmfw5NAUSrsu/7FX2oK2m0AT5vzo4GvtIt2sXL3ZcBizOklbzypqgvVZq+5Fy+x36jgKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1/qnkuq1GSEYbEV0O81VYYIZnAn8z4/in9GF2NWxII=;
 b=LDotFZzL9HxlyOYHSU1Iw95NM6yiEW2qOO+M+8zTspRO/37cBUZJ5Jq1FQGJSG0WTVXB+KBosp62FP9N0KNoGtZdCZIThj1lcFR1Tdz3y9cSNUOVboj26coO/eXzYj1AaGAXbY7vWrFzZFaQYRHTmHmBy1m/YUTgbPx3XDKOcXs=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CO1PR10MB4593.namprd10.prod.outlook.com (2603:10b6:303:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 19:05:35 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 19:05:35 +0000
Message-ID: <40e949f1-754f-4b60-9464-fc0a9e266fe0@oracle.com>
Date: Tue, 8 Oct 2024 12:05:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFS: remove revoked delegation from server's
 delegation list
To: Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker@oracle.com" <anna.schumaker@oracle.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <1728406678-16857-1-git-send-email-dai.ngo@oracle.com>
 <a35e31e53c87c96cee9bf82ec4727ee793931789.camel@hammerspace.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <a35e31e53c87c96cee9bf82ec4727ee793931789.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0585.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::19) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CO1PR10MB4593:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f395ac1-51be-4667-deeb-08dce7cc3028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3d1NlNQK1ZxUmRjMVp5OUZRR0psMm5aNWVOcmZVNWh2aG81RXBDc3ZuakR5?=
 =?utf-8?B?aGwrblQyRjA3eHY5RXNwS3BxdFdFWXhSN0VGekdHbmJMaklmenhaY0ZFNlVI?=
 =?utf-8?B?K2s0OVB5UXVkNjd0WmxQREJ2YS9VTEJlbm1DRG9JVzdRUk41NVFTbWptekFr?=
 =?utf-8?B?YWMxZkZ0c2o3U1N6ajhJRGZrNVBPKzZ5NnJpeTlXRi8yTnlPcUxyQitQV1Fm?=
 =?utf-8?B?cjh1b2p0VVVrMmZKeVh1NVF6OVlNNTJUWVVWcE4wY2JWWCtqc2ZCVXpLUUNU?=
 =?utf-8?B?Qm5OKytpNWFHUVRPWlExcGhVbDY1Y1dONEJSa20vaHo1VWxKZk5YaTBKRUhJ?=
 =?utf-8?B?TVRJTjNReWdOVEM5M01GakdBRis3VkpFR0FyTk5mY0xudlVlcXV1VHVKRnVv?=
 =?utf-8?B?aFNHa1ZnaXpqZ0ZqaVhKbzhES25EQnM0eDdyQ0NJbDJ5WlozOEUxaytnWi9t?=
 =?utf-8?B?NmlxVnd4OWNNWlFmYjBFV0NCcW0va2NpaC9WTENoeTRvZUpSK3Q1bXZySGpE?=
 =?utf-8?B?Q2ViSzY3YzVRWi8yZHlkTDJnWTZKQ2hzR0Y4MFBmaUJGcnhjNGs1SzV3WXFH?=
 =?utf-8?B?WlZKVGlTeEhTVTBIQ2tjaFllajV0TjNaMzAvUVp5ZVl5K2MvV25NTVJ4Zkg1?=
 =?utf-8?B?MlFOTEJocXZkWEVxVjJhNXFESzNrdEkrM2crcGkzZzZtZm42N1FuVFFsS3NC?=
 =?utf-8?B?ZW5MRXY0MU1ISVNSOEVsZ3VmU1k1RzZBUWNQL2dHNHpZV01sVmNjZjRoS3VM?=
 =?utf-8?B?YnpaeFVNMTBHcjZjUDNCQkVNaVlha2tWZjlsU2N5UXJTUG5qdzZYMzh1T3Yy?=
 =?utf-8?B?clhKWFdXaldPTSt1bzk1NmsrcTN0bEczMXlhZUduRUJPcUtWYlBvdG1vdGJN?=
 =?utf-8?B?akZoM1B0eVZ5eElaVTZDY0FicGlTMlVVY0EwQUMvTE9pc3JuSS96K2E1SEVp?=
 =?utf-8?B?b0RRL1IxSUwwcC9LZ2sva28zUE0vKzl6Q3pHa01NeVVjZ3FKc3NQQU5PT3lj?=
 =?utf-8?B?bnBockdMV1R1RWVyc2pjOGRzZUlXNmZ2QUpnMjJoYm1ORHNZd2R1ci8vU1Q0?=
 =?utf-8?B?NTlUbW5mM3NLaFU5bmQyWjVZUEFkVVJBMUtIejg1azM1by9UamwwYW4zdXJO?=
 =?utf-8?B?VVF5dlcvT3RIMlRXanhWeDBNUnBHVjFhNU8rdEVDV0kwQmxLU0tGVjBWNk5E?=
 =?utf-8?B?VS8rZ1Q0cXpwWXVLdUhidFdWb3ZMdmZxUksxekV3bXg4dndrbGJVdmFpR0xw?=
 =?utf-8?B?cTRuNmJ5Zm9YNVJqZHZsMWt0VnNzZUtKMFVFeXVaVDhBVWNWZHFiWkZUQ21k?=
 =?utf-8?B?YW1wbkliYTlXdEplNG5YVlZJRVVEelNMelVHWjZtVHRPWGluWFI2ZVVXYUs2?=
 =?utf-8?B?NUVtTm1oVSt0UGU5T0cvZ1dvMFBaSDJQZjZzWk9GUlMrclU3cVJjM3U3aHFv?=
 =?utf-8?B?UnlWMHdtSGYydnF1TWUxdXBiVjd1bW5MRlFBbTBNSzNwV0p6WHhxUnZOSzQw?=
 =?utf-8?B?TVhTaWRaU2dvdFNLUWMySXNjYWU5T3JaLy90S3l2bVpNU3BuWTVBbkFjZ1FL?=
 =?utf-8?B?eFU4cUhmam9GRzVqMFUrQndVUld5V1pBVGZ1bE5Nbjc5KzJLcmk5Z2Z4R2xz?=
 =?utf-8?B?NXduSGVUNmdiOXowYTVvNlA2c2l2aHR4bDVTVDVvYlJOOGFhRWRucmRqa0l5?=
 =?utf-8?B?SklIVGJFRWJyWjdVNFpEUU9FRjVwc3MzZGlBQWhyZTZsVGlWRWxnOHV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVF0aDNnemF3S2JhQUFRVzlHd2VCN2dWc3hOOCt5M1liWHJQa1lnTHUwQTNi?=
 =?utf-8?B?K0VvTjN3WFVQQTJTSGlYcTU5d05lVUhMRVJraXF1MFBFSTFhVG5pajJvY2Ir?=
 =?utf-8?B?WSsxNjZNamF3bDBSMDdBQlVRRTlUb3FJcmdGQk5WM0JxSVZmd2Zibk1iQmZp?=
 =?utf-8?B?K2RFNUhqRTMxQXZaUWRrVm0vaWpPdi9ZY3kvV2RMSG9QcnA1WCtWNkhBT0Zx?=
 =?utf-8?B?aVRPUklvL09IMTNVMmRtQ3V1c2NWcENXVVBQQzBXRGFyYkNmTnJSTHRhTm1v?=
 =?utf-8?B?c0wxQzVkR3V1ODZjTTBia1A3UFNIQ242SW43TTJrckdVN3VidFlRUS8waFB3?=
 =?utf-8?B?M01SVXlWcFlNK2lkWjhaWHFpdjBWSzhBd3I1NzVGaVMwUGo0YTZNelJIYUJR?=
 =?utf-8?B?bFhXb0VqdStaWVJrMWptSGI4L0FETWNvY0ZuZ05VVklNUjFHTWloa2ZMYVdh?=
 =?utf-8?B?WXlVQWZCM0xFdTMweUVSQktBUkNOYmRpclpVZHIyeGN6ZU1qK2xDSTFEZUY3?=
 =?utf-8?B?c20reWxsdlh6RlJNOUR4SmtYSVhwZDMvdVQycFJoeTUzQWY3OWR2YUFINW1y?=
 =?utf-8?B?aEhhTEtIMnAxN2V2YjFJY1RCQWVIa2NlZkdWQStEWGl4QnhNSlhzWE13Sy9R?=
 =?utf-8?B?MUM1VnhuTjVGZFY5Z2ZXSi9lQXU2ZDJPTVhUVlNzYVlJU0NQUDBobWtYa0lX?=
 =?utf-8?B?N09WYllock9nVWJGV0tOaXBsN1lxOWF0dWFkUUFrcWpUb21jNWhtTVVHTDJr?=
 =?utf-8?B?T3lGb2xFR0grVTdmVUpkNUFYWjdudXZqUFBFRXkwRStuZlN4NGpwTHo4WFNE?=
 =?utf-8?B?bkgrSEtrL0ZZMU56VWZzdmxmSGg2MGE5WThoTDgyUHl6ZkRIVVI1b2VGcnZq?=
 =?utf-8?B?OXdkbmRqZW4zVjRweXR3bmttcTRmSllMQmQ0d2xseFJ6aHk1Zkh0V243Q0lK?=
 =?utf-8?B?UE9YejZ4WUxHeE5HQXMrcnRZQTNYOThKeTRKQ1lPZys1d0dZcGs0TkFkclNa?=
 =?utf-8?B?WTFVWWZYWHBDWjd5c20yNkN1MmRBUTlLQVRvSUVrOEhmK1lTSWQ3NkxnU2Zr?=
 =?utf-8?B?NVczQUQxQ0R5SnprbTBEUXNYdENmd0ZIOVdsNjJKdFNiK0o3U3BscWVIMXF2?=
 =?utf-8?B?UjVhMEtoMHBXVWdEd2toTkp6R1B2NkN2VHdNbk9vMFlCVXlzOHpmYi8ydFhY?=
 =?utf-8?B?N3Q3LzRTOHUrc2JTaUtKNCtzdGNLQlFnUU1JaVNpakk4ZTJRTkdRMFV4TG5G?=
 =?utf-8?B?RmhjZEhxT29qZ0ZMNHNNK1owR3ZiNDlod0hxWVNuZ3lkSWJjMVlCUXJLN0xD?=
 =?utf-8?B?b3Z3NDlldjgzT2NWd1ZqbU9DNnhjcXBYTmYyVHZDV21uMnFqYmNhV053V1hy?=
 =?utf-8?B?cTRYT1VqUnFqUm9vRVlGZW81U2NPb0lUR00xUGxkM2VVbXRSR0d0dG5PZU9M?=
 =?utf-8?B?eEcxalJVYWRVYmlmZmZMMnJRYTR3eHRCc2xGTnZXRHZza0h0TlFPQXN5UjJu?=
 =?utf-8?B?a0Q0MzFIQkNFVlFtdGRyYVZiUnFzU2MvTlBGdGhmc0hGYk4xOTBudDVGOTM0?=
 =?utf-8?B?aWtwL3BQWWtXVnlrZHF2azl0V1VnRTc4bDRocUk3akM3cEZheU1pM3BubTk0?=
 =?utf-8?B?TEtZQ0VNcWZ0a2h2czFMamlEUnh1TjBQOWNtSjFRN2p4Yzc2Uk5CNkU5L0Vl?=
 =?utf-8?B?NnprN2FoNzM2ZXY2QlBIbDdwaThXNnlaU2lsaWZzaDE5dnQ3eUpiekRONzJO?=
 =?utf-8?B?anF3TC82emZwU1ZtbkUzMXVQT2ZGVXUva0tXYnNOVGlNYjlDM0FMQlZIdU8v?=
 =?utf-8?B?OFl3S09kbjZjY01zVXFvSkJiUUY5SHZCNVZRVGpzeUJRU0dtR3JlMkN2amhz?=
 =?utf-8?B?YlROMGluN1NKaXlaRFVmc09FUDFueUptUWRwKytjdkpDYktXVWJsbjRmOXl5?=
 =?utf-8?B?MXNQc05KV0Fmc2xaRTBrNWpNVHAvUjN3MmMva1cvNSsvYUpobE5aWWxORHdF?=
 =?utf-8?B?Qm0rSFpUSmhDYVV3Qk81OUxGL0JFckZDUVhWK3hnYzhsZFByeDQ2QWJzWFh1?=
 =?utf-8?B?cVRuWFlpRWVzaTJpS0hsWjJRYmVMSlh1b0VRcHVmMXlRQzB4SU9CWVlCQUt0?=
 =?utf-8?B?REFQQTZWblljcWxybHlwdHJ5M3hROWxmVGwwMDVCbFN4Z2dseGV5VTRyN0Rj?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bVNezd7hZIZeO/1TvKyQKJ1Z0GqKbWodmtlULgi3cK1TlPSFj68RbodEgXSL4/0T2z+hnCkYqjYufPs2M5I618mIUdoAGfbkKASHX827KqyLSYugjAQEwkFOnZA7zY+0r/Wf1ey69ws9smETqnnhhyXky+jQtNYdBRJBfJ1p485WPOeTAaW7K8e33CExeGFvAN1RCMl2KMsBVc0axYzl7OTz5iIbBiWCk81d50a5x7r/FQmtHAy1fy3lgZDlLDWpCWn2m/ukEqNTqqB6ZrujymnPrpa/vb3FR+7N6YnAco8yrLslzXQF5p1aL36F6BpeDFJyVLlFDb8HcT+/zFW5yt37aS1o0+CnoEoy5dVHfiXyrlaQhBLySJQUAvX2ledP0fj+4AXQlsuFURlABBA9IP8crr+zfT27fqNTwebNSsCOPmRHjxIelDJLLW2o3NGkw8dElxk5IpiA5v8QgvoKHyX4YKw4V1oRgHXHLLaPmAxLzdWtZFFoA8IRXf9kyqJYnvVXmaKAGgV09V64mRjqgBXfBOKR7QhCBbVG/kWrSq0OTE9xlDKv5KNnwxMK3LBAjkPep5Ayv+3qhAIblAmU8g10afvB1cA9l0GK+vCmIvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f395ac1-51be-4667-deeb-08dce7cc3028
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 19:05:34.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAAu1fGZDdkCO5ym2jJ+YtglQFiJyoTv4uwBiK2/9ZdwR+KWSuixkWGlfhvko8AnO33TeD8ofnVIeSQtcyvhag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_17,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080123
X-Proofpoint-ORIG-GUID: fw4un12siLizKlqjm3dFAyE2cZ2Me-mR
X-Proofpoint-GUID: fw4un12siLizKlqjm3dFAyE2cZ2Me-mR


On 10/8/24 10:50 AM, Trond Myklebust wrote:
> On Tue, 2024-10-08 at 09:57 -0700, Dai Ngo wrote:
>> After the delegation is returned to the NFS server remove it
>> from the server's delegations list to reduce the time it takes
>> to scan this list.
>>
>> Piggyback the state manager's run to return marked delegations
>> for this job.
>>
>> Network trace captured while running the below script shows the
>> time taken to service the CB_RECALL increases gradually due to
>> the overhead of traversing the delegation list in
>> nfs_delegation_find_inode_server.
>>
>> The NFS server in this test is a Solaris server which issues
>> CB_RECALL when receiving the all-zero stateid in the SETATTR.
>>
>> #!/bin/sh
>>
>> mount=/mnt/data
>> for i in $(seq 1 20)
>> do
>>     echo $i
>>     mkdir $mount/testtarfile$i
>>     time  tar -C $mount/testtarfile$i -xf 5000_files.tar
>> done
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfs/delegation.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
>> index 20cb2008f9e4..65b10f7ea232 100644
>> --- a/fs/nfs/delegation.c
>> +++ b/fs/nfs/delegation.c
>> @@ -642,6 +642,17 @@ static int
>> nfs_server_return_marked_delegations(struct nfs_server *server,
>>   
>>   		if (test_bit(NFS_DELEGATION_INODE_FREEING,
>> &delegation->flags))
>>   			continue;
>> +		if (test_bit(NFS_DELEGATION_REVOKED, &delegation-
>>> flags)) {
>> +			inode =
>> nfs_delegation_grab_inode(delegation);
>> +			if (inode) {
>> +				rcu_read_unlock();
>> +				if
>> (nfs_detach_delegation(NFS_I(inode), delegation, server))
>> +					nfs_put_delegation(delegatio
>> n);
>> +				iput(inode);
>> +				cond_resched();
>> +				goto restart;
>> +			}
>> +		}
>>   		if (!nfs_delegation_need_return(delegation)) {
>>   			if (nfs4_is_valid_delegation(delegation, 0))
>>   				prev = delegation;
> This is not the right place to garbage collect revoked delegations.
>
> We can do something like the above in nfs_revoke_delegation() and in
> nfs_delegation_mark_returned() instead.

The code path of nfs_revoke_delegation is only called when the client
gets SEQ4_STATUS_RECALLABLE_STATE_REVOKED error on SEQUENCE op and
when the client tries to reclaim the open state. So this does not help
for this problem.

I'll move this to nfs_delegation_mark_returned().

Thanks,
-Dai

>

