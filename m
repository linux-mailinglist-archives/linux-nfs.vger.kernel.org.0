Return-Path: <linux-nfs+bounces-4972-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B956933F85
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 17:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8881C231B3
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4F17F362;
	Wed, 17 Jul 2024 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HBYQ4yoe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uI1WkQ3u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB93EED8
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jul 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229870; cv=fail; b=O506ZaooURuEzjEpOrhWncqnyYmvKCKIt846UaV140pSqBRfQvC6Ie0y0YzOmV0VoZUnP75qA57+1/iXZd9I0UsYycXByZ/0s04HWzhxrHJy2e4R5e7vCCrOpSOsFM2MP4E37bGf90SsPU60ufzlsHWVU+JYq3xHlGAVPCwpvfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229870; c=relaxed/simple;
	bh=Gu7fRGkksyfRUyt1acXfzK/xuSGMTH7TaeCKFOPHlTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=umSVaN5Mfwf5lKzQPRe/lKNOgwUEttqfj7Q0ILXnsRBbJLMLv+dJJoTqmA+YdmxdG4lURYTpuWDsQFgnGnNk6qifpp9vtiVmBYDhpHki7i04S93x1/I9qX0w15vYUWbJDMszzVg0c0tME6F5HTwUap81j76UFNY1KK5p5AT2H80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HBYQ4yoe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uI1WkQ3u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFKgE0027182;
	Wed, 17 Jul 2024 15:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=Gu7fRGkksyfRUyt1acXfzK/xuSGMTH7TaeCKFOPHl
	Ts=; b=HBYQ4yoehoFaMeONpZvR6F5zEURd0fwsJW0jgMnoFYoQ9jO8Dg3zwVek/
	VUZbFxDmAq93LDpLAS7ByFOUN+kiN6iJKWP+7ROiGhfhQQjKtVmgOyEWMtoQWk/3
	HkJM8ewQWS5/r2WMw8pXX4azFRWJVTCGwy4lTAAnlk2BW8DBsHf6d9XNcDwYmmh+
	0jsrBIW8+on7RwO5CxLOQ5xXoz7hRM8K5DnnsyUlt/VjAJCRdq2IEApBnOp0Su6m
	uYYkVIB+D4+GVYE0CacYnNqTlYvcPlR7F3S+cDAspzYXqM54HkuzR3sO+PQc9ZUY
	KGUGfCPBvUlOx/ZcMtlAtt5tm2wgw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40eggsg0h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 15:24:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HEKucs039549;
	Wed, 17 Jul 2024 15:24:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwev6fx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 15:24:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQfA//2LkjxzcYpATPn0mHRLo0C/bl6dY5f0PdJnyvJDzU/+EvOJvVDpA2ZuQ4qh3ZxDnUh6i0d096Cy8HsLJNxvsLMRvGUBW4nkdnxIfCsDhgCv4VVThQ25TqMjlgsPfBbQe/hMrJbbroah0nKv7qEFXf/wsFGjW8gjI2RT1KjI+pwdB/kQkANkaUzgtpsh26W3Nk3FVlnYwGpc6/NKn0RM1qjr3yCyVXluA2kwjNhJ4uA680Q7PacQPiym9yQeyqqUwaQ1ctl4mJYW7BQ6es7wWkzIem5r2q2fmYBfa+jDu0KcRS0H1AQsGvVfbGu58Ut6jDHxzup63xSnpmiesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu7fRGkksyfRUyt1acXfzK/xuSGMTH7TaeCKFOPHlTs=;
 b=Fuvu65Ap1dmQpzRUDkLzXo/cwKy6tFd0oea6eGDBWc+1thQPvhWzG/OXMcMy0V1l2mhPFRXIImJ3C/ro43DtfRACyQ4IyvQBiqODJJK08CtD90g93fcSQLuxUwak0k4Xx9K0Pi++tjs5Vl757+V72Zy6A8XrsqbQCSNnECM8Gxk6xgAa5hwQCu84gcxyCdU8gZZSoCP4JM+lAJm3+mpd6rqpcspN2bv+Zzu4sJMEhZYewT+h8cZyq+WRpT7ZMP8Sr/WwX45s+h/yNlQDc2rGoOKKSZa1/KCOXURax7H4FCeZSgJnlapWHiw6kodLuMM5o+F11sHMvKCiOxUuViEDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu7fRGkksyfRUyt1acXfzK/xuSGMTH7TaeCKFOPHlTs=;
 b=uI1WkQ3utiNaF2HoSaOYbNrsFqrHfva9jDzd1OyVItrnVzE06nwKiC0C5/YTigU3PTrp569csOrnFJD4OvAORno8FhLIKYfAViyetMarqUZ8xCBbP22dbhD9VcchJm4E23cIVIivPDLEPyZm5R4BGciZ8DoGDKQjBZLtCBjGBpg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5616.namprd10.prod.outlook.com (2603:10b6:a03:3dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 15:24:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 15:24:13 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Tom Talpey <tom@talpey.com>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia
	<kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Steve Dickson
	<steved@redhat.com>
Subject: Re: [PATCH 13/14] nfsd: introduce concept of a maximum number of
 threads.
Thread-Topic: [PATCH 13/14] nfsd: introduce concept of a maximum number of
 threads.
Thread-Index: 
 AQHa1ouEOet5cO0e10aYjf9C+rrX/rH4BZ+AgACrtYCAAIBxgIAAKhcAgABY94CAAVjKAA==
Date: Wed, 17 Jul 2024 15:24:13 +0000
Message-ID: <F2BB54A1-F07E-43A9-B849-5F58C31AF82B@oracle.com>
References: <f12bdd8dde21de4473d38fada67b60ef5883e8dc.camel@kernel.org>
 <172110007383.15471.14744199179662433209@noble.neil.brown.name>
 <27b282045253419857b67f3240ab8ec5f585cf40.camel@kernel.org>
 <B8450A75-EB10-4FED-A0AF-7EA7EA370055@oracle.com>
 <05ab9c05-5d5d-4e51-9e38-7df1c2e60c28@talpey.com>
In-Reply-To: <05ab9c05-5d5d-4e51-9e38-7df1c2e60c28@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5616:EE_
x-ms-office365-filtering-correlation-id: d33b4936-59f8-4c10-e571-08dca674835e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NmFtekRJcTFhbzFvV2J3RU9lV0Nvd0hCRHorRnUrVERPdmkzR25tVUo5SzJV?=
 =?utf-8?B?VW1sVnhrdkY0Smg4RGt6ckVPMTFlMWh5d1ZhU2c0ekZSbDVMa0paS2pOVmJJ?=
 =?utf-8?B?STR2NHZreThEL2pSU1htWTAySkt5S0V6K3IyOU04NUdZOGlNa21JZ0IreGhP?=
 =?utf-8?B?T1lucVBtMGFzUlgwb0VrVEZxM0x3MGN6K0pON09YSFpZZkVrMGFOdW91STBI?=
 =?utf-8?B?a1pleTJuZTN2UWFSRWFwN2FHQ21hbVdRUjI1RkI3bkJNRWxRRS9nRlBkWFAr?=
 =?utf-8?B?WURWMTNQSGtkL1gvS0tyYjAvVWtINlN5b2ZGMjVOUS9JZHFxQjhGR1FFVDdh?=
 =?utf-8?B?TUtCQloyc3VtSFBKTllVL3NGVUQ5bnZjbCtLT3hzUGdIaGl2b2VhN3EwNWxE?=
 =?utf-8?B?VFZ3MDg0YUoyQ1BsN1hFY3pBRHp1N3N3Y2g0MFN6Z2hmSmJlMXV6OS9NclZY?=
 =?utf-8?B?UEk2bzhWZjBxVXZqak85R01XS1pPeWtobHEyZ29XdmdoajJTZVNhNFFsN25E?=
 =?utf-8?B?Z0grVGg2bStoSHRkMVN1VlRjTlZYRkFFRlp3RFkvQmNaUXFHMFFOTi9VNTYx?=
 =?utf-8?B?ODYzUjZLZHloUU8rQXBjanNUMFJVdzQ2cUQ0VlE0MytTcFpYcnhNb1FITVpk?=
 =?utf-8?B?VzM3enVLeU9yY3QzRllXV2VqMGcreGZNb3k0c25TYjBzTHA0aUhNUXllU1FO?=
 =?utf-8?B?dVFEd2syditWWXM4NlhMV1JIR1dxcEdLbzFZakpqM2xicllvNm1tTmtBMWpn?=
 =?utf-8?B?Qnc1TGd3NFpZRWtjdVBySXYyVmprNWZsbTNEbGtnaW51NTQzTFFPN1hrdHJH?=
 =?utf-8?B?WUt1bFd4eHNEb0V4SXBFU2tURHZmQmxtQjl3SUlCbGRhd1NFWitkT1JrTzB4?=
 =?utf-8?B?UVFqY3hJdlJGazhqc1BRaE1Td1I0eTZ1ZnVYbEx5UnNNRWlrcXB1WnQzVmJV?=
 =?utf-8?B?aE5pWEpOZTZGSmRMdU8wSzZtTzEzeXBhRkhEaXJRMEZ6dXNZNVgzc1VBUDF6?=
 =?utf-8?B?bGp3d1pkeXhweXFidjhSK1pyaWYzYjFVbldJNzlETzJyU2NvbDhVWmxjZ0xF?=
 =?utf-8?B?S0RCWHdjV0xuMjJnTHRMbVpDdmNPNnl1TVl3bnZDeTlsRDZRY3pCclJmWGxP?=
 =?utf-8?B?NkJ0U3l3N2pnL291R21Sai9EaDJvSWhGbkdYYTdkR09RQzZzdERDdVNTcnJM?=
 =?utf-8?B?TWlEMUowV2tEWHNWbVA2dms1NFZ1QVFqamVFVitzNHVxS2hkMnRyb21neGpR?=
 =?utf-8?B?cEdha3EyZzhtKy9DcWNaN1Z3UlhEcVVYcnhRYVZLcC9xaWVKWWtkcCtXMk1L?=
 =?utf-8?B?dkpvR0ZTeE4xTmkzcWkyN0pIUGQ1VkJWSTFRRlZ3UTlYRmp0S2t3YXlTdzdT?=
 =?utf-8?B?NFY4amtSNGllZGpqcmhpU0pYMWt2SWNWaEhVRXVJOHNJL0Q5ME5KdENGS0dW?=
 =?utf-8?B?U3JOOWJqbjRWTG1VL2FCT2tEMU0zeHRuMldUbzJwb2xZeHdqUWM3b3c1cjhs?=
 =?utf-8?B?TjlleG5lMkNpaG45VUZ0Rll0ZkN3Sld4bGtTc2NscjlMQ2g1Mk9tZjJ2N3JF?=
 =?utf-8?B?S2RaZHJsdnB5NTVqMmkrbTB3YXNEbnpRaG90TVFybkd2eG1YV0Rlb3hLR0Ny?=
 =?utf-8?B?bGY3bURlbUFpS3BLVkRCaFVEaEUyUjlKSlg5Um4zNGhCa1RnblN5OXI1cVUy?=
 =?utf-8?B?U3FGMnlLRmdRU0Nva2h1OEJ1VUNXaHJ3VjNQREtwQThWNm90eXlLNXBQbWFt?=
 =?utf-8?B?US9paWVoQTVXeUlKQUdnUFp5NW5yOXc4RHJZZDhqanF4U1IrS2RTRUozbDQv?=
 =?utf-8?B?T3NvNmE2WmRma2pkNHBlNVNZd0RVRWRvQVFUckF1S1daQmthUkJpK2xFZkNy?=
 =?utf-8?B?bWxRYkNjZ0tXbGJKbTZrdGhrMVRGWExEaWlVU3NwYjNmQVE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bEhzUktZTFk1ZDVaUlRVV3VaaTlIYVFpZzVnN2w4bzZMWUxsREVQTEtOc2RM?=
 =?utf-8?B?MTNLWUh1UCtESGJuYW50T1UyWlpqK1hQaFlBbVFmWHBRSkQ0U2M1UTlkSWNY?=
 =?utf-8?B?Q3BMUFQ1M2pGaCtjMUF3Q2NweUV6SDVsK2dicHFhclBsTDBYb1VrY09MQlpw?=
 =?utf-8?B?ZGZLR0ZCbUhIRVZRVEZRT0RuempCR3NLSWVmR1V0U2VXSHF3cHFrWE5TZjdC?=
 =?utf-8?B?eTNsK3I0YkFJL1JaSVBxUnpWU2ZqVGZlUmViRjNnVWk1ZzJoYlFXRW9OeFYz?=
 =?utf-8?B?OXM4bllXdnpuL0tKeXgxbDR3b0d4MDBZRTRPNWM4N2dFTWhoZUhkRC9SVGE5?=
 =?utf-8?B?Z0huQWhHazNiL3Bwblo0c3Mzam1YWmpsRVp4a3NiU0N3bWZqcnJkV0sydFli?=
 =?utf-8?B?QU1GdnQvTHgzL1FJUnRVN0tpK1VIQlArSk1UeWl2NlRCNHkrZjR5QzhUK2ZE?=
 =?utf-8?B?VUI4azlxdXFHaGhYQi9wWnVCZklxZ3FjZ25YUlVRM0I2aXVsOWlDblpuVlBk?=
 =?utf-8?B?aytBOGJERndnaUlBSmtCS3ZUbVQzaDdWanh0QlgzTnZVR003ZWhvV1p2ZEJm?=
 =?utf-8?B?aVJ3cFQyc01HbTBsWHBERkJxK29mS0dxYlNqemRBUTB2cUVMQXd2eGJEcWtL?=
 =?utf-8?B?TnJVbzF1WDZ3dDdsRzFieUpQYmZGeVp0eGhkdEJ0L1M5bzkrNUxrMzJtVzFB?=
 =?utf-8?B?UGpjc1JEcnR1VjNlTUZIZXhGN0FyOWcyVFF5ZUUxZG5KZUVwT1pVYldxMmxN?=
 =?utf-8?B?LytZalhaNjdMbEdpcEdUSVovdjZzSnJ2bDRNMTg5UjlOaVRMR1hXMHdHMk8y?=
 =?utf-8?B?L0k3dWNFdkY2REJNRWlFZmwyWjc0UVRRT3dZdExROWp2OG9YTzIvOEMrYWZM?=
 =?utf-8?B?a3M5b3luYThSS2dUcEpTVkcwZm9lS1NEODdCSkkvQldmZzJnM2lnVnkyWldN?=
 =?utf-8?B?ZytuLzVrLzlrdTVIMjJsOWZGaWdXbmdKOE5MNjdxZW1zSUNOc0p3c0lHYWJa?=
 =?utf-8?B?dGVla0l2K2w3RHpaZXhZS2ladGpVaG1jSnlwa29QaE9ZS0JrRVk1REZJVjlB?=
 =?utf-8?B?NXR0RXBCWUcvMnZSbDBrRVliRG9mMHlmdHhlWENPM3RvaTgrOHpqZWlQTmxq?=
 =?utf-8?B?NVlhWGQ3aEY3WXkzbFh1c2FuSkd6QnEwTmkrL1phM1ErK05xVkg4TEdtMWxS?=
 =?utf-8?B?bDFseUJ2dUxrcU1xVDlNbStPMk9UaWNZK3l0RzlNa04wa054aytNdGVna3lL?=
 =?utf-8?B?Qm82VjZ1SkFsejE5dE5PdXhENWFjTjZCSC9nWElGZFA5RlVFQjZoTlNHUHhC?=
 =?utf-8?B?VnNRcHpwYW5Eb1lWeVdnSWo3d2VJYmRzZEdrN0lpSUxJUEVTdThyOE1SYUVM?=
 =?utf-8?B?bkhBWU9RV2M1ZDMrTTd3NDJGQ0NpdG0wMkwrMkNNRzZ1UGxtNUZZTENjL3B6?=
 =?utf-8?B?SU1qR3lQbkVGaW5lRWx2aGhyODB2MkdyTEZqa3dXejBEMVhrUEZET1htVkYv?=
 =?utf-8?B?Vk96LzVrVWdZZ25qMVJXZjNlVTBGUmtQVlBzTjlBSGxETVQ2QnhMUWxjT0VM?=
 =?utf-8?B?dlVBeHZ6OVMzSVhiVWh1MGE5RExFM2h4REJpNlZhRjFyNnk2RjhJVHZWS3g4?=
 =?utf-8?B?QU5lS21SV25UNDV1OFBKY3dZekJEQ3ZzSlYwekdQcUlHOEgvakpaZjdwQTBC?=
 =?utf-8?B?UlRJTGR0Zy9NVCtCbklITWhvZVJld1o4ZVJBalpoVDlOblN0S3JDdk53YmhI?=
 =?utf-8?B?Ni9heXFXVTJHL1NNTmhuc2Z4WVRrNHorb3JpOUdEUmlCay82aExaZmFXVnZy?=
 =?utf-8?B?WjI0T2libXNpb2lDaTc2ZFU5Skl3bzVsSHUvSFhjclNiRCszL0hiT042dERV?=
 =?utf-8?B?VmNwNXUvZmpSN3psNVhLRE1WNWFyN3EvRXlCTHkzZE1PYWZwWW5XNkwrSkVL?=
 =?utf-8?B?WUNsTzZGd3NnOThZVFNlWDhrbjJGNkRmVXkvZlNLSzF0UWRrR2V6OHFDL1Ns?=
 =?utf-8?B?cHVDM0ZRZTA3c1NScC81QTU1LzQwazZrbmtHN1pZZ3Zwa3dYUkNVYlQ4OUxj?=
 =?utf-8?B?d2JmZUkvZHJnODhqRDZWK01zWnJRZnZRYmJua1RLQWZXSnNYaWNHSHNzc1Fv?=
 =?utf-8?B?clppTVp1YmpsUVQvcWkzODBDMzUxU0lQSitJSEpKM1NIOW50SEJHZTFLN1NK?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B7BBE1B7B046B43BAF044EDAF021598@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cjxQWl0wLIOQpUzORSwq4kBtqn6MGcT0jZ+q7a1a9cJ3LKutDMzWY09XT+EEIuPqxzpDCq7aRpMCK3X9UlVSFWIOzKpXs7qcZ7NeCP/sf9QZWUZaIdUN1yV7ELxLMhNqmz4mnHzNc+oPf9Jvzo1u6Ci5e8N1/himzS8Z/DQLezwVkmwWJFVStNnu2q9TlQ+vBl95garGoZ0LFlk+Yufc0evFIQNznkSQ6NClshgCQH25+3UWaOt0tfEFNvXBE3ei0xtnHdu3a/YHfB2Zyuje2ID9TDjwXeUGoBO4pBk2mO23PpY/V0efIEuOrxWXERhYwa6AJM0ZIJhFpdh9efXczHOQCpIEqROxqC9A11rZ019SGzcOy60uGrZhhESTmWElfzOa87AqYsfZXJpNGCndseenQsiC5Nkn8waj+Y+9BMBx6PbroHhrw2usuDdPdJQC9qAEqu89z+TXXaIi5LO/P2zEZ1LhaLCiOySpI5eJBHAQ8jrsw/882i2pnMAY52XGFHDziFP8e2dj+JdFuXNQru80uKmqsaENstuZNZml/g7Uc2sWwUOQSOkuc2Cm7IKwsUuVyByuV7qkhJXtTDum/WCndNnEQDEXL3jXnKHMF9Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33b4936-59f8-4c10-e571-08dca674835e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 15:24:13.0138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWOGNFm2/RRN4PvnIR+93rJ+SCqv3x6pPoCCTl9biW0mGk0SyxUhS2qV6e5+D61VPhlg8Z7E0AwPw0YkTX5E4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_11,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170118
X-Proofpoint-GUID: yz1zI9B44S9P17yCEeTn7vUcub_sAs9-
X-Proofpoint-ORIG-GUID: yz1zI9B44S9P17yCEeTn7vUcub_sAs9-

DQoNCj4gT24gSnVsIDE2LCAyMDI0LCBhdCAyOjQ54oCvUE0sIFRvbSBUYWxwZXkgPHRvbUB0YWxw
ZXkuY29tPiB3cm90ZToNCj4gDQo+IE9uIDcvMTYvMjAyNCA5OjMxIEFNLCBDaHVjayBMZXZlciBJ
SUkgd3JvdGU6DQo+Pj4gT24gSnVsIDE2LCAyMDI0LCBhdCA3OjAw4oCvQU0sIEplZmYgTGF5dG9u
IDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFR1ZSwgMjAyNC0wNy0x
NiBhdCAxMzoyMSArMTAwMCwgTmVpbEJyb3duIHdyb3RlOg0KPj4+PiBPbiBUdWUsIDE2IEp1bCAy
MDI0LCBKZWZmIExheXRvbiB3cm90ZToNCj4+Pj4+IE9uIE1vbiwgMjAyNC0wNy0xNSBhdCAxNzox
NCArMTAwMCwgTmVpbEJyb3duIHdyb3RlOg0KPj4+Pj4+IEEgZnV0dXJlIHBhdGNoIHdpbGwgYWxs
b3cgdGhlIG51bWJlciBvZiB0aHJlYWRzIGluIGVhY2ggbmZzZCBwb29sIHRvDQo+Pj4+Pj4gdmFy
eSBkeW5hbWljYWxseS4NCj4+Pj4+PiBUaGUgbG93ZXIgYm91bmQgd2lsbCBiZSB0aGUgbnVtYmVy
IGV4cGxpY2l0IHJlcXVlc3RlZCB2aWENCj4+Pj4+PiAvcHJvYy9mcy9uZnNkL3RocmVhZHMgb3Ig
L3Byb2MvZnMvbmZzZC9wb29sX3RocmVhZHMNCj4+Pj4+PiANCj4+Pj4+PiBUaGUgdXBwZXIgYm91
bmQgY2FuIGJlIHNldCBpbiBlYWNoIG5ldC1uYW1lc3BhY2UgYnkgd3JpdGluZw0KPj4+Pj4+IC9w
cm9jL2ZzL25mc2QvbWF4X3RocmVhZHMuICBUaGlzIHVwcGVyIGJvdW5kIGFwcGxpZXMgYWNyb3Nz
IGFsbCBwb29scywNCj4+Pj4+PiB0aGVyZSBpcyBubyBwZXItcG9vbCB1cHBlciBsaW1pdC4NCj4+
Pj4+PiANCj4+Pj4+PiBJZiBubyB1cHBlciBib3VuZCBpcyBzZXQsIHRoZW4gb25lIGlzIGNhbGN1
bGF0ZWQuICBBIGdsb2JhbCB1cHBlciBsaW1pdA0KPj4+Pj4+IGlzIGNob3NlbiBiYXNlZCBvbiBh
bW91bnQgb2YgbWVtb3J5LiAgVGhpcyBsaW1pdCBvbmx5IGFmZmVjdHMgZHluYW1pYw0KPj4+Pj4+
IGNoYW5nZXMuIFN0YXRpYyBjb25maWd1cmF0aW9uIGNhbiBhbHdheXMgb3Zlci1yaWRlIGl0Lg0K
Pj4+Pj4+IA0KPj4+Pj4+IFdlIHRyYWNrIGhvdyBtYW55IHRocmVhZHMgYXJlIGNvbmZpZ3VyZWQg
aW4gZWFjaCBuZXQgbmFtZXNwYWNlLCB3aXRoIHRoZQ0KPj4+Pj4+IG1heCBvciB0aGUgbWluLiAg
V2UgYWxzbyB0cmFjayBob3cgbWFueSBuZXQgbmFtZXNwYWNlcyBoYXZlIG5mc2QNCj4+Pj4+PiBj
b25maWd1cmVkIHdpdGggb25seSBhIG1pbiwgbm90IGEgbWF4Lg0KPj4+Pj4+IA0KPj4+Pj4+IFRo
ZSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIGNhbGN1bGF0ZWQgbWF4IGFuZCB0aGUgdG90YWwgYWxs
b2NhdGlvbiBpcw0KPj4+Pj4+IGF2YWlsYWJsZSB0byBiZSBzaGFyZWQgYW1vbmcgdGhvc2UgbmFt
ZXNwYWNlcyB3aGljaCBkb24ndCBoYXZlIGEgbWF4aW11bQ0KPj4+Pj4+IGNvbmZpZ3VyZWQuICBX
aXRoaW4gYSBuYW1lc3BhY2UsIHRoZSBhdmFpbGFibGUgc2hhcmUgaXMgZGlzdHJpYnV0ZWQNCj4+
Pj4+PiBlcXVhbGx5IGFjcm9zcyBhbGwgcG9vbHMuDQo+Pj4+Pj4gDQo+Pj4+Pj4gSW4gdGhlIGNv
bW1vbiBjYXNlIHRoZXJlIGlzIG9uZSBuYW1lc3BhY2UgYW5kIG9uZSBwb29sLiAgQSBzbWFsbCBu
dW1iZXINCj4+Pj4+PiBvZiB0aHJlYWRzIGFyZSBjb25maWd1cmVkIGFzIGEgbWluaW11bSBhbmQg
bm8gbWF4aW11bSBpcyBzZXQuICBJbiB0aGlzDQo+Pj4+Pj4gY2FzZSB0aGUgZWZmZWN0aXZlIG1h
eGltdW0gd2lsbCBiZSBkaXJlY3RseSBiYXNlZCBvbiB0b3RhbCBtZW1vcnkuDQo+Pj4+Pj4gQXBw
cm94aW1hdGVseSA4IHBlciBnaWdhYnl0ZS4NCj4+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+
PiBTb21lIG9mIHRoaXMgbWF5IGNvbWUgYWNyb3NzIGFzIGJpa2VzaGVkZGluZywgYnV0IEknZCBw
cm9iYWJseSBwcmVmZXINCj4+Pj4+IHRoYXQgdGhpcyB3b3JrIGEgYml0IGRpZmZlcmVudGx5Og0K
Pj4+Pj4gDQo+Pj4+PiAxLyBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBlbmFibGUgdGhpcyB1bml2
ZXJzYWxseSAtLSBhdCBsZWFzdCBub3QNCj4+Pj4+IGluaXRpYWxseS4gV2hhdCBJJ2QgcHJlZmVy
IHRvIHNlZSBpcyBhIG5ldyBwb29sX21vZGUgZm9yIHRoZSBkeW5hbWljDQo+Pj4+PiB0aHJlYWRw
b29scyAobWF5YmUgY2FsbCBpdCAiZHluYW1pYyIpLiBUaGF0IGdpdmVzIHVzIGEgY2xlYXIgb3B0
LWluDQo+Pj4+PiBtZWNoYW5pc20uIExhdGVyIG9uY2Ugd2UncmUgY29udmluY2VkIGl0J3Mgc2Fm
ZSwgd2UgY2FuIG1ha2UgImR5bmFtaWMiDQo+Pj4+PiB0aGUgZGVmYXVsdCBpbnN0ZWFkIG9mICJn
bG9iYWwiLg0KPj4+Pj4gDQo+Pj4+PiAyLyBSYXRoZXIgdGhhbiBzcGVjaWZ5aW5nIGEgbWF4X3Ro
cmVhZHMgdmFsdWUgc2VwYXJhdGVseSwgd2h5IG5vdCBhbGxvdw0KPj4+Pj4gdGhlIG9sZCB0aHJl
YWRzL3Bvb2xfdGhyZWFkcyBpbnRlcmZhY2UgdG8gc2V0IHRoZSBtYXggYW5kIGp1c3QgaGF2ZSBh
DQo+Pj4+PiByZWFzb25hYmxlIG1pbmltdW0gc2V0dGluZyAobGlrZSB0aGUgY3VycmVudCBkZWZh
dWx0IG9mIDgpLiBTaW5jZSB3ZSdyZQ0KPj4+Pj4gZ3Jvd2luZyB0aGUgdGhyZWFkcG9vbCBkeW5h
bWljYWxseSwgSSBkb24ndCBzZWUgd2h5IHdlIG5lZWQgdG8gaGF2ZSBhDQo+Pj4+PiByZWFsIGNv
bmZpZ3VyYWJsZSBtaW5pbXVtLg0KPj4+Pj4gDQo+Pj4+PiAzLyB0aGUgZHluYW1pYyBwb29sLW1v
ZGUgc2hvdWxkIHByb2JhYmx5IGJlIGxheWVyZWQgb24gdG9wIG9mIHRoZQ0KPj4+Pj4gcGVybm9k
ZSBwb29sIG1vZGUuIElPVywgaW4gYSBOVU1BIGNvbmZpZ3VyYXRpb24sIHdlIHNob3VsZCBzcGxp
dCB0aGUNCj4+Pj4+IHRocmVhZHMgYWNyb3NzIE5VTUEgbm9kZXMuDQo+Pj4+IA0KPj4+PiBNYXli
ZSB3ZSBzaG91bGQgc3RhcnQgYnkgZGlzY3Vzc2luZyB0aGUgZ29hbC4gIFdoYXQgZG8gd2Ugd2Fu
dA0KPj4+PiBjb25maWd1cmF0aW9uIHRvIGxvb2sgbGlrZSB3aGVuIHdlIGZpbmlzaD8NCj4+Pj4g
DQo+Pj4+IEkgdGhpbmsgd2Ugd2FudCBpdCB0byBiZSB0cmFuc3BhcmVudC4gIFN5c2FkbWluIGRv
ZXMgbm90aGluZywgYW5kIGl0IGFsbA0KPj4+PiB3b3JrcyBwZXJmZWN0bHkuICBPciBhcyBjbG9z
ZSB0byB0aGF0IGFzIHdlIGNhbiBnZXQuDQo+Pj4+IA0KPj4+IA0KPj4+IFRoYXQncyBhIG5pY2Ug
ZXZlbnR1YWwgZ29hbCwgYnV0IHdoYXQgZG8gd2UgZG8gaWYgd2UgbWFrZSB0aGlzIGNoYW5nZQ0K
Pj4+IGFuZCBpdCdzIG5vdCBiZWhhdmluZyBmb3IgdGhlbT8gV2UgbmVlZCBzb21lIHdheSBmb3Ig
dGhlbSB0byByZXZlcnQgdG8NCj4+PiB0cmFkaXRpb25hbCBiZWhhdmlvciBpZiB0aGUgbmV3IG1v
ZGUgaXNuJ3Qgd29ya2luZyB3ZWxsLg0KPj4gQXMgU3RldmUgcG9pbnRlZCBvdXQgKHByaXZhdGVs
eSkgdGhlcmUgYXJlIGxpa2VseSB0byBiZSBjYXNlcw0KPj4gd2hlcmUgdGhlIGR5bmFtaWMgdGhy
ZWFkIGNvdW50IGFkanVzdG1lbnQgY3JlYXRlcyB0b28gbWFueQ0KPj4gdGhyZWFkcyBvciBzb21l
aG93IHRyaWdnZXJzIGEgRG9TLiBBZG1pbnMgd2FudCB0aGUgYWJpbGl0eSB0bw0KPj4gZGlzYWJs
ZSBuZXcgZmVhdHVyZXMgdGhhdCBjYXVzZSB0cm91YmxlLCBhbmQgaXQgaXMgaW1wb3NzaWJsZQ0K
Pj4gZm9yIHVzIHRvIHRvIHNheSB0cnV0aGZ1bGx5IHRoYXQgd2UgaGF2ZSBwcmVkaWN0ZWQgZXZl
cnkNCj4+IG1pc2JlaGF2aW9yLg0KPj4gU28gKzEgZm9yIGhhdmluZyBhIG1lY2hhbmlzbSBmb3Ig
Z2V0dGluZyBiYWNrIHRoZSB0cmFkaXRpb25hbA0KPj4gYmVoYXZpb3IsIGF0IGxlYXN0IHVudGls
IHdlIGhhdmUgY29uZmlkZW5jZSBpdCBpcyBub3QgZ29pbmcNCj4+IHRvIGhhdmUgdHJvdWJsaW5n
IHNpZGUtZWZmZWN0cy4NCj4gDQo+ICsxIG9uIGEgY29uZmlndXJhYmxlIG1heGltdW0gYXMgd2Vs
bCwgYnV0IEknbGwgYWRkIGEgY29uY2VybiBhYm91dA0KPiB0aGUgTlVNQSBub2RlIHRoaW5nLg0K
PiANCj4gTm90IGFsbCBDUFUgY29yZXMgYXJlIGNyZWF0ZWQgZXF1YWwgYW55IG1vcmUsIHRoZXJl
IGFyZSAicGVyZm9ybWFuY2UiDQo+IGFuZCAiZWZmaWNpZW5jeSIgKEF0b20pIGNvcmVzIGFuZCB0
aGVyZSBjYW4gYmUgYSBiaWcgZGlmZmVyZW5jZS4gQWxzbw0KPiB0aGVyZSBhcmUgTlVNQSBub2Rl
cyB3aXRoIG5vIENQVXMgYXQgYWxsLCBtZW1vcnktb25seSBmb3IgZXhhbXBsZS4NCj4gVGhlbiwg
Q1hMIHNjcmFtYmxlcyB0aGUgdG9wb2xvZ3kgYWdhaW4uDQoNCkkgdGhpbmsgaXQgd291bGRuJ3Qg
YmUgZGlmZmljdWx0IHRvIG1ha2UgdGhlIHN2Y19wb29sX21hcCBza2lwDQpjcmVhdGluZyBzdmMg
dGhyZWFkIHBvb2xzIG9uIE5VTUEgbm9kZXMgd2l0aCBubyBDUFVzLiBBbmQgcGVyaGFwcw0KdGhl
IG1pbi9tYXggc2V0dGluZ3MgbmVlZCB0byBiZSBwZXIgcG9vbD8NCg0KQnV0IHRoZSBpZGVhIHdp
dGggZHluYW1pYyB0aHJlYWQgcG9vbCBzaXppbmcgaXMgdGhhdCBpZiBhIHBvb2wNCihvciBub2Rl
KSBpcyBub3QgZ2V0dGluZyBORlMgdHJhZmZpYywgdGhlbiBpdHMgdGhyZWFkIHBvb2wgd2lsbA0K
bm90IGdyb3cuDQoNCg0KPiBMZXQncyBub3QgZm9yZ2V0IHRoYXQgdGhlc2UgbmZzZCB0aHJlYWRz
IGNhbGwgaW50byB0aGUgZmlsZXN5c3RlbXMsDQo+IHdoaWNoIG1heSBkZXNpcmUgdmVyeSBkaWZm
ZXJlbnQgTlVNQSBhZmZpbml0aWVzLCBmb3IgZXhhbXBsZSB0aGUgbmZzZA0KPiBwcm90b2NvbCBz
aWRlIG1heSBwcmVmZXIgdG8gYmUgbmVhciB0aGUgbmV0d29yayBhZGFwdGVyLCB3aGlsZSB0aGUN
Cj4gZmlsZXN5c3RlbSBzaWRlLCB0aGUgc3RvcmFnZS4gQW5kIFJETUEgY2FuIGJ5cGFzcyBtZW1v
cnkgY29weSBjb3N0cy4NCg0KQWdyZWVkLCB0aGVzZSBpc3N1ZXMgc3RpbGwgcmVxdWlyZSBhZG1p
bmlzdHJhdG9yIGF0dGVudGlvbiB3aGVuDQpjb25maWd1cmluZyBhIGhpZ2ggcGVyZm9ybWFuY2Ug
c3lzdGVtLg0KDQoNCj4gVGhyZWFkIGNvdW50IG9ubHkgYWRkcmVzc2VzIGEgZnJhY3Rpb24gb2Yg
dGhlc2UuDQo+IA0KPj4gWWVzLCBpbiBhIHBlcmZlY3Qgd29ybGQsIGZ1bGx5IGF1dG9ub21vdXMg
dGhyZWFkIGNvdW50DQo+PiBhZGp1c3RtZW50IHdvdWxkIGJlIGFtYXppbmcuIExldCdzIGFpbSBm
b3IgdGhhdCwgYnV0IHRha2UNCj4+IGJhYnkgc3RlcHMgdG8gZ2V0IHRoZXJlLg0KPiANCj4gQW1h
emluZyBpbmRlZWQsIGFuZCBqdXN0IGFzIHVubGlrZWx5IHRvIGJlIHBlcmZlY3QuIENhdXRpb24g
aXMgZ29vZC4NCj4gDQo+IFRvbS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

