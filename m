Return-Path: <linux-nfs+bounces-9911-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13F1A2B454
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 22:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72861887481
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A2B22259A;
	Thu,  6 Feb 2025 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E3htO0mo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vAAGmK83"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F13222594
	for <linux-nfs@vger.kernel.org>; Thu,  6 Feb 2025 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738878278; cv=fail; b=cP3q3Zcv9o309+6T1k5btRmACcjRcpx8lUIZPuKsh6FOcbyAxi1VmJm2gb5PSf9P/kv4qR5twiVcpAYv8sxWQqOY17bvmNiQ9f7Ppn1DBOVwhb9JXyls8/qXzj0DhHa+OANOgx9NXoT8CusnpcrO+D5z0vWKIly7ryNdHXt9+Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738878278; c=relaxed/simple;
	bh=N0G7rpAtEAqGSJsOQEZ6o0Sf/FxxMdxD1PqTHUGC89g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rzoSqPXTxhkv9h9c+4pKHbfPBLKiDuVi+9eiL3Mk4Dt0mTA3e40TPOfGEs/wDkQF5O4axQi9Lp9+O+CXSHxsSU5E7vRTj9nhY95jAP2tAff700P1yg4QHHTnig5uLBemvhj7OqMh9OhUAkXd60WiQzB1+R/tLbf9Fp0O36PqC2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E3htO0mo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vAAGmK83; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516JfuxZ016151;
	Thu, 6 Feb 2025 21:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Swf0YY8C1TWWezA9gPurIEF7R6FfyqsuCJetO8umyKw=; b=
	E3htO0mosNCXWcfwLqjeP77T0iC7A7J3tpo2rz6hK8iINvgSUVWO67VZ9ckTIRoy
	nqjhfCJRg6ev5IVGrcuSuSxPusWBAjGv+2SwKFLnHSQtt4TnRy61XTPdVhoELNbI
	TkjyHXFg/Rm/lMcItE6PYVd/3TahbwgnsR/Vw/KwUATJq7+rEOWTBzSLzD9F+Sy0
	ajSJ3OQnIp+KWu4Kr7KOG/jsLZwqkDO6QgZtDdqPQsKSnEAsIMxCM3S7V7Q7hVd3
	yVdtRWdVNFmtBOYc4UlclTql7HZN/uyDsEHi6Tx22pGoFpE4FQ+FXnsBwsgeICX+
	2dskwuJ23/lw2aEcZ/L4xA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m50ubmeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 21:44:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516KZDUO027796;
	Thu, 6 Feb 2025 21:44:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dqr6dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 21:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8LrjXiHvUTiUo+YRi4yqn0KIrCAnpKqcwHmi410eAozqy2OMsnQAcDvCO9k48ESIFhZg1II8JHWIGOiFdc4ZRD/dIPvKK+W46rWQqx5J4RXSLe4QrxiLPuMdrD5SvLyPnV+LkK4CTHw3DPRuXXel+yNDcTUEj0Yh9XFq1r9Cg/+UcL+KSHGy9P0xjPVG517jaCvbgdQJCAXXFR8iAIhDWRAh00rnusxxkq3jlwh2uKKk+2rGDE6zEM1gG9isyFUZoEar5aNz/BomnWq8yZLXjFAI2LTd75K1jAWgPuNaDPF85WiJQfEwWyPVIaBxpkG1stle4QGZNMWFgx7bU+k5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Swf0YY8C1TWWezA9gPurIEF7R6FfyqsuCJetO8umyKw=;
 b=aLHjwuSXM3JycaWpQu4cv/niQfevIBa+Si/LwQneIhzzBp1p8fU3lnEMohFX8qCob1taSQlML+KPA2cKvYW9rOUYEutMx0wPbUpkl6JB0GKKvxahXOIbeH0zzZlDZhhXBtzxwRu3qeKZ5WKJvbMh6C1BCWYh0KTKWrhZvEwsXC3dc0308PfFib39Ydev+tT2DANbig7NETzXMCYokJ4qGm0dps5py61O659cnIA/ApT7HbYWh7QPzzZqDPhePUfGyEevUh7FcQvtL2PX/lWDO6FpWhH4ILTD/HDjndV4IUddG8KDOKL5Yskuejx/pBiBtrqbetEZl1O7IlN/IVOmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Swf0YY8C1TWWezA9gPurIEF7R6FfyqsuCJetO8umyKw=;
 b=vAAGmK8320MKLh28fRix9ShOto5CAHsJUND2EqF29RsvZsuvPEW5tlQ0zBTSYVpZOiU3OVKBmL4jVSqoEJbSwTBE1iNFusgUZtq+8ZhKulnKd6xD7KSOSTJNkJ2gwMP0huRlN1fI6J2wSX4i463HTchp1nrPOSTp+BQfsYGBbBE=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 21:44:23 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%3]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 21:44:23 +0000
Message-ID: <a8183611-e3d0-4a40-85f0-2d2b82088e71@oracle.com>
Date: Thu, 6 Feb 2025 16:44:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v2 4/4] rpcctl: Add support for `rpcctl switch
 add-xprt`
To: Steve Dickson <steved@redhat.com>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org
References: <20250127215056.352658-1-anna@kernel.org>
 <20250127215056.352658-5-anna@kernel.org>
 <c6a022dc-b21e-45e6-ae17-b812a40ba038@redhat.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c6a022dc-b21e-45e6-ae17-b812a40ba038@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:610:e7::26) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|CH0PR10MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: d540245b-24fc-47cc-aaa0-08dd46f76b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3dkazRnS1laR0tiek1UYkVxT2wxdGxQRW1CbU5aMjd1L29Gbm8xUnVjWmhw?=
 =?utf-8?B?ZEpBSkEwMVNyN3NubG9ZM3ZOa1BveU1kU2pFaFJVcjJ0eHE3M1RTejBaUGJB?=
 =?utf-8?B?cTAzSUUvTnhYN3BYUURQSW14MnJBZkRVWUlIeHcyRXRZN2wwcUtpZ1ZsT0ht?=
 =?utf-8?B?aGFPMFR1VkxDMEpKbWhSb1U5bTFuSTRlU1pIZWlCQWZOdkVKT0ViTG01R1U4?=
 =?utf-8?B?ODRUdHhoSUZneDhwWHNEUVYwQ015aEtpaHNzYXhxVFhPZGxRZHhtdmFSWitD?=
 =?utf-8?B?QVJzZGJwOTB2czlKOUNxNnJERWpOSEY1VGJybm1pRENTYUFHU1pIamN4Umk0?=
 =?utf-8?B?OS9TYVkxOGxZaDNPb3l4eEQ4eENMbU51dDVJbkhRSFpmMjVKYXNsTGJSWU5q?=
 =?utf-8?B?UFdzWjZqRHhoZ3cyODJaMWhLbG5nNlMyM2FnVFd4S1pyOHgwR2tjNktjcDIr?=
 =?utf-8?B?Z1RGK0dNTHJlNytLU2tTeTJaNjVrT2N6M2tyVG5NYWZKeEQrTnFTRVJaUmdR?=
 =?utf-8?B?eWZhNFZ0MllRczNaalduQmpmd0l1SkwvKzFSSW1zcFZDY0JiTmRnbUhyekRy?=
 =?utf-8?B?ZlhQeVJNdnFYMFZJMHB5QWhzV1JHcWtjY1EyRnJVc21UbkY0TjZqWStWa1Jo?=
 =?utf-8?B?TVFiS3ExWG1WMWIvOFBNcGZlcDV3YXRzTVEzdlhaZGgzRlBrVnA4eFpxWkd5?=
 =?utf-8?B?WHVlVS9kY3J5YjBUcGphaFhaYmNpMkZEbndtclFMZ0NUK3YxVnExd2dJN0ln?=
 =?utf-8?B?dlloM0J1bkxHTEFrb2RkZndiK25OdXY5cHhiWHdNTWhFVW04angxc3NMTStN?=
 =?utf-8?B?TmljeFRDSXVuWGNnaUdiS3JRZ1J0Qi9kcXpHQnpUd29sMGlNUnFqWDFyTElN?=
 =?utf-8?B?MDR2bGNLYzdZNkdORnoxUWdnNWVNTlZudzhrYjVoRm4rTWJZL1Z3OTNyeVRV?=
 =?utf-8?B?ZnlRWURqMW5YbGtnWHdoODlXZTdEVG41bkE0WTBlSUNKb3Bkam5INFh6SHgz?=
 =?utf-8?B?dzBCd1ZsZWsyRjRnc0R1WS9TVXM2NDluVTBJMDRERzRDYlhJdDJ1Nzg4L1NG?=
 =?utf-8?B?T2t5RGRPRU54OExiaXhTTGlQeXBjVGpPMUdxQ256WEh6MjNoTXRrMnZoKzQy?=
 =?utf-8?B?UFAzYXVKeVM5WmNvSGhLaC8rMjR4TndyYVFONGxhb0xLOHJDWVkveCs2cUtt?=
 =?utf-8?B?V2V1V2hlbXBqaENBOVBGMEl3SXhXeFNqaGwxUEk3THY5dEVHQXlKcCsrMU51?=
 =?utf-8?B?TVlOWEduVVArbFNBclptRVcya0JrQ201Y1lYQTJNSmpiUkdHaklDd1phV0Np?=
 =?utf-8?B?Y2cwOVd5K2JOaXJKc0pBOStHS0dlTkR0c3ZZZHBvNTA1cHNEN2JGQnhZdS9l?=
 =?utf-8?B?Slk1RGhXQmtrWEtjMUR1VU9ydXVieE9VUzhVNG5VcnBOMkh5YU5VVTU3aDVH?=
 =?utf-8?B?V1kwbnNqbjJFRXB5amhZTGswZDdSMDVDZTMwVTZuL2hLTVVnTUx4Z25uL0ow?=
 =?utf-8?B?UTlKc1VKWGh1YWM4M0ZQTkhXY0I2dUd3N0FhbkI0NERDZ0NEVkNzU0lKVVVV?=
 =?utf-8?B?cEpQNkJFZFJ3RXpGcEU4b1Nvd2FiUDNPZmFqTVFNN3FFbXQzRE93NXExc3c0?=
 =?utf-8?B?UTB0ZEF5aU00UDY4bVdaYTF1QityOXZVMzROOEFIZDAwMW5nVnh4cTkyS3ZM?=
 =?utf-8?B?V1Zya0pUNUJMQkFtTEE2Q2xpWUkrRXV5aTVFak4yYUkrblpHcHBpYm94d0pG?=
 =?utf-8?B?MExqZzJlaVVHeGVzUi9QeFExbXlzbG1kWDQrMld3NEk2S21ZYkl0Ty9OeFdN?=
 =?utf-8?B?ZDlweEJmdGZKR2loQzVldmZIeGpVMGxCZS9uKzh6a21kZlN2VE0yV3NlaE1C?=
 =?utf-8?Q?DsPWHjZhtzhKu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTBranp4Z1k2TDJUSDVQcjl1SHkrOW9QNDkrYjhBK3hjYkpEL0RqQWJ5WUlJ?=
 =?utf-8?B?RVlINjJNMlk1Zm9UdE9Gd3ByNTlMYjQxeDJzQWY3SUtoU3ZhLzBlOTc2cDJF?=
 =?utf-8?B?cUhTQWplZFE4Tm9HS25RMjkrK1VzbnJpeCtnUXlZUUEwS2RheU1uNVN0Z3BK?=
 =?utf-8?B?VGZtYTFZaHRvdTFiVVBzUzdkNm5EUFZ1eEJacjZYb1JhTFl6T3VmVXRSdE9z?=
 =?utf-8?B?eUxWOHpwb3BZNjRvZEkxaTBSMlY5U3p5YjJxZzFFd3doMXloRkQ4d2tHcEhk?=
 =?utf-8?B?dk95bGhsalJLQVZWTUdPK1d4ZEpobndnZTNERFQ1amhVWnpHZWduRWhheXlo?=
 =?utf-8?B?UFBRd0lja1hpQjRaZHg2K2l3QitMdlpTOHVkZnd3WEFPSjExWXhNZmdXUytV?=
 =?utf-8?B?Q3RVeTBFeVdXRHNEWXRVSnE4dHltdGdXL2NiRGc3YjN2Tm5WMTI4QnNaNGRx?=
 =?utf-8?B?QWNmNjJKa1VFc0ROVjlCT2RKZytjekd0YTRaL0RnRVFkZ3FySCtiSlU2VHJB?=
 =?utf-8?B?Nyt0eXdMRlhxSGQ1OUpLNEpFbU1VcXlMcjljNXpWTmszUTlVS2JNNFdBTDcr?=
 =?utf-8?B?YzBZNDRCZ2hNeW9uM0RFNHdTUVRQMHZTQmdOQ0pLWVk5SzdpWVBETFErVXlR?=
 =?utf-8?B?YnBQU2dOSnloSUVvR0lnVnJrd0VYeUMvMWlvMkJ5Q3dZeEh5bVowVVI2Sitm?=
 =?utf-8?B?WkFoTEJ1QkU0Qm5oNjhnbGNYNGE5SjBxYmc2dzVzWE9yUGhKQVBkdGU1UTV5?=
 =?utf-8?B?Mm5ad0x6MlRvZncxdHg3N2t1V3NpRFlWbkZEdkhPYTQ0NlpsbEdmWjdkaDJ3?=
 =?utf-8?B?a3g4TDFyYlBrQlV0Y0VyUTRqZG9uK3NUeGJ4WEVQMVFKMDVEN0pFQ01BMTZ5?=
 =?utf-8?B?dkdCRUVSeVJYVFIyclBCODhoUlJOd3JDaTVOQ1N6cDdWdWJhV3RqRUZzamgz?=
 =?utf-8?B?dHRGb0xKL1piQlova1dWNjVoUXZESVhJOGhVb3puQmwvSU8xTmUzUU0xL05r?=
 =?utf-8?B?Zk1xVVdHUUUxRDB1MlVIMkhVYlpoM1FnRm5qbEZqVS9JYmRsaFJSRGNCZk9i?=
 =?utf-8?B?M05CNC9PV0tWRTNmazI3VXRtMVF1Q1g0SmhKVE1IcUh2L0E0VkJSVFFYVWlz?=
 =?utf-8?B?NXVqVEJyaERRVFVLaXJrdmxMRHRwejdSTy9HKzIwMGkrbStPSTdheFkxTVIv?=
 =?utf-8?B?ZEtab3R0R1NFdUNnK0FIc0NURWNaTnFxd1BmRWV1TFhRUlNuMUlhSlA4Tk94?=
 =?utf-8?B?MG1PVGdqKzk0MzNYeXpWY2VkblBqSXZMYUFyMGxiQlBYakNkQm1VbG8wUmJR?=
 =?utf-8?B?c2pVbXR6NnE1M05MNmpsZVpTeU9MRGhieFZQbVladEVEUE44T3dBVWtkWmVZ?=
 =?utf-8?B?OThIaC9VbStxcnJUdnBzZmZrOXR1T1hPR1pqWENKWEtMM1M0MXcwUitCRjUw?=
 =?utf-8?B?RFBFT0xOb0tMMC85OCtaWGowTmxlT0lFVWx3R2dDSG1ZVWJFQjNFSUpCRy9R?=
 =?utf-8?B?eEgzc1ErUzBQblB2b1ZnL2YxYnZnVmppNjlqb1dyODZmanUrbjdVZXp4amtF?=
 =?utf-8?B?dzNtdm1aMElDSTAxRnU1MUQyUlhOQy94QkUvbWpHNVhIV2VSWC9odmNyYmty?=
 =?utf-8?B?cWtub21LSFZ1U3d6N3JUYjdMb1NVVHBHNXZTVVEraTJxckNCRktiR1VNQ1FE?=
 =?utf-8?B?OXQ1eW03ZjFnT0U1VzByOXBmWEVFS3dreis5WitxNm5tYmdZdEZieUgvVk9B?=
 =?utf-8?B?OXVaaFlZcS9IUWRUMlZtNWRqbllwUk55aGlXNW03QW14YkZFOGNDUUxRdmNQ?=
 =?utf-8?B?TURWR09ueGNTODRwUTJLcGozd0k4cDVJeFg1WmpFQjJKTHFtNFRsNm4xZkZk?=
 =?utf-8?B?MSs5NHEwd3RpZkV1bVJvZ2RJM3MvQlJZb0pPZVJtallSL082MG1mNTMyVjdL?=
 =?utf-8?B?UmJQb2RvaGZuQjkreDJEc3h5VGZZM1pHMkRuVHcyeWhqMmRnNlFWRGxVTDJS?=
 =?utf-8?B?L1BUNDA3L3didVBVR1EvVWpydlhaYy9RQmNMU1dIMU9NV1RIRGZMaFRYSFlo?=
 =?utf-8?B?eHdrT1NaTEZvVThBbWZTQWVJWmRZRXExbzVTa3F3enh3RDV3S05MSERGUE90?=
 =?utf-8?B?MHg1dm5JVlVWYjdMcHJQYTFwMjJiMEhzaXdPNlhaWHF3ZS9VU2V1L3c5Skl6?=
 =?utf-8?B?ZDJvV1RJczhLcGoraC9LV2RKdi9nOUw1MkcwWE9UTXFSbTBMU3pqc1Y4Z1RQ?=
 =?utf-8?B?ckFPYkViYU5BWlE3RjBPZXNlWllRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PfXvPD9zJ553wV5u7WtuZ0M/yc8kJvsbf0kORHpDbeHh14UmDtYWmhml5qHHQNGH1MQLrCvfQ+QQ/vRxSBTLqOLht8793fcW/K7xkDH+KY+WNDHANaGxD8tvfsz5c+56+I/EXEfNs5HcL0LK8vYwjvAfQ/I6AIjDBmyz99cMBndXYLhy8XesMGnRlW26BtkByh2IskkaRg6lbMoxnL0gbVpV3ZZAheXCqRowFB53f+Nm5m1hdJhs3LjtZUaafmjjCrumLvCRdlzJCPDelJNLIQFxngty4tV70mK7Snms4Ym3s1WeIyf0+2C1+Z5qAdHJc3bG/xHLKm4tQ0vRWvJ9aXQRX408csLLxjiOkGlRmuW8Elk15EXMi1w+p4qXMJfNmpkyWtDks+FW1/ROem6xPJp/8KSx4C1KCq04OLcwcL4ijriEl7apIyiDtaFAJ6YWenIDuCCasWdn1MR0mWwqlAln/ADML58QE8vbb6s8qpywAnNxYvIAaODoiQ0LGL3qzRqSnCcaOVbVQILyNd76pdg5jQsLOmV0TvC788LQTfSbjlbqszlrwcuW8ETnRwFZjhAthsL5zZQr7lV+b6iSTgtb5e/mqMLzk6llld4DqZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d540245b-24fc-47cc-aaa0-08dd46f76b8a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 21:44:23.4858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qc6VtTLMFNCXdQQlzV6Ueo8aEVrxDs+AltmldnsSwbDGp/PKzag+TJGFVsTG40Xnap2I6WFs9D3UhFgUzQm7ZFVdyibMgRJjWTFIMLO6EXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060170
X-Proofpoint-GUID: ff0VHVTuMB1V_zltRn3lVIxWbwF5-iQU
X-Proofpoint-ORIG-GUID: ff0VHVTuMB1V_zltRn3lVIxWbwF5-iQU

Hi Steve,

On 2/5/25 5:23 PM, Steve Dickson wrote:
> 
> 
> On 1/27/25 4:50 PM, Anna Schumaker wrote:
>> From: Anna Schumaker <anna.schumaker@oracle.com>
>>
>> This is used to add an xprt to the switch at runtime.
>>
>> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
>> ---
>>   tools/rpcctl/rpcctl.man |  4 ++++
>>   tools/rpcctl/rpcctl.py  | 11 +++++++++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/tools/rpcctl/rpcctl.man b/tools/rpcctl/rpcctl.man
>> index b87ba0df41c0..2ee168c8f3c5 100644
>> --- a/tools/rpcctl/rpcctl.man
>> +++ b/tools/rpcctl/rpcctl.man
>> @@ -12,6 +12,7 @@ rpcctl \- Displays SunRPC connection information
>>   .BR "rpcctl client show " "\fR[ \fB\-h \f| \fB\-\-help \fR] [ \fIXPRT \fR]"
>>   .P
>>   .BR "rpcctl switch" " \fR[ \fB\-h \fR| \fB\-\-help \fR] { \fBset \fR| \fBshow \fR}"
>> +.BR "rpcctl switch add-xprt" " \fR[ \fB\-h \fR| \fB\-\-help \fR] [ \fISWITCH \fR]"
>>   .BR "rpcctl switch set" " \fR[ \fB\-h \fR| \fB\-\-help \fR] \fISWITCH \fBdstaddr \fINEWADDR"
>>   .BR "rpcctl switch show" " \fR[ \fB\-h \fR| \fB\-\-help \fR] [ \fISWITCH \fR]"
>>   .P
>> @@ -29,6 +30,9 @@ Show detailed information about the RPC clients on this system.
>>   If \fICLIENT \fRwas provided, then only show information about a single RPC client.
>>   .P
>>   .SS rpcctl switch \fR- \fBCommands operating on groups of transports
>> +.IP "\fBadd-xprt \fISWITCH"
>> +Add an aditional transport to the \fISWITCH\fR.
>> +Note that the new transport will take its values from the "main" transport.
>>   .IP "\fBset \fISWITCH \fBdstaddr \fINEWADDR"
>>   Change the destination address of all transports in the \fISWITCH \fRto \fINEWADDR\fR.
>>   \fINEWADDR \fRcan be an IP address, DNS name, or anything else resolvable by \fBgethostbyname\fR(3).
>> diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
>> index 130f245a64e8..29ae7d26f50e 100755
>> --- a/tools/rpcctl/rpcctl.py
>> +++ b/tools/rpcctl/rpcctl.py
>> @@ -213,6 +213,12 @@ class XprtSwitch:
>>           parser.set_defaults(func=XprtSwitch.show, switch=None)
>>           subparser = parser.add_subparsers()
>>   +        add = subparser.add_parser("add-xprt",
>> +                                   help="Add an xprt to the switch")
>> +        add.add_argument("switch", metavar="SWITCH", nargs=1,
>> +                         help="Name of a specific xprt switch to modify")
>> +        add.set_defaults(func=XprtSwitch.add_xprt)
>> +
>>           show = subparser.add_parser("show", help="Show xprt switches")
>>           show.add_argument("switch", metavar="SWITCH", nargs='?',
>>                             help="Name of a specific switch to show")
>> @@ -236,6 +242,11 @@ class XprtSwitch:
>>               return [XprtSwitch(xprt_switches / name)]
>>           return [XprtSwitch(f) for f in sorted(xprt_switches.iterdir())]
>>   +    def add_xprt(args):
>> +        """Handle the `rpcctl switch add-xprt` command."""
>> +        for switch in XprtSwitch.get_by_name(args.switch[0]):
>> +            write_sysfs_file(switch.path / "add_xprt", "1")
>> +
>>       def show(args):
>>           """Handle the `rpcctl switch show` command."""
>>           for switch in XprtSwitch.get_by_name(args.switch):
> Question... is this support needed by a kernel patch? if so is
> it in a public kernel?

I'm about to post v3 of the patchset adding the kernel side of this. I'm hopeful it'll go in with the next merge window.

Anna

> 
> steved.
> 


