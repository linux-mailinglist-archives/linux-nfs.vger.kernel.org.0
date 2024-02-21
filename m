Return-Path: <linux-nfs+bounces-2044-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EC585EC15
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Feb 2024 23:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151AE1F21B9F
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Feb 2024 22:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A8C3E468;
	Wed, 21 Feb 2024 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gjPkvqMd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="atwW/3fZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F93BB37
	for <linux-nfs@vger.kernel.org>; Wed, 21 Feb 2024 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556164; cv=fail; b=VxqGBoVs0Ix7nHQYJsA+HTGzRymaYnVWAuVERHYl8CaUKDbXOUW3w+MWSrqa3eyVEEfk7UtCtHlfuE7xvClgI/CZpDzEKFPxxb2wzl/WNuNSpUkFsnozAdxrFtaF+lmckkP8M/93UfFOVCMxzZ2MWSHsGDK8vX60CJn6uCUX8/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556164; c=relaxed/simple;
	bh=ugAqGT+gzk0eZx8yT+m26omgdJitFBJUIUVIcWMxvg8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o46pTC1rBFYfTmPFuA9WhEUx3kcEDWbLINoHwkWDLsslTpLo2KNDj3yuHRUGRSzve5IuTWuXUlSDnST7szjaPP0ScueF9O5am1xy38dJBAaHLFqBcuvZzK5NFdhYJUB5b6haBGCUcRImj6bzYZuVE+Tf85GfkTVJqVeZVsd6G3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gjPkvqMd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=atwW/3fZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJ9Q4l005011;
	Wed, 21 Feb 2024 22:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ugAqGT+gzk0eZx8yT+m26omgdJitFBJUIUVIcWMxvg8=;
 b=gjPkvqMdVt3vq+2xT8r7d37HpkLp5uvpYO9569oo2XCz1iAd8ZZARGKGDa7VRoP2hkZP
 EJN/48t5QlkHaAK4vY8mxTn3baulyEIwHDryAd7Vt/Yljx/Oz3c8SK1gogbh5Kk/HEZ9
 ADxL7ee3FYUin8+lpkjXAJIyyvLzheDSV7EiFvtbfuTTfVGtDOHCtMsc/6SYPhnouitV
 /XK4YZrqjQe1NTJolpHGgMUvu5fZrZSrbRaoYm3ljM32Ttq+EvGfuWs5HHbVXWKNxxTI
 cs8iEakS4/UVS8NOe5/Clb6jfo1O0RKik3ICLnN1zE9Wbqhz7V2ZYuTj0ATIBfqc5XIf 5Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd2b6sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 22:55:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LL6ZxJ038036;
	Wed, 21 Feb 2024 22:55:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89qau0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 22:55:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAarl3EoA2bzLob+GRfMTfJ3i7gAov7yzci5og8woneDzFfXpZBeydXxuuPHabslut33t31cnrYGZiW36Ndt6hgCHvGT3EztBGSwFo7NUE7UYuQN0KuP9E728V7O8lv4MPHXoU6rC1pKbgKAjjLWCGdrXOC362Cv73xxpaF2mtT+edLwbsEjXQ34ToJUMb3Txcm/p9p65bHZNl9Z/uIYzCj2lVE8cpt6c1qXhocvk8RxLS7Mnwi/CXcuVcLO+yTKnAeDmRWKFpZ9f0tNI6JhPCf7DgbcLs7quK2GeU9Y2n8+efFO6oci7o+quawvlbbAT/pmemd2z77hwzRGLaR9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugAqGT+gzk0eZx8yT+m26omgdJitFBJUIUVIcWMxvg8=;
 b=ldd1Sz1w9PwcAYleiqUAenJKwyd0HrTQr4JZohAZOH+Wv6jhrbZyPJb9B172M1qDTJQ1rTEPD6hPHRjHgSS25BBaNeL9Ms4yiICWB1plvc9fD3md6dSsyhMI0SPYo2pX0WVAIGC1TfpLBUYNYyB4WzboEOK8esxC8wfh2xEoZTHucl0b92s1jJwILqyDE3fwSmrpYHIwtaVzplHVcVNe6HnaFcqnESNbvQQdJp5L48Zuts+lEFCKilkzGDx116dLmDYPmXxRVMYEzB9S4zhRdKJOdeFN/HkMylsSjOHeR5aExtQqmdQbu6vER6SvYqlDvMP6jxbnHsxJbNbU4H0X1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugAqGT+gzk0eZx8yT+m26omgdJitFBJUIUVIcWMxvg8=;
 b=atwW/3fZhAbwzob5HJeZRHssjyFV5G/0pUEJaR4jNrHkUWKPmJvscL92+srJXE7d1T4y0OCHuxXgftEJDLKeG0JsatDKbs1Ak5t0ERoy/Obh5cz3PCWgkrBqQWaWKI2h99hpL2hFmFgfngeKPRgCK8FaTZX939B1PBXDf4sN0ls=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SJ0PR10MB5669.namprd10.prod.outlook.com (2603:10b6:a03:3ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Wed, 21 Feb
 2024 22:55:54 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::329f:23a:265a:e4cf]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::329f:23a:265a:e4cf%3]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 22:55:54 +0000
Message-ID: <530d4fa6-f4f8-4981-b352-095c9d038f41@oracle.com>
Date: Wed, 21 Feb 2024 22:55:50 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: send OP_CB_RECALL_ANY to clients when number of
 delegations reaches its limit
To: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com, jlayton@kernel.org
References: <1708473508-19620-1-git-send-email-dai.ngo@oracle.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <1708473508-19620-1-git-send-email-dai.ngo@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Y65ohb2LwZN2NamKMoPjo0i8"
X-ClientProxiedBy: LNXP123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::34) To BLAPR10MB5138.namprd10.prod.outlook.com
 (2603:10b6:208:322::8)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SJ0PR10MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f4cd4b-5aaf-4ba9-703b-08dc33304236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9j76+z6fg03spNki/+R+Hq45Hs48TsL1dV1QxgIIKeiClvWdq/kDkOKmzZNhN2YkYdEKBZwB9BeCzRMBitdgB5iae++H+9ujXIm7DbZEDM8Q6N4Hb2lEz/yYSgR/gKZ4FHkDwkaR+FL9/5q6YuMG4up2jmPI9jyAp4HKIfpsVP33eoR6Jx7s5kfP4Ff2KyOCgaglMR6VEaoZVlMCQcBPXqPwiSlED0eWRMBBrQN5w99/etfyhNbPi70N+sFquFue/eI2un5RsFMlCvonNneyGoLIU/6vLwSr8G2ZtKYSE6Ljm5pM5l2nva+kKNojpnyot+EG6FOITs+wcusFCdVciim0csjYp562Fh2E53prLAdufhjfCqmbAVEkS4nwAmdb/ytG3ebg9mQ34BepPh8ApTlcIcoxB+WJRkZ1t9QvrxCXElpOrEY0BhZcXSs7sg0rg5JYBOAUX+ivZdwz4d7Po0/R+Jv+zCvNboJ3/5FiHBpDO4SsMGiSsMZVP56ZdAwAl1n62u5tESgV7BE8MumRLIF8lX9GR7QiaphBZ960LfE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RitBOXloVlp1V1llL3Z1cDZtWkd2NFRHK1NEMDVlQ252c1hMMXlCK2VhMTkx?=
 =?utf-8?B?QTZtUGp5T3dBOXRnOWRMemhpRVlZc2VsdGtJdlJFemZGVlJUdFdhMk5uU1Mv?=
 =?utf-8?B?TFRocGhjSHVTa1lFUkp6VmtoZ0FjU2UvekxOb01sU1ZNZFRXT2JkMXZnb2RH?=
 =?utf-8?B?cU4xZTVzZWo1OHJpWGowMUFZNVNJY01Sc2dETDI0U1Y3SFUxUzhMWk5RVEI3?=
 =?utf-8?B?U1BrM1FKVWRDc3RZdnhGK2ZlT0NFRjM4QnhLN2NjaVBIUVJPakk4a28xczht?=
 =?utf-8?B?dnVUYVIvckVEMGZEY0UyWkMveld5ZEtuRXFtNnhzTHNvdG5nb3VoOUZvZ0VN?=
 =?utf-8?B?MUM1ZnU1Z01aUmRYR21WMWtpQ2U1REt1S1RoNVMrWFZMTUJIaDF5K2kya2FD?=
 =?utf-8?B?cFdUZnlRWXM3YmtnZWNjaWtZNWJRc3JtY3pMUjFRaklQVmVGUzR4bmhYc1pu?=
 =?utf-8?B?NHN3RU56cTdKZXM1MThZbVd6dE9vVTJySzBHVkM4RkZCMFRjM3NJU0trN0JT?=
 =?utf-8?B?KzROWklUakpyRnMydmRnV2dscWVKbWsvZlg0R081ZnZmSjZuWm1IQVF2ZE45?=
 =?utf-8?B?MjBZeE5zNnpBcjNPSkNtbVlvaUIyenMzSEVpa0UwV2VENkViVW9vdTMvUXBr?=
 =?utf-8?B?S20zbE5XSGJIdlhiVktVbld0empqWm52R1R0czY3ZldwUmFSdVA5bU1jRzJP?=
 =?utf-8?B?eWRpaHVpekFkT3hxL0c5S21xZmZqY0lHdkpMOURzdDJMK3d4MXVLM0V4RlF0?=
 =?utf-8?B?eE92SXdmN0lJQW45dmpESmFBYWZxam9pK1NlZlF4YW5wRFhUQU4yNHVmUGFO?=
 =?utf-8?B?ZnhRcHB1QjNNbUtMKzBIKytJUkFQQ1pPcm5IN2NGNkxNUGJCeGdhaDZ2ek1s?=
 =?utf-8?B?VVRjV1B3RmxpbitQM1ZpZUNSRHRydEZCMWZjUFV4VWt3YXl6VlJ6NTVQRENQ?=
 =?utf-8?B?L2p3ZGZ3MG1zNTR1bDI1NWJKNnVhMElManBJWHRrRUdNVXI4Z2dOYkZzQTVr?=
 =?utf-8?B?czRVRG1BWVR1eGNvUzNXQzdPQkU3eWJvRzJqWFJMdTFQczhkY05LYjRqeW96?=
 =?utf-8?B?UVU3MXU2ZFprV0FUbGRCVW0rM0ozZkZGSk5acHloUWNzc3A0SEdicWY1c3U0?=
 =?utf-8?B?aW5SU3NFZHFYUkRYUXl6TFRKNTNZb3ZXNTNzNmVhWHlJS1I2LzZIeXAvaktZ?=
 =?utf-8?B?VjVHa3FNYnBGbnVOejl6TEUvRVkzWmV0bGZ3b0h1cGFHQU1xbmxWaVYwMW1T?=
 =?utf-8?B?TitPejB1T3lpWU1mWEhqSzdFaVoxMkxSZGdaYmJwWGtMYTNBOGtsa0QzdThS?=
 =?utf-8?B?RnNGWFhGT0ZZdDM3OTkzeEtYUXl2OTkyUmRuR3VLTldSUlgvb3hIazgxRFFE?=
 =?utf-8?B?U28zQlk4R1d5NkhxOHEvNDloN3JkZkI3bHFLR0R1dzRGRWNLS3JTSi81Q0FP?=
 =?utf-8?B?MmtFMjNnSE9YVWxGVW9UdUVUZXZkZ0RvTnJMUlVRUHBiZStObnphSml6Ukgv?=
 =?utf-8?B?cnZqQTNxUXk4WE0rTVdPa0lmY016ZHNPVmtIdi9leHZQdC9aVlRpRnNSYm43?=
 =?utf-8?B?aDMxbVBtdGk1b3FFZTBOaEF6RXpwSjJ4Y2psQWxOUzROQytHVHZ6L1l5cTds?=
 =?utf-8?B?TlVXdHAxTlBJMVE4SzN1eHFkSTUwdDV0Q1FzS3QyMDVRL3JHNHBBaEN5dlJ6?=
 =?utf-8?B?c3dkMGgrL2FGM1dZd1V2M1JRUzBZYVpKMHdOdWgzb2U0SENDWFI4dVZGSmJL?=
 =?utf-8?B?Sng0bUlXNW1LY1VTNnhzMU9XQ2V5T1VRcGZORUtPWTZFSnJWRkhBU084bGZ6?=
 =?utf-8?B?RjhYN0JLRVhZeXBDZ01ibC81WGpRY3lSa3M2Q09QVHNlcXllWXYxQVRFUzhp?=
 =?utf-8?B?VjV4VW44Z1gwaWdEWUd0ZDhTN2JBd0RSZUNESEJnUGd0QWIwam0xaWhKT1FY?=
 =?utf-8?B?NGhRRnFpNGJpNFdyK1hNdm9RSmRUZFlSOVlOS1JvMlE2Z0ZGdGlJLzJmbUdv?=
 =?utf-8?B?VWgrQ1ZwZW5kNXNKWm9qN3pCTysvQ0ZNU3JTMnNvTEkyM0didUZtekZUSGJh?=
 =?utf-8?B?WXpDUUdHZXpPVk9yZEVlc1Q1RXljWnhXRjE4aXZxL3VQdHJiaFlCdFBONnh3?=
 =?utf-8?B?cXNoMmNQZkZReVBGWUVaTDJuRXFLRVpjQ1lySmFPOCthVnJaQXdaR3d2d0M1?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mK3tyTiCTK/D3noRZO0CFGHBdqDkuCNU1e62tWjXquhUTtdrY9+vdbKFsly0bpcWcAvyeKmk5+LI/aGVlF+NW5cN+Psk3QNi9B042Vz4TbIndQN3WlZPvOWxFu6jUoAE/NMj5kPvdfit8eKeH5eekjU9d5g8c2XjwBnusa3IV5fTydHNfU04WpV6rjkuvv2htagNO1qd7e+6he9951PZkneqXRYnzNORmY6XMrHBpoMtyk91v2jwCEjnz/FLMMTUDpWJX3NmCfe0Bv5qjz9rrWD9UlOSOcSSZm3loX1K3t7IqFxjo29U661TdaNAyB5oJIAMf72lTTONUE4Z+tcw6EjE2KUPEtwea7LqTI5qU+sqcIZI4kscTGt5w6+aCiGmSy4oU4oMa6aWwrK/b2cF8wQDnMxD4BAuunEJSGaY+GnFlk51lXbBhbx1/HLZINidHQmxRMW1yM8vHEWoIGbdGq8fOs6K0nSYCpu+2p6nFLd95H1wfhEWNSyld97B/CvhypkBIkkza9YG6hpHgP0h7hCoykGKRIy4UAnY8/g4IrakNuauxdzSfyK1v792AQyzdyYqcXz+4w+59km0NwN1hH1ZGSZ8tUepaaA4GAF8Qu4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f4cd4b-5aaf-4ba9-703b-08dc33304236
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5138.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 22:55:54.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYjMKIHvamz/PJfaaABulK+1ApFgCJuQo3vVUVFskgu7An/51a40TaVA1QbyU2ZtaNBppTs3qG2SUwwZEbmhxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210180
X-Proofpoint-GUID: SOrTCWICcZw8ULllx4fbUFvuM86V57Ey
X-Proofpoint-ORIG-GUID: SOrTCWICcZw8ULllx4fbUFvuM86V57Ey

--------------Y65ohb2LwZN2NamKMoPjo0i8
Content-Type: multipart/mixed; boundary="------------43eAPLp4XdYJWFS0kcKTyrvR";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com, jlayton@kernel.org
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Message-ID: <530d4fa6-f4f8-4981-b352-095c9d038f41@oracle.com>
Subject: Re: [PATCH 1/1] NFSD: send OP_CB_RECALL_ANY to clients when number of
 delegations reaches its limit
References: <1708473508-19620-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1708473508-19620-1-git-send-email-dai.ngo@oracle.com>

--------------43eAPLp4XdYJWFS0kcKTyrvR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

aGkgRGFpLA0KDQpPbiAyMC8wMi8yMDI0IDExOjU4IHBtLCBEYWkgTmdvIHdyb3RlOg0KPiBU
aGUgTkZTIHNlcnZlciBzaG91bGQgYXNrIGNsaWVudHMgdG8gdm9sdW50YXJpbHkgcmV0dXJu
IHVudXNlZA0KPiBkZWxlZ2F0aW9ucyB3aGVuIHRoZSBudW1iZXIgb2YgZ3JhbnRlZCBkZWxl
Z2F0aW9ucyByZWFjaGVzIHRoZQ0KPiBtYXhfZGVsZWdhdGlvbnMuIFRoaXMgaXMgc28gdGhh
dCB0aGUgc2VydmVyIGNhbiBjb250aW51ZSB0bw0KPiBoYW5kIG91dCBkZWxlZ2F0aW9ucyBm
b3IgbmV3IHJlcXVlc3RzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFpIE5nbyA8ZGFpLm5n
b0BvcmFjbGUuY29tPg0KPiAtLS0NCj4gICBmcy9uZnNkL25mczRzdGF0ZS5jIHwgMyArKysN
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZnMvbmZzZC9uZnM0c3RhdGUuYyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4gaW5kZXgg
ZmRjOTViZmJmYmI2Li5hMGJkNmY2Yjk5NGQgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mc2QvbmZz
NHN0YXRlLmMNCj4gKysrIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiBAQCAtMTMwLDYgKzEz
MCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbmZzZDRfY2FsbGJhY2tfb3BzIG5mc2Q0X2Ni
X25vdGlmeV9sb2NrX29wczsNCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IG5mc2Q0X2NhbGxi
YWNrX29wcyBuZnNkNF9jYl9nZXRhdHRyX29wczsNCj4gICANCj4gICBzdGF0aWMgc3RydWN0
IHdvcmtxdWV1ZV9zdHJ1Y3QgKmxhdW5kcnlfd3E7DQo+ICtzdGF0aWMgdm9pZCBkZWxlZ19y
ZWFwZXIoc3RydWN0IG5mc2RfbmV0ICpubik7DQoNCk5pdHM6IElmIHRoaXMgaXMgYWN0dWFs
bHkgbmVlZGVkICh5b3Ugc2VlbSB0byBiZSBjYWxsaW5nIGl0IGFmdGVyIGl0IGlzIA0KZGVm
aW5lZD8pLCBzaG91bGRuJ3QgaXQgYmUgd2l0aCB0aGUgb3RoZXIgZm9yd2FyZCBkZWNscyBh
cm91bmQgbGluZXMgODTigJM4OT8NCg0KY2hlZXJzLA0KY2FsdW0uDQoNCj4gICANCj4gICBp
bnQgbmZzZDRfY3JlYXRlX2xhdW5kcnlfd3Eodm9pZCkNCj4gICB7DQo+IEBAIC02NTUwLDYg
KzY1NTEsOCBAQCBuZnM0X2xhdW5kcm9tYXQoc3RydWN0IG5mc2RfbmV0ICpubikNCj4gICAJ
Lyogc2VydmljZSB0aGUgc2VydmVyLXRvLXNlcnZlciBjb3B5IGRlbGF5ZWQgdW5tb3VudCBs
aXN0ICovDQo+ICAgCW5mc2Q0X3NzY19leHBpcmVfdW1vdW50KG5uKTsNCj4gICAjZW5kaWYN
Cj4gKwlpZiAoYXRvbWljX2xvbmdfcmVhZCgmbnVtX2RlbGVnYXRpb25zKSA+PSBtYXhfZGVs
ZWdhdGlvbnMpDQo+ICsJCWRlbGVnX3JlYXBlcihubik7DQo+ICAgb3V0Og0KPiAgIAlyZXR1
cm4gbWF4X3QodGltZTY0X3QsIGx0Lm5ld190aW1lbywgTkZTRF9MQVVORFJPTUFUX01JTlRJ
TUVPVVQpOw0KPiAgIH0NCg0KDQo=

--------------43eAPLp4XdYJWFS0kcKTyrvR--

--------------Y65ohb2LwZN2NamKMoPjo0i8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmXWf3YFAwAAAAAACgkQhSPvAG3BU+Iw
qxAAmH+AWcwJpiGpWAjSOmPz+okqAW57aq8Sv1t6EwAFBT8ikT09U+HbVwDDkq23hEGM34gY7PXf
AvRkbfpv1HptawNodZJMLsq2pUUn1wp0dGGwsrOJUDNcM8Hd6WBQsEWs0ipRCCMkuTRslxMlJ5Zu
A1EEvRW82123tI5rTCSo9yROK27X/dRUfIHW7dEUPZlA4HxUlMErd8cFtvpMgwdRLq32p1dMeShA
g0SeK8pbwY6RFQMPAQ+QPLcIZugY5I9qfrd6qK+X6NiEf5CfY8TOv4JcP8zUMHudV1NT2KPUpFVH
Mz2hMC0ABttDlM/TSZUMhRdpqDQKXvkaIPNoU+7rs0/dqzw6Q2nq8c0uk6c7uj+qsie8HhuM6G+t
dFzRprlyPSnez9zCeKog+e9+2EC3V4/jbm8jXXFSTcawGUnYoZirEVmhwRaUqrdhCZ9Sdm7q/H7G
SOo6JatYdSDIe6KN8Dl6wuM+OW4GbW63VJauheoX8WW9CcMc8xskQTRW7GJ02M0rmhQ6TpTNpHva
e9ptD+LHYNUdViwEsdzDHjJlnOZXNUap6xit7BWzbgYpFlqWNKA3BrApLFThWxhWrduslHRAwDw8
wqdHd7+FawVDDjAvgLw1xZnoM7qNNBhQ51nRzDvKeVNRCZDf6TheXGte5HxEZ3aGiNY3ZA3FHMa3
mkY=
=Pldn
-----END PGP SIGNATURE-----

--------------Y65ohb2LwZN2NamKMoPjo0i8--

