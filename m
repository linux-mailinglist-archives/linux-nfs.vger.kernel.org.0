Return-Path: <linux-nfs+bounces-10350-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A50A45184
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 01:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD897A144A
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 00:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2123219FF;
	Wed, 26 Feb 2025 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MX2TKhKY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JT/oW/vo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B08DDC5
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 00:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740529941; cv=fail; b=AWkHy7Q36esV/DiC1emY6ewMRWNCgpZrM+i8vER8b/MPyEAby1qJdWGyqcXKAPUI5DieBA7upL+s5AxC7sAjGI4YRWT8Imb0qrEn55GlcWXCteZ5tvHTm7Bc8LI7RSzBXWVqpgb9HIg8PUUEGUCeURo1vb5FSNIVgnRMlCXb2eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740529941; c=relaxed/simple;
	bh=K6ABuxjB5G1uoPqPJAzKLEV79RdkRyLzjoO0qRoMJy4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tMyZ9cd/kHVBlqbLUu8e6SMNjla9Hv21q9HtOZhGcZ0R+VDF3JybI6i+XhrLaE8ArbcpG3yVXxeAojYtnJjDnK0OMnf9EuWjb+KEPcXhP57wONTYEZ5FUaw38mM3cY4BqWMEUL+54E9/C9v3h/NwklWS0MtvQQ6a2JkhtsMbJKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MX2TKhKY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JT/oW/vo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMZFlh004078;
	Wed, 26 Feb 2025 00:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qp4Etj9Syj4VcKOP8b+KfscadZ6JZxFFcARVpWK4di4=; b=
	MX2TKhKYbfGhekfhp8RK+gHVSwrE6kknQ8H6pPegIBRWVULXQ1MBTwtjHXGGbg9R
	kE0aCuUydW/NDri3aZxRNIVQN8ezeX8hlj4UtSALKazmwAk4YVSSC10/gLqXYiOT
	3RySrcJbDQzqlXoLyXjOw1VH6Id6FmMoaQ9PVQ/HulmmiezTG72ItAWOJgNmUePD
	FPyn3VVSrDUE7DQ2N2UVQJpGDhquUwkhp0yl4Rq+oM6Vvor7dZme82la/TVdkb4T
	oHi87uNse/CX5nlxlgbIkF10h+lsjwfWjzsWKm6E3KizEGrLt/BmDR7uaDViRlMW
	UE1I8275w/XD1zy/x8782w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdg4nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 00:31:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PNNopr010259;
	Wed, 26 Feb 2025 00:31:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y519r0k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 00:31:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJgCY/xkIu58nGhq11FHG+UmjZV0sX8Gl0KiA5U+s118Hby2wUuOk3t8woFKhlauE5vyHBL4BWRsOMVKe9A6eDRFCqnf0rzpnPN3fMdS6gnQcdop7aODEYviflwT6Myhqo3LyQ8v0n6BtQ5xflFX58xAGF2xSSg/5BOfrn1LNZZdx63SWwzLY8P3a1B0Ptt9p1GHNiR/LeTRa1/722bcXunJRNBLTskrqmw5pxAcwwLD7GJMppqboGNbKVc/OT9vT0ZqQBipy86fmniWUq+9K9LWcLP5tYH/LWtteXtdknbDo+32P4H9cjOjNtz/FL/Vam4aU036dqq8GwAw7ZB0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp4Etj9Syj4VcKOP8b+KfscadZ6JZxFFcARVpWK4di4=;
 b=Mo+ZqKA0e/pY0coeC5hxMJqMHFK5faRFrLU8NDUmXBk9Ts7x6hH2fAKwZlY0YxV5PiEEk70QLo+iRqEjnCelFj8M1r3dGB2xKER5Htaar5k6Fume3djPnF0elkD4Nx0yJ5rrUGIXm7OKejrS1nVN9kn2krQCe1jXL34fcUxskC0MD0NIQa3pNngixkWZyaEYuyv659ZWfoydMmp8EMjOakETdBh737/t4pydUwhPJ0ObgIO5Uh/ZPDJL7YQOnKu1t3VGqv7bGlpNnsdeEip5CNYvKtZCGkj1dGVYz/KDTi8Ly6o3GDUDy4MTX8zr9F4ZqLB41bdX/9PpzyX3ZvMSuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp4Etj9Syj4VcKOP8b+KfscadZ6JZxFFcARVpWK4di4=;
 b=JT/oW/vo/ZhMbF0eoRIvo03Xc9bVZY3Qe0pBIVwP9KVAAYJY0gmrcmDNaxVt30tLnFNsjZyfeiR5Trnn64r/dVlFKWYgqAafz1I6+xkGQENtqtOQXbq/rJoXW3aCwsRMBgYKsKE09+Umm5l3959S++rhGS+O5Ua9KOz1ziJ9LNw=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CH0PR10MB5196.namprd10.prod.outlook.com (2603:10b6:610:c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 26 Feb
 2025 00:31:52 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 00:31:51 +0000
Message-ID: <bee17735-d7c6-4a0e-8da9-e8daea9fcd6c@oracle.com>
Date: Tue, 25 Feb 2025 16:31:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] NFSD: allow client to use write delegation stateid
 for READ
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1740181340-14562-1-git-send-email-dai.ngo@oracle.com>
 <1740181340-14562-3-git-send-email-dai.ngo@oracle.com>
 <dba0a1c365e0e3276639f7682bf07b3d3e593456.camel@kernel.org>
 <5d54e75f-7c98-4181-a738-dd1844461b6d@oracle.com>
 <2b65654e1e06125ba0b02b0beca3771896d4ab5f.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <2b65654e1e06125ba0b02b0beca3771896d4ab5f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:408:fd::33) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CH0PR10MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 308c2ec2-a0c8-46a6-6436-08dd55fcf686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzRtZmNiNldCUVFRWTVDUE5ROVVjUkhXNDRHMzIvR1pYUnc1cU82eFgxUkVz?=
 =?utf-8?B?N3k2alVHR3hSYUY3dkRscGpBZlI2ZUtVc1J3WlBCZ2VVcnhFdjl4ZnFBVzBQ?=
 =?utf-8?B?T2g1cGIwZUdSRXVDTW5sUG9NR21ENkZXU2ZjYVJrNFhOeXE0cWhpSHI1Nm5M?=
 =?utf-8?B?MU4xYjhta09wOXZWUWR2SHpQMG4wTm53djg5TWJuNCtuQzZMWHZ3T3dUdGI3?=
 =?utf-8?B?ZFJiL2x4NDNaQ2g2aDRCU2JWK0RjcW9DUGxEdEFmRGdZN1BGWU5FbjJIbFV3?=
 =?utf-8?B?V2xwK1lTeUxnVXd1Q2N3R3JSZTFaeDdOeW9Yams0ZTVVN2lBbU94bUd5QmNO?=
 =?utf-8?B?NUJrWHBxV3N1eE5JdHdnVzRZOG1nM2pVbEhOUm8xeTJIQ3lIYUJRNjZJdUFz?=
 =?utf-8?B?eWlVbSt4L3RFUk9hL1k5RHM0bEVEcGhJOFV4VkgyZlBTdUVJTzk1NitWLzRr?=
 =?utf-8?B?aXJGelN3SGgzWlhhdy9JdzZtWDZuaXNsQnpZTmxQV3BLQ2g3MWc0K0JNMFNj?=
 =?utf-8?B?QVBRTWI0VzBiZTN3U3BzZ2JhKzRzQ3I4K3ovaE8vZFpyU21lWnRZeTN1T3dP?=
 =?utf-8?B?MTBBcnFHZVNDRmRMVWFLT1RIZjFOUndEU3BPcjVHMlhrQ0YycmdYM2VNcmZp?=
 =?utf-8?B?UnBva3FqeGdwYkNoQnBJSkhTVUhoNGd3SFoySiszZTduZms0TDVzK0JBQkFN?=
 =?utf-8?B?ak1jNjY4aGhWcFcrM2J4Q3hVK09QVU1IOHl6SlZNbGJVT25sbUpIbUpyd1hl?=
 =?utf-8?B?OXVPU29sRk8xa3lmKy95TW94ZWJFZ0wyK2doSW5GSWlsMmZVbGpsTmZUcklR?=
 =?utf-8?B?WUJTbUN0R21jWGpIVkpaWjZFdUdwQTREUUxFd0poZzBHYXp5V2FJR3ZOVjhJ?=
 =?utf-8?B?SUNtOENSM25vVkpxL3MzemwwWDVtZE45cVpSd1lpRG4xQm1qdUJ1UnBORy9N?=
 =?utf-8?B?UE5Ib0lpSmdQU0l3NENZQXNSalJZeXJjMXFlL3BEaEViQ3Z4clorUlVIOFJZ?=
 =?utf-8?B?YjlVY2V5RGVSckdzS2U1b1VUR2FhVGpGb1lSSkpwVmlMU2k3ZWExRnM0L0Ju?=
 =?utf-8?B?b2F6RFdvKzJ1aDErU0FKelhJQUFxQ080THlYTmhnWnREWHovMUg3Q0pZUVA3?=
 =?utf-8?B?c0xrb2xidzBwaUltZWpRSXZMTFRUTzRzOGdRbVRRRXZ5VTYrYUlrSFBXT29s?=
 =?utf-8?B?cmplK21FbzMySUZHNC8wdUs0eURnMTlYWnhkaWp1U3lKYjJuMGxGaWZYVFk1?=
 =?utf-8?B?NldVeGd5M1U3M2lJWXA2QXRQMmZ4Y1dLNHAzYWQvajJUMUdJb0w3eDNwTFR4?=
 =?utf-8?B?cHQrQy9vdS81YmtnSmJlVDRRN0xrUm5wSHdBblhBWStRUkc1UFpiWnVBeVJC?=
 =?utf-8?B?S0NhdENBTUlQVlJFaVFjb2UwMFdnTTB3MVlDR0wrc2szN3lBVXBoZ09RMVlq?=
 =?utf-8?B?WnpyNjdtdEJRQUdzVWJiZEp6SVQzL1FBN1hhWXBWazF6aVhmWklxTUtxTjlk?=
 =?utf-8?B?MzdSOFNhd2JVSXpuVkFzUjVYa1hjLzR2aG9pZnQrNTdsN0o4bTRyd3BTWkdT?=
 =?utf-8?B?aEorczlFc2FsVHhYSHZUaW9rN2RxSDRIRlozY1dwaDRjMndjOWYzOUxIR2hj?=
 =?utf-8?B?SkVRN3JGUlRoTExvVGJiR3NHUEFJZHpNVHJPRmR4bkZiZFYvVjlTSGlSVWdS?=
 =?utf-8?B?bkQ0eS9RSkhUbjRxbkRsaVpXaVVVdVp0QmV6T1NROXoxMjlZQlRWUE0wMDlT?=
 =?utf-8?B?WVErZis0TkpSK0NUc042dTJkY2FtYW0vYTRCSzVBSzg1U3hreFhlSzFXZW1n?=
 =?utf-8?B?bG94ZytmenJUNzFSWFZGWDQzWGhvRnBmT2daNVZJd2crUWt4VzJuZFZydSsv?=
 =?utf-8?Q?4BSqjL2MVaLNk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGRMQVRObkVyRHRoNEpVYXNXWXlNS0dEbkloVmZjSHI5bit0aXR4OXVKYVFU?=
 =?utf-8?B?ajlJRDRXRC9LcXBLL3ZYNnlYNHJJY0Uyak5Ec1NVRStCcy92NGpsajZjOUZm?=
 =?utf-8?B?d3krcXVvd3pQWm1GbzFSLzFnR0RjL1RYSmdsMTVoTEpaVEt6N2FHbHVpMHpO?=
 =?utf-8?B?ZUlGd0k2R2ZabDBVbkZjekhXdDR6MlJXOTRZWHpRUnVMRXYrQmVaRjZjRGl2?=
 =?utf-8?B?L0tjSDNqYVZaTEhIRTlqSGZZMENUZXlQT2FMZ2czOEYrOFl2OUxDQW0wTGNX?=
 =?utf-8?B?Y0hFYWI5T2hzZVEwcWhDcXVGNnovb3ZqcHhRS0lJelZIVGsvdEhZYVdaalZk?=
 =?utf-8?B?aFZoT2ZQaXJMSHEwajBFb0M2K3lzUFpGbURqS0VGR21NUGNRbXViejhuUThK?=
 =?utf-8?B?d25LYTMvZTJCNnl6Yy9yRDAyV2tEclY2SHYzQ2lzenZzMmZXWmNHZ3FJNTMz?=
 =?utf-8?B?RDJwbzVXU2ZJVDlaVW5YTmNFRmtjdUZJU0EwUGNwQW1JVGNZQ21tRmp4YkNV?=
 =?utf-8?B?K1M2NGJVb3Z5cUQyVFRyTjJVUGplZzBIamZwYXU0ekVHM0NGRGNHSlRnRE9r?=
 =?utf-8?B?UXFQVW1STXVUOGs4U0hGSDBjRGtsenZOVTc0bHRYSnJVU3ZFOThPUzBFRHBo?=
 =?utf-8?B?a0hZTGlKOUlEaFd2VDRtYk9POC9SQy9pMFBacGpydHdWQmQ0UXdQWnZNeTIz?=
 =?utf-8?B?dFV6L1lQcC95NlhQVXR2Wm1YNWNxZFpqbkFmdHN6VHV5bHRvazBUd1hEbGpv?=
 =?utf-8?B?ekEwcExUQ25odlZJZURaK09uZ1NPdDlvWndtamJmRDZuTHB5V2VtZGFZYlJC?=
 =?utf-8?B?VGNZSi9SakQzZDRUcEZMWXBaYjh0MUpUYzlId3ZSY1d4WThNUWdmNWFzcitY?=
 =?utf-8?B?R0pIQ1JsT09VQUgwZVZkTFoxSE9yYmtneThWOG5IZ2YrVlFFekRJQlNuUGFZ?=
 =?utf-8?B?a1dYYUh1WlpwVU9odnRmK21BeFMwaWlxSGVaTmFrTExnMERJQTBET0pIajNq?=
 =?utf-8?B?R0VWRFhaYmRKQ0VBalVRUy9aL1Q4clhaV1d2bUJmVUtXZFZ1OWZYbTZDQkV0?=
 =?utf-8?B?cmwxKy9pRUl6aldnQVRIYWtVMVpVUGxvd3NtZ3hCMGtlc2M4cVh3aEhjajZq?=
 =?utf-8?B?Q1lZcExIYjUwSFV3TUhHbjMyV3lZWm5HMWYzTTRpNXhLdHJONnlsSlNmWUJo?=
 =?utf-8?B?UldNdG1VSTVvbUZjMmpDb0xYNFdvTUx5QUJ4SjM0M3FRMzRpZ3d6YktTRG8x?=
 =?utf-8?B?OWx2eU9lZ2FvSkV1cHRlZ3F0Rld1UTUrQ3lVbWRhOWsyK3lpZG02Z0xoRFRx?=
 =?utf-8?B?RlpEbFNsY2YyLzUxcEFnTGFMNmFrTEE1TGhNMXM5VkZ1NitudmhMT3hiQjZj?=
 =?utf-8?B?Ry8xaUVBY2Jadmwzc1NHSzFtTi92TDRRK1VQemViQkJmTGsvWVZEUmlaeFgy?=
 =?utf-8?B?L2NVUEVEdFZvUUMrYWRGNE9jd0xmRW5XbkFWOEJrMFcySmFrRGU3NVI0RlNk?=
 =?utf-8?B?cURpUVMxV2lvelN4ektRRC9QWEpBQnFMNVpsTlllYjFqWWtJTVpjUFdrbC90?=
 =?utf-8?B?aFVUK3hMdnl1RjFTdEd2eHFlM0hFZFB4aDM2RkxHTlpacmhkeG5lTUJVdlVp?=
 =?utf-8?B?OXBycXJPUUw5dVZjRGFLaS9XLzh1TmpJeEJHWEdmZklESjV2VWhIZFlFd3Fh?=
 =?utf-8?B?aFI4U1Yvc3krQmp4OW5mbWRqUzQ0ZG1zL1VpdWdrVHpURjFUR1RIOWdJb2U0?=
 =?utf-8?B?MG4yaFZHMm5MOTlBTFhNQkNtcHZkL3UzNHdocnJHaDM2NEo3bk1MWUZEN1ZE?=
 =?utf-8?B?WUtEMUp6VnEzbk11ODh3dEdycTRLN3l3eFdGV2lVNFptVkJDTWxoZ20wTE90?=
 =?utf-8?B?b3RuTEs4aURsK21jR0FsMmRTQ3JlSjhESDhuK0JWR25UN2JqSVpaRmQ3TDIw?=
 =?utf-8?B?aFUzemptRFlqSlV5OWEyQi9HUDUzbDUwNmFvRjJmS0pvOEpKc1hOUUt1dk14?=
 =?utf-8?B?OGQrUHUrWFZxaEoxaWE3YlMvWGhNZi9HbXh5OFhURThBWlpuMkNrYjNxMnAw?=
 =?utf-8?B?RGVHOG9BQU10Qm5IRkdUK2puN2NJU3hQNTNzOEk3QXpHMkJqbDRXZmg5Tk0x?=
 =?utf-8?Q?/LukPNIHVpNp3vvhhhRSYNSks?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	izzKVAjyHsSfBZ4iZIkcR7DnGsiSIJvpSrIxrysenPuoL05IkHdyftksXBcxpUAiR382bB+gmW3lUPwCCfVMGhIqsDXfUWy1/DwosDTo0RIQq45PsTFbv9vKF9oUU/A+7koMpOCP1hOkjTvsEpVDicGds3teyxsVOxn0/bT6oUbGbiS+sCUK4Snu4d/v1J3F9uOOD8rAvAH2ECIRF7e84OKkQ7zImfmsqhCw2/OFUuw+n+GHHtbqA/HvvZ8TXtTCM4/9rUWlXLu7tLqwgHhX0BvCO1CS58sxf0i9j70IjnQhPNWHH3PQ/lzu0ezVK0lza6aSwS4E5erOUC+tkm4+egUMhpPN4JVG+j1WZwS0zIxfGkYnidOasFNDKh8isUkrUN4LVUNr9dnT1Ur5LSG059vVVS9CUgwuak0NqbXzex2BsgZxALq95XIRx9ihSHuufMn4AMcdOhpc/4S6s423cPmrtDATZYmaFiUtBB9CY7grCixpFAnhgGDAcZe8tw6q/W5YRlqeX+d8mL87RGosohnoOIhAHqAZ7aHNRozLrU6MXRVAAti6dXgRIhEJcCLYTVcLYuOD1h0FH4SEF0AVgRcUfOnN3Wxz1rDwUR30RJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308c2ec2-a0c8-46a6-6436-08dd55fcf686
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 00:31:51.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36zjR7FEvuby3QzHf94ffEMHG1wPslQXlW6pYOlutGAVY8JgNPW1v5D0NJGBULKooJz1fWNLaM7BLMJvXGW+ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260002
X-Proofpoint-GUID: ZY7RCv7JXBbQEydDS0KGZ5Qtz54g7gpl
X-Proofpoint-ORIG-GUID: ZY7RCv7JXBbQEydDS0KGZ5Qtz54g7gpl


On 2/25/25 4:31 AM, Jeff Layton wrote:
> On Mon, 2025-02-24 at 17:10 -0800, Dai Ngo wrote:
>> On 2/24/25 7:48 AM, Jeff Layton wrote:
>>> On Fri, 2025-02-21 at 15:42 -0800, Dai Ngo wrote:
>>>> Allow READ using write delegation stateid granted on OPENs with
>>>> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>>>> implementation may unavoidably do (e.g., due to buffer cache
>>>> constraints).
>>>>
>>>> When the server offers a write delegation for an OPEN with
>>>> OPEN4_SHARE_ACCESS_WRITE, the file access mode, the nfs4_file
>>>> and nfs4_ol_stateid are upgraded as if the OPEN was sent with
>>>> OPEN4_SHARE_ACCESS_BOTH.
>>>>
>>>> When this delegation is returned or revoked, the corresponding open
>>>> stateid is looked up and if it's found then the file access mode,
>>>> the nfs4_file and nfs4_ol_stateid are downgraded to remove the read
>>>> access.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/nfs4state.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
>>>>    fs/nfsd/state.h     |  2 ++
>>>>    2 files changed, 64 insertions(+)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index b533225e57cf..0c14f902c54c 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -6126,6 +6126,51 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>>>    	return rc == 0;
>>>>    }
>>>>    
>>>> +/*
>>>> + * Upgrade file access mode to include FMODE_READ. This is called only when
>>>> + * a write delegation is granted for an OPEN with OPEN4_SHARE_ACCESS_WRITE.
>>>> + */
>>>> +static void
>>>> +nfs4_upgrade_rdwr_file_access(struct nfs4_ol_stateid *stp)
>>>> +{
>>>> +	struct nfs4_file *fp = stp->st_stid.sc_file;
>>>> +	struct nfsd_file *nflp;
>>>> +	struct file *file;
>>>> +
>>>> +	spin_lock(&fp->fi_lock);
>>>> +	nflp = fp->fi_fds[O_WRONLY];
>>>> +	file = nflp->nf_file;
>>>> +	file->f_mode |= FMODE_READ;
>>> You can't just do this. Open upgrade/downgrade doesn't exist at the VFS
>>> layer currently. It might work with most local filesystems, but more
>>> complex filesystems have significant context attached to a file. Just
>>> because you've changed it here, doesn't mean that you will _actually_
>>> be able to do reads using it.
>> I think allowing read using a write delegation from a OPEN with
>> WRONLY is an optional feature and is not a requirement from the
>> spec. So if there are filesystems that do not allow this feature
>> to work then it is ok; we did not introduce any new problems with
>> this feature.
>>
> This patch is swapping the O_RDWR fd in the nfsd4_file with an O_WRONLY
> one that has had FMODE_READ added. That will break on filesystems that
> don't actually allow you to do reads on a filp that was opened
> O_WRONLY.

So the current patch might not work for all filesystems, it is not
a perfect solution but it doesn't introduce any bugs or undesired
behavior. I wonder how many filesystems out there fall in to this
category. So far I've only tested with xfs and ext4.

>
>>> This might even be actively unsafe, as you're bypassing permissions
>>> checks here. You never checked whether the file is readable. What if
>>> it's write only? Same clients will do an ACCESS check before allowing
>>> it, but a hostile actor might be able to exploit this.
>> Apparently the NFS server relies on the NFS client to do permission
>> check at time the file is opened. Once the permission check passes and
>> the OPEN is successful, then there is no permission check on READ/WRITE.
>>
>> I wrote this pynfs test to verify:
>>
>> def testReadOnWrOnlyFile(t, env):
>>       """Test read using open stateid with OPEN4_SHARE_ACCESS_WRITE
>>          on file with permission 0222
>>
>>       FLAGS: writedelegations deleg
>>       CODE: DELEG28
>>       """
>>
>>       # create a file with write-only mode (0222)
>>       sess = env.c1.new_client_session(b"%s_2" % env.testname(t))
>>       filename = env.testname(t)
>>       res = open_create_file(sess, filename, open_create=OPEN4_CREATE,
>>               attrs={FATTR4_MODE: 0o222}, access=OPEN4_SHARE_ACCESS_WRITE, want_deleg=False)
>>       check(res)
>>
>>       # write file content
>>       fh = res.resarray[-1].object
>>       stateid = res.resarray[-2].stateid
>>       data = b"write test data"
>>       res = write_file(sess, fh, data, 0, stateid)
>>       check(res)
>>
>>       # close the file
>>       res = close_file(sess, fh, stateid)
>>       check(res)
>>
>>       # OPEN file with OPEN4_SHARE_ACCESS_WRITE
>>       access = OPEN4_SHARE_ACCESS_WRITE|OPEN4_SHARE_ACCESS_WANT_NO_DELEG
>>       res = open_file(sess, filename, access = access, want_deleg = True)
> nit: shouldn't want_deleg be False there?

Thanks! Fixed, result is the same.

>
>>       check(res)
>>
>>       # READ file using open stateid
>>       # Linux NFS server allows READ using open stateid from OPEN4_SHARE_ACCESS_WRITE.
>>       # However, the file permission mode 0222 then the READ should fail!
>>       stateid = res.resarray[-2].stateid
>>       res = sess.compound([op.putfh(fh), op.read(stateid, 0, 10)])
>>       check(res, NFS4ERR_ACCESS)
>>       res = close_file(sess, fh, stateid)
>>       check(res)
>>
>> and the test failed with:
>>        "OP_READ should return NFS4ERR_ACCESS, instead got NFS4_OK"
>>
>> Am i missing something?
>>
> nfsd actually does check permissions on every READ operation via:
>
>    nfs4_preprocess_stateid_op
>       nfs4_check_file
>          nfsd_permission

Ah I missed this check.

>
> You may be bypassing it via the NFSD_MAY_OWNER_OVERRIDE flag.

Yes, the NFSD_MAY_OWNER_OVERRIDE flag bypasses the permission check
if the file owner is the same as the user accessing the file.

>   Does the
> above test also fail if the file is owned by a different user than the
> one running the test?

I modified the test so that the file is created by different user from
the one that got the write delegation (on an open with O_WRONLY) and tries
to do the read using the deleg stateid. The read fails due to the check
in nfsd_permission which is the correct behavior.

>
>>> I think you need to acquire a R/W open from the get-go instead when you
>>> intend to grant a delegation, and just fall back to doing a O_WRONLY
>>> open if that fails (and don't grant one).

I think so far this patch works as expected, except that it might not
work for some filesystems due to the strict permission checking that
you mentioned above. However I'll explore your suggestion to acquire
a R/W open from the get-go to see how it goes.

Thanks,
-Dai

>>>
>>>> +	swap(fp->fi_fds[O_RDWR], fp->fi_fds[O_WRONLY]);
>>>> +	clear_access(NFS4_SHARE_ACCESS_WRITE, stp);
>>>> +	set_access(NFS4_SHARE_ACCESS_BOTH, stp);
>>>> +	__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);	/* incr fi_access[O_RDONLY] */
>>>> +	spin_unlock(&fp->fi_lock);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Downgrade file access mode to remove FMODE_READ. This is called when
>>>> + * a write delegation, granted for an OPEN with OPEN4_SHARE_ACCESS_WRITE,
>>>> + * is returned.
>>>> + */
>>>> +static void
>>>> +nfs4_downgrade_wronly_file_access(struct nfs4_ol_stateid *stp)
>>>> +{
>>>> +	struct nfs4_file *fp = stp->st_stid.sc_file;
>>>> +	struct nfsd_file *nflp;
>>>> +	struct file *file;
>>>> +
>>>> +	spin_lock(&fp->fi_lock);
>>>> +	nflp = fp->fi_fds[O_RDWR];
>>>> +	file = nflp->nf_file;
>>>> +	file->f_mode &= ~FMODE_READ;
>>>> +	swap(fp->fi_fds[O_WRONLY], fp->fi_fds[O_RDWR]);
>>>> +	clear_access(NFS4_SHARE_ACCESS_BOTH, stp);
>>>> +	set_access(NFS4_SHARE_ACCESS_WRITE, stp);
>>>> +	spin_unlock(&fp->fi_lock);
>>>> +	nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);	/* decr. fi_access[O_RDONLY] */
>>>> +}
>>>> +
>>>>    /*
>>>>     * The Linux NFS server does not offer write delegations to NFSv4.0
>>>>     * clients in order to avoid conflicts between write delegations and
>>>> @@ -6207,6 +6252,11 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>>    		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>>>>    		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
>>>>    		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>>>> +
>>>> +		if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_WRITE) {
>>>> +			dp->dl_stateid = stp->st_stid.sc_stateid;
>>>> +			nfs4_upgrade_rdwr_file_access(stp);
>>>> +		}
>>>>    	} else {
>>>>    		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG :
>>>>    						    OPEN_DELEGATE_READ;
>>>> @@ -7710,6 +7760,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>    	struct nfs4_stid *s;
>>>>    	__be32 status;
>>>>    	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>>>> +	struct nfs4_ol_stateid *stp;
>>>> +	struct nfs4_stid *stid;
>>>>    
>>>>    	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
>>>>    		return status;
>>>> @@ -7724,6 +7776,16 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>    
>>>>    	trace_nfsd_deleg_return(stateid);
>>>>    	destroy_delegation(dp);
>>>> +
>>>> +	if (dp->dl_stateid.si_generation && dp->dl_stateid.si_opaque.so_id) {
>>>> +		if (!nfsd4_lookup_stateid(cstate, &dp->dl_stateid,
>>>> +				SC_TYPE_OPEN, 0, &stid, nn)) {
>>>> +			stp = openlockstateid(stid);
>>>> +			nfs4_downgrade_wronly_file_access(stp);
>>>> +			nfs4_put_stid(stid);
>>>> +		}
>>>> +	}
>>>> +
>>>>    	smp_mb__after_atomic();
>>>>    	wake_up_var(d_inode(cstate->current_fh.fh_dentry));
>>>>    put_stateid:
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index 74d2d7b42676..3f2f1b92db66 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -207,6 +207,8 @@ struct nfs4_delegation {
>>>>    
>>>>    	/* for CB_GETATTR */
>>>>    	struct nfs4_cb_fattr    dl_cb_fattr;
>>>> +
>>>> +	stateid_t		dl_stateid;  /* open stateid */
>>>>    };
>>>>    
>>>>    static inline bool deleg_is_read(u32 dl_type)

