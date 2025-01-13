Return-Path: <linux-nfs+bounces-9175-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD67EA0BEA1
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 18:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AC61889C2D
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6AD20AF6D;
	Mon, 13 Jan 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Adgwzcfm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xbq0JPL8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB520F062
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788330; cv=fail; b=MZGzznGG8AijgS5YkVQWEmosDI8Jxwkub5euWKne91acIivvzlEI7HAnHcmmsYnJL1eM6PtE2Gw8NnIUzHy2RlM/r2uWupeBneApX6NnEtBTSrnQ011A/IlKBjxIhihm2JzFPEaFaYaJfvocKUTmwLJDsrgovuKIcGocA6qVOeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788330; c=relaxed/simple;
	bh=Djo0/5sLcxJJrvFO5bCEcaLuW86T02ygf5qj4m/oZt4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pL9YbA2BWPaFb92pWbFUVLOj5qPytVhsiNZHZ/ICvcxeDxyHQHU5m3JYuVfctJIY8mlbXapvkYO+pFhnzw06l9TzTtZSSmIhzq/0Er294vl3DOdOAiKWXF2wmR5ThlIEeYEJBWPmS2+o0EGxvkQAvyH4RfVoex5fvkY3pgTCO1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Adgwzcfm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xbq0JPL8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DHBdC4031676;
	Mon, 13 Jan 2025 17:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2YLmB599z1ZEwa08Kr5YzrjQLDRFcaJrQOputLRRuI4=; b=
	AdgwzcfmriPB/JuLKsMyEyneUluKCuF7nOPH58RMGb7BO9lorELe+/giUrQ+zSZT
	mFa7qUpHucryQ/x3kIkpSEFq0gFP3jsdGWLaqMPxahE90iGN5mJJv8JXaBmVFOLE
	M0ruiQnGptAfT5cHx3nDGRtVXa9Xe30E7N17OBJtFJYFzDyBFn0b9uTVzJGlEVEp
	ff8bM6/KBUMdgUrYt/MAjf1tYj8TVjlnhoFha90bIdiicxHvrVMh2I+g0S+tUTiT
	FX17CLv1AwLW4lqc3YN6228svlV43Cc8gggUGhpnqBqh3py1udM4+7yCxJmpzy7P
	/NK4D5lXd1DJFutHkyi0lg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fjam377-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 17:11:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DGXgmr020364;
	Mon, 13 Jan 2025 17:11:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3dgq4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 17:11:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpaoNjqO/HuFcAjGUMemrjA2+AinY9GZayaPbyNkJDoJhPp8CyPSAqW3HeSVwJ4gz/3vwHvWMdHy4LbUIpoC3lE44I05cNrCEieEajYzLP12wlisCUX1n/KXTWYPLMtoLOjN0Upmlef6k710kToguAx1yTScoAP22U91Dkue9ztn0pH+YUKmgcR58eBTuWSbpG9C1S07Q+6HKWE/1o4xDFVUncuCaaf4fe5IHQv5s4tKMtPXz484HaRdTGg3I5krCh7h9cFpORtilIoPxqSdnTQJdWQPo/4sKx4DgDUrHvpJNnbJbRg0TjgutqQcajc/2fa4iCOJ1k0fMOva2SeUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YLmB599z1ZEwa08Kr5YzrjQLDRFcaJrQOputLRRuI4=;
 b=k2fanGlw56ENX67cAMtXwP07JDFEe/XkEdK3IoGoPZgFKZ18FB5BdV1+6WNXDKSKpIyJkp2RV4kWuNf9uUPeh+GunBE6nQPtrLb8zqKcQOlUt4uMX/j7ziubia7SHobTh2BbENCTSg7+Khx6Pwj1RWPvpKz55uv9u/op/SV6IKYOGwH2DguZppwJYWKQYyLlfc5xd/g4Id4HBtSN+79cNGBkRHWOcLwXisvt2jg2eeKSG4JjvJKzbraAQPER9wYjNgYfG6Pv9HqZI7iHMR3kGmSlyDj7BdsMwtV+WGK6PZKmfuKXFvqS/E4x/cZ2tXAwNqilgCciknzdPyBMS+vkuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YLmB599z1ZEwa08Kr5YzrjQLDRFcaJrQOputLRRuI4=;
 b=xbq0JPL8k65PxKKIkqgKr1t6q3ActSayWhAm8GALsQf/DpMHugpNGXcbIfHtZRUr+90myeKYSW7D/zrDjHi+Pw9TNikyX6aQKhm9KmNlmDHGQUcwKArhHA1vencFNDBTesPSx15wehHOjZhYNqLMpVYG/2GBAZ/Ud/sj6yfyhs0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4937.namprd10.prod.outlook.com (2603:10b6:610:c5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 17:11:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Mon, 13 Jan 2025
 17:11:51 +0000
Message-ID: <e13ff082-0cce-4768-bb6a-ddc38bc8211c@oracle.com>
Date: Mon, 13 Jan 2025 12:11:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
To: Benjamin Coddington <bcodding@redhat.com>, cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>
References: <20250113153235.48706-9-cel@kernel.org>
 <20250113153235.48706-15-cel@kernel.org>
 <9D804462-55EC-4D75-A5A8-28C43AA86AAB@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9D804462-55EC-4D75-A5A8-28C43AA86AAB@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:610:b0::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a9be41-62ca-4cef-efb9-08dd33f55f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVdHeXRDcktERHhqNnJ6OUYwbHA4T2lZd2lSOXJMZ0JFU2lmOVNNK0wwcW1M?=
 =?utf-8?B?ZWlZZ0ZVWWVGWGVCTk55dDhOTjZvU0JLVXZVK3g1aFd6bmRZNzZpUXBPWkRs?=
 =?utf-8?B?N2ZRemNkekcyVHdickZQQTIrNW91OGx1YXI3Nk9jT2hwWERwL2JGZjZRN1p0?=
 =?utf-8?B?bjFhV1B3Q2poRjZ3V3NIK2dCVjNmSnMxK2laT3ltclltUWN6OXdnQ0JzK1V5?=
 =?utf-8?B?ZllhUXVRWjAzdHNhQnhoYUpDSXhYRTN0VVRPSTIzVC9uWWdHb1FRcnIyUDJD?=
 =?utf-8?B?LzlXV1lacWlPaGx0ZFQ5YVpWem94SXNocWg2OWFRMGc0QjhOZmM3ZU9MSGg1?=
 =?utf-8?B?UzUrb1hPNTVqZVgxaVRUYVZ1cjJSOW53cWxvMGJJMVNKVks4SG1HQTRFZy9F?=
 =?utf-8?B?elFKdm4wRmg2cnYyaWtMMkZJWm9acGxiTFEyUEVLYnlPaTMwR2dNRlNlVmhR?=
 =?utf-8?B?eFUzcXFDUGZnK1JmMDIxMC80VWlnYmZNY0NGT2tCTmF3cUxZQnNwVFUvaEVG?=
 =?utf-8?B?TkJtQkpzeFNLSUdkbG1SUkY4cUtmNW8vZUNLMEdMYzNoYXJhdWw2WE5WbEgv?=
 =?utf-8?B?ZUlzRUg0RFNsVE1TMDc2dndvYTJabnZEUkV2NlMvakh0Z0pKS0tKT2JWdHFG?=
 =?utf-8?B?djJNdUZsclh5b2IrRkxjOVRvSmlDd3lhZU14ZU00bi9tQURMZlVLUWx6Rkdq?=
 =?utf-8?B?QVVLd0tUYkV2NEtTU2gwNEErT0NORzNXQWlmRWNQU1B0YWNXZ0FZZCtBSWtH?=
 =?utf-8?B?STk4VVliWlhSclVJdmZ2ZUNraDI5TGhFNzlrb2R6TThCNmUwRVJUMmNvbi9m?=
 =?utf-8?B?SW4rMWNQVzVaZ3VtK3ZPODhCb2tvcXZRTUV2b0Frc3NrKzFNTEtYZGpnU1dq?=
 =?utf-8?B?TlpwL1JrNDc2MHdoRy8vOFBEU0FCZVVWT1NuaVplL2RIOFd2OGlaUTgzeEZ3?=
 =?utf-8?B?VHRYNDRaYlJEbEw0RHUwcGR5bG5KUUY3eFE3N01WTHNycHlETWF5T0JaL3J4?=
 =?utf-8?B?VFhlcEV3SUdFV003NXpjcEpGUzk0TXRQa0hZUE5Ba0VCMGNnTzN5L3RHWTdV?=
 =?utf-8?B?OXczdlozNDl4U3puTVJzbW1kOXBVWUlSWWo2MkxhT2tXUis4Sm8yQjFGY2l2?=
 =?utf-8?B?czV2dWpGMGF3QnZVWlhDenh5WjluM1VudHRqSXh5WTFVQml0ZmFKclBHMkx5?=
 =?utf-8?B?azBsMFNSR1gyRzlWZUVEMitnbnEwUlU0SG9MT0RzV3dPdkRjbDNrOGY2Vjc2?=
 =?utf-8?B?WUUzZFdONWRtWDNMaXdidUdtRXZrSEJRTGwzaTR0cUIxS2laaXJhbVhTbnpt?=
 =?utf-8?B?blJoRlpKYjlUM2sraDBXay9SRkRBR1dXYmhOZnRiQW9xY2xNeEJvd0tBY2d5?=
 =?utf-8?B?QjlPQVozY2VLdFp5Lyt5cEVFZnFNbmF4dzgrTHp0U3hPb0h5Q0RPNFN1RmNC?=
 =?utf-8?B?ZTVIYml1cW5IYlVOZW4wNUl1cGI2ekVUSWQzOGZ0ZWg4M3lJQ1ROclIzdkV5?=
 =?utf-8?B?cXhpcjlIS1JlcnV6cWhTUC9zaGh3S2ZkWDZoUllpVzlVT1gxYnRZWnRyZTRr?=
 =?utf-8?B?RThua1A2eldpTkx0alhpYnpzMHhWVzlZUFhmakZta1ZTZ3ovVUNvSk00Wksz?=
 =?utf-8?B?emd3aHJsOWhhVVpTa00wWFpQS2s0RUNVTTk3SmxQTmdZdHczSlByeTNEYXI3?=
 =?utf-8?B?NXkwRVhTYTdNVGRxaTF4MldhZ2UzQmk1RUhKa0pQa3JXNnhjcWVnL3NJL0JL?=
 =?utf-8?B?QW9mUXJrYU04R1dRdHBmcDNlMGhtMjJwT2pGaXJ0bG5iOVpTSnJ2UzJWc3Bu?=
 =?utf-8?B?aVppNkRqSWlGS3lYcUZMZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmlvZnVDNUEwN21OQW5HbHBKbUNKbEFaWEpmM1YraWlWM3RZSk1zQWp1VDA4?=
 =?utf-8?B?R2lBZVJla0VlNkVCUVJ6UXJFT2NhRDhzSjc1dUtIM1I2U24wT1Qvb2RucWJj?=
 =?utf-8?B?eVRWZFdKWDh2aWhsOU9oLzg4T0toSE9kRlhFYmhwR3ZHdFZ6MDE4aFNrWDJR?=
 =?utf-8?B?dDRqWGFNY29TTmo3R0x0UmI5WHhIMkVVYmU4RlY2Yy95SEExb2xrRXQySkdv?=
 =?utf-8?B?YlcxdUU1cVNkTytWclZDSThnU1lhVWhyYmJPejJBTDFDNjE0VkxHT3ZmTmJk?=
 =?utf-8?B?T1hDbkdoVHgwQTV6WVhrY1Bjbzl5MHhXVmswL2xpd3FvYUp1Z3JWRGFRRU0z?=
 =?utf-8?B?bmZvaUFCcGNvbWhOUE91UTlvUXdPZ3RHek91THg5RWN5SFM4Z2ZRVExuT1ZW?=
 =?utf-8?B?WDIvc1pmQUIzTmJ6NUpkdThRNnRNakxodzVuaDJFMTBOMnJ1SlZnalh4U3JJ?=
 =?utf-8?B?Q3VKdGthSVlLM2JMRXQxRmFGWDgyd3llWFZKdXVRZXRRcjgwOHZtUmtuQjh3?=
 =?utf-8?B?Nkp2amVydXN1bW1NR2hJVFFvbnVkTWI2ZzNPSkdJUlZlVnl5Nm1ROVVpWHVr?=
 =?utf-8?B?U0piZ092MHZTVWhyTFNWYktIbEF0bFR5VWFWZlRtRWF5WXRRU2gyaUwrT1hV?=
 =?utf-8?B?TkVzY3Bya2I2Q1NkUXdiRmwrcVE2QmY1VjUxcDlFQmlSYU5ndFNoZ2NId2J2?=
 =?utf-8?B?eFRjaEpLU2NXczFOWHJGODI3ZFN6SVdXdmFYNWZtQ1dCUkVqTzVhVHhmRU9N?=
 =?utf-8?B?akpyUDNKL21NY0s4ZjR1SE5YaUtFNEFOcDFoYmpMcDdwbE1QTm5QSk00MFJQ?=
 =?utf-8?B?QXlGK3dGRnpWcERqckVsQlRnejFpck9RMXdMenVSOGlEZENNa0ZMR3lZVGpx?=
 =?utf-8?B?bzZPdVlSTVZNRGlnNUNXMGpXblBudEVOR0hUVGdTdjZpMEZMMm5pY2hHektI?=
 =?utf-8?B?Tk81UGVhS2pnaXljZDV1TmE0UG0zVUlYUmlUMmpxUEtjYmtpN3BIbnJURFVI?=
 =?utf-8?B?MU02TjV4M25YaERRY1pkckJTcUwyVCtrdm00NWxiR0NibjlsODV4Y25Ed2N0?=
 =?utf-8?B?d1ZubVV5Mm1BaStNTWllK29jUGdqQ3d1Qm9zVUhaNzV4bGRnQ2h5NWFPZzVa?=
 =?utf-8?B?emEyYXVmeEpjZ0VwRElXdFNSejJvd1NvNkNWdjJOMnBWajlvaVIrZ21MMXlu?=
 =?utf-8?B?am01eEVIbmhJK0ZYd1RXL1o0c1FkSDdORzQ0bGJWN0lvbmxtTDhpV2t1enR4?=
 =?utf-8?B?N3VlRHVpR2N6TExDUkdWdlVKQnUySVlCME1BOGsvZUJNWG14NTNBc05kdWxY?=
 =?utf-8?B?cmIrbnA1cUo2aDJscmNGRzBKTmdlTWlVRU1MY1FZRGFqeVE4d05UcjdDWFhn?=
 =?utf-8?B?ZHM4WFczSkMwWW5pUjVSSFMxaFJYTi9xUlBjMWRpTDdDYjhzeVFqNkJNa3VI?=
 =?utf-8?B?MWZDQnNQejB4QTlFQTV5WHVOV1daSHFobEdBWDIzV0M0dFZKaC9ka3R2b0FF?=
 =?utf-8?B?bGQ1a053clpXZXBEbzB1MmUrM096TFF6OXMzeCs1cWlnYTRPVC9yRXVHblMr?=
 =?utf-8?B?c1dlQ0NWdEZ6K1pySTlnUHpBZUF4NldCd3d4RWRPSlhHQTFCTVdVSm1ra0Rm?=
 =?utf-8?B?OGZlT2ZIUkNoZmpPZ3FqRVF2TGVRa1dBaWdkSnV5Qm81MW5nZSt0eDdsNmYx?=
 =?utf-8?B?VzBRKy9UZ0tYckNmVUppZVhiWTBQeEtaSjRSbCs4dTVLcjVjMWdKemRhNmtI?=
 =?utf-8?B?RTREbDh2VzFXcXhCRFdwWkN1dUNKWVZiTVBlR0NZSjc1bytwWHZoTC9WOWRX?=
 =?utf-8?B?Qjlsa0FadHhGLzl1VW01SFIzZ2tRcVNVZzJ4RDBTcFZ3ZXpNM3lLanRmVTMv?=
 =?utf-8?B?cWVhc1ZLc2I2cEYwWHk2emhBdVh5L0c1Rm9JOTFCWE8ybVlmV1pxWGV2bmVY?=
 =?utf-8?B?Wjdyd2M5OWpZdWxrTVpTc21HZGxPYWUwc0s4dURzNTNacGRxQUd4azNQTkF3?=
 =?utf-8?B?MkpON29pbUVSTi9HaEZpTjQrSURCdW9lRk9uZWh2Sm9kVlA1b2NqVW9wbGpM?=
 =?utf-8?B?ZGRidVZiWnhrbmd4RkZkc0ZGUzEvVFlzMUltc0cyaU1PUk1vanBsOEwxTHEv?=
 =?utf-8?B?Z0tlR0xSN0IySkNpRFlLMTZackJ1TUIwMjlJcTVPMDlJVDcreUFydzBkcDdK?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YunauwGmtJKgNc+5GsTeQvkLEHm/Yhc7ReTDdPzg/w1pKBbxlY1bh/k/cq99pysZMI6wMWVrMHRxRZx5wXrOmzFPRJsjeJJAKcS/rKl4XThTvjVl+OQ5+TJE3DNcart7yr7KE+QlT3hAaiuvD6/Mc7eLe0tsLQ1d5yBd7HofC/mzvX36Dy0q0x84mrL/6BgIIJHtZV7PPGwboRG/0XkQOQgIKt+1r54UYlTelSD86MGvJTIwlVuTvSlmeu2OsuY2nEJYhCdYxucM0NR8TYbYlVo/uykuzOsQdrBAF2PbPUHn1UprUZmoFMHKnNgeOXprplHqyghb4/9moagOxk0yR3pW/6FaEZ+AS3UpS8gnQbP7MQPJAg7+UUIcYQJgtGFYoHf5Db+Tp/2by2A+9aVh8xZ4q0IWCW/nnd/MRN+YOqbcIaAtfAue7pRBs2Cc9KQ8TykOQQZkoO82Bw1iJLVjLv2wja0x6WF05wR//eIikGncG3FUSbE+7jS2bLd9xH2cXbQHjcMtc+SQ5U/PKW4PfPU74sRmQ5sqe6zE7lAJMZ23vGs0FSFsTX691w29UkeW+otHbiK1t1EiqJmldzHSvFM5i5T7Rej62a59yDLPv+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a9be41-62ca-4cef-efb9-08dd33f55f71
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 17:11:51.8864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1Ehlj98AisfIqN5VmtJ4HrZgp0JEr/c+ofW6k/p0IAfytL50EiM+b1CwVUZ1s5C7MS4zYHsVwmqW0NHDJYbOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_06,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501130139
X-Proofpoint-GUID: k24c06_KK025h_XnrdhEq99C_dSaMcI2
X-Proofpoint-ORIG-GUID: k24c06_KK025h_XnrdhEq99C_dSaMcI2

On 1/13/25 11:51 AM, Benjamin Coddington wrote:
> On 13 Jan 2025, at 10:32, cel@kernel.org wrote:
> 
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> We've found that there are cases where a transport disconnection
>> results in the loss of callback RPCs. NFS servers typically do not
>> retransmit callback operations after a disconnect.
>>
>> This can be a problem for the Linux NFS client's current
>> implementation of asynchronous COPY, which waits indefinitely for a
>> CB_OFFLOAD callback. If a transport disconnect occurs while an async
>> COPY is running, there's a good chance the client will never get the
>> completing CB_OFFLOAD.
>>
>> Fix this by implementing the OFFLOAD_STATUS operation so that the
>> Linux NFS client can probe the NFS server if it doesn't see a
>> CB_OFFLOAD in a reasonable amount of time.
>>
>> This patch implements a simplistic check. As future work, the client
>> might also be able to detect whether there is no forward progress on
>> the request asynchronous COPY operation, and CANCEL it.
>>
>> Suggested-by: Olga Kornievskaia <kolga@netapp.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218735
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   fs/nfs/nfs42proc.c | 70 ++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 59 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>> index 23508669d051..4baa66cd966a 100644
>> --- a/fs/nfs/nfs42proc.c
>> +++ b/fs/nfs/nfs42proc.c
>> @@ -175,6 +175,20 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
>>   	return err;
>>   }
>>
>> +static void nfs4_copy_dequeue_callback(struct nfs_server *dst_server,
>> +				       struct nfs_server *src_server,
>> +				       struct nfs4_copy_state *copy)
>> +{
>> +	spin_lock(&dst_server->nfs_client->cl_lock);
>> +	list_del_init(&copy->copies);
>> +	spin_unlock(&dst_server->nfs_client->cl_lock);
>> +	if (dst_server != src_server) {
>> +		spin_lock(&src_server->nfs_client->cl_lock);
>> +		list_del_init(&copy->src_copies);
>> +		spin_unlock(&src_server->nfs_client->cl_lock);
>> +	}
>> +}
>> +
>>   static int handle_async_copy(struct nfs42_copy_res *res,
>>   			     struct nfs_server *dst_server,
>>   			     struct nfs_server *src_server,
>> @@ -184,9 +198,12 @@ static int handle_async_copy(struct nfs42_copy_res *res,
>>   			     bool *restart)
>>   {
>>   	struct nfs4_copy_state *copy, *tmp_copy = NULL, *iter;
>> -	int status = NFS4_OK;
>>   	struct nfs_open_context *dst_ctx = nfs_file_open_context(dst);
>>   	struct nfs_open_context *src_ctx = nfs_file_open_context(src);
>> +	struct nfs_client *clp = dst_server->nfs_client;
>> +	unsigned long timeout = 3 * HZ;
>> +	int status = NFS4_OK;
>> +	u64 copied;
>>
>>   	copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_KERNEL);
>>   	if (!copy)
>> @@ -224,15 +241,12 @@ static int handle_async_copy(struct nfs42_copy_res *res,
>>   		spin_unlock(&src_server->nfs_client->cl_lock);
>>   	}
>>
>> -	status = wait_for_completion_interruptible(&copy->completion);
>> -	spin_lock(&dst_server->nfs_client->cl_lock);
>> -	list_del_init(&copy->copies);
>> -	spin_unlock(&dst_server->nfs_client->cl_lock);
>> -	if (dst_server != src_server) {
>> -		spin_lock(&src_server->nfs_client->cl_lock);
>> -		list_del_init(&copy->src_copies);
>> -		spin_unlock(&src_server->nfs_client->cl_lock);
>> -	}
>> +wait:
>> +	status = wait_for_completion_interruptible_timeout(&copy->completion,
>> +							   timeout);
>> +	if (!status)
>> +		goto timeout;
>> +	nfs4_copy_dequeue_callback(dst_server, src_server, copy);
>>   	if (status == -ERESTARTSYS) {
>>   		goto out_cancel;
>>   	} else if (copy->flags || copy->error == NFS4ERR_PARTNER_NO_AUTH) {
>> @@ -242,6 +256,7 @@ static int handle_async_copy(struct nfs42_copy_res *res,
>>   	}
>>   out:
>>   	res->write_res.count = copy->count;
>> +	/* Copy out the updated write verifier provided by CB_OFFLOAD. */
>>   	memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
>>   	status = -copy->error;
>>
>> @@ -253,6 +268,39 @@ static int handle_async_copy(struct nfs42_copy_res *res,
>>   	if (!nfs42_files_from_same_server(src, dst))
>>   		nfs42_do_offload_cancel_async(src, src_stateid);
>>   	goto out_free;
>> +timeout:
>> +	timeout <<= 1;
>> +	if (timeout > (clp->cl_lease_time >> 1))
>> +		timeout = clp->cl_lease_time >> 1;
>> +	status = nfs42_proc_offload_status(dst, &copy->stateid, &copied);
>> +	if (status == -EINPROGRESS)
>> +		goto wait;
>> +	nfs4_copy_dequeue_callback(dst_server, src_server, copy);
>> +	switch (status) {
>> +	case 0:
>> +		/* The server recognized the copy stateid, so it hasn't
>> +		 * rebooted. Don't overwrite the verifier returned in the
>> +		 * COPY result. */
>> +		res->write_res.count = copied;
>> +		goto out_free;
>> +	case -EREMOTEIO:
>> +		/* COPY operation failed on the server. */
>> +		status = -EOPNOTSUPP;
>> +		res->write_res.count = copied;
> 
> I think "copied" can be the original uninitialized stack var in this path,
> is that a problem?

I think you mean in the rare case when the /server/ returns REMOTEIO?

I changed nfs42_proc_offload_status() so that it now always initializes
@copied.

Thanks for your review!


> Ben
> 
>> +		goto out_free;
>> +	case -EBADF:
>> +		/* Server did not recognize the copy stateid. It has
>> +		 * probably restarted and lost the plot. */
>> +		res->write_res.count = 0;
>> +		status = -EOPNOTSUPP;
>> +		break;
>> +	case -EOPNOTSUPP:
>> +		/* RFC 7862 REQUIREs server to support OFFLOAD_STATUS when
>> +		 * it has signed up for an async COPY, so server is not
>> +		 * spec-compliant. */
>> +		res->write_res.count = 0;
>> +	}
>> +	goto out_free;
>>   }
>>
>>   static int process_copy_commit(struct file *dst, loff_t pos_dst,
>> @@ -643,7 +691,7 @@ _nfs42_proc_offload_status(struct nfs_server *server, struct file *file,
>>    * Other negative errnos indicate the client could not complete the
>>    * request.
>>    */
>> -static int __maybe_unused
>> +static int
>>   nfs42_proc_offload_status(struct file *dst, nfs4_stateid *stateid, u64 *copied)
>>   {
>>   	struct inode *inode = file_inode(dst);
>> -- 
>> 2.47.0
> 


-- 
Chuck Lever

