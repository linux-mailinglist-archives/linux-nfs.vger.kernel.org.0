Return-Path: <linux-nfs+bounces-12866-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AFFAF6630
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 01:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DFB752103A
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 23:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E961624FBFF;
	Wed,  2 Jul 2025 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TErm++8G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ArWEcXke"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF08248883
	for <linux-nfs@vger.kernel.org>; Wed,  2 Jul 2025 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751498791; cv=fail; b=tXG0MAGZvIXh0EGSfExmwJOVjWOFXd8Sjek0rkpaMV53hfAuz6VphC5uLh5p62MPsPUVlry0f+6UVWy3+tW04XpjQpz1gMAdoxMYRhaxIfopP7asRu/GP+PlfjQCkYjwjJbhm+0eKtwK3sWTA884ro6RA971AV/C274ZCs+UmCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751498791; c=relaxed/simple;
	bh=5C7w1tGOVCgLzImgXQZKixpSMWxhEzdkrEB9MQBWhag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YY+kc/hovdK3m+BVDEaLkgZ/3JpMQewrnBm/W7RjOl7lcb+hD8hIO51g8y+AcZI2m0XrnUo0pAARSyDEI25gjy/hgM3L+MwHRoOjatKJMFbAuQe11CbjKqPCVJB4gBgRFnZ7eOy6BZVRsubYSR4aD1yNiKMFMf1ThcVmdao3hZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TErm++8G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ArWEcXke; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQefi014146;
	Wed, 2 Jul 2025 23:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mnNFGmOXx1Sc+QkBhNothV7TwBB6VLZMSbsUXtUMKgU=; b=
	TErm++8GPOxguIiIvVY8gHnHYfNc2vic6JspiYA1shghHLkSUebFaD1RvdYyCyVj
	HjqmUvX4bD2O9lN1dzANtWqC+5HEyQ/t8/oC8kKI72uMOT4wrPp7j5QM12cyBHMQ
	WcQRHgsfQGUHLs2AM7VB7giV/hm/aEJF9Ma96U7WnjQMHKVl/gXv10W5d6FD+1QQ
	KWbiisZK7tZ7AhXl3NEVwTYFiuLexOgYSZXc523bKDPGMegdSClpAlonXJZhtCXd
	abTlFsv/WRVZwEXUNJ+2vBN+1EdLVDbs39HnGIZyDuxkE/VcmCD2JOZBvSX7E6F4
	4fsPs38JAzexvXS3EoaHCg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704g0yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 23:26:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562Llnjp027484;
	Wed, 2 Jul 2025 23:26:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ubv1q6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 23:26:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wj5uscX8CFCAldNOYKeRNGY8GcNiFHrxUdz6M4CjO0qNrfY3WhGqRsAHbmWG7IGkMkt4rwyJtcNjE7pb3+Yf3Fm7n4HxMDBSAymoTD/ImM/lJYQjgXVVZbSjtGklkS/VVfsKZMA9hijZ3qkUPkhlhbKjNSPLLr0TiFio4AjMHF8xnXcDEILyZ3AdcMMY0K+3skk94CsFt7Fe9aNSYPC92R3Nz+5QOr418Mz1EdmWH6X7BidLCeI0K/dWWShs3BrlX+R4g9qDvsSwULwmlDuKmaJWu09SaRkjZ53fIidnmiztn9g/dPcEcZm7t7MhhWfailPjs//xWkB6X0DzdMOSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnNFGmOXx1Sc+QkBhNothV7TwBB6VLZMSbsUXtUMKgU=;
 b=JBl5scF15mnfI7l+Qm3/AAENPf+F78pZg4RFCNaA8RkjfGGVZI2loPBqqaF8v32xPnE3Dslv+jKCReuFHDLbs7uB93N9XKKpxq/vkW0ZsU3wF61LVZZKbwqDUgs4YANLeHCeCAZzQpfvw7JRcakDonLj2e4Twg6XsICrUBqD5IcWuIu4nZcxW51e1q91QvfV4fG6WStTH3jCWETuYsqq2TZfyBSw/dW1eWrPfuUcIyZzZJbMh07Zkk1GSIZlZhLZWPZ0a9olU2R78ELwOq+CHlA7PQ5zLD7aPXs7LYMPNlOSD3IW4hmivNfM+hywT/uzuM2IZUEF2ll4k7xAe2yfjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnNFGmOXx1Sc+QkBhNothV7TwBB6VLZMSbsUXtUMKgU=;
 b=ArWEcXkezV4I+P0IXdF4uwQvqJd6v9N7vStx0Xk6ZhkpuJTy2tY9Nnb56ZJ6RYawVSIYGDJK2MIGbPnW2frlFwa3sjNZqLvfcBCQsYaNQ0x3PSG9OOFkxvhYo3HTMOCn58OAO3jVPRk0/Yz3iTayECODqQWWpSdmvJGHNLcJHi4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ5PPF1849371D1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::78e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 23:26:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 23:26:04 +0000
Message-ID: <7de72319-95ce-46b8-8aa5-33fb211aaadc@oracle.com>
Date: Wed, 2 Jul 2025 19:26:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v2] nfsd: provide locking for v4_end_grace
To: NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jeff Layton <jlayton@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>
References: <175136659151.565058.6474755472267609432@noble.neil.brown.name>
 <2ed77c1d-787c-4abf-96c2-72821e73d565@oracle.com>
 <175149132125.565058.15666202434202898775@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <175149132125.565058.15666202434202898775@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0045.namprd18.prod.outlook.com
 (2603:10b6:610:55::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ5PPF1849371D1:EE_
X-MS-Office365-Filtering-Correlation-Id: d97622de-f41c-4367-8d32-08ddb9bfd05f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WU9kcDJwTWV1ZjlqM0tSd1dJZ1Y0bzF5QXA0eTN2YjIrckU0Z25pMktlRDlw?=
 =?utf-8?B?YlVzc2NtL0xadEFpZDErS2V2bVFidGdFencrRHgwRnFPQnJGeWQybW1OQktk?=
 =?utf-8?B?bTNWYTE0T0pXdnFOMDdwU2lReTFDSzc0OFJrVkgwN2Z0dTNXc0FwSDYwQ1Zp?=
 =?utf-8?B?MkNSTG1vbU41ZlJ2UXE0dDBQL1IwUVlDN0tLT0JCaXY4ei9wMm12UWYzNHBv?=
 =?utf-8?B?NXFLNmNNZEM5WlJyb2JRNGI1a1U4TEhIandwR1lCSmM2NmNMT0VkamJNL0JN?=
 =?utf-8?B?UGdXY0hkUXFyVStIcVdKWEY1RmxocThWdnFBZlR5UWpRRVVXVmNMVGJEQUJr?=
 =?utf-8?B?VHlZOVFNYUtDWWcwekJMQVZ5QkpKb0hyd3NKQTdoRVdiUmhrZWFISC9jKytP?=
 =?utf-8?B?enRIWXJTUHUxeVZoMmVubi9lckpHZytrVk5xNzFMVXRMT1YvdXdQbEU0dkxj?=
 =?utf-8?B?UDlYYXNXNU5RQmFvU1d2RmpveGM0NUxVVkl4MjNMeHhXRitURTdzUDRGWjZx?=
 =?utf-8?B?YUd6M1U0S0JZSDJIUUhmZzFsb1NjSWRZSHFxTnNGZXVhOGdubTJaUUluakhi?=
 =?utf-8?B?NFZ0RFRSU25GMCsxS05TbitBTW5SbVYzUHozTTVmYlhEMmVITW1lT29XTzBt?=
 =?utf-8?B?M3N2a3NyNEhhaEtkaGhJVzdKSXRpTlU5YVVLQ25tUWpkbzc4cG5QcW5LNGdk?=
 =?utf-8?B?YlIyWFM3MzFJVzlucG5OYnMxeXhlckJXRmxVYWJhMjNUdC9ESmVtNUd0dy83?=
 =?utf-8?B?N0NSMktXb01HYWNBWUV4bnlkaVdHRWE0eU5DVFdHRnpQUHFRUVplamdjTWpL?=
 =?utf-8?B?V0xySEhXWWFxTy9TRWVEOSt0V0JDcGdvd2xMOVlyc2hONkVzbmRFMWN1UGFp?=
 =?utf-8?B?dnpzTmtVUEh0WGpxOW1rZHA0MUE2WGowTVNwQXR6RjJmWEVnaVpwcE5BSW1m?=
 =?utf-8?B?c0FSckFIamVaVm5QRWdGcGJjSU9xTGJ2YW5JdG9zYlkyZTRybXZad1hWYUJD?=
 =?utf-8?B?Z1VNZDAyWDh1K1BQcy9iN0xEQ09DSUgyTm1xZ0JpSUZwN0IwMnBSblE0S1RR?=
 =?utf-8?B?MmVjb0hyajkvVGh3R3V1NERJRVhSYXZPc0RWU3RsSVNDUWVQZ21Ec0tPaWZj?=
 =?utf-8?B?eitzRkNlR21peWdGRS93TkJpRHF4cThmTG9kaGhLeTRBUVVBRnQ4UnRsMHJK?=
 =?utf-8?B?M0FDbUxYQjArWWROTkJYUTNVZU4vUGErT0xrUkRGVEwzaE1NcXNETlU2MmlV?=
 =?utf-8?B?RWtWbk1hOGJESlVhazNmWDIrT2RBcW5oMmx0WnZyUnZyWTRlUTM3YjhOenhD?=
 =?utf-8?B?ZHNsUVl6QkRGaGZwa0xJem0xR1hzV2lxaXRlTVE3bzVKZlpHS2xzS2Z1YmFk?=
 =?utf-8?B?M2J5U1ZmeXMvRlQ2dUdheDJkWUE0M3EyVVVZN2tieGZWUkhqMG5HejJoVzh0?=
 =?utf-8?B?Q3Rud2dTYmpNMnlJbm5kbUl3clgyR2diS084dFhFN0t4OVZwSlFkcW5tU3Nu?=
 =?utf-8?B?OTRIUzFFelhieG50QUV6U0xTTVZ4RGhxZ1laZlY5aXcwWHhOb1pycnFabkp1?=
 =?utf-8?B?VUNRMHdiWEgxN3V2UE5XT1lJc2VPTTFYSGlpMXRUZHRVdkg3enVaSXYzUXdw?=
 =?utf-8?B?WjlCdXBzdlcwRmdjNDNiMHU0Z2N1L2lLTTMvYkhuN0Q4aHgvdlAveUIrMWhF?=
 =?utf-8?B?azZhMGExNy9kdGF1dW5xaERGQURDdkRWQXdwOFhBNEVDOFhSSENKVjMvcjMw?=
 =?utf-8?B?YlZ5aE42OUdXNG96bzFKVW5EL2NjZHdhdDhnWE9vL0oyL1hVa3krbjU5QTRM?=
 =?utf-8?B?RXhXNTQ3MUdrMk5vZlRqV0c1bzA3aGlwbm9JYWpWczBUM0doZmJYS1kxSHFh?=
 =?utf-8?B?RVE2QWVpNHlsUFN0VHJwWjhSaFYvNFFJVUZKQWZ1MkkrbHNxdkh1dzEyVHBL?=
 =?utf-8?Q?vY9PUxe1nL8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OSswcC9UU2hzTmwzVW5lTkEwNS9HWFRROXllSUE1SnkwRHk1R3l4TVloejRX?=
 =?utf-8?B?TXdocU41dHNCWlR5RE8zQUpob1NOampzQmxibWJLOXFCdTNQUzM5QlAzL1h6?=
 =?utf-8?B?dGUvWm1mZjVsaHZPcUR2cWhTR0RTTWlVUEdJemFCQlNkelRQUmxoMm9Jd1ZR?=
 =?utf-8?B?cTNUaUkrdTUweVF5UVFkMUVjR21SOExWcWdTclNGaVNZODlvYXZwd1NscGl3?=
 =?utf-8?B?Smk3MWpISCsrT01QTmFGbEdzczZFRHQxaStWSzkwQ0twMjdSbWJlaStZL1Vi?=
 =?utf-8?B?cmZxbzVaWCtwSDNLL0pkeFNUUGt5OXV4QlNtcUIrK2JLTC9kOHliN3NOeXhO?=
 =?utf-8?B?Z2RDUjMzY1VZRG1zZEhaYmkrSFl6ODNBREtWQ1M1dDlqaTBtL2dlQXJIR0pT?=
 =?utf-8?B?VTBLRmZzZ0hKc2RSY3RUbXpFcnNmYWEwUXd4cWtPektWMFZaUUlGVStMRTU4?=
 =?utf-8?B?SEpZRUIvV0FxczB4cjlNUE5CZ0J6bG01dzVjNUpNbktYWjdldEI2cDVCWjVH?=
 =?utf-8?B?NTF4ZFlUQXZGaXpnKy9BWHNDQnBnRkRsQSs2N0pJSWMweUhibmRVbWlkYS9w?=
 =?utf-8?B?c0tHbUJrZjlMV3E2Ty9ieFA2aWJpdU5EN3E0Wlk4Um9jZXBmNkR1eXNpSjdL?=
 =?utf-8?B?eUFVRzAwamxvZ0M4eGZEbFBtcHNSREUwRW1PZUg2R0ZTdkNVc0R3eitHL1Vs?=
 =?utf-8?B?b0RKVUZkRlNTRmVtdWlKdEFXNTE0Q1BOQ2F0OWl5TUdaS1doNTNIRG9laE1P?=
 =?utf-8?B?RjFJZ2E0Tm5xcTIvbGd4WTFqaHlpSS8yT0ZQeTdQWjVWTVZVNmlxMmhSSzZB?=
 =?utf-8?B?a01nR0RzanRja3N0Z2crZzVoRUxoc2FrSXZzendNblRFQzZ3eGpwdGJjZlFX?=
 =?utf-8?B?bnFvQ2k3QUZSWm4xVkE1L0ZmSFdVUGFJNW5ZNStYK3E3WnEzNTAvWTBJNzZT?=
 =?utf-8?B?ZFUrT2JkQ2JOZHljeDhXR2h3cldlQW9sUkRLYW5pVkIyUS9DTDVVOXlLSFd3?=
 =?utf-8?B?MzlOU2ZpaHVkK0xkaUV2SlVDQmdvMnpxaVdka0g0TkorMC9PenZmelhlYS8x?=
 =?utf-8?B?NnVxVmxqL3V3VDZJNXRlMFBhT2tTYmlCMmhzc1ZiWVRnZHBtcUMrTEZOaWNr?=
 =?utf-8?B?MkFBMVNtTllYZGQxcmhNa08rZmtZNkg5aDNJUWFWRkhMUGxZb1lNV29BTXNB?=
 =?utf-8?B?L3NzVWs1cTdxQ1o3ZEwreEp3MHpVcm5UbWdRTjlYelpFY2lFRjYzVm5zd1A0?=
 =?utf-8?B?R0VaK1FZZW1LQit0cHowZU55Y3BVM1cvUUE0bkZFTEszRWNEeVR3WFlZeGV1?=
 =?utf-8?B?cEhBNWR1eWdhWGNOL25pMXR6RldiNUQzRmcvZWdyN2pwOHI0aUxEVng2aTM3?=
 =?utf-8?B?NnNMZWRob05EZ3VJQ0JoRzIyeVB5N0JYRVhDU1RvNW9qUk4rSHloWDc5YjhB?=
 =?utf-8?B?c0NIYUF3MzVQMWZUUDlCQVFpSUJ2M0o0NGtsaXR5VjV2by9pRkRNTEg3WmdM?=
 =?utf-8?B?N3dqTzY1VkU1Mk1Pa0JaZ2NmbGx3UGd5TC9PSjl0L2lMd0NPZ3hxTmYyTkpS?=
 =?utf-8?B?bWQvdGRnK2dWdHA4YUpIY24wQkZIUVB3MUl5NDhDc0dEK2FmWndxbTlYQ0d2?=
 =?utf-8?B?dWIrRmdSTThJdWtBYzZxOThJTHl1cUNwLzZHMFp1UzdxSVNCZ1Y0L0FmWHVz?=
 =?utf-8?B?SFlSTkJFYzFSNUd3Y3JPUjRjcFN1cW9FUFhtL1VrZXNvQXFzSTNseE10Rklr?=
 =?utf-8?B?RUNCVTVQK2FpbjNJSHpiTE12dHkwSlNiWFJLOHpPU1FqK0FjaWIrQ2tLU3ho?=
 =?utf-8?B?TTZzU2pFUURDQ3hNeUlubUxndEFndG82V2FRRXRKSmlIY1M3cWpLQmp1N0Fo?=
 =?utf-8?B?ZFE5Y2haK00vMTIrTFJoUTNLeTdIU1UreVVlVEZGcDQyY2U2bjJhSEtDODEw?=
 =?utf-8?B?TG1uV2pTVUpQWEY1OXpmeElRRndueGxmazNRSUZ0RUhWQmNpbzJUUkVqU0ov?=
 =?utf-8?B?Y3lGcStyQ3NzZW5ZdUJtMDk4Sk1rUHBWWTN1NU1keGNiZjBMS2FRbElseEVQ?=
 =?utf-8?B?bXhMQWt6RWpDL1NZK1NHcDJjZ0lQcXlKaEppbDVnSldwaHN0NllRK3YrY01Y?=
 =?utf-8?Q?mmPfQXEMMBZ2cBuSMXLcMevFL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LTRRi+45TVEEL9sGCcoD51UQppI0G+DL/QjQ0V8ggZTKKCMy74ohyBNy1ptmiPbnSgzFVd7m8q+Q6Z+Cg5xpOqWg/ag9mHif5JcjMu6AbpVGuKxTgvxK8EjcMzBMhQU9DjX9KkIu+KI/xikvChaYjKC0D/rCQmyvSMcsxFR9deZKUhfN7uZ56NiRJ8rwOUO8Gar46VL0TD/F9z5M1DT0HYlkI8KO7NdA8CLqDokBGfzIgfCVp5kE1hKKMmYBEMJMy/7O+GXYlxfkQD+fH3AIIxecHkO7KUMLYasvv6++s5SED3xKvNCzn4wjw0klfX1R8W/Pn6/NeZXR09Jy74vwKNF6eu2NUV3+UYrUWPvuWJTxg/UewhbQQknzzxWGj1xxDhI/p7uvCdp/JryR1Zhk03OsnadeZB/PaIk5F2/IzxaMXeKFZzA9ltiXFS2qvMwuxnFp8SM/pOBxwzTKA2kK07+t/fhj7i1QoalJEvTvasgOdBXdT6OdxphGhcAgagxT5o8mydmc7zt8wIQJtTPRK63C0uvxriOrS3JancqDtOw5g4HlUOplYDztZBj3u0QuyiO4lyqRa2uNy+3JgKNlxDA5NL4Hvm3KMOwQrAnDJtA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97622de-f41c-4367-8d32-08ddb9bfd05f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 23:26:04.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9SksbXuHemQi69MPL6fPrAiKDXPSLkMmo/r1u3AOzaX3C24sPzY4+xBdRVz5OOomm8q57G2yvDprZotDdktLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1849371D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_05,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020195
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE5NCBTYWx0ZWRfX9mM6CmWccBiV 7m4E1v3V8OXe7TJDlmx5KME8E94lVLZ/tSxXvqpdmkNHRQ3c7gNAgaQYKNROpqdia0ovBMmsMep ONZVwX23jeMgJWUnfBB0Ot/yHNaDAoDXbMcWTS/akyXKMH9KaGAygyQByl/l8vvFZVJLXZbIY4Z
 Ncrs1+rRu2mtM8syOZ3zbzJOsOsTHHijDgHs47We5zQCKcu0WZGJxXnxzsTIToTAihMH61syihp 4IBZyk1z3llGb85xQUn4ATTo5Ir59zV29qXH6LJdMGHwkOdRfSa4JyhCw8VpTaJ09lboulsuHt6 zkI19nH0vMFGVRaxqv4WhfU7YF3Yaz9/lwpgq1G4C06DaAI3f1O8uiuQpUsY10CTvoT9IMrLyk+
 +D18nWwvv9FJ03Rm+FexMyCN9W6AqsB/hAC2njAN2kpkfQbYWPJzgL4tsUUhcw9BF3Nmt/6u
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6865c011 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=osG7FQIJQQoi8Vmgd5EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RmysnSSvTriSCbLp6aUBl_wT4V9iMpQR
X-Proofpoint-ORIG-GUID: RmysnSSvTriSCbLp6aUBl_wT4V9iMpQR

On 7/2/25 5:22 PM, NeilBrown wrote:
> On Wed, 02 Jul 2025, Chuck Lever wrote:
>> Hi Neil, handful of nits below.
>>
>>>
>>> [[ 
>>>  v2 - disable laundromat_work while _init is running as well as while
>>>  _exit is running.  Don't depend on ->nfsd_serv, test
>>>  ->client_tracking_ops instead.
>>> ]]
>>
>> Do you want the patch change history to appear in the commit log?
>> Asking because that is not usual practice.
> 
> Not really.  I'll send something new, likely tomorrow morning.
> What do you think is the best way to handle backporting?

The best practice is to have upstream patches that can apply cleanly to
LTS kernels.

- One patch that can be backported for the fix, one or more for
  clean-ups that apply only to master;

- Identify pre-requisites that need to be backported first to make
  your fix apply cleanly; or

- Handcraft the fix for each LTS kernel


> Should I
> submit the version that doesn't use disable_delayed_work(), then add a
> patch which changes to use that instead of a flag ?

Post an RFC here, let's see what you're thinking.


-- 
Chuck Lever

