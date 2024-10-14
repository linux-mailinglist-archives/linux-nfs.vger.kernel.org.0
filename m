Return-Path: <linux-nfs+bounces-7176-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D8599D8F1
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 23:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13656281484
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 21:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E692F1C8FB3;
	Mon, 14 Oct 2024 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VZzedRdl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZDQqPJyb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180EC156F44
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941076; cv=fail; b=RMOSSS0ZPHYoLvTuGTEDSNrxvB6MxYCSVXHOkP8MWvJ5BbBmIKS51+oYOYCDyfGYOKcG2vMIKFfPDGqeliTYM9R0L0B2YnIZHIBMjMV6Xp1ZM4qqGEPl/ARR7E3nSW4ruFc9Sv8FwbILFmQyrVGxRVeBQnm3Zdu6JQF3bgfrNyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941076; c=relaxed/simple;
	bh=v8U4DEoZf+cxEy2E+jQLYUJ10Y8t0TCFcoJJhUwi08M=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAdezruNX9dk0n1hY5+5PiP5Xvfh+u2ssdi6tjx0X7rXoG2fqcZzqVtq5IbZzevr4IcoSYdmWehyAL5ckdxh+8+FqMpXVwV4/ed+pmm4+53UVfnAjZ3tGUHVRa0oXwiNNrJij0EMzU4cz6iBf8oZtc4lSq70qVR6YZ9+nZkxn5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VZzedRdl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZDQqPJyb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ELMdJ8003414;
	Mon, 14 Oct 2024 21:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=v8U4DEoZf+cxEy2E+j
	QLYUJ10Y8t0TCFcoJJhUwi08M=; b=VZzedRdl1/bLXpvmma2kXTb9eQxU6kQEbR
	Cyo7R/heXt/c6CP6Gj4fyRpdbzCEFIEsXt5VMAfKN1uh/n76KRfqn3jPHgFawlae
	pdxIpDqCnUZ9VcGoliVgL5CDhNMkfPWxysPW2cFGJeU5jnIWBAqGdEj3QSpiQirc
	g0ERyX5PV1K3cCflIzf2IOQxVtgNv9u2gu1WNDvd5YOal/FcfKjaxvTgVoQOi/Ez
	KbqxLQLNHtkOHlf9IXFJ2LTG5WBolShBPfFU0PzAr7AjVuQjmVmuwdsUPGtT+Uzw
	HegGSWmjqJPoIUK7oil83CiIMy7CJLRqm2mE/VBT9c3uq+C9ZpdQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhceyf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 21:24:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EJZQ6m027154;
	Mon, 14 Oct 2024 21:24:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjd4f6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 21:24:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FabEhuuRyxBcjTcnBnPll4EyfZ8R6Sctud/UZfhhG7WgsA6CgscBHIYrR/hvHiNx/Pb6U66R4nrCE1wmF7Pekv9Ttts+cZty3QcHAfPDjDJkzMmvyGXYeRJqnBO59xBiNHRf10kVMnYtZhiPqpXmjqZsNVCCOcgB5RvDzksrJbn2Y9TN0yW4EE4pOY7ZJpT9ff7CY/3JcUobxVfTragayr8np5adrS6sRhL0lWOjcIu0qlgzAQExHAx9eenSCHd1Xo5krr5XJcCKBmMAVZ3gLUsn3M4YozdjmCpMx7DOCN4H3i3kY0pjgsFwzAEujM+w66vHZ05wsCWzN+fb1tLOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8U4DEoZf+cxEy2E+jQLYUJ10Y8t0TCFcoJJhUwi08M=;
 b=qjnYrFPO3B7giR9t6SA4e1wkK0JTHepqniBQR+z486AeC/LcCYcg1Vbvm8428IHEOxUCqdee/wInKOn/+otPoyY3mbsmRG2CrwXQQQWBk4gFcTYKeaQ3Np1kcZZKMtsXtCV0fhFWeG/d52ufYm5IV1EP9IQ32nGDrhXXL1wAslB31+hqjDO8SPVudYI/apZXkdlwop75zUzJx8K26N4E1ev3K0YJi9NsvI+PYdiE2PseCOJJdWSZTu/T9KKCBYvE+0ob61w96k004Kx2xCHbQE7kP/t7NDrkV2FDO1bSksFuKvJYEr4zw7yctmM3pZsmmxKKQSZ1tFtJJS3/TAa9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8U4DEoZf+cxEy2E+jQLYUJ10Y8t0TCFcoJJhUwi08M=;
 b=ZDQqPJybnisGJxgfZ8pRstuOt3wCOepQgqIJks5KMV4oYvSzEXXe2d3QcDKrwYkEY9Ar5cz9LPE2RlzajLoDXJ70I7QHcrc+ayHK4g9jZovIVVLl4xrm2XRNj2mUSOBBlO7YTgEBLzxljWD02eIfaQr/Wzv0Z4In1HyRmlymt9g=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by PH8PR10MB6575.namprd10.prod.outlook.com (2603:10b6:510:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 21:24:22 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 21:24:22 +0000
Message-ID: <0c3da60c-1868-4de3-b72a-18520713390b@oracle.com>
Date: Mon, 14 Oct 2024 22:24:19 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH pynfs v2 0/7] pynfs: add CB_GETATTR tests and tests for
 delegated timestamps
To: Jeff Layton <jlayton@kernel.org>
References: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hAnkE0dG9tFGd0JipiXG4ODF"
X-ClientProxiedBy: LO2P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::34) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|PH8PR10MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3cafd9-5046-41df-f482-08dcec969234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWlubld6TW5NN2FWYloxVFlYa2kwU2hoQmROZFFZalEwZTZMT1VkNFVpREpU?=
 =?utf-8?B?NHk4UmdySDd5OGRJL292Q1ZQS2dhT2pibUxXOWVvUUtkRzlhZmlSeTczRTVl?=
 =?utf-8?B?dlFkS3RvZkFrREprZWtPN3NiTzNSM1JJTFY2NEptWmltQ0U0ckYzOGY3Y0JR?=
 =?utf-8?B?dFB0bTl2dTVyeUovUUlDMHNUS281TEE1eUtmZFpldHZlb3E4dnVDU2h0QWhK?=
 =?utf-8?B?UGx0S1h1eGt2Q3BhS0R3ZFdpbHdMUGtBRlFMbS9iNzlLazVJSDdFNkZRYnVF?=
 =?utf-8?B?Q3FVZWNIbWZPOHVaN3VTWUd5VDNYU1Nlb0luRnlNaDJlOHRaeXFENTR4eGMr?=
 =?utf-8?B?SXh1VXpFQTdIazdVK0VCK3krSlNnVWtMUGQyODlwZXZKWWMyQWszZDlOc2JF?=
 =?utf-8?B?aGpVZUhYVy9OVEFxQUNpazVmU1ZidDNaNVJrcitqc01ZQ1MrNUxsN2FVeHdy?=
 =?utf-8?B?VlQ5c1hOTHV1aHNwR3QwNGhYVkhCV285YWZtcytsOHJyNWVKU2c4cng5Zkx6?=
 =?utf-8?B?Y1ZhVFdmZ2h1Q0VYd0JMRnpkeXkwSHZaMVNWZVZ0dVhTdWJjbm5SYThlVm1E?=
 =?utf-8?B?dmx4WmdaVlJBWGZEZ3dIMmZVbVFBR0RKNzhod09UaEhDd1FVenlXejJxNFB5?=
 =?utf-8?B?cG43WTZ0RTU5MVFxdDcvUWVSYnBVTHN2Mi9RT1JRNWJEbGlvY01CWVBjaFM1?=
 =?utf-8?B?QnQvaTRWcFJRQmlkdS9pdlhKdU10RWxaOFBwS3h3N2hHYXhsdXE0VnFoTVA1?=
 =?utf-8?B?Y01ub1IrVFdZSGJOdm9ReExmaUFwc1I0SExwYThwSnBYZ0RyYWlpVWlWc1pJ?=
 =?utf-8?B?QzBoRXZ2VFprZm9SU3BVQjUyaGVNQXM5SVEyZUdzekxWaEh6N25GSjUrVmxB?=
 =?utf-8?B?d0Z0eEtENjFSV1NiWjZMZ3VNWFZqd0oxQlluTnFuVUt0VlQwTHhjbytwOGR1?=
 =?utf-8?B?SERJTkxhWXMwRFQ5VGFBR212WGU1U29Qc0FZcDA1emMrZU5aTzhldUI2cjFu?=
 =?utf-8?B?LzBKbjAwdUJkdXE2TGlzZXY1YXNyQWZxREVIOENhUkVGdnpuek0weGY2ZUc4?=
 =?utf-8?B?WExmZHZjdjRSWm5QZEpNcEM4VmdIb1lmUE5SVFFDQzZjTGZLeGMraTV6VWtJ?=
 =?utf-8?B?UUVzcnNhSGRIRThlZkVyajNveHRUYnkyOVo1TmMvdnE1R2pUUzB0NFRKZklX?=
 =?utf-8?B?YUpHbTdPbTlQMjV3dHpDK2pVU2h0UVpFQ2hyUkJKYVA1YVdoV0REZU1adzJ0?=
 =?utf-8?B?dCtQd2k1K0lva08zc0Z6Rk1RZUxZZko1NHY3WGc4cFNmMVROcUNobjlCSzA4?=
 =?utf-8?B?dCtURWZLemRyVWc3ekpaWGpGa0xWRC9qTlVVNjhwSlkxYnNQUUVFQ1NOb2w4?=
 =?utf-8?B?YmNWeDJGLzg2elZyeC9HYStlbTQ1bnA5aDlLMlVVZFFZVXpZQXlKKzBCOUkz?=
 =?utf-8?B?cDV1enBtVjUyWFZIcXJXMStEc0NOQUs5eUVGbGxxRU8waEZkNzNwOGVCNm1l?=
 =?utf-8?B?N1RxbW9iYnloUC9mUHM2b1NaMGZSVDdBb0ZtN1E4SlUvSmpKczNXWTNsbjVP?=
 =?utf-8?B?NlFYdUdYaFNJbmZQODVEcWplN2QxVGJNdWxQK3dXa0NPME1KTTRVMmxsWFp4?=
 =?utf-8?B?SzRORFhlZUcxY0FqemFOS1Z6MjJYNXU4TDNubUU0dGRwaGRrRnRIWnk2bzhW?=
 =?utf-8?B?SW5PeVl3M1RabDlaTzFublB2UDFBVWVRK2twT0hlU0tEVENSbURxeDBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajFUS0ZnSURObmY0Vm9qWUdkdXoxTnBCUHd6MzVyTFpzUXpEdjMrWnN4WXdB?=
 =?utf-8?B?OXBDOHlleGhldjVDM1lFNmd3czBvTEdpUlZFZzJmZVQwRW9wck1SY081cW5Z?=
 =?utf-8?B?MVdOTXZWSHduNXRWV3BDM0U3TE9OZWo0TVdLUUVTS1FTb0FrWG15amVTSWNa?=
 =?utf-8?B?Snp4Ym02djdsSWxYN3NDUERKdE5wK0ZaNWFHcHFlVzVuc2lqc0w5SStUNTRE?=
 =?utf-8?B?M0thYW5kclFMWEM4MzJNRVY5MUJDeHo4ZHlwS1lid3FFMGtVNURmbHRZdHVk?=
 =?utf-8?B?bVVnZ3RRZGoxSkNiKyt3T0VNbkNuNWsvQmRJZGxPU3JDTWlTWmpMZGs4MHdt?=
 =?utf-8?B?c2N0OVB3RUkvbDkvcUN5WWZhankwazZpTDAwNG1FaWQ5UWY5eGdZVStFL1lQ?=
 =?utf-8?B?d21FMnJSYXFvSitlZkZDTTQ4MUxTS1NyZjNQbU8zbzViQzZDSXRHbFR6R2hx?=
 =?utf-8?B?ZHpaOGJ0clJUZnVzRWdJeWhQZDV4aWFEQ2QrLzRJNml1SU85cnd4cjRiZVdD?=
 =?utf-8?B?YURWMjhqZDlPajV6ZkJZeUdVUWdncDZ1d0d5MCtuM1dQYTkvVitvZzB0Sisz?=
 =?utf-8?B?bitPbDVSTVJnSm4xcTQyNzd6eGM3M1prbDJjaUhTeWJqdVdLeTExZFFFQlk0?=
 =?utf-8?B?STgwU0ZqY1FyU1VOVm5VNDdvbFpZMG4wSWRCbnVXcHJncHNHeVllWDRtd2dV?=
 =?utf-8?B?WUZmTmlyeDNGaXFlWjE5dFI5U1lhK2pBRWxNZEZ4bEo1OGhqNVRWd3NpOGtN?=
 =?utf-8?B?Vmx4YzhsdDEybXN2UXNQWVdJRkxtMElQMmlqSzl5NDk4UmVlZlc3WmRTUlpE?=
 =?utf-8?B?QmVBMXV2SlZtM2lacU1TUTlKcXppdUswMWpOak1ISGZFYnJDQWVndTRLWnFW?=
 =?utf-8?B?Q0JLeU96dWgzdmxId3A4dWhjRXB0N3VIU0R2RyszQTQxaHo3OGN3WXpmTUNq?=
 =?utf-8?B?S1AwTjE1S0dCMnRRMElYd2xNTyt2WlQvcWlSeEh3dk5VUko0NnRtM29rbkRt?=
 =?utf-8?B?dEdYSEVCamxzTVNPK1VlWm56eHhqbTBSZTZFTjJpeUtudC82UGJ4L2g2MjRF?=
 =?utf-8?B?bWZ4elVLZTZ3cVllZ0JhN3gwQ3krV0s3WEtReVV3aVVJVXprd3Ayc1k4Ym9F?=
 =?utf-8?B?aGgraXBwd2h0c0hKcWVSdWlIQ2NqWHpERDV5M2s0YW1XTmNUSWlWZ2pvYkhF?=
 =?utf-8?B?SWhFeDA4bXc0WHQ0LytzcU1nRyt4Wnh6Y0QxZkRrRlhkbEJyS1Z5bmNBU0lz?=
 =?utf-8?B?QTJoREI4WlRaeE5JSzdpdWt3dk9ZS3YxOGkwaXlqRERwbkcwVjR2M1BKTXZZ?=
 =?utf-8?B?dFpLeWhCT29CQVY2TU9zSFVxMTVjNkk2K0gwRENFMVNmdWZYemt0Sm5tSHd0?=
 =?utf-8?B?eCtyWjJhQVdJMDhPd1VlelpOSUpBdnVXcitrb2dnNk9rSnFtdEEvK3d2VVdR?=
 =?utf-8?B?eDB0V2dyMUFibUxQTTZNZitxeWxKWkZYYkZtbkU1Qktzakl0cXhjZnRZMUJP?=
 =?utf-8?B?dmZUTkdVNDMxMmljR01nd250bGVJMG5OT0hSTE9Rc29GeDBsREd2b09ySTZ6?=
 =?utf-8?B?S2REWHNoemlHOFQ0YklMdFlZcjBNcU5oemhSUUdxeUZwR3BIWVlxcVJPQUFM?=
 =?utf-8?B?aDlhTE1uVXFkTkNjK1p2MEpyVytKcWtGTm1YaFp0dzN5SEJ6a3hBdCtWYnVs?=
 =?utf-8?B?UWJWUlRaakdENTJmVjZ5WHJFV3pYbHRtZDZndkhsZGEweGRLYzhqaEpaaXlV?=
 =?utf-8?B?VCtrOXZYcEo0Zm9FR1dzRVZ6QnA1K2g4QXlORklJSy9oT2x2NXE2K1hyUSs2?=
 =?utf-8?B?QVFwQzNVNE1EUWM0KzRySGROUXZYWXB4VTVVUyt2ZTk1dDAzazA5N2RtVHZz?=
 =?utf-8?B?Z3c3akF0SW5UcGt5MkNIM241dHdjUmZMc1d0eENVdWNXYnovbUU2S3V5Kzdp?=
 =?utf-8?B?bUx6bkdlM3RYOGkrZWcxYjRyQTBKT0wxWXhyQkRMQ292MVpuVVBvcHBrR0h6?=
 =?utf-8?B?aE5pK1BJOUhEUU1FRlNMWEpuaXhyRE5TdS9GcTJqSzZyM0I5MWE2M1kxRFU5?=
 =?utf-8?B?TG9obWVqc1R2VTBVVGdXQ0paclNVOE1wNEU3M3dOR1dmNC9TNm1jeVNKQStL?=
 =?utf-8?Q?uPwtFDKry200NAb9gmAR/neZs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jAHgEiWRPpfC2twTg8h5Mfy+Qv+GGA7pKJjz/ufemWnyKn2R9wiylle3HJZgy4Bu5gm8Lvm6OIwreRu5Q8pcdqD+DWjLSNKYgPesVkzOJzF1XCRzaVwQkvf1EPTRIN/msQ2LSlYuJyTQWyhKye/DHOvFdluM4qz3Ni9KsU/QNyQfw59HgDZ0KYId1dbmyLu46RXP5N/tx3YOwqHd5eKLXorFYQZhhs2eWcqMNd62IUdNc4eJfDApeO8sim9VOZUxF2HEijN7kPH2zqTYYZD6rnNn04SpOCa/4tXqFnSu5I/OWtMpOTD5Qn553TbseaWRq2igAKHZoW7Zo8+4ZNhH9GbyRvDT+Wdavuf71VTK+7d55x4sL19/k+INHdiXJFIjlUB05xP8eLF91tnKFxDls0r+LYBdtuYM9sZvzWtsUWW7MyvPjP4DUpSTbAYpoLv/Q/jFuq0Rmec8eOPnYMVo2cGeDat0mcQhqQ79p4Qd9uar+1OWkO0/JMPBeB91F700E/SPT31zdjg5qZA8PxLftGDNbR1VihKkmcYojI8MaSBZBXL5U2a3/mrlL+VF1C+M7OgOUYwR9E6JiIXL1bExj3x8k6g8lfa0ZY/637KLiKg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3cafd9-5046-41df-f482-08dcec969234
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 21:24:22.3576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRF/ipEuq/4mHOeqWfGsWk7CC8Eq5SBG+X6bCJskA6lXc2nRP7aeWmej0apmPfy5lfS27uqBwSNFqlB9Lh67WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_15,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=859 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140152
X-Proofpoint-GUID: l9vOv-411TEoUOUnpBUCS-u8R47WzbpJ
X-Proofpoint-ORIG-GUID: l9vOv-411TEoUOUnpBUCS-u8R47WzbpJ

--------------hAnkE0dG9tFGd0JipiXG4ODF
Content-Type: multipart/mixed; boundary="------------8ckp0IgWJCvV2s36z08k03F2";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Message-ID: <0c3da60c-1868-4de3-b72a-18520713390b@oracle.com>
Subject: Re: [PATCH pynfs v2 0/7] pynfs: add CB_GETATTR tests and tests for
 delegated timestamps
References: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
In-Reply-To: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>

--------------8ckp0IgWJCvV2s36z08k03F2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

dGhhbmtzIHZlcnkgbXVjaCBKZWZmLCBhbmQgZm9yIHRoZSByZW1pbmRlci4gSSdsbCBsb29r
IGF0IHRoZXNlIHRoaXMgd2Vlay4NCg0KY2hlZXJzLA0KYy4NCg0KT24gMTQvMTAvMjAyNCA5
OjUwIHBtLCBKZWZmIExheXRvbiB3cm90ZToNCj4gSSBzZW50IHRoZXNlIGEgbW9udGggb3Ig
c28gYWdvLCBidXQgQ2FsdW0gd2FzIG9uIFBUTy4gU2VuZGluZyBhZ2FpbiwNCj4gd2l0aCBz
b21lIGFkZGl0aW9ucy4NCj4gDQo+IFRoaXMgcGF0Y2hzZXQgYWRkcyBhIGNvdXBsZSBvZiBD
Ql9HRVRBVFRSIHRlc3RzLCBhbmQgdGhlbiB1cGRhdGVzIHRoZW0NCj4gdG8gYWxzbyB0ZXN0
IGRlbGVnYXRlZCBtdGltZSBzdXBwb3J0LiBUaGVyZSBpcyBhbHNvIGEgcGF0Y2ggdG8gbWFr
ZQ0KPiB0aGUgbmZzdjQuMSB0ZXN0cyBkZWZhdWx0IHRvIG1pbm9ydmVyc2lvbiAyDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPiAt
LS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBjaGVjayB0aW1lc3RhbXBzIGluIFdSVDE4LCBh
bmQgcGFzc193YXJuIGlmIHRoZXkgZG9uJ3QgY2hhbmdlDQo+IC0gaGF2ZSB2NC4xIHRlc3Rz
IGRlZmF1bHQgdG8gbWlub3J2ZXJzaW9uIDINCj4gLSBoYXZlIERFTEVHMiBvcGVuIHRoZSBm
aWxlIHIvdw0KPiAtIGFkZCBzdXBwb3J0IGZvciB0aGUgImRlbHN0aWQiIGRyYWZ0IHN5bWJv
bHMNCj4gLSB0ZXN0IGRlbGVnYXRlZCB0aW1lc3RhbXBzIGluIG5ldyBDQl9HRVRBVFRSIHRl
c3RzDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDkw
NS1jYl9nZXRhdHRyLXYxLTAtMGFmMDVjNjgyMzRmQGtlcm5lbC5vcmcNCj4gDQo+IC0tLQ0K
PiBKZWZmIExheXRvbiAoNyk6DQo+ICAgICAgICBXUlQxODogaGF2ZSBpdCBhbHNvIGNoZWNr
IHRoZSBjdGltZSBiZXR3ZWVuIHdyaXRlcw0KPiAgICAgICAgREVMRUcyOiBmaXggd3JpdGUg
ZGVsZWdhdGlvbiB0ZXN0IHRvIG9wZW4gdGhlIGZpbGUgUlcNCj4gICAgICAgIHB5bmZzOiB1
cGRhdGUgbWFpbnRhaW5lciBpbmZvDQo+ICAgICAgICBuZnM0LjE6IGFkZCB0d28gQ0JfR0VU
QVRUUiB0ZXN0cw0KPiAgICAgICAgbmZzNC4xOiBkZWZhdWx0IHRvIG1pbm9ydmVyc2lvbiAy
DQo+ICAgICAgICBuZnM0LjE6IGFkZCBzdXBwb3J0IGZvciB0aGUgImRlbHN0aWQiIGRyYWZ0
DQo+ICAgICAgICBzdF9kZWxlZzogdGVzdCBkZWxlZ2F0ZWQgdGltZXN0YW1wcyBpbiBDQl9H
RVRBVFRSDQo+IA0KPiAgIENPTlRSSUJVVElORyAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDYgKy0NCj4gICBuZnM0LjAvc2VydmVydGVzdHMvc3Rfd3JpdGUucHkgICAgICAgIHwg
IDI4ICsrKysrKy0tLQ0KPiAgIG5mczQuMS9uZnM0Y2xpZW50LnB5ICAgICAgICAgICAgICAg
ICAgfCAgIDggKystDQo+ICAgbmZzNC4xL25mczRsaWIucHkgICAgICAgICAgICAgICAgICAg
ICB8ICAgMyArDQo+ICAgbmZzNC4xL3NlcnZlcjQxdGVzdHMvZW52aXJvbm1lbnQucHkgICB8
ICAgMyArDQo+ICAgbmZzNC4xL3NlcnZlcjQxdGVzdHMvc3RfZGVsZWdhdGlvbi5weSB8IDEw
MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ICAgbmZzNC4xL3Rlc3RzZXJ2
ZXIucHkgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiAgIG5mczQuMS94ZHJkZWYvbmZz
NC54ICAgICAgICAgICAgICAgICAgfCAxMTEgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLQ0KPiAgIDggZmlsZXMgY2hhbmdlZCwgMjQyIGluc2VydGlvbnMoKyksIDIxIGRl
bGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGM3NWY2NTk4MzQ5OGEzMjU0ZTM5
NzBkYTg2ZWI2OTU0NDE1Y2FjMDENCj4gY2hhbmdlLWlkOiAyMDI0MDkwNS1jYl9nZXRhdHRy
LThkYjE4NGE1YjRiZg0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQoNCg==

--------------8ckp0IgWJCvV2s36z08k03F2--

--------------hAnkE0dG9tFGd0JipiXG4ODF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmcNjAQFAwAAAAAACgkQhSPvAG3BU+JB
sBAAt9nULB2Jnec8bmC0p/JhVRfWqnfYTHiDjk9p+9RL4AgpO/qproyLOMqkfVX+OCiofJ7S6qpx
iHodw1jczHhONq1/3lsN1rfjbzQ1krhXe3Lh/xTaBwL+dokQEd3y/QUFL/G9LAiBTykIy7LAqHdi
mfY1GX+VGCDw5UPlz2ulh7SU/HL+p80Gp7vdBO8UNqPH1ufuDuaFKCn4kHEoaHxMJPW98Hs1dy1b
xXPKQDYqWv9jjKHXgSHW/kuLvaU3oLC8AnOs5mEpTJ9iREhmxrh9phe5A7p+RrVbdNwQYxrewVB9
gMVYU80WdOTHWK7keld54GaKuqdP6aiGq0C5IDoxp71aD00s4BSVjWHlu7QkOR5C/wGSQiIn4dAU
xonLSNpAY3auXfPsLfwtTiheM3mN+Dm65W9dopgH7Sym3PoQTh2L27MnD81hxjcmfldGLIUTMML2
WRiT12XXaZMww9mTvfgC0FxGrREFyoBRDUICf8wvx4Gb88FQMIxdIL5Rbs7SCIUOPHL1RKjIby9K
kgy8mh7VQglWZCZGp6Pdwf5J2p6JlkFZbq3LRezfSocokgWddfC9Py5ig1m0ilpda5x6PdYCykIv
0gFUP9c4tfcSerXUZFRKWllTQzH2WGNdwTNwmmNknG5KFgePcplNTzmESQAFHz3H18L63g/+HlH/
mHk=
=cFIY
-----END PGP SIGNATURE-----

--------------hAnkE0dG9tFGd0JipiXG4ODF--

