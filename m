Return-Path: <linux-nfs+bounces-5145-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18F593F86E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 16:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D6F1F211FA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AF415530C;
	Mon, 29 Jul 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ClSTLd5J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JqCSsLYu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAB154C0C;
	Mon, 29 Jul 2024 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264073; cv=fail; b=T99Q1DDf5+ifnmFRkIXg25FSG7ukjtAzIaDknVRsHAEycdnNpellKBMgQN44y1DMq/1ykxAXZSYlpuZqp7fUx/x11qWkNmsckdItqFZ8oTktkC7MEmApz8Vwjrg3GnAO5VyntBZUnUCu3Q8RZLwysRzFAd1iekP01rSLZSU9n30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264073; c=relaxed/simple;
	bh=nR+Er5pJGm/IhQJ5H9ZKbc/2GuZaxKCvKa+Thy1Xq6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YKYdHHWuXT55wn9u7KRkOCRmos4aXNbBsoekI/UP3x9ptgLEFEP6nq+hRBrFkbm4iz87zhjpEmO+Pn8FHiX4ggnp0q4xbLm8kXNn0d5673/7qnmma61lI9+kobpKusobvidluS80SokxF/DO+p6oJPOTDd6vH7J65NJxCTL8jlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ClSTLd5J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JqCSsLYu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MV6t006540;
	Mon, 29 Jul 2024 14:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=nR+Er5pJGm/IhQJ5H9ZKbc/2GuZaxKCvKa+Thy1Xq
	6s=; b=ClSTLd5JprXimEbh7gFLTS5HOtYy9rQoNBFzsOv+NyOD1w472T2rPBCcr
	CDaJy35wsSm1eCIqzVGOlts8MKuUqSPqjbIs7dyXBT4d47tSUBN7KDH/+S1KMDXJ
	Ql5yT+Xvyvz3ABB0+xVda5KGFbT5rAqzCjyZ9zCmu5db30yi41f9jVVutJf9erRx
	HA68tqqQCL6gCc6Hq+NKjSIvpT3c8LAtg3fc6yPQZQCjjkhXKBeRqzwAYdVKYtJf
	brfCxbMCA7tuXvgI9OUzcO+UCPIMKqml/BrLFW7dEUWHZu3yLrfFSwMnMZC74Uxm
	ivKK5RuzmxF0woZ+xrwPiAG0OTV3g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqp1tu3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:40:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TDUSOY003809;
	Mon, 29 Jul 2024 14:40:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4bxtjwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:40:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoCeraWjXC/xbVmN5bhFTDfJdu1CP+OAgvMSDAHwAwoR5sGKY1nRoVv5hk+JbWHPbCMeUhweapON7Hm8uS9LtQRRKBF8HOnnnOCeCwu4Ust0jrSGFGLBDXefym3XEgj86uatLo7oYFFhQYufhfBOnL4s5C60RymiwJM5MXw7XgLTGxCZzRV9hnda2fGPtKby2AB5uPzAkfEleue4rQYKVdM6zHdAf4ekihuDqKrFAMtxN6h/aGBCST8jJu/US+Q9wRnsfKuXEuiA77FJqexe2pDbttwWhS01ozR6gLvro4rwfQu7xw/b/CBIlJ5yhMdT8RGiR418/gKLr+J2CTCt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR+Er5pJGm/IhQJ5H9ZKbc/2GuZaxKCvKa+Thy1Xq6s=;
 b=v3iTp+3BjqkYs1Oc/gFl+RaB9iBBaNloY65NMQhP/cAOx6bn2E4f2lwRZuQ5SgAOCLW7SEwA7pmxK66p43uskEJSLsGk+b2jByPO53CjdY+PN8YRwEf3mTluMwLvItUplLlBuk4Zk5aVBcWx2EjM5Qni0z8qrSkYQ0wwNZOgB3fvyOw3/1nSvh/BgqhNgspqqltD37teZQJOE8B+QtkrzB3YuXldyMknJc6Oxi/YWlWg4R/atmvZuoQSfEY/bkxw/VAXshHOE6ihvlpSDL6HNIpXpyHgRFtfXoBtwuF7Dt1ko6Y3S+2L9kz6wD0jLN296th7Udlh5Mdwlc0ELS2O2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR+Er5pJGm/IhQJ5H9ZKbc/2GuZaxKCvKa+Thy1Xq6s=;
 b=JqCSsLYuO/ymdjMisuNMYhOpCorOM3fcZkWXal5YtpTbaDUtV35xt0shDxET3mhjmTCgIChAqKuIPBw3WG3psqdPC98+DWNATCDNb318rHsMsVrLRjvQzfgeLuzINQKrGijzh4/AQ+ed131dZCqL5w3PBMuMY2u//EnMnU47BaI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6180.namprd10.prod.outlook.com (2603:10b6:510:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 14:40:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 14:40:56 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Youzhong Yang <youzhong@gmail.com>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: remove unneeded EEXIST error check in
 nfsd_do_file_acquire
Thread-Topic: [PATCH] nfsd: remove unneeded EEXIST error check in
 nfsd_do_file_acquire
Thread-Index: AQHa08Yq8dAoUHuGG0ySvfdkXiRhZLH28/UAgADIw4CAABwBgIAWBlEAgAAEAIA=
Date: Mon, 29 Jul 2024 14:40:56 +0000
Message-ID: <4E09E6A0-8C84-4598-BDF4-DC9CC9C9D686@oracle.com>
References: <20240711-nfsd-next-v1-1-f9f944500503@kernel.org>
 <172100324023.15471.746980048334211968@noble.neil.brown.name>
 <85dcb63bd31b962039269bef6e3791c82cef9ecb.camel@kernel.org>
 <ZpUsz61KzRosNNtm@tissot.1015granger.net>
 <CADpNCvYpeJ-2sRCpeAC=320SL5KrBvCRMHa+BQdN5XeWATv8BA@mail.gmail.com>
In-Reply-To:
 <CADpNCvYpeJ-2sRCpeAC=320SL5KrBvCRMHa+BQdN5XeWATv8BA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6180:EE_
x-ms-office365-filtering-correlation-id: cb7bde5d-a1be-43c4-d644-08dcafdc7472
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WlFTOURvQnB4UysydDhsYS8rL091Uy93VVZZSDFxOFNJankrYS9JYksvK0s1?=
 =?utf-8?B?c1k0NXdHeDZjMlp0VXZSdmlLRlIxUHRiTUFvZlJrdk1QZXlsWmdvSDdheUMr?=
 =?utf-8?B?NFNJdmpnRFFkbkJVSzN4SXlJS0FtZm90dzNoVWp2cVdaTGhsOC9tV1UvVmxl?=
 =?utf-8?B?NUJ0dTFpT2J4QTJWZnBDN2ZEOG5YcDNPMUE3Qm0zNzJweU5ldWtBek9ZSXhE?=
 =?utf-8?B?Z1VFbXV0ZW1KaEVIdEF0TXlSMENaWXRVNnF6b1VBNjJOY3BWTmNLZ2Zlak5O?=
 =?utf-8?B?dXhUQXUybExVNnNWZjUvSVI5M1VRc3lwMnhEUDJsVVpvSWNXdTYzdVNHdXlW?=
 =?utf-8?B?d0tNTDczcTFyNm4yaGZOa09qYlEyOXpIaVVHR0pDSFgzUEYzaC9POXZ6czZx?=
 =?utf-8?B?NThSNERZTDRGZTJmWUVtYXRwbEN0RURMRGZnV255cFpGbEM3SmFHSnc4bEtR?=
 =?utf-8?B?Z0RKaHpZaFlOZVpRSTkvYjU0V0J4NUVZcHUvV3hFUXA2NForT0UvdUxHQU1q?=
 =?utf-8?B?Qjh3M2Z5R0ZoUjRWTENhL1BlWGRIVEdqNlY5T3hpYkVaM1o1R0JwcHFDeVlt?=
 =?utf-8?B?VVRwU3FZakhLRHhIYTgzYmhwWGRNSVlzLzFwOEt2VXVtQnNNMUtBcktTWFg1?=
 =?utf-8?B?Nm55S3dZREcvQ1JQWitBWlRRRFJJRExBNGFFbVkxaElKTm9oQ3FXbVB0NG0z?=
 =?utf-8?B?THl3MUU5RFluV1RtV0JQM1NQSG1Od1FZb082RHI0dFBjUHp1YW9kc1M1T0t5?=
 =?utf-8?B?eEEwdDJPSHE3ZXVHeDBwNm9EblNndGhGSW94K0dLL2tUcWdRYWlaZjVvOXUz?=
 =?utf-8?B?NFIyckxmeno1VVBoY3hycjVtMG5zSC9pWG1yTFJUSlEzcHROZFBoV1JOdHJx?=
 =?utf-8?B?SEJVaWxETFF2R3NTMnk5OUtWd25OZGtoL2luYStxOWdaNXZKYkFWY1BCT1Q1?=
 =?utf-8?B?cjd0cXVjeFRPZFBHR2Q2VVVXeHJqQWRnYlBqYStUb0QwVEtlU3BaYllnb1VO?=
 =?utf-8?B?QkJ6NTkvTXhZRlhjbFJaZWhUSWVsWDZ6NFJhU1BHaEMrY0xocWtnNk9kV1dD?=
 =?utf-8?B?eFZPbTdzT0Z2RFM1ZHUxTGRqK3FPTlJuQVB6OU9Bb1I2N3BJS2p3ZFIzWnhh?=
 =?utf-8?B?bXJJN0VRRTlKQi9FSlBTLytTOG5WUUlJMUlhNVZ3anFRRm5UcjRWdDk3NGNF?=
 =?utf-8?B?ZFM5QUo5cVlaL1BheUN5QWdtbjBlNVQ2Q3d5bVEyNTkxNC9lK29qMUJwency?=
 =?utf-8?B?SEtvQXVyRzY5UjN1MExWYXk0bytOeVc1ZEtGSi9nNU5lT2tBVHU1aVpVd2Ex?=
 =?utf-8?B?eVJvRTlrRjZ1V2J6MFY0bTZhTDZsaDFIRTZkc3pSS3g5SG1Qck9BbDhjRFZ3?=
 =?utf-8?B?VHNBM08xMlN5Ym5UNDBSWnh6QjdVRHhwSWhiRit4dDlIa0plbjVyVEJtRjQ5?=
 =?utf-8?B?N2FhTzlEaExQekM2WDh0U3dEcS9kaFRzcE1lcjBDT1U3NnExNlFRR1BvNTUw?=
 =?utf-8?B?K2s2Sm44aVN5a0FDS1lyeW4wSk9YZlp4bDZIVjRucVFWVHNMa2N5Y3I2clFv?=
 =?utf-8?B?S0NzcGdLcXR4ZmlIZ1hCTXdCUFYyd0hES3FKMXRGQkZwTDYrdDRBNXVSQVZS?=
 =?utf-8?B?THBuNFhSOGVNcjBYY2d3UDA4ZGNQNXc4RDQyVmF4SG9UQVVGMGVKWkJhdUZC?=
 =?utf-8?B?NnRZWEgvOUFTanhsbzJ4b3FPNWFaV0dueTRudEcyK2M3UUU4Q01tci9hVzls?=
 =?utf-8?B?M3kyR3pNWVNDTitiUGcrMVFQajBvbVhyakVod25aaHJBRWZmYUZ1YlBJRHdw?=
 =?utf-8?B?bUx1UHk4b2tqVXB1Vk1YeU9XYnNwYmZVK24yQzBYWGJpblV4S3M3YWlHck4x?=
 =?utf-8?B?Q2lTRW9uZTRUV2ZNcERtN2cvZFN0bmRnaUFQcDQ2L3lGL2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnNtazVLNitpcXFLVENhbWtranQxWEVuZ21YRCsvcEcwQUVmaWIvTkpMOGJt?=
 =?utf-8?B?TmcwREhoRlUrLzVBME9QaW4rV2RvY2k0cEFzZDdZRzBneVRpMmlLcXl1bkg2?=
 =?utf-8?B?M3JmUnYzZjlVL3lYQWdqQ1hTaUNOZGNnQVc2UWlKcTA4c0orbU9oNlJvU09y?=
 =?utf-8?B?WlFQSUhWR044WUtQZ0I3WTBDcTZVejJoOFF4d2xIK2E2ZU5hdnBjMjNwMkRZ?=
 =?utf-8?B?WUFvbnRuUnIvMjR0QmhFQUFRNWk5ZUhpVC9JTlFxR045V0ovT3FIZmd6WEZD?=
 =?utf-8?B?TWRNZ1pnTU5mSndWaGJwLzR3eGJjSFlVTG43TE1uOVk5ZlU3SlMrUFN1aEJs?=
 =?utf-8?B?OTVGaTdiUzF4bjVuamNsVkRTQW5lNGhzYTBVQUF1a2d6UFNBSWxtcUQ5WVBj?=
 =?utf-8?B?Znd4cDZNbDBIODRSOEhZek10V2E2ZEtVSmhyQUNnTWMrbDgvNnlsMTlrbGtX?=
 =?utf-8?B?d2xyNEpvWHVmMzJUYVVLU3ZoZUxwTlVKS2dLVXkzV3ZIaWdUYVp6cGlTc2dN?=
 =?utf-8?B?elNTZkovTFhVWHlVRExXVFRwNkM0SUJwNGxWUk1mdU5OTE83Qno1bW0xOFJ2?=
 =?utf-8?B?eEY1UlJYTHFwUy9pK3ZPV2piOVdIMks3UUs1NXlWb05yTTFBb0ovbXhPeTcy?=
 =?utf-8?B?VlhZclhEZWkrMFNDcUNlWDBweTYrL1FIUXFnTUcyZCtDVHNlZVhsY3A5RGZJ?=
 =?utf-8?B?U1ZUNmpUemZpblhqWDE0MUJYdjJYUGtmdGpQcFcrb3VGYXUzRDZBWUdkZ1Fj?=
 =?utf-8?B?TXk4RU5aTW1BS0NQaWhIOGpkVU9wYmVtTENXeE5NSHBYT1hhT3EyMEI4UFJk?=
 =?utf-8?B?ZkxXS01OM3YxSXoyVWJmNmtUb1pyS1dhUFBzSXhBOVdwd2h4THprS3lxMmIv?=
 =?utf-8?B?THJiWTk0NGJsMkhjbUlTV29pRSsxQ3JlSG5CSW1LelJZMnhVemFvOURCQ2FV?=
 =?utf-8?B?UFprQ2JkbHJ3cmQrT2lBcjFka3crYysvTDRicXlVRTlpYWFIUkp1VjR1QzBO?=
 =?utf-8?B?U0ZYaS9GZ293eHl4SmsxbTM0Wnc2OXkyanVBQmdkZjhKK21WTUQ0Rzc2ZDBt?=
 =?utf-8?B?WHRaREcyNjAyTEtvbkQ2N2d5ajRvUWFBd09xbGZxUHNyVUZ0anJUdXByQ2Ev?=
 =?utf-8?B?TnNydzk0SlFuWnE3WXBjUTJsZm40MmR0ckxBQTQ2MnBBdFNmNi8vdU9kNGsz?=
 =?utf-8?B?Yld2MWJyVldxTDhpUThWdEdXV2VUKzdoNGVTZzNBMk4wQ1ozVllMY2hDdjdM?=
 =?utf-8?B?bVdRSHFtV0Q4ZjVnODZDUFY4VTFUUWNaanlpQzFCb0g3c08wR1FseDZ0K281?=
 =?utf-8?B?aHhCRXF2R1R3ak1BVCsyZk53cm5EaEV6c3BBSlBLamgwajlNc0xSaXRRZzF2?=
 =?utf-8?B?bXdxRjBXRGN4RzBFaVp4V0xHZ1F5M2hxcUNkcGV3YnZmZm5FVXE0NCsrcFFa?=
 =?utf-8?B?OGNOWm53NWlCWWFKVmpIQlEvNHlYa3N3NzBkS3FMbEhXbTM1eExKU0JZTEpR?=
 =?utf-8?B?LzNPTGZNckdPSUJQelJJRFgvYnFvWGkwV2VBenFHQ3VtcXRiNmJkWWg2eUhJ?=
 =?utf-8?B?TWZMQXVyZnU1SlozRGMrT0FXamc3YUJHWEllbkQ1TmRZcGd5emZLMGx2M0Vy?=
 =?utf-8?B?TDhUbDA4V3RvNnlEeVhxbzhlTThxYTJnMFIzYXozd0tBbFVXSU9TdndRUHRS?=
 =?utf-8?B?M1ByR2hqWmVCdnEyNVVLckphRVc1T1lpSnprZmd3MWltUUdzaEMydldNM0Jt?=
 =?utf-8?B?THV0RHlUMklzUEZCeGt4RDRnU0RURkxqQVkxaEhOS0lvS0hRVHlCNXc2c0pN?=
 =?utf-8?B?ZnVaOXNPUXo2MVpONEFZREx0bW9yV0FzRmxWQ1Zxc2dkMXA3ODhjWFdBbWY3?=
 =?utf-8?B?Q0JlQWVnclIxM1U4VDE2dDY2Wi9sem13R1hDcE1ONHpJaXAveFBPT3BHb0pR?=
 =?utf-8?B?bTRKWkxza3BZVjVaOFhBVnlNdklRY2NYUDFTNitHYlUwRmZuR3VUSlpwQTNX?=
 =?utf-8?B?bGpZc284NFUzTzhXRlBxbXd3L3kvTUtXL01oUEpUbTUvbFJBU1hWSTVMcWNI?=
 =?utf-8?B?N0Njb1RNM2RaejFZVUN4cHBLSWFuR0R6TXBYOUVRdVo5aUxSZ2JldFB2bzJV?=
 =?utf-8?B?bU5rQ0FrUk5mNTlFaVRRbWVER0FHY241OVczZS85M1BKcCt1UGJGMkZLRzA2?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46AA119E52E4A4498B2194B3ECAC5252@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jF2IxCXqsGianH8FfJAUe1lczJpGscjQTHT5bQsiUa2yyvUM1QZEyymcRJkjVMLutZY6AQRvKCs4MePuhu/bbIMpIXIXE3NSIGdDL16405fcXJmVK1B+Aa2f8DOvnvtU9vtowoNXYpLhwZ/NBC3Yo1gwTbmQvKTip/JYI+6AEGOVKBhIo9BaM9PBORKuPaWJkVOsaMidLAu9wKs9iQ6j6zGBea2dASLik5iSigK+EucHraTz+QFvSrldM5OU3N5/VuS6Jk5ip9EE0f+QStL6RcAdozN/DPj3nFxk5ysaZ/61YlXBWg1sDQ9pE8b2hqv12vuP2ZHCxd7CHY+3s6erroH36elW1YmdBUUOXT04XF0SOxODP95TO/kToulOB/D0Iogwexh7bHrEaUjJWpVA8DfeJNm9xOIQveAguplVr1/GOE4QDll8zqqz8mlIhPwD2B9nQW34V6xKW7PFuo2tQVOXjPJow3EkJetdXNSo5zXMRFJTBAtNiajm/L5IPU1yA031RuUjc7OXdt2Fr8MHUC8tVO3CcVjbhYlm8ZGe+Hd+aX2+Gee0aTrj6MDpvtCGlJWr1udnsGL3mTMmyHn0DpZRo9nWm5W4g2FB0sthM/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7bde5d-a1be-43c4-d644-08dcafdc7472
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 14:40:56.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tr5ojOdF/auiU9OfbFbjqrLle5yrJEdZ38le63eHstqDEvTscczEZjLfCxtsxLRz/1QaQhEa1xawmgfcloC1gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407290098
X-Proofpoint-ORIG-GUID: kxcur_Qs_wHws4g9VW--8Jc4jupQpVBp
X-Proofpoint-GUID: kxcur_Qs_wHws4g9VW--8Jc4jupQpVBp

DQoNCj4gT24gSnVsIDI5LCAyMDI0LCBhdCAxMDoyNuKAr0FNLCBZb3V6aG9uZyBZYW5nIDx5b3V6
aG9uZ0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSG93IGlzIHRoaXMgZ29pbmc/IGFueSBjaGFu
Y2UgdG8gbW92ZSBmb3J3YXJkIGFuZCBkZWFsIHdpdGggdGhlIEVFWElTVA0KPiBjYXNlIGluIGEg
ZnV0dXJlIHBhdGNoPyBJIHNlZSBubyBoYXJtIGluIGtlZXBpbmcgdGhlIEVFWElTVCBjaGVjay4N
Cg0KVGhlIEVFWElTVCBwYXRjaCBoYXMgYmVlbiBhcHBsaWVkIHRvIG5mc2QtbmV4dCBmb3IgYSB3
aGlsZSwgYWxvbmcNCndpdGggdGhlIG90aGVyIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMuDQoNCg0K
PiBPbiBNb24sIEp1bCAxNSwgMjAyNCBhdCAxMDowNuKAr0FNIENodWNrIExldmVyIDxjaHVjay5s
ZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0KPj4gT24gTW9uLCBKdWwgMTUsIDIwMjQgYXQg
MDg6MjU6NTNBTSAtMDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6DQo+Pj4gT24gTW9uLCAyMDI0LTA3
LTE1IGF0IDEwOjI3ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+Pj4+IE9uIEZyaSwgMTIgSnVs
IDIwMjQsIEplZmYgTGF5dG9uIHdyb3RlOg0KPj4+Pj4gR2l2ZW4gdGhhdCB3ZSBkbyB0aGUgc2Vh
cmNoIGFuZCBpbnNlcnRpb24gd2hpbGUgaG9sZGluZyB0aGUgaV9sb2NrLCBJDQo+Pj4+PiBkb24n
dCB0aGluayBpdCdzIHBvc3NpYmxlIGZvciB1cyB0byBnZXQgRUVYSVNUIGhlcmUuIFJlbW92ZSB0
aGlzIGNhc2UuDQo+Pj4+IA0KPj4+PiBJIHdhcyBnb2luZyB0byBjb21tZW50IHRoYXQgYXMgcmhs
dGFibGVfaW5zZXJ0KCkgY2Fubm90IHJldHVybiAtRUVYSVNUDQo+Pj4+IHRoYXQgaXMgYW4gZXh0
cmEgcmVhc29uIHRvIGRpc2NhcmQgdGhlIGNoZWNrLiAgQnV0IHRoZW4gSSBsb29rZWQgYXQgdGhl
DQo+Pj4+IGNvZGUgYW4gSSBjYW5ub3QgY29udmluY2UgbXlzZWxmIHRoYXQgaXQgY2Fubm90Lg0K
Pj4+PiBJZiBfX3JoYXNodGFibGVfaW5zZXJ0X2Zhc3QoKSBmaW5kcyB0aGF0IHRibC0+ZnV0dXJl
X3RibCBpcyBub3QgTlVMTCBpdA0KPj4+PiBjYWxscyByaGFzaHRhYmxlX2luc2VydF9zbG93KCks
IGFuZCB0aGF0IHNlZW1zIHRvIGZhaWwgaWYgdGhlIGtleQ0KPj4+PiBhbHJlYWR5IGV4aXN0cy4g
IEJ1dCBpdCBzaG91bGRuJ3QgZm9yIGFuIHJobHRhYmxlLCBpdCBzaG91bGQganVzdCBhZGQNCj4+
Pj4gdGhlIG5ldyBpdGVtIHRvIHRoZSBsaW5rZWQgbGlzdCBmb3IgdGhhdCBrZXkuDQo+Pj4+IA0K
Pj4+PiBJdCBsb29rcyBsaWtlIHRoaXMgaGFzIGFsd2F5cyBiZWVuIGJyb2tlbjogYWRkaW5nIHRv
IGFuIHJobHRhYmxlIGR1cmluZw0KPj4+PiBhIHJlc2l6ZSBldmVudCBjYW4gY2F1c2UgRUVYSVNU
Li4uLg0KPj4+PiANCj4+Pj4gV291bGQgYW55b25lIGxpa2UgdG8gY2hlY2sgbXkgd29yaz8gIEkn
bSBzdXJwcmlzZSB0aGF0IGhhc24ndCBiZWVuDQo+Pj4+IG5vdGljZWQgaWYgaXQgaXMgcmVhbGx5
IHRoZSBjYXNlLg0KPj4+PiANCj4+Pj4gDQo+Pj4gDQo+Pj4gSSBkb24ndCBrbm93IHRoaXMgY29k
ZSB3ZWxsIGF0IGFsbCwgYnV0IGl0IGxvb2tzIGNvcnJlY3QgdG8gbWU6DQo+Pj4gDQo+Pj4gc3Rh
dGljIHZvaWQgKnJoYXNodGFibGVfdHJ5X2luc2VydChzdHJ1Y3Qgcmhhc2h0YWJsZSAqaHQsIGNv
bnN0IHZvaWQgKmtleSwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHJoYXNoX2hlYWQgKm9iaikNCj4+PiB7DQo+Pj4gICAgICAgIHN0cnVjdCBidWNrZXRfdGFi
bGUgKm5ld190Ymw7DQo+Pj4gICAgICAgIHN0cnVjdCBidWNrZXRfdGFibGUgKnRibDsNCj4+PiAg
ICAgICAgc3RydWN0IHJoYXNoX2xvY2tfaGVhZCBfX3JjdSAqKmJrdDsNCj4+PiAgICAgICAgdW5z
aWduZWQgbG9uZyBmbGFnczsNCj4+PiAgICAgICAgdW5zaWduZWQgaW50IGhhc2g7DQo+Pj4gICAg
ICAgIHZvaWQgKmRhdGE7DQo+Pj4gDQo+Pj4gICAgICAgIG5ld190YmwgPSByY3VfZGVyZWZlcmVu
Y2UoaHQtPnRibCk7DQo+Pj4gDQo+Pj4gICAgICAgIGRvIHsNCj4+PiAgICAgICAgICAgICAgICB0
YmwgPSBuZXdfdGJsOw0KPj4+ICAgICAgICAgICAgICAgIGhhc2ggPSByaHRfaGVhZF9oYXNoZm4o
aHQsIHRibCwgb2JqLCBodC0+cCk7DQo+Pj4gICAgICAgICAgICAgICAgaWYgKHJjdV9hY2Nlc3Nf
cG9pbnRlcih0YmwtPmZ1dHVyZV90YmwpKQ0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgLyog
RmFpbHVyZSBpcyBPSyAqLw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgYmt0ID0gcmh0X2J1
Y2tldF92YXIodGJsLCBoYXNoKTsNCj4+PiAgICAgICAgICAgICAgICBlbHNlDQo+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICBia3QgPSByaHRfYnVja2V0X2luc2VydChodCwgdGJsLCBoYXNoKTsN
Cj4+PiAgICAgICAgICAgICAgICBpZiAoYmt0ID09IE5VTEwpIHsNCj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgIG5ld190YmwgPSByaHRfZGVyZWZlcmVuY2VfcmN1KHRibC0+ZnV0dXJlX3RibCwg
aHQpOw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgZGF0YSA9IEVSUl9QVFIoLUVBR0FJTik7
DQo+Pj4gICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4+PiAgICAgICAgICAgICAgICAgICAgICAg
IGZsYWdzID0gcmh0X2xvY2sodGJsLCBia3QpOw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ZGF0YSA9IHJoYXNodGFibGVfbG9va3VwX29uZShodCwgYmt0LCB0YmwsDQo+Pj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhhc2gsIGtleSwgb2Jq
KTsNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgIG5ld190YmwgPSByaGFzaHRhYmxlX2luc2Vy
dF9vbmUoaHQsIGJrdCwgdGJsLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBoYXNoLCBvYmosIGRhdGEpOw0KPj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKFBUUl9FUlIobmV3X3RibCkgIT0gLUVFWElTVCkNCj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZGF0YSA9IEVSUl9DQVNUKG5ld190YmwpOw0KPj4+IA0K
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgcmh0X3VubG9jayh0YmwsIGJrdCwgZmxhZ3MpOw0K
Pj4+ICAgICAgICAgICAgICAgIH0NCj4+PiAgICAgICAgfSB3aGlsZSAoIUlTX0VSUl9PUl9OVUxM
KG5ld190YmwpKTsNCj4+PiANCj4+PiAgICAgICAgaWYgKFBUUl9FUlIoZGF0YSkgPT0gLUVBR0FJ
TikNCj4+PiAgICAgICAgICAgICAgICBkYXRhID0gRVJSX1BUUihyaGFzaHRhYmxlX2luc2VydF9y
ZWhhc2goaHQsIHRibCkgPzoNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtRUFH
QUlOKTsNCj4+PiANCj4+PiAgICAgICAgcmV0dXJuIGRhdGE7DQo+Pj4gfQ0KPj4+IA0KPj4+IEkn
bSBhc3N1bWluZyB0aGUgcGFydCB3ZSBuZWVkIHRvIHdvcnJ5IGFib3V0IGlzIHdoZXJlDQo+Pj4g
cmhhc2h0YWJsZV9pbnNlcnRfb25lIHJldHVybnMgLUVFWElTVC4NCj4+PiANCj4+PiBJdCBob2xk
cyB0aGUgcmh0X2xvY2sgYWNyb3NzIHRoZSBsb29rdXAgYW5kIGluc2VydCB0aG91Z2guIFNvIGlm
DQo+Pj4gcmhhc2h0YWJsZV9pbnNlcnRfb25lIHJldHVybnMgLUVFWElTVCwgdGhlbiAiZGF0YSIg
bXVzdCBiZSBzb21ldGhpbmcNCj4+PiB2YWxpZC4gSW4gdGhhdCBjYXNlLCAiZGF0YSIgd29uJ3Qg
YmUgb3ZlcndyaXR0ZW4gYW5kIGl0IHdpbGwgZmFsbA0KPj4+IHRocm91Z2ggYW5kIHJldHVybiB0
aGUgcG9pbnRlciB0byB0aGUgZW50cnkgYWxyZWFkeSB0aGVyZS4NCj4+PiANCj4+PiBUaGF0IHNh
aWQsIHRoaXMgbG9naWMgaXMgcmVhbGx5IGNvbnZvbHV0ZWQsIHNvIEkgbWF5IGhhdmUgbWlzc2Vk
DQo+Pj4gc29tZXRoaW5nIHRvby4NCj4+IA0KPj4gVGhpcyBpcyB0aGUgaXNzdWUgSSB3YXMgY29u
Y2VybmVkIGFib3V0IGFmdGVyIG15IHJldmlldzogaXQncw0KPj4gb2J2aW91cyB0aGF0IHRoZSBy
aHRhYmxlIEFQSSBjYW4gcmV0dXJuIC1FRVhJU1QsIGJ1dCBpdCdzIGp1c3QNCj4+IHJlYWxseSBo
YXJkIHRvIHRlbGwgd2hldGhlciB0aGUgcmgvbC90YWJsZSBBUEkgd2lsbCBldmVyIHJldHVybg0K
Pj4gLUVFWElTVC4NCj4+IA0KPj4gQXMgTmVpbCBzYXlzLCB0aGUgcmh0YWJsZSAiaGFzaCB0YWJs
ZSBmdWxsIiBjYXNlIHNob3VsZCBub3QgaGFwcGVuDQo+PiB3aXRoIHJobHRhYmxlLiBCdXQgY2Fu
IHdlIHByb3ZlIHRoYXQ/DQo+PiANCj4+IElmIHdlIGFyZSBub3QgeWV0IGNvbmZpZGVudCwgdGhl
biBtYXliZSBQQVRDSCAxLzMgc2hvdWxkIHJlcGxhY2UNCj4+IHRoZSAiaWYgKHJldCA9PSAtRUVY
SVNUKSIgd2l0aCAiV0FSTl9PTihyZXQgPT0gLUVFWElTVCkiLi4uPyBJdCdzDQo+PiBhbHNvIHBv
c3NpYmxlIHRvIGFzayB0aGUgaHVtYW4ocykgd2hvIGNvbnN0cnVjdGVkIHRoZSByaGx0YWJsZQ0K
Pj4gY29kZS4gOi0pDQo+PiANCj4+IA0KPj4+Pj4gQ2M6IFlvdXpob25nIFlhbmcgPHlvdXpob25n
QGdtYWlsLmNvbT4NCj4+Pj4+IEZpeGVzOiBjNjU5MzM2NmMwYmYgKCJuZnNkOiBkb24ndCBraWxs
IG5mc2RfZmlsZXMgYmVjYXVzZSBvZiBsZWFzZSBicmVhayBlcnJvciIpDQo+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPj4+Pj4gLS0tDQo+Pj4+
PiBUaGlzIGlzIHJlcGxhY2VtZW50IGZvciBQQVRDSCAxLzMgaW4gdGhlIHNlcmllcyBJIHNlbnQg
eWVzdGVyZGF5LiBJDQo+Pj4+PiB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBqdXN0IGVsaW1pbmF0
ZSB0aGlzIGNhc2UuDQo+Pj4+PiAtLS0NCj4+Pj4+IGZzL25mc2QvZmlsZWNhY2hlLmMgfCAyIC0t
DQo+Pj4+PiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4+Pj4+IA0KPj4+Pj4gZGlm
ZiAtLWdpdCBhL2ZzL25mc2QvZmlsZWNhY2hlLmMgYi9mcy9uZnNkL2ZpbGVjYWNoZS5jDQo+Pj4+
PiBpbmRleCBmODQ5MTM2OTFiNzguLmI5ZGM3YzIyMjQyYyAxMDA2NDQNCj4+Pj4+IC0tLSBhL2Zz
L25mc2QvZmlsZWNhY2hlLmMNCj4+Pj4+ICsrKyBiL2ZzL25mc2QvZmlsZWNhY2hlLmMNCj4+Pj4+
IEBAIC0xMDM4LDggKzEwMzgsNiBAQCBuZnNkX2ZpbGVfZG9fYWNxdWlyZShzdHJ1Y3Qgc3ZjX3Jx
c3QgKnJxc3RwLCBzdHJ1Y3Qgc3ZjX2ZoICpmaHAsDQo+Pj4+PiAgaWYgKGxpa2VseShyZXQgPT0g
MCkpDQo+Pj4+PiAgICAgICAgICBnb3RvIG9wZW5fZmlsZTsNCj4+Pj4+IA0KPj4+Pj4gLSBpZiAo
cmV0ID09IC1FRVhJU1QpDQo+Pj4+PiAtICAgICAgICAgZ290byByZXRyeTsNCj4+Pj4+ICB0cmFj
ZV9uZnNkX2ZpbGVfaW5zZXJ0X2VycihycXN0cCwgaW5vZGUsIG1heV9mbGFncywgcmV0KTsNCj4+
Pj4+ICBzdGF0dXMgPSBuZnNlcnJfanVrZWJveDsNCj4+Pj4+ICBnb3RvIGNvbnN0cnVjdGlvbl9l
cnI7DQo+Pj4+PiANCj4+Pj4+IC0tLQ0KPj4+Pj4gYmFzZS1jb21taXQ6IGVjMTc3MmMzOWZhOGRk
ODUzNDBiMWEwMjA0MDgwNjM3N2ZmYmZmMjcNCj4+Pj4+IGNoYW5nZS1pZDogMjAyNDA3MTEtbmZz
ZC1uZXh0LWM5ZDE3ZjY2ZTJiZA0KPj4+Pj4gDQo+Pj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4+PiAt
LQ0KPj4+Pj4gSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCj4+Pj4+IA0KPj4+Pj4g
DQo+Pj4+IA0KPj4+IA0KPj4+IC0tDQo+Pj4gSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9y
Zz4NCj4+IA0KPj4gLS0NCj4+IENodWNrIExldmVyDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

