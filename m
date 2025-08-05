Return-Path: <linux-nfs+bounces-13430-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC328B1B6A6
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 16:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2759F7A3DE9
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB8E277CB8;
	Tue,  5 Aug 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qys3OMtP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gx9B4wEs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228A8273D99
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404618; cv=fail; b=sMhaL5ujKi81KveB7vATmru66lk0s+Woj6n3WNes8r7Q/i7nQbOtLsjr6WO60Vz4NxLp99ruY5a1rEQrJDQKa6MKAwxy5xRl/HbjeDUgk1kDBDxVqe5nHqusOE/lNPAXOT13eDKXu24OPjUo5oUWeXK3c20ArdnhQRab83Hh/28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404618; c=relaxed/simple;
	bh=RjkeOtevv2/6UsJA1sweJCAgdyUIYzlW/4hEO29moOM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gTHoU1oGcoBdGqr7/OqJrNfRXccdgPKq7xY6EqdBjSco9De0Em/LX2ycEl7czzt3ul8wAYSlSpKwdHPChOFxdQE0cWnKvXHkBKZxajbp/lo7XiwQwWLQxNNExq5h0wSBkESvUzcWBMp2NADoeXLOa5LhVaryiwnaby2C/Iaesu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qys3OMtP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gx9B4wEs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575EY1dw025910;
	Tue, 5 Aug 2025 14:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VYe9W8s/Wlkcrh2foE5mmuICTL5ZHKX4MnmbD4yi45A=; b=
	Qys3OMtPCOzfeLyGqvzcwDWhtVIIH3pGJ6ldOK3oI0RuSBP3WdDCAFrc/30v4pTn
	f297i99XSYmq6zdyA+g0pX6HyjKOJJqVRjDX4MFxWtDOOZq7BxlV25pdWv/oObz7
	fQ4ip4X5+Aqy8w3Ny+6wq5YfM4qaO0yIDkSB15d1JZIla9PkU9a3uHZl01mapTKg
	bOuWrQysBPTUzSYFVJ0/6wPuL06r/UdCKHfbQ5unJoBKT64kMy8s5TUEQlZdMaQn
	lVNIoXgzxR/8ax68FlAlLE620cRy/2jNUtGNcCIu9gIh2m7TJLyVGVXVOBYYIwpK
	n+WYMvZNvupMgnDPDkIfxg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489a9vvvap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 14:36:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575EVUlA029909;
	Tue, 5 Aug 2025 14:36:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7q226ep-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 14:36:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPWJF7tK8AdlJj3HSLhck598IupW/RytUa9mR5yMqC6XlRLgPi6ALM93yVNRTjPF0qJvS2121fvcWVY0X5ZPqtlQtm2BHFCKQUyKPYskL/apQk21rPpp5QyJv0H00yVYRrhgJF3uL8KJUNPERZDjbpwkrPNeAo+AykfuPJ1TJY0wmkj/vQIehlEpIwQS+MzghZ0N8f41OfC/GDBC1xt1aFN6jzk7YwrgrTrJo8tokFAt9kIPwZkYH3iPKNUaADC7Qxj3TXlgQZzy/uqa8edzlFB9DVkkCjRMO6nIzJpZQ/CDuxV+ahjomTt/gRv4KTWsZn5yd5qxO52NuGiDC3A85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYe9W8s/Wlkcrh2foE5mmuICTL5ZHKX4MnmbD4yi45A=;
 b=W6t7eHmhK9cF3F97VjHZxI/H6aF6WuS+nfZUwgkzxj6OF9/DN0aIS04VDS4/ZBzWFalauIZQmRq+/boj/ws2Hoy/4AL9h4q1yQ6kC7PcwJ8VjjmWa1rzF3XnYfaecJKDZK4pRNlAcYcr6ltLKjPshfMvTmC3nzLdzxaYUqC/Ci4nMMbu+41DgseFJ/hQa/DELeMz2NJ6UGXfqgP+0HJxdyfUvuHrrrwbyi/pDOpVCVaqLzsYXU/Ah5G8Y5NAsmTrbEfOkqNk38CZBXwicg4ihy/7CsabeoYMeGHDfO/HGG0lW2ryopxR6hXL3cZk2XSG2mS0TKSFcdxx7wBNGIbB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYe9W8s/Wlkcrh2foE5mmuICTL5ZHKX4MnmbD4yi45A=;
 b=Gx9B4wEs4MD/+upaLnyM1NsWZk1jX8ShTUwGHR88rKMUEgvr/518ltro62tfgzHTd3KBEfMpTUn1sSeVuupyxXzXvQBPnkCSniaxBgZp1BMQXLKj0uCe7KHXOsdl+tadpmNb8kqhWnk9o3LVTg4afLtNdbWZrAS3frI1w3UosKA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 14:36:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8989.017; Tue, 5 Aug 2025
 14:36:46 +0000
Message-ID: <ba8cc0ad-29f7-4064-8405-95f17ac46c64@oracle.com>
Date: Tue, 5 Aug 2025 10:36:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: decouple the xprtsec policy check from
 check_nfsd_access()
To: Scott Mayhew <smayhew@redhat.com>
Cc: jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
        Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
References: <20250731211441.1908508-1-smayhew@redhat.com>
 <3cd2b16e-d264-48e0-ba20-0c666d88d39c@oracle.com> <aJIV6I5MNYOU1YQC@aion>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aJIV6I5MNYOU1YQC@aion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:610:b1::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cf3a08-6647-44ca-4d65-08ddd42d810c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?emlIam83cElBaEVHTkFYc1pDR2RkcGQ3aE5aTnlVZElQSVU5N3dTdU0rb01B?=
 =?utf-8?B?WnBOSlIzQW5WVTRkL1piNFUzQ05rVnpkKzA0WFpyTGU2eS9NMzFzdElhUFN2?=
 =?utf-8?B?SUhOVGFla2hJSWplV2V1YXZLK2kvcjZLL2plUXNHenlDbHhBMzlnYkNsL3Zp?=
 =?utf-8?B?UHZBeWFLS3BUNnREUlpReHdCWnA4TXdXeEVMTVhFR0t1cUg4MkNsK2VTMHIy?=
 =?utf-8?B?bDM4SGZjMGg5OTR5dlhqSEZmMEwxd3ZXTHFpSUR3WlRLNGVyT1ZDZ3pITWVC?=
 =?utf-8?B?cllmcERuRGxaY1RWcWJmVGdXUU9NUHRHNG93U2l0VU5wdFZ6WVhYV3hNUC9L?=
 =?utf-8?B?M3VTQkc1YVNYVnNJNnIwZW5GcksyZHV6QXVMWFZzTmZQMTNDdkd5V1VKU1lm?=
 =?utf-8?B?MVBJcFBkZVIvV2pNREU5TmorQklMbDlHNHpxVlkzWWh2SXlWYXU0U2JwM2VU?=
 =?utf-8?B?bDN3Rk9aZ3pvOUFMUVM2cnA5V1g4QzQ3eEZVenZUdmV2RkxOa0ZrZVArTTNp?=
 =?utf-8?B?dGJPM0xFdURZa3EydERzR3ZWdnRwMVpPTzFSZWhHbFE2RTE1UlZzZ3YyZXc1?=
 =?utf-8?B?dmNEdzhHZTdQWjNsNWdML0dzNDBYbUgvZEVDSVpZVFdxaWpxdmVTK3pmRkVs?=
 =?utf-8?B?bTFyM25ycEd0STJSNnRaZHkrSjcwOEVLWmxCaFhiMWV4R0dRTkRDdTdBajBI?=
 =?utf-8?B?WGtGWGIxeDJiYkNZZVZiQmxxangxTHIyb1A2UE43aHdsV2UzQytGaHZTYU9j?=
 =?utf-8?B?ekVhMk9xbmIzd0txSmg1U0RWUTFLb0Q2RDJTSUJ4NGVET2pNZGFhS29aMHVB?=
 =?utf-8?B?RUcxVGRNVDRVTnJiTkhvU1U2c2tKKzU2MFNHVlBLbkdFOHpPM3ltakhqdU50?=
 =?utf-8?B?a2poeGNlUDN2OGxuZHExVndPVzlUbUdKNGhEWGMxMHZKc2Y0REVVZnlmdGZZ?=
 =?utf-8?B?VnNoODBpei9PS2hqMTNXcDFzRU14cHFSRGdveUxPS1FKY3FaZzZEa2RRV2VX?=
 =?utf-8?B?c1BxZDlyWWRuV0tsMUpQL0cvcmtMcmpwdHdJanRLVVlVMnA1R0ljRWlPazBr?=
 =?utf-8?B?dEl5ZWFtdjVZVUpTK1NNeWxSZVZiNnFrczkvMzlZOUxJSTd5am52QmZ3ZzNo?=
 =?utf-8?B?Y2lGdnJLdXBXTnBMQUExMmhiRGZKSWZ1SjRxZ0dSVVdLVGJyczF3ZGc1c0ls?=
 =?utf-8?B?VVRBVDk0czNmUk5Qd2ZmRkY3UjdNSmVyV1lPQ1FlZ2xBaDZPd2pONG5hUjNE?=
 =?utf-8?B?c25wWnBjbVFOMTdRK293NzlyN1B5M3ViaHR1cFZXczQ3OW9od2FGZGUzMzRD?=
 =?utf-8?B?c1NQU3QzNUo3WU9EenJYVHFHc3dIM01hdklvQ2l0dmZJcVJnTE53ZHV1eGUw?=
 =?utf-8?B?b2gzRE1XUU9ZVWdWMC9Zc21xcHZONjB1SzBockRxbG1VWENEOXB3eEt6ZjhT?=
 =?utf-8?B?amZaYkVzTnVTMHFUUEQ5YStoSVZSY1F6bTVzZ2dOb3VlNWZQL2U2ZDhqZW90?=
 =?utf-8?B?U2hsUk5SbXRseFJRcHZzWTAvVVlyR2Z6WWVDR09KVlNmSmgyOWpzV1VUWitj?=
 =?utf-8?B?Z1BnaXYrWTZHVU9aWE5OTlhrTExLTGRzZHA4YmhlNFZieFZCM1NmKzMzeHhZ?=
 =?utf-8?B?MkJ6ODZuTTJ0enFRNkVGRmZZazdjd3pxM2tUQSt4ZnFqajhQSW1aaS8yaUxJ?=
 =?utf-8?B?QkVjbkE2QmtzNGtDS3VPQnljR2xDcm5LeERsZ043VmZkeVdyL2VxanpPeXFJ?=
 =?utf-8?B?bUpEdWRDSmZuZGNZM05MMTVYL1M0cTk1STl1NXR3ODB5V0J0d1J6VWdZZkhi?=
 =?utf-8?B?REw4aFMzSzFXTG13cUFLVEFVMkRWcFpiaTdCNC9va3ZlU0pPTXcrU0hqZU9X?=
 =?utf-8?B?SGFEZXhlWmtLY09OWTlkVkxaTFJycnNOa0cwZmtCS2VJU1E9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cXdtS0ovZ2F6Zi82Nkx0cVZHbXhRV05qaFU4K2xicWxnKy84K3V2T0tTcW41?=
 =?utf-8?B?ZVhyNXgveXd4N3RWV21NQW9aU2lqblY2RXNKQ1NMRjlJbjV1K2RJTEprbFBW?=
 =?utf-8?B?OGQybkwzK3M5L1g0VDFBOXZiWCtJTjZSdUY0U2VTRnBBOGsvYnJIY2NxckRI?=
 =?utf-8?B?Zk5iS3JjbnBtYUl5Rk5YYjExbEZPbDJscGh4VmJXazJHL29weUg1Y0w5eVAy?=
 =?utf-8?B?OXFyNjJpS3Q2WUgvK25FVXVVeTcyMStpQWRPb2dDQlc3a3NLMHk2ZzB2SnhQ?=
 =?utf-8?B?UzExMnFJNkdBa0FmV1FQQ2NtMW1Ea2FUWkw1VUxmaUV6TUxVeXpZV1QxMEpW?=
 =?utf-8?B?UStrS2tSbDZvTEtxYUxjbTNXMWY5YWtZb2djWFdNaXR1Y21xb09Ib0Z5L0Vn?=
 =?utf-8?B?RjVWRGZwdVlZRllBT0NNcnVrbVhaMVhBdSttR3RDeE1JWkhVcnI3TFY1OTdt?=
 =?utf-8?B?TWJXZ1ZMVElBYjdYNkxDdVdoeVVYbVhjTzI0OFVOdTFvVGx3RjUvU0M1UUNy?=
 =?utf-8?B?b052dGlQUkxDU0xiUytjN0V3SXhZQkVqaVYxZ3BodTVxOE9FUVpFV1JqMHNr?=
 =?utf-8?B?SXNJQS9Ba080Wlh1Tk1ta0dQN3Y2UVRJZyt3bzAybFZUdUhHZG9XempFWnd0?=
 =?utf-8?B?Y1llQ0dCN0dsdGtEZGJBVCttYWloU2c1NGFGV2NuaGxGSndNOUVjVzJJbW5K?=
 =?utf-8?B?SEt2SkVGWmliaU43ZXlVMW8yTFhEWDFHNUtxWnB1UVBLODEybFdhSUVpVkRQ?=
 =?utf-8?B?RHoxM2paVWdLUjVhRU5rNGF4ZWNEVkJWcStBWmxia01JTnJYSlAyYXhmaGE5?=
 =?utf-8?B?UmlydGRuZmVjOUUyRUZaMnp6MXRHSms0YmQ1WjM0YTAwbUQwQXJqSkZneTFU?=
 =?utf-8?B?Qk8raFlvbFdWQitCd21kbzNRa1BqZXd2MTdqWmRDTDg3ajV0WExmbFducHNv?=
 =?utf-8?B?QVE1TXBQQk5aellzWVhkczVyTHlaWVRZaTlOa0tjenFUZlhITXljak1QWHJ4?=
 =?utf-8?B?akVYRTdobFBZeHZneVJ1TmJsUUhMeWlGSzRyZ2RwWnZkbThjcys5Rk9YRUVB?=
 =?utf-8?B?Z0NCTjV4SElPWk9BYWordUJUdll6aEJ4Y2U1WllFTFpMNUgyYVFZWm5PS3Jx?=
 =?utf-8?B?b0x0a2ZhVG9nbFBsemg5aGh5UHQ3NGRYYnRBZlZKek5qSEFCaCttMWUxRktF?=
 =?utf-8?B?Q0UrTEUxVFo3S0RQbTFLRWk1VjhwUHN0RXZnaHpJWHpScFRiL2RKSDk1N2hv?=
 =?utf-8?B?VmcxeEc0elhjWG9RK1lySDdhRVpLUGx5VDJ4ZzJncmt1Z0FqbEc2Y3RobUdq?=
 =?utf-8?B?TG9sZVFhY0pWR3UrVkdWbU9UeTA3WDhtSm02VHpETHRGdzhJNEhJSndCRWZ1?=
 =?utf-8?B?TFUzTllSUWhycUxDUVJoRjUrR2dKdmdMTXJRMUJNdGdqUjdjTy8vRDcxdndT?=
 =?utf-8?B?bnkvOFJja3VwQWM1YjkrM21vd1hkeis1L1g3cWRydUk0RDRnWEJKUlI3bHVx?=
 =?utf-8?B?TXJ2TUdGN3BOZWtlMFBYa0hsb1RWR3JHRW1CU2lQWUtWRkVaQVIxMzZHb2VS?=
 =?utf-8?B?a254TTlyd3FIZTRVcjQzUlpvNHV2UmI0L0o5MEd2Z3VYQTh1YjFRak1jOFZB?=
 =?utf-8?B?bzg1S0ZHZm1rQWRSNjR4M0oxYzZFS25tYklLeVVXR3V6QUFTSTY2SGNHL1NV?=
 =?utf-8?B?VDl0azU2ZVhnOGRzdzRVdElSakxKR0RiZktZVGtNRHhtT0s1VVM2VUZnUGNP?=
 =?utf-8?B?UTdBdG5Cd3ZkV3F2cEh6dGRUZHBScEZjTUxJb3ZGaVJVSE5XRlpwcCt6eDZN?=
 =?utf-8?B?OTMzN1pqZFVLQjljU0ZNeGV1VUVpK1JkYU85Y29RRzR3UUYxVXliZjVVRkdM?=
 =?utf-8?B?N3gxQnprNE1zdFU4Q2dXTG1ZWnhVM1JzZ1NXTWowcUtHaUpXTjFuem80RCtJ?=
 =?utf-8?B?YXczVGUwMEFBU0dwMVlyQWtvZ1hKbEk5azdVeUZha1FsRGRxdkpBbFFscHRT?=
 =?utf-8?B?UU5LMGUwc0J2ZGc3aWd2OTIyZXNNR3dxK2pVWGtNRmhBQVlFSjZiZGM2T2px?=
 =?utf-8?B?TG1PVkVib0xCSkc5LzVId3pDeTA3aHIrQW1pSEZYcDNheTlaMmh2Nm55ZUlU?=
 =?utf-8?Q?DMVW3LbktTBq0slhGjypmRaXt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 Fh9REYRQ6qVSFrZ1UJckvmRyB3pl8no/HAv1IfmKpeJP1x8f2OpWICmtFyLuT105iQw6tR6kdPnywHmafepxO0JvaSBHO7kbMVjplEfsHkEqoZkpuTurPesVEbE4yry69A4mjTBjDiZUy5pIdT9X5pO/sea8YbrRnzQqF1PkdGQ92SHmih73g/lRQj4RW3Brf7+VX+ud1/ERWoFo2FOSXTDf0qlyInb66tj0O0ZMprwsumddhEQvuUuSeFccZqN7MrBif/6s7bQkv3a+Tr5lP/EBHeuwwQnmEala3HWdC4Bb8VSyj0nmwcRD5ozhFTkURtLVO6GFdrZpArEnjZagViq8a1fCvR0HieWTIzMsHxsOMEX0HqESArPXb1PfJEyMB1DZYecEA8nSDQbB8gedPuMd2VKfMrUBlKgI6mAcbhZzGMXO//8bXqdFLpEcayK68S1dnvt58amaTG95fV6MR9yFtHbwEGBke+oQQmmVB86LaOZG8FRrQInnmkBYjACJXLtIxZzqr+L1LxVKWUwXFbl3sEEpSVVC5B5DYu0kXWKyXppRfhTd2vgmURIuKFcc0TZpJG5aZE7JJCSbZeMpnqCU1LaQs4f1e5u2Zcygq6A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cf3a08-6647-44ca-4d65-08ddd42d810c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 14:36:46.1157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQ8xO9oHhr+lHFgW6b/e6rkp63rGBk1ihay5qvQgXD6I+I7uzEMNawuJtdCZ14q/XGH8H1RZ0z9to+HIoWa9hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508050106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNyBTYWx0ZWRfXwCHIbeEiNrE+
 OUA2CGAiknHaQcife3Acx1D0SsJqr4QsauPjgt5pHF6J468IGbLMF3v2X/uOwl9kDo2cOFcbaIF
 pHN7DXqAnG4Zb48W3yxPV6g8w/MpbEGm9krkTeRHyc0vjeyUtRpATKDAh2FNFzgJTeXtGxUg1VM
 L/UWoHDBf3JCuPXDbjUfKytCaKWrqkR48uDffBqgr5jdaGTvhtvVY2Lt/jlUsxAsMOKp0sRK/U6
 tvqMgm6j8RDGD8vGil/NnQhoijG3ZIL3xdegBHno/6rXETgAHj7vo1BhmOZf/jNw8qKbsqwLF70
 ggu96cNl5444kStxc9VvGpKKxqibzH+Oi5zxVPG8OgJILBRkmSXveYYs2FB/mnuAC/FYKbk2TDb
 6cglg4ak3Zd5ExQa0g5QBT6vllbX8BbN2aq4jZPBYIYj8b2W8tAUKrafskMXD8aKIamV1B6E
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=68921704 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=eVLo4qD6szsvXJt1M94A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12066
X-Proofpoint-GUID: WoFNZbb1hzgjT6kaYBb4nAqKMu3fNuQO
X-Proofpoint-ORIG-GUID: WoFNZbb1hzgjT6kaYBb4nAqKMu3fNuQO

On 8/5/25 10:32 AM, Scott Mayhew wrote:
> On Fri, 01 Aug 2025, Chuck Lever wrote:
> 
>> On 7/31/25 5:14 PM, Scott Mayhew wrote:

>>> +}
>>> +
>>> +/**
>>> + * check_nfsd_access - check if access to export is allowed.
>>> + * @exp: svc_export that is being accessed.
>>> + * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
>>> + * @may_bypass_gss: reduce strictness of authorization check
>>> + *
>>> + * Return values:
>>> + *   %nfs_ok if access is granted, or
>>> + *   %nfserr_wrongsec if access is denied
>>> + */
>>> +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>>> +			 bool may_bypass_gss)
>>> +{
>>> +	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
>>> +	struct svc_xprt *xprt;
>>> +
>>> +	/*
>>> +	 * If rqstp is NULL, this is a LOCALIO request which will only
>>> +	 * ever use a filehandle/credential pair for which access has
>>> +	 * been affirmed (by ACCESS or OPEN NFS requests) over the
>>> +	 * wire. So there is no need for further checks here.
>>> +	 */
>>> +	if (!rqstp)
>>> +		return nfs_ok;
>>
>> Is this true of all of check_nfsd_access's callers, or only of
>> __fh_verify ?
>>
> Looking at the commit where this check was added, and looking at the
> other callers, it looks like this is only true of __fh_verify().
> 
> I'm splitting up check_nfsd_access() into two helpers has you suggested,
> having __fh_verify() call the helpers directly while having the other
> callers continue to use check_nfsd_access().
> 
> Should I add an argument to the helpers indicate when they have been
> called directly?  Something like 'bool maybe_localio', which can
> then be incorporated into the above check, e.g.
> 
>         if (!rqstp) {
>                 if (maybe_localio) {
>                         return nfs_ok;
>                 } else {
>                         WARN_ON_ONCE(1);
>                         return nfserr_wrongsec;
>                 }
>         }

If __fh_verify is the only call site that can invoke these helpers with
rqstp == NULL, then __fh_verify seems like the place to do this check,
not in the helpers. But maybe I've misunderstood something?


>>> +
>>> +	xprt = rqstp->rq_xprt;
>>> +
>>>  	/* legacy gss-only clients are always OK: */
>>>  	if (exp->ex_client == rqstp->rq_gssclient)
>>>  		return nfs_ok;
>>> @@ -1167,7 +1202,6 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>>>  		}
>>>  	}
>>>  
>>> -denied:
>>>  	return nfserr_wrongsec;
>>>  }
>>>  


-- 
Chuck Lever

