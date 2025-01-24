Return-Path: <linux-nfs+bounces-9591-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A97A1B98D
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 16:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4765816BA53
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EEF153828;
	Fri, 24 Jan 2025 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JWVJcQUt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lMgPNxMk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB5215623A;
	Fri, 24 Jan 2025 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733406; cv=fail; b=Jl2i30yG5iALULrgpOIgWcBG3PuT69RAtlw1AaQsprBPd4DJaJIu0qF4VBiLsRew69QbXtlQ7S7Co9qm+/G7Tph//Y/fB3R81WmBqI7LO8P8rWzjmdaS/GnLWBZKJMHGLxHxzxBTSoCK6FTPr6Imt/LFgLZf+Rau3XPPQNvY7v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733406; c=relaxed/simple;
	bh=sElDsTlPfKz1TPU3LbJZJD6M15cOmQ3nspKAjGHn1Xk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dzk8GQUMrUeK/zfMNaeIBUFHUyTacP6kVL7pgvJy8aPf5yemVmdslRi3BgkXqI1QMPGdkNkcQpb4yAkyn1wDS+wvtKxdAFN9olc1qvs0RUnXq2xJEvR95HbANNCMGjbBh3Zah7WDmLE42GcDmt1gj3Htd8QD5BF2C4FA4ZEFchU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JWVJcQUt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lMgPNxMk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O8g8vK018400;
	Fri, 24 Jan 2025 15:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=e446tMXs/hNgnmQl+n5uNFQcxyrDDCM87bvfBRLRy3U=; b=
	JWVJcQUtE8l3ATxjgWur/OhcXFahLV2ODWHgMvlmVcEgJFk60ygI6s4/4CF6ji2F
	XnG97MLcVEjuWH2TSVmGndUXqpTFmaiOGBKXzO/4MUMk/CbcT5bxpU/Hhoh+ZbCj
	WHTHwtbfhd8dTgKjyWk0j5Z8cS1ZGyVMy6La+p+iX2lJtJ9L7w/KJWx/8z0E9BlP
	d/kjU28NNp11WGmDp/q0X3hvVLKRlvISJeZ85oJfNDU0wQ7kN5IFYsmuQnRfiY1K
	Z5ebmPBPA9ltq3uWwJ2geGTrtFXQ6p6TNTekTUpHWct4/X3N4gyKIurhPjxLKNku
	UsvvKQE6tiqvK7NppaFvzw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b96akew1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 15:43:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OFOXcL038182;
	Fri, 24 Jan 2025 15:43:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4491a44d1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 15:43:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUD/RbCYo9qKfrY6Rurlp0sGWolxNzyprHYvmgWXILnxj/OEGwItbLiazkzB4dGhp+9kjFGH3w5Pa714gPfdUCuR1kSutTofjF7SWOEK15QZx51VA/etp9yikVgBzfkNIainV7v/MSv420WqnT4aDDskUex3Hw4MFo0jEqHgONFMTbZnTJxBv8zZn3GI7m4DLM+jshbwQu19nGgO1oRGgdKL/pawbJ00ru1Zh+Bb7PJ9zdVV/MG7/DGYy/KYNmVZUWcbhnKNgM5wIrAcpNh6/aBXfTEp3dHAyg12PVBdiTvCl2UlmXOcT4ipPskwdl09F/jsz+YBCZhd+1syR1mm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e446tMXs/hNgnmQl+n5uNFQcxyrDDCM87bvfBRLRy3U=;
 b=DndZ3CjzzbW9nNTeK/P8pw2xB9+ktdgG335joRRbR+V3X3abuACnOhXMa7JJ1U5fUArpHsdzQkZ3ppfoNDEfFwxkRVvoF33g1lt+/tPoXMHWm6wxUBfbS8i8BGB1fZiA1iJDsxW652hv6P6Zy0RpPie7uFlcacsygFa/Pv2RDMp51CPWk1BKP7DcjtcJEthP4uXCix96ydT30bqz23CQJfoD5ogQS+7VZeJCk/4YBDX/inyN2kalYYcT6fK79DCDB7dt10nCpCPeSs7cLPYEMYkpGG22qMDvAxvpz0gRv7aR3EUEuFicsQha0crqxgv4tgoOSBznG1qTuAVwApuWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e446tMXs/hNgnmQl+n5uNFQcxyrDDCM87bvfBRLRy3U=;
 b=lMgPNxMk0iF0u2H0+ngi4XH7mc9j2DoKSK3bNVQjJ3Pqll60n4iGwAoK34xilCmJtGJ5EOUFe8L7pHxRj/Leip8bVCaYVdgh+A7rt7ozwBYV1+18Oi8Q+3usakx04LOoTq4tlnNRj3tCwKfC0qAfzZQKWMPxOa9aNE3E7MY2hOk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7859.namprd10.prod.outlook.com (2603:10b6:a03:56e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 15:43:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 15:43:02 +0000
Message-ID: <82af28bb-9fe5-4ba3-a592-68aea840aefa@oracle.com>
Date: Fri, 24 Jan 2025 10:42:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] nfsd: clean up and amend comments around
 nfsd4_cb_sequence_done()
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-7-c1137a4fa2ae@kernel.org>
 <8a6e1930-feee-47f8-8260-874b9c47f20e@oracle.com>
 <42ef9ff65c27fb7347f72e85b583ff74b2200bd6.camel@kernel.org>
 <1f967fd7-17b6-402e-ac55-aba956ba0d65@oracle.com>
 <39a9a8e714b0cdf728080862a5fe69bbc617361e.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <39a9a8e714b0cdf728080862a5fe69bbc617361e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:610:11a::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c045c0-9f77-43ff-b509-08dd3c8dc920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RC9WYis4UnBRODZaNCt1WjQwcE1BK0lwekN1TFkzOVdkRjVIVzhHOUFVRXA0?=
 =?utf-8?B?d3BWa2ZGNnYvUHhyelJJT1ljb0Y3K2x5RGV5TmNqclFOTnlpSFJSdE9idDRP?=
 =?utf-8?B?L3VKZ2NuK1BxOUozVGpyZ0Q4S2tQMGQvdENHdnZyVWtlc1c5Tnpya1NpTW9t?=
 =?utf-8?B?SnVXREZKVUJSV1pYTkJrcExNNEVETUtHc09YcTJJUllZTFZ1aDhIWFJRRjRx?=
 =?utf-8?B?WUZJbUVheGpia2E3SVNrMXJjRlJQRTNmWlRQa1RrdHVvSGpoTHpvOVcvL1BX?=
 =?utf-8?B?dG9LZ09YazZmdnEzUEoreWlZVzc1NjB1aFFoeWcyOXh4K1dseGhETXFuQmRl?=
 =?utf-8?B?MDFSaDc3VnUvbThpU1M2cERCeFBrSG1YL2FoKzRWOFQvbEhJYmhpcjU4eXd3?=
 =?utf-8?B?NWkwMFBUTmErZllJY3VVSDlTaEJEQ0h0VUNkUFlEQXpOZ2N1eTd2dS9tQzQ1?=
 =?utf-8?B?OFJUN1JxdEF0alBDSHo1NExYZ2JMSmdteUZ0ME1vZ3g2bFRmUkFQU3NpTUFq?=
 =?utf-8?B?MndFbmJYaGdIeGdIMVpodFJGZTFaUnlUQ3VYbktiMXBUbVNxMG1QdEhxekNY?=
 =?utf-8?B?MDZma0JTTFd3endTNnhBb0VpdmFzWjRkYkFiL0NPY1VMUFFwWXhnb1A4RjdB?=
 =?utf-8?B?bThqbTdKbldhQ05BdklYTTJ4Q3NEcElXK3FUNUQ0VnU0UkZsV2E3UWJuYXBo?=
 =?utf-8?B?QmNaV3lYaWZ6NlFKWFVFdWlTL3RDS3VvRXFDdVNyVk5qY1hrZEYyT3lOZ2R6?=
 =?utf-8?B?YjFMRVpzN0Zpc0J2d1Q5WlF3SFhkU2lYZUxQalBQMkdQMGlYTFdZUXltSUJz?=
 =?utf-8?B?RG9MYXpsMVN0aFB3THZ0WlNPM2ptRGpnbnJzWjF1bGlOMFE5WHdsU3ZCZHZM?=
 =?utf-8?B?ckowWHNKUHpvNW11S3FQVDFKSUpTZFEvZnBsbzczYkxWZm95MndFOStZN2Rn?=
 =?utf-8?B?LzdUWHRJUU52K0VEUTlSZ1hMWDgxNEM5U1VJRXgyZzN3WlpYaUhTeTREalE1?=
 =?utf-8?B?aGN2b0s4SXBWdm5FVkdYSWlnbkxSV0RVMHVLK2M1UUdyVVpvNTIza2F3cXBw?=
 =?utf-8?B?bWdiYlEyTmVmTnczdkVmeUpXV09wOUpVbEM4QjdRYXZmK3dSMloyemo0N1NX?=
 =?utf-8?B?bm5wcTBPZTkzS1kyVjJ1bDExZVBlTXFQRDV2QlNCMVl0bktXbUJyY2lSaXkv?=
 =?utf-8?B?bm82VFljcEM1R290NzE0TzlBcjJTRDVSU3NaeWZUUGc0ZjlXMFByOXlJbG4y?=
 =?utf-8?B?MmhVWk1QMTdjdEJFOURlR1QyTnZLcXV3ZmFzZnV4b0Zqa2FKV2RJMVQxaHEx?=
 =?utf-8?B?eEVqSkRrWTU1VGEzYlhUa3lxSjd0Tytoc3ZvL3pvejBzalpzakRQNkhFRWwr?=
 =?utf-8?B?ZFNXNlE0TUgySmpYdWRINVNtT0FkeDRHRnYwbzRpVWxSMXQ5L2JOelAvRUsr?=
 =?utf-8?B?aG5Xd1F1UVFRTHYxZnVSZnQ0ZDFWa0Zkai91aTh2cFdMQ25aT29hNXVZaUhE?=
 =?utf-8?B?Qi9nY2V5dURiRGx1WUZwbWtsbGpzbVVVSzlVdjFFWlhkcTU4UXhxMnd1bUZq?=
 =?utf-8?B?WEhPNFVaMDRoRzhqcG5lRC9GbEJUcmdEUkpEUkZlUDJTMWJkL1VLaFptU25Z?=
 =?utf-8?B?bTdOQ3IvTGJLdTRERGpYY3dUTVRFdEVCZXIxbjR2OEpiSDIrd1NGRVNNdjdx?=
 =?utf-8?B?b0VPRExqSTNnM2lPaWFWUGYwbjNYMm5IOUxMTlk5UUg4MkZPNmM2b0ZBTTdu?=
 =?utf-8?B?VEtaYkR1OVZmUW5ueGxtUU9HcTN1ayt5VGoxUUVGNnhlS2FiT1c4SmMvN3lZ?=
 =?utf-8?B?SHhoQXpiOTJjTmhOb0NsU3JIcHZLT3g5VTNTR1NEdk83aGFNWlI3MSs0OTlp?=
 =?utf-8?B?Y1JGTk9mR1JZcWl5M1c1TjZEcTV0T2hmc1NWUGowWURZaysrbW1ocXEvWG1I?=
 =?utf-8?Q?l4SlOSeC7ac=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm5SVjlWVmxySVdvRzlUQ2gxajN0S3lzSEUzYk5iZkxYenZRYzJmSGJ6TTYw?=
 =?utf-8?B?bjBJL0E4bzJhNjdtZTA1MGxGaGgwejFCUUt4N0wwenlHVWVwUlVGNHo4ZUV3?=
 =?utf-8?B?eDN0UUVsRkZYcWVOQlRmQTVTSFBtdmVYR0s0My9KNEVXRmpsNUdOWW9ZYXdQ?=
 =?utf-8?B?b2MyNGZjRE85Z1JxL05NWm1XaWQ1Vm1PRkNHdksrK0NNVng3MHp5Q2R1ckV1?=
 =?utf-8?B?VGVMS3RqNU1XY2E3RkxZeWlsYXFNK2x1VHlKTzRKQVZFNExCeFU1ZVRXYU5o?=
 =?utf-8?B?a21DaEhlcGFxQUh4cTdwZGZKZForOXdPSEpZRGhwV0g4QXlCeEJ2S0Jta3FZ?=
 =?utf-8?B?d3JwS0ZBQWduejRWKzNjU01hVG9BSmhURDJTS3JndUxRRm16NHdUV1BXL0Nm?=
 =?utf-8?B?cXBxeDVFaDFQTWZIOFFzc3M0VDhrM3h5RGFIUUkrMWNYYmcwTFQ2eWEzamJM?=
 =?utf-8?B?ODZseFNQY1BrSCtwT1ZBdmE3ZGM5WFVaVjNNOXJsWC83R2llZGdkc2V2ZVdH?=
 =?utf-8?B?akNsMGEyRWQvVGtXUzAzMEhzaXNyMStQR1NWQ3QyNWFjT0JVNTV3aVpxMlM1?=
 =?utf-8?B?U0duU2kwS2c3VURPbDZ4aEhJcWVla0ltbDB3SGdpazRRNFJZbGdxSW94eE9T?=
 =?utf-8?B?WWNJNnI0ZE5TR3lNMGhDb2pkYTBWOG9ycVd4bGsrUU9UbzVHTmhrazUzT3Ar?=
 =?utf-8?B?VVAyaFl0N3p5eUNLR2IyRTArM3laMGZQVlQzdFFLWjlSU0NzS2hWd3VzcnhR?=
 =?utf-8?B?VlU4QTNETFR0dWI3Yno5OXQ0TFF3WnpGTzFWWVRUTk5WakRndkl1ZWhtSFR3?=
 =?utf-8?B?RzBqcy9VRTJCNGxiODBFVERyUlNsbXFiS25YWlVJOExJOHExbExlZFk4djgz?=
 =?utf-8?B?ZnI5c1lXTDhJaVE4eCtLYWdkR3dHVkhzOGt5elpTTVpleEF3STREdUNRL2Yz?=
 =?utf-8?B?NkRsZHFkYjRDMTlxUWZrTE9tY3JDNURSc2RlUTdxZ2Y4ZDBBbkFDM3J0QmZW?=
 =?utf-8?B?ZVoxcGZZRzJXOVc5YkxIVkxrdDdjYi9TK2toSkl1MFNvRU8rMkw0Q0RoaEo4?=
 =?utf-8?B?aloydW5tUWUvd0E4TUdDQTAzYjV3d3FBdXF1VldWLzNVQU9ORWNndFEySXZX?=
 =?utf-8?B?bDNPMlF4VjFFejRsYmNKeSt6MmRpdit1VUZPR0pBRm1QRUdZNEdpenY3UGwx?=
 =?utf-8?B?dDZXVjdkaTdjak5pRXhMbitqUGVlb0p5b0FsV0ptNGdncmhtbnBIZzVTYXVP?=
 =?utf-8?B?TDJkOWRCZGFsYkZFU1JoV2JrM0cxdzNQVHVscHdFdXM4VWE4VnZIM3o3NC9V?=
 =?utf-8?B?cmZzRnVzdk80ZDFESVRrSXRZUFBpOTJlRVZlQk1JWTZIaU43NTFwaG1YM1pl?=
 =?utf-8?B?WDBNcDJxTFN6YXo0bFNlYllMQmhBMUpjK1RtZjZDN0kxblQ5azlNRnFQYitx?=
 =?utf-8?B?cWNGZEtjSUlGZGNNbzYxcE53ZnpER3pZSFF0R3c0eDl6SGc4R2d5bmc0c1J2?=
 =?utf-8?B?b2pLcFJYM0FLWU5iSkR4R3gzVGxwK2RVbmFIS2gwS1FsWVdCdHFTNURjMmZa?=
 =?utf-8?B?T3c0RFhaQ0VkYlNIWUVML0gwSklhU2RRRklrRVVMeVhVZEYwSG1halMvSXpC?=
 =?utf-8?B?ZHpueE03cWFOdmNxbXlJUlllVXc0ell1SzZ6UEIybllxYm5EU3FBM3NtWENl?=
 =?utf-8?B?Vk9qYk0zL3c3MTFmNVY1Y2lMc3QrS2dUYVZWOWNKU2dBTmNsYjRHcnJPRTB3?=
 =?utf-8?B?dUMxdVI5bDNlZ2FRZlp3elFqbTViUlU1Q0gvdVpsUm45Nm5GbldMbHF5Tnpj?=
 =?utf-8?B?bFBFWks5L2VGWGRYejkvdU9DdUFNKzBBMGFlcm55eFRqQ2xxL2VRUkxCTGor?=
 =?utf-8?B?a0U3bUQrT3IyOFAxdE1sa29KWTZESkMxVnBNRWNCS3UrcWpOSmlOZ3hBMkhm?=
 =?utf-8?B?UW1kMkY2aHVqcmZ0dUFYRUw2ZkNyZlZYOVgyWng4b3hGdWFkZ0ZKRG9POG1w?=
 =?utf-8?B?SGxpTDhSTnpwSnR0MDZUbTMyZVpEZGhVK2YxTFVGTmFZa2hmcWdwUnFwSVNM?=
 =?utf-8?B?K3JGMGxjLzkzR1h6QmplNXZOMHVJVHZPWHRnQkxXN1Q0MWE4WjYySkhzMUJK?=
 =?utf-8?B?cnZ3ei82Y3NJN1lFNVYzQTVFZFc3RktYMm5GenB0cW9sTnB3VWtraUlGdnkw?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rnk3k5+8+hktVqVMMemh2ahITjMMdyZ0HqyqnKRkp1O35tBxKZslBTvoi9TKetOoXFlx0GhBImPrytkm5L3iQu+4aJKW9iq9qUO4p6UKRLuAecF+s+KVW0CwwA7sq3yXPPsoiAESY7dOY0Tyf9h89EIFmm/i9N97yoxmDhl/jN3nVziqRRlzrs1crbKsRJ801si3z/+QZGu1f9NSwG+kvhPvNktaEnXMFHWgViAL+G2JEYso4BOokubc62b/rYXROgia7hE1cKo2M/OHSL25s5MrpuVNE5bgYG6xStCoruyfIszuZ7IJW+fTgV7zqtmxCqaca7Bk7YmRQuIjxnTlo9/1urvRlT0aLSEqntHk2g/LFvA2YDZ4j6gSHlYm8FGzjPElby6JXFy9S3F7jHEVXaxwjyM23tthdpeyybPJe/ZLkmTDWc2wdzjpyKeeqVHiI0jbnQU0o68EhOjBQnW0QgHTD9dRQi2FCCINHPDqeUs1CBVWHQn0ImpJvNidStQrJoGCQaz2xeTULplMfd+e+xexqRpL3VxGa6PC3d1OANO0A9t4Hcvv/XLzSWLutO/qNpvnnNYyh4SuiW/68FK3WkZbvllOgsTifQ4J9z0QB2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c045c0-9f77-43ff-b509-08dd3c8dc920
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 15:43:02.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UPw1mNY9OspJ1WLBVRVuJhQbGvYQiM71UxZXIYMC2oZd134XDS465yMNN+3b1IK3J9LA8/JIpH+kPov1t7g3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501240111
X-Proofpoint-GUID: ZsPKVX6jSIiBYWUlNSI3iSEpRO5p3BES
X-Proofpoint-ORIG-GUID: ZsPKVX6jSIiBYWUlNSI3iSEpRO5p3BES

On 1/24/25 10:31 AM, Jeff Layton wrote:
> Stepping back, when we do find failing callbacks, should we be doing
> more to alert the admin? What would be an appropriate response?
> Ratelimited pr_notice()? Conditional tracepoints? Something else?

If we can identify a reasonable action that an admin can take, then
pr_ratelimited (or once per client instance) to report a decoding
failure makes sense. Report the IP address of the client that is sending
us weird crap.

For the more conventional session failures, I'm less enthusiastic
about logging these because frequently they are the result of
transport failures (or a suspended client, or ...). We'll have to
sort through the various cases to understand where a logged error
might be helpful/actionable.


-- 
Chuck Lever

