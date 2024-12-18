Return-Path: <linux-nfs+bounces-8656-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE789F6F15
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 21:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02D4166781
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 20:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8F617BEB8;
	Wed, 18 Dec 2024 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G8e57yuz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lgr5kuj/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D7224F6
	for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555332; cv=fail; b=l0dU/saF4HCZJ37ECXiPHEkLbYlJBfR6qSw+uAv+gRUjZFpi/cgc7F8nZ7jvnyhVqlI8ujvI37Cb8fXEUa7S25i+U565pywzRH9pleQoRMqtUwbyfx9MHAzgygXwCO9LbQVzhvIPigIXUvHft0E6qawm0HQ3aPvuGYFSaZUQiLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555332; c=relaxed/simple;
	bh=TdJC6skkjUVs4qQ5biexptzbpHHkObdLMrOD3C51mHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gNIiHg1+QwV69ZYKxyKq1sHvxANHTAYCqeFrz4X2lb8M/dZM8oVhV0aRNokRSlMIL3awG/uS/GHjMfRgs2jKv4GjMpylLxdEQtl4tYUw3qXSvpmE0yjy6el6ef+NVCJSmGhRjMwevDC4X8aV1PfuPH98H6r7ANgScjTpRn8B+GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G8e57yuz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lgr5kuj/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIKIcLq013087;
	Wed, 18 Dec 2024 20:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Qq84Q4Kt71WjOGSrHILet8+y9i3ElaNN8yo6lcaiYFo=; b=
	G8e57yuzXha99cPYhdFzNPyn1LJmANCsRrKUa9f1n6SNIgcr9FwrJXGc/QH714eo
	zlk0TDj6+CTK3Fje0fcohZXgwBHVah70SwsDzOXHHLeZNaxdUgCfkFv0LNTbrcMW
	+j1NiQYtDBUEIF0cWo5sUfgwG2il9ZzluPV90Cqkj6ayItb748Ov68f50LtFcLZs
	LA+GlM9tWz3K2SeAhCabUxhmMVku/J176C42HISiIC0/+mPtxJw2qoWvZ8lOYZqr
	tk/yCSOiD8R0/dhV7fcDMv3fJXQPK/DB2PahoE2ZlT9PfZHQ4FH8k9NuMpfJ/pQ4
	BnRcNzvnDg9LQkfQhNEEug==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj5fdq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 20:55:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIKpZpO010895;
	Wed, 18 Dec 2024 20:55:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fa72j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 20:55:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLgGAhYCmI6cttTl6gYqliMt12NXq54WFY9ZhTGkj1rl6TN3v/6B9eVxWlTOlNsTTVFZ+A+zEDVzdaLuxWtptN4tpaZY78iYUoVMtUihqdvJBDKAcYMWRVae+Jbyi11YhUWo+vrkXlXCLBsnUn5iY0+ENn5YRJpuveSG4wSuP1AyJoKmckOwLoHiwrj415DvJXn0t4t3l0w1VmRQttun0pcmh+dF5UR3JIhlce04vc0RYjdp7ErqtZ7NhnniBlIH961KyPnObFXTmumqSj4VJlDgVefUZtsAgOnI11v5DiqVzMxGkujqO4ZH/gjy+2Iy0O7buVLlRdJEeRQglUYqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qq84Q4Kt71WjOGSrHILet8+y9i3ElaNN8yo6lcaiYFo=;
 b=Tjxp9v+NK458t/OXQl9LApaAyfwubmYcySJL50HzX78ar7nXNdGFF0CSE8fIA3R6iygSEXzBpAIhio1miGFatanQXyiBJrgjho0j/MUemSDQqxZfAWOGmUFj185PwibxxMcGIT3R+NjOZc1DiMngOi/a8ps8blhBJypj0u6jOambVP02qGq0bV+4JJ92xTLlkBKXpV9GjjFjbnfBBbxdN5FD+UMAGzObWNnCUfHKU3B22z+PZRabYxqlQ8CeBw0sCo/gFiWP/3X1bRGjWU5ExryxzRjDqYW0EgtGR9NHf/bqIl2nHQhjhBw5cbOhB3/RmkqTc3p7cfrteSHdBWzzkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq84Q4Kt71WjOGSrHILet8+y9i3ElaNN8yo6lcaiYFo=;
 b=lgr5kuj/+czrwPiyKZ0ibqUce1jmCrVSvO62TOTFI6/P1smCRtwACi0sb3bn5x/Wanxane92OQ7pvJXueS2P1soUOGRbF3m1UvsUwKEnwh5Ctw+Y9btyppJ43VPgNrVGX4hNq66XpSZgQr0ZfvhO8n8OH6W8Z38SxSdf3nl9DuY=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 20:55:19 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 20:55:19 +0000
Message-ID: <f0d7f601-a6ac-40d6-9665-e9a40e2dc00c@oracle.com>
Date: Wed, 18 Dec 2024 15:55:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [for-6.13 PATCH v3 00/14] nfs/nfsd: improvements for LOCALIO
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org
References: <20241116014106.25456-1-snitzer@kernel.org>
 <754757a44ac96f894c82338ec3212cf7202d540a.camel@kernel.org>
 <Z0E-e7p5FtWWVKeV@kernel.org> <Z2MG3X_PpbJRNzCw@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z2MG3X_PpbJRNzCw@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::24) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|PH8PR10MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 350aec6b-312a-4f52-bb57-08dd1fa647b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnR4V0xqd0VnbVgva3NJdFJDcjlqUzdxaHN2Ukk2UFl5dmJLVzRvTEJLVGU4?=
 =?utf-8?B?RDdGUHcwaGxldlpaQTA2YXhrVlZBcjFFVkJMZlVMaHNIMC9FZ1J5czEyY1Bi?=
 =?utf-8?B?WGMyaEx2cXdQaDV5NEZYOVduMEhiSEQwMlB0YVRZMkh0Q2tSaTJuRThEejlh?=
 =?utf-8?B?blk0QkJCTDNpT2tHQ2xkY2E5VEt5emc3QlkybDNwaWQvc3p0SVdPcVJEYm5r?=
 =?utf-8?B?bS92NXZ5ekhFeGdBTGFLZWdTYU1TWllNUzYrQmk4N3lTd3p2QVduL3R6RkVi?=
 =?utf-8?B?emdLSFYrRWFGWkdMODMyUE5CQW92eG5ydjZMZmRWRjhvVGFiMFE0eEtTbnNT?=
 =?utf-8?B?eEMwRDlPSWdEbU1ZVC9mOHdYc2tIdVZPV3ZCL3J3MFN0a3JIUVRUYjMvUnpu?=
 =?utf-8?B?dXYwOXR2Q3lTVEQ2TFNCT3N0SW9ZUU9qTUNDR2RONDJrRnFlSUh3OU9FdGcx?=
 =?utf-8?B?blBGWGFyNmdkN1FWM0M1bGN0b05nWmJWY2piclo3bjlsN1I3V3ZDblBsOUhL?=
 =?utf-8?B?NkJBK2xLRUdETng3cEYzQ0doa0xkQnRFK0tRc01qd2NCMmgwZm5MMUNnZ1pC?=
 =?utf-8?B?OEhVSVM0UWNOYVQxV2RzTDVNWkVRZlVXbTR3S2JuWUNuQmhhZGFGUnkvWTJ0?=
 =?utf-8?B?K294bkRjaThKaU1Ja1JONTBUL2hUZTh0aFh2WmpHdHc1Sk1ycktPZlZHTHkx?=
 =?utf-8?B?VTVXd3pacDc3MWRneHprTDMxQUVEWXFPQ0NKMC9KTWh4YTlYRXZCUWhNVzJv?=
 =?utf-8?B?TUkwQVozQ1kwYWtnbVRmVWlDVGdJY2hLNHpBSll4QU9vajFhNm4vL3g4cWF0?=
 =?utf-8?B?a3pFaHFSanp2NFJtVUF6STVjclBKN2RwaitjTTBtN2dzNVI2ZDhOdG4yWlhu?=
 =?utf-8?B?ZHdxRHhXcElzWDZzNGErRUpoNmk5L0RlU1lhYnZKa1pXOHY4UHUyZ3ZRdTVP?=
 =?utf-8?B?RjRsOEZ3ZGVHVmVWaGhBSmZQR3Rta1dBbElyVVF4NldJRU1IWmhHR09UVVhJ?=
 =?utf-8?B?cDZDdG5Od1FCS1hJR09vVTdNcENFZDZrSzlwTWltOXpmMDBGd3Q5VXhEVGY3?=
 =?utf-8?B?RE5NY0svbklJR212M2dRRzFKNnhUOEFrRnJvOE93SHFNZXZJYi9uUE41VWdK?=
 =?utf-8?B?ZXZwUnV6OU1tTFZNeVNrN25BRit1OTBTUkthcEJkQWVjekY1ZnVFMXdzYmdU?=
 =?utf-8?B?M285TGNNRDZYMjNOdy9oQUJOczQ2S1BFVUE5aVRVbFZiNkRRK3g2Ti9NTmlL?=
 =?utf-8?B?bU1GbmMvMFhmVVZJVGNiTy9mdVNhYkxOTWQ2NmN6bituQTlJbUdQU2RUS1lw?=
 =?utf-8?B?SDZnY1pMQkkrMHNmQU0xaFJzNzlqeVhpUzBuV0FaejFFVjFxZGdOdEtVcFNP?=
 =?utf-8?B?Rm1tWVNHS1g4VUlSYUZIYkhZUHVlV3ZZNnVUaWZtWGhjdTNvSEl1SDJYQmhV?=
 =?utf-8?B?Si90dXlnMFl5dlpRamNmTWFuTTRwZldHMkl4ckNSaXpwMGxWQ0Z0dXZzL3cr?=
 =?utf-8?B?L1B1QWM4L1NTOWxKZU9mZHJ0WE5lM1BJZ2EzYzNhWFFrTW01S1lHSVhScnMy?=
 =?utf-8?B?ZDdUcUtXVGVsZnR4QXNUV1lTdmJlUmk4WEhWYkJHMTJ0RnJ4eStFbDhUTmRi?=
 =?utf-8?B?ZkoxRDRHNXo4QStiMU1XMzdUMUIwaWRlR2pCd3FxSkEzSE5XSFdueFd6VDhE?=
 =?utf-8?B?TTNwRk5iSXc1RDFpYTF5SWR1UG1OS016d1lxbWcrSHZTelBKUEtjbkZSZnZI?=
 =?utf-8?B?NmhTVU9NeWRGOExNNC9MZ1dtdWt3OTk1VGgrN2pSMlBPL1EwcTN0NHF0WmYw?=
 =?utf-8?B?Z3pZK1E2UXZ0eFlvYm5TSTNoZEdHSk5ydlo0VE1OSUs4cG1kSS9vZE1pd0pv?=
 =?utf-8?Q?FZiIu1fubZ8t9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UStrVkkvQXo2ZjFSYkU3emdaOUxhdDBLa0JYWlNPSXFDVjZ6MXQ4cDFUbmhJ?=
 =?utf-8?B?SGJucXljRk5HMk1zM29ya2J5dmQxYjY4amNWTXdTZVQ4R043dC9sdFNwZk4v?=
 =?utf-8?B?eVJJdHdzMUxzN3RWZEg4NnBDcnJNcHJVVDI4MitnVEJKQVY3dVVmUVFkMVk3?=
 =?utf-8?B?UFIxUkxqeWJLM2ZuVE1jSFVtOGwxZ1NNdkcvRm8zUjdBc3MyYVc4MmtwcmYv?=
 =?utf-8?B?eHlSZnpYYlZmKzJZS0JOMlNyM1lYNjc5VTVWMURLeGpJZGlqaExnOTBRSWIw?=
 =?utf-8?B?UFBCcHBLa2FKdGI0UFFQUUhPWnRuT3ZQczAzbTl1WmxnUkdsVU4vVHJ5Njgr?=
 =?utf-8?B?cEJKZmFvUUFxMmVRSFg2cGxVSjZNSU94eUU5d0FFdDFlaXI3R3I2ZjFVMUdT?=
 =?utf-8?B?dDgxL1VTK3Z5K3Z3dk1TaWRWKzJ1TDZha0RmekRYQ1VwM09nRUJCNkpodURo?=
 =?utf-8?B?RFpad0U5djU0VmxwM0RlZWJpcGg2MTMxTkNkZWhHV05tTHJkYWVGY2RKb29O?=
 =?utf-8?B?Yk5kTzlhcnpaRjlkZ0NZT2ExRFZHRVd2SkczOWJnVTJiVlNWOXdqZWVXanlh?=
 =?utf-8?B?UFlsVUl6em5NelhDWW9rRGxtN1RRVGVycWdiMUxuWTdqNEM5ZTFVdmVLako0?=
 =?utf-8?B?QzVnaVdLOVNBbk04dGl2c1RINCthU3BldUR5cUJCZXBhU3ZzSVZzTnNqV2Q1?=
 =?utf-8?B?SkdMdkpQMXhaTzhRbUYvblpIdGlOQjR2NVlqOXlrY2pwb3dZRE5GbE9SY3Az?=
 =?utf-8?B?NnNBQjVERkFxS3lOcE1QK0Z1UGRJMzZBTzlPU3VUdFZLYW14Rm5ZWFRiU21N?=
 =?utf-8?B?UnhCM3lqR05keHJOVGErUXhSaDdHNkRpbTd6UTVBdnJ0STJ4VWo2a1lvN2lO?=
 =?utf-8?B?bk45ZFFmTHRXdTBVRkpMWldYdVhjYmZpb1hrd1lrbnV2YUEreTgyMVg0NDli?=
 =?utf-8?B?QnNOY3RYQXMrNnA4RVVJanJEZGFnOHRkbVF5Sm5HQ1pkQ1I0WXB6T3dZdFNS?=
 =?utf-8?B?TDIwSWxjaXd2NWk3RmV4VXRicnAwSC9DZ3ZkR0RydzlPTTNvcysxMllMNFpK?=
 =?utf-8?B?Ymp0aVJ2YjhseThxTk43eEd5Q1FiK05pY090SEtkMHpFUHFJczljTmpveG1y?=
 =?utf-8?B?eTEyanNFd0U3UTZBOG9JbnNmUlMvZUpDaitOaUE5eUZZa1M4aDljZmpCR0Qz?=
 =?utf-8?B?c2Urbk5CamFpRFA1OUc4Tis1dGhLOEpKZnJmNVlBZldpVkF1QnVwZ0J4dXlr?=
 =?utf-8?B?VXpqSG5qS3NhK00rSWdsbTRoenVaMkw5d2ZoUVdSVWh1M1pFc2liNk1HRWZU?=
 =?utf-8?B?dmRNbk5LNjI5UnpEd2tZNEdvaDRxQjR5Uk9oMXhGd0YvWlMvSWgyeTFZUXZG?=
 =?utf-8?B?T1ViN0k3c2RFeHpPZTR3UWlNQWEzQXVmRmh0V1IwWlJsVDltWm41ZnBIZ3Ey?=
 =?utf-8?B?NUxTYVBVaG55a3A3ZHFXbUliajZKTUl6aU1YM044N2h2RFpoOXpQd2dTTTlB?=
 =?utf-8?B?VFlnZW9QUHdQaklJMnY5cmZUN3VHbzNNSUJWeVNWSnp4a2VITytTN096cTNX?=
 =?utf-8?B?NlVjdk02SWhYZklpMVhNa2U3Q0duallMeUJWckxzTXNLUm5hRDN2V0tONnly?=
 =?utf-8?B?MTQ5ekNybjNJOVFZQWN0RjkwWFBzeCtNaXNiVk82OSs1aHl5TVBkYVAvd01X?=
 =?utf-8?B?R0gxbjd1dVN6UkYzYTc5djZVVHVFeG50Q3hQc0tuWXdXZWU2R0hxcERFcE9S?=
 =?utf-8?B?V3NDMFYrampqSG5ybnFnSEgvVmNiYUpwNnZmQnhwNU5zcURBM2VxazFvRUpC?=
 =?utf-8?B?NEtybkdweUsvblEwWU9uOURuKzB1VVp4L0VYTzVQa1MyMGx4L29Bc2h2V0E2?=
 =?utf-8?B?VDErbFc1cElsb3YvQUNicjZnK0VCWENTVmZ5eTFOOW1ONVNLZkZoR00rcTJV?=
 =?utf-8?B?bmtjMlhJcFpyTVA3WVpYS3lPVUI4ZWhFdGt3bk9neExVYkhlalM4SGEyaTN5?=
 =?utf-8?B?dExFbTYrZm9ycFYyNDArbFN5U0R1UlMyM0xlUjZLTGdpQ3hXcHVzcE82L2th?=
 =?utf-8?B?bXdwWld2RjZOYWNJQ2kxaEdTV0hpenFPQ2FJWDFKdTZQdit3UjdFWTJabzF1?=
 =?utf-8?B?MWJYMmp5Ukc5T0duOUVwVi9POERWTlVYa0xkTEtWbXRjQ3NEYm9YeDAxNkRr?=
 =?utf-8?B?VXIwalVTdE11aVk4eWtaNjBwOW9RY2pUaFRReTR5RjV3Z1UrQUF2YlQ5SmNN?=
 =?utf-8?B?dHdIZjU5L083QU1MM0JTNXRsaGdBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YtYPX8gLaFWW6a3GF3veqbJf174wC1wzCRanbhIkgmsiOBiW6ltXfMVz3m/Zgmdu6f/NAqboo9EHAXB09pqfGOJnA5nfDPhifYWc6wbKvF/CbWXk1/KAxHdyPROljaGLMP1vj3THSdSRQmnplRib2fF4CVF3tihJPNa8Hm5bD5wNwv+OkWcL5QTw9yRQ62bl3Q5D9pM63MZmjFPLV7jmCPXWugnEOpw1/0OqAxV2Pykl2leFUcWoUSdG1FJA2OHOh4/oueORkwolvUWcf5IEDUuoY+r+jXCQ84yxeUrtDP1klfNTRGYfWjW8Ln+liRDXB16KuSWNwcnSYvtRrObLKHPiiFL1cT2zetpla9s6QQO65s/unSl6wDwu8KFZwAl4fpgOJOcXqhgeUBqZg62gNMf9llvfPAKqQKv+XdQnTLr0Sw3y2b+GkTPSYF8WwYYoSRrTw5XmJyWOx4nWg+NoyIRJ2KuqSUzxe+BrlGXcvryhOCnzFKOLWPEsM/ufvOc6jLhzVBHOrkv+RrIwS0ENewZPr1W/ALeOEULmEaxbaA/plCLGEi5PnntncBhDHm3CxOmPsdZbuEtHWeMTth6m67wQ98unbbKzKXuWBeU8jkI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350aec6b-312a-4f52-bb57-08dd1fa647b4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 20:55:19.2633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lc6KIj4ys7nPuWCToOVvBwM9HETnnNLtbluO1uCEGu5R3zY22cwQ5hEEttJHqVRoOxkrqchWOBdAOhVNV/KwIDHkmU6kPYYWKT2/j9+UH3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_07,2024-12-18_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412180162
X-Proofpoint-GUID: 9HzJoAMS6pKD-TQ-dBSFALfRMompZCGr
X-Proofpoint-ORIG-GUID: 9HzJoAMS6pKD-TQ-dBSFALfRMompZCGr



On 12/18/24 12:31 PM, Mike Snitzer wrote:
> On Fri, Nov 22, 2024 at 09:31:23PM -0500, Mike Snitzer wrote:
>> On Fri, Nov 22, 2024 at 12:26:39PM -0500, Jeff Layton wrote:
>>> On Fri, 2024-11-15 at 20:40 -0500, Mike Snitzer wrote:
>>>> Hi,
>>>>
>>>> All available here:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
>>>>
>>>> Changes since v2:
>>>> - switched from rcu_assign_pointer to RCU_INIT_POINTER when setting to
>>>>   NULL.
>>>> - removed some unnecessary #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>>>> - revised the NFS v3 probe patch to use a new nfsv3.ko modparam
>>>>   'nfs3_localio_probe_throttle' to control if NFSv3 will probe for
>>>>   LOCALIO. Avoids use of NFS_CS_LOCAL_IO and will probe every
>>>>   'nfs3_localio_probe_throttle' IO requests (defaults to 0, disabled).
>>>> - added "Module Parameters" section to localio.rst
>>>>
>>>> All review appreciated, thanks.
>>>> Mike
>>>>
>>>> Mike Snitzer (14):
>>>>   nfs/localio: add direct IO enablement with sync and async IO support
>>>>   nfsd: add nfsd_file_{get,put} to 'nfs_to' nfsd_localio_operations
>>>>   nfs_common: rename functions that invalidate LOCALIO nfs_clients
>>>>   nfs_common: move localio_lock to new lock member of nfs_uuid_t
>>>>   nfs: cache all open LOCALIO nfsd_file(s) in client
>>>>   nfsd: update percpu_ref to manage references on nfsd_net
>>>>   nfsd: rename nfsd_serv_ prefixed methods and variables with nfsd_net_
>>>>   nfsd: nfsd_file_acquire_local no longer returns GC'd nfsd_file
>>>>   nfs_common: rename nfslocalio nfs_uuid_lock to nfs_uuids_lock
>>>>   nfs_common: track all open nfsd_files per LOCALIO nfs_client
>>>>   nfs_common: add nfs_localio trace events
>>>>   nfs/localio: remove redundant code and simplify LOCALIO enablement
>>>>   nfs: probe for LOCALIO when v4 client reconnects to server
>>>>   nfs: probe for LOCALIO when v3 client reconnects to server
>>>>
>>>>  Documentation/filesystems/nfs/localio.rst |  98 +++++----
>>>>  fs/nfs/client.c                           |   6 +-
>>>>  fs/nfs/direct.c                           |   1 +
>>>>  fs/nfs/flexfilelayout/flexfilelayout.c    |  25 +--
>>>>  fs/nfs/flexfilelayout/flexfilelayout.h    |   1 +
>>>>  fs/nfs/inode.c                            |   3 +
>>>>  fs/nfs/internal.h                         |   9 +-
>>>>  fs/nfs/localio.c                          | 232 +++++++++++++++-----
>>>>  fs/nfs/nfs3proc.c                         |  46 +++-
>>>>  fs/nfs/nfs4state.c                        |   1 +
>>>>  fs/nfs/nfstrace.h                         |  32 ---
>>>>  fs/nfs/pagelist.c                         |   5 +-
>>>>  fs/nfs/write.c                            |   3 +-
>>>>  fs/nfs_common/Makefile                    |   3 +-
>>>>  fs/nfs_common/localio_trace.c             |  10 +
>>>>  fs/nfs_common/localio_trace.h             |  56 +++++
>>>>  fs/nfs_common/nfslocalio.c                | 250 +++++++++++++++++-----
>>>>  fs/nfsd/filecache.c                       |  20 +-
>>>>  fs/nfsd/localio.c                         |   9 +-
>>>>  fs/nfsd/netns.h                           |  12 +-
>>>>  fs/nfsd/nfsctl.c                          |   6 +-
>>>>  fs/nfsd/nfssvc.c                          |  40 ++--
>>>>  include/linux/nfs_fs.h                    |  22 +-
>>>>  include/linux/nfs_fs_sb.h                 |   3 +-
>>>>  include/linux/nfs_xdr.h                   |   1 +
>>>>  include/linux/nfslocalio.h                |  48 +++--
>>>>  26 files changed, 674 insertions(+), 268 deletions(-)
>>>>  create mode 100644 fs/nfs_common/localio_trace.c
>>>>  create mode 100644 fs/nfs_common/localio_trace.h
>>>>
>>>
>>> I went through the set and it looks mostly sane to me. The one concern
>>> I have is that you have the client set up to start caching nfsd files
>>> before there is a mechanism to call it and ask them to return them. You
>>> might see some weird behavior there on a bisect, but it looks like it
>>> all gets resolved in the end.
>>
>> Yeah, couldn't see a better way to atomically pivot to the new disable
>> functionality without it needing to be a large muddled patch.
>>
>> Shouldn't be bad even if someone did bisect, its only the server being
>> restarted during LOCALIO that could see issues (unlikely thing for
>> someone to be testing for specifically with a bisect).
>>
>>> How do you intend for this to go in? Since most of this is client side,
>>> will this be going in via Trond/Anna's tree?
>>
>> Yes, likely easiest to have it go through Trond/Anna's tree.  Trond
>> did have it in his testing tree, maybe your Reviewed-by helps it all
>> land.
>>
>>> You can add:
>>>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>
>> Thanks,
>> Mike
>>
> 
> Hi all,
> 
> These LOCALIO changes didn't land for 6.13 merge, please advise on if
> we might get these changes staged for 6.14 now-ish.

Works for me.

> 
> Trond and/or Anna, do you feel comfortable picking this series up
> (nfsd cachnges too) or would you like to see any changes before that
> is possible?

I'll go through the patches once more, but they should be fine. I will need Acked-by's for the NFSD bits from Chuck or Jeff.

Anna

> 
> Thanks,
> Mike


