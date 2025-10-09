Return-Path: <linux-nfs+bounces-15112-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04124BCAE6B
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 23:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE60A1A61182
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 21:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513EC280325;
	Thu,  9 Oct 2025 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pha6gpNr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PLbPDCRo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D6257435;
	Thu,  9 Oct 2025 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044717; cv=fail; b=iPxaCU9C5lKFSvuoTqAhhqnT75qKdjT2gykNoMt7FrXibwb5WsdKZD5mCrELylAlINYWAhkv4sQX2Doy+yLqhTo9Pv1XJaOsAXZjrsY0ktGXkxVp2Sa/KCtb83DxoIXj6qjvK/9JAEsdRw+llYdxyGBJfDlu2nSQz/o1C59rj1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044717; c=relaxed/simple;
	bh=758Gw3Waofsmk/594Q2itBzpeI77+0+VWYH6BZ0aNxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UuzrbpSxzZHlnjssTRC7PuqujaQ07CXk034EYlCUG8dFKtmhLEyRUpr8fhmEmetmNCPC2YaYyVMALatcvem7+ABSc2BSdUg62OV41m1yDvmCOlgFrMbIHjaJlySNlJU5KM8bFW0t4XY1LT+fYdKp9YPmxH1mJWY74BS4YhlYmZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pha6gpNr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PLbPDCRo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599Kg17Q019636;
	Thu, 9 Oct 2025 21:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lonjaxRIVjwzwjnEaKrPnT+/Gucw3HU52UzV2uP23ec=; b=
	pha6gpNrUHCBXWSzLAPYmna/V7b5BTmzeajQ2MfOO11mwkejUVp87SvWs8gBSV+J
	GzuAwZlQMGasjIGMVGnZ4zpMIaNl4jAYA7r86mtaT3W8HxLnnS7+mUqBrZwRsvAK
	Wmc/lvpdrkILCD3Pep8iaUFHh/a+HEEe7HbFwm9gMyNIBfgCPUGt3k0adlqMdVil
	behIR5uVA5/LR4nWpZq1MvkSaPQLVXCG5JOB0sNXcR+BZHlwo9qVOTok2uMt4x0K
	8KX6pqi8gw6kwi1obFdFJXItIEAlf+14xN0mzbMmnB2QYr3+ikdutjnygCYn5E6J
	WQ/QLHQLGz8odeCbWS6B/w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv69tgr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 21:18:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 599K1eHI036738;
	Thu, 9 Oct 2025 21:18:30 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49nv687c7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 21:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPg/CAhz4xegwzut/qGhy5fzYrx1vP4UIvBRaLhyhb4aPp0gB5YaO2TThdU/nDGEbh6YfAfkXFf7n8N0ZMds0wYf1TkUVx2KN8AoLUTIfBTxnxq+F06nKGzSJb2XraGvHDK4K3MMl3F7TMBxgothG7TKrTXVr0CU0kqHPl1qQySUwmc8GpXOTCllEXurug78GZYnPGXuwhza5yey3qgzPzsOhM5qcr3MuVZ4AT50Lugh5HeQZecG/uFprLywKwAS0lyLdBvKyPAtCeOd0hZZHKfQ5UQVe07y+HMrVGV1wNs+TTpb3m7eZz7tECQZ2RWUGoFtnmNWomp6L6092dmHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lonjaxRIVjwzwjnEaKrPnT+/Gucw3HU52UzV2uP23ec=;
 b=vQlegTKwtJVTgg5/RUmOA0OVUhWWwuAtTNT9dWa3aFTue0XjckMFWLHgN9dy8hiS2/yugqD83x+s5BdFYuGN5N0eR0w60iT6A+S5aDnWUB7sRuQsfopgbO/7oJ8HBzSCubDA6e04U/A7Wo4RaYIiiYq5ckK6Ma2CwSviNGPgSEkAZ87+6wRwHW/9ablVKh/d8C0LHz/no4e/JaSVSDSt73zFeA9q3pjLbVQ7ZbCOwKRGlkTLS6BlZAeCzFX1ZhJT/va/SEqBcKqf0iq1V041OScZTA9QbgGf48PYbh9Js9hb7JjS8hoGweHDMvXSdJSGDOKzVd7VdqWgvulcALU6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lonjaxRIVjwzwjnEaKrPnT+/Gucw3HU52UzV2uP23ec=;
 b=PLbPDCRozuMGFWODHfMC7e2GJHtwqy4YNZKafGCC0oRE5HDLKDoC1C2SgIO90cd01mf2Se5rCMV8/XvEUZpqxTwOK+4s4rDXRei5kL4EABCAYNWbiaHWMxMlnXsAz6FYPYuYA9sRdpdFrMnsbvL9vml6ox9TAv1ZGY5Gr4nvpMo=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SA3PR10MB6949.namprd10.prod.outlook.com (2603:10b6:806:319::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 21:18:28 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 21:18:28 +0000
Message-ID: <41489d55-4d40-4761-9a4e-88357c3866db@oracle.com>
Date: Thu, 9 Oct 2025 17:16:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFS: Fix state renewals missing after boot
To: Joshua Watt <jpewhacker@gmail.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
References: <20251008230935.738405-1-JPEWhacker@gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251008230935.738405-1-JPEWhacker@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:36e::9) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SA3PR10MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e53208-98e7-40b3-a582-08de077962a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3QwUXhFMHNtdm1jSmt2N2ZsdEFDNUhrWjVYUllvYWlJcGlNNDVSUDVpVmNh?=
 =?utf-8?B?S1piN2x5QndDMkhPT2RMcFFoOUdWbzVqSCtVR3hGSkVFd2p1cUdXSUw0a1Z4?=
 =?utf-8?B?S1FiU1dFSTVkRjU3S05VRVdTMkFOL0ZsZm5LRmhtcTJGY2I0ekZ2aU5YcGZ2?=
 =?utf-8?B?Sk9UaWRqcW5BK0x4Q1FlWHN1SjFkcHlJSVptOEFZeEpIQzQ2cjVkVHJaMEtv?=
 =?utf-8?B?dnl4bVg0UzZBTFhVc2JSdit6OFZpWlZBOWpPTGFvaS9zekYrdjVHQ1V6YnN1?=
 =?utf-8?B?blB2b29OL1dWd00zL3dFQUhEOUxaZ2hsS1pLbm00QUo4cGhxL2NYRi9BOFhv?=
 =?utf-8?B?TjBFOWxNZDRYOGlhdnROVkhhMEk0dWlFNjAzaS9SY3pTbmRDNFlCc0JFcmtH?=
 =?utf-8?B?VTVrUGx0eDdrRHJrSW1PMFFhWkxFNGpMV0xXWCtRV0tpVDQ3VllMZksrdkh5?=
 =?utf-8?B?N0VEUFFWOFlMU1kvL3A0cFc4amgxRUh3RmZ3S0xWSDhWWTR4VllmQkdOcTk3?=
 =?utf-8?B?RlpWcW5aaWlGaVNtbXJjSUpOamNnS0tvQWgrNkd6WVhTQWpxU3J3OTIxMmZz?=
 =?utf-8?B?NUVrcmVnZWd5eDUvRjZ0TnpndWdhdTBwc3R0M1FrNWlMQmc0V2FudHBYNURQ?=
 =?utf-8?B?Z1Y3c2tGNml4YjFmcmRUQ2xvRy9aWWw2T2F2bEJrbllrWjY1NGlwb1NrNjRQ?=
 =?utf-8?B?K3lIVzczZVFqa1V4Wm8wT1ZXVFFtVzR4dS8wQ3pBYVZZVUlMS1pTREoyQjFt?=
 =?utf-8?B?dU5nSlhiTStJM1ZqSWpwN01QRUVLa0dJck0yMGJYUS9FWEFBbUhRRGM0Y1dW?=
 =?utf-8?B?SitPdU9Tdi9Hb0ZiQ1J4VC9VRTAvTWN5L0RselV5WHd6UCtndE1LUVV2c2g2?=
 =?utf-8?B?aGxkWkFHKzRvL2RKSUhjamxZaG9NemxicCs1YmVVN2dOcm5nOElPK25TT1NI?=
 =?utf-8?B?Z29kK3RIUHlmbVRiUmVSUWJZMHRNUU04ZExYNWwyeUpKVExjN3BobnllOUVm?=
 =?utf-8?B?VVpQQ2FFdW5JSHZYeGg0UVlBQ0YzdlZZNjN3c2c3SXRZYXRoOUZSRncxRWJj?=
 =?utf-8?B?QWd3cWJXaDRVOEVoTGk1NjhYQTNncHRWcTNxajFoQ01Jam0waTJBMWNFQ1JU?=
 =?utf-8?B?S1NWZnZUWlRNNE41OGN0TUtxTjZjTUNvUllEbzRCckNvRitSR3JZdmVIdzlM?=
 =?utf-8?B?L0JFUG1qR1htc2NpSDF3cjVDUmRxczc0M25LUXJNS1VwdzhMb2xhZ2hQUGk5?=
 =?utf-8?B?SENNRG5qMm5lZTZSUEdFWFYzVXB0UWZON01mNlVSbWdiS2lDUDlWUVVjRzJ5?=
 =?utf-8?B?dFpjUmxaZGphcmJvbEE5L05QcG01L2o1NndPNU4rRGhrVjUyMllpMWlNS1dM?=
 =?utf-8?B?U0xZOW9nMnhuRERVS3ZKT3pXUDBYcHIxakh4a3M5UmU2NmRhRWlUdVNsOTlI?=
 =?utf-8?B?b3FWbmNLL2Y0eldIVjhyb0dMamRldkczMWVaWDRGd0FSOUZKNXRyTVNHWW5V?=
 =?utf-8?B?cXhOMlVMTnFveUsrWFEvS0U5cUhPYThQMGhtTHpJeHIzRjZGWk0rYmRRK1JC?=
 =?utf-8?B?Mk9hOTFmbGlFODJjZlRoMUVWZHFUeUtPQkxOcjZkdmhreE9zYldIQVZoVmoy?=
 =?utf-8?B?TEhGREhLYTFtV3gySHBlaWQxSEIwUlZ1ZEgxN1dmcGNyajJGNGo1UHoxNGxS?=
 =?utf-8?B?TGZ2MWFZM1M2UmtuT1N1OXFJR3FZQjJEQm5GQVFvaERwbFZPWDhUNng4ZThC?=
 =?utf-8?B?cyt4WUl4Yi9yQWcrYjJwTWRlZUxWd2R3U25nbzdSUWFNNlo0a2dhZ2tBTmZl?=
 =?utf-8?B?dE9YZi93WlZKcjhOUGZiNHZCeDdJbEYrY1N3a1RFMTVBWFRSQmZIT0xrMTRu?=
 =?utf-8?B?emhuL2xRMmVCT0E2b0plMmdMMW9sdzNscWJqRGNVaHg1R3Joc0NFd3ppM01W?=
 =?utf-8?Q?A/EAOYfJh/HjoKwKqvG7wbaWRCQiOvnA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHVzUndPd3haYlUvdkZLSk0vSVM0eDgxVWVIZEdkd1JNckxMS3l3S0ZMdC9U?=
 =?utf-8?B?MkRTZEp1NzBsNTR4bnR2MWRORWkrOEl1Ty9GNS9ZYkdXNTVQR2NNTTNiQVlI?=
 =?utf-8?B?YmZwMWRjM0NzeGhCV1k3RjZiQUt1enNMYlhtNkRoUEpvOTZuTzVkZjdKa2Q3?=
 =?utf-8?B?NDRZM0lJeVlaNWw1cHJvaHVXOTdVUDdNNFdERGlSenJsSU9XdXhYOXhwaGkw?=
 =?utf-8?B?bFRvYnRwbVRrTWpOSmdhbnZ5bDNNTW9qSXJNTkFFYW8zNHZrbVdtc2w0eVhs?=
 =?utf-8?B?em5qbnZxbXpqSlExdTlxb01mVjRUY0hEK1ZZbGdkZExEdFN1WElrekdNYkl6?=
 =?utf-8?B?YUVxYllhbkFNUUZNcm9lUUwxOXhENWNscEVzUzkvZTdVb0dkSVF0N1ZYTjNJ?=
 =?utf-8?B?NFcrN1J0NXFMSXRzV2RQZUZZVzZjeXYvNjB1SmVjY1V1QzN1UHJTNEdXcS9y?=
 =?utf-8?B?MUFYSzA4NDJiNjFDWlJENDlTQ21KSm45dGNra2ZyM3pBeUJ1UWZGV1FQQVZO?=
 =?utf-8?B?T0F6Nmg4cmlhYkhwR3ZRR1NOWEZ2b21LY1BSOVVzVXQ1U1BHdWFDcDh4SDI3?=
 =?utf-8?B?VDlnQTR2b3U0bGIzZkFEZncwdGsrd05YWUorQmJxM0l2SWdSc0F3LytnbUhY?=
 =?utf-8?B?UEdzREdqdWpJSnZhVko3RTBQZEhMdXpmaG1XWnFuNW1HcTZxK3F2OGJ2TlNK?=
 =?utf-8?B?MW1MN2pMdDVEaEdqSjdFRlVFM0pHb3p0T1RlZHJiSUVLQk13aFg5a2gxT1lI?=
 =?utf-8?B?SWErTVppTExEcS92RFNJUy8xaXhxd3NldzlGYTN2eURwVFhNTHJEOVVlQ2Zz?=
 =?utf-8?B?eWxyY3RZWnhERzgrZFBqZXpLMkd6dWk5YWxZWitrU0NQYUd6VHRxZVFBN0RR?=
 =?utf-8?B?KzlWS0VOcktKL2lKS21FZ2F1Sy8xV1J4b2FVNEMzQVl0d3lHczZDSDZISGIv?=
 =?utf-8?B?ckxPS3FNOWZMSWVRQWltc2JaUkVUTVZiLy9hUDZrU2R0L2lJODFCVkVTQjF4?=
 =?utf-8?B?MFF3QnNiR3RST1VmSVVwbjB4Q3BFN2xHaUF6RVEzVFAzSGdhSDlPVHdtcTFD?=
 =?utf-8?B?dVVIVjVhTkdMeFB2QmI3QkZWK1IySURFMmJVampleU1DZjZGSkd4SlRwZmt5?=
 =?utf-8?B?TjB5aWZWSlRCWmhlbjM0MTJsUEIweXJWZ3RFVHQzVFdkV2N3Z2FhczllRHJW?=
 =?utf-8?B?WFRHU3VKYWMrV1pUNDBsNWFHL3RGNVp6bWFFdmN4cUxodGtwSkF5WlE0dUpR?=
 =?utf-8?B?dGpGZkk5YTNGclZSWUxjdTE3MmdxUmk1K2hNaVJQR0tOcFJrby9Td05tcU84?=
 =?utf-8?B?U1VMQ3p4QTR4ZUFnNkFyeXhuV2dndzlvSmpJNXFFVjM4WGR6eVJ6bkIxeDFC?=
 =?utf-8?B?YTkrdklMZlRvOUxUckorcmtxcGN1TjdNaGM2ek9xZmVTanJlcWxRemhMdjlY?=
 =?utf-8?B?VUs2a0ZmZUY5NjRTemN6NEk4RzJ1aWluMThWRVJjR2xEb0VuZWZHV0NOQW1V?=
 =?utf-8?B?K2x2cmtKcGl1a1MyUnpQdS9rYnBBUGY5azBCL3VYa2p5bncyZkt3ZmpTelI2?=
 =?utf-8?B?RVJqODhHMENWSm1XeTUzR1NVaDErMyt2RmhDOTZ1NVFJQi9VVW5zdlJqMXNI?=
 =?utf-8?B?Lyt6c2E2UkgydG9ScmZGcTZBM1JIS0REVDFGVFNmUUlJTEtEaldsNnhMVXlx?=
 =?utf-8?B?eGE0Szh2bFhFWEIvUlF5RE1MZ1padm02MGpya0NJQzVtUmY4c09iVEVYMFdp?=
 =?utf-8?B?bHRNUDh4Njk4cnJlMVIwMjJETlBqUmhNMDBMbTVZc3BoK25ETnV3QUg0STcr?=
 =?utf-8?B?TGNYbHB5NnZSdDV0dXpzN2V0c05pYnJLWEt0aXpnQWNQeEhpbHFFWldscVlK?=
 =?utf-8?B?cmJXaDJ2QUJ1dktYU3JWejc5L1JNTGd4NVAxYUFIY0Urci9OZlkwRTBTYzNB?=
 =?utf-8?B?UERpQVVtdHpUVENNR3BPRUtZTHZCcG9rRjc0VWN5NG5mWm9heEJ4OE5zQjNF?=
 =?utf-8?B?Mmt5eE1LaDh3T1dmeFhRNlJocWIvZE5udDVsTDlGZXU3RVNiNGJES2hmMVZS?=
 =?utf-8?B?cHhQSTlUVGRhVnJGdzVmNTNuK3NtWDRhTktaU1ptTmp3WU1nMWpoUGMxRVVP?=
 =?utf-8?B?S2p1V2YxUWU0ZkdzMUQ1K2REQmtDMGd1UkJ5N3lGRGd6TzRFQ21paXV0alRQ?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sxu4n1v+z1eEovH5TyVA9T6Ee4RoYh9t0pH6vwYpIhlK3z15BBjOTGdBe68GqEPlMQnewh4vJbmoKnzDZzWoiPjD28LlfoITIGEzkgKaKcs6ZIW1QfzXZsl4vFMcG7KTtWmUbNFx/Uw95LELxWX5Qbsy6Y8w0ZxAOBDi2DazIy1s79548AXn0bnV1cOCwObtwKny8sQ8Qqfl3j8jLPUHoSYh4pFdWIRK2tPDvwW1P+U6FzD/Dx0qz7AoqWbAnMG7kGWdOlqPooKKkVRDlpWzqD0sFgU+ahij/I/rn4W3y3EVOH6J8chtlGBkQ+5X2rYBsVr2ifXsubbD57ny8ruclE+a3lZkBvjrqzFPjNZuhbSKPxY99aCWSjbajimpZ/JT9nnA4titOA+a2Kj6Npaxa8klYIuPkimvyb/1qxRdaHKLbKyNUHVcsKdzsP3c5FVEbL6/YmOUEtqifM8EPepCDPdaK35zClMU9Hw0QihsRzDbkqUyl9vB93aJVBtvPLkqlxpPm0so22moRMcpKx46RjBNd4YlAVghov6oXHpDsiz5MLXltH7CbkiNq4AHpILxNgTmhVNMqo2V1LW1mshXZ0PZ541f5/fng8OsDkSTn3Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e53208-98e7-40b3-a582-08de077962a4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 21:18:28.1640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWv1MjWcZPSejTMCKvl1LL+zrR582lI7w7luouCWDSBa3UM6sMFPo56Jo+kfcSeGsCKIV6o27NXwrQclYc1wTVG3huLik3GY7cf3Jqe9j7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510090130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX3SBASg6dR7vE
 N3Xsn5AZbaCprHTE2cwK2vc/WcCOnAgghCQsI0dd6zXJBJOfCM21kHVp9RWvRWhlQ20OSYxCG2K
 Shz4ULRn1hQzc5K0UCD4idya53ZYYVUFjp8ulNIOjCc8OyaQV/TIMIQiRxA43Z3oFnUAPhG7Rzm
 0zVt8xXq8a7QwU+f+ottQPKTgNRJTlO6ylwI72OfeQhyZuCY4PfJObZ0OXcOQI910YayUvYxEJ1
 /YoIO5SX3wjh83SvIfajtIysXtG9widdxTHWz4cOQ+G7Ciw84qKYbda+74jnr7BDzQ+Fipd3w1y
 MORLMu0NnedibtfY8iu8FT328G0wcUnvj01ovVSacvlPFenu19kqy4uxgtY7DjoxEDYEtZ0WXU3
 AyEFQTFcX86CVsy4N7PtX/dwUhZ8dQ==
X-Authority-Analysis: v=2.4 cv=dtrWylg4 c=1 sm=1 tr=0 ts=68e826a7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=GihYrfN24ZxaN-lLqYMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Gk26E8SBoYU76qtzXy0jGplfn4KmdQmS
X-Proofpoint-ORIG-GUID: Gk26E8SBoYU76qtzXy0jGplfn4KmdQmS

Hi Joshua,

On 10/8/25 7:09 PM, Joshua Watt wrote:
> From: Joshua Watt <jpewhacker@gmail.com>
> 
> Since the last renewal time was initialized to 0 and jiffies start
> counting at -5 minutes, any clients connected in the first 5 minutes
> after a reboot would have their renewal timer set to a very long
> interval. If the connection was idle, this would result in the client
> state timing out on the server and the next call to the server would
> return NFS4ERR_BADSESSION.
> 
> Fix this by initializing the last renewal time to the current jiffies
> instead of 0.
> 
> Signed-off-by: Joshua Watt <jpewhacker@gmail.com>
> ---
>  fs/nfs/client.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 4e3dcc157a83..96cdfeb26a90 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -181,6 +181,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
>  	clp->cl_nconnect = cl_init->nconnect;
>  	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
>  	clp->cl_net = get_net_track(cl_init->net, &clp->cl_ns_tracker, GFP_KERNEL);
> +	clp->cl_last_renewal = jiffies;

Thanks for the patch! It looks like cl_last_renewal only exists if CONFIG_NFS_V4=y, so this
will fail to compile with NFS v4 disabled. Can you please move this to nfs4_alloc_client()
in nfs4client.c?

Thanks,
Anna

>  
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  	seqlock_init(&clp->cl_boot_lock);


