Return-Path: <linux-nfs+bounces-15037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F147BC2956
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 22:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A171888C6A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 20:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD9F1E32A3;
	Tue,  7 Oct 2025 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jZHq0hk3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nkAGlL+l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583241A8401
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867527; cv=fail; b=iAyJlsKvPla5OQbUhOGOTr/iMZk1HHPCV7JO9VnD5cKesdViWXmoRT2PkH7ms8o3dpciRZX0OwpsmMy4soFXs6j9dsyfi1kX8FQS0UK0BNQ6L39iAhyjS90zXW5fPnviU0d5VMxkdvmYtcoM9/dLbRXLJ2ImWW+6A3FHlwPOf88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867527; c=relaxed/simple;
	bh=bHE5j1nbwFvjA6eguzOfoiwo3inVxs+7B50QB2RSFzU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BjXOkMZfPr8dFLM9CZhUzd5gAWeS0DQ/Yj3STn0KWfJgvpFZ1xHsFpwIkN9ZU5GEGAPTxObQjtuioajJwoGVR7Zw1trzeRYbO9QhvkAw5WYMqwQCDHDIOWRtv7xbuwOmL0RUCv1AtZqMAjzSc5rwidB5n1GWFWngDocQb+xuYGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jZHq0hk3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nkAGlL+l; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597IJqfR031416;
	Tue, 7 Oct 2025 20:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IwaUzvW7ygO8QhhAx4V8Vj8XPArVB/sDbxGFilsqOO0=; b=
	jZHq0hk3aiIneyV+z4t5neOvCvt9ANvdap0CJHNImiF+I8ebpzaYPvYe5XtepaTf
	44PV0MnoXoCoXC932YmD63Zj4icLj7Sv/C4D67Nh3lN7+vZ4NA9r82ORQgKLlGOj
	O5NJez/qFbclEsAfW034kjMwD9IRjls0vqJvYa5NsCkc9WbqVFDREhc+IbqbOoaR
	DqvDoaaKIWnwDuj8IgfPt9SLBVOYAbaPTIPhCXzTp8LG6UjTf3sYD8DLgH2V3a/K
	UbppacyovGmT9HfZH9q5jEqSDfpEIFGbXQDNhOBiKHlf9+ZHeb05Z9SWyf8SiTtr
	H3MjOejRnPhZc4YUo78YRw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49n81r0848-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 20:05:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 597INYQ8035762;
	Tue, 7 Oct 2025 20:05:15 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49kdp5bnve-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 20:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beC6OofutPWlL1zm+iPjQNnGJS7rQgxtYOfKT0wFSfvLE3+Zk6OmDQ0sO2XnRH6W8VyUzOk9Yv/MMw7lSchRo8wv1pQu9EZ+2bElot93BMyLj12DpcZZyDvd0HVTpEyoaPKudgRTe99qRgBhhFix2XCRcObKCuoIeiWnaXrUyTZkspzIqPMSPT5MUN7JeiiFpD3LbvDyqkM1MPeClu7zYJf4+7N0v+CWOwi2YfrfmTl/tiUnNdu+PU3tKTZY0svWmDFXWCEbuQgcfdG/L9eSBmUh3Qh3aldSBNEPJ4Fp1ss2xKflJN4yOzIsW6VwEc+sT7HTWf+90Puzlx6DfXemLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwaUzvW7ygO8QhhAx4V8Vj8XPArVB/sDbxGFilsqOO0=;
 b=Oc6DWpZaE2EYwpG8ReXvuF8Jm3f7vcVcGEpYonTeGdgNgs6v8t3BtNM8EzvyN6W3rx7pj9aS4aXJd88uiDFbwJAvPQ887GH5BvfjbvuJwrbZBdzJc5nJZx6ts7k1OvY6uoqBaExOYb1SiWC2wecHvpJjC2NWHgLa1uzWGcR1vEKe/HOHKr0KPHmkIagJD1BIfO4DSmBPXKOuhhdeYKnNgJXFO+2hlnrCWb8SVZCtqyW/Tst8AQ8b9XAMGPBLdPhkinxa7Lt1LuVCwM2p+dmtajParc1xgkqWiWbl4CrNkES7Zz5iI9CFUm8zzuWWCJrTlrV9mMIrUPl8DAX2BJP6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwaUzvW7ygO8QhhAx4V8Vj8XPArVB/sDbxGFilsqOO0=;
 b=nkAGlL+lOvyqX+PU0WHpN+AtxmZQ3OnfEcrGePgVxh/u9F5kC/beXt8B8vLLt1zIb5Gwc2V8V2NNIKMmQ7mewIw8To7WD9nlBGwnNDMZB2SySeLat/6IyLiyFqHidowxpFHCgrbDlCif6Qz1fMuKqt1TUrUMmWiWyJnAjrdfLrU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4915.namprd10.prod.outlook.com (2603:10b6:208:330::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 20:05:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 20:05:11 +0000
Message-ID: <98277504-3d4b-4aff-9810-1847e6bf4030@oracle.com>
Date: Tue, 7 Oct 2025 16:05:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] NFSD: Do not cache solo SEQUENCE operations
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
References: <20251007160413.4953-1-cel@kernel.org>
 <20251007160413.4953-4-cel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251007160413.4953-4-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:208:23e::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1e87ca-730d-44a3-2af8-08de05dcd232
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M29vNXpZTURnd213ajlpQ0JTeGRMVVhycTN2MDhWcUgzTk9hOTFJb0VDMFdX?=
 =?utf-8?B?SkRHL2t2RjY2cnJ3azdpSVFlV1dVRG1sLy81N1c3N241bFk3Z0U4UmppMHV1?=
 =?utf-8?B?WkM2QXg4ckwyMlE5d29KZENiRVNrcWNlVTZ1dVJRdlR2WGFZS01ORHZtQkdm?=
 =?utf-8?B?d1FKbTFPa1p5emtGbng0ZVNYTXJzaHZTWjBpd3hpclBMa2ZublBHTFdodk5u?=
 =?utf-8?B?WStENTJVMXpxQXV6OUVRbm1ia0MzbGwyWkRTNHR3c3pDaDIzdlN4UUlaV2k2?=
 =?utf-8?B?L3NNQk9jcmh2aXVXd2JYRldRV0wzaXZtNHVITkxSMzE2d2ZqaE1OdWJZRDdK?=
 =?utf-8?B?TURKL0pQZU1Ka2ZGOHhoeTFOWVFLS202NzNOR2pIVENDMDNWVUlaZit4T084?=
 =?utf-8?B?K2hWV0RZdjFkaExLMWdOS2V6QW5URklDNm9KTUJtcXYwaVF1NnNFSGtoSHQ4?=
 =?utf-8?B?UTdWeHNYcVlwcTRobzd3TE5WZVZrR3RXZ1VrWlE3UkdMMXNzTVdHM1l6QXJw?=
 =?utf-8?B?YjhZd2hKQTBreG5VUU1LOUdaTmdSSzZBdVZzeGJud05XZlpEbXdObTlPR296?=
 =?utf-8?B?d1pTQVdUWlNwdDdkZkxWdDhUT2lnaUxjb3FQS0J4MzVyejRFR3lsdkh1bnVy?=
 =?utf-8?B?WmFvOTN4cWdDUWpZVU5PL0hpVWMrWmhISk1YRW5KajQ1N3ZaNHNzNTNLZFV1?=
 =?utf-8?B?bU1GMWNtL2JOSnRtd0MwTlNRRFMyYXhSdWh4bG0zWXZqeUxzem1YTlphZzJE?=
 =?utf-8?B?eHRNY0VWRGEvdXAxVktNUk85cFVxc0tzczR5b3BEUjFlZHBYZlZhR2pFMFlY?=
 =?utf-8?B?TEE1bU91d1JKMWovT2NzV1lTZ1JGNm1vYTJ5bldmenhHb0FDVUNYQWtEVnJo?=
 =?utf-8?B?anllOU03TTQ3WHJnbzZzVjVoeWZiZHlHRFFxVHpZaFdmK2NEcld6dGpnMHZC?=
 =?utf-8?B?UGpGZUZZdSswcXlHZDlpeVY0NldCQXJXbGdGMExBYXhZUEhRR1pKK3FCWG11?=
 =?utf-8?B?b25EWnF1cWNEdktFM0wzeEVNOEc0b01IWGNNbk5sUlh1WDYvN01yOFFjRG1N?=
 =?utf-8?B?bHNlZnlvS3hhbWJFaWlWemljS0MzV0svTGIwNHlYT3diNmJGeEo4VEhWNzVN?=
 =?utf-8?B?eU5pbHRhSElKV1lYZGtrQ1pLUG9XREpMWjEwUHZjLytzdzZpNVE5SktTcjU5?=
 =?utf-8?B?NUhTTHV3TzUxbUJ6VHpza0FaL2VnaG9pRGhvTjFnQTh5bkF6LzR3cU5ad0RG?=
 =?utf-8?B?ODFDclNjK3djdDJWdTROVXdRTEU3aTg1bUp0MUpablNCUDlFMDQrak91L1hs?=
 =?utf-8?B?bnlDZUNYOTM2SDZ0M3U4OGxwb3NxK1oyQTdKUXJvOHVGZC9FcXduQTVGTW11?=
 =?utf-8?B?WHJvYzdUV3c5WjRBR0xHOGYwd2l4T005TEF3clErSjJvUUxLYTBRdWNUUm9j?=
 =?utf-8?B?cFhUemxydDdKWU5TditLT1Q2YzlLeWx4aXBibEpCNXAyaDBieldXWjJmRkV4?=
 =?utf-8?B?czNzVEdtQUdsU3QvZ0lEK2dzZmNZdkQyNkRLMFY0OTgzRzUxK1I4bFFuWGIv?=
 =?utf-8?B?YW1pK3B4QkNmQmthWmxlTVJ2MUVoNnFDYU1JcEZxd3RRV2FicFVSUHI2OW9X?=
 =?utf-8?B?VjlkeFVucE15eGFZZjdyUUloSEhmT0tPNUJqUDU0WmRjditjK2V4WW1GcXU0?=
 =?utf-8?B?aHR6N3VZcnFZVXZZUE1UY2p5alpNK3BzeThxdzB6MHBnaHVvUmMxY0VQbWp3?=
 =?utf-8?B?TWNLSVZDdC9uSmVhOVY1S1V1R2orRVhnQmxDd0FyWGNvVDhueG1KZWh3Rk5p?=
 =?utf-8?B?cnNENmxaYWdxYkNlTXMzZlNUQXlxeWJvVEpkaFhjVS9qamxTaHpJS1NkYWs2?=
 =?utf-8?B?Z2w3OGpGMThwZnZYTTRtUm9vamZPOHVLRnRLNzhGS29JU2NHVFI3MmFLNkZo?=
 =?utf-8?Q?FTsKHvsfFGxjl7gxuzZCwTlIxVHD+Rzn?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cnlEZlQvVHpOOWxmV0paUFZWYUJ5NDJsYTJFWVZzRUxMRmVhSXR2Ny9ubVZk?=
 =?utf-8?B?RjdOcS9sUGgxM053endtdlJwcG1MWkthM2s5NlVaTWh5b0VEeUkwVVRuS3B5?=
 =?utf-8?B?Z0ZpRDlKUGFmMWZGbUFhdDhzNjVVcG1UY1U4YkpBVnhJVjZNY0gyVVlPV0dL?=
 =?utf-8?B?eGVZZEFwUGdkdWg3ZmxTdDU3M1pZRzNNaE5pOVo5RVZsRDNzYjNTdFg5dFJs?=
 =?utf-8?B?Qzdtdk9OdXhxVThvNXIrblcwaU5uS1pKZXNtMmcycmNwVmNoM3BQeEFKc2Fo?=
 =?utf-8?B?TlJmWHpNU01iVDVFNEthOERDSHBGNUUzTSsweFdQRjl1citjeFp1bHR6ODJw?=
 =?utf-8?B?TTJkR1ptS0kvZUNNSk9oMXZVNnNUOHA2bWk3bldsUkd6ZG9iZzlXZXhHeFBH?=
 =?utf-8?B?ZklHTWlNNVAxcytZdGQwY25nTERwZEp1aTdpTHY2Yk9kVGIreHpiaFJvc2RQ?=
 =?utf-8?B?bmJlUngwWmZiNjVvSEI2UytHdE85Q1ArVno4eGowMjYvOGpFYjdVOTlyeDlh?=
 =?utf-8?B?MHkvaFEzRVdQYnhxS1VIK0FEWW5QZG1BODE5K2VOVjJkUUQ1WjFVdVE1VUVD?=
 =?utf-8?B?UHZmeFRSRnJHcSt3LzY2M0dOMk1lUGZwNTNFUXBsREtwUHZEU25FTHRHcytN?=
 =?utf-8?B?dWIrVDlzN0JCNHliajJPU2NDU0UwT2Q4ZjJtVjlwdCtqVkZaZ0dkdWFVbk1i?=
 =?utf-8?B?QlJMM2thTXpmWm5FNGFHdk5ybENZWWNraHQzSGZLNFhzVzhTUHZtaWV2V2oz?=
 =?utf-8?B?bnBBdmJESFdvTU9Jc1lpZmJWUWI1ODVCOG9OenFWemkrNkdVeVRPTjRZU3hn?=
 =?utf-8?B?cGxkRURBTjU3empOZE9MaldRTmVxckZmdmZMNkl0SGdDQkJmMyt2RFFTTU02?=
 =?utf-8?B?Rkxkd0RlQmNPaTNOTVVqNm1sb094blY1Y0VLV3lGbGRzMmpQT2I3TWhscms2?=
 =?utf-8?B?Si9xWkFWS1djdk92WHl2aERvbWVtSERmcDJPNEcxMTBqSHlSMnNtTHoxU2Fx?=
 =?utf-8?B?bUpERjNkTlRMczZEUU1GRHBIVllKV1o0b0JiaWdKM2locmxPRlZ2TUsxZ2lo?=
 =?utf-8?B?b3pvUm16d085Z2NURWxtRXBtbGNYQkhnR0FFbWgrV0g0VTZncFFZbHlKSGNQ?=
 =?utf-8?B?aFFBdEVZQU1WVHVhMTQ2Y0I3aHdWTnhiRXJuQWJESzJUeHoySEtNWWZSZGt1?=
 =?utf-8?B?bHlGTG9BWE1kaVRTSlVYYXlIMFlvZU8wcHBQZEU5eUFaUHNhNFRJUng1dzlQ?=
 =?utf-8?B?cWNOemwzOU1VY2ZzaUVsSDVLa21uVjg3SlJESG9TUXdIMFJvMk5TNnFTakxV?=
 =?utf-8?B?R2ZUUG9FR1hBRVNMNGRpTWhlTE1qOXB5VlNOZVRBM0Q4eDVFalhjeGtybXhM?=
 =?utf-8?B?QTV5WVlTKytNS2Q2SGxCN205WEtiRlNLMU9OTmVTdW5YbEVmdjFsa0gyWmZV?=
 =?utf-8?B?dWxENTFnOVd2RWEwRk1RanczWlh2QVpPa2pHakNFLzlCTzQ4cE1yeTNlb1U0?=
 =?utf-8?B?YWloMTB2ZWR0eTVwUjNwSXJoeWZlcEU1NmdvUVZONjJjZkMyYVAwanAzelpQ?=
 =?utf-8?B?Sk9idVE2TTJCT24wQXpvTjdYa3VBUDhsVWVjaVVYY1FDV09PZFM5bUVWRkVi?=
 =?utf-8?B?S3dYbWpTd09NYjZoZVJrNkNHUjBTVzV5VDlZc0FYVmRBZ1pZOVB2K043UmJM?=
 =?utf-8?B?dDk3ZUlFemxGb25keWJ6dXhhSDdLMitiaTFOaTlwR2xwZExNT0JLMDBPNFVS?=
 =?utf-8?B?TGZlWjJweEUwU3NaWHN2aHRwbFJNeU9qMTUzSDdQbUh5Yi9ISmt0aklSc1Z5?=
 =?utf-8?B?UTBRbHp4QXhFN2lVbHVZQ055L2ZrTmJRVmlwVm1Wck1yTUoydHgzSSttRk5M?=
 =?utf-8?B?d2paWUJkYzVxRzVaU0pRWFRJbUplMlVUK3JvYUhQZCtCRnZ4aTZoMVJmbVo4?=
 =?utf-8?B?VXZSYyt3ODRPSHloNUpBblJUTzJSZ25sa1VtbHR1NHRTUFFiRjltc3FIQlh2?=
 =?utf-8?B?ek1seGZmbnY0cDJoNGZvTUxwNzVMTUhTSFhjc1Y3WDR3Si9VUkhicjRDbFVy?=
 =?utf-8?B?QmVOV2Q2TU9nQnJUUUttYm5mK1F3STVHbk9ndERXQWZvcitQajFGZTY3VHdB?=
 =?utf-8?Q?SETCJg3dw3vDQxRBTnKTN1Z8f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mj//2PHABAvIp4gGP4lr7SXPJPvJMYr9JsTNjcy5bHcYS+VP/ejYXly5nwjQiskMS432sU7Q8eOxqqMiVokYmkEIyJmRbU+xGTgPl5tBQcIAiVZW7p4dK+DimeWm/QjUWzmF7sZT9m0V5InUMB+5qPMq/jBbuel/3srcz7/uURzfIFcANVbSBDt4+vwzKEhUwL2W9fJnVMSRoLuY1M3Dk8Rd14BKbEN4YXtPYgaeYi+DRA4P56let4O0QNM/iy6cRy5q2ImbQCirJb8a1C4/xZdIT9/e6Bhi3VRluOPNNNuWgKcn2HsBhhhbng549SEQB6SnujjGC7EAWBouoJwF+sADCx/aLik37+JcJ5t5ImAg+GEPyWa839EZxH7bC2N9fB6Hz8egwytB7sYa8l73tU0eR+XejooMi3Gw4eUYoH3pPl6qwU5VbCjGvV/17uE6VokaAAViMBySRSkE2x6mdWKnyzCIlzS/7fktyIC+ZNcryoBz9xE5oBIPvt9Yfw+nGIgcIB00/nGgmjYrfGuzj4MkLsrRCQ3yPp4lNWGgq4pb5N9WkvrwDOMeQrsAIp+Rjb+4WUG7TIWzRWIRUPFXC3UQN2GIAtp8o14wL/Rmu4Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1e87ca-730d-44a3-2af8-08de05dcd232
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 20:05:11.3476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oF5LNyiPC/Dvd0LudvZXVsCvMg+3d0CpX56D3T9u+VucOYB12iB56HGJAgy/FQxGoX7MAq0WHhYKyQftyYimUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510070157
X-Proofpoint-GUID: 5nN3CtDHh0a-3sTNrnBt3IW-AVTwOp6z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0NCBTYWx0ZWRfXwcCDR3WhAts/
 KOzBB24ELmESmScmHKFZoT4ViSbFogSJ8G5AwuxFPmdFj3AlH7q8zVrv261gaWWaRbqBvyFJHu9
 U2t4kRweoauz/4fqKrWorzer9kAiMUQfxzzaLDRr4s2cnvxCOlD4wxpvHqSog4fSuvJzOjzd5U/
 0lRm1JQVrGJWrvQpyCYsLpuE/Iw/rhwEWFbrqhlKpAJHG+zBHHJFuVTj7oQkZ+2SpiDG7kY2TTg
 FaKDS4OEZZhtSVyJzLRYObiMwiYafaSPGKFxGJxNfcf+es+8dc1GbhwQuUnat99RzhAyh/M3n5z
 08g+TjvJYpKfVyJHCK21pB9DmnIriZZ2k9Eu0aQ0ARy3bw4OSWZbLG1qYhElZQ+/BcajxxmZJbi
 q1yLgRvo21/HPg/x9JzZp+jfZxjSkLIXUMc8QgUKNoqaaTtj8rU=
X-Authority-Analysis: v=2.4 cv=dubWylg4 c=1 sm=1 tr=0 ts=68e5727c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=Zx08UACrDGvWNtcTG3AA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: 5nN3CtDHh0a-3sTNrnBt3IW-AVTwOp6z

On 10/7/25 12:04 PM, Chuck Lever wrote:
>  RFC 8881 Section 2.10.6.1.3 says:
> 
>> On a per-request basis, the requester can choose to direct the
>> replier to cache the reply to all operations after the first
>> operation (SEQUENCE or CB_SEQUENCE) via the sa_cachethis or
>> csa_cachethis fields of the arguments to SEQUENCE or CB_SEQUENCE.
> RFC 8881 Section 2.10.6.4 further says:
> 
>> If sa_cachethis or csa_cachethis is TRUE, then the replier MUST
>> cache a reply except if an error is returned by the SEQUENCE or
>> CB_SEQUENCE operation (see Section 2.10.6.1.2).
> This suggests to me that the spec authors do not expect an NFSv4.1
> server implementation to ever cache the result of a SEQUENCE
> operation (except perhaps as part of a successful multi-operation
> COMPOUND).
> 
> NFSD attempts to cache the result of solo SEQUENCE operations,
> however. This is because the protocol does not permit servers to
> respond to a SEQUENCE with NFS4ERR_RETRY_UNCACHED_REP. If the server
> always caches solo SEQUENCE operations, then it never has occasion
> to return that status code.
> 
> However, clients use solo SEQUENCE to query the current status of a
> session slot. A cached reply will return stale information to the
> client, and could result in an infinite loop.

The pynfs SEQ9f test is now failing with this change. This test:

- Sends a CREATE_SESSION
- Sends a solo SEQUENCE with sa_cachethis set
- Sends the same operation without changing the slot sequence number

The test expects the server's response to be NFS4_OK. NFSD now returns
NFS4ERR_SEQ_FALSE_RETRY instead.

It's possible the test is wrong, but how should it be fixed?

Is it compliant for an NFSv4.1 server to ignore sa_cachethis for a
COMPOUND containing a solo SEQUENCE?

When reporting a retransmitted solo SEQUENCE, what is the correct status
code?


-- 
Chuck Lever

