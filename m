Return-Path: <linux-nfs+bounces-9486-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0961CA19922
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 20:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC50C188B952
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 19:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54218215182;
	Wed, 22 Jan 2025 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J/agCvzg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ocCeHp17"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EEAAD4B
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737573754; cv=fail; b=BnVP8a2Qw9RwcEDhqZKVz60OyUGTJUC8akxskaVBu2QTBzjix4JAyWIAJ2mjzb6xtegSYntXoFcdGqOkweAYMwnAfPVqn3pYCFc1Saey1H9A0yHOx7OGGFs8v0jQWUy6eq1QygP7kb5F0sVmMT4kGn/64iPNfCVOn+3BRJqRVJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737573754; c=relaxed/simple;
	bh=pmR0CkAhkKL/FtaBReCPpWNL74VFHf5mHOwRPPU71a8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s5yMeoxLNJLLRJg9DY6PUwKlyCQLByvFGVBd45GzPOtFJinE1ksq00DEwENZHYKZgy+YHpgMFcoGKXLtj6zu1bRjDnBV6Ir9+9kdBfqJI+KBCcKHJaojAJmWPOvmIZjfLhH++6Jf2lshHEGb82bMGUZjzGC2iHUbb71E52ee3G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J/agCvzg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ocCeHp17; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MGXjOV005592;
	Wed, 22 Jan 2025 19:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sxpTEuaBa4DDYJq3AB6rN9lfzaVCoPFAfI1sSg0XSKU=; b=
	J/agCvzgoks7VE0ayJJUUyrKFgoX7P+mbLlUXAfaZe9vMvsNam+5e5/ulBBRVNh+
	bvQjnbKbbjUPJpDvzARO3kA91h66/03t0lVSoNqmYGkdzhbt09p8Wc669iDeTegU
	zgOS7irBQWwHGktttZP+JbDNWgMy6AkOczd2/R+p/R6b2+wBBZcc7MugAkrAnoqI
	4oYwkK3kdw78d0DIvJfLKnwm/R1sPKDx9pS1dm4fcRZ8v+P2Ejg0Rxri+3SM+c8n
	/JGHXCutMsx3dYU48w8mkUDOEvB79xGowJ9e7puE8xapKgVZxzksLHGMARiiMHwg
	gOrOkelC18LN1bmDYutI/w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awyh1608-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 19:22:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MHYGMH036739;
	Wed, 22 Jan 2025 19:22:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917r85js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 19:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpqtfhP2gSdGOfk9/j2oUDPtUZ6FmCNGKpH0Br61nMeBoydKMX0bJI0hcvt3YNJdCI0loMaKAtupLqcnUoiaYaqwN+7L4RoMtjj+3yDIj1tZqqL9uq+v9tx/ES0xYdhkkYFZI1rCNsmp8OSfSOoYpguThGbOVP15xYDipQWR2Puu55gh/ii6VdS4LlbUuKCRO0i/3fED4URU5BbJz3PKHbVcOtJHctuezFE+HYed5rGfm4BNhWwSlzbmZxcpL+CujFPkzNzp/2r0gLyHwfNu2Mg/DuJ6CzgVNMfhuErsJKM66juXU42fMkRLwdwS1gmU2VyjktBDZxSfrrcelOrVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxpTEuaBa4DDYJq3AB6rN9lfzaVCoPFAfI1sSg0XSKU=;
 b=E/Q3Od07xPSHutJPqB6sny08bDPyMO7zKDxzXkXF3iiBymVHTJFAHZe/sFi9BUtjuzykUFae4xGv85oyq/2CSw5GthyOJOO0vVGt/J+wgSbBAZKgQa9HSOIlxOOaUqSa06qGhdguRH6Lv/+sjGOCRanIlRhjLziFrAMN6uwkzGVRkXZHIbp427oRXA/U10Qzt0csTF8Knri9ZNcAMKHdWIJ7DBYdY7HS5kN8y/3+d/G5uodSTEQggBJorGhZXxh1wf6wXr1w8ZxYXuKtAX6lqJ1e2rRLyDZnhFLCuwwRV/Rr8NSzSb3ctrJHJqc7LoxoNPaE7RAW1cZjAeN1+kQV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxpTEuaBa4DDYJq3AB6rN9lfzaVCoPFAfI1sSg0XSKU=;
 b=ocCeHp17Va/vhTjwoPkWbb3AkyVkvoo1laDB7XF+jl8/4bj0XoPaquyXWz6VZN8IcNBkDstzNi/OdEiR0Xhg4Was6X25vDM0q7Jhulgk+cv0Z1/J+ye+TCCWwCrFzGmMBlTgYmcmntq9pA0eaED0RGPNC9uXC6W51W8qBlNRk0Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4973.namprd10.prod.outlook.com (2603:10b6:5:38d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 19:22:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 19:22:18 +0000
Message-ID: <83ed7510-0a0c-4048-beb5-c4a10c38ca06@oracle.com>
Date: Wed, 22 Jan 2025 14:22:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] nfsd: filecache: change garbage collect lists
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jeff Layton <jlayton@kernel.org>
References: <20250122035615.2893754-1-neilb@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250122035615.2893754-1-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:610:cd::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: 7867d570-8b7d-4501-498b-08dd3b1a15df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEZBa2RPeXlWY1VGMkdaZEw1TXNaSUViOG5DdzlaZjVHbTJnbVZyeEZsbDIx?=
 =?utf-8?B?eFhGRDB5R1JaVGkvVEVJNUlvaWI4dW1UWTJRajRreVFDWVFpTEtJbVZLTkwx?=
 =?utf-8?B?THFWb1B2Y08vNnZBbXhTMWcrNTl3dmRrck5WZFNGYXJnZ2VZYWd0TXVYUG85?=
 =?utf-8?B?MDhwRi9KWGgrNXVDVU8xc0l5NW9pMURuQllpSFU2cFdPaGZnaG9PdU1ueUtu?=
 =?utf-8?B?dys4TWJERnUxTVlUM29DVGxNQmVWOXBEck41MmZPY0pqS1h5OGc5NkRUeU53?=
 =?utf-8?B?YXJCTDcwZVV2UksySzJBeDV6bXRkSDgrcXVqRUw1R3U1SHJjZlR6azZMYUdu?=
 =?utf-8?B?ZWhCVUY3QkorRmdFY3gzdHJadHpOVDVaaE5VaERtWHIyMUI2eTdETnRPM2xL?=
 =?utf-8?B?N1RUVnhXUmgxakMrTzJjTVhXRmMrd1NFUnlmUTdCYUpGK0w5V29jMVN3OExz?=
 =?utf-8?B?TUJxNnFiNkFiUkNCK29mcm16UEQzK2FGVGE5emIyNHAzNUh4R2d4U3d0Z3Jx?=
 =?utf-8?B?VjZvVk1vb0E3WThCQ2NTVDlMNHkxRnJicXh1eE9ZU290SWtXWkw1dGFRSm1E?=
 =?utf-8?B?SDBnbExDNWxkMzVQRTlINUx3K1p4OFIxcDBCMEtuUHlRQ2cyVE1nU01Denl4?=
 =?utf-8?B?OGMzNFZHdWwwOWM4eEllRlViSDR3V0tzbmVLVjlqeURUUk1nMDNycGloQ0Ir?=
 =?utf-8?B?blVmMXZXSXJSNXBxOHpacTFIcUhxSEZkbXJQdXBWUHdXMGluOVI5bHlVTWpD?=
 =?utf-8?B?MkoxeHB3MjZHZ01VSkpWaHZFVzAvUnBHbXJEYnptVGpFS1Z2NThIdkZ1ZSts?=
 =?utf-8?B?Q1dtcDRneGc1M3g3YmQ3WFo5dnBuYXN6YjdLMXRIRVZSbVBNV1J2Q01hbzJR?=
 =?utf-8?B?YnRrR1hxcU9FdndlNlNQVWpYQis4bUxVa3U5U3MvTkZ6QnhEaVBLY20vSENo?=
 =?utf-8?B?Tm1CYSt2TkJrWWNSeEJ3YmJTTjVkWXU5QjBkOUR0bVlIY3JGYUpMaEtkSExZ?=
 =?utf-8?B?S1MxNmwwTWt6UndPMUY1R3o4NHo4NzNCb2RSR08zN0tPWXVhSEpHQ25DQy91?=
 =?utf-8?B?cG53cmZod3V6TUppbCtudkQ5ejlFWlYrWWtKTzZrNU9PNklMd2VYdHdaVzY4?=
 =?utf-8?B?TjhZTmpLWTRjbHVJazR5dGRqZ0R6TmJjWTlhUTFrL2lmem5NTFJIcFVMSlZx?=
 =?utf-8?B?cW1EVksvdXF4Q3E2OE10T1oyczF4MFo2L1Nhb1ZjSW5iOVViZUJLZU9QY1ZE?=
 =?utf-8?B?MmU1YnVtdkRWc0xOclRtYXJXRFNMS0FXN3J3WlpjV0lYZ3VjMDUxcGlZSHEz?=
 =?utf-8?B?TFpCUkkzdW1kWlI0MUhURWJRMU04RzdWckpWenhwTmQ0VlFubC9rbGxHcnJL?=
 =?utf-8?B?bkk5enR0NUF4RWxTSk13ZG0yakZVZC9GY1AxWk9HT01ockdnQkRhR2xLQ21S?=
 =?utf-8?B?M04wR0JOcFpwVE5sZ01XUll0Z0I4a2RlY2dCWFlLNmx6Sk93bEhSUmpOTW5C?=
 =?utf-8?B?VlNoQVBlRDlvM0VWckJxWVFlZE5LWTI2citqTk0rV3JXMHhZVmFxZmMwQnlN?=
 =?utf-8?B?ZnhSS1loTXBUT2pZV3RKaW9PTHBuTVk2MHhDQ0xpSS8xallKQXZrOHpwSDBi?=
 =?utf-8?B?QnlnMWkrUXMvNE5aeFRvT1lIMVhpWGlSdEM1TEgyZjVZZHd5S0dVR3VxUXJj?=
 =?utf-8?B?NUtGbTJXbVZVVkZ2V2NVdGxsODZXVE9aQ1FLRWFsV1hUdkRuK0dnSE96ZjA0?=
 =?utf-8?B?NVNzWDNJTitOV1V3c096ejNIb2pUQmRUeFlvZkNiUGR4bmQwUEd5TDdwcGhy?=
 =?utf-8?B?M3Jxei85L3RCNWhDcXZpZGloeFFGYytSV256QW84QXpRaWp2ZUxYVEJEV0VP?=
 =?utf-8?Q?j4M4jDgw0qwQd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkdKK2oyWlVqZ1plUFlyV0Q5V2lYR2V0bjN3RXBDNDgvY2liV0c1dDNPcWI4?=
 =?utf-8?B?Z2FaVWkyc0M3TWNmUStYeUZIelgvUStJV3A2SkNlV09JeFRIcTFtQytPblZo?=
 =?utf-8?B?YlJpaDhVSXdkYllXcW5yUWllRGRHam1McVovYXc3SVpicGhERTI5Rnh1TFdH?=
 =?utf-8?B?WXQ5Mm5Pa3JHTm11Z0NqOFdrd3F2eGtOV0YxR21aS1RjMFp2UlNTaEMxS3Fs?=
 =?utf-8?B?SEd2dzhudjB0NDRCNnpOS3RQRk9nV2VVS2QzZUEyVFBhYzlCY3dyMzE5bFNC?=
 =?utf-8?B?UW5iVE1ab1BudVJXeUZsbitGMWVUdnFBN0c4Vk8xNDRPbVJxYmJER093dmFv?=
 =?utf-8?B?dWk1bFhzL0NNcDJHTnRub1lpTnlDZ0NrbTJlWWxDTUt2NncwRDhqbWJma3A1?=
 =?utf-8?B?ZkJKMWo0ZTdPYmhEOWYyRDNPbmtzR2pJYkdjaThIRlZFQUlma0QyV01VaUd3?=
 =?utf-8?B?QTBqdlJhRGR1VTVZU3FSOVNOcUlVa2Y3cmZLY0J6eVhPbG4rOU41aXVndFNh?=
 =?utf-8?B?ODFETWFBa0RYZjhSSnBjaUpUL0dLT0tBbXhjbGsrdHVDa3BxWG8xWFJSU0pJ?=
 =?utf-8?B?dm1Ca2pvdzRlUVBPUEw3bzBkeTRJQ1FrWE93aDdKQ3BlOW1hT3Job0tzYTVS?=
 =?utf-8?B?b1dQbG1QekhaY2t1Nko0WmlNeXdwUU0yNXlqU1JjVldjUEVBaHo2Mnh3RmEr?=
 =?utf-8?B?ZEg4MTAxSXQxdE85dEpkSlE5blkydCs3bGREWTh3ZVJyekpHaGt4NGtHRDcz?=
 =?utf-8?B?SFZhUitWMlh0SWdjeldYZThXWUNDM1ZqYW1IWURPT2RxTWZIaGNlNWsxVThZ?=
 =?utf-8?B?ZFpvN1VnNS9rYUwxdkJWc2ltNUpiR0pwRGUxK1B0LzZTdHpPV3ZpMTBEc1I1?=
 =?utf-8?B?WWpSSWdvUk96SFdDMDRuRitnUnJ6cVAvVEFMUFRHRGtWQXFHbjVQQ1hSaDlz?=
 =?utf-8?B?MktpRXN1ZnR0MHkrYW1IbHorWjBXK05lVEdtRFNiNlA2RG5ZUkZzajQvcWIy?=
 =?utf-8?B?QTNvd01Jdk9ZdnAyVFhtNU9HVC9mVFdhRlFwR1kzaFpHUFpQZnFxdVZnWU1O?=
 =?utf-8?B?VXRiTWlaV2VNSWF4SGx3NlJFTUZXV21BcE04ZXdqb2Zrdkd2R2RyRDFkZnRK?=
 =?utf-8?B?TFo4bUs2V2RQT05zWVRKbi9jYlF5MjJSOEJPREU4RU5ubDVGcjc3QlpPaU1E?=
 =?utf-8?B?c0FrdFhjcVRDZ01wZko3SlZhWm9hOG1PTVV3SFVaYU9TM0lYNjYwV2ZFcGVk?=
 =?utf-8?B?UWJwVVAxL09sZWYzRzFqbDk4TDAwZ0YrNUtlUnlqUC8yWEdkQTBaTkxIME12?=
 =?utf-8?B?UnFmMkV2ei8yamFPalNkNzMrNDBXVEhmQ0dCUkc5ZU5IVHV4YkNEbEhYOG1M?=
 =?utf-8?B?OXdpOW9LUjcrS1k0VVBjQTBhbmRlK29vR3M2cGhNdUdWVEdKZS9kQUtTTXVK?=
 =?utf-8?B?eTh4VmY4L0hoa096WkU0WGh6ZWM2TkNBb3NwS05TS2JEcnlZQUF0V3hxdFVy?=
 =?utf-8?B?MVoxcW9jaDd2VVdMQ0dIL0ZhTU1SbkxvQllWc0xlc3pWNEwzYmZ1Kys1aUEy?=
 =?utf-8?B?dFZEVzkzdUNjcTJwcTY4WTU3VkRwNGpYdjRnNUZSTk9rWTF6dHpkNWxMWGZN?=
 =?utf-8?B?dHZQQWplME04VllqRjZGZy9TVTBCcThQTEdTYk1wZlI4TkVSNG5UZUlVNmFq?=
 =?utf-8?B?bTFGZ0R4ZDZvY0ZCQkFUdFJaOUEwTkQyeWFseWZEVWR0VTVqOUxHKzVLdkF0?=
 =?utf-8?B?akNlNUdhS05yUTZ3TTR1bGNma3RVM1BSZDJ5clV3NlJ5WGErVGc0RTVPY3dl?=
 =?utf-8?B?QW1ZSG5qc1l6MHVxbUlkTHdWbnV3UVp3NnozWGxvQlpnaEFNQjhFL01Jaitn?=
 =?utf-8?B?aVA1SExROTlWUVc3cmdsZlNmNHdGRVBQZjdNeUxKYVRRTVBkNWdwSVpoWUFO?=
 =?utf-8?B?dTBEaFZEcmt3bmJISkw0NWtwYkpxVlduMk1GNXZwTHpobzRWZmVCM1JsRmIr?=
 =?utf-8?B?b20rRWgrRnZOTldQbnh4YU5EcHUxV1laWUtWVllYcCtCcTRhZWljLzVKbmhl?=
 =?utf-8?B?S0V6SnBxT3VhZEhTQlRDcmQzUXVuTDlKVjAzM0hzY3c2d0FRQ2FISkJTS2Fv?=
 =?utf-8?B?U21YVFVIK0dCWGFlOEMyQ08zeFVqaTdLckJpYy9yWmVhSFZhSmxuY3dPK2ts?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A8F2ktKNOKLAZywGU9Sot23ArjN9LrvnYuJchxayZMXQaJzZTaIZeYnoNFO7kum8cAmg9jDz7PRpRws3xdcsCW57ZYnizwS45VbLgAoPobjt0FN18yuF9iHXbViz5X3p2QxjEoAKrLDwJ7YOXIqJkLLLIhm8zfE7tr6ZIjUbMBFX1I1+bnsf1WJNw5mh76PmK6KcTHMEt6Fa7c0+RlYYj/vP5G7xi9FhzUr97CaeI4ucYxTD/3ZuYsuox3ZWsvzKIf1d+d+gW+qraHh8PCWTR7fkW55QHpuSBG21f0Uzu6UdgHjQxpSkOqgck+WXl+n+T35IyA5k1b4QGO5u+uuH149+Z9aNAjebmsvpvdbrNl5KCdPI/anE3h/RIUXJtMl8gkdM4VPaviMG5KjYpX2mecz8r1lRtR+4Kc57++eSpJG0NgSevxP+nfQ2xCWspZAauToZWHGqjV4Jfmm9335mRF2JyJgGq6xhBQtefex/FIaSJKDHtq9OL8DSIsoF8yudzOoAXf7dHDy2tcRNaYTnViSsXypNubfGau+gsiLkYBpORZDdld4rfSjL7vWnpxuWl10/VQG3673HNB8zNxvMBQcWiZdQPHgUbKyQVEWia5Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7867d570-8b7d-4501-498b-08dd3b1a15df
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 19:22:18.0157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXKnD50ZGGM66EzQWasoBmtJIdsZLwCYRkSiUndpbBcZbt1YgP8tyPHd1ctySyf/Ca7Li0GcCYeitStoccVR6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_08,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220141
X-Proofpoint-ORIG-GUID: QdT3gpolSEvZRQy6CF8xurGmlyYxTX7l
X-Proofpoint-GUID: QdT3gpolSEvZRQy6CF8xurGmlyYxTX7l

On 1/21/25 10:54 PM, NeilBrown wrote:
> 
> The nfsd filecache currently uses  list_lru for tracking files recently
> used in NFSv3 requests which need to be "garbage collected" when they
> have becoming idle - unused for 2-4 seconds.
> 
> I do not believe list_lru is a good tool for this.  It does no allow the
> timeout which filecache requires so we have to add a timeout mechanism
> which holds the list_lru for while the whole list is scanned looking for
> entries that haven't been recently accessed.  When the list is largish
> (even a few hundred) this can block new requests which need the lock to
> remove a file to access it.
> 
> This patch removes the list_lru and instead uses 2 simple linked lists.
> When a file is accessed it is removed from whichever list it is one,
> then added to the tail of the first list.  Every 2 seconds the second
> list is moved to the "freeme" list and the first list is moved to the
> second list.  This avoids any need to walk a list to find old entries.
> 
> These lists are per-netns rather than global as the freeme list is
> per-netns as the actual freeing is done in nfsd threads which are
> per-netns.
> 
> This should not be applied until we resolve how to handle the
> race-detection code in nfsd_file_put().  However I'm posting it now to
> get any feedback so that a final version can be posted as soon as that
> issue is resolved.
> 
> Thanks,
> NeilBrown
> 
> 
>   [PATCH 1/4] nfsd: filecache: use nfsd_file_dispose_list() in
>   [PATCH 2/4] nfsd: filecache: move globals nfsd_file_lru and
>   [PATCH 3/4] nfsd: filecache: change garbage collection list
>   [PATCH 4/4] nfsd: filecache: change garbage collection to a timer.

Hi Neil -

I would like Dave Chinner to chime in on this approach. When you
resend, please Cc: him. Thanks!


-- 
Chuck Lever

