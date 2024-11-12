Return-Path: <linux-nfs+bounces-7897-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 716829C59CC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 15:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320D5284100
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F327C4DA04;
	Tue, 12 Nov 2024 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ehaSIjHC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oImAC4Xf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080001885A4
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420071; cv=fail; b=iOkeKg5UBDARLJqtTuJu+qefUN2EYTxx5ULJbAAR/biic08jwDyZ/iJF18G/SEV6u3bTSTYbXOEs4GOV5gNBhZDPbGuIatVUsKUfBHPgZr664KL/0EkSw+3dB8I40DsPAp2w+cZzlhRzwx8qNGGEGCZLsc4za8R/VWZ4SgpuZeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420071; c=relaxed/simple;
	bh=ti6gz+IbAmj2KWblWU6NrW/40D3+aZhPY87C/q4AKyc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GpGsnOAh0Ad9UhVa3LClDMfJQpHEnLg2ZX7WRuf3eCb/YpsTQ6VTIaD6sRRMrRAYci4D6f1VItA+H/NucsgaJT+danPy5QoQI3e6hG+8fch2uW3ze4/Asfjg2H8sbVS+Um17fAnckuj5x3dorO5AAndXWqi4R0wIksnnO1AGvoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ehaSIjHC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oImAC4Xf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACDBYxm004338;
	Tue, 12 Nov 2024 14:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ti6gz+IbAmj2KWblWU6NrW/40D3+aZhPY87C/q4AKyc=; b=
	ehaSIjHC2VEB/K3Dc37lLGth7OtULPEkgPW5EoASgEPNd5ZpH1STx3RIegWZRp1s
	E4ER1w1oZRHkG1ta9rD2JhKRgm3vVHtG/8JDVFVV8osaDtTlbb4yPRwm0oej97P7
	2LXk6SLI596H2OdY5Tm8+O0tMzrH1siAuHqv6JjamYfIiYMFskDHXncj5BYLk3wg
	dBK0Fls5SN98NmnCQCf1br2bPkTZa+0kTzAuyREgtXIUc0L4c8O7IPRmDXQ0m/Z4
	jH0CO/VwxhPKU/pKRptjeSFCb/LGtwM4Buf03g8co3c0KwOQ8ChHnQAX0KksrGSo
	kY8o26G3pxHDf+QDM75atQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hembu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 14:01:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACCU9gJ001182;
	Tue, 12 Nov 2024 14:01:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx686g8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 14:01:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQttX2guSnT83Ep0oyGB4TGuTg4YC7WnzPPZRME17h7G4a0FQOYw/ynhMIU3pEKsZC686kyEY3GytFTDuhUCU4Shiqde/jiHZVZn4OWS8h7fGc0aoXXysKoIfSs6RVGhpR1olvdQeRQCNfAgu2exdm3swpaTYwLtsWrsuzwbF6X+HT3752Wx7W3vOIz4hxvSUFCrGncUMEGmTORZmf+Q2ZNxPw2oFgg/QWLd+RjQiNQLcGR2QAuoTWl0Od3iHryd5DzHCDl2/9xet3DD1wQ7myevfzdlj6Ae7jXo2UlmrqgpZaXkHKTKZdX78FyIWQI6MdshdIwWLI+geNfJUKbXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ti6gz+IbAmj2KWblWU6NrW/40D3+aZhPY87C/q4AKyc=;
 b=IL7iD37qtbI+SSibPSy3sw12Gko/XurjrujpGg3O8JsiAPBUO/aisRMj2GgMdz1MAJ/PXa1sRvsRVqnWpmkUOaHP8D13j4IRqtoHt8KzfdYEWZjFyfXupnDcJaW3geLKSAvPH9b5Xeh/7w8cP7Fdfs0/4AxscYpitRcqMtrEme4qGm4m3jpbGFydQzoYGCaxMcB6+V0ygUrURyVnnG3rl/+DxH0ElP79HK7YazwM+9x+ARI5RGOBPnm5qahAr5fgxA1G6VDOKfyGf/uY+WQHe3PaRvAvmTDmudqFi5HYBb5MNCFg9arFY7hpob0hvLVsI5m1VMeihCsGjEHrDjAsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ti6gz+IbAmj2KWblWU6NrW/40D3+aZhPY87C/q4AKyc=;
 b=oImAC4Xfjpc14Qls3VEcWpp5lUjJZiH9pfRzzK4L+YEokyxrZE/KVCuVcvxH0UoL3zQzc8RgC2I1ydCL4pfv27hP/tlLxRARp722tUdtRN6VyfSLIbbnSAL0EFWEnQh1NnNmVQeuwq7X2QjsT+EQdcEZPFjfg8dDFa5LLNLbHOg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7954.namprd10.prod.outlook.com (2603:10b6:8:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 14:01:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 14:01:00 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Philip Rowlands <linux-nfs@dimebar.com>, Steve Dickson <SteveD@redhat.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Insecure hostname in nsm_make_temp_pathname
Thread-Topic: Insecure hostname in nsm_make_temp_pathname
Thread-Index: AQHbNIwe0SGaCBRrkUKLeTYSkr1wFbKzrXWA
Date: Tue, 12 Nov 2024 14:01:00 +0000
Message-ID: <2FDD029D-70A6-4F20-BB6E-10A0364FEF71@oracle.com>
References: <6296a7d4-64de-4df0-893e-8895e8ec36d0@app.fastmail.com>
In-Reply-To: <6296a7d4-64de-4df0-893e-8895e8ec36d0@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7954:EE_
x-ms-office365-filtering-correlation-id: 88ac2ebf-400d-4141-b8ab-08dd03227074
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zi8vQmRiMVlPVnRTNkRjRXQ3TllkR25qVTREdUJhMWpnalluWDY3b1pqLzBx?=
 =?utf-8?B?eEF3MG9GaUFYSnNGNHdhR2lOZnpQbVNBbm1hV2VJakZoNU94VDZYYS9vSmlV?=
 =?utf-8?B?U1d1ZFVtODYzcDZsZlZQTGgxT2dyMEFuNFUrajBLdk1WakFMaThEV1JubjBZ?=
 =?utf-8?B?YlJSY0haNCtXb3dMbTFGOTgzOW5CTkV5bHhWazI3Wll4c00yMFRXeHBRYWh1?=
 =?utf-8?B?cHZmeXphMXEvZmpWMnp4L1hTVlBhVG4xMVhxcHNUVE10cXMrL2czNFJTZ1Vh?=
 =?utf-8?B?SGd5d3BGR3JtRGpZT1lxOWU3K0NrWGk4aHlRZENtWHBuZUhKR3pwVlN6U3Qx?=
 =?utf-8?B?UkprT2JTdTJVZldrMHd1K3p6Nko0anN3eTdDaktrUHM5cHdxVlZnUWVGZVEz?=
 =?utf-8?B?aEVXZ015cmZjTEdsTmZKUm5KR1FQbHVHUFlubnNlZU9IdUwrQzJ3ZnFteEJM?=
 =?utf-8?B?dE82bzhCM3BlZy92ZVlMTjBpclRoOUdmSkE4a0JoZk9OTFkxYVAzb2dGTDIy?=
 =?utf-8?B?NlRLYnA5Y3dueHpmSU5mODgyVnVzWG91Zmh6NnhLNnU1YVpCdHpsbmdITTdV?=
 =?utf-8?B?SnhMUEtQalJKVHVIeitQdXlqc3NFREVLYTR5aGVHb1F2ZS9YQkVhSXpsRVNm?=
 =?utf-8?B?d3UrSDlWMHd0bFdVRUtQMjF0dGR0TEpvMWx6NUFub05NajhUWmNUR3Vyakxk?=
 =?utf-8?B?eStBanppSktBRDFZZVhjYlBWd3JrTysyQzNLNGVMallQeEN2RjBXOHpkVUhn?=
 =?utf-8?B?YTVZVEJBZWZsdExoaHdmVjhBL0VIYkZNZWVnVjNJRlF0REpVNDFkYUU3NXUy?=
 =?utf-8?B?VGhKZGYrR2hVWlcxRWxzclFhR0JKUUk4ZUtKcms0cFg1VE04VUpQTWt5WGZa?=
 =?utf-8?B?ck5qaXViNWk5cXFQNy9jMU43VFJmaDhxemtBTG1vcVVvaVdtMzlDamVxcFpK?=
 =?utf-8?B?ZGpIcmpvVURQbHpXbnlvSllsSTFENlBESkJzSFlBSnZxUzBoTk9FeXpVbXBh?=
 =?utf-8?B?VVVEN2M5bTdtNXhmTnNaeDNyblNYVkk4SCtGbW1nOVBaejU0UGk2UGxGempB?=
 =?utf-8?B?S0JaRE9WSEtiR1Z5Uysxb2ZVV29CemR6cW4yK1MyUDRQTHhIdjl4VmpiTDI3?=
 =?utf-8?B?OFNFeVMyblBUdXB2TFVjTElzY1F0cEhXaWs3S3h6WlZ5R1I3cjcwcXJyc01r?=
 =?utf-8?B?ei9taHdqT1ovTFpwMXdjUytMMExkV2NIRmpiM1ZuSWQ1SUhrb2pkSWlHMTRD?=
 =?utf-8?B?V1hNZzFnaExlU3MzSytoMCtIN1Fyb0lKZUNBd3Q1Y0p6ODF1bE5tUnlaL09Y?=
 =?utf-8?B?QjRBUEhQUE11WE1zcUxjVXFOeEMrRE9sa2F2M0IyRUVmZmIxMmI1YkNGRnI4?=
 =?utf-8?B?dHRvVXRkTFFpcE5iTzNzL3FaNkRuV21BMXZJRHBlUGN3K1l1MWpLbG5Pejkx?=
 =?utf-8?B?UE9qMzhpZHJPc3dsMEowV0czbmRmUTkyRmFYQ1o5YXRkMFppa25NZE9yWFZa?=
 =?utf-8?B?TGZHaHJ3eENubG1BWjd6bVVzRmdTZ2NjUTdTVVNmWkU3R2pHZU9mMlJSbUE3?=
 =?utf-8?B?Wjl6dWRDZDkrY1kxTWNLTWtJbWl4UGpYOFl5bk1xUFo3RHJyYStVUkIxMVdN?=
 =?utf-8?B?UitJUU0wN1U5aWxuQW40cU9iMldCTWVOdnpMODN1VlFGMGYrMTl3NVJKaENK?=
 =?utf-8?B?OEdNajJDbDZLdWdnMlNmSVBJaGNmK1IrSnBWNlZGSklsQWtnRnZWeTVNaHFI?=
 =?utf-8?Q?juf42qCuTHO5R8PP3pPZIlcxzfI1GAsLnLvi1Tl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0R0Ylhkd1FLYVRWaFhMM3BkYWgzenRBK0Y3N0Z3WU5hd09HYnptTWRRQlRu?=
 =?utf-8?B?Z05EcDhmZXkwN3c1MkdvOFV0VjluazlBYnVMeGF4RVZUWHZHVkZaREdPVVBQ?=
 =?utf-8?B?VlRNWlBJS1JmVVlQY3JaZkplbVB6dmNJZGhLWmN6a3ZldkhJN3dUL3dNUHl3?=
 =?utf-8?B?MWozYUdISnJwb0FTK0RRVkpsZmN2Q0ZjVk54WjB2a3I2WThVSWNNQ0FTYVVp?=
 =?utf-8?B?UU5YYmowZ2hBcjFDMGZYM1c4RlBzSkhQYVFUdkEvQy9PYjM0R3dtNmdpOElC?=
 =?utf-8?B?L0JnVzFSUlF5QTAzMUNCb2h0RkE1c3JNYUlNTWplVnFQZERNcENvY2lCSVFk?=
 =?utf-8?B?ZkQxTVhrYkNwNzlDbVhHSzJwK09vcDd5a2NQUVZXWHhxMFZTbVMzVVlSdzRL?=
 =?utf-8?B?QjRIMGtRTURrMnNETnp6VVhTcUQvL0YwMFVIMGRPRHhsK0FIb1h3SUJRUHgv?=
 =?utf-8?B?Y3NXY3dqOXZSUytpYnhVcG4wb1RuK1JEY29xNHNsMHdCbklJVEVGNnZqdnhT?=
 =?utf-8?B?aW03K2ZzZU9MNHpqeHhJWkE1bVRHVjh0blh1cUEwUGNmTEtSZlcxckNIVFhy?=
 =?utf-8?B?bUdvKzFwQW02ekllL1ByOWhhTFAyL2ZENnE5Yys2ZDkyTnJOL2l0QXc2d1hT?=
 =?utf-8?B?OWxzcmM1Z1Y5M3RlcVJ1Zjk2Q0doMjhqRTRUME94YTZPZXZGUFBXdUk5bVFz?=
 =?utf-8?B?a21mTHozSlM3SFhpQWlPSGx0ZHZ0UU53a0x0Skl0RURhd3V4VnNiZDVra0J0?=
 =?utf-8?B?VFUrdk40enE4cElZWW5IZjEyUUVDVkpGY3U5Sng3UHFvUW9NODI3OTBXSFpM?=
 =?utf-8?B?MTYxUWZ3MEtGaHRacHhTZkZ3U0k1LzdpQ3g2d09GaG5McjVyMVh5am9ac0pI?=
 =?utf-8?B?b2N0QmswZWJQTDYxU0JFazNMald5SU44TzBKOTVWbXhxNmNXb2diQmJqM3Rn?=
 =?utf-8?B?MkxFTy9QT2pabkFWNExXUW41alcrTWN2NFBDOG54bnFnRkNRcnFkcDZUSytj?=
 =?utf-8?B?bFJIZ2FtMGNYTDA2YWRqWUw4bGl3eGY4VXdLbWpkVlE0d0o3WElIRGNsMFJM?=
 =?utf-8?B?a0hZOXNYamR1N01yRlI2eElYN1BWNEtWZjAreW5VNGswaHlTL1haV211MlBZ?=
 =?utf-8?B?T054cjAzS05MQkRBYWFzdUtIa2dqdFllMEZuY0pFcGJCSTZ6Ym5Db29sSXlu?=
 =?utf-8?B?ZGNxOXdTdG40QnRzVUI0S0Z6MW9Vc0M0TXU3M1dGSTJ4bmozUENzUUt4U3Az?=
 =?utf-8?B?RDQ3dW9wTUZ4Tkp3K2dNWUNRYzZud2VMeUlXRERnTFFzaXJKZCt6MUhLa1o5?=
 =?utf-8?B?dkhiV2ZmQmZNalFrZjRDejlleGNKaFpIejc4cllEc2hUTWlxQ1pOdnZIbzBx?=
 =?utf-8?B?V2dZZ29nejQzUHdHWVh6dThQTW1GSzc5dlFxeUx2aXJ3TnVLc0hTbHZ6UzZa?=
 =?utf-8?B?K1pSYktyZHBQODlGTXhOQnFiSGhjL3B4SVcxbXpvamZYUXZDa2puTWQrNnZQ?=
 =?utf-8?B?VlRJWUFaTWRqM2hqenA0ZHBuQURiTWl2aEVnMWxGWVJPckFrb28rSHlhYVZS?=
 =?utf-8?B?Z0o3OHg5eE1acnQxYVJXUHNaY0tINnZQaXlYOTBhaWxaWW55d0RmaEgweXNh?=
 =?utf-8?B?NXVNR1hLSTVMK1RGWCtSYUdzYnBYUTVadkkvMnRmRnN2UnExKzlPWDhlTHFX?=
 =?utf-8?B?NmtRRVlLbVZGOWtEZkUrMWd2ZHlrR2FCQkMxWTdrclEvTU9FV0lrOTExbjR0?=
 =?utf-8?B?UzJDSUh4d0dSWVF3Q1Z2T2VxUERxN2F2TVVqT1hiRXVzYkhuRjQwYXlPZW1Q?=
 =?utf-8?B?cVJHVkNNekt2ZFYxdXFKelUwY0dqS0d6RUY0bU9SUm10MkpKV0ZIU0YxOTNx?=
 =?utf-8?B?Q0g1RksvQW5JSzdoRVlFMjZaVzNiYjdLYkdhQ09WY2tBQk5CbzRKaHBiOW9w?=
 =?utf-8?B?SzRUVlBqM3RGRjYwRHhUMXM2cTZjQVJTTDlyK29XK3dDTU1UbFRRNzRIcUJ2?=
 =?utf-8?B?T0k2dFQ1NSs0Vm9EL21VT0lGakR3RncvYzc0Ymtyb2tTY2lvaHp0RHVkSjhW?=
 =?utf-8?B?Z2JQWG9qNlpJc2ZJOUhwYmRJUnVZaEV0cmJTSnBZUDJzRFY0eE8zZURWMmVv?=
 =?utf-8?B?dFMvdWI5NDZzWkhWYTFVa243ZGFVZUpGWVo5aVJ1MnhLcE5SZWhZd2V5MGFV?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB906DBF633B9E4383E7134BA2F9F349@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B7EDgK5pkQ8bFIGe4qmlCz+HacSlhH3MDGuCtJV1pJzq14nCQPpPEhH8Lt82+vQ4qJsjwTD8AlRiEPrKTnL7VP4fVhv4rjUhLPpDCACUaT5tt1aURfyWmD8WKMwpI4fI4aqNADQIujadkvaaWB7aIiVb2KfbSssHxHZ4ErfcbxqFIf4/XbYk18V6DLElUkrd11Y/5j0wL7dcgeT5A+BaM2i/H/Sa4aHul38WEShuvN7lA+ystbZn3/w5Hc6ptchBlYgvQNI2INtRS1ga+Rco7S7eLa/aIlPhbkjLyZTqh7wGaJoJ8qV7dcyhCDw9zvvVVNmFyczL+VQnQRYK+wm7jraIvMWHp+GtBgqZeYdw6ADyQ6eQRhPsIYRttHyY6ew/sxzfUv0aE9TMxM2W9yn0OiPzFAgdQIMPatTEN18nynYBzZ1khoOWHdDI2kQ+bOwJW9CQBVBjEegsAhTW7kT4xXLrT4I/fTEsLJopdc/3BkWjZ1GXEWWVFPhG3AxMVmsUkfOEmSijyHiQTtGXsAOZ3w6WERzq/niFeVIB3TJgpafhZRvdurLvK7FcPG6By+OVMGIggVozD/l4QYgUtBHWm7y6FwD9vM1IMSnMQqgzsdI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ac2ebf-400d-4141-b8ab-08dd03227074
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 14:01:00.6832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3khaLEXuFsTXtqvHphZjGGsncWFEODi0eBeWet2N2ioCm9bfIphg2cUzyusaHJ7ZHL7heesLKsikmhOaNZWyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120113
X-Proofpoint-ORIG-GUID: 77P6pXN2dxWT4qmNU4gATnxjOFTbbSeU
X-Proofpoint-GUID: 77P6pXN2dxWT4qmNU4gATnxjOFTbbSeU

DQoNCj4gT24gTm92IDExLCAyMDI0LCBhdCA1OjQ54oCvUE0sIFBoaWxpcCBSb3dsYW5kcyA8bGlu
dXgtbmZzQGRpbWViYXIuY29tPiB3cm90ZToNCj4gDQo+IElmIGEgaG9zdCBkaWVzIGFmdGVyIG5z
bV9tYWtlX3RlbXBfcGF0aG5hbWUgYnV0IGJlZm9yZSByZW5hbWUodGVtcCwgcGF0aCkgd2UgbWF5
IGJlIGxlZnQgd2l0aCBwYXRocyByZXNlbWJsaW5nIC4uLi9zZXJ2ZXIuZXhhbXBsZS5jb20ubmV3
DQo+IA0KPiBTb21lIGNsZXZlciBwZXJzb24gaGFzIHJlZ2lzdGVyZWQgYW5kIGluc3RhbGxlZCBh
IHdpbGRjYXJkIEROUyByZWNvcmQgZm9yICouY29tLm5ldy4NCj4gDQo+ICQgaG9zdCBzZXJ2ZXIu
ZXhhbXBsZS5jb20ubmV3DQo+IHNlcnZlci5leGFtcGxlLmNvbS5uZXcgaGFzIGFkZHJlc3MgMTA0
LjIxLjY4LjEzMg0KPiBzZXJ2ZXIuZXhhbXBsZS5jb20ubmV3IGhhcyBhZGRyZXNzIDE3Mi42Ny4x
OTUuMjAyDQo+IA0KPiBZb3UgY2FuIHNlZSB3aGVyZSB0aGlzIGlzIGdvaW5nLi4uDQo+IA0KPiBP
dXIgZmlyZXdhbGwgc2Nhbm5lcnMgdHJpcHBlZCBvbiBvdXRib3VuZCBhY2Nlc3MgdG8gdGhpcyBh
ZGRyZXNzLCBwb3J0IDExMSwgSSBhc3N1bWUgZHVlIHRvIE5TTSByZWJvb3Qgbm90aWZpY2F0aW9u
cy4NCj4gDQo+IFN1Z2dlc3RlZCB3b3JrYXJvdW5kcyBpbmNsdWRlOg0KPiAqIGV4cGxpY2l0bHkg
c2tpcCBvdmVyIHBhdGhzIG1hdGNoaW5nIHRoZSBleHBlY3QgdGVtcG5hbWUgcGF0dGVybiBpbiBu
c21fbG9hZF9kaXIoKQ0KPiAqIHVzZSBhIGRpZmZlcmVudCB0bXAgc3VmZml4IHRoYW4gLm5ldywg
ZS5nLiBvbmUgd2hpY2ggd29uJ3Qgd29yayBpbiBETlMNCg0KSW5kZWVkLCB3aWtpcGVkaWEgcHJv
dmlkZXMgYSBub24tYXV0aG9yaXRhdGl2ZSBsaXN0aW5nIG9mDQp0b3AtbGV2ZWwgZG9tYWlucyB0
aGF0IGluY2x1ZGVzICIubmV3IiBhcyBhIHZhbGlkIFRMRA0Kb3duZWQgYnkgR29vZ2xlOg0KDQpo
dHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9MaXN0X29mX0ludGVybmV0X3RvcC1sZXZlbF9k
b21haW5zDQoNCkl0IHNob3VsZCBiZSBhIG9uZS1saW5lIHBhdGNoIHRvIHJlcGxhY2UgdGhlIHRl
bXAgc3VmZml4DQp3aXRoIGNoYXJhY3RlcnMgdGhhdCBhcmUgbm90IHZhbGlkIGluIGEgZG9tYWlu
IG5hbWUuDQoNCg0KPiBTdGVwcyB0byByZXByb2R1Y2U6DQo+IA0KPiAjIGNhdCAvdmFyL2xpYi9u
ZnMvc3RhdGQvc20vc2VydmVyLmV4YW1wbGUuY29tLm5ldw0KPiAwMTAwMDA3ZiAwMDAxODZiNSAw
MDAwMDAwMyAwMDAwMDAxMCA4OWFlMzM4MmU5ODlkOTE4MDAwMDAwMDBkYzAwZWQwMDAwMDBmZmZm
IDEuMi4zLjQgbXktY2xpZW50LW5hbWUNCj4gIyBzbS1ub3RpZnkgLWQgLWYgLW4NCj4gc20tbm90
aWZ5OiBWZXJzaW9uIDIuNy4xIHN0YXJ0aW5nDQo+IHNtLW5vdGlmeTogUmV0aXJlZCByZWNvcmQg
Zm9yIG1vbl9uYW1lIHNlcnZlci5leGFtcGxlLmNvbS5uZXcNCj4gc20tbm90aWZ5OiBBZGRlZCBo
b3N0IHNlcnZlci5leGFtcGxlLmNvbS5uZXcgdG8gbm90aWZ5IGxpc3QNCj4gc20tbm90aWZ5OiBJ
bml0aWFsaXppbmcgTlNNIHN0YXRlDQo+IHNtLW5vdGlmeTogRmFpbGVkIHRvIG9wZW4gL3Byb2Mv
c3lzL2ZzL25mcy9uc21fbG9jYWxfc3RhdGU6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4g
c20tbm90aWZ5OiBFZmZlY3RpdmUgVUlELCBHSUQ6IDI5LCAyOQ0KPiBzbS1ub3RpZnk6IFNlbmRp
bmcgUE1BUF9HRVRQT1JUIGZvciAxMDAwMjQsIDEsIHVkcA0KPiBzbS1ub3RpZnk6IEFkZGVkIGhv
c3Qgc2VydmVyLmV4YW1wbGUuY29tLm5ldyB0byBub3RpZnkgbGlzdA0KPiBzbS1ub3RpZnk6IEhv
c3Qgc2VydmVyLmV4YW1wbGUuY29tLm5ldyBkdWUgaW4gMiBzZWNvbmRzDQo+IHNtLW5vdGlmeTog
U2VuZGluZyBQTUFQX0dFVFBPUlQgZm9yIDEwMDAyNCwgMSwgdWRwDQo+ICMgZXRjLg0KPiANCj4g
dGNwZHVtcCBzaG93cyB0aGUgb3V0Ym91bmQgdHJhZmZpYzoNCj4gMjI6NDI6MzEuOTQwMjA4IElQ
IDE5Mi4xNjguMC4xMzEuODE5ID4gMTcyLjY3LjE5NS4yMDIuc3VucnBjOiBVRFAsIGxlbmd0aCA1
Ng0KPiAyMjo0MjozMy45NDI0NDAgSVAgMTkyLjE2OC4wLjEzMS44MTkgPiAxNzIuNjcuMTk1LjIw
Mi5zdW5ycGM6IFVEUCwgbGVuZ3RoIDU2DQo+IDIyOjQyOjM3Ljk0NjkwMyBJUCAxOTIuMTY4LjAu
MTMxLjgxOSA+IDE3Mi42Ny4xOTUuMjAyLnN1bnJwYzogVURQLCBsZW5ndGggNTYNCj4gDQo+IFRo
ZSBjbGllbnQgc3RhdGQgd2FzIGFydGlmaWNpYWxseSBwbGFjZWQgZm9yIHRoZSBwdXJwb3NlcyBv
ZiBzaG93aW5nIHRoZSBwcm9ibGVtLCBidXQgSSBob3BlIGl0J3MgY2xvc2UgZW5vdWdoIHRvIG1h
a2Ugc2Vuc2UuDQo+IA0KPiANCj4gQ2hlZXJzLA0KPiBQaGlsDQo+IA0KDQotLQ0KQ2h1Y2sgTGV2
ZXINCg0KDQo=

