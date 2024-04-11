Return-Path: <linux-nfs+bounces-2768-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448C08A1F1D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 21:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF2E284460
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 19:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3EAD51D;
	Thu, 11 Apr 2024 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="WY8OiUYd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2114.outbound.protection.outlook.com [40.107.244.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A589205E18
	for <linux-nfs@vger.kernel.org>; Thu, 11 Apr 2024 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862499; cv=fail; b=HgGoQcX2BzJbp4t9cDBbP/9r8NYisB2cQ37wKHfkJ7+gcYd0/zTjxDxz9WG23KFbKy3nSLcvmaRjn1SNQJOFKAp21+14b04oiSBZNjmoB0BtDGukBpiks4Lr/7arxftY4mgX3f5rkM7qRAidysNmDXCm2PgctR4YxyvPmo5QEcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862499; c=relaxed/simple;
	bh=mcNK4Y+X6WXipDU85gFU44YZza7am6GrD4rnKcS59i4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UA//xiYHGiPjiUVb8+ZIc5qfsmrGyAPQp/KuBqLY+uYrF3qlutjlfKYsqKpIcnWiCj+JXrApoC7LYbiMteY0Hq11s/+hqk6X0Ptq0BfrL+2jjRKwOkv3uJRkZ0B5WypRWcdG0rmIrk/h45DQcVxAcXafTXYq/Wm3gpVVrYBHByE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=WY8OiUYd; arc=fail smtp.client-ip=40.107.244.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPnyeB7cREmLZ9SgF5xeNJniRn+zCUIMvIAcdeShZaxtQ2FzeNnm6NQLnogLBu41yzqQh0Ur6OLTRZxmNA8PyJHO3Ci1PFKImbdgn/cSxMxA6k5wEeZAJHq3h1IgbFIspJH8geanWbZo0elF0AjXH1EKXZI5N5RQucOuSYh7XPVn95SrvOG8BCLUAtUMqhA61d14AhhVLgEmCqKTueioI56WtlkCb9rd1htlyCGL2wuy1ABXV3wLqRB+XngX+E29oVwOD33UKvMOcSytgEIMrYNnHt+Qlq+0CFxiHh2iT9WH5ap7LlDbSHooXrqsAJqvTdmr+GTAXLztRr2h7OE+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcNK4Y+X6WXipDU85gFU44YZza7am6GrD4rnKcS59i4=;
 b=YqvPbi5fDgZbgHGllxQlPcU8SwTklGAEerjz0+VlfVD9BbTUTyW9w9IapPL87IMb0+48KxoLUEI7R5To/uwPZ5vbiQPl5DmJpCA49+lXdXsgvpm2Zw+V2mcvxyRZ6ZagNtkNUr4Pckz/8VkmNoId17KRqpgDDVqh7RafkrX7w7alXQ65ZNUNH/JRbrSq2j8BTvUoTUgiefQnXNg8qlV3HTsV9FazUqCqTrLkqJhBbDwfTQ4vpI8qBD9cAbTUiGmn0pTi2qLk4J6YjOuqn3q0hcm5CPHzImZ76+CqliRmNSetS3Ad6FEGyJhLh6FiQZ5zzv0iBzjNQMtM503U9S/hCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcNK4Y+X6WXipDU85gFU44YZza7am6GrD4rnKcS59i4=;
 b=WY8OiUYdan7aDzJlVxG8qv0o0FLpgM3zsvhphGPQay2vABq+/kZh3L49taIjBhmvX6j/YDVas8RCHo5chG0+afSHeV2ktxGjpr3oxTtqbScSbPfErGbPdSnUhHMkjCjLzsmfq1kzBZzWOpTETCNQGAAiDo/pdlJLRak5XkX7WzM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5548.namprd13.prod.outlook.com (2603:10b6:a03:421::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 19:08:14 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 19:08:13 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>, "bcodding@redhat.com"
	<bcodding@redhat.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: mount options not propagating to NFSACL and NSM RPC clients
Thread-Topic: mount options not propagating to NFSACL and NSM RPC clients
Thread-Index:
 AQHaD/+eMN0O5c+JBUeqSMfNRLqFBLBu4bwAgCKL7wCAAaX5AIDPdjcAgAGdpgCAABVNAIAAKmQA
Date: Thu, 11 Apr 2024 19:08:13 +0000
Message-ID: <8357f330100e840094b0193dc5e324e1d1b25a7e.camel@hammerspace.com>
References: <20231105154857.ryakhmgaptq3hb6b@gmail.com>
	 <80B8993C-645D-4748-93B3-88415E165B87@redhat.com>
	 <20231129132034.lz3hag5xy2oaojwq@gmail.com>
	 <8FDECCA5-80E0-4CB4-B790-4039102916F0@redhat.com>
	 <20240410143944.srhfeq6owfvdxcci@gmail.com>
	 <5D6491EA-53CF-488C-B1D6-A77A8CDFFDC8@redhat.com>
	 <20240411163628.jtnhu3pxgcskvel6@gmail.com>
In-Reply-To: <20240411163628.jtnhu3pxgcskvel6@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5548:EE_
x-ms-office365-filtering-correlation-id: 24cdedc4-8ec1-428a-2bc9-08dc5a5abca0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ffpTxkhVwJb21FxHZG7+MzK9Rmqty20JPazlqi2AcaFGqK/keERpZKe9LDYTBucahihyN5v9AvU/MhnnL0DS/VacK6Ufs5f1fPY88xoXnJl8Ya5YVG1Tyjf08Oudu/QvUYcmQez9QYvedWUBEVBz+T/x3VaQbB1tUbHXeOjR1opKnf6bw4XU9j9tricLX/Jz6LNFxWU44x4yWW6PH0MLQQqjn0QH2GI0E8hG6UJ+cPbzzHP9xaeGf8Y8JeeaRCzC4nvRrDU+TXTIfOHHzIx81UqxWAz7sfaiGOxejQRfXHGeyENoloPR9nZRxH9FeoAG9EA47v63zSaZtKofwVX3gKQi9KQQf8c4GzOvnm8ZEJB4u78TcPM3ydF9X1UTY5njjYocrcsaubvsWrK0+MZfr4mmifE47N9/uRyDr8n1vNOwbAo/oPOS58ORwzm2KaQ4gK3o+3i/YXevXFas2EOuLqBgQ6E/9tPrPX1pMIm6Gw6gszi7OUFrc0isrpA9SzB8o42KD8h690CpIpUVAQ3V3b21KlRkrdEh0wJxKZXC043IhxSzVYYt65eFwlKQdA7AZIJl7XL5B0uxfisJbciXa0KyL0+IvEXQXy1HoP/wTijwVopXAqorq63rsE+SjOd66Jtac+PfxAPMM8j3njC0cp4X9eMtCioKKRO5xMU2bDx21+OmY2NRUn7C6bbaP073eFJ+h2/C5zok5hHEo5qkjPWLEv1aJ1mNPd4pIfdbhRY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3ZYeGpWbnppWXUrRnJrQm1aNkcrNHFsMnI4eGxUUVR1RHBJODNRKzFEbXVT?=
 =?utf-8?B?STJna2pJRTJxN1o2MHJyZ1l2UkIrYnhldHdLSE1jSkQwOGVMYzZRWkRtK3Fj?=
 =?utf-8?B?aU9jNVdjQklqd0FHWHlBU2dtVmg5YlZBWHk1bE9JaG8rQm1uSkpFb2RMRzhX?=
 =?utf-8?B?TUQvTmxZZUFoUm9jV1FrcnowMi9xb2xuSzh3eUdHSGJESTdOMXdKVm5sL2xy?=
 =?utf-8?B?OFd4MUI2WnpodE9TYjlTU2NQUlM2WnNOb2IwRTN0aFN1WWJNVHpITklZYklN?=
 =?utf-8?B?bWRHNlU1MzhUazdsSXZEVVl4cTZWVXpBZDR2c252Rkx3dE56VWpLeEx1cysv?=
 =?utf-8?B?dERNMzJ1aG1Vd0MwcGk2d1EvNmdaWitTZHN3OStwNXlzOW51cXB1eCtJdkhF?=
 =?utf-8?B?dDNXa0ZaVXNXVnBrRXlmTzJCUlpmSGpFQmt5WDB5NXFTaUs3TDd2QmpUQlg3?=
 =?utf-8?B?ZTZhc1FkTm5nRnhDME9VVGZmRStqZ0l1QXBjT0g5czFKQXowQ0tlYkFlN3lZ?=
 =?utf-8?B?UEhlNWYvMTNtbElyVUs4bUlybzJqTmJ5bkwyaTlqOU9nR3J5ZVhBcjh5dnZI?=
 =?utf-8?B?dzd4T0RHdngzaG9Nc0xhZnhaUTNEQnJmOE9tS0x6Q3lONUc1aXRSaHdEUjF3?=
 =?utf-8?B?ckFpcDhVL3RDYmNTR01taG1yY3kzNytva2JOREliSW9jYnk3eVBaVEYyTktq?=
 =?utf-8?B?UFdZWnQ5SDZPUEdwcGhjcDF6SVlNZVZtUDlSS2RHVDBkYUNyZmFOMDBCRkpi?=
 =?utf-8?B?TjkxODFLckZxemI5ZGxqalcwckNDTDhMWWY4WEtmdVFTZU9peUcxZ2hXSWNB?=
 =?utf-8?B?VGx2akozcUdQc0ZPTStDYWFrMS9TUGl0ajJZVFVqSTRydlh0ZTRtYURDUi9D?=
 =?utf-8?B?c1JYbnBxUWIwRW95ZE5MblMvL1Y2VlJBS1lMdnhiVXo3a3Q1SG9yVjFUUG12?=
 =?utf-8?B?bjBOWmczR2x5REhxVEh1RHIvUVM0R1FqNEZZMUlLNkRGYjNZREgyUnM1V0FU?=
 =?utf-8?B?SEd2U2pFMmVJSDErb3VVK3hhVmRwaldwRTM3TlZBRXNVUUR0dEN5T05xNEJY?=
 =?utf-8?B?TmluK1VKYVFYbzRHNnRBdFY1bXVZRitHZSsrNlQ0MnlhalJLd3N5RFhtZENa?=
 =?utf-8?B?eUxJWXhyRVcvaWU0Sjl1ckZZd0tIdm1HalJ2eG5RLzJvTmx1UW1PV21jdHNi?=
 =?utf-8?B?Q3ROSDN3UTgwaEpTdDk3dmZZUjJXdVRwUHhnd0NUZVhqanJudkFzVE83TkJR?=
 =?utf-8?B?VUY3ZUd3SHc2VEhpM0lrMVZqTVFGbUU5OEJ3TzFDYS9KcE44R09IZThyR2No?=
 =?utf-8?B?QXFPOHI5ckt5MUdPUnlYNThMa1FwSlVRWmJub0hNdXBjR2lPRTFKS05sTEVM?=
 =?utf-8?B?N3FINmpOWloxMmxCL1RpVkpsZWJqUHMrdURSSXIzaGxwbnNDVlJSK2VNWUpq?=
 =?utf-8?B?OEVQeVVscHQzTG04RWtCU28rYlNqbytEdGFmYStUTmwrSzNRNHBxYUNsdGJ1?=
 =?utf-8?B?MHZUNktaOHZLTXpxWUdKcmF5dlE2TEc0SmNqVWtBWGJBR0RFc3VNRFhQMi9U?=
 =?utf-8?B?RTluUTZobVlDWDdNaWpUYTBRUnZqM1lIOUR2RGdtMW1EbDNoU1R6L2xFd1ZL?=
 =?utf-8?B?UldxT1Izd1UyZElWTnJ3dkl2aUh2bHZQMmZmaTJEdGVGMmJ5U21tRjlOOE8v?=
 =?utf-8?B?NmN0U0hONDcyVkxyMWVLKzkvTWp0NU5mMncxUVllK2ZHL0FoOWFPYlcyYVVr?=
 =?utf-8?B?RjdKTzNPUERkRWhENFEzQlo3QjVQcGtMWktVcDl0MUJiUXVDRUhDQkhhR3J1?=
 =?utf-8?B?TEJwZFNMeXVxRTdVbVJDYmxxRTR5WnI4M1BuamhUelZ0bmhRK2MwdnpabHRa?=
 =?utf-8?B?RTlMMlBBdUMwWTB2T1ZaSEtISlIxLzRlU1JYSnY0djBwZ0kyN1hQNHU2QkRD?=
 =?utf-8?B?M3ViT2dDYmZoTTd3ZEpCTnNlZ3JzZXNPUys0aHplaGZjR21wOXhjYkIrcEIy?=
 =?utf-8?B?RUNTa2NqUmpVTzV5Z1NnaXVxUVU4a0ZWSEUyc1JUUUsxandyUG80dnk5MGdQ?=
 =?utf-8?B?WDBER2FnUzlpUGlzVG5lM1U1MWlmd2ZNZVFwWGlvUGw0aW5YNEFONllnTjZq?=
 =?utf-8?B?VmhqTEJOeDdMMnNBejdSREZZa25Xc3h1RWN6QmhjcDh6RE1oZW1yeHlDSWdq?=
 =?utf-8?B?c2EwNEtiUGRPeWtwMExUZFFac2l0Y2lPQVB1aitWdFQwN0gzcC9UUFFwak9W?=
 =?utf-8?B?ekN0c25iUE9MbWJxMWttODlUQjlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD98962FF5BC904D970C42AEB81F083A@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cdedc4-8ec1-428a-2bc9-08dc5a5abca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 19:08:13.7377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gApIzIdFS4VSTIA2x6/GVOaipl030zhuq+Ap+vTlZD+kiO+zbGVLWuF51Yc0dlWGXQFB2VZCW9Tpjp0hANowhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5548

T24gVGh1LCAyMDI0LTA0LTExIGF0IDE5OjM2ICswMzAwLCBEYW4gQWxvbmkgd3JvdGU6DQo+IE9u
IDIwMjQtMDQtMTEgMTE6MjA6MTQsIEJlbmphbWluIENvZGRpbmd0b24gd3JvdGU6DQo+ID4gPiBT
byBsb29rcyBsaWtlIHRoZSByZXF1ZXN0IGlzIG5vdCBiZWluZyByZXRyYW5zbWl0dGVkLiBKdXN0
IHRvIGJlDQo+ID4gPiBzdXJlLA0KPiA+ID4gaWYgSSBjYXVzZSB0aGUgbmZzZCB0byBkcm9wIHRo
ZSByZWd1bGFyIE5GUzMgcHJvZyBJL09zIGxpa2UNCj4gPiA+IEFDQ0VTUyBhbmQNCj4gPiA+IExP
T0tVUCwgSSBvbmx5IGdldCB0aGUgZXhwZWN0ZWQgNSBzZWNvbmRzIGRlbGF5IGZvbGxvd2luZyBh
DQo+ID4gPiBzdWNjZXNzZnVsDQo+ID4gPiByZXRyeS4NCj4gPiA+IA0KPiA+ID4gU2VlbXMgd2Ug
b25seSBoYXZlIGFuIGlzc3VlIHdpdGggdGhlIE5GUzNBQ0wgcHJvZy4NCj4gPiANCj4gPiBJdCBs
b29rcyBsaWtlIHRoZSBjbGllbnRfYWNsIHByb2dyYW0gZ2V0cyBjcmVhdGVkIHdpdGgNCj4gPiBy
cGNfYmluZF9uZXdfcHJvZ3JhbSgpIHdoaWNoIGRvZXNuJ3Qgc2V0dXAgdGhlIHRpbWVvdXRzL3Jl
dHJ5DQo+ID4gc3RyYXRlZ3ksIGFuZA0KPiA+IHRoZXJlJ3Mgbm90aGluZyBhZnRlciB0aGUgc2V0
dXAgdG8gZG8gaXQgZWl0aGVyLg0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlIHByb2JsZW0gaGFzIGV4
aXN0ZWQgc2luY2UgMzMxNzAyMzM3ZjJiMi4uwqAgSSB0aGluayB0aGlzDQo+ID4gc2hvdWxkDQo+
ID4gZml4IGl0IHVwLCB3b3VsZCB5b3UgbGlrZSB0byB0ZXN0IGl0Pw0KPiANCj4gUGxlYXNlIGFs
bG93IG1lIHRvIHByb3Bvc2UgYSBkaWZmZXJlbnQgY2hhbmdlLCB3aGljaCBJIGFscmVhZHkNCj4g
dGVzdGVkLg0KPiANCj4gTG9va3MgdG8gbWUgdGhhdCB0aGUgMjAxMiBjaGFuZ2UgdGhhdCBJIG1l
bnRpb25lZCBiZWxvdyBpcyBhY3R1YWxseQ0KPiB3aGVuDQo+IHRoZSBwcm9ibGVtIHN0YXJ0ZWQg
aGFwcGVuaW5nLCB3aGVuIHRoZSBga21lbWR1cGAgY2FsbCB3YXMgcmVtb3ZlZCwNCj4gc28NCj4g
c2luY2UgdGhlbiB3ZSBhcmUgc2ltcGx5IGp1c3QgbWlzc2luZyBhIGZpZWxkIGNvcHksIGFuZCB3
ZSBhcmUgdGFraW5nDQo+IHRoZSB0aW1lb3V0IGZyb20gdHJhbnNwb3J0LWJhc2VkIGRlZmF1bHQg
dGltZW91dCBnbG9iYWxzIGluc3RlYWQuDQo+IA0KPiBBbHNvLCBJIGhhdmUgYSBodW5jaCB0aGF0
IHdlIG5lZWQgdG8gZG8gc29tZXRoaW5nIGRpZmZlcmVudCwgYmVjYXVzZQ0KPiBvZg0KPiB0aGUg
Zm9sbG93aW5nIGNvZGUgaW4gYHJwY19uZXdfY2xpZW50YDoNCj4gDQo+IMKgwqDCoCBjbG50LT5j
bF9ydHQgPSAmY2xudC0+Y2xfcnR0X2RlZmF1bHQ7DQo+IMKgwqDCoCBycGNfaW5pdF9ydHQoJmNs
bnQtPmNsX3J0dF9kZWZhdWx0LCBjbG50LT5jbF90aW1lb3V0LQ0KPiA+dG9faW5pdHZhbCk7DQo+
IA0KPiBPbmx5IHNldHRpbmcgYGNsbnQtPmNsX3RpbWVvdXRgIF9hZnRlcl8gY2xpZW50IGNsb25l
IGRvZXMgbm90IHNlZW0gdG8NCj4gYmUNCj4gcmlnaHQgaWYgdGhlcmUgYXJlIGBjbF9ydHRfZGVm
YXVsdGAgY2FsY3VsYXRpb25zIHRoYXQgZGVwZW5kIG9uIGl0Lg0KPiBTbw0KPiBtYXkgYXMgd2Vs
bCBuZWVkIHRvIGNhbGwgYHJwY19pbml0X3J0dGAgdG9vLg0KPiANCj4gLS0NCj4gDQo+IEZyb20g
NTU3MzdmODJhOWJiM2U0OTA4MzZkMTA0OTE5OTVjODA4MmViY2YxMSBNb24gU2VwIDE3IDAwOjAw
OjAwDQo+IDIwMDENCj4gRnJvbTogRGFuIEFsb25pIDxkYW4uYWxvbmlAdmFzdGRhdGEuY29tPg0K
PiBEYXRlOiBUaHUsIDExIEFwciAyMDI0IDE4OjMwOjU2ICswMzAwDQo+IFN1YmplY3Q6IFtQQVRD
SF0gc3VucnBjOiBmaXggTkZTQUNMIFJQQyByZXRyeSBvbiBzb2Z0IG1vdW50DQo+IA0KPiBJdCB1
c2VkIHRvIGJlIHF1aXRlIGF3aGlsZSBhZ28gc2luY2UgMWI2M2E3NTE4MGM2ICgnU1VOUlBDOiBS
ZWZhY3Rvcg0KPiBycGNfY2xvbmVfY2xpZW50KCknKSwgaW4gMjAxMiwgdGhhdCBgY2xfdGltZW91
dGAgd2FzIGNvcGllZCBpbiBzbw0KPiB0aGF0DQo+IGFsbCBtb3VudCBwYXJhbWV0ZXJzIHByb3Bh
Z2F0ZSB0byBORlNBQ0wgY2xpZW50cy4gSG93ZXZlciBzaW5jZSB0aGF0DQo+IGNoYW5nZSwgaWYg
bW91bnQgb3B0aW9ucyBhcyBmb2xsb3dzIGFyZSBnaXZlbjoNCj4gDQo+IMKgwqDCoCBzb2Z0LHRp
bWVvPTUwLHJldHJhbnM9MTYsdmVycz0zDQo+IA0KPiBUaGUgcmVzdWx0YW50IE5GU0FDTCBjbGll
bnQgcmVjZWl2ZXM6DQo+IA0KPiDCoMKgwqAgY2xfc29mdHJ0cnk6IDENCj4gwqDCoMKgIGNsX3Rp
bWVvdXQ6IHRvX2luaXR2YWw9NjAwMDAsIHRvX21heHZhbD02MDAwMCwgdG9faW5jcmVtZW50PTAs
DQo+IHRvX3JldHJpZXM9MiwgdG9fZXhwb25lbnRpYWw9MA0KPiANCj4gVGhlc2UgdmFsdWVzIGxl
YWQgdG8gTkZTQUNMIG9wZXJhdGlvbnMgbm90IGJlaW5nIHJldHJpZWQgdW5kZXIgdGhlDQo+IGNv
bmRpdGlvbiBvZiB0cmFuc2llbnQgbmV0d29yayBvdXRhZ2VzIHdpdGggc29mdCBtb3VudC4gSW5z
dGVhZCwNCj4gZ2V0YWNsDQo+IGNhbGwgZmFpbHMgYWZ0ZXIgNjAgc2Vjb25kcyB3aXRoIEVJTy4N
Cj4gDQo+IFRoZSBzaW1wbGUgZml4IGlzIHRvIGNvcHkgYGNsX3RpbWVvdXRgIGFuZCBtYWtlIHN1
cmUgYGNsX3J0dF9kZWZhdWx0YA0KPiBpcyBpbml0aWFsaXplZCBmcm9tIGl0Lg0KPiANCj4gQ2M6
IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiBDYzogQmVuamFtaW4gQ29k
ZGluZ3RvbiA8YmNvZGRpbmdAcmVkaGF0LmNvbT4NCj4gTGluazoNCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjMxMTA1MTU0ODU3LnJ5YWtobWdhcHRxM2hiNmJAZ21haWwuY29tL1Qv
DQo+IEZpeGVzOiAxYjYzYTc1MTgwYzYgKCdTVU5SUEM6IFJlZmFjdG9yIHJwY19jbG9uZV9jbGll
bnQoKScpDQo+IFNpZ25lZC1vZmYtYnk6IERhbiBBbG9uaSA8ZGFuLmFsb25pQHZhc3RkYXRhLmNv
bT4NCj4gLS0tDQo+IMKgbmV0L3N1bnJwYy9jbG50LmMgfCAzICsrKw0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL2NsbnQu
YyBiL25ldC9zdW5ycGMvY2xudC5jDQo+IGluZGV4IGNkYTA5MzVhNjhjOS4uNzVmYWYxZjA1YTE0
IDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL2NsbnQuYw0KPiArKysgYi9uZXQvc3VucnBjL2Ns
bnQuYw0KPiBAQCAtNjY5LDYgKzY2OSw5IEBAIHN0YXRpYyBzdHJ1Y3QgcnBjX2NsbnQgKl9fcnBj
X2Nsb25lX2NsaWVudChzdHJ1Y3QNCj4gcnBjX2NyZWF0ZV9hcmdzICphcmdzLA0KPiDCoAluZXct
PmNsX2NoYXR0eSA9IGNsbnQtPmNsX2NoYXR0eTsNCj4gwqAJbmV3LT5jbF9wcmluY2lwYWwgPSBj
bG50LT5jbF9wcmluY2lwYWw7DQo+IMKgCW5ldy0+Y2xfbWF4X2Nvbm5lY3QgPSBjbG50LT5jbF9t
YXhfY29ubmVjdDsNCj4gKwluZXctPmNsX3RpbWVvdXQgPSBjbG50LT5jbF90aW1lb3V0Ow0KPiAr
CXJwY19pbml0X3J0dCgmY2xudC0+Y2xfcnR0X2RlZmF1bHQsIGNsbnQtPmNsX3RpbWVvdXQtDQo+
ID50b19pbml0dmFsKTsNCj4gKw0KPiDCoAlyZXR1cm4gbmV3Ow0KPiANCg0KVGhhdCBlbmRzIHVw
IGNsb2JiZXJpbmcgYW55IHRpbWVvdXQgdmFsdWUgdGhhdCBnZXRzIHNldCBpbiB0aGUNCnJwY19j
cmVhdGVfYXJncywgYW5kIG9wZW4gY29kZXMgc29tZXRoaW5nIHRoYXQgaXPCoGFscmVhZHkgYmVp
bmcgZG9uZSBpbg0KdGhlIGNhbGwgdG8gcnBjX25ld19jbGllbnQoKS4NCg0KSU9XOiBJJ2QgbXVj
aCByYXRoZXIgc2VlIHVzIGRlZmF1bHQgdGhlIHZhbHVlIG9mIGFyZ3MtPnRpbWVvdXQgdG8gdGhh
dA0Kb2YgY2xudC0+Y2xfdGltZW91dC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20NCg0KDQo=

