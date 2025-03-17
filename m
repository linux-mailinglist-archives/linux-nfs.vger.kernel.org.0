Return-Path: <linux-nfs+bounces-10646-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE2FA660B5
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A899189BBA0
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 21:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE351FECD3;
	Mon, 17 Mar 2025 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Ig6mh5J3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2123.outbound.protection.outlook.com [40.107.237.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60791AD4B;
	Mon, 17 Mar 2025 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247478; cv=fail; b=D8/i6fuSifRfxtGHPmkvHpuLKOq9j8aCDDV6ORLfYo/+GxaP8E9jo3XW4n+uOCIxf12dXPoHGHoBaWx90CMLOLyF04At/Q2MmLGMLRDxYHyZZaZhWiql8P4bLN9kJNEQjd+fhIdn6PVtytQoXJQkmIDfD24Z7NZhD29P3AYiHig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247478; c=relaxed/simple;
	bh=3Av6UftfeJlrTsb8zFiCoYLjufiWhrXjoDcvQQGJeus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CYPF9SrSQ1UW9fVJJR+qaQrXMQx9eg1OVul8ARi9ffIwDQfd9dfIrXbr15mL3Hy3nQJsUgQ807klT4vSPpOHoNEoR4KbeydhSQiV/tcr3DAVpih4pCAMKN2Wu+DekvjQTovGYo7q6euhiFpYbahOJCGZdfiCMRfa3BKC5AAdkmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Ig6mh5J3; arc=fail smtp.client-ip=40.107.237.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCF65qxcv5OOuAq/krZKS8HuEJVPfQKm5C4lXGv7Mbct7foMvmBqQ4Yd+2uAgRUbAOzBz6pt7A7RWinr7+G3wag1InTA4m9Ajg7LBTDW5LoN08pI2LLgBknRAA8a2Wd6MTEX+Eu7mL/ahje9so865NGayllJAb0lcwm4Ng+elThq0Qh+rayoUqUWvDBDMhtXTUr2OES7b0svr50Ii59RA42bpyfl/B4TExe8Ci3e+JXAo1uNo4SEfUDZTKBDp62CenTh5F6uWlbLitdFQ/v0H/91dzhihPkQKZdrhsr7yFX9bzNprYnpzC+XcTkrXby5KiwQv76F36LFbWvwrepQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Av6UftfeJlrTsb8zFiCoYLjufiWhrXjoDcvQQGJeus=;
 b=KhEQer/mNP/t76rkSaPf/qxpD41+ZGjFnCGjMDdT0caydFTMknnTHnuY/wEnJRxYLy3QQHrZxYaE6QhycmPCjZGPHyoKrmKjtOXVjpUKr5wmoyqrr5Xza2sugWUiCUr0am3bT5BJ+e0v38y14IRDtlLxPy5C4TR2/opMv50rsPa9KDLIJGTdPKHylr0Fvh11i/+qhzg9RDR/FOLp8dFTbZUVGJ2sKUrRotFLhrMV0Ld0jPca/1+CiPVzRSRuORRnziWCPMrKknYU4riuRpbevJZmM4rtj/aqWZfVlP9S7b/zJfAhMeqel7dOo/KaCehLZJmXuCRN01TQXNclEnqkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Av6UftfeJlrTsb8zFiCoYLjufiWhrXjoDcvQQGJeus=;
 b=Ig6mh5J3eJJLUtWhRaxY/eI6AdzHr1eufj4QXLtTk1WT/339UTVDTCOH+hm6F5FOn+hxoj6XsEmmmW5TR8Weeds6RJgU1gfYLUtMxFzogjl0LgnyBgUO8eGOBYiukPz9igfjKsDHNcucCVwMWv46S/8nvF9Qv4jM00UZHFvH24Q=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5519.namprd13.prod.outlook.com (2603:10b6:510:12a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 21:37:51 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 21:37:51 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"okorniev@redhat.com" <okorniev@redhat.com>, "tom@talpey.com"
	<tom@talpey.com>, "anna@kernel.org" <anna@kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "Dai.Ngo@oracle.com"
	<Dai.Ngo@oracle.com>, "edumazet@google.com" <edumazet@google.com>,
	"neilb@suse.de" <neilb@suse.de>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "bcodding@redhat.com" <bcodding@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC 9/9] sunrpc: don't upgrade passive net reference in
 xs_create_sock
Thread-Topic: [PATCH RFC 9/9] sunrpc: don't upgrade passive net reference in
 xs_create_sock
Thread-Index: AQHbl4A93CHa4xOFS0Wz/Ra5qddpqrN31+wAgAACPACAAACBAA==
Date: Mon, 17 Mar 2025 21:37:51 +0000
Message-ID: <1c1a17caf13911270d02ae2fb0147136580f254c.camel@hammerspace.com>
References: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
			 <20250317-rpc-shutdown-v1-9-85ba8e20b75d@kernel.org>
		 <8555e0cb4774bc1b225fe628cc4e07eb3c6e2a40.camel@hammerspace.com>
	 <1b2824d29af8b23ed59db976420e048eff875159.camel@kernel.org>
In-Reply-To: <1b2824d29af8b23ed59db976420e048eff875159.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5519:EE_
x-ms-office365-filtering-correlation-id: c2f4aa84-8b56-4e5f-dc44-08dd659bf84b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0taNzRIYlhDMFVubVhSRDFoVUNEMUtnYitFd21nU3dnbEFJVUJBK2Z4OVE1?=
 =?utf-8?B?cHRBSjZuR1ovY1R0TEtSYWRvWkFLRGRVL0pMTlAyS3U5QWJnN1RwSTFuQWhw?=
 =?utf-8?B?RkxpVmh6K01KaGYvd0llUG1KY29OcWZEYXlTZWdEQjZBRi94RUlTY21YUlpJ?=
 =?utf-8?B?S2l0WmRpcHM1aXROeHBJMGJJZkFPb2h2R2poMVg1WmxKK1NQVnEzTGJYb1JG?=
 =?utf-8?B?Y3ViZVRXVjZKUVB0NzN1Q1hza1dqdmtNNGRoalEwNFhuMldNeVZFeEJmTG5O?=
 =?utf-8?B?Wm5VL2Q3eHFKMzNOZGJscUVmK0p6cVdvd3RaTGlIbWNVbWhJN2c2d3MxQTl0?=
 =?utf-8?B?L2hzR2NMZzJwSHQ0ZkNDQzh5bVhBbWN6bmhibS96Y1dsZ2x3NWg2K1V4Qnox?=
 =?utf-8?B?WitGQ1N1V0tBSGd4UGVYdWJsSmtVdXY3U1h0NnFQQmRSVjlIQmRBSllFaXFD?=
 =?utf-8?B?V2lzaWVxc2VqdnhpQU5tcjhqWG4zMGdRRENvRlBxLzBzVUI0SzhRZlJvM3lB?=
 =?utf-8?B?eHFxWUFFdUxzcFIrT1haUVBtdGl6VzgyRkdoZXpDSkV5aHpkcTZjd2tteUFG?=
 =?utf-8?B?T0Nya0I5QkFTVjNRYi9qeHNuMGdTRWlRTHA2eERuejBHRHZqanhTNlhyaHlK?=
 =?utf-8?B?ek92UmtRMmtuTktSUU50eDRVeWFRWTFuMjZHTW4zNEoxSGJXZkFaZHp5WGZE?=
 =?utf-8?B?cHdlVDdZenJvYmE4SDIyM2h0RHFiV2JnOWdoSTFlRnF2K0lxK0ZjVmpOZWcw?=
 =?utf-8?B?Y3R0YlUrSElSaVFQb1g3RGVNV0ErWnQrZU5Sa0puSDJqUWpOQWNmMWlzNVFm?=
 =?utf-8?B?Q1NkYUJNN1FhUWNraWwxMjFiWUJEQ3M4MzZyU2M4ZVQrZnA4OVFqN0Jhai9x?=
 =?utf-8?B?UkxDMHBTRkdaVGloSnVOVXlQeHBhU0IzTFMweE43SXlLN053RGJOSitOVHE0?=
 =?utf-8?B?WnFnTllJQ0lLTFBnbTlNVFpiWUJqTGQ4RHVOOEpZeGtURS9FMDlCV1pJSXpM?=
 =?utf-8?B?ckdQMEJEL1NKNmpHNmpDWktGS3RuQVZ6eVJjcnJyWHpxNXdiT1NXU0l2YlAw?=
 =?utf-8?B?TDQ3UnRsVFFuSVhNeThxN3BaY0tOYXhHZ2FNdHJ2Q1pic0NVNTQ4TWVlQklQ?=
 =?utf-8?B?ZVhsNmJwOGZDMVk4anRMakVML2I5Q2NxRnU4MHhENHpIQW5HTkZFRDJjWDVx?=
 =?utf-8?B?bVhsZ3MrekpIU0RVOWJDRVBDSFFjTlpabEdaRXY4OHhHWXVZc3MzOXdWRzNx?=
 =?utf-8?B?aWZOd251aFlSYmFqZ1J4MHpJc0pzeHMwSGNKc3JYUTZhdTJadnVMK0JDUi9L?=
 =?utf-8?B?QjNxUHFJTitXeVdkQXJVT1FrNlIxMDI0SURkQ1Mxb2ViY244Y21qS2EyS0Zh?=
 =?utf-8?B?UzhZTEJDekRUSlZoc0NucWlzNTVSblMwYko5c2lNTS9aVzBtN2haZlUra2lw?=
 =?utf-8?B?MmxzMUtydHBTN1piK3p5RDVLU2F0R0I2VGZvMWVIVnhncWUvSmhVMVBpbWg3?=
 =?utf-8?B?Q1MzWlB1WE5zTEtMV3BTRXNYRXY3eUdYM0owZ1U0eXZ0Z1dSanVGVG9KeUQv?=
 =?utf-8?B?b1hyT0VyRzBKeFBPQWU2WFU0UHlBWkF4R3pLdTBqYkhTOUVoQi9KS2h5cjBE?=
 =?utf-8?B?bm41b1BhaXN2dHVsTUJHRUJSMUk0aFZLdXFFYmNoMlhXVFgzWHBHM28wOW1m?=
 =?utf-8?B?NlZSaGZsRlpXYjREM1ZXaUdRWUtRbmNrVm9kZFVJM0xidk9Cb1RjYjRnWnd5?=
 =?utf-8?B?MkNJN0N0R1ZxOHk4K1dPL0JWeTVPZHJkUG5VOVVMRWIwalFqc2lqeXUxMWxW?=
 =?utf-8?B?WnA1NGdUbW90cHNvU2QvN3FaNHp5YnhPNmhFd2hJaEZnbUl5VkVic2ZSMnMw?=
 =?utf-8?B?aWdIdnFLSE9oQ3phTCtwaHRZUk9kdlpQaDhSa00reFBySWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0Ezekd4R0VJSGRWMERBNUJPZlJiMlNkZTF1RTJtdno2ZGo1SC9DMlVpSVBu?=
 =?utf-8?B?eDR6QWt2UmFHTC94T283SWRUR1FEN3JuSnlpT2dETERUaFBtVUE4dnQzMXNU?=
 =?utf-8?B?TzRMTnd0cjdoazBUbndYc084R21SQ3JkamcrdW4zbSs3QVpHSTBmUkg2SURX?=
 =?utf-8?B?dzNySEVSSXdlRFdvZklEVUUxeTA1Q1V2b3c2cHBzR0gzazUyb2FBcFRwQXBQ?=
 =?utf-8?B?NDdoVk9udXRTYlZ4T1NIUEo4cFRoVWRxMmw4c0xsaVFmNVRqMkFMaWhWeFl3?=
 =?utf-8?B?aVZXQzRuYVdJTUxYZ2R3NkFvZDVMbTdaRkRaK3VLUlkyNlEvaFlQSVZIeHNR?=
 =?utf-8?B?a2I0amRlS3p0eEVWdXVqMlAxZWpzMkNnWHJyNGFPZHhDQWRMY2xMVUttN0N6?=
 =?utf-8?B?N0RuUUVJMmpkUWZHOHpLZ0diUlVLeVplZWR6OE1ZeTlndUd3VjJUSkMvTjVH?=
 =?utf-8?B?THNPUWJ5anFmSHdudWlSV3ZVNW10MWc4NERwWFhyK3NvSWpRY25ST0xvRllV?=
 =?utf-8?B?Z3RQbzhROU5wVC9VcDhlV3VJN2tsc0dlRXkzTjRaK1V2U1pyenM4OElhQW91?=
 =?utf-8?B?Q1Z1aDBmTW53R1JQYlBMMHIxOE16alZhS2RQdmhOaTF1aVhmSkdJdmc0K3oz?=
 =?utf-8?B?ZkEyUUlrOXNOOVBYQ2FKSENNSm9EQUtLV3RnVDdmSWI2TGJUQk5KTVRlYlVB?=
 =?utf-8?B?OElzVXRuRTlmdC9BMERjVUdNRTNvc1oySytqUEY0SmpQYnVnZmVMam5XcXly?=
 =?utf-8?B?TWtCQUV6S1dqVWtrUkVqeFhKMGdSd1BpbHlXNmtiMkVrUFFnODJVc1loTjJU?=
 =?utf-8?B?US9saFZLb0p4VDFqakI5cFo4aTIvb3VDdys0ZWxIVUExMFljRENQK0lJWi9u?=
 =?utf-8?B?ZWFqSXBQenVSM0tJeUZYRzMxU2dMTGxvK1dNNXhCVFVwV3RaU0NBeUNGeHhj?=
 =?utf-8?B?d0tKcnU0dnh4T1cyb1lsSStpWGh3amRIcjlKQnByZXBsaThDWFlyQ015N3ha?=
 =?utf-8?B?V29QZUk2T21oRnpqemZCa3MzNVBPekN6RzZlNkdpdHpwMHVzaCtwd3NtK2hG?=
 =?utf-8?B?S21oQ2ZtWVNnaHhCNUIzbVBrQ05JVll6dWpwR09QZXVVaFJDcHB0YjRZaG5E?=
 =?utf-8?B?ck9xSUtid1hqOHZhc2o4cW5PczBMQm1jMzVRTlJBbG9ZUS9pUElIdUplNnJO?=
 =?utf-8?B?TEZoU2ZMMGRablhzR1ZSZVM3VFpKdDNucHdEck1uRHlBZmlKRFJpSm5jZXlY?=
 =?utf-8?B?Y2p1ZWdacXNNNm9ZSWl1NGZhcUZBZFZsU3luL2o2eFR0YS9ZbG1ST1UzZjY3?=
 =?utf-8?B?alRwVkhmdmhhMEFkNW1HR3YxN2tHci8wTEZ5VXdCd0hGeDlFNjhpRzhxTmdX?=
 =?utf-8?B?d1BZOXNkRFZlU1M4TWprcGVvWG1PK1VuRXhXQktPbmhFM3p2eHVmbkdYdS9l?=
 =?utf-8?B?VEROeW1XSXcrbUIwOG1UN0w5MU4vY3NsSVVuYTdNWTBQb25BdFFuZjNOMnBk?=
 =?utf-8?B?dXdPVG5rbzZ5Mm4rMFhKam5aS3V1V1R5U29IL1ZuSndzSndIRUh5QnhnbEpt?=
 =?utf-8?B?blA1VUkxZXpMengvdm50YWFjbWcwdUZnKzdVbDBvamVSc3pkV3RXc2dEMHc3?=
 =?utf-8?B?YlI5eVhNcnpqQk1vckZNVWJVd2ExZHQrZFJzVUJLWjlUMm5vbmk3OEFGRmND?=
 =?utf-8?B?eFVIUlZKa3dZOVZIVjlUUmY1cU9SV3ZmTzZpT0FNWWM2dXdWcHNkbE9HUFo2?=
 =?utf-8?B?a3NUdWV3WDN0ZHV2RWRhcFBYakluWENSVW1Rc2U2eVdTcEV2cGlZRS9nWXdD?=
 =?utf-8?B?T21XRVB5ZTFDOCtvemlRUHhPMWIyckJZRGxTRmZlb0JOdDhkTzlzV010K1ZG?=
 =?utf-8?B?cWZyY0JhanduY1RQa25SVWVQM3JVVUl0M2dBQ1pPbzJFVlNjbmNPT1Rkd1lZ?=
 =?utf-8?B?M2NuM1NROTk0TWJaNTRFN2I5WkkzbUp2V0FEalJFR21NTFRrSUZ2M3Z4bUZv?=
 =?utf-8?B?WkNiQyt5YWtvVHI5Qjh0VW9xcXFnd3ZLYlZVeWtCcW1ZdFYzVUVlL0VRZHdK?=
 =?utf-8?B?QkF0ZkEzZStDUGZ5MUJGVVRSdEdNZDc1U0lHbll1L0J0Y2MzdzdLai9hYm9E?=
 =?utf-8?B?eUtMVmFpTHFwL2N2QWV1ei8rblJQWDJqbHVVazhVQklaelZ6UDh3VEplNnVi?=
 =?utf-8?B?ak0raDUyc3pMUlhUaUtFK3pMZk1wL0c2alg5cEZVdytWcU9aWTJRYmpWME9K?=
 =?utf-8?B?bTVwOGIyUG84UmppVHg3NTErQXlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B04769DC7F8434EBBE3EB803AD3D77C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f4aa84-8b56-4e5f-dc44-08dd659bf84b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 21:37:51.6164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 474r3ZLuWsXg20noRaNh0CrPBjQEf8ep+0Q3QSBaAe+DWCckh9q0voW0VohB13ZgpKmAFsaLI6fNN4u81saRXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5519

T24gTW9uLCAyMDI1LTAzLTE3IGF0IDE3OjM2IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gTW9uLCAyMDI1LTAzLTE3IGF0IDIxOjI4ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gTW9uLCAyMDI1LTAzLTE3IGF0IDE3OjAwIC0wNDAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IFdpdGggdGhlIG1vdmUgdG8gaGF2aW5nIHN1bnJwYyBjbGllbnQgeHBydHMgbm90
IGhvbGQgYWN0aXZlDQo+ID4gPiByZWZlcmVuY2VzDQo+ID4gPiB0byB0aGUgbmV0IG5hbWVzcGFj
ZSwgdGhlcmUgaXMgbm8gbmVlZCB0byB1cGdyYWRlIHRoZSBzb2NrZXQncw0KPiA+ID4gcmVmZXJl
bmNlDQo+ID4gPiBpbiB4c19jcmVhdGVfc29jay4gSnVzdCBrZWVwIHRoZSBwYXNzaXZlIHJlZmVy
ZW5jZSBpbnN0ZWFkLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8
amxheXRvbkBrZXJuZWwub3JnPg0KPiA+ID4gLS0tDQo+ID4gPiDCoG5ldC9zdW5ycGMveHBydHNv
Y2suYyB8IDMgLS0tDQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQ0KPiA+
ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94cHJ0c29jay5jIGIvbmV0L3N1bnJw
Yy94cHJ0c29jay5jDQo+ID4gPiBpbmRleA0KPiA+ID4gODNjYzA5NTg0NmQzNTZmMjRhZWQyNmUy
Zjk4NTI1NjYyYTZjZmYxZi4uMGMzZDc1NTJmNzcyZDZmODQ3N2EzYWUNCj4gPiA+IGQ4ZjANCj4g
PiA+IGM1MTNiNjJjZGY1ODkgMTAwNjQ0DQo+ID4gPiAtLS0gYS9uZXQvc3VucnBjL3hwcnRzb2Nr
LmMNCj4gPiA+ICsrKyBiL25ldC9zdW5ycGMveHBydHNvY2suYw0KPiA+ID4gQEAgLTE5NDEsOSAr
MTk0MSw2IEBAIHN0YXRpYyBzdHJ1Y3Qgc29ja2V0ICp4c19jcmVhdGVfc29jayhzdHJ1Y3QNCj4g
PiA+IHJwY194cHJ0ICp4cHJ0LA0KPiA+ID4gwqAJCWdvdG8gb3V0Ow0KPiA+ID4gwqAJfQ0KPiA+
ID4gwqANCj4gPiA+IC0JaWYgKHByb3RvY29sID09IElQUFJPVE9fVENQKQ0KPiA+ID4gLQkJc2tf
bmV0X3JlZmNudF91cGdyYWRlKHNvY2stPnNrKTsNCj4gPiA+IC0NCj4gPiA+IMKgCWZpbHAgPSBz
b2NrX2FsbG9jX2ZpbGUoc29jaywgT19OT05CTE9DSywgTlVMTCk7DQo+ID4gPiDCoAlpZiAoSVNf
RVJSKGZpbHApKQ0KPiA+ID4gwqAJCXJldHVybiBFUlJfQ0FTVChmaWxwKTsNCj4gPiA+IA0KPiA+
IA0KPiA+IElzIHRoaXMgbm90IGdvaW5nIHRvIHJlaW50cm9kdWNlIHRoZSBidWcgZGVzY3JpYmVk
IGJ5DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzY3YjcyYWViLjA1MGEwMjIw
LjE0ZDg2ZC4wMjgzLkdBRUBnb29nbGUuY29tL1QvI3UNCj4gPiA/DQo+ID4gDQo+ID4gQXMgSSB1
bmRlcnN0YW5kIGl0LCB0aGUgcHJvYmxlbSBoYXMgbm90aGluZyB0byBkbyB3aXRoIHdoZXRoZXIg
b3INCj4gPiBub3QNCj4gPiBORlMgb3IgdGhlIFJQQyBsYXllciBob2xkcyBhIHJlZmVyZW5jZSB0
byB0aGUgbmV0IG5hbWVzcGFjZSwgYnV0DQo+ID4gcmF0aGVyDQo+ID4gd2hldGhlciB0aGVyZSBh
cmUgc3RpbGwgcGFja2V0cyBpbiB0aGUgc29ja2V0IHF1ZXVlcyBhdCB0aGUgdGltZQ0KPiA+IHdo
ZW4NCj4gPiB0aGF0IG5ldCBuYW1lc3BhY2UgaXMgYmVpbmcgZnJlZWQuDQo+ID4gDQo+ID4gDQo+
IA0KPiBJIGRvbid0IHRoaW5rIHNvLiBUaGF0IHN5emthbGxlciByZXBvcnQgd2FzIGNsb3NlZCBi
eSB0aGlzIHBhdGNoOg0KPiANCj4gwqDCoMKgIDVjNzBlYjVjNTkzZCBuZXQ6IGJldHRlciB0cmFj
ayBrZXJuZWwgc29ja2V0cyBsaWZldGltZQ0KPiANCj4gVGhhdCBzYXlzOg0KPiANCj4gwqDCoMKg
ICJUbyBmaXggdGhpcywgbWFrZSBzdXJlIHRoYXQga2VybmVsIHNvY2tldHMgb3duIGEgcmVmZXJl
bmNlIG9uDQo+IG5ldA0KPiBwYXNzaXZlLiINCj4gDQo+IFdpdGggdGhpcywgd2Ugc3RpbGwgZG8g
a2VlcCBhIHBhc3NpdmUgcmVmZXJlbmNlIG9uIHRoZSBuZXQgaW4gdGhlDQo+IHNvY2tldCwgd2hp
Y2ggSSB0aGluayBpcyBlbm91Z2guDQoNCk5vLiBZb3UganVzdCByZW1vdmVkIHRoYXQgYnkgcmV2
ZXJ0aW5nIHRoZSBwYXRjaCB0aGF0IGFzc2lnbnMgdGhlDQpwYXNzaXZlIHJlZmVyZW5jZS4NCg0K
PiANCj4gVGhhdCBzYWlkLCBJJ2QgYXBwcmVjaWF0ZSBhIGxvb2sgYXQgdGhpcyBmcm9tIHRoZSBu
ZXRkZXYgZm9sa3MuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K

