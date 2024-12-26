Return-Path: <linux-nfs+bounces-8791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 947479FCBE8
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 17:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF37D1881FB1
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1EF2CCC0;
	Thu, 26 Dec 2024 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B1ZhiL9x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="phnfX2+B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452028EC
	for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735230817; cv=fail; b=lm4rFPAIsjxSKgwcMjtwbjncVO10wfeetX502I+0LGukTd8E1P2wypA6xWsUGsHCUYKOuFoQE5b5dxvK7qPra3SLyCqYS4PDunEFbNhCTxwAT71EGkpRppB2wFceMwgCE+6QB51nYRtNv+NwyKzTlhA+2t/NGq+KpStwBG1EQbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735230817; c=relaxed/simple;
	bh=BWZRzVak+ysZO+JQ6Kf/IWrIVYwlW4ho+oivApQjo2I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iUoCszztkJPwJZ2kznNQdSobBa/R8htcjCAgfeI1ac65oHJVOs0CPC74W+s8fejueblymhdujgqyP+qipNtiyZLCAJ4iGErsAdVW+D0/7IBZI+qtEogbVdLu+0ewzhFdYmpM4M9U5iL5nwgny30/shCUcX1b/t525HHZ7+7PFbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B1ZhiL9x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=phnfX2+B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQGFuIE015817;
	Thu, 26 Dec 2024 16:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OPZzrdWVYQz3vai2nFBsIsi1e9wwqcPsHqE2sT3WdtM=; b=
	B1ZhiL9xfUcb58Qc9SISeWMyR+sigDjfJ/tODSejA2IuUIxyfJts45dWTrXBIMDW
	FcHtiNrs8YAASz/p8FjLo8Z8YkNsYOKT1VrauExQxTIRe3lra/yQk96w7/oReMPx
	c2MusY19ZUvpwnMek0BtSLxVNX/MkvUcb7l04zak56ifkz5trxBIctOG7A6EYzct
	C5uS6tBc5AqT9pHDAsOJVrvB3hqvjPWMQgKmHE8fi16N4qZsErBZBIQzHuCfoeNI
	K7vxYZCiRRiN+7AykthzzO6a0m4XlEtAqb/s7XxWjOahbT/qVRZgxizty0IqxniI
	J8xdWSczrp94fEj9QVnG9g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nqd5pfbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Dec 2024 16:33:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQEo1um020590;
	Thu, 26 Dec 2024 16:33:21 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43nm49fs8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Dec 2024 16:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwx9z4b1akWXG5n+4GIKLdBCb/wvBMCn1hoDhqUqkuWv8WWj6PpMC+6TTvAT6Akd6ZMDKlM96kujn+D50ZUuTnYERaEtuNqpUOssixjpdFFW/q6wTS1S4gMOR/k0eI1jRd0uRETS819qTU4KCLJ1TKDIcZZwkSAW01OPLnphrHj2sme8yoeY42knA5jq4hdmY+6IOH/IHQdDodDs59xMWKJrNt87qlB92qfjpw3rsI4qTToOEPRU14fANrxVAXfZVWiPpNU+4aAZ6IKCwYXNLA4mCuFCU3z9XQUW+spl7uykdR0tVPedd4AyM5msg9YHtyVpvV3mVGyO1dBVN6TIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPZzrdWVYQz3vai2nFBsIsi1e9wwqcPsHqE2sT3WdtM=;
 b=VUm7spDylBJTVLM2E+ZE1kqx3gzV0WKj+pPIj499ygmUtQpi/6pj1uxWk3M/1QRSd2GBhEwGX7j9FUYU3yFAVSyaD1jV05aGsRSa7/bhgo1PnxTZiCFR9M6X92844o1Ew1f1r0JKsgG3p7Vc/oeQqihN+OPCacvqG2kHbX9ZLiByVuISphb4GKiDIY7DwLETFZsRScQxA5v5Y27YZq1tuK8ymoVxHQWpO1zosa04uQy/7GAZHX8MOk9cYKUUEnYj2PLZzWyfpCAaO8ZkgqT8gdINLhE9Rv2cJYzqbbrK2aor0tF1pfX15RzR1WKTPbeQV5wS16wyGualcA7JPisayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPZzrdWVYQz3vai2nFBsIsi1e9wwqcPsHqE2sT3WdtM=;
 b=phnfX2+BA1sTu8lsxIPCAaRIxMc8EsgOYr8lQbzmyc2B9YeUQQeTGeA2NSnTNUeIPoTKqMYscYCe49/k0dGb6e3xooeiclycU3a7WuKSa/Tt9juVPmgic4jRAEjxMlWLfQN7MjFQPQ/RMKrFtidJLkLoyHXInteub5/Vm1M0oOY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4412.namprd10.prod.outlook.com (2603:10b6:806:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Thu, 26 Dec
 2024 16:33:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8293.000; Thu, 26 Dec 2024
 16:33:03 +0000
Message-ID: <7c76ca67-8552-4cfa-b579-75a33caa3ed2@oracle.com>
Date: Thu, 26 Dec 2024 11:33:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG at fs/nfsd/nfs4recover.c:534 Oops: invalid opcode:
 0000
To: Salvatore Bonaccorso <carnil@debian.org>,
        Jur van der Burg via Bugspray Bot <bugbot@kernel.org>
Cc: anna@kernel.org, trondmy@kernel.org, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, cel@kernel.org, 1091439@bugs.debian.org,
        1091439-submitter@bugs.debian.org, 1087900@bugs.debian.org,
        1087900-submitter@bugs.debian.org, Scott Mayhew <smayhew@redhat.com>
References: <20241209-b219580c0-d09195e1d9e8@bugzilla.kernel.org>
 <20241209-b219580c2-2def6494caed@bugzilla.kernel.org>
 <Z22DIiV98XBSfPVr@eldamar.lan>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z22DIiV98XBSfPVr@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf3c0e8-d8ab-4897-ea58-08dd25caf860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkhnM1pIZDFuUnNZWlpXUE9vNkU2ejFkZmRLeWVEUjZ3RDdnMC96dDltRUlY?=
 =?utf-8?B?UzdYMlp2K3JHWjB6UVpjcnRKZTZCU2hqcHFlaWQ0Qk50QWMwSXhlYTdwR1I4?=
 =?utf-8?B?bktmc2tPV3h3N0tBR1VGMkNaSy9LUlRFUmF2cHZHS2VvUjUxU1FlMXFXdWJE?=
 =?utf-8?B?SFBwUTJrV3EwQ3VBMmRYdWRURWlVV2NrdlBxTGRsZ0tLTTV2bktFbEZwZFVa?=
 =?utf-8?B?SkpUV3dpYUJiM29oSEhoQkprZkM2dGZuR1lQZFFQT1FSNVRlWFJhaFRibGR3?=
 =?utf-8?B?OUxTTytrU2RETlRoRi9tTndhVWJIWG1lVXl2cVEwVmkydXNwSFBmQlJiZlgz?=
 =?utf-8?B?bE01aXhwMXhLbkxWbmRCbTV0WTUrR3BoZVM0cGpTWEthQjlxRWQ2Q05yYTh5?=
 =?utf-8?B?alQxSGVyMkFqODF5YWlMRWpzQjJpYnUyQS9sRmtWQlczeHBSMFBpL2t2MHAr?=
 =?utf-8?B?MjZ4T1o5NE5vVmJYUForSXVRdzFuMytQd0c4Zkhsdk5yZ3I1aGl3VUZvb0dW?=
 =?utf-8?B?dUxlYnVFMHVGUFdmVW4vLzRZd0VtdVQxMi9SN2s0NFIxTDJyam5Ka1htRDRL?=
 =?utf-8?B?WVA4OHJ0cWNqZUI5QmhMdnRSdmJVQURxVTlKTm1uTFgzLy9hQ0hCcWlILzRF?=
 =?utf-8?B?bWNnVDIxY2Y3dFYxMmVvTmZoL2VudnNodUJpaTZBTGRyRTI5SzAzbUZUeWox?=
 =?utf-8?B?eTJUSkR0ekRvVk9wRmJDa1F0MzA1OGJBTkN0eDJDZjMzeFQ1Mk9BR1R6SDZX?=
 =?utf-8?B?MmFBN0xFT08vTmFjakYzL3dCbHpNUVdXWEg4Sms2K3lSVlphMndvaFJEcjVj?=
 =?utf-8?B?SGZmQ2VKUnBYOHIydmR3Q3JDdkVwMzNIUDJBaEZtbWVLWG4zenRKRDV1U1VZ?=
 =?utf-8?B?Skt2RVI4aktZZ2wwcW1kQVlVVVF5Y0FubXExek1UVlAzS09wTXo2UlRpcVlQ?=
 =?utf-8?B?UVpxaVFPbEhXbU9RL29nOFA5MjdpdE4wZlFib2pGb0hlYUNnbkFWT1lDdk5N?=
 =?utf-8?B?T25WVk9FN2xWT0drWnUrbUdub294T3dmQUJIWnJXdHJXSmZQN29LVVdGUWZn?=
 =?utf-8?B?SWtXSDE4anRSTXRtSjZUc2llYmh5RWU0SFVsSkc1VzdJekJvb3N6THlDc25x?=
 =?utf-8?B?TmRwZEIxUjJGaTZJQkh3emFrUTIrWjFzaWNsV0d5Q3pMcFlVd2FtY3J3RHdW?=
 =?utf-8?B?NGVWdkVUSDZSMG83eVlFNEFLZE9tRWFhU1BEOVduQ1g4TDF3Z0RlS0svSnlJ?=
 =?utf-8?B?UExjbVZPMFdxb3RDU2R2UnhlWEg4UE5OanlhdmxPYUFxT0JmZk1YSm16OEht?=
 =?utf-8?B?U1Q1ZkdxR0JYSEhOQTEyNmIxNC8yUk1uaEZiY1hnSEhnT1N4ZUY1Y21lL0hz?=
 =?utf-8?B?TnV1c201RnMwQ0t5ZnFHcVlYTkdJTFhmN2hnTXVQSzRGbG9qcGU2UmtpekRL?=
 =?utf-8?B?ZHBxcnFzVWVSMkRtVTZtUkhxcXduSzBXZUdock94RkR4dllKWEJGYWNXdG1X?=
 =?utf-8?B?aTMrWUJuSFc2TGx0Z1V5c0pHaFp1akVEaFdSRjhLaFZVUjgwUENvVHE2elJw?=
 =?utf-8?B?alRtbjc1Tk5Hc281VDROb0h6N29VN2pFNm5TQTJwZFhFTjFnZWVsK0Q1M1FB?=
 =?utf-8?B?eE9adjdRVEdycE82bG1IeTJiUDhla0dIZ2ljczJ4MjBvZHdXS0Y4eFdvaERW?=
 =?utf-8?B?QlBSUElWREtQUG5ISURlancyT0dLYk52L0UxV3NvSUF1aVNGOFk3NTcxdXJy?=
 =?utf-8?B?U3JKWUYyNXRSMnVNMUdDSkEzakgzLytZQXpXbzN6VGZSdUxPWGk5d2NoMHZL?=
 =?utf-8?B?ajdTcHYyblZDVVF5Wno2a04wVi9HampQbFZ4R3MvalBic2tjaGJWUUR5dVVq?=
 =?utf-8?Q?2zFo+G/ZkzwiG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU1GYUw0WGdHSWtsOVN1ZE1CY3RkU1lRSzA3VkY1TllXRWtJM0JIZTFYQ3c1?=
 =?utf-8?B?OFVGSjE4RWdkWktjQmhacnhWMXR5a1k0SUlrTXV5WXhKU2lZOWxLSXY0Wnlz?=
 =?utf-8?B?MzJyRU9DcTZEYllnOHVPUy9FZEk1QU9kc1VXTEtkR1hlN2JZdjl3emhsc01N?=
 =?utf-8?B?dEp2d3Eyek95Y2dIeWpUV2h1MmRzOXZXMWhXUVhUc2xWeVBRRU0zVHhYaUV5?=
 =?utf-8?B?c0J5RU84bGVVbGJDcU1IcnA0V2E0Y2s2bkZ6Z0hISTVRM25TMmI1c2g4OGV5?=
 =?utf-8?B?T2dvRlF5VUZsVmsvbTROdERSN1JLNDR4a0g2QXB5dlBrQjQvNXM1V3E2Q2pC?=
 =?utf-8?B?cm91d2RDTUIzMjlsdHByV2ZSNnhGWDVhQ1EwSm9INFpHQXVWRVNzWDBvRWo0?=
 =?utf-8?B?eGt4cFVaS050aUE1SVpzcUNmZUVEd2I5TXFBbjNaajJlM0lPOGdhOEdFNHFW?=
 =?utf-8?B?TlFxV1dqaklHS09EVWJwMUtQdXFOL3A4Nmc4VlBhK213QUNxSnFWeFp3TW1B?=
 =?utf-8?B?NWt3ekhKU2YvdGRqK21qM3JTK2xVb0puYVkxSkF6c0NxLzU4M2poSW1BWGJk?=
 =?utf-8?B?L1pNdDF4M04ybDEzOXEvL0VNVGZ3NXFhUWt2bmsxdHE4OTd4L3kwOWVSdlZI?=
 =?utf-8?B?ZjU0Zjg4aFlpYkppeDdIdVN3V1E0c081eHhqU2FYZ3F4elZnaW5wNytvNEQx?=
 =?utf-8?B?S2J3d2svdGs1NGNNTlZVTFBKeklDeGlpQjE2Q0xkZjBTR0VVM255K1kvTjRH?=
 =?utf-8?B?ZUZaZFJ4NVlocVRRaVFENVpKU3JIKzRXY1F4VEtjOVNrQmJ6TkpoWGpHa0dK?=
 =?utf-8?B?d2dkOW0rTlkwcnNZbjdDZEV4UDNVR2FrOWtZMXN2Vzh0S2lXRnhRTWIzRFly?=
 =?utf-8?B?TENyWFRsUVdpVGxKblVSaHNYd1ZGR1kyY1FZZ2s2dGREMlM1MHIyOWZJdWpQ?=
 =?utf-8?B?Zkx4ZVVEQ3FhekpVenlxSkhzeWZCZzRhVDFwbVY4U3ZySytyRkYwdTVRNkUw?=
 =?utf-8?B?UUFnM3k3c0ZaaTkvcjllWmdqeG1WOTA1U25tbDRITmFic29EVk1FS0xYNVdH?=
 =?utf-8?B?TnFuTHM3NWlnU3Fkb3A3Yi9nb0NvTW95blZaaGVOYzZ2TFFIcVNzd3lvNzFh?=
 =?utf-8?B?Vkord3pZZGhzSE10b2pzaVh2SHhTTEl6NWs0a1NrWGE3R0JVK0h2cXhJVXZR?=
 =?utf-8?B?VzBMZTJ5YjdKaEE4WVY2enZTNzYvR1FOQXorQmdTUDd6Q0lUVmZabFRxMTg3?=
 =?utf-8?B?SVZXbHNzclVrZVhXVWRDMHZkcjRCTzQ4WTVLNUxsMWZjQm1scElUVjFuVFlG?=
 =?utf-8?B?MFZzeGlzK0V3blNoY2VsMDZmRzB3ZGx0NXNZRnV4SWplRFJXWFMwbDI0WXJm?=
 =?utf-8?B?NWFaWFpUWjVMQStSVjIvb3UxT0RaZUZMK280RFczS2hYV2hVNDZ2STV5U3l3?=
 =?utf-8?B?U0lPc0pGS2FuU0NNR0x1d3JYemlKNTNsOWdGUE84YktwQjdKeDRUWEM1R0hm?=
 =?utf-8?B?dkNJTFduVnI0T0ZRZlZWWkIyUDlsWllJUVRSU1JTOFJlZFBCUDlPMTd2dUR0?=
 =?utf-8?B?Uys1d1hiL0FVZDZkdHdsRUluQ1VpZS8xM3hySHNxZXQrbVBha09hUlNEcTd1?=
 =?utf-8?B?a1d4eEdFYWt4Z2RkdG5YT1Z5L1Q1ZjVudStlVkJhNDcwRERhUEloeDJMRFpJ?=
 =?utf-8?B?WmtPSnQ5THR4NVI0RUhKTnZpbG5vaGU0dDNCY0tjeVQ0dmhrUkt2cWE0TFk4?=
 =?utf-8?B?K05UeExPZW1PbzdBVzhZRlcvbjVNRzNaVFlocjNyb21rbVgzVkE0bklkaEdL?=
 =?utf-8?B?QWNNeVB6eXdDbGtueWxMRlA3K2dNWGppUUQrYVdFRjM1RHE3WTNTQlZHbW55?=
 =?utf-8?B?U0FhMVdpZzkvU3YyUU5BMjBBSCtzYnhTbnVRdlh3YlNyMUc4M3YzMTlBSWRQ?=
 =?utf-8?B?SEt2eGIyS0VYNU1wNFE5L1QyV1E1WGxqajFlK1pzdThrcng4NGJ2N2pGMXQ4?=
 =?utf-8?B?NnFHS01PY0JNNFo3bFdIYVVPdWN4VWE1UDYvazd6dTkveGdQdSt1ZGRqMG5Z?=
 =?utf-8?B?Ty9sODVsVHNnaWM4SzNIaWtDY2o1K0RXRHhmRUUwY2JYMmFvNlhUY001elJa?=
 =?utf-8?Q?lpyXY2JHaFWy6XqaVr2V+zg0D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZFSJC4/wmu1OAerZknvC8p1fcK9o4UmGAIoN+id4XjlxIup4WCXWR2nFzSkCij7IZe2STFR4FPmwbbyHotryPTFivbSFFxv0m/JSZTzDdC+92twDFh49o8w6F7pUh4KktCCDBf5HNRkd2z4pKeYZMxjNZB/TzASeaGUGEf7O9DGz3nwpvvvuz2W0VFGmA+N1zqoYsgv/3NKbWWhBxObNqx2PSPJaCqn0asEgynrM+hCcWE3YsPAW+21vvPUoIGSolBC5J0atWJp5fB2ppiaTNbxRaifZF+HKR+RbLQoj/fA4TDM34QbPq14kpvOV6AjeAzGTgZma/NgPwh608JevjF30wfVMPXzXN83al9r+AgjD3N0ucV40UQHV3lqLCiSoLZTwWMTybryxgBlJLtEjGKo2RFuNGvTIQjvTuBee3ofhBNZsMOUJzpNdq3ydAf2Ynr2CmBfV4x+TOi/o0mK45TlE3RMtMeY+QWckdafR7qMzS4e4KTOP7Rk+5PypOJ6iqo9RDMzED/CEzB584AY8vFQmr3wFbtzL7MaROIGAS7w+SUn/SV3bHx+Ypm409fl0R6etKnCzANKCT5liHjNS+cWgw8YYzxSRIstvv/SO10g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf3c0e8-d8ab-4897-ea58-08dd25caf860
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 16:33:03.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBoGonJP5U7qlRxwr+pzdeBIjbYXFfy0eWUScfEXUCM+rGhEttjRiAhLnWhsaBMuNHizr7+XAGDOFWFmveSkLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-26_07,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412260147
X-Proofpoint-GUID: XlxlxArCQJZ1HZOGJcful4_sPjIrpqxy
X-Proofpoint-ORIG-GUID: XlxlxArCQJZ1HZOGJcful4_sPjIrpqxy

On 12/26/24 11:24 AM, Salvatore Bonaccorso wrote:
> Hi Jur,
> 
> On Mon, Dec 09, 2024 at 04:50:05PM +0000, Jur van der Burg via Bugspray Bot wrote:
>> Jur van der Burg writes via Kernel.org Bugzilla:
>>
>> I tried kernel 6.10.1 and that one is ok. In the mean time I
>> upgraded nfs-utils from 2.5.1 to 2.8.1 which seems to fix the issue.
>> Sorry for the noise, case closed.
>>
>> View: https://bugzilla.kernel.org/show_bug.cgi?id=219580#c2
>> You can reply to this message to join the discussion.
> 
> Are you sure this is solved? I got hit by this today after trying to
> check the report from another Debian user:
> 
> https://bugs.debian.org/1091439
> the earlier report was
> https://bugs.debian.org/1087900
> 
> Surprisingly I managed to hit this, after:
> 
> Doing a fresh Debian installation with Debian unstable, rebooting
> after installation. The running kernel is 6.12.6-1 (but now believe it
> might be hit in any sufficient earlier version):
> 
> Notably, in kernel-log I see as well
> 
> [   50.295209] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [   52.158301] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> [   52.158333] NFSD: Using legacy client tracking operations.

Hi Salvatore,

If you no longer provision nfsdcltrack in user space, then you want to
set CONFIG_NFSD_LEGACY_CLIENT_TRACKING to 'N' in your kernel config.

Otherwise, Scott Mayhew is the area expert (cc'd).


> [   52.158337] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> 
> Normally it should have been (if using the more modern client racking
> operations):
> 
> 
> [  145.851951] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [  146.891838] NFSD: Using nfsdcld client tracking operations.
> [  146.891844] NFSD: no clients to reclaim, skipping NFSv4 grace period (net f0000000)
> 
> I can reproduce it if I do in following order:
> 
> Install Debian unstable, reboot after installation.
> 
> Install nfs-kernel-server package with its dependencies.
> 
> In our case this is nfs-utils upstream already at 2.8.2.
> 
> I notice the following observation: When installing under this
> condition the package freshly there is not yet a valid:
> 
> /var/lib/nfs/nfsdcld/main.sqlite
> 
> for the nfsdcld, and so it used the legacy client tracking.
> 
> At this point we get the splat. if before installing the packages I
> initialize /var/lib/nfs/nfsdcld/main.sqlite:
> 
> mkdir -p /var/lib/nfs/nfsdcld
> chmod -c 0700 /var/lib/nfs/nfsdcld/
> 
> and
> 
> sqlite3 /var/lib/nfs/nfsdcld/main.sqlite <<SQL
> CREATE TABLE parameters (key TEXT PRIMARY KEY, value TEXT);
> CREATE TABLE grace (current INTEGER , recovery INTEGER);
> INSERT OR FAIL INTO grace values (1, 0);
> INSERT OR FAIL INTO parameters values ("version", "4");
> INSERT OR FAIL INTO parameters values ("first_time", "1");
> SQL
> 
> So to me it looks that the problem arises from actually starting the
> services were we have to fallback to the legacy method as we cannot
> use yet nfsdcld.
> 
> One other observation: if while installing the package the nfsdcltrack
> utility is available and the these NFS client tracking methods are
> availabe, it seems that the issue is not hit, and dmesg shows
> 
> [  216.206678] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [  218.215961] NFSD: Using UMH upcall client tracking operations.
> [  218.218074] NFSD: Using UMH upcall client tracking operations.
> [  218.218078] NFSD: starting 90-second grace period (net f0000000)
> 
> In the most recent nfs-utils packages we do actually not install
> nfsdcltrack anymore as as I understand it's encouraged to move away
> form it as nfsdcld is available.
> 
> Regards,
> Salvatore


-- 
Chuck Lever

