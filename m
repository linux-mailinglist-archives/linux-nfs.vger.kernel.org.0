Return-Path: <linux-nfs+bounces-1993-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2498584FB
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 19:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F041F228A1
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 18:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C4D130E5E;
	Fri, 16 Feb 2024 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="COshch3B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2122.outbound.protection.outlook.com [40.107.96.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6038A12F377
	for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107496; cv=fail; b=JyxNTML8kO+iXCjzd9VdITiLOlnUFmNNBgs1XlL4AsxFEJkzgUJDqnDcxyapHASSl5oCBYANqINiVAt/5zkxjczjmRHvAUC+ojENkAhi9LGc2+TGZ2ETACvEEjvdm3in/idWSITAR1ZTKPNHKfXRdLKjY5HvITtmYvD04i+1YWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107496; c=relaxed/simple;
	bh=jCsfqkL4nJeXOlKcsE2kGkPN/qHtHJ6lR12Qnt2iXPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pa55j5nov05V0SiBrCO7/6FxK2lrQfG+xaJIqTUZpBGS7IDQt7rq0pgfvLuNYS59mscV9n2MHURIXhjeAVKmRNstG+zyV6hM3xZVtOMX36JhRTVaIvbBGUKjX4/+/eOq1fktEnpqQfgTWUpfE02GIjR/fvBTiWndqtAsZEZWsZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=COshch3B; arc=fail smtp.client-ip=40.107.96.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5xW6w+LfKpfe0mxPg3/zccTmoExb6me+5wlbs+6w+5tsBN+jEooda9C4ApMYT9Fv1b70PRafUZsBPlpEiPrrt8mkWFG7E0Q1dPc3SefMSdTRyX33GUg7pq82NFWIxzCThdhz5YAjX9l1F4q85j1qxncUuRbAMxNuVe1rkNAMpzi7Ze1GJc4xhK1eCtXaH88XCu5LKzLL7/XbUfpUMr9syN9/vbJOR9Pb8TDouJFOom9MANqKz6cYK4Fa8B+UXX7U67t5vUWJ2PiEj9g1+/BopjtozWUaSxQDMwFJtuV4OprIrU46FYks9/r3l1UZUyanDqCJFqB7Z46Hb/o/NGQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCsfqkL4nJeXOlKcsE2kGkPN/qHtHJ6lR12Qnt2iXPM=;
 b=ax4IvDjEqKOVRJVhjFwefUIWYhbRKJKJ4mQB3pX5l/5+OmY8Qsp6AXAevi/1yoqZT0aQirNtQ99LJdWQJhZVRc6lqbpkUMz28Mxz+mINKsJFMakO8eRP6KDZCLKe5hsEOf4MuFu+MM7QmD6hkI0nfuVVnAhdLzZlPKqDyX7UO0MVvuFfyWBN4xkxCtiIV7Qq0Q28IQa4/Azh/gdHMj0iKRadX0NQOxMERjRwiDVUf3VFYRp/WIMGTluxD2qSW0pk4QbksP+UsWU0vbimoSUWpSwjUANk9NCGqaiDqXcnnX8M4lDD/8UyEePVvE2O5PFZJqwXc9E4o9ZRyfV67cMPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCsfqkL4nJeXOlKcsE2kGkPN/qHtHJ6lR12Qnt2iXPM=;
 b=COshch3ByeOziU+kq28M507joPLhK+x6+fHg+ZCUc5qKoj3CJ4/nGdx/aN1rSZHMeHNo8tZEQYGvd33Ir2IG1v8t+oPzwSJGaWVmiFbBcA2MlCRalPTIFWbSBfc9qFAFWi0W7uJKKs/uINOxs+hcl7tpMKNvO3CDWawXQb3tPf4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3954.namprd13.prod.outlook.com (2603:10b6:5:2a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 18:18:11 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 18:18:10 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Thread-Topic: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Thread-Index: AQHaYHfUW0xTMio2ik6dSCtFnyTgcbEM+KOAgABPaQA=
Date: Fri, 16 Feb 2024 18:18:10 +0000
Message-ID: <ac1166ca466c343f18df45094c0130947bd21f5c.camel@hammerspace.com>
References: <20240216012451.22725-1-trondmy@kernel.org>
	 <20240216012451.22725-2-trondmy@kernel.org>
	 <Zc9kQ1Autf6xdcii@tissot.1015granger.net>
In-Reply-To: <Zc9kQ1Autf6xdcii@tissot.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB3954:EE_
x-ms-office365-filtering-correlation-id: 1900f996-429f-4e2f-b3ad-08dc2f1ba1e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xFeHHTnCdOz0L3/bekR6QBmRjtBs8b+hH2Vm72iFj61k7LW3MSuO1eRDxIXRj67pTAMFOqRGrmzmHvWxdBkQBxQ9Y1zSBY5bDM4P32/t/brbIHwnOhhaXW8I0nlECX1M1aModA3r2cHNsip/6bE3tlixMBOljfEmi+N153X7qD7EHnCnBsgM6zBc0SgPlYk3+jZCyk3yToMQuVb9JrRjc62vHzcT05lCQAeD9cNukHJricSbYGt6xzKBn8apo7gEO3STSmTmxEcXsTTpvBAn7sLnlu04FRuWkJTBYzz2uo30SwqJO9RLKaLOg4E3okmb/3gH5eWzq1ZpcUpcjlVK23+5Aq7mfPnEdMy7Hvp2vrVZvyQ5SpNsoGg4nqAdgwbDbIqfYbwUGcKvopVbCtAboVJNYUV80VLg99vnA7GHxIiHbMyPszp79FGsG4dIenMa07+fov9Z77RTUbbid7VG4Nwsvjvi9H27nAbsLN1orB1xbKbT6XePY3AbFSuGREnS+Qpb9dHaCdOyF/I2WX9EyBlSHUi6zzAGHI0qwfCq8gYX7e7Y8tIyBftOUMBfstgwghIOUrUnDUBUzI2YtXrrXJxFMYX5tySBJqOuV+5pthjFF7ey+Nh1tIlKS9/A3XTb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39840400004)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(64756008)(8676002)(86362001)(38100700002)(122000001)(36756003)(38070700009)(83380400001)(2616005)(66476007)(66556008)(5660300002)(4326008)(8936002)(66446008)(6916009)(66946007)(76116006)(478600001)(2906002)(316002)(6512007)(6486002)(71200400001)(6506007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXJJbWNtKzRNSDVmT3VQOUI5d29yUmlMemFkN1d1ZUJHSTh4dkMvNGMvaW5Z?=
 =?utf-8?B?cC92cmJTOTY0RmN5WW16eVc0Q1h5aUo1eGdJbUJ2cFpYb0FoT1RGbmFtSW9z?=
 =?utf-8?B?Q3REd3BrQTZKR0VwRWRCQ1pTMEJWbHdnQUVkaHFXSWV5Yy93cGxQd0lTT3Zr?=
 =?utf-8?B?bmZVMFJVVG5qQ3VoWUpoWGF5VU90TFFWZnplQ3IyMDlXTnhBdTBsdVRWVnNL?=
 =?utf-8?B?WVY1a2VRVzdTTW9DWUdpaDFweWF3RVR0UjdUWStZeDhrUGVPTFJBMTg3WXpN?=
 =?utf-8?B?SzFEaHdSQlNaTnFwckhDaUpDTnZxakpkaSt3NjR1eFZHNU5vL0VrLzRNY0ZP?=
 =?utf-8?B?MlgrVEE1djI2eWxPVzFrTEJva2R6ZUpCQVpWWDlmTWdKU01sTWFOQSthT25Y?=
 =?utf-8?B?Uk1ya1NQNmErazQrQ2xjL202SmNKN1MwZ05kdUJaRkJodWs3SjRmOHk4ZjRT?=
 =?utf-8?B?aFRuVlNVZnVHTnpITGlrSzA5dldQTVdlZjdKSFlwN0dsNmQ4WFI3ajcvM0pM?=
 =?utf-8?B?RFNaMjd4dEJUaGNSTklKbkxaUkxTNzU4Y2dOdGREZ2NiQVpGTlpaR2xSOG1s?=
 =?utf-8?B?UG1xaDhCeGEwMjFLV21tK0dwNUtnKzVQWlNPNFBic0NFUi9RLzFWWFdxR2NG?=
 =?utf-8?B?c1JXT1U1RmZOZW1qY2NoRkVEeG9Vc2tIeHdRVU9vVHZINEd4WGRnUGxQbC94?=
 =?utf-8?B?U3RvVnBrVVJpYVZFUm1CQUhZWFdudkt5MnRFVVVyZjJkcUVzRjlFVHMrV3gw?=
 =?utf-8?B?QTF1czErNTV0VnZyNjlFeHBScU1zM1ZBUlQyZ2czWkpjQVp6alJuaG9jd05S?=
 =?utf-8?B?Q2JKNnFURXFHM0ZIbjR1ZHJWTlBqaHlYYlRHZThldDJmWWU3N2haRjNUYXFm?=
 =?utf-8?B?UW5rNzJaUXRIY01Cd28vZzdFVDFsV3dISFB4TmRucUViRy95a3YxbjJQY3Ur?=
 =?utf-8?B?Y04zVVlqTnVNNUJvdVJUbmU1VXhUaVBMclZwaHhZVGVENTJUMFloUnd2SVFX?=
 =?utf-8?B?ZTQzZEJhWkh1TmxyU0FERUU0WTlLUlQxQS9EVTV3aEtoVGlWODBzajdlSEsv?=
 =?utf-8?B?eDJLUjFGZGo1bnpVdE9QOGwxcXliM1p2TGlqSUU5alVLTzVlWjFXQ3dvdE1i?=
 =?utf-8?B?YndZamtnbmFXZGdabEl6TEpTUlN1YXU2bnhaczBLbEEvV2d3enZNRWRyRFRE?=
 =?utf-8?B?Rkpwb2U4dUdtVTNaL0ZuckdSTlVYa3BmSnBadThxR2xnYjZ1Qm1qNFhUZzEy?=
 =?utf-8?B?NWZsWW1TZHhTOVZGRFVBSzdIV012bHRXWDRyRFhOdnBJNUFwV3hCbXA1S0J0?=
 =?utf-8?B?cHZkNlp2MzdVV0hNREJDUmIzYi9hWDN1cGtib3R4MU9KSStJOTNZVmJKV204?=
 =?utf-8?B?NHJFTWNZSGprbU9MQTBmOEZKN2xHS3pMYWI1K29wcExjbkZJdWFKUE9rNHRq?=
 =?utf-8?B?emtXV0lQT1dsNSs0cjdRVStqUlVKSjI3YnpoVWNtSE1xOS9jeW10U3NpZkgz?=
 =?utf-8?B?NVZiTjVpTkJuNFNzL1dVenJGMCtRbzlNT3ovU3R2cmpxWi85bEFCVDNBalkv?=
 =?utf-8?B?NG5WTlBrYXo2Q2tWeUcrVVQzZFByM1NtdDUrZmJtZHVRbXA0L2hpZU5BMmZz?=
 =?utf-8?B?RnFiL0tnUW5TZnVPNVd6ZFJTVlVEMTNyNjBWZVZ6Y01ROXBDb05oUHVyektY?=
 =?utf-8?B?dXhZUWFURmI5SEZ1M3ZvaE5PbjVOdTRtNGoyZWlFZzk0RWhSVGpmVnNudHZ5?=
 =?utf-8?B?UG9LRzNTQ211TnRObFRUbTdGcSsrelFxMzRiVzBUZGh3TUxSdUR4RW5rNGcw?=
 =?utf-8?B?SEZqQ0lyT2pUOWp4UGFZbEI3b2pqUE0zWlFhY3dUMytrZllJdnpBT2hKNGtr?=
 =?utf-8?B?Q3FwNHg3b015KzRlZ3czUUtzUS9HNCtqSHlIVDVoaFIrUHN1NCtqUVFFcytv?=
 =?utf-8?B?U0hxQkdCYWZvRXdtVE5KUmkxNU5DaW1wbCt1TE5zbjFpNW4zSjhvNzc4dGlO?=
 =?utf-8?B?Yk96citibTFNZTZvUmRDTmRsTXdIWFZTcDVsejlnQUsyYTBVSHZzQnVyb05I?=
 =?utf-8?B?UlI5NjY4b2NqMEk0V3hMR0dBdk9jVGx3NCtsZnREbjdBUzlLSzhHa2VrOTYw?=
 =?utf-8?B?N2NEQTh0T1Jrd2QxdXFjTDhuYmlaajN2TGV1b0xLcVhBTXU3Z2p4UXJaNmZv?=
 =?utf-8?B?TWhETklvTmpHSE1Ed0JPbmJtcjcyQUtpdFdUaXNGV0gvM1R3M0JhTWJNU0sw?=
 =?utf-8?B?NHlDSlNPNG5keTMwbWtyRFoxbjJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D37C9EFD2C1934FA3D96E52E0563931@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1900f996-429f-4e2f-b3ad-08dc2f1ba1e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 18:18:10.6021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: io9fCLDrQG71r2sngDroo5fMMRB7hk2A5erhbqEw7Ugb7NOHZA2ZP9IFtg6Wr3mbYs7jnzPHIWEhgj5GQc/DIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3954

T24gRnJpLCAyMDI0LTAyLTE2IGF0IDA4OjMzIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gVGh1LCBGZWIgMTUsIDIwMjQgYXQgMDg6MjQ6NTBQTSAtMDUwMCwgdHJvbmRteUBrZXJuZWwu
b3JnwqB3cm90ZToNCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4gQ29tbWl0IGJiNGQ1M2Q2NmU0YiBicm9rZSB0aGUg
TkZTdjMgcHJlL3Bvc3Qgb3AgYXR0cmlidXRlcw0KPiA+IGJlaGF2aW91cg0KPiA+IHdoZW4gZG9p
bmcgYSBTRVRBVFRSIHJwYyBjYWxsIGJ5IHN0cmlwcGluZyBvdXQgdGhlIGNhbGxzIHRvDQo+ID4g
ZmhfZmlsbF9wcmVfYXR0cnMoKSBhbmQgZmhfZmlsbF9wb3N0X2F0dHJzKCkuDQo+IA0KPiBDYW4g
eW91IGdpdmUgbW9yZSBkZXRhaWwgYWJvdXQgd2hhdCBicm9rZT8NCg0KV2l0aG91dCB0aGUgY2Fs
bHMgdG8gZmhfZmlsbF9wcmVfYXR0cnMoKSBhbmQgZmhfZmlsbF9wb3N0X2F0dHJzKCksIHdlDQpk
b24ndCBzdG9yZSBhbnkgcHJlL3Bvc3Qgb3AgYXR0cmlidXRlcyBhbmQgd2UgY2FuJ3QgcmV0dXJu
IGFueSBzdWNoDQphdHRyaWJ1dGVzIHRvIHRoZSBORlN2MyBjbGllbnQuDQoNCj4gDQo+IA0KPiA+
IEZpeGVzOiBiYjRkNTNkNjZlNGIgKCJORlNEOiB1c2UgKHVuKWxvY2tfaW5vZGUgaW5zdGVhZCBv
Zg0KPiA+IGZoXyh1bilsb2NrIGZvciBmaWxlIG9wZXJhdGlvbnMiKQ0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4g
PiAtLS0NCj4gPiDCoGZzL25mc2QvbmZzNHByb2MuYyB8IDQgKysrKw0KPiA+IMKgZnMvbmZzZC92
ZnMuY8KgwqDCoMKgwqAgfCA5ICsrKysrKystLQ0KPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9u
ZnNkL25mczRwcm9jLmMgYi9mcy9uZnNkL25mczRwcm9jLmMNCj4gPiBpbmRleCAxNDcxMmZhMDhm
NzYuLmU2ZDg2MjRlZmM4MyAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnNkL25mczRwcm9jLmMNCj4g
PiArKysgYi9mcy9uZnNkL25mczRwcm9jLmMNCj4gPiBAQCAtMTE0Myw2ICsxMTQzLDcgQEAgbmZz
ZDRfc2V0YXR0cihzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3QNCj4gPiBuZnNkNF9jb21w
b3VuZF9zdGF0ZSAqY3N0YXRlLA0KPiA+IMKgCX07DQo+ID4gwqAJc3RydWN0IGlub2RlICppbm9k
ZTsNCj4gPiDCoAlfX2JlMzIgc3RhdHVzID0gbmZzX29rOw0KPiA+ICsJYm9vbCBzYXZlX25vX3dj
YzsNCj4gPiDCoAlpbnQgZXJyOw0KPiA+IMKgDQo+ID4gwqAJaWYgKHNldGF0dHItPnNhX2lhdHRy
LmlhX3ZhbGlkICYgQVRUUl9TSVpFKSB7DQo+ID4gQEAgLTExNjgsOCArMTE2OSwxMSBAQCBuZnNk
NF9zZXRhdHRyKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdA0KPiA+IG5mc2Q0X2NvbXBv
dW5kX3N0YXRlICpjc3RhdGUsDQo+ID4gwqANCj4gPiDCoAlpZiAoc3RhdHVzKQ0KPiA+IMKgCQln
b3RvIG91dDsNCj4gPiArCXNhdmVfbm9fd2NjID0gY3N0YXRlLT5jdXJyZW50X2ZoLmZoX25vX3dj
YzsNCj4gPiArCWNzdGF0ZS0+Y3VycmVudF9maC5maF9ub193Y2MgPSB0cnVlOw0KPiA+IMKgCXN0
YXR1cyA9IG5mc2Rfc2V0YXR0cihycXN0cCwgJmNzdGF0ZS0+Y3VycmVudF9maCwgJmF0dHJzLA0K
PiA+IMKgCQkJCTAsICh0aW1lNjRfdCkwKTsNCj4gPiArCWNzdGF0ZS0+Y3VycmVudF9maC5maF9u
b193Y2MgPSBzYXZlX25vX3djYzsNCj4gPiDCoAlpZiAoIXN0YXR1cykNCj4gPiDCoAkJc3RhdHVz
ID0gbmZzZXJybm8oYXR0cnMubmFfbGFiZWxlcnIpOw0KPiA+IMKgCWlmICghc3RhdHVzKQ0KPiA+
IGRpZmYgLS1naXQgYS9mcy9uZnNkL3Zmcy5jIGIvZnMvbmZzZC92ZnMuYw0KPiA+IGluZGV4IDZl
N2UzNzE5MjQ2MS4uNThmYWI0NjFiYzAwIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mc2QvdmZzLmMN
Cj4gPiArKysgYi9mcy9uZnNkL3Zmcy5jDQo+ID4gQEAgLTQ5Nyw3ICs0OTcsNyBAQCBuZnNkX3Nl
dGF0dHIoc3RydWN0IHN2Y19ycXN0ICpycXN0cCwgc3RydWN0DQo+ID4gc3ZjX2ZoICpmaHAsDQo+
ID4gwqAJaW50CQlhY2Ntb2RlID0gTkZTRF9NQVlfU0FUVFI7DQo+ID4gwqAJdW1vZGVfdAkJZnR5
cGUgPSAwOw0KPiA+IMKgCV9fYmUzMgkJZXJyOw0KPiA+IC0JaW50CQlob3N0X2VycjsNCj4gPiAr
CWludAkJaG9zdF9lcnIgPSAwOw0KPiA+IMKgCWJvb2wJCWdldF93cml0ZV9jb3VudDsNCj4gPiDC
oAlib29sCQlzaXplX2NoYW5nZSA9IChpYXAtPmlhX3ZhbGlkICYgQVRUUl9TSVpFKTsNCj4gPiDC
oAlpbnQJCXJldHJpZXM7DQo+ID4gQEAgLTU1NSw2ICs1NTUsOSBAQCBuZnNkX3NldGF0dHIoc3Ry
dWN0IHN2Y19ycXN0ICpycXN0cCwgc3RydWN0DQo+ID4gc3ZjX2ZoICpmaHAsDQo+ID4gwqAJfQ0K
PiA+IMKgDQo+ID4gwqAJaW5vZGVfbG9jayhpbm9kZSk7DQo+ID4gKwllcnIgPSBmaF9maWxsX3By
ZV9hdHRycyhmaHApOw0KPiA+ICsJaWYgKGVycikNCj4gPiArCQlnb3RvIG91dF91bmxvY2s7DQo+
ID4gwqAJZm9yIChyZXRyaWVzID0gMTs7KSB7DQo+ID4gwqAJCXN0cnVjdCBpYXR0ciBhdHRyczsN
Cj4gPiDCoA0KPiA+IEBAIC01ODIsMTMgKzU4NSwxNSBAQCBuZnNkX3NldGF0dHIoc3RydWN0IHN2
Y19ycXN0ICpycXN0cCwgc3RydWN0DQo+ID4gc3ZjX2ZoICpmaHAsDQo+ID4gwqAJCWF0dHItPm5h
X2FjbGVyciA9IHNldF9wb3NpeF9hY2woJm5vcF9tbnRfaWRtYXAsDQo+ID4gwqAJCQkJCQlkZW50
cnksDQo+ID4gQUNMX1RZUEVfREVGQVVMVCwNCj4gPiDCoAkJCQkJCWF0dHItPm5hX2RwYWNsKTsN
Cj4gPiArCWZoX2ZpbGxfcG9zdF9hdHRycyhmaHApOw0KPiA+ICtvdXRfdW5sb2NrOg0KPiA+IMKg
CWlub2RlX3VubG9jayhpbm9kZSk7DQo+ID4gwqAJaWYgKHNpemVfY2hhbmdlKQ0KPiA+IMKgCQlw
dXRfd3JpdGVfYWNjZXNzKGlub2RlKTsNCj4gPiDCoG91dDoNCj4gPiDCoAlpZiAoIWhvc3RfZXJy
KQ0KPiA+IMKgCQlob3N0X2VyciA9IGNvbW1pdF9tZXRhZGF0YShmaHApOw0KPiA+IC0JcmV0dXJu
IG5mc2Vycm5vKGhvc3RfZXJyKTsNCj4gPiArCXJldHVybiBlcnIgIT0gMCA/IGVyciA6IG5mc2Vy
cm5vKGhvc3RfZXJyKTsNCj4gPiDCoH0NCj4gPiDCoA0KPiA+IMKgI2lmIGRlZmluZWQoQ09ORklH
X05GU0RfVjQpDQo+ID4gLS0gDQo+ID4gMi40My4xDQo+ID4gDQo+ID4gDQo+IA0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

