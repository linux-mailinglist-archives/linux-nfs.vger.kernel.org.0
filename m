Return-Path: <linux-nfs+bounces-12282-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5D2AD41B7
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 20:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD758163F84
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 18:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9FF23D290;
	Tue, 10 Jun 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FP2d4ZBj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jwjaIW1v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA3A15C0;
	Tue, 10 Jun 2025 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749579073; cv=fail; b=lWnRKs754KnYI9+JjCWPvNYHSTw/ANUuSViMMb25951ObTIWDfaaMij0uCGAQWKIp0AxfI3iDMFXmfK6oxWUpSqehSwhhGvKUSuRl5kTNyY2nyWZkCY7W0kZvIcWIfmbwYNUPCHy9CkFm8EEC3ouFRwNwPljAPlgBH3yk6o88MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749579073; c=relaxed/simple;
	bh=NN7drO6dIvPymazuT2GlCunuKcYC3tL9YBNyGs4aWsQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xt74m/8SUddrXbyxLWFJp0+b4yL9biR69Tduc3ZQQOW7DNQ64yY5qLy2ah3uCNfRcv4m70M06IB3biGwxXqoQVMve36rdLUn4Ubxcw/EmZKuaYrNUsLbe8xghrk8ALBunEZij52n3W8bP8CIYBGdA0g5AR4E9+il537MIXAYKKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FP2d4ZBj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jwjaIW1v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGMwMA009204;
	Tue, 10 Jun 2025 18:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pbw6kI6u0LvMnTdz5t7xpR4pg3Tq2a8WgM+xzC2Beyc=; b=
	FP2d4ZBjKovJnXllHYtmd4TWRgpvS+pv4QG8XjNTC2IcSNAGUqC9yAQuM+4e2YqL
	SV72+Nu62h0rtP9ts7P3cul1Tai1VNNIdOCt/lKqvN/rNqm7UJgDe5OLSlmEy0LD
	0vOa2h+OgwQJcslakqRYSI0OsVGB4eOl/8sO9Nc3eeJ7KR0iueqPh0IwNJK3J0Q0
	AurQAzqLVoS4dhsFOQetPw1Mv74UOUb1blB/lFIfvZWRgpH3exMdL3KdYKkNWkHp
	MutnrIVkyZerDMSvd2kyNLjJGgTtoSIC0pBefNDQApqCcuQKLTvqeiJnCCp/26hq
	5/ElxEvEcCCa5pdGjfKwcg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v4uhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 18:10:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGedtx020725;
	Tue, 10 Jun 2025 18:10:53 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9t5a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 18:10:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h35NUhgrV/VuhtdSGBKgK9OnUSOVX0mGRqxmZe5wnkfBoqsW89UCpFp7zY/tT+lgfEDdWDSU4RSwsYC7+Fp2l9L3+YqyqH/Hg0hAySeSFN1LEkKSOJIchKNfOYVpWGi2D1NFp9dpbK9nzzxH1BZTTIEVW7JYmeaWsuD/aviJU3s9rpo5ZGjGIySipU7NI/VxsD6zYgpX7kYJD4AvNbLCPLro6mJ2oWibYlrhzCCN+4/zVra4dUts105PVow2hBFsXsk4XH3QUM/meUy6l3vxXVAs7oDf7QAzx3rqA8m0y9xwNEkyDFmEMOAvJ9CArN7uZn2oBQJudAoIjpqJEUW4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbw6kI6u0LvMnTdz5t7xpR4pg3Tq2a8WgM+xzC2Beyc=;
 b=kEG5V0ca2cG64Qd4DPve+WPDSjkTvX36kAp0PX++exPa3X/76leahCVkLGHzq7+h9OsRZk6k7czt5d/UNtoZZ1SLvgdKYys44p0Hae8x11zT6C43rmQwYGZjfexbaoXBFCX56fxeS4R4tIW+nrFRjDFHF9UuMk9flSP8icZE0Xspa27DbGcUnCWedhTxaX6MDBmJcUXaE6fH/CHH3YqSx4OhxYJ3TohgYn558iIMAPxbwUxqinwK+zNghOvkewfGR9+O55EH9PwHqUTjLp+KuUuekd34lOYTzYnDiwLOnqi0CKr8KAdy3H+AWe0RAqHTMIyHm5S40zNg+5s03Nah6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbw6kI6u0LvMnTdz5t7xpR4pg3Tq2a8WgM+xzC2Beyc=;
 b=jwjaIW1vcYTH3CouiUFzt8TqhtHgQcHca25tszo75x9SMFoh67od+5yUS97c4KH2lJQO8w0W3BKLro7/zxvj/73K13crxXMFC/nfbmz3yTusVUIouuWeqd4yt7RUg+bmEpSR3hdh9Yv9Teiri4J56LTEhphFqe0HjRD1TlbAMok=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7914.namprd10.prod.outlook.com (2603:10b6:408:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 18:10:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 18:10:48 +0000
Message-ID: <1da1e7db-c091-44b0-b466-cb8aaa6431ff@oracle.com>
Date: Tue, 10 Jun 2025 14:10:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: Implement large extent array support in pNFS
To: Sergey Bashirov <sergeybashirov@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250610011818.3232-1-sergeybashirov@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250610011818.3232-1-sergeybashirov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: b556d998-ea70-4376-ec47-08dda84a208b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VGdVWm9rU2lnTjc0Ynd3RXRVRnppQWNiems0U3gxRmNaL2Y4NzhheU91UXpq?=
 =?utf-8?B?UEpyVW5XTUdyVUVBNHZYbEdHcUhQSWhjc09CaHR2b1NYN245Q05QaytPL3cr?=
 =?utf-8?B?Unp0SHRRb1UzTlpIMTYyY1dqbkhkQmZkTVhTR0xwUlQzd29pRGR3RllsWTBE?=
 =?utf-8?B?ZUZhc2Y2Yld6d3Q3ZHQ0NC9DWkdsNnczOXdsd1FVY2tEb0g0NGhDd1Nkdlll?=
 =?utf-8?B?TzFidmhaRzloT3hQT2UwK1RqbkRFZjF0eEpsdEFlR3QzeVBKNmljLzZmeUNo?=
 =?utf-8?B?VTUxU1ZwM3B2YXlTSlpCekN3WkJXWlhDQnhGN1c2N1pLQndxSEtXRU9WQ0w2?=
 =?utf-8?B?bkZKaUxvbmdYVlNVdU9yblhDVmtBT2ZKZ2V6eDhyRll4K3RnMGd1TnVObEpL?=
 =?utf-8?B?enVaMkc0SE5IUUp1b240bzdZMjlSSUV5bUswYVVqdW0zbEpXNHM0RkphamxF?=
 =?utf-8?B?T01oaVRxSCtHQmRiRTd4M0NKdDIxczRXclhFMSttbGt1MXFOVkJoSEN5L0Rk?=
 =?utf-8?B?M0tGTmc5VDVtU1lXTlMvVkNvV09lbW51cVVaVW1KcUxTL0FPUHlySUp5WUlF?=
 =?utf-8?B?L1F3S2luZGkrUk44WFFYQjNaZFlMOFViYU4rc21DT0pFa0lYeG1FcmZabUkr?=
 =?utf-8?B?eUNPaXhnYkhrRk12TlF6NjBZQTNSMW16R29pbnNoeG01NWdMR2MwZjZYYS9t?=
 =?utf-8?B?RllzVWN2Tzk0OG9NODRVWkxHa3VGRjBEei9SR2ltTWZWR2daZGMrSUpyait0?=
 =?utf-8?B?WHRsL0V6Z2dYU1J5WHhtZnltN2s5SmczdkVxV0sxS3hKQjRJSERXYXluMGl0?=
 =?utf-8?B?Znk2RGhVTUJleUxHK3YyYkZzcWZmVmVPbTJoZE56QVA3NHJzSy9ZQ3lrTWgr?=
 =?utf-8?B?RXVqOWpTdldvaWJIS0dlZkE3OFlEaVVldzdSdGtmUTZCZnFGL2pobXBlVzJ4?=
 =?utf-8?B?bGtPTC9rOHVneUFEbmNLdzBZTERNVURRN3FWcTJNZVRtRTZuWXV6TzBRbGtB?=
 =?utf-8?B?eW5xVVVDRnlScit6WldLb0Z1RGl0USsrd0dmTlRnMTBteTZDUmlmTHJOR2Vu?=
 =?utf-8?B?N1RtZnExM05QMS81a2ptWjZmNkF6MmtZT0paQ1loQTc0eUhzbW9DeDlhWHhN?=
 =?utf-8?B?emJ5TEJaQnBNNVZFaTU1cGlHZVZwNmVxUkJiL0lFZThrV29PWFEySjFvMEZD?=
 =?utf-8?B?cnZNNGREUE4zemc2Qm1tMzE3YzdZL0hHNEpnSk5FZURvRFNGWXJZY2NZWnNu?=
 =?utf-8?B?U0NpblhseUh0aGVOUEUxOFIxaVJrbWVYU2tvOTVWbjgzdGRlOThPeS8zQVlD?=
 =?utf-8?B?UWkrSlhKMHAzcjFRSlkyUEsyOFQzZ25qU09YRTZjaUtzaTZIREVla0pERDRE?=
 =?utf-8?B?MzYrMC9pbWNYUWVHOWdyYlZJOG1xZzZrcDNpUFNucUtnODlNRjNMSS9naGtL?=
 =?utf-8?B?QTJSR0g4SDlaUFRaajRGVjg4QW1KNlZIR1V6eXFDcXorZVRuZTBxRjBEVnkv?=
 =?utf-8?B?ODZQZ1hQSGREaHZKSmd3bERFbHBLWFZSUzY4bkNibVNOS2FoYWFaSHFSTGZ4?=
 =?utf-8?B?dXBHcEk0SXNkZTRITTk1REVoWC9RK0ZQZjFOMU1oL0FFV3JIVzRQUHlKUits?=
 =?utf-8?B?N2JCSzJEQXFaTWcveEhTOHprZXFCemNyMXlLSUNwWWdkQ1RoTWIwSlBPOHMw?=
 =?utf-8?B?U21YQjM4UVpyQ1h3a29acmpaM0xBUHNkeU9PUXUvdVJ1aC92M1l0aXFEQytU?=
 =?utf-8?B?L0x6N1gzd21kbmFPVzU2VU1GQ3I5MkpCbWl0UDZvTDdqSE1NU1h5M3UrUmJk?=
 =?utf-8?B?akVOdERLQUk3cEVQRHN2cktSNWJDRGcxWjMvR2hRenIrT3NiakpPS3BCTGFv?=
 =?utf-8?B?bkdIeWUxYUcwSWZPT243SmcwbUxCekE5ZThWaUZLUE9xZURBamhiSnhUWFBh?=
 =?utf-8?Q?TfJKAOgxyDg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ekpOblhFb2RMV3RFL1gxUW1vUHc5UnhvcXVEaE41SmZWbE56OEFyQ2xpdVp1?=
 =?utf-8?B?Y3hrUEFKSkxwaEtLOXdYWUVFQVBUVFVwdE14Ny9zWE5HbXFmT3dCeSsvSEl4?=
 =?utf-8?B?eWNkalE2K1NDdlJBYmNyUU8zU0g5VTZ4eDdxbTZzaTlnTTBESlJHSTVjRWtZ?=
 =?utf-8?B?TUVHQ08rMk81NnJQTlMwY055Um1hREorNkJIQ3dzZ3lPRk9iWkdYUlg0cWRD?=
 =?utf-8?B?eDY5a1RNZzBSQ0VSSTg3SFkyeW1Ecm52VXMweDdjVTBIVy9NY0t5ZzNZcTI1?=
 =?utf-8?B?MzB6NGxMYmVUTHA5dVhaUTVEQXFoM1NqRFdZVVVzNS9rYVhiL2lvVm9FN0hU?=
 =?utf-8?B?TGRqYmk0cmp6MnFUbXppOGlwSENoSmRiaDcrOXlPVjVjdWFwZGNMTXNoeDl3?=
 =?utf-8?B?Y2plSWhQV2dXYjZFRzBabSt6NVIwNGFGK0JsUFlESXcwK1JyeXhXUDlkN1pM?=
 =?utf-8?B?Rm5jZjkxTFMwcktabDhSMGtsWnU0c0ZjOXBJdVlOS1A5NURHTjJGNmJzRU5J?=
 =?utf-8?B?blpwZURXVnAwMUJxeloreXFPQjRuZHQ2bWlmSlBFc2g0K0lYRm0vMHczOXdl?=
 =?utf-8?B?ajdvV1h6S1RrRjRmVGNwWldIT2hoVXhPV3E5VWFHOTFlUi9VTmVyK08rMFVx?=
 =?utf-8?B?Zjg1ZmpIZUZmKzVUQ0ZEWGc4VThKWlExQm0vSkZkWG1Ec0QyNjhqTjNDeWli?=
 =?utf-8?B?TElzK2tNdmd6L3lXR1JQOVA2R25qdU9RTFFTSVZTWmF1NytDSGI5RTMwZnpV?=
 =?utf-8?B?VURSMjQ2Rlo3RG9jRk5PNGFvWDNESDNvTEdkZ3h2bk5KTlhTbkdvcWR0Q1VF?=
 =?utf-8?B?VmlSam5pNDZ1TWxvc2dLNDYzVmJTUjltKzFvNWRkZ1oxb2h5MHhwZkhtMW9m?=
 =?utf-8?B?WXhhcEk0NFVHamtBTEVPSUVNNGNud1NNMjI3dWpJQStCTi9GM0Y4dVh2a1h4?=
 =?utf-8?B?cjJrVGVHa0RjUmY1SjQ2dXJlc2VETjhvOVhnb0pkUHVJK20wNGwzTjVZUGtj?=
 =?utf-8?B?SWg2Tm4xYnBIekpiVUIwQ3c1TFEreXpMVVBFVTRneVN3eCs0RUdrbVNPY0Fh?=
 =?utf-8?B?T1hMNnRxVC9KRDZ5MkVrbHY0cmczZlY3V3NWMEduanZSQ3UxR2Via25iZU9N?=
 =?utf-8?B?ME05ZzgzQTc5ZHVQYnBiMXRiNEFWc0EzVTNIbjMzeUxjU3o1MkRrclBBb3pZ?=
 =?utf-8?B?a2dGKzM3RU1Cdnp1R3REWFZPTmJwSFJ1T0NhLzlVS1BxTGFuOGh3SHdwRmta?=
 =?utf-8?B?NHdGSDBXU2E1NW5FTEhad00zanRnKzY2NGtxaEJvbXhTbHBSODVsZlB1ZDY5?=
 =?utf-8?B?L2dzdmFZYVcvOWY3c1d6OHd4VnF3NTZvVXV5TUZpOVVsOUk1Q0wzaGdYS1d3?=
 =?utf-8?B?b1FVS2NZdTVDM1FubHM0UUdkZWhUdXZtcnF2V0J2bm1mUU91UlFTeEdTa2xJ?=
 =?utf-8?B?TURQUkFpNmtRTGMvNTRTeE1QV0VBSjIvRWhUbnJxb2gzSnRxNFMyTElkR3p2?=
 =?utf-8?B?TWFXRmpTMmVrQys3eDRDbVVENTMyNit3S3dGMmhSVktTejBKU0dJOTc4UGZG?=
 =?utf-8?B?TkcrWGlPZ0VqMG1ZOUJsRk80L1Q1V3haZmJVdDJHSk9zZWtpNHYwZXNGdi9D?=
 =?utf-8?B?Vml1RmU1dmt1L3lXaHF5VDZvUjkvYlZKWnJYUm9uVmdoZlhZZW5JOG5uT2Jw?=
 =?utf-8?B?eVZRRGNzR0ZHcUdKWmJhVTRkL2RLZXNjdGtoL29mekhSVExlL2hvYm1nQ3NS?=
 =?utf-8?B?M21iQmJGVzNBYzF4ZzRyZk1yRTlONHRmU2hXL0pkR2JSOHd5RkVyK0YzVkZn?=
 =?utf-8?B?ZmpRTmF0SEpnYXVTUFgxL0UyZTl2OXdzNWxSOTlsNFVwbGM3Q3RpMXFoaXZw?=
 =?utf-8?B?TDdJSmc5T1pWUTlQZE1ONU85c2RIclJvSHFGMXFUUWJMbzFCZUNCM0swbzA0?=
 =?utf-8?B?amZhczkzK0hUVGUyV05iY0JVNlFOUmZVSXhBRTVqNm5vdDd2UFZEOG9tejJt?=
 =?utf-8?B?ZUNXQlVtOVJLaFk3TklHYU1UT0EweVcvT20rOTRLaVJXZzZyUG0vTWRNcTJF?=
 =?utf-8?B?RTBKUDZwVCsvcFFJQjQ5RXMyb0hVUkpKRy94aXdhakdPUUt3SFJvaGpIeWJB?=
 =?utf-8?B?Rk9CbnJoaGM0ZzRGNmFUTnBpT2MzQlk1SWFpVUZaalRtQVFhVTV0UVZkM1hX?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+2TkAlM1Po8Ipee6dgbyy/FEqvVnfD43QK7Qxow6adYf47KFy+EPnucE+VSeL1mHAyq9O3GNokYX90HlPK4zbDd90oW9W22g4BmHuGwKIHK01P2CrOV/UXlucFfkEGJk3jU0R0halVxxo31MZCIPlpHoYfzrFzenqx1tKKVs2zZRH/0A7nXPBBhemdLYmZ7i1QdGanpVZkUcOqsdKOxUkHgXoL9qlfTLYb8PTQHioH4JX3AsnqXS3HQdycfZKKEm74lFxYiM7fiGO7qLo1z3QCneLh52PmHS+PZZTHdtWRCA8lmU0DpLTBwJh1ve5eKEBmdaqM62WVlHGcPQlZxTU/ga7hMbmyjjvYd3mMUJoJYnLiniCnAX0yYRQE2VNMebmxfHLZ24Er6tPAQJ3Dy4W1efvGlME3/BEYbOkmVKg42GwzPPRHULWPogq9Ng4RiFCKBi1orp6OzWyXCZgEo7KtBiGk33TN/gqsVVgCARcYQATrDHExhVgvoNamov77+tvV19muYyjsit0puoh/ApTwnhNx0bXnnwXrZvoQj/Ngp1NmVxTc5zWAgzoInmOXCW9SoyLQkW4dzHUGBhb0qfEuRe0ZplNfNNg3sHiUaeY8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b556d998-ea70-4376-ec47-08dda84a208b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 18:10:48.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9j9Vt+9STw1dfAdNMHusbU0kgC1OjagmslUmgq0DyAIhJOf2yOQC3SSdkKPxufCSSohBCDDmNKpXniGtHal+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100147
X-Proofpoint-GUID: ViCt-W3balUXmvXVXlnOj6BQaH6b2U_y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE0NiBTYWx0ZWRfX/+hxqhxSt2fL 7Uw45nW/ZxOZEaj7smRClesoZH/bkHtEgyILx9RHxbvKKd1Wuu69JQRDhAH97pS6hdy6Z//RmSk 7EK23TNg0iO/ZI4U8YhBteFxatEjzjzBW0dAh5soTY4XciQ2EeNIfeVV60QUuY8m8aU/Gt06KdL
 YywMWlRg2mLWMTp/gwHhsVnKVIr2iSgp36AyevnNbB2o8euDwO4ZN1L1NZGA+/2RQLiZ6YqkKKl C6Fo0U2zI+dLCN3YUxU0nqDQIKifJbZIyYmzEvc37unNJO65EmMLX1F6mt8DbX9kUq9owOjvJE5 OcOtxjNtIMyTG+NdjUZ9NhCARrzKbucfKFoUovir0YdWX8z2bRf0bN9yEbB7aH5W+UK5yOMw3RZ
 a85illljlU3KFnFbz6G3Y/x5N2ZPQeF8ixdVOmmfQzYfeG15L8R7Wr4m1Fq/7GX/rKv9MQik
X-Proofpoint-ORIG-GUID: ViCt-W3balUXmvXVXlnOj6BQaH6b2U_y
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=6848752d b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=BMxJXzqDAAAA:8 a=pGLkceISAAAA:8 a=Lr3q9Uz3VAHwro_5k0sA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206

On 6/9/25 9:18 PM, Sergey Bashirov wrote:
> When pNFS client in block layout mode sends layoutcommit RPC to MDS,
> a variable length array of modified extents is supplied within request.
> This patch allows NFS server to accept such extent arrays if they do not
> fit within single memory page.
> 
> The issue can be reproduced when writing to a 1GB file using FIO with small
> block size and large I/O depth. Server returns NFSERR_BADXDR to the client.
> 
> Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
> Changes in v2:
>  - Drop the len argument in *_decode_layoutupdate()
>  - Remove lc_up_len field from nfsd4_layoutcommit structure
>  - Fix code formatting
> 
>  fs/nfsd/blocklayout.c    |  8 ++--
>  fs/nfsd/blocklayoutxdr.c | 89 +++++++++++++++++++++++++++++-----------
>  fs/nfsd/blocklayoutxdr.h |  8 ++--
>  fs/nfsd/nfs4xdr.c        | 11 +++--
>  fs/nfsd/xdr4.h           |  3 +-
>  5 files changed, 78 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 08a20e5bcf7f..e74c3a19aeb9 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -179,8 +179,8 @@ nfsd4_block_proc_layoutcommit(struct inode *inode,
>  	struct iomap *iomaps;
>  	int nr_iomaps;
>  
> -	nr_iomaps = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
> -			lcp->lc_up_len, &iomaps, i_blocksize(inode));
> +	nr_iomaps = nfsd4_block_decode_layoutupdate(&lcp->lc_up_layout,
> +			&iomaps, i_blocksize(inode));
>  	if (nr_iomaps < 0)
>  		return nfserrno(nr_iomaps);
>  
> @@ -317,8 +317,8 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
>  	struct iomap *iomaps;
>  	int nr_iomaps;
>  
> -	nr_iomaps = nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
> -			lcp->lc_up_len, &iomaps, i_blocksize(inode));
> +	nr_iomaps = nfsd4_scsi_decode_layoutupdate(&lcp->lc_up_layout,
> +			&iomaps, i_blocksize(inode));
>  	if (nr_iomaps < 0)
>  		return nfserrno(nr_iomaps);
>  
> diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
> index ce78f74715ee..b76dbb119e19 100644
> --- a/fs/nfsd/blocklayoutxdr.c
> +++ b/fs/nfsd/blocklayoutxdr.c
> @@ -113,26 +113,27 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
>  }
>  
>  int
> -nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
> +nfsd4_block_decode_layoutupdate(struct xdr_buf *buf, struct iomap **iomapp,
>  		u32 block_size)
>  {
>  	struct iomap *iomaps;
> -	u32 nr_iomaps, i;
> +	u32 nr_iomaps, expected, len, i;
> +	struct xdr_stream xdr;
> +	char scratch[sizeof(struct pnfs_block_extent)];

Using "sizeof(struct yada)" for an XDR decoding buffer is incorrect.

struct pnfs_block_extent is a C structure, with padding and
architecture-dependent field sizes. It does not represent the size of
the XDR data items on the wire.


> -	if (len < sizeof(u32)) {
> -		dprintk("%s: extent array too small: %u\n", __func__, len);
> -		return -EINVAL;
> -	}
> -	len -= sizeof(u32);
> -	if (len % PNFS_BLOCK_EXTENT_SIZE) {
> -		dprintk("%s: extent array invalid: %u\n", __func__, len);
> +	xdr_init_decode(&xdr, buf, buf->head[0].iov_base, NULL);
> +	xdr_set_scratch_buffer(&xdr, scratch, sizeof(scratch));

Consider using svcxdr_init_decode() instead.


> +
> +	if (xdr_stream_decode_u32(&xdr, &nr_iomaps)) {
> +		dprintk("%s: failed to decode extent array size\n", __func__);
>  		return -EINVAL;
>  	}

Throughout, please drop the dprintk's. At least don't add any new
ones.

I find the use of -EINVAL to signal an XDR decoding error to be somewhat
inappropriate, but I guess it's historical (ie, its usage is not
introduced by your patch). I would have expected perhaps NFS4ERR_BADXDR.
Perhaps that should be corrected in a prerequisite patch.

NFS4ERR_EINVAL means the server was able to decode the request but the
decoded values are invalid. Here, the decoding has failed, and that's
really a different problem.


> -	nr_iomaps = be32_to_cpup(p++);
> -	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE) {
> +	len = sizeof(__be32) + xdr_stream_remaining(&xdr);
> +	expected = sizeof(__be32) + nr_iomaps * PNFS_BLOCK_EXTENT_SIZE;
> +	if (len != expected) {
>  		dprintk("%s: extent array size mismatch: %u/%u\n",
> -			__func__, len, nr_iomaps);
> +			__func__, len, expected);
>  		return -EINVAL;
>  	}
>  
> @@ -144,29 +145,54 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  
>  	for (i = 0; i < nr_iomaps; i++) {
>  		struct pnfs_block_extent bex;
> +		ssize_t ret;
>  
> -		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
> -		p += XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
> +		ret = xdr_stream_decode_opaque_fixed(&xdr,
> +				&bex.vol_id, sizeof(bex.vol_id));
> +		if (ret < sizeof(bex.vol_id)) {
> +			dprintk("%s: failed to decode device id for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  
> -		p = xdr_decode_hyper(p, &bex.foff);
> +		if (xdr_stream_decode_u64(&xdr, &bex.foff)) {
> +			dprintk("%s: failed to decode offset for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  		if (bex.foff & (block_size - 1)) {
>  			dprintk("%s: unaligned offset 0x%llx\n",
>  				__func__, bex.foff);
>  			goto fail;
>  		}
> -		p = xdr_decode_hyper(p, &bex.len);
> +
> +		if (xdr_stream_decode_u64(&xdr, &bex.len)) {
> +			dprintk("%s: failed to decode length for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  		if (bex.len & (block_size - 1)) {
>  			dprintk("%s: unaligned length 0x%llx\n",
>  				__func__, bex.foff);
>  			goto fail;
>  		}
> -		p = xdr_decode_hyper(p, &bex.soff);
> +
> +		if (xdr_stream_decode_u64(&xdr, &bex.soff)) {
> +			dprintk("%s: failed to decode soffset for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  		if (bex.soff & (block_size - 1)) {
>  			dprintk("%s: unaligned disk offset 0x%llx\n",
>  				__func__, bex.soff);
>  			goto fail;
>  		}
> -		bex.es = be32_to_cpup(p++);
> +
> +		if (xdr_stream_decode_u32(&xdr, &bex.es)) {
> +			dprintk("%s: failed to decode estate for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  		if (bex.es != PNFS_BLOCK_READWRITE_DATA) {
>  			dprintk("%s: incorrect extent state %d\n",
>  				__func__, bex.es);
> @@ -185,18 +211,23 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  }
>  
>  int
> -nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
> +nfsd4_scsi_decode_layoutupdate(struct xdr_buf *buf, struct iomap **iomapp,
>  		u32 block_size)
>  {
>  	struct iomap *iomaps;
> -	u32 nr_iomaps, expected, i;
> +	u32 nr_iomaps, expected, len, i;
> +	struct xdr_stream xdr;
> +	char scratch[sizeof(struct pnfs_block_range)];
>  
> -	if (len < sizeof(u32)) {
> -		dprintk("%s: extent array too small: %u\n", __func__, len);
> +	xdr_init_decode(&xdr, buf, buf->head[0].iov_base, NULL);
> +	xdr_set_scratch_buffer(&xdr, scratch, sizeof(scratch));
> +
> +	if (xdr_stream_decode_u32(&xdr, &nr_iomaps)) {
> +		dprintk("%s: failed to decode extent array size\n", __func__);
>  		return -EINVAL;
>  	}
>  
> -	nr_iomaps = be32_to_cpup(p++);
> +	len = sizeof(__be32) + xdr_stream_remaining(&xdr);
>  	expected = sizeof(__be32) + nr_iomaps * PNFS_SCSI_RANGE_SIZE;
>  	if (len != expected) {
>  		dprintk("%s: extent array size mismatch: %u/%u\n",
> @@ -213,14 +244,22 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  	for (i = 0; i < nr_iomaps; i++) {
>  		u64 val;
>  
> -		p = xdr_decode_hyper(p, &val);
> +		if (xdr_stream_decode_u64(&xdr, &val)) {
> +			dprintk("%s: failed to decode offset for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  		if (val & (block_size - 1)) {
>  			dprintk("%s: unaligned offset 0x%llx\n", __func__, val);
>  			goto fail;
>  		}
>  		iomaps[i].offset = val;
>  
> -		p = xdr_decode_hyper(p, &val);
> +		if (xdr_stream_decode_u64(&xdr, &val)) {
> +			dprintk("%s: failed to decode length for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  		if (val & (block_size - 1)) {
>  			dprintk("%s: unaligned length 0x%llx\n", __func__, val);
>  			goto fail;
> diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
> index 4e28ac8f1127..6e603cfec0a7 100644
> --- a/fs/nfsd/blocklayoutxdr.h
> +++ b/fs/nfsd/blocklayoutxdr.h
> @@ -54,9 +54,9 @@ __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
>  		const struct nfsd4_getdeviceinfo *gdp);
>  __be32 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
>  		const struct nfsd4_layoutget *lgp);
> -int nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
> -		u32 block_size);
> -int nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
> -		u32 block_size);
> +int nfsd4_block_decode_layoutupdate(struct xdr_buf *buf,
> +		struct iomap **iomapp, u32 block_size);
> +int nfsd4_scsi_decode_layoutupdate(struct xdr_buf *buf,
> +		struct iomap **iomapp, u32 block_size);
>  
>  #endif /* _NFSD_BLOCKLAYOUTXDR_H */
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 3afcdbed6e14..659e60b85d5f 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -604,6 +604,8 @@ static __be32
>  nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
>  			   struct nfsd4_layoutcommit *lcp)
>  {
> +	u32 len;
> +
>  	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_layout_type) < 0)
>  		return nfserr_bad_xdr;
>  	if (lcp->lc_layout_type < LAYOUT_NFSV4_1_FILES)
> @@ -611,13 +613,10 @@ nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
>  	if (lcp->lc_layout_type >= LAYOUT_TYPE_MAX)
>  		return nfserr_bad_xdr;
>  
> -	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_up_len) < 0)
> +	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
> +		return nfserr_bad_xdr;
> +	if (!xdr_stream_subsegment(argp->xdr, &lcp->lc_up_layout, len))
>  		return nfserr_bad_xdr;

The layout is effectively an opaque payload at this point, so using
xdr_stream_subsegment() makes sense to me.


> -	if (lcp->lc_up_len > 0) {
> -		lcp->lc_up_layout = xdr_inline_decode(argp->xdr, lcp->lc_up_len);
> -		if (!lcp->lc_up_layout)
> -			return nfserr_bad_xdr;
> -	}
>  
>  	return nfs_ok;
>  }
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index aa2a356da784..02887029a81c 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -630,8 +630,7 @@ struct nfsd4_layoutcommit {
>  	u64			lc_last_wr;	/* request */
>  	struct timespec64	lc_mtime;	/* request */
>  	u32			lc_layout_type;	/* request */
> -	u32			lc_up_len;	/* layout length */
> -	void			*lc_up_layout;	/* decoded by callback */
> +	struct xdr_buf		lc_up_layout;	/* decoded by callback */
>  	bool			lc_size_chg;	/* response */
>  	u64			lc_newsize;	/* response */
>  };


-- 
Chuck Lever

