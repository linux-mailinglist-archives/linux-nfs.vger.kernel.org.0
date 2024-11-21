Return-Path: <linux-nfs+bounces-8181-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF849D4F64
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 16:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1FB1F2251A
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E471D0405;
	Thu, 21 Nov 2024 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PLG+paDP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s5//LbN8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C7AD2C
	for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201593; cv=fail; b=oyapqfwc4skSFpWaPYv5a0WVUZX4Z+fxv62hATV1JLt8wnfV9PuD5Q/L3pAi7yhrniPlH7BpC5dM51CKiYYmSjxf4VeN9p5dOv3c2i10m9QAimna8DXvyhl9Oa7EtuiSHPhegEN7UNv+tPAvYcY3MFpwp+uM2oWtEqzFD//VbL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201593; c=relaxed/simple;
	bh=litTkMCXmaQhqHh+vIZvLprH99YHW0k2zDFQrVPtC38=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fWwtCDIXDZEO8O0wmnaTPzhukb8yAwzZonjYUtYYB1veT/KMzgixr/Hsys8Og84PibDGWUCkm5zSX4KyWFXxy+OhKElwe5PH3MtYHH9ZZLhXtPBDFeeiUH9Od0k3NyV3OPigHK6vNhf8+EcRitzw28bwpkMK+eFm1UhA5YFDbLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PLG+paDP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s5//LbN8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALEtVOI019473;
	Thu, 21 Nov 2024 15:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MaHaCXBkfRPmKCYIX33wZsqp0gJJQJy4MKkDZEdv8fo=; b=
	PLG+paDPhEIhd7VMNApROQXjGBF7KzdYGw0G4cOJYwwNOIJo5CHhb/M8xUpiDg0G
	rg+EI4Vr6aWfHX1BpMQssq75lydTkrB1NAq6Eex8fcZhn+rA4/FK/GqTc6LvMcOA
	MeBIK1fnPxK4Xpu/d2YOvt9n4o3mvx1QQ8l6+1iEAmzD+jax+TvP8izpQ3rZt8sP
	kU82wjLUthPzk4WiDhJVfmwqVsVo38FVPrFuX+b1YbvlDxdF2p5KodaH1jDDBMjF
	zeJUVoKsqOh9WBQGhOANFOqklO1DsegKPTZadOQl2RYVW6fYyeLZk86I+9n9KD9b
	3/i8CcDbCGbcNix7UP1zVw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0ssv33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 15:06:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALEI8gM037036;
	Thu, 21 Nov 2024 15:06:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubtxnw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 15:06:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fimsncKmrCBRFYnvyqy9yq+R5WnZvTS85RRh5NIjJjwfCbnUvU2VquMQP/hzJYD86YWNSXtg1Fn11WrsJZjYX2jURoLkVjvWKSGIZT1lDOKSBKj2Q/jPw+RMJTNOt7eax+mXowQ9t0coT+Ko4b+FwjhzcHqGOiWivWgshVZEZT9vOQGvVwPEHsHNjIJWWZHaEqjfEVb/aHkjzI39N/EIKFSlYjq42QhwKXrhIigwhq3AThSIjj/AyLgO3lh2tWv9TRgmsNKv+1cCDQA0+pHSgK7uxsOyhEeYijFQ1kJk8898lWnIpDbxYqDX/YWml1N2CNoXsBG20gYCIpR5yEhPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaHaCXBkfRPmKCYIX33wZsqp0gJJQJy4MKkDZEdv8fo=;
 b=bE92BjqQhCpXV2kV9E8nV9w7jj7jtzxqatVOLu/sccX8keSxqlehZBADfTfNCg6Io2815ldlruwP0SO5BoxiU2gok/RjEMOOoQGZ+gLM/1yWodDunV8Y7bYU8hFo8ez8ps+UvtGTX/6QahLBcuQhOOdOCYsI8eUzx9kGIDxdLzAPtVaFu9Os9YRKTPPb38ubZjH1yTYtRHM4e6ofdsalmMwjWkmO3HIJ3N/8zE1g7RyHPN0BzehszkzgI0I5Mb0Om0SjlRe1snDB0Udc4pChUMlVvxAa7PE2FblDzSdiLCTIQ5snp22XPR0dvmTnBhTHuxQgIfpcx7nL2yRDzyWrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaHaCXBkfRPmKCYIX33wZsqp0gJJQJy4MKkDZEdv8fo=;
 b=s5//LbN8Rw0k0gow3FoxuB0P55njat7o90i1qe6mVZ4x5y80Jwn93dmRNWVgR3LuW3ysFhs4Vm/L8erne9RjPIDC+f6VebhwoJsZC0HtvMVlkyMaK4fXfg3AlztvdEiBecIGErFOP2fYDhriI8L0Lj+YR/PMLNNzkedSh6VTyvE=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by IA1PR10MB6050.namprd10.prod.outlook.com (2603:10b6:208:38a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 21 Nov
 2024 15:06:25 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%6]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 15:06:25 +0000
Message-ID: <f688220d-0814-464a-9915-c253b777a0f3@oracle.com>
Date: Thu, 21 Nov 2024 10:06:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: WRITE_SAME support available in NFSv4.1 mode?
To: Dan Shelton <dan.f.shelton@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAAvCNcByQhbxh9aq_z7GfHx+_=S8zVcr9-04zzdRVLpLbhxxSg@mail.gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAAvCNcByQhbxh9aq_z7GfHx+_=S8zVcr9-04zzdRVLpLbhxxSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:610:77::9) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|IA1PR10MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd52473-3972-4fee-8637-08dd0a3e1168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmdocUpPTWROTG5UUjRnejZyQ2lUcDkxcCtvR3VUMEdpUGJTclhLNjFrQllw?=
 =?utf-8?B?b0VGVGg1ZkdwQTA0dks2NUtOK2tZWjJhbktQM2VhS1BEY25YYXZSUzEvdFNz?=
 =?utf-8?B?cWtSNnNjV1RrQzc5Q0RTNW1DN0J6STlYbzlzSyt0THJodk9vUm00bGViRTIy?=
 =?utf-8?B?OXFVbStnV3ZNR2EzV1hxQnFSSGI2SHBJRzJhdnI1WStVK2hBL2JrNERjUVN1?=
 =?utf-8?B?Kzh2bUlLQUJRMnN6dVdPTmM4ZVl4MldKRGZpUTlLVFpnajZTMFdpZGc5RGo3?=
 =?utf-8?B?ejdDVzZPOTlzMm9adTJEbmFkL0FvQmdJdjA1MzQvbm5wV1ExQWF1UTc5RHVE?=
 =?utf-8?B?Ny9IcitiTzQ3UUNGVkVDK2xlSkJ5cW80VVNhK05SOHVnNmVJdk10d01OdVFS?=
 =?utf-8?B?Uk5kV015YURrNVp4QU9pd29qNW9va00wT3dBbFJ3SnJob1JPejMybzRiRks2?=
 =?utf-8?B?TEhZdGIzekUvZFU3bUN1Z3BEV0EyREFvbmx6MmsvU0dMQ0J0MXRuWmNMbFc3?=
 =?utf-8?B?TDRzSm9UY3Jid0xGRE9wczVCRjRVMXBnTVUzd2xzUEVmcThZbVpxRTRDRnNm?=
 =?utf-8?B?S3k3WnpqMHB3Zkh5enNZQ3JWYnNiSHI3QTkyN3ArOVNTNlRWUTBDNXRPeXJ0?=
 =?utf-8?B?OTNTWVVyK3J2YllPWlZ2N2tpbVg0TEJtbll3eGY5enJTZFpOZWl3WWZzL0pN?=
 =?utf-8?B?VUN4VUU4VjV0RlJsTnoxSHVCeVA1VUdJWjU1NTgwQ2M0blNlT0FFRE1tNWVw?=
 =?utf-8?B?THVwT2c3Nyt6S0RTOGFIRjJMMUtTTXcrN1JKcUplTk1MWUxldU1VVERuc3ds?=
 =?utf-8?B?S0VIZFdMU1NGdmsrdTA4d0xtNTh5ajcvZ2twcEkzek5iYTVYc252eXZneHhm?=
 =?utf-8?B?ZUJmaEt0NXRGNUxpd3JLZEVYMmRYQkdhZTh1QmFnNTZNdy9OV0FWMGZFZHUz?=
 =?utf-8?B?b0RCcy85NmRsMml3NU5PbVlTc1Y5UUJlQ0NSMVhFbDdlNjNMR25ZRTRKeDh1?=
 =?utf-8?B?OW10UlRISmhwb215YzAxd3hVLzZZNWJHVTNrTDl4MG5ycnI3TXJ1U08xR0V5?=
 =?utf-8?B?cWpzNHpuS0llRXMrR1Q2NEFEOTZtN2lPaElsWHQ5M0RkYTZhY2RRWSszN1cx?=
 =?utf-8?B?U054Y0plNzd1VVNQR1lWdHdHYTl4MzM4WnAvSmZPU1h6UVkybzRQMUhOYXdO?=
 =?utf-8?B?Y0hYSHBHaWtnQ1p3bHh6QjRIR1BHR003ZTVuNVRVQzN3VWtqMzd5Y29QR0p3?=
 =?utf-8?B?SFVxcFVzb3dKTlFTS2xrTjFpeGsyNVUyc09rYjB4YWV0U0ZWU1hBd2lYWS9j?=
 =?utf-8?B?Z1Zwb2l5RFduUkhoWG9FWkVoNUVBU0VwUXgzVmp4ejkwZ0FXNEZkU0dWTUx3?=
 =?utf-8?B?ZDg4UDFEWS96Z0Y0Y0FobVhQVU5ZYkZTZFFmTHhZYno4TEFMOCtnbjBCT0tJ?=
 =?utf-8?B?Zk9MdHFjRGVCTjg3RDFQNHF2VlRUODZmUm1YQlluTStUOC93S050VC9MaFZT?=
 =?utf-8?B?dkw1cVNZMWc1TENVUDA1VG1rU1N2M2t0NkV3d0djUjRteGh6bE03Wm5hTmN1?=
 =?utf-8?B?WEdMZWlBZThrcU5ZSjJoNGJRMHNSWm5vakRBc2IzWDExNFU2eEQ0bjRndHk1?=
 =?utf-8?B?cmR4QXZLby8wMThkdkd2Vjh1VnlxMXRzd1UrWVo1Z2pzNVZuOVhNL1R6WURK?=
 =?utf-8?B?WG1pL0FsSWNQRDZWYmFXbyt4OExNRlFQV0p3Wk5qdUxNcDhRb04xeHpRSDVa?=
 =?utf-8?Q?A6KZT6GIeD9IyNNJXTbfTsWYU/BHAg9zHeY/FT2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHhTcmpNUFhqcGJrMkhwMGhibUdSN3RFUnZKdVRSUmpBU3l0SmM5QVo1dXJt?=
 =?utf-8?B?OFpTaUlJYzQ3Tk5EaHdML1E4RDJXYjQ1TDFRRnhabnJBM0dwUTIvVjIyRmli?=
 =?utf-8?B?bGFTRlRYNVBGNlpOc1JkTkNxM2hISzRyMGUvWTZFRGxaVFQvRlFJeHZtM1Jj?=
 =?utf-8?B?bHFyZEhvVlB6amFXZnJMQ1FGMVZ0R0ZDOUg0MEpIYmlxRW81L0FBQUF2eGJz?=
 =?utf-8?B?dU1ybVZUb1VUM0RiUzFqNGJtczZiY2RGbjBKMTdReVBuMERCQUdzL2MrNXpt?=
 =?utf-8?B?Q2xKSk50ZXBCSDRRN1JrY2N0R0RWT0V4UEJ1M2JJU0kxMTlCUnB0bVdJK2s4?=
 =?utf-8?B?L1NoUUhCVHRyZGg4KzZXUTFoekhKNHJqejhpaG0vbi9abU9XRDdNeGZJUmJx?=
 =?utf-8?B?REZVWWxJTmtHU0k4YTViY2oxNjIrdzJNalZmVEI1ZHhVdWwwMHJLT2I2eUdW?=
 =?utf-8?B?RlFiZ0F0MU93NEhlNnMvTzM2MTlyY3dzUDh4YmFXZ0xDZWNPdkYwSzk0ZWxl?=
 =?utf-8?B?RENEL1l4cEttaUlQd3hjaklsV2daUmdvWjNzeVRWQzFLSzZqZm5BMlFyREFI?=
 =?utf-8?B?SHdQYjl5b3VOY2JienZVV1YvT0twOHZWcmhwbGh3Sy9QS1JUSWFvN2Zsd3N2?=
 =?utf-8?B?NWl5MUlSYkZSclc4QWFQcENmOGZWUllpUTYydUt5Vmpuc1BtSFdBaDlDTjha?=
 =?utf-8?B?Ynp0by9nakhvK2dQSk9SWkxRYW9sZ3ZqUzAyallMS1hHMkJZTzNjSnpEK1hw?=
 =?utf-8?B?em14KzdqWXVnalo2cFRKWUp2R3hySnlvS3V6S0l4ZzdiOWRHWk1aMU5QOUVT?=
 =?utf-8?B?L0pkY1A4REYybkRsQzYwR0MzbElZbmR0U0twdnZMQ2JGeFl5RDBjL0U4aTla?=
 =?utf-8?B?WGcya1ViVU1mdGxDSkhZazJmcWlhdThqNUlLaVlKdDVjb0dVVWkvRG05TkZu?=
 =?utf-8?B?Q2M2ZWd5bE1tdEVtRW5SL2pTTU9LQWVObVNKb2tVZExJNU5JcUs3aGh2Y0hE?=
 =?utf-8?B?akNncG5ENlRTd3d1UzlTbVo4T0UvUFJhTkgxcVJpWEdnR2VVRnZjRUZwQ1RG?=
 =?utf-8?B?MDdvcnlYeTM4b1h0VFBnSHdjTkN4M0FxNzJJUUtTVVNZY1JQczVzMXJUTW5N?=
 =?utf-8?B?Uk9tbHgvT2RCOXpwSk9nbGFzeUJXZGRvNVRJc05ERmxuMm9XRjRvbG1rbC9M?=
 =?utf-8?B?UjE3RFR1MkVsWkhoN1NkRnpEZE9IbXdXMkthenJQSFlHN0RvRUY1bmtmeFcr?=
 =?utf-8?B?V2preHRCaHFuUDVmMHMrOG5OZjRid0o2Um85Um4zb015aU9qbGgrT05BZ2dy?=
 =?utf-8?B?bngra1hFbGVxRXhHdzhOb1d4NHpSM3FuaGVPTUovMGxEbW93SXhNelNRakFa?=
 =?utf-8?B?MVBuM2hxRGxQSmVhQlRjT2JPQW4xZDEzeFJjL3dDODM4OHVNY0srY2Q0T29B?=
 =?utf-8?B?RE94NUcwTTRpcTFndUpHVU4yTkZSWmpiMmdMSEV0NlBoeUVxRjJFc1Ivb0Fn?=
 =?utf-8?B?empadVA2VzZDL28ydEVmNG8zSVFYL0RmQ2dVcjdIdjJDcStYOFNudExJZDNE?=
 =?utf-8?B?QmY3cEJFVFRXeDdGSjVnTUhMV0RXRkN6K0ZHYWV1WXM4V0REQ2pla3ZqWXFr?=
 =?utf-8?B?WVZ4WWhPbkg5UENrREgzQktYZlNBbEg1UnlhejJ2VmxhdW9xdzF6QWc4SGZr?=
 =?utf-8?B?NGxvanAxKzV0TVRUcENiRVdSOHB4NG9vUkQyaDZoMEgxKzJnREZOQWpvK0h4?=
 =?utf-8?B?ZGhNL1NrV1VkYnlmS25wY3B4WStzS2ZTQThLaTVKbWc5cU01Tk40YXdGanNx?=
 =?utf-8?B?NVJZcTM3UmlmeWxoaG1sQ2Q1RnB0c3dyN0psTzBaMUVnV2pldVZpY0dhaXVP?=
 =?utf-8?B?eW5MSFhsc3lZV1JPUUtUYlVrdTVNZnJnQndYdnVYQnZpZlBLQWVEaUJGVS9o?=
 =?utf-8?B?cUV5cTVvaE9RRDhBVURjY1NCV0tOM2VXOXBXZFlaZitIUkszbktIQWZYS0k4?=
 =?utf-8?B?VkM4SnZhSEhydURaai8ySHpacjd0M1pWb0pWQnRSaGZBYzdSVWpaYjhIN1Na?=
 =?utf-8?B?Y0xFVHZVcy9PYmVVQmxuTVJ6MkN6RGpobTBpZ1JueVJ5NEZndHhDWGlidTNv?=
 =?utf-8?B?SVllN2IvcSsrSGRaWlBDWkxZS25ySXA4TS9OM0U4c3dwU0FNbnZEbDlxY0gz?=
 =?utf-8?B?c0x1QVZObHlKV2xPMmtkK1NyWWNZUWczQTcvT3RsNWRVZWhMdG81U1dZekNk?=
 =?utf-8?B?Ly8yWEJVd1hONnozNzlwOURVUG9RPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cT2BI4me43O10/KqJNNaB8/Xa7bm/vLwITgw2Q700GwL4x0WggSsWRAQUMDAqVl4irMPigx+2Hp7yAzsGZjHu3kZyx9bA/mLUAz9olgBRpiOI2WGFwMezub9d/AaxOjX7/XT/AyN10/aaSeHttpm3VA54E2ji+zzJv9hiGsLrCNjonbMdlHqYvyRI8DOl2ZvL4l8OTzTMH5qRixbDjtFs8A14KwNBVx5ccz3ZCJAzxiSbQOJWbO04kciqjX/yS+TNz2j3aCS98quJpVfprD/fgrH/mecztxr4j7drOfmjHs0jsGyW7qw+HIpUYR0QypvTD1sybGf1KGFVZmN4d1z2EIgkzYdrixa+wcLKBptU05gNUTNTT1MVduNMlJkVxjnTOHjLwqdvz+GKqAOMQvv3JgeH/mw83pVyVUq04M2Tbt/XaF3hgdfUIGOqqzBe7EyP2id/knldEkoGdtp5oqoWG1v5QynvUjrjjGFwCJEVZJ+t0vdZH1f4suRV0oLgR0/JTtEU7alM14/wfGctLzSDKe9I+H0S92PG/0+7dGwHfvxg+MagM6581aFpKohuf4Q4d93RGEXqtqyN0qKFWDrsMkknlXLguCKJ7tZB9dU6JM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd52473-3972-4fee-8637-08dd0a3e1168
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 15:06:25.4768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAESNBmzKDos/2XyEpoJrCiAQoGkKRhyz94Pl8CECYnXQWzK91SyBQc23+o+UTOTgNUJuHNieOOxxxzAJ3bqSsr3z3ab7xVng7XwUV7jsxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_11,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210116
X-Proofpoint-ORIG-GUID: SXR-BF_op9_wJUETxdTZRZ2Qp-3VOrhl
X-Proofpoint-GUID: SXR-BF_op9_wJUETxdTZRZ2Qp-3VOrhl

Hi Dan,

On 11/20/24 6:40 PM, Dan Shelton wrote:
> Hello!
> 
> 1. Is WRITE_SAME op supported in NFSV4.1 mode, or MUST a client
> support NFSv4.2 first, and only then WRITE_SAME can be used by a
> client?

WRITE_SAME was added with NFS v4.2, so the server must be mounted with v4.2 for the operation to be available.

> 
> 2. Does Linux nfsd support WRITE_SAME?

WRITE_SAME has not been implemented on the Linux nfs server or client, and I'm not aware of anybody working on this feature. Patches welcome if you want to tackle it!

Thanks,
Anna

> 
> Dan


