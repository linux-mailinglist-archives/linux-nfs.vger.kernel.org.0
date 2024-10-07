Return-Path: <linux-nfs+bounces-6915-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CA1993606
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 20:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17216286C0B
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7457A1DDC0C;
	Mon,  7 Oct 2024 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B9Gkdp4z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xvERirHB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A865A1DC054
	for <linux-nfs@vger.kernel.org>; Mon,  7 Oct 2024 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325404; cv=fail; b=qgEv+9Ob5WvOGuAYknXhhvppu79Q4EIm4Q6udjloLj/ZlKguIRmAQ43nFuCMpW6NyjSnhfDSukspSGHJ/W8r27pqeDnA+BXbn4k1DUKxH7NJ7CD2M9yqI5B5bpbYMSSdyxyhPr2p5KRiy1z1T1QIlq7XmGAFeK5g2FNz71tWm5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325404; c=relaxed/simple;
	bh=Y0NXRamEzjBrXeaceS59I6AcUoCyaXqu7G4JY2XeyZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ADvNTzSITSsshFBEDHTmDSFZfgErY++xmKha6wqyA8tngszuGuFMCYIM0KKN7fPSmRhE3uJOEvwnHAZE+P9TTEP9xMgcflEPbMr327gtsNhHmNudhiY0NE98WkR28rtMUfxxUacfGce262KDPDNKvFS/zBwkxgqIC+q/xw/Upsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B9Gkdp4z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xvERirHB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMaQL022224;
	Mon, 7 Oct 2024 18:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Y0NXRamEzjBrXeaceS59I6AcUoCyaXqu7G4JY2XeyZE=; b=
	B9Gkdp4zS1TMfZ/h/DV1lTOq/jylE24ym0Uz1H+7Te4B7vz9jz+zQA9jQPjJdAbG
	BM1ObzZZ0tEDIS6UNA6Y75XquqpuCmbNBMYNEIIyM9LzXnX3IyiSQvjSW9/Ehzt8
	mdumb1BO0ovSKiNTUMt6Y7vc/g4fu8e+2XFQeQZRQnAnPc4RbDa2oo6w26uEMOsw
	/mzb27rjRUMRw7a+TdmKA8rp5H/s3SSvbel3BIGGzx/ugupPvqjbMJz2OlGGXn/8
	ypwTelpm6C/h0GOaMi6h7aFdpCJ8hDkNk7+s/8WQyH19tbb6gBvvXj72JH7gDA6V
	ZgKwA2Adqm91eGrQWQtdsA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034m887-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 18:23:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497IDZ11002889;
	Mon, 7 Oct 2024 18:23:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwce0cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 18:23:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMd6Qv+Hjlgkiu7sDfnmNkUJxNo6irg0d0LhArJ5R0wSJqDtJiKD1+LUmSFvhAgKMd3+qxkTjbURVvKegN+1vEiFvuL9FvLac64oDYo6VbIv9WTdl+lA3GurI/NmGZyWz4/fCsX/S2iuRRq6n9foFDlYKj3hDehnwLzA0HqCTdK9QczWV38mbSjwO/8aK+hcm/Y7slH4244sHOnZ3RuN2o9pfMEBi+Y7zv4WqMI0LMewh6kAwY/fcA+bdKowQtHh+244eNG2/wtCDZEHGD4F3ugIVCQNJ4W4NoEeNjVbVk9nD48HzhICj44wglcPca/kZ9KL228FnJ5QnqMPZFJfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0NXRamEzjBrXeaceS59I6AcUoCyaXqu7G4JY2XeyZE=;
 b=Fc1Y/L2g7FkepxVKUZgwH0D7d8UK5b2OZwPkoDa4qOlom0m270H+ZHW9HYxTLXVQXEjFyZ82ul2nNs7hI/z85EssxVy77ME6QGbwuBBCqbk/Q3lNwOG1nowTEGjPkOl2MFHHx56tqDYkUbCLaLrfeouKUqMRgQWsIoL1JjiWZVA8P+2DjJEu1zUQIWbEx3RS+FzjjQwNcllgJG4gAVoe2gpd3NF5rwMAOljyvyDuANJhYqSSpEG0zXRLR6OKPlKpvZLI8FB5HQBpaNZwQ9lMGC9Yc0zpzB+mEIiEyIzmPaXENfukXJwOor6Zu/OCNjOk+/OstNGgavbuVpa71C/TjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0NXRamEzjBrXeaceS59I6AcUoCyaXqu7G4JY2XeyZE=;
 b=xvERirHBu8etk9rFSEawLR3C5OIz85WiNUy0p5d61gcgqMHGlPFcv+AxxmVi/9caN2HoRSudOZGrmnIvRxnOcZJsGmYoCS1iJdnpwqhnqDwinFYuwzvs7+hFon16VNIU/R6U2glwT8mkKQY2TanQdPcGHfZ1oZ8GNvg/xBgU9v0=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH8PR10MB6552.namprd10.prod.outlook.com (2603:10b6:510:224::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 18:23:15 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 18:23:15 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] xdrgen: Add a utility for extracting XDR from RFCs
Thread-Topic: [PATCH] xdrgen: Add a utility for extracting XDR from RFCs
Thread-Index: AQHbGOPamNC0IESyek6ox6gQOktMZLJ7mHwAgAABo4A=
Date: Mon, 7 Oct 2024 18:23:15 +0000
Message-ID: <2642E603-E47A-427B-B835-29321CE37276@oracle.com>
References: <20241007180754.112429-1-cel@kernel.org>
 <f99c00b849a3cb3ca98be800a6e0f69e51cd9e7d.camel@kernel.org>
In-Reply-To: <f99c00b849a3cb3ca98be800a6e0f69e51cd9e7d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|PH8PR10MB6552:EE_
x-ms-office365-filtering-correlation-id: 28826c21-3fc0-462a-8291-08dce6fd1c6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WmlVN3VVaWFxU1ZHaGJNcGVGWjhUMXcyazhWOVR4dEN3WlV0VExCM3dwTmhx?=
 =?utf-8?B?Y1lFVHRja0lrbnJMUVdSSW04OFV5TnIxQ0tJNVpjNjVnOW9saXhUSVhFSmNE?=
 =?utf-8?B?UlloR2NjTjB5cE5QWFp6TEJvVk4yOVFONDRMZjZWZVgwcVpNOFE1dXhqdjEr?=
 =?utf-8?B?alZJbU0vSzZ5N0ZLQXJkM3dEUjJGVnJFcnNpQlpHVkNFeDVFanU5QnNSY1Fk?=
 =?utf-8?B?OEp2dWZKRTlrZlVDQllQb0E1Q0ZCb0k1c1A1N0h3ZE5PSE5YOVY1aDVvK25L?=
 =?utf-8?B?eUNwZEVIdjhsbzI1OXFvWnRjUWJNaEdrYWZkSXR4Ni9qalVXYWlDUWVQR296?=
 =?utf-8?B?b0lhVFM4UlA2WmRjbFBIbWlLSFFRTk80RG0yU2YyZ0ZuK1BIdkhYelROSlhw?=
 =?utf-8?B?K3oyWmV3dEpIZDZhanVoQlREcStmWHFxQi9HV1RlRktueGsvYmFlVmpheE5U?=
 =?utf-8?B?UkR4RE93TkVkRmpINHJoMVFMSXU5aG9qdlEzUFJEV2IvQWNmOE8vaXhERlRW?=
 =?utf-8?B?WngwWVhQTjhUYWYvdFdZTGhRdThYelhTdkxiRnRrcGtJL3h1d2JlL1FmS21n?=
 =?utf-8?B?NllYTC9Zei9wSnliUmxITTdvT2ZBeFZTQ2FiWGZHRzhOZkk1V3M5cjc5V0Fk?=
 =?utf-8?B?bUxuUExqaDh0Q3F6VVRpYnE4bklTd21QeXZsZ0dqRHJONDVHS1NNcnJQcWhM?=
 =?utf-8?B?NzVCTHh2b3ppM2h0OUY2QitySkhVdGUyOFg5MWVtUHhOSGpRZmZTeE5Gc283?=
 =?utf-8?B?RDRyL3lmMDR5bGZrbHVCbXRrZGVhRENsSFVXd0p3SkRtUWZnbFVTQzhuSXFT?=
 =?utf-8?B?UUg4UGxIS1Y4RHZLV2dMeithWEE2Q0FrUU1wVXhyOWYvVHdBOEgwRTBhT21n?=
 =?utf-8?B?UVo3S2JXZ3R5S0dHYjJPM21mbjJjRjZqdStldDJVMWZJdUNYb2t0UUVSOTJv?=
 =?utf-8?B?dEhGcE9HTEtRb2VrNDJqRHlwTjVDOXZOYVRucmZXb2xxbGNEZUhsa0k2UVUx?=
 =?utf-8?B?VUQ2ODNLb3lhV0d1UmpJMkVTRS91bjgxWXd2Rm1kMlNaL2YyUDRaWGFhSTAv?=
 =?utf-8?B?K1R6MGtDYXZ6OGozYVgvcFBLWlVjaGpsU2lSb1FFekVLQ0RWZUVhQjVuQVVt?=
 =?utf-8?B?WmNUeU1sdjF0RWhMajJiK294aURDQzRkb0FNcm5vTFFqRGVEdStkMkY3V1pS?=
 =?utf-8?B?TXBzelZNNXJYaGZMS2UwTlo4VXQ1bTZnWHBmeHBNdGk2VDUzbSsycGt0TWJi?=
 =?utf-8?B?ZFBLQS9TSEJ6OHVYTjd6N01FYzN3cWNabHJpTkk5WU43c1k5S2RTQnNmbnVH?=
 =?utf-8?B?K2MrSXFCMEVGSnRRbTE0RmY0amczYnhHTDEvekJOaGtsejNXRnB0ODJnVHlx?=
 =?utf-8?B?MGdOODNvenhpaXdMZ2VKN3cvbnJ0WWJjOWRtR21IeVBZOG1STmtCNUhtTG1H?=
 =?utf-8?B?TXFTbkQrU1FkME5OZWpON2dldGc2eTNlRUZ6VkMvVU1ZV1Z3WFJNTmdrbTgw?=
 =?utf-8?B?SUhWM3I4VURJQzNvSDdoTU5acW1GczZNZTJsRWVkR3I5QTN1N1lJRGs3U2tH?=
 =?utf-8?B?NldodE5sTzk1NHVNUlhhbzVkbm8wQ1graCswejJzT3FjMFcrRnRWSGZueVFk?=
 =?utf-8?B?WHFIdFpqaEhaLzhLL0plakY5V2ZLWVNLc0xsMHBRNUU2cnRpWm94YnZwU1Vs?=
 =?utf-8?B?dGFNbTIydHlPRE9uSSt2MDV2QW9PSTRiQUdFM2d2UFVGTGFDNDBteENhWXpN?=
 =?utf-8?B?SDFoRFhNNUx4UnVkcXp1U1UxQUdMMDVpa3hyYmFzSzN1SGJVdkhmUHBmaGVG?=
 =?utf-8?B?S081eU9wQ2hYSTVoUUxnUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFFKOVJ6RmFGbU5DbE85UmZvMEMzUkorMldQYWNUR2xmeXp0RlUveFIvRXVF?=
 =?utf-8?B?RVE0NThzZlh2dlZXaWpLbU1NN2srdDNHSXBRMU5WeWpsczNpWit3ckdnU2JI?=
 =?utf-8?B?UGRqRWoxK0FSM2dFTGc3elh3ZWI4cWNPOUhwV01NeTBPczV3ZzZIVStTcmdR?=
 =?utf-8?B?QVlBUW9uTXRnOTkwaENnZndiVnc5N05TOHVKZDEvSGFSUWpBV1VJTFlIdlpH?=
 =?utf-8?B?bHBsNzVtM3hGWFFIajVtc3RxUUZ0ZFZUVGNtS1U3VkhtTDZRUUZvQTBRck00?=
 =?utf-8?B?MmgzbzYwelZkYzQwVjlKZElwUVZFWjVVWHhMV2ZpbWxHUHd6Z2l3Tk5lQWxS?=
 =?utf-8?B?VTJFQ1dPZkhTNVozQXJlbGlyOXc4VWQzaUlsdXJsanY5dE81RTlkTHV2YThY?=
 =?utf-8?B?T2ZzZ0lsdW13SWY2bldJWXFRNU5RVHNRTC85RDU2Slo1N2NXSDdIeGl6WmlB?=
 =?utf-8?B?dHJ0NzJzVUh6UU1Fa3Z2Q1BYUlVWSU5uem5KM3pCOHFuV0RFRWpVaXVOY3cx?=
 =?utf-8?B?OXNxUzFqY3NLRHdXTnFZWGhOWEFQN2FlYVl3L3VQVnNtVXEwSTJpVkxSV1Q0?=
 =?utf-8?B?UUsyYTRsUXZPTUIwSWNiaTNqckNwR3V1T29aem5wbmh2RlRmbHc2eEYwNkF0?=
 =?utf-8?B?cHE4V2k3UHE2dkU3S1B5Z2xnSmJjTmJnK2tyak9JaHZkdGZIVTV6QUZrT0Qy?=
 =?utf-8?B?Zk1Ld0RzZ1k3N2E4MHVPTk55YUFkbXZoYWJoYzZnZU5sTEZXVmcxK041SzRo?=
 =?utf-8?B?S1FRajhpYWwvaDAwbWFSa3lMMElrNktrR3dNc1orQ3g3QSs4ZXR2cDIzbzZj?=
 =?utf-8?B?K3RjVGt3WjRqUlY5ZldNR3RJK3FDQ0tITFlpclJaa0dHSHAwRXVRU3NsUmJR?=
 =?utf-8?B?enliMGNXakZlSXp1MkU2MHJyZExybGtxNHpya1RQbWc3S3hxL2pZNENUdzJU?=
 =?utf-8?B?SUlOYXNIbGJpOG5oeDVES28vd3pPV0dZZVJiSXVxVUFNYnZneStjaHE1N0pD?=
 =?utf-8?B?NVpQbHNFNFVVc2RwblhUTWEwNWJnbzdYY0dCZW1pMCtvUWdURjNLTUZxdWhW?=
 =?utf-8?B?Umg3OVk5QWtzZ0UweFN6Rm80Tzl3T0V1VDZEaXFzTmRzV3FNRXJQSHZlTysv?=
 =?utf-8?B?eWlNZHFnb1d4M3FTeEJHV1dPUnl3OHNOdXo5VGtMNmJWL3FxbXRENjZnV0dr?=
 =?utf-8?B?c1YwKzNEd1ZPbUdmOEdYU0podDZMTzE4ZVdTSG52RWEyb1hXUXdsQTBXOHB2?=
 =?utf-8?B?MVJnZXM3U3Q5aCtnZ3dyRXlMMmw5cWM4YTN5YURNYm1NSEM0TWg2UGQxSkY5?=
 =?utf-8?B?YTErOSt6TEMxakF2WnZaaXY1NnVmTXFsbTJqR1RNZkZrSHo1UXQwRGMwaEgx?=
 =?utf-8?B?L0tNVUZGUzg2T0pEbXd1elVDTVRuN2I1cmZDcy9oSE5TLzI3eU9OVDIxbyt3?=
 =?utf-8?B?S0RiRWVVZkFmV3dGbzRsb3luT1Q2RlJhNjA5ZzVPdTVDQ3JWRWVSTVZWK1ZP?=
 =?utf-8?B?Rk9iMTlwS0UweDJNZ2ZTQWFRQi9jcCtCMjBrbHo0MDhxb1pqdWRmVE4vaWFT?=
 =?utf-8?B?RWg0M0RIZmhYNjZFRUgzM01qMTRLWDBvdTRYY1ltTnhqcDBOUGEwd3o0dTQv?=
 =?utf-8?B?WWVxZmtFUndXNzgrcDRxQ25EaVIyRzVITlBOQnVOZUpOYUFkb2RjT0JZaFVH?=
 =?utf-8?B?UllvVUhvMGhORk5LNnRwaUtMcEhxYVBOWDNSUE02ZC9qVGVWNGVpUEtKaHVo?=
 =?utf-8?B?aGp1Z3NoQlMzUUEyY3JndHlVWG9Rc2kzRHh0ZXBmVzlnS0lsRlVNejFNeGEx?=
 =?utf-8?B?ellMalZQeVJ4ZWZrK0hrMkF5YlhLUU9SV2EweWhiejZzeXhZTnZ5WTVtUDlK?=
 =?utf-8?B?TmIvcGliSFo4eW44UEQ4K1ZxalVJblpWOG9lcG8zU3dVWUdUdVo1YXBheVN0?=
 =?utf-8?B?Q1F1QUJHc0VSQTd4UGdHRWVwZUdON3BYemd3QTc5OU50dmdRNUM4RkRoOERF?=
 =?utf-8?B?aVVFN0Z5VERYVU5kcHNzODF0cmNDWTNWVk0wUmdjbndHUUpEeS9UQm5aTEdx?=
 =?utf-8?B?eThweTBiYmZmU0IzTkUwV0VpaXRMYXU5OHVwK3I1SGtjV2c4Um5qOEUxcVlm?=
 =?utf-8?B?NUtqOFVuM2hpY0FrdkoyRXZ2L1lNUENMVzVvR3QrNnpBOEQzTDdEbEhkSC9k?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E7770152B11BD4AA4BA21DC0C18E23D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jo367b8NfslIbJc3cdcZ53rEBzbyjgmFV0vlBaPOlx8UH4dhd2RBRd6rejjGW4jEN1/+AxypeltzylAeFlEkS0KzNW5d33vDm0f8XU0AH3oYW1dO6GuOYXO347bLlEjDmC45twkfM7PtzjRyCmV1tSS+JjqsmJ0gCYKmEGxzg7XMzoJ2ZkOUzGRxwKU3JQIrq9omdtYEkAX4JtBru/6ZsAP+ed8qf6rOR/NnZUo7Z+ggUkoi0xxKw5ELucdzsHtHA/+tb8TLqWApNPMrMGVgOMcKkq4hHYjYE7AO8LUqstcpLbY1uQNuozVKd21vk1XoQhXZ+xKH0vdtgIpj3745sS8TwGRvPCBGmYrXuaD8Kyo9J+6v/xbXlxbQLJ3cXeIzmWx5jjb7ZVf+OdAkVOlkiB/g9CDlvdBh7uH4K6TvYuLgJybGiNQbE/UpWlpY9j73O63gvpEXeU/NqUSyQV5hMej6/WQEOl0s1L3rujH23S9MpEwiHA0GDAqlbjXhGvaS+Yke/PvRQIy+pzBU0KNf5Bn0FVWAuMZeacZGqRQtE+DxC7sXATnvB/SvyNnSnr2VK2qfvmqKTlSXqM+D1jmzeXv35sNwArTU3K934hEw4B8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28826c21-3fc0-462a-8291-08dce6fd1c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 18:23:15.7679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKusrWvgPnBcFtLDqDcCeWORuaG0muvfwbAUUC2QwsMZppXevpLHRxVmcmLLtwK/Vd0q2ICIM7yivcOzxEIi8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_11,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070127
X-Proofpoint-GUID: nLrKDyw3f1CgAbs_NJT9BtDYle_0uV0l
X-Proofpoint-ORIG-GUID: nLrKDyw3f1CgAbs_NJT9BtDYle_0uV0l

DQoNCj4gT24gT2N0IDcsIDIwMjQsIGF0IDI6MTfigK9QTSwgSmVmZiBMYXl0b24gPGpsYXl0b25A
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIDIwMjQtMTAtMDcgYXQgMTQ6MDcgLTA0
MDAsIGNlbEBrZXJuZWwub3JnIHdyb3RlOg0KPj4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxl
dmVyQG9yYWNsZS5jb20+DQo+PiANCj4+IEZvciBjb252ZW5pZW5jZSwgY29weSB0aGUgWERSIGV4
dHJhY3Rpb24gc2NyaXB0IGZyb20gUkZDDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IENodWNrIExl
dmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiB0b29scy9uZXQvc3VucnBj
L2V4dHJhY3Quc2ggfCAxMCArKysrKysrKysrDQo+PiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKQ0KPj4gY3JlYXRlIG1vZGUgMTAwNzU1IHRvb2xzL25ldC9zdW5ycGMvZXh0cmFjdC5z
aA0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvbmV0L3N1bnJwYy9leHRyYWN0LnNoIGIvdG9v
bHMvbmV0L3N1bnJwYy9leHRyYWN0LnNoDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDc1NQ0KPj4gaW5k
ZXggMDAwMDAwMDAwMDAwLi4xM2IwMDM2ZWFhODENCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBi
L3Rvb2xzL25ldC9zdW5ycGMvZXh0cmFjdC5zaA0KPj4gQEAgLTAsMCArMSwxMCBAQA0KPj4gKyMh
IC9iaW4vc2gNCj4+ICsjDQo+PiArIyBFeHRyYWN0IGFuIFJQQyBwcm90b2NvbCBzcGVjaWZpY2F0
aW9uIGZyb20gYW4gUkZDIGRvY3VtZW50Lg0KPj4gKyMgVGhlIHZlcnNpb24gb2YgdGhpcyBzY3Jp
cHQgY29tZXMgZnJvbSBSRkMgODE2Ni4NCj4+ICsjDQo+PiArIyBVc2FnZToNCj4+ICsjICAkIGV4
dHJhY3Quc2ggPCByZmNOTk5OLnR4dCA+IHByb3RvY29sLngNCj4+ICsjDQo+PiArDQo+PiArZ3Jl
cCAnXiAqLy8vJyB8IHNlZCAncz9eICovLy8gPz8nIHwgc2VkICdzP14gKi8vLyQ/PycNCj4gDQo+
IEl0IG1pZ2h0IGJlIG5pY2UgdG8gbWVudGlvbiB3aGVyZSB0byBnZXQgdGhlIHZlcnNpb25zIG9m
IHRoZSAudHh0IGZpbGVzDQo+IHRoYXQgaGF2ZSB0aGUgIi8vLyIgYW5ub3RhdGlvbiBiZWZvcmUg
dGhlIHNvdXJjZSBjb2RlIGJpdHMuIEFyZSB0aG9zZQ0KPiBhdmFpbGFibGUgc29tZXdoZXJlPw0K
DQpUaGF0IGtpbmQgb2YgaW5kZXggd291bGQgYmUgYXBwcm9wcmlhdGUgdG8gc3RvcmUgdW5kZXIN
CkRvY3VtZW50YXRpb24vc3VucnBjL3hkci8gLg0KDQpPciB5b3UgY2FuIGVkaXQgdGhlIGV4dHJh
Y3RlZCAueCBmaWxlIHRvIGluY2x1ZGUgdGhhdA0KaW5mb3JtYXRpb24gYXMgYSBjb21tZW50LCB3
aGljaCBpcyB3aGF0IEkndmUgYmVlbiBkb2luZw0Kd2hlbiB0aGUgZXh0cmFjdGVkIC54IGRvZXMg
bm90IGFscmVhZHkgaGF2ZSB0aGF0DQppbmZvcm1hdGlvbi4gRm9yIGV4YW1wbGU6DQoNCmh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NlbC9saW51eC5naXQv
Y29tbWl0Lz9oPXhkcmdlbiZpZD1lYTIyZmQwMmNmNGFlZDJlYjZkZmFhZWI1NzM4ZGNjYTM2NmMx
MWRlDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

