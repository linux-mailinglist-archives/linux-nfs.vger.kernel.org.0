Return-Path: <linux-nfs+bounces-7328-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A8B9A6C0F
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 16:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF26DB20CE5
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 14:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627EC1EF942;
	Mon, 21 Oct 2024 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MxTdzfYe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WsoPI9yC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7E1E0B96
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520764; cv=fail; b=O5U0C7N3fs/20ID52KSjtpImd73Xm8X0+nXlDxxfT2yjjfy59LNvUW1tYuqnzBpdJ2OiDrmZESSqTB7oNy1Ck4v/dNepAayEFncmewN5y9gKGLaxFXz0w9PIDXgpt0UtF+xAiC55q0jZcKVZ9dlFGD9tYVH7PvR1xBLJev8H85Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520764; c=relaxed/simple;
	bh=SqLintLxO3asdg88f4Gg5WLeNyM2VQRB4YdxJp4jyhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dUhy+wS4FnrOElIDwTfvEYnqqacmHjEU3nyecv5CMsSKxnytQvYCwllBo46H1Uej6qe1BbZr1TJ7k4VazsQp69orohesD0BZ6cuzagW/OvT/hTBzfQrvv2kLEDB73E9XGu2aOfxUmfcxDXV3vZBcVo/qIhrlj7OT6vljIHIBUeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MxTdzfYe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WsoPI9yC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L96YMN002713;
	Mon, 21 Oct 2024 14:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SqLintLxO3asdg88f4Gg5WLeNyM2VQRB4YdxJp4jyhE=; b=
	MxTdzfYeSNSUM8cKbuxF/L804Z9YbnsTC5czq4xDGviSN+BEdaRgMEqM3xWPNxgi
	R7kd+eSXZu942uSyROdhOiYrbgVAcH6+5y8ZVyod/U0EEB6rz2CtkaZBe2C9lKsR
	GVjUw50R9yrJ1m436UcFmDPKWL6Fz5ucQJkYu1ohl6YeZlvSjyBxDgTVK+9IFed/
	YzVio4f8m/fwEKc4FjqmPnbEwLul1VnkXz6Xzgw09qVKQPhHM4fFDVatS/WcCO+/
	QIJEA5nw52OMqMhOcgpFgTFO2I74p7v15IUtiW11EmzJiHz+nRlElCWgGi6PqLNY
	4+em0G1UdCYZvA8vhZPrDg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c54538jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:25:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LD6b2U019683;
	Mon, 21 Oct 2024 14:25:35 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37chccf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:25:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xt0lJsI9oxKF0GEYJbvPVUmQY7b0KGVy9X5bSPIgWseJpdhYI47RONr2C9W6wnwN5+iRr0rvwMkatNMs0WTKJNqi6m+lwRgO5tY1lwmO9TLMhEed0/GtK7r6Ru7Uf+o7eh7mECZfBZmVDw+WQ2+CWQ+OTYxZFWLqmjmkNylgXkBqajlC0uT59uYOEfbK1RZ7ooVJc2rdGLMhuseqP+T7Q2NVdif1UF+m8RJ9je0Xj4DBv595XiiXaaCIXK64LzFKkCoz7c1VmK8SAOja9w90vyZ0cFCjdm699qFH4uCBAIDIAqxsM2cgH4QtWVPalfDsIsqdY3QZQiB9guQ5iZ9Rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqLintLxO3asdg88f4Gg5WLeNyM2VQRB4YdxJp4jyhE=;
 b=EOH1pkm6ct1xgf8Js9FTYfKIPuGUVG8P+FtScrHUd6NjTckD9VwZ46G7qyNXRZo5GSus1X7YuB3iCkN0mDuxZw7hgEHWBwyfbivmbn3j7mdU3yI6dTEVV4NoB3i763Kk88wBipbhGqb2aDU75P2SDnoizlZtKnC8Gh/7OWjr9K2M9kr8Lfymt7uvBWkrQd9Wzg1VbO2k7P0csBNdMCvX6q5njCEcH32MGE/FE7E6GiEsyTZnOFpuAp3+m40u8aqAmD+36qwkTLAXpyu808IfQDEAqOK1Xj8E6icEKnzj2HZ59Vb3NT5JrSXJcNv9XvgVtASpfTXJPKutJIMjgq27dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqLintLxO3asdg88f4Gg5WLeNyM2VQRB4YdxJp4jyhE=;
 b=WsoPI9yCbz+74Kt6n6YNMWUV0n/0iRCTxipwgbtECpnLT+8l/rgh0GkiIQ3W2gjFVIBKNau/iQsab5Uo7zupR871Mjj4XXCvpcYF6gK+cCeECN1X+Ir125ZgBjCy3niP3tb8hGJdnIJrQYsVK7qe9laLFSN3h3nDX7FdqSMmc2c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5734.namprd10.prod.outlook.com (2603:10b6:806:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Mon, 21 Oct
 2024 14:25:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:25:31 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: yangerkun <yangerkun@huawei.com>
CC: Yang Erkun <yangerkun@huaweicloud.com>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo
	<dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH] nfsd: cancel nfsd_shrinker_work using sync mode in
 nfs4_state_shutdown_net
Thread-Topic: [PATCH] nfsd: cancel nfsd_shrinker_work using sync mode in
 nfs4_state_shutdown_net
Thread-Index: AQHbI5M5ORcVR5t6gEij87LMrVDn5LKRO+cAgAAFAwCAAAIMAA==
Date: Mon, 21 Oct 2024 14:25:31 +0000
Message-ID: <7FA40B59-C5FC-4393-82DD-BB8CE44F4AC0@oracle.com>
References: <20241021082540.2885014-1-yangerkun@huaweicloud.com>
 <ZxZeZB51iwVgVZt6@tissot.1015granger.net>
 <2e5c039a-fde0-de3c-c15f-5405a5507c8b@huawei.com>
In-Reply-To: <2e5c039a-fde0-de3c-c15f-5405a5507c8b@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB5734:EE_
x-ms-office365-filtering-correlation-id: 8c37bd24-d6f5-417d-f168-08dcf1dc3818
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a29ybDhWQzUra1RpUktYVDB6R1Y3Zmd0S2pqSmxKN0JRQlBYcUhhK1BLTzdn?=
 =?utf-8?B?akd5NE1ucDZrZURRMExSOW5Pa2sxMm9uUjdVU3pkVEhNZEVsaFNJem4xTlBY?=
 =?utf-8?B?eTl2Z3RVNk1VY3gwSUE1OTQ0cUQ2RzAwQkpUNVh2QjRldUtKTGxISS9WRVRx?=
 =?utf-8?B?Z1ZHMzQ1R2JYQkVDdVQzTEp6TzVIV3hRM013Sm8rSWhuZXB5Y1A1WHdMczZh?=
 =?utf-8?B?Nml0eXp4SVRXUUFSaWpvRzVFOTBCUVNzNDUrZVpLTHROWGRqWFNxTFc3UXdR?=
 =?utf-8?B?STZta0RDOVlVRUJLcEUyckNEWURLT2VoR2lYREowRE9WcE5QWS9UbXpnNnp4?=
 =?utf-8?B?eGdkVUtGaXNXVmtTa0VzRmsvSkJQREozRDNWMnZ6Y1Rwc3pocG9lR1BtU2NZ?=
 =?utf-8?B?YlR4M2dnUVhnbG84bzJRckFidmFPbHAreU4rVy9kZ2ZPbk91dStheTI4QlJz?=
 =?utf-8?B?TzBsU1oza2phWlpwYWpBUWNwazZUT1B0V1ZWY2JMZ1pUaXdYcnpZQkJtR0Q4?=
 =?utf-8?B?UUsyZDVwUjBKL1djQWE5Mkk3UkVjL1JCcnp0VTFFOTErVTRZSCtCRlpxZ2RN?=
 =?utf-8?B?OWgvMnpnWDRNM2lFL1prdmYrSEJ4R2ludjU0anM1M1JGTHVqMXNJcEpTVnNw?=
 =?utf-8?B?elVuRWxOVmZ5R1lxa1h4RVlseVZnakpVb3NxM3hoRTZCbHBHNGZxYzVzRXpa?=
 =?utf-8?B?Zzc1Z1EySkN4SCsvY1UvS3QxYlNoUVY0UUMwY1FpYURMZGF4c0hZZWFaRERw?=
 =?utf-8?B?eHRlNGdpR2VLeng2eVZ1cmkxUUQ5L2RYMWRYYUlUb0lRZFZmYXFOWTBPSmwz?=
 =?utf-8?B?R0tjRUZib2Q4cGhLZ3RHa1R3c1ZPVi9LRWFwZ3I1bU9WOGlJSnJSeld1aVdM?=
 =?utf-8?B?UUwxanM4Vmk4c0wyZzVGYUowR0lxd24xRjlmaGZ4ZkJhSlhQSDJ1TytESDB6?=
 =?utf-8?B?QUFVTURFMFYxVmlya2NYTWp3ZzZFVE8vK3Q5QUNUdVhJOW5OZ0pLUmZqNnhE?=
 =?utf-8?B?NGFyNlJLRmtUdkNTRWVVK3pNaFB3KyswWmdPN2dUeXJ5eC8zVk4rSGEwanNU?=
 =?utf-8?B?Y01FT21QRlZkRVFuOUwyWDZGOCtOdzB0aHZncXJSSXB6MjdrV2dUYmNsU2h5?=
 =?utf-8?B?UzM0elZOTEF3WHpFc2M4QUpHdm9CYkhLOHVTMGZJUWpJUWdQK0NZZCtHaVRB?=
 =?utf-8?B?M2FYWlpmV2Z5cUJCc0U1Z0kxUTdXazBEaVFCdTR0bG5CWFJLZ1NhVHlRczZZ?=
 =?utf-8?B?RzZMd3h6a0oxZHFRYk0wTWpRZ2R4Yk1FcWc2VG9mWlNiRk9kb2o2TDg4a3dN?=
 =?utf-8?B?bnVNL2NwZTRlQi9MSEp1Zzh5Qlp5aFVhcjdlM3FCTmt6bmkxZWE4OTdReVJR?=
 =?utf-8?B?UGp6RVd6aW9Vb0xhWWJFT0c5NkIzRm9zZnErSmJONXlkaEQ1V2pOTnVGUWpE?=
 =?utf-8?B?VHBOSDg5L0lyMGV6eFg3NUkwV3JpNzc4ZTJSS1lUT0llRjhjRVZmeDBCcHZK?=
 =?utf-8?B?eFdjVW01RUM3TXJ4SGRFUDRJdWUwWWVjOWdxN2xmenFaaUVYTFJpbDFZZHdI?=
 =?utf-8?B?bkZua2ZtYW41L24rbUsrb3FJVWFIeWRQZSs4RUhPeWdWZUhLYXhBWk8vTGsw?=
 =?utf-8?B?THZlMnpsVFZOakp6bmlZVXpDRnd5b3crWWIxQVZzbkRMVEhUV0NvVFhTMmh2?=
 =?utf-8?B?d0xaNjBjRGpUcTJKcXh0VUtuVk1BMXZaeVhhc29zSGJCVks1UTg5aTVpT1Fy?=
 =?utf-8?B?SFpBOVlTb0xzZVlSWVRyL0FyTmx0YzhGdHBWZGVSck9uKzB6VU5oUmozRm0v?=
 =?utf-8?Q?jjFAhS8ccttWzAe23pV3y40yyg3l8wKtUEWKE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0FMZ2ZjNFpXSFVNUldYdWVHeXJkeGRFOXJ4ZlVHeWwvTzZFbUlEQUpSV2pl?=
 =?utf-8?B?TXNmZUxXU1Qzd2tDRkcxMGpuK0IyNGxjMFRjbWhaeWxjdUFXT2c5bVZVcGRm?=
 =?utf-8?B?VVZ6ODlST01LSS81ZEVjZUVrbzFQNjkrbFA5c3dsVXI3ZmsvK2FDcmZHSm14?=
 =?utf-8?B?cmIzZlNDdFdrQlFiMyttUXE5QnZXdmEzNXEyMEwwK1Zua3gwN2tITE10bGRj?=
 =?utf-8?B?TDlPTHZ4VVF2YVV2ZUlyYXJ5RFRrc1FKU2M3NHRVRmwxTFgwL0lkKzkrNTBL?=
 =?utf-8?B?N2NSVjhuUGhFRW1ZWG1OcXpNOHh2bGliYS9WMTBjZEhVdDZPbWlIMW5BZmky?=
 =?utf-8?B?R0JGRko1WUtGV3BlcVhyUFg5MGVUQVlLbmVhblF2TjRtb2swS094Ym5nc2Fy?=
 =?utf-8?B?TjlBdGo4KzY0OUpiNUVqMEpjSkdXSTh6RTg2VktyV2tsM0dPU3U3bUlYSmdx?=
 =?utf-8?B?aE5jaU1PSXNMOWkrZURJTlVFNlgrOTZ5TVBmbGQvSitxc1phaERqeWJrS28w?=
 =?utf-8?B?b3NOTTNDU0wzV3BKaFM4Z2tGdFdiUEtqNmR6ckVzMUpoenJnbzBxbUdmQ2xJ?=
 =?utf-8?B?TWlva2FhOXpqeWZMZmNUVW9IckpNOGVSTVh3aGx0N2NVcWNjNitMT0Z6NTY4?=
 =?utf-8?B?aERTVldMRU9RMmJGVkt1RkpUL3E0aC81NzlUWFd4aHdPNk0zb3dRRnExbEhE?=
 =?utf-8?B?ZkNXdlZRK2tDVjdBSzdjeE1KTmNmR1YvRnhMUS9UcFpha1FxSHpVODZ6Rno4?=
 =?utf-8?B?MXpWVThwRThNQmQzNURBYjZBc3IxNi9jcVBOSDBxTGcxd0JPWFNmUHZORVhM?=
 =?utf-8?B?WXU4YXlGR1BBdUhRTUJmSlBMZ1NrR3c1cS9oWUtIajRDSWtxdENuS0swWjFx?=
 =?utf-8?B?RUhObzI3MTFWalRsQm1ITHNnTDFyUSs2b1hnRzB5N09WTnNEMllROGFXYzNV?=
 =?utf-8?B?V2FGT3UxSHBEU2g4c2lYSmpFb2lQcTN2UkpMNkhRczF0ZU8rb2VpUC9yeFdL?=
 =?utf-8?B?aCtRQlhhUWhWVWp1Sm03eS9CNk9QYk53Y2JJUGpiWWxPVVk5L250TEEydmtF?=
 =?utf-8?B?TkNDdVZDazFVTFRDci9zOXNSekVzY3VlOE9zcDczUTdKTnNGYml4NnBWTmMz?=
 =?utf-8?B?RHo0Q2daaU9iNGxTTlpRaWlGWjVkUWdxbkZ6blJSaGo4aEJOZkU3L1lXRHRh?=
 =?utf-8?B?UC9rbFlVcGJiYWVFRktYc3dDMTVMOE9UakhUaDhzNmh4dEpGTkM1UTBkOTFo?=
 =?utf-8?B?aWlFUmVRUElDbEEvaGt5THJ5Q0pnWUlEWXdQQXgyUHNvNkE3ZkdqYUR1MW55?=
 =?utf-8?B?MUpXWDArbW5QdDZ5NWp5Skt5OGRkeFlWRWt1RmQrVlNrOGhqVFpzRktvNkNz?=
 =?utf-8?B?aWZBTWNjbWZDR1JPTnZveHVyRFlWOGVKQUlEQVNTQmZlcjRSM1A3VTVlKzJP?=
 =?utf-8?B?TldVY1VNZDdMUXUrdUk1T0hOTHV5TzNRT29kMzJ5akZ4UnVaNVVkVzBUd3la?=
 =?utf-8?B?MXJWajJiTGROMlVOYW9VU2JxNTdTT09NQUZRNkdpNG9WY280UmFyZ2k3aGhX?=
 =?utf-8?B?a2ovRW5HR0xMVklPcHozQ2ltQzUyRWdGV215UTBiU05IZ3lScHpNdm4vLzdD?=
 =?utf-8?B?N0lpVVV0SzdUZmNNdld6ZTExeE04Y010eC9MQk9OSktJL2MyaEdqN1lyVUF3?=
 =?utf-8?B?dTU0bjRTNjhCdXBFTmYxaU1sQlFiR2FmSkM3cks1dGliUmQ2NkdIU1V0Q3Vm?=
 =?utf-8?B?MWVPYTdlQng1bzlFWVR4SzBwT093ZExjUFhQWHpXM2hpeW1BOThvNi9hNFZv?=
 =?utf-8?B?ZkhtME41dXFldU1ubVNEemtSd1N5bTFEb05SeXR2UmNReU5OZUMrelpCd29D?=
 =?utf-8?B?RHVYTEZkRWFQWElmV2R0Q3hyaUdxMkVqeUIrWm1QUE1sbXlmUzhpeVpLWml5?=
 =?utf-8?B?TW9ic3V2dkZZcUNHOFBnSVVWZktJdFg2cWRxV1UxUGRFUmVycVI3QW9EekJY?=
 =?utf-8?B?Q0txcU5JN1BxbFNIZktBTDNCWEtWbmFRRVpMTEd5MUhTM0RoYTJkWVJuSDV2?=
 =?utf-8?B?V0ZYVmxiVE16MkpCcmM4aWdjM21RanZJb01LRTVBTWpvNTlSaWZ0aGRSSlRS?=
 =?utf-8?B?cGRIUzluTkNsdmZJdmZZKys4ZWttU0VNdXJMVkk0WndVTXBqRmx2Y2R6T0Rs?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <172030FDC4AC034E88FC7F3B98162E5B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ivW0BJZM373WQbFKmZ88K4oBzsDuTiYqZA9DqdWN2jkyZ6+tPz9Ut3R78KlBT2zu/hFhS2206vT0dw3sGf8jAGPT80YIHEzPNnCbA3dPdd9flKd66NJoY0Os1zTtrEeAOCMaKQ5/AfnR0Kj1BQMVNek9fHe38hQYumnhtCZ2rTAmyWgji2uC1HDA5CPGx2nnsjhr/wd+eFpAwZeppvUk4XiX/MHVXyfh1dAU9v7r4V7DpxbNlxDfWecNlfiv0jjscrJUj3PqZ6YFGxpXu9evmVkccEu9WuWEs+qkD+yjc6/DV44AFzmyViggfS9nGq1cTBuD79KWTYyQ5hFiZ+u8uZXxOMdygUebfgVy8TxOVWhGz6/uTljplayLqFGUg4k6Vd/oPCakqKeGYcIzBQsC0JKLBBWLXfpOPjX94Z0DJJXpt9gi1gwbttar46sSJFvvdmrIoVvPtRnk0z47tFaGFKBnOd8rr4QY1Q7PPWlaX9/GGCqXTPACHo2BmWVGLV784hSoaqh8zGEabHF7wfx0WoUVCcNOOl9TEgbJZ+HWtditPDmOB891SsyH1XQkzLurgSKwJ5ZfpAkO+6JLY5M3mcF1A1VoFcBAk+JXAPWEbW4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c37bd24-d6f5-417d-f168-08dcf1dc3818
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 14:25:31.5463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lKYA5kFnBzhWXFBz6DgAJiP+DiVv9zCLGy87S/g+v23RQfQkwa1gZTn/V/6V9cD6rck1kncmqauqRxffAuJnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_11,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210103
X-Proofpoint-ORIG-GUID: xX_Q1NtYAUEeigZ9XnSiU-hylM26aQm4
X-Proofpoint-GUID: xX_Q1NtYAUEeigZ9XnSiU-hylM26aQm4

DQoNCj4gT24gT2N0IDIxLCAyMDI0LCBhdCAxMDoxOOKAr0FNLCB5YW5nZXJrdW4gPHlhbmdlcmt1
bkBodWF3ZWkuY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4g5ZyoIDIwMjQvMTAvMjEgMjI6MDAs
IENodWNrIExldmVyIOWGmemBkzoNCj4+IE9uIE1vbiwgT2N0IDIxLCAyMDI0IGF0IDA0OjI1OjQw
UE0gKzA4MDAsIFlhbmcgRXJrdW4gd3JvdGU6DQo+Pj4gDQo+Pj4gRml4ZXM6IDc3NDZiMzJmNDY3
YiAoIk5GU0Q6IGFkZCBzaHJpbmtlciB0byByZWFwIGNvdXJ0ZXN5IGNsaWVudHMgb24gbG93IG1l
bW9yeSBjb25kaXRpb24iKQ0KPj4gSSB0aGluayBsaWtlOg0KPj4gRml4ZXM6IDdjMjRmYTIyNTA4
MSAoIk5GU0Q6IHJlcGxhY2UgZGVsYXllZF93b3JrIHdpdGggd29ya19zdHJ1Y3QgZm9yIG5mc2Rf
Y2xpZW50X3Nocmlua2VyIikNCj4gDQo+IEhpLA0KPiANCj4gVGhhbmtzIGEgbG90IGZvciB5b3Vy
IHJldmlldyEgQmVmb3JlIHRoaXMsIHdpbGwgdGhpcyBwcm9ibGVtIGV4aXN0IHRvbw0KPiBzaW5j
ZSB0aGUgY29uY3VycmVudGx5IHJ1biBiZXR3ZWVuIHVwcGVyIHR3byB0aHJlYWRzIGNhbiBoYXBw
ZW4gdG9vPw0KDQpZZXMsIHRoZSByYWNlIGNhbiBoYXBwZW4gYmVmb3JlIDdjMjRmYSwgYnV0IHlv
dXIgcGF0Y2gNCndvbid0IGFwcGx5IHRvIGtlcm5lbHMgdGhhdCBkb24ndCBoYXZlIDdjMjRmYSBh
cHBsaWVkLg0KDQpUaGUgYXV0b21hdGlvbiBzaG91bGQgcHVsbCBib3RoIG9mIHRoZXNlIGludG8g
TFRTIGNvcnJlY3RseS4NCklmIGl0IGRvZXNuJ3QgaGFwcGVuIGFzIHdlIGV4cGVjdCwgd2UgY2Fu
IGZpeCBpdCB1cCBieSBoYW5kLg0KDQpJIHBsYW4gdG8gYXBwbHkgdGhpcyB0byBuZnNkLWZpeGVz
IChmb3IgdjYuMTItcmMpLg0KDQoNCj4+IGEgbGl0dGxlIGJldHRlci4NCj4+IEknbSB2ZXJ5IGN1
cmlvdXMgaG93IHlvdSBzdHVtYmxlZCBhY3Jvc3MgdGhpcyBvbmUhDQo+IA0KPiBPdXIgZXhjZWxs
ZW50IHRlc3QgdGVhbSBoYXMgcmVjZW50bHkgcGVyZm9ybWVkIGEgbG90IG9mIGZhdWx0IGluamVj
dGlvbg0KPiB0ZXN0cyBvbiBuZnMvbmZzZCwgd2hpY2ggaGVscHMgdXMgZmluZCBtYW55IG5mcy9u
ZnNkIHByb2JsZW1zLiBUaGlzDQo+IHByb2JsZW0gaXMgb25seSBvbmUgb2YgdGhlbS4gVGhlcmUg
d2lsbCBiZSBzb21lIGJ1Z2ZpeGVzIGZvciBvdGhlcg0KPiBwcm9ibGVtcyBsYXRlci4NCg0KRXhj
ZWxsZW50LCBsb29raW5nIGZvcndhcmQgdG8gc2VlaW5nIHRob3NlLg0KDQoNCi0tDQpDaHVjayBM
ZXZlcg0KDQoNCg==

