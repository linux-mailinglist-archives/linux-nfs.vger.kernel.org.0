Return-Path: <linux-nfs+bounces-15044-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94253BC51F0
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 15:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 198E24EA5F8
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 13:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C2D1F3BA4;
	Wed,  8 Oct 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E4vZZzbG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uL0f282n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B024501E
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928706; cv=fail; b=W9Cb1Yjx29CJcnlNIoMA8qcx9k0hbqYPpJsDyZzpnJpxMjWRmiS+v3FEcK3iqpgcEeYyGfBqYhp5ciFmjFm7BXnngytJOXp3geaZQCV9zaw3y0LEkx2r/FuFT3E7KaY/o9YEMbsFfPb0VgEXk/qYJu+auEzI3LFgkLA8RQtWjdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928706; c=relaxed/simple;
	bh=WN5hx5Sd9SQa2ED7QnF9aOvmB0iwLSUUh31Mz9tctoM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t7EmOQX+bECXy4rvZJ+7sFKpShiaMzSlf5ZxGhGFfK2EKWc449J72SbhA+E8rhT1107/rA9y6ymxuo4Q/TYQmJNO5BLAcI6LMctr2WczuuLXyCDwChrWRjmCqms5GKubxiVVa0su/xKt5KhqhfcgMCfTm8z5OGy+Ekk/a1Y922A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E4vZZzbG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uL0f282n; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598CN2kY027603;
	Wed, 8 Oct 2025 13:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EeI1xfbzx2YDSuDt3o3QFHiwkCeQvOkCXM7CXfSO7Z0=; b=
	E4vZZzbGe9zqY6XYxth5M+213ju2x3QJWTmPd+/h1+yq4+J8lKfYYhFdkRusWy/s
	M+PTXDqiVbVdLlcBr/0mn14zmzqQrfG40Bv15v1WHRJfE2ymZER37l+dm+Tw7BK/
	UCAFVEfRtH9NiMbL0KbCmzH4u+1j1JV6CUOgC8G1DBgC1R1E8iP45a32w06W+yTR
	9mYkfjWuFUr7iXAp25Qwo2q1Jqq8iK5udRrjzI1CsN+N7/9FDgYPUKy2jyWUiUMn
	4727utnKyNAtR9mjDuQB5thGBhEJzkuwfRhuw0I21L/zu0EHfK9wx6qCD2w9xOSs
	KE6Kg2uE1u2GpyMsyR97GQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nmg60e63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 13:04:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598BlrpG004087;
	Wed, 8 Oct 2025 13:04:51 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49nqd9jrnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 13:04:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rK3rp+F7nvXwGlMUMZP5ZRJH7VcbsKGSVnVd1IaZdmo34080AbO7tQLIzOVvA5GEXvnCjex96FFovAXZieD8CFRYeUKn/ZxueNtVrY766w3qnRwEwg+6dS24T/G+O04rSfll/Ehi8g6OzGh+PWbDYDnOYEf0Vqz/rDzfWSaqyhO+qApWLe0SblNiZrJP6Ds4LGTzJvVlsaPgpgLS4IWFk3tAku+lh+4KvJEm3IkcjyN6T2eHCdvHiRDweaBovvigdARfBDeZSTFRk2C4/nVNntUTIE//CWkAr6/mFPJ7KjROUWlvdvTMAt0zT8pjI//X4ue0D8OhER1farHUJneTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeI1xfbzx2YDSuDt3o3QFHiwkCeQvOkCXM7CXfSO7Z0=;
 b=JLd3qdM3IqIFmNatntHWd9DJTU0ZUeVy5v1TcJEr5nD8jMjT9u1hBa8U74EXLe6aGBvSN+mQ4H3G0EC1Sv75gFpqwMFzLq9quMHHrb7BcQe3dqjIfpLROcXx4DU1n1swoe+GFMLDX+sYySOUcANqcFnGE/1A7xl2WC4z/a3oMjrugAu4CoNhTfYrNUSDCCQWiU7V6vzFjuN2nLyj98ZnTatlVfE6VmGedVP6OGG2+rNrgmS4azbQccZ1+37ZpBhpIzh1J7joeGUif2jLzsEeUKxqmBMI1m9JeE6gSKHmXj1lM9VYtkMMZTQpbB0nDHWL+K5y6d+zlaULPpruqxLyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeI1xfbzx2YDSuDt3o3QFHiwkCeQvOkCXM7CXfSO7Z0=;
 b=uL0f282nwha7XKOZXP5XSZPAAnufUHBh0MuF6Can0h76BhJl/n8NMzfaPFXOKsfTSz/JDbV1P7aMLEQxW75AXTiFIrC6SQrCBs/bbScCK/Y4LsP0aSIPdE6hFWUyVo5QIlThsB8CoeXlaoS/+xS5/lghqs/Pb5uPCv7B41VMPYc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8370.namprd10.prod.outlook.com (2603:10b6:208:583::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 8 Oct
 2025 13:04:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 13:04:44 +0000
Message-ID: <711bd35a-78b3-4309-9cb7-9e2c7a83a87e@oracle.com>
Date: Wed, 8 Oct 2025 09:04:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] NFSD: Do not cache solo SEQUENCE operations
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251007160413.4953-1-cel@kernel.org>
 <20251007160413.4953-4-cel@kernel.org>
 <98277504-3d4b-4aff-9810-1847e6bf4030@oracle.com>
 <175987517335.1793333.17851849438303159693@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <175987517335.1793333.17851849438303159693@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0025.namprd22.prod.outlook.com
 (2603:10b6:208:238::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7929ca-c1bd-443c-d4bd-08de066b4049
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NVNGNzJna0JXUFhxYVNvYzIvZThHVU45TWFqZ3BzeDQxSVN5SkhFcjBjOE9u?=
 =?utf-8?B?K3dTQ0lzQ3doY2dUSVRRRlZKTDZnZk5PRDdZYjVjZndkUVIrWjU4WmFjM3R2?=
 =?utf-8?B?VnZCR0FEYzJnRlI2Z2d0WmlJYjBCcVVjV3N1QUhDazZIL1hrckZqa2FyNzF4?=
 =?utf-8?B?VWJFRU5vZnMybjZiU29WaUNvV01UR3NUa3RtRzhkK3R6UnIxVVJxWXpyOWk0?=
 =?utf-8?B?SW4rdTkranVjNE5JS1RVTXZGenBUc2RZQmU2ZTk1SUxmd3JoeWR6cEFrUlBJ?=
 =?utf-8?B?UElCNzFVRVhhOG9UV0I4V3lSQ1BiVnowbXphYThLTVpvKzhUMVZ4NGcwZHRz?=
 =?utf-8?B?QStrRWhNNWlYZFRZL29FMW9TcU1VYVNhcXU5KzFwUWNIUHZEVUc4V1QrdWQv?=
 =?utf-8?B?dXRVbWhBaE1VMXZKWTJwRkcwMDRqaGNUMk1pTzYrcy85VWtMZHFnQUlYNUN6?=
 =?utf-8?B?U1Y5NWxZNUFFQ2xiZFA1NnllSndwVlFPdCt5Zk1TaEp5bExCYzBYcVh0a21P?=
 =?utf-8?B?T09ydTRseEpSL0w2VW5kajMxcnBwT3UzK210RWxJdWhOM3U5V3ZQRGJsMzh3?=
 =?utf-8?B?SFJZZ1BiSXJmdHlOOFY5MXhCWThnSGdzMHhSWVM2T3lVMHF1RHQ0WFRhQTJF?=
 =?utf-8?B?bU1LK3NNZkVJeHM0dE5PY1lHQmpmVEJOMlVzRjZtQlQxMjZ5Y3hZcS9xeStZ?=
 =?utf-8?B?dndvRlVGbFdHVlNXQVRhcEZ2VFBjTWxLOHhhU2dNYUZKejJzS3hha0VDeGt5?=
 =?utf-8?B?VENDMFQwWExZK0h0QWVnSzRIK1BoM2Jic09XczdDQlI0RGtFNWdkTTlwT0dj?=
 =?utf-8?B?eE13b2dSQ1VDNkZBTWVIWEgyZWNiSy9aTkV2bXd5bU95elljS2FsamczR1dT?=
 =?utf-8?B?OTVCTVF1Q092KzB3VUw5VGdlNUs0NWxJSm5DK3RZY0IyWUJDSUhXZ2ZpUEJh?=
 =?utf-8?B?cWovdnJNc2svQTVTbkViSDYvNTFtYVhmdWhXck1sdFE2Q2NMSlJzQmNTZm43?=
 =?utf-8?B?b3Fvc1hZa3l2MFZGZmxWZk1NYXUvTFJ5UDJHUW1nWi9OZ2cyemFBeURiS3k3?=
 =?utf-8?B?Q0FkQ2Q3Rm11TExlNFJtcHMwcVJ5K2xsVytEUE5zTmRIanFwOVd0MVBmN3JV?=
 =?utf-8?B?Z0pRSTBDNXk2RmE3MEFQR1UxSlA0blBKcmNhYlhnRFgyazVPT3QzRUJJVFdL?=
 =?utf-8?B?Q01CYStNVi9iTGYwM3VtMnN0NEg5MTRMWDA4WWlOdXExcWtBVXhHSUczcHVF?=
 =?utf-8?B?UFdQeWNIYUFyLzk1V2hmeElWRDU2RC9TWlN2OEJZcUU4ZzBVUzQ4Q2E1ZHdm?=
 =?utf-8?B?NjF4NjBNT25ZR2t4aGM5eDVSUW42QlNob01SbnZEV3ZsT3FaRFI2ZzRoSjNl?=
 =?utf-8?B?Y3FKcnJ0Zmw0RHBYakpKUktpTGQ1ZVlnRlJIdG5PNVlkSjVlMUJ0VEVJUkNa?=
 =?utf-8?B?NmJCblJKT0F2emNCcUlsQzJHcjA0Rm96eGFRQTVhWVVjV2dRUkFJbjMvd1ZB?=
 =?utf-8?B?V1BMVXR5OHRXQ0NBOEcxT2p3YWRUV1pTL2VrVk14bXlCek03eEMrcEx5OG9u?=
 =?utf-8?B?dVoySWZEYWdqcTdQR3BsVzcyTyt6MmFuNTZPUWRqVjQ2TG1sL2ZQMjRuWkVR?=
 =?utf-8?B?RnBqOVNLNXhhQUZESTZIQVlReHV1UmxHalJ5QWZBdTJCR2VpazZiK29vQVk2?=
 =?utf-8?B?TFdqUFYzTG9TM3ZzSDJXK05Bc1pZMEh6aCtRYnRJcXNKcExTS3ZJUHNuK0xM?=
 =?utf-8?B?amNpeVJnOEd2NUdYM0NocXFwbXNaakllR3lMSWt4VDlVNTFmSlRGR1BYdVp2?=
 =?utf-8?B?OWQzUDRmM3RhanhvSkxaK2tQU1ZnUmdsZE5NdUJEcjNVL29kMnlQNHEvRkFm?=
 =?utf-8?B?RDAydkdtQmg4WGkweTVGYmdGcWtUNks0K2liUHIvTi9nRytHSjg2YmVoTm5I?=
 =?utf-8?Q?fxgr5BxrbNN+21H6zNJvNWOlC00IMyaD?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OEYzZ3VhRmNPT2tkY1MvNFJNNEdqZ1k3c1I1T2xyOFpKak1TQ0x1YURybHdx?=
 =?utf-8?B?dGVzTkhjblVXdUN2ZlFQS2lKU1RqTTFFam1FUHpwMVhzMDV0VXpRMVgvYUs3?=
 =?utf-8?B?QnJXaWRzMFdZMmRFaEJBNTFiV2xTcTNqYmpaTDRIRk4xYk1XaGJhbWR3eEdh?=
 =?utf-8?B?cHVUSkg4bW1FdjJHRFhCVjBjWms2Qi9OeE5lZnBHWTNFcTZ6OTVSeCtybU1I?=
 =?utf-8?B?bmRFMmF5ejhGNWlCVm1CQVJ1OUV1WjcxZExUV3haek5PMlJSNFBuNFh2Z0V5?=
 =?utf-8?B?QW9MT09QZzQycXc2QnQvS2U4ck9CTWRyOTJMQjZENlFac1V2djdpS0drVlRV?=
 =?utf-8?B?V0MveWZwSDZLa3UvTjV2SjZqWDlQcGQ0VmV0L1pVY004eTV4MUExUFJpS08y?=
 =?utf-8?B?clBrbGNSajJsZU9XQ3FzUmVmai9NZFZjYTRvS1R2WUhnK3ZsT3VNaDZkT0Z0?=
 =?utf-8?B?STdBckZKd3BjZWF6TUtFRXUrUWNkdWVEYWcxenQ1Um8wdFkxM2tjYTlVU0pp?=
 =?utf-8?B?NjFoZzBxdmhHSlk0LzZpZURlMXRDNVloY01KU2Mya1I0bjRNUDZ4VVM5MFox?=
 =?utf-8?B?K3BWQlJmVHpQV1BtaVBuUm0ycE9wZ2U4QnJFa2EyNlViaVdLQ1VlcE9wMlBD?=
 =?utf-8?B?R2l0VEFaWmRhdEVkbHh5ZlVsbHhSUnB2ZHRhTzlPVXo2QlVnK3dvVXU3cUVs?=
 =?utf-8?B?SEhIQlY1WHNYZ0theWliOWRwU0F5cFBnQ0dGUXdKM2pqTTk3OUFYRXhXUkhX?=
 =?utf-8?B?VURvdkhPLzIzNW56MVdDYWM1Wm1uOCttREkwYitLdjJOeS9wNEJqbWsvNVhH?=
 =?utf-8?B?d1VPamZ0OWZnMGxueVRyOE9GcFJyS3lYRzU5clY5ZzAycXczbU5KSnJvSkIw?=
 =?utf-8?B?Q0Q0QThuamFubXA5cnZrMGowZVZHdldGNUNWbytNVi9YZGNjQVkvQWI1c3I5?=
 =?utf-8?B?aTVFM1B5QjlQWGw3elRRazlyLzZ1emVwV2NqSTNRVFNLY3NJMUdxcHZNeG12?=
 =?utf-8?B?aWpoSHZhMmxKblhuZjhxeEtDUFZoa2VrNTNJOU9vQ3pHYnVXRDVURkh3Wlp0?=
 =?utf-8?B?cnNxZUwzOGVpRUxoQm9wcVRuQ0FFZU5ob3hhckgxN01aVTQxSFEvRG12R2Vh?=
 =?utf-8?B?ZXVRWVBjKzRJMUJsZlQ3UFhNZVQwN0s4ZXpZTUEwYnJHTytaQWkrOTF1aWUw?=
 =?utf-8?B?NDdyWEpHUm1pMHozanlHbmZIdzhvcXdsYUQ4OHdlVlgyT0NWaHZHbUhmTWxP?=
 =?utf-8?B?S0FHZkZOSDNDVnViZjlaamkxT1ZZNEY2RG9sNlhlNlcyNGVET0xLRVJ5YU95?=
 =?utf-8?B?TldBRlJUMEMyZlhhS0YrS2RPMG1YblZUSXhFZHA1eXEwcVE5cnNGREdhZUJV?=
 =?utf-8?B?Q3M0OGN2V3BMNlgvNVBrMk5aRURrYy9wSGJVbjNwMzRWZmlRZElBdDh6SGZN?=
 =?utf-8?B?OFpaY2JXTHJLY1hLTUZTYWFKV3NMaVloZHpYUlkwdFllWUo4VU9BRjJMTkc1?=
 =?utf-8?B?U1NLSE85Y3I5V0NGMUdpN3I1TFM2Wmgwc25tTGN0NkxaemNFOEJpRUlFVmVK?=
 =?utf-8?B?Z1ZoL1owS3p5dDZCa0V4bFpneG1KQzFjTmdHd3JCSU5tSGEvckM5MStjTkFY?=
 =?utf-8?B?K3N1YjRUMDFGQlN2RElRNCtDMXhKZGZLUUx0UU0wM01USURBUHRiMXpITTND?=
 =?utf-8?B?bnZIalVrb2trTTR3UjNxcUJBUWlPQStCYVExcmJMZnFDOU1jcVViTUM5bytL?=
 =?utf-8?B?ZCtsOHBqUmNDY1NmSitGWGpvSHRwZllMRG52SVFzdXJEMlNERTM2Q1dvdU9M?=
 =?utf-8?B?R2tUWVhFUVdtdEx2Si96SFhTU3dSUkVkVStzVzhrR2Z3VWp3aHVkNitJeURX?=
 =?utf-8?B?M0w3c212Sjc4QXVwek8yTlVtWDhKNm95VlhCTWpZUlRseFltTzlSNktLeWVo?=
 =?utf-8?B?cDUxRHRISVB3YytGMDJuYjduMnUwUGJvdExvbk8rUmlFMmRaOVFhanlSeFdQ?=
 =?utf-8?B?WXExMGNWVGhQbnMxUU9rU2Q2YUxjbngwaVA0NW5mVUFXU05rczBOOURmN3RU?=
 =?utf-8?B?NjRwZHRZUkRsbjIwendNOWVSWkpEcWtIUmpwWmg0aGYxb2NIL2luamY1RDlH?=
 =?utf-8?B?eHJFdkVUZ0toS0V6Z2ZZMzJrQ3BESVpCSkJGNmZmVU9HaXYxN2dsTlhZN3A0?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UmXDIEC9i9X8qECryC6KdkwRzT/nduAOv508+0jSz9aMz6elVeLIfZNv0CmdXlhORbShU8V5XxbVYHiWas6bL1OADI864EvwPofDRuscQaUhZ1H+wcKpGltpt6i4hCRmjXR4Seaxax8Mjooc52yJ1YLNqxut3IintX4jH08hdYgEDNKoNeoKCBFoeET39IdDpe+LMfAz6VqaYBeSwEAqq5GekMt1Fd+mUjid+kKfX6PNydWYWRPjL5pgXQUuXi9MoNQ/poI6FM2WN7zLNBVdzyP5NVqk8bRtU5nwzhpglzTT2JEH+IYZAiAC6zwTUNKlG7wPRFErkGyXZzRsuEt2HA2o2TuGovx5MnhrPe02gXGpHhizP6S9F53mJ6XKKG2wg4BJygPuNB/1Jt+0Fe31oY1BYErdHGf1g/cH7OWm23zVBGCN8IYCyiB914RnUDFg74yghYaX9pREgUOuqI3bu+lgE4Y5QWSbTBoA0zgLSxTRVVeaUo81SFPErZL2IXaxE19dg5Wq4uo2uvISzxShVlluBFQsh9qHKxBREfN73eKqPwYSnmtbZ3/jubaB+ZApg50/77hSBF04uKVPHYCKxF4sW/bpkFLjKx5B8g85wcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7929ca-c1bd-443c-d4bd-08de066b4049
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 13:04:44.4272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbHTQFbRVwvvrWVw8WV86/Hy3vglm8MZlwD1SqXUabp8TQR92F0ccM7hLjy4qSvP36u3BMDom7paWTvmITAH1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510080091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDA1NyBTYWx0ZWRfX9k/ynUSXteSw
 0rL/+wKqjQ9Vl+U4zCvjmZ+TJ4u84Hy6YAKdjvaW37ISBk4zYNtaBP7hpbDdVLP7o+QbAxhwT1O
 57a6XK4H2OYkgfL1yWz7NOFhKAmpPMIj1tBnLOXwfCEbB0K1Vjx6APd6Esejzl1psGnNhAOkLT2
 XmVnP5GNGQVMwNBZtb4fxcLcJ2zbEL/YQpHcbRhgw8IlG26e8IyJmy3BRyVRyVCFEKE8npLtEHY
 zxrjoOcBOpcWTPfbo8MVT3Gv9FabjJ2gRBoUQDO9LNa/KW7ftzKuk00c4bIytpk0ryTirnRK3Wo
 t5EeWlH2/u4R0OV4ojrdlveJ9p59zTgJUMgD1E5BpqEZ5H3uPF2s3mj8gHdOt8AAYra2JWvxZQ4
 FECiiyjfygeFkC9LaVqBw0qlv78gvw==
X-Proofpoint-ORIG-GUID: YfBO8ryoCRGvNCG1TsUm46FEKRuD8DgH
X-Proofpoint-GUID: YfBO8ryoCRGvNCG1TsUm46FEKRuD8DgH
X-Authority-Analysis: v=2.4 cv=ZbcQ98VA c=1 sm=1 tr=0 ts=68e66174 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=8AY0yEwNZwtB1RvbB0sA:9
 a=QEXdDO2ut3YA:10

On 10/7/25 6:12 PM, NeilBrown wrote:
> On Wed, 08 Oct 2025, Chuck Lever wrote:
>> On 10/7/25 12:04 PM, Chuck Lever wrote:
>>>  RFC 8881 Section 2.10.6.1.3 says:
>>>
>>>> On a per-request basis, the requester can choose to direct the
>>>> replier to cache the reply to all operations after the first
>>>> operation (SEQUENCE or CB_SEQUENCE) via the sa_cachethis or
>>>> csa_cachethis fields of the arguments to SEQUENCE or CB_SEQUENCE.
>>> RFC 8881 Section 2.10.6.4 further says:
>>>
>>>> If sa_cachethis or csa_cachethis is TRUE, then the replier MUST
>>>> cache a reply except if an error is returned by the SEQUENCE or
>>>> CB_SEQUENCE operation (see Section 2.10.6.1.2).
>>> This suggests to me that the spec authors do not expect an NFSv4.1
>>> server implementation to ever cache the result of a SEQUENCE
>>> operation (except perhaps as part of a successful multi-operation
>>> COMPOUND).
>>>
>>> NFSD attempts to cache the result of solo SEQUENCE operations,
>>> however. This is because the protocol does not permit servers to
>>> respond to a SEQUENCE with NFS4ERR_RETRY_UNCACHED_REP. If the server
>>> always caches solo SEQUENCE operations, then it never has occasion
>>> to return that status code.
>>>
>>> However, clients use solo SEQUENCE to query the current status of a
>>> session slot. A cached reply will return stale information to the
>>> client, and could result in an infinite loop.
>>
>> The pynfs SEQ9f test is now failing with this change. This test:
>>
>> - Sends a CREATE_SESSION
>> - Sends a solo SEQUENCE with sa_cachethis set
>> - Sends the same operation without changing the slot sequence number
>>
>> The test expects the server's response to be NFS4_OK. NFSD now returns
>> NFS4ERR_SEQ_FALSE_RETRY instead.
>>
>> It's possible the test is wrong, but how should it be fixed?
>>
>> Is it compliant for an NFSv4.1 server to ignore sa_cachethis for a
>> COMPOUND containing a solo SEQUENCE?
>>
>> When reporting a retransmitted solo SEQUENCE, what is the correct status
>> code?
> 
> Interesting question....
> To help with context: you wrote:
> 
>    However, clients use solo SEQUENCE to query the current status of a
>    session slot.  A cached reply will return stale information to the
>    client, and could result in an infinite loop.
> 
> Could you please expand on that?  What in the reply might be stale, and
> how might that result in an infinite loop?
> 
> Could a reply to a replayed singleton SEQUENCE simple always return the
> current info, rather than cached info?

If a cached reply is returned to the client, the slot sequence number
doesn't change, and neither do the SEQ4_STATUS flags.

The only real recovery in this case is to destroy the session, which
will remove the cached reply.

We've determined that the Linux NFS client never asserts sa_cachethis
when sending a solo SEQUENCE, so the questions above might be academic.


-- 
Chuck Lever

