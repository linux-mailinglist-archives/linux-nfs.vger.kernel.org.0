Return-Path: <linux-nfs+bounces-12100-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E63ACE3CA
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 19:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3541741A7
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006B1D5AC0;
	Wed,  4 Jun 2025 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bbt6bC/P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Psoqs/aF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E518DF8D
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749058858; cv=fail; b=Rlpizk10F2eY4+O3w6UYObse+WDuK8cIo3SpiD8xJfWwHvjbBgPXiGXwEmC4Ieh1L5iFW9W3VrkfQfNt1YgdImKj9CzKRE0qiKoAbNgvTidW5Iu7y23jIap/Z0ts/j9qloETtpADE1pZ9ORupEh3FaREmmEGdhLgI3rU/29Jego=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749058858; c=relaxed/simple;
	bh=OnZ2yrbruNgnuCYalsFAl+ps/+Hc3blZG/jVZpy2Fsk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kgTZ7VNKOMFKzz/ldZufI3yfv31ZXUVENMGPisH3ECjxUgeocfQy02enC9gM0YW6rpf5ssWGXboeAx285FNOnT3wxDWnP4GBG/pVjAGYQpLUPHndrRNpexDIoDmYXOr0s9JIDdeJSc44QxxkR0yyRCNJg9QN87gWg/0+Ag4ftRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bbt6bC/P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Psoqs/aF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554Fe1V2008878;
	Wed, 4 Jun 2025 17:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O7zxwdlfxrakOAgIHohfpQgGu1E0oraY+6b8WuAsFEk=; b=
	bbt6bC/PmqdU1+ATsy59alEg95H2/zb4xxZ3cJlc7JNGXu+/2k3aVaJ9Yp4ZxfxT
	+oAwWgK+RMWqFEQ5Zu/U1bnp1CAG2Lh6eJeHQsnwmNf0WyXGtXQFuTQFc3Bs3rp9
	oQ6QbD3QsI9aHaYY7RFmr8+i62VdDH40O347RIG6fzLniZvdBMf0W8ra0rUEiYE/
	RnELEk7rsMNnhmEUSGTEkd6eyNzHj4OtKUhOGrzBeR2NoFQI6eRky2Hp1O/KdRu9
	F2u+uNz/TzVsmudDyAzuTUfhHNPJDhwG6VJK8089n/dXIKlVekWVKYlK7T9WlgrE
	Bp84TFcnDmeyW0hQ6Un2Kg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8j4k1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 17:40:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 554GjNha000561;
	Wed, 4 Jun 2025 17:40:51 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7bahe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 17:40:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OR88TA0+qsMSf4fKpXSfSohasme3KKV6BsbnIpfUV4fXhVFxChj7dTX8ROgRU5MkSom5MaNNCXTtlpmMSG2kOjKI50jFyXRgNVZFLaWttbSKR1WUJTeBKYcTSJYS9X9y0x5r+Xky6Rw/OG0CBhaqUIkO2yPMbSyXApDIY6FIggK6lat2KXIHittR1ihXmCuuVKswyX1vPlJUCfDESzYex9FpUexB7iGse5RfUB8pWTMv63+55MQLWG/BubT4tzDeSJaroYldL0fyjtcPCqAo3CZl9um0TGkL2J4EhMuo+ujDNDPyWYFP2FEuC56e0mNwuoXXruZF3TsHqbvL52Rrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7zxwdlfxrakOAgIHohfpQgGu1E0oraY+6b8WuAsFEk=;
 b=HEEfR1pT/n12HTrLYEFzyVGsDtPOAzFQX4B6JZS6xcp0yfNMgEbEmVBBLcHkxWhLClCafzvSmEG7P51xJ24Zj56Movx5/bCSPLJ5sFVVcqn3Tc9zl/ieO0TxsyORyjgrt1CVuF6pp0yupccdv6pr/4/F3+wDMiJsnidsI40J00Zp7DMW3ibohIqlZcCdw1WTlMeKnqxA8LqrLrlwbnJLemAKJnSwq6bmmpbvlljdJ1EN7QAMS6vMaskw38ypQisSZpzyTYQk8yKISUp9Wf8UQ8wTXdWPWC9K1QV2KwK0DOdB+V1LQmk/hGTzcOUxkrX41j6ktVHSOU7DoNIJFGE9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7zxwdlfxrakOAgIHohfpQgGu1E0oraY+6b8WuAsFEk=;
 b=Psoqs/aFQcjHqXHkcBJJX1z4U+TWPnhFJtsl3vNtKMwNgASq8YpjPC2tkMaPEpmweDHHEeT83aiJ/fnfedKbYIDa6UHfKMGUl98pmktVMRVcNO+8Pj8RXPCeCIztUOy4rjtkGtH6tP5z/Kn4UOULU3OASMKVzSHMHtVtC4KmsGE=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by IA1PR10MB6028.namprd10.prod.outlook.com (2603:10b6:208:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Wed, 4 Jun
 2025 17:40:48 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%3]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 17:40:47 +0000
Message-ID: <21f116cb-acd1-413d-be3a-18b467a9e7f5@oracle.com>
Date: Wed, 4 Jun 2025 13:40:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFS stuck in nfs_lookup_revalidate
To: =?UTF-8?B?THVrw6HFoSBIZWp0bcOhbmVr?= <xhejtman@ics.muni.cz>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc: Zdenek Salvet <salvet@ics.muni.cz>
References: <18945D18-3EDB-4771-B019-0335CE671077@ics.muni.cz>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <18945D18-3EDB-4771-B019-0335CE671077@ics.muni.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ROAP284CA0193.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:10:2d::11) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|IA1PR10MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: f9636608-e39f-4ff3-1189-08dda38ef070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWZFM0NlV05Ya2JWdVdoQ0VLY01RNER4RkRaWC9qdVFOYzZtbEdrUGlLRWNu?=
 =?utf-8?B?dDl5MnFTd2FzdEMwa3RqaGFYR2JCYjA1bEJia2tyRnhSNSs4WEc3dVFaQUtn?=
 =?utf-8?B?QzZPZGo2MG5ZTXVCelFuT0VOdDlCS0NpbkUvVXhQMVdkQmxMNEwyb3lkbHJ6?=
 =?utf-8?B?WHlXR052RVRra0dBKzBONlM2N2ZuRTg1V01LMHlFMXJWNUsramVkd2pEcEt5?=
 =?utf-8?B?Z2dMZ2JzT0hOQ0dsUXErMk5hSWJybHJDejdnb0l6TzBid1kwcVcyY3ZHVTdp?=
 =?utf-8?B?ckxHMHdOOXNMOERuNXRRVWJwSUoyV25tdnJmVk5yMTF3NUhNUmUyWTE3bVc5?=
 =?utf-8?B?TFU1ZjZGMkpoWWpSZlBTUXJQZHlzVndKRmVsRmZVOUxKREVySGRvY3hkOHcw?=
 =?utf-8?B?dStLQjBPbjgwRkhVWTZlbVpvQkdBdDlvRXA5UytEdHNrR0NzbVlrT3JlN0FU?=
 =?utf-8?B?TFJNRGxqd21vMWJlQnJLd3ZVVEtacmpyWUdSbUczWlNSUmV6VjU0a2hESHVJ?=
 =?utf-8?B?TGFnNWNJblN2VVRYaUVsdWtUMHU1ZWNoeW9MVmFoVXhNWUJoZEMzWnIyYjVk?=
 =?utf-8?B?UGpJQUlraEc5cFFFWHNUTlExY1BxbEVuM3pWaEdmYktPSXRYRmU3RUQrVzAz?=
 =?utf-8?B?RXB0a3FaSHRXKzk4TjU5YUF5dEl0OXlEenhrU1pvZDJtWU1PTktzZW9MWnRo?=
 =?utf-8?B?cURkYVVTRk1OaTFXSnFTVVBSQ2t0Qzh5NjZFdnVMOSt1WU5vcDh6U0grUVlK?=
 =?utf-8?B?WFA1bm42SVRRUmxvQXhrQ3NGZHdzZTR5UWhjM1JaRSt1WVg2RU5abEgxRWVp?=
 =?utf-8?B?VGlyWVdobVI4QmF6OVhNWG1iZmFhQTVnK0JvdVNOMTFOdTJUVXUzejl3bVFH?=
 =?utf-8?B?dHpuSW5wUllzOWhDOHJWRS9wem16NlV6bGhzZ0pLbHhzWHZ2V0I4R29Xc0Nm?=
 =?utf-8?B?aE9lUGlMYmI4LytXb1pobmlMc0RldjNEQ3J0bW1KR3VhSDlsTS9GZ1ErVTNt?=
 =?utf-8?B?S05OejZXN282QXkxUTJtWTE3bnVFcjFuYlViMjEyYVVTSUU2ZHYweWxBWE9L?=
 =?utf-8?B?WkttNWZ3K2VaeTVJSFpTU3NHdmFVUUhMSDRGWmtGZXUwYUtMUzRBeXNBTHJF?=
 =?utf-8?B?aDQ3VFQ5eVlLZVkzNURYYW1XQkhWdCtkOGR3Tk8yOU1EZlR5dkxaKzYreTFn?=
 =?utf-8?B?dnVha21nNWVJb3RGKzlPUDZvYjFSYW1FN2x4aFNkVUVHREZIYVhEWDAyS09P?=
 =?utf-8?B?L1crcHIxTWVzbHkvWFZqUzd1WGVyc2VBMWV3UUwyQ2VtdFlKQ0Z0TjYvSllN?=
 =?utf-8?B?bE9jZGs3MWVsemlLSFd1aS9qQUhHazJKQUs0cFhzWnk2a3VQeUhzdXFwaXVq?=
 =?utf-8?B?cTh3WU5nSkFCZEtSdW1tSjZOMG1BWDJreXdxTjMxUllRZDlPdnVIYXhGdVVy?=
 =?utf-8?B?bmhLc3NwU1NUZkx0bnRyQXVYSSs5UWkzcWN6SVRlZGtNOWlldlFnZEVyaHQx?=
 =?utf-8?B?aFkvZDJZVzV6TXdOMVUvV2VXWVJpMFhSS1NISXUwU245bC9JTkVMTDI0cHln?=
 =?utf-8?B?QVViTldQQklHYTJaWkR5eXp2cmdLZWNxWVZaZVRMb3o3RVpuZFBQR0FzLzhj?=
 =?utf-8?B?bkpWQ1FEcnNYcTJHYTRVTUlsQlBveFJDZXZFRXJpNmlCeGM3RUZha3JYYVZG?=
 =?utf-8?B?MVlvYUluOHdKdlFoK2tNWGNXNFVHbWhJZFlvcUk4NnZENnAzOFdCeVEzR2VJ?=
 =?utf-8?B?bDM1eDJDeHM2OHVTT0FJTEVOcXRzY2U1Z0ZteGdFMCtHMGlyL25uY3pJWWo0?=
 =?utf-8?B?NVBDb0xxbnllQjRzd1l1STZIWlA2YVBWdzdVWHpSZXhRUEhuWE1BdDRHcC9U?=
 =?utf-8?B?bVVaRUc3SC8vV0Q2OVI2dkYvR09lcDRWRkE2YXQ0ZDVrVFg1d2tKWnFCdFRp?=
 =?utf-8?Q?ER7IruI75U0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WU9RcHowMzZjbzRIK3VsMHBaQ2hkSkNFc2dPWGpoanljVmRtUXdTbWh2eXlJ?=
 =?utf-8?B?ZnJMcGRMdWV1U0xuVXBmYmRlTm9ET3A0WFNJcUlTUndqVDc0TFIvTTAwZ2pa?=
 =?utf-8?B?VU1aNHEyTGpEYWFyUEZRcmRaa2V1U2RqZDN1UVUzMHdMTHVIYS9EaVNXQnZl?=
 =?utf-8?B?NEtDc3RNNjhLNWZOQ2JoRFJiMTY2K2VuNzJCZXdJVkFjMi9HUTIyTVBPZTZu?=
 =?utf-8?B?M0VEUlBaekwxb2lGdmF6clJnTTJRODdlT1pWS29lRzA2eVRsMC9BZ1E4ZllX?=
 =?utf-8?B?b3JFa2ZTdjhKdkZqYXZyOEliOHhRdC9yY1FtUmtJVFcraWRnM1hZM3R0VHhK?=
 =?utf-8?B?UVo2WnFUa2R4dGhIU0RWY2RLa2x6bXRzdUlMWjJKOFIyd1RlbllWYThzTURm?=
 =?utf-8?B?aGtFZVZjZXJHdmNYWVcwVUlTb1RJUVloU3NsbEJMcWRGdHFQN1VtaFVYV3Zm?=
 =?utf-8?B?WjVabHJ2M2VGcEYrZEtFOVhRamdjMXlrRVQyOUNhYnJFd2lWSDluQlcyWEll?=
 =?utf-8?B?K0tDRG5IV0ZITllWSTlTU2F6UGlMSHFQSVFFa0JBZkZ5My9XS09xTkJER05F?=
 =?utf-8?B?dFZmVmFmYlRDZ3lWb1lSbHV5dkMzalZnWDY0NTFPTmZlaVdxM0JmNjgrQmZO?=
 =?utf-8?B?Y1dGd05ReDM2MkQzRlAzQ1BDdTU0UkF2eEJZKzBrSEJUcnIyaFl4Yjl2NUlv?=
 =?utf-8?B?SzBlbTJXbjE3TXdUOTZPOTFTL2hKNlkxTlMyN1NsUjhPenBCWVY3Qm12TEc2?=
 =?utf-8?B?Unh2ZCtrOS9hbXIxOEc1aUFmb0cxT24rbWx5elZmUHNZSWpmVkY4R0kvbnB3?=
 =?utf-8?B?MEE0TkNiV29mM1grTVlOQzVkWlF4OUZpdkFSYTdBMWtSNFp1R1NQL1RFaFpa?=
 =?utf-8?B?K0FqUTYxRUdVemlRNnE4U1FTbDZtczVpZUliUzZnRDZaajBydndHbHFLVC8r?=
 =?utf-8?B?RzNjc011SEJmOUFQTlRZMkZNTzBmVUlYTDBsaE9pSlVPYnJaYmRkNDVjMEs2?=
 =?utf-8?B?cFQ0SkVUU0hyTENGeHUvSk5wclZwenRRdC9RajkyQ3JqWDA3eUh6WndaaUpR?=
 =?utf-8?B?OUZ3TEZXTmpVMDdFZzRzNUtuSGk4STlOWGM1NEZmcUQ1d1MzUmlPODVCeTVR?=
 =?utf-8?B?eDVINUw4MjlidGt0Smt0UDFoT2toSnBNTDBieUxKZTc2YWh3WThmNkYrLzZV?=
 =?utf-8?B?L1VpWExGKzNvdUZGMGd1RDRvMFZrQ1AvRUVDaEkycHBJVzZ0UlJOSUxMRzc3?=
 =?utf-8?B?QXp6eGp5d3dybGxNODcvWHhxMGphUnJaazlkZThwd2ZuazVSQUw3cFpFOUs1?=
 =?utf-8?B?ZEdJejF6bVRrREpBaUJlYTZ3bEphNVE3eE95UzR5Q1VCQ1pkdlpUZWgvVWpn?=
 =?utf-8?B?MkZZaUZBbWRqa0dLQ2NJWlRuN1UwdXhaSWdNRWFwckNpcjFoOThDUUh5UDBm?=
 =?utf-8?B?Q3FEckNkL0RjV2grRTlnVTRmWUNVOGNZdXBkWjZtYlRHZEpqZHJNaGpoazVL?=
 =?utf-8?B?VkJSL2tocUFIUWJldW5TVVgxaE82WEg0MzdsYzFWVmc2LzNJYzNOQU1wL3pT?=
 =?utf-8?B?c1oxS2RWWitVdlVmWkM0anp4dkNRVWh2Tm9tZUdldTFPZStENC9TU1VVMzRi?=
 =?utf-8?B?ejZPeUhYKzhJbk10YlE5UHRSOW1wV1RJNjdacXQ1endjNTdUb1ovVVhscDV5?=
 =?utf-8?B?dEo5bjgxMFhyVTBrT001OEpDZDZUUnl5NE1jS2phdDJyNmhPbndXVUhpLzZI?=
 =?utf-8?B?R2dxalBSLzRmWXY3SDExMlZiU0g0V0M5bTRmSklxSkdTOE5nZ0xSbmdvY01z?=
 =?utf-8?B?OE9PeXIzSlU2bWJ4RkRKS2lwT1lHSHEzdU1JcFh0VFcvdlJoYzU5bEtxM0t6?=
 =?utf-8?B?dUwxMDBET0owOTdlRHhlSUs4M0lrbEJteXpTa2paYkxDNUpyMnFJV0pvUzJC?=
 =?utf-8?B?MkxVL1BNSnNpaEwxRzFnY2ZMYlA0THJMMkR1eS9WNGxyVHVacDBRc2ZJOUxt?=
 =?utf-8?B?bE9HWEFhbFNFSTR5MU1IV0dDUjZ3NkFWb0tLcE5nTzVlNndGaVBRa3JDWFhy?=
 =?utf-8?B?OVVGWXExYjkrQmNjeVFjeU9PLzJuSTRTeG00Z09PVURKSTBGbmhRZ3JyeHdo?=
 =?utf-8?B?VE5CdzA0ZXRZU2ppZjM3b2Y2VDc0R0JLUGVubTBEaU5YdU9DM2xXcnU2Y3JZ?=
 =?utf-8?B?SUxBNlNpTXpPTlRtay9RVzVLK3c4b2JSUW9GM1h2MmU4djRXcFcvUUZnUlZi?=
 =?utf-8?B?S3JDVDUya0FaRzRKY01SbTlLbnpBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	emCxqcdGic+8h72Ox3PP+5FeZR9yL/G5B+4SI5sO41OUGuGQsYNlibvX6xy5HQHaDkvSzA3nNxd9b10GYjcC2Z4bONFxGapBt2kRkPC5V2qYxGhKNNKbFU3nttiwfogM1KY/6uxf2Bb70XmTH7rG6yccNUKU0YUJ/GopxeHM1qtkb0UyOc8ODfxSiPbeyM4w55o9f46OE2JjUiFTToYnVC4AiJm+FHbAg6GDPPBdH9CFY3jYRP+mMiZCGfqpUCKWcSQugPko+FxNrggVLt1jBf4+8RPeUUMMzXhm4l7xdtOCgm6grUV7tnLWNyyIV9m5vtEZvsy/uveyFcBlBU+r6NhF0GOLMZo1fGgLFKK7g9QDwvtTZj106O41K8mBGemIrsxsTmZ9NR49eTewPmKyWSzMrStngyW13orFA1Rb/RfYy5b5aYU981f3FUW2y7kOjXR+wDsOWJp+vEMIGM7y1+LJr5MRIxFuHr5IvoJPQ7DeMgwXodzaZIsU8PApd6LltcsU3bJOjiniXJHx+j2X91Qd4wQ3cWcrBrTU6nu4Ta5hUdqp36FZ09rCeep8PODOx/gM69fmvVjMratumPHKipIr0C9NdXfKpDhmnMrpTvM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9636608-e39f-4ff3-1189-08dda38ef070
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 17:40:47.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQKjhbrnXbo0iCPX2tAhxKDJ5rNHHMVukqylgvmE1wiO/SLtMFuxqvMe1V0PsEyOAbVixRYWjqa4kHiVdXpVKTp/6qV4yWCRHmJN8EumgZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506040137
X-Proofpoint-GUID: qtWBVkR-uS1TQpsj677ZPX8fA0bNG8h-
X-Proofpoint-ORIG-GUID: qtWBVkR-uS1TQpsj677ZPX8fA0bNG8h-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEzNyBTYWx0ZWRfX3H5bnV8AvNBs dY2DL6Jw2izJnTADMzbG/e6l6h0yjdPlxLgKADTtzRzjkkU18F2A8/u8IqfWcpxDGOEwr+1PJPB fD2ZaodKhOmghxtFtM0aCq/HB7zezoqqtKEu3HpsZ+84JrJuzyoR+M/6g7SgU+QlfTi6LoNgG2w
 gNmbpxmb7Uu66SZI/TeRhFSVULIsr44Zx1IUXczPMh7LYYBXzRMAQM+HOuDzIkK/4XqMYGe+D7E HX5rRFzceJNRJnk7qwxsYRDyYH3LvRKnABFmHgbiMiZNdnrHuPs31SmuSmnCcqY/rieaqVHLp6u oPv12THudy/ltlQYcKNdLvLuEDX5ynnzuUk7/xCLvdw5S2zJ7kFFLJdLzfnFT/CxLXFq1RY235k
 EkEi08eEFtAebIr40z9HjRVAFezH3rvdYuQvlEP34CSUPKMpZAuu4ZOw/yUvCLYWZZjvRCZo
X-Authority-Analysis: v=2.4 cv=QI1oRhLL c=1 sm=1 tr=0 ts=68408524 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=WnEWVa1JCIL2TFqyPVAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206

Hi Lukáš

On 6/3/25 7:57 AM, Lukáš Hejtmánek wrote:
> 
> Hello,
> 
> We are experiencing repeated PostgreSQL process freezes when using NFSv3-mounted storage on clients running Ubuntu kernels in the 6.x series (specifically tested on 6.2, 6.8, and 6.11).
> 
> Setup:
>     - Storage: All-flash disk array exported via NFS (v3)
>     - Client OS: Ubuntu with kernel versions 6.2, 6.8, 6.11
>     - Application: PostgreSQL using the NFS volume as its data directory
> 
> Symptoms:
> On affected systems, PostgreSQL processes (particularly autovacuum workers) intermittently hang. 
> The stack trace shows a consistent pattern involving __nfs_lookup_revalidate:
> [<0>] __nfs_lookup_revalidate+0x113/0x160 [nfs]
> [<0>] nfs_lookup_revalidate+0x15/0x30 [nfs]
> [<0>] lookup_fast+0x87/0x100
> [<0>] open_last_lookups+0x5f/0x400
> [<0>] path_openat+0x99/0x2d0
> [<0>] do_filp_open+0xaf/0x170
> [<0>] do_sys_openat2+0xb3/0xe0
> [<0>] __x64_sys_openat+0x55/0xa0
> [<0>] x64_sys_call+0x1eb1/0x25a0
> [<0>] do_syscall_64+0x7f/0x180
> [<0>] entry_SYSCALL_64_after_hwframe+0x78/0x80
> 
> Process Tree Example:
> 863813 ?        Zsl   12:24  \_ [manager] <defunct>
> 3644504 ?        Ds     0:00      \_ postgres: mlflow: autovacuum worker template1
> 
> The autovacuum worker is most commonly affected.
> 
> Workaround Attempt:
> We observed some improvement by modifying the NFS client source fs/nfs/dir.c (around line 1833):
> 
> Change:
> dentry->d_fsdata = NFS_FSDATA_BLOCKED;
> 
> To:
> smp_store_release(&dentry->d_fsdata, NFS_FSDATA_BLOCKED);
> 
> While this mitigates the issue somewhat, it does not fully resolve the hangs.
> 
> Is this a known issue with NFS in 6.x kernels?
> Is there a recommended patch or workaround?
> Are there any known regressions related to __nfs_lookup_revalidate or dentry locking?

I'm not aware of this being a known issue or any regressions in __nfs_lookup_revalidate(),
so I can't recommend a patch or workaround to try. Have you tried an upstream kernel
to verify if it's still an issue there? There were a handful of patches that went into
v6.14 that touch the lookup path, and I'm curious if they make a difference either way.

Anna

> 
> Problem can be related to the all-flash array, that is able to provide about 30k IOPS over NFS and 5633 TPS in pgbench (pgbench -T 300 -c100 -j20 -r).
> 
> Other NFS connections to the same NFS servers are not affected and are usable, however, the process cannot be kille obviously and the client node reboot is required.
> 
> I believe that in 5.x kernel series it was more stable.
> 
> --
> Lukáš Hejtmánek
> 
> Linux Administrator only because
>   Full Time Multitasking Ninja 
>   is not an official job title
> 


