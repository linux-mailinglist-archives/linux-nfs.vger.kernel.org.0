Return-Path: <linux-nfs+bounces-7980-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 424609C8CD8
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 15:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE69B27587
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9A3FBB3;
	Thu, 14 Nov 2024 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AgIiaoRv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n9siT44a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9463987D;
	Thu, 14 Nov 2024 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593989; cv=fail; b=LCnm+k8TpbPPv8XN4/m+Qx3xIcugq6L61YHp5wtVSNJlvXhH3Wx9SY+Ayz9r9wcrDkiiRPgN88NCgV7Vo4USAk1C8gL497n8bBUGxP4nTY2Q7EvRkxIMc4LMgl7Vv7UCcoWL6GLC7bnlf+RCaUqeHHyiGie3ORqwiWzadD7pLhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593989; c=relaxed/simple;
	bh=febllVOib0HcluP+2H2fsXMZEF81+vMOO9NZ5u7Q2M0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IhdYSFhoHoy6irjk6+qmQYWMFeJknPQc/lov7HDluW68SpkxkEgO3fEBvtJkCfCBDDChUCCqkqvexCtrVAcOzGuqRajJfTtQO6Agxt1M/0u+BaBwwo9NO34KTRjsuyunPDihx7MAHHCzOkToi1LL/TnwJGPSsBHbAabM2ak+zAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AgIiaoRv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n9siT44a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEBTupU001338;
	Thu, 14 Nov 2024 14:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=febllVOib0HcluP+2H2fsXMZEF81+vMOO9NZ5u7Q2M0=; b=
	AgIiaoRvInHa1o1+Lx24gmLijabBx/byXm6rFkyuLw2Q56jbvtHtjaX2eMg0gLyC
	laVVf5pNYeVGUWktNN72o15lMQ7WNZLNSMkiFokePpAedlftUaRJvCmMdI2IGi0F
	F+CFwDXb4pP3oWP1xGMV3QDOLidsBddB1fep/L6NdmadKJ0CGFTPWhrwXD8EN2WQ
	IjbLbWnnYyGU4wx8tlPtv5G69OE5WZdU+ttaNN6AvAw0WHr2zSh5ST8zZ8mZI9uJ
	nut/KqBotJ6onyBq+y65dID7lbtES7yzYbEyOUTNHLci13MD2PqnCWcOmMSzp00q
	rdE8CkV20iPM+5RejleR9w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4k02s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 14:19:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED5RVB025992;
	Thu, 14 Nov 2024 14:19:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6aw50c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 14:19:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfWaToIg9GJfYeuZPAjawaftAfBeABb4vJdwB/ARiz1nOSU9cZLNz4soSCJQGbDO5RPIVnZpifvSBYUfMay/acrWgQP0SE0h0Yv5tY/EKm4CFfBvfsmRpIqrozfNJAOpr56r/UWOVM3zQJfaws78PU8BUXj8UlmDq+bQrBHvqd+NRbyixLv56hTvTzqzSmwNuCtEPCq/6TWA3TCXs00u3Gd1HGCT4LO3Api0xsLJeRFqUkmX3bNNYDRvjs5iAav0yBRmJbmeY/0KPBZgA3I/2V5+eTaAD9CMgkzi7bS2JkUk6ki1s4zNMs5m/vpVvJN1B1PYqsNkdA0dCRXFCj10/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=febllVOib0HcluP+2H2fsXMZEF81+vMOO9NZ5u7Q2M0=;
 b=FZSsTYZ36m0zytqlEOhLB01WQRGQ1USQxo/qvOyEiMw0Q7mUk9GPIY+36JkeBBZLDf6tmbP9b3o+llcHELFGWk5OBQ5xMKzUyxqzm5J3GyioVyZKJx3I3coS2oINttU59MwBN3n5oi37atqJ8PWtP9jVc4/Rva74G8ZMIoxApIX3QuwkI670DOdZx6ddq3JLeYw2MzfgXEtF+wrdpq6yNF/Q7u4CB+q81SYw83S5bpX6XYb7Sn+IdWPmVLj6qxcfDLyixXwG2+Vxt2L+bCJ5Pz+77QwhnRMqEpGOUSYzoVGORYOTQsrDTWvo2d9uSRR4+catS+BAjhRJoAESwZBUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=febllVOib0HcluP+2H2fsXMZEF81+vMOO9NZ5u7Q2M0=;
 b=n9siT44aH4pK8ua9XMpynd9edjBbhdzDbR7gUZJyoCIvue9YwWrCrqTA0JLOiZf/+5RPZtEgVCyy7rA03pKWehFHe7E3OUVh1IclGqAkFFMj5YH5ReWsEbb6nEBT/SVfLhYN26Ukg7iaHKyICZKUpmJh5TgFHoUqHl1xRaRRGoE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6028.namprd10.prod.outlook.com (2603:10b6:208:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 14:19:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 14:19:28 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>,
        Linux NFS Mailing
 List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
Thread-Topic: [PATCH v4] nfsd: allow for up to 32 callback session slots
Thread-Index:
 AQHbL+M3o36n4DUBwkG5RWjgwRNfwrK0YGoAgAAPoQCAAAfDgIAA5kKAgADKUQCAALg5gA==
Date: Thu, 14 Nov 2024 14:19:28 +0000
Message-ID: <9A8D2B27-AF26-4A5F-A1A2-1C30935A026C@oracle.com>
References: <acf8d86338c881b6837d85399bfca406f1e1c0a3.camel@kernel.org>
 <173155439694.1734440.14845420245634385370@noble.neil.brown.name>
In-Reply-To: <173155439694.1734440.14845420245634385370@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6028:EE_
x-ms-office365-filtering-correlation-id: 9de05421-b57a-4ada-9ef9-08dd04b7597a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGVwS1NzYkc5dkRqeVZHcHc3RUlPOFg0N1VFdXhaWVBFSnVXNFNnWExjby8z?=
 =?utf-8?B?THRyY1NHY1dUbFpZYWhMWHFRSDllVU05UCtaNTlJeHFqcmhWcWk5OGVRVnQx?=
 =?utf-8?B?T01KRnIxMnl4Q0lvWFlRSmhFTVgxeE5JMTFTd3FmYWpLRFAvdU81eVptVUcz?=
 =?utf-8?B?ZVlkQVNhci9TbEFHU0pTL3VZVzRjbU5ZSU5UaG1qb2JuOFhWRVl4bGJQU1Ax?=
 =?utf-8?B?U3JNODlWZ1lOOWRjZm5IVHhlOStPSlRpTE9DNkVyLzQ2aStEZjZqcTBqTlNx?=
 =?utf-8?B?T3RQdVd2N3dLSjRWZGpGbjRJNU9wMVJ6UUFLTDR3TzNBVlFhZDlyU3JxalBR?=
 =?utf-8?B?NExoMjk4YUlDVyt0Z21Ud2pZMG9RTDVQOWx3TDk5clA2V3RWdDVWOFhDaXZ6?=
 =?utf-8?B?U3dPdWtrWW5aV0ZEZDdEZmtJT29uNHBDaTA3eDA1T2g5anBRM0tlTHowdzhK?=
 =?utf-8?B?eENHeUJNUnJjUU9XckpTbHpNNEIzbjhxRENoN0pTUmkzZUZKT1o1VDcxOUdM?=
 =?utf-8?B?TDFnaVJjcloxY2Z6RmFOVVp6bVhSNUJFTkwrNytCWVdSc2gxMFQ3eWkyZUFa?=
 =?utf-8?B?aFVpUGFNc3E3U01qMkxjaEFNYWczZFlpaytITVYrc3ovSHAvbWZVNTdwRFhk?=
 =?utf-8?B?NGxJQVV4TVMraC9hMnExbjZEdllGTXJhbFRDbzRXd2dFVTJuaGliZW5aZGQ3?=
 =?utf-8?B?ek9ZZGZTeG5NaUJkalB3c09IZEJkb1NzeFhvanR2ajBJREtRZTF2UzZQblM2?=
 =?utf-8?B?bkZtcWd3M3NwMm9LQUR6SSthWkVMYitqNlNSOFM1WGFzYmpsQUd4U2N0aXBJ?=
 =?utf-8?B?UEhXT3EvK1BtRnV1c203L1pweFliRW56b21CTG14cjJtVDh0bURQdEsyN0lr?=
 =?utf-8?B?Um5iQmllbEVrc3RjOVZhTW5wRTZNTmFHRG5LVGVsa2tjcFd5OU5NUUFiZGVa?=
 =?utf-8?B?YlZyMHVGdDZ5cjJtUnhBOHVFSHVBOXgxb3FGMWNlS3NuT2FvTVZSQ0pYMkpJ?=
 =?utf-8?B?aEJMZjJLTmVWWHpRTnBVTC9JeFY2QndXNjlWb3dhRU93ZHU2SDFkVGR6SG1k?=
 =?utf-8?B?V05lYWFWUFVZS2oyYllTWHVJd1JFT1dRMEdyV0YyMEh3alBEaXJtS1NBZHRK?=
 =?utf-8?B?STB6STUybGI0SzZiNDBGZ1pYZ2hvOWppVzczb3dJTGNsNnNlSGloOVpXK1l1?=
 =?utf-8?B?MERscTRtc05rSEFuNkkzYjdtbkpFTC8yV0lsYlBZSlhUZ2h2TzFQMkxkZE9L?=
 =?utf-8?B?SkYwTWRjb2dyTlYzRW1NNUlEK1NuOEROZkkyNzdlT0NILzhSeHZRRUFaUnVB?=
 =?utf-8?B?ZWptT3NFZkFtdUxFQ3ppWEpPL0dTaGl4ci9zUFBBZGRzQjFHbXdzbUFCK2Jr?=
 =?utf-8?B?ZTJ4aTk0WW5PZ0pMdlljaHJTd2l4STdxVU5tRWxuQUtONEJ2SG5yZUJHYUp6?=
 =?utf-8?B?V3NNS3VDZ0RhcHcrajVCZzlCMitlNm5nYXRiWThoTXNqMHhuSytSUjFiTVUx?=
 =?utf-8?B?eEcvM2dHL2Z1aUtTdEswNE9maDRYVXBKcFdUdVRoeVdyWTZOT0JJWFgyK1BS?=
 =?utf-8?B?aFZkdS9tUWpxQXFiQVJZU01iM0grZDdEMzFNcDkrZlUySWdqU1ZZMVZ2ZnJZ?=
 =?utf-8?B?Mnc5Szl6bGtNcCtoeC9HU0R6Smh2amhIZEhRNjNUMk9nNGhiRUNmRWhHUVEz?=
 =?utf-8?B?cTRmVFJCcmkybk80TDJva0xsUy96K0I3ZnVZcVJyVWQyd09xS08wMHlwNlJQ?=
 =?utf-8?B?ZFF2anp1cUk4enN1cTY0QmFiRkFrRXE5UFFhK01ZMWFkZkNVOHEyN2l3MzZB?=
 =?utf-8?Q?YnKl944Urr7ImeQd6iT8Ej3rZ46/qiMNs/hVk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmdUODlaMkxscUZKMHJQMU4yZWlRclpEajhtR01CQ1I4S3cyQ2gvcFZtK3lo?=
 =?utf-8?B?VFRFdkRTVzEyQTlpckNNYmJPUkp5R0xTQ0hYRlJWRUdtU3p5UUpNYnZwTWpJ?=
 =?utf-8?B?QUZkcGNyS1NFdnB4VTE1eTVMTkh1eGJ1ODVmd0Q1SVNEbHBmNjhvMmRLaklX?=
 =?utf-8?B?cndVOTRjeEROM0l2MUx6amlaYUFqRkVRUkVMWlhCcGtja0JudkIzVTMrTGlj?=
 =?utf-8?B?WGdjM3lpckJydkJxQkhjK3ZSdUJJcnFhMUwyTng1ZFdBVE9pcW1YZHlMZlgv?=
 =?utf-8?B?eUsrTVpCTkIwbVErL0dKLzB6ZXpKdC9VZFlsMnJWcHBNellLcVN3RUZhRG9B?=
 =?utf-8?B?c3hEdkxCRWpyRC9GdVZlczdTR295NVhPN25yR0JsOUJTTjRyRFhKRENOMW1v?=
 =?utf-8?B?Q2pKUjlkSCtQRjN5N3NyekdWQ0VwOXF5SWdMWDhoajUwd0RpZTQzVC9sUlVs?=
 =?utf-8?B?MFBpRGV4M2dpTi9aTFBOMEZiMUY3Z3BONGNWM2R6WHNpK1BQbWg0Nmc3Y3h6?=
 =?utf-8?B?UUpLSElBaGNPSnNwRThOVnllVnQ0eUhxVlhNZlE0aXE0NmtCbTFPVHUvTWxW?=
 =?utf-8?B?dUs4VlRYeXVKZVpFU2lEMVdNYXNSZmxLN0k2THRHZW4zZWRiUEdTMHU3Qmg2?=
 =?utf-8?B?ZndaU3N0ZkViTWdMbXJzNFc1TzhmYXYycG9RZFBEQmVzZTRLOG0zQ2cwd3hk?=
 =?utf-8?B?QjIxMGhCZ0RZd2FPbHlGRkpLekJqMThCNnhHaGlsL1d5czFtbXJkeFVmeFhL?=
 =?utf-8?B?eVFqbVRRNlJlTmhndmlacFFDMTZPWkIwcVBrdWhqSFFUaFB3NVR5QkxscU1C?=
 =?utf-8?B?WC9ZR2hiTlZ1WUhaK0ZkWVhjbVFoWWFpd1cwQ0UxZUV4YzdJazA5WUtvT1NH?=
 =?utf-8?B?TkVJWWpjZjQ3NFJrRWE2QUtZTnFjdm1DaFBaTzhKOXBFMkZqQ0FJNVdIN3NK?=
 =?utf-8?B?NjMvZ2NpRmxuNHUvOUMweDlXZXRUcU9udWgwRm80aFlONDhDMXppN1MwMWZt?=
 =?utf-8?B?dHMxUUc1b3BvNkZiSE1MTUxPREVVbzJrOXMwYitrNlRBbVNLS29XS0JJbUdW?=
 =?utf-8?B?cmZpb2NHTTFzWFZtdldDSzkxVlNMOTZKcnN5TU90ZTRYV1RZSVlSbHo5SVRz?=
 =?utf-8?B?TFZObThEcWlVOU4wRDlIZDVSL3UxM2YwRG1oS29sZjBmYVpkdGMrOUVVR1h1?=
 =?utf-8?B?cEtwTzkwazcrZUpUeUZsRzdJY2psbUpzMXFVNmZwL29WMDd4OWRWbE1DQ1V2?=
 =?utf-8?B?MGd6dTFZSWZZTWdmL0hOTW14YXlSZWYzaVJLS1dLVFN3SjFSZk1mYlBHY01S?=
 =?utf-8?B?TXRYUkhleU52L296ODIzcHF4ckoxOU9PUEpobG9hZFpNTGYzTWhsamo3aUVP?=
 =?utf-8?B?UFM3ajlYOUVKcHdrKzRYZWVldlRqNkxQSko4Z1FhQ1FhN2pXRjFMWXZOY2dJ?=
 =?utf-8?B?ajZqVjhpVzcxcUlyN3I4RW1JSytVbHViREk2S2VCYkFYMU03bDNVeS9FcUpp?=
 =?utf-8?B?R3VpcWlXaUg0V3IrTTdZbjN0eFRKaWQrM2l5d05ZVTZMNW9mWll4WWZia0Zk?=
 =?utf-8?B?Mit1dENTMWpRMUxBMU41RzRLeDlsMVRRR3RDMGJGMUt3Q2k5anpOeExvRDdi?=
 =?utf-8?B?WUhJYmlSVXg3Z0g4c0JLR1l2Z1Q5MVEzaGhmbU91b3VoRk1YMEdBU1hvU3pE?=
 =?utf-8?B?aU9KMVJGMGNqUDVtSENnbWR1QkVQNXU3QnI5a1Azam4xRUpHOTNFTXQvd1JD?=
 =?utf-8?B?eXZXa0JCY3JuRjFIb1pndi9XMVJlL2xVT29QSTZKMUVsTGFjbVVjSDU1ejVo?=
 =?utf-8?B?cWFRNm90OEJmV1B4WVpHbDJia29tRm9MMkJvZXc5bmcvVlRUL3RtUmZjMjl1?=
 =?utf-8?B?NlBzMndaRHE2RExEWGZLNHEyOUE4aDNxelNwRE9vTGdYai9IYjYxZWtONEdR?=
 =?utf-8?B?OUpoS0hYaG93cmwrTk45WGtBcDZ0NVBKcTV6QUZEOURNU09rZVdwcGY1SExj?=
 =?utf-8?B?S3hYQ094VnZvV0pGbnJhOWluYXFLNCtOR3RVaHhxdnZmM2NBYXllbEF1bEhx?=
 =?utf-8?B?U21NUXVTSWRlZndzRDJpYVcyVWpDb0lSSENtekh3cmFiaWR2VkRnN1hPeHFp?=
 =?utf-8?B?YkJEN09kaWVuWm4wTEhZSzFiRGpTRDlSOWlscTUvTlVuSGYxOS9hWGZwYmtw?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C72216DEC4E98469237B5ADF2DF4B08@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TaAPtA7z7OJypGR+QnAyIn/SDbPsNi4zKMZ3/gLdnyiZLyqZqoK4yyRonvQzqoVsAWuJOBgLVsvpIeGtdsOZO+XWfeJztbUuFGJr+OAsbOEmCyxU/Drhf62fb82ntMWm9a0doCzzVhwUr04L74miDtxya4pfcN4sSKcI9EZB1nLw7O9bet89JgW+7N80kWEWKoaF7DmlEdCrRi0ovequ9wQbsKD1+wNhxBlWPNYuAuvbyzzrMRnSZIUj9q/9CUwVtMkhsHSts8ObZkCY1FeHCHCQ6sW66HVaefevd13hLtU4K+mthz/ic+Idm83isOybzbWu/jhj2SZ+AeEdAeNq0MxvoBkEbnHG5QJ46Do5lCMgRZ52uyeRc8KKUF4SlYU2+yaYHchGfnm9YoOf38zvdvl59j9mVrPQQrpC6Ij0hbXKDb6Goer3fcbZ5Z/ZKWTBX0jpMtoBktRj0mNSMhhpVJe91XUrExZok5cNYqgX4Jp74nRhKKFN87soF2KQ1TWScJNpVlN1etoT/LSIT7/fiXJ6zqc8ivpDEQmfRYIZ1HlGCDprfP0sBQ/s9xrjY8LP9clkjX0LMTXUqMHuR1iwNMGvBHSGDmvWKHLzMr+rAL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de05421-b57a-4ada-9ef9-08dd04b7597a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 14:19:28.2781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zj7EQA71H3bB60pwhVnH+KxkETEcex873FFjHNMXVdRA5WNFDtaBNpsmb5CB1VdTBSr5wdbBzQcVBjW2Amhf8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140112
X-Proofpoint-ORIG-GUID: NvedpjzRl9CiK3zkzpL64lcx6apci8gY
X-Proofpoint-GUID: NvedpjzRl9CiK3zkzpL64lcx6apci8gY

DQoNCj4gT24gTm92IDEzLCAyMDI0LCBhdCAxMDoxOeKAr1BNLCBOZWlsQnJvd24gPG5laWxiQHN1
c2UuZGU+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAxNCBOb3YgMjAyNCwgSmVmZiBMYXl0b24gd3Jv
dGU6DQo+PiBPbiBXZWQsIDIwMjQtMTEtMTMgYXQgMTI6MzEgKzExMDAsIE5laWxCcm93biB3cm90
ZToNCj4+PiANCj4+PiBTbyBpbml0aWFsaXNpbmcgdGhlbSBhbGwgdG8gMSB3aGVuIHRoZSBzZXNz
aW9uIGlzIGNyZWF0ZWQsIGFzIHlvdSBkbyBpbg0KPj4+IGluaXRfc2Vzc2lvbigpLCBpcyBjbGVh
cmx5IGNvcnJlY3QuICBSZWluaXRpYWxpc2luZyB0aGVtIGFmdGVyDQo+Pj4gdGFyZ2V0X2hpZ2hl
c3Rfc2xvdF9pZCBoYXMgYmVlbiByZWR1Y2VkIGFuZCB0aGVuIGluY3JlYXNlZCBpcyBub3QNCj4+
PiBqdXN0aWZpZWQgYnkgdGhlIGFib3ZlLg0KPj4+IA0KPj4gDQo+PiBCdXQsIG9uY2UgdGhlIGNs
aWVudCBhbmQgc2VydmVyIGhhdmUgZm9yZ290dGVuIGFib3V0IHRob3NlIHNsb3RzIGFmdGVyDQo+
PiBzaHJpbmtpbmcgdGhlIHNsb3QgdGFibGUsIGFyZW4ndCB0aGV5IGVmZmVjdGl2ZWx5IG5ldz8g
SU9XLCBvbmNlIHlvdSd2ZQ0KPj4gc2hydW5rIHRoZSBzbG90IHRhYmxlLCB0aGUgc2xvdHMgYXJl
IGVmZmVjdGl2ZWx5ICJmcmVlZCIuIEdyb3dpbmcgaXQNCj4+IG1lYW5zIHRoYXQgeW91IGhhdmUg
dG8gYWxsb2NhdGUgbmV3IG9uZXMuIFRoZSBmYWN0IHRoYXQgdGhpcyBwYXRjaCBqdXN0DQo+PiBr
ZWVwcyB0aGVtIGFyb3VuZCBpcyBhbiBpbXBsZW1lbnRhdGlvbiBkZXRhaWwuDQo+IA0KPiANCj4g
VGhlcmUgaXMgbm8gdGV4dCBpbiB0aGUgUkZDIGFib3V0IHNocmlua2luZyBvciBncm93aW5nIG9y
IGZvcmdldHRpbmcuDQo+IFRoZSBvbmx5IG1lYW5pbmcgZ2l2ZW4gdG8gbnVtYmVycyBsaWtlIGNh
X21heHJlcXMgaXMgdGhhdCB0aGUgY2xpZW50DQo+IHNob3VsZG4ndCB1c2UgYSBsYXJnZXIgc2xv
dCBudW1iZXIgdGhhbiB0aGUgZ2l2ZW4gb25lLg0KPiANCj4gSSB0aGluayB0aGUgc2xvdCB0YWJs
ZSBpcyBjb25jZXB0dWFsbHkgaW5maW5pdGUgYW5kIGV4aXN0cyBpbiBpdHMNCj4gZW50aXJldHkg
ZnJvbSB0aGUgbW9tZW50IENSRUFURV9TRVNTSU9OIGNvbXBsZXRlcyB0byB0aGUgbW9tZW50DQo+
IERFU1RST1lfU0VTU0lPTiBjb21wbGV0ZXMgKG9yIGEgbGVhc2UgZXhwaXJlcyBvciBzaW1pbGFy
KS4gIFRoZSBjbGllbnQNCj4gY2FuIGxpbWl0IGhvdyBtdWNoIG9mIHRoYXQgaW5maW5pdHVkZSB0
aGF0IGl0IHdpbGwgY2hvb3NlIHRvIHVzZSwgYW5kDQo+IHRoZSBzZXJ2ZXIgY2FuIGxpbWl0IGhv
dyBtdWNoIG9mIGl0IGl0IHdpbGwgYWxsb3cgdG8gYmUgdXNlZCBzbyBuZWl0aGVyDQo+IG5lZWQg
dG8gc3RvcmUgdGhlIGZ1bGwgaW5maW5pdHkuICBCdXQgaXQgbmV2ZXIgY2hhbmdlcyBzaXplLg0K
PiBJbXBsZW1lbnRhdGlvbnMgY2FuIGNob29zZSBob3cgbXVjaCB0byBzdG9yZSBpbiByZWFsIG1l
bW9yeSBhbmQgY2FuDQo+IGRpc2NhcmQgZXZlcnkgZXhjZXB0IChJIHRoaW5rKSB0aGUgbGFzdCBz
ZXF1ZW5jZSBudW1iZXIgc2VlbiBvbiBhbnkgc2xvdA0KPiBmb3Igd2hpY2ggYSByZXF1ZXN0IHdh
cyBzZW50IChjbGllbnQpIG9yIGFjY2VwdGVkIChzZXJ2ZXIpLg0KDQpUaGlzIGlzLCBJTU8sIG9u
ZSBwb3NzaWJsZSBpbXBsZW1lbnRhdGlvbiBvZiBhIHNsb3QgdGFibGUuDQoNCkFzIHlvdSBzYXks
IHRoZSBzcGVjIGRvZXNuJ3QgcHJvdmlkZSBhIGxvdCBvZiBndWlkYW5jZQ0KYWJvdXQgaXQuIFRo
ZXJlZm9yZSBJIGJlbGlldmUgb3RoZXIgaW1wbGVtZW50YXRpb25zIGFyZQ0KcG9zc2libGUuDQoN
Ckl0IHdvdWxkIGJlIHBydWRlbnQgdG8gc3VydmV5IHNvbWUgb2YgdGhlbS4NCg0KDQo+IEkgYWdy
ZWUgdGhhdCB0aGlzIHNlZW1zIGxlc3MgdGhhdCBpZGVhbCBhbmQgaXQgd291bGQgYmUgZ29vZCBp
ZiB0aGUNCj4gcHJvdG9jb2wgaGFzIGEgbWVjaGFuaXNtIGZvciB0aGUgY2xpZW50IGFuZCBzZXJ2
ZXIgdG8gYWdyZWUgdG8gcmVzZXQNCj4gdGhlIHNlcWlkIGZvciBzb21lIHNsb3RzLiAgQnV0IEkg
Y2Fubm90IGZpbmQgYW55IHN1Y2ggbWVjaGFuaXNtLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoN
Cg==

