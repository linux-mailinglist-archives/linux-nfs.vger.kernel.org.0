Return-Path: <linux-nfs+bounces-9227-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA12A126D1
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 16:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374A53A1272
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C570816;
	Wed, 15 Jan 2025 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DVjkvXRg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x+ypcTyQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D21547C5;
	Wed, 15 Jan 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953477; cv=fail; b=QHWr3+OI+kPIMfuzs4rli+iWg3EuBm484wZUppxbsVgZxQIEUrEqM8I5BK5Ynr0SLhDwT2CaYwzaLtua2Rgv0R5OqvVWSfx5ebJDt0EaPMyNcl9OIHoqgJFRhulz0hEC+H5JuSZEPJuQkH8hwNwZSPTZ3JCPyjavNjyhwJ3y1Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953477; c=relaxed/simple;
	bh=FaiuJeonMONVeZy4UYHlrS4Qgt1U3DmdxbV22E6P3Go=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hkm30XG6XCNgCKF42BGVerSZ8IiHe1DsscVgKq9vDpqxr3JHmpaD+jx53CnaMm5btSmyjKxGTf/2nWCbyWjMuzZ+zc6d3dZSzF23TDdvLuJlKO9spuCcJPPbaq04IVwmKRtUWnjIOQMuFtZKVvQoj9kiZiBw2QsUZgduwiX4Vyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DVjkvXRg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x+ypcTyQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FCijFt001279;
	Wed, 15 Jan 2025 15:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xnLAvc77Od65PXuD6dkC9bl48HMwo5xy/8LSPuTUKU4=; b=
	DVjkvXRghsFhIWA0LqfeAc2pGkPnryjMfcDUDz1hopb5sIdMc4TGpwr6Yz6H+szF
	3RJfjqutXeT+iRzwpXCDGYBkgKcW7WwwrzNZc3NR1A7radvfWSZfpo0owf5ETwI9
	ktULqyZAKTs5zqFM9Ro0ib8SSfuns/R0sm+OnMQioYltpTCSmRWgTGNBIjF7E389
	tBw1pBVf2mB/fmaTMx8UpFlmS551IilDKRGMGV+eoBmO31A7BC/gvMeonw85XDdp
	tDCdqPDC8B+/P3ZPAkC4/1BKAc358FGd4kLID4tSSaIHsNvtIPyKN1G/Lil/8Jzu
	JXUk25aE9lpYmR6ml3s+8w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fjar6j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 15:03:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50FDHvWc036479;
	Wed, 15 Jan 2025 15:03:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3a3wjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 15:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOigqrXX1f1wXofPisSnH4ZKwuKJ5RDJCuFxYnb5J0iynA1Mv630qycew75Ij0TDz1HWoJobQ6V5jQEOIb9PmZUhReMAqegx0kt6sBMF9dURup9J0s9kuBTvO3kZ5S+G+HQwcadYodkTYnyXccIrz/2zIBwRMrF4SSep5AXKryXrHnvl2DjzjYu+b2blbmMy+Q3jwLu6BN/tgfS8x9/xwnrR4TUofYZsEiRsnl36B60InWyhwu35jAipKXdXUTEH9zCpw3c+cP5Rx15o5Ibc6UrwD6KMyoA++WpSqZ+HKV0bzfrEgT7UXz4NeAbchW4lQhyGBlnTMJGaAcH9IWbcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnLAvc77Od65PXuD6dkC9bl48HMwo5xy/8LSPuTUKU4=;
 b=W74iqGVkTJ9ymv2G83RyhHQvJuOKDBWSyc41Au+s49Hxv/ltWPkF0NDglnm9NjhmwRy1WMgN6x9PCBtU/2bA8mrkzJ8brO8E1x1YyZSqmOkpia279i+gM8qyDEQEd+EFPogR5DDmZdaqy5UcLtuAlJOGEvt97fp2HRy82Krbyg0tkHNXYCEKIVOIpN32Fg1d1HH+gdsD+b0M9bV2o9eWdsI5R/MayfDDhO6IoTIei/K916W+Tv1S4PZWgCI0DcnHDT+R24GqHYakYn4QicXN5pPUPZCKa/Ic/4niI6G3jF2YhWEnqRYCyoWlNF1VD4bVi6/Acn5ssr9jHtH9oYjO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnLAvc77Od65PXuD6dkC9bl48HMwo5xy/8LSPuTUKU4=;
 b=x+ypcTyQ0cNM9ERqvH1zl8qsQFMLSOUNXTEX4oZGh8hXLlzdmhK545qAUUMdB6eTXBx6n0Uzm3qDhDiQwSzD/x3oqD817F/E119xjFvpb2lX5EPUEYZoSgQeedCDfjieubLi2cVxLN2bQhuiQBTnKgYgPIka5OyEi3Pj1r6HqOY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 15:03:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 15:03:53 +0000
Message-ID: <a453c201-7dd4-49e7-a90a-5dc4c9359f2b@oracle.com>
Date: Wed, 15 Jan 2025 10:03:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: free nfsd_file by gc after adding it to lru list
To: Jeff Layton <jlayton@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>,
        neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com
References: <20250113025957.1253214-1-lilingfeng3@huawei.com>
 <8864761c99553a7f18adc13e98b4ef6255da1d9e.camel@kernel.org>
 <a32d4eefe27757de6ad8761e8de740e8d0968561.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <a32d4eefe27757de6ad8761e8de740e8d0968561.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:610:4d::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 292a7e63-0236-48af-ba37-08dd3575d39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFhqNVpJZURUWVd6Vi93YnlUOEdXWlV3Z3V1d1d5bTJsSkRNRjZTUzdTUlhj?=
 =?utf-8?B?ODUvTTVkaUpKK0pSeGlBNmluNjlVOVplaFJxSWRWK2xWMG9TN0RvYlhoWXZN?=
 =?utf-8?B?eG1nbUt4b1JOOTJTdkZoQjdHb1pyTEFGaXZ5NEUrRjZUblQxZHhxWHJkbjcz?=
 =?utf-8?B?OXdESnVKM3lzTnRuTG05SXI1a1Q3RjNkT3RLTDlObDBrU2F5VmhQc3hyM2hr?=
 =?utf-8?B?eW9qdHVzRTNDTkJZUzRzdHVLek1WWUFFU29DNHVzbVZsdE9CQXNWaHUvVE1n?=
 =?utf-8?B?RGJUb0NvY2tmYzIxc2h3My9kclp3UDlKalpmaE5aK3JIQ1Nqd1VOcEl3cTNV?=
 =?utf-8?B?NzlZVHdsQVhndkVzbGVOTy9hZTNSaE5NdzEyMlBrRWpFRHhzQ2hDQ3VBYXo5?=
 =?utf-8?B?V2YreUhrdE5yUWM5MUdWVkhsVEM5Y0J3b1VYSisvRWdPRkhPd2ZvSHAyZy9q?=
 =?utf-8?B?VENLMmVSTXpWOWFuUlBQaGcybzFHWVVleHNJZEtvYmNEVmxkaDFkNWY5TXg5?=
 =?utf-8?B?Tldla3RKU1JRUWRiazJPSmZ4b2J3bjEyaWs1ZjlaVUZDMDgxamMzRXI5SkFv?=
 =?utf-8?B?cDFBWHJ6ZmFzYXFHM3dvYUl0cUx1VjhjQnZNWnZTS2h1TDRRTHNDQ3UreWZu?=
 =?utf-8?B?MUZZaXlCTW5zZ1JFMURyaStlamxSNFhlOW5ibkQ3cmJoZUk5Ulp4bG5HaFR1?=
 =?utf-8?B?OW5oSThuTy9PUFNyVTBDTVRRdDVFRXpNNzZ5a3JIVlJWSTBKd1RDLzJSSG9w?=
 =?utf-8?B?dkp6T1pwT2FabkdYanRsTStoR3FqbS9OUHpIdy9aZEdmbVh2RHlZNnI1QVdw?=
 =?utf-8?B?QzZ1czNwVkRuaU96MDk4OWZxV1lpNjRmbEhUL3MyOHZ3NHA4VFJETXc4SUtj?=
 =?utf-8?B?WDhVcjBiZFo3N1Eyemp6bUdZUHN5cjdwdEpiWjlyZVhUT1lVbFUxenpPMmkw?=
 =?utf-8?B?andCcDI5VU1GNXQ3YXBYYVM0QzJoSVdiYVg0QXhlaHpHMmxtVHllTXlrMFp0?=
 =?utf-8?B?SGRJZ0tKeHZSbnppQ0gzQ1NZNWpTWTBTQWhJdDVFejdOY0VDOXpVTDgwM1ZE?=
 =?utf-8?B?VmlyZW1zZWQ5WXRiTUlhMkpNa24yYXJjL2FzQkZuSEo5cXlISkxIUVZCdFAw?=
 =?utf-8?B?aGZuMWpLRnE5cE5WVUZLZTZ3L3NhQkFlVjVIVTFZSnpwV0l4V2xnU1JoOWE4?=
 =?utf-8?B?Uk9VaVRCTU9xRVd1MG5nVEtXYjBoNmpOaUJTSDlrYjhtNk8wa3RLbldVMFZx?=
 =?utf-8?B?cEJwWTYyeEM0VlNLMmptVndjdXkwQjlWczdKVzA4ZHg4VzVVK3RjNUFvZHdV?=
 =?utf-8?B?VWxnV0JPR2k1THRZSExjTFBzNmxXbkhWcWtiMDBaNmVIbXdDMWpRNHR3bXJh?=
 =?utf-8?B?Y200SFc3bzJhZWpKeGxtWmxrbmpkMU1Mb2VGTHpJeG9BbVlRKzk2RHNRMEVw?=
 =?utf-8?B?dE5xWVZCaExvcjYwb1FOVEZtWUlibHQ2VURvcGdyQjVmeWJiamR1dkV6eitT?=
 =?utf-8?B?YWozWEdKWnh2KzJUTDU5Y1hRVEdFdkhCa3NWYVlFMWFQWXRPYlNDbS9tSG1M?=
 =?utf-8?B?YS9OTS9sZURjMUFrVjgyWHhBU3RDR3ZldFlEZk1kd0YrR2MxVGlEdnNpZExF?=
 =?utf-8?B?a2Y4ZXBFK3JOam5GaURBSi94NGdTTUdjSjFDcW5UZWJ6b0dmY2Rmd2lPVERO?=
 =?utf-8?B?SkwyTGJsVkNwc0pjRmR2alF0ZlR2QWpzemlaRUdLZjRWSUlhL3dWSnpsV0cv?=
 =?utf-8?B?aUppcElJRmdjeHJhOFRsYjVCYld3MlFUOFd5TmdQNTNGcC9vVDVQaFZVM3NU?=
 =?utf-8?B?OFpCNWdsQTVxYTJhZzArZ0krZUFaWllVZ1VCbkMwL1R1QXJtTlMvaWNLQmhz?=
 =?utf-8?Q?fWVBZBab4wgAZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1Nac1pFQ1BIZzlVWEJBMWRVdlRTS1MzNTgyVURUeW9TTit5ejYwY281Qm8y?=
 =?utf-8?B?aXBxUFMvWFp3Qkp4NW9ZREVpVUJ5Zzh6QXlTcVVOenh3TytmdkcySG1Hc2dw?=
 =?utf-8?B?R1RvekpTb3o0ZjM2Z1haY1NEMXh6cmhqWFRyZDFNZEpSUFFSSnBmL2VFWGVt?=
 =?utf-8?B?NjBSNVJjc0FuKytPa0JTN1poajVQc3gwOElDY2tTSUlISitoLzRyNkorRzho?=
 =?utf-8?B?VG9qSXhCWHFCWEtDeDdLaVBSaHdoTnNnUlVhbndSZGdVNXMrTWwyRFc4T0c2?=
 =?utf-8?B?bEJMN2c0YU1EY1UzNG5MSll6bDEzclBJVEkwbFU0VHNNZ1E3b2RIS1JNV2Rq?=
 =?utf-8?B?WVVma2RvZFphaGw5OWtFRTlhZUVvN0xHaldHb3R2TGlXZFBwWk1kbHZvcDl0?=
 =?utf-8?B?UVBjVTQwZ0JUaXNIUXpqQUVSSzk3bFpGZjlCZ292NEZETTJPb1d6ME05eDVH?=
 =?utf-8?B?K3R2Ym94dmJ3Z2x2QzVDcTd1eFJXTkpHZFRuZjJzdmRSTStlTHVXZVVIL2dQ?=
 =?utf-8?B?UUdibWpiTjFZQjdTVDFyaU9GQmgrbmlJNHp0aXlVNE9WZWxjQUNXZ0FCUm5s?=
 =?utf-8?B?czlPalJOVTZSOS9YRCtmcXdWZDhCZG5IbFZSR2crZTRlcHhkVkUrR0RCbTZo?=
 =?utf-8?B?blFrcTJ2TXNPektCNDdLRUJWK3gyOTc4Vi9nRnhZSTNEQ3ZyaG9EU0FBMTJN?=
 =?utf-8?B?eEl2WDNhUFFsbVRVTkR3a0pMbEJKd0xTWEFHTVN4VHRtOXBMWHJGMVUzVjRO?=
 =?utf-8?B?clloRjB0M2hQNTRUQ2VhTTUvVWlMTGxqQjRZc2xQRHBuc2l3dXovR1ZrMDZI?=
 =?utf-8?B?cVQxSUx5Z1lpRkxRQlV6SUxlOVRYc0pWS2QzSmdTY1Y3NnNHWXJhKzFHOHZV?=
 =?utf-8?B?S2g2MU03RTlRbVExL051SUo3b29QYThzOFBsNUpSTWlUNlBCSkJpaTRsbUZ1?=
 =?utf-8?B?NmhFV3llTVRiTHhUZkF6K1lwaGR5a0U2L2hVMXRxWkRnc25BTHRwNlZOS2pJ?=
 =?utf-8?B?YlJRUHJ0dm5ET1BOSW9JdHB3dG5GRHlaQUU1cmFOaXRtMkNwSHVkbkJuWnFw?=
 =?utf-8?B?aVdjajhDM1E0cHI1WVVLbnpISlZ4ZTZQYUd2RUNUMzZGMjBtbm9mbmt4ZDNk?=
 =?utf-8?B?cHpTY3lxcEVlYkhhSG5NREIrRCt3aFgvSTcyYjJpblN1dFVkNzQ4YzlKTnpm?=
 =?utf-8?B?ZHJSWHdNYVZoK2Z1Z1pRd3dJRVZ0eTVMNDhEUjBUTnZsQVRBRHdCa2M2OGRW?=
 =?utf-8?B?UVpGRExJMjBmU2tKOFpGUEhPYTUyRnNqTFB4MWM4UFZGenhMT2V4M2pYR3o2?=
 =?utf-8?B?Njc1MnJxVVVWTXVRYVpCWlFjbml2WEhjTHpsRkZFS25YZGZjT0M3UTRObnIx?=
 =?utf-8?B?KzZwd2plSXNpaHViVlRkOHphSnUxNWRoNWg2R0ZXV284VHFNNnhkMitwN2hn?=
 =?utf-8?B?OUZkM2RjTWtObDd6UHlVUUhNRFZYVEVDYWVSc08ycmpIWXNHd0dJQlJKcU9K?=
 =?utf-8?B?NkYvanRsZEhpNjk2S0tZcFJTa1ljVUFUTmZmbGl3aUp1Y1licnNtSFVySFFU?=
 =?utf-8?B?OHVyZmI4aVd1b3h3ejV4OVRJKzArbHBuZ0xHN3loaDJ2dzZ2YlFkRmF0dnlW?=
 =?utf-8?B?dFE4TE5YY1laY29la0pkYUQvUmtXMDNYY3ZhbmxqY1k2MFNmTHRTcmdMaU90?=
 =?utf-8?B?cWowV2U3WkJheDQ0NExLMXFLWW1tY1JzVFNOMzQvaTU4QTlPcEpiV0VSL2RK?=
 =?utf-8?B?c0R5dkI4RFRHaVZWVnRPaVNTVG8yT2lOcWZybGtGaTJDVjNoRURlTmdhVkJG?=
 =?utf-8?B?R3VLcE9EOU5zY0xZTkQreWRFUHkwYkpMRXJLM1BrV2x1dzNTVC9kRWRNZXBU?=
 =?utf-8?B?cWRnOHZaZ0U5OTFzN21MeEFNQ284UkNYZGJSamdLTjQ0ckkrYVg2WmxGNXQw?=
 =?utf-8?B?ckhub3B6ekkyRGEzNnNVbkNzTFVPVTVxR1FKd2U5V2pFcnY0VmdtMDJxNFhi?=
 =?utf-8?B?NVNHYUN5WHA4amtKOGllaEMrNTJ5L0NLTlBSeG9hNm5OYjVTelBTcDNXREVi?=
 =?utf-8?B?RTlCcGJrT1I4M1FVNnVacWdNQWtKNHpUaVV5SXptci9vTlhxVFd2NnVsaXB5?=
 =?utf-8?B?VUc4UDFLVVpBUG5ScW5XUHMwdmpHR0cxSWt1OGtwdG8vRFBaakd0aTZYSEl2?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qhnDobOEY9EJEo0DH655UtDoExCjesymHq4ayij1ksHvVogOf+MQ+M2V+2TNEOcYNhFdQgUqTR1dDnopGqLHLKilkfTQhnGRVzW1CEwZ2IZ1cv7DKebydGcn6aCQRTAppp8zwL+QA6wLwK4XQm5ZnRadkhltjH6pJ9sb6YFend5mi1UpvD9SuhWiW1vTcveIqk1VvbhmOTgoudy7biL5PvkMjoHhI9qEMDV+mMxc7/eZKbGN51VzZ9LUih31NkYWPzBOHWASGlevlQ+gz0avN4wLtKiJyPzZixxeQe3BqGh0jj05vmwha4tMwN7NpiganosZCsXYsAIePzonvrN4jj5MH3PKSZBKUO96ldyoMlT/Kl77KMJ9LaPHiAzg03k86KCiBWJ0kVdUdkVPbVp5tY8f3w/jv7JIP2AGco2yvB78jIusTgAettNSqsDc2ZGj4t4S1eoXaQbsccRG+wBHaQesMGHKqolnsFWmZYEsGnuz7wrLvqvzwVdtZi2fAxQdfc91WCxsslcwsPfADaGGIzBTphjcWnuXleI6dU7pKScrXzuF7dBwoMWfyCuGWMJBVItKnCi1opaE67eem0uw/bAKPrf1fwlwGz6ACiuSwzc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292a7e63-0236-48af-ba37-08dd3575d39b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 15:03:53.5907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5jVk5Rj0KP3pFerilGGs326Jj1HUaa76GCC2UMjxYh11fB5Re+xdCfgmYFp6UZHUe/n7qgSBkgosxFH7vA4Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_06,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150114
X-Proofpoint-GUID: dm-_qGrM-SdJJAUVtFZRv-0tF7Bq0Aha
X-Proofpoint-ORIG-GUID: dm-_qGrM-SdJJAUVtFZRv-0tF7Bq0Aha

On 1/14/25 2:39 PM, Jeff Layton wrote:
> On Tue, 2025-01-14 at 14:27 -0500, Jeff Layton wrote:
>> On Mon, 2025-01-13 at 10:59 +0800, Li Lingfeng wrote:
>>> In nfsd_file_put, after inserting the nfsd_file into the nfsd_file_lru
>>> list, gc may be triggered in another thread and immediately release this
>>> nfsd_file, which will lead to a UAF when accessing this nfsd_file again.
>>>
>>> All the places where unhash is done will also perform lru_remove, so there
>>> is no need to do lru_remove separately here. After inserting the nfsd_file
>>> into the nfsd_file_lru list, it can be released by relying on gc.
>>>
>>> Fixes: 4a0e73e635e3 ("NFSD: Leave open files out of the filecache LRU")
>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>> ---
>>>   fs/nfsd/filecache.c | 12 ++----------
>>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index a1cdba42c4fa..37b65cb1579a 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -372,18 +372,10 @@ nfsd_file_put(struct nfsd_file *nf)
>>>   		/* Try to add it to the LRU.  If that fails, decrement. */
>>>   		if (nfsd_file_lru_add(nf)) {
>>>   			/* If it's still hashed, we're done */
>>> -			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>> +			if (list_lru_count(&nfsd_file_lru))
>>>   				nfsd_file_schedule_laundrette();
>>> -				return;
>>> -			}
>>>   
>>> -			/*
>>> -			 * We're racing with unhashing, so try to remove it from
>>> -			 * the LRU. If removal fails, then someone else already
>>> -			 * has our reference.
>>> -			 */
>>> -			if (!nfsd_file_lru_remove(nf))
>>> -				return;
>>> +			return;
>>>   		}
>>>   	}
>>>   	if (refcount_dec_and_test(&nf->nf_ref))
>>
>> I think this looks OK. Filecache bugs are particularly nasty though, so
>> let's run this through a nice long testing cycle.
>>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 
> Actually, I take it back. This is problematic in another way.
> 
> In this case, we're racing with another task that is unhashing the
> object, but we've put it on the LRU ourselves. What guarantee do we
> have that the unhashing and removal from the LRU didn't occur before
> this task called nfsd_file_lru_add()? That's why we attempt to remove
> it here -- we can't rely on the task that unhashed it to do so at that
> point.
> 
> What might be best is to take and hold the rcu_read_lock() before doing
> the nfsd_file_lru_add, and just release it after we do these racy
> checks. That should make it safe to access the object.
> 
> Thoughts?

Holding the RCU read lock will keep the dereferences safe since
nfsd_file objects are freed only after an RCU grace period. But will the
logic in nfsd_file_put() work properly on totally dead nfsd_file
objects? I don't see a specific failure mode there, but I'm not very
imaginative.

Overall, I think RCU would help.


-- 
Chuck Lever

