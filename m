Return-Path: <linux-nfs+bounces-3372-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405448CE87B
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 18:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF611F2346D
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 16:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7420412E1D7;
	Fri, 24 May 2024 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FfGW3akY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="boRR55J5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363412E1CD
	for <linux-nfs@vger.kernel.org>; Fri, 24 May 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566988; cv=fail; b=AnqdPkuWGzlim+xVh6u8X9RbHkwRvEVSywdh0DEvM5Su5w0RmtpOGzI1dWrURKfFJYO21IaX+HlKE2Me0ZDQY+Wwba/vxqPQIM4FZKQEaNNbIj9rVwY8DzBuGDH1/pPXfvLSj7aSojYv+MdqeuDQvN3/yae5u3yfBdkri7Q2w4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566988; c=relaxed/simple;
	bh=lTX0C8LWI6tF/kWVFMl+4tF7gzQ3NuNy0gUDj7ch3wY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tkXhZDaFUt8JZWyA6BEPC5ICzCNTiX5gG2N90MDaF8mCLp6+qVxJQ7aJ7pWsS/F6/DWXZ861RzkkocJnSepRxGaX3maAj9qGWU9ta8lDaGUuc+AsvEZQDScUyRj9U+fbszmWCu8+BG6PJwKzLpU42cecOdEvFi81AeiOGPQaOPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FfGW3akY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=boRR55J5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44OFxb3x021458;
	Fri, 24 May 2024 16:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lTX0C8LWI6tF/kWVFMl+4tF7gzQ3NuNy0gUDj7ch3wY=;
 b=FfGW3akYAxRYJ7GAIVHf6Y9h8tBIUV/KqoPTuMwNtZq/7YwISZPV8B9ghiYGh8ed1Lvg
 uGutFFldpS7s1ALFSyPoRAukcaid6SJfguOKTmugPnLV0rAdJ0ipv2hHZQnockQEhTE+
 q96DBzpK+Ehf8EKGz+bVhy7zQMzmRzxEG89Q/BMLhOiym5uA/L5ScQ941MulM2QtCLa0
 ARWA7wF2iQa1v8SgfnNf/CD2zfzT7zTad+nUHXDFnzsf65a0EqTR30awLh3V13jhuZrQ
 H86QhbjjASuULIaskiJNLW02Dob72bk0ml0C2k9oFPYb8+jjdgHXPr/jNHhYiHeizFkp 3w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6m7bcejx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 16:09:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44OFL5xA013690;
	Fri, 24 May 2024 16:09:22 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsbge52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 16:09:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9rTPO6T2/afZCy8OOLjvsTDvWtv5PBj1F0YxRrZw3hrzLWE6s8ybjNmZsoV8kBWjjLnFfrA/vl5DHRsgqBifNexe9kDjyqWZH6Wx0LcQY+omNZNdVOr5ctZVulZQZrxpBKrqOyrl7xSOaKCZZyVqGPiehnGH1jZ3cNobSK/8CPkEW5JC6MkyzAqP+WnIpFmpn8A9++JcBztSKHuVMyUcLd04s1NERwAhiA/SMU7o2bKBkD2iz81/0tnDPvH3wQhh4VxuLiVD0+ctbgiPNwUwxJm2X4WpevFVXnJO7BS4CKk3F5AvtIx1qQkbkXmfwBV/y3D/j1GSQOJ7wqpuscfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTX0C8LWI6tF/kWVFMl+4tF7gzQ3NuNy0gUDj7ch3wY=;
 b=d4DpOduMPJ8QWwsSsJ7K/PbCVurXekMAduc7N7EumXXioau6bYTR8vLqNkXQC4Iate9nohvjsJ9ClhMkTd3ODyttUJUie8ubBO1tArLKGDhsinmHzpjLb+8c/+0BbId5KD7NH3VSaxnUTjorUP20IJArKxy2FkkBI6A4G/luAY5+GMtwz9WWMTEDUvrZZV7DJCOywNrIHz4pYQOHfXsKaBVnGe/Ma/G/RMactMnt3IjV5YfJgeEgy1arU+OcXOsidoiLvdpfbhHVtSg9FJ/U9jL5xddriBdw3ZI/M/+Jf5BBgRo+CPcNosS4H+GMPUYuzLHeleniSF5CHmOIjDd0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTX0C8LWI6tF/kWVFMl+4tF7gzQ3NuNy0gUDj7ch3wY=;
 b=boRR55J5EbkSQ9llb2MS11RaLrZOTmgPyWTDxGR0OJgYwLP2+OcYSP1wJlKb67hJtk3mXlaGmpwSPZWobXxFKQfWcDi1hlBOjzxOuQhHynooDBDRlCZ7cYF2enonSWoFJWfXumn/tuFH6GyZt8dqhrM5KZQphcpeI5pLRotVY78=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5718.namprd10.prod.outlook.com (2603:10b6:a03:3ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 16:09:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7611.025; Fri, 24 May 2024
 16:09:18 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
CC: Jeff Layton <jlayton@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "it+linux-nfs@molgen.mpg.de" <it+linux-nfs@molgen.mpg.de>,
        Linus Torvalds
	<torvalds@linux-foundation.org>
Subject: Re: NFSD: Unable to initialize client recovery tracking! (-110)
Thread-Topic: NFSD: Unable to initialize client recovery tracking! (-110)
Thread-Index: AQHaknnPaXSa5g+Zzk6CqrxcsNUIVLGhpRgAgAABwACABMvJgIAAUdUA
Date: Fri, 24 May 2024 16:09:18 +0000
Message-ID: <5360A648-8236-466C-A9D8-82F2BBE6F059@oracle.com>
References: <aaeae060-2be0-4b9f-818c-1b7d87e41a5f@molgen.mpg.de>
 <e8ab863e-18a5-4c16-b0c8-a3ab6440a9f6@molgen.mpg.de>
 <5096230634b5bab2e5094c0d52780ffe2fa75bb9.camel@kernel.org>
 <90700421-4567-4e28-ae71-8541086b46e2@leemhuis.info>
In-Reply-To: <90700421-4567-4e28-ae71-8541086b46e2@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5718:EE_
x-ms-office365-filtering-correlation-id: 64f9a332-61d0-4cba-d42c-08dc7c0bdded
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R25zemJpb0F3UTlWb3VrbDRSaU50SFpXSVViVzNOaXZ5RGtHQ3B6aFVhU2xj?=
 =?utf-8?B?N3F1MGg2c0dTUDhrbUlnNzlwenlVTnVXUjJBZWNoNk4yenRydm9jVk9qcS82?=
 =?utf-8?B?QjRmWDZjT25rKzVzYmQreFo5OGYvNk1HN2ZOM3d4RnJsd1NJVWVvdmNzN0tO?=
 =?utf-8?B?MFNZZXRCRnU3N2ZqRjdOUlcxYWZnN1hrY1lTU1praGJLQUNwYjRRMGc4WE94?=
 =?utf-8?B?d2J4WEtnZDZRZ3VoRDVpVGY1UnM2NVl2LzZmSTBXVnMxL1M4WDJTbGU5Y3RF?=
 =?utf-8?B?UXRxdS9UQUxjcldZVG9rS1FJVkpLMFUyT2ZuS0kwa2NaZldkV0tFQ004U1Vi?=
 =?utf-8?B?U2RoS3JLa2J3YnJyUlpSQUxrMzVBdlNyY3o3RmpPSlVXQmh5WjFJYXZRR0FI?=
 =?utf-8?B?cXNCaG0vWXFWT3B6U1BxRmsyMUw2TDFUTHRNQXVHMDFaeGppNWZnWDVKQ1Fi?=
 =?utf-8?B?MHR3TitWeVNTK2s5TklVb0ZyeGY3dnJVOXB5K3VpdVEvNHk1MHpWWk1TcnZ2?=
 =?utf-8?B?dE1FT2VqZ3RzQjNWVndNSkc0UTZXRWMzY2VMZUFFQjYzSUx5b1F6ZVplR3lx?=
 =?utf-8?B?Q0Y0eEh1MkVkdDBoMm9VRHFEaENjSXlad21UOWZoOHNSTEZRVm5TWTVLYjRU?=
 =?utf-8?B?bFZKeWRIV2VhWG5BM1NqbmQxSnBaZ0JJWjFNM1BtdVovTnAzUm9lQnJWRE9j?=
 =?utf-8?B?OXZ3WW9sc3A2OXhES21ISS8vUFI4ZjVWd2tucUwrckhiRXZJSDhrZld1WStv?=
 =?utf-8?B?N2xFRm9KVXdMWitLUXdrNVpQOUNoK0ZuYjFYU0V2T2taTjQzam1YWDJsZXBk?=
 =?utf-8?B?SWdCSEdieWJnRGlDRzhVYkZYQkRTY2s3N09JbnkzSWhCV2pmK3FIZEVXY0tC?=
 =?utf-8?B?eTNDbko5c09sWHB3VVBPMFBFYXZiaVIvd1BuNEZ2aHUxTzlmOTgzS2hJK0FL?=
 =?utf-8?B?UFcrUExvZHdZelFXY21zOEdNWkdYaExBQkVTb1R3SnJRekhkOFNCQ1cxd3R1?=
 =?utf-8?B?dTE5MzExblIraS9EUW5YYXJvUHR4Q2JwMHN5TVRiOEduS2wwdXlFL3RpdHF6?=
 =?utf-8?B?Z2gyNTdPanRBNy96d0pJZzcydG55L3pyaWRXNEdWT3FRUDB5K0c0bjAvWFln?=
 =?utf-8?B?Uy9uRWlFeVBxbWdicU1ad2dmMk1Dd1RPMzVtWDVib3hyaTBrQWl2eWxWa3Bj?=
 =?utf-8?B?SHh1djcvQTdrUWlkOFdyYm5Zbk0ybEZxVDM1V3V3YXdmbGVzc0krTUEzOU9j?=
 =?utf-8?B?UmVoY2xUZHM0V3UxRzd2STFtQVpoeGdwSjhFTFg4K012L0VESUZ2Y090UXpo?=
 =?utf-8?B?N0VSQS8xRGZyVlQxTWl5dHUySDJ0YmRvQmhvalFtVkM2eVBibDlKdUdWSEFp?=
 =?utf-8?B?UExDRndqaU1HODhROVFuOW56RDdlUGVwVk9tbHlLSnZrVCtMZDRDOXJDRitB?=
 =?utf-8?B?RlFEM1kxU2hiUnlkdnVqZTNsV1NOZUZTaE1MN1FGUy96MnNrSFU1TDJqUUtj?=
 =?utf-8?B?QVErNjNtZStQUVJ6cUxQNUhhZjZwSzRwYVc5K3hOQzNaTE1NRmxjL2RYTVpU?=
 =?utf-8?B?NHQ3L1JPOTNRelJ4eWgxKzV4bjcwT2dQV1N1SEZTS1EycDVrN2hWWGpUbVkv?=
 =?utf-8?B?OGVvNndzOFdiNENMSmwxWTdyVlFwa2N6ZEIrWnBzSU5RbkhqQnJ5NVRTdUdG?=
 =?utf-8?B?dEk4cEIxNUYrZkk1VzBDbkRLSGxSQ05SbG1TSHcxaWNWbHhvTzJUYzV3cEdT?=
 =?utf-8?B?M3FiK0JnaTQyV2lyTUZZZjdkWTI3aFBDZlVkTWRaSUdHWGxYSkQvNjdLaU5R?=
 =?utf-8?B?ZFdoeGxEVFRZTCtBTlcyZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YkloaU0zcHdSc0E1MWhHaERzZCtKcHB0VFdQN0tLVCtmVUlFL2o1aTdTTitk?=
 =?utf-8?B?QXMvQndrSXV4UXUzcGRRM3QyRStPY1ZWNkltWFFtWTBqb1U4TDVLT0FKcy9y?=
 =?utf-8?B?MUhCOG01MHI4U0RnL2tvalhXM0wvOFRUZzgxOWErQ3FVMitlQTljRGZieDMz?=
 =?utf-8?B?WkZrVTQ1M3JRMHhwMEFRSitkTEcxQW9zeG8xZDFrSWsyMVJSOG9pbDFDMmtB?=
 =?utf-8?B?WW5DTGx1SHpwSGlZTFcxNTZwVmlqMXV0V2hPS1djU2pjYkRVc3NzcVE0S24r?=
 =?utf-8?B?bXNnYXBTMDRLdUhhT2tiSlpyZjNvb0JsQVl3b2xUVFVRMkp6THFVc0ZOcTRj?=
 =?utf-8?B?YlpIWnBLOTlWTVl5MnRRZENFZlZKNGVQc2w1d29jZldCb01qakNOSlgzZTNK?=
 =?utf-8?B?dzY5UVZPMy92VitNWkQxMHBhQUZhbG9HN0h3c3NLRWtBZDVZQ2ltOVBCTGZC?=
 =?utf-8?B?U1V0WXB1dmFlczhRVHJMVnZSajN1TEs4YXdoTDJSZ2ZmNERydnNicWRJcGFk?=
 =?utf-8?B?dDlQK0xack1MUDYxVXZ1Q2dUd2M4MXRMN2piRDFWVHcvMlhwbStWSDFiT1dU?=
 =?utf-8?B?bVFUbTVqcXBBUDhDYndudTFCUDRoOC9vNHp1R25UUmQ2bk0vTFYrSmxPRnl6?=
 =?utf-8?B?RUVUSkRvVFRvKzNpTm0rV0ltWjN1cVFQbmV4UDdKeWpwVWdiMjV5QTZQTk1P?=
 =?utf-8?B?a0lFZlpzRU14K3dKdUJFZXlYcmphM3JISnREL3ptRm1Xb0psSkJFVnJsRy9t?=
 =?utf-8?B?QjdMaG1UNFgzcE9PRC9NZG55dzRZb0ladzg4ZHpDcHRhY1JvdXpQR3FrWVJO?=
 =?utf-8?B?QXF3UFJPVS9SOUxRK3JsMytrZjZtajZoTjBIcDZ0WXM5U2k1OXVSKzVoY0pJ?=
 =?utf-8?B?SXRMTVlDMmZ0MjZwMWtPMjhrajJ1OFM0RXhQaktwb3dxV25oeVNNNjlaeTht?=
 =?utf-8?B?K1ZjeS9GRGdnMGxHNHltNXBwd2t5T0pGR1ZBajk5RjhpNytzd3gyUHBwQ0JU?=
 =?utf-8?B?OUh5M3BKUUs5VS83RmlFZzRyVnNYYnk2OTN1WloxaDlkMVpWdFlvZGZZaFZu?=
 =?utf-8?B?VEdyb0ZCL1ZwVTVESDJOdSt2QVU2NGtXUnJJMmE5QWs4bzk4c0NubGFJTit1?=
 =?utf-8?B?aEJtUTBkMVZmaXZpOHdvMU9DWFdmNDJmcll3S0dLSVhaa0piWktmbFNrQVR6?=
 =?utf-8?B?Y25yTGJsWW45ajVlYmswOTN3am1WdWNiZHFmV2ptSlV4RjJyQmJKZy9qSXlK?=
 =?utf-8?B?QVc4ZVJsRW1rY3o3NHBXZkgyWWhHSk8reGxORlVkTDF1TWdEYWdhenJveU40?=
 =?utf-8?B?VkZzZDZmU2J4SzZtT2JoRlRtQ0NvZ0Z3Q3VlbFV0UzB0ZkdEdVB6VFh2aWwx?=
 =?utf-8?B?ZGlOSUc0dUhWRGZCK0VsVS8zVGJiMCtPVTRPY3l2VUFRVFJIUEFMRE41clJI?=
 =?utf-8?B?WXlnUWQ5eit2N1JXdXFmV2hoSFVTcVN4OS9FVkNEb0NpTVZ3eU9kSHJMQlRW?=
 =?utf-8?B?QnR1ZGlXNzdWWjlCWHFHVzFFT1oxTVRjcXd6TXdQeFpueXhVZWx3M0pzaFlp?=
 =?utf-8?B?cncvY0g5cW0rZkx4OXlSM0lVK3hzRWRKYlVCMGZZSUJzUDEwSk5WOURKQjlY?=
 =?utf-8?B?SHEwYXB1cFZ3SUczMlJ5Y053WUN2QkhWTG55bG5PMmR3R3cvem95NE54MDZ1?=
 =?utf-8?B?VU80RC9hT2M4QjZlcm9Sdjd1TEdOanh0MTBJYUJBY2x4NERnd21sUUpVUi9M?=
 =?utf-8?B?OUtlL2MvUUFCWkhFQzN2eXYrOEFJNzYvQTd6ZXp2MzNYNlJ2REw2Zlh3L2or?=
 =?utf-8?B?bDBOcU9MVSs1SFVQdTVJQmRpUVNOQkZiMENDbzl3TjZOb3pheDV4VEtNS0FT?=
 =?utf-8?B?ZjVycEY1QkljazYxMDVGRElOcUxHcVRjbkgyV2MwTnI5c2RVNXNxODJpZDZm?=
 =?utf-8?B?OFpJNU1PSWM4K0VMTTRLc2NVRC9nMzhSM1FybkFwT1pRanhyS01wY3dzMUtL?=
 =?utf-8?B?b2RIUFJKdDE2R05WTTYxUWZYek43c0FDUTJxYWlFOU9WNndYK2dmbkU4bG5j?=
 =?utf-8?B?UkQvRHkvQk1Wa0Jpd2duTTNFU29aM3hMSU5rMFo1a0dQeFExbVJBU001QTB2?=
 =?utf-8?B?MFd1WHNid2xZa2FlZTJEWDhyb2xPMUtqRnNTTFVnc3ZsMVdlSm5pYWE2NGht?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28855ABAB8327D419B75B84EC46D3237@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dsccxtV42q+aJdgPaNgZFdzHWsXygfaGCpaphOCw9F11TCpP9224UBnJqzBqK48NNJQXsv3EXl6gPO7KigRVDIPVPIgc1wc26KlGqOAHR1wI/zexIiMuDhxsr7V2dftPq2BfWeGccry2HYvCrH2pOVFJAvrYOO4VhNdGhWvvfgYtc8J5Fos7EWPPWE9a1y8CCE2+q3etvp0tHTxgCbBNEkIbjKABgZBmOLjMNfwk4cDo+5s9RCPRxKmz8Hc6Jaxq8nmXBqY779r4EOtp8z7ei3VSy9pTT+ApseTZv+xrJ81AnQZpnAqxxPt3FBh7o1U4J5HQq0o1k9JS2T/5TGaUN50QDt1koR1rk1uJuwz5XqmvO3GDfjcDPLeHigqxgnNuSVITvGXzFPG5HZYOx6/QdDiEiDZsr+01TessPVkNFHqD+kd1htu6uUpo/lVTZaNC73pm2eUS/b+26cXx8whdQscrjaf4ohT1IwfMY2u5RJNnd8rAk2nF/u3mDZwAQEp1lZI6IYJDNUkefMm8uqgAHfnSgHhInu24eaYp2udMtVNQjdtYARwK/EelqXVDD7uUDJASpkKHz090kseb/cQU5IcJWKYqSSPMlx5XrqB/Ju0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f9a332-61d0-4cba-d42c-08dc7c0bdded
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 16:09:18.9513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HC1rzpr3FKxTW5zuZGn18tz+sSCD2PKcbyaxVZmXLxBfT2hLYoe6hUiJKZ781KcRwZl/PD68KZ7Pm3TkgsoLMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405240113
X-Proofpoint-ORIG-GUID: l-AZ47kaoswveXlvOXYdg-Fc7-DTYt-z
X-Proofpoint-GUID: l-AZ47kaoswveXlvOXYdg-Fc7-DTYt-z

DQoNCj4gT24gTWF5IDI0LCAyMDI0LCBhdCA3OjE24oCvQU0sIExpbnV4IHJlZ3Jlc3Npb24gdHJh
Y2tpbmcgKFRob3JzdGVuIExlZW1odWlzKSA8cmVncmVzc2lvbnNAbGVlbWh1aXMuaW5mbz4gd3Jv
dGU6DQo+IA0KPiBPbiAyMS4wNS4yNCAxMjowMSwgSmVmZiBMYXl0b24gd3JvdGU6DQo+PiBPbiBU
dWUsIDIwMjQtMDUtMjEgYXQgMTE6NTUgKzAyMDAsIFBhdWwgTWVuemVsIHdyb3RlOg0KPj4+IEFt
IDE5LjA0LjI0IHVtIDE4OjUwIHNjaHJpZWIgUGF1bCBNZW56ZWw6DQo+Pj4gDQo+Pj4+IFNpbmNl
IGF0IGxlYXN0IExpbnV4IDYuOC1yYzYsIExpbnV4IGxvZ3MgdGhlIHdhcm5pbmcgYmVsb3c6DQo+
Pj4+IA0KPj4+PiAgICAgTkZTRDogVW5hYmxlIHRvIGluaXRpYWxpemUgY2xpZW50IHJlY292ZXJ5
IHRyYWNraW5nISAoLTExMCkNCj4+Pj4gDQo+Pj4+IEkgaGF2ZW7igJl0IGhhZCB0aW1lIHRvIGJp
c2VjdCB5ZXQsIHNvIGlmIHlvdSBoYXZlIGFuIGlkZWEsIHRoYXTigJlkIGJlIGdyZWF0Lg0KPj4+
IA0KPj4+IDc0ZmQ0ODczOWQwNDg4ZTM5YWUxOGIwMTY4NzIwZjQ0OWEwNjY5MGMgaXMgdGhlIGZp
cnN0IGJhZCBjb21taXQNCj4+PiBjb21taXQgNzRmZDQ4NzM5ZDA0ODhlMzlhZTE4YjAxNjg3MjBm
NDQ5YTA2NjkwYw0KPj4+IEF1dGhvcjogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4N
Cj4+PiBEYXRlOiAgIEZyaSBPY3QgMTMgMDk6MDM6NTMgMjAyMyAtMDQwMA0KPj4+IA0KPj4+ICAg
ICBuZnNkOiBuZXcgS2NvbmZpZyBvcHRpb24gZm9yIGxlZ2FjeSBjbGllbnQgdHJhY2tpbmcNCj4+
PiANCj4+PiAgICAgV2UndmUgaGFkIGEgbnVtYmVyIG9mIGF0dGVtcHRzIGF0IGRpZmZlcmVudCBO
RlN2NCBjbGllbnQgdHJhY2tpbmcNCj4+PiAgICAgbWV0aG9kcyBvdmVyIHRoZSB5ZWFycywgYnV0
IG5vdyBuZnNkY2xkIGhhcyBlbWVyZ2VkIGFzIHRoZSBjbGVhciB3aW5uZXINCj4+PiAgICAgc2lu
Y2UgdGhlIG90aGVycyAocmVjb3ZlcnlkaXIgYW5kIHRoZSB1c2VybW9kZWhlbHBlciB1cGNhbGwp
IGFyZQ0KPj4+ICAgICBwcm9ibGVtYXRpYy4NCj4+IFsuLi5dDQo+PiBJdCBzb3VuZHMgbGlrZSB5
b3UgbmVlZCB0byBlbmFibGUgbmZzZGNsZCBpbiB5b3VyIGVudmlyb25tZW50LiBUaGUgb2xkDQo+
PiByZWNvdmVyeSB0cmFja2luZyBtZXRob2RzIGFyZSBkZXByZWNhdGVkLiBUaGUgb25seSBzdXJ2
aXZpbmcgb25lDQo+PiByZXF1aXJlcyB0aGUgbmZzZGNsZCBkYWVtb24gdG8gYmUgcnVubmluZyB3
aGVuIHJlY292ZXJ5IHRyYWNraW5nIGlzDQo+PiBzdGFydGVkLiBBbHRlcm5hdGVseSwgeW91IGNh
biBlbmFibGUgdGhpcyBvcHRpb24gaW4geW91ciBrZXJuZWxzIGlmIHlvdQ0KPj4gd2FudCB0byBr
ZWVwIHVzaW5nIHRoZSBkZXByZWNhdGVkIG1ldGhvZHMgaW4gdGhlIGludGVyaW0uDQo+IA0KPiBI
bW0uIFRoZW4gd2h5IGRpZG4ndCB0aGlzIG5ldyBjb25maWcgb3B0aW9uIGRlZmF1bHQgdG8gIlki
IGZvciBhIHdoaWxlDQo+IChzYXkgYSB5ZWFyIG9yIHR3bykgYmVmb3JlIGNoYW5naW5nIHRoZSBk
ZWZhdWx0IHRvIG9mZj8gVGhhdCB3b3VsZCBoYXZlDQo+IHByZXZlbnRlZCBwZW9wbGUgbGlrZSBQ
YXVsIGZyb20gcnVubmluZyBpbnRvIHRoZSBwcm9ibGVtIHdoZW4gcnVubmluZw0KPiAib2xkZGVm
Y29uZmlnIi4gSSB0aGluayB0aGF0IGlzIHdoYXQgTGludXMgd291bGQgaGF2ZSB3YW50ZWQgaW4g
YSBjYXNlDQo+IGxpa2UgdGhpcywgYnV0IG1pZ2h0IGJlIHRvdGFsbHkgd3JvbmcgdGhlcmUgKEkg
Q0NlZCBoaW0sIGluIGNhc2UgaGUNCj4gd2FudHMgdG8gc2hhcmUgaGlzIG9waW5pb24sIGJ1dCBt
YXliZSBoZSBkb2VzIG5vdCBjYXJlIG11Y2gpLg0KDQpUaGF0J3MgZmFpci4gSSByZWNhbGwgd2Ug
YmVsaWV2ZWQgYXQgdGhlIHRpbWUgdGhhdCB2ZXJ5IGZldyBwZW9wbGUNCmlmIGFueW9uZSBjdXJy
ZW50bHkgdXNlIGEgbGVnYWN5IHJlY292ZXJ5IHRyYWNraW5nIG1lY2hhbmlzbSwgYW5kDQp0aGUg
d29ya2Fyb3VuZCwgaWYgdGhleSBkbywgaXMgZWFzeS4NCg0KDQo+IEJ1dCBJIGd1ZXNzIHRoYXQn
cyB0b28gbGF0ZSBub3csIHVubGVzcyB3ZSB3YW50IHRvIG1lZGRsZSB3aXRoIGNvbmZpZw0KPiBv
cHRpb24gbmFtZXMuIEJ1dCBJIGd1ZXNzIHRoYXQgbWlnaHQgbm90IGJlIHdvcnRoIGl0IGFmdGVy
IGhhbGYgYSB5ZWFyDQo+IGZvciBzb21ldGhpbmcgdGhhdCBvbmx5IGNhdXNlcyBhIHdhcm5pbmcg
KGFpdWkpLg0KDQpJbiBQYXVsJ3MgY2FzZSwgdGhlIGRlZmF1bHQgYmVoYXZpb3IgbWlnaHQgcHJl
dmVudCBwcm9wZXIgTkZTdjQNCnN0YXRlIHJlY292ZXJ5LCB3aGljaCBpcyBhIGxpdHRsZSBtb3Jl
IGhhemFyZG91cyB0aGFuIGEgbWVyZQ0Kd2FybmluZywgSUlVQy4NCg0KVG8gbXkgc3VycHJpc2Us
IGl0IG9mdGVuIHRha2VzIHF1aXRlIHNvbWUgdGltZSBmb3IgY2hhbmdlcyBsaWtlDQp0aGlzIHRv
IG1hdHJpY3VsYXRlIGludG8gbWFpbnN0cmVhbSB1c2FnZSwgc28gaGFsZiBhIHllYXIgaXNuJ3QN
CnRoYXQgbG9uZy4gV2UgbWlnaHQgd2FudCB0byBjaGFuZ2UgdG8gYSBtb3JlIHRyYWRpdGlvbmFs
DQpkZXByZWNhdGlvbiBwYXRoIChkZWZhdWx0IFkgd2l0aCB3YXJuaW5nLCB3YWl0LCBkZWZhdWx0
IE4sIHdhaXQsDQpyZWRhY3QgdGhlIG9sZCBjb2RlKS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0K
DQo=

