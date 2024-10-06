Return-Path: <linux-nfs+bounces-6902-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EB3992232
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 00:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE06B20D70
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 22:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC4818A957;
	Sun,  6 Oct 2024 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YxX+GJpp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E2BT365V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA68018BBB2;
	Sun,  6 Oct 2024 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728255539; cv=fail; b=R7lcycK/ORDCipTz2DRath0wYvdA6Jf/9Vcu9dyISE/SEkODDNwNk85Eclr9vyCWpxNL7Ir68+jFwpjADkluRsbLfSdn5PRjiO2Cbf2cy+Wuw6Iwu1kUvzcADW2BTACqRWdEAYVc1g76znRVX19VzodBJZsd0y1ykq2VDdjJXnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728255539; c=relaxed/simple;
	bh=rRFLGKfjrLXlBC1m0dQRQ9qFZysHk7XRLwmXAK5+ckU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g5bHMtWnJLSy2QhuT7JBHxsq3GaEJ+lpXdGTFg/X/kerlBb2ExpacaFvuQLercjlTOdOi5Qi33IbNRAX12ZWS6ornYT6SYSc+zRYZEePzuDz/6/SSexn0FW20hbFopsQF7aTXRbQLwBjrkXCJtp9ennFPxKtf4Dk7clCiH2umUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YxX+GJpp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E2BT365V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 496Lj22v008419;
	Sun, 6 Oct 2024 22:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rRFLGKfjrLXlBC1m0dQRQ9qFZysHk7XRLwmXAK5+ckU=; b=
	YxX+GJppCm4yiqGbTw95M2fkBzQ3bdkZCQoj1PXlwYmB8rIpKbSSIhRYePOsQZYi
	nFVU6WVhxS6Lde9YQPnqDLDjvBndSUiXrUrWnmvtjA1vOs+87c8lvPQHsattATSB
	Ekmuwz0AwnE9nP0Ixs8UY0+bpUixcY2dvIlOHbhZGlTI6DtECryYlUHWRdkRu2eo
	LeJ1cWZ8aZR9AIzfbPW9PYdCIUd9I6C4KTBwJZc2nnGDsLqplUraSSFKX5zsXD/b
	5r9aVARoMsMlbUCFyrLvBh/KCFd1Kxu34e7UQjWqJlIlLnYIb4ozePfh4J5lor6S
	9DEhGD4qJdF2wpdHX71cXg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302p9gxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Oct 2024 22:58:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 496K95xu012056;
	Sun, 6 Oct 2024 22:58:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw541md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Oct 2024 22:58:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhXm6TIPe2f9qFVZC472U6GvsrBwHYDRxnT1wMRx/RxbncEtUrX39gcvqfyGEWNH6QvNtAh6h2aX25Ig4nB+p9WmcFAX4sOXiJu2GaSyKOZmvrD7E9HdJNyOiL8YvK0CaCC4yWThAOeKOkvVlYKEQrku5oqSpU9l5tBID+9BMpyFWc9FNBJM4wNy9bPesfK4CUBmbnt18vTdNfwVy0fMBekon+elSg6Kwct26zrjcW1b/hvtcyHtKLv3lrx6ZyB7W1mLT/L+TKAvAW80tdFzyNVDxRtCWcjxv8wK2gbmRQxXZzs1avRAFENym7l90mTXSGT77AIbGfJJdRmxS/Bncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRFLGKfjrLXlBC1m0dQRQ9qFZysHk7XRLwmXAK5+ckU=;
 b=tZTGGy9ZOdejmS+6u6DYk9FrC9jPZ/sxREQ+g8tDvWPs5+I9Khuh13AXK4ISbae1hpWfY1tW6bA0OqcxYoROrrzxFAxdCJVNKK/VXip0mLGAaDRTwt7ttV+yRm6sMZdKi3aiHbOcF51Cn9eTd3h284SMJ13djQpbVFcXgzR57kGtoECCkTjEMDM2VS7o8ntZREXGX3/goD7iop/FI2NwTwx/T2UgcMlMx4hI9qt8yZzxjZXOR6kclAas9nXlpfeb3xks1qyAuSjb8RKVnTp0Bl7Y1SAQIulnIeHmHkxfs25NJ2DwLyt5XjXkky8BdtDq6BMYnI/jX9/ecFdQzO7Xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRFLGKfjrLXlBC1m0dQRQ9qFZysHk7XRLwmXAK5+ckU=;
 b=E2BT365V13XyIq7mcxr+okMDaVnOdA+aWW5Sg18dviUigFTXkJRRhlBTvSFOtOj4fy365B29bdbCMyMlCua8Vfrfkxw0k+NZDv9cWXbAJ0vkYVC4y3RKIIascu+eGF1ZBQHmezeJlIkFof5ky2mofxV/EAYDriFSx8bIcZCj+E8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6602.namprd10.prod.outlook.com (2603:10b6:510:206::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 22:58:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.020; Sun, 6 Oct 2024
 22:58:36 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and
 NFSD_MAY_BYPASS_GSS_ON_ROOT
Thread-Topic: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and
 NFSD_MAY_BYPASS_GSS_ON_ROOT
Thread-Index: AQHbBWH4I3P32Fqeh0Sy+qADx3c2LLJUwhQAgCVjo4CAAElogIAABHoAgAAIIwA=
Date: Sun, 6 Oct 2024 22:58:36 +0000
Message-ID: <EEC2DC14-EBE9-4F41-9BBE-47F9DDD110C7@oracle.com>
References: <ZwLN6RtYwVIkUfaL@tissot.1015granger.net>
 <172825279728.1692160.16291277027217742776@noble.neil.brown.name>
 <20241006222918.jnf4odeoyq6u7l5m@pali>
In-Reply-To: <20241006222918.jnf4odeoyq6u7l5m@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6602:EE_
x-ms-office365-filtering-correlation-id: e1961d4a-86f3-4634-bfdd-08dce65a691c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bEFYc2N1ODFzbXV5R21SbUdHVjNYbllLUjAzM3NHb3NZdS9TZEt3Z3NibFIw?=
 =?utf-8?B?WmlSUWwzY2JRNGVWK2lNekkrbEFNMGkzdkVwanQ0U0NmeFFQMWFMOWNHY3Jw?=
 =?utf-8?B?N0JwQk5Ld2xmNXBFSjExZW5HS0xLSmNWeXdoZUM4UVA2UHE3UnlwQjNPNHVm?=
 =?utf-8?B?M0hYYnN5TGJROTNoTzJaMkc0QXd5QnBwT0FLL1hLeVpkQ2Fpa2d0cEFMTU5q?=
 =?utf-8?B?T01QQ1l0YTcwY3dZNXdzVlFuNHQ2UU1OTERGRDFWMnQzaHNlODFUcVZkR0ll?=
 =?utf-8?B?eEYvcWVvNWFIWUFadEVIUjdvWkd2K0dTR1N5Q29mKzE1Qjl6cFNGWWQ3U2NS?=
 =?utf-8?B?blBtVFJQU2Vucm40ZFhyck1CNDZyUVc0ZVpTM3VNWWRZdGtKYmwvNTR0NFpl?=
 =?utf-8?B?NEtGcC81Q1Q1WFZDMUZIckw5MXRPM3J3SzZJUmxwWmRuTEhrdVdCd1JMTnhU?=
 =?utf-8?B?c045ZUd1cHJlMHR6TkRIR01YcE50RXBZaDNkdFA1MitncURWVFg1cXlHYzRM?=
 =?utf-8?B?MnBoT2pUL0dEd3FYZEF0RDV0ZFFVQTFzb0FCUHlPNVBtWkZYdjNiYzFUTStY?=
 =?utf-8?B?WkRXcWFtR2JnbEdXdzRUcHlsVzliZnpLQ0ZxbS9na1p2dlFBa0x0RmEvMlpv?=
 =?utf-8?B?clk1dlFCVCswSVJJeHBBUTV2UnlOeFE2TUt4dHhxMElQSUh3Nm1tN2kzcnJj?=
 =?utf-8?B?QXMwbkZXWGpjcTBYL2VOWDNmMjJFWjZXVUVxQzJsK1BxOWJDZ2dORENBWWNM?=
 =?utf-8?B?UjJobTIxTlBCK2hBY3Avd3RZdk41VTc1ZHU4eHRQM0NXODVoOEFLcVVMZ3RM?=
 =?utf-8?B?ZmljN1NFUjM4SE1sanNWK2xTekJvalVDU2I0Vng5b05rVU1rbVVjb29NTmxV?=
 =?utf-8?B?S0ZraVFyRm5GV1c2bHdVNjNkU0t3b2owdFIvUFdQUXlXekRLUUtSbE4veGFC?=
 =?utf-8?B?WGVEdlJpMms3QUFxa2RkVnlvUlM2NlNYeE9vN0dmUlh1azJWNjdMWDl3UEdY?=
 =?utf-8?B?bFh3K0FLbmUwbHRjMFhETXRsN3RBSmVveVpmMTFLZFd0Sk0rNnl5VTZtdldS?=
 =?utf-8?B?ZEIwSU9aU0ZZaU14MmZmaU14VFUxcFVOWTMrNEJTL1VSS20vRjBSL3dHNFIv?=
 =?utf-8?B?c3JEeXJGdWtoRXRVWitPTE1pQTcwR3pVZmhDbzdEUDlvRWFDemltMU8zSWhC?=
 =?utf-8?B?TXRlNnVyTWNJZDFCMFZxcUNSblNucHVQQkhwZ0dWV1lZOG11cnBsWE9PdUUx?=
 =?utf-8?B?Y0xzbVE5RkRNK1haU2tzalhWY2o5eHRCZWdaaHBBQ2x0aDdNZGNIdUYzb1NZ?=
 =?utf-8?B?U1ZLeFRKcGpUaG02U2c4ZlAwREpEd2ovczFDdG1NbnZEMytSYml1ZWF2STA2?=
 =?utf-8?B?SlBuMlFCKy9kd3RZVGJyTVpReGx6T0I2cXo5SnNpc2dTUG9rNVBqVVpjdEpU?=
 =?utf-8?B?RVArUGhPZWprT3crTzhyZnB4c0VCZXMvTENSc0tTZStkR1NpNEFlUkx4VC82?=
 =?utf-8?B?NWk3YzgwQmVGOUVhNWU1TGQ5TlF1TkFsTE5XMXdmbmtOUm1wbG4vdTdIbUN4?=
 =?utf-8?B?SmpFWmtnY0ZjMmpqNXJGTWhlQlMzRkJPY2JIZEdaYVEydGlkZmtlRTNqeU80?=
 =?utf-8?B?eVU2OGtCaVpKdWl0Z1FZKzd3UjNneHR4eloyUmNqT0ExYTR3UklxMlgwMzZu?=
 =?utf-8?B?bm5XRjFySWY3ZmMvcTYyTEZjMno3WUl2UERsaU5rbWM3dkJMeE9NOHRBNkY5?=
 =?utf-8?B?S3F4d2tXVXNMY0tYNUtIN1R0ZkJ5TUw5T3Rub2RSUTJGd2h4K2tYdndiUG14?=
 =?utf-8?B?Si9taWVsdm5kOUQ1TS9oQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VC9HbEV4cVhIOVl5Y1JsbnlaQmhabXBoQlNFK3pDbEdTNDg0d1lkMlltT2Z5?=
 =?utf-8?B?U1c2ajhqYmJTRTZTSWtrSTlteWN4WjhZY1d0dlU5aEM0dG0zdVE3eXFzRksw?=
 =?utf-8?B?a1h4dTRvU3B0RUs1aXBzbWRHMTcxM3RJaEdyS3FvK0VvR2FPSklwZDQrUzJn?=
 =?utf-8?B?eURaa3RDSFMzQUl6NThPclBpaHpDcy9pZVNuQ2JVdEdFM2ZuTEsxYWlpSXNU?=
 =?utf-8?B?UmNsU21idmZ0VmE0c2orVkVyLytjTGlFVlVpRzZ5QlZCcGQwSzZlSDNvQUZj?=
 =?utf-8?B?S0JGSkJCbkwybzhXaVA3a0VTNjVPUHVpbStVZyttYmg5K0xRS1BtN2R4WlB1?=
 =?utf-8?B?bXBmdUxnQjNtcXI3bmtldkxESm1CRDZHUUZQMFhjU3lwUXJXMXRiQnU5NzFT?=
 =?utf-8?B?SVk1bFhNYmdIenBGTTVwU0dvZi8yNUtVcHNUNXJVbTBvd05IWE5GbkpCbVJY?=
 =?utf-8?B?TFBDQW5VR3dQVUxDZFBMSXVFYk5NZC80U1RrcXB3K3JUQ3NDSlp1RTNYV2Y5?=
 =?utf-8?B?dk1ROUEvd3Jra2Vpb0tNaS9sZDl0Q3lrOTk5TytETUNGd1g5UCtCaTkzdGZr?=
 =?utf-8?B?V1ZQdGVVT2pLTWV4UkFGL1E1WjlRaUQyTGZMaDlTb096M3NQTmRhSFM0WEMw?=
 =?utf-8?B?RlhsWGFNZ04xZ0pRQW1yakwrUHRVZElCNitYWlRsWDE3RUl1dFdhK2YyS2lT?=
 =?utf-8?B?V2dSTGo5dkVSY1JtWGxkSnJoaHFlTkRLRXV5d0hVcFVTWWx0azE3UlB4c0hz?=
 =?utf-8?B?Ym43Qi9BS3ZnZG1BZHhWNFJqNkVYNEZLL2NIZ3BlV0tGMVFKVERsT2VpNTdy?=
 =?utf-8?B?bTZBL05UQ0pxUTYyaUpwak9jQlBBaVp6aUo5Q1Q1SjdBUTEva2h1cmFCUEdw?=
 =?utf-8?B?TlVYeHBUOXJ2TUpjN2NqbE8yRlVMUFEyWE5XWTFxaWNTU3JOU2dwL3RueUw2?=
 =?utf-8?B?WXFnSllBOGhrRVdINmFpK3RoQUdnUGVTT1NQTnVpcHJqZkVybFZ6bCs0MVBZ?=
 =?utf-8?B?VHFDZ1Zsd0l1V2NsVTIza2VkY0Fqa3RUSnc3V0R1dUlnS0pGQ3p2RlYxNklQ?=
 =?utf-8?B?c2VTUmRCYTN1VzJNejhoNVdjRFFndlpTSWtpMGRtZUI5RUJsTVY1ZmlWN2RH?=
 =?utf-8?B?aHJ1eThFck9iWC9HU1BmV1pMckJJbk5rbExyOWVRUzMwVnN2ek43UElvazlu?=
 =?utf-8?B?ZFUzM28vbjBBMk9yclNabjRzTFI0eDlrdE9SbGhNd1FBMjdOVFFzMlo4ck1Y?=
 =?utf-8?B?V2dDSENiM0p6cXFiOUFzV2FQZ1RFWStoU0tLRnBoTmlWUXlZeXlRa0F0NEdJ?=
 =?utf-8?B?RkNZNlJWR3FZMXVOTjFLVjA1VDYyV0NiajhqTC94eGlzZVVwcHh1TjFhQVg3?=
 =?utf-8?B?M3g5YXJGOGwzUkwxdE9McHVrd2lvckhWN0ZtaXk5MTZVc2hjTzNhMlZ3a0R1?=
 =?utf-8?B?b1IzNUR2dWtnVGp0czVUZnNxWDRnalFoM3VEQk5XajQySVBNeUZIT1p4Q2h1?=
 =?utf-8?B?RXgvbjQyZ0pxWmdNSVl4T3ZxT1E2SUxMc014V25GYWlOTjZLRlJpaCtUbi8y?=
 =?utf-8?B?Z2NZZElFSVd0a2Y3MHpMUVo1aUphTTdKZzZrK1Z2OHB2UFJWMzFyVThYNER5?=
 =?utf-8?B?T25XSWlsaHFuekRHcThkNmxvaWNsdk5rQXpYZHIra1RGOVNIa1hOL1RLb2Nh?=
 =?utf-8?B?Q0p0YUowN0NxLzNXTmtWbnc2N3pqeDZCNmRiaFYwNC9JWjRUYzRMejhtYWRT?=
 =?utf-8?B?UHYrUUhwbis5VSt3REFTRzlHdVkvRXFnOVJDb2htNHVRZGljenNOSHpUNFQr?=
 =?utf-8?B?SGt0OWxNQVFyTmNqME1ndzhNcEQwNWJrQTdaM0hsa0NRR0ltNHcxSFRNWkJF?=
 =?utf-8?B?RXYwTGt6NVZ5TTZPZ3g4cG9PWkRvK0V0T0x0azVpbnY3cEM4NnB5eFowRnJo?=
 =?utf-8?B?UDhPU3NTMUVmR0N0U3VjS1BRclM2R2daVVZwUHg5ZmcxZzRtTFZ1S3NkZkg2?=
 =?utf-8?B?NStmUG1saFV6YlhSMkJkNnYwTjMwNUUyMGxUNUVFYjExUGE3bzBmT0hmYklh?=
 =?utf-8?B?Q05BUzRhVEROa0VnWnEwZXJjTE4zZHJwODA0c1ZoZHdhMUpoU3NLWVNrUHZW?=
 =?utf-8?B?UGExdW03MWM4dWRvOE1ucG9zRXpWR3dlZnhPYlJGdi9LY2FKcXpoTEt5VDhZ?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B34448B854E7B344A392AAF86DE6491F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T+qk0erAlWu2ykBuWHm1OTf+EDM260UAPOf0/NAXXQKjNcSMUJ+rUkskq+Bwldk/Q04PHv36z9zhzmmu7L1NiD/4oAwfWh9O6X2dQ3vO/m0CBDP0EoSrXyM3OTirYZEpgq3vBjOfnThbEpsemPXJTiAUKHuUiZ89r5V8HkfnQTsGsdfw64WMSu4PgABDABEzYx6JHUoYw7BIP11hnrKmEipcq/LeOAhivkpX9FAylNzua+VMiu7trAd8Al6C6IIQDqcwjYwIIwV0BcAw0Jm/wSXETkKz+FRpx+YUwkoBP83FlUP9KK9F1k7c2pXuKG27XopgixaFGXkurJxptZbvkpOhhtNop2id0+w0mU5++Vq8RowOBVPDGmjPCKTPMEC/hv5hiKg+l7fX2q5D75UzuTSWLIorScbih0BSL5ffytVeVg0eBjZR9Uo2Z4LX8kqlJBm2Mw26vJ64h/FJ+1yWQvDbk8kK+yJMVysrXmVrjmwwGEEyVhCgirWqHUANjPhFGXoebMhmFnwwjYqYYsjilczRutD/3sWIubKF11+7lSPSZmK+JtaUfRcUFQaUp27XpYZKI27VzvY7BE3P9uaIXUtW7x1Oq0lU6fccDRygIGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1961d4a-86f3-4634-bfdd-08dce65a691c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2024 22:58:36.4461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYjU2exVSutfjNiwhO4iWSP8mc3wtQG3UMZYhbruvq0qhLE5ss0FrgDHY+JFiQHWSmTLTFVPzAM6upBO5E3zgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-06_21,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410060166
X-Proofpoint-ORIG-GUID: bq2Gq6znOiLHO_bwAOWXy1MMKaD5sNDn
X-Proofpoint-GUID: bq2Gq6znOiLHO_bwAOWXy1MMKaD5sNDn

DQoNCj4gT24gT2N0IDYsIDIwMjQsIGF0IDY6MjnigK9QTSwgUGFsaSBSb2jDoXIgPHBhbGlAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb25kYXkgMDcgT2N0b2JlciAyMDI0IDA5OjEzOjE3
IE5laWxCcm93biB3cm90ZToNCj4+IE9uIE1vbiwgMDcgT2N0IDIwMjQsIENodWNrIExldmVyIHdy
b3RlOg0KPj4+IE9uIEZyaSwgU2VwIDEzLCAyMDI0IGF0IDA4OjUyOjIwQU0gKzEwMDAsIE5laWxC
cm93biB3cm90ZToNCj4+Pj4gT24gRnJpLCAxMyBTZXAgMjAyNCwgUGFsaSBSb2jDoXIgd3JvdGU6
DQo+Pj4+PiBDdXJyZW50bHkgTkZTRF9NQVlfQllQQVNTX0dTUyBhbmQgTkZTRF9NQVlfQllQQVNT
X0dTU19PTl9ST09UIGRvIG5vdCBieXBhc3MNCj4+Pj4+IG9ubHkgR1NTLCBidXQgYnlwYXNzIGFu
eSBhdXRoZW50aWNhdGlvbiBtZXRob2QuIFRoaXMgaXMgcHJvYmxlbSBzcGVjaWFsbHkNCj4+Pj4+
IGZvciBORlMzIEFVVEhfTlVMTC1vbmx5IGV4cG9ydHMuDQo+Pj4+PiANCj4+Pj4+IFRoZSBwdXJw
b3NlIG9mIE5GU0RfTUFZX0JZUEFTU19HU1NfT05fUk9PVCBpcyBkZXNjcmliZWQgaW4gUkZDIDI2
MjMsDQo+Pj4+PiBzZWN0aW9uIDIuMy4yLCB0byBhbGxvdyBtb3VudGluZyBORlMyLzMgR1NTLW9u
bHkgZXhwb3J0IHdpdGhvdXQNCj4+Pj4+IGF1dGhlbnRpY2F0aW9uLiBTbyBmZXcgcHJvY2VkdXJl
cyB3aGljaCBkbyBub3QgZXhwb3NlIHNlY3VyaXR5IHJpc2sgdXNlZA0KPj4+Pj4gZHVyaW5nIG1v
dW50IHRpbWUgY2FuIGJlIGNhbGxlZCBhbHNvIHdpdGggQVVUSF9OT05FIG9yIEFVVEhfU1lTLCB0
byBhbGxvdw0KPj4+Pj4gY2xpZW50IG1vdW50IG9wZXJhdGlvbiB0byBmaW5pc2ggc3VjY2Vzc2Z1
bGx5Lg0KPj4+Pj4gDQo+Pj4+PiBUaGUgcHJvYmxlbSB3aXRoIGN1cnJlbnQgaW1wbGVtZW50YXRp
b24gaXMgdGhhdCBmb3IgQVVUSF9OVUxMLW9ubHkgZXhwb3J0cywNCj4+Pj4+IHRoZSBORlNEX01B
WV9CWVBBU1NfR1NTX09OX1JPT1QgaXMgYWN0aXZlIGFsc28gZm9yIE5GUzMgQVVUSF9VTklYIG1v
dW50DQo+Pj4+PiBhdHRlbXB0cyB3aGljaCBjb25mdXNlIE5GUzMgY2xpZW50cywgYW5kIG1ha2Ug
dGhlbSB0aGluayB0aGF0IEFVVEhfVU5JWCBpcw0KPj4+Pj4gZW5hYmxlZCBhbmQgaXMgd29ya2lu
Zy4gTGludXggTkZTMyBjbGllbnQgbmV2ZXIgc3dpdGNoZXMgZnJvbSBBVVRIX1VOSVggdG8NCj4+
Pj4+IEFVVEhfTk9ORSBvbiBhY3RpdmUgbW91bnQsIHdoaWNoIG1ha2VzIHRoZSBtb3VudCBpbmFj
Y2Vzc2libGUuDQo+Pj4+PiANCj4+Pj4+IEZpeCB0aGUgTkZTRF9NQVlfQllQQVNTX0dTUyBhbmQg
TkZTRF9NQVlfQllQQVNTX0dTU19PTl9ST09UIGltcGxlbWVudGF0aW9uDQo+Pj4+PiBhbmQgcmVh
bGx5IGFsbG93IHRvIGJ5cGFzcyBvbmx5IGV4cG9ydHMgd2hpY2ggaGF2ZSBzb21lIEdTUyBhdXRo
IGZsYXZvcg0KPj4+Pj4gZW5hYmxlZC4NCj4+Pj4+IA0KPj4+Pj4gVGhlIHJlc3VsdCB3b3VsZCBi
ZTogRm9yIEFVVEhfTlVMTC1vbmx5IGV4cG9ydCBpZiBjbGllbnQgYXR0ZW1wdHMgdG8gZG8NCj4+
Pj4+IG1vdW50IHdpdGggQVVUSF9VTklYIGZsYXZvciB0aGVuIGl0IHdpbGwgcmVjZWl2ZSBhY2Nl
c3MgZXJyb3JzLCB3aGljaA0KPj4+Pj4gaW5zdHJ1Y3QgY2xpZW50IHRoYXQgQVVUSF9VTklYIGZs
YXZvciBpcyBub3QgdXNhYmxlIGFuZCB3aWxsIGVpdGhlciB0cnkNCj4+Pj4+IG90aGVyIGF1dGgg
Zmxhdm9yIChBVVRIX05VTEwgaWYgZW5hYmxlZCkgb3IgZmFpbHMgbW91bnQgcHJvY2VkdXJlLg0K
Pj4+Pj4gDQo+Pj4+PiBUaGlzIHNob3VsZCBmaXggcHJvYmxlbXMgd2l0aCBBVVRIX05VTEwtb25s
eSBvciBBVVRIX1VOSVgtb25seSBleHBvcnRzIGlmDQo+Pj4+PiBjbGllbnQgYXR0ZW1wdHMgdG8g
bW91bnQgaXQgd2l0aCBvdGhlciBhdXRoIGZsYXZvciAoZS5nLiB3aXRoIEFVVEhfTlVMTCBmb3IN
Cj4+Pj4+IEFVVEhfVU5JWC1vbmx5IGV4cG9ydCwgb3Igd2l0aCBBVVRIX1VOSVggZm9yIEFVVEhf
TlVMTC1vbmx5IGV4cG9ydCkuDQo+Pj4+IA0KPj4+PiBUaGUgTUFZX0JZUEFTU19HU1MgZmxhZyBj
dXJyZW50bHkgYWxzbyBieXBhc3NlcyBUTFMgcmVzdHJpY3Rpb25zLiAgV2l0aA0KPj4+PiB5b3Vy
IGNoYW5nZSBpdCBkb2Vzbid0LiAgSSBkb24ndCB0aGluayB3ZSB3YW50IHRvIG1ha2UgdGhhdCBj
aGFuZ2UuDQo+Pj4gDQo+Pj4gTmVpbCwgSSdtIG5vdCBzZWVpbmcgdGhpcywgSSBtdXN0IGJlIG1p
c3Npbmcgc29tZXRoaW5nLg0KPj4+IA0KPj4+IFJQQ19BVVRIX1RMUyBpcyB1c2VkIG9ubHkgb24g
TlVMTCBwcm9jZWR1cmVzLg0KPj4+IA0KPj4+IFRoZSBleHBvcnQncyB4cHJ0c2VjPSBzZXR0aW5n
IGRldGVybWluZXMgd2hldGhlciBhIFRMUyBzZXNzaW9uIG11c3QNCj4+PiBiZSBwcmVzZW50IHRv
IGFjY2VzcyB0aGUgZmlsZXMgb24gdGhlIGV4cG9ydC4gSWYgdGhlIFRMUyBzZXNzaW9uDQo+Pj4g
bWVldHMgdGhlIHhwcnRzZWM9IHBvbGljeSwgdGhlbiB0aGUgbm9ybWFsIHVzZXIgYXV0aGVudGlj
YXRpb24NCj4+PiBzZXR0aW5ncyBhcHBseS4gSW4gb3RoZXIgd29yZHMsIEkgZG9uJ3QgdGhpbmsg
ZXhlY3V0aW9uIGdldHMgY2xvc2UNCj4+PiB0byBjaGVja19uZnNkX2FjY2VzcygpIHVubGVzcyB0
aGUgeHBydHNlYyBwb2xpY3kgc2V0dGluZyBpcyBtZXQuDQo+PiANCj4+IGNoZWNrX25mc2RfYWNj
ZXNzKCkgaXMgbGl0ZXJhbGx5IHRoZSBPTkxZIHBsYWNlIHRoYXQgLT5leF94cHJ0c2VjX21vZGVz
DQo+PiBpcyB0ZXN0ZWQgYW5kIHRoYXQgc2VlbXMgdG8gYmUgd2hlcmUgeHBydHNlYz0gZXhwb3J0
IHNldHRpbmdzIGFyZSBzdG9yZWQuDQo+PiANCj4+PiANCj4+PiBJJ20gbm90IGNvbnZpbmNlZCBj
aGVja19uZnNkX2FjY2VzcygpIG5lZWRzIHRvIGNhcmUgYWJvdXQNCj4+PiBSUENfQVVUSF9UTFMu
IENhbiB5b3UgZXhwYW5kIGEgbGl0dGxlIG9uIHlvdXIgY29uY2Vybj8NCj4+IA0KPj4gUHJvYmFi
bHkgaXQgZG9lc24ndCBjYXJlIGFib3V0IFJQQ19BVVRIX1RMUyB3aGljaCBhcyB5b3Ugc2F5IGlz
IG9ubHkNCj4+IHVzZWQgb24gTlVMTCBwcm9jZWR1cmVzIHdoZW4gc2V0dGluZyB1cCB0aGUgVExT
IGNvbm5lY3Rpb24uDQo+PiANCj4+IEJ1dCBpdCAqZG9lcyogY2FyZSBhYm91dCBORlNfWFBSVFNF
Q19NVExTIGV0Yy4NCj4+IA0KPj4gQnV0IEkgbm93IHNlZSB0aGF0IFJQQ19BVVRIX1RMUyBpcyBu
ZXZlciByZXBvcnRlZCBieSBPUF9TRUNJTkZPIGFzIGFuDQo+PiBhY2NlcHRhYmxlIGZsYXZvdXIs
IHNvIHRoZSBjbGllbnQgY2Fubm90IGR5bmFtaWNhbGx5IGRldGVybWluZSB0aGF0IFRMUw0KPj4g
aXMgcmVxdWlyZWQuDQo+IA0KPiBXaHkgaXMgbm90IFJQQ19BVVRIX1RMUyBhbm5vdW5jZWQgaW4g
TkZTNCBPUF9TRUNJTkZPPyBTaG91bGQgbm90IE5GUzQNCj4gT1BfU0VDSU5GTyByZXBvcnQgYWxs
IHBvc3NpYmxlIGF1dGggbWV0aG9kcyBmb3IgcGFydGljdWxhciBmaWxlaGFuZGxlPw0KDQpTRUNJ
TkZPIHJlcG9ydHMgdXNlciBhdXRoZW50aWNhdGlvbiBmbGF2b3JzIGFuZCBwc2V1ZG9mbGF2b3Jz
Lg0KDQpSUENfQVVUSF9UTFMgaXMgbm90IGEgdXNlciBhdXRoZW50aWNhdGlvbiBmbGF2b3IsIGl0
IGlzIG1lcmVseQ0KYSBxdWVyeSB0byBzZWUgaWYgdGhlIHNlcnZlciBwZWVyIHN1cHBvcnRzIFJQ
Qy13aXRoLVRMUy4NCg0KU28gZmFyIHRoZSBuZnN2NCBXRyBoYXMgbm90IGJlZW4gYWJsZSB0byBj
b21lIHRvIGNvbnNlbnN1cw0KYWJvdXQgaG93IGEgc2VydmVyJ3MgdHJhbnNwb3J0IGxheWVyIHNl
Y3VyaXR5IHBvbGljaWVzIHNob3VsZA0KYmUgcmVwb3J0ZWQgdG8gY2xpZW50cy4gVGhlcmUgZG9l
cyBub3Qgc2VlbSB0byBiZSBhIGNsZWFuIHdheQ0KdG8gZG8gdGhhdCB3aXRoIGV4aXN0aW5nIE5G
U3Y0IHByb3RvY29sIGVsZW1lbnRzLCBzbyBhDQpwcm90b2NvbCBleHRlbnNpb24gbWlnaHQgYmUg
bmVlZGVkLg0KDQoNCj4+IFNvIHRoZXJlIGlzIG5vIHZhbHVlIGluIGdpdmluZyBub24tdGxzIGNs
aWVudHMgYWNjZXNzIHRvDQo+PiB4cHJ0c2VjPW10bHMgZXhwb3J0cyBzbyB0aGV5IGNhbiBkaXNj
b3ZlciB0aGF0IGZvciB0aGVtc2VsdmVzLiAgVGhlDQo+PiBjbGllbnQgbmVlZHMgdG8gZXhwbGlj
aXRseSBtb3VudCB3aXRoIHRscywgb3IgcG9zc2libHkgdGhlIGNsaWVudCBjYW4NCj4+IG9wcG9y
dHVuaXN0aWNhbGx5IHRyeSBUTFMgaW4gZXZlcnkgY2FzZSwgYW5kIGNhbGwgYmFjay4NCj4+IA0K
Pj4gU28gdGhlIG9yaWdpbmFsIHBhdGNoIGlzIE9LLg0KPj4gDQo+PiBOZWlsQnJvd24NCg0KDQot
LQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

