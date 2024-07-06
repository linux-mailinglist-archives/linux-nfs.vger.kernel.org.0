Return-Path: <linux-nfs+bounces-4679-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8E7929192
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 09:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526DE1F22167
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 07:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEA518040;
	Sat,  6 Jul 2024 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DGkbEHip";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mctjw9I3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0F134AC;
	Sat,  6 Jul 2024 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720252011; cv=fail; b=N71L/ZljJ96fUnyP288Iqw14KuYDdemg1YklG2B+xvMxgXyypKlpdwT0jhcg5WSRpWkeBQf3Ld5NcyJMDNLrJBliQmzQXXhLi3BBnwagP9E+k62GZkg1Btegcahf3efE+bT0n0X9ZRLIbupGPlBUeod6f6kO2dbOW1BrYV/RWOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720252011; c=relaxed/simple;
	bh=XOMAxD/YI8cfSEVyT78MC+rkSYdQ2h5Pwv0eLXMzoWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RCLItMUBPr4Xmbom61vmgMbrEAKpFIQM0Zi3RozN4hQ3yY+s7A//w9IF3LZoiOXYwJYirP/UPRnaqndYuaGvFkr1zXEWqoJj6QqJYWuXjc9X8TGgPvReSVBumSN3sIApuQGWUtk6fg/7rKCA1oWHs2VgJ/x/5fDKJDOzwAhG204=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DGkbEHip; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mctjw9I3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4664p1nT007663;
	Sat, 6 Jul 2024 07:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=XOMAxD/YI8cfSEVyT78MC+rkSYdQ2h5Pwv0eLXMzo
	WU=; b=DGkbEHiprHnqaIUIq0x7DQ1wn9HcGKn/Tf2PlaaryW/+mt7iZ7T9abQCD
	60lXH2gxp2A2UOiwhkZcnDk9F596GV95T7J1as+WmQt9bvD7cuav/CWtOienc0gg
	Po+b+/7Wp1zObsD57OaMau4nbMpwOUYhjj6PvNEzpioH8wND6P+ghNXAMxUzxTP5
	DpQ73cMCh9vFQX8tkBc7flEpQY5evmBPHGxXvOBErQbpsuUZt3/CUABa47mFc/vs
	pFdepmZIK1GIh/qWdlXJv3qoTktwrhqv9+IrqlnK6GwtsR9Pumkampy9o5ryOwHt
	KPiEqxPzaiDt+eG7ZXOBiinB3QggA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybg4ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jul 2024 07:46:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4666Pxk9040701;
	Sat, 6 Jul 2024 07:46:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 406vc5nbnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jul 2024 07:46:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTmSrw5lOjecJNSDSK7aZGLstUFQbgleZn8wmtTcOwnOR8b0+8fktJgeHH1+Bsa9uMCDX2A7AuQ5GBL5S4ObE5MRShKSsujA1gwkpLgYX6T1eE9tMEgMQc6mEK0Yeg2RajNI5aJ1grZ+TQpagl/gBW5Fq3jsXfUIXmM3H01QG6O7xfEtBb7Q5qEwPZ3d9L9QmxCnoiqjl9ZVU3VWOYL8+OYpdVk46GdlQsHkn4SDm8N0gg7RpNqfBhOXw1PWUGDwX2gzvUDK3TwiuIVy48lM8avHF87c/e4DUQW2gIo/tKQNMu00Z9QonPpGblCSEvXjNw0+9D60E+xkz6T/YV+kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOMAxD/YI8cfSEVyT78MC+rkSYdQ2h5Pwv0eLXMzoWU=;
 b=f+SpnsxGAwoc1vvU+fqWx/0wsq7dOc49FYoEOnhGiTXvN2YiIqihgL4auEIGtHV9t80bxbtyiqwNZCwFJKqkdi9Ts3dIlIrpZMvihKfEyaJ1ig7b051MrwijBDQRKGCpwFYuH5Se2yFrko76I9cq/Yw8AwA7Fy9XeP+dWk+HFBWGK21Emr7WDQdC37zHJEdWP1ppb5sDkYcFRHGpThs35J/BXrkkOnV2pD9IFOa9hkKy6+Pxg4M/jo8V+s3GYOmP45PsLNFrk+FwPwlBdSpOegaIe/N/yk0VhLLzX5cZNAKOTVhgmaGpQAGk8q2k2O5v1tvwP07z0xwZ9y00cMngbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOMAxD/YI8cfSEVyT78MC+rkSYdQ2h5Pwv0eLXMzoWU=;
 b=Mctjw9I3rRphdwRGlFQERz/ItYcG6jB4RajcoHrayVk+/MCDOpK8Ks4qmd72/IUpsbRABYsf2YDMuzyPreGcLwCv5LdyeGI2v7CcADO9Yd7jmYQlhPiZngbJgKbM2GH1LlZzqJIzktLGdw0A1B9PqaDUgDADXU2UWQ2cAasLTvk=
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6)
 by DS7PR10MB5951.namprd10.prod.outlook.com (2603:10b6:8:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Sat, 6 Jul
 2024 07:46:19 +0000
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::2cd7:990f:c932:1bcb]) by SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::2cd7:990f:c932:1bcb%3]) with mapi id 15.20.7719.036; Sat, 6 Jul 2024
 07:46:19 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: Greg KH <greg@kroah.com>, Chuck Lever III <chuck.lever@oracle.com>
CC: Calum Mackay <calum.mackay@oracle.com>,
        linux-stable
	<stable@vger.kernel.org>, Petr Vorel <pvorel@suse.cz>,
        Trond Myklebust
	<trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-team@fb.com"
	<kernel-team@fb.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Avinesh
 Kumar <akumar@suse.de>, Neil Brown <neilb@suse.de>,
        Josef Bacik
	<josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
Thread-Topic: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
Thread-Index: AQHazKCTYoZ2RW6MYU+Ymy9Cw+3zaLHkDKAAgAQmwwCAARqwgIAACcsA
Date: Sat, 6 Jul 2024 07:46:19 +0000
Message-ID: <E1A8C506-12CF-474B-9C1C-25EC93FCC206@oracle.com>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
 <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
 <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
 <2024070638-shale-avalanche-1b51@gregkh>
In-Reply-To: <2024070638-shale-avalanche-1b51@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7082:EE_|DS7PR10MB5951:EE_
x-ms-office365-filtering-correlation-id: 761745b9-ebcb-4886-eca0-08dc9d8fb90c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TC85M2RJSWpnU1MrOWxqbzF0SEc1eUhWNUtCcjdxYXB5UjhIam1GNWlFZWRv?=
 =?utf-8?B?dStvMjAvMGVDbGxNdVF6V0VWWWFWZ2lpVXBOc00rdFB4Q2FhUTJvZnM4WG93?=
 =?utf-8?B?T2ZIRnMyZjc5SHZ0eHd3c25IdGRwMlNhbGdibUVvZzdXWTZuMTNXY3B1bVM5?=
 =?utf-8?B?bjNRUkxTZmNsVkplT1dIcmFzaTFScFBZN0tpTzZRS0QxZm01QW9wUjllUVUv?=
 =?utf-8?B?bUlEQ1NlS00zeGxwYitMUytCVitRaTk5UXVjallvTk1rbjlKODI0QlB1aEVx?=
 =?utf-8?B?VXpndGxyclh2LzJpYnkxVFJMSjJqVEkrRzhtUmNlZ1Zxc0RNcGVkR2wrMy9D?=
 =?utf-8?B?NmhLcGFLY2xWZXc2UkR3TlZZbmNReHJHRmN5aHg0Q3FXTGR6OHY2STlQQkpI?=
 =?utf-8?B?UmpqWWR6YmNia2FFRWdFa3d5VTJBY1RMMXArSlQxQ0RHUTc2dVdDSmkveWIw?=
 =?utf-8?B?TVBrd0xCdzBYUnd0eUFaQjUvalFCSmRyRUJVR212WUp3QjVJNVBQL0tQZksw?=
 =?utf-8?B?alEzSktRK3hpVVFjcHJybVRYV0pYaFlubHY5RTVVU0VTZlVUVCt6cWFncmp0?=
 =?utf-8?B?SUNWalR1Q0phZFhmQzI3alJWcCs2UXVGeU80UmtDWTBTeUlkdGNoQnlJREw4?=
 =?utf-8?B?OGpxbTZBNU14Vy9FNHBiRjdKME5NeDZmZDVSeVVOdHZ4YzZ6WGpzdDQ0a2U1?=
 =?utf-8?B?YmJmZHhkeitTbC9EUHgrV3MwcDNFYzFJNVNDMmVqRVQ0ZjM1NFgzT0pwQVJB?=
 =?utf-8?B?MktqUEdWa2dUamljc000ZlV1a0NyemJHRWtJeUhJRFZxdXhzZXVCQVpxZXUx?=
 =?utf-8?B?dDM5MlZaQWowdTZWdXNnc1R2VjI2R0hBbFMxcWpiL1h5eStNS3lhOXFMVVZF?=
 =?utf-8?B?MGMyaDlIYThDOUs3cmhadFFVOU16UFNXczlmMVJ5RVNFeEdQR092aHpLaUlk?=
 =?utf-8?B?cUJoWkE3ckI4Zmg0U0RPUUcvMGxtdDdnSGlPSGkzMGxTK2ViRTJjMkxYZkhT?=
 =?utf-8?B?SVRvV1VQcGJWaWhQUGN4bDBObXpnWWRtZ3pQUUplM1R1am4zcUZPVWdoUXdp?=
 =?utf-8?B?R2ttWUlBN2NBMFRaL2pjekhRNjdjVWd2YW1weEV6U3RYYVhMb2pkL21uVVk1?=
 =?utf-8?B?NFpxTTZLK2hkQXR3QTNSTDl5NllsMUdtNStpTXV2MjVZZG5WczdQNVhzbDRW?=
 =?utf-8?B?aHE1WHdyZUlKelVROXRGTUV6WmxtU2lVNE54RGNlWXFWRHRtTGMwSkFSQjhi?=
 =?utf-8?B?MzZTSno4Vlh2WnREK0RBSGtqb1VCbGNhOVllbTh2TkxBM2pnZFM0SVZGeUR3?=
 =?utf-8?B?RG42ZExmMHV3bkw0QnMvZ01SZTFiSDJFcEZPbVMzTHRZSVFEZHE5cUFReEJX?=
 =?utf-8?B?U1ZCQTZFOHVaZUE2L3Avc2xseGF6d0MrVU1hKzdKbms4UUl4dVN6T3BLVTdL?=
 =?utf-8?B?SURHY0UrVlZCNTNpVG1CSXBJRjFVL1hEMEszTWJrdW94S0ZiRjlqSzFiUG54?=
 =?utf-8?B?Z2FSWTBxT0NNQ3BMTVVZdkNGVkNtTzVMalJHTG5mRTBaZHh0aVd3OURMWnRl?=
 =?utf-8?B?WGJTZ2FQeStZekJHNVlxTFRMRDJPZ3RHQ2gzMjVRVkpQaGtxQ1NUbUxFSjRz?=
 =?utf-8?B?ampEb3FEak1Yd2lJMGwxZzI5NnRLZy9ZVDZTQ1VyUEllWGx4MnJ6NVdIa3E1?=
 =?utf-8?B?bXJxU0hNcEhjL0dMS1puakhFb0hhN0MwVjA1OGkxSGk5bmZwayt3UHppcGo5?=
 =?utf-8?B?N0ovQS9JNDFXbDJGZXNSTlEzN3kyalNFNkhTMFhtK1lwYUhkMmdwVTBneDdC?=
 =?utf-8?Q?RtUuIUN8wW45rVVZf9BOfukHZFW3beC0Zi3LE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7082.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dUZGZEZ1MWtLbFozcG42cFpsMGh4dlozS1cxblU4MmxQd1BPczc2a0tWbUZF?=
 =?utf-8?B?TjFnUWJsY3ozbm9JQUlvY1RlZmdPd1BQaCtoclNhTzM1UW5vNzZlNUV3QVNP?=
 =?utf-8?B?T3JobzR3S25qdFFWckVXWm8xQ3NSYVQ0UjFSQldHNGdycnBxRUI0TGMwQm5R?=
 =?utf-8?B?UTNPbmxkWTN0aGxiSGNxeCtMZzgzUjNHSFdBZlRWc1I2ZHBDUyt6Zno0aWF2?=
 =?utf-8?B?bVA5U2Y5V0l6U2NPU1FjeUZSeklYcGJydkcyaElGRlJPS0k0ZHZ2MHh6emwx?=
 =?utf-8?B?aE9YWHgvL3FEdmhBVjVZWU5mV0NjbTZNb1d6Nk85a0xGdHJjZkRITlAwajlu?=
 =?utf-8?B?UlRBWDRKczhDNmZ0ek56ZEtUZytRTG9jeTNEYUFSczkvV1l5V3hnR2s3NWVw?=
 =?utf-8?B?R2hiMEVoWFp3b0RnaGczdzNEMldTblhoOTNFYnJaVndNcnJQOFBzcVFDUnpX?=
 =?utf-8?B?bVZSbW1wT3lLa0NlRDZxUFUzVU5nMTQvR2x3QTQwZFQyTXplSHJucHFwdVJh?=
 =?utf-8?B?Y2Y5MkFRU2NDSTgxSzl1dkYydGJQN3QrSVR1S25VSkIxZUJBVzhzNGRvMzZI?=
 =?utf-8?B?SW5vYXZ5NkFGNHQ4VDMvdExqTlB0YmFNR0dsRjhiV09BZWNYZ2g4dXVjUVF3?=
 =?utf-8?B?SzNacGRIeUdsaWs1TFQydTU2Ti9oM1YxWCtFY0Q1aWg4VlhkeEtpSzNBYkYy?=
 =?utf-8?B?N3BqT2NIM3JGOVlLa01ybXdkSzdab2s1Qyt5ZFU2NGJIM1RZN1NVanFScmRj?=
 =?utf-8?B?Zi9aRlUzbGF5ZmhRaFZTblNvVnpqRHdZZWRNdkFrLzQ1VmdRaVl6c1lrQlVJ?=
 =?utf-8?B?eG9ZSHdWNTBWY0lIQVF0bGUwcmFjUi9kc1QxR0FhZzVPaDIrVTBQdFc4Z3M2?=
 =?utf-8?B?aktlYVRKT1RUYXVSK0dycXpTZitzWUhuNGhsZUV2OVVCRENUV01lMnR1ZEVz?=
 =?utf-8?B?bFVhNS9CdU50RFFHNVcyZUFscVRwUTBZR0JJU29tNExtNUpwRGhycWFPdWNs?=
 =?utf-8?B?ZjFGcnlFL2lkZnp1K1FXalBvSSswT1BzdGxJb054SjdsQ3FKY0FHbHUySWFW?=
 =?utf-8?B?a2hBZ2lFbnNOdGROZ0xPa2lrMzhSNEFWOE55NFJJSGJsUFFOMEV1RHBuY1hZ?=
 =?utf-8?B?dlNzcGIwdjlWY0pwZ0EreFVsU1JHTThXSkFCeXhuRkVYOU1VL0l4cHVLcFBt?=
 =?utf-8?B?cE82QXBoc1VwK2taT1pCV3E5Snd1YkRJeGxIK0YyNHRrT3E5bmJRNTc5ZFJC?=
 =?utf-8?B?V3ZOb1UzdStrM1BpWVRQQkNhdGdJQy8rdk1YcGRDakM4MVNiSng0bnlzYzBn?=
 =?utf-8?B?ZUZGQnNQNWR5aUYvZnVNWFo1dmhCcDFvK3UrRzN4R0pMOXQwRS9vTUhWRFUz?=
 =?utf-8?B?b1I5WWZQY2tDZHhMbjY5VzlOSGNucmZaZGsxWkRMUVl0YVVvNVN6RUlqc1Jk?=
 =?utf-8?B?clo5ZWhNQU1ocUd5NFErV2ZyZE93WDJSVmV0ZkhiWDU1NVkxc3FuYjI1SFlK?=
 =?utf-8?B?c1FsYXIzby9ZZlF5UDEyN29EeU42bGtYL2tXc0VLTWhVVUR2ZlRvaHVneWlL?=
 =?utf-8?B?YmRoUm9XcVRmakp1OWtzYWVUOFgrMVpCWlh3dnIwQTZ1Mm14QU5QTC9VNjJx?=
 =?utf-8?B?akNEeDN3eHZqMzgvZWtySzdpa1VkVHBkZEtPV09pMUhQL0VEeGltYzhyblFz?=
 =?utf-8?B?b2Njb0FHR29SdE41L1A0cHBOc3ZtV2cycWhubm1jK3NKeVlCNExlYlR4MVg5?=
 =?utf-8?B?N0l1cEk2ZlF6QWdoRjRTMFlIR3V1anpENy9JUGVPSDV6ZHVBOXFQdzJ4eUtY?=
 =?utf-8?B?TGFvWEpNMDl6SnV5VHg5cXRzbS9rc1ZGcEkySVdwZ2MwdXBWRGpiTjNWQnAv?=
 =?utf-8?B?Wkx6YldmZWhKN28rUm4xUXdSYTlCcE1SODF2WTJNaHdGS243TnQ1ZytYNGlC?=
 =?utf-8?B?MUY3d0lJQ21UMXQ5NEtmYnJIQ3k3RUpEUURiM1BMcU9pN0JaTHRaVFNuZTZ6?=
 =?utf-8?B?ZGF5ZjYwM1RadDNlckJwUjNqV3JkM2I2bURHVktScHhxaTEvTk5oOHFVb0NP?=
 =?utf-8?B?eWkrM1VBRWhHcGhaVWhpNEtBejBNTHIvUXlWeUFzWm5rZkRIRytHdWh5U0ox?=
 =?utf-8?B?T0hmSFBEZ0Z5UFZjaE9GRWF0cVJVTjRocHJHYXR2akhsczRTVkJoTUNqdXBL?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <643F67EA905B244F8CF2B4368C0B4CDF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/ddHcfrlryA+PR+YgPqzhJ+i5r6t3D7oVs/Dv8E3UiGpzgiujZMvWr7pVb5inowPeuxvwWTl9yn4s8IsvrDSB6DSPQQ4kYMACUZN4dS0/XPNo+j+rF8QksNUkc9r8hl9EYLAxU2FoBb+3hDPCUUgpAWg5FV/CmdxTlrblJhXVRPzsvrgScX7cv2waKM+M7M83MLlKL3tO4V3vI5KWncuLNtc+vAsfSNT/0hVePi2bVrDpzn2jHhnAuW6kyEPH+PHA7XTG56tX8+yCt1PDh0l6pKOJwzJ4JPvRUSFUgavQMtAZLnTAsXyWIaotmOavKdbii7xKshMtUOJDHaEW8hbip0kGaWCO314h+t2/k1IAlDL4HKCcLOUidpiSUQ5xNkfbUskmsBJVGHJUwVqntnrRgSs9mdZMxR7hShjusJcjcLC8VUKkMQl1VzG2QFA5Fov7XTdfLoanD1jlHfs5V/Ea7uOvMwxKeyv4dz9nc9mfn98+78v2ffOB0+FzeUkRLtAfI/4Lvcod9SgdLLkZqQZbJCa305ekaody8eMiVNciYirFerLOHCaAeGSkSvFxUDLHA4pL1r4q8T3Zo9vB49o+zBOn0jhJEb2/eCvCl9D/fg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7082.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761745b9-ebcb-4886-eca0-08dc9d8fb90c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2024 07:46:19.0269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRUfeFvyfdsbXbzZyRIXrA5saIGV/62F1iY1CAtJCL7+qO7TgSBqKaCZwOOQX+HAMATJBfKH/hWVrtiOaX2QOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-06_03,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407060057
X-Proofpoint-GUID: KEiiqYiAXnKn5NRBoCdSBusa-QR-qn9a
X-Proofpoint-ORIG-GUID: KEiiqYiAXnKn5NRBoCdSBusa-QR-qn9a

DQoNCj4gT24gSnVsIDYsIDIwMjQsIGF0IDEyOjEx4oCvQU0sIEdyZWcgS0ggPGdyZWdAa3JvYWgu
Y29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgSnVsIDA1LCAyMDI0IGF0IDAyOjE5OjE4UE0gKzAw
MDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gSnVsIDIsIDIwMjQs
IGF0IDY6NTXigK9QTSwgQ2FsdW0gTWFja2F5IDxjYWx1bS5tYWNrYXlAb3JhY2xlLmNvbT4gd3Jv
dGU6DQo+Pj4gDQo+Pj4gVG8gY2xhcmlmeeKApg0KPj4+IA0KPj4+IE9uIDAyLzA3LzIwMjQgNTo1
NCBwbSwgQ2FsdW0gTWFja2F5IHdyb3RlOg0KPj4+PiBoaSBQZXRyLA0KPj4+PiBJIG5vdGljZWQg
eW91ciBMVFAgcGF0Y2ggWzFdWzJdIHdoaWNoIGFkanVzdHMgdGhlIG5mc3N0YXQwMSB0ZXN0IG9u
IHY2Ljkga2VybmVscywgdG8gYWNjb3VudCBmb3IgSm9zZWYncyBjaGFuZ2VzIFszXSwgd2hpY2gg
cmVzdHJpY3QgdGhlIE5GUy9SUEMgc3RhdHMgcGVyLW5hbWVzcGFjZS4NCj4+Pj4gSSBzZWUgdGhh
dCBKb3NlZidzIGNoYW5nZXMgd2VyZSBiYWNrcG9ydGVkLCBhcyBmYXIgYmFjayBhcyBsb25ndGVy
bSB2NS40LA0KPj4+IA0KPj4+IFNvcnJ5LCB0aGF0J3Mgbm90IHF1aXRlIGFjY3VyYXRlLg0KPj4+
IA0KPj4+IEpvc2VmJ3MgTkZTIGNsaWVudCBjaGFuZ2VzIHdlcmUgYWxsIGJhY2twb3J0ZWQgZnJv
bSB2Ni45LCBhcyBmYXIgYXMgbG9uZ3Rlcm0gdjUuNC55Og0KPj4+IA0KPj4+IDIwNTdhNDhkMGRk
MCBzdW5ycGM6IGFkZCBhIHN0cnVjdCBycGNfc3RhdHMgYXJnIHRvIHJwY19jcmVhdGVfYXJncw0K
Pj4+IGQ0NzE1MWI3OWUzMiBuZnM6IGV4cG9zZSAvcHJvYy9uZXQvc3VucnBjL25mcyBpbiBuZXQg
bmFtZXNwYWNlcw0KPj4+IDE1NDgwMzZlZjEyMCBuZnM6IG1ha2UgdGhlIHJwY19zdGF0IHBlciBu
ZXQgbmFtZXNwYWNlDQo+Pj4gDQo+Pj4gDQo+Pj4gT2YgSm9zZWYncyBORlMgc2VydmVyIGNoYW5n
ZXMsIGZvdXIgd2VyZSBiYWNrcG9ydGVkIGZyb20gdjYuOSB0byB2Ni44Og0KPj4+IA0KPj4+IDQx
OGI5Njg3ZGVjZSBzdW5ycGM6IHVzZSB0aGUgc3RydWN0IG5ldCBhcyB0aGUgc3ZjIHByb2MgcHJp
dmF0ZQ0KPj4+IGQ5ODQxNmNjMjE1NCBuZnNkOiByZW5hbWUgTkZTRF9ORVRfKiB0byBORlNEX1NU
QVRTXyoNCj4+PiA5MzQ4M2FjNWZlYzYgbmZzZDogZXhwb3NlIC9wcm9jL25ldC9zdW5ycGMvbmZz
ZCBpbiBuZXQgbmFtZXNwYWNlcw0KPj4+IDRiMTQ4ODU0MTFmNyBuZnNkOiBtYWtlIGFsbCBvZiB0
aGUgbmZzZCBzdGF0cyBwZXItbmV0d29yayBuYW1lc3BhY2UNCj4+PiANCj4+PiBhbmQgdGhlIG90
aGVycyByZW1haW5lZCBvbmx5IGluIHY2Ljk6DQo+Pj4gDQo+Pj4gYWI0MmY0ZDlhMjZmIHN1bnJw
YzogZG9uJ3QgY2hhbmdlIC0+c3Zfc3RhdHMgaWYgaXQgZG9lc24ndCBleGlzdA0KPj4+IGEyMjE0
ZWQ1ODhmYiBuZnNkOiBzdG9wIHNldHRpbmcgLT5wZ19zdGF0cyBmb3IgdW51c2VkIHN0YXRzDQo+
Pj4gZjA5NDMyMzg2NzY2IHN1bnJwYzogcGFzcyBpbiB0aGUgc3Zfc3RhdHMgc3RydWN0IHRocm91
Z2ggc3ZjX2NyZWF0ZV9wb29sZWQNCj4+PiAzZjZlZjE4MmYxNDQgc3VucnBjOiByZW1vdmUgLT5w
Z19zdGF0cyBmcm9tIHN2Y19wcm9ncmFtDQo+Pj4gZTQxZWU0NGNjNmE0IG5mc2Q6IHJlbW92ZSBu
ZnNkX3N0YXRzLCBtYWtlIHRoX2NudCBhIGdsb2JhbCBjb3VudGVyDQo+Pj4gMTZmYjk4MDhhYjJj
IG5mc2Q6IG1ha2Ugc3ZjX3N0YXQgcGVyLW5ldHdvcmsgbmFtZXNwYWNlIGluc3RlYWQgb2YgZ2xv
YmFsDQo+Pj4gDQo+Pj4gDQo+Pj4gDQo+Pj4gSSdtIHdvbmRlcmluZyBpZiB0aGlzIGRpZmZlcmVu
Y2UgYmV0d2VlbiBORlMgY2xpZW50LCBhbmQgTkZTIHNlcnZlciwgc3RhdCBiZWhhdmlvdXIsIGFj
cm9zcyBrZXJuZWwgdmVyc2lvbnMsIG1heSBwZXJoYXBzIGNhdXNlIHNvbWUgdXNlciBjb25mdXNp
b24/DQo+PiANCj4+IEFzIGEgcmVmcmVzaGVyIGZvciB0aGUgc3RhYmxlIGZvbGtlbiwgSm9zZWYn
cyBjaGFuZ2VzIG1ha2UNCj4+IG5mc3N0YXRzIHNpbG8nZCwgc28gdGhleSBubyBsb25nZXIgc2hv
dyBjb3VudHMgZnJvbSB0aGUgd2hvbGUNCj4+IHN5c3RlbSwgYnV0IG9ubHkgZm9yIE5GUyBvcGVy
YXRpb25zIHJlbGF0aW5nIHRvIHRoZSBsb2NhbCBuZXQNCj4+IG5hbWVzcGFjZS4gVGhhdCBpcyBh
IHN1cnByaXNpbmcgY2hhbmdlIGZvciBzb21lIHVzZXJzLCB0b29scywNCj4+IGFuZCB0ZXN0aW5n
Lg0KPj4gDQo+PiBJJ20gbm90IGNsZWFyIG9uIHdoZXRoZXIgdGhlcmUgYXJlIGFueSBydWxlcy9n
dWlkZWxpbmVzIGFyb3VuZA0KPj4gTFRTIGJhY2twb3J0cyBjYXVzaW5nIGJlaGF2aW9yIGNoYW5n
ZXMgdGhhdCB1c2VyIHRvb2xzLCBsaWtlDQo+PiBuZnNzdGF0LCBtaWdodCBiZSBpbXBhY3RlZCBi
eS4NCj4gDQo+IFRoZSBzYW1lIHJ1bGVzIHRoYXQgYXBwbHkgZm9yIExpbnVzJ3MgdHJlZSAoaS5l
LiBubyB1c2Vyc3BhY2UNCj4gcmVncmVzc2lvbnMuKQ0KDQpHaXZlbiB0aGUgY3VycmVudCBkYXRh
IHdlIGhhdmUsIExUUCBuZnNzdGF0MDFbMV0gZmFpbGVkIG9uIExUUyB2NS40LjI3OCBiZWNhdXNl
IG9mIGtlcm5lbCBjb21taXQgMTU0ODAzNmVmMTIwNCAoIm5mczoNCm1ha2UgdGhlIHJwY19zdGF0
IHBlciBuZXQgbmFtZXNwYWNlIikgWzJdLiBPdGhlciBMVFMgd2hpY2ggYmFja3BvcnRlZCB0aGUg
c2FtZSBjb21taXQgYXJlIHZlcnkgbGlrZWx5IHRyb3VibGVkIHdpdGggdGhlIHNhbWUgTFRQIHRl
c3QgZmFpbHVyZS4NCg0KVGhlIGZvbGxvd2luZyBhcmUgdGhlIExUUCBuZnNzdGF0MDEgZmFpbHVy
ZSBvdXRwdXQNCg0KPT09PT09PT0NCm5ldHdvcmsgMSBUSU5GTzogaW5pdGlhbGl6ZSAnbGhvc3Qn
ICdsdHBfbnNfdmV0aDInIGludGVyZmFjZQ0KbmV0d29yayAxIFRJTkZPOiBhZGQgbG9jYWwgYWRk
ciAxMC4wLjAuMi8yNA0KbmV0d29yayAxIFRJTkZPOiBhZGQgbG9jYWwgYWRkciBmZDAwOjE6MTox
OjoyLzY0DQpuZXR3b3JrIDEgVElORk86IGluaXRpYWxpemUgJ3Job3N0JyAnbHRwX25zX3ZldGgx
JyBpbnRlcmZhY2UNCm5ldHdvcmsgMSBUSU5GTzogYWRkIHJlbW90ZSBhZGRyIDEwLjAuMC4xLzI0
DQpuZXR3b3JrIDEgVElORk86IGFkZCByZW1vdGUgYWRkciBmZDAwOjE6MToxOjoxLzY0DQpuZXR3
b3JrIDEgVElORk86IE5ldHdvcmsgY29uZmlnIChsb2NhbCAtLSByZW1vdGUpOg0KbmV0d29yayAx
IFRJTkZPOiBsdHBfbnNfdmV0aDIgLS0gbHRwX25zX3ZldGgxDQpuZXR3b3JrIDEgVElORk86IDEw
LjAuMC4yLzI0IC0tIDEwLjAuMC4xLzI0DQpuZXR3b3JrIDEgVElORk86IGZkMDA6MToxOjE6OjIv
NjQgLS0gZmQwMDoxOjE6MTo6MS82NA0KPDw8dGVzdF9zdGFydD4+Pg0KdGFnPXZldGh8bmZzc3Rh
dDNfMDEgc3RpbWU9MTcxOTk0MzU4Ng0KY21kbGluZT0ibmZzc3RhdDAxIg0KY29udGFjdHM9IiIN
CmFuYWx5c2lzPWV4aXQNCjw8PHRlc3Rfb3V0cHV0Pj4+DQppbmNyZW1lbnRpbmcgc3RvcA0KbmZz
c3RhdDAxIDEgVElORk86IHRpbWVvdXQgcGVyIHJ1biBpcyAwaCAyMG0gMHMNCm5mc3N0YXQwMSAx
IFRJTkZPOiBzZXR1cCBORlN2Mywgc29ja2V0IHR5cGUgdWRwDQpuZnNzdGF0MDEgMSBUSU5GTzog
TW91bnRpbmcgTkZTOiBtb3VudCAtdCBuZnMgLW8gcHJvdG89dWRwLHZlcnM9MyAxMC4wLjAuMjov
dG1wL25ldHBhbi00NTc3L0xUUF9uZnNzdGF0MDEubHo2emhnUUhvVi8zL3VkcCAvdG1wL25ldHBh
bi00NTc3L0xUUF9uZnNzdGF0MDEubHo2emhnUUhvVi8zLzANCm5mc3N0YXQwMSAxIFRJTkZPOiBj
aGVja2luZyBSUEMgY2FsbHMgZm9yIHNlcnZlci9jbGllbnQNCm5mc3N0YXQwMSAxIFRJTkZPOiBj
YWxscyA5OC8wDQpuZnNzdGF0MDEgMSBUSU5GTzogQ2hlY2tpbmcgZm9yIHRyYWNraW5nIG9mIFJQ
QyBjYWxscyBmb3Igc2VydmVyL2NsaWVudA0KbmZzc3RhdDAxIDEgVElORk86IG5ldyBjYWxscyAx
MDIvMA0KbmZzc3RhdDAxIDEgVFBBU1M6IHNlcnZlciBSUEMgY2FsbHMgaW5jcmVhc2VkDQpuZnNz
dGF0MDEgMSBURkFJTDogY2xpZW50IFJQQyBjYWxscyBub3QgaW5jcmVhc2VkDQpuZnNzdGF0MDEg
MSBUSU5GTzogY2hlY2tpbmcgTkZTIGNhbGxzIGZvciBzZXJ2ZXIvY2xpZW50DQpuZnNzdGF0MDEg
MSBUSU5GTzogY2FsbHMgMi8yDQpuZnNzdGF0MDEgMSBUSU5GTzogQ2hlY2tpbmcgZm9yIHRyYWNr
aW5nIG9mIE5GUyBjYWxscyBmb3Igc2VydmVyL2NsaWVudA0KbmZzc3RhdDAxIDEgVElORk86IG5l
dyBjYWxscyAzLzMNCm5mc3N0YXQwMSAxIFRQQVNTOiBzZXJ2ZXIgTkZTIGNhbGxzIGluY3JlYXNl
ZA0KbmZzc3RhdDAxIDEgVFBBU1M6IGNsaWVudCBORlMgY2FsbHMgaW5jcmVhc2VkDQpuZnNzdGF0
MDEgMiBUSU5GTzogQ2xlYW5pbmcgdXAgdGVzdGNhc2UNCm5mc3N0YXQwMSAyIFRJTkZPOiBTRUxp
bnV4IGVuYWJsZWQgaW4gZW5mb3JjaW5nIG1vZGUsIHRoaXMgbWF5IGFmZmVjdCB0ZXN0IHJlc3Vs
dHMNCm5mc3N0YXQwMSAyIFRJTkZPOiBpdCBjYW4gYmUgZGlzYWJsZWQgd2l0aCBUU1RfRElTQUJM
RV9TRUxJTlVYPTEgKHJlcXVpcmVzIHN1cGVyL3Jvb3QpDQpuZnNzdGF0MDEgMiBUSU5GTzogaW5z
dGFsbCBzZWluZm8gdG8gZmluZCB1c2VkIFNFTGludXggcHJvZmlsZXMNCm5mc3N0YXQwMSAyIFRJ
TkZPOiBsb2FkZWQgU0VMaW51eCBwcm9maWxlczogbm9uZQ0KDQpTdW1tYXJ5Og0KcGFzc2VkIDMN
CmZhaWxlZCAxDQpza2lwcGVkIDANCndhcm5pbmdzIDANCjw8PGV4ZWN1dGlvbl9zdGF0dXM+Pj4N
CmluaXRpYXRpb25fc3RhdHVzPSJvayINCmR1cmF0aW9uPTEgdGVybWluYXRpb25fdHlwZT1leGl0
ZWQgdGVybWluYXRpb25faWQ9MSBjb3JlZmlsZT1ubw0KY3V0aW1lPTExIGNzdGltZT0xNg0KPDw8
dGVzdF9lbmQ+Pj4NCmx0cC1wYW4gcmVwb3J0ZWQgRkFJTA0KPT09PT09PT0NCg0KV2UgY2FuIG9i
c2VydmUgdGhlIG51bWJlciBvZiBSUEMgY2xpZW50IGNhbGxzIGlzIDAsIHdoaWNoIGlzIHdpcmVk
LiBBbmQgdGhpcyBoYXBwZW5zIGZyb20gdGhlIGtlcm5lbCBjb21taXQgNTdkMWNlOTZkNzY1NSAo
Im5mczogbWFrZSB0aGUgcnBjX3N0YXQgcGVyIG5ldCBuYW1lc3BhY2XigJ0pLiBTbyBub3cgd2Xi
gJlyZSBub3Qgc3VyZSB0aGUga2VybmVsIGJhY2twb3J0IG9mIG5mcyBjbGllbnQgY2hhbmdlcyBp
cyBwcm9wZXIsIG9yIHRoZSBMVFAgdGVzdHMgLyB1c2Vyc3BhY2UgbmVlZCB0byBiZSBtb2RpZmll
ZC4NCg0KSWYgbm8gdXNlcnNwYWNlIHJlZ3Jlc3Npb24sIHNob3VsZCB3ZSByZXZlcnQgdGhlIEpv
c2Vm4oCZcyBORlMgY2xpZW50LXNpZGUgY2hhbmdlcyBvbiBMVFM/DQoNClRoYW5rcywNClNoZXJy
eQ0KDQpSZWZlcmVuY2U6DQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVj
dC9sdHAvYmxvYi9tYXN0ZXIvdGVzdGNhc2VzL25ldHdvcmsvbmZzL25mc3N0YXQwMS9uZnNzdGF0
MDEuc2gNClsyXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD0xNTQ4MDM2ZWYxMjA0ZGY2NWNhNWExNmU4
YjE5OWM4NThjYjgwMDc1DQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KDQoNCg==

