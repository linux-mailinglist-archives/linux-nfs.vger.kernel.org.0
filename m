Return-Path: <linux-nfs+bounces-9309-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F7CA13DB9
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 16:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DAB164198
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B893A22AE55;
	Thu, 16 Jan 2025 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d83ihQCk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yqt5b3fB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26324A7F6
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041639; cv=fail; b=XJE9tquVkT7sQP5wKSZilMcDVHutgYx2UimHAdFJxC9hQvzHLC25op/WdeWZCtc1XnNzapRbyN/QwM4atbfApz1GfNf/Sw9ki/S/cRMo7l9iPLsi1jeyy9QN1f8Pvap+wR6Yb+T7Jz3kwGXYTB5oI0UVEBBvy4g5FCqFjlwxpvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041639; c=relaxed/simple;
	bh=N6cW2UwR0XDPbhwv02j6/f+BVP/TMIpmJlv7tckyE4U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nty3EU4FZE6AM2da4VPm5qTXT7w4K+KseGr1YPF3uc2lsf1n7Gr/KJD6u3tvNmfYyg/ARR6mnlT2UbIs2p5eEuXZ37yAkZnxgxhMMWoMDz18/+j33iRvp6gjMnSKwAp1t99eceWapQ0HXgmKCn/UbbhdElR/bYuc+5/b7RGtcYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d83ihQCk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yqt5b3fB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEuXjs024278;
	Thu, 16 Jan 2025 15:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FKo5VUYT+cNrOa++PAv/wXWPtBsYG7vzdrurnn6MMMo=; b=
	d83ihQCkK+ma6838tSyOHYWkGcbY+aZ33atmsS1Oxbimhb06IT3jW6GVlqFohIkp
	fBKXFhC6M5rMeHATg2COrwxsd538S0kFnmikuIZ8QRR02on67IdnfdmcQRJu6lTx
	dPApOoMYqDgeLBQqwkC+xfSboQSJZkbCZIf1atjAXgSaQVahDii+HBbOal9agW3q
	AJn1UsaTsRxA0UyWVnDhaYEHgUieUcwRTMvDx6SYsGdSXTHieplZNCl0ROCEGsBr
	zLvvGUcdgJfh9tkq27xVtgLkbCofJTl27RU1de9jLrdpHeGi1NC1nzHlcp3cEeVW
	dDw591h2fB91tWEDmglYbQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443g8sjhfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:33:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEafek029872;
	Thu, 16 Jan 2025 15:33:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3axjum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlRj82dYJLwlyLDage9QAYpcG/ajq6FpmllBX6MJDDaVdir3GMtZdaKhDBbRIkVZP0DHqkEtrYQYiCXZqn/ahwce0NRDd5IuiYRPB2kNkfq8DjhtgcDghdYuJ7riJS3yc7B6L/lWboE+UC1M25GEdP8c7KKxiH5lwIgzfFw/bYGtxetpGpwYZT6h+TibpM3NGDWOkT5Iu0Qxg+VSUz3B6FSZkUQboahyrhxaGArRl8N4973p0xCZr/lDDjIeCQgpR5HoJgZoPD1292IYnh96oVFU0IYpFs+cF0wlF4AOHVF8FmWHxnIsxMCNwc395OdQyXBmINQ8Cp4WWaEWJ2zpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKo5VUYT+cNrOa++PAv/wXWPtBsYG7vzdrurnn6MMMo=;
 b=jYGGVl51CuqsZ/wpWjXp/2HskaAD2Lxta4CQPp42n7fY/jFDHO1Np5POvtFrqwTpU3XHECdvoObKU4Hc9pbeyMLlWLFcPZh9iAQeAikL+aMyqaRwq5E1eb5S6NGUh+8GjneTgb19nGwXjKFaxvDZPSbZ10qHZSqP9qCAUssaASCM5fQMfqYCGoHiYKM3fMBNrUY6PF47srh03fvKJbk+LEtexCstWk04BPpqw9bk39IMPKFLJMXHOHQ6IWn62zhIC0UZvTjphEve+iy11+RyY8lJW3lj9QREz7Ln/jfifO9W4SfKE4xNRYIX/DqapSB8U4MCl6Vwv1RM3Qtto35JBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKo5VUYT+cNrOa++PAv/wXWPtBsYG7vzdrurnn6MMMo=;
 b=Yqt5b3fBQJ7ont+IWqx6bgcQbL08YjQC/WR5u8rnFBvqnkKKDpznVf+BTaORvpY5VinF9V/Dd9kkaU3a/hxuC16bPKVrJhfs0n9xEGts1a4ojFjRx4vyMtBGVSb3tROqMEqfb/K4jhM4AOVzvKohenxIs7x7v1cW6gnKImIy3SM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7294.namprd10.prod.outlook.com (2603:10b6:8:f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Thu, 16 Jan
 2025 15:33:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 15:33:49 +0000
Message-ID: <f2c87e35-2ce4-455b-bd1b-e567123b368f@oracle.com>
Date: Thu, 16 Jan 2025 10:33:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] llist: add ability to remove a particular entry from
 the list
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <20250115232406.44815-1-okorniev@redhat.com>
 <20250115232406.44815-2-okorniev@redhat.com>
 <b469204c-adb7-4cc6-a8e9-dfd19ee331df@oracle.com>
 <CACSpFtAgN7+7Bwa2dQckdC++QF-zP-ZBPyiphqoV2VgPatQt1g@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CACSpFtAgN7+7Bwa2dQckdC++QF-zP-ZBPyiphqoV2VgPatQt1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:610:77::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: c066fd95-b89b-4d7a-3dfb-08dd36432c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2I4cDRPQ2lMdWJMaDl0S3lnQTlvUnVtbC9wNmlyRDBxQnowVVAvT0JDNjVN?=
 =?utf-8?B?SkZZbDE4TkcxMElya0d4NnJhVm1VMDYxTjEydHFoam84TmxkOGFIbWVHM0hL?=
 =?utf-8?B?TC9QZE0yWGJGbnV6UG5rT0I1WlBTU0ZKa0x2N0FZcExrRU5yQzV2M283Rmtq?=
 =?utf-8?B?VjhqVDhSY3d4YlBmT2c2MXljMTB2V3pRQ1NqdDBBVFlrd2hBOUdNeUdRVjFn?=
 =?utf-8?B?ZXgzRkF5ajEzWXRFajZxa042d0lDTVo2Z3lJQWFaUVY2encyVDVNNXFKVGtp?=
 =?utf-8?B?MVIzTVZPTFF5TmhHUjRHTjh2bzY3U3Y0YnhPRzdXSGd3c25HVitFQlpmbjEy?=
 =?utf-8?B?NWlVbFZVb3g5Q29IUnlPQzRLbGlNbzBLQnpsVlFzNEF4ZDdpUURvRDl1OHV2?=
 =?utf-8?B?Tk5KaVJzdWl1aFpoUVRWR2FCbWtIWE0yWEFYdE9yY25VUjBHVE1EZnAyY3d3?=
 =?utf-8?B?Q2F2cXpzMy9Gancvcm9oQk5LYi9ScUI3WmowZlNaOW1QUkRNY3QwaC82SUMx?=
 =?utf-8?B?L2hXMHBCQmIvUEpqUnBlc082YXVOL0c2WkZyVlZxSGZYYXRxTm1OT0l5bENV?=
 =?utf-8?B?QUNpLzFFRDd6ZlpIM29JdWNRT1ViVUpsSitYQ0FkUExWQmE3cnp2OXYyNnl1?=
 =?utf-8?B?Qm4wcVNOdTNZSlRFMDNsYm5COTRKMkxKQ0hYOXU4eEtLakFTRmg5Tm9qanU3?=
 =?utf-8?B?UndUK082M1dqc3hhenVSRHlzVnlKakFLMWxGL2F6WEp6Q0ptNnlaQVdHVFAw?=
 =?utf-8?B?ajlURTFPdVEycEp5ZXA5UWZnS25rUms1OVlpd3hkbE5TbEZpWStmRVF1TFpB?=
 =?utf-8?B?NmVmSTlYbzZUd2FnaHNjcHFwdjZwREV0TGozU0dxR2o1MDNnL0lpSmltV3Uw?=
 =?utf-8?B?d1RFVFl1R2MyUWhuUVkzKytXSWFjc1VGaWRRUXprc2ZHVWlTUEkva3NUV0pR?=
 =?utf-8?B?WGRxcGhpWmFCbDBWdlM5Nnc4eStlYkYza0lTbnpuRStkSDBlYjNsay9OVmJB?=
 =?utf-8?B?VjRLNTFwS0p0dG5DZmI5MGVTTkEzeXl1Um93V2hvN1NDYnFyeUdWS3NDejBR?=
 =?utf-8?B?TnNxYmphYUdTSFFlbnoyTVBhSmVLUngzUEV0WFF4dUdNZ2E5SzF6OFY5U3VJ?=
 =?utf-8?B?SzJGcWpXeEJxY2JhQmpodFhFbW5naDBnVnk1NEZncVlmVWdGSXFTUWhET3pC?=
 =?utf-8?B?Z3FNNXhYU0RQbFA4VU53MXFlajdyR2R0aFFtUTQ5cThRbUlsY1pxY2xTbjA1?=
 =?utf-8?B?REc2ekVybDF1NHdzVVJ1WStoZHBCYzFjM0lIOXVNdkpmb3pEMkh5SUFNUUJZ?=
 =?utf-8?B?S3NrRWdpOE9GVzdlaHgvbzB3WEcxVUR4TWJreTdxcmFuczdjMGpTL3dnbFR5?=
 =?utf-8?B?WEZMZlliMkYzb1FzNlBRSjQrWHZiait5UjdRem1qK3F3dVFLbjFIQSt1MjU4?=
 =?utf-8?B?MDUzRDNxcDM2RnFDcVZNYjVsYnVSOVE0RTBnRHdPb2xVcjUvY25ubDhSUDNt?=
 =?utf-8?B?MGFhVU9sUGMzS3RHa3pBYk0vRXdQa09CVDlRa1NpOHlxUWJhU0wyYkZVMllC?=
 =?utf-8?B?dXlzVk1XUUkwamdSVTlKQWRyLzBUUWtVMDFEMS90L0RjMmVCVHZVQjJJWU5H?=
 =?utf-8?B?Q01MTkRtUXUzRGZuNWU4K2RPUkx6Mkxqc0hJbkpmMTRzTmU0OU5kVi9EOE9i?=
 =?utf-8?B?OFNTN000SmJGZUl1dHVlUE16NllJN3RZeU9DVzhlMXFxVitKYTlUb3RZNjhD?=
 =?utf-8?B?L3VSWm9XSTJWZ0xjYWYreTdpMFBBMytyYkYrcjYrUXJacityUGtmN0hwdmhY?=
 =?utf-8?B?eEwzL1JTTEFKSFVUMC9INUcxaXJzekRMMU0rL3htSTZHTi9oNWJyeGdlOXhE?=
 =?utf-8?Q?TTGfltJCaa4zx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDhIQ09VU1dxb280dWxhMkltRlR2d3M3TU5aK0ZKTnkydGdDZmZQNXdGRWp5?=
 =?utf-8?B?SkwySmhjbXJCRWN1eUgwbjhWK1VxS2Yra2RES1QyTGZnV3RHMVdlYy83clMz?=
 =?utf-8?B?UnE3ZVRKbjJGUkhPcy9jMjIxaUoyemxQL2U2RDNyR3M3M0YrWWVLTFFSR2hu?=
 =?utf-8?B?SThreDZFMWlGcmY5cUhLQUVyNlhjZlppdVJTaUs0L0R2L3psd1VFYW1VNUtO?=
 =?utf-8?B?L2ZyOHgydHBpeGxaSklyRnRPRnNjMllGY1cxdTZLb045ZFdDMWRkY2M3RmRP?=
 =?utf-8?B?N1AvZTVRcGdJSFdlUUE4OW1MV0NBVmlnNXgrTDB2dEFOdFBwYWMzRW5oT3E5?=
 =?utf-8?B?SjNHSDU5eGxic202L0JrZHNXc3dRWmF4K1pPSUdRRXFDY3BPUGY3Tytoa29H?=
 =?utf-8?B?SWNMSXZhNFJXK1dVazRWaWJ5WVNCRndTSEN3UU4zU0VERk5mOGhNSXZyak9T?=
 =?utf-8?B?a1lyYjFGeEtYRHNUeSttTWxEdEdGOUxqaGlKbmhpNjV2TkJjUlRWNTFqNUth?=
 =?utf-8?B?Kzg0bWVkZkFDOXV5Y0NnTGU4cVZvd1hMWjZqc2xBWDArYnpuQjFNUzlYMnF4?=
 =?utf-8?B?ajhJZTRMMWs1QUc0MnpSaWIrZUxKQVBTUFY2Y2V3aElIRTBYdGlrTGpEdFBv?=
 =?utf-8?B?MFVLdklnKzJaTjU4Y3BZeW1hTnFjcUFHYjIvb0wwSUFRMFJvczI0WkV2OTZl?=
 =?utf-8?B?UTVPSENRN3ZLU2sxSGVnK0JzM2RSTlpWNVhjUnlUWWgvdGhHNjBWRmJ2YTdi?=
 =?utf-8?B?VjhZd0RBWjlBTnZ1WFU5d29jQ2xwU2NuWW9nV20zcnE3dHNHVkpLOGY1REg1?=
 =?utf-8?B?cUJ1bkRVclQ4aEVpeGNwTUJLOGZ6SUtTVkwwMjhaYkptYTYyTTRHa2dUWmF5?=
 =?utf-8?B?S1E0OTRCeFhCUUk5YmZLUExISmJEaElGK0kvTXZCMWlSdVQzMzVJMGkxbGZM?=
 =?utf-8?B?MnkxSkVKcUF0cndBRUNraXROdlNYWE1lVUVPUHBJSGdYejJ1Q1dZNFZlWVdp?=
 =?utf-8?B?cml2OXpnMFAwNmRsTzV1SXlncGlTWU5BQ2kwQlIzVERUa01Ha2hDcWgydGpB?=
 =?utf-8?B?WFhJSnVoNjlNTmRRRFFxQ1RwVGcvczZIdTlsYm9SY1drcy9YcE9hcElYWHBs?=
 =?utf-8?B?MFN4MitqU2lIRXNwYVRqMDVqMXlNczVuRTRkQW5CdVhaNDJVV3hlOHUyN1ZC?=
 =?utf-8?B?M0xWOVpDKzJNRzE0Z1Yxa2pCVktIK0phNTRYK0laNzE0aWV5RW9RcW5XWGt1?=
 =?utf-8?B?em10WEhJVmtmRzNJZ0xPTnNXYkJZbDhyNSswQ3U1SEprTTd4K2xJRFgzcDRQ?=
 =?utf-8?B?N1UzVkZPVFNUWGlkOGtwM09vRkYyeHNJL0pyci9LeDAvUzJ6K0hSY0k1bHV3?=
 =?utf-8?B?aElhMkFUU24vbDk0eXRjK0UvUWVFYlhVaVhlUUVGMXRXUXpKeTRNTnR0SjB1?=
 =?utf-8?B?cWN5ME55RW1JamZZbTZDM3N2LzkvZ3NjNGw3Slk1OXRSbG9kZW1KNHVGM3I2?=
 =?utf-8?B?cStJeHJrRUlscFRQZmtsL3Z5d29ieG9TQ1J6dFRTNlRWUVo3eTZTRE5OMWY1?=
 =?utf-8?B?cEFybHNQZmZEaUdwY2hDd2VlUHZJYUFmeG9tMnZVc3VjcGh0d3hXdGtVTDBR?=
 =?utf-8?B?aFRDOWM3QU5sU2xFQS9CUG03Z0VpTnp2UWZkZXFnSGx2a2pBNTFneEY4NHdX?=
 =?utf-8?B?QVRCaVNKUlg4N05iZ0lNSDRQeVd1dlQ1Smxsc25zaEdZeFNTS1ZNSHh5TVZz?=
 =?utf-8?B?R0E1bWMyNWUyRDNhbFN1Z0JzeGJKajZsS01TV1FWbWZzWGpEdGd0WXl0Vk11?=
 =?utf-8?B?am5zS3FtTjhIbTZTNVIzZHRGZ0NtR2JIOXZwNnhPd3pMRzJCRWdibnRtVHRl?=
 =?utf-8?B?Q0Vwb1VkMDhVZ2RWdjgyTnZZTDZIbEdkc05aTGxXYWd1c0drNGhkNGNrcTFB?=
 =?utf-8?B?NFljeXNwTVFxdVU3S1pWWUZKVFZ3U1A3UitOcVZRSGZxNUU2UUdTLzVzSHB6?=
 =?utf-8?B?NDZ3N2FaTlFYQjloV2hmbW40UFJkL3JQdzVabXk1ZStsWHBNQmVacDN1RVZy?=
 =?utf-8?B?WXRNcFdnQzFQS0cxU094c3BUUkZpMGpkT2JJRVZDK2svbXRLSWovdHlJd0p4?=
 =?utf-8?B?MkJFM1E3U2d0TzgxTy9BVGFxVnVmV1daTDF0WlNnU0hoWDZCcGdJaXhBbE1u?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ymh8ErmQfE4VamDwDe24MmM6WJo3J31a+EhnHu+kFibKTqUDsu9XUx2yEMt+v4+GpHCb4gr2KaYCvxVCTXkMr6zoUdEkRI9kbp0GZaLyxy5mDhJJJdWnG6Mbqw7wY63XCMrHchz6q6rB8CmIk5QtmSPaNl++ssizbytQpa/mWOv4BW1gm6w3OPP8jXLvzTHN6I767so1EgR3vrE+61bvvypUoSlQwXndc3zY/ZUDM122H07X+h76A0IFn4LVPf6wN1NnLluj/pL/dbWolL6HRR5jc3wxwRNwtG6sB910va/JSMcp4klSXuArqpPB2lbdExhx9XncILoT4YgwK2gxb3O22TPFhyOSUXaxxW+JxgXSYCy2Fg9NKGi3XeLjzM6VORNGeC1puQ+JGBR++IBhHrjGifnAsUoWP9ZFGsGQ5/rHduYJB8bnMeN9IWjdPGqA5cMrw4Ewx0pV0HCdb6Lx5c/asMFKogekSs7zn1d/b3qYiFg5d9YGtafrPs+6zT9db9ndYB3q+AjvQdn9IRgloSbTRwOwSmSC6Tg+eZ4ZLYFWIJrVPnFTr3ZLE3Al7JV+3mq6QXibsSTo42QUtDwK/bSGBlTjuco6HbjErWq3brE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c066fd95-b89b-4d7a-3dfb-08dd36432c7e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:33:49.5492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRFBi8mdCrAB8hkl7rFpk+MEb2lDt1lq5BKgYmGsanBL8S1PKhAlDOAFWn9wNyxFJy51jnKyZgNuDwwAFh9K6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160117
X-Proofpoint-GUID: hmaW9ruT7FBscSlbuWxAgVSlLrkyoO_D
X-Proofpoint-ORIG-GUID: hmaW9ruT7FBscSlbuWxAgVSlLrkyoO_D

On 1/16/25 9:54 AM, Olga Kornievskaia wrote:
> On Thu, Jan 16, 2025 at 9:27 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 1/15/25 6:24 PM, Olga Kornievskaia wrote:
>>> nfsd stores its network transports in a lwq (which is a lockless list)
>>> llist has no ability to remove a particular entry which nfsd needs
>>> to remove a listener thread.
>>
>> Note that scripts/get_maintainer.pl says that the maintainer of this
>> file is:
>>
>>     linux-kernel@vger.kernel.org
>>
>> so that address should appear on the cc: list of this series. So
>> should the list of reviewers for NFSD that appear in MAINTAINERS.
> 
> I will resend and include the mentioned list.
> 
>> ISTR Neil found the same gap in the llist API. I don't think it's
>> possible to safely remove an item from the middle of an llist. Much
>> of the complexity of the current svc thread scheduler is due to this
>> complication.
>>
>> I think you will need to mark the listener as dead and find some
>> way of safely dealing with it later.
> 
> A listener can only be removed if there are no active threads. This
> code in nfsd_nl_listener_set_doit()  won't allow it which happens
> before we are manipulating the listener:
>          /* For now, no removing old sockets while server is running */
>          if (serv->sv_nrthreads && !list_empty(&permsocks)) {
>                  list_splice_init(&permsocks, &serv->sv_permsocks);
>                  spin_unlock_bh(&serv->sv_lock);
>                  err = -EBUSY;
>                  goto out_unlock_mtx;
>          }

Got it.

I'm splitting hairs, but this seems like a special case that might be
true only for NFSD and could be abused by other API consumers.

At the least, the opening block comment in llist.h should be updated
to include del_entry in the locking table.

I would be more comfortable with a solution that works in alignment with
the current llist API, but if others are fine with this solution, then I
won't object strenuously.

(And to be clear, I agree that there is a bug in set_doit() that needs
to be addressed quickly -- it's the specific fix that I'm queasy about).


>>> Suggested-by: Jeff Layton <jlayton@kernel.org>
>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>> ---
>>>    include/linux/llist.h | 36 ++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 36 insertions(+)
>>>
>>> diff --git a/include/linux/llist.h b/include/linux/llist.h
>>> index 2c982ff7475a..fe6be21897d9 100644
>>> --- a/include/linux/llist.h
>>> +++ b/include/linux/llist.h
>>> @@ -253,6 +253,42 @@ static inline bool __llist_add(struct llist_node *new, struct llist_head *head)
>>>        return __llist_add_batch(new, new, head);
>>>    }
>>>
>>> +/**
>>> + * llist_del_entry - remove a particular entry from a lock-less list
>>> + * @head: head of the list to remove the entry from
>>> + * @entry: entry to be removed from the list
>>> + *
>>> + * Walk the list, find the given entry and remove it from the list.

The above sentence repeats the comments in the code and the code itself.
It visually obscures the next, much more important, sentence.


>>> + * The caller must ensure that nothing can race in and change the
>>> + * list while this is running.
>>> + *
>>> + * Returns true if the entry was found and removed.
>>> + */
>>> +static inline bool llist_del_entry(struct llist_head *head, struct llist_node *entry)
>>> +{
>>> +     struct llist_node *pos;
>>> +
>>> +     if (!head->first)
>>> +             return false;

if (llist_empty()) ?


>>> +
>>> +     /* Is it the first entry? */
>>> +     if (head->first == entry) {
>>> +             head->first = entry->next;
>>> +             entry->next = entry;
>>> +             return true;

llist_del_first() or even llist_del_first_this()

Basically I would avoid open-coding this logic and use the existing
helpers where possible. The new code doesn't provide memory release
semantics that would ensure the next access of the llist sees these
updates.


>>> +     }
>>> +
>>> +     /* Find it in the list */
>>> +     llist_for_each(head->first, pos) {
>>> +             if (pos->next == entry) {
>>> +                     pos->next = entry->next;
>>> +                     entry->next = entry;
>>> +                     return true;
>>> +             }
>>> +     }
>>> +     return false;
>>> +}
>>> +
>>>    /**
>>>     * llist_del_all - delete all entries from lock-less list
>>>     * @head:   the head of lock-less list to delete all entries
>>
>>
>> --
>> Chuck Lever
>>
> 


-- 
Chuck Lever

