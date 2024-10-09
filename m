Return-Path: <linux-nfs+bounces-6990-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 921BD997628
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 22:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BAE1F22DD8
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 20:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F431E04A0;
	Wed,  9 Oct 2024 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="koWtbuFJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ssDKN+g7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCC71D356C;
	Wed,  9 Oct 2024 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728504233; cv=fail; b=Xcel6Qm0pC6nGxCluIoVQchEu+PPPGzQncFjWgzr3TvwPIGbFUjSl49e1RPIcLx1JxqBljhJpO4jQC9FIAowLrLzBI+rm2dKXh/O0sxgLdGx4AxZuU3DpyiyB6IxoZ3KjXclG1Eh9XfoQE1ipTdEbHIQet2yOd2EHp73WhLYNVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728504233; c=relaxed/simple;
	bh=dtfPlQFEimKmoEwHxhLrW/7b0ACEZRBdZy7ESM5XtTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iwmXtwznlNGiupHy3/Q9V7ttHxz6YbCZFfL7Nk1GYsRqrFR6Q1Zbu8HX7dcpOKK5qoa93kOeAbQYMTV2AuUB0r93KbfepVkGxxpFbKnQEGwaszjjtIuvICTWLh4wuOwK7/PFH4J5LWicVAfykF9Xwsu2QyzLbuUdJ3BeG2zqXuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=koWtbuFJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ssDKN+g7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499IIU7n001303;
	Wed, 9 Oct 2024 20:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JwetsQABPcUe0VFYHAkI/QoAZ9ZM27RdFDCob/7Goyo=; b=
	koWtbuFJuNewjpHwFyKva4wwKS2JrE+hL9B2g06cRIK082wYMaa039vuRxPIHCcG
	VoqD89kOoz1yMcWiYwnZCGc76dEGkTHWoIR2LZi4J2XW00aAx8EiL4+TM/2ZohFV
	JozWg5BKLS8Ye5Quv+cLe+dVxc0sM75AJPonlpp5wMx3XJkuwq33feRz+PleGDYO
	doMvGMkXu1VeXFohOM6gy1k7YUZjHyLr3tqv8fM8I8OtgDUoIuXIJusR32K2+ASc
	BV6UGarUkjOO+CXdgXcHMyeiE4sAOX4LnacZ/IoZ5yPzm4FfQbNAQFwEpEhXH9Gh
	j3O5+XSVLNLpUs9IqZpPUA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308ds9b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 20:03:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499J3mxi019093;
	Wed, 9 Oct 2024 20:03:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwfe1sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 20:03:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBViDbBS0NcYkILvrBo68MMu5K6cFD+HhBboa3H4T11bcgvlR+QQyV0ELlfgHYtqqiOJ7lPfkT1suJHkii+kgr8v2KnRIgEmQSY0QwSBMBsnVlcXiXLrOPIaNQBYt6LTVL+bB+hvvlSfdBJKrJwJidg6ttP/f+qJiEOdAVb7yWJhBaDNumXziY8v/9EIufBtumZBTHWq13jQjGkrSV6p0aHDK2nX9iDzClf/shZNiETcn4stXQ49y0j+TAXLOZRxcPJXOmLSXjZi96HPjgYAC9XjP5qBfKINaq4/Kn36IOryd1yMUs+gHsscTx/ErHterAmVVGWY6I6ksXVSaQWDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwetsQABPcUe0VFYHAkI/QoAZ9ZM27RdFDCob/7Goyo=;
 b=aOX3GANl2EC9tL33+RWUkAukT7O8VwIQhLnUcrfdt8pWur8sXFL3oRbGgyuBC5l4NEJhfw7nS54xUd+j6N7zK3EWU4dirXfeVe+z4OeeWt+GDiVUevl9qFwzDzA+zwO7ofV9LdQck9xdrpYtR26B9PM0aF+vFRtGse72SJ0/OJaT6qt5DL0QIJpcRz/hmXcp5J87pQvT+txC/gJ+eJF4Cadhs1u3pU/t+T9WSWr7mldxtpbBefccZCO4a0gz5+qLoE+BNpHSgGJrpDZmqBWW+ORJalYS15OVXGa5SBPJBsaKmdQz4sIFNiWPcfoN2xsIdBXR1NAc5sKnUHCqVQfsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwetsQABPcUe0VFYHAkI/QoAZ9ZM27RdFDCob/7Goyo=;
 b=ssDKN+g7ycfrtP8keiJcrA006vARWr+D/SbqNvucrFvp5rbSR8R5rw/upFsb6vGHyLQ6jOcvwoIghLZ4IFjOlWK3vevHjQubk2CaoI/o/n2BujIXEmK8ou9Z0Rj6igWASGzSjKdx8m1rtlxzWWfAYDfCvUtCsnUQpWHG2QPS39k=
Received: from BL0PR10MB2947.namprd10.prod.outlook.com (2603:10b6:208:30::27)
 by BY5PR10MB4209.namprd10.prod.outlook.com (2603:10b6:a03:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 20:03:37 +0000
Received: from BL0PR10MB2947.namprd10.prod.outlook.com
 ([fe80::8ad0:1f2a:6f02:635d]) by BL0PR10MB2947.namprd10.prod.outlook.com
 ([fe80::8ad0:1f2a:6f02:635d%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 20:03:37 +0000
Message-ID: <3a2ce01c-954f-4552-919b-57108509177d@oracle.com>
Date: Wed, 9 Oct 2024 16:03:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] nfs: kobject: use generic helpers and ownership
To: Benjamin Coddington <bcodding@redhat.com>,
        Alexander Aring <aahringo@redhat.com>
Cc: trondmy@kernel.org, anna@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, akpm@linux-foundation.org,
        linux-nfs@vger.kernel.org, gfs2@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20241003151435.3753959-1-aahringo@redhat.com>
 <A81234BC-0E6D-42AE-BA2B-AF6004DE3C79@redhat.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <A81234BC-0E6D-42AE-BA2B-AF6004DE3C79@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::22) To BL0PR10MB2947.namprd10.prod.outlook.com
 (2603:10b6:208:30::27)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB2947:EE_|BY5PR10MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: 4466765f-11d3-4115-f643-08dce89d7647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFUwTWYrWU55REl5SEU1bXBmZHdsOTliVE5YM1pmUDJVR0JZMS9MYU8xUHBq?=
 =?utf-8?B?bGdrSWxqMDFTR2NDMlcySElmb3dqUDBBaHRwbUtaNkV4aldjQXVCZ2hVVlhi?=
 =?utf-8?B?ZEh1c2pnTWgvN0x6TnJvWkpaV200NWJyVGdZVis5anZUVGZ1V3hTY2QxZ2Iw?=
 =?utf-8?B?TlhXY0Q3S2RWNXY1SDA2Q25MNEFUdXhFVUtEN1NFaGdwVnlXOUtRVW5Kdkd2?=
 =?utf-8?B?OE1RdkdiUGczeXIxNFVwcDFsdk1BZEE0aTFCdTE4b2ppYTNESVZjeWJOakp5?=
 =?utf-8?B?UmVyL05VT2M3U1BHWVNENHBQSDQ1SUd3YXVYclgwQnQxYmxFZXNhZUVoVkhG?=
 =?utf-8?B?dUgrZmdBQlNCcVJ1M3RaT0hKVllya3M5QVBZeTJ0QUpVU1BwNGtCWEsvTEpI?=
 =?utf-8?B?NEtCRldtUTU0ZGQ3WWhjMjN0VGZBa3FvdWpFM2VVZFJSMXlMNG15N0pkT054?=
 =?utf-8?B?R2pwOEVZcEpHVFdHNGNsVzNFRUtsZTU3RGhyZjZPUUQ5aUVCUVBkZ2xuYUs2?=
 =?utf-8?B?cXRrZHhjWXVEL0VJNmZuOFNlZlpTOWJQN0pUQ0R3eGRaRkg5UzVPMk9VdzJv?=
 =?utf-8?B?bjFOM2RpTEU0LzdwSUhNY2hNN1VEQ0pSelVKb09YcWdrRkN4aDRHMTNxejY2?=
 =?utf-8?B?Ti84UnV1eFU2Rm5qUW5zSUxrdm1XeTY5N2RZcXcvTHVJNnpTbjdCa3lrRFRm?=
 =?utf-8?B?MnpMaDNxOWJHcFpyVzY5Y0wxNUljdDd3QTZKbkE0dGFCQWR3T1RSemcrZHlO?=
 =?utf-8?B?dGJIUUhZVmxEejdWQ1h5aGIrdndLbzVZZEczcDVRMzMxelFueUV2a3hYSkJm?=
 =?utf-8?B?dm9FcUpzajBMN1JpWG5JV2IwSnliZW5Ib2NudUhvYlZzdzFoN1Q2cjhybktE?=
 =?utf-8?B?ZTJPTFZ1UUNObXRjQ0JwNDI5TkUvd0NlVWY1VldvRnlBVVpXbHk1Rjg3dkov?=
 =?utf-8?B?bFh3eHMxVUZYM3JPaFhwVWxUUTl4bi83MXRoWWpuWTVtM25OQnJpUDJVODhj?=
 =?utf-8?B?WlpQc0doWDZqSENGZGxoWDhDMCtoVVVubVlRT1lod0lzU29ORXZpY29NeUJY?=
 =?utf-8?B?QUtOdmRIYWQwd1k2U3NHcHVtUWFqbmVLWXhQdG0yRGU3eFBXdHFrNDZsMUFz?=
 =?utf-8?B?cmRvOFZnNUt1OHVPa3hqd2tzREt6UEN1NmF2SmVqMEwrdWkyWlN6TlhBK0Nr?=
 =?utf-8?B?RXBpM1lsOC9VUmU5em1Td1pKeVpnOUlIN1NBZk40R0lXdzllNkJZS3h0VHgr?=
 =?utf-8?B?MkpOWlJQbkJiNnRURFhKeDhRdDUvbHdFalZDUUZzekxXajRzV2pzUHJrbzRt?=
 =?utf-8?B?Rm5VbFY4c3hWbUhaNmpIMUpmQlhkcExEbG1YYTc2QkdlenF0R0xhTTN0OWd5?=
 =?utf-8?B?Z3dtY3hSREgwb1FyTUQraDZMeU05V1Z6bVMwYXgrZGNTSiszTjdRT1phamcz?=
 =?utf-8?B?dmpBU2dUQzZtZG9yckhBbWRJaE0reStyaGo5c1dsYWxWaHRIMVVsOVNDL2Vw?=
 =?utf-8?B?aWIzUzJpQjcxQ3h1dW4vT3lNaHJHM3RsZWVmNGJIVS9UbjBJUExJREtRc1hE?=
 =?utf-8?B?TFZOaWtybm0xR3JyUGtBeUpiTGZxaVVaNzRpaDcvSmR5RTR1d2FjVkJ3VktW?=
 =?utf-8?B?ckZRT0kyWU5yRFdCdDFDQlE3cjhNYnl1Vmt2S29wVzdRNFpCZWVLVWRKbHFs?=
 =?utf-8?B?ZnJpeUw4bUZ3b2p5bVdsVUNoOWZMWlVDazNXWlQ0NDk2NjA5MzNjVkd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB2947.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K00zMmlNSUJJVkM0aGZkN1hzL3cxdlh2QWNnTlhWSjNOejBkVHlPVDJ5TFpV?=
 =?utf-8?B?bkZOYmJHS3pSMEFnUVdXWUNQaStML2xYUkdHaEJKaDJBNmoyd1MzaFoyeDlI?=
 =?utf-8?B?ZWR2bUNmSldsVnM2REgwRjVTeHdmTERGcUlVUDAycDArdnp3ZklUZk96SnJr?=
 =?utf-8?B?SXhGV1dtWjFJU05PSlFxbWRoTzhWR0dtQTZ6T3c0bFpmMFgzeHF2REpVdmtC?=
 =?utf-8?B?SUhSUFh3V0pnajdXdFFWOFlPdEs0R0NKdmVzNHdIajZRdytsZjlSRHJIUXpX?=
 =?utf-8?B?R3ZIOFc2cll5ZkJFQmsxT1lnSDdOUGxvL050czNYbE44S1N3cEZUcEdzQ0RR?=
 =?utf-8?B?UHdKNm81M0JFWWdiZ1VOK1orcGlSKzNPUng0dEpHTStVamJKQkZSWkdySUFn?=
 =?utf-8?B?ZE83d1BaSmUrdDIvNnhna1h0REtOWXNtY2hUaVZLdGgxM0Y3Y3d1dFlPZUtp?=
 =?utf-8?B?NGpaMUJIcjh4Rmo1VHZyV3N5bGZKbzljUkRKSDhKVkF4aVFrZS9UV0JNZ3NZ?=
 =?utf-8?B?Sk1tdENITXhUT042M09HTjhzNkIrYmxWWDJMNlZFN1k3WnF1bExxcmh0Y3Vm?=
 =?utf-8?B?UFlPRWt5SkQwYzUyelFqc05PTDh4MVptV2EyaVM5LzdFZ3ZyZU8zbVoyTHN4?=
 =?utf-8?B?cWlROXo4VnB2SW4yVkpqMTVLM0hVRWJleGovSlAzNDFXdnM3ZTVlTUFNeFlY?=
 =?utf-8?B?YnAxUnlTOFdlR3V0SXpxT1NNN284cjhHZTI2RnRsK0tVYkhJc0VuVVA1Wklt?=
 =?utf-8?B?ZkJCN0hlTWpmL0ZrNWV4c3VRNUl1QWY1am4renNPenZnSlR3U1o3aEs3NVN6?=
 =?utf-8?B?OWw1MUpYUjk2TGYvVUpEMHQwekJKYW1uQTE4RVJPUmwzTjVCclNoNXFHTDRo?=
 =?utf-8?B?ckZhcTJjdFpneGJ6TzdDOUl5ZUpQUVVjd0ZiOG1TWXk1SVB3NnNCTTZodlZt?=
 =?utf-8?B?eVMxSmVNMDNxc2JZaCtnODBLVGVHd0lXdDhaNi8rS0RxdXRXTUxTemZRekdk?=
 =?utf-8?B?NEpTeGZDNjZBOFUyVHM3bjh4QlZic0J2alIvdG5maGZYNmRkME51Y0Zrd2No?=
 =?utf-8?B?a0RUb2tuWnlrY255dkZFMHlmeXFGYThrSzZpa3hCeGYySXJuUTVOWlhiNXpQ?=
 =?utf-8?B?eVJsSHZaS2xsMUtwZ0VYUkNCUnRGcTFScWhQV0x1QTM1Nkl4ekNVRUd6NGZj?=
 =?utf-8?B?TElJSVpsbktHR3JkQlM5NVduckd5VGM1RWNrZ3A4SnFDL1hSM3ZJV3VSblJx?=
 =?utf-8?B?QTZHNUlwWWNBZlZUQlljanZSWFpPWm5NM205RS9mSFI1djlRMG9rSWduaW9T?=
 =?utf-8?B?STE4S1F2WkVFU0JkRSt6WmpudlRuTnNXMFlrSmU3UnpMV1ZkSzV3WkNlL2VB?=
 =?utf-8?B?bWFVRCtYd3haMVVnM2xkQ0V5a0F6QnFQRTdtcVhXWDE0Ylk5S2xteWxha2hx?=
 =?utf-8?B?R0dZRnRWY2hCZ0VkZ3BzZlRhdXUzSk9IWXU1R2RiN2xmN0dsVERYdTRyVVNS?=
 =?utf-8?B?bkp4NGpUemVCZExtZGI2NVFZMjFFb01TSWVqdS9JWlR1TkJXNzhCNjM4d1lM?=
 =?utf-8?B?Y1hHM2x0cGgyS3NPRGlnT2tsaHpZdzFSMlJBUGUweVNHeFI5Vy8yQ09wZUIr?=
 =?utf-8?B?TGxqQ09jT1FGN1JhbmNybG15Rm5QcGhpNmNsREdOR1RmdlhMcllLcDhjU3lC?=
 =?utf-8?B?N0dDU2paanVwajJzdHR4L2RpbEZLNFdBYjk5Tmp6NFRQQzF5VW5iTUFKU201?=
 =?utf-8?B?TFArYXNGMlpzazQycjVvV2twanE2a01KWlZ4WG1ZNmVZNXNOc2hqSGNKWXJY?=
 =?utf-8?B?RG5vMjNPR1R0azNBa1VJRzJyYm1YQkUvS3l4aG5iMWk2RjNrYzRBS1NrZGNM?=
 =?utf-8?B?Z0JOYVlvVDdXaGNCT3owYU4ybFJLc01TZ280VC9ub0lCNW45N2JWTDRqWkMw?=
 =?utf-8?B?OGYyQlVlTFpRRmVlZ3BER0xjUDVoZVVGTlNkdHpTR2VuUWxuekNieFVZcDdE?=
 =?utf-8?B?VWNud0x6dEQzYTZHVGZCUXp6SS9qdzdxalk2dzlyRHVoanZGUVVjZVBjbFJK?=
 =?utf-8?B?dVlDOWo0NHVER1BDNlVoODJDY2ZsQ3FlTnZtaTdSVXhFemU2UWd6NTA4YlpH?=
 =?utf-8?B?dmtqOXAzUEhtdUJxM1pxenQ4U09IZ1JwajJHOHN3N2UwL1k3blRhYTc4R3Fw?=
 =?utf-8?B?b1JLSXA0MGc4SXFWMHNISTAzOVJ4YlNWL2UxWGR1QVFxOGpZamJqeGx0UWtG?=
 =?utf-8?B?dmU4STFDWDBCTE9iT3A5V3k0ZVN3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sIfgO68IYsVw4urzY9Z2hZc8LnbjI2eMG78yTFHB+DkMuIVAZCegoW95MPeOTvkU6/q0Hh2w+Yv8oyUt0l6hHyV5UF4lDhNc+SrRjOJ0Xrb6vR+4pqSiimDh+XglN+FNIM61gB4Ms6iMwaynPMtjrYCbVMVUq1UbyFZmAi0JgMsgUr3GAlT3mBpCyGTg/C4FzYpICES5M2OK8Vj5Bi9Qxz2g9Zn15W9NRd/DpajIR2RBVANcAdBOmNv97/blXggybhzO44H0XPuGyeRoQLPM0SYHLLAK7SWBcbLecT/V/3HaUtqyeAUQiDxD47/MTJcl/+rCleAPD270YzZ8lHl6BqZ6v1LSZBSBUUV7oNkP1HDeTCoCWi5c4JhpAooG0D6ijxPwMLb8EeiRzfxDXgjBmVZlDrOsWbsi+wSaYbQFNgT+xJN30/IYcCv/Mx2t7mNHBKHgipK+/fyFz4vn8THjAovSTA9Ug1Mmr2UlhOaDM1HCoyvruN+r+ADNPYRJokB5OL4Cgn14QyFsQ7E61zyCzd7Ce6SU2wN/9F8EwzFquQFi9LoYczZ/9JJbRJ7/ulyQIFg5gGVMDQIrahVv+AuIuPQPQyZ3ReN6oJlDpEPSOMo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4466765f-11d3-4115-f643-08dce89d7647
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB2947.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 20:03:37.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LFm7XVKQFKKCfgljw2VU3WFDz9LTFQQT4My5br04+tYeW3/RUoEjEwWqLJRRAn11eOlGyJBkoe6C1Mstr8zd6zQy4TBnQ7O557NCteuJoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_18,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090125
X-Proofpoint-ORIG-GUID: G8O4YTHlId9unw_6zsXyZLGyg02GDVjQ
X-Proofpoint-GUID: G8O4YTHlId9unw_6zsXyZLGyg02GDVjQ



On 10/8/24 4:12 PM, Benjamin Coddington wrote:
> On 3 Oct 2024, at 11:14, Alexander Aring wrote:
> 
>> Hi,
>>
>> I currently have pending patches for fs/dlm (Distributed Lock Manager)
>> subsystem to introduce some helpers to udev. However, it seems it takes
>> more time that I can bring those changes upstream. I put those out now
>> and already figured out that nfs can also take advantage of those changes.
>>
>> With this patch-series I try to try to reduce my patch-series for DLM
>> and already bring part of it upstream and nfs will be a user of it.
>>
>> The ownership callback, I think it should be set as the
>> kset_create_and_add() sets this callback as default. I never had any
>> issues with it, but there might be container corner cases that requires
>> those changes?
>>
>> - Alex
>>
>> Alexander Aring (4):
>>   kobject: add kset_type_create_and_add() helper
>>   kobject: export generic helper ops
>>   nfs: sysfs: use kset_type_create_and_add()
>>   nfs: sysfs: use default get_ownership() callback
>>
>>  fs/nfs/sysfs.c          | 30 +++----------------
>>  include/linux/kobject.h | 10 +++++--
>>  lib/kobject.c           | 65 ++++++++++++++++++++++++++++++-----------
>>  3 files changed, 60 insertions(+), 45 deletions(-)
>>
>> -- 
>> 2.43.0
> 
> These look good to me, though patch 4/4 seems superfluous, I responded there.

They look good to me, too. They're not really a bugfix, so they'll probably go in through v6.13 (assuming Trond has no objections, it's his turn to do the merge) and not v6.12-rc.

Anna

> 
> For the series:
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> 
> Ben
> 


