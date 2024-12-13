Return-Path: <linux-nfs+bounces-8556-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 521B49F1516
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 19:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63928169E8B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522B6189BA2;
	Fri, 13 Dec 2024 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bMXwxerO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uRGwxQ28"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AFA1DA5F
	for <linux-nfs@vger.kernel.org>; Fri, 13 Dec 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115273; cv=fail; b=bpvzv4nthD6tRG3UK/tc3VPn2gvYOtjdeXs70M0Yarctvh3CP+Lcbdomr09VKoQXoYZIxCxStcTa4PCI14+X8u6DCeoSkhq9F4IJtK7puMBu4yo1+ofAl4TvjUAEXaCbqQF1s/ImWR6vGOuRGtEqwzSeyoh2puhzJZT5IaH/NRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115273; c=relaxed/simple;
	bh=geYlpim0kzfjXy26B01skOVBN8zho1Is8f/AP8m8HZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pvZVDDexV4qkmZ95plcIVMYF7G5T22qR6JvhFWIRdZbQQkAi8TlR238MQnoKF1nS5rJv26g4GXg9qV2hvG2hjyF4y2Jvwa8nK7wsVc8bclcC9DM0uBLmy3VEFix5Hku/WUEVA45yc4duKUa70cBifR6ZO77x/o91MaXVXVv6LpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bMXwxerO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uRGwxQ28; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDIBrsR011070;
	Fri, 13 Dec 2024 18:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TCDsy2vLZF3EghF51rdFx1a/MxgNiC7H4LbgWNfP6aQ=; b=
	bMXwxerOTYImPpKmEGzPYnoeUhOgcLRyS/10HkJaAxS9zOxzYFcjMGP3mn+03vQe
	SVU9gG5DXQQChjbP9yQIEbh/OiKnsW9Uc3rB3aF0OSp6SMMyiAx43gMle/Fgc/Lk
	urUe3AxZ3hOFGKEhX74+kSgdyCGaQ9LffuPpTq5X4epHM1qX48kZJxxhPrmpYt9R
	0OsGFU1B8evbkDH96J6hUnux46at3PIbwhoUBqRzryDpeuQCHnDPxVO3K2xp0CVg
	OPUUXMbS05btFPZECPwRbC7uBn5NWypIIh2Tk5tNb1i53Q99gMFCMxI8A0Ztxrs4
	P3Mef73rcvAgaz8BrSFcGA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdyt5wtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 18:40:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDGsui2038162;
	Fri, 13 Dec 2024 18:40:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctke4b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 18:40:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMTiL3cdWBNvjUhrx+eY7We+Ilr1B6WJxu0rLMXvHyl7tAIHiGUQYLBRBlQIiunuz8BiW7WNpH2eIDjTJBadA4PgGhcB/LEEGUt1aHzSOFWXdP8qd7inIoZlam6rbF75rv/JMk3r72DLwmDylR2DzksNrqAO51ezWi9whEz+J6ESdyYqBMg+wob39btmAhRS3QXvMrSErmaFTvSJdRB2teM6//6Q1u54Oef526h8wyE9wUeOz8KvCjXasWy81m69lqRqUpMY43ujbCs53AaNYC9a9FLfVJmXJ423rYxQFGmDPJR+iCbdStXqF/NVaSriwBkX9FAMBwZ1D1leiAHk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCDsy2vLZF3EghF51rdFx1a/MxgNiC7H4LbgWNfP6aQ=;
 b=kbTPv/qDDhLJiFR9AZyyzUnMh82UGVwpVM8rli/Q2X5Looiz+hNOSn/2tVagit49SFZ62D1vcYM/Gy3Bk7D4MSh389y8O0kKRIlPZEHolmYp5GeQlOseOs+XkYG/tYtWSWIwdcCxGqIzdCnp19mZaNPvaik3Fk37hVqGTWQk2YcjEx7k4g63R/OI/TNb4/3Riyl6b++KiVO0tYYobMAOrui55diWPA2Ohur4JmjZ1DCVJXChLEcpnBgCRYmmKc26+MOUwFobDaoGN2XjX6py21JbPYR+0boBqLJBG8S5WOfeSPpz+MyWCm1MT8fFE9ioyrukDygeEl1SDsdGwDvehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCDsy2vLZF3EghF51rdFx1a/MxgNiC7H4LbgWNfP6aQ=;
 b=uRGwxQ28RKvrqctKWJhpK3CrihFu4oNPUBlOZyyc6uxYfia9jG0OepCAxkknPgENfzCNqg/asKLEECivs8iUMfa/tRqZCxFdtSQKjZVLz6jIB+K+d1dl7PBmy4N5qiONccDinXCcltDw2GOGcLP64IrYpqXqJ1792F7AJGcmVV8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4904.namprd10.prod.outlook.com (2603:10b6:408:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 18:40:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 18:40:56 +0000
Message-ID: <00dba584-79c0-4450-8cf1-69ce5c40601e@oracle.com>
Date: Fri, 13 Dec 2024 13:40:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
To: Olga Kornievskaia <aglo@umich.edu>, cel@kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>, Anna Schumaker
 <anna@kernel.org>,
        linux-nfs@vger.kernel.org
References: <20241203162908.302354-9-cel@kernel.org>
 <20241203162908.302354-14-cel@kernel.org>
 <CAN-5tyFCRcdJ_SRKfb+79dJ8pxRp=N4vb10FT2eYkhcmEb+uhw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyFCRcdJ_SRKfb+79dJ8pxRp=N4vb10FT2eYkhcmEb+uhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:610:e5::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: c496fb51-b7be-4045-d227-08dd1ba5ae6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEQxWVZUd2hkNytGdmpLUTlWZ0JIT1JVd215VlhSb0xpMi9kWWg3UjVCN2tm?=
 =?utf-8?B?VVhQQmwxd2xER00xUi83T3ltYzR4dkxwRzFmWFF0WFc0UEx6bWlUcWRuUm1E?=
 =?utf-8?B?YnFTUndpOVdldlJMeEVDZUo3R1RnWFVocDhGYVAvWlRxbXFWakxGcGsxNVY4?=
 =?utf-8?B?bkUyYmhnaEZHeU02UVpndWY3Q2ZPNm9nNVVrd0Zta2dGS255b3pHMXF2eEFy?=
 =?utf-8?B?c2Fady9PUU4xN0tjLzJZVU4yOEJKR2VuUDFjV3pzbG1nNU04dWtrQWZnRUkw?=
 =?utf-8?B?dnVqZk80RW9sODlOU2g1L01wSFkrSHljWit6L2lCTEVPU1FmMXNXNnlCdjNt?=
 =?utf-8?B?ZlhIMnVwZHh5S0JJT2pRd2IzczYrc0w2SUlTNHE2aXlRNXhvanU1NTZGLzZF?=
 =?utf-8?B?anE2RzRzc1VtUTUxZXpuTmJDcHc0dGpYS1Y2QXdSKzFXVnoySXY4blhrWUFS?=
 =?utf-8?B?OWJGd0IyeU80UlJ3b1o2OXhxdlVxUk53REorL1gzeDJmemtFTVlPWVh1bTdN?=
 =?utf-8?B?Q2ZWaXZ5WHc4cm9wYWgyeWFNVks0eEVNWndsQThWNlJyc3h4OEkzYTVzUUlX?=
 =?utf-8?B?LzYyOUwxSEtaR09qK1B5cEY3QXNUMHMvWnVVeWhFN0c4WnNTamJyM28xc0RK?=
 =?utf-8?B?M2YzZ3cxRWtxT0F3RnhBL0tLbFZGZEZQZmlpeHhLKzYzTEp1blJVZkN6MDMz?=
 =?utf-8?B?YWtBSEZiZmVweTRtUUxKQmQxN3BKWWpLRlBzS0M0aU5xTVJJWktBMk50Rmxh?=
 =?utf-8?B?bCsyZ09BOWcxNHpYTnZESDJIei9qRUZmRWFhcldKQzB5dmVMSFpiZ2dZanF5?=
 =?utf-8?B?Si9GOEo1Wk9lRDczRFBRRDN6c3JFY21NdUFRNksvNjhmTjFnSUNUL0JkdnYy?=
 =?utf-8?B?bzhiUEF0a1d1QXBSS2I5TmYxcmJRUEtrRUZ4V0FmTzN0NVFra3Mvb05JdmIy?=
 =?utf-8?B?Z2RtcWI4ckFkcEZ3NUhYRDhFSHlLZVBweUxNb0J5MGVBU0Y4ZmdUR2oyeVoy?=
 =?utf-8?B?Q2t4VnRadHRBK2w0NXhLdHZ4UDN6Q2FtRDBDUDU4L2lzci8vSFBwQkMwbkVs?=
 =?utf-8?B?bE9OSC9SS0hZeDhpRitFRE9BdVRPNmNSU3lYaXlZR1BWaUpDTzJhNHpuUGdK?=
 =?utf-8?B?YmNnNDIva1k3Q0ZGcHhyWmpaWWZvN3RiVXNOMUh5U0NPT280a3ZWMnZUSEZt?=
 =?utf-8?B?OXpaNmtUTmNtbVhsSnZNMUFKandpQlZKd0FscktHSlovcmduQW4zcDB3Ukl6?=
 =?utf-8?B?UTFpaWtxcEtBQzJNWnlxVzg5K0tIYUZIRUUxZGlkSmhuVzlvTGZQSUg2R3Z3?=
 =?utf-8?B?YWlnemtIRDBaQ1hJZmM0UDhvUWFoUHFUakF0TFFjMklVU3c1aFVKWVRHSjNz?=
 =?utf-8?B?NjJOZ0RmcS95bmpsaExSMkgybUNjWWp4aGZkaVhTbm5wQUFIaDRGSkF3YTUz?=
 =?utf-8?B?bjBOY1greE44VUptWEFtZGlzTGk1MmFWSlN4NnR4SHc5K0hqMXZhcTBwSXFp?=
 =?utf-8?B?K3IyRmhxM2orL2ExdDVzVFo5WWRuRG1YQXFnQ2o3RUcyQmw0SFR4NjdrTG1W?=
 =?utf-8?B?MDhsVHM1bUpjcDRaQitwK2dXU01OdEk3ZVY5aTlwVkRSNnZFL2N1VlBNZHkv?=
 =?utf-8?B?S0V5R1poZjVJb0dGcWU3RmUxUXE1dEQ2Q2NHb1dkSDdJQ2t3NnZ6aGpTSlla?=
 =?utf-8?B?SFY3SHUvemIxNkhENFEzb2VNaU5nVkNEcmh5dldsNFNYMUJUVEVhVWJ4K2ND?=
 =?utf-8?B?aGFlTDJUYUQ0VGtjSFc1WGI2NDZNZkxySUMwS0JBOFRJc3VtOFlEVlh4WE5s?=
 =?utf-8?B?OTR1SDRtamdQQThWTC9TZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2Y3VVc0V0UxT3g1MlRxSFl4Y0dYU1N2Z2RoZ0Y4RVROSkNvb1Z3Ky9UNmhD?=
 =?utf-8?B?SXlOcnNGeXBNSlVvc2drZzZTMzRyRVFpT1J1eDg4aDIrbi8rNFhvcUJ3M3Y2?=
 =?utf-8?B?ZFUzSmRlS3JkQ3hRRUk1QVVxL3ZwVWVVTDF2ZTdCTm9TZm9zVjJHdWgxYTF6?=
 =?utf-8?B?Tm5Bekh4UnZOSVA3dXBxK0FwVGoxSmhlMmwzQ0kwcWJPbm1ML1dkeEFJU1dN?=
 =?utf-8?B?UWhYckVYNFBIVGVUdENtR2tIa2dZcThqT0lOVFdsRlhjVUhmZUZZdGdvTmRO?=
 =?utf-8?B?TExZL1Bmdi91a2NneTArVVB6Nys5S2dFRWw0bEszZEl6VWN3dkROcHM2V09M?=
 =?utf-8?B?aG1aN3JxLzdHWEdzcHQ0WWFIZGl6UEl1RWdQVFFGdUZPeWJyR1JLSFlvWG1N?=
 =?utf-8?B?WEFMZDdXNjJUeEtGU0ZxYjIxN25JbS9ibXVvNUg5eVZLckFhVk50QUVPb0Z5?=
 =?utf-8?B?dVJWNUE1TTVBZnBxVGF3b1JWTEZNTlZxSnJNUXZkQlRXOUhpVThtT1VlenVj?=
 =?utf-8?B?STgxOG01dU1EZnozNWtTZ0ZJQlNxT1JuUFpHeXJsb0J0bVExUmwwR01xYnZJ?=
 =?utf-8?B?dnpDSTVNeVZySzNlUTJYOGxpczNwQlN0R0x4RWp0cEJUYk9TK1ZmQTk0b0V2?=
 =?utf-8?B?dTB4WWlpZVNXT2c3a2Jjcm1yS1Vrc3FhTnEvd21jTWxmOU9mU3RqQlNFZ20y?=
 =?utf-8?B?TWdVUkJVWFl6eW8zb290WEczZmxLVjBkNDJXYzRFbGsrd0ZWY0ZvSkphVVZp?=
 =?utf-8?B?VW1QU3BZQWQzVEFNbWNmZ2UzbEFQSUVaU3daeUlkaEtiR3NTNTRZZ2l1dW5N?=
 =?utf-8?B?TDQ0WjJUS3ZJQmp3bERQQm1MWWc4UmRLYjRhZC9uemJzRGpSSXZNWG0rNGhj?=
 =?utf-8?B?czVmeVh1RUkrUDdENGFSRFF4U3ZFeml2ZkJwVWc5d3RrcURWQlZOVXkyTkRs?=
 =?utf-8?B?TkF6QXB1N1luM055U2hhQzJyL1QzV2UrWDd5UXhid0paWjJ6b3o2aTQ2VnpI?=
 =?utf-8?B?N25FNDl6RUVlNldOZU8zOHhIWE5nTzBwT0l6M3dURVRzVDJ3VUg0eVgzNVEz?=
 =?utf-8?B?ZzRQQkNGWThqMVNBTVFJejlXWVF5UG5vcUQwV2kzQm9HQ2pZMkd0dnNFOEoz?=
 =?utf-8?B?VlFBTDNYdnJHTDc4NkxJUERxTWw4WTBKaW40Zk1oa1ZXL3o2Sk12OC8rQzFD?=
 =?utf-8?B?OXh2VkxQc3dSYTdWNkE2NCtiSVpSeGlTY1hYbHpUMUFoTXdVSWNzYjVmTWo4?=
 =?utf-8?B?YUZucUhENUxwTUVzRVhvRVVhd1ViUFV1NFpOMk9XOEsvMSs1U2dsakdhZjdr?=
 =?utf-8?B?Z2Q4UFl6a3VmNTNPczZzbkY2NTQ0NTB4VWs4K2IrU0kxcmhjVTZQOHNBTWo0?=
 =?utf-8?B?YVUxMWk2L2I4UUQwL29UYll3SkhTc2VUYlhhTVlIT0o0WU9EK3k3bDB1ZVhj?=
 =?utf-8?B?NmFJbkRyU0NDUGVyVEJhdVRDaTRBZTlBZ01xanRxU2F0WEJ3d09lU2ZZV1VL?=
 =?utf-8?B?UWpDZkRCZ1ozR3FUdXVheDR1MHhJd1grK2pHcnh6RFhIL0ZiZzV1UlhERE9T?=
 =?utf-8?B?VDdqbForZFdJaWhyaXBKdThsdTdzR1g2WDZxVXNma05hUUovUS9aL1RZTlRZ?=
 =?utf-8?B?UHJoK2dzNGUzZWtQLzN0aytwKzhuazczWW1KcERaMnNZREpXNUxTbnJKQ1h1?=
 =?utf-8?B?UlRMYk13WjZTMks4QTBCY24xaDM3TXI3SDJoUnorU1ZDazNVZWNuUHc4RStO?=
 =?utf-8?B?SWwzK1VxK2Q3SEREUUhYNk1NV0puNWt0OUEzZEFhaEFCcFYvRFNibThUa0RM?=
 =?utf-8?B?WCtBUlhqc0hxTmdwV0tBeGVqd3lDVWh5NVRGNFI5OElReDdHMkNuTXVjcVlR?=
 =?utf-8?B?ZDAwcitXWXZwckx6dHlYS05sZWxUV3drbkNjUWNCdUxBbldCcnBNaC9yRlRT?=
 =?utf-8?B?V0NZeWtCMGNIaVB0SXVacjlkSEJrWVVrWGNoTUhsK2RzUWNLaGp3cmd4OVhK?=
 =?utf-8?B?QjZFYzNYczZ6TGJZdFg1VzBqRzQydGtJaW8rcE8yOVRBN2NJbVRwSFFUWjVJ?=
 =?utf-8?B?YWFlZjVUa0NGOGVyR0FKTGg3a2VyUDBzbFlDWFZMYnRuV1BpWkw5aDFqNUNt?=
 =?utf-8?Q?HMTWbZ3Ee7imH6f5yCHC/1F1w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WsMH4PylvLrhLRp0n2wQZg3wj8e46E9FmyDWhOlox8lMbdbPdIQVoRtxRCtpAS2RbIPStbDtqCuFvnZpF3xPRFILy1goP+rsYkl9vw911BRivdJjnhIgJcdA+bCyPnSraleAfKSd7BQrVPTi79Q7Jp9Dw2RZl/lBEfBA+F1CJJrNJ/r7B8cMSjh9zPFIyIaHrg2PfTb8Kf/hV1QwEr7+d0K63lNSbEFKt4XmRxpuEIwVVjQKpfeYyAprfHYEOccM1yWTTKdqua2D503T2/MeGf8jc2LyO3L7iuu0Cjk81S1Tuee7GvYtmMZ4i/ZG0GOiS6aWtGnn7Sam/alHa1lj/n4XqcmLlDTWLRCgNerNV4iFYXqN0P4ov5dtg3aBL8qp6EzDvLJ0yYOmz0nPs7AH1UIOZNbsJoO3q7qcOTBirUZ88aiqKiFMrOXcuZ4qMQ9bKpr349b9XsLvzBDqYvTxsOr8wl5Xajj3C7mY8fj5T+gEIaehTNBsbJggvOeFoR5ErT3KAeBRPTPJFHZc4Kn5mBkPoRzxXuKbsSuZx5blHMDSYY11jZC0qBT5Wcna9KiaTJaSsbSQeu5XxIy1/nJj2q/GVFnWjhzy+tqSCC86n/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c496fb51-b7be-4045-d227-08dd1ba5ae6d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 18:40:56.7984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+CLe5lm+J2HRKyhjm5PiOYvuFpqdTxzoRFw5PShsLMyR5WnG7/EB8DwtvRw4Z5hdGJQKdwWEGBMUmlHQL4UcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_07,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130132
X-Proofpoint-ORIG-GUID: fU38oylGHgrg7pFoZ8s4m5uRe03Jisq4
X-Proofpoint-GUID: fU38oylGHgrg7pFoZ8s4m5uRe03Jisq4

On 12/12/24 7:39 PM, Olga Kornievskaia wrote:
> On Tue, Dec 3, 2024 at 11:29 AM <cel@kernel.org> wrote:
>>
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Enable the Linux NFS client to observe the progress of an offloaded
>> asynchronous COPY operation. This new operation will be put to use
>> in a subsequent patch.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   fs/nfs/nfs42proc.c        | 117 ++++++++++++++++++++++++++++++++++++++
>>   fs/nfs/nfs4proc.c         |   3 +-
>>   include/linux/nfs_fs_sb.h |   1 +
>>   3 files changed, 120 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>> index 9d716907cf30..fa180ce7c803 100644
>> --- a/fs/nfs/nfs42proc.c
>> +++ b/fs/nfs/nfs42proc.c
>> @@ -21,6 +21,8 @@
>>
>>   #define NFSDBG_FACILITY NFSDBG_PROC
>>   static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid *std);
>> +static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid,
>> +                                    u64 *copied);
>>
>>   static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *naddr)
>>   {
>> @@ -582,6 +584,121 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
>>          return status;
>>   }
>>
>> +static void nfs42_offload_status_done(struct rpc_task *task, void *calldata)
>> +{
>> +       struct nfs42_offload_data *data = calldata;
>> +
>> +       nfs41_sequence_done(task, &data->res.osr_seq_res);
>> +       switch (task->tk_status) {
>> +       case 0:
>> +               return;
>> +       case -NFS4ERR_ADMIN_REVOKED:
>> +       case -NFS4ERR_BAD_STATEID:
>> +       case -NFS4ERR_OLD_STATEID:
>> +               /*
>> +                * Server does not recognize the COPY stateid. CB_OFFLOAD
>> +                * could have purged it, or server might have rebooted.
>> +                * Since COPY stateids don't have an associated inode,
>> +                * avoid triggering state recovery.
>> +                */
>> +               task->tk_status = -EBADF;
>> +               break;
>> +       case -NFS4ERR_NOTSUPP:
>> +       case -ENOTSUPP:
>> +       case -EOPNOTSUPP:
>> +               data->seq_server->caps &= ~NFS_CAP_OFFLOAD_STATUS;
>> +               task->tk_status = -EOPNOTSUPP;
>> +               break;
>> +       default:
>> +               if (nfs4_async_handle_error(task, data->seq_server,
>> +                                           NULL, NULL) == -EAGAIN)
>> +                       rpc_restart_call_prepare(task);
>> +               else
>> +                       task->tk_status = -EIO;
>> +       }
>> +}
>> +
>> +static const struct rpc_call_ops nfs42_offload_status_ops = {
>> +       .rpc_call_prepare = nfs42_offload_prepare,
>> +       .rpc_call_done = nfs42_offload_status_done,
>> +       .rpc_release = nfs42_offload_release
>> +};
>> +
>> +/**
>> + * nfs42_proc_offload_status - Poll completion status of an async copy operation
>> + * @file: handle of file being copied
>> + * @stateid: copy stateid (from async COPY result)
>> + * @copied: OUT: number of bytes copied so far
>> + *
>> + * Return values:
>> + *   %0: Server returned an NFS4_OK completion status
>> + *   %-EINPROGRESS: Server returned no completion status
>> + *   %-EREMOTEIO: Server returned an error completion status
>> + *   %-EBADF: Server did not recognize the copy stateid
>> + *   %-EOPNOTSUPP: Server does not support OFFLOAD_STATUS
>> + *   %-ERESTARTSYS: Wait interrupted by signal
>> + *
>> + * Other negative errnos indicate the client could not complete the
>> + * request.
>> + */
>> +static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid,
>> +                                    u64 *copied)
>> +{
>> +       struct nfs_open_context *ctx = nfs_file_open_context(file);
>> +       struct nfs_server *server = NFS_SERVER(file_inode(file));
>> +       struct nfs42_offload_data *data = NULL;
>> +       struct rpc_message msg = {
>> +               .rpc_proc       = &nfs4_procedures[NFSPROC4_CLNT_OFFLOAD_STATUS],
>> +               .rpc_cred       = ctx->cred,
>> +       };
>> +       struct rpc_task_setup task_setup_data = {
>> +               .rpc_client     = server->client,
>> +               .rpc_message    = &msg,
>> +               .callback_ops   = &nfs42_offload_status_ops,
>> +               .workqueue      = nfsiod_workqueue,
>> +               .flags          = RPC_TASK_ASYNC | RPC_TASK_SOFTCONN,
> 
> I wonder why we are making status_offload an async task? Copy within
> which we are doing copy_offload is/was a sync task.

I tried it as a sync task, there were some issues with that that I
no longer recall.


> Why is it a SOFTCONN task?

If there is no existing connection to the server, fail immediately
instead of waiting for minutes to reconnect.

Otherwise, just like RENEW, the client will stack up a bunch of
OFFLOAD_STATUS operations as long as the RPC transport is down.

Also, when retrying, wait interruptibly -- that way a ^C will work
as expected.


>> +       };
>> +       struct rpc_task *task;
>> +       int status;
>> +
>> +       if (!(server->caps & NFS_CAP_OFFLOAD_STATUS))
>> +               return -EOPNOTSUPP;
> 
> Let's not forget to mark tasks RPC_TASK_MOVEABLE. I know other
> nfs42proc need review and add that but since I remembered it here,
> let's add it. It allows for if ever this transport were to be moved,
> then the tasks can migrate to another transport.

OK.


>> +
>> +       data = kzalloc(sizeof(struct nfs42_offload_data), GFP_KERNEL);
>> +       if (data == NULL)
>> +               return -ENOMEM;
>> +
>> +       data->seq_server = server;
>> +       data->args.osa_src_fh = NFS_FH(file_inode(file));
>> +       memcpy(&data->args.osa_stateid, stateid,
>> +               sizeof(data->args.osa_stateid));
>> +       msg.rpc_argp = &data->args;
>> +       msg.rpc_resp = &data->res;
>> +       task_setup_data.callback_data = data;
>> +       nfs4_init_sequence(&data->args.osa_seq_args, &data->res.osr_seq_res,
>> +                          1, 0);
>> +       task = rpc_run_task(&task_setup_data);
>> +       if (IS_ERR(task)) {
>> +               nfs42_offload_release(data);
>> +               return PTR_ERR(task);
>> +       }
>> +       status = rpc_wait_for_completion_task(task);
>> +       if (status)
>> +               goto out;
>> +
>> +       *copied = data->res.osr_count;
>> +       if (task->tk_status)
>> +               status = task->tk_status;
>> +       else if (!data->res.complete_count)
>> +               status = -EINPROGRESS;
>> +       else if (data->res.osr_complete != NFS_OK)
>> +               status = -EREMOTEIO;
>> +
>> +out:
>> +       rpc_put_task(task);
>> +       return status;
>> +}
>> +
>>   static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
>>                                     struct nfs42_copy_notify_args *args,
>>                                     struct nfs42_copy_notify_res *res)
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 405f17e6e0b4..973b8d8fa98b 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -10769,7 +10769,8 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
>>                  | NFS_CAP_CLONE
>>                  | NFS_CAP_LAYOUTERROR
>>                  | NFS_CAP_READ_PLUS
>> -               | NFS_CAP_MOVEABLE,
>> +               | NFS_CAP_MOVEABLE
>> +               | NFS_CAP_OFFLOAD_STATUS,
>>          .init_client = nfs41_init_client,
>>          .shutdown_client = nfs41_shutdown_client,
>>          .match_stateid = nfs41_match_stateid,
>> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
>> index b804346a9741..946ca1c28773 100644
>> --- a/include/linux/nfs_fs_sb.h
>> +++ b/include/linux/nfs_fs_sb.h
>> @@ -290,6 +290,7 @@ struct nfs_server {
>>   #define NFS_CAP_CASE_INSENSITIVE       (1U << 6)
>>   #define NFS_CAP_CASE_PRESERVING        (1U << 7)
>>   #define NFS_CAP_REBOOT_LAYOUTRETURN    (1U << 8)
>> +#define NFS_CAP_OFFLOAD_STATUS (1U << 9)
>>   #define NFS_CAP_OPEN_XOR       (1U << 12)
>>   #define NFS_CAP_DELEGTIME      (1U << 13)
>>   #define NFS_CAP_POSIX_LOCK     (1U << 14)
>> --
>> 2.47.0
>>
>>


-- 
Chuck Lever

