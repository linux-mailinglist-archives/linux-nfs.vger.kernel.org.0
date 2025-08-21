Return-Path: <linux-nfs+bounces-13836-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C052FB2FE03
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 17:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B351C2131F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB1B2FB610;
	Thu, 21 Aug 2025 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qFcmDxwD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oZGT2gFG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F82FB608
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788994; cv=fail; b=YRNwJYfsguL/PTRbccWCr79bw2kcQFBEUpIynHRu4D9hULhWab8IcLH4D5WXqn27S2gxjR07GYcywSXLtoTSAtF/C03SfCS3SBXtG0YKlr9ZGUzQo2gHFYfNjp6i8nNq9lFe0C8E6uUlaagR84tpPdjuM6Bmk2efvQsdmWFu3I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788994; c=relaxed/simple;
	bh=15eiwaQxGmlTO/5uP6HEM/CvH9X/p80VvsIVJZS3J7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j6sRL2f4QvRus57mVvqOn3Gj7GBwcvppkVak+MxUbo8zoC8SU3mcYvlsrikj1OMWFjFuO/yQNOXJYdZN5zDrvg9u1jGAu4ObOH+NnSIPENdUkjL5YAdbx5eHpNESbnbksgNdYV3EQJamNLVFbDQAMuvBUGo0wBawCmz3QF6nr/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qFcmDxwD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oZGT2gFG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LElBCs002601;
	Thu, 21 Aug 2025 15:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kiR4a7CXhHhbMyfG+hiaptaZLyu3MgP9ntPZJHLArBk=; b=
	qFcmDxwDGLBS5Z4WdBt8U/Agzx+t/uU97Rt0iuMBFlxN8TOvSZQ2q0OAEVELWMPz
	CaMv6x1yBT+jETYTL0W1lKMlSRLF8RTo5jK+oTtzf02YRz/DZ7S4gdiqpColbmsd
	oRQVzHWsunvowJ7yOzKvHMjA0QO+0aP4o6qLq/P1clOCtkuelM9oeMeATNfVKBGJ
	lAxkHMCuD4GrdVAmOLG9/UnfGPrenuXCEobjfhKwnbX0t3K2aJPRS9aJD8IwEfvw
	Bny1ummtCIVFAKLGfgjo2ElEFSJpuGi+XoTpk466OZlhnrGgxnOSa9o3c/6kIPl5
	c50d7Wj5J2IWZxv6llS3wA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tt3rh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 15:09:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LE9pRA020677;
	Thu, 21 Aug 2025 15:09:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48nj6g6fb8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 15:09:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tid4+11GsDx+ulm9GLGFSWzDdC/k30qiT8jYV5PBlojRWyB0XKLzmaISIlwPs6KRZB7eHsu3EcyUhmknqOtubT0FlnCXOri+Kv4O1t1nZaeisTU4ah796Ki/iAt0e0JMDakHpHTJUaMTJDNNutwhdqrFFi0k0i5bpUMpkDyGymqldmG+QSNLWWEhcAnMN8RPFvooaHcQo0W/izHHJ1X3HhI04N1Ifyx842jXrH34XSf1X0G0zWNgAkeoUJhYiGxg5AeYNyhPyIbUO3R7NQScXMZ7DCq0P+qgWrNf7o6CPNjXejB2X6PC3Nl+A+tkT8+gP/hd9B21EKehEIu8RHH8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiR4a7CXhHhbMyfG+hiaptaZLyu3MgP9ntPZJHLArBk=;
 b=EIohRp3KCDUmD47foiC+Mram3uEh8ChS1yGhZ91QgBkQxmBssHiF242/Q/N4h6wS1aZV82SapzCKyRjOHMhIe5XZbVv5Cdi0M2YBvEbpQBMdCNLGG7DJVyO3Eb8lCJKabIAdohUHF8zmb82EguMH+fFEWRsddbPy08S27nZOtc3tAnWoheM3Gox791okBiWTkbMwYtL5x4MbwKsG2JCR3mvi9iZnthAOjgfyQArAJKDeRpDib2FoMr9h8XWG/45BZWCJrZ2pEw3ZOZ8c03xWD4T5OConsN8omCnB6Sz/+0kMKrd76un3sjyF4B4zOJwztch1mZArW04xqo2F0nod+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiR4a7CXhHhbMyfG+hiaptaZLyu3MgP9ntPZJHLArBk=;
 b=oZGT2gFGfMmOTv3p7BjoRP+WJM0s9OP46maTZVqNoG9pXn8T33LXhBX5GCZVIx4u6qJvN7vmhEwtaoU7Log2Sf2U7nHxBBt07U7BzxUObfWyyYivUKmuRxrXfA1ra+VOQPI1rdQkl5yRypEqbmys7jZGpHa51UoGYHeWLu9+Jgw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4843.namprd10.prod.outlook.com (2603:10b6:610:cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 15:09:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:09:36 +0000
Message-ID: <8d72170c-ac40-4652-96ef-5ca39b2cb0c6@oracle.com>
Date: Thu, 21 Aug 2025 11:09:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] lockd: while grace prefer to fail with
 nlm_lck_denied_grace_period
To: Olga Kornievskaia <aglo@umich.edu>, NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
References: <CAN-5tyEammkfv3QGwe5Z38q1nFAxYV=REFDN++3XrX7Lni+H0A@mail.gmail.com>
 <175573171079.2234665.16260718612520667514@noble.neil.brown.name>
 <CAN-5tyGXxzmMipt8fcdMkpSiPq8cxF5++OJcZriQbcjk9JK3GA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyGXxzmMipt8fcdMkpSiPq8cxF5++OJcZriQbcjk9JK3GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:610:5a::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: e99951e9-cc3e-48a1-fe46-08dde0c4bdcf
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MlNscGNmTjFhbDVEOHZlT29IZXZwYlNLSVJic2Z4VnMzcDc3VTJhbC9uLzVL?=
 =?utf-8?B?WU5wQnRyWjNsSnUxY1FQMUEza05DTm03YmMyeklqS2dGM2haa3pNZC9wL3BF?=
 =?utf-8?B?dHJsbkh2a1poTGtiRHFpc09YUVc2b1lqeXhkL3FhaXdHS2NhclltRStVR2o3?=
 =?utf-8?B?enYvS1B1WUV0Ti80blhRSUxaT0ZCa1Q5REp5a0NDV0ZUdFV1RzhBSjVocXNL?=
 =?utf-8?B?ZWNmYXJKSDdzWmJTN2g3Q0FmR1lZRlQ0dzFpNDlQRjA3b3pyL3dlV3VaZzV4?=
 =?utf-8?B?WWE1Y0ZWSS9BVU94L1VPLy9DL1kyZEEwN1BZL3gyQ1JKNFRhaWErV1RSTzQ4?=
 =?utf-8?B?WE9VOVZBbW9sTG5MNzJsNmN1dTZkUW1OUFNJRTdNb2xJcFdoenV2SjZGS0lE?=
 =?utf-8?B?OGtPVlUrRWdla2pyR1A4NHM1VWNySnI4STFwTGwzNDg2S1Jsamc2cEJiYnYx?=
 =?utf-8?B?VkhPNUJUaVJsYmhCOWlCbEZxTkhWYk1aZitTcWNPSDdnY0RFclVqcXV0TFhR?=
 =?utf-8?B?Tlk0bjRFTnA2NXNBQmNVR29SYnRDWStKL0U5aWo2VitNNExFMW1DZzBvM3Vs?=
 =?utf-8?B?b1p6Z0pmNGJ6Ykd2Rnd3dU5WcXpoblpJRlV3ZDhUQ1ZyaWtIbGZWM1JUVG5P?=
 =?utf-8?B?emlQeTUxTnZ2ZmkzSFN0VXJlN0g5VWJsT0V5NWFEdjk4VFFQZVFPQURsNjIx?=
 =?utf-8?B?M1pBYWdOQm0rd0hxaHJYNlV4VVBwemJWNEgya0RnblFyR1VBbjFhdU9semRo?=
 =?utf-8?B?VWJRWFFzKzc3cVVpSHVhOGtSUGt4eWEzUmtISWsyUkFQelBDclFkSVRja2dx?=
 =?utf-8?B?ZTdLRDBoQzRua0haeHhOMmpVNjBaemQ4d1VlOWhxcEsxRXpYZUFzRWhQZm9J?=
 =?utf-8?B?V2IzZ0d6WUJ3aGd4UUZwN2lkUmRWUGt1M1ZTS2hqVGN5SzRDR3I2Vmgrak1u?=
 =?utf-8?B?WlNvRGNBVERxbHJxQ1NjRWFnSFIrWW1iQjNqb2pIQkdFYi82dXc0Tk56aUJQ?=
 =?utf-8?B?R2MyZnIvS0tLaVFqZ1dKM3FQKytvYnhlclp2YVlqYW4yMUhKQ2R2Vm9xOUFI?=
 =?utf-8?B?R085alB6enBZeDVjd29LM2hrNUsyck93OXNnUkk4bXMrWERKL0NnQWI0R2FC?=
 =?utf-8?B?bU9hWGNaaHVaaDljeS90c0JxTTJSVHcwUUxNeTMzNDNEdXNDNzhjNTUxY1Vk?=
 =?utf-8?B?TGRiUm8vS3BRbXBKR1RGVjZrazVVRzcrSUhiTFFMVHlNVVR3cnpHSDkzc3Fi?=
 =?utf-8?B?SVJyaG4weDNZRDJNYWRML3dqSUUyVlZaU2hVNHdrK3BhODdtMDUrcEVBVmwv?=
 =?utf-8?B?WUV3ak91KzBKVlhKY05ReFl0L1RaVVVKZFk3aHlLbWR4dTgreFM0bTJmZVFt?=
 =?utf-8?B?MC9jVHAvVitNQnRPdzd5NWtjSS9BWExROEdtUmJZTEo1NjB3bXZMWlN4Rjhw?=
 =?utf-8?B?aVBDNUdnTDN3VE1USEVNOGNkb2Q5UmJET000OTZNU2xxY1hMQTdLODJ3dEw0?=
 =?utf-8?B?WFFDa01tNEVRRFNuSkdkZzJJOThpZUtBR09qclJLVGxxTU9HM0tiRWEzMzJv?=
 =?utf-8?B?Y1d4QkJRcDJRLzUyYXh1MkRrcXBINU5oZzZPRkJQOXFsaGJKT1orK0duNzlP?=
 =?utf-8?B?M0xFc0JtNkF0em5WSXFoYkFXSkF2a2JNNW5rT0V2TkIwSnFzSTZrTkZSdlhi?=
 =?utf-8?B?MDhtTnRFZElhTFkrb2NWRkpZY3RublVpcnl3MGpmQkp5MFYvS3dlTEVXaCtL?=
 =?utf-8?B?eXhHRndsS29uOUxZejNaR1Fiak1iY1RWMjhqSmErUHRud3ZRTDdJM1htb2oy?=
 =?utf-8?B?Z0hzaGFJaEhtUElyV2pNbjJSZ1lyZWZQeVBWdE12cUFuM2hSN0ZoY0RsaDli?=
 =?utf-8?B?dExGdHRaUU1aZ1hITzhwaUdzKzE3SHdNdENVL3BEU0RwQ2IxWWxxcndHbDJ5?=
 =?utf-8?Q?dQculGZEeUY=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bzFnYU5zRktGR3p1c1Fsbnh6YndZSWxUN3FxMkZHWUdDNFd2SnBNKzFhQTFB?=
 =?utf-8?B?bktxS2NacFhxelhxTGR2SXVCRVlndXR3MU9TVzNiVmZrc0d4dWdTdTlYWFl2?=
 =?utf-8?B?Y296RGdEdGZRZWN2VGhKeUNpVXpsYkh1azBtN3lzSTM1R3U1ZmNyeUpvcm9M?=
 =?utf-8?B?MUk4NmFWUlBWc1JUdFVIM0xMRUhoYm1XN1pzTWFDbk8vcGlOUWlwajNBV1FT?=
 =?utf-8?B?KzdOQlZqOCtsdmtrK3hWNkNDdUZDVHlFNUo5c3FTQ25Pazh5eG0vL1N2czFJ?=
 =?utf-8?B?YzlpWHN6a2pYNnpPdlNSZDlYUUR5TE9aVkxHTDlOcjFrVU1xU0F5elJpanJP?=
 =?utf-8?B?dGx1ajI4Z2pMQytFZEtSRWtBMzloYUtBay9uajZGUDg1YVJaejJjRmNyYk91?=
 =?utf-8?B?TU82RGxrT1I0VkRraGVSOUhUUGJZdDhLY3F2SmxScVBNc0RKWGh5Tm85MWMw?=
 =?utf-8?B?cFN6MkVucVpVVnVpNzNTeFpRTVNubVk4UFdzN3dENUVHemNWQUYzdlBLcXAz?=
 =?utf-8?B?VGhnQkFIOTlCRXZmbG9GRmJPc3VrMXVlM0daKzhDYkNMQWprWE1IUEllS1Bj?=
 =?utf-8?B?N0pUWFdoZUVmUVpPTmZPcGtVd0ovaHQ4SUJkWDRMOXVOckRKOGxuNWtIOTFh?=
 =?utf-8?B?ekJLN1hwdWhINWFHRUFYeXcrL2tERjZKcU94SEpBMGZyWVZEUk1JdVlXMWFp?=
 =?utf-8?B?alozQTlTQVk1eHVvWXg4a01pcEkwcFhrZU1FTXh3a0hVQjN1aXRRem9BVWZK?=
 =?utf-8?B?TjV1L3VQd3BtNWNqNHk2NHZobHZ4ZXVleDhqcVVEemZCdVFNdFpFK2FkdFJC?=
 =?utf-8?B?SUY5QkZsdzY2WXhJNHN5bHhGdkFFdC9DL0RyZG5hVWNqeFQ4WEJRTGx4emNt?=
 =?utf-8?B?OUJmY2pVamhKWXVoZ04wLzRXdGRMb3dKVTM5R2Q5UDVjVTh2dnVBWjEvVjRX?=
 =?utf-8?B?eWlXeE1DTXgrelZxRGZVdm9xMFNQcGNKaHU1OW5XWkE5N0M1bWtwZ0xJY055?=
 =?utf-8?B?RWRVZDlhS3VWd1BwdlNqSXpySXE5N3BMMGhXbDAxRi9CYkZPZVM2SHUyckZp?=
 =?utf-8?B?d1F5TU5rVW5SVi9sMUZ5N0JRc0M5OFFVVnpSQk5GT1JicjhwSk5uc2hKelpi?=
 =?utf-8?B?Z0lGMEJsWk5WeE5sTzk5R3BKRldoTVJsZEtHZndqMDlXbk0xUmV2NGxIcVRy?=
 =?utf-8?B?aTJ3RFpRZzRoNHBPSzdBMjVCdk9jWHJ2V2piTEdsL2pBWTBVeUhqSWhWZFVF?=
 =?utf-8?B?akN2cHdlRFBFaGRSZC8vbUhOZHU4NWk4aDQ4L2ZTalJiQWkxenNjZWFqa3Y1?=
 =?utf-8?B?V2wvY3RCa29zQ295Zjl4U0wxNzFJTG1UUWdTdjJ6S2RXUzZEVnB4MjFtSTZn?=
 =?utf-8?B?cXhyQldqdUZKRWNaRGNEaFlGKzM3enZyTUxkVlVpVFhsOEpMUkxaSC9sTnJU?=
 =?utf-8?B?Wm53ampIUm9hSll3d2dUS1ZBdy8yRzJsQUloeG8xNzNsLzl6ak0wdCs3Nkhj?=
 =?utf-8?B?bEJZRzM4NzFBRGQrY1JDOHNPZ0RQZFpOdjhhWkwzOW1kUkRRcjliaWxTN3FW?=
 =?utf-8?B?NkNoMml2K3R6aURnT1dvUHEzaUtzZmtGdCt4UGREL0paa2IwczdXZnVoTWlC?=
 =?utf-8?B?QVo4a1dqa2UyVG42SHhkNWVXalVldFZ3WnVMcW12Y0NyaWY3K2hQQTdXOHFO?=
 =?utf-8?B?MEI1cVV1NmNKU2JNUjdZMVh0azluUkZISm0zWTZOdGVzWG9IS3JlSXFBYXZm?=
 =?utf-8?B?L3pSdHVDMWl3cmVyQ29OcWpKSzJEWmttUnBtTzJXR0dScE44Qmp1dnZnSHZz?=
 =?utf-8?B?Tzl4V1ZMUmc5RkJMNlQ3QlBtNmc3dGxpVU5BYXordmVlWXJ5YVRKcFMrY0th?=
 =?utf-8?B?Z0k3RERyTjlsRGVqNWVZRUVNdGNXN3VXTDFJdmNNRklsYzdlaTlYZGxOZm9D?=
 =?utf-8?B?NFpIY3c0NmxpTUVtWGwyTEh3eFBvQk1Tdnc2STdhamM3a3oyQlJNblFIM0xx?=
 =?utf-8?B?NUtxaTBZZHBRNXFDeHZkYnJjbzZ6VFlydVhVYVNqV1d3cmNWQVRPSWZhQnhO?=
 =?utf-8?B?bVBhRWtVSjA1QWhOdFpqL3llc1pRTUhGVlV1Umh4UDNvek9TOGp5b0NnUFBB?=
 =?utf-8?Q?t0CYQblL3CKpWq7KeByaIzaBy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K5tfAMXgkLaZ32aol5dWI/Q22C/3c6q+DlukS2LqQ3bhnkrCizWT8hpwXjQClhL6fKVICI5u7AetS5cICXq9v6pmpshee5U2woeJTT2InaYsc1DF72DnR5EtP1YaCw/GKUX5+hOuL09ewr81Feabd6Gxl/C2yVX9oumIyShlEiLcByntk6+QZ/0hnKoc/FaXUtgL0ldSf0slgh3vsHyzAWnTbrF0M3sNgA4wMIBILNnD1zJaSkNxXyprPP/10CZL0ap/eY/G6b2WfhGZb54uNfXDjYN33PDTABmfUKTiSGVUN6Q8AF8gyecychCO8mPnGC401Bw6W9cUtD3jm5tNDq1GFmHlkS0CWaMpDGfqk0WCyJGsei/w0xfClwO/gp7yh4vOu+3yiQpbKYLJU+ZYSbGCPu3VPnZdnpA/spJHjpQ2Jm/nM78ZUfDqYGbPJcdElDMtXpsappDLmkTYukP3SbbYyUAhFuQQXj5e8byB5jdXKUeRwjjDkGWXgnRiwMTWG9FehIbDq53Wbiz1B2NQFlCkly7y3L6+V5JapVmolbPQ5GUeaDUzMGbP8hnVW95vuZ3z8JFpsW20/z95xbIrxAqPPgiEiM0mZxR4uwtdzCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99951e9-cc3e-48a1-fe46-08dde0c4bdcf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:09:36.5943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgeyMRycQTD2FxwFbC/2hGUaM3Iz/g0zu/gZqcrnLTDIZLL4bVtW1ybFhDKUiPyQoTc/mShp19YId6Cnf1PQSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4843
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210123
X-Authority-Analysis: v=2.4 cv=YvRWh4YX c=1 sm=1 tr=0 ts=68a736b5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=mJjC6ScEAAAA:8
 a=HHIqi4Iterr6EpXi5dkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ijnPKfduoCotzip5AuI1:22 cc=ntf awl=host:12069
X-Proofpoint-GUID: z2XKycJLOyVNL1ue6MVhJiBwl1gtFY2Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NiBTYWx0ZWRfX0pJx87BJEudM
 y/nYHVMAHwvo2hFW3mnxPw/BpeBAtqqfGfEAdinRQkcNnKnRqipQbzjJ1g76duYtVTtdtZ/KYyQ
 3oUv9j/0+0i88q1jWu412bzBa8MQYluHcePqF+zhvt7U/IQtTYRVorsukd4pSJoxXfW4/1ogAgf
 lxfbPQKOwiPbODbrVsoBp7yRZ/LSZRvogaBOiHM9gLH1Iy8a10nlfAOvcZYDVoO0xlwS/d7Kq1z
 Vk4PJnxyWmBfU/WSGdoFaNr3Y7FxEn6H6595M/s3zWcl6pdViOGO58VynUgAz1xxsg+XM4DWbcT
 pfPLgmB5yOYXbrrHdpcd1phinp87CQMCNuDo6OeD8h4R86YApEK0NEcGeR1dIcoEsVXrb5dHqZz
 HUwqRH5mt9Mn0oeQN8Pp2GN9fwFa0iNUCx+vnTgRVjHLxaJOwkk=
X-Proofpoint-ORIG-GUID: z2XKycJLOyVNL1ue6MVhJiBwl1gtFY2Z

On 8/21/25 9:56 AM, Olga Kornievskaia wrote:
> On Wed, Aug 20, 2025 at 7:15 PM NeilBrown <neil@brown.name> wrote:
>>
>> On Thu, 14 Aug 2025, Olga Kornievskaia wrote:
>>> On Tue, Aug 12, 2025 at 8:05 PM NeilBrown <neil@brown.name> wrote:
>>>>
>>>> On Wed, 13 Aug 2025, Olga Kornievskaia wrote:
>>>>> When nfsd is in grace and receives an NLM LOCK request which turns
>>>>> out to have a conflicting delegation, return that the server is in
>>>>> grace.
>>>>>
>>>>> Reviewed-by: Jeff Layton <jlayton@redhat.com>
>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>> ---
>>>>>  fs/lockd/svc4proc.c | 15 +++++++++++++--
>>>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
>>>>> index 109e5caae8c7..7ac4af5c9875 100644
>>>>> --- a/fs/lockd/svc4proc.c
>>>>> +++ b/fs/lockd/svc4proc.c
>>>>> @@ -141,8 +141,19 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
>>>>>       resp->cookie = argp->cookie;
>>>>>
>>>>>       /* Obtain client and file */
>>>>> -     if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
>>>>> -             return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
>>>>> +     resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file);
>>>>> +     switch (resp->status) {
>>>>> +     case 0:
>>>>> +             break;
>>>>> +     case nlm_drop_reply:
>>>>> +             if (locks_in_grace(SVC_NET(rqstp))) {
>>>>> +                     resp->status = nlm_lck_denied_grace_period;
>>>>
>>>> I think this is wrong.  If the lock request has the "reclaim" flag set,
>>>> then nlm_lck_denied_grace_period is not a meaningful error.
>>>> nlm4svc_retrieve_args() returns nlm_drop_reply when there is a delay
>>>> getting a response to an upcall to mountd.  For NLM the request really
>>>> must be dropped.
>>>
>>> Thank you for pointing out this case so we are suggesting to.
>>>
>>> if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim)
>>>
>>> However, I've been looking and looking but I cannot figure out how
>>> nlm4svc_retrieve_args() would ever get nlm_drop_reply. You say it can
>>> happen during the upcall to mountd. So that happens within nfsd_open()
>>> call and a part of fh_verify().
>>> To return nlm_drop_reply, nlm_fopen() must have gotten nfserr_dropit
>>> from the nfsd_open().  I have searched and searched but I don't see
>>> anything that ever sets nfserr_dropit (NFSERR_DROPIT).
>>>
>>> I searched the logs and nfserr_dropit was an error that was EAGAIN
>>> translated into but then removed by the following patch.
>>
>> Oh.  I didn't know that.
>> We now use RQ_DROPME instead.
>> I guess we should remove NFSERR_DROPIT completely as it not used at all
>> any more.
>>
>> Though returning nfserr_jukebox to an v2 client isn't a good idea....
> 
> I'll take your word for you.
> 
>> So I guess my main complaint isn't valid, but I still don't like this
>> patch.  It seems an untidy place to put the locks_in_grace test.
>> Other callers of nlm4svc_retrieve_args() check locks_in_grace() before
>> making that call.  __nlm4svc_proc_lock probably should too.  Or is there
>> a reason that it is delayed until the middle of nlmsvc_lock()..
> 
> I thought the same about why not adding the in_grace check and decided
> that it was probably because you dont want to deny a lock if there are
> no conflicts. If we add it, somebody might notice and will complain
> that they can't get their lock when there are no conflicts.
> 
>> The patch is not needed and isn't clearly an improvement, so I would
>> rather it were dropped.
> 
> I'm not against dropping this patch if the conclusion is that dropping
> the packet is no worse than returning in_grace error.

I dropped both of these from nfsd-testing. If a fix is still needed,
let's start again with fresh patches.


>> Thanks,
>> NeilBrown
>>
>>
>>>
>>> commit 062304a815fe10068c478a4a3f28cf091c55cb82
>>> Author: J. Bruce Fields <bfields@fieldses.org>
>>> Date:   Sun Jan 2 22:05:33 2011 -0500
>>>
>>>     nfsd: stop translating EAGAIN to nfserr_dropit
>>>
>>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>>> index dc9c2e3fd1b8..fd608a27a8d5 100644
>>> --- a/fs/nfsd/nfsproc.c
>>> +++ b/fs/nfsd/nfsproc.c
>>> @@ -735,7 +735,8 @@ nfserrno (int errno)
>>>                 { nfserr_stale, -ESTALE },
>>>                 { nfserr_jukebox, -ETIMEDOUT },
>>>                 { nfserr_jukebox, -ERESTARTSYS },
>>> -               { nfserr_dropit, -EAGAIN },
>>> +               { nfserr_jukebox, -EAGAIN },
>>> +               { nfserr_jukebox, -EWOULDBLOCK },
>>>                 { nfserr_jukebox, -ENOMEM },
>>>                 { nfserr_badname, -ESRCH },
>>>                 { nfserr_io, -ETXTBSY },
>>>
>>> so if fh_verify is failing whatever it is returning, it is not
>>> nfserr_dropit nor is it nfserr_jukebox which means nlm_fopen() would
>>> translate it to nlm_failed which with my patch would not trigger
>>> nlm_lck_denied_grace_period error but resp->status would be set to
>>> nlm_failed.
>>>
>>> So I circle back to I hope that convinces you that we don't need a
>>> check for the reclaim lock.
>>>
>>> I believe nlm_drop_reply is nfsd_open's jukebox error, one of which is
>>> delegation recall. it can be a memory failure. But I'm sure when
>>> EWOULDBLOCK occurs.
>>>
>>>> At the very least we need to guard against the reclaim flag being set in
>>>> the above test.  But I would much rather a more clear distinction were
>>>> made between "drop because of a conflicting delegation" and "drop
>>>> because of a delay getting upcall response".
>>>> Maybe a new "nlm_conflicting_delegtion" return from ->fopen which nlm4
>>>> (and ideally nlm2) handles appropriately.
>>>
>>>
>>>> NeilBrown
>>>>
>>>>
>>>>> +                     return rpc_success;
>>>>> +             }
>>>>> +             return nlm_drop_reply;
>>>>> +     default:
>>>>> +             return rpc_success;
>>>>> +     }
>>>>>
>>>>>       /* Now try to lock the file */
>>>>>       resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
>>>>> --
>>>>> 2.47.1
>>>>>
>>>>>
>>>>
>>>>
>>>
>>


-- 
Chuck Lever

