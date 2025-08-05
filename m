Return-Path: <linux-nfs+bounces-13433-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F991B1B7C4
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 17:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3BE3A275E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816927F015;
	Tue,  5 Aug 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CfRbtTOI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AUapOisu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038127FB12
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408812; cv=fail; b=V1U2p83gKRVlh8VrahegEVnP+fZlg6cAoFd9T9QKLmGI9K2LXZj7pLhpzjAEpsyaf/HZp6bNmPMMK/4UwasAvp2z7wBg84oUZpfmrQef0qR2qd+L+XrPXlRnXv4SHoGjFFoDCyGynFobliGeIMr2bI5S+ZZ3qigUVdpnHHC5/yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408812; c=relaxed/simple;
	bh=1EzWbqeO2ckGaje1n8M2kf0T+NvV5lLOVmrWMAaq1vU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eARW639poOn7jfm1coMsetkYmsZeaNAjJuoyZtPGpEhRvjmGri6UPr/PIyfskpAqGdRBlDPZskNkh4Oha+chNtGIk/5bzi3x0Eszfyd839sakIqXyxNtKplZUp8VbF/UYNJqEiq3OhewifTilN3rb70Y/fapqAlVvr08vFY5Z3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CfRbtTOI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AUapOisu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575EpSVb022356;
	Tue, 5 Aug 2025 15:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yoQCf+52R6EYMkKs5vkRtupcJ31hgdVFepZmXRAEvHE=; b=
	CfRbtTOIDQxWnRtMMr8lZ7+OIM8W1p8vJ0v9f8aVHZad5snCgBOQg8EeW1ieQQxc
	NFCE0WvNlPubosa4ILgMhZ57rftlLZss2nRqpb1cmjFe3s/3p1kC3mDayawOpsis
	QNByTf+Suq45J1+EseVTgHx0MajMvoWLsfzVzPKhs2Zk/hrDhCeuvrMn9vOzdV2F
	h2CidG2wHI+2iH3QlTLD3Auhn69rAtDD6MncrSF8H6ZLw/U6kG7wDm7/N2MNMRMg
	qcnFwTQPgVkQj3ozpEaNmJGl2CvzrKlBXAcACiq3XaRaMEvdAu0R529452DE2cUd
	FIr9M3t7hRHJYDhDC3vxKA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489a9vw1wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 15:46:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575EkRkH006485;
	Tue, 5 Aug 2025 15:46:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48a7jtvesw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 15:46:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6w2/BM9QSgaN8xtyqccW1wSr0wpSTJgNPWxFREaEnD4xc/J+F3lg571a6l5OB7MslYPB+bhPCPUYzf90QX5JU9Z9M+Yt8oN0d9vG4kl+vmLdvcwIFDueJ1vbTPph3Q38jI0NN4ehTqgKcZ8Qk4DLI6Ox/o13gyHfWMvVtrUst4UI9we9tdTXYAFab4R7lxXxwCMwaequY+IjvnpvPcNnDJ91udturYSJlnfXdqO4g2aI+Qnz+kHjX06Kcy6nXAp9aov1X3iL0x4LsSlnIXqx0fi5brLiBY7moJBxDccc9LsLl/oEI3MI5xxxFG0qwUP+esye7Y5EFg9h4RImLNifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoQCf+52R6EYMkKs5vkRtupcJ31hgdVFepZmXRAEvHE=;
 b=TATmdevo0Q6BCnpaqITgqccOeA+fDUcdimZdY8mGybY9MFVZIXQl6Gd1ZfQ5u2crTDlHEPxwfZynxxPrx4E4+WWuMnXYEQGetio2fDB8Q2N5dUutdErlatWKwS1TULUQ7cQim8qWBUQFTus0BfhgNQOAWT5tRUVF6lAHO2G6FDG7i5loUjnU6uSg7K0z6CMbiXLR/l7jjBgnI2osJI1AvDQOAaNtnP5GsB0e8MUiY1W6SvzcT66xbGz3Dz5HYsd7RGRK8w1NHC1ghUGXxsFGEIvu4++9imA7ZHvpX+ZhLUXmgNpir6gHda2FwnW76EqjMRaRctT432XEmGFLzfZu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoQCf+52R6EYMkKs5vkRtupcJ31hgdVFepZmXRAEvHE=;
 b=AUapOisuqTGkUAn3sxWYqC+nNmKVv/xz9nYPWBkkvRkuPdOnO36aBPky5jb2J8/6xl3nTXIaymRs/FpcewqP0URgY2ufBkwVo1DLQsoRWHQFpBzGx4aO5wc3JHzdXrz0h3vWPW91FvOICvlj85fbmMXXzcAJxniReLd2DcrA4vE=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS7PR10MB7192.namprd10.prod.outlook.com (2603:10b6:8:ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 15:46:41 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 15:46:41 +0000
Message-ID: <de62d42e-5e85-45d5-825b-369938a4a24c@oracle.com>
Date: Tue, 5 Aug 2025 08:46:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] SUNRPC: call_connect_status needs to destroy
 transport on ETIMEDOUT before retry
To: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <1754334505-65027-1-git-send-email-dai.ngo@oracle.com>
 <48287a80e639d61eb507175ceb44d216e8032510.camel@kernel.org>
 <72e387a8-b800-431b-89c3-0104fbfe6273@oracle.com>
 <23fbff6b80f0c7c4b963f214c4c1e5d7b31c1d23.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <23fbff6b80f0c7c4b963f214c4c1e5d7b31c1d23.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:510:23c::16) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS7PR10MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 40dde391-408d-44ed-3718-08ddd4374596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3Q5TFF5KzRVSzdnNm5XWGI0OHp1RUM1NG42dTJGbVI1MGlFOW5hclFrVldX?=
 =?utf-8?B?cG5jaUIzYkRiMnFRWkpGdVlRYk5ZTTdGaHdJaFR5QlNUSVN4QWdBakFjTnJH?=
 =?utf-8?B?cndHNFo3QkFHY2NYUzBGamVha2ZvT0tTVTVJbnVoLzlmb3Zzc0E2cm5JZ1R6?=
 =?utf-8?B?R1JNdlAvNW5OSStCcmR5bmpUcFRLamNMckpRclprRCtzb3NmU0hyamo0L3Jh?=
 =?utf-8?B?azZ3UTU3Yk5rb0pGc2JHdGh6c291K2lsQU5laCtFblZvTnNqN1UySE1QMStP?=
 =?utf-8?B?cXZvSHB2Q2c1SWh4bml2ZDB3cExUY1NSS0N3c1YzMDMwZkw2UDVwMTdhdGlD?=
 =?utf-8?B?d0dBYTZJNFNIT1dEc0dBN0d1cmpwaGVKMVoyajZCdXdodXk3Y2dxSTBRc0JO?=
 =?utf-8?B?T1ovTks5NlpsZ2Rwb2pIZVh3VEF6VkZRcW44bHVtbTZWYzFSNWtCOWhkUlZ0?=
 =?utf-8?B?Rlp1Nld6MjJrVExVbUFXWUpFQTQxZ0tWM1FKRVNjTm9EVjBLUXp5V2VqMDRD?=
 =?utf-8?B?bkdhT2VLWi9zcXp3NEp3akFaY25INzRjN2cxbVcrZHVHZzdXaTFqQnZHTmlS?=
 =?utf-8?B?RmE1UW1FcmlxTC9sZTFOQzZTM3JIT29wU1lYaGx0dG0wdmZpcXBvMGNRanJC?=
 =?utf-8?B?MFZMc1FYUXllRXdkM3BSL1QxUjRkQWlxRTRuUnFBUTR6a1M0TkxVRU9RTS9l?=
 =?utf-8?B?bi9YeWlWNnRBZWdNaE9sRXJPSHJXMkVEM0cxSHlCWm05VmJuWks1N21kdE94?=
 =?utf-8?B?Nkhla2NweXAwRFpuRG54WGQ1UDBRVjBXbFJNeE9kMFNDZTAwNFFLRXB6UTJ1?=
 =?utf-8?B?RTJzbEgxV0ZXY0RHU25lNUd6bE9sNUx4ekJ4UEhPNjkvdFFWUXQ3bzlIRmx6?=
 =?utf-8?B?NThXcXJoM1MyV0F2b2pieVF0QlZ6ZDJMZkxRa25OQkhublNDQ1FNZjB1aGZh?=
 =?utf-8?B?NVNqMExLRFBDWEswSXNXaUdWaEMyTXdGbEtqNXJMekZqNjRDbWJtZi9GMnVQ?=
 =?utf-8?B?TWI2VVIwbEZuWmFBU0Z0YzlRdlR4TVNOemdobkFISTVHbm5DR01tUzZSVXFN?=
 =?utf-8?B?ZU9RM2ZvYmUyL3hRYy9MM2Nkek1OaUhTN0FTQmpqQlFBSlQwM3NVdjdhYTcx?=
 =?utf-8?B?NHRycisrRXA4YVJjMzEyem5kTnA1RFVGWGJKbmVyVUlnTC9tZEpGdVdJaXVq?=
 =?utf-8?B?eTdnQktWZVR1RElyUkNzUGVPNndkNlVySWkzM2J5WE1zUUw2TmxvVExqRXZX?=
 =?utf-8?B?cWY1VC9xd0pPNzZFWjZwazFNOFB0VUVLUFZjRGV3RGFCWUticW5rbHJldUpr?=
 =?utf-8?B?cHg4R1RKRklnOFRNcUhmcTVIdW1DSXJlV0M2NitCMHdKUHR3WGlsN2tMT29P?=
 =?utf-8?B?MkVoUEhUTWJpMWpQcDNmQUJTMHRPQzF5MS9LTUNCYVFGQXlmWjNvNVorRytx?=
 =?utf-8?B?OUV5SC96eE5aUWJxNHVYMHhRbjNySDV6UExZRW56cVRJK3M2NmJLaFc2UlBy?=
 =?utf-8?B?QVo4QmpMcml6L2M4QVpCdXVqZWRRNGZxaks1Wlh4VUc3SVUvT1VrMXpaSkVl?=
 =?utf-8?B?UzJRR0svaFV5NFczN2dOYjkzWXZNanlwN0o5ZW1scWdyQmJNUm5TT3pqaWht?=
 =?utf-8?B?ZTNGUU1BZ2dwU1dXdzdnYno0bm9DdnpRTXdEbEpJZGJoMGxJeExJbFdYcFl1?=
 =?utf-8?B?N0pBUHlPZVQrN3pUakcyRUMzbWYvdTRJQUpwR3UyWFRYVkQxT0UxSkhmREtX?=
 =?utf-8?B?NGVXdUhxU014RWE5UFJXM3E1UXowaEFDTGIxK25FakV3cks3NzhTWStvZjY1?=
 =?utf-8?B?TTZSdlVxZlp0dmx6a1Bjd0Y3cldja25rL3ZucnlNSStMbitoUWRwRWtLSytO?=
 =?utf-8?B?U1VFcjdzamRxM1NEU0M2S1R3cDRudXU3ZzRmTms3RGpmL3FzWTRqQ1ZuanB5?=
 =?utf-8?Q?5cAzk4YGq3U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVlwMVh3T3pKVURDQlBnQnR2RkM5UExkOU5IRk56RGljZTZuZGJjdnlWNStq?=
 =?utf-8?B?QWpLeXIxUUppa2ZxaWF3Tk9iS0thRTFVbUUra3pQZkpuVWhId1kydW9vYTZF?=
 =?utf-8?B?Nlcyd1h4Tm9KcnluQk05WU9GZmh1S1Irc0pwRndDSWJkdGhSRVBHbnN4bnJt?=
 =?utf-8?B?WnZaWFZmd2xOeFM0cDh2OU9CK0VpVHk4cnIzN1ZqZFUxWjZ2MGVNZVdrSHYr?=
 =?utf-8?B?ZU5BZVVybEV5cjZQRkV0L2JYU2Zpcit0VTF5eDB1T1lrUEFtcWJmSzVvcm1M?=
 =?utf-8?B?TUE2QjFXeVFYc04va2dtR0R4Y3RaTS9ZOHFQSDVYRmR2ZHY4czZ5Qm5zNlc4?=
 =?utf-8?B?R3E1K1RiRUtJVTZEZ0ZweWFUTE5Famgrb3JBYms0U1Z4UHlrTEFSOEdnSEhm?=
 =?utf-8?B?Z1F2cTh4RDAwamF5d3ZTQ0RrOThlQ1NTQnBDWDExSjR1U2Y5ajBFSkJFYmJK?=
 =?utf-8?B?WlFQTXpoZnhQSjEwMytBQTRrSlowWHMwUWFXMTIvZUdlSDJjcVRQcjJhMWhr?=
 =?utf-8?B?aE5MQ1B5UXh0K3EvdGRGeVRNOTUvQ3JVRUFnMzU1c2NMNjR1UFVOcG5iK01L?=
 =?utf-8?B?QmpzTnEwTHRaZzROK21pRERuc0hFdU02czJiNUVaWGlDV0R5MEJuaDZDOGY0?=
 =?utf-8?B?ZS9WMzErZUFyMlFKNmlJWTdLR2RFQmczNGNHNnlHWjNvSXNXRE9ycWZzNjF1?=
 =?utf-8?B?N3lxbXVXMEVhK2t3S3dwNmtUSXpzanpJcXc0TTg5aVFIWC82c1A0UXB4WlZn?=
 =?utf-8?B?SEhXNzJTeU50M1BNZ0ozV1RxdmtIa2F6Wmp5MHFpam4xck1VYUZad3N6VHB5?=
 =?utf-8?B?dGpUQ1JRL3VHNnVNa0J2M3ByeE5OTjFCd2dXQm14dFZlbFB4K1JxQThHM21K?=
 =?utf-8?B?NWxUa1BSSlJVOEFRcU1JcTJEdU0rVTNJN0RWTXQ5ci9sWFBMR2VEZDRFSE1s?=
 =?utf-8?B?SHF5OUE5TjZJMURia3BnOXNSYk9TMEF5Y3BEZnVBZEtwWGttZGdJWmVFdEpp?=
 =?utf-8?B?YzRIUFkwbU5ZcUtWcytFU2ZvQ2JZUmFyWlJWNjdGY0d2OUF2ZXZqWTEvam1S?=
 =?utf-8?B?T0NUbGd0aWVwWWw5aEpCRWdqTmhTZDJ5UEJUSDRCVC9pS2FPL1hsWFFiejN6?=
 =?utf-8?B?RHhvZ2NCQUdjTlNSMnpvcWc0S1RiRXhRa09UQnQrTkFXTHVseU1WaWNTYmxB?=
 =?utf-8?B?enZlZXRNYmpBekhRRzVDeit1WlY3YXljV1QrdkJrR1Q5S1gxOWM4R1hkeXlS?=
 =?utf-8?B?MEwwMGNJK3pCSklXQjI3WTE1S1FWTjhZbTBaQ1ZCYWliRVZCclhHK2NvUDRV?=
 =?utf-8?B?VEZmQk5oNDVWVHhnYnIrczI0cENsdTFSbDl2N1RaMWtFNS9XdGJHNjEyTXM3?=
 =?utf-8?B?UkVMNnBJRFBJVm1ESk9Vekw1VzZQNEQ5ZklKbURONWZUSG1wblBzM1NiUGNo?=
 =?utf-8?B?dWgwZUxnYm9VQWxBcS96alRMSDZwWHhWVzFQMU50YjY2a1hNb2dzb3k3U2xr?=
 =?utf-8?B?elNwbTh6N1FPTWxyVnM0TUZDSDUzZmFmcytEOEU5bWpFblVRR25zMkJBYmpI?=
 =?utf-8?B?Yy9hOGtUSFA2NzMvb25YQU9yb0UwRmh2VFJSeitlNm4wV1RHdHVwcG43eTEv?=
 =?utf-8?B?N25YVWk0T1BJYVdzbDV1cWcwSnI2UEgwUVpYMnB4RSsyU1VUcXpjamlqUDJM?=
 =?utf-8?B?SUIrMEpVYnJwc3IzTDllREhCRjRkbVlYMzNteS9MS3cxOG1uUmlNZzE2VjBN?=
 =?utf-8?B?OFRBMlNUbXdnUGk3ZkdIOVQrTzdiaUUvL3Y2aXlqSkZZT25EbUlQR0ZVYndI?=
 =?utf-8?B?SzBiRWlXcVhWWmhhUDYxZEFTWWwzWnFCcWNrd0Z1SzY5c2FKVHRIaWJZR2lw?=
 =?utf-8?B?Q2lKUVpOeklxOW9JMXlza092ek5VcG1KSXJMbitIbzgvM1NWMHBqWUJPMTZ0?=
 =?utf-8?B?ZGJGM3FFTWt2cFdtVGxEa1I4N0tUUC9ZcmxGYkRDWWtJTWY2cTJnSjE1dFNK?=
 =?utf-8?B?d0doV0JvdzRDbmp5OHhsY09rY0tnSWVXY2dzZDRCOVhxTEp3K21qYXJ6ZjFP?=
 =?utf-8?B?MTNEczNyYnBUVEQ2OVVHK0VNVWMwcC8rVWhoTjdhQUNCOVdJWWNlcUd5VXdZ?=
 =?utf-8?Q?PeHJhESnnCOeLFVGZAKxz6tp5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cgXy+lLazqnk5BPq6NgsT/cOkETb0LnB95QErY/2fU1JsAkLQC7DLDyo3uyezHV4FVXH3gfbzf1DnQRnhxoFQeRBCYj64mPAM/unJTS7fWorsQGFMoyPmLTs8CeZariqcW9yRI49/SLQ+wLGiWf9FAoDsFM6wEmPYpwzYiYS6Hu47wu2AYfVp2Vuv+BKmbgdcqS7c2iKIQBIYd9Exm6Bp6Kfdr6GvOgSOfqjWH69d9y/8iRSbC51pMgQP2nzUV2HCWa1vrvJV/zsSCBC4ZHFxClBUDvODoYYoSWBPUsADM8vo1AT61f1YRh+tA8ZAykv+Guvjzd1/ZRyM/jyDi+TICGJLs+dDa/wyyQeLhwey3R1mnLHMK4N0nwxH6rTwD+uFBMQtSYIWeDVNnxhVwnwYOoQMMi2+yJ/WGzhCwGAJUgJKXN71I7dfAVdx3XZ4FJTVASVr71Rp2we7zB62NNQscM3g6SxD4Pd78uLJ5J21qkVnXVu9eJT5FzQXPlrIyO6+bCUSxuOdLFbd5scsn6kkfYklLkQPikK6Uv2rvErXUOZ0XS0TiuNpMfIFz5kd5AeMRSsoxdHzo9uuSt3HPfZRHpKV71wkY3AwHQM40+Q6tc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dde391-408d-44ed-3718-08ddd4374596
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 15:46:41.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sbYtjP5WFClenEIXPCDbySKGvXkKCUdm9IAOpIQWmLtbFAwZSHWfa3AebkVsnp+B2CLhg3/Umb3Fkso9J3w0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508050112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDExMiBTYWx0ZWRfX/20x2NWlzE+v
 v+UFcIR1Wo6vxn4HoVdWgTN7mJoTaMjXe/9FyrB35rfSJIu94MBG0zwWrsWzkBynAjyMr/+8c3X
 2+aYD9isQ/M6paXR95NLXK7kB/9WchPW8CCZjQ/tnUGBoyFJaODRZRHMIMatKo1pZi6SSsZHeLm
 RKmegXjZDifNxKkOnwKuIaOAhjkUht0J3SSHNIdAFG5G67zl/rj8Z655h+iAc6y0iUfM0BZeTul
 u4es75euWFoGkxDT4TpZwug/S1EeTidWVZCg9p79S89cX+O1MMV9o4ISYSVzFlHiU2lqHdXEPA6
 mf6faosv0WgOLBRbJ/tN+0v02NDW4vrQteDp1wNUxe1dv5XkeLXQYVNH6qTZLoCMYfrDjkyoea0
 +Zizqn+dBkF1GfnlvgafqR64V01hsUxO+wRHFLYCzy/Nn10SYAxDkxvCff9gSjA82XLlUeKt
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=68922766 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=9i4nDWCdOPhLfV6TPcIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=e10fF4DqEehlLX_lK1wm:22
X-Proofpoint-GUID: u2j3aABVOahBUftaNq9nVKJLhs9_9027
X-Proofpoint-ORIG-GUID: u2j3aABVOahBUftaNq9nVKJLhs9_9027


On 8/4/25 4:55 PM, Trond Myklebust wrote:
> On Mon, 2025-08-04 at 13:13 -0700, Dai Ngo wrote:
>> On 8/4/25 12:21 PM, Trond Myklebust wrote:
>>> On Mon, 2025-08-04 at 12:08 -0700, Dai Ngo wrote:
>>>> Currently, when an RPC connection times out during the connect
>>>> phase,
>>>> the task is retried by placing it back on the pending queue and
>>>> waiting
>>>> again. In some cases, the timeout occurs because TCP is unable to
>>>> send
>>>> the SYN packet. This situation most often arises on bare metal
>>>> systems
>>>> at boot time, when the NFS mount is attempted while the network
>>>> link
>>>> appears to be up but is not yet stable.
>>>>
>>>> This patch addresses the issue by updating call_connect_status to
>>>> destroy
>>>> the transport on ETIMEDOUT error before retrying the connection.
>>>> This
>>>> ensures that subsequent connection attempts use a fresh
>>>> transport,
>>>> reducing the likelihood of repeated failures due to lingering
>>>> network
>>>> issues.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    net/sunrpc/clnt.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>> index 21426c3049d3..701b742750c5 100644
>>>> --- a/net/sunrpc/clnt.c
>>>> +++ b/net/sunrpc/clnt.c
>>>> @@ -2215,6 +2215,7 @@ call_connect_status(struct rpc_task *task)
>>>>    	case -EHOSTUNREACH:
>>>>    	case -EPIPE:
>>>>    	case -EPROTO:
>>>> +	case -ETIMEDOUT:
>>>>    		xprt_conditional_disconnect(task->tk_rqstp-
>>>>> rq_xprt,
>>>>    					    task->tk_rqstp-
>>>>> rq_connect_cookie);
>>>>    		if (RPC_IS_SOFTCONN(task))
>>>> @@ -2225,7 +2226,6 @@ call_connect_status(struct rpc_task *task)
>>>>    	case -EADDRINUSE:
>>>>    	case -ENOTCONN:
>>>>    	case -EAGAIN:
>>>> -	case -ETIMEDOUT:
>>>>    		if (!(task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
>>>> &&
>>>>    		    (task->tk_flags & RPC_TASK_MOVEABLE) &&
>>>>    		    test_bit(XPRT_REMOVE, &xprt->state)) {
>>> Why is this needed? The ETIMEDOUT is supposed to be a task level
>>> error,
>>> not a connection level thing.
>> If TCP was not able to sent the SYN out on due to the transient error
>> with the link status and the task just turns around a wait again,
>> since
>> TCP does not retry the SYN, eventually systemd times out and stops
>> the
>> mount.
>>
>>
>> Below is the snippet from the system log with rpcdebug enabled:
>>
>>
>> Jun 20 10:23:01 qa-i360-odi03 kernel: i40e 0000:98:00.0 eth1: NIC
>> Link is Up, 10 Gbps Full Duplex, Flow Control: None
>> Jun 20 10:23:09 qa-i360-odi03 NetworkManager[1511]: <info>
>> [1750414989.6033] manager: startup complete
>>
>> ... <NFS mount starts>
>> Jun 20 10:23:09 qa-i360-odi03 systemd[1]: Mounting /odi...
>> ...
>> Jun 20 10:23:09 qa-i360-odi03 kernel: RPC:     1 added to queue
>> 0000000093f481cd "xprt_pending"
>> Jun 20 10:23:09 qa-i360-odi03 kernel: RPC:     1 setting alarm for
>> 60000 ms
>>
>> ... <link status down & up>
>> Jun 20 10:23:10 qa-i360-odi03 kernel: tg3 0000:04:00.0 em1: Link is
>> up at 1000 Mbps, full duplex
>> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
>> [1750414990.6359] device (em1): state change: disconnected -> prepare
>> (reason 'none', sys-iface-state: 'managed')
>> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
>> [1750414990.6361] device (em1): state change: prepare -> config
>> (reason 'none', sys-iface-state: 'managed')
>> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
>> [1750414990.6364] device (em1): state change: config -> ip-config
>> (reason 'none', sys-iface-state: 'managed')
>> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
>> [1750414990.6383] device (em1): Activation: successful, device
>> activated.
>>
>> ... <connect timed out>
>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 timeout
>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 __rpc_wake_up_task
>> (now 4294742016)
>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 disabling timer
>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 removed from queue
>> 0000000093f481cd "xprt_pending"
>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 call_connect_status
>> (status -110)
>>
>> ... <wait again>
>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 sleep_on(queue
>> "xprt_pending" time 4294742016)
>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 added to queue
>> 0000000093f481cd "xprt_pending"
>>
>> ... <systemd timed out>
>> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mounting timed
>> out. Terminating.
>>
>> Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 got signal
>> Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 __rpc_wake_up_task
>> (now 4294770229)
>> Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 disabling timer
>> Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 removed from queue
>> 0000000093f481cd "xprt_pending"
>>
>> Jun 20 10:24:39 qa-i360-odi03 kernel: <-- nfs4_try_mount() = -512
>> [error]
>> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mount process
>> exited, code=killed status=15
>> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Failed with
>> result 'timeout'.
>>
>> This patch forces TCP to send the SYN on ETIMEDOUT error.
>>
> Something is very wrong here...
>
> If this patch is correct, and the call to xprt_conditional_disconnect()
> does indeed cause the socket to close, then something must have bumped
> xprt->connect_cookie.

I'm a little confused here, xprt_conditional_disconnect only closes the
socket if the connect cookie is still the same:

         if (cookie != xprt->connect_cookie)
                 goto out;

So in this case the xprt->connect_cookie has not been bumped.

-Dai

>   The only things that can do that are the state
> changes recorded in xs_tcp_state_change(),
> xs_sock_reset_connection_flags(), or xprt_autoclose().
>
> If it was xs_tcp_state_change() that bumped xprt->connect_cookie, then
> either we're in TCP_ESTABLISHED (in which case triggering a close on
> ETIMEDOUT is just wrong), or we're in the TCP_CLOSE state, in which
> case autoclose should already be scheduled.
> If xs_sock_reset_connection_flags() got called, then the socket is in
> the process of being closed.
> Ditto if xprt_autoclose() got called.
>
> So why do we need the call to xprt_conditional_disconnect()?
>

