Return-Path: <linux-nfs+bounces-15957-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2279FC2DF4D
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 20:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA791891E6D
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 19:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7373B23372C;
	Mon,  3 Nov 2025 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sAw97XBp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k3A07Wd/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A19284690
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199964; cv=fail; b=qlpvUOjcTuqrQtwub8zumYCp8WeZAlRgjtkkQMdeUgPFEJBoT2f9m7Y+tSxGtgcqj9DPXExK3cr7f7GwyeFW0BfFcwysMRk7nZqa0womJbXPLeRa8tnmUJXMo2hcXjOKTq2re1R4DIw7iZ3cLBFvmZA/Td5oZy0HmYxX2O5u+cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199964; c=relaxed/simple;
	bh=OE/ww1UepWeaxfGpJNaTIoIVUcGOdcSqRDu0WfmWa/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ubBEUse/HMbI1up2OaCBer/Bmaq5sA+HK0k4bcwdtF5/B4pdMEar4LMVrWiQ+wNBGKup4fIb2WGZIf2twG913LbwkQS3U83QHw64RBY8rBlfI9vXlWMO/bybv8H0SlvhFjiTX29cuj2nHZZOTuE21a+qNQCqKyYdj02Fe/qzTCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sAw97XBp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k3A07Wd/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3JjA4g002729;
	Mon, 3 Nov 2025 19:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Y5e3V4BfQfK/72IMPGHbIWzpX70OsXLFajwl4JnVY0o=; b=
	sAw97XBpq4xOTslZAnh7MclrgzCeHstoggwSSu5iJ9UW7QqmaxlvFmNaF5tWmoB0
	UkYUBTrOci5Lsw0enXOMzXAilvB95p6JkHvkuGxbKmEpM4T26GJrChGYMPux51+P
	ph+sM/XpRPL0EM9LUCB/uv2pgaYFRHpWD9pzGxROARxYMopiRcvD/Qw1bvejPwcJ
	rB6c2ZgqG5TkXwyFSaqnC+atWXGkmUvWm69j/eDphCRBLb6kBM3UQkH5fE2xJY7C
	jhFB41xvbx9kOqgaa1Nut7HNQ0rTgU5Eta8Bd35emiSrFFFUXDtnwl/OQY6ujUWj
	Ywf+KI6X5UYgYGLMDZHw9A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a72tj013n-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 19:59:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3Jfshe020947;
	Mon, 3 Nov 2025 19:50:11 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n8mdwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 19:50:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5dIf/EMG6VNqCo4VSjiHaXYIsA0SoLyikU56WUxzPzs+07dC6Ng5XHjeHMMhViHSaCXRhin6QHqifbHsVf5y032x8DxibDAy+k+UK7t/gsj1PjBIPD5ILNZ1+nN4F4D0vicFeiuDmdvWqqO/rvWlsTcp40/m2+7BRg/Nxuh29qnm9NuZIUR2nlrpZcu5Z3tryMIWf9QSWca4M1gQjWHLhouP5NCI8iR3w4K2RqC4XxvVJbJUsGg6nZxipGjS5X9BIO2oe59DQkZHzf6Z1gEUalhGhrFc0Muc+kcBkd5Pt+HI8yTG5aYpPglsS3AH9K1Kox5t/unQKpWSF/Txlf0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5e3V4BfQfK/72IMPGHbIWzpX70OsXLFajwl4JnVY0o=;
 b=D5O2znZ9KPEsvACbhrrTTpPbN5zdZl7CWKSJ5nXwJA+k4Kq0A7fllrh7zkpVhXBdd9Z8RUP5vO7a4B3o2bf96Ao0kFtxJZp/DklGPIjytIh4eJb67h6hZ4pLLGVyRKwmseh8h6J1KIyMB6hQKVpyQC9ZNnEz8COCsTqgan9A2TmAGq7IbnJPeXlbcXV8P454AAqv0bREpzO6P/PyfV4Kbb+58eRaxoIOd5bvPHivbLsRVOJcZbqzs7eYTDE40mFKb936m3+5acMXgjvWoT4KHXF0i1Yxbi3ad2aDORg7SIUJGFr17vfXrgfrLSv6pq20cDgb9BCw/4L5wlv/4sGWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5e3V4BfQfK/72IMPGHbIWzpX70OsXLFajwl4JnVY0o=;
 b=k3A07Wd/+cggCuGZg+Yxe55qW9s/reROdqUmq6QbZn6eOdg22LI6TNxZvXWBf9MI1GFLtGJPVbJrJS29myjUWJ9tFOzb94am+9L+P8HluQ4H3oSQ/0D6oMAsdMA3N4JgSB9V72FDxtVlsY1yQAhpciDa4g2JkYhBBs4L8BkTtHU=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by DM6PR10MB4267.namprd10.prod.outlook.com (2603:10b6:5:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 19:50:08 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 19:50:08 +0000
Message-ID: <0706b076-bacf-456b-8c7e-593277c16806@oracle.com>
Date: Mon, 3 Nov 2025 14:49:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] NFSv4.1: protect destroying and nullifying bc_serv
 structure
To: Olga Kornievskaia <okorniev@redhat.com>, trondmy@kernel.org,
        anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20251030214759.62746-1-okorniev@redhat.com>
 <20251030214759.62746-4-okorniev@redhat.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251030214759.62746-4-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:610:32::13) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|DM6PR10MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e41f9b-de36-457b-d950-08de1b123142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzRjdmdsZWo1ei9YUmdOUCt6Q2VjUlQzOURLOFova0VXdEFEenFiVEp6UVZG?=
 =?utf-8?B?TmxrNVVTYmNNcFduQjdsWDA5VnFlNFp5U1NBRjB1K1Z2R3g2TW93VWVNZEpu?=
 =?utf-8?B?S2FQbVZ1K0VNSm02NzMzZGFGMURzQWRFMkdYbE42OFZVQ0NLbC9qYWpQSUo0?=
 =?utf-8?B?c2xpZUsyL25xMVJBOENtYlMxZHRmZWxWcERqY010bzhzVDl5NjNDZk1qRE1x?=
 =?utf-8?B?bnpCWC9hdXV6TFczNU1nTk9lQjRDVXErUGVGdk92cVcwK1N4cjhJZXlrV2M2?=
 =?utf-8?B?Tmk3RU5ZNmE4K0xkL2hiWkJvTC9ZckpQK2VpaUhxM1BXa1JVcXBmUG0yckVL?=
 =?utf-8?B?cjdhY21yT3hJOWtObWVFeUdRVUoxbE9VN2pYK1pIcUU5MmYrbVdsV1NiQXNX?=
 =?utf-8?B?Sk9BM0VsTng4dnQyR2pZcDdWdkRPUW1ZUWxaTU05blppSUY2eVVGM21YMCs1?=
 =?utf-8?B?bFFZSkdqdXRzWFlrV24zZ05xRUlxRVFqSFUzNWo1WU8rK08rd1luNTdWNG90?=
 =?utf-8?B?SWhsd251TGFMRnNzV1R0Z1c5SUY0WUtWaFR2bUdjTkxhSFc3S0h4SFk0WFYy?=
 =?utf-8?B?d3VnMWs1dyt0Yk42MHNsZVNYaVlBNHdueTRXREI4NHV3bGNBVFNFM2ptb3p0?=
 =?utf-8?B?UnNwTzN6T2N4VGtsdkRsSWFSWGI1VmVVVW9wREFNMTVmZ3B4ZWdqRjdHQWtj?=
 =?utf-8?B?dUdiZFRMQ3JvcHF5anp0OGlqdDFKZW1kMU5YUWZ4YStLWDg2eXo1SmhlT3NK?=
 =?utf-8?B?bmtKN3lDQ1NUSDhrU3JqL2kybDNSWlU4WEd1T3NTZ293Mm5DVTZyQURpZXVz?=
 =?utf-8?B?TDRrQ0tWSWZHQnVyZ2grY0cxTkFNb1dURlhjbVpVVWpKQlU0OXpRb1ZZUkQ2?=
 =?utf-8?B?blBKakFFeXYxczdoUHp3NGJIWklITzNaTzY3MytzMTlJdEpBSWhFSVVUeDNV?=
 =?utf-8?B?Sm5OSWZ6Z3Mwb0Vid21xSlBWVWg4WVJjUUtkL0VQWnlMNWxnTE5YSUVJTFpW?=
 =?utf-8?B?d2hmM2QrS0lvQXV2UFdvaW5JcWs2ZTN5d25WNDZmdHdNZ1M5d3EyYk5ZSytI?=
 =?utf-8?B?dWo2R3Mwb1NOMkZURXgweDBtZ0p1VzlXUjhFWnJOL0cydldFdkYvdVdqdTNt?=
 =?utf-8?B?SDEvbWdTenM3V2NhZXNRemtsYTFkaWlOY3A1em40U1VpbXhWa0xlVXBpZ0Nq?=
 =?utf-8?B?VjJIazZ3SjE3VzMxMkJRMkFmZWsyUkVvSW1HV2diK2wvSDlJZTY5N0pqT05Z?=
 =?utf-8?B?b3RDNG1TK3pWNkFZZ1hDM1hpM3d2aGVvQmdhVEVlUDY4WHNDL1FVclAvMWE1?=
 =?utf-8?B?TitsOW5yVW82Qm5scWE3UGJaQ1JIK3gxdXFyWHhMc3BUUXA2MzlqcW1SclRN?=
 =?utf-8?B?RTc5NFJnMnRRSGdmT3A3citaR0x0TDVMUUMyVkc4SkNpVytvbWNOQTc2bFI0?=
 =?utf-8?B?aURHbEVXamJxYk50Q01kYitwSzk1S2x4Rk52dWtuMERBcGJhSWgvSFA5WVhP?=
 =?utf-8?B?ZnVUcXRzY2Ftc3h3VjBvd21qZ3B1dmE2dUNQU0hocHFUbnN0RVVOVVJGaTFn?=
 =?utf-8?B?K1Vnd1NaWVY5Mzl5R1lxcWxhTElFQjF0djRZb1hvVkhqcFVScUkzc1dmbExX?=
 =?utf-8?B?NTAvMjlzbFpsSmlydEU5SUUvMFg1L29RQW1PbEhUSEp3ci9sT0c0RXJHSy81?=
 =?utf-8?B?TStJMy9uM2tMWGxMb0F3K04rMDUwYlk1QXJkYTBjcWNUTHd1UXBBT1N6Y0U1?=
 =?utf-8?B?U2VaTlNQUTRESUpvWms4Y3RzRUpDeDc4N2d4TXpmTGVUZmQ1SktlUzNPZFBk?=
 =?utf-8?B?cVlRU3BUcGtKWE5yZllUaEk2WTFKM2NrYUlVaDFHSXpRQnlTQ2ErUUp5TnVj?=
 =?utf-8?B?RzVBNlpKOG1ZVGN5OUt0TXNpelpCN3FURzA5eDFKQXgzcTZWeHVGTHhPK05p?=
 =?utf-8?Q?khKnvjXEdKhZIsiYe2MG5/LxvMaxwyqc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm9tc3pPNlFlSXVITnlVbGVCUDZFd0paTklPUHNtdGZ5L0VhaE52bTF5c1J6?=
 =?utf-8?B?a0FudjBVRHA0bzVhQXRGSWxaV2NYMWZRTDdTNWhrNHl5WXBFbUxuc0dzRUsv?=
 =?utf-8?B?Qit0V2lRTUV0b3V2VHhEVzBCRGN1cjh2a3FMUngzbXBxL3IrcmVoZHhaSXND?=
 =?utf-8?B?VEh1ejBweWlsTDRkWUdmUE1NenRxWE5DQ0ROV1M4clR0QUJGcUJOckswTjRi?=
 =?utf-8?B?Q3Z6UHRsbjg3TGlsV0ZkRm1qLzM3RmdNNCtybm1uV3luN1lYZkpuVkZTT3E2?=
 =?utf-8?B?OTQzNXhDTXEwK3NzUmFldm84Y2dYalZaZFhWUUlXWUNrL3VsYnd3NmN4cytV?=
 =?utf-8?B?dU1vVDdCcmNkREJGaWNSUk5oWnk3cGRGdHRnazY0QVcyaGpISEl0YzJ1cURx?=
 =?utf-8?B?eURoZ0dUUUdNdWVmVjBiREpyOWhadEt2QkdocDFlTkY1eUxmN3hReXlqNmtV?=
 =?utf-8?B?REVoV2RjZ2c3blNiMENzTTJaM2I3MWkxMStTUjlTS202U0ZkeERwbHJTOGlJ?=
 =?utf-8?B?bFR3R2VHWkhKSGlteWZZdTZ2MDZoMU56OVdDdGl3V2lpc0twOVozTlVxVmp4?=
 =?utf-8?B?M2ZlUVZVemV3b0dNVS9BakpQWVVEOFJvVkVpcTBCSTdzVEN0amMzSzBqWmky?=
 =?utf-8?B?bElwT3JCdkNVS2x4bElDQ0VJOG9DS0EzRHp2VHJUdDY0NlplZTAxc2c1NWlL?=
 =?utf-8?B?bGF2ZnQvOHU3VTBGRVVvTlJTOXVkYlBkRmNmVjVoaHlRaTkzLzlCdi9COVB2?=
 =?utf-8?B?MlVWMXQ4bEVTbE1QMldoY1RjUkErRi8zTEk0QThNZ0YwK28rMTJwNkRaRzlN?=
 =?utf-8?B?UTFiQlFtNHV3R1pYVVdTNE9VazZOdlpzZS8rQVNIYS9IYzVHbWtLakxKTGY5?=
 =?utf-8?B?aEhxRTJNMTdyOHlDZUN4ZndIb01TQlp0NkJpaU1CaVNZMk5ROXN0UW91SElV?=
 =?utf-8?B?dnlsNlI2R0NieTdnQ2RUdnU4R1NxQTl0SzFqR1dOTklkZmc2T3lTSlp0ejdz?=
 =?utf-8?B?QkFLUG5CdnlRVkJUVHlqajl1dEZpVGFvWWx6VUxmNW9YMHd4VEZqZStsM0xZ?=
 =?utf-8?B?dFdWVE1nQWpTaEh0d3czeTRDcFB3bVVUV0pmUmp4SzU3bERYZUlNLzFhQUYx?=
 =?utf-8?B?YzBBcXZBM2tBYUxzaTVVM1IrUnZPRGZWMEpTTndxSFUwYko4enExTE1vdW83?=
 =?utf-8?B?dmQvRFlTd0g3eFUrSmdkK01wNU14anRqRTVmazZDSGhmWFJBRzUybmJ5Nm00?=
 =?utf-8?B?Sll5dkhEOVNmNVdYdHZPMENDMDl1RjdBNk1OTzFISEtEcG9tUHExTGpPWStK?=
 =?utf-8?B?MzRRODRWa3FiSmlPbER3eENQY2dhUmFVZER3NGllRHFydnBOTkNtTDNhTmR1?=
 =?utf-8?B?VkEzeWtGbkQzNkZ3azFCL2h1dnhadENJOHRKaUVIV1dWQmlCWDhqSnBkVjlY?=
 =?utf-8?B?bDV3ZjY1VUx5cFFkQTBXampiVTd3R2lwNDIreFRjdmQ2TU9xZ2J5S1kxTVh6?=
 =?utf-8?B?SXpvVmE1NGJTU0ZSWTB3SURGby9PeVBJb1p4UUN5bmRQa2RBYzdNTHpkQldX?=
 =?utf-8?B?ayszNENuZWJPaUdhdS94cHdOanVSaUEyRG9IWVY0ZWZrK0laaUpSUnpRWHVV?=
 =?utf-8?B?OGNUZXNxQ28vcy9SUmh6NG5Pek1zQmYvOGxGMlFRMGVmSVhuRjlISUlJcTk1?=
 =?utf-8?B?Mmx0blM2WHBxZ3FUbjNCc0dmNzVRdDRhN0pOcklhV0liVzhXWlFBei9rb0hL?=
 =?utf-8?B?SlZmcDRPU1R1Nnd5a3ZBbjBwZWR1bGh2K2ZyRVE1U1NjV3RSd0Y2TFpmdHpE?=
 =?utf-8?B?UUpUWWR3ZW0rSmJ1UXpoZk1VSUZTY1ZZMXN0NjBwS0k0V0hBdFcyVS9JdXlK?=
 =?utf-8?B?YWt0RU5KclVveHpuUmZKckV3YnFxcmY5RjIwRXBESUpEL2dFR0M2dWR0dk9k?=
 =?utf-8?B?N21Mb2dXV2VtUkFtZ1M2RUpuRHJBMFRnNTh4dGszRmJKbDNWS0lGTTFkQlpn?=
 =?utf-8?B?U1ZzM3R4ZlhYNlM5WkJ3QXJuemh5Z2pNMk81bURQRjBnS0g1MDRQWDhtRXBN?=
 =?utf-8?B?VkR0WnhkdnE3QlhLbjlpekRTL0FpK2pvMytJcHNHZEFmOHprbXZuZzF5TS9s?=
 =?utf-8?B?dFUrZzRUeEZrYVlwYkl1aVFEVGp5cVlUalRPcEdxOG0za1lWaUEvS2YyRlJv?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BPqrF/8uNI9Qsf5bUm+X0DoSizV6xP2gqL1VGWCgzai0eWvBs7ArguwYUn3SUJ+WadcP84kXnoQCbJe7qvICa/4nLsDV17w2uAA3F6YsHCepD6qUyOHljYGwTERaITB2Ge1NA9UcKK/5ODcRACVR340L0dmSy5RPMQLyzlDHf93fdYCOPvkAk+pAyD0c+ERSeT9Jtf3/1QNrF8QMdp0hWTN3hDJ7xPL8spRWC6TRam9PsasyPHAF4DG8xHP9YriVQCBEJuk+6xhq3DjIXS3GqvByCv3v5GShZTJ8ftbu3HRA7stZ5GC1jX/eToSO152oAFyUW9YL+QSihhJXySwTo0u9hUotS/slo0lQKo4u92hcPuKURcpUSGwBEdGV1DiFSa6goVOb/4rtEVp6+KbaRT08FgGUIZD0VuUJniE+Ka4vzxxLKk9dAL7p3Keio2cW0wHq69owQe2+0QsKR9CUnsM+7ZYx/z2tkvQTIPRoD8zSV04Q42awgD6SW6rY2XbRW9HD7tAqwhCu6av2hQepHGb0XFAM7PHA0z+aqJN52KcCRU0Rql9A3vZb+WEfC7scgn0yHD1e4Wd0iepkl30QRlXloThAz6xtjM1dZYKhCbY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e41f9b-de36-457b-d950-08de1b123142
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 19:50:08.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtLBB17BkryOV6DZnLbQHAI8ZDkSI5RQaSDEGx4+tBJgDp2gYI9/VFisByJvkftsCyvJGHa+YkdK1qWwz6wfh/U+xcV/YQZD/sHen6G6cO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030177
X-Authority-Analysis: v=2.4 cv=Aa683nXG c=1 sm=1 tr=0 ts=69090995 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=g_5NQh0UZuAHVuUQhoUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XFRg8Hz37VISISfd1mbuL6rNqhh34EXd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE3NyBTYWx0ZWRfX6feKCgwaVTrA
 QRTyy46q8t2Snh+9+4t8h29N5oiYQW9z6Hj+4LFqesrCLlRGIPMv4nhPKwaOGX7RWf24S4hQBt+
 o4xl5U2awa636JX8YBQxHeaZC3CuGdtKbMk6IchZeavj4/4vYAST/zd9JPjL+skscyfejMx7j/T
 vmDAg8x9SY+USR/mNtG3lotlk8PakL9a+G2GiDrwdnkS8y+8Jl5ecAM/MugzdcvmmHEfL/Zix58
 7VRAzfpbs+tGUyorko0afCJK4OQZ6/9bK1xe+Xkux9rbspQ/yCEpBV344G7UrGJfKxE4ksLxxF5
 afdUUZqtHvqg2/FvT6hpeZZiK61VXqKwPzNi9UyE/fvMuqOrOVsbFfPtK/kgcWBnMk5IXQQlQzg
 3Zxq9UssNpTWEXnNsMtCac6qizVmeA==
X-Proofpoint-ORIG-GUID: XFRg8Hz37VISISfd1mbuL6rNqhh34EXd

Hi Olga,

On 10/30/25 5:47 PM, Olga Kornievskaia wrote:
> When we are shutting down the client, we free the callback
> server structure and then at a later pointer we free the
> transport used by the client. Yet, it's possible that after
> the callback server is freed, the transport receives a
> backchannel request at which point we can dereferene freed
> memory. Instead, do the freeing the bc server and nullying
> bc_serv under the lock.
> 
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfs/callback.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 8b674ee093a6..2135c363c394 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -270,7 +270,14 @@ void nfs_callback_down(int minorversion, struct net *net, struct rpc_xprt *xprt)
>  	if (cb_info->users == 0) {
>  		svc_set_num_threads(serv, NULL, 0);
>  		dprintk("nfs_callback_down: service destroyed\n");
> -		svc_destroy(&cb_info->serv);
> +		if (!minorversion)
> +			svc_destroy(&cb_info->serv);
> +		else
> +#ifdef CONFIG_SUNRPC_BACKCHANNEL
> +			xprt_svc_destroy_nullify_bc(xprt, &cb_info->serv);
> +#else
> +			svc_destroy(&cb_info->serv);
> +#endif

Is there any way to do this inside the sunrpc layer? Perhaps in the include/linux/sunrpc/bc_xprt.h
file which already has a #ifdef CONFIG_SUNRPC_BACKCHANNEL section in it?

Thanks,
Anna

>  	}
>  	mutex_unlock(&nfs_callback_mutex);
>  }


