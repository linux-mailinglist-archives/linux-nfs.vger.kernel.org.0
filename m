Return-Path: <linux-nfs+bounces-10475-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FE7A50149
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 15:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAFB18819BF
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 14:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129DF24BC0B;
	Wed,  5 Mar 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IQyTTf2o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UDcwQDwR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E5E24BBF5;
	Wed,  5 Mar 2025 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183407; cv=fail; b=cuJUk0Wg0U3dvl2+AaZtfxhALReInGXuPMn2w+AjQ/IEu3MoNN0PMW2n59LMyw1Zc09eNSdHFa4lWNRshuOO1ixKKLJSWxhZjZ9qfvjkeqsv4o4Was/zeWUsgzfWbTriaS3wjEyNBd05ALyIlsakduj1xQJwIkNFz+5WhLemY3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183407; c=relaxed/simple;
	bh=ff09s8oMXmbnhYXhcPgHAP5bQNhDmNQsA3TvvQ0n+XY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=omyAQbD0QY3AC6VxmNyZBWAqvhl3yOV5zGcyfUlvUQdZPS+ZCRSlRhG/uIJJiD+VeDnhlw5HOQf16jCP8Of79fys01S6X+mA5fOuM4ny+L7ly6K2dYm9IT9LY3niDojUr80+uox8tqimh/g9Y9SW2dRvm4Td1TO0B67A1kFBStk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IQyTTf2o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UDcwQDwR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525C3wTI021603;
	Wed, 5 Mar 2025 14:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NYpuKpFT2YH949OuyFPCj6j5RK8Ic2e+giAEBsmNnMs=; b=
	IQyTTf2oHd5WieuzQZLGOM7yEyhdJnWVH4Lkv6FNJxdLmn6agwnVuupBfIjyFuuS
	5Kr5b2WPkIw01jp79RH+9meS7aNhJSqksS2Zs0DMyYqq/WrgOJ5C0YofY9lwg4XN
	MIPkBk2CqIpuWkm+2ukHlTwY+3W1MGB0OHXlSIoUSb4cqoRkG90N9nM0U/aOlNVh
	LryVihkCl5qVuOyFo3Iw2Jj4oAo68qiDv6FtYMSvyErWsH8Aea8dfgDCRBNN8LqU
	mKu3IFLrLo+YCFp6ULRXrlLV2wO76UreUpJORAFtPzx0E9NNGy2141z2Lk0O2Y5T
	+RVyuv2zzbGgOCQ3k4tE8g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u81ypja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:02:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525C7uEa040417;
	Wed, 5 Mar 2025 14:02:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpgq7d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:02:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9B+1pCRrNchuMM0BP/PPR3rY43mjZNKAcx1how4v+g6GNH79fP6bIzzoqPBJQ0BZJo8XHIELDXXtTi+8SEN1ayXjvm4wAG2gGFIN+jUOoVYfxswFodOmMlCcz1ZtWBYc7YWNq3RPPbHfenUkEaeG91aZnF1zyEmzr0kC//qJ2r3MWUt+S7zipvfmPnbHa9N01bzRZJEfSTuCcb0qhVOMCWKYEy5C/yhC6baMD7QnHjIUVO171f3syE74oZR5pdniUlXJT+5+h5tbEAFCRpia+jqwSQ/1nYTmuCJzgHo8Ll4SIV2hSiYE/rVgwV/m3bXRljpRfRX2sXtqmtVZZydxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYpuKpFT2YH949OuyFPCj6j5RK8Ic2e+giAEBsmNnMs=;
 b=kT0BVGz8/gvMy+nFkdiXJL7UnvJiXHtVpCSg7ANknqEA6YOAwX0cyAHxnWpF3a5ayOP+Ux1LDHdQYW2CQIVLy/uz09eVoKqcjJvsrCm6VsubPPen6+X7nol5aR48Huw+r9yNQicpw45yHBhd3DULRqLuvFQyTYalDFJv9aR6SZozerGAmNX74igpVO6KDudJgM12cHJK3yzxZGJ6naaSlvFqhR3y1twVFXTI3WrbDizixEcbvXjGGFcE7CoGuVrC6bK+7s2cV81dlQSp90xG5c3ALMuMOO1dJ3faDJiYJttwYopQXRAt/Z1BR0yPmINvyKomJpeq0o+slwnftevHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYpuKpFT2YH949OuyFPCj6j5RK8Ic2e+giAEBsmNnMs=;
 b=UDcwQDwRDQ8tTt0tvCEN1H9Tpy8PWLFU+s+HY6U/BHAVAxLqR/3Ki2uNYp91xHojvfqRoxVl3ex++71zS176B7QFe/sNLga8YUjZTTiCoc9h1x8Zd9iD3rhDtNnHmjjuSKUyY46MCJMRapd9OX1NtFvkCbrW5n9wsQ3eccf0uy0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7113.namprd10.prod.outlook.com (2603:10b6:208:3fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 14:02:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 14:02:45 +0000
Message-ID: <314f60a8-4b0d-45f9-87f4-5a4757d34aea@oracle.com>
Date: Wed, 5 Mar 2025 09:02:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] NULL pointer dereference in frwr_unmap_sync()
To: Li Nan <linan666@huaweicloud.com>, Dai Ngo <Dai.Ngo@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org, trondmy@hammerspace.com, sagi@grimberg.me,
        cel@kernel.org, "wanghai (M)" <wanghai38@huawei.com>,
        yanhaitao2@huawei.com, chengjike.cheng@huawei.com,
        dingming09@huawei.com
References: <e7c72dfc-ecbc-bd99-16f6-977afa642f18@huaweicloud.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e7c72dfc-ecbc-bd99-16f6-977afa642f18@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:610:b0::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1d5535-182f-487c-9da5-08dd5bee6771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTE5UnpRdkpzWEtmR2RxdG9rVjhnQ29WNE1sVzRIb3Z2T0pqN2svWEpwN0x5?=
 =?utf-8?B?ankwSjJDTkorSFI4T2MycGFEYUc5LytjWmczYWExZ3dLQll1Vk81dTF2RCs1?=
 =?utf-8?B?NlVjOW5ZclFPRzdlRnpvMmdBa0pid0h3ZjVjcWVIY0pCZzY0eFNKNy9mWk5x?=
 =?utf-8?B?bUx5RUM4ZzhyWDM0MGttK3RkWmhjcTVsK3NJRFR2bStXVjl0TzNEVGcrU3VK?=
 =?utf-8?B?VUhUUC9zQlZTZGNHak9nZ2NDOGtQTmZrZXdqK3RyTGNXWWdYaE9SYnFGYjEy?=
 =?utf-8?B?TUtwbDZLamV4Z3Q5cWtWSmNTTk96MjNhNnRvQmtvN0laR0Z0bGxrQVI0QjRC?=
 =?utf-8?B?SkltZ2psaU9ZVGlocjhUZ2NQVDhQL0FMWDF4WmR4bThHTlcxQlpWbmtpTXNr?=
 =?utf-8?B?OW83TFVtRm9IaGpRREdTQXh1ZnpPUUt2dzJLZDNiWXhnMUdrbktkUjdWR3BB?=
 =?utf-8?B?VmIzV3V1WTkwa3V4eU5wa0FoWml0aEZjVTRPZmtRSElLTTJFV0hiZDVpQlBj?=
 =?utf-8?B?RCt5K1FjNlUxZWtRQS9KVUJKSkx1UDB6SFBoYlN6VTlCdnVEeXlyQ2dtQktQ?=
 =?utf-8?B?MUg5TnI3c2NUbytSRGdrVWpUTVpHcEhvNk1jOHBBZy9DRUFObTJqbnY4eVc1?=
 =?utf-8?B?Z3dLZHlxTTRmUmNxMmQybDhtdXZyZTBwVWthYWIzeWZCNnAyeU84Z1FnTGpE?=
 =?utf-8?B?RXNOQko2UzdCMzlmMzFveS9jZnZFKzVVYlZ5M2Q1OUQxdVNheG9WbXlhY1lI?=
 =?utf-8?B?UmVHRVFIQVRGdWxKTWNhazZyemY0ZS9lS1RqZG9RZVM2VnVpd09lSHpjS0FI?=
 =?utf-8?B?a0FvVUdrS3I0alovZVc3MTZHbXBDV2YyOGJPa01aSlp0OTVTdTBjaWJjS01F?=
 =?utf-8?B?bG1FcE1ZWGZSVDZaRU9rNnRreFMwUGUzUXdiMUpKVHVqVWtGQ3pLYUtrc1dS?=
 =?utf-8?B?Q1UzU1lDMW4yMWdUbnJTVk5aQTNva1NqMmMrN2FtWHhFaHFpT01RSUlSMmpN?=
 =?utf-8?B?eDNJVllPMW42YU01VG5IR0dGS3YrMDdWYnd4NG9LQnJoS3hkSENMQm43bmF4?=
 =?utf-8?B?aEYxQjVkWjRWR0o1VCthNmhJdUs5bGswam1nQ1RrUGxhQUVtOElVbnl2MEZY?=
 =?utf-8?B?bkJTdUkzMCtFZDNmczBjVXBLWHpjcWhLWUVEMkdOQm84V2pvMUcySGxYVXVF?=
 =?utf-8?B?YTZSUXZxaFY2RlQ5VEpNWnhLNDM3ZGgyZEZMV3NDNisvTTZoSkdHUVAzcEMz?=
 =?utf-8?B?VzVvcU1WY09hWHBDNzNvU3QwUEpGdkJMWWdJRi9IZ3YxYjdyRDRYaHFOSTBo?=
 =?utf-8?B?ZHAyS2pVWHZ0ZEJFckx1VlhpRkx5cVBWb2Nta1BJc1F0NGRHMDA3SnRaa1g0?=
 =?utf-8?B?aVczaVkveUlHK0FVb2o5VlEyOENudEZYZGdBVHovTXp0KzliNHVVdUtwNjF4?=
 =?utf-8?B?eldEZ0c0SVpkK09GWXpLNWRFeG5sNEM1UkNpbEhwQWJuS28wZDgrdGI3NGJL?=
 =?utf-8?B?dElUd0xIREhuRXRxeG9ydjJPVWlSSGRzQ0tlUUpKYzF1cFNwYlQvM01EaWFx?=
 =?utf-8?B?TFczdDEzY3d3RkhsYmFNTngxRW4zTW43T3VTdGZDWm5xZTE2Qnk5Wk1vYmpm?=
 =?utf-8?B?ejJTdWxHQkx0czRiT0lGbEVKVGl0SGJmaFRSa3FQRlYyeEJGR0FuRE9BNFky?=
 =?utf-8?B?REF4YVJNcnNwK3l5TVo5RUZ0cGJlTWdqbnRIMVkwdTZ4Ykx1SU5QWndidmJt?=
 =?utf-8?B?NDVBYVJDS2ZsM3dpZU5VbHl3dFhsc0VuTFBqWUdnVzdpYUtjS2M4NWRTSW03?=
 =?utf-8?B?VXRhR2VLUkRrNW1DSlA4bG9PbDdHNzVlTXUwVjJVL3NzZCs3eDBKMU5GejJD?=
 =?utf-8?Q?JzCXCzl3eX9nb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3RGcUg5QU1JYS9rNG80SzlOVkJEeStLdk9rZWsrVGRyc2ZrN0gwR1U5S3JB?=
 =?utf-8?B?L2dNUWVKL2JwYXh4M3YvTW1qck5xWGlUNllTV3pESlIzckd4M2ZENHJySGpI?=
 =?utf-8?B?ckZCWWE1Y3FmNHE1MkFUUHBpMk9yRmZZZFhpaGRPK0dVMjhVUjJ0VWVMM0Jw?=
 =?utf-8?B?K2hJd0lmUTJhQmowYmRtV1FzK1FQWkpQZHl5R1NNRjI4Wks2dnRrR2E5aWJ1?=
 =?utf-8?B?ODVGMTl2a2J5ZlBPOUFZOFRCNVk3UnBWQkRoOTYzd25HeEFjUWNPdG5oMm45?=
 =?utf-8?B?RVUxWnlncWZvZ2l2VzUrWWZLelVKbDAxNFoxR2xEUmsvSHV4RUVvYlVsSmZS?=
 =?utf-8?B?emtaVTlCbzNRQXhzejJBUVM1Sld4N3plTlVWUmU5L2pzZWRGSWpGS0FISm0w?=
 =?utf-8?B?RkVxSXdWM3RpRmx1UWtPY0NjMjlIRFQ0Wm9ucUdyWnFtZWdMQnhSZ2NCd1hI?=
 =?utf-8?B?VUdGRXhudHcwdW5va2JnWGNJc0ZQdUpOQSsyRnRQazlWR3A3UHpZbzVrTGk3?=
 =?utf-8?B?QVgxdGRQRDFtSmRFQURzUzVUQ09jQkNBazhrbE9uMG8xN1BTVFgrd0xpbmIx?=
 =?utf-8?B?SUNNcmJhVzRIaVpUdUIvU1FleUcydGxuYzZ2QmtPN0xjU2FBdzN4SFR3ZC9j?=
 =?utf-8?B?UU5vOTFQKys3SmdqVm5KNjRaanVSK1RYS0R0Z1RrNFhNSGJjUW1XS3lDUmtY?=
 =?utf-8?B?MUI2N0pNUkdmUDQzTUdjRU0wS3NoSjIySmx2dFRCRldxWXcyTGh2VHZFOXgr?=
 =?utf-8?B?QlBjbHpOSXRGMEVWU09qNitwNDlMOFk3VVl5dVNUbVQrVE1jMjliaW9STHhE?=
 =?utf-8?B?dFVXL2hBZjlELy9NTEZaZ05oRHBQd1ZlUVF1SUYwUkVUT2Y3ajljVnJNcHV3?=
 =?utf-8?B?a2N0TWJML0IzaFRXeDg1SllNVEJyUGxEeHJiZ2RuVXlIbDlZMGo1eXRXZEx5?=
 =?utf-8?B?UVFGTXoyWVR5b2M5ZEJieWg1Rk9ndHNnbTNGTkJrNnBwQThWbEVxWjQxQ2NJ?=
 =?utf-8?B?VUVnbkEzUkVZWTBsTEpyczdUM045WTVUV3VlQWxsKzlIN2lNRHdFL1dnakhk?=
 =?utf-8?B?TjgyTkVTM2JwZ243R2FrSnF4eFFuSlJLSWtLdERrRnNRRDQ2MjdZSkJTTkd2?=
 =?utf-8?B?NUxoWnpKWTRuekpiNDRibjE3UHEwa2JKZE9iWE1FSGlSVUJwWjZHTUdFc3cv?=
 =?utf-8?B?WjA2VW4zaDFYb3daeDl3UElDRzM2aVNWZ2hMd25WVFlHcmUvVWQ1dUVpb1I2?=
 =?utf-8?B?TVY4M0FzYVB6Mi91eVFXNzdNU0RFMkd6a3JreS9ETldiQ1hMdzR1WjNsYlp4?=
 =?utf-8?B?ZWZ0Z2FmUUdwTzUwSnQrbU9DbkxhZElycUxMYjRWYUJBU0VGV3VkTzFTdzQ1?=
 =?utf-8?B?U1BiQmw0N3dVejVVOTMrc09YaXowcnY2L01qdFNYMHlsVEZ4enFqbzVUa1FO?=
 =?utf-8?B?WS9zb09xbXZONFExU2dmTENUNnptREsyYmpZS004czN4YUY3T0RkREx3Mm8w?=
 =?utf-8?B?eXlJdWxPTzV5c1VzelBnMFpnRzVDSm0rOE9VMDY0OGYvNDRtbVJjUktnam1M?=
 =?utf-8?B?TTNCQ1IvWjFLM1BlTHJCNVAvbENERDZQanlYSjJ5WWt2L2V4SW8yWFVYMlB5?=
 =?utf-8?B?ZGlDeGsvSDZaM1R5WlNBb21tUEtaQm9IQjY5MVJNV0VxNzVpREd6YmU5L3lO?=
 =?utf-8?B?bmdnMGVISWhjK2Uza3RtS055Y0d6cDFiQXJxaTJQc2tDZGpndlBTSGNhcnhQ?=
 =?utf-8?B?b2x0SW5ycU95R2dUNUlNWHNKNU11Mk8rNG5TVmI2bXl2S25XOUlwSGNRMysw?=
 =?utf-8?B?VGdOYTE3b1RkVmd3cWJZaTFtaFl0bVVueVI2QzIzdkMrcU9tU2pmTDl2MnhR?=
 =?utf-8?B?amdOdUFnUUs5Rm13Zm5qNmx1elIvQ3dSTExOcXZjMkJaeVlFWEJSVkEyMkdF?=
 =?utf-8?B?eTd2dVBlUmhCcktGTi91Z2ZsK3hBRnRGMzNqS3NXanVqTUE2eWpGWGMrNlFH?=
 =?utf-8?B?Mk5ya1FzZGQ2QlFjRDFyckdTRjBhTk9EQjhrR0pqL2NaWnVhbXJVYUlaRVVz?=
 =?utf-8?B?WDJxUmJpalJuNS9vNWw1Q1NzMTRXYVRVbGMrajFLc2p4RkpLZEkyRDY2aFBP?=
 =?utf-8?Q?CAEddiQlceOT3De9a6c8NotYk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i3rfDpgwYiW3093K/GxypNlvlyt556JCZxHskSU9PG4Y/ji9DvKBc+67wretik3LxHQlaUGoHdSxPjLHjUstEQbhkux5L6uprpg9SY/bjo9LKnBNrebTQgeNnKPocNrqWrsriGYg5cQ+xorgWoFPPYxYHtAzBH1+jSUVglKrQCCEs3Bn4TuMPk1yqZG2e95H+DBtQDizIyZuH+Rx4yfLmN2NsSIrvgthVhquZ3IzEVYsX2qmyFBw2Z2y8CDGv/hDlDEWYbWU7naVSQZflCawwGF6v3a+6p4n6IE8pkZSGlrXM+KrO1DcqNfCKAK5U7Y4oBpUi8txBg4WyRUBwDeMWiUVYISg9yQRynqZXd6sZQxFsWpsfO1QAvlnkAsJsJDWFFvChHWC7U58LbA7xvOEgSHyP1Br4pl6vflPrUuKlRKkhmsekVf88lmJ3pFCb8kQZD2gaQtwyUw9W3Z8m3TntvTMh3q9Snj6SMtdRm40RVljYq9h4RTP6BR0+xnvOJy5N4CBi+2aIupQX/JmcRHP2F5iEfn+mHVFNwtBj+EIdg7FbqPAJC6AU+ioYxRa3U7z6nC52C+E50ZXozVty6Joj+IrFmlhY6HZcNSkeRVN8Yk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1d5535-182f-487c-9da5-08dd5bee6771
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:02:45.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUEZQAqitfRyviKuVL9kk7EoLZz7B8cmZ1maMFq2KGZ26BZpjMESvuBko+k3IvrXbbLzfP8jtLLOIBs+VHrJMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_05,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050111
X-Proofpoint-GUID: 92-L8XLCzP6ZIiSmoTNvl-H1BuDKcYmZ
X-Proofpoint-ORIG-GUID: 92-L8XLCzP6ZIiSmoTNvl-H1BuDKcYmZ

On 3/4/25 9:43 PM, Li Nan wrote:
> We found a following problem in kernel 5.10, and the same problem should
> exist in mainline:
> 
> During NFS mount using 'soft' option over RoCE network, we observed kernel
> crash with below trace when network issues occur (congestion/disconnect):
>   nfs: server 10.10.253.211 not responding, timed out
>   BUG: kernel NULL pointer dereference, address: 00000000000000a0
>   RIP: 0010:frwr_unmap_sync+0x77/0x200 [rpcrdma]
>   Call Trace:
>    ? __die_body.cold+0x8/0xd
>    ? no_context+0x155/0x230
>    ? __bad_area_nosemaphore+0x52/0x1a0
>    ? exc_page_fault+0x2dc/0x550
>    ? asm_exc_page_fault+0x1e/0x30
>    ? frwr_unmap_sync+0x77/0x200 [rpcrdma]
>    xprt_release+0x9e/0x1a0 [sunrpc]
>    rpc_release_resources_task+0xe/0x50 [sunrpc]
>    rpc_release_task+0x19/0xa0 [sunrpc]
>    rpc_async_schedule+0x29/0x40 [sunrpc]
>    process_one_work+0x1b2/0x350
>    worker_thread+0x49/0x310
>    ? rescuer_thread+0x380/0x380
>    kthread+0xfb/0x140
> 
> Problem analysis:
> The crash happens in frwr_unmap_sync() when accessing req->rl_registered
> list, caused by either NULL pointer or accessing freed MR resources.
> There's a race condition between:
> T1
> __ib_process_cq
>  wc->wr_cqe->done (frwr_wc_localinv)
>   rpcrdma_flush_disconnect
>    rpcrdma_force_disconnect
>     xprt_force_disconnect
>      xprt_autoclose
>       xprt_rdma_close
>        rpcrdma_xprt_disconnect
>         rpcrdma_reqs_reset
>          frwr_reset
>           rpcrdma_mr_pop(&req->rl_registered)
> T2                   
> rpc_async_schedule
>  rpc_release_task
>   rpc_release_resources_task
>    xprt_release
>     xprt_rdma_free
>      frwr_unmap_sync
>       rpcrdma_mr_pop(&req->rl_registered)
>                    
> This problem also exists in function rpcrdma_mrs_destroy().
> 

Dai, is this the same as the system test problem you've been looking at?

-- 
Chuck Lever

