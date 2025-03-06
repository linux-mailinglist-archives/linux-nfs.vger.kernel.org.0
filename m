Return-Path: <linux-nfs+bounces-10509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3305A54D7D
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 15:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD061895786
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A116C687;
	Thu,  6 Mar 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R0RJJVID";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lvn/ap3A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63971624FD;
	Thu,  6 Mar 2025 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270792; cv=fail; b=Djo4++X2wv6i0TeOGoFSwWsWMMO4oGoLHjV3H013xD+OHRz4Nhe6aaBtGDK6BBslVJC5JeE0Srq8+e712Ftj/0NbYeGr8tJ0fKiKvFN02HswjDyYPk7cjN6L23gBGrXpQUbp/xw08QyGQiY70P8p5WWYIi59wwoYRMUk9xi3Hxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270792; c=relaxed/simple;
	bh=63eK/rqvw50+BfbaywrQXD197r68EUI4sUP2wv8EMQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jzN/G1nCf+RW64FNEalG/8jDlfXL/8pP2QxPDGg6Jr1RCgxkRjm4dTOuIAr9QziHZekSFB+NEHP6z0ngF0gcjW+vrFCXcFtNhImkKuw7BP/ZukH1by4OwEAMgjUlELiG+rVkkMI+BuOg7CPBAYuAzpPCxC3mkKKuaC3vzRHPHyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R0RJJVID; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lvn/ap3A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526AtivQ006204;
	Thu, 6 Mar 2025 14:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Rn8GFFWt6G/SFFI5DE1/Lt3wkQ0wkj7PSSwP7GiEQ+0=; b=
	R0RJJVIDpYP8aqdtRIDKw7Mn8zjFB9nsqaty/sEiiSydXl4eqp4UseYuKB0za5AY
	+Jaj4k8q0G7UGXi5rWG+qwhbnaHh6izxdYUVYy8WumNl/AFRQukNL1W0JSdf3Cbj
	gVv/u95lXUYyO1nP1iihXaw8EJJt8msbEssgK1t/dd5279cRHinl6455uGhwCKn2
	6+66p2jxFFi+1xIluEBe1WG1Y9idsKapzbKWdZUQ04s1MWxwuLg80exFZ5f3HW+O
	Dg/KVZCSMpc+Bmb0I7QQ05VVe/x8otlu3829rLDqjPxrRmirmMAuRtf3LuJka+Q+
	CAIPvH86k57ktxx6g9TcwA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wt1u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 14:19:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526D57t8003319;
	Thu, 6 Mar 2025 14:19:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpc5k85-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 14:19:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaoGcR17CAG2Hqbf+0C1tlvl4qVfICs6aL2vGkfjTdY5TalPUG5IRo4YR2u9/vuh5id/gjFYybizAneyHxCcMVICHWT/11PXtGwe7Q4os/ZNYmIYRMXr5XY3EzDl1BAkA1ULOxBLfeB/LCGqgDg0bnBTwZG5rLiM63UHHFhnwbsevd2QLTWInH49Tq6D60GLJA0vwRCvqOMJcATVzN86nhDNV5cwWE6tOUrgwyP3cv+jXB3YGzFma9SN7+zobLbpeP5zoMhOXd6DZao0TGDrFzXhoUux5RbSNyO1feGGP7GVn7BmTdtkdXPkCVXZ3fwSmtaOVW7+yKo3k478PYjgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn8GFFWt6G/SFFI5DE1/Lt3wkQ0wkj7PSSwP7GiEQ+0=;
 b=QoxqgkFVu3pRKFe8BbElyXhP/3XN/jOrYrPitYyVqUIO/0tJFqc9V2gnwcfI59gmBT4il4R24SRAcuN07MlfF1SuRc6T1q907gLDzNoKy1g/+EepKBOYUzlBu+isnxlXy5le6NMuPvfywmSYNRBVQGWhSG5hY8bcbEExDuaqeNlNKqZ0ReqS0jGjIdxj+t8xCB+eny9shPmph/QW3CgCBvfw80w6FGZcwZyltlGyGsBYHu0ZnagB50EtcKek2qtTv3UH96xz3rp+09xLL8It2nQ9F6j+Zg6dfZ2yy+t3+PlfFBc4BREs6JZ+cjncVkCUnsLXEHw1a+5s+kuqdmmlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn8GFFWt6G/SFFI5DE1/Lt3wkQ0wkj7PSSwP7GiEQ+0=;
 b=Lvn/ap3A+lsFUZ5zwCJrt5vH/JXyC7EIBumtN/2+G+9dAdBoNq5p2x1YcVhsqARc0kRh8jHXdzsXawBpO6uUx8ansBcSOPbwheaX5eGayQsFdP4jDvb0snelQE3sXUIxXv2NloH5Vasu/MdQIQ2eI9VZaXY39fWVnd3NrMQwL0M=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by BN0PR10MB4965.namprd10.prod.outlook.com (2603:10b6:408:126::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Thu, 6 Mar
 2025 14:19:34 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 14:19:34 +0000
Message-ID: <e9754d28-6304-40d8-834c-e1e0aa28cf92@oracle.com>
Date: Thu, 6 Mar 2025 09:19:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nfsd: add a tracepoint for nfsd_setattr
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Sargun Dillon <sargun@meta.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org>
 <20250306-nfsd-tracepoints-v1-2-4405bf41b95f@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250306-nfsd-tracepoints-v1-2-4405bf41b95f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:33::16) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|BN0PR10MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: cde1273b-a52d-4858-f4b7-08dd5cb9eb07
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZmxacHNGckZMcWZ6bWJEeW9MV1BBZkhhN3o4bzB3dUduRVZBL3hnRG9Ec0xJ?=
 =?utf-8?B?Y01WaE8xb1pHVmFRcHl0bStpbTQ5L3dNWXZBTVY0YlhJdmU1NW9zdEZmeTll?=
 =?utf-8?B?VVlKNE0vVStzeE1Zd2VqV1NyVUZOZTdsZnhxa3FtTUpHN0x2aCsvVjNpQWRv?=
 =?utf-8?B?VWFOQVpsaHVpK1dPeHd4dVJlZjUyaUxIejNneTFPZGIyZzRKdEtOdC9KU0t0?=
 =?utf-8?B?WXZUWTR4TCtnSmQrYjVuV1hrbkNQMkFzb3IzTkRwblJuQTRGOGR6bGQvK0dV?=
 =?utf-8?B?R1J0ay80S3U1UkhIYUc3bjJuaVhYN21QNTcxaTIzN1NUMnNYOTB3MUdaRjRP?=
 =?utf-8?B?VWljcmtPZnFYZllKQ3RNMnRVNE1sc1FSekdhRGxqcFdJQmFUOVZYSGlLWFIw?=
 =?utf-8?B?WWhEdFZRV2FqemZ0NlhENWlRenRqcW1zMCtHMjF2QkY0ZG1rb1NNUis3VnlD?=
 =?utf-8?B?M3AwRWtoNUR2NlpPZm16eW5hVWhyL3V1cExzVUxEQUdaVzg4WnZXQUtGU2NS?=
 =?utf-8?B?MDNFdmcwY1J5NHlCSWFBM0RqTTZIUGN1MkNrWUhYT3FRek9TTERSNEFSMC9Q?=
 =?utf-8?B?ZzA0T0xycnRBdTBvTW9KOW1SdUxUcDRRUFlVTWIyV1ZQZ1J3VzZ0T25kZkJD?=
 =?utf-8?B?ZGlwZGxQcWh5N3VTUGtrWExzUHpqVnlDa2R1Vm1taENtaVdSaUVUTzR4VzBZ?=
 =?utf-8?B?ZGhkYzFmaTdkZW1xWks5ZHBWRE1HS2dRT2w2NzR1ZHh3cDZVZjRveFVoNW41?=
 =?utf-8?B?K1hqRkZRY21xaytXUzYxV2RCRDQrSDhUVFZhSFhJY2FqZlllT1ZCd2hLY20v?=
 =?utf-8?B?TklOYlJFdnl1M2t5NE1DdTBqa2dGeUZXZDZkSVM3SFBNSWxaVGN5SEt4QTJr?=
 =?utf-8?B?Q0MrbDY5SEo0LzJhcnFRLzFIOG9sZnlLQXFPWDNLSnVteGhnMU80WU9mYlBq?=
 =?utf-8?B?SnlkdTZOQTNYYmFMMzJFUXVtYmN4WmNIM2Q3YUtCa01ZNlgvMlp0QS8yRGd3?=
 =?utf-8?B?SlJFN243VzVNK0tNa3Vjc2lxam1CSWtLUWlLbi80cFVwMkhVbnBXNEViak5P?=
 =?utf-8?B?d0NiTXI2T1ZmVUdxUU9oQzU5WWI0anhRZ09nZ3lUTGpoNXBMOGI5MDVVUTVY?=
 =?utf-8?B?VEZFRjRQZHlnRlZYc0RoKzZnVmR0L1FmekltRVJkRWtKQ1ZjRElSeGR0TXRx?=
 =?utf-8?B?c3Y5ZE1iWVY0M2c2SkVIOWIzMDMwVTd3bFlKSmJpZHhlbnR1eUs0RnEvNy9G?=
 =?utf-8?B?Y0ZGQ0NsWHQ5MklPSUVJdW9aWGI0QlRCMkhEYVh6SitrYVhGeTdpNkpaOW1s?=
 =?utf-8?B?Y0t6RE9tbVFQMENUdngrY2FJOWZLOE1vK3Z2ZWxYLzRpTG1Gb25FSCtacUZr?=
 =?utf-8?B?akpMdkV2czBkMllsZjRCK0tsR0hUajhFSVNnMGgyUlM3TzI4YldaWVNpQjBV?=
 =?utf-8?B?KzRJM3RyU1B0Ri9jcVZmNmg2UVFNTy9TVHNHSjd6eUN4SGdXVW1QeFFlUWtX?=
 =?utf-8?B?U3FiU0lCS0NVRm10TTdHb3EreGhEWnBQcUY2TjEvR2J2VHBzOXdqSnpvTEIw?=
 =?utf-8?B?d1lKdnpoQXloeTJvdW9qVlhDak5VbjhNSkFLaExBWE5hNHdQc3RSaU5UdEpw?=
 =?utf-8?B?UmkrcVJKUlp1ZUErT09OOFFZb3FhaHdkVnRGb1hvaWk0ckJzTWVHa1RkNDE2?=
 =?utf-8?B?amZvZEFibXkyTEZKbnROTFZPMkQzUGRwZ1A5OFhFRTRLbDhLdjdITkhaN3B2?=
 =?utf-8?B?M3RhVUJoMFNzYmdUczF5RkZlb1lJOEU2anphcExFN29yMU5oQXJOQ0p1N3JT?=
 =?utf-8?B?WnptR3NIcWluUUFnRVdlQVVEUkNROWxBSlJ5c2lTRmdscHdUMEd3cVhIVGlj?=
 =?utf-8?B?RDB0aUZkeGU4V2Y2Z3dWSy8wRUozVGk4bUp5Ny9YM3JqTEVZcmYweFIxZDhW?=
 =?utf-8?Q?tTsyKcBMbRo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?b2ZkQUdQV1dZNDROZnNqWUgwN1lqMmpLSVhEaDIwandsN0VKeGpaNjFTaUpB?=
 =?utf-8?B?UkJXTlVsZEZ5TFdSUFo4VUdvaE5xTTNqOWNrRDFWd0NmWlE1L2FObUFTUVp6?=
 =?utf-8?B?cjQ3SGlXc0VOWU04Y1dxSFBSTVk5SmpsUTlPdjJJbUxqQ0lzZk9xeTltZWlN?=
 =?utf-8?B?ZERuTUxNVW5GSWIrWWEyMFpRdVM1WG9rVko5WDI4UURQTTlmUzM3SitmOTBo?=
 =?utf-8?B?R1VZMFpjME9tVDVYTGttNU1oMTFwdW1lS1h0cFpKY1lQSjdYY1M3NlZ2M3M2?=
 =?utf-8?B?dTJvZmw0VkY5ckptSjRCeVpnQkRxbDFqZ1YyYkZDQWNDdU93QVF3VGwwWUxH?=
 =?utf-8?B?Yk1xM0tyV3A2cDhBa01Ld0hjSVVmdFNGS05vN054U1V1aWpDdWxyZUwzYzhz?=
 =?utf-8?B?ZzBoZFhjMDhrL3daRXZoZmtXa1JzeXBESUdFQU83NkxUbjM2a1JmT3FwOVJC?=
 =?utf-8?B?MVpZTDF4ZHNnTTJMa1JNM0RSZm0wZHZQdmUySTZ6djdobE85KzRCQmpLeUF3?=
 =?utf-8?B?UTluYWV6bHUxbnEwVlRWSlRCSWZYR0FnZ3l5Z1JCVSs3SFBkSVd0cG8vL1g2?=
 =?utf-8?B?L0ZlMWRjM1BJVmlISnl1NTI5ZFp0VUQrVDBzeUtwMVBRTVZFMnpEUWNFRm1S?=
 =?utf-8?B?WlV1Y0w2RmlQTlo2WnFYV1NtSFg0T2ZZNDIyMXRiV1NOVkhnVmNtSytGekVl?=
 =?utf-8?B?Mll1Zk5pSmg1Nyt5Yk9PejZzRGdwd005eHMrcjB5dFllU1YzSnBraThxc2oy?=
 =?utf-8?B?V0lPbW9GRjgzUnE2MC9LeGdNdWkvOW5oWHk3QjJFVzQ0UXhkUnZqVUFlamJU?=
 =?utf-8?B?M0tXckF2QmZFWVNNVjd0cUtpUlQzZTB2YUlyVGNDaEt5U25McWpFYVZtZW02?=
 =?utf-8?B?Z3NZQ2FBc1hqMmRIdGlScFFnWXVHVHEyNm5Jd1BoeE9wRnFlUmxRZzJLc2l3?=
 =?utf-8?B?WDRIcytaVUtWQ3AxYXdzbkRGZzUrV0NlRTV3M2JDMG9zMzI5TGJQUjBXcmhO?=
 =?utf-8?B?OGFLdlQ3K0tuM3FwTzFnM2o1b2x1M0RtMmM5Y2M5Y2ZJOW9kVHhtckVGVlVu?=
 =?utf-8?B?SVh4cDJTTlJPdklHUmtKbU4rR0cxblZjSHhMVjhsQ3JPcG9qbDgrYjFGM2ZD?=
 =?utf-8?B?bkJBZTE2Y2EySG9kN3JYZ1BYRWJoSG9LMVI0K0kzNjBRbTkwSHFnYTAzQjB6?=
 =?utf-8?B?Um1LR3lrNzZ5L1dKWnNudWt4M0xIU0xWV3AreEtScThCRjJ0VXhuT2hObWFM?=
 =?utf-8?B?ZmV2QXlVYU5xdUdoaXRhNVc2YWhMYTFvYnZEa2g4TnJ0SXNzUEo5Qlc5aE5v?=
 =?utf-8?B?amN4N0dCZ2VGR2xKdnBXSytSRjFTM0dZZGFhay9GUW9QUnowcUV5OEs2SUFE?=
 =?utf-8?B?OFVYTEIxbnRrN3crcWtVQ0d0MCtNdnF6Q3Z4bUpzVXlTQ1NtaWU0USt3ZVFH?=
 =?utf-8?B?REdCaFQzVzJBYmZ1YWJkWTIxaGw0aE16R3dreTJTNTJjU3lEalNiU1RrV2lB?=
 =?utf-8?B?dnBMN3RRVndFMVoyU2VaK2YxRTdsR2ZMZWYrQnFkZzFSdVFKQzE5ZVVRN291?=
 =?utf-8?B?QjMrVlZpZlQ2ZGZaZUIxa0diZEJZZHU5cVZjbnFTUm44WkxoeUM1cklEdkpm?=
 =?utf-8?B?Z3BFL2dKS3dtQkJCVzN5V3JsQ2JJUHczb2N0bmVaT0lqeEo1T2pzUmZZc2Y5?=
 =?utf-8?B?NGVKZ2FDZ2xUdlRKSCtQU2FQVUJIVytxejVVZDQ3cHhnNThiTCtNNEl6dDh5?=
 =?utf-8?B?NDBuYU5GWEtOdmI3bXQ3MzdSTXZBOFJvcGFhbDVPMDZDaUFURTZCR0h4NTgw?=
 =?utf-8?B?eGQvZUFyM3JWN1JvQjIxMENBWC9pQXNvbWVFV3pMOS82S25wWG5HMW10U0Yy?=
 =?utf-8?B?VGIvSzNvUkxNdFZYMXVSUmVQN2tVNFVzblNCOE9BajhjV3h0L3djTnp3NFdZ?=
 =?utf-8?B?VHNHMHZ0cFZwVG1ZOTFLWk1MS1g2ZHdBcHVyR1lzajhXakk1RTdVQVFERXZW?=
 =?utf-8?B?dHl5VXI1aDZMSmhYUGxnZkM4K0JhNHB5Qllydi90dHlXcnk0VGZnZkU5RFJT?=
 =?utf-8?B?Kzg0cjBHM1VtYUlsOFIxbXpBVC9hV1ZkL3F1clpUUnNWdmN5ZWN0bGZKQWwz?=
 =?utf-8?Q?JoRiV5VEeEOAY6vhGUzI8Puyj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	924lYEPXTrlopxDnaxISA1YTt/PT80Ew7hoOTEZoTltTsjs5TQr66tTT2TkdRuc0SVJceLm+nSSiRcqS/BW6lBMgXZiFlROWdzxcf7hA206bF4TXZfRZ7MMjHOumLJ5Bq0STaJCTl09NwKXj/DD54VM5VYPWe3nMIJGkT/SQ7k8+G1/BhxjTMcZwcS2ObM9or4Lw8VHmipq2zIhqjMtPctHyrQcLYk2sCwrmwiSZe9cv18wXL7n5q3tt6Kuq0wp1/s0uy3d8wzaGU+vdi9paZ4Hx372tSYxGFNCtg6nr2rv7uHlUl+VRY3WYPPA9pLvX/BxAWMoGztFTY+gU/GZvOGBpa/lUAb4ce9XJi2H4VCW4LY6NbKuCT3zX0VRp8qiYZeSEIIns6HD4nFToJsiVAWRmeyqzkRm+YmpHDkChOsQHZ0pPnkspIyJDqdTNqwdd26c6rj1J5YTLH/OuoK40tHCKIVQTdu94309tJPbpyyekk0mOWsY9Gghsy83xPEUH9dvN8mcCG3UGhzS/ATJyZjkO0k+QsQ5Y+6Wne5/thTpfBnTAmCsT8nmNCyhYPEoeD23k32dbcJqh78+tnUz68xyK0ovg+pg6mENxzq50N4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde1273b-a52d-4858-f4b7-08dd5cb9eb07
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 14:19:34.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QH2+q2MQ61lZNQ3YlwfrrrnRiNroy9Bye+mwWL9iOqmqOXPKitTghBCja3dgrEdHbXJrnMkQ2+kj8q2s26O67g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4965
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060109
X-Proofpoint-ORIG-GUID: p3Q_DEtoZfnzZaY35rlcsTVEBq98JuVk
X-Proofpoint-GUID: p3Q_DEtoZfnzZaY35rlcsTVEBq98JuVk

On 3/6/25 7:38 AM, Jeff Layton wrote:
> Turn Sargun's internal kprobe based implementation of this into a normal
> static tracepoint.
> 
> Cc: Sargun Dillon <sargun@meta.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/trace.h | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/vfs.c   |  2 ++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 0d49fc064f7273f32c93732a993fd77bc0783f5d..117f7e1fd66a4838a048cc44bd5bf4dd8c6db958 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -2337,6 +2337,60 @@ DEFINE_EVENT(nfsd_copy_async_done_class,		\
>  DEFINE_COPY_ASYNC_DONE_EVENT(done);
>  DEFINE_COPY_ASYNC_DONE_EVENT(cancel);
>  
> +#define show_ia_valid_flags(x)					\
> +	__print_flags(x, "|",					\
> +			{ ATTR_MODE, "MODE" },			\
> +			{ ATTR_UID, "UID" },			\
> +			{ ATTR_GID, "GID" },			\
> +			{ ATTR_SIZE, "SIZE" },			\
> +			{ ATTR_ATIME, "ATIME" },		\
> +			{ ATTR_MTIME, "MTIME" },		\
> +			{ ATTR_CTIME, "CTIME" },		\
> +			{ ATTR_ATIME_SET, "ATIME_SET" },	\
> +			{ ATTR_MTIME_SET, "MTIME_SET" },	\
> +			{ ATTR_FORCE, "FORCE" },		\
> +			{ ATTR_KILL_SUID, "KILL_SUID" },	\
> +			{ ATTR_KILL_SGID, "KILL_SGID" },	\
> +			{ ATTR_FILE, "FILE" },			\
> +			{ ATTR_KILL_PRIV, "KILL_PRIV" },	\
> +			{ ATTR_OPEN, "OPEN" },			\
> +			{ ATTR_TIMES_SET, "TIMES_SET" },	\
> +			{ ATTR_TOUCH, "TOUCH"})

Let's add the above helper in include/trace/misc/fs.h instead.


> +
> +TRACE_EVENT(nfsd_setattr,
> +	TP_PROTO(const struct svc_rqst *rqstp, const struct svc_fh *fhp,
> +		 const struct iattr *iap, const struct timespec64 *guardtime),
> +	TP_ARGS(rqstp, fhp, iap, guardtime),
> +	TP_STRUCT__entry(
> +		__field(u32, xid)
> +		__field(u32, fh_hash)
> +		__field(s64, gtime_tv_sec)
> +		__field(u32, gtime_tv_nsec)
> +		__field(unsigned int, ia_valid)
> +		__field(umode_t, ia_mode)
> +		__field(uid_t, ia_uid)
> +		__field(gid_t, ia_gid)
> +		__field(loff_t, ia_size)
> +	),
> +	TP_fast_assign(__entry->xid = be32_to_cpu(rqstp->rq_xid);
> +	       __entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
> +	       __entry->gtime_tv_sec = guardtime ? guardtime->tv_sec : 0;
> +	       __entry->gtime_tv_nsec = guardtime ? guardtime->tv_nsec : 0;
> +	       __entry->ia_valid = iap->ia_valid;
> +	       __entry->ia_mode = iap->ia_mode;
> +	       __entry->ia_uid = __kuid_val(iap->ia_uid);
> +	       __entry->ia_gid = __kgid_val(iap->ia_gid);
> +	       __entry->ia_size = iap->ia_size;
> +
> +	),
> +	TP_printk(
> +		"xid=0x%08x fh_hash=0x%08x ia_valid=%s ia_mode=%o ia_uid=%u ia_gid=%u guard_time=%lld.%u",
> +		__entry->xid, __entry->fh_hash, show_ia_valid_flags(__entry->ia_valid),
> +		__entry->ia_mode, __entry->ia_uid, __entry->ia_gid,
> +		__entry->gtime_tv_sec, __entry->gtime_tv_nsec
> +	)
> +)
> +
>  #endif /* _NFSD_TRACE_H */
>  
>  #undef TRACE_INCLUDE_PATH
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 390ddfb169083535faa3a2413389e247bdbf4a73..d755cc87a8670c491e55194de266d999ba1b337d 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -499,6 +499,8 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	bool		size_change = (iap->ia_valid & ATTR_SIZE);
>  	int		retries;
>  
> +	trace_nfsd_setattr(rqstp, fhp, iap, guardtime);
> +
>  	if (iap->ia_valid & ATTR_SIZE) {
>  		accmode |= NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
>  		ftype = S_IFREG;
> 


-- 
Chuck Lever

