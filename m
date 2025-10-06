Return-Path: <linux-nfs+bounces-14994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE549BBE9EC
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 18:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C494189A64C
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0421F4625;
	Mon,  6 Oct 2025 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kIJccZ/4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LwjN6HXx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707AB215198
	for <linux-nfs@vger.kernel.org>; Mon,  6 Oct 2025 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767620; cv=fail; b=cV/26H0efVVbYn0U+GIo0NVkbjRjf2ITFItv1GTzi8tg9S2yA6WoIvCNzHn5pR2okm3PGMliaOl3qvQvObr5pxmQe/7svaX470wBtB5GGJ0jUDDtBfc9e37Vn7GJgSfAh49cKwnyLm0UZ/lRi8Ck+IeWN/7oReBfiYgpwJpxBa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767620; c=relaxed/simple;
	bh=JsA5T6xjgVq8oT1GrukI0tqUD0QN+FYFU7iIv07/liM=;
	h=Message-ID:Date:Cc:To:From:Subject:Content-Type:MIME-Version; b=tLfF69YLCOmN2whkfNg2PWuSXHvbb0CBStEI4wihljyX/5vZq/c8aEs48MF4NQLitx9WiKCmu3VHNklc2YXSujlGE/fAZJR2mYUi3KHXT1PW33//pZ41KtK+K/s7GC+UmeiCBa1bB/TdOxFp/+rWhiCgBrYTlFAEOlRSwA8CwMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kIJccZ/4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LwjN6HXx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FuVMj019301
	for <linux-nfs@vger.kernel.org>; Mon, 6 Oct 2025 16:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=9ne4ns0u/a42urwr
	tjOgzwTvnKGLF2hE+FjOvRDQQ/0=; b=kIJccZ/4UcftJrwCZ/tFOJf/N3+Z74tK
	av1NxLZmsh70wzYI40dDJB35WNh1dIIdkGM9G5HhoDG4NwSEK0SrOsieBK7BiZcy
	Fr54wyXDBzUfm/1dZDG3At2IZOb4hj4saAyitfO62gh0Hc+8Lb5qzuBlju/PTD+I
	C849mrulmhOCjicGJAY+TJpfAVi5mDcPZsGde6UkjsXq6Pmht1JOdFQZWu5QttjI
	4uYjJ1ntDr8AJcq8Ip/xe46y5EXQzjiM60hGLtJub8+M+LXCD/F+fG88nZc7DPYe
	xBmtPb3fp7Ryubp1Wb3q3zYsmv6sRAFumRjkpkxv99E6H2tdYU0K9A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49mgajg5e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 06 Oct 2025 16:20:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 596FbxGP028616
	for <linux-nfs@vger.kernel.org>; Mon, 6 Oct 2025 16:20:17 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49jt172e69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 06 Oct 2025 16:20:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYvDVpWa52j/1MbsmlewnqII1sz3xhoZG0NVgDAJnRH4KT8CEEicCcoSDx1oBZNyYiUEgf0W9WjTAQ86FxGQcubc/p3071AHvPvv+sxjYuh8PjIcdUqYyr7JMcdOFkg5uAWNZ6q3qX4C0pOPuIRX3JHjNTwl2PXPBGWhXyiHVwkglrvrV4FK0U06V8yelsFY7gXL+jPUMzV6cBlBEtu056offtg17q6pkI+R3FWgakdpOISbTyrcy/GDpCX/EOKZM9jSe6r6b8YPpkHl6X86xWCqHv4R15o9LthBbjAW8kBPd1XcbQUL8QYKpio5oWSgBpTfr5BWzQlu9L7MCkpbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ne4ns0u/a42urwrtjOgzwTvnKGLF2hE+FjOvRDQQ/0=;
 b=cTqlKJ22acgPsweU/cAlcZ1ZpkwLhFyoSYalqM/ev5eesXzxLAscFLUO+0iva/C+QbdNkwUpKkLx1N717BUpz2WkVLy33uo/OId3pdVEptfhtQrZmXB7x2x0Vk9BB3+oV1rbMuwxGmJv2g4FpYul41PBCzn6CiIe3Q1iDm0/691u9umgQz6G41uQgX05B0mYC4tRZzCQgL5Pml1NSuZ1BMCqJ/2mEei0F9s4QqvcAr7wkFDtpDIZI09A5O88kB0apPQZyjVq5DNYChZNbWML/RT0/nChP7WgB8z7bt69Urvlk2V38vph3q2O911/usIwU1sN3nSOQsZB+Dm/Crfqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ne4ns0u/a42urwrtjOgzwTvnKGLF2hE+FjOvRDQQ/0=;
 b=LwjN6HXxk0qupjhgcR0w3CKSPeQkitjgNAtrGwwyQFGbQlM+acmjOMdAlaU1HqGWw5+oXcvM+nuZfdft61MCrNuCi7psFqpWQwC1PimD4W5YnU3uv8afCrZkYL7vsj6w5HX4XSfqYxPx6c/UTtZfPW29aLeFMx03fHRP1RxMjvg=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BY5PR10MB4292.namprd10.prod.outlook.com (2603:10b6:a03:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 16:20:09 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%6]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 16:20:09 +0000
Message-ID: <0b38bc00-016c-49fb-a725-bf15035aaa42@oracle.com>
Date: Mon, 6 Oct 2025 17:20:07 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>
Content-Language: en-GB
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Calum Mackay <calum.mackay@oracle.com>
Subject: pynfs activity
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0152.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::13) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|BY5PR10MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: ea01fec4-4595-4e28-a351-08de04f43851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlE1UFRTUG94NFRzVmhQWXBTeERlSGJ3NXdJeXQ5VVFGT0o3Vmg4dC9FRlNT?=
 =?utf-8?B?QkdDKzBFR2hMUThaYm83RjRieVhBNmZVaDVBc2s2a2I1Kzg1dFZoSWllV0lO?=
 =?utf-8?B?TXRiTnd0NTBxN1lzNXZDNkRTVUNaNVVhczBvRTVrbUlZeSt6WVh1WFdKL1Yr?=
 =?utf-8?B?QzlsSmNNS3JyQlVWb0FBRi9qajF3Y3hEdllVZTQ2K00yUmJtbndBdzJyQzlN?=
 =?utf-8?B?WmxLazJ3OTN2M0FnNzVlcjZ4L0VaUG82dHdLOCtYazhFWkQrVkFtQnE4S2dV?=
 =?utf-8?B?MmdSZnEwbzV2YzVTMFZ1M1U1cnNGNGRzWnRqR3lrRi9oS1k4ckpPeFRMdHRw?=
 =?utf-8?B?WVFjZ2xHbzBBS2pRZjhGRzhxOW5UejhLUDVmSmRtdVNDRCtwNmVPK2p1UlJu?=
 =?utf-8?B?czJvZ3dwL0VFT3hYdTh0RVFNdklWVTBHYmtyWTZoc21PQkxpV3NqVlNaUnI3?=
 =?utf-8?B?T3dXK1hTTXgxTXhBRGZXbyt4aWphWVM4K1NBbFp1WlFsd0tYbW5LZHg1NWVw?=
 =?utf-8?B?bzVxTUd4cnZHc2FMdy9PQWVSSTV2MTgvU2ZPTTcyMCtQNUhlREJTRUlBMmNq?=
 =?utf-8?B?YWZydXVJZ0JweEtMUlhyaVozcTZ0aVp6U25oNHN2UGdka214Z1NEa2xLQkw3?=
 =?utf-8?B?bU9aaU80bVNzTGhxS2R6cjFnQlQwcFVnOG8vL2RjUjVCNDdtM3NEYTVyS3d0?=
 =?utf-8?B?Nlg0ZEUzZTZjaWc4T1V2MEtGU2pGd1c2N3R6WkNNa1QwN2R5QnZMZjg0VW12?=
 =?utf-8?B?YWdGUnpMYlZWR3dsRzJZb0xwbFRNRWlQKzBMWEl1SXE2cjVHUW9wd082NHlX?=
 =?utf-8?B?YWd6bjZ0aElDOVJ5NHJFVWQrQ3MwSHdPeWZFcWhDcUxObGVYR1ZJK01XWXJy?=
 =?utf-8?B?QXErUXZqTHh1VVJIMDFCY2o3YTlOWk0rcW5YVmgrNXduSWhKdFBxaVBCTzRv?=
 =?utf-8?B?Z1VSMGI0L3ZXYXJFUkpUTno0bUJUSXRMN3BpMG5NbjhnRHljTER5aFhaUXJu?=
 =?utf-8?B?Q1NoME5GeHlrbzZEZDJqbytQRUF1azFEaUJpRFVTVmtmaTczR0pkYjgwMm9L?=
 =?utf-8?B?QU9wR1pFL2FuT3FqdzNtR0xDT3Brb2lLWDdHZStHRldJMXA3ZllPT1dZc0RE?=
 =?utf-8?B?QlhaMGRsK3Y1UmY1YWxYMkFkVS9IZ1ZHRHVYZFBTM0lheUFvb3ROVnhyUkRi?=
 =?utf-8?B?QUVsRHBaVTgzTkdRR055WWROSk8vcWJ1VWhRdStGYzk3OWIwVXVSOHg3ejZX?=
 =?utf-8?B?ek5ZaG5JQy83V2lmTHljNG42Q3ZyYnYraU5tYWR4T3BiL0FSMVVFVnVwSmc3?=
 =?utf-8?B?Uk1uRVFjL3pES0pXeDlqN3JKRWFKdzg0K0pBbUhFdldtdHo3SlVlcHhTeE53?=
 =?utf-8?B?ektIb2hsS1VsN3BXT2d2bUVnZmptMEVWeEtBUG9xQndSU3EwQkQ1eW41dXJ1?=
 =?utf-8?B?eDFQQnlJR1ZvdlNwOUx5MlhMRlRXc1NYOHZ2ejlMeTNBVnBLSG1jbmJQWjRL?=
 =?utf-8?B?RVlmWUoxTnpoK2hTYjdoY3RNY1M5SUMvTjZmSENFbGVydjFHamViUnFSWkpr?=
 =?utf-8?B?WmhpQ1JxNjBWZ3pkczhSMURIcEEreVJKNmt1U0o1cDNQMndzNFQwT1JIRTZF?=
 =?utf-8?B?a2wvaFd3a1pXaExDbFhZZE5DUmhWOGI2NVlXY2YxcHdqMXdwQ1lCUXFGNEpN?=
 =?utf-8?B?TWhJQ2phc3VrblREYys1OC96YnhJd3hSTzZHR2cyWnd3endhenRxbHhZbmxK?=
 =?utf-8?B?VERoQ3ZhMzNIaG1wM2NCN0tNN0FFb1VVdi9ET3J1YUNqWmt1KzA0bXYvRTBj?=
 =?utf-8?B?ZG0xVU0vSVpBVU9GQlNNZHhTUDg2RE02Z0x3UHhYSGRDaDliTzB2QStKUHhB?=
 =?utf-8?B?TEViSHF5T0JzOWtFSTRuekVxQTQzaXZQTXJzT3NmTTA3cFd6UUROR2pNNStz?=
 =?utf-8?Q?u7zxq56wsdLbPfiYyX22DWHfuBELgc/f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0tyaVVaZGk2TXRvR05CMUI4T2Qzb1luK2lSQmtSMHJRVUduQ01xM3RLa3E3?=
 =?utf-8?B?YlNiQThnZmljcTdnSnRkRUFMbk85TWR1RkxKYVAwWHdaZDgxSk10TUFqTlpK?=
 =?utf-8?B?T0xtR0VYMFh0a2VTL1JmVVJGSUlxTFlmemd3T29lMFBFSUkveG91Q0NieTY5?=
 =?utf-8?B?Y0orSG1BMm1tcTJUK05FUDBqNTR3RDhJSENnRTF0cjNaWUNGSGRNTi9vRFJD?=
 =?utf-8?B?VDZ1UlNheFplUzhHeURVNG1KMThzQXJMN1VBYmQwNGw0K1BzY3hqT0VmSytS?=
 =?utf-8?B?Z1JHK1pLTjIwZG9mU29Ua3RZdktPMCtBN1MvSkYxaGxjaUpIaWJOdHlPWnV0?=
 =?utf-8?B?Tnc1MHdnRHdMRlhOdzZUa09ObWlmclZZWDViS3lQaUhxNEFXWFovb3NvOUhw?=
 =?utf-8?B?YkRIOUR3cUZqR3k3dTg2ajBMd3gxT3hwWHI3Tm8vZ2laQWY1K25ITnNtYlhC?=
 =?utf-8?B?aDZnb3hGdzJwRktDYjZNVjcreDJ1V1BweVBya1VWbzZvNVdIOGorU0Nwak5k?=
 =?utf-8?B?cU44YWtITzVKVllJeVExcVh0anFIcmpNZmtwbHo4RWVBWUF6MGNRV25jWGZl?=
 =?utf-8?B?Z3ZTRWsrcC91SzNoZ1lhV2NBS2t3OFIwR2wvSm80S0t2WlBKVUgycmdtdzZU?=
 =?utf-8?B?d0gwQWg4N2FaZW94am1YNWVrcVI0VTZmOHdnM05id1RnY3RWY3VyVWRJVDFr?=
 =?utf-8?B?ei91d0RTUCt5UUo3V3hqMmUxYnQzMTgzbm1yTFZkYkEwZDUyVkI4YXdwRTFU?=
 =?utf-8?B?TFhBOWhGUzF3ZDQvUkV3Q3AweEtMQTdoUmdGU2hlL3ZvWWU4ZjFRMUYrdG5q?=
 =?utf-8?B?TWhiQmo2K3BJVnlmZWlzb2RNNnhDc244OTFxc2sraDJRcDhrME9zdUlTQ3FG?=
 =?utf-8?B?NkU0WExrMHRybHBOWFFsNVlIK2Q1N3R3TFA3WlhWeVY1S2NOZ3Zoc0FKUkJR?=
 =?utf-8?B?VzMwc1d2NFJXQjhqd2pHZTlFYnU0Y0NDeHJXbktkLzg4Mit3QjluVStGaHYz?=
 =?utf-8?B?TmpFOExLVVNZR0xpOVZGTTZxVWFDQ0JpQjFTZDVENm8vWVZKQllCTUsvMm92?=
 =?utf-8?B?YnFOU21HZTVFbFRDTjVBZHR3UDVrWk1uVHF6bjkvMWVoSHg2WUJmUjhtRHZ0?=
 =?utf-8?B?cUUxSVQxN3dWaVFTeUJ5dnUrQTBxa1BEMGM3RE5RZjhUbkF3LzFNMFZ0Ullz?=
 =?utf-8?B?VWpyeVFQL0p5L2FrYkZSQlgzcTdqeFg1VE9hNFNxUndnaW9DVEt6dFAybW5l?=
 =?utf-8?B?T1ExUVpWb1JzU1Y2UDRPRlVRTHl3Z05IbGJ1R1paNjZEbUtaZ3RjbW9HMUpy?=
 =?utf-8?B?QzM4WS9QSnE0ME1JR2Y0N3ZoREFoYlV1d1RGTDlLNmJ4RlpoWitGbWRkNTJq?=
 =?utf-8?B?bXVMc2RxS3c4U3VYRExNTU5VNWxWK3M4V3lqUWdLOWlpOXZGN1dKT0JiL3hI?=
 =?utf-8?B?NzRoUklrQnFmOEVKanVTMmh5dFVqd0R3WnhVVk5ldVVScEh2NlpSNmFOdS9U?=
 =?utf-8?B?QTJwVjhQZEdoVmFXMWdLTmhxYWpDOXBPaVRtQ3hHb1JJbTVBbElzUzBWNWpU?=
 =?utf-8?B?d2pCSmRCemY2TEN3Rm1acXVqNTNOOVk3MVpmTFIvNzlTVXB2RXpxZUZGT2Nt?=
 =?utf-8?B?V243UXl0cjlKMEN5dzdiRG83YlBqYjJvc1MwRlhLT21KYVAxZjRIWW1mbk1i?=
 =?utf-8?B?RGpRenlKTlA3bHNVRjhrSTZZdjNsN1BiUFdGSCtSc0FRckZIR1k4UkhpNlp1?=
 =?utf-8?B?SDYybXVNeS9pZHprTGdsODNDUTNVZzlsbU03SVN4VWRPYTRvNWI2eExQTW9r?=
 =?utf-8?B?VElZQ0gwTW93RnZrSFdOWkI5NGRBdlZWZHh0cVQ2R2tKclNoemJZY1pNSktG?=
 =?utf-8?B?QUYxT2ducHBZRWV1SjliQnA2NFJ6OWFKNWo2eHc2NjJQTkNUWnlNbmJjNVlN?=
 =?utf-8?B?VkovSGYwWGZwMlh4WFJzR1NDMGZLZStVdUtQQmxyL3NmQ3k3NmRkOEdqK21L?=
 =?utf-8?B?d0N2SFR3ZHNiV1ZtS0tQZzJwZkdFV3FZb3FuWW4rRFZBWnBkMDVyMmtiNHhq?=
 =?utf-8?B?ZjJwaDZEemdPUGZya2s5NHJmUGY1NEhLK2l6THZzTUVVOGZFdzRhM1ZzRWho?=
 =?utf-8?Q?PVQTTuLfLA8uKGn+evMq8uppa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yD0OOjDcpnfMbenjN3E6qc8jeb0ytTLuNv9poBrV/e6P8NDsXjGWrctmbSGo9rmEkQhWvVQMBlAr3CJ79+1m6VH0KERQO/1f+FtAXFJE3i8VbwM8S4kAq06vIXhgJllc24RbRTpyHoEtGOLvHtxgq6D+uIITpSsbc9vJphScI98gJwfsTV1r30QXjACmbo6FzRl8bpQW6GBo4vxB9dlODh0Ng5roSynncLqPeMBH2SpyR7INvfR81O+flSjnTH+usiDagwNzXRoHv1uBu7xvYF6P/nDOnatcs7N8XkxeJrsZeD1Os4kCCMeljVHwhkX+UufFrFiUrcTrGol8QgVaWH2T9FGw13yXZcOrgnh1YdOC151e/WEDH+4q/UiUdnZM+EuGr19JgKtCMvg5udUEvDkrd8gNzLlExStb3hZMrM2sETbc/08dNTSKtG4ywxjJUYyaQXCrJFYYp+Jtxf4d+kzLd/iYC4n/+XwcQS6qnvmBYq09gsH5eLNSkgeHRNdE7DEYIsirIHzhTeee+gM8cMLigrBUiUlbKWWdhE4mVrx0goMnuR8JnN43iNDxa7MwQKeX2pddDqnOIBFMvwvnlrIcGKm0VLPlpWZSYJj0wKM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea01fec4-4595-4e28-a351-08de04f43851
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 16:20:09.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qORkdnMIh36X4k+9a3CdMxlS/bgRSF6l2boUj7SBEVpXRVykQ02Ta+cfBKjOJC7XKTYWhv2r9H5k+Pbwn8WXfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=787 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510060128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMyBTYWx0ZWRfX5CA68r8E8V+W
 PmHWyUMqzi6JMJsXhoY+19ij23Yx4JYD7bAsoirtUZeNRF6bG7jbuldGZct/RPGRvBua2Xp+J6R
 1czM6oVtOyoLWu7/apQmV5h4jbHc+duHOrW32io7AA2hPRbMvg6dvqa9iLpwvJb7hMH+WSb5lwF
 lME2UeY1NlsqKCqvcSRN9lA9wHnqy7Gyl2h6sweFuLQKIGGO4RBGYTTqicvikH0K8ZeHVVaXWnY
 of1GMw6IJYb4KztMdDoFzqy7yeyTHBQdOgywWT9wccRF1ApjR33r85EIjEpdqT9TbhCbseDYr1H
 5fOKXAimzd6qh3+YnN7G5AJWY5OquKFEmu/3HN/YG7L5lu58sjdruqWG5dCBAnHIOwjVtLqQWm3
 9TSYSVnF85dB61b4Xa+hvS/7CqPPNjTWmgZhi6qROESe4XuFUPo=
X-Proofpoint-GUID: aQHilrM32SIzi4KqrenNBJ7xsM9-Fb8E
X-Authority-Analysis: v=2.4 cv=famgCkQF c=1 sm=1 tr=0 ts=68e3ec42 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=_31CF2-tk7I22SvKQUsA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13625
X-Proofpoint-ORIG-GUID: aQHilrM32SIzi4KqrenNBJ7xsM9-Fb8E

hi folks,

I must apologise for the continued delay in getting recent pynfs patches 
(for which many thanks) committed; I've been dragged off onto other 
things recently.

I'm sorting out my test systems now, and will start testing all the 
recent commits, and get them released asap.

thanks again,

cheers,
c.


