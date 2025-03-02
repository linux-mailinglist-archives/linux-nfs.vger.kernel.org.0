Return-Path: <linux-nfs+bounces-10407-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167EBA4B4FA
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Mar 2025 22:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1525D168606
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Mar 2025 21:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C33A1EDA1B;
	Sun,  2 Mar 2025 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dCRjMYfQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UIqlqE61"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CFB1EDA3E
	for <linux-nfs@vger.kernel.org>; Sun,  2 Mar 2025 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740951656; cv=fail; b=tuqd2/KUIzpXYRK/E6Iiiws1Z/uhVHmQyOT0hLovvrUfrOM/DcYSfVKljdp3razpOaJwPyPq5/5iznnlIl+qjw5zaxjjp3mKhXS9F20Fbzt4/zFwN8vvA08MqtuIqH0T8rDG2Sw2vsVovAcMhIes/GefYkK5joU0JWVqcXoveH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740951656; c=relaxed/simple;
	bh=2N0QYWKTau56+ppq/5DzNbuOGB7cTpq5WnnS7KMneTQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wjg7JidL2yEYJx5Ul2pLjAAl1ZzpKZSANXwtRbtOhmd3Mfla4An5z7Me0CJbVB/OG1e2HFUFhntIb7aD3mRWh3d7yo32E+ZXrgnxaD2bx+lMOlkKT9j8MBgcHOuHSAmj3oAMtdY0RxXuiXG4OYGIZGlbdOgpGNLRKmLmHHaeKbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dCRjMYfQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UIqlqE61; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522LbcoU005725;
	Sun, 2 Mar 2025 21:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Qfe8Bwbv3JhXGsHJmRf9+1/7xbAi+MMw0E6ToXH6CKY=; b=
	dCRjMYfQmnm8JyhvPVPVHu+8fU+xcob8EZDz+MZHe0aSD/0AfsYv9IDI98aEEPmo
	2LyIzpcLVoCE4KEEkWxhy1g+2+BLpRz0VSQaW66s3wwHgjWSdEW4v1sSNRwmBACh
	njX++fu2pwVxzRVJsW3ijp9nnVuXJTFz4MtfnbqzFpWpCik7EQ9+Ko7yhNXZ1PuC
	Sih/w3jawOhL1Tia3RYrkg/0YqD4JWTb5WpI7fVnDRovTrwJWc80lSujoKcKjfwd
	PbA0lw/j7hNiJx1Vu8gFKLMGxiJ+HVA5eX+scY3ABL0VcasUayJdvONQBCOqG3qd
	rLAybA07GiswAYyzWcv2dw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8h9knc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Mar 2025 21:40:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 522JdEmC039698;
	Sun, 2 Mar 2025 21:40:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7fdc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Mar 2025 21:40:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btXl0RHsRIfm479+TOr4g5sE/uxEpiNU/Dw4xPpwavk9/oa9zaw9vM/tiG+MpfBHZU7z8SgJnWaZRm5jAUMl/8a1hTx19rVVf86j9KImy2+WqbxeqbNVjcw5Qbc+ZC9n9FZxnmv7otCZkpu+L5f7QRF/4H1eYHPi97ZnypgSy17SXzjAsV9y1jr4TYmwh1/ZcCCgiAltsTZMpGLMMDeEL7VTVBH4perY2TJsf84qb12yG8Su9gWDmbCbdMr/iK6F30/3eMSdCtyz3qmKKzklkaJhbYVfWMDNA+Q/nf2hOO4xyzkExtkCSSXelouDqS6vWDZ6/gXLctDIBVwN9chfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qfe8Bwbv3JhXGsHJmRf9+1/7xbAi+MMw0E6ToXH6CKY=;
 b=QwNUY6PgOJKFF3Lv37aZGzw8q2dPo5MTy4Da+jIA1UIB+Rs6gxZmhl3Yd5PaqPBt3AHIMYihF8+z4r5MH+YycmbuaC8cECAsMeI7e4vZ4OLR2U6GiX+mcG4XWodZiylK8LaC3+UzGFCnt52LXttWqTlqdDBoxb6+5f9TiHLg50qLShN4aEEote7w1f9BDxpU4naAK17JXAzeGv2Rmak5A+HGQU0Z6caUeWiLENlNIFwft8yLEl7ZAHso4Gxst00A28RlSXJBA7MBwKbT1rsSD5Jd8hQ2aXQ6LYk+QorjsXJ2DZYd/Eek5jx4TSWejizXRjFoDu5NUh6x7GW39qWORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qfe8Bwbv3JhXGsHJmRf9+1/7xbAi+MMw0E6ToXH6CKY=;
 b=UIqlqE61jvv1DqWeetGiT+Q93cJTcMjlICaBEMB3OZ+MSjypkPS5hjhlMIO/tuLiUtTRKHraNI06AAYMgYrfPSK6g6ZvArqa53EI7hrP3bWR8+nJeg9pKP+Bg55Y5+I60xKcX7KQPwBxC10J9wyQQ78KmjCk5aFaiAJCnzKke6Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5196.namprd10.prod.outlook.com (2603:10b6:610:c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Sun, 2 Mar
 2025 21:40:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 21:40:34 +0000
Message-ID: <84ef6425-153a-4924-a7d1-cc3134bc6ffd@oracle.com>
Date: Sun, 2 Mar 2025 16:40:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] NFSD: OFFLOAD_CANCEL should mark an async COPY as
 completed
To: Jeff Layton <jlayton@kernel.org>, cel@kernel.org,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
References: <20250301183151.11362-1-cel@kernel.org>
 <20250301183151.11362-2-cel@kernel.org>
 <d03e64d0fe6e524fde6bfc7c2d1ac8748b5e4ddf.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <d03e64d0fe6e524fde6bfc7c2d1ac8748b5e4ddf.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:610:4c::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 512d9462-ca96-4153-e77b-08dd59d2dd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTNmSFhUSTBPcmNBOGtBWnBJZFBzS3NoZ1ZYUy90MGs4Snp3Rk52YURteng2?=
 =?utf-8?B?RHFmVmZtU3NoQVB4NTJ2azJySWllSnRNOHl3dUhtRnErOW1oSDl3UHdPa3dY?=
 =?utf-8?B?dWx2MjVBdjdheGJaelB5UzFsdEZuc2tORFUxSk03NzdNUGdlaVFTaHpQbWVX?=
 =?utf-8?B?VWZTaWkrcERGZHZrdXVqUWVIbE16aThuQmpnSjRhSzZ5d2owZmhYOTQ0ajN6?=
 =?utf-8?B?akd6Q0wyaUlCdWpJbjUrdVlvYmtEcExKb2J5N1M4ZXFyU3F0Rlg0YVMwdWdB?=
 =?utf-8?B?TkdCcU9pamFkSmxKUWtrMkpkTlhQRjBhVlRyaW93d1VTMFlYM0pleFRodnJz?=
 =?utf-8?B?RWpBOUd0SWhZNXJkakVqQlBHSHNvNE00T3lCRTluSGR3NFZXcWdQSW5sVmNX?=
 =?utf-8?B?YVBacXR1NmhmNFRRUzdpNUZxR2k5cW9TdGp3VFRTeWpJQWFhL3dEQjBLdXZS?=
 =?utf-8?B?KytJSC8zVUdoYm9yREtvOStYY0RWQ1FuQVRqUzVDMEpiUXFpa1hPM2xzdjBX?=
 =?utf-8?B?RFR4TGY0bmJQaHByaDZIOXJ6ZnEyNzRYeks0bmN1Tjl2c2xWNHN6WDNjTTdm?=
 =?utf-8?B?MzJWVk03N2RjRzd0Y24zckZSajNjUjZBbDBDcFZKVkVqaXlKZzlUMFJNZWhp?=
 =?utf-8?B?Sm5RanFaRFg1MWJHZVE1U3NtajhxT2hPdDN0THN3a3lyR0RraG5XMTZOQk1Z?=
 =?utf-8?B?QW04K29HM2ZUeXF6OUdreDlPbzA3MGNRaS9GeGNJRXdLamMyRnVlaTNiczhR?=
 =?utf-8?B?Q012UlYyTlM0ekRmVnR0akdWWWJrS1hOVzJVR2lHdndXc09iVjk0ZjlGQW9O?=
 =?utf-8?B?UXVhNFg1VzFOaEJVRlpaVUQwVmlOTEw2NXpyR21jOG50bmV4Nmg2RmlreGl3?=
 =?utf-8?B?TWh2WlNZb0tab1U4czEwU3JvM1BzYzZmTmN0WXlOOGg2NllRY2xtZUd2Q1Mx?=
 =?utf-8?B?S0hidXFkTk9ZYnlwYmdFbTdheTFObDhRWE9SY1RWcTVMRk5ybHVScFBjVVJE?=
 =?utf-8?B?cTFaY0FDdzNyYVdLNlFWVnBkOGg5Z0JsUUpjQXI1QndQZTBXVE9xWFM3SDVJ?=
 =?utf-8?B?WjhzaFljYkJMazFhRHM0Yk9BRTc2cExyRk9wTy9vaXNnbFFBVXhDNm5BL1ND?=
 =?utf-8?B?K21TVnp0RTBZSWhUTWpqblRkMVdmYTBqY2dJWmtSWmlZbmJmSG44TTNmOFAv?=
 =?utf-8?B?S2hYUnJZR09rdm1VKzRzSHc3QlM1N0x6RUJYKzZLWEVFTjBSVDVBVVROQit4?=
 =?utf-8?B?TldWbURBRk5CdHBoWktuVEw5TEdUelI2OERFM1RMcGJYMnhFTGNHYXpBdFBC?=
 =?utf-8?B?SXRuV3lqbTZNQnUrNnRoeDlYZEMxSHgyOFRYNHFadUxCZmhzQStjMW15OXh5?=
 =?utf-8?B?eXJiek8waG1Idmw0MHZKZ3BpdEg4ZThtZ0tEcG04L1JXemNVQnh3NG5CMVNw?=
 =?utf-8?B?anZrOTU2T1dpSTk1bW4xd3V2UStBelA4V1krTVJJeHk2Z3ZuY3dWWUNPQk05?=
 =?utf-8?B?NzFiK0MyU1Ryc1dlN1JiT0RQKzFmVk04aVNNMy9KSVBTYUYzaWZqVnNWRW0v?=
 =?utf-8?B?d1hnb21nTUtZdEZERHd4Q1ArRHVwSy9xdzFQSGw4aVB3REUveU51OVF6MWlB?=
 =?utf-8?B?S3hWdDFsUWM2TjNlNW5GVFdzTzlablk3VG55Y1RTdFBkanpOSDF0VnZsVVkz?=
 =?utf-8?B?WWZnamFwbFV2Z1lxM1FqUXF1V3gyczhLQTZlUkt6UUp2UXdZY096OUFjV0RN?=
 =?utf-8?B?WUNLUTRQSzU5UFE2M3dvYnFUdHpLYUhnZUpzaUExRzIzQ3VvWGVUK3lGb1dq?=
 =?utf-8?B?NE5odUVhQkUyWHN3OE5jYzd0bTBJWHZyNUFaeFRiSnZwTzhQalNaMlV5YjhX?=
 =?utf-8?Q?8nFzvzN/I49li?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0lrUmxNY3J3M1huL2RtdjNnVVQ5UVl3Q2REVHRjOWdQeCt3bXpkYlAwd0NW?=
 =?utf-8?B?Y2h2Qno3TzFuVU9ScGxER0dwdkNvSmthcExnTXZVTTA2RGpxYXhKV2J6Z2Np?=
 =?utf-8?B?N0F3bjdwS0FaZ0ZDeEdXWjV5ZTd6YXBGVlJ2L01BZ2NEVkduTzJGVHJDOU9z?=
 =?utf-8?B?T2dKZEdaZFlNdk9sY2pjVFphdmZZK2Fibk00cXRZeTRpU094L0EvMjBwa01n?=
 =?utf-8?B?SlRRVHRRbnV6anVseTZFMWdGMjZ3KzVtYzRWSjVVNTg3bXhnUHZTdGVwbC9v?=
 =?utf-8?B?aittSnJlT1VpYzhQLzNud21zZkhWYzVCdTVLY1E5TDVLMzRxbm1ZMDQ5VzlN?=
 =?utf-8?B?WXE0azhIbkU0TlM1a2RHK0FmekpSVTRiTTBDdERQdmFJaGdxb2s2bVRQMks0?=
 =?utf-8?B?cXZwaWpyY3llaHVsY1lBSmRBYy94QzdsZmN3UHRDVW5GSmtDb21qYXpQVklB?=
 =?utf-8?B?eWw3ZlZYTmRYWlhEVjhNM1N4NnlpdmxnSFg3YjhwaHVvNEYwQU9jY1lLaGYz?=
 =?utf-8?B?K2tXeFc4SVhSeTlIQUdnaWhNc05YbHZMN1VUYnRPbE5maDMxNWNwK005enJH?=
 =?utf-8?B?YXpDa2MxcXlQVmQ4Sko5dGFZaElXdUpENit1UXozYW1LYU9yb1VvNStXbWo5?=
 =?utf-8?B?anV4SkpOeGcwcUUrK0pQQ0J2bUxGVWtqTWRFeFVVZEswdHI0U0FrcnBHeEZt?=
 =?utf-8?B?OXBzMXV1b3htbHVVU2JnQUs2LzJrNG5ZSm52RHV6TGN3Vzg0cEh1enZncjJs?=
 =?utf-8?B?Y21XUGhnbzFpTENtdFl6d3VQNWRzVGtpUEtlWEdGSTRJVVg5YXVlV2tXR1o3?=
 =?utf-8?B?TkxvMXpSWTVON25RY003Z3ZwaGFQR2NCem1WTDlhQWNVUm9xTkdNd2kzTjc4?=
 =?utf-8?B?QUkySGx5a1hEeXM5MUpJUWVoUjhudmpEejYrS3lBelBFZDNSYnlrQzU4d0ps?=
 =?utf-8?B?TmRmL0dSb2FkWXFjbW9Xekh6YkY1VjgvOTh0MVE4NDhOQi9oNk1Xalh1dUF6?=
 =?utf-8?B?eWI4VmF5OXBtWDFWTEtOejJFR2RsSWUwekRMbkJFYThqSWd3VklDZmJrTlpa?=
 =?utf-8?B?WGlNcXJzZjVIV2RUQW0yZThjKzZlL3cxUTZEcVVnVmhEaUExc3RQcXZWUWF2?=
 =?utf-8?B?TGplM2xYT2YrWjVUK2hsdCtaV1E5K1lHeFMrU2gwVzNtOUR6QnRGanFQbExl?=
 =?utf-8?B?eXJ2MHpZZmQwWHRJUjNuUXJWMEt5bWFZb3lBTjVQemNrdDYzLzlEeGwxcm5w?=
 =?utf-8?B?ekZFb2VaRmwvRTRPSUszZ1dkZm1kcGxacHhyKzl5bk5mbTlRNDJLMGdtL1ZP?=
 =?utf-8?B?VlBOVUowOGU1OXhENHh3eitNSVYrOXNDUllmWndHQ25FZTRFb1RNMGtmTzMw?=
 =?utf-8?B?emFZbU96OHJpb1RVSENiUVlJUEUyQVN4dmtLdUJFeDEwSEpDcUxxYXdqaEN0?=
 =?utf-8?B?bXJPRHBCaGN5ZEhQN3BvdndtME8ySEtMbzM2S3pZRFZqN2UySEYzakw3Z2xq?=
 =?utf-8?B?amFMeGF6em5GV1hyTlY1VERLa3c3QlFFdUxFblpPNmoxeVU0S1BtQlh4MnY1?=
 =?utf-8?B?ekNvMkZVblI1djh0L3o4V1NkZjh6V1ViSCtJNU1zaDBMa0JhYUpUS01uVHI3?=
 =?utf-8?B?Q3JJb1JYcFVPSDFYRXR2dG9DSnJpNVF6N2t5bWJrck1QaS92MlBRcUd0dkVy?=
 =?utf-8?B?UzNFenRyNEFyTjlyTXBvaElQNGtDUmVHN2NXeVFsekNzNTFacUdJUytIRjVU?=
 =?utf-8?B?Wm1rTi9wcjZVaDIwOCtIdFg0V3Vleng4Q3hqeW5uME5tWnJ6Ym9uZExsQjNI?=
 =?utf-8?B?bnJWbU1zT0VQRGtHSGFMckJOSk5zOFdxcEFQT0Vxc002aHJqVkZBZXF0aTEy?=
 =?utf-8?B?UkdTRkg4cXh1N3FQeGtUWDg4TFVoNVpBQ1U4aDl0QkRZc3I0SGptRVhyQ3Yr?=
 =?utf-8?B?RTNHZGFHOXhNSEc4S21zck5ibkJ4S1I3U3RaNE0rVGZTcU5vUDh6MEV3bE55?=
 =?utf-8?B?S2tHTWhTbEVnRGZNY29qTWM2NEcyV0JOMGFwRXNhQVl5ekdqTCsvR0Q5L2xm?=
 =?utf-8?B?UWt1eXMrLzIyZ1VORjAvN3AvUGxKRmI2SlhmeUptQXZKS1RRV3VSMEFJK2gy?=
 =?utf-8?Q?ZYwMhTc8qvL/l3ci7GUoA5nZb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ddXuc8V1EbsLBgOkCiWzd3iGJbp+0FQNDt8EO7J8IFaMMlABXtJHVvqExfYDY7OvN3uGIgUOnJevAF+OhbcKNog/MhBTbJWTgxOe4BKldevdDbW8VassyZHg16uKJ1uTVlCH+KwBP1p3m4mb2toW+iMU7X4fpJckqN6pFn0Iq660rC1UjMPpbbtKeFlzsVn1r/+Cu9+wPCsziWdj0lFJDNNeDSPTaPz58AmRY3ahmFLgiDa3PxrLvem2DmDdibMmj0KMvch8fWFXqiEvw0vfn3+WrinCSvnoIByDcljeAfU9uWVANt58hrWAJPZQ9RsFb84jqFr+GchY/Pm4qJerYD4/PDcZi858rmppdMdHrGhKgrHgUB1eCz0qZ0B6f33Wh8PqzU52WXeOddOZmdHO/D0rnC6VX7r09MJpzxT9NeYF00Y7tapwEDTbz9yNMYL2hkDFd9DwY43pnNZ+ogDiBeq5iWQMLL9BGaJx1DJ34ZqtlM/AXhMDK73ja5p9X3Qu5Pe7kF6/YJrylQKkSG+UVWlDdXjL0X35BfOoNC7yRmmvpO+od5eXWq0/77FveJiRuZnBRQavh04aOZhJoCWL8wpTqY9d6GpLcqnusFZK54s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512d9462-ca96-4153-e77b-08dd59d2dd17
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 21:40:34.5069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYhSdpO4H/zWoKt3csj1Igu7fHBB6wMpJBvxh3fFnWh2/0RYlJypWmiDpeE0pX0sfbeV0JJURPHeuVUVhHexpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503020176
X-Proofpoint-GUID: IaJu0Qjyf8Ba2HPKfkKASJCDmQR84O11
X-Proofpoint-ORIG-GUID: IaJu0Qjyf8Ba2HPKfkKASJCDmQR84O11

On 3/2/25 4:35 PM, Jeff Layton wrote:
> On Sat, 2025-03-01 at 13:31 -0500, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Update the status of an async COPY operation when it has been
>> stopped. OFFLOAD_STATUS needs to indicate that the COPY is no longer
>> running.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfs4proc.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index f6e06c779d09..9a0e68aa246f 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1379,8 +1379,11 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
>>  static void nfsd4_stop_copy(struct nfsd4_copy *copy)
>>  {
>>  	trace_nfsd_copy_async_cancel(copy);
>> -	if (!test_and_set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags))
>> +	if (!test_and_set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags)) {
>>  		kthread_stop(copy->copy_task);
>> +		copy->nfserr = nfs_ok;
>> +		set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
>> +	}
>>  	nfs4_put_copy(copy);
>>  }
>>  
> 
> STOPPED and COMPLETED seem to basically track each other. What's the
> distinction between the two bits? When is one set, but not the other?

IIRC:

COMPLETED means the background COPY is no longer running. It prevents
kthread_stop() from being called more than once on the same kthread.

STOPPED means that the background COPY is no longer running because
something stopped it before it could finish normally -- more or less
this is like being signaled.

We could name it "ABEND" or something else.

-- 
Chuck Lever

