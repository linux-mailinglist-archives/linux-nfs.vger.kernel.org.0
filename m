Return-Path: <linux-nfs+bounces-13751-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D6B2B2C3
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 22:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747157AD526
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 20:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CC417A318;
	Mon, 18 Aug 2025 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o5aJzS8e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="anKliiU0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B4111A8
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550053; cv=fail; b=Smb6evMsKAjSLAc9Dsn2UISLMVmyWb9LmG2A0EefIIuoiy2H1feDY1MmEWntF7eUPT5m16Uzzc11Xq5bRWqneqa/Yoii8u8ZTs9j7xPxMb+xrV8XCXm139B6D+CX+3Xhi2ZNA62JsCZwfwc/rGmUV6g4fb4Ux5b25HRxylC6XLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550053; c=relaxed/simple;
	bh=/hh0i1POjfoxMwoM8G3VhZ2v2sr1+hw9neHVk8zsT/s=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GmyVVTLFIjbdKrOts10FSgG8mlk1jlXFTPtrU1zWV8mQxnDYLcdSqxfhsIq/GWBaCh2fwYFNWYNqEovDROUj1SUrlgoAIcTV1gQBNfNqHIB/oh5PH01Iad+lCX2ev5XzMVt/nmyrDPCSyv3pEJPUK4p/0M0mW9cM5XJc5ExjXyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o5aJzS8e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=anKliiU0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IJggXC012580;
	Mon, 18 Aug 2025 20:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7lEurmIeptcJmU7kXyLY1LjO07nqq7g7pU793b4jVNs=; b=
	o5aJzS8emSbhMCv7+ZSHRk3EVdVPIj4+erxM+Lpprl20wKLHuiidnLx5zfMIPKJR
	2bEItHskF6Elv6XAkixgz9d+ZNYIIYqefQmxHeJVMkBIZicJ39/9fvPGGQgM8GbB
	rC4pOCLS66ahE5J8Y8M+xNlyeTOBTHV5UrUOqoZQgEjcvAzVbe44NuVw+G1D2o1p
	gNN5vApEPF9lGLQzIl9tr20LdDl3VTQVbLWHvDiUxjMFB58BvqvAxR+JNAwOzu4i
	7H7u1MmZZ4QhkWEqn7rdgXdf0BFQNtPteeJ+LselEzEB6xekk706Zy3CB+Nscvw8
	6uyH6Tt0ac1bgkeW0SxO0Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jhkuuxjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 20:47:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57IJTq6V016908;
	Mon, 18 Aug 2025 20:47:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge9gxxh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 20:47:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkEGlmnMSWtm9iWHzDWKcn6iJlpUFwspMotjMspkusk4gt1sfsnnlfAfS8xRxhb6GMI+6wKam3gAYSBLcULxNE5eXOM4tnGNPlzfSgbPC87G4zQav1JsicwstTklhuG0Jxv41uFSxRg+UTHlBbl3L0UfACQI1DUZqp4nZPU5yplzstjbxbKQWBtgpDEEajFDAo93j51fXj2SaL4coBClgOrO0S7p/AyKNRDtjoOyeX8d5353l7V14Kp6uGjhqSXVh5/xKVGBH/r3VCLgXJvXHAOQTImrMGEL3P0Uggak1w+LkanbQchI92AzCjIuBDmnElOiqA9AzChvipM7GP4OnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lEurmIeptcJmU7kXyLY1LjO07nqq7g7pU793b4jVNs=;
 b=yhqbnfKMjHPbMMJP0Ud0Ik5S0DLt53rhHBScXqbpqL5VrxvYU1ScefvKHB/lDaRfztaotPbTChUHaZ2A0wM/JYcROsvvD2xYkOAyET/Ee4pFSDFlu1hQGk5+EOaCFky3a3stIZVVjhfQlGsytIna5L+b9Dy4mjgk8wjAV0c2D9EkN/9VVHtl4Y0EnAG5rbWUpJGn9hMA6nR9Q3AexaqWtDGjFCnXc6/gQbvoLHBDFyhksiiT1IzMggCMAjrctg5sw8/arxd3G+2Ol4qkTYpRU0SBNCPt70XeQx8Zq304B3wTpy7tghEqN3CN8XIs3hfwVBc30whfU6J1XjMt0t0Kvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lEurmIeptcJmU7kXyLY1LjO07nqq7g7pU793b4jVNs=;
 b=anKliiU0ShpN4vphSPmrFF9XDphiXGZ3/J1Klzs1NXg91pTuQFlctSxTG2oRFNqyuplG1BfHeMOnBD9N5WCjCu5Db+sSqWlvf9CLGhJwQMXQuSt5lm5iNC4RYxFb5+zbodBtQb4M1Rr3jr+1WJVtXciuiXC2LyrYKT9z3EiukBs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB8126.namprd10.prod.outlook.com (2603:10b6:8:1fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 20:47:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 20:47:17 +0000
Message-ID: <37b4ab16-6adc-48c3-984d-cfaf0bac259b@oracle.com>
Date: Mon, 18 Aug 2025 16:47:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when deleting a
 transport
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <okorniev@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, neil@brown.name,
        Dai.Ngo@oracle.com, tom@talpey.com
References: <20250818182557.11259-1-okorniev@redhat.com>
 <c4722c18-57a5-49b5-818b-1e46cb4733b8@oracle.com>
 <CAN-5tyHincZxuNL3z5QDZ8Sv1F=fqT1b-3nUt2DVvFhr0MePRw@mail.gmail.com>
 <CACSpFtB3WDtWL7sv3FEyBh7UYiYSwiQwDr42vDck_nVQB_Z2ww@mail.gmail.com>
 <ff15eec1-3827-4057-a116-1f1bbc9bc8fd@oracle.com>
Content-Language: en-US
In-Reply-To: <ff15eec1-3827-4057-a116-1f1bbc9bc8fd@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0013.namprd18.prod.outlook.com
 (2603:10b6:610:4f::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6d595b-e902-46a9-d319-08ddde986b42
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WkZ2c2NDbHVYV25rdmFaRHhTU0lDTklIUDVDL3R0czNOT1pKR3RZS1VuTlpy?=
 =?utf-8?B?ZnhMdHZTMmlmd2c3cWpqN2pxVG1XaU02aGpJcW4zZGJPUUNkYXMxemt6ZjQv?=
 =?utf-8?B?TWFzMWhJZUlVeVB4M2dMN2xMb0NZTSs0QzlseG5vRWJ2Ry9FZjkzVFEvV1o1?=
 =?utf-8?B?TWNwWFlVamMzdzlYVDh3U2lnT3VOTUo4SUVSK3pHbkR4c09qcnNRVEJZMXk1?=
 =?utf-8?B?ZW12SGRpTitwQlM5QStPSWlBR2pFODlqak4wTVFTV0J5MUJUOGdlU1liTGhS?=
 =?utf-8?B?QjF6c1hXRVdBQW9SclNBYVc2Q3VOV0VzeW1xb2tqZTVGVHpubEJVTW5uR1cy?=
 =?utf-8?B?SVFBQTIxd0VMVXJZTkY3MW00Z2I2Lyt2VlU0S3hnWjlFeWJ3UnhEdDV1WHp2?=
 =?utf-8?B?cGUyNStIandSYzR3UnNuM3FsVXlvaGcwVExjSTdaNkkwUlJrVk1IVkxHNHZn?=
 =?utf-8?B?STBpMzZYK0tXcU9XdzNqTjJlWGxUa1hOOTFmTkhKcFpUR3BjdDlpdS94YklG?=
 =?utf-8?B?ZU9iR1JSTm9HRHM2VFFLdGpNWE1sNmZhRTEyZlBlU0F1cUlIYVl4NVloK3Fu?=
 =?utf-8?B?NndUM1RqOGVjNmFyYjZJTWdZbnBhdzJSZ2hubGcyZVBMeWF0cVkyUHExODk0?=
 =?utf-8?B?Z3hxSkY3Q2Jqb0FCZjdsb1lKSmZYNkVjUWxQSW9scmpGaEVQY0ZYL081STJa?=
 =?utf-8?B?a2E3Y3ozWVNoK2RHb1JiUzVBeDZRV3VUZjNyVTB6ZE5CRUpoQ0hUc2Rwazgw?=
 =?utf-8?B?V0oxRXZXL3V1ZDFmV29PUzM2dmNIVldSQjJCSUhpS003a25JaFQ1TVhrYTBB?=
 =?utf-8?B?MHZIL1VWNm9yWTRnZ1IzcDZTNkkxdi9tMkdKdVBBdU5XWTRvQ1hQUk55bnhR?=
 =?utf-8?B?OEhtYU1vNGw3RWhOOSt4dFFIWEMweEJrdXRWeW45ZmYySG5ETlRmNWNPUTUr?=
 =?utf-8?B?QjdCSkF4b1BHODVCZmtvWnRuS2FWYmhnUTlsR2JYTkJHUFpXQ0JPZ1J2cS91?=
 =?utf-8?B?OEtMZERkMUVnUmtsZU9ENU9hNGhvUlZVYWlUVlgzSldYRzFFL2NkV1NhN1lq?=
 =?utf-8?B?ODFvOS90SVY0bE84K3g2WjdDYnoxbmlEZEs5NEJoMVF1SktYNFVmbmRqVkYw?=
 =?utf-8?B?dzNHdVJFbVl6Yjl6RG5xdExUcExjWExVZXlXZkw0UWd5RXBqYWpMUnY0YXUv?=
 =?utf-8?B?YjNSa3FtZnZzajQ2T0I5RkZobXJpUW5PYzZya3BVMVo3NTZPcmQzTzFhUVdr?=
 =?utf-8?B?OHI0MGlRcVZEdWRlSkVLRjZMN3JKNDRyM2FCclhQOEtRaXdyc2o0RytwVWhw?=
 =?utf-8?B?TEg1UXo4YlZabmY1NGZHVWUzRFZ4SFNqSFVLRndrVjlVQnZOTDVEa2dxUFZL?=
 =?utf-8?B?WDBtUEp0ekF4NkdmWFpjdThQU2hHOXhjM2VkUEFoeEhmd0pIbjJDaTUxR0Y1?=
 =?utf-8?B?aHJjS1Y5Qkp6ZjAweE12WGFQZjQyUkUxUzY3ZndMM1JwOFQ5cmJ6QjZ1c01o?=
 =?utf-8?B?Rm1jSlhpYXZReHNwYzVNMW9LSkNveDkyaWFSaTd0TGtZSHBXRmptUGdUWVZl?=
 =?utf-8?B?MDVqNzMyaTN6QUFldVlvTTlxWkZyRUtlY0VaMVJlNkhYRXhoY2xiNmJwRnRV?=
 =?utf-8?B?Qjc5UnUzN2taak55V3VPLzY3SkF0VTNnK3ByY0RaVkZlbVBncSs1SWRqaDR3?=
 =?utf-8?B?ZEJOS3lZMDdzYjJscmtmZ1pHajJmcGNKNnMvSHJZRWtRVUUyeG8vRDU3eFkv?=
 =?utf-8?B?UFlUaXJCVlJON09sVlVBVWZVekpYVzBtK2x4S3JiNmVDaENMNmFGMHV6TGNi?=
 =?utf-8?B?NmJuc0RSekJiSncyWjRuZHBoMTVQWWRQWmkxVlkvVUhBUnJPVlczTThOZjIy?=
 =?utf-8?B?UWtvVCtQSktINDAvRVU4MW50M2c2dzNDb0tDbTBPM0JJTU5odG5iUUdEZTFW?=
 =?utf-8?Q?5/dIRZ2b4Tw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K3hvekpxcHMyMjBibGpXVmdFRXMwK0tNVUxjNGVTRnpLMXRpY0U1L1ZucXY4?=
 =?utf-8?B?MWFsYzhEQTdyMWJ5U1RXaWRFZ1dRV2drOU85TEJLYXJNM2JwK3FCVDdPa3Vv?=
 =?utf-8?B?ZUU5V05MVGdWaE9kQnlncHJBL3gzSGp3Ukg3TGUrMmVodmJPVjc5K0pFbTJx?=
 =?utf-8?B?RHVDQ1ZMTGphY3F5U2huYVh5QmxBVjNFY050QkJBVzBxWDcvYzNyWDlUOXd0?=
 =?utf-8?B?OVpwSkEwY3JzbDNUalB6c2hMYkl0aUd6NjYzQ3k3ZkdrREFzM1BJeERPemk4?=
 =?utf-8?B?eEU4ZWxHNnRWemhCRHNpeDNobytCVXN3RXVWMkN3TTE0YlFtWEJpNE1ZSmd3?=
 =?utf-8?B?cWpMbUpidmVCcnMrVWdWV1NoODhiVVRTSUcvTnU3Zm5QTUo5ZXVidmNia0xx?=
 =?utf-8?B?RjlYZitsaDRHQVFmdmR3MUlUb1Jpb3pqSitOVlZwVUZyMlEzTzhOcXBvNWUz?=
 =?utf-8?B?d29nd3lPT2hFZzREY2I0NXZNVTdJL1ZiSlc1emNsSFh2SEhFNVFocm5DeHlY?=
 =?utf-8?B?QTFkKzVWVUp3ZHd1cXlYMGF3VEhoTlhWYjBLa0FRdVNZaFFTWnhvYXBYRk0y?=
 =?utf-8?B?UHN0SDhKeHhTYzA3WitPc3VROEVibm5sNHhSSk9CZ29vaUkxa0NlR3NNM1Rr?=
 =?utf-8?B?MGROZm14cExtcWIySmpJNDdIZVVLNllJai9Xakx2c2V0Y05wQ1FaOWhtU3Fw?=
 =?utf-8?B?Nnh0SmZFSHJEK05WSFgzaUdXemsyNk1Scmd3Y25USmZsY0F3bUxLdVpHZ3Mv?=
 =?utf-8?B?MTN2TWFKdWxoZUd0Q3hoa2NUZXFRM1pGNVUyZmZ1UDJ1N21DMS9SdWRCeWxp?=
 =?utf-8?B?aDJwMUdoVjlYSzMzVFkrZ2s5aVplT3RXTUVHckpNeGNLNGNHclNIK0tBREVj?=
 =?utf-8?B?Uk44UklISHgxLzNNTVkxWlFtRUYyQnIxeFBzRHZBWlhWYUpkeGgwZW9KaGd5?=
 =?utf-8?B?ZEFkZW9wZGVLcDFPNlF6M0kyenQyV0M2NW4vT1pqQVZ0RHZaVjJTNG9JbU8y?=
 =?utf-8?B?cC9wK21XZHpWT0Z1WGVrMzAzaU1JZW5CTnJqajZmZEt0QlpncWdnYzRWdk9l?=
 =?utf-8?B?MnFIdXF0Q0pJZW5QQ3VFbjE5cEhNMGdodkpKT0JPa3NkSmI1SGhXNnBtUm9S?=
 =?utf-8?B?NldGc3pUeGpvSllDbE9VajR3eG43SCtaM0JXN0tvL2FTSXNENTRCak10WHdx?=
 =?utf-8?B?dktCT2krWVk4N1EvdXNpS090VDNCaU0xSDh0aUk2UnloMGQrTndIM0dmaWlo?=
 =?utf-8?B?aWpKMWMyRmthK2hvSjY5emZEL3pHdnAxSUdZTm00Y0VvRHh1NlF0RUQ3MTBp?=
 =?utf-8?B?VlJ4R0dxaTQwczZPNmVuY2x6THpQclZreThvNjhvRGxDSTFDRU9haWtyVWRo?=
 =?utf-8?B?WkI5Rm1WTStINUtVbmdvRnJtRTNQR00vNGNoRmN6RkdvY085NDdrS29BdDAy?=
 =?utf-8?B?WUZWeU01WDNjL2FkV04rd1RCb2lEK0szaVA3TGI1RkIxSytqR3pkdytpNEJw?=
 =?utf-8?B?YnBvb3FQVXB1VEgrWTU1K3UwZ1RtTXlyYXNJaGVJUkZKTDFzV3ZGakFWalpO?=
 =?utf-8?B?Tng4alRIUisveHI5R2NidHZaS3RCeDZBajBKT2FXUTQySXU4TGhEUWdOaTg3?=
 =?utf-8?B?SGI0REgvd0RlcURSMUhaQVY2YXkxMS93VjY3ZmNFWWdTT25CLzlOKy9uMklK?=
 =?utf-8?B?dW42cExDYzQ2cDNRRnFsVHBlbXZyZ3NSeStmWTJETWlPYVJiNWRWN05GZ0JV?=
 =?utf-8?B?eTNoU3hPL2ZMWXpOWlRhbGJoN1hndzNmdW52c0Y5b1J6OWtiZVBGRlYrbDhp?=
 =?utf-8?B?eWErT3J5YVl3bGU2ZThnWDdaR3dVMVg3WUdkLzFrUlovNFlWeU1jWmJjU3Bz?=
 =?utf-8?B?ZFNFNmVXRVBrWDB5NldjbEtreUtiTzZyS3FzeVJaa0VCY2IvKyttcXl2dEo0?=
 =?utf-8?B?Vk5NcVp0bVV4Wm1TcFAxT2NQSVQzVnBETHBVcitjYXlMbnZmbmdxYVhRVllz?=
 =?utf-8?B?WHI3Y3BJWjBQT1Y2VTNiYm1tVzRLZStsZUVOTW1qM0hvdFN2bmM1MkpFRGd3?=
 =?utf-8?B?bFlRWTBIa3IwVUlsOVFtUlA4eGdOUnVueWo2MDg5OHYrVkdROTNoNTcrajhu?=
 =?utf-8?Q?1ezXUgYn0NdwGWK1fZss2knME?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qbJBoYrS9hz8PMyGvwiq3tcKUTRIHlyC4CxLtQ5sDrt4XYbGhOK8+gC8OW4C3n+YuQ+kT4k1nxavqgA/HZ5pu8050KsgtbyYySJE6gpat5ma/s5u3qO/H+yvVeFct7YE9zImbPBHRXH3SAu5tPtB3aQCIclEFtFEKbZtAljha9WrEW3aZn9d1dQ2B50UEfX5QAG2MB8Xwy115IERUM6Nn68sfaZLOMOe3ubkYy49++H94E3eIXJTIRauU//Lb6a6tBmVUVULZZmKFH/xZqRMW6E1+X+jV4a9xY9mbDEBBfNIsU/ZP3l2xP0SMhOFJvnfG6M5O5mlrDzX6+7a1lbLLVlCVxWDkmLxG+Kmek6HW8HZJJP/KaJ1lwCwX5soz+IdxN/lEMoh6UKjqx+v37y8wae1noLAsYfNeGVfNNYQeATQeopYpR1v2ig+sUTRIBb+Q/0s+oEpSY9V7tJOMpuSgffTiNRkT895f5KK3ucLH6raMf7+aS42iVGv8oLwkrLBY2Io+9yokWQiIi/JodanznBLuJNgBGPAbrFwAu5/nwJvkiPYvEgE3h73x5PaIBDnX0pxuy9Rt7jvihzyq3o6fhYrbShngBGL2rrhD3NJI+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6d595b-e902-46a9-d319-08ddde986b42
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:47:17.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iZcS38qN8f2/E1E5dNhBRvURIs/IYdRelutv6cF++BJRa5OoshvYawVWY6iwzde6PkSM1TmzKzQNr2qq7x2kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508180194
X-Proofpoint-GUID: 0uNndYy8orZ3aDKN-TBBiGnQVjjd-nIK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE5NCBTYWx0ZWRfX4oHUcHRRhGQE
 HKlMYJyRx1VwNbw1i3PedaCPKabX+MWCeLR/kSpuFvns13wKCYQOJ8Eo9njZYDvEk9m3HQ9sZ9r
 cNjtU939edmSvxhq5gHHXNjKz2eiCNQzkWpsj+LOz/0d7kPxb9m1D4niixizByhEZCnxCdfVVPR
 gXsFmWmbu6l8nTui37bgRFCelsvooqRYilR3fZ3PTBZ+U5FKmj6EClVQfa1kcSzM5+sctPWd5bN
 YS84xAeJKktqSaSGOwTMZ1UeDxl5hISeuLgyjSr7ORq5mswirhti8RiRwpwN6n3wbpl2AzW/EZ3
 m/qoknsmq2xs1WdjYarNz391PuHWEh0GHsxMncC67uhPzoL7KvE/KldImq8eT+lN4sTAk0JwR2W
 vNQU65gmxA5ekt6IJBJNIa9y/AxV1aIpmP/xtteML64TJipR3Heyq2fnY5CYphuKCXNUlijF
X-Proofpoint-ORIG-GUID: 0uNndYy8orZ3aDKN-TBBiGnQVjjd-nIK
X-Authority-Analysis: v=2.4 cv=HKzDFptv c=1 sm=1 tr=0 ts=68a39159 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=gMh4FCMu4RjppfL8FncA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On 8/18/25 3:36 PM, Chuck Lever wrote:
> On 8/18/25 3:04 PM, Olga Kornievskaia wrote:
>> On Mon, Aug 18, 2025 at 2:55 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>>
>>> On Mon, Aug 18, 2025 at 2:48 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> Hi Olga -
>>>>
>>>> On 8/18/25 2:25 PM, Olga Kornievskaia wrote:
>>>>> When a listener is added, a part of creation of transport also registers
>>>>> program/port with rpcbind. However, when the listener is removed,
>>>>> while transport goes away, rpcbind still has the entry for that
>>>>> port/type.
>>>>>
>>>>> When deleting the transport, unregister with rpcbind when appropriate.
>>>>
>>>> The patch description needs to explain why this is needed. Did you
>>>> mention to me there was a crash or other malfunction?
>>>
>>> Malfunction is that nfsdctl removed a listener (nfsdctl listener
>>> -udp::2049)  but rpcinfo query still shows it (rpcinfo -p |grep -w
>>> nfs).
>>>
>>>>> Fixes: d093c9089260 ("nfsd: fix management of listener transports")
>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>> ---
>>>>>  net/sunrpc/svc_xprt.c | 17 +++++++++++++++++
>>>>>  1 file changed, 17 insertions(+)
>>>>>
>>>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>>>> index 8b1837228799..223737fac95d 100644
>>>>> --- a/net/sunrpc/svc_xprt.c
>>>>> +++ b/net/sunrpc/svc_xprt.c
>>>>> @@ -1014,6 +1014,23 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
>>>>>       struct svc_serv *serv = xprt->xpt_server;
>>>>>       struct svc_deferred_req *dr;
>>>>>
>>>>> +     /* unregister with rpcbind for when transport type is TCP or UDP.
>>>>> +      * Only TCP and RDMA sockets are marked as LISTENER sockets, so
>>>>> +      * check for UDP separately.
>>>>> +      */
>>>>> +     if ((test_bit(XPT_LISTENER, &xprt->xpt_flags) &&
>>>>> +         xprt->xpt_class->xcl_ident != XPRT_TRANSPORT_RDMA) ||
>>>>> +         xprt->xpt_class->xcl_ident == XPRT_TRANSPORT_UDP) {

I still think this check is unnecessarily confusing.

Can you instead add an XPT_RPCB_UNREG_ON_CLOSE flag in the
svc_xprt::xpt_flags field? Check if that one flag is set here.

Set XPT_RPCB_UNREG_ON_CLOSE for TCP listener sockets and all UDP
sockets.

An additional clean-up might be to add an svc_rpcb_cleanup() call to
svc_xprt_destroy_all(), and remove svc_rpcb_cleanup() from the upper
layer callers to svc_xprt_destroy_all().


>>>> Now I thought that UDP also had a rpcbind registration ... ?
>>>
>>> Correct.
>>>
>>>> So I don't
>>>> quite understand why gating the unregistration is necessary.
>>>
>>> We are sending unregister for when the transport xprt is of type
>>> LISTENER (which covers TCP but not UDP) so to also send unregister for
>>> UDP we need to check for it separately. RDMA listener transport is
>>> also marked as listener but we do not want to trigger unregister here
>>> because rpcbind knows nothing about rdma type.
> 
> rpcbind is supposed to know about the "rdma" and "rdma6" netids. The
> convention though is not to register them. Registering those transports
> should work just fine.
> 
> 
>>> Transports are not necessarily of listener type and thus we don't want
>>> to trigger rpcbind unregister for that.
> 
> Ah. Maybe svc_delete_xprt() is not the right place for unregistration.
> 
> The "listener" check here doesn't seem like the correct approach, but
> I don't know enough about how UDP set-up works to understand how that
> transport is registered.
> 
> A xpo_register and a xpo_unregister method can be added to the
> svc_xprt_ops structure to partially handle the differences. The question
> is where should those methods be called?
> 
> 
>> I still feel that unregistering "all" with rpcbind in nfsctl after we
>> call svc_xprt_destroy_all() seems cleaner (single call vs a call per
>> registered transport). But this approach would go for when listeners
>> are allowed to be deleted while the server is running. Perhaps both
>> patches can be considered for inclusion.
> 
> You and Jeff both seem to want to punt on this, but...
> 
> People will see that a transport can be removed, but having to shut down
> the whole NFS service to do that seems... unexpected and rather useless.
> At the very least, it would indicate to me as a sysadmin that the
> "remove transport" feature is not finished, and is thus unusable in its
> current form.
> 
> An alternative is to simply disable the "remove transport" API until it
> can be implemented correctly.
> 
> 
>>>>> +             struct svc_sock *svsk = container_of(xprt, struct svc_sock,
>>>>> +                                                  sk_xprt);
>>>>> +             struct socket *sock = svsk->sk_sock;
>>>>> +
>>>>> +             if (svc_register(serv, xprt->xpt_net, sock->sk->sk_family,
>>>>> +                              sock->sk->sk_protocol, 0) < 0)
>>>>> +                     pr_warn("failed to unregister %s with rpcbind\n",
>>>>> +                             xprt->xpt_class->xcl_name);
>>>>> +     }
>>>>> +
>>>>>       if (test_and_set_bit(XPT_DEAD, &xprt->xpt_flags))
>>>>>               return;
>>>>>
>>>>
>>>>
>>>> --
>>>> Chuck Lever
>>>>
>>>
>>
> 
> 


-- 
Chuck Lever

