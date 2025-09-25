Return-Path: <linux-nfs+bounces-14710-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F96B9FA40
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 15:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91E62E2860
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 13:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547E027703E;
	Thu, 25 Sep 2025 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LZzdK5Ff";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a/Q0APvF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854F2727FD
	for <linux-nfs@vger.kernel.org>; Thu, 25 Sep 2025 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807863; cv=fail; b=U6xmjjOUVcB4HbLAduRgj3fKCkLOsnqwiyizrLbiYFiCfmzViBQRhpaxcAn42OnbJcO1zN+TSGhnxh6h4GiXOiQ4WRE0XCBkUhWm0TPdROnydNjohpd/i7x5Ut8iBaldJm6h1xpTqQRyvbpW7hUp78nRbIjLgEbBE45nZgUR4Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807863; c=relaxed/simple;
	bh=HeDj5Iol41uI62M/phpLUzWjAQs8E2gr08wk+FjUN9U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tuV7ROHfXGo/qmdqQCICSENftsDH6kCAUfibCuTBxvGAIJIZsBDT8lwu5aEgjofDlUAdzGeHxG1rnlpXz2s23MdpRxeUt3lUHAnlbM4JMmh52ckXGFrOVCo+ji4t+JPB83VXuciCz5TFldmieM8+q9vIy3miSP1tMM64de25xWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LZzdK5Ff; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a/Q0APvF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAtdCt017831;
	Thu, 25 Sep 2025 13:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5AzI2ud6TIbvzXbpgByz5ivvRmab9U8sVOYmOHxNK3s=; b=
	LZzdK5Ffk6t5UVSfHUJJv0JaRYpPvt7Y1BHO1o6aIEDm/xINdJoJCidehOL6JkXS
	gVTShkHPCudUjK3VXJcxi11FNtifpwdT6VIOUd5GYE+c7rmE47UIZYiyTpuP8ZdE
	Drpt247ZesmM+esB4xVcE3z4RQ3PoUKO2E3vayH1H/AaF32yFXKNG26VcO7a2xsk
	bOqy8JwBm9ajlZw42VzVL5EoHAS19CyTyKAhCI+NH3vhsib01Y6moQMFszIuqQVV
	IYyD4T+z/dehIjsbKp/7xULTKXzdIPntrNRgJi8v04E1XZsHevvN1OdqrOUjONp4
	ZHh550/vyBpkFnCLcpa2fw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mada49n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:44:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCbeXF014604;
	Thu, 25 Sep 2025 13:44:04 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a9525pc7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:44:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/fN7kJLg/7fN9ubdow3xn39UoYLkEjdnntzFmZ5P4GmRBqDV5FnV3HS5xfKjFA2p50/Daj9nDl3LBb75+LRUu5L0KuCAKFnVYQQ/fpFkjTtzp3a6LToFsSNhDtjk3Y2mPTpzWkaQMlAABeB541odNIRx9FD26w/4RdVVpx/5oAYrDB4VShdUK5263OETJ1oiHodbl1xR/95jPxpzGqTW9+dz/A4K96SBkWfs6UYHlu/EcuzOElgrb3DMzuYwAU79MNvcMqyhlvbWsuEYWqKwXUNUOsNYANZDHsJZ923N9mslLY5doUFwp504A3xc2q6y8Hn8wxW5AxTbZYMzSOgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AzI2ud6TIbvzXbpgByz5ivvRmab9U8sVOYmOHxNK3s=;
 b=r5DumSpuD1vphOtLOca/yo0fsYmIR1xZ/HdM3vehHmcuMMdWKYEVTMVglwbZ745TPZ3AHy6Cn+JciYZJ3ooaLJBQLOVJFuIKTnmbpBt9CIGsA5NvHvQKloEhJImI23A8MVbpPYOzI0m33BeDPqzOXeWySoA3ktOvjKvdlpLwUYuH6+dh0CcmkjTdc5/pVFAlEvK9Bxjm0QKxUfuwQAWNpxFEIlPr840vWNrnV6p+lHSuJ83+p5wFHFSNITD6uyq5mwD/trlrzOJM7TLgQKHXQfWQL8S8wKclpMZZE64rFGz7NhA4Qjaao/r9t8fygTFqiC56fX1cnWNX1Tm9MqXD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AzI2ud6TIbvzXbpgByz5ivvRmab9U8sVOYmOHxNK3s=;
 b=a/Q0APvFqGEsvlPQxaPZAW2Xq6U4x6PBQ1LdCetpVVqdBaTW3OCdXYJ116hQG99Nv9uSs8FG6yn5UXe0wATtLiWAJZ1gfmq6n5uqYN75yR6qa+oKb1cDolAzlHbwTF1Uaj46hjPCZW5vQGabTKAfwji6OBCOTbDRXtT3FQBqlAo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6649.namprd10.prod.outlook.com (2603:10b6:510:208::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 13:44:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:44:00 +0000
Message-ID: <6669bd1e-ba37-433a-8f8c-5cd9787b846f@oracle.com>
Date: Thu, 25 Sep 2025 09:43:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Move strlen declaration in
 nfsd4_encode_components_esc()
To: Nathan Chancellor <nathan@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org,
        patches@lists.linux.dev, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@oracle.com>
References: <20250925-nfsd-fix-trace-printk-strlen-error-v1-1-1360530e4c6b@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250925-nfsd-fix-trace-printk-strlen-error-v1-1-1360530e4c6b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d27743-6775-4a34-58bc-08ddfc399508
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZlRjNElubnZFWlBDckhNZ3pOVWdtc2xOa0o4YkNFcjNxbjZRU09qd2lKSERO?=
 =?utf-8?B?cThCeXBMOC8xSERFV21LWnI4T0U0SjRITks3TE9qZThFSjJaclF6Mk1PdU8y?=
 =?utf-8?B?TlB2RTduai93ZkM5V2ZqaVdXWVY3cXNHVUtKSWV0VjNyYkZvVXR2QVNFOUVr?=
 =?utf-8?B?Z2xXN0JPYlU0ZWNEQVpUdEZhQmxMdnFjUWRkbXZyOXFTVGpaNWxaWjRzTENr?=
 =?utf-8?B?dzUyMDVEVGdFUEJxbjIyYTdpQTJGZStZUWdMYm5RSmpDOXdKYzRLZDgvQnl6?=
 =?utf-8?B?c3YrZ01zWXFZODVSZUNtQWkwclVOK2sxTjV0MjdFeDFHVy9qdEV0c0FVZyto?=
 =?utf-8?B?M2NmQWdZRHljK0Jod2N0bXNJNk1MNDg3SHVyOXdHclR6d2N2QUJKYW1xQ1hU?=
 =?utf-8?B?cERsMGVIbGxMemRFQmw2b3NQbDVjRDhhS08zTWJxTGFNSTFQQy9lZjlOUHU5?=
 =?utf-8?B?OFY4ZVpJYlZkcjhMOXRrcDhPcWdGREREMGdqRWxxaGt1MEYwK0dSaHJRWmVU?=
 =?utf-8?B?NkNYR3cyQnFRRVBzOHBRQ3N1VTNTTTlNQS9DUFlRUmFsbzU4ZWw4Z2RneG5v?=
 =?utf-8?B?bkdpeWhtZUs5Y3JTL3RwN29KVUFXYUVEQUZzVnJiWkFjc01mcGxsU1oxRFVs?=
 =?utf-8?B?QlgwWDJOVGFnN2FZZWJqWEJnUmdoZmFzbm9HNU9aN29OTkM5UnpzQ1JLdEcx?=
 =?utf-8?B?N2RQMldoUFd3UlMra0VzRDNuWTlLcjEzdTRtWFNoZ0dUNzlNUEdBa3NoYTIz?=
 =?utf-8?B?WkJacWpib0RvNllid3RJbjR0ZTJCK0lMdU9Xd3NHSURLM3RLL1FLVjJJL1N0?=
 =?utf-8?B?MCtJUTVhdDUyRzMyOHV5YVBIM1ZZeXRBOEhzV1VxOXROVVVqR0RYQUlNTzlm?=
 =?utf-8?B?QzNDY0ZmUld5TVc2K1JmV0xQNFJuS25wR25vaGdVanhaTHFMdVMzdkFJZWVr?=
 =?utf-8?B?dDBvcDRCNHZnNVR3NmJLN094bHkvRk12ejBkTXU5UEFsUUNoQVlUbUVjSnov?=
 =?utf-8?B?a2xMVXpxeFJ0V3k4Sk42ZncwMiszWm92bVRyOWczaEdyZGxoUkQ4OE5zNUdu?=
 =?utf-8?B?eHhkMTlTbEhzREw4aXFnM2lDVG5Ldm43R1V1YVdrbGhwVEF2SzNUcE9uSWNh?=
 =?utf-8?B?ajRwc09jbVEybWVoWVNrdlphS2k4cVdCeUVGblNkcDh4cVNnMDVyc1BlZE1C?=
 =?utf-8?B?OGtNTWN0dVR4RkxvYXdtYUp6K1Jxb2lIcTdYb0xSclZvY0dFNXRYZStWMmRP?=
 =?utf-8?B?Tlg2MXpRNlhISlI3a3UxNlhxM0hVQ2pkUGdYRFFiQlhxdzJuQlF5SGcrV2Jn?=
 =?utf-8?B?cHVHdDNhT2dnT2hHY0c0VzBETWRyMW1pNWF5c3dJS2x6MWk2NTVyazZ6WEVG?=
 =?utf-8?B?MnV4YUZuQUxHVVVKSTZ0LzhpZlo5MG5CMHR0bFN0RlNYSldBRHVycEdBV2l5?=
 =?utf-8?B?cXpZV3Z5L3lBY2xDLzZqU04zbFV6UTdScjAwd0xrdGl6UTlaVDZwZXhrL3pQ?=
 =?utf-8?B?VTg2WUlSOUxydHZZWXNNa091Um83TDJOV0F5eWkrcklMSksrVG83Uk54blVH?=
 =?utf-8?B?Q0dMaHQzNnpCcTBiU2pYK0NpVk5xMndrdmNReVJwdHR2UXdQYlN6bUQ5QnZT?=
 =?utf-8?B?eVFZQ2RQLy90dkRUZmlaQ3N1L2JTS1ZlY3g2T2RRTGhpQ01say9lMmc1cXhv?=
 =?utf-8?B?ZUNMdHZENjBJNk5tdE9TOHRaNFAwWGprMTc5VlE1S2VFK1JPUCtLY1hvMXFu?=
 =?utf-8?B?NCtJMXFPRVkzOWRMclNKZUpIeGg0YTAvY0wrcGovWXdLb1lBMksrWGZyZkFo?=
 =?utf-8?B?OENzOHFObk1mdTUvc05DMUF2MWdqY0d0Y2p1eFo5ZE1za2k5aXI2TnVqTW8r?=
 =?utf-8?B?dmxYQVU4VTBOZVR3UTQ1YmFwbE9vdE5waXJXY21sY1RuS3ZuaVViMy9wS1lC?=
 =?utf-8?Q?9sK/nS85ius=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MXRFUC9mK2xOckh0NkJTZmhRS0lTMjZQZjgrRWkrNEZ1cFFxZG1MQ1lTckZL?=
 =?utf-8?B?bjFMdGlhbXdGTFF2QTNjb2dWd2ZzcUZRMjV4cmx3Z2pzSnlrSHl2THdIcHRl?=
 =?utf-8?B?RXdEZG5vS2dtdUcxeTVmQWVrOWo4MWhvZXgrNmQrUU5DMW40QlQ5dEU2Y3ZN?=
 =?utf-8?B?ZW1NdUhLTS9zUEc3d2NzSUwyQjQrTE15Y2dCRE4xcWFHTVVGTzJ2U3VHZ0dy?=
 =?utf-8?B?VEJaZkZVWjZwMTIwZ01nc2h3YXkrRnFyV0RzdkJ1ZkhHUzJpOUVGZUlJekor?=
 =?utf-8?B?a1NnZnN1L251aE02ZlpJWjcwTWk2NnJkL0VXOXllZ1JLbTlWYWd4c09aNDJx?=
 =?utf-8?B?REo1d1lEQlBuQ1lXbGE3MGRCcURoS0J5VnFKNnh2VVdwbjRvNHVlQ0VXd0hp?=
 =?utf-8?B?N1p6QU95S1UwUVp5ZFJtQlhsWHp0Z2l3b21CRHF0MmZlQmhIN1NyQ2x2anVy?=
 =?utf-8?B?UmRzbjdFY2dvUlBzUElWTTM4dWtWTms4eHNmL3BSSTZ0Ukl1bFI0L0NOOExN?=
 =?utf-8?B?dnhkNHdlTFpYeVcrTWlhRzc2VlNGTElicSszQTc3d2IrK3habVpWWVI0QUpZ?=
 =?utf-8?B?aDFjci9LaXhLUlB3VUhJN1krazZlb0JyR045eEtCdkYwbFVSTnNxZ2tmSnNn?=
 =?utf-8?B?Z0hiMWtzcHN0REZxeHM0cmUyaHhBNWU2dGd6cGlGNDRrYXRTdjFjR0p4aDR2?=
 =?utf-8?B?NHVld1AvSnVwMzBwZy9CejJhS0NOWk9MNi9Kc2o4eHZDSy82ZGRocWVUSUpP?=
 =?utf-8?B?UUc4cHlQQWRCSm1nK1lOMmQ4a3F4ZjFTeTdxWFJ2YUI5Y2RLRnNyWkloaW1y?=
 =?utf-8?B?MGNSdGp5UEtWS0k4OHVlT1NUVmtxMEtxU2VxMU5xRXN6Y1dvei84a0pQN1dP?=
 =?utf-8?B?NGlEb2U3WS9VSXVnTVJtM1RtdmdmcDUyMXBMZVdBZXZ2cDBIeUVPWWRvYWdH?=
 =?utf-8?B?ZDFmQVZRNUhFS2dhU1I1NjRhajY5Rk9kVktTRGNOKzZtN0JYemFkeHNSR0Ri?=
 =?utf-8?B?dUhmaHRxWDdaNUh6NVAwb1NoU3NjckNLalo5OWxEcmsvajZtbi9TbHpUZjZ1?=
 =?utf-8?B?U0tBQ01hVVkyVmYwbHhOM2RCS2tubHhqTHJzTXc4MWlOMGxSdFk5b1dya1Ry?=
 =?utf-8?B?bU43VE5wSlpqOFFXRmU1dnRGbEdjbDcySDFVOGh6ZC9iWWVQWG1iSEYxY2xu?=
 =?utf-8?B?MWUzYWFSOWdJS2FMeTFqY0xpK2RHSjdVMUcrVnVVZzFkWDd5bGV6MWxDaWRV?=
 =?utf-8?B?Wmo3OGw5dkwwQkg0STlLdnJLM2FEYTlLNWdmM0xjZUd3aHZGTFlhU2RRejF4?=
 =?utf-8?B?ZlBUUHIreUJ1Nzh1ZS9UTEhMR2c3M3gxaTY0Z2FWTG9JeHJqWnVzZ2JIM1hD?=
 =?utf-8?B?RWNZdkR5ZTU3RTJKQ2xJWW9vWWFNd1VySUtCN1Y4am1xWlczVVR1YkI3aUJ6?=
 =?utf-8?B?a2xuczZURVFNaHV4S3JjSFM0SEl5VCszNkcyMjNmL1UzeUV3RWVsUm1LaHR2?=
 =?utf-8?B?T0hsNHliU0Fzc2hZOEJjSHNwbFV5Z2lTdmtwUi9HaVptazhpVGZiM2QrdjhL?=
 =?utf-8?B?Ni9HWkorQldWaWswRlRXMVhtUXI5aElveWdmaXgrWTNMU3NXWU1tcVdRdWJX?=
 =?utf-8?B?RXdiTGE5ZXRNLy9zdGtWMGdyYjZLWnZtNmowczZDbUhFWjJxc1NYZERISnpi?=
 =?utf-8?B?aWtJblNGa3RYa1VRSERNVGJlbjJZUi9wTGxHVmp4czlsd0FUTHNTQVR2b1M4?=
 =?utf-8?B?dmdVQWJmSTJOZ3lueGZlR0ZlbzJjK2w4Uy94MDg1emRZM3hZUHJqZk1jZXhB?=
 =?utf-8?B?Y2ZKM2ZHOUxNQ1BZZHYxYjR2Ukk5NG0rRnYzeEI1dnJyRlZtZkl1ZTNqK05l?=
 =?utf-8?B?bDR5YnJQUjQ0di9TYmpsRnNJNkQ0MmhSWFg4OTdsbHhhMHoveWt3Q3VMc3oy?=
 =?utf-8?B?eVl5cnI2d0RaUVhpUU9aRXcrMEFzVGxWN2JhSEd4Y2N0QU40cUxUelBiRDhi?=
 =?utf-8?B?WDFtVE9XSElIQXJwdVBnMlFpaVNjdnl6cUt1ZWlqREM5ODhNYkdHT1JXdHhS?=
 =?utf-8?B?cDhCL2Q5ek16a3FkVXVhSktVUzI2NVRzRWV4Y0FxWGhwS2VXWDd3Ri9TbmdR?=
 =?utf-8?Q?odc1mR01ln3A2IESJZmjOcQEV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y3OiTEhN7zuZkvw68n8yxFSunhoeXcmlr3xWBBRRnYP8vccSZITpXZzpfpL/atRFLJQuioIjdlW06eo61RL/8zBB+j28ZWsGrjD2pmRFgt1s5BzXaY8hLGa18Zq9mGUzT530+cASAbP/eP3Hb/fk289+XmPP4cfX3F2JSWcjXJKH/7pgZEZ1hrG7PKxQs8auTG817zGYJAOFBKAQ9cRKiHDsjJyiDp+nap+QepFTphgLk/IUOa4m/pw7R2ha8mwiswBB8O3qH6WeXJurERgTCqL40y/pd/osJazxvQyJU8p8xwWO1epRsPBC3IV3q2XejbFoZDULu0JJAsr1jkvfwddHq5JpgQm1rkOsMsdXQddHaWNVN1Wc7qByOlTw1TKK4XtfbkT7PmlEChuGIPafZUZXeKxIPPtW6urif7/BZT3HLonj5SKVI5I/CizB6mWwt1qJjc2RqZpw7pjul0QJZNnQhdth7FJOPyxWR0VNYA6vrfvjqOvvoUL2sVi866E1WP6R7C/zxIte7kXREosmrGdVljhqexj7prekR6LSi7tpuXv0CgN/7mHoMEP1Wb+2abwwJPBEL/pOiCGwC1YNJRZ2F7c+bGEL54sH2i/K1eY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d27743-6775-4a34-58bc-08ddfc399508
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:44:00.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErcnASL6WKPRMNQU1DgNVdP30Bm+MB/HTMg6EViv1uSlNQP3Gi4l/7X05eS1bJbiFiTLBgv0OLgF0rd9zPwnkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509250128
X-Proofpoint-ORIG-GUID: AmfL35PLxGco_8WrFsD_MlSvV9TemX-e
X-Proofpoint-GUID: AmfL35PLxGco_8WrFsD_MlSvV9TemX-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOSBTYWx0ZWRfX9PJWjMYv7wSu
 W6WHpF185BCJjkMWso7tqemjAr8N4mATrnU6n7rjCYhBD71MdLc6bicnX3Y+B2Ir0IidGJqw7y6
 66X5cdO8Y6eiPQ1Wy+ZZsq+UtDfSzMGmm+7pHQbK1DY5+JQX68lq6YHqmAQwVVCDr76OdTefMpD
 POWIqjd4KDCXx58RPPS3neyOASPAjAs2dlUa0fo4GjLaViCr8+9drtqzCfnjTb/NjwyHzHxC+Zu
 SKzJdiVvI9MD1LEV0jZASsN0dWvXCH3eIE6qtaAMG7wZQRkj5XUBfgnIYToLraZ0wrKej9/zgmT
 /ACQBs1oCAv9LITgi3bIFZoXBuaSNhOSPQtB4ltd3bOW0EQBPtwxXxEO+TcFOYWzjvgb3aqcb75
 2o7ujFrTE+BlaZBUXeJnILgb8tve2Q==
X-Authority-Analysis: v=2.4 cv=Vfv3PEp9 c=1 sm=1 tr=0 ts=68d54725 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JE85pbngJOHBN0uRewkA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12090

On 9/25/25 5:14 AM, Nathan Chancellor wrote:
> There is an error building nfs4xdr.c with CONFIG_SUNRPC_DEBUG_TRACE=y
> and CONFIG_FORTIFY_SOURCE=n due to the local variable strlen conflicting
> with the function strlen():
> 
>   In file included from include/linux/cpumask.h:11,
>                    from arch/x86/include/asm/paravirt.h:21,
>                    from arch/x86/include/asm/irqflags.h:102,
>                    from include/linux/irqflags.h:18,
>                    from include/linux/spinlock.h:59,
>                    from include/linux/mmzone.h:8,
>                    from include/linux/gfp.h:7,
>                    from include/linux/slab.h:16,
>                    from fs/nfsd/nfs4xdr.c:37:
>   fs/nfsd/nfs4xdr.c: In function 'nfsd4_encode_components_esc':
>   include/linux/kernel.h:321:46: error: called object 'strlen' is not a function or function pointer
>     321 |                 __trace_puts(_THIS_IP_, str, strlen(str));              \
>         |                                              ^~~~~~
>   include/linux/kernel.h:265:17: note: in expansion of macro 'trace_puts'
>     265 |                 trace_puts(fmt);                        \
>         |                 ^~~~~~~~~~
>   include/linux/sunrpc/debug.h:34:41: note: in expansion of macro 'trace_printk'
>      34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_ARGS__)
>         |                                         ^~~~~~~~~~~~
>   include/linux/sunrpc/debug.h:42:17: note: in expansion of macro '__sunrpc_printk'
>      42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
>         |                 ^~~~~~~~~~~~~~~
>   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
>      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>         |         ^~~~~~~~
>   fs/nfsd/nfs4xdr.c:2646:9: note: in expansion of macro 'dprintk'
>    2646 |         dprintk("nfsd4_encode_components(%s)\n", components);
>         |         ^~~~~~~
>   fs/nfsd/nfs4xdr.c:2643:13: note: declared here
>    2643 |         int strlen, count=0;
>         |             ^~~~~~
> 
> Move the declaration of strlen into the while loop (as that is the only
> place where it is used), which is after the call to dprintk, to clear up
> the error.
> 
> Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> This solution may be too subtle but given that dprintk() seems to be on
> its way out, maybe it is fine. An alternative would be a rename such as
> str_len but there is some symmetry with pathlen so I opted for this one
> up front.
> ---
>  fs/nfsd/nfs4xdr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index ea91bad4eee2..580bfa8011c7 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2640,7 +2640,7 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
>  	__be32 *p;
>  	__be32 pathlen;
>  	int pathlen_offset;
> -	int strlen, count=0;
> +	int count=0;
>  	char *str, *end, *next;
>  
>  	dprintk("nfsd4_encode_components(%s)\n", components);
> @@ -2654,6 +2654,7 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
>  	end = str = components;
>  	while (*end) {
>  		bool found_esc = false;
> +		int strlen;
>  
>  		/* try to parse as esc_start, ..., esc_end, sep */
>  		if (*str == esc_enter) {
> 
> ---
> base-commit: 3fadfaec904dffab02ebf63dd9c2ae8fa15c6d32
> change-id: 20250925-nfsd-fix-trace-printk-strlen-error-2a24413eb186
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 

Would anyone be heartbroken if this patch removed the dprintk call site?

I think renaming the strlen variable to a name with a lower collision
risk would be sensible as well.


-- 
Chuck Lever

