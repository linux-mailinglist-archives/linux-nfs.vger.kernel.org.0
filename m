Return-Path: <linux-nfs+bounces-10666-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250EA680D3
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 00:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FCE3B5635
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 23:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739BC2080FB;
	Tue, 18 Mar 2025 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="CRejs4+K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC220765F
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341214; cv=fail; b=ruM9JKHtR/DClBOvZn1xpjvfBu2UY8A4aCfdVYdXf4R8nXQ7OXzUT0XOmflH2u1LJpZ3mcLs8iUUt9D45gVaWFkty7QyAQr8CkNkfX45WGWkRuhplN1/+YMzvAFKumeOEAE2gIf+xNjDpb/G/kSh59faoAd/vqWHVx5NZYv53OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341214; c=relaxed/simple;
	bh=WcXfwLYxSnhFKTOKNlYTqTZR/YSONIZnA7DZTGpBnL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uzvy3wdf7QTnWIdecl/89BhbADylC3FnxGomiNkWd2vA7bHFZUESZE3kq17DztVJxYOQelzhwhwQt6J2Odnsk8OEBWV6+1/Ai0ZK5hJXbg2szJCUsw+KJaHJOi5D4mTtDnACq85pOlcDQZgZ6R1tBfB6XvK1TYcm0+pS+xjPZd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=CRejs4+K; arc=fail smtp.client-ip=40.107.223.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbiBTQPeH18XJY5z/POBoKWZNR34HBBwjMpyO1WfGtMSYU3Anplas/3P38IHKv3LIQ73vhoznzKGvaIS7kLooL+eXTkPUUKAiYBprCvtwTaVDT3WR7MfhI9teYaHuEmAKEExhQ4GRj52D2HrfOCEgDf+R9PfkJpsXTzYfyiakgEMfU4MtkW+8taacoNrnH38tow/KmEXb6sviA7RPPEPriAt80d+vx7GLjXl4HnhZygNa9SB3bhe9cVNF2HRiMfuVLYNlJwQKzrSYAAKeNJ/t6jPoM0SFBJz2chbe9f4PxEPFqz4nP1tpsZtBExnrT3ny41XI6CZCJkPoBcgHVP+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcXfwLYxSnhFKTOKNlYTqTZR/YSONIZnA7DZTGpBnL8=;
 b=Q7FKWQb2f0s8kQegOa6wvIdm90Pyd4IWTsGY4BREZOVW2QsPo/WgVS0ClzNJ7JKNMzvm4mr2DPzXh79ukA3iuBkTu9gh8n3RYAy7XIsjUujoGOU4SGRSfYLtzFROP3mRFYqyn27samfKOh5TqLwTi6O6iUT/Kb/42hxuNHFjzbqL+7RlWPv870Ky41UTax8/yNQ8lTBUSHNPlonzaMAVoS4OiOhZUV5MmMHfBsKI/362eKMeBdEylJENOcHPCGk4UvyVvnOwc0bYJUFL4Hjgk1yuH6ti95R9+VQ6Xfa/rGvLcuibbmZY3pdAmE9SvVpOX1ZZcMV/QeSFDbk6BNIH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcXfwLYxSnhFKTOKNlYTqTZR/YSONIZnA7DZTGpBnL8=;
 b=CRejs4+KyU6KAY66p9mOzERpaw9VywcarNya1GouLw5R66e8ikULyPXw61j7Yep8u6K7SBUoT7Mpdr+7m8dIVgRi3z64rr/vo047bcu9ZuEi6WhJ7uhuKgaper/7u6sDyzDRm9GPvxbvOTwzEhA6JeL0i2pydZeFQ5qHzNulPNY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3710.namprd13.prod.outlook.com (2603:10b6:208:1ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 23:40:08 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 23:40:07 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "lionelcons1972@gmail.com" <lionelcons1972@gmail.com>
CC: "rick.macklem@gmail.com" <rick.macklem@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>,
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
Thread-Topic: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
Thread-Index:
 AQHbmBa5xy/j3c2GaUCylZ3htsCWqbN4/18AgAAOAgCAAFTsgIAAA8+AgAAWQoCAABGcAA==
Date: Tue, 18 Mar 2025 23:40:07 +0000
Message-ID: <e21645871fd6249d93f9bb33b154c3663eaf0a70.camel@hammerspace.com>
References:
 <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
	 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com>
	 <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
	 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com>
	 <e674d6ec96cc8598b079efd3b93612537f840a87.camel@hammerspace.com>
	 <CAPJSo4WrOnWfLzmfoCcj1MuYQQBHo434vTK=9qx+rh_FCVck=w@mail.gmail.com>
In-Reply-To:
 <CAPJSo4WrOnWfLzmfoCcj1MuYQQBHo434vTK=9qx+rh_FCVck=w@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB3710:EE_
x-ms-office365-filtering-correlation-id: a5db0e87-3f75-452f-5a15-08dd6676372d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWJwVkJpWFBmT2lOWWJYT1lsR3g5UU0yNjA5Z2NYZWJuQWdhOGFvZk8rd1dh?=
 =?utf-8?B?Mjc2eWtOMm5lb01KNytMZDRxOHRYY01menN6K0xXWThWVjdvZVVLU2NQRWNx?=
 =?utf-8?B?SWpIQjNjcWVwMnpNZDFUMWxETjdReXpiR1BTNjdhSEcwc2d5ZWM0VE1uSHN0?=
 =?utf-8?B?T2hSeXBjeGZ4MEZxemtUTlhBZHhhUUxQQzdLdnNHemJEMVg2WUMyakFMUjhv?=
 =?utf-8?B?N2lpaEVETlB6NmZkVDlUNXdDY2MzdUFsVkF6WUQ4U01xdklVRTFFTWVoT2lm?=
 =?utf-8?B?ZW5XUlRhR3RFc1FQenZaY0dscWRmdlZkdkYzeEkwa2dHVGJpZEVVN2F0a0RP?=
 =?utf-8?B?dDFZaDh6TTZuOTBDVnpZRjdxZk9qOGtEeTJzUnNCM3UwM2wyMzZDSEgrWk1Z?=
 =?utf-8?B?cVRQUUFoeTVlNjBDTHRsTnJZZk5lTVdMOXVJb3g2SDBON01PQ3dLaVJjUkxM?=
 =?utf-8?B?N09mdmxxZnBpZzVjNG9aT3g3d1FhZGhlQjNobHc1dS8xUW15clQzK2N4TWJQ?=
 =?utf-8?B?d3VvVnhJRWRXUGt3VFY0Y1hZUVNPdDJtSW92TnBlMEdTL2hTejBja3c1SVpN?=
 =?utf-8?B?alZlK0R3MDg4SHBrRUJvWWJSUFFhQWNpaGdhQXRiUVppK3p6Um5TSzNyQTFU?=
 =?utf-8?B?OU1lUEFycy9JNFJHRDAzNVdmNzZOZmp1NmwzTmlFWi9RVzZOTTZwazdGVUUy?=
 =?utf-8?B?b2MyeUhodGhaVm5MN3BLdVllSitPTS9MVXoydzNlV3lZZmZlVER0RWU0Z01D?=
 =?utf-8?B?akpLWE1XbHFtUUM0K0ZOQTZnWDJEaS93Yk5QSFQyTnNsVWlBTklZUjJrTHhr?=
 =?utf-8?B?RlNjYkRMeXg4eW1hblRRQTE4STZYalRNRXBKR1ZydzhXRFYxUFdaSHRSVkJp?=
 =?utf-8?B?ZnAxL1EvN1hLSFZKVjUvdTRIWTY5RG9WbjZ5RHRydkRhaUNpcS95RWpMaVp1?=
 =?utf-8?B?Wkk1K3Zaa3VyNDBJUENoQ3gwNWhvVmlJYUZWU2tSUFRya0J1dFR3RVpSZjYx?=
 =?utf-8?B?K0NpRjFtU2Z2dUFTUFNFTUgyZXBVV3U1d3Q0UzRCS1h6QkY4WXJZdnFMb1Zs?=
 =?utf-8?B?b0VxQmk3dDJtYkhDSUI5L0YwQldrMUJSVDNnVEtNMlhZZWEreTY0RWc4NzY1?=
 =?utf-8?B?b01IVmoyQXJhR25ZSE9oQWJ0VzRBU01TL2tNTCtzdHVoVktLU01mZ2FlUWF1?=
 =?utf-8?B?ZGhDY2kxUjFzemdnZVIrTXlMY0JwYkdiOTlhUElWY0F0ZDczYnBvZHpPQ0h6?=
 =?utf-8?B?UTRhOStpSTQydjV6eHd0alA0amlrcXZaczRWOFdRclc1ZVV1Und2NGphRDQv?=
 =?utf-8?B?V25aalB6Z3p0ZWRZRTFQZnpIRUZ2QmFwa1dkUFhHcDZGN1V0KzJtRmt5Vi9Y?=
 =?utf-8?B?KzRnS04vYmhXaWRPMWM2a2d1NDI5MXEyLzhzM0g3UHkwUjBXWS9UcnBRK3k0?=
 =?utf-8?B?NTM3bXladXBka0RyOGZHMGFTalM2Y0J1QW1BOTZkMU1uSG9kTFQrcjdTR1M0?=
 =?utf-8?B?R1IzRFBrZDV0QVhKcWtnaUNQRXgyQTNqaWlyc0F0d0ZhL1RBZXNxb3dBNktP?=
 =?utf-8?B?ZW10YjJhUWt6Q1V0NXloVWZNTU01dUV6RTdZVWRkbEgwYVRUSHluRk1IMEkz?=
 =?utf-8?B?Z1JpQnVqekJBN3BNaW1QK0gyTURJQkRrbC8zSjZsbmxBMHZFL3dpd040aXF0?=
 =?utf-8?B?RWYrSEgwNzdmaUtxVFMyeXdXZm93bzVnQ1YxQjB2Tk5RUlVrSTlZSTI5Vkp2?=
 =?utf-8?B?TVVCNWdZWXc2WHZVM0dtaGdJaUNmellMKzl0cWFvN0hlbUtneEJtajFhTldl?=
 =?utf-8?B?T2VuR0J2TXlueDRUMEEvT00vY2xrVytaWjh5Mk9uU0xLYTVBSDB4U2FGR0tU?=
 =?utf-8?B?QjNOU3lmUEd1MVVQWHlKWFowYlIyZHRBbEFpTmxNNFVkT2dDTjB2SzVMaXFK?=
 =?utf-8?Q?XLebeyDo3HG+x2A5O7Q5CVAKOc0IaYoG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmgrMFNuVFRhWVlObE9XTmVKd3M0ajJsTXVReGFYcjF0SEh0OGg1UC94QjNy?=
 =?utf-8?B?K2xCK0E4UGFYektWeGNjUmZnbFVTdVRMelVFVWl6TEdZT0lybUhTdUk2MVFo?=
 =?utf-8?B?VllhbnlwYlFGM2Z5VUhrdllteWRvc1R3SDliY1V0SDhzMDNPbllWQTV0VDRO?=
 =?utf-8?B?dEtuOXNGSGk4T0dEcUw2MGJlOEJxVzVMZU0rSUhCdDJRVVlhWFdtUVNpSFEr?=
 =?utf-8?B?UlI5V3RFOWdBcFZwYWFqNjdFM2NXblJXVTFZaDRjTlpCOVY5elErRmVWM1pm?=
 =?utf-8?B?VE1ZSktmNllUOE1LVytGeTRIWUxRUytaUG0yQmR6elA0cVlFYnhGTjVia2Mw?=
 =?utf-8?B?QS94Zm9JSk1obUpHTHAyT0FLSjVnRWZpdTZGOWwrUS9xeFcrclY1ZWV4ajky?=
 =?utf-8?B?VGFTZWtiYk5GL3ZOUURscW1DYlFpVUtHeEN1QTJTVzQrT0d1bTVUd21lUThE?=
 =?utf-8?B?MUQ1Smh6MVNSMzBGREtkYWNoRmRPbWtBUHFMZ0QveVJkeUV0ZUkvKzhTUXhz?=
 =?utf-8?B?cXYyWGNXczU3eExmNFI3SkNyUldiT0k1a2dteXBhQk9nbU1SVWcwdGdObDds?=
 =?utf-8?B?T3lLbUlabWh6NG53MFF6cjJPU3lSVW9vTTFNd210b0hvNE5KVUxvcWVIcm9z?=
 =?utf-8?B?S3p1SXRPczZuQVRmVkVoVC9EYW5STHlyT1d6RmhnRHR3M1ZrSGRkMXk2dzFp?=
 =?utf-8?B?Tk9tUDlleUxQb1M1dU9jbm9XYWdjNHlML21mQVUxS2t3cmJwdFNKYkJjdXpl?=
 =?utf-8?B?UTB6STdQdWNzZGp3UGs1QzZ1R0Ewa1NueldiWlE0R1NPVzF3VlVYMHN1QWdJ?=
 =?utf-8?B?VWU3aUdFSEVwYi9qbFRUTWxPdFVoOVVHWThLaER6OTJLeXYrczRTN3RncHpu?=
 =?utf-8?B?K2NJU2RaZFFmY1Fnb3JzdzI3a29Obk5PUHg3ZEJYRGZ3ZW1tVHZSMUw1Tkx5?=
 =?utf-8?B?WDFuei81TEN0KzVxelErY2VydUk5YU5nRWs1WnYzckhNK0E4dGtqMkhINnp1?=
 =?utf-8?B?OE5iZW9ZeE5lOFQzSWM4U1BWQVUxb2ZFODJLTzh5TlJDL2p2cm54YzBKT1U2?=
 =?utf-8?B?Ym5hd1JQaEx6Vm9JQ3pXQjJKY2tQOVJhcXA5TGx5SnlsSHVkbGQ1NVk4TC9p?=
 =?utf-8?B?cmxoMldQczNRQkc1bEpab0hPUFVjRHBhVTJlOHRVNEYzSGk2WmxyVXBRUVF5?=
 =?utf-8?B?NkJ5UGZJVmxqNlFGb2E0N2VJSkdhaGNPYlBIckVNUkpKeUlld2pHWGUvbTd2?=
 =?utf-8?B?VkZDVXdXQnVDNWM4cTJIK2tDcUd6dnNDOTJLQWFNUVhDMW5Yc2RzK2oweVVi?=
 =?utf-8?B?OUZOSE5QeXYxNG9LVFRDSEV0czRlSW9hR00xandVSDI1clpwMmdzMXMwVlBI?=
 =?utf-8?B?a0dNejhubDNVR05mdGhtWUlsZk1wQVo3eFVhL0dNTjhyRVE0UlFPYXlnUmRu?=
 =?utf-8?B?R3NEVVlWOEVTeko2YTlYcW05MENGc3BZdTd6RWkyUzZSbjlGaVQ3VW5uYnNv?=
 =?utf-8?B?UFV6anVIZStnc1FxZVFwOXVqdEw1YlR0RHo0VGpqZHpJTUN4QXV1MnRMS3Ni?=
 =?utf-8?B?WWorNWs0bFBQVXVTdXplUDJsU0Y2QmxlallQdGZrTDNNRXJzakhRMlRZQjcv?=
 =?utf-8?B?TFlNaWVHRVJOZjkycGQ1TGZqUTNmelBORWNsNHpCRkxNUVdPZ3l3R3BuVXNO?=
 =?utf-8?B?YUdsVlBOOVRGNkVCRjJTQ0sxQnQ2b1VGbTlDd1l5eUE0TnZ6Q1VPSXBkOHFz?=
 =?utf-8?B?bGg3VzZtYUJ6djdWaEs2UkZ3TER1UnBmRzNlNGtRS2hFbC9lb2VFWWVROXk0?=
 =?utf-8?B?RVErZHNwdnRUVzRoZm5DaXpBMC9ZdVNYZUNFeCtVV291L0FGN1RycTVsR2t5?=
 =?utf-8?B?MFIyYjBmQjhlS2VyTm1ZQ0FGTnQyZVdzS2t3a2Z5ZGlsY2tNOXhSL2ZoK25u?=
 =?utf-8?B?UHBpdWkvaWxnLzlTNVFvb2l2V2FDTlhPRTVmYXN4QmxFV3RrbmhGYVVlMTdo?=
 =?utf-8?B?VnFUbjRTdDZXdDFsRWJ4aEErdFowWUNBWjRHdThibFZ4WUMwakRadjlUS2cz?=
 =?utf-8?B?Z2toalVNeEIrMUYvVHZBUGN4bUZHdVFTUlh4YWwzajVveHhPNDVLeXJKQVI4?=
 =?utf-8?B?ZlBONGpoMktDclcyTkpONmQvK0pqZU5rS2pQOUE3a05VanV6N0FkT1ZLdG00?=
 =?utf-8?B?VS9lWGdwUjB3Z3poRmpEUUR0Tm9RUys0eFNadjA2UE40aS8vMmtNaGNQNkdF?=
 =?utf-8?B?R0pWNkxYWTNSU1FaajRkbExhV2dRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1FEDCA5C163D24DA71D95D945D63AEA@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5db0e87-3f75-452f-5a15-08dd6676372d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 23:40:07.4014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YDpFVcDZtTdXGvrDRfJUvrnxjyEMeOF5KEYhjJcngljtpvVdgwu84wXs1t+/02PlCtsMwKOXD7+fdPT47u8AnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3710

T24gVHVlLCAyMDI1LTAzLTE4IGF0IDIzOjM3ICswMTAwLCBMaW9uZWwgQ29ucyB3cm90ZToNCj4g
T24gVHVlLCAxOCBNYXIgMjAyNSBhdCAyMjoxNywgVHJvbmQgTXlrbGVidXN0DQo+IDx0cm9uZG15
QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVHVlLCAyMDI1LTAzLTE4IGF0
IDE0OjAzIC0wNzAwLCBSaWNrIE1hY2tsZW0gd3JvdGU6DQo+ID4gPiANCj4gPiA+IFRoZSBwcm9i
bGVtIEkgc2VlIGlzIHRoYXQgV1JJVEVfU0FNRSBpc24ndCBkZWZpbmVkIGluIGEgd2F5IHdoZXJl
DQo+ID4gPiB0aGUNCj4gPiA+IE5GU3Y0IHNlcnZlciBjYW4gb25seSBpbXBsZW1lbnQgemVybydu
ZyBhbmQgZmFpbCB0aGUgcmVzdC4NCj4gPiA+IEFzIHN1Y2guIEkgYW0gdGhpbmtpbmcgdGhhdCBh
IG5ldyBvcGVyYXRpb24gZm9yIE5GU3Y0LjIgdGhhdCBkb2VzDQo+ID4gPiB3cml0aW5nDQo+ID4g
PiBvZiB6ZXJvcyBtaWdodCBiZSBwcmVmZXJhYmxlIHRvIHRyeWluZyB0byAobWlzKXVzZSBXUk9U
RV9TQU1FLg0KPiA+IA0KPiA+IFdoeSB3b3VsZG4ndCB5b3UganVzdCBpbXBsZW1lbnQgREVBTExP
Q0FURT8NCj4gPiANCj4gDQo+IE9oIG15IGdvZC4NCj4gDQo+IE5GU3Y0LjIgREVBTExPQ0FURSBj
cmVhdGVzIGEgaG9sZSBpbiBhIHNwYXJzZSBmaWxlLCBhbmQgZG9lcyBOT1QNCj4gd3JpdGUgemVy
b3MuDQo+IA0KPiAiaG9sZXMiIGluIHNwYXJzZSBmaWxlcyAoYXMgY3JlYXRlZCBieSBORlNWNC4y
IERFQUxMT0NBVEUpIHJlcHJlc2VudA0KPiBhcmVhcyBvZiAibm8gZGF0YSBoZXJlIi4gRm9yIGJh
Y2t3YXJkcyBjb21wYXRpYmlsaXR5IHRoZXNlIGhvbGVzIGRvDQo+IG5vdCBwcm9kdWNlIHJlYWQg
ZXJyb3JzLCB0aGV5IGp1c3QgcmVhZCBhcyAweDAwIGJ5dGVzLiBCdXQgdGhleQ0KPiByZXByZXNl
bnQgcmFuZ2VzIHdoZXJlIGp1c3Qgbm8gZGF0YSBhcmUgc3RvcmVkLg0KPiBWYWxpZCBkYXRhIChm
cm9tIGFsbG9jYXRlZCBkYXRhIHJhbmdlcykgY2FuIGJlIDB4MDAsIGJ1dCB0aGVyZSBhcmUNCj4g
Tk9UDQo+IGhvbGVzLCB0aGV5IHJlcHJlc2VudCBWQUxJRCBEQVRBLg0KPiANCj4gVGhpcyBpcyBh
biBpbXBvcnRhbnQgZGlmZmVyZW5jZSENCj4gRm9yIGV4YW1wbGUgaWYgd2UgaGF2ZSBmaWxlcywg
b25lIHBlciB3ZWVrLCA3MDBUQiBmaWxlIHNpemUgKDEwMFRCDQo+IHBlcg0KPiBkYXkpLiBFYWNo
IG9mIHRob3NlIGZpbGVzIHN0YXJ0IGFzIGEgY29tcGxldGVseSB1bmFsbG9jYXRlZCBzcGFjZQ0K
PiAob25lDQo+IGJpZyBob2xlKS4gVGhlIGRhdGEgcmFuZ2VzIGFyZSBncmFkdWFsbHkgYWxsb2Nh
dGVkIGJ5IHdyaXRlcywgYW5kIHRoZQ0KPiBwb3NpdGlvbiBvZiB0aGUgd3JpdGVzIGluIHRoZSBm
aWxlcyByZXByZXNlbnQgdGhlIHRpbWUgd2hlbiB0aGV5IHdlcmUNCj4gY29sbGVjdGVkLiBJZiBu
byBkYXRhIHdlcmUgY29sbGVjdGVkIGR1cmluZyB0aGF0IHRpbWUgdGhhdCBzcGFjZQ0KPiByZW1h
aW5zIHVuYWxsb2NhdGVkIChob2xlKSwgc28gd2UgY2FuIHNlZSB3aGV0aGVyIHNvbWVvbmUgY29s
bGVjdGVkDQo+IGRhdGEgaW4gdGhhdCB0aW1lZnJhbWUuDQo+IA0KPiBEbyB5b3UgdW5kZXJzdGFu
ZCB0aGUgZGlmZmVyZW5jZT8NCj4gDQoNClllcy4gSSBkbyB1bmRlcnN0YW5kIHRoZSBkaWZmZXJl
bmNlLCBidXQgaW4gdGhpcyBjYXNlIHlvdSdyZSBsaXRlcmFsbHkNCmp1c3QgdGFsa2luZyBhYm91
dCBhY2NvdW50aW5nLiBUaGUgc3BhcnNlIGZpbGUgY3JlYXRlZCBieSBERUFMTE9DQVRFDQpkb2Vz
IG5vdCBuZWVkIHRvIGFsbG9jYXRlIHRoZSBibG9ja3MgKGV4Y2VwdCBwb3NzaWJseSBhdCB0aGUg
ZWRnZXMpLiBJZg0KeW91IG5lZWQgdG8gZW5zdXJlIHRoYXQgdGhvc2UgZW1wdHkgYmxvY2tzIGFy
ZSBhbGxvY2F0ZWQgYW5kIGFjY291bnRlZA0KZm9yLCB0aGVuIGEgZm9sbG93IHVwIGNhbGwgdG8g
QUxMT0NBVEUgd2lsbCBkbyB0aGF0IGZvciB5b3UuDQoNCiQgdG91Y2ggZm9vDQokIHN0YXQgZm9v
DQogIEZpbGU6IGZvbw0KICBTaXplOiAwICAgICAgICAgCUJsb2NrczogMCAgICAgICAgICBJTyBC
bG9jazogNDA5NiAgIHJlZ3VsYXIgZW1wdHkgZmlsZQ0KRGV2aWNlOiA4LDE3CUlub2RlOiA0MTA5
MjQxMjUgICBMaW5rczogMQ0KQWNjZXNzOiAoMDY0NC8tcnctci0tci0tKSAgVWlkOiAoMC8gcm9v
dCkgICBHaWQ6ICgwLyByb290KQ0KQ29udGV4dDogdW5jb25maW5lZF91Om9iamVjdF9yOnVzZXJf
aG9tZV90OnMwDQpBY2Nlc3M6IDIwMjUtMDMtMTggMTk6MjY6MjQuMTEzMTgxMzQxIC0wNDAwDQpN
b2RpZnk6IDIwMjUtMDMtMTggMTk6MjY6MjQuMTEzMTgxMzQxIC0wNDAwDQpDaGFuZ2U6IDIwMjUt
MDMtMTggMTk6MjY6MjQuMTEzMTgxMzQxIC0wNDAwDQogQmlydGg6IDIwMjUtMDMtMTggMTk6MjU6
MTIuOTg4MzQ0MjM1IC0wNDAwDQokIHRydW5jYXRlIC1zIDFHaUIgZm9vDQokIHN0YXQgZm9vDQog
IEZpbGU6IGZvbw0KICBTaXplOiAxMDczNzQxODI0CUJsb2NrczogMCAgICAgICAgICBJTyBCbG9j
azogNDA5NiAgIHJlZ3VsYXIgZmlsZQ0KRGV2aWNlOiA4LDE3CUlub2RlOiA0MTA5MjQxMjUgICBM
aW5rczogMQ0KQWNjZXNzOiAoMDY0NC8tcnctci0tci0tKSAgVWlkOiAoMC8gcm9vdCkgICBHaWQ6
ICgwLyByb290KQ0KQ29udGV4dDogdW5jb25maW5lZF91Om9iamVjdF9yOnVzZXJfaG9tZV90OnMw
DQpBY2Nlc3M6IDIwMjUtMDMtMTggMTk6MjY6MjQuMTEzMTgxMzQxIC0wNDAwDQpNb2RpZnk6IDIw
MjUtMDMtMTggMTk6Mjc6MzUuMTYxNjk0MzAxIC0wNDAwDQpDaGFuZ2U6IDIwMjUtMDMtMTggMTk6
Mjc6MzUuMTYxNjk0MzAxIC0wNDAwDQogQmlydGg6IDIwMjUtMDMtMTggMTk6MjU6MTIuOTg4MzQ0
MjM1IC0wNDAwDQokIGZhbGxvY2F0ZSAteiAtbCAxR2lCIGZvbyANCiQgc3RhdCBmb28NCiAgRmls
ZTogZm9vDQogIFNpemU6IDEwNzM3NDE4MjQJQmxvY2tzOiAyMDk3MTUyICAgIElPIEJsb2NrOiA0
MDk2ICAgcmVndWxhciBmaWxlDQpEZXZpY2U6IDgsMTcJSW5vZGU6IDQxMDkyNDEyNSAgIExpbmtz
OiAxDQpBY2Nlc3M6ICgwNjQ0Ly1ydy1yLS1yLS0pICBVaWQ6ICgwLyByb290KSAgIEdpZDogKDAv
IHJvb3QpDQpDb250ZXh0OiB1bmNvbmZpbmVkX3U6b2JqZWN0X3I6dXNlcl9ob21lX3Q6czANCkFj
Y2VzczogMjAyNS0wMy0xOCAxOToyNjoyNC4xMTMxODEzNDEgLTA0MDANCk1vZGlmeTogMjAyNS0w
My0xOCAxOToyNzo1NC40NjI4MTczNTYgLTA0MDANCkNoYW5nZTogMjAyNS0wMy0xOCAxOToyNzo1
NC40NjI4MTczNTYgLTA0MDANCiBCaXJ0aDogMjAyNS0wMy0xOCAxOToyNToxMi45ODgzNDQyMzUg
LTA0MDANCg0KDQpZZXMsIEkgYWxzbyByZWFsaXNlIHRoYXQgbm9uZSBvZiB0aGUgYWJvdmUgb3Bl
cmF0aW9ucyBhY3R1YWxseSByZXN1bHRlZA0KaW4gYmxvY2tzIGJlaW5nIHBoeXNpY2FsbHkgZmls
bGVkIHdpdGggZGF0YSwgYnV0IGFsbCBtb2Rlcm4gZmxhc2ggYmFzZWQNCmRyaXZlcyB0ZW5kIHRv
IGhhdmUgYSBsb2cgc3RydWN0dXJlZCBGVEwuIFNvIHdoaWxlIG92ZXJ3cml0aW5nIGRhdGEgaW4N
CnRoZSBIREQgZXJhIG1lYW50IHRoYXQgeW91IHdvdWxkIHVzdWFsbHkgKHVubGVzcyB5b3UgaGFk
IGEgbG9nIGJhc2VkDQpmaWxlc3lzdGVtKSBvdmVyd3JpdGUgdGhlIHNhbWUgcGh5c2ljYWwgc3Bh
Y2Ugd2l0aCBkYXRhLCB0b2RheSdzIGRyaXZlcw0KYXJlIGZyZWUgdG8gc2hpZnQgdGhlIHJld3Jp
dHRlbiBibG9jayB0byBhbnkgbmV3IHBoeXNpY2FsIGxvY2F0aW9uIGluDQpvcmRlciB0byBlbnN1
cmUgZXZlbiB3ZWFyIGxldmVsbGluZyBvZiB0aGUgU1NELg0KDQpJT1c6IHRoZXJlIGlzIG5vIHJl
YWwgYWR2YW50YWdlIHRvIHBoeXNpY2FsbHkgd3JpdGluZyBvdXQgdGhlIGRhdGENCnVubGVzcyB5
b3UgaGF2ZSBhIHBlY3VsaWFyIGludGVyZXN0IGluIHdhc3RpbmcgdGltZS4NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

