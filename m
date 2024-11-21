Return-Path: <linux-nfs+bounces-8188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209739D54B0
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 22:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46C31F21F51
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 21:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018331B1D63;
	Thu, 21 Nov 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UcAnE+lQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JhMWm21G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E56199FC9
	for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224306; cv=fail; b=aOZU/DGuCrhrtI+QffegfhLd5Bqj5wv6Ul0l5tA6lwVIykBefND0dSGvrPDOjL6XegNvWYIgnzbe42izyZcG/9r+5kmJiEgyV0ERgpknrVT3Zq7U3cHYpfQF95vLXIuZ9OGmzEk8c1y8OQOA8+9c38Ua2I6cvlsU9pBWO2BHSys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224306; c=relaxed/simple;
	bh=+lUCQnId6xIAmJ+V3OZwHMf1Q47f118BDO+TsyHWUqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LLfrMyo7lzIEPPjznh2py6OPc7leGdEICbB5YZNiufv8t2LpB/Jp0lj9foRFwXEx/ikuUDNQQ3zrc1Qg6Wv+wkRRZ+QsNx9/SWwSIpOwaJvPKlyPZUKQdUfeAmzDe9Aux0OMQGwR1zohTdeN2hZfNWz0V/BJGx+QqzkRB/4WsN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UcAnE+lQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JhMWm21G; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALIBbwo004116;
	Thu, 21 Nov 2024 21:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+lUCQnId6xIAmJ+V3OZwHMf1Q47f118BDO+TsyHWUqQ=; b=
	UcAnE+lQYQDpNaS/H5DgoLt3bmUvwxAouGyX018pJIQX0ZzaDaB35bYfQ6SSg4ig
	eTuyNEM+1c0spaSS9EyDuVd/o0V2dSWqOYv1s1WnSovBjrRHtpbSeyDAJrFQn084
	1gRUkLjsYtmJKgqiOWb++JOHfF0dX2J7EGez28YhDgWC+/p8NvKbASOp3G7vFgRE
	Kw1WZMtrHuh1TXRSBUrBWU69LP+v+FZjPF1buuOTbfDZWQh6zlkUIj18BScbKbJl
	J6eRIGOxjPYscU1O1NmqWwW9idE1lt3oASXQr3TkNwMak7yXvFqm/o1SESCLWoOW
	/j/xiC1vbgJA66URR4n88A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98tgyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 21:24:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALKI9SR039181;
	Thu, 21 Nov 2024 21:24:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuc705s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 21:24:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wex6O8zPV6CC4yyZr/GOBSTkXDJ8P7wT9ptufULgtb729SxQUi7P0n0O4TEmR6c0wjajLdPi8R/sLxQ1Gg/hG2y/MEVi1pYRBAP2PaH9k9QmSFjTIBC+BZ7C3qyZlx9pKZAb+LKtV6Hb5NO+OWQsrEkVzezf9HjMG0J6yFYIS5jHKbH0REsJfZvsEh2HPIGQ7gVLQxE3lQA6F3/d93GcvQpsp/ihpEpfhSaeBm8ZpPwYvZtZ6jYLnFZ8zosVAUmM7o405C5LpqIhnq5mey5PTVkXaiYp6Dh3Y8jFlkiYBnq2noanwrrZ16m3tfUwymUSlE1o56FwekgS9GM9HkBrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lUCQnId6xIAmJ+V3OZwHMf1Q47f118BDO+TsyHWUqQ=;
 b=QPHQIYiyqLgCNZwTmAB3lx2++iMWV3wGG1V6AMp6PwrfnG1sPB38JncAbHP1tbD6Och0yXnxi00qWTc5bs0VBKc12qaIq38x2BYLPmRoKsGHCqwyl2V+xUpKqcdWn7R0JOE6upXEZOsAFxMIoinrC50WdiIACKayvPLEdodtUmbH5JSuT09gd8+xHZOKTjcgGHD/H488cIwteaI9Uet6uXFRFpuMde8EQLEQFzOGAaj3ra0NkzuA0XT+pi20A8gxEBq4gxlqZZ49DCy8x9mKW6TqHPrI1pHt6pYk7ObuKuT2dsvWXolEkBca8p8LTUmu++jTRxmHSl3mCyyNhGvoSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lUCQnId6xIAmJ+V3OZwHMf1Q47f118BDO+TsyHWUqQ=;
 b=JhMWm21GF0Lp6E23JZeaySuao8jlqWwkSxnRfPYMBTjh9QGWd3hNenFWEEc4yBj0y/TuBwlJmI22lwSJSSFQv0Di1LvkD8Qft+tzQkzvuBYdex9rS3cs0oWMk1hzO5Ynqz17AnFZp/z4aMSzSxVnmMl0ttwcQOYI/rT7eOiufCA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5631.namprd10.prod.outlook.com (2603:10b6:a03:3e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 21:24:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 21:24:51 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/6] nfsd: add session slot count to
 /proc/fs/nfsd/clients/*/info
Thread-Topic: [PATCH 3/6] nfsd: add session slot count to
 /proc/fs/nfsd/clients/*/info
Thread-Index: AQHbOhz8uOQfhadoVE644HnkNmfrxrK+/DSAgAAzRgCAACGjAIAC7EEAgAAF9AA=
Date: Thu, 21 Nov 2024 21:24:51 +0000
Message-ID: <1E6EDF7D-5B5F-4F17-A1E3-0EBEE0093BBC@oracle.com>
References: <Zz0sbK49PELT7HpN@tissot.1015granger.net>
 <173222300252.1734440.30767813440263840@noble.neil.brown.name>
In-Reply-To: <173222300252.1734440.30767813440263840@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5631:EE_
x-ms-office365-filtering-correlation-id: cfcd63a2-a449-4f46-0db0-08dd0a72ef41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXpMME5PZ3czbFFPb2dzYndvWStKWGpheTFSNlU4M2lhUmhPUXVKNFkxNVps?=
 =?utf-8?B?K2duSTlJWlpUWHUwaTgweWtOdEllOVVuV2t1ajBGRG1JakFKcXNhaDJ3bUpH?=
 =?utf-8?B?TG9lT1pyU243Z2YzZDFFaVp0NUZydE9VTjFJb1B2NGtxaFh4WVN1alVCbGFq?=
 =?utf-8?B?ZkJNUlE5SzVxdW5jNlJSaGFuTSsyTlpxcFVOdm1lNm9QcC9QYSs0Y3BnbWEx?=
 =?utf-8?B?YzVHQ1lEeFk0S3VMcUtSL1h6ZVV4UCtOTFgyWkZPMzZCcGF2Y3dKTGlESlRu?=
 =?utf-8?B?RnVzaG4rMUlESXI2RGtTUDIwQmFpL09MVEw2Q1haQWhGMEJTc3kwYW1iSldw?=
 =?utf-8?B?UlVmaERPcnZ1YjZkVU9zRGdjM0kyT3ZMbjlXeXV4UFJqQStkWC9OUWxRV3Vp?=
 =?utf-8?B?enhTNlVzYmR6a2k4WXdWYzY4NE0vWmo4TUpLT0tRazEzS2JTbU9OaEY5WjJB?=
 =?utf-8?B?VGIrQ3N1MzZZWWRvTGxxSGU3V0pOOWk5YkNoZFRqSjAwaE1tekIvbEdlVkJP?=
 =?utf-8?B?d1B2R1FRM044R0pjK3l0eWoxWDlSbGQ1UCtibFh6ZWkwa1A5TDVVcGprWE5P?=
 =?utf-8?B?TGV0cTNCK1hGeXI0T2cwL1IwMkNtdlk3cXRlQjZQcTFEZEd5UFoxbEZqc2Fj?=
 =?utf-8?B?VmkwR1I2WCs3ZzdvV2gyVjBnTytHMUpZYjZCZm4rZW1tbkowb005alZFdVZY?=
 =?utf-8?B?bDQ5cHladU8rL0l3QjRpYU5saXhvamRyQzJtdHJrQkg5WUQrYVJFZWtpRGsw?=
 =?utf-8?B?eGJ2ZWwwYTNTeGFoSC9ITEs3aWJ4dld3RlRlZjNndXFZcy9RZDI5N0VaRUhp?=
 =?utf-8?B?N1ZacEMxbmRnMWpmZDRaVTZMc1hxYVk1bWVsdUVZWWtrZ3hVSjdXQVY2NVdO?=
 =?utf-8?B?Wno3dTZQN3FoWUNsTGkya1lyWi90N21heTlJdGRvcWxMOTNlOVNDZzloZGJK?=
 =?utf-8?B?WjM3RGFMMDJWNjY2NWpXY3RLOTJqYUZYWFRib3dFY0pHRkpOcWRpVEdmelFk?=
 =?utf-8?B?YmJHcDJpajhkMkd0Y2ZJSFh4cEE0bzVrbG42V1ZnTU8rNHVVMjZLUXhkRzR6?=
 =?utf-8?B?bjlRbkNuVURoODllWFg2YWd3cVRqbUdqbEJ2bXp1TXJIbUV3NTNhdW9lUUF2?=
 =?utf-8?B?SndxVmk4eUFKVEhGVzJ2Tmd2bFR4dlFPNHhKd29MSjAyV0xlb0VGUG05ZGdq?=
 =?utf-8?B?OFJsVUFPQ0pGNGhpZmVXUG9pTi9rVEpqZDR1ZzY1SFk2bTNKeGJRZUpGVkFx?=
 =?utf-8?B?WStqYTZ1amN2TTd4aDZDZG5kbDA1UFhSK04zK0JtN085WlozZ3UrdWF6UEd3?=
 =?utf-8?B?NHllUlBXOFpoMGREc1BxRnpDL0pQc3JVZDRuQ2RWaTFtQXlCWWsvVDViay9S?=
 =?utf-8?B?ODFHdXh3bnZZSW00dUFYdVFIRXh0ZWY3a1Vib08xVDVGcFRUVGZqT1B2aUNY?=
 =?utf-8?B?TVRMdkt0dG43dStNZHdOdXpWY1F0SkZHcE5VYWVjZVZnQnFWYTZJdEZheUlS?=
 =?utf-8?B?SFVhOWpxVmZtSUFWelE1aG9INktXTHBqMEVhYWE5b2xrMGE2TkY0V1o2a1dX?=
 =?utf-8?B?cEhOQUcwRm55MWx3RlkycmswMnBSOVJoTVJTckFPZXB6YU1ackNSbEFrRnJy?=
 =?utf-8?B?WER1ZlAxMHprM1BwcmhEYjByazZ0L3BpbUxSL09lbTBjdVBoMjNwRXlVN0kv?=
 =?utf-8?B?Vk41UHJEaHBEdzVCeHpOU2tNUU9DQU1JZ21yQndGSlZJVGR3YUhqRktQODNU?=
 =?utf-8?B?dytYTkZQSWI2VUVTQmc3RGlVTnJncmFtNkM4ekZaVitNZWY5M09MYXlEdm82?=
 =?utf-8?Q?sU6WKvGQgI06tjoTt+e/PBXSJoKWgIezIvfWc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WCtsTXJqNVQ5bzFaQnZjTy9IQlBhb0VQU29ldEhHUUlrZVBtbnpWdWVpcG9W?=
 =?utf-8?B?WWtYUVdjMTJrSmg1TGhQaXJpbWNSSklCMHdCV2dPOGQ3Q0FWS29QTEQ2Z0Iv?=
 =?utf-8?B?VTlNeG5oL1JoQnovb2ZEOGZKQTZ2SG5pblpDOExycFh2VUZ0YUpKeUtaMS9z?=
 =?utf-8?B?VGt6R0xhWkQwU21hR1g3cjU2NTRLdWFMZDhmUGplckxDbW1MRXFVb1VrRUhG?=
 =?utf-8?B?UGhkSDllaW9nZUdwU2NDNnpacDZHalRuYmRjSk1sNkZDM0VBZWRmWERSUjUv?=
 =?utf-8?B?QVlobmx1ZFltYzVSYk8xODhKS0R2SXlMd0NTbVBINzZnNGVPcHJ6MzJoaGJ4?=
 =?utf-8?B?TkhXTTdqM3NiQUNXdktyS0g5NmUwZmhydmxrdVRSN0NKUFVKR2I0eWFpZUVE?=
 =?utf-8?B?Um04VktCcVF3WkJsemxpV0dhSk0yVTRYL0VrSmtUclMwSFBGTUF5b0JteHNV?=
 =?utf-8?B?V096Wk95U1lndUJjNG9kMFhONDBlOE40dW5lMHB3TXJHa3NrUmlJSnpkcXZC?=
 =?utf-8?B?ZlVweXh1UHhnL25VUkovNEg0S1BhcFlSVVViaExCMXZnSytqbldsMUZMSTZa?=
 =?utf-8?B?Kzgwc0xTSkduTUhxRitYNlR1S1Nhdkh2T0NiTHdlRW9CMTJpS0ZaUGZ0VzdK?=
 =?utf-8?B?WUF6SHMwMFN0cURGM3Z3UlF3NjU0Q0JoRlNqWXc1c3BFRnZ2dnlKaUVQZ1Fv?=
 =?utf-8?B?UWZsQk1TUU03RVF1bWNQODdVOGVGMTFqSUEwdFNkVTZvdytlblA0REZmcklu?=
 =?utf-8?B?L3AyNlBJRExyRlRCNmlTR3BHTDJmSDZQU2ZFdHVncjgxZnBKeEpYRkJ0ZDkv?=
 =?utf-8?B?dTczbWpaV3gxLzFhUm1rM0x5ZWpoMHVHbzFlbSt4K3FDbG9aeEt3QW5xdWln?=
 =?utf-8?B?TXZUbm5kblNiSFZSczhLM21VSlVKb3YvUHEyWWFRY1NVMzBYanlFQ2t2ays2?=
 =?utf-8?B?WDg2eURJbnNvSnU5VWlzWEdodG1sSStPZkJYM2xCRzNpa0t6YkVRUkNUNGVO?=
 =?utf-8?B?L3RrcXBiQk1GSG9BK2ZYMUdEQks5aEFDQzN2djVMdnQ1THBxQ2VNdXBLbEFo?=
 =?utf-8?B?emkySmR1WjRiY2p0aERuVXJmbTByMVprWGMzRktSN2VFZmhhd0JnU0FRb1dw?=
 =?utf-8?B?YnZ3MEtML3BVWjYrYXJzb2xKRnJYN0wvQU42Mm44NTBiRkI5ekI3MGllMFp6?=
 =?utf-8?B?NWFaM0IrMldrNGNJajNnT0tGRVFzSWQxRmlTR1J6MXUvdVNMVVpSK3lTSjlN?=
 =?utf-8?B?a1BRTi9LOUVHSVFzZTk1b0d6VUdQanJYLzJ6K28zUlR0V21DMDFrWG5UeEpp?=
 =?utf-8?B?dDhHZERYc1h6RHpwVk40MExJRkw0eGpxc1c5Zk1iK0lmeE5wWU1KTXdoOFlU?=
 =?utf-8?B?NnNOUXNnOHhUa05iU2pFM2hic1p5UUxoY01hUE5oZkRqM0owSTJOY2k1eXZz?=
 =?utf-8?B?N3NRT1o4MlZlemYvZHA3cjBkWU9ySEVJV1dKVGU5alZQVi93V2k0VHVqaU5P?=
 =?utf-8?B?L25wemloY3FXbzVGQXYrWHRZQWlsL2J4TWtURmF1MnJSSWl0ZFlYYmRwU2FJ?=
 =?utf-8?B?eFhXa0kvVndkWjRzS01GRmQ1dmI4a3ZCRkkyOXErUDJKWWphUEdCRnQ4QzJt?=
 =?utf-8?B?TmdqZjRmWDB1NDBYRndFNHhrK1EyTUpBa3JqaG9rUDN2Z2NmSlFHTGdSOGhH?=
 =?utf-8?B?bFNicGt3ZEJRYm5VdW8yV0FucXVqVmJsYmljcGJtT2JRTkI2N1VpaWQ3NVBT?=
 =?utf-8?B?T0thUk9xb1ZHNVhwMGRQeTluS3FhaU1QQVlSdWhHdkRpeTNQamF5NzI5a0xV?=
 =?utf-8?B?YnlhS0VaWHlFVGErenFqaTlPTnlDMTgwdVVtWFU5V1k5OUVaalR6a0VHQmNm?=
 =?utf-8?B?dE9yMUdUMFBidE1ZeDJrczJhUUJPQWtpYXpyRUxrYThVRnhEcGNBMmtmcmZV?=
 =?utf-8?B?bkR3NlAvSUJtalZnNGI3NkxGNzZnTjhreDZhcHVoUkRWVG5ZNXRPY2VCaUhO?=
 =?utf-8?B?ZFhHdi9CNUp5NDgxUmI0aTAxeHFvY3pMVmFGdXErUklacXBZTUpuV2RNVDRN?=
 =?utf-8?B?QkNGSXdubm9KL2FsNFBCdUJRRXpQZisvZnNTYnZYMU9uZHhFc3Q1VnlxOHZs?=
 =?utf-8?B?N0FNRmxhVE54eUZGdHZJUS8reGhTM3ptbDAxTWdJU2JqbEJvaWNHVU82VHdN?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E19D115B85CC97408C07450CFBC51EA3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OWy7jbPbGK5Te8oyjJSvpBbdwM7aDXyQN+grt38bAUpEOtGCXBMToOxXhMPc8IjcDWscuTl3qLTId6vOy/nyMGkZWIUYYGYNutspjBpQEAYaHTspIAk1+plPriGRCE7P5TGz4bb0PYtHzzqvt57Y0KM5658MfSU4Mz3zaXK4cJMuVgw8nlXXsBA/Yp9OtFNlMyyatXDfr0ZCE1hESCzsW90JfdwVa+Rmfh3myxH4VRL1F6h835Uwy/Mlrag93Zp3LUT/dNXVrTU+n9+WetpZp1BDuGV9XKwapcVesh2X4qdcmK4exOc88iEYZxc+wgTMdsnH6LCx/pgVehPv2mmiyVcYQ1HUV4jbZHJS3nFmociuiClMnLKwOWcKZOMLJkBQgyOOHIsnzF03hVt2qc5ptzu2g54/hLYueNVOlTUXIe7wZxVwckuY6TGu5sg/PSJh8/QCx2kTI9veu+z2aUP5sRzgKtenCZLC5KN7X3u5jZZB0v0nPCN4ab60XuG1Pe33LXsnwM7KzOkWWgvA1Y15k7YbtSSGnJrMsFcRiuoI+vfvVbkVaqNpCkyiEWtDoP4sSjyROYyl1gCcjcQ0oy/Wlx86h+s/wVyNHtjOdcNq7qQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcd63a2-a449-4f46-0db0-08dd0a72ef41
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 21:24:51.2485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M94xk+5ahjGr9c59xZCQjz0dU76a4odPw7s/1qYGHCqCB2qzkIW33m+E0ETNetFPfABYsQo6T6KVAPAI3ShgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_15,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210160
X-Proofpoint-ORIG-GUID: psw1sFUck53bAJFSh24yJwnDmpAkmzLN
X-Proofpoint-GUID: psw1sFUck53bAJFSh24yJwnDmpAkmzLN

DQoNCj4gT24gTm92IDIxLCAyMDI0LCBhdCA0OjAz4oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDIwIE5vdiAyMDI0LCBDaHVjayBMZXZlciB3cm90
ZToNCj4+IE9uIFdlZCwgTm92IDIwLCAyMDI0IGF0IDA5OjI0OjUyQU0gKzExMDAsIE5laWxCcm93
biB3cm90ZToNCj4+PiBPbiBXZWQsIDIwIE5vdiAyMDI0LCBDaHVjayBMZXZlciB3cm90ZToNCj4+
Pj4gT24gVHVlLCBOb3YgMTksIDIwMjQgYXQgMTE6NDE6MzBBTSArMTEwMCwgTmVpbEJyb3duIHdy
b3RlOg0KPj4+Pj4gRWFjaCBjbGllbnQgbm93IHJlcG9ydHMgdGhlIG51bWJlciBvZiBzbG90cyBh
bGxvY2F0ZWQgaW4gZWFjaCBzZXNzaW9uLg0KPj4+Pj4gDQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBO
ZWlsQnJvd24gPG5laWxiQHN1c2UuZGU+DQo+Pj4+PiAtLS0NCj4+Pj4+IGZzL25mc2QvbmZzNHN0
YXRlLmMgfCA4ICsrKysrKysrDQo+Pj4+PiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
DQo+Pj4+PiANCj4+Pj4+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRzdGF0ZS5jIGIvZnMvbmZz
ZC9uZnM0c3RhdGUuYw0KPj4+Pj4gaW5kZXggMzg4OWJhMWM2NTNmLi4zMWZmOWY5MmE4OTUgMTAw
NjQ0DQo+Pj4+PiAtLS0gYS9mcy9uZnNkL25mczRzdGF0ZS5jDQo+Pj4+PiArKysgYi9mcy9uZnNk
L25mczRzdGF0ZS5jDQo+Pj4+PiBAQCAtMjY0Miw2ICsyNjQyLDcgQEAgc3RhdGljIGNvbnN0IGNo
YXIgKmNiX3N0YXRlMnN0cihpbnQgc3RhdGUpDQo+Pj4+PiBzdGF0aWMgaW50IGNsaWVudF9pbmZv
X3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2KQ0KPj4+Pj4gew0KPj4+Pj4gc3RydWN0
IGlub2RlICppbm9kZSA9IGZpbGVfaW5vZGUobS0+ZmlsZSk7DQo+Pj4+PiArIHN0cnVjdCBuZnNk
NF9zZXNzaW9uICpzZXM7DQo+Pj4+PiBzdHJ1Y3QgbmZzNF9jbGllbnQgKmNscDsNCj4+Pj4+IHU2
NCBjbGlkOw0KPj4+Pj4gDQo+Pj4+PiBAQCAtMjY3OCw2ICsyNjc5LDEzIEBAIHN0YXRpYyBpbnQg
Y2xpZW50X2luZm9fc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpDQo+Pj4+PiBzZXFf
cHJpbnRmKG0sICJjYWxsYmFjayBhZGRyZXNzOiBcIiVwSVNwY1wiXG4iLCAmY2xwLT5jbF9jYl9j
b25uLmNiX2FkZHIpOw0KPj4+Pj4gc2VxX3ByaW50ZihtLCAiYWRtaW4tcmV2b2tlZCBzdGF0ZXM6
ICVkXG4iLA0KPj4+Pj4gICAgYXRvbWljX3JlYWQoJmNscC0+Y2xfYWRtaW5fcmV2b2tlZCkpOw0K
Pj4+Pj4gKyBzZXFfcHJpbnRmKG0sICJzZXNzaW9uIHNsb3RzOiIpOw0KPj4+Pj4gKyBzcGluX2xv
Y2soJmNscC0+Y2xfbG9jayk7DQo+Pj4+PiArIGxpc3RfZm9yX2VhY2hfZW50cnkoc2VzLCAmY2xw
LT5jbF9zZXNzaW9ucywgc2VfcGVyY2xudCkNCj4+Pj4+ICsgc2VxX3ByaW50ZihtLCAiICV1Iiwg
c2VzLT5zZV9mY2hhbm5lbC5tYXhyZXFzKTsNCj4+Pj4+ICsgc3Bpbl91bmxvY2soJmNscC0+Y2xf
bG9jayk7DQo+Pj4+PiArIHNlcV9wdXRzKG0sICJcbiIpOw0KPj4+Pj4gKw0KPj4+PiANCj4+Pj4g
QWxzbywgSSB3b25kZXIgaWYgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGJhY2tjaGFubmVsIHNlc3Np
b24gY2FuIGJlDQo+Pj4+IHN1cmZhY2VkIGluIHRoaXMgd2F5Pw0KPj4+PiANCj4+PiANCj4+PiBQ
cm9iYWJseSBtYWtlIHNlbnNlLiAgTWF5YmUgd2Ugc2hvdWxkIGludmVudCBhIHN5bnRheCBmb3Ig
cmVwb3J0aW5nDQo+Pj4gYXJiaXRyYXJ5IGluZm8gYWJvdXQgZWFjaCBzZXNzaW9uLg0KPj4+IA0K
Pj4+ICAgc2Vzc2lvbiAlZCBzbG90czogJWQNCj4+PiAgIHNlc3Npb24gJWQgY2Itc2xvdHM6ICVk
DQo+Pj4gICAuLi4NCj4+PiANCj4+PiA/Pz8NCj4+IA0KPj4gSWYgZWFjaCBjbGllbnQgaGFzIGEg
ZGlyZWN0b3J5LCB0aGVuIGl0IHNob3VsZCBoYXZlIGEgc3ViZGlyZWN0b3J5DQo+PiBjYWxsZWQg
InNlc3Npb25zIi4gRWFjaCBzdWJkaXJlY3Rvcnkgb2YgInNlc3Npb25zIiBzaG91bGQgYmUgb25l
DQo+PiBzZXNzaW9uLCBuYW1lZCBieSBpdHMgaGV4IHNlc3Npb24gSUQgKGFzIGl0IGlzIHByZXNl
bnRlZCBieQ0KPj4gV2lyZXNoYXJrKS4gRWFjaCBzZXNzaW9uIGRpcmVjdG9yeSBjb3VsZCBoYXZl
IGEgZmlsZSBmb3IgdGhlIGZvcndhcmQNCj4+IGNoYW5uZWwsIG9uZSBmb3IgdGhlIGJhY2tjaGFu
bmVsLCBhbmQgbWF5YmUgb25lIGZvciBnZW5lcmljDQo+PiBpbmZvcm1hdGlvbiBsaWtlIHdoZW4g
dGhlIHNlc3Npb24gd2FzIGNyZWF0ZWQgYW5kIGhvdyBtYW55DQo+PiBjb25uZWN0aW9ucyBpdCBo
YXMuDQo+PiANCj4+IFdlIGRvbid0IG5lZWQgYWxsIG9mIHRoYXQgaW4gdGhpcyBwYXRjaCBzZXQs
IGJ1dCB3aGF0ZXZlciBpcw0KPj4gaW50cm9kdWNlZCBoZXJlIHNob3VsZCBiZSBleHRlbnNpYmxl
IHRvIGFsbG93IHVzIHRvIGFkZCBtb3JlIG92ZXINCj4+IHRpbWUuDQo+IA0KPiBJIGNhbm5vdCBz
YXkgSSdtIGV4Y2l0ZWQgYWJvdXQgdGhlIHByb2xpZmVyYXRpb24gb2YgdGlueSBmaWxlcy4gIFlv
dXINCj4gc3VnZ2VzdGlvbiBpc24ndCBxdWl0ZSBhcyBiYWQgYXMgc3lzZnMgd2hpY2ggY2xhaW1z
IHRvIHdhbnQgb25lIGZpbGUgcGVyDQo+IHZhbHVlLCBidXQgSSB0aGluayB0aGUgc3lzZnMgYXBw
cm9hY2ggcHJvdmlkZWQgbW9yZSBwYWluIHRoYW4gZ2FpbiBhbmQNCj4geW91IHNlZW0gdG8gYmUg
aGVhZGluZyB0aGF0IHdheS4gIEFzIGV2aWRlbmNlIEkgcHJlc2VudCB0aGUgcmlzZSBvZg0KPiBu
ZXRsaW5rLiAgTmV0bGluaydzIG1haW4gYWR2YW50YWdlIGlzIHRoYXQgaXQgYWxsb3dzIHlvdSB0
byBhY2Nlc3MgYQ0KPiBjb2xsZWN0aW9uIG9mIGRhdGEgaW4gYSBzaW5nbGUgc3lzY2FsbCAob3Ig
bWF5YmUgcGFpciBvZiBzeXNjYWxscykuICBJZg0KPiB3ZSBoYWQgYSBzdGFuZGFyZCBmb3JtYXQg
Zm9yIGRvaW5nIHRoYXQgd2l0aCBvcGVuL3JlYWQvY2xvc2UsIHRoZQ0KPiBmaWxlc3lzdGVtIHdv
dWxkIGJlIGEgbXVjaCBuaWNlciBpbnRlcmZhY2UuICBCdXQgdGhlIHN5c2ZzIHJ1bGVzIHByZXZl
bnQNCj4gdGhhdCwgc28gcGVvcGxlIHdobyBjYXJlIGF2b2lkIGl0Lg0KDQpJIGRvbid0IHNlZSB0
aGlzIHNldCBvZiBpbmZvcm1hdGlvbiBhcyBiZWluZyBpbiBhDQpwZXJmb3JtYW5jZSBwYXRoLiBO
ZWVkaW5nIG11bHRpcGxlIG9wZW4vcmVhZC9jbG9zZQ0KaXRlcmF0aW9ucyBkb2Vzbid0IHNlZW0g
bGlrZSBhbiBpbXBlZGltZW50IHRvIG1lLg0KDQpUaGUgb25seSBwb3NzaWJsZSBpc3N1ZSBpcyB0
aGF0IHVzZXIgc3BhY2UgbWlnaHQNCndhbnQgYSBzbmFwc2hvdCBvZiBjZXJ0YWluIHJlbGF0ZWQg
dmFsdWVzLCBhbmQNCmhhdmluZyB0byBnZXQgdGhlIHZhbHVlcyBmcm9tIG11bHRpcGxlIGZpbGVz
IG1lYW5zDQp0aGVyZSdzIG5vIGd1YXJhbnRlZSB0aGF0IHRoZSB2YWx1ZXMgYXJlIGNvbnNpc3Rl
bnQNCndpdGggZWFjaCBvdGhlci4NCg0KDQo+IFdlIGRvbid0IG5lZWQgdG8gaW1wb3NlIHRob3Nl
IHNhbWUgcnVsZXMgb24gbmZzZC1mcy4NCj4gDQo+IEhhdmluZyBzZXBhcmF0ZSBkaXJzIGZvciB0
aGUgY2xpZW50cyBtYWtlcyBzb21lIHNlbnNlIGFzIHRoZSBjbGllbnRzIGFyZQ0KPiBxdWl0ZSBp
bmRlcGVuZGVudC4gIFNlc3Npb25zIGFyZW4ndCAtIHRoZXkgYXJlIGp1c3QgcGFydCBvZiB0aGUg
Y2xpZW50LiANCj4gVGhlICpvbmx5KiB3YXkgc2Vzc2lvbiBpbmZvcm1hdGlvbiBpcyBkaWZmZXJl
bnQgZnJvbSBvdGhlciBjbGllbnQNCj4gaW5mb3JtYXRpb24gaXMgdGhhdCB0aGVyZSBpcyBtb3Jl
IHN0cnVjdHVyZSAtIGFuIGFycmF5IG9mIHNlc3Npb25zIGVhY2gNCj4gd2l0aCBkZXRhaWwuICBJ
IGRvbid0IHRoaW5rIHRoYXQganVzdGlmaWVzIGEgbmV3IGRpcmVjdG9yeS4NCg0KSHJtLiBJTUhP
IGEgZGlyZWN0b3J5IGlzIGV4YWN0bHkgc3VpdGVkIHRvIHRoaXMga2luZCBvZg0KaW5mb3JtYXRp
b24gaGllcmFyY2h5LiBJIGNhbid0IHNheSB0aGF0IEkgdW5kZXJzdGFuZCB5b3VyDQp2aWV3OyBw
ZXJoYXBzIHlvdSBmZWVsIHRoaXMgd2F5IGJlY2F1c2UgdGhlIGNsaWVudA0KaW1wbGVtZW50YXRp
b25zIHdlIGFyZSBmYW1pbGlhciB3aXRoIHVzZSBvbmx5IGEgc2luZ2xlDQpzZXNzaW9uLiBGb3Ig
dGhhdCwgb2YgY291cnNlLCBhIGRpcmVjdG9yeSBpcyBvdmVya2lsbC4NCg0KDQo+IEl0IGRvZXMN
Cj4ganVzdGlmeSBhIGNhcmVmdWxseSBkZXNpZ25lZCAob3IgY2hvc2VuKSBmb3JtYXQgZm9yIHJl
cHJlc2VudGluZw0KPiBzdHJ1Y3R1cmVkIGRhdGEuDQoNClRoYXQgdXN1YWxseSBtZWFucyBKU09O
IG9yIFhNTCwgd2hpY2ggYWxzbyBoYXZlIHRoZWlyIGhhdGVycy4NCg0KSG93ZXZlciwgSSBkb24n
dCBmZWVsIHN0cm9uZ2x5IGFib3V0IHRoaXMuIFlvdSBhc2tlZCBtZQ0KZm9yIHNvbWUgdGhvdWdo
dHMsIGFuZCBoZXJlIHRoZXkgYXJlLCBhdCByYW5kb20uDQoNCk15IGJvdHRvbSBsaW5lIGlzIHJl
YXNvbmFibGUgZXh0ZW5zaWJpbGl0eSAtLSB0aGUgYWJpbGl0eSB0bw0KcHJvdmlkZSBtb3JlIGlu
Zm9ybWF0aW9uIGluIHRoZXNlIGZpbGVzIGluIHRoZSBmdXR1cmUgd2l0aG91dA0KcGVydHVyYmlu
ZyBjdXJyZW50IGNvbnN1bWVycy4gSU1FIHRoYXQncyBiZWVuIG5lYXJseSBpbXBvc3NpYmxlDQp3
aXRoIGRlc2lnbnMgdGhhdCBoYXZlIG9uZSBmaWxlIGZ1bGwgb2YgZmllbGRzIHRoYXQgbmVlZCB0
byBiZQ0KcGFyc2VkLg0KDQpTaG91bGQgd2UgZXhwb3NlIHNlc3Npb24gaW5mb3JtYXRpb24gdmlh
IHRoZSBuZXcgTkZTRCBuZXRsaW5rDQpwcm90b2NvbCBpbnN0ZWFkPyBPciBhIHNlc3Npb25zLyBk
aXJlY3Rvcnkgd2l0aCBvbmUgZm9ybWF0dGVkDQpmaWxlIHBlciBzZXNzaW9uPyBJJ20gb3BlbiB0
byBkaXNjdXNzaW9uLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

