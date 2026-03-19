Return-Path: <linux-nfs+bounces-20282-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P3NIUBEvGmAwAIAu9opvQ
	(envelope-from <linux-nfs+bounces-20282-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 19:45:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE102D13AB
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 19:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72500300D343
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 18:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E70335063;
	Thu, 19 Mar 2026 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XHtOBDCX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oKhtrbVR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391740DFDF;
	Thu, 19 Mar 2026 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945915; cv=fail; b=n4PUFYSbBwPwccpNOhAkUkDXCa6XViICdFlKuL7WjP1HhNABis1dMgAYNgZNov8SBp1FvtvbfRdh/QlAE721FmwxOChhhSNDgmrOv4i6sTCURIrPjMXK4j+vT3UmrRzL2C1OYNboZV5VtkMHaSe/5S3XuTlripx0nn61VHm1a1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945915; c=relaxed/simple;
	bh=Yi2gHq4bt/NE+BNbND4Lk+ChVufvOZjG/UaYxuzS7/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DDVyoKkUI5nGa21JH2N4NNCNYCvnlpkJ7RE7Y8M+GlIyJpjRygxNjdVqvI9sDk4YiIvePHYjmlONDgi1erwbaiNZ3sEB5Y/HAKxslhKuzRkoLnEAcFIyvCnxqtbLd7dyg7rjxomaRTQ64BhpKe3yZZpkyGlGUcFHKz00ArU3VV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XHtOBDCX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oKhtrbVR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JHSGYp2307286;
	Thu, 19 Mar 2026 18:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=alE8W+QafkP1oBiyBivKUr4AQrDi6GgLlomlwkZAPnM=; b=
	XHtOBDCX1pNx780+bdvddJEoYZTUi4V9JYzEj0Ub8hghpme8yFcn1Tn9iGfOj3wP
	d2XX2llPtGvLloYscOJwRoyGh0ad0deGkXVeMh5GCAFVjkEZ9MMY9mS0nf8+xqlq
	WuCd+yRk+L8qpRC9pkSlrZLhD1xkbHoSXxBno+duCY7bmLHcc8uIfhS4aLMjv3nI
	7uQRzb0f5iyHkZF41cFj02ow8QRJL2ZbuNlRwmI/yd3giJRnO9cbDoXNF4qTEcFn
	Uwv8/XRJvUb9PHoWuGYpYcehlVd5JDfytTt/Vt1sskeDFYkUM3mGpsdttGPw0WU0
	+f6dL2tno8Z0kKWjKWGv6Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvy9s0b5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 18:45:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JHVHgS014043;
	Thu, 19 Mar 2026 18:45:06 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4d95kv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 18:45:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIOJ2CIFx+46KQKa1ieSqVKYn6HOZ5F9a+fA2gJmyYlamku7LoBIvyZdLKEbjL/XWAwOjb4+iKFdX+JUEXVfSkTcUwTQfmsZLeAAnqMbVss4GqinRjIDgjAEG+tsBfGqiw2GjsUBQdQvqLEPWLtKxrEaPvlK0nNxz155yI/b9hWfMot7z9FZqxlDyuu3fAQ4oIBZChSibuIJkGNav7yxfeNezEZMY2GLnbvJjUOZCP8K+kut5Wl0LLZ7SID669Kw0AlQBX4mUd8erUbUBKLsZWT2FqQzVjWyltjvutR3wiOA2pvYoZJP4NiLpmI+pTXc09GY/KK4F6bIVIos+f87+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alE8W+QafkP1oBiyBivKUr4AQrDi6GgLlomlwkZAPnM=;
 b=wLb5mr3mQ3sbDktdN4eaaEllk1khymNq4yv0wL5w35gnnCti13Af9uSQHKaqd0ijXGfw9fsw3n+qFBc0ZnJhqZ1vdD35o1nCl7rs0IY9XdIoH5X62UZHS74wVhG95f7JxFPaaMaHOEqCtlGFCO/Gb/sGhidGc0N6wh2n/8CIlPuRRIHlE7WUaBddZGF1PyEZ3JhNTnN4avR6ur9GO9V/TXt1S60+02q/4hMfdXtBpHgMxduAKed7VCSOEkklX5CUEC7dlFDoekt9q0QsgdkxQCfLymQ5GMCbtBzOd+PvGPEtpcYUFQKqUrhtQ3B4qIaJcLpsN+KrFpGoneJkBVZuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alE8W+QafkP1oBiyBivKUr4AQrDi6GgLlomlwkZAPnM=;
 b=oKhtrbVRCMzz6lTT6YM2KTMGUnLzEp3jWnf5Vgmk45CMI0XGkzTpZwsew1vKICDvXPc4c/bps4xs9vBVILN5KFYLP0cOpmTP6wm8qwlK1K4ukFD4UGZGm1X/EwjFjsSiWisGzzFJFOwen+3PYBt71bZ2FsZiTsR3zTAdckuGnEc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5081.namprd10.prod.outlook.com (2603:10b6:610:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 18:45:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 18:45:01 +0000
Message-ID: <e527b377-028f-4074-850f-5ec97c5048e6@oracle.com>
Date: Thu, 19 Mar 2026 14:44:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] sunrpc: add a generic netlink family for cache
 upcalls
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
 <20260316-exportd-netlink-v1-7-6125dc62b955@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20260316-exportd-netlink-v1-7-6125dc62b955@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:610:cc::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d9e04a-ad41-45c0-0d32-08de85e7a0a0
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|7053199007|22082099003;
X-Microsoft-Antispam-Message-Info:
 mouWTwHRGS6+RSQwyE5qTSeI6tg8fVBxlz3g+ABo8diFGG+l8LgUK3n6O4Mr79bR9pUpk2iHUJeRrqUOFGQ7TXJASZnMfXLX92wnnUN+GrOZpWGJonPTYr4F3GKhMJbM3OVpqXzZm7ST2X3g9nGUSHmBIipMtupJ1zNI5BIxlp16EdPQ+gazYYPO8NUJSyJDRIuiAOPWv/Evk0zr294taZKbiqazx29OxCyAKEpEurLsIg8qejK3Iy46oLoBCCZIdZDcRFc/a/FKFFiZsTMFOU44G2iiYfp4CdxpBsI/v7fVBWFpMsMXDAjp3NNjjAwyzuZ8kw91PUo4EiJkjnmsNyJnNkc7ZrFO1jA/iTVeelXb+YdjsDAom6r/taz6wGtXCJeLHVIm4y6+bR9wyPZXTKLq9l0zdY776JGBK+9M01jfBCWet8aHRpluQSkqow9jY3K6kT1BBPD9EvvtbsErvPLn/tT2XAEODMoyQ0U2plh+PYo3tpWNUSKawrDwLofwHsLeZuOqfA48sRsZyHYAkxUbRIWIWC5nBwvQIBIMZ4lj2YOVN+aXDah22wMA4F+RbhRaYAJkb6wqN+Iub/kerdMrppv2DGt5PDJJDbaS7dSJ0FMFlsgFVRXWXEONOaoQqhkqvzKkQnUwqCTq1dK71zWXzLfHHp+3Qd2I7MjzagHBA3W7DCydkSHvQSgWH27DS9nhhWE+D8swIN6jHdmnlDaqRgyNj3Xs3Sl+p9vXtGU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(7053199007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WjRhdXpFRmJRdTRlWXVPUFBCNDFGeE5HNHJKM0VnQnpoTUU0SVpYbE1tM3p5?=
 =?utf-8?B?dmZzUFRoUWlDSWtkZTc3c21URldFSXI5OHYvbWtZNHVEcXBnOE15UmxiUW5Y?=
 =?utf-8?B?dG1HVEk0bkZxMHNBOVZxUk5qQXVibXBJRmlTQ2xuUWloQmowaUppM0RLTFJu?=
 =?utf-8?B?Mmp3L2F2eGV0elpnMkZEaTUxZlF5UmZhYUNzaGZ4bFBEY0VSc0JpWUJ2QXM4?=
 =?utf-8?B?MnBSd001S1Z0VFpENW16NHJSbUVBRE9VbCtLVlBZb1NyU0djZ2F0dU9DVU5s?=
 =?utf-8?B?NGlQekhscXE1Ulh5S3I3L2VOYlJGYlJVTk95SUpqUlNTZmFxTU9GYlFHdzBG?=
 =?utf-8?B?YktrNkhKTTAzVEtjTnlFYUlTTmREZWhHbDEzMnl5elFKWkRtR3Z4dzZUVWFp?=
 =?utf-8?B?MFZGZ3dkWnRtNWpOWUg2WUt2Wm1zMFhhNVN4b09zUXJSZWhCN2hKU2o2SUY1?=
 =?utf-8?B?Z01ab3k3dGtGMm5BZFc1UVVRKyttaGR3YVpFMkNDY0hKR0hSNU1VdUROYmhK?=
 =?utf-8?B?VEFCWmRiLzhtWmE5KzZ2MG02RUlsd3NuY2ZEZ0ViWStUMGhPelVaQS95dDEr?=
 =?utf-8?B?ZUdtUnk4MG1KdGpkdUZEWk8vbDlSYm9ZNDJwcy9ZNjBkOU9LcHRBQTg4Rzh5?=
 =?utf-8?B?OG5uNzJtVHRFRU5CS1JjYVNqc0VmU3NQWkJqdW1IemxoTU44KzVSWVM1ZkZS?=
 =?utf-8?B?aTcrN2FqN29nYklFd3djVzV6RHQxOEU3MEhjMldXRzZURk1xaXpuOTR6c2Yw?=
 =?utf-8?B?V3UxaGM4VWRGYlplL2NvMlh4TktEeHlaaU9oSHZ6c2JDL29vVXlUK1NWeDcz?=
 =?utf-8?B?K1FDNXRkdW5wVW5MTDJBVU1GVEZoNGsrQTNSZzVFM3hheGwwTnRPMTVFbXph?=
 =?utf-8?B?aUIwR1BNM3Zod3NXNmk2Ny9DUnNTcGREcVkydXArYklieUF6ekhBTU1iR0Zs?=
 =?utf-8?B?SUtVQWoyb1hJOXV0SHVYMXIyak4wRTdhS2t6TjRoNkIxcldFRzZlcU9XalZm?=
 =?utf-8?B?eVVuSDJmRzFyR0s1djlkdkpaa0RwS2w1T25MU09DTXNJalRoMFN4bjdwcVZx?=
 =?utf-8?B?RGlIcVkrU25UUE16Ym1oRVBOMmk0bzBBc0hkajhQNzA1M0ZOL3RwdU1jaE5Q?=
 =?utf-8?B?MWc3bm95SUhRTWtTNlZKaWxtU1RUVTZody9Bdnh0T0tPMmw5cjQrNVJwNjM3?=
 =?utf-8?B?bkRnNzFDRk9yNHE1dU5sUTExVUJaa1RoRTZ6SjVsRnRmWko1WjlpeUNMMHJ2?=
 =?utf-8?B?MnpWc290RTFnbTNLZklMWUlKNDdrdm1pZjZzNEJoNEZ2TW4vODZ6NWZNY3hU?=
 =?utf-8?B?c0FVTXVRbmtrTEc3dStLOVkwb09OMTFQcjJQM05wYkZjTHlxN0lxMW5HME95?=
 =?utf-8?B?Y0swa096SHBHR0dkenVTa0tFTThNUk03MjI1VjJZMEZFaEQzcW1uNlFvVGFS?=
 =?utf-8?B?dWZFNmRUWUhEQmM3UTZ4ZzlWK0V2eVZ5THZ4VUhjOGZzNVVsWTNCTzZXczlt?=
 =?utf-8?B?eWxkdEFNN2RKVFFGRzZYTmgzSU9uM3dSblprUEErTWtITHYwbU5jS0FuQ0sz?=
 =?utf-8?B?WEY0TisyMHlsdWlNR1RFTkpFd3dhYWV2czF6ajFEZDFxemR3S3JRT3o2WGFW?=
 =?utf-8?B?eks1VDhNSDRrZ0lxYU94ZmF5YXlwcElIQ1FtS3poOEpOenJYNzJzRHdmZnJ2?=
 =?utf-8?B?cHlpMXU4T1lWMEVXUUFpN2FTYTFpaS9XSzV4SHg0QXhSZHFXT1Uzbno0M3E3?=
 =?utf-8?B?VW9GMTZOUkxSMlJrR3ZzK214T05BbjNVMGFoZXFLZGh1a2YyZDdnVzdUeWd6?=
 =?utf-8?B?Q3R6VnQ0MG5GK0l1a0VrcHZYNTBsTis3WVdCOVNzL01qbUIzU2Q4MXYzaW96?=
 =?utf-8?B?QUFGRXB6WGZkV3ZEaXVpT2tiZzZrQTh3YlRRb0ZVMHZrK1ZHT0lvS3Bxb3VN?=
 =?utf-8?B?WnAzRndCV0ZySi9mVmpGVURBR3ZhNDVpNHdLb0Zsb2RjUFNyakVRMHVTeks1?=
 =?utf-8?B?czBQZmsrS2x4YTdiUjAxUVJKY3hNcExCUit5QzRBUnZ6OEFSQ0tOOVdaZld4?=
 =?utf-8?B?S0d5QjFSNTN1clFjdUNzRTdtcTlNd2VXdjd2UlFjWjRMeXFGMVZyaGduU0oy?=
 =?utf-8?B?U1c3NkFxVTVNTU1PcDhOaGk1bnhwcDIwQXU0dFFnREZwNlM4MHBNK2FXc0lS?=
 =?utf-8?B?cEF4SHZnY3BSQkdUaHdjc2YyRjBNTVJvQmEzQXljRUVGYjJoTnZtZ1djaHlp?=
 =?utf-8?B?Qk15TnBuaDdrdExaTEhVUkNMMFdyczFWVG5nRmovZTZMR0FheXQ4SlZSdDVV?=
 =?utf-8?B?VU1nK1V2RTh5Mzdrd0tLTGpFMFlTVmxRQVllMDcwYmc4b203TU05UT09?=
X-Exchange-RoutingPolicyChecked:
	XOjyoUInSkNRsf9/ytnty++TWuxThblLDlRTRgR2l9Jb8RFj/+AWhLuGKEe41vxDmPv2LgEKZOIBoVH72IzziXpaoRzrI/rSBZMRv/s8QFZTSZrI1ZFDYZgzG++WbikNlNd8KFDsR6TLiCrFvlaIjq3AHOeqYak000tHAku73g5PF26QpL4PLPGbQE1ccoPBHhyB2cxXOQM7hZ4NBiBnkJnPZp7iVn+6AmqkT37bYWJ/mMo6cs07CvRtQ6pE+B+z1eRHYNuZNpFx1pM6k3OaSBffXnuCvJ0fFu2yuNn2DG2pVBFugufKfMVq2FUFi4j4LKqB4jQbA+1tzf6n981qAA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	05ulPuouVNadJYURR763yI6a/YaXIvUeXPFAh5wKSB+TW3RTB1K7Fpv6CHnrC9cSxvqi5MnF43vYmqK1TOPlN88MANuIluscz2CDFjP7KBBLaIavTxSaSywZfhiAxb1ZllxsJDvZ4vvFsQaezcnR61PZnKG1lKgkFjaTHvwBFLApyaGB7JEaE2z6oTqJRlW2VlGbsDDb/nR6HFyh/PWiONDXMkcd7hN2+Ilq4CoilQrrWe5LKNHpDLzhqGVLIG7ia4Ro7+wlKhaVUWmaR0iMfB/XgmJ/RTiT13l6nbJS9XG4IKU/AC8JhSlAZvmYDoxdv3vFaCHTrNLvoDrPO07cDVceBBcl8yh8xB9VDdZPGqio+Al2vESl8NwXnquIdjDFw2P3hCXijtRbfzL77hRmm4e1d1iULxzHjvKLZu1b+lWQ42L7T4DAzE2vkA3Nyl0c0LOecBkTBGtwyP6m0/JD774Q+x6qRpSdwhS9QGwgjzf9pspvcEo6uxlBGjbUyunZHguZRjcUXPlR2zb28yjMO8g5lWcS3w78MLQ3mGkeajXixPZbHoKT4IO/QSDXyxzIvJB1NXi0/gXhQsxvbm941SC3ocNpOaTplk0S9pEvdjA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d9e04a-ad41-45c0-0d32-08de85e7a0a0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 18:45:01.4142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wx9qE+4fcFh49BHX8zFeRlDj11Kg/3b74LgdDTsLh1WLtjLcdhB5izEl1daacCcmGaSxSBVC0laGTlqaEWrrMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603190150
X-Authority-Analysis: v=2.4 cv=X5Vf6WTe c=1 sm=1 tr=0 ts=69bc4433 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=fcBPgAWQy6f62UrYKpsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1MCBTYWx0ZWRfX5q0X7lw/Dw9p
 M8nHgncvW+pYTWNkOALtOUont79wt15eLcxkG0SZ95Hw0etzJ8XRsJkWuLdqX+1jVoKDik1YtIr
 M+8kegUOIGknBD4n4lRu9bOcdrIi70uxi/jUT0N7221VVS9WXnZ9hn54aktzIuuKaMKKLNF0Yvd
 aZs1jNYZlORMdcGlbPHhjJs76dxu8Rozikn1uL1rcy/WhUxfla8nCxR9P1J28Y+XHP/EfRi2C4e
 q2lcp8Y7N6/NtFKAkwrhrcvsoLnOaN4ggUEw7sODL8RIgXuTsB+yunIKobtqN0cRaefxdxYzXAP
 iYaqknvXq+QUnUdbGqcEMLMyiRaFM6diMT7ovDAfkL2Q15Xo85zblIXxmPyx9w0sueyJXcdZFrj
 v2z5THpw8OcJ3rZ7WFsGeIp/LSIHUsKdYkGruHSMbW7K2llPlE9LrxnUahEjTiHgRhBz52d2MtY
 HC3+rZfvNtMJ8RRszCw==
X-Proofpoint-GUID: jAByZT0-3Fb2gizo0Suc0h8N7glsWOqq
X-Proofpoint-ORIG-GUID: jAByZT0-3Fb2gizo0Suc0h8N7glsWOqq
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20282-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2EE102D13AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:14 AM, Jeff Layton wrote:
> The auth.unix.ip and auth.unix.gid caches live in the sunrpc module,
> so they cannot use the nfsd generic netlink family. Create a new
> "sunrpc" generic netlink family with its own "exportd" multicast
> group to support cache upcall notifications for sunrpc-resident
> caches.
> 
> Define a YAML spec (sunrpc_cache.yaml) with a cache-type enum
> (ip_map, unix_gid), a cache-notify multicast event, and the
> corresponding uapi header.
> 
> Implement sunrpc_cache_notify() which mirrors the nfsd_cache_notify()
> pattern: check for listeners on the exportd multicast group, build
> and send SUNRPC_CMD_CACHE_NOTIFY with the cache-type attribute.
> 
> Register/unregister the sunrpc_nl_family in init_sunrpc() and
> cleanup_sunrpc().
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/netlink/specs/sunrpc_cache.yaml | 40 ++++++++++++++++
>  fs/nfsd/netlink.c                             |  2 +-
>  include/uapi/linux/sunrpc_netlink.h           | 35 ++++++++++++++
>  net/sunrpc/Makefile                           |  2 +-
>  net/sunrpc/netlink.c                          | 66 +++++++++++++++++++++++++++
>  net/sunrpc/netlink.h                          | 25 ++++++++++
>  net/sunrpc/sunrpc_syms.c                      | 10 ++++
>  7 files changed, 178 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/sunrpc_cache.yaml b/Documentation/netlink/specs/sunrpc_cache.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..f4aa699598bca9ce0215bbc418d9ddcae25c0110
> --- /dev/null
> +++ b/Documentation/netlink/specs/sunrpc_cache.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +---
> +name: sunrpc
> +protocol: genetlink
> +uapi-header: linux/sunrpc_netlink.h
> +
> +doc: SUNRPC cache upcall support over generic netlink.
> +
> +definitions:
> +  -
> +    type: flags
> +    name: cache-type
> +    entries: [ip_map, unix_gid]
> +
> +attribute-sets:
> +  -
> +    name: cache-notify
> +    attributes:
> +      -
> +        name: cache-type
> +        type: u32
> +        enum: cache-type
> +
> +operations:
> +  list:
> +    -
> +      name: cache-notify
> +      doc: Notification that there are cache requests that need servicing
> +      attribute-set: cache-notify
> +      mcgrp: exportd
> +      event:
> +        attributes:
> +          - cache-type
> +
> +mcast-groups:
> +  list:
> +    -
> +      name: none
> +    -
> +      name: exportd
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 4e08c1a6b3943cda5b44c2b64bcf3a00173a08db..81c943345d13db849483bf0d6773458115ff0134 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -59,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
>  		.cmd		= NFSD_CMD_THREADS_SET,
>  		.doit		= nfsd_nl_threads_set_doit,
>  		.policy		= nfsd_threads_set_nl_policy,
> -		.maxattr	= NFSD_A_SERVER_MAX,
> +		.maxattr	= NFSD_A_SERVER_FH_KEY,
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
>  	{
> diff --git a/include/uapi/linux/sunrpc_netlink.h b/include/uapi/linux/sunrpc_netlink.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..6135d9b3eef155a9192d9710c8c690283ec49073
> --- /dev/null
> +++ b/include/uapi/linux/sunrpc_netlink.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/sunrpc_cache.yaml */
> +/* YNL-GEN uapi header */
> +/* To regenerate run: tools/net/ynl/ynl-regen.sh */
> +
> +#ifndef _UAPI_LINUX_SUNRPC_NETLINK_H
> +#define _UAPI_LINUX_SUNRPC_NETLINK_H
> +
> +#define SUNRPC_FAMILY_NAME	"sunrpc"
> +#define SUNRPC_FAMILY_VERSION	1
> +
> +enum sunrpc_cache_type {
> +	SUNRPC_CACHE_TYPE_IP_MAP = 1,
> +	SUNRPC_CACHE_TYPE_UNIX_GID = 2,
> +};
> +
> +enum {
> +	SUNRPC_A_CACHE_NOTIFY_CACHE_TYPE = 1,
> +
> +	__SUNRPC_A_CACHE_NOTIFY_MAX,
> +	SUNRPC_A_CACHE_NOTIFY_MAX = (__SUNRPC_A_CACHE_NOTIFY_MAX - 1)
> +};
> +
> +enum {
> +	SUNRPC_CMD_CACHE_NOTIFY = 1,
> +
> +	__SUNRPC_CMD_MAX,
> +	SUNRPC_CMD_MAX = (__SUNRPC_CMD_MAX - 1)
> +};
> +
> +#define SUNRPC_MCGRP_NONE	"none"
> +#define SUNRPC_MCGRP_EXPORTD	"exportd"
> +
> +#endif /* _UAPI_LINUX_SUNRPC_NETLINK_H */
> diff --git a/net/sunrpc/Makefile b/net/sunrpc/Makefile
> index f89c10fe7e6acc71d47273200d85425a2891a08a..96727df3aa85435a2de63a8483eab9d75d5b3495 100644
> --- a/net/sunrpc/Makefile
> +++ b/net/sunrpc/Makefile
> @@ -14,7 +14,7 @@ sunrpc-y := clnt.o xprt.o socklib.o xprtsock.o sched.o \
>  	    addr.o rpcb_clnt.o timer.o xdr.o \
>  	    sunrpc_syms.o cache.o rpc_pipe.o sysfs.o \
>  	    svc_xprt.o \
> -	    xprtmultipath.o
> +	    xprtmultipath.o netlink.o
>  sunrpc-$(CONFIG_SUNRPC_DEBUG) += debugfs.o
>  sunrpc-$(CONFIG_SUNRPC_BACKCHANNEL) += backchannel_rqst.o
>  sunrpc-$(CONFIG_PROC_FS) += stats.o
> diff --git a/net/sunrpc/netlink.c b/net/sunrpc/netlink.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..e59ee82dfab358fc367045d9f04c394000c812ec
> --- /dev/null
> +++ b/net/sunrpc/netlink.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/sunrpc_cache.yaml */
> +/* YNL-GEN kernel source */
> +/* To regenerate run: tools/net/ynl/ynl-regen.sh */
> +
> +#include <net/netlink.h>
> +#include <net/genetlink.h>
> +#include <linux/sunrpc/cache.h>
> +
> +#include "netlink.h"
> +
> +#include <uapi/linux/sunrpc_netlink.h>
> +
> +/* Ops table for sunrpc */
> +static const struct genl_split_ops sunrpc_nl_ops[] = {
> +};
> +
> +static const struct genl_multicast_group sunrpc_nl_mcgrps[] = {
> +	[SUNRPC_NLGRP_NONE] = { "none", },
> +	[SUNRPC_NLGRP_EXPORTD] = { "exportd", },
> +};
> +
> +struct genl_family sunrpc_nl_family __ro_after_init = {
> +	.name		= SUNRPC_FAMILY_NAME,
> +	.version	= SUNRPC_FAMILY_VERSION,
> +	.netnsok	= true,
> +	.parallel_ops	= true,
> +	.module		= THIS_MODULE,
> +	.split_ops	= sunrpc_nl_ops,
> +	.n_split_ops	= ARRAY_SIZE(sunrpc_nl_ops),
> +	.mcgrps		= sunrpc_nl_mcgrps,
> +	.n_mcgrps	= ARRAY_SIZE(sunrpc_nl_mcgrps),
> +};
> +
> +int sunrpc_cache_notify(struct cache_detail *cd, struct cache_head *h,
> +			u32 cache_type)
> +{
> +	struct genlmsghdr *hdr;
> +	struct sk_buff *msg;
> +
> +	if (!genl_has_listeners(&sunrpc_nl_family, cd->net,
> +				SUNRPC_NLGRP_EXPORTD))
> +		return -ENOLINK;
> +
> +	msg = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_put(msg, 0, 0, &sunrpc_nl_family, 0,
> +			  SUNRPC_CMD_CACHE_NOTIFY);
> +	if (!hdr) {
> +		nlmsg_free(msg);
> +		return -ENOMEM;
> +	}
> +
> +	if (nla_put_u32(msg, SUNRPC_A_CACHE_NOTIFY_CACHE_TYPE, cache_type)) {
> +		nlmsg_free(msg);
> +		return -ENOMEM;
> +	}
> +
> +	genlmsg_end(msg, hdr);
> +	return genlmsg_multicast_netns(&sunrpc_nl_family, cd->net, msg, 0,
> +				       SUNRPC_NLGRP_EXPORTD, GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(sunrpc_cache_notify);

Is sunrpc_cache_notify() hand-written? If it is, can you find another
initial landing place for it (I think it is moved out in a later patch)?


> diff --git a/net/sunrpc/netlink.h b/net/sunrpc/netlink.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..efb05f87b89513fe738964a1b27637a09f9b88a9
> --- /dev/null
> +++ b/net/sunrpc/netlink.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/sunrpc_cache.yaml */
> +/* YNL-GEN kernel header */
> +/* To regenerate run: tools/net/ynl/ynl-regen.sh */
> +
> +#ifndef _LINUX_SUNRPC_GEN_H
> +#define _LINUX_SUNRPC_GEN_H
> +
> +#include <net/netlink.h>
> +#include <net/genetlink.h>
> +
> +#include <uapi/linux/sunrpc_netlink.h>
> +
> +enum {
> +	SUNRPC_NLGRP_NONE,
> +	SUNRPC_NLGRP_EXPORTD,
> +};
> +
> +extern struct genl_family sunrpc_nl_family;
> +
> +int sunrpc_cache_notify(struct cache_detail *cd, struct cache_head *h,
> +			u32 cache_type);

Ditto...


> +
> +#endif /* _LINUX_SUNRPC_GEN_H */
> diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
> index bab6cab2940524a970422b62b3fa4212c61c4f43..ab88ce46afb556cb0a397fe5c9df3901813ad01e 100644
> --- a/net/sunrpc/sunrpc_syms.c
> +++ b/net/sunrpc/sunrpc_syms.c
> @@ -23,9 +23,12 @@
>  #include <linux/sunrpc/rpc_pipe_fs.h>
>  #include <linux/sunrpc/xprtsock.h>
>  
> +#include <net/genetlink.h>
> +
>  #include "sunrpc.h"
>  #include "sysfs.h"
>  #include "netns.h"
> +#include "netlink.h"
>  
>  unsigned int sunrpc_net_id;
>  EXPORT_SYMBOL_GPL(sunrpc_net_id);
> @@ -108,6 +111,10 @@ init_sunrpc(void)
>  	if (err)
>  		goto out5;
>  
> +	err = genl_register_family(&sunrpc_nl_family);
> +	if (err)
> +		goto out6;
> +
>  	sunrpc_debugfs_init();
>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  	rpc_register_sysctl();
> @@ -116,6 +123,8 @@ init_sunrpc(void)
>  	init_socket_xprt();	/* clnt sock transport */
>  	return 0;
>  
> +out6:
> +	rpc_sysfs_exit();
>  out5:
>  	unregister_rpc_pipefs();
>  out4:
> @@ -131,6 +140,7 @@ init_sunrpc(void)
>  static void __exit
>  cleanup_sunrpc(void)
>  {
> +	genl_unregister_family(&sunrpc_nl_family);
>  	rpc_sysfs_exit();
>  	rpc_cleanup_clids();
>  	xprt_cleanup_ids();
> 


-- 
Chuck Lever

