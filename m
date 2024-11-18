Return-Path: <linux-nfs+bounces-8080-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215069D1A80
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 760FBB218DF
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8852155C94;
	Mon, 18 Nov 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WwHnzx88";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rk4pQ1JD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4BE178395;
	Mon, 18 Nov 2024 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964993; cv=fail; b=skdRLY+3Ig7G64j0hobAcVrSLgyg2810q3yfdBAAyQPg9QkHR38HCbSrHtARyUooLKjrGKDMJDZhBfjmYO/lqUifnSOvY6h+0u6Sr0uyiPrsXa50EXjBT25cHDQ6jlfLjT9SKRtU2jRW60MPTdV/ywgVvXmVs1QYDwyhL75CG4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964993; c=relaxed/simple;
	bh=4Q8gzhEzclqIgrQrVAhVDpyqgYTOBXP7jyp1sx+f+6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=almVo6ajT8sMdAjES2lw3pn3aUvBMdYdacezR5BEc+O0uH60/Kfk3jyZfVLxQwviLVF3RfaExzzuOZDjvSB5N47PU+dhs9EIFtp33/+itBGCZbMKQSPCxQqj5hEq5323bRs2/NwKAgP10ywS4l3XKnsLjnoFT19bEAtnaJBKKaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WwHnzx88; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rk4pQ1JD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIKtjI6007689;
	Mon, 18 Nov 2024 21:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4Q8gzhEzclqIgrQrVAhVDpyqgYTOBXP7jyp1sx+f+6Y=; b=
	WwHnzx889OfjcVmQsAebCc5tkRARu6jWUQn/iDLKOKxinUDgoWYiM+mz+AK8Zu4v
	R9pCgawZ9gU/IXBV79VVxh1KuJtgLZtXGMi4zOicQfwxSNqkaolYlFzOi17Osu3U
	ssI2M4iyc9Sr5+HlRFiLKAZT0ncKfQLvyA438Y7Txiojq4d5tfAA0WGMrLNN8lwf
	dc0E3H4c45V5t2qm/a+3xS79BRshTQpPfklpHXsNp3RW6xHtIydWm+eur/HVWBHP
	N/P4AzycOZ1VXOwiqHaKs6/w7XMb7pNxy2XK5AbhxgObTTOaP4YBbvRh0UoABvf3
	iR0S2Bw18RHBgnpUij09Uw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkxsukka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 21:23:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIL6qJ3037162;
	Mon, 18 Nov 2024 21:23:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7p2ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 21:23:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E50EdfFE6UPJrlw5NB+KT4mXs/rL2omwDr56piAoIyURBhU1OVtCB1b+i5xzNSLYtydgq7ZYWDudcoyGTC55h8q1DisWaPJckmomcWZfkLfy320NK0N7vERxfqYQk5fVNarYY2D9aTAyUhtlWTsLBfCgRilq06MzkDbtbEuEHXtKtyFLMftOiyAMoRfh+cTc96Rqx1b6dFXtil9VbUaigWpQfjIRsUcyW46UcajE+Lq1udXH4mVFJPQI66x57xwAPKbdNZ7xa1FLD7nzulNKAj8s8YBrZP3smZxZyv6ns/XuR+RYasTePGRV6KMrNFY9GQmOJyRQmY0blPYBI85k9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Q8gzhEzclqIgrQrVAhVDpyqgYTOBXP7jyp1sx+f+6Y=;
 b=WoWfKu/6V1Jy4Za6SitRvDGZk8G8qCRFWqgW9UOrKn8O5oOF5o0uxkY5RuxQigXyrtMx9cPXRzUR7uHtwloe0kJUBOnwAAf8n964Hiq725TIa2gBCwfKAz5yK01A84iN58m9NTriqBfOTzqH3ZXd4bWY7UupfClL1LbUOIyFEpDj/sFnDSot6K/RXrNorDvEDhWt/6Idl7PnT9U2/vP7BRThOMeMWv0cna5ZwaeIv8Y3UMJ+if/hZrPWW80v+UAcmj3qv9m8p9VmQrXkSVZyNTCojdqNqicny+C/tB+RRpYKtDyREMBJZoxW5N9jfa2Cu3TvI1hceHji2xn00WjLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q8gzhEzclqIgrQrVAhVDpyqgYTOBXP7jyp1sx+f+6Y=;
 b=Rk4pQ1JDt0oYLdl99qwoKqvv+2k54DJ30g4t87TBD30oKopNLGZcEZRvnQKoV/1rPbo3aqlqBD4naxsrQDTEMVaqHSe8BjMj/o48GUld3hYgak7K/uWZXKsdCKTPgJFmipViRsR5X/GcDyhWoS9h/EbbbSaqiTtJtFjHupSqtgM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6733.namprd10.prod.outlook.com (2603:10b6:208:42f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 21:23:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 21:23:05 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: linux-stable <stable@vger.kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>
Subject: Re: [PATCH 5.15 0/5] Address CVE-2024-49974
Thread-Topic: [PATCH 5.15 0/5] Address CVE-2024-49974
Thread-Index: AQHbOf+5e3i8YOM6l0y43L1BO2O337K9jA8A
Date: Mon, 18 Nov 2024 21:23:05 +0000
Message-ID: <2AED5837-7E93-4A51-B4F0-2D57462D725F@oracle.com>
References: <20241118212035.3848-1-cel@kernel.org>
In-Reply-To: <20241118212035.3848-1-cel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6733:EE_
x-ms-office365-filtering-correlation-id: 2922bb41-be2a-4c7b-6244-08dd081730c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RDZyZ2p4TWhUNnpGUWdMbDQ0S0paYjd5WG1qRHN4cXE0aUFkc2hBL1A2WkIz?=
 =?utf-8?B?NGtTZkZhUCtMcWxsaDF6TXZlUHNIcjFWTVVLc25hVnFITS8xZ3hDcWVSY0VB?=
 =?utf-8?B?NDFtRllCeGk1ZStvL2JNSWNhanozWHpDMTgwQk9rZHhScU9tZTVkRjVGSm5o?=
 =?utf-8?B?L0VraXByd0NCZkFKdDVERTRkSVJZNmVNaTRpSkJEb3M3MEZoa0tmY0VYRVZy?=
 =?utf-8?B?YnZBME15T0JzY3JkZjVDOTg0OGxYRkNTMVNNcXBnb3VDaForTk5HVnpVamZZ?=
 =?utf-8?B?aDhQVXV2dnNpTEpma0hxZWhkeHI2enF1M29UNkRLcm9SM1dnRWp5M041dURk?=
 =?utf-8?B?Y0lKOFNrbGVXVEp6TWsrbGhsYjByTWI1Q2hJcnhOQkJRVTlxcXNWMjlNTURt?=
 =?utf-8?B?YmpKTEpUT1ZhR0xNZTArMzcvQ0NZL3M2NDYrMTd3K3h2QnlXUHVPVVJaVFR3?=
 =?utf-8?B?ZG5MSm5wam40OUsrYTN4QjhRZHByMmNscno2TlE1U2dsMFBXUDFtTEk4WEJ0?=
 =?utf-8?B?bjhBOHI0OVJxNnZPTXNKUzY2RXVOU3dXMWk2OW5naFlPT1pPNURFQm5LVWJ6?=
 =?utf-8?B?L0FEYU52L29JY2NoOTM1N1pzRU1sbDVqTWltdXFxZk9TSEJMcUhFVUxvd1pV?=
 =?utf-8?B?NlBwbmhhb1Y5dVpvU0x6VXlONG0rV3R4Qm82VWxOckRUTHJ3ZEFWQnZzbTBK?=
 =?utf-8?B?ZWtnTTZoM09iK01NQzduM2owTFpVM3cxOUlvZWp4QTVKdnBWUHgzcG5haU5s?=
 =?utf-8?B?VFNmM2dyMnNMaElvSE80YXRvSlNaTTY0ZDFvbXh1eVpUSUN0MkloTVNhWDln?=
 =?utf-8?B?R09NVm9WRHJFWG1RMzJPRmRlZjFtaVJFM2N1ZS9JOXY0K0ZCUEcvZ2pLUFpQ?=
 =?utf-8?B?THFsdi8vd0V6anRkYzhvRGRFdHhYeHFzWTJTaGk4aWdPbVhmRkd3ejd5UWpS?=
 =?utf-8?B?VFZQSzBlMFA3WXYxKzR4aHFraFZwU3orbThXRVNXTlpPc0R0eWJWZXNqK1BP?=
 =?utf-8?B?NE9ZeVdDUW03b2tlNy9ZQkp4OS9wVWgyVzVQODZ5bnhxWVNNS0ZDbmhYVW1s?=
 =?utf-8?B?WEF3elRMZGZKc3kvVXFjbkRabjJHSEtNZHJWWFBYMkN5SHdmNGpzL29YdU9p?=
 =?utf-8?B?YzFvSWdzWXdOQkR6U0ZOS2ozWC9vY3ZwQWtBb3ZzSWlOQzFOVGRjZHY2Z2VI?=
 =?utf-8?B?TkRCSi9HbmZVMSt3enNmTmxIalhGd2pNR0lEUTErUjVmZHNsVnBDMlN2RURG?=
 =?utf-8?B?V0tPYlFTSTh6Sy9HYkxEbDdLVGtCZmhkVitheUg2a0FFTEpIaEhDaU93RUdV?=
 =?utf-8?B?NEVCSEdpYTNSaXNKcnNyMHMrVUFOcUh6d0F2QTRVU1FpUWRnUmIyMnRyZFls?=
 =?utf-8?B?ZG1uUjBtN1FWYVE4UVlFSzBzQjdjNjk3LzRjQTJ6aFZhOS9Cb016Szg0aDh0?=
 =?utf-8?B?KzNuTFJLSGJTOHlFbWt3VTJpRGRjNFhlMXZReUQ4eWVQTG1jdmd5UExSODZJ?=
 =?utf-8?B?aUhHU2VIOHBLQ2pRNVhvc0JLd2lQdzBoeE9TZmJJVmdBcnFMcGxHVDhvTHk0?=
 =?utf-8?B?L3dzRis1NDNCSDhFaTNCb3c4NWJlcUpkNDAzc3huQWpQamt3ZUZHQ3Y3NUxp?=
 =?utf-8?B?MmoyQ3dHYXZ3dG1CS3p4RGJlcEFtd2FQZG1PUEorVi9tSzNBdUFsOGg0Umo1?=
 =?utf-8?B?KzhZSzVDOWlISnVGL1R6Z2ZWYXZiUlU3WUt3Y0phNElBWEJOWWFkYU5XaWxi?=
 =?utf-8?B?YjU1MnVZeWRzcjl4em1XU3dSU0Y0OTAxRDBqK2phV081OTM4a0ZrdjVuQmdE?=
 =?utf-8?Q?ShzQGIHRURxoUt9RaGWR6TcThHVL8hdmp7TO4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bU9qV3Q1eFB3OStBWkZRU2Q5YkJCZzBCV0RnRURJQWRhWTdJVE1HL1piYUs5?=
 =?utf-8?B?d3l5NDhqd0IrR2VpY0hQamV1S1VwM1hPOHBOYkFuTGdMendqUjRxRmlyTExa?=
 =?utf-8?B?Q2dhMW0zL2RvWkRtQ0piNTFIUlVMWTlzTE4wUm5FWnFuemJoL0lDU053eTlj?=
 =?utf-8?B?Yk5JcnE5TlN0QlF5UFk2Sm14dy9YcWpEalh1aDY3S2FtQmVMU1ZqWmhoWUlM?=
 =?utf-8?B?M1JWbWhweE4xeitUWlRBUWVrajlDV2laNktGekpCOWxZUElPTDJpRCt0VVZ3?=
 =?utf-8?B?Mi9ueUt0QzZ5djVvdmd3SzdjL1MwUFVVczR3Q2pMVlE5KzlIeWw0bDBwMHRz?=
 =?utf-8?B?emdYMFhnS2hQYTFpS2xYVWZ3d1hncWVTN1J4U0VQQlNiZzJHK1hWVmkwcFJO?=
 =?utf-8?B?ZG5iTEpTMStHMXUrOG55UlBBSnhjSkR4Uml2M25sV2tMNlp0SVFhc1FzLzdx?=
 =?utf-8?B?T2k5V2k3Wk54SGgyOVRaVFhVZHN3Vi85N01XaWs1UHVMM1lvaW9PNkpYUGNR?=
 =?utf-8?B?RnBsbjNndDIwbktnRTdmRVVUV0FQd0NZaC9KbWxzNnZDN2pOM0xIa2VPbE56?=
 =?utf-8?B?dFlDazFXNzNrSDdjQ0QzdTQydEhOOXkwUDhhZmZtZzVlRDNhK2xPWmRwSlNP?=
 =?utf-8?B?SGNjbEtORis1TGpKai9HelRVYTY4djdyZU93L0kwVXFGSWZlM0dCbVpqcXcz?=
 =?utf-8?B?aWVwYWRqN0JFaHJmQ01md3VkeXNPTnBycGJzc0syZXltSUthQXMwc0RrcHd5?=
 =?utf-8?B?ZndkSCtHS1ExRTRKV2EybVhMZnVVMUVWSFRTMlZZTit0djdFZFQrN3F4KzZ5?=
 =?utf-8?B?UWpVbER6RVJsL0U5dUphYmM4clUvQkJhdThjdGJDaUU4cm9YYWRJakg1TStV?=
 =?utf-8?B?L1ZzMlZka1c1T0V1dERhTXk5RGdremhUYkRPL3h5ZmZGVkY0bzJXbkpJNGJl?=
 =?utf-8?B?T2tqcTVIekc0VnNYeDFDUXpMK1RXMWNhSnZxUU5Yd21WQkZVOE1CbnZ6OXlR?=
 =?utf-8?B?L082RmJYdVBxQkx4ZTZyd2lqLzVjQmtURW5vYktnRzc5Z2JiSU8vSFZvWWhI?=
 =?utf-8?B?NnlQTTd4bk5ERzg4OW9ib2xyN1lyVGQ2TUhjZFVQU1dXT0Y2UTRCcWkvNlV2?=
 =?utf-8?B?RXVEUHp4REJRL25yS2dqWVhkdHdKandLdmNIWEVBQ05nb29VNWdFT3htWDZm?=
 =?utf-8?B?RDkvZXZJbFZCN0VoWmpnSS9yd2ZGVHIrYzRjVkx3R3pWSk5pZW9RWXJqcDFa?=
 =?utf-8?B?Z0c0bHJlNk1YMnJyREEzbU9TK2M5ZzZBb1BvZktmbklMM1I0SUNKZzlZQ1dh?=
 =?utf-8?B?M3lQZ2NHNXlrOEx6RU1aWTBqbFFic1c0b2s0T0Y5eDNXUEhySkpNdWV6V3FN?=
 =?utf-8?B?eDcydUNZajBORjVyTkEvMFdFcWdRRURhTGJ6V3VIeVJMcll1S2taWkdIMFZx?=
 =?utf-8?B?cVF4bk1PSzd1ekp6UnNXVWYxTkVpSnYwaG1ITmpOY2hwVVN2WnM0WGUwc3Vl?=
 =?utf-8?B?KzJNOWRxdHVjaHhiY0ZjK1p2c2RwTkIzYjJEakV0Y05iS0lJTGNHeEV0dDI2?=
 =?utf-8?B?Zit5ZWtuNzY5RU9iZElRQ3JKbTR0eTZ0ZlYxL2dPYUdZS1RCU21RR3dVVFZt?=
 =?utf-8?B?ckxwL2RwZExJNU9tclVyWmwxSSsvWjl5L29HVllibWgxMWNTTDAxWHVSN0xz?=
 =?utf-8?B?bGZ2Mkp4SktwbldjNTkvcVVjYUtYUWxGcWFpeGVvZ0hweVlRUjdRUTVmcjQ5?=
 =?utf-8?B?NVdRZEthV0M4RkFXSHBBVG9nM0RFMlB3am9FSEtLcDYveVRDMSs5UmprT3k0?=
 =?utf-8?B?ak9wZzYxa2NPRlVnK0lzc3B2SGRKNUw3SXJsWkZIY1lFbWpJTnhGbVkvMnYw?=
 =?utf-8?B?eFd0RFloOEI4T0NPZWZDY3hrUGYybGNLVG44ek5xN1I3ZnVyK3hrQ0ozSnI0?=
 =?utf-8?B?K0JNT1BVc2duQUxaNFFhUmRCdW43WVZwdWFjN0ZmNW0wbzdIczlFeVVnQTcx?=
 =?utf-8?B?UkpqNmd1aFRHanJxV0RIYWpVWUp4dHI3WmROM1NTcWxpTTFPaDVRVTlPRTZL?=
 =?utf-8?B?YWVOMWtoT2J3ZVZ3akV5Q2pkbWtyYnhJMWhSQ0Nhak0xUnNiUytUcnd0dU9m?=
 =?utf-8?B?MVhPY2NWRXNBV2I3cmlUNWRFTnlXTXRzNEVOSEUra245TE1LTXE2UEdvVENz?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <984E3F4714BF8E48B8EAEBC30A097065@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HuEXAfQJJxMEfC7Q273DN6PevA4ukeVlmRKnTzzFp+XhdcvLusndhm+BBd21ra1tVVvmmmZRY6O0jfm57cihzUlmrZOif4R65GbYUROr/1vc9nEKTCc8Xil4Ahulr8w7NP0zrd1Qn5UM8s26kVq+anebm9iPMHFnKuGC60lapVLO/mvhVXYMStvuS0+K9KZaOvMTGQp4M4nCM2zcm90J3VuY/XBIxU9f1Ny4ZG9euvYYSzKWdeGcX8SDSWJr3ikGxkxdEFe9CF5XOoxrF7fQKCNldMszR7MyZhmLtqDUTyCN1q6+/PrFPzuU1PuadclRbsvCp5DeVgpxQ5vAEON/VcFlwXpTrYGgEwt6KmvfbH6VgRa4TXjtksq4+iEzUQIJSQvLst2DlIDWSM8VD46vSF3RmwRG+evuLzSXHFwiaFIFwTYVOU5YSecH56lsrFTMNZviIiyRJ+ssjeSoo8BlpY+HNR5sCcsJxocGd1e4u6rLGTa07+o5/CjHEoN8SxM6vyxMB66ksJh61yEsBkSUZ9XBb0oEf6LPlwLVdwsA6ZHAT7rTvDUyGeqWYSGc9/Umz0/Gny374U3QPLql/5aQtg0DpsaSTFcbvJme664mOqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2922bb41-be2a-4c7b-6244-08dd081730c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 21:23:05.1468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PsquUD8q6YuR8mWGvPxOb5nup098WCUBY6N3Y3gzslyBXM8EMSnHO9aAgAUFd3pe8p8zMxzk8bpPtB0bwGIk9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180174
X-Proofpoint-GUID: NJoFyKbw9HXnmXxoCQZkW6ys-LHEMvnD
X-Proofpoint-ORIG-GUID: NJoFyKbw9HXnmXxoCQZkW6ys-LHEMvnD

UGxlYXNlIGlnbm9yZS4gSSBkaWRuJ3Qgbm90aWNlIEkgaGFkIDE4IG90aGVyDQpwYXRjaGVzIGxl
ZnQgaW4gdGhpcyBkaXJlY3RvcnkuDQoNCkkgd2lsbCByZXNlbmQgdGhpcyBzZXJpZXMgcHJvcGVy
bHkuDQoNCg0KPiBPbiBOb3YgMTgsIDIwMjQsIGF0IDQ6MjDigK9QTSwgY2VsQGtlcm5lbC5vcmcg
d3JvdGU6DQo+IA0KPiBGcm9tOiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4N
Cj4gDQo+IEJhY2twb3J0IHRoZSBzZXQgb2YgdXBzdHJlYW0gcGF0Y2hlcyB0aGF0IGNhcCB0aGUg
bnVtYmVyIG9mDQo+IGNvbmN1cnJlbnQgYmFja2dyb3VuZCBORlN2NC4yIENPUFkgb3BlcmF0aW9u
cy4NCj4gDQo+IENodWNrIExldmVyICg0KToNCj4gIE5GU0Q6IEFzeW5jIENPUFkgcmVzdWx0IG5l
ZWRzIHRvIHJldHVybiBhIHdyaXRlIHZlcmlmaWVyDQo+ICBORlNEOiBMaW1pdCB0aGUgbnVtYmVy
IG9mIGNvbmN1cnJlbnQgYXN5bmMgQ09QWSBvcGVyYXRpb25zDQo+ICBORlNEOiBJbml0aWFsaXpl
IHN0cnVjdCBuZnNkNF9jb3B5IGVhcmxpZXINCj4gIE5GU0Q6IE5ldmVyIGRlY3JlbWVudCBwZW5k
aW5nX2FzeW5jX2NvcGllcyBvbiBlcnJvcg0KPiANCj4gRGFpIE5nbyAoMSk6DQo+ICBORlNEOiBp
bml0aWFsaXplIGNvcHktPmNwX2NscCBlYXJseSBpbiBuZnNkNF9jb3B5IGZvciB1c2UgYnkgdHJh
Y2UNCj4gICAgcG9pbnQNCj4gDQo+IGZzL25mc2QvbmV0bnMuaCAgICAgfCAgMSArDQo+IGZzL25m
c2QvbmZzNHByb2MuYyAgfCAzNiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gZnMvbmZzZC9uZnM0c3RhdGUuYyB8ICAxICsNCj4gZnMvbmZzZC94ZHI0LmggICAgICB8ICAx
ICsNCj4gNCBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkN
Cj4gDQo+IC0tIA0KPiAyLjQ3LjANCj4gDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

