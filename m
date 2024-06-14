Return-Path: <linux-nfs+bounces-3848-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3196690931B
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 21:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8B91C21C53
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 19:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD57195964;
	Fri, 14 Jun 2024 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="QoiA+YHW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2091.outbound.protection.outlook.com [40.107.102.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B617C72
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395168; cv=fail; b=exG8TX8iVjeLHAfRPIZLcCSmHPwDXvEcBiwdsUCLsRG8KWIzWBJNoFNxLf/fvCR/M5KO26O6+ciA21wVWVT/3QKdUOLKA6M2paqbS0HgXBLCs7qutDP4AeUZTpqIPElpoAZxr8j94VwGdp1KqjISIkgvRbRyirYEG9UHzFGJzWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395168; c=relaxed/simple;
	bh=OkREn38zj3jI8/gw4GeRY5NOPKCCXH5cRslCAZvs6eY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C9cjs1Xbyv+g4PNK8JwV0oeQavGrHwZNQDR4lVJ1d5Jd06Z8AVv+PPIY0hKduNMBpTWaQtICqBoJ+/nZ6hVNB3wPwck5eLS6RBKmquHQGj24s9vElH+XHcX0PbYeBsl8us9y8yoj14XOUdPLgU0hi8FzZonY9NhvxwVKWUvikAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=QoiA+YHW; arc=fail smtp.client-ip=40.107.102.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lh6TdhPyN35FSIDjCoA+BUFBm/mjKdo45IaFvkdRqxOT72Yzwlkt2rTrcR3pnsurfd43pGafKGD+QT09ZzjFda6M1TIxDouls5R3dycjX6AA1WXtI6b5ro7UPT3/FoSGj/UReNpuFvT73s08sH6hDoZhSSUJqNcvVjMlS6Vow4q3cvAOVZXZHqFnfIbT+DIyn7OCVozkqsyYtR7DoZpXwKzIz5Pu9YXJbSsqjbz8cd0aQrl289UUiXDRJ++VEPGOScNvjrXCjgrMUBPBnhPIV1l6sus5KeRxueYCXS1Ny5XIFWu8vW5zKnJLXwdthoA5kic0ZqCdAtIqizmKircMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkREn38zj3jI8/gw4GeRY5NOPKCCXH5cRslCAZvs6eY=;
 b=nZKFNsr0eEGJndt/qD65fam24K6pqgF7HoZvsLeTTYKE46e2ys4RJX34Nu4/QqUn3OO031/0a7w40V4/sYKSroMa9UVJnMHIiXlcJsFuA3/CWPirZjwhp/zbacyGglryFBdXd3hj0l0d2uggD4HeXWSedWv5BDDLs++j7+xryRE8O+nXUYTHgdMM52pCOI7t2O7wN51bZCA+B0jWTbDTMTSiOQpHftuToZyYP+XArQ0dZdxrodyNG8ydIV4NKT//icyrV74/Avzjg91e1Q/QBZuqVlA6IBu4nYqNX1z7yk/x1+3CdqjvAglCRMmm4EERFMsEGhT7pI+9cKJl4/ayEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkREn38zj3jI8/gw4GeRY5NOPKCCXH5cRslCAZvs6eY=;
 b=QoiA+YHW66ZseQBhuavNXe+Di1Rk/aVlUJ2N90PzUuF4Du99NsLWl8y6nC+VUnidCEyUpnM9QEpULa+3UADLT5PX2cDBrTvau5QM2WrP7ecJsj6NalTDWovVvAGNDwhEKlGrV7jPWqQUFVq1VwcfoLfl59f0bGRegF3eM1+oq4Q=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW3PR13MB3916.namprd13.prod.outlook.com (2603:10b6:303:5e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 19:59:24 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 19:59:23 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 12/19] NFSv4: Fix up delegated attributes in nfs_setattr
Thread-Topic: [PATCH 12/19] NFSv4: Fix up delegated attributes in nfs_setattr
Thread-Index: AQHavUi0gMtnQJb8rUyAZH08NRiFi7HHdl2AgAA5xAA=
Date: Fri, 14 Jun 2024 19:59:23 +0000
Message-ID: <bddef727ec63731061a7c80f477f8dc112085b0a.camel@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-6-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-7-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-8-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-9-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-10-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-11-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-12-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-13-trond.myklebust@hammerspace.com>
	 <CAFX2Jfk7u37+AOX_o1ZRf-QX_abSDXpKaEpHt=iOvL5Bq6opTQ@mail.gmail.com>
In-Reply-To:
 <CAFX2Jfk7u37+AOX_o1ZRf-QX_abSDXpKaEpHt=iOvL5Bq6opTQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW3PR13MB3916:EE_
x-ms-office365-filtering-correlation-id: 62ebb8ec-7136-4f54-46c5-08dc8cac7cde
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1EvUUlyWHkwWEJNdUNVVnBOajc3NkRUNTlVOGZZRHBPM2szQitHcGJ1ZG92?=
 =?utf-8?B?cE1namk4T0srZGJvSzBsc21hajJrWmZQMUxCMXZRNHlzbWpIUndvdlFjSHI3?=
 =?utf-8?B?NTNnSUVZQ3o3ZXRka0c2c1pUUFliVUwvN2g4ZTVCYjJ1OUMzZm5paGZhV3Q0?=
 =?utf-8?B?U2Zlalg3TnQ2L0NmVldYMHZ0aGcwRHlnRlh6UTFQbjZjNWZrcDZKTEx1MXNE?=
 =?utf-8?B?ZmcrekFua2t5VjlFRHVHMGRreHc2QktmTVBDOG5uaE43RzJja0pHWGlyUUpw?=
 =?utf-8?B?ZEpvdFJjaXN3VDUzeXVFTkxiaUFCZWZPQ3VSeHJCM1FlcGRScFRnejl5TGw3?=
 =?utf-8?B?MkRJQzhnbTBaejVGWTQ0R3Y5bUJhSkRKK3pYWUp4UnQvK2xoeldmUklJZlht?=
 =?utf-8?B?am9mcFhSOExLQzRmd3ZOejZObzlCY3dudGRpempIeWREU2RNd2xveHpXRHc5?=
 =?utf-8?B?OW55WUMwK1hBYXBUQ1NKdDdoN2N6ZWVNVTB3N1g2QmpxVWRJN1o3UGtqNUZn?=
 =?utf-8?B?cUZUdnpvQTVGUnBvaFM2bnpEdDlYelNoVkZGUFdIWmRQVlJ5TklMMmZENEUx?=
 =?utf-8?B?Qkdic1E1VUIzbUcrTEJwczlIbWswQzR0U3ZXK1c0by9QSS9acU1pVTQ3Uysx?=
 =?utf-8?B?TW1LeE5HdGpBQ2RiRUNBZDJkSXVOVWdOTFpXa0tkeWkydzVPbkljQ0tCbjBZ?=
 =?utf-8?B?SFNnOW9ka3ZlTlg1eGRCREJrekhLd0Z1NHlkNVFkSi9nM252YkJyOXdnSjB0?=
 =?utf-8?B?TUpkRUNHZnkyN01ZVS9qS09Dd1NkalZQRlcvMGp0WEFESHozRm5CeHF0Ym9n?=
 =?utf-8?B?dmc3c2U5bGJmTWNnQStoRldJQnFCVE9Sek1FaDNZdkRKYjRZRGpUcTByT29k?=
 =?utf-8?B?R3VjYUZmK3JGWFlGU2pxNm11ZWluZ2dQa3pheEpwelMzTDNhcWY3L3dyRm0r?=
 =?utf-8?B?YWdsMzQ5N2lJYkFRZG81aEI2NG1LcHU2Q3YycFRBT0lMekwycEdzNmJxRHA4?=
 =?utf-8?B?WWlvSFJYc2FpbkR6OExPdDBjQk0rMmtwWklmaWxiTE14QmdNV2xXV2c5dHBz?=
 =?utf-8?B?Qk1rMmJ4VGU1ektUOGg4S0J5U0Jjc05rczZXZkhwMTgyOXdTS0M5Wk5EN2Mw?=
 =?utf-8?B?b2tQOGpUK3RLR2pSaE5vaXB2b2h0c0l0TGxSSVpIbG5oWHBKWmFKaDNyZVB6?=
 =?utf-8?B?ZCtVekMrU0g1WDBTUTI2WGhSWGlGV3h3VzdnS0RNL3V5SjFxMlRpWkl4QStJ?=
 =?utf-8?B?OFE2N1VTQnFZT1Vudzc1TFprM3JHSkVkbkVjWkxYa1R1VmtYQmNnK2twUFFh?=
 =?utf-8?B?ei9lODFsUkJrMklaRVBObjg4VXE2T0hvMUlqa2s3bzN5ODlPRjVIYzNYYW1R?=
 =?utf-8?B?UHhnM2JTa1hBMnpXbDZPNWY0YmRzUkVqU3J3ejBWQStXZ3h5eUdudjljM2ZN?=
 =?utf-8?B?bFgxRTFUS1E0WEZDbSt3cWphRitFTUF1bFR6TVR1Z3cySzMzVlJUMHFCalNi?=
 =?utf-8?B?RUl4STBDdFovWXN4S2wzdERIbmczV1FPaDhWTjFDZnBSbGhQNkFnZUl3clFS?=
 =?utf-8?B?UjNHUEJ5MjhXMDJGTnY3TUFodzVCQWllT0g5ZS9uMHpMNWg1N3hKa2VDdEdW?=
 =?utf-8?B?QkpLUXhheVVNaktkbUNSSTZoTE1mcWdrZ0RXaEpVTWxQYUE0UTU2bEhXL1VI?=
 =?utf-8?B?T1RVckpiYUlBaGdjSHNzQis0YU5UWmYyczl0bUsyRHNZWjNHeE9reE1ORkNT?=
 =?utf-8?B?TWhqYWR6cDJ0d1pkckxZZFlFNnVLTzl0TGN0ZUlPMlF3TXZvTzlNK2lIZTg4?=
 =?utf-8?Q?R+4p4nr4Fu/1QpEHma9SJfn0f9R/fxpBxn0HY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFdrNnFkRVJUR250cVF2a2xackJ0bVlGQmNBQldvQXhXWkhwOGVadTB3YmRK?=
 =?utf-8?B?QmlWTEVTZkJkdVBreXhlWFBrYldxWG8xbitGMXIyM0RhYWM1RFZxdUxVcDRJ?=
 =?utf-8?B?dHdpZnFKVTJsUTRFcnp2NStRN0VZQlArYW5pU0p4MkdIVU1zYmNranFmbTR2?=
 =?utf-8?B?cGRJbEtZUGQzNlhkMlhEcFljSGc1T2ROeWhQenlFc2c0MXFnZXZwdTVXOHZa?=
 =?utf-8?B?ZzFIYVJiTUxoY2Y2bmpMK2dPa25FeUQvNzhhUHJSdkNpNHBSSjVwLzZTQUhB?=
 =?utf-8?B?cHF4R0lnUDJNRzVBcGsvYUYzZ0J5SXF3bzBrSk1jdmJQeVlIY3BDbEtpWkpK?=
 =?utf-8?B?WEM2UWRaQ25lN2hvWFhzZnVFNGlka05rRW14KzAzYlM2MFE0K2dmWG9DbTJT?=
 =?utf-8?B?WlRJQmhMbDhkRW5mcU9GaC9XSGZlVkpFZmNZaXQ3M0tpcnJLSmx1a2ZwSmR5?=
 =?utf-8?B?MzEwY2RqUTBWcTE2QjhtQWI4cWdSc2JYM1lOdW1jUkdlWWlwRzRncHE5RDdq?=
 =?utf-8?B?UU9ESGZmL1lLYVRBUkFqMnZVVk5PT2ErK2JxSy9aZkZ4OW1idlR2KzR0dnRB?=
 =?utf-8?B?RlR1dlF1Y1poYnd0bFZGOXZ5THBCNkdGSEEwdkVySXIxT01uNExuU0pjY3lG?=
 =?utf-8?B?cnJUQThLZ2JwM2p5ZXNITmVqMms2ZFNoeWQ4bWl5MXpoQWNud3dWc2hvME5o?=
 =?utf-8?B?QjkzOW1yblFyV0JEUUFvbThTVE91QWVmTWhFSGkwZ1JOQzZSY2xkUVFoWExu?=
 =?utf-8?B?eng4V045SnZKSW45TEhPU0JUcUFRUmlRZEJrd2Q1M25ac1BvMC82Tkw5YXRH?=
 =?utf-8?B?NkUyTUR1bWlPQzF1akV0UG1UTTBZdTBIUjZMbWZEV0ZKQnlyUGNrOGNsVDlz?=
 =?utf-8?B?MzI3bWc2Y3hWNlh3elUyN3IrdXBSd3lRdEs4dHhoODYrZk9SeG5kdWZMdkNZ?=
 =?utf-8?B?Wms2d1p3YytDdWVhZzB2R21ZaE53ZUJZdm1QaXRLMTllb0lRZ0xlcTlQQkh2?=
 =?utf-8?B?YjA0b1FSa25XWktIZUJ1TUYzQ1plaGxLNE1FMWZqcmRXUGNEeWszL2xVNlNs?=
 =?utf-8?B?SG05ODJZNkZyZjZhT2RLMWNPQTRIV3hmdVlBUFlQaUhZVnhuOEhxVHE3T2Fu?=
 =?utf-8?B?OU9OWTVSZ1RXZWJhSjhzMEpacEN1K0FhdkhiYWpQZXRKai9Ea2RuTXZvaUZr?=
 =?utf-8?B?Y1lMWU82QTVhellGMFBkMjBldWRqZzZDK3h4T3NFQ1VrZHZVdWwyOE5hMGJO?=
 =?utf-8?B?ZTMwMWU5MFlDSHp4eTlqZnhrKzRzc3crRjBZaHlHZjdOVXNDVlRua1NqUGJh?=
 =?utf-8?B?dE8yQVpNSWw2d1d5K2QwYzN5bVBxcDVydnkvek5TWklKQ2ptR2tncjl5SjVE?=
 =?utf-8?B?Vk9HSjB5TndCVGpSNmNaMStzdE5iVW5JekdLZ0pkaXo5QStYL01PY1YvOHpM?=
 =?utf-8?B?TnpFRzFqbkUwaXM5YWgrNUhNL2h3QUpuWmpIUU01NmIyTENQQjEzU3VjWmo4?=
 =?utf-8?B?eWhSb3F2WURoUkp6aE5YS01HQ1Z1MlBVQlFYdk11T2g3dTVFM1plMWFQSlhL?=
 =?utf-8?B?emxEVnM3bWJSRHBneVVYWnFTMjdyN2hqdGs4bDZJMXRrb0RZSFdHc1hRbGFF?=
 =?utf-8?B?S1ZBZlZCLzg0cHp6aGI2QkUwVi9KeGIyUDkwL0txRnJoekNtLzI4SDBDdzVO?=
 =?utf-8?B?YkxiK1JpRjRITUYvTzBkZVJnSEo3MnQrQ2J3ZXFkbGYrTG0zOFU4ZW9WRmdz?=
 =?utf-8?B?SmowRERmdW85VVo0VjM0c3VuOWxHSXdHSzBCcnNPVVRpZnlhQUpqRmxxcm1L?=
 =?utf-8?B?SUZkWGRLQzRBczh0dUJWZXpSVXhEdE1oSzBwNzQ1cVRuS054Qk91eEtmUkla?=
 =?utf-8?B?bUgrWVFHaklrY0FpTHI4d1EzNURXSjBhbFd3MTdNOWRKRzdXczBJWXJob2NU?=
 =?utf-8?B?NERjSzZMYlEzUjEzZzI5bS9PdTVqajR6T0VDam9DNWxyRldZc0dQMHRTbGFR?=
 =?utf-8?B?aG83RVJrY015UHlIMGlFU3Z3MFRMU3MxcGNmQXpIZm9NZ1BIUlltZDIzdWYv?=
 =?utf-8?B?MHh3WTZCcXZ6M0V5VWNPRlJxcXRNSVN6dlE2NGh4eXo0QnRKUHpXM2Z0WXhR?=
 =?utf-8?B?MS9TSEdqUml2ZXpNcnlORklqbk1VWlBwZThxOTU2T2UzYzREWlBXR1JlTGw1?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9576447DEAAD9F4F940A5805C12AD1C7@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ebb8ec-7136-4f54-46c5-08dc8cac7cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 19:59:23.6864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5Mm2jsHD250fcCoR0KvXRAQthd6FeoNNIPbTXYDB7U/xeIuc3LSZ66ho2mN2W+pak4PYZC0zzHMBlEMtqa41w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB3916

T24gRnJpLCAyMDI0LTA2LTE0IGF0IDEyOjMyIC0wNDAwLCBBbm5hIFNjaHVtYWtlciB3cm90ZToK
PiBIaSBUcm9uZCwKPiAKPiBPbiBUaHUsIEp1biAxMywgMjAyNCBhdCAxMjoxOOKAr0FNIDx0cm9u
ZG15QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiAKPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJv
bmQubXlrbGVidXN0QHByaW1hcnlkYXRhLmNvbT4KPiA+IAo+ID4gbmZzX3NldGF0dHIgY2FsbHMg
bmZzX3VwZGF0ZV9pbm9kZSgpIGRpcmVjdGx5LCBzbyB3ZSBoYXZlIHRvIHJlc2V0Cj4gPiB0aGUK
PiA+IG0vY3RpbWUgdGhlcmUuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVz
dCA8dHJvbmQubXlrbGVidXN0QHByaW1hcnlkYXRhLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IExh
bmNlIFNoZWx0b24gPGxhbmNlLnNoZWx0b25AaGFtbWVyc3BhY2UuY29tPgo+ID4gU2lnbmVkLW9m
Zi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPgo+
ID4gLS0tCj4gPiDCoGZzL25mcy9pbm9kZS5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKwo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygr
KQo+IAo+IEFmdGVyIGFwcGx5aW5nIHRoaXMgcGF0Y2ggSSBzZWUgYSBoYW5kZnVsIG9mIG5ldyBm
YWlsdXJlcyBvbgo+IHhmc3Rlc3RzOgo+IGdlbmVyaWMvMDc1LCBnZW5lcmljLzA4NiwgZ2VuZXJp
Yy8xMTIsIGdlbmVyaWMvMzMyLCBnZW5lcmljLzM0NiwKPiBnZW5lcmljLzY0NywgYW5kIGdlbmVy
aWMvNzI5LiBJIHNlZSB0aGUgZmlyc3QgZml2ZSBvbiBORlMgdjQuMiwgYnV0Cj4gNjQ3IGFuZCA3
MjkgYm90aCBmYWlsIG9uIHY0LjEgaW4gYWRkaXRpb24gdG8gdjQuMi4KClRoYW5rcyBBbm5hIQoK
WWVzLCBJIHRoaW5rIHRoYXQgaXMgYSBjb25zZXF1ZW5jZSBvZiB0aGUgY2hhbmdlcyB0aGF0IHdl
cmUgbWFkZSBpbgpjb21taXQgY2M3ZjJkYWU2M2JjICgiTkZTOiBEb24ndCBzdG9yZSBORlNfSU5P
X1JFVkFMX0ZPUkNFRCIpLiBJIGNhbgpqdXN0IHJlbW92ZSB0aGF0ICJpZiAoIShjYWNoZV92YWxp
ZGl0eSAmIE5GU19JTk9fUkVWQUxfRk9SQ0VEKSkiCmFsdG9nZXRoZXIgd2l0aCB0aGF0IGNoYW5n
ZSBhcHBsaWVkLgoKVmVyc2lvbiAyIHdpbGwgYmUgZm9ydGhjb21pbmcuCgo+IAo+IEkgaG9wZSB0
aGlzIGhlbHBzIQo+IEFubmEKPiAKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9pbm9kZS5j
IGIvZnMvbmZzL2lub2RlLmMKPiA+IGluZGV4IDkxYzBhZWFmNmMxZS4uZTAzYzUxMmM4NTM1IDEw
MDY0NAo+ID4gLS0tIGEvZnMvbmZzL2lub2RlLmMKPiA+ICsrKyBiL2ZzL25mcy9pbm9kZS5jCj4g
PiBAQCAtNjA1LDYgKzYwNSw0NiBAQCBuZnNfZmhnZXQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwg
c3RydWN0Cj4gPiBuZnNfZmggKmZoLCBzdHJ1Y3QgbmZzX2ZhdHRyICpmYXR0cikKPiA+IMKgfQo+
ID4gwqBFWFBPUlRfU1lNQk9MX0dQTChuZnNfZmhnZXQpOwo+ID4gCj4gPiArc3RhdGljIHZvaWQK
PiA+ICtuZnNfZmF0dHJfZml4dXBfZGVsZWdhdGVkKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVj
dCBuZnNfZmF0dHIKPiA+ICpmYXR0cikKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgIHVuc2lnbmVk
IGxvbmcgY2FjaGVfdmFsaWRpdHkgPSBORlNfSShpbm9kZSktCj4gPiA+Y2FjaGVfdmFsaWRpdHk7
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIGlmICghbmZzX2hhdmVfcmVhZF9vcl93cml0ZV9kZWxl
Z2F0aW9uKGlub2RlKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsK
PiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKCEoY2FjaGVfdmFsaWRpdHkgJiBORlNfSU5PX1JF
VkFMX0ZPUkNFRCkpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYWNoZV92YWxp
ZGl0eSAmPSB+KE5GU19JTk9fSU5WQUxJRF9BVElNRQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IE5GU19JTk9fSU5WQUxJ
RF9DSEFOR0UKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCBORlNfSU5PX0lOVkFMSURfQ1RJTUUKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBORlNf
SU5PX0lOVkFMSURfTVRJTUUKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBORlNfSU5PX0lOVkFMSURfU0laRSk7Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgIGlmICghKGNhY2hlX3ZhbGlkaXR5ICYgTkZTX0lOT19JTlZBTElE
X1NJWkUpKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmF0dHItPnZhbGlkICY9
IH4oTkZTX0FUVFJfRkFUVFJfUFJFU0laRQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IE5GU19BVFRSX0ZBVFRSX1NJWkUp
Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoIShjYWNoZV92YWxpZGl0eSAmIE5GU19JTk9f
SU5WQUxJRF9DSEFOR0UpKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmF0dHIt
PnZhbGlkICY9IH4oTkZTX0FUVFJfRkFUVFJfUFJFQ0hBTkdFCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgTkZTX0FUVFJf
RkFUVFJfQ0hBTkdFKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKG5mc19oYXZlX2RlbGVn
YXRlZF9tdGltZShpbm9kZSkpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
ICghKGNhY2hlX3ZhbGlkaXR5ICYgTkZTX0lOT19JTlZBTElEX0NUSU1FKSkKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmYXR0ci0+dmFsaWQgJj0gfihO
RlNfQVRUUl9GQVRUUl9QUkVDVElNRQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBORlNfQVRU
Ul9GQVRUUl9DVElNRSk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoIShjYWNoZV92YWxpZGl0eSAmIE5GU19JTk9fSU5WQUxJRF9NVElNRSkpCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmF0dHItPnZhbGlkICY9IH4o
TkZTX0FUVFJfRkFUVFJfUFJFTVRJTUUKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgTkZTX0FU
VFJfRkFUVFJfTVRJTUUpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKCEoY2FjaGVfdmFsaWRpdHkgJiBORlNfSU5PX0lOVkFMSURfQVRJTUUpKQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhdHRyLT52YWxpZCAmPSB+
TkZTX0FUVFJfRkFUVFJfQVRJTUU7Cj4gPiArwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAobmZzX2hh
dmVfZGVsZWdhdGVkX2F0aW1lKGlub2RlKSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKCEoY2FjaGVfdmFsaWRpdHkgJiBORlNfSU5PX0lOVkFMSURfQVRJTUUpKQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhdHRyLT52YWxp
ZCAmPSB+TkZTX0FUVFJfRkFUVFJfQVRJTUU7Cj4gPiArwqDCoMKgwqDCoMKgIH0KPiA+ICt9Cj4g
PiArCj4gPiDCoHZvaWQgbmZzX3VwZGF0ZV9kZWxlZ2F0ZWRfYXRpbWUoc3RydWN0IGlub2RlICpp
bm9kZSkKPiA+IMKgewo+ID4gwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZpbm9kZS0+aV9sb2Nr
KTsKPiA+IEBAIC0yMTYzLDYgKzIyMDMsOSBAQCBzdGF0aWMgaW50IG5mc191cGRhdGVfaW5vZGUo
c3RydWN0IGlub2RlCj4gPiAqaW5vZGUsIHN0cnVjdCBuZnNfZmF0dHIgKmZhdHRyKQo+ID4gwqDC
oMKgwqDCoMKgwqDCoCAqLwo+ID4gwqDCoMKgwqDCoMKgwqAgbmZzaS0+cmVhZF9jYWNoZV9qaWZm
aWVzID0gZmF0dHItPnRpbWVfc3RhcnQ7Cj4gPiAKPiA+ICvCoMKgwqDCoMKgwqAgLyogRml4IHVw
IGFueSBkZWxlZ2F0ZWQgYXR0cmlidXRlcyBpbiB0aGUgc3RydWN0IG5mc19mYXR0cgo+ID4gKi8K
PiA+ICvCoMKgwqDCoMKgwqAgbmZzX2ZhdHRyX2ZpeHVwX2RlbGVnYXRlZChpbm9kZSwgZmF0dHIp
Owo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqAgc2F2ZV9jYWNoZV92YWxpZGl0eSA9IG5mc2ktPmNh
Y2hlX3ZhbGlkaXR5Owo+ID4gwqDCoMKgwqDCoMKgwqAgbmZzaS0+Y2FjaGVfdmFsaWRpdHkgJj0g
fihORlNfSU5PX0lOVkFMSURfQVRUUgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IE5GU19JTk9fSU5WQUxJRF9BVElNRQo+ID4gLS0KPiA+IDIuNDUu
Mgo+ID4gCj4gPiAKCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK

