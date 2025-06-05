Return-Path: <linux-nfs+bounces-12140-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF2CACF637
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 20:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFCB189DE00
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 18:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC90927A465;
	Thu,  5 Jun 2025 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hh7iOqtr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kGIZOML0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E727A919
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749146977; cv=fail; b=qcHMHdNWPDpxkWX8M3srF4khVtLnz8BctTQVzWKKuLt5Z/KA5puLUT40IoVN9ScAQhjOhg/YK0Ca8uq42iD8o3+1BOFE1cCBRBBd/BaxjF48/6xtcBEISUH/1uYMYUI+HLaL7QRdhKpiT81uoEWRH6tXPpOpu89Y9ZqczWmEmmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749146977; c=relaxed/simple;
	bh=ZExwIJRWHsRgi+EI0OCWP+jy9JGlVooeUsRbVFvuIBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b/J9qU1ftrXWKDn+sEjnC9m5iysbnAd/HjSy4Sl9ZnHWcuMZoIbsvcQX2ukjdKkMaMqZ9DxdSdP7toIKpKg8TWS/WqC0pqDuUhZTH7f/jT09KYZH3sBu7e6DpgMQTL7i8A432tuSyrc9VCaKcc8RfhVnQdYr/VIDb3l+LzBe/tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hh7iOqtr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kGIZOML0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555FtUlW017835;
	Thu, 5 Jun 2025 18:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0I1j8eR+iywdnqJ+m6ldoUuyXlLMxOyAnhirVly+dCs=; b=
	hh7iOqtrxHrH80d6jAXwoZR0JEEX83AYu+HWsdCf/9RgJH3jVvOYcSG2x4zXSd9O
	T+MsW5vxfsarQv+mGaj9fiIAJYmrb6KHBQ5KLQrfTTCiSF/lU/bNl5tMctaqhYj4
	z7mvueuXibsp/exq9P6/We0+8ukCS+vwKJ5vlAhhLPy2nPZqorABd02hxoin8TjG
	F6tx0l39UgKeHa6MReXKO1BTNnhHXS9Sy6tqpXvjHQ7tcm2avP8ZjKoB0mtGOrlC
	9//oRSmB9V/mSpv5LP4cwaFVrulm0swqk3tk2I8PmJ8VCeiO6NxB7CeFwT5FuX4u
	/KxlRKIslDZZWgY/Psh5oQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gahes4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 18:09:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555HJ4Og033839;
	Thu, 5 Jun 2025 18:09:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7cd2hj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 18:09:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpbr2VVmqgE7loaVVUbKLvOfAjvPqCGbkE/yTPT/1bMVQYrA7/RRbhZjCIJWSWrgcfNgzQSRpCtLrfkZiLLuR0YXw07ySRxaS1hi1ep5MGzB4jQQLXAwDaTnL710w3YV8Ub5PRgNtbp/1mA/W5dGwH1TIafCaVJJL5UJZ9vZNANeNIqV77kmRX4mVuuEfNYWV+wo4mbIJo652XGN54zhaPGBSVU2f7GuhvO62hk1/XObM20U0R6aJA6r+UmC6fDNGPC7pwLZQwNeBRDNiDjCnnYaw/boDiz+L1QwNWvmlImIP7CFr5CQ0M0tcBa6wMoAOCAOwKdy9fn19mkcCZDtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0I1j8eR+iywdnqJ+m6ldoUuyXlLMxOyAnhirVly+dCs=;
 b=wAIBXfRvTGaBiXyTPKwTwL2O4B1ByS9Ubvc2jXrJ3DkHBHI/tUsBmU1MzF1qhjw3SWVK/l2acMe1Hc6FlLq5dnyMEnx24GOPvxQJSmSff68HPPuu4a9IGSELZyZWXURD6YLzULEY5RMJPqxqz1F4Yusyzn6pKhXYGa2J5MagZYH9faD5y78ZV2NF7EgWlFHog0GdCjV+NLMrIicHqqN0MDAprSpmRsxw3kyalqYecchSDieDvO7g4/bS82aIcH5uh+HrAESvF6pF6clABx0sR/3rLbVu8U+RJN2IGYMykLr9AxifKjHfIn4tdsUEdJ9OxBVOu64TdK/0ULWRk9PtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0I1j8eR+iywdnqJ+m6ldoUuyXlLMxOyAnhirVly+dCs=;
 b=kGIZOML01kU+XzYxNKC3rqEo695Alc6NTGH7kYKAuC5Bjil5oj5cRbmVF+Ny6VVTQwDMJyC9CHI9FQ3ZdTolNuxXHYZ/lxnKnBdkWrnzhPU0z84ZZlx0b2egGf/zvRi3MX73MawwsNCpLYYy9SK6VtSNij3u2liBCndx4FLlLy8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4690.namprd10.prod.outlook.com (2603:10b6:303:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 18:09:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 18:09:25 +0000
Message-ID: <49fe5097-7622-43f1-a404-4d5e16cbb107@oracle.com>
Date: Thu, 5 Jun 2025 14:09:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Trond Myklebust <trondmy@hammerspace.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "steved@redhat.com" <steved@redhat.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "loghyr@gmail.com" <loghyr@gmail.com>
References: <20250513-master-v1-1-e845fe412715@kernel.org>
 <7bbb789d-b3ae-4258-bebf-40ed87587576@redhat.com>
 <16285c94bc3498fb7a612f62e718ae8a53c42c3c.camel@kernel.org>
 <e6dbb6be-4e58-4d94-8912-05a5eee87ada@redhat.com>
 <c65a34cba5884a0d20fe3a9c9247919e2602fd40.camel@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <c65a34cba5884a0d20fe3a9c9247919e2602fd40.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:610:52::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4690:EE_
X-MS-Office365-Filtering-Correlation-Id: d76a730d-8ff1-4012-5d39-08dda45c1ab8
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cjdKWlh6WUxJcWlkWEd5Z3dTSkg0M3FsNVIzSGl3TjNQSGU2Y0xYRVdCcGFY?=
 =?utf-8?B?WDZMaTUvMGFpeEx0YW5SMzVzZ3V0ajBhRXU5MC83WFlwT3lGTzJ3VnIzOTBl?=
 =?utf-8?B?QkJkWGcwQ2JsNnRPakduOWVxNHlQOHNlZnI5ekJOTUtxTSt4ME5DZnBGdFgx?=
 =?utf-8?B?NG9HVjFIMmxqZVUzUXdscWcxbzg1MER4RkZQUG9jcFJnaXQvdjF3UFZJWE80?=
 =?utf-8?B?WkxZbjY2U08xYks5YUZ0VmxkOGxLL01VUVJzeDlpSzlVMmN2Q2RCd2lIL09C?=
 =?utf-8?B?SHlQRENPNzlBdjFoNmZ4QXdmQlEybFFhSVJGVkJHZ2ZNTkVERFNYcG8ra0pv?=
 =?utf-8?B?WEoxeXQ5TjZUeWN6VjZrclg3dkpzWU5TOFhURjZkcFJyTWZHNVRWaVJxYXhQ?=
 =?utf-8?B?cXhyd3pQMmZwd2NDZmNwd3pmRnBqQ3RrWVdsVUJKL1NCRGhBQ3UveDVGVjVW?=
 =?utf-8?B?SjNCSTAxYnRmak5kU3QwN0U0RjJOcGUybnNYVGMvZC9UMnFXakFIcTRXVXEr?=
 =?utf-8?B?cXQ1ZnNmSG1aYlNranQ0Q0Jxa2hyMU5aRnhlZi8xN1BlTm9YWWYwY2p1MDJG?=
 =?utf-8?B?VENuZzVCalVtVit3UkZCeVl3aVNGS25ydmxSSlQxeHpOWnFXS0JuWml1LzVr?=
 =?utf-8?B?WHQzdTZiMVFYQitjWWpyUmg3VURjM3NpYzNpWnhKeWZ0WXpWWFhRVVJBM3VS?=
 =?utf-8?B?b3pTQllYY3E3M295TlBidTZKY05hYWJLOHJPZGRwSWRFZVhYL21ScVF2dGc4?=
 =?utf-8?B?S1NrY3BzVHVaVGZlZzlnb1l1dlh2TW9kUkd4QUhCSVBXczJ5TncwZ0JtNXF6?=
 =?utf-8?B?UmdncHB3OXNkUC82M05yRFo3a3dpaVZ6K2F6QnU5L05mM3pZMzNtYWw3REU1?=
 =?utf-8?B?NDlVYVF1aVBBM0NUbWxHc0pwa2xRMjhYNjdLT2ZveENMSzZGNlRIRzFBVzc0?=
 =?utf-8?B?bURpUGZ2RFZzZjNoTXFiWCtMbUY0OVV0ME0ybkF0OVFjQVAxOXozV2xIWEN2?=
 =?utf-8?B?ZUdFYkNVRmg3QmRCVk5Gb3pSMUJ2RVdReDFGRkpPaEVFbEw0UjJHc3hKdlp0?=
 =?utf-8?B?U3ZNNndDVFVPaHkvMjFkTjJwekhqbjNWOWpQNU50d2t3MkhvdXd0M0hnMjlB?=
 =?utf-8?B?bnl1UVEyRi9qbHZVMVBqYkJlUEVKOTNja0JmVmVjZ093K2V3Z0JBZjIrdTNY?=
 =?utf-8?B?cldCb0JuU25ERVNvSG81YjAwTHRSZGJDeWNNZlJUa2o2T3grWjBHbE1qUXJ3?=
 =?utf-8?B?aE11NXFkbW9pVXBtWHBnNkZQa3NwZEtHMnZtTDVYeHBmTGtjb0NqK21yeHVa?=
 =?utf-8?B?QmZTNU85cnFzbkN2dFZ5eVdpR2FadlJBd1R6K2hxRmVCRS9HYkMxOGpPSm9X?=
 =?utf-8?B?WlJjVmhaalVVczQ0NXA5TU1YWi9heWdRcERMdTd1VmZVVHVOeG9Ud0JVNnNG?=
 =?utf-8?B?cmpPNFhzN1dPck9vMXdjamt3YWtzNnhDWEp1Um90d0JKeWYzd3lxVHpoeDN3?=
 =?utf-8?B?azBQUEJXTWQyMUNIWXhmU2dBbzd1VHpFRG9YdUhiWklJQTUrMmZqQlNoVklG?=
 =?utf-8?B?R2JxY0FkUHJwd20yRk9yVWEwNmdETHZFekhFUVBWMThOZG1PUlJQT20rQ2RU?=
 =?utf-8?B?OWwranJORHpmYWdUVEJ6TnFEUWtyUXhTQnJ6ZFU0QVh0ZjdibEVlV2xvUHBP?=
 =?utf-8?B?RW5Qdmc1eWRkaVc5K3BkSzhOQ1Y4S2JSYzNsb0JDdnVReXRHQkU4UHlOdHBT?=
 =?utf-8?B?b0FlbjNQMHlHbFRoaVppQitTUmZ5aUlhUjBrZU1sMUZPNVZKV2tHQWM1dnlk?=
 =?utf-8?B?ZW1FUDRnbGVvS2xYWmkrYWZoaGNJOEF4VEFwMmpyNExNa3BRVXFodFp3VlBC?=
 =?utf-8?B?Nkw3ajUxc0FRQ3hUNC94L0dWUFYyald4TDRBU3puTkVnTWI1bzQ5b2d1S3lE?=
 =?utf-8?Q?Pdxc8DxRBj8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RnZxYlNxcG1qN1U0SzliSnRMNW1YS21oNUlUZGN2RjIwMmZKSnBuM1pOZTZy?=
 =?utf-8?B?ZEoyeHVzMnc4bG8wWGNQelY2d2svNGJiOXFvM3E4eFlyTWxBSCs3by81eXpz?=
 =?utf-8?B?Vmw2RjFtREZ2RHBRTC9KZlEwSGEzMThlT1R1Zzg2b1VaMFE1L3dlcWdXNjZv?=
 =?utf-8?B?OFVkM2I0djNTSlVvNGw0ZHlNM1Fza1Zncnc4L29JT3dRM2dwSWsxRnFLSG5J?=
 =?utf-8?B?UUQzdzBoNXJOaXplY2JDYmx6MGJ3b04vNEFkNDRrdWMrNElJYmduTFNvVzJl?=
 =?utf-8?B?Q0NpWGlVYkNJaU9GYTZOZkgrV25mUzZNdCs0WmUwdkQ3ZDd4eWV6Wldkb241?=
 =?utf-8?B?WXNpN3dLZFlWU1dvblExRkhpL2JQWkQ3K3pkQ1cvanM5bm4wbDl1TlE3Mzg2?=
 =?utf-8?B?TVlBK0hMRTNzMU9FUTdBaDRqM1ZTTjBDZGFSV0Vwd1hvWkxoQzZRd01JUFRK?=
 =?utf-8?B?UkRPN3RIbkFENGwxRDEwNTNPNFZaTFhvOFovc3RkSnNWaXNqM2hLMFE0M0lK?=
 =?utf-8?B?TlljZzFjSlJJMVJkK0N5bzJYRUE2clBhalhkK05GWXZxZitHTks4QURoQ1VU?=
 =?utf-8?B?cWZhbEtyK1ZBc1o1UmljZ3NGTU9kVUc1WngyRFJjTWFUTExvS2lJL3lDekhQ?=
 =?utf-8?B?aHVnV1FmZTJ6ZWVweVFxUzlta2U0dlBZWHNlMkVWQnNsdkU1WURFUnQyelpa?=
 =?utf-8?B?ejZJYXhXUVhCUFNxcHMvVXlMODkvK1ArcGt4OWVoMmhMVlRIWXBlRVlNS3Rv?=
 =?utf-8?B?OUprc250R25HSUNWUWkxWWxGUlcwNThjOFNDN1hXSmRRRTlRY3ZHazBORzlR?=
 =?utf-8?B?MWJBSENZOVZ4VlljNnVTaDBXODhxbWZocXFpckJsNGY0MFBrNTBCbDFPWTQv?=
 =?utf-8?B?MDlEM1FhNERZWWltdW9WNThpaklMbHJpUGhBUS8vOGxaV3pubno1ejNmS1lI?=
 =?utf-8?B?b25PQXMzWnRqSG5MR0MrcEl0SFRKc0NiSXZzdWlCNm5Yd09hYVQ3SVpod2xz?=
 =?utf-8?B?TjlEZWlUQVlXSytWOWZQdi9nY3pYN1pac0R1ejFTWVVGdnpoOE9mazRRODF4?=
 =?utf-8?B?M3Jtdmx0SkE1Wm0zSHUvRGozaTZJVnkyRzk1Rk54SG1LZE1IeGhaUldzT3ZI?=
 =?utf-8?B?YzFWMmkwVFI3MjZsbjhpWTBySmtjbktUK2pWYndHQytTTkpOa0hNVk5Yc2sw?=
 =?utf-8?B?RGM2eFdIclNtTXNlSjgyeHQ3YXBQc2l3cDdndXF0Q3MrMkJ4RDZRV25hVklT?=
 =?utf-8?B?Y056MFlET0QzRSs1ZW5KQXNsalJubnNFdzhUajhIMW1pWUJnc1psVVkvZHFj?=
 =?utf-8?B?MSsrWk52ZmtQRVVKRDRDMVMyOVJGUWZnYzhvNmNYK25VMDRnVllZb2owcm9N?=
 =?utf-8?B?emh5ZTJES1U0S1JFWmRNc0dGTS85Mms3eGpiWWM4UzdRRlZGaGhaMGRCamIz?=
 =?utf-8?B?bTVjTjhFblhHTndJT2w4aXVIdWtrZGxNWTJLek5oRk1Fb0Z5S3FoRW9uWUR4?=
 =?utf-8?B?ZzJjVGJFbHZSdnpVRzVqcFZ5YmZIblJTV0tCWEhBZ1BSNU9vUmRJZ0pZdGI3?=
 =?utf-8?B?aWRWcldnZXNUZGQxWlZqbnpoS2Z2TWtkeTR6NSt5d21UVnBMcUVPWk0yWHVB?=
 =?utf-8?B?UFQ0T1EySDJDVnkvNVRtYmFYSnBhQ3ZmRUNwZE81K2JyUHhraEhLeXM3dUY0?=
 =?utf-8?B?NzZHMDhTYWFkZ3B2VXdyeW1qQzN1TjdCUmduRFJFWUk5T2lvWjFIWlNjNWhn?=
 =?utf-8?B?SG5aenA3aDBUYmtxaEQ3YjlWMGhpR1Z4a3I4U1ZJdmJNNHA2a3lCYVVlc2xp?=
 =?utf-8?B?NWxtY1drdFNabmg4MzJhUGVjRisyaWd0U0oxR3pLUGVXNVo2K004a0Z0TnlI?=
 =?utf-8?B?b2hwWENDczcxOXROR0J3Y3ZQWnNidGkwWWxoclE5U21hYlRmRkwyR0l4ejd6?=
 =?utf-8?B?dnlxaXdhREVPTElPN3Q1RlVMVjhKTzBReGYvYW5jcTk5ZTB5aFIrWUNpZGxR?=
 =?utf-8?B?YVlDV09Oa1FaMkMwYVFuSWZpZU9RQnVlbVkrZU1QNnZDWjhXa1VNc2RDc2pl?=
 =?utf-8?B?QnFDNHg3Zys4SkhWajAwcWp6ckRQT3dKOTkvMnBmUUp6RE5Fa3BlaS9IbFRH?=
 =?utf-8?Q?UV6ZCmR1wS8DzceUwzYaO9xMY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ty9M/Lsow5HvpGO1dhe8XSbES1HFVyepiM0U8GrED28jB826SnH9FYwAHlRv1NPcthMUXrGVElcfuO+F+27KmSwd/xE+ar50KnBK3mpn/BxnPrY78J811BhPuXTQe/Mm4J7fONafjkltpS1V+Bo/9RqY4EhN7hbzNs0s0kP8hh4hd0jhdk5auXJQvMuCcEgJez/GPA6mdQG41niHwxOpyymL0RmTwQ5MaegrxFjpzv27DcSYikLyC4XFvM4E4CIG5EIBI3j/Rn/kqy7SGJGY9XmaSzolyXezdYkKydf/xWjYr8YevihM8qmqPbUpRH3TBy6XHhbZh83MkEIs/cvupyekkh6JPHdVp8LaCdiPUi45AHQoCk82gQuljQ2kTOrHbI9RXcUzB7Pv9mrisP6VayXQgrAnSs89oECqBa13AOyL/uzqD2gsdCXtOwXwiCv50P+jjHS5VvVxeA5P8yuG5kEl28ZliuCwwXu4c9yti0G4OJ2QyXYOMDIYxlNQ8aWQiblBYDSlRK1iBdJD7ot5CO0vapYF6RByXRkz0dri/+N7GouiyMaYTfBMBP32X87GC4H9rLhLeQ1qPeve41YgQmANitlNkDfg0BxgUZwPcmM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76a730d-8ff1-4012-5d39-08dda45c1ab8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 18:09:25.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWFpYH0xBFmzXk0+6HbcZSGBcVLlfk/rsl0OEPNC/UYyv52xytYLgN3FbNRMm0vMzJRJdu0yFRmw8WUwNjMR+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050161
X-Authority-Analysis: v=2.4 cv=aqqyCTZV c=1 sm=1 tr=0 ts=6841dd58 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=d0w6K6hC3zuiJQwjwakA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-GUID: 1HGzrNzXkLU49ioGQna_xFiqzqH_R6Va
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE2MSBTYWx0ZWRfX/2YJpEFFiGqv WKVWl7/S89yD05NKAWytdpSZ7FOgzniuCqys5cdUkjwl0A/fdCGj8sDA7ye4C2orzWSK8wRZXL6 l7wurB6Zc21/YNg0CxP398EVUU9gqFF8L8Wr9giBnjIvPZ1lOI8OrQSyDFs31TLb0zH4BA4nmW+
 l+1d341BZYObSkZicgty/6fxjB1Pz/d9/gN/evy4n6tGmei9NcorZgtZk68IpW+ZOQyNnT2SrEs gVAcXPtZGk7RxcH8B4XauY/WWYB9Ow5us8AY2FdIWQoR4At4YMAXX4RnBjdNAFf2C/hSE5vLL3+ WvIKTcwofiWvQ4nUFenM3zfbXjxpxATeHyo+2It8CFjztRH8ygRdnRq5S9U76x2GulCzsSvBI6G
 3rGZYP3FD+DfIQvyXxcu7N4w+jh3vXjpcTi+f02OLdAbayCeFkzBMHPM9ofVC+rv0/PbMr1r
X-Proofpoint-ORIG-GUID: 1HGzrNzXkLU49ioGQna_xFiqzqH_R6Va

On 6/5/25 12:48 PM, Trond Myklebust wrote:
> On Wed, 2025-06-04 at 15:53 -0400, Steve Dickson wrote:
>>
>>
>> On 6/4/25 3:17 PM, Jeff Layton wrote:
>>> On Wed, 2025-06-04 at 14:26 -0400, Steve Dickson wrote:
>>>> Hello all,
>>>>
>>>> On 5/13/25 9:50 AM, Jeff Layton wrote:
>>>>> Back in the 80's someone thought it was a good idea to carve
>>>>> out a set
>>>>> of ports that only privileged users could use. When NFS was
>>>>> originally
>>>>> conceived, Sun made its server require that clients use low
>>>>> ports.
>>>>> Since Linux was following suit with Sun in those days, exportfs
>>>>> has
>>>>> always defaulted to requiring connections from low ports.
>>>>>
>>>>> These days, anyone can be root on their laptop, so limiting
>>>>> connections
>>>>> to low source ports is of little value.
>>>>>
>>>>> Make the default be "insecure" when creating exports.
>>>>>
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>> ---
>>>>> In discussion at the Bake-a-thon, we decided to just go for
>>>>> making
>>>>> "insecure" the default for all exports.
>>>>> ---
>>>>>    support/nfs/exports.c      | 7 +++++--
>>>>>    utils/exportfs/exports.man | 4 ++--
>>>>>    2 files changed, 7 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
>>>>> index
>>>>> 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef
>>>>> 287ca0685af3e70ed0b 100644
>>>>> --- a/support/nfs/exports.c
>>>>> +++ b/support/nfs/exports.c
>>>>> @@ -34,8 +34,11 @@
>>>>>    #include "reexport.h"
>>>>>    #include "nfsd_path.h"
>>>>>    
>>>>> -#define EXPORT_DEFAULT_FLAGS	\
>>>>> - 
>>>>> (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEX
>>>>> P_NOSUBTREECHECK)
>>>>> +#define EXPORT_DEFAULT_FLAGS	(NFSEXP_READONLY |	\
>>>>> +				 NFSEXP_ROOTSQUASH |	\
>>>>> +				 NFSEXP_GATHERED_WRITES |\
>>>>> +				 NFSEXP_NOSUBTREECHECK | \
>>>>> +				 NFSEXP_INSECURE_PORT)
>>>>>    
>>>>>    struct flav_info flav_map[] = {
>>>>>    	{ "krb5",	RPC_AUTH_GSS_KRB5,	1},
>>>>> diff --git a/utils/exportfs/exports.man
>>>>> b/utils/exportfs/exports.man
>>>>> index
>>>>> 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7e
>>>>> b84301c4ec97b14d003 100644
>>>>> --- a/utils/exportfs/exports.man
>>>>> +++ b/utils/exportfs/exports.man
>>>>> @@ -180,8 +180,8 @@ understands the following export options:
>>>>>    .TP
>>>>>    .IR secure
>>>>>    This option requires that requests not using gss originate
>>>>> on an
>>>>> -Internet port less than IPPORT_RESERVED (1024). This option is
>>>>> on by default.
>>>>> -To turn it off, specify
>>>>> +Internet port less than IPPORT_RESERVED (1024). This option is
>>>>> off by default
>>>>> +but can be explicitly disabled by specifying
>>>>>    .IR insecure .
>>>>>    (NOTE: older kernels (before upstream kernel version 4.17)
>>>>> enforced this
>>>>>    requirement on gss requests as well.)
>>>>>
>>>>> ---
>>>>> base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
>>>>> change-id: 20250513-master-89974087bb04
>>>>>
>>>>> Best regards,
>>>> My apologies but I got a bit lost in the fairly large thread
>>>> What as is consensus on this patch? Thumbs up or down.
>>>> Will there be a V2?
>>>>
>>>> I'm wondering what type documentation impact this would
>>>> have on all docs out there that say one has to be root
>>>> to do the mount.
>>>>
>>>> I guess I'm not against the patch but as Neil pointed
>>>> out making things insecure is a different direction
>>>> that the rest of the world is going.
>>>>
>>>> my two cents,
>>>>
>>>>
>>>
>>> Thumbs down for now. Neil argued for a more measured approach to
>>> changing this.
>>>
>>> I started work on a manpage patch for exports(5) but it's not quite
>>> ready yet. I also want to look at converting some manpages to
>>> asciidoc
>>> as we go, to make future updates easier.
>> Sounds like a plan... Thanks!
>>
>> steved.
>>
>>
> 
> Can we please add an explanation to the manpage to let people know why
> this default is set?

That's exactly what Jeff is working on right now.


> It is basically in order to prevent any untrusted Tom, Dick or Harry
> from spinning up a userspace NFS client that spoofs a different user.
> 
> IOW: The assumption is that you should at least be able to trust the
> kernel NFS client to at provide the correct credential for an untrusted
> user.
> If you can't make that assumption, then your server should probably be
> configured to squash any AUTH_SYS credential supplied by this client.


-- 
Chuck Lever

