Return-Path: <linux-nfs+bounces-16280-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07648C5007A
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 23:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73C984E187D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 22:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7795F2D23B8;
	Tue, 11 Nov 2025 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bDsdDQlq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GM1J/oSo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E9E24113D;
	Tue, 11 Nov 2025 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901911; cv=fail; b=J/X0+4k5H9rebmLLSeCmKBtqYwYXCV2djuFOCQBJVQat0BUQ6MxB6BDqB+C7+RwgDXHqA5gcM3BvqomJ2F3gD9rWWcBSPPzsoC2R001TD4NoNmDhXbaXfcQljo0kZA4nU3/6eiXZtZL3pJRSQSLMyhzXeU/W1oyoUZwj3QHdhC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901911; c=relaxed/simple;
	bh=6+1/H6QueOu6/wHKBx6aOlpRCn40bv3iAI70ipemJGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s2Nj7wFat0HjCTQTB1tlQrYrnvEH3H/MVQ0b8/zi3agT7pHyUXfGWGv/3ylEmeS10eMLs9/G9H1kxK/CRLvMLTxieBjhZPg9yySxNA0BKXMflIHuxTEkDwGxUJE0hglWl46MJp24I+cvzgApqnfdfG36l7rqsZVq4h9GmOvHc9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bDsdDQlq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GM1J/oSo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABMaMqp029555;
	Tue, 11 Nov 2025 22:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WJUt0gnUWTcshIsxUQS3FJaPlTXvFkYR4L69uW/fusw=; b=
	bDsdDQlqbynxCQeI1Vs/yYVU7r4wet9Fp82Qrm0O18n1cWV/Eu0eVm/KiAtYsO2S
	NduqtFx09bCdsVuurWzV0mCetdmRyeuC7oxJdSzFXTAGGuI3aj9qTP/c4HF9fNNW
	MxpJ2EVo+CrmykAkbH3lAaUy9us7ZMruXqpfYpVT09PlAkJwTLKmyQfAXj+4QOuN
	NSYvbkuTN85coGJhluBEp+JC7PcvjzmGnEQSEy9W4WCoZCfKA5Rpqb24Iy9mgmgr
	qMf87X2J97aWIPF1BHxgtxa7/qjBSIbiKA4kexibfe2WlmWIkrj+aHpL9625J6iM
	ohlimrRcj05vQx51hK4IOA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acdwwr1rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 22:58:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABKbT8M012682;
	Tue, 11 Nov 2025 22:58:24 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vadgw3a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 22:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRLbac/AYW6JkjCOqUXFcn6Ln+eu18KJY36Ivshpj1UgDVYoKrPCb7+Il8jkOTvLMOsvoxNLAA6RB0q77Bl9zm5cj17B7hV4OE8q1SMp8VzhIBkNvfkYKLp66LO/v44huu3K4Y7ZV6fqxTfw6CO8aC+uCBoJu7NrzX/B6Qpht3AfaW6QvOeabRQEgplo4SunV71ISdBTpnXsqR9i1Ud5dHyZapq1A/qtDmHdlsrO4SsRtq0tpoXJNUSk6KmtpMRs09da3xX0NmeQwU3WnvA2GeapoVPCiMLCUuootceQA0fGVpq+ENsF3p9BKva+/ACxspwPXJKwQf2O10JPdwnNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJUt0gnUWTcshIsxUQS3FJaPlTXvFkYR4L69uW/fusw=;
 b=rAnJhto6Nf5qxdH6TlAom8OrTVaDKp0UsosonBaf52pApZmNQS/a3BV9LCP9UopNlcrgi7/HRRWUA17AMzE1mRA+ge2ZD3ka5IymCKZdpJE16EC+Pyyhi6+cWnFNp7dm7OgVTUryFKpCDe2uAAi9b2qJ/6ksxgnptiN5Umy4bklWuiYVQtLP5D/Pmye74v+DrnXPgzSQhHF2Gv05cHrflX1GELTMZQbB0212wHYftHzQhZ9+mkiSgrs5Bl/I6fLsjUbiRPQWkdfEa9YsEJO+EudkeZ1C5En3vBpR9XujTKAXruCcynEqUW6XiAh2vrCYIwb84NU6ggMhfPWr5F0XHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJUt0gnUWTcshIsxUQS3FJaPlTXvFkYR4L69uW/fusw=;
 b=GM1J/oSoGXOJB7GZwbBDStKj1YyOP13RN43q4gsnFAMaZOLu5EklSYC3P8YVypoYp72W3egOZpMgbn/yGm+8SM/8z6iYz/tlZ9xzjWqGKLys5Ii6IsYlD5TXxVD+jIAmyPHhmCZt4xkY+4w5UsnTnVFAz81ZyX4Y5F2vpYtK8KE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB7073.namprd10.prod.outlook.com (2603:10b6:806:34e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 22:57:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Tue, 11 Nov 2025
 22:57:54 +0000
Message-ID: <d770535b-5884-4f29-9023-3150be4f9980@oracle.com>
Date: Tue, 11 Nov 2025 17:57:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdrgen: Handle typedef void types
To: Khushal Chitturi <kc9282016@gmail.com>, jlayton@kernel.org
Cc: neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251111205738.4574-1-kc9282016@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251111205738.4574-1-kc9282016@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 4958578c-4897-4a6e-0b88-08de2175bf65
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?STJ5dWFreGlDd0Z0aGdOREVWUlNKbEl4d1p3azRma0FDbXVkVVJiWE9FQzZE?=
 =?utf-8?B?Y2lSUDRxVXV5TWtKVXBlQXRSWjJ4a3N2MHZCby96U3FaaTdoWnBDcnJNeEcw?=
 =?utf-8?B?dUtFY3E3d0xTcncvcnZIcSsrdmg5NDlZK2lBeVhEdllDYmltdk54Y1pWZ0E3?=
 =?utf-8?B?VklMbTJqSDh2UUpWaWFPYmY4ZXZMRloyQS93cUFUL002WGxCMHZtSzFFSnZJ?=
 =?utf-8?B?UWxHVEZSNjErWGlpTDZ2SStHOGxha0dqUjg2aS81WUc1VjAvVEV2dEh1SG1i?=
 =?utf-8?B?dndkQklMOERrd1YrWjdFYUpyZEN3QzU1OHQza2doRlpSbjJaeGlwZTNTVlMr?=
 =?utf-8?B?MHdiZ2xzZ2dBd0tiQ1psZUt1YTV2S0NxZEswU1VvNm9wUjVJNndVcHhOc2hV?=
 =?utf-8?B?cURCNGVqZmJKLzVzVkk3Sjl1djdPdWpieGJwSWtDV0RrZkhGRVpsS2V1QUJy?=
 =?utf-8?B?K1k5Z01XbTdQZ00yZXNoRVAwdWZMU1NrVTVqcjQ3a3c5M2lEL2J3NlJjc3RE?=
 =?utf-8?B?WXlSa3czMkQ0QUhSVDU5TThLUFZFb2tUdUd2aWVmU0VIYlBWYy9UQ2Y2RlBv?=
 =?utf-8?B?WjdCM2E5WUlocHZnZnRhWTl2TSt2WHZyMHBhZHlUWlpPRUg5VWtxTzJjaGVZ?=
 =?utf-8?B?ZnQ5UURWenl5eGpCREhxVlVHZitqeWRITFNFREh5bklaTE96NSs5b09xSGtE?=
 =?utf-8?B?aVg2RVhuQ1Y3ejloZVQ4YUFnb1lNMmVKNnR5N1FINnpWTVBuNy9zWlVyL04z?=
 =?utf-8?B?K1o3OXlFdUVhL1U5anFxOTdWelcvMGlEQUdmcHhMeHRzRmQ3SWs4d1J5c1Zr?=
 =?utf-8?B?VE00WXdzc1ZNNGhqN1JFVjlaM0pKTC94aWxuOGFsbmVhL0ZyenJjakh6OXRQ?=
 =?utf-8?B?MThxRTZNTG5lNmtoNDVCUjAyT3RlQlJ6bmo1Nk1JQ0cveU5rL3dCQzEwb1cv?=
 =?utf-8?B?Q2VsZzVMUDN2MElUaG9LclMvZEZRQ1BTUWVEcFJTdHVPL1BLdTMrd3lqS29m?=
 =?utf-8?B?MFAzaVJ4WGd0OHJNZ2o1bWY5enNhYzdZOGpOUGY5c3o3QnZzWHc2MmdWeFBP?=
 =?utf-8?B?dEgxS1lueVBQYkV2dC94Mi9WY0ppUmN2aEsxNlZuT3JhMjhpQXJQbmN5b0Ns?=
 =?utf-8?B?OHRYNEdNNmtvMEV6cDJrQ01VdWgyb1RnZE44aGVXNTNuT0NuL0tqemU1bDRL?=
 =?utf-8?B?cGtWZzNNbUpFZ3JhMkZEUUxwc2hSOHVuRXRvdmY5a3FtM1F1L294UW5GRkJX?=
 =?utf-8?B?cStzM1NmcXZtYVVPTlBOdkR4WnJnZVBiQklya3FDL0JETERKSnBYd0MzbzY1?=
 =?utf-8?B?UW1FNjM0ZWRVOEkrdmNldytSZElMZ20vVHRDc3BmeDFOajNDUHduQk9zamQ0?=
 =?utf-8?B?RDhpWUR2RG0vcEJQZmEvMTBpWkVhM0poWCtWZG9XWUtWUlVsZEZzOHhvQTNN?=
 =?utf-8?B?bnkzcHlpZG5JSEVDdUZDRTBCUFNaM0RtcFM3UGxiSjFaZmhXODRhdFBZYmg3?=
 =?utf-8?B?OXYreDQxUGNyQzg2Rnh5RFhENmZndTI4bzVpTzlIN3c5ZWFuSi9uOW9MTFV4?=
 =?utf-8?B?VVFZSWVDOGxiRTdSWU9WVFpidHFwa1BxQ1lCTHR3cnZyTkdwN2FGeEF4a0pr?=
 =?utf-8?B?eHNacWJkMmhvRnNQbE9CQmI3eU5lMElPRy8xN09BUWRBOTBIeXlsSm04WVlm?=
 =?utf-8?B?Vy92QXRYYzE4MVdrMGZFM01zVGZKQ081WGczUTkxRDJzQ0x0S1hrM1J3RFg4?=
 =?utf-8?B?a1BkOVh6cmViVnVjYk8xMnpNYjZDT1NHbFJvTTBHZFZSSzBqMDNMSytsUitZ?=
 =?utf-8?B?ZThaWkxrdnUvZWV5T1NhUCs1WDhuNWx0UjdQYkw3dnZKVHpoWGtiNlpWVDZT?=
 =?utf-8?B?OThnYk1vcFZhVDZwcVBzT2Jtc3pGMDBwV3dOejVRdlFpL2tudXVyNHFoRmZs?=
 =?utf-8?Q?R4M5M1+fuBAGu23hvYEzDo0CaZtcYpJJ?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SmllR0luRFFZOHRCU2Z0T2VWL2tLc3pSTjlQaXowTFZSWktCNlVBd1AwbUdE?=
 =?utf-8?B?VkdQQzBpbkNSV0VQbUhNa3BtL2RUUk1wdlBxT3RiUzlnaTFucWUvcGd5enB4?=
 =?utf-8?B?b1pMSFRaeEw4aUdnbkRZTkZIYTBIS0p4aG5lZEQrSklBMFRBWHoxZUl2RVdC?=
 =?utf-8?B?S1FVaTYxVXQvK3RsMk5XeHcvSTVIaExMN3lnWS9hSURzMnpnMmpXMTJjZEZ0?=
 =?utf-8?B?UzBzbXIxWGs1Q0VFWjN3SjhpcldycW5vUUQzeHJzeS80RUV1U05Hb3BwRHM1?=
 =?utf-8?B?ZS9laWNyQllrb1ltVGF6cHFRZ09yUzRsZnIwVXFvWjIwZGJzWk5TZUpsZHRh?=
 =?utf-8?B?T3RDZUlveUllV3Y3TzlvdWl1ZGtSKy95TFBFRmx5QUdBblhxZEJMWmRLMDNW?=
 =?utf-8?B?cVJ4aU83dW5icFpIbVhENjArRGppeHRBVDBCWjVwVmVmSTNTaWNmRHBLNzlW?=
 =?utf-8?B?VU1YenJQcTZValByTGF0aGUyM2hNeHE4Z3dNdGRWRjFVdGg2cUhsVVBGT0h5?=
 =?utf-8?B?MGZiMFBNVkFKVGxISk81eXE3cFBKUEtkbnU0MnFSTkRPajJaRlNoME1DcmdK?=
 =?utf-8?B?VTI2M1BoQTVHZkRseWplRDExdU92RlVaVGdFSDlrbkRIcVFGbFVrUlJkdGhX?=
 =?utf-8?B?dEFOTXZiTWVhV052Mmg4U2lNdVh6bGNBdXJWWnA5MTVIMyt2citXSVh3V0Nm?=
 =?utf-8?B?cnJFN2lZWGhaQ0VSYkMyWVZnaXN5dVN6MnZmRjZxUGwzUVZUL2dXQUpNd0xK?=
 =?utf-8?B?UzJxVHVyRDRIWktlaHhCdDNwaDVBdEhVWnBWdmxYdDMyRGpIRTJPWHpocHFq?=
 =?utf-8?B?bjEzcEhOYkNJTEFmSHJwcUo0VUJmNk8rSCtLdElaMzRobkxVcmZpMitLZmFt?=
 =?utf-8?B?QVIvMXdJM2Y1Y0lVTEdiUE5GSW5HaytlUDZ2RnRpMm90U0tYYkUyMVpGb2lj?=
 =?utf-8?B?Mndqd2oxODFlVlhFd01lZWhFd2xtRVRYbVhlSmRueTd3b1p6VS9yd2VCUFNy?=
 =?utf-8?B?NUx4eko3M2JLUElmVTFiSkpiWmxzcWh4UkJJOVlhOG5LelJEQzJESTN6cXRo?=
 =?utf-8?B?cXFzWDNtaHUvU0pKeHgyMUVscHQ3SGsrS2pnUTE2czNjQVZ6eGtJOXg5bktt?=
 =?utf-8?B?YitMT3l0clpCQTdZMERnTjYrZXZTWFBuR0dGYlQ0bzZGbHBMQ09ibDlHbmJW?=
 =?utf-8?B?c1l3bjEya2ZpcHRhNk8yVXR1UGQ5ZmxLRU5qTWJkem9CYjVMTEhaTm9adGMz?=
 =?utf-8?B?b2FTQVlNamgzcDF6UjZ3dytrZk5ZeDUraWZhRXd2UnYwck45Y2R6SDd2MnhK?=
 =?utf-8?B?amxaelhNa1Y3MWNQTzAxMldVVjNHRWN3VFVZM2ZMOVlUUVFqM0lITFpFSVpn?=
 =?utf-8?B?bTA1QmYybnA0MnoyV2xRS1hmRGRhc3llSkFFRmp1clJ2cGtqWXJrdDl1b2FS?=
 =?utf-8?B?aENPZndCWDJJU0t1Wk5JMGM3d3BmRmtUeXRqVmc4ZUsxTk1GWUFHUTVnSWc4?=
 =?utf-8?B?d0xNOGN2dGttUDM4TkQ5d2RVODFtR09tYXc0WWFJZlZ6QjlIRVZUc0ZQRDhn?=
 =?utf-8?B?T01vUkplcHd5MG9rQXJNVWRPdXo5cWhXR2VkZGU4dDh0REdaUEorNVh0Tmw5?=
 =?utf-8?B?OExNUE1Sb3VOOFFSaG9lcWlNd0t1RzFlaUhkb01Qdm9TRmdqY21SMGV6V1hp?=
 =?utf-8?B?ODZZUVFPV0R6MEdEejczZkhQUkt5ZSttUHRpQjZBNVdNV0R5eDR4NlB1T3hv?=
 =?utf-8?B?OVRJUzhxOG5tdXdDdisxdGZzTnBXWUllNy9BZlRiMVY2R2Q2UklWQ0hnQzBV?=
 =?utf-8?B?QW1INHpiT3ZvVHQ1RkxhaTV4WTdmUU1kYmwwQ2FhekxQTWpPV0RHd01hbk1K?=
 =?utf-8?B?TTdub0paemNhK2lrN2tQTG9aSklZK0hiRXQ1d0UrYzE3QmhFa3lMZW42aXIy?=
 =?utf-8?B?Z3BhNmJmYzB0RjVaTCt5WDNERWd6NlIvWHYxaXVKdlZJckZaVVl0SmtibHJM?=
 =?utf-8?B?TnFuZUkxRldkbkY4d1FJdmlFVUFpM2FaRDAxTWFEMG5RU3l4NGJnWlFTN21x?=
 =?utf-8?B?ZFFoWG5kdlJDcWp6RTVZRk9oVEphZVhrUks4SVNZMmM1NEpRZUZ0NHZjL0lQ?=
 =?utf-8?Q?Xuldx1TXWKUJ7I/XzX+jqJx+U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	94gGSHsob2KoQaTNTuIIuxXkNk7i7gj8z5pNjXv9YYEbcIidk4SCzoATIKfiXds6HYy0W4B0gl5x5E/xGECe7efYMTSuu0ANScIlsTdAF9ZYOdctfMqfmw+7ZlDRmifnuF6t/rrxFGL5xXzwsC9lYNcoA2fK1ePsEwUDHAMX7pRUo6puZAt++Q2RVVHzeFQ41RsI9JcCsR4pS0imeGmoqK6Esaqt3a2abHu4g3nUgavuQ2eo8c3g4Y0nnjICdRFwyTGXIpbUoAZR9WF2L7p7oIeqEF7nT6FIzu4z2qpDzcKY4PzJjh8edWygFLO8Ed4GuIHUJ21HSE5ilpYPwZCE+/lfZIOU4NEqj6nx25M7pFksFQrsEgXM408zy/zv/Ez0B50JMejQSRBT1GSJhp7x+Rz+k2ZFuHksM9y0yhm8hktjdDLPHJLzRylm1QHYZmcnQIbSdfzmGmAZaZfWXoBq8H+YEVApoUSvh8+qkNYJdRUsGCZ2+DN1NEjx6+PNKkbB0KkoR6kjXKSih6xaROAqHZJYWmTymeNkpgobOtsWcGxeEHMowSVBiu/+mdFNPbXosi2KUVnkvVF/dyjbPJ6KMix6cqfJ6ScRmPCkKNkSgAI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4958578c-4897-4a6e-0b88-08de2175bf65
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 22:57:54.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQfAvTFDg/hqwpbJQbGwEXqf4kE+7zHd8jlnFW4bjCh/6Y7kDBJiSKrroc3fUvvqnzCG4pBj8UwrscISBkJXpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110188
X-Authority-Analysis: v=2.4 cv=Jq38bc4C c=1 sm=1 tr=0 ts=6913bf90 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=aL6jq2tTQg7Tl71RQSIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: nyKeoi0GlzziYI67-7-qp0Nei7tKNC4E
X-Proofpoint-GUID: nyKeoi0GlzziYI67-7-qp0Nei7tKNC4E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE4MyBTYWx0ZWRfX89B7quAILp3I
 69t930CvfWmuTZY8eXM0SrNRb4Ljsp5NrI/lW8+LBSBUwAzQe3RJVzm/Eh+JpNTkgUkZDZG5BSP
 IbDI6dxn4W5rZTZZ4GD7pBk3e8F+C/GXk+PyZELXCCuumkIDLs0JJ5OuNJMLfT4omhNX/+v4rIu
 QFeojDUL9bFT7z22Q8agIo7NgA442YMiSJYyclT8GYTTBR0cSLDf61rBHaCXUXybCIv6XI1pcoW
 t0cpIgVPJdtLKwX8PpiAZXXSEaWpCMHX0v8p2WcOIW25svKTYJJhtgMg2hFz5qF22mqHp7nocko
 KG5X36mW9e3LxFK0nV0JnlSgZJJuQEE6IcOuovGjhA2wxAoxhL4Oh/D5+VGDTo8jo0NWn+2irPl
 KfgZa2wazkB+R5Op5kG4PCkk0MoL0neoUJUycvnJitCgYcJ5AiQ=

Hi Khushal -

On 11/11/25 3:57 PM, Khushal Chitturi wrote:
> This patch Handle typedef void in XDR Generator. Previously, such
> declarations triggered a NotImplementedError in typedef.py.

Your patch adds a feature, but the patch description doesn't explain
why this change is needed. See below for an explanation of why
"void [identifier];" is not implemented.


> This change adds handling for _XdrVoid AST nodes within the
> typedef generator. When an XDR includes a typedef void,
> the generator now recognizes _XdrVoid nodes and emits the
> respective C typedefs and associated functions. New Jinja2
> templates were introduced for encoder, decoder, declaration,
> definition, and maxsize generation. The XDR grammar was
> updated so that void typedefs can be parsed properly
> 
> Tested by running xdrgen on tests/test.x containing a typedef void
> declaration. The tool now runs and produces the encoder, decoder,
> and typedef outputs across source, definitions, and declarations.
> 
> Signed-off-by: Khushal Chitturi <kc9282016@gmail.com>
> ---
>  tools/net/sunrpc/xdrgen/generators/typedef.py        | 12 ++++++++----
>  tools/net/sunrpc/xdrgen/grammars/xdr.lark            |  2 +-
>  .../xdrgen/templates/C/typedef/declaration/void.j2   |  2 ++
>  .../xdrgen/templates/C/typedef/decoder/void.j2       |  6 ++++++
>  .../xdrgen/templates/C/typedef/definition/void.j2    |  2 ++
>  .../xdrgen/templates/C/typedef/encoder/void.j2       |  6 ++++++
>  .../xdrgen/templates/C/typedef/maxsize/void.j2       |  2 ++
>  7 files changed, 27 insertions(+), 5 deletions(-)
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/void.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/void.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/void.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/void.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/void.j2
> 
> diff --git a/tools/net/sunrpc/xdrgen/generators/typedef.py b/tools/net/sunrpc/xdrgen/generators/typedef.py
> index fab72e9d6915..f49ae26c4830 100644
> --- a/tools/net/sunrpc/xdrgen/generators/typedef.py
> +++ b/tools/net/sunrpc/xdrgen/generators/typedef.py
> @@ -58,7 +58,8 @@ def emit_typedef_declaration(environment: Environment, node: _XdrDeclaration) ->
>      elif isinstance(node, _XdrOptionalData):
>          raise NotImplementedError("<optional_data> typedef not yet implemented")
>      elif isinstance(node, _XdrVoid):
> -        raise NotImplementedError("<void> typedef not yet implemented")
> +        template = get_jinja2_template(environment, "declaration", node.template)
> +        print(template.render(name=node.name))
>      else:
>          raise NotImplementedError("typedef: type not recognized")
>  
> @@ -104,7 +105,8 @@ def emit_type_definition(environment: Environment, node: _XdrDeclaration) -> Non
>      elif isinstance(node, _XdrOptionalData):
>          raise NotImplementedError("<optional_data> typedef not yet implemented")
>      elif isinstance(node, _XdrVoid):
> -        raise NotImplementedError("<void> typedef not yet implemented")
> +        template = get_jinja2_template(environment, "definition", node.template)
> +        print(template.render(name=node.name))
>      else:
>          raise NotImplementedError("typedef: type not recognized")
>  
> @@ -165,7 +167,8 @@ def emit_typedef_decoder(environment: Environment, node: _XdrDeclaration) -> Non
>      elif isinstance(node, _XdrOptionalData):
>          raise NotImplementedError("<optional_data> typedef not yet implemented")
>      elif isinstance(node, _XdrVoid):
> -        raise NotImplementedError("<void> typedef not yet implemented")
> +        template = get_jinja2_template(environment, "decoder", node.template)
> +        print(template.render(name=node.name))
>      else:
>          raise NotImplementedError("typedef: type not recognized")
>  
> @@ -225,7 +228,8 @@ def emit_typedef_encoder(environment: Environment, node: _XdrDeclaration) -> Non
>      elif isinstance(node, _XdrOptionalData):
>          raise NotImplementedError("<optional_data> typedef not yet implemented")
>      elif isinstance(node, _XdrVoid):
> -        raise NotImplementedError("<void> typedef not yet implemented")
> +        template = get_jinja2_template(environment, "encoder", node.template)
> +        print(template.render(name=node.name))
>      else:
>          raise NotImplementedError("typedef: type not recognized")
>  

Looking at the _XdrVoid class definition (line 285-289 of xdr_ast.py):

  @dataclass
  class _XdrVoid(_XdrDeclaration):
      """A void declaration"""
      name: str = "void"  # Default value, never overridden
      template: str = "void"

The name field is never properly initialized with the (new) parsed
identifier. To implement this correctly, the void() transformer should
extract the identifier from children when present:

  def void(self, children):
      if children:
          name = children[0].symbol
          return _XdrVoid(name=name)
      return _XdrVoid()


> diff --git a/tools/net/sunrpc/xdrgen/grammars/xdr.lark b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
> index 7c2c1b8c86d1..d8c5f7130d83 100644
> --- a/tools/net/sunrpc/xdrgen/grammars/xdr.lark
> +++ b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
> @@ -8,7 +8,7 @@ declaration             : "opaque" identifier "[" value "]"            -> fixed_
>                          | type_specifier identifier "<" [ value ] ">"  -> variable_length_array
>                          | type_specifier "*" identifier                -> optional_data
>                          | type_specifier identifier                    -> basic
> -                        | "void"                                       -> void
> +                        | "void" [identifier] -> void

RFC 4506 defines void as a 0-byte quantity with declaration syntax
"void;" (no identifier), and void may only appear as union arms or in
program argument/result definitions.

The change void [identifier] violates this. RFC 4506 has errata (ID
6382) noting the grammar was too permissive, allowing void in incorrect
places—this change reintroduces that problem, allowing invalid
constructs like void foo; in struct bodies and typedefs.

Unless there's a strong reason to support "void [identifier];" I'm
going to have to reject the proposed feature. However, you might replace
the NotImplemented exception with something that better reflects that
the error is in the RPC language specification being parsed, not in the
xdrgen implementation.


>  value                   : decimal_constant
>                          | hexadecimal_constant
> diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/void.j2
> new file mode 100644
> index 000000000000..22c5226ee526
> --- /dev/null
> +++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/void.j2
> @@ -0,0 +1,2 @@
> +{# SPDX-License-Identifier: GPL-2.0 #}
> +typedef void {{ name }};
> diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/void.j2
> new file mode 100644
> index 000000000000..ed9e2455b36f
> --- /dev/null
> +++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/void.j2
> @@ -0,0 +1,6 @@
> +{# SPDX-License-Identifier: GPL-2.0 #}
> +static inline bool
> +xdrgen_decode_{{ name }}(struct xdr_stream *xdr, void *ptr)
> +{
> +    return true;

These templates are used to generate C code in the kernel style.
Indentation for generated code should use tabs, not spaces.


> +}
> diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/void.j2
> new file mode 100644
> index 000000000000..22c5226ee526
> --- /dev/null
> +++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/void.j2
> @@ -0,0 +1,2 @@
> +{# SPDX-License-Identifier: GPL-2.0 #}
> +typedef void {{ name }};
> diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/void.j2
> new file mode 100644
> index 000000000000..47d48af81546
> --- /dev/null
> +++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/void.j2
> @@ -0,0 +1,6 @@
> +{# SPDX-License-Identifier: GPL-2.0 #}
> +static inline bool
> +xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const void *ptr)
> +{
> +    return true;

Ditto.


> +}
> diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/void.j2
> new file mode 100644
> index 000000000000..129374200ad0
> --- /dev/null
> +++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/void.j2
> @@ -0,0 +1,2 @@
> +{# SPDX-License-Identifier: GPL-2.0 #}
> +#define {{ macro }} 0

The convention for these size macros is to wrap their expanded value
with parentheses to prevent them from being unintentionally combined
with other tokens after expansion.


-- 
Chuck Lever

