Return-Path: <linux-nfs+bounces-7857-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 746D09C415B
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 15:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BB81C21D19
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C93F1A255D;
	Mon, 11 Nov 2024 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ESw/5Kbm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rkG3Yb6o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C719F118
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337171; cv=fail; b=geOvFP0XoZtL3UPA+HyJYr+tdX0Ci5SMQMv/Sd/MGuV144vvTMUWr3clAM8NKZvs9eMTOmlSsNuDcaNsstVozjvOHG8S/Y9I2+am5ZZpqbuW4zF5dvo3QHy21BQ7p2jSaSpM9HhJQo2rgu6uf5+HHXZ0YZLY+01gUPf23r8tho0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337171; c=relaxed/simple;
	bh=6d8hkaUrLOErgUKzOF22puELrh5Ypu/X6ZSx0cuNyBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tyuLnpgbL8xPkYpHba6uMyPKWJRUYzaabtlvHUt1xKSeX5fV/jQfx8h1+X4rwHATGOc1pGxeVrIBCAp87X6mOzeakzlJldMq4/luxaGToz0Bm9SebLN5CXqNTsvYMBamzCh3Ifa81EBqzSs2e4W/upuM9qRfPwqiqE9FAue4Ai8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ESw/5Kbm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rkG3Yb6o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9sodK016878;
	Mon, 11 Nov 2024 14:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6d8hkaUrLOErgUKzOF22puELrh5Ypu/X6ZSx0cuNyBo=; b=
	ESw/5KbmlnzQZMk3yHETkTk0tg8u0Z9QjZeYaYK2SdcBRa3UikqFsjW4OMIM3KQi
	HhbwTEwH+wPx6zu+H/0CUC2HwPl4n4iomqeuCWR/hIW3q+Ifw6oav7DASmPPMClr
	oTH6A2AN3nua8SqJbaiHJCtY5cYdfRyXOYiPVKjGx2KzeczHTo56w8ANy1nxSCtx
	NMqXOZke78ySyyUJvV/r7/i9Uyn3mnCuhMl8fRAdOhA1dOC4uJwjy+c2+mLLv0E9
	FVGGBaWUzZ03yD2oj3EO8jiGAfJaJk28nMMzH7FcOcA4xRsz6fCSWYipYytKB8zS
	S50kWvtU6dA6y0qBxhZifQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hnahm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 14:59:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABDMTtV026442;
	Mon, 11 Nov 2024 14:59:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx67193q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 14:59:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHuBaam5rd5aHonEUEsGNGCu/nH1WgWDFuYVp03GhgMTjNgYLVQanJzhD7KYmGcII8UxcotU2iwtGvGVEJwkAoI7oLMbZVFUHYn3tlH4fgDYolueoK5OvHBddDKSJt1ryDA3ShykXzQjWWwKLYFr5OtsnNidNVqAxZDENhGn3RHnSki+SaEvI+1slN/thMOrq38CrHi0LIWwcoeXwzI09yilHZTK3yG6s6jgL+Hnp633GXPdjDHAChOWedC3AibQDvQrGQ/StuGNPLiNgZ+WvIqsC6NoNNmvPi7ZXZgOewAePwxplxELg+5TjyQThjYpMSUjbawxokkbMGSeyrcJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d8hkaUrLOErgUKzOF22puELrh5Ypu/X6ZSx0cuNyBo=;
 b=Xuh7HL2mtYhvYvdJw2w/gHY6f2uhMEPZTtK5s39ZwuTRFboCWUOFS34tVpVMbv9t++Vcx2fFxEuj3+z/PijcK2ID5WeTLAbKTip55/EeI11gtceL2NUDkV0LhN6N7nm9Kw3ovAYK9nrHwzcLRu+ZZjgngyEGv7XgSms0PGU0BH1vXvsf65u1bXeyfN6ItrPKj0mU1VU560qjJtTZugV8/txr02YgS10ssDNplEugomgpoEYR+4cVDPBy2bp9FSzBN5TRiBdG/uoyGqfoweGXiN+SzByPaQwtP+Pc1jnkDQwUZJ9I12UpvpcIW6SJQQz+XCTVkA6hFW5SmrO/wrF4Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d8hkaUrLOErgUKzOF22puELrh5Ypu/X6ZSx0cuNyBo=;
 b=rkG3Yb6oPdTyRGMUBxhw59ahyACf1g8/bdxCxD9uOAYq8VVNOrWuTKG5HW8PRi+88/dthQJXYdZspAO/RmNY15q96y92TMAvusoSzZvsxA3CdGMGCizTupE7DfGjFKf3hQVv9Jwm9hB0HZzkQuE+KKTbz6WFOfwAynYEvU6N3WU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7321.namprd10.prod.outlook.com (2603:10b6:8:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 14:59:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 14:59:20 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
CC: Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@oracle.com>
Subject: Re: [PATCH] nfs(5): Update rsize/wsize options
Thread-Topic: [PATCH] nfs(5): Update rsize/wsize options
Thread-Index: Ads0CNAGIEAUadG7QF6DMBzDxhWiYQAQXK+A
Date: Mon, 11 Nov 2024 14:59:20 +0000
Message-ID: <D001CF66-6807-4FF2-B45A-C10ECEB80015@oracle.com>
References:
 <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB7321:EE_
x-ms-office365-filtering-correlation-id: 8b9788bd-5ce2-4832-b75f-08dd02616c0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?blpmOXB3bmdhNzBHczdoT1dSRkRoMDZwOVpiMjI5Q0JRSTA5bTNiS2hZeHg1?=
 =?utf-8?B?Ri9oQ0E3MFlvTkFJVnhBMHNwTy93N1JCMjhUNlVpcXp1S3pycmVjQnplTEtn?=
 =?utf-8?B?K0xsWlMrYllscTF2MWludmM3Vjcxam9pRXNHOGhHV3lWOGxuZS9lWFhzWktB?=
 =?utf-8?B?WEpuaE1EYTI0QURaM1BJVk5MQ1VacU9MZlRITEl6OUJORzg5VDRyY0RMN2FR?=
 =?utf-8?B?eG5JbkFweXFLWmpBaE0xcDBQd2w0RzJITFhsa1R0d1E1NTVzd1hNNDUvSEFS?=
 =?utf-8?B?SStIa3ovenh4SVg2bytCY2UyY3I3RnZpMTIzdktjZUxkOS9PUno1ZUIvNmtN?=
 =?utf-8?B?U2tlZyt5ZTNpSzdEOEcyaldHRzgxd3VBYVRqWEZ1QXhNUkJEck5RZWJhNVh1?=
 =?utf-8?B?NWV5NEpWYXFkbUl1TjlpQy9qYXlmUnAweUErandqTEpiUG8vZVUzaFd2V2xv?=
 =?utf-8?B?a0ZVV3BjM1dUR3JqM3N5Um5Jam1hK3Y3TFFzSStnVnRiV3FNRnJGM2ZIVzJo?=
 =?utf-8?B?eXZUMlNxcFZubFU4YUlVVVpYUFo3OUJsMTN0NnFMTGRSL1E1TXRSS0NXOWw0?=
 =?utf-8?B?c0p4Ym0xRjhSTVhrS28rbSt3c3ZLNGNSQnRpQ3hlOC8zM1JnNkREZ3poNzMz?=
 =?utf-8?B?SDVuNkF6a1BZVGh2Q1dLWktOdFlKWHVYRWQ3cHFPMFFMSkg4RjlNdjhLZW4y?=
 =?utf-8?B?Uk5BTWhaVnRLTmVpbzJZVEN5d05WVGdZSFdnckpRVnVlcmU0cmx2c1hya0JH?=
 =?utf-8?B?bHMwbFV6UTJCdlhBUzVjQzNVTFVCaTZFQnRHc3Q4dDJUN24xWjZuNlc1OWk5?=
 =?utf-8?B?UnZZRVA2VVZubDF6cEtSKzRwNllNc0dOZFNsSEpzalFyQ01ZNUpZQkhTdlov?=
 =?utf-8?B?N1NWYW5QUjNGaFRHMTFCeG9lVGsyNlVJNVFpTFB0QmpYUGtKWVQ0WlFpbkcz?=
 =?utf-8?B?TW5uWVFhK3pETS94QjRFM2VkLzBjQ0l3akFRc1IzdVc3SmJweFRjbTdFNVQx?=
 =?utf-8?B?L2pCOXIzVHpjd1FVRVpmSU1FeHhUc3ZSZ0xzTGMzY2xyWnUyZGdCSktXNWpS?=
 =?utf-8?B?VUtwQndxbVJXV2RJbFN6ZW1hNGJURHZFRTJpYVBBU2NGb0JoSUg0aXk4cVRo?=
 =?utf-8?B?TnRTTFV5UkU3NE85Znd6azF3TSt2b2Q5c1lrQkxTNE1hZHQ5VENZcUFkWm9Q?=
 =?utf-8?B?eE9rK3hPZHp6bTJvWEdCenpBOHg3aFUyd1hMK1MvSTlidlQvMzFnL21aRzgv?=
 =?utf-8?B?akt3TnFPc0dvRHcxWDdEdVM4Y2NBSFE5cGRTMGh6ZHV1TGhaV0JWeDd0NlEr?=
 =?utf-8?B?cnk3cTdJMkgvNGZISnMxNDFUYkdQSHNVVlRPbUdDR0ZrdlZ0TE9Na1FWaCtS?=
 =?utf-8?B?dHZnS3VxYzNJLzk4QVVGTGpRdU1tRVVUZi9lNllub1FCMDlwemQzeW54VTk1?=
 =?utf-8?B?RzBKcWlYTWJLWVdtZUVnMlhNb3BIMlZTZFFXakI2bXQwY1V1VVpSWVJQSU1P?=
 =?utf-8?B?RktlRGltRk9qRzEzNXNFL0ZnYUtwRW5zbzk1NWx4YjVQUzdUckFWNFI2NVZ3?=
 =?utf-8?B?Y0F3M05NUWQ0ejQ1dHlKTnVLZ1UwV3VhbURjVml5TzVkeVVlTDhZSGxKWkk0?=
 =?utf-8?B?WVlBTjZFbWtvTitPYWtrZ2NSUkUyRVRPYzNiYUhVY21HSlU4TmN1dFZLRzVo?=
 =?utf-8?B?am5SdEpkN0o4VmdocVppV3IxelpHbjlBdGJoZHg4V1dNLy9PWUJpZG1UcGMz?=
 =?utf-8?B?S0t5ZEkvbE1HTm1QUVA1MldlVDU0WU9Qbmo1eTRRZGpxZTBUTEtqeEFkZlFK?=
 =?utf-8?Q?OtTuR2v/iY5QVhBY/R87GXCTlm7cdnR+ljwrc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHJKSXIvb0QzQVVVd2wxMnkrK3hzUXVWT3h3aG5pZUx5SlRGUitoRmhkZUt0?=
 =?utf-8?B?eEo1QjZoYWdnSjE5MVlWVTZNV3JZQzE1SytxdUdmbjhTNnZaeVBibDFiK3ZV?=
 =?utf-8?B?bEV5YysweWsySmZqNmhmTVRZZS9pZGlSOVIrZ3Z0ZE9ZWUQxSzBhMmtueDVD?=
 =?utf-8?B?ZjFwUFY0RVFXQ2RDbFJadjBmcEU2c0E0QTBNTTA2MjBOMzdVcFZkWC9jT2lI?=
 =?utf-8?B?MFMwRVVoRVRmZEpBN2Uza1BNNzlFWUZqZFcyS0ptU1RrT0V2YUdNUTAwT3Zy?=
 =?utf-8?B?dTl2Ujh0K3VidGRpV3dCelg0WUhHQUoyOURDc3J0bUxnblA4TklnSzVKWklU?=
 =?utf-8?B?TXJlUDRWdmgrbnA1aVIwSzZHRUF3allXUnoyOVc4VXhZTVRmRFhPUDVVdFFy?=
 =?utf-8?B?ZXJKd0ticlN5bUhtMXgydUdxczB0R1Z4V25GMnBLRmhyUXBQUEI4MWh4S1Fu?=
 =?utf-8?B?d25NMC92ODNSL09mdzhLN1MrUloyRllnekdUMHRMTDVlN0hXQVJUVzlLeUVh?=
 =?utf-8?B?cGN2dlRiRGEvSlBQSVNvcUlBK21DUUwxc0UwNWZwbCtaV1gvQWlIa1g0M3lC?=
 =?utf-8?B?NCtJZVFPTmlDd0E2MjhWUTRqQUdaano2THNTSzhVbmppMnEwWHcrQkFmWXZz?=
 =?utf-8?B?dnRDNEdHNENhME82eGc1eU4xa080R2YxZW0xaU5UL0k1RmpURnhUZERraFFM?=
 =?utf-8?B?cWpSN0xuRllEQnlySy9kS2o4ZUdmM0ora0ZIWHpFek5hSUlvTlhqSnRiOXhX?=
 =?utf-8?B?WGo2MGFRek1FaFlCUWIrQkcwVGNhUkhhWWp1SUV1VlNPNEFBREtXKzl2TmxS?=
 =?utf-8?B?eVNYUHJiejJLeTZSaW1FSUgyb2tMWmhDdEF1VG8xL1hIM3RkQWVDOEtOYXdX?=
 =?utf-8?B?N3FDSmlCQ1BqZHQ5R2tlLzg2ZnRvMWY1RHBhend0eTlGbXVJbUpKRlIwRnNX?=
 =?utf-8?B?SFJocVZ3RXoxUG8xdHoyTWFraDhMVUx4MkJ3VEd6Z2p2ekJZN1RueDNlQWdX?=
 =?utf-8?B?OU1EMnFaV3MxUGFVY3h4amN1WWhranVFcGovT1VTb1d2ZmVTMWd0Z0pGZURi?=
 =?utf-8?B?V1ZJR3NYRE9QTGMxYUFUZDdQdGU3OWtYWFNFYWJ0Rjc2WEVrbU4rd2RTRGtU?=
 =?utf-8?B?bStGY1FiNWswQTE2Q1h2aXhZY0JxRGNGb3hNME12V1NXeDkySGZyallPbzBa?=
 =?utf-8?B?T09zbG1WYVA0WE5NMmdQQUlkRWFkMDRPTjhPMWpaV0Y4eWUyUGdxTEpKSHFD?=
 =?utf-8?B?NklOeC9aOUlSSXJ0ekwyR0ZhVEVoaEh6b09hTk04OFRaMUgrU2UvMC9rWkpE?=
 =?utf-8?B?QzMwS0NVWEtXU1pIUVB1WlVaRGpXQkl1WEZVcDNNMU5pbldwTzdoMm1NZk1I?=
 =?utf-8?B?MCtyOE9pb3Zia2hvUFl2WFBoRWhQVkxmZ2NCdU1UWTRyZVhqSHIyS1ZKVWNh?=
 =?utf-8?B?bW1ZTGI2L1MwY1QwQ1dMbWxCdFZkbTZ4dmxaa0lGV3U5dGtacjNKbUc2T2dF?=
 =?utf-8?B?U2FDbTNDbHhNTVBZcjlwWUdLM0cxN2xIUnFydjBiQnp3anZRKy9ydmtzWE83?=
 =?utf-8?B?bXVqSWFha0lIZGhScmtOQm5iU2JHaElxVlQ5Z1lUdW9hblRVMWwvZUpscGFn?=
 =?utf-8?B?SEN4RGw1eWJ2UDdqNnZVbWY2bmV2RkF3bE1UcFhmQUYrOUZZYitwRU5hY09B?=
 =?utf-8?B?Ui8wY1poRXdheUZGc2ljWURXbzhGY1VNVTk4SVpUQWdGYzU5dW5OM2VWQisx?=
 =?utf-8?B?b2dxa0N5dXl6ZHhDWkthYnJEZzJiREJ5N0ZLRGJQalk4UysveXFmMUZuQzZl?=
 =?utf-8?B?dXR4YWIxV0lvcXNMUEU0dUlFb3RsZ2UrdnI4MFZyU0hWZGl4eUlSbXFHQjF5?=
 =?utf-8?B?Y05QMythd1Z5MjFZdHlSc3JTQVNyaFNhM040dFY0V2RjdnRLelZFdnBlOTIw?=
 =?utf-8?B?aXViSk9uQ2EwSjhxdDlMakF3UmNlSkhRT1FHOHNubkx2NWlPZ01zLzRISkx5?=
 =?utf-8?B?WklNeldUdmJESk9hN25HTklHQ2ppanJjYnVCSkVDampGamN4c3F3Zmo4Z0cx?=
 =?utf-8?B?S2E3ZUZsaWIvcm1hazVqSXZzSVpQcGNhZzEzQzVMUXhJeWhIbWdBbjhvZTQw?=
 =?utf-8?B?Uk56ZUVsOXY3cnJoamtsTHlRRVB6SHZSM0V4VlJEdHJib1VaYmVGSlZkUXhl?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7399999AACB564193800480715BF831@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z6lHnhxVcJY3J/Zr2Tv+ezr709PC0ritDY0lQ1wAvBGdvxZOx7egEL+uQSrSeyO/Ve7O/7NvDHIHROSAZpBUy3BRnZN01stRhziDxBU7x/L9A+lH9uzAxn0PNmfVvEOvz7EWhrjMN3mODf7cQrsVoBocSu+5/NnKOfVYNhZgQAD7o0XXYB+wgB5XMQ5Wf6Sg2puNokzU3ciL3x8boDoEbl3nmY8TPtVbzKX3yhI8v1N8j2goQ7ldl/ZuZ/XN2nxjKHoxZna38fLmwiKmbz6fK1Dgr5Dam+G93ly0/M6W0BkMp+U1YXQVEyDN3gkWXUVtxe5FIDmCnC2hAFY9f9zKDZll4zstG7ADhBvzxUe2HzCtuPNNxBM17W8JMcmTRQkADNqg3pAgfYbFfXn0pngVP0jzWeriOTYS/WFO2Ott5Uunn7Y1zOiWKRM5UsVl6w9Y+Eb2ji63e0qZStUqcdZ02hIv5XFsmwGCByoHznwV/YHBQSRTNP63xGGtaBC2btdFAfT+Kuq/Q/x1IFxkHghNsMUvj9EmTy1YvDuvWKBTo/kk31lFRLSQIomwkjWbisrj7u2YHbhkoZlW2qFq2RzvhZhEpPMo/+sKBMitw4ScOlg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9788bd-5ce2-4832-b75f-08dd02616c0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 14:59:20.4280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8R43g4kIQhPwROrJ/Opc4pznb2NkY416mFCmoKeseKpaFJasVUlYQZUOfgHPJH52UwuUIuY5cy5A5idc++3Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411110123
X-Proofpoint-GUID: HtbgDMQ9ef7tqZ3_CyP2azmZM7WXJN5-
X-Proofpoint-ORIG-GUID: HtbgDMQ9ef7tqZ3_CyP2azmZM7WXJN5-

DQoNCj4gT24gTm92IDExLCAyMDI0LCBhdCAyOjIz4oCvQU0sIFNlaWljaGkgSWthcmFzaGkgKEZ1
aml0c3UpIDxzLmlrYXJhc2hpQGZ1aml0c3UuY29tPiB3cm90ZToNCj4gDQo+IFRoZSByc2l6ZS93
c2l6ZSB2YWx1ZXMgYXJlIG5vdCBtdWx0aXBsZXMgb2YgMTAyNCBidXQgbXVsdGlwbGVzIG9mIFBB
R0VfU0laRQ0KPiBvciBwb3dlcnMgb2YgMiBpZiA8IFBBR0VfU0laRSBhcyBkZWZpbmVkIGluIGZz
L25mcy9pbnRlcm5hbC5oOm5mc19pb19zaXplKCkuDQoNCkkgdGhpbmsgdGhlIGJlaGF2aW9yIGNo
YW5nZWQgcmVjZW50bHkgZHVlIHRvIGEga2VybmVsDQpjb2RlIGNoYW5nZSBBbm5hIGRpZD8gVGhh
dCdzIG15IHJlY29sbGVjdGlvbi4NCg0KSWYgeW91IGNhbiBpZGVudGlmeSB0aGF0IGNvbW1pdCwg
aXQgd291bGQgYmUgZ3JlYXQNCmluZm9ybWF0aW9uIHRvIGFkZCBpbiB0aGUgcGF0Y2ggZGVzY3Jp
cHRpb24gaGVyZS4NCg0KDQo+IFNpZ25lZC1vZmYtYnk6IFNlaWljaGkgSWthcmFzaGkgPHMuaWth
cmFzaGlAZnVqaXRzdS5jb20+DQo+IC0tLQ0KPiB1dGlscy9tb3VudC9uZnMubWFuIHwgMjQgKysr
KysrKysrKysrKysrLS0tLS0tLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCsp
LCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3V0aWxzL21vdW50L25mcy5tYW4g
Yi91dGlscy9tb3VudC9uZnMubWFuDQo+IGluZGV4IDIzM2E3MTcuLjAxZmEyMmMgMTAwNjQ0DQo+
IC0tLSBhL3V0aWxzL21vdW50L25mcy5tYW4NCj4gKysrIGIvdXRpbHMvbW91bnQvbmZzLm1hbg0K
PiBAQCAtMjE1LDE1ICsyMTUsMTggQEAgb3Igc21hbGxlciB0aGFuIHRoZQ0KPiBzZXR0aW5nLiBU
aGUgbGFyZ2VzdCByZWFkIHBheWxvYWQgc3VwcG9ydGVkIGJ5IHRoZSBMaW51eCBORlMgY2xpZW50
DQo+IGlzIDEsMDQ4LDU3NiBieXRlcyAob25lIG1lZ2FieXRlKS4NCj4gLklQDQo+IC1UaGUNCj4g
K1RoZSBhbGxvd2VkDQo+IC5CIHJzaXplDQo+IC12YWx1ZSBpcyBhIHBvc2l0aXZlIGludGVncmFs
IG11bHRpcGxlIG9mIDEwMjQuDQo+ICt2YWx1ZSBpcyBhIHBvc2l0aXZlIGludGVncmFsIG11bHRp
cGxlIG9mDQo+ICsuQlIgUEFHRV9TSVpFICwNCj4gK29yIGEgcG93ZXIgb2YgdHdvIGlmIGl0IGlz
IGxlc3MgdGhhbg0KPiArLkJSIFBBR0VfU0laRSAuDQo+IFNwZWNpZmllZA0KPiAuQiByc2l6ZQ0K
PiB2YWx1ZXMgbG93ZXIgdGhhbiAxMDI0IGFyZSByZXBsYWNlZCB3aXRoIDQwOTY7IHZhbHVlcyBs
YXJnZXIgdGhhbg0KPiAxMDQ4NTc2IGFyZSByZXBsYWNlZCB3aXRoIDEwNDg1NzYuIElmIGEgc3Bl
Y2lmaWVkIHZhbHVlIGlzIHdpdGhpbiB0aGUgc3VwcG9ydGVkDQo+IC1yYW5nZSBidXQgbm90IGEg
bXVsdGlwbGUgb2YgMTAyNCwgaXQgaXMgcm91bmRlZCBkb3duIHRvIHRoZSBuZWFyZXN0DQo+IC1t
dWx0aXBsZSBvZiAxMDI0Lg0KPiArcmFuZ2UgYnV0IG5vdCBzdWNoIGFuIGFsbG93ZWQgdmFsdWUs
IGl0IGlzIHJvdW5kZWQgZG93biB0byB0aGUgbmVhcmVzdA0KPiArYWxsb3dlZCB2YWx1ZS4NCj4g
LklQDQo+IElmIGFuDQo+IC5CIHJzaXplDQo+IEBAIC0yNTcsMTYgKzI2MCwxOSBAQCBzZXR0aW5n
LiBUaGUgbGFyZ2VzdCB3cml0ZSBwYXlsb2FkIHN1cHBvcnRlZCBieSB0aGUgTGludXggTkZTIGNs
aWVudA0KPiBpcyAxLDA0OCw1NzYgYnl0ZXMgKG9uZSBtZWdhYnl0ZSkuDQo+IC5JUA0KPiBTaW1p
bGFyIHRvDQo+IC0uQiByc2l6ZQ0KPiAtLCB0aGUNCj4gKy5CUiByc2l6ZSAsDQo+ICt0aGUgYWxs
b3dlZA0KPiAuQiB3c2l6ZQ0KPiAtdmFsdWUgaXMgYSBwb3NpdGl2ZSBpbnRlZ3JhbCBtdWx0aXBs
ZSBvZiAxMDI0Lg0KPiArdmFsdWUgaXMgYSBwb3NpdGl2ZSBpbnRlZ3JhbCBtdWx0aXBsZSBvZg0K
PiArLkJSIFBBR0VfU0laRSAsDQo+ICtvciBhIHBvd2VyIG9mIHR3byBpZiBpdCBpcyBsZXNzIHRo
YW4NCj4gKy5CUiBQQUdFX1NJWkUgLg0KPiBTcGVjaWZpZWQNCj4gLkIgd3NpemUNCj4gdmFsdWVz
IGxvd2VyIHRoYW4gMTAyNCBhcmUgcmVwbGFjZWQgd2l0aCA0MDk2OyB2YWx1ZXMgbGFyZ2VyIHRo
YW4NCj4gMTA0ODU3NiBhcmUgcmVwbGFjZWQgd2l0aCAxMDQ4NTc2LiBJZiBhIHNwZWNpZmllZCB2
YWx1ZSBpcyB3aXRoaW4gdGhlIHN1cHBvcnRlZA0KPiAtcmFuZ2UgYnV0IG5vdCBhIG11bHRpcGxl
IG9mIDEwMjQsIGl0IGlzIHJvdW5kZWQgZG93biB0byB0aGUgbmVhcmVzdA0KPiAtbXVsdGlwbGUg
b2YgMTAyNC4NCj4gK3JhbmdlIGJ1dCBub3Qgc3VjaCBhbiBhbGxvd2VkIHZhbHVlLCBpdCBpcyBy
b3VuZGVkIGRvd24gdG8gdGhlIG5lYXJlc3QNCj4gK2FsbG93ZWQgdmFsdWUuDQo+IC5JUA0KPiBJ
ZiBhDQo+IC5CIHdzaXplDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

