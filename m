Return-Path: <linux-nfs+bounces-9322-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 019DBA142CE
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 21:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4BF18857F1
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 20:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36322FAF8;
	Thu, 16 Jan 2025 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c4hqItcT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vs8WxHpZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB624A7EE
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058085; cv=fail; b=aMWRik7mB6j+7anScxGMZEnLGwTIDvBWT8N/gBjec5qM5KgM6OIPyF/y9r4NJuybEYL84jjJKylyK2OdSPjkoWIZ1mAHWj2IzxHsKE7SydYrGCA00zypR0DqsZSzCVOFtU5h3+zRR2QOPuw1WmvtWeP0MPs9gxlNKfmWs8ySM68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058085; c=relaxed/simple;
	bh=Z4qH/flwx6+HYIt52mvLeXezRnuoXKGHXjYXXqIGEz4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QNBdwg+prl/Da/2adhWJbhDYbPCHWjNFRhSvfVuMoQHa6L3b58Jexy0XcXHO7guDVvBKazzZ+vQSqkhfQh126uJrpITh68JLPqcA2+6ElRC3DGmQaIWN8Ka8i/hsTCvgDe4df8yli4KCeM6yA6y1fLBRoeXq0MNcYe5qk2OufPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c4hqItcT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vs8WxHpZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GJBmY3012012;
	Thu, 16 Jan 2025 20:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PdvzkxZ0hY/56Wb+QsBn0FKhX1kRZErhMGrlQPxe4MA=; b=
	c4hqItcTZOKkXcoszyx8f/7Ax6SPcIdnKST0r+3k+nRLL9X5REKWTfr8uub/CSPf
	5y1sxlmIYO6vRzkLMiJkZl5vTA4RaHZyipV24pMxHNEC517ssPJRkgd//lbI3uki
	8UuoVc2uxOLq7DaqLAvVOGLnRsMKIpL7NHE/NusEhqbnPSlCPyPGE+TYU5oQADgq
	k5ggtjBZkaUkLOJeAt3aOYx0uLsSk0OlAMH0JO3RQuHsYjzG4osAqMVWhjOKcUz7
	5V9c/Q+Yw7i4vluJb8wQd30lgDf1dGOHEJ6a0eGEOPgDb0tZb7AH2YZWyBGkJgx/
	LoHf+iqLRL0/Gl4ibjNRlA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443g8sk4kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 20:07:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GIdoD3032305;
	Thu, 16 Jan 2025 20:07:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3b9muc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 20:07:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+X4zFopqYg4KDCrFex3NnbY86ebCK6WhwLJTbXfq5NHx6uBkRxP5j3BoqL8voHqjOplk/TIKm6f0DxUPtg2syd49Qy5ReO9TZDkSgpT49eUTOXLDnbu1yAYhD1+h0Uyowv1gAfhKgC1N5Rrz6/mvX0WvsQngNt83s+AfNvVFRTdyniAIOd2nB1bbj8bkXgcLj7wtQaVpwl9juQi1KPNQxlZrJmfxEBJyG9c+1imfb0pnNWxEfMlpmqiNA2L4rMxxZooh9GbJ4GSTXkq6K1JTiWRR8TmXqAeqAOSsdWNj8TztlZina51luov1Nv8rjyVKtT3IydW+c3eNwZGIubIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdvzkxZ0hY/56Wb+QsBn0FKhX1kRZErhMGrlQPxe4MA=;
 b=Wp3VzfYZsS3pa4wVMbUe8vMJ4FaW4bvg32dvLTCPs6N17aQhK9/Rrf/a/+hmc1ZkGqPVcf5BTzzqA3H6MlykF5GtteILOplna9qcees6/d0E56G+xMRvTUl4PaPyjebsCLROVhEnEzv4KqYP6lwfOggDDFR7CeiCxphx7roGGVVzXxA4tBkh1VzMEWoA2lzb5Op7B/ykNiMe1H66DG0OSHbCiZ7aBf2VyhLD3KotDihLIpwlW+U1QXMGgu1a53/+TNnwubqeJPvHvnzdSIqt20tsL3LNdwpwCHIKXhnY/ez/lsZz3HioiKQq8GR6IJK9RGi2nCA52yHtMl8Od8Mfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdvzkxZ0hY/56Wb+QsBn0FKhX1kRZErhMGrlQPxe4MA=;
 b=Vs8WxHpZPEc5lFHCXgxBhIDr0ztOYKd6xN2pBNOJjcqY/CNeVJl1K1P0yvrrvb+mgahR4lFzN4f/L5vmSmNWMjkQGbIb0pyErSsAsxCN9XZOYE/9M/O12GHrgXqaE6X4uXWF9A5aC3GOCdza1QByrik5hl7jubTSEV8raoLwqWA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Thu, 16 Jan
 2025 20:07:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 20:07:35 +0000
Message-ID: <7428f722-3456-42e1-91ba-7cb52468f364@oracle.com>
Date: Thu, 16 Jan 2025 15:07:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd blocks indefinitely in nfsd4_destroy_session
To: Pellegrin Baptiste <Baptiste.Pellegrin@ac-grenoble.fr>,
        Rik Theys <rik.theys@gmail.com>,
        Christian Herzog <herzog@phys.ethz.ch>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Harald Dunkel <harald.dunkel@aixigo.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Martin Svec <martin.svec@zoner.cz>,
        Michael Gernoth <debian@zerfleddert.de>,
        Jeff Layton <jlayton@kernel.org>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <Z2vNQ6HXfG_LqBQc@eldamar.lan>
 <ecdae86c-2954-4aca-bf1c-f95408ad0ad4@oracle.com>
 <Z32ZzQiKfEeVoyfU@eldamar.lan>
 <3cdcf2ee-46b3-463d-bc14-0f44062c0bd0@oracle.com>
 <Z36RshcsxU1xFj_X@phys.ethz.ch>
 <7fb711b1-c557-48de-bf91-d522bdbcc575@oracle.com>
 <Z3-5fOEXTSZvmM8F@phys.ethz.ch>
 <36f4892e1332e2322ab46e1343316eb187d78025.camel@kernel.org>
 <a4a3aca4-3e53-4537-a6f5-a46dc2258708@oracle.com>
 <f0705a65549ef253.67823675@ac-grenoble.fr>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <f0705a65549ef253.67823675@ac-grenoble.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:610:b2::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f0e75e-362e-4c58-cbbf-08dd36696b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEVITVFENXF6d1kyV1JWUkNtMXgzRVZhcFJ0TFExNjBpaWFXY0tNbVdUOUpB?=
 =?utf-8?B?R09hSTJNUUdZSjJkVUxlQXZlcDMxOXNKbjcvUXFsQ1BkekNGdFNzQS9vN2RD?=
 =?utf-8?B?RmorTFNaSUNUSUgyNUxTQWlieTQ5S1hEaThTYmlpU1NWRTRUUS9yTHFHclhh?=
 =?utf-8?B?dmZIY1FoMFZkbnc1RllKRDZwTmVNb09XS3lrYkpLM05UNEtZTy94c3VybmVZ?=
 =?utf-8?B?RVFwQkpLMEJZMGd1N3FEOG1Ha2x3blZERGJOUjlsSExCMk10eWZZdEwzTzFr?=
 =?utf-8?B?WkU2WVVuR2RIcEFudnhpWkdudzlvRXpmT1c0dzU5V3BsZmVBOWxEdllsT0No?=
 =?utf-8?B?Z1lQN0NwZkZSdUQ2dUxqU3lrSHVhZDgrbEpEd0VpWFk0Mi9OMXpHMFBLU3A5?=
 =?utf-8?B?aXROU3Y2S0NBUlp0bVgvZG5rTWtYeDNEbEJROVBROVAwTkhVOEVpUnhBUW5O?=
 =?utf-8?B?SW93cVBMTTE3VFF6NmRubjBRWVFFT3lsVU9xMWFVcDd6UFF1SW1LTHlYLzJ2?=
 =?utf-8?B?cEt6SlJBL3ExRE5vbjZjUW5JYmtIZmxUaEVERkRDRUZFRUN2cVVKbkhuTWEr?=
 =?utf-8?B?eDJDTVgzeWt3VjY3Z0ZaaURRb1NPZDM0R0ljTXVqc0ljdklhUUxuREM4UUJv?=
 =?utf-8?B?Zm8yeU5Cd2l2UllQWVVzOEZCMDdvaitjRi9FZVhGQ2dJa3EyYllTOUlPdW5m?=
 =?utf-8?B?WWNYTFVobWRud0ovbFZOZ0YySjlJTHE3MlJYTmpuQXFkM2xVVHI0T0JIenV5?=
 =?utf-8?B?NGtvVGlQd083Q252VTNrbFg4T3hUYjMwS1pZK2pmVVZBT3RiL3NYM1BZa2VZ?=
 =?utf-8?B?a1pFRzR6Q1FyL281WGdJemJqaC92VzRDdjZLazVNeDNGUFN6L1QyOUppQktT?=
 =?utf-8?B?UE05OUh0Q2dMQzEzZ2pMS1pZR1A3UUdlK3Z5eS9QaE9Td2JVTTJFbVM4bGRQ?=
 =?utf-8?B?TlJuOCtFcHRpSjZzL3ZpdmdzQjFmNkFLM0hCYldQeDdjU2YrWU9kOEVkMlNq?=
 =?utf-8?B?MC9GbVF1cFIrWTBPZk9mT3IxUzVOd3FqSW55aG9sT1pQNHoycGVSRmpqWG54?=
 =?utf-8?B?VHVSRXNOYzFpVXhJK2ljTFZXVENkdFliYWU1K2VXZlFOa3hEcjNFRmZZbVc4?=
 =?utf-8?B?WEJ6TXdadW9sWm5EK2YvSU5ja3ZDTE51QW1vU1RzbFBocGVLZ2htTU4xUzc1?=
 =?utf-8?B?SG02Rnd6N05lcUFkRFR4NmpsanV6TTRPR3FGRDNtV1RyUG9JaUNGUDRldmtx?=
 =?utf-8?B?RTljUjM4a0VIMkVmMFZxRXA2aDI4L0ZQdVkvektGbnFIZzZIb0x6bkpIUmJQ?=
 =?utf-8?B?Z0ZrWmFEcm80VWpGUmE2YVZCeEUvaDhobUE1QU1ta3FmdW1ZdEJGT0FpYmlP?=
 =?utf-8?B?UG9ETCtPU3YvZ1FWUkFEeFh3SjRwRlJIMWgzTlBMR3RSVlpsWEk2Zm0yTEIy?=
 =?utf-8?B?SWl6VWxMcnRSd0k1WWp6OFZhUTJ1OUg1YUlIbnRqL0NPY1ZzOE15VzVmaUxx?=
 =?utf-8?B?aGhLbUZmVVQ5bHdGZVM5Q01iMy96bnBib2hyUDltMXQ3OUZ6RkhQWm84S0hY?=
 =?utf-8?B?RkREOUxkVmFiVi9MM3dBS0hzUUgzckN1VklaZE9kZW5lMjVCQ0lZYjY4alh5?=
 =?utf-8?B?UUQ1eTZ3SnVTemVNNmFQZDBaVWwySW1ia0pDN0p2TWtCcXdCNFY1R1YvUDFH?=
 =?utf-8?B?YVhwYWtTTnBhVUhsdzlRSWlQamRWNFdEN0Rob2pxSXNWeGRKNi9NTFpINC9W?=
 =?utf-8?B?ZUFEK2tZWEovRENLeVRBRjJSajNFSnN4QlVwTVk0cmpUdkllQm1VcEwwWEtn?=
 =?utf-8?B?UVFYK0k4Smwyd0J0U2t0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THF4VEI2cEpMTmNKeGRtcDZxVmRMVXpzN1JVMmRVb0phclN0WU5LWXN5U3Fz?=
 =?utf-8?B?UFFvK01GM1lJM0w0M1lwblBoWnM4OXpBVzZsWHJJdUxMdS9PaEZOVWlOdTBt?=
 =?utf-8?B?VGEyMmppZHVNNHFpeE5aTVpXM2JyOUNEeGJBcFJHUVFhUFRhZEp5S0N6ZkJC?=
 =?utf-8?B?SFoxTHVKWTBFVXlGQ3drVTB6MWRqL2NaUG9OVVNHZU9sdW1IYkF4TU9mZTha?=
 =?utf-8?B?N1hmalVzVTc3UzhtVThKOE56V1JpNENJYXNGVm4yMzRLb0VYaUN4RTlXWmtF?=
 =?utf-8?B?OXAxQW42YXl5bmRzYmc4aVJYVTJqd2I3VmJRcUMySnZyMU1GK2VhSi8rTmc0?=
 =?utf-8?B?MHlia2sxK2wxNjNJcS9ENC9oRkFnRXRYYUt6ODFLTm9QaTJqdU9mcE8zQ2U2?=
 =?utf-8?B?OE1EbGlCdnlFNXQ2b1U5Y2xSdTJGdkRwN2k3V2I4TGIySklPamdIMW4zZXlJ?=
 =?utf-8?B?RUY3OHdJeXVvK1JRWjdzUHZBNERCcEFnVWVJcXBoRnJnWEpCVUFmekxOUW1I?=
 =?utf-8?B?MnVwWjVnQkxRbzk4OFR1dEhhL2JHT0o3WHFRRGJXS3NlZEc1YVErd25ueWgw?=
 =?utf-8?B?UnhOMUtZdFVVb0FIQkVnWXEwREFHd3ZRcjUrL0UrZDZHd0lNWHg0OFg3SnIv?=
 =?utf-8?B?eDRtOWwvK21CS3BQOXd0TVVuYndOMXhxS2U1YnVBdVhOMittdHc0S3FSSXN2?=
 =?utf-8?B?QlkycXA4bHdJM0dvbkxEVHp4N0VnYlFQUURLanZRcndybHZwV0xTQW90bVRk?=
 =?utf-8?B?ZlN5Yk9jb3o3UjYzVG9DOWhmWm0wOWsyU3J6VHdYUFQ4MkhtcGxmWERINVIr?=
 =?utf-8?B?MkNBVUZGODR0aUJ2VTBmV2JkMHhFcytzNDhRUVpORWtKQkF0S3Vva0RTQllZ?=
 =?utf-8?B?QkI5eXRlUUNGRSswTEdyeFlFVU5xbTdBUUdRMW5BbWxFNUE2L3dUbVl4R1d4?=
 =?utf-8?B?MUQvVGFRMGRFbmlHbGMvUmU3aXZyL24vOHdtaGJvSFpHZFFjVW1nQXVDbWdI?=
 =?utf-8?B?MkRidVpSd1BjWmppR3RCcU9oSU4xbDNZUzBJUHlBQThJenlnSkxaU05GSFpT?=
 =?utf-8?B?b2VISlUxMUl2aWZxcGFCYkxmV2xPQ00wQXhMKzF5cW91Zjc3ZWxuNEVDQWNq?=
 =?utf-8?B?UU1INFhKam9qeXRoVjB2RHlONGJpUWo5RWVHbWZ3V09nb2pyYzFYUkJ5UENC?=
 =?utf-8?B?UHV1emJGTzJQc3NXZ1l5SHJRcFJjR2hPbmtXWHE1YVJtVHNTOGhwVDVsUGNm?=
 =?utf-8?B?VVVqV01BNm1rTXc3ampPaEowcFlsQXNHRUs1dmxDRnN5WC9KKzJxdS9KT1E0?=
 =?utf-8?B?SThIbzRDMHY2Z3FaeE5HNkUyaDYvbUdDS2daNXVwTWR0MzNkSVFoZkg0NStJ?=
 =?utf-8?B?ZG9zd29QWTR2V1k2WVFmZXJ1dnVrUGtWSmdER0pKaW55N1MrUHZQdTJVeEVu?=
 =?utf-8?B?d1FxYWZuemJ6K0F3YlI1V1FmL0phMHZwZzMrdG5BTUpxR3V5Y0ZxVFE5K0k3?=
 =?utf-8?B?YlpUMjY2aWQzc3JvemYyelV5QjlyQUxuUzhsS3RXNmozMURZQzhnRDRMTzVa?=
 =?utf-8?B?QUE3YWFCWHpCNTVjNG5LOW82Qm85SDQ2aGFHUmNmYkhxK0s0YldyZ3lTR1Q3?=
 =?utf-8?B?OWpBd0VXUjlFVmJyUWdpejRVMmYvN0g2VHcvWFI2Ti9BTVF3RmttTGU4LzRp?=
 =?utf-8?B?c09ZcWpCU0hNVWRhVW90N0syWkJRSyttaThOZGpIWG5DeFhaaWI1OERPSmM1?=
 =?utf-8?B?bkpka0NRZ2gxRlh6eUxUcVRQTXphS3ZyM3l0TVdMRFlYMC9RWFRXSEVDemlt?=
 =?utf-8?B?VUlNMWFHVUIzakI0M01DRTZKZWpUT3Uwa1RYZUdYcHJ6eGNaWDVUWkRtMGZs?=
 =?utf-8?B?OTdYMjI0QmMwanBlRzdZY01vNkpJa2o3UGc2NEtWYkUwWkJEb0srNTJsNHhi?=
 =?utf-8?B?MVA0c2plVmU3bElwMnl1QTdOUXpMTDUrcTN5aHRVTW4wRzZmVkRUTFl2dnZt?=
 =?utf-8?B?bVg4c3dvRTg0NnhLMUo0Ym5tM3BoSHJCZ3JSRmlQWVNhSzdoUk80TzlUamtj?=
 =?utf-8?B?T3hraGdmQ1JrZUJkUmFxdldFK1RGd2h4WDlJWWNMc1dPWnFuYjZVZmVscHFT?=
 =?utf-8?B?cmYrL1luTEZIMUFRek5oZUVMUHoveS84S2Z5L09tVGhiNUxYUlc0eEV4NnJR?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YXuO+/+/AhmEfWdqYcdA68rxIFjge6S++HkxfuMACMrezUT/UCZc0PXpKfZpJu9pocN7FbvmfPK/V2MKk0zvx9BSwXdvEkofCtws1eIoXPn3AEa//EaJXykEAToSsCU7o1SuYfnR+Y5EPcV0dg5oQ9NsIqRItWCsh+sIQccZ5sEsTbRFQNC5VCUhh3zBP3KENWkW0Z/8MypxN1Edb1Sytw+P4HnNAn3IRzB1UhcEr0cF1GBlNFqWpy4hFztMVTOaJhehoRPFR9utYGRjOySpzNSXPsav6pZ9dlKXU0+FvVZCGv687Z0ezJk2lGkGIIqud7UajIAyNO8dOJPA5Uh7JuK5ip79DuTAr6ztmgIUD48UkSqNDvtKJP+pJ/ib95D49ENhdfv+uLaghdTDqZ+ePLWuEnBOdeZMtg2fx3VME4QB9aO4sC9tBV7yjblCtAhpm5GMtUpnQ1Zb8Q08LfRT93wktcZJwFUu70fLW7Sx78/lfCF32XfyFm9lG7REQV+48uOIlVv+drzKPkZkvGkkD1nQ6wynj0C8xlTMx7iS4Apivayab+c8M3vksTwPzCQe/jtDnn2LZxRD6Ij2Uo5H/HH/HY0oalyx+AdngyxmNlQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f0e75e-362e-4c58-cbbf-08dd36696b67
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 20:07:35.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Axfa8ml4H2EMmWSwz/fCrtgPNxyyJQf3ZjZyyNuewyLFh9NBZp4rFZ5bt9fO5m4lybEfRyAZiBF/vwalEZS7uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_08,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160148
X-Proofpoint-GUID: Ac2GYiyrMduUUg30LiY0uK_8wgKAPg7T
X-Proofpoint-ORIG-GUID: Ac2GYiyrMduUUg30LiY0uK_8wgKAPg7T

On 1/11/25 3:14 AM, Pellegrin Baptiste wrote:
> On 09/01/25 17:32, *Chuck Lever * <chuck.lever@oracle.com> wrote:
>> On 1/9/25 7:42 AM, Jeff Layton wrote:
>> >On Thu, 2025-01-09 at 12:56 +0100, Christian Herzog wrote:
>> >>Dear Chuck,
>> >>
>> >>On Wed, Jan 08, 2025 at 10:07:49AM -0500, Chuck Lever wrote:
>> >>>On 1/8/25 9:54 AM, Christian Herzog wrote:
>> >>>>Dear Chuck,
>> >>>>
>> >>>>On Wed, Jan 08, 2025 at 08:33:23AM -0500, Chuck Lever wrote:
>> >>>>>On 1/7/25 4:17 PM, Salvatore Bonaccorso wrote:
>> >>>>>>Hi Chuck,
>> >>>>>>
>> >>>>>>Thanks for your time on this, much appreciated.
>> >>>>>>
>> >>>>>>On Wed, Jan 01, 2025 at 02:24:50PM -0500, Chuck Lever wrote:
>> >>>>>>>On 12/25/24 4:15 AM, Salvatore Bonaccorso wrote:
>> >>>>>>>>Hi Chuck, hi all,
>> >>>>>>>>
>> >>>>>>>>[it was not ideal to pick one of the message for this 
>> followup, let me
>> >>>>>>>>know if you want a complete new thread, adding as well 
>> Benjamin and
>> >>>>>>>>Trond as they are involved in one mentioned patch]
>> >>>>>>>>
>> >>>>>>>>On Mon, Jun 17, 2024 at 02:31:54PM +0000, Chuck Lever III wrote:
>> >>>>>>>>>
>> >>>>>>>>>
>> >>>>>>>>>>On Jun 17, 2024, at 2:55 AM, Harald Dunkel 
>> <harald.dunkel@aixigo.com> wrote:
>> >>>>>>>>>>
>> >>>>>>>>>>Hi folks,
>> >>>>>>>>>>
>> >>>>>>>>>>what would be the reason for nfsd getting stuck somehow and 
>> becoming
>> >>>>>>>>>>an unkillable process? See
>> >>>>>>>>>>
>> >>>>>>>>>>- https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562 
>> <https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562>
>> >>>>>>>>>>- https://bugs.launchpad.net/ubuntu/+source/nfs-utils/ 
>> +bug/2062568 <https://bugs.launchpad.net/ubuntu/+source/nfs-utils/ 
>> +bug/2062568>
>> >>>>>>>>>>
>> >>>>>>>>>>Doesn't this mean that something inside the kernel gets stuck as
>> >>>>>>>>>>well? Seems odd to me.
>> >>>>>>>>>
>> >>>>>>>>>I'm not familiar with the Debian or Ubuntu kernel packages. Can
>> >>>>>>>>>the kernel release numbers be translated to LTS kernel releases
>> >>>>>>>>>please? Need both "last known working" and "first broken" 
>> releases.
>> >>>>>>>>>
>> >>>>>>>>>This:
>> >>>>>>>>>
>> >>>>>>>>>[ 6596.911785] RPC: Could not send backchannel reply error: -110
>> >>>>>>>>>[ 6596.972490] RPC: Could not send backchannel reply error: -110
>> >>>>>>>>>[ 6837.281307] RPC: Could not send backchannel reply error: -110
>> >>>>>>>>>
>> >>>>>>>>>is a known set of client backchannel bugs. Knowing the LTS kernel
>> >>>>>>>>>releases (see above) will help us figure out what needs to be
>> >>>>>>>>>backported to the LTS kernels kernels in question.
>> >>>>>>>>>
>> >>>>>>>>>This:
>> >>>>>>>>>
>> >>>>>>>>>[11183.290619] wait_for_completion+0x88/0x150
>> >>>>>>>>>[11183.290623] __flush_workqueue+0x140/0x3e0
>> >>>>>>>>>[11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
>> >>>>>>>>>[11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
>> >>>>>>>>>
>> >>>>>>>>>is probably related to the backchannel errors on the client, but
>> >>>>>>>>>client bugs shouldn't cause the server to hang like this. We
>> >>>>>>>>>might be able to say more if you can provide the kernel release
>> >>>>>>>>>translations (see above).
>> >>>>>>>>
>> >>>>>>>>In Debian we hstill have the bug #1071562 open and one person 
>> notified
>> >>>>>>>>mye offlist that it appears that the issue get more frequent since
>> >>>>>>>>they updated on NFS client side from Ubuntu 20.04 to Debian 
>> bookworm
>> >>>>>>>>with a 6.1.y based kernel).
>> >>>>>>>>
>> >>>>>>>>Some people around those issues, seem to claim that the change
>> >>>>>>>>mentioned in
>> >>>>>>>>https://lists.proxmox.com/pipermail/pve-devel/2024- 
>> July/064614.html <https://lists.proxmox.com/pipermail/pve-devel/2024- 
>> July/064614.html>
>> >>>>>>>>would fix the issue, which is as well backchannel related.
>> >>>>>>>>
>> >>>>>>>>This is upstream: 6ddc9deacc13 ("SUNRPC: Fix backchannel reply,
>> >>>>>>>>again"). While this commit fixes 57331a59ac0d ("NFSv4.1: Use the
>> >>>>>>>>nfs_client's rpc timeouts for backchannel") this is not something
>> >>>>>>>>which goes back to 6.1.y, could it be possible that hte 
>> backchannel
>> >>>>>>>>refactoring and this final fix indeeds fixes the issue?
>> >>>>>>>>
>> >>>>>>>>As people report it is not easily reproducible, so this makes it
>> >>>>>>>>harder to identify fixes correctly.
>> >>>>>>>>
>> >>>>>>>>I gave a (short) stance on trying to backport commits up to
>> >>>>>>>>6ddc9deacc13 ("SUNRPC: Fix backchannel reply, again") but this 
>> quickly
>> >>>>>>>>seems to indicate it is probably still not the right thing for
>> >>>>>>>>backporting to the older stable series.
>> >>>>>>>>
>> >>>>>>>>As at least pre-requisites:
>> >>>>>>>>
>> >>>>>>>>2009e32997ed568a305cf9bc7bf27d22e0f6ccda
>> >>>>>>>>4119bd0306652776cb0b7caa3aea5b2a93aecb89
>> >>>>>>>>163cdfca341b76c958567ae0966bd3575c5c6192
>> >>>>>>>>f4afc8fead386c81fda2593ad6162271d26667f8
>> >>>>>>>>6ed8cdf967f7e9fc96cd1c129719ef99db2f9afc
>> >>>>>>>>57331a59ac0d680f606403eb24edd3c35aecba31
>> >>>>>>>>
>> >>>>>>>>and still there would be conflicting codepaths (and does not seem
>> >>>>>>>>right).
>> >>>>>>>>
>> >>>>>>>>Chuck, Benjamin, Trond, is there anything we can provive on 
>> reporters
>> >>>>>>>>side that we can try to tackle this issue better?
>> >>>>>>>
>> >>>>>>>As I've indicated before, NFSD should not block no matter what the
>> >>>>>>>client may or may not be doing. I'd like to focus on the server 
>> first.
>> >>>>>>>
>> >>>>>>>What is the result of:
>> >>>>>>>
>> >>>>>>>$ cd <Bookworm's v6.1.90 kernel source >
>> >>>>>>>$ unset KBUILD_OUTPUT
>> >>>>>>>$ make -j `nproc`
>> >>>>>>>$ scripts/faddr2line \
>> >>>>>>> fs/nfsd/nfs4state.o \
>> >>>>>>> nfsd4_destroy_session+0x16d
>> >>>>>>>
>> >>>>>>>Since this issue appeared after v6.1.1, is it possible to bisect
>> >>>>>>>between v6.1.1 and v6.1.90 ?
>> >>>>>>
>> >>>>>>First please note, at least speaking of triggering the issue in
>> >>>>>>Debian, Debian has moved to 6.1.119 based kernel already (and 
>> soon in
>> >>>>>>the weekends point release move to 6.1.123).
>> >>>>>>
>> >>>>>>That said, one of the users which regularly seems to be hit by the
>> >>>>>>issue was able to provide the above requested information, based for
>> >>>>>>6.1.119:
>> >>>>>>
>> >>>>>>~/kernel/linux-source-6.1# make kernelversion
>> >>>>>>6.1.119
>> >>>>>>~/kernel/linux-source-6.1# scripts/faddr2line fs/nfsd/ 
>> nfs4state.o nfsd4_destroy_session+0x16d
>> >>>>>>nfsd4_destroy_session+0x16d/0x250:
>> >>>>>>__list_del_entry at /root/kernel/linux-source-6.1/./include/ 
>> linux/list.h:134
>> >>>>>>(inlined by) list_del at /root/kernel/linux-source-6.1/./ 
>> include/linux/list.h:148
>> >>>>>>(inlined by) unhash_session at /root/kernel/linux-source-6.1/fs/ 
>> nfsd/nfs4state.c:2062
>> >>>>>>(inlined by) nfsd4_destroy_session at /root/kernel/linux- 
>> source-6.1/fs/nfsd/nfs4state.c:3856
>> >>>>>>
>> >>>>>>They could provide as well a decode_stacktrace output for the recent
>> >>>>>>hit (if that is helpful for you):
>> >>>>>>
>> >>>>>>[Mon Jan 6 13:25:28 2025] INFO: task nfsd:55306 blocked for more 
>> than 6883 seconds.
>> >>>>>>[Mon Jan 6 13:25:28 2025]       Not tainted 6.1.0-28-amd64 #1 
>> Debian 6.1.119-1
>> >>>>>>[Mon Jan 6 13:25:28 2025] "echo 0 > /proc/sys/kernel/ 
>> hung_task_timeout_secs" disables this message.
>> >>>>>>[Mon Jan 6 13:25:28 2025] task:nfsd            state:D 
>> stack:0     pid:55306 ppid:2      flags:0x00004000
>> >>>>>>[Mon Jan 6 13:25:28 2025] Call Trace:
>> >>>>>>[Mon Jan 6 13:25:28 2025]  <TASK>
>> >>>>>>[Mon Jan 6 13:25:28 2025] __schedule+0x34d/0x9e0
>> >>>>>>[Mon Jan 6 13:25:28 2025] schedule+0x5a/0xd0
>> >>>>>>[Mon Jan 6 13:25:28 2025] schedule_timeout+0x118/0x150
>> >>>>>>[Mon Jan 6 13:25:28 2025] wait_for_completion+0x86/0x160
>> >>>>>>[Mon Jan 6 13:25:28 2025] __flush_workqueue+0x152/0x420
>> >>>>>>[Mon Jan 6 13:25:28 2025] nfsd4_destroy_session (debian/build/ 
>> build_amd64_none_amd64/include/linux/spinlock.h:351 debian/build/ 
>> build_amd64_none_amd64/fs/nfsd/nfs4state.c:3861) nfsd
>> >>>>>>[Mon Jan 6 13:25:28 2025] nfsd4_proc_compound (debian/build/ 
>> build_amd64_none_amd64/fs/nfsd/nfs4proc.c:2680) nfsd
>> >>>>>>[Mon Jan 6 13:25:28 2025] nfsd_dispatch (debian/build/ 
>> build_amd64_none_amd64/fs/nfsd/nfssvc.c:1022) nfsd
>> >>>>>>[Mon Jan 6 13:25:28 2025] svc_process_common (debian/build/ 
>> build_amd64_none_amd64/net/sunrpc/svc.c:1344) sunrpc
>> >>>>>>[Mon Jan 6 13:25:28 2025] ? svc_recv (debian/build/ 
>> build_amd64_none_amd64/net/sunrpc/svc_xprt.c:897) sunrpc
>> >>>>>>[Mon Jan 6 13:25:28 2025] ? nfsd_svc (debian/build/ 
>> build_amd64_none_amd64/fs/nfsd/nfssvc.c:983) nfsd
>> >>>>>>[Mon Jan 6 13:25:28 2025] ? nfsd_inet6addr_event (debian/build/ 
>> build_amd64_none_amd64/fs/nfsd/nfssvc.c:922) nfsd
>> >>>>>>[Mon Jan 6 13:25:28 2025] svc_process (debian/build/ 
>> build_amd64_none_amd64/net/sunrpc/svc.c:1474) sunrpc
>> >>>>>>[Mon Jan 6 13:25:28 2025] nfsd (debian/build/ 
>> build_amd64_none_amd64/fs/nfsd/nfssvc.c:960) nfsd
>> >>>>>>[Mon Jan 6 13:25:28 2025] kthread+0xd7/0x100
>> >>>>>>[Mon Jan 6 13:25:28 2025] ? kthread_complete_and_exit+0x20/0x20
>> >>>>>>[Mon Jan 6 13:25:28 2025] ret_from_fork+0x1f/0x30
>> >>>>>>[Mon Jan  6 13:25:28 2025]  </TASK>
>> >>>>>>
>> >>>>>>The question about bisection is actually harder, those are 
>> production
>> >>>>>>systems and I understand it's not possible to do bisect there, while
>> >>>>>>unfortunately not reprodcing the issue on "lab conditions".
>> >>>>>>
>> >>>>>>Does the above give us still a clue on what you were looking for?
>> >>>>>
>> >>>>>Thanks for the update.
>> >>>>>
>> >>>>>It's possible that 38f080f3cd19 ("NFSD: Move callback_wq into struct
>> >>>>>nfs4_client"), while not a specific fix for this issue, might 
>> offer some
>> >>>>>relief by preventing the DESTROY_SESSION hang from affecting all 
>> other
>> >>>>>clients of the degraded server.
>> >>>>>
>> >>>>>Not having a reproducer or the ability to bisect puts a damper on
>> >>>>>things. The next step, then, is to enable tracing on servers 
>> where this
>> >>>>>issue can come up, and wait for the hang to occur. The following 
>> command
>> >>>>>captures information only about callback operation, so it should not
>> >>>>>generate much data or impact server performance.
>> >>>>>
>> >>>>>    # trace-cmd record -e nfsd:nfsd_cb\*
>> >>>>>
>> >>>>>Let that run until the problem occurs, then ^C, compress the 
>> resulting
>> >>>>>trace.dat file, and either attach it to 1071562 or email it to me
>> >>>>>privately.
>> >>>>thanks for the follow-up.
>> >>>>
>> >>>>I am the "customer" with two affected file servers. We have since 
>> moved those
>> >>>>servers to the backports kernel (6.11.10) in the hope of forward 
>> fixing the
>> >>>>issue. If this kernel is stable, I'm afraid I can't go back to the 
>> 'bad'
>> >>>>kernel (700+ researchers affected..), and we're also not able to 
>> trigger the
>> >>>>issue on our test environment.
>> >>>
>> >>>Hello Dr. Herzog -
>> >>>
>> >>>If the problem recurs on 6.11, the trace-cmd I suggest above works
>> >>>there as well.
>> >>the bad news is: it just happened again with the bpo kernel.
>> >>
>> >>We then immediately started trace-cmd since usually there are 
>> several call
>> >>traces in a row and we did get a trace.dat:
>> >>http://people.phys.ethz.ch/~daduke/trace.dat <http:// 
>> people.phys.ethz.ch/~daduke/trace.dat>
>> >>
>> >>we did notice however that the stack trace looked a bit different 
>> this time:
>> >>
>> >>     INFO: task nfsd:2566 blocked for more than 5799 seconds.
>> >>     Tainted: G        W          6.11.10+bpo-amd64 #1 Debia>
>> >>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables t>
>> >>     task:nfsd            state:D stack:0     pid:2566  tgid:2566 >
>> >>     Call Trace:
>> >>     <TASK>
>> >>     __schedule+0x400/0xad0
>> >>     schedule+0x27/0xf0
>> >>     nfsd4_shutdown_callback+0xfe/0x140 [nfsd]
>> >>     ? __pfx_var_wake_function+0x10/0x10
>> >>     __destroy_client+0x1f0/0x290 [nfsd]
>> >>     nfsd4_destroy_clientid+0xf1/0x1e0 [nfsd]
>> >>     ? svcauth_unix_set_client+0x586/0x5f0 [sunrpc]
>> >>     nfsd4_proc_compound+0x34d/0x670 [nfsd]
>> >>     nfsd_dispatch+0xfd/0x220 [nfsd]
>> >>     svc_process_common+0x2f7/0x700 [sunrpc]
>> >>     ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>> >>     svc_process+0x131/0x180 [sunrpc]
>> >>     svc_recv+0x830/0xa10 [sunrpc]
>> >>     ? __pfx_nfsd+0x10/0x10 [nfsd]
>> >>     nfsd+0x87/0xf0 [nfsd]
>> >>     kthread+0xcf/0x100
>> >>     ? __pfx_kthread+0x10/0x10
>> >>     ret_from_fork+0x31/0x50
>> >>     ? __pfx_kthread+0x10/0x10
>> >>     ret_from_fork_asm+0x1a/0x30
>> >>     </TASK>
>> >>
>> >>and also the state of the offending client in `/proc/fs/nfsd/ 
>> clients/*/info`
>> >>used to be callback state: UNKNOWN while now it is DOWN or FAULT. No 
>> idea
>> >>what it means, but I thought it was worth mentioning.
>> >>
>> >
>> >Looks like this is hung in nfsd41_cb_inflight_wait_complete() ? That
>> >probably means that the cl_cb_inflight counter is stuck at >0. I'm
>> >guessing that means that there is some callback that it's expecting to
>> >complete that isn't. From nfsd4_shutdown_callback():
>> >
>> >         /*
>> >          * Note this won't actually result in a null callback;
>> >          * instead, nfsd4_run_cb_null() will detect the killed
>> >          * client, destroy the rpc client, and stop:
>> >          */
>> >         nfsd4_run_cb(&clp->cl_cb_null);
>> >         flush_workqueue(clp->cl_callback_wq);
>> >         nfsd41_cb_inflight_wait_complete(clp);
>> >
>> >...it sounds like that isn't happening properly though.
>> >
>> >It might be interesting to see if you can track down the callback
>> >client in /sys/kernel/debug/sunrpc and see what it's doing.
>>
>> Here's a possible scenario:
>>
>> The trace.dat shows the server is sending a lot of CB_RECALL_ANY
>> operations.
>>
>> Normally a callback occurs only due to some particular client request.
>> Such requests would be completed before a client unmounts.
>>
>> CB_RECALL_ANY is an operation which does not occur due to a particular
>> client operation and can occur at any time. I believe this is the
>> first operation of this type we've added to NFSD.
>>
>> My guess is that the server's laundromat has sent some CB_RECALL_ANY
>> operations while the client is umounting -- DESTROY_SESSION is
>> racing with those callback operations.
>>
>> deleg_reaper() was backported to 6.1.y in 6.1.81, which lines up
>> more or less with when the issues started to show up.
>>
>> A quick way to test this theory would be to make deleg_reaper() a
>> no-op. If this helps, then we know that shutting down the server's
>> callback client needs to be more careful about cleaning up outstanding
>> callbacks.
>>
>>
>> -- 
>> Chuck Lever
> 
> Hello.
> 
> Thanks a lot for all of this work !
> 
> I have started recording traces using :
> 
> # trace-cmd record -e nfsd:nfsd_cb\*
> 
> and currently waiting for the bug to trigger. This generally happen in 
> one/two weeks for me.
> 
> If you want I adjust some recording parameters let me know.

After looking at your data and Rik's data, I decided to try reproducing
the problem in my lab. No luck so far.

The signatures of these issues are slightly different from each other:

v6.1:
- nfsd4_destroy_session hangs on the flush_workqueue in
   nfsd4_shutdown_callback()
- There might be outstanding callback RPCs that are not exiting
- Lots of CB_RECALL_ANY traffic. Only place that's generated in
   v6.1 is the NFSD shrinker when memory is short
- There appear to be some unreachable clients -- evidence of client
   crashes or network outages, perhaps

v6.12:
- destroy_client() hangs on the wait_var_event in
   nfsd4_shtudown_callback()
- There are no callback RPCs left after the hang
- There are some stuck clients listed under /proc/fs/nfsd/

Similar, but not the same.

I'm still open to clues, so please continue the regimen of starting
the trace-cmd when the server boots, and doing an "echo t >
/proc/sysrq-trigger" when the hang appears.

  # trace-cmd record -e nfsd:nfsd_cb\* -e sunrpc:svc_xprt_detach \
    -p function -l nfsd4_destroy_session


-- 
Chuck Lever

