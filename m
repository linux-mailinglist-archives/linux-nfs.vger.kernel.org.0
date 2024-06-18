Return-Path: <linux-nfs+bounces-4039-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2146E90E02F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 01:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126051C22DC0
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 23:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D7D13D625;
	Tue, 18 Jun 2024 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UsxBEG5N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hJ6SnbIO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBACF11CA9
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754691; cv=fail; b=WOzdsX6Z0/lDkGhysxCoI72lWRRQgwXzZ7lY1Z8SiwbuMikeUjvIseNLMz3fun7+xgKH04oHlg5YDzlKAhnKih86Vmk02wVGT7CXSSCD99Vo/OBULErX/hYC+IX7m5CUmjXucQof2Xb5cOXMzLped2dQKXLUi31zjbAnSZ4ULfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754691; c=relaxed/simple;
	bh=QlKkAYYvAHi0YloWbKTVKZsuc21GxVtIN/oxLX/B0xc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mDEgccN8/YFrT0A/GfH4CyfxOLxgdEoeV5df/wibluwg21ZuGYi0no5Ae+zUuQPXdz1dApewRpd+nK53Db85vVuThdd3lfDyPXywJAGe8beb6TUjUJtVyNqvwc/DZSJG+DYY7pEWQsbgF/e6M8adbM0kwxCv6QqAMpiG0YoT+IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UsxBEG5N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hJ6SnbIO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILaopo000983;
	Tue, 18 Jun 2024 23:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=QlKkAYYvAHi0YloWbKTVKZsuc21GxVtIN/oxLX/B0
	xc=; b=UsxBEG5Ny6Kt7+fQ+ik6OpkjM0yGRrEf1atbt8AXQu5KA1mWc2iEIT/qP
	bYAokeJ845DlzhTB1mytjcxaxDn1ZR5aOLkvEbCnqJ3/EN7I4dTv+HWzrpy9qqc3
	MoqbFMIAZv6LgM6FuJXmoqU17GBBMXxFQe5O2HRaLwd4ZKBlAiZdXw/HWMl0wQCi
	8BNHb8nhZxAdrpeRRrPPWqgCipCG7Rvw60izvJdJv3/fdCWy9DY2yySoN60FqLrr
	wDngQf7M86Z5Bk+9QcrUU4XZZZ5Wy0/iyUL0w5zPthiTCdiS2f9Evieyb850oUN0
	42mlaLBqNR0KLec5Ds5Kx7DiSjs9w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9j8482-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 23:51:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IMNvlC014806;
	Tue, 18 Jun 2024 23:51:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1devwja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 23:51:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHg/ndm6ILTGeLMc9TNlWxWpPIQzvQf1LVYkonsDr+VwcTXmOLmIUicNZAb3YXf+Vmw7UnSWdexgecdKXV6yFiD0cRVxY/qUhtx1lJ4UBQIvay8n1CJRspCicc8Aj828NQDS7WTDd4vUsSbjBkA1hzIr1tQv5qXEhdNz1IDcGuaIQTLgXD1/rTKOOvw3ZJM8uYt77uRVuPUzHJbZxoGFJUCbSDpMPzdJ65eeXdb9UawDnwWbhZX5ZUUYkkXZGQ8onL4Aa7bQxOs8YSYrcbaGtx1w28IBzQXmYE04PY1XvxIctGKoHqBfNE6wvuGhafm7KfM88UVz2MgAIOGnLu5TJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlKkAYYvAHi0YloWbKTVKZsuc21GxVtIN/oxLX/B0xc=;
 b=h1l4WiuOaJZuQcuzb6Y+lmqISpsAcvrUTbwHRM93RQj/0Gk0vXMAA8Omzd3RAhvzTxRtdfbQbW6BT1+eRBq/a4R3ijSplWhClxQMphIQ9cvSAvWZM1w+zQEwqoQU1CGyHxrhFQcWIdgsKazVpA+YHkhwOOK6fLCm3/bDa7vuHASiS1Lnrlytryv4PykQnyb1HGTfq+nHXE0zcbsFTepIOZ8mozw3K51xOdrolxYNfsIAvRWmRESNko5JS7wyfkgsWYegT9SAgoEf/C5dojLZnDZi7LrN2DM7kOBqThJ2i1BWtV9MYEAUXXOI0uwHqhEdgPi06c6qKd+lihM9vZ7roA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlKkAYYvAHi0YloWbKTVKZsuc21GxVtIN/oxLX/B0xc=;
 b=hJ6SnbIO87cL7D0SpF+jFiuEUwjN0CjHa+qoF6+wocZKHarGZPO7EuyKJWe1j9RoQNJKU4rjRxlMWrBd0Rt649GkT7zNJfqLMoRb/Qz11JG/h6YRlYdb+fSu7sTJhfq01SJe5XxAw3f3AbLFHn2ZpIfogRuPHBserKqlzv85KOI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6337.namprd10.prod.outlook.com (2603:10b6:510:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 23:51:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 23:51:17 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>, Trond Myklebust <trondmy@hammerspace.com>,
        Dave Chinner <david@fromorbit.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: knfsd performance
Thread-Topic: knfsd performance
Thread-Index: 
 AQHawa3dybcUo3ed40e1woBUDQls6LHN2rIAgAANu4CAAAKdAIAAAygAgAABH4CAAAY3gIAAMnyAgAACcACAAAIAAIAABPSA
Date: Tue, 18 Jun 2024 23:51:17 +0000
Message-ID: <4745FED8-65D5-4C13-A7AC-FD862E750D7F@oracle.com>
References: <87354accc0d1166eb60827c0f8da545e0669915b.camel@kernel.org>
 <171875264902.14261.9558408320953444532@noble.neil.brown.name>
 <E14A0A67-71C7-4ED7-BE4E-525A186B876A@oracle.com>
 <666773670fb0eace2ce41c586b3d3fe99e54dda1.camel@kernel.org>
In-Reply-To: <666773670fb0eace2ce41c586b3d3fe99e54dda1.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6337:EE_
x-ms-office365-filtering-correlation-id: 806d181a-1e25-40d0-d8d7-08dc8ff18baf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SE5GaFhWd0pQMDgxbUQrRXFFU0xtSVBRTzU1T3FaZ0RieDhGM04xNU9JZEpU?=
 =?utf-8?B?Y0V0SkQ3RkQyMkRFdlpKMWZBSk8rZHM5OTJKd3VTbTdmYzZFV3FielkxYjgv?=
 =?utf-8?B?cktFcXhCOHd4RnZyajFsdkNweVJQOWlDdzNJOWZRdVFMbm8wbjVXMWJOa29l?=
 =?utf-8?B?MzBkNnhJZnpZRytrV0NXcllUKzY1V1kxUHlpV00vWE00NDd6YWRsd01TYVR4?=
 =?utf-8?B?Rk1LR1QzT1pLNVV1OFN5WnFzVFJtRFM3WmczQkRWdzVtRXdsSVRFOEUrNDEv?=
 =?utf-8?B?ZkgrWTFJMjE4Y1h6UTJtcW1MWG5iaG9HQit4cm5jaGhURnNXR3JZOGRTL1Uv?=
 =?utf-8?B?c3YvdnN3ek5ZYlhGeXhjb0k2UytYRXVDeHpqTVRtN082WEpQZmhGZWRjaFZk?=
 =?utf-8?B?ZHFRbjZLRTVyWWF2QlJvaG1HdWNXbnpwU2FMcFVOa2J3OGxBNG1Lcy8yRmpa?=
 =?utf-8?B?T2Z2RFIzaEtLUldyYkVlTUhlRkI0ckxyMHVlcmM5YnZLN3pHY252emdLbERZ?=
 =?utf-8?B?ZC9LeXcyaG95Z0dTS0xPWU5GZVhnZGVaSm5OcVlVSStJc1ZPREtPZ2tRWExC?=
 =?utf-8?B?TDFoU2FkVDB1KzZkamJqalBwMEREU2xEUDNuemdCUmYxNTFSUmFQYzU4OXJ1?=
 =?utf-8?B?bzFKMHlOT1JiQnZFWmRIMzRGd2k0aktnM0ZGSlVFd3kvMU12Q1FOaTErNVJC?=
 =?utf-8?B?ZmhUNlA2UXJBREdobU5xdWwwVnVpQkNibVpHT1l0Z3BSNld1M1VNMFFzYk5m?=
 =?utf-8?B?dHhyMlJKN0F1OWZrS1hHczQyZ2JPTDJvd3JUTGE0UHo1Tmd4Ly80VTE0MHJM?=
 =?utf-8?B?UExJYW1QSENUNHYwd29PQTBYQnNVVTlSTER5aDNIRlZDeGpDUDdRbmF0T2pP?=
 =?utf-8?B?VnhpTGtIZWZwRXBGZ21SSFpIbEFkQ3BLMUNacm9VOWtiWUxlTVNDMExjb3BB?=
 =?utf-8?B?YmdRNitFVXdRR0NUNWVWMFdQRFVYaTFOSnhQaXJ1ZXoxenlFODRXZFMyNXRE?=
 =?utf-8?B?TnppU0dEQXBWODBqcGh4RGZTZ0ZUWVBqQVAyb25aSlRWUVEwR1E3WU1aL1FL?=
 =?utf-8?B?NFBwVjk0Q2RVc2d4UGRBbzNNbVMwbXpjeit0Q2tWUjdqSk53SkhoNkdla2tn?=
 =?utf-8?B?bUNsMTZGR1R2QVk2L0VTY0kvZE1wREErSUJvaDFZcHJPMDRRSTRQM2ZDYjhD?=
 =?utf-8?B?eGVPUVJDNDNwY051dDFSOXp6ZnRVejV4a2Z6QldoL3FLTno0VlhndWdIUDFq?=
 =?utf-8?B?aXNpN2NMeGh4UXdxc2pNNEhHYy85V1QxdzJDRDU2UDdjeWpkUjJPNGNlOEFH?=
 =?utf-8?B?OW9WaDAxZ0Rva2NlSVl0UGoxQWRab3VnTFNoQ3FRQ0hjYVcxamdTb1pFd0VE?=
 =?utf-8?B?U2FGSGJiTEt3SmFXblF2WjdlNUU3ejl3SE0zbXN2WHplREErRnJhbGx4K1ht?=
 =?utf-8?B?dE1PL2ZzdFNPcXJtSVozaExwMk13ci9TblBweVJsOGRIZ0VUdzZkekFjMS9a?=
 =?utf-8?B?WkpNYU5Dcjl2MUMyR05hMGpaaUd6bzdvOVZnVERoM21ETUhBYXI4NCsxTWs1?=
 =?utf-8?B?Wnk0dWpPWlVjQnZFRDRYZEdOK3NZQWc1RWljNkw4QzF2dVJCQXpzMTl4ZWJI?=
 =?utf-8?B?SHIwdzBTdjhFbk5ITmlQYWNLYjVySmZpZk5IN1F6VTBpYkpueVM5ZGRPbWVi?=
 =?utf-8?B?eTRkUitWUmlMQzYyWUhnYmNaank4b3RCSUlmUW96VklzeHRuWi9zRllLazZB?=
 =?utf-8?B?cVh6K25jQitSMVh5S284VnFCbEMvMHBmQTJCaWl5WDdDRlA3dGV0UC9PK1JQ?=
 =?utf-8?Q?L5QdHKR2c+Rb0LxRzcZuosVsN/po4F9n7H9R8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Tzg3Y0lIVitxOC9ndHVKRjlpanNKV3JoODRPckJiQU1nQUVCVWhZWkNla0tT?=
 =?utf-8?B?clZkaEtMYndDenUrRmpkamhEbjdNQzVGa2pXUDAzNW03azZ3NERNTlhaNmZy?=
 =?utf-8?B?UDh1Ryt3MHFhbCtyM05OM3phR0liN2JOZ3BYU1hDVDU0eVliUDRGYTZodUVy?=
 =?utf-8?B?UzdOR0FCeFFXR3lwbU9JbE85eXYwWlpPTWRESmlPaVBDRlJTMTZOQkJ6NGsr?=
 =?utf-8?B?amdoM3RIOEp0UlZ3ak84bjQxSWMzVWJyMjMyOWdEU2kwZ213MEFZMThKOGdG?=
 =?utf-8?B?U0t4NDRBYjVsWDl2OGx6VXoxZVFhcHlLbU9yOS9idExpbWNDWDJWeDBuT2lz?=
 =?utf-8?B?YXZTYnRsWDIrSmp3UjBXaGJZbEdrS1Qwb3pmUW1STjdGVVFXTXRZUUhjMXZS?=
 =?utf-8?B?YlJsb3pkWXdxR0o1aUl4YlpEdU12SnJINlh4S2ViempCVDZSekZKNVI1UjZu?=
 =?utf-8?B?UTdVb0hyZnh2L21yWGd6V1NuU3BtaTBDUE1nS3BIQ204TVY2aS9ENmNPM05a?=
 =?utf-8?B?RE1lS250UUwwczNPbHc1Ukx2UnJNYlAzNXBubWU3RVFKekpWL3N0U1g5T1F5?=
 =?utf-8?B?d0phaFdhM2pzQ3VaR09QaFBFN3ZXQmdqME05LzNwN0ZtdG1jYnFRYU5EZkpQ?=
 =?utf-8?B?U3RuWHBLcXBJQTJNYkE2cWNLWE9wbWdhQUdNaDBHZ3Y5K2RZSUhRaUVuZ2FP?=
 =?utf-8?B?dC9DUi9RR3JkYzBrbWNHT1g5MXMybHAxMldidTlvU3RmTVlCdEkzbUlrQmg1?=
 =?utf-8?B?UGpnSzhldGtUZGZ1V0JRYVBPSitHT2lKOUtQRW4zRFVjRTNubGtYSURFR280?=
 =?utf-8?B?SjF0ck1mWXlsU05XbkZId0x1M2NneTNaNy9yUUJjdGZENlBaTWZsYU9LZ0ZW?=
 =?utf-8?B?Qlk1WTdhdEFnOUI5SFI1SGZmb21ZTUVUb1BoNmorOWRYWlMwSnNWRUIyMVgv?=
 =?utf-8?B?d3hyb1AyNkJDTmplZjdoOWxEU0dhSTU5WGgzbHE0akg1Zkx1WWdrZlNrNnVO?=
 =?utf-8?B?N2xnM3pVVVpUY3F4emQ3aFp3cnZkekpCczNFaU1vTjgrVlFLd3FEYWVpd1N2?=
 =?utf-8?B?cXpHaEZwblJ4ZXlqV0prTjZMNDJNRjZKNUVlMzFGUCs3K1ZaWGMwV09yL3VV?=
 =?utf-8?B?VHErVVJ1bUYrckMrMXdjSGZhNEdFeEZ3eHRrU0RGK2hpY2lzTmo5QkhPd0Er?=
 =?utf-8?B?Q1ZYUEFXNmlWd21hZjAyc2NBdVp4OEJWZjhTNHNPNkZFa25sL21wbUthb1hC?=
 =?utf-8?B?WUtTaWdRMDE1cXJDeVdyWjd3WnRmekN0TklGT3daKzZGWXhBMGdTNTlFcDdk?=
 =?utf-8?B?WmFNN2VLVFYxRU80ZkF2M0ZLMFRVRUNXRnB3eGhaQVFHQVQvUmUwVnh5TEoy?=
 =?utf-8?B?YUZVa25tTXdkRjhiR2tpVzB5QUZ0YUlDbEdJZzdhNkY2dkIxeUdCb3BTWmRK?=
 =?utf-8?B?c3lMUWw1NXZFMjNwQlJMNWU3RVlXTGhUcEFDWUp2bU1rYzJOTWJPNHZIQm56?=
 =?utf-8?B?SmZkS2xONDJWQWs1RmQzUGlLTXc2KzZDNDQxd3hjTndndkRkektMSk5CNU1M?=
 =?utf-8?B?THV2eVN0RkpiVzV4ZlFCZTlNb24zV0pjbDZweVRwMWw2OXVqUHRjMDVOaGQy?=
 =?utf-8?B?VzNJWkpNVzZBS0pER3F3YlB6RUdJYjFDYW1sWjA1NXFZMEdaeDYzb3lJcHJs?=
 =?utf-8?B?WXNaSFF2YVh1dGdIejJxWlMxWSt2WXh4UnZkam9zbTFIRW9LNHEvcmlCekZK?=
 =?utf-8?B?V2hhN0MyRDdkNXh2OWd2bk1nbmhaQnY5M1N0aFRVcmhXQkVSNk92SmUwaHBx?=
 =?utf-8?B?VlZEV2hFZjY5U0ljd0g5VjBsN1JvNytjM1BaY2tHdjJGQW9xUWREMFJjZSth?=
 =?utf-8?B?czU3dU9NZy9aV1NHbzdabjBmbXJQajZwb0lrQ1piOEh0TTJaODRCWGVaUy83?=
 =?utf-8?B?bGhDdk5XZGpDdVFsK2YyTlpRdEZCbjQ4TzRvVVVsUGZ1N0RlZ3h0U3pkZWFo?=
 =?utf-8?B?N2JQZnpONVZBc0NKRVFISFdtZkdpNk1DMnlGckxKbVoreEhrYzJqQk5IY0FY?=
 =?utf-8?B?SlY3ZUN5aThTZ2pjNElxK21Fbnp3byt6NGlBNjFkeDVRMUQxUDVJam9yNk1B?=
 =?utf-8?B?SHUzd2dQR3dkNWJjVEdoTkdSa2xEYmxxMlRtNlBZdHdFSk82enpRYnJFQ2lC?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E4A2D8517876A41BE0488474C26331C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eImekVW5vMD994QGSKe697jP9q8oyDimko2kCdkGYrl4LjrNTNYBW8IoAz9uwnW3pvA4CDpzrUFE3C69qA+CK7MgUoRtvERQOFGqRwQFK/bXMmfaocr5hjPx6YzplyueMT7HsNQJ2BCV9XyA+pNaQGYIwrUCFby23d+NPjwHAewGrGzR2CM+eV2q/OULz7r5wwaVq5rCx7kXY7mDgOhWZx+27J20YJQSvvuZCSqUkOFt6WVr/0uz6a6SlVbRtBgqgHkbSw2lbb02FuM5BxntH+A/XwFfjN0zgq0m6smsjCmircNf93gTOhCXUTP3CDzdpLPq7UJPvWbZ0TV/6UtULBQg6RG5gvlEg6VRzLxXZmH1XiQt8wMd49N6Vn6qIPNhqJn2XXYQDoUIBwaPu/uhGQSNTv0SFRfklwX672tC4hLo6L6ZvYKM9ymI+lpAu9RzrDSs4TF0T6VVBwRlEHCqtta65KM45G57qzXJW9TUYSKrh39+bjQ3DmsjhaJCIZ4NdHLao6os+IvUgQKPKxu4bwcqx34wB6mZWOmVfl5/UU97gHgcqkauKzpac3iR07sJPhqk04shXK3PItJG2H/jLMHpcAKdNDA1KLsyUeka8PU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806d181a-1e25-40d0-d8d7-08dc8ff18baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 23:51:17.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDLi4LgReklU2eRK+jUHqZc1csHmijbsCX0ZfdzGKTpvUIsA7XyOXkOuAjZiKuEzYdRIONif1d1jC9tVdedDxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6337
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406180174
X-Proofpoint-GUID: Zwch6m95d51fntUTap1hj0E67_w9Ruc_
X-Proofpoint-ORIG-GUID: Zwch6m95d51fntUTap1hj0E67_w9Ruc_

DQoNCj4gT24gSnVuIDE4LCAyMDI0LCBhdCA3OjMz4oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyMDI0LTA2LTE4IGF0IDIzOjI2ICsw
MDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+PiBPbiBKdW4gMTgsIDIwMjQsIGF0
IDc6MTfigK9QTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRlPiB3cm90ZToNCj4+PiANCj4+PiBP
biBXZWQsIDE5IEp1biAyMDI0LCBKZWZmIExheXRvbiB3cm90ZToNCj4+Pj4gT24gVHVlLCAyMDI0
LTA2LTE4IGF0IDE5OjU0ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+Pj4+PiANCj4+
Pj4+IA0KPj4+Pj4+IE9uIEp1biAxOCwgMjAyNCwgYXQgMzo1MOKAr1BNLCBUcm9uZCBNeWtsZWJ1
c3QNCj4+Pj4+PiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+
Pj4+IE9uIFR1ZSwgMjAyNC0wNi0xOCBhdCAxOTozOSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdy
b3RlOg0KPj4+Pj4+PiANCj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBPbiBKdW4gMTgsIDIwMjQsIGF0IDM6
MjnigK9QTSwgVHJvbmQgTXlrbGVidXN0DQo+Pj4+Pj4+PiA8dHJvbmRteUBoYW1tZXJzcGFjZS5j
b20+IHdyb3RlOg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBPbiBUdWUsIDIwMjQtMDYtMTggYXQgMTg6
NDAgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiAN
Cj4+Pj4+Pj4+Pj4gT24gSnVuIDE4LCAyMDI0LCBhdCAyOjMy4oCvUE0sIFRyb25kIE15a2xlYnVz
dA0KPj4+Pj4+Pj4+PiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+
PiANCj4+Pj4+Pj4+Pj4gSSByZWNlbnRseSBiYWNrIHBvcnRlZCBOZWlsJ3MgbHdxIGNvZGUgYW5k
IHN1bnJwYyBzZXJ2ZXINCj4+Pj4+Pj4+Pj4gY2hhbmdlcyB0bw0KPj4+Pj4+Pj4+PiBvdXINCj4+
Pj4+Pj4+Pj4gNS4xNS4xMzAgYmFzZWQga2VybmVsIGluIHRoZSBob3BlIG9mIGltcHJvdmluZyB0
aGUNCj4+Pj4+Pj4+Pj4gcGVyZm9ybWFuY2UNCj4+Pj4+Pj4+Pj4gZm9yDQo+Pj4+Pj4+Pj4+IG91
cg0KPj4+Pj4+Pj4+PiBkYXRhIHNlcnZlcnMuDQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBPdXIg
cGVyZm9ybWFuY2UgdGVhbSByZWNlbnRseSByYW4gYSBmaW8gd29ya2xvYWQgb24gYQ0KPj4+Pj4+
Pj4+PiBjbGllbnQNCj4+Pj4+Pj4+Pj4gdGhhdA0KPj4+Pj4+Pj4+PiB3YXMNCj4+Pj4+Pj4+Pj4g
ZG9pbmcgMTAwJSBORlN2MyByZWFkcyBpbiBPX0RJUkVDVCBtb2RlIG92ZXIgYW4gUkRNQQ0KPj4+
Pj4+Pj4+PiBjb25uZWN0aW9uDQo+Pj4+Pj4+Pj4+IChpbmZpbmliYW5kKSBhZ2FpbnN0IHRoYXQg
cmVzdWx0aW5nIHNlcnZlci4gSSd2ZSBhdHRhY2hlZA0KPj4+Pj4+Pj4+PiB0aGUNCj4+Pj4+Pj4+
Pj4gcmVzdWx0aW5nDQo+Pj4+Pj4+Pj4+IGZsYW1lIGdyYXBoIGZyb20gYSBwZXJmIHByb2ZpbGUg
cnVuIG9uIHRoZSBzZXJ2ZXIgc2lkZS4NCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IElzIGFueW9u
ZSBlbHNlIHNlZWluZyB0aGlzIG1hc3NpdmUgY29udGVudGlvbiBmb3IgdGhlIHNwaW4NCj4+Pj4+
Pj4+Pj4gbG9jaw0KPj4+Pj4+Pj4+PiBpbg0KPj4+Pj4+Pj4+PiBfX2x3cV9kZXF1ZXVlPyBBcyB5
b3UgY2FuIHNlZSwgaXQgYXBwZWFycyB0byBiZSBkd2FyZmluZw0KPj4+Pj4+Pj4+PiBhbGwNCj4+
Pj4+Pj4+Pj4gdGhlDQo+Pj4+Pj4+Pj4+IG90aGVyDQo+Pj4+Pj4+Pj4+IG5mc2QgYWN0aXZpdHkg
b24gdGhlIHN5c3RlbSBpbiBxdWVzdGlvbiBoZXJlLCBiZWluZw0KPj4+Pj4+Pj4+PiByZXNwb25z
aWJsZQ0KPj4+Pj4+Pj4+PiBmb3INCj4+Pj4+Pj4+Pj4gNDUlDQo+Pj4+Pj4+Pj4+IG9mIGFsbCB0
aGUgcGVyZiBoaXRzLg0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IEkgaGF2ZW4ndCBzZWVuIHRoYXQs
IGJ1dCBJJ3ZlIGJlZW4gd29ya2luZyBvbiBvdGhlciBpc3N1ZXMuDQo+Pj4+Pj4+Pj4gDQo+Pj4+
Pj4+Pj4gV2hhdCdzIHRoZSBuZnNkIHRocmVhZCBjb3VudCBvbiB5b3VyIHRlc3Qgc2VydmVyPyBI
YXZlIHlvdQ0KPj4+Pj4+Pj4+IHNlZW4gYSBzaW1pbGFyIGltcGFjdCBvbiA2LjEwIGtlcm5lbHMg
Pw0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiA2NDAga25mc2QgdGhyZWFkcy4gVGhl
IG1hY2hpbmUgd2FzIGEgc3VwZXJtaWNybyAyMDI5QlQtSE5SIHdpdGgNCj4+Pj4+Pj4+IDJ4SW50
ZWwNCj4+Pj4+Pj4+IDYxNTAsIDM4NEdCIG9mIG1lbW9yeSBhbmQgNnhXREMgU044NDAuDQo+Pj4+
Pj4+PiANCj4+Pj4+Pj4+IFVuZm9ydHVuYXRlbHksIHRoZSBtYWNoaW5lIHdhcyBhIGxvYW5lciwg
c28gY2Fubm90IGNvbXBhcmUgdG8NCj4+Pj4+Pj4+IDYuMTAuDQo+Pj4+Pj4+PiBUaGF0J3Mgd2h5
IEkgd2FzIGFza2luZyBpZiBhbnlvbmUgaGFzIHNlZW4gYW55dGhpbmcgc2ltaWxhci4NCj4+Pj4+
Pj4gDQo+Pj4+Pj4+IElmIHRoaXMgc3lzdGVtIGhhZCBtb3JlIHRoYW4gb25lIE5VTUEgbm9kZSwg
dGhlbiB1c2luZw0KPj4+Pj4+PiBzdmMncyAibnVtYSBwb29sIiBtb2RlIG1pZ2h0IGhhdmUgaGVs
cGVkLg0KPj4+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+PiBJbnRlcmVzdGluZy4gSSBoYWQgZm9yZ290
dGVuIGFib3V0IHRoYXQgc2V0dGluZy4NCj4+Pj4+PiANCj4+Pj4+PiBKdXN0IG91dCBvZiBjdXJp
b3NpdHksIGlzIHRoZXJlIGFueSByZWFzb24gd2h5IHdlIG1pZ2h0IG5vdCB3YW50IHRvDQo+Pj4+
Pj4gZGVmYXVsdCB0byB0aGF0IG1vZGUgb24gYSBOVU1BIGVuYWJsZWQgc3lzdGVtPw0KPj4+Pj4g
DQo+Pj4+PiBDYW4ndCB0aGluayBvZiBvbmUgb2ZmIGhhbmQuIE1heWJlIGJhY2sgaW4gdGhlIGRh
eSBpdCB3YXMNCj4+Pj4+IGhhcmQgdG8gdGVsbCB3aGVuIHlvdSB3ZXJlIGFjdHVhbGx5IC9vbi8g
YSBOVU1BIHN5c3RlbS4NCj4+Pj4+IA0KPj4+Pj4gQ29weWluZyBEYXZlIHRvIHNlZSBpZiBoZSBo
YXMgYW55IHJlY29sbGVjdGlvbi4NCj4+Pj4+IA0KPj4+PiANCj4+Pj4gSXQncyBhdCBsZWFzdCBw
YXJ0bHkgYmVjYXVzZSBvZiB0aGUga2x1bmtpbmVzcyBvZiB0aGUgb2xkIHBvb2xfdGhyZWFkcw0K
Pj4+PiBpbnRlcmZhY2U6IFlvdSBoYXZlIHRvIGJyaW5nIHVwIHRoZSBzZXJ2ZXIgZmlyc3QgdXNp
bmcgdGhlICJ0aHJlYWRzIg0KPj4+PiBwcm9jZmlsZSwgYW5kIHRoZW4geW91IGNhbiBhY3R1YWxs
eSBicmluZyB1cCB0aHJlYWRzIGluIHRoZSB2YXJpb3VzDQo+Pj4+IHBvb2xzIHVzaW5nIHBvb2xf
dGhyZWFkcy4NCj4+Pj4gDQo+Pj4+IFNhbWUgZm9yIHNodXRkb3duLiBZb3UgaGF2ZSB0byBicmlu
ZyBkb3duIHRoZSBwb29sX3RocmVhZHMgZmlyc3QgYW5kDQo+Pj4+IHRoZW4geW91IGNhbiBicmlu
ZyBkb3duIHRoZSBmaW5hbCB0aHJlYWQgYW5kIHRoZSByZXN0IG9mIHRoZSBzZXJ2ZXINCj4+Pj4g
d2l0aCBpdC4gV2h5IGl0IHdhcyBkZXNpZ25lZCB0aGlzIHdheSwgSSBoYXZlIE5GQy4NCj4+Pj4g
DQo+Pj4+IFRoZSBuZXcgbmZzZGN0bCB0b29sIGFuZCBuZXRsaW5rIGludGVyZmFjZXMgc2hvdWxk
IG1ha2UgdGhpcyBzaW1wbGVyIGluDQo+Pj4+IHRoZSBmdXR1cmUuIFlvdSdsbCBiZSBhYmxlIHRv
IHNldCB0aGUgcG9vbC1tb2RlIGluIC9ldGMvbmZzLmNvbmYgYW5kDQo+Pj4+IGNvbmZpZ3VyZSBh
IGxpc3Qgb2YgcGVyLXBvb2wgdGhyZWFkIGNvdW50cyBpbiB0aGVyZSB0b28uIE9uY2Ugd2UgaGF2
ZQ0KPj4+PiB0aGF0LCBJIHRoaW5rIHdlJ2xsIGJlIGluIGEgYmV0dGVyIHBvc2l0aW9uIHRvIGNv
bnNpZGVyIGRvaW5nIGl0IGJ5DQo+Pj4+IGRlZmF1bHQuDQo+Pj4+IA0KPj4+PiBFdmVudHVhbGx5
IHdlJ2QgbGlrZSB0byBtYWtlIHRoZSB0aHJlYWQgcG9vcyBkeW5hbWljLCBhdCB3aGljaCBwb2lu
dA0KPj4+PiBtYWtpbmcgdGhhdCB0aGUgZGVmYXVsdCBiZWNvbWVzIG11Y2ggc2ltcGxlciBmcm9t
IGFuIGFkbWluaXN0cmF0aXZlDQo+Pj4+IHN0YW5kcG9pbnQuDQo+Pj4gDQo+Pj4gSSBhZ3JlZSB0
aGF0IGR5bmFtaWMgdGhyZWFkIHBvb2xzIHdpbGwgbWFrZSBudW1hIG1hbmFnZW1lbnQgc2ltcGxl
ci4NCj4+PiBHcmVnIEJhbmtzIGRpZCB0aGUgbnVtYSB3b3JrIGZvciBTR0kgLSBJIHdvbmRlciB3
aGVyZSBoZSBpcyBub3cuICBIZSB3YXMNCj4+PiBhdCBmYXN0bWFpbCAxMCB5ZWFycyBhZ28uLg0K
Pj4gDQo+PiBEYXZlIChjYydkKSBkZXNpZ25lZCBpdCB3aXRoIEdyZWcsIEdyZWcgaW1wbGVtZW50
ZWQgaXQuDQo+PiANCj4+IA0KPj4+IFRoZSBpZGVhIHdhcyB0byBiaW5kIG5ldHdvcmsgaW50ZXJm
YWNlcyB0byBudW1hIG5vZGVzIHdpdGggaW50ZXJydXB0DQo+Pj4gcm91dGluZy4gIFRoZXJlIHdh
cyBubyBleHBlY3RhdGlvbiB0aGF0IHdvcmsgd291bGQgYmUgZGlzdHJpYnV0ZWQgZXZlbmx5DQo+
Pj4gYWNyb3NzIGFsbCBub2Rlcy4gU29tZSBtaWdodCBiZSBkZWRpY2F0ZWQgdG8gbm9uLW5mcyB3
b3JrLiAgU28gdGhlcmUgd2FzDQo+Pj4gZXhwZWN0ZWQgdG8gYmUgbm9uLXRyaXZpYWwgY29uZmln
dXJhdGlvbiBmb3IgYm90aCBJUlEgcm91dGluZyBhbmQNCj4+PiB0aHJlYWRzLXBlci1ub2RlLiAg
SWYgd2UgY2FuIG1ha2UgdGhyZWFkcy1wZXItbm9kZSBkZW1hbmQtYmFzZWQsIHRoZW4NCj4+PiBo
YWxmIHRoZSBwcm9ibGVtIGdvZXMgYXdheS4NCj4+IA0KPj4gTmV0d29yayBkZXZpY2VzIChhbmQg
c3RvcmFnZSBkZXZpY2VzKSBhcmUgYWZmaW5lZCB0byBvbmUNCj4+IE5VTUEgbm9kZS4gSWYgdGhl
IG5mc2QgdGhyZWFkcyBhcmUgbm90IG9uIHRoZSBzYW1lIG5vZGUNCj4+IGFzIHRoZSBuZXR3b3Jr
IGRldmljZSwgdGhlcmUgaXMgYSBzaWduaWZpY2FudCBwZW5hbHR5Lg0KPj4gDQo+PiBJIGhhdmUg
YSB0d28tbm9kZSBzeXN0ZW0gaGVyZSwgYW5kIGl0IHBlcmZvcm1zIGNvbnNpc3RlbnRseQ0KPj4g
d2VsbCB3aGVuIEkgcHV0IGl0IGluIHBvb2wtbW9kZT1udW1hIGFuZCBhZmZpbmUgdGhlIG5ldHdv
cmsNCj4+IGRldmljZSdzIElSUXMgdG8gb25lIG5vZGUuDQo+PiANCj4+IEl0IGV2ZW4gd29ya3Mg
d2l0aCB0d28gbmV0d29yayBkZXZpY2VzIChvbmUgcGVyIG5vZGUpIC0tDQo+PiBlYWNoIGRldmlj
ZSBnZXRzIGl0cyBvd24gc2V0IG9mIG5mc2QgdGhyZWFkcy4NCj4+IA0KPj4gSSBkb24ndCB0aGlu
ayB0aGUgcG9vbF9tb2RlIG5lZWRzIHRvIGJlIGRlbWFuZCBiYXNlZC4gSWYNCj4+IHRoZSBzeXN0
ZW0gaXMgYSBOVU1BIHN5c3RlbSwgaXQgbWFrZXMgc2Vuc2UgdG8gc3BsaXQgdXANCj4+IHRoZSB0
aHJlYWQgcG9vbHMgYW5kIHB1dCBvdXIgcGVuY2lscyBkb3duLiBUaGUgb25seSBvdGhlcg0KPj4g
c3RlcCB0aGF0IGlzIG5lZWRlZCBpcyBwcm9wZXIgSVJRIGFmZmluaXR5IHNldHRpbmdzIGZvcg0K
Pj4gdGhlIG5ldHdvcmsgZGV2aWNlcy4NCj4+IA0KPiANCj4gSGF2aW5nIHRoZW0gYmUgZGVtYW5k
LWJhc2VkIGlzIGEgbmljZS10by1oYXZlLiBSaWdodCBub3csIHlvdSBuZWVkIHRvDQo+IGtub3cg
aG93IG1hbnkgdGhyZWFkIHBvb2xzIChpdCdzIG5vdCBhbHdheXMgdHJpdmlhbCB0byB0ZWxsKSBh
bmQgeW91DQo+IGhhdmUgYW5kIGRlY2lkZSBob3cgbWFueSB0aHJlYWRzIGVhY2ggZ2V0cy4gVGhl
cmUgaXMgc29tZSBjb3N0IHRvDQo+IGdldHRpbmcgdGhhdCB3cm9uZyB0b28uDQoNCkkgbWlzcmVh
ZCBOZWlsJ3Mgc3VnZ2VzdGlvbi4gSSB0aG91Z2h0IGhlIG1lYW50IHRoYXQNCnRoZSBwb29sX21v
ZGUgc2V0dGluZyB3b3VsZCBiZSBkZW1hbmQtYmFzZWQuIEkgZG9uJ3QNCmhhdmUgYSBwcm9ibGVt
IHdpdGggYSBkZW1hbmQtYmFzZWQgdGhyZWFkIGNvdW50LCBhbmQNCnRoZSBkZW1hbmQgc2hvdWxk
IGJlIGVzdGltYXRlZCBwZXIgcG9vbCwgSU1PLg0KDQpUaGUgY3VycmVudCBwb29sX21vZGU9bnVt
YSBzZXR0aW5nIGtub3dzIGhvdyBtYW55DQpwb29scyB0byBzZXQgdXA6IGl0J3MgdGhlIHNhbWUg
bnVtYmVyIGFzIHRoZSB0aGVyZQ0KYXJlIE5VTUEgbm9kZXMgb24gdGhlIHN5c3RlbS4gVGhhdCBw
cm9iYWJseSBzaG91bGQNCm5vdCBiZSBjaGFuZ2VkLiBuZnNkY3RsIGNhbiBsb29rIGF0IHRoZSBw
b29sX21vZGUNCnNldHRpbmcgYW5kIGtub3cgaG93IG1hbnkgcG9vbHMgdGhlcmUgYXJlLCBjYW4n
dCBpdD8NCg0KDQo+IEFuIG9uLWRlbWFuZCB0aHJlYWQgcG9vbCB0YWtlcyBhIGxvdCBvZiB0aGUg
Z3Vlc3N3b3JrIG91dCBvZiB0aGUNCj4gZXF1YXRpb24gKGFzc3VtaW5nIHdlIGNhbiBnZXQgdGhl
IGJlaGF2aW9yIHJpZ2h0LCBvZiBjb3Vyc2UpLg0KPiANCj4+IA0KPj4+IFdlIGNvdWxkIGV2ZW4g
ZGVmYXVsdCB0byBvbmUtdGhyZWFkLXBvb2wtcGVyLUNQVSBpZiB0aGVyZSBhcmUgbW9yZSB0aGFu
DQo+Pj4gWCBjcHVzLi4uLg0KPj4gDQo+PiBJJ3ZlIG5ldmVyIHNlZW4gYSBwZXJmb3JtYW5jZSBp
bXByb3ZlbWVudCBpbiB0aGUgcGVyLWNwdQ0KPj4gcG9vbCBtb2RlLCBmd2l3Lg0KPj4gDQo+PiAN
Cj4+IC0tDQo+PiBDaHVjayBMZXZlcg0KPj4gDQo+PiANCj4gDQo+IC0tIA0KPiBKZWZmIExheXRv
biA8amxheXRvbkBrZXJuZWwub3JnPg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

