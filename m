Return-Path: <linux-nfs+bounces-7360-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF909AB0A2
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 16:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E8B28452A
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61A11A08BC;
	Tue, 22 Oct 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eh2OM+C9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PaKohcN5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF361A00F2
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606650; cv=fail; b=g+pHJPjmgnuXRuCoUlBTltVOUE+VReggWPUGawwnZ7sjypF3EQFSohU/DD3EnMuA6rXZHm5V0PUDvOLimI3Aw44G8lm8G+X3/Tf7F7e2PnKYHurUAVARqxh/hc+FOpWYBNYL/B7kZUXVmmLJPoJ7buD8c8JVqFL9oToVLYdAlnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606650; c=relaxed/simple;
	bh=JgG39hiXvAqtxQi3nbFVDnrkVb85EMrB+Dxcf946yNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jv8B6/YfyNInIYAaS0tp9tGmIYE6a2bj1gZxKLCFjp3+AhkiJCJhC5sfsSqiFXsrJB9qABpoTbeQtMPCueWh1+eh/VVBdTYIAtRJ3queB4PDcGP7SODhWIxsg5gl5USaACmf/sCvP2+uSRyMkRvsY2GIVRkD7q7ybryxCuSwUXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eh2OM+C9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PaKohcN5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MChcnB016503;
	Tue, 22 Oct 2024 14:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JgG39hiXvAqtxQi3nbFVDnrkVb85EMrB+Dxcf946yNE=; b=
	Eh2OM+C93Iyzqq/xOzvYEIoPhOQNgZX/OT4TOSPo2IyU1rEnGjxkinrdNVNp0EKX
	NFrbHS9hSM/EygLEmGiTuIXv5SVEMElLvTPPHlxvFs2P4qV5La0ZyRWA+dL0m7J+
	+WPU2bCnOBsLsggEHT09tYf+khJJGC/HdsTX4ffGU6Yzwsz3pFh61Cs/+jXwyhzO
	CN/4l/NPh3q2p9y0tfqRWWhn9GAUD/eDpaEZMJjFYSVZF327Jqtk5LhTvfBwvojP
	mriouGfbewB4/uW3er45Nwa8elGUPvRlqHLxUFMSN6cKv2UpsXG6PmkOeFK9yEBI
	aPgkCkP/BTPUKxVA24651Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53unr22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 14:17:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MEBJGA008286;
	Tue, 22 Oct 2024 14:17:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c377r56y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 14:17:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agBtSX1b4Gz442I9b1ERHzbGWNrsxqe3lH+W2d0zpuKrS89suMcq3XQgTY/H588kpz+Blv+CF0zxewcdo4+4JFHU7bkdQVqU9upzimy76PRY6svOXmoJkwCddtFeyterXCjE06pbL+hhjD4DPUcQUsOh1biuKHAK19N/SN+9QkTl9dhTNTJlhNigCByVU/ootglU5s4Jjd2ZdtVmUXDDR1b4RK+WwjHQlfv3FoTf7yuPlDmm6wl+eBjm4t+JLUJAhrxcUQYL73B7yW9/jJ0FP7i3mGg8bdKGchEfMfgWIaZhN2cRZQYmtchJbnxWO2r3m6hWvOY1pjtwux2L/gwxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgG39hiXvAqtxQi3nbFVDnrkVb85EMrB+Dxcf946yNE=;
 b=OFvT9yekPy2I6WI20+1SjYL9TQOS/C0D7X/T93fXKRGDmfpaxU93eZ6I95z/UBIh6QA9K4cTn23tiO20Dav9Ng7LFlrwf1TQlOM0fwy/zwdWHy08KVA6ekBZisOt5NQNIPMVFPSjo9oLRHY8pri7EmqKem81Wt4XOX7lPogvLLiABo1u0BTxb+/QPovaCzjfDAy+Z2aV6N3wq72IwQ6KeIawWq3BUhtw4ZzVuNSNIlGmFR1qxfuLyvQ+34QDnJjHt6QftFgmMZkRo6VFB/A+1oNJfegQMybKRSFWCWNqUmWqb/psyAozvM5Mklw9K54wX/Be4/An5jtEQPLq1vo9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgG39hiXvAqtxQi3nbFVDnrkVb85EMrB+Dxcf946yNE=;
 b=PaKohcN5iaeHUR0D+GZTgAR7M5u7F5BM0vRqlmVxD5iJCB4yp9I+L1QNQihTVWvKmrLioO2TJLQjQAy4OcyRxvm/fIB8Jjxx77P/Dl7UXowzzGfy8KJRVcBFu3fCaQbrmcLTuWk9L6U3qHkJ5iT5f/SFV+MDmQPy26B1Y6rHHLQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5186.namprd10.prod.outlook.com (2603:10b6:208:321::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 14:17:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 14:17:18 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Patrick M. <s7mon@web.de>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfs xprtsec conflicting with squashing
Thread-Topic: nfs xprtsec conflicting with squashing
Thread-Index: AQHbJImG74zHiX6KKUCO6c6GrqdGErKS0ROA
Date: Tue, 22 Oct 2024 14:17:18 +0000
Message-ID: <1294ABC2-CFCB-4984-B286-A973627E70EB@oracle.com>
References: <20241022155047.0b73b6b3@jen>
In-Reply-To: <20241022155047.0b73b6b3@jen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5186:EE_
x-ms-office365-filtering-correlation-id: b8eb965e-fcaa-423d-f32e-08dcf2a43c5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?STJVQ0VCWm45dm05R3hQOEFkaHZDSVQvWkJRMExRTnhtVWFiTGZjZkF3Mmdx?=
 =?utf-8?B?Y1hJblh0UDBab1Fsc1Y3SzZmeks4azRiQ3IvVjFRbVpKTHVMeDRabU5jWVJ1?=
 =?utf-8?B?UFp6V251bXhka3l5T3ZEbGw5S3prWFVjeHNSNVNLMlNGcXphYnVMQmFMYytQ?=
 =?utf-8?B?dlNYdFAwaFQrY1QrYmhGd2lpMi9BRDBZWHBmQ3V4TDdyaUQyVlQ4a0JSRkpt?=
 =?utf-8?B?SWhFenRCTWkxdW5LVmszWm1OV05PMFdYSGU1OWpiNDNHaXRPZ2poMy9wY1gx?=
 =?utf-8?B?c3NKRUZLQWJXUlQ0NWdCQmtjZEtzWGdmTm1zT2x1S1U0VDgxNGlvMDdzbzhs?=
 =?utf-8?B?cjA3cGt2NzRaSHFIVWM2UDBSY2JXem9XdjJxdXU0dTF6R3BxZ2JtdXovdzdo?=
 =?utf-8?B?Rm5uSyswOFBzcUFWd25oaUtjN3poQnRod2pwRy9MUmRNWlE0a2pEYVBPV0dw?=
 =?utf-8?B?ZlZtUVBVSzdPb2NESW1TUW16dUVlWS8vbDZ1SjZ0cEZiWE9PVDdGMkNLaHZp?=
 =?utf-8?B?SGY0N2s3WFVPQXVsWUZMclFzQ0JMV21CcDExYmcrWnEya1JlL2dIbmV1ZzBH?=
 =?utf-8?B?a3djOEZLSm02Nm1ETWhBYmRZU1pORVRaM0pxaHkrQ1gxTitMRVQrWGM3cUN3?=
 =?utf-8?B?blVuUk5wdVU1VSsxTGtOMWx4UG9pa0J2MW1VdWY1K0RSQWRobnNnV1FTZWNO?=
 =?utf-8?B?M1VNbzJ4RE10UlBUMmZib2l5UEZwUDN1SGt2UGpCUEVBYlJHYUE0cW1CZXo5?=
 =?utf-8?B?MzluTDB1Vk5VSDkrYWFzMk1JaUtEaFgvZS84bEdBeHhTVTd1YWF6L1NPdW0z?=
 =?utf-8?B?MXI3S2xEUXVTRHVzaGVvUHpwRkE2MEtpKytXbzVxc2QvL250MlZLaUkrejMz?=
 =?utf-8?B?OFFvdEkwRVB5dDFRUUF1djU4K0hiZXh4ZnorMUMwMXhqTEErMTZjSEJUNTNw?=
 =?utf-8?B?UDZZZTQyWndaOTZsNFpTVitvejVXY0x4UVZIOWgvQTJHSVhSVjhYK3BjSUY0?=
 =?utf-8?B?WW5hVFNueXdDdGJIZzV4TWFRTk5CZlYrTkpPVHlsbitjaWRiV1VYMmxDNXd5?=
 =?utf-8?B?RmNBRzZvSVBMN3cyNTYxejB2Q21RWDJvY2hXQjM0T1QwVmdkSWhzY0ltbFFH?=
 =?utf-8?B?Z2c0TmhzenBCcUl5dE1mYStVSk95R0EzS1hHemFyaHJiSFdnbENzVWxaekdL?=
 =?utf-8?B?S3NkK2oxK29oMG9pMFNPWkhoUWhJUS80a0ErZzZscVhlcXZUMUlWVjhlZ0p1?=
 =?utf-8?B?TG9mRGFFVi8vcUs1RTJ1ejRSZ3BGbDFnR2dyYTkrUFkrdWtVMjM1U1psSENM?=
 =?utf-8?B?UzRlL1ZxaTd4ekxQOWFoM2xxWkVRdHJ5LzRmamJXeFdvUCtJU1MyTkdDR1ZS?=
 =?utf-8?B?OE4vRUk2UllhYTJnUUQwS3poYW1LZjJlb0ZPMEhUYml5Y0dPOUFOYlJUWllF?=
 =?utf-8?B?dkZvTmRPQWt2YmUzWXI2NkdKUDg3L3I0WHJYWnAwMEpjbyt2cGUwUExaVXBY?=
 =?utf-8?B?VDNnTFg3SlpOLzF1dkpGc3lTLzJObnA2eHRoMXhWd3ZvRXpaL1NLMERBd1RN?=
 =?utf-8?B?cWtVaXJJZ1hSMm43Z3JuVFA0VVRZdHBuOUZKS2UwMFBaS2ZHUks3eXVTYU9Y?=
 =?utf-8?B?d25mdkhEYUhQQ3dOM0syaXdtL3NsbEVwZ29iV1B4N3ZCS1FTZVlyS1A5UnFu?=
 =?utf-8?B?ZWxiTmw0d0NnayszYzBLenNLRmNhTG1raDYzc2htSVU4S1FTNGhzVkxJYnRT?=
 =?utf-8?B?NkZleGpqQWhnQk5lYVF5ODRhWnZNRGRseGkwU05uU3BBYzZ2dEFTUmtDVHJ4?=
 =?utf-8?Q?4HRSLwv6DZKN22fByHKM6y/x98IpGgMjwv3aw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?enRyM2Q2NnBTekp2S3JleS9KY1FLQmFBam55VjRDMVZvVU01NEVyZ0FFd0U5?=
 =?utf-8?B?eEY4U05ZMlI5TjRsUFk4dVI4U2RCcDRRYjZjcjRCUWpuaGVRUjBwUGN2dkVo?=
 =?utf-8?B?ampCYjEyd2FxZ3BQRjVBdmliQjJMWDBidzMvbEZoTkFoSkFNNWczKzFWRGpz?=
 =?utf-8?B?bngraXRwOEt0RUFaNGRtMHh2RnQ4QUhuSndidFJBWHQ5dERPVERFOFM4QmIz?=
 =?utf-8?B?YWkyZW1uMDdkbE1lWFNJR3dwcUdZZCtDZFU4UnJ4YUxhTDZVZTRJRlNoUkZL?=
 =?utf-8?B?TC9xUDBlN20wbktoUFk2Y2dIcS91bUFCNzJVd2ovNFplL3JOTlRzajloZGJS?=
 =?utf-8?B?L2tMZ1hLV0JuNVZodlF3b1Flb3ppOFNwRDQzNVV3d2lyM2s4SXJhSWUyNyt4?=
 =?utf-8?B?ejFqeDNQcDNJQTk4NzlrZ3lndzdnblpZVVZLWGJ4ekIxVnU0dTFORXR2ODQ0?=
 =?utf-8?B?T0o4Z2FaNnZyYzd3SEViSDBocVU4dUpMdmVENmpRMHZ2S2tsZ21SSlNOaFY1?=
 =?utf-8?B?UTdCU0ZmWUFkc2hUcnI5N2cwcDA3YjdReWZ6K0ZWNWY2alVReUJrMEdCUUpN?=
 =?utf-8?B?UVNqRzNvWGEwTVFyenliN25iUk8vZktCRVRUVFZVQnBnQnFLZ0MrUzc4SkdG?=
 =?utf-8?B?S0djQytJL0kxWmZ2cWhzNDRtZFUzckpWNTNkVlJMR2lqRVF0NVlEdnAycUNj?=
 =?utf-8?B?UXY0TFJtQ1lHc1Z2cUo0WWJxYTdhamlpaTVoREIySHRVakl2Z2l2cHhkd3Zq?=
 =?utf-8?B?OUx6aXBUNUFTdnRxUzFnaHM5UlBHbTkyNVd2ek4xTVZtM1FBeUh5VHZQQm1K?=
 =?utf-8?B?aHJ5bndsN2J5U0Z0MFV1N25PZEh4MnVHUC8rWVg3Q1ZuaWdnSmVwOEw1Z1pN?=
 =?utf-8?B?dkMvMHZyQkRKVTlLZ2o3OVB1bzltczRDbHl0eDJ1V1pxM1JOSkpnTEJBOXhY?=
 =?utf-8?B?Y0VTcFhVb1huVGw0eUlzRXRteUM2R1pWMEtCWHdCL1haTldtaFZLanZZY3hr?=
 =?utf-8?B?VzB2UWZXR3c1UzZucXRxS1FoQU1yNjNkckl4S3ZsU1ZNek5ZNytWL0xYU1dT?=
 =?utf-8?B?a1E4Mmx4eCtsRmFpNUdlOHdNY1JFZzFScEZRL1FkZnRITnNnT1EycC9KSVV6?=
 =?utf-8?B?bXpMRzFlMUlOYzJ4bTVYZ3VHemVaZ0dIYkI1d1B1VHg2MC8zSTVHSUdxdDEv?=
 =?utf-8?B?R3NIZHp2Z3BiZGhuenh4bm5Nam4wcmlQYXNYYncrSGRwWEJZWnN2cUUwN3Yy?=
 =?utf-8?B?bGZ3WlA4Z0pWTmdBSktYK0VKbkNEWkxGa01EMVhRbDIyb21mcDZ1MlJkNG9U?=
 =?utf-8?B?NExrV0FkTHI1aFR4RHV3bkJDeUFYY2JIcWY4OHRyZVVaYmc2dDJITHlXMlZv?=
 =?utf-8?B?OUt4Q3FrS3NwSE5sdk1ZRlBaWlhVMEUvcVZ5dUJsR0c1d1pKelN2MGZrcHg1?=
 =?utf-8?B?c3dsa3ZWVGFPMzNMcEtUcnY0QklYSXQ2Q0R2dXdPV3V6M3VMb3FDdWtnKzZn?=
 =?utf-8?B?U0xIRVBGUWNoNVdkTmwydnNBaGhUaDljeXVuT21UK1RDVFgranNJR2tLZ3RE?=
 =?utf-8?B?RVhkVzJJQXhZejNJSW9DdXBkT2dvZDUrazBydkZYVWMvamRmN2JqR1dOL3Nl?=
 =?utf-8?B?USswK2p3ZFArQWRaaHI1d1dTSUN4UmZPbWRkdGVaRHFmUzQvVGVZdkFxcEF5?=
 =?utf-8?B?bVBlcE5kd0h4OEZ5WlJ4SGdqdGtkUE4wd0xWWExWY3pqZDJSYUYzWHRkUy9N?=
 =?utf-8?B?cWNQa3RYUFJKenFMV3MybmxRd25EUVdMZmZlUWI4MmFDbEplZDRkUG5FUVZF?=
 =?utf-8?B?VXpLaUJtR3JSV09DWFdDUGR5aDdnZS9TWTRZMWJvSzJEbDNTZjJ6a2FFcHV6?=
 =?utf-8?B?SjJ2TzlZOEdBL3JFNVBQQlVGcFd1cm1iVnl5MElnaUw4cDByQkt3UUh3c1hK?=
 =?utf-8?B?YmdUMlZubk9hTjdFdGpkYWNzdlk2QjlGSFRHN3FTWlNFWVEyYVNaUVR1dXNq?=
 =?utf-8?B?SlRxR0U3Mlo5SnVEYmNWUTdIWW92UVdnZDY3enBreFRSdDBmZVBsTWkrUUJB?=
 =?utf-8?B?SmkxemJtUi9qaE93MUxNaFB5OU1PM3Q4VHBnNUVpaXJOV0lpNnp1bVYrcktG?=
 =?utf-8?B?OEprSVdxYUtMV2dlYnlMdlRnVTRiTWFTOGpmcDhXcWFleldVdjkxMHZDYzh4?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21CCDDBFD43E5042834B346F5A8DFE38@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dxBMFOsmklTB6ns3K0v3EHQ5uvrEIyUsV4x4C+to2Zu7qy5nwokCXoT9dhYVsIZT17YSoUPcWw+YTQNoMbhKcSebwslkxVGtKLVC/LzTDBTMjlPu5biqU8+hWUUTAEv0XMoZ/zMWyCZOEpvSGQxStxGAalkrKamBXBtKFVHYrCFvi2mSEym1V5egsKqehx9S/I2WQ8Cq+d6aAjEelhhH5P+v0uLDII64YW8iEPevjaYoqdKoQHVcP9pl+TFWSg4K/D3P7SjZiGVtBVLIuJtca/gMMv0xhq84lk+G42CJPd2wA7XTdSkaBVtaw04YJsSgskICWtO+2qkriUZreYB3SMZD5iNZvWZIX87dhsEqpGJlik+N1j2eSsb36ASBDxCVowx3frtdGhQAeMAh7DnoTx/RVtZbqvP9oOkUqOm715Nc6FqSTHBley6VIowlmI68EPUC44PBAbaTkj7wmUn1eSllf1NZhlKLLDaHWW2TC2Ys6a2VrrAGzUOc8JiQpEMrOMqfW7BwshXzmmKMhR/YZ16Kkz43rb5KVcF8g9GTRFu2Z68X6n5evyAZ9loCgoPMlmlgHKKeBEtiXFItF/nLWtINhXCI5REFTj8YmU66MAM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eb965e-fcaa-423d-f32e-08dcf2a43c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 14:17:18.0628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HWIFuaNBd3nl75eabp5uHnwXyWrwxWyIfLxg001hMu0ZpBOWXqDjHRKFqkxDmsF+LbfODh1Q2Bq8pgLNBJI+8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_14,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410220091
X-Proofpoint-GUID: QRTRgW8qZdixSRwOaPwclmj-BOcSj1NS
X-Proofpoint-ORIG-GUID: QRTRgW8qZdixSRwOaPwclmj-BOcSj1NS

DQoNCj4gT24gT2N0IDIyLCAyMDI0LCBhdCA5OjUw4oCvQU0sIFBhdHJpY2sgTS4gPHM3bW9uQHdl
Yi5kZT4gd3JvdGU6DQo+IA0KPiANCj4gSGkgdGhlcmUsDQo+IA0KPiB0cmllZCBzd2l0Y2hpbmcg
dG8gbmZzIHdpdGgga2VybmVsIFRMUyAobVRMUyB0byBiZSBzcGVjaWZpYykuDQo+IFdpdGhvdXQg
eHBydHNlYyBpIHdhcyBhYmxlIHRvIHVzZSB0aGUgZm9sbG93aW5nIG9wdGlvbnMgb24gZXhwb3J0
cw0KPiANCj4gInJ3LGFzeW5jLGFsbF9zcXVhc2gsbm9fc3VidHJlZV9jaGVjayxhbm9udWlkPTEw
MDAsYW5vbmdpZD0xMDAsZnNpZD02LHNlYz1zeXMiDQo+IA0KPiBidXQgYm90aCB0aGUgc3F1YXNo
aW5nL21hcHBpbmctaWRzIHNlZW1zIHRvIGNvbmZsaWN0IHdpdGggVExTIGFuZCBpIHdhbnRlZCB0
byB1bmRlcnN0YW5kIGlmIHRoaXMgaXMgYnkgaW50ZW50aW9uIG9yIGEgYnVnLg0KDQpJIGRvbid0
IGV4cGVjdCBicmVha2FnZSBsaWtlIHRoaXMsIHNvIGF0IGxlYXN0IHNvbWUgZnVydGhlcg0KdHJp
YWdlIGlzIG5lZWRlZC4gQ2FuIHlvdSBvcGVuIGEgYnVnIG9uIGJ1Z3ppbGxhLmtlcm5lbC5vcmcN
CnVuZGVyIHRoZSBGaWxlc3lzdGVtL05GU0QgY29tcG9uZW50Pw0KDQpZb3UgY2FuIGFsc28gdmVy
aWZ5IHRoYXQgdGhpcyBiZWhhdmlvciByZWN1cnMgd2l0aCBhIDYuMTEgKG9yDQpsYXRlcikga2Vy
bmVsIG9uIHlvdXIgTkZTIHNlcnZlci4NCg0KDQo+IEFuZCBpZiBpdCBpcyBieSBpbnRlbnRpb24g
b2YgY291cnNlIHdoeSAtIGJlY2F1c2UgaW4gbXkgdW5kZXJzdGFuZGluZyBhdXRoIGFuZCBlbmNy
eXB0aW9uIG9mIHRoZSBtb3VudCBpdHNlbGYgd291bGQgbm90IGNvbnRyYWRpY3Qgd2l0aCB0aGUg
bWFwcGluZyBmdW5jdGlvbmFsaXR5Lg0KPiANCj4gSSBub3cgdXNlICJydyxhc3luYyxub19zdWJ0
cmVlX2NoZWNrLGZzaWQ9NixzZWM9c3lzLHhwcnRzZWM9bXRscyIgYW5kIGl0IGlzIHdvcmtpbmcu
IFVzaW5nIG5vX3Jvb3Rfc3F1YXNoIGFsc28gc2VlbXMgdG8gY29uZmxpY3QuDQo+IA0KPiBLZWVw
aW5nIElELU1hcHBpbmcgaSBnZXQgdGhpcyBvbiBjbGllbnQgc2lkZQ0KPiANCj4gbW91bnQubmZz
OiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZCBmb3Igc2VydmVyOi9tbnQvdGFyZ2V0IG9uIC9tbnQv
dGFyZ2V0DQo+IA0KPiBBbmQgbm90aGluZyBpIGNvdWxkIHJlbGF0ZSBhcyBjYXVzZSBvbiBzZXJ2
ZXIgc2lkZSAoaGFwcHkgdG8gcHJvdmlkZSBzcGVjaWZpYyBsb2dzIGlmIG5lZWRlZCwgZXZlbiB3
aXRoIG5mc2Qgb3IgcnBjIGZsYWdzIHdpdGggcnBjZHVtcCBpIGNvdWxkIG5vdCBzZWUgYSBjYXVz
ZSkuDQo+IFRsc2hkIHNob3dlZCBhbHNvIHN1Y2NlcyBpbiBib3RoIHNjZW5hcmlvcyAoaGFuZHNo
YWtlIHN1Y2Nlc3NmdWxsKSBhbmQgaSBjYW4gdXNlIGFsbCBvcHRpb25zIGFzIHdlbGwgaWYgaSBy
ZW1vdmUgdGhlIHhwcnRzZWMgb24gc2VydmVyIHNpZGUuDQo+IA0KPiBDbGllbnQ6DQo+IExpbnV4
IDYuMTEuDQo+IG5mcy11dGlscy0yLjcuMQ0KPiANCj4gU2VydmVyOg0KPiBMaW51eCA2LjUuNTIN
Cj4gbmZzLXV0aWxzLTIuNy4xDQo+IA0KPiBTb3JyeSBpZiBpIG1pc3NlZCB0aGlzIGluIGRvY3Vt
ZW50YXRpb24sIGlmIHNvIGknZCBhcHByZWNpYXRlIHRoZSBoaW50IHdoZXJlIGkgc2hvdWxkIGxv
b2sgaW4gZGV0YWlsDQo+IGFuZCB0aGFua3MgZm9yIHRoaXMgZmVhdHVyZSENCj4gDQo+IA0KPiAt
LQ0KPiBiZXN0IHJlZ2FyZHMNCj4gUGF0cmljayBNLg0KPiANCg0KLS0NCkNodWNrIExldmVyDQoN
Cg0K

