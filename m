Return-Path: <linux-nfs+bounces-12315-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35745AD5948
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 16:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACAD167FA4
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35CF27C154;
	Wed, 11 Jun 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bOBh9APA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XTVqvQy3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E392BB04;
	Wed, 11 Jun 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653528; cv=fail; b=WQFNGkQI3mKoCGfyPWkThKIz5/O8wPRD5y/h96chmTA/P0jhuiLLjd6Ub9G5d9AA5zixveICAVFXeOnX1VPfjGxDiLz6DYLito+1v1vXZApwQiXmiizy4KD/OQF/SRG+PJoxKMT82RKWbYaeJemmy7HXqayyhLxX5Jp5fMr59zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653528; c=relaxed/simple;
	bh=YfaQLXOHcsYeN0oELlqmQ+OZPXlyfIlIWXiwxY76XZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lCWip9Sbh1r2TQAQxFJbuAsdAYLxVbvyzeNNMK1/5ZKnl3gJye0BRlmKqAP/oww1qAM6X/2W9tZZ+my7Akl4pmk3butyqvsO49nycUyDcgGv6NupnC9teZ2TY8yJwS5uPbZ4OL3bZZFTjJlvUrF0Lbi+QLmiVNGvnwNSst91/cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bOBh9APA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XTVqvQy3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BEfaKm006974;
	Wed, 11 Jun 2025 14:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hwtuD1crhnzJX3a0pa9QL3uYMow47ef38JAHbgG+pzo=; b=
	bOBh9APAopacSduMuG4coNUM6Ph6nz6FiP8csY3TfSXB/rFJPZ4lu+dz6/ArJeeo
	HX0yrKiAzmghYMQIUxZIKZV3KurwZyD0hOyFynMkaesIyIoZI8BT2pmyVYiJioN0
	nubm6U8FwSdtZ6fOvmwfkrYOQfexujuTmt+tL/q2B4XMsagC+4Pq42tf/cnb0Sv1
	WkQGI7Y/AigpGF0jS//sVYyxY6Ldm3dBfW0U+c8sWc+HM7Tj8KZHY1duoZWnrLKj
	DCnfiVJZvTTYtwqNkJekioqy93/b9V39+dCWu33FEPX0Ftu0kPza11emOIIPyMM2
	svzlJirssJYNJmUhd+0Odg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dad7htj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 14:51:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BEW1n0021304;
	Wed, 11 Jun 2025 14:51:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvb0vh4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 14:51:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bmk01i7sD+22g/s5XysQHamcZMdJmEc80/Y3MxHIMts+17nouyauN7GISfXpnU/4bdXvYBTPM8JblIYxb6i0wJ1RFtzDuSnX6SAr2rOodjxSUnyJKtV0nEXP09GdlvGZtChA9VDlgLtErkogjcZnBIBvgB3uSLsuDfD+EFdWH6KBbLR5u5AksZGWJ8kUosf1Wg2lCYHqi79HN8rN/GdbbfHxQRPhQrCvpmJ3LbWBPRSK8a1Nli+ielfU8wPw3v2/gu6OsHN973veX1eEhXjaDaTxIOGgaqnXcUVgTuvSjFVkIwhMdcAw1cByOPWFUmoxBJevd1FXX0XorhTsHQ6wSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwtuD1crhnzJX3a0pa9QL3uYMow47ef38JAHbgG+pzo=;
 b=OcRPioR0lgNSmkt2S7gXmcm4Qj8gmi9W6QceZejepbzhHNgKfjs8SxK8pxkLPk1bmpWouuXCCXaWVQ40umYk4nkUV6tgzzA0P5iWmgNBn6UUj3P4frvqaNkiZzJePsE50cI10c8htiBlR70NLAGlvkUMmfQF0kjOsUxbXU/CLMisvUTy1ytDytnVmaB9Fkm1xCIeJ3Rhn04c5rQiSfv3daxr3STN1TISE5qRItX+iFAyBTgWVlhLrEnZTaFd5Ek8mFK0PtWDwj+uuo0+IUrgBlcsFRvywyxAllXcBi8d3pehO0m4uttxZnu/Z7rhx2X37W4qMbUWBiTkepTyRh19Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwtuD1crhnzJX3a0pa9QL3uYMow47ef38JAHbgG+pzo=;
 b=XTVqvQy3G+bRsKHIlm/vBKwSNPxyjQifaFfu3/q1gclBL2rDtqQCkl41+4U7qIqY8I9pqcl47O3VMjtylyVxjq717lrlwgeu5cOQx7Vy3JK6ew1ujDc+JCqVqw0c9v5FPA8hPlNdprEzHsxWbDOZChBQ0H1MhtXaKdHnVGbtfyU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6586.namprd10.prod.outlook.com (2603:10b6:930:59::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Wed, 11 Jun
 2025 14:51:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 14:51:53 +0000
Message-ID: <3f3647f8-5359-4729-bf06-cce8efc6cff9@oracle.com>
Date: Wed, 11 Jun 2025 10:51:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: Implement large extent array support in pNFS
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250610011818.3232-1-sergeybashirov@gmail.com>
 <1da1e7db-c091-44b0-b466-cb8aaa6431ff@oracle.com>
 <aEkouh-uedz1_c4m@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEkouh-uedz1_c4m@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:610:b3::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5e4228-970f-490d-49d3-08dda8f78125
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RnovZThlQjM3SFNuOW9HQXhPeUs2dlBTTVZYL1VVUUVMM0NTNG10S1Z4d1I5?=
 =?utf-8?B?azY4VmRaYk5PQnA1dEExdjJTaFlka1lOdGhucVBMbjRTYUN0dDBRL2RUZnFQ?=
 =?utf-8?B?Sjc5VlkzYjc3VTFpR2YwekNJVk9pNmtzblIyOGgvWHlmSFFaRUYweHVIUlVq?=
 =?utf-8?B?aUhsRUlDL2tCS1AzRDEraFNtWlpHU2lyUzQ5OE5tU2VBdnN6REdObzRVYU1m?=
 =?utf-8?B?V3YvZmdJa3FIbStSVjAwaHdCMVdTS0FGOU1obStsL000YVRSaU1UYUZoalB2?=
 =?utf-8?B?S3kyTUVRQkhodmRNWW5JNCtnUHFkTmNDSVpYcjBwTFB4Wm8xc0lRNFdzVGs5?=
 =?utf-8?B?c0ZTcTllcUM1RFZYSEJPVllOdTdxSFlHQ0FRRFhtdFFuUzVIblUzdzRiRGE4?=
 =?utf-8?B?bThOSDhsclRQbWZneFN2dkpWSEROUURoUnEvcHNXR3FuQWZZaEVZZXdxTUYw?=
 =?utf-8?B?cU41TGFuaTQ1UTIrZ3NiK2VvN0tSczFHNVpqZUtTYjBrZTg1V1R5dStGdk1m?=
 =?utf-8?B?QWZpNU5iUWxtb2ZZb3ZjZENlTmsrOEw0Q1RObGpVWlJNaEpVbnlPZUlzWTBw?=
 =?utf-8?B?Mk40cDJ0WERLeWdmQW9jZ1c0U0l2Ujl5ai83QmhGRVZTZWMzNENNNFN3MUk0?=
 =?utf-8?B?eit4em0yc3o5a2Mxd0VybWtmVjYvSVlVell0WnJBK0k2YU1sdklHUFdGYkVx?=
 =?utf-8?B?dnlrNHhRY3cyRkpwcWlCYUFkTkRmbnhTZDE3UkxUeUo1NS8yS3ZrNXNlZ3M0?=
 =?utf-8?B?QTVuVDNvYTk4L1RnY1NOZlBjNzlrWXl2YXJlbEo0MERBVUIxVEdnVmhRUmg4?=
 =?utf-8?B?NEYyeHV3RktneFprVHAxOHZ4OHQ1bGoydllPdTJCSWN3R251dWU1QTdxTFBG?=
 =?utf-8?B?TkN2UDZVZ0JFUUp2enpLWnlQMXBJUEZOZjlwbXRnSDhHVTlCZW0waFdWSVBq?=
 =?utf-8?B?U2Y1VzA4U09zaFBBT0k5V0ZjUXVYZDZuZXlyS3laU0VQekxvNjdGbi9JVERp?=
 =?utf-8?B?SUNlczZOUVE1dm5ZWTRTdTdrM1dqNVZVQk5QZUpjQjlPZ2RVMDV2UWk3Z1Jx?=
 =?utf-8?B?bVF5SThXbEU1c2RmMzBjMzA1ZXoyYk1TcDllMlQ3YmJUdi9kY2ZubEdWWFo3?=
 =?utf-8?B?Ti9PYVF6Zy84Y0NZRmxUejNpa2VWcmx5KzZ4M1g4Rk9BV3gvaFhRZ1ZlTlA5?=
 =?utf-8?B?c1NpdExPdW9pUExYTndORUNDbDJJOWhrZWpkMXNsUFU4OEVPd25lSml1R3l4?=
 =?utf-8?B?N2l3KzF5YzlVa0FBbVowNUVTeU1YVE1Lc0RweHM4M0pHZE02eWdWMkZOdS9h?=
 =?utf-8?B?TklzdGtWSFRiY0tEMTgyVXhBVitOYWNmdnM2Z0trcmhZdGdoRDhPT1hJTVhL?=
 =?utf-8?B?MmRLOVpBc3poV29RdlhrYURSMGtMK2dRRk13a1JiWWRweTEzY1dpRWpKdHM4?=
 =?utf-8?B?eDBwOXo3Wkh4NlJCRXIwcFZRWkh1Y3VIbW1JTU91QVJyankyRnA1Q2p1cWlC?=
 =?utf-8?B?M2g5bUVlRExIU1lZNExUdG5Pdks2eEY4eTBXWHh2VmhDMVJvUmZSVlBpQTBH?=
 =?utf-8?B?M3hNZ2t5N09aZFNaQ001QVVUWXhBTmFIWEp2MVdZVVVZbllta2V5a2NTQ1hR?=
 =?utf-8?B?NjdtMGVmTGFzUTZ3M2Q1WHFSdjlUZUZuYW9iN2UybyswQ3BBOVdIYm5SSy84?=
 =?utf-8?B?ZFJuTDVQL0p5Q0JZL1J6Q2ZlL1FrUm5wbE43ZndqNG1XRGhJMWpPUHltdHdx?=
 =?utf-8?B?KzdaRVZPOWxSd1M3OWkwbnJvdmZxVWFiY2tNdVVNNHVsRVZSYmlOSDY5Nk95?=
 =?utf-8?B?OHhpdTN6VkRtTlhmSGdXaTZiTENWWUxCNUdzV2U4akdMRUFJblZIUThmUUhY?=
 =?utf-8?B?SU9MRDVrZ01XOHpJODlNNXZkempybEpnbGdZN003SkU1bFJlM1Y0c05iYmt5?=
 =?utf-8?Q?pbzyysxUtoY=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ajluVzdKQjhXVWFFRldaMTU3MFRLZnhYNVNQTjNEcUtKcWNLVGpxNldoTFFx?=
 =?utf-8?B?YnplVkxFa3Jlb2VUVlBVUEJwT1NoQXRhdU1NNURZeHl1UzRXZmZEUjJrTnF0?=
 =?utf-8?B?UXNlTXN4YW8vcTkrb2d6eW5ua0VpaEY4aGFjUUZCYXl0NlhUdnovTGxWeVdH?=
 =?utf-8?B?QlNwUGxCOTc4Q0pNbTB4b2U1ZXliNlkrQ1Vob094RmYxRGlydGh1S1NqTEFV?=
 =?utf-8?B?aUZpb0NjOS9ZQlRkYlAwK25aZmtTTUZGeWl4WDZ4Rk9DdGorZVNob2t2TFk0?=
 =?utf-8?B?KzZsMmtEcWh4b2dsNVl5MUdnaGx6RGRBVjF5M2d2eWxVN01MWTNEVXJ3N0Qv?=
 =?utf-8?B?cVJzbGc3S1JJZVZuZWJscmYwSEpYSGdWNVZiRnBBM3JPb3Fpd1plUU1sUWk4?=
 =?utf-8?B?bjNjVkFWK21QQW1qaE5FYkRUMXJJb1FrcXgrdWxjY1MrOHBucnlOQ0NEQ2ZS?=
 =?utf-8?B?SmdWOGJoQ3ZvRG05NGlKbnNoQWtmYzM5cXRZNmhNY2UxOHQybTZSdUVZNWln?=
 =?utf-8?B?ZlF1dm1hajNUbG5QNTROK2NjY3NvZ2ZuK01iR044Uld4U294UWwrSmhqV1Vt?=
 =?utf-8?B?SEFVRXJ6Ynpncnp0NEdZME9JQW1KMHk4ajFDM0J6cFp5b1ZMdWcxVUxQVHhY?=
 =?utf-8?B?d0V1UGQvNXZMTGhFN2hlRVZSV0pkcTJZS2FtODJmWG9WNEFtWSt0dFkxcnds?=
 =?utf-8?B?VE00NUgyV0FzdUoxc0JjWHJJZmlwaWhNMUduNDB1cUh2aUVkWVBsMk81cStM?=
 =?utf-8?B?cVFhZ3JadE9vK1N6bnk2ZDVUZUxiYW9paHNPQVk3ZWJVYjkwazdKZ2FpS0Vn?=
 =?utf-8?B?blhSeG1vSkxSTXp1QXFLOEt5dW54Qm5URnp4R2JUYUU1NEFsWkhOSEZISEQv?=
 =?utf-8?B?MmdHR3ViLzhuNkdIVlZyNUdMYi9mc2FyS2FyVllSajRURXpTVVpRUmtHYkh4?=
 =?utf-8?B?djlUN0JxUVh3YnphcHhvMndxWmlnUEIycHhGVHlydzlvR3FVMDJpb0hyR21x?=
 =?utf-8?B?SUNpZS9WV3k1eVFCS1lMSk9qSUJvRUErRzF1VWU2Nm9PQVV6aGZEYStLNHFK?=
 =?utf-8?B?akJOQnptUHB1M1d3RGNsMXlKWGQyQk5TczVSNmdPakpSS2Z0OVhHZ1RCTmJC?=
 =?utf-8?B?YUlLSm11WXNSMVUva0xlNkFkSEpFRHkwQ2ZGL1U0NHErTTQvQmNCSTU5S0M1?=
 =?utf-8?B?S0tvc2dCd2QxU3EvZjR3WGtISml1eUJRWWRpdW9TZmhJdVNORnBrOXR0eWs4?=
 =?utf-8?B?SWl4MktUMS9wbWJ5SHFPK1NyNjJBMWJTZ0pmYUpncjllU0NmLzV2c2lubXdK?=
 =?utf-8?B?QlZ1UUcyQ1JWc2hhU1k0azQ2U2pSRVh5MzFuaExvSXV2MThNdThhTFIxcG05?=
 =?utf-8?B?enRxR0FkSFJqYlVuMVVWUjU1QXVNc0RaTjJ0UGR4MVZoNmw0OG8vRW5xUy9Z?=
 =?utf-8?B?STFsTmY5WXBYaExzdGhsS2wzU2FKSVF2NlRHL2VlbmR1L1UzTC9odTU3Tk1M?=
 =?utf-8?B?U2VJTVY2cW9KQzVyWjhLeXhNTVNkSGFzeDZxcVVBYWdnc2h6bHhDSUxFbjYv?=
 =?utf-8?B?QnJzcW51c2pKWFlnNHpqN0JJUjg1WHNDK0NKdDFXYXlJWjRiTVVXaU13T0Yx?=
 =?utf-8?B?ZnhpL2lEMnRxQVRpeXRMWWJJdS9zbDltNlYzdnRUMmxyRGVCT3NjalptSmdi?=
 =?utf-8?B?dFV1MmdSczh0bzlzaTlXcVdlWDFacFMxSGxwRmFJcFI1NDM0TitxelhCcnJI?=
 =?utf-8?B?aXpKdnMvVG55bG5sWk5Ka0VZUTN3Zzc5ejBVZkhaSU8yQWZjMVZ6RCs4L3d5?=
 =?utf-8?B?cUZVaURBOThEbXE5NXBnaXlFVnRQb2VoMUQvMDk4L0Q0WTRiV3I5WFFuSlRz?=
 =?utf-8?B?TDRBbHByNXdld3FwaFJvMkFVWU9Hc0lUT3dQUkZMcjNzMXQwaHcrZWxVa2py?=
 =?utf-8?B?YWtOdXo5S1ZKWW5zU2RoN1FVOEVjUHZHcEl1YU45WEpUMGpQbUQvSXgxQXZ5?=
 =?utf-8?B?bU0wQlBlY2h4bzZ0OXd2NWxCQjJkTEMwSitleFFXcTQyUW1iMVcwWHUwRkdw?=
 =?utf-8?B?b1MybEI2U241bHg1NG84RTdSQWpDQW5KL1FTeDlQbWVHdUNCN0VWOEVVbE9B?=
 =?utf-8?Q?Yi666yaL1KZxmA0uMdIgAsN+R?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nexGlPDki2d1XzMwtS05KH/fvfwuIh03x20KS8OWX8Rww4vRtD1iF++A6VoyWmqWKjJKyztfFP25CmxOizlXv54efuaP+gAPpLLVAK2RER1knG9n+zwmwfI//M8QW1J/8d/fEwhDAGGNtIzfRvIIii0ElZio++MvniZGIPRkf41dRu69kwzMslqvwozkliZK3MGlELiDTmh8NykEukOGVLxvgT+wBOxFombgqENO0J7q8LyrNdI2VuITdKeRjyFo1OTnRUo3Skpajx2eeMMy1kp5dhqgk1WYTErlG8jjtBpMFXcpVqz9QNQ/oafBBGGTVRsbq3OX66KtBbw3pc7FpM5wchQgjRdQSP8A7E7fqGUv7hdr95MCThRZgnfn04Cjc4ClODd8P4aTwpfYYyg0jB+WIERv/t7ZRjVkXzAaQmQtntckfnX9cKkPENxmNpVtIGCoH5Gli1DtBALiUQZIxRAd9BgVZpwnepjJWPDkr2g8GNfVDTDgaYuxlnVAvBIf2Dv8bv9HTsGjBUj4RsJbKPNZHliHMPFoWPqxNfO90bL0i1yxKNw3UwsfPZFdq6VJqfT6voflwK0oiWPmC9uc6Z+KT0i9UFIBWjYSYa1a894=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5e4228-970f-490d-49d3-08dda8f78125
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:51:53.4983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4qgaEjw86YlAoszFJIfSqYlskCrSfPFISkwed+PFf/EdkPboncesMbCtN1LlfDAKswA0pyJ6ujsCxODQOvssg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=629 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110124
X-Proofpoint-ORIG-GUID: hyTmWfhY-SmvMNyixBDTSm_AWSgdh-o7
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=6849980e b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=RygNssP7KhhmzD4IiUQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEyNCBTYWx0ZWRfX0bBrZVASy98q eyUAq3sgDuYg3af3tupUVkJWn8D9s2CL+HNhCgxnNA37qcb++yJ6WssCFip/s5sktxXlwnjvupH ReAJSWLtT4y++0OSCrBCZk8ZDNX2Zja00cT7tB3Y0+K3UTNcBBa9j9/vEm3mi7rsR+7BVA3Qyxv
 9iP8tcwc5dXgHDR7LbAcVW6hA8PxXYtyWxDCTlR0IvMu+sGvXtVgJZfCQF2rERYPjlcPOmE8PFn nZs/HbBfn2xnV2MC8A7azSqFV933Le8u+ybr2/YA85CC9K5W4W6AkXdRtXrwDZwm5iKlrPMZ2Um RT9C9ZvchLxz9B7NGXrUxCh9biViHH9lZYbUJqd8rZwpJXcwdxjSXsWv9TUJTGUmprc2maFr6Ts
 1UDD29yTzEiSK5ecuu9B97tiSncVv7k2tQiSf1RrA+8fawi6fWizXotCyJ305eutgonCko9r
X-Proofpoint-GUID: hyTmWfhY-SmvMNyixBDTSm_AWSgdh-o7

On 6/11/25 2:56 AM, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 02:10:46PM -0400, Chuck Lever wrote:
>>> +	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
>>> +		return nfserr_bad_xdr;
>>> +	if (!xdr_stream_subsegment(argp->xdr, &lcp->lc_up_layout, len))
>>>  		return nfserr_bad_xdr;
>>
>> The layout is effectively an opaque payload at this point, so using
>> xdr_stream_subsegment() makes sense to me.
> 
> Btw, when trying to switch XDR to work with bvec backing,
> xdr_stream_subsegment has been a very painful primitive.  I also don't
> really understand what the benefit of it is vs just keeping on decoding
> the subsegment normally.  That might just be me not understanding the
> code, though.

XDR subsegments are useful when another layer will be responsible for
encoding or decoding the field. Generally a subsegment contains an
opaque (an operation in an NFSv4 COMPOUND, a read or write payload, or
an RPCGSS_SEC payload that is checksummed or encrypted).

For pNFS, the layout metadata has to be skipped over when it is
encountered in a generic operation like LAYOUTCOMMIT, but then it is
later handled by another layer (the layouttype-specific plug-in, which
is part of an "upper layer").

The generic layer has to confirm that the length of the opaque is
correct, skip over that length, and then continue marshaling or
unmarshaling fields after the opaque.

-- 
Chuck Lever

