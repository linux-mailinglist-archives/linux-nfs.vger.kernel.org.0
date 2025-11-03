Return-Path: <linux-nfs+bounces-15950-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8313EC2DBE8
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 19:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB76189A5A2
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 18:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B9D31D75A;
	Mon,  3 Nov 2025 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XkHD/5oT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OyCu1I8t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551FA31D73F
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195864; cv=fail; b=oRL4HY3Tg8iX1GcDgwU9lTl887VrJVr5mBf9303uCgVjX3D0nqHQKWgQvXsWeil22zyhhKrgtDRgJKFNFlR4Kno15YWtWGkSLd53is3jAWVf/KdIFkFdJCXCgA3gT2/orWN0POLanxQn8/Qur+DGK8jHGRiMWvmLdH/zPlnmt7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195864; c=relaxed/simple;
	bh=nM9qzkRKKrR6DiPClmMSdI7W7/bZgKLeQjdZvP362zs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dMuxOCk4WbrVC4ao1qRBTjB5Aa8dk4CFWpQyc9fA0pENSUu9mqa/xMTD78GCbn9mo9MFCEA6GEgt1Li6tS3vcRRUogGsvTM/v9Va5hvQq/HPVdzPIUNemMqKBPPtckyvR/X5jKRe0++KUh3zC2JarMUPODCA8fUW9Q5eIOL5SZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XkHD/5oT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OyCu1I8t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3IWJ5O008852;
	Mon, 3 Nov 2025 18:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=auGgFnYjAz1Qkmz2ahOFlqK0T63aj5aQBFvUgD/rJ1E=; b=
	XkHD/5oTexYH3a2VzVYbhR5aLEw39SPTQRDlT8eEyD367EnMWP+SYazZ5zXiwd66
	DWAbOL2xPy9Zxoh9R7h1L4pBtt1to4znqQiCDZ4oDROIrfBuFjx+ZeV5rK0LSUoF
	96KqJzBfIf1sBLYfHkZTYj23M+jd2Bum7W/x/SzNKRA8ROrnZOALrhc/jszVOEDa
	GgUk/e6utCLZIMzHADDObZyVWzAjDIO0maSPBZsg2mmOz2byfhoWs94dhlVmR6wZ
	8skxK6g2eTNMvP4VTadSeh5pnMvTarbVEuC2nBm2hW2DofAJL+BopV/hWKPm8hPT
	5eHTpGP4IiCp0SU8eSXU9g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a71rj81jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 18:50:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3HcnS8015717;
	Mon, 3 Nov 2025 18:50:52 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n8a9b8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 18:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsmz7I8JvhbstJUGwCU9zOWfh+5Crcy4E0bsGRNp9XaV75+k2k1LJ1eYtYfiMkoJws3NTEtFKasBlyMQ7RYMWS8n0swSIiSaan07+bF8CHVtmNkHkHq6P8eHx/3HKmsnbUCQGNSD0+1dwE1ElykKldR1XFKhza4ah+VjACgiD0GzFxqc0dmed21UdkKhNW7HiCcrjDpEI484kXVqwJtpZK67R5Z1i0uqNdjmBXol/RDyR8cc2D7L905s/pcamem/WPcaONuL3eKDbWsW5ZNT89V+Y5XIq4jaYbdMIt5PmF07R6d3gIrpJu3wUnTmIUpjIjstyTC8nvTnll+I5WA6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auGgFnYjAz1Qkmz2ahOFlqK0T63aj5aQBFvUgD/rJ1E=;
 b=AuWZvDQhVHuxcq2VgG7Ps89aG1+ED7GBcBnhrT7Fk411LrcZAIFYMJS1ICCR6+0cKwTHlFCQ2u5HAiAKdJHjmzL/7hQX0LaQzyAVdeYUQH8w9WknRApr8W//HW7P5VP1kHueaYbngO5cKghpmxiA8sUczhVoQSIDgK0TvX5x5Jx3bEBJr2XKjXHcly+mt+7GmuupsTpCPVIJZvL80/FIIoNsgUXSLEfwNNqphJ5/VC2YRwtcqroO0glSVaFFp1lb27X+DmiOJuUnoAe+zCdoWj6jMPnCTekePxYVdtx8PXdAPy6OSEo782eJD4Yg0IVIa37Wbwmeu8cNV3OX0EjeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auGgFnYjAz1Qkmz2ahOFlqK0T63aj5aQBFvUgD/rJ1E=;
 b=OyCu1I8tRDasUPesKhFmQYpizcuZG91Ewzy4XJm+pN6eafKSYjv0Rh/0oCJASXH7NCrto1wiNN++hnbKKoKEUKTpyX8iWkbpV/Gs2koyM/ZdVHRtAt+ZwrkDni5vAbV0XY34UpI08WR5K+LLmggCHGrsKO+F/0HyFPk2raAKMoI=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH7PR10MB5748.namprd10.prod.outlook.com (2603:10b6:510:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:50:49 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 18:50:49 +0000
Message-ID: <b8489e0f-550c-4c63-8429-fb2d44f24c0e@oracle.com>
Date: Mon, 3 Nov 2025 10:50:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] NFSD: Do not fence the client on
 NFS4ERR_RETRY_UNCACHED_REP error
To: Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        linux-nfs@vger.kernel.org
References: <20251101185220.663905-1-dai.ngo@oracle.com>
 <20251101185220.663905-3-dai.ngo@oracle.com> <20251103114500.GC14852@lst.de>
 <841a3ef8-d5c8-4f87-9244-f79a10c66e3b@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <841a3ef8-d5c8-4f87-9244-f79a10c66e3b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::6) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH7PR10MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: b73f12ee-03ac-4d81-cfbf-08de1b09e7a5
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bVgxY1FqZkpBU21sNzZMTzFWZUVucXI1cWRzaWJDcHpZbDZaejJ5WTRBd1F1?=
 =?utf-8?B?cFUzKzB0UzJIVG8zZE4wUDhkZ0RGZUlCQ04zaG9SeWVLNW10dnRFNDZHZGxu?=
 =?utf-8?B?dHJxVGtMcVNOcjQwL014UWptNmV1ajREVGtTUVhySjlFK1lWd3ZTV0pIYzl6?=
 =?utf-8?B?QWRjMmQvcldyY2NlUjJ2MUF1VUxlZHpPSUYzNTI4aEtUQUxHbzRlUktwOTZH?=
 =?utf-8?B?TlM2Y2lPWEVNUEJISEFsamxLUnZRRHdseVlhMENXNUJwNlB2QlBvc1A0R2lz?=
 =?utf-8?B?MUJ6UDJWQlhSVVNZM1VROVl0ZVU2SG5VdHVrbUYrRG8vYVpwVDZZUXBRVktn?=
 =?utf-8?B?b1c1V2lMcCtlVUJXbkgvajAvWUtZMVEwZGpvOTU5a2llWXZod2JWa2J5NmpX?=
 =?utf-8?B?VnBuajJGTGcwMERKelAyaWxGY1RYRmJLYjAvK1E3RWk5dVpNMWhleUtIR2Jp?=
 =?utf-8?B?cmpYQkhTT2t3OUpNQmFEZGFsRk5vNGRqTUwyUnVxeDVyanZvb3JBZUpZcFdX?=
 =?utf-8?B?eTZydXhYN1g4MEtIQTFIQjNTd1FkMmJWaWQzbmxnMGswbitua0ZXdTFQTDZU?=
 =?utf-8?B?ZEd5VWRIUDNmNStRYzFmMXIwYjVpZkE2VnVlQ0ZqZUd5aGE2VWRwS3lVNzEr?=
 =?utf-8?B?WWc5SGY1Uy9lbHhzRWhGNm9pK2xYNVVPMnBUMURsL3VGWnVVek5LNTRWSkUx?=
 =?utf-8?B?Z3JYbXk2am5MYnkvS2QyclBUNmthdHlFMGFnSWVOV0JVZDZ3RTZxNy9sZWxh?=
 =?utf-8?B?eEhaRkw2b3BzdkkvOHViNUxkZEhQVCtaUGJaK1FBa1ZGS2NYYkMyTHBDNGh2?=
 =?utf-8?B?UXl2RmN6dEl1V0pCS2RYWDVpZ0JjWWRxRlcwMGJXNExrQlc2Q2RtbFhERkZ1?=
 =?utf-8?B?TUQ1eERsam9ZdlFpUkxiQS9qdXBwdWlFaEdqTHhJZ3VQSHhFWXBWbjZHbmRl?=
 =?utf-8?B?T3Y2Y1MzelVLUThCd2ZKcWw4NE4rVmxvRGtsM0Ztb2tNTjNiejVpTGx1L0dE?=
 =?utf-8?B?dHB4NTc1ZGl3OUdhV215NVdVUTBzc1pJTGxWS2p4d3g1bXRXdkpSRjh1VDNY?=
 =?utf-8?B?YzZqNnlabjNoNzBRVStsWU5zUTBNTW9BOGZ0S2hOK2NWUGZZQWhHV3RCeTR1?=
 =?utf-8?B?SitWaExOd3AyUnd0MlFxbm1SNWtKVTZGQisydmxBMWxZQml1NGdDWFFZbncy?=
 =?utf-8?B?eHdOZ0lMZ3dSWFoyYXUrZU1Ob3JCNnBuUjVZak9EaTBaT0FQeWlwWG83N2FI?=
 =?utf-8?B?c1NYZ2NjWnZoaktjN1NxWkdwOGFDVEc1VVdCVk8wZktkUXhTWGxrZU9sMmxv?=
 =?utf-8?B?Ym9peHp0N3JUSlA4UDFYOW9uNFUvMHlKeEh3VXRNT3d2UW9IS2ZzcmExSUFs?=
 =?utf-8?B?ZWJ0Q0JxUDR4Y1pna0ZFdjBydG5KVHRrUU91aUhxeUdjaWlNS1BVbVRQMjJN?=
 =?utf-8?B?clI5Z2doVEkxQVYyTVE1eWorZUJUZEsxeFZBb21US0FseUErcmY5dFNpbnlw?=
 =?utf-8?B?bzRoQnZzMytlQlFJNGluRVYwY3h4cnlsM2l6bGN5cmRwSVE2QjkzRHRVVVRB?=
 =?utf-8?B?UkUvajlsallQTS94N01XbnU2U3pYN3U0dGMzRTlUdmx3Y0J1VlNzdzRIYkZD?=
 =?utf-8?B?Vmg2QTl0dUMvcDA4SGdLc05PRktueFg4bmluRVVIN2tuMHZNc2JxM09pZTVX?=
 =?utf-8?B?TUVLYmdVUnFQaU9DdEpPSWo4R3F3NGpNZGJCMTlMUVdtMnlQWFRndEw0dXYy?=
 =?utf-8?B?Zm03dXltTlAwM21uQUt2NEM2WlVIaDZuNHorRFRLNFFtSS9CaTVaUTZkc0dH?=
 =?utf-8?B?V1dLOXlGZE5UWERkWDJsQkwzc2dmMGtCb2UxSzhtMjRDVlRNRVVQbGl5cTUy?=
 =?utf-8?B?Zmk2QmlyeGc4VjBWQ3J5OGRXRGNwckxaYzlsckI0b21TZ0R5UGdGT21oSlQx?=
 =?utf-8?Q?MDLRRBJ2iuV+GNLTc1TDN345RFI+7z/g?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K0FodStxMEF6SXVWaVd1MzJOQmxlSkZZMFBpeVlZczhiR3ZsNTdxQUxWS2wr?=
 =?utf-8?B?QXNkV3p6Z0tlZ2s4MTlqQkh4STIwUnpKYWozSk42a3pzeFBSZGNKOE1CekZT?=
 =?utf-8?B?WHZZUVFjNytYT3ByY2xEenlTaVlLMW04bmpsN25PcElka0luVk5td3oxcjF5?=
 =?utf-8?B?eHVKOExYdDJzVmc0Rk1PODR0ejVhV2pQUmtGK3Q5SHgwdmlkd2NpNGpuUE9W?=
 =?utf-8?B?Y1puTTZxQWRiQ093cmFIZ1ZxWUNyYlYycitkS0Z5VTV4bCtSR1pQZ0hSaE1y?=
 =?utf-8?B?NE1BU2I1MkJWcXB2NkxwOUNUMlVyRDlISkRJRTBCQUxGdlpLSFRzV2s0cHlK?=
 =?utf-8?B?M2cxcGdiQWY5dU9RcUt3cGRPUmw1clR0b05aQjBKTnp5Qmw3R3g1dmxVaVpP?=
 =?utf-8?B?eFcxbkVBK1pCMWJmeSs2VTY4YVlEcnVhNWhCQkVBMGtWTCtMcjVSV2hFdHJj?=
 =?utf-8?B?bnBBK0RYZmpNUGJLVzZYczYxZ1k3QjBqRHdUVzlTcnlycjlTVVJVd2JYZnZJ?=
 =?utf-8?B?RVNWSnZpS1dJa1lHYWRwRlNEcC9ZQ0o5cTJhUE9STG52ZXN2ak12Y2FIQTdF?=
 =?utf-8?B?QldXNFJ0ZEhoajBZV0RtRWhvbnFFRThTVnVFd01kRUV5N2pjUmd1VW9wTVQ0?=
 =?utf-8?B?L3RvK0dQN1FyaG9lYjV5c0lRV0VjM2hYUTVWSkpNLzJTYmx6TzhpdzZuMGtw?=
 =?utf-8?B?S0hXT2RMRHphaUtybXNmZUtXZVljVWZVdmlKcHhRaVpYckMraGovdDBxME9B?=
 =?utf-8?B?bFpoT3ZDdVZNWFE0d1l4TkJ5Wm5UZzJmbVFZc1dPVTdqZXVqZmRETUgzaUE4?=
 =?utf-8?B?V0w5cjlHei84SEpZQllVSnRQOUlySU5DNnoxK3JYeFh4azBwQVhlaTJaek9V?=
 =?utf-8?B?NGhiUk1ZY09JSEFCZG5xemMwMlJENEhLTjFKaUZZd2h3UW1mRzE3dVpheHRR?=
 =?utf-8?B?TkEyVGdnMmRzQi8zWnNWbVkzRUNpOEs3SmgxdWhjTkEyRjJvdVVRVWkzQUJ3?=
 =?utf-8?B?eVJVbXBUeTFPd0JHVXkyaWljUFU2ajJ5alRYWEloRzl0R3hFdlN3MEx2Y3F6?=
 =?utf-8?B?VExnR2UxdjdKOEM3T2sxeGhxRis1a24vSDNOUHdhcE40VVNuVEZqT0tVWVRV?=
 =?utf-8?B?WjNvZytRaUV5ZnZRZWxGTEl6Qkt5Um1wU0tJaGhMSW14RHdJdTUxRFBaZWN3?=
 =?utf-8?B?WkYwMnBXSGNLcDkySDNsenZwOE1UUnJoMjFydzZxa1ppN082bTFEaEpRczkr?=
 =?utf-8?B?OE1jVUFWbmlMMGhWSUxiTDJ4WWZTUzA3YkczbEJ5RkZzbWdTSHZqdG5RcXpu?=
 =?utf-8?B?UnY5REtFb1pwUmM1akU3Rk1VUXNXelJkNHRkZ1lHWEg2eDFUb3U2cmVITThi?=
 =?utf-8?B?bnZOaUQxVWROeDlobzFTbUJwQ3NEak1kUWtlLzZvU055ZlBlWHJ1T0EwdUVT?=
 =?utf-8?B?QlRoQzNndjQ4VXNxVDFINHk4V2lFc3ZlV2gzcGloSUlkRC9lc3V1ZTViMTRO?=
 =?utf-8?B?SHlPeUtxY1BJWU1KTjNFdHF6OFFOMlFGZ0VuZ1ViVmZISXVYQVZIM1BNQ2x5?=
 =?utf-8?B?WkFDS1U4S2poN05XMUJlc0lZUzhlcldnQWFHSEZJQlNZMXlkeG51ZUlSR1g5?=
 =?utf-8?B?R0kra0dMVUUrVThXbU9tVTVFblFHVGJsRnBmazQ4L2ZXZ3dDS1FiSXFJTnpX?=
 =?utf-8?B?Tmh1SDJCVGhRNWMzNFBhWktIeHBiR2F6cTdHeFRBYjZVQyswWE1tdGJCN0ZH?=
 =?utf-8?B?T0VJdGpYMTdJS3I2aDlBVkVyUGRGRTRkU3NCdXZNYktPbVRTUFo2bmVqS3JG?=
 =?utf-8?B?SEhkYkViNnFrWXBwS08rTHFNTU1GbW1pSFlSdXlCdU1CdFZzbnRJM05HK1JW?=
 =?utf-8?B?SnNFN2wzbmRXdmthYVB2bW9VbzgvZHZCVTZiMXB0MG5EM3JlTVVYUnc3K2p4?=
 =?utf-8?B?Skdsb0EwTDRacUhEZGhRSWtTRXliUDhpV1NLSlNlbkhSbmpZUmFzOUo3RWY4?=
 =?utf-8?B?dGFRWXE5MklxdnRybEprRFVGVXNUMW5namd0THFyNHhZZGdpMWt4bmxCTzFG?=
 =?utf-8?B?RHZhMDF2SkxTQUlZdEdHZFI0d1JxQUJEbVVmMk91N2JMOUU5QnFkVnJhSkRa?=
 =?utf-8?Q?/ZKIDD4fMH2dXPjf7bzgk+cec?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S6GfqyXPqPxROcM2a735lr9f3gUC9+AS2dEUsXjHPuoLRY4bNHsn70dDckvgIQIwuc64qDJelQDWm+Es0SQGwInNwyIuIAe0wZz406T3NHvu48dIPmxT0KaaDdn6gpuvqvkFhQLh1zB0/xuT1vZUcY8ec88EuGSoBDZc/rKdCiVVbd30ucuTa2g8GQYhwZ8vQMCRfipd27d4jBN7uXarh+Y50Aj91LZ1bncuNFb5i9KZUokQozlOD+g4iYzady3BqbfG8UA4n/LV7k39RLsyA69p8feYNfke6og9RjC2Cb9idhwuZ4hVrsPq6c7TA0jUN2tvZfrXbAiB8ZWelK7rR84wYGDz51gXmS08mvFQFLLJc4wqx/ld85Q13LySsq+oWC1nKAQv66zK02WMo0NXnhaCHVlakcq1WeVBynrMFuvwT9q6m7KvODYs5QLcRdACkiXOJFs3hbErCiAVDfcVbzQqqPEO59f0Bw3qXS6xc3rUGBxaeJGfxb3hwsY/biBmimo58YbmoXdh9DxPcPSKeXx/2pO0qxeXwcwa1Ahpa3DNHhuOLVSUUMOT4wMxWwWpsie3odWqeytfQku1DTtOFNjE7+DDV5NLA5cLWHpnBSA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73f12ee-03ac-4d81-cfbf-08de1b09e7a5
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:50:49.0206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqNXvjKGZayEkXYqcuWM050W7pQB1iXNRVeF7RnHK0nUJwgDbKZ49nQVdcfDyfyX8+HbmdS4+GZkJ6R/xb4fkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5748
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030168
X-Proofpoint-ORIG-GUID: 2GYp87xfsqTU8W5JmSpP5BZ0t2oub33K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE2NiBTYWx0ZWRfXxKyT+yK9MTcW
 69zmsXyMNSoYjwVHsXRXOT6cqfQb0+0qLXdrnA8K7qMVu58/gpks8HeOpoWqXjkKKid9/OK1kJu
 V1XsTYmHzSRjLPlJcZObTxQsY8vGxfWcv4wNrJ1lZBy5JRLG4T5/9CwR52CV8aNbUReZYGNgihk
 mYTbhNqaNp/BMVUG24D+QsD0kAAN6jdyeHWPUAPtMfi1JaB3jRCv+i5/fasEnl4CD9xoY0vfNj0
 Jx6x52ARrOkDlSBMcWqaT5lE4kBXf64mFvGbtr9ZcsOT4Gi28ZBk0ALG8kseiGn4oWWrCdUzkIE
 80oP9kic/vwPTGBR+l6d6ZT6e6z69uke/rWi36kznsUyiu5RvLbewuJXOhQotHUfwqdw+R7OZd5
 8Jm88MSGPeRs+mgVPyBTCo+7FBBhQg==
X-Authority-Analysis: v=2.4 cv=frXRpV4f c=1 sm=1 tr=0 ts=6908f98d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zfLrO1pFhAl8iZ6LkMwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2GYp87xfsqTU8W5JmSpP5BZ0t2oub33K


On 11/3/25 6:16 AM, Chuck Lever wrote:
> On 11/3/25 6:45 AM, Christoph Hellwig wrote:
>> On Sat, Nov 01, 2025 at 11:51:34AM -0700, Dai Ngo wrote:
>>> NFS4ERR_RETRY_UNCACHED_REP error means client has seen and replied
>>> to the layout recall, no fencing is needed.
>> RFC 5661 specifies that error as:
>>
>>    The requester has attempted a retry of a Compound that it previously
>>    requested not be placed in the reply cache.
>>
>> which to me doesn't imply a positive action here.
> Agreed, this status code seems like a loss of synchronization of session
> state between the client and server, or an implementation bug. Ie, it
> seems to mean that at the very least, session re-negotiation is needed,
> at first blush. Should the server mark a callback channel FAULT, for
> instance?
>
>
>> But I'm not an
>> expert at reply cache semantics, so I'll leave others to correct me.
>> But please add a more detailed comment and commit log as this is
>> completely unintuitive.
> The session state and the state of the layout are at two different
> and separate layers. Connect the dots to show that not fencing is
> the correct action and will result in recovery of full backchannel
> operation while maintaining the integrity of the file's content.
>
> So IMHO reviewers need this patch description to provide:
>
> - How this came up during your testing (and maybe a small reproducer)
>
> - An explanation of why leaving the client unfenced is appropriate
>
> - A discussion of what will happen when the server subsequently sends
>    another operation on this session slot

Here is the sequence of events that leads to NFS4ERR_RETRY_UNCACHED_REP:

1. Server sends CB_LAYOUTRECALL with stateID seqid 2
2. Client replies NFS4ERR_NOMATCHING_LAYOUT
3. Server does not receive the reply due to hard hang - no server thread
    available to service the reply (I will post a fix for this problem)
4. Server RPC times out waiting for the reply, nfsd4_cb_sequence_done
    is called with cb_seq_status == 1, nfsd4_mark_cb_fault is called
    and the request is re-queued.
5. Client receives the same CB_LAYOUTRECALL with stateID seqid 2
    again and this time client replies with NFS4ERR_RETRY_UNCACHED_REP.

This process repeats forever from step 4.

In this scenario, the server does not have a chance to service the reply
therefor nfsd4_cb_layout_done was not called so no fencing happens. However,
if somehow a server thread becomes available and nfsd4_cb_layout_done is
called with NFS4ERR_RETRY_UNCACHED_REP error then the client is fenced.
This stops the client from accessing the SCSI target for all layouts which
I think it's a bit harsh and unnecessary.

This problem can be easily reproduced by running the git test.

-Dai



