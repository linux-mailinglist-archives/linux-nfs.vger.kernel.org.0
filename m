Return-Path: <linux-nfs+bounces-10526-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF13A56D01
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Mar 2025 17:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B763B8E53
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Mar 2025 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFF42206BC;
	Fri,  7 Mar 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PIwH61bT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zIT68DSV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578BC194C78
	for <linux-nfs@vger.kernel.org>; Fri,  7 Mar 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363262; cv=fail; b=mL5pEOXvUGd/sn4R7PytIMle6IrclxGXoJhBxUGe5sxeoRDAefvCIhk7NWl/caEMW7C2dFviEUEpIk/fjxBraFmeSxm1cyS8oOMi6uVbYEYmIVPhdlHa3uDBVv0MD+GTkSR21nGallVRpkhs8YdTzsyd1s6VywRjL+DhZFFNABk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363262; c=relaxed/simple;
	bh=iY4e2bY4uE2Wg/BrebJ77J6cPTa9eDKUdZ//rnASowQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PlrVByCrInx21hq+LihjuRvlgWjqC1Uwh02n+8fQhItOc7XtWc66PiIn5UaBw0s7ayGrtxrEuS0d1AWcNLd98MxcqP6zKWQiTcFKHeelBbqhVAkUbYrwKU4D6L9kR7TyeH/MA2vjnDx2OVyxYtMLTiMR4e62QVv12mYh9+pVdJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PIwH61bT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zIT68DSV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527EOH9h000318;
	Fri, 7 Mar 2025 16:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=L9MLK6Vg4I4aso68yoVTuVZ9ldWMxAx7JKlMtYYvYfs=; b=
	PIwH61bTP1XqXSQ2UJJUDPMBIT9ZA3yRyRS5JMcgI/rgcXACrL0CNirjVLhUvgw/
	WZdrgcGK4U3M9zUA/lbCV3qAAAbF6WF+ZCDGwMLTUdiHYzwCvTPLmSwT4z9ugc+C
	UJpYBPbex0KYayEMpK70hoICRvVmW8y0J7nP38fJhPBKFzqCP4fcnAetWKnmOtOg
	7nZbUD76b9gMTI93XCOQfmLTjSUwYuR43F50bVvikJDw8QYOVa8Cyf399jD5lQJH
	kK05IoMKKJLuR2Y9MEXWADodZQCrJcdoQRzC/meluok7A64kdRI6XKzxU/fidtCB
	CvLcHhokSLAyxPG/l749JQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86vewh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 16:00:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527F9hwM038319;
	Fri, 7 Mar 2025 16:00:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpkyn7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 16:00:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmiC8yJ65RiOA99y/d2ku4AdiXxUCYQ3E4lfE+reMDY52mk1J3sml/jRptrUDdMTOYrrhOxxIPXYqweZmAa0bX3+eV9ckvZXY8SsY+/nKmKWYUefBkCygwZZkxpPpG8oYs5GOedJh2ez5XXKXIFLRpSi0JSlJUUYADWiOzAcn6XjkQt8iN23MCu4C7UJTbP3+PkYb2kSf/jybGwvFjiTNu1j5ix2jswM3P0K+0IQLm1DtDKXRR1bTbottvUGjGUOt8NlqpZPpzLZkexaExzODk21k+5JBJolE5E5qAHaTrOArDadxzkLbXouEvkg8sBJ4JHINThUec/f/KhWgpwmhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9MLK6Vg4I4aso68yoVTuVZ9ldWMxAx7JKlMtYYvYfs=;
 b=ne8rmqV5BinmolaBYLtpZ5fJz2pjXZDeimNYwoNqNdG+hJyYzvXBzkn8lHOzHEtGKecQOQjz44Q0o8jVYK9ba8G7puMzI0UON8LAsjW7zpHwVKafbjrCmFvRjOAllalZZb/5KaFflY3lZjYv7G8K5n5my4p+IyTEZIiJA69KtZQX0xxWz6RSWnnFe58dkByW4mr5WfJ3f5vBEu0XKuT2qh4y6F0gb4EJjhyffDFABrlzNgvo/3FeFmfHp3MI/cW2tPdltKjxCSj0xzQXCnCK9+5R9pcAriy/l2ASF8a0p3B284m6DH4RAi5BMoLNAZrxJSo++/yrxJgH2xaxCF5LQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9MLK6Vg4I4aso68yoVTuVZ9ldWMxAx7JKlMtYYvYfs=;
 b=zIT68DSVBLB/CxjEhqEv9pQNVhjjcSURbkacUC9qJ8EzDWW8d2hVINYdwU2SvjCYx3TCK6HGaQ2h1RDYjC8xLECK74jxbe6FD5KJ2Wa4MX6dDc3nQoziQmFkTGCnYduRksJFlFkv2xUZVRM1XjBehqw/zVZWduSMf4PMA/kkDCc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6882.namprd10.prod.outlook.com (2603:10b6:610:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 16:00:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 16:00:47 +0000
Message-ID: <2c7f1ac9-5715-48e5-80e6-61b8fd856e4a@oracle.com>
Date: Fri, 7 Mar 2025 11:00:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Implement referring call lists for CB_OFFLOAD
To: Jeff Layton <jlayton@kernel.org>, cel@kernel.org,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
References: <20250301183151.11362-1-cel@kernel.org>
 <f267eca114234a96260cdc546083853d3ef1d7a0.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <f267eca114234a96260cdc546083853d3ef1d7a0.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:610:b3::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f9b770-0a72-404f-fcf3-08dd5d91397e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WU5EZzZWcmw5dGtrMFhPMHZMOUlLZitCTXcvd3djbWU4dmJjUDh5Qzd2N2w1?=
 =?utf-8?B?azI5R0dqdEliMktCbEFZb1F6ZWtLWkU0bVUyVVRFbTlZVEowOFV3YUc2d2NK?=
 =?utf-8?B?bmwzcmdBTUFxQnVMVFZzNTZ3U3lwU1VnK09uLzNKQStNd3JZRW1xN0w4OWdv?=
 =?utf-8?B?RmNTUHdtaUJWQURiSUtTcmp2UEd5bUdQNGI2SFN4UHVGcU56QVp4OUpkdDdn?=
 =?utf-8?B?L3NwQ3lFWUJjYXY1QUpiSUVxL0NoY013N3F5Q0ppRUhxQ3pha3NsMDJvTUhG?=
 =?utf-8?B?QlF0bytlOERQQ1hiTzJtNC8vVGJxRlR5K0F5cDI0c1NDazRKMFNHMlFscWFN?=
 =?utf-8?B?QlhHRWVWcTRYeXR0TUg5cEhFd0lROXRyckZIUHZ5ZzFZaG5CajhaWnBwckpt?=
 =?utf-8?B?bzBkblV5MFc0dTFQakhYVWpoSU9rOThEUFhTSkViZFFVTXp4QWRROGVxWHpY?=
 =?utf-8?B?RkJxQWowZVgzN1o2QStkRWJjb29wOEsvbkhqSDVoMmNlUVdCcS9TRkxCUUZt?=
 =?utf-8?B?czNrYStva2VFU1NMbmNrbFV3MXhkZHlQWHlOaDVHZ09TU0E0WTNlMzR1YTg0?=
 =?utf-8?B?LzFBbGc3M0pKTWhjdzY4U0pjbzZCalgxTXhDNzV4VTZYVlc2MGdFQUt6Q2VE?=
 =?utf-8?B?eVBqOFU5QmsvL2hUMUNQdmEzb2w0ZlpKVG9heHRwTURvbGtSMHJidnZKVHIw?=
 =?utf-8?B?RURmd0V3cCtXZ2h0c3B0NHRPSnE4VUg4dFhEYjh2WkhIcnJTWmdnSzVVeitl?=
 =?utf-8?B?WFZPRXRwZjlpK0R3TmtDcWR1Vnp5S0hDSkxaRi9zU0JTNGtlclh1NDg3UFhK?=
 =?utf-8?B?cklwbjV1SzJOa0MzbmlBM1doQzFqc0tiUi9reVFsMkh6WW5jZlZoRUFNODF6?=
 =?utf-8?B?cHAyV0t5cUVZYVhWY3FrUFAzcnJNR09zV245VVRCaDRMM0FubGwxYnZ4a2Zu?=
 =?utf-8?B?cnRNVHFtSDdYL1pUY3lSQmtlclRCekFEZkpOWXZuK3RGUFAwdmptR3pJY0U2?=
 =?utf-8?B?TThQbXR6Qk4yWFQza2ZwbkY4UmowMUJ2c0FkYkNDdHlHOEVVaDZqY2ZWYnNi?=
 =?utf-8?B?R3Yrc2t0ZGdrenc1S1k1ZkQreXBvenROYzJCK3VMWW8wd1B5elRqN2lONVdD?=
 =?utf-8?B?c25uYkJ1bEtFUWpoMWE5NVh2enlTazFVN2hycFphdXBsakJRSklTbGFxYUxE?=
 =?utf-8?B?YjJqbnh3VVhaR3hpWEJPSUt1T2JKUlVwdlZQLytxNHQvKy9ETGR5d3QxNlVt?=
 =?utf-8?B?YmsvZFE4eFR3VVZ1ZDh0anBHVkpmZnN1cGpxRE1tK044VTR2cDV0RTBHQkNY?=
 =?utf-8?B?Tjk5bFBVS2xNYUxacGp3eVNjdkdoWWtRYXREbGVYbE9LMzFyZTUzdUt5TnJm?=
 =?utf-8?B?alhnOEhIK2x2dmMzc21yRUJsdlN3UFNEc29lblN0Zm1PMnlpeXcwNEFQbU10?=
 =?utf-8?B?SyttYi9INkdkQ013eFBWM3JSN2NLdlJYMytFYm55SC9mWVpTSFYwRTJ5SG9p?=
 =?utf-8?B?VjVGL2FvTFpOa3NXaFpBeXQ5SlVqZmdZMC9OZ0w0STA1VVBpV0twR0JwK05j?=
 =?utf-8?B?MUdvZk5WU0dPOHcrU0lQOFZSL3FBWWFmdUhkUnFGdFMzZ3hUNTZsK0VNQWtx?=
 =?utf-8?B?c3dNRk5UM1ZCQk9qbWlsemhCT2VDaW1SaXR1eEdQNmxSVG56Rm1HeWNITVlP?=
 =?utf-8?B?eVcyUWRIOWJwWDB2RDZqc0RyTTBFaDRZM2tPVFQrdXpYdUZPanlzNjI3bzdr?=
 =?utf-8?B?OVgvVlJCa1JNaDlnWUpvcnZZSXV0aHprdGd3VWtYeHFJOHpzbW82NjBnZm9K?=
 =?utf-8?B?MVUrdzFsUmVDeS9NY0dpTVkvSlJjUGk3cGp5eVdxWkxTcGp5Z05td1dCZ0I1?=
 =?utf-8?Q?KRfuipwZNRZNX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTUxTkU5RVBPWVU2ZjlzNTF6Tk5sb1BwWnRyek55NG9aTTlXMGpZZlNLem9C?=
 =?utf-8?B?a3FldFhpMm9WV2huNUNyRHdLMkUycFEvWUxSQVlyRDdrYVQyakpPdFBWK0th?=
 =?utf-8?B?TlFTMkhUNFVXV0N2RDZMOGZtTVlOVmxHYVJvaWZTN3ZuSWFTQzNsOC9FL2VU?=
 =?utf-8?B?OXJjc0NUa3FjZytGaStIOUd0czFjSDlSVzhENG5MMjlFYW90eFNYcWdDQ2VS?=
 =?utf-8?B?RnB3aTZOQkdEaWhjNWMwOTBTNjZtcStSNzN6Y1pCWnl2TTRPWDBHR3A3UkxS?=
 =?utf-8?B?NTFUMjh0ZTlaelRWM3VLNWZCa3ZUb0tqam42YzA0NDJqU1cvL0pxaURXSS9U?=
 =?utf-8?B?N1RNSUZrM1BCUlJkYXdpOGJ3d1I0QUZwYjVKTUovenNDTDBGNDdpajBaYXBM?=
 =?utf-8?B?aDlDRThEaU9Hb2lRUFpYUkJNdUVQM3RaeU1EcjZ4S0dPRnJVUWZBMUZDMU5v?=
 =?utf-8?B?NWlERnRib1RkNEFqSUFiU0Y5Rm9HMTI0VUczaG15bzhob1pRL0g3NGRTTUpj?=
 =?utf-8?B?TUY5UFJ3c2JERnB3d2RVSjljeWV3OTA4a2pkN3N0UVl0SFpma0MxWTl6WjBw?=
 =?utf-8?B?M0RYbjZ2S3BQU0ZLazdFTXNKTlZYU2pDVUNMZGdXODdzYjE2TXJZSTJ0bDRx?=
 =?utf-8?B?U1JLUkdLNHU3THNhaGdLbUFXVXVLcW9udVRHTHZ3N2h4ZHdVQzR6NWNzYlZn?=
 =?utf-8?B?RFd3YXEzTERNRDVmM3liQ2d1MXV3WVdMd1h6c2kxWXE3Q3NWaHU1ejJqNGli?=
 =?utf-8?B?aFpDWlVOZHBKRk5mYWlZaW43SUlTVk5XTmllWFhLZUdKY0d3bmpxQXJMMGxv?=
 =?utf-8?B?emVRRVppaHF4SkxRWC9Mb0ZCS3ZvQ25TbXdhZXV4WDRQMkRFZysyRVYvemt0?=
 =?utf-8?B?K3JSTXFGeWw0TG43Q0wwRGZzcmNDeEZnZFJnaXM5d21CaTQydy9sTm5FT0s0?=
 =?utf-8?B?U1haVHFzdXlrQ1grcjBVU204YWMxYkMyTE0vWnA2S2FvL3RPTzV4RnF4bUll?=
 =?utf-8?B?YXhvNEljdTlmb28zQk5Mejh3emRSQXpRWjM3eUxEQi9lZWROUm5pYXU1TmtK?=
 =?utf-8?B?dzlOc1JHOVhSTnFTdGhGaTFmRHoxTmU1RktCTVV5c2VqT05hTFh0NVRMV0dK?=
 =?utf-8?B?Z01GcStQejFTVlcwUjl2MWg2YVZSSHpubGo3RS9KeEFSVDNiWnYvb2kvNUNz?=
 =?utf-8?B?NVhZS0RuUEF0NWRWTitRL21JbCtPZDR0WGlKWFAzbEVWQXFBbW4wUHZiWXoz?=
 =?utf-8?B?SjM1dW9kRWx5bWJic3RSZlB4b2gvVmFrMHp0eXVFdWhrRW4zdjVIU3ZiVnVt?=
 =?utf-8?B?eTFkMkk0amFmRDVmSmE2NjNuRDdCS3lXVTJWNE5sSmhJT0tualpBaUhnWFhE?=
 =?utf-8?B?cnFocFVyYjZsb2VLMHg5OVhscXI5SytjZ2tiKzAxYzdVaFJ4bisrWXhGUU5L?=
 =?utf-8?B?dnpaTjJ2dEZDYnRaaWYvZlNWMnpOOU1BWGJFZEJQNUtBYjV3Zk1hTTdRQnVo?=
 =?utf-8?B?MnNudVZROFBuelpwOU5yMDFmTElLaGV5MWFmZmttdWEvQktYYmcxMnh3Y0xo?=
 =?utf-8?B?OGZ0VnVoYkJsWno3VzhYcEFHTTdZRlIrOXBvNGRRUVJZUk5xUzdyTUl4VzR6?=
 =?utf-8?B?TTFJMTlkcFJPS1BVQjJ2V1NkWUFjb2FQdERLdDZjOXV4V1JPTTFyb09GRjNW?=
 =?utf-8?B?M0Y0YW96WWNSUWptZW4wZXFsNmNZOXEwMm5KL3J5TWRlOUxKYmJreERhUGJI?=
 =?utf-8?B?VnZjUWt0N0pTZ0RsRTJVczRRRHpIODZySnR1Qkc1Q3pTRlNiNDc4eHZjLys2?=
 =?utf-8?B?L2tKeEMyMTVzQWpmSCt6MDRib3ZqMXFwcnNDeXpsdGdNWFMwVWdpN3FQbXhx?=
 =?utf-8?B?V2hCcVF5TnZpYVZoWVlVQndHZlF4SUtRVVJCdGttUzU3cEJ5SU1TQnZtMlRo?=
 =?utf-8?B?cUNVb2hqR0kzKy9Ibmt0aFFCVzMzOFcrWjU0T2cxYXovaEI5akJLNUJZSFh1?=
 =?utf-8?B?dUUycXZadGd0aFdJQXUrZDhvb2dQWDFaUkJ6cWlxNVlxR0lrTkppL2tuMUVj?=
 =?utf-8?B?akdQTGJjTjNBZFhWblFqSGN4SS9QL3J0ZVMvdHpFNkdtblJMbElwRGd0U3Fo?=
 =?utf-8?B?UXhnRW1NODl2cE1UUlA4SEUwR3BTZnFwcUdIUmkzUHd6bm55Ym5CNVBtbndN?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yjCKAGb18VkBDwmH3hLYI6GG1q3mxZDPPJbLCDq1L0M/7YIFBS3KUOiFPifrGegj39pvBEOn/sPySDg6Zy47LMGdEqD+ZbEe82yvMgKHkZ3//jAhm89mxTxiOJSmqtqZHFOlGSd+IVME0ceWmn6T4JqZDI7zDbXFuR8YJEf8Fv+mzgtk/SgBXOIO9taWSgul5P4k1f5OxU+VQRKS3zkkPWshu3UT2pVv66OQGVY0BNwenTdhRgUAH17rwBw8b2cwlNRFWIQZwyjwebNUrdBgp/4at2FVC5uTdb1PVsBy8p6ctznLAVqjOXt9TehlbnnjnmweDjB7kswZY3l4wosp6hMQ9E1NU1zIpHH6towJx1LLS7GUejsClLbxFJUdRGGnEOoH/mzM5I9N1EIiRDTaEw4O04PZBM0f4JVs2/c5Qpr2fLkJ5eSPnDAhotg2al4WDfTLmSK/JU6qZ9bMh/Ofp7LFXOKbNRJWc4h6qo3Iitveeo0LNuXMpfNRTaXiFexzG2OE9nHxmDp6SgHkgM7oWzWSepU6LXR3ik+egwuD46PPRA7/H/EZNEXpRPaaMTIB0UagNIc3fSYKdBLJoKiDtPaefUYVVDou0RifEf8ZPs0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f9b770-0a72-404f-fcf3-08dd5d91397e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 16:00:47.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYIKEBHCB8LdnDzt5jF+J4yzLuEi9xugo4y1f7yA2Ipee3i9raUD7y1KuSxS5WyrOVHZnoGhDgy+rKnuXF5V9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070118
X-Proofpoint-ORIG-GUID: RNWtEPHQW4l8D7GhzmCUkRYtsgIuGY0b
X-Proofpoint-GUID: RNWtEPHQW4l8D7GhzmCUkRYtsgIuGY0b

On 3/7/25 10:00 AM, Jeff Layton wrote:
> On Sat, 2025-03-01 at 13:31 -0500, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> I've built a naive proof-of-concept of the csa_referring_call_list
>> argument of the CB_SEQUENCE operation, and hooked it up for the
>> CB_OFFLOAD callback operation.
>>
>> This has been pushed to my kernel.org "fix-async-copy" branch for
>> folks to play around with.
>>
>> I've done some basic testing with a server that ensures the
>> CB_OFFLOAD callback is sent before the COPY reply, while running a
>> network capture. Operation appears correct, Wireshark is happy
>> with the construction of the XDR, and the CB_SEQUENCE arguments
>> match the SEQUENCE operation in the COPY COMPOUND.
>>
>> I'd like to include this series in nfsd-testing.
>>
>> Changes since RFC:
>> - Add a field to struct nfsd4_slot that records its table index
>> - Include a few additional COPY-related fixes
>> - Some operational testing has been done
>>
>> Chuck Lever (5):
>>   NFSD: OFFLOAD_CANCEL should mark an async COPY as completed
>>   NFSD: Shorten CB_OFFLOAD response to NFS4ERR_DELAY
>>   NFSD: Implement CB_SEQUENCE referring call lists
>>   NFSD: Record each NFSv4 call's session slot index
>>   NFSD: Use a referring call list for CB_OFFLOAD
>>
>>  fs/nfsd/nfs4callback.c | 132 +++++++++++++++++++++++++++++++++++++++--
>>  fs/nfsd/nfs4proc.c     |  16 ++++-
>>  fs/nfsd/nfs4state.c    |  38 ++++++------
>>  fs/nfsd/state.h        |  23 +++++++
>>  fs/nfsd/xdr4.h         |   4 ++
>>  fs/nfsd/xdr4cb.h       |   5 +-
>>  6 files changed, 193 insertions(+), 25 deletions(-)
>>
> 
> I think this all looks good for a first pass, and should be OK for
> COPY. You can add:
> 
> 
>     Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks!


> I think we'll eventually want this for longer-lived stateids too.
> Specifically:
> 
>     CB_RECALL
>     CB_LAYOUTRECALL
>     CB_NOTIFY_LOCK
> 
> The main thing missing for that is the ability to free referring call
> records once we ensure that the client has seen the reply. For
> instance, if nfsd records a referring call on slot:seq 1:2, then once
> it sees a SEQUENCE for 1:3, then it doesn't need to keep around the
> referring call for 1:2. The server knows that call is no longer in
> flight so it's no longer needed.
> 
> If we don't do that, then we could end up with rather long referring
> call lists, with a bunch of long-completed calls.

Agreed that RCLs will have uses outside of COPY. I don't have a good
understanding of the use cases you mention above, so it would delay
RCL support in CB_OFFLOAD quite a bit if we were to wait for the
implementation of the other use cases.


-- 
Chuck Lever

