Return-Path: <linux-nfs+bounces-9721-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06CCA20E21
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 17:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0183E3A2057
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AE11991D2;
	Tue, 28 Jan 2025 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a+lFK9KR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XvxJU7/n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119FF198E65
	for <linux-nfs@vger.kernel.org>; Tue, 28 Jan 2025 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080717; cv=fail; b=g1IIcmFwXKTCQ/g4bdopLMTPu4GT5eOpvlJIojI0WWdidgS80O10TNApefXsxxAE95+iM1lyCaXO5r8R2fw2c3S/FC7e9BituCS1VvZ4qTcdj1obC7DQytyvncLKI21uJ7KUo6xevLjpa7QUJFg9muqHw8tRwG3be00+gF2c34A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080717; c=relaxed/simple;
	bh=Xd5wTzjyT/rPNiLnc9oozb3RLk+1+LM/3giX4ZZ5SYA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IGL3FsPQB/UrLXJu9PUyUmxJJD18WnIsygxViSMJu8hXuFgAAhmE7BkQL4rnydm/ndGlWWPvZtLGvVMblt8cEWmdapY8JiNyT+bwYa6mu188voXX1uVkaowBeaHfWPAxK4/soxbgLZvxcp3kQGONoPgJIlc2Fzrc3+sf5bYiG/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a+lFK9KR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XvxJU7/n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SG6Mk3015287;
	Tue, 28 Jan 2025 16:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ewqz30rrL1tjw6bwIJkl1sI1YhGJ5ThTlbQk9t5I5HY=; b=
	a+lFK9KRRlOA+DpvXRFTcCKlW1RJ2xZynKwoeK8n/6nW9uMPH3rfg+Hq7Y991oqk
	9D0RnJN/3SUyI7SrZh9YIfyTMCunHF+XsmAM18twKc4PVFLqYRBJaRvOa61nNfD7
	TKEPwLGAFGOz1+prjDwCAvN7/6XP1B9ysBN6Pg6RyXA5yPMC4xCNa7s7MWl8DiX/
	8Kms/+aOltaquDBP5nEenMQqQKFDYYJqEZrY69OOzyO3A0e37I2ZmgeBj5jDZQFv
	LVWk3OJnQPqagaYSz2tLPHXEBwHnoP/K/yPOXfacuPUeIxUlB3xecChVTEDXCymH
	9eH1YEY7I+CaMTa7yh6yjQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f2ax01am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 16:11:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50SFmvuk005374;
	Tue, 28 Jan 2025 16:06:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd8m4hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 16:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V27BdovLOF8mf97k+x4Ve1b3qnkoD9vxuDcXF1UZcJeOiwNNsMqHXe7HpqtXW32pnwvZ4Gez1waM3zxKUyuZY8BcRseuCS94214fz0uwUhKXzZuqL9SpXwjeNXIRmz3/wI4uE/utT9Vp+wmJcjKePy89Vt2MZS9ocUfRSFhFxAOn8D87/lK9JeINkMuGarpYAyimK0SRjHM5E/JaxDpEdmRP6/iHXstJypKFRynDE8UqpPod0zMCHkLl9HTRS1JA0kT1ggxUH9pBgnsn+cRkZ0oOZLB04Pf6b70g79xxQmY1EUyk2sHooqz+PB+sW+eQB7/5mTRaS9hHG0pHQ+HRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewqz30rrL1tjw6bwIJkl1sI1YhGJ5ThTlbQk9t5I5HY=;
 b=v20auqT7Z2XRD7mOn5ks02LlLDCGNB8cdf5QBkvZihxfDVdB1RKGKJ2vjySuFPsnBUKxADM1ONEggpY7mDBIGBiFVt2Jd/KlF1K03iUlHaBUt/lsr0JEMNiarSSQ0DDuYVzNEnWXzOUd5iJk6jpwpuZE5eU+hn+5KdIIv9uLpbS74e28q2obC3g8LgJAZWn23IcqTzbfB7gxWoZo8DWIVkFgygkbtyN6117ENk0DzC3MJJBT5WoUHgw3ePF8QlswMUrwBgwFoOajXVGXsFzhPlX6oymyXtLa4lzn9rPLYp0RFOeI+Z4+vktYiHSFT0+1DIcQOQ0a62yxTIOdGFfs0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewqz30rrL1tjw6bwIJkl1sI1YhGJ5ThTlbQk9t5I5HY=;
 b=XvxJU7/nP7TywG03NX2OtNQ09xTCwJHOEoP+8Oar6Qu2Czico9om+Pu5Moi6NzIwuB+tSedhdlz6P7PuAQSakJQ7VpV1p0HUBpWyG0Me+yYC/GCiyieaFV85dfjtNH8U05CPeTQRpaZh7X3Tjrog5sneAQPv1w6PL1klOKUV/vw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8017.namprd10.prod.outlook.com (2603:10b6:208:512::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 16:06:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 16:06:14 +0000
Message-ID: <08fb33c7-d495-4b88-a28f-53521377f3bc@oracle.com>
Date: Tue, 28 Jan 2025 11:05:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nfsd: filecache: change garbage collection lists
From: Chuck Lever <chuck.lever@oracle.com>
To: Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
References: <20250127012257.1803314-1-neilb@suse.de>
 <Z5h7HOogTsM4ysZx@dread.disaster.area>
 <154547d0-fafb-4b5f-a071-6cb697f6d9ed@oracle.com>
Content-Language: en-US
In-Reply-To: <154547d0-fafb-4b5f-a071-6cb697f6d9ed@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:610:57::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 1993194b-cf74-4da9-501a-08dd3fb5b087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzFCNXBKUXNoeHRWVm5kY01IRXdFTGdhVDZONTIrZzVuWG0rWENDRGlTd1py?=
 =?utf-8?B?aGllSHM0Zm92ak0xdnZJbGd3ajVVWWl0R094TVh2em94dmRDbklBd1ZUQzNB?=
 =?utf-8?B?dzlzcVJ0dG4rbTQzcTFSaHFlc1VwTUdiUlk3L3FoclA3VW5ILzBHSFdNS0NI?=
 =?utf-8?B?ais2S1RRMnBNY2ZiVGRHT09NWHFleUxBWlA5T0JmS0pJY1NSa1JNMEszSjJk?=
 =?utf-8?B?MHlFWTYrRURDejd4eGZZcWNEcitPcU1QV2trM2tuclN3OTUycE8wNGdrbzlV?=
 =?utf-8?B?R09XTDI5MUxXdER5bWRCZkpQS0ZRT3k4bENYQ3QrdnJkWjQ2VWNUMGZzZ0V3?=
 =?utf-8?B?UjViTGVESnhVSnNVQkxtbmczNTRoRGpBVThOSjF4ZDBFYmFaWFRlWUowU2x2?=
 =?utf-8?B?YThEMEwxY0s4dVI2N3NQU1AvY2E3N0kwWE13WVlWRGx0bFhiZU1vbC9rMmlW?=
 =?utf-8?B?MGE0SWtHVGp0Q3F6MEpkZFJRdEtDNFgvMmdtbVc1aTU4Wm9MbE84elNWVXBo?=
 =?utf-8?B?NFp3dWJuQWc5WVdxWVdOUk1QSFNzL1VKdi9TL2JieXRkWWNkd2c0bTF3dGw1?=
 =?utf-8?B?VDZVK1V5cWl0eWxOaDJKTEw3aEhvZ2kzU0s4eDllbkpoVjJYZVBxVTZvQUMx?=
 =?utf-8?B?SjhVckxrSTJabG95bEplQ3hhVkRnKy9DTmJ6RjhmWXBGZ29Vc3B4MTVBKytC?=
 =?utf-8?B?N3RLNFZSblFtQzFjU2wyK3Q1YXBwcE9Lb3FJWlE3Sm1neU43ekZSUGFidkVo?=
 =?utf-8?B?bkR1T3dabWxsSkY1cmdzSmlzVXl4SzNvSEt1Y0twMzhyV2EzcVVZVUdyQWRM?=
 =?utf-8?B?TUw4bVV2bE1CSUpCYVc3UWRzUGk3YXRneCsxYjlycVlpTHNlaWo3aTFtR01W?=
 =?utf-8?B?ZDZyNTFvRjllMG9BNnRuZE1WY3VoMThsaytxc2pieU9YcEdvaXNRS2xYaHpH?=
 =?utf-8?B?eDQ3M0NJMHQ3dlBvN0ZZY2tmczNUVGNxRzJhZ21BbTFzMmxUT3pYbjU5SXQr?=
 =?utf-8?B?SjcvYm54bFB5alF1R3hxbERHS2RWQlBsMXJoakhMSTJtM0g3bklwQzMzcFp6?=
 =?utf-8?B?cU1xUjdlS3hWTk9KY0tyallCTWFtWld2a0xBU0dYekJrNDR4STdVR1JhbWpz?=
 =?utf-8?B?ZzJya0xhdGFqbFNJS042WlFkeHl5RERoR016bWZ2aXBRTGNQcVdPMElYRld5?=
 =?utf-8?B?ei9sbVJNN3p6dE9yYldweUZPWTBQU1ZUZzJRbUVwNnhxVVRPRGRHeVF3aE4x?=
 =?utf-8?B?Z3JWUU1oN1hVUGwwbml0QWJWUWw3ejJ2d1pwdmprQjB2dUNFaGxQUUh6SEZ2?=
 =?utf-8?B?cEpDYUFzN1hhaUFUNlYxRGVibmVmYmpHSTQrcEV4VEord0ZTT2JjbWpOaGpm?=
 =?utf-8?B?c0RaSC9CeEVoNEt1bmpRZ2lMU0x3YVhLbVBHVktMbGZCaEVZL09aT0lkdldv?=
 =?utf-8?B?RFk1Y3JPaWJYakQ4Mi9tRjFOMFUwdEM5Wk1xb0Z3S0lUdzFLdGpDSkZHODVF?=
 =?utf-8?B?Ti9CVlA2cEljY1hoYVpoMmRGeWYrU3VZR0lsTDI5enlsUStFcStGK1R0NWh0?=
 =?utf-8?B?RjkydVJMbmRNTVBMSzBla1pIaytFS0E4ZHMrOVB1RmZ0ZGpqZHRXRVZvL0dB?=
 =?utf-8?B?V2wvZFBsTmM1VFFLYWkzUDdQU0J1dlVoUHVqYUpZUWxzZkJ0VmU1YWpHdFpn?=
 =?utf-8?B?dC9lYWNXYkgxZHNIa2ltNm5ndDg4S3NZc1lCeU13TTJyUlhiQWZqUEdJelVr?=
 =?utf-8?B?amQydWl0S2xKd3dhZGdENXY5NWIxcG9UcjNLcE55RjlHc09EZXJFZ2w0Rmxw?=
 =?utf-8?B?STFTQ3d3ZnN0MFZyQjJMZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nnl1ZGVzOFppYVIxaitmaTJwekVFaEEzWkc2L20wM00zV3VZaWhmREpCZWNK?=
 =?utf-8?B?Q2ZpRWQ4L2xuUEwwT1FMckNwUmJ6UWhHN2ZiUWc0SEN1SlRMRFFrZGhKSEgy?=
 =?utf-8?B?aVVBUXYrd0drU0g5dEtQSzZBTHA3OFlVK1F1akowekRMTEV4UGlFR2lHd1BU?=
 =?utf-8?B?aEpVaXRNUlFDVHREdjhzTmxHSTduSGowNlBOeHM2V1k4VFRoY0RWVUVPbkpy?=
 =?utf-8?B?Z3JscEQzZnJNSlExTnVjQ2Ntb2NESWNlYzQ4NWZibjZnQjZtaGVMUElnNmp3?=
 =?utf-8?B?TGw5K2xFcmwwZmlXb243amZvRkozRWZobXNZNEFiRDl5VHpaejNPbjFuZER5?=
 =?utf-8?B?NHMxdzMzNTNYbDJjUmg2dDRGbU9rNWhvOTlJU3ZtOWNHSjAwbFYrVVB3MlZL?=
 =?utf-8?B?UEtjd1lweCtuQS9kTGhGU1E2Y2NDaTRVS29HRUtnTlkwMXl0ZmoxTGo2N1Jh?=
 =?utf-8?B?bkUxeFFaVG55dGpwSFRmaG0yV25uOERQYktaTjk3NCsrOWZHNXpiRjdETUo2?=
 =?utf-8?B?ekRqckFudHRxaUVGTHJ6YUxnV2RlTHhqSWlLOHlvb0lLVENLMHBUbkp1Rmk0?=
 =?utf-8?B?Z3lpRjlZaUJqcVdXb1NHODBhWmh3NmROU1BBWEFaWHp0TXFwbVlDdlN2THBE?=
 =?utf-8?B?TW1IeEl1RFpGbFJlS0h5M3djMEdCNjhGVVh2Ukk3dDhGUm50RktydUIvSzRG?=
 =?utf-8?B?YUp4VElOVXVEUkQ5dUF5Uzg3OHlhWUZWMmFXMjhQNTNiUGZHTUhGQ0lPR2d4?=
 =?utf-8?B?THJndmpkRlNkUUs1enR1YjExUVgvYXlxRjN2QTMxSkNqTnJqSEdyWll4N0F6?=
 =?utf-8?B?TGNhZGhJcmQ5RUNOVzU5TWx4TCtObHorU0I5OEt3OGV2QWhjeUdvSWtrSDV3?=
 =?utf-8?B?REpuSXFMNjd0L25vOXJGVVcra0pIZkdFdVpGWW5ZbHRqUk9QQ1ZOZ2NycUVo?=
 =?utf-8?B?Ry9JWnlKSk1kUGVYbXFmRTVjSE96TVMwK2xxVkdDaSsyTDZ1ZHEvTHY5MkZW?=
 =?utf-8?B?S2cvZ3grQVpwWkM3Wmd1ay9ucE1IUVRNY1FOdlZNNDdpb3E4cGhEVE44dzFX?=
 =?utf-8?B?bUhGN2U4bzRaTFhROWtuSXJpc0JzYzU3M09rei9LZWdvTHBUa1ZMcUxIOHVD?=
 =?utf-8?B?d3VSMExhTmpZUVE5ZE9iK2xIRythVFdyOUFuQ3U0OGhYSjRzcHRJTmtnVnRL?=
 =?utf-8?B?QnV3emxzaktKbW1sT2Y5Wi80Y25RdjY1MjVoZm9WZHoxNmJXMjE2THJ3RDYw?=
 =?utf-8?B?VFdQR3cvVHlNdSs5emgycjVubkw3T0l1Q2d6YTZOZGxRcnVZdlZPNEFGNTB1?=
 =?utf-8?B?K0xFV3JMdDVEemE5TVJrV3RTaVhiVTZDc0ZJUEVCdHdxb3hmaitINnR3dEtu?=
 =?utf-8?B?L3d3djdJWmJFdVdnRUJQQ1EyTEZQV21tMi9SYXhhS2lYQmFWSUNrZjRsemdh?=
 =?utf-8?B?VTVGck9RbmF4bXRNSkhVbTM0Tkt0OEdIUGJQTlNvMVFETm50VmY5NU9SbXpW?=
 =?utf-8?B?M3k5WmpvdGdTM1ViZzVhYjhKTkh1TmJ2RC9uTmZ1SElhY0crdkN5T3huMU90?=
 =?utf-8?B?OU14d20zRkxTOEtyaGpvdXZ4WGwrNmNhMjFPZnVEbzF1SDRQOTdzMktCSGVC?=
 =?utf-8?B?bzdFSzk1M1l0RnFBQXZoN1FEV0F6YmFTZFhyb2trWHNSUFI0YW8yQlQxdkZi?=
 =?utf-8?B?N0x5cWFpbWplOUgzU0pEbFJ2VkxGTC9QVlhpUGVCdlVkYUlPZHkvZTdwcGlB?=
 =?utf-8?B?YWVZR2tKSzJ5OVp1UE0vY2ZXUjl2WkZvNXZjb2MrREpXMkYxNVNialNDTXNX?=
 =?utf-8?B?OTFVUkZMdXY2eVlmQVBzS0t6OStWM01Ba0FVY0U5RjNwcU5rUHUwNjN0VVZ4?=
 =?utf-8?B?VWJ2cFg3OVhFaDBid2tXZ0h4clZPR01VUzcrZHBnL0V0WUYvSE9wRlhEVlo3?=
 =?utf-8?B?MlN5cFJPbUh2ZmZ5RDF2NGMreWF4RnNwdUJnV0F2bElrcFFCQkpUUjgzRXF2?=
 =?utf-8?B?WFUrM0I1L1c5bWdCQ1ArdnhtRzFkQnIySjRyT0luRUdhS1FGMnFqajJkUnEx?=
 =?utf-8?B?NWlLY0o4T05ZbHc0SUU1MVJxdWE1NmhDeUhNU05NOUN2V3JKM3lxMVFqTUpW?=
 =?utf-8?B?bFdsM1dnVituMlJyWDRJY2dmZWI2K1dRMG4yOUNXR1pIM0wySnR2Snk0dkRP?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	APsPrDdmAxv88iFsUkWTVf93zYV+lY2rARVKPW3QkORNqmeMtEQdS9zrZZoeYTnVyXzMRPV6XPsCJB+BbXcUASf2eI9fkgOH/qzhAaUfRiuewwZ2ZDPPGpnMAmHmnp6LzW/C2SAWoQOzZBRhHSTeKIb231BPxLhxtYkgEhnYgnIiPtmji+B/z3Cvn5VlTRVPsgydebEqaes2kBNzyU0ErMYWBD1V9jUg+E5dbWjgbRtjC7X31/h9w7lqPFzWTlkYeOlo2ppiQke36WnwCTLj3npSbTWXevjW44jagPuYWkTjWiCZFBm4dfjIcGPOwO9i6a9/1zizFdgucoejfwbV2URG6D03vHCXTTxBD/l1Dj5IZac0ujT2vZG5yOOvG7e3w5gSO713rBhXMueH9rVsSCgDqgplwMPCCfPJmgwfBmDGbakI6mjq8FnXVEqom+jGwvp2+9kHhPjRsGSUDwqgP1E3akHUhcSX09Q5Za+1TW8zHWxqJLomVNlFvtlhLaPUuPxnhwdhQgNSUhisiXjpdN8740ENGoXxVEIzVwWNE3nxQi1PxDWFxdobSfmQDrF3QEv27V18Wgk8dZ3wg3YanG70wd/rtpti3B5CD6zD89U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1993194b-cf74-4da9-501a-08dd3fb5b087
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 16:06:14.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8mJomuWWSoBaLcxPnGRcrNgZI/I3m91sqNfGPoUdxsYE/8xfj9YPnCfTgUXmEYrbHkuhgkqzretnceEHgks3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501280118
X-Proofpoint-GUID: mkdHDvKkUK_fEiee30R88GQbnpEn-PKb
X-Proofpoint-ORIG-GUID: mkdHDvKkUK_fEiee30R88GQbnpEn-PKb

On 1/28/25 9:27 AM, Chuck Lever wrote:
> On 1/28/25 1:37 AM, Dave Chinner wrote:
>> On Mon, Jan 27, 2025 at 12:20:31PM +1100, NeilBrown wrote:
>>> [
>>> davec added to cc incase I've said something incorrect about list_lru
>>>
>>> Changes in this version:
>>>    - no _bh locking
>>>    - add name for a magic constant
>>>    - remove unnecessary race-handling code
>>>    - give a more meaningfule name for a lock for /proc/lock_stat
>>>    - minor cleanups suggested by Jeff
>>>
>>> ]
>>>
>>> The nfsd filecache currently uses  list_lru for tracking files recently
>>> used in NFSv3 requests which need to be "garbage collected" when they
>>> have becoming idle - unused for 2-4 seconds.
>>>
>>> I do not believe list_lru is a good tool for this.  It does not allow
>>> the timeout which filecache requires so we have to add a timeout
>>> mechanism which holds the list_lru lock while the whole list is scanned
>>> looking for entries that haven't been recently accessed.  When the list
>>> is largish (even a few hundred) this can block new requests noticably
>>> which need the lock to remove a file to access it.
>>
>> Looks entirely like a trivial implementation bug in how the list_lru
>> is walked in nfsd_file_gc().
>>
>> static void
>> nfsd_file_gc(void)
>> {
>>          LIST_HEAD(dispose);
>>          unsigned long ret;
>>
>>          ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
>>                              &dispose, list_lru_count(&nfsd_file_lru));
>>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>>          trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
>>          nfsd_file_dispose_list_delayed(&dispose);
>> }
>>
>> i.e. the list_lru_walk() has been told to walk the entire list in a
>> single lock hold if nothing blocks it.
>>
>> We've known this for a long, long time, and it's something we've
>> handled for a long time with shrinkers, too. here's the typical way
>> of doing a full list aging and GC pass in one go without excessively
>> long lock holds:
>>
>> {
>>     long nr_to_scan = list_lru_count(&nfsd_file_lru);
>>     LIST_HEAD(dispose);
>>
>>     while (nr_to_scan > 0) {
>>         long batch = min(nr_to_scan, 64);
>>
>>         list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
>>                 &dispose, batch);
>>
>>         if (list_empty(&dispose))
>>             break;
>>         dispose_list(&dispose);
>>         nr_to_scan -= batch;
>>     }
>> }
> 
> The above is in fact similar to what we're planning to push first so
> that it can be cleanly backported to LTS kernels:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/? 
> h=nfsd-testing&id=9caea737d2cdfe2d194e225c1924090c1d68c25f

I've rebased that branch. Here's a more permanent link:

https://lore.kernel.org/all/20250109142438.18689-2-cel@kernel.org/

But note that the batch size in the patch committed to my tree is 16
items, not 32.


>> And we don't need two lists to separate recently referenced vs
>> gc candidates because we have a referenced bit in the nf->nf_flags.
>> i.e.  nfsd_file_lru_cb() does:
>>
>> nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
>>                   void *arg)
>> {
>> ....
>>          /* If it was recently added to the list, skip it */
>>          if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
>>                  trace_nfsd_file_gc_referenced(nf);
>>                  return LRU_ROTATE;
>>          }
>> .....
>>
>> Which moves recently referenced entries to the far end of the list,
>> resulting in all the reclaimable objects congrating at the end of
>> the list that is walked first by list_lru_walk().
> 
> My concern (which I haven't voiced yet) about having two lists is that
> it will increase memory traffic over the current single atomic bit
> operation.
> 
> 
>> IOWs, a batched walk like above resumes the walk exactly where it
>> left off, because it is always either reclaiming or rotating the
>> object at the head of the list.
>>
>>> This patch removes the list_lru and instead uses 2 simple linked lists.
>>> When a file is accessed it is removed from whichever list it is on,
>>> then added to the tail of the first list.  Every 2 seconds the second
>>> list is moved to the "freeme" list and the first list is moved to the
>>> second list.  This avoids any need to walk a list to find old entries.
>>
>> Yup, that's exactly what the current code does via the laundrette
>> work that schedules nfsd_file_gc() to run every two seconds does.
>>
>>> These lists are per-netns rather than global as the freeme list is
>>> per-netns as the actual freeing is done in nfsd threads which are
>>> per-netns.
>>
>> The list_lru is actually multiple lists - it is a per-numa node list
>> and so moving to global scope linked lists per netns is going to
>> reduce scalability and increase lock contention on large machines.
>>
>> I also don't see any perf numbers, scalability analysis, latency
>> measurement, CPU profiles, etc showing the problems with using list_lru
>> for the GC function, nor any improvement this new code brings.
>>
>> i.e. It's kinda hard to make any real comment on "I do not believe
>> list_lru is a good tool for this" when there is no actual
>> measurements provided to back the statement one way or the other...
> 
> True, it would be good to get some comparative metrics; in particular
> looking at spin lock contention and memory traffic.
> 
> 


-- 
Chuck Lever

