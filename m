Return-Path: <linux-nfs+bounces-16694-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C864CC7E50D
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 18:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712FF3A60C5
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509491C84AB;
	Sun, 23 Nov 2025 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mUWDlcMc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yGgw2HUr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E634926ACB
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763918468; cv=fail; b=XwvP9UedcVu1t0ABwFkPOOgzaC+0N9xf1mZMxsfAPU7YskDw51tXmtHBsT7FUYJQvEekHAzUeC8yJGRNdzd2kh5b44d8SygrIQGEMFAHZERZjocdpVC69tCtuweix9JqAqm0cG06zbnlQJDP98WX5m12ze6aDwqf1xZGVg5sfe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763918468; c=relaxed/simple;
	bh=ClcccQqCFcg+/pvdI0l/iKBFikrqICalm02KypKfFSg=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XzBX2w0j5GaF6g8hc5RZOsjhsz20yhi3qzPV46cHSz5cNW8r15+m+rC4RRtR3LCKhs6uL7dfq1t47iNA3k794gaXn0AsRwEiJZ3tlmdGjM1zjhZyClw05gWvd8sjCxnPDoBiUaLSkm8amgbDsUkiownwemFRxjOVf3w+vGS+gWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mUWDlcMc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yGgw2HUr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ANFTuM43239455;
	Sun, 23 Nov 2025 17:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WCoxzjBAU9no+6Haf62TwS0irR2P3LqCqUKa7txfHk0=; b=
	mUWDlcMcxPAveW8uAQLYeu8qTI+eJo2i3yqpPpQ3yMqWIWK7ORnayelEiYPtNU/s
	uNjpC6zAVg2kkkL6mAlH1T1owy77ZI80G5xrsPWQ+h1/1zt5JkRsBVNwCexvI8tF
	7LTNtU1zxt+XMBz+xjcirrs9V1EzZLTLlKrilfrKNPL+2RkAlchhlnPq1YzQPWVH
	6GnmQFfiBrmkdnJ/qeJ0cgh33yEGPEuK2ZWooe8/jRiZ3tzH8+Iv2YXMe9IyjuWG
	cGjH2YqaGBLb8LDme3gX3kqnojPlwoR8TKtO5CEVVT6FXKxR5b8+7HpzY+KYx2ZE
	1L7gMOKmCSfK0nGYeoXjbQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7xd0xem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Nov 2025 17:20:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ANDea9n022521;
	Sun, 23 Nov 2025 17:20:50 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mhaxys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Nov 2025 17:20:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0tkfqqViBeYlu7n2JNjgbsWUvg7XIWdjXW5S1xDLQi0BZgrbutXcXVSuNcRyGYkvwIih6Z7zHttyWVWr3Sb8fv1w8AzjiYb0BU+K+Q+FlSeeQRz+tYWHSVJ3hAaLP5QdOuzjBMgAGUPEZFlnDcR5JdlWLVjx2oTdM/0aWrkM4Y13Y5lq48F7fgA80IH/fJtcGtHOsKn07ZNQBUFpC9zLvdUrvOwsZUWmgFPzNAJI5tpNeFsuLoKfB9cbKHvnwx61QHSYeH0bGT2zOEkNtgRh7rU76G7KhQ7O6E0wTn7sylzZlVW+523OZQd5rf3O3LZZMEY1Mhi5kloMg7bgudu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCoxzjBAU9no+6Haf62TwS0irR2P3LqCqUKa7txfHk0=;
 b=TQ1NY/8ld/A0hF9lf7TEKJG284RSyEIAjDJ+fDfu/ApI3uAxsFz76cnovsiGDJ128M6CZfRYb7irkxooRKIwNEyeqkty+jHSTv0Wvb5IZ97QaU3Cb6ivUXui9MbphiUy5Vn2iDabusf9g0l4+h8qjFeZibzUZfMC0O8CknG1gEGZIm94f1xtzMPInpTcvM9nGHgxPdxa50voeurQMjhKTEuk0Vrue36gbmzVfxESs9zkV/u0hqn2lpkVt3ehwR4qKkJI7duksRoVarR/7Co4ANCHiFK0DbXX3HdoUXnqjGr/IGcPXTCAj79ajOMPz4DQ+WA56chUqrKd7E3Zb4jsgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCoxzjBAU9no+6Haf62TwS0irR2P3LqCqUKa7txfHk0=;
 b=yGgw2HUrV6DbznnH49tKB5zxSFyVgJx/+a3j7utEDuDvTWCuXMfnWDFAx70iErKDiAU1dPJaesRbJeUvktgelGYSb6RW3TwSLzDdGX52r4qx3bLGewj7WGQ1iQBdWvbhSqO/3ljV50WtR6qj1BN2A2ZV1EQesVA2NaFziKuQ41w=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by MN2PR10MB4301.namprd10.prod.outlook.com (2603:10b6:208:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Sun, 23 Nov
 2025 17:20:47 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%6]) with mapi id 15.20.9343.016; Sun, 23 Nov 2025
 17:20:47 +0000
Message-ID: <d8986867-a10e-4354-810e-8adedd114fde@oracle.com>
Date: Sun, 23 Nov 2025 17:20:44 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 00/10] pynfs tests for setting ACL+MODE
To: Chuck Lever <cel@kernel.org>
References: <20251123155623.514129-1-cel@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <20251123155623.514129-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::24) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|MN2PR10MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 83225bda-76db-4020-ce14-08de2ab4a3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkFEOE14WU41UmNJQU5tK1JLTGJINkJwbWRMUmxDbkVUcFN2cUZQeGtTR2tx?=
 =?utf-8?B?WEtJeU9Dbnd0RmU3dDVmazNNaXR3bWhRcnpuQ3FKSDRFcFhlQ0JHMVdQbjM3?=
 =?utf-8?B?RGxNZVpNeTZNc0dSUGE4dWJvSS91RGN0dHk4eWhzbzFBQkNWS0ZzZk5aRDRv?=
 =?utf-8?B?RnBMdTZKZXR6NmdLNnN4YWI3QWMvS1pLc1hIdmpORVM4K3JST09PbjY1R1dn?=
 =?utf-8?B?Z1g1OVc2dEVBeStIaW9rNVdUaWRGQ1pIT2RlRTAyb1Q4QWcrREJacTNpM3J6?=
 =?utf-8?B?Tlg5UjdMWW1CWktsMHIyQzVaT002U282RDYwa1FueWIxUzV1eEg3VStJeFhF?=
 =?utf-8?B?VGZlRk52Z1IyTEo0TDZWdXZib3pjU1dtMDNPNXE0ZVhrU0pKM2dBUXh3SUo4?=
 =?utf-8?B?MjBkL2h2YW93TEMvbmlHZjdnWkZtWlJEL0dJUzkrYTRKMUhIUUVNOXdTM3hF?=
 =?utf-8?B?S2RpNnpSSldvQWNOam1KZnVkaFVUbUJzZFlVSW9EdGdFaHhMejBwK0dYZ1NP?=
 =?utf-8?B?aXNWa3NpeHdSbjNsOWtjNUdibE92WUluOWxGMktQbDdhUnZ5b3JEbDAwVzBJ?=
 =?utf-8?B?L3lNYmQ4a3RlalU1UGhYVmU4WHluTXlYN0NqVjh3Qmdrd2pQbXFRZ2hvQzFY?=
 =?utf-8?B?MnFpS1VzTmtwNWcyTnZlN3oxYVE3Nkh5cEFacEJGTDBzRHZuOTJwdVM0WlFH?=
 =?utf-8?B?SERIbDg5TEs4Ym51V01ZNGZodmo3T1l4ckJPa1g1eGlYQTcvUENyOXpPUlNt?=
 =?utf-8?B?NGlhbmVGczlvNHBGbGY4WklzL0U4ZDBFRWZXdFlBbk01dWYzNzRMSW45bkh5?=
 =?utf-8?B?U08rNFllVnpJZ1NtQzdWb1I3Q3dscmdkelBUVTY5S1ovS3lVZmRjT3dsZWs0?=
 =?utf-8?B?eSt0SUFYQkpXeis1bTBmTXp0UENJZ3IzWXl1R0lCSEErT2ZCRFIrMkc0UTNX?=
 =?utf-8?B?QkpHcG4wcERGMlhmczFEZXo0MlNGUDkrKzl1V2NoWTJEZHlBSHprck4ydlVV?=
 =?utf-8?B?TkdPVVJHcVJyWDlHajZ4b1lhTHB1dVdsVSs2LytDa2hLVVgrVTRaSElDV0xN?=
 =?utf-8?B?RCtnR3hZVjkwTmdRcTdPNG9WekxpcVprWFpxaVJNS002Y1B4R0ZOeXYxa3VJ?=
 =?utf-8?B?QTgvVXR5cTdSQnFiWWU0N0dWejhwbWk5aEVQMFU5NTJmcW81MDZQSVRIQzJF?=
 =?utf-8?B?YXpiMW91Rk5lZ3NoczNsSG5GSHpET2lBOC9hWG9ueTRBTmJZRVhmdWpQOERq?=
 =?utf-8?B?czBZaTl0TnMwMFZ5M1VodTdLMXhkZXJpSDBVVjRmWWZXalJDdkN5Mnc5YmIv?=
 =?utf-8?B?dEVxdjljaWs1Vkh1aGI2OUVvK2VieEdPN0EvNWJieUh5ZUZObmJMZ0h5U1Ir?=
 =?utf-8?B?UDUwTzd5UWt2d3Njb1JhSjFZSWZFaVpmd1YwNVBmUWR6dUo1UGIzV09haldT?=
 =?utf-8?B?cmNtWjhrZFJZMmhJWVVhZ2hEY1lOYmQ2V0xLUGR1Um5NSldEeEFXNkJHZ3RU?=
 =?utf-8?B?SFhrL3oyTDlLNGM4b0lPVHVGejJ3SGs3T2tqdEM4NVlFa3FrZFlNMlYvNDNH?=
 =?utf-8?B?NWc3RTFVNnBnTUdMaXZFeHJhUGhnb1BIUGt2dC9hU3ovMkIvYVpERWxaWUlI?=
 =?utf-8?B?L2hWeFFhMERxdWJJdDlRS2ZyQ2d4K29FcjBmM1NFZHZBbVUzY3hHRkhNMy9E?=
 =?utf-8?B?b0dNSy8zV2p5bzZUWktGcC9wbWY1dGl1emtQUitETjN6UXRiUVVrVVQwOGhO?=
 =?utf-8?B?eHNTc3R2YkRROTlYV2VvVU9QbU5aVTNTTlNkNnVYdnljWUV5N01leC9pN3NV?=
 =?utf-8?B?WndZSExWZW5VbXE3c2VSejFNUGk1REZKaHpTU0FTM0kvU0lYTjBYSW1WMHFD?=
 =?utf-8?B?LzR2OWFCdU8zUzIwYjZ2MDh1WHJQQnJ1U2ZiZzBkMk9FMmpxYnBqcVcxZzMw?=
 =?utf-8?Q?dSwT1kKeI9WEJ5HOTfIQVSXgA9rLJ3Kx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3F0R1JqZnZWSkhvUGM4cGgraXFzbjBRcys3Ym9WVm9pM3VPVVR0ZnBLbjJC?=
 =?utf-8?B?YkhPVGRHUGFJUmVtYXZkTEpMREJGTHlWKzFuV0xaQWtGcDF1NmtjM1RIT000?=
 =?utf-8?B?em5SZGNGbmJORGZvdnprOUtLWnJtUFNXQUFWQ2pXSG9EdHFMaElKQldZcGVh?=
 =?utf-8?B?T1pYZ3MyQThweHRHUDBQOWltZnErV2N4Sm56aUQ4Q25TRkV6K1ZnaER5MnhK?=
 =?utf-8?B?N0x0NU04SDhXNFFIVkRmZFRyVDdqK1NmbjdONTkweVpCTXd1dVN3ZTlMeDJ5?=
 =?utf-8?B?d1NNaTBQOXR1YlpIQjgwQzh5Z25kK3JwR0xXVTg4L2UwSnJrZ1VUcUVqUUNx?=
 =?utf-8?B?YTR5THBzSWhDSG9McVFHRzlEUmJ1UVRFbkhEVTVnNkp6eVlNenQrN2xlalA3?=
 =?utf-8?B?d1Rpd243b3d4bUFIM1E1Y0t6U3NBWnpEa2QyZUViWCtrMnNIZ2xKNHBReGta?=
 =?utf-8?B?aDVQR2xkRU8vbFBnRmZycmZhYUdDWlZiOTh0dElKM2M1c0JCUE1lL2JXTDZW?=
 =?utf-8?B?MWRDaW95eFRRdE85MGVwUVNtOG9JbEdCa2ZGMFZBckFmc0s2SEQrd216Ylk4?=
 =?utf-8?B?YkZDRFlGdXhlTXAvTFFoTzZrdDgzMm5Kc3pzeDZyZG1IM3d6aGQ5VFZsZ25m?=
 =?utf-8?B?S2J1eGhtQW1lYVRjS2NvRyttcit5T2g0eTRFUHMrUDVEemwyM0xHY0VSWGtP?=
 =?utf-8?B?ODlUL3FWSDVPL3dJUWRWc3ZwWUNNZGthVUlMejJQa3hWUWRMbzE3eUVvK0Za?=
 =?utf-8?B?Z2pMY3dJM2NUUGVyVVpXTHJGcjN6Yk8wVnBvMUgrbUVZV1pQYlZMWE8wVjlF?=
 =?utf-8?B?OTl6USsyQ1dYZ0lhbWdURkxPUlE1cEFjbjJUWmxTSiszU1Y0SW1aL0V6OFF4?=
 =?utf-8?B?dnkxSHQwY1pXSzdCaEd3U3RhR0JTaXdOYnhESGQ3MUM4Nks3U0hGSDBwaGRU?=
 =?utf-8?B?SExxVWhrQ1NRVlkxbEdpYnh6TUpGdjZPR3NpRGV4QzBiZGtnVWlLS1hoejJD?=
 =?utf-8?B?OFJWYmVkVE1XZzdmNDhRdVg2SXdqUW5ydTBocFgya1MydVNSZW5UZWdaQzJY?=
 =?utf-8?B?aEpYMUVWZlR3ZlBHVUprOVhlZUdFWHZtVnREbmg3SlUxM3cyU2JEODdNcy9O?=
 =?utf-8?B?SWE4eXBxYktxc1QrR3JvbXVGZngxb3ZvOE11Vlh6NWVSd3JXYzU4cGJFSk0r?=
 =?utf-8?B?STFMVUpKMEx1cjlFK25kSXlQSmhMck9aTTJuZ0psUmdnbjBDZThxWm4zMlNi?=
 =?utf-8?B?V3RIbTRWbDdHaEZJeU9HZWtWT0NTRTFlVjl6UXJLUnFZZ1Y2MU9NM2VSNjJG?=
 =?utf-8?B?bjZ4eFVxOE1QMmtJZno2Wk1lN0RNV1ZEVGx4UlU3TFNhN3gxak9rUTZRUzFv?=
 =?utf-8?B?R0xzejhlZjdLSjM2b0R3UUpwb01XSmc1dVZxUHlCMDNlK0V3NE5XdVZzL2xz?=
 =?utf-8?B?VHVES2xMOFZaSGozakhEV25xL0c4eDhrNDBKQXFqNDFXUWpEM2Z5Ty9taGQz?=
 =?utf-8?B?STJITGFmcktNYU1pTmRXUjZIVzdibi9hRno2QmVkaGNMSTRQQmtsbCtkWUJi?=
 =?utf-8?B?Q09SUW4vUEJaVG4zc1NHekF3b3JGNUl2QlRnZ3RVNzQ5bzJYMlMyaWNJdDVx?=
 =?utf-8?B?RHd4dWJLN2djMVZKenVNKzlZRlZEd2dYTzR1ZUlXTmdaQnRYaEtycjJTZ1Rm?=
 =?utf-8?B?ODhNU1Mvc1B4OWJkZy95K0tDZ1VJNE5BMEJyVng5OFd1dmY0azNXTUhpb3Jl?=
 =?utf-8?B?MFg5c0hQc0lPaGJCcmtFYVgvOHhXSFo2MnU4VVFjY3pacXdFVXpJZWtKenBo?=
 =?utf-8?B?bk12U3JhL0xDRWJJditmbHBUQU55YktUaDBYTzdnem14YTdPbXRjMmYzWWJr?=
 =?utf-8?B?dVFSeit6ai9PVk9BWUlVNm1jeG9obG90WXY3Vk85TWRLK25aNFE2LzJMRGJL?=
 =?utf-8?B?dWt1MFU0OVVJL2xTMjBrTWZycmltQW8yNDAwcFE3QlpxcHgrTy9RQjBiNEFx?=
 =?utf-8?B?RlFiNTUyRFVydWprUEt6dzU5NkhyZUxaZ1l1ZVAzaTU5a0xpRTE3RDVYSVFs?=
 =?utf-8?B?NE0wSWpNR29mYjB1cTJXQWtUSG5ESmxxL3B2d0VQTVdIdEpUK3RRUks4NHk1?=
 =?utf-8?Q?4RzqgKb5oFVmTHDFoXWz8zYv0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CTcULhUR6vZb+hvEjaHguZDprzrw+2U7GewN4K/OhxOaPQiIIkwpV/jOiqlREZFWh7sYrg1I9ByXzPEv1pP6tWXoshRo0/WMSu/HFiTfXJlsCsD6Cgp4EcxFvWZQaypTy2V1tGfvP8uOoKTrOFr4/EmlgvC2BwM3uPGLKrHaSoug4Ez133X5xeUCnn9QtF/EdgWxO0Jxu18wTJngdoI1AYo3SZHRCBGwCYF6Wrsv+DlnuxMc8O5F5b0IVYKJSVWrIy5TR3u2D3MS+MVAgz/L9sqPp0rNB8gQgAU2rkKjxrQMCrz5EcxwBtQQQZsL9wI1tzmi37Q5lXvlyY6myA37fUcwJTsggmHeeTqHGS6+8msWvQ0oOpu6T/+gJCFfBQ8OwNHPUa3oAFZlioh826ysaYJIsVg6/R7EN7CbLpfLNKMOcPKTkhtgujQHSRjRNW788i/CqAxqgkcg1KIeXtSsWGki/6He7qeepIHSWPMBpnERtuDJvewolkSwMy977ITCQQNI9vjIQY8d1n/8fjAkbxNDVNeXjg69BI0ckvcoXY9/hTjqJ67YJfefr9Vkq5QnyfMPmdn5mqSq1hHJxbkbyFvxPYuwbsl08prIXOvnkSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83225bda-76db-4020-ce14-08de2ab4a3fe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 17:20:47.4348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnX2egCH1JKM4YU2vNDAw0rlbLS5Cvz22MOt4Lj/UCP/ULKYyv1iXXB7QX8cDrB1HztfYSbcDdQG3i6UOSxnMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-23_06,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=853 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511230156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIzMDE1NyBTYWx0ZWRfX2L75EI7RYm/v
 0k7lgH+3di9gHWX62tQlOT2bu5UojMApDDhYq65Y9nD8xnzhuOTV3085B8pN5/ilW+M4x3sMsqy
 ooFQF7Hn3RP0EvYoxUs2dYub4wJgsZpbg3r1a3g77kssVQNCZLCd6NfpBS3Wu5ZwpVgfQNHTduw
 NNNjCZplPXdAx2xzpj6v+NNFfzo/bkygaeXX/Z6zWr31fNjJABmGFgns636n9QrK5fS3pPxY/2g
 ig71SZYqnqWFcApyN1Gb0ZBo4u1OSvwHsDewDtlZOv/O5gxCtouJzYikWsO///kGsDqhuraGTvD
 fCM3RysLHs6wiDk77hUBwBq3uyAQivOvTT+luABz6dISJLV+jrwWi5Cj3bFpQ7xZwRJ7Ms3dCMi
 FiQakNz4+U6Iv9dl7qljkBuaWI7+sKANp7yO2kE1QjuZmhWzPLQ=
X-Proofpoint-ORIG-GUID: V0BfXLzZLWlL0_R0nd_Z32y9uXdHfcoh
X-Proofpoint-GUID: V0BfXLzZLWlL0_R0nd_Z32y9uXdHfcoh
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=69234273 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=WonYcQLPIkF3GsrAv5UA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13642

On 23/11/2025 3:56 pm, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> There are plenty of corner cases when an NFSv4 client requests
> setting an NFSv4 ACL and POSIX mode bits in the a single SETATTR
> request. It's even worse for NFS server implementations that have
> to translate NFSv4 ACLs to POSIX ACLs.
> 
> Note that the in-kernel Linux NFS client itself does not support
> NFSv4 ACLs since Linux is a POSIX ACL ecosystem. I believe it will
> never send an OPEN(create) or SETATTR that sets an NFSv4 ACL and
> mode bits simultaneously, relying on only user space tooling to set
> the ACL. So we must depend on pynfs for testing this server feature.
> 
> pynfs didn't have many tests in this particular category when I set
> out to troubleshoot a recently reported ACL+MODE bug in NFSD. So
> I've written a handful to exercise this specific case.
> 
> These are RFC, so Calum, let's hold off on applying these until
> they've had some review.

Noted, and thanks again Chuck.

cheers,
c.

> 
> Chuck Lever (10):
>    Add helper to report unsupported protocol features
>    Add helper to format ACE access masks
>    Add helper to format attribute bitmaps
>    Add a helper to compute POSIX mode bits from NFSv4 ACLs
>    Add make_test_acl() helper to nfs4acl modules
>    Add access_mask_to_str() helper to nfs4.0/nfs4acl.py
>    Add verify_acl() helper to nfs4acl modules
>    Add verify_mode_and_acl() helper to nfs4acl modules
>    Add tests for SETATTR with MODE and ACL
>    Add tests for OPEN(create) with ACLs
> 
>   nfs4.0/nfs4acl.py                   | 180 ++++++
>   nfs4.0/servertests/st_setattr.py    | 844 +++++++++++++++++++++++++++-
>   nfs4.1/nfs4acl.py                   | 188 +++++++
>   nfs4.1/nfs4lib.py                   |  69 +++
>   nfs4.1/server41tests/environment.py |   3 +
>   nfs4.1/server41tests/st_open.py     | 723 +++++++++++++++++++++++-
>   6 files changed, 2003 insertions(+), 4 deletions(-)
>   create mode 100644 nfs4.1/nfs4acl.py
> 



