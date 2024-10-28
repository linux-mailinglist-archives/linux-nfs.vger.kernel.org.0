Return-Path: <linux-nfs+bounces-7536-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBF79B34F5
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 16:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03EEFB21177
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAA415E5B8;
	Mon, 28 Oct 2024 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yfff+Nwr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x8u0nirH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D516512F585
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129550; cv=fail; b=X7khmhG/Cr+h2DN8FhFGpDhDhZlzccVk2ss8NxaR1ymPB1J9ju9Eq1n9U7nhqaa0sdJj6YXJpMRQpedICMtpEgtNElO+DxZ4Jopi0hrGVFoalyFvhnLRqHrAzNK4EnhyNxlwWAPaQZctgT7AkndmB5US5wATlO0/mdW8sUlZVtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129550; c=relaxed/simple;
	bh=3hBdpxwbiCSGmlnvWAWd5mRwIE1d/JQISWAtD/niWkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W2C05bUMzMEPwt0SJZNnrx1nyHYdWfDFwdG4i2cCObCeC/K8jvo0chEb9wwI6CKMPBZC9lxRWDCPzfJgyZt+NjuoAWndJAZnD7ciJuQCnRbZBlxv/dOF7h5Tnd5ho9sS8DqFL9dM15xqE1tsccGxPlFxT6I47PnYXAVZCAi5zV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yfff+Nwr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x8u0nirH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SEtdCx021597;
	Mon, 28 Oct 2024 15:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3hBdpxwbiCSGmlnvWAWd5mRwIE1d/JQISWAtD/niWkw=; b=
	Yfff+NwrBHpg2pYjcdipykImuIWZa8oC3YIcyTBoYSL6k78UGpFwc869ms7AxtQq
	3YLImSWuMg9qTpmEQM2SrDi2p+3wyhuU4madEHfWBV6YQ+jMifGqRoA/JA460Ab+
	sZ2ke1qTuxYwZTvWNh4mol81dPZZ/Rvla9yQwUfwdAKFvCGb5YgphDYOKaZwlZoe
	beGojTtG3oKeq8CQAL5VgtjExKUFdJfBmhzPlFXBnhKrcyCKemEvYdz3L3JVD+Ey
	s/dflu4zaqqjyF2F9Xgn8vXy0BCX/zkbZLr8v7PRBzFkQ1U9MXs/Xf5iMxq5Q2UX
	NpRFN6dRO9agWkNNrLUCaQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqb5v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 15:32:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SEwmF1040314;
	Mon, 28 Oct 2024 15:32:24 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnamjh10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 15:32:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR+ZxSDXOyO11o+3z41OT0BuNdzHggpSgDBTVNonFx7CUarp7MH8DaA7tGB7EHTOAEdWYQuh4D2KF7k1qOvz1AiFxZ/yDuJ1pzL/o0eRINdjejva4Lwhb3dYkCjL4IELkl4BwGIE7Fe6cSQsmsRe/69r18pwb7nXr/ANE0NyAYg7e+QDpbLg8g86o617ltBZrZNw0RVhk5wl1cKL0kw5EpFlc931MqWvuRkpPLbmHIxFbYHp6WqI88eQiSzd0e/0lJpN1ns1KNyG/v0n6lKyOzvKMRdV8PxHzGOzclTijMob8hA1LUUBA+3ipOYHzZEZF7ZR7v1UIcSLTid9M9HDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hBdpxwbiCSGmlnvWAWd5mRwIE1d/JQISWAtD/niWkw=;
 b=C8UEiz/MJwzBN4DYHGdKtCAnCilgsiR4Rc36r+/kUJEFhUumdF3sg87GQEoFTLtHLRlokjVylEe9YWBKEC9ZX3l8gpp7Q//pW9nObQNEkC+VyliX8Uuydw3O4stuDpLZ78F5HEWzj9vHojoZYgBS2PJjVHXzorkq0WZVXmJNI5SmHEe3sCc4tZ4tv8Odew12r7eolqxfR41ilN5dh6n6G+ljsbHg1bwF93qwGpMH4iCT4YnbLasCyuqHhhLVtvMEadfcSySYEGpZR1RXjWTFnOf6oQg6z7L9WnW8XJXPstPlhAb3PQQmHiuNH8oCNAjpP5D0jGYEKtZxOIaOrbz1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hBdpxwbiCSGmlnvWAWd5mRwIE1d/JQISWAtD/niWkw=;
 b=x8u0nirHbMfWtSGRJfvo97rzJMxBwfpMWBmBjLhK6nV6vxx4kQ2R1AtjFSbIMPE1BEqIxnRXB7h3m8rQvE7SQb7R6kCTOOtVjht4wVA5nt32Py0srlCfeaG7yNPfqXjhQu011DlTnEgPRTC3I+RMVoPjFFFcMEV58wuM3yo15LI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4581.namprd10.prod.outlook.com (2603:10b6:510:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 15:32:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 15:32:21 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>, Neil Brown <neilb@suse.de>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH - for -next] nfsd: dynamically adjust per-client DRC slot
 limits.
Thread-Topic: [PATCH - for -next] nfsd: dynamically adjust per-client DRC slot
 limits.
Thread-Index: AQHbJZbu3IDA/5/rNkiy/7+aOwqiLbKbz2cAgACChAA=
Date: Mon, 28 Oct 2024 15:32:21 +0000
Message-ID: <FDBFA185-7580-4F18-82E8-9F76AA561968@oracle.com>
References: <172972079577.81717.6397186554656127040@noble.neil.brown.name>
 <CALXu0UeGKrTpH2J1OemmrS2Ab3-mtKQwgHGG6GcSJXVnzjHDYA@mail.gmail.com>
In-Reply-To:
 <CALXu0UeGKrTpH2J1OemmrS2Ab3-mtKQwgHGG6GcSJXVnzjHDYA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4581:EE_
x-ms-office365-filtering-correlation-id: 63ec334e-9dde-4189-ba2d-08dcf765b707
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QU4wVTEvT3pFRW1EdjRXdldlUWdGZ2tvVFpRcTdCYnBCc1FHRlJQRnhQRTZP?=
 =?utf-8?B?VDFKZG1RQUV3a09MWENzRlVNT1ZEVlFzQUM3OU1Jby80QzZ6WGs2Um5aV3d6?=
 =?utf-8?B?U3d3NnkwK1NKc1ZQaVJsc1Jxc241TnBGdkY2SFpCNnZza2NTeDc1WHNyaWFw?=
 =?utf-8?B?QUdydllSejlKYUl5WW5aN0F4cXRZdVVrVFhINlR1a2JFK216d0xhbGh2QkVq?=
 =?utf-8?B?M09hZ1lOajdvQ3FkUjM4MDN5cFdFeW5ZR0o4ZTU0V1BkNnVBZFpRSG9lMDhL?=
 =?utf-8?B?bW1EZExNa1MxY3IvS3l1ejZEamE0TmN2czhUUHhySjhLdWhvaHlxSWpPd0pm?=
 =?utf-8?B?SXArZGROY3RERmhiSis2TWRIMlByRXYwa3RMSXpLQkVMU0x6SHh2U2wxVXF1?=
 =?utf-8?B?Sno2VmVzcEJDN1diM29GdnVVSW1XNTVrazgxNm5YbmMvTFU2bzUwdlFGOWVW?=
 =?utf-8?B?dnVLSG5nLzBDWm5SeWR3aCt4S1h2Y01yN0Z0UXU1V3ZNeWhEQ0lqTlFnTW52?=
 =?utf-8?B?WVI3MnVYbkRvWTBNQXQrdjNvUStTdXZkQUYzQjhac0FoK0d4OTdDbkFac3hY?=
 =?utf-8?B?T2RCR1RYT1A0OWVyTU1nbEM2dW5CRzRvYnFjQnk0b0ovN2xIV2c4ZmNxUERJ?=
 =?utf-8?B?NmlqVHZIZ0c4N2dBYXowUG9RRTdtNXlvSG82OXR2MW44NDhMSldBbkdvSHlk?=
 =?utf-8?B?d0hrb3gveisvaTJzUzg2WXdUbWRnNDdxVG9mb0U2MUhKL0dwZ0E2ZGwvN1M2?=
 =?utf-8?B?WE5zTVVtVWxNNFJwaXBDVjhQSmxtVTlwVHIrUE9hZnpTTS82YVRyM0dleVhv?=
 =?utf-8?B?ZE1xSU9PcFBnS2pjSnNIYU4vVmxlVjVaTFpNOHMxYUM3OEdueVYzeGxnY3Uz?=
 =?utf-8?B?UnkxZjAwa2dCWVppdXZ5SGFpV0RxUGh2RHNReVNTUDRqclpYc2JsQTAyci9H?=
 =?utf-8?B?amZ4RUxSb2pZMjdEbWloUzNON2RFU0NiZkM1a0o1aVRMSHZ6Y1A5bVdOTng5?=
 =?utf-8?B?cS9JdWp1K3dVRVBlQW5ZT2k0Ull2dWlPd1FZRUJ5Ukl1dzNyVmxzVE1IQjRq?=
 =?utf-8?B?OTBwNlg3cXU2NjJWdjlzUWQrZzBWSTVtVWNqaDRYNCt4WWEyY05hcGNVWThm?=
 =?utf-8?B?YmlaOWlvQnNab29NS2hhNHQyanpaWjgyaW9PUGtqcW50Z0JtM1d3b25IalVZ?=
 =?utf-8?B?ZVJvZ0Uremgvb1NWeUVYUlhOczR2czZQbGlSTHA1TUl0UEo1TTU4WlgvellG?=
 =?utf-8?B?OFhaOC9MV2VrSWlQZWJQZDdJUjkwVUJuT3F4TVU2d1N0SStMNnBvT1dYQ2JX?=
 =?utf-8?B?RE83cjB5N3F4QVpOV083Sm1BOEFWRzBaL0MwZmtOcUFPK3JHdnZDWktjb2dM?=
 =?utf-8?B?ME1Td2tyRVZueTJaK015dmhsL2pzelhsQ1EvS2toR3lCZktQQU5RTEJpRDRY?=
 =?utf-8?B?eFJBcUZrRk5ablRBT09zTTlINy9SK1g2VlgyTFl6dUtBa2xReVNCeWlnMEE4?=
 =?utf-8?B?RDRrUGV0azBzYlZMdTlYL09xcTVMSTQvM2plaUt1d3V2Ui9ZN254RC9RZWVu?=
 =?utf-8?B?ZE1ubEVUVjZQcTBKcjhSelZjU2M3SktZRE1XQmxWRytOYU93WVJScHhteGxr?=
 =?utf-8?B?ZmN2dDhybGdCYitWcW51cjZZdi9wK2VUSHhjUXhabmJZakgwSnJxcWh1MVdZ?=
 =?utf-8?B?YjVJRlBlZ0ZqL1NRVkdUdUxncEhrYUlncUVSalg1OStuc0RLcTVTbngyWEU1?=
 =?utf-8?B?Zkd5aWJqdW51RlJlYkpyVXlaMi90RGdBb3RJMWxmTmk5OGpWWURmNU51OUxE?=
 =?utf-8?Q?CtwnSozhX/CJMCFx7PoReU0KCGywR+QkIH8dc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0llTDFoMVFPVGJ2Mi9VZjBZLzdTTlpKV3d4Q0ppYXc3aFlJSUhBRTZkbHJO?=
 =?utf-8?B?Q3U3eHNuNEM1REd4ejB0RkdkYlFVN05MQnhDUngzV1luNjlXOGNSbUpXa1BY?=
 =?utf-8?B?VUFaYkozNERjREZpUVlVbkU5WnJGaE0ydEFjVUZTRDcrWmd2czA4bERHUmc1?=
 =?utf-8?B?R3hxQTVvN09VLzFMUGJGcHRHTlZHaG04UzBsR1R2c3U1YXhKU0VCNFpEcFNx?=
 =?utf-8?B?bGtTWTZ6VWlHM1ljWjdibk9aU0YrL1BkOEd4MzdTSlgvclVZSU5DZHc5d05N?=
 =?utf-8?B?QlhvTG5hTWtOZmZ1RUQreXhDbjVSd2FENDFNUTJyeCtDT04wYXZacEd5NmFz?=
 =?utf-8?B?U0NETVlEdDhBaG5jc0ZyR1ArSk9Ca2FzWVRrTEhscUFOWkFGNk1yWWpjeTgr?=
 =?utf-8?B?Q3JKVE5sbGx3Y1Y5ekhNS0tTblg4YXZzcXJZSFNvVnU1VjNydnZCOW9XS1JK?=
 =?utf-8?B?MVZRbndPKzZOVU9pM0NqNjhKMG42T1Z5RWxiVlZGVjZKS05PK2FoNTZkMDhE?=
 =?utf-8?B?Ymo1dnFmZE8rVlZpOXRSZ29jZWRUMFc3cTgyTjAxci91cGV3eGx2Y0twTHRU?=
 =?utf-8?B?QVJnWXd1ZmNNK3NzWHhEeW96NzFhVnltLzNBUk9wUGtjMFJJNTF1M1ZSSEow?=
 =?utf-8?B?MnRkcWErNEtTK0FoblUzYlZpNzNxZThtTVZSNE1PMVE1U292d05NNnl3c28z?=
 =?utf-8?B?ZEFETXpFaW9TVTNmZFMzN29tWmpzemVxR1FDcXdTU09oZEEyWUlqQThHVFhk?=
 =?utf-8?B?Wjc0Sk1wTUNzU2kzWjVWSHRuMGMxUUE0N295YWVBM29UNG9lTzM4Mnc5Z1ZP?=
 =?utf-8?B?U01ISGp2clBoWUZYaCt4ZmU0UWVsVG9vMkgrTEhxNmtiL2R3Y2FzbFM1OHVp?=
 =?utf-8?B?Z0pLSzVrMVMzaWlWYkY0cGdwd0dGYTZXSVF2N2hnSXBCKzhucmk0TG5sMFhE?=
 =?utf-8?B?ZDFZRW9BRFNRc1RDWnhHNDdQRVplSmViM1Z1SzJwZTRLaGcvRmZ1aG10L1Z3?=
 =?utf-8?B?SU5SbTBXaDg0c1R6TWVXNkJSQ3E4L3E1ODlqR2toVHlpVUNPYlBRaE96TytG?=
 =?utf-8?B?MjhXMklzRVQwSndNZFRlSHdjb3Z3RmJiWTU3cmc3Qnlla1A5K1ZlNnJWUkV5?=
 =?utf-8?B?NUo1ZnZXMlF3ZXpCZ200TkM2QjVOTkVleXh1aGRnMWlWQ2RNa2QxWjdXNUlG?=
 =?utf-8?B?QjVQQUVzWWpCTGg0VjV1d3NiUHBlRHVsNFJTR3duRUZ1cGdNeDI0K3NZZjli?=
 =?utf-8?B?UTdoUkhHcVBrWU9ucGlWaDZPV1k4WFIrN3lmM25hOFQzbk5JSklVVGZ2WWJK?=
 =?utf-8?B?VU8rTmZ5WVJaQy9zTWdwOXRZZG8ycHFKb3ZQRGRmemU4cG1JckU4YWJEN1pV?=
 =?utf-8?B?dzl4TUxIKy9hcTFLY01UU3NBbVBxMWZPZS9uRy96aEVFMkpYNXA3ZmEyWmdo?=
 =?utf-8?B?MFBsY09lcG9uMkJQaFZiZ3k3RUhlYlBQQUtla2VvVDJqSGNhT3FPajdlYzY5?=
 =?utf-8?B?UXRRSWV6WEFnNzY4UEdQT1N2Z3hjM2E1RWpGWlBPWXY2STBCRENnUGlodE5R?=
 =?utf-8?B?emI2SUJvd1ZuZ2NrTnNWQmduSFRQME5PQ1hyRkM5bklMeEJhbTFya1VMVmxh?=
 =?utf-8?B?S2c5OEs0T2NjMUNsOUJsWUpVVmhQTFBhN1NIaGxiTnl0NlFKdXk0U1daRlpo?=
 =?utf-8?B?U0cvREl4TSt4YUlnWmJMOWVlaUhuUDZqcXY5eVV1UU5qc3EyWXV6ak5JQ004?=
 =?utf-8?B?T0V4R0UvdzRTUUYyb0EwU3BVZFFJaGduS3JnV2V4WE1ydFRTYnBZWnlwYWNK?=
 =?utf-8?B?M041SDUvVnhjYzJObnlwdndyT3B3R2JsSUYyTkZoTzFYZ2dvZ3NuV21yZHUr?=
 =?utf-8?B?bDlmeTNLclVFeEdpYUlDQWNQRnNHMDZZemxhQlJabGh5MlY5NEc5dzBRL3o2?=
 =?utf-8?B?MitUUnY1dHNhRVNtbll5U1BtaTBPVUJ1QnoxMS95UnYrRlBLcVdsbnRNTEhj?=
 =?utf-8?B?QUtoYWJxTzFtUUpodXF6OXJITU1ldGg0MkZrYkMwQzZGSVd4dWRZdE5JVGUy?=
 =?utf-8?B?WnhFbS9WVEltOGUxcUYxRS9jYVkxNm5OcDBMcU80eis1NDVrQ29rTWQveThG?=
 =?utf-8?B?c09BL1prNmtISFdvb1VuelJQTVVsRG42M0JlV01MS2N5WjE4MXhNVUtWZXgz?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D6B86C55358324E95052B5F1B95051A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mYVz3u8/8iog3McX07oYRKeZqGfmwLy0122mX6tI9RaY2rIfFDfJ5YF+vPeWVNUBy/fAsm5vKCO+VsawnqQ3V6Rp7T0eu6QqFoP4LrtRHN0GnQpQ8IylkEqIZLqUoc75aV9jXnBkNn7UaenPPKqX2+YsJwqK5Iy6/tAlcnnMPbYJjyrkNFb7Z+vrylLiavgzUPTL5L9oVUwdAvMthTccN7YDgTq4PgI1CuMAPzGZ//xf0XvKEj/WFY7iGMAHEgBRHwJ4s1PaaVIMW7q86IbtPbLxE7rnRst7G0NOJgx+ZIEf3xVktJp1nO2o+LYGpB59GJmcxeFITVFvkF8cVVKSyDLuYP3Fly0Xj5iNJf+a+oJAi2IzaqLiq/7sz3TbqYL12+aH87YknqMdiQy+8l+dGkX/PaVSlrIHveBL47VeHrS1ivq7SNVYr2qMjKvhH3m0GIqEmOQf6+j3zzAQTvb1UJrWfPI/sUjwaaqQPsXDAQN1RDmpuw9V2zAcPUbiyAEqqYBswHLQCa6X+ZsS0yBPp9J7Lme014996cXo+3hoxolEADCdjKjvmyhrWaGfYzFsHVadeSbjtx7quaueS9NubHS04mj1T2eZyFsKvzHH0a8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ec334e-9dde-4189-ba2d-08dcf765b707
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 15:32:21.3748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9tJAyIfskHif0KbAYhGrwZDGYg5OQOJuaT46tugEZNtL94GdEiqAtsi+W2MMIfzeFwde8HYMKyfq08kQcEwpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_04,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280124
X-Proofpoint-GUID: dRdi1WwXvcp-e-ZeWReHb2ClqIpddaM1
X-Proofpoint-ORIG-GUID: dRdi1WwXvcp-e-ZeWReHb2ClqIpddaM1

DQoNCj4gT24gT2N0IDI4LCAyMDI0LCBhdCAzOjQ14oCvQU0sIENlZHJpYyBCbGFuY2hlciA8Y2Vk
cmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiAxLiBIb3cgc2hvdWxkIHRoaXMg
YmUgdGVzdGVkPyBZb3UgYXJlIGFkZGluZyBhIHJhbmRvbSBlbGVtZW50IHRvIHRoZQ0KPiB0ZXN0
IG1hdHJpeCwgd2l0aG91dCBhbiBvcHRpb24gdG8gbWFudWFsbHkgc2V0IGEgZml4ZWQgdmFsdWUs
IG9yDQo+IGRpc2FibGUgaXQuIEF0IGxlYXN0IHRoZXJlIHNob3VsZCBiZSBhIGhvb2sgaW4gL3By
b2MgdG8gc2V0IHRoZSBudW1iZXINCj4gb2YgRFJDIHNsb3RzLCBzbyBDSSBjYW4gc2ltdWxhdGUg
Y2hhbmdlcy4NCg0KTmVpbCBzdWdnZXN0ZWQgZXhwb3Npbmcgc2Vzc2lvbiBwYXJhbWV0ZXJzIHZp
YSAvcHJvYy4NCkkgdGhpbmsgSSB3b3VsZCBwcmVmZXIgL3N5cyBpbnN0ZWFkLg0KDQpCdXQgcGVy
aGFwcyB3ZSBjb3VsZCBtYWtlIChzb21lIG9mKSB0aGVtIHdyaXRhYmxlIGFzIHdlbGwNCmFzIHJl
YWRhYmxlOyBOZWlsIHdpbGwgaGF2ZSB0byBsZXQgdXMga25vdyBpZiB0aGF0IGlzDQpmZWFzaWJs
ZS4NCg0KcHluZnMgYWxyZWFkeSBoYXMgc29tZSB1bml0IHRlc3Rpbmcgb2YgU0VRVUVOQ0UgYW5k
DQpDUkVBVEVfU0VTU0lPTiwgYnV0IHdlIGRvbid0ICh5ZXQpIGhhdmUgYSBsb3Qgb2YNCnRlc3Rp
bmcgYXJvdW5kIHNlcnZlciBtZW1vcnkgZXhoYXVzdGlvbi4NCg0KDQo+IDIuIEhvdyBkbyB5b3Ug
cHJvdmlkZSBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eSB0byBjbGllbnRzIHdoaWNoIGRvIG5vdA0K
PiBpbXBsZW1lbnQgdGhlIG51bWJlciBvZiBzbG90cyBhZGp1c3RtZW50cyBwZXIgU0VRVUVOQ0Ug
b3AsIG9yDQo+IGltcGxlbWVudCBpdCB3cm9uZz8gSnVzdCAgY2xhaW0gIml0cyB0aGUgTkZTdjQu
MSBzdGFuZGFyZCwgYW5kIGxlZ2FjeQ0KPiBjbGllbnRzIHNob3VsZCBidXJuJmRpZSIgaXMgbm90
IGFuIG9wdGlvbiwgb3RoZXJ3aXNlIEFXUyZjbyB3aWxsIHRyeSBhDQo+IEplYW5uZSBkJ0FyYy1z
dHlsZSBwdW5pc2htZW50IG9uIHRob3NlIHJlc3BvbnNpYmxlDQoNClRoYXQncyB3aGF0IGEgc3Rh
bmRhcmQgaXMgZm9yLiBFaXRoZXIgYSBjbGllbnQgaW1wbGVtZW50YXRpb24NCmNvbXBsaWVzIHRv
IHRoZSBzdGFuZGFyZCwgYW5kIHRodXMgaGFzIGludGVyb3BlcmFiaWxpdHkNCmd1YXJhbnRlZXM7
IG9yIGl0IGRvZXNuJ3QsIGFuZCBhbGwgYmV0cyBhcmUgb2ZmLiBUaGlzIGlzbid0DQpzb21ldGhp
bmcgdW5pcXVlIHRvIHRoZSBORlMgd29ybGQsIGl0J3MgYWN0dWFsbHkgYSB2ZXJ5DQpjb21tb24g
YXBwcm9hY2ggdG8gc3VjaCBpc3N1ZXMuDQoNCkRvIHlvdSBrbm93IG9mIGFueSBzcGVjaWZpYyBj
bGllbnQgaW1wbGVtZW50YXRpb24gdGhhdCB3b3VsZA0KaGF2ZSBkaWZmaWN1bHR5IHdpdGggZHlu
YW1pYyBzZXNzaW9uIHJlc2l6aW5nPyBGaW5kIGFuIGV4YW1wbGUNCmFuZCB3ZSBjYW4gd29yayB0
aHJvdWdoIGl0Lg0KDQoNCj4gMy4gSG93IGRvIHlvdSBoYW5kbGUgY2hhbmdlcyBpbiBtZW1vcnks
IGUuZy4gbWVtb3J5IGhvdHBsdWcsIG9yDQo+IGNoYW5nZXMgaW4gbWVtIGFzc2lnbmVkIHRvIHRo
ZSBWTSBydW5uaW5nIHRoZSBuZnNkPw0KDQpJdCdzIGNlcnRhaW5seSBwb3NzaWJsZSB0byBhZGQg
YnV0IGhhcyBpdCBiZWVuIGRlbW9uc3RyYXRlZA0KdGhhdCBpdCBpcyBuZWNlc3Nhcnkgb24gZGF5
IHplcm8/IFRoZXNlIGFyZSB0aGUgY29ybmVyaWVzdA0Kb2YgY29ybmVyIGNhc2VzOyBJIHdvdWxk
IHByZWZlciB0byBhdm9pZCBoZXJvaWMgaW50ZXJ2ZW50aW9ucw0KaW4gdGhpcyBjb2RlIHVudGls
IGl0IGp1c3QgY2FuJ3QgYmUgYXZvaWRlZC4NCg0KSSBhbHNvIG5vdGUgdGhhdCBhIHNocmlua2Vy
IGNvdWxkIHNpZ25hbCBORlNEIHdoZW4gc3lzdGVtDQptZW1vcnkgY29uZGl0aW9ucyBoYXZlIGNo
YW5nZWQuIEEgc2hyaW5rZXIgY2FsbGJhY2sgZG9lcw0Kbm90IGhhdmUgdG8gcmVsZWFzZSBhbnkg
bWVtb3J5LCBhbmQgY2FuIGJlIHVzZWQgdG8NCm9wcG9ydHVuaXN0aWNhbGx5IHJlZHVjZSBmdXR1
cmUgbWVtb3J5IG5lZWRzLg0KDQoNCj4gSXMgc3dhcCBzcGFjZSBjb3VudGVkIHRvbz8NCg0KDQpJ
dCBpc24ndCBjdXJyZW50bHkuIEkgY2FuJ3QgdGhpbmsgb2YgYSByZWFzb24gTkZTRCB3b3VsZA0K
bmVlZCB0byBkbyB0aGF0LiBXaGF0IHdlcmUgeW91IHRoaW5raW5nIG9mPw0KDQoNCj4gNC4gV2lu
ZG93cyB1bnRpbCBXaW5kb3dzIFNlcnZlciAyMDAzIChsZWFrZWQgc291cmNlIGNvZGUgY2FuIGJl
DQo+IGdvb2dsZWQpIGhhZCB0aGlzIGtpbmQgb2YgbWVtb3J5IGF1dG9zY2FsaW5nIGZvciBTTUIu
IEVhY2ggV2luZG93cw0KPiByZWxlYXNlIGJlZm9yZSBTZXJ2ZXIgMjAwMyBoYWQgaW5jcmVhc2lu
Z2x5IG1vcmUgY29tcGxleCBjb2RlLCB3aXRoDQo+IGluY3JlYXNpbmdseSB1bnBsZWFzYW50IGN1
cnNlcyBpbiB0aGUgc291cmNlIGNvbW1lbnRzIGFib3V0IHVuZXhwZWN0ZWQNCj4gYW5kIHVud2Fu
dGVkIHNpZGUgZWZmZWN0cy4gQWZ0ZXIgV2luZG93cyBTZXJ2ZXIgMjAwMyB0aGlzIHdob2xlDQo+
IG1hY2hpbmVyeSB3YXMgeWFua2VkIG91dCwgYmVjYXVzZSBpdCB3YXMgbXVjaCBtb3JlIGhhcm1m
dWwgdG8NCj4gY3VzdG9tZXJzIHRoYW4gYW55IHNhdmluZ3MgaW4gbWVtb3J5IGNvbnN1bXB0aW9u
cyBjb3VsZCBldmVyIGJyaW5nLg0KPiANCj4gV2h5IGRvIHlvdSB3YW50IHRvIHRyeSB0byBicmlu
ZyB0aGUgc2FtZSBuaWdodG1hcmlzaCBleHBlcmltZW50IHRvIHRoZQ0KPiBORlN2NCB3b3JsZCwg
YWZ0ZXIgTWljcm9zb2Z0IGZhaWxlZCBzbyBob3JyaWJseT8NCg0KWW91IG1pZ2h0IGJlIGNvbXBh
cmluZyBhcHBsZXMgYW5kIG9yYW5nZXMsIGJ1dCBJIGNhbid0DQp0ZWxsIGJlY2F1c2UgdGhlcmUg
aXMgc28gdmVyeSBsaXR0bGUgZGV0YWlsIGhlcmUgdGhhdA0Kd291bGQgZW5hYmxlIHVzIHRvIHNh
eSB3aGV0aGVyIHdlIGFyZSBpbXBsZW1lbnRpbmcNCmFueXRoaW5nIHJlbW90ZWx5IHNpbWlsYXIg
dG8gd2hhdCBNaWNyb3NvZnQgbWlnaHQgaGF2ZQ0KZG9uZSAyMCB5ZWFycyBhZ28sIG5vciBkbyB3
ZSBrbm93IGFueSBzcGVjaWZpY3MgYWJvdXQNCnRoZSBpbXBsZW1lbnRhdGlvbiBpc3N1ZXMgdGhl
eSBmYWNlZC4gV2UgZG8gaGF2ZSBvbmUNCm9yIHR3byBmb3JtZXIgU01CIGZvbGtzIG9uIGxpc3Qg
d2hvIGNvdWxkIHByb3ZpZGUgc29tZQ0KZmFjdHMuDQoNCkJ1dCwgc3VmZmljZSB0byBzYXksIG90
aGVyIE5GU0Qgc2VydmVyIGltcGxlbWVudGF0aW9ucw0KYWxyZWFkeSBpbXBsZW1lbnQgZHluYW1p
YyBzZXNzaW9uIHNsb3QgcmVzaXppbmcsIGFuZA0KdGhlcmUgaGF2ZSBiZWVuIG9ubHkgbWlub3Ig
aXNzdWVzIHdpdGggdGhvc2UuIEkgZG8NCmV4cGVjdCB0aGF0IG91cnMgd2lsbCBoYXZlIHRvIGJl
IHR1bmVkIGFuZCB0d2Vha2VkIG92ZXINCnRpbWUuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

