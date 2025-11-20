Return-Path: <linux-nfs+bounces-16618-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33166C7463D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 14:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B755E30F44
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E033446D3;
	Thu, 20 Nov 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OgAEKowp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MhT7CKIl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1193446A2;
	Thu, 20 Nov 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646746; cv=fail; b=VqwFfhcb/X2hx6GjUOr1EQde2Gj1JcFBKXI+JvWFK9ctlZeaB0nukVs4/GifM5OWYHg9oje9uee1wmZPCC8VaW4HhRN5Ze52kQU+tUOz5XrHuJYry16n591SP0/cKF7bxupxUk58wDAGq3I5MglI4xSzkOZicQ3+uqKVD7tRYZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646746; c=relaxed/simple;
	bh=EcP2l7MlmcWfMq36an2lrNq+05eMZx7rYUfAkWz6DZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pXxEQ832heDcdm9RPrXRyysk5yLpPaoD+8i6KNYmYtEJ4Yo58YyFWSS5+N2fk6lF7AByJHgyJFrQvORLpFN9EvxdfauayJrpTA7MS+lUqkXKDVBxj3qWt6rYa5efqdmgZaKziTHDUyu8lEBkyAVyT2invAQzCfU+53K4mIlIgh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OgAEKowp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MhT7CKIl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKCfvss024693;
	Thu, 20 Nov 2025 13:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IJ7eQvR7EwSwELZGE+LvHdK/sQBaMgZg3PBGuAV667A=; b=
	OgAEKowpHawcqA3StQ9R/RPMz3+N/K6cZzQ/W4upd08aJysnaQAMfprkejm/ss3f
	tutBFXTmjLwiOcQVPM9YtnwZr+gT8Vv96o0WrkfYK+bKRA+dLdTOzvGckC7gE4vM
	NgMVW3SV8TxJPCiV5ceWVlWpwzoeYUwb9azQuRvSSay1sL7LJXHpCwyr5z0q7Af6
	zFNsvDH8Q8R8orwnz3aUw2COu9yTZl7cB/Yj1xfG1c6XYzWQsIc8VFkhxlLjO2wM
	CcenVAbAlSm9wQK+DKTCekSpuFJXEdRtkmxANVYp1hF9rn9Z4QLgkVwgcjUhez2M
	HV0Tlc/cl+Rr4/DT2ZBeMw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbq158h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 13:51:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKBp3Qc002564;
	Thu, 20 Nov 2025 13:51:57 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyc3nj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 13:51:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtychvVsH7kSYI5J5TNBB85cE9atk03HUDB/PqxNSV6uixMI80KC/IzEZV9Tnb23GWyUkFKEMKUgZaILANW6Tz2yQNdNP310NM2ilVpdz0SbJFOWO55OLxuhT0Lh7HWyLG6duMN3xlR/vSIrXaGgAq+KQVfOeiRmmksF5TvvpJf6nc2AeETR+1zAVsh4QfGai8rRY1kFheU5AFtnSWwYmUWIBJZ+LThz8lOojP29pggNlaZEIzBrrGaTtUzc3aLStpqBgRMSHiyM49YElVl4LZW2K1InI20lMY9vdwPgSJNNYSBpEufNFYmG/vaMliiZEs9qk3dU9bewWob1wlM2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ7eQvR7EwSwELZGE+LvHdK/sQBaMgZg3PBGuAV667A=;
 b=w/AsXl+k7BcIesNmvS8zm5T/ZoLioOsy5zJJYu8l9Jyr3k3Qt6EOjQHA1GKyxwBLEnNGBFUZf5JqCt58Alvs0GWmZZ4P7Y9FUnipzSz22guJodhTjQxfQtsKsAaO6bHtbxvfu8sFnRS1Bc5mOvCJOD/37GSQpB9MZ+UUi2wvWu5VdtLSg8FOfJ1D+MAu/n2jxE9PXxADwXNwAW8oUaPLeUp4qWDtqXShdhL02xe6hydPaF1UYIKK2sivDNeRpI18z/grZrvqVGZvdgLpA6TJYaOZtSusBTkAq4fsjC+tvYtzq535SpdLKnu59U6Blj1pkfJSdLktE6MI5b5NkEQtYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ7eQvR7EwSwELZGE+LvHdK/sQBaMgZg3PBGuAV667A=;
 b=MhT7CKIlYlUsH9ot91BRpNf1f9KeqUwpoG7G65h/XyOd3txI7CwtX8tFq7NyyVvndR+7cXWmUcBOtYo6Dia+DKIHQ79+QO5/Peg/wbAVP69lVLLPglQjm5NDpGlwHz89+QRULwJxT7aGKa1vLL4AHza1jj8Ywc8vKFtJXMi44pA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5114.namprd10.prod.outlook.com (2603:10b6:610:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:51:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 13:51:52 +0000
Message-ID: <14f4ee67-d1dc-4eb0-a677-9472a36ae3bc@oracle.com>
Date: Thu, 20 Nov 2025 08:51:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] net/handshake: Define handshake_sk_destruct_req
To: Alistair Francis <alistair23@gmail.com>
Cc: hare@kernel.org, kernel-tls-handshake@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-nfs@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, kch@nvidia.com, hare@suse.de,
        Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-3-alistair.francis@wdc.com>
 <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
 <CAKmqyKN4SN6DkjaRMe4st23Xnc3gb6DcqUGHi72UTgaiE9EqGw@mail.gmail.com>
 <0d77853e-7201-47c4-991c-bb492a12dd29@oracle.com>
 <13cf56a7-31fa-4903-9bc2-54f894fdc5ed@oracle.com>
 <CAKmqyKObzFKHoW3_wry6=8GuDBdJiKQPE6LWPOUHebwGOH2PJA@mail.gmail.com>
 <1cc19e43-26b4-4c38-975e-ab29e0e52168@oracle.com>
 <CAKmqyKMjZWAvbc23JQ358kyWyJ0ZajHd8o0eFgF-i1eXX85-jA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAKmqyKMjZWAvbc23JQ358kyWyJ0ZajHd8o0eFgF-i1eXX85-jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef4d5dd-94fc-40fa-d10a-08de283bf567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXA5Qkg0Ulk2K1pLZkR3Y21GbGJJazNCOUpJa0xTNGZJZng2dndZMlowQWRI?=
 =?utf-8?B?S1U2aXJYWDJrQXdLS2dNaFlLVCthSkc5T0kwWlVnRHQwNWJnZGhiRU4rK1dL?=
 =?utf-8?B?WmJMZmtKcmdRQmlCMkloVEI4cndqNUZuQVEwNmN1aEZNb3lhL1F1WWVGNnpN?=
 =?utf-8?B?MGhoM0xsempNa2tYVHMwdnliY1pjMU51L2pkMy82LzFza1A1YjFLQlU0bi9F?=
 =?utf-8?B?TFhKaTUwSUp6YTJtbG1CQm5zNEZnbW15TDZ5UUpVNTNUVFJDQUVPbHE3Z28y?=
 =?utf-8?B?R0Q4YXNLaFJLZ0FHcmR5ZUpHb1FsWit2QVpTMmYyVENHU1hHWGltMWRqUjE1?=
 =?utf-8?B?TGtiL2Jta2w2TVU5Yjl4cEZTb1FQc3VhTnAwVHBUcFNsVWhZa05ueWtjelZl?=
 =?utf-8?B?Vjg5SUU0TlovVlhoWlBCZTV3c0hCNmozU3VHZDJMeVBGdEJaWUh4NW96eW1K?=
 =?utf-8?B?SzZoZGpZZVlhdVNIK2RDUXIrWjVBSWRBTE1xYVhMZC9PZ0xjWWg4Y1g0OGhD?=
 =?utf-8?B?aGJlR3AyeUpHL1l3c3RYQ0xZMW80c0FnRUdkUFJ2VXowK1NEZk1zdy9GTm0y?=
 =?utf-8?B?UWZ2UTZhQWY0clBKZjMrN3I2bnVpS1FYeldsclRmNllGOUtjL2xZTS9DUDRi?=
 =?utf-8?B?RnRycFErcDVyODU5UXFPT2hZRkVOUDl2Rkp0dXc0TzA0TXVoYXNrWEVBS2NZ?=
 =?utf-8?B?NDAwemVrK3BNVGl4SEFYeXUzaWMwQWc1dzFOWDFqK0NYVHdSdHB3U2lrMTYr?=
 =?utf-8?B?Y1RtUVB2MDdvNVJZRGw0UkxGVHByRjY2QXdjSzgwQUt4dFdTM05uUkNDZloz?=
 =?utf-8?B?RnZ2dnVZazVLbjNkWG9XckU3UDFhZUxSKzdyczZXZzdTU2pmSXdFOE1taXhI?=
 =?utf-8?B?NVFsTUgwaEQ1UWpWOFZMb0pOS3JLeUx2Zm5UWEpQcjF5OXJtbThVZzlzcFMr?=
 =?utf-8?B?ekhDQnBKNzcxekhRRHUxbSt2SzJHRUFMM1FMbWpzbEo1aVhlcGRRYTZVdFBC?=
 =?utf-8?B?QXZScnY0RWxRZktMWmVwOFpwbzFzcWJYMDB3SzQ3UnY2L2RyeE81cktsdU00?=
 =?utf-8?B?N1RuZGdHUGJtRVZNcjRwRGtrc0tVWVhWQnp0U1hOUGNrbi9iVDlpVnFLK2F0?=
 =?utf-8?B?U0x1Ry9IbW11MlFCWWRuQkp1MEpkMzh1dXlBTUovVDZaZUNaZU81dHpjK0Fk?=
 =?utf-8?B?cXFDbU1Rck1Gd3ZSUGFIVU9CZWlYT3pGQWVKdnNVcE12VFBHcTlsUW1WekZR?=
 =?utf-8?B?SHVyU3dqR2RVdVdRekNNVitid1IybWsySTVhS3daYkhWTFpnTkxkOXplK0Fu?=
 =?utf-8?B?VG9wbUdjNkNyemg4TmZSaEIxMS9EcDJWQWlvUWNna1IwMUptQlFibXZuMUVH?=
 =?utf-8?B?V0VSMzUwellCbnZaSnFUVHgxS1p1bzduZFR5L2ZVa3hMb0RXQ2NhRW0yZ3Bh?=
 =?utf-8?B?Q2hmcU5zT2EydVNMYlgxQkdKbjROYmlhbnhMa1VPQ3RwM3BzY1pLZ3lqNXRL?=
 =?utf-8?B?WC9aSVJQME5vWnN2WnlqOGNuc0hkcFllM1g1cE91OGIrZVJhU1lONTU5d1Fa?=
 =?utf-8?B?SEdUeThnSDM3K3pxb3lzUXQvd3B4cGMyZWxlblVpVUNXSEZuSDBiNXBmcnJy?=
 =?utf-8?B?SHh2K1ZpR0ZXUmFJc1FlZjZ5SkJWUTUxcVpFSlUraEJiZExvOWpzbCszMWRr?=
 =?utf-8?B?aWU2Q09SQXI1VHl6RXRiWU93VWFkZm5pSkp3Zjl2aFk1YmcxbWh1WGVlZzZB?=
 =?utf-8?B?QWJIWFZMWUU4ZU5abHUyeWtNa3pWalVMNU51R2NMemtscXc4UkJzSXRpTW5X?=
 =?utf-8?B?L29iQ3lnQktYZ0ZSRWwxZmU0c1dqQXJqZ2pValZHVk1EZG1NMXN6bkMyTU9P?=
 =?utf-8?B?UlNMWHRZN1pSM2xwY1JWaVgzSmV3NmZTNTFrd0w0NXpLTzFnak10b3FqY3lW?=
 =?utf-8?Q?/6hYmGhQIdlIPAoOrN6nN1E2b4Bz+5m/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEsvL1N5TGR0blZQSGZvZEd4VGJtZFIzNjlUOWNiZVd5bm5GRXpzYkg0c3NV?=
 =?utf-8?B?SFZMbWI3TDl3SUsxQ2grUmg2WW9VT2lJN1JBa29pQ0ZpQ0p5MjNCWW5WOUE2?=
 =?utf-8?B?UW1RT1JGYnZFSE45M2hCRVk5QjlHUkd3Snl2U1ZBSVgxelpvd0MyWmlzY09v?=
 =?utf-8?B?NW81ZXZtYmZUQmtWRmJYUVdqRG41cElQNnJlTXl0d2xlTGFNTnhLZ1ZzNU03?=
 =?utf-8?B?SHBUT21lYXA3dXRtUFZGNUxJTHZ3N0x2MU1DcjBKaXFrZDFNc3JlMHdCOFNW?=
 =?utf-8?B?NjlVbWtoNFd1V2RyWlZVM3FleVM0VWI2TjFUejJlWDZmSnZOU1FRTlpMN3Ex?=
 =?utf-8?B?VjhJNVdsNzVlbFhibGFYcmQ0djh4L1BTd21UMlR6d1o1bXdFWWdVc2t5N2lH?=
 =?utf-8?B?a3BneElzOGZ1UnpTZGMxZ2JUanBBSW5SdHAwWlloSGNDV1dFamdtRFRWdXNU?=
 =?utf-8?B?R0xhd1hGbFJsVm8xd3VUbFI1b1d1WWZ6by9uSWdWUFd0TW1Fc21jUVcrTXpX?=
 =?utf-8?B?Ni9taGwxMm5SeERSZ2RhOUJGYS9qMElsSlZyRVg0NWREcFhXK01uTmtPR3hy?=
 =?utf-8?B?RnZ6M2ZqcSs2L0dIMWtqUVVkNGdoL0QvbWJBQW56dk4rdVI4SDc5MjFsTXdN?=
 =?utf-8?B?WEpUSlQxSGx5WDZDN0N4eWFmMk9qclk5R3BrUG1nNGU2Ty9jQ25NWXZvV2Fy?=
 =?utf-8?B?WE1Gem1vUnJSZkpyOXpTcjBHeDBudkpFemZMSXQrT0JES0FWNmxZQnFLN1R3?=
 =?utf-8?B?UzA1SnI1VWt4Sk1tbEFDc0t3Rm5MZ2pBVnF3R2U0TmNtY1dFcEpjZityVnZH?=
 =?utf-8?B?N01wOXZneDhEZ3phZitHQlpuSEl2dFpkWVVZeGl5SkxmL2RMTnp2TDVpNzZY?=
 =?utf-8?B?V2pDZ0x6KzZYVlpBYjhTL3lVbGpVRVpGeUdtNmtMRmY3bVYxS1ZCNy91bTNv?=
 =?utf-8?B?TjhMOC82ZmVXNVRRdUFncWdBblU2cHdVZzNPeEFqcCtveDRSL2QxV0tncXRH?=
 =?utf-8?B?UFpESCtTMXdaY1dxZTZrL05hV3B6UHJqaEhtaDgvZ2d2UytpditUZytZQ1VK?=
 =?utf-8?B?ekRPMm0vNXEwbmp1RlpveGxvTnlJa1dIYk9Fa29na0JnWmZ0V1I0MTM2Ykk0?=
 =?utf-8?B?ZnJDbWVXRzZnYmVoZHdkYWpGWGc1OHVabFNpd1MzSWtqNGJ5bnRyR2dpS1BU?=
 =?utf-8?B?OVQyS2NCb3dQaTN5Y3lkZytyNzlrQm5ITmFXd0I0aUVPTGVMN2FVL05RWGJR?=
 =?utf-8?B?WVYrbURnRXowRzEzZU9ac2VMZXlqZmdQUkk5Qmw2VXFCdXBWeDd2SkkzeDY5?=
 =?utf-8?B?OFNEdXBrL2lBUjhCQU5GVnhlQlJ0R2pRMlhXYXpkSjBRY2hwcVdzd3ZUY2Zn?=
 =?utf-8?B?NXJqenh6RjBHdlFtc0FuQ0tYZmhHZ1o0dWYwUXNRUjgvZEI3eG5DcXFybFh2?=
 =?utf-8?B?Z0NoUDFINURaVFI0QU5adW0vdGdYSEdTdFY2WjUwUmNEOTB6bExiUGtyQ2VL?=
 =?utf-8?B?VVhSRDJ0N2JXRC84eDN4OTJSOWNKQWFDZlZuREFJMkVTZGM4eHplNXhrQWRY?=
 =?utf-8?B?dWFzZGd5WjNmMDc4M1NkOTRDbHVseGllb1dTWWxqaTRJc0lSWjNGR3pPWW5z?=
 =?utf-8?B?c0g0Z2VIc0xSWnRyaWtxSnI0U0gwNVQyZnR4azByelZ6VHVXTU5RNTZhTlA2?=
 =?utf-8?B?Q0o4Rzg1dzhTVE1QcExDWWN5YzByYTUrTjNQSllkMlR2a3dZeDh2eHVhZjBL?=
 =?utf-8?B?cUE2b0hzT29MT2RsNzdyK2U0Q096RmxQN2daS2tLQjhJZE5jcUVVUll2TTZG?=
 =?utf-8?B?b0lrUElxK0lxckh4WE9ONTR4bElOKzEvRFNKcFhiYWF1SnNhRlBKMGp1WVJw?=
 =?utf-8?B?M0hKNzk1ZmZQbHVvakZBS0k0OFVPNjZjZkVwYnQ5QzI5K2svZkQrRnloOHVJ?=
 =?utf-8?B?WkhBZjhCcFZpSmZDN3JSTEVLUEc5SDN6NUlxM2tXcmFYeUxMQ2ZCcWpHYjE2?=
 =?utf-8?B?bFVQeE9HaW9sWTBGejl5OFlzRWNaSlFwNnZDbEZvWjZ4KzVsTko0TXhYNGxY?=
 =?utf-8?B?cjhWcE5QaXl0ZjIxcmFpSEQ1T1VpVmFGeVVrMDREaHJ4UEF5LzNFd25wN2ZS?=
 =?utf-8?B?ZkRwQWg5V1JXYmNPWjlJU1h1ak9RVUdQeWMrZmxNU0FhU3JGVDd6dGFITzk4?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pG5vXx5MV5PQGgGTX5C/5ntdqdB3KaO9k4NwbOjr4LvzR9oP0S11TfHbJofXKsLGXEaN69RKPk9RKZc+g9fLSUr6Enwxjj7F56CWYz0dMFJG2KP9U7t0fOPHPTAo1SISoAffQ8204wFXttGmTLSLqw9pnydHjdArRyUmn5d2NafGH50UiKbDW6z5NIQfNKdTf0cgzhg+WrVWVhgYGgC1WBilj/bfGCOqlewAVmWEXO2crIAyM1BAX6Hxqp7ixhdhyDvdfpN3yHG2p7FEjQc+yyVjjoJ9P81U9lMB4Hik/bwrmhcY1CvP9wEPDDP4fextb6DAwdvmTVXdagaPJ5PyQoZMiai6ogOqfofF/NV1GBAZzOwAs+J5Z9LGnV4uBKaZZQfTD0OUSy6GaMWBa2RkQ+hNBRV0qVDNiEJejj5+2VrjJL/oWsXKCDK/ofnigNWlgVqgsnHuNwUF0LgjjKfvHdmtYSKNmBu0v7fVDY0TMhjUCN6F3BagamcY49mCr2lJ8QKfOCEJFVS2LBEKbmW85+MajUjz1bHrCJyGQsWj+bHnbIcap93KDxD61zj8IEtL8B6De9A6POgSk6QqE/rsXPJZkaEgpdiHw2Kg5BUZLmI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef4d5dd-94fc-40fa-d10a-08de283bf567
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:51:52.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZeIScbjLZoZub5YNS/UnQLdEEUKUvbaMnrvBHJB/q0yAn5UpBpJeel23mAkET/IU7DdGUzBdMBdGvysiKqFeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_05,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX+jtFMJNLF3Os
 8OjGxqNWWB6hpkuFlhnQfGILXjZAMCZW83Seu7KW6lcpIZuVfhuFosV4hf/0/y8QjAu2/ZEZeHP
 huyzx5EBmBJM5dmvrN+oWKQr8oYawyz8AFr978k7ZBR73o4lN2eryIM4SuxdG/DVlnGCL3VZ1gJ
 BQpxlSDAZirQ3gegUry2CuckmcO7lzyMpvT+LXk9miQ+GHO1mhq3GlTo4s/Ar7usubZJ8Yn8DnY
 S7rCIxv591fUreeYCFiMa4XBnvVC6zKsHT/mQFo296faDg4gtgGDct8MwznOO6yd+uGEVqhFVh8
 47nqU6Hy9r5AnJ+gXpUnAR4wHG/z4DG6/+3VmwWeNhCk+PynvhfggL6p8GZ/nq0PNJoci6RZvVj
 hvRTvIjNbeEfXf0wWCBzvJFIN4go2g==
X-Proofpoint-ORIG-GUID: Xf19WOtFhFZTPIL1ASs180NL75WyILQo
X-Proofpoint-GUID: Xf19WOtFhFZTPIL1ASs180NL75WyILQo
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691f1cfd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=TcJFfKN58SS5vaPbdZwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22

On 11/18/25 7:45 PM, Alistair Francis wrote:
> On Sat, Nov 15, 2025 at 12:14 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 11/13/25 10:44 PM, Alistair Francis wrote:
>>> On Fri, Nov 14, 2025 at 12:37 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> On 11/13/25 9:01 AM, Chuck Lever wrote:
>>>>> On 11/13/25 5:19 AM, Alistair Francis wrote:
>>>>>> On Thu, Nov 13, 2025 at 1:47 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>>>
>>>>>>> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
>>>>>>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>>>>>>
>>>>>>>> Define a `handshake_sk_destruct_req()` function to allow the destruction
>>>>>>>> of the handshake req.
>>>>>>>>
>>>>>>>> This is required to avoid hash conflicts when handshake_req_hash_add()
>>>>>>>> is called as part of submitting the KeyUpdate request.
>>>>>>>>
>>>>>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>>>>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>>>>>> ---
>>>>>>>> v5:
>>>>>>>>  - No change
>>>>>>>> v4:
>>>>>>>>  - No change
>>>>>>>> v3:
>>>>>>>>  - New patch
>>>>>>>>
>>>>>>>>  net/handshake/request.c | 16 ++++++++++++++++
>>>>>>>>  1 file changed, 16 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/net/handshake/request.c b/net/handshake/request.c
>>>>>>>> index 274d2c89b6b2..0d1c91c80478 100644
>>>>>>>> --- a/net/handshake/request.c
>>>>>>>> +++ b/net/handshake/request.c
>>>>>>>> @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
>>>>>>>>               sk_destruct(sk);
>>>>>>>>  }
>>>>>>>>
>>>>>>>> +/**
>>>>>>>> + * handshake_sk_destruct_req - destroy an existing request
>>>>>>>> + * @sk: socket on which there is an existing request
>>>>>>>
>>>>>>> Generally the kdoc style is unnecessary for static helper functions,
>>>>>>> especially functions with only a single caller.
>>>>>>>
>>>>>>> This all looks so much like handshake_sk_destruct(). Consider
>>>>>>> eliminating the code duplication by splitting that function into a
>>>>>>> couple of helpers instead of adding this one.
>>>>>>>
>>>>>>>
>>>>>>>> + */
>>>>>>>> +static void handshake_sk_destruct_req(struct sock *sk)
>>>>>>>
>>>>>>> Because this function is static, I imagine that the compiler will
>>>>>>> bark about the addition of an unused function. Perhaps it would
>>>>>>> be better to combine 2/6 and 3/6.
>>>>>>>
>>>>>>> That would also make it easier for reviewers to check the resource
>>>>>>> accounting issues mentioned below.
>>>>>>>
>>>>>>>
>>>>>>>> +{
>>>>>>>> +     struct handshake_req *req;
>>>>>>>> +
>>>>>>>> +     req = handshake_req_hash_lookup(sk);
>>>>>>>> +     if (!req)
>>>>>>>> +             return;
>>>>>>>> +
>>>>>>>> +     trace_handshake_destruct(sock_net(sk), req, sk);
>>>>>>>
>>>>>>> Wondering if this function needs to preserve the socket's destructor
>>>>>>> callback chain like so:
>>>>>>>
>>>>>>> +       void (sk_destruct)(struct sock sk);
>>>>>>>
>>>>>>>   ...
>>>>>>>
>>>>>>> +       sk_destruct = req->hr_odestruct;
>>>>>>> +       sk->sk_destruct = sk_destruct;
>>>>>>>
>>>>>>> then:
>>>>>>>
>>>>>>>> +     handshake_req_destroy(req);
>>>>>>>
>>>>>>> Because of the current code organization and patch ordering, it's
>>>>>>> difficult to confirm that sock_put() isn't necessary here.
>>>>>>>
>>>>>>>
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  /**
>>>>>>>>   * handshake_req_alloc - Allocate a handshake request
>>>>>>>>   * @proto: security protocol
>>>>>>>
>>>>>>> There's no synchronization preventing concurrent handshake_req_cancel()
>>>>>>> calls from accessing the request after it's freed during handshake
>>>>>>> completion. That is one reason why handshake_complete() leaves completed
>>>>>>> requests in the hash.
>>>>>>
>>>>>> Ah, so you are worried that free-ing the request will race with
>>>>>> accessing the request after a handshake_req_hash_lookup().
>>>>>>
>>>>>> Ok, makes sense. It seems like one answer to that is to add synchronisation
>>>>>>
>>>>>>>
>>>>>>> So I'm thinking that removing requests like this is not going to work
>>>>>>> out. Would it work better if handshake_req_hash_add() could recognize
>>>>>>> that a KeyUpdate is going on, and allow replacement of a hashed
>>>>>>> request? I haven't thought that through.
>>>>>>
>>>>>> I guess the idea would be to do something like this in
>>>>>> handshake_req_hash_add() if the entry already exists?
>>>>>>
>>>>>>     if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
>>>>>>         /* Request already completed */
>>>>>>         rhashtable_replace_fast(...);
>>>>>>     }
>>>>>>
>>>>>> I'm not sure that's better. That could possibly still race with
>>>>>> something that hasn't yet set HANDSHAKE_F_REQ_COMPLETED and overwrite
>>>>>> the request unexpectedly.
>>>>>>
>>>>>> What about adding synchronisation and keeping the current approach?
>>>>>> From a quick look it should be enough to just edit
>>>>>> handshake_sk_destruct() and handshake_req_cancel()
>>>>>
>>>>> Or make the KeyUpdate requests somehow distinctive so they do not
>>>>> collide with initial handshake requests.
>>>
>>> Hmmm... Then each KeyUpdate needs to be distinctive, which will
>>> indefinitely grow the hash table
>>
>> Two random observations:
>>
>> 1. There is only zero or one KeyUpdate going on at a time. Certainly
>> the KeyUpdate-related data structures don't need to stay around.
> 
> That's the same as the original handshake req though, which you are
> saying can't be freed
> 
>>
>> 2. Maybe a separate data structure to track KeyUpdates is appropriate.
>>
>>
>>>> Another thought: expand the current _req structure to also manage
>>>> KeyUpdates. I think there can be only one upcall request pending
>>>> at a time, right?
>>>
>>> There should only be a single request pending per queue.
>>>
>>> I'm not sure I see what we could do to expand the _req structure.
>>>
>>> What about adding `HANDSHAKE_F_REQ_CANCEL` to `hr_flags_bits` and
>>> using that to ensure we don't free something that is currently being
>>> cancelled and the other way around?
>>
>> A CANCEL can happen at any time during the life of the session/socket,
>> including long after the handshake was done. It's part of socket
>> teardown. I don't think we can simply remove the req on handshake
>> completion.
> 
> Does that matter though? If a cancel is issued on a freed req we just
> do nothing as there is nothing to cancel.

I confess I've lost a bit of the plot.

I still don't yet understand why the req has to be removed from the
hash rather than re-using the socket's existing req for KeyUpdates.


-- 
Chuck Lever

