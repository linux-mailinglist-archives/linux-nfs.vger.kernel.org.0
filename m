Return-Path: <linux-nfs+bounces-4836-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B02492EEA4
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 20:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8324A1C20B7C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4569A16CD18;
	Thu, 11 Jul 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RJucBlfl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aBVqZnRH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7370316C68D;
	Thu, 11 Jul 2024 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721798; cv=fail; b=cDOSI1VqjKsw5ZkuibG52p4jDC4/ZT0ufa6D9Pk/dNLcQS/HpgBoddoTmPg8i3c2sunWArOjtgdgk16Hew/fXa4t8btPLh/ezmrcLpjKmymKtkihLHq3l4DLJhKVNLsATB0GM2I8l3Dp5gBMh2U4bBInaedR5mBZnezn0WdsYUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721798; c=relaxed/simple;
	bh=2cxO/+8jDncfCWPFfOafTxwnKGF3l7qzuOhZaEl2Cf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYiGvL94bfqi8HvL0SHXc7rsm5Z6k49Pv8tXFs9DrwAQdFs2AXY04xGorCNxWFaPAWlFN7nmfW6M67LaAZv8886OJ6Ev9/qrFvtW7q6adS9M9907rPzVhQc3AB5909xOb6yR4+FmFk5E2CmivGVCenSCXF7OmDhVZhkNOBsDH/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RJucBlfl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aBVqZnRH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBZxm008230;
	Thu, 11 Jul 2024 18:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=2cxO/+8jDncfCWPFfOafTxwnKGF3l7qzuOhZaEl2C
	f8=; b=RJucBlflbtRssRsW/t40+jS/ZOEn3mE8c7RuxeuaTmCyP+BDaenQoyZRo
	Vr4ucheIz6dN7EL0QZnS7OV3F3K2rI79tdRVQpi3ADp9qo1Nf3KZ0E9ikApFbX6U
	RmXUZX22HkzcGnHu8Yom8ZUVJmssWmNPv80BHI5Kh2eQ1u29gXB0fmX5hCxOnqFN
	CR0bNlVxm5KxdwzOmirClnEdlwBMvCbdJJFd/GRnqK8w972iJ1r9IzPGpP2ngEvJ
	PugbJPPoyzBow+EtHzSP+EqsDLhiB/2TxfQYKFptm4omQDal0N3hWPU906xR4Zj+
	ZxwAGUv3wyWSpxKg1eh+mg50JHvNw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkyac6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:16:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BHldJe029964;
	Thu, 11 Jul 2024 18:16:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vvbmwv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rri0mmx6hWq1iWhhDAUEEbaxIYONpmK41HAq+FAhNIs0f6YQt0nn5YBKSWTg2YmL5sJhxApgMD3MAU9WGwlziX6aoJD6ZRwQbBRaBpgCMTzwMBwBxjeNsh5Btd4MkCiQn/9NqsD/m9W+vzU6x3ko2q2WRhR0n+16Q5ueWJiIrZhDbjjRdx2EUf8DpIWUG++hgkfWylPls/UggxxWQx8xp6Jr6HZ535kAFUHSPXOVeKchBOEzH/TaEfPuBfb3o8QRyQip++beXG4nI2Z/qM3L5tl87c7S4l1ZfMI/m4wzUaiD8+4b31JDKM8oeTDmyxeEApRmX0woEkYs40XQtbzKYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cxO/+8jDncfCWPFfOafTxwnKGF3l7qzuOhZaEl2Cf8=;
 b=g1xw5xC6x4QK5D+wQGxbLdnX989UV099dyi2+aSmlaNxW2BLQf/gAWx3T1Gzih5FGQk6e0xfWdbehY1rH5zeiw6tNwvJYGcRfkux+UaLtZuUMc2j7+mC1n2P8x93I+XMiDu2jU7Tmwxz5T9jc2VueVjxcXd8ReEgB1J5/wAQWBDnu28HmWaHbMK8AA5v4MAxTDV72SAlIK4fKdFgh1wYvD/k90+ihPopLeBKZ+fcx25Y4s4BX0uRI9Vw06KSAOliWqVhP8suaJ/e9Q0xGs/ewr6Ee5BvVoIJgDbxmowE14crrmWjdWaTIj5EXrluHt0MJRYEJP3ripoI2glwmNnGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cxO/+8jDncfCWPFfOafTxwnKGF3l7qzuOhZaEl2Cf8=;
 b=aBVqZnRHRf8pY+GCMdHUSKwwiFn5Apywa2X4nxwUPRV9QflFe4vl5ffm33inddvWCT4S6DktUMwzCG9uRnweFwcvWZvmJk07Vh1ZRAytbEz09lwrMrwhiW0OX7wQjVnB9FsggKSd6nueP5U7X+Ztu0iHHI5T094u1NCd3nhibqc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4915.namprd10.prod.outlook.com (2603:10b6:208:330::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 18:16:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 18:16:17 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Youzhong Yang <youzhong@gmail.com>
CC: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo
	<dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] nfsd: fix refcount leak when failing to hash
 nfsd_file
Thread-Topic: [PATCH 1/3] nfsd: fix refcount leak when failing to hash
 nfsd_file
Thread-Index: AQHa0soGF/qQvWTZV0unhYKg8rR63LHxw4CAgAANUACAAAZmAA==
Date: Thu, 11 Jul 2024 18:16:17 +0000
Message-ID: <1874B388-3A15-4D06-A328-C8581F5FE896@oracle.com>
References: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org>
 <20240710-nfsd-next-v1-1-21fca616ac53@kernel.org>
 <CADpNCvYknMBXf+V=vBLkjOMhTFRN-3o2R9A2c5J4POuaD49kMw@mail.gmail.com>
 <50afe4a63be26a946257c335188e230c86beb148.camel@kernel.org>
In-Reply-To: <50afe4a63be26a946257c335188e230c86beb148.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4915:EE_
x-ms-office365-filtering-correlation-id: e857d31c-d336-4afa-f928-08dca1d58e85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dzIvR0RGVXhIclhxdHAyVkRrSGt2ci9ncEF5MDh6WXl1ZXR5SHhVZUhFU04y?=
 =?utf-8?B?dWxrMW9pcStIUEduZFhSaWdWUHRCTDE4NmFMNG5pMzBYRzRhZ3pncUp3aFhG?=
 =?utf-8?B?a2ZTRUUyaS9VU3hEbmlROHhhWTREc0xZT0Y5UVBJVTJNaXdVMnVtWUhkaGZC?=
 =?utf-8?B?aGh0dU1rZkFmWXdVd2orcGFPaHZMakY5OFZqVDhQNHp6eEM4d3Z4UTVWMU0r?=
 =?utf-8?B?VnpUK09SaW9aL0lQUjJ4aWRtOTV4WFhPQklIWmx4YmpsUVVwcnZadU52MkdN?=
 =?utf-8?B?TURYTzMwQWI3bFJlenlBTmZVVHFTSkxQa0VyeTJ4NStDV0ZkcHFYTlNEc0hm?=
 =?utf-8?B?S1I2TVVpelM5TTA1SWFWcmk3REpWckdRYUdPeVJ3dnlEUGxoSUNYdWYyM1kz?=
 =?utf-8?B?SUNOY1JGNU1wNXhqVWdMYVcyUnpmL1Jtb3ZwTC9yUW9ZcGErU3pwS0NlR2Rz?=
 =?utf-8?B?M3RZNURmV05xUFkzYUdKVDJVRng0ZE5XaGkzME5UODc3L3pzZkNQMEEyQzV0?=
 =?utf-8?B?Z0R3MEtTM3g3dlFZTkV4NjNsNlZRY1NJZjRSUklVeW12K1hrMmRXdGRyWnFX?=
 =?utf-8?B?MjBNOEFaYndxTEYra09oTkQrT1M1ZXRHUjBRUHZ2b2FYVnVFalNtbDhybE8y?=
 =?utf-8?B?a3FzR1lZbTRxN1QwOElWcldCa0RYWlByckRuNExUcDhLczIwdU5FL3V5K2Rr?=
 =?utf-8?B?WFZSNEROZENwQWZVUW9yU1FWMEtCT3JOTkdPSDBTQU9TeG9SdTUxRklrOFBu?=
 =?utf-8?B?Q09FV1J2cy96SkRmSytMZU15amVFaGcxSnNvQWJIZENaWG5EQWdLa2ozbmpt?=
 =?utf-8?B?QWZmTm9uaEFuTHhsREpnb1JqUStPSnFQdEtZeTNIRzZ3QWdDMEZpTkdTdzA0?=
 =?utf-8?B?bkhBZFZsOVQ2WUJTRXNJTHJPU1V2OUxJcnAvcWhvd2ZmYkJuby95WjNyQmd4?=
 =?utf-8?B?N0FFZDYrbDMyT1NJcElBZC80Z2xGNjZ3bEFjVXZMbXRwR3hvaE5LNkIvVU5s?=
 =?utf-8?B?Y1BtdThQZ3RqNmsvR0ZoN0t4eG1kQ2xOdWtSbElzVkU1a1hwTW41ME1JWEpE?=
 =?utf-8?B?cEx1bW1Xb21OTFpaVldUcVVUQW0yZDdBdGZRUm4wNjYwZjU3cHg4SVZWUnl4?=
 =?utf-8?B?M3NhTGs3UDZiejVPSW5TUjZPaE5qK1g5bWxlajNHeVVocElNK1pRLzh4TUdF?=
 =?utf-8?B?YnJtV2lxcTMvazFUMllTRXVIYjN3TDEzRnd4MU9qSFFSbVF3KzRmZG50L1hY?=
 =?utf-8?B?eVFCSFJlUkRVN3JkT2JoVGRJU25HNnJ2eXdLUjlialVkajQ5dEF4ZHloMUVD?=
 =?utf-8?B?R3JzeXRNdG9lcCtReU10RnMzZldGSzdIdEdMeGp0bU5BL2N4ZEsrKzZ2c2ZJ?=
 =?utf-8?B?dktiakV5T1FRTkdSSUZpNEJIQjB2b2VjeGpwd2JjOFlUWWlEYWF3VVhwRDdq?=
 =?utf-8?B?ZDdENTdNZStZWU1wZ3RWeDdlZ3Y3Wkp3eUNqMjhmS2ZocUE3bm56R1Z1UGtq?=
 =?utf-8?B?Y3pFNUZ6M1k2L3ZFN2IxOCtRS1I5a0hoZ2Z6VFNDbUx4RkZnT0k3ZzR4anJv?=
 =?utf-8?B?ZXVCUnRMQWJ4WVJZRGJHSjB5UXdKRk9LeFBJN2o2NDd5WlNKNjNkWGRwTGlN?=
 =?utf-8?B?eFh6SjZzeVZvWCtZNE1NdlhxKzZyaU1BVlJzSHNBT2lMUkVlNlErS2NKTTZw?=
 =?utf-8?B?a1RIYjYyRHJITTRES1JnZGU2RFBhL0JKUTJkbS9OSmoyUFBPK3BRS0dwNkxS?=
 =?utf-8?B?RnZBVTVjUGxQdWNLN2lIMFpReEZqd3UwYTJTWnJXSzZwbFBIWkFsMlhWZjZi?=
 =?utf-8?B?amlyOUpubCtBd1p0dnBCZTVoMHZhRms2RUVLS3o2WWJPbGxzNFNLVUY4b2pX?=
 =?utf-8?B?WVV1SzM0TmpFZWwzVTYxNkhTVjNVUi80VnRjOGxESG1Ob1E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VHlqSlVNaCsxeGFhaHdtN3RqaC94V0xoSmJ3SkVJdnNBWWhXTVNNN0pVb2xl?=
 =?utf-8?B?Y2NqV01hQ09jZHFLMzQ5b1Q0U0plUkdhcFpyb1l0cGs1Z00vdnM3bzdQYi9F?=
 =?utf-8?B?cDExd3BXaXFlZ2d3UUpQSzBXVGp6ZCt6cmVrWGNHYThNM3MrRi9HL1pCeG1T?=
 =?utf-8?B?ZVpEZ3NxYjB3bHc0eHNzRk9kb3k4SHNqdE94SjdhWjVSZXE3NEVtZWdRTjY2?=
 =?utf-8?B?RTljc2loaXBOeEhFVWJaNytJMmN5WnFyMjhNMFVKbG9ZZFRpbFV3dmtJcGpO?=
 =?utf-8?B?UFhxODVsVGFEbmxXSm92SmNIbng5MWplTnhBV1J3QVlqMnphSkRadmh3TWQw?=
 =?utf-8?B?SHpZM2NUMTNRc1o5ZnBvYys4R0FqSjNBbzRYTzd3V3gyTEx2T3ljSW0zdEt6?=
 =?utf-8?B?ZGRzUkpDWnlZSGdLM2VSemtPbzJuRWQyOW9NeWNKbHZyb0Q5MXpwU3VRNmJ4?=
 =?utf-8?B?bXZkRjVtVTZpSGRjOVFaQjdJUE1xRkcwS0ZrclVKa0RXaVRkQkRlVUN2dU1R?=
 =?utf-8?B?QUtCQkNzTWFCTWpZcmNxcWk4VkIxUVdXOXJqeVlJYy92dUVTQ0YzaXNYVVdq?=
 =?utf-8?B?eGdyQnBuaTBHb3JHcmtwMlFVRVFEN3hma3ZkeURCNmxTNzhTcW5PMzNmRTJI?=
 =?utf-8?B?bGozMEI0UE5ZZmpiUy9WMURVV2N0bUZSb3RNTkJBY0Z4Q2lUWWp5ZCtUaDhY?=
 =?utf-8?B?WE9ycENEUWRXSjZYV21FamNqU29WaVZTMjNQUWZKb3VqdWVHNytrSjU4bTlp?=
 =?utf-8?B?dmVzVFBzTWY5dVViRzBSd0xYK1BZeUp1c0FEZ0d4Mm9MVnFVOXZzbDZOWjlZ?=
 =?utf-8?B?YVc4eTVrZjRDb2d6UFJoN2w0eElsNVcxaXBRc2tpNGt5QUpqTXp3T2N0dDlN?=
 =?utf-8?B?WGhFWlRKakJaSUZmTmNkdU8vckZTcm4wZmNsNW1IeTh5Nm5FUWppWmVEbHhF?=
 =?utf-8?B?OWVSZForNk1rY0tIWitGcVM5aTh2bGV3cGduREV5UXk0K3UrZEN6KzJSdGdv?=
 =?utf-8?B?L0szMnZPT3JNcnRzUm5hNTZxZVNncGxjd2VDb0JZM1VjbkFmWk9ya3c5cEd3?=
 =?utf-8?B?bDYvNkMvYkFBblhCbHF6WCs2blJnc1MxSnRxTmhFdWdXMmJLOEZDSVlCT2Q5?=
 =?utf-8?B?RHRsWWdYbnlTZjduZVVjeGNORTUxelNwWTYzZm5UUDJsWkxtTGlzN0lGOUJL?=
 =?utf-8?B?SDRiSWJtR0NZWmQ4Q1VWSGRLL3UrbE8yNExGS1JxNGlqR1RLY25DSnFRVnZr?=
 =?utf-8?B?VHNQUElDdERtUFNTSVk2TFJnWEhsRUNqdjNqT0dVN1BFTnlxTEFncG5jOHJ5?=
 =?utf-8?B?V3dvYUV3NjRacmdTN1pvRDl2a3QwRDBmaVUzNXlTS0RHekJ1UW54eHBLbkor?=
 =?utf-8?B?endMUlZGaGRPMUR6bFB1Z3hnWkcyY21aVExSVDB1emJQUEw3dU05dU45ZEdI?=
 =?utf-8?B?cVMyYnRaMHVTQ2RlVExaYXBaT21VMXp6ejhMTFBGMVlOdlp2OVNBQ04zOFVt?=
 =?utf-8?B?OW0wZWwrSXkzTU1ZV3NSQjljeWY2R053bnR4bXpCU0NCYlZJckRvMGFORTdu?=
 =?utf-8?B?TkIxR2VVRVVnWk5vVjg0NjEzOHNXbXZEWHpJVWJxRCtKTWRUMXE5R2U1eFpC?=
 =?utf-8?B?ejdZYTgvRU5NQTF4M24zMkwvdnZwZnZiVnVlOGhHdFhlR1o1UjhwVDc4Uzk2?=
 =?utf-8?B?WVh1YVJySkR6NXhYYy9hK0liVTJWZ2NKVjdrTVhkOWd5SDIrVkFXQVp1Z2ta?=
 =?utf-8?B?dkFmNDA4eS8zbFR5VmpQUlRqeFViTFh4VVRlSG5oZGt6U2pWUUdTaDY0SWYx?=
 =?utf-8?B?RmJ5cUJ0RjRKMC9iTit3enhUdTFibzNjSThHZGozRFJCdkk5bVFHcHpPaFVm?=
 =?utf-8?B?WkRZZXZMQktGa0daSDI2M0Q0SjliZlpZTkVnQ0tKRFp0K2NRcXlRclJKcGYx?=
 =?utf-8?B?Ymx0SEw3VUIxNy9pUDNra05aVEZVTTJmSU44LzF5YnYxckdnTGJzc3B6bDVt?=
 =?utf-8?B?Y0dGQzY2RTBVa3REdjV0RzR4c2E1WXpzYzJhdm5NUzdxZWgrVjhscTZpSGZj?=
 =?utf-8?B?U09CVzRoaDgwTmpPUlA0SjFJSjE4RWhzUEhOZXZiRCt3SEZ4MTE0WG8rNVpB?=
 =?utf-8?B?ZGNHOHBkNkU5d1FaMlFKZVFGQThvd3FnN2VDYU8wYk5ZQmRaMzcvV1VrUkdm?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DBA5FA43EB50543A12998982FCB212A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3FbTFlUooZt6vP2hOydmB5v351u3lvbpw3eNlR6lHW0h+4DZH04uB7FOkcykfpm7e58KpdH+7tIOYutOmrwgFgpzaEOWBtaQKLeTWpg7+x/jwxyOISP/LtE0oM5Gl18hkewPNjh8lrmN2XGXqEAAxqBBq9pxAtKvuOXhL1kUqB7ftaIdtbQlP1ywuEkro5ZILSYv6+tlkSlFfLxuajzQimC/Yz2h9vLzGMss4X3GA2YJBJ33L0vU0XoFfitNbapqD9VXw4CBmixWzNrar7P2MjiF490D9/6Rtfj7X9SIPAwgiubY9rHg0KyEQLYTzMkC9BcuZW3uPaqf40PKG8n/a5P9Y5jcJePZj104cfi7KCoHvBLriNDbkT2+ixHKVym2bHL3Da4vn+0T6HJGdBAJOd8Q5Ct5ZU4fhLXFlZT11HK4chVxCivgX88IxlW/l4XEQC46kVn51cLyDBdNGdtEIPBD+o+FfQ2t10nM1WsOszvctDSu+oNLCDQ2K4tbwg2B5qOlwui03fgnfoAyTsqvQflbS/qs40qGz4eKcbJOXWTtOBtgDJjzJbP0taCWQUTmUvYdZhcdT2Pxxy4/qx6MbsweYA32tKAijoS+QySDRao=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e857d31c-d336-4afa-f928-08dca1d58e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 18:16:17.0607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EvyXdYXkSyW1I2GbG6b9iSTH8/eZq+n0hNMH4k1xnAkXk8e1CR4db2jbE7W3UcXwLz9XeMM55Rroont7TtFqVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110126
X-Proofpoint-ORIG-GUID: do_5g693rHULASReYOsFEDwewakpiDMj
X-Proofpoint-GUID: do_5g693rHULASReYOsFEDwewakpiDMj

DQoNCj4gT24gSnVsIDExLCAyMDI0LCBhdCAxOjUz4oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI0LTA3LTExIGF0IDEzOjA1IC0w
NDAwLCBZb3V6aG9uZyBZYW5nIHdyb3RlOg0KPj4gU2hvdWxkbid0IHdlIGhhdmUgZmhfcHV0KGZo
cCkgYmVmb3JlICdyZXRyeSc/DQo+PiANCj4gDQo+IEEgc3VidGxlIHF1ZXN0aW9uLCBhY3R1YWxs
eS4uLg0KPiANCj4gSXQgcHJvYmFibHkgd291bGRuJ3QgaHVydCB0byBkbyB0aGF0LCBidXQgSSBk
b24ndCB0aGluayBpdCdzIHJlcXVpcmVkLg0KPiANCj4gVGhlIG1haW4gcmVhc29uIHdlIGNhbGwg
ZmhfcHV0IGlzIHRvIGZvcmNlIGEgc2Vjb25kIGNhbGwgdG8NCj4gbmZzZF9zZXRfZmhfZGVudHJ5
LiBJT1csIHdlIHdhbnQgdG8gcmVkbyB0aGUgbG9va3VwIGJ5IGZpbGVoYW5kbGUgYW5kDQo+IGZp
bmQgdGhlIGlub2RlLg0KPiANCj4gSW4gdGhlIEVFWElTVCBjYXNlLCBwcmVzdW1hYmx5IHdlIGhh
dmUgZm91bmQgdGhlIGlub2RlIGJ1dCB3ZSByYWNlZA0KPiB3aXRoIGFub3RoZXIgdGFzayBpbiBz
ZXR0aW5nIGFuIG5mc2RfZmlsZSBmb3IgaXQgaW4gdGhlIGhhc2guIFRoYXQncw0KPiBkaWZmZXJl
bnQgZnJvbSB0aGUgY2FzZSB3aGVyZSB0aGUgdGhpbmcgd2FzIHVuaGFzaGVkIG9yIHdlIGdvdCBh
bg0KPiBFT1BFTlNUQUxFLiAgU28sIEkgdGhpbmsgd2UgcHJvYmFibHkgZG9uJ3QgcmVxdWlyZSBy
ZWZpbmRpbmcgdGhlIGlub2RlDQo+IGluIHRoYXQgY2FzZS4NCj4gDQo+IE1vcmUgcG9pbnRlZGx5
LCBJJ20gbm90IHN1cmUgdGhpcyBwYXJ0aWN1bGFyIGNhc2UgaXMgYWN0dWFsbHkgcG9zc2libGUu
DQo+IFRoZSBlbnRyaWVzIGFyZSBoYXNoZWQgb24gdGhlIGlub2RlIHBvaW50ZXIgdmFsdWUsIGFu
ZCB3ZSdyZSBzZWFyY2hpbmcNCj4gYW5kIGluc2VydGluZyBpbnRvIHRoZSBoYXNoIHVuZGVyIHRo
ZSBpX2xvY2suDQo+IA0KPiBDaHVjaywgdGhvdWdodHM/DQoNCklzIHRoZSBxdWVzdGlvbiB3aGV0
aGVyIHdlIHdhbnQgdG8gZHB1dCgpIHRoZSBkZW50cnkgdGhhdA0KaXMgYXR0YWNoZWQgdG8gdGhl
IGZocCA/IGZoX3ZlcmlmeSdzIEFQSSBjb250cmFjdCBzYXlzOg0KDQozMTAgICogUmVnYXJkbGVz
cyBvZiBzdWNjZXNzIG9yIGZhaWx1cmUgb2YgZmhfdmVyaWZ5KCksIGZoX3B1dCgpIHNob3VsZCBi
ZQ0KMzExICAqIGNhbGxlZCBvbiBAZmhwIHdoZW4gdGhlIGNhbGxlciBpcyBmaW5pc2hlZCB3aXRo
IHRoZSBmaWxlaGFuZGxlLiANCg0KSXQgbG9va3MgbGlrZSBub25lIG9mIG5mc2RfZmlsZV9hY3F1
aXJlJ3MgY2FsbGVycyBkbyBhbg0KZmhfcHV0KCkgaW4gdGhlaXIgZXJyb3IgZmxvd3MuDQoNCkJ1
dCBtYXliZSBJJ3ZlIG1pc3VuZGVyc3Rvb2QgdGhlIGlzc3VlLg0KDQoNCj4+IE9uIFdlZCwgSnVs
IDEwLCAyMDI0IGF0IDk6MDbigK9BTSBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0K
Pj4gd3JvdGU6DQo+Pj4gDQo+Pj4gQXQgdGhpcyBwb2ludCwgd2UgaGF2ZSBhIG5ldyBuZiB0aGF0
IHdlIGNvdWxkbid0IHByb3Blcmx5IGluc2VydA0KPj4+IGludG8NCj4+PiB0aGUgaGFzaHRhYmxl
LiBKdXN0IGZyZWUgaXQgYmVmb3JlIHJldHJ5aW5nLCBzaW5jZSBpdCB3YXMgbmV2ZXINCj4+PiBo
YXNoZWQuDQo+Pj4gDQo+Pj4gRml4ZXM6IGM2NTkzMzY2YzBiZiAoIm5mc2Q6IGRvbid0IGtpbGwg
bmZzZF9maWxlcyBiZWNhdXNlIG9mIGxlYXNlDQo+Pj4gYnJlYWsgZXJyb3IiKQ0KPj4+IFNpZ25l
ZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+Pj4gLS0tDQo+Pj4g
IGZzL25mc2QvZmlsZWNhY2hlLmMgfCA0ICsrKy0NCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS9mcy9uZnNk
L2ZpbGVjYWNoZS5jIGIvZnMvbmZzZC9maWxlY2FjaGUuYw0KPj4+IGluZGV4IGY4NDkxMzY5MWI3
OC4uNGZiNWU4NTQ2ODMxIDEwMDY0NA0KPj4+IC0tLSBhL2ZzL25mc2QvZmlsZWNhY2hlLmMNCj4+
PiArKysgYi9mcy9uZnNkL2ZpbGVjYWNoZS5jDQo+Pj4gQEAgLTEwMzgsOCArMTAzOCwxMCBAQCBu
ZnNkX2ZpbGVfZG9fYWNxdWlyZShzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLA0KPj4+IHN0cnVjdCBz
dmNfZmggKmZocCwNCj4+PiAgICAgICAgIGlmIChsaWtlbHkocmV0ID09IDApKQ0KPj4+ICAgICAg
ICAgICAgICAgICBnb3RvIG9wZW5fZmlsZTsNCj4+PiANCj4+PiAtICAgICAgIGlmIChyZXQgPT0g
LUVFWElTVCkNCj4+PiArICAgICAgIGlmIChyZXQgPT0gLUVFWElTVCkgew0KPj4+ICsgICAgICAg
ICAgICAgICBuZnNkX2ZpbGVfZnJlZShuZik7DQo+Pj4gICAgICAgICAgICAgICAgIGdvdG8gcmV0
cnk7DQo+Pj4gKyAgICAgICB9DQo+Pj4gICAgICAgICB0cmFjZV9uZnNkX2ZpbGVfaW5zZXJ0X2Vy
cihycXN0cCwgaW5vZGUsIG1heV9mbGFncywgcmV0KTsNCj4+PiAgICAgICAgIHN0YXR1cyA9IG5m
c2Vycl9qdWtlYm94Ow0KPj4+ICAgICAgICAgZ290byBjb25zdHJ1Y3Rpb25fZXJyOw0KPj4+IA0K
Pj4+IC0tDQo+Pj4gMi40NS4yDQo+Pj4gDQo+IA0KPiAtLSANCj4gSmVmZiBMYXl0b24gPGpsYXl0
b25Aa2VybmVsLm9yZz4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

