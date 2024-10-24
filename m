Return-Path: <linux-nfs+bounces-7460-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261B79AF372
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 22:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A10281BE1
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 20:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92924185920;
	Thu, 24 Oct 2024 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L15vfeIL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZXoE+FHl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135D184101
	for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2024 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801084; cv=fail; b=OMaBJkuqE54hpq4F0Y51Cr7j/SxlZWWtylziMllcy3ZSEMEFaDkOB7WgPhdbXtxfoE6j5V5Pnl35QSfxKi8sQD42z9wFDkZ1PtYdb+yJrvipMm/LwUvWP9wicTJ+B8nflYHWygfDkxWgvtEHO99+jqzTCPQfAdZeqJTbFTVye3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801084; c=relaxed/simple;
	bh=0uRf3gtdrszskQE6AN2lr2s9q1TNei6rURYoeMSgV88=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CegO1z38ag4izraV3HbcstckkvncMq7yHWFTtlSJqovQ/6Hs9JedI4VJ6bycQtxoNLUgNbZChkdacaER7KFuMl8iPDR5wqfXbzKavWQvhXB2PHcx6Km/DVrllzkVXqVPopyXRgtbtOHI6ucaKsPd6Z2ijER/T/Svc9tm+sWudAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L15vfeIL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZXoE+FHl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OHmaNZ019912;
	Thu, 24 Oct 2024 20:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=0uRf3gtdrszskQE6AN
	2lr2s9q1TNei6rURYoeMSgV88=; b=L15vfeILUaNYe6bWzj+BLr7nLHuszCGg1M
	u5rjFWYsAUDfJpdvYsVf0/bfedrST0qCw8oOluJLfgso6PC87xAmVn81whVgq8Cz
	xEnox1XN6aYyI7jVj3dVcAzl4DLvkTwEDE2PGel8bsHi56eqmFewuhpBladlxraG
	PLGNnEV1vObv6UxaoY1/VZvJ+5dFqlGgsWbgSiDz5HctEoaLvuUkrrEtJW+jMfWq
	3FOMG/0IPhxnSDRqr4KUrRNLqK2GRsHOZalI3wr0++ialNI01CGIJjVU9sI0D5S7
	y1KwyX60soruTE1G3JsHgNBjVOMvRjZyKL68049pbX1s5UafAVTw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uujsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 20:17:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OJXh29030987;
	Thu, 24 Oct 2024 20:17:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh3fdgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 20:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atDG9jLFf3Lm6EE1cb26Qq7YbQfoJNmYYUdzNcbJW6YohtcY7nNZnhVR21YK337HB/DQSxl2Ol5fJIgVx3VJXlt5qcohgRX0lrxdtZpALlbtKWygU08Xq8K5hZaNHkEOjz5ZiAP7VTvdt7JHFMcpvfIUGeB632VcXusjYRy32+7yTgIXpWKWBVf54/JEufwOius4xx4dyoVzwbyJJZBco+QIrJ6vYQ9qoDyPr7F3iw/7iq49zGWG/IP4PIA5fwHp8uuux16fqlmcpiLzXOH9UASF0On4qT3KlguLbJKIpg/0hjMRqqhNlEy4YiiotcOLDIuBve4O+86ovmrfJ149bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uRf3gtdrszskQE6AN2lr2s9q1TNei6rURYoeMSgV88=;
 b=SG2gzb4mWce5m4gIvcU3aajrBRcVASto3xx+JawnXg63u8z4KtNrl69JvNmbfRJ9tFHYCmZUULHPv57KoDh8wfX0YrfEjQBTnebd6mr3y6u2a+KbT1eV9ts1xbnlHw55d7LKzTDIlc2x6pgwHdnb8Nq1gbY6Jg0jVRbkS6nhqf/93bxQD2SxKBnd+t9IA+soMpplJBSwf05foKkusnYgEInYlzYGKhhOj+FcY17PsTKI/EfCr4tc1ecQEyLIkJOAX05Gmrwcfa9ejYpJYseKQqOzCs3EYg/bMUaZQqdTSjn+UNt4/Szj1sNL6FjRHh25B5+XB6nBq6hsC0kVZsnrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uRf3gtdrszskQE6AN2lr2s9q1TNei6rURYoeMSgV88=;
 b=ZXoE+FHly43lHF28+5WfBb43uDUaL34kZW5iqrROsnSjC4k5lxcjjxv4tvAwziDFtQ/zrvpfC4r9DeceH4WpyyjW/ql5Rz5bUu/urA5yUOiH9MpiJvBsu4d15nsVyd0vHUoe4aIjc2lcDW8FnyqvQH+oM4XOEYhvaw6JsfOOj2U=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by DS0PR10MB7903.namprd10.prod.outlook.com (2603:10b6:8:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 20:17:55 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 20:17:55 +0000
Message-ID: <d5a31cfb-a82a-4513-8194-1ccda5e6b3e4@oracle.com>
Date: Thu, 24 Oct 2024 21:17:50 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] Adjust COMP5 for RFC8276 addition of XATTR ops
To: Yong Sun <yosun@suse.com>
References: <20241024091041.30811-1-yosun@suse.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20241024091041.30811-1-yosun@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QV1750JUTb0QpVYDFb0UMUBU"
X-ClientProxiedBy: LO4P123CA0253.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::6) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|DS0PR10MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: 645bceef-a39d-4b88-f9d5-08dcf468f1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDI2Znl2bmZwbjBrNHY2Q3FaMld6TjlJVTZpN0FoRzZ1eTRwNlBmT2puT05Q?=
 =?utf-8?B?dERSQ0YzejIvNWJGOXpKVU5Vb214S3kzcGEwNTI4NmxONWhIL2s5M1E2OFBt?=
 =?utf-8?B?UVNSei9GTkRiUmpyY05KVGZQbUFkM3p3dmE2aFI3Tkh5amhSWFNYM2JTbmIr?=
 =?utf-8?B?OUhDS3BQYWZZR0twU0ZSdlo2MjVaOStvR0pnMDBaTGVnUXNFbmo5clFHNWdG?=
 =?utf-8?B?ZlQ3MWVXQUU4NTJhME9KbXU3UFFQL25WSnNhRWpuRStiOEVjWUdBSXhMWmxC?=
 =?utf-8?B?aE9McFZWN2kraTJiSlFYeTBSNkFiVDYyZUFMWG45VU04c0hJZzhrQllNYVJw?=
 =?utf-8?B?U3QvUVY5VFJDVjJsWk9ya2V4YnlSdU41TEFUblNvR3A5cHNZTlRCUWdiZjdy?=
 =?utf-8?B?eHJRd084SHRTNGlYRHZZdUsvMkZUbTZ1cHpVQUdSRWZJSDlhcm1sZzAvajRt?=
 =?utf-8?B?MXdQSTBlcU1CTkVGVXltMXAyT1B3SEF1bWlSWG5jMXVKY0I5ZG85cjBsRFNW?=
 =?utf-8?B?RGxSaFg1R0NWeG5nMnd4UkcrS0xNMEU1WFZtVzNMMHVZa25DS2xrY2lZK3dw?=
 =?utf-8?B?a2ZBeFJaMVhKRFZOUVlQbm5vbVBVbHZkVnk2VEFmSWd5WDBSRmNMbGwzZmhF?=
 =?utf-8?B?bENhUi94OHpneFg2d3l0bzFKcHF4czVkT2pMTWtQdXdUdis2ai8xU3hJYWhn?=
 =?utf-8?B?aXkvMW1QVWJYNVVDaUFKQTVndGpFWm9RV1NKZmU0dFg3SzR0TklNWFZaaE1u?=
 =?utf-8?B?dUYwengvVjdDcnhvdWxKeVhaZWdXL0Yxd3FtdFBUZTNFSGFpWEJ3U2ZGeE9Y?=
 =?utf-8?B?Rk5MNXMyNlZOYzlJcjdqTnovbmJIOW9lYmtOOVVad0ZZbi9BL1U0ajI4dFhU?=
 =?utf-8?B?dVVaTllBZjVyeDJEUHFlRkFIbWhPbU1CQkNzSWJUOERlbEkrdG1CcTV4ODgy?=
 =?utf-8?B?UWRZVEM3SmF5b0dUWXhJYVdCUDFxQ1p4T0JQeE93bjZtck9uSDh0bmIwV3dF?=
 =?utf-8?B?R0M1YmdBUHFleUlLb0FaclNoZXJhSjFoSDFRR3dTTnhKbXkybG9QVHJlaTJU?=
 =?utf-8?B?MnBJTUU4a2VJMzNha3RrVGVnUGJ3aENnMkJMdVBFd3R4dmtkYlVrVFdCK3BI?=
 =?utf-8?B?cnNLVm0rVkhndkFsU0lwcjcxTXNxNG5vcUpVQ0JaUys0dk5VL2hrZloxOTlj?=
 =?utf-8?B?anpMUVVrd1duOUhnUW5OZEo1UTNZb3hLZlcwMFpxTlgrZEl6eThSMkdYYzlG?=
 =?utf-8?B?RTY0SVRZTHlOMVpkRFJ5VE0ycTcyRUxwU0laNjRSeEhzZ0pMZjEzV1RhdTZ5?=
 =?utf-8?B?TUIrbHhocEdIbTM4akZkOTFJSEE1RUlnRXQxSUhZZDM0dG5FcmdGTCtRZkN5?=
 =?utf-8?B?TEVUK2VFVmZlMHBkU2dDWEcvQ3JBTzlGeXlXNXBJZG1ybDdyQjBtbDRkbnIr?=
 =?utf-8?B?MjdPYy9HNm5UYVh0TTFBazJWNSs2emx3SENaOEhPL1dhcW93SysvVTZxb0xo?=
 =?utf-8?B?Y1dubVV3KzhQcmlDR01rTEFzYVVNRkdZSHVaUFQ2T1RmenN3VkI4aG1SYVJQ?=
 =?utf-8?B?NjEyRVlMTWZaYXlGeEhHa29pRm1BVHhXZTVVV2VGSnE0Y3JtSnZEbUo2WGZF?=
 =?utf-8?B?K3k4cXFIQ29ibC9jWHhZYmV2ZGlUbFN5eStrcUM3WDRZclJSVk1CWVZSWitE?=
 =?utf-8?B?b3MzZEJEMkovUXFvSnBUSWxJeXY1Um1Gc2dLZDFBajRldjNuc0NwVzdjZ0pR?=
 =?utf-8?Q?GE0uxY8UPOOsy2nsKI5Bgwl8c81A/P7Kt6z3vlL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZERzQk41cXN5OGRtVHE3SmRaaWh3Nlh0NUVVcEpTbGZMU1JXZkhvT3JzTzBo?=
 =?utf-8?B?SFMxUHRtMWxkSll0SkhVeFg2MjVGNVRzZDBnTDBuM1QxcFVyVm92aHNQWTA3?=
 =?utf-8?B?N3NjQlgwSkFBeElwdk1XSWZEUWRnNHNiZERQUG1IdmNmSjl6MFBUU1Z6bU43?=
 =?utf-8?B?a0pxV0wzRnBmbmg1VUlNc3hpMlBaS3RRQWVXZi9KT05qYVNqUEQ1QjZNL0RK?=
 =?utf-8?B?ZFArbWZ5YXFrQWZUNFJPVkFvRVd6eHU1SEJubkY3UE5aUWttMnlzVEFBaGZ3?=
 =?utf-8?B?TENlSk81SUxJeGM5SDhzaWd1WE5Zc1RlQXBMWS9ZN1FmQWM5MzZnYzFIajdS?=
 =?utf-8?B?ZEl6UTU1aldodktZT1BRQXZsaFA5WVlNbjRyeGlXMGtnbmQrLy9uVGxxancy?=
 =?utf-8?B?RjdwbUY0Qk9iOHVRT2ZBMDF1NXhwcTQyeWhMbnlPbzVtYk1MYXEyVDV4VFB4?=
 =?utf-8?B?enM0Y05jZzJVOExwTjFLQTczUXNta2VYdXJJYXZYeUdCbUUydVJEN2VhM3JM?=
 =?utf-8?B?aW1JbXBXL3FHRVp1UkVHYlFmb1piQUdrbit0Y2VYdVlVczhLaHdycVNYcmwy?=
 =?utf-8?B?KzBCZFJSbmNZNEFOUGc5anZGRFlNWnZDVzgzTElnNEEwZ285ZDlWV054Y2Rr?=
 =?utf-8?B?ckR1TzFvYjA4UVE1RnpEK2YwSjhML2ZwVTZmZDhHK0dqRHExN3hlOEx2RW5R?=
 =?utf-8?B?b3FwSGtJQjV3NVcra2M1WGMyOTE0d290MVNHeXFxV25FQUFtaEVpMnVXNVBR?=
 =?utf-8?B?QU9peVZPU29LeCtvNTJidnBkbzlHV2VkVDd6d2JBQW9HQWd5bk81S09LWXhX?=
 =?utf-8?B?UDY2K016SFQ1T2dPL0RPRXBqR2xvRnF4SEp0MVN0QzYwS0QyMFJ2c3FqdG83?=
 =?utf-8?B?UkNOMTBiS3JIcC94Mm9IUnc1THU1VExISG5oemFvMU9xbnMxRWVLWHpzUXZP?=
 =?utf-8?B?TDZQVXl6SXpBWlVMNEhSVmVwZlE2SEx3emdvYUpMUHRNUVJRbVRaRzVFTGl4?=
 =?utf-8?B?YUR1L1VaWTVkbkthdFNzWXArSG0xeG5Ja1hkbmpaRDVIZUZuNUh3WnBBZUNx?=
 =?utf-8?B?a281enRCYVZ4RUJqczFTeEFpQ3RWOFNjM0dPZXRINU5nM01KLzRYN05ucW9W?=
 =?utf-8?B?Zk5saHNuR1Q1SCtEMnhyWlVqeFIzY0lZbkNCLytUTWlBYkJsR1IyMzB4a0Jk?=
 =?utf-8?B?VWFxMS9TS3lGUlZudjI0NVB0dWl5SmxzL2haa1JiYTVNWE5XZ1U3ZFlvVVVz?=
 =?utf-8?B?eThiR21KbUdveURycFd4SlJ3UldWVjJQTmxmd0ZSRlp2WnUyQWNOOHNFemZu?=
 =?utf-8?B?aWU2c1RWbE9VU2hvdVcrNkQ1anVtejlzOFFyR0gvZHBmQU11TnB0TnA4T3hs?=
 =?utf-8?B?bGdZblc1VkJ5TEoyRTBCSlIrRUJoMEF5MnJ0TjNxWm1WR2UvWDdJNjBPakRV?=
 =?utf-8?B?bExENVpHWHpBbmFrMmlqQ3NWcGQ3UDVReERMZWt2NWRtcEt6SWZtamcxRk9n?=
 =?utf-8?B?K1VHcVVWTUVUWXZ6MDM0c0VyeW01M1hpS21aVmFFWHlJN25CaHZaZ1NIV0Rp?=
 =?utf-8?B?OE82T1hvNGFuRndveVozR0JQTHdxbFljNUJGdXFjMkdsUUZRRE15V0x6MGJm?=
 =?utf-8?B?QlMzRjFJUVZWcFdIdEgySmRMR3BxVTdoTFAyaHpRTnA2ZXJxMHlqQzNNUnB3?=
 =?utf-8?B?TWxUK2RVdjcrc3I1NUhRQ2ZLT1NIMjE3YTBEV2ZSMFBPL3I2RERWS0ZOcDRZ?=
 =?utf-8?B?RDE0a1orRXptcUgyZXVxM2t5dXMzTytRQlZWM1oxazBLZkJ6aWdsSHM1RHUv?=
 =?utf-8?B?Z3JwajA4blNUdC9tQlFiV1BKSEVaL3lJZWdoajNmZ3FNMHd2YmtRb29NVUlC?=
 =?utf-8?B?Y3hqZG8rTW1VZUNjN2wzUWtTQ0c1d1VDSUtLZE9sVlFhVUM0eitCdDZYZlQ2?=
 =?utf-8?B?MnhHRXR2ODg2Y3Q3YjQyaFdEZThrRHJudzZVdEtQU2hVU0tYQUVsdThnN21W?=
 =?utf-8?B?UmtwVkRHL1pkd3pOZVVRVzN5TGVFZVpuWlhzNFV4NEhtN3ZoVmQ2WXdrWHQ5?=
 =?utf-8?B?SVlLVUFvbGRzZUd2Y0hEZHg2dXBmbVRQWGtCQ093ekFtMEU5WGlIRG9VSFRT?=
 =?utf-8?Q?X8GzMCmq1NQDL5tMAsllk6oFw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Js+GDoHuspfNgDoemQmGDyi2G5UGn1WtwyGbr4FasBg08xxwY1uGICy629qBynAc902mRcfdRZmE6nTBe3Q4LnkBH0aiLkochp2ubPGXWhSZy+p3+yOBVOa0lBYo8BpnALPPRTgcptShl1W6q1SkAldK87IMXthVDT15bcbfleBH+Tp+i/aC61trJk+YOThFSVBNxF6osSMMbOu3Y5i7i2wYH+8baWQriT4DmXLmuNxSKguoPxLpAOh0dbK15pevXasI2m0m0yMT2nXDPvQp0ogxpfqyYET0dzdSwbUle+FiblXBkzd2FbpLOwiigjcGKRMlRBPp4/EQgF1VNBF+gDp4fVdAs+xVKooRfvszK8iLPDkWjTiW50EF982jRoZWrVW45wxNehQ6/IlwexktuIyg6zZsAdniJ5jKHpRz1d4uXL7q8B2jZu7wWt64sUtCoB27ZZOpCXMPJA7elvmXwBMDAKiAZx8JM7CkhmrWn7XSBGCG7Msh+sNZrgu0uFNROoRc4FjkbfG++mPoIVJuHj/cejpg7nB1IInXbTlJI7NqhqozaMjzhxuvFOSq9acTRQ434IiWaXATqS6EfhQLh2fxKyF5JvdoUCKFXVTyiGA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645bceef-a39d-4b88-f9d5-08dcf468f1ea
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 20:17:55.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1T11cejGy+K8VApmg5mbD7Y+MdFGTJpQdsvZAGQNiNBYJHEfH5/0nR3WgXkKbQgAobE9dx2No2/2boXxtE9Tsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_19,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240165
X-Proofpoint-GUID: So-8ClcAYV0BQxa3l-h4B70km2YZm45Y
X-Proofpoint-ORIG-GUID: So-8ClcAYV0BQxa3l-h4B70km2YZm45Y

--------------QV1750JUTb0QpVYDFb0UMUBU
Content-Type: multipart/mixed; boundary="------------LdyoS4hPyw0m60Pwn0mc0mPr";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Yong Sun <yosun@suse.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Message-ID: <d5a31cfb-a82a-4513-8194-1ccda5e6b3e4@oracle.com>
Subject: Re: [PATCH] Adjust COMP5 for RFC8276 addition of XATTR ops
References: <20241024091041.30811-1-yosun@suse.com>
In-Reply-To: <20241024091041.30811-1-yosun@suse.com>

--------------LdyoS4hPyw0m60Pwn0mc0mPr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQvMTAvMjAyNCAxMDoxMCBhbSwgWW9uZyBTdW4gd3JvdGU6DQo+IFRoZSBDT01QNSB0
ZXN0IG5lZWRzIHRvIGJlIHVwZGF0ZWQgZm9yIFJGQy04Mjc2Lg0KPiBUaGlzIFJGQyBhZGRl
ZCBzb21lIG5ldyBsZWdhbCBvcGNvZGVzIGZvciBORlN2NC4yIC0gbnVtYmVyIDcyLDczLDc0
LDc1Lg0KPiBTbyB0aGUgJzcyJyBzaG91bGQgYmUgY2hhbmdlZCB0byAnNzYnLg0KDQpUaGFu
a3MgdmVyeSBtdWNoIGluZGVlZC4gQXBwbGllZC4NCg0KSSd2ZSB0YWtlbiB0aGUgbGliZXJ0
eSBvZiBhZGRpbmc6DQoNCglTaWduZWQtb2ZmLWJ5OiBZb25nIFN1biA8eW9zdW5Ac3VzZS5j
b20+DQoNCklmIHlvdSBzdWJtaXQgYW55IG1vcmUgcGF0Y2hlcywgcGxlYXNlIGluY2x1ZGUg
dGhhdC4NCg0KdGhhbmtzIGFnYWluLA0KY2FsdW0uDQoNCg0KPiAtLS0NCj4gICBuZnM0LjEv
c2VydmVyNDF0ZXN0cy9zdF9jb21wb3VuZC5weSB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9u
ZnM0LjEvc2VydmVyNDF0ZXN0cy9zdF9jb21wb3VuZC5weSBiL25mczQuMS9zZXJ2ZXI0MXRl
c3RzL3N0X2NvbXBvdW5kLnB5DQo+IGluZGV4IGZkZjczYjYuLmQ2YmM0ODYgMTAwNjQ0DQo+
IC0tLSBhL25mczQuMS9zZXJ2ZXI0MXRlc3RzL3N0X2NvbXBvdW5kLnB5DQo+ICsrKyBiL25m
czQuMS9zZXJ2ZXI0MXRlc3RzL3N0X2NvbXBvdW5kLnB5DQo+IEBAIC0xMTEsNyArMTExLDcg
QEAgZGVmIHRlc3RVbmRlZmluZWQodCwgZW52KToNCj4gICAgICAgICAgICAgICBleGNlcHQ6
DQo+ICAgICAgICAgICAgICAgICAgICMgSWYgaXQgZmFpbHMsIHRyeSB0byBqdXN0IHBhY2sg
dGhlIG9wY29kZSB3aXRoIHZvaWQgYXJncw0KPiAgICAgICAgICAgICAgICAgICBzZWxmLnBh
Y2tfdWludDMyX3QoZGF0YS5hcmdvcCkNCj4gLSAgICBmb3IgaSBpbiBbMCwgMSwgMiwgNzIs
IE9QX0lMTEVHQUxdOg0KPiArICAgIGZvciBpIGluIFswLCAxLCAyLCBPUF9SRU1PVkVYQVRU
UisxLCBPUF9JTExFR0FMXToNCj4gICAgICAgICAgIGEgPSBuZnNfYXJnb3A0KGFyZ29wID0g
aSkNCj4gICAgICAgICAgIHRyeToNCj4gICAgICAgICAgICAgICByZXMgPSBjLmNvbXBvdW5k
KFthXSwgcGFja2VyPUN1c3RvbVBhY2tlcikNCg0KDQo=

--------------LdyoS4hPyw0m60Pwn0mc0mPr--

--------------QV1750JUTb0QpVYDFb0UMUBU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmcaq24FAwAAAAAACgkQhSPvAG3BU+I+
Kg//Q93YjvjBX+tRF0M9dQEXkX//h6be6tKypuvQ2OP58DLncTxjO5cND4CEB/CqXA7IRLdVvL73
ZSTkhU67aAKGzmOk4P9lZ4UXUEFnZ4ls4vE0s7WBhidlS94FUpkXnj5qK/XtFKBr6bLaxiKFvS5K
U9voC3cgTFvm3a4Py4F9UFsHBWqy2K2Cdv1YRZIr2aZXSwGM4FGpzKT+nUBdIatJx9kIPZWYMUFc
oyoZSGaZlqGNka+zGrjjrEdtRWjEiufxNM4PwZ9O083C7IG0RP+2giVffzbJUPsbm9PFughzh57p
A+qvehTLK7GxkO3gTOwE2eQKfZqyk60tx7Uprh7O/gh4ek0Nh+Cupsld7xVXu46ezR7qE6yE0JQS
AIBCY5tzrPknavhePlPMfZe0VQOnoT5kULfy4wLq8w07ZkS865wFfgSr1KlCZuFSopkU3NVZySjc
47XguyAevndc0Fufrs9Qxz9+igifr+RKdW9Ug4Z12VtjA675Ccfs5csiSsYreECfeBHT+Kz7j0RH
x9zf0n3VFgr5kT1O41jSbMQz025ScNfCmNnGLcVS2YyQp3FIYmaW3sB6xDU65X8KUBG2Jo7dhfNI
GAdjW1tQrtZCBzmHqi66p1Uy/JFUZPHjG6qZBeDbOPowI27yNv1qNZrG/vSBGKRFPHfDybXUJrJ8
x/8=
=JF2D
-----END PGP SIGNATURE-----

--------------QV1750JUTb0QpVYDFb0UMUBU--

