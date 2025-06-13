Return-Path: <linux-nfs+bounces-12452-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E7EAD95D4
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 21:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1277AEF01
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 19:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106071A76AE;
	Fri, 13 Jun 2025 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hZqxDUdG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CplYTSCc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443AE23A990
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749844669; cv=fail; b=Zv7tmOiQfyiVDUEgHG8etS7ImIpQ2iLe/+it5FYptd7pwmCpo/dbHy8ntib5Y17LiJM8fqhsGdwECXpTbPLpFSgSUN9YUtsxMcgIF98I8+OGVrv+njyEMbR4aXCCb75JwEOtv3Wg5io+krB3QSmTbR2Os97edJXGzNfHM+wIDLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749844669; c=relaxed/simple;
	bh=4ynYzr2nImNet0B7ErpbycK+VEgry8EcRn1JzkkpGY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JT7DozY0xLmw+yZMpoIY5ltbrTPYYu0qSz+qYPRHaQ/sMo2rZxt6VDZCC3ZaXvFdD2Q/CKJrJJx+dS1/TLhqxEX5GSP9fnK/SOZit6kT7860VLhBoauBsoxnD4Nwaw9L5bkYKczBMNfRE+RuGPbGvUvY4nl7uli87HAEPjccNZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hZqxDUdG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CplYTSCc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCtd1C023692;
	Fri, 13 Jun 2025 19:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wzEGBwCNy0Ca06bCjeGObSTXzgZVd+7OXID6w16es38=; b=
	hZqxDUdG23wkr+R4k3X3G7qjppz+fMqpD+0CT8whei46ZIcl9fWC8INV8NKftJ+P
	3NaChQTwPKzMdwb0ireriAb/d35lvh/AUTvjc41QM+rXjzWBPCdE9ZBqut638NZn
	wF/c1EDxIJgW4B74bkZA+H2G2lvwCk0KmCaQCsl57hnmXZgdH1vPKIMMb+kJLck/
	DJ1zoip8ubkSnJjWmk+VS/XZNON+Q8yQFOYTvCYwv9C4CVupLkD/wtW71viXt7jC
	W/OCalblM2FdmIqvGNfDcAUMdiYm7skzBJkteYqx5WLPOiIMETuXda76d9/4uYK9
	OE+fONsPvp6QuczCGYKxWw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dadc3wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 19:57:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55DJNJ2g013193;
	Fri, 13 Jun 2025 19:57:42 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvd1y58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 19:57:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRLLUgfNB7IhRdE2WDDnNyy2vQ4ahWCOp9gbCCYejzPFNlvU8AgIp7eEOd9S+oS5Zjdg8KXF1pAT4P0yxzBtBUD+eaeVhQqN2EqhUo6XX3K+ESvdj9bYRJNSR+7cVob5Eu1LWFbN48AlL6ydzA0mPePxhK6/CN9pFA8XslcgZF8JHSv+R5oPjjsOYExnvvrgD69fIThDv+E+5Z1YkF/aJ8XnxUwVDE10EdohplUsWYkyCvAwuRKD9SLn5jkWyPWr+3rl560radrobAhqC3WKsZX0Om4Z0THkImralsqn0OMQMft6fZyLGQx+LOMFOkYo9Jy7qmJK9FotzcOQbKg5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzEGBwCNy0Ca06bCjeGObSTXzgZVd+7OXID6w16es38=;
 b=nCE/HYZhZpa6JMvw8pzFg/ZLFu90ZLm5ZpC/U5LcP82/TKAk4uUZua82B0zU53Ilx7y9psUrOQyEUxK5qs7iwrMZEBk6A/A1tT05VPlEWTO/cqnOwLYsA6naWFMWq1ojaOA4fFh3DXD23RfhQ5WqgrQ4zTCFPir7zyeORFr3gEPHK7N/wWJYfVymNgwx9CPmxtlmjpXS4lfZf5t5znRWMKc+nuEEeArDjMCXF7WSrfZz4i/La5Bj+ZTH7Bjt1NzB5iKVuxVhkqDzXUiRQwuFEVad0X1FJS5x1uARCVD1bi0FH19AUWNdzKy716GU+y4Wri8f6ZVvROM5hZMDFBUebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzEGBwCNy0Ca06bCjeGObSTXzgZVd+7OXID6w16es38=;
 b=CplYTSCc69s4HhzEIeDATD8xcYY/EhQutoL7U/fuTzVGkwaZ4qnniF5at6Y33fsXjX//j/lCwOUq1wM/64JEu3LSHs6I8N3VnT+pCLgX+yr5dEZkG/9w7V618PHgYkcaH6Yl+j2O5z677tZfLnyqQvfLAuEEWiNFRduzk++/IBA=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Fri, 13 Jun
 2025 19:57:35 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%3]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 19:57:35 +0000
Message-ID: <ade5761a-7914-4282-9b0e-383bd6280268@oracle.com>
Date: Fri, 13 Jun 2025 15:57:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunrpc: fix loop in gss seqno cache
To: Benjamin Coddington <bcodding@redhat.com>,
        Nikhil Jha <njha@janestreet.com>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20250611-fix-loop-in-seqno-cache-v1-1-9f9214d60dbf@janestreet.com>
 <6C5A0113-E08B-4C5D-B2D2-85FBEADE30F8@redhat.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <6C5A0113-E08B-4C5D-B2D2-85FBEADE30F8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CP5P284CA0101.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:92::8) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SJ0PR10MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f3a115-8ac5-49f2-a3d1-08ddaab489fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzUzVEZxNi81Yms3WFhjQkoyb1JNWm5UQW1VZzE1MlducWFmYyt3S2k4dWpt?=
 =?utf-8?B?VzcwTVhZODZNUGYxd0s4d1F4TzhmcXUyaEZtem5SbFArVlk5MG4rU1piVVBt?=
 =?utf-8?B?REdBNjNpTGl6WWJ1V0VwZERIRUd1MEV2WDF5aGNaaEhlcjh1TC9QcmFROVBH?=
 =?utf-8?B?TUJRQnZjVnVoSWx2Um1ZQ0lMbGQzK21FSkdVUDA3ZGV3WW9tNE9CclYrdlZU?=
 =?utf-8?B?blZ0Znc0dUlNWnpkcXFocFdqODFQVzR4bXFVOTR5VWM0OWNCcE9MdmFjaDFj?=
 =?utf-8?B?ZW44dExWdTZmNlA5aWJRZU0wcGtHREV4OUkzRmIyVlNrMVN5ckdqOGs4S05h?=
 =?utf-8?B?b3I0eUVQd1pLMFcxV2k3bXRQQkc0MExab3FLSDZ0Rkx4SUJCL1pvZnV2Tmoz?=
 =?utf-8?B?T1p4TFlRQXdBNnN2bXE0OFpXMVdaVEdTakhabUNCdTdKdWlreDFkaEtJK3FP?=
 =?utf-8?B?NmlxRjNTazRnQ2w1b3ZERzcxUUxta2JDNVR1OUtQSStYaElEblRjVWNMWXp5?=
 =?utf-8?B?b3gramMxRmdySElldGFNVTIwOVZHd1ZWcXBGdFNxeWs0b2RKejJUM3BZUWxt?=
 =?utf-8?B?THEzYXcrRjUvSXpHTksrMW12YzJVdFp1UGVXbjhNL1dTNnVKVmVJSGdMR0Z4?=
 =?utf-8?B?ZTJLYXZoOXVGZTU2bDBqd2tkTXl5YTV3cW43VC93clR6VzByWTRpVTFQeEtv?=
 =?utf-8?B?Sm1JbzhkMFdnREQ5WHl0Vm10L0N0alI5S2xxSzNwb1VCSVBuN0Ntb2VRWXo5?=
 =?utf-8?B?bE9ycEJCYUl5ODVqdFgrTk9uMjlFak4vMDY2RHhYeGJ4QmpWbUQwTjRBZXYw?=
 =?utf-8?B?SytncmM0V25YcEhHUkNyendKcVpkMTQ5NXdHVExKQXkxck10V01zL21LQTdu?=
 =?utf-8?B?dy92eHc2NUMwR05OWldNcjAwalcrdUxwK3lwNENjOEJjU0UrTHBRK0VoNVNQ?=
 =?utf-8?B?NkJTTUlhT1hTL1h4ZGpnZGZpUzc1VkJrNlNpMER6QUZkb1dQMnc0RnVZM2hk?=
 =?utf-8?B?d1BTS3BMYkxDclEvd01lSjdXWkk2Q0xYbWM5eUsvdkJQLzdSRS8zL3lyVDNZ?=
 =?utf-8?B?K0ZBY3JDaytEZWhIWjNITFpYWkQ4MTBVR28vK2I2WTBGenhkZ3lReXRoSGlx?=
 =?utf-8?B?R3hFSk1RNWVlUjlHUEQwMmpocW42S1AySjFsTkczcWs4Q2IrVFZITXBmTytC?=
 =?utf-8?B?Mnd5UzJQRnBvQlhES1loNCthdUdZNUZ4S2ZKWmozZ3ZJcXNZRGRzMGlCQ3pH?=
 =?utf-8?B?eHowaTVROTZJRk5yaVJWQkZ3QVQyWjYrZ2RORkd3SWVmeGFYOEFHczVxZXM1?=
 =?utf-8?B?dnNKbzh5S3I1dk5BWXVzODhBd1Nzbkt5a0dmV21jOHZCRlJYQTF1WFFEUG5Q?=
 =?utf-8?B?YkRyRW95YkY5U1VTdmR5UWFqRS9QODJSSjFWeGtXYy9FTkc0Z0hZODBhK3Zp?=
 =?utf-8?B?ZWVvcWh2UHM0anBwa3BKY3NoZzU4blVhVW80L1FUZlNLMHhReHNKZjkxTlZZ?=
 =?utf-8?B?OVdvUFd0dHBRRkNyYlljS0RiRU1RMFFaejd5eWkrQkhSRnVQREd0akc5eWVY?=
 =?utf-8?B?bHArUmoydkY0T2RvcWk4UGJ4T2lmd3NOVmVEZUNHTS8vdjczaVdWVHFVTDJR?=
 =?utf-8?B?Um5DOEJJc2U0aWJGOEVteTljM29uUzFGYWdGY004MUtHWlVSUnNKWEthRnhp?=
 =?utf-8?B?ZHNRTCtVNkV2NzhOYmNWZ0xGbU5Iek1DOTRlQmlVS2h4aENvTmpPY0VUL0ht?=
 =?utf-8?B?aXh2bnlLdEZwdEJDQWlOY3U1VkFuWmN4MDhhQmFmdG9yeU5aWFJCVlhBSkZH?=
 =?utf-8?B?UFZ3MnRGOUI5Mmpjc3UyS0pUV0V5SEp1Sm1LQWJyUXZFU3hTMWxMaXpsQUxr?=
 =?utf-8?B?ODRzd3NwTm1ndlBQQ2VDT29GaXVhQ29DQllWN3R3VEUxckRnSmtJSkI5QlFk?=
 =?utf-8?Q?xeVN7PTz95I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHZGQVkxcmFkait0NVA4VUc3eGlWWVVZRTQwVVhENTREWncwbDVYRUx2WEJk?=
 =?utf-8?B?ejJUWVQwbXplakd4dFRLSWgzaDlUaGlxMVViNzZxYmFVUm1ZMk4yUjR0MGlZ?=
 =?utf-8?B?QW42aVIzSi82T1I5c0lIMmcwc0o0OXY3UWdzMXBDK3VYMC9DbTJFTHRBcWxW?=
 =?utf-8?B?VHJEYzl1aHNLajM0empaR3UzckNGTHFncWlPV1BqdGUvKy85QzQ0clRFWEJN?=
 =?utf-8?B?RlNSMnlQSG5MckcwdnUyaDlUL3Foa1NwUGNiWGVjbEJoQU9aSzBGOG1hM0N5?=
 =?utf-8?B?WkZ4NEJsWnNhRzNTUGROcUw0OU1Ucm1zZVV1Ylo3YTZuU2o2VVczWDhPTkU4?=
 =?utf-8?B?dVpnTk56Y2ZvNTYyYkZvZnhLMjdBa0dKdGtQR1BKT2lyNi9yT2trZVViMWk4?=
 =?utf-8?B?QmFyOUxidS9tWVJuNDB5Qkh0dTBFS2NzeGNKSUlGZFJFaFZTSHUwNVlpalBv?=
 =?utf-8?B?TFpVL1d5Y3BJVGZHdTZZcnpTcmltQ3NEZWZGcUtwNHpRcEZQbVZYaTVSSnBT?=
 =?utf-8?B?SndkUGNHVWZFcGlpMitMc2RrNXUwYjFGUkN5bmFBaVlOT2U5b0hsQXFSUGpv?=
 =?utf-8?B?TGUxazA2WTNrSGlhemlIdzR0MTk5L0hrL09xZksvbGFSQVRFWHlUeXlic240?=
 =?utf-8?B?ZThUMnZ3NStla042bnhaZWtjR0pFT3d4dUxrakJ3djNvRjJZYXVIbDBMR0RJ?=
 =?utf-8?B?Ryt5TitOMUdQaURtSXcyNmtKK3VYakk5emxNTkZBSkl1Q20yc2JLOGZMZTY5?=
 =?utf-8?B?YkUvcCtNdjFHZWVJVnd4RS9HUXJBSU5nc2hVYUdoWGIxbmpydmNYOHRjdHE3?=
 =?utf-8?B?ZG9HdjI5SDhETnpzWTc2d0ljcENNV0RzN1hCTitUSDhmcGhHdTJaSkRQLzFB?=
 =?utf-8?B?bXJnbVYvanlHSGdEVUJWYVBjbFBHc2g5a1NZT3Z4aERDK0JRZmJoMFlDRjBX?=
 =?utf-8?B?cUowaEk3TTFFdHRzMm9qQ2xmc3NpSlFXT0M2OHF6TUdpY3pRRGszeHhaSmpW?=
 =?utf-8?B?ZVd1VWp4OG84SE1odDc1QkxqVTB5V25zRmZpWU1XUGVVZC8zeFltaUw3M1cx?=
 =?utf-8?B?d3FFRWtJOFNDUkZEUHVpeWJsTnBPYzBvV0pwcVY2WHR2aDFBM1BGUnJXVm93?=
 =?utf-8?B?NDJFaWp6WEMwOS9INXZFSGdRazByRloyYWN1Vkt4dTRSdHA1aXRqQW5ENklW?=
 =?utf-8?B?UGJDRWxEMFdlUlk3K2o1YjFIL0RXUW4zb1hRalpubUR6ZnZoa2V1M1pTZkhN?=
 =?utf-8?B?aytoYk1JWGtrcXdJemxyWHlpQlZTaGRjWUQydlAzK2ZEaThuaUwydEExZThi?=
 =?utf-8?B?cEJSd01xa1lFSFhEdmtlVzExeEVhOEVRSFRtMldGdU9XYnJ1NE5IeGo0ajQ0?=
 =?utf-8?B?MmhsRGtZcVB2Q0dySzUxVTJXa3FySG1jU2R3ZVNONWN6aGVRSHl1cmdZS1U1?=
 =?utf-8?B?ckJqODU5cWZmYzZoNnFHeTNBSEdlTUoyQ3E3SVNSRzZRVjIrbEY4UkdUN1hO?=
 =?utf-8?B?WlMra0xBM25QZGlqZVVYYjhaajVMaUZ4cTN3OFYyWkF2cDJtSFZka1ppS0tM?=
 =?utf-8?B?Q2hxcExqbVYvQXVtOXpkK2NncWVvalNja2l4dTBOKzZOaElndVNKZUlmTGhq?=
 =?utf-8?B?TVlFK1djS1FuNEM4eHUwamFBdmlpRm5CUVg4RzJzaGk3TXlJaFVKdUZnY2Yv?=
 =?utf-8?B?cGZVS292OWxDRFo5T0pqL1k5UE4yQmtKbEJlbTJIY3dvR1p6a25FMCtVbk1q?=
 =?utf-8?B?WXl6aXEralU0QVU4NndGVkJraUgwRTBNeUVqRDl4b1JxZzZwRXVVSnFHMXkx?=
 =?utf-8?B?SkZrNm51UEFCbjE2WXFaSVB3TEx4ZmtUVFZ3Y3haS2d1NlBUUnY0MWpXa293?=
 =?utf-8?B?Nk9aR3lQYVFxMy83UGFkQlY3K3FTdWJ2cmwrVGpKWXFtRHhKRnY5UGFnWk9T?=
 =?utf-8?B?NGJnVks4aFh4OWVYMmEyeFQ1VEdCajhSUFJBTDQ1TUlNRmNrWFNIUW9hMGx1?=
 =?utf-8?B?dTdBQzdVLzFUazArSjl1cXEzRGZjOHJFL200R1J5ZXhvMXdKbEUwOUR3OEQ0?=
 =?utf-8?B?Rm50RTlCYVowQWlvdFRSSFFTWlNSRHRUWDBVVXRHTDJ3V2JMNlZZWGRwdTZ0?=
 =?utf-8?B?eVFOQzZuSEEzaGNMRWNlbCtoVGlFb0JGQ2VNUGVBNXNjVzZFSVVqTGl5d2tJ?=
 =?utf-8?B?THdjV1p4TURxc1M4M05NcUROM2JGZFZ4cFd1eFRmSFg5eEdEWWIxQkpsYUxT?=
 =?utf-8?B?R24rUTU4NHNzUzl6a0xDTTh0ZlRnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cCi+C6pT+L37+QwxkExliRdMpUP05Dw7Yf7eOSMkN7v9GQPz6oG1jIKD2dZqGo3sS5vLah0GSDqx9AcnterufTJEC1ZftB9dpCzLNcMVJcxGgFyRIXstHya6IQq92BljBcYzXppE2fcfJPisV0W4vUX6HEcXIXTA0gw2wblJg1eHgb5PrEv5waKuxBTAC5gdRLm3CvzrAERNP7dJ0Lgq8fg6JQxR3Jm3/DuT/IeZBCbAHOdfcKZOJVQdH3FS9qFLZF7vCJThEvEMteH+JMqlippzrjQxcsWsd5zmA0980rEyu3t+Hyg1wD99Br3Yi7GHf3Vnrvmdk5lltYtzb/wxXEXPs0DOgKKqFKAM+w5g8mixlQ0XxFqj1ivIOCYuGMEzWvoOZ76AmjLOuOvzaho2b2UzKS+5t7D5C84qfxT5aFQ1/gA9SGTtzn3gFc4zpFNb/1T825qXkUBlKm2+klhUrDcTLlleigwv0W0V8cOvSI0McLKyC66reN7I/cYBBxt+5DomYsiNbNPi61RihujQtLRXTOT7goOmMcBD1FbKBb4gNjJ8ic3vyAEXde6p2kjkJmq0RdDPNJaSdWejJyys7h5shbAy+MpII5WRVBAz/VI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f3a115-8ac5-49f2-a3d1-08ddaab489fe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 19:57:35.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNnPCqgQYTwnDmPLOAcQPdePHkkmoOPzcSBJpJkYUGwh/fBJlsTxdA22Rl2JUF4J+d0ApuZz8sb8pg1hIR6X2pMb1xLG0Q0lRq50SCc+Ugk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506130138
X-Proofpoint-ORIG-GUID: FDrFC-wMxmr1cVEvzaS7d4PM1Fr1GLgJ
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=684c82b6 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=h6pNz4pCAAAA:8 a=20KFwNOVAAAA:8 a=2r5qvGpQaVRLmLR2334A:9 a=QEXdDO2ut3YA:10 a=ZpoZn5rNyLF8gW58NSEC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDEzOCBTYWx0ZWRfXxLQ8vmsWFRW/ fi9Ynqd11adbVWVJtRZn3U4FZ6JgWJLTrPmPdZhm/ySdgYwttyszNd4fNX0uVin5Doe8iL/ANXn rwywTLIerTNkDWxt9rEZwMyTI+zf4Omncac0hGZVOn0ScbPaUh7DywIoxLQgbcdUm819REqzJ22
 l9JU21flur6hscxjHLO5FNmLBODJK/9AroqtVrOEWUzM1Yy+x1sjI4+B+jYjCqL2Mb295Tfd4CI L5JcWDOqXHvUmC+G1uqQDau/qkWIxXZj9tSJXYRjMct2QlIpG86v+1EfTVOMU95U4PCf1Hs/ezG nLCfpBboA5C4Hk+588tySDYRvjwJTak7ItXqWcNVy1bODG/dOGfroBKqj2/12NWEZg2UggHe8jE
 x7iqJxeWnC8v+bOhHcd6M29AbV58nvOAFT1v7IlRy91S8vqI6pp3uzbvbHAGsgHv56ra6Cax
X-Proofpoint-GUID: FDrFC-wMxmr1cVEvzaS7d4PM1Fr1GLgJ



On 6/13/25 7:12 AM, Benjamin Coddington wrote:
> On 11 Jun 2025, at 15:46, Nikhil Jha via B4 Relay wrote:
> 
>> From: Nikhil Jha <njha@janestreet.com>
>>
>> There was a silly bug in the initial implementation where a loop
>> variable was not incremented. This commit increments the loop variable.
>>
>> This bug is somewhat tricky to catch because it can only happen on loops
>> of two or more. If it is hit, it locks up a kernel thread in an infinite
>> loop.
>>
>> Signed-off-by: Nikhil Jha <njha@janestreet.com>
>> Tested-by: Nikhil Jha <njha@janestreet.com>
> 
> Fixes: 08d6ee6d8a10 ("sunrpc: implement rfc2203 rpcsec_gss seqnum cache")
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Thanks! I've applied this bugfix to my linux-next, and I'll send a pull request
with it before v6.16-final.

Anna> 
> Ben
> 



