Return-Path: <linux-nfs+bounces-10869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D686A70AF1
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 21:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E043716E17E
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 20:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BF1265CC3;
	Tue, 25 Mar 2025 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e2urempV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PThH7wTZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72535265CB9
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933003; cv=fail; b=cfILOgOOEjriEOdzKdAZ8qSsdK4wZSR7lVuP30zuoLn1TAhhX9KW4dGHgex5vQ+sXV1RMyS0/+Z3F9rcrocjih9MZzQ03yjhNAm+2XK54e+5xv/tq/OJZm+NmdIe+h1IOuNolKquPg57YxxoR0XWviQjLnHvTrbq9TQiD5KqsFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933003; c=relaxed/simple;
	bh=gBWHBP0Z/38NvD0RaBdBqn6oIyATgBPR08Y58/Ereow=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ggSeZU2EwjLU4dyT4B1jJI6skfx8o6E4Dz/cjCGiQ2LI2Wn8BRZ+4/RymOut3ebddeDMrIRBesUDHmeUI23xd0OS7hXwX3XBcLBe1FLza/t6d/QWOK/uEM7GjNTBMAfLcFTb7rgcL/H+KeoqD6D2q4TQmU1+coDnFNY9cobocR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e2urempV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PThH7wTZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PJXo0e022514;
	Tue, 25 Mar 2025 20:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Y4B3m7m2DRRfZYUNbs0nQfEvQZhbIzkIuapyL5/9G6Q=; b=
	e2urempV4lOKP5PvIqsvoBts/Uho+ud/HibGMi8GoRSV2ZvA2/KivztA6FFOtGui
	c78Oeo+qDBiPJCCe3TMVZKGWaQCxrusjSU5S1R3AN714373J0fDHkjhLSPSevaTy
	XwYTmVpq2PSb4yYgd+q0i+2ysecQPay0A6vk9XmLS8svR25SquEy4M8kMNwOu9CZ
	c/xf21s2uzEfeigSRXZRn4I59SlbYuCR+ih0nSYnJJKh0tt1EqLXHI3nrOUsHncP
	YAAJLQ4gJKT1SxZQmoF7g+UMJPRBtD0Y1aP2Bi6h60CRASR9KhbSNx8EtRbKhlSk
	qk4G7qKANtEPp5MRPmQNAw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn9c01wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 20:03:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PJW7NC015098;
	Tue, 25 Mar 2025 20:03:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj92e9br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 20:03:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJwMtJURa822tPsrWyTPKRXBenQFI3jqzeLGMBpy3bXBoK+FtxdXYra1Yuhp3EhksFC8K/V8RFpjpveTXOft/yMYebEQGE8pD2w/TzULEG4fZdecQ+5e8J0f4dm0+KAymsRgwGfQXJT+NxCP5Q9evzdQKV4gzKoruj0rFYja+YR3yWgdyh39vaHxL9aIhzNtByN9TXu4PdZo872Nr0zq7/IWrUjTllElKm7wY1M8t2uPEdAlVwfnn9R5FGLIzneUEFv8hABGakNqz1B23HGKJHwkewZ8eb5/IwVpic4/8WWkwtkJ2kCFAiwOi9JD5uLtwz/cDEsbWJwoKEMnSIk0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4B3m7m2DRRfZYUNbs0nQfEvQZhbIzkIuapyL5/9G6Q=;
 b=Ian+tiUeWPuHyBoc4rflc74iXIplwaMOo6awbH7nIV06Q6bDTw/r1cFtM93lcyxZxkK85Q7Tx0pwgqEcQnLtgaO01xgMzy8PmEYCvVJYA2IQeMBIFSgXhOSNlQ2nAvcZB5rVeo+9r6urqudA+HUTLcJUyGkpMB02Lkz+dauWtFgpBCd+1J6hF2qZWPWa7g9pDu2hf5q7kbovXn+YYxbBZ8FctepZI5sKrZy6D1pDezikemABqaRgiFS630bcFp0fOvevARtZeNdMtLKYK0rvopFYnqRUvaJuYhdfEceaNTMnZzEhT+yhLtNBXG90qryO+Rb52p5meDRBmHs+gSuPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4B3m7m2DRRfZYUNbs0nQfEvQZhbIzkIuapyL5/9G6Q=;
 b=PThH7wTZqYJg2OyHLwGTIzO+OZDD+4GNi17G+G78G9KePr3EcKDVC/wZy2WQYF1M+wit7gSbYISobN/CUMF+99bEA7wq4TmN02MrZRdPU5Q7hjAMbs1k6sSi5WF/JqIodmqyRWNH4uFiZdBeOaFVciak4htJQ4xT3gN+K7a0AEc=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by PH0PR10MB7008.namprd10.prod.outlook.com (2603:10b6:510:287::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 20:03:16 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 20:03:16 +0000
Message-ID: <9324cfc2-4a74-4577-bcfd-704ffd25240d@oracle.com>
Date: Tue, 25 Mar 2025 20:03:13 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>
Subject: Re: pynfs tests for NFSv4.1 OPENATTR / O_XATTR?
To: Martin Wege <martin.l.wege@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CANH4o6NoWzPikoEtbVN1esw9d5KDgfOfds1iLfpUNeFcXzaA2w@mail.gmail.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <CANH4o6NoWzPikoEtbVN1esw9d5KDgfOfds1iLfpUNeFcXzaA2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::6) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|PH0PR10MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 442e3e0d-e0bb-4547-6293-08dd6bd8146d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk00ajRVend1NjZUbWtZY1FIcklBaEthQUJld21uNWN6SVJuZ0pZN3FMN0JH?=
 =?utf-8?B?QU1lY3NLc2NiOG1WazBNbjIwc2RaNUk5c3VaSWUwWXdvb1I1blpVU2hvcG5w?=
 =?utf-8?B?VU1DbEdzbmdPWGYwRXhvTDBrYXpTY0I4MXlQWXZXeWVUclhXcHlxMGE5c2Jz?=
 =?utf-8?B?eW5ERGt4aWVTS0oyY0R0R21mU2NwZ1JIRlAyZXN6SnZ2WVRJSU15V1d2SVJj?=
 =?utf-8?B?d043N0RUSXpsYTI3N3dxVHRZK0QveTBXT29oNmRITzVIOVlFekpldm1lK0RE?=
 =?utf-8?B?RmVyOGVnbERPRlhsS3J0dVNja3ljZFRrbFdpOXF3RTV5ZFVCcUJ3NjFKS3pN?=
 =?utf-8?B?aVpMd2xaZUxVb1BxckgrUWM3c2FqNHJ0VHJHVHJUYVRYNGZwMVV3cHFmV0Vx?=
 =?utf-8?B?eGFsUjRXWkZkNUtWaTMyQlBkODJObURDMDljSTlHN2tLK1k2L2UrK2pobThv?=
 =?utf-8?B?KzlYbS9pb3Z3K0ZPeEZoYzhFK2VqcmtwQ3o0R1hzV3R4ZHYza3oyRTNFKzFZ?=
 =?utf-8?B?VUlzNGxtZ1ZpNkQ5ZmZYVEhNVHRzYnRJN0pIWVdyMS83ZXlhbTZWR2d2RXV2?=
 =?utf-8?B?Z3RlNUFqMTd5SS92SDlITmhvbEpWR25Dei9MNU5vOHNnSFpFelhUVHdwYnl1?=
 =?utf-8?B?RHlVZitoazd4ejcxc1dUTzFnZFIzZ2R5aFlKelZqRXZyOVdITU5NU3AvZHhQ?=
 =?utf-8?B?cWFBdnV3TWdtYUZ3aHZtSnBGdi9VTGoybi96RTk5M21vdm9uVVhLYTVSYngz?=
 =?utf-8?B?MDNuVDVjNVV3alJsSHpqVnJFdGtvRjA0WlordWxPWFZ2azlhamU5M1Jyc1hJ?=
 =?utf-8?B?TTF5UG9MWUFGNVRTVmZUbWgxZ0pkcTgwUzZmL3dOZXdONG5LWTdadVY2dmV5?=
 =?utf-8?B?RWJabXNkQmU4ZC92bVVJSEVTend5aXp0c25xMVloLzY1WE9ZMVZ5M2RFZGtM?=
 =?utf-8?B?Tm9RbE05dC9UR1lPbVZid1d1T0NlbHJldXd6UEU0Q1hucVZwcW5yUUZzN2V4?=
 =?utf-8?B?QUlOaGNYcUVHNis2V2NUOWhJY3ozeXlERkRmeG1WTDQ1RXNHVHRuM0crN1JN?=
 =?utf-8?B?dFNQOFlSM0MybS9SdXZtYmZnb1dBUUtyRzRCYXZJQ2MxNWZqOUoxdVhJSVNh?=
 =?utf-8?B?K2o3ckJGbERVU0pZYTlIbnFsNExvaGh3YmszbFp0OXA4OEtONEtPZldyblN0?=
 =?utf-8?B?QzJ4KzhsVWIvdExjSjBwc1k0Yno1UnNMMUgrelIwZmt6RmVGcUpIN0RGNWxk?=
 =?utf-8?B?WCtKNWJtM2ZnZ2ZSZEdTakk5S0hiRldqQ2IycHFsc1Bwell6dmpCcjloOU5s?=
 =?utf-8?B?Wmk1Tk9OOE1FUkRKRk1ycWVzdWdJSitkSzZRc0xhSGJELy9vUGNocS9WSVJB?=
 =?utf-8?B?aW5YeFVxamtxQ1dTTXpCblJvc3RuWHJpblEwU3luTmZqaGk4c1EvWGFuM3hk?=
 =?utf-8?B?UGppVnVMVWJ5ak5jK0k4MHk0N1RJUmxweGRCdkNHRDU5MFFmT0ZsQlUyRVgv?=
 =?utf-8?B?akk5R2xGMjQyeHpyT2NsTkRzWkd2aEw2YkFuaXczUm83czM2SlI5Z0ZsalU1?=
 =?utf-8?B?K1VjRE5Dc2dRT1VMR2Q3SGxoOWNuZElNRXlwckRGRkU1UGtJU0EzWDNDTlc1?=
 =?utf-8?B?bXN6MzV3c3ZiWkVzZE53amtGT2FWY2F3d1RUWTAra3JWWE1IbHBBQjkzZkpm?=
 =?utf-8?B?dHpsWGxlK0ZvMllobGNQQStPWit5MEZHekFSWmZmWmt6YW5GS3QvL21tTjBs?=
 =?utf-8?Q?QG+dl9W8lpQNUD4yDC7UeDFeFC8Csfey04GlJVq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnBUaUFkbHVpSDFWWUZ1dGdVRDRyaGI5NmFDaVg2MDJKL2JzNGJUa1RqV0R0?=
 =?utf-8?B?TFdEdkNtbGRqL1M2REVtb3d0dzZPVDZEK1hrZ2tMQm9lSzE4TE9oUExUTkV2?=
 =?utf-8?B?S2N6aXlFTTRUVC9HQ2hDV3k5dGdKVTZnajdXSmVlQnI1U25OZUw1KytYVUVs?=
 =?utf-8?B?U1VGTTh5dURPWXJid0crdU5DcG91NEZEQkp3eHRkeFZqOFVxOWo5V2NWNHZY?=
 =?utf-8?B?Sy8xY24vZFBjMmkzWmUzdjhRcFkrdDhJcW5PMkV1MnBuRkM2VUpUU1FmdVdx?=
 =?utf-8?B?VTgydDZGN0Fhb1Q3QktaTjVibERLWUsvOVN4RmdjSDRUR21MQXJMQlJmRUlo?=
 =?utf-8?B?MEhiSk1xT0JxdmMwRzYxUXdWK21uYnJFYTdaelBoYytsZXVwLzdaT1ZuZ3d6?=
 =?utf-8?B?VjlUWkVPV1NIU0hVS0ZvbzBvTENycXNNSWlKL0t4Y1VSelBza09MQWhNVnpV?=
 =?utf-8?B?ODllbTV0YjQzdDVJUmcvZUpEamJPa2pFTTNHbVI0blMrQ3AzYi9mN2tuN2Jt?=
 =?utf-8?B?alErYStvUUZ2UnRHL3RsOHREa2RKQW9yYmVCZ2VuV2JhLzEybEtlcUxlcHdM?=
 =?utf-8?B?QlJveXBFZUJpanE0SWJKK3FYeHFTcFRMMUVTWEZhNUVKVENsZDZiNE9aTDhq?=
 =?utf-8?B?WjhJbWQ1M3ppMW5sZFVrQnRHWVdQZVJYV0ptb0toK3ZqM3d3U3pjZ0x3TUQ0?=
 =?utf-8?B?alVmOXlvZTNDNnRGSW94T1JGSnZmRjZiRVpHZjNpYzNpUnc4eTk2R01nd1gy?=
 =?utf-8?B?bUJIdFVVZFV3MjlFN0RCM2lTRklCZE1xaE1SSDhER0Q1Q1MzQWhuUFFHclhk?=
 =?utf-8?B?bzNkOVU2OVBCdXdoVko2Qi8xRTM1aGpGSFIzbkZzOTJELzh0aGhXcjdzYUx0?=
 =?utf-8?B?dXF1MXk3cGExazM1cDlBTTYyY21POU5pTFI1L1RSK04xLzJxWGpKMndjem4v?=
 =?utf-8?B?ZTRoVTVpMUhFMlRQY2dmMVBWclMwUkNyTGcrSkM0WU1OclJzZ1lVeUVRYTA4?=
 =?utf-8?B?QjFXSUVtWm50a0kzY3luUUI3ay81emxwZkJnd2pYaWhUbXNER0ZtQkliVUh0?=
 =?utf-8?B?US9UaEhNZUh0RnpsY1pjakhmT1BvSHZVSXp1djA0N3NlV3FsMVpSSTc4NStX?=
 =?utf-8?B?amR3RThqdEpxRUljV2ppWHE4bmd0Y1JscFoxL3FidnRtb1FiZFY2cW1QQWNa?=
 =?utf-8?B?VDJNTHpKbkd3YkRjK1RTTDZOUXBtSnBRaVdBc3BNRE1IN2lxd3BpRHZZTW1t?=
 =?utf-8?B?cnlTdVgzbysvc2RYdVZ4cWNwMEhucEhiQktOZUJqcnEwdldGdWYyUzJ0NFZ2?=
 =?utf-8?B?R09adGFYdGxYNjNieFhwTlQyRXZVeXYyL01PY2NUVzNQc1hTbTZaazJnUTI2?=
 =?utf-8?B?UFprS1crd2tSWjZqV3h3b2VrZjFNYW1xUzhuNHdjV0prSjIweGZBYVcrdGls?=
 =?utf-8?B?a1Q1em5aS251RjUxZCtOZDJFNEdNQi8waWkrdnl0R2VOb3B1NzlnTXRBb3Mz?=
 =?utf-8?B?amY5cHdLK0ptY0txQTFtc3Z0NnBsV1ZBdlZpS1BkVUFYVE9wSXNCeEhyMHVG?=
 =?utf-8?B?ZFNrVFhzQU8vemZCNDUxeHJva1pNZldkNE5OZ2R2MjZzN0JYQlpabmg4bEk5?=
 =?utf-8?B?b0h4TGRwVGlWRktOK0xMaEozV1NiZlBjQWt3M3Y2bEVFenNnb0hDaTVCOEQ4?=
 =?utf-8?B?MWtmTUdYaWFwVUhERWJnOEczd2ZnREVDM3djUWhOcUNtTXBWSm1wRU5Wenpx?=
 =?utf-8?B?VWxoUkx0UzRyZzlMQXRhVGd1S2R1eHEvNGdJSXBpSUZFbGFnQ09JN21YMG02?=
 =?utf-8?B?ZStqNGZwSUF6VURqV2lXaUF6TXVvc3hRS0dScm42QkNuT1hSaEdweEdjbnpw?=
 =?utf-8?B?VmtRNUg5YW1IK1BmaEU0d1FpME0wWEdENU02eklrRDVrbXpKY3BYbnVueFdv?=
 =?utf-8?B?TUNTMVVxd1BnR2NFb2dPOXAwWG4wY2xGVUJhenZweWVGR0RUVEcxQjIzbS9W?=
 =?utf-8?B?bU9zTHljczJkNHp2ZWJrTk83RUtWaTBtWVdLWFJheExEbWp6UEIxamlsQzRh?=
 =?utf-8?B?YjkrYnZ0OWlaMHJsWnBuZVVzRVY4S3huMG54V2I0RzQ0QTZtdDBPRUo0VEI2?=
 =?utf-8?Q?FFLxnC2Zv42HwucLNa/D+U0d5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9vOg7lMF+B9fuszZpSLn1VClttWVQKVrhgyZwW1bGT4Yoi7iOrGSJUVqacmKn4lYgpyM5CjdfPQEdtV75qtn5z2mbr37lzQeeC54xwkMJjWR0udt+tw3tZPagpydn3qcCw32yCRpkAde32YDAiFg9keqb82tZx3Cy3C4WUcl8VK9YINg1UFTzybLBX3HnBzo2M89KHq9CIh3is3jLEu8GMSbdskp4n3Oazv4elGXjCZEUVF3lHeXYs0M3uZZyL+R8Zt5lfgg1Fkaz1aRLriKN6OtnGsnObDaEfQO6SNojvhwy4IulAjAbozi5kDhJF6NduOfOCB0Q1YXnZSLn7VYFS0xCsVSs3g9i/Cgv6vYRFXp32Sp4gjAnGSN1L5ymJATg47sfEW1hDpTni+6sr6SzMdYwFi7sis60Z96FC8zytAKPJiSn9f/fVxbHcOM5T3F+DpuWwPHaBdUAyGeomGGQh9PdKl0UKNQe4yombGb7OJbgZ9JpDS2iVO8aWmnN23qu/eD/1WzDb0IogYyyMi2toJYD+VaZ7/HEmX7zjSr7Ak09hhD0V09vNd30FCoiakSZnl7xW51/LzrUC4mGuUdaQXDXjmaEqWnPuBN6W0aB1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442e3e0d-e0bb-4547-6293-08dd6bd8146d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 20:03:16.0018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/PMBLRu+Ur+vjOT09wDk7vxp64LsWDRnTRYgAvFsTuI/XjQUG3Tt/hY4xWSsoYE0EcyxuqzfOMnpjZM6w37WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_08,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=997 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250135
X-Proofpoint-GUID: yD95hkAzlIFvbXM41r_Bv9uTy9H2AKuC
X-Proofpoint-ORIG-GUID: yD95hkAzlIFvbXM41r_Bv9uTy9H2AKuC

hi Martin,

On 24/03/2025 2:29 pm, Martin Wege wrote:
> Hello!
> 
> Does pynfs have tests for NFSv4.1 OPENATTR / O_XATTR?

Yes, have a look at the "xattr" flag, the XATT1–XATT12 tests, and:

	https://git.linux-nfs.org/?p=cdmackay/pynfs.git;a=blob;f=nfs4.1/server41tests/st_xattr.py

cheers,
calum.


