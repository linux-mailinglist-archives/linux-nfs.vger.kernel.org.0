Return-Path: <linux-nfs+bounces-10270-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9676A3F977
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E918619E5
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86771E7C19;
	Fri, 21 Feb 2025 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lCJ0dq8P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kvTgnAqc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A081E7640
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152831; cv=fail; b=AGx+7lHbQpWgd8X08Avtn6RxkxRPQ8Z8bFRs6ThQEmYKjcUr1X4xs8RdayrfSF4HVAnGQqKCBhhC5JdxMvQbf0acRo84TIyxeMQQJZoV5mIxGLEH/UDDpvryKF/ynzzZFDpLf/C8ChdOLtbAcMm1Hm9fOPrOITSYDAjGBbTlflo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152831; c=relaxed/simple;
	bh=GqM9jyo9EQF0IhYzoc3k1e/0FQJcP9B1Aoob2/WmyoA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sE9bShtwYhl78ssPrQ3yID4TqG+EbCRQZz9yM2jD3TB032Tz3fToUgZOXa42luYTm0NVvF1trtlR5bpTBXKXJug1VvFZtf1cnMsQDX9dtMHTkaRJi3ZDFjROqYBXOO0JMfaW9FSKlf7R1HoHM60TYUAnUneR68+iQk71AZqVDNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lCJ0dq8P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kvTgnAqc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fgUV029949;
	Fri, 21 Feb 2025 15:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=chvM6kZ6xuFkeQi5dCP9R30Kd7Cexnp6YVLG6DMos6A=; b=
	lCJ0dq8PECLei/8C9e8DO2NmDzLzI7uBS3sZs4QWSRiPX/SmtJg+ENJ16vPj7wko
	ztwBK4VlYUHAHIo14pt9JCHUGUyW1ECzyXJhiU/SeXetwtuCC0fWp89PsALr/rVk
	xvhMNFfKbBkVBoPQMM7aphxyL8Xj/AMnwAGCSGp+XFgRQ/2gQBrTqd0HwJ289pVy
	PuTP7KT9HOijs3Nidw5h3icobSNOqS6NwcDCuLtQrhyG0o1vBP2U4ITlg0netKox
	QEXt/O9aGu7kcs9FUQW+Q8l8vh+hUyYGTs2h91AU0NeuJAAY8vSpYXY3GdZIhrmc
	PgzfPq1/iPBxgpQuycGvWA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n6fx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 15:47:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LELsrS010616;
	Fri, 21 Feb 2025 15:47:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07gv31j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 15:47:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COfZli9wVdr7uTxq7AL67wkJr2GmDc8MoA5fHW57Ij6DGuCehGLHfbCwFnymAcsodjBtLpjnrioSY7a+4qyc1K+TyOMk/7gJuvn0hnHcfIB71WHY8/uH8tNF/go3eiHtF4Judjd5mcFQz3MpWzEi9mOIeBb6aE/zsJlrSP/qqbAObqRvDzC+Xq4fqWQGY6HUXgqJSx98/M9F6BfLg/+WvvU5L7bPDKjczOJoirXjcPNdA/KO+z+JpYaevpHHjBK3uJt3K+6By4gd+aCZAfC92i5eqt3KnJMuC3vo2JnPFE7yNatPxO7UiRBgFI1/ZqoVqPT9M3njT/Cx80rznA7ABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chvM6kZ6xuFkeQi5dCP9R30Kd7Cexnp6YVLG6DMos6A=;
 b=MCJuLJLigYTGzKCMDJaDuKLXKbAgKFTpuPThDytqHaSdt4d47FYCrXBkuB7WC3C9K7UVSFoeWABds/7L4QlMO64BEmq3Na28Vyfn/bd3y8Mj0MszxAXNgFevINFKizIELjdqg2b9a6SFWShGFNnLRmdODzr/HvMKQtR4D+0QRODooGuAhGxgN/t9bhNKRazHPJ+nq30QOxdnaJdzz2Kvh6ekTjV+6IrcYDg2BYjTGBczXMef1qhQhW0vvmRnjABpSDQyvkj1OUkDPzHIq3aG/XRiINOKKtcajRQ9PcVyY6ce/aHk/SGmkdb7jduFl/b/i+rCum5QwAZwr9waDI4p8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chvM6kZ6xuFkeQi5dCP9R30Kd7Cexnp6YVLG6DMos6A=;
 b=kvTgnAqcyiXegq+RS/OMAQoPHc5QeZIPJur2hT9QmCH4+u9kZRkLB0HEtHk5N3mzfzIDf9Z4v3HojTdermc8oOdoW+f0zJBVrMc0D9KIQHRLkuD8P256mJyLjMTa04OUmbDlEFwxGU5BRMGwJWp5R4xZ6JX/HfvMXs0OPeel+gk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4992.namprd10.prod.outlook.com (2603:10b6:5:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 15:46:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 15:46:52 +0000
Message-ID: <6bd2aa18-e52b-47e6-9151-4ff80d1a39b8@oracle.com>
Date: Fri, 21 Feb 2025 10:46:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd: add the ability to enable use of RWF_DONTCACHE for all nfsd
 IO
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, axboe@kernel.dk
References: <20250220171205.12092-1-snitzer@kernel.org>
 <ce92e5f6-d7cb-47ef-ad96-d334212a51f1@oracle.com>
 <Z7iVdHcnGveg-gbg@kernel.org>
 <b101b927807cc30ce284d6be9aca5cbb92da8f94.camel@kernel.org>
 <Z7idYDSHD_hcLL9b@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z7idYDSHD_hcLL9b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:610:118::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4992:EE_
X-MS-Office365-Filtering-Correlation-Id: a2011035-884f-4303-9e0d-08dd528ef634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVpVMEsrcVBTcTh3YVF1V3piN3N5Ynl6aE4zaThrTnRrOWxlM1RXMkhSa0FT?=
 =?utf-8?B?djZTejJJZDFrVWtTWjZzUHc5M2pzcmRnOWI3ckU3L2p2VDhmd0Q2TmlTTGZY?=
 =?utf-8?B?aWFpYnhWaXhoZWVXbmxwYllvelkyZEY0WVFqQzJaYzRpN3VFbmd4N0xRNVN6?=
 =?utf-8?B?U2VtdVR4UVI2YVhxU0hxMEJUQXFWT21ZSzdQT1NjQ0Y5R1BkR01zUGVXMUpR?=
 =?utf-8?B?WXRsMzY1ajh2WlEySmpxdDl5MWtQbElmRW1sMkxWTTdSUUMzK0tqM211K2dH?=
 =?utf-8?B?U0VYT3grSmJDQXZNQmZrL3Q3T2hYSTdVVVhzUzhPVVBDUkRoUTlFeFpiMVFu?=
 =?utf-8?B?MC9IY3Z1L095QTVORXNCZks2K0Npa0lEVnBkSlFaT3Q2SmZSZWZOSk90SWVz?=
 =?utf-8?B?WXF4MDdGSit1S3JtY0x1UUk5UTIxYjZXSGdkS1oxbXdiTGNmSVpXYlZtdk9S?=
 =?utf-8?B?TDlXb0pTTmJQNWplMkMwUlNZbFVoMlNSSjlRREU3dGRyR0g2cFhkZzRZR0Z5?=
 =?utf-8?B?QXcrVUZCdm96bk1zK1REOFBMVlJFNzliZjdWN2N0ZVlPSmtiZ1dMZHFua3c0?=
 =?utf-8?B?cmpndG1sZzRpSHozUE1Tc2x5ekRlSENUdWc2dGV5RGJGZU1iOVNqaDlZZkpM?=
 =?utf-8?B?Z3B2bTBNSmNhcVY0S3BjQmVBV0RaUHRTTTl0K0VpYmNhdVZ2d2JKbjVsVk9L?=
 =?utf-8?B?dXJna2FiQ1RrYVdXSU5EYzJtY2lBL25uRTlPTk15TlBwSHRaRWhWT0VmaUhx?=
 =?utf-8?B?UzRWNXM0by9kZWdQUmtyRGpRby9yZU4zNnJkOXJsMG81bHN5b1BjR3FuL2NB?=
 =?utf-8?B?MmJsZzVlZE1ReXBhNG9aMWU1SXhsUFhyVnZNMUxGRUlKb0VXWFluUUEybDdr?=
 =?utf-8?B?WG5LcFhiUGFCOFZuRlI5TGFDUmtUVzkyaXZyZ0hFbmdNYUNaNjlmYzJRVmdp?=
 =?utf-8?B?MTN1ZzVyRzJjZ1dXQUZlMi9sOW1Jay9OMWVQbmswQWJRaTRSWG9UaVhONGJR?=
 =?utf-8?B?aXlXVVpBZkdBOEI4S2U4UVkyT3hwaC9BUVVzNmJ5OGdJdVFHRzVGWXJuM1B3?=
 =?utf-8?B?R09RbHIrR1NQcm45LytzVTlERFhLSzFrOTVBclU5eGRjUWs1NUt5NElSNVFE?=
 =?utf-8?B?YloxUmtVZGkxcE9TcnU0VFZiK1h5ZWhMd3MvL1pnU0lBdlMzMkdKRXl2SWhL?=
 =?utf-8?B?Z2V4dTdzVklDL0JMVXR2dTRuSmQ3VzdMNGJ1bXVteGcycXNOWFhmYVp5dnVI?=
 =?utf-8?B?OEd0UW11TWFCM0t3TzVjS3REOFRXc1dxNzMrcWtaK2VjVDhaV0lpb2JjWUFY?=
 =?utf-8?B?bHlBUmFrbEJZbkVadHZYZFNtVzJUTHMvdG9zdlc0aXZTb0VpQUpQNmI0OXNz?=
 =?utf-8?B?SGsxTTd6aE1TaE9NRDA1YmVxczFXSnhIVElLT3FPd0cveW13MDljcnJPd0Jh?=
 =?utf-8?B?WmhTLzkyWGdUOXVaL3ZXa241aUQ2NEo1TnhsY0sxTVc2MGxLY09BY2xIN1dS?=
 =?utf-8?B?dktLbmJNTnRZcXVpUm1NNnYvRnlhQmRkdjVDdmdzbjBwREIvKzZVQWIxbS9G?=
 =?utf-8?B?UFZsNTRKWCtGcmJzdHpENm1Zeklubm5XS1ZMOC82aDFVcXZmRmprcHY1SU5k?=
 =?utf-8?B?MUx0emc0aW9vT3NpUFNuM2JrdkxWdWxMbkJqRDVCcDYxRHVwVjBCc05uQWU3?=
 =?utf-8?B?TUlOaitNbHlDU2JrenlWSVIyWEluTHNUS0ZzeUVHcnF0Uk9oVzYzQjBnQmlk?=
 =?utf-8?B?dkZxL09nWjhSUk5Pekd4RjhKVnc1aWFUOTZYbjA1ZGRjWi9FM3BlOWZ2dlpo?=
 =?utf-8?B?SmFlenFtd3Y5MHpvdTNtMnZoRExXUi9oM1lxc1liaXlROFhIVU96a1llMmVx?=
 =?utf-8?Q?4ow0YngnHUtMF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlBQczdtUUdhd0QrWUFiVHNmTXJ4ejBtSmFHQUhBTXpiUnVnN0dmSFRSaUhC?=
 =?utf-8?B?dVJQYVY4UjJ3eS93eVhORGJWQ21XbnlmL1U4cTEvUEZUN0JORmFVL2d0MXkv?=
 =?utf-8?B?aTRyMmh3U0dWRUxRRWUzVm5DQnBWTzJGS2lkNGdZa1ZvUjVNR2RHaXBYa1JW?=
 =?utf-8?B?VW5tZ0JtTW94Zk1Kcll0eThBVVJqMkZIYVdpOUpacTZVZ0FNK0YrZUQzVS9B?=
 =?utf-8?B?WkQzTGltR1NxTWxzUjU1U3BtNnorTytncUtNZzFtN1U4WUl4V1E0TU9rL2VB?=
 =?utf-8?B?ZkViRkl6b2xVbWJ1OGVrUmZhMzFlcGJjME9VdC80MUVaWGN5UTYvNmRKbTJD?=
 =?utf-8?B?c2pKd3JydEc4b01pK1NxR1lBOWlueWJER0VIRVVBWVBoRkZsZVV5Yit3Y3BI?=
 =?utf-8?B?b1lYR0Z0SC8yZGFGWXAyUXcyV2xFdTdaWDBCSm94QzRlZmJKbk9hVGtUWE8x?=
 =?utf-8?B?aWFGbjR5TVBpMmZCbkpBSE9CU1JkRGRzdDN4RjdZM1lxWG5QRzdqQWVnY28y?=
 =?utf-8?B?NHI2MWVxQlM3T3V5VXlKMTYxdEx5OGg5LzRTb1k5ekN0bVpUd0cwQ010dDY5?=
 =?utf-8?B?MDFuU3dEYnRob0JIcVIyOUx0N1NmOUpkOEhNSDhsL3cxZkJHd2tCWjRiOWxz?=
 =?utf-8?B?dyttaXNreFVXMkVkQy9jWHN4ODJMUndLYTRYTG40K1VDamwra2xVNVZXZmVR?=
 =?utf-8?B?R2JJQW94dzYxN2oyREUyb1AwdjZLdis0ODVLWUpWcm90c3daaytFaERtMTRK?=
 =?utf-8?B?R2tpMXJBalQ4TjgvWDdEY2JnQ05WUk9naThObiswUkVzc1A0Z0JEU0hJcWFJ?=
 =?utf-8?B?QlV4VVNiZjdDdHdDdm5LaW81RWxmTHpic0sxVk90SlpvNW16aDEraVRVSjh4?=
 =?utf-8?B?NUpTcFRFcVhPdzV3c2VwUzFCZVNyVlZjVWhFVFdhS1NieU9UMG1sekFzYUJu?=
 =?utf-8?B?UXN0dXFubTE1dnF5ejFWRndFSmtsOE1oSExpTjJpK0EyR3Z4R3AxYnR4NTFO?=
 =?utf-8?B?RHNRQnlmOWdZUVJPQUUycUVnQzVBbFRjZWVITExqb0lXVVUrR0VTbm1YZ3Iw?=
 =?utf-8?B?ZEVFWjZsaWt0Z09CYTI5a21zL0pHYXdadHdxNXVISDdCdzdmWC9KSTdpWWEx?=
 =?utf-8?B?OW9WMmxGeSt4NUpNaWZiN2xSVmU1dDRUZExpR3M0eFhJV3V1Y2V3cFkyUitz?=
 =?utf-8?B?Y1c5QVZHSVRCZ2NlM2FaUS96K1MrS01pZzJtUW9tS3J3ckxUQVdQa2lIZzF6?=
 =?utf-8?B?Qm42TW91MnozVGdCWG5JS05Ha2ZWVCtseWZRbUVHZFg1K0I3NVMrOVlQWVFD?=
 =?utf-8?B?MjdiZHJjTVVGTWNtZGhibzVYZ2NCdytCMWpZVzlqWEVDQVE5a3JpR0VJSWVq?=
 =?utf-8?B?SFgzQkhNd3A5VndML1RaamR0WGxkREJBcHFNNHRPaFdoZnBrS2t3M0wwc25S?=
 =?utf-8?B?MDNpRjdCd0Z0dmkyTHczcGZJNTFtaFVBclFGNXlhZFBFMng5ektTRFJlU2o5?=
 =?utf-8?B?Z3pHemN2K2hKNjE0WHJTajdraytlR3JvTjZvY0JGbC84Mm8ydVNjOTNYbVhz?=
 =?utf-8?B?akFFc1AxQlRiQytmTGxhbDN2YlNxaDRGdGswaDZ3NW5FMUxIVXBhTFp6Tm9i?=
 =?utf-8?B?OE5BeTNnNTMzSzJOMGFXSjRxT2ZaOEZnQ2E5Y3RGRE9zSXJyaHhQTTAxV1Fo?=
 =?utf-8?B?VUJFWUhHYTFHNmVpUGdQdCs5YVU1S3VuMXUrUi9lNFEyZXB0aDBPTS9raUhE?=
 =?utf-8?B?VTFXNklCa1VRTXR5RS9FYmFab0NsMDNjZDgyUlBDR1NHTytSOVdSbWpzOGdG?=
 =?utf-8?B?dzVtdkE4VExBcitYMWdNbmJLUC93QzBxRGhMaWswVjNDT3c2aWlibFg3Y3d2?=
 =?utf-8?B?WFBoWGJrWjZSMlYxVTZpZmhWOVh1UkJ0eit3cm5YK1A1eUR5Sm81OFY5QnZF?=
 =?utf-8?B?MnVnazZ2bUxjMVhyN2paS2dkQUkweWpTVjlGajU2blhlM09OdlNKZ0Mza01r?=
 =?utf-8?B?OE5XMkphSklRb1NSZGxxdW92Ty9XdE05Qng1Q3ZwUEppUk5XaVd0UDRBbWVW?=
 =?utf-8?B?NkZEZDZWU2Q5cnRMZzAvVUNuY29qSXI5bjk0ZnVnVnJhZGwrM1owb1R5VFFK?=
 =?utf-8?B?cjliT1kyUkNBNXZlUnJjU3JjYWd2Y2FvYUNFZDhyaFk3RTBrbHk0MllCTHZ0?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZkWZ62xL02spuKSlAadqY32RfXY6OLk2WvD0qniNn+xp1AbTWkGZHjfQ3lMFC/m5mIdvI8XZnyf2YscFSNB2BBuOg9945UNqJsJXBFN2JYZB2jEJEuhLv7YBALIgXxxaNojWRgg0F/Nw1XTNwl/TGh4pLNxAf33ztX1cJ55IbrEtiqfMnrRIn9XaVBQzgzVqMU2uZWxybfCd0tg6YKMt38CxtQL8bBq7OOHp1sSVjxG6DF6EIv0Sc2H0SC0Cuy1Yfj8uvL+OUYqum/lbZAPG/MQZzlBzLdlfIPzhQ48H2q+CRTTdgeGXxnVte/JrsCMp3Pt/rUsldSkKQHfp1Mt4GJn9u6q9W5jMb5yWs/+pUWc55Cx/FRAe5KzlllYwVWxQW2brsp2fGXsK5O2+mmKuiQoFjCrh9ZAC/0+kQnozq1Aa3mMVyEfdaWCmbnTtZnyZaoLmtETl4BNtGbNcP6/xXoxRDXOJt68fC2/53eyUfWoRgByIQVplXpdlcuF7wGTX1XEntKDwejtmFoUcEABDPR9dyXexAW4CTwZC3usMg5XnwcBpYjASyDuEVF6C+yjS89q/UUJnVT8mtkRox2tLDEThcdwn0/vv5FwNIwq7uoU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2011035-884f-4303-9e0d-08dd528ef634
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:46:52.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldrT7C++raam3U9BZAnlU2adkbFj6Hky9qtknIAZtbnfrF1E1OXSmy/iXXztAhZoCX79FinxxYRlP7B/l+hfbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210112
X-Proofpoint-ORIG-GUID: P0DJMXGDsji379wb08A_iLJ0lFRfvKHs
X-Proofpoint-GUID: P0DJMXGDsji379wb08A_iLJ0lFRfvKHs

On 2/21/25 10:36 AM, Mike Snitzer wrote:
> On Fri, Feb 21, 2025 at 10:25:03AM -0500, Jeff Layton wrote:
>> On Fri, 2025-02-21 at 10:02 -0500, Mike Snitzer wrote:
>>> My intent was to make 6.14's DONTCACHE feature able to be tested in
>>> the context of nfsd in a no-frills way.  I realize adding the
>>> nfsd_dontcache knob skews toward too raw, lacks polish.  But I'm
>>> inclined to expose such course-grained opt-in knobs to encourage
>>> others' discovery (and answers to some of the questions you pose
>>> below).  I also hope to enlist all NFSD reviewers' help in
>>> categorizing/documenting where DONTCACHE helps/hurts. ;)
>>>
>>> And I agree that ultimately per-export control is needed.  I'll take
>>> the time to implement that, hopeful to have something more suitable in
>>> time for LSF.
>>
>> Would it make more sense to hook DONTCACHE up to the IO_ADVISE
>> operation in RFC7862? IO_ADVISE4_NOREUSE sounds like it has similar
>> meaning? That would give the clients a way to do this on a per-open
>> basis.
> 
> Just thinking aloud here but: Using a DONTCACHE scalpel on a per open
> basis quite likely wouldn't provide the required page reclaim relief
> if the server is being hammered with normal buffered IO.  Sure that
> particular DONTCACHE IO wouldn't contribute to the problem but it
> would still be impacted by those not opting to use DONTCACHE on entry
> to the server due to needing pages for its DONTCACHE buffered IO.

For this initial work, which is to provide a mechanism for
experimentation, IMO exposing the setting to clients won't be all
that helpful.

But there are some applications/workloads on clients where exposure
could be beneficial -- for instance, a backup job, where NFSD would
benefit by knowing it doesn't have to maintain the job's written data in
its page cache. I regard that as a later evolutionary improvement,
though.

Jorge proposed adding the NFSv4.2 IO_ADVISE operation to NFSD, but I
think we first need to a) work out and document appropriate semantics
for each hint, because the spec does not provide specifics, and b)
perform some extensive benchmarking to understand their value and
impact.


-- 
Chuck Lever

