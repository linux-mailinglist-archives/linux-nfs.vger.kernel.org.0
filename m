Return-Path: <linux-nfs+bounces-5050-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F30093C6FF
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jul 2024 18:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67187282346
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jul 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FE5199231;
	Thu, 25 Jul 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P9/eSIFc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JVZcKRoN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C619CD00
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jul 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923837; cv=fail; b=QUHPR+48tfMEHepGnPGp3DEtvLg3kEpgqRmJ5Pd4Qs09GNH01tM7wDGYmEBU//LrOzGLSsotKuM8AMq0AeQVfodmJ1sviTPDiAugBhyAC9I62vp4h73TxZfEXSQSBoneDKx7zi4b2SymnBpWfutLX6CEBBKJXvO3cGJj+dOW2LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923837; c=relaxed/simple;
	bh=73S0lT/LH6U4QspB3qxYL7v609nV8g6DGsmDL1Gu+20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mIZe0WHG6UWGJ73sUTmFivWiKFQfBeGZL+s63E0EMAjhMBmEkLUMP3bvDDfD5JLChmWdE7Fr/r/D9cm+mywmg+piiDWBVkTfaFaudxtJjIO6/CnEkgrltXYBioEyy89tDOaiIQ2PRGmIhmTIExOFc/e4L1gMDd+qqSQSQSnIWKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P9/eSIFc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JVZcKRoN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PG8PUC008104;
	Thu, 25 Jul 2024 16:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=73S0lT/LH6U4QspB3qxYL7v609nV8g6DGsmDL1Gu+
	20=; b=P9/eSIFceylvCbNnJEbvwjx47iqq9d3RK+k4jx6bJSW4g92NzYOxI8ajR
	enZFCwlCRYRVNL0RQIyg1ZB4SV/KYZfsr/2w674JQR8MgNZcSVc27W02GZTSK7tf
	eDjPIaFTOlnddvZ92ZQmJkaFHCMruulVmXQIdbBZiYQRl4rA/XkvJvMNDM+V9GrG
	yaaOxbp6/xnyzE8dDSkDicOgjOh25zf51DJ9V5NnXdngCuzVhGra6vH+8V/LuQGl
	SoO/ed2wfyPDMz9MX0HpFoWBBanQ3YpQs9FmbskM/ssGIYMlXWO+hSclUMI7Laoo
	/sJ/uNwbeZ8icnEHZZti4ZH0n8zvw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0kt1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 16:10:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46PFvZSe039007;
	Thu, 25 Jul 2024 16:10:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29ua4k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 16:10:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eq6iEyLgHmL9M/Zhvekg0578RTQP0KiZ/OWyFrZOm7gPBdTY/L/lEGUbpBKYYFuJFDfYXXIA64IeiJ/VhBhCMOhL10UeJzm5QPpXI5qaVqjxn9OCf2m9p7qmhnECYbW0Pqw9n/X58lwwKOAkGfd9y8aNHRFbAfEjm0Zt7B061+fcb82LvR7m4nNDrIOtDLghs/kqYO8PjLxMvNccDB95eXTZvMQVde7WUAAXMrxN65EFcEC7z9Fz4ANx5ehJG1NmK1VjPFRiGi+KVdqTY20PDzhV6J9CrtUWU4/Ye5S0wlgOiVYNNwz7UxNBIGxZ09YGQ7WDwObLAkWrIILUGdl5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73S0lT/LH6U4QspB3qxYL7v609nV8g6DGsmDL1Gu+20=;
 b=riXLgmUMAov5qU8HxZPeM7JvEqZAON4YJ2pG8WKLVFF2Y/FCMgL1JJLdxpjYZi0AM52mDtUloqo2Q1PXBJrWa37OlOSxdSLkSqhP4yN6D7EHvX6rBUvweb510BIwQR1wruv5ZqJLHzXIdTkLdKFUKJ4DVMeEXmhJCHcOzoPfYvT/Xwa7eOgBZumCvW/82wy9V+NrHGH+VETVac2127UCtXk0mxbsSh8yZ1HI+eeXQvEBoSq8DGIwsEBMau2YgtzR5JnOszdbIHGNCl9ohENS6mS8/V+ubkFuuQ6IAA+UEfBVYJdYtxPdpbvtQ7JpLeeX4vcI0QxKNo7OJRakgY0vRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73S0lT/LH6U4QspB3qxYL7v609nV8g6DGsmDL1Gu+20=;
 b=JVZcKRoNFadwTiYyCpCOq7LBJWQcJTRejaaOsy7A34MGi4gcRc6jL4HyxBzF4U2LxE0NXreIvNwfvaxKDdxyXSTkR7xwACJmMQ8VOMU9WV61X/xJ7eT3Ie7sJrv+NlbHaoe5sOzvtf2WD+unP17M/aaiEOLKs8FFBbM3SU/aMKQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4966.namprd10.prod.outlook.com (2603:10b6:408:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 16:10:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 16:10:18 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dan Shelton <dan.f.shelton@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "ms-nfs41-client-devel@lists.sourceforge.net"
	<ms-nfs41-client-devel@lists.sourceforge.net>
Subject: Re: New NFSv4.2 attribute |FATTR4_TMPFILE| (sort of opposite of
 |FATTR4_OFFLINE|) ?
Thread-Topic: New NFSv4.2 attribute |FATTR4_TMPFILE| (sort of opposite of
 |FATTR4_OFFLINE|) ?
Thread-Index: AQHa3QKuWVeyibac00Wk/nvvcieDf7IEVq+AgACZDoCAArB5gA==
Date: Thu, 25 Jul 2024 16:10:18 +0000
Message-ID: <9D5914C6-BF08-4063-BCC7-C2F7458F33EC@oracle.com>
References:
 <CAKAoaQmG+FRhQquBJzFkr+BHFDCxxKky706Za2+nC9CNf8i10w@mail.gmail.com>
 <CAN-5tyG+t1Q=Tr0FtTzWhKE-=hLvWOarNn3_ArUt9VYuZ=aauQ@mail.gmail.com>
 <CAAvCNcBQK+z5=NUN3AmDG6qnEUJvwgF11479TrKwhTEC1qV-fg@mail.gmail.com>
In-Reply-To:
 <CAAvCNcBQK+z5=NUN3AmDG6qnEUJvwgF11479TrKwhTEC1qV-fg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4966:EE_
x-ms-office365-filtering-correlation-id: 48595c19-5dd6-4dad-ae1d-08dcacc446e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUdwcXZiT3FDYzFlZE9HV2pQY1pwZDByaWJSWkJlOE4rU2g4TGsxeC91Y21F?=
 =?utf-8?B?YWtIcVNOZ3R1dU1LSklJd05FNmlFRGZQS3RxMFMwcklJYUlyZmhWRlEvUTZj?=
 =?utf-8?B?NkJtWlN3SVBRN1hONmdOUm81LzZEUWJ3cjRoWFE1d1ltT05abTdxcW1zYktC?=
 =?utf-8?B?WEFScTVwcTJ2QlUyVGowelVlVFFBdHJuU0RqNStGU241bm1hWDVDbzlBc1F1?=
 =?utf-8?B?VTd1YmdhN3JwODZMTFVjUWZOSU9IYmxrMm9zYlpYdk5Wa0xzbUh2NHpXeEV0?=
 =?utf-8?B?UjJEMy9sSDl6V0NpOUQ5cHdHR2tJN3RScHU3cWdpSy9KelpuWVFXK25meGda?=
 =?utf-8?B?VElCcFlRcUMrV1l1MThwamhiSXE3TUo5RFhDbnBrSlpmR1AwWG5oZXlyK0dt?=
 =?utf-8?B?YXR6N2IrZk1RR1ludXNVUElKdGdmNjM2aTV6Z1hVMGd1aWNEUTl0RGpRclNK?=
 =?utf-8?B?QVFQVGpVaWQyTGhoOHo2a29CdVlDODBiNFpjMlNWUlNiUW1uVWZFOGpRU1lO?=
 =?utf-8?B?L3Zqam1lRHk5a0F6SUZZdUEvYmVlMml0WS84dCsvZkNqTERibUdQVVJtS3pZ?=
 =?utf-8?B?RVBGYzRrOUNTK3lZbkZRaVFJV2haa1MrcW5aYzFpRllMYkNSbk9UK2gxNlEx?=
 =?utf-8?B?M1FWckx4bW9SeHl5cE53UmRDdk4xT2RKeU5uSkJrMVVLOHVDS2FjZDRYRkVh?=
 =?utf-8?B?UGxjSEdPS1FMSWxNL0ZEb0tDbjR2K2NIM254Wkc2ZXBrOTFKcjJGU1hlR1Jz?=
 =?utf-8?B?UXdkT3hkQW90dkJmelhHWWREa3QvYUJhL3BmeTk2ejBhZ3V4VEtHREtNNFc3?=
 =?utf-8?B?SGltVFRuMVBMSjZsZGEwbWlQbTd5dEFtWUtJdU5RMTdkVzRjMkhNaTRQdEpD?=
 =?utf-8?B?QkFLQ2JkMHM3MGtENC9zOWdUY1k1c3JTNmwwMTErVVZDazJRK3JvQ1lnOUpX?=
 =?utf-8?B?RXR0YkJhZSsySDgyL1k1MWpGVnBpaUp0czBSUzBXS05MZUV0b084TnpueFlY?=
 =?utf-8?B?ZFFzMTNvSU40eEJ2blBxaDVNczhVQ3FkcmhVSENrQjNGVnkzbzNNUWxvVWc0?=
 =?utf-8?B?aHNXUjZObGFMZ25BUzF3SFMxcDFSNnZXbVBIbHlCeHlYaGRwLytLNm9pNW5Y?=
 =?utf-8?B?TUFGVmtiSE1XQkhnUGZLbndOcG1wbFRQeGRSTmM5R3JEcytnV1FOaWpDbVdE?=
 =?utf-8?B?Z0h1Mm1ZRCtFMHZsUkhxSTdyOWc2Sks0eHpFT3Y0MzdNc1VMMkYzUlEvZXBq?=
 =?utf-8?B?N1ZrY0FhMzV5QWRmQWJSTG9BcDlBcS9rZzNWM2hyKzJCWldiMkxuM1MwMU0z?=
 =?utf-8?B?c3V4TFlvOGxrR2wzUGFhdDdVWG9wdm8vT0ZEVGl6ekpEZGN2NDJqWkdzUWVy?=
 =?utf-8?B?a0Y4UGdycXpRcmZ4eXZlYWpsMURZSzcyR3VCdzdQM2drdzZIdEppbXlJWmJZ?=
 =?utf-8?B?MkMwSmxzc0huUW1ranhPZkdkMnFIZ2sxRmdLSzJzV2dDRHBGR0FXaUljN2s5?=
 =?utf-8?B?S3ZyWUtPT1FucFdZV1I4aENybnQ1c1poREJVTUNzUWh6YUprbnRQM3NKYjQr?=
 =?utf-8?B?R3JTRFNzTVhJZ3JWUmg0L0ZxOGtRVFJNbmxDRUJhK0pIMFRlS3dUK2xmWlNF?=
 =?utf-8?B?NHdhZnZzeWNIT1Qwc3Bxejg0RmpVR2EvSWkreHVibmJYeXhHZjF3SVlmNjlw?=
 =?utf-8?B?TCs2and6N3ZuK3AzaU1ydW5hZTRKemRmVkE1b1MxbWx0TkwxdmtBalhDQStF?=
 =?utf-8?B?aVhhL3c5NWI0YTVKSjRNSmVnZmVha3Z2UVY0K3M1Y1BEd2JyYldlWlpKeWs5?=
 =?utf-8?B?VXEyUVFvQUpLVHVBVlpUVDlpRExWNWdZQVo5aHBLd2NvcklVZC9VaGoyOFpm?=
 =?utf-8?B?cnB3bFRmOFpaZVhGdWUxZzh6S1NEbWVQeGlNYWFBd1NkRkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ylg5WGorZlNCS29OMXYvN0hQTHd0T2F2b3poY09Bb1hlY3NDbkpHR2pvNGNv?=
 =?utf-8?B?dzNvZU5FaGlLazc0Y3Q3dVJIU3g4eG0yUjR3K1VtamlZUXNOZUNxdldvTWFx?=
 =?utf-8?B?Z0tqNU4zSlpFc3hDbUU4UWlIZWNEYzVNR3llVTRqWFcyeThpQ0Z5WGxGNitp?=
 =?utf-8?B?SlBSdENFcWUyRkJ5dnEwUUYzVmF2cklVbk52b2RueDVhTUpTK2NnWVFWMDBa?=
 =?utf-8?B?RFIyVWFPcXF4aGFXZWgwekJmRjgwb2s2bTJmaTkycE1iQzRrRjZyVUZBS282?=
 =?utf-8?B?cGQ0UHRSdHVteWhsSFlxV2Nndmpua0l0UG9VcGdnZHZLK0tMYTYxaEZ2N2Ir?=
 =?utf-8?B?aEZPdHBZaWpyZ2hlL3VmUTRyWHU5UFE3dGl0QmdkWXJHWmdvZjlrVjNMZDAy?=
 =?utf-8?B?YnFrV0t3VElWOE5aUkFFTHphTWxiOCtHdFc0MkxkbUR2NFVnRHg5WlZRZW0w?=
 =?utf-8?B?TEdRbmZhSkJYSC9xRkRpcDFyZTVSckxMd2JrVWg4Z2dtU0sxS1lIdmZGSTVO?=
 =?utf-8?B?NEVCS2oxWUlJOXZSaW5mMjZmSDdab0dnQ1EyYmVORXByajBQOTVhZE5iS2xM?=
 =?utf-8?B?RW1DaWRya2NlZFBqRHRyVVZ0Y0hyaXI3ZEIweC9HNUsyTHlhdHlPRnNOS05X?=
 =?utf-8?B?bUpvdGp4cnNoSHc4aDBVYjdtb3JNOVdtQjcwaC9kMllQZ0NTNmFmRlBIbEtw?=
 =?utf-8?B?aU8welVKUjFtenF0K290TEV4cUphN3lXT3BuWnZ3OHpWUnh4aXBkbi9SQVo5?=
 =?utf-8?B?VVZVTVdxeUduNVZnV2xRa2xxMWFGU3lVbE8xRkVDdkI1OTB0S2FKS2pvMHBX?=
 =?utf-8?B?cVNOcmdDcEVhOUlDdVFaTWVJelBhVVBxVnY3Zkl6NEludUQ0RkY0ckZ4Rk1j?=
 =?utf-8?B?K0VDdTZJSGV4Q2Rtck5oeVF1TjhVdm5wUFVsM016eHd4RkxuQ0NPNkJ6akhT?=
 =?utf-8?B?RC9tQ1AxaDlrVFRYU0NIV3pxdkUxYUVmdU5SVXF2OENZcGcyeW9XUElUQ0t0?=
 =?utf-8?B?S0JFV1AzWnpITUo5a2VyK0FqdUQrZkthZmt4SlhHMTkvWmhFYlNqZHh6N3N6?=
 =?utf-8?B?TS9tSjJKS1dhMXVqZVNEZDBDRks3VUNjUXIrUFFMY0RJVnNzOS9qNTVkeFov?=
 =?utf-8?B?QnZyOXMwYWlqaENMS1hRdWpYQ3ZuQXRIUmtEZXNvRGtTTjRQZ0dNMDNEOTV6?=
 =?utf-8?B?Z3MybEswejVORjZEbnFQczJMaFN6cCs3VElpUER0QytwS0E5QWtGSDRXRE96?=
 =?utf-8?B?b1dUN3dQTUFxdzBtOHVsWUhJdVlmbzlFUHBUVVpySTkrYnlXYk9RNkQ5U1Vp?=
 =?utf-8?B?bTF6Um1XSDhCZ2pUMlpWQkVtSVllck0wbjhoVmNIQlY1VFNHWHJTYUxWdk4w?=
 =?utf-8?B?UTVrT2J3U2dTZDRmeW9YMVA1MmVYUlByTEQwNHRmc0orVlZRTU5xNm92RlJL?=
 =?utf-8?B?eHZwdm5FanhnQUJHWkFEOE1NVDF6dVErVDd2RE1YZndHeGVweFhvQVlhNnRj?=
 =?utf-8?B?Yjh6ZDNuNXVuQkpDWDU4WjlVRzlYMjQwbjZuaUo0dFdkVkpBNUpyNDRPWTda?=
 =?utf-8?B?NDQwelpQM284VkFRbU1XVUpNbFpzU3R6aVpENWk4UWYzN1BMamtuWXl1Mm53?=
 =?utf-8?B?SG9mNndlRWRoa3RqYnlMZWYvOFlhbXRCY2ZPY0R6NHVuenNNQ2pxMFJ6dVp0?=
 =?utf-8?B?emF5cGlXcXM0RnREcWg3amQyNm93c2tsaUhGT2JoZjUzWDEzZEU0Q3Foa1k0?=
 =?utf-8?B?YU10S1FRTjZWRFhQNnVKcTcvcGFaN2Nia1kzMjdMK2xFRWd5aExWMjRtV21W?=
 =?utf-8?B?bzcwNlF3dTVTaTFGeHliMTMyN2J6Q2U3REZhTXlCRjZ6RHE5V2V0TzJxZjRr?=
 =?utf-8?B?bFExdkpnckRmTjkySGZPUXNncUZKby9UeXRnY3Q3bWI3U1h4c3M2SHRtUmds?=
 =?utf-8?B?YmhSMTlNWjhhdlQ4S25HUmVLUEZkNmMvTUNyWGVoaG5kNHpMUVdLK05jVnlP?=
 =?utf-8?B?TlpYRkd6UFIwZUJZWmhKUml4Z0p3bFIweGVNYWNVTGlUb1M4ZDJBckpuWVZo?=
 =?utf-8?B?MVhYa3FIcWVjVERxOWt6U21acU5TZk0raHQ3SnJaSWZkbmZna2ZvMFdFMXNO?=
 =?utf-8?B?QTAxT3I2Nkx4WCs1MXhNMXV4MHFYaURpMTQxakg4TTJRQTFSR2dCYldTdG5r?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8ACB13E47EFDB34BA74C9A4588594F2B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lnKxzO4Y+hftPC/Jflzvh9ewT4FWnJZE2zHKX0Cez75UhdyS9xh/V6McqxEr6TkTKJn+fOwDcv2P4iiKZJIS4Rb8yscVgxgU+3h7Sfti/QgJ+IxEdJCZG/5V9VxbnAazDO/guP0C5INozMchWfTDWt7Sn5gdV8D0b3PH3H1XIGHzWbDnHQS9Kin/tN7hMLhEd6SzIg5Cl7GKMiM+oJRVhTpMYOfEmXirs6SEyL3A+A4WVRtaIDLxivlxoV6rCD7g00Id3WPf967eWzk0FzIzYqb6bKftppvALxYENnIoGzSWy2E8p4YezOr+j90pZMT5HfSIy8Lbu9IBp6Pj9bKhi9FhE2rVm1yOz8/ecADvXHi0WUZSDxiZ6qN52wyb6E4VwQ9SfH/9cmN88J+8t2k4+ktgdmvygtidOknGDCKbmALbzTvgKkFyPaMS0Zwl3rkjPBucxt0csNkcQGYsbi38/zVzCbN+jzEyu5Kw9jH2Nra+z8A3ypIpJzDeQGCS8ou+t8C1h7W6osNIxu1Kc2itHaOt298qhJUhLIZWfVy1fkORet5BLc11hLZzE9PhtIuO9C0rU67Nw1IgrLPa7DHxvzHNHGXbCU/QZPppCrZbt88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48595c19-5dd6-4dad-ae1d-08dcacc446e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 16:10:18.2274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRw1kaiqN3YKS/u/R6/utB1jxURQhBDciMst9iSbydWUqNDKh8BwKJglb2N1wYoSS0wmbWiMVHVWtIOOtAXzBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_14,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407250110
X-Proofpoint-GUID: gLkeFfKsu5EUL0UufUr1KpOfJ9Tqtkyr
X-Proofpoint-ORIG-GUID: gLkeFfKsu5EUL0UufUr1KpOfJ9Tqtkyr

DQoNCj4gT24gSnVsIDIzLCAyMDI0LCBhdCA3OjA14oCvUE0sIERhbiBTaGVsdG9uIDxkYW4uZi5z
aGVsdG9uQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIDIzIEp1bCAyMDI0IGF0IDE1
OjU4LCBPbGdhIEtvcm5pZXZza2FpYSA8YWdsb0B1bWljaC5lZHU+IHdyb3RlOg0KPj4gDQo+PiBP
biBUdWUsIEp1bCAyMywgMjAyNCBhdCA5OjE34oCvQU0gUm9sYW5kIE1haW56IDxyb2xhbmQubWFp
bnpAbnJ1YnNpZy5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IEhpIQ0KPj4+IA0KPj4+IC0tLS0NCj4+
PiANCj4+PiBbMm5kIGF0dGVtcHQgdG8gc2VuZCB0aGlzIGVtYWlsXQ0KPj4+IFRoZSBXaW4zMiBB
UEkgaGFzIHxGSUxFX0FUVFJJQlVURV9URU1QT1JBUll8IChzZWUNCj4+PiBodHRwczovL2xlYXJu
Lm1pY3Jvc29mdC5jb20vZW4tdXMvd2luZG93cy93aW4zMi9hcGkvZmlsZWFwaS9uZi1maWxlYXBp
LWNyZWF0ZWZpbGVhKQ0KPj4+IHRvIG9wdGltaXNlIGZvciBzaG9ydC1saXZlZC9zbWFsbCB0ZW1w
b3JhcnkgZmlsZXMgLSB3b3VsZCBpdCBiZSB1c2VmdWwNCj4+PiB0byByZWZsZWN0IHRoYXQgaW4g
dGhlIE5GU3Y0LjIgcHJvdG9jb2wgdmlhIGEgfEZBVFRSNF9UTVBGSUxFfA0KPj4+IGF0dHJpYnV0
ZSAoc29ydCBvZiB0aGUgb3Bwb3NpdGUgb2YgfEZBVFRSNF9PRkZMSU5FfCwgc3VjaCBhDQo+Pj4g
fEZBVFRSNF9UTVBGSUxFfCBzaG91bGQgYmUgaWdub3JlZCBieSBIU00sIGFuZCBmbHVzaGluZyB0
byBzdGFibGUNCj4+PiBzdG9yYWdlIHNob3VsZCBiZSByZWxheGVkL2RlbGF5ZWQgYXMgbG9uZyBh
cyBwb3NzaWJsZSkgPw0KPj4gDQo+PiBJIHRoaW5rIGEgbW9yZSBhcHByb3ByaWF0ZSBtZWRpdW0g
Zm9yIHRoaXMgbWVzc2FnZSBpcyBhbiBJRVRGIE5GU3Y0DQo+PiBtYWlsaW5nIGxpc3QNCj4gDQo+
IFdoZXJlIGlzIHRoYXQgbGlzdD8NCg0KPG5mc3Y0QGlldGYub3JnPiBpcyBwdWJsaWNseSBhcmNo
aXZlZCwgYnV0IHlvdSBoYXZlIHRvIGpvaW4gdG8NCnBvc3QgYmVjYXVzZSBhbGwgcG9zdHMgdG8g
dGhhdCBsaXN0IGFyZSB0cmVhdGVkIGFzIGNvbnRyaWJ1dGlvbnMNCnRvIHRoZSBJRVRGLg0KDQoN
Cj4+IGFzIEZBVFRSNF9UTVBGSUxFIGlzIG5vdCBhIHNwZWMgYXR0cmlidXRlLg0KPiANCj4gSSB0
aGluayB0aGUgcXVlc3Rpb24gd2FzIHdoYXQgdGhlIExpbnV4IG5mc2QgcGVvcGxlIHRoaW5rIGFi
b3V0IHN1Y2gNCj4gYW4gYXR0cmlidXRlLg0KPiANCj4gQnV0IEkgYWxzbyBoYXZlIGEgcmVsYXRl
ZCBxdWVzdGlvbjogQ2FuIHRoZSBMaW51eCBuZnN2NCBjbGllbnQgY29kZQ0KPiBzZWUgdGhlIE9f
VE1QRklMRSBmbGFnIGZyb20gb3BlbmF0KCkgc3lzY2FsbHM/IElmIHRoYXQgaXMgdGhlIGNhc2Us
DQo+IHRoZW4gT19UTVBGSUxFIC0tLS0+IHtGQVRUUjRfVE1QRklMRSwgdHJ1ZX0sIGFuZCBMaW51
eCBuZnNkIGNhbg0KPiBvcHRpbWlzZSBzdWNoIGZpbGVzIHRvby4NCg0KT19UTVBGSUxFIGlzIGEg
bGl0dGxlIGRpZmZlcmVudC4gb3BlbigyKSBzYXlzOg0KDQogICAgICAgT19UTVBGSUxFIChzaW5j
ZSBMaW51eCAzLjExKQ0KICAgICAgICAgICAgICBDcmVhdGUgYW4gdW5uYW1lZCB0ZW1wb3Jhcnkg
cmVndWxhciBmaWxlLiAgVGhlIHBhdGhuYW1lDQogICAgICAgICAgICAgIGFyZ3VtZW50IHNwZWNp
ZmllcyBhIGRpcmVjdG9yeTsgYW4gdW5uYW1lZCBpbm9kZSB3aWxsIGJlDQogICAgICAgICAgICAg
IGNyZWF0ZWQgaW4gdGhhdCBkaXJlY3RvcnkncyBmaWxlc3lzdGVtLiAgQW55dGhpbmcgd3JpdHRl
bg0KICAgICAgICAgICAgICB0byB0aGUgcmVzdWx0aW5nIGZpbGUgd2lsbCBiZSBsb3N0IHdoZW4g
dGhlIGxhc3QgZmlsZQ0KICAgICAgICAgICAgICBkZXNjcmlwdG9yIGlzIGNsb3NlZCwgdW5sZXNz
IHRoZSBmaWxlIGlzIGdpdmVuIGEgbmFtZS4NCg0KVGhhdCBkb2Vzbid0IHNlZW0gdG8gYmUgcXVp
dGUgdGhlIHNhbWUgdGhpbmcgYXMgImNyZWF0ZSBhIG5hbWVkDQpmaWxlIGJ1dCByZXF1ZXN0IHRo
YXQgdGhlIHNlcnZlcidzIEhTTSB0byBpZ25vcmUgaXQiLg0KDQpBbHNvOiBhbiBPXyBmbGFnIGlz
IGEgZGVjbGFyYXRpb24gb2YgYW4gYXBwbGljYXRpb24ncyBpbnRlbmRlZA0KdXNlLiBBIGZpbGUg
YXR0cmlidXRlIGlzIHBlcnNpc3RlbnQgYWNyb3NzIG9wZW5zLiBPX1RNUEZJTEUgbWlnaHQNCmFw
cGx5IHRvIHdyaXRlYmFjayBzdHlsZSwgYnV0IGl0IGRvZXNuJ3Qgc2VlbSBjb25zaXN0ZW50IHdp
dGgNCmhvdyBvbmUgbWlnaHQgcHJlZmVyIHRvIHNldCBIU00gcG9saWN5IG9uIGEgcGVyc2lzdGVu
dCBmaWxlLg0KDQpUaGVyZSB3YXMgYSByZWNlbnQgKGJ1dCBub3cgZXhwaXJlZCkgcGVyc29uYWwg
ZHJhZnQgdGhhdCBwcm9wb3NlZA0KYWRkaW5nIHNvbWUgZmF0dHI0IGF0dHJpYnV0ZXMgdGhhdCBl
bmFibGVkIGNsaWVudHMgdG8gY29udHJvbCB0aGUNCkhTTSBwcm9wZXJ0aWVzIG9mIGEgZmlsZS4g
SXQgZGlkbid0IGdldCBhIGxvdCBvZiB3b3JraW5nIGdyb3VwDQp0cmFjdGlvbi4NCg0KSU1PIGdl
bmVyYWxseSB0aGUgTkZTIHByb3RvY29sIGlzIGFib3V0IGFwcGxpY2F0aW9uIGFjY2VzcyB0bw0K
ZmlsZSBkYXRhOyBhZG1pbmlzdHJhdGl2ZSBvcGVyYXRpb25zIGxpa2UgSFNNIHBvbGljeSBhcmUg
bGVmdCB0bw0KdGhlIE5GUyBzZXJ2ZXIgYW5kIGl0cyBsb2NhbCBzdG9yYWdlLiBZb3UgY291bGQg
Y2VydGFpbmx5IGludmVudA0KYW4gUlBDIHByb3RvY29sIChvdXRzaWRlIG9mIE5GUyBidXQgdXNp
bmcgTkZTIGZpbGUgaGFuZGxlcykgdGhhdA0KY291bGQgYmUgdXNlZCB0byBzZXQgSFNNIHBvbGlj
eSByZW1vdGVseSAoYW5kLCBvZiBjb3Vyc2UsDQpzZWN1cmVseSkuDQoNCldlYXJpbmcgbXkgTkZT
RCBtYWludGFpbmVyIGNhcDogQWdhaW4gaXQgaXMgYSBtYXR0ZXIgb2Ygd2hldGhlcg0KdGhlcmUg
YXJlIGxvY2FsIGZpbGUgc3lzdGVtcyBvbiBMaW51eCB0aGF0IGNhbiBzdG9yZSBhbmQvb3INCm1h
a2UgdXNlIG9mIHN1Y2ggYXR0cmlidXRlcy4gSSdtIG5vdCBhd2FyZSBvZiBhIGN1cnJlbnQgc3Rh
dHgoKQ0KQVBJIGZvciBjb250cm9sbGluZyBIU00gcG9saWN5LCBidXQgSSdtIG5vdCBleHBlcnQg
aW4gdGhhdCBhcmVhLg0KKFRoYXQgZG9lc24ndCBtZWFuIHRoZXJlIGFyZW4ndCBvdGhlciBORlMg
c2VydmVyIGltcGxlbWVudGF0aW9ucw0KdGhhdCBjb3VsZCBpbmRlZWQgbWFrZSB1c2Ugb2Ygc3Vj
aCBhbiBhdHRyaWJ1dGUpLg0KDQpBcyBmYXIgYXMgZGVsYXlpbmcgZGF0YSBwZXJzaXN0ZW5jZSwg
dGhlIGNsaWVudCBjYW4gYWxyZWFkeQ0Kc2lnbmFsIHRvIHRoZSBzZXJ2ZXIgdGhhdCBpdCBkb2Vz
bid0IGNhcmUgbXVjaCBhYm91dCBhIGZpbGUncw0KY29udGVudCBieSBzaW1wbHkgbm90IHNlbmRp
bmcgV1JJVEVzIG9yIGEgQ09NTUlULiBTZW5kaW5nIGENCkNMT1NFIGNhbiBiZSBwcmVjZWRlZCBi
eSBTRVRBVFRSKHNpemU9MCkgdG8gZW5zdXJlIGFueSBhbHJlYWR5LQ0Kd3JpdHRlbiBkYXRhIGlz
IHRvc3NlZC4NCg0KSXQgZmVlbHMgdG8gbWUgbGlrZSB0aGUgY2xpZW50IGhhcyBzb21lIGNvbnRy
b2wgaGVyZSBhbHJlYWR5LA0Kd2hpY2ggaXMgd2h5IEkgc3VnZ2VzdGVkIHRoYXQgYSBwcm9vZi1v
Zi1jb25jZXB0IHdvdWxkIGJlIGENCnVzZWZ1bCB3YXkgdG8gZXhwbG9yZSB0aGUgaWRlYSBhbmQg
bmFpbCBkb3duIHRoZSBkZXNpcmVkDQpzZW1hbnRpY3MgYmVmb3JlIG1ha2luZyBhIGZ1bGwgcHJv
cG9zYWwgdG8gY2hhbmdlIHRoZSBwcm90b2NvbA0Kc3RhbmRhcmQuDQoNCg0KLS0NCkNodWNrIExl
dmVyDQoNCg0K

