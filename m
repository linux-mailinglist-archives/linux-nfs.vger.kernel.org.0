Return-Path: <linux-nfs+bounces-10697-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C40EA6993B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 20:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855FC981746
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 19:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3F421ABD1;
	Wed, 19 Mar 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LiTvN+5k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JXG8YW0y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631621A44B
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412294; cv=fail; b=RF1dmJmDokYb1hpaFfxkgZHgbuy2u7UJxTRRDU4eQppdmohxKs3r01DO2XglZGVXS7e74U920Qk7x4icGk3doTFvbtFiRBonFiUrH4XVAEV61uxGdCsBDVN7TvXzprA9gWLXE1GECy3RDKSVlcnnpcTyhdeVp72UCG/RXX+4AVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412294; c=relaxed/simple;
	bh=ERU24L14F5B4nx3H2My8LbM/egqCicicRoP57UTo68I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ASw++Lf745KYvY6pGhTX3XmZQxfqe0f26P5MqorTEFF+NlUIxvbqx+h4aN2/NPlbDUZfh79gqP7ZclCG7/Aa1pQB3w3mcbSzrp0fTfOv+L4BpcRI/c4oZ/q4LOvMvPE5RGTrngGR96uXrtmWLdsPTT4qMUZ8jgU2dvE3JM6NBx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LiTvN+5k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JXG8YW0y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JItj2R003023;
	Wed, 19 Mar 2025 19:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bVeQNRdxA6cmPPGl4lg7t5h2kbk/bzq7iUT1GabzAvE=; b=
	LiTvN+5kJ+OEtTHEf9m1DNbOH7IwMRjGHKXlzeatG+sshjgNk7LSCEXAWDlHQFUu
	sSHfsx+D9en9Fszyj3wsBMQLIjwpELb+XrbeCIVlPCGj6szcLrlMeKFVrYRNKJSm
	bGqyQHK+78F3Q/8ZozEApaeMbsmNVBuVB/bfuYDsilWn4wpv2XqWMYZ4a1lvWT/F
	bimx6YmcTgVhPcXQ41VS+GqHD2sjT5XILDHFrTVYp/7wLsxH6+89XjcA+SgUmMVG
	F55ff3zvNmT489J4GfC4Z0lvsnnNBkfsqHLanYQvYGEIp7ItViNPKHgwQoqX32j8
	sVlmPIq2IUw1v1N+KfgwhA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m3utd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 19:24:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52JIUP3v004604;
	Wed, 19 Mar 2025 19:24:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ftmw0cya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 19:24:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIL1hFqtQbamedoHfEPWZ4kLEDYl0+7L4iTi4ZlWoasSHZVj1IeHOSTlzhhoV8yZhe6CDh2O05NndGaoEm41aJOaPWlPNiiRf9Nfffel5/cBhfzjNxhhb735Xk3gIC4r3ZGKsO4fKWdNVYjiG2AStje4GAILgYS9NeXj8+2GkdlBN4dukQXvB7eF2AlsvF2DNNy2xXzMft6MsWEtGeMnJ7xpCWGELGnnBFUJcbwru85+25htZT5z/M6nea4lB0gvPYr+leA0X864bxg859OfPP54lCNEqIOSzcY7xPKIotr2uq7JNCBmjkQUaVXhQXeN0ky9bC5MN8+xEjJcwCSFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVeQNRdxA6cmPPGl4lg7t5h2kbk/bzq7iUT1GabzAvE=;
 b=bJED1Rg8VpAJoyXvEIYfUDe+XRlzXkNQL2FwXgvOrSy+xr7cgS6dq/Att5vZ4BegRYuGUBPl9cFUJgZpbxP+qX40uwDkfXQ9FqN+myY06+GwGfoDPOTfq45IXWOkbwRdeOsGzTRG2mmy4enH3dkEEyR9I4LSpZ7xZBs25fNNJmDxrYuj/6qYSJRxwKKOsjRvRhyen0N5YEe/5zCKqQALygce7NB0IBfMqH+gn0buZ2lQ59ybAtLftor+aG+Rf7QyW0/OPKSd8vTESfCNeNBLXssTCQHzZd5TNVYQ8XaDAaij0O+bzq9CRTdNpYsKLWbJISC/+kO1vlcSDo/2xUGo1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVeQNRdxA6cmPPGl4lg7t5h2kbk/bzq7iUT1GabzAvE=;
 b=JXG8YW0yId8UsDQ8jGV1Ay92owDFxgm+P81hJYaHR+MIxQ5ZkOzJEOx6C5G39admVLTPqauHUOrY2vTsFoJJr6W0UkHa3tj77+J3cdoak34SwzJ6Y/6o0Q+Z23ku9NOF3aNtLvCFG7KkmN7xDZSMqTcHP5DQW5dg+bayXTeXThw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6293.namprd10.prod.outlook.com (2603:10b6:806:250::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:24:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 19:24:09 +0000
Message-ID: <e2b24cc2-c135-43d2-8c21-8bb59a723c5c@oracle.com>
Date: Wed, 19 Mar 2025 15:24:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
 <37313734-890a-4ab6-a2f8-0ee5668c1298@oracle.com>
 <ba129a50-a4cc-4294-94bb-c75b13454e47@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ba129a50-a4cc-4294-94bb-c75b13454e47@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:610:4d::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c43035-82f6-43e9-3f71-08dd671b9f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzRwditSMmJyQjNTaTNWS01WN2hvbWpNekVJblA5TDFMOHlsMVFNdVRIVVZ2?=
 =?utf-8?B?SHhOUG1yTVZZcXJlQWFuSEt4SStjdVl2U2dkckZZd0wzZm9NY01ZRVBLa1RD?=
 =?utf-8?B?a2J6SG9lSGZKVmEwUncwNUwzQW9Pck1vaStmUWJ2cTZ5RFhKVUo2ZDZBcFdu?=
 =?utf-8?B?dmN0cWV2ZFNNd0NCZjlDVXFyaFFnTURCUng5anZlTDdWK2x4QVdhYmJHNlBJ?=
 =?utf-8?B?c0FoM0E5dzA1bnNqQVZlUWs5SmZjMXpaRWoyb2xjN1NnYTRFVytWclh0UnFK?=
 =?utf-8?B?Mm1WVmUvbVNCUkxnNHRobm9rWlhiQm9aTHJxUVpwbjB6NE4xczFCdVdTdk5W?=
 =?utf-8?B?WGhJRURjYnJYTnR4MFo0bXNkbElDaUZtSFdtdFRla1J6cWRpaTREdDduUGQx?=
 =?utf-8?B?cVlRSzc0S0hkUG5IbGEvL2VFblFVem1wTUhFNjIwVWluK3R0MjFUV0J1ZE04?=
 =?utf-8?B?WG1HVHkvU0pIYUk4b0ZpN1hhbzRiL3FLQ1ZodVJaek9TMGpsVHkzM09ydXEr?=
 =?utf-8?B?aGVNRnFjQk5oWjlXK2RWNjFNV1plSm1XNjZrZ1p4YzdKdjZKTGFCWVFza1B4?=
 =?utf-8?B?Z28zeEJUd3ZQOWdZYU1CbElUZXRvWVlzN2VTMlROQzJOUFlvSDNRRkQrRTE1?=
 =?utf-8?B?Q1NqRkw5cWNQZmtpbU5Sc1pBY1g0cG9DbFBnQ1pGcFA3V2dKVEN2eG90WUpi?=
 =?utf-8?B?UTBXL3E3MVdYcWRYd1VMM2h1aHNQVW5iQVp4dmNWWTJEbExMQ1EveDlLWmEr?=
 =?utf-8?B?ckU3OWdSNXN6QnhsU3U2Z3FzSGtBL0k4cVFZc1BmQnRWbFpWUmFZdWN5emxU?=
 =?utf-8?B?a0gxL2l4UjQxNk9BOWozVGtVbVNhNU5UTG9nSUV3REY0VDBGdUpCci9NWFFN?=
 =?utf-8?B?OFRBTkxETytqU3JOUWdxK0tmQzJtTjd4ZlBKZW15YWZ4NkpnVEtPMXlPQ1B5?=
 =?utf-8?B?clhYQlBhL3dJRkNzZ3FjUXE1cVV1TkFXUFgwTVdlRnZaekFHbHU2S1BWUmR0?=
 =?utf-8?B?ZTY2N0sySklnY0lKRzhSSTh2bnZWZWlYVmNKeTE0R1JodnRlOHJnRTRmNU8r?=
 =?utf-8?B?M2tucjArWGxyVmIrSy90ZUw4QnJtdzlmU1lmZW5ldlFWRUJHZ1JsdWVSRDRa?=
 =?utf-8?B?L2NLcEtmMlVGZ2xUNkJINkJsc3JYTTRTYkxYZ1poWUhKbzZ6bkxXZVdXWGpP?=
 =?utf-8?B?RWpkdi9GSzJsbjIyZ1hmMkxwMkNWSVV3RVd6OTRucCtrMENOVlcrZjRpemxG?=
 =?utf-8?B?RWc1aDlUdFNSQkJaMnp0NloxL2JPQmtSWmY3VVBWR2N0MEd0NmZOc0pyWTVS?=
 =?utf-8?B?d1RLKy9xZnBwV1RaU25qaVdMQWVZT2VHamtTejJ4cmNwNjdWU1hNUWx2bVk1?=
 =?utf-8?B?bXFCYkZ6ZjVFUE1DSlp0RE5pa1pVa2ZwSE0wYlZFR040ekNSUGVMVjhJeDBT?=
 =?utf-8?B?a3lrSFFxTUtBSkl6clpaMzk0WjZiWitjeFc1TXp4N2s2TzB6eisvNWw0dmE2?=
 =?utf-8?B?c3VWOGRCL09pMENTQ2k4dlg2K1JocjVPN2ZoV3FrZ2VpRWY5ejFzTDBwbjRX?=
 =?utf-8?B?NEFnbVVNbmVWTTJyTko2anNScTFXTUwrMHBVYU53R3pYM0MweGJaL1JkdmlY?=
 =?utf-8?B?TnVKblUrRDQ4WDAvME9PZDN2MGpraDFHbjlRemVnQnM5SEhXM3d1VUNnTTBk?=
 =?utf-8?B?ZG1qTGZGSDlCOEhxT0dINGFJZk1GZ1p5ZmRMREFCZFB0ZlRpdjRhdWI1MUo1?=
 =?utf-8?B?T0IzN1RDRXZabWw2OTI0dTFiME5kM21yd09tazhCcnppSXNRMENDa0JPbGd3?=
 =?utf-8?B?WnU1Vi92WXlPTGxBZndhK2JCeEVGU0I2NllmU1pBVm5YR0NKZDQvK3VzYzJI?=
 =?utf-8?Q?JcH7tRL68o900?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0EvcHZFUUU2WUtqdVdPWmxlazBTVEdFRWZGRFpxbjhVaURWRkx6TFBoa3VV?=
 =?utf-8?B?YUF4bTZPaGxQTlIyWEp6Sk96R2pvSkFGNENLeDhNUGR2REdWNm4wQzJzVnoz?=
 =?utf-8?B?cW0vckVLOWV3aVNqNVh6QUtJTjZJSnR1OEdvYUEyL2ZaSUI0UzVhRTZKOWJP?=
 =?utf-8?B?SG93ZTM0MHpET2QzSXZyVFEwY3BITjFWSEtwc0VFV3hlTSs2RGVBaHN6bEFC?=
 =?utf-8?B?YWliZWhqemRWRlRIdlJSbWZNV2xZaTNCK3N0eDFzU05ob1pLZTJyOGZuanZI?=
 =?utf-8?B?ZVp4RkpKeXdqbURHbE5DTFd6VDFLUEl6OEJEQWIzaTN5Q0xmZnJKUEZwMHZy?=
 =?utf-8?B?alhsNGZwOUcrY0JXbWc5UzlINEsrQzBSTmpQQ0RGN04rOHFzWEkrMkN5UWt4?=
 =?utf-8?B?TjRzVjRlRGRObkJPamM3N2JjMDZadWJlUUJsVEFyNlJJeXVzRTl0cE54cG41?=
 =?utf-8?B?SVZRdWkzdExYK285dzVSM2pOek5vMW9mblN6SHZXdWsxYTZUYjIyMG9WY2Vi?=
 =?utf-8?B?aUYxcGtSdGN0Qjluby9ESnc0NDJ6V0N2SmJjaU9Da3lyQ3BVUmlldmVMUDUy?=
 =?utf-8?B?a056VmVBb1RoODFTMTNodS9qcnk1TU9UVUp6VFBnVmtweFl4N3NRZGhoVDZ6?=
 =?utf-8?B?Nyt0cnB4Wjd4Tndaa1pmMGY4cStxa2hwYW96NGd1VndkcVpXYjRFVy9TaVlO?=
 =?utf-8?B?UTlONjUyQTJEdFBoZm54emFBOXlwT2Uza3ZrcHh1V0xxY0ZGaDRUOUd4S1FG?=
 =?utf-8?B?U1RGdVBROHNUR0Vlc3VWelppY0xPTjJUUXBEVENPYjIrSVhxdWVDSEh4SnBu?=
 =?utf-8?B?TW1vMGk5VDMvMldSYjhLWEhDOVZFaFBIZHpnM2VsNzZ1TWJsSjJ6M2pZYytN?=
 =?utf-8?B?RzNjaUVTaVpBSkdCOWYwVHNMbURiRXFiQ1ZHTkQ0Mk94Yk5qTlBodHVuRi9B?=
 =?utf-8?B?UHpocHcvZCtnRzhJR3ZkTkI1WXdpK09lTTNHaWNUbllZS21RTG5IeE1Ja2Zz?=
 =?utf-8?B?QjVqVEpTMk5HREFsY3ZhVGt5YnFwRWZuMUVhRTRidmtDTGpNS0R4MWdCUE9B?=
 =?utf-8?B?WjBlWXhDSXRJZG9Pa2Z1UEtBYkJzVytQdmlUUUZIV2d5Y1lvZzZLSEdOd1hX?=
 =?utf-8?B?cEVTV2FMVnVSdm9McktQb2Frb3VVRGZReWtMRjl0KzQ2VVNIR3czL1liMXRN?=
 =?utf-8?B?aVlWRFNuQlA2eFgreGw2ZE9HUlE3MEpWY2s0TXFodDlzMnh3Q1IvVEhXZDFR?=
 =?utf-8?B?V3czU0JMVUJwd0JRcDZwczJXQUIwVXBIOG5Fd2xCcEU0RDVNYjhTZmVFaGZw?=
 =?utf-8?B?OVdHVG8xanpCQnYyeWhqMkFGQXN5NlgvOEVpMkI3aU5EemdHWHRVNWd4dURO?=
 =?utf-8?B?V29jT01Nem1OemZNNEs4c0lMYldhK0x0QkVBZUpaR1hObW1zUGFGcmFyc2k4?=
 =?utf-8?B?M3RzM3gzZTFWVFhVL0tBaDZEc2FUYm4yNXI0Z3IwU0lEaE1IMDR0WlgzbHhK?=
 =?utf-8?B?UkE2eGRBT1RBbzZvcXhOT24xZ2F2L2dUY1RDVnNJRUJTcDlwcng4dVFnZEUx?=
 =?utf-8?B?MVZsTHpIT2p4OEFucVF3RlpFblhkQTVWUWNLVk9SbFk1NUZpNG80R1pPUkNm?=
 =?utf-8?B?d2xKOUVnQ3o5YjAvTndRRFpyS2ljWjJCeWhLUU5BS2xxN1VlR243eFQwdUtC?=
 =?utf-8?B?RGpRelBqQ2pwbGE1bTk3RjZaVmZ5cW9INDlJcVhxKzFHNjA1dEFpU3d3L0gr?=
 =?utf-8?B?ZEJIWVpsTS84YWtXUjZCUEFqWllTZmtrNDFaVW00OGVqQ295Sm9xakQ3S0dH?=
 =?utf-8?B?OG82dm55SUs4bnRyL21Eak1FQXJicm1YU1lycGs5NG1hSmI5dDIrdkVzZjlp?=
 =?utf-8?B?RmJJSC8wNmNwZVVRS3Q2Q0haS0VSN0pvSFNzNktCMmY2YnJEOEQ1SzZHK0V5?=
 =?utf-8?B?VmVPOVd2Tm9YMWs5c1BmUDkwTHNPNUIvdml5VGVnTGdLeVlCbXdqeCtvTGdt?=
 =?utf-8?B?dkg5ZXU4Zm9MWDdOV3BRWXZ1R3d6ZWYyMTY1YUlSUmJpU0FKbjMwc3dBS3l1?=
 =?utf-8?B?c08zN2JReTJpdXBUbDRRdVVWZ1JQdHVGQlQzMlZFVG5UQklDMGZZaThUajRJ?=
 =?utf-8?Q?vd9ko+H1ktVZBjj8xN5HkoFRa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	weFT3YuyHWkNUFG4h+MWe5tZrDmT/8GpUnfm1Tfe46f/JZwYnPn+lA+o0aKcP1BgoLSkl7DNar547pUYGjhkamZvRIGeChbe5BR6KiTC1yNa8TIs9nFDF1m7yww4cYKlxJGdMvPT8lp/JrbM/mblmj3WOgjKigyuo16if+qB/TDXBdiRWqn9LEDdFilo++eEtDaU/DhJUpyETBCcyjS0dEKqkM3/IEXTG/a0rgdYgAiNdhB/Z8MO33AWguDxloPQUlYw+XioeEA0+76E5W7xtF5QwlkTGL4shLEYr5nLeIE+1onhUFRcq5wUnwQZZzE2WkZuMFpdg1NBmDWObXxTD9mol4Vg1tulxq3kMHX17l7A2Im//43i2TfpqSLsYwOh0vloOKqB8k3YcdxU6nh6aJCb1a1wnbd62rXHZfKEKp9kjUfGqzmZPiXvqME+oJw/WAb8JM7R7zCAvQ2ZWCr2Sbo/dywj428DDMLOtxEqL1Td29AxXsVXrwwuYjhhSHYQtPvJJOk6yu8kssxBaoeXIZg3Ym+OuZNwvaPMDwlAst7pUSprv0WlqXnj/oHYk21lP4ZRZxup9M8fpy4Ftwv4S4SeGnztotymKkdIEUnqYdQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c43035-82f6-43e9-3f71-08dd671b9f78
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:24:09.5384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /048VXajEhUXpr3M2hiCzKJhWP6vSc0ZGM5skcRsoH7IQHJpYsuKVzk4eP7meMSlsMZGKSXkbY7L/PoMYcbswA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_07,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503190130
X-Proofpoint-ORIG-GUID: hVYQaaBpBUDX2jqFthCcTKQ7UflXVDRg
X-Proofpoint-GUID: hVYQaaBpBUDX2jqFthCcTKQ7UflXVDRg

On 3/19/25 3:00 PM, Dai Ngo wrote:
> 
> On 3/19/25 11:28 AM, Chuck Lever wrote:
>> Hi Dai, thanks for starting this conversation.
>>
>> [ adding Mike -- IIRC localio is facing a similar issue ]
>>
>> On 3/19/25 2:22 PM, Dai Ngo wrote:
>>> Hi,
>>>
>>> Currently when the local file system needs to be unmounted for
>>> maintenance
>>> the admin needs to make sure all the NFS clients have stopped using any
>>> files
>>> on the NFS shares before the umount(8) can succeed.
>>>
>>> In an environment where there are thousands of clients this manual
>>> process
>>> seems almost impossible or impractical. The only option available now
>>> is to
>>> restart the NFS server which would works since the NFS client can
>>> recover its
>>> state but it seems like this is a big hammer approach.
>> Well we could do this instead by having the server pretend to reboot for
>> only clients that have mounted the export that is going away. That way
>> any clients that don't have an interest in the unexported/unmounted file
>> system don't have to deal with state recovery.
> 
> Is there a way to restart the NFS server for just the export that's going
> away?

There is not a way do that, currently, though it's a feature that has
been discussed for years.


> How do we specify an export when doing 'systemctl restart nfs-
> server'.

I would think that the emulated restart for select exports would be
handled entirely in the kernel, and not via systemd.


>>> Ideally, when the umount command is run there is a callback from the VFS
>>> layer
>>> to notify the upper protocols; NFS and SMB, to release its states on
>>> this file
>>> system for the umount to complete.
>>>
>>> Is there any existing mechanism to allow NFSD to release its states
>>> automatically on unmount?
>> Can you explain why you don't believe unexport is the right place to
>> trigger remote file closure?
> 
> Yes, unexport is another place that can be enhanced to trigger the
> releasing
> of all states of the export that going away. For this to work, the downcall
> mechanism between exportfs and the kernel needs to be enhanced to specify
> the export that is going away. This approach would eliminate the need for
> VFS involvement.
> 
> Currently when 'exportfs -u' is called, exportfs makes a downcall to the
> kernel to clear the cache of ALL exports and not just the one that going
> away.

Clearing the export cache is OK. That just means that new client
requests will trigger an upcall tp repopulate the kernel's export cache.
That is a much smaller bump in the performance road than a full server
restart.


-- 
Chuck Lever

